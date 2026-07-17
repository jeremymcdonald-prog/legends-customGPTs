# Custom GPT Field Copy

Copy/paste reference for the exact text to put in each field when configuring the Custom GPT in ChatGPT. Use the values in this file verbatim.

---

## 1. GPT Name

```
Realtor Co-Branded Marketing Assistant
```

## 2. GPT Description (short, public-facing)

```
Creates compliant realtor co-branded mortgage marketing drafts for Loan Factory loan officers using listing URLs, property details, team compliance data, approved campaign templates, and Loan Factory disclosure rules.
```

## 3. GPT Instructions

Paste the entire contents of `00_PASTE_IN_GPT_INSTRUCTIONS_SHORT.md` into the **Instructions** field. This is the paste-ready short version, kept under the 8,000-character ChatGPT Instructions limit. The longer `01_GPT_MASTER_INSTRUCTIONS.md` is the comprehensive reference and lives in Knowledge — do not paste it into the Instructions field.

## 4. Conversation Starters

Paste these four exact strings as conversation starters (one per slot):

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

## 5. Knowledge Files to Upload (Order)

Upload these files into the GPT's Knowledge section, in this order:

1. `01_GPT_MASTER_INSTRUCTIONS.md` (the comprehensive reference — the short version `00` goes in the Instructions field, not Knowledge, though uploading 00 to Knowledge is also fine)
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
14. `14_CUSTOM_GPT_FIELD_COPY.md` (optional — useful for future maintenance)
15. `MND_RATE_CONTEXT_COMPLIANCE_RULES.md` (required whenever the GPT is allowed to use MND for payment range estimates — recommended always)
16. `TEAM_ASSET_REFERENCE.md` (V4 — fast LO lookup; the GPT pulls public-facing LO data dynamically from here)
17. `V4_CHANGELOG.md` (V4 change log; optional but useful)

### 5a. Files NOT Uploaded to Knowledge (Used Elsewhere)

- `00_PASTE_IN_GPT_INSTRUCTIONS_SHORT.md` — paste this into the Custom GPT **Instructions** field (not Knowledge, though it's harmless to upload).
- `GPT_ACTION_MND_RATE_OPENAPI_SCHEMA.json` — paste this into the Custom GPT **Actions** panel (not Knowledge). See §11 below.
- `MND_AVERAGE_RATE_RESEARCH.md` — internal research reference for the development team. Optional to upload; not needed by the GPT at runtime.
- `MND_PAYMENT_RANGE_WORKFLOW.md` — internal reference for the n8n developer. Not uploaded to the GPT.

## 6. Capabilities to Enable

Enable in the Custom GPT builder:

- **Web Browsing** — required so the GPT can attempt to read listing URLs (Redfin, Zillow, Realtor.com).
- **Image generation (DALL·E)** — optional. Even if enabled, the GPT must produce **image prompts** with placeholder tokens, not generated final compliant artwork.
- **Code Interpreter** — not required.

## 7. Capabilities to Disable

- **Actions / external APIs** — not required for this phase.
- **Memory across chats** — recommended off so each campaign is treated independently.

## 8. Recommended Builder Settings

- **Visibility:** Private link (share with Legends Mortgage Team loan officers only).
- **Allow ratings:** off (internal tool, not a public product).
- **Allow user feedback:** off.
- **Profile picture:** use the Legends Team logo from the Drive folder (file: `legends_offical_logo_2026 (1).png`).

## 9. Profile Picture Source

Logo to upload as the GPT profile picture: file `legends_offical_logo_2026 (1).png` from the **Legends Team Logo and Team Headshots** Google Drive folder.

Drive folder: https://drive.google.com/drive/folders/1867ermsSLaZpvPGXf3TqFVEWlJWP_W0X?usp=sharing

## 10. Maintenance Cadence

- Re-upload `03_TEAM_ROSTER_AND_DISCLOSURES.md` whenever a new loan officer joins, leaves, or changes states.
- Re-upload `02_LOAN_FACTORY_MARKETING_COMPLIANCE_RULES.md` whenever Loan Factory compliance issues an updated guideline.
- Re-upload `04_TEAM_ASSET_INDEX.md` whenever new approved headshots or logos are added to the Drive folder.
- Re-upload `06–09` campaign playbooks whenever an offer's terms change (rate, credit %, structure).
- Re-upload `01_GPT_MASTER_INSTRUCTIONS.md` and paste it into Instructions if any compliance rule or workflow rule changes.

## 11. Optional: Wire Up the `getMNDRateContext` Action

If you want the GPT to be able to pull market-context rate data from Mortgage News Daily via the Legends n8n webhook, configure the Action:

1. In the Custom GPT builder, open **Configure → Actions → Create new action**.
2. Paste the entire contents of `GPT_ACTION_MND_RATE_OPENAPI_SCHEMA.json` into the schema field.
3. Replace the `servers[0].url` value with the actual deployed n8n webhook host (e.g., `https://n8n.legendsmortgageteam.app`).
4. Under **Authentication**, choose **Custom**. Add header `X-Legends-Auth` with the shared secret stored in n8n credentials.
5. Save and test using a sample request from `MND_PAYMENT_RANGE_WORKFLOW.md` §2.
6. Ensure `MND_RATE_CONTEXT_COMPLIANCE_RULES.md` is uploaded to Knowledge — the GPT must apply those rules to every Action call.

Until the Action is wired up, the GPT will fetch the MND rate via web search using the URLs in `MND_RATE_CONTEXT_COMPLIANCE_RULES.md` §3 and apply the same rules manually. The pack works either way.

## 12. Quick Sanity Test

After uploading, run this prompt against the GPT in test mode:

```
You are a test. Please pretend a loan officer pasted a Zillow listing in Jacksonville FL and is asking for a Seller-Funded 2/1 Buydown campaign. Walk me through your intake questions, then produce a fake-but-compliant draft pack using placeholder values. Do not invent any rates or APR.
```

Verify the GPT:

- Asks which loan officer
- Asks for the listing details (fallback fields)
- Asks for rate and APR before producing rate copy
- Asks for $120/mo insurance approval
- Asks output formats
- Asks about the $2,000 Best Price Guarantee
- Recaps inputs before drafting
- Produces output in default order: summary → missing inputs → image prompt → caption → email → text → DM → checklist → final approval reminder
- Refuses to invent rate/APR
- Surfaces a compliance checklist at the end
- Labels the output as draft
