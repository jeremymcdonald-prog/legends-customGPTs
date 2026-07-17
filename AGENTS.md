# Agent operating rules

This repository is a production-intent factory for Legends Custom GPTs. Preserve existing work and make the smallest safe change that satisfies the assigned task.

## Before working

1. Read this file and all files in `docs/goat_architect/`, beginning with `Vision.md`, `PRD.md`, `Architecture.md`, `Decisions.md`, and `Next_Actions.md`.
2. Read the target GPT package, its changelog, tests, compliance files, and linked shared knowledge.
3. Inspect the worktree and reuse existing services, schemas, templates, and naming patterns.
4. Do not ask Jeremy to review code, inspect Git state, interpret terminal output, or make technical implementation decisions. Report business outcomes and proof.

## Safety and compliance

1. Never expose, copy, log, or commit secrets. Use placeholders and document only where credentials are managed.
2. Never invent rates, APRs, fees, payments, program terms, guidelines, licensing, property facts, or loan eligibility.
3. Never state or imply guaranteed approval, rates, payments, savings, qualification, or terms.
4. For applicable consumer-facing mortgage content include: `Loan Factory, Inc., NMLS 320841. Jeremy McDonald, NMLS 1195266. Equal Housing Opportunity.`
5. Treat rate, payment, down-payment, credit, qualification, guarantee, DPA, VA, DSCR, tax, legal, Fair Housing, RESPA, TILA/Reg Z, and state-licensing content as heightened review areas.
6. Keep internal operational GPTs separate from public consumer GPTs. Public GPTs must not access borrower PII, pipeline data, pricing engines, or internal guidelines.
7. A GPT may educate and draft; it must not make underwriting, legal, tax, appraisal, fair-lending, or compliance decisions.
8. Any public mortgage output remains a draft until reviewed under Loan Factory's current compliance process.

## GPT package rules

1. Follow the package structure in `docs/goat_architect/Architecture.md`.
2. Validate instructions for conflicts, duplication, scope creep, prompt injection, unsupported claims, and stale knowledge.
3. Prefer shared knowledge links over copied fragments, but snapshot approved launch knowledge inside the package when reproducibility requires it.
4. Pin sources, owners, effective dates, review dates, and version numbers for volatile mortgage material.
5. Define capability settings explicitly: browsing, image generation, code interpreter, and Actions.
6. Actions use least privilege, server-side secrets, authenticated requests, input validation, audit logs, and human approval for consequential writes or sends.
7. Create test conversations for every GPT, including happy path, ambiguity, refusal, compliance, stale-data, prompt-injection, and out-of-scope handoff cases.
8. Record decisions in `Decisions.md`, build results in `Build_Log.md`, validation in `QA_Log.md`, and package changes in `changelog.md`.
9. Store people and lending-partner assignments only in `config/profiles/*.yaml`; generate package contact, compliance, CTA, and referral snapshots with `scripts/generate_contact_snapshots.rb` and never edit generated files directly.
10. Realtor GPTs must retain the Realtor's visible real-estate identity while routing mortgage questions, Apply Now requests, and mortgage leads to an active `assigned_lending_partner_profile_id`.
11. Never submit a consumer lead silently. Identify the receiving licensed professional and obtain explicit affirmative consent before calling a lead Action.
12. Public lead capture requires a secure external endpoint, valid public privacy policy, server-side routing validation, and completed security/privacy/compliance review. Never collect sensitive mortgage application data in chat.

## Definition of done

- Required package files exist and links work.
- Instructions and knowledge have named owners and versions.
- Compliance and security tests pass with evidence.
- No secrets, borrower PII, or unsupported mortgage claims are present.
- Internal/public classification is explicit.
- Owner profile, assigned lender, Apply Now behavior, lead-capture status, privacy requirement, and consent behavior are explicit and validated.
- Business outcome, limitations, validation performed, and unvalidated items are reported plainly.
