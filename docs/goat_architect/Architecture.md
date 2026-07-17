# Architecture

## Repository layers

1. `source_material/` — immutable research snapshots and source mapping.
2. `knowledge/` — curated, approved, reusable knowledge with ownership and review dates.
3. `gpts/` — self-contained GPT packages built from shared standards and approved knowledge.
4. `actions/` — reusable schemas and examples; implementations and secrets live in their owning systems.
5. `docs/` — portfolio memory, decisions, research, validation, and launch governance.
6. `config/` — centralized non-secret professional profiles and reusable profile templates.
7. `scripts/` — deterministic local generators and validation tests; no production credentials or endpoint implementations.

## Standard GPT package

```text
gpts/<gpt-slug>/
  README.md
  manifest.md
  instructions.md
  description.md
  conversation_starters.md
  knowledge/
  actions/
  tests/
  examples/
  compliance/
  generated/
  changelog.md
```

### Required responsibilities

- `README.md`: business outcome, owner, audience, status, setup, limitations.
- `manifest.md`: version, classification, capabilities, model assumptions, knowledge and Action inventory.
- `instructions.md`: role, scope, workflow, output contract, source rules, refusals, and handoffs.
- `description.md`: builder name and short description.
- `conversation_starters.md`: four concrete tasks that produce deliverables.
- `knowledge/`: package snapshots or references with provenance and review dates.
- `actions/`: package-specific schemas, auth model, data classification, and failure behavior.
- `tests/`: test matrix, prompts, expected outcomes, and recorded results.
- `examples/`: approved sample inputs/outputs with no PII.
- `compliance/`: risk assessment, required disclosures, review workflow, and launch sign-off.
- `generated/`: contact, compliance identity, CTA, and referral-routing snapshots produced from centralized profiles; never hand-edited.
- `changelog.md`: dated semantic-version history.

## Contact profile and referral architecture

`config/profiles/*.yaml` is the source of truth for professional identity, approved public contact information, licensing identifiers, application URLs, and Realtor-to-lender assignment. A package manifest declares:

- `owner_type`: `jeremy`, `loan_officer`, `realtor`, or `team_shared`;
- `owner_profile_id` and, where required, `assigned_lending_partner_profile_id`;
- `audience_type`, mortgage-routing and lead-capture flags, public/internal classification, compliance level, privacy-policy requirement, and Apply Now behavior.

`scripts/generate_contact_snapshots.rb` resolves active profiles into `generated/contact_profile.md`, `generated/compliance_identity.md`, `generated/call_to_action_library.md`, and `generated/referral_routing.md`. Realtor packages keep the Realtor visible for real-estate matters and route mortgage opportunities to the assigned active licensed lending profile. Team-shared mortgage routing requires an active selected loan officer or approved routing endpoint.

## Audience boundaries

| Class | Allowed | Prohibited |
|---|---|---|
| Internal | Operational drafting and authenticated least-privilege Actions | Unapproved autonomous sends, invented facts, unnecessary PII retention |
| Partner-facing | Co-marketing drafts, outreach, training, brand tools | Borrower records, pricing systems, referral-exchange language |
| Public consumer | General education, safe intake, licensed human handoff | Eligibility decisions, official quotes, underwriting, personalized legal/tax/credit advice, internal data |

## Knowledge lifecycle

`raw source -> reviewed candidate -> approved shared/domain knowledge -> package snapshot -> test -> launch -> scheduled review -> supersede/archive`

Every approved knowledge document records owner, source, effective date, last reviewed date, next review date, applicable jurisdictions, and replacement path. If volatile knowledge is stale, the GPT must avoid the claim and hand off.

## Action boundary

The GPT is a client, never the secret holder. Actions terminate at an authenticated server that validates the user, scope, payload, and approval state. Reads return only necessary fields. Writes and sends are audited and, when consequential, require explicit human confirmation.

The planned `submitMortgageLead` Action collects only approved low-risk inquiry fields. Before a call, the GPT identifies the receiving licensed professional and obtains explicit affirmative consumer consent. The server revalidates the GPT manifest, active profile IDs, assignment, consent, field allowlist, and idempotency. Full application data and documents remain outside chat and use the assigned lender's approved Apply Now URL. A public lead Action cannot launch without a valid public privacy policy and completed security, privacy, compliance, and operational review.
