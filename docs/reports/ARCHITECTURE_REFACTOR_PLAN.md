# Architecture refactor plan

**Owner:** GOAT Architect
**Audit date:** 2026-07-17
**Scope:** authored factory files; `source_material/` remains an immutable research archive and is excluded from runtime inheritance and deduplication gates.

## Current-state findings

| Duplication class | Current locations | Problem | Canonical replacement |
|---|---|---|---|
| Identity and contact formatting | `config/profiles/`, `README.md`, `AGENTS.md`, generator tests | Profile values are centralized, but literal disclosures and test assertions repeat identity data. | `config/profiles/` remains the only person-data store; `core/identity/identity_pack.yaml` owns inheritance and formatting. Tests resolve expected values from those sources. |
| Compliance | Repository rules, architecture docs, Action docs, lead instructions, generator strings | Shared prohibitions and disclosures can drift between GPT packages. | `core/compliance/` owns reusable rules and one inherited checklist; identity-specific disclosure formatting stays in `core/identity/`. |
| CTAs | `gpts/templates/shared_modules/call_to_action_library.md` and `scripts/generate_contact_snapshots.rb` | The same CTA intent is maintained as both prose and Ruby literals. | `core/cta/cta_library.yaml` owns all CTA templates; generators only resolve variables. |
| Routing | Architecture, routing standard, manifest rules, Action routing docs, generator code, test prose | Owner and assigned-lender behavior is repeated and partly enforced only in prose. | `core/routing/routing_rules.yaml` owns routing and Apply Now behavior; builder validation enforces it. |
| Lead capture | `actions/lead_capture/`, GPT shared instructions, routing standard, generator constants | Consent, sensitive fields, fallback, OpenAPI, and security are split across package and Action layers. | `core/lead_capture/` becomes the complete reusable module; legacy Action paths become compatibility references. |
| Audience behavior | Coarse audience table in architecture plus package-by-package recommendations | Tone, actions, privacy, disclosures, CTA, and routing are not inherited automatically. | `core/audiences/audience_profiles.yaml` defines all nine supported audiences and their merged defaults. |
| Conversation behavior | Package standard and lead instructions | Greeting, discovery, clarification, refusal, escalation, closing, handoff, and application behavior would be rewritten per GPT. | `core/conversation/conversation_engine.yaml` owns the common lifecycle. |
| Prompt composition | Package instructions assembled manually | Module order and precedence are implicit. | `core/prompts/composition_order.yaml` defines deterministic precedence and conflict resolution. |
| Shared knowledge | Empty domain placeholders under `knowledge/` | Packages have no machine-readable registry or review gate. | `core/shared_knowledge/knowledge_registry.yaml` registers approved domains and lifecycle requirements. |
| Shared tests | Routing matrix under `gpts/templates/tests/`; other requirements only in QA prose | Future packages could omit core inheritance tests. | `core/shared_tests/` owns reusable routing and factory acceptance tests. |
| Manifest/template validation | Markdown manifest template with prose rules | No schema or builder proves allowed enums and cross-field constraints. | `core/templates/manifest.schema.json`, blueprint/template files, and executable validation. |
| Platform export | Package assumes OpenAI Custom GPT layout | Adding Claude, Gemini, Copilot, or local assistants would require changing core content. | `exporters/platforms.yaml` isolates platform naming and export behavior from the core build graph. |

## Refactor boundary

1. Preserve `source_material/` byte-for-byte as research, not runtime knowledge.
2. Preserve the approved profile records under `config/profiles/`; do not copy their values into core modules.
3. Move reusable lead-capture artifacts into `core/lead_capture/` and leave compatibility references under `actions/lead_capture/`.
4. Replace GPT-local shared modules with canonical core modules.
5. Generate package snapshots deterministically and mark them as derived; never edit generated files.
6. Record every source dependency and SHA-256 digest so regeneration is auditable.
7. Keep individual GPT creation out of this task; builder tests use temporary synthetic packages only.

## Completion gates

- Every required `core/` module exists, documents ownership, and is machine-readable where behavior must be generated.
- The builder validates manifests, profiles, audiences, routing, compliance, actions, and output structure.
- Changing one core module changes the dependency fingerprint and regenerated package output.
- Authored non-generated files contain one canonical Jeremy profile, one canonical CTA library, one canonical routing engine, one canonical compliance checklist, and one canonical lead-capture module.
- OpenAPI, profile inheritance, routing, lead capture, links, secret scans, and clean-build tests pass.

## Remaining duplication after refactor

- `source_material/` intentionally preserves historical exports and exact duplicate research for provenance. It is quarantined from Factory inheritance.
- Generated package snapshots intentionally materialize resolved core behavior for platform portability. They are derived, hash-tracked, and never hand-maintained.
- Governance documents may restate a safety gate or business decision for human accountability, but executable wording, profile values, templates, routing, CTA, compliance checklist, consent, and Action contracts have one canonical runtime source.
- Compatibility paths under `actions/lead_capture/` and `gpts/templates/` are symbolic links, not copies.
- Approved production knowledge is still a scaffold; future curation may uncover domain-content overlap that must be resolved before the first build.
