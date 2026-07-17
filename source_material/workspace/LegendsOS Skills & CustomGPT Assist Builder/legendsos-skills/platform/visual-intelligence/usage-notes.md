# Visual Intelligence — Usage Notes

## Engine selection cheatsheet

| You want to... | Engine | Default layout |
|---|---|---|
| Build trust / look like the authority | Cinematic Authority | Hero Portrait, Cinematic Office, Luxury Command Center |
| Stop the scroll with contrast or tension | Pattern Interrupt (use sparingly) | Split Screen, Myth Buster |
| Teach one mortgage idea fast | Educational Minimal | Market Update Card, Loan Program Spotlight, Checklist |
| Show a closing or celebration | Cinematic Authority | Closing Celebration |
| Promote a webinar | Cinematic Authority + Educational | Webinar Promo Card |
| Win or keep Realtor partners | Educational Minimal | Realtor Partner Education |
| Real testimonial | Cinematic Authority | Testimonial Proof Card |

## Pattern Interrupt discipline

Use sparingly. One Pattern Interrupt per 5 to 8 posts max. Never names or depicts a real competitor. The pain side is generic: "the big retail lender," "the bank," not Wells Fargo, not Chase.

## Caption rules

- Jeremy's voice. Plain, confident, broker-first.
- Short lines. No em dashes.
- One CTA per piece. Never stack.
- Always end with a next step.

## When to swap to a different skill

| If the user asks for... | Route to |
|---|---|
| A campaign kit (multi-asset, multi-format) | `platform/creative-studio` |
| Boardroom-level review of the concept, not just the image | `platform/ai-boardroom` |
| A HeyGen avatar script | `companions/02-heygen-video` |
| A Reel / Short with shot list + B-roll plan | `companions/03-broll-ai-video` |
| The email body that wraps the email header graphic | `companions/04-email-newsletter` |
| The social post copy that pairs with the image | `companions/06-social-media` |

## What this skill never does

- Renders text in the AI image (Canva owns text).
- Outputs a rate number on-image without APR context.
- Names or depicts a real competitor.
- Outputs a guarantee creative without verified config.
- Skips the boardroom review.
- Approves at Compliance score < 8.

## Producing a Realtor / partner co-brand version

When the user asks for "the Realtor version" of any image:
- Reserve a partner logo lockup zone on the canvas.
- Add the partner's licensing alongside Loan Factory's.
- Apply RESPA-safe language (no thing-of-value-for-referrals).
- Keep the value-first tone: "Let's make your buyers look smart." / "Want the Realtor version?"

## Pairing with Visual Boardroom scoring

Every output includes the 5 scores: Attention, Compliance, Trust, Readability, Brand. Compliance is the hard gate. The others are signal, not gates.

- Compliance < 8 → HOLD + review note. No exceptions.
- Any other score < 7 → returns a "fix before publishing" recommendation, but does not block.

## Working with Creative Studio

Creative Studio embeds Visual Intelligence for any single-image work inside a larger campaign kit. When Creative Studio calls this skill:
- Visual Intelligence produces the 6-part package per format.
- Creative Studio collects the outputs and assembles the full kit.
- The campaign-level boardroom (concept gate) runs in Creative Studio, not here.
- The asset-level boardroom (scores per image) runs here.

## Working with the AI Boardroom

If the user asks for a full strategic critique of the concept (not just the asset), route to `platform/ai-boardroom` with workflow 6 (Landing Page Critique) or 3 (Mortgage Marketing Campaign) depending on scope.

## Source files still required

- Official brand kit (hex, fonts, lockup PNG/SVG, transparent cutouts).
- Approved testimonial bank.
- 10 source social images tagged winners vs retire.
- Canva Pro template names per layout.

Until those land, the skill produces text + prompt packages but cannot complete the round-trip into real Canva files.
