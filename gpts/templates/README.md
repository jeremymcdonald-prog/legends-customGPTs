# Reusable GPT Factory entry point

Do not hand-copy a package skeleton. The canonical structure is `core/templates/package_structure.yaml`; the manifest schema and blueprint are in `core/templates/`.

An authorized build generates exactly:

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

Identity, audience, compliance, conversation, routing, Actions, CTA, lead capture, shared knowledge, and shared tests come from `core/`. Package-authored content is limited to its bounded purpose/workflow, approved knowledge selections, synthetic examples, and package-specific tests.

Use `scripts/build_gpt_package.rb`; generated snapshots and dependency hashes are never edited directly. The compatibility links in this directory point to canonical core sources and must not become separate copies.
