# Contact and referral routing standard

**Owner:** GOAT Architect
**Effective:** 2026-07-17

The executable source of truth is split deliberately:

- approved person data: `config/profiles/*.yaml`;
- identity inheritance and formatting: `core/identity/identity_pack.yaml`;
- owner, assigned-lender, and Apply Now selection: `core/routing/routing_rules.yaml`;
- consent, safe intake, fallback, privacy, security, mapping, and tests: `core/lead_capture/`;
- generated package snapshots: `gpts/<slug>/generated/`.

Do not restate these rules or values in GPT instructions. A package blueprint selects the owner and behavior, and `scripts/build_gpt_package.rb` validates the relationships before generating contact, compliance, CTA, and referral snapshots.

Realtor packages retain the Realtor's real-estate identity while the Routing Engine resolves regulated mortgage activity to the active assigned licensed lender. Team-shared routing fails closed without its required recipient. The Lead Capture Engine identifies the resolved recipient and requires affirmative consent before any submission.

Generated files are immutable build outputs. Change the profile, blueprint, or canonical core module and regenerate. Validate with:

```bash
ruby scripts/validate_gpt_factory.rb
ruby scripts/test_contact_snapshot_generation.rb
ruby scripts/test_gpt_factory.rb
```
