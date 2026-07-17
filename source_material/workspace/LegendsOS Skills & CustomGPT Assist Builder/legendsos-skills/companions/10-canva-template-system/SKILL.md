---
name: legendsos-canva-template-system
description: Canva template specification and field schema for The Legends Mortgage Team. Defines reusable Canva templates by category (mortgage story, closing day, VA, FTHB, broker-vs-bank, Realtor AI, local authority, investor, motivational, personal brand, GBP, YouTube thumbnail, Reel cover, carousel education), produces template field maps for Canva Bulk Create CSV runs, and outputs asset filename and export specs the production engine uses. Hands off filled Canva assets to the media URL tracker and the HeroPost Scheduler.
---

# LegendsOS Canva Template System

## What this does

Defines and operates Jeremy's reusable Canva template set. Every social, GBP, blog, vlog, and video asset that uses on-screen typography ships from a template here. The skill outputs the template spec (canvas size, fields, slots, exports) and the per-asset CSV row that drives Canva Bulk Create.

## Core rule

Canva owns text and compliance. AI image tools own visual plates. Templates lock the layout so compliance footers, NMLS, EHO, and disclaimers can never get dropped. Templates also lock the visual DNA (palette, type families, accent rule) so production stays on brand at scale.

## Steps

1. Receive a request (build a template, fill a template, batch-fill via Bulk Create).
2. Confirm the template category and version.
3. Apply field schema from `knowledge/template-field-schema.md`.
4. For a fill: produce a Canva Bulk Create CSV row using the template's required and optional fields.
5. Output the asset filename per `knowledge/asset-export-rules.md`.
6. Run the compliance gate (footer present, NMLS, EHO, disclaimers).
7. Hand the filled asset to the media URL tracker (post-export step is human or n8n).
8. End with the next step.

## Output (always this shape)

1. **Header** — template name, version, canvas size, platform target.
2. **Field schema** — required and optional fields with placeholder text.
3. **Asset filename** — per `asset-export-rules.md`.
4. **Bulk Create CSV row** when filling.
5. **Compliance footer placement** confirmed.
6. **Production tracker row.**
7. **Next step.**

## Compliance (hard gate)

Reference `_shared/brand-dna/compliance-pack.md`, `_shared/brand-dna/visual-dna.md`, `_shared/brand-dna/nmls-eho-footer.md`, `_shared/brand-dna/guarantee-terms.md`.

- Footer slot is locked on every template; removing it is not an option.
- NMLS field is required and validated as a six-digit number for Loan Factory (320841).
- Guarantee dollar amount slot only renders when `current_guarantee_offer` is verified.
- No rate field unless paired with APR field and assumptions field (and a Red-tier owner approval flag).
- Visual DNA strictly enforced (one accent, two type families, palette only).

## Voice

Operator voice in the field schema. Jeremy's voice in the template's headline placeholders.

## Handoff

- Filled asset → media URL tracker → HeroPost Scheduler.
- Image plate where a generated visual is needed → `companions/12-higgsfield-visual-system` or `platform/visual-intelligence`.
- Full multi-asset campaign → `platform/creative-studio`.

End every output with the next step.
