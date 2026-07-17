# Scheduling Rules

## Time zone

All Date cells in Eastern Time (Northeast Florida). Convert if HeroPost expects UTC at import; the operator handles that conversion on import.

## Default daily slots (Eastern)

| Platform | Default time |
|---|---|
| Facebook Personal | 07:30 |
| Facebook Business | 08:30 |
| LinkedIn AM | 07:00 |
| LinkedIn PM | 12:30 |
| Instagram Story AM | 09:00 |
| Google Business Profile | 10:00 |
| Instagram Feed | 11:00 |
| YouTube Long Form | 16:00 (Tue, Thu) |
| YouTube Short | 17:00 |
| Instagram Reel | 18:00 |
| TikTok | 18:30 |
| Instagram Story PM | 19:30 |

## Stagger rule

- Never schedule two rows on the same platform within 90 minutes of each other.
- Never schedule the same caption text on two platforms within the same hour.
- Spread weekend posts (lighter cadence).

## Holiday and event handling

- Memorial Day, Veterans Day, Independence Day: shift VA-pillar posts to those days.
- Local Jacksonville civic events: lift Local SEO pillar that day.
- Sundays: lighter cadence (1 to 3 posts), leadership lean.

## Cancellations and reschedules

- If a row needs to slip, the Scheduler updates the staging Date and unpromotes from final if already there.
- Cancellations write `BLOCKED: cancelled_by_operator` and leave the row in staging.

## Time-sensitive types

- Market update: schedule within 24 hours of the rate event.
- Closing day: schedule same-day if possible.
- Story-from-a-call: 24 to 48 hours after the call.
