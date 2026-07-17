# Team member GPT setup guide

**Owner:** GOAT Architect
**Effective:** 2026-07-17

1. Copy the appropriate profile template from `config/templates/` and fill it with approved information once.
2. Validate the profile and keep it inactive until its contact, licensing, websites, and role are approved.
3. Copy `core/templates/gpt_blueprint.template.yaml` to an approved working location.
4. Define the bounded purpose, scope, output contract, platform, capabilities, Actions, and shared-knowledge selections.
5. Select the owner type, active owner profile, and one of the nine Audience Engine labels.
6. For a Realtor or applicable team-shared GPT, select the required active licensed lending partner by profile ID.
7. Select routing, compliance, privacy, lead-capture, and Apply Now behavior without copying their underlying rules.
8. Run `ruby scripts/validate_gpt_factory.rb`, then generate the authorized package with `scripts/build_gpt_package.rb`.
9. Review generated contact, compliance, CTA, audience, referral, platform, and dependency snapshots; run shared and package-specific tests.
10. Complete business, knowledge, security, privacy, compliance, and launch review before publishing.

Never ask Jeremy or a team member to edit identity, compliance, routing, CTA, conversation, or lead-capture content in multiple documents. Change the single canonical profile or core module, regenerate dependent packages, and review the resulting build fingerprint and diff.

See `docs/GPT_FACTORY_BUILD_PROCESS.md` for the full workflow and `CORE_MODULE_DEPENDENCY_MAP.md` for inheritance order.
