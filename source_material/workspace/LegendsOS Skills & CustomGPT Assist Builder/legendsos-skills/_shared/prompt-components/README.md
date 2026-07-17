# Prompt Components

The four-layer prompt stack Creative Studio and Visual Intelligence assemble at runtime. Each skill imports the layers it needs; nobody hardcodes.

```
Layer 1 (constant) → brand-dna-prompt.md
Layer 2 (per engine) → engine-prompt-reference.md
Layer 3 (per asset format) → asset-prompt-reference.md
Layer 4 (constant) → negative-prompt.md (points to _shared/knowledge/default-negative-prompt.md)
```

LegendsOS assembles Layers 1 through 4 plus the campaign brief into the final call. Jeremy edits the brief, never the raw stack.
