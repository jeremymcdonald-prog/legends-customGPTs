# Legends GPT Factory

A reusable, platform-neutral factory for generating branded, compliant, maintainable assistants for Jeremy McDonald, The Legends Mortgage Team, loan officers, Realtor partners, and future business units.

## Start here

1. Read [`AGENTS.md`](AGENTS.md) and the architecture memory in [`docs/goat_architect/`](docs/goat_architect/).
2. Review [`CORE_MODULE_DEPENDENCY_MAP.md`](CORE_MODULE_DEPENDENCY_MAP.md).
3. Follow [`docs/GPT_FACTORY_BUILD_PROCESS.md`](docs/GPT_FACTORY_BUILD_PROCESS.md).
4. Create a blueprint from `core/templates/gpt_blueprint.template.yaml` only after an individual GPT build is authorized.
5. Run the factory validator and tests before generating or reviewing a package.

```bash
ruby scripts/validate_gpt_factory.rb
ruby scripts/test_contact_snapshot_generation.rb
ruby scripts/test_gpt_factory.rb
ruby scripts/rebuild_all_gpts.rb --dry-run
```

## Architecture

- `core/` — canonical identity, audience, compliance, conversation, routing, Action, CTA, lead-capture, knowledge, test, prompt, and template modules.
- `config/profiles/` — the only approved person-specific identity and lending-assignment store.
- `exporters/` — platform-specific packaging for OpenAI, Claude, Gemini, Copilot, Open WebUI, AnythingLLM, OpenHands, and local assistants.
- `gpts/` — generated packages and the human template entry point; no shared module is authored here.
- `knowledge/` — curated, approved domain knowledge registered by the core knowledge engine.
- `actions/` — compatibility/export paths; canonical reusable Action behavior lives in core.
- `scripts/` — deterministic builder, snapshot generator, validator, and tests.
- `docs/` — architecture, audit reports, decisions, QA, and launch governance.
- `source_material/` — immutable research; never inherited directly by a production assistant.

## Build model

A blueprint selects identity, audience, knowledge, capabilities, Actions, routing, compliance, CTA, conversation, lead-capture, and platform. The builder validates those relationships, creates the standard package, generates resolved snapshots, and records SHA-256 dependency hashes. `scripts/rebuild_all_gpts.rb` regenerates every authorized blueprint after one canonical change, without manual multi-file edits.

## Current status

The GPT Factory platform is implemented. No individual GPT was built or approved for launch in this refactor. Lead capture remains a non-deployed contract with placeholder endpoint/privacy configuration and mandatory launch gates.

Mortgage identity and disclosure text are always generated from the active profile and `core/identity/identity_pack.yaml`. This repository must never imply guaranteed approval, rates, payments, savings, qualification, or terms.
