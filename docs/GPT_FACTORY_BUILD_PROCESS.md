# GPT Factory build process

**Owner:** GOAT Architect
**Status:** platform architecture; no individual GPT is created by this document

## Inputs

- Identity Pack and an active owner profile
- One Audience Engine profile
- Approved shared-knowledge folders
- Explicit capabilities and Actions
- Routing, compliance level, CTA, conversation, and lead-capture settings
- A blueprint based on `core/templates/gpt_blueprint.template.yaml`
- A platform adapter from `exporters/platforms.yaml`

## Build

1. Copy the blueprint template outside `gpts/` and replace every required placeholder.
2. Add or approve the owner profile once under `config/profiles/`.
3. Select one of the nine audience labels and only registered knowledge folders.
4. Declare capabilities and Actions explicitly; disabled is the default.
5. Set owner type, assigned lender where required, mortgage routing, Apply Now behavior, compliance level, privacy requirement, and public/internal boundary.
6. Validate the factory and the blueprint.
7. Generate the package into `gpts/<slug>/` only when an individual GPT build is authorized:

```bash
ruby scripts/validate_gpt_factory.rb
ruby scripts/build_gpt_package.rb \
  --blueprint /approved/path/<slug>.yaml \
  --output-root gpts
```

8. Review the generated dependency fingerprint and snapshots; never edit them directly.
9. Add only package-specific knowledge, examples, and tests. Do not copy core identity, compliance, routing, CTA, conversation, or lead-capture modules.
10. Run factory tests, package tests, security/privacy/compliance review, then follow the launch gates.

## Generated package

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

The generated directory contains contact, routing, compliance identity, CTA, audience, platform-export, and dependency snapshots. These are reproducible outputs derived from the blueprint, profiles, and core modules.

## Rebuild and propagation

After changing one profile or core module, rerun the builder for every dependent blueprint. The dependency manifest changes its build fingerprint, a complete replacement package is staged before installation, and shared tests prove the new inheritance.

Authorized blueprints are registered under `gpts/blueprints/`. Regenerate the complete registered portfolio with:

```bash
ruby scripts/rebuild_all_gpts.rb
```

The command validates and stages all blueprints before replacing their generated packages. Use `--dry-run` to validate and list targets without writing.

## Platform exports

The generic package graph stays constant. OpenAI, Claude, Gemini, Copilot, Open WebUI, AnythingLLM, OpenHands, and local-assistant differences are isolated to `exporters/`. A new platform adds an adapter; it does not fork identity, audience, compliance, routing, CTA, lead capture, knowledge, or tests.
