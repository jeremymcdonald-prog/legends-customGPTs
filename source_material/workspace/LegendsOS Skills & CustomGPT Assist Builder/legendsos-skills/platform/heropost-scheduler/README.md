# LegendsOS HeroPost Scheduler

Two-stage HeroPost CSV system. Stage everything. Promote to Final only when media URLs and compliance gates clear.

## Files

- `SKILL.md`, `CUSTOM_GPT.md`, `usage-notes.md`, `test-prompts.md`
- `knowledge/heropost-csv-schema.md`
- `knowledge/bulk-upload-rules.md`
- `knowledge/media-url-rules.md`
- `knowledge/scheduling-rules.md`
- `knowledge/validation-rules.md`
- `knowledge/platform-title-map.md`

## CSV header (locked)

```
Caption,Media,Title,Date,Link,Thumbnail,Type,Comment
```

## Files this skill writes (outputs/60-day-social-media-machine/06_heropost/)

- `heropost_staging_60_day.csv`
- `heropost_week_1_ready_later.csv` (becomes `heropost_week_1_ready.csv` after media URLs land)
- `heropost_validation_report.md`
