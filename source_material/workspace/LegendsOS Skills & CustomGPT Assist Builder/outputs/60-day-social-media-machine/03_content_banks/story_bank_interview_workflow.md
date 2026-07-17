# Story Bank Interview Workflow

The default. Jeremy never fills out a form. Claude runs a short conversational interview, parses the answers, anonymizes, runs the compliance gates, updates the structured CSVs, and produces the downstream content drafts.

## Operating rule

Jeremy talks. Claude structures. Claude anonymizes. Claude compliance checks. Claude updates files. Claude creates the content. **No manual CSV editing required from Jeremy.**

## Order of operations

1. **Interview first.** At most 5 questions per story (optional 6th only when public-use is unclear). Parses long answers and skips covered questions.
2. **Anonymize.** The voice-answer parser strips names, addresses, rates, payments, credit, income, assets, and competitor names from public-facing fields. Sensitive items stay in internal-only fields.
3. **Compliance gate.** Runs the 11 publish gates inline. Failures land in `story_bank_needs_review.csv` with the reason.
4. **CSV update.** Claude writes to the structured Story Bank CSVs automatically.
5. **Content generation.** Claude generates caption, reel, HeyGen, Canva drafts. Adds GBP and LinkedIn drafts when the angle fits.

## When to start an interview

- Jeremy says "I have a story for you," pastes a review, or starts describing a deal.
- Jeremy says "Run the interview" or "Start Story Bank intake."
- A Week N lock has open story slots and Jeremy is ready to fill them.

## The interview loop

```
[Claude] Jeremy, tell me one mortgage story.

[Jeremy] (talks)

[Claude] (parses; asks ONLY the missing critical questions; max 5)

[Jeremy] (answers)

[Claude] Here's what I captured: {summary}. Is this accurate enough to turn into content?

[Jeremy] Yes / corrections.

[Claude] (anonymizes, runs gates, writes rows, generates drafts)

[Claude] Created story_id STORY_xxx. Publish status: Publish Ready / Needs Review.
         Downstream drafts: caption, reel, HeyGen, Canva, [GBP], [LinkedIn].
         Week 1 swap eligible: yes / no.
         Next step: {action}.
```

## The 5 questions

1. What kind of story is this?
2. What was the main problem or challenge?
3. What did we do differently that helped?
4. What was the outcome?
5. What lesson should buyers, Realtors, or investors learn from it?

Optional 6th (only if needed): Can this be used publicly after removing names, addresses, and private details?

Full question rules in `story_bank_interview_questions.md`.

## Anonymization (automatic, always)

Run via `story_bank_voice_answer_parser.md`:

- First name + last name → public stripped. Internal field stores name.
- Exact address → public stripped. Internal field stores address.
- Rate / payment / credit / income / asset / loan amount → public stripped. Internal field stores number.
- Competitor lender name → replaced with "a retail lender" or "a national bank."
- Negative comment about another lender → rewritten as "another lending path was not working."
- Emotional detail → kept.
- Lesson and strategy and outcome → kept (with no "everyone gets this result" framing).

## Compliance gates (11)

Same gates as `story_bank_publish_ready_conversion_rules.md`. Failures route to `story_bank_needs_review.csv` with reason in the notes field.

## Files Claude updates per confirmed story (automatic)

1. `story_bank_interview_capture_template.csv` — append raw capture
2. `story_bank_intake_tracker.csv` — append structured record
3. `story_bank_publish_ready.csv` — append IF all 11 gates close
4. `story_bank_needs_review.csv` — append IF any gate is open
5. `story_to_content_map.csv` — append one row per recommended platform
6. `story_based_caption_drafts.csv` — append caption draft
7. `story_based_reel_scripts.csv` — append reel script
8. `story_based_heygen_prompts.csv` — append HeyGen prompt
9. `story_based_canva_prompts.csv` — append Canva prompt
10. `story_based_gbp_posts.csv` — append IF local market angle fits
11. `story_based_linkedin_posts.csv` — append IF professional / leadership angle fits

## Week 1 integration

After at least 2 Publish Ready stories exist that fit Week 1 slot frameworks, Claude offers the swap:

- `02_calendars/week_1_locked_calendar.csv`
- `05_assets/week_1_asset_generation_plan.csv`
- `06_heropost/week_1_heropost_staging_locked.csv`
- `03_content_banks/story_based_caption_drafts.csv`
- `03_content_banks/story_based_reel_scripts.csv`
- `04_prompt_banks/story_based_heygen_prompts.csv`
- `04_prompt_banks/story_based_canva_prompts.csv`

Claude does NOT mark HeroPost final ready. Media URLs do not exist until Canva, HeyGen, and Higgsfield assets are rendered and hosted.

## What this workflow refuses

- Manual CSV editing as Jeremy's task.
- Invented reviews, customers, addresses, numbers, or outcomes.
- Direct quotes from non-public reviews.
- Auto-publish.
- HeroPost upload before media URLs land.
- Banned phrases.

## Pausing and resuming

- "Pause" or "stop" → Claude saves whatever's captured with `interview_status = paused` and stops.
- "Resume STORY_xxx" → Claude reads the capture template row and continues where it left off.

## Why this beats manual form workflow

- ~2 minutes per story typical.
- Anonymization runs automatically.
- Compliance gates run automatically.
- Content drafts are produced in the same pass.
- Jeremy never opens a CSV.

## Hard rule on review-based content

Per FTC and Google review policy: real source only. No invented reviewers. No distorted customer experiences. Public reviews require Jeremy to paste real text and source URL. Default treatment is reframe-as-lesson without names.
