# Story Bank Interview Questions

Max 5 questions per story. Optional 6th only when public-use is unclear from context. Claude parses long answers and skips questions already covered.

## Question 1 — Story type

**Ask:** "What kind of story is this?"

**Examples Claude can offer:**
- VA buyer win
- File save
- First time buyer
- Move up buyer
- Investor
- Realtor rescue
- Closing day
- Payment strategy
- AI for Realtor
- Other

Maps to framework via `story_bank_interview_to_csv_rules.md`.

## Question 2 — The problem

**Ask:** "What was the main problem or challenge?"

Capture in `problem`. The parser strips any name, address, or private number before it lands in a publishable field.

## Question 3 — The move

**Ask:** "What did we do differently that helped?"

Capture in `strategy_used`. Lean on broker-advantage framing when relevant (wholesale access, multiple investors, overlay differences, structure tradeoffs).

## Question 4 — The outcome

**Ask:** "What was the outcome?"

Capture in `outcome_summary`. No specific savings dollar amount, no rate, no payment in public copy.

## Question 5 — The lesson

**Ask:** "What lesson should buyers, Realtors, or investors learn from it?"

Capture in `lesson`. One sentence. Education, not brag.

## Optional final question (only if needed)

**Ask:** "Can this be used publicly after removing names, addresses, and private details?"

**Options:** Yes / Needs review / No, internal only.

Skip this question when context already answers it:
- Public Zillow or Google review pasted in → assumes Yes (Public Review Source).
- Jeremy's own teaching content (AI for Realtor education, broker advantage education) → assumes Yes (Educational content).
- Borrower memory with no name given → assumes Yes (anonymized).
- Borrower memory with name given and Jeremy says "internal only" or similar → No, internal only.

Only ask the optional question when public-use intent is unclear after the first 5.

## What Claude never asks

- Customer's full name. If Jeremy volunteers one, it lands in `borrower_name_do_not_publish` (internal only).
- Property address.
- Credit score, income, assets, interest rate, payment, APR, underwriting details. If Jeremy volunteers any, they land in `private_numbers_do_not_publish` (internal only).
- Competitor lender name. If Jeremy volunteers one, the public copy uses "a retail lender" or "a national bank."

## Long-form answer parsing

If Jeremy gives a paragraph covering multiple questions, Claude:

1. Identifies which of the 5 fields the answer covered.
2. Asks ONLY the missing fields.
3. Typical reduction: 5 questions → 1 to 3 questions.

Detailed parser rules live in `story_bank_voice_answer_parser.md`.

## Confirmation step (always)

Before writing anything:

```
Here is what I captured:

Story type: {framework}
Problem: {problem}
What we did: {strategy_used}
Outcome: {outcome_summary}
Lesson: {lesson}
Market: {market_area if known}
Loan type: {loan_type if known}
Public use: {permission_status}

Is this accurate enough to turn into content?
```

Jeremy confirms with "yes," "ship it," "looks good," or similar. On confirmation, Claude runs the write/generate cycle.

## What Claude refuses

- Asking Jeremy to fill out a CSV.
- Inventing fields Jeremy did not provide.
- Publishing content the confirmation step did not approve.
