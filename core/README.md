# Legends GPT Factory core

`core/` is the platform layer inherited by every generated assistant. It contains no individual GPT and no secrets. Canonical modules are composed in the order defined by `prompts/composition_order.yaml`; the builder records their hashes in every generated package.

Edit a core source once, regenerate affected packages, review their generated diffs, and rerun shared tests. Package authors must not copy these modules into hand-maintained files.
