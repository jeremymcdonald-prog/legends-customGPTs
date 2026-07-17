# Story Bank Manual Intake Instructions

This is the paste-and-go workflow. Real source in, anonymized lesson out. No invented reviews. No invented customers.

## What you fill in

- `manual_review_intake_form.csv` — 10 slots. First 5 are for Zillow reviews (`STORY_001` to `STORY_005`). Next 5 are for Google Business Profile reviews (`STORY_006` to `STORY_010`).
- `manual_borrower_memory_intake_form.csv` — 2 slots for anonymized borrower memories (`STORY_011`, `STORY_012`).

## The 10 steps for review intake (Zillow and Google)

1. Open the Zillow review page: https://www.zillow.com/lender-profile/JeremyMcDonaldFL/#reviews — or the Google Business Profile reviews tab for Jeremy McDonald / The Legends Mortgage Team.
2. Pick one real review at a time. Most-recent first is usually best.
3. Paste the **exact review text** into `review_text_paste_here`. Do not paraphrase. Do not edit. Do not invent.
4. Paste the reviewer's name as it appears publicly into `reviewer_name_remove_before_publishing`. The Story Bank will strip or keep it based on the public-review rule.
5. Add `loan_type_if_known` only if the review or your memory tells you (VA, FHA, FTHB, conventional, refinance, DSCR, etc.). Leave blank if unsure.
6. Add `market_area_if_known` only if the review or your memory tells you (Jacksonville, St. Johns County, Ponte Vedra, etc.). Leave blank if unsure.
7. Do **not** add any private borrower data — no rate, no payment, no credit score, no income, no asset value, no loan amount.
8. Set `permission_status` to `Public Review Source` for any public review. Leave it that way.
9. Set `publish_status` to `Needs Review` until the Story Bank skill transforms and validates the record.
10. Save and close the CSV.

## The intake rule for borrower memories

- Only use details you are comfortable publishing after anonymization.
- The `borrower_name_do_not_publish` and `property_address_do_not_publish` fields stay **internal only**. The Story Bank never publishes them unless `permission_status` is `Approved` with a written record.
- Fill in `what_was_the_problem`, `what_made_the_file_hard`, `what_strategy_did_we_use`, `what_was_the_result`, and `what_lesson_should_people_learn` in your own words.
- Default `permission_status` to `Internal Memory Only`. Move it to `Approved` only if you have a written consent record from the borrower.
- Default `publish_status` to `Needs Review`.

## What you must NEVER do during intake

- Never invent or paraphrase a review.
- Never make up a customer name.
- Never combine two reviews into one.
- Never add a rate, payment, credit, income, or asset number.
- Never paste a property address into a publishable field.
- Never use the words "lowest rate," "best rate," "guaranteed approval," or "free closing."
- Never imply VA, FHA, USDA, or any agency endorses Loan Factory.

## After you fill the forms

1. Save the CSVs.
2. Open `story_bank_publish_ready_conversion_rules.md` and confirm each filled record meets all 11 gates.
3. For records that meet every gate, change `publish_status` to `Publish Ready` and copy the record into `story_bank_publish_ready.csv`.
4. Tell the Weekly Production Engine which story IDs are ready.
5. The Engine will swap the matching Source Pending placeholders in `story_based_caption_drafts.csv`, `story_based_reel_scripts.csv`, `story_based_gbp_posts.csv`, `story_based_linkedin_posts.csv`, `story_based_heygen_prompts.csv`, and `story_based_canva_prompts.csv` for real-source content.
6. Week 1 dispatch can then move forward against real source IDs.

## Quick paste targets

- Zillow profile: https://www.zillow.com/lender-profile/JeremyMcDonaldFL/#reviews
- Google Business Profile search: https://www.google.com/search?q=jeremy+mcdonald+mortgage+broker
- Website source: https://www.mcdonald-mtg.com/en

## Time budget

- 10 review pastes: about 20 to 25 minutes.
- 2 borrower memory writes: about 10 to 15 minutes.
- Conversion to Publish Ready: about 10 minutes.

Total: under 1 hour.
