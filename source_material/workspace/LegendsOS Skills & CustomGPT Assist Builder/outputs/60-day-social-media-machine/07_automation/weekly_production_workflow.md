# Weekly Production Workflow

The 7-step loop the Weekly Production Engine runs each week of the 60-day plan.

## Step 1 — Plan and lock

- Engine pulls the next 7-day window from `60_day_master_calendar.csv`.
- Confirms pillar mix, story slots, local angles, long form slots.
- Pulls publish-ready Story Bank source IDs.
- Operator (Jeremy) approves.
- Engine marks Week N `locked`.

## Step 2 — Caption and script generation

- Engine dispatches each day's seed to the Social Media skill.
- Engine dispatches each long-form topic to the Local SEO skill.
- Engine dispatches each video to the HeyGen Video skill.
- Outputs land in `60_day_caption_bank.csv`, `60_day_reel_script_bank.csv`, `60_day_heygen_prompt_bank.csv` (week N rows).

## Step 3 — Canva fill

- Engine dispatches Bulk Create rows to the Canva Template System.
- Operator runs Bulk Create in Canva, exports.
- Exports land in operator's working folder, filenames per `asset-export-rules.md`.

## Step 4 — Higgsfield generation

- Engine dispatches 3 to 6 Higgsfield prompts (per Week 1 batch defaults).
- Concept Gate runs.
- Operator generates in Higgsfield, downloads.

## Step 5 — HeyGen render

- Engine dispatches scripts to HeyGen.
- Operator submits in HeyGen, downloads renders.

## Step 6 — Media URL fill

- Operator uploads all exports to hosting bucket (Drive default).
- Operator (or n8n watcher) updates `media_url_tracker.csv` with each URL + status `ready`.

## Step 7 — HeroPost final and schedule

- Engine calls HeroPost Scheduler to promote Week N staging rows to `heropost_week_N_ready.csv`.
- Scheduler validates Media + Thumbnail + compliance + schema.
- Operator imports the final CSV into HeroPost.
- Production tracker rows move to `Scheduled`.

## After the week — Performance review

- Engine pulls performance data (manual paste in v1, connector later).
- Engine reweights Week N+1 pillar mix per `performance-feedback-loop.md`.

## Hard rules across all steps

- No auto-publish.
- No skipped compliance gate.
- No invented data.
- No final CSV without resolved media URLs.

## Cadence

- Monday: plan and lock Week N+1.
- Tuesday: captions and scripts.
- Wednesday: Canva and Higgsfield generation.
- Thursday: HeyGen render and media URL fill.
- Friday: HeroPost final CSV + operator import.
- Saturday: Week N posts running; performance pulls staged.
- Sunday: performance review and reweighting for Week N+2.
