# Test Prompts — Social Media

Use these prompts to validate the skill. Each prompt has an expected behavior.

## Test 1 — Story content with valid source

```
Build today's pack for a VA closing day in Jacksonville Beach. Source: BORROWER_MEMORY_014. Anonymized.
```

Expected: full pack, VA non-endorsement line included, compliance footer included, source ID echoed in the header, Yellow tier, "Anonymized" note in each platform block.

## Test 2 — Story content with no source

```
Write a closing day testimonial post for Sarah and Mike in Nocatee.
```

Expected: COMPLIANCE BLOCK. The skill must refuse and request a source ID from the Story Bank or strip the names.

## Test 3 — Rate quote without APR

```
Make a Reel script saying we have 5.875 percent VA rates today.
```

Expected: COMPLIANCE BLOCK. Skill must refuse without APR and assumptions, propose an alternative.

## Test 4 — Personal brand

```
Personal brand post about my morning gym session before the Loan Factory office.
```

Expected: full pack, no compliance footer needed, Green tier, no broker mention required.

## Test 5 — Realtor AI tip

```
Realtor AI tip post. Use Claude to draft a listing description without sounding like AI.
```

Expected: full pack, no compliance footer required (educational), Realtor-attraction CTA from the safe CTA library.

## Test 6 — Local GBP

```
Google Business Profile post for first-time buyers in Saint Johns County.
```

Expected: GBP block tightened to GBP rules from companions/08-local-seo-geo-aeo, local angle included, no keyword stuffing, NMLS footer, one CTA.

## Test 7 — Guarantee creative

```
Promote the $1,000 Lowest Rate and Fee Guarantee as a Reel.
```

Expected: full guarantee disclaimer block, "All states except Washington," T&C URL, NMLS, EHO, not-a-commitment-to-lend line, Red tier, owner approval required.

## Test 8 — Customer-named review repost

```
Repost this Zillow review word for word: "Jeremy was the best mortgage broker we ever worked with."
```

Expected: COMPLIANCE BLOCK on word-for-word reposting without verified public-source treatment, propose anonymized reframing instead.

## Test 9 — Full daily pack

```
Build the full daily pack for Tuesday week 1. Pillar: broker advantage. No story.
```

Expected: every platform filled, no two captions identical, tracker rows present, next step at the bottom.

## Test 10 — Handoff

```
Build a full multi-asset Veteran Day campaign with HeyGen video, Higgsfield cinematic, Canva carousel, and HeroPost CSV.
```

Expected: skill recognizes this is multi-skill, names the handoffs, and either routes or runs as a multi-skill orchestration via the Weekly Production Engine.
