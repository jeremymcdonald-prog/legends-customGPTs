# Rate Quote Research — Loan Factory Public Surfaces

This file is the research log behind the Custom GPT's optional rate-quote action. It documents what was probed, what was found, and what the safest production architecture is. All probing in this research was read-only on public URLs, with no credentials, no form submission, no PII, and no security bypass.

> **TL;DR:** No clean public JSON API exists for rate quotes. The quote form is reCAPTCHA-protected (do not automate). The rate chart is client-rendered (Playwright required to extract values). The safest production path is Playwright scraping of the **public, no-input rate chart** for **market context only**, with the loan officer always confirming the matching APR before any rate-based public copy is produced.

---

## 1. URLs Inspected

| URL | Purpose | HTTP | Tech | Size | Notes |
|---|---|---|---|---|---|
| https://www.loanfactory.com/quote/qm | Rate quote engine | 200 | Legacy GAE + jQuery widgets | 90 KB shell + JS | reCAPTCHA-protected |
| https://www.loanfactory.com/jeremymcdonald | Loan Officer homepage | 200 | Next.js (lo-homepage-v2 Cloud Run) | 760 KB | LO metadata inline; `mortgage-rate` component pulls from chart |
| https://www.loanfactory.com/jeremymcdonald/mortgage-rates | LO rate chart | 200 | Legacy GAE shell | 84 KB | Same widget system as /quote/qm |
| https://www.loanfactory.com/jeremymcdonald/mortgage-report | LO marketing page | 200 | Next.js | 760 KB | Returns identical content to /jeremymcdonald — alias |
| https://www.loanfactory.com/best-rate-chart | Company-wide rate chart | 200 | Next.js (lf-homepage Cloud Run) | 1.09 MB | Aliases: `/rate-chart`, `/mortgage-rate/chart`. Rate values rendered client-side |
| https://www.loanfactory.com/jeremymcdonald/historical-rates | Historical rate trends | 200 | Next.js | 636 KB | Same client-render pattern |

## 2. Architecture Observations

Loan Factory operates **two parallel front-end stacks** that share a Google App Engine backend named **`lender-rate`**:

1. **Legacy stack** — jQuery + AppEngine-rendered templates. URLs include `/quote/qm`, `/jeremymcdonald/mortgage-rates`. JS bundles are served from `storage.googleapis.com/lender-rate/express/`.
2. **Next.js stack** — Two Cloud Run services:
   - `lf-homepage-444859640964.us-central1.run.app` — company-wide marketing pages including the best-rate chart.
   - `lo-homepage-v2-444859640964.us-central1.run.app` — Loan Officer homepages.
   Routed through `www.loanfactory.com` via reverse proxy.

Shared backend config visible in `window._atocfg`:
- `appId: "lender-rate"`
- `quotable_lenders_count: 91`
- `lender_approved_count: 200`
- `best_rate_chart_state: "CA"` (default state)
- `best_rate_chart_purpose: "PM"` (purchase-money default)
- `best_rate_chart_loan_type: "Conventional"` (default loan type)
- `compensation_cap: 3.0`
- `pylon_licensed_states:` 42 states the company is licensed in

## 3. Public Endpoint Probes (HTTP Status Only)

All probes were unauthenticated GETs from a desktop user-agent string, no form data, no PII.

**Endpoints that 404'd** (no public JSON API exists at any of these):
- `/api/rates`, `/api/best-rate`, `/api/best-rate-chart`, `/api/v1/rate`, `/api/v1/quote`, `/api/lender-rate`, `/api/mortgage-rate`, `/api/mortgage-rates`, `/api/quote`, `/api/lo/jeremymcdonald`, `/api/loan-officer/jeremymcdonald` on `www.loanfactory.com`
- `/api/rate`, `/api/rates`, `/api/lender-rate`, `/api/loan-officer`, `/api/quote`, `/api/best-rate`, `/_next/data` on either Cloud Run host
- All Next.js Cloud Run hosts return 404 for any `/api/...` path → there are **no Next.js Route Handlers** exposed to the public.

**Endpoints that returned 200** but turned out to be HTML wildcards (the legacy GAE app routes any path under `/lender-rate/` and `/quote/qm/` to a fallback HTML page):
- `/lender-rate`, `/lender-rate/api/rate`, `/lender-rate/api/anything-fake`, `/quote/qm/api` — all return identical 1.09 MB Loan Factory homepage HTML
- Therefore: **no `/lender-rate/api/...` is a real API**. Do not call any of these as APIs.

**Real HTML pages returning 200**:
- `/best-rate-chart`, `/rate-chart`, `/mortgage-rate/chart` → all return the same 1.09 MB Next.js page (the company-wide rate chart). URL query params (`?state=FL&purpose=PM&loan_type=Conventional`) do **not change** the initial HTML byte count → rate filtering happens client-side after hydration.
- `/jeremymcdonald/historical-rates` → Next.js historical chart page.

## 4. Quote Form Inspection (`/quote/qm`)

- The page ships **zero `<form>` elements** in initial HTML. The quote UI is built by JavaScript widgets after page load.
- Embedded config (`_atocfg`) includes:
  - `recaptcha_site_key: "6LcXLL4qAAAAAM0QLnu-oAO16KLJv2mX4RZwqjOG"` → **Google reCAPTCHA v3 protection**.
  - `version: "20260514120936"` → versioned daily.
- AJAX/fetch targets discoverable in inline scripts:
  - `POST /x-update-ga-client-id` (analytics only)
  - `https://zoom.loanfactory.com/api` (Zoom subdomain, not rate data)
  - No public rate or quote API was found.
- **Conclusion:** the quote engine is gated behind reCAPTCHA. **Programmatic submission is not safe to attempt**, both for technical reasons (reCAPTCHA v3 will flag automated traffic) and policy reasons (Loan Factory ToS + Google reCAPTCHA ToS).

## 5. Rate Chart Inspection (`/best-rate-chart`)

- Next.js page served from `lf-homepage-444859640964.us-central1.run.app` via reverse proxy on `www.loanfactory.com`.
- Initial HTML is 1.09 MB but **contains no live rate values** — the rate chart hydrates client-side from a server action or RSC fetch we cannot trigger purely via HTTP from the outside.
- URL params (`state`, `purpose`, `loan_type`) do not change the initial HTML payload. Filtering happens after hydration.
- One important LF copy snippet from the page (quoted verbatim, helps explain LF's stance on APR):
  > "APR is an easily manipulated number which makes it difficult if not impossible to compare different programs and products."
  This is a tell that the public chart **may publish rate without APR**. Our compliance posture must assume APR is not always returned from the chart and must require the loan officer to provide it for any rate-based public copy.
- Recommendation: **Playwright is required** to actually extract the displayed rate (and APR if present) from this page.

## 6. LO-Specific Inspection (`/jeremymcdonald`, `/jeremymcdonald/mortgage-rates`)

- The Next.js LO homepage embeds rich loan officer metadata in the RSC payload, including:
  - `loInfo.first_name`, `last_name`, `title: "Loan Officer"`
  - `originator_nmls`
  - `licenses[]` with state, expire_date, issued_date, sponsored flag
  - `company_email`, `company_phone`
  - YouTube embed URL, social links
- The page includes a `mortgage-rate` component but the actual rate values are not in the inline HTML; they hydrate client-side.
- The legacy `/jeremymcdonald/mortgage-rates` page is the older shell, served by App Engine — same widget system as `/quote/qm`.
- **Whether LO-specific pages show different rates than the company-wide chart is unverified** — the rates may be the same with LO branding overlay. The n8n workflow should support both URLs and let the LO request the source explicitly.

## 7. What Cannot Be Confirmed Without Browser Automation

The following questions can only be answered by loading the pages in a real headless browser (Playwright) and inspecting the rendered DOM and network traffic. They are intentionally left for first-run discovery during n8n workflow setup.

1. Does the rendered `/best-rate-chart` actually display APR alongside the interest rate?
2. Does the rendered LO-specific `/jeremymcdonald/mortgage-rates` show different numbers than the company-wide chart for the same state/purpose/loan type?
3. What URL does the chart hydration fetch from after page load? (This may reveal an internal endpoint that, if and only if it is publicly served without authentication, could be used as a cleaner data source. **It must not be reused if it appears to be a private RPC.**)
4. Are there CORS or rate-limit signals that suggest the chart endpoint is intended for first-party use only?

These are the first three tests the n8n workflow should perform in headed mode during setup, with the Loan Factory team's approval, before any production scraping runs.

## 8. Compliance / Policy Risk Notes

- **Do not automate `/quote/qm` form submission.** reCAPTCHA v3 plus Loan Factory ToS make this a hard no.
- **Do not impersonate users.** All Playwright runs must use a clear identifying User-Agent string referencing the Legends Mortgage Team automation and a contactable email (see workflow spec).
- **Do not bypass rate limiting.** Cache responses for at least 15–30 minutes per `state + purpose + loan_type` combination to avoid hammering the public chart.
- **Do not store rate data long-term as if it were a quote.** Rate chart values are **market context** only — they are not a quote, not a commitment to lend, and not necessarily LO-specific.
- **Always tag the source URL and timestamp** so compliance can audit where each rate number came from.

## 9. Recommended Production Architecture

```
+-----------------+     +-----------------+     +------------------------+     +-------------------+
|  Custom GPT     | --> | GPT Action      | --> | n8n Webhook            | --> | Playwright Worker |
| (ChatGPT)       |     | (OpenAPI POST)  |     | (validate + route)     |     | (headless chrome) |
+-----------------+     +-----------------+     +------------------------+     +-------------------+
        ^                                                |       |                       |
        |                                                |       v                       v
        |                                                |   +-----------+        +------------------+
        |                                                |   | Try real  |  GET   | /best-rate-chart |
        |                                                |   | endpoint  | -----> | (Loan Factory)   |
        |                                                |   | first     |        +------------------+
        |                                                |   | (none yet)|                |
        |                                                |   +-----------+                v
        |                                                |                        +------------------+
        |                                                |                        | Extract rate/APR |
        |                                                |                        | from rendered DOM|
        |                                                |                        +------------------+
        |                                                |                                |
        +------------------------------------------------+--------------------------------+
                                                         |
                                                         v
                                                Structured JSON response:
                                                {success, source, source_url, retrieved_at,
                                                 interest_rate, apr, points, ...,
                                                 compliance_flags[], market_context_only, ...}
```

Key design choices:

1. **GPT never calls Loan Factory directly.** Always through n8n.
2. **n8n tries a "real endpoint" branch first.** Currently no public endpoint exists, but the branch is kept open so that if Loan Factory ever publishes one (or if the Legends team coordinates a private partner endpoint), the workflow can switch with no GPT-side change.
3. **Playwright is the fallback, not the default.** Playwright runs are throttled, cached, and use a clear identifying User-Agent.
4. **Output is always tagged "market_context_only"** unless APR is also returned AND the loan officer has confirmed the matching APR for the specific campaign.
5. **The GPT decides how to use the data** under the compliance rules in `RATE_QUOTE_COMPLIANCE_RULES.md`. The workflow itself never produces marketing copy.

## 10. Open Questions to Confirm With Loan Factory (Before Production)

Before the workflow goes live, the Legends Mortgage Team should ask Loan Factory:

1. Is there a partner/affiliate JSON API available for licensed loan officers to retrieve their own rate data? (If yes, that is the right primary source — Playwright becomes the fallback only.)
2. Does Loan Factory consent to read-only Playwright access to `/best-rate-chart` for caching market-context data for internal marketing prep? With what rate limits and identifying header?
3. Does the LO-specific `/<lo-slug>/mortgage-rates` page surface different rates than the company-wide chart, and if so, may it be cached the same way?
4. What is Loan Factory's preferred attribution language for market-context rates pulled from `/best-rate-chart`?

These four answers should be captured in writing and stored in `RATE_QUOTE_COMPLIANCE_RULES.md` before any rate data flows from the workflow into a public-facing draft.

## 11. Summary

- No public REST/JSON API exists for rate quotes.
- Quote engine is reCAPTCHA-protected — never automate it.
- Rate chart is publicly viewable but client-rendered — Playwright required to extract values.
- All extracted values are **market context**, not quotes — APR must be loan-officer-confirmed before any rate-based public copy.
- Architecture: **Custom GPT → GPT Action → n8n Webhook → Playwright Worker → /best-rate-chart**, with a fallback branch ready for any future official endpoint.

See `N8N_RATE_QUOTE_WORKFLOW_SPEC.md` for the workflow build, `GPT_ACTION_RATE_QUOTE_OPENAPI_SCHEMA.json` for the GPT-side Action schema, and `RATE_QUOTE_COMPLIANCE_RULES.md` for the runtime compliance rules.
