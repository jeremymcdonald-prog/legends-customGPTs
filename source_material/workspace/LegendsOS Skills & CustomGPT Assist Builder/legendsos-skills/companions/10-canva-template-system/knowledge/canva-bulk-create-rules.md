# Canva Bulk Create Rules

## What Bulk Create does

Canva's Bulk Create feature ingests a CSV and produces one design per row, mapped to template fields. This skill writes the CSV rows.

## CSV header convention

Each template's CSV header is the ordered field list from `template-field-schema.md` for that template. Templates differ; do not mix templates in one CSV.

## Universal columns

Every template CSV includes these columns (regardless of template):

- `asset_id` — `{day}_{platform}_{template_id}_{variant}` per `asset-export-rules.md`
- `headline`
- `subhead`
- `accent_word`
- `cta`
- `nmls_block`
- `eho_block`
- `disclaimer_block` (program-specific or "none")
- `image_plate_url` (when template has an image plate)
- `image_plate_id` (Higgsfield or Visual Intelligence asset ID when applicable)
- `export_format` (`png`, `jpg`, `mp4`)
- `export_filename`

## Row validation rules

The skill validates before emitting:

- `asset_id` is unique inside the CSV.
- `headline` non-empty.
- `cta` is from the safe CTA list (or explicitly marked `none`).
- `nmls_block` includes 1195266 (when Jeremy attributed) and 320841 (Loan Factory).
- `eho_block` is present.
- `disclaimer_block` matches program tag (VA, FHA, USDA, DSCR, guarantee).
- `image_plate_url` resolves to a file path or hosted URL (else `STAGING_PENDING_IMAGE`).
- `export_filename` follows `asset-export-rules.md`.

## Escaping rules

- Commas inside cells are wrapped in double quotes.
- Line breaks inside cells are wrapped in double quotes and use `\n` escape if Canva requires.
- Quote characters inside cells are doubled.

## CSV mode vs single-fill mode

- Single fill returns one row.
- Batch fill returns multiple rows under one template header.
- Multi-template batch returns multiple files, one per template.

## What this skill does not control

- The actual Canva Bulk Create execution. Operator (or future Canva MCP connector) runs the job.
- Export hosting. Exports go to the operator's drive and then into the media URL tracker.
