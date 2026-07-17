# Week 1 Higgsfield Execution Packet

**Higgsfield connector status.** Unknown — no MCP or API connector observed in this session.
**Mode.** Manual UI generation.
**Source.** `04_prompt_banks/week_1_higgsfield_batch_prompts.csv` (3 rows).

## Operator steps
1. Open Higgsfield.
2. For each of the 3 prompts below, paste the assembled prompt + negative prompt.
3. Match aspect ratio and style preset exactly.
4. Keep reserved text zones clear (Canva will layer text on top).
5. Generate.
6. Download and rename to the asset_id-based filename.
7. Upload to Drive Week 1 folder.
8. Paste hosted URLs into `media_url_tracker.csv`.

### HF_W1_DAY01_IG_FEED — DAY01
- **Use case.** cinematic_still
- **Aspect.** 1080x1350
- **Style preset.** cinematic_authority_dark_luxury
- **Reserved text zones.** bottom_18pct
- **Concept Gate status.** pending
- **Prompt.** ```Cinematic dark luxury scene for Broker Advantage, charcoal palette, single accent in orange or gold, mobile-first composition, reserved text zone bottom 18 percent, no text rendered in image.```
- **Negative prompt.** ```text, captions, watermark, logo, brand mark, bank name, customer face, real loan document, fake check, cartoon, clip art, rainbow, neon, overlay UI, third type family, deformed hands, extra fingers```

### HF_W1_DAY03_IG_FEED — DAY03
- **Use case.** cinematic_still
- **Aspect.** 1080x1350
- **Style preset.** cinematic_authority_dark_luxury
- **Reserved text zones.** bottom_18pct
- **Concept Gate status.** pending
- **Prompt.** ```Cinematic dark luxury scene for Mortgage Story, charcoal palette, single accent in orange or gold, mobile-first composition, reserved text zone bottom 18 percent, no text rendered in image.```
- **Negative prompt.** ```text, captions, watermark, logo, brand mark, bank name, customer face, real loan document, fake check, cartoon, clip art, rainbow, neon, overlay UI, third type family, deformed hands, extra fingers```

### HF_W1_DAY05_IG_FEED — DAY05
- **Use case.** cinematic_still
- **Aspect.** 1080x1350
- **Style preset.** premium_handoff_closing
- **Reserved text zones.** bottom_18pct
- **Concept Gate status.** pending
- **Prompt.** ```Cinematic dark luxury scene for Closing Day, charcoal palette, single accent in orange or gold, mobile-first composition, reserved text zone bottom 18 percent, no text rendered in image.```
- **Negative prompt.** ```text, captions, watermark, logo, brand mark, bank name, customer face, real loan document, fake check, cartoon, clip art, rainbow, neon, overlay UI, third type family, deformed hands, extra fingers```

## Hard rules
- No text rendered inside the image (Canva owns text layers).
- No guarantee dollar amount in any plate.
- No depictions of real people other than Jeremy without authorization.
- All assets land in staging as drafts; Asset Gate runs before approval.