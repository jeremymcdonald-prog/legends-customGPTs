# Verified Source Knowledge — Agent 13

**Verified from local disk:** 2026-05-24
**Method:** Direct file read from `/Users/JeremyMcDonald/Desktop/JEREMY's MASTER BUILD FOLDER/`
**No GitHub auth used.**

---

## AI Realtor Pro — Source: `AI-Realtor-Pro-Final-main/`

### Files Read Successfully
- `README.md`
- `package.json`
- `app/layout.tsx`
- `app/page.tsx` (landing page — 828 lines)
- `app/about/page.tsx` (About Jeremy page)
- `app/dashboard/page.tsx`
- `app/ai-twin/page.tsx`
- `app/marketing-studio/page.tsx`
- `app/get-preapproved/page.tsx`
- `app/` directory listing (about, about-jeremy, admin, ai-twin, api, automation, coach, dashboard, flowclaw, get-preapproved, loan-officer, marketing-studio, projects, settings, team-leader)
- `components/` directory listing (auth, brand, chat, environment, layout, onboarding, studio, theme, ui, video)

### Files Not Found or Empty
- No standalone `app/features/page.tsx` (features are embedded in landing page)
- No top-level "marketing" or "integrations" file outside the landing page

### Verified Product Name
- **"AI Realtor Pro"** (exact string from `app/layout.tsx:9`)
- Tagline in metadata: **"AI Realtor Pro — Built by Axon Forge AI"** (`app/layout.tsx:9`)
- Footer credit: **"AI Realtor Pro — Built by Axon Forge AI"** (`app/page.tsx:645`)
- Footer attribution: **"© [year] AI Realtor Pro. Powered in partnership with Legends Mortgage Team."** (`app/page.tsx:648`)
- Package name: `"ai-realtor-pro"` (`package.json:2`)

### Verified Audience
- "Realtors" / "real estate agents" (used throughout landing page)
- Specifically: **"agents working directly with Jeremy McDonald and the Legends Mortgage Team"** (`app/page.tsx:520`)
- Tagline: **"Built for agents who want leverage — not more busy work."** (`app/page.tsx:256`)
- Modal subtitle: **"The private AI operating system used by agents working with Jeremy McDonald and the Legends Mortgage Team."** (`app/page.tsx:662`)

### Verified Features / Sections (from `app/page.tsx`)
1. **AI Twin** — "An AI version of you that never forgets to follow up, never runs out of content, and never sounds generic." (line 378)
2. **Instant Marketing Engine** — "Listings, posts, scripts, emails — delivered the moment you need them. Every asset, every platform, every day." (line 386)
3. **Lead Conversion System** — "Leads don't go cold. They get worked instantly." (line 394)
4. **Multi-Platform Presence** — "Instagram, Facebook, email, video, SMS. You're everywhere your clients are — without lifting a finger." (line 402)

### Verified "Reality Scenarios" (live use cases)
- **Live lead response:** "Agent gets a new lead → AI follows up within seconds → Conversation starts before the agent even opens their phone" (lines 314-319)
- **Content multiplication:** "One listing → AI turns it into a full week of content → Posted across multiple platforms automatically" (lines 326-331)
- **Database reactivation:** "Past client database → AI re-engages them consistently → Without any manual effort from the agent" (lines 338-343)

### Verified Outcomes (from `app/page.tsx`)
- "More conversations" — Every lead engaged. Every day. (line 433)
- "Faster follow-up" — Seconds, not days. Closed loops, not leaks. (line 440)
- "Consistent visibility" — Every client, every platform, every week. (line 447)
- "More deals closed" — Because the agents in front always win. (line 454)

### Verified Integrations (from FAQ, `app/page.tsx:633`)
**Exact string:** "Gmail, Google Drive, Google Business Profile, Meta (Instagram and Facebook), YouTube, FollowUpBoss CRM, and HeyGen for AI video. More added continuously."

### Verified Access Model — Invite Only / Closed Platform
- Hero badge: **"Private AI System · Invite Only"** (`app/page.tsx:208`)
- Exclusivity badge: **"Closed Platform"** (`app/page.tsx:514`)
- Headline: **"You can't buy this."** (`app/page.tsx:517`)
- Body: **"AI Realtor Pro is not publicly available. It's only accessible to agents working directly with Jeremy McDonald and the Legends Mortgage Team."** (`app/page.tsx:520`)
- "Access is granted by referral. If you're already in the room, request your seat." (`app/page.tsx:526`)
- FAQ: "Access is invite only. If you're working with Jeremy McDonald or the Legends Mortgage Team, you already qualify." (`app/page.tsx:614`)

### Verified Positioning Copy (hero, `app/page.tsx:213`)
- Headline: **"Close More Deals. Stay Top of Mind. And Stop Losing Clients to Agents Who Follow Up Faster."**
- Lead paragraph: **"AI Realtor Pro is your personal AI twin and automated marketing system that writes, follows up, and keeps you in front of every client — without you doing the work."** (line 221)
- "Most agents don't lose deals because they're bad. They lose deals because they disappear." (lines 223-225)
- Subhead: "This isn't a tool. It's your unfair advantage." (line 363)
- Features sub: "Four systems running in sync — so every lead gets nurtured, every post gets made, and every deal gets closed faster." (line 367)
- Pre-CTA: "Most agents fall behind because they can't keep up. And they don't even realize it until the deal is gone." (lines 570-572)
- Final tag: "No learning curve. No extra work. Just leverage." (line 594)

### Verified AI Twin Detail (FAQ + Configure page)
- "Your AI Twin trains on your voice, your market, and your process. Every message, post, and follow-up it produces sounds like you — because it is you, at scale." (`app/page.tsx:621`)
- AI Twin page (`app/ai-twin/page.tsx`) has fields: name, market, brokerage, years experience, style, tone level (1-5), useEmojis, follow-up style, caption style, content types/platforms

### Verified Dashboard "Start Here" Flow (`app/dashboard/page.tsx:288`)
1. Create Your AI Twin — "Train it on your voice, listings, and local expertise."
2. Generate Content — "Turn one listing into a week of posts, reels, and emails."
3. Capture Leads — "Launch the automated lead pipeline and track conversions."

### Verified Pre-Approval Routing (`app/get-preapproved/page.tsx:17`)
- **"All mortgage conversations route to Jeremy McDonald (NMLS# 2121161)."**
- Apply link: `loanfactory.com/jeremymcdonald`
- Phone: 904-442-3213
- Email: jeremy@mcdonald-mtg.com

⚠️ **NMLS DISCREPANCY:** AIRP `get-preapproved/page.tsx` shows NMLS# **2121161**. All other Jeremy assets (Jeremy site `constants.ts`, Legends Team site `constants.ts`, AGENT.md compliance footer, `public/llms.txt`) show NMLS **1195266**. **This needs Jeremy's review.** Do not use NMLS in newsletter copy until reconciled.

### About-Page Stats (`app/about/page.tsx:194`)
- 50+ team members trained
- $100M+ in production volume
- AI-First marketing approach
- Top 1% industry innovator
- Role line: "Team Leader · Loan Officer Development · AI Trainer"
- About copy: "Team Leader · Legends Mortgage Team / Loan Officer Development & Marketing Strategy Consultant / In-house AI Trainer at Loan Factory"
- Bullet: "Built AI Realtor Pro — the private AI operating system for agents."
- Bullet: "Runs bi-weekly training for Loan Factory loan officers."
- Phone on about page: (904) 424-2025 ← **second phone — different from primary (904) 442-3213. Likely typo in source; not in newsletter copy.**

### Tech Stack (from `package.json`)
- Next.js 15.4.9, React 19, Firebase (auth + admin), Tailwind 4, Sonner toasts, react-markdown, Lucide icons
- Auth: Google sign-in (Firebase Auth)
- Routes a "lead-flow" workflow: lead created → project created → AI intro generated → AI followup generated → AI content generated → email sent → fub_synced

### Not Verified (missing from source)
- **Pricing or subscription terms** — not in any inspected file
- **Public launch status** — "Live System" badge appears (page.tsx:276) but no explicit beta/GA labeling
- Any third-party endorsement, certification, or award claim
- Specific user count or numeric agent metrics

---

## Florida Home Buying Network — Source: `florida-home-buying-network-main/`

### Files Read Successfully
- `README.md`
- `package.json`
- `App.tsx` (44 lines)
- `pages/Home.tsx`
- `pages/` directory listing (Blog, Directory, Forms, Home, IDX, MetroHub, ProProfile)
- `components/Layout.tsx`
- `services/api.ts`
- `types.ts`
- `constants.ts` (453 lines — METROS, CATEGORIES, PROS arrays)
- `locales/en/common.json` (full i18n)

### Files Not Found or Empty
- No `services/api.ts` exception, no separate `RealtorPilotReview.tsx` (the user request mentioned it; not present)

### Verified App Name (`locales/en/common.json:3`)
- Brand: **"Florida Home Buying"** with appended "Network" wordmark (`components/Layout.tsx:44`)
- Blog title: **"Florida Home Buying Network Blog"** (`locales/en/common.json:125`)
- Package name: `"florida-home-buying-network"` (`package.json:2`)

### Verified Routes (`App.tsx`)
- `/` (Home)
- `/directory` (Directory)
- `/metros/:slug` (MetroHub)
- `/pros/:slug` (ProProfile)
- `/blog`, `/blog/:slug`
- `/homes`, `/idx` (IDX placeholder)
- `/get-pre-approved` (Mortgage lead form)
- `/find-agent` (Agent lead form)
- `/get-quote` (Quote lead form)

### Verified Home Tabs (`locales/en/common.json:49`)
- "Buy a home"
- "Find a pro"
- "Get financing"
- "Invest in Florida"

### Verified Hero Copy (`locales/en/common.json:47`)
- Headline: **"Find your Florida home team in one trusted search."**
- Sub: **"Search homes, compare licensed professionals, and get financing help with clear next steps."**

### Verified Trust Bullets (`locales/en/common.json:62`)
1. "Licensed and verified Florida professionals"
2. "Fast financing handoff with human follow-up"
3. "Clear categories, no confusing lead marketplaces"
4. "Local market context for buyers and investors"

### Verified Footer Copy (`locales/en/common.json:24`)
- Description: "Shop homes, compare local service pros, and connect with licensed financing experts in one trusted place."
- Trust list: "Verified professionals · Transparent lead routing · Florida local expertise"

### Verified Lead Forms (`locales/en/common.json:134`)
- Mortgage form title: **"Get Pre-Approved"**
- Mortgage form sub: **"Fast track your home buying journey with the Legends Mortgage Team."**
- Agent form title: "Find an Agent" / "Connect with a top-rated local expert in your desired metro area."
- Quote form title: "Request a Quote" / "Tell us about your project and get connected with verified professionals."

### Verified Mortgage Owner Slot (`constants.ts:32`)
- The mortgage "Pro" record at id `p1` is **"Legends Mortgage Team"** company "Legends Mortgage" (slug: `legends-mortgage-team`)
- isFeatured: true
- Tags: "Fast Closing", "Jumbo Loans", "First Time Buyer", "VA Loans"
- Badges: NMLS, Top Rated, Verified
- Service areas: miami, tampa, orlando, jacksonville, fort-lauderdale

⚠️ **Placeholder contact data:** The Legends record currently uses placeholder phone `(555) 123-4567`, email `hello@legends.com`, website `https://legends.com`. **This is mock data — do not quote in newsletters.**

### Verified Metros (`constants.ts:4`)
Miami, Fort Lauderdale, West Palm Beach, Tampa, Orlando, Jacksonville, Naples, Central Florida — statewide Florida, not Jacksonville-only.

### Verified Categories (`constants.ts:16`)
Real Estate Agent, General Contractor, Roofer, Plumber, Electrician, HVAC, Pool Services.

### Verified Languages Supported (`locales/`)
- `en/` (English)
- `es-PR/` (Spanish — Puerto Rico variant)
- Language toggle label: "Español PR" (`locales/en/common.json:21`)

### Verified Bilingual Statement (`chat.welcome`)
- AI concierge welcome: "Hello! I'm your Florida Home Concierge. Are you looking to buy a home, find a contractor, or check mortgage rates today?"

### Verified Lead Routing (`services/api.ts:80`)
- `submitLead` writes to a Supabase `leads` table (per code comment).
- Lead types: `MORTGAGE`, `AGENT`, `QUOTE`, `IDX_NOTIFY` (`types.ts:57`)

### Verified Pro Profiles
The directory ships 18+ pros including Jacksonville agents (Expert Home Advisors, Gailey Enterprises, Joseph Larsen, Melissa Ricks, Kallam Realty), Central Florida agents (Erica Diaz Team, The Nickley Group with KW, Wemert Group Realty), Miami agents, and a handful of contractors/trades. **All non-Legends contact phone numbers in `constants.ts` are placeholders (555/904/407/305 area codes with -555- prefix), so do not cite specific pros in newsletter copy without confirmation.**

### Not Verified (missing from source)
- Live launch status (Supabase health check is gated by env vars; no marketing copy says "live" vs "beta")
- Any pricing for Realtors or pros to be listed
- Any RESPA disclosure or referral compensation language
- Whether the mortgage handoff is exclusive to Legends Mortgage Team (the directory only has one MORTGAGE entry, but no copy states exclusivity)
- "Realtor Pilot" page mentioned in the original task list — not present in repo

---

## Jeremy McDonald Website — Source: `final-jeremy-mcdonald-mtg.com-main/`

### Files Read Successfully
- Top-level directory listing
- `constants.ts` (300+ lines read; COMPANY_INFO, LOAN_OPTIONS, FEATURES, LOAN_PROGRAM_VIDEOS, TESTIMONIALS, NAV_ITEMS)
- `pages/HomePage.tsx`
- `pages/AgentsPage.tsx` (full file)
- `pages/InvestorHubPage.tsx`
- `public/llms.txt`
- `content/blog/en/first-time-buyer-structure-guide.md` (partial)
- Headlines extracted from all 29 blog files in `content/blog/en/`

### Files Not Found
- `public/ai.txt` — does not exist
- `public/llms-full.txt` — does not exist (only `llms.txt`)
- `public/humans.txt` — does not exist
- No standalone `pages/AiRealtorProPage.tsx` (AI Realtor Pro positioning lives inside `pages/AgentsPage.tsx`)
- The following blog files **DO NOT EXIST** in the repo (these were guessed in the original task spec):
  - `mortgage-broker-vs-bank-2026-wholesale-broker-advantages.md` (actual: `mortgage-broker-vs-bank-florida.md`)
  - `jacksonville-mortgage-broker-vs-bank-guide.md`
  - `jacksonville-va-loan-preapproval-guide.md`
  - `jacksonville-fha-loan-guide-first-time-buyers.md`
  - `northeast-florida-usda-loan-guide-2026.md` (actual: `usda-eligible-best-100-percent-financing-spots-near-jax-2026.md`)
  - `self-employed-mortgage-florida-2026.md`
  - `florida-homebuying-2026-fully-preapproved-before-shopping.md`
  - `jacksonville-mortgage-preapproval-documents-checklist.md`
  - `jacksonville-new-construction-mortgage-guide-2026.md`
- Only `first-time-buyer-structure-guide.md` from the original list exists.

### Verified Brand and Identity (`constants.ts:16` COMPANY_INFO)
- name: **"Jeremy McDonald Mortgage"**
- poweredBy: **"Loan Factory"**
- leader: **"Jeremy McDonald"**
- role: **"Loan Officer, Team Leader, The Legends Mortgage Team"**
- **NMLS: 1195266**
- **Company NMLS: 320841**
- directPhone: **(904) 506-0181**
- mobilePhone: **(904) 442-3213**
- corporatePhone: **(407) 500-6000**
- location: **"Jacksonville, Florida"**
- address: **"301 North Fern Creek Avenue, D, Orlando, FL 32803"**
- email: **jeremy@mcdonald-mtg.com**
- teamEmail: **jeremy.mcdonald@loanfactory.com**
- tagline: **"Brokers Win. Banks Sell."**
- slogan: **"$0 lender fees. $1,000 Best Price Guarantee on eligible loans."**

### Verified Site Links (`constants.ts:36`)
- personalSiteUrl: `https://www.mcdonald-mtg.com`
- teamSiteUrl: `https://www.legendsmortgage.team`
- applyNowUrl: `https://www.loanfactory.com/jeremymcdonald`
- youtubeUrl: `https://www.youtube.com/@jeremymcdonaldmortgage`

### Verified Social Links (`constants.ts:44`)
- whatsapp: `https://wa.me/19044423213`
- instagram: `https://www.instagram.com/notyouraveragebroker_jm/`
- linkedIn: `https://www.linkedin.com/in/jeremymcdonald`
- facebook personal + business + Google Business Profile

### Verified Loan Programs Featured (`constants.ts:65` LOAN_OPTIONS)
Conventional, FHA, VA, USDA, Jumbo, Refinance, DSCR, Fix & Flip, Ground-Up Investor Construction, FHA 203k Renovation, HomeReady, Home Possible, ITIN, Bank Statement, HELOCs (Primary Residence + Investment Property).

### Verified Hero Copy (`pages/HomePage.tsx:52`)
- Headline: **"The Legends Mortgage Team"**
- Subheadline: **"Led by Jeremy McDonald, Team Leader and Loan Officer"**
- Support line: **"Powered by Loan Factory"**
- Broker line: **"I'm a broker, not a bank. I shop multiple lenders so you get better pricing and lower fees."**

### Verified Highlights (`pages/HomePage.tsx:27`)
- 20+ years in mortgage lending
- **1,600+ families helped**
- Broker level pricing across dozens of lenders
- Local Jacksonville mortgage expert
- Team Leader of The Legends Mortgage Team

### Verified Broker Positioning (`constants.ts:148` FEATURES)
- **"Broker advantage over banks"** — *"I shop 90-230+ wholesale lenders instead of one bank menu."*
- **"$0 lender fees"** — *"I charge $0 lender fees. Most banks stack $2,500+ in lender costs."*
- **"$1,000 Best Price Guarantee"** — *"Loan Factory offers this on eligible Conventional, FHA, and VA loans of $200,000+ with qualifying same-day locked comparisons."*
- "20+ years in finance"
- "Direct loan officer access"
- "Education over sales"

### Verified Schema/JSON-LD (HomePage `pages/HomePage.tsx:75`)
- Mortgage Broker, NMLS 1195266
- areaServed: Jacksonville Florida
- telephone: 904-442-3213
- LocalBusiness: The Legends Mortgage Team, "powered by Loan Factory helps Jacksonville Florida buyers compare FHA, VA, Conventional, DSCR, and investor mortgage options"

### Verified AI Realtor Pro Positioning (`pages/AgentsPage.tsx:54`)
- Heading: **"AI Realtor Pro support"**
- Body: **"Agent partners can access AI Realtor Pro training, CRM workflows, and AI tools designed for real production support."**
- Listed support areas:
  - Lead follow up
  - Listing presentation support
  - Social content and scripts
  - Open house workflows
  - Buyer nurture sequences

### Verified Agents Page Value Props (`pages/AgentsPage.tsx:24`)
- H1: **"Work With The Legends Mortgage Team"**
- Pitch: **"I am a broker, not a bank. I shop multiple lenders so your clients get better pricing, fewer surprises, and smoother closings."**
- Bullets: Wholesale broker advantage / Fast, clean preapprovals / Payment engineering support / Florida tax and insurance awareness / Direct access to Jeremy

### Verified Investor Hub Copy (`pages/InvestorHubPage.tsx`)
- H1 EN: **"Investor-Focused Mortgage Solutions"** / ES: "Soluciones hipotecarias para inversionistas"
- Tag EN: **"Clear structure. Real numbers. No guessing."**
- Investor paths: Buy and Hold (DSCR, Bank Statement) + (other paths render in deeper sections)
- Spanish translations present throughout (i18n active)

### Verified Blog Topics (29 files in `content/blog/en/`)
Headlines (verbatim):
- "3 Best Jacksonville Neighborhoods for First-Time Buyers in 2026"
- "3 Duval County Neighborhoods for First-Time Buyers in 2026"
- "3 More Jacksonville Neighborhoods First-Time Buyers Need to Watch in 2026"
- "Best Mortgage Loan Options in Florida"
- "Best Places to Buy a Home in Florida in 2026"
- "Why the Builder's Lender Isn't Always Your Friend"
- "Can You Buy a House in Florida with Student Loan Debt"
- "How Much Down Payment Do You Need to Buy a Home in Florida"
- "FHA vs Conventional Loans in Florida"
- "First Time Home Buyer Mortgage Guide | Jacksonville & Northeast Florida"
- "First Time Homebuyer Programs in Florida for 2026"
- "Florida First Time Homebuyer Guide"
- "Florida Housing Market and Mortgage Rate Guide 2026"
- "How Much House Can I Afford in Florida in 2026"
- "The Invisible Debt That Kills Your Pre Approval"
- "Military PCS: The Best Spots Near NAS Jax, Mayport, and Camp Blanding (2026)"
- "Minimum Credit Score to Buy a House in Florida"
- "Mortgage Broker vs Bank in Florida"
- "Mortgage Rates Forecast for Florida in 2026"
- "Negotiating in a Rebalancing Market"
- "Northeast Florida Lifestyle & Neighborhood Navigation Guide (2026)"
- "Northeast Florida Real Estate Market Outlook 2025–2026: What Buyers and Investors Need to Know"
- "Should You Buy a Home in 2026 or Wait"
- "What the Latest Jobs Report and Global Tensions Could Mean for Northeast Florida Homebuyers in 2026"
- "The Top 5 Neighborhoods in Jacksonville, FL to Buy a Home in 2026 (From a Local Mortgage Pro Who Actually Lives Here)"
- "The Truth About Refinancing in 2026"
- "USDA Eligible: The Best 100% Financing Spots Near Jax (2026)"
- "What You Need to Qualify for a Mortgage in Florida"
- "Why St. Augustine & St. Johns County Are the Hottest Real Estate Markets in Northeast Florida Right Now (2026)"

### Verified `first-time-buyer-structure-guide.md` Key Talking Points
- Author: Jeremy McDonald · Date: 2026-02-16 · 12 min read
- Core principle: **"rate is one line item. Structure is the whole deal."**
- Strong structure includes: payment target, down payment plan, right program for credit/timeline, reserves, pre-approval and offer strategy
- Two-number framework: Target payment vs Hard ceiling
- PITIA plus community costs framing

### Verified `public/llms.txt`
Preferred citation:
- Jeremy McDonald, Mortgage Broker, The Legends Mortgage Team, Jacksonville Florida, NMLS 1195266

### Not Verified
- Specific deal save scenarios approved for public use (no on-site case studies file)
- Spanish website fully translated for all blog posts (i18n keys exist; per-post Spanish blog file inventory was not fully exhausted)
- Any RESPA-specific disclosure language stored as a constant (not present in `constants.ts`)

---

## Legends Team Website — Source: `Legends-Team-Website-main/`

### Files Read Successfully
- Top-level directory listing
- `constants.ts` (LOAN_OPTIONS, COMPANY_INFO, NAV_ITEMS, LOAN_PROGRAM_VIDEOS)
- `pages/TeamPage.tsx`
- `components/Team.tsx`
- `src/data/authority.ts` (grep'd for member records and bilingual references)
- Pages list (21 pages — see below)

### Files Not Found
- No standalone Spanish/bilingual statement page (bilingual support lives in team member records inside `src/data/authority.ts`)
- No `compliance.tsx` or `disclosures.tsx` — compliance footer is referenced in agents/sales contexts but no dedicated page found in this scan
- No "broker vs bank" standalone page (positioned across hero, About, Agents/Loan Options pages)

### Verified Team Name and Branding (`constants.ts:6`)
- name: **"Legends Mortgage Team"**
- poweredBy: **"Loan Factory"**
- leader: **"Jeremy McDonald"**
- phone: **(904) 506-0181**
- location: **"Jacksonville, FL"**
- email: **jeremy@mcdonald-mtg.com**
- teamEmail: **legendsteam@loanfactory.com**
- tagline: **"Realize Your Dream of Home Ownership"**
- slogan: **"We Dare You To Compare"**

### Verified NMLS Numbers — Team Roster (`src/data/authority.ts`)
| Team Member | Role | NMLS |
|---|---|---|
| Jeremy McDonald | Team Leader, Loan Officer | 1195266 |
| Ashley Rogers | Operations Manager and Lead Processor | 1938675 |
| Hugo Calvillo | Loan Officer | 1808485 |
| Bryan Payne | Loan Officer | 2360741 |
| Eric Jason Ritchie | Loan Officer | 2702310 |
| Raleigh Morrison | Loan Officer | 2511940 |
| Scott Mason | Loan Officer | 2576892 |
| Barbara Jordan | Loan Officer | 2475165 |
| Vivian Delgado | Loan Officer | 1910685 |
| Alison McLeod | Loan Officer | 2680230 |
| Katherine Bernal | Loan Officer | 2696379 |
| Jesus Urquiza | Loan Officer | 2717748 |
| Christina Bús | Branch Manager, Loan Officer | 118777 |
| Irene Holden | Loan Officer | 2084953 |
| Mark Sileck | Loan Officer | (no nmls field at line 1209) |
| Camilia Da La Luz | AI Marketing Manager and Operations Lead | (support role, no nmls expected) |

Company NMLS (from sister site `final-jeremy-mcdonald-mtg.com-main/constants.ts`): **320841**.

### Verified Loan Programs (`constants.ts:37`)
Same set as Jeremy site: Conventional, FHA, VA, USDA, Jumbo, Refinance, DSCR, Fix & Flip, Ground-Up Investor Construction, FHA 203k, HomeReady, Home Possible, ITIN, Bank Statement, HELOCs (Primary + Investment).

### Verified Geographic Service Area
- Primary location: **Jacksonville, FL**
- Schema/coverage: Loan officer mini-sites with state-level guides (TeamPage references `getFeaturedStateGuides()` from `src/data/authority.ts`)
- Multi-state via "State Mortgage Guides" — explicit state list not enumerated in this scan, but the architecture confirms multi-state licensing rather than Jacksonville-only

### Verified Bilingual Support (DIRECTLY confirmed in `src/data/authority.ts`)
- Hugo Calvillo: "serves Florida buyers and investors with bilingual mortgage guidance" · specialty: "Bilingual service"
- Vivian Delgado: "bilingual Florida loan officer with more than 10 years of experience" · "South Florida background" · specialty: "Bilingual service"
- Katherine Bernal: "bilingual Florida loan officer with deep mortgage and real estate experience" · specialty: "Bilingual service"
- Camilia Da La Luz: "AI Marketing Manager and Operations Lead, bringing bilingual communication" · "Bilingual in English and Spanish, Camilia plays a key role in supporting Hispanic homebuyers"
- FAQ generator emits: "Yes. Spanish-speaking families can work with bilingual support that keeps the process clear, informed, and easy to follow from start to finish." (line 1364)

### Verified Broker Positioning
- The TeamPage organization schema describes Legends Mortgage Team as: **"Mortgage guidance, loan officer mini-sites, and multi-state educational content powered by Loan Factory."**
- Investor Hub copy (sister site): **"Clear structure. Real numbers. No guessing."** Bilingual rendered.

### Verified Pages on Legends Team Site (`pages/`)
AboutJeremyPage, AboutPage, ApplyPage, BlogIndexPage, BlogPostPage, CalculatorPage, ContactPage, DigitalBusinessCardTemplatePage, HomePage, InvestorHubPage, JoinTeamPage, LoanOptionsPage, ReviewsPage, StateMortgageGuidePage, TeamMemberBlogIndexPage, TeamMemberBlogPostPage, TeamMemberCardPage, TeamPage, VlogIndexPage, VlogPostPage, YouTubePage, plus `loan-programs/` subfolder.

### Not Verified
- Specific list of licensed states for the team (the data exists in `authority.ts` member-by-member but was not fully exhausted in this pass)
- Any explicit RESPA disclosure copy block
- Any approved investor "deal save" scenarios in the website source (not in the inspected files)

---

## Cross-Repo Consistency Findings

### Consistent Facts (Green-light to use)
- Jeremy McDonald · NMLS **1195266** · Company NMLS **320841**
- The Legends Mortgage Team · powered by Loan Factory
- Mobile: **(904) 442-3213** · Direct: (904) 506-0181 · Corporate: (407) 500-6000
- Email: **jeremy@mcdonald-mtg.com**
- Apply: **https://www.loanfactory.com/jeremymcdonald**
- Personal site: **mcdonald-mtg.com** · Team site: **legendsmortgage.team**
- Jacksonville Florida base; multi-state coverage via team
- $0 lender fees · $1,000 Best Price Guarantee on eligible Conventional/FHA/VA loans $200K+ (note: $1,000 not $2,000)
- "I shop 90-230+ wholesale lenders instead of one bank menu"
- "I'm a broker, not a bank"
- 20+ years in finance · 1,600+ families helped
- Bilingual English/Spanish supported via specific team members
- AI Realtor Pro is **invite only** and **only for agents working with Jeremy/Legends**

### Conflicts to Flag
- **NMLS mismatch:** AIRP `get-preapproved/page.tsx:18` shows NMLS# 2121161 vs 1195266 everywhere else. **Do not cite NMLS in newsletter copy until Jeremy resolves.**
- **Phone variance:** AIRP `about/page.tsx:128` uses `(904) 424-2025` (likely a typo; 442 vs 424). **Default to (904) 442-3213** until confirmed.
- **FHBN mortgage Pro record:** Uses placeholder phone/email/website strings — do not cite as fact in newsletters.
