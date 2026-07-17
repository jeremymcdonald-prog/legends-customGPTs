# MCP and Connector Audit — LegendsOS 60-Day Social Media Machine

Status as of 2026-05-24, this build session. The audit reports only what could be observed in this session's tool environment. Connectors marked `unknown` were not verified in this session and must be tested separately before being relied on.

## Status legend

- **available_now** — connector tools surfaced in this session's tool registry (loadable via ToolSearch). Auth may still need to complete before use.
- **needs_setup** — connector tool exists but requires authentication or configuration before first use.
- **unknown** — connector was not observable in this session; verify by attempting a connection in Cowork / Claude Code.

---

## Canva

- **Status:** available_now (tool surface present).
- **What it's used for:** Reusable templates (mortgage story, closing day, VA, FTHB, broker advantage, Realtor AI, local authority, investor, motivational, personal brand, GBP, YouTube thumbnail, Reel cover, carousels). Bulk Create runs. Asset exports.
- **Required credentials or tokens:** Canva account auth via the connector. Skill keys live in connector config.
- **Safe test action:** `mcp__f62fe56b-...__search-designs` for an existing Canva design name; no destructive action.
- **Production action:** `mcp__f62fe56b-...__generate-design`, `perform-editing-operations`, `export-design` for templates already mapped in `companions/10-canva-template-system/knowledge/canva-template-map.md`.
- **Fallback if unavailable:** Operator runs Bulk Create manually inside Canva using the CSV rows the Canva Template System emits.

## HeyGen

- **Status:** available_now via Zapier (HeyGen actions appear in the Zapier MCP tool registry under `zapier...heygen_*`). Direct HeyGen MCP not observed.
- **What it's used for:** AI avatar video rendering (Jeremy primary avatar, Inside Man / Coach / Wolf personas), short and long form.
- **Required credentials or tokens:** HeyGen account auth, Zapier account auth.
- **Safe test action:** `mcp__20bc4fd3-...__heygen_retrieve_a_video_status` against a known video ID.
- **Production action:** `mcp__20bc4fd3-...__heygen_create_an_avatar_video_generate` from a script the HeyGen Video System emitted.
- **Fallback if unavailable:** Operator renders manually in HeyGen, or Jeremy films on camera, or the slot is skipped with a documented gap.

## Higgsfield

- **Status:** unknown in this session's tool registry. The existing Creative Studio Higgsfield seam (`platform/creative-studio/higgsfield/`) is a code/spec seam; whether a live MCP or API connector is connected was not confirmed.
- **What it's used for:** Premium cinematic stills, image-to-video hooks, motion plates.
- **Required credentials or tokens:** Higgsfield account API key, or MCP server setup.
- **Safe test action:** Attempt a connection via the connector registry; if not present, plan a manual generation cycle.
- **Production action:** Generate per `companions/12-higgsfield-visual-system/knowledge/higgsfield-prompt-schema.md`, log to the `generations` table per Creative Studio policy.
- **Fallback if unavailable:** Operator generates manually in Higgsfield's UI; or substitute Canva-only for the asset; or use Visual Intelligence (`platform/visual-intelligence`) for a different generator.

## Google Drive

- **Status:** available_now (Google Drive MCP tools `mcp__4669bbc6-...__*` and Zapier Google Drive actions both present).
- **What it's used for:** Storing exported assets, sharing public URLs to assets, holding the production tracker and media URL tracker CSVs.
- **Required credentials or tokens:** Google Workspace auth (Jeremy has both Loan Factory and mcdonald-mtg.com workspaces).
- **Safe test action:** `mcp__4669bbc6-...__list_recent_files`.
- **Production action:** Upload Canva and HeyGen and Higgsfield exports; share public direct-download URLs; route URL strings into `media_url_tracker.csv`.
- **Fallback if unavailable:** Cloudflare R2 or S3 or any other hosting bucket.

## Google Sheets

- **Status:** available_now via Zapier (`mcp__20bc4fd3-...__google_sheets_*`).
- **What it's used for:** Live tracker storage if Jeremy prefers Sheets to CSV files. Performance pulls. Operator collaboration.
- **Required credentials or tokens:** Google account auth.
- **Safe test action:** `mcp__20bc4fd3-...__google_sheets_find_worksheet`.
- **Production action:** Mirror `asset_production_tracker.csv` and `media_url_tracker.csv` as Sheets for team collaboration.
- **Fallback if unavailable:** CSV files only.

## Google Business Profile

- **Status:** available_now via Zapier (`mcp__20bc4fd3-...__google_business_profile_*`).
- **What it's used for:** Posting GBP content, replying to reviews, surfacing post insights.
- **Required credentials or tokens:** GBP account ownership (the actual Jacksonville profile).
- **Safe test action:** `mcp__20bc4fd3-...__google_business_profile_make_api_get_request` to read profile.
- **Production action:** `mcp__20bc4fd3-...__google_business_profile_create_post` and `create_reply` for review responses.
- **Fallback if unavailable:** Operator posts manually via GBP web UI.

## Website CMS / blog publishing

- **Status:** unknown. mcdonald-mtg.com runs on the user's chosen CMS; whether a publish-to-CMS MCP or API is connected was not verified in this session.
- **What it's used for:** Publishing blog posts and vlog pages with schema markup.
- **Required credentials or tokens:** CMS admin / API token.
- **Safe test action:** Attempt connector search via `mcp__mcp-registry__search_mcp_registry`.
- **Production action:** Publish long form pieces, embed schema, set internal links.
- **Fallback if unavailable:** Operator publishes manually in the CMS.

## HeroPost

- **Status:** unknown. No HeroPost-specific MCP observed in this session's tool registry.
- **What it's used for:** Bulk scheduling final social posts across platforms via CSV import.
- **Required credentials or tokens:** HeroPost account.
- **Safe test action:** Check connector registry for HeroPost; if absent, mark manual.
- **Production action:** Import `heropost_week_N_ready.csv` manually until automation lands.
- **Fallback if unavailable:** Operator imports the final CSV in HeroPost UI.

## n8n

- **Status:** Jeremy operates n8n locally and on Hostinger VPS per user preferences. n8n-specific MCP tools observed (`mcp__b5aebd8f-...__*`).
- **What it's used for:** Background orchestration (watch trackers, trigger HeroPost final promotion, notifications).
- **Required credentials or tokens:** n8n API key on the operator's n8n instance.
- **Safe test action:** `mcp__b5aebd8f-...__search_workflows`.
- **Production action:** Build workflows that watch media_url_tracker, trigger HeroPost final, notify Telegram or Slack when a week's CSV is ready.
- **Fallback if unavailable:** Engine prompts operator at each handoff.

## GitHub

- **Status:** available_now via Zapier (`mcp__20bc4fd3-...__github_*`).
- **What it's used for:** Version control on the skills pack at github.com/jeremymac904.
- **Required credentials or tokens:** GitHub auth for `jeremymac904`.
- **Safe test action:** `mcp__20bc4fd3-...__github_find_repository`.
- **Production action:** Push skill updates, branch for changes, open PRs for review.
- **Fallback if unavailable:** Manual git operations from local CLI.

## Local filesystem

- **Status:** available_now via the workspace folder (`/Volumes/LegendsOS/Jeremy's_2026_Master_Build_Folder/legends-team-builds/LegendsOS Skills & CustomGPT Assist Builder/`).
- **What it's used for:** Storing skill packs, draft outputs, working files.
- **Required credentials or tokens:** None (mounted folder access already granted).
- **Safe test action:** Read of an existing file.
- **Production action:** Write skill files, output CSVs, reports.
- **Fallback if unavailable:** N/A.

## Browser automation

- **Status:** available_now (Claude in Chrome MCP `mcp__Claude_in_Chrome__*` and `mcp__Control_Chrome__*` observed).
- **What it's used for:** Fallback for any platform without an API or MCP connector (HeroPost, Higgsfield UI, CMS, GBP).
- **Required credentials or tokens:** Operator logged into target services in the controlled browser.
- **Safe test action:** `mcp__Claude_in_Chrome__list_connected_browsers`.
- **Production action:** Drive UI flows when no API exists.
- **Fallback if unavailable:** Operator performs the action manually.

## Zapier MCP (general)

- **Status:** available_now (`mcp__20bc4fd3-...__*` host of actions across Gmail, Google Calendar, GitHub, Slack, Telegram, Notion, HeyGen, Google Business Profile, Sheets, Drive, Docs, Forms, etc.).
- **What it's used for:** Cross-platform glue when no native MCP exists.
- **Required credentials or tokens:** Zapier subscription, per-action auth (750 tasks per month per user preferences).
- **Safe test action:** Any `find` or `get` action.
- **Production action:** Wire scheduled flows for notifications, performance pulls, and routine cross-platform handoffs.
- **Fallback if unavailable:** Direct API integration through n8n.

## Notion

- **Status:** available_now via Zapier (`mcp__20bc4fd3-...__notion_*`).
- **What it's used for:** Optional secondary place to log the production tracker for visibility.
- **Required credentials or tokens:** Notion workspace auth.
- **Safe test action:** `mcp__20bc4fd3-...__notion_find_page_by_title`.
- **Production action:** Mirror weekly summaries to a Notion page for visibility.
- **Fallback if unavailable:** Skip; Google Sheets or local CSV is sufficient.

## Telegram and SMS

- **Status:** available_now via Zapier (`mcp__20bc4fd3-...__telegram_*`, `sms_by_zapier_send_sms`).
- **What it's used for:** Operator notifications (week locked, week's CSV ready, blockers needing approval).
- **Required credentials or tokens:** Telegram bot setup; SMS via Zapier (rate-limited).
- **Safe test action:** Send a test message.
- **Production action:** n8n flows ping operator on key handoffs.
- **Fallback if unavailable:** Email via Gmail Zapier.

---

## Zillow review intake

- **Status:** unknown. No Zillow review scraping connector observed.
- **Plan:** Operator manually pastes reviews into the Story Bank intake. Source URL set to the Zillow profile or specific review URL.
- **Hard rule:** No scraping without explicit approval and a verified ToS-compliant connector.

## Google review intake

- **Status:** Indirect via Google Business Profile API (Zapier connector available). Verify whether the GBP API surface includes review pulls in the current Zapier action set.
- **Plan:** Operator pastes reviews into Story Bank intake; GBP API used for reply posting.

---

## Verification posture

For every connector marked `available_now`, this audit confirms only that the tools appeared in the session's tool registry. Each connector still requires:

1. Authentication completed in Cowork or Claude Code.
2. A real test action successful.
3. Operator confirmation that the bound account is the correct production account (Jeremy's Loan Factory accounts vs personal accounts).

For every connector marked `unknown`, the next setup action is:

1. Use `mcp__mcp-registry__search_mcp_registry` to look for an MCP.
2. If none, plan the manual / fallback flow documented above.
3. Re-audit after onboarding.

## How the Engine uses this audit

The Weekly Production Engine references this file before locking a week. If a critical connector is `unknown` or `needs_setup`, the Engine flags the week as `manual_mode` for the affected step and notifies the operator.
