# 06 — Geraldine Coordinator Workflow Plan (Follow-Up Board)

**Goal:** Give Geraldine a simple, reliable board for follow-up, document collection, borrower status tracking, missing-item chasing, pipeline updates, Drive folder organization, and quick borrower communication drafts — with a one-tap way to escalate urgent items to Jeremy.

**Design principle borrowed:** herdr's status model (what's blocked vs. handled), paperclip's friendly task-board disguise, Hermes Desktop's draft-first comms, openhuman's escalation concept⚠️ — all LegendsOS-native, draft-only, read-only on Drive.

---

## Geraldine's screen (the Follow-Up Board)

A calm, prioritized list grouped by what the borrower/file needs next:

- **Reach out today (🔴):** leads/borrowers overdue for contact, missing-item chases, expiring items.
- **Waiting on borrower (🟡):** requested docs not yet received (with how long they've been waiting).
- **Handled / recently updated (🔵🟢):** so she can see momentum and not double-chase.

Each row shows: borrower name, loan stage, what's needed, how long it's been waiting, and the next suggested action. One click opens the borrower with the document tracker and a draft-communication tab.

## Feature 1 — Lead & borrower follow-up

- LegendsOS surfaces **who needs contact and why**, prioritized by stage and aging (new lead not contacted, doc requested 3+ days ago, rate-lock/closing approaching).
- For each, a **draft message** (email/SMS text) is pre-written in your brand voice with compliance footer — Geraldine reviews, edits, and sends from her own tools, or queues for approved send. **Never auto-sent.**

## Feature 2 — Document collection & missing-item follow-up

- Shares the same **received/missing tracker** as Ashley's cockpit (one source of truth), but framed for *collection*: who to chase, for what, and a ready draft to ask for it.
- When a borrower uploads to Drive, the item flips from ⚠️ missing to ✅ received automatically (read-only detection) and drops off Geraldine's chase list.
- **Safety:** detection only — LegendsOS does not move or rename anything in Drive.

## Feature 3 — Borrower status tracking & pipeline updates

- A clean per-borrower status (where the file is, what's next) that Geraldine can update, and a **pipeline-update assistant** that drafts the "here's where we are" note for the borrower or realtor.
- Pipeline status writes to LegendsOS (Supabase), not to any lender system. Pushing a status anywhere external is a consequential action → requires approval (see escalation/HITL).

## Feature 4 — Drive folder organization (recommendations only)

- LegendsOS can **recommend** how to tidy a borrower folder (e.g., "these 3 files look like pay stubs — suggest moving to /Income") and present it as a checklist.
- **It does not perform the move.** Per directive, LegendsOS does not modify Google Drive, delete files, or overwrite borrower files. Geraldine (or Jeremy) makes the change; LegendsOS just advises.

## Feature 5 — Basic borrower communication drafts

- One-click drafts for the routine coordinator messages: welcome/intro, document request, gentle reminder, status update, "we're clear to close" prep.
- Voice + compliance from `legendsos-skills/_shared/` (brand-dna voice, RESPA do/don't, CAN-SPAM, NMLS/EHO footer, safe-CTA list).
- All **drafts**. Default is no live send.

## Feature 6 — Escalate to Jeremy (one tap)

- Any item Geraldine flags as urgent moves to Jeremy's command center with full context (borrower, what's wrong, what she tried). Borrowed from openhuman's permission-tier approvals, kept deliberately light — a button, not a workflow engine.
- Optional Telegram ping to Jeremy for true urgencies (alert only — no loan action over chat).

---

## What powers each feature (reuse, don't rebuild)

| Geraldine feature | Reuses (existing) | Borrows (pattern) |
|---|---|---|
| Follow-up board | Supabase + RLS + roles + `StatusPill` | herdr status, paperclip board |
| Follow-up prioritization | Atlas retrieval + AI gateway | aging/priority logic |
| Doc collection/missing | shared tracker (file 05) + Drive read API | AionUi preview |
| Status / pipeline updates | Supabase loan records | paperclip goal/status roll-up |
| Drive org recommendations | Drive read API (read-only) | (advice-only, no writes) |
| Comms drafts | `lib/email/*` + brand/compliance skills | Hermes Desktop gateway + your send-gate |
| Escalation | `permissions.ts` + Telegram alert | openhuman permission tiers |

## Geraldine safety guarantees (plain language)

- Drive is **read-only**: recommend, never move/delete/overwrite.
- All borrower communication is **draft-first**; nothing sends itself.
- No made-up borrower data, contacts, statuses, or guideline claims — unknown is shown as unknown.
- Escalation is a button to a human, not an automated decision.

## Keep it simple

Geraldine should never see connectors, providers, model settings, budgets, or an agent console. Her world is: a prioritized list, a borrower panel, draft buttons, and an "escalate" button. That's it.

---
*Next: `07_GOOGLE_DRIVE_LOAN_BRAIN_INTEGRATION_PLAN.md`*
