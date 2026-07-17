# n8n Workflow Spec — Rate Quote Action

This spec describes the n8n workflow that powers the Custom GPT's `getRateQuote` Action. The workflow accepts a sanitized request from the GPT, optionally calls a Loan Factory endpoint (none exists today; the branch is reserved), and otherwise uses Playwright to extract market-context rate data from the public Loan Factory rate chart. It returns a structured JSON response that the GPT then renders under compliance rules.

> **All output from this workflow is market context, not a quote, not a commitment to lend, not an approval. Marketing copy is not produced by this workflow — the GPT decides how to use the data under `RATE_QUOTE_COMPLIANCE_RULES.md`.**

---

## 1. Workflow Identity

- **Workflow name:** `realtor_cobranded_rate_quote_v1`
- **Webhook trigger path:** `/webhook/realtor-rate-quote`
- **Full webhook URL (example):** `https://n8n.legendsmortgageteam.app/webhook/realtor-rate-quote`
- **HTTP method:** `POST`
- **Auth:** custom header `X-Legends-Auth: <bearer-token>` (rotate quarterly; store in n8n credentials, never in the GPT prompt)
- **Timeout (end-to-end):** 25 seconds (GPT Actions hard-limit is ~45s; we leave headroom)

## 2. Expected Input JSON (from GPT Action)

```json
{
  "loan_officer_name": "Jeremy McDonald",
  "loan_officer_profile_url": "https://www.loanfactory.com/jeremymcdonald",
  "property_state": "FL",
  "zip_code": "32256",
  "loan_purpose": "purchase",
  "loan_type": "Conventional",
  "occupancy": "primary",
  "property_value": 525000,
  "loan_amount": 472500,
  "fico_range": "740-759",
  "doc_type": "full_doc",
  "down_payment_percent": 10,
  "campaign_type": "general_listing"
}
```

### 2a. Required Fields

The workflow rejects any request missing all of these:

- `loan_officer_name` (string) — must match the Legends Mortgage Team roster
- `property_state` (string, 2-letter)
- `loan_purpose` (`"purchase"` | `"refinance"` | `"cash_out_refinance"`)
- `loan_type` (`"Conventional"` | `"FHA"` | `"VA"` | `"USDA"` | `"Jumbo"` | `"NonQM"`)

### 2b. Optional Fields

- `loan_officer_profile_url` — used to pull LO-specific chart if available
- `zip_code` (5 digits)
- `occupancy` (`"primary"` | `"secondary"` | `"investment"`)
- `property_value` (number, dollars)
- `loan_amount` (number, dollars)
- `fico_range` (string)
- `doc_type` (`"full_doc"` | `"bank_statement"` | `"alt_doc"`)
- `down_payment_percent` (number 0–100)
- `campaign_type` (one of: `"2_1_buydown"`, `"100_pct_financing"`, `"va_1pct_credit"`, `"general_listing"`, `"agent_outreach"`)

### 2c. Validation Rules

The workflow validates and rejects with a structured error (see §10) for any of:

- Missing required field.
- `property_state` not a 2-letter US state code.
- `loan_purpose` / `loan_type` / `occupancy` / `doc_type` outside the allowed enum.
- `property_value` < 50000 or > 5000000.
- `loan_amount` > `property_value`.
- `down_payment_percent` < 0 or > 100.
- `loan_officer_name` not found in the embedded Legends roster (kept in a Function node as a static list — see §6).
- `loan_officer_profile_url` not matching `https://www.loanfactory.com/<lo-slug>` (basic format check).

## 3. Node Sequence

| # | Node Type | Name | Purpose |
|---|---|---|---|
| 1 | Webhook | `In: POST /realtor-rate-quote` | Receive request |
| 2 | Function | `auth_check` | Check `X-Legends-Auth` header against env var; reject otherwise |
| 3 | Function | `validate_input` | Apply rules in §2c; build a normalized payload |
| 4 | IF | `is_valid` | Branch to `respond_validation_error` if invalid |
| 5 | Function | `lookup_lo` | Resolve loan officer from Legends roster; attach NMLS, licensed_states, slug |
| 6 | IF | `state_licensing_check` | Branch to `respond_state_mismatch` if LO is not licensed in `property_state` |
| 7 | Function | `route_source` | Choose mode: `endpoint` (always returns "no_endpoint" today), `playwright_chart`, or `cache_only` |
| 8 | HTTP Request | `try_endpoint` | Reserved branch — call official Loan Factory rate endpoint if/when published; currently always 404s |
| 9 | IF | `endpoint_success` | If endpoint returned 200 JSON, skip Playwright |
| 10 | HTTP Request | `playwright_worker` | POST to Playwright microservice with target URL, state, loan_type, purpose; returns extracted DOM values |
| 11 | Function | `parse_playwright_response` | Normalize numbers, detect APR presence, build `compliance_flags` |
| 12 | Function | `apply_compliance_layer` | Apply rules in `RATE_QUOTE_COMPLIANCE_RULES.md`: WA suppression, market_context_only, missing APR, sample scenario gating |
| 13 | Set | `compose_response` | Build the final structured JSON (see §9) |
| 14 | Respond to Webhook | `respond_ok` | 200 + JSON body |

Error branches all converge on `Respond to Webhook` nodes with structured 4xx/5xx JSON.

## 4. Playwright Worker — Detail

The Playwright worker is a small Node.js or Python microservice hosted alongside n8n (recommend Google Cloud Run, AWS Fargate, or a self-hosted box). It accepts:

```json
POST /scrape-rate-chart
{
  "url": "https://www.loanfactory.com/best-rate-chart",
  "filters": {
    "state": "FL",
    "loan_type": "Conventional",
    "loan_purpose": "purchase"
  },
  "lo_slug": "jeremymcdonald",
  "request_id": "uuid-string"
}
```

Internal Playwright steps:

1. Launch Chromium with a clear identifying User-Agent:
   `Mozilla/5.0 (Legends Mortgage Team rate-context bot; contact: jeremy.mcdonald@loanfactory.com) Playwright/1.x`
2. Set viewport 1280×900.
3. Navigate to the URL with `waitUntil: 'networkidle'` and a 12 s timeout.
4. If reCAPTCHA challenge or "Are you a human?" indicator is detected anywhere in the DOM:
   - Abort the scrape.
   - Return `{ status: "blocked_by_captcha", source_url: url }`.
   - n8n converts this into a `compliance_flag: "captcha_detected"` and `success: false`.
5. Set state / loan_type / loan_purpose filters on the page via UI clicks where supported (selectors discovered during workflow build). Wait 1.5 s after each filter change.
6. Read the rate row(s) displayed for the requested filter combination. Extract:
   - `interest_rate` (number, percent)
   - `apr` (number, percent — null if not displayed)
   - `points` (number — null if not displayed)
   - `estimated_payment` (string or number — null if not displayed)
   - `disclosures` (string — any footer disclaimer text near the chart)
   - `last_updated_at` (string — chart's published timestamp, if visible)
7. Take a small full-page screenshot and store it in cache for compliance audit (key by request_id, retain 30 days, then auto-delete).
8. Return:
   ```json
   {
     "status": "ok",
     "interest_rate": 6.875,
     "apr": null,
     "points": 1.0,
     "estimated_payment": null,
     "disclosures": "Rates as of ... Subject to change without notice.",
     "last_updated_at": "2026-05-14T12:09:00-07:00",
     "source_url": "https://www.loanfactory.com/best-rate-chart",
     "request_id": "uuid-string",
     "screenshot_storage_key": "rate-quote-screens/uuid-string.webp"
   }
   ```

### 4a. LO-Specific Chart (Optional Branch)

If the request includes `loan_officer_profile_url`, the Playwright worker may navigate first to that LO's `<lo-slug>/mortgage-rates` page (the legacy LO chart) and read the same data points. If the LO chart shows different numbers from the company-wide chart for the same filters, prefer the LO-specific values and tag `source: "lo_chart"`. If both match, prefer the company-wide values and tag `source: "company_chart"`.

### 4b. Rate Limiting and Caching

- Cache key: `state|loan_type|loan_purpose|lo_slug` (lo_slug optional, defaults to `company`).
- TTL: 30 minutes default, configurable.
- Cache hits do **not** re-launch Playwright; return the cached payload with the original `retrieved_at` timestamp and add `cached: true` to the response.
- Cap concurrent Playwright runs at 2. Queue overflow returns 429 with `compliance_flag: "rate_limited"`.

## 5. Endpoint Branch — Reserved For Future

The `try_endpoint` HTTP Request node is configured but does not currently resolve to any real Loan Factory rate API. It is left in place so that when Loan Factory publishes a partner endpoint (or when the Legends team negotiates one), the workflow can switch primary source by:

1. Updating the `try_endpoint` node URL to the new endpoint.
2. Adding auth headers in `try_endpoint` from n8n credentials.
3. Setting the `route_source` Function node to prefer `endpoint` over `playwright_chart`.

The Playwright branch then becomes a fallback for when the endpoint is unavailable or returns insufficient data.

## 6. Loan Officer Roster Lookup

The `lookup_lo` Function node holds a static array mapping loan officer names to NMLS, licensed states, profile URL, and slug. The list is sourced from `03_TEAM_ROSTER_AND_DISCLOSURES.md`. Update the array whenever the roster changes.

```js
const roster = [
  { name: "Jeremy McDonald", nmls: null, licensed_states: ["FL"], slug: "jeremymcdonald", profile_url: "https://www.loanfactory.com/jeremymcdonald", company_email: "jeremy.mcdonald@loanfactory.com" },
  { name: "Barbara Jordan", nmls: "2475165", licensed_states: ["GA","IL","IN","KY","MO"], slug: null, profile_url: null, company_email: "barbara.j@loanfactory.com" },
  { name: "Bryan Payne", nmls: "2360741", licensed_states: ["CA","GA","LA","VA"], slug: null, profile_url: null, company_email: "bryan.payne@loanfactory.com" },
  { name: "Christina Bús", nmls: "118777", licensed_states: ["AL","WA"], slug: null, profile_url: null, company_email: "christina.bus@loanfactory.com" },
  { name: "Eric Jason Ritchie", nmls: "2702310", licensed_states: ["FL","WI"], slug: null, profile_url: null, company_email: "eric.ritchie@loanfactory.com" },
  { name: "Hugo Calvillo", nmls: "1808485", licensed_states: ["FL"], slug: null, profile_url: null, company_email: "hugo.calvillo@loanfactory.com" },
  { name: "Jesus Urquiza", nmls: "2717748", licensed_states: ["FL"], slug: null, profile_url: null, company_email: "jesus.urquiza@loanfactory.com" },
  { name: "Mark Sileck", nmls: "983638", licensed_states: ["FL"], slug: null, profile_url: null, company_email: "mark.sileck@loanfactory.com" },
  { name: "Raleigh Morrison", nmls: "2511940", licensed_states: ["FL"], slug: null, profile_url: null, company_email: "raleigh.morrison@loanfactory.com" },
  { name: "Alison McLeod", nmls: "2680230", licensed_states: ["CA","NV","TX","UT"], slug: null, profile_url: null, company_email: "alison.mcleod@loanfactory.com" },
  { name: "Scott Mason", nmls: "2576892", licensed_states: ["FL"], slug: null, profile_url: null, company_email: "scott.mason@loanfactory.com" },
  { name: "Irene Holden", nmls: "2021254", licensed_states: ["CA","FL","SC"], slug: null, profile_url: null, company_email: "irene.holden@loanfactory.com" }
];
```

Note: Jeremy's individual NMLS is intentionally `null` here because the roster file lists him as team leader without an LO NMLS. Update if and when Jeremy's individual NMLS is loaded into the roster.

## 7. State Licensing Branch

The `state_licensing_check` IF node enforces the licensing rule from `01_GPT_MASTER_INSTRUCTIONS.md` Section 14. If `property_state` is not in the matched LO's `licensed_states`:

- Workflow does **not** call Playwright.
- Workflow searches the roster for any officer whose `licensed_states` includes `property_state`.
- Workflow returns a structured response with `success: false`, `compliance_flag: "state_not_covered_by_requested_lo"`, and `suggested_licensed_teammates: [...]` so the GPT can run the handoff workflow.

Example:

```json
{
  "success": false,
  "source": "no_data",
  "compliance_flags": ["state_not_covered_by_requested_lo"],
  "suggested_licensed_teammates": [
    { "name": "Barbara Jordan", "nmls": "2475165", "licensed_states": ["GA","IL","IN","KY","MO"] },
    { "name": "Bryan Payne", "nmls": "2360741", "licensed_states": ["CA","GA","LA","VA"] }
  ],
  "notes": "Jeremy McDonald is not licensed in GA. The roster shows Barbara Jordan and Bryan Payne are licensed in GA. Choose one of them and re-call this action with that loan officer name.",
  "retrieved_at": "2026-05-14T15:35:00Z"
}
```

## 8. Compliance Layer (`apply_compliance_layer` Function Node)

This Function node applies these rules to the Playwright (or endpoint) result before it leaves n8n:

1. If `apr` is null OR `interest_rate` is null → set `market_context_only: true`.
2. If both `interest_rate` and `apr` are present → set `market_context_only: false`, but **still tag** that the values are illustrative and require LO confirmation before going public.
3. If `property_state === "WA"` AND `campaign_type` is one that could reference the $2,000 Best Price Guarantee → add `compliance_flag: "wa_best_price_guarantee_suppressed"`.
4. If `interest_rate` is present but `apr` is null → add `compliance_flag: "apr_missing_required_before_public_use"`.
5. If LO is licensed in `property_state` but `loan_officer_profile_url` is null → add `compliance_flag: "lo_profile_url_missing_use_company_chart"`.
6. Never include borrower-specific PII in the response.
7. Always set `retrieved_at` to the actual timestamp Playwright completed (or cache timestamp).
8. Add `source_url` to the response — the actual URL the data came from.
9. Source label conventions:
   - `"endpoint"` — official Loan Factory API (currently unused)
   - `"company_chart"` — company-wide `/best-rate-chart`
   - `"lo_chart"` — LO-specific `<lo-slug>/mortgage-rates`
   - `"no_data"` — could not retrieve

## 9. Structured Response Shape

Successful response:

```json
{
  "success": true,
  "source": "company_chart",
  "source_url": "https://www.loanfactory.com/best-rate-chart",
  "retrieved_at": "2026-05-14T15:35:12.341Z",
  "loan_officer_name": "Jeremy McDonald",
  "property_state": "FL",
  "zip_code": "32256",
  "loan_purpose": "purchase",
  "loan_type": "Conventional",
  "occupancy": "primary",
  "property_value": 525000,
  "loan_amount": 472500,
  "fico_range": "740-759",
  "interest_rate": 6.875,
  "apr": null,
  "points": 1.0,
  "estimated_payment": null,
  "disclosures": "Rates as of 5/14/2026. Subject to change without notice. Not a commitment to lend.",
  "market_context_only": true,
  "compliance_flags": ["apr_missing_required_before_public_use"],
  "missing_fields": ["apr"],
  "cached": false,
  "notes": "Pulled from company-wide best-rate-chart. APR not displayed on the public chart. Loan officer must confirm matching APR before this rate is used in any public marketing copy."
}
```

Cache hit response:

```json
{
  "success": true,
  "source": "company_chart",
  "source_url": "https://www.loanfactory.com/best-rate-chart",
  "retrieved_at": "2026-05-14T15:09:42.001Z",
  "cached": true,
  "...": "all other fields same as fresh response"
}
```

Validation error response:

```json
{
  "success": false,
  "source": "no_data",
  "source_url": null,
  "retrieved_at": "2026-05-14T15:35:12.341Z",
  "compliance_flags": ["invalid_input"],
  "missing_fields": ["loan_purpose"],
  "notes": "Missing required field: loan_purpose. Acceptable values: purchase, refinance, cash_out_refinance."
}
```

State mismatch response: see §7 example above.

CAPTCHA / blocked response:

```json
{
  "success": false,
  "source": "no_data",
  "source_url": "https://www.loanfactory.com/best-rate-chart",
  "retrieved_at": "2026-05-14T15:35:12.341Z",
  "compliance_flags": ["captcha_detected", "scrape_blocked"],
  "missing_fields": [],
  "notes": "Scrape was blocked. Loan officer should provide rate and APR manually."
}
```

Timeout fallback response:

```json
{
  "success": false,
  "source": "no_data",
  "source_url": "https://www.loanfactory.com/best-rate-chart",
  "retrieved_at": "2026-05-14T15:35:37.812Z",
  "compliance_flags": ["timeout", "fallback_to_lo_input"],
  "missing_fields": ["interest_rate", "apr"],
  "notes": "Data could not be retrieved within 25 seconds. Loan officer must provide rate and APR manually for this campaign."
}
```

## 10. Error Handling Summary

| Failure | HTTP | `success` | `source` | Compliance Flags |
|---|---|---|---|---|
| Auth header missing or wrong | 401 | false | null | `["unauthorized"]` |
| Validation error | 400 | false | `no_data` | `["invalid_input"]` |
| LO not in roster | 400 | false | `no_data` | `["lo_not_in_roster"]` |
| LO not licensed in property state | 200 | false | `no_data` | `["state_not_covered_by_requested_lo"]` (with `suggested_licensed_teammates`) |
| Playwright captcha block | 200 | false | `no_data` | `["captcha_detected","scrape_blocked"]` |
| Playwright timeout | 200 | false | `no_data` | `["timeout","fallback_to_lo_input"]` |
| Playwright runtime error | 200 | false | `no_data` | `["scrape_error","fallback_to_lo_input"]` |
| Cache hit | 200 | true | (matched source) | (matched flags), `cached: true` |
| Endpoint returns 200 | 200 | true | `endpoint` | (per response) |
| Playwright extracts rate + APR | 200 | true | `company_chart` or `lo_chart` | (per rules in §8) |
| Playwright extracts rate only (no APR) | 200 | true | `company_chart` or `lo_chart` | `["apr_missing_required_before_public_use"]`, `market_context_only: true` |

## 11. Timeout Tuning

- Webhook overall: 25 s
- Playwright navigation: 12 s
- Playwright wait-for-render: 6 s
- Playwright filter-change settle: 1.5 s per change
- Hard cap on total scrape time: 18 s; remainder reserved for parsing + compliance + response

## 12. Observability

Each request emits a structured log line to n8n's logging (or a Loki/Datadog sink):

```json
{
  "request_id": "uuid",
  "ts": "iso",
  "loan_officer_name": "...",
  "property_state": "FL",
  "loan_type": "Conventional",
  "loan_purpose": "purchase",
  "source": "company_chart",
  "duration_ms": 4731,
  "cached": false,
  "success": true,
  "compliance_flags": ["apr_missing_required_before_public_use"]
}
```

No borrower PII, no full payloads, no auth tokens.

## 13. Build Checklist (n8n Setup)

- [ ] Create workflow `realtor_cobranded_rate_quote_v1`.
- [ ] Webhook node configured at `/realtor-rate-quote` (POST).
- [ ] Function node `auth_check` reading `X-Legends-Auth` against an n8n env var.
- [ ] Function node `validate_input` per §2c.
- [ ] Function node `lookup_lo` with the roster array from §6.
- [ ] IF node `state_licensing_check` returning suggested teammates per §7.
- [ ] HTTP Request node `try_endpoint` (placeholder, currently 404s).
- [ ] HTTP Request node `playwright_worker` pointing to a deployed Playwright microservice.
- [ ] Function nodes `parse_playwright_response` and `apply_compliance_layer` per §8.
- [ ] Set node `compose_response` building the final response shape per §9.
- [ ] Respond to Webhook nodes for all branches.
- [ ] Cache layer (Redis or in-memory n8n KV) with TTL 30 min per `state|loan_type|loan_purpose|lo_slug`.
- [ ] Observability sink configured.
- [ ] Smoke test with the sample payload in §2.

## 14. First-Run Verification Checklist (To Confirm Page Behavior)

Before flipping production traffic on, run these manual headed-browser tests (one per filter combination):

- [ ] Load `/best-rate-chart` with state=FL, purpose=PM, loan_type=Conventional. Does it display APR? Yes / No → set `apr` field expectations accordingly.
- [ ] Load `/jeremymcdonald/mortgage-rates`. Does it display the same rate as the company chart for FL/PM/Conventional? Yes / No → set `lo_chart` preference accordingly.
- [ ] Confirm no reCAPTCHA challenge appears on simple page load with a clean User-Agent.
- [ ] Confirm the chart has a "last updated" timestamp; capture the selector.
- [ ] Confirm the chart has a footer disclosure; capture the text.
- [ ] Document each selector and field in the Playwright worker code (these are the only selectors the worker depends on — keep them in one source file for easy maintenance).

These four checks should be repeated whenever Loan Factory ships a Next.js redeploy (the chunk hashes in the script src URLs change daily — see `RATE_QUOTE_RESEARCH.md` §2 for the version pattern).
