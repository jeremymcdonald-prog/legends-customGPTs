# HeyGen Prompt Schema

Every HeyGen prompt is a block with these fields. The skill emits this block ready to paste into HeyGen project notes or pipe into a HeyGen API call when the connector exists.

## Fields

```yaml
heygen_prompt:
  asset_id: DAY03_IG_REEL_HG_REEL_BROKER_ADVANTAGE_001
  topic: Broker advantage — bank said wait, broker closed in a week
  audience: First time buyers in Northeast Florida, retail-lender skeptics
  length_seconds: 45
  format: vertical_1080x1920
  visual_style: cinematic_authority
  avatar:
    identity: jeremy_mcdonald_primary
    persona: coach
    energy: warm_directive
    pacing: brisk
  script: |
    A first time buyer in Mandarin had a credit ding mid underwriting.
    Their original lender said wait six months.
    We pulled the file, called three of our wholesale investors, and found the right overlay.
    Same loan amount. Same closing date. Closed in seven days.
    Brokers do not sell one shelf.
    Brokers shop the whole field.
    If you got a no last week, that no might just mean wrong shelf.
  on_screen_text:
    - "A bank said wait six months"
    - "We closed in a week"
    - "Same loan amount, different investor"
    - "Brokers shop, banks sell"
  broll:
    - cinematic_phone_call (Jeremy on a call, low light)
    - cinematic_keys_handoff (closing day handoff with orange accent on keys)
    - cinematic_mandarin_neighborhood (St. Johns suburb dusk light)
  caption_style: bold_clean_silver_white_with_orange_accent
  music_direction: warm_low_bpm_strings_no_vocals
  thumbnail:
    template_id: TMPL_REEL_COVER_BROKER_ADVANTAGE_v1
    headline: WE CLOSED IN A WEEK
    accent_word: WE
  end_screen:
    cta: DM NUMBERS for a second opinion on your file
    duration_seconds: 3
  compliance_footer: |
    Jeremy McDonald
    The Legends Mortgage Team powered by Loan Factory
    NMLS 1195266 | Loan Factory NMLS 320841
    Equal Housing Lender
    904-442-3213 | mcdonald-mtg.com
  risk_tier: Yellow
  story_source: BORROWER_MEMORY_007
  program_lines: []
```

## Required fields

`asset_id`, `topic`, `audience`, `length_seconds`, `format`, `visual_style`, `avatar.identity`, `avatar.persona`, `script`, `on_screen_text`, `caption_style`, `thumbnail.template_id`, `thumbnail.headline`, `end_screen.cta`, `risk_tier`.

## Conditional fields

- `compliance_footer` required when topic is mortgage-related.
- `story_source` required when video is story-based.
- `program_lines` required when VA / FHA / USDA / DSCR / guarantee.
- `broll` recommended; HeyGen alone is acceptable if no B-roll is named.

## Forbidden fields

- `customer_name` — never stored.
- `address` — never stored.
- `rate` — only when paired with APR + assumptions + Red approval.
