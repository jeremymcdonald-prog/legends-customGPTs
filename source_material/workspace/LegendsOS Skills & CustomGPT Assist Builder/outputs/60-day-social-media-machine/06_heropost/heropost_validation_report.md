# HeroPost Validation Report

File: heropost_staging_60_day.csv
Generated: 2026-05-24 (build session)

## Schema
- Header expected: `Caption,Media,Title,Date,Link,Thumbnail,Type,Comment`
- Header actual:   `Caption,Media,Title,Date,Link,Thumbnail,Type,Comment`
- Schema match: **PASS**

## Totals
- Rows: 502
- Pending Media: 502
- Pending Thumbnail: 114
- Blocked rows: 0
- Caption banned-phrase hits (lowest/best/guaranteed/free): 0
- Em-dash hits in captions: 0

## By Type
- Facebook Business: 60
- Facebook Personal: 60
- Google Business Profile: 44
- Instagram Feed: 52
- Instagram Reel: 44
- Instagram Story: 60
- LinkedIn: 60
- TikTok: 52
- YouTube Long Form: 18
- YouTube Short: 52

## By Week
- Week 1: 58 rows
- Week 2: 58 rows
- Week 3: 58 rows
- Week 4: 58 rows
- Week 5: 58 rows
- Week 6: 58 rows
- Week 7: 58 rows
- Week 8: 58 rows
- Week 9: 38 rows

## Promotion-Ready Status
- Final CSV ready when: Media URLs resolved + Thumbnail URLs resolved (where required) + 0 BLOCKED rows + 0 banned-phrase hits + 0 em-dashes.
- Current status: STAGING ONLY. No row is Final ready.
- All 502 rows are in `heropost_staging_60_day.csv` with placeholder Media and Thumbnail values.
- Week 1 ready-later file (`heropost_week_1_ready_later.csv`) is a copy of the Week 1 subset, awaiting media URL fill.

## Next step
Lock Week 1, dispatch via Weekly Production Engine, generate Canva and Higgsfield and HeyGen assets, fill `media_url_tracker.csv`, then run HeroPost Scheduler to promote Week 1 ready rows.
