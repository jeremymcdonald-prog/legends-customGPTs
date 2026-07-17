# Week 1 Canva Execution Packet

**Canva connector status.** Live (auth + read scope confirmed; brand kit `kADdnJbTv_M` returned in test).
**Mode.** Manual Bulk Create until brand template IDs are mapped.
**Source.** `04_prompt_banks/week_1_canva_batch_prompts.csv` (37 rows).

## Why manual not automated for this batch
- Canva connector verified at the auth/list level.
- LegendsOS template IDs in our spec (TMPL_FEED_*, TMPL_REEL_COVER_*, TMPL_GBP_*, etc.) are LOCAL identifiers. The Canva account's actual brand template IDs must be paired before autofill can run programmatically.
- Doing the first batch manually is faster than building the mapping table for 50+ templates right now.

## Operator steps
1. Open Canva.
2. Open the brand template that matches the `Template ID` column for each row below.
3. Click **Bulk Create** → upload the row group's data (one CSV per template ID).
4. Export to the agreed Drive folder. Filenames must match `Export Filename` exactly.
5. After export, paste hosted Drive URLs into `05_assets/media_url_tracker.csv` paired by `asset_id`.

## Recommended Drive folder
- Suggested name: `LegendsOS_60Day/Week_01/exports/` under jeremy@mcdonald-mtg.com.
- Confirm folder ID and paste into `media_url_tracker.csv` `host_provider` notes.

## Templates needed for Week 1 (grouped)
### TMPL_FEED_BROKER_VS_BANK_v1 (1 rows)

| Day | Platform | Headline | Accent | CTA | Export filename |
|---|---|---|---|---|---|
| DAY01 | IG_FEED | Brokers shop. Banks sell. | WE | DM NUMBERS for a second opinion on your file. | `DAY01_IG_FEED_TMPL_FEED_BROKER_VS_BANK_v1.png` |

### TMPL_FEED_DSCR_BASICS_v1 (1 rows)

| Day | Platform | Headline | Accent | CTA | Export filename |
|---|---|---|---|---|---|
| DAY04 | IG_FEED | DSCR is a business-purpose loan. | REAL | DM INVESTOR if you want to walk a property. | `DAY04_IG_FEED_TMPL_FEED_DSCR_BASICS_v1.png` |

### TMPL_FEED_FTHB_v1 (1 rows)

| Day | Platform | Headline | Accent | CTA | Export filename |
|---|---|---|---|---|---|
| DAY02 | IG_FEED | Four numbers before you tour. | ONE | DM NUMBERS for a second opinion on your file. | `DAY02_IG_FEED_TMPL_FEED_FTHB_v1.png` |

### TMPL_FEED_MORTGAGE_STORY_v1 (1 rows)

| Day | Platform | Headline | Accent | CTA | Export filename |
|---|---|---|---|---|---|
| DAY03 | IG_FEED | Consistency is a quiet brand. | CONSISTENT | DM NUMBERS for a second opinion on your file. | `DAY03_IG_FEED_TMPL_FEED_MORTGAGE_STORY_v1.png` |

### TMPL_FEED_REALTOR_AI_TIP_v1 (1 rows)

| Day | Platform | Headline | Accent | CTA | Export filename |
|---|---|---|---|---|---|
| DAY06 | IG_FEED | 5 minute listing description with AI. | 5 MIN | Comment AI for the playbook. | `DAY06_IG_FEED_TMPL_FEED_REALTOR_AI_TIP_v1.png` |

### TMPL_GBP_LOCAL_AUTHORITY_v1 (5 rows)

| Day | Platform | Headline | Accent | CTA | Export filename |
|---|---|---|---|---|---|
| DAY01 | GBP | Brokers shop. Banks sell. | WE | DM NUMBERS for a second opinion on your file. | `DAY01_GBP_TMPL_GBP_LOCAL_AUTHORITY_v1.png` |
| DAY02 | GBP | Four numbers before you tour. | ONE | DM NUMBERS for a second opinion on your file. | `DAY02_GBP_TMPL_GBP_LOCAL_AUTHORITY_v1.png` |
| DAY03 | GBP | Consistency is a quiet brand. | CONSISTENT | DM NUMBERS for a second opinion on your file. | `DAY03_GBP_TMPL_GBP_LOCAL_AUTHORITY_v1.png` |
| DAY04 | GBP | DSCR is a business-purpose loan. | REAL | DM INVESTOR if you want to walk a property. | `DAY04_GBP_TMPL_GBP_LOCAL_AUTHORITY_v1.png` |
| DAY05 | GBP | Closing day in Northeast Florida. | TODAY | Call 904-442-3213 for a straight read. | `DAY05_GBP_TMPL_GBP_LOCAL_AUTHORITY_v1.png` |

### TMPL_LINKEDIN_v1 (7 rows)

| Day | Platform | Headline | Accent | CTA | Export filename |
|---|---|---|---|---|---|
| DAY01 | LINKEDIN | Brokers shop. Banks sell. | WE | DM NUMBERS for a second opinion on your file. | `DAY01_LINKEDIN_TMPL_LINKEDIN_v1.png` |
| DAY02 | LINKEDIN | Four numbers before you tour. | ONE | DM NUMBERS for a second opinion on your file. | `DAY02_LINKEDIN_TMPL_LINKEDIN_v1.png` |
| DAY03 | LINKEDIN | Consistency is a quiet brand. | CONSISTENT | DM NUMBERS for a second opinion on your file. | `DAY03_LINKEDIN_TMPL_LINKEDIN_v1.png` |
| DAY04 | LINKEDIN | DSCR is a business-purpose loan. | REAL | DM INVESTOR if you want to walk a property. | `DAY04_LINKEDIN_TMPL_LINKEDIN_v1.png` |
| DAY05 | LINKEDIN | Closing day in Northeast Florida. | TODAY | Save this. | `DAY05_LINKEDIN_TMPL_LINKEDIN_v1.png` |
| DAY06 | LINKEDIN | 5 minute listing description with AI. | 5 MIN | Comment AI for the playbook. | `DAY06_LINKEDIN_TMPL_LINKEDIN_v1.png` |
| DAY07 | LINKEDIN | Consistency is a quiet brand. | CONSISTENT | Save this. | `DAY07_LINKEDIN_TMPL_LINKEDIN_v1.png` |

### TMPL_REEL_COVER_v1 (5 rows)

| Day | Platform | Headline | Accent | CTA | Export filename |
|---|---|---|---|---|---|
| DAY01 | IG_REEL | Brokers shop. Banks sell. | WE | DM NUMBERS for a second opinion on your file. | `DAY01_IG_REEL_TMPL_REEL_COVER_v1.jpg` |
| DAY02 | IG_REEL | Four numbers before you tour. | ONE | DM NUMBERS for a second opinion on your file. | `DAY02_IG_REEL_TMPL_REEL_COVER_v1.jpg` |
| DAY03 | IG_REEL | Consistency is a quiet brand. | CONSISTENT | DM NUMBERS for a second opinion on your file. | `DAY03_IG_REEL_TMPL_REEL_COVER_v1.jpg` |
| DAY04 | IG_REEL | DSCR is a business-purpose loan. | REAL | DM INVESTOR if you want to walk a property. | `DAY04_IG_REEL_TMPL_REEL_COVER_v1.jpg` |
| DAY05 | IG_REEL | Closing day in Northeast Florida. | TODAY | Save this. | `DAY05_IG_REEL_TMPL_REEL_COVER_v1.jpg` |

### TMPL_STORY_4_FRAME_v1 (7 rows)

| Day | Platform | Headline | Accent | CTA | Export filename |
|---|---|---|---|---|---|
| DAY01 | IG_STORY | Brokers shop. Banks sell. | WE | DM NUMBERS for a second opinion on your file. | `DAY01_IG_STORY_TMPL_STORY_4_FRAME_v1.png` |
| DAY02 | IG_STORY | Four numbers before you tour. | ONE | DM NUMBERS for a second opinion on your file. | `DAY02_IG_STORY_TMPL_STORY_4_FRAME_v1.png` |
| DAY03 | IG_STORY | Consistency is a quiet brand. | CONSISTENT | DM NUMBERS for a second opinion on your file. | `DAY03_IG_STORY_TMPL_STORY_4_FRAME_v1.png` |
| DAY04 | IG_STORY | DSCR is a business-purpose loan. | REAL | DM INVESTOR if you want to walk a property. | `DAY04_IG_STORY_TMPL_STORY_4_FRAME_v1.png` |
| DAY05 | IG_STORY | Closing day in Northeast Florida. | TODAY | Save this. | `DAY05_IG_STORY_TMPL_STORY_4_FRAME_v1.png` |
| DAY06 | IG_STORY | 5 minute listing description with AI. | 5 MIN | Comment AI for the playbook. | `DAY06_IG_STORY_TMPL_STORY_4_FRAME_v1.png` |
| DAY07 | IG_STORY | Consistency is a quiet brand. | CONSISTENT | Save this. | `DAY07_IG_STORY_TMPL_STORY_4_FRAME_v1.png` |

### TMPL_YT_LONG_THUMB_v1 (2 rows)

| Day | Platform | Headline | Accent | CTA | Export filename |
|---|---|---|---|---|---|
| DAY02 | YT_LONG | Four numbers before you tour. | ONE | DM NUMBERS for a second opinion on your file. | `DAY02_YT_LONG_TMPL_YT_LONG_THUMB_v1.jpg` |
| DAY04 | YT_LONG | DSCR is a business-purpose loan. | REAL | DM INVESTOR if you want to walk a property. | `DAY04_YT_LONG_TMPL_YT_LONG_THUMB_v1.jpg` |

### TMPL_YT_SHORT_v1 (6 rows)

| Day | Platform | Headline | Accent | CTA | Export filename |
|---|---|---|---|---|---|
| DAY01 | YT_SHORT | Brokers shop. Banks sell. | WE | DM NUMBERS for a second opinion on your file. | `DAY01_YT_SHORT_TMPL_YT_SHORT_v1.jpg` |
| DAY02 | YT_SHORT | Four numbers before you tour. | ONE | DM NUMBERS for a second opinion on your file. | `DAY02_YT_SHORT_TMPL_YT_SHORT_v1.jpg` |
| DAY03 | YT_SHORT | Consistency is a quiet brand. | CONSISTENT | DM NUMBERS for a second opinion on your file. | `DAY03_YT_SHORT_TMPL_YT_SHORT_v1.jpg` |
| DAY04 | YT_SHORT | DSCR is a business-purpose loan. | REAL | DM INVESTOR if you want to walk a property. | `DAY04_YT_SHORT_TMPL_YT_SHORT_v1.jpg` |
| DAY05 | YT_SHORT | Closing day in Northeast Florida. | TODAY | Save this. | `DAY05_YT_SHORT_TMPL_YT_SHORT_v1.jpg` |
| DAY06 | YT_SHORT | 5 minute listing description with AI. | 5 MIN | Comment AI for the playbook. | `DAY06_YT_SHORT_TMPL_YT_SHORT_v1.jpg` |

## Locked fields on every export
- NMLS 1195266
- Loan Factory NMLS 320841
- Equal Housing Lender
- VA-tagged rows include: "VA is a government benefit program. Not affiliated with or endorsed by the VA."

## Forbidden during this batch
- Editing the headline or CTA after Bulk Create unless the operator notes the change in the production tracker.
- Removing the NMLS / EHO strip.
- Placing a guarantee dollar amount on any asset (guarantee config not verified for this sprint).

## After export
1. Upload exports to Drive Week 1 folder.
2. Generate public direct-download URLs.
3. Paste URLs into `media_url_tracker.csv` for the matching `asset_id`.
4. Notify the HeroPost Scheduler (or run it) only after media URLs land.

## Hard rule
No row in `week_1_heropost_staging_locked.csv` is promoted to a final CSV until media URLs are real and validated.