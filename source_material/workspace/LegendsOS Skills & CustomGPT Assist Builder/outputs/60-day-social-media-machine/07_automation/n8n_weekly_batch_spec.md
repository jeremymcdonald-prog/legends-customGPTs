# n8n Weekly Batch Spec

Reference automation spec for n8n. The Engine drives manually in v1; n8n adopts the choreography in v2.

## Workflow 1 — Week Lock Notification

- **Trigger:** Schedule (Mondays 06:00 ET).
- **Steps:**
  1. Read `60_day_master_calendar.csv` for Week N+1.
  2. Compose Telegram message: "Week N+1 ready for approval. Pillar mix: ..."
  3. Send to Jeremy via Telegram bot.
  4. Wait for `lock_status = locked` write in Sheets mirror.
- **Failure handling:** Slack alert if no lock by Monday 22:00 ET.

## Workflow 2 — Story Bank Pull

- **Trigger:** Webhook from Engine after lock.
- **Steps:**
  1. Read story slot list for the locked week.
  2. Query Story Bank (Notion or local CSV) for publish-ready source IDs matching the framework requested.
  3. If a slot's source ID is missing, write a `STORY_PENDING` row to the week's tracker and notify Jeremy.

## Workflow 3 — Canva Bulk Create Dispatch

- **Trigger:** Webhook from Engine after captions and scripts are in.
- **Steps:**
  1. Read this week's rows from `60_day_canva_prompt_bank.csv`.
  2. Group by Template ID.
  3. POST each Bulk Create CSV to the Canva connector (when verified).
  4. Watch job status; when complete, write hosted URLs to `media_url_tracker.csv`.
- **Failure handling:** If the Canva connector errors, post a Slack notification with the failing rows and the recommended manual workaround.

## Workflow 4 — HeyGen Render

- **Trigger:** Webhook from Engine after scripts are in.
- **Steps:**
  1. Read this week's rows from `60_day_heygen_prompt_bank.csv`.
  2. POST to Zapier HeyGen action (`heygen_create_an_avatar_video_generate`).
  3. Poll `heygen_retrieve_a_video_status` until done.
  4. Pull rendered video URL.
  5. Write hosted URL to `media_url_tracker.csv`.

## Workflow 5 — Higgsfield Generation

- **Trigger:** Webhook from Engine after Concept Gate clearance.
- **Steps:**
  1. Read this week's rows from `60_day_higgsfield_prompt_bank.csv` filtered to `concept_gate_status = cleared`.
  2. POST to Higgsfield (when connector verified).
  3. Receive draft asset URL.
  4. Write to `media_url_tracker.csv` with status `pending` until Asset Gate clears.

## Workflow 6 — HeroPost Promote and Notify

- **Trigger:** Schedule (Fridays 09:00 ET) or webhook when `media_url_tracker.csv` reports zero pending for the week.
- **Steps:**
  1. Read `heropost_staging_60_day.csv` filtered to Week N.
  2. Validate every row per `validation-rules.md`.
  3. Promote rows with resolved Media + Thumbnail to `heropost_week_N_ready.csv`.
  4. Notify Jeremy via Telegram: "Week N final CSV ready for import. {count} rows."

## Workflow 7 — Performance Pull

- **Trigger:** Schedule (Sundays 20:00 ET).
- **Steps:**
  1. Pull engagement data from each platform's analytics API (Meta, IG Graph, YouTube, GBP, LinkedIn).
  2. Append to `performance_pulls.csv`.
  3. Notify Engine to run the reweighting cycle.

## Failure escalation

- Every workflow logs to a Slack `#legends-content-ops` channel.
- Each failure includes the `request_id`, the failing row, and the recommended manual recovery step.
- Telegram backup notification if Slack delivery fails.

## Authentication

- Each workflow runs as a service account.
- Tokens stored in n8n credentials, never inline in workflow JSON.
- Per per `_shared/brand-dna/compliance-pack.md`, no secrets in payloads.

## v1 vs v2

- v1: Engine prompts operator at each handoff. No n8n workflows running yet.
- v2: Workflows 1, 3, 4, 6, 7 light up. Workflows 2 and 5 follow when connectors land.
