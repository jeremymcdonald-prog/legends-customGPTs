#!/usr/bin/env ruby
# frozen_string_literal: true

require "digest"
require "fileutils"
require "json"
require "tmpdir"
require "yaml"
require_relative "generate_contact_snapshots"

module LegendsFactory
  REPO_ROOT = File.expand_path("..", __dir__)
  GENERATED_NOTICE = "<!-- GENERATED FILE — DO NOT EDIT. Regenerate from the Legends GPT Factory blueprint. -->"
  REQUIRED_BLUEPRINT_FIELDS = %w[gpt_id slug name version status purpose scope output_contract owner_type owner_profile_id audience mortgage_routing_enabled lead_capture_enabled public_or_internal compliance_level privacy_policy_required apply_now_behavior capabilities actions knowledge_folders platform].freeze

  module_function

  def load_yaml(path)
    data = YAML.safe_load(File.read(path), permitted_classes: [], permitted_symbols: [], aliases: false)
    raise "YAML root must be a mapping: #{path}" unless data.is_a?(Hash)

    data.transform_keys(&:to_s)
  end

  def load_json(path)
    JSON.parse(File.read(path))
  end

  def audience_key(label)
    label.downcase.tr(" ", "_")
  end

  def deep_merge(base, override)
    base.merge(override) do |_key, old_value, new_value|
      old_value.is_a?(Hash) && new_value.is_a?(Hash) ? deep_merge(old_value, new_value) : new_value
    end
  end

  def resolved_audience(label, core_dir)
    engine = load_yaml(File.join(core_dir, "audiences/audience_profiles.yaml"))
    selected = engine.fetch("audiences").fetch(audience_key(label)) { raise "Unsupported audience: #{label}" }
    deep_merge(engine.fetch("defaults"), selected)
  end

  def schema_enums(core_dir)
    schema = load_json(File.join(core_dir, "templates/manifest.schema.json"))
    schema.fetch("properties").transform_values { |property| property["enum"] }.compact
  end

  def validate_manifest_schema!(manifest, core_dir)
    schema = load_json(File.join(core_dir, "templates/manifest.schema.json"))
    missing = schema.fetch("required").reject { |field| manifest.key?(field) }
    raise "Manifest schema missing fields: #{missing.join(', ')}" unless missing.empty?

    schema.fetch("properties").each do |field, definition|
      next unless manifest.key?(field)
      value = manifest[field]
      allowed_types = Array(definition["type"])
      unless allowed_types.empty?
        valid_type = allowed_types.any? do |type|
          { "string" => String, "boolean" => [TrueClass, FalseClass], "null" => NilClass }.fetch(type).then do |klass|
            klass.is_a?(Array) ? klass.any? { |item| value.is_a?(item) } : value.is_a?(klass)
          end
        end
        raise "Manifest schema type mismatch: #{field}" unless valid_type
      end
      raise "Manifest schema enum mismatch: #{field}" if definition["enum"] && !definition["enum"].include?(value)
      raise "Manifest schema pattern mismatch: #{field}" if definition["pattern"] && value.is_a?(String) && !value.match?(Regexp.new(definition["pattern"]))
      raise "Manifest schema minimum length mismatch: #{field}" if definition["minLength"] && value.is_a?(String) && value.length < definition["minLength"]
    end
    true
  end

  def placeholder?(value)
    value.to_s.include?("REQUIRED_")
  end

  def validate_blueprint!(blueprint, profiles_dir:, core_dir:, allow_placeholders: false)
    missing = REQUIRED_BLUEPRINT_FIELDS.select { |field| !blueprint.key?(field) || blueprint[field].nil? }
    raise "Missing blueprint fields: #{missing.join(', ')}" unless missing.empty?
    raise "Invalid slug" unless blueprint.fetch("slug").match?(/\A[a-z0-9]+(?:-[a-z0-9]+)*\z/)
    raise "Invalid semantic version" unless blueprint.fetch("version").match?(/\A\d+\.\d+\.\d+\z/)
    validate_manifest_schema!(blueprint, core_dir)
    unless allow_placeholders
      placeholder_fields = blueprint.select { |_key, value| placeholder?(value) }.keys
      raise "Unresolved blueprint placeholders: #{placeholder_fields.join(', ')}" unless placeholder_fields.empty?
    end

    enums = schema_enums(core_dir)
    enums.each do |field, allowed|
      next unless blueprint.key?(field)
      raise "Unsupported #{field}: #{blueprint[field]}" unless allowed.include?(blueprint[field])
    end

    owner, lender = ContactSnapshots.resolve(
      profiles_dir: profiles_dir,
      owner_profile_id: blueprint.fetch("owner_profile_id"),
      assigned_lending_partner_profile_id: blueprint["assigned_lending_partner_profile_id"]
    )
    expected_profile_types = {
      "jeremy" => ["team_leader"],
      "loan_officer" => ["loan_officer"],
      "realtor" => ["realtor"],
      "team_shared" => %w[team_leader loan_officer]
    }
    raise "owner_type does not match owner profile" unless expected_profile_types.fetch(blueprint.fetch("owner_type")).include?(owner.fetch("profile_type"))

    identity = load_yaml(File.join(core_dir, "identity/identity_pack.yaml"))
    if blueprint["owner_type"] == "jeremy" && owner["profile_id"] != identity.fetch("default_mortgage_profile_id")
      raise "Jeremy ownership must use the default mortgage profile"
    end
    if blueprint["owner_type"] == "realtor"
      assigned = owner.fetch("assigned_lending_partner_profile_id")
      requested = blueprint["assigned_lending_partner_profile_id"]
      raise "Realtor blueprint assignment conflicts with profile" if requested && requested != assigned
      blueprint["assigned_lending_partner_profile_id"] = assigned
    end
    if blueprint["mortgage_routing_enabled"] && blueprint["owner_type"] == "team_shared" && blueprint["assigned_lending_partner_profile_id"].to_s.empty? && blueprint["approved_team_routing_endpoint"].to_s.empty?
      raise "Team-shared mortgage routing requires an assigned lender or approved endpoint"
    end
    if blueprint["apply_now_behavior"] == "show_assigned_lender_link" && blueprint["assigned_lending_partner_profile_id"].to_s.empty?
      raise "Assigned-lender Apply Now behavior requires an assigned lender"
    end
    if blueprint["apply_now_behavior"] == "show_owner_link" && owner["profile_type"] == "realtor"
      raise "A Realtor owner cannot supply a mortgage application link"
    end
    audience = resolved_audience(blueprint.fetch("audience"), core_dir)
    boundary_rules = {
      "Consumer" => "public",
      "Loan Officer" => "internal",
      "Internal Team" => "internal",
      "Vendor" => "internal",
      "Executive" => "internal"
    }
    expected_boundary = boundary_rules[blueprint.fetch("audience")]
    raise "Audience requires #{expected_boundary} boundary" if expected_boundary && blueprint["public_or_internal"] != expected_boundary
    if blueprint["lead_capture_enabled"]
      raise "Lead capture requires submitMortgageLead" unless blueprint.fetch("actions").include?("submitMortgageLead")
      raise "Audience does not allow mortgage lead capture" unless audience.fetch("allowed_actions").include?("submitMortgageLead")
      if blueprint["public_or_internal"] == "public" && blueprint["privacy_policy_required"] != true
        raise "Public lead capture requires a privacy policy"
      end
    end

    registry = load_yaml(File.join(core_dir, "shared_knowledge/knowledge_registry.yaml"))
    registered = registry.fetch("domains").keys
    unknown_knowledge = blueprint.fetch("knowledge_folders") - registered
    raise "Unregistered knowledge folders: #{unknown_knowledge.join(', ')}" unless unknown_knowledge.empty?

    exporters = load_yaml(File.join(REPO_ROOT, "exporters/platforms.yaml"))
    raise "Unsupported platform: #{blueprint['platform']}" unless exporters.fetch("platforms").key?(blueprint["platform"])
    [owner, lender]
  end

  def dependency_paths(blueprint, profiles_dir:, core_dir:)
    core_files = Dir[File.join(core_dir, "**/*")].select { |path| File.file?(path) && !File.symlink?(path) }
    profile_ids = [blueprint.fetch("owner_profile_id"), blueprint["assigned_lending_partner_profile_id"]].compact.reject(&:empty?).uniq
    profile_files = profile_ids.map { |id| File.join(profiles_dir, "#{id}.yaml") }
    (core_files + profile_files + [File.join(REPO_ROOT, "exporters/platforms.yaml")]).sort
  end

  def dependency_manifest(blueprint, blueprint_path:, profiles_dir:, core_dir:)
    paths = dependency_paths(blueprint, profiles_dir: profiles_dir, core_dir: core_dir)
    dependencies = paths.to_h do |path|
      relative = path.start_with?(REPO_ROOT) ? path.delete_prefix("#{REPO_ROOT}/") : path
      [relative, Digest::SHA256.file(path).hexdigest]
    end
    dependencies["blueprint"] = Digest::SHA256.file(blueprint_path).hexdigest
    digest = Digest::SHA256.hexdigest(dependencies.sort.map { |path, sha| "#{path}:#{sha}" }.join("\n"))
    { "factory_version" => "1.0.0", "build_fingerprint" => digest, "dependencies" => dependencies }
  end

  def yaml_front_matter(data)
    body = data.to_yaml.sub(/\A---\s*\n/, "")
    "---\n#{body}---\n"
  end

  def render_audience(audience)
    list = lambda do |value|
      Array(value).map { |item| "- #{item}" }.join("\n")
    end
    <<~MARKDOWN
      #{GENERATED_NOTICE}
      # Audience profile — #{audience.fetch('label')}

      - Tone: #{audience.fetch('tone')}
      - CTA behavior: #{audience.fetch('cta_behavior')}
      - Lead routing: #{audience.fetch('lead_routing')}
      - Privacy level: `#{audience.fetch('privacy_level')}`
      - Disclosures: #{audience.fetch('disclosures')}
      - Response style: #{audience.fetch('response_style')}

      ## Allowed Actions

      #{list.call(audience.fetch('allowed_actions'))}

      ## Compliance reminders

      #{list.call(audience.fetch('compliance_reminders'))}
    MARKDOWN
  end

  def render_platform_export(platform, core_dir)
    exporters = load_yaml(File.join(REPO_ROOT, "exporters/platforms.yaml"))
    adapter = exporters.fetch("platforms").fetch(platform)
    <<~MARKDOWN
      #{GENERATED_NOTICE}
      # Platform export — #{adapter.fetch('label')}

      - Adapter status: `#{adapter.fetch('adapter_status')}`
      - Instruction target: `#{adapter.fetch('instruction_target')}`
      - Knowledge target: `#{adapter.fetch('knowledge_target')}`
      - Action format: `#{adapter.fetch('action_format')}`

      Platform formatting may change in `exporters/`; core identity, audience, compliance, conversation, routing, CTA, lead-capture, knowledge, and tests remain unchanged.
    MARKDOWN
  end

  def render_compliance_snapshot(core_dir)
    rules = load_yaml(File.join(core_dir, "compliance/compliance_rules.yaml"))
    sections = rules.fetch("topics").map { |name, entry| "## #{name.tr('_', ' ').split.map(&:capitalize).join(' ')}\n\n#{entry.fetch('rule')}" }
    <<~MARKDOWN
      #{GENERATED_NOTICE}
      # Compliance snapshot

      Source: `core/compliance/compliance_rules.yaml`. Complete the inherited checklist in `compliance/` before launch.

      #{sections.join("\n\n")}
    MARKDOWN
  end

  def render_conversation_profile(core_dir)
    engine = load_yaml(File.join(core_dir, "conversation/conversation_engine.yaml"))
    stages = engine.fetch("stages").map { |name, behavior| "## #{name.tr('_', ' ').split.map(&:capitalize).join(' ')}\n\n#{behavior}" }
    guards = engine.fetch("guards").map { |guard| "- #{guard}" }.join("\n")
    <<~MARKDOWN
      #{GENERATED_NOTICE}
      # Conversation profile

      #{stages.join("\n\n")}

      ## Guards

      #{guards}
    MARKDOWN
  end

  def render_lead_capture_profile(core_dir, enabled)
    engine = load_yaml(File.join(core_dir, "lead_capture/lead_capture_engine.yaml"))
    behaviors = engine.fetch("behaviors").map { |behavior| "- #{behavior}" }.join("\n")
    <<~MARKDOWN
      #{GENERATED_NOTICE}
      # Lead-capture profile

      - Enabled by manifest: `#{enabled}`
      - Deployment status: `#{engine.fetch('deployed')}`
      - Operation: `#{engine.fetch('operation_id')}`

      #{behaviors}

      A manifest flag never deploys or authorizes the external endpoint. All privacy, security, compliance, consent, and operational gates remain required.
    MARKDOWN
  end

  def write(path, content)
    FileUtils.mkdir_p(File.dirname(path))
    File.write(path, content.end_with?("\n") ? content : "#{content}\n")
  end

  def build(blueprint_path:, output_root:, profiles_dir: File.join(REPO_ROOT, "config/profiles"), core_dir: File.join(REPO_ROOT, "core"), platform: nil, force: false)
    blueprint = load_yaml(blueprint_path)
    blueprint["platform"] = platform if platform
    owner, _lender = validate_blueprint!(blueprint, profiles_dir: profiles_dir, core_dir: core_dir)
    audience = resolved_audience(blueprint.fetch("audience"), core_dir)
    dependencies = dependency_manifest(blueprint, blueprint_path: blueprint_path, profiles_dir: profiles_dir, core_dir: core_dir)
    target = File.join(output_root, blueprint.fetch("slug"))
    raise "Target already exists: #{target}" if File.exist?(target) && !force

    Dir.mktmpdir("legends-gpt-build") do |temporary|
      package = File.join(temporary, blueprint.fetch("slug"))
      %w[knowledge generated tests actions compliance examples].each { |name| FileUtils.mkdir_p(File.join(package, name)) }
      generated = File.join(package, "generated")
      ContactSnapshots.generate(
        profiles_dir: profiles_dir,
        owner_profile_id: blueprint.fetch("owner_profile_id"),
        assigned_lending_partner_profile_id: blueprint["assigned_lending_partner_profile_id"],
        output_dir: generated,
        core_dir: core_dir,
        apply_now_behavior: blueprint.fetch("apply_now_behavior"),
        audience_label: blueprint.fetch("audience")
      )

      manifest = blueprint.reject { |key, _value| %w[purpose scope output_contract conversation_starters].include?(key) }
      manifest["factory_build_fingerprint"] = dependencies.fetch("build_fingerprint")
      write(File.join(package, "manifest.md"), "#{yaml_front_matter(manifest)}\n# Manifest\n\nGenerated and validated by the Legends GPT Factory.\n")
      write(File.join(package, "README.md"), <<~MARKDOWN)
        #{GENERATED_NOTICE}
        # #{blueprint.fetch('name')}

        **Status:** #{blueprint.fetch('status')}
        **Version:** #{blueprint.fetch('version')}
        **Audience:** #{blueprint.fetch('audience')}
        **Owner profile:** `#{owner.fetch('profile_id')}`

        ## Business outcome

        #{blueprint.fetch('purpose')}

        This package inherits factory modules recorded in `generated/factory_dependencies.yaml`. Edit the blueprint or canonical core modules and regenerate; do not hand-edit generated files.
      MARKDOWN
      write(File.join(package, "instructions.md"), <<~MARKDOWN)
        #{GENERATED_NOTICE}
        # Instructions

        ## Purpose

        #{blueprint.fetch('purpose')}

        ## Allowed scope

        #{Array(blueprint.fetch('scope')).map { |item| "- #{item}" }.join("\n")}

        ## Output contract

        #{Array(blueprint.fetch('output_contract')).map { |item| "- #{item}" }.join("\n")}

        ## Inherited controls

        Treat every file in `generated/` as binding inherited behavior. Package-specific instructions may narrow behavior but cannot override identity sources, safety, privacy, compliance, audience boundaries, routing, consent, or Action policy.
      MARKDOWN
      starters = (Array(audience.fetch("conversation_starters")) + Array(blueprint["conversation_starters"])).uniq
      write(File.join(package, "conversation_starters.md"), "#{GENERATED_NOTICE}\n# Conversation starters\n\n#{starters.map { |item| "- #{item}" }.join("\n")}\n")
      write(File.join(package, "knowledge/README.md"), "#{GENERATED_NOTICE}\n# Knowledge selection\n\n#{blueprint.fetch('knowledge_folders').map { |item| "- `#{item}` from the shared knowledge registry" }.join("\n")}\n")
      action_lines = blueprint.fetch("actions").empty? ? "- No Actions configured." : blueprint.fetch("actions").map { |item| "- `#{item}` governed by `core/actions/action_policy.yaml`" }.join("\n")
      write(File.join(package, "actions/README.md"), "#{GENERATED_NOTICE}\n# Actions\n\n#{action_lines}\n")
      if blueprint.fetch("actions").include?("submitMortgageLead")
        FileUtils.cp(File.join(core_dir, "lead_capture/openapi.yaml"), File.join(package, "actions/openapi.yaml"))
      end
      write(File.join(package, "compliance/README.md"), "#{GENERATED_NOTICE}\n# Compliance\n\nInherits `core/compliance/compliance_rules.yaml` and `core/compliance/compliance_checklist.md`. Record package approval evidence here after review.\n")
      write(File.join(package, "tests/README.md"), "#{GENERATED_NOTICE}\n# Tests\n\nInherits `core/shared_tests/factory_acceptance_tests.yaml` and `core/shared_tests/contact_and_referral_routing_tests.md`. Add package-specific cases without copying shared tests.\n")
      write(File.join(package, "compliance/checklist.md"), "#{GENERATED_NOTICE}\n#{File.read(File.join(core_dir, 'compliance/compliance_checklist.md'))}")
      write(File.join(package, "tests/factory_acceptance_tests.yaml"), "# GENERATED FILE — DO NOT EDIT.\n#{File.read(File.join(core_dir, 'shared_tests/factory_acceptance_tests.yaml'))}")
      write(File.join(package, "tests/contact_and_referral_routing_tests.md"), "#{GENERATED_NOTICE}\n#{File.read(File.join(core_dir, 'shared_tests/contact_and_referral_routing_tests.md'))}")
      write(File.join(package, "examples/README.md"), "#{GENERATED_NOTICE}\n# Examples\n\nAdd approved, synthetic, non-PII examples during package development.\n")
      write(File.join(package, "changelog.md"), "#{GENERATED_NOTICE}\n# Changelog\n\n## #{blueprint.fetch('version')}\n\n- Generated from factory fingerprint `#{dependencies.fetch('build_fingerprint')}`.\n")
      write(File.join(generated, "audience_profile.md"), render_audience(audience))
      write(File.join(generated, "compliance_snapshot.md"), render_compliance_snapshot(core_dir))
      write(File.join(generated, "conversation_profile.md"), render_conversation_profile(core_dir))
      write(File.join(generated, "lead_capture_profile.md"), render_lead_capture_profile(core_dir, blueprint.fetch("lead_capture_enabled")))
      write(File.join(generated, "factory_dependencies.yaml"), dependencies.to_yaml)
      write(File.join(generated, "platform_export.md"), render_platform_export(blueprint.fetch("platform"), core_dir))

      FileUtils.rm_rf(target) if force && File.exist?(target)
      FileUtils.mkdir_p(output_root)
      FileUtils.mv(package, target)
    end
    target
  end
end
