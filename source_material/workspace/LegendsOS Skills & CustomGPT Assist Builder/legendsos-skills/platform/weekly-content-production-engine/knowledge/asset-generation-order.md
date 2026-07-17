# Asset Generation Order

The order matters. Cheaper assets first. Premium last.

## Per-week order

1. **Source IDs.** Story Bank pulls every needed source ID for the week.
2. **Captions and scripts.** Social Media skill writes the caption packs. HeyGen skill writes the scripts.
3. **Local canonical pieces.** Local SEO skill produces GBP posts and blog outlines.
4. **Canva Bulk Create rows.** Canva Template System writes the CSV rows for the week's text-first assets.
5. **Canva fills (operator step).** Operator runs Bulk Create in Canva, exports.
6. **Higgsfield plates.** Higgsfield generates premium stills and motion plates (after Concept Gate).
7. **HeyGen renders.** HeyGen renders the avatar videos.
8. **Thumbnails.** Canva thumbnails for YT Long, YT Short, Reel covers.
9. **Hosted URLs.** Operator uploads, fills `media_url_tracker.csv`.
10. **HeroPost final.** Scheduler promotes ready rows to Week N final CSV.

## Why this order

- Captions and scripts validate concept before any expensive render runs.
- Canva is the cheapest production layer; doing it first means assets are ready as Higgsfield and HeyGen catch up.
- Higgsfield is the most expensive; gating it after concept clears prevents waste.
- HeyGen needs the script and any B-roll plates that Higgsfield produced.
- Thumbnails are cheap and last because they often want the video's still as input.

## Parallelism

Canva fills, Higgsfield generations, and HeyGen renders can run in parallel inside the same day. The Engine tracks each independently and waits for all three before HeroPost promotion.

## Failure handling

- If a Higgsfield plate fails, swap to a Canva-only fallback for that asset.
- If HeyGen is down, swap to Jeremy on camera or skip the video and rely on text-only.
- If Canva Bulk Create fails, fill manually for the week and log the failure.
- Each fallback writes a note in the production tracker.
