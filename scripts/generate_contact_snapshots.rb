#!/usr/bin/env ruby
# frozen_string_literal: true

require "fileutils"
require "optparse"
require "tmpdir"
require "yaml"

module ContactSnapshots
  REPO_ROOT = File.expand_path("..", __dir__)
  GENERATED_NOTICE = "<!-- GENERATED FILE — DO NOT EDIT. Regenerate from the Legends GPT Factory sources. -->"
  LENDER_TYPES = %w[team_leader loan_officer].freeze
  REALTOR_FIELDS = %w[profile_id profile_type full_name professional_title brokerage_name license_number mobile email website service_area brand_voice assigned_lending_partner_profile_id active].freeze
  LENDER_FIELDS = %w[profile_id profile_type full_name professional_title team_role team_name company_name mobile email personal_website team_website individual_nmls company_nmls apply_now_url equal_housing_required active].freeze

  module_function

  def load_yaml(path)
    data = YAML.safe_load(File.read(path), permitted_classes: [], permitted_symbols: [], aliases: false)
    raise "YAML root must be a mapping: #{path}" unless data.is_a?(Hash)

    data.transform_keys(&:to_s)
  end

  def core_modules(core_dir)
    {
      identity: load_yaml(File.join(core_dir, "identity/identity_pack.yaml")),
      cta: load_yaml(File.join(core_dir, "cta/cta_library.yaml")),
      routing: load_yaml(File.join(core_dir, "routing/routing_rules.yaml")),
      lead_capture: load_yaml(File.join(core_dir, "lead_capture/lead_capture_engine.yaml")),
      audiences: load_yaml(File.join(core_dir, "audiences/audience_profiles.yaml"))
    }
  end

  def validate_profile!(profile)
    raise "Invalid profile_id" unless profile["profile_id"].to_s.match?(/\A[a-z0-9_]+\z/)
    fields = profile["profile_type"] == "realtor" ? REALTOR_FIELDS : LENDER_FIELDS
    missing = fields.select { |field| !profile.key?(field) || profile[field].nil? || profile[field].to_s.strip.empty? }
    raise "Missing required profile fields: #{missing.join(', ')}" unless missing.empty?
    raise "Unsupported profile_type: #{profile['profile_type']}" unless (LENDER_TYPES + ["realtor"]).include?(profile["profile_type"])
    raise "Profile is inactive: #{profile['profile_id']}" unless profile["active"] == true

    return if profile["profile_type"] == "realtor"

    raise "equal_housing_required must be true" unless profile["equal_housing_required"] == true
    %w[individual_nmls company_nmls].each do |field|
      raise "#{field} must contain digits only" unless profile[field].to_s.match?(/\A\d+\z/)
    end
    %w[personal_website team_website apply_now_url].each do |field|
      raise "#{field} must use HTTPS" unless profile[field].to_s.start_with?("https://")
    end
  end

  def resolve(profiles_dir:, owner_profile_id:, assigned_lending_partner_profile_id: nil)
    raise "Invalid owner profile ID" unless owner_profile_id.to_s.match?(/\A[a-z0-9_]+\z/)
    owner_path = File.join(profiles_dir, "#{owner_profile_id}.yaml")
    raise "Owner profile not found: #{owner_path}" unless File.file?(owner_path)

    owner = load_yaml(owner_path)
    validate_profile!(owner)
    raise "Profile ID does not match filename" unless owner["profile_id"] == owner_profile_id

    partner_id = if owner["profile_type"] == "realtor"
                   owner["assigned_lending_partner_profile_id"]
                 else
                   assigned_lending_partner_profile_id
                 end
    lender = owner
    if partner_id && !partner_id.to_s.empty?
      raise "Invalid assigned lending partner profile ID" unless partner_id.to_s.match?(/\A[a-z0-9_]+\z/)
      partner_path = File.join(profiles_dir, "#{partner_id}.yaml")
      raise "Assigned lending partner profile not found: #{partner_path}" unless File.file?(partner_path)

      lender = load_yaml(partner_path)
      validate_profile!(lender)
      raise "Assigned lending partner must be a lending profile" unless LENDER_TYPES.include?(lender["profile_type"])
      raise "Assigned lending partner profile ID does not match filename" unless lender["profile_id"] == partner_id
    elsif owner["profile_type"] == "realtor"
      raise "Realtor profiles require assigned_lending_partner_profile_id"
    end

    [owner, lender]
  end

  def format_template(template, values)
    format(template, values.transform_keys(&:to_sym))
  rescue KeyError => error
    raise "Template variable missing: #{error.message}"
  end

  def template_values(owner, lender)
    {
      lender_name: lender["full_name"],
      company_name: lender["company_name"],
      phone: lender["mobile"],
      email: lender["email"],
      apply_now_url: lender["apply_now_url"],
      booking_url: lender["booking_url"],
      realtor_name: owner["profile_type"] == "realtor" ? owner["full_name"] : "the consumer's real estate professional"
    }
  end

  def compliance_line(lender, modules)
    format_template(modules[:identity].fetch("formatting").fetch("compliance_disclosure"), lender)
  end

  def consent_prompt(lender, modules)
    format_template(modules[:lead_capture].fetch("consent_prompt"), lender_name: lender["full_name"], company_name: lender["company_name"])
  end

  def rendered_ctas(owner, lender, modules, apply_now_behavior)
    values = template_values(owner, lender)
    modules[:cta].fetch("ctas").each_with_object({}) do |(key, entry), rendered|
      next if key == "book_appointment" && values[:booking_url].to_s.empty?
      next if key == "apply_now" && apply_now_behavior == "no_application_link"

      template = if key == "action_failure" && apply_now_behavior == "no_application_link"
                   entry.fetch("text_without_application")
                 else
                   entry.fetch("text")
                 end
      rendered[key] = { "label" => entry.fetch("label"), "text" => format_template(template, values) }
    end
  end

  def render_contact(owner, lender, apply_now_behavior)
    owner_lines = if owner["profile_type"] == "realtor"
                    [owner["full_name"], owner["professional_title"], owner["brokerage_name"], owner["mobile"], owner["email"], owner["website"], "License: #{owner['license_number']}"]
                  else
                    [owner["full_name"], owner["professional_title"], owner["team_role"], owner["team_name"], owner["company_name"], owner["mobile"], owner["email"], owner["personal_website"], owner["team_website"]]
                  end
    lender_lines = [lender["full_name"], lender["professional_title"], "#{lender['team_role']}, #{lender['team_name']}", lender["company_name"], lender["mobile"], lender["email"], lender["personal_website"], lender["team_website"]]
    lender_lines << "Apply Now: #{lender['apply_now_url']}" unless apply_now_behavior == "no_application_link"
    <<~MARKDOWN
      #{GENERATED_NOTICE}
      # Contact profile

      ## GPT owner

      #{owner_lines.map { |line| "- #{line}" }.join("\n")}

      ## Licensed mortgage contact

      #{lender_lines.map { |line| "- #{line}" }.join("\n")}
    MARKDOWN
  end

  def render_compliance(lender, modules)
    <<~MARKDOWN
      #{GENERATED_NOTICE}
      # Compliance identity

      #{compliance_line(lender, modules)}

      Source: `core/identity/identity_pack.yaml` plus the active licensed profile. Do not hand-edit this disclosure.
    MARKDOWN
  end

  def resolved_audience(modules, audience_label)
    return nil unless audience_label

    key = audience_label.downcase.tr(" ", "_")
    selected = modules[:audiences].fetch("audiences").fetch(key) { raise "Unsupported audience: #{audience_label}" }
    modules[:audiences].fetch("defaults").merge(selected)
  end

  def render_ctas(owner, lender, modules, apply_now_behavior, audience_label)
    sections = rendered_ctas(owner, lender, modules, apply_now_behavior).values.map do |entry|
      "## #{entry['label']}\n\n#{entry['text']}"
    end
    audience = resolved_audience(modules, audience_label)
    audience_rule = audience ? "Audience CTA behavior: #{audience.fetch('cta_behavior')}" : "Audience CTA behavior: resolve from the package Audience Engine snapshot."
    <<~MARKDOWN
      #{GENERATED_NOTICE}
      # Call-to-action library

      Source: `core/cta/cta_library.yaml` plus the resolved audience and licensed profile.

      #{audience_rule}

      #{sections.join("\n\n")}
    MARKDOWN
  end

  def render_routing(owner, lender, modules, apply_now_behavior, audience_label)
    triggers = modules[:routing].fetch("mortgage_triggers").map { |item| item.tr("_", " ") }.join(", ")
    sensitive = modules[:lead_capture].fetch("prohibited_fields").map { |item| item.tr("_", " ") }.join(", ")
    fallback = rendered_ctas(owner, lender, modules, apply_now_behavior).fetch("action_failure").fetch("text")
    application_line = apply_now_behavior == "no_application_link" ? "- Application link: disabled by manifest." : "- Apply Now: #{lender['apply_now_url']}"
    audience = resolved_audience(modules, audience_label)
    audience_line = audience ? "- Audience routing: #{audience.fetch('lead_routing')}" : "- Audience routing: resolve from the package Audience Engine snapshot."
    <<~MARKDOWN
      #{GENERATED_NOTICE}
      # Referral routing

      - Owner profile: `#{owner['profile_id']}` (#{owner['profile_type']})
      - Assigned licensed lender: `#{lender['profile_id']}` — #{lender['full_name']}, #{lender['company_name']}
      - Mortgage triggers: #{triggers}.
      #{audience_line}
      #{application_line}

      Before any lead submission, display this resolved prompt and wait for a clear affirmative response:

      > #{consent_prompt(lender, modules)}

      Never request or submit: #{sensitive}. A lead submission is not an application, preapproval, approval, rate lock, or lending commitment.

      Action failure fallback: #{fallback}
    MARKDOWN
  end

  def generate(profiles_dir:, owner_profile_id:, output_dir:, assigned_lending_partner_profile_id: nil, core_dir: File.join(REPO_ROOT, "core"), apply_now_behavior: nil, audience_label: nil)
    modules = core_modules(core_dir)
    owner, lender = resolve(
      profiles_dir: profiles_dir,
      owner_profile_id: owner_profile_id,
      assigned_lending_partner_profile_id: assigned_lending_partner_profile_id
    )
    behavior = apply_now_behavior || (owner["profile_type"] == "realtor" ? "show_assigned_lender_link" : "show_owner_link")
    allowed_behaviors = modules[:routing].fetch("apply_now_behaviors").keys
    raise "Unsupported apply_now_behavior: #{behavior}" unless allowed_behaviors.include?(behavior)

    documents = {
      "contact_profile.md" => render_contact(owner, lender, behavior),
      "compliance_identity.md" => render_compliance(lender, modules),
      "call_to_action_library.md" => render_ctas(owner, lender, modules, behavior, audience_label),
      "referral_routing.md" => render_routing(owner, lender, modules, behavior, audience_label)
    }

    FileUtils.mkdir_p(output_dir)
    Dir.mktmpdir("contact-snapshots") do |temporary|
      documents.each { |name, content| File.write(File.join(temporary, name), content) }
      documents.each_key { |name| FileUtils.mv(File.join(temporary, name), File.join(output_dir, name), force: true) }
    end
    documents.keys
  end
end

if $PROGRAM_NAME == __FILE__
  options = {
    profiles_dir: File.join(ContactSnapshots::REPO_ROOT, "config/profiles"),
    core_dir: File.join(ContactSnapshots::REPO_ROOT, "core")
  }
  parser = OptionParser.new do |opts|
    opts.banner = "Usage: generate_contact_snapshots.rb --owner-profile ID --output-dir PATH [options]"
    opts.on("--owner-profile ID", "Active owner profile ID") { |value| options[:owner_profile_id] = value }
    opts.on("--profiles-dir PATH", "Directory containing profile YAML files") { |value| options[:profiles_dir] = value }
    opts.on("--core-dir PATH", "Factory core directory") { |value| options[:core_dir] = value }
    opts.on("--output-dir PATH", "Target gpts/<slug>/generated directory") { |value| options[:output_dir] = value }
    opts.on("--assigned-lending-partner-profile-id ID", "Assigned lender for Realtor or team-shared routing") { |value| options[:assigned_lending_partner_profile_id] = value }
    opts.on("--apply-now-behavior VALUE", "Apply Now behavior from the Routing Engine") { |value| options[:apply_now_behavior] = value }
    opts.on("--audience LABEL", "Audience Engine label") { |value| options[:audience_label] = value }
  end
  parser.parse!
  parser.abort("Missing --owner-profile") unless options[:owner_profile_id]
  parser.abort("Missing --output-dir") unless options[:output_dir]

  ContactSnapshots.generate(**options)
  puts "Generated contact snapshots in #{options[:output_dir]}"
end
