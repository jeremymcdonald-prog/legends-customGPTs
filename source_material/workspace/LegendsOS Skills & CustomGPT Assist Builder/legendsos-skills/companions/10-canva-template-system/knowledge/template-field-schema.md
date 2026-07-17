# Template Field Schema

Per-template field list. Required fields are bold. Optional fields are plain. The footer block is always required.

## Common universal fields (every template)

- **asset_id**
- **headline**
- subhead
- accent_word
- **cta** (or `none`)
- **nmls_block** = `NMLS 1195266 | Loan Factory NMLS 320841`
- **eho_block** = `Equal Housing Lender`
- disclaimer_block
- image_plate_url
- image_plate_id
- **export_format**
- **export_filename**

## TMPL_FEED_MORTGAGE_STORY_v1

- Canvas: 1080x1350
- Platform: IG Feed, FB Business
- Required: asset_id, headline, body_summary (3 to 5 short lines), cta, nmls_block, eho_block, export_format, export_filename
- Optional: source_id_label (e.g., "Anonymized story"), accent_word, image_plate_url
- Footer placement: bottom 12% of canvas

## TMPL_CAROUSEL_EDUCATION_v1

- Canvas: 1080x1350, 10 slides
- Required per slide: slide_number, slide_headline
- Required overall: asset_id, cta (on last slide), nmls_block (on last slide), eho_block (on last slide), export_format = png, export_filename pattern with `_s01..._s10`
- Slide 1: hook
- Slides 2 to 8: idea per slide
- Slide 9: takeaway
- Slide 10: CTA + footer

## TMPL_CAROUSEL_BROKER_ADVANTAGE_v1

- Canvas: 1080x1350, 8 slides
- Same overall rules as Carousel Education
- Slide 1: hook
- Slides 2 to 7: broker advantage points
- Slide 8: CTA + footer

## TMPL_FEED_CLOSING_DAY_v1 and TMPL_FEED_CLOSING_DAY_VA_v1

- Canvas: 1080x1350
- Required: asset_id, headline ("Closing day"), location_label (city or county), cta, nmls_block, eho_block, export_format, export_filename
- Optional: image_plate_url (cinematic still), accent_word
- VA variant additionally: **va_non_endorsement_line** = `VA is a government benefit program. Not affiliated with or endorsed by the VA.`

## TMPL_FEED_FTHB_v1

- Canvas: 1080x1350
- Required: asset_id, headline, body_summary, cta, nmls_block, eho_block, export_format, export_filename
- Optional: image_plate_url, accent_word, source_id_label

## TMPL_FEED_BROKER_VS_BANK_v1

- Canvas: 1080x1350
- Required: asset_id, headline, contrast_line_1, contrast_line_2, cta, nmls_block, eho_block, export_format, export_filename
- Forbidden: competitor names

## TMPL_FEED_REALTOR_AI_TIP_v1

- Canvas: 1080x1350
- Required: asset_id, headline, ai_tip_summary, cta, nmls_block (Jeremy attribution may be omitted on educational AI posts), eho_block, export_format, export_filename
- Optional: image_plate_url

## TMPL_FEED_LOCAL_AUTHORITY_v1

- Canvas: 1080x1350
- Required: asset_id, headline, location_label, body_summary, cta, nmls_block, eho_block, export_format, export_filename

## TMPL_FEED_DSCR_BASICS_v1 / TMPL_CAROUSEL_DSCR_BASICS_v1

- Required overall fields plus **business_purpose_line** = `For business-purpose lending. Terms differ from consumer loans.`

## TMPL_FEED_MOTIVATIONAL_v1 / TMPL_FEED_PERSONAL_BRAND_v1 / TMPL_FEED_GYM_DISCIPLINE_v1 / TMPL_FEED_DATE_NIGHT_v1

- Canvas: 1080x1350
- Required: asset_id, headline (often the quote), accent_word, eho_block (optional on pure personal-brand pieces; required when post mentions broker context)
- nmls_block optional on pure personal posts

## TMPL_GBP_* family (FTHB, VA, BROKER_ADVANTAGE, DSCR, REALTOR_AI, LOCAL_AUTHORITY)

- Canvas: 1200x900
- Required: asset_id, headline, body_summary, cta, nmls_block, eho_block, location_label, export_format = png, export_filename
- DSCR variant requires business_purpose_line
- VA variant requires va_non_endorsement_line

## TMPL_YT_LONG_THUMB_v1, TMPL_YT_LONG_DSCR_THUMB_v1

- Canvas: 1280x720
- Required: asset_id, headline (max 3 words), accent_word, face_plate_url (Jeremy face), nmls_block (small bottom), eho_block, export_format = jpg, export_filename

## TMPL_YT_SHORT_*

- Canvas: 1080x1920
- Required: asset_id, headline (max 4 words), accent_word, image_plate_url, nmls_block (small bottom), eho_block, export_format = jpg, export_filename

## TMPL_REEL_COVER_*

- Canvas: 1080x1920
- Required: asset_id, headline (max 4 words), accent_word, image_plate_url, export_format = jpg, export_filename
- Footer compact at bottom; nmls and eho required on mortgage covers

## TMPL_STORY_4_FRAME_v1 / TMPL_STORY_5_FRAME_VA_v1

- Canvas: 1080x1920 per frame
- Required: asset_id, frame_1_text, frame_2_text, frame_3_text, frame_4_text (and frame_5_text on VA), cta_frame_text, nmls_block (last frame), eho_block (last frame), export_format = png, export_filename pattern with `_f01..._f0N`
- VA variant adds va_non_endorsement_line on the last frame

## TMPL_LINKEDIN_*

- Canvas: 1200x1200
- Required: asset_id, headline, body_summary, accent_word, nmls_block, eho_block, export_format = png, export_filename

## TMPL_GUARANTEE_v1 (gated)

- Canvas: 1080x1350
- Required: asset_id, headline, **guarantee_amount** (only renders when `current_guarantee_offer` is verified), **eligible_states_block** = `Available in all states except Washington.`, **terms_url** = `loanfactory.com/best-price-guarantee`, **not_commitment_block** = `This is not a commitment to lend. All loans subject to credit approval. Rates, terms, and fees subject to change without notice.`, nmls_block, eho_block, export_format, export_filename
- Hard gate: if any of guarantee_amount, eligible_states_block, terms_url, not_commitment_block is empty, template refuses to render
