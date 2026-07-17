# Seller-Funded 2/1 Buydown Playbook

This playbook tells the Custom GPT how to draft a compliant Seller-Funded 2/1 Buydown campaign for a specific listing.

---

## 1. What This Campaign Is

A **2/1 buydown** temporarily reduces the buyer's interest rate by 2% in year one and 1% in year two before returning to the full note rate in year three. The buydown is funded by the **seller** as a closing-cost concession. The structure can help buyers ease into a home in a higher-rate environment without changing the underlying loan.

This campaign positions the buydown as a tool the **seller is offering** on this listing to attract qualified buyers.

## 2. When to Recommend This Campaign

- The seller has agreed (or is willing) to fund the buydown via concession.
- The buyer pool for the listing would benefit from a lower year-one payment.
- The listing has been on the market longer than market average or is in a price band where buyers are payment-sensitive.

## 3. Compliance Requirements Specific to This Campaign

In addition to all rules in `02_LOAN_FACTORY_MARKETING_COMPLIANCE_RULES.md`:

- Always state the buydown is **seller-funded** (or seller-paid).
- Always quote the **note rate** and the **effective year-one and year-two rates** if you quote any effective rate.
- Always state the **APR** at the same prominence as any quoted rate.
- Trigger terms almost always apply — include a **full sample scenario** in the asset.
- Do not promise the buydown without confirmation of the seller concession amount. If the concession is unconfirmed, treat the campaign as a hypothetical and label it as such.

### State Licensing Pre-Check (Mandatory)

Before drafting any 2/1 Buydown campaign output, confirm the selected loan officer is licensed in the property state.

If the selected LO is **not** licensed in the property state, run the **State Licensing Handoff Workflow** in `01_GPT_MASTER_INSTRUCTIONS.md` Section 14:

1. Flag the mismatch by name and state.
2. Check the roster in `03_TEAM_ROSTER_AND_DISCLOSURES.md` for licensed teammates in that state.
3. List the licensed teammates.
4. Ask the user which licensed teammate to attach to the campaign as the public-facing LO.
5. Allow the originally requested LO (e.g., Jeremy) to remain in the background only as team lead, strategy support, or internal reviewer.
6. Do not produce public promotional 2/1 Buydown copy under an unlicensed LO for that state.
7. If no licensed teammate exists, fall back to education-only or internal strategy content only.

**Preferred response pattern when triggered:**

> Jeremy is not licensed in GA, so I cannot create promotional Georgia mortgage copy under Jeremy. The roster shows Barbara Jordan and Bryan Payne are licensed in GA. Choose one of them and I can build the campaign under that licensed LO, with Jeremy staying in the background as team lead or strategy support.

Do not say only "I can't create this." Always pair the refusal with the roster lookup and the handoff offer.

### MND Market-Rate Context (Payment Range for This Campaign)

When the loan officer wants a market-context payment range for this 2/1 Buydown campaign instead of (or alongside) a confirmed LO rate + APR, use **Mortgage News Daily** as described in `MND_RATE_CONTEXT_COMPLIANCE_RULES.md` and `01_GPT_MASTER_INSTRUCTIONS.md` §15. Key points specific to 2/1 Buydowns:

- The MND page depends on the underlying loan type: Conventional → `/30-year-fixed`; FHA → `/30-year-fha`; VA → `/30-year-va`; Jumbo → `/30-year-jumbo`.
- Apply the default spread (MND rate − 0.25% to MND rate + 0.50%) to compute the P&I range.
- A 2/1 Buydown is typically advertised by structure ("Year 1: payment break, Year 2: still below note rate, Years 3-30: full 30-yr fixed at note rate"). The MND-based payment range is for the **note rate**, not the temporary year-1 or year-2 effective rate. Do not advertise an effective year-1 payment from MND data.
- **Image rule:** never put the MND rate or any APR on the image. Use allowed phrases like "Estimated payment range available" or "Seller-paid buydown strategy available."
- **Caption rule:** may attribute the payment range to MND but must never imply Loan Factory is offering that rate.
- If the loan officer wants to publish the note rate AND effective Year 1 / Year 2 rates, that path requires LO-provided rate + APR (option a), not MND.

## 4. Inputs Required (Beyond Standard Listing Intake)

- Note rate (full 30-year fixed rate)
- APR matching the note rate
- Seller-paid concession amount (or confirmation of structure)
- Loan amount (or down payment % so it can be computed)
- Term (default 30-year fixed)
- Loan program (Conv, FHA, VA, USDA, Non-QM)
- Property tax (annual or monthly) from listing or county
- Insurance estimate (or approved $120/mo placeholder)
- HOA if applicable

If any are missing, list them under Missing Inputs and refuse rate-based public copy until provided.

## 5. Default Output: Quick Campaign Summary

Format the summary like this:

```
Campaign: Seller-Funded 2/1 Buydown
Listing: [address] — [price]
Buyer angle: lower year-one payment, full 30-year fixed underwriting, seller-paid concession structure.
Loan officer: [name], NMLS [#]
State: [property state] — coverage confirmed.
Best Price Guarantee: [included | not included | omitted due to WA]
```

## 6. Default Output: Image Prompt

```
Create a 1080x1350 vertical co-branded real estate flyer.

Headline: "Seller-Funded 2/1 Buydown Available on this Home"

Sub-headline: "Lower payment in year one. Full 30-year fixed underwriting."

Layout:
- Top-left: {LOAN_FACTORY_LOGO}
- Top-right: {LEGENDS_TEAM_LOGO} (smaller)
- Hero: {LISTING_HERO_IMAGE} (60% of canvas, no rate overlay)
- Mid-band: address and listed price [confirmed from listing]
- Lower-mid: short buydown explainer ("Year 1: [year_1_rate]% effective rate | Year 2: [year_2_rate]% effective rate | Years 3-30: [note_rate]% note rate")
- Loan officer block (right column): {HEADSHOT_<LOAN_OFFICER>} | [Loan officer name] | NMLS [#] | [licensed state(s)] | [company phone] | [company email]
- Agent block (left column): {AGENT_HEADSHOT} | {AGENT_NAME} | {AGENT_BROKERAGE} | {AGENT_LICENSE} (placeholders if not confirmed)
- Footer: {EHL_LOGO} on left, "Loan Factory NMLS 320841 | Licensed in [state(s)] | Equal Housing Lender" centered
- Bottom strip: "Rate [note_rate]% | APR [apr]% — Sample scenario shown for illustration only. Not a commitment to lend." (font style, size, and prominence equal to any rate shown above)
- If Best Price Guarantee is included: add "Terms and Conditions: https://www.loanfactory.com/best-price-guarantee"

Sizing rules:
- Loan Factory name/logo size ≥ loan officer name/domain.
- NMLS text = smallest text on the asset.
- Interest rate and APR matched in font style, size, prominence.

Do not invent logos, headshots, license numbers, agent names, brokerage names, rates, APR, or seller credit amounts.
```

## 7. Default Output: Social Caption

```
Buyers — this seller is helping take the sting out of today's rates.

Seller-Funded 2/1 Buydown available on this home. Here's the gist:
• Year 1: a meaningful payment break
• Year 2: still below note rate
• Years 3-30: full 30-year fixed underwriting at the note rate

You qualify on the full note rate. The seller funds the year 1 and year 2 reduction. Real money you don't pay back.

Listed at [price] — [short listing description].

DM me if you want to run real numbers on this home or any other home you're eyeing.

Rate [note_rate]% | APR [apr]%
Sample scenario shown for illustration. Subject to underwriting approval. Not a commitment to lend.

[Loan officer name], NMLS [#]
Loan Factory | NMLS 320841 | Licensed in [state(s)] | Equal Housing Lender
[Loan officer @loanfactory.com email]

[If Best Price Guarantee included and not WA]
$2,000 Best Price Guarantee — Terms and Conditions: https://www.loanfactory.com/best-price-guarantee
```

## 8. Default Output: Agent Email

```
Subject: Quick way to make [listing address] more buyer-friendly

Hey [agent first name],

Saw your listing at [listing address] and wanted to send you something practical.

If the seller's open to a small concession, we can structure a Seller-Funded 2/1 Buydown for the buyer. That lowers their year 1 and year 2 payment without changing the underlying 30-year fixed loan. Buyer still qualifies on the full note rate, so it doesn't change underwriting in a bad way — it just opens up a wider buyer pool that's payment-sensitive right now.

I put together a draft co-branded flyer and social post for the listing so you can see how it would look. Want me to send it over for your review?

This is education-only; nothing here is a commitment to lend, and every buyer's scenario gets quoted off real numbers.

Talk soon,
[Loan officer name]
[Loan officer @loanfactory.com email]
[Company phone]
NMLS [loan officer NMLS] | Loan Factory NMLS 320841
Licensed in [state(s)] | Equal Housing Lender
```

## 9. Default Output: Agent Text

```
Hey [agent first name] — saw your listing at [short address]. If your seller's open to a small concession, I can structure a Seller-Funded 2/1 Buydown that gives the buyer a real year-1 / year-2 payment break without changing the underlying 30-yr fixed underwriting. Mind if I send a draft co-branded flyer for the listing? — [Loan officer name], Loan Factory NMLS 320841
```

## 10. Default Output: Agent DM (Social)

```
Hey [agent first name] — your listing at [listing address] caught my eye. Quick idea: Seller-Funded 2/1 Buydown. Seller funds a year-1 / year-2 payment break for the buyer. Same 30-yr fixed, wider buyer pool. Want me to send a draft co-branded flyer? — [Loan officer name], Loan Factory NMLS 320841
```

## 11. Default Output: Compliance Checklist

Use the standard checklist from `13_COMPLIANCE_QA_CHECKLIST.md` plus these specifics:

- [ ] Note rate stated with matching APR
- [ ] Year 1 / Year 2 / Years 3-30 structure explained
- [ ] Seller-funded nature stated explicitly
- [ ] Sample scenario included (purchase price, loan amount, term, rate, APR, P&I, taxes, insurance assumption, HOA if any, seller credit)
- [ ] Insurance source labeled ($120/mo placeholder if approved, otherwise real estimate)
- [ ] EHL logo present in image
- [ ] NMLS text = smallest text in image
- [ ] Loan Factory ≥ loan officer name in image
- [ ] Best Price Guarantee terms link present IF offer is included AND asset is not for WA
- [ ] No unsupported claims
- [ ] No referral exchange language

## 12. Final Approval Reminder

```
Draft marketing content for compliance review. Do not publish without approval.
Final reminder: this is a draft. Send to Loan Factory compliance for review before sending to the agent, posting publicly, printing, or filming.
```
