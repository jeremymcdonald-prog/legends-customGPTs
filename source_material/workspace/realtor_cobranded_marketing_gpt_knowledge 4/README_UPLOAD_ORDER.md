# README — Upload Order and Custom GPT Setup

Jeremy — here's the exact build-out for the **Realtor Co-Branded Marketing Assistant** Custom GPT for the Legends Mortgage Team powered by Loan Factory. This is the production knowledge pack. No app development in this phase.

---

## 1. What You're Looking At

This folder is the complete knowledge pack for one Custom GPT. It contains:

- The master system instructions (file 01)
- The compliance rulebook (file 02)
- The active team roster with disclosures (file 03)
- An asset index that points to the Drive folder (file 04)
- The listing intake workflow (file 05)
- Four campaign playbooks: 2/1 buydown, 100% financing with assistance, VA 1% credit, general listing (files 06–09)
- Agent outreach templates: email/text/DM (file 10)
- Social caption templates by campaign and platform (file 11)
- Image prompt templates (file 12)
- The compliance QA checklist (file 13)
- The exact copy for the Custom GPT name, description, instructions, conversation starters, and knowledge upload order (file 14)
- This README

## 2. Step-by-Step Custom GPT Build

### Step 1 — Open the GPT builder

Go to ChatGPT → **Explore GPTs** → **Create**. Use the **Configure** tab (not Create chat).

### Step 2 — Set the Name

Paste this exactly:

```
Realtor Co-Branded Marketing Assistant
```

### Step 3 — Set the Description

Paste this exactly:

```
Creates compliant realtor co-branded mortgage marketing drafts for Loan Factory loan officers using listing URLs, property details, team compliance data, approved campaign templates, and Loan Factory disclosure rules.
```

### Step 4 — Paste the Instructions

Open `01_GPT_MASTER_INSTRUCTIONS.md` and paste the **entire** file contents into the **Instructions** field.

Do not paraphrase. Do not trim. Do not summarize. The compliance language is load-bearing.

### Step 5 — Add the Conversation Starters

Add these four conversation starters (one per slot):

1. ```
Help me create a 2/1 buydown marketing campaign for this listing.
```
2. ```
Create a 100% financing campaign for this listing.
```
3. ```
Create a VA buyer campaign with a 1% closing cost credit.
```
4. ```
Create an agent email, text, DM, caption, and image prompt for this listing.
```

### Step 6 — Set Capabilities

- ✅ **Web Browsing** — ON (required to attempt to read listing URLs)
- ☑️ **DALL·E image generation** — OPTIONAL (the GPT will still produce placeholder image prompts; do not let the GPT publish final compliant artwork without your designer)
- ☐ **Code Interpreter** — OFF
- ☐ **Actions** — OFF
- ☐ **Memory across chats** — OFF (each campaign session should be independent)

### Step 7 — Paste the Short Instructions

Open `00_PASTE_IN_GPT_INSTRUCTIONS_SHORT.md` and paste the **entire** file contents into the Custom GPT **Instructions** field. It is the paste-ready short version, kept under the 8,000-character limit. The longer `01_GPT_MASTER_INSTRUCTIONS.md` is the comprehensive reference and lives in Knowledge (next step).

### Step 8 — Upload Knowledge Files (in this order)

Upload these files from this folder into the **Knowledge** section:

1. `01_GPT_MASTER_INSTRUCTIONS.md`
2. `02_LOAN_FACTORY_MARKETING_COMPLIANCE_RULES.md`
3. `03_TEAM_ROSTER_AND_DISCLOSURES.md`
4. `04_TEAM_ASSET_INDEX.md`
5. `05_LISTING_INTAKE_WORKFLOW.md`
6. `06_SELLER_FUNDED_2_1_BUYDOWN_PLAYBOOK.md`
7. `07_100_PERCENT_FINANCING_ASSISTANCE_PLAYBOOK.md`
8. `08_VA_ONE_PERCENT_CREDIT_PLAYBOOK.md`
9. `09_GENERAL_LISTING_CAMPAIGN_PLAYBOOK.md`
10. `10_AGENT_OUTREACH_TEMPLATES.md`
11. `11_SOCIAL_CAPTION_TEMPLATES.md`
12. `12_IMAGE_PROMPT_TEMPLATES.md`
13. `13_COMPLIANCE_QA_CHECKLIST.md`
14. `14_CUSTOM_GPT_FIELD_COPY.md`
15. `MND_RATE_CONTEXT_COMPLIANCE_RULES.md` (required whenever the GPT is allowed to use Mortgage News Daily for payment range estimates — recommended always)
16. `TEAM_ASSET_REFERENCE.md` (V4 — fast lookup for every LO's NMLS, contact info, headshot file, disclosure block; the GPT pulls public-facing LO data dynamically from here)
17. `V4_CHANGELOG.md` (V4 — change log summarizing the V4 updates; optional but useful)

You can also upload this README, but it's not required for the GPT to function — it's for you.

**Do NOT upload these files to Knowledge** (they live in the folder for the Instructions field, the Actions panel, or developer reference):

- `00_PASTE_IN_GPT_INSTRUCTIONS_SHORT.md` — paste into the Custom GPT **Instructions** field (step 7).
- `TEAM_ASSET_REFERENCE_FOR_UPLOAD.html` — print-ready visual reference. Open in any browser and print to PDF if your team prefers a visual upload over the markdown version.
- `TEAM_ASSET_REFERENCE_FOR_UPLOAD.pdf` — printable PDF version of the team asset reference, ready to upload as a visual Knowledge document.
- `GPT_ACTION_MND_RATE_OPENAPI_SCHEMA.json` — paste into the Custom GPT **Actions** panel (optional, see step 9).
- `MND_AVERAGE_RATE_RESEARCH.md` — internal research log for the development team.
- `MND_PAYMENT_RANGE_WORKFLOW.md` — internal n8n workflow build spec for the developer.

### Step 8 — Set Profile Picture

Upload `legends_offical_logo_2026 (1).png` from the **Legends Team Logo and Team Headshots** Google Drive folder as the GPT's profile picture.

Drive folder:
https://drive.google.com/drive/folders/1867ermsSLaZpvPGXf3TqFVEWlJWP_W0X?usp=sharing

### Step 9 — Set Visibility

Private link, shared with Legends Mortgage Team loan officers only. Not public. Not searchable.

### Step 10 — Smoke Test

Open the GPT in preview and run this exact prompt:

```
You are a test. Please pretend a loan officer pasted a Zillow listing in Jacksonville FL and is asking for a Seller-Funded 2/1 Buydown campaign. Walk me through your intake questions, then produce a fake-but-compliant draft pack using placeholder values. Do not invent any rates or APR.
```

Verify the GPT:

- Asks which loan officer
- Asks for listing details (fallback fields)
- Asks for rate and APR before producing rate copy
- Asks for $120/mo insurance approval
- Asks output formats
- Asks about the $2,000 Best Price Guarantee
- Recaps inputs before drafting
- Produces output in default order: summary → missing inputs → image prompt → caption → email → text → DM → checklist → final approval reminder
- Refuses to invent rate/APR
- Surfaces a compliance checklist at the end
- Labels the output as draft

If any of the above is missing, re-paste the Instructions from `01_GPT_MASTER_INSTRUCTIONS.md` and re-upload `02_LOAN_FACTORY_MARKETING_COMPLIANCE_RULES.md`.

---

## 3. Where the Loan Officers Plug In Real Assets

The GPT itself does **not** ship final compliant artwork. It produces image prompts with placeholder tokens. Loan officers (or your designer) drop in the matching real files from this Drive folder:

https://drive.google.com/drive/folders/1867ermsSLaZpvPGXf3TqFVEWlJWP_W0X?usp=sharing

Reference for token-to-file mapping is in `04_TEAM_ASSET_INDEX.md`.

Logos direct links (also referenced inside the GPT knowledge):
- Loan Factory logo: https://lh3.googleusercontent.com/d/1HrACAbKJlwAasqR9OtN-T1CqPcbgzT_p=s1200
- Equal Housing Lender logo: https://lh3.googleusercontent.com/d/12Gzj-3bq5P-O7MtnfFVr5Kn1b6HAix02=s1200

---

## 4. Maintenance Checklist

Every time the team changes:

- ☐ Update `03_TEAM_ROSTER_AND_DISCLOSURES.md` (new officer, removed officer, license state change, contact change).
- ☐ Update `04_TEAM_ASSET_INDEX.md` if new headshots get added to the Drive folder.
- ☐ Re-upload the changed files in the Custom GPT Knowledge section.

Every time compliance changes:

- ☐ Update `02_LOAN_FACTORY_MARKETING_COMPLIANCE_RULES.md`.
- ☐ Update `01_GPT_MASTER_INSTRUCTIONS.md` if the rule change affects workflow or output order.
- ☐ Re-paste `01_GPT_MASTER_INSTRUCTIONS.md` into the Instructions field.
- ☐ Re-upload `02_LOAN_FACTORY_MARKETING_COMPLIANCE_RULES.md`.

Every time a campaign offer changes:

- ☐ Update the matching playbook file (`06`, `07`, `08`, or `09`).
- ☐ Re-upload it.

---

## 5. What's Intentionally Out of Scope for This Phase

- No backend app for the marketing GPT itself.
- No CRM integration.
- No automated posting.
- No automatic compliance approval.

**Optional / Phase 2:** A `getMNDRateContext` Action is designed and ready to wire up via an n8n webhook (see `MND_PAYMENT_RANGE_WORKFLOW.md`). It returns market-context rate data from Mortgage News Daily plus a computed principal-and-interest payment range — third-party average market data only, never a quote, never a Loan Factory price. The GPT works fine without it; until the webhook is deployed, the GPT can fetch MND rates manually via web search using the URLs in `MND_RATE_CONTEXT_COMPLIANCE_RULES.md` §3.

This is **just** the production Custom GPT knowledge pack. You can build the MND rate automation on top of it as a Phase 2 once n8n is deployed.

---

## 6. File Inventory

```
realtor_cobranded_marketing_gpt_knowledge/
├── 01_GPT_MASTER_INSTRUCTIONS.md
├── 02_LOAN_FACTORY_MARKETING_COMPLIANCE_RULES.md
├── 03_TEAM_ROSTER_AND_DISCLOSURES.md
├── 04_TEAM_ASSET_INDEX.md
├── 05_LISTING_INTAKE_WORKFLOW.md
├── 06_SELLER_FUNDED_2_1_BUYDOWN_PLAYBOOK.md
├── 07_100_PERCENT_FINANCING_ASSISTANCE_PLAYBOOK.md
├── 08_VA_ONE_PERCENT_CREDIT_PLAYBOOK.md
├── 09_GENERAL_LISTING_CAMPAIGN_PLAYBOOK.md
├── 10_AGENT_OUTREACH_TEMPLATES.md
├── 11_SOCIAL_CAPTION_TEMPLATES.md
├── 12_IMAGE_PROMPT_TEMPLATES.md
├── 13_COMPLIANCE_QA_CHECKLIST.md
├── 14_CUSTOM_GPT_FIELD_COPY.md
├── 00_PASTE_IN_GPT_INSTRUCTIONS_SHORT.md
├── V4_CHANGELOG.md
├── MND_RATE_CONTEXT_COMPLIANCE_RULES.md
├── MND_AVERAGE_RATE_RESEARCH.md
├── MND_PAYMENT_RANGE_WORKFLOW.md
├── GPT_ACTION_MND_RATE_OPENAPI_SCHEMA.json
├── TEAM_ASSET_REFERENCE.md
├── TEAM_ASSET_REFERENCE_FOR_UPLOAD.html
├── TEAM_ASSET_REFERENCE_FOR_UPLOAD.pdf
└── README_UPLOAD_ORDER.md   ← this file
```

A zipped version of the folder lives next to it on the Desktop:
`realtor_cobranded_marketing_gpt_knowledge.zip`
