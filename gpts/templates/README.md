# Reusable GPT package template

Create `gpts/<gpt-slug>/` with the exact structure defined in `docs/goat_architect/Architecture.md`.

## Package header

Every package begins with:

- Owner and backup owner.
- Audience: `internal`, `partner`, or `public-consumer`.
- Status: `planned`, `draft`, `pilot`, `approved`, `deprecated`, or `archived`.
- Semantic version.
- One measurable business outcome.
- Data classification and prohibited data.
- Capability settings and Action list.
- Knowledge sources with owners and review dates.
- The required ownership, audience, assigned-lender, routing, lead-capture, privacy, compliance, and Apply Now fields from `manifest.template.md`.

## Generated contact and routing files

Create `generated/` in the package and populate it with `scripts/generate_contact_snapshots.rb`. It must contain `contact_profile.md`, `compliance_identity.md`, `call_to_action_library.md`, and `referral_routing.md`.

Never edit these outputs directly or duplicate contact details in package instructions. Update the centralized profile YAML, regenerate, inspect the diff, and run `scripts/test_contact_snapshot_generation.rb`. Realtor packages require an active assigned lending partner. Team-shared packages require an active selected loan officer or approved team routing endpoint before mortgage routing is enabled.

## Versioning

Use semantic versions: `MAJOR.MINOR.PATCH`.

- MAJOR: scope, audience, risk boundary, or Action behavior changes.
- MINOR: backward-compatible capability, knowledge, workflow, or test additions.
- PATCH: wording, examples, metadata, or non-behavioral fixes.

Tag approved releases as `<gpt-slug>-vX.Y.Z`. Record every change in the package `changelog.md` and include the tested knowledge snapshot version.
