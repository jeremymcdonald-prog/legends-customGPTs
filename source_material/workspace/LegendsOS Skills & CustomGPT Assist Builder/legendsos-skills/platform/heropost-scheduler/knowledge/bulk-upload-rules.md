# Bulk Upload Rules

## What "upload" means here

The skill never performs the upload. Operator (or future automation) imports the final CSV into HeroPost.

## Pre-upload checklist

Before the operator imports a final CSV:

- All Media URLs resolved (no placeholders).
- All Thumbnail URLs resolved where required.
- All Date cells in the future at upload time (HeroPost typically requires future-scheduled).
- All Type strings match the locked list.
- All Caption cells under platform character cap (skill provides per-platform soft caps but HeroPost enforces).
- All compliance flags closed (no `BLOCKED:` in Comment).

## Upload sequencing

- Recommended: one final CSV per week (Week 1, Week 2, ...).
- Avoid: importing all 60 days at once. Production drift means later weeks need adjustment.
- Cadence: import a week 24 to 48 hours before its first scheduled post.

## Post-upload reconciliation

After upload:

- Mark Production Tracker rows as `Scheduled`.
- Save the imported CSV to `outputs/60-day-social-media-machine/06_heropost/imported/`.
- Capture HeroPost's job ID or run reference if available.

## Failure handling

If HeroPost rejects rows:

- Capture the rejection reasons in the validation report.
- Move rejected rows back to staging with `BLOCKED: heropost_rejection: {reason}` in the Comment column.
- Fix and re-stage.

## Connector option

If a HeroPost MCP or API connector becomes available, the upload step can move from operator-manual to automation. The `docs/mcp-connector-audit.md` file tracks status.
