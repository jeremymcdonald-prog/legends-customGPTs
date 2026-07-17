# Product requirements document

## Product

The Legends GPT Factory generates governed assistant packages from centralized modules and approved blueprints. It serves Jeremy, Legends team roles, loan officers, Realtor/referral partners, recruits, vendors, marketers, executives, consumers, and future business units.

## Functional requirements

1. Maintain one approved person/profile source and one source for each shared behavior class.
2. Support nine audience profiles that determine tone, starters, CTA behavior, routing, compliance reminders, Actions, privacy, disclosures, and response style.
3. Inherit one compliance engine and checklist covering mortgage advertising, RESPA, Fair Housing, Equal Housing, licensing, NMLS, rates, guarantees, AI disclosure, privacy, consent, prohibited statements, and escalation.
4. Inherit a complete conversation lifecycle and 18 reusable CTAs.
5. Resolve Jeremy, loan-officer, Realtor, and team-shared routing with required active profile validation.
6. Keep lead capture non-deployed, minimum-data, explicit-consent, server-validated, privacy-gated, and reusable.
7. Generate the standard package and all identity/audience/compliance/routing/CTA snapshots without hand duplication.
8. Record dependency hashes so shared changes are detectable and reproducible.
9. Isolate OpenAI, Claude, Gemini, Copilot, Open WebUI, AnythingLLM, OpenHands, and local-assistant differences in exporters.
10. Preserve raw source material as research and allow only registered approved knowledge into packages.

## Safety requirements

- No unsupported mortgage, rate, payment, savings, approval, qualification, licensing, guarantee, legal, tax, appraisal, underwriting, or compliance claim.
- No public access to borrower records, internal pipeline data, pricing, internal guidelines, or unapproved tools.
- No secrets in blueprints, core modules, generated packages, schemas, examples, or documentation.
- No sensitive application intake in chat; full applications use the resolved secure approved path.
- Consequential writes or sends require authenticated least privilege, server validation, audit, idempotency, and explicit human confirmation.

## Acceptance criteria

1. Every required core module and README exists and parses.
2. Blueprint and manifest schemas validate allowed audiences, owner types, routing, privacy, compliance, Apply Now, and platforms.
3. The temporary synthetic factory build produces every required file and directory.
4. Profile, audience, routing, CTA, compliance, conversation, and lead-capture inheritance tests pass.
5. Changing one core module changes the dependency fingerprint and regenerated output.
6. Canonical profile values, CTA libraries, compliance checklists, routing engines, consent prompts, and OpenAPI contracts are not duplicated in authored runtime files.
7. Markdown links, secret scans, YAML/JSON/OpenAPI parsing, whitespace, Git state, and remote synchronization pass.
8. No individual GPT is created by this refactor.
