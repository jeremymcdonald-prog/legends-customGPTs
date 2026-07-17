# Usage Notes — Story Bank

## How to intake a new story

1. Paste the raw source (review text, your notes from a call, the Realtor scenario, the blog post excerpt).
2. Tell the skill the source type.
3. Tell the skill the permission status (none / verbal / written).
4. Optionally tell the skill the framework you want; otherwise it picks one.
5. The skill returns a full source record + lesson summary + channel routing.

## How to pull a story

By tag, by framework, by risk tier, or by source ID. Example asks:

- "Give me a publish-ready VA framework story for this Friday."
- "Pull all First Time Buyer Confidence Shift stories that are Approved."
- "What Realtor Rescue stories do we have for Northeast Florida specifically?"

## The five gates a story must pass before publish

1. Source ID assigned.
2. Permission status set.
3. Privacy gate cleared.
4. Risk tier set.
5. `do_not_publish_until` list is empty.

If any gate is open, the skill returns a `DRAFT — GATES OPEN` record, not a publish-ready entry.

## What never gets stored

- Raw PII (social, DOB, full account numbers, signed docs).
- Income figures.
- Credit scores.
- Loan numbers.
- Borrower contact info.

The Story Bank is for narrative source material, not for loan data. Loan data lives in MOSO and TERA.

## Pairing with the Weekly Production Engine

Every weekly plan reserves story slots (Wednesday and Friday by default). The Engine asks the Story Bank for a publish-ready source ID for each story slot. If the bank can't produce one, the Engine swaps the slot to an educational pillar and notes the gap.
