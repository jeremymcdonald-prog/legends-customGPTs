# Story Bank Schema

Every story record has this shape. Stored as YAML-ish blocks in the bank, surfaced as markdown when pulled.

## Fields

| Field | Type | Required | Notes |
|---|---|---|---|
| `source_id` | string | yes | Prefixed by source type. Sequential. Never reused. |
| `source_type` | enum | yes | `zillow_review`, `gbp_review`, `borrower_memory`, `realtor_scenario`, `website_blog`, `team_win`, `partner_anecdote` |
| `source_url` | URL | when public | Required for any public review. |
| `intake_date` | ISO date | yes | Date the record was created. |
| `last_reviewed` | ISO date | yes | Updated when the record is checked. |
| `status` | enum | yes | `draft`, `anonymized`, `approved`, `public`, `retired` |
| `framework` | enum | yes | From `mortgage-story-frameworks.md`. |
| `risk_tier` | enum | yes | `Green`, `Yellow`, `Red`. |
| `permission_status` | enum | yes | `none`, `verbal`, `written` |
| `permission_record` | string | when written | File path or doc link to the written permission record. |
| `tags` | list | yes | Pillars, programs, cities, counties, audiences. |
| `lesson` | string | yes | One sentence. The takeaway. |
| `lesson_summary` | string | yes | 2 to 5 sentences in Jeremy's voice. |
| `channels_recommended` | list | yes | Where this story fits naturally. |
| `do_not_publish_until` | list | yes | Open gates. Empty list means publish-ready. |
| `redactions_applied` | list | yes | What was scrubbed (names, addresses, numbers). |
| `program_lines_required` | list | when applicable | VA, FHA, USDA, DSCR program lines. |
| `linked_assets` | list | optional | Canva templates, HeyGen prompts, Higgsfield prompts already produced for this story. |
| `notes_internal` | string | optional | Operator notes. Never published. |

## Example block

```yaml
source_id: BORROWER_MEMORY_007
source_type: borrower_memory
source_url: null
intake_date: 2026-05-10
last_reviewed: 2026-05-22
status: anonymized
framework: The File Save
risk_tier: Yellow
permission_status: verbal
permission_record: null
tags: [first_time_buyer, broker_advantage, mandarin, jacksonville, credit]
lesson: A credit ding mid underwriting doesn't have to kill a file when a broker can shop the field.
lesson_summary: |
  First time buyer in Mandarin hit a credit ding mid underwriting. Their original lender said wait six months. We pulled the file, called three of our wholesale investors, found the right overlay, kept the same loan amount, and closed in a week. Brokers shop. Banks sell.
channels_recommended: [fb_personal, fb_business, ig_feed, ig_reel, ig_story, tiktok, yt_short, linkedin, gbp]
do_not_publish_until:
  - no_rate_quoted
  - no_address_referenced
  - lesson_framing_held
redactions_applied: [first_name, last_name, address, rate, payment, credit_score]
program_lines_required: []
linked_assets: []
notes_internal: Borrower is open to written permission. Ask on next touch.
```

## ID sequencing

Source IDs are zero-padded to three digits at start, four digits after 999.

- `BORROWER_MEMORY_001` through `BORROWER_MEMORY_999`
- `BORROWER_MEMORY_1000` onward
- Same pattern across all prefixes.

## Search axes

Story Bank pulls accept queries along these axes:

- by `status`
- by `framework`
- by `tags` (program, city, county, audience, pillar)
- by `risk_tier`
- by `channels_recommended`
- by `source_id`
