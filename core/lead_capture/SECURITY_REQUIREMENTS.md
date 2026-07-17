# Security requirements

The implementation must satisfy all requirements before public use:

1. HTTPS only.
2. Server-side schema, type, size, and allowlist validation.
3. Per-client and per-origin rate limiting.
4. Bot, replay, and abuse controls.
5. Minimum necessary data collection.
6. Encryption in transit and at rest.
7. Audit events that exclude lead payloads and sensitive content.
8. Consent-version and consent-timestamp retention.
9. A defined, enforced retention and deletion process.
10. A valid public privacy-policy URL.
11. No secrets in GPT instructions, knowledge, schemas, examples, or repository files.
12. Authentication values only in the GPT Action configuration and an approved server-side secret manager.
13. Idempotency and duplicate-submission detection.
14. Assignment validation against active owner and licensed-lender profile IDs.
15. A named human follow-up owner for every accepted lead.
16. Security, privacy, lending-compliance, and operational review before launch.

Reject unknown properties, inactive profiles, missing consent, stale/replayed requests, and payloads outside the documented boundary. Return generic errors to the GPT and keep diagnostic details in access-controlled server logs without lead content.
