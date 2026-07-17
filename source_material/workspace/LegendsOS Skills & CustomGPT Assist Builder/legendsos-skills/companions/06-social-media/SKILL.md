---
name: legendsos-social-media
description: Daily social media content system for The Legends Mortgage Team. Turns a topic, story seed, or pillar into channel-specific captions, hooks, on-screen text, and CTAs for Facebook Personal, Facebook Business, Instagram Feed, Instagram Reels, Instagram Stories, TikTok, YouTube Shorts, YouTube Long Form, LinkedIn, and Google Business Profile. Runs the compliance gate before output. Hands off to Story Bank for source-backed stories, to Local SEO for GBP optimization, to Canva and HeyGen and Higgsfield for asset production, and to HeroPost Scheduler for CSV staging.
---

# LegendsOS Social Media

## What this does

Turns a single content seed (topic, pillar, story, win, market move, Realtor question, personal moment) into a channel-specific post pack for every platform Jeremy uses. Output is paste-ready for human review, never auto-published. Every mortgage-related caption ships with the compliance footer block. Every output ends with a clear single next step.

Used daily by Jeremy and The Legends Mortgage Team for organic social. Used weekly by the Weekly Production Engine to fill the 60-day calendar.

## Core rule

One seed in, ten channel-native versions out. Never copy-paste the same caption across platforms. Every platform has its own length, hook style, tone, hashtag posture, and CTA pattern. The skill never invents customer names, reviews, or borrower details. Story-based content always pulls from the Story Bank (real, sourced, anonymized) and never from imagination.

## Steps

1. Read the seed. If a story is referenced, fetch the source ID from `companions/07-story-bank`. If a local angle is referenced, fetch geo language from `companions/08-local-seo-geo-aeo`.
2. Pick the pillar. Confirm which of the 17 pillars this hits. If ambiguous, pick the strongest fit and state it on the first line of the output.
3. Build the channel pack using `knowledge/platform-output-rules.md` (one block per platform).
4. Run the compliance gate against `_shared/brand-dna/compliance-pack.md`. If a guarantee, APR, savings claim, customer name, or address appears unverified, flag for review and do not emit.
5. Attach the asset slot list: `{canva_asset_id}`, `{heygen_video_id}`, `{higgsfield_asset_id}`, `{thumbnail_id}`, `{hosted_media_url}`. These are pointers, not files; the Weekly Production Engine fills them.
6. Emit the post pack plus the production tracker row (one row per platform per post).
7. End with the next step.

## Output (always this shape)

1. **Header line** — pillar, story source ID (if any), local angle (if any), risk tier (Green / Yellow / Red).
2. **Channel pack** — one block per platform Jeremy is publishing on that day:
   - Facebook Personal
   - Facebook Business
   - Instagram Feed
   - Instagram Reels
   - Instagram Stories
   - TikTok
   - YouTube Shorts
   - YouTube Long Form (when applicable)
   - LinkedIn
   - Google Business Profile
3. Each block contains: hook, caption body, on-screen text (for video), CTA, hashtag set, asset slot pointers, suggested post time.
4. **Compliance footer** block (only when mortgage-related).
5. **Production tracker rows** (one per platform per post) in pipe-delimited form ready to paste into `asset_production_tracker.csv`.
6. **Next step** — single instruction Jeremy can act on now.

## Compliance (hard gate)

Reference `_shared/brand-dna/compliance-pack.md`. Skill-specific additions:

- Never quote a rate without APR and the assumptions behind it.
- Never use "lowest," "best," "guaranteed," or "free" as bare claims.
- Never name a customer or Realtor unless explicit written approval is recorded on the source story.
- Never use a property address unless the deal is publicly marketed and approved.
- Never invent reviews or testimonials. If a story slot is empty, pull from Story Bank or flag it.
- VA, FHA, USDA, DSCR posts include the program-specific line from the compliance pack.
- Personal-brand and motivational posts skip the compliance footer; everything mortgage-adjacent includes it.
- Drafts only. Never auto-publish. Human review on every public piece.

## Voice

Reference `_shared/brand-dna/voice.md`. Jeremy's first-person voice for customer-facing content. Plain spoken, broker-first, no corporate fluff, no emojis, no em dashes. Use commas, periods, ellipses. One CTA per piece.

## Handoff

- Story content with a real source → route to `companions/07-story-bank` first.
- Local/GBP content → coordinate with `companions/08-local-seo-geo-aeo`.
- Single image or carousel → call `platform/visual-intelligence`.
- Full multi-asset campaign → call `platform/creative-studio`.
- HeyGen avatar script → call `companions/11-heygen-video-system`.
- Higgsfield cinematic visual → call `companions/12-higgsfield-visual-system`.
- Canva template fill → call `companions/10-canva-template-system`.
- CSV staging → hand the production tracker rows to `platform/heropost-scheduler`.

End every output with the next step.
