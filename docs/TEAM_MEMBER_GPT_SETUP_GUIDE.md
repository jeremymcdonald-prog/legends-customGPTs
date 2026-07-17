# Team member GPT setup guide

**Owner:** GOAT Architect
**Effective:** 2026-07-17

Use this workflow to create an owned or Realtor-partner GPT without duplicating contact data.

1. Duplicate the appropriate YAML file from `config/templates/` into `config/profiles/<profile_id>.yaml`.
2. Fill it with approved professional, licensing, contact, and website information.
3. Validate every required field, HTTPS URL, NMLS value, active flag, and approved public contact method.
4. Select the GPT package and copy `gpts/templates/manifest.template.md` into it as `manifest.md`.
5. Set `owner_profile_id` to the active profile that owns the GPT.
6. For a Realtor GPT, set `assigned_lending_partner_profile_id` to an active licensed Legends Mortgage Team loan officer profile.
7. Generate `contact_profile.md`, `compliance_identity.md`, `call_to_action_library.md`, and `referral_routing.md` into the package's `generated/` directory.
8. Verify the resolved Apply Now behavior and URL against the assigned licensed lender's approved profile.
9. Run `ruby scripts/test_contact_snapshot_generation.rb` and the package's contact/routing test conversations.
10. Package the generated snapshots with the final approved knowledge, record the version, and complete compliance and launch review.

Never ask Jeremy or a team member to edit the same contact, compliance, CTA, or routing detail in multiple documents manually. Change one source YAML profile, regenerate every dependent snapshot, review the diff, and rerun the tests.

For team-shared packages, select an active assigned loan officer or approved team routing endpoint before enabling mortgage routing. Do not launch public lead capture until the Action endpoint, public privacy policy, security controls, and compliance review are complete.
