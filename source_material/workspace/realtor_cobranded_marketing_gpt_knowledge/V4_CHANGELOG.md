# V4 Changelog — Realtor Co-Branded Marketing Assistant Knowledge Pack

Version 4 ships a tighter, more reliable Seller-Funded 2/1 Buydown workflow, removes friction in the intake (no more blocking on agent license number or seller concession amount), and standardizes the image prompt around a clean copy-paste format that pulls every loan officer detail dynamically from the roster.

---

## 1. Seller-Funded 2/1 Buydown Logic Improved

- The GPT now **always builds payment examples for both FHA (3.5% down) and Conventional (5% down)** by default on every 2/1 Buydown campaign. Each is shown side-by-side so the agent can speak to a wider buyer pool.
- Loan officers can still ask for additional scenarios (10%, 20%, etc.) on request — but 20% down is no longer the assumed default.
- New default output order for 2/1 Buydown campaigns prioritizes verified listing facts → assumptions → FHA estimate → Conventional estimate → seller-funded buydown cost → image prompt → captions → outreach → compliance.

## 2. FHA 3.5% and Conventional 5% Down Defaults Added

- New documented defaults baked into `06_SELLER_FUNDED_2_1_BUYDOWN_PLAYBOOK.md` and the master instructions.
- FHA 3.5% down = current FHA program minimum on a 30-year fixed.
- Conventional 5% down = standard low-down-payment Conventional on a 30-year fixed.

## 3. 20% Down Default Removed

- 20% down is no longer auto-applied. Marketing for typical buyer audiences (especially first-time and step-up buyers) now leads with realistic low-down scenarios.

## 4. Seller-Funded Buydown Cost Calculation Added

The GPT now estimates the seller-funded buydown cost automatically using a documented formula:

- **Year 1 subsidy** = (P&I at note rate − P&I at note rate − 2%) × 12
- **Year 2 subsidy** = (P&I at note rate − P&I at note rate − 1%) × 12
- **Estimated seller-funded buydown cost** = Year 1 subsidy + Year 2 subsidy

When MND market-context rates are used, the estimate is framed as an **estimated market-context buydown cost range**, never a final concession, quote, approval, or commitment to lend.

This removes the prior friction of asking the LO for a seller concession amount upfront before the GPT could draft anything.

## 5. Agent License Number No Longer Blocks Draft Creation

- The GPT does **not** ask the user for the real estate agent's license number by default.
- The GPT may web-search the agent's name + brokerage + state to surface a license number.
- If a license number cannot be found, it is left out of the draft. Drafts proceed without it.

## 6. Copy-Paste Image Prompt Format Improved

- The 2/1 Buydown image prompt now ships as a **clean, paste-ready prompt** that does not lead with a compliance lecture.
- Practical language up front, compliance constraints toward the end.
- Designed to paste directly into ChatGPT Image Generation, Midjourney, or another image tool after the LO has uploaded the listing hero image.
- Explicit instruction: "Use the uploaded listing photo. Do not replace the home with an AI-generated property."

## 7. Hero Image Upload Workflow Improved

- The GPT now explicitly tells the LO to **upload the listing hero image before generating the final graphic**.
- The image prompt is written to work AFTER the upload, using a `LISTING_HERO_IMAGE` placeholder.
- Optional uploads: loan officer headshot, agent headshot, agent brokerage logo. The prompt template includes optional sections for each that the GPT removes if not provided.

## 8. Team Asset Reference Document Added

Two new files give the GPT a fast lookup for every team member's NMLS, licensed states, contact info, and headshot filename:

- `TEAM_ASSET_REFERENCE.md` — markdown, uploads cleanly to ChatGPT Knowledge.
- `TEAM_ASSET_REFERENCE_FOR_UPLOAD.html` — print-ready HTML that can be saved to PDF for upload as a visual reference document.
- `TEAM_ASSET_REFERENCE_FOR_UPLOAD.pdf` — generated from the HTML when Chrome is available.

## 9. Dynamic Loan Officer Pull (No Hardcoding)

- The master instructions and image prompt template **never hardcode any single loan officer's name**.
- All LO data flows through dynamic placeholders: `PUBLIC_FACING_LO_NAME`, `PUBLIC_FACING_LO_NMLS`, `PUBLIC_FACING_LO_LICENSED_STATE`, `PUBLIC_FACING_LO_PHONE`, `PUBLIC_FACING_LO_EMAIL`, `PUBLIC_FACING_LO_HEADSHOT`.
- The State Licensing Handoff Workflow still applies — if the selected LO isn't licensed in the property state, the GPT swaps in a licensed teammate as the public-facing LO and keeps the original LO in the background only.

## 10. Jeremy McDonald's NMLS Corrected

- `03_TEAM_ROSTER_AND_DISCLOSURES.md` now includes Jeremy's individual NMLS **1195266** (previously listed as Team Leader with no individual NMLS).

## 11. Master Instructions Shortened and Returned for Paste Review

- `00_PASTE_IN_GPT_INSTRUCTIONS_SHORT.md` is fully rewritten for V4 and remains **under 8,000 characters** so it fits cleanly in the ChatGPT Custom GPT Instructions field.
- The complete V4 master instructions are also returned in the assistant's final response under a section titled **MASTER INSTRUCTIONS UNDER 8000 CHARACTERS** for direct paste review.

## 12. Files Touched in V4

**Created:**
- `V4_CHANGELOG.md`
- `TEAM_ASSET_REFERENCE.md`
- `TEAM_ASSET_REFERENCE_FOR_UPLOAD.html`
- `TEAM_ASSET_REFERENCE_FOR_UPLOAD.pdf` (printed from HTML when Chrome available)

**Updated:**
- `00_PASTE_IN_GPT_INSTRUCTIONS_SHORT.md` (V4 master instructions, <8000 chars)
- `03_TEAM_ROSTER_AND_DISCLOSURES.md` (Jeremy NMLS 1195266 added)
- `04_TEAM_ASSET_INDEX.md` (references to new team asset reference docs)
- `05_LISTING_INTAKE_WORKFLOW.md` (no license blocker, hero image upload step, optional headshot/logo asks, FHA + Conv default note)
- `06_SELLER_FUNDED_2_1_BUYDOWN_PLAYBOOK.md` (FHA 3.5% + Conv 5% defaults, buydown cost math, new output order, new copy-paste image prompt format)
- `10_AGENT_OUTREACH_TEMPLATES.md` (no license number references blocking output)
- `11_SOCIAL_CAPTION_TEMPLATES.md` (buydown caption supports both FHA and Conv options)
- `12_IMAGE_PROMPT_TEMPLATES.md` (new copy-paste format with dynamic placeholders, hero image upload workflow up front)
- `13_COMPLIANCE_QA_CHECKLIST.md` (no license blocker check, FHA + Conv versions check, hero image upload check)
- `MND_RATE_CONTEXT_COMPLIANCE_RULES.md` (buydown cost framing as estimated market context only)
- `README_UPLOAD_ORDER.md` (new files in upload list, V4 paste flow)
- `14_CUSTOM_GPT_FIELD_COPY.md` (references new TEAM_ASSET_REFERENCE files)

**Not touched (intentionally):**
- `01_GPT_MASTER_INSTRUCTIONS.md` — long-form reference; still valid as Knowledge content. The paste-in is `00_PASTE_IN_GPT_INSTRUCTIONS_SHORT.md`.
- `02_LOAN_FACTORY_MARKETING_COMPLIANCE_RULES.md` — base compliance rules unchanged.
- `07_100_PERCENT_FINANCING_ASSISTANCE_PLAYBOOK.md`, `08_VA_ONE_PERCENT_CREDIT_PLAYBOOK.md`, `09_GENERAL_LISTING_CAMPAIGN_PLAYBOOK.md` — only V3 MND additions apply; V4 buydown logic doesn't affect these campaigns.
- `MND_AVERAGE_RATE_RESEARCH.md`, `MND_PAYMENT_RANGE_WORKFLOW.md`, `GPT_ACTION_MND_RATE_OPENAPI_SCHEMA.json` — no API surface changes.
