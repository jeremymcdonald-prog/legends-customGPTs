# HeroPost CSV Rules (per-post view)

The HeroPost scheduler skill owns the schema and validation. This file documents what the Social Media skill must produce per row so that the HeroPost skill can validate cleanly.

## Schema (exact, do not edit)

```
Caption,Media,Title,Date,Link,Thumbnail,Type,Comment
```

## Per-column rules from the Social Media skill

| Column | Source | Rule |
|---|---|---|
| Caption | Social Media skill output for that platform | Plain text. No quotes inside the cell unless escaped. No em dashes. Newlines escaped per HeroPost CSV (use `\n` if HeroPost requires; default to literal line breaks inside double quotes). |
| Media | `{hosted_media_url}` | Must resolve to a public hosted URL by HeroPost final. In staging, this field is `STAGING_PENDING_MEDIA`. |
| Title | Platform-specific title (YouTube long/short, blog) | YouTube: 50 to 70 chars. Blog: H1 mirror. Other platforms: leave empty unless required. |
| Date | YYYY-MM-DD HH:MM in HeroPost expected format | Always include the time. Time defaults from `usage-notes.md`. |
| Link | Website page, blog, or landing | Optional. When used, it's the website page that pays off the post. |
| Thumbnail | `{thumbnail_id}` resolved to public hosted URL | Required for YouTube. Optional for Reels/TikTok if cover image is set in-platform. |
| Type | One of: `Facebook Personal`, `Facebook Business`, `Instagram Feed`, `Instagram Reel`, `Instagram Story`, `TikTok`, `YouTube Short`, `YouTube Long Form`, `LinkedIn`, `Google Business Profile` | Exact string match. The HeroPost mapping layer translates these to HeroPost's own platform identifiers. |
| Comment | First comment text (pinned comment, optional) | Used for IG and YouTube comment posting. Optional. |

## Staging vs final

- **Staging row.** All columns filled except `Media` and `Thumbnail` (set to `STAGING_PENDING_MEDIA` / `STAGING_PENDING_THUMBNAIL`). Goes into `heropost_staging_60_day.csv`.
- **Final row.** Same row with `Media` and `Thumbnail` set to real hosted URLs. Goes into `heropost_week_N_ready.csv` only after media URL tracker confirms.

## Hard rules

- The Social Media skill never marks a row as Final.
- The Social Media skill never invents a hosted URL.
- The Social Media skill never edits the schema header.
- The Social Media skill writes one row per platform per post.
- If a row would violate the compliance gate, the skill writes the row with `BLOCKED` in the `Comment` column and a one-line reason, and emits the row to staging only for visibility, not to final.
