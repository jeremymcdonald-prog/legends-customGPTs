# 05 — Ashley Processing Workflow Plan (Processor Cockpit)

**Goal:** Make Ashley's processing work as easy as possible while being extremely capable. Ashley should open LegendsOS and immediately see what's on her plate, get clean handoffs, and draft (never auto-send) the right emails in a couple of clicks. No jargon, no agent console, no setup.

**Design principle borrowed:** paperclip's "it looks like a task manager" + herdr's blocked/working/done/seen status + Hermes Desktop's draft-first gateway + AionUi's inline document preview. Built LegendsOS-native on Supabase.

---

## Ashley's screen (the Processing Cockpit)

A single board with three columns and a detail panel:

- **Needs Ashley (🔴 blocked):** files waiting on her next action.
- **In progress (🟡 working):** files she's actively processing.
- **Done / submitted (🔵🟢):** recently completed, newest first.

Clicking a loan opens the **borrower detail panel** with the document tracker, the handoff, condition responses, and an "email" tab — all in one place (AionUi-style preview so she can read the actual PDFs without downloading).

## Feature 1 — Processor Handoff Generator (the centerpiece)

When Jeremy (or the Loan Brain) hands a file to Ashley, LegendsOS generates a **clean, complete handoff** with exactly these fields (from the handoff doc):

- Borrower name
- Loan number
- Loan program
- Loan purpose
- Property address
- Lender
- TPO portal link
- AE contact
- Account manager contact
- Support desk contact
- Realtor contact
- Title contact
- HOI contact
- Fannie Mae 3.4 file (link)
- AUS findings (summary)
- Documents received
- Documents missing
- Known conditions
- Known risks
- Priority next steps
- Google Drive borrower folder link

**How it's built:** the Loan Brain reads the borrower's Drive folder (read-only) + the 3.4 + AUS, fills the template, and presents it for Jeremy's one-tap approval before it lands in Ashley's "Needs Ashley" column. **LegendsOS never invents a value** — any field it can't source is shown as "❓ not found — confirm," never guessed. (Directive: do not invent borrower data, do not treat agency findings as lender approval.)

## Feature 2 — Documents Received / Missing Tracker

- The Loan Brain classifies what's in the Drive borrower folder and checks it against the program's expected document list.
- Ashley sees two clean lists: **Received ✅** and **Missing ⚠️**, each item linking to the actual file (preview inline).
- Missing items can be turned into a **borrower request draft** (Feature 4) with one tap.
- **Safety:** classification is a suggestion; Ashley confirms. Nothing is moved or deleted in Drive (read-only). Borrower docs are never overwritten.

## Feature 3 — Underwriting Condition-Response Builder

- For each known condition, LegendsOS drafts a **response plan**: what the condition is asking, which document/explanation satisfies it, and a draft cover note.
- Pulls guideline language from **UW Guides / Loan Factory Loan Brain** (see file 07) and shows the citation source.
- **Hard rule:** LegendsOS does **not** invent guideline citations and does **not** treat an AUS/agency finding as lender approval. Every guideline claim shows where it came from; anything unsourced is flagged for human verification.

## Feature 4 — Ashley Email Generator (draft-first)

- One-click drafts for the common processor emails: missing-item request to borrower, status update, condition-package cover note to the lender/AE, title/HOI follow-ups.
- Voice + compliance come from your existing `legendsos-skills/_shared/brand-dna` (voice) and `_shared/knowledge` (CAN-SPAM block, RESPA do/don't, NMLS/EHO footer, safe-CTA list).
- **Every email is a draft.** It goes to a review step and only sends through the approved gateway when `ALLOW_LIVE_EMAIL_SEND` is on and a human approves (your existing `N8N_WEBHOOK_EMAIL_SEND` path). Default = draft only. (Directive: do not run live email / do not send Gmail.)

## Feature 5 — "What needs me?" + escalation

- The 🔴 column is Ashley's to-do, auto-prioritized by the Loan Brain (rate-lock expirations, aging conditions, closing dates).
- A one-tap **"flag for Jeremy"** moves an item to Jeremy's command center with context attached (borrowed from openhuman's permission-tier approvals, kept light).

---

## What powers each feature (reuse, don't rebuild)

| Ashley feature | Reuses (existing) | Borrows (pattern) |
|---|---|---|
| Processing cockpit board | Supabase + RLS + roles + `StatusPill` | paperclip board, herdr status model |
| Handoff generator | Atlas retrieval + AI gateway | (LegendsOS-native template) |
| Document tracker | Drive read API (new) + Atlas | AionUi preview + classification |
| Condition builder | Knowledge module + Atlas retrieval | guideline-cited drafting |
| Email generator | `lib/email/*`, `ALLOW_LIVE_EMAIL_SEND`, n8n send | Hermes Desktop gateway + your existing send-gate |
| Escalation | `permissions.ts` + Telegram alert | openhuman permission tiers |

## Ashley safety guarantees (in plain language)

- Drive is **read-only** — LegendsOS never moves, renames, deletes, or overwrites a borrower file.
- Emails are **drafts** until a human approves; default is no live send.
- LegendsOS **never makes up** a contact, a document status, a number, or a guideline citation — missing = clearly marked missing.
- Agency/AUS findings are **never** shown as lender approval.

## What to confirm before building Ashley's cockpit

1. The **expected-document checklist per program** (so "missing" is accurate). Source from Loan Factory / your UW Guides.
2. The **canonical borrower-folder structure** in Drive (so classification is reliable) — see file 07.
3. Which **contacts** (AE, account manager, title, HOI, realtor) live where, so the handoff can populate them.

---
*Next: `06_GERALDINE_COORDINATOR_WORKFLOW_PLAN.md`*
