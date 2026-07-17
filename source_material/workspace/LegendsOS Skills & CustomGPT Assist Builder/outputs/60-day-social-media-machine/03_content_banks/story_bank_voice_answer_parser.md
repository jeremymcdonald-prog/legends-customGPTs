# Story Bank Voice Answer Parser

How Claude parses a free-form natural answer into the 5 structured fields, with anonymization and compliance applied inline.

## Operating principle

Jeremy talks the way he talks. Claude listens, structures, and protects the brand.

## Parser pass 1 — Field extraction

For every Jeremy answer, identify text that maps to:

| Field | Trigger words and patterns |
|---|---|
| `framework` (story type) | "VA," "Veteran," "first time buyer," "FTHB," "move up," "investor," "DSCR," "Realtor rescue," "closing day," "payment," "AI," "Claude," "ChatGPT," "file save," "credit ding," "rescue," "saved the file" |
| `problem` | "the issue was," "the challenge," "they were stuck," "another lender said," "the file was," "the problem," "what was going wrong," any past-tense problem statement at the start of the story |
| `strategy_used` | "we did," "what we did differently," "I pulled," "we structured," "we shopped," "we restructured," "we slowed down," "we read the file," "we called," "the move was," any first-person action verb sequence |
| `outcome_summary` | "we closed," "the deal closed," "they got into the home," "the file moved," "Realtor was relieved," "buyer was confident," "ended up," "the result was," past-tense result statement |
| `lesson` | "the lesson is," "what people should learn," "the takeaway," "most buyers think," "the part nobody explains," reflective generalizations that follow the outcome |

Claude tags every sentence in the answer with the field it serves. A sentence can serve multiple fields.

## Parser pass 2 — Sensitive-detail extraction (always strips from public, optionally stores internal)

| Detected | Action |
|---|---|
| First name + last name pattern (e.g. "John Smith") | Remove from public fields. Store in `borrower_name_do_not_publish` (internal only). |
| Single first name in context of a borrower or Realtor | Treat as a name. Same rule. |
| Address pattern (number + street word) | Remove from public fields. Store in `property_address_do_not_publish` (internal only). |
| City alone (Jacksonville, Mandarin, St. Augustine, etc.) | KEEP. Cities are local-market signal, not PII. |
| County (Duval, St. Johns, Clay, Nassau) | KEEP. |
| Credit score number | Remove from public. Store in `private_numbers_do_not_publish`. |
| Income figure | Remove from public. Store internal. |
| Asset value | Remove from public. Store internal. |
| Specific rate (e.g. "6.25%") | Remove from public unless Jeremy explicitly requests APR-compliant publishing. Store internal. |
| Specific payment | Remove from public. Store internal. |
| Loan amount | Remove from public. Store internal. |
| Down payment dollar figure | Remove from public. Store internal. |
| Specific lender name (Wells Fargo, Rocket, Chase, etc.) | Replace in public with "a retail lender" or "a national bank." |

## Parser pass 3 — Tone and compliance rewrite

| Detected | Rewrite |
|---|---|
| Negative comment about another lender ("they fumbled it," "they didn't know what they were doing") | Rewrite as "another lending path was not working." |
| Bare superlative ("we got the lowest rate," "the best deal," "the cheapest closing") | Strip. Replace with "we got the right structure for the file" or similar non-superlative. |
| "Guaranteed" claim ("guaranteed approval," "guaranteed to save") | Strip. Replace with "we set up the structure that fit the file." |
| "Free" claim ("free closing," "no cost") | Strip. Replace with "we negotiated the structure." |
| Em-dash (—) | Replace with comma, period, or ellipsis. |
| Emoji | Strip. |
| Emotional detail ("she cried," "he was relieved," "the family was overwhelmed") | KEEP. Emotional honesty is brand voice. |
| Lesson statement | KEEP. Polish for clarity, do not over-edit. |
| Strategy detail | KEEP. The mechanics teach. |
| Outcome | KEEP. Phrase without "everyone gets this result." Avoid promising the same outcome for every borrower. |

## Parser pass 4 — Program-specific lines

| Detected | Append to public copy |
|---|---|
| VA, Veteran, VA loan, GI Bill mention | `VA is a government benefit program. Not affiliated with or endorsed by the VA.` |
| FHA | `FHA loans are subject to FHA program guidelines and credit approval.` |
| USDA | `USDA Rural Development loans subject to property and borrower eligibility.` |
| DSCR, investor, business-purpose | `For business-purpose lending. Terms differ from consumer loans.` |
| $1,000 Lowest Rate and Fee Guarantee | Full disclaimer block + "All states except Washington." Only when verified config is on file. |
| Rate quote (only if Jeremy opted in and APR is provided) | `APR is X.XX percent based on these assumptions. Rates and terms subject to change without notice.` |
| Credit topic | `This is not credit repair or legal advice.` |

## Parser pass 5 — Footer attachment

Every mortgage-related public piece appends the standard footer:

```
Jeremy McDonald
The Legends Mortgage Team powered by Loan Factory
NMLS 1195266
904-442-3213
www.mcdonald-mtg.com
```

Personal-brand, motivational, and pure educational AI pieces may skip the footer.

## Parser pass 6 — Public review handling

If Jeremy pasted a public Zillow or Google review:

- Store raw text in `review_text_raw`.
- Set `source_url` to the public profile URL.
- Default treatment: REFRAME-AS-LESSON. No reviewer name in public copy. Themes captured as Jeremy's teaching.
- Public-quote with citation is opt-in only ("Option 2"). Requires explicit "use Option 2" from Jeremy.

## Parser pass 7 — Confidence and missing-info detection

For each of the 5 fields, after parsing:

- High confidence: field has at least one full sentence of substance. → Do not ask the question.
- Low confidence: field has a fragment or is empty. → Ask the question.
- Mixed: parser found the answer but Jeremy used pronouns or ambiguous antecedents. → Ask a tight clarifier ("Was that the same file or a different one?") rather than the original question.

## Parser pass 8 — Confirmation summary

Generate the confirmation summary block (template in `story_bank_interview_questions.md`). Show Jeremy what landed in each field. Then ask: "Is this accurate enough to turn into content?"

## Edge cases

- **Multiple stories in one answer.** Capture the first complete story. Acknowledge the second and ask if Jeremy wants to capture it next.
- **Story half-shared then Jeremy pivots.** Save partial capture to `story_bank_needs_review.csv` with `interview_status = paused`. Mark it so the next interview can resume.
- **Story Jeremy decides he doesn't want to share.** Mark `publish_status = Do Not Publish`. Stop. Do not push.
- **Public review with reviewer naming a competitor.** Strip the competitor from any reframe. Keep the lesson.

## What this parser never does

- Invent a detail Jeremy did not provide.
- Add a name, an address, or a number that Jeremy did not give.
- Skip the confirmation step.
- Publish without explicit confirmation.
