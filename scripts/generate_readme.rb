#!/usr/bin/env ruby
# frozen_string_literal: true

require "open3"
require "optparse"
require "pathname"
require "yaml"

class ReadmeGenerator
  REQUIRED_CONFIG_KEYS = %w[
    project_title mission section_order folders_included_in_repository_map
    documentation_links badge_labels statistics_sources excluded_paths
    sensitive_path_patterns maximum_current_portfolio_rows
    include_generated_timestamp gpt_status_order
  ].freeze
  REQUIRED_SECTIONS = %w[
    current_release release_status executive_overview architecture_flow
    repository_statistics main_capabilities supported_owner_modes
    supported_audiences supported_export_targets repository_map quick_start
    gpt_package_standard contact_and_referral_routing compliance_boundary
    current_portfolio current_build_status release_and_versioning
    safety_and_secrets documentation_links license_status maintainer footer
  ].freeze
  REQUIRED_STATISTICS = %w[
    core_modules audiences compliance_topics ctas routing_tests action_tests
    platform_exports gpt_packages archived_source_documents portfolio_report
    identity_profile identity_pack package_structure
  ].freeze

  attr_reader :root, :config

  def initialize(root:, config_path:)
    @root = File.expand_path(root)
    @config = load_yaml(resolve(config_path))
    validate_config!
    @sensitive_patterns = config.fetch("sensitive_path_patterns").map { |pattern| Regexp.new(pattern) }
  rescue RegexpError => error
    raise "README config contains an invalid sensitive_path_pattern: #{error.message}"
  end

  def generate
    sections = config.fetch("section_order").map { |name| send("render_#{name}") }
    (["# #{config.fetch('project_title')}", config.fetch("mission")] + sections.map(&:rstrip)).join("\n\n") + "\n"
  end

  def write(output_path)
    destination = resolve(output_path)
    content = generate
    File.write(destination, content) unless File.file?(destination) && File.read(destination) == content
    content
  end

  def check(output_path)
    destination = resolve(output_path)
    File.file?(destination) && File.read(destination) == generate
  end

  private

  def resolve(path)
    expanded = File.expand_path(path, root)
    raise "Path escapes repository: #{path}" unless expanded == root || expanded.start_with?("#{root}/")

    expanded
  end

  def relative(path)
    Pathname(File.expand_path(path)).relative_path_from(Pathname(root)).to_s
  end

  def load_yaml(path)
    raise "Required README source is missing: #{relative(path)}" unless File.file?(path)

    data = YAML.safe_load(File.read(path), permitted_classes: [], permitted_symbols: [], aliases: false)
    raise "README source must be a YAML mapping: #{relative(path)}" unless data.is_a?(Hash)

    data.transform_keys(&:to_s)
  end

  def source(key)
    resolve(config.fetch("statistics_sources").fetch(key))
  end

  def validate_config!
    missing = REQUIRED_CONFIG_KEYS - config.keys
    raise "README config missing required keys: #{missing.join(', ')}" unless missing.empty?
    sections = config.fetch("section_order")
    raise "README section_order must be an array" unless sections.is_a?(Array)
    missing_sections = REQUIRED_SECTIONS - sections
    unknown_sections = sections - REQUIRED_SECTIONS
    raise "README config missing sections: #{missing_sections.join(', ')}" unless missing_sections.empty?
    raise "README config contains unknown sections: #{unknown_sections.join(', ')}" unless unknown_sections.empty?
    raise "README config section_order contains duplicates" unless sections.uniq == sections
    missing_stats = REQUIRED_STATISTICS - config.fetch("statistics_sources").keys
    raise "README config missing statistics sources: #{missing_stats.join(', ')}" unless missing_stats.empty?
    raise "maximum_current_portfolio_rows must be a positive integer" unless config.fetch("maximum_current_portfolio_rows").is_a?(Integer) && config.fetch("maximum_current_portfolio_rows").positive?
    raise "include_generated_timestamp must be boolean" unless [true, false].include?(config.fetch("include_generated_timestamp"))
    config.fetch("folders_included_in_repository_map").each_key do |folder|
      raise "README repository-map folder is missing: #{folder}/" unless File.directory?(resolve(folder))
    end
    config.fetch("documentation_links").each do |entry|
      raise "README documentation link requires label and path" unless entry.is_a?(Hash) && entry["label"] && entry["path"]
      raise "README documentation target is missing: #{entry['path']}" unless File.file?(resolve(entry["path"]))
    end
  end

  def git(*args)
    stdout, _stderr, status = Open3.capture3("git", "-C", root, *args)
    status.success? ? stdout.strip : nil
  rescue Errno::ENOENT
    nil
  end

  def public_remote
    remote = git("remote", "get-url", "origin")
    return nil unless remote
    match = remote.match(/\Agit@github\.com:([^\/]+)\/([^\/]+?)(?:\.git)?\z/)
    return "https://github.com/#{match[1]}/#{match[2]}" if match

    remote.start_with?("https://") ? remote.sub(/\.git\z/, "") : nil
  end

  def branch
    git("branch", "--show-current")
  end

  def version
    @version ||= begin
      value = File.read(resolve("VERSION")).strip
      raise "VERSION must contain a semantic version" unless value.match?(/\A\d+\.\d+\.\d+\z/)
      value
    end
  end

  def changelog
    @changelog ||= File.read(resolve("CHANGELOG.md"))
  end

  def release_date
    @release_date ||= begin
      match = changelog.match(/^## \[#{Regexp.escape(version)}\] - (\d{4}-\d{2}-\d{2})$/)
      raise "CHANGELOG does not contain release #{version}" unless match
      match[1]
    end
  end

  def generated_timestamp
    "#{release_date}T00:00:00Z"
  end

  def audience_engine
    @audience_engine ||= load_yaml(source("audiences"))
  end

  def audiences
    @audiences ||= audience_engine.fetch("audiences").values.map { |profile| profile.fetch("label") }
  end

  def exporters
    @exporters ||= load_yaml(source("platform_exports")).fetch("platforms")
  end

  def profile
    @profile ||= load_yaml(source("identity_profile"))
  end

  def identity_pack
    @identity_pack ||= load_yaml(source("identity_pack"))
  end

  def package_structure
    @package_structure ||= load_yaml(source("package_structure"))
  end

  def path_excluded?(path)
    rel = relative(path)
    config.fetch("excluded_paths").any? { |excluded| rel == excluded || rel.start_with?("#{excluded}/") || File.basename(rel) == excluded }
  end

  def excluded?(path)
    rel = relative(path)
    path_excluded?(path) || @sensitive_patterns.any? { |pattern| rel.match?(pattern) }
  end

  def package_manifests
    @package_manifests ||= Dir[File.join(source("gpt_packages"), "*", "manifest.md")].sort.reject { |path| excluded?(path) }.map do |path|
      text = File.read(path)
      front_matter = text[/\A---\n(.*?)\n---\n/m, 1]
      raise "GPT manifest lacks YAML front matter: #{relative(path)}" unless front_matter
      data = YAML.safe_load(front_matter, permitted_classes: [], permitted_symbols: [], aliases: false)
      raise "GPT manifest must be a mapping: #{relative(path)}" unless data.is_a?(Hash)
      status = data["status"].to_s
      raise "GPT manifest has unsupported status #{status}: #{relative(path)}" unless config.fetch("gpt_status_order").include?(status)
      data.merge("_path" => relative(path))
    end
  end

  def portfolio
    @portfolio ||= begin
      report = File.read(source("portfolio_report"))
      rows = report.lines.each_with_object([]) do |line, collected|
        next unless line.match?(/^\|\s*\d+\s*\|\s*Legends /)
        cells = line.strip.sub(/^\|/, "").sub(/\|$/, "").split("|").map(&:strip)
        total = cells.last[/\d+/]
        collected << { "rank" => cells[0].to_i, "name" => cells[1], "score" => total.to_i }
      end
      rows = rows.sort_by { |row| row.fetch("rank") }.first(config.fetch("maximum_current_portfolio_rows"))
      raise "Portfolio report contains no ranked GPT rows" if rows.empty?
      rows
    end
  end

  def recommended_first_five
    report = File.read(source("portfolio_report"))
    paragraph = report[/first five should be:(.*?)(?:\n\n)/mi, 1]
    names = paragraph ? paragraph.scan(/\*\*([^*]+)\*\*/).flatten : []
    names.empty? ? portfolio.first(5).map { |row| row.fetch("name") } : names
  end

  def archived_source_count
    Dir[File.join(source("archived_source_documents"), "**", "*")].count do |path|
      # This is a filesystem inventory only. Source contents and filenames are
      # never rendered, so sensitive-path filtering is not needed for the count.
      File.file?(path) && !File.symlink?(path) && !path_excluded?(path)
    end
  end

  def core_module_count
    Dir[File.join(source("core_modules"), "*")].count { |path| File.directory?(path) && File.file?(File.join(path, "README.md")) }
  end

  def count_test_rows(path, prefix)
    File.read(path).scan(/^\| #{Regexp.escape(prefix)}-\d{2} /).length
  end

  def statistics
    @statistics ||= {
      "Core modules" => core_module_count,
      "Audience profiles" => audiences.length,
      "Compliance topics" => load_yaml(source("compliance_topics")).fetch("topics").length,
      "CTA variants" => load_yaml(source("ctas")).fetch("ctas").length,
      "Routing tests" => count_test_rows(source("routing_tests"), "CR"),
      "Action tests" => count_test_rows(source("action_tests"), "LC"),
      "Platform exports" => exporters.length,
      "Planned GPTs" => package_manifests.count { |manifest| manifest.fetch("status") == "planned" },
      "Built GPT packages" => package_manifests.length,
      "Approved GPT packages" => package_manifests.count { |manifest| manifest.fetch("status") == "approved" },
      "Archived source documents" => archived_source_count
    }
  end

  def license_summary
    @license_summary ||= begin
      text = File.read(resolve("LICENSE_STATUS.md"))
      match = text.match(/License status is \*\*([^*]+)\*\*/i)
      match ? match[1] : "See LICENSE_STATUS.md"
    end
  end

  def badge_token(value)
    value.to_s.gsub("-", "--").gsub("_", "__").gsub(" ", "_").gsub("/", "%2F")
  end

  def badge(label, value, color)
    "![#{label}](https://img.shields.io/badge/#{badge_token(label)}-#{badge_token(value)}-#{color})"
  end

  def section(title, body)
    "## #{title}\n\n#{body}\n"
  end

  def markdown_table(headers, rows, aligns = nil)
    divider = aligns || headers.map { "---" }
    (["| #{headers.join(' | ')} |", "| #{divider.join(' | ')} |"] + rows.map { |row| "| #{row.join(' | ')} |" }).join("\n")
  end

  def render_current_release
    rows = [["Version", "`#{version}`"], ["Release date", release_date], ["Branch", "`#{branch || 'unavailable'}`"]]
    rows << ["Repository", "[GitHub](#{public_remote})"] if public_remote
    section("Current release", markdown_table(["Field", "Value"], rows))
  end

  def render_release_status
    qa = File.read(resolve("docs/goat_architect/QA_Log.md"))
    validation = qa.include?("GPT Factory v1.0.0 release validation") ? "release validated" : "factory tests"
    ready = exporters.count { |_id, entry| entry.fetch("adapter_status").to_s.start_with?("ready") }
    badges = [
      badge(config.fetch("badge_labels").fetch("version"), version, "blue"),
      badge(config.fetch("badge_labels").fetch("build"), "local scripts", "blue"),
      badge(config.fetch("badge_labels").fetch("validation"), validation, validation == "release validated" ? "brightgreen" : "blue"),
      badge(config.fetch("badge_labels").fetch("license"), license_summary.split("/").first.strip, "lightgrey"),
      badge(config.fetch("badge_labels").fetch("platform"), "#{ready} ready / #{exporters.length - ready} planned", "blue")
    ]
    section("Release status", badges.join(" "))
  end

  def render_executive_overview
    section("Executive overview", "This repository is a governed GPT operating system, not a prompt dump. Approved blueprints inherit centralized identity, audience, compliance, conversation, routing, CTA, lead-capture, knowledge, and test modules; deterministic builders then create auditable, versioned packages for supported assistant platforms.")
  end

  def render_architecture_flow
    dependency = File.read(resolve("CORE_MODULE_DEPENDENCY_MAP.md"))
    diagram = dependency[/```mermaid\n(.*?)```/m, 1]
    raise "CORE_MODULE_DEPENDENCY_MAP.md contains no Mermaid diagram" unless diagram
    section("Architecture flow", "```mermaid\n#{diagram}```")
  end

  def render_repository_statistics
    rows = statistics.map { |label, value| [label, value.to_s] }
    rows << ["Last generated timestamp (UTC)", generated_timestamp] if config.fetch("include_generated_timestamp")
    section("Repository statistics", markdown_table(["Metric", "Current value"], rows, ["---", "---:"]))
  end

  def render_main_capabilities
    capabilities = [
      "Centralized identity profiles", "Loan officer and Realtor profile inheritance", "Assigned lending-partner routing",
      "Audience, Compliance, Conversation, Routing, and CTA engines", "Non-deployed lead-capture architecture",
      "Deterministic package generation and portfolio rebuild", "Factory, profile, routing, and contract validation",
      "Multi-platform export configuration", "Governed knowledge-curation model", "Versioned, hash-tracked GPT packages"
    ]
    section("Main capabilities", capabilities.map { |item| "- #{item}" }.join("\n"))
  end

  def render_supported_owner_modes
    routing = load_yaml(resolve("core/routing/routing_rules.yaml"))
    labels = { "jeremy" => "Jeremy", "loan_officer" => "Loan officer", "realtor" => "Realtor", "team_shared" => "Team shared" }
    modes = routing.fetch("owner_types").keys.map { |key| labels.fetch(key, key.tr("_", " ").capitalize) }
    section("Supported owner modes", modes.map { |mode| "- #{mode}" }.join("\n"))
  end

  def render_supported_audiences
    section("Supported audiences", audiences.map { |audience| "- #{audience}" }.join("\n"))
  end

  def render_supported_export_targets
    rows = exporters.map do |_id, entry|
      [entry.fetch("label"), "`#{entry.fetch('adapter_status')}`", "`#{entry.fetch('action_format')}`"]
    end
    section("Supported export targets", markdown_table(["Platform", "Adapter status", "Action format"], rows))
  end

  def render_repository_map
    rows = config.fetch("folders_included_in_repository_map").map { |folder, purpose| ["`#{folder}/`", purpose] }
    section("Repository map", markdown_table(["Path", "Purpose"], rows))
  end

  def render_quick_start
    commands = <<~MARKDOWN.chomp
      ```bash
      # Validate the complete Factory
      ruby scripts/validate_gpt_factory.rb

      # Generate this README
      ruby scripts/generate_readme.rb

      # Generate one authorized GPT package
      ruby scripts/build_gpt_package.rb --blueprint /approved/path/<slug>.yaml --output-root gpts

      # Rebuild every registered GPT blueprint
      ruby scripts/rebuild_all_gpts.rb

      # Run contact/profile snapshot tests
      ruby scripts/test_contact_snapshot_generation.rb

      # Run the non-deployed lead-capture contract tests
      ruby scripts/test_lead_capture_contract.rb
      ```
    MARKDOWN
    section("Quick start", commands)
  end

  def render_gpt_package_standard
    required_files = package_structure.fetch("required_files")
    lines = ["gpts/<slug>/"]
    required_files.reject { |path| path.include?("/") }.each { |path| lines << "  #{path}" }
    package_structure.fetch("required_directories").each do |directory|
      lines << "  #{directory}/"
      required_files.select { |path| path.start_with?("#{directory}/") }.each do |path|
        lines << "    #{path.delete_prefix("#{directory}/")}"
      end
    end
    body = "Every authorized package is generated from the canonical Factory structure:\n\n```text\n#{lines.uniq.join("\n")}\n```\n\nSee [Architecture](docs/goat_architect/Architecture.md) and the [GPT Factory Build Process](docs/GPT_FACTORY_BUILD_PROCESS.md)."
    section("GPT package standard", body)
  end

  def render_contact_and_referral_routing
    body = <<~MARKDOWN.chomp
      - Jeremy-owned GPTs route mortgage opportunities to Jeremy's active licensed profile.
      - Loan-officer-owned GPTs route to the selected active licensed loan officer.
      - Realtor-owned GPTs preserve the Realtor identity while mortgage inquiries and Apply Now behavior route to the assigned licensed lending partner.
      - Team-shared GPTs require an approved recipient before mortgage routing is enabled.
      - Consumer lead submission identifies the licensed recipient and requires explicit affirmative consent.
      - Full mortgage applications use the resolved secure Apply Now URL, never ordinary lead capture.
    MARKDOWN
    section("Contact and referral routing", body)
  end

  def render_compliance_boundary
    disclosure = format(identity_pack.fetch("formatting").fetch("compliance_disclosure"), profile.transform_keys(&:to_sym))
    body = <<~MARKDOWN.chomp
      - No guaranteed approval.
      - No guaranteed rate.
      - No guaranteed payment.
      - No guaranteed savings.
      - No guaranteed terms.
      - No autonomous underwriting or eligibility decisions.
      - No sensitive mortgage application data in ordinary lead capture.
      - Public releases require privacy, security, compliance, licensing, and operational approval.

      #{disclosure}
    MARKDOWN
    section("Compliance boundary", body)
  end

  def render_current_portfolio
    rows = portfolio.map { |row| [row.fetch("rank").to_s, row.fetch("name"), "**#{row.fetch('score')} / 150**"] }
    recommendations = recommended_first_five.each_with_index.map { |name, index| "#{index + 1}. #{name}" }.join("\n")
    body = "### Ranked Top 15\n\n#{markdown_table(['Rank', 'GPT recommendation', 'Score'], rows, ['---:', '---', '---:'])}\n\n### Current first-five portfolio recommendations\n\nThese are portfolio recommendations, not an approved build order.\n\n#{recommendations}"
    section("Current portfolio", body)
  end

  def render_current_build_status
    blocks = config.fetch("gpt_status_order").map do |status|
      matches = package_manifests.select { |manifest| manifest.fetch("status") == status }
      rows = matches.map do |manifest|
        [manifest["name"] || manifest["gpt_id"], manifest["version"], "`#{manifest.fetch('_path')}`"]
      end
      content = rows.empty? ? "No #{status} GPT packages." : markdown_table(["Package", "Version", "Manifest"], rows)
      "### #{status.capitalize} GPTs\n\n#{content}"
    end
    intro = package_manifests.empty? ? "No individual GPT package manifests currently exist.\n\n" : ""
    section("Current build status", "#{intro}#{blocks.join("\n\n")}")
  end

  def render_release_and_versioning
    section("Release and versioning", "The Factory uses semantic versioning (`MAJOR.MINOR.PATCH`). Release history and material changes are recorded in [CHANGELOG.md](CHANGELOG.md). Generated GPT packages maintain their own semantic versions and changelogs.")
  end

  def render_safety_and_secrets
    body = "Credentials, tokens, private keys, live webhooks, borrower data, and hidden environment values never belong in this repository. The visible no-secret environment and credential process is documented in [Credentials Map — No Secrets](docs/goat_architect/Credentials_Map_No_Secrets.md); future environment templates may contain variable names and safe placeholders only."
    section("Safety and secrets", body)
  end

  def render_documentation_links
    links = config.fetch("documentation_links").map { |entry| "- [#{entry.fetch('label')}](#{entry.fetch('path')})" }
    section("Documentation", links.join("\n"))
  end

  def render_license_status
    body = "**#{license_summary}.** See [LICENSE_STATUS.md](LICENSE_STATUS.md). Do not treat this repository as open source or redistribute it unless the owner adds an explicit license that permits that use."
    section("License status", body)
  end

  def render_maintainer
    body = "#{profile.fetch('full_name')}<br>\n#{profile.fetch('professional_title')}<br>\n#{profile.fetch('team_role')}, #{profile.fetch('team_name')}"
    section("Maintainer", body)
  end

  def render_footer
    section("Generated file", "This README is generated by `scripts/generate_readme.rb` from repository metadata. Do not edit `README.md` directly; update the configured source of truth and regenerate it.")
  end
end

if $PROGRAM_NAME == __FILE__
  options = { root: File.expand_path("..", __dir__), config_path: "config/readme_sections.yaml", output: "README.md", check: false }
  parser = OptionParser.new do |opts|
    opts.banner = "Usage: generate_readme.rb [options]"
    opts.on("--config PATH", "README configuration path") { |value| options[:config_path] = value }
    opts.on("--output PATH", "Generated README path") { |value| options[:output] = value }
    opts.on("--check", "Fail when README.md is stale; do not write") { options[:check] = true }
  end
  parser.parse!

  generator = ReadmeGenerator.new(root: options.fetch(:root), config_path: options.fetch(:config_path))
  if options.fetch(:check)
    abort("README.md is stale. Run ruby scripts/generate_readme.rb") unless generator.check(options.fetch(:output))
    puts "PASS: README.md matches generated repository metadata"
  else
    generator.write(options.fetch(:output))
    puts "Generated #{options.fetch(:output)}"
  end
end
