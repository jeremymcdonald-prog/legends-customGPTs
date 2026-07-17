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
