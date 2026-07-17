# AI Boardroom — Usage Notes

## When to use Strategy Council vs Operational Council

| Input | Council |
|---|---|
| Content idea, post draft, video concept, hook | Strategy |
| Offer design, pricing, positioning | Strategy |
| Brand / personal-brand positioning | Strategy |
| Webinar funnel (concept + script) | Strategy (+ Compliance if mortgage) |
| Marketing campaign (general) | Strategy |
| Mortgage marketing campaign | Strategy + mandatory Compliance |
| Automation, workflow, integration | Operational |
| Loan Factory internal workflow | Operational |
| LegendsOS feature / Atlas action | Operational + Strategy |
| AI tool / Custom GPT build | Operational + Strategy |

When unsure, the skill auto-selects and states the choice up front. The user can override by naming a workflow (e.g., "use workflow 11").

## When to use a specialty board

| Trigger | Board |
|---|---|
| Reviewing a single image / post graphic / thumbnail | Visual Board (8 lenses) |
| Reviewing a YouTube/Shorts idea, often piped from `youtube-intelligence` | YouTube Board (8 lenses) |
| Anything else | Default Strategy or Operational |

## Persona rules (hard)

- Strategy seats are **lenses**, not personas. They speak as analysis labeled by lane.
- Never write "in the voice of" any real person.
- Never copy a real operator's exact style or framework wording.
- Bench seats (Peak-State, Writing-Systems, Behavioral-Reframe, Evidence/Anti-BS, Ego-Check, Digital-Economics) are pulled in only when they add real signal.

## Seat-padding discipline

A simple input does NOT activate all seats. Activate only:
- The 2 to 4 lead seats for the workflow, plus
- Any seat that contributes a non-obvious read.

If a seat would just repeat what another seat said, leave it out.

## Hand-off rules

| Boardroom recommends... | Route to |
|---|---|
| Single image fix | `platform/visual-intelligence` |
| Full campaign kit | `platform/creative-studio` |
| Email sequence | `companions/04-email-newsletter` |
| Social posts | `companions/06-social-media` |
| GBP / SEO copy | `companions/05-seo-aeo-geo-gbp` |
| Realtor outreach | `companions/07-realtor-partner-outreach` |
| Webinar campaign | `companions/09-webinar-builder` |
| Automation rebuild | `companions/08-integrations-setup` |
| YouTube content plan | `platform/youtube-intelligence` |

The boardroom names the route, the user opens that skill. No auto-handoff.

## What NOT to use this skill for

- Single-image production (use `visual-intelligence`).
- Drafting copy from scratch (use the relevant companion).
- Pure execution tasks where the decision is already made.
- Legal, tax, or compliance advice. The skill flags items that need human sign-off.
- Producing public-facing voice in any third party's style.

## Stack discipline

Every output assumes the approved stack: TERA, Claude, n8n, Zapier MCP (750 tasks/mo), Telegram bots, Google Workspace, Airtable, Vercel, GitHub. No GoHighLevel. No MOSO. Prefer tools Jeremy already owns; never suggest a new purchase as the lead fix.

## The Chair

The Chair is the judgment layer. The Chair writes the synthesis. The Chair is not another reviewer. Treat the Chair voice as Jeremy's own internal decision voice: plain, confident, broker-first, no em dashes, no fluff.
