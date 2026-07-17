# Visual Intelligence

## What it is
The single-image production engine for LegendsOS. Replaces Companion Pack #1 (Image Studio). Takes a topic + platform and outputs a thumb-stopping, mortgage-safe, on-brand image package.

## Who uses it
Jeremy (primary). Creative Studio embeds this skill when it needs a single image inside a larger campaign kit.

## When to invoke
- Daily social: Instagram, Facebook, LinkedIn, Google Business Profile.
- Thumbnails for YouTube and Shorts.
- Story / Reel covers.
- Email header graphics.
- Single ad creative.

## When NOT to invoke
- Full campaign kit (use `creative-studio`).
- HeyGen avatar script (use `companions/02-heygen-video`).
- Short-form video plan with B-roll (use `companions/03-broll-ai-video`).
- Pure boardroom critique on a concept (use `ai-boardroom`).

## How it works

1. You give it a topic and a platform.
2. It picks one of three engines (Cinematic Authority, Pattern Interrupt, Educational Minimal) and one of 14 layouts.
3. It assembles a four-layer prompt: brand DNA + engine direction + asset format + negative prompt.
4. It outputs the 6-part package: engine+layout / AI prompt / Canva build / caption / boardroom review with 5 scores / final approved prompt.
5. If Compliance score < 8, it does NOT approve. You get a review note with the specific fix.

## Hard rules

- AI builds the plate. Canva adds the words and the compliance. Never both.
- No rate numbers baked into graphics without APR context.
- No "lowest / best / guaranteed / free" as bare claims.
- No named or depicted competitors.
- No fake testimonials, no loan documents, no borrower PII.
- No government endorsement for VA/FHA/USDA.
- NMLS #320841 must be complete (six digits) and correct on every public piece.

## File map

```
visual-intelligence/
├── SKILL.md
├── CUSTOM_GPT.md
├── README.md (this file)
├── knowledge/
│   ├── README.md
│   ├── layouts.md                  the 14 layouts in full
│   └── priority-templates.md       the 20 priority templates from Section 13
├── examples/                       5 worked examples
├── test-prompts.md
├── usage-notes.md
└── compliance.md
```
