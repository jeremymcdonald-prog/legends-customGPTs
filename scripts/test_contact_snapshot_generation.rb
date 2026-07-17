#!/usr/bin/env ruby
# frozen_string_literal: true

require "fileutils"
require "tmpdir"
require "yaml"
require_relative "generate_contact_snapshots"

def assert(condition, message)
  raise "FAIL: #{message}" unless condition
end

repo_root = File.expand_path("..", __dir__)
jeremy_path = File.join(repo_root, "config/profiles/jeremy_mcdonald.yaml")
expected_compliance = "Loan Factory, Inc., NMLS 320841. Jeremy McDonald, NMLS 1195266. Equal Housing Opportunity."

Dir.mktmpdir("contact-snapshot-tests") do |root|
  profiles = File.join(root, "profiles")
  output = File.join(root, "generated")
  FileUtils.mkdir_p(profiles)
  FileUtils.cp(jeremy_path, File.join(profiles, "jeremy_mcdonald.yaml"))

  ContactSnapshots.generate(profiles_dir: profiles, owner_profile_id: "jeremy_mcdonald", output_dir: output)
  files = %w[contact_profile.md compliance_identity.md call_to_action_library.md referral_routing.md]
  files.each { |name| assert(File.file?(File.join(output, name)), "#{name} was not generated") }
  combined = files.map { |name| File.read(File.join(output, name)) }.join("\n")
  assert(combined.include?("LO Development, AI & Marketing Consultant"), "Jeremy title missing")
  assert(combined.include?("Team Leader"), "Jeremy team role missing")
  assert(combined.include?("Loan Factory, Inc."), "company name missing")
  assert(combined.include?("(904) 442-3213"), "Jeremy phone missing")
  assert(combined.include?("jeremy@mcdonald-mtg.com"), "Jeremy email missing")
  assert(combined.include?("https://www.mcdonald-mtg.com"), "Jeremy website missing")
  assert(combined.include?("https://www.legendsmortgage.team"), "team website missing")
  assert(combined.include?("https://www.loanfactory.com/jeremymcdonald"), "approved Apply Now URL missing")
  assert(File.read(File.join(output, "compliance_identity.md")).include?(expected_compliance), "approved compliance line missing")
  assert(!combined.match?(/NMLS\s*#/i), "NMLS hash format found")

  realtor = {
    "profile_id" => "casey_realtor", "profile_type" => "realtor", "full_name" => "Casey Realtor",
    "professional_title" => "REALTOR", "brokerage_name" => "Example Realty", "license_number" => "TEST-100",
    "mobile" => "(555) 010-1000", "email" => "casey@example.invalid", "website" => "https://example.invalid",
    "service_area" => "Test market", "brand_voice" => "Helpful and direct",
    "assigned_lending_partner_profile_id" => "jeremy_mcdonald", "active" => true
  }
  File.write(File.join(profiles, "casey_realtor.yaml"), realtor.to_yaml)
  ContactSnapshots.generate(profiles_dir: profiles, owner_profile_id: "casey_realtor", output_dir: output)
  routing = File.read(File.join(output, "referral_routing.md"))
  contact = File.read(File.join(output, "contact_profile.md"))
  assert(contact.include?("Casey Realtor") && contact.include?("Jeremy McDonald"), "Realtor and assigned lender identities missing")
  assert(routing.include?("Your information will be sent securely to Jeremy McDonald with Loan Factory, Inc. so they can respond to your mortgage request. Would you like me to submit it?"), "resolved consent prompt missing")

  before = files.to_h { |name| [name, File.read(File.join(output, name))] }
  lender = YAML.safe_load(File.read(File.join(profiles, "jeremy_mcdonald.yaml")), permitted_classes: [], permitted_symbols: [], aliases: false)
  lender["full_name"] = "Updated Test Lender"
  lender["mobile"] = "(555) 010-9999"
  lender["apply_now_url"] = "https://updated.example.invalid/apply"
  File.write(File.join(profiles, "jeremy_mcdonald.yaml"), lender.to_yaml)
  ContactSnapshots.generate(profiles_dir: profiles, owner_profile_id: "casey_realtor", output_dir: output)
  files.each do |name|
    updated = File.read(File.join(output, name))
    assert(updated != before[name], "#{name} did not regenerate after one profile update")
    assert(updated.include?("Updated Test Lender"), "#{name} does not contain the updated lender")
  end
  assert(File.read(File.join(output, "referral_routing.md")).include?("https://updated.example.invalid/apply"), "updated Apply Now URL did not propagate")

  broken = realtor.merge("profile_id" => "broken_realtor", "assigned_lending_partner_profile_id" => "missing_lender")
  File.write(File.join(profiles, "broken_realtor.yaml"), broken.to_yaml)
  begin
    ContactSnapshots.generate(profiles_dir: profiles, owner_profile_id: "broken_realtor", output_dir: output)
    raise "FAIL: Realtor without an assigned lender was accepted"
  rescue RuntimeError => error
    raise if error.message.start_with?("FAIL:")
    assert(error.message.include?("Assigned lending partner profile not found"), "unexpected missing-lender error")
  end
end

puts "PASS: contact snapshot generation and routing"
