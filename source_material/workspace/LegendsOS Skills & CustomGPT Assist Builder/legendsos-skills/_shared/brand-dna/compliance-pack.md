# LegendsOS Compliance Pack (canonical)

Single source of truth for compliance language across every customer-facing skill. Every skill references this file. Never copy these blocks into other files. Update here, propagates everywhere.

---

## Customer-facing pack-wide guardrails (PASTE)

```
COMPLIANCE GUARDRAILS (LEGENDSOS — CUSTOMER FACING)
- Always identifiable as Loan Factory, NMLS #320841. Include LO NMLS #1195266 when content is attributed to Jeremy McDonald.
- Equal Housing Lender / Equal Housing Opportunity must be available on any public marketing piece.
- Never promise or imply loan approval, guaranteed approval, or guaranteed qualification.
- Never quote an interest rate without APR, the assumptions behind it, and "rates and terms subject to change without notice."
- Do not use "lowest," "best," "guaranteed," "free," or "no cost" as bare claims. The $1,000 Lowest Rate & Fee Guarantee may be referenced only with its actual program terms.
- No specific payment, savings, or cash-to-close numbers without stating they are estimates and not a commitment to lend.
- This is not credit repair, legal advice, or tax advice. Add the relevant line when the topic touches credit, legal, or taxes.
- Investor / DSCR / business-purpose content: state it is for business-purpose lending and terms differ from consumer loans.
- VA content: VA is a government benefit program. Do not imply VA endorsement of Loan Factory.
- When a claim needs a source and none is provided, flag it for human review instead of inventing it.
- Output a short compliance footer block the user can paste under any public piece.
```

---

## Visual compliance rules (PASTE)

```
LEGENDSOS VISUAL COMPLIANCE RULES
- Do not promise or imply loan approval or guaranteed qualification.
- Do not claim "lowest rate" or "lowest fees" unless the claim is sourced and approved in writing.
- Do not quote an interest rate without APR and the assumptions behind it.
- Do not imply guaranteed savings unless tied to approved, current program terms.
- Use Best Price / Lowest Rate & Fee Guarantee language only when accurate, current, and approved.
- Do not put a specific guarantee dollar amount on an image unless the current source offer and eligible states are confirmed. Verify the live amount before publishing; do not assume.
- Do not promote the Best Price Guarantee in or to Washington. Include "All states except Washington" when the guarantee is featured.
- Always include the T&C URL and "This is not a commitment to lend. All loans subject to credit approval. Rates, terms, and fees subject to change without notice." on any guarantee creative.
- Include Equal Housing Lender when required.
- Include Loan Factory NMLS #320841 when required. Verify the number is correct and complete every time (it is 320841, six digits).
- Include the individual LO NMLS when the LO is promoted (Jeremy: #1195266).
- Do not use fake testimonials. Real reviews only, with "Individual results vary."
- Do not show fake or real loan documents, or any private borrower data.
- Do not depict or name a real competitor (no bank logos, no "Wells Fargo / Chase," no competitor caricatures).
- Do not imply government endorsement for VA, FHA, or USDA.
- Use "Terms, eligibility, and program guidelines apply" when featuring any program.
- Treat illustrative dashboards, stats, and numbers as clearly illustrative, never as real performance claims.
- When unsure, output a COMPLIANCE REVIEW NOTE instead of marking the image approved.
```

---

## AI Boardroom guardrails (PASTE)

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

---

## Risk Tier Model (Operational reviews)

| Tier | Trigger | Ship rule |
|---|---|---|
| **Tier 1 — Green** | Internal-only, no active-loan data, no external send | Ship earliest. Light approval. Audit log still required. |
| **Tier 2 — Yellow** | Public marketing copy, partner or borrower emails, no active-loan PII | Human review before send. NMLS + EHO footer. Owner approval. |
| **Tier 3 — Red** | Active loans, lender escalation, borrower PII, GLBA exposure, sender-identity risk, AI-written external email | Draft only. No auto-send. Owner + Compliance/Legal written sign-off. Mandatory audit log + routing record. AI-written external bodies stay in draft for human approval, minimum first 90 days. |

**Hard rule:** Any AI-generated external or sensitive message goes to draft / human approval first. Never auto-send. Always require audit logs and routing records.

---

## Boardroom Risk Register (R-codes)

| Code | Risk |
|---|---|
| R2 | Orphan systems: new tool with its own data model that should live in one shared source (TERA / Airtable). |
| R3 | Template / map drift: routing maps, contact maps, lender lists duplicated across systems. |
| R4 | Unapproved content drift: content going out without approval, mainly external-facing. |
| R7 | Data model debt: missing reference keys (lender_id, group_id, LO record) captured too late. |
| R8 | Overbuilding: automating before the manual version is proven. Manual first, automate second. |
| R10 | Autopilot risk on external communication: automated external sends without keyword filter or human review. |

Do not invent new R-codes in any skill. The full register lives in Jeremy's architecture docs; new codes are added there only.

---

## Program-specific lines (add when topic matches)

| Topic | Line to include |
|---|---|
| VA / Veteran | "VA is a government benefit program. Eligibility and program guidelines apply." (No VA endorsement of Loan Factory.) |
| FHA | "FHA is a government insurance program. Terms, eligibility, and program guidelines apply." (No FHA endorsement.) |
| USDA | "USDA is a government program. Eligibility and program guidelines apply." (No USDA endorsement.) |
| DPA | "Programs vary by area, subject to availability and eligibility. Terms and program guidelines apply." |
| Investor / DSCR / Bank Statement | "Business-purpose lending. Terms differ from consumer loans." |
| Refi | "Refinance results vary by borrower. Terms and guidelines apply." |
| Webinar promo | "Educational. Terms, eligibility, and program guidelines apply." |
| Realtor co-brand | "RESPA-safe. No thing-of-value-for-referrals. Both parties' licenses shown." |
| Testimonial | "Real review. Individual results vary. Not a commitment to lend." |
| Illustrative dashboard / stat | Label as "Illustrative" on-image. Never present as real performance. |

---

## CAN-SPAM (Email Newsletter)

Every public email must include physical mailing address and a working unsubscribe link in the footer. Subject lines must not be deceptive.
