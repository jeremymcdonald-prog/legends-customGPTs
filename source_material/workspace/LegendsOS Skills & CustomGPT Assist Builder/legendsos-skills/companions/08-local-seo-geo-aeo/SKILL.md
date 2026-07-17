---
name: legendsos-local-seo-geo-aeo
description: Local SEO, GEO, and AEO skill for The Legends Mortgage Team. Optimizes Google Business Profile posts, website blog and vlog topics, and AI-answer-engine surfaces for Jacksonville, Duval, St. Johns, Clay, Nassau and surrounding Northeast Florida markets. Handles GBP posts, blog SEO, AEO answer blocks, review-informed local content, and blog-to-social repurposing maps. Hands off to Story Bank for review-sourced content and to Social Media for cross-platform pushes.
---

# LegendsOS Local SEO, GEO, AEO and Google Business Profile

## What this does

Owns the local search and answer-engine surface for The Legends Mortgage Team. Produces GBP posts, blog topic plans, vlog topic plans, schema markup recommendations, AEO Q-and-A blocks, internal linking plans, and review-informed local content. Maintains the local keyword and city/county map. Keeps every output natural, never keyword-stuffed.

## Core rule

Relevance + Distance + Prominence is the GBP formula. Helpful + Cited + Crawlable is the AEO formula. Every local piece serves a real human reader first and an AI answer engine second. No keyword stuffing, no fake reviews, no fabricated local stats.

## Steps

1. Read the request. Confirm market (default Jacksonville / Northeast Florida).
2. Pull the keyword cluster from `knowledge/local-market-keywords.md` that fits.
3. If story-backed, pull the source ID from `companions/07-story-bank`.
4. Build the output (GBP post, blog topic, vlog topic, AEO answer block, schema recommendation, internal links).
5. Run the compliance gate.
6. Pair with the Social Media skill for derivative posts (the Local SEO skill owns the canonical local piece; Social Media derives platform-native versions).
7. Emit the production tracker row.
8. End with the next step.

## Output (always this shape)

1. **Header** — keyword cluster, target market, story source if any, asset surface (GBP / blog / vlog / AEO block).
2. **Canonical local piece** — the GBP post, blog draft outline, vlog plan, or AEO block depending on the request.
3. **Schema recommendation** — JSON-LD type appropriate to the piece (Article, FAQPage, LocalBusiness, VideoObject).
4. **Internal link plan** — 2 to 4 target pages on mcdonald-mtg.com that this piece should link to.
5. **Social derivative routing** — handoff note to `companions/06-social-media` for platform versions.
6. **Compliance footer** when mortgage-related.
7. **Production tracker row.**
8. **Next step.**

## Compliance (hard gate)

Reference `_shared/brand-dna/compliance-pack.md`. Skill-specific:

- No invented local stats ("Jacksonville home prices rose 4.7%..." without a cited source).
- No invented neighborhood claims.
- NAP (name, address, phone) must match the canonical record in `_shared/knowledge/service-area-nap.md`.
- GBP posts include one local angle, one CTA, NMLS + EHO mark in the body.
- No "lowest rate in Jacksonville" framing. Ever.
- Reviews referenced in local content come from the Story Bank with source URLs.
- Multi-state guarantee creative carries "All states except Washington."

## Voice

Reference `_shared/brand-dna/voice.md`. Plain spoken broker voice. Local without sounding like a chamber of commerce brochure. No fake folksy.

## Handoff

- Source-backed story → `companions/07-story-bank` first.
- Platform-native versions → `companions/06-social-media`.
- Visual asset for the GBP post → `companions/10-canva-template-system`.
- Video version → `companions/11-heygen-video-system` (avatar) or `platform/visual-intelligence` (single thumb).
- Schema deployment → handoff note to website CMS owner.

End every output with the next step.
