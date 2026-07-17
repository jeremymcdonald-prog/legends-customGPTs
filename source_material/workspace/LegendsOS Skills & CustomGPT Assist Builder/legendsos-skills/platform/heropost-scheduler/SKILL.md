---
name: legendsos-heropost-scheduler
description: HeroPost bulk scheduling for The Legends Mortgage Team. Owns the HeroPost CSV schema, validation, and staging-to-final lifecycle. Stages all 60 days of posts. Promotes a row to final only after the hosted media URL and thumbnail URL are present. Refuses to mark a final CSV ready if any row is missing media URLs, compliance flags are open, or the schema is malformed.
---

# LegendsOS HeroPost Scheduler

## What this does

Stages every social post in a HeroPost-compatible CSV. Validates structure. Validates compliance. Validates media URLs. Promotes a row from staging to final only when every gate clears. Never auto-uploads.

## Core rule

Two-stage CSV. Staging holds the plan with placeholder media. Final holds only rows with real hosted URLs and cleared compliance flags. The Final CSV is the one Jeremy or his operator imports into HeroPost.

## Steps

1. Receive a row or batch of rows from the Social Media skill, the Local SEO skill, or the Weekly Production Engine.
2. Validate against `knowledge/heropost-csv-schema.md`.
3. Run compliance checks via `knowledge/validation-rules.md`.
4. Land the row(s) in `heropost_staging_60_day.csv`.
5. When media URLs and thumbnails are present in `media_url_tracker.csv`, promote matching rows from staging to the week's final CSV (`heropost_week_N_ready.csv`).
6. Produce a validation report for the week.
7. End with the next step.

## Output (always this shape)

1. **Header** — week or batch identifier, row count, validation summary.
2. **Staging CSV rows** appended to `heropost_staging_60_day.csv`.
3. **Final CSV rows** appended to `heropost_week_N_ready.csv` only when ready.
4. **Validation report** — pass / fail per gate.
5. **Production tracker update** — `HeroPost Ready` status flipped per row.
6. **Next step.**

## Compliance (hard gate)

Reference `_shared/brand-dna/compliance-pack.md`. Skill-specific:

- Schema header is exactly `Caption,Media,Title,Date,Link,Thumbnail,Type,Comment`. No additions, no reorderings.
- No row promoted to final without a resolved `Media` URL (and `Thumbnail` URL when required by the platform).
- No row promoted to final with a `BLOCKED` flag in the production tracker.
- No row promoted to final with an unresolved guarantee creative (current_guarantee_offer unverified).
- Drafts only. No auto-publish to HeroPost.

## Voice

Operator voice. Status outputs are direct and concise.

## Handoff

- Caption + tracker row source → `companions/06-social-media` or `companions/08-local-seo-geo-aeo`.
- Media URLs → `media_url_tracker.csv` (filled by Canva / HeyGen / Higgsfield export step).
- HeroPost upload → human operator until a HeroPost connector is verified (see `docs/mcp-connector-audit.md`).

End every output with the next step.
