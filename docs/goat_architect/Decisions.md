# Decisions

## D-001 — Preserve the existing remote history

- **Decision:** Clone the populated `main` branch and build on its initial commit.
- **Reason:** The repository already existed and must not be overwritten.

## D-002 — Review first-party business Markdown; exclude vendored code

- **Decision:** Treat Legends, mortgage, real estate, marketing, GPT, persona, workflow, and first-party architecture Markdown as in scope. Exclude dependency docs, unpacked third-party repositories, and external reference repositories from the copied corpus.
- **Reason:** The workspace contains thousands of third-party Markdown files that do not inform the GPT portfolio.

## D-003 — Preserve approved source variants without borrower data

- **Decision:** Review all 658 in-scope Markdown files, copy 657 under their original relative paths, and document exact duplicates instead of silently choosing a winner. Exclude the pipeline reconciliation report from Git because it contains borrower-identifiable operational history.
- **Reason:** Several Realtor and GPT-pack directories are versions or exports with meaningful provenance, but source preservation does not justify committing borrower data.

## D-004 — Internal-first launch policy

- **Decision:** Build internal and partner-facing GPTs before public consumer assistants.
- **Reason:** They deliver faster value with lower consumer and data risk.

## D-005 — Equal-weight opportunity model

- **Decision:** Score 15 factors from 1–10 and total them out of 150. Difficulty, live-data need, and compliance risk are scored inversely so 10 is always favorable.
- **Reason:** A simple consistent total is auditable and avoids rewarding risk or complexity.

## D-006 — One package standard

- **Decision:** All future GPTs use the structure in `Architecture.md`, semantic versioning, shared knowledge, and recorded tests.
- **Reason:** Consistency lowers maintenance cost and prevents prompt-only orphan systems.

## D-007 — Centralized contact profiles, assigned-lender routing, and consented lead handoff

- **Decision:** Contact and lending partner data will use centralized profile files with generated GPT specific snapshots. Realtor GPTs will route mortgage opportunities to an assigned licensed Legends Mortgage Team loan officer. Lead submission will require explicit consumer consent and a secure external Action endpoint.
- **Reason:** A single source prevents conflicting identity and Apply Now values, preserves Realtor ownership of real-estate relationships, makes the licensed mortgage recipient visible, and keeps lead intake within a reviewable privacy and security boundary.

## D-008 — Destination-neutral lead-capture facade

- **Decision:** Define the `submitMortgageLead` contract and launch gates without deploying an endpoint or selecting a CRM. A future implementation will use a small authenticated API/serverless facade with a replaceable approved destination adapter.
- **Reason:** The reviewed sources reference multiple downstream systems and do not establish one current system of record. The routing, consent, validation, and audit boundary can be governed before that operational decision.

## D-009 — Core-first GPT Factory

- **Decision:** Every future GPT inherits identity, audience, compliance, conversation, routing, Action policy, CTA, lead capture, shared knowledge rules, shared tests, and templates from canonical `core/` modules.
- **Reason:** Package-local copies create drift and make portfolio-wide updates unsafe. One build graph makes change propagation testable.

## D-010 — Generated packages with dependency fingerprints

- **Decision:** Authorized packages are produced by a deterministic builder, and every build records SHA-256 hashes of all selected core modules and profiles.
- **Reason:** Generated snapshots are necessary for platform upload and reproducibility, while dependency hashes prove exactly what a package inherited and when a rebuild is required.

## D-011 — Audience Engine as a required manifest dimension

- **Decision:** Every blueprint selects exactly one of nine canonical audiences. Mixed contexts inherit the strictest active boundary until clarified.
- **Reason:** Tone, privacy, Actions, disclosures, routing, CTA, and response style are behavioral controls, not optional copywriting preferences.

## D-012 — Platform-neutral core and replaceable exporters

- **Decision:** Platform differences live only in `exporters/`; core modules and blueprints remain portable.
- **Reason:** New assistant platforms should require an adapter, not a fork of regulated business logic.
