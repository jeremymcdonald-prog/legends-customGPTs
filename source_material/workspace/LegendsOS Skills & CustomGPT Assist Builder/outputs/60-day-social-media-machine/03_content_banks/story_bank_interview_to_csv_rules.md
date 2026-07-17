# Story Bank Interview → CSV Rules

How Claude converts an interview capture into the structured CSV rows and content drafts. Deterministic so the same input always produces the same outputs.

## Story type → framework map

| Q1 answer | Framework |
|---|---|
| VA buyer win | The Veteran Win |
| File save | The File Save |
| First time buyer | The First Time Buyer Confidence Shift |
| Move up buyer | The Move Up Buyer Strategy Story |
| Investor | The Investor Numbers Story |
| Realtor rescue | The Realtor Rescue |
| Closing day | The Closing Day Lesson |
| Payment strategy | The Payment Reality Check |
| AI for Realtor | The AI Helped the Realtor Win Story |
| Other (broker advantage angle) | The Broker Advantage Story |
| Other (appraisal / inspection) | The Appraisal or Inspection Curveball Story |

If "Other" is unclear, Claude picks the closest fit, names it on the confirmation step, and lets Jeremy correct it.

## Story ID assignment

- Next available ID is `STORY_xxx` where `xxx` is the next zero-padded integer after the highest existing story_id in `story_bank_intake_tracker.csv`.
- Story IDs are never reused or renumbered.

## Permission status mapping

| Q6 answer | permission_status | source_type default |
|---|---|---|
| Yes | `Internal Memory Only` (or `Public Review Source` if a real public review was pasted) | Borrower Memory / Realtor Scenario / Zillow Review / GBP Review |
| Needs review | `Needs Permission` | same |
| No, internal only | `Do Not Publish` | same |

`Approved` is only set when a written permission record exists (file path stored in `permission_record`).

## Compliance risk default

- Green: AI for Realtor stories with no mortgage data.
- Yellow: all standard mortgage stories with anonymization applied.
- Red: any story that names a real customer (and `permission_status = Approved`), quotes a specific rate, or names a guarantee dollar amount.

## Publish status decision tree

```
if all 11 publish gates close AND permission_status in (Internal Memory Only with anonymization, Public Review Source, Approved):
    publish_status = Publish Ready
elif any gate open:
    publish_status = Needs Review (notes field lists which gates)
elif Q6 = No, internal only:
    publish_status = Source Pending  # never reaches Publish Ready
else:
    publish_status = Needs Review
```

## Channel routing (story_to_content_map.csv)

| Framework | Default platforms |
|---|---|
| The File Save | FB Business, IG Reel, IG Feed, TikTok, YT Short, LinkedIn |
| The Veteran Win | FB Business, IG Feed, IG Reel, YT Short, GBP |
| The First Time Buyer Confidence Shift | IG Feed, IG Reel, TikTok, FB Business, GBP |
| The Realtor Rescue | LinkedIn, FB Business, IG Reel |
| The Payment Reality Check | IG Feed carousel, IG Reel, YT Long |
| The Broker Advantage Story | all channels |
| The Investor Numbers Story | LinkedIn, IG Reel, YT Long, FB Business |
| The Move Up Buyer Strategy Story | IG Feed, FB Business, GBP |
| The Appraisal or Inspection Curveball Story | IG Reel, TikTok, FB Business |
| The Closing Day Lesson | FB Personal, FB Business, IG Story, IG Feed |
| The AI Helped the Realtor Win Story | LinkedIn, IG Reel, TikTok, YT Short |

## Caption generation rules

- First-person, Jeremy's voice (per `_shared/brand-dna/voice.md`).
- Short sentences. One idea per line.
- Plain numbers ("20 percent," not "20%").
- No emojis. No em dashes.
- One CTA from the safe CTA library, matched to the framework.
- Compliance footer appended for any mortgage-related caption.
- Program-specific line appended for VA / FHA / USDA / DSCR.

## Reel script generation rules

- Hook (0 to 2 seconds).
- Setup (2 to 8 seconds).
- Body (8 to 45 seconds).
- Land + CTA (last 5 to 7 seconds).
- 3 to 5 on-screen text lines.
- Persona: Coach for File Save / Veteran / Closing Day / Realtor Rescue / Broker Advantage; Inside Man for FTHB / Investor / Payment / AI; Wolf rarely (market-leaning).

## HeyGen prompt rules

Filled to the schema in `companions/11-heygen-video-system/knowledge/heygen-prompt-schema.md`:

- asset_id, topic, audience, length, format, visual_style, avatar (Jeremy primary + persona), script, on_screen_text, broll, caption_style, music_direction, thumbnail (template + headline + accent), end_screen, compliance_footer, story_source = story_id, risk_tier, program_lines.

## Canva prompt rules

Filled to the schema in `companions/10-canva-template-system/knowledge/template-field-schema.md`:

- Template picked from the canva-template-map.md by framework + platform.
- Headline from the caption hook (max length per template).
- Accent word from the framework's accent list (e.g., WE, ZERO, FOUR, REAL, TODAY).
- NMLS + EHO + disclaimer locked.
- Image plate ID points to Higgsfield only when premium (Closing Day, Personal Brand, Local Authority).

## GBP post rule

Append a GBP draft to `story_based_gbp_posts.csv` when the story's `market_area` is set AND the framework is one of: Veteran Win, First Time Buyer, Closing Day, Local Authority, Broker Advantage, Investor (with business-purpose line), Move Up, Payment Reality Check.

## LinkedIn post rule

Append a LinkedIn draft to `story_based_linkedin_posts.csv` when the framework is one of: Broker Advantage, Investor Numbers, Realtor Rescue, AI Helped the Realtor Win, Veteran Win (leadership lens), Payment Reality Check.

## Sensitive data scrub (always applied before write)

- Strip any first/last name from public-facing fields. Keep in `borrower_name_do_not_publish` only.
- Strip any address pattern. Keep in `property_address_do_not_publish` only.
- Strip any rate, payment, credit, income, asset, loan amount, down payment dollar figure. Keep in `private_numbers_do_not_publish` only.
- Strip competitor lender names. Substitute "a retail lender" or "a national bank."
- Strip banned phrases. Substitute compliant alternatives.

## Em-dash and emoji scrub

- Replace `—` with commas, periods, or ellipses.
- Strip emojis.

## Write order

1. Append capture row to `story_bank_interview_capture_template.csv`.
2. Append intake row to `story_bank_intake_tracker.csv`.
3. Append to `story_bank_publish_ready.csv` or `story_bank_needs_review.csv` per decision tree.
4. Append channel rows to `story_to_content_map.csv`.
5. Append draft rows to `story_based_caption_drafts.csv`, `story_based_reel_scripts.csv`, `story_based_heygen_prompts.csv`, `story_based_canva_prompts.csv`.
6. Optionally append to `story_based_gbp_posts.csv` and `story_based_linkedin_posts.csv` per rules above.

## Confirmation gate

Claude shows Jeremy the summary BEFORE writing anything. Only on explicit confirmation do the writes proceed. If Jeremy says "wait" or makes corrections, Claude updates the capture and re-confirms.

## What this never does

- Invents content.
- Bypasses compliance gates.
- Auto-publishes.
- Marks any row Final-ready in HeroPost.
- Inserts a real `hosted_media_url` (always leaves `STAGING_PENDING_MEDIA` until the asset is rendered and hosted).
