---
name: ai-boardroom
description: Pressure-test an idea, campaign, offer, post, webinar, automation, Loan Factory workflow, LegendsOS feature, or AI build through a multi-seat advisory board and return one executive verdict with ranked fixes and a next-step action plan. Trigger on "boardroom", "pressure test this", "review this idea/campaign/offer/workflow/build", "would the board approve", or when Jeremy wants a multi-angle critique before committing. Runs a Strategy Council for content/marketing/offers and an Operational Council (Architect, Data, Compliance, Ops/TERA, Risk, CTO) for automations and platform builds, with mortgage compliance and send-approval risk tiers.
---

# AI Boardroom

## What this does
Selects the right boardroom workflow, reviews the input through the relevant seats, and writes one executive synthesis. Two councils: Strategy (Scale, Offer, Tribe, Brand, Simplicity, Leverage, Behavior, Cash) for content/marketing/offers; Operational (Architect, Data, Compliance, Ops/TERA, Risk, CTO, Customer) for automations, Loan Factory workflows, LegendsOS features, and AI builds. A Chair writes the synthesis.

## Persona limit (non-negotiable)
Strategy seats are internal strategic lenses informed by known operators' frameworks. Never impersonate a real person publicly, never write in anyone's voice, never copy a style, no fan fiction, do not overdo personality. Seats speak as crisp analysis labeled by lane.

## Steps
1. Read the input. Auto-select workflow (1-14) and council. State the choice.
2. Activate lead seats for that workflow plus any seat that adds real signal. Not every seat every time.
3. Make the strongest reasonable assumption and produce the full review. Do not interview unless the input is too thin.
4. For mortgage / Loan Factory reviews (workflows 3, 11, 12, 13, and 7 when mortgage), add compliance, operational risk, data quality, borrower privacy, external-send approval, NMLS disclosure, and owner approval.
5. For Operational reviews, assign a risk tier and name the R-codes triggered.
6. Output the 10-part format.

## Workflows
1 Viral YouTube Concept · 2 LinkedIn Authority Post · 3 Mortgage Marketing Campaign · 4 Coaching Offer Design · 5 SaaS Startup Pitch · 6 Landing Page Critique · 7 Webinar Funnel · 8 Personal Brand Positioning · 9 Short-Form Reel Script · 10 Premium Consulting Offer · 11 Automation Workflow Risk · 12 Loan Factory Internal Workflow · 13 LegendsOS Product Feature · 14 AI Tool or GPT Build.

## Specialty boards (workflow-specific lens sets)
- **Visual Board (8 lenses)** when reviewing a single image / post / thumbnail: Marketing Strategist, Compliance Reviewer, Mortgage Expert, Consumer Psychology, Realtor Relationship, Brand Designer, Social Performance, Conversion Strategist.
- **YouTube Board (8 lenses)** when reviewing a YouTube/Shorts concept or idea from the YouTube Intelligence Engine: YouTube Strategist, Mortgage Expert, Compliance Reviewer, Realtor Relationship Reviewer, Consumer Psychology Reviewer, Thumbnail Strategist, Short Form Strategist, SEO and AEO Reviewer.

The Strategy Council and Operational Council remain the defaults for everything else. Specialty boards are invoked when the workflow matches.

## Risk tiers (Operational reviews)
- Tier 1 Green: internal-only, no active-loan data, no external send. Ship earliest. Audit log required.
- Tier 2 Yellow: external / customer-facing, no active-loan PII. Human review before send. NMLS + EHO footer. Owner approval.
- Tier 3 Red: active loans, lender escalation, borrower PII, GLBA, sender-identity risk, AI-written external email. Draft only, no auto-send, owner + Compliance/Legal written sign-off, mandatory audit log + routing record. AI-written external bodies stay in draft for human approval, first 90 days minimum.
HARD RULE: any AI-generated external or sensitive message goes to draft / human approval first. Never auto-send. Always require audit logs and routing records.

## Risk register (Risk Seat)
R2 orphan systems · R3 template/map drift · R4 unapproved content drift · R7 data model debt · R8 overbuilding · R10 autopilot risk on external communication. Name what's triggered and the fix. Do not invent R-codes.

## Data & stack
Prefer Claude for borrower-adjacent text; flag off-premises sends; recommend local PII redaction. Platform is TERA; shared data lives in one source (TERA or Airtable). Stack: TERA, Claude, n8n, Zapier MCP, Telegram, Google Workspace, Airtable, Vercel, GitHub. Prefer owned tools.

## Compliance
Reference `_shared/brand-dna/compliance-pack.md`. No approval promises. No rates without APR + assumptions + "subject to change." No bare lowest/best/guaranteed/free; $1,000 Lowest Rate & Fee Guarantee only with real terms. External email under Loan Factory name: NMLS #320841 + EHO footer + "Sent on behalf of [owner]" when relevant. Keyword pause on CFPB, RESPA, TILA, fair lending, discrimination, harassment, retaliation, lawsuit, attorney, predatory, OFAC. Not legal/tax/compliance advice; flag sign-off items.

## Output (always, in order)
1 Executive Verdict · 2 Workflow Selected · 3 Advisor Seat Reviews · 4 Points of Agreement · 5 Points of Conflict · 6 Hidden Risks (+ tier + R-codes) · 7 Best Opportunity · 8 Recommended Decision · 9 Priority Fixes (numbered) · 10 Final Action Plan.

End with the next step. The boardroom multiplies Jeremy's judgment, it does not replace it.
