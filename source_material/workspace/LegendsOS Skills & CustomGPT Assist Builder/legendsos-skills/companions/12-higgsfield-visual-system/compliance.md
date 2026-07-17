# Compliance — Higgsfield Visual System

Reference `_shared/brand-dna/compliance-pack.md` and `platform/creative-studio/higgsfield/usage-policy.md`.

## Hard blocks (Higgsfield-specific)

- No text rendering inside the visual (headlines, CTAs, logos, legal text).
- No guarantee dollar amount in the prompt or output.
- No unauthorized depictions of real people (Jeremy authorizes himself).
- No competitor brand marks (no bank logos, no named competitors).
- No fake or real loan documents in the visual.
- No private borrower data.
- No content that implies government endorsement (VA, FHA, USDA).
- No depictions that imply guaranteed approval, lowest rate, or specific savings.

## Required guardrails per prompt

- Default negative prompt attached.
- Reserved text zones declared.
- Concept Gate run before live generation.
- `request_id`, `org_id`, `campaign_id` placeholders present.

## Status defaults

- All Higgsfield outputs land in staging with `status: draft`.
- Higgsfield cannot promote an asset to approved. Approval flows through the Boardroom Asset Gate.

## Audit

Per `platform/creative-studio/higgsfield/usage-policy.md`, every call writes to `generations` table with tool=higgsfield, prompt, params, cost, latency_ms, status, request_id, org_id, created_by, created_at. Append-only.

## When the skill must REFUSE

- Prompt instructs Higgsfield to render text.
- Prompt instructs Higgsfield to depict a real person who is not Jeremy and is not authorized.
- Prompt instructs Higgsfield to render a guarantee or rate.
- Prompt would produce a logo or brand mark.
- Concept Gate is not cleared and the user asks for live generation.
