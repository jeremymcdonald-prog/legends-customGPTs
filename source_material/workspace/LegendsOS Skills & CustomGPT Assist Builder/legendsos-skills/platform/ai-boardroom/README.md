# AI Boardroom

## What it is
The internal review gate for LegendsOS. A multi-seat advisory board that pressure-tests anything Jeremy is about to commit to: content, campaigns, offers, automations, workflows, builds, decisions.

## Who uses it
Jeremy (primary). The other LegendsOS skills call it as a gate before they mark anything approved.

## When to invoke

- Before scripting a YouTube video or recording a Short
- Before shipping a marketing campaign or post
- Before launching an offer
- Before turning on an automation
- Before merging a LegendsOS feature
- Before signing off on an AI tool / GPT build
- Any time the cost of being wrong is bigger than the cost of one extra review

## When NOT to invoke

- Pure execution work where the decision is already made
- Single-image production (use `visual-intelligence` directly; it will call the Visual Board internally if needed)
- Simple text edits or proofreading

## How it picks a council

| Input type | Council | Specialty board |
|---|---|---|
| Content, campaign, offer, brand, copy, positioning | Strategy Council | — |
| Single image / post / thumbnail | Strategy + Visual Board (8 lenses) | Visual Board |
| YouTube/Shorts concept from intel | Strategy + YouTube Board (8 lenses) | YouTube Board |
| Automation, workflow, LegendsOS feature, AI build | Operational Council | Risk tier + R-codes mandatory |
| Mortgage marketing campaign | Strategy + Compliance check | Compliance auto-added |

## What you get back

The 10-part synthesis. Verdict up front. Seat reviews next. Conflicts, hidden risks, the recommended decision, ranked fixes, and an exact action plan.

## Hand-offs

- If the boardroom recommends a creative fix, the synthesis routes to `visual-intelligence` (single image), `creative-studio` (campaign kit), or `09-webinar-builder`.
- If the boardroom flags a compliance issue, the synthesis stops with a "hold + review note" and the item never reaches the publish queue.

## Limits

- Internal only. Strategy personas are lenses, not voice impersonations.
- Not legal, tax, or compliance advice. Flags items that need human sign-off.
- The Chair makes the call. The board informs it. Jeremy still owns the decision.

## File map

```
ai-boardroom/
├── SKILL.md
├── CUSTOM_GPT.md
├── README.md (this file)
├── knowledge/          source files this skill pulls into context
├── examples/           5 worked examples, real input + full 10-part output
├── test-prompts.md
├── usage-notes.md
└── compliance.md
```
