# Story Bank Intake Report

**Run date.** 2026-05-24.
**Owner.** Jeremy McDonald.
**Bank state.** 12 records seeded. 0 Publish Ready. 12 Needs Review (10 Source Pending public-review placeholders + 2 borrower memory placeholders).

## Why 0 Publish Ready

This intake run did **not** scrape Zillow or Google reviews. Reasons:

- FTC and platform policy treat AI-generated or paraphrased review content as a serious compliance risk if it is presented as a real customer experience.
- The Story Bank rule set requires real source material, not invented or paraphrased review language.
- The browser environment available in this build session reads but does not execute live scraping on `https://www.zillow.com/...` or `https://www.google.com/...`, and no Zillow connector or GBP review-pull connector is verified.
- Inventing review content would violate the skill compliance posture set in `legendsos-skills/companions/07-story-bank/compliance.md`.

What was created instead: structured placeholder records labeled `Source Pending`, anonymized, framework-mapped, and clearly flagged "NOT A DIRECT REVIEW QUOTE. NEEDS JEREMY REVIEW BEFORE PUBLISHING."

## Records seeded

| story_id | source_type | framework | market | publish_status |
|---|---|---|---|---|
| STORY_001 | Zillow Review | The First Time Buyer Confidence Shift | Northeast Florida | Source Pending |
| STORY_002 | Zillow Review | The Veteran Win | St. Johns County | Source Pending |
| STORY_003 | Zillow Review | The Broker Advantage Story | Duval County | Source Pending |
| STORY_004 | Zillow Review | The Closing Day Lesson | Ponte Vedra | Source Pending |
| STORY_005 | Zillow Review | The Investor Numbers Story | Jacksonville | Source Pending |
| STORY_006 | GBP Review | The First Time Buyer Confidence Shift | Orange Park | Source Pending |
| STORY_007 | GBP Review | The Veteran Win | Jacksonville Beach | Source Pending |
| STORY_008 | GBP Review | The Move Up Buyer Strategy Story | Nocatee | Source Pending |
| STORY_009 | GBP Review | The Realtor Rescue | St. Augustine | Source Pending |
| STORY_010 | GBP Review | The Payment Reality Check | Fleming Island | Source Pending |
| STORY_011 | Borrower Memory | The File Save | Mandarin | Needs Review |
| STORY_012 | Borrower Memory | The Investor Numbers Story | Jacksonville | Needs Review |

## What Jeremy needs to do to move records to Publish Ready

For each `Zillow Review` and `GBP Review` placeholder:
1. Open the matching public review on `https://www.zillow.com/lender-profile/JeremyMcDonaldFL/#reviews` or in the GBP profile.
2. Paste the review text (or specific quote you want to use) into the `notes` column of the intake tracker.
3. Set `source_url` to the direct review URL when available, otherwise leave the profile URL.
4. Decide treatment: **Reframe-as-lesson** (default) or **public-quote with citation**.
5. If using as a public quote, confirm the reviewer's published first name is allowed; never invent or extend it.
6. Confirm the lesson summary fits the actual review's content.
7. Flip `publish_status` to `Publish Ready` only when source URL is set, anonymization gates are confirmed, and any program-specific lines (VA, DSCR) are noted in the publish_status row.

For each `Borrower Memory` placeholder:
1. Replace the generic obstacle and outcome in the record with the real (anonymized) memory.
2. Confirm permission_status. Default `Internal Memory Only` is fine for anonymized use; `Approved` is required for any named use.
3. Confirm program lines (VA, FHA, USDA, DSCR) match the actual file.
4. Flip `publish_status` to `Publish Ready` when the gates close.

## Compliance posture confirmed in this intake

- No invented reviews.
- No invented customer names.
- No invented outcomes.
- No exact addresses.
- No rate, payment, credit score, income, or asset numbers in any record.
- No banned phrases ("lowest rate," "best rate," "guaranteed approval," "free closing").
- All records flagged for Jeremy review before any publish.

## What was generated downstream from these placeholders

Story-based content drafts in `03_content_banks/story_based_*.csv` and `04_prompt_banks/story_based_*.csv` are clearly labeled `SOURCE PENDING — NOT A DIRECT REVIEW QUOTE — NEEDS JEREMY REVIEW BEFORE PUBLISHING` in every row's `notes` field. None can move to a Final HeroPost CSV until the underlying story record is moved to Publish Ready and the corresponding asset is rendered and hosted.

## Next step

Jeremy opens `story_bank_intake_tracker.csv`, pastes 5 real Zillow reviews and 5 real Google reviews from the public profiles, fills in 2 real anonymized borrower memories, then flips `publish_status` on each to `Publish Ready`. Once 5 of the 12 are `Publish Ready`, Week 1 dispatch can move story slots from placeholder to real content.
