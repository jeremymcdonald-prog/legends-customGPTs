# B-Roll Rules

B-roll is the visual texture under the script. The skill names B-roll cues; the operator (or Higgsfield / Visual Intelligence) produces or sources them.

## When to call B-roll

- Story videos: B-roll bridges the lesson.
- Long form: every chapter gets at least one B-roll plate.
- Market updates: B-roll under data callouts.
- Personal brand: real lifestyle footage from Jeremy preferred.

## B-roll categories

| Category | Examples |
|---|---|
| Cinematic real | Jeremy on a call, at his desk, in the gym, on the road |
| Cinematic AI plate | Florida lifestyle scenes, abstract market metaphors, luxury closing scenes |
| Static graphics | Carousel-style stats or callouts |
| Lifestyle stock (sparingly) | Florida coast, downtown Jacksonville skyline |
| Document close-up | Generic application or rate-sheet stand-in, never showing real loan data |

## Hard rules

- No real customer photos without written permission.
- No real loan documents on camera.
- No competitor logos.
- No third-party brand marks unless licensed (NFL, Disney, etc.) — not the move anyway.
- No depiction of a Realtor's branded sign unless approved co-brand.

## Florida coastal B-roll set

- St. Augustine waterfront dawn
- Jacksonville Beach pier
- Nocatee greenway
- Ponte Vedra coastal cinematic
- Downtown Jacksonville skyline
- Mandarin tree-lined neighborhood

## AI plate handoff to Higgsfield

When a B-roll cue calls for an AI plate, the skill emits:

```
broll_ai_plate:
  source: higgsfield
  prompt_id: HF_CINEMATIC_KEYS_HANDOFF_v1
  description: Closing day handoff cinematic still, dark luxury palette, orange accent on the keys.
```

The Higgsfield skill then picks up that prompt ID.

## Sound design alongside B-roll

- Music persists under cuts.
- Light foley on key visual moments (key click, door close) sparingly.
- No stock "swoosh" or transition sounds. They date the video.
