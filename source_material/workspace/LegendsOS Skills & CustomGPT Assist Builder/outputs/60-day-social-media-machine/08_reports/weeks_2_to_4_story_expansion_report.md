# Weeks 2-4 Story Expansion Report

**Run date.** 2026-05-24.
**Scope.** Weeks 2 through 4 (DAY08 → DAY28, 2026-06-01 → 2026-06-21).
**Source records used.** STORY_013, STORY_014, STORY_015. Three real captures. No new browser fetches. No invented reviews. No fabricated testimonials.

## What was built

**53 story-based content pieces** generated from 25 source angles (10 from STORY_014, 8 from STORY_013, 7 from STORY_015) across 9 platforms over 21 days.

| File | Rows | Purpose |
|---|---|---|
| `03_content_banks/weeks_2_to_4_story_expansion_bank.csv` | 53 | Full unified bank (24-field schema per piece) |
| `03_content_banks/weeks_2_to_4_story_caption_bank.csv` | 53 | Caption-focused subset |
| `03_content_banks/weeks_2_to_4_reel_script_bank.csv` | 15 | Video script subset (IG Reel, TikTok, YT Short) |
| `04_prompt_banks/weeks_2_to_4_heygen_prompt_bank.csv` | 15 | HeyGen prompts |
| `04_prompt_banks/weeks_2_to_4_canva_prompt_bank.csv` | 53 | Canva Bulk Create rows |
| `04_prompt_banks/weeks_2_to_4_thumbnail_prompt_bank.csv` | 15 | Thumbnail specs for videos |
| `03_content_banks/weeks_2_to_4_gbp_posts.csv` | 4 | Local-relevance GBP posts |
| `03_content_banks/weeks_2_to_4_linkedin_posts.csv` | 13 | LinkedIn thought leadership |
| `02_calendars/weeks_2_to_4_story_content_map.csv` | 53 | Story → channel routing |
| `05_assets/weeks_2_to_4_asset_generation_plan.csv` | 53 | Asset production plan |
| `06_heropost/weeks_2_to_4_heropost_staging.csv` | 53 | HeroPost staging (schema-exact) |

## Platforms covered

Facebook Personal, Facebook Business, Instagram Feed, Instagram Reels, Instagram Stories, TikTok, YouTube Shorts, LinkedIn, Google Business Profile.

## Source-angle expansion map

**STORY_014 — Public Zillow review (Clay County Veteran) — 10 angles → ~22 pieces.**
Friday communication, calm guidance, VA respect, Veteran experience start-to-keys, broker relationship over transaction, wholesale broker advantage on VA, repeat trust and long-term advocate, sudden change handling, Clay County local angle, Middleburg / Northeast Florida market angle. All reviewer names retained in internal-only fields. Public copy uses "a Veteran buyer in Clay County" framing.

**STORY_013 — Jeremy's VA borrower memory — 8 angles → ~17 pieces.**
Slow down and read the full file, plain English explanation, Veteran borrower confidence shift, why structure matters more than rate, why a broker solves what a bank misses, clear communication reduces stress, loan officer leadership under pressure, closing day is downstream of week one.

**STORY_015 — Realtor AI educational — 7 angles → ~14 pieces.**
AI helps Realtors follow up better, AI does not replace relationships, listing content multiplied, open house follow up systemized, Realtors need usable workflows, AI plus broker strategy, AI content needs a human voice.

## Compliance scan (all clean)

| Check | Result |
|---|---|
| HeroPost schema lock (`Caption,Media,Title,Date,Link,Thumbnail,Type,Comment`) | PASS |
| Banned phrases ("lowest rate," "best rate," "guaranteed approval," "free closing") | 0 hits |
| Em-dashes in any caption / script / on-screen text | 0 hits |
| Reviewer name leaks (Sueann or Keith Adk in public copy) | 0 hits |
| VA non-endorsement line on every VA piece | Attached |
| Compliance footer on every mortgage piece | Attached |
| Story-bank source ID on every story-driven piece | Yes |
| Anonymization preserved ("a Veteran buyer in Clay County," "a Northeast Florida buyer") | Yes |
| Public review handling per reframe-as-lesson (Option 1) | Yes |
| HeroPost rows with real Media URLs | 0 (all `STAGING_PENDING_MEDIA`) |
| HeroPost rows with real Thumbnail URLs | 0 (all `STAGING_PENDING_THUMBNAIL` where applicable) |

## Anti-patterns explicitly avoided

- No direct quote of the Sueann/Keith Adk review in any public piece.
- No invented Realtor testimonials in any STORY_015 piece (educational framing only).
- No address, rate, payment, credit, income, or asset numbers anywhere.
- No competitor lender names anywhere.
- No "everyone gets the same result" implication.

## Production status

All 53 pieces marked `PLANNED` in the asset generation plan. Nothing is marked Posted, Scheduled, or HeroPost Ready. Media URLs stay pending until Canva, HeyGen, Higgsfield assets are rendered and hosted.

## Exact next step

Run the Weeks 2-4 production batch through the Friday/Sunday cycle: Canva Bulk Create on the 53 Canva prompts, HeyGen renders on the 15 video prompts, Higgsfield generations on the premium-plate slots, upload exports to fill `media_url_tracker.csv`, then run the HeroPost Scheduler to promote ready rows to `heropost_week_2_ready.csv`, `heropost_week_3_ready.csv`, `heropost_week_4_ready.csv` one week at a time.

No HeroPost upload yet. No final media URLs. No publication.
