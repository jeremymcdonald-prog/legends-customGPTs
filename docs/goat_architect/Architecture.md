# Architecture

## Repository layers

1. `source_material/` — immutable research snapshots and source mapping.
2. `knowledge/` — curated, approved, reusable knowledge with ownership and review dates.
3. `gpts/` — self-contained GPT packages built from shared standards and approved knowledge.
4. `actions/` — reusable schemas and examples; implementations and secrets live in their owning systems.
5. `docs/` — portfolio memory, decisions, research, validation, and launch governance.

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
- `changelog.md`: dated semantic-version history.

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
