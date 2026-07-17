# Generation Tier Logic

Decision rules for when Creative Studio spends a Higgsfield generation vs uses a cached / library / spec-only asset.

## Tier 0 — Spec only (no generation)

**Default mode today.** `LocalDraftSource` is bound. Creative Studio returns the assembled prompt, the Canva build, the boardroom review, and the storage metadata. No file is generated.

**Used when:**
- Higgsfield MCP isn't connected.
- The user is planning, not approving.
- Iterating on the prompt before generation.

## Tier 1 — Reuse from library (no generation)

Creative Studio first checks Supabase `assets` for an existing draft or approved asset matching the engine, layout, format, and tags. If found and still on-brand, reuse it.

**Used when:**
- B-roll scene packs already exist for the topic (e.g., command center, neighborhood dusk).
- A close-enough cinematic plate exists from a prior campaign.
- The "Realtor version" of an asset already lives in the library.

## Tier 2 — Generate once, reuse many (1 generation)

The cinematic plate is generated once. Canva then produces all platform exports from that one plate.

**Used when:**
- New campaign concept with no existing plate.
- Topic warrants its own dedicated visual asset.

## Tier 3 — Multiple generations (2+ generations)

Only when the campaign actually needs distinct visuals: a 16:9 thumbnail with different composition than the 1:1 post, an image-to-video hook that requires a different camera angle.

**Cap:** Default cap is 3 Higgsfield generations per campaign kit unless the boardroom explicitly recommends more.

## Tier 4 — Full kit production (3-6 generations)

Reserved for highest-leverage campaigns: webinar launches, Best Price Guarantee campaign, major authority pushes.

**Used when:**
- Webinar campaign kit (hero, reel teaser, thumbnail, email header, recap).
- Best Price Guarantee multi-channel push.
- Major authority video with multiple thumbnail / cover variations.

**Cap:** 6 generations per kit unless owner approves more.

## Decision rules (in order)

```
1. Is Higgsfield connected? If no → Tier 0.
2. Did the concept clear the Concept Gate? If no → stop, return review note.
3. Is there a library match (engine + layout + format + tags)? If yes → Tier 1.
4. Does this campaign call for multiple distinct visuals? If no → Tier 2.
5. Did the boardroom recommend additional generations? Cap by Tier 3 default.
6. Is this a webinar / guarantee / major authority push? Tier 4 with owner approval.
```

## Cost protection

- Every generation request includes a `cost` estimate before execution. If the estimate exceeds the per-campaign cap, prompt the user before continuing.
- Cache by `hash(prompt + aspect + negative_prompt)`. Identical inputs return the cached `asset_url`.
- B-roll scene packs are generated once and tagged for indefinite reuse.

## What never counts against the cap

- LocalDraftSource calls (spec only).
- Library matches (no new generation).
- HeyGen calls (separate API, separate budget).
- Canva exports (free per Pro account).
