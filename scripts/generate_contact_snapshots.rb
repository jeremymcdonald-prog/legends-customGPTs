#!/usr/bin/env ruby
# frozen_string_literal: true

require "fileutils"
require "optparse"
require "tmpdir"
require "yaml"

module ContactSnapshots
  GENERATED_NOTICE = "<!-- GENERATED FILE — DO NOT EDIT. Update the source YAML profile and regenerate. -->"
  LENDER_TYPES = %w[team_leader loan_officer].freeze
  REALTOR_FIELDS = %w[profile_id profile_type full_name professional_title brokerage_name license_number mobile email website service_area brand_voice assigned_lending_partner_profile_id active].freeze
  LENDER_FIELDS = %w[profile_id profile_type full_name professional_title team_role team_name company_name mobile email personal_website team_website individual_nmls company_nmls apply_now_url equal_housing_required active].freeze
  SENSITIVE_ITEMS = "Social Security numbers, bank account numbers, credit card numbers, passwords, full dates of birth, tax returns, bank statements, government IDs, or uploaded financial documents"

  module_function

  def load_profile(path)
    profile = YAML.safe_load(File.read(path), permitted_classes: [], permitted_symbols: [], aliases: false)
    raise "Profile must be a YAML mapping: #{path}" unless profile.is_a?(Hash)

    profile.transform_keys(&:to_s)
  end

  def validate_profile!(profile)
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
  end

  def resolve(profiles_dir:, owner_profile_id:, assigned_lending_partner_profile_id: nil)
    owner_path = File.join(profiles_dir, "#{owner_profile_id}.yaml")
    raise "Owner profile not found: #{owner_path}" unless File.file?(owner_path)

    owner = load_profile(owner_path)
    validate_profile!(owner)
    raise "Profile ID does not match filename" unless owner["profile_id"] == owner_profile_id

    partner_id = if owner["profile_type"] == "realtor"
                   owner["assigned_lending_partner_profile_id"]
                 else
                   assigned_lending_partner_profile_id
                 end
    lender = owner
    if partner_id
      partner_path = File.join(profiles_dir, "#{partner_id}.yaml")
      raise "Assigned lending partner profile not found: #{partner_path}" unless File.file?(partner_path)

      lender = load_profile(partner_path)
      validate_profile!(lender)
      raise "Assigned lending partner must be a lending profile" unless LENDER_TYPES.include?(lender["profile_type"])
      raise "Assigned lending partner profile ID does not match filename" unless lender["profile_id"] == partner_id
    elsif owner["profile_type"] == "realtor"
      raise "Realtor profiles require assigned_lending_partner_profile_id"
    end

    [owner, lender]
  end

  def compliance_line(lender)
    "#{lender['company_name']}, NMLS #{lender['company_nmls']}. #{lender['full_name']}, NMLS #{lender['individual_nmls']}. Equal Housing Opportunity."
  end

  def consent_prompt(lender)
    "Your information will be sent securely to #{lender['full_name']} with #{lender['company_name']} so they can respond to your mortgage request. Would you like me to submit it?"
  end

  def render_contact(owner, lender)
    owner_lines = if owner["profile_type"] == "realtor"
                    [owner["full_name"], owner["professional_title"], owner["brokerage_name"], owner["mobile"], owner["email"], owner["website"], "License: #{owner['license_number']}"]
                  else
                    [owner["full_name"], owner["professional_title"], owner["team_role"], owner["team_name"], owner["company_name"], owner["mobile"], owner["email"], owner["personal_website"], owner["team_website"]]
                  end
    <<~MARKDOWN
      #{GENERATED_NOTICE}
      # Contact profile

      ## GPT owner

      #{owner_lines.map { |line| "- #{line}" }.join("\n")}

      ## Licensed mortgage contact

      - #{lender['full_name']}
      - #{lender['professional_title']}
      - #{lender['team_role']}, #{lender['team_name']}
      - #{lender['company_name']}
      - #{lender['mobile']}
      - #{lender['email']}
      - #{lender['personal_website']}
      - #{lender['team_website']}
      - Apply Now: #{lender['apply_now_url']}
    MARKDOWN
  end

  def render_compliance(lender)
    <<~MARKDOWN
      #{GENERATED_NOTICE}
      # Compliance identity

      #{compliance_line(lender)}

      Use this approved identity for applicable consumer-facing mortgage content. Do not add a `#` before either NMLS number.
    MARKDOWN
  end

  def render_ctas(owner, lender)
    realtor = owner["profile_type"] == "realtor" ? owner["full_name"] : "the consumer's real estate professional"
    <<~MARKDOWN
      #{GENERATED_NOTICE}
      # Call-to-action library

      ## General consultation
      For mortgage guidance, contact #{lender['full_name']} with #{lender['company_name']} at #{lender['mobile']} or #{lender['email']}.

      ## Apply Now
      When you are ready to complete a secure mortgage application, use #{lender['apply_now_url']}. Do not provide sensitive application information in this chat.

      ## First-time buyer
      First-time buyer questions are welcome. #{lender['full_name']} can explain possible next steps without promising eligibility or approval: #{lender['mobile']} | #{lender['email']}.

      ## Refinance
      To review a refinance goal and the facts that matter, contact #{lender['full_name']} at #{lender['mobile']} or #{lender['email']}.

      ## Investment property
      For an investment-property mortgage conversation, contact #{lender['full_name']}. Program availability and terms require current human review.

      ## Realtor co-marketing
      Real estate guidance remains with #{realtor}. For mortgage and preapproval questions, use #{lender['full_name']} with #{lender['company_name']}

      ## Open house
      For property questions, contact #{realtor}. For financing or payment questions, contact #{lender['full_name']} at #{lender['mobile']}.

      ## Payment scenario
      #{lender['full_name']} can review a payment scenario using current, verified assumptions. Any estimate is educational until reviewed through the official lending process.

      ## Late-night inquiry
      Your question can be saved for follow-up, but it will not be submitted without your explicit consent. You may also contact #{lender['full_name']} at #{lender['email']}.

      ## Action failure
      The request was not submitted. Contact #{lender['full_name']} directly at #{lender['mobile']} or #{lender['email']}, or use the secure Apply Now link: #{lender['apply_now_url']}.
    MARKDOWN
  end

  def render_routing(owner, lender)
    <<~MARKDOWN
      #{GENERATED_NOTICE}
      # Referral routing

      - Owner profile: `#{owner['profile_id']}` (#{owner['profile_type']})
      - Assigned licensed lender: `#{lender['profile_id']}` — #{lender['full_name']}, #{lender['company_name']}
      - Mortgage questions, financing, preapproval, payment scenarios, Apply Now requests, and mortgage leads route to the assigned licensed lender.
      - Apply Now: #{lender['apply_now_url']}

      Before any lead submission, display this exact resolved prompt and wait for a clear affirmative response:

      > #{consent_prompt(lender)}

      Never request or submit #{SENSITIVE_ITEMS}. A lead submission is not an application, preapproval, approval, rate lock, or lending commitment.

      If the Action fails, state that the request was not submitted and provide #{lender['full_name']} at #{lender['mobile']}, #{lender['email']}, and #{lender['apply_now_url']}.
    MARKDOWN
  end

  def generate(profiles_dir:, owner_profile_id:, output_dir:, assigned_lending_partner_profile_id: nil)
    owner, lender = resolve(
      profiles_dir: profiles_dir,
      owner_profile_id: owner_profile_id,
      assigned_lending_partner_profile_id: assigned_lending_partner_profile_id
    )
    documents = {
      "contact_profile.md" => render_contact(owner, lender),
      "compliance_identity.md" => render_compliance(lender),
      "call_to_action_library.md" => render_ctas(owner, lender),
      "referral_routing.md" => render_routing(owner, lender)
    }

    FileUtils.mkdir_p(output_dir)
    Dir.mktmpdir("contact-snapshots") do |temporary|
      documents.each { |name, content| File.write(File.join(temporary, name), content) }
      documents.each_key { |name| FileUtils.mv(File.join(temporary, name), File.join(output_dir, name), force: true) }
    end
  end
end

if $PROGRAM_NAME == __FILE__
  options = { profiles_dir: File.expand_path("../config/profiles", __dir__) }
  parser = OptionParser.new do |opts|
    opts.banner = "Usage: generate_contact_snapshots.rb --owner-profile ID --output-dir PATH [options]"
    opts.on("--owner-profile ID", "Active owner profile ID") { |value| options[:owner_profile_id] = value }
    opts.on("--profiles-dir PATH", "Directory containing profile YAML files") { |value| options[:profiles_dir] = value }
    opts.on("--output-dir PATH", "Target gpts/<slug>/generated directory") { |value| options[:output_dir] = value }
    opts.on("--assigned-lending-partner-profile-id ID", "Assigned lender for a team-shared package") { |value| options[:assigned_lending_partner_profile_id] = value }
  end
  parser.parse!
  parser.abort("Missing --owner-profile") unless options[:owner_profile_id]
  parser.abort("Missing --output-dir") unless options[:output_dir]

  ContactSnapshots.generate(**options)
  puts "Generated contact snapshots in #{options[:output_dir]}"
end
