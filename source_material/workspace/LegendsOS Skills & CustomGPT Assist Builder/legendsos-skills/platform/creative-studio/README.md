# Creative Studio (HOLD — Higgsfield not yet connected)

## Status

**HOLD — not built yet.** Awaiting Higgsfield MCP connection. The abstraction layer, generator interface, and policy files are in place so Creative Studio can be fully built the moment Higgsfield is connected without any rewrites elsewhere.

## What's in this folder right now

```
creative-studio/
├── README.md (this file)
├── higgsfield/
│   ├── mediaGenerator.ts        the interface every Creative Studio call talks to
│   ├── LocalDraftSource.ts      current behavior: spec output only, no generation
│   ├── HiggsfieldSource.ts      placeholder; wire to real Higgsfield MCP when ready
│   ├── usage-policy.md          when Creative Studio is allowed to call Higgsfield
│   ├── generation-tier-logic.md decision rules for when to spend a generation
│   └── workflow-references.md   pointers to the 6 Higgsfield workflows from the spec
```

## Why HOLD

Per the Master Skills Build Plan:
- Creative Studio is the only skill that strictly requires Higgsfield MCP.
- Visual Intelligence and AI Boardroom are already built and do not need it.
- HeyGen Video has its own API.
- B-Roll & AI Video can ship its planning portion now; the AI clip generation step waits.

Building Creative Studio's full SKILL.md + CUSTOM_GPT.md + examples + boardroom integration before Higgsfield is wired would either:
- Burn Higgsfield generations on test prompts (waste), or
- Ship a skill that can't actually produce assets (worse waste).

The abstraction layer below lets the rest of the build proceed and means Creative Studio's full build is a contained piece of work, not a re-architecture.

## What this skill will eventually do

(Reference, not built yet)

Turn a concept into a complete cinematic mortgage campaign kit: hero images, reel covers, YouTube thumbnails, B-roll, animated hooks, Canva templates, webinar promo kits, email graphics, storyboards. One of the 10 campaign engines. Full kit per run. Boardroom gate at concept and asset. Supabase memory. n8n distribution of approved-and-signed-off assets only.

## Build seam

The `mediaGenerator.ts` interface in this folder is the contract every Creative Studio call talks to. Today's implementation is `LocalDraftSource` — it outputs the prompt spec and Canva build details without calling any external generator. Tomorrow's implementation is `HiggsfieldSource` — same interface, real generations.

Visual Intelligence, B-Roll & AI Video, and YouTube Intelligence all build against this same interface so they can swap from spec-only to real-generation in one place.

## When this skill gets fully built

The trigger is: Higgsfield MCP is connected and reachable from the LegendsOS environment with documented tool names and parameters.

When that happens, the build prompt is:

```
Build platform/creative-studio fully. Read the full spec at uploads/LegendsOS-Creative-Studio-System.md. Wire the HiggsfieldSource to the real Higgsfield MCP tool names. Build SKILL.md, CUSTOM_GPT.md, README, examples (5 real worked campaign kits), test-prompts, usage-notes, compliance. Confirm visual-intelligence is callable as a sub-skill for single images. Confirm n8n only distributes approved-and-signed-off exports. Run the 8-lens visual boardroom + 2 gates (concept + asset). Do not auto-publish external. Output the final file tree.
```

## What is blocked until Higgsfield is connected

- Creative Studio full build.
- The AI clip generation step of Companion #3 (B-Roll & AI Video) — the planning step is fine to build today.
- Any image-to-video animated hook generation.
- Higgsfield B-roll scene pack production.

## What is NOT blocked

- AI Boardroom (built).
- Visual Intelligence (built — produces single-image packages today).
- HeyGen Video Assistant (HeyGen has its own MCP/API).
- Email Newsletter, Social Media, Realtor Outreach, SEO/AEO/GBP, Webinar Builder, Integrations Setup, YouTube Intelligence, Meet Prompter — all build today.
