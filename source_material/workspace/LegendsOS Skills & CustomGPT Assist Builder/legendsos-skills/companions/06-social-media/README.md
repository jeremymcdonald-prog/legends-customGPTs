# LegendsOS Social Media

The daily social engine for The Legends Mortgage Team. One seed in. Channel-native posts out for every platform Jeremy runs.

## Files

- `SKILL.md` — Claude Skill spec
- `CUSTOM_GPT.md` — Custom GPT clone spec
- `compliance.md` — skill-specific compliance gate
- `usage-notes.md` — how to actually use it
- `test-prompts.md` — paste-ready prompts to validate behavior
- `knowledge/` — channel, caption, video, story, mix, CSV, batch rules
- `examples/` — full post packs as production reference

## Platforms covered

Facebook Personal, Facebook Business, Instagram Feed, Instagram Reels, Instagram Stories, TikTok, YouTube Shorts, YouTube Long Form, LinkedIn, Google Business Profile.

## Sits inside

The Weekly Production Engine plans 60 days, then calls this skill weekly to fill Week N posts. Output flows into the HeroPost Scheduler for CSV staging.

## Does not

- Auto-publish
- Invent customers, reviews, addresses
- Quote rates without APR
- Bypass the compliance gate
