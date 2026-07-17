# LegendsOS Creative Studio — System Specification

**Owner:** Jeremy McDonald — The Legends Mortgage Team powered by Loan Factory **NMLS:** \#1195266 (Jeremy) · Loan Factory \#320841 · Equal Housing Lender **Phase:** v1, internal to Jeremy. LO self-serve is a future phase, not optimized for yet. **Builds on:** LegendsOS Visual Intelligence System (image doctrine) \+ LegendsOS AI Boardroom (review gate). **Status:** Production spec. Paste-ready for LegendsOS source, Custom GPT, and Claude Skill.

---

## How To Use This Document

Blocks marked **PASTE** are final text. Creative Studio is the campaign-level engine. The Visual Intelligence Assistant lives inside it and handles single images; Creative Studio handles whole campaigns, video, B-roll, and the orchestration, permission, and audit layer around all of it.

**The one rule that runs through everything:** Higgsfield, Canva, and every MCP tool are creative subsystems that produce drafts. Nothing is approved until it clears the AI Boardroom gate and is logged in Supabase. n8n only distributes already-approved exports. No tool bypasses LegendsOS approval or audit logging. Nothing publishes externally without human sign-off.

---

# 1\. Executive Summary

LegendsOS Creative Studio is the internal cinematic content engine for Jeremy McDonald and The Legends Mortgage Team. It is not a generic image generator. It is a branded mortgage media operating system that turns Jeremy's high-level campaign concepts into complete, on-brand, compliance-safe campaign kits: hero images, reel covers, YouTube thumbnails, B-roll, animated hooks, Canva templates, webinar promo kits, email graphics, and storyboards.

The model is leverage, not labor. Instead of every loan officer learning to prompt, Jeremy creates master campaigns and approved template systems once. The system generates the assets. Later phases let LOs customize safely inside locked branding and compliance zones. In v1, this is Jeremy's tool, tuned for quality, brand consistency, repeatability, and authority positioning.

Architecturally, LegendsOS stays the brain: the UI, orchestration, permission, audit, source of truth, and workflow manager. Supabase is memory, permissions, usage logs, asset tracking, automation records, and template metadata. n8n is execution only. Higgsfield is a creative subsystem for cinematic stills, image-to-video, B-roll, and motion. Canva is the editable template and export layer. The AI Boardroom is the gate every concept and asset passes through before it is called approved.

---

# 2\. System Architecture

**Layered model (current state):**

```
LegendsOS (brain)
  - UI, orchestration, permissions, audit, source of truth, workflow manager
  - Owns approval rules. Nothing is "approved" outside LegendsOS.

Claude / Claude Code (intelligence)
  - Writes campaign briefs, master prompts, layout specs, storyboards, captions
  - Runs the AI Boardroom review

AI Boardroom (gate)
  - Scores every concept and asset; blocks publish below threshold

Higgsfield MCP (creative subsystem)
  - Cinematic stills, image-to-video, B-roll, motion sequences
  - Produces drafts only; outputs flow back through LegendsOS

Canva (template + export layer)
  - Approved editable templates, locked zones, platform exports

Supabase (memory + governance store)
  - campaigns, templates, assets, approvals, generations, brand_dna, automation_jobs, tags

n8n (execution only)
  - Scheduled generation triggers and distribution of APPROVED exports only
  - Never an approver. Never publishes external without human sign-off.
```

**Request flow (the spine):**

```
Concept (Jeremy) -> LegendsOS logs request (request_id, org_id)
  -> Claude writes campaign brief + master prompt
  -> AI Boardroom reviews concept (scores, verdict)
  -> if pass: Higgsfield generates cinematic assets (drafts)
  -> Canva receives approved layout, builds editable template
  -> AI Boardroom reviews finished asset (compliance gate)
  -> Supabase stores asset + metadata + append-only approval record
  -> n8n distributes only approved, signed-off exports
```

**Target module map (future state, see Section 17 \+ future module):** Creative Studio contains Image Studio, Social Studio, Webinar Studio, Video Studio, Campaign Library, Template Vault, Brand DNA, and Creative AI Workflows. v1 ships Image Studio \+ Campaign Library \+ Brand DNA first.

**Hard architecture rules:**

- Higgsfield is a subsystem, not the OS. It cannot mark anything approved or write final state outside LegendsOS.  
- Every MCP call is permissioned and logged in Supabase (generations table) with request\_id and org\_id.  
- n8n runs jobs and moves approved files. It does not decide approval and does not auto-publish external.  
- The AI Boardroom gate is mandatory before "approved" status is set.

---

# 3\. Higgsfield MCP Integration Strategy

Higgsfield is the cinematic generation muscle: high-quality stills with real camera feel, image-to-video animated hooks, B-roll clips, and motion intros. It is wired as a governed subsystem.

**Integration principles:**

- All Higgsfield calls route through LegendsOS, which attaches request\_id, org\_id, campaign\_id, and the approved prompt before invoking the MCP tool.  
- LegendsOS records every call in Supabase `generations` (tool, prompt, params, cost, latency, status).  
- Higgsfield returns drafts to a staging bucket. Draft status only. It cannot set "approved."  
- The AI Boardroom reviews Higgsfield output before it advances to Canva or storage as approved.  
- Prompts sent to Higgsfield are scene/subject/lighting/motion only. No headlines, no legal text rendered by AI (carryover from the Visual Intelligence core rule).

**What Higgsfield generates here:**

- Cinematic hero stills (the plate that goes into Canva)  
- Image-to-video animated hooks (subject turn, push-in, parallax) for Reels/Shorts  
- B-roll scene packs (office, neighborhood at dusk, command center, keys/closing motifs)  
- Motion intro sequences (logo reveal, dashboard glow, title cards as motion plates, text added in Canva/edit)

**Operational workflow (PASTE):**

```
HIGGSFIELD WORKFLOW
1. Claude generates the campaign brief and the scene/motion prompt.
2. AI Boardroom reviews the concept. Pass required to proceed.
3. LegendsOS calls Higgsfield MCP with the approved prompt + request_id + org_id.
4. Higgsfield returns drafts to staging (status: draft).
5. AI Boardroom reviews the asset (compliance gate). Below threshold = hold + review note.
6. Canva receives the approved plate/clip for templating.
7. LegendsOS stores the final asset + metadata + append-only approval record in Supabase.
8. n8n distributes only approved, signed-off exports.
```

Note: bind to the exact Higgsfield MCP tool names and parameters per its published schema at integration time. Do not hardcode endpoints into prompts; LegendsOS owns the call.

---

# 4\. Canva Template Strategy

Canva is where the cinematic plate becomes a finished, editable, brand-locked asset and where every platform export is produced.

**Template anatomy (every Creative Studio template has these zones):**

- **Locked branding zone:** Legends \+ Powered by Loan Factory lockup. Not editable.  
- **Compliance footer zone:** NMLS, EHO, disclaimers. Not editable. Pulled from Brand DNA config.  
- **Headline zone:** editable text, constrained to the approved type styles.  
- **Support line zone:** editable, one line.  
- **CTA zone:** editable from the approved CTA list only.  
- **Transparent cutout upload zone:** where Jeremy or an LO drops a transparent PNG of themselves.  
- **Safe text zones:** marked guides so text never collides with the face or the compliance strip.  
- **Platform export presets:** 1:1, 4:5, 9:16, 16:9, banner, sized per Section B.

**Rules:**

- Locked zones cannot be moved, recolored, or deleted by an LO (future phase enforced via Canva Brand Kit \+ locked layers).  
- Editable zones are constrained to approved fonts, colors, and the CTA list.  
- Every template carries its compliance footer by default; removing it is not an option.  
- Each template maps to a Supabase `templates` row with locked\_zones, editable\_zones, compliance\_zone, and version.

**Why Canva for text:** image and video models garble headlines and legal text. Canva renders type and compliance cleanly and exports per platform. The cinematic plate is AI; the words are Canva. Always.

---

# 5\. LegendsOS Integration Strategy

LegendsOS is the operating system. Creative Studio is a module inside it.

- **UI:** Jeremy initiates a campaign from a concept, picks an engine, and watches it move through brief, review, generation, template, and approval.  
- **Orchestration:** LegendsOS sequences Claude, the Boardroom, Higgsfield, and Canva. It owns the flow.  
- **Permissions:** LegendsOS decides who can generate, who can customize, and what zones are editable. v1 \= Jeremy full access.  
- **Audit:** every step writes to Supabase with request\_id and org\_id. Approvals are append-only.  
- **Source of truth:** the Campaign Library, Template Vault, and Brand DNA live in LegendsOS/Supabase, not scattered across tools.  
- **Workflow manager:** recurring campaigns (Section 19\) are defined in LegendsOS and executed by n8n.

Integration contract: any tool (Higgsfield, Canva, Claude Code) is a worker. LegendsOS assigns work, receives drafts, runs the gate, sets status, and logs everything. Workers never set final state.

---

# 6\. AI Boardroom Review Workflow

Reuses the LegendsOS Visual Boardroom (eight lenses) and gates both the concept and the finished asset.

**Eight lenses:** Marketing Strategist, Compliance Reviewer, Mortgage Expert, Consumer Psychology, Realtor Relationship, Brand Designer, Social Performance, Conversion Strategist.

**Two gates:**

- **Concept gate (before generation):** is the idea worth producing, on-brand, and compliant in principle?  
- **Asset gate (before approval):** does the finished image/video pass every compliance rule and brand standard?

**Scored output (PASTE):**

```
1. EXECUTIVE VERDICT — produce / fix-then-produce / hold (concept) | publish / fix / hold (asset)
2. ATTENTION SCORE (1-10)
3. COMPLIANCE SCORE (1-10) — under 8 blocks advancement
4. TRUST SCORE (1-10)
5. READABILITY SCORE (1-10)
6. BRAND SCORE (1-10)
7. RISK NOTES — specific compliance/claim flags
8. FIXES BEFORE PROCEEDING — numbered
9. FINAL APPROVED BRIEF/PROMPT — corrected, ready
```

Compliance under 8 \= hold \+ compliance review note, written to Supabase `approvals`. No exceptions, no auto-override by n8n or any MCP tool.

---

# 7\. Prompt Orchestration System

Claude orchestrates a layered prompt stack so every asset is consistent.

**Layer 1 — Brand DNA prompt (constant, injected every time):**

```
LegendsOS dark-luxury cinematic style: charcoal and black base, burnt gold / Loan Factory orange energy accent, champagne gold luxury accent, white and silver typography, glass UI panels, cinematic realism, clean directional lighting, film grain, mobile-first composition, one big idea, strong face presence. Leave clean zones for Canva text and a bottom compliance strip. Do not render any text.
```

**Layer 2 — Engine prompt (per campaign engine, Section 17):** sets emotion, audience, scene direction, CTA style.

**Layer 3 — Asset prompt (per format):** aspect ratio, subject position, motion (if video), platform.

**Layer 4 — Negative prompt (constant):**

```
garbled text, fake text, misspelled words, gibberish signage, watermark, real bank or competitor logos, trademarked logos, fake legal text, real loan documents, extra fingers, deformed hands, plastic skin, oversaturated, cartoon mascot, clip art, busy footer, white flyer background, low resolution, blurry face.
```

**Master campaign brief template (PASTE):**

```
CAMPAIGN: [name]
ENGINE: [one of the 10]
AUDIENCE: [who]
EMOTION: [one trigger]
BIG IDEA: [one sentence]
SCENE: [cinematic setting]
SUBJECT POSITION: [frame placement + pose]
FORMATS: [list from Section B]
MOTION (if video): [camera move / animated hook]
TEXT PLAN (Canva): headline / support / CTA
COMPLIANCE: [program lines + footer]
PLATFORMS: [where it runs]
OUTPUT: [campaign kit contents]
```

LegendsOS assembles Layers 1-4 \+ the brief into the final call. Jeremy edits the brief, never the raw stack.

---

# 8\. Brand Consistency System \+ Visual DNA

Consistency is enforced by config, not memory. Colors, fonts, lockups, and compliance text live in Supabase `brand_dna` and are injected into every prompt and template. Change once, propagate everywhere. Versioned.

### LegendsOS Visual DNA

- **Burnt gold / Loan Factory orange** — energy accent, the single key word, CTAs  
- **Champagne gold** — luxury accent, premium moments, script  
- **Black / charcoal** — the cinematic stage  
- **White / silver typography** — headlines and support  
- **Glass UI** — frosted panels, subtle reflections, command-center surfaces  
- **Cinematic realism** — real light, real depth, film grain, never cartoon  
- **Luxury mortgage command center** — the signature environment  
- **Clean emotional composition** — one feeling, one idea, room to breathe  
- **High contrast readability** — reads at thumbnail size  
- **Mobile-first layout** — center 80 percent safe, bottom 12 percent reserved for compliance

Hex anchors: Charcoal `#1A1A1A`, Black `#0A0A0A`, Loan Factory Orange `#F26A21`, Champagne Gold `#C9A24B`, White `#FFFFFF`, Silver `#C7C7C7`.

### Do Not Create

```
- generic Canva flyers
- cluttered mortgage ads
- tiny unreadable compliance text
- fake rates
- fake approvals
- fake testimonials
- cheap stock broker imagery
- overly AI-looking faces
- cartoon mortgage graphics
- flat white background templates
- random typography systems
- generic corporate banking style
```

---

# 9\. Compliance Overlay System

Compliance is a layer, not an afterthought. It is applied at three points.

1. **Concept gate:** the Boardroom checks the idea against the rules before generation.  
2. **Template layer:** every Canva template ships with a locked compliance footer pulled from Brand DNA. It cannot be removed.  
3. **Asset gate:** the Boardroom verifies the finished asset and assigns a Compliance Score; under 8 blocks approval.

**Overlay content (pulled from config, PASTE):**

```
- Legends Mortgage Team powered by Loan Factory
- Equal Housing Lender
- NMLS #1195266 (when Jeremy/LO is promoted) · Loan Factory NMLS #320841 (verify complete, six digits)
- Guarantee creatives: current confirmed amount only, eligible states, "All states except Washington," T&C URL, "This is not a commitment to lend. All loans subject to credit approval. Rates, terms, and fees subject to change without notice."
- Programs: "Terms, eligibility, and program guidelines apply." No government endorsement for VA/FHA/USDA.
- No approval promises. No rate without APR. No bare "lowest rate/fees" without approved sourcing.
- Real testimonials only, "Individual results vary." No loan documents, no borrower PII.
- No named or depicted competitors.
- Illustrative dashboards/numbers must read as illustrative, never as performance claims.
```

The guarantee dollar amount is never hardcoded. It reads from `brand_dna.current_guarantee_offer` with eligible\_states and tc\_url. If unset, the gate blocks guarantee creatives.

---

# 10\. Cinematic Content Framework

Every Creative Studio piece is built like a shot, not a flyer.

- **One subject, one idea, one emotion.** If two ideas compete, split into two assets.  
- **Depth and light:** background bokeh, directional key light, rim light on the subject, controlled orange flare.  
- **Stage before subject:** establish the charcoal cinematic environment, then place the subject in the strong third.  
- **Negative space is a feature:** the dark zone is where Canva text lives. Design it in.  
- **Motion where it earns it:** stills for authority and education, motion hooks for Reels/Shorts where a 1-2 second move stops the scroll.  
- **Grain and grade:** subtle film grain and a warm-cool grade unify the whole library.

---

# 11\. Mortgage Media Framework

Mortgage content leads with emotion, teaches one thing, and stays compliant.

- **Topics:** rates, credit, FHA/VA/USDA, DPA, refinance, DSCR, bank statement, investor, reverse, buyer readiness.  
- **Pattern:** hook (emotion) \-\> one insight (education) \-\> CTA (action). Emotion first, education second.  
- **Claims discipline:** no rate without APR, no guaranteed savings, no "lowest" without sourcing, programs carry "terms and guidelines apply."  
- **Engines used:** Mortgage Education, Market Update, Pattern Interrupt, Veteran/VA, Investor.  
- **Formats:** square post, story, reel cover, program spotlight, myth buster.

---

# 12\. Realtor Media Framework

Realtor content makes agents look smart and builds the referral relationship, RESPA-safe.

- **Angles:** time-saving AI tips, listing/marketing help, market clarity for their clients, co-branded education and open houses.  
- **RESPA discipline:** never offer or imply anything of value in exchange for referrals. Co-branded pieces show both licenses.  
- **Engines used:** Realtor Attraction, AI Authority, Webinar Promotion.  
- **Formats:** Realtor partner education card, co-branded open house, carousel cover, LinkedIn authority graphic.  
- **CTA style:** "Want the Realtor version?", "Let's make your buyers look smart," "Book a strategy call."

---

# 13\. Webinar Media Framework

Webinar assets are a kit, not a single image.

- **Kit contents:** promo hero, reel/short teaser (motion), registration graphic, email header, slide title plates, recap graphic.  
- **Pattern:** topic title \+ 3 "you'll learn" \+ date/time chip \+ register CTA.  
- **Engines used:** Webinar Promotion (lead), plus the topic's engine (e.g., Veteran/VA for a VA webinar).  
- **Compliance:** "Educational. Terms, eligibility, and program guidelines apply." No approval or rate promises in promo.  
- **Formats:** 16:9 promo, 9:16 teaser, email header, 1:1 social.

---

# 14\. YouTube and Shorts Framework

- **Thumbnails (16:9, 1280x720):** subject on one side with a strong face and emotion, clean dark zone for a 3-5 word headline, one orange accent, reads at small size.  
- **Shorts/Reels covers (9:16):** single dominant subject \+ emotion, clean band for a 3-4 word hook, center composition that survives 1:1 cropping.  
- **Animated hooks:** Higgsfield image-to-video, 1-2 second push-in or subject turn, text added in edit/Canva.  
- **Consistency:** same dark-luxury grade so the channel reads as one brand.  
- **Engines used:** AI Authority, Pattern Interrupt, Mortgage Education, Market Update.

---

# 15\. B-Roll Generation Framework

B-roll is a reusable scene library, generated once and tagged for reuse.

**Scene packs (generate per pack, store and tag):**

- Command center: desk, glowing dashboards (illustrative), city night skyline  
- Premium office: dark interior, Legends wall, marble desk, coffee \+ notebook  
- Neighborhood at dusk: warm-lit homes, moody streets  
- Closing/keys: keys, sold motif, doorway light  
- Lifestyle authority: subject walking, working, on the phone, confident

**Rules:** no real client homes or data, no real documents, illustrative dashboards only. Each clip tagged by scene, mood, length, and engine for fast reuse across campaigns.

**Use:** intro/outro b-roll for Reels and Shorts, background motion behind title plates, transitions, ambient authority cutaways.

---

# 16\. Video Storyboard Framework

Claude writes the storyboard; Higgsfield generates the shots; the edit assembles them.

**Storyboard template (PASTE):**

```
TITLE: [hook]
LENGTH: [15s / 30s / 60s]
ENGINE: [one of 10]
HOOK (0-3s): [shot + on-screen text plan + B-roll]
BEAT 1: [shot + point]
BEAT 2: [shot + point]
BEAT 3: [shot + point]
CTA (last 3s): [shot + CTA]
MOTION NOTES: [camera moves, pacing, music feel]
TEXT PLAN: [overlays, added in edit/Canva, not by AI]
COMPLIANCE: [footer + any program lines]
```

Used for HeyGen avatar scripts, talking-head shorts, and B-roll-driven hooks. Pairs with the HeyGen and B-Roll companion assistants.

---

# 17\. Reusable Campaign Engine \+ Engine Library

A campaign engine is a reusable recipe: emotion \+ audience \+ scene \+ CTA \+ compliance, applied to a topic and exploded into a full kit. Jeremy picks an engine and a topic; the system produces the kit.

## Campaign Engine Library (10)

**1\. Cinematic Authority Engine** Purpose: build trust, leadership, premium recognition. Audience: all, brand-level. Emotion: confidence/trust. Visual: dark luxury office/command center, subject centered, gold accents. Prompt direction: premium environment, strong face, minimal text zone. CTA: soft or none ("Save this," "Follow"). Platforms: IG, FB, LinkedIn. Compliance: standard strip. Formats: 1:1, 4:5, LinkedIn graphic, B-roll.

**2\. Realtor Attraction Engine** Purpose: win and keep agent partners. Audience: Realtors. Emotion: credibility/time-saved. Visual: premium interior, subject working, co-brand space. Prompt direction: approachable authority, lighter premium allowed. CTA: "Want the Realtor version?", "Book a strategy call." Platforms: IG, LinkedIn, FB. Compliance: RESPA-safe, dual licenses on co-brand. Formats: partner education card, carousel, co-branded open house.

**3\. Mortgage Education Engine** Purpose: teach one mortgage idea. Audience: buyers/refi. Emotion: clarity/confidence. Visual: dark stage, one color-blocked text zone, subject secondary. Prompt direction: clean minimal, one big idea. CTA: "Comment GUIDE," "DM NUMBERS." Platforms: IG, FB, GBP. Compliance: no rate without APR, "terms and guidelines apply." Formats: square, story, program spotlight, myth buster.

**4\. AI Authority Engine** Purpose: position Jeremy as the AI-leveraged operator. Audience: agents, peers, recruits, buyers. Emotion: curiosity/edge. Visual: command center, glowing dashboards (illustrative), tool panels. Prompt direction: cinematic tech authority. CTA: "Read the comments." Platforms: IG, LinkedIn, YouTube. Compliance: numbers illustrative, not performance claims. Formats: 1:1, thumbnail, motion hook, B-roll.

**5\. Veteran and VA Engine** Purpose: serve and honor veteran buyers. Audience: veterans/active. Emotion: pride/respect. Visual: restrained patriotic tone, premium home at dusk, dignified. Prompt direction: respectful, no flags-as-logos. CTA: "DM VA." Platforms: FB, IG. Compliance: no government endorsement, "eligibility and program guidelines apply." Formats: closing celebration, program spotlight, myth buster.

**6\. Investor Opportunity Engine** Purpose: attract investor borrowers. Audience: investors. Emotion: opportunity/control. Visual: bolder dark luxury, subtle property motif. Prompt direction: confident, data-aware but illustrative. CTA: "DM INVESTOR." Platforms: IG, LinkedIn. Compliance: business-purpose lending, terms differ from consumer loans. Formats: program spotlight (DSCR, bank statement), carousel.

**7\. Webinar Promotion Engine** Purpose: fill webinars. Audience: per topic. Emotion: anticipation/value. Visual: dark stage title block, date/time chip. Prompt direction: premium educational. CTA: "Register." Platforms: FB, IG, LinkedIn, email. Compliance: "Educational. Terms and guidelines apply." Formats: 16:9 promo, 9:16 teaser, email header, 1:1.

**8\. Market Update Engine** Purpose: weekly market authority. Audience: buyers/refi/agents. Emotion: clarity in confusion. Visual: color-blocked panel \+ subject. Prompt direction: clean, one insight. CTA: "Ask me for today's numbers." Platforms: IG, FB, GBP. Compliance: no rate without APR context. Formats: market update card, story.

**9\. Team Momentum Engine** Purpose: show traction and culture. Audience: buyers, recruits, partners. Emotion: trust/momentum. Visual: dark office, stats icons, "One Team. Real Results." Prompt direction: confident, premium. CTA: optional. Platforms: IG, FB, LinkedIn. Compliance: standard strip; stats truthful or illustrative-labeled. Formats: 1:1, story.

**10\. Pattern Interrupt Engine** Purpose: stop the scroll. Audience: all. Emotion: surprise/tension. Visual: high contrast, single charged emotion, orange energy. Prompt direction: bold, professional, never name/depict a competitor. CTA: "Start here." Platforms: IG, FB, Shorts. Compliance: no disparagement, no competitor logos, standard strip. Use sparingly. Formats: 1:1, 9:16 hook.

---

# 18\. Asset Approval Workflow

```
ASSET APPROVAL
1. Concept created (Jeremy) -> logged (request_id, org_id, campaign_id).
2. Concept gate (Boardroom). Pass to proceed.
3. Generation (Higgsfield/Canva) -> draft status only.
4. Asset gate (Boardroom). Compliance < 8 = hold + review note.
5. Human sign-off (Jeremy in v1) -> status: approved.
6. Supabase writes append-only approval record (scores, verdict, signer, timestamp).
7. Only approved + signed assets are eligible for n8n distribution.
8. External publish requires explicit human sign-off, never auto.
```

Status values: `draft -> in_review -> approved -> published` (or `hold`). Only LegendsOS sets status. No MCP tool or n8n job can jump an asset to approved or published.

---

# 19\. Future Automation Workflows

Recurring campaigns are defined in LegendsOS, generated through the gate, and distributed by n8n as drafts for sign-off. n8n never publishes external without approval.

### Recurring Automation Calendar

| Slot | Engine | Format default |
| :---- | :---- | :---- |
| Monday — Money Moves Monday | Mortgage Education | 1:1 \+ story |
| Tuesday — Realtor Tip | Realtor Attraction | 4:5 \+ carousel |
| Wednesday — AI Workflow | AI Authority | 1:1 \+ thumbnail |
| Thursday — Testimonials | Cinematic Authority (proof card) | 1:1 |
| Friday — Friday Momentum | Team Momentum | 1:1 |
| Weekend — Open House | Realtor Attraction (co-brand) | 1:1 |
| Veteran Spotlight (as scheduled) | Veteran and VA | 1:1 |
| Rate Update (weekly) | Market Update | 1:1 \+ story |
| Market Myth (weekly) | Pattern Interrupt | 1:1 |
| Investor Opportunity (biweekly) | Investor Opportunity | 1:1 \+ carousel |

### Automation Job Structure (PASTE)

```
job: {
  id, org_id, cadence_slot, schedule (cron),
  engine, template_id, topic_source,        // topic from a backlog or manual
  steps: [
    generate (higgsfield|canva),
    concept_gate (boardroom),
    asset_gate (boardroom),
    store (supabase),
    notify (jeremy for sign-off)
  ],
  distribution: { mode: "draft_only", publish: "requires_human_signoff" },
  audit: { request_id, last_run, next_run, last_result },
  status: enabled | paused
}
```

n8n executes the schedule and the move-file steps. The gates and sign-off are owned by LegendsOS/Boardroom. Carryover rule from the automation boardroom review: no auto-publish of external content, audit log and routing record required on every run.

---

# 20\. Internal vs Public Generation Permissions

**Phase 1 (now) — Jeremy internal:**

- Jeremy: full generation, full engine access, approval authority, sign-off.  
- LOs: no direct generation. They consume Jeremy's approved, finished assets.  
- All generation logged; all approvals append-only.

**Phase 2 (future) — LO safe customization:**

- LOs: customize approved templates only. Upload a transparent cutout, edit the headline within approved styles, pick a CTA from the approved list.  
- LOs cannot: access raw prompts, generate net-new cinematic assets, edit locked branding or compliance zones, publish without the compliance gate.  
- Every LO export is compliance-gated and logged with the LO's identity and NMLS.  
- Org-scoped via Supabase RLS so an LO only sees their own and shared-approved assets.

**Permission matrix:** | Capability | Jeremy (v1) | LO (future) | |---|---|---| | Generate cinematic assets | Yes | No | | Access raw prompts | Yes | No | | Edit locked/compliance zones | No (locked for all) | No | | Customize approved templates | Yes | Yes (constrained) | | Approve / sign-off | Yes | No | | Publish external | Yes (with sign-off) | No (request only) |

---

# 21\. Assistant Package — LegendsOS Creative Studio Assistant

The campaign-level orchestrator. It plans campaigns and kits; the Visual Intelligence Assistant executes single images inside it.

**Name (PASTE):**

```
LegendsOS Creative Studio Assistant
```

**Short description (PASTE):**

```
Turn a concept into a complete, on-brand, compliance-safe campaign kit: it picks the engine, writes the brief and master prompt, specs the Higgsfield generation and Canva template, plans every format, runs the boardroom gate, and defines what gets stored and logged.
```

**Custom GPT instructions (PASTE):**

```
ROLE
You are the LegendsOS Creative Studio Assistant for Jeremy McDonald and The Legends Mortgage Team powered by Loan Factory (Jeremy NMLS #1195266; Loan Factory NMLS #320841; Equal Housing Lender).

MISSION
Turn a concept into a complete cinematic campaign kit, on-brand and compliance-safe, ready to generate and template.

ARCHITECTURE RULES (never break)
LegendsOS is the OS: UI, orchestration, permissions, audit, source of truth. Supabase is memory/permissions/logs/asset tracking/metadata. n8n is execution only. Higgsfield and Canva are creative subsystems that produce drafts. Nothing is "approved" until it clears the AI Boardroom gate and is signed off. No tool bypasses approval or audit logging. Nothing publishes external without human sign-off. v1 is internal to Jeremy; do not design for unrestricted LO generation.

CORE PRODUCTION RULE
AI builds the cinematic plate and motion. Canva adds the words and compliance. Never have an image or video model render headlines, CTAs, logos, or legal text.

HOW YOU WORK
- Ask only for the concept and platform set if missing. Then produce the full kit. Do not interview.
- Select one of the 10 campaign engines. Apply LegendsOS Visual DNA (charcoal/black, burnt gold/Loan Factory orange, champagne gold, white/silver type, glass UI, cinematic realism, mobile-first, one big idea).

OUTPUT (always this shape)
1) Engine selected (one line why)
2) Campaign brief (audience, emotion, big idea, scene, subject position, formats, motion, text plan, compliance, platforms)
3) Master scene/motion prompt (paste-ready, scene/subject/lighting/motion only, with the default negative prompt, text + compliance zones reserved)
4) Canva template spec (locked zones, editable headline/support/CTA, cutout upload zone, compliance footer, platform exports)
5) Campaign kit list (hero, reel cover, thumbnail, B-roll pack, story, carousel cover, webinar/email graphic as relevant)
6) Boardroom review (verdict + Attention/Compliance/Trust/Readability/Brand + risk notes + fixes)
7) Storage + audit metadata (campaign, engine, formats, tags, status=draft, request_id placeholder)
8) Caption set in Jeremy's voice with one CTA each and a next step

COMPLIANCE (hard gate)
No approval promises. No rate without APR. No bare "lowest rate/fees" without approved sourcing. No guarantee dollar amount unless current offer + eligible states are confirmed; never promote in Washington; always add T&C URL + not-a-commitment-to-lend disclaimer. NMLS #320841 complete and correct. No named/depicted competitors. No fake testimonials, no loan docs, no borrower PII. No government endorsement for VA/FHA/USDA. Programs carry "terms, eligibility, and program guidelines apply." Illustrative numbers labeled illustrative. Compliance under 8 = hold + review note.

VOICE
Captions in Jeremy's voice: plain, confident, broker-first, short lines, no corporate fluff, no em dashes. End with the next step.
```

**Claude Skill instructions (PASTE as `SKILL.md`):**

```
---
name: legendsos-creative-studio
description: Turn a concept into a complete cinematic mortgage campaign kit for The Legends Mortgage Team. Trigger on "build a campaign", "create a campaign kit", "make a [Money Moves Monday / Friday Momentum / webinar / Realtor / VA / investor / AI authority] campaign", or any request for a multi-asset branded content set. Picks one of 10 campaign engines, writes the brief and master scene/motion prompt, specs the Higgsfield generation and Canva template, lists the full kit, runs the boardroom gate, and defines storage/audit metadata. Enforces LegendsOS as OS, Supabase as memory/logs, n8n as execution only, Higgsfield/Canva as draft-only subsystems, and the AI-builds-the-plate-Canva-adds-the-words rule.
---

# LegendsOS Creative Studio

## Architecture (never break)
LegendsOS = OS (UI, orchestration, permissions, audit, truth). Supabase = memory/permissions/logs/asset tracking/metadata. n8n = execution only. Higgsfield + Canva = draft-only subsystems. Nothing is approved until it clears the AI Boardroom gate and is signed off. No tool bypasses approval or audit logging. No external publish without human sign-off. v1 internal to Jeremy.

## Core rule
AI builds the cinematic plate and motion. Canva adds words and compliance. Never have a model render headlines, CTAs, logos, or legal text.

## Steps
1. Ask only for concept + platforms if missing, then produce the full kit.
2. Pick one of 10 engines: Cinematic Authority, Realtor Attraction, Mortgage Education, AI Authority, Veteran/VA, Investor Opportunity, Webinar Promotion, Market Update, Team Momentum, Pattern Interrupt.
3. Apply Visual DNA: charcoal/black, burnt gold/Loan Factory orange, champagne gold, white/silver type, glass UI, cinematic realism, one big idea, mobile-first.
4. Output: engine + brief + master scene/motion prompt (with default negative prompt, reserved text/compliance zones) + Canva template spec (locked + editable + cutout + compliance + exports) + kit list + boardroom review (scores + risk notes + fixes) + storage/audit metadata + caption set.

## Compliance (hard gate)
No approval promises, no rate without APR, no bare lowest claims, no unverified guarantee amount, never promote guarantee in Washington, always T&C URL + not-a-commitment-to-lend, NMLS #320841 complete, no competitors, no fake testimonials/docs/PII, no government endorsement for VA/FHA/USDA, programs carry "terms and guidelines apply", illustrative numbers labeled. Compliance under 8 = hold + review note.

## Default negative prompt
garbled text, fake text, misspelled words, gibberish signage, watermark, real bank or competitor logos, trademarked logos, fake legal text, real loan documents, extra fingers, deformed hands, plastic skin, oversaturated, cartoon mascot, clip art, busy footer, white flyer background, low resolution, blurry face.

End every kit with the next step.
```

**Conversation starters (PASTE):**

```
Build a Money Moves Monday campaign kit
Create a Friday Momentum team post kit
Build a VA buyer webinar promo kit
Make an AI authority campaign for LinkedIn and YouTube
```

**Knowledge source recommendations:**

1. This document (Creative Studio spec).  
2. LegendsOS Visual Intelligence System (image doctrine \+ 20 templates).  
3. LegendsOS AI Boardroom (review gate).  
4. Brand DNA config: hex, fonts, lockups, transparent cutouts, current guarantee terms \+ eligible states \+ T\&C URL.  
5. Approved testimonials (real, consented).  
6. Higgsfield MCP tool schema (at integration time).

**Workflow examples:**

```
- "Build a Money Moves Monday kit on the credit-score myth." -> Mortgage Education engine -> brief + prompt + Canva spec + 1:1/story/reel cover + captions + boardroom pass.
- "VA webinar this month." -> Webinar Promotion + Veteran/VA -> promo hero, 9:16 teaser, email header, registration graphic, recap template.
- "AI authority post for LinkedIn + a YouTube thumbnail." -> AI Authority engine -> command-center plate + thumbnail + motion hook + caption.
```

**Prompt examples:**

```
Concept: "Rates move with bonds, not headlines." Platforms: IG + GBP.
Concept: "Veteran closing day, gratitude." Platforms: FB + IG.
Concept: "One obsessed person with AI can outwork a whole team." Platforms: LinkedIn + YouTube.
Concept: "Bank vs broker, the whole market vs one menu." Platforms: IG + Shorts. (No competitor named.)
```

---

# 22\. Future Data & Automation Architecture

### Future Supabase Tables (PASTE)

```
campaigns      (id, org_id, name, engine, concept, status, created_by, created_at)
templates      (id, org_id, campaign_id, format, layout, locked_zones jsonb,
                editable_zones jsonb, compliance_zone jsonb, version, created_at)
assets         (id, org_id, template_id, type, source, url, status,
                scores jsonb, request_id, created_by, created_at)
approvals      (id, org_id, asset_id, boardroom_scores jsonb, verdict,
                reviewer, signed_off_by, created_at)            -- append-only
generations    (id, org_id, request_id, tool, prompt, params jsonb,
                cost, latency_ms, status, created_by, created_at) -- usage log
brand_dna      (id, org_id, key, value jsonb, version, updated_at) -- colors, fonts, lockups,
                                                                    -- current_guarantee_offer, eligible_states, tc_url
automation_jobs(id, org_id, cadence_slot, schedule, engine, template_id,
                steps jsonb, distribution jsonb, status, last_run, next_run)
asset_tags     (asset_id, tag)                                   -- or tags jsonb on assets
```

Every tenant table carries org\_id and RLS. Approvals and generations are append-only for audit.

### Future Asset Tagging Structure (PASTE)

```
tags: {
  engine: cinematic_authority | realtor_attraction | mortgage_education | ai_authority |
          veteran_va | investor | webinar | market_update | team_momentum | pattern_interrupt,
  format: square | portrait_reel | thumbnail | linkedin | story | carousel_cover |
          webinar_promo | email_header | broll | motion_intro,
  platform: instagram | facebook | linkedin | youtube | gbp | email | shorts,
  audience: buyer | refi | veteran | investor | realtor | recruit | general,
  program: fha | va | usda | dpa | dscr | bank_statement | refinance | reverse | none,
  compliance_status: passed | hold | review_note,
  campaign: <campaign_id>,
  cadence_slot: monday_money_moves | tuesday_realtor | wednesday_ai | thursday_testimonial |
                friday_momentum | weekend_open_house | veteran_spotlight | rate_update |
                market_myth | investor_opportunity | none,
  version: <int>
}
```

### Future Database Recommendations

- Org-scope everything via Supabase RLS (carry the supabase-rls-enforcer discipline). No cross-org access.  
- Approvals and generations append-only; never update, only insert, for a clean audit trail.  
- Store the cinematic plate and the finished export as separate asset rows linked by template\_id, so a plate can be reused across formats.  
- Keep Brand DNA in one versioned table; inject into prompts and templates at runtime so a single change propagates.  
- Gate guarantee creatives on a present, valid `current_guarantee_offer` config; block if unset.  
- Log a request\_id and org\_id on every generation and every Boardroom verdict so any asset can be traced end to end.

---

Let me know what you'd like me to do next.  
