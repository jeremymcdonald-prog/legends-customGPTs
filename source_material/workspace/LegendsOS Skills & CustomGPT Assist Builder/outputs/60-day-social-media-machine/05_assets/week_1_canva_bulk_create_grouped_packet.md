# Week 1 Canva Bulk Create: Grouped Packet

**Connector status.** Canva verified (auth + read scope).
**Mode.** Manual Bulk Create grouped by operator group. One run per group, not 37 individual runs.
**Source.** `04_prompt_banks/week_1_canva_batch_prompts.csv` (37 rows total).
**Export destination.** `Drive: LegendsOS_60Day/Week_01/exports/` (under jeremy@mcdonald-mtg.com).

## Run order (Canva-only, do all 5 groups before touching HeyGen)

### 1. Feed static

- **Number of assets.** 5
- **Required Canva template(s).** `TMPL_FEED_BROKER_VS_BANK_v1`, `TMPL_FEED_DSCR_BASICS_v1`, `TMPL_FEED_FTHB_v1`, `TMPL_FEED_MORTGAGE_STORY_v1`, `TMPL_FEED_REALTOR_AI_TIP_v1`
- **CSV rows needed.** 5 (one row per asset; use the Bulk Create CSV columns headline / accent_word / cta / nmls_block / eho_block / disclaimer_block).
- **Export format.** png
- **Where to save exports.** `Drive: LegendsOS_60Day/Week_01/exports/Feed_static/`

**Asset filenames (exact):**
```
DAY01_IG_FEED_TMPL_FEED_BROKER_VS_BANK_v1.png
DAY02_IG_FEED_TMPL_FEED_FTHB_v1.png
DAY03_IG_FEED_TMPL_FEED_MORTGAGE_STORY_v1.png
DAY04_IG_FEED_TMPL_FEED_DSCR_BASICS_v1.png
DAY06_IG_FEED_TMPL_FEED_REALTOR_AI_TIP_v1.png
```

**Copy-paste prompt template for this group (Bulk Create CSV rows):**
```csv
headline,accent_word,cta,nmls_block,eho_block,disclaimer_block,export_filename
Brokers shop. Banks sell.,WE,DM NUMBERS for a second opinion on your file.,NMLS 1195266 | Loan Factory NMLS 320841,Equal Housing Lender,none,DAY01_IG_FEED_TMPL_FEED_BROKER_VS_BANK_v1.png
Four numbers before you tour.,ONE,DM NUMBERS for a second opinion on your file.,NMLS 1195266 | Loan Factory NMLS 320841,Equal Housing Lender,none,DAY02_IG_FEED_TMPL_FEED_FTHB_v1.png
Consistency is a quiet brand.,CONSISTENT,DM NUMBERS for a second opinion on your file.,NMLS 1195266 | Loan Factory NMLS 320841,Equal Housing Lender,none,DAY03_IG_FEED_TMPL_FEED_MORTGAGE_STORY_v1.png
DSCR is a business-purpose loan.,REAL,DM INVESTOR if you want to walk a property.,NMLS 1195266 | Loan Factory NMLS 320841,Equal Housing Lender,For business-purpose lending. Terms differ from consumer loans.,DAY04_IG_FEED_TMPL_FEED_DSCR_BASICS_v1.png
5 minute listing description with AI.,5 MIN,Comment AI for the playbook.,NMLS 1195266 | Loan Factory NMLS 320841,Equal Housing Lender,none,DAY06_IG_FEED_TMPL_FEED_REALTOR_AI_TIP_v1.png
```

### 2. GBP static

- **Number of assets.** 5
- **Required Canva template(s).** `TMPL_GBP_LOCAL_AUTHORITY_v1`
- **CSV rows needed.** 5 (one row per asset; use the Bulk Create CSV columns headline / accent_word / cta / nmls_block / eho_block / disclaimer_block).
- **Export format.** png
- **Where to save exports.** `Drive: LegendsOS_60Day/Week_01/exports/GBP_static/`

**Asset filenames (exact):**
```
DAY01_GBP_TMPL_GBP_LOCAL_AUTHORITY_v1.png
DAY02_GBP_TMPL_GBP_LOCAL_AUTHORITY_v1.png
DAY03_GBP_TMPL_GBP_LOCAL_AUTHORITY_v1.png
DAY04_GBP_TMPL_GBP_LOCAL_AUTHORITY_v1.png
DAY05_GBP_TMPL_GBP_LOCAL_AUTHORITY_v1.png
```

**Copy-paste prompt template for this group (Bulk Create CSV rows):**
```csv
headline,accent_word,cta,nmls_block,eho_block,disclaimer_block,export_filename
Brokers shop. Banks sell.,WE,DM NUMBERS for a second opinion on your file.,NMLS 1195266 | Loan Factory NMLS 320841,Equal Housing Lender,none,DAY01_GBP_TMPL_GBP_LOCAL_AUTHORITY_v1.png
Four numbers before you tour.,ONE,DM NUMBERS for a second opinion on your file.,NMLS 1195266 | Loan Factory NMLS 320841,Equal Housing Lender,none,DAY02_GBP_TMPL_GBP_LOCAL_AUTHORITY_v1.png
Consistency is a quiet brand.,CONSISTENT,DM NUMBERS for a second opinion on your file.,NMLS 1195266 | Loan Factory NMLS 320841,Equal Housing Lender,none,DAY03_GBP_TMPL_GBP_LOCAL_AUTHORITY_v1.png
DSCR is a business-purpose loan.,REAL,DM INVESTOR if you want to walk a property.,NMLS 1195266 | Loan Factory NMLS 320841,Equal Housing Lender,For business-purpose lending. Terms differ from consumer loans.,DAY04_GBP_TMPL_GBP_LOCAL_AUTHORITY_v1.png
Closing day in Northeast Florida.,TODAY,Call 904-442-3213 for a straight read.,NMLS 1195266 | Loan Factory NMLS 320841,Equal Housing Lender,none,DAY05_GBP_TMPL_GBP_LOCAL_AUTHORITY_v1.png
```

### 3. LinkedIn static

- **Number of assets.** 7
- **Required Canva template(s).** `TMPL_LINKEDIN_v1`
- **CSV rows needed.** 7 (one row per asset; use the Bulk Create CSV columns headline / accent_word / cta / nmls_block / eho_block / disclaimer_block).
- **Export format.** png
- **Where to save exports.** `Drive: LegendsOS_60Day/Week_01/exports/LinkedIn_static/`

**Asset filenames (exact):**
```
DAY01_LINKEDIN_TMPL_LINKEDIN_v1.png
DAY02_LINKEDIN_TMPL_LINKEDIN_v1.png
DAY03_LINKEDIN_TMPL_LINKEDIN_v1.png
DAY04_LINKEDIN_TMPL_LINKEDIN_v1.png
DAY05_LINKEDIN_TMPL_LINKEDIN_v1.png
DAY06_LINKEDIN_TMPL_LINKEDIN_v1.png
DAY07_LINKEDIN_TMPL_LINKEDIN_v1.png
```

**Copy-paste prompt template for this group (Bulk Create CSV rows):**
```csv
headline,accent_word,cta,nmls_block,eho_block,disclaimer_block,export_filename
Brokers shop. Banks sell.,WE,DM NUMBERS for a second opinion on your file.,NMLS 1195266 | Loan Factory NMLS 320841,Equal Housing Lender,none,DAY01_LINKEDIN_TMPL_LINKEDIN_v1.png
Four numbers before you tour.,ONE,DM NUMBERS for a second opinion on your file.,NMLS 1195266 | Loan Factory NMLS 320841,Equal Housing Lender,none,DAY02_LINKEDIN_TMPL_LINKEDIN_v1.png
Consistency is a quiet brand.,CONSISTENT,DM NUMBERS for a second opinion on your file.,NMLS 1195266 | Loan Factory NMLS 320841,Equal Housing Lender,none,DAY03_LINKEDIN_TMPL_LINKEDIN_v1.png
DSCR is a business-purpose loan.,REAL,DM INVESTOR if you want to walk a property.,NMLS 1195266 | Loan Factory NMLS 320841,Equal Housing Lender,For business-purpose lending. Terms differ from consumer loans.,DAY04_LINKEDIN_TMPL_LINKEDIN_v1.png
Closing day in Northeast Florida.,TODAY,Save this.,NMLS 1195266 | Loan Factory NMLS 320841,Equal Housing Lender,none,DAY05_LINKEDIN_TMPL_LINKEDIN_v1.png
5 minute listing description with AI.,5 MIN,Comment AI for the playbook.,NMLS 1195266 | Loan Factory NMLS 320841,Equal Housing Lender,none,DAY06_LINKEDIN_TMPL_LINKEDIN_v1.png
Consistency is a quiet brand.,CONSISTENT,Save this.,NMLS 1195266 | Loan Factory NMLS 320841,Equal Housing Lender,none,DAY07_LINKEDIN_TMPL_LINKEDIN_v1.png
```

### 4. Story static

- **Number of assets.** 7
- **Required Canva template(s).** `TMPL_STORY_4_FRAME_v1`
- **CSV rows needed.** 7 (one row per asset; use the Bulk Create CSV columns headline / accent_word / cta / nmls_block / eho_block / disclaimer_block).
- **Export format.** png
- **Where to save exports.** `Drive: LegendsOS_60Day/Week_01/exports/Story_static/`

**Asset filenames (exact):**
```
DAY01_IG_STORY_TMPL_STORY_4_FRAME_v1.png
DAY02_IG_STORY_TMPL_STORY_4_FRAME_v1.png
DAY03_IG_STORY_TMPL_STORY_4_FRAME_v1.png
DAY04_IG_STORY_TMPL_STORY_4_FRAME_v1.png
DAY05_IG_STORY_TMPL_STORY_4_FRAME_v1.png
DAY06_IG_STORY_TMPL_STORY_4_FRAME_v1.png
DAY07_IG_STORY_TMPL_STORY_4_FRAME_v1.png
```

**Copy-paste prompt template for this group (Bulk Create CSV rows):**
```csv
headline,accent_word,cta,nmls_block,eho_block,disclaimer_block,export_filename
Brokers shop. Banks sell.,WE,DM NUMBERS for a second opinion on your file.,NMLS 1195266 | Loan Factory NMLS 320841,Equal Housing Lender,none,DAY01_IG_STORY_TMPL_STORY_4_FRAME_v1.png
Four numbers before you tour.,ONE,DM NUMBERS for a second opinion on your file.,NMLS 1195266 | Loan Factory NMLS 320841,Equal Housing Lender,none,DAY02_IG_STORY_TMPL_STORY_4_FRAME_v1.png
Consistency is a quiet brand.,CONSISTENT,DM NUMBERS for a second opinion on your file.,NMLS 1195266 | Loan Factory NMLS 320841,Equal Housing Lender,none,DAY03_IG_STORY_TMPL_STORY_4_FRAME_v1.png
DSCR is a business-purpose loan.,REAL,DM INVESTOR if you want to walk a property.,NMLS 1195266 | Loan Factory NMLS 320841,Equal Housing Lender,For business-purpose lending. Terms differ from consumer loans.,DAY04_IG_STORY_TMPL_STORY_4_FRAME_v1.png
Closing day in Northeast Florida.,TODAY,Save this.,NMLS 1195266 | Loan Factory NMLS 320841,Equal Housing Lender,none,DAY05_IG_STORY_TMPL_STORY_4_FRAME_v1.png
5 minute listing description with AI.,5 MIN,Comment AI for the playbook.,NMLS 1195266 | Loan Factory NMLS 320841,Equal Housing Lender,none,DAY06_IG_STORY_TMPL_STORY_4_FRAME_v1.png
Consistency is a quiet brand.,CONSISTENT,Save this.,NMLS 1195266 | Loan Factory NMLS 320841,Equal Housing Lender,none,DAY07_IG_STORY_TMPL_STORY_4_FRAME_v1.png
```

### 5. Reel cover

- **Number of assets.** 5
- **Required Canva template(s).** `TMPL_REEL_COVER_v1`
- **CSV rows needed.** 5 (one row per asset; use the Bulk Create CSV columns headline / accent_word / cta / nmls_block / eho_block / disclaimer_block).
- **Export format.** jpg
- **Where to save exports.** `Drive: LegendsOS_60Day/Week_01/exports/Reel_cover/`

**Asset filenames (exact):**
```
DAY01_IG_REEL_TMPL_REEL_COVER_v1.jpg
DAY02_IG_REEL_TMPL_REEL_COVER_v1.jpg
DAY03_IG_REEL_TMPL_REEL_COVER_v1.jpg
DAY04_IG_REEL_TMPL_REEL_COVER_v1.jpg
DAY05_IG_REEL_TMPL_REEL_COVER_v1.jpg
```

**Copy-paste prompt template for this group (Bulk Create CSV rows):**
```csv
headline,accent_word,cta,nmls_block,eho_block,disclaimer_block,export_filename
Brokers shop. Banks sell.,WE,DM NUMBERS for a second opinion on your file.,NMLS 1195266 | Loan Factory NMLS 320841,Equal Housing Lender,none,DAY01_IG_REEL_TMPL_REEL_COVER_v1.jpg
Four numbers before you tour.,ONE,DM NUMBERS for a second opinion on your file.,NMLS 1195266 | Loan Factory NMLS 320841,Equal Housing Lender,none,DAY02_IG_REEL_TMPL_REEL_COVER_v1.jpg
Consistency is a quiet brand.,CONSISTENT,DM NUMBERS for a second opinion on your file.,NMLS 1195266 | Loan Factory NMLS 320841,Equal Housing Lender,none,DAY03_IG_REEL_TMPL_REEL_COVER_v1.jpg
DSCR is a business-purpose loan.,REAL,DM INVESTOR if you want to walk a property.,NMLS 1195266 | Loan Factory NMLS 320841,Equal Housing Lender,For business-purpose lending. Terms differ from consumer loans.,DAY04_IG_REEL_TMPL_REEL_COVER_v1.jpg
Closing day in Northeast Florida.,TODAY,Save this.,NMLS 1195266 | Loan Factory NMLS 320841,Equal Housing Lender,none,DAY05_IG_REEL_TMPL_REEL_COVER_v1.jpg
```

### 6. YouTube short thumbnail

- **Number of assets.** 6
- **Required Canva template(s).** `TMPL_YT_SHORT_v1`
- **CSV rows needed.** 6 (one row per asset; use the Bulk Create CSV columns headline / accent_word / cta / nmls_block / eho_block / disclaimer_block).
- **Export format.** jpg
- **Where to save exports.** `Drive: LegendsOS_60Day/Week_01/exports/YouTube_short_thumbnail/`

**Asset filenames (exact):**
```
DAY01_YT_SHORT_TMPL_YT_SHORT_v1.jpg
DAY02_YT_SHORT_TMPL_YT_SHORT_v1.jpg
DAY03_YT_SHORT_TMPL_YT_SHORT_v1.jpg
DAY04_YT_SHORT_TMPL_YT_SHORT_v1.jpg
DAY05_YT_SHORT_TMPL_YT_SHORT_v1.jpg
DAY06_YT_SHORT_TMPL_YT_SHORT_v1.jpg
```

**Copy-paste prompt template for this group (Bulk Create CSV rows):**
```csv
headline,accent_word,cta,nmls_block,eho_block,disclaimer_block,export_filename
Brokers shop. Banks sell.,WE,DM NUMBERS for a second opinion on your file.,NMLS 1195266 | Loan Factory NMLS 320841,Equal Housing Lender,none,DAY01_YT_SHORT_TMPL_YT_SHORT_v1.jpg
Four numbers before you tour.,ONE,DM NUMBERS for a second opinion on your file.,NMLS 1195266 | Loan Factory NMLS 320841,Equal Housing Lender,none,DAY02_YT_SHORT_TMPL_YT_SHORT_v1.jpg
Consistency is a quiet brand.,CONSISTENT,DM NUMBERS for a second opinion on your file.,NMLS 1195266 | Loan Factory NMLS 320841,Equal Housing Lender,none,DAY03_YT_SHORT_TMPL_YT_SHORT_v1.jpg
DSCR is a business-purpose loan.,REAL,DM INVESTOR if you want to walk a property.,NMLS 1195266 | Loan Factory NMLS 320841,Equal Housing Lender,For business-purpose lending. Terms differ from consumer loans.,DAY04_YT_SHORT_TMPL_YT_SHORT_v1.jpg
Closing day in Northeast Florida.,TODAY,Save this.,NMLS 1195266 | Loan Factory NMLS 320841,Equal Housing Lender,none,DAY05_YT_SHORT_TMPL_YT_SHORT_v1.jpg
5 minute listing description with AI.,5 MIN,Comment AI for the playbook.,NMLS 1195266 | Loan Factory NMLS 320841,Equal Housing Lender,none,DAY06_YT_SHORT_TMPL_YT_SHORT_v1.jpg
```

### 7. YouTube long thumbnail

- **Number of assets.** 2
- **Required Canva template(s).** `TMPL_YT_LONG_THUMB_v1`
- **CSV rows needed.** 2 (one row per asset; use the Bulk Create CSV columns headline / accent_word / cta / nmls_block / eho_block / disclaimer_block).
- **Export format.** jpg
- **Where to save exports.** `Drive: LegendsOS_60Day/Week_01/exports/YouTube_long_thumbnail/`

**Asset filenames (exact):**
```
DAY02_YT_LONG_TMPL_YT_LONG_THUMB_v1.jpg
DAY04_YT_LONG_TMPL_YT_LONG_THUMB_v1.jpg
```

**Copy-paste prompt template for this group (Bulk Create CSV rows):**
```csv
headline,accent_word,cta,nmls_block,eho_block,disclaimer_block,export_filename
Four numbers before you tour.,ONE,DM NUMBERS for a second opinion on your file.,NMLS 1195266 | Loan Factory NMLS 320841,Equal Housing Lender,none,DAY02_YT_LONG_TMPL_YT_LONG_THUMB_v1.jpg
DSCR is a business-purpose loan.,REAL,DM INVESTOR if you want to walk a property.,NMLS 1195266 | Loan Factory NMLS 320841,Equal Housing Lender,For business-purpose lending. Terms differ from consumer loans.,DAY04_YT_LONG_TMPL_YT_LONG_THUMB_v1.jpg
```

## Hard rules per Canva run
- Do not edit the NMLS or EHO strip.
- Do not add a guarantee dollar amount.
- VA-tagged rows already include the VA non-endorsement line in `disclaimer_block`.
- DSCR rows already include the business-purpose line.

## After each Canva group exports
1. Upload the exports to the matching Drive subfolder.
2. Generate public direct-download URLs.
3. Append rows to `05_assets/week_1_export_upload_map.csv` (asset_filename → drive_folder_destination → hosted_url).
4. Once a URL lands, `05_assets/media_url_tracker.csv` should be updated for the same asset_id.

## Time estimate
- 5 Canva group runs at ~6 to 10 minutes each = 30 to 50 minutes total for all static + thumbnail assets.