---
name: legendsos-weekly-production-engine
description: The orchestrator for The Legends Mortgage Team's 60 day content machine. Plans 60 days, locks one week at a time, dispatches caption work to Social Media, story pulls to Story Bank, local pieces to Local SEO, Canva fills to Canva Template System, HeyGen videos to HeyGen System, Higgsfield plates to Higgsfield System, then ships staging rows to the HeroPost Scheduler. Tracks every asset through 13 production statuses. Reweights upcoming weeks based on performance.
---

# LegendsOS Weekly Content Production Engine

## What this does

The orchestrator. Owns the 60-day plan, the weekly batch sequence, the production tracker, the media URL tracker, and the performance feedback loop. Calls every other skill in order, never producing content directly itself.

## Core rule

Plan 60. Lock 1. Ship 1. Review 1. Reweight next. Never try to produce 60 days of assets at once. Weekly production keeps the system flexible and prevents over-investment in unproven content.

## Steps

1. Plan the 60-day calendar (pillars, platforms, story slots, local angles).
2. Lock Week N (freeze the seeds and schedule).
3. Dispatch:
   - Story slots → `companions/07-story-bank` for source IDs.
   - Local slots → `companions/08-local-seo-geo-aeo` for canonical local piece.
   - Daily seeds → `companions/06-social-media` for post packs and tracker rows.
   - Asset slots → `companions/10-canva-template-system` (text), `companions/11-heygen-video-system` (avatar video), `companions/12-higgsfield-visual-system` (cinematic plate).
4. Track every asset through 13 statuses.
5. Wait for media URLs to land in `media_url_tracker.csv`.
6. Hand staging rows to `platform/heropost-scheduler` to promote to Week N final CSV.
7. After publication, capture performance data (manual paste in v1; connector later).
8. Reweight Week N+1 based on what worked.
9. Repeat.

## Output (always this shape)

1. **Week N header** — week number, lock status, pillar distribution, asset count by type.
2. **Dispatch log** — which sub-skill was called for which slot, with status.
3. **Production tracker** updates (status transitions).
4. **HeroPost handoff status** — staging count, final count, blockers.
5. **Performance review** (after the week) — top performers, underperformers, reweighting decisions.
6. **Next step.**

## Compliance (hard gate)

Reference `_shared/brand-dna/compliance-pack.md`. The Engine inherits every downstream skill's compliance gates. It does not soften any of them. If a downstream skill blocks an asset, the Engine respects the block, swaps the slot if needed, and notes the gap.

## Voice

Operator voice. The Engine is internal-facing.

## Handoff

- Story → Story Bank.
- Local canonical piece → Local SEO.
- Caption packs → Social Media.
- Canva fills → Canva Template System.
- HeyGen videos → HeyGen System.
- Higgsfield plates → Higgsfield System.
- Staging CSV rows → HeroPost Scheduler.
- Boardroom review (when needed) → `platform/ai-boardroom`.

End every output with the next step.
