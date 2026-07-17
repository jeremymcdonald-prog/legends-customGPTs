# Higgsfield Usage Policy

When Creative Studio is allowed to call Higgsfield, the rules.

## When Higgsfield CAN be called

Only after all of the following are true:

1. The concept has cleared the **Concept Gate** (AI Boardroom, Compliance ≥ 8).
2. The user has explicitly approved generation (no auto-trigger).
3. The asset format is one Higgsfield is rated for (still, image-to-video hook, B-roll, motion intro).
4. `request_id` + `org_id` + `campaign_id` are attached.
5. The prompt is the assembled four-layer stack with the default negative prompt.
6. Text zones and compliance strip are reserved (typed constraint).

## When Higgsfield CANNOT be called

- Concept Gate failed or wasn't run.
- The user did not explicitly approve generation (e.g., a planning session).
- The prompt instructs the model to render headlines, CTAs, logos, or legal text.
- The asset would carry a guarantee dollar amount without verified config.
- Off-premises model concerns trigger (borrower-adjacent text being processed).
- The skill is in spec-only mode (`LocalDraftSource` is the bound implementation).

## Drafts only

Higgsfield outputs land in a staging bucket with `status: draft`. Higgsfield cannot mark anything approved. Approval flows through the LegendsOS Boardroom Asset Gate + human sign-off.

## Audit

Every Higgsfield call writes to Supabase `generations`:

| Field | Value |
|---|---|
| `tool` | `higgsfield` |
| `prompt` | The full assembled prompt |
| `params` | aspect, kind, motion_notes |
| `cost` | tool cost if known |
| `latency_ms` | round-trip |
| `status` | `draft` |
| `request_id` | propagated |
| `org_id` | propagated |
| `created_by` | user_id |
| `created_at` | ISO8601 |

Generations are append-only. No row is ever updated or deleted; new state becomes a new row.

## Distribution

n8n distributes Higgsfield-produced assets only when:
- The asset has cleared the Asset Gate (Compliance ≥ 8).
- A human has signed off (Jeremy in v1).
- The distribution is to an approved channel.
- External publish requires explicit human sign-off, never auto.

## Higgsfield is a subsystem, not the OS

Higgsfield cannot:
- Set asset status to approved.
- Bypass the Boardroom gate.
- Write directly to the campaigns / templates / assets tables (LegendsOS owns that).
- Distribute to any external destination.

LegendsOS calls Higgsfield. LegendsOS receives the draft. LegendsOS runs the gate. LegendsOS records the result.

## Cost discipline

Higgsfield generations cost real money and quota. Do not:
- Burn generations on test prompts (use `LocalDraftSource` for tests).
- Re-generate the same prompt without changing inputs (cache by prompt hash + aspect).
- Trigger generations on every Creative Studio session (only on explicit user approve).
- Auto-regenerate when the boardroom returns "fix-then-publish" (re-run only after the fix is applied).
