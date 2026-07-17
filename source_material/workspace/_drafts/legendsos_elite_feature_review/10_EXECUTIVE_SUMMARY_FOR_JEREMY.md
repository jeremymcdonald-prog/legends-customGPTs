# 10 — Executive Summary for Jeremy

**Prepared for:** Jeremy McDonald (and clean enough for Thuan/CEO to review)
**Subject:** What LegendsOS can safely borrow from 9 open-source projects to become an elite mortgage AI operating system
**Status:** Review only. Nothing was built, committed, pushed, or deployed. No secrets opened. Drive untouched.

---

## The short version

LegendsOSv2.0 is already a real platform, not a prototype. It is a Next.js app on Supabase, deployed on Netlify, with a working Atlas AI workspace, an AI provider gateway, an n8n automation bridge, and, importantly, a draft-first, gated-send safety model already wired in. What it is missing is the entire mortgage layer... Google Drive loan files, a borrower/loan data model, document reading, and processor/coordinator workflows. That is actually the perfect place to be. The foundation is strong, and the mortgage brain is a clean build on top of it.

I reviewed nine open-source projects. None of them is mortgage software. Their value is proven patterns I can borrow without turning LegendsOS into a stitched-together mess, and without exposing any third-party UI to my team.

## What I reviewed

- **The live repo:** `jeremymac904/LegendsOSv2.0` (cloned fresh) plus the local working copy.
- **The handoff doc:** the Drive-based Jeremy Applicants Pipeline, Ashley and Geraldine workflows, UW Guides, and borrower folder plan.
- **The local folders:** `_drafts`, `hermes`, `infra`, `legendsos`, `loanflow`, `tools` (most are empty placeholders that map to the intended roadmap), plus my real `LegendsOS Skills & CustomGPT Assist Builder` library (brand DNA + compliance packs I should reuse).
- **Nine archives, all unzipped and read at file level:** AionUi, UI-TARS Desktop, Hermes Desktop, herdr, paperclip, GitNexus, OpenSwarm, multica, openhuman.

Full detail is in files 01 through 09. Ten markdown files were created in `_drafts/legendsos_elite_feature_review/`.

## Top 10 features LegendsOS should borrow

1. **Borrower-folder preview panel** (AionUi) — read loan PDFs/images inside LegendsOS.
2. **Unified tool/MCP registry** (AionUi + openhuman's typed-tool-per-integration) — one place to connect Drive, Gmail, n8n, Zapier.
3. **Governed pipeline board with budgets** (paperclip) — every loan is a goal; status and cost roll up. This becomes LoanFlow.
4. **Blocked / Working / Done / Seen status model** (herdr) — one "what needs me?" language across the whole pipeline.
5. **Draft → approve → send comms model** (Hermes Desktop gateway + my existing `ALLOW_LIVE_EMAIL_SEND`/n8n, with openhuman-style approvals) — the safe model for Ashley and Geraldine email.
6. **Memory graph per borrower** (openhuman) — the Loan Brain remembers each file's docs, conditions, and history.
7. **Permission tiers + chat approvals** (openhuman) — approval only on consequential actions, never on everything.
8. **Read-only screenshot/vision intake** (UI-TARS) — drop a pricing or AUS screenshot, get structured text. Read, never click.
9. **Scheduled, conversation-bound summaries** (AionUi) — "every morning, tell me what's blocked."
10. **Run trace / audit log** (UI-TARS + paperclip governance) — every automated action is reviewable. This is what makes it trustworthy for a regulated workflow.

## Top 10 things NOT to copy

1. Autonomous GUI/computer control of real systems (UI-TARS operators). Vision reads, it does not click.
2. YOLO / full-auto "approve everything" modes (AionUi).
3. **GitNexus code** — its license is PolyForm Noncommercial, so it is a personal dev aid only, not something I embed.
4. **herdr code** — AGPL copyleft. I borrow the status concept and reimplement it.
5. `embedded-postgres` (paperclip) or any parallel datastore — I stay on Supabase, and n8n already handles my queue/send.
6. A second agent brain inside LegendsOS (Hermes Agent loop, AionUi's bundled agent, openhuman's agent). Atlas stays the one brain.
7. Heavyweight orchestration frameworks as product dependencies (OpenSwarm in the product). I already have intent + retrieval + tool routing.
8. Any third-party UI exposed to my team (paperclip board, Hermes tabs, AionUi panes, terminals).
9. Acting on borrower data over chat platforms (Telegram for alerts to me only).
10. A graph database for v1 (GitNexus style). Atlas retrieval is enough.

## Recommended next build phase

**Build Phases 1 and 2 first:** the mortgage data model on Supabase (loans, borrowers, documents, conditions, contacts, status, tasks, approvals, audit), then a **read-only Google Drive borrower-file browser with inline preview inside Atlas.** It is small, safe (read-only, nothing sends, no Drive writes), deployable on Netlify/Vercel with no local runtime, and it proves the Loan Brain foundation. Everything else stacks on it. Full sequence in file 08.

## Email setup before or after the Drive Loan Brain?

**After.** Do the Drive Loan Brain (read-only browse and summary) first. The valuable emails (Ashley's processor emails, Geraldine's follow-ups, condition responses, missing-item requests) are only good when they are filled with real loan facts, and those facts come from Drive. My repo already has the draft-first email plumbing, so email is not the hard part... context is. Build the context source first, then turn on the email generators on top of it, with live send staying off until last and behind human approval. (One nuance: I can scaffold the empty "Hermes" composer shell in parallel, but I will not wire real borrower email generation until the Loan Brain can supply accurate data.)

## Blockers / what I need to confirm before building

1. **Which Google identity** owns the Drive connection (Loan Factory corporate vs. mcdonald-mtg.com), and that the "Jeremy Applicants Pipeline" folder is shared read-only to it.
2. **The canonical borrower-folder structure** in Drive, so document classification is reliable (proposed structure in file 07).
3. **The expected-document checklist per loan program**, so "missing items" are accurate.
4. **Which connection path** to standardize on for read-only Drive (Google Workspace OAuth, Google Drive MCP, or Zapier MCP).
5. (Minor, already resolved) During review, four archives collided on a parallel unzip and were re-extracted sequentially. The build scripts should run IO sequentially to avoid the same thing.

No blocker stops the recommended first build. Items 1 through 4 are inputs I need at the start of Phase 2.

## The exact next prompt to run after reviewing this report

> **"LegendsOS Build, Phase 1 + 2. Do not deploy, do not commit, do not send anything. On a new feature branch only: (1) design and add Supabase migrations for the mortgage data model (loans, borrowers, loan_documents, loan_conditions, loan_contacts, loan_status, tasks, approvals, activity_log) with RLS from the start and role scoping for LO / Ashley / Geraldine / Jeremy; (2) build a READ-ONLY Google Drive borrower-file browser inside Atlas with inline preview, using <chosen Drive path> with the narrowest read scope, pointed at the Jeremy Applicants Pipeline folder. No writes to Drive, no live email, no live social, no n8n live runs. Reuse lib/atlas, lib/ai, mcp_connections, and the existing draft-first model. Show me the migration files and the browser as a preview before anything is merged. Confirm the borrower-folder structure with me before indexing."**

Adjust `<chosen Drive path>` once you answer blocker #4.

---

Let me know what you'd like me to do next.
