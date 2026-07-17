# Week 1 Lock Report

**Week.** Week 1 (DAY01 → DAY07, 2026-05-25 → 2026-05-31, Memorial Day week).
**Locked at.** 2026-05-24.
**Locked by.** Jeremy McDonald (operator confirmation pending in the calendar approval column).
**Status.** **LOCKED — NOT FINAL UPLOAD READY.**

## What "locked" means here

- Day-to-pillar map confirmed in `02_calendars/week_1_locked_calendar.csv`.
- Channel-by-channel asset plan in `05_assets/week_1_asset_generation_plan.csv` (58 asset slots across 7 days).
- Batch prompt files ready for Canva, HeyGen, Higgsfield, Thumbnails.
- HeroPost staging locked in `06_heropost/week_1_heropost_staging_locked.csv` (58 rows, schema exact).

## What "not final upload ready" means

- Media URLs are still `STAGING_PENDING_MEDIA` on every row.
- Thumbnail URLs are still `STAGING_PENDING_THUMBNAIL` on every video row.
- Story slots reference `STORY_001` and `STORY_004` which are `Source Pending` placeholders in the Story Bank.
- No row is promoted to a Final HeroPost CSV. No row will be promoted until media URLs land and source records move to Publish Ready.

## Week 1 pillar map

| Day | Date | Weekday | Lead Pillar | Local Angle | Story Slot |
|---|---|---|---|---|---|
| DAY01 | 2026-05-25 | Mon | Broker Advantage | — | — |
| DAY02 | 2026-05-26 | Tue | First Time Buyer | St. Johns County | — |
| DAY03 | 2026-05-27 | Wed | Mortgage Story | Ponte Vedra | STORY_001 (Source Pending) |
| DAY04 | 2026-05-28 | Thu | Investor Strategy | — | — |
| DAY05 | 2026-05-29 | Fri | Closing Day | — | STORY_004 (Source Pending) |
| DAY06 | 2026-05-30 | Sat | Realtor AI Education | Fleming Island | — |
| DAY07 | 2026-05-31 | Sun | Leadership / Reflection | — | — |

## Counts

- Locked calendar rows: 7
- Asset slots planned: 58
- Canva batch prompts: 37
- HeyGen batch prompts: 19
- Higgsfield batch prompts: 3
- Thumbnail prompts: 13
- HeroPost staging rows (locked): 58

## Compliance status

- HeroPost schema: PASS (exact `Caption,Media,Title,Date,Link,Thumbnail,Type,Comment`).
- Banned phrase scan: 0 hits.
- Em-dash scan: 0 hits.
- Customer names: none used (anonymized).
- Exact addresses: none used.
- VA posts: include VA non-endorsement line.
- DSCR / investor posts: include business-purpose line.
- GBP posts: include local relevance and NMLS footer.
- All story-linked rows note Source Pending and need Jeremy review before publishing.

## What still blocks final upload

1. **Story Bank intake.** Move `STORY_001` and `STORY_004` (at minimum) from Source Pending to Publish Ready.
2. **Canva fills.** Run Bulk Create against the 37 Week 1 Canva prompts. Export assets.
3. **HeyGen renders.** Submit the 19 Week 1 HeyGen scripts. Download renders.
4. **Higgsfield plates.** Run the 3 Week 1 Higgsfield prompts after Concept Gate clears.
5. **Thumbnails.** Generate 13 thumbnails in Canva.
6. **Hosting.** Upload all exports to the hosting bucket. Fill `05_assets/media_url_tracker.csv` with the URLs.
7. **HeroPost promotion.** Run the HeroPost Scheduler to promote `week_1_heropost_staging_locked.csv` rows to `heropost_week_1_ready.csv` once all media URLs resolve.

## Hard rules respected

- No row marked Final.
- No media URLs invented.
- No story slot publishes without an underlying Story Bank source.
- No auto-publish.
- No HeroPost upload until media URLs exist.

## Next step

Jeremy moves at least 2 story records (`STORY_001`, `STORY_004`) to Publish Ready in the Story Bank intake tracker, then dispatches Canva Bulk Create and HeyGen rendering for Week 1.
