# Automation Requirements Report: Mortgage Media OS

**Date:** May 2026  
**Author:** Jeremy McDonald  
**Purpose:** Define the automation architecture to make this system run on minimal manual effort  

---

## The Goal

The entire point of the Mortgage Media OS is to create a system that produces consistent, high-quality content without requiring me to personally create every piece from scratch. I want to spend my time on strategy and client relationships, not on repetitive production tasks.

This document defines what needs to be automated, how, and in what order of priority.

---

## Automation Priority Matrix

| Task | Priority | Complexity | Time Savings |
|------|----------|------------|--------------|
| Epic RE channel monitoring | High | Low | 2 hrs/week |
| YouTube transcript fetch | High | Low | 1 hr/video |
| Style analysis on new videos | Medium | Medium | 1 hr/video |
| Script drafting | High | Medium | 3 hrs/video |
| HeyGen submission | High | Low | 30 min/video |
| Social distribution | Medium | Medium | 1 hr/post |
| Rate data refresh | High | Low | 30 min/week |
| GHL lead pipeline | High | High | Ongoing |

---

## Automation 1: Epic RE Channel Monitor (monitor-epic-re.sh)

**Purpose:** Automatically detect when Epic Real Estate posts a new video  
**Trigger:** Scheduled cron job, runs daily at 7 AM ET  
**Process:**
1. Query YouTube Data API v3 for latest videos from channel UC8ZYmCweKD2x-wy8PDEiFog
2. Compare against `analytics/epic-real-estate/video-performance/latest-videos.json` (local cache)
3. If new video detected: log to `analytics/epic-real-estate/video-performance/new-videos.log`
4. Send notification (email or Slack webhook) with video title, URL, and publish date
5. Trigger `fetch-transcript.sh` for the new video automatically

**API Required:** YouTube Data API v3  
**Credentials:** `YOUTUBE_API_KEY` from `.env`  
**Output:** Updated cache file + notification + transcript trigger

**Quota consideration:** YouTube API has 10,000 units/day free. A search request costs 100 units. Running once daily = 100 units. Plenty of headroom.

---

## Automation 2: Transcript Fetch (fetch-transcript.sh)

**Purpose:** Retrieve the auto-generated transcript from any YouTube video  
**Trigger:** Called by monitor-epic-re.sh OR manually with a video URL argument  
**Process:**
1. Accept YouTube URL or video ID as argument
2. Use YouTube Data API captions endpoint OR youtube-transcript-api (Python) to fetch transcript
3. Clean transcript: remove timestamps, merge short segments, normalize punctuation
4. Save to `analytics/epic-real-estate/video-performance/[video-id]-transcript.txt`
5. Log fetch with date, video ID, word count

**Fallback:** If auto-captions unavailable, use yt-dlp to download audio and Whisper API for transcription  
**Output:** Clean text transcript saved locally  
**Notes:** Some videos don't have auto-captions enabled for the first 24-48 hours. Build in retry logic.

---

## Automation 3: Style Analysis (analyze-style.sh)

**Purpose:** Run automated analysis on a new Epic RE transcript to extract hook, structure, and topic patterns  
**Trigger:** Called after successful transcript fetch, OR manually  
**Process:**
1. Load transcript from file
2. Send to Claude API (or OpenAI) with structured analysis prompt:
   - Identify the hook pattern (first 30 seconds)
   - Extract the core topic and sub-topics
   - Identify any data points or statistics cited
   - Note any product mentions or CTAs
   - Rate the estimated production quality and energy level
3. Save JSON analysis output to `analytics/epic-real-estate/hook-analysis/[video-id]-analysis.json`
4. Append summary to `analytics/epic-real-estate/topic-trends/monthly-summary.md`

**API Required:** Anthropic API or OpenAI API  
**Prompt file:** `config/prompts/style-analysis-prompt.txt` (create separately)  
**Output:** Structured JSON + updated trend summary

---

## Automation 4: Content Generation (generate-content.sh)

**Purpose:** Draft a new content piece using knowledge base + template + persona  
**Trigger:** Manual (called with parameters: topic, persona, format)  
**Usage example:**
```bash
./automation/generate-content.sh --topic "va-loans" --persona "inside-man" --format "youtube-script"
```

**Process:**
1. Load topic knowledge file from `/knowledge/mortgage-topics/[topic].md`
2. Load persona config from `config/personas.json`
3. Load format template from `templates/[format]-template.md`
4. Load relevant hook patterns from `knowledge/epic-real-estate/hook-library.md`
5. Send combined context + generation prompt to Claude API
6. Save draft to `outputs/daily/[YYYY-MM-DD]-[topic]-draft.md`
7. Log generation with timestamp, topic, persona, format, word count

**Parameters:**
- `--topic`: Matches knowledge file name (e.g., "va-loans", "dscr-investor-loans")
- `--persona`: "inside-man" | "coach" | "wolf"
- `--format`: "youtube-script" | "instagram-reel" | "linkedin-post" | "facebook-post"
- `--hook-style`: Optional override for specific hook pattern

**Quality control:** Script should include word count check (reject if under 500 words for scripts) and compliance phrase check (must include NMLS footer)

---

## Automation 5: HeyGen Submission (heygen-submit.sh)

**Purpose:** Submit a finalized script to HeyGen API and poll for completion  
**Trigger:** Manual, called with script file as argument  
**Usage:**
```bash
./automation/heygen-submit.sh --script "outputs/scripts/sample-package/video-script.md" --segment 1
```

**Process:**
1. Parse script file, extract segment specified
2. Clean script text: remove markdown formatting, stage directions, compliance notes
3. Submit to HeyGen API:
   - `avatar_id`: from `config/heygen.json`
   - `voice_id`: from `config/heygen.json`
   - `script`: cleaned segment text
   - `background`: from persona config
4. Capture returned `video_id`
5. Poll `GET /v1/video_status.get?video_id=[id]` every 60 seconds
6. When status = "completed", download MP4 to `outputs/heygen_prompts/[package]/renders/`
7. Log completion with video_id, duration, file size, location

**Error handling:** If status = "failed", log error and send notification  
**Output:** Downloaded MP4 + log entry  
**Rate limits:** HeyGen rate limits vary by plan. Build in exponential backoff on polling.

---

## Automation 6: Social Publishing (publish-social.sh)

**Purpose:** Publish finalized social content to multiple platforms  
**Trigger:** Manual, with platform flags  
**Usage:**
```bash
./automation/publish-social.sh --platform instagram --content "outputs/social-cuts/instagram-reel-guarantee.md" --video "outputs/heygen_prompts/sample-package/renders/reel-60sec.mp4"
```

**Platforms supported:**
- Instagram (via Facebook Graph API)
- Facebook Page (via Facebook Graph API)
- LinkedIn (via LinkedIn API)
- Google Business (via GMB API)

**Process:**
1. Load content file (caption text + metadata)
2. Validate compliance footer present in caption
3. If video: upload video file to platform's media endpoint
4. Submit post with caption and scheduled time
5. Log post ID, platform, timestamp, content hash

**Compliance check:** Require confirmation prompt before publishing. Display content summary and ask "Post this? [y/N]:"

**Notes:** YouTube uploads should be done through YouTube Studio directly due to OAuth complexity. This script handles the short-form platforms only.

---

## N8N Workflow Integration

For the GHL lead pipeline and more complex multi-step automations, use n8n as the orchestration layer:

- **Trigger:** New lead enters GHL from YouTube video CTA
- **Workflow:** Auto-tag with content source → send welcome email sequence → create task in GHL → notify Jeremy via Slack/SMS
- **See:** `knowledge/` for n8n workflow JSON specs (create separately)

---

## Implementation Timeline

**Week 1:** Set up `.env` credentials, test YouTube API connection, run `monitor-epic-re.sh` manually  
**Week 2:** Add transcript fetch and style analysis automation  
**Week 3:** Build `generate-content.sh` with knowledge base integration  
**Week 4:** Set up HeyGen submission script, test with one segment  
**Month 2:** Add social publishing automation, connect to GHL via n8n  

---

*Jeremy McDonald | The Legends Mortgage Team powered by Loan Factory | NMLS 1195266 | Loan Factory NMLS 320841 | Equal Housing Opportunity*
