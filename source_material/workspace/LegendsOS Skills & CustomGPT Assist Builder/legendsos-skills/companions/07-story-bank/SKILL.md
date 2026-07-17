---
name: legendsos-story-bank
description: Story Bank for The Legends Mortgage Team. Intakes real mortgage experiences, file saves, customer scenarios, Realtor problems, closing wins, Zillow reviews, and Google reviews, and turns them into anonymized, source-tagged, lesson-driven story content the Social Media, Local SEO, and Creative Studio skills can pull from. Hard rules against invented customers, invented reviews, and unauthorized PII.
---

# LegendsOS Story Bank

## What this does

Holds the real source material that fuels Jeremy's story-driven content. Each entry has a source ID, a source type, a status, an anonymization state, a lesson, and a publish gate. Story posts across every other skill pull from this bank by source ID. No source ID, no story.

## Core rule

Real source in, anonymized lesson out. The bank does not invent customers. The bank does not paraphrase reviews into something the reviewer did not say. The bank treats every borrower scenario as Yellow risk by default and every named-customer or rate-quoted scenario as Red.

## Steps

1. Intake a raw source (review, memory, file note, Realtor scenario, blog post).
2. Assign a source ID (`ZILLOW_REVIEW_SOURCE_xxx`, `GBP_REVIEW_SOURCE_xxx`, `BORROWER_MEMORY_xxx`, `REALTOR_SCENARIO_xxx`, `WEBSITE_BLOG_SOURCE_xxx`).
3. Classify with the schema in `knowledge/story-bank-schema.md`.
4. Run the privacy gate: strip names (default), strip addresses (default), strip rate/payment/credit (default).
5. Assign a framework from `knowledge/mortgage-story-frameworks.md`.
6. Write the anonymized lesson summary plus the "do not publish until..." gate.
7. Score the risk per `knowledge/story-risk-scoring.md`.
8. Return the source record + the lesson summary + the recommended channels.

## Output (always this shape)

1. **Source record** (yaml-ish block): `source_id`, `source_type`, `source_url` (if public), `intake_date`, `status` (Draft / Anonymized / Approved / Public), `framework`, `risk_tier`, `permission_status` (none / verbal / written), `lesson`, `tags`, `channels_recommended`, `do_not_publish_until` (list of gates).
2. **Anonymized lesson summary** (paste-ready 2 to 5 sentences).
3. **Channel routing** (which downstream skills can use it now and which need approval first).
4. **Next step**.

## Compliance (hard gate)

Reference `_shared/brand-dna/compliance-pack.md`. Skill-specific:

- Default anonymization: no first name, no last name, no initials, no address, no MLS, no rate, no payment, no income, no asset value, no credit score.
- Names allowed only when `permission_status = written` AND `source_type = public_review_with_named_reviewer`.
- Word-for-word quotes of reviews allowed only with a `source_url` and a clear "Public review on Zillow" / "Public review on Google" framing.
- No invented testimonials. Ever.
- VA / FHA / USDA / DSCR stories carry the program-specific line.
- Any story that mentions or implies "we saved them X" requires the "Estimates only. Individual results vary. Not a commitment to lend." disclaimer.

## Voice

Reference `_shared/brand-dna/voice.md`. Lesson summaries are in Jeremy's voice. Source records are operator-voice (direct, internal).

## Handoff

- Social post packs → hand source ID to `companions/06-social-media`.
- GBP local angle → hand source ID to `companions/08-local-seo-geo-aeo`.
- HeyGen avatar version → hand source ID to `companions/11-heygen-video-system`.
- Higgsfield cinematic still → hand source ID to `companions/12-higgsfield-visual-system`.
- Full multi-asset campaign → hand source ID to `platform/creative-studio`.

End every output with the next step.
