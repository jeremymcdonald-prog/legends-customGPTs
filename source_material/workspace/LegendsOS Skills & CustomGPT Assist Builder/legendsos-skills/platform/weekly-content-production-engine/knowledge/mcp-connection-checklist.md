# MCP Connection Checklist (Engine view)

This is the Engine's quick-reference. The full audit lives at `docs/mcp-connector-audit.md`.

## What the Engine needs

| Connector | Engine use | Required for what |
|---|---|---|
| Google Drive (MCP + Zapier) | Read/write storage for assets | Asset hosting, Bulk Create source, media URL routing |
| Google Sheets (Zapier) | Tracker storage | asset_production_tracker, media_url_tracker, performance pulls |
| Canva (MCP available) | Template fills, exports | Reduce operator Bulk Create time |
| HeyGen (Zapier actions available) | Avatar video render | Auto-render scripted videos |
| Higgsfield | Generate cinematic plates | Reduce manual generation |
| Google Business Profile (Zapier) | GBP post create / reply | Drop GBP rows directly |
| Website CMS | Blog and vlog publish | Long form posting |
| HeroPost | Final CSV import | Reduce import friction |
| n8n | Background orchestration | Watch trackers, trigger steps, send notifications |
| GitHub | Skill versioning | Source-of-truth for skill packs |
| Local filesystem | Working files | Drafts, exports staging |
| Browser automation | Fallback for tools without MCP | When connector is missing |

## Engine fallback if connector missing

| Connector missing | Fallback |
|---|---|
| Canva | Operator uses Canva manually |
| HeyGen | Operator renders manually |
| Higgsfield | Operator generates manually (or skips with note) |
| GBP | Operator posts manually |
| HeroPost | Operator imports CSV manually |
| Website CMS | Operator publishes manually |
| n8n | Engine prompts the human at each handoff |

## Checklist before locking Week 1

- [ ] Google Drive access confirmed.
- [ ] Google Sheets access confirmed.
- [ ] Canva account access confirmed (manual or MCP).
- [ ] HeyGen account access confirmed.
- [ ] Higgsfield account access confirmed (or planned manual generation).
- [ ] HeroPost account access confirmed.
- [ ] GBP account access confirmed.
- [ ] Story Bank seeded with at least 5 publish-ready source IDs.
- [ ] Compliance pack reviewed (footer current, guarantee config status known).
