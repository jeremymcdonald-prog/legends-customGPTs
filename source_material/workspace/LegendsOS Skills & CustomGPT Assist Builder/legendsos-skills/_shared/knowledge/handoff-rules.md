# Handoff Rules

Every skill has one job. When a request crosses a skill boundary, hand off cleanly. Do not let a skill grow tentacles into someone else's lane.

## Routing map

| If the user asks for... | Route to |
|---|---|
| Pressure test / review / risk audit an idea, campaign, automation, build | `platform/ai-boardroom` |
| Single image, post graphic, thumbnail, Reel cover, story | `platform/visual-intelligence` |
| Full campaign kit (multi-format, multi-asset) | `platform/creative-studio` |
| Daily YouTube research / content ideas from videos | `platform/youtube-intelligence` |
| Live webinar teleprompter overlay | `platform/meet-prompter` |
| HeyGen avatar script | `companions/02-heygen-video` |
| Short-form video plan (Reel / Short / TikTok) | `companions/03-broll-ai-video` |
| Email newsletter or sequence | `companions/04-email-newsletter` |
| GBP post / SEO content / AEO answer / review reply | `companions/05-seo-aeo-geo-gbp` |
| Social media post per platform | `companions/06-social-media` |
| Realtor / partner outreach / co-brand | `companions/07-realtor-partner-outreach` |
| Webinar campaign kit (full 19-part build) | `companions/09-webinar-builder` |
| n8n / Zapier MCP / GHL / webhook setup | `companions/08-integrations-setup` |

## Universal handoffs (the gate)

Every creative skill calls **`ai-boardroom`** before any asset is marked approved.
- Visual Intelligence runs the 8-lens Visual Board.
- Creative Studio runs both the Concept Gate and the Asset Gate.
- YouTube Intelligence runs the 8-lens YouTube Board on each content idea before producing.
- Webinar Builder runs Strategy + Compliance review before sign-off.
- Email Newsletter, Social Media, Realtor Outreach run compliance gate before publish.

## Creative Studio embeds Visual Intelligence

Creative Studio is the campaign-level engine. When it needs a single image inside the kit, it calls Visual Intelligence rather than rebuilding the image logic. Same rule for B-Roll + AI Video and HeyGen Video. Creative Studio is the orchestrator; the companions are the executors.

## YouTube Intelligence feeds the studios

YouTube Intelligence outputs content opportunities tagged with a destination: `youtube`, `short`, `social`, `email`, `webinar`, `creative`. Drafts only. Jeremy approves the route, then the target studio takes the brief from there.

## Meet Prompter syncs to Webinar Builder (v0.2)

In v0.1, Meet Prompter loads scripts from local paste or JSON import. In v0.2, it pulls approved Webinar Builder scripts from Supabase via the LegendsOS API. The JSON schema is locked in `webinar-script-schema.json` so both skills point at the same shape.

## When NOT to hand off

- The skill can fully answer the request in its lane: do not hand off, do the work.
- The user explicitly named a skill: honor it.
- The hand-off would create a loop (avoid: A → B → A).

## Skill etiquette

When a skill identifies an out-of-lane ask, it states the hand-off in one line:

> "This is a Visual Intelligence task. Want me to route it?"

Then proceeds to either route or stop. No silent scope creep.
