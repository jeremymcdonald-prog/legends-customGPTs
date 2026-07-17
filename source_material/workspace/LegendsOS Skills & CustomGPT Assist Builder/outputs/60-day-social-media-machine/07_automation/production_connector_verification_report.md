# Production Connector Verification Report

**Run date.** 2026-05-24.
**Scope.** Real safe-test calls only. No fabricated results.

## Verified live (3)

### Canva — verified_auth
- **Safe test action.** list-brand-kits (Canva MCP)
- **Test result.** PASS - returned 1 brand kit (id: kADdnJbTv_M). Auth + read scope confirmed.
- **Production action.** Run autofill-design / generate-design or manual Bulk Create on the 37 Week 1 prompts.
- **Fallback.** Operator runs Bulk Create manually in Canva UI using the prompts file.
- **Blocker.** Brand kit thumbnail returned but the actual template IDs we use (TMPL_FEED_*, TMPL_REEL_COVER_*, etc.) must be mapped to real Canva brand template IDs before autofill works.
- **Next required human action.** Confirm or create the Canva brand templates listed in canva-template-map.md inside the Canva account; capture their Canva-side template IDs.

### Google Drive — verified_live
- **Safe test action.** list_recent_files (pageSize=1)
- **Test result.** PASS - returned Jeremy's 'LO Development YouTube Upload Manifest' file under jeremy@mcdonald-mtg.com. Auth confirmed.
- **Production action.** Upload Canva, HeyGen, Higgsfield exports. Generate public direct-download URLs. Write URLs into media_url_tracker.csv.
- **Fallback.** Cloudflare R2 or S3 or any operator-controlled bucket.
- **Blocker.** Target folder for Week 1 exports not yet defined.
- **Next required human action.** Create or pick a Drive folder for Week 1 exports and note its folder ID.

### n8n — verified_live
- **Safe test action.** search_workflows (limit=1)
- **Test result.** PASS - returned 1 workflow named 'My workflow', 89 total workflows in account.
- **Production action.** Build the 7 weekly batch workflows from n8n_weekly_batch_spec.md once Canva, HeyGen, Higgsfield, HeroPost auth is confirmed.
- **Fallback.** Engine prompts operator at each handoff manually (current state).
- **Blocker.** Workflows in this account are not yet authoring the LegendsOS batch flow.
- **Next required human action.** Defer n8n workflow build until at least Canva + Drive + HeyGen auth is fully confirmed end-to-end.

## Needs setup or unknown (5)

### HeyGen (via Zapier) — needs_setup
- **Safe test action.** Discovery-only test attempted; HeyGen Zapier actions all require a video ID or other input so a zero-cost safe test is not available.
- **Test result.** UNVERIFIED - auth state inferred from Zapier MCP presence but not confirmed.
- **Production action.** heygen_create_an_avatar_video_generate then heygen_retrieve_a_video_status polling.
- **Fallback.** Operator renders manually in HeyGen UI from the 19 prompts in week_1_heygen_batch_prompts.csv. Jeremy on camera as backup.
- **Blocker.** Cannot safely confirm HeyGen auth without consuming render credits. Avatar identity not confirmed in this session.
- **Next required human action.** Open HeyGen, confirm Jeremy's primary avatar is approved, then submit one test render from prompt row 1 in week_1_heygen_batch_prompts.csv.

### Higgsfield — unknown
- **Safe test action.** No Higgsfield connector observed in this session's tool registry.
- **Test result.** FAIL - no connector available.
- **Production action.** Generate the 3 Week 1 premium plates in Higgsfield UI after Concept Gate clears.
- **Fallback.** Operator generates manually. Or substitute Canva-only assets for those slots.
- **Blocker.** No API or MCP path observed.
- **Next required human action.** Generate the 3 Higgsfield prompts in week_1_higgsfield_batch_prompts.csv manually in Higgsfield's UI.

### Google Sheets — available_via_zapier
- **Safe test action.** Same Google Workspace auth as Drive; tested implicitly by Drive PASS.
- **Test result.** INHERITED PASS - same auth tier as Drive.
- **Production action.** Mirror media_url_tracker and asset_production_tracker as Sheets for team collaboration.
- **Fallback.** Local CSV only operation (already the default).
- **Blocker.** Sheets mirror not required for v1; CSVs are sufficient.
- **Next required human action.** Skip until Week 2 unless team collaboration is needed.

### HeroPost — unknown
- **Safe test action.** No HeroPost MCP or API connector observed.
- **Test result.** FAIL - no connector.
- **Production action.** Operator imports week_1_heropost_staging_locked.csv manually into HeroPost.
- **Fallback.** Manual CSV import (the assumed v1 flow).
- **Blocker.** No automation path. Manual import required.
- **Next required human action.** Hold until Week 1 media URLs land; then promote staging to final and import manually.

### Website CMS / blog publishing — unknown
- **Safe test action.** Fetched https://www.mcdonald-mtg.com/en — returned page meta but full body was not exposed via WebFetch.
- **Test result.** UNVERIFIED - CMS not identified.
- **Production action.** Publish Week 1 long-form pieces with schema and footer.
- **Fallback.** Operator publishes manually in the CMS admin.
- **Blocker.** CMS platform identity unknown; no admin connector observed.
- **Next required human action.** Tell Claude which CMS the website runs on (Webflow, WordPress, Framer, Squarespace, Wix, Sanity, custom) so the publish path can be mapped.

## Hard rules respected in this verification
- No publishing.
- No HeroPost upload.
- No fabricated test results.
- No invented connector status.
- No render-credit consumption (HeyGen was NOT called with create actions).

## Recommendation
Proceed with manual execution packets for Week 1. Use the Canva live connector for confirmation testing on a single design before queueing all 37. HeyGen and Higgsfield run manually until end-to-end auth + render cost is confirmed.