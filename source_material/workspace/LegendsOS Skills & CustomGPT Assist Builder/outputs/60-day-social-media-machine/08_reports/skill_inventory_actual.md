# Skill Inventory (Actual)

**Source of truth.** `08_reports/skill_build_report.md` + live file counts under `legendsos-skills/`.
**Run date.** 2026-05-24.
**Total skills confirmed.** 8 production skills + 1 docs file (mcp-connector-audit.md).

## 06-social-media - LegendsOS Social Media
- **skill_path.** `companions/06-social-media`
- **purpose.** Daily channel-native posts across 10 platforms.
- **core files present.** `SKILL.md`, `CUSTOM_GPT.md`, `README.md`, `compliance.md`, `usage-notes.md`, `test-prompts.md`
- **knowledge files count.** 8
- **examples count.** 5
- **status.** READY
- **next use.** Used by Weekly Production Engine to render captions per platform per day.

## 07-story-bank - LegendsOS Story Bank
- **skill_path.** `companions/07-story-bank`
- **purpose.** Real-source, anonymized, source-ID-tagged stories. 11 frameworks. No invented reviews.
- **core files present.** `SKILL.md`, `CUSTOM_GPT.md`, `README.md`, `compliance.md`, `usage-notes.md`, `test-prompts.md`
- **knowledge files count.** 8
- **examples count.** 1
- **status.** READY
- **next use.** Used by interview workflow to add/maintain real story records.

## 08-local-seo-geo-aeo - LegendsOS Local SEO + GBP
- **skill_path.** `companions/08-local-seo-geo-aeo`
- **purpose.** Jacksonville and Northeast Florida local search, GBP, blog, vlog, AEO.
- **core files present.** `SKILL.md`, `CUSTOM_GPT.md`, `README.md`, `compliance.md`, `usage-notes.md`, `test-prompts.md`
- **knowledge files count.** 7
- **examples count.** 1
- **status.** READY
- **next use.** Used to draft GBP posts, blog posts, AEO answer blocks for Jacksonville.

## 10-canva-template-system - LegendsOS Canva Template System
- **skill_path.** `companions/10-canva-template-system`
- **purpose.** Reusable Canva templates with locked compliance footers. Bulk Create CSV producer.
- **core files present.** `SKILL.md`, `CUSTOM_GPT.md`, `README.md`, `usage-notes.md`, `test-prompts.md`
- **knowledge files count.** 6
- **examples count.** 0
- **status.** READY
- **next use.** Used to produce Bulk Create CSV inputs (already done for Week 1).

## 11-heygen-video-system - LegendsOS HeyGen Video System
- **skill_path.** `companions/11-heygen-video-system`
- **purpose.** HeyGen avatar video specs. Inside Man / Coach / Wolf personas. Compliance gated.
- **core files present.** `SKILL.md`, `CUSTOM_GPT.md`, `README.md`, `compliance.md`, `usage-notes.md`, `test-prompts.md`
- **knowledge files count.** 7
- **examples count.** 0
- **status.** READY
- **next use.** Used to build HeyGen prompt blocks (done for Week 1). Test render is next.

## 12-higgsfield-visual-system - LegendsOS Higgsfield Visual System
- **skill_path.** `companions/12-higgsfield-visual-system`
- **purpose.** Cinematic plates only. Concept Gate enforced. Text and compliance live in Canva.
- **core files present.** `SKILL.md`, `CUSTOM_GPT.md`, `README.md`, `compliance.md`, `usage-notes.md`, `test-prompts.md`
- **knowledge files count.** 6
- **examples count.** 0
- **status.** READY
- **next use.** Used to write Higgsfield prompts (done for Week 1). Manual UI execution is next.

## heropost-scheduler - LegendsOS HeroPost Scheduler
- **skill_path.** `platform/heropost-scheduler`
- **purpose.** Two-stage HeroPost CSV: staging then final. Schema locked. Validation gated.
- **core files present.** `SKILL.md`, `CUSTOM_GPT.md`, `README.md`, `usage-notes.md`, `test-prompts.md`
- **knowledge files count.** 6
- **examples count.** 0
- **status.** READY
- **next use.** Used to validate staging and promote to final ONLY after media URLs land.

## weekly-content-production-engine - LegendsOS Weekly Production Engine
- **skill_path.** `platform/weekly-content-production-engine`
- **purpose.** The orchestrator. Plans 60, locks 1, ships 1, reweights next.
- **core files present.** `SKILL.md`, `CUSTOM_GPT.md`, `README.md`, `usage-notes.md`, `test-prompts.md`
- **knowledge files count.** 6
- **examples count.** 0
- **status.** READY
- **next use.** Orchestrates the weekly batch cycle (Friday plan, Sunday ship).

## Supporting docs
- `legendsos-skills/docs/mcp-connector-audit.md` - canonical connector status; updated this run via `07_automation/production_connector_verification_report.md`.

## Confirmed total: 8 skills