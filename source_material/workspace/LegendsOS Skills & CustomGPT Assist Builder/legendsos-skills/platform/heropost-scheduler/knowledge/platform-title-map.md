# Platform Title Map

## Canonical Type strings (what goes into the CSV `Type` column)

```
Facebook Personal
Facebook Business
Instagram Feed
Instagram Reel
Instagram Story
TikTok
YouTube Short
YouTube Long Form
LinkedIn
Google Business Profile
```

## Platform aliases the skill normalizes to canonical

| Operator might type | Skill normalizes to |
|---|---|
| FB | Facebook Personal (asks for clarification if ambiguous) |
| FB Page | Facebook Business |
| IG | Instagram Feed (asks if Reel/Story instead) |
| Reel | Instagram Reel |
| Story | Instagram Story |
| Short | YouTube Short |
| YT Long | YouTube Long Form |
| LI | LinkedIn |
| GBP | Google Business Profile |
| GMB | Google Business Profile |

## HeroPost internal identifiers (when known)

Operator confirms the exact HeroPost dropdown names in the account. The skill stores the mapping here for reference. When the mapping is unknown, the operator translates on import.

## Tracker codes (internal, not in CSV)

These appear in the production tracker, not in HeroPost CSVs:

```
FB_PERSONAL
FB_BUSINESS
IG_FEED
IG_REEL
IG_STORY
TIKTOK
YT_SHORT
YT_LONG
LINKEDIN
GBP
BLOG
VLOG
```

## When a new platform is added

- Add to canonical list above.
- Add to the daily content mix in `companions/06-social-media/knowledge/daily-content-mix.md`.
- Add to the per-platform rules in `companions/06-social-media/knowledge/platform-output-rules.md`.
- Add to scheduling defaults in `scheduling-rules.md`.
