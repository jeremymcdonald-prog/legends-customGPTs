# Production Status Map

Every asset goes through these statuses. The Engine tracks transitions in `asset_production_tracker.csv`.

## Status sequence

1. `Planned` — slot exists on the calendar, seed defined.
2. `Scripted` — caption / script written by Social Media or HeyGen skill.
3. `Prompt Ready` — Canva / HeyGen / Higgsfield prompt block emitted.
4. `Canva Template Ready` — Canva template field schema filled, Bulk Create row written.
5. `Image Generated` — Higgsfield asset rendered (when applicable).
6. `Video Generated` — HeyGen video rendered (when applicable).
7. `Thumbnail Generated` — Canva thumbnail produced (when applicable).
8. `Hosted URL Added` — file uploaded to hosting, URL added to media_url_tracker.csv.
9. `HeroPost Ready` — staging row promoted to Week N final CSV.
10. `Scheduled` — final CSV imported into HeroPost, schedule set.
11. `Posted` — the platform actually published.
12. `Performance Reviewed` — engagement captured (manual paste or connector).
13. `Repurpose Candidate` — top performer flagged for repurposing in future weeks.

## Status transition gates

| From | To | Required |
|---|---|---|
| Planned | Scripted | Story source if story; pillar confirmed |
| Scripted | Prompt Ready | Compliance gate cleared on caption/script |
| Prompt Ready | Canva Template Ready | Template ID set, fields populated |
| Canva Template Ready | Image Generated | Higgsfield called when needed |
| Image Generated | Video Generated | HeyGen called when needed |
| Video Generated | Thumbnail Generated | Canva thumbnail filled |
| Thumbnail Generated | Hosted URL Added | Files uploaded, URLs in tracker |
| Hosted URL Added | HeroPost Ready | All compliance flags closed |
| HeroPost Ready | Scheduled | Operator imports final CSV |
| Scheduled | Posted | Platform confirms |
| Posted | Performance Reviewed | 48 hours post-publish, engagement captured |
| Performance Reviewed | Repurpose Candidate | Engagement above week's median |

## Tracker row shape

```
day|platform|pillar|story_source|canva_template_id|heygen_video_id|higgsfield_asset_id|hosted_media_url|hosted_thumbnail_url|status|risk_tier
```

## Reverse transitions

A row can move backward only with an operator note. Examples:

- `Hosted URL Added` → `Image Generated` when a URL goes broken.
- `HeroPost Ready` → `Scripted` when compliance review reopens.
