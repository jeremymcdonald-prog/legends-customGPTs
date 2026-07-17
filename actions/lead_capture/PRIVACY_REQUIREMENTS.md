# Privacy requirements

1. Publish a valid, public, HTTPS privacy-policy URL and configure it in both the GPT Action and the deployed API documentation before launch.
2. State what is collected, why, the assigned recipient, downstream processors, retention period, deletion process, consumer rights/contact, and effective date.
3. Collect only fields in `FIELD_MAPPING.md`; do not repurpose them without notice and review.
4. Retain the exact consent version and timestamp with the submission.
5. Define and enforce retention and deletion schedules across the API, logs, queue, and destination system.
6. Do not place lead payloads or sensitive content in analytics, error traces, prompt logs, or general audit events.
7. Document subprocessors and any cross-system transfer before selecting an implementation destination.
8. Complete privacy and compliance review whenever fields, purpose, recipients, or retention change.

The placeholder URL in `openapi.yaml` is intentionally not launch-valid.
