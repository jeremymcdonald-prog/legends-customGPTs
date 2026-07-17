# Architecture

## Repository layers

1. `source_material/` — immutable research snapshots; never a runtime dependency.
2. `knowledge/` — curated approved knowledge registered by `core/shared_knowledge/`.
3. `config/` — centralized active professional profiles and reusable profile templates.
4. `core/` — platform-neutral identity, audience, compliance, routing, Action, conversation, prompt, CTA, lead-capture, shared-knowledge, shared-test, and template modules.
5. `exporters/` — platform-specific packaging only.
6. `gpts/` — generated package outputs and compatibility template entry points.
7. `actions/` — compatibility/export paths for reusable Action contracts; secrets and implementations remain external.
8. `scripts/` — deterministic builder, snapshot generator, validator, and tests.
9. `docs/` — decisions, reports, validation, and launch governance.

## Dependency order

`Identity -> Audience -> Compliance -> Conversation -> Routing -> CTA -> Lead Capture -> Generated Snapshots -> Final Package -> Platform Export`

Shared knowledge and shared tests join before package generation. See `CORE_MODULE_DEPENDENCY_MAP.md` for the visual graph and precedence rules.

## Builder contract

An approved blueprint declares bounded purpose, scope, output contract, owner profile, one of nine audiences, knowledge selection, capabilities, Actions, routing, compliance level, privacy, lead capture, Apply Now behavior, and platform. `scripts/build_gpt_package.rb`:

1. validates schema enums, active profiles, Realtor/team assignments, audience, knowledge registry, Action/consent/privacy gates, and platform;
2. resolves core modules and active profile data;
3. stages the complete generated package before replacing its target;
4. records a SHA-256 hash for every core module and selected profile;
5. fails closed on invalid or unresolved routing.

## Standard generated package

```text
gpts/<slug>/
  README.md
  manifest.md
  instructions.md
  conversation_starters.md
  knowledge/
  generated/
  tests/
  actions/
  compliance/
  examples/
  changelog.md
```

Package-authored content is limited to bounded purpose/workflow, approved knowledge, synthetic examples, and package-specific tests. Identity, audience, compliance, conversation, routing, CTA, Actions, lead capture, shared knowledge rules, and shared tests are inherited. Files in `generated/` are derived outputs and are never hand-edited.

## Audience and data boundaries

The Audience Engine defines Consumer, Realtor, Loan Officer, Internal Team, Recruit, Vendor, Marketing, Executive, and Mixed behavior. Mixed or ambiguous contexts use the strictest applicable privacy and compliance boundary until clarified.

## Action boundary

The assistant is an Action client, never the secret holder or live routing authority. External authenticated services validate identity, assignment, scope, allowlisted fields, consent, idempotency, and approval. Public lead capture remains disabled until endpoint, privacy, security, compliance, retention, monitoring, and human ownership gates pass.

## Export boundary

Platform adapters may translate field names, file packaging, size limits, knowledge upload instructions, and Action configuration. They cannot change core identity, safety, privacy, compliance, routing, consent, or knowledge authority.
