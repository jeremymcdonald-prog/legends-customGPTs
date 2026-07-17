# Usage Notes — Social Media

## Minimum input

A single seed. Examples:

- "Veteran closing day in Jacksonville. Anonymized."
- "Broker advantage vs Wells Fargo style retail lender. No competitor naming."
- "Realtor AI tip — using Claude to draft listing descriptions."
- "Personal brand — early gym morning before the Loan Factory office."
- "Market update — bond move this week."

## How to invoke

1. Drop the seed.
2. If story-based, include the source ID from the Story Bank.
3. If local, name the city or county.
4. Optionally tell the skill which platforms to skip. Default is all platforms.

## What you get back

A header line, one block per platform, a compliance footer, the production tracker rows, and one next step.

## What the slots mean

| Slot | Filled by |
|---|---|
| `{canva_asset_id}` | Canva Template System after the template is filled and exported |
| `{heygen_video_id}` | HeyGen Video System after the avatar video renders |
| `{higgsfield_asset_id}` | Higgsfield Visual System after the cinematic visual generates |
| `{thumbnail_id}` | Canva or Higgsfield, depending on the asset |
| `{hosted_media_url}` | Filled after the file is uploaded to the hosting bucket; HeroPost CSV cannot finalize without this |

## What this skill never does

- Auto-publishes
- Bypasses compliance
- Invents customer details
- Quotes a rate without APR
- Ships a guarantee creative without verified live config
- Outputs identical captions across platforms

## How it pairs with the Weekly Production Engine

The Engine plans the 60 days, locks Week N, and calls this skill once per day in that week. The Engine carries the seed, the pillar tag, the channel target, and the story source ID. This skill returns the post pack and the tracker rows.

## Time-of-day defaults

| Platform | Default post time (ET) |
|---|---|
| Facebook Personal | 7:30 AM |
| Facebook Business | 8:30 AM |
| Instagram Feed | 11:00 AM |
| Instagram Reels | 6:00 PM |
| Instagram Stories | 9:00 AM and 7:30 PM |
| TikTok | 6:30 PM |
| YouTube Shorts | 5:00 PM |
| YouTube Long Form | 4:00 PM Tuesday and Thursday |
| LinkedIn | 7:00 AM and 12:30 PM |
| Google Business Profile | 10:00 AM |

These defaults can be overridden per post; HeroPost reads the `Date` column verbatim.
