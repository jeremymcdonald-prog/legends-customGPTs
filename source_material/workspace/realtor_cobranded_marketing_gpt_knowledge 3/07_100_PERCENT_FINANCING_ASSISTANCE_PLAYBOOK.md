# 100% Financing with Assistance Playbook

This playbook tells the Custom GPT how to draft a compliant 100% Financing with Assistance campaign for a specific listing.

---

## 1. What This Campaign Is

A buyer-side campaign positioning that the buyer can get into the home with **0% down out of pocket** using a combination of program-specific 100% financing structures and/or assistance funds. Examples:

- **USDA** (in eligible rural areas) — 100% LTV with no down payment.
- **VA** — 100% LTV with no down payment for eligible borrowers.
- **Conventional 100% with DPA** — a first-lien conventional loan combined with a Down Payment Assistance program covering the down payment.
- **Seller-funded concession** covering closing costs alongside a 100% structure.

The structure varies by buyer eligibility, program availability, and market. The GPT must not lump these together as if they're interchangeable.

## 2. Compliance Requirements Specific to This Campaign

In addition to all rules in `02_LOAN_FACTORY_MARKETING_COMPLIANCE_RULES.md`:

- Be precise about the **source** of the 100% (USDA, VA, or 1st + DPA combo). Do not claim "100% financing with assistance" generically without naming the actual structure.
- Do not say "no money out of pocket." Buyers will still have earnest money, inspection, and prepaids in most scenarios.
- Eligibility is program-specific. Always state eligibility is subject to underwriting and program guidelines.
- If a rate or APR is shown, both must be present at matching prominence.
- Always include sample scenario if payment, down payment, or any trigger term appears.
- Do not promise the buyer "free money." DPA programs may be grants, soft seconds, forgivable loans, or repayable seconds — call out the structure of any specific program named.

### State Licensing Pre-Check (Mandatory)

Before drafting any 100% Financing with Assistance campaign output, confirm the selected loan officer is licensed in the property state.

If the selected LO is **not** licensed in the property state, run the **State Licensing Handoff Workflow** in `01_GPT_MASTER_INSTRUCTIONS.md` Section 14:

1. Flag the mismatch by name and state.
2. Check the roster in `03_TEAM_ROSTER_AND_DISCLOSURES.md` for licensed teammates in that state.
3. List the licensed teammates.
4. Ask the user which licensed teammate to attach to the campaign as the public-facing LO.
5. Allow the originally requested LO (e.g., Jeremy) to remain in the background only as team lead, strategy support, or internal reviewer.
6. Do not produce public promotional 100% Financing copy under an unlicensed LO for that state.
7. If no licensed teammate exists, fall back to education-only or internal strategy content only.

**Preferred response pattern when triggered:**

> Jeremy is not licensed in GA, so I cannot create promotional Georgia mortgage copy under Jeremy. The roster shows Barbara Jordan and Bryan Payne are licensed in GA. Choose one of them and I can build the campaign under that licensed LO, with Jeremy staying in the background as team lead or strategy support.

Do not say only "I can't create this." Always pair the refusal with the roster lookup and the handoff offer.

### MND Market-Rate Context (Payment Range for This Campaign)

When the loan officer wants a market-context payment range for this 100% Financing + Assistance campaign instead of (or alongside) a confirmed LO rate + APR, use **Mortgage News Daily** as described in `MND_RATE_CONTEXT_COMPLIANCE_RULES.md` and `01_GPT_MASTER_INSTRUCTIONS.md` §15. Key points specific to 100% Financing:

- MND page depends on the underlying loan type: USDA → `/30-year-fixed` (general conventional baseline; flag the fallback); VA → `/30-year-va`; Conventional 1st + DPA → `/30-year-fixed`; FHA → `/30-year-fha`.
- When the down payment is $0, the loan amount equals the purchase price for the rate-context calculation.
- Apply the default spread (MND rate − 0.25% to MND rate + 0.50%) to compute the P&I range.
- The payment range is for the **first lien** rate. If a DPA second has its own payment, only include it when the LO confirms the DPA program structure and payment.
- **Image rule:** never put the MND rate or any APR on the image. Use allowed phrases like "Estimated payment range available" or "Payment strategy example available."
- **Caption rule:** may attribute the payment range to MND but must never imply Loan Factory is offering that rate. Always mention eligibility ("for eligible buyers") and that the buyer still covers earnest money, inspection, and prepaids in most cases.

## 3. Inputs Required (Beyond Standard Listing Intake)

- Specific 100% structure to highlight (USDA, VA, Conv 1st + DPA, etc.)
- DPA program name if applicable
- Estimated loan amount (or use listing price as proxy)
- Interest rate and APR if quoted
- Sample scenario inputs (taxes, insurance, HOA if any)
- Buyer income assumption if a DPA program has an income cap (or note that program eligibility will be confirmed at application)

## 4. Default Output: Quick Campaign Summary

```
Campaign: 100% Financing with Assistance
Listing: [address] — [price]
Structure to highlight: [USDA | VA | Conv 1st + DPA name | seller-paid closing costs + 100% LTV]
Buyer angle: get into the home with no down payment from the buyer's own funds.
Loan officer: [name], NMLS [#]
State: [property state] — coverage confirmed.
Best Price Guarantee: [included | not included | omitted due to WA]
```

## 5. Default Output: Image Prompt

```
Create a 1080x1350 vertical co-branded real estate flyer.

Headline: "100% Financing with Assistance — Could This Be the Buyer's Way In?"

Sub-headline: "[USDA | VA | Conventional + DPA program] — 0% down out of pocket may be possible for eligible buyers."

Layout:
- Top-left: {LOAN_FACTORY_LOGO}
- Top-right: {LEGENDS_TEAM_LOGO} (smaller)
- Hero: {LISTING_HERO_IMAGE} (60% of canvas, no rate overlay)
- Mid: address and listed price
- Lower-mid: 3-bullet structure summary
  • [Structure name] — what it is
  • What the buyer covers (earnest money, inspection, prepaids)
  • What the assistance covers (down payment, closing costs, or both)
- Loan officer block (right column): {HEADSHOT_<LOAN_OFFICER>} | [Name] | NMLS [#] | [licensed state(s)] | [phone] | [email]
- Agent block (left column): {AGENT_HEADSHOT} | {AGENT_NAME} | {AGENT_BROKERAGE} | {AGENT_LICENSE} (placeholders if not confirmed)
- Footer: {EHL_LOGO}, "Loan Factory NMLS 320841 | Licensed in [state(s)] | Equal Housing Lender"
- If rate is shown: "Rate [rate]% | APR [apr]% — Sample scenario shown for illustration only. Eligibility subject to underwriting and program guidelines. Not a commitment to lend." (font style, size, prominence matched to rate)
- If Best Price Guarantee included: "Terms and Conditions: https://www.loanfactory.com/best-price-guarantee"

Sizing rules:
- Loan Factory name/logo size ≥ loan officer name/domain.
- NMLS text = smallest text on asset.
- Rate and APR matched in font, size, prominence.

Do not invent logos, headshots, license numbers, agent names, brokerage names, rates, APR, DPA program names, or program terms.
```

## 6. Default Output: Social Caption

```
Buyer worried that they can't bring a down payment to the table? There may be a path.

100% Financing with Assistance — that's the headline. The details depend on the buyer:

• [USDA / VA / Conventional 1st + DPA] structures may let an eligible buyer skip the traditional down payment.
• Buyer still covers earnest money, inspection, and prepaids in most cases — there's no such thing as $0 to the table, but it can be way less than 3-20% down.
• Eligibility is real and gets checked. Income caps, property location, service eligibility, credit — all of it.

If you've been sitting out the market because of the down payment number, ping me. I'll run your real options against this listing or any other.

[If rate shown] Rate [rate]% | APR [apr]%
[Always] Sample scenario shown for illustration. Eligibility subject to underwriting and program guidelines. Not a commitment to lend.

[Loan officer name], NMLS [#]
Loan Factory | NMLS 320841 | Licensed in [state(s)] | Equal Housing Lender
[Loan officer @loanfactory.com email]

[If Best Price Guarantee included and not WA]
$2,000 Best Price Guarantee — Terms and Conditions: https://www.loanfactory.com/best-price-guarantee
```

## 7. Default Output: Agent Email

```
Subject: 100% Financing path for buyers on [listing address]

Hey [agent first name],

Quick one on your listing at [listing address]. There are a few 100% financing structures we run a lot right now that might widen the buyer pool for this home:

• [USDA / VA / Conventional + DPA] — depending on the buyer's profile, the down payment can be covered by the structure or assistance, not the buyer's checking account.
• The buyer still brings earnest money, inspection, and prepaids in most scenarios — full transparency.
• Eligibility is buyer-specific and gets verified before anything goes into writing.

If you want, I can put together a co-branded flyer and short social for your listing that highlights this angle for buyers who are sitting on the sidelines because of the down payment number. Want me to send the draft over?

[Loan officer name]
[Loan officer @loanfactory.com email]
[Company phone]
NMLS [loan officer NMLS] | Loan Factory NMLS 320841
Licensed in [state(s)] | Equal Housing Lender
```

## 8. Default Output: Agent Text

```
Hey [agent first name] — for [short address], could pitch buyers a 100% financing + assistance angle ([USDA / VA / Conv + DPA] depending on buyer). Widens the pool. Want me to send a draft co-branded flyer? — [Loan officer name], Loan Factory NMLS 320841
```

## 9. Default Output: Agent DM

```
Hey [agent first name] — your listing at [listing address] could line up with a 100% Financing + Assistance angle for the right buyer ([USDA / VA / Conv + DPA]). Mind if I send a draft co-branded flyer? — [Loan officer name], Loan Factory NMLS 320841
```

## 10. Compliance Checklist Additions

In addition to the standard checklist:

- [ ] Specific structure named (USDA, VA, Conv + DPA program name, etc.) — no generic "100% with assistance"
- [ ] Buyer's actual out-of-pocket items acknowledged (earnest, inspection, prepaids)
- [ ] Eligibility caveat present
- [ ] If rate shown: APR matched
- [ ] Sample scenario included if any trigger term shown
- [ ] Best Price Guarantee terms link present IF included AND not WA
- [ ] No "free money" or "no money out of pocket" language
- [ ] EHL logo, NMLS, Loan Factory disclosure block all present

## 11. Final Approval Reminder

```
Draft marketing content for compliance review. Do not publish without approval.
Final reminder: this is a draft. Send to Loan Factory compliance for review before sending to the agent, posting publicly, printing, or filming.
```
