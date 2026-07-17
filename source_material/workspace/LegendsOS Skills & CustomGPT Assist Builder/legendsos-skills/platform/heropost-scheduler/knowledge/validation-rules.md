# Validation Rules

## Schema gates

- Header exact match: `Caption,Media,Title,Date,Link,Thumbnail,Type,Comment`.
- No extra columns. No missing columns. No reorderings.
- UTF-8 encoding, LF line endings.
- All rows have the same number of fields as the header.

## Compliance gates (per row)

- Caption present.
- Caption has compliance footer if mortgage-related (detected by keywords: VA, FHA, USDA, DSCR, mortgage, broker, refinance, rate, payment, closing, NMLS, Equal Housing).
- Caption contains no banned phrases: "lowest rate," "best rate," "guaranteed approval," "free closing costs," named competitor.
- Comment column does not contain `BLOCKED:` for promotion to final.

## Media gates (per row)

- Staging allows `STAGING_PENDING_MEDIA`.
- Final requires `Media` to match https URL pattern.
- Final requires `Thumbnail` to match URL pattern OR be empty (when platform doesn't require thumbnail).

## Date gates (per row)

- Date present.
- Date format `YYYY-MM-DD HH:MM`.
- Date is in the future at staging time (warning, not block) and at final time (block).

## Type gates (per row)

- Type matches exact string from `platform-title-map.md`.

## Platform-specific gates

| Platform | Extra rule |
|---|---|
| YouTube Long Form | Title required, Thumbnail required |
| YouTube Short | Title recommended, Thumbnail optional |
| Google Business Profile | Caption ≤ 1500 chars (Google's cap; soft cap 250 enforced by Local SEO skill) |
| LinkedIn | Caption ≤ 3000 chars |
| TikTok | Caption ≤ 2200 chars |
| Instagram Reel | Caption ≤ 2200 chars |
| Instagram Feed | Caption ≤ 2200 chars |
| Facebook Personal | Caption ≤ 60000 chars |
| Facebook Business | Caption ≤ 60000 chars |
| Instagram Story | One row per frame |

## Aggregate gates (per CSV)

- No duplicate rows (same Caption + Type + Date triple).
- Distribution sanity: no single day has more than 30 percent of the week's posts on one platform.
- Distribution sanity: every platform has at least one post in a week if it appears in the daily content mix minimums.

## Validation report shape

```
HeroPost Validation Report
File: heropost_staging_60_day.csv
Generated: {ISO timestamp}

Totals
- Rows: {N}
- Ready to promote: {N}
- Blocked: {N}

Breakdown by week
Week 1: {N} ready, {N} pending, {N} blocked
...

Breakdown by platform
Facebook Personal: {N}
Facebook Business: {N}
...

Blockers
- DAY03_IG_REEL_TMPL_REEL_COVER_BROKER_ADVANTAGE_v1: BLOCKED: media_url_pending
...

Compliance flags
- DAYxx_xx: missing VA non-endorsement line
...

Next step:
{action}
```
