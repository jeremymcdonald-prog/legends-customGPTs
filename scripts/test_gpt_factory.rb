#!/usr/bin/env ruby
# frozen_string_literal: true

require "digest"
require "fileutils"
require "tmpdir"
require "yaml"
require_relative "factory_support"
require_relative "rebuild_all_gpts"

def assert(condition, message)
  raise "FAIL: #{message}" unless condition
end

def write_yaml(path, value)
  File.write(path, value.to_yaml)
end

def tree_digest(path)
  files = Dir[File.join(path, "**/*")].select { |item| File.file?(item) }.sort
  Digest::SHA256.hexdigest(files.map { |item| "#{item.delete_prefix("#{path}/")}:#{Digest::SHA256.file(item).hexdigest}" }.join("\n"))
end

root = LegendsFactory::REPO_ROOT
core = File.join(root, "core")
structure = LegendsFactory.load_yaml(File.join(core, "templates/package_structure.yaml"))

Dir.mktmpdir("legends-factory-tests") do |temporary|
  profiles = File.join(temporary, "profiles")
  output = File.join(temporary, "output")
  FileUtils.mkdir_p(profiles)
  lender = {
    "profile_id" => "factory_test_lender", "profile_type" => "loan_officer", "full_name" => "Factory Test Lender",
    "professional_title" => "Loan Officer", "team_role" => "Test Role", "team_name" => "Test Team",
    "company_name" => "Test Company", "mobile" => "(555) 010-2020", "email" => "lender@example.invalid",
    "personal_website" => "https://person.example.invalid", "team_website" => "https://team.example.invalid",
    "individual_nmls" => "100001", "company_nmls" => "200002", "apply_now_url" => "https://apply.example.invalid",
    "equal_housing_required" => true, "active" => true
  }
  realtor = {
    "profile_id" => "factory_test_realtor", "profile_type" => "realtor", "full_name" => "Factory Test Realtor",
    "professional_title" => "REALTOR", "brokerage_name" => "Test Brokerage", "license_number" => "TEST-300",
    "mobile" => "(555) 010-3030", "email" => "realtor@example.invalid", "website" => "https://realtor.example.invalid",
    "service_area" => "Test market", "brand_voice" => "Helpful", "assigned_lending_partner_profile_id" => lender.fetch("profile_id"), "active" => true
  }
  write_yaml(File.join(profiles, "#{lender.fetch('profile_id')}.yaml"), lender)
  write_yaml(File.join(profiles, "#{realtor.fetch('profile_id')}.yaml"), realtor)
  blueprint = {
    "gpt_id" => "factory-test", "slug" => "factory-test", "name" => "Factory Test Package", "version" => "0.1.0", "status" => "planned",
    "purpose" => "Prove deterministic factory composition without creating a production GPT.", "scope" => ["Synthetic validation only"],
    "output_contract" => ["A temporary package"], "owner_type" => "realtor", "owner_profile_id" => realtor.fetch("profile_id"),
    "audience" => "Consumer", "assigned_lending_partner_profile_id" => lender.fetch("profile_id"), "mortgage_routing_enabled" => true,
    "lead_capture_enabled" => true, "public_or_internal" => "public", "compliance_level" => "heightened", "privacy_policy_required" => true,
    "apply_now_behavior" => "show_assigned_lender_link", "capabilities" => { "browsing" => false, "image_generation" => false, "code_interpreter" => false },
    "actions" => ["submitMortgageLead"], "knowledge_folders" => [], "conversation_starters" => [], "platform" => "openai_gpts"
  }
  blueprint_path = File.join(temporary, "blueprint.yaml")
  write_yaml(blueprint_path, blueprint)

  registry = File.join(temporary, "blueprints")
  registry_output = File.join(temporary, "registry-output")
  FileUtils.mkdir_p(registry)
  FileUtils.cp(blueprint_path, File.join(registry, "factory-test.yaml"))
  registry_targets = FactoryRebuild.rebuild(blueprint_dir: registry, output_root: registry_output, profiles_dir: profiles, core_dir: core)
  assert(registry_targets.length == 1 && File.directory?(registry_targets.first), "blueprint registry did not rebuild every package")

  package = LegendsFactory.build(blueprint_path: blueprint_path, output_root: output, profiles_dir: profiles, core_dir: core)
  structure.fetch("required_files").each { |path| assert(File.file?(File.join(package, path)), "missing package file: #{path}") }
  structure.fetch("required_directories").each { |path| assert(File.directory?(File.join(package, path)), "missing package directory: #{path}") }
  structure.fetch("generated_snapshots").each { |path| assert(File.file?(File.join(package, path)), "missing generated snapshot: #{path}") }
  assert(File.file?(File.join(package, "actions/openapi.yaml")), "lead Action export missing")
  assert(File.read(File.join(package, "generated/contact_profile.md")).include?(realtor.fetch("full_name")), "owner identity missing")
  assert(File.read(File.join(package, "generated/referral_routing.md")).include?(lender.fetch("full_name")), "assigned lender routing missing")
  first_fingerprint = LegendsFactory.load_yaml(File.join(package, "generated/factory_dependencies.yaml")).fetch("build_fingerprint")
  first_tree_digest = tree_digest(package)
  rebuilt_same = LegendsFactory.build(blueprint_path: blueprint_path, output_root: output, profiles_dir: profiles, core_dir: core, force: true)
  assert(tree_digest(rebuilt_same) == first_tree_digest, "identical inputs did not produce a reproducible package")

  platforms = LegendsFactory.load_yaml(File.join(root, "exporters/platforms.yaml")).fetch("platforms")
  platforms.each do |platform_id, adapter|
    blueprint["platform"] = platform_id
    write_yaml(blueprint_path, blueprint)
    platform_package = LegendsFactory.build(blueprint_path: blueprint_path, output_root: output, profiles_dir: profiles, core_dir: core, force: true)
    export = File.read(File.join(platform_package, "generated/platform_export.md"))
    assert(export.include?(adapter.fetch("label")), "platform export missing for #{platform_id}")
  end
  blueprint["platform"] = "openai_gpts"
  write_yaml(blueprint_path, blueprint)

  copied_core = File.join(temporary, "core")
  FileUtils.cp_r(core, copied_core)
  conversations = LegendsFactory.load_yaml(File.join(copied_core, "conversation/conversation_engine.yaml"))
  conversations.fetch("stages")["closing"] = "UPDATED SHARED CLOSING"
  write_yaml(File.join(copied_core, "conversation/conversation_engine.yaml"), conversations)
  rebuilt = LegendsFactory.build(blueprint_path: blueprint_path, output_root: output, profiles_dir: profiles, core_dir: copied_core, force: true)
  second_fingerprint = LegendsFactory.load_yaml(File.join(rebuilt, "generated/factory_dependencies.yaml")).fetch("build_fingerprint")
  assert(first_fingerprint != second_fingerprint, "shared module update did not change the package fingerprint")

  invalid = blueprint.merge("privacy_policy_required" => false)
  invalid_path = File.join(temporary, "invalid.yaml")
  write_yaml(invalid_path, invalid)
  begin
    LegendsFactory.build(blueprint_path: invalid_path, output_root: output, profiles_dir: profiles, core_dir: core, force: true)
    raise "FAIL: public lead capture without privacy policy was accepted"
  rescue RuntimeError => error
    raise if error.message.start_with?("FAIL:")
    assert(error.message.include?("privacy policy"), "unexpected privacy validation error")
  end
end

puts "PASS: temporary Factory build, reproducibility, portfolio rebuild, inheritance, eight exporters, fingerprints, and launch gates"
