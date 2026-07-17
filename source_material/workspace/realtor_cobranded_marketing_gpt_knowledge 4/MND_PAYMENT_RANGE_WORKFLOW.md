# n8n Workflow Spec — MND Payment Range Action

This spec describes the n8n workflow that powers the Custom GPT's optional `getMNDRateContext` Action. The workflow accepts a sanitized request from the GPT, fetches the current daily survey rate from the matching Mortgage News Daily page, applies a conservative spread, computes a principal-and-interest payment range, and returns a structured JSON response.

> **Output is third-party market context only. It is not a quote, not an approval, not a commitment to lend, not a locked rate, and not a Loan Factory price.** Marketing copy is never produced inside this workflow — the GPT decides how to use the data under `MND_RATE_CONTEXT_COMPLIANCE_RULES.md`.

---

## 1. Workflow Identity

- **Workflow name:** `realtor_cobranded_mnd_payment_range_v1`
- **Webhook trigger path:** `/webhook/mnd-rate-context` (also accepts `/webhook/realtor-mnd-rate-context` as an alias)
- **Full webhook URL example:** `https://n8n.legendsmortgageteam.app/webhook/mnd-rate-context`
- **HTTP method:** `POST`
- **Auth:** custom header `X-Legends-Auth: <bearer-token>` (rotated quarterly, stored in n8n credentials, never in GPT prompt)
- **End-to-end timeout:** 12 seconds (much shorter than the prior LF workflow since MND is plain HTML)

## 2. Expected Input JSON

```json
{
  "loan_type": "Conventional",
  "property_state": "FL",
  "purchase_price": 525000,
  "down_payment_percent": 10,
  "loan_amount": 472500,
  "term_years": 30,
  "taxes_monthly": null,
  "insurance_monthly": null,
  "hoa_monthly": null,
  "mortgage_insurance_monthly": null,
  "rate_spread_low": -0.25,
  "rate_spread_high": 0.50
}
```

### 2a. Required Fields

- `loan_type` — one of `"Conventional"`, `"FHA"`, `"VA"`, `"Jumbo"`, `"USDA"`, `"NonQM"`, `"ARM"`, `"FifteenYearFixed"`. Anything outside this enum is mapped to `"Conventional"` (general baseline) and flagged in the response.
- `purchase_price` (number, USD)
- Either `loan_amount` (number, USD) **or** `down_payment_percent` (number, 0–100) — the workflow computes the missing one.
- `term_years` (number, default 30 if omitted)

### 2b. Optional Fields

- `property_state` (2-letter US code) — recorded in response but does not change MND source URL (MND state pages have no daily table)
- `taxes_monthly`, `insurance_monthly`, `hoa_monthly`, `mortgage_insurance_monthly` — only included in the total payment range if explicitly provided. If null, the response sets `included_assumptions` to indicate principal-and-interest only.
- `rate_spread_low` — default `-0.25` (interpreted as percent)
- `rate_spread_high` — default `+0.50` (interpreted as percent)

### 2c. Validation Rules

- `purchase_price` between 50,000 and 5,000,000 USD.
- `loan_amount` (if provided) ≤ `purchase_price`.
- `down_payment_percent` (if provided) between 0 and 100.
- `term_years` in [10, 15, 20, 25, 30, 40].
- `rate_spread_low` between −2.00 and 0.00.
- `rate_spread_high` between 0.00 and 2.00.
- Monthly cost fields (taxes/insurance/HOA/MI) ≥ 0 when provided.

Validation errors return HTTP 400 with a structured response (see §10).

## 3. Loan Type → MND Page Map

| `loan_type` | MND page URL |
|---|---|
| `Conventional` | `https://www.mortgagenewsdaily.com/mortgage-rates/30-year-fixed` |
| `FHA` | `https://www.mortgagenewsdaily.com/mortgage-rates/30-year-fha` |
| `VA` | `https://www.mortgagenewsdaily.com/mortgage-rates/30-year-va` |
| `Jumbo` | `https://www.mortgagenewsdaily.com/mortgage-rates/30-year-jumbo` |
| `FifteenYearFixed` | `https://www.mortgagenewsdaily.com/mortgage-rates` (parse 15 Yr Fixed row from the summary table) |
| `USDA` / `NonQM` / `ARM` / unknown | Default `/30-year-fixed` and set `loan_type_matched: "Conventional"` with flag `loan_type_fallback_to_conventional` |

## 4. Node Sequence

| # | Node Type | Name | Purpose |
|---|---|---|---|
| 1 | Webhook | `In: POST /mnd-rate-context` | Receive request |
| 2 | Function | `auth_check` | Validate `X-Legends-Auth` |
| 3 | Function | `validate_input` | Apply §2c; compute missing `loan_amount` or `down_payment_percent` |
| 4 | IF | `is_valid` | Branch to validation error if invalid |
| 5 | Function | `map_loan_type_to_url` | Per §3 |
| 6 | HTTP Request | `fetch_mnd_page` | GET the matched MND URL with a clear identifying User-Agent |
| 7 | Function | `parse_mnd_table` | Extract today's row: rate, change, prior year. Reject if today's row is older than 4 calendar days (stale) |
| 8 | Function | `compute_range` | Apply spread; compute P&I low/high; if monthly cost fields are provided, compute total payment low/high |
| 9 | Function | `apply_compliance_layer` | Set `market_context_only: true` (always); add compliance flags |
| 10 | Set | `compose_response` | Build the final response shape (§9) |
| 11 | Respond to Webhook | `respond_ok` | 200 + JSON |

Error branches converge on `Respond to Webhook` nodes with structured 4xx/5xx JSON.

## 5. HTTP Request Configuration (`fetch_mnd_page`)

- Method: `GET`
- URL: `{{$json.mnd_url}}` from `map_loan_type_to_url`
- Headers:
  - `User-Agent: Legends-Mortgage-Team-RateContext/1.0 (contact: jeremy.mcdonald@loanfactory.com)`
  - `Accept: text/html,application/xhtml+xml`
- Timeout: 6 seconds
- Retries: 1 attempt, 2 second backoff
- Response format: text/HTML

If status ≠ 200 or response size < 5000 bytes, branch to `respond_fetch_error`.

## 6. Parser (`parse_mnd_table`)

The MND loan-type pages have a single `<table>` with columns: `Rate | Points | Change | Prior Year | YOY Change`. The parser logic:

1. Find the first `<table>` whose first row caption contains `daily survey`.
2. Find the first `<tr>` whose first cell looks like a date (`M[M]/D[D]/YY` or `Month DD YYYY`).
3. Parse the date and confirm it is within 4 calendar days of today (UTC, with a tolerance for weekend rollover).
4. Extract `rate` from the second cell as a float (strip `%` sign).
5. Extract `change` and `prior_year` for context (optional fields in response).
6. If the table is stale or unparseable, flag `mnd_data_stale` or `mnd_parse_error` and continue with `success: false`.

For `loan_type: "FifteenYearFixed"`, parse the multi-product summary table at `/mortgage-rates`: find the row whose first cell contains "15 Yr. Fixed".

A reference parser (Node `cheerio`) is included in `parser-reference.js` (kept in the n8n workflow's notes — not in this knowledge folder).

## 7. Range Math (`compute_range`)

Given:
- `mnd_rate` (percent, e.g., 6.57)
- `rate_spread_low` (e.g., -0.25)
- `rate_spread_high` (e.g., +0.50)
- `loan_amount`
- `term_years`

Compute:
- `rate_range_low = mnd_rate + rate_spread_low` (e.g., 6.32)
- `rate_range_high = mnd_rate + rate_spread_high` (e.g., 7.07)

Principal-and-interest monthly payment (standard amortization):
```
P&I = L * (r/12) * (1 + r/12)^(n*12) / ((1 + r/12)^(n*12) - 1)
```

- `principal_interest_low` = P&I using `rate_range_low / 100`
- `principal_interest_high` = P&I using `rate_range_high / 100`

If any of `taxes_monthly`, `insurance_monthly`, `hoa_monthly`, `mortgage_insurance_monthly` is provided:
- `estimated_total_payment_low = principal_interest_low + sum(provided monthly costs)`
- `estimated_total_payment_high = principal_interest_high + sum(provided monthly costs)`

If none of the monthly cost fields is provided:
- `estimated_total_payment_low = null`
- `estimated_total_payment_high = null`
- `included_assumptions.principal_and_interest_only: true`

All numbers rounded to whole dollars (nearest 1).

## 8. Compliance Layer (`apply_compliance_layer`)

Apply these rules before composing the response:

1. **Always set `market_context_only: true`.** MND never provides APR. Output is always market context.
2. **Always include `disclaimer`** (verbatim string):
   > "This is a market-context estimate only. It is not a quote, approval, commitment to lend, or locked rate. Average market rate data is sourced from Mortgage News Daily and is not Loan Factory's offered rate. Actual rate, APR, payment, and terms depend on credit, income, assets, occupancy, loan program, property details, and final underwriting."
3. **APR is null in every response.** The GPT must obtain APR from the loan officer if it intends to publish a rate publicly.
4. **Compliance flags** added based on conditions:
   - `loan_type_fallback_to_conventional` — if input `loan_type` did not have a dedicated MND page.
   - `mnd_data_stale` — today's row is more than 4 calendar days old.
   - `mnd_parse_error` — the table could not be parsed.
   - `taxes_not_included` — if `taxes_monthly` is null.
   - `insurance_not_included` — if `insurance_monthly` is null.
   - `hoa_not_included` — if `hoa_monthly` is null.
   - `mortgage_insurance_not_included` — if `mortgage_insurance_monthly` is null (treat as a flag only if the loan type typically requires MI — FHA, conventional with <20% down).
   - `principal_and_interest_only` — when no monthly cost fields are provided.
   - `state_not_used_for_rate_lookup` — note that MND state pages don't have a daily table.

## 9. Structured Response Shape

Success response (P&I range only — no monthly cost inputs):

```json
{
  "success": true,
  "source": "mortgage_news_daily",
  "source_url": "https://www.mortgagenewsdaily.com/mortgage-rates/30-year-fixed",
  "retrieved_at": "2026-05-14T18:30:11.012Z",
  "loan_type_requested": "Conventional",
  "loan_type_matched": "Conventional",
  "average_rate": 6.57,
  "rate_range_low": 6.32,
  "rate_range_high": 7.07,
  "principal_interest_low": 2935,
  "principal_interest_high": 3162,
  "estimated_total_payment_low": null,
  "estimated_total_payment_high": null,
  "included_assumptions": {
    "principal_and_interest_only": true,
    "taxes_monthly": null,
    "insurance_monthly": null,
    "hoa_monthly": null,
    "mortgage_insurance_monthly": null,
    "term_years": 30,
    "loan_amount": 472500,
    "purchase_price": 525000,
    "down_payment_percent": 10
  },
  "missing_fields": ["taxes_monthly", "insurance_monthly", "hoa_monthly"],
  "market_context_only": true,
  "compliance_flags": ["taxes_not_included", "insurance_not_included", "hoa_not_included", "principal_and_interest_only"],
  "disclaimer": "This is a market-context estimate only. It is not a quote, approval, commitment to lend, or locked rate. Average market rate data is sourced from Mortgage News Daily and is not Loan Factory's offered rate. Actual rate, APR, payment, and terms depend on credit, income, assets, occupancy, loan program, property details, and final underwriting."
}
```

Success response (with monthly cost inputs provided):

```json
{
  "success": true,
  "source": "mortgage_news_daily",
  "source_url": "https://www.mortgagenewsdaily.com/mortgage-rates/30-year-fha",
  "retrieved_at": "2026-05-14T18:30:42.811Z",
  "loan_type_requested": "FHA",
  "loan_type_matched": "FHA",
  "average_rate": 6.02,
  "rate_range_low": 5.77,
  "rate_range_high": 6.52,
  "principal_interest_low": 2768,
  "principal_interest_high": 2992,
  "estimated_total_payment_low": 3553,
  "estimated_total_payment_high": 3777,
  "included_assumptions": {
    "principal_and_interest_only": false,
    "taxes_monthly": 480,
    "insurance_monthly": 120,
    "hoa_monthly": 0,
    "mortgage_insurance_monthly": 185,
    "term_years": 30,
    "loan_amount": 472500,
    "purchase_price": 500000,
    "down_payment_percent": 5.5
  },
  "missing_fields": [],
  "market_context_only": true,
  "compliance_flags": [],
  "disclaimer": "This is a market-context estimate only. ..."
}
```

Stale data:

```json
{
  "success": false,
  "source": "mortgage_news_daily",
  "source_url": "https://www.mortgagenewsdaily.com/mortgage-rates/30-year-fixed",
  "retrieved_at": "2026-05-14T18:31:09.412Z",
  "market_context_only": true,
  "compliance_flags": ["mnd_data_stale"],
  "missing_fields": [],
  "disclaimer": "MND's most recent daily survey is older than 4 calendar days. Do not use this as current market context. The loan officer should provide the rate manually or wait until MND posts a fresher number."
}
```

Validation error:

```json
{
  "success": false,
  "source": "no_data",
  "source_url": null,
  "retrieved_at": "2026-05-14T18:31:30.001Z",
  "compliance_flags": ["invalid_input"],
  "missing_fields": ["purchase_price"],
  "disclaimer": "Required field missing: purchase_price."
}
```

Fetch error:

```json
{
  "success": false,
  "source": "no_data",
  "source_url": "https://www.mortgagenewsdaily.com/mortgage-rates/30-year-fixed",
  "retrieved_at": "2026-05-14T18:32:01.812Z",
  "compliance_flags": ["mnd_fetch_error", "fallback_to_lo_input"],
  "missing_fields": [],
  "disclaimer": "MND data could not be retrieved. Loan officer should provide rate manually for this campaign."
}
```

## 10. Error Handling Summary

| Failure | HTTP | `success` | Compliance Flags |
|---|---|---|---|
| Auth header missing or wrong | 401 | false | `["unauthorized"]` |
| Validation error | 400 | false | `["invalid_input"]` |
| Loan type not matched | 200 | true | `["loan_type_fallback_to_conventional"]` |
| MND fetch non-200 / network error | 200 | false | `["mnd_fetch_error","fallback_to_lo_input"]` |
| MND parse error | 200 | false | `["mnd_parse_error","fallback_to_lo_input"]` |
| MND data stale (>4 calendar days) | 200 | false | `["mnd_data_stale"]` |
| Cache hit | 200 | true | (matched flags), `cached: true` |

## 11. Caching

- Cache key: `loan_type_matched|YYYY-MM-DD` (calendar day in US Eastern).
- TTL: 4 hours during market hours (9 AM – 6 PM ET, M-F). 24 hours otherwise.
- Cache hits do not re-fetch MND. Add `cached: true` and preserve original `retrieved_at`.

## 12. Observability

Each request emits a structured log:

```json
{
  "request_id": "uuid",
  "ts": "iso",
  "loan_type_requested": "FHA",
  "loan_type_matched": "FHA",
  "average_rate": 6.02,
  "rate_range_low": 5.77,
  "rate_range_high": 6.52,
  "duration_ms": 412,
  "cached": false,
  "success": true,
  "compliance_flags": []
}
```

No borrower PII. No purchase price stored long-term — only `loan_type` and aggregate rate values for monitoring.

## 13. Build Checklist

- [ ] Workflow `realtor_cobranded_mnd_payment_range_v1` created in n8n.
- [ ] Webhook at `/mnd-rate-context` (POST).
- [ ] Auth header check on `X-Legends-Auth`.
- [ ] Function nodes for validate, map, parse, compute, compliance per §§2c, 3, 6, 7, 8.
- [ ] HTTP Request configured with identifying User-Agent and 6 s timeout.
- [ ] Caching layer (Redis or n8n KV) keyed by `loan_type|YYYY-MM-DD`.
- [ ] Compose response per §9 shape.
- [ ] Smoke test with all 4 loan types: Conventional, FHA, VA, Jumbo. Verify rate values match the live MND page.
- [ ] Smoke test "with monthly costs" path: confirm total payment range adds up.
- [ ] Smoke test "loan type fallback" path with `loan_type: "USDA"`.
- [ ] Wire the GPT Action to this webhook (see `GPT_ACTION_MND_RATE_OPENAPI_SCHEMA.json`).

## 14. Manual Fallback Before n8n Is Live

Until the n8n workflow is deployed, the GPT can work manually:

1. Use web search to retrieve the current MND daily survey rate from the matching page URL.
2. Apply the standard −0.25% / +0.50% spread to construct a rate range.
3. Compute principal-and-interest range using LO-confirmed purchase price, loan amount, term.
4. Include monthly cost fields only if the LO confirms them.
5. Output using the format in `00_PASTE_IN_GPT_INSTRUCTIONS_SHORT.md` and `MND_RATE_CONTEXT_COMPLIANCE_RULES.md`.
6. Cite the MND URL in the internal compliance footer.

This manual path is fully compliant and works the same as the eventual n8n-backed path — only the data fetch is different.
