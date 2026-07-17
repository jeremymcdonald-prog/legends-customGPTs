# Automation Readiness

## What runs manually in v1

- Canva Bulk Create execution (operator clicks Run).
- HeyGen render (operator submits in HeyGen).
- Higgsfield generation (operator submits in Higgsfield).
- Upload to hosting bucket.
- Fill `media_url_tracker.csv`.
- HeroPost import.

## What can move to automation as connectors land

| Step | Connector needed | Status |
|---|---|---|
| Canva fill execution | Canva connector (mcp__f62fe56b-...__*) | Available in tool registry, needs verification |
| HeyGen render | HeyGen MCP or Zapier action (heygen_* via Zapier MCP available) | Zapier path available; direct HeyGen MCP TBD |
| Higgsfield generation | Higgsfield connector / API | Unknown — see mcp-connector-audit.md |
| Hosting upload | Google Drive (Zapier available, plus Google Drive MCP available) | Available, needs binding |
| HeroPost import | HeroPost API or MCP | Unknown — see mcp-connector-audit.md |

## Manual to semi-automated transition

When a connector is verified:

1. Engine logs the connector as `verified` in `mcp-connection-checklist.md`.
2. Engine swaps the manual step for the connector call.
3. Engine keeps the manual fallback documented.

## n8n role

n8n hosts the longer-running orchestrations:

- Watch `media_url_tracker.csv` for new URLs (or Google Sheets row events).
- Trigger HeroPost final promotion.
- Notify Jeremy on Slack/Telegram when a week's final CSV is ready.
- Capture performance pulls after a week ends.

## Hard rule

No external publish runs without human approval until at least the first 90 days of automation are observed. Drafts only. The Engine prepares; Jeremy signs off.
