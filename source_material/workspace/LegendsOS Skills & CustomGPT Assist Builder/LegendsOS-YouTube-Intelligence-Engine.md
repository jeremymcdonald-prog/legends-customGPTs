# LegendsOS YouTube Intelligence Engine — System Specification

**Owner:** Jeremy McDonald — The Legends Mortgage Team powered by Loan Factory **NMLS:** \#1195266 (Jeremy) · Loan Factory \#320841 · Equal Housing Lender **Connects to:** Creative Studio, AI Boardroom, Social Studio, Webinar Builder, Email Studio. **Stack:** TERA, Claude, n8n, Supabase, YouTube Data API, Vercel. **Phase:** v1 MVP, internal to Jeremy. No auto-publishing, no auto-emailing. **Status:** Production spec. Paste-ready for LegendsOS source, Custom GPT, and Claude Skill.

---

## How To Use This Document

Blocks marked **PASTE** are final text. This engine turns trusted YouTube channels into a daily stream of content intelligence. It is a research and signal extractor, never a content copier.

**The rule that governs everything:** extract themes, signals, hooks, objections, and opportunities. Never copy scripts, structure, thumbnails, or expression. Convert signals into original Jeremy-style content. Every factual claim is flagged for verification before it touches anything public. n8n drafts only; nothing publishes or emails without human sign-off.

---

# 1\. Executive Summary

The YouTube Intelligence Engine watches a curated set of trusted channels, pulls metadata and transcripts where available and permissible, summarizes each video, and extracts the parts that matter to Jeremy: the main idea, the best hooks, audience pain points, content angles, relevance across mortgage, Realtor, buyer, investor, and AI, and any claims that need verification. It scores each video, groups the day's findings into a single intelligence brief, and recommends original content to create across YouTube, Shorts, social, email, and webinars.

This is leverage on attention. Instead of Jeremy watching twenty videos a day, the engine reads them, strips them to signal, and hands back a brief and a stack of original content ideas already routed to the right studio. It is built on a hard originality firewall and a hard compliance gate, so it sharpens Jeremy's thinking without ever borrowing anyone's words or pushing an unverified claim into the market.

v1 stays small on purpose: daily scan, transcript summary, insight extraction, daily brief, and manual approval to turn ideas into drafts. The advanced version adds trend tracking, clustering, and pattern libraries later.

---

# 2\. Use Case

Daily YouTube monitoring across the topics that feed Jeremy's content and authority: mortgage, real estate, AI tools, sales, marketing and content strategy, economics, housing market, investing, mindset and leadership, and creator strategy. The output is a content intelligence brief every morning plus ready-to-route content ideas, not a feed to repost.

---

# 3\. Channel Categories

Jeremy maintains the curated list. Each channel is tagged to one category and a priority. Starter taxonomy:

| Category | What it feeds |
| :---- | :---- |
| Mortgage industry | Program changes, LO strategy, broker positioning |
| Housing market | Inventory, prices, demand signals (claims need verification) |
| Real estate agents | Agent pain points, co-marketing angles |
| AI tools | New tools, workflows, AI authority content |
| Marketing and content strategy | Hooks, formats, distribution tactics |
| Sales training | Objection handling, scripts to reframe (not copy) |
| Personal brand | Positioning, story, authority building |
| Investor education | DSCR, BRRRR, cash flow angles |
| Veteran and VA content | VA buyer education and respect angles |
| Economic updates | Rates, Fed, bonds (claims need verification) |
| Leadership and mindset | Motivation, team culture, recruiting |

Jeremy populates real channels into `youtube_channels`. The engine does not auto-add channels.

---

# 4\. Daily Automation Design

```
TRIGGER: scheduled daily (e.g., 5:30 AM ET) via n8n cron
CHANNEL LIST SOURCE: Supabase youtube_channels (active = true), org-scoped
NEW VIDEO DETECTION: YouTube Data API, per channel, since last_checked_at
METADATA PULL: title, channel, publish date, URL, duration, description, thumbnail URL
TRANSCRIPT RETRIEVAL: where available and permissible (public captions); store as internal research only
SUMMARY GENERATION: Claude (in-stack) summarizes + extracts insights
TAGGING: category, relevance flags, programs, audience
SCORING: nine scores (Section 10) + composite usefulness
STORAGE: Supabase (videos, transcripts, insights, source_claims)
REVIEW QUEUE: insights and opportunities surface in the daily brief
DRAFT GENERATION: content ideas created as drafts only, routed to studios
HUMAN APPROVAL: Jeremy approves before any idea becomes produced/published content
```

Carryover rules: every run logs request\_id and org\_id. Transcripts are internal research with a retention policy. No auto-publish, no auto-email. The brief is delivered to Jeremy, not to an audience.

---

# 5\. Data Model Recommendations (Future Supabase Tables)

```
youtube_channels        (id, org_id, name, channel_handle, channel_id, category,
                         priority, active, last_checked_at, added_by, created_at)
youtube_videos          (id, org_id, channel_id FK, video_id, title, url,
                         publish_date, duration_sec, description, thumbnail_url,
                         status, fetched_at)
youtube_transcripts     (id, org_id, video_id FK, available bool, source,
                         language, text, retention_until, fetched_at)   -- internal research only
youtube_insights        (id, org_id, video_id FK, summary, main_idea,
                         hooks jsonb, pain_points jsonb, angles jsonb,
                         relevance jsonb, risks, scores jsonb, created_at)
content_opportunities   (id, org_id, insight_id FK, type, idea, routed_to,
                         status, created_by, created_at)
source_claims           (id, org_id, video_id FK, claim_text, claim_type,
                         verification_status, source_url, verified_by, created_at)
daily_intelligence_briefs(id, org_id, brief_date, summary, top_videos jsonb,
                         opportunities jsonb, claims_to_verify jsonb,
                         recommendations jsonb, status, created_at)
```

Notes: org\_id \+ RLS on every table. `relevance` jsonb holds {mortgage, realtor, buyer, investor, ai} flags. `scores` jsonb holds the nine scores. Transcripts carry a `retention_until` so internal research is not kept indefinitely. Claims and briefs are append-only for audit.

---

# 6\. n8n Workflow Concept (Safe)

```
LEGENDSOS YOUTUBE INTELLIGENCE — n8n WORKFLOW
1. Scheduled Trigger (daily cron)
2. Get Channels (Supabase: active channels for org)
3. For each channel: Fetch Uploads (YouTube Data API, since last_checked_at)
4. Fetch Metadata (title, date, URL, duration, description, thumbnail)
5. Fetch Transcript (where available/permissible; else mark available=false)
6. Store Source Record (Supabase: youtube_videos + youtube_transcripts)
7. Summarize + Extract (HTTP -> Claude in-stack: summary, insights, claims, scores)
8. Store Insights (Supabase: youtube_insights + source_claims)
9. Build Daily Brief (aggregate top videos, opportunities, claims, recommendations)
10. Store Brief (Supabase: daily_intelligence_briefs, status = draft)
11. Create Draft Content Ideas (content_opportunities, status = proposed) — DRAFTS ONLY
12. Notify Jeremy (brief ready for review)
-- STOP. No auto-publish. No auto-email to any audience. No content goes out.
ERROR PATH: on failure, log + Slack/email failure notice with request_id; do not partially publish.
```

n8n is execution only. It scans, stores, summarizes, drafts, and notifies. It does not approve, publish, or email content. The AI Boardroom gate and Jeremy's sign-off sit between drafts and anything produced.

---

# 7\. Compliance and Copyright Rules (PASTE)

```
YOUTUBE INTELLIGENCE — ORIGINALITY + COMPLIANCE RULES
ORIGINALITY FIREWALL
- Do not copy scripts, sentences, or phrasing. Extract abstract themes and signals only.
- Do not reproduce a video's structure or sequence as Jeremy's video.
- Do not copy or recreate thumbnails. Generate original thumbnail directions only.
- Do not copy unique named frameworks. If a framework is referenced, attribute it; do not rebrand it as Jeremy's.
- Do not quote long transcript passages. Keep any incidental quote minimal and clearly attributed; default to paraphrase.
- Transcripts are internal research only. Never republish them, in whole or in part.
- Convert signals into original, Jeremy-voice content. The source is inspiration, not material.

CLAIM + COMPLIANCE GATE
- Do not state any rate, housing-market data, legal point, guideline, or economic claim from a video as fact.
- Log every such claim to source_claims with verification_status = unverified.
- A claim cannot enter Jeremy content until verified against a primary source or flagged and removed.
- Any mortgage claim must pass the standard LegendsOS compliance review (no approval promises, no rate without APR, no bare "lowest" claims, NMLS/EHO, "terms and guidelines apply," no government endorsement for VA/FHA/USDA).
- Respect YouTube's Terms of Service for metadata and caption use. Pull only what is available and permissible.
```

---

# 8\. Custom GPT Package — LegendsOS YouTube Intelligence Assistant

**Name (PASTE):**

```
LegendsOS YouTube Intelligence Assistant
```

**Short description (PASTE):**

```
Paste a YouTube video, channel, or transcript and get original, compliant, Jeremy-voice content plans: topics, outlines, Shorts scripts, hooks, titles, thumbnail concepts, and where each idea should go. It extracts signal, never copies, and flags every claim that needs verification.
```

**Custom GPT instructions (PASTE):**

```
ROLE
You are the LegendsOS YouTube Intelligence Assistant for Jeremy McDonald and The Legends Mortgage Team powered by Loan Factory (Jeremy NMLS #1195266; Loan Factory NMLS #320841; Equal Housing Lender).

MISSION
Analyze YouTube videos, channels, transcripts, and trends, then turn the signal into ORIGINAL Jeremy-style content plans. Source material is inspiration, never material to copy.

ORIGINALITY FIREWALL (never break)
Extract themes, hooks, pain points, angles, and trends. Do not copy scripts, phrasing, structure, or thumbnails. Do not rebrand someone's named framework as Jeremy's; attribute it. Do not quote long passages; paraphrase. Never turn a creator's video into Jeremy's video. Output original content in Jeremy's voice.

CLAIM GATE (never break)
Treat every rate, housing-market figure, guideline, legal point, or economic claim from a video as unverified. List it under "Claims needing verification." It cannot enter produced content until verified or it is removed. All mortgage claims pass standard compliance: no approval promises, no rate without APR, no bare "lowest" claims, NMLS/EHO, "terms and guidelines apply," no government endorsement for VA/FHA/USDA.

HOW YOU WORK
- Take a video, channel, transcript, topic, or the daily brief. Produce the requested plan. Make the strong assumption; do not interview.
- Route ideas to the right destination: YouTube, Shorts, Social Studio, Email Studio, Webinar Builder, Creative Studio.

YOU CREATE
video topic ideas, YouTube outlines, Shorts scripts, thumbnail concepts, title options, hook banks, description drafts, chapter outlines, community posts, newsletter ideas, webinar ideas, and AI Boardroom critiques.

OUTPUT
Default to a clean, labeled plan. For a single video: summary (paraphrased), main idea, best hooks to ADAPT (not copy), relevance (mortgage/realtor/buyer/investor/AI), claims needing verification, then the original content ideas with destinations. Include scores when reviewing (Section 10).

VOICE
Jeremy McDonald: plain, confident, broker-first, short lines, no corporate fluff, no em dashes. End with the next step.
```

**Conversation starters (PASTE):**

```
Analyze this YouTube video and give me original content ideas
Turn today's intelligence brief into a content plan
Build a Shorts script from this hook idea (original, in my voice)
Give me title and thumbnail options for a video on this topic
```

---

# 9\. Daily Brief Format (PASTE)

```
LEGENDSOS YOUTUBE INTELLIGENCE — DAILY BRIEF [date]

1. EXECUTIVE SUMMARY — the day in 3-4 lines.
2. TOP 5 VIDEOS WORTH REVIEWING — title, channel, why it matters, usefulness score.
3. BIGGEST CONTENT OPPORTUNITIES — the 2-3 ideas with the most upside.
4. BEST HOOKS TO ADAPT — angles to reframe in Jeremy's voice (not copied lines).
5. MORTGAGE AND REALTOR RELEVANCE — what applies to buyers, refi, and agents.
6. AI AND MARKETING RELEVANCE — tools, formats, distribution signals.
7. CLAIMS NEEDING VERIFICATION — every rate/data/guideline/legal claim, with source to check.
8. RECOMMENDED YOUTUBE VIDEOS TO CREATE — titles + one-line angles.
9. RECOMMENDED SHORTS TO CREATE — hooks + one-line angles.
10. RECOMMENDED SOCIAL POSTS — platform + angle.
11. RECOMMENDED EMAIL TOPICS — subject angle + audience.
12. RECOMMENDED WEBINAR ANGLES — topic + audience.
13. CREATIVE STUDIO ASSET IDEAS — thumbnail/image/B-roll/reel prompts to queue.
14. NEXT ACTIONS — what to approve, verify, or route first.
```

---

# 10\. Scoring System

Each video scored 1-10. Direction noted so the composite is read correctly.

| Score | 1-10 means | Direction |
| :---- | :---- | :---- |
| Relevance | fit to Jeremy's lanes | higher better |
| Originality opportunity | room to make something original | higher better |
| Audience demand | how much the audience wants this | higher better |
| Mortgage usefulness | value to mortgage content | higher better |
| Realtor usefulness | value to Realtor content | higher better |
| YouTube potential | long-form upside | higher better |
| Shorts potential | short-form upside | higher better |
| Risk level | compliance/brand risk | lower better |
| Verification need | how much fact-checking it needs | lower better |

**Composite usefulness** \= the upside scores minus the risk scores, surfaced on the brief so the top 5 sort cleanly.

---

# 11\. AI Boardroom Review Workflow

Each content idea can be run through eight lenses before it is produced. Internal strategic lenses, never impersonations.

| Lens | Checks |
| :---- | :---- |
| YouTube Strategist | Is the topic and packaging strong for the platform? |
| Mortgage Expert | Is the mortgage angle accurate and current? |
| Compliance Reviewer | Does it pass the claim gate and mortgage rules? |
| Realtor Relationship Reviewer | Is it RESPA-safe and partner-friendly? |
| Consumer Psychology Reviewer | Does the hook land for the real viewer? |
| Thumbnail Strategist | Will the thumbnail stop the scroll on brand? |
| Short Form Strategist | Does it cut to a strong Short? |
| SEO and AEO Reviewer | Is it findable and quotable by search and AI engines? |

Output reuses the scored Boardroom format (verdict \+ scores \+ risk notes \+ fixes \+ final approved plan). Compliance under 8 \= hold \+ review note.

---

# 12\. Integration With Creative Studio

For each recommended content idea, the engine queues a Creative Studio brief with:

- **Thumbnail direction** — composition \+ the one big idea, on the dark-luxury DNA.  
- **Image prompt** — cinematic plate, scene/subject/lighting only, default negative prompt, reserved text \+ compliance zones.  
- **B-roll prompt** — scene pack clip for the topic.  
- **Reel cover prompt** — 9:16 hook cover.  
- **Canva template idea** — which layout \+ editable zones.  
- **Higgsfield video prompt idea** — image-to-video hook or motion intro.

All carry the Creative Studio rules: AI builds the plate, Canva adds the words and compliance, nothing approved until the Boardroom gate passes.

---

# 13\. Priority MVP

Ship only this first. Do not overbuild.

```
v1 MVP
- Daily channel scan (curated list)
- Transcript summary (where available)
- Insight extraction (main idea, hooks, pain points, relevance, claims, scores)
- Daily intelligence brief
- Manual approval to turn ideas into drafts
```

Everything else waits.

---

# 14\. Future Advanced Version

```
- Trend tracking across days and channels
- Topic clustering (group related signals)
- Channel comparison (who's covering what)
- Hook performance library (what hooks recur and convert)
- Thumbnail pattern library (original patterns, not copies)
- Competitor intelligence (category-level, never plagiarism)
- Content calendar auto-suggestions (drafts only, human-approved)
- Weekly strategy report (the week's signal + a recommended plan)
```

---

# 15\. Claude Skill Instructions (PASTE as `SKILL.md`)

```
---
name: legendsos-youtube-intelligence
description: Turn YouTube videos, channels, transcripts, and a daily intelligence brief into original, compliant, Jeremy-voice content plans for The Legends Mortgage Team. Trigger on "analyze this video", "youtube intelligence", "turn the brief into a plan", "give me content ideas from this channel", or planning YouTube/Shorts/social/email/webinar content from YouTube research. Extracts themes, hooks, pain points, and angles; never copies scripts, structure, or thumbnails; flags every rate/data/guideline/legal claim for verification; routes ideas to the right studio.
---

# LegendsOS YouTube Intelligence

## Originality firewall (never break)
Extract themes and signals only. No copied scripts, phrasing, structure, or thumbnails. Attribute named frameworks; do not rebrand them. Paraphrase, never long-quote. Transcripts are internal research, never republished. Output original Jeremy-voice content.

## Claim gate (never break)
Every rate, housing figure, guideline, legal point, or economic claim from a video is unverified. List under "Claims needing verification." It cannot enter produced content until verified or removed. Mortgage claims pass standard compliance (no approval promises, no rate without APR, no bare "lowest", NMLS/EHO, "terms and guidelines apply", no government endorsement for VA/FHA/USDA).

## Steps
1. Take a video, channel, transcript, topic, or the daily brief.
2. Produce: summary (paraphrased), main idea, best hooks to adapt, relevance (mortgage/realtor/buyer/investor/AI), claims needing verification, then original content ideas with destinations (YouTube, Shorts, Social, Email, Webinar, Creative Studio).
3. Score 1-10: relevance, originality opportunity, audience demand, mortgage usefulness, realtor usefulness, youtube potential, shorts potential, risk (lower better), verification need (lower better).
4. On request, run the 8-lens Boardroom review and the Creative Studio asset queue.

## You create
video topics, YouTube outlines, Shorts scripts, thumbnail concepts, titles, hook banks, descriptions, chapter outlines, community posts, newsletter ideas, webinar ideas, Boardroom critiques.

End with the next step.
```

---

# 16\. Claude Code Implementation Prompt (PASTE)

```
TASK
Implement the LegendsOS YouTube Intelligence Engine v1 MVP in the LegendsOS repo.

CONTEXT
LegendsOS is Jeremy McDonald's internal AI OS (Legends Mortgage Team powered by Loan Factory). Stack: TERA, Claude, n8n, Supabase, Vercel, GitHub (jeremymac904). This engine monitors curated YouTube channels daily, summarizes videos, extracts insights, flags claims for verification, and produces a daily intelligence brief plus draft content ideas. It is research-only: no copying, no auto-publish, no auto-email.

DELIVERABLES
1. Supabase migrations for: youtube_channels, youtube_videos, youtube_transcripts, youtube_insights, content_opportunities, source_claims, daily_intelligence_briefs. Every table has org_id and RLS. Transcripts include retention_until. source_claims and daily_intelligence_briefs are append-only.
2. A YouTube fetch service (TypeScript): given active channels, pull new uploads since last_checked_at via YouTube Data API; store metadata; pull captions only where available and permissible; mark available=false otherwise. Respect YouTube ToS. No scraping beyond permitted captions.
3. A summarizer service: send transcript/metadata to Claude (in-stack) and return {summary, main_idea, hooks[], pain_points[], angles[], relevance{mortgage,realtor,buyer,investor,ai}, risks, scores{9 scores}, claims[]}. Store insights and source_claims. Prefer Claude for all AI steps; do not send to off-premises models.
4. A daily brief builder that aggregates top videos (by composite usefulness), opportunities, claims to verify, and recommendations, and writes daily_intelligence_briefs (status=draft).
5. A content opportunity generator that writes content_opportunities (status=proposed) routed by type (youtube/short/social/email/webinar/creative). Drafts only.
6. An n8n workflow JSON: scheduled trigger -> get channels -> fetch uploads -> metadata -> transcript -> store -> summarize (Claude) -> store insights -> build brief -> create draft ideas -> notify Jeremy. STOP. No publish, no email-to-audience. Error path logs + Slack/email failure notice with request_id.
7. The YouTube Intelligence Assistant system prompt (Section 8) at /config/assistants/youtube-intelligence.md.

CONSTRAINTS
- TypeScript, strict typing, no secrets in code or prompts; env vars only.
- request_id and org_id on every fetch, summarize, and brief operation; append-only audit on claims and briefs.
- Originality firewall and claim gate enforced in the summarizer prompt: extract signal, never reproduce scripts/structure/thumbnails; flag every factual claim as unverified.
- No auto-publish, no auto-email. Human approval converts proposed opportunities into drafts.
- Tests: new-video detection respects last_checked_at; summarizer output validates against the schema (Zod); claim extraction flags a sample rate claim as unverified; brief excludes any unverified claim from "recommended to create."

OUTPUT
The migrations, the three services, the brief builder, the opportunity generator, the n8n JSON, the assistant config, and a README explaining the daily flow and the approval step.
```

---

# 17\. Testing Checklist (PASTE)

```
YOUTUBE INTELLIGENCE GO-LIVE CHECKLIST
[ ] Daily scan only pulls new uploads since last_checked_at per channel.
[ ] Metadata stored: title, channel, date, URL, duration, description, thumbnail.
[ ] Transcript pulled only where available/permissible; absence handled, not faked.
[ ] Summaries paraphrase; no long quotes, no copied phrasing.
[ ] No thumbnail is copied; only original thumbnail directions are produced.
[ ] Every rate/data/guideline/legal claim is logged to source_claims as unverified.
[ ] Unverified claims are excluded from "recommended to create" until verified.
[ ] Nine scores produced; risk and verification scored as lower-is-better.
[ ] Daily brief renders all 14 parts.
[ ] Content ideas are drafts only; nothing auto-publishes or auto-emails.
[ ] Boardroom review available; compliance under 8 holds the idea.
[ ] Creative Studio queue produces on-brand prompts with reserved text/compliance zones.
[ ] request_id and org_id logged on every step; claims and briefs append-only.
[ ] No GoHighLevel, no MOSO; platform reads as TERA.
[ ] Every output ends with a clear next step.
```

---

# 18\. Example Prompts (PASTE)

```
Analyze this video [URL] and give me 3 original Shorts angles in my voice, plus any claims I need to verify.

Turn today's intelligence brief into a one-week content plan across YouTube, Shorts, and email.

This channel keeps covering "rates are dropping." Give me an original mortgage-education angle that teaches the bond/rate relationship without repeating their claims, and flag what needs verification.

Build 5 title options and 2 thumbnail directions for a video on first-time buyer myths, on the dark-luxury DNA.

From this transcript, extract the audience pain points and turn them into a webinar angle for Realtors. Do not reuse their structure.

Give me a hook bank of 10 original hooks on VA buyer myths, compliant, no government endorsement.
```

---

Let me know what you'd like me to do next.  
