# 01 — Current LegendsOSv2.0 Repo Status

**Reviewed:** GitHub `jeremymac904/LegendsOSv2.0` (cloned fresh) + local working copy at `legends-team-builds/legendsos/legendsos-v2`.
**Date:** May 30, 2026
**Reviewer:** Jeremy's AI Assistant (review only, no build, no commits)

> Plain-English version up top, technical detail below. I did not open `.env.local` or print any secrets. Everything here comes from the public code structure, the migration files, and the `.env.example` variable *names*.

---

## The one-paragraph truth

LegendsOSv2.0 is already a real, well-structured platform, not a prototype. It's a Next.js (App Router) web app on Supabase, deployed to Netlify, with a thin optional Electron desktop wrapper. It has multi-user roles, row-level security, an AI provider gateway, a working "Atlas" AI workspace with retrieval and tool routing, a marketing-grade Email Studio, Social, Calendar, Image, Knowledge, and Training modules, plus an n8n automation bridge. What it does **not** have yet is anything mortgage-operational: no Google Drive loan-file integration, no borrower/loan data model, no document parsing, and no processor/coordinator workflows. So the foundation is strong and the mortgage brain is the greenfield. That's actually the ideal starting position.

---

## Current app architecture

- **Framework:** Next.js (App Router) — single web app (the package is `legendsos-v2`, v2.0.0). Not a multi-app monorepo.
- **Backend/data:** Supabase (`@supabase/ssr`, `@supabase/supabase-js`) with SQL migrations and RLS.
- **Styling/UI:** Tailwind, `lucide-react` icons, custom component library under `components/` (shell, ui, atlas, email, calendar, social, knowledge, admin, images, resources, settings, help).
- **Auth:** Supabase auth via `middleware.ts` + `app/auth/callback`. Admin impersonation supported (`lib/impersonation.ts`, `/api/admin/impersonate`).
- **AI gateway:** `lib/ai/providers.ts` + `lib/ai/types.ts` abstract multiple providers (OpenRouter as the multi-model hub, plus DeepSeek, FAL for images, NVIDIA). Providers are seeded in the DB and toggled by admins.
- **Hosting:** `netlify.toml` (Netlify). Vercel also in Jeremy's stack. **No Docker or local Mac runtime is required to run production** — good and aligned with the directive.
- **Desktop:** `electron/` (`legendsos-desktop` 2.0.0, `main.cjs` + `preload.cjs`) — a thin wrapper that loads the web app. Desktop is optional packaging, not a separate runtime.

## Current modules (what users see today)

Under `app/(app)/`:

- **dashboard** — landing/overview.
- **atlas** — the AI workspace: threads (`atlas/[threadId]`), a model catalog, connector panel, and an LO workspace component. This is the closest thing to the "command center."
- **email** — campaigns (`email/[campaignId]`) + audiences (`email/audiences`) + audience import. Marketing/newsletter shaped.
- **calendar** — content/scheduling calendar.
- **images** — AI image studio.
- **social** — social posts (`social/[postId]`) with composer + preview.
- **knowledge** — collections (`knowledge/[collectionId]`) + uploads + quick upload picker.
- **training** — academy (track → module), audio, scripts, roleplay, resource pages.
- **lf-resources** — Loan Factory resource library.
- **marketing-materials** — branded material library.
- **shared** — shared team resources.
- **admin** — users, usage, assets, impersonation.
- **settings** — provider toggles, MCP connections, connection setup.

## Current Supabase model

Migrations present (RLS-first design):

- `20260512000000_init_schema`, `..._rls_policies`, `..._storage_buckets`, `..._bootstrap`
- `..._provider_seed_reset` (AI provider registry seeded)
- `..._newsletter_audience` + `..._newsletter_contacts_dedupe_fix`
- `..._atlas_assistants_metadata`
- `20260513_extend_user_roles`
- `20260518_create_mcp_connections`
- `005_atlas_connectors`

**Translation:** multi-user with roles, row-level security, storage buckets, an AI provider registry, newsletter audiences, Atlas assistant metadata, an MCP connections table, and an Atlas connectors table. There is **no** loans/borrowers/documents/conditions/pipeline data model yet.

## Current AI / "brain" wiring

- `lib/atlas/intentDetection.ts` — classifies what the user is asking for.
- `lib/atlas/retrieval.ts` — retrieval/RAG over knowledge.
- `lib/atlas/toolRouter.ts` — routes a request to the right tool/assistant.
- `app/api/ai/chat`, `/ai/image`, `/ai/status` — AI endpoints.
- `scripts/import-local-knowledge.ts`, `index-local-assets.ts`, `seed-atlas-assistants-from-local.ts` — a working knowledge-ingestion + asset-indexing pipeline.

This is the single most important asset for the mortgage build: Atlas already has intent → retrieval → tool-routing. The Loan Brain plugs in here.

## Current automation readiness

- `lib/automation/n8n.ts`, `n8n-bridge.ts`, `zapier-mcp.ts` and `/api/automation/callback`.
- `.env.example` wires n8n webhooks for: email send, social publish, provider health, daily usage, content reminder, failed-publish recovery.
- This matches Jeremy's stack (n8n local + Hostinger VPS, Zapier MCP). **Automation backbone is already in place.**

## Current email/social safety model (important)

`.env.example` shows feature flags **and** cost caps already exist:

- `ALLOW_LIVE_EMAIL_SEND`, `ALLOW_LIVE_SOCIAL_PUBLISH`, `ALLOW_PAID_IMAGE_GENERATION`, `ALLOW_PAID_TEXT_GENERATION` (default-off gates).
- `DAILY_CAP_CHAT_MESSAGES`, `DAILY_CAP_EMAIL_DRAFTS`, `DAILY_CAP_IMAGE_GENERATIONS`, `DAILY_CAP_SOCIAL_POSTS`.

So LegendsOS **already drafts by default and gates live sends behind a flag + an n8n webhook.** This is exactly the safe pattern the handoff asks for, and exactly what Hermes Desktop (one of the reviewed projects) does for email. We extend this model; we don't reinvent it.

## Current Google Drive readiness

**Not started (greenfield).** No `googleapis`/`google-auth-library` dependency, no Drive module, no Drive route. The *foundation* to add it cleanly exists: Atlas connectors + the `mcp_connections` table + the fact that this very environment already has Google Drive and Google Workspace MCP access. This is the biggest single gap between "marketing platform" and "mortgage operating system."

## Current Email Studio readiness

**Partially ready — but for the wrong job.** Today's Email Studio is marketing/newsletter (campaigns + audiences + CSV import + `test-send`). The handoff needs **transactional, 1:1 borrower/lender/processor drafting** (Ashley email generator, condition responses, missing-item requests). That's a different shape — closer to an inbox-style "draft, never send" assistant. The good news: the draft-first + `ALLOW_LIVE_EMAIL_SEND` + n8n-send backbone is the right plumbing to extend.

## Current Atlas readiness

**Ready as the command-center shell.** Threads, model catalog, retrieval, tool routing, connector panel, and an "LO workspace" already exist. Atlas should host the Jeremy command center and the Loan Brain rather than us building a new shell.

## Current desktop readiness

**Ready and correctly scoped.** Thin Electron wrapper only. Production is the web app (Netlify/Vercel). We should keep desktop optional and never make Mac/Docker/Cloudflare-tunnel a production requirement (directive respected).

## Current gaps (the build list, ranked)

1. **Google Drive loan-file integration** — none. (Highest-value gap.)
2. **Mortgage data model** — no loans/borrowers/documents/conditions/pipeline tables.
3. **Document intelligence** — no 3.4/1003 parser, AUS reader, condition-response builder, missing-item detector.
4. **Processor & coordinator workflows** — no processor-handoff generator, missing-item tracker, pipeline-update assistant.
5. **Transactional email drafting (Hermes-style)** — Email Studio is marketing-shaped, not borrower/lender 1:1.
6. **Role-scoped simple views** — roles + RLS + impersonation exist, but there's no deliberately simplified LO / Ashley / Geraldine surface yet.
7. **Guideline/overlay knowledge** — Knowledge module exists but isn't loaded with UW Guides / Loan Factory Loan Brain / lender overlays.

## Best next build path (one line)

Add a **Google Drive read-only Loan Brain inside Atlas** (Drive connector → borrower-folder index → loan summary + missing-item tracker + processor-handoff generator), reusing the existing retrieval/tool-router and the existing draft-first/n8n send model — **before** expanding the marketing-style Email Studio. Full sequence in `08_NEXT_BUILD_SEQUENCE.md`.

---
*Next: `02_LOCAL_PROJECTS_INVENTORY.md`*
