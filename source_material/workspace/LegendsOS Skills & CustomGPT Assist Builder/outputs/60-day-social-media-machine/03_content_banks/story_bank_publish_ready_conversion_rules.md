# Story Bank Publish Ready Conversion Rules

A record moves from Needs Review or Source Pending to **Publish Ready** only when **all 11 gates** below close. If any gate is open, the record stays in Needs Review.

## The 11 gates

1. **Real source text or real borrower memory exists.** No invented review. No invented customer. Either `review_text_paste_here` contains the exact review text, or the borrower memory fields are filled in Jeremy's own words.
2. **Customer name is removed** from any publishable field. The `reviewer_name_remove_before_publishing` field can hold the public reviewer name for reference; the published content does not name the customer unless `permission_status = Approved`.
3. **Exact address is removed.** No street + city pair. No MLS number. The `property_address_do_not_publish` field stays internal only.
4. **Sensitive loan details are removed.** No rate, no payment, no credit score, no income, no asset value, no loan amount, no down payment dollar figure.
5. **No direct customer quote** unless the source is a public review AND `source_url` resolves to the public profile or specific review URL AND the published content cites it as "Public review on [platform]."
6. **No guaranteed-result language.** No "we always," no "the same result for every borrower," no "guaranteed approval."
7. **No rate mention** unless paired with APR and assumptions and the "rates and terms subject to change without notice" line. (Easiest path: skip rate references entirely.)
8. **Story framework is set.** One of: The File Save, The Veteran Win, The First Time Buyer Confidence Shift, The Realtor Rescue, The Payment Reality Check, The Broker Advantage Story, The Investor Numbers Story, The Move Up Buyer Strategy Story, The Appraisal or Inspection Curveball Story, The Closing Day Lesson, The AI Helped the Realtor Win Story.
9. **Content lesson is set.** A one-sentence takeaway that frames the story as education, not a brag.
10. **compliance_risk is Green or Yellow.** Red-tier (named customer, rate quote, guarantee dollar amount) requires owner sign-off and does not move to Publish Ready automatically.
11. **publish_status equals Publish Ready.** Operator (Jeremy) flips the field after every prior gate is confirmed.

## Program-specific required lines (when applicable)

- **VA story** → `VA is a government benefit program. Not affiliated with or endorsed by the VA.`
- **FHA story** → `FHA loans are subject to FHA program guidelines and credit approval.`
- **USDA story** → `USDA Rural Development loans subject to property and borrower eligibility.`
- **DSCR / investor story** → `For business-purpose lending. Terms differ from consumer loans.`
- **Guarantee mention** → full guarantee disclaimer block + "All states except Washington."

## The Publish Ready conversion checklist (paste at the top of each record's compliance_notes)

```
[ ] Real source captured (review text or memory)
[ ] Customer name removed from publishable fields
[ ] Address removed
[ ] No rate / payment / credit / income / asset numbers
[ ] No direct quote (or public-quote with citation)
[ ] No guaranteed-result language
[ ] No banned phrases (lowest / best / guaranteed / free)
[ ] Framework assigned
[ ] Lesson written
[ ] Program-specific line attached (if applicable)
[ ] compliance_risk = Green or Yellow
[ ] publish_status = Publish Ready
```

When every box is checked, the record can power downstream content.

## What happens after Publish Ready

1. Copy the record into `story_bank_publish_ready.csv`.
2. Notify the Weekly Production Engine.
3. The Engine swaps the matching `Source Pending` rows in the story-based drafts for real-source rows.
4. Downstream skills (Social Media, Local SEO, HeyGen, Higgsfield, Canva) can pull the source ID.

## Reverting a record from Publish Ready

If a record is published and the customer later asks to be removed, or if a new compliance flag surfaces:

1. Move the record's `publish_status` to `Retired`.
2. Update the production tracker: any Posted asset stays in the public record; future planned slots get re-assigned to a different source ID.
3. Notify the Boardroom for postmortem if a complaint or compliance issue triggered the retirement.

## Owner approval (Red-tier escalation)

Records that reach Publish Ready with any of these flags require Jeremy's written sign-off before any downstream content goes live:

- Named customer with `permission_status = Approved`
- Specific rate paired with APR + assumptions
- Guarantee dollar amount
- Address used for marketing
