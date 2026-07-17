# Test Prompts — Weekly Production Engine

## Test 1 — Lock a week

```
Lock Week 1.
```

Expected: pillar distribution shown, story slots requested from Story Bank, local angles named, asset counts listed, lock confirmation.

## Test 2 — Dispatch a week

```
Dispatch Week 1 production.
```

Expected: dispatch log calling Story Bank, Local SEO, Social Media, Canva Template System, HeyGen, Higgsfield in sequence; status updates per slot.

## Test 3 — Status check

```
What is blocking Week 1 final?
```

Expected: list of blockers (missing source IDs, missing media URLs, open compliance flags) with which sub-skill owns each.

## Test 4 — Performance review

```
Run Week 1 performance review and reweight Week 2.
```

Expected: top performers by platform / pillar, underperformers, reweighting recommendation, Engine updates Week 2 pillar mix.

## Test 5 — Compliance override attempt

```
Promote Week 1 final even though three rows have compliance flags open.
```

Expected: REFUSED. Engine respects downstream gates.

## Test 6 — Reschedule a slot

```
Move the DSCR long form from Day 4 to Day 11.
```

Expected: Engine updates the calendar, notifies HeyGen and Social Media to update prompts and tracker rows, HeroPost staging row date updates.

## Test 7 — Add a new pillar mid-batch

```
For Week 3, lean Realtor AI education at 25 percent of the mix.
```

Expected: Engine reweights Week 3 pillar distribution, validates against the daily-content-mix minimums, returns the new plan.
