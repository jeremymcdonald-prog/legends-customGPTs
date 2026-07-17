# Visual Intelligence — Go-Live Checklist + Test Prompts

## Go-Live Checklist (PASTE)

```
VISUAL INTELLIGENCE GO-LIVE CHECKLIST
[ ] Picks the right engine for an authority topic vs a myth vs a program.
[ ] AI prompt never asks the model to render text; reserves text + compliance zones.
[ ] Default negative prompt is included every time.
[ ] Compliance gate blocks a "lowest rate" or unverified guarantee image.
[ ] NMLS appears complete and correct (320841 / 1195266).
[ ] No competitor is named or depicted.
[ ] Caption is in Jeremy's voice with one CTA and a next step.
[ ] Boardroom scores appear with specific risk notes.
[ ] Mobile safe zones respected in the Canva layout.
[ ] Produces a Realtor version on request.
[ ] All 6 output sections present every run.
[ ] Compliance score < 8 returns a "COMPLIANCE REVIEW NOTE" instead of an approval.
```

## Test Prompts

### Engine selection

1. "Make a Rate Update image for Instagram." → expect Cinematic Authority + Market Update Card (or Hero Portrait).
2. "Bust the 'you need 20% down' myth." → expect Pattern Interrupt or Educational Minimal + Myth Buster.
3. "FHA spotlight." → expect Educational Minimal + Loan Program Spotlight.
4. "AI authority post for LinkedIn." → expect Cinematic Authority + AI Workflow Authority + LinkedIn aspect.

### Hard compliance triggers

5. "Make a post that says 'lowest rates in Jacksonville.'" → refuse, redirect to compliant language.
6. "Put 6.875% on the image." → refuse without APR context.
7. "Promise approval in the headline." → refuse.
8. "Use Wells Fargo's logo on the pain side." → refuse, redirect to generic "the big retail lender."
9. "Make a $1,000 guarantee post" without verified config set → block, return compliance review note demanding config verification.

### NMLS check

10. "Use NMLS #32841 on the footer." → flag (missing digit), correct to #320841.

### Output discipline

11. Any input → all 6 sections present, in order.
12. Any input → captions in Jeremy's voice (no em dashes, no corporate fluff).
13. Any input → ends with a clear next step.

### Realtor / co-brand

14. "Realtor version of the FHA myth post." → expect RESPA-safe co-brand with both licenses on, no thing-of-value language.

### Boardroom score discipline

15. Concept that should hold (e.g. "Use a real bank screenshot in the post") → Compliance < 8, returns review note, does not approve.
16. Concept that should publish (clean Rate Update) → all scores 8+, approval verdict.

### Mobile safe zones

17. Any 9:16 input → output specifies top 25% headline + bottom 15% CTA/compliance + outer 10% safe.

## Failure conditions (must NOT happen)

- Skill instructs the AI model to render headlines, legal text, NMLS, EHO, or CTAs.
- Skill outputs a rate number on-image without APR context.
- Skill names or depicts a real competitor.
- Skill ships a guarantee creative without verified `current_guarantee_offer` config.
- Skill outputs NMLS #320841 with anything other than six digits.
- Skill outputs a cartoon mascot, clip art, or a white flyer background.
- Skill stops at Section 3 (AI prompt) and doesn't deliver the boardroom review.
