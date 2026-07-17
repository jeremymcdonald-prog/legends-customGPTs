#!/usr/bin/env ruby
# frozen_string_literal: true

require "yaml"

def load_yaml(path)
  YAML.safe_load(File.read(path), permitted_classes: [], permitted_symbols: [], aliases: false)
end

def assert(condition, message)
  raise "FAIL: #{message}" unless condition
end

root = File.expand_path("..", __dir__)
engine = load_yaml(File.join(root, "core/lead_capture/lead_capture_engine.yaml"))
openapi = load_yaml(File.join(root, "core/lead_capture/openapi.yaml"))
operation = openapi.fetch("paths").fetch("/v1/mortgage-leads").fetch("post")
request_schema = openapi.fetch("components").fetch("schemas").fetch("MortgageLeadRequest")
response_schema = openapi.fetch("components").fetch("schemas").fetch("MortgageLeadResponse")

expected_required = %w[first_name last_name email phone preferred_contact_method inquiry_type buy_or_refinance property_state estimated_timeframe message source_gpt_id owner_profile_id assigned_lending_partner_profile_id consent_to_contact consent_timestamp]
expected_response = %w[success lead_id assigned_loan_officer_name next_step apply_now_url contact_phone contact_email]

assert(engine.fetch("deployed") == false, "lead-capture contract must remain non-deployed")
assert(operation.fetch("operationId") == engine.fetch("operation_id"), "operationId differs from Lead Capture Engine")
assert(request_schema.fetch("required") == expected_required, "required lead fields changed")
assert(request_schema.fetch("additionalProperties") == false, "unknown lead fields must be rejected")
assert(request_schema.fetch("properties").fetch("consent_to_contact").fetch("const") == true, "affirmative consent is not enforced")
assert((engine.fetch("prohibited_fields") & request_schema.fetch("properties").keys).empty?, "OpenAPI exposes a prohibited field")
assert(response_schema.fetch("required") == expected_response, "required lead response fields changed")
assert(engine.fetch("behaviors").length == 10, "Lead Capture Engine must retain ten behaviors")

test_cases = File.read(File.join(root, "core/lead_capture/TEST_CASES.md")).scan(/^\| LC-\d{2} /).length
assert(test_cases == 15, "Lead Capture Engine must retain fifteen contract cases")

puts "PASS: non-deployed lead-capture OpenAPI, consent, fields, response, and contract cases"
