# Example Source Records

Placeholder records to seed the bank. These are framework examples only. Replace `source_url`, raw notes, and any identifying detail with real intake before any record moves past `draft`.

## ZILLOW_REVIEW_SOURCE_001 (placeholder)

```yaml
source_id: ZILLOW_REVIEW_SOURCE_001
source_type: zillow_review
source_url: https://www.zillow.com/lender-profile/JeremyMcDonaldFL/#reviews
intake_date: 2026-05-24
last_reviewed: 2026-05-24
status: draft
framework: The Broker Advantage Story
risk_tier: Yellow
permission_status: none
permission_record: null
tags: [zillow, broker_advantage, communication, jacksonville]
lesson: Communication and broker access are the two things borrowers remember.
lesson_summary: |
  Public reviews on Zillow keep landing on the same two themes. The first is communication that did not stop on a Friday afternoon. The second is access to lenders that retail shops could not match. That is the broker advantage in plain language.
channels_recommended: [fb_business, ig_feed, ig_reel, linkedin, gbp]
do_not_publish_until:
  - source_review_intake_completed
  - reviewer_name_handling_decided
redactions_applied: []
program_lines_required: []
linked_assets: []
notes_internal: Placeholder. Replace with a real intaken Zillow review before any publish action.
```

## GBP_REVIEW_SOURCE_001 (placeholder)

```yaml
source_id: GBP_REVIEW_SOURCE_001
source_type: gbp_review
source_url: https://www.google.com/search?q=jeremy+mcdonald+mortgage+broker
intake_date: 2026-05-24
last_reviewed: 2026-05-24
status: draft
framework: The Closing Day Lesson
risk_tier: Yellow
permission_status: none
permission_record: null
tags: [google, closing_day, jacksonville]
lesson: Closing day is downstream of week-one decisions.
lesson_summary: |
  Google reviews that mention smooth closings almost never describe the closing itself. They describe what happened in week one — the math, the document plan, the lender choice. Closing day shows up on time because everything before it did.
channels_recommended: [fb_business, ig_feed, gbp]
do_not_publish_until:
  - source_review_intake_completed
redactions_applied: []
program_lines_required: []
linked_assets: []
notes_internal: Placeholder.
```

## BORROWER_MEMORY_001 (placeholder)

```yaml
source_id: BORROWER_MEMORY_001
source_type: borrower_memory
source_url: null
intake_date: 2026-05-24
last_reviewed: 2026-05-24
status: draft
framework: The First Time Buyer Confidence Shift
risk_tier: Yellow
permission_status: none
permission_record: null
tags: [first_time_buyer, education, northeast_florida]
lesson: A buyer who thought they were not ready often is, once the math is shown clearly.
lesson_summary: |
  A first time buyer in Northeast Florida thought they were a year out. The math told a different story. Once we walked through credit, down payment, debt to income, and payment cushion, the timeline collapsed. Education is the unlock, not pressure.
channels_recommended: [fb_business, ig_feed, ig_reel, tiktok, yt_short, gbp]
do_not_publish_until:
  - replace_with_real_borrower_intake
redactions_applied: [first_name, last_name, address, rate, payment, credit_score]
program_lines_required: []
linked_assets: []
notes_internal: Placeholder. Use as a structural template only.
```

## REALTOR_SCENARIO_001 (placeholder)

```yaml
source_id: REALTOR_SCENARIO_001
source_type: realtor_scenario
source_url: null
intake_date: 2026-05-24
last_reviewed: 2026-05-24
status: draft
framework: The Realtor Rescue
risk_tier: Yellow
permission_status: none
permission_record: null
tags: [realtor, broker_advantage, problem_solving, st_johns]
lesson: A Realtor who brings the broker in earlier keeps more deals.
lesson_summary: |
  A Realtor's deal slowed at a national lender that lost grip on the timeline. The Realtor brought us in halfway through. We restructured the file, kept the close date, and the listing did not collapse. Earlier involvement would have saved a week.
channels_recommended: [linkedin, fb_business, ig_reel]
do_not_publish_until:
  - replace_with_real_realtor_scenario
redactions_applied: [realtor_name, address]
program_lines_required: []
linked_assets: []
notes_internal: Placeholder.
```

## WEBSITE_BLOG_SOURCE_001 (placeholder)

```yaml
source_id: WEBSITE_BLOG_SOURCE_001
source_type: website_blog
source_url: https://www.mcdonald-mtg.com/en
intake_date: 2026-05-24
last_reviewed: 2026-05-24
status: draft
framework: The Broker Advantage Story
risk_tier: Yellow
permission_status: written
permission_record: site_owner_self
tags: [website, broker_advantage, loan_factory, education]
lesson: The website's broker positioning is the single source of truth for any social repurposing.
lesson_summary: |
  Long form content on mcdonald-mtg.com is the canonical positioning. Social content quoting or paraphrasing this material maintains the same voice and the same compliance posture.
channels_recommended: [fb_business, ig_feed, linkedin, gbp]
do_not_publish_until:
  - identify_target_blog_post
redactions_applied: []
program_lines_required: []
linked_assets: []
notes_internal: Placeholder. Replace with the specific blog post each time.
```
