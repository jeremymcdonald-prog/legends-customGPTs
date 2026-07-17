# Friday → Sunday Weekly Production Batch Spec

The recurring 3-day production cycle that feeds the Monday-to-Sunday publish run.

## Rule

Plan 60 days. Produce 14 days. Schedule 7 days. Review weekly.

## Friday morning — Plan next 14 days

**Owner.** Weekly Production Engine + operator.

Steps:

1. Read the next 14 days from `02_calendars/60_day_master_calendar.csv` (Week N+1 + Week N+2).
2. Refresh story slot assignments from `03_content_banks/story_bank_publish_ready.csv`. Replace `Source Pending` placeholders where real records have moved to Publish Ready.
3. Refresh local angle rotation from `08_local-seo-geo-aeo/knowledge/local-content-angles.md`.
4. Confirm long-form Tuesday and Thursday topics for the next 14 days.
5. Write the lock state to `02_calendars/week_{N+1}_locked_calendar.csv` once Jeremy approves the next week.

## Friday afternoon — Queue production

**Owner.** Weekly Production Engine.

Steps:

1. Queue HeyGen videos. Generate `04_prompt_banks/week_{N+1}_heygen_batch_prompts.csv`. If Zapier HeyGen connector verified, submit; otherwise prepare for operator submission.
2. Queue Higgsfield visuals (3 to 6 premium plates per week). Generate `04_prompt_banks/week_{N+1}_higgsfield_batch_prompts.csv`. Run Concept Gate before generation.
3. Generate Canva prompt batch into `04_prompt_banks/week_{N+1}_canva_batch_prompts.csv`.
4. Generate thumbnail prompt batch into `04_prompt_banks/week_{N+1}_thumbnail_prompts.csv`.
5. Notify operator (Telegram + Slack) that the batch is queued.

## Saturday — Produce

**Owner.** Operator (with optional Canva / Higgsfield / HeyGen automation).

Steps:

1. Generate Canva assets (Bulk Create).
2. Generate thumbnails (Canva).
3. Generate Higgsfield plates (after Concept Gate).
4. Poll HeyGen video render statuses; download finished videos.
5. Update `05_assets/media_url_tracker.csv` with any URLs that landed.
6. Tag any asset with broken or missing URLs as `pending` and note the gap.

## Sunday morning — Validate and finalize

**Owner.** HeroPost Scheduler + operator.

Steps:

1. Insert hosted URLs into `05_assets/media_url_tracker.csv` for every Week N+1 asset.
2. Promote ready rows from `06_heropost/week_{N+1}_heropost_staging_locked.csv` to `06_heropost/heropost_week_{N+1}_ready.csv` (only rows with resolved Media + Thumbnail + closed compliance flags).
3. Run HeroPost Scheduler validation; write `06_heropost/week_{N+1}_validation.md`.
4. Generate `08_reports/week_{N+1}_lock_to_ship_report.md`.

## Sunday afternoon — Human review and schedule

**Owner.** Jeremy McDonald.

Steps:

1. Spot-check 5 rows across pillars (story, broker advantage, local, VA, personal).
2. Confirm every Red-tier item has owner sign-off recorded.
3. Confirm the compliance footer on every mortgage row.
4. Import `heropost_week_{N+1}_ready.csv` into HeroPost.
5. Confirm scheduled times are correct.
6. Update Production Tracker rows to `Scheduled`.

## Monday — Content starts posting

**Owner.** HeroPost (or operator manual posts for slots HeroPost does not cover).

Steps:

1. HeroPost executes the scheduled posts across the week.
2. Operator monitors for any rejected rows; reschedules if needed.
3. Production Tracker rows transition to `Posted` after platform confirms.

## End-of-week — Performance review

**Owner.** Weekly Production Engine + operator.

Steps:

1. Capture engagement data per asset into `08_reports/performance_pulls.csv` (manual paste in v1, connector in v2).
2. Reweight Week N+2 pillar mix per `companions/12-higgsfield-visual-system` and `companions/06-social-media` performance feedback loop docs.
3. Flag top performers as `Repurpose Candidate` for Week N+3 or beyond.

## Cadence summary

| Day | Action |
|---|---|
| Fri AM | Plan next 14 days |
| Fri PM | Queue HeyGen + Higgsfield + Canva + Thumbnail prompts |
| Sat | Generate assets, poll videos, update media tracker |
| Sun AM | Insert URLs, validate, generate final CSV (only ready rows) |
| Sun PM | Human review, schedule in HeroPost |
| Mon | Content begins posting for the week |
| Thu PM | Capture mid-week engagement notes |
| Sun PM (end of week) | Performance review, reweight next week |

## Hard rules

- Plan 60 days. Produce 14 days. Schedule 7 days. Review weekly.
- No final CSV without resolved media URLs.
- No auto-publish. Jeremy approves before HeroPost import.
- No story slot publishes without an underlying Story Bank source.
- No guarantee creative without verified current config.

## Failure handling

- Connector down → fall back to manual flow documented in `connector_test_checklist.md`.
- Concept Gate blocks an asset → swap to Canva-only fallback or defer to the following week.
- Story source not Publish Ready by Friday → swap the story slot to an educational pillar and document the gap.
- Performance pull missing → use prior-week median; do not skip the reweight.

## Notification stack

- Telegram bot to Jeremy on batch queued, batch ready, schedule complete.
- Slack `#legends-content-ops` on any failure.
- SMS backup via Zapier for high-priority blockers.
