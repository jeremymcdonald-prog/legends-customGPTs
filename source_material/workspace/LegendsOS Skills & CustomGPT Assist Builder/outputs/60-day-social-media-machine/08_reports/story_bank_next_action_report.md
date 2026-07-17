# Story Bank Next Action Report

**Run date.** 2026-05-24.
**Owner.** Jeremy McDonald.
**State.** 12 Story Bank records exist. 0 Publish Ready. 12 Needs Review / Source Pending. Week 1 is locked but not final upload ready. Manual intake packet is built and waiting.

## What to paste, where, in what order

| Story ID | Source type | Paste into | Time |
|---|---|---|---|
| STORY_001 | Zillow Review | `manual_review_intake_form.csv` row 1 | ~2 min |
| STORY_002 | Zillow Review | `manual_review_intake_form.csv` row 2 | ~2 min |
| STORY_003 | Zillow Review | `manual_review_intake_form.csv` row 3 | ~2 min |
| STORY_004 | Zillow Review | `manual_review_intake_form.csv` row 4 | ~2 min |
| STORY_005 | Zillow Review | `manual_review_intake_form.csv` row 5 | ~2 min |
| STORY_006 | GBP Review | `manual_review_intake_form.csv` row 6 | ~2 min |
| STORY_007 | GBP Review | `manual_review_intake_form.csv` row 7 | ~2 min |
| STORY_008 | GBP Review | `manual_review_intake_form.csv` row 8 | ~2 min |
| STORY_009 | GBP Review | `manual_review_intake_form.csv` row 9 | ~2 min |
| STORY_010 | GBP Review | `manual_review_intake_form.csv` row 10 | ~2 min |
| STORY_011 | Borrower Memory | `manual_borrower_memory_intake_form.csv` row 1 | ~5 min |
| STORY_012 | Borrower Memory | `manual_borrower_memory_intake_form.csv` row 2 | ~5 min |

Total time budget: under 1 hour.

## Recommended sequence

1. Open `story_bank_copy_paste_queue.md`. Paste real source text into the 12 boxes. Working in one document is faster than tabbing between CSVs.
2. Transfer each captured text into the matching row of:
   - `manual_review_intake_form.csv` for STORY_001 through STORY_010.
   - `manual_borrower_memory_intake_form.csv` for STORY_011 and STORY_012.
3. Open `story_bank_publish_ready_conversion_rules.md`. Run the 11-gate check on each row.
4. Flip `publish_status` to `Publish Ready` on rows that pass every gate.
5. Append the Publish Ready rows into `story_bank_publish_ready.csv`.
6. Tell the Weekly Production Engine which story IDs moved.
7. The Engine swaps Source Pending placeholders in `story_based_caption_drafts.csv`, `story_based_reel_scripts.csv`, `story_based_gbp_posts.csv`, `story_based_linkedin_posts.csv`, `story_based_heygen_prompts.csv`, and `story_based_canva_prompts.csv` for real-source content.
8. Week 1 dispatch (Canva, HeyGen, Higgsfield) runs against real source IDs.

## The 11-gate quick check

Real source captured. Customer name removed. Address removed. No rate / payment / credit / income / asset numbers. No direct quote unless public-quote with citation. No guaranteed-result language. No banned phrases. Framework assigned. Lesson written. Program-specific line attached when applicable. publish_status = Publish Ready.

## Minimum to unblock Week 1

If time is short, prioritize:

- **STORY_001** (Zillow, First Time Buyer) — covers Week 1 Wednesday story slot.
- **STORY_004** (Zillow, Closing Day) — covers Week 1 Friday story slot.

Moving just those two to Publish Ready clears Week 1's story slots. The other 10 records can be intaken across the week as time permits.

## What is still blocked

- Canva Bulk Create execution (waiting on real source IDs and operator run).
- HeyGen renders (waiting on operator submission).
- Higgsfield generations (waiting on Concept Gate and operator generation).
- Hosted media URLs (waiting on uploads).
- HeroPost Week 1 Final CSV (waiting on all of the above).

## What is not blocked

- The locked Week 1 calendar.
- The Week 1 asset generation plan.
- The Week 1 batch prompt files (Canva, HeyGen, Higgsfield, thumbnails).
- The Week 1 staging CSV (schema-locked, validation-clean, awaiting media URLs).

## Hard rules respected this sprint

- No invented reviews.
- No invented borrower memories.
- No customer names entered without explicit owner permission.
- No exact addresses entered into publishable fields.
- No publication.
- No HeroPost upload.
- No final media URLs.
- No fake testimonials.

## Exact next action

Open `outputs/60-day-social-media-machine/03_content_banks/story_bank_copy_paste_queue.md` and start with STORY_001 by pasting the most recent real Zillow review from the public profile.
