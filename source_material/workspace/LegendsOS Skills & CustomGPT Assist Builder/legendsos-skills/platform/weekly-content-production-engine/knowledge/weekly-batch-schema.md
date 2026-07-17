# Weekly Batch Schema

## Per-week record

```yaml
week:
  number: 1
  date_range: 2026-05-25 to 2026-05-31
  lock_status: locked
  pillar_distribution:
    Mortgage Stories: 2
    Broker Advantage: 2
    First Time Buyer: 2
    VA: 1
    Investor Strategy: 2
    Realtor AI Education: 2
    Local Authority: 2
    Personal Brand: 2
    Leadership: 2
    Closing Day: 1
  story_slots:
    - day: 3
      framework: The File Save
      source_id: BORROWER_MEMORY_007
    - day: 5
      framework: The Closing Day Lesson
      source_id: BORROWER_MEMORY_011
  local_angles:
    - day: 2
      surface: GBP
      city: St. Johns County
    - day: 6
      surface: GBP
      city: Jacksonville Beach
  long_form:
    - day: 2 (Tue)
      topic: Buying Your First Home in St. Johns County
    - day: 4 (Thu)
      topic: DSCR Loans for Florida Investors
  weekly_recap_day: 7 (Sun)
  asset_counts:
    canva_assets: 38
    heygen_videos: 7
    higgsfield_assets: 5
    heropost_rows: 48
  approval_required:
    - Red-tier slots: none this week
  blockers: []
```

## Lock status values

`draft`, `proposed`, `locked`, `in_production`, `shipping`, `completed`.

## Lock transitions

- `draft` → `proposed` when the Engine has filled the slots.
- `proposed` → `locked` when Jeremy confirms.
- `locked` → `in_production` when dispatch runs.
- `in_production` → `shipping` when HeroPost final CSV is generated.
- `shipping` → `completed` when the week is fully posted.

## Pillar distribution rules

- Minimum 1 story slot per week.
- Minimum 1 closing-day slot per week (if a real closing is available).
- Minimum 1 local-authority slot per week.
- Maximum 30 percent of week on any single pillar.

## Story slot rules

- Source ID required before dispatch.
- If source not available, slot swaps to an educational pillar with a documented gap.

## Long form rules

- 2 per week default, Tuesday and Thursday.
- Topic must derive from a pillar in the week.

## Asset count discipline

- Asset count balanced against the operator's weekly capacity.
- Engine flags any week where asset count exceeds 1.5x the prior weeks' actuals.
