# Visual Intelligence — Compliance

Canonical compliance for this skill lives in `_shared/brand-dna/compliance-pack.md`. Skill-specific additions and gate logic below.

## Reference

- Pack-wide guardrails + visual rules: `_shared/brand-dna/compliance-pack.md`
- NMLS + EHO footer + "Sent on behalf of" rule: `_shared/brand-dna/nmls-eho-footer.md`
- $1,000 guarantee terms (single source): `_shared/brand-dna/guarantee-terms.md`
- Default negative prompt: `_shared/knowledge/default-negative-prompt.md`

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

## Hard gate logic

Every output runs through the 5-score boardroom review. Compliance is the only score that is a gate.

```
if compliance_score < 8:
    verdict = "HOLD"
    output = COMPLIANCE REVIEW NOTE (specific fix required)
    do NOT mark approved
else:
    verdict = "PUBLISH" (or "FIX-THEN-PUBLISH" if any other score < 7)
    output = final approved prompt + Canva build
```

## Guarantee config check

Before any creative that references the $1,000 Lowest Rate & Fee Guarantee:

1. Read `_shared/brand-dna/guarantee-terms.md`.
2. Verify `current_guarantee_offer`, `eligible_states`, and `tc_url` are set and current.
3. Verify Washington is excluded.
4. Verify the not-a-commitment-to-lend disclaimer is included verbatim.
5. Verify NMLS #320841 is complete (six digits) and #1195266 is present.

If any check fails, BLOCK the creative. Return a compliance review note listing what's missing.

## Live fixes carried over from analyzed source images

From the original 10 source images:

- **The $2,000 promise image** showed `NMLS #32841` (missing a digit). Always verify NMLS is `#320841` (six digits) before any guarantee creative ships.
- **The bank-zombie image** named real competitors. Never repeat: no Wells Fargo, no Chase, no caricature of a named brand. Use "the big retail lender" or "the bank."

## What this skill always does

1. Picks the engine and layout that fits the topic and platform.
2. Assembles the four-layer prompt stack with the default negative prompt.
3. Reserves text + compliance zones; never lets the AI render words.
4. Outputs the 6-part package with the boardroom review.
5. Holds publish at Compliance < 8.

## Hard refusal list

- Rendering text, NMLS, EHO, CTAs, or any legal line in the AI image.
- Rate quotes on-image without APR + assumptions.
- Bare "lowest / best / guaranteed / free" claims.
- Naming or depicting a real competitor.
- Fake testimonials, real loan documents, real borrower PII.
- Government endorsement for VA / FHA / USDA.
- Guarantee creative without verified config.
- Cartoon mascots, clip art, white flyer backgrounds.
