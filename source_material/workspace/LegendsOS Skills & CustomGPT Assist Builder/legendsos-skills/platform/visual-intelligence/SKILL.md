---
name: legendsos-visual-intelligence
description: Turn a mortgage topic into a thumb-stopping, compliance-safe social image package for The Legends Mortgage Team and Loan Factory LOs. Trigger on requests to "make an image / post / thumbnail / Reel cover / story / banner", to design social creative, or to make a mortgage graphic compliant. Picks the engine (Cinematic Authority, Pattern Interrupt, Educational Minimal) and layout, writes an AI scene prompt that leaves room for text, specifies Canva text and compliance, writes the caption, and scores it through a visual boardroom. Built on LegendsOS dark-luxury DNA: charcoal/black, Loan Factory orange, champagne gold.
---

# LegendsOS Visual Intelligence

## Core rule
AI builds the cinematic plate. Canva adds the words and compliance. Never have the image model render headlines, CTAs, logos, or legal text. Reserve a clean text zone and a bottom compliance strip.

## Steps
1. Ask only for topic and platform if missing, then produce the full package.
2. Pick engine: Cinematic Authority (trust), Pattern Interrupt (scroll-stop, sparing, never name competitors), Educational Minimal (one idea).
3. Pick a layout from the 14-layout framework. Apply DNA from `_shared/brand-dna/visual-dna.md`: charcoal/black, Loan Factory orange + champagne gold, cinematic realism, strong face, one big idea, mobile-first.
4. Assemble the prompt stack: Layer 1 (`_shared/prompt-components/brand-dna-prompt.md`) + Layer 2 engine line + Layer 3 asset specifics + Layer 4 (`_shared/knowledge/default-negative-prompt.md`).
5. Output the 6-part package: (1) Engine + Layout, (2) AI image prompt with negative + empty text/compliance zones, (3) Canva build with headline/support/CTA/logo/compliance, (4) caption in Jeremy's voice with one CTA and a next step, (5) Visual Boardroom review (Attention/Compliance/Trust/Readability/Brand) with risk notes + fixes, (6) final approved prompt.
6. If Compliance score is under 8, do not approve. Output a compliance review note.

## Output (always this shape)
1. Engine + Layout selected (one line why)
2. AI Image Prompt — paste-ready, scene/subject/lighting only, with the default negative prompt, text + compliance zones reserved
3. Canva Build — headline, support line, CTA, where each text zone sits, logo lockup placement, compliance strip text
4. Caption — Jeremy's voice, plain and confident, one CTA, ends with a next step
5. Visual Boardroom Review — verdict + Attention/Compliance/Trust/Readability/Brand scores + risk notes + fixes
6. Final Approved Prompt — corrected and ready

## Compliance (hard gate)
Reference `_shared/brand-dna/compliance-pack.md`. No approval promises. No "lowest rate/fees" unless sourced and approved. No rate without APR. No guarantee dollar amount unless current offer + eligible states confirmed (see `_shared/brand-dna/guarantee-terms.md`); never promote in Washington; always add T&C URL + "not a commitment to lend; subject to credit approval; rates/terms/fees subject to change." NMLS #320841 complete and correct; LO NMLS when promoted. No named/depicted competitors. No fake testimonials, no loan docs, no borrower PII. No government endorsement for VA/FHA/USDA. "Terms, eligibility, and program guidelines apply" for programs. Compliance score under 8 = do not approve, output a review note.

## Default negative prompt
See `_shared/knowledge/default-negative-prompt.md`. Append to every AI image call.

## Hand-offs
- Campaign-level work (multi-format kit, video, B-roll): route to `platform/creative-studio`.
- Boardroom-level critique on the concept (not just the asset): route to `platform/ai-boardroom`.
- Email graphic only: this skill produces the header; the body goes to `companions/04-email-newsletter`.

End every package with the next step.
