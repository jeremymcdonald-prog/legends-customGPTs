# Weekly Production Batch Rules

The Weekly Production Engine drives the cadence. The Social Media skill is the executor for the captions and tracker rows inside each week.

## What "batch" means here

A batch is one week's worth of content for one or more platforms, planned, written, and prepped for asset production.

## Weekly batch sequence (from the engine)

1. Engine locks the week's calendar (pillar, platform, story source if any, local angle if any).
2. Engine asks Social Media skill for the week's caption pack — one daily seed at a time, or all 7 days in one batch.
3. Social Media skill returns post packs + tracker rows + asset slot pointers.
4. Engine routes the asset slots to:
   - Canva Template System for static assets
   - HeyGen Video System for avatar videos
   - Higgsfield Visual System for cinematic stills/motion
5. Engine collects asset hosted URLs from the media URL tracker.
6. Engine asks HeroPost Scheduler to convert staging rows to final rows.
7. Engine outputs `heropost_week_N_ready.csv`.

## What this skill is responsible for inside the batch

- Caption packs (per platform).
- On-screen text packs (for video).
- Hashtag sets.
- CTAs (one per piece, from the safe CTA library).
- Tracker rows (staging format).
- Compliance review notes when applicable.

## What this skill is NOT responsible for inside the batch

- Generating the asset (Canva, HeyGen, Higgsfield).
- Hosting the asset.
- Filling `Media` or `Thumbnail` columns with URLs.
- Final HeroPost CSV.
- Posting.

## Batch hygiene

- The skill flags any day where more than 30 percent of the week's pillar load lands. Variety is a compliance and engagement lever.
- The skill flags any two consecutive days where the same story type repeats.
- The skill flags any day missing a Story Bank source on a slot reserved for a story.
- The skill flags any day where a Yellow/Red item lacks a noted reviewer.

## Batch carryover

If Week N performance review (from the Engine) suggests pillar A is over-saturating, the Engine reweights Week N+1. The skill respects the new weights without rewriting Week N's locked content.
