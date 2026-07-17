# Team Asset Index

This file tells the Custom GPT where the Legends Mortgage Team's approved brand assets live and how to reference them in image prompts and outputs. The GPT itself does not host these assets — it references them as placeholders for designers and image tools to swap in.

---

## 1. Primary Asset Folder

**Google Drive folder name:** Legends Team Logo and Team Headshots
**Share link:** https://drive.google.com/drive/folders/1867ermsSLaZpvPGXf3TqFVEWlJWP_W0X?usp=sharing

This folder contains:
- Legends Mortgage Team logos
- Loan officer headshots
- Reference brand assets

> The GPT should always tell the loan officer to grab the matching file from this folder when finalizing the image. The GPT must never claim it has embedded the final logo or headshot into a generated image.

---

## 2. Required Branding Logos

### 2a. Loan Factory Logo
- Direct image link: https://lh3.googleusercontent.com/d/1HrACAbKJlwAasqR9OtN-T1CqPcbgzT_p=s1200
- Placeholder token in image prompts: `{LOAN_FACTORY_LOGO}`
- Required on: every mortgage marketing image, flyer, and video frame
- Sizing rule: must be equal to or larger than the loan officer's name or personal domain on the asset.

### 2b. Equal Housing Lender (EHL) Logo
- Direct image link: https://lh3.googleusercontent.com/d/12Gzj-3bq5P-O7MtnfFVr5Kn1b6HAix02=s1200
- Placeholder token in image prompts: `{EHL_LOGO}`
- Required on: every mortgage marketing image, flyer, and video frame.

### 2c. Legends Mortgage Team Logo (Secondary Mark, Approved)
- File name in folder: `legends_offical_logo_2026 (1).png`
- Placeholder token in image prompts: `{LEGENDS_TEAM_LOGO}`
- Optional secondary mark. Must not outsize Loan Factory.

---

## 3. Loan Officer Headshots (Active Roster)

| Loan Officer | Headshot File | Placeholder Token |
|---|---|---|
| Jeremy McDonald | `Jeremy McDonald.png` | `{HEADSHOT_JEREMY_MCDONALD}` |
| Barbara Jordan | `Barbra HS.png` | `{HEADSHOT_BARBARA_JORDAN}` |
| Bryan Payne | `Bryan Profile.png` | `{HEADSHOT_BRYAN_PAYNE}` |
| Christina Bús | `Christina HS Final.png` | `{HEADSHOT_CHRISTINA_BUS}` |
| Eric Jason Ritchie | `Eric Profile.png` | `{HEADSHOT_ERIC_RITCHIE}` |
| Hugo Calvillo | `Hugo.png` | `{HEADSHOT_HUGO_CALVILLO}` |
| Jesus Urquiza | `Jesus Profile.png` | `{HEADSHOT_JESUS_URQUIZA}` |
| Mark Sileck | `Mark HS Final.png` | `{HEADSHOT_MARK_SILECK}` |
| Raleigh Morrison | `Raleigh HS.png` | `{HEADSHOT_RALEIGH_MORRISON}` |
| Alison McLeod | `Alison.png` | `{HEADSHOT_ALISON_MCLEOD}` |
| Scott Mason | `Scott Profile.png` | `{HEADSHOT_SCOTT_MASON}` |
| Irene Holden | `Irene HS.png` | `{HEADSHOT_IRENE_HOLDEN}` |

When the GPT builds an image prompt for a specific loan officer, it should insert the matching placeholder token (`{HEADSHOT_<NAME>}`) so the designer knows which file to drop in.

---

## 4. Agent and Realtor Assets

The GPT **does not** invent agent assets. When an agent's headshot, brokerage logo, or license number is needed, the GPT must use these placeholder tokens until the loan officer confirms the actual asset:

- `{AGENT_HEADSHOT}` — only if approved by the agent
- `{AGENT_BROKERAGE_LOGO}` — only if approved
- `{AGENT_NAME}` — confirmed by loan officer
- `{AGENT_LICENSE}` — confirmed by loan officer
- `{AGENT_PHONE}` — confirmed by loan officer
- `{AGENT_EMAIL}` — confirmed by loan officer

If any of these are missing in the final loan officer input, the GPT must list them under **Missing Inputs** and decline to produce final co-branded artwork instructions.

---

## 5. Listing Imagery

The GPT must use placeholders for the listing hero image and additional listing photos. Do not generate fake property imagery.

- `{LISTING_HERO_IMAGE}` — hero shot from listing site
- `{LISTING_PHOTO_2}` — secondary listing photo (optional)
- `{LISTING_PHOTO_3}` — tertiary listing photo (optional)

If the listing URL doesn't yield usable images, the GPT must ask the loan officer to upload the hero image or paste a direct image URL.

---

## 6. Asset Reference Convention in Image Prompts

When the GPT writes an image prompt for a designer or image tool, it must:

1. Use the placeholder tokens listed above instead of describing imaginary logos.
2. State the sizing rule for Loan Factory vs. loan officer name.
3. State the NMLS text sizing rule (same size as smallest text).
4. Include the EHL logo placeholder in a visible footer position.
5. Reference licensed states when relevant.
6. If a rate is shown, instruct the designer to pair APR at the same visual prominence.
7. If the $2,000 Best Price Guarantee is shown, include the terms link on the image (and confirm the asset is not for WA).

Example image prompt skeleton:

```
Create a 1080x1350 vertical co-branded real estate flyer.

Layout:
- Top: {LOAN_FACTORY_LOGO} (left) and {LEGENDS_TEAM_LOGO} (right, smaller)
- Hero: {LISTING_HERO_IMAGE} (full-width, no overlay)
- Mid: campaign headline (see playbook)
- Right column: {HEADSHOT_<LOAN_OFFICER>} with name, NMLS, phone, email
- Right column secondary: {AGENT_HEADSHOT} with agent name, brokerage, license (placeholders if not confirmed)
- Footer: {EHL_LOGO}, Loan Factory NMLS 320841, licensed states, Best Price Guarantee terms link if applicable

Sizing rules:
- Loan Factory name/logo size ≥ loan officer name/domain.
- NMLS text = smallest text on the asset.
- Interest rate and APR (if shown) match font style, size, and prominence.

Do not invent logos, headshots, license numbers, agent names, brokerage names, rates, or APR.
```
