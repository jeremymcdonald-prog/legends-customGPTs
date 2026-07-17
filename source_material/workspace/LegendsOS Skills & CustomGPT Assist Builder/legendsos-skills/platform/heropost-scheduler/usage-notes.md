# Usage Notes — HeroPost Scheduler

## Two stages

- **Staging.** Where every planned post lives. `Media` and `Thumbnail` columns hold placeholders `STAGING_PENDING_MEDIA` and `STAGING_PENDING_THUMBNAIL`. Compliance flags may be open.
- **Final.** Where only ready rows go. `Media` and `Thumbnail` resolve to real hosted URLs. All compliance flags clear.

## How rows enter the system

1. Social Media or Local SEO emits a tracker row.
2. Scheduler appends it to `heropost_staging_60_day.csv`.
3. Production engine fills the media URLs via `media_url_tracker.csv`.
4. Scheduler promotes ready rows to `heropost_week_N_ready.csv`.

## How to ask the skill for things

- "Stage Week 2 rows."
- "Promote Week 1 ready rows to final."
- "Validate the staging CSV."
- "Show me what's blocking Week 2."
- "Generate the Week 1 final CSV."

## Validation report

Markdown report with:

- Total rows in staging.
- Rows ready to promote.
- Rows blocked (and reason).
- Compliance flags still open.
- Hosted URL coverage.
- Platform distribution.

## What the skill never does

- Auto-upload to HeroPost.
- Edit captions.
- Edit the schema header.
- Invent a media URL.
- Promote a row that lacks a media URL.
