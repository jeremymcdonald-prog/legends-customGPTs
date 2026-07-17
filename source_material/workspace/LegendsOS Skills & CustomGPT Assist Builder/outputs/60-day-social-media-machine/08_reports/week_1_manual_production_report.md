# Week 1 Manual Production Report

**Run date.** 2026-05-24.
**Goal.** Fewest possible manual moves to produce Week 1 media without publishing or uploading anything.

## The fewest production moves

Jeremy or his operator only needs to make **10 moves** to get all Week 1 media produced:
1. Run Canva Bulk Create: **Feed static** (5 assets).
2. Run Canva Bulk Create: **GBP static** (5 assets).
3. Run Canva Bulk Create: **LinkedIn static** (7 assets).
4. Run Canva Bulk Create: **Story static** (7 assets).
5. Run Canva Bulk Create: **Reel cover** (5 assets).
6. Run Canva Bulk Create: **YouTube short thumbnail** (6 assets).
7. Run Canva Bulk Create: **YouTube long thumbnail** (2 assets).
8. Run HeyGen test: **1 video** (the Day 1 broker advantage Reel).
9. Run Higgsfield: **3 premium plates** in the UI.
10. After the HeyGen test passes, queue the remaining **18 HeyGen videos** in one batch.

## Which tool to open first
**Canva.** It is the only verified connector and produces the largest share of Week 1 assets. Static images, GBP images, LinkedIn, Story frames, Reel covers, and thumbnails all live here.

## Which packet to use first
`05_assets/week_1_canva_bulk_create_grouped_packet.md`. Start with the **Feed static** group. Bulk Create CSV is already in the packet.

## Which assets can be produced now
- **37 Canva assets** across 7 operator groups.
  - Feed static: 5
  - GBP static: 5
  - LinkedIn static: 7
  - Story static: 7
  - Reel cover: 5
  - YouTube short thumbnail: 6
  - YouTube long thumbnail: 2

## Which assets are blocked
- **1 HeyGen test render**: pending operator open + render-credit consumption.
- **18 HeyGen batch renders**: HOLD UNTIL TEST PASSES.
- **3 Higgsfield premium plates**: manual UI generation only (no connector observed).

## What not to touch yet
- Do not promote any HeroPost staging row to final.
- Do not invent media URLs.
- Do not run the HeyGen batch before the test render passes.
- Do not upload anything to HeroPost (no connector + no real URLs yet).

## What was created this sprint
1. `05_assets/week_1_operator_master_queue.csv`: single ranked queue across all tools.
2. `05_assets/week_1_canva_bulk_create_grouped_packet.md`: 5 grouped Bulk Create runs.
3. `05_assets/week_1_heygen_test_render_packet.md`: the single test prompt + pass/fail criteria.
4. `05_assets/week_1_heygen_batch_after_test_packet.md`: remaining 18 prompts on HOLD.
5. `05_assets/week_1_higgsfield_manual_packet.md`: 3 premium plates copy-paste.
6. `05_assets/week_1_export_upload_map.csv`: single upload tracker for all exports.
7. `06_heropost/week_1_final_promotion_rules.md`: 8 gates for staging → final.
8. `08_reports/week_1_manual_production_report.md`: this file.

## Compliance state (re-verified)
- HeroPost schema: PASS.
- Banned phrases: 0 hits.
- Em-dashes: 0 hits.
- Premature final-ready rows: 0.
- Invented media URLs: 0.
- HeroPost upload: not performed.

## Exact next action
Open Canva. Open `05_assets/week_1_canva_bulk_create_grouped_packet.md`. Run the Feed static group first. Export to Drive folder `Drive: LegendsOS_60Day/Week_01/exports/Feed_static/`. Then move to the next Canva group.