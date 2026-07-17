# AI Boardroom — Knowledge Files

This folder holds knowledge files pulled into the skill's context at runtime. Files marked **SOURCE FILE REQUIRED** are not yet attached and must be sourced before this skill goes fully live.

## Required source files

| File | Status | Purpose |
|---|---|---|
| `AI_BOARDROOM_COMPLETE.md` | **REQUIRED** | The 20-persona research doc, council and workflow definitions, mortgage and AI trios |
| `2026-05-19_AI_Boardroom_Review_Two_Automation_Workflows.md` | **REQUIRED** | The worked example: operational seats, risk tiers, send-approval lesson, compliance keyword list |
| `boardroom-risk-register.md` | **REQUIRED** | Full R-code list and definitions (the 6 codes in compliance-pack.md are a subset) |
| `tera-stack-reference.md` | **REQUIRED** | What TERA holds, API access status, Airtable middle layer, n8n/Zapier MCP limits, approved AI providers |

## Shared knowledge (already exists, just point to it)

| File | Location | Purpose |
|---|---|---|
| Compliance pack | `_shared/brand-dna/compliance-pack.md` | Canonical guardrails + risk tiers + R-codes |
| NMLS + EHO footer | `_shared/brand-dna/nmls-eho-footer.md` | Footer text + "sent on behalf of" rule |
| Voice | `_shared/brand-dna/voice.md` | Jeremy's voice for any customer-facing fix the board recommends |
| Handoff rules | `_shared/knowledge/handoff-rules.md` | Where boardroom output routes after review |

## How to add a source file

Drop the .md into this folder. Update the table above to mark it complete. The skill automatically reads any .md in this directory at session start.
