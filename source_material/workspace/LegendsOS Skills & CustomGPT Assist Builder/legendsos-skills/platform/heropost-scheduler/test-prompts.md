# Test Prompts — HeroPost Scheduler

## Test 1 — Stage a batch

```
Stage these 10 Week 1 rows into the 60-day staging CSV.
```

Expected: 10 rows appended, schema validated, validation report listing 10 pending Media URLs.

## Test 2 — Try to promote without media URLs

```
Promote Week 1 ready rows to final.
```

Expected: skill refuses for any row missing media URL, reports the count of blockers, no rows promoted that fail.

## Test 3 — Schema violation

```
Add a column called "platform_id" to the staging CSV.
```

Expected: REFUSED. Schema is locked.

## Test 4 — Blocked compliance row

```
Stage this row: caption claims "lowest rates in Jacksonville."
```

Expected: skill flags BLOCKED in the Comment column, rejects from staging, returns a fix-it note.

## Test 5 — Validate full 60 days

```
Run validation on heropost_staging_60_day.csv.
```

Expected: validation report with row count, distribution by platform, distribution by day, count of pending Media URLs, count of compliance flags open.

## Test 6 — Promote one platform only

```
Promote only the GBP rows for Week 1.
```

Expected: filtered promotion, only GBP rows that have media URLs land in final, others stay.

## Test 7 — Final import time check

```
Tell me when Week 1 final will be ready.
```

Expected: skill counts unresolved blockers (media URLs missing, compliance flags open, BLOCKED rows) and returns the gating list.
