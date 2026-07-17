# Week 1 HeroPost Final Promotion Rules

**File this controls:** `06_heropost/week_1_heropost_staging_locked.csv` → `06_heropost/heropost_week_1_ready.csv`.
**Default state:** staging only. Final CSV does not exist until every gate below closes for the row.

## A staging row may move to final only when ALL of the following are true

1. **Real media URL exists.** `Media` field contains a working `https://...` URL. No `STAGING_PENDING_MEDIA`. No placeholder.
2. **Thumbnail URL exists if video.** Rows with Type `Instagram Reel`, `TikTok`, `YouTube Short`, or `YouTube Long Form` carry a real `https://...` URL in the `Thumbnail` field. Non-video rows may leave `Thumbnail` empty.
3. **Caption validated.** Caption present, plain text, escaped for CSV. No em-dashes. No banned phrases per the canonical list in `_shared/brand-dna/compliance-pack.md`.
4. **Compliance footer present if mortgage content.** Caption contains `NMLS 1195266` and `Loan Factory NMLS 320841` and `Equal Housing Lender`. Pure personal-brand / motivational / Realtor-AI-educational rows may skip.
5. **No pending media fields.** Both `Media` and (where required) `Thumbnail` resolve to real URLs.
6. **No Source Pending story IDs.** Any row whose Comment column references a story ID must point to a story currently in `story_bank_publish_ready.csv`. STORY_001 / 004 placeholders are already swapped to STORY_013 / 014, but verify before promotion.
7. **No banned phrases.** Re-run banned-phrase scan on every promoted row.
8. **HeroPost schema exact.** Header is exactly `Caption,Media,Title,Date,Link,Thumbnail,Type,Comment`. No additions, no reorderings.

## How promotion happens
1. Operator confirms `05_assets/media_url_tracker.csv` shows `status=ready` and a real URL for every Week 1 asset_id.
2. Operator (or n8n workflow once built) runs the HeroPost Scheduler over the staging CSV filtered to Week 1 dates (2026-05-25 → 2026-05-31).
3. Scheduler validates each row against all 8 gates above.
4. Rows that pass land in `06_heropost/heropost_week_1_ready.csv` with `Media` and `Thumbnail` filled.
5. Rows that fail stay in staging; the Comment column records which gate failed.

## Hard rules
- Do not edit the staging CSV header.
- Do not invent a media URL.
- Do not strip the compliance footer to fit a character cap; rewrite the body instead.
- Do not promote a row whose Comment column starts with `BLOCKED:` or `WEEK 1 LOCKED. NEEDS MEDIA URLS BEFORE FINAL UPLOAD.` until that text is replaced with a clean state.
- Drafts only until Jeremy approves the final CSV for HeroPost import.

## What this skill never does without explicit operator confirmation
- Auto-upload to HeroPost.
- Auto-publish.
- Promote a row missing any single gate.