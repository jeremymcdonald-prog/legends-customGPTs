# 02 — Local Projects Inventory

**Scope:** Everything inside the `legends-team-builds` project folder, plus the 9 open-source archives.
**Review folder created:** `_drafts/legendsos_elite_feature_review/` (this folder). Archives unzipped into `_drafts/legendsos_elite_feature_review/_unzipped/`. **Originals were never moved, renamed, deleted, or overwritten.**

---

## A. Open-source archives (9)

| Archive | Size | Unzipped to | Inspection status |
|---|---|---|---|
| `AionUi-main.zip` | 453 MB | `_unzipped/AionUi/AionUi-main` | ✅ Verified (README + structure + package.json) |
| `UI-TARS-desktop-main.zip` | 33 MB | `_unzipped/UI-TARS-desktop/UI-TARS-desktop-main` | ✅ Verified |
| `hermes-desktop-main.zip` | 14 MB | `_unzipped/hermes-desktop/hermes-desktop-main` | ✅ Verified |
| `herdr-master.zip` | 11 MB | `_unzipped/herdr/herdr-master` | ✅ Verified |
| `paperclip-master.zip` | 18 MB | `_unzipped/paperclip/paperclip-master` | ✅ Verified |
| `GitNexus-main.zip` | 7.5 MB | `_unzipped/GitNexus/GitNexus-main` (3,348 files) | ✅ Verified — codebase→knowledge-graph for AI agents, MCP-native. **PolyForm Noncommercial license.** |
| `OpenSwarm-main.zip` | 2.6 MB | `_unzipped/OpenSwarm/OpenSwarm-main` (238 files) | ✅ Verified — multi-agent deliverable team (orchestrator + 8 specialists), built on Agency Swarm (MIT). |
| `multica-main.zip` | 20 MB | `_unzipped/multica/multica-main` (2,381 files) | ✅ Verified — open-source "managed agents" platform (board, Squads, Autopilots) for coding agents; Go + Postgres + React (desktop app marked UNLICENSED — check repo LICENSE). |
| `openhuman-main.zip` | 20 MB | `_unzipped/openhuman/openhuman-main` (4,042 files) | ✅ Verified — local-first personal AI agent: memory tree + typed tools + permission-tier approvals; Tauri + React. **App is GPL-3.0** (CLI sub-package MIT). |

> **Process note (for transparency):** the first extraction pass ran the unzips in parallel and four of them collided (the sandbox allows one process at a time), leaving empty folders. They were **re-extracted sequentially and read at file level** (READMEs, `package.json`, licenses, source tree). All nine projects are now ✅ verified. Original `.zip` files were never touched. Two of the four (**multica**, **OpenSwarm**) turned out to be different from what a first glance suggested — multica is a *managed coding-agents platform* (not a support inbox), and OpenSwarm is a *deliverable-producing agent team* (not a git-worktree coder). **License flags to remember:** **GitNexus = PolyForm Noncommercial** (personal/dev use only); **openhuman app = GPL-3.0** and **herdr = AGPL-3.0** (both copyleft → borrow concepts, reimplement, don't vendor); the rest are Apache-2.0 / MIT.

## B. Existing local folders inside `legends-team-builds`

| Folder | What's actually in it | Meaning for the build |
|---|---|---|
| `_drafts/` | Was an empty placeholder (README only). Now holds **this review** (`legendsos_elite_feature_review/`). | Working/scratch area. Safe to use for drafts. |
| `hermes/` | Empty placeholder (README only). | Reserved name for the future **Hermes** comms/email engine. Not built. |
| `infra/` | Empty placeholder (README only). | Reserved for infrastructure-as-code. Not built. |
| `legendsos/` | Contains `legendsos-v2/` — the **working local clone of the live app** (~38.9k files incl. `node_modules`, `.next`, `.git`, and a `.env.local`). | This is the real product. **I did not open `.env.local`.** Matches the GitHub repo reviewed in file 01. |
| `loanflow/` | Empty placeholder (README only). | Reserved name for **LoanFlow** (loan pipeline) module. Not built. |
| `tools/` | Empty placeholder (README only). | Reserved for shared tooling. Not built. |
| `LegendsOS Skills & CustomGPT Assist Builder/` | **Real content (~3.3 MB, ~298 files).** Spec docs + a structured `legendsos-skills/` library. | Your existing brand/skill brain — see breakdown below. Highly relevant to the build. |
| `# LegendsOSv2.md` | The **handoff document** (the Drive-based Jeremy Applicants Pipeline, Ashley/Geraldine workflows, UW Guides, borrower folder structure). | The product brief for the mortgage layer. Drives files 05–07. |
| `README.md` | One-liner: "Internal team tools, LegendsOS, Hermes, LoanFlow, content systems, and team operations." | Confirms the intended module map: **LegendsOS + Hermes + LoanFlow + content + ops.** |

### The `LegendsOS Skills & CustomGPT Assist Builder/` folder is an asset, not clutter

It already contains a working brand/skill system you should reuse rather than rebuild:

- **Spec docs:** AI Boardroom Assistant, Companion GPT Pack Master Spec v2, Creative Studio System, Master Skills Build Plan, Meet Prompter Spec, Visual Intelligence System, YouTube Intelligence Engine.
- **`legendsos-skills/platform/`:** creative-studio (Higgsfield media generator + tier logic), heropost-scheduler (CSV schema, scheduling/validation/bulk-upload rules), weekly-content-production-engine, ai-boardroom (with compliance pack + examples), visual-intelligence (layouts, templates, compliance, examples).
- **`legendsos-skills/companions/`:** 13-realtor-newsletter-agent (with verified-source knowledge + examples).
- **`legendsos-skills/_shared/`:** **brand-dna** (voice, visual-dna, compliance-pack, guarantee-terms, NMLS/EHO footer), **knowledge** (safe-CTA list, CAN-SPAM block, RESPA do/don't, service-area NAP, handoff-rules), **prompt-components** (brand-DNA prompt, negative prompt, engine references), **templates** (skill + custom-GPT templates).
- **`legendsos-skills/docs/mcp-connector-audit.md`** — your own MCP connector audit.

**Why this matters:** the compliance guardrails (CAN-SPAM, RESPA do/don't, NMLS/EHO footer, safe-CTA list, guarantee terms) and brand voice are already written down. The mortgage build should *load these as the compliance + voice layer* for any borrower/lender/marketing text LegendsOS drafts.

## C. What's genuinely missing locally

- No mortgage/loan data anywhere (correct — borrower data must not live in GitHub or this repo).
- `hermes/`, `loanflow/`, `infra/`, `tools/` are reserved-but-empty. The names tell you the intended roadmap: **Hermes (comms), LoanFlow (pipeline), infra, tools.**

---
*Next: `03_OPEN_SOURCE_FEATURE_EXTRACTION_MATRIX.md`*
