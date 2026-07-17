# LegendsOS Master Skills Build Plan

**Owner:** Jeremy McDonald, The Legends Mortgage Team powered by Loan Factory
**Scope:** Convert the six LegendsOS system docs into 14 production Claude Skills + matching Custom GPT packages
**Rule:** One skill per major system. No mega-skills. Each skill is its own folder with SKILL.md, examples, test prompts, usage notes, knowledge files, and compliance.

---

## 1. Recommended Skill Folder Structure

Top level lives in the LegendsOS Skills & CustomGPT Assist Builder folder. Two families, both flat.

```
legendsos-skills/
├── _shared/
│   ├── brand-dna/                          shared by every skill (colors, fonts, lockups, voice)
│   │   ├── visual-dna.md
│   │   ├── voice.md
│   │   ├── nmls-eho-footer.md
│   │   ├── guarantee-terms.md              current $ amount + eligible states + T&C URL
│   │   └── compliance-pack.md              the LEGENDSOS CUSTOMER-FACING guardrails block
│   ├── knowledge/                          assets pointed to by multiple skills
│   │   ├── persona-guide-heygen.md
│   │   ├── safe-cta-list.md
│   │   ├── default-negative-prompt.md
│   │   ├── service-area-nap.md
│   │   ├── respa-do-dont.md
│   │   └── canspam-block.md
│   └── templates/
│       ├── skill-template.md               the v2 template every skill clones
│       └── custom-gpt-template.md
│
├── platform/                               the 5 standalone "system" skills
│   ├── ai-boardroom/
│   ├── visual-intelligence/
│   ├── creative-studio/                    ⚠ requires Higgsfield MCP for full power
│   ├── youtube-intelligence/
│   └── meet-prompter/                      Chrome extension + a script-loader skill
│
└── companions/                             the 9 customer-facing companions from the Pack v2
    ├── 01-image-studio/                    ⚠ supersedes the Pack #1; see Conflict #1
    ├── 02-heygen-video/
    ├── 03-broll-ai-video/                  ⚠ partially Higgsfield-gated for AI video clips
    ├── 04-email-newsletter/
    ├── 05-seo-aeo-geo-gbp/
    ├── 06-social-media/
    ├── 07-realtor-partner-outreach/
    ├── 08-integrations-setup/
    └── 09-webinar-builder/                 Meet Prompter syncs here in v0.2
```

**Every skill folder follows this exact shape:**

```
<skill-slug>/
├── SKILL.md                                frontmatter + system instructions (Claude format)
├── CUSTOM_GPT.md                           paste-ready Name / Description / Instructions / Starters
├── README.md                               what this is, who uses it, when to use it
├── knowledge/                              skill-specific knowledge files
│   └── (links into _shared where reused)
├── examples/                               3 to 5 real "input → output" examples
│   ├── example-01.md
│   ├── example-02.md
│   └── example-03.md
├── test-prompts.md                         the go-live checklist + 10 to 20 test prompts
├── usage-notes.md                          edge cases, what to NOT use it for, hand-off rules
└── compliance.md                           skill-specific compliance lines + pack-wide reference
```

---

## 2. Skill Dependency Map

```
                              ┌──────────────────────┐
                              │  _shared/brand-dna   │  ← every skill reads this
                              └──────────┬───────────┘
                                         │
       ┌─────────────────────────────────┼──────────────────────────────┐
       │                                 │                              │
┌──────▼──────────┐            ┌─────────▼─────────┐         ┌──────────▼──────────┐
│  ai-boardroom   │◄───────────┤ visual-intel      │◄────────┤  creative-studio    │
│  (review gate)  │            │ (single images)   │         │  (campaign engine)  │
└──────┬──────────┘            └────────┬──────────┘         └─────────┬───────────┘
       │                                │                              │
       │ gates everything below         │ feeds Image Studio           │ uses both above
       │                                │                              │ + Higgsfield MCP
       ▼                                ▼                              ▼
┌──────────────────────────────────────────────────────────────────────────┐
│                       COMPANION PACK (the 9)                              │
│                                                                            │
│  01 Image Studio  ←──── replaced by visual-intelligence                   │
│  02 HeyGen Video                                                          │
│  03 B-Roll & AI Video  ←──── needs Higgsfield for AI clips                │
│  04 Email Newsletter                                                      │
│  05 SEO/AEO/GEO/GBP                                                       │
│  06 Social Media                                                          │
│  07 Realtor & Partner Outreach                                            │
│  08 Integrations Setup                                                    │
│  09 Webinar Builder  ◄──── meet-prompter syncs to this in v0.2            │
└──────────────────────────────────────────────────────────────────────────┘
       ▲                                                          ▲
       │                                                          │
┌──────┴──────────────┐                                  ┌────────┴──────────┐
│ youtube-intelligence│  feeds ideas into Creative,       │  meet-prompter    │
│ (research engine)   │  Social, Email, Webinar, YT       │  (Chrome MV3 ext) │
└─────────────────────┘                                  └───────────────────┘
```

**Hard dependencies (in order):**
1. `_shared/brand-dna` and `_shared/knowledge` must exist before any skill is built.
2. `ai-boardroom` must exist before `visual-intelligence` or `creative-studio` ships, because both reference its gate.
3. `visual-intelligence` must exist before `creative-studio`, because Creative Studio embeds it for single-image work.
4. `creative-studio` is the only one that strictly requires the Higgsfield MCP. Visual Intelligence and AI Boardroom do not.
5. `youtube-intelligence` outputs route into Creative Studio, Social Media, Email Newsletter, Webinar Builder.
6. `meet-prompter` runs standalone in v0.1, then connects to `09-webinar-builder` in v0.2.

---

## 3. Best Build Order

Four waves. Ship each wave fully before starting the next. Reuse the v2 skill template so every skill looks and behaves the same.

**Wave 0 — Foundation (build before anything else)**
1. `_shared/brand-dna/` (visual DNA, voice, NMLS + EHO footer, $1,000 guarantee terms, compliance pack)
2. `_shared/knowledge/` (persona guide, safe CTA list, default negative prompt, NAP, RESPA, CAN-SPAM)
3. `_shared/templates/skill-template.md` and `custom-gpt-template.md`

**Wave 1 — Brain and gates (no Higgsfield needed)**
4. `ai-boardroom` (the review gate every other skill calls)
5. `visual-intelligence` (single-image production, replaces Pack #1)
6. `companions/04-email-newsletter` (daily revenue use)
7. `companions/06-social-media` (daily revenue use)

**Wave 2 — Distribution and partner**
8. `companions/09-webinar-builder` (highest leverage in the pack)
9. `companions/07-realtor-partner-outreach`
10. `companions/05-seo-aeo-geo-gbp`

**Wave 3 — Research, content production, voice/video (Higgsfield not required for HeyGen)**
11. `youtube-intelligence` (start feeding the studios)
12. `companions/02-heygen-video`
13. `companions/03-broll-ai-video` (text plan + B-roll planning works today; AI clip generation waits for Higgsfield)

**Wave 4 — Orchestration and tools (Higgsfield + Chrome)**
14. `creative-studio` (campaign-level engine, hold until Higgsfield MCP is connected)
15. `companions/08-integrations-setup` (build last so the other skills have something to plug into)
16. `meet-prompter` v0.1 (Chrome extension MVP, no LegendsOS sync yet)

**Companion #1 Image Studio is deliberately not on the list.** See Conflict #1. The official replacement is `visual-intelligence`.

---

## 4. Conflicts Between Documents

**Conflict #1 — Image Studio vs Visual Intelligence (must decide)**
- Pack v2 Companion #1 ("LegendsOS Image Studio Assistant") and the Visual Intelligence System describe the same job.
- The Visual Intelligence doc explicitly says it is "the upgraded engine behind the Image Studio Assistant (#1 in the Companion Pack)."
- **Resolution:** retire the Pack #1 spec. Build `visual-intelligence` as the production version. The companion folder `01-image-studio/` exists only as a README redirect that points to `visual-intelligence`.

**Conflict #2 — Creative Studio and the video companions overlap**
- Creative Studio claims responsibility for "hero images, reel covers, YouTube thumbnails, B-roll, animated hooks, Canva templates, webinar promo kits, email graphics, and storyboards."
- That overlaps with Companion #2 (HeyGen) and #3 (B-Roll & AI Video).
- **Resolution:** Creative Studio is the campaign orchestrator. It calls into HeyGen and B-Roll skills for single-asset work the same way it calls into Visual Intelligence for single images. Do not let Creative Studio re-implement script writing or B-roll planning. Keep clear hand-offs.

**Conflict #3 — Webinar Builder vs Meet Prompter**
- Webinar Builder produces the script. Meet Prompter loads the script during the live webinar.
- The Meet Prompter spec says v0.2 pulls approved scripts from Supabase via the LegendsOS API.
- **Resolution:** no real conflict, but make the JSON schema match on day one. Webinar Builder must output the exact Section 5 JSON schema from the Meet Prompter spec. Lock the schema in `_shared/knowledge/webinar-script-schema.json` so both skills point at the same file.

**Conflict #4 — Compliance footer text drift**
- The Pack v2 compliance block and the Visual Intelligence Section 7 rules and the Creative Studio Section 9 overlay are 95 percent identical, with small wording differences.
- **Resolution:** one canonical file at `_shared/brand-dna/compliance-pack.md`. Every skill references it. No skill keeps its own copy of the footer text.

**Conflict #5 — Boardroom seat lists differ across docs**
- AI Boardroom Assistant uses 8 Strategy seats + 7 Operational seats.
- Visual Intelligence and Creative Studio reference 8 visual lenses (Marketing Strategist, Compliance, Mortgage Expert, Consumer Psych, Realtor Relationship, Brand Designer, Social Performance, Conversion Strategist).
- YouTube Intelligence uses 8 YouTube-tuned lenses.
- **Resolution:** these are different boards by design, all owned by the AI Boardroom skill. Document them as "Visual Board," "YouTube Board," "Strategy Council," "Operational Council" inside the `ai-boardroom` skill so the gate logic is centralized but the lenses are workflow-specific.

---

## 5. Missing Source Files Needed Before Builds Start

Real gaps. These need to exist or the skills will guess.

1. **Current $1,000 Lowest Rate & Fee Guarantee terms** as a single source-of-truth file: live dollar amount, eligible states (excluding Washington), T&C URL. Without this the compliance gate blocks all guarantee creatives.
2. **Official LegendsOS brand kit** with exact hex values, font files or font names, the Legends + Loan Factory lockup files (PNG and SVG), and transparent cutout PNGs of Jeremy at usable resolution.
3. **HeyGen persona guide** for Inside Man / Coach / Wolf, with sample lines and pacing notes, plus a phonetic dictionary for mortgage terms.
4. **Approved testimonial bank** with real reviews, real first names + city, written consent on file, loan-type tags.
5. **Boardroom Risk Register / Architecture Readout** with the full R-code list (the AI Boardroom doc references R2, R3, R4, R7, R8, R10 but the full register lives "in Jeremy's architecture docs").
6. **AI_BOARDROOM_COMPLETE.md** and **2026-05-19_AI_Boardroom_Review_Two_Automation_Workflows.md** (referenced as primary knowledge files for the Boardroom skill).
7. **Curated YouTube channel list** with channel handles, channel IDs, category tags, and priority, for `youtube-intelligence` to ingest.
8. **TERA + stack reference** doc: what TERA holds, API access status, Airtable middle layer, n8n local vs Hostinger VPS, Zapier MCP limits, approved AI providers.
9. **Webinar script JSON schema file** (lock the shape from Meet Prompter Section 5 so Webinar Builder and Meet Prompter cannot drift).
10. **Canva Pro template names** for the 14 layouts in Visual Intelligence (so the AI references real template IDs, not invented ones).
11. **n8n credentials list and webhook signing standard** for `08-integrations-setup`.
12. **RESPA do/don't reference and dual-NMLS co-brand lockup rules** for `07-realtor-partner-outreach`.

If any of these are missing on build day, the skill ships with placeholders and a "REQUIRES SOURCE FILE" flag in the compliance section.

---

## 6. Higgsfield MCP Gating

Per your clarification: Higgsfield is only required for Creative Studio and B-Roll / video generation. Boardroom and Visual Intelligence do not need it.

**Wait for Higgsfield MCP:**
- `creative-studio` (campaign-level cinematic stills + image-to-video + B-roll + motion intros)
- The "AI clip generation" portion of `companions/03-broll-ai-video`

**Do NOT wait for Higgsfield:**
- `ai-boardroom` (text only)
- `visual-intelligence` (writes prompts; image generation handled by current tools or downstream when Higgsfield arrives)
- `companions/02-heygen-video` (HeyGen has its own MCP / API)
- `companions/03-broll-ai-video` *planning portion* (shot lists, B-roll plans, captions, edit direction all work today)
- `companions/04-email-newsletter`, `06-social-media`, `05-seo-aeo-geo-gbp`, `07-realtor-partner-outreach`, `09-webinar-builder`
- `youtube-intelligence`
- `meet-prompter`

**Build seam for Higgsfield:** every skill that will eventually call it must expose a `mediaGenerator` interface with a `LocalDraftSource` now and a `HiggsfieldSource` later. That way Creative Studio and B-Roll ship in "spec output only" mode today and flip to "generate" the moment the MCP is connected. No skill rewrites needed.

---

## 7. Exact Next Prompt to Create the First Skill

The first skill is **`ai-boardroom`** because Visual Intelligence and Creative Studio both reference its gate. Build the brain first, then the engines.

Paste this exact prompt into your next Claude session:

```
Build the first LegendsOS skill: ai-boardroom.

Source: /Volumes/LegendsOS/Jeremy's_2026_Master_Build_Folder/legends-team-builds/LegendsOS Skills & CustomGPT Assist Builder/uploads/LegendsOS-AI-Boardroom-Assistant.md (or the uploaded LegendsOS-AI-Boardroom-Assistant.md file in context)

Target folder: /Volumes/LegendsOS/Jeremy's_2026_Master_Build_Folder/legends-team-builds/LegendsOS Skills & CustomGPT Assist Builder/legendsos-skills/platform/ai-boardroom/

Create this exact structure:
- SKILL.md (Claude Skill format with frontmatter; use the PASTE block from the source doc as the body)
- CUSTOM_GPT.md (Name, Short Description, Long Description, Instructions, Conversation Starters, Knowledge Files, paste-ready)
- README.md (what it is, who uses it, when to invoke, when NOT to invoke)
- knowledge/ (subfolder; include placeholders pointing to AI_BOARDROOM_COMPLETE.md, the automation review doc, the Risk Register, the Loan Factory compliance pack, the TERA + stack reference, the brand voice doc)
- examples/ (subfolder with 5 worked examples taken from the "Example Prompts" section of the source doc, each as its own markdown file showing input + the full 10-part output)
- test-prompts.md (use the "AI Boardroom Go-Live Checklist" from the source plus 10 additional test prompts I can run quickly)
- usage-notes.md (when to use Strategy Council vs Operational Council, the persona limit rules, hand-off rules to Visual Intelligence and Creative Studio, what NOT to use this skill for)
- compliance.md (the LEGENDSOS AI BOARDROOM GUARDRAILS block from the source, plus a one-line reference to _shared/brand-dna/compliance-pack.md)

Rules:
- Do not merge any other system into this skill.
- Keep every PASTE block from the source doc word-for-word in its final destination file.
- Use Jeremy's voice in README and usage-notes (plain, confident, no em dashes, no corporate fluff).
- Do not invent R-codes or seat names beyond what the source doc lists.
- Output the final file tree at the end so I can verify.

End with the next step: what to build next in Wave 1.
```

---

## Wrap

The plan is execution-ready. Foundation first, then Boardroom, then Visual Intelligence, then the two daily-use companions (Email + Social), then leverage (Webinar Builder), then research (YouTube), then video, then Higgsfield-gated work (Creative Studio + AI video clips), then plumbing (Integrations), then Meet Prompter v0.1. Conflicts are resolved on paper. The 12 missing source files are listed so nothing ships with invented facts.

Let me know what you'd like me to do next.
