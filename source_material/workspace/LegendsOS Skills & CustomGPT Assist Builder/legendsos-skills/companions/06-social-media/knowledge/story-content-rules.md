# Story Content Rules

Stories drive trust. Stories also carry the most compliance risk. These rules govern any borrower-based, Realtor-based, or transaction-based content.

## Source first

No story-based post is written without a Story Bank source ID:

- `ZILLOW_REVIEW_SOURCE_xxx`
- `GBP_REVIEW_SOURCE_xxx`
- `BORROWER_MEMORY_xxx`
- `REALTOR_SCENARIO_xxx`
- `WEBSITE_BLOG_SOURCE_xxx`

If the source slot is empty, the skill returns a `STORY SOURCE REQUIRED` block and does not write the post.

## Anonymization defaults

- No first name unless written approval is logged on the source record.
- No last name. Ever, except testimonial reposts where the source is public AND the original review is treated as a public review.
- No street name + city combo.
- No exact loan amount.
- No exact rate.
- No income, asset, or credit score numbers.
- Use "a Veteran in St. Johns County," "a first-time buyer in Mandarin," "a Realtor in Ponte Vedra," etc.

## Reframe over repost

Reposting a review word for word is rare and conditional:
- Source must be a public review (Zillow or Google).
- Caption must clearly say "Public review on Zillow" or "Public review on Google."
- Customer name in the review is left as published; the caption does not add detail beyond what is public.
- Even when allowed, prefer the lesson-from-the-review reframe.

## The lesson rule

Every story post lands on a lesson:

- What was at stake.
- What the broker did differently than a bank or retail lender would have.
- What the takeaway is for the next buyer or Realtor.

Stories that don't teach get cut.

## Risk scoring

| Element in the post | Risk |
|---|---|
| No identifying info, no numbers, lesson framed | Yellow |
| Names a public reviewer with public review | Yellow with cite |
| Implies guarantee, lowest rate, or specific savings | Red — block |
| Names a real customer without written approval | Red — block |
| Uses an address | Red — block |
| Quotes a rate without APR | Red — block |

## Required additions when applicable

- VA story → VA non-endorsement line.
- DSCR / investor story → business-purpose line.
- "We saved them X" story → "Estimates only. Individual results vary. Not a commitment to lend."

## Frameworks the skill can request

When the skill picks a framework, it pulls from `companions/07-story-bank/knowledge/mortgage-story-frameworks.md`:

- The File Save
- The Veteran Win
- The First Time Buyer Confidence Shift
- The Realtor Rescue
- The Payment Reality Check
- The Broker Advantage Story
- The Investor Numbers Story
- The Move Up Buyer Strategy Story
- The Appraisal or Inspection Curveball Story
- The Closing Day Lesson
- The AI Helped the Realtor Win Story
