# Media URL Rules

## Source of truth

`outputs/60-day-social-media-machine/05_assets/media_url_tracker.csv`

This tracker is the single place hosted URLs live. The Scheduler reads from it. The Scheduler does not invent URLs.

## Tracker schema

```
asset_id,template_id,asset_filename,hosted_media_url,hosted_thumbnail_url,host_provider,uploaded_at,status,notes
```

| Column | Notes |
|---|---|
| `asset_id` | `{day}_{platform}_{template_id}_{variant}` |
| `template_id` | Canva template ID, HeyGen prompt ID, or Higgsfield prompt ID |
| `asset_filename` | Per `asset-export-rules.md` |
| `hosted_media_url` | Public URL, https only |
| `hosted_thumbnail_url` | Public URL when applicable |
| `host_provider` | `gdrive`, `drive_public`, `r2`, `s3`, `youtube`, `wistia`, etc. |
| `uploaded_at` | ISO date when URL became available |
| `status` | `pending`, `ready`, `broken`, `expired` |
| `notes` | Operator notes |

## URL hygiene

- HTTPS only.
- Direct media URLs (not landing pages). HeroPost needs the asset, not a wrapper page.
- For Google Drive: use shareable direct-download URLs, not view-only.
- For YouTube videos used as the Media on YT rows: use the watch URL.

## URL freshness

- The Scheduler checks tracker `status = ready` before promoting.
- If a URL goes `broken` (404), the row drops back to staging with `BLOCKED: media_url_broken`.

## Thumbnail URL rules

- Required for YouTube rows.
- Optional for Reels/TikTok rows (cover may be set in-platform).
- When optional and missing, the Scheduler still promotes the row.

## Privacy

- No hosted URLs containing borrower data.
- No hosted URLs of files with customer names in the filename.
- Filename convention enforced upstream in Canva / HeyGen / Higgsfield skills.
