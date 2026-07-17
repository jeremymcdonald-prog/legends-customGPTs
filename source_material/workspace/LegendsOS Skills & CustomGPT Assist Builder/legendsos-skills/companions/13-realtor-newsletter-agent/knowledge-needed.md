# Knowledge Status — Last Updated 2026-05-24

| Knowledge Area | Status | Source |
|---|---|---|
| AI Realtor Pro | **VERIFIED — local source read** | `AI-Realtor-Pro-Final-main/` (landing page, layout, about, dashboard, ai-twin, get-preapproved, marketing-studio) + Jeremy site `AgentsPage.tsx`. See `verified-source-knowledge.md`, `source-map.md`, `verification-report.md`. |
| Florida Home Buying Network | **VERIFIED — local source read** | `florida-home-buying-network-main/` (App.tsx, Home.tsx, Layout.tsx, services/api.ts, constants.ts, locales/en/common.json, types.ts). Note: directory contact data is placeholder/mock — see verification-report.md §Blockers. |
| Jeremy website content | **VERIFIED — local source read** | `final-jeremy-mcdonald-mtg.com-main/` (constants.ts, HomePage.tsx, AgentsPage.tsx, InvestorHubPage.tsx, public/llms.txt, 29 blog files indexed). Section 11 of AGENT.md uses AgentsPage.tsx AI Realtor Pro content verbatim. |
| Legends Team website | **VERIFIED — local source read** | `Legends-Team-Website-main/` (constants.ts, TeamPage.tsx, Team.tsx, src/data/authority.ts). 15 loan officer NMLS roster captured. Bilingual team members named. |
| Loan Factory guarantee | **PARTIALLY VERIFIED — section in AGENT.md left untouched per user instruction** | Source confirms $1,000 amount + eligibility (Conv/FHA/VA $200K+ same-day locked comparisons) at Jeremy site `constants.ts:160`. **Still open:** excluded-states list (especially WA), full T&Cs URL, approved disclaimer copy. Pending Prompt 3 confirmation that $1,000 (not $2,000) is current and excluded-states detail. |
| Bilingual team details | **PARTIALLY VERIFIED — section in AGENT.md left untouched per user instruction** | Bilingual team members named in Legends `src/data/authority.ts`: Hugo Calvillo, Vivian Delgado, Katherine Bernal, Camilia Da La Luz. Approved bilingual line at `authority.ts:1364`. FHBN ships en + es-PR locales. **Still open:** Spanish-language tagline, approved Spanish CTAs, cultural-fit notes for Hispanic FL market. Pending Prompt 4. |
| Investor programs | **PARTIALLY VERIFIED — section in AGENT.md left untouched per user instruction** | Programs offered: DSCR, Fix & Flip, Ground-Up Construction, Bank Statement, HELOC (Investment), FHA 203k — all listed in `constants.ts` with full transcripts. Investor Hub positioning verified. **Still open:** typical deal profile that can be public, foreign national specifics, approved talking points, marketing restrictions. Pending Prompt 4. |
| Deal save stories | OPEN | No on-site case studies file. Requires direct Jeremy approval per AGENT.md §14. |
| NMLS reconciliation | BLOCKER | AIRP `get-preapproved/page.tsx:18` shows NMLS 2121161 vs verified 1195266 everywhere else. Newsletter copy must use 1195266 only until Jeremy resolves the AIRP source. |
| AIRP phone typo | BLOCKER | AIRP `about/page.tsx:128` shows 904-424-2025 vs verified 904-442-3213. Default to 442-3213. |
| FHBN per-pro contact data | BLOCKER | Most agent/pro records in `constants.ts` use placeholder phone/email/website. Newsletter must not cite specific contact strings until real data lands. |

---

# Knowledge Needed — Agent 13: Realtor Newsletter Agent

These are the four knowledge gaps that must be resolved before this agent can generate fully verified newsletter content. Each prompt below is paste-ready and should be sent to the relevant project.

---

## Prompt 1 — For AI Realtor Pro Project

**Send to:** AI Realtor Pro project or Jeremy's AI Realtor Pro documentation source

**Subject:** Agent 13 Knowledge Request — AI Realtor Pro Official Positioning

---

I am building the Realtor Newsletter Agent (Agent 13) inside the LegendsOS Skills system. This agent will generate Realtor-facing newsletters that reference AI Realtor Pro.

To generate accurate, compliance-safe content, I need you to provide the following in a single response:

1. Official name and branding (is it "AI Realtor Pro" or another name?)
2. What it is — one to two sentence plain explanation
3. Who it is built for — audience and use case
4. Core features or workflows it includes
5. What it does not do — limitations and scope
6. Approved marketing language and phrases
7. Language or claims that are not approved for use
8. Any disclaimers or disclosures required when marketing it
9. Any third-party platform integrations that can be mentioned publicly
10. Pricing or subscription model (if public-facing information exists)
11. Current status — live, beta, or coming soon
12. CTA or next step for Realtors interested in learning more

Please be concise but complete. I will use this response to populate the AI Realtor Pro section of the newsletter agent.

---

## Prompt 2 — For Florida Home Buying Network Project

**Send to:** Florida Home Buying Network project or Jeremy's FHBN documentation source

**Subject:** Agent 13 Knowledge Request — Florida Home Buying Network Official Positioning

---

I am building the Realtor Newsletter Agent (Agent 13) inside the LegendsOS Skills system. This agent will generate newsletters that reference the Florida Home Buying Network.

To generate accurate, compliance-safe content, I need you to provide the following in a single response:

1. Official name (is it "Florida Home Buying Network" or another name?)
2. What it is — one to two sentence plain explanation
3. Who it is built for — audience breakdown: buyers, Realtors, or both
4. Value proposition for Realtors specifically
5. Value proposition for buyers
6. How lead flow or referral routing works (general, not proprietary)
7. Approved CTA language for newsletters
8. Approved marketing language and phrases
9. Language or claims that are not approved
10. Any compliance notes for marketing this network
11. Current status — live, pilot, or planned
12. How a Realtor or buyer connects with or enrolls in the network

Please be concise but complete. I will use this response to populate the Florida Home Buying Network section of the newsletter agent.

---

## Prompt 3 — For Loan Factory Guarantee Source

**Send to:** Loan Factory compliance or marketing source, or Jeremy's Loan Factory documentation

**Subject:** Agent 13 Knowledge Request — Price Guarantee Official Language and Terms

---

I am building the Realtor Newsletter Agent (Agent 13) inside the LegendsOS Skills system. This agent will reference Loan Factory's price guarantee in Realtor newsletters.

To use accurate, compliant language, I need you to provide the following in a single response:

1. Exact approved public marketing language for the guarantee (is it "$2,000 Lowest Price Guarantee," "$2,000 Best Price Guarantee," or another phrase?)
2. Dollar amount (is it $2,000 or another amount?)
3. How the guarantee works — plain explanation
4. Eligible loan types
5. Eligible states
6. Excluded states (especially: is Washington state excluded?)
7. Any other exclusions
8. Required disclaimer or disclosure language when marketing the guarantee
9. Terms and conditions URL or source
10. Approved CTA language for the guarantee
11. Whether the guarantee can be promoted to Realtors as a referral advantage
12. Any restrictions on how it can be described in third-party or co-branded marketing

Please be concise but complete. I will use this response to populate the guarantee section of the newsletter agent and remove all [VERIFY] placeholders.

---

## Prompt 4 — For Legends Mortgage Team Bilingual and Investor Expertise Source

**Send to:** Jeremy directly or The Legends Mortgage Team documentation source

**Subject:** Agent 13 Knowledge Request — Bilingual Team and Investor Loan Positioning

---

I am building the Realtor Newsletter Agent (Agent 13) inside the LegendsOS Skills system. This agent will generate bilingual newsletters and investor-focused content on behalf of Jeremy McDonald and The Legends Mortgage Team.

To generate accurate, approved content, I need you to provide the following in a single response:

**Bilingual section:**
1. Official language for communicating the team's bilingual support (who on the team is bilingual?)
2. Spanish-language tagline or positioning line if one exists
3. Approved Spanish CTA language for newsletters
4. Whether all marketing can be produced in Spanish or only specific pieces
5. Any cultural notes relevant to serving the Spanish-speaking Florida buyer market

**Investor and non-QM section:**
6. Which investor loan programs the team actively closes (DSCR, fix and flip, foreign national, commercial, ground-up construction, short-term bridge, other)
7. Minimum or typical deal profile for each program type that can be shared publicly
8. Any foreign national loan notes — documentation required, eligible nationalities, approved language
9. Approved talking points for Realtor education on investor financing
10. Any restrictions on how investor loan programs can be described in marketing

**Deal save stories:**
11. Any approved anonymized deal save stories that can be used in newsletters (brief summary only — I will build the copy)
12. Any restrictions on how deal save stories can be framed

Please be concise but complete. I will use this response to finalize the bilingual and investor sections of the newsletter agent.

---

## Access Note

CoWork cannot directly access private GitHub repos without authentication. See github-access-resolution.md for options.

If local clones exist, paste the paths here and CoWork will read them directly.
If no local clones, the fastest fallback is to ask ChatGPT to paste specific file contents here.

Priority files to request from ChatGPT:
1. AI-Realtor-Pro-Final/app/page.tsx — full file content
2. florida-home-buying-network/pages/Home.tsx — full file content
3. final-jeremy-mcdonald-mtg.com/pages/AiRealtorProPage.tsx — full file content
4. final-jeremy-mcdonald-mtg.com/constants.ts — full file content
5. final-jeremy-mcdonald-mtg.com/public/llms-full.txt — full file content
