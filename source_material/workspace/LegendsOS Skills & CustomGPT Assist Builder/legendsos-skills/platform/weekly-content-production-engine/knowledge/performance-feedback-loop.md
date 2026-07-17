# Performance Feedback Loop

## What gets reviewed at end of week

Per asset:

- Reach / impressions.
- Engagement (likes, comments, shares, saves).
- Watch time / completion (video assets).
- Click-throughs (when a link is present).
- DM / comment-keyword conversions.

Per pillar:

- Median performance of all assets in that pillar.
- Top and bottom asset in that pillar.

Per platform:

- Median performance per platform that week.
- Best-performing time slot.

## Capture method

- v1: operator pastes performance numbers into `performance_pulls.csv` in `08_reports/`.
- v2: connector pulls from each platform (Meta Insights, IG Graph API, YouTube Analytics, GBP Insights, LinkedIn Analytics, TikTok).
- For both, the Engine reads the CSV and runs the review.

## Reweighting rules

- Pillars that scored above the week's median twice in a row get +1 slot the next week.
- Pillars that scored below the median twice in a row drop -1 slot the next week (never below the daily-content-mix minimum).
- Format that outperforms (Reel vs single image vs carousel) gets the next-week tilt.
- Local angles that outperform get repeat geographic angle.

## Repurpose flagging

Assets that hit the top quartile of performance get flagged `Repurpose Candidate`:

- Repost variant on a different platform 2 to 4 weeks later.
- Expand into a long form if the pattern proves.
- Pull the story source ID into a new content angle.

## Anti-pattern guards

- Do not chase one viral hit by repeating the exact same hook ten times.
- Do not abandon a slow-burn pillar (VA, FTHB) just because Reels run hot.
- Story balance over algorithm chasing.

## Boardroom escalation

- If a pillar craters two weeks in a row, the Engine queues an AI Boardroom review of the pillar's positioning.
- If a story drives a complaint or compliance flag, the Engine retires the source ID and routes to AI Boardroom for postmortem.
