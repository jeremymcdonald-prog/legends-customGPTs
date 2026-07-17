#!/usr/bin/env ruby
# frozen_string_literal: true

require "fileutils"
require "tmpdir"
require "yaml"
require_relative "generate_contact_snapshots"

def assert(condition, message)
  raise "FAIL: #{message}" unless condition
end

def load_yaml(path)
  YAML.safe_load(File.read(path), permitted_classes: [], permitted_symbols: [], aliases: false)
end

repo_root = File.expand_path("..", __dir__)
jeremy_path = File.join(repo_root, "config/profiles/jeremy_mcdonald.yaml")
core_path = File.join(repo_root, "core")
jeremy = load_yaml(jeremy_path)
identity = load_yaml(File.join(core_path, "identity/identity_pack.yaml"))
lead_engine = load_yaml(File.join(core_path, "lead_capture/lead_capture_engine.yaml"))
cta_library = load_yaml(File.join(core_path, "cta/cta_library.yaml"))
expected_compliance = format(identity.fetch("formatting").fetch("compliance_disclosure"), jeremy.transform_keys(&:to_sym))
expected_consent = format(
  lead_engine.fetch("consent_prompt"),
  lender_name: jeremy.fetch("full_name"),
  company_name: jeremy.fetch("company_name")
)

Dir.mktmpdir("contact-snapshot-tests") do |root|
  profiles = File.join(root, "profiles")
  output = File.join(root, "generated")
  FileUtils.mkdir_p(profiles)
  FileUtils.cp(jeremy_path, File.join(profiles, "jeremy_mcdonald.yaml"))

  ContactSnapshots.generate(profiles_dir: profiles, owner_profile_id: "jeremy_mcdonald", output_dir: output, core_dir: core_path)
  files = %w[contact_profile.md compliance_identity.md call_to_action_library.md referral_routing.md]
  files.each { |name| assert(File.file?(File.join(output, name)), "#{name} was not generated") }
  combined = files.map { |name| File.read(File.join(output, name)) }.join("\n")
  %w[full_name professional_title team_role team_name company_name mobile email personal_website team_website apply_now_url].each do |field|
    assert(combined.include?(jeremy.fetch(field).to_s), "resolved #{field} missing")
  end
  assert(File.read(File.join(output, "compliance_identity.md")).include?(expected_compliance), "Identity Pack disclosure missing")
  assert(File.read(File.join(output, "referral_routing.md")).include?(expected_consent), "Lead Capture Engine consent prompt missing")
  assert(!combined.match?(/NMLS\s*#/i), "NMLS hash format found")
  cta_labels = cta_library.fetch("ctas").values.map { |entry| entry.fetch("label") }
  cta_labels.reject { |label| label == "Book Appointment" }.each do |label|
    assert(File.read(File.join(output, "call_to_action_library.md")).include?("## #{label}"), "CTA missing: #{label}")
  end

  realtor = {
    "profile_id" => "casey_realtor", "profile_type" => "realtor", "full_name" => "Casey Realtor",
    "professional_title" => "REALTOR", "brokerage_name" => "Example Realty", "license_number" => "TEST-100",
    "mobile" => "(555) 010-1000", "email" => "casey@example.invalid", "website" => "https://example.invalid",
    "service_area" => "Test market", "brand_voice" => "Helpful and direct",
    "assigned_lending_partner_profile_id" => jeremy.fetch("profile_id"), "active" => true
  }
  File.write(File.join(profiles, "casey_realtor.yaml"), realtor.to_yaml)
  ContactSnapshots.generate(profiles_dir: profiles, owner_profile_id: "casey_realtor", output_dir: output, core_dir: core_path)
  routing = File.read(File.join(output, "referral_routing.md"))
  contact = File.read(File.join(output, "contact_profile.md"))
  assert(contact.include?(realtor.fetch("full_name")) && contact.include?(jeremy.fetch("full_name")), "Realtor and assigned lender identities missing")
  assert(routing.include?(expected_consent), "resolved Realtor consent prompt missing")

  before = files.to_h { |name| [name, File.read(File.join(output, name))] }
  lender = load_yaml(File.join(profiles, "jeremy_mcdonald.yaml"))
  lender["full_name"] = "Updated Test Lender"
  lender["mobile"] = "(555) 010-9999"
  lender["apply_now_url"] = "https://updated.example.invalid/apply"
  File.write(File.join(profiles, "jeremy_mcdonald.yaml"), lender.to_yaml)
  ContactSnapshots.generate(profiles_dir: profiles, owner_profile_id: "casey_realtor", output_dir: output, core_dir: core_path)
  files.each do |name|
    updated = File.read(File.join(output, name))
    assert(updated != before.fetch(name), "#{name} did not regenerate after one profile update")
    assert(updated.include?(lender.fetch("full_name")), "#{name} does not contain the updated lender")
  end

  copied_core = File.join(root, "core")
  FileUtils.cp_r(core_path, copied_core)
  ctas = load_yaml(File.join(copied_core, "cta/cta_library.yaml"))
  ctas.fetch("ctas").fetch("general_consultation")["text"] = "CORE MODULE UPDATE %{lender_name} %{email}"
  File.write(File.join(copied_core, "cta/cta_library.yaml"), ctas.to_yaml)
  ContactSnapshots.generate(profiles_dir: profiles, owner_profile_id: "casey_realtor", output_dir: output, core_dir: copied_core)
  assert(File.read(File.join(output, "call_to_action_library.md")).include?("CORE MODULE UPDATE"), "shared CTA update did not propagate")

  ContactSnapshots.generate(
    profiles_dir: profiles,
    owner_profile_id: "casey_realtor",
    output_dir: output,
    core_dir: core_path,
    apply_now_behavior: "no_application_link"
  )
  no_application = files.map { |name| File.read(File.join(output, name)) }.join("\n")
  assert(!no_application.include?(lender.fetch("apply_now_url")), "no_application_link exposed an application URL")

  broken = realtor.merge("profile_id" => "broken_realtor", "assigned_lending_partner_profile_id" => "missing_lender")
  File.write(File.join(profiles, "broken_realtor.yaml"), broken.to_yaml)
  begin
    ContactSnapshots.generate(profiles_dir: profiles, owner_profile_id: "broken_realtor", output_dir: output, core_dir: core_path)
    raise "FAIL: Realtor without an assigned lender was accepted"
  rescue RuntimeError => error
    raise if error.message.start_with?("FAIL:")
    assert(error.message.include?("Assigned lending partner profile not found"), "unexpected missing-lender error")
  end
end

puts "PASS: core-driven contact snapshots, inheritance, routing, and regeneration"
