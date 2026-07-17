#!/usr/bin/env ruby
# frozen_string_literal: true

require "json"
require "pathname"
require "yaml"
require_relative "factory_support"

def assert(condition, message)
  raise "FAIL: #{message}" unless condition
end

root = LegendsFactory::REPO_ROOT
core = File.join(root, "core")
required_modules = %w[identity audiences compliance routing actions conversation prompts cta lead_capture shared_knowledge shared_tests templates]
required_modules.each do |name|
  assert(File.file?(File.join(core, name, "README.md")), "core/#{name}/README.md missing")
end

yaml_files = Dir[File.join(core, "**/*.yaml")] + [File.join(root, "exporters/platforms.yaml")]
yaml_files.each { |path| LegendsFactory.load_yaml(path) }
JSON.parse(File.read(File.join(core, "templates/manifest.schema.json")))

audience_engine = LegendsFactory.load_yaml(File.join(core, "audiences/audience_profiles.yaml"))
expected_audiences = %w[consumer realtor loan_officer internal_team recruit vendor marketing executive mixed]
assert(audience_engine.fetch("audiences").keys.sort == expected_audiences.sort, "Audience Engine must define exactly nine required audiences")
audience_fields = %w[label tone conversation_starters cta_behavior lead_routing compliance_reminders allowed_actions privacy_level disclosures response_style]
audience_engine.fetch("audiences").each_value do |profile|
  resolved = LegendsFactory.deep_merge(audience_engine.fetch("defaults"), profile)
  assert((audience_fields - resolved.keys).empty?, "audience profile is incomplete")
end

cta = LegendsFactory.load_yaml(File.join(core, "cta/cta_library.yaml"))
expected_ctas = %w[apply_now book_appointment call email text realtor_partner first_time_buyer va investment refinance builder open_house educational_webinar market_update general_consultation late_night_questions action_failure emergency_human_contact]
assert(cta.fetch("ctas").keys == expected_ctas, "CTA library must define the required 18 CTAs in canonical order")

compliance = LegendsFactory.load_yaml(File.join(core, "compliance/compliance_rules.yaml"))
expected_topics = %w[mortgage_advertising respa fair_housing equal_housing licensing nmls rate_language guarantee_language ai_disclosure privacy lead_capture_consent prohibited_statements escalation]
assert(compliance.fetch("topics").keys == expected_topics, "Compliance Engine topic coverage mismatch")

conversation = LegendsFactory.load_yaml(File.join(core, "conversation/conversation_engine.yaml"))
expected_stages = %w[greeting discovery clarification answer_first escalation refusal contact lead_capture human_handoff application closing conversation_end]
assert(conversation.fetch("stages").keys == expected_stages, "Conversation Engine stage coverage mismatch")

lead_engine = LegendsFactory.load_yaml(File.join(core, "lead_capture/lead_capture_engine.yaml"))
assert(lead_engine.fetch("behaviors").length == 10, "Lead Capture Engine requires ten behaviors")
assert(lead_engine.fetch("deployed") == false, "Lead Capture Engine must remain non-deployed")
openapi = LegendsFactory.load_yaml(File.join(core, "lead_capture/openapi.yaml"))
operation = openapi.fetch("paths").fetch("/v1/mortgage-leads").fetch("post")
assert(operation.fetch("operationId") == "submitMortgageLead", "OpenAPI operationId mismatch")
request_schema = openapi.fetch("components").fetch("schemas").fetch("MortgageLeadRequest")
expected_required_fields = %w[first_name last_name email phone preferred_contact_method inquiry_type buy_or_refinance property_state estimated_timeframe message source_gpt_id owner_profile_id assigned_lending_partner_profile_id consent_to_contact consent_timestamp]
assert(request_schema.fetch("required") == expected_required_fields, "OpenAPI required fields changed")
assert(request_schema.fetch("additionalProperties") == false, "OpenAPI must reject unknown properties")
assert((lead_engine.fetch("prohibited_fields") & request_schema.fetch("properties").keys).empty?, "OpenAPI defines a prohibited field")
lead_test_count = File.read(File.join(core, "lead_capture/TEST_CASES.md")).scan(/^\| LC-\d{2} /).length
routing_test_count = File.read(File.join(core, "shared_tests/contact_and_referral_routing_tests.md")).scan(/^\| CR-\d{2} /).length
assert(lead_test_count == 15, "Lead Capture Engine must retain fifteen contract tests")
assert(routing_test_count == 15, "shared routing suite must retain fifteen tests")

template = File.read(File.join(core, "templates/manifest.template.md"))
front_matter = template[/\A---\n(.*?)\n---\n/m, 1]
assert(front_matter, "manifest template front matter missing")
template_manifest = YAML.safe_load(front_matter, permitted_classes: [], permitted_symbols: [], aliases: false)
schema = JSON.parse(File.read(File.join(core, "templates/manifest.schema.json")))
assert((schema.fetch("required") - template_manifest.keys).empty?, "manifest template omits required schema properties")
LegendsFactory.validate_manifest_schema!(template_manifest, core)
schema.fetch("properties").each do |field, definition|
  next unless definition["enum"] && template_manifest.key?(field)
  assert(definition["enum"].include?(template_manifest[field]), "manifest template has invalid #{field}")
end

compatibility_links = Dir[File.join(root, "actions/lead_capture/*")] + Dir[File.join(root, "gpts/templates/{manifest.template.md,shared_modules/*,tests/*}")]
compatibility_links.each do |path|
  assert(File.symlink?(path), "legacy compatibility path must be a symlink: #{path}")
  assert(File.exist?(path), "broken compatibility link: #{path}")
end

profile = LegendsFactory.load_yaml(File.join(root, "config/profiles/jeremy_mcdonald.yaml"))
unique_fields = %w[mobile email personal_website team_website apply_now_url individual_nmls company_nmls]
authored_files = Dir[File.join(root, "**/*")].select do |path|
  File.file?(path) && !File.symlink?(path) && !path.include?("/.git/") && !path.include?("/source_material/") && !path.include?("/config/profiles/")
end
dedup_files = authored_files.reject do |path|
  path == File.join(root, "README.md") ||
    path.match?(%r{/jeremys-custom-gpts/[^/]+/generated/})
end
unique_fields.each do |field|
  value = profile.fetch(field).to_s
  # README.md and package generated/ snapshots are projections of the canonical
  # profile, not additional authored identity sources. They remain in link and
  # secret validation below.
  hits = dedup_files.select { |path| File.binread(path).include?(value) rescue false }
  assert(hits.empty?, "central profile value duplicated outside profile store: #{field} in #{hits.map { |path| Pathname(path).relative_path_from(Pathname(root)) }.join(', ')}")
end

canonical_runtime_sources = {
  "CTA library" => File.join(core, "cta/cta_library.yaml"),
  "routing engine" => File.join(core, "routing/routing_rules.yaml"),
  "compliance checklist" => File.join(core, "compliance/compliance_checklist.md"),
  "lead-capture engine" => File.join(core, "lead_capture/lead_capture_engine.yaml"),
  "OpenAPI contract" => File.join(core, "lead_capture/openapi.yaml")
}
canonical_runtime_sources.each do |label, canonical|
  basename = File.basename(canonical)
  regular_matches = authored_files.select { |path| File.basename(path) == basename }
  assert(regular_matches == [canonical], "#{label} must have exactly one regular canonical source")
end

markdown_files = Dir[File.join(root, "**/*.md")].reject { |path| path.include?("/source_material/") }
missing_links = []
markdown_files.each do |path|
  File.read(path).scan(/\[[^\]]+\]\(([^)]+)\)/).flatten.each do |target|
    next if target.match?(%r{\A(?:https?://|mailto:|#)})
    clean = target.sub(/#.*\z/, "")
    next if clean.empty?
    resolved = File.expand_path(clean, File.dirname(path))
    missing_links << "#{path} -> #{target}" unless File.exist?(resolved)
  end
end
assert(missing_links.empty?, "broken Markdown links:\n#{missing_links.join("\n")}")

secret_pattern = /sk-[A-Za-z0-9_-]{20,}|gh[pousr]_[A-Za-z0-9]{20,}|AKIA[0-9A-Z]{16}|BEGIN (?:RSA |EC |OPENSSH )?PRIVATE KEY/
secret_hits = authored_files.select { |path| File.binread(path).match?(secret_pattern) rescue false }
assert(secret_hits.empty?, "secret-like value found")

puts "PASS: core modules, audiences, compliance, conversation, CTAs, lead capture, manifest, deduplication, links, and secrets"
