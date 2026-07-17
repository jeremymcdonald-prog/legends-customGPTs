# Layer 2 — Engine Prompt Reference

Per-engine direction. Sets emotion, audience, scene, CTA style. Pulled from Creative Studio's 10-engine library and Visual Intelligence's 3-engine system.

## Visual Intelligence — 3 Engines

| Engine | Emotion | Scene direction | Default CTA flavor |
|---|---|---|---|
| **Cinematic Authority** | Confidence, trust | Dark luxury office / command center, subject centered, gold accents, minimal text | Soft brand (Save, Follow) or none |
| **Pattern Interrupt** | Surprise, tension | High contrast, single charged emotion, orange energy, NO competitor names | "Start here" |
| **Educational Minimal** | Clarity, confidence | Dark stage, one color-blocked text zone, subject secondary, mobile-first | Comment keyword (GUIDE, CHECKLIST) |

## Creative Studio — 10 Engines

| Engine | Emotion | Scene | CTA style |
|---|---|---|---|
| Cinematic Authority | Confidence/trust | Dark luxury office/command center, gold accents | Save this / Follow / none |
| Realtor Attraction | Credibility/time-saved | Premium interior, subject working, co-brand space | "Want the Realtor version?" |
| Mortgage Education | Clarity/confidence | Dark stage, one color-blocked text zone | "Comment GUIDE" / "DM NUMBERS" |
| AI Authority | Curiosity/edge | Command center, glowing illustrative dashboards | "Read the comments" |
| Veteran/VA | Pride/respect | Restrained patriotic tone, premium home at dusk | "DM VA" |
| Investor Opportunity | Opportunity/control | Bolder dark luxury, subtle property motif | "DM INVESTOR" |
| Webinar Promotion | Anticipation/value | Dark stage title block, date/time chip | "Register" |
| Market Update | Clarity-in-confusion | Color-blocked panel + subject | "Ask me for today's numbers" |
| Team Momentum | Trust/momentum | Dark office, stats icons | Optional |
| Pattern Interrupt | Surprise/tension | High contrast, charged emotion, NO competitors | "Start here" |

## How a skill assembles a prompt

1. Inject Layer 1 (brand-dna-prompt.md) verbatim.
2. Inject engine line(s) from this file for the chosen engine.
3. Add Layer 3 asset specifics (aspect ratio, subject position, motion).
4. Append Layer 4 (default-negative-prompt.md).
5. Reserve text + compliance zones. Never render words.
