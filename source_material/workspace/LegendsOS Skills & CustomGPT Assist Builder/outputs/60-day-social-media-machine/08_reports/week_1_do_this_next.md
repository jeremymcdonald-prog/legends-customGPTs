# Week 1 - Do This Next

1. Open Canva.
2. Upload `week_1_canva_bulk_create_feed_static.csv` into Bulk Create with the matching brand template. Export all rows to Drive: `LegendsOS_60Day/Week_01/exports/Feed_static/`.
3. Repeat step 2 for: `gbp_static`, `linkedin_static`, `story_static`, `reel_cover`, `youtube_thumbnail` (each CSV in `05_assets/`). TikTok reuses the Reel cover, so no separate TikTok Bulk Create run is needed.
4. After each Canva export, copy the Drive shareable URL into `05_assets/week_1_export_upload_map.csv` for the matching `export_filename`.
5. Open HeyGen. Run the one test render from `05_assets/week_1_heygen_test_prompt.md` (payload in `week_1_heygen_test_payload.json`).
6. If the test render passes, submit the remaining 18 HeyGen prompts from `week_1_heygen_batch_after_test_packet.md`. If it fails, hold the batch and film Friday on camera as backup.
7. Open Higgsfield. Generate the 3 plates from `05_assets/week_1_higgsfield_manual_packet.md`. Download to Drive: `LegendsOS_60Day/Week_01/exports/Higgsfield/`.
8. Copy all Drive shareable URLs into `05_assets/media_url_tracker.csv` for the matching `asset_id`. Set `status=ready`.
9. Run the HeroPost Scheduler validation against `06_heropost/week_1_heropost_staging_locked.csv` per `06_heropost/week_1_final_promotion_rules.md`.
10. Only rows that pass all 8 gates land in `06_heropost/heropost_week_1_ready.csv`. Do not import anything that has not passed.
11. Spot check 5 rows across pillars (story, broker advantage, local, VA, personal). Confirm captions and footers.
12. Import `heropost_week_1_ready.csv` into HeroPost manually.