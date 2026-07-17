# 08 — Next Build Sequence

**Principle:** Keep the first useful build simple, practical, and production-minded. No Docker/Cloudflare/local-Mac requirement. Ship read-only and draft-first. Each phase is independently valuable and safe to stop on.

---

## The ordering question, answered

**"Should the Team AI Assistant Email Setup happen before or after the Google Drive Loan Brain integration?"**

**After — do the Drive Loan Brain (read-only browse + summary) first.** Here's the plain reasoning:

- The valuable emails (Ashley's processor emails, Geraldine's follow-ups, condition responses, missing-item requests) are only good if they're **filled with real loan facts** — borrower name, loan number, what's missing, which condition. That data comes from the **Drive Loan Brain**. Turning on email first means drafting blind.
- Your repo **already has** the draft-first email plumbing (`lib/email/*`, `app/api/email/*`, `ALLOW_LIVE_EMAIL_SEND` default-off, `N8N_WEBHOOK_EMAIL_SEND`). So email isn't the hard part — **context is**. Build the context source first.
- Doing Drive first also de-risks the scary part (live sending) by leaving it off until everything upstream is trustworthy and reviewable.

**The one nuance:** you can *scaffold* the draft-only email surface (the "Hermes" 1:1 composer) in parallel as a low-risk shell, but do **not** wire real borrower/processor email generation until the Drive Loan Brain can supply accurate facts. So: **Drive read-only foundation → loan data → then email generators on top.** Live send stays off until last and behind human approval.

---

## Phase 0 — Foundations already done ✅ (no work)

Next.js + Supabase + RLS + roles + AI gateway + Atlas (intent/retrieval/toolRouter) + n8n bridge + draft-first flags + Netlify deploy. You're starting from a real platform, not zero.

## Phase 1 — Mortgage data model (small, safe, enabling)

- Add Supabase tables: `loans`, `borrowers`, `loan_documents`, `loan_conditions`, `loan_contacts`, `loan_status`, `tasks`, `approvals`, `activity_log`. RLS from day one (you already enforce RLS).
- Add role-scoped views scaffolding (LO / Ashley / Geraldine / Jeremy) using existing `permissions.ts`.
- **Acceptance:** a loan can be created and viewed by the right roles only; nothing borrower-real yet (test data clearly marked).

## Phase 2 — Google Drive Loan Brain: connect + browse (read-only)

- Drive connector (read-only scope) via existing OAuth/MCP; reuse `mcp_connections` + Atlas `ConnectorPanel`.
- Borrower file browser + inline preview (AionUi pattern) inside Atlas.
- **Acceptance:** open "Jeremy Applicants Pipeline," open one borrower folder, preview a PDF — all read-only. No writes anywhere. (See file 07 Phase A–B.)

## Phase 3 — Loan Brain: index + search + summary

- Index metadata + extracted text into Supabase (RLS). Active-loan search + borrower-folder summary via Atlas retrieval.
- **Acceptance:** "find the Smith VA loan" and "summarize this borrower folder" return accurate, sourced results; unknowns marked unknown.

## Phase 4 — Trackers + Processor Handoff + status board

- Received/missing tracker (vs. program checklist) + the 21-field processor-handoff generator (file 05).
- LoanFlow pipeline board with the **blocked/working/done/seen** status model (herdr) and budgets visibility (paperclip), built on Supabase with your `StatusPill`.
- **Acceptance:** Ashley sees a clean cockpit; a handoff generates with every field sourced or clearly marked "not found."

## Phase 5 — Conditions + guidelines + overlays

- Condition-response builder + UW Guides / Loan Factory Loan Brain guideline search (cited) + lender overlay risk note.
- **Acceptance:** each condition shows a cited response plan; guideline answers cite sources; agency vs. lender clearly separated.

## Phase 6 — Hermes draft-first email + pipeline assistant

- Ashley/Geraldine email generators + pipeline-update assistant, brand+compliance loaded from `legendsos-skills/_shared/`.
- **Live send stays OFF** (`ALLOW_LIVE_EMAIL_SEND=false`) until a human-approval step + audit log are verified; then enable through the existing n8n webhook only.
- **Acceptance:** drafts are accurate and compliant; sending requires explicit human approval and is logged.

## Phase 7 — Vision intake + scheduled summaries (elite polish)

- Read-only screenshot/vision intake (pricing/AUS/lender) via a new `/api/ai/vision` route on the existing gateway.
- Scheduled morning pipeline summary (AionUi pattern) via existing n8n webhooks.
- **Acceptance:** drop a screenshot → structured text into a loan; "what's blocked this morning?" arrives on schedule.

## Phase 8 — Role polish + audit + CTO-grade reporting

- Final LO/Ashley/Geraldine/Jeremy view polish; complete `activity_log` audit trail; a clean status report Thuan (CEO) could review.
- **Acceptance:** each role sees only what they need; every consequential action is logged and reviewable.

---

## The recommended FIRST build (smallest useful, production-minded)

**Phases 1 + 2:** the mortgage data model + a **read-only Google Drive borrower-file browser with inline preview inside Atlas.** It's simple, it's safe (read-only, no sends, no Drive writes), it's production-deployable on Netlify/Vercel with no local runtime, and it immediately proves the Loan Brain foundation. Everything else stacks on it.

## Guardrails carried through every phase

Read-only Drive · draft-first email (send off by default) · no invented data or citations · agency ≠ lender approval · no borrower data in GitHub · no secrets printed/committed · least-privilege scopes · human approval + audit log on consequential actions · LOs never overwhelmed (role-scoped views).

---
*Next: `09_RISKS_AND_DO_NOT_BUILD_LIST.md`*
