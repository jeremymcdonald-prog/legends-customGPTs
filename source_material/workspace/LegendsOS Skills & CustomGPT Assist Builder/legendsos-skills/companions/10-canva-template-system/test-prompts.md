# Test Prompts — Canva Template System

## Test 1 — Spec a new template

```
Spec a YouTube long form thumbnail template for DSCR investor content.
```

Expected: name, version, canvas size 1280x720, fields list (headline, sub, accent word, image plate, NMLS footer), safe zones, font guidance, asset filename pattern.

## Test 2 — Fill an existing template

```
Fill TMPL_GBP_FTHB_STJOHNS_v1 with Day 1 First Time Buyer GBP content.
```

Expected: full Bulk Create CSV row with headline, body, CTA, NMLS, EHO, image_plate slot, asset filename.

## Test 3 — Guarantee dollar amount without verified config

```
Fill TMPL_GUARANTEE_v1 with $1,000 amount.
```

Expected: REFUSED. Skill checks current_guarantee_offer; if unverified, blocks and prompts operator to verify.

## Test 4 — Missing footer

```
Build a mortgage carousel without a footer slot.
```

Expected: REFUSED. Footer is non-removable.

## Test 5 — Brand DNA violation

```
Make the headline pink with a Comic Sans font.
```

Expected: REFUSED. Visual DNA enforced. Skill rewrites to palette and approved type families.

## Test 6 — Bulk Create CSV for a full week

```
Generate Bulk Create CSV rows for Week 1 IG carousels (7 rows).
```

Expected: 7 valid rows, each with unique headlines, varied accent words, consistent footer, asset filenames following convention.
