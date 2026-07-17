# Connector Test Checklist

Run this checklist before Week 1 dispatch. Do not claim a connector is working unless the safe test action returns a real response from the bound account.

Status legend:

- **available_now** — tool surface observable in this session's registry. Auth may still need to complete.
- **needs_setup** — connector exists but requires authentication or configuration before first use.
- **unknown** — connector not observable in this session; verify by attempting a connection.

---

## Canva

- **Status.** available_now (Canva MCP tool surface present).
- **Safe test action.** Search an existing design by name; no destructive call.
- **Production action.** Run Bulk Create against `week_1_canva_batch_prompts.csv`. Export to operator folder.
- **Required credential.** Canva account auth (production account, not personal).
- **Fallback.** Operator runs Bulk Create manually inside Canva using the CSV rows.

## HeyGen

- **Status.** available_now via Zapier (`heygen_*` actions present in Zapier MCP).
- **Safe test action.** `heygen_retrieve_a_video_status` against any known video ID.
- **Production action.** Submit Week 1 scripts via `heygen_create_an_avatar_video_generate`; poll until done; pull video URLs.
- **Required credential.** HeyGen account auth + Zapier auth.
- **Fallback.** Operator submits manually in HeyGen UI. If HeyGen unavailable, Jeremy films on camera.

## Higgsfield

- **Status.** unknown (no Higgsfield-specific connector observable in this session).
- **Safe test action.** Check `mcp__mcp-registry__search_mcp_registry` for "higgsfield"; if absent, plan manual generation.
- **Production action.** Generate the 3 Week 1 Higgsfield prompts after Concept Gate clearance.
- **Required credential.** Higgsfield account or API key.
- **Fallback.** Operator generates manually in Higgsfield UI. If unavailable for the week, substitute Canva-only assets for those Higgsfield slots and document the swap.

## Google Drive

- **Status.** available_now (Google Drive MCP + Zapier actions both present).
- **Safe test action.** `mcp__4669bbc6-...__list_recent_files` on the bound account.
- **Production action.** Upload all Canva, HeyGen, Higgsfield exports. Generate public direct-download URLs. Write to `05_assets/media_url_tracker.csv`.
- **Required credential.** Google Workspace auth (Loan Factory or mcdonald-mtg.com workspace).
- **Fallback.** Cloudflare R2, S3, or any operator-controlled hosting bucket.

## Google Sheets

- **Status.** available_now via Zapier (`google_sheets_*`).
- **Safe test action.** `google_sheets_find_worksheet`.
- **Production action.** Mirror `asset_production_tracker.csv` and `media_url_tracker.csv` as Sheets for team collaboration.
- **Required credential.** Google account auth.
- **Fallback.** Local CSV-only operation.

## Google Business Profile

- **Status.** available_now via Zapier (`google_business_profile_*`).
- **Safe test action.** `google_business_profile_make_api_get_request` to read the profile.
- **Production action.** Post GBP rows; reply to reviews.
- **Required credential.** GBP account ownership (the Jeremy McDonald / Legends Mortgage Team profile).
- **Fallback.** Operator posts manually via GBP web UI.

## HeroPost

- **Status.** unknown (no HeroPost-specific connector observable in this session).
- **Safe test action.** Check connector registry; otherwise plan manual import.
- **Production action.** Operator imports `heropost_week_N_ready.csv` manually until automation lands.
- **Required credential.** HeroPost account.
- **Fallback.** Manual CSV import is the assumed flow.

## n8n

- **Status.** available_now (n8n MCP tool surface present).
- **Safe test action.** `search_workflows` to list current workflows.
- **Production action.** Build the 7 workflows in `n8n_weekly_batch_spec.md` once connectors are verified.
- **Required credential.** n8n API key on Jeremy's local or Hostinger VPS instance.
- **Fallback.** Engine prompts the operator at each handoff manually.

## Website CMS or blog publishing path

- **Status.** unknown (CMS publish path not verified in this session).
- **Safe test action.** Use `mcp__mcp-registry__search_mcp_registry` for the CMS in use (WordPress, Webflow, Framer, Squarespace, etc.).
- **Production action.** Publish Week 1 long-form pieces with schema, internal links, and footer.
- **Required credential.** CMS admin or API token.
- **Fallback.** Operator publishes manually in the CMS.

## GitHub

- **Status.** available_now via Zapier (`github_*`).
- **Safe test action.** `github_find_repository` for `jeremymac904`.
- **Production action.** Version-control skill packs and outputs on github.com/jeremymac904.
- **Required credential.** GitHub auth for `jeremymac904`.
- **Fallback.** Manual git operations from local CLI.

## Local filesystem

- **Status.** available_now (workspace folder mounted at `/Volumes/LegendsOS/Jeremy's_2026_Master_Build_Folder/legends-team-builds/LegendsOS Skills & CustomGPT Assist Builder/`).
- **Safe test action.** List a known file.
- **Production action.** Write skill files, batch CSVs, validation reports.
- **Required credential.** None (folder already granted).
- **Fallback.** N/A.

---

## Test order for Week 1 dispatch

1. Google Drive — confirm upload + share URL flow.
2. Google Sheets — confirm tracker mirror works (optional).
3. Canva — confirm Bulk Create flow on a single test template.
4. HeyGen — confirm a single test render via Zapier action.
5. Higgsfield — confirm UI access or registry presence; document fallback.
6. Google Business Profile — confirm the bound profile is the production profile.
7. HeroPost — confirm account access and manual CSV import path.
8. n8n — confirm the instance is reachable; defer workflow builds until connectors above are verified.
9. Website CMS — confirm operator publish path for blog/vlog.
10. GitHub — confirm `jeremymac904` repo access for versioning.

## Hard rule

Do not mark any connector "verified" in the Weekly Production Engine until the safe test action returns a real response from the bound production account. Unverified connectors fall through to the documented fallback.
