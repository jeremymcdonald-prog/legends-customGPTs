# Weekly Higgsfield Asset Batch Rules

## Default weekly batch

- 3 cinematic stills (1 closing-day plate, 1 personal brand plate, 1 broker authority plate)
- 2 motion plates (1 long form intro/outro, 1 Reel hook)
- 1 reserved slot for a premium asset (campaign push, signature moment)

## Order of generation

1. Long form intro/outro (sets the weekly look).
2. Closing day plate (likely Friday content).
3. Broker authority plate (Monday lead pillar).
4. Personal brand plate (Friday or Saturday).
5. Reel hook (any short-form story video).
6. Reserved premium (only if needed).

## Concept Gate cadence

- All 6 prompts go through Concept Gate at the start of the week as a batch.
- Once cleared, generation runs.
- Drafts land in staging.
- Asset Gate run before any asset moves to Approved.

## Cost discipline

- Track render minutes by week.
- If a week trends over budget, the skill defers the reserved premium slot.
- If a week ships under budget, the spare slot can become a Realtor partner cinematic.

## Pairing

- Each Higgsfield asset pairs to a Canva template (text layer).
- Each motion asset pairs to a HeyGen video where applicable.
- Each asset gets a `hosted_media_url` slot in the media URL tracker.

## When to skip a batch

- Concept Gate blocks a prompt and the rewrite isn't ready in time.
- HeyGen pipeline is down (motion assets may go unused).
- Operator capacity is constrained.

In any skip case, the skill emits a deferral note and the Weekly Production Engine reweights the week's Canva-only assets.
