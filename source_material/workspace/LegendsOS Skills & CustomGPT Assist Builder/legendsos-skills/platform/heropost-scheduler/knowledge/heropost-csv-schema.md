# HeroPost CSV Schema

## Header (locked, exact)

```
Caption,Media,Title,Date,Link,Thumbnail,Type,Comment
```

No additions. No reorderings. No renamings.

## Column rules

### Caption

- Plain text, escaped for CSV.
- Newlines inside cells wrapped in double quotes.
- Em dashes not allowed.
- Compliance footer included when mortgage-related.

### Media

- Public hosted URL after final.
- `STAGING_PENDING_MEDIA` placeholder in staging.
- Validated as URL pattern (https://...) when not placeholder.

### Title

- YouTube Long: 50 to 70 characters.
- YouTube Short: 40 to 70 characters.
- Blog: H1 mirror.
- Other platforms: optional, may be empty.

### Date

- Format `YYYY-MM-DD HH:MM` (24h) in operator timezone (Eastern Time default for Northeast Florida).
- Required for every row.

### Link

- Optional. Used when a post points to a website page.
- Validated as URL pattern when present.

### Thumbnail

- Public hosted URL after final.
- Required for YouTube (Short and Long).
- Optional for Reels and TikTok (cover may be set in-platform).
- `STAGING_PENDING_THUMBNAIL` placeholder in staging.

### Type

Exact string match. One of:

- `Facebook Personal`
- `Facebook Business`
- `Instagram Feed`
- `Instagram Reel`
- `Instagram Story`
- `TikTok`
- `YouTube Short`
- `YouTube Long Form`
- `LinkedIn`
- `Google Business Profile`

A platform-title-map.md translates these to HeroPost's internal identifiers when an automation layer exists.

### Comment

- Optional first comment (pinned).
- Used for IG and YouTube.
- May contain compliance disclaimers or program-specific lines.
- Used in staging to carry `BLOCKED: reason` text when a row fails compliance.

## Cell escaping

- Wrap any cell containing a comma in double quotes.
- Wrap any cell containing a newline in double quotes.
- Double any double quotes inside cells.

## Encoding

- UTF-8.
- No BOM.
- LF line endings.

## File naming

- 60-day staging: `heropost_staging_60_day.csv`
- Weekly final: `heropost_week_{N}_ready.csv` (N is the week number 1 through 9)
