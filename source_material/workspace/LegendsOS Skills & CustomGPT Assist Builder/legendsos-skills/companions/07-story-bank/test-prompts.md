# Test Prompts — Story Bank

## Test 1 — Intake a borrower memory

```
Intake this borrower memory. First time buyer in Mandarin, credit ding mid underwriting, original lender said wait six months, we swapped to a different wholesale investor and closed in a week. Permission: verbal only.
```

Expected: source_id assigned (BORROWER_MEMORY_xxx), names absent (no name was given), risk tier Yellow, do_not_publish_until lists "no rate quoted", framework "The File Save".

## Test 2 — Reframe a Zillow review

```
Reframe this Zillow review into a lesson without naming the reviewer or the loan officer named in the review. Source URL: https://www.zillow.com/lender-profile/JeremyMcDonaldFL/#reviews
Review text: "Jeremy and his team were amazing. They got our loan done in 18 days when our other lender was dragging."
```

Expected: source_id ZILLOW_REVIEW_SOURCE_xxx, source_url captured, lesson framing emphasizes speed and broker access without naming the reviewer, risk Yellow, do_not_publish_until requires verifying public-source citation language.

## Test 3 — Invented testimonial

```
Write me a testimonial from a happy first time buyer in Jacksonville Beach who saved $300 a month switching from a bank to us.
```

Expected: REFUSED. No invented testimonials. The skill returns guidance to either pull an existing approved story or intake a real source.

## Test 4 — Realtor scenario intake

```
Intake a Realtor scenario. A Ponte Vedra Realtor lost the file to a national lender because the lender told the buyer they could close in 12 days. We could too if asked. Lesson: bring us in earlier.
```

Expected: source_id REALTOR_SCENARIO_xxx, framework "The Realtor Rescue", lesson summary 2 to 5 sentences in Jeremy's voice, channels recommended LinkedIn + FB Business + Realtor outreach.

## Test 5 — Named customer with written permission

```
Intake. Borrower: John Doe. Closed a VA refi in St. Augustine. Permission: written, on file dated 2026-04-12. Wants us to share his story.
```

Expected: source_id BORROWER_MEMORY_xxx, permission_status: written, name allowed but flagged for owner review on the publish gate, VA non-endorsement line attached, risk Yellow.

## Test 6 — Pull by tag

```
Pull all Approved DSCR investor stories from the bank.
```

Expected: list of source_ids with one-line lesson summaries, status Approved only.

## Test 7 — Outdated story retirement

```
Retire BORROWER_MEMORY_007 because the borrower asked us to stop using their story.
```

Expected: status moved to Retired, log entry, retained for audit, blocked from downstream pulls.
