# Story Bank Interview Mode Report

**Run date.** 2026-05-24.
**Change.** Manual CSV fill workflow → guided interview workflow (5-question model with voice-answer parser).

## What changed in this update

- Question count: 6 → **5** (optional 6th only when public-use is unclear).
- Starter prompt: updated to the exact 3-line form Jeremy specified.
- New file: `story_bank_voice_answer_parser.md` — 8 parser passes that handle long natural answers, sensitive-detail extraction, tone rewrite, program-specific lines, footer, and confirmation summary generation.

## Operating rule

Jeremy talks. Claude structures. Claude anonymizes. Claude compliance checks. Claude updates files. Claude creates the content.

## Files created or updated this sprint

1. `03_content_banks/story_bank_interview_workflow.md` — updated to 5-question model.
2. `03_content_banks/story_bank_interview_questions.md` — updated to 5-question model with optional 6th.
3. `03_content_banks/story_bank_interview_capture_template.csv` — unchanged (23 fields, existing example row).
4. `03_content_banks/story_bank_interview_to_csv_rules.md` — Q1 mapping updated (VA buyer win first).
5. `03_content_banks/story_bank_voice_answer_parser.md` — NEW. Eight parser passes.
6. `03_content_banks/story_bank_interview_starter_prompt.md` — updated to exact spec text.
7. `08_reports/story_bank_interview_mode_report.md` — this report.

## Files retained as backend only (Jeremy does not open these)

- `manual_review_intake_form.csv`
- `manual_borrower_memory_intake_form.csv`
- `story_bank_copy_paste_queue.md`
- `story_bank_manual_intake_instructions.md`
- `story_bank_publish_ready_conversion_rules.md`
- `story_bank_next_action_report.md`

## Current Story Bank state

- Total intake records: 15 (12 placeholder + 3 real captured last sprint).
- Publish Ready: 3 (STORY_013 VA borrower memory, STORY_014 Clay County VA reframe, STORY_015 Realtor AI educational).
- Needs Review / Source Pending: 12.
- Week 1 Wednesday slot now references STORY_014.
- Week 1 Friday slot now references STORY_013.
- HeroPost final upload still blocked on media URLs.

## How the interview compresses the work

- **Before:** Open CSV, find row, paste review text, set name, loan type, market, framework, lesson, permission, publish status, run gates, copy to publish_ready.csv. ~5 to 10 minutes per story.
- **After:** Jeremy talks. Claude asks at most 5 questions. Confirmation. Claude writes everything. ~2 minutes per story.

## Compliance posture preserved

- No invented reviews.
- No invented customers.
- No customer names in public copy.
- No exact addresses.
- No private loan details in public copy.
- No banned phrases.
- No em dashes.
- Mortgage content carries Jeremy's footer.
- VA content carries VA non-endorsement note.
- Public reviews require real source text and source URL; reframe is default.

## Exact next action

Use the starter prompt and give Claude the next story. Claude runs the interview, captures, structures, anonymizes, gates, writes, and reports.
