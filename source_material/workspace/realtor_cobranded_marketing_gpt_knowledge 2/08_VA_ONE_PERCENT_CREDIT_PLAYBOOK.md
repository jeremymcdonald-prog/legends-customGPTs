# VA Buyer Campaign with 1% Closing Cost Credit Playbook

This playbook tells the Custom GPT how to draft a compliant VA Buyer campaign with a **1% Closing Cost Credit** for a specific listing.

---

## 1. What This Campaign Is

A campaign aimed at **eligible VA borrowers** — active-duty service members, veterans, and qualifying surviving spouses — pairing the VA loan structure with a **1% Closing Cost Credit** funded by Loan Factory or the loan officer's marketing budget where approved.

The 1% credit is calculated against the loan amount and applied at closing toward the buyer's closing costs.

## 2. Compliance Requirements Specific to This Campaign

In addition to all rules in `02_LOAN_FACTORY_MARKETING_COMPLIANCE_RULES.md`:

- Make clear the credit is for **eligible VA borrowers**.
- State the credit is **1% of the loan amount, applied toward closing costs at closing**, and credit cannot exceed actual closing costs.
- Do not describe the property itself as "VA approved." Property eligibility is determined through appraisal.
- Do not imply the credit can be combined with other unsupported claims.
- The 1% credit is not a discount on price or principal — it is a closing cost credit. Be precise.
- Include the standard sample scenario if any trigger term appears.
- Include APR with any quoted rate, matched in font style, size, and prominence.

### State Licensing Pre-Check (Mandatory)

Before drafting any VA 1% Closing Cost Credit campaign output, confirm the selected loan officer is licensed in the property state.

If the selected LO is **not** licensed in the property state, run the **State Licensing Handoff Workflow** in `01_GPT_MASTER_INSTRUCTIONS.md` Section 14:

1. Flag the mismatch by name and state.
2. Check the roster in `03_TEAM_ROSTER_AND_DISCLOSURES.md` for licensed teammates in that state.
3. List the licensed teammates.
4. Ask the user which licensed teammate to attach to the campaign as the public-facing LO.
5. Allow the originally requested LO (e.g., Jeremy) to remain in the background only as team lead, strategy support, or internal reviewer.
6. Do not produce public promotional VA campaign copy under an unlicensed LO for that state.
7. If no licensed teammate exists, fall back to education-only or internal strategy content only.

**Preferred response pattern when triggered:**

> Jeremy is not licensed in GA, so I cannot create promotional Georgia mortgage copy under Jeremy. The roster shows Barbara Jordan and Bryan Payne are licensed in GA. Choose one of them and I can build the campaign under that licensed LO, with Jeremy staying in the background as team lead or strategy support.

Do not say only "I can't create this." Always pair the refusal with the roster lookup and the handoff offer.

## 3. Inputs Required (Beyond Standard Listing Intake)

- Estimated loan amount (typically listing price for VA buyers with full entitlement and no down payment)
- VA loan rate and APR (if quoted)
- Funding fee assumption (note that funding fee can be financed; exempt veterans pay none)
- Property taxes (from listing or county)
- Insurance estimate (or approved $120/mo placeholder)
- HOA if applicable
- Whether the 1% credit is structured on this campaign or a standing team offer

## 4. Default Output: Quick Campaign Summary

```
Campaign: VA Buyer with 1% Closing Cost Credit
Listing: [address] — [price]
Buyer audience: eligible VA borrowers (active-duty, veterans, qualifying surviving spouses)
Credit: 1% of loan amount, applied at closing toward closing costs (cannot exceed actual closing costs)
Loan officer: [name], NMLS [#]
State: [property state] — coverage confirmed.
Best Price Guarantee: [included | not included | omitted due to WA]
```

## 5. Default Output: Image Prompt

```
Create a 1080x1350 vertical co-branded real estate flyer.

Headline: "VA Buyers — 1% Closing Cost Credit on This Home"

Sub-headline: "For eligible VA borrowers. Credit applied at closing toward closing costs."

Layout:
- Top-left: {LOAN_FACTORY_LOGO}
- Top-right: {LEGENDS_TEAM_LOGO} (smaller)
- Hero: {LISTING_HERO_IMAGE} (60% of canvas)
- Mid: address and listed price
- Lower-mid: 3-bullet VA angle
  • $0 down for eligible buyers using full VA entitlement
  • Competitive VA fixed-rate options
  • 1% closing cost credit from Loan Factory at closing
- Loan officer block (right column): {HEADSHOT_<LOAN_OFFICER>} | [Name] | NMLS [#] | [licensed state(s)] | [phone] | [email]
- Agent block (left column): {AGENT_HEADSHOT} | {AGENT_NAME} | {AGENT_BROKERAGE} | {AGENT_LICENSE} (placeholders if not confirmed)
- Footer: {EHL_LOGO}, "Loan Factory NMLS 320841 | Licensed in [state(s)] | Equal Housing Lender"
- If rate is shown: "Rate [rate]% | APR [apr]% — Sample scenario shown for illustration only. Eligibility subject to VA guidelines and underwriting. Not a commitment to lend." (font style, size, prominence matched to rate)
- If Best Price Guarantee included: "Terms and Conditions: https://www.loanfactory.com/best-price-guarantee"
- Disclosure line near offer: "1% credit calculated against loan amount, applied at closing toward buyer's closing costs. Credit cannot exceed actual closing costs."

Sizing rules:
- Loan Factory name/logo size ≥ loan officer name/domain.
- NMLS text = smallest text on asset.
- Rate and APR matched in font, size, prominence.

Do not invent logos, headshots, license numbers, agent names, brokerage names, rates, APR, or credit amounts.
```

## 6. Default Output: Social Caption

```
To the veterans, active-duty service members, and qualifying spouses house-hunting right now — this one's for you.

VA buyers using their entitlement on this listing can stack:
• $0 down (for eligible borrowers with full entitlement)
• Competitive VA fixed-rate options
• 1% Closing Cost Credit from Loan Factory at closing (credit applied toward your closing costs; cannot exceed actual closing costs)

The VA loan is one of the strongest tools in the country. If you've earned it, you should know exactly how it works on a real home like this one.

[Address] — [short listing description]

DM or message me and I'll run a real VA scenario on this home or any other.

[If rate shown] Rate [rate]% | APR [apr]%
Sample scenario shown for illustration. Eligibility subject to VA guidelines and underwriting. Not a commitment to lend.

[Loan officer name], NMLS [#]
Loan Factory | NMLS 320841 | Licensed in [state(s)] | Equal Housing Lender
[Loan officer @loanfactory.com email]

[If Best Price Guarantee included and not WA]
$2,000 Best Price Guarantee — Terms and Conditions: https://www.loanfactory.com/best-price-guarantee
```

## 7. Default Output: Agent Email

```
Subject: VA buyer angle on [listing address] — 1% closing credit

Hey [agent first name],

For your listing at [listing address], wanted to share a VA-specific angle that's worked well for us:

For eligible VA borrowers, we can stack the standard VA structure ($0 down for full entitlement, VA fixed rates) with a **1% Closing Cost Credit** from Loan Factory at closing. The credit applies toward the buyer's closing costs and can't exceed actual closing costs — but it's real money that helps the buyer come to the table.

If your listing is appealing to veterans, military, or surviving spouses, this combo can move the needle. Happy to put together a draft co-branded flyer and social for the listing if you want.

[Loan officer name]
[Loan officer @loanfactory.com email]
[Company phone]
NMLS [loan officer NMLS] | Loan Factory NMLS 320841
Licensed in [state(s)] | Equal Housing Lender
```

## 8. Default Output: Agent Text

```
Hey [agent first name] — for [short address], thinking VA buyer angle: $0 down for eligible VA buyers + 1% Closing Cost Credit from Loan Factory at closing. Want me to send a draft co-branded flyer? — [Loan officer name], Loan Factory NMLS 320841
```

## 9. Default Output: Agent DM

```
Hey [agent first name] — your listing at [listing address] could line up with a VA buyer push: $0 down for eligible VA + 1% Closing Cost Credit from us. Mind if I send a draft co-branded flyer? — [Loan officer name], Loan Factory NMLS 320841
```

## 10. Compliance Checklist Additions

- [ ] "Eligible VA borrowers" language present
- [ ] 1% credit described accurately (loan amount, at closing, toward closing costs, cannot exceed actual closing costs)
- [ ] No claim that the property itself is "VA approved"
- [ ] If rate shown: APR matched
- [ ] Sample scenario included if any trigger term shown
- [ ] Best Price Guarantee terms link present IF included AND not WA
- [ ] No combined-claim language that implies stacking with unsupported guarantees
- [ ] EHL logo, NMLS, Loan Factory disclosure block all present

## 11. Final Approval Reminder

```
Draft marketing content for compliance review. Do not publish without approval.
Final reminder: this is a draft. Send to Loan Factory compliance for review before sending to the agent, posting publicly, printing, or filming.
```
