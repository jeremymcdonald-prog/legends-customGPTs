# Tool map

| Capability or service | Recommended use | Guardrail |
|---|---|---|
| ChatGPT browsing | Current public market, regulatory, program, and local information | Cite authoritative sources; never treat search snippets as official loan terms |
| Image generation | Concepts, backgrounds, generic illustrations, approved virtual staging | Do not fabricate listing/property facts or alter material property condition without disclosure |
| Code Interpreter | Calculations, document analysis, structured exports | Label estimates and assumptions; do not produce an official quote or underwriting result |
| Google Sheets / Apps Script | Pipeline reads and approved writes | Least privilege, authenticated server, field minimization, audit log, explicit approval for sends |
| Gmail / calendar | Drafting, scheduling, approved communication | Draft-first; consent and human approval; CAN-SPAM/TCPA as applicable |
| GoHighLevel | CRM nurture and partner workflows | Role scoping, opt-out handling, audit trail, no unapproved autonomous claims |
| n8n / Zapier | Workflow orchestration | Secrets in credential stores, signed webhooks, retries, dead-letter/failure alerts |
| Canva | Branded layouts and co-marketing templates | Approved logos, licensing, disclosure size, brand lockups |
| HeyGen / AI video | Approved scripts and avatar production | Consent for likeness/voice; visible disclosure where required; script compliance review |
| Google Business Profile / social tools | Draft and schedule approved content | Current licensing and disclosures; no unsupported superlatives |
| MOSO / pricing / guideline systems | Internal verified lookup only | Never expose publicly; official system remains source of truth |
| Secure lead-capture facade | Validate consent, active profile assignment, approved fields, deduplication, and destination delivery | External authenticated endpoint; public privacy policy; payload-free audit; no application documents |

Reusable Action schemas belong in `actions/schemas/`; the planned mortgage lead contract is grouped in `actions/lead_capture/`. This map does not grant permission or contain credentials.
