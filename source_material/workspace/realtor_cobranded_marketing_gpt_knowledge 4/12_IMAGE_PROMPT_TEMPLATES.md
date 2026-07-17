# Image Prompt Templates (V4)

V4 ships a clean **copy-paste image generation prompt** that uses dynamic placeholders pulled from the selected loan officer's roster entry. The prompt leads with practical layout direction, not a compliance lecture, and the "do not include" list lives at the end. The hero image upload workflow always comes first.

---

## 1. Hero Image Upload Workflow (Always First)

Before generating any final graphic, the GPT must tell the loan officer:

> Upload the listing hero image before I generate the final graphic. I'll fill in everything else dynamically from your roster entry. If you also want your headshot, the agent's headshot, or the agent's brokerage logo on the graphic, upload those too — they're optional.

The GPT then produces a copy-paste image prompt designed to work AFTER the upload. The prompt instructs the image tool to use the uploaded photo and not replace the home with an AI-generated property.

## 2. Placeholder Tokens (Dynamic)

The GPT fills these placeholders from `TEAM_ASSET_REFERENCE.md` (LO data), `03_TEAM_ROSTER_AND_DISCLOSURES.md`, the listing details, and any optional uploads. The GPT must **never hardcode a specific loan officer's name** in any template.

Loan officer placeholders:

- `PUBLIC_FACING_LO_NAME` — full name
- `PUBLIC_FACING_LO_FIRST_NAME` — first name only (for CTAs like "Ask {first_name}")
- `PUBLIC_FACING_LO_NMLS` — individual NMLS
- `PUBLIC_FACING_LO_LICENSED_STATE` — state(s) the LO is licensed in for the property
- `PUBLIC_FACING_LO_PHONE` — company phone
- `PUBLIC_FACING_LO_EMAIL` — @loanfactory.com email
- `PUBLIC_FACING_LO_HEADSHOT` — optional upload, headshot file

Listing placeholders:

- `LISTING_HERO_IMAGE` — required upload
- `LISTING_ADDRESS`
- `LISTING_PRICE`
- `BEDROOMS`
- `BATHROOMS`
- `SQUARE_FEET`

Agent placeholders:

- `AGENT_NAME` — confirmed by LO or pulled from listing
- `AGENT_BROKERAGE`
- `AGENT_HEADSHOT_OPTIONAL` — optional upload
- `AGENT_BROKERAGE_LOGO_OPTIONAL` — optional upload

Brand placeholders:

- `LOAN_FACTORY_LOGO`
- `EHL_LOGO`
- `LEGENDS_TEAM_LOGO`

## 3. V4 Copy-Paste Image Generation Prompt — Seller-Funded 2/1 Buydown

The canonical V4 prompt. Paste-ready, no compliance lecture up front. The GPT swaps placeholders dynamically; the user pastes the resulting text into ChatGPT Image Generation, Midjourney, or any image tool, after uploading the listing hero image.

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

## 4. V4 Copy-Paste Variants — Other Campaigns

The same skeleton applies to the other campaign types with these headline/subheadline swaps:

### 4a. 100% Financing with Assistance

- Main headline: `100% Financing With Assistance May Be Available`
- Subheadline: `For eligible buyers — VA, USDA, or Conventional + DPA`
- Buyer strategy section bullets:
  - `Eligible structure: USDA / VA / Conventional 1st + DPA`
  - `Buyer still covers earnest money, inspection, and prepaids in most cases`
  - `Ask PUBLIC_FACING_LO_FIRST_NAME if you qualify`

### 4b. VA Buyer with 1% Closing Cost Credit

- Main headline: `VA Buyers — 1% Closing Cost Credit Available`
- Subheadline: `For eligible VA borrowers. Credit applied at closing toward closing costs.`
- Buyer strategy section bullets:
  - `$0 down for eligible buyers with full VA entitlement`
  - `Competitive VA fixed-rate options`
  - `1% Closing Cost Credit from Loan Factory at closing`
  - `Disclosure: 1% credit calculated against loan amount, applied at closing toward buyer's closing costs. Credit cannot exceed actual closing costs.`

### 4c. General Listing Marketing

- Main headline: `BEDROOMS BR / BATHROOMS BA in [CITY] — LISTING_PRICE`
- Subheadline: `Talk to AGENT_FIRST_NAME about the home. Talk to PUBLIC_FACING_LO_FIRST_NAME about the loan.`
- Buyer strategy section bullets:
  - `Pre-approval before tour`
  - `Pre-approval before offer`
  - `Ask PUBLIC_FACING_LO_FIRST_NAME to run real numbers`

All variants share the same Public-Facing Loan Officer section, Agent section, Footer, Required layout, and Do-not-include list as §3.

## 5. Legacy Skeleton Templates (V3 Reference)

These remain available for custom designer work. They are not used in the default V4 copy-paste flow but are kept here for advanced layouts when a hand-designed flyer is required.

### 5a. Vertical Social Flyer (1080 × 1350)

```
[UNIVERSAL IMAGE COMPLIANCE HEADER]

Format: 1080 x 1350 vertical
Style: clean, modern real estate flyer

Layout (top to bottom):
1. Top band: {LOAN_FACTORY_LOGO} + {LEGENDS_TEAM_LOGO}
2. Hero: {LISTING_HERO_IMAGE}, full bleed, no rate overlay
3. Listing band: address, price, beds/baths/sqft
4. Campaign band: headline + sub-headline + bullets
5. People band:
   - Left: {AGENT_HEADSHOT_OPTIONAL} | AGENT_NAME | AGENT_BROKERAGE
   - Right: {PUBLIC_FACING_LO_HEADSHOT} | PUBLIC_FACING_LO_NAME | NMLS | state(s) | phone | email
6. CTA band: "Tour the home with [agent first]. Get pre-approved with PUBLIC_FACING_LO_FIRST_NAME."
7. Disclosure band: {EHL_LOGO} + "Loan Factory NMLS 320841 | Licensed in PUBLIC_FACING_LO_LICENSED_STATE | Equal Housing Lender"
   - If LO-confirmed rate + APR shown: rate + APR matched in font style/size/prominence
   - If $2,000 Best Price Guarantee included AND not WA: terms link
```

### 5b. Square (1080 × 1080), Story/Reel (1080 × 1920), Print Flyer (8.5 × 11)

Use the same placeholder system as §3 and §5a. Adjust which sections fit per format. The disclosure band, EHL logo, and Loan Factory NMLS 320841 must remain visible in every format.

## 6. Designer / Tool Reminders

When the copy-paste prompt is handed to a designer or image tool:

- Replace every placeholder with the actual value or upload.
- Use the uploaded listing hero photo — never an AI-generated property.
- Use real LO and agent headshots only if approved and uploaded. Otherwise omit the visual and use the text section only.
- Match the sizing rules: Loan Factory ≥ LO name; NMLS = smallest text; EHL logo visible.
- If a rate appears on the image (only with LO-confirmed rate + APR), APR must appear at the same font style, size, and prominence.
- If using MND market-context data, the exact rate or any APR must NOT appear on the image.

## 7. Image Prompt Compliance Checklist (Per Prompt)

- [ ] Hero image upload requested from the LO before final graphic
- [ ] Placeholders dynamically substituted from the selected public-facing LO via `TEAM_ASSET_REFERENCE.md`
- [ ] No specific loan officer hardcoded in the template
- [ ] Loan Factory mark ≥ LO name/domain
- [ ] EHL logo present
- [ ] LO name + individual NMLS visible
- [ ] Loan Factory NMLS 320841 visible
- [ ] Licensed state(s) shown
- [ ] NMLS text = smallest text on asset
- [ ] No exact MND rate or invented APR on the image
- [ ] Rate + APR shown together only if LO-confirmed
- [ ] $2,000 Best Price Guarantee terms link present IF included AND not WA
- [ ] Agent license number not required (web-searched if practical; left out if not found)
- [ ] Agent headshot / brokerage logo treated as optional

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
- "Seller-paid buydown strategy available" (paired with a 2/1 Buydown campaign)
- "Payment strategy example available"

The actual rate range and payment range live in the caption and in the internal compliance footer — not on the image.
