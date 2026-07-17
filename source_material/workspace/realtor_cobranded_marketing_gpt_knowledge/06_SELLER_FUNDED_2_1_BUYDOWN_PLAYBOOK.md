# Seller-Funded 2/1 Buydown Playbook (V4)

This playbook tells the Custom GPT how to draft a compliant Seller-Funded 2/1 Buydown campaign. V4 ships two major updates: (1) the GPT always creates payment examples for **both FHA 3.5% down and Conventional 5% down** by default, and (2) the GPT **estimates the seller-funded buydown cost from the rate math** instead of asking the loan officer for a seller concession amount upfront.

---

## 1. What This Campaign Is

A 2/1 buydown temporarily reduces the buyer's effective rate by 2% in year 1 and 1% in year 2 before returning to the full note rate in year 3 and beyond. The seller funds the buydown as a closing-cost concession. The buyer qualifies at the full note rate. The buydown does not change the underlying 30-year fixed loan.

## 2. V4 Defaults — Both FHA and Conventional

For every 2/1 Buydown campaign, the GPT always produces payment examples for BOTH:

- **FHA 30-year fixed with 3.5% down** (FHA program minimum)
- **Conventional 30-year fixed with 5% down** (standard low-down-payment Conventional)

20% down is **NOT** the default. The GPT only uses 20% down if the user explicitly asks for it. The LO can request additional scenarios (10%, 15%, 20%, etc.) but the FHA-3.5 and Conv-5 pair always ships first.

## 3. Compliance Requirements Specific to This Campaign

In addition to all rules in `02_LOAN_FACTORY_MARKETING_COMPLIANCE_RULES.md`:

- Always state the buydown is **seller-funded**.
- Always quote the **note rate** and the **year-1 / year-2 effective rates** when quoting any rate.
- Always include **APR** at matching prominence whenever a rate is quoted publicly. APR comes from the LO under option (a). Under option (b) MND, no APR is shown and the output is restricted to educational payment range estimates.
- Trigger terms almost always apply — include the full sample scenario in the asset.

### State Licensing Pre-Check (Mandatory)

Before drafting any 2/1 Buydown campaign output, confirm the selected loan officer is licensed in the property state. If not, run the **State Licensing Handoff Workflow** in `00_PASTE_IN_GPT_INSTRUCTIONS_SHORT.md` and `01_GPT_MASTER_INSTRUCTIONS.md` §14. Required response pattern (swap names/state to fit):

> [Selected LO] is not licensed in [state]. The roster shows [teammate(s)] are licensed in [state]. Choose one and I'll build the campaign under that licensed LO, with [original LO] staying in the background as team lead or strategy support.

## 4. Estimating Seller-Funded Buydown Cost (V4)

V4 does **not** ask the loan officer for a seller concession amount upfront. The GPT estimates the cost using the rate math.

For each scenario (FHA 3.5% and Conv 5%) at a given note rate **N%**:

- **Year 1 subsidy** = (P&I at N% − P&I at (N−2)%) × 12
- **Year 2 subsidy** = (P&I at N% − P&I at (N−1)%) × 12
- **Estimated seller-funded buydown cost** = Year 1 subsidy + Year 2 subsidy

When MND market-context rates are used (option b in `05_LISTING_INTAKE_WORKFLOW.md` §7), the GPT computes the estimate at the **MND average rate** (the center of the spread) and frames the output as an "estimated market-context buydown cost" — never a final concession, quote, approval, locked rate, or commitment to lend.

## 5. Inputs Required

- Purchase price (LO-confirmed)
- Note rates for FHA and Conventional (option a: LO-provided rate + APR; option b: MND market context per loan type)
- Property taxes (LO-confirmed or marked "not included")
- Insurance (LO-confirmed or marked "not included")
- HOA (LO-confirmed or marked "not included")
- MI / MIP (LO-confirmed for both FHA and Conv when <20% down; otherwise marked "not included" with a note that FHA MIP and Conv MI <20% almost always apply)

Do **NOT** ask for or block on:

- Seller concession amount (the GPT estimates it; see §4)
- Agent license number (web-search if practical; leave out if not found)
- Agent headshot or brokerage logo (optional — see §6)

## 6. Optional Asset Inputs

Ask the loan officer once: "Do you want the agent's headshot and brokerage logo on the graphic?"

- **Yes:** ask for the URLs or files. If the LO doesn't end up providing them, the GPT still proceeds with text-only attribution ("Listing presented by AGENT_NAME at AGENT_BROKERAGE") and notes the missing asset in the Missing Inputs section.
- **No:** the GPT produces a version with no agent visual.

**Always** request the listing hero image upload before generating the final graphic (see §11).

## 7. Required Output Order (V4)

Always produce 2/1 Buydown campaign output in this exact order:

1. Campaign summary
2. Verified listing facts
3. Assumptions used
4. FHA 3.5% down 2/1 buydown estimate
5. Conventional 5% down 2/1 buydown estimate
6. Estimated seller-funded buydown cost explanation
7. Copy-paste image generation prompt
8. Social caption
9. Agent email
10. Agent text
11. Agent DM
12. Compliance checklist

## 8. Sample Output — FHA 3.5% Down

```
FHA 3.5% Down 2/1 Buydown Estimate

Purchase price: $[LISTING_PRICE]
Down payment: 3.5% = $[DP_AMOUNT]
Loan amount: $[LOAN_AMOUNT_FHA]
Loan type: FHA 30-year fixed
Note rate source: [LO-confirmed | Mortgage News Daily — /mortgage-rates/30-year-fha]
Note rate used: [N]%
Year 1 effective rate: [N − 2]%
Year 2 effective rate: [N − 1]%
Years 3-30 effective rate: [N]% (note rate)

Estimated P&I at note rate: $[A]/mo
Estimated P&I year 1 (effective rate): $[B]/mo
Estimated P&I year 2 (effective rate): $[C]/mo
Year 1 estimated monthly savings vs. note rate: $[A − B]/mo
Year 2 estimated monthly savings vs. note rate: $[A − C]/mo

Taxes: [confirmed value | not included]
Insurance: [confirmed value | not included]
HOA: [confirmed value | not included]
MIP: [confirmed value | not included — FHA MIP almost always applies]

Important note: this is an estimate for illustration only. It is not a quote, approval, commitment to lend, or locked rate. Actual rate, APR, payment, and terms depend on credit, income, assets, occupancy, property details, and final underwriting.
```

## 9. Sample Output — Conventional 5% Down

Same structure as §8 with:

- Down payment: 5% = $[DP_AMOUNT]
- Loan type: Conventional 30-year fixed
- Note rate source: [LO-confirmed | Mortgage News Daily — /mortgage-rates/30-year-fixed]
- MI: [confirmed value | not included — Conv <20% down almost always has MI]

## 10. Seller-Funded Buydown Cost Estimate Block

```
Estimated Seller-Funded Buydown Cost

FHA 3.5% Down Scenario:
- Year 1 subsidy = ($[A_FHA] − $[B_FHA]) × 12 = $[F_FHA]
- Year 2 subsidy = ($[A_FHA] − $[C_FHA]) × 12 = $[G_FHA]
- Estimated total = $[F_FHA + G_FHA]

Conventional 5% Down Scenario:
- Year 1 subsidy = ($[A_CONV] − $[B_CONV]) × 12 = $[F_CONV]
- Year 2 subsidy = ($[A_CONV] − $[C_CONV]) × 12 = $[G_CONV]
- Estimated total = $[F_CONV + G_CONV]

Important note: this is an estimated market-context buydown cost only. It is not a final seller concession, quote, approval, locked rate, or commitment to lend. The actual buydown cost depends on the agreed seller concession, lender pricing, and final terms.
```

## 11. Copy-Paste Image Generation Prompt (V4)

Before producing the prompt, the GPT must tell the loan officer:

> Upload the listing hero image before generating the final graphic. If you also want your headshot, the agent's headshot, or the agent's brokerage logo on the graphic, upload those too — they're optional.

Then the GPT outputs the copy-paste prompt below, with the bracketed placeholders dynamically substituted from the user-selected loan officer (resolved via `TEAM_ASSET_REFERENCE.md`) and the listing facts. Never hardcode any specific loan officer's name in this template.

```
COPY-PASTE IMAGE GENERATION PROMPT

Create a premium 1080 by 1350 vertical real estate mortgage marketing graphic using the uploaded listing hero image as the main property photo.

Use the uploaded listing photo. Do not replace the home with a fake AI generated property. Do not materially alter the home, yard, condition, setting, or view.

Style:
Luxury real estate flyer, clean black, white, orange, and silver Loan Factory inspired branding, modern mortgage strategy design, high contrast, premium but readable.

Main headline:
Seller Funded 2,1 Buydown Strategy

Subheadline:
Lower estimated payments in year 1 and year 2

Property details:
LISTING_ADDRESS
Listed at LISTING_PRICE
BEDROOMS beds
BATHROOMS baths
SQUARE_FEET sq ft

Buyer strategy section:
FHA 3.5 percent down option
Conventional 5 percent down option
Ask PUBLIC_FACING_LO_FIRST_NAME for a custom payment breakdown

Do not place exact interest rates, APR, or exact payment numbers on the image.

Public facing loan officer section:
PUBLIC_FACING_LO_NAME
NMLS PUBLIC_FACING_LO_NMLS
Loan Factory
Licensed in PUBLIC_FACING_LO_LICENSED_STATE
PUBLIC_FACING_LO_PHONE
PUBLIC_FACING_LO_EMAIL

Agent section:
AGENT_NAME
AGENT_BROKERAGE

Footer:
Loan Factory NMLS 320841
Equal Housing Lender
Draft marketing content for compliance review.

Required layout:
Loan Factory logo must be equal to or larger than loan officer name or team branding.
NMLS text must be the same size as the smallest text.
Equal Housing Lender logo must be visible.
Use the uploaded listing hero image as 50 to 60 percent of the design.
Use clean sections, large readable text, and a strong CTA.

Do not include:
Exact Mortgage News Daily rate
APR
Exact payment number
Guaranteed payment
Locked payment
Available now
You qualify for
No closing costs
Lowest rate
Best rate
Fake house image
```

## 12. Social Caption Template

```
Buyers — this seller may be able to help take the sting out of today's rates.

Seller-Funded 2/1 Buydown strategy available on this home. Two paths most buyers can consider:

• FHA 30-year fixed with 3.5% down — lower year 1 / year 2 estimated payments
• Conventional 30-year fixed with 5% down — lower year 1 / year 2 estimated payments

You'd qualify on the full note rate. The seller funds the year 1 and year 2 reduction. Real money you don't pay back.

[Address] — [short listing description]

DM me if you want to run real numbers on this home or any other home you're eyeing.

Estimated payment range based on average market rate data from Mortgage News Daily. Actual rate, APR, payment, and terms will vary based on credit, income, assets, occupancy, property details, and final underwriting. Not a quote, approval, or commitment to lend.

PUBLIC_FACING_LO_NAME, NMLS PUBLIC_FACING_LO_NMLS
Loan Factory | NMLS 320841 | Licensed in PUBLIC_FACING_LO_LICENSED_STATE | Equal Housing Lender
PUBLIC_FACING_LO_EMAIL
```

## 13. Agent Email Template

```
Subject: Quick way to make [listing address] more buyer-friendly

Hey [AGENT_FIRST_NAME],

Saw your listing at LISTING_ADDRESS and wanted to send you something practical.

If the seller's open to a small concession, we can structure a Seller-Funded 2/1 Buydown. I built two example payment scenarios on this listing:

• FHA 30-year fixed with 3.5% down
• Conventional 30-year fixed with 5% down

Both show lower year 1 and year 2 payments without changing the underlying 30-year fixed loan. The buyer still qualifies at the full note rate — it just opens the buyer pool to payment-sensitive folks.

The estimated seller-funded buydown cost based on current market-context rates is in the range I sent. The actual cost depends on the agreed concession and final lender pricing.

Want me to send the draft flyer + social post over for your review?

Estimated values are illustration only. Not a quote, not a commitment to lend.

PUBLIC_FACING_LO_NAME
PUBLIC_FACING_LO_EMAIL
PUBLIC_FACING_LO_PHONE
NMLS PUBLIC_FACING_LO_NMLS | Loan Factory NMLS 320841
Licensed in PUBLIC_FACING_LO_LICENSED_STATE | Equal Housing Lender
```

## 14. Agent Text

```
Hey [AGENT_FIRST_NAME] — for [short address], if the seller's open to a small concession we can structure a Seller-Funded 2/1 Buydown with both FHA 3.5% down and Conv 5% down example payments. Real year 1 / year 2 break for the buyer. Want me to send a draft co-branded flyer? — PUBLIC_FACING_LO_NAME, Loan Factory NMLS 320841
```

## 15. Agent DM

```
Hey [AGENT_FIRST_NAME] — your listing at LISTING_ADDRESS could fit a Seller-Funded 2/1 Buydown. I built example payments for both FHA 3.5% down and Conv 5% down. Mind if I send a draft co-branded flyer? — PUBLIC_FACING_LO_NAME, Loan Factory NMLS 320841
```

## 16. Compliance Checklist Additions for 2/1 Buydown

- [ ] Both FHA 3.5% and Conventional 5% scenarios shown side-by-side
- [ ] Buydown described as **seller-funded**
- [ ] Year 1 / Year 2 / Years 3-30 structure explained
- [ ] Estimated buydown cost computed (Year 1 + Year 2 subsidies) — not asked from LO
- [ ] When MND option (b) used: buydown cost labeled "estimated market-context buydown cost", never a final concession or quote
- [ ] Note rates labeled "LO-confirmed" or "MND market context" — never invented
- [ ] APR shown only if LO-provided; otherwise omitted with sample-scenario framing
- [ ] No exact rate or APR on the image
- [ ] Hero image upload requested before final graphic
- [ ] Agent license number not required (web-searched if practical, omitted if not found)
- [ ] Agent headshot / brokerage logo handled as optional
- [ ] Disclosure block pulled from `TEAM_ASSET_REFERENCE.md` for the selected public-facing LO
- [ ] State Licensing Handoff ran before any of the above

## 17. Final Approval Reminder

```
Draft marketing content for compliance review. Do not publish without approval.
Final reminder: this is a draft. Send to Loan Factory compliance for review before sending to the agent, posting publicly, printing, or filming.
```
