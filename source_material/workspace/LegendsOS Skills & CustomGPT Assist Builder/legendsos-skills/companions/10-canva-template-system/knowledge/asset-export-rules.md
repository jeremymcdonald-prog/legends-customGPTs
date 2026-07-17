# Asset Export Rules

## Filename convention

`{day}_{platform}_{template_id}_{variant}.{ext}`

Examples:
- `DAY03_IG_FEED_TMPL_CAROUSEL_BROKER_ADVANTAGE_v1_s01.png`
- `DAY03_IG_REEL_TMPL_REEL_COVER_BROKER_ADVANTAGE_v1.jpg`
- `WEEK01_BLOG_FTHB_STJOHNS.png`
- `DAY05_GBP_TMPL_GBP_VA_v1.png`
- `DAY07_YT_LONG_TMPL_YT_LONG_DSCR_THUMB_v1.jpg`

## Platform codes

| Code | Platform |
|---|---|
| FB_PERSONAL | Facebook Personal |
| FB_BUSINESS | Facebook Business |
| IG_FEED | Instagram Feed |
| IG_REEL | Instagram Reel |
| IG_STORY | Instagram Story |
| TIKTOK | TikTok |
| YT_SHORT | YouTube Short |
| YT_LONG | YouTube Long Form |
| LINKEDIN | LinkedIn |
| GBP | Google Business Profile |
| BLOG | Website Blog |
| VLOG | Website Vlog |

## Day labels

- `DAY01..DAY60` for the 60 day plan.
- `WEEK01..WEEK09` when a piece is week-spanning (blog, vlog).

## Variant suffixes

- `_s01..._s10` for carousel slides.
- `_f01..._f05` for story frames.
- `_cover` for video covers.
- `_thumb` for thumbnails.
- `_v2`, `_v3` for re-spins of the same template fill.

## Export formats per template

| Template | Export |
|---|---|
| Carousels, stories, GBP | png |
| YT thumbnails, Reel covers | jpg |
| Video deliverables (if Canva exports any) | mp4 |
| Logos, lockups | png with transparency |

## Hosting and URL handoff

- After export, files land in the operator's working folder.
- Operator (or future automation) uploads to a hosting bucket (Drive, R2, S3, or similar).
- The hosted URL goes into `media_url_tracker.csv` paired with the asset_id.
- The HeroPost Scheduler reads `media_url_tracker.csv` to convert staging rows to final rows.

## Forbidden filename patterns

- Spaces.
- Special characters other than `_` and `.`
- Customer or Realtor names.
- Address strings.
- Loan numbers.
