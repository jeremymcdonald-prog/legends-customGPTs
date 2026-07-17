# Product requirements document

## Target users

- Jeremy McDonald as portfolio owner and executive user.
- Legends Mortgage Team loan officers, processors, coordinators, marketers, and recruiters.
- Realtor and referral partners using approved partner-facing assistants.
- Mortgage consumers using tightly bounded educational assistants.

## Repository goals

1. Provide one governed home for GPT instructions, knowledge, Actions, tests, compliance, examples, and changelogs.
2. Consolidate overlapping concepts into fewer assistants with clear jobs.
3. Separate internal, partner-facing, and public-consumer risk boundaries.
4. Reuse shared brand, compliance, licensing, glossary, and handoff knowledge.
5. Make every launch reproducible, testable, reversible, and maintainable.
6. Maintain contact, compliance identity, application links, and referral assignments once in centralized profiles, then generate package-specific snapshots.
7. Route Realtor-originated mortgage opportunities to a named active licensed Legends Mortgage Team loan officer with consumer-visible disclosure and consent.

## GPT package standard

Every package follows the structure in `Architecture.md` and includes ownership, audience classification, capability settings, source provenance, knowledge review dates, test conversations, compliance decisions, and a changelog.

Every manifest also declares owner mode, owner profile, audience type, assigned lending partner when applicable, mortgage-routing and lead-capture settings, public/internal boundary, compliance level, privacy-policy requirement, and Apply Now behavior. Realtor and team-shared packages fail launch validation when required routing is unresolved.

## Shared knowledge system

- `knowledge/shared/` stores approved identity, voice, glossary, capability, handoff, and source-provenance standards.
- Domain folders store curated mortgage, real estate, marketing, compliance, and business knowledge.
- Volatile material includes source, effective date, owner, review cadence, and expiration behavior.
- Raw research stays in `source_material/`; only reviewed material graduates to `knowledge/`.

## Action schema system

- OpenAPI schemas live in `actions/schemas/` and non-secret payloads in `actions/examples/`.
- Secrets remain server-side and are referenced only by environment-variable names or credential-manager location.
- Actions use least privilege, authentication, input validation, tenant/role scoping, audit logging, idempotency where applicable, and human approval before sends or consequential writes.
- Consumer lead submission identifies the receiving licensed professional and requires explicit affirmative consent before an Action call.
- Public lead capture accepts only the approved low-risk inquiry fields; sensitive application information and documents are directed to the assigned lender's secure Apply Now URL.

## Compliance requirements

- No unsupported mortgage, rate, payment, savings, approval, qualification, or licensing claims.
- Current NMLS and Equal Housing language when applicable.
- Public content must handle Fair Housing, RESPA, TILA/Reg Z trigger terms, CAN-SPAM/TCPA, privacy, state licensing, VA, DPA, credit, and business-purpose lending as applicable.
- Public assistants cannot access borrower PII, pipeline data, internal pricing, or internal guidelines.
- Outputs requiring compliance review are labeled as drafts and routed to the current human process.

## Success metrics

- 100% of launched GPTs use the package standard and have an owner.
- 100% pass required security, compliance, prompt-injection, and scope tests.
- Zero committed secrets or borrower PII.
- Measured reduction in task time for the target workflow.
- Adoption, repeat use, accepted-draft rate, handoff conversion, and correction rate are tracked per GPT.
- Volatile knowledge remains inside its review SLA.
- 100% of launched GPTs resolve contact and routing snapshots from active centralized profiles with no conflicting Apply Now links.
- 100% of Realtor GPTs with mortgage routing have an active assigned licensed lending partner.
- 100% of public lead submissions retain explicit consent evidence and pass server-side assignment validation.

## Acceptance criteria

1. Package structure and manifest are complete.
2. Internal/partner/public classification and data boundary are explicit.
3. Instructions contain a clear job, output contract, refusal behavior, source discipline, and handoff.
4. Knowledge has provenance and review metadata.
5. Capability and Action choices are justified.
6. Test conversations pass with recorded evidence.
7. Compliance owner and launch owner approve the release.
8. Rollback and deprecation steps are documented.
9. Generated contact, compliance, CTA, and routing snapshots match the manifest's active source profiles.
10. Public lead capture has a valid privacy URL, secure external endpoint, consent test evidence, approved retention/deletion rules, and security/privacy/compliance sign-off.
