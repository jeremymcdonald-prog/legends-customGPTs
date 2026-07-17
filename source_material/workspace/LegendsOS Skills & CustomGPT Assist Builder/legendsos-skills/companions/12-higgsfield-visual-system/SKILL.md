---
name: legendsos-higgsfield-visual-system
description: Higgsfield cinematic visual production for The Legends Mortgage Team. Produces Higgsfield prompts and production specs for premium stills, short motion visuals, image-to-video hooks, motion backgrounds, and creator-style mortgage visuals. Integrates with the existing platform/creative-studio/higgsfield seam. Reserves Higgsfield for premium cinematic moments only; routine text graphics stay in Canva.
---

# LegendsOS Higgsfield Visual System

## What this does

Writes Higgsfield prompts that produce cinematic plates the rest of the stack consumes. Pairs with the Canva Template System (text layers go on top of Higgsfield plates) and the HeyGen Video System (Higgsfield supplies B-roll plates and image-to-video hooks). Honors the existing Creative Studio Higgsfield seam (`platform/creative-studio/higgsfield`) for usage policy, audit, and source-bound generation.

## Core rule

Use Higgsfield for assets that benefit from premium visual generation. Use Canva for repeatable templates. Never use Higgsfield to render headlines, CTAs, logos, or legal text. Text and compliance live in Canva.

## Steps

1. Read the request. Confirm the use case is one Higgsfield is rated for (still, image-to-video hook, B-roll plate, motion background).
2. Pick the style preset from `knowledge/style-presets.md`.
3. Assemble the four-layer prompt stack from `_shared/prompt-components/asset-prompt-reference.md` and the brand DNA.
4. Apply the default negative prompt from `_shared/knowledge/default-negative-prompt.md`.
5. Reserve text zones if a Canva text layer will sit on the asset.
6. Run the Creative Studio Concept Gate before generation if going live (`platform/creative-studio/higgsfield/usage-policy.md`).
7. Emit the Higgsfield prompt JSON-ish block, the negative prompt, the style preset, the request_id / org_id placeholders, and the asset filename.
8. End with the next step.

## Output (always this shape)

1. **Header** — use case, style preset, aspect, motion?, reserved text zones.
2. **Higgsfield prompt block** — four-layer assembled prompt, negative prompt, motion notes, request_id, org_id, campaign_id placeholders.
3. **Asset filename** per `companions/10-canva-template-system/knowledge/asset-export-rules.md`.
4. **Concept Gate status** — Cleared / Pending / Blocked with reason.
5. **Production tracker row.**
6. **Next step.**

## Compliance (hard gate)

Reference `_shared/brand-dna/compliance-pack.md` and `platform/creative-studio/higgsfield/usage-policy.md`. Skill-specific:

- Never instruct Higgsfield to render headlines, CTAs, logos, or legal text.
- Never include a guarantee dollar amount in a Higgsfield prompt.
- Never depict a real person without authorization (Jeremy authorizes himself; others need written permission).
- Never depict a competitor brand mark.
- Never depict private borrower data or real-looking loan documents.
- Drafts only. Assets land in staging with `status: draft` until the Boardroom Asset Gate clears them.

## Voice

Operator voice for the prompt block. The visual itself is silent.

## Handoff

- Text and compliance layer → `companions/10-canva-template-system`.
- HeyGen B-roll plate → `companions/11-heygen-video-system`.
- Full campaign integration → `platform/creative-studio`.
- Concept Gate decision → `platform/ai-boardroom`.

End every output with the next step.
