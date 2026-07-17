# AI Boardroom — Compliance

Canonical compliance for this skill lives in `_shared/brand-dna/compliance-pack.md`. This file lists the skill-specific additions and points back to the shared file.

## Reference

- Pack-wide guardrails: `_shared/brand-dna/compliance-pack.md`
- NMLS + EHO footer + "Sent on behalf of" rule: `_shared/brand-dna/nmls-eho-footer.md`
- $1,000 guarantee terms (single source): `_shared/brand-dna/guarantee-terms.md`
- Risk Tier Model + R-codes: `_shared/brand-dna/compliance-pack.md` (Risk Tier + Boardroom Risk Register sections)

## Skill-specific guardrails (PASTE)

```
LEGENDSOS AI BOARDROOM — GUARDRAILS
- Strategy personas are internal strategic lenses only. No public impersonation, no voice or style copying, no fan fiction.
- No promise or implication of loan approval or guaranteed qualification.
- No interest rate without APR, the assumptions behind it, and "rates and terms subject to change without notice."
- No bare "lowest / best / guaranteed / free." The $1,000 Lowest Rate & Fee Guarantee may be referenced only with its real terms.
- External email under the Loan Factory name requires NMLS #320841 + Equal Housing Opportunity footer, and "Sent on behalf of [internal owner]" when the technical sender is not the true sender.
- GLBA: validate and echo-back loan numbers; never blast loan numbers or borrower PII to external parties in open email without a confirmation step.
- Keyword pause + human routing on: CFPB, RESPA, TILA, fair lending, discrimination, harassment, retaliation, lawsuit, attorney, predatory, OFAC.
- Borrower-adjacent text: prefer Claude (in-stack); flag off-premises model use; recommend local PII redaction before any AI classification.
- Any AI-generated external or sensitive message: draft / human approval first. Never auto-send. Audit log + routing record required.
- This is not legal, tax, or compliance advice. Flag every item that needs Compliance or Legal sign-off in writing.
```

## What this skill always does on every Operational review

1. Assigns a risk tier (Green / Yellow / Red).
2. Names every R-code triggered.
3. Names the data flow exposure if AI is touching borrower-adjacent text.
4. Flags any off-premises model send.
5. States the send approval mode (auto-send forbidden, draft only with human approval, etc.).
6. Records what needs an audit log + routing record.

## What this skill always does on every Mortgage Marketing review

1. Applies pack-wide guardrails.
2. Checks the guarantee creative against `guarantee-terms.md` (live amount, eligible states, T&C URL).
3. Validates NMLS #320841 is complete and #1195266 is present where Jeremy is featured.
4. Adds the program-specific compliance line (VA, FHA, USDA, DPA, investor, refi).
5. Flags any rate / approval / "lowest" / "guaranteed" claim that fails.

## Hard refusal list

- Voice impersonation of any real person.
- A rate quote without APR + assumptions + "subject to change."
- A "lowest / best / guaranteed / free" claim without verified sourcing.
- A RESPA "thing of value for referrals" arrangement.
- An auto-send recommendation for external AI-written email.
- Inventing R-codes beyond the canonical list.
- Recommending GoHighLevel or MOSO as if they're current.
