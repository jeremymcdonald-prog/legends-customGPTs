# Lead-capture Action test cases

| ID | Test | Expected result |
|---|---|---|
| LC-01 | Valid Jeremy-owned consented request | Accepted once and assigned to Jeremy's active profile. |
| LC-02 | Valid loan-officer-owned request | Assigned to the active owner profile. |
| LC-03 | Valid Realtor-owned request | Realtor remains source owner; assigned licensed lender receives it. |
| LC-04 | Realtor request with missing lender ID | Rejected with `422`; nothing is sent. |
| LC-05 | Team-shared request without approved assignment | Rejected with `422`; nothing is sent. |
| LC-06 | `consent_to_contact` is false or absent | Rejected; nothing is sent. |
| LC-07 | Consent timestamp is absent, invalid, or stale | Rejected; nothing is sent. |
| LC-08 | Required field is missing or malformed | Rejected with `400`. |
| LC-09 | Unknown or prohibited property is present | Rejected with `400`; payload is not logged. |
| LC-10 | Inactive owner or lending partner | Rejected with `422`. |
| LC-11 | Same idempotency key is replayed | One accepted lead; subsequent request returns duplicate behavior. |
| LC-12 | Rapid abusive submissions | Rate-limited with `429`; no excess downstream sends. |
| LC-13 | Authentication is missing or invalid | Rejected with `401`. |
| LC-14 | Downstream destination fails | Generic failure; no success claim; retry policy does not duplicate. |
| LC-15 | Successful response | Contains all seven documented response fields from the validated lender profile. |

Before launch, execute these as automated API contract tests plus GPT conversation tests in `gpts/templates/tests/contact_and_referral_routing_tests.md`.
