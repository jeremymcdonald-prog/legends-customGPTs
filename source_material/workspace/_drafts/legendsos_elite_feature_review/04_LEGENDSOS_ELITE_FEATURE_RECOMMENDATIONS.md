# 04 — LegendsOS Elite Feature Recommendations

How to turn LegendsOSv2.0 into an elite mortgage AI operating system **without** overwhelming loan officers or making Ashley's and Geraldine's jobs harder. Every recommendation reuses something you already have (Atlas, Supabase + RLS, the AI gateway, the n8n bridge, the draft-first `ALLOW_LIVE_*` model, your `legendsos-skills` brand/compliance library) and borrows a proven pattern from the reviewed projects.

**Design north star:** one platform, one brain (Atlas), role-aware surfaces. An LO sees a clean, almost boring app. Ashley sees a powerful-but-simple processing cockpit. Geraldine sees a follow-up and document board. Jeremy sees the full command center. Same engine underneath.

---

## The Top 10 features LegendsOS should borrow (ranked)

1. **Borrower-folder preview panel (from AionUi).** Inline view of PDFs/images/docs from a loan folder without leaving LegendsOS. The backbone of the Drive Loan Brain UI.
2. **Unified tool/MCP registry (from AionUi).** One admin place to connect Drive, Gmail, n8n, Zapier MCP — agents/assistants inherit tools. Extends your existing `mcp_connections` table + Atlas connectors.
3. **Governed pipeline board with budgets (from paperclip).** Each loan = a "goal"; tasks and status roll up; cost/usage visible. Becomes **LoanFlow**.
4. **Blocked / Working / Done / Seen status model (from herdr).** A single "what needs me?" vocabulary across every loan and task. Reimplemented in your stack (don't copy AGPL code).
5. **Draft-first messaging gateway (from Hermes Desktop).** Borrower/lender/processor emails are *drafted*, queued, and only sent through an approved gateway — exactly your `ALLOW_LIVE_EMAIL_SEND` + n8n pattern, given a real 1:1 UI.
6. **Read-only screenshot/vision intake (from UI-TARS).** Jeremy drops a pricing/AUS/lender screenshot; LegendsOS *reads* it into structured text. Vision to read, never to click.
7. **Scheduled, conversation-bound summaries (from AionUi).** "Every morning, summarize my pipeline and what's blocked." Uses your existing n8n webhooks + the new status model.
8. **Surgical human-in-the-loop approvals + escalation (from openhuman's permission tiers, on top of your existing `ALLOW_LIVE_*` send-gate).** Approval only on consequential actions (send, move file, pipeline push) with a one-tap Geraldine→Jeremy escalation. Not gates on everything.
9. **Markdown-defined assistants + skills, compliance-loaded (from AionUi + your own `legendsos-skills/`).** Reuse your brand-DNA, RESPA do/don't, CAN-SPAM, NMLS/EHO footer, guarantee terms as the voice + compliance layer on every draft.
10. **Run trace / audit log (from UI-TARS + paperclip governance).** Every automated action is reviewable step-by-step. Quiet, but it's what makes the whole thing trustworthy for a regulated workflow (and reviewable by Thuan/CEO).

## The Top 10 things NOT to copy (hard "no" list)

1. **Autonomous GUI control of real systems** (UI-TARS computer/browser operators) clicking through lender portals, MOSO, or Drive. Read with vision; act through approved APIs only.
2. **YOLO / Full-Auto "approve everything" modes** (AionUi). Never for loan files.
3. **AGPL code from herdr** copied into LegendsOS. Borrow the concept; reimplement.
4. **`embedded-postgres`** (paperclip) — stay on Supabase Postgres; one data model, one RLS surface.
5. **A second agent runtime/brand running inside LegendsOS** (Hermes Agent / Nous loop, AionUi's bundled agent). Atlas stays the single brain.
6. **Heavyweight multi-agent orchestration frameworks** (OpenSwarm⚠️) as a dependency. You already have intent + retrieval + toolRouter.
7. **Exposing any third-party UI** (paperclip board, Hermes Desktop tabs, AionUi panes, terminals) to users. Rebuild as LegendsOS-native components.
8. **Remote chat-platform control of loan operations** (AionUi Telegram/WeChat/DingTalk acting on files). Telegram is fine for *alerts to Jeremy*, not for operating on borrower data.
9. **"Self-improving" auto-learning loops** touching compliance/marketing copy. Humans approve compliance text.
10. **A graph database for v1** (GitNexus⚠️ style). Plain Atlas retrieval is enough; revisit only if a real need appears.

---

## How the borrowed ideas map onto your existing architecture

| Borrowed idea | Where it plugs into LegendsOS today |
|---|---|
| Preview panel | New component in **Atlas** workspace + a Drive read API route |
| Tool/MCP registry | Extend `mcp_connections` table + `components/settings/MCPConnections.tsx` + Atlas `ConnectorPanel` |
| Pipeline board + budgets | New **LoanFlow** module (`loanflow/` is already reserved) on Supabase; reuse `DAILY_CAP_*`/`ALLOW_PAID_*` |
| Status model | New `loan_status` / `task_status` enums in Supabase; render with existing `StatusPill` component |
| Draft-first gateway | Extend `lib/email/*` + `app/api/email/*` + `ALLOW_LIVE_EMAIL_SEND` + `N8N_WEBHOOK_EMAIL_SEND` into a **Hermes** 1:1 surface |
| Vision intake | New `app/api/ai/vision` route on the existing AI gateway (`lib/ai/providers.ts`) |
| Scheduled summaries | Existing n8n webhooks + `lib/automation/*` + `/api/automation/callback` |
| HITL approvals + escalation | New lightweight `approvals` table + the existing `permissions.ts`/roles + Telegram alert to Jeremy |
| Assistants + compliance | Seed Atlas assistants from `LegendsOS Skills & CustomGPT Assist Builder/legendsos-skills/` (script already exists: `seed-atlas-assistants-from-local.ts`) |
| Audit/trace | New `activity_log` table; write on every consequential action |

## Role-aware surfaces (so nobody is overwhelmed)

- **Loan Officer (default):** Dashboard + Atlas (ask questions, get education/scripts) + their own loans on a simple board. No admin, no connectors, no agent console. Clean and calm.
- **Ashley (processor):** A **processing cockpit** — incoming processor handoffs, document received/missing tracker, condition-response drafts, one-click "draft Ashley email." Powerful, few clicks, no jargon.
- **Geraldine (coordinator):** A **follow-up board** — leads/borrowers needing contact, missing-item chases, status updates, Drive folder organization prompts, one-tap "escalate to Jeremy." Drafts only; never auto-sends.
- **Jeremy (command center):** Everything — Drive Loan Brain, vision intake, condition/overlay tools, marketing, training, AI automation, audit log, budgets, admin.

Roles already exist (`extend_user_roles` migration, `lib/permissions.ts`, impersonation). We're adding *views*, not a new auth system.

## The "elite" bar, concretely

LegendsOS becomes elite when Jeremy can **drop in a screenshot, a 3.4, or an AUS finding and get back a clean loan summary, a processor handoff for Ashley, a borrower missing-item list, a condition-response plan, a compliant draft email, a lender overlay risk note, and a pipeline update** — all reviewable, all approved before anything leaves the building, all on the platform he already has. The reviewed projects show this is achievable by borrowing UX and governance patterns, not by adding runtimes.

---
*Next: `05_ASHLEY_FLO_PROCESSING_WORKFLOW_PLAN.md`*
