# Usage Notes — Canva Template System

## When to invoke

- "Build the field schema for [template]."
- "Fill template [name] for [day / pillar / story source]."
- "Generate the Bulk Create CSV row for [day] [platform]."
- "Spec a new template for [use case]."

## Two modes

1. **Spec mode** — define a template (canvas, fields, layout, exports).
2. **Fill mode** — produce a Bulk Create CSV row that drops into a Canva Bulk Create job.

## What this skill never does

- Generate images. Image plates come from Higgsfield, Visual Intelligence, or HeyGen frames.
- Edit Canva files directly (no MCP for that). Outputs are CSV rows the operator pastes into Bulk Create.
- Skip compliance footers.
- Place a guarantee dollar amount without verified current config.

## The Canva Bulk Create workflow Jeremy uses

1. Pick the template in Canva.
2. Click Bulk Create.
3. Upload the CSV row(s) this skill produced.
4. Map columns to fields.
5. Export.
6. Drop exports into the media URL tracker so URLs land in the right HeroPost row.

## Pairing with image-plate skills

When a template has a `{image_plate}` field, this skill specifies the Higgsfield or Visual Intelligence prompt that the image-plate skill must produce. The image-plate skill produces the image. The Canva skill receives the image path or URL and includes it in the Bulk Create row.
