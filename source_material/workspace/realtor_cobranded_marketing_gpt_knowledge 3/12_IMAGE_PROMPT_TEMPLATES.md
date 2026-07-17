# Image Prompt Templates

The GPT does **not** generate finished compliant artwork. It generates **prompts** that a designer or an image-generation tool will use. Every prompt must use the placeholder tokens from `04_TEAM_ASSET_INDEX.md` and explicitly call out the sizing and disclosure rules.

---

## 1. Universal Image Compliance Header (paste at the top of every image prompt)

```
COMPLIANCE NOTES (do not skip):
- Loan Factory name/logo must be ≥ size of loan officer's name or personal domain.
- NMLS text must equal the smallest text size on the asset.
- Equal Housing Lender logo must appear visibly.
- If a rate is shown, APR must appear at matching font style, size, and prominence.
- Do not invent logos, headshots, license numbers, agent names, brokerage names, rates, APR, or seller credit amounts.
- For WA listings or audiences: omit $2,000 Best Price Guarantee entirely.
- For all other states: if $2,000 Best Price Guarantee is shown, include "Terms and Conditions: https://www.loanfactory.com/best-price-guarantee" on the asset.
```

---

## 2. Vertical Social Flyer (1080x1350) — Skeleton

Use this for Instagram feed, Facebook portrait, LinkedIn portrait.

```
[UNIVERSAL IMAGE COMPLIANCE HEADER]

Format: 1080 x 1350 vertical
Style: clean, modern real estate flyer, brand-aligned with Loan Factory + Legends Mortgage Team

Layout (top to bottom):
1. Top band:
   - Left: {LOAN_FACTORY_LOGO}
   - Right: {LEGENDS_TEAM_LOGO} (smaller than Loan Factory)
2. Hero: {LISTING_HERO_IMAGE} — full bleed, no rate overlay
3. Listing band:
   - "[street address]"
   - "Listed at [price]"
   - "[beds] BR | [baths] BA | [sqft] sqft"
4. Campaign band:
   - Headline: "[campaign headline]"
   - Sub-headline: "[campaign sub-headline]"
   - 2-3 short bullets describing the offer or angle
5. People band (split column):
   - Left: {AGENT_HEADSHOT} | {AGENT_NAME} | {AGENT_BROKERAGE} | {AGENT_LICENSE} (or placeholder if not confirmed)
   - Right: {HEADSHOT_<LOAN_OFFICER>} | [Loan officer name] | NMLS [#] | [licensed state(s)] | [phone] | [email]
6. CTA band:
   - "Tour the home with [agent first name]"
   - "Get pre-approved with [loan officer first name]"
7. Disclosure / Compliance band (bottom):
   - {EHL_LOGO}
   - "Loan Factory NMLS 320841 | Licensed in [state(s)] | Equal Housing Lender"
   - If rate is shown: "Rate [X.XXX]% | APR [X.XXX]% — Sample scenario shown for illustration only. Not a commitment to lend."
   - If Best Price Guarantee included AND not WA: "Terms and Conditions: https://www.loanfactory.com/best-price-guarantee"

Typography rules:
- Loan Factory primary mark sized ≥ loan officer name.
- NMLS sized = smallest text on asset.
- Rate and APR (if shown) matched in font style, size, and prominence.

Do not invent logos, headshots, license numbers, agent names, brokerage names, rates, APR, or seller credit amounts.
```

---

## 3. Square Social Image (1080x1080) — Skeleton

```
[UNIVERSAL IMAGE COMPLIANCE HEADER]

Format: 1080 x 1080 square
Style: clean, modern real estate marketing tile

Layout:
- Left half: {LISTING_HERO_IMAGE} cropped to square
- Right half: stacked content
  • {LOAN_FACTORY_LOGO} on top
  • Campaign headline
  • One supporting line
  • {HEADSHOT_<LOAN_OFFICER>} thumbnail + [Loan officer name] + NMLS [#]
  • Phone, email, licensed state(s)
- Bottom strip across full width:
  • {EHL_LOGO}
  • "Loan Factory NMLS 320841 | Equal Housing Lender"
  • Rate/APR pair if rate shown
  • Best Price Guarantee terms link if included AND not WA

Sizing rules (same as universal header).
```

---

## 4. Vertical Story / Reel (1080x1920) — Skeleton

For IG Stories, Facebook Stories, TikTok-shaped vertical assets.

```
[UNIVERSAL IMAGE COMPLIANCE HEADER]

Format: 1080 x 1920 vertical
Style: thumb-stoppable cover frame, brand aligned

Layout:
- Top safe area (top 250px): {LOAN_FACTORY_LOGO} + {LEGENDS_TEAM_LOGO}
- Mid: {LISTING_HERO_IMAGE} as background, subtle dark gradient overlay for text legibility
- Center text: campaign headline + sub-headline
- Lower safe area (bottom 400px):
  • {HEADSHOT_<LOAN_OFFICER>} small circle thumbnail
  • [Loan officer name] | NMLS [#]
  • Loan Factory NMLS 320841 | Licensed in [state(s)] | Equal Housing Lender
  • {EHL_LOGO}
  • Rate / APR pair if rate is shown
  • Best Price Guarantee terms link if included AND not WA

Sizing rules (same as universal header).
```

---

## 5. Print Flyer (8.5x11) — Skeleton

```
[UNIVERSAL IMAGE COMPLIANCE HEADER]

Format: 8.5" x 11" portrait, 300 dpi print-ready
Style: clean, modern real estate flyer

Layout:
- Top band (1.25"): {LOAN_FACTORY_LOGO} left, {LEGENDS_TEAM_LOGO} right
- Hero (5"): {LISTING_HERO_IMAGE}, listing address overlaid with subtle background bar
- Listing details band (1.25"): price, beds, baths, sqft, 1-line description from listing
- Campaign band (1.25"): headline, sub-headline, 3 bullets explaining offer
- People band (1.5"):
  • Left: {AGENT_HEADSHOT} | {AGENT_NAME} | {AGENT_BROKERAGE} | {AGENT_LICENSE}
  • Right: {HEADSHOT_<LOAN_OFFICER>} | [Loan officer name] | NMLS [#] | [licensed state(s)] | [phone] | [email]
- Footer band (0.75"):
  • {EHL_LOGO}
  • "Loan Factory NMLS 320841 | Licensed in [state(s)] | Equal Housing Lender"
  • Rate / APR pair if rate shown
  • Sample scenario disclosure if any trigger term shown
  • Best Price Guarantee terms link if included AND not WA

Sizing rules (same as universal header).
```

---

## 6. Designer / Tool Reminders

When the GPT outputs an image prompt, end with this designer reminder:

```
Designer reminder:
- Replace every {PLACEHOLDER_TOKEN} with the actual approved asset from the Legends Team Logo and Team Headshots Drive folder (https://drive.google.com/drive/folders/1867ermsSLaZpvPGXf3TqFVEWlJWP_W0X?usp=sharing).
- Do not generate fake logos, headshots, or signatures.
- Match font sizing rules exactly.
- If any required asset is missing, stop and request it before finalizing.
- The final asset must pass the compliance checklist in 13_COMPLIANCE_QA_CHECKLIST.md before publication.
```

---

## 7. Image Prompt Compliance Checklist (must accompany every prompt)

Every image prompt the GPT outputs must list these checks for the designer to verify:

- [ ] Loan Factory mark equal to or larger than loan officer name/domain
- [ ] EHL logo present
- [ ] Loan officer name and NMLS visible
- [ ] Loan Factory NMLS 320841 visible
- [ ] Licensed state(s) shown where relevant
- [ ] NMLS text = smallest text on asset
- [ ] Rate and APR matched if rate is shown
- [ ] Sample scenario shown if trigger term appears in copy
- [ ] $2,000 Best Price Guarantee terms link present IF offer is included AND not WA
- [ ] No invented logos, headshots, license numbers, agent names, brokerage names, rates, APR, or credits

## 8. MND Market-Rate Context Image Rule

When the campaign uses Mortgage News Daily for a payment range estimate (option b in `05_LISTING_INTAKE_WORKFLOW.md` §7), the image **must not** include:

- The exact MND rate value
- Any APR value (MND does not publish APR; do not invent one)
- Any phrase that implies Loan Factory is offering the MND rate
- Phrases like "your rate", "locked payment", "guaranteed payment", "available now", "you qualify for"

Allowed image phrases when using MND:

- "Estimated payment range available"
- "Ask me for a custom payment breakdown"
- "See what the numbers could look like"
- "Seller-paid buydown strategy available" (when paired with a 2/1 Buydown campaign)
- "Payment strategy example available"

The actual rate range and payment range values live in the caption and in the internal compliance footer — not on the image.

### 8a. When the LO Provides Rate + APR (Option a)

If the loan officer has provided BOTH a confirmed rate and matching APR for the campaign, standard rate-bearing image rules in §1 apply: the rate and APR appear on the image at the same font style, size, and prominence, and the sample scenario block is included for trigger-term assets. This is allowed because the source is the LO, not MND.

### 8b. Mixed Source Disclaimer

If a single asset uses LO-confirmed rate + APR for public copy AND an MND-anchored payment range as a secondary educational example, each must be clearly labeled with its source. Do not blend the two so the viewer cannot tell which number came from which source.

See `MND_RATE_CONTEXT_COMPLIANCE_RULES.md` §§7–10 for the full image and caption rule set.
