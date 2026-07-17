# Compliance QA Checklist

The GPT must append this checklist (filled in) to every campaign output. The checklist is also a final review the loan officer can hand to Loan Factory compliance.

> **All marketing produced by this GPT is draft. Nothing here is final until Loan Factory compliance has reviewed and approved.**

---

## 0. V4 Universal Checks (Apply to Every Output)

- [ ] Public-facing loan officer data is dynamically pulled from `03_TEAM_ROSTER_AND_DISCLOSURES.md` and `TEAM_ASSET_REFERENCE.md` based on the user's selection — no hardcoded LO in the template.
- [ ] Hero image upload was requested from the LO before any final graphic was produced.
- [ ] Agent license number is NOT treated as a required input. Web search if practical, leave out if not found, never block the draft.
- [ ] Agent headshot and brokerage logo are treated as optional. If not provided, the draft proceeds without them.
- [ ] For 2/1 Buydown: both FHA 3.5% down and Conventional 5% down example scenarios are present (V4 default), and the seller-funded buydown cost is estimated from the rate math (not asked from the LO upfront).
- [ ] Copy-paste image generation prompt does not start with a compliance lecture. Practical layout first, do-not-include list at the end.

## 1. Universal Checks (every output)

- [ ] Loan officer matches an active member of the Legends Mortgage Team roster.
- [ ] Loan officer's NMLS is included with the loan officer name.
- [ ] "Loan Factory" appears with NMLS 320841.
- [ ] Loan officer's licensed state(s) appear when an offer or rate is shown.
- [ ] Loan officer's @loanfactory.com email is used (not a personal email).
- [ ] Equal Housing Lender logo is referenced or visible (image assets) and "Equal Housing Lender" appears in caption/email/text disclosure.
- [ ] No invented APR, property taxes, HOA, interest rate, seller credit, agent name, brokerage, headshot, or license number.
- [ ] No unsupported claims (lowest, best, no closing costs, guaranteed rate, guaranteed approval, guaranteed savings, free money).
- [ ] No referral exchange language between mortgage and real estate parties.
- [ ] Borrower private information is not disclosed.
- [ ] Output is clearly labeled as draft marketing content for compliance review.

## 2. Image-Specific Checks

- [ ] Loan Factory mark sized **equal to or larger** than loan officer's name or personal domain.
- [ ] NMLS text sized **equal to the smallest text** on the image.
- [ ] EHL logo placeholder included in the image prompt.
- [ ] Loan officer headshot placeholder uses the correct token from `04_TEAM_ASSET_INDEX.md`.
- [ ] Agent assets are real and approved, or marked as placeholder pending agent confirmation.
- [ ] Listing hero image is real (from listing or agent), not generated.
- [ ] Image prompt itself instructs the designer/tool not to invent assets.

## 3. Rate-Specific Checks (only if a rate is shown)

- [ ] Interest rate value confirmed by loan officer for this campaign.
- [ ] APR confirmed by loan officer for this campaign.
- [ ] Rate and APR appear at the **same font style, size, and prominence**.
- [ ] Sample scenario included (purchase price, loan amount, term, rate, APR, P&I, taxes, insurance, HOA if any, seller credit if any).
- [ ] Insurance source labeled ($120/mo placeholder only if loan officer approved, otherwise real estimate).

## 4. Trigger Terms Checks

If any of the following appear, treat as trigger-terms asset and confirm sample scenario is present:

- Down payment amount or percentage
- Monthly payment amount
- Loan term (e.g., 30-year, 15-year)
- Finance charge
- Specific payment example

- [ ] Full sample scenario present.
- [ ] Asset tagged "Triggers full TILA-style scenario disclosure — requires heightened compliance review."
- [ ] All assumptions sourced from confirmed values, not invented.

## 5. Campaign-Specific Checks

### 5a. Seller-Funded 2/1 Buydown (V4)

- [ ] Buydown described as **seller-funded**.
- [ ] Year 1 / Year 2 / Years 3-30 rate structure explained.
- [ ] Note rate and APR shown together, matched in font style, size, and prominence.
- [ ] Sample scenario included.
- [ ] **Both FHA 3.5% down AND Conventional 5% down payment examples shown** (V4 default).
- [ ] 20% down NOT used unless user explicitly requested it.
- [ ] Estimated seller-funded buydown cost computed via rate math (Year 1 + Year 2 subsidies). Not asked from the LO upfront.
- [ ] When MND market-context rates used: buydown cost labeled "estimated market-context buydown cost", never a final concession, quote, approval, or commitment.
- [ ] No exact rate or APR on the image.
- [ ] Hero image upload requested from the LO before final graphic generation.
- [ ] Agent license number not required to proceed (web-searched if practical, left out if not found).
- [ ] Agent headshot and brokerage logo handled as optional.
- [ ] Public-facing LO data dynamically pulled from the roster (no specific LO hardcoded).

### 5b. 100% Financing with Assistance

- [ ] Specific structure named (USDA, VA, Conv 1st + DPA program name).
- [ ] Buyer's actual out-of-pocket costs acknowledged (earnest, inspection, prepaids).
- [ ] Eligibility caveat present (program-specific, subject to underwriting).
- [ ] No "free money" or "no money out of pocket" claims.

### 5c. VA Buyer with 1% Closing Cost Credit

- [ ] "Eligible VA borrowers" language present.
- [ ] 1% credit described accurately (loan amount, at closing, toward closing costs, cannot exceed actual closing costs).
- [ ] No claim that the property itself is "VA approved."
- [ ] Sample scenario included if any trigger term shown.

### 5d. General Listing Marketing

- [ ] No rate or APR unless both confirmed by loan officer.
- [ ] Listing details accurate to source.
- [ ] Agent assets real and approved, or marked as placeholder.

## 6. $2,000 Best Price Guarantee Checks

- [ ] If included anywhere, terms line is present in BOTH the caption and the image:
      "Terms and Conditions: https://www.loanfactory.com/best-price-guarantee"
- [ ] Guarantee is **NOT** advertised or promoted for any WA listing or WA-targeted audience.
- [ ] If WA conflict identified, guarantee removed and rationale noted.

## 7. State Licensing Handoff Check

- [ ] Property state matches one of the **public-facing** loan officer's licensed states.
- [ ] If the originally selected LO is not licensed in the property state, the **State Licensing Handoff Workflow** (`01_GPT_MASTER_INSTRUCTIONS.md` Section 14) was run before drafting:
  - [ ] Mismatch flagged by name and state.
  - [ ] Roster searched for licensed teammates in the property state.
  - [ ] Licensed teammates (if any) listed for the user.
  - [ ] User selected a licensed teammate to attach as the public-facing LO, **or** confirmed no licensed teammate is available.
- [ ] No public-facing promotional mortgage copy was produced under an unlicensed LO for that property state.
- [ ] Originally selected LO (e.g., Jeremy) does **not** appear on the public-facing asset as the licensed LO — only the chosen licensed teammate appears with name, NMLS, phone, email, and headshot.
- [ ] If the originally selected LO is involved, their role is documented as team lead, strategy support, or internal reviewer — never public-facing licensed LO for that state.
- [ ] If no licensed teammate is available in that state, output is limited to either education-only public content (no rate, no offer, no licensed mortgage CTA) **or** internal strategy content clearly labeled "Internal strategy — not for public distribution."
- [ ] Preferred response pattern matched when the workflow triggered, per `01_GPT_MASTER_INSTRUCTIONS.md` Section 14.2.

## 8. Channel Compliance Check

- [ ] Email signature includes loan officer @loanfactory.com email, NMLS, Loan Factory NMLS 320841, licensed state(s), and "Equal Housing Lender."
- [ ] Text and DM end with "— [Loan officer name], Loan Factory NMLS 320841."
- [ ] No personal email or non-company phone used for mortgage communication.

## 9. Final Sign-Off

- [ ] Output labeled "Draft marketing content for compliance review."
- [ ] Final approval reminder present:
      "Final reminder: this is a draft. Send to Loan Factory compliance for review before sending to the agent, posting publicly, printing, or filming."

---

## 10. If Any Box Is Unchecked

Stop and remediate before producing the final draft. Tell the loan officer specifically which item is failing and what's needed. Do not push partial outputs through.

---

## 11. MND Market-Rate Context Checks (only if MND is used as the rate source)

- [ ] The loan officer was offered all three rate-source options (LO-provided rate + APR, MND average market context, no rate) and explicitly chose MND.
- [ ] The MND page URL matches the loan type (Conventional → `/30-year-fixed`; FHA → `/30-year-fha`; VA → `/30-year-va`; Jumbo → `/30-year-jumbo`). Fallback to `/30-year-fixed` is labeled "general conventional baseline" when used.
- [ ] The conservative spread (MND rate − 0.25% to MND rate + 0.50%) was applied. Any override of the default spread is documented in the compliance footer.
- [ ] The output uses the required payment-range format (Estimated P&I range, Assumptions block, Important note).
- [ ] Each line of the Assumptions block is filled in or explicitly marked "not included."
- [ ] At least one required framing phrase appears in the caption: "Estimated payment range", "Market-context example", "Based on average market rate data", or "Actual rate, APR, payment, and terms will vary".
- [ ] No forbidden phrases appear anywhere: "your rate", "guaranteed payment", "locked payment", "available now", "you qualify for", "this home can be yours for", "no closing costs", "lowest rate", "best rate", "Loan Factory's rate", "our rate".
- [ ] The exact MND rate value is **not** printed on the image.
- [ ] No APR value is printed on the image (since MND does not publish APR).
- [ ] The caption attributes the rate range to MND ("Mortgage News Daily" with the URL when appropriate) without implying Loan Factory is offering that rate.
- [ ] The State Licensing Handoff Workflow ran before MND data was used. Property state is covered by the public-facing LO.
- [ ] The internal compliance footer includes: source = Mortgage News Daily, source URL, survey rate as of timestamp, rate range used.
- [ ] If the draft mixes LO-confirmed rate + APR (option a) with an MND payment range (option b), each rate is clearly labeled with its source.
