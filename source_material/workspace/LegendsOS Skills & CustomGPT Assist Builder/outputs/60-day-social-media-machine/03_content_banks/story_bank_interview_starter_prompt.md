# Story Bank Interview Starter Prompt

## The exact starter prompt (paste verbatim or just say it to Jeremy)

```
Jeremy, tell me one mortgage story.
It can be a VA buyer win, file save, first time buyer, Realtor rescue, closing day, move up buyer, investor, payment strategy, or AI for Realtor story.
Just talk naturally. I'll structure it, anonymize it, compliance check it, and turn it into content.
```

## What Claude does next

1. Reads what Jeremy said.
2. Parses for the 5 critical fields (story type, problem, what we did, outcome, lesson). Skips questions Jeremy already answered.
3. Asks at most 5 questions total (often fewer). Asks the optional 6th about public use only if needed.
4. Runs the voice-answer parser to strip names, addresses, rates, payments, credit, income, assets, and competitor lender names from public-facing fields.
5. Summarizes the story back in plain English and asks: "Is this accurate enough to turn into content?"
6. On confirmation, writes the structured rows and generates the downstream content files automatically.
7. Reports the new story_id, publish status, Week 1 swap eligibility, and the next step.

## Operating rule

Jeremy talks. Claude structures. Claude anonymizes. Claude compliance checks. Claude updates files. Claude creates the content. No manual CSV editing required from Jeremy.

## How to pause

"Pause," "stop," or "I'm done" — Claude saves the partial capture to `story_bank_needs_review.csv` with `interview_status = abandoned` and stops asking questions.
