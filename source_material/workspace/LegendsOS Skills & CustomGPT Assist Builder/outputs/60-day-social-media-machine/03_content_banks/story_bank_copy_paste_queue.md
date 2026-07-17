# Story Bank Copy Paste Queue

Twelve clearly separated boxes. Paste the real source material into each box. The Story Bank operator (or Jeremy directly) then transfers the captured text into `manual_review_intake_form.csv` or `manual_borrower_memory_intake_form.csv` and validates against the conversion rules.

**Source links (open in another tab):**
- Zillow: https://www.zillow.com/lender-profile/JeremyMcDonaldFL/#reviews
- Google Business Profile: https://www.google.com/search?q=jeremy+mcdonald+mortgage+broker
- Website: https://www.mcdonald-mtg.com/en

---

## STORY_001 — Zillow Review

```
PASTE REVIEW TEXT HERE
---
Reviewer name as published:
Review date:
Star rating (1 to 5):
Direct review URL (if Zillow exposes one):
Loan type if mentioned:
Market area if mentioned:
Notes for the lesson framing:
```

---

## STORY_002 — Zillow Review

```
PASTE REVIEW TEXT HERE
---
Reviewer name as published:
Review date:
Star rating (1 to 5):
Direct review URL (if Zillow exposes one):
Loan type if mentioned:
Market area if mentioned:
Notes for the lesson framing:
```

---

## STORY_003 — Zillow Review

```
PASTE REVIEW TEXT HERE
---
Reviewer name as published:
Review date:
Star rating (1 to 5):
Direct review URL (if Zillow exposes one):
Loan type if mentioned:
Market area if mentioned:
Notes for the lesson framing:
```

---

## STORY_004 — Zillow Review

```
PASTE REVIEW TEXT HERE
---
Reviewer name as published:
Review date:
Star rating (1 to 5):
Direct review URL (if Zillow exposes one):
Loan type if mentioned:
Market area if mentioned:
Notes for the lesson framing:
```

---

## STORY_005 — Zillow Review

```
PASTE REVIEW TEXT HERE
---
Reviewer name as published:
Review date:
Star rating (1 to 5):
Direct review URL (if Zillow exposes one):
Loan type if mentioned:
Market area if mentioned:
Notes for the lesson framing:
```

---

## STORY_006 — Google Business Profile Review

```
PASTE REVIEW TEXT HERE
---
Reviewer name as published:
Review date:
Star rating (1 to 5):
Direct review URL (if Google exposes one):
Loan type if mentioned:
Market area if mentioned:
Notes for the lesson framing:
```

---

## STORY_007 — Google Business Profile Review

```
PASTE REVIEW TEXT HERE
---
Reviewer name as published:
Review date:
Star rating (1 to 5):
Direct review URL (if Google exposes one):
Loan type if mentioned:
Market area if mentioned:
Notes for the lesson framing:
```

---

## STORY_008 — Google Business Profile Review

```
PASTE REVIEW TEXT HERE
---
Reviewer name as published:
Review date:
Star rating (1 to 5):
Direct review URL (if Google exposes one):
Loan type if mentioned:
Market area if mentioned:
Notes for the lesson framing:
```

---

## STORY_009 — Google Business Profile Review

```
PASTE REVIEW TEXT HERE
---
Reviewer name as published:
Review date:
Star rating (1 to 5):
Direct review URL (if Google exposes one):
Loan type if mentioned:
Market area if mentioned:
Notes for the lesson framing:
```

---

## STORY_010 — Google Business Profile Review

```
PASTE REVIEW TEXT HERE
---
Reviewer name as published:
Review date:
Star rating (1 to 5):
Direct review URL (if Google exposes one):
Loan type if mentioned:
Market area if mentioned:
Notes for the lesson framing:
```

---

## STORY_011 — Borrower Memory

```
WRITE THE MEMORY HERE IN YOUR OWN WORDS
---
Date or timeframe (e.g. April 2026):
Loan type (VA, FHA, FTHB, Conventional, DSCR, Refi):
Market area (Jacksonville, St. Johns County, Ponte Vedra, etc.):
Borrower name (INTERNAL ONLY — never published):
Property address (INTERNAL ONLY — never published):
What was the problem:
What made the file hard:
What strategy did we use:
What was the result:
What lesson should people learn:
Can this be used publicly after anonymization (yes / no):
```

---

## STORY_012 — Borrower Memory

```
WRITE THE MEMORY HERE IN YOUR OWN WORDS
---
Date or timeframe (e.g. April 2026):
Loan type (VA, FHA, FTHB, Conventional, DSCR, Refi):
Market area (Jacksonville, St. Johns County, Ponte Vedra, etc.):
Borrower name (INTERNAL ONLY — never published):
Property address (INTERNAL ONLY — never published):
What was the problem:
What made the file hard:
What strategy did we use:
What was the result:
What lesson should people learn:
Can this be used publicly after anonymization (yes / no):
```

---

## After the boxes are filled

1. Open `manual_review_intake_form.csv` and `manual_borrower_memory_intake_form.csv`.
2. Transfer the captured text into the matching `story_id` row.
3. Run the 11-gate check from `story_bank_publish_ready_conversion_rules.md`.
4. Flip `publish_status` to `Publish Ready` on the records that pass every gate.
5. Append those records to `story_bank_publish_ready.csv`.
6. Tell the Weekly Production Engine which IDs moved to Publish Ready.

## Reminders

- Never invent or paraphrase a review.
- Never publish a customer name without written permission.
- Never publish an exact address.
- Never publish a rate, payment, credit, income, or asset number.
- VA, FHA, USDA, DSCR stories carry the program-specific compliance line.
- Drafts only until Jeremy approves.
