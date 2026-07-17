# General Listing Marketing Campaign Playbook

This playbook tells the Custom GPT how to draft a compliant general co-branded marketing campaign for a specific listing **without** anchoring to a specific named offer (no 2/1 buydown, no 100% + DPA, no VA 1% credit). This is the default "just help me market the listing with the agent" pack.

---

## 1. What This Campaign Is

A clean, consumer-friendly co-branded asset pack that helps the agent's listing get visibility and drives qualified buyer conversations to both the agent and the Loan Factory loan officer. The angle is **education + property value + buyer enablement**, not a specific offer.

This campaign is the safest fallback when:

- The seller hasn't agreed to a concession or buydown
- The audience and structure aren't yet known
- The loan officer just wants a co-branded asset pack for any active listing

## 2. Compliance Requirements Specific to This Campaign

In addition to all rules in `02_LOAN_FACTORY_MARKETING_COMPLIANCE_RULES.md`:

- If no rate is shown, no APR is needed.
- If a generic "rates available" reference is made, do not include a number unless rate and APR are confirmed.
- Do not stack hypothetical offers without explicit loan officer confirmation.
- Keep the asset focused on the home and the consumer-friendly path to ownership.
- The same referral-exchange and RESPA-awareness rules apply.

### State Licensing Pre-Check (Mandatory)

Before drafting any General Listing Marketing campaign output, confirm the selected loan officer is licensed in the property state.

If the selected LO is **not** licensed in the property state, run the **State Licensing Handoff Workflow** in `01_GPT_MASTER_INSTRUCTIONS.md` Section 14:

1. Flag the mismatch by name and state.
2. Check the roster in `03_TEAM_ROSTER_AND_DISCLOSURES.md` for licensed teammates in that state.
3. List the licensed teammates.
4. Ask the user which licensed teammate to attach to the campaign as the public-facing LO.
5. Allow the originally requested LO (e.g., Jeremy) to remain in the background only as team lead, strategy support, or internal reviewer.
6. Do not produce public promotional general listing copy under an unlicensed LO for that state.
7. If no licensed teammate exists, fall back to education-only or internal strategy content only.

**Preferred response pattern when triggered:**

> Jeremy is not licensed in GA, so I cannot create promotional Georgia mortgage copy under Jeremy. The roster shows Barbara Jordan and Bryan Payne are licensed in GA. Choose one of them and I can build the campaign under that licensed LO, with Jeremy staying in the background as team lead or strategy support.

Do not say only "I can't create this." Always pair the refusal with the roster lookup and the handoff offer.

### MND Market-Rate Context (Payment Range for This Campaign)

A general listing campaign typically does not anchor to a specific loan program offer. When the loan officer wants to include a market-context payment range, use **Mortgage News Daily** with these defaults:

- Default to the Conventional 30-year fixed page: `https://www.mortgagenewsdaily.com/mortgage-rates/30-year-fixed`.
- Label it "general conventional baseline" in the assumptions block.
- Apply the default spread (MND rate − 0.25% to MND rate + 0.50%) to compute the P&I range.
- If the listing is more likely to attract FHA, VA, or Jumbo buyers, the LO may swap to the matching MND page and the GPT updates the source URL accordingly.
- **Image rule:** never put the MND rate or any APR on the image. Use the safest framing: "Estimated payment range available — ask me for a custom payment breakdown."
- **Caption rule:** may attribute the payment range to MND but must never imply Loan Factory is offering that rate. Keep the focus on "the home + the loan side + the buyer + pre-approval before tour."

If the loan officer prefers no rate context at all (option c), the general listing campaign works perfectly fine rate-free.

## 3. Inputs Required (Beyond Standard Listing Intake)

- Listing details (price, address, beds, baths, sqft, description, hero image)
- Agent name, brokerage, headshot, license — confirmed
- Loan officer roster details
- Output formats wanted

No rate or APR is required unless the loan officer wants a rate quote in this asset.

## 4. Default Output: Quick Campaign Summary

```
Campaign: General Listing Marketing
Listing: [address] — [price]
Angle: co-branded education + property highlight. Pre-approval invitation. No specific offer.
Loan officer: [name], NMLS [#]
State: [property state] — coverage confirmed.
Best Price Guarantee: [included | not included | omitted due to WA]
```

## 5. Default Output: Image Prompt

```
Create a 1080x1350 vertical co-branded real estate flyer.

Headline: "[Bedroom_count] BR / [Bathroom_count] BA in [City/Neighborhood] — [Price]"

Sub-headline: "[Short hook from listing description]"

Layout:
- Top-left: {LOAN_FACTORY_LOGO}
- Top-right: {LEGENDS_TEAM_LOGO} (smaller)
- Hero: {LISTING_HERO_IMAGE} (60% of canvas)
- Mid: address, price, key specs (beds, baths, sqft)
- Lower-mid: 3-bullet listing highlight (pulled from listing description, no inventions)
- Agent block (left column): {AGENT_HEADSHOT} | {AGENT_NAME} | {AGENT_BROKERAGE} | {AGENT_LICENSE} (placeholders if not confirmed)
- Loan officer block (right column): {HEADSHOT_<LOAN_OFFICER>} | [Name] | NMLS [#] | [licensed state(s)] | [phone] | [email]
- Call-to-action band: "Talk to [agent first name] about the home. Talk to [loan officer first name] about the loan."
- Footer: {EHL_LOGO}, "Loan Factory NMLS 320841 | Licensed in [state(s)] | Equal Housing Lender"
- If Best Price Guarantee included AND not WA: "Terms and Conditions: https://www.loanfactory.com/best-price-guarantee"

Sizing rules:
- Loan Factory name/logo size ≥ loan officer name/domain.
- NMLS text = smallest text on asset.

Do not invent logos, headshots, license numbers, agent names, brokerage names, rates, APR, seller credits, or program terms.
```

## 6. Default Output: Social Caption

```
New listing worth a real look — [bedroom_count] BR / [bathroom_count] BA in [city/neighborhood], listed at [price].

A few things buyers should know:
• [Highlight 1 from listing]
• [Highlight 2 from listing]
• [Highlight 3 from listing]

[Agent first name] handles the listing. I handle the loan side. If you're house-hunting in [city/area], it's worth getting your pre-approval squared away before you walk through.

DM me to start a real pre-approval, or call [agent first name] to see this home.

[Loan officer name], NMLS [#]
Loan Factory | NMLS 320841 | Licensed in [state(s)] | Equal Housing Lender
[Loan officer @loanfactory.com email]

[If Best Price Guarantee included and not WA]
$2,000 Best Price Guarantee — Terms and Conditions: https://www.loanfactory.com/best-price-guarantee
```

## 7. Default Output: Agent Email

```
Subject: Co-branded flyer + social for [listing address]

Hey [agent first name],

I put together a draft co-branded flyer and social post for your listing at [listing address]. No rate flyer — just a clean, consumer-friendly piece that puts your listing in front of buyers and reminds them that getting pre-approved before they fall in love with a home matters.

Quick split:
• You handle the listing
• I handle the loan side
• The buyer wins because nobody's running around half-prepared

Want me to send the drafts over for your review? If you want me to swap in a more specific buyer angle (VA, 100% financing, 2/1 buydown), I can spin that variant too.

[Loan officer name]
[Loan officer @loanfactory.com email]
[Company phone]
NMLS [loan officer NMLS] | Loan Factory NMLS 320841
Licensed in [state(s)] | Equal Housing Lender
```

## 8. Default Output: Agent Text

```
Hey [agent first name] — drafted a co-branded flyer + social for your listing at [short address]. No rate flyer, just clean and consumer-friendly. Want me to send for your review? — [Loan officer name], Loan Factory NMLS 320841
```

## 9. Default Output: Agent DM

```
Hey [agent first name] — your listing at [listing address] caught my eye. I put together a co-branded flyer and social post for it. Want me to send a draft for your review? — [Loan officer name], Loan Factory NMLS 320841
```

## 10. Compliance Checklist Additions

- [ ] Listing details accurate to source
- [ ] No invented agent assets
- [ ] No rate or APR unless both confirmed
- [ ] Co-branded language educational, not referral-exchange
- [ ] EHL logo, NMLS, Loan Factory block all present
- [ ] Best Price Guarantee terms link present IF included AND not WA

## 11. Final Approval Reminder

```
Draft marketing content for compliance review. Do not publish without approval.
Final reminder: this is a draft. Send to Loan Factory compliance for review before sending to the agent, posting publicly, printing, or filming.
```
