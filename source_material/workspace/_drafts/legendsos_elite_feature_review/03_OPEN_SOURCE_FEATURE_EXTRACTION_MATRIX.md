# 03 — Open-Source Feature Extraction Matrix

**Rule of the road:** LegendsOS stays the platform. We **borrow patterns and ideas**, we do **not** bolt these apps on, expose their UIs, or make any of them a runtime dependency. Nothing here requires Docker, Cloudflare tunnels, or a local Mac to run in production.

Legend — **Risk** = product/compliance/security risk of borrowing it. **Complexity** = effort to adapt the idea into LegendsOS.

---

## Category coverage at a glance (the 20 review lenses)

| # | Category | Strongest source(s) |
|---|---|---|
| 1 | Agent orchestration | paperclip, multica, OpenSwarm (orchestrator + specialists), AionUi (Team Mode) |
| 2 | Desktop control | UI-TARS Desktop |
| 3 | Browser control | UI-TARS Desktop (browser operator) |
| 4 | Local file indexing | AionUi (file mgmt), openhuman (memory graph), paperclip (file watch) |
| 5 | Repository review | GitNexus (code knowledge graph) |
| 6 | AI workspace UI | **AionUi** (best), Hermes Desktop, paperclip, multica |
| 7 | Multi-agent task routing | paperclip, multica (Squads), OpenSwarm (orchestrator routing), AionUi (Leader/Teammate) |
| 8 | Knowledge graph / memory | **openhuman** (memory graph), GitNexus (code graph), Hermes Desktop (memory) |
| 9 | Automation runners | AionUi (scheduled tasks), multica (Autopilots/cron), Hermes Desktop (schedules) |
| 10 | Human-in-the-loop | **openhuman** (permission tiers + chat approval), AionUi (approval gates), paperclip (approve & run), herdr (blocked state) |
| 11 | Local app shell | **AionUi**, Hermes Desktop, openhuman (Tauri), UI-TARS (Electron main/renderer/shared) |
| 12 | Tool registry design | **AionUi** (unified MCP), **openhuman** (typed tool per integration), paperclip (MCP server) |
| 13 | Screenshot & vision | UI-TARS (visual grounding) |
| 14 | Document parsing | *(gap — none of the 9 is a parser; use the AI gateway's LLM/vision extraction)* |
| 15 | FS workspace navigation | **AionUi** (file panel + preview), paperclip |
| 16 | Project dashboard | **paperclip** (org/board/budgets), **multica** (board/Squads/Autopilots), Hermes Desktop (kanban) |
| 17 | Google-Drive-style workflow | *(gap — closest patterns: AionUi file panel + paperclip board + openhuman integrations)* |
| 18 | Processor-focused task automation | **paperclip** (board/goals), **multica** (board/autopilots), openhuman (approvals) |
| 19 | Mortgage ops workflow | *(none are mortgage — map patterns, see files 05–07)* |
| 20 | Safe email draft/response | **Hermes Desktop** (gateways) + LegendsOS's own `ALLOW_LIVE_EMAIL_SEND` model, with **openhuman** approval-before-send |

---

# Verified projects (read at file level)

## 1) AionUi

- **Project name:** AionUi
- **Local folder reviewed:** `_unzipped/AionUi/AionUi-main`
- **Likely original GitHub source:** `github.com/iOfficeAI/AionUi` (Apache-2.0)
- **What it appears to do:** A free, cross-platform **desktop "Cowork" app** (Electron · Vite · React · Bun) where AI agents work alongside you with full file access — read/write files, web search, image gen, MCP tools. Ships a built-in agent **and** auto-detects external CLI agents (Claude Code, Codex, Qwen, etc.) through ACP, exposing them in one interface. Data is stored locally in **SQLite** (`better-sqlite3`); nothing is uploaded.
- **Best ideas worth borrowing:**
  - **Unified MCP management** — configure MCP tools once, sync to all agents. This is the model for a LegendsOS tool registry (one place to manage Drive, Gmail, n8n, Zapier MCP).
  - **Preview panel** — render PDF/Word/Excel/PPT/code/Markdown/HTML/images/Diff inline without leaving the app. Exactly what a borrower-folder viewer needs.
  - **Scheduled tasks** (cron / interval / one-time, conversation-bound) — pattern for "every morning, summarize my pipeline."
  - **Team Mode** (Leader breaks work into subtasks → Teammates run in parallel, each with its own permission dialog + pending-approval badge). Clean multi-agent UX with per-action approval.
  - **Assistant + 3-tier skill system** (built-in / custom / extension) defined by markdown — mirrors your existing `legendsos-skills/` library.
- **What not to copy:** **YOLO / Full-Auto mode** (auto-approve everything) — the opposite of mortgage safety. Remote control via Telegram/WeChat/DingTalk for *operations on loan files*. Giving any agent unrestricted local file access. The 21-assistant sprawl — LOs need few, focused tools.
- **Risk level:** Medium (powerful file/agent access; safe if you borrow the approval UX and skip auto-run).
- **Complexity level:** Medium to adapt patterns (High to fork the whole app — don't).
- **Best LegendsOS use case:** The **Atlas command-center UX** for Jeremy — multi-pane workspace, inline document preview of borrower files, unified MCP/tool registry, and a per-action approval badge.
- **Suggested implementation phase:** Phase 2–3 (preview panel + tool registry), Phase 4 (scheduled summaries).
- **Recommended action:** **Borrow patterns** — preview panel, unified MCP registry, per-action approval UX, markdown-defined assistants. Do not fork.

## 2) UI-TARS Desktop

- **Project name:** UI-TARS Desktop (and the sibling "Agent TARS")
- **Local folder reviewed:** `_unzipped/UI-TARS-desktop/UI-TARS-desktop-main`
- **Likely original GitHub source:** `github.com/bytedance/UI-TARS-desktop` (Apache-2.0)
- **What it appears to do:** An Electron monorepo (pnpm + turbo) for a **GUI agent that controls your computer and browser using natural language**, driven by a vision-language model (UI-TARS). Ships local + remote "computer operators" and "browser operators," an agent SDK (`@ui-tars/sdk`), an action parser, and replay/trace.
- **Best ideas worth borrowing:**
  - **Visual grounding / screenshot understanding** — reading a screenshot and extracting structured meaning. Directly useful for "Jeremy drops a lender pricing screenshot / AUS screenshot → LegendsOS reads it."
  - **Run replay & trace** — every agent run is reviewable step-by-step. Great audit pattern for any consequential automation.
  - **Operator abstraction** — a clean boundary between "the brain" and "the thing it acts on."
- **What not to copy:** **Autonomous computer/browser control of real systems** (clicking around lender portals, MOSO, Drive on the user's behalf). That is high-risk for a regulated mortgage workflow and conflicts with "don't make local Mac runtime required." Use vision **to read**, not to **act**.
- **Risk level:** **High** (auto-GUI control + reliance on a specific VLM + native OS permissions).
- **Complexity level:** High.
- **Best LegendsOS use case:** **Read-only vision** — turn screenshots (pricing, AUS findings, lender conditions, title/HOI emails) into structured text for the Loan Brain. Borrow the trace/replay idea for automation auditing.
- **Suggested implementation phase:** Phase 4+ (vision intake), study-only for the control parts.
- **Recommended action:** **Study + borrow the vision-reading and trace concepts only.** Do not adopt GUI automation.

## 3) Hermes Desktop

- **Project name:** Hermes Desktop
- **Local folder reviewed:** `_unzipped/hermes-desktop/hermes-desktop-main`
- **Likely original GitHub source:** `github.com/fathah/hermes-desktop` (MIT) — a desktop client for Nous Research's "Hermes Agent."
- **What it appears to do:** A native desktop app (Electron · React · `better-sqlite3`) to install, configure, and chat with an AI agent. Runs the backend **locally (`127.0.0.1:8642`) or against a remote API + key**. Multi-provider (OpenRouter, Anthropic, OpenAI, Gemini, xAI, Groq, local LM Studio/Ollama). Clean GUI for **chat, sessions, profiles, memory, skills, tools, scheduling, messaging gateways, kanban, persona, and "office."** Streaming UI with token/cost tracking. Source is split `src/main` · `src/preload` · `src/renderer` · `src/shared`.
- **Best ideas worth borrowing:**
  - **The "Hermes" framing itself** — your repo already reserves a `hermes/` folder and has a `legendsos-atlas-hermes-engineer` agent. This is the blueprint for the LegendsOS comms/assistant engine.
  - **Local-or-remote backend toggle** — develop locally, run production remotely with URL + key. Good for "don't require local Mac in prod."
  - **Profiles + persona + memory + skills + tools as first-class GUI tabs** — exactly the surface Jeremy's command center wants.
  - **Messaging gateways** pattern (a controlled bridge to chat platforms) — the safe shape for "draft outbound, route through an approved gateway," not direct send from the client.
  - **Token/cost tracking in the footer** — pairs perfectly with your existing `DAILY_CAP_*` flags.
  - **Clean Electron `main/preload/renderer/shared` split** — the reference structure if you ever harden the LegendsOS desktop wrapper.
- **What not to copy:** Don't adopt a *second* agent runtime/brand inside LegendsOS — borrow the structure, keep Atlas as the brain. Don't expose raw provider/model/gateway config to LOs (admin-only). Avoid the "self-improving agent" auto-learning loop for anything that touches compliance text.
- **Risk level:** Low–Medium (it's a well-structured local client; risk is scope creep / running a parallel brain).
- **Complexity level:** Medium.
- **Best LegendsOS use case:** Reference architecture for the **Hermes comms module** and for the **draft-first messaging gateway** behind Ashley/Geraldine email generators.
- **Suggested implementation phase:** Phase 3 (Hermes comms patterns), Phase 5 (gateway hardening).
- **Recommended action:** **Borrow architecture + gateway/cost-tracking patterns** for the Hermes module. Don't run it as a second brain.

## 4) herdr

- **Project name:** herdr
- **Local folder reviewed:** `_unzipped/herdr/herdr-master`
- **Likely original GitHub source:** `github.com/ogulcancelik/herdr` (AGPL-3.0-or-later, commercial license available)
- **What it appears to do:** A **single Rust binary terminal multiplexer built for AI agents** ("tmux for agents"). Workspaces/tabs/panes, mouse-native, detach/reattach, session persistence. Its standout feature is **agent state awareness** — a sidebar showing each agent as 🔴 blocked (needs input/approval) / 🟡 working / 🔵 done / 🟢 idle — plus a **local socket API** so agents can create workspaces, spawn helpers, and wait on state changes. No GUI app, no Electron.
- **Best ideas worth borrowing:**
  - **The four-state status model (blocked / working / done / seen).** This is the perfect mental model for a LegendsOS "what needs me?" board across loan files: 🔴 needs a human (a condition response to approve), 🟡 agent working, 🔵 done-unseen, 🟢 handled.
  - **"Blocked = needs input/approval" as a first-class state** — bakes human-in-the-loop into the status itself rather than as a separate gate.
  - **Roll-up of most-urgent state** so you can scan a long list at a glance — ideal for Geraldine's pipeline view.
- **What not to copy:** It's a **terminal** tool and **AGPL** (viral copyleft). Do **not** vendor its code into LegendsOS (license risk) and do not expose a terminal to LOs/Ashley/Geraldine. The licensing means: **borrow the concept, write your own implementation.**
- **Risk level:** Low as a concept; **High if you copy code** (AGPL).
- **Complexity level:** Low (the idea is simple to reimplement).
- **Best LegendsOS use case:** The **status vocabulary** for the pipeline/"needs attention" board (files 05–06). Reimplement in your stack; don't import.
- **Suggested implementation phase:** Phase 2 (status model in the pipeline board).
- **Recommended action:** **Study only; reimplement the status model.** Do not copy AGPL code.

## 5) paperclip

- **Project name:** paperclip
- **Local folder reviewed:** `_unzipped/paperclip/paperclip-master`
- **Likely original GitHub source:** `github.com/paperclipai/paperclip` (MIT)
- **What it appears to do:** A **Node.js server + React UI that orchestrates teams of AI agents to "run a business."** Tagline: "If OpenClaw is an employee, Paperclip is the company." Looks like a task manager/kanban; under the hood it does org charts, **budgets, governance, goal alignment, and agent coordination.** Bring-your-own-agent via a heartbeat (OpenClaw, Claude Code, Codex, Cursor, Bash, HTTP). Stack: `embedded-postgres` + `drizzle-orm`, `express`, `better-auth`, `chokidar`, `ws`, a `@paperclipai/mcp-server` package, `pino` logging. "Manage from your phone."
- **Best ideas worth borrowing:**
  - **Goal → board → approve & run → monitor** loop with **budgets and governance** baked in. This is the cleanest template for a **pipeline/operations dashboard** where each loan is a "goal," tasks roll up, and cost/usage is visible.
  - **"It looks like a task manager"** — the right disguise. LOs/Ashley/Geraldine should see a friendly board, not an agent console.
  - **Bring-your-own-agent via heartbeat/adapters** — a tidy adapter pattern for plugging Claude/OpenClaw/n8n into one board.
  - **MCP server package + adapter-utils** — a real example of exposing your own tools over MCP.
  - **Budget enforcement** — pairs with your `DAILY_CAP_*`/`ALLOW_PAID_*` flags.
- **What not to copy:** The "fully autonomous company running 24/7" ambition — too much autonomy for borrower files. `embedded-postgres` (you're standardized on Supabase Postgres — keep it). Don't expose the raw Paperclip UI; borrow the board *concept* into LegendsOS components.
- **Risk level:** Medium (autonomy ambition; keep humans in the loop for loan actions).
- **Complexity level:** Medium.
- **Best LegendsOS use case:** The **LoanFlow pipeline dashboard** and **processor task board** — goals (loans), tasks, approvals, budgets, status roll-up — rendered as LegendsOS-native components on Supabase.
- **Suggested implementation phase:** Phase 2–3 (pipeline + processor board).
- **Recommended action:** **Borrow the dashboard/governance/budget patterns**; build on Supabase, not embedded-postgres. Don't expose its UI.

---

# Additional verified projects (re-extracted and confirmed at file level)

> These four had a parallel-unzip collision on the first pass; they were **re-extracted sequentially and read** (READMEs, `package.json`, licenses, source tree). Everything below is confirmed, not inferred. Two of them (**multica**, **openhuman**) turned out to be far more relevant to the mortgage build than their names suggest.

## 6) GitNexus

- **Project name:** GitNexus
- **Local folder reviewed:** `_unzipped/GitNexus/GitNexus-main` (3,348 files)
- **Likely original GitHub source:** `github.com/abhigyanpatwari/GitNexus`. **License: PolyForm Noncommercial 1.0.0** ⚠️ (free for non-commercial use only; commercial use needs a separate license).
- **What it does:** "Building a nervous system for agent context." Indexes any codebase into a **knowledge graph** (every dependency, call chain, cluster, execution flow) and exposes it through smart **MCP tools** so AI coding agents (Cursor, Claude Code, Codex, etc.) get full architectural awareness. Two modes: a **browser Web UI** (Tree-sitter WASM + KuzuDB/LadybugDB WASM + in-browser embeddings via transformers.js, ~5k-file limit) and a **CLI + MCP** (native Tree-sitter + persistent graph DB). 12 languages. A "Graph RAG" agent.
- **Best ideas worth borrowing:** Pre-computing a **structured graph for reliable retrieval** (vs. ad-hoc search); **MCP-native tool exposure**; the principle that "even smaller models get full clarity with the right context." For Jeremy as CTO, this is how you make the dev agents reliable on the LegendsOS codebase.
- **What not to copy:** **The license** — PolyForm Noncommercial means you must **not** vendor or use it commercially inside LegendsOS. And a graph database is overkill for the Loan Brain v1 — Atlas retrieval already covers it.
- **Risk level:** Low as a concept; **High if used commercially (license).**  **Complexity:** Medium–High.
- **Best LegendsOS use case:** **Jeremy / CTO dev-productivity only** — give your Claude Code/Codex build agents architectural awareness of the LegendsOS repo. Not a borrower feature.
- **Suggested implementation phase:** Dev-tooling (now, as an external aid); not in the product.
- **Recommended action:** **Use the hosted/CLI tool as a personal dev aid; do not embed its code in LegendsOS (noncommercial license).**

## 7) OpenSwarm

- **Project name:** OpenSwarm (`@vrsen/openswarm`)
- **Local folder reviewed:** `_unzipped/OpenSwarm/OpenSwarm-main` (238 files)
- **Likely original GitHub source:** `@vrsen/openswarm` (MIT), built on **Agency Swarm + the OpenAI Agents SDK**. Python (`agency-swarm[fastapi,jupyter,litellm]`, `fastapi`, `uvicorn`, `pandas`, `pillow`, `pdf2image`, `opencv`) + Node (`pptxgenjs`, `dom-to-pptx`, `playwright`, `sharp`). Folders: `orchestrator/`, `virtual_assistant/`, `deep_research/`, `data_analyst_agent/`, `slides_agent/`, `docs_agent/`, `image_generation_agent/`, `video_generation_agent/`. Install: `npm i -g @vrsen/openswarm`.
- **What it does:** A **multi-agent "AI team" that produces finished deliverables from one prompt.** An **orchestrator** routes your request to specialists — a virtual assistant (with 10,000+ Composio integrations), deep research, a data analyst (charts in an isolated IPython kernel), a slides agent (HTML → PPTX), a docs agent (Word/PDF), an image agent, and a video agent. "One prompt → complete deck + report + visualizations + document."
- **Best ideas worth borrowing:** The **orchestrator → specialist** pattern is the cleaner, named version of what your Atlas `toolRouter` already does — and it maps perfectly to the mortgage flow: one input (a 3.4 + folder) routes to specialists that produce the **loan summary, processor handoff, condition plan, and draft email**. The specialist line-up (research / data / slides / docs / image / video) also overlaps your existing studios (marketing, training) — a reference for Jeremy's content + training output.
- **What not to copy:** Don't adopt the whole framework as a product dependency (you already have intent + retrieval + toolRouter). Don't expose specialist sprawl to LOs.
- **Risk level:** Low–Medium.  **Complexity:** Medium.
- **Best LegendsOS use case:** Reference for **Atlas "one input → full deliverable" generation** (loan summary + handoff + condition plan + draft in one pass) and for **Jeremy's marketing/training content** production. Also usable directly by Jeremy/CTO as a deliverable generator.
- **Suggested implementation phase:** Reference for Phase 4 (handoff/deliverable generation); usable as a personal tool now.
- **Recommended action:** **Borrow the orchestrator→specialist deliverable pattern.** Optionally use OpenSwarm itself for content/deliverables. Don't embed the framework in the product.

## 8) multica  ← a managed-agents platform (correcting an early mis-read)

- **Project name:** multica ("Multiplexed Information and Computing Agent")
- **Local folder reviewed:** `_unzipped/multica/multica-main` (2,381 files)
- **Likely original GitHub source:** `github.com/multica-ai/multica` (open-source; the desktop sub-app is marked `UNLICENSED`, so check the repo LICENSE before any reuse). Stack: **Go server** (`server/cmd|internal|migrations|pkg`) + **PostgreSQL** + a **React monorepo** (`apps/web`, `apps/desktop` Electron, `apps/mobile`; `packages/core|ui|views`), pnpm + turbo. Self-host via Docker/Helm.
- **What it does:** **The open-source "managed agents" platform** — "your next 10 hires won't be human." It turns *coding* agents (Claude Code, Codex, Copilot CLI, OpenClaw, OpenCode, Hermes, Gemini, Pi, Cursor, Kimi, Kiro) into teammates: you **assign an issue like you'd assign a colleague**, the agent shows up on a board, posts comments, creates issues, reports blockers, and updates status autonomously. **Squads** group agents under a leader that delegates (stable routing). **Autopilots** schedule recurring agent work (cron/webhook/manual — standups, weekly reports, audits run themselves). **Reusable skills** compound over time. **Unified runtimes** (local + cloud) with real-time monitoring. **Multi-workspace** isolation.
- **Best ideas worth borrowing:** (1) **Autopilots** — scheduled, recurring agent work maps directly to "every morning summarize the pipeline" and "nightly missing-item sweep." (2) The **board with assignee + activity timeline + proactive blocker reporting** reinforces the LoanFlow/processor board (alongside paperclip). (3) **Squads routing** (assign to a team; a leader delegates) is a clean model if you route work across multiple assistants. (4) **Reusable skills that compound** mirrors your `legendsos-skills/`.
- **What not to copy:** It manages **coding agents**, not borrower comms — do **not** treat it as an email engine. Don't run it as a separate platform or expose its UI. Its Go server + Docker self-host shouldn't become a production requirement (stay on Supabase/Next/Netlify).
- **Risk level:** Low–Medium.  **Complexity:** Medium.
- **Best LegendsOS use case:** **Jeremy / CTO** — manage the coding agents that *build* LegendsOS (board, Squads, Autopilots) — a direct fit for your AI-Implementation + CTO role. In-product, the **Autopilots** and **board** concepts feed LoanFlow and the scheduled summaries.
- **Suggested implementation phase:** Dev-tooling now; Autopilots/board concepts into Phases 4 + 7.
- **Recommended action:** **Borrow Autopilots (scheduled agent work), the board/assignee/timeline, and Squads routing.** Optionally use multica to run your build agents. Keep it out of the product and out of borrower comms.

## 9) openhuman  ← the best reference for memory + tool registry + approvals

- **Project name:** openhuman (OpenHuman, by tinyhumansai)
- **Local folder reviewed:** `_unzipped/openhuman/openhuman-main` (4,042 files)
- **Likely original GitHub source:** `github.com/tinyhumansai/openhuman`. **License: GPL-3.0** for the app (copyleft ⚠️ — concept-only, don't vendor the app code); the `packages/npm` CLI sub-package is MIT. Stack: **Tauri (Rust shell) + React + Redux Toolkit** (`app/src-tauri`, `src-tauri-mobile`, `src-tauri-web`), integrations through the **Composio** connector layer.
- **What it does:** A **local-first "personal AI super-intelligence."** It reads your documents, emails, notes, and chats and builds a private **Memory Tree** plus an **Obsidian-style Markdown vault** on your machine, then acts through **100+ typed integrations** (Gmail, Drive, Calendar, Notion, Slack, GitHub, Linear, Stripe…) via Composio — each gated by **permission tiers + chat-based approvals** (sensitive actions require explicit approval; signing in does not grant ongoing access without per-integration approval). Default experience uses OpenHuman-hosted services for sign-in/model-routing/search/OAuth, with a bring-your-own option. Has a skills system.
- **Best ideas worth borrowing (high value):** (1) The **memory tree/graph** that summarizes and links your documents and emails — a strong model for the **per-borrower Loan Brain memory.** (2) **One typed tool per integration** — the right way to expose Drive/Gmail/n8n to Atlas (extends your `mcp_connections`). (3) **Permission tiers + chat approvals** — *surgical* HITL: harmless tools run, consequential ones (send, move, push) require approval. This is exactly how to avoid "security theater." (4) A **skills system** that mirrors your `legendsos-skills/`.
- **What not to copy:** **The app license is GPL-3.0 (copyleft)** — borrow the concepts, don't vendor the code. Don't run a second agent app inside LegendsOS. Don't grant 100+ integrations against borrower data — least-privilege only. openhuman *acts* on Drive; **LegendsOS must keep Drive read-only.** Keep memory in Supabase (e.g., pgvector), not a separate store.
- **Risk level:** Low–Medium concept; **High if you vendor code (GPL).**  **Complexity:** Medium.
- **Best LegendsOS use case:** The single best blueprint for the **Loan Brain memory + the typed-tool registry + the permission-tier approval model.**
- **Suggested implementation phase:** Phase 1–2 (tool registry + tiered approvals), Phase 3 (memory).
- **Recommended action:** **Borrow the memory-tree, typed-tool registry, and permission-tier/approval patterns; reimplement (do not vendor — GPL).** Constrain to least-privilege + read-only Drive; build on Supabase.

---

## The single biggest takeaway from the matrix

The strongest, safest, most directly reusable ideas come from **openhuman (memory graph + typed-tool registry + permission-tier approvals), AionUi (workspace UX + preview + unified MCP), paperclip and multica (governed agent boards + budgets / Squads / Autopilots), Hermes Desktop (comms gateway + cost tracking), and herdr (the blocked/working/done/seen status model).** None of them is mortgage software — LegendsOS supplies the mortgage brain; these supply proven UX and governance patterns. The standout "sleeper" is **openhuman** (its memory + tool registry + tiered approvals is the Loan Brain + safety blueprint, though its app is GPL-3.0 so reimplement, don't vendor). The **draft → approve → send** comms model is best built from **Hermes Desktop's gateway + your own existing `ALLOW_LIVE_EMAIL_SEND`/n8n plumbing** with openhuman-style approvals — not from any single app. Handle **GitNexus** carefully (PolyForm Noncommercial — personal dev aid only) and **herdr/openhuman** as concept-only (AGPL / GPL). See `04` for the consolidated recommendations.

---
*Next: `04_LEGENDSOS_ELITE_FEATURE_RECOMMENDATIONS.md`*
