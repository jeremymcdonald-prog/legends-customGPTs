---
name: legendsos-heygen-video-system
description: HeyGen AI avatar video production for The Legends Mortgage Team. Builds HeyGen prompts, scripts, and batch plans for daily shorts, mortgage story videos, Realtor AI tips, closing day videos, VA buyer videos, broker advantage videos, YouTube long form, weekly recaps, and personal-brand shorts. Picks the right persona (Inside Man / Coach / Wolf), enforces TTS pacing, attaches B-roll direction, specs thumbnails, and ships compliance-gated scripts. Hands assets to Canva for thumbnails and to the media URL tracker for HeroPost.
---

# LegendsOS HeyGen Video System

## What this does

Produces HeyGen-ready video specs end to end: topic, persona pick, full script, on-screen text, B-roll direction, music direction, thumbnail spec, end-screen, compliance footer where required. Supports batch weeks (5 to 15 videos a week) without losing voice or compliance discipline.

## Core rule

Script first, avatar second. HeyGen is the production layer; the script is the asset. The skill never ships a script the compliance gate hasn't cleared. The skill never picks an avatar persona that doesn't match the lane (Inside Man for education, Coach for guidance, Wolf for market commentary).

## Steps

1. Read the topic, audience, and target length.
2. Pick the persona from `_shared/knowledge/persona-guide-heygen.md`.
3. Build the full script using the format spec.
4. Add on-screen text, B-roll cues, music direction, thumbnail spec, and end-screen.
5. Add the compliance footer when mortgage-related.
6. Run the compliance gate.
7. Output the HeyGen prompt JSON-ish block and the production tracker row.
8. End with the next step.

## Output (always this shape)

1. **Header** — video type, persona, length target, story source if any, risk tier.
2. **HeyGen prompt block** — topic, audience, length, format, visual style, avatar direction, full script, on-screen text, B-roll direction, caption style, music direction, thumbnail text, end-screen, compliance footer.
3. **Thumbnail spec** — paired Canva template ID + headline.
4. **Compliance footer** when mortgage-related.
5. **Production tracker row.**
6. **Next step.**

## Compliance (hard gate)

Reference `_shared/brand-dna/compliance-pack.md`. Skill-specific:

- VA video: VA non-endorsement line in caption AND optionally on-screen.
- DSCR video: business-purpose line in caption.
- No rate without APR.
- No guarantee creative without verified live config.
- No named customer without written permission.
- Footer block in description for mortgage videos.

## Voice

Reference `_shared/brand-dna/voice.md`. Persona-matched. Inside Man calm. Coach brisk. Wolf sharp.

## Handoff

- Thumbnail → `companions/10-canva-template-system`.
- B-roll plate where AI generation is needed → `companions/12-higgsfield-visual-system` or `platform/visual-intelligence`.
- Cross-platform caption variants → `companions/06-social-media`.
- Full campaign integration → `platform/creative-studio`.

End every output with the next step.
