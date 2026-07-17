# Mortgage Media OS
## AI-Powered Content System for The Legends Mortgage Team

**Built for:** Jeremy McDonald | NMLS 1195266  
**Company:** The Legends Mortgage Team powered by Loan Factory | NMLS 320841  
**Market:** Northeast Florida  
**Version:** 1.0 | May 2026  

---

## What This Is

This is a complete operating system for producing consistent, high-quality mortgage education content at scale. It's built around three ideas:

1. **Knowledge first.** The knowledge base contains everything I know about mortgage products, the local market, competitor positioning, and my brand voice. Content generation pulls from this knowledge base, which means every piece is accurate and on-brand.

2. **System over inspiration.** Good content doesn't come from waiting for inspiration. It comes from having a repeatable process. This OS gives me that process: from tracking what's working in my market to generating scripts, to submitting to HeyGen, to distributing across platforms.

3. **Compound advantage.** Every video I publish builds authority, search rank, and trust. The automation layer means the system compounds over time without requiring proportionally more of my personal time.

The primary content model is Epic Real Estate (Matt Theriault, ~300K subscribers). I've analyzed their hook strategy, production approach, content structure, and audience psychology. My differentiation: I'm local, I'm a broker (not an investor), I have the $1,000 guarantee, and I have 20 years of NE Florida market experience.

---

## Directory Structure

```
mortgage-media-os/
├── .env.example          # Environment variable template — copy to .env and fill in
├── README.md             # This file
│
├── config/               # System configuration
│   ├── personas.json     # Three content personas: inside-man, coach, wolf
│   ├── platforms.json    # Platform specs and repurposing matrix
│   ├── compliance.json   # NMLS, footer variants, disclosure templates
│   └── heygen.json       # HeyGen avatar and voice configuration
│
├── knowledge/            # The brain of the system
│   ├── epic-real-estate/ # Channel analysis (7 files)
│   │   ├── channel-overview.md
│   │   ├── hook-library.md
│   │   ├── thumbnail-psychology.md
│   │   ├── style-report.md
│   │   ├── audience-analysis.md
│   │   ├── content-calendar-patterns.md
│   │   ├── engagement-tactics.md
│   │   └── top-performing-videos.md
│   ├── mortgage-topics/  # Product knowledge (10 files)
│   │   ├── va-loans.md
│   │   ├── first-time-buyers.md
│   │   ├── rate-environment-2026.md
│   │   ├── credit-scores.md
│   │   ├── dscr-investor-loans.md
│   │   ├── closing-costs-explained.md
│   │   ├── fha-loans.md
│   │   ├── refinancing.md
│   │   ├── down-payment-strategies.md
│   │   ├── brrrr-strategy.md
│   │   ├── conventional-loans.md
│   │   └── usda-loans.md
│   ├── market-intelligence/ # Local + macro data (4 files)
│   │   ├── northeast-florida-market.md
│   │   ├── broker-vs-bank-talking-points.md
│   │   ├── fed-policy-tracker.md
│   │   └── competitor-analysis.md
│   └── jeremy-brand/     # Voice, stories, guarantee (3 files)
│       ├── voice-guide.md
│       ├── story-bank.md
│       └── guarantee-messaging.md
│
├── analytics/            # Data and tracking
│   ├── epic-real-estate/ # Channel monitoring outputs
│   │   ├── video-performance/
│   │   ├── hook-analysis/
│   │   ├── thumbnail-analysis/
│   │   ├── engagement-patterns/
│   │   └── topic-trends/
│   ├── competitors/
│   ├── market-data/
│   └── jeremy-performance/
│
├── outputs/              # Generated content
│   ├── daily/            # AI-generated drafts (date-stamped)
│   ├── scripts/
│   │   └── sample-package/   # Complete "$1,000 Guarantee" video package
│   │       ├── video-script.md
│   │       └── edit-package-brief.md
│   ├── heygen_prompts/
│   │   └── sample-package/   # HeyGen submission prompts + renders/
│   │       └── heygen-prompt.md
│   ├── thumbnails/
│   │   └── sample-package/   # 3 thumbnail concepts
│   │       └── thumbnail-brief.md
│   └── social-cuts/          # Platform-specific versions
│       ├── instagram-reel-guarantee.md
│       ├── linkedin-post-guarantee.md
│       └── facebook-post-guarantee.md
│
├── automation/           # Shell scripts for automation
│   ├── monitor-epic-re.sh    # Daily channel monitoring
│   ├── fetch-transcript.sh   # Transcript retrieval
│   ├── analyze-style.sh      # AI style analysis
│   ├── generate-content.sh   # Content generation with knowledge base
│   ├── heygen-submit.sh      # HeyGen API submission + download
│   └── publish-social.sh     # Social media publishing
│
├── templates/            # Reusable content templates
│   ├── video-script-template.md
│   ├── hook-formula-template.md
│   ├── thumbnail-brief-template.md
│   ├── heygen-prompt-template.md
│   └── social-cut-template.md
│
└── reports/              # Analysis reports
    ├── style-analysis-report.md
    ├── hook-library-report.md
    ├── thumbnail-psychology-report.md
    └── automation-requirements.md
```

---

## Quick Start

### 1. Set Up Environment
```bash
cp .env.example .env
# Edit .env and fill in API keys
```

### 2. Make Scripts Executable
```bash
chmod +x automation/*.sh
```

### 3. Test YouTube API Connection
```bash
./automation/monitor-epic-re.sh
```

### 4. Generate Your First Piece of Content
```bash
./automation/generate-content.sh --topic va-loans --persona inside-man --format youtube-script
```

### 5. Submit to HeyGen (after finalizing script)
```bash
./automation/heygen-submit.sh --script outputs/scripts/your-script.md --segment 1
```

---

## The Three Personas

| Persona | Energy | Use For |
|---------|--------|---------|
| **The Inside Man** | Confident, knowing | Educational explainers, broker advantage content |
| **The Coach** | Warm, motivational | First-time buyers, emotional topics, process guides |
| **The Wolf** | Sharp, urgent | Investor content, DSCR, market timing, rate alerts |

Default is Inside Man for most content. Switch personas intentionally based on audience and topic.

---

## Content Production Workflow

```
1. IDEA
   Identify topic from knowledge base or Epic RE trend
   Run: hook-formula-template.md to develop 3 hook options
   
2. SCRIPT
   Run: generate-content.sh --topic [X] --persona [Y] --format youtube-script
   Review and refine the draft
   Finalize sections, B-roll notes, data points
   
3. HEYGEN
   Segment script per heygen-prompt-template.md
   Run: heygen-submit.sh for each segment
   Download renders to /outputs/heygen_prompts/[package]/renders/
   
4. EDIT
   Follow edit-package-brief.md
   Stitch segments, add graphics, add compliance overlay
   Export YouTube master + vertical crop for Reels
   
5. DISTRIBUTE
   Upload YouTube video with full description + timestamps
   Run: publish-social.sh for Instagram, Facebook, LinkedIn
   Post Google Business update
   Send to email list (GHL automation)
   
6. TRACK
   Check YouTube CTR at 48 hours
   Swap thumbnail if below 4%
   Log performance in analytics/jeremy-performance/
```

---

## Compliance Requirements

Every piece of published content must include:

**Standard footer:**
> Jeremy McDonald | The Legends Mortgage Team powered by Loan Factory | NMLS 1195266 | Loan Factory NMLS 320841 | Equal Housing Opportunity

**For rate-related content, add:**
> Rates shown are for illustrative purposes. Actual rates based on creditworthiness, loan type, and market conditions at time of application.

**For the $1,000 Guarantee:**
> The $1,000 Lowest Rate and Fee Guarantee applies when a competing written Loan Estimate on the identical loan program shows lower rate AND lower fees before closing. See full terms at [website].

Full compliance templates are in `config/compliance.json`.

---

## Keeping the Knowledge Base Current

The knowledge base is only as good as its data. Update these files on the following schedule:

| File | Update Frequency |
|------|-----------------|
| rate-environment-2026.md | Monthly |
| fed-policy-tracker.md | After each FOMC meeting |
| northeast-florida-market.md | Monthly (NAR/Realtor.com data) |
| competitor-analysis.md | Quarterly |
| dscr-investor-loans.md | Quarterly (rates change) |
| All other knowledge files | As regulations/products change |

---

## HeyGen Quick Reference

**Avatar ID:** 417274708f6a4fb6bfe850e2f0e575e7  
**API Base:** https://api.heygen.com  
**Max script per segment:** ~600 words (verify with current plan limits)  
**Typical render time:** 10-30 minutes per segment  
**Resolution:** 1920x1080 (16:9) for YouTube, request vertical crop for Reels  

**Pronunciation overrides in scripts:**
- NMLS → spell out: "N-M-L-S"
- DSCR → "D-S-C-R"
- DTI → "D-T-I"
- LTV → "L-T-V"
- APR → "A-P-R"

---

## Dependencies

**Required for automation scripts:**
- `jq` — JSON parsing (install: `brew install jq`)
- `python3` — Python 3.9+
- `pip install youtube-transcript-api anthropic` — Python packages
- `curl` — Usually pre-installed on Mac
- `yt-dlp` — Fallback for transcripts (install: `brew install yt-dlp`)

**API Keys Required:**
- YouTube Data API v3 (Google Cloud Console)
- Anthropic API key (console.anthropic.com)
- HeyGen API key (app.heygen.com → Settings → API)
- Facebook/Instagram Graph API (Meta for Developers)
- LinkedIn API (LinkedIn Developer Portal)

---

## Built With

This system was designed and built using:
- **Claude** (Anthropic) — AI content generation and analysis
- **HeyGen** — AI avatar video generation (Avatar IV)
- **YouTube Data API v3** — Channel monitoring
- **GoHighLevel** — CRM and lead pipeline (separate)
- **n8n** — Workflow automation (separate)

---

*Jeremy McDonald | The Legends Mortgage Team powered by Loan Factory | NMLS 1195266 | Loan Factory NMLS 320841 | Equal Housing Opportunity*
