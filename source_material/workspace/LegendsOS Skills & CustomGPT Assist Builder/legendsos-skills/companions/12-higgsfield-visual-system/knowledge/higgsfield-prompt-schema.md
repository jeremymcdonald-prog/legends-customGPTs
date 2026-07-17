# Higgsfield Prompt Schema

The four-layer prompt structure plus the metadata Higgsfield needs.

## Block shape

```yaml
higgsfield_prompt:
  asset_id: HF_CINEMATIC_KEYS_HANDOFF_v1
  use_case: cinematic_still
  aspect: 1080x1350
  motion: false
  reserved_text_zones:
    - bottom_18pct
  style_preset: cinematic_authority_dark_luxury
  brand_dna_layer: |
    Dark luxury mortgage command center. Cinematic realism. Charcoal #1A1A1A and black #0A0A0A base. One accent in Loan Factory orange #F26A21 or champagne gold #C9A24B, not both. Premium, controlled, professional. Subtle film grain. Soft bokeh. Clean directional lighting. Mobile-first composition.
  engine_layer: |
    Cinematic Authority engine. Subject-centered or hero-positioned. Minimal text zones. Gold or orange accent on one element. Quiet luxury, not flashy. Trustworthy, leadership.
  asset_layer: |
    Close-up cinematic still of a closing-day key handoff between two anonymous hands. Warm interior light, late afternoon. Orange accent on the keychain. Background softly bokeh'd at a closing table edge. No faces in frame. No documents in frame. No logos.
  negative_prompt: |
    text, captions, watermark, logo, brand mark, bank name, customer face, real loan document, fake check, currency overlay, cartoon, clip art, stock photo style, rainbow, neon, overlay UI, third type family, cluttered composition, low resolution, deformed hands, extra fingers, cinematic overdone HDR
  motion_notes: null
  request_id: REQ-{{generated}}
  org_id: ORG-LegendsMortgage
  campaign_id: 60DAY-SOCIAL-MACHINE
  status: draft
  concept_gate_status: pending
```

## Field rules

| Field | Rule |
|---|---|
| `asset_id` | Unique. Pattern `HF_{style}_{subject}_v{n}`. |
| `use_case` | `cinematic_still`, `image_to_video`, `bro_roll_plate`, `motion_background`. |
| `aspect` | Numeric WxH or named ratio. Match the publish surface. |
| `motion` | Boolean. True when an image-to-video or motion background. |
| `reserved_text_zones` | List of regions (`top_12pct`, `bottom_18pct`, `right_40pct`, etc.). |
| `style_preset` | From `style-presets.md`. |
| `brand_dna_layer` | Pull from `_shared/prompt-components/brand-dna-prompt.md`. |
| `engine_layer` | Pull from `_shared/prompt-components/engine-prompt-reference.md`. |
| `asset_layer` | The specific subject and scene. The only layer that changes per asset. |
| `negative_prompt` | Default from `_shared/knowledge/default-negative-prompt.md` plus per-asset additions. |
| `motion_notes` | When motion is true: motion description, duration, loop seam, easing. |
| `request_id`, `org_id`, `campaign_id` | Always present for audit. |
| `status` | Always `draft` at emit. |
| `concept_gate_status` | `pending`, `cleared`, `blocked` with reason. |

## Hard validation

The skill refuses to emit if:

- `asset_layer` contains the words "text," "headline," "caption," "logo," "watermark," "rate," "guarantee," "APR," "$".
- `asset_layer` names a real person other than Jeremy.
- `asset_layer` names a competitor or bank.
- `negative_prompt` is missing.
- `reserved_text_zones` is missing when downstream Canva text is planned.

## Re-use rule

Same `asset_id` can be regenerated with `_v2`, `_v3` suffixes. Never silently overwrite.
