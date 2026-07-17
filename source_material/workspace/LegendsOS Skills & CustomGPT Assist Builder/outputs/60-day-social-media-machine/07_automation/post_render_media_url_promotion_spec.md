# Post-Render Media URL Promotion Spec

**Purpose.** Define the path from exported media to a HeroPost final CSV. Designed to be operator-driven now and n8n-driven later.

## Inputs
- Exported files in operator local folders (Canva, HeyGen, Higgsfield).
- Drive folder structure under `Drive: LegendsOS_60Day/Week_01/exports/`.
- `05_assets/week_1_export_upload_map.csv` (asset_filename -> drive_folder_destination -> hosted_url).
- `05_assets/media_url_tracker.csv` (asset_id -> hosted_media_url -> status).
- `06_heropost/week_1_heropost_staging_locked.csv` (58 staging rows, schema locked).

## Pipeline

### A. Upload
1. Operator (or n8n) uploads each export to the matching Drive subfolder.
2. For each upload, generate a public direct-download URL.
3. Write the URL into `week_1_export_upload_map.csv` for the matching `asset_filename`.

### B. Reconcile to asset tracker
1. For each row in `week_1_export_upload_map.csv` where `hosted_url` is not empty:
   - Find the matching `asset_id` in `media_url_tracker.csv` via `media_url_tracker_row`.
   - Set `Hosted Media URL` = the new URL.
   - For video assets, also set `Hosted Thumbnail URL` after the thumbnail export uploads.
   - Set `Status` = `ready`.
   - Set `Uploaded At` = current ISO timestamp.
   - Set `Host Provider` = `gdrive`.

### C. HeroPost promotion
1. Load `week_1_heropost_staging_locked.csv` (58 rows).
2. For each row, look up the matching `asset_id` in `media_url_tracker.csv`.
3. If `media_url_tracker.status == ready`:
   - Replace `Media` placeholder with the real URL.
   - Replace `Thumbnail` placeholder with the real URL (video rows).
   - Replace Comment text from `WEEK 1 LOCKED...` to `WEEK 1 READY. story_source=...`.
4. Validate the row through the 8 gates in `week_1_final_promotion_rules.md`.
5. Rows that pass all 8 gates append to `06_heropost/heropost_week_1_ready.csv`.
6. Rows that fail stay in staging with the failure reason in Comment.

### D. Operator confirmation
1. Spot check 5 rows across pillars before HeroPost import.
2. Import `heropost_week_1_ready.csv` into HeroPost manually until a HeroPost connector is verified.

## Hard rules
- No URL written into `media_url_tracker.csv` without a real Drive upload.
- No row promoted to final without all 8 gates closing.
- HeroPost final CSV created only when at least 1 row qualifies. Empty CSV is not created.
- HeroPost schema header is exactly `Caption,Media,Title,Date,Link,Thumbnail,Type,Comment`.

## Automatable version (n8n target)
1. **Trigger.** Drive `file.created` webhook in any Week 1 export subfolder.
2. **Step.** Read filename, find row in `week_1_export_upload_map.csv`, write Drive URL.
3. **Step.** Update `media_url_tracker.csv` for the matching `asset_id`.
4. **Step.** Re-run HeroPost Scheduler against staging filtered to Week 1 dates.
5. **Step.** Append qualifying rows to `heropost_week_1_ready.csv`.
6. **Step.** Telegram notification to Jeremy: 'Week 1 has N rows ready for import.'

## Current state
- Pipeline B and C run as soon as one real Drive URL lands.
- Until then, every Week 1 row remains in staging with `STAGING_PENDING_MEDIA`.
- No final CSV exists. Will be created the moment the first row qualifies.