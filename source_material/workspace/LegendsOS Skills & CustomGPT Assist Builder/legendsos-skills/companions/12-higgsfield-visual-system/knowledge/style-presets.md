# Style Presets

The canonical preset library. Each preset is a packaged style layer the skill can drop into the four-layer prompt.

## cinematic_authority_dark_luxury

Use: closing day stills, broker authority, signature campaign moments.
Look: charcoal + black base, gold or orange accent, subtle film grain, soft bokeh, controlled directional light, hero-positioned subject.
Avoid: bright daylight, stock-photo feel, busy backgrounds.

## pattern_interrupt_high_contrast

Use: short-form hooks, scroll-stopping Reels, story plates with emotional charge.
Look: high contrast charcoal vs accent, dramatic light, single charged emotion (no faces of strangers), orange energy.
Avoid: cluttered composition, cartoon, stock people, anything that names a competitor.

## educational_minimal

Use: text-heavy education plates where the image is a frame around the message.
Look: simple background, one accent texture, clear text-safe zone, mobile-first.
Avoid: detailed subjects that fight the text.

## florida_lifestyle_warm

Use: Northeast Florida coastal, suburb, downtown lifestyle. Personal brand. Local authority.
Look: warm light, golden hour, controlled saturation, natural texture.
Avoid: tourism brochure feel, oversaturated, fake palm-tree clichés.

## premium_handoff_closing

Use: closing day handoff stills, key shots, document close-ups (no real docs), table edge moments.
Look: warm interior, edge bokeh, orange accent on a single object, hero crop on hands or objects (no faces unless authorized).
Avoid: showing real loan documents, real signatures, named cards.

## market_metaphor_abstract

Use: rate / bond / market commentary backgrounds.
Look: abstract dark backdrop with one accent motion line or curve, premium financial editorial feel.
Avoid: chart styling that looks like real data, ticker overlays.

## leadership_lectern

Use: LinkedIn long form imagery, CTO positioning content.
Look: subject in command position, dark backdrop, premium light, single accent.
Avoid: corporate stock executive feel.

## gym_dawn_discipline

Use: personal brand fitness and discipline content.
Look: low light, hard light from one side, charcoal palette with warm accent, real grit.
Avoid: shiny gym brochure feel.

## How the skill picks a preset

1. Read the asset layer's subject.
2. Map subject to the right preset using the table below.
3. Combine with the engine layer.

| Subject | Preset |
|---|---|
| Closing day handoff | premium_handoff_closing |
| Broker authority moment | cinematic_authority_dark_luxury |
| Florida coastal lifestyle | florida_lifestyle_warm |
| Education plate | educational_minimal |
| Reel hook | pattern_interrupt_high_contrast |
| Market / rate commentary | market_metaphor_abstract |
| LinkedIn / CTO leadership | leadership_lectern |
| Gym / discipline | gym_dawn_discipline |
