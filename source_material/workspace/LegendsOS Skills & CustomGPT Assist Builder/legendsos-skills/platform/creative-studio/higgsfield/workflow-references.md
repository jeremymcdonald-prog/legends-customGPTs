# Higgsfield Workflow References

Pointers to the workflows defined in the Creative Studio System spec (Section 3 + 15 + 19). Implementation lives in the Creative Studio full build, not here.

## The 6 Higgsfield workflow categories

| # | Workflow | What Higgsfield produces | Tier (typical) |
|---|---|---|---|
| 1 | Cinematic hero stills | The cinematic plate that goes into Canva | Tier 2 |
| 2 | Image-to-video animated hooks | 1-2s motion (subject turn, push-in, parallax) for Reels/Shorts | Tier 3 |
| 3 | B-roll scene packs | Office, neighborhood dusk, command center, keys/closing motifs, lifestyle authority | Tier 1-2 (generate once, tag, reuse forever) |
| 4 | Motion intro sequences | Logo reveal, dashboard glow, title cards as motion plates (text added in Canva/edit) | Tier 2 |
| 5 | Reel cover stills | 9:16 covers that survive 1:1 crop | Tier 2 |
| 6 | YouTube thumbnails | 16:9 with strong face + clean text zone | Tier 2 |

## Operational workflow (PASTE — from Creative Studio System spec)

```
HIGGSFIELD WORKFLOW
1. Claude generates the campaign brief and the scene/motion prompt.
2. AI Boardroom reviews the concept. Pass required to proceed.
3. LegendsOS calls Higgsfield MCP with the approved prompt + request_id + org_id.
4. Higgsfield returns drafts to staging (status: draft).
5. AI Boardroom reviews the asset (compliance gate). Below threshold = hold + review note.
6. Canva receives the approved plate/clip for templating.
7. LegendsOS stores the final asset + metadata + append-only approval record in Supabase.
8. n8n distributes only approved, signed-off exports.
```

## Request flow (the spine, from Creative Studio Section 2)

```
Concept (Jeremy) -> LegendsOS logs request (request_id, org_id)
  -> Claude writes campaign brief + master prompt
  -> AI Boardroom reviews concept (scores, verdict)
  -> if pass: Higgsfield generates cinematic assets (drafts)
  -> Canva receives approved layout, builds editable template
  -> AI Boardroom reviews finished asset (compliance gate)
  -> Supabase stores asset + metadata + append-only approval record
  -> n8n distributes only approved, signed-off exports
```

## B-roll scene packs (Section 15 of Creative Studio spec)

Generated once per pack, tagged for reuse:

- **Command center:** desk, glowing illustrative dashboards, city night skyline.
- **Premium office:** dark interior, Legends wall, marble desk, coffee + notebook.
- **Neighborhood at dusk:** warm-lit homes, moody streets.
- **Closing/keys:** keys, sold motif, doorway light.
- **Lifestyle authority:** subject walking, working, on the phone, confident.

**Rules:** no real client homes or data, no real documents, illustrative dashboards only. Each clip tagged by scene, mood, length, and engine for fast reuse across campaigns.

## Recurring automation calendar (Section 19)

n8n schedules these; Higgsfield generates the plates as needed; the Boardroom gates everything; Jeremy signs off; n8n distributes drafts. No auto-publish external.

| Slot | Engine | Format default |
|---|---|---|
| Monday — Money Moves Monday | Mortgage Education | 1:1 + story |
| Tuesday — Realtor Tip | Realtor Attraction | 4:5 + carousel |
| Wednesday — AI Workflow | AI Authority | 1:1 + thumbnail |
| Thursday — Testimonials | Cinematic Authority (proof card) | 1:1 |
| Friday — Friday Momentum | Team Momentum | 1:1 |
| Weekend — Open House | Realtor Attraction (co-brand) | 1:1 |
| Veteran Spotlight | Veteran and VA | 1:1 |
| Rate Update (weekly) | Market Update | 1:1 + story |
| Market Myth (weekly) | Pattern Interrupt | 1:1 |
| Investor Opportunity (biweekly) | Investor Opportunity | 1:1 + carousel |

## Pointer to the full spec

Full system spec: `uploads/LegendsOS-Creative-Studio-System.md` (in the workspace folder).

When Creative Studio is fully built, this file becomes the implementation reference. Until then it's the read-only blueprint.
