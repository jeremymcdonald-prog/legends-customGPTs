# Implementation options

## Recommended boundary

Use a small secure API or serverless function as a lead-capture facade. It should validate consent, active profile assignments, allowed fields, idempotency, abuse controls, and audit metadata before sending the lead through a replaceable destination adapter.

The repository evidence does not establish one authoritative CRM: source material references multiple tools and LegendsOS documentation explicitly separates its system from a CRM. Do not hardcode GoHighLevel, Follow Up Boss, TERA, email, or any other destination until the GOAT Architect names the operational owner and approved system of record.

## Viable implementation shapes

1. **Existing LegendsOS/Vercel API boundary:** preferred only if its owner approves the security, privacy, isolation, and support model.
2. **Dedicated serverless function:** clean isolation and a small attack surface, with an adapter for the approved downstream system.
3. **Managed workflow/webhook platform:** possible for a controlled pilot only if authentication, field minimization, logging, retention, deduplication, and secrets handling meet every requirement.
4. **Secure email handoff:** possible as an adapter, not as direct GPT email; requires an approved recipient map and delivery/audit controls.

## Required interfaces

- Active profile and GPT-manifest lookup
- Consent and payload validator
- Idempotency/deduplication store
- Destination adapter
- Payload-free operational audit
- Alerting and named human follow-up ownership
- Deletion and retention job

No option is deployed or selected by this architecture package. Deployment begins only after the privacy URL, destination, owner, threat review, compliance review, test environment, and rollback path are approved.
