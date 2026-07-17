# Higgsfield Production Rules

## Budget posture

- Higgsfield costs render minutes. Treat as a scarce resource.
- Default to 3 to 6 Higgsfield assets per week, paired with 15 to 25 Canva assets.
- Premium weeks (launches, big stories) can rise to 8 to 12 Higgsfield assets.

## Selection logic (from generation-tier-logic.md in Creative Studio)

| Tier | Use case |
|---|---|
| Tier 1 — Higgsfield Pro | Premium cinematic still, premium image-to-video hook, signature campaign asset |
| Tier 2 — Higgsfield Standard | Bulk Reel covers, weekly B-roll plates, story plates |
| Tier 3 — Canva or Visual Intelligence | Text graphics, GBP images, carousel slides, motivational quotes |

The skill recommends a tier with every prompt block.

## Concept Gate

Before generation, the asset passes the AI Boardroom Concept Gate (Compliance ≥ 8). The skill emits `concept_gate_status: pending` until the gate clears.

## Audit

Every Higgsfield call writes to `generations` table per Creative Studio policy:

- `tool`: `higgsfield`
- `prompt`: full assembled prompt
- `params`: aspect, kind, motion notes
- `cost`: tool cost if known
- `latency_ms`: round trip
- `status`: `draft`
- `request_id`: propagated
- `org_id`: propagated
- `created_by`: user_id
- `created_at`: ISO8601

Append-only. No update or delete.

## Distribution

n8n distributes Higgsfield assets only when:

- Asset Gate cleared (Compliance ≥ 8).
- Human sign-off (Jeremy).
- Approved channel.
- External publish requires explicit human sign-off, never auto.

## Output review checklist

For each draft Higgsfield asset:

- Text zone clear of subject.
- Accent rule held (one accent, orange or gold).
- Composition mobile-first.
- No artifacts in hands, faces, or text-shaped objects.
- Aspect matches publish surface.
- Negative prompt suppressed forbidden elements.

## When to retry

- Faces or hands deformed.
- Accent color violated (e.g., red instead of orange).
- Composition crowded.
- Subject not centered or hero-positioned where required.
- Stock-photo feel snuck in.

## When to swap to Canva

- The asset really wanted text the whole time.
- Generation cost outweighs the strategic value.
- The same effect can be achieved with a Canva template on a flat color background.
