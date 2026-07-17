# Mortgage News Daily — Average Rate Research

This file is the research log behind the Custom GPT's optional MND market-rate context action. It documents what was probed on Mortgage News Daily, what's available, what's not, and the architecture for safely using MND data as **third-party average market context** (never as a Loan Factory rate quote).

> **TL;DR:** MND publishes a daily national survey rate per loan type — clean, attributable, and updated daily. **MND publishes rate only, never APR.** The GPT may use MND values to build educational payment range estimates, but must never publish an exact MND rate as a Loan Factory advertised rate. MND data is third-party average market context, not Loan Factory pricing.

---

## 1. Why MND, Not Loan Factory's Quote Engine

A prior research pass investigated whether the GPT could pull rate data from Loan Factory's public surfaces (`/quote/qm`, `/best-rate-chart`, LO-specific `/mortgage-rates` pages). The conclusion was:

- The Loan Factory quote engine is **Google reCAPTCHA v3 protected**. Programmatic submission is unsafe.
- The company-wide rate chart is **client-rendered Next.js** with no public JSON endpoint.
- Loan Factory's own copy explicitly downplays APR ("APR is an easily manipulated number"), so the chart likely publishes rate only — same as MND but with more brittle scraping.

Mortgage News Daily is the cleaner choice:

- Public, ad-supported, journalism-style site with a permissive `robots.txt`.
- Daily survey rates published in plain HTML `<table>` markup, no auth, no captcha, no JavaScript-only rendering.
- Industry-standard reference. MND's daily survey is widely cited in compliant mortgage marketing across the industry.
- Treating MND rate as **third-party average market context** (rather than a Loan Factory quote) eliminates the implication problem of Loan Factory "advertising" a number it hasn't priced.

## 2. URLs Inspected

| URL | HTTP | Size | Has daily rate table | Has APR |
|---|---|---|---|---|
| https://www.mortgagenewsdaily.com/mortgage-rates | 200 | 2.8 MB | Yes (multi-row) | No |
| https://www.mortgagenewsdaily.com/mortgage-rates/30-year-fixed | 200 | 112 KB | Yes (16-day history) | No |
| https://www.mortgagenewsdaily.com/mortgage-rates/30-year-fha | 200 | 110 KB | Yes (12-day history) | No |
| https://www.mortgagenewsdaily.com/mortgage-rates/30-year-va | 200 | 107 KB | Yes (8-day history) | No |
| https://www.mortgagenewsdaily.com/mortgage-rates/30-year-jumbo | 200 | 110 KB | Yes (12-day history) | No |
| https://www.mortgagenewsdaily.com/mortgage-rates/florida | 200 | 115 KB | No (educational page, no daily table) | No |
| https://www.mortgagenewsdaily.com/robots.txt | 200 | 45 B | — | — |

## 3. robots.txt

```
User-agent: *
Allow: /
Disallow: /*/print*
```

MND explicitly allows crawling all paths except `/print*` printer-friendly variants. No User-Agent restrictions. The scraping approach below stays well within these rules with a clear identifying User-Agent and conservative throttling.

## 4. Table Structure (Per Loan-Type Page)

Every loan-type page (`/30-year-fixed`, `/30-year-fha`, `/30-year-va`, `/30-year-jumbo`) ships a single `<table>` with this shape:

| (header row) | Rate | Points | Change | Prior Year | YOY Change |
|---|---|---|---|---|---|
| MND's 30 Year Fixed (daily survey) | | | | | |
| May 13 2026 | 6.57% | -- | +0.01% | 6.92% | -0.35% |
| May 12 2026 | 6.56% | -- | +0.07% | 6.92% | -0.36% |
| ... | ... | ... | ... | ... | ... |

Findings on the actual page (snapshot taken 2026-05-14):

- 30-Year Fixed (daily survey): **6.57%** (today, +0.01% from yesterday, YoY -0.35%)
- 30-Year FHA (daily survey): **6.02%** (today, +0.02%, YoY -0.31%)
- 30-Year VA (daily survey): **6.04%** (today, +0.02%, YoY -0.31%)
- 30-Year Jumbo (daily survey): **6.68%** (today, +0.03%, YoY -0.36%)

The main `/mortgage-rates` page has a multi-product summary table:

| Product | Rate | Points | Change |
|---|---|---|---|
| 30 Yr. Fixed | 6.57% | -- | +0.01% |
| 15 Yr. Fixed | 6.07% | -- | +0.03% |
| ... | | | |

This is the canonical "what are rates today?" snapshot.

**APR is not displayed anywhere** on any MND rate page. MND is a rate-only publisher. This shapes our compliance posture: any GPT output using an MND rate must be **rate-context only**, not a public rate ad.

## 5. State Pages (e.g., `/florida`)

State-level pages (e.g., `/mortgage-rates/florida`) are **educational/contextual landing pages**, not daily rate tables. They do not publish a state-specific daily survey rate.

Implication: when a campaign needs a state-specific rate, the workflow defaults to the **loan-type national daily survey** (e.g., `/30-year-fixed`) and tags the asset as "national average daily survey." Do not invent a state-specific rate.

## 6. Attribution & Citation

MND's canonical product name for the daily rate is:

- **"Mortgage News Daily 30 Year Fixed (daily survey)"** (and FHA / VA / Jumbo variants)

The asset source URL should always be cited in the GPT's internal compliance footer. Public-facing copy may say "based on average market rate data from Mortgage News Daily" without printing the URL.

## 7. Freshness

MND publishes a new daily survey rate after market close each business day. Approximate update window: 4:00–6:00 PM ET, Monday through Friday. Saturdays and Sundays roll the previous Friday number.

Cache TTL recommendation: 4 hours. Anything older than 4 hours during market hours should be re-fetched. Anything past close (after ~6 PM ET) can be held until the next market close.

## 8. What MND Does NOT Provide

- **APR.** Never displayed on any rate page.
- **Locked rates, quotes, approvals.** MND is a market-context publisher, not a lender.
- **State-specific daily survey rates.** State pages are educational only.
- **Borrower-specific scenarios.** No payment calculator data, no FICO bucket pricing.
- **Closing costs, points-paid pricing, lender-specific rates.** MND survey rate is national, average, par-pricing approximation.

Anything we'd need beyond rate (APR, payment, fees, etc.) must come from the loan officer.

## 9. Risk Surface

1. **No APR.** Compliance requires APR to publish an exact public rate. **Mitigation:** use MND only for educational payment ranges, never as a public exact rate. Spread the rate into a range to defuse the "exact rate ad" risk further.
2. **Average, not bid.** MND survey doesn't price the LO's specific lender stack. **Mitigation:** always label as "average market data, not Loan Factory pricing."
3. **Property state implication.** A buyer might infer an MND rate is available in their state. **Mitigation:** wording must say "national daily survey" and the GPT enforces State Licensing Handoff if the LO is not licensed in the property state.
4. **Implied advertising of MND's number under Loan Factory's brand.** **Mitigation:** never put the MND rate on an image. Captions may attribute the payment range to MND but must explicitly say it is third-party market context, not Loan Factory's offer.

## 10. Recommended Architecture

```
+-----------------+     +-----------------+     +------------------------+
|  Custom GPT     | --> | GPT Action      | --> | n8n Webhook            |
| (ChatGPT)       |     | getMNDRateCtx   |     | (validate + fetch)     |
+-----------------+     +-----------------+     +------------------------+
                                                          |
                                                          v
                                                  +------------------+
                                                  | HTTP GET MND     |
                                                  | (or Playwright   |
                                                  | if HTML changes) |
                                                  +------------------+
                                                          |
                                                          v
                                                  +------------------+
                                                  | Parse rate row   |
                                                  | apply spread     |
                                                  | calc P&I range   |
                                                  +------------------+
                                                          |
                                                          v
                                                  Structured JSON:
                                                  {rate, range_low, range_high,
                                                   pi_low, pi_high, total_low, total_high,
                                                   source_url, retrieved_at,
                                                   market_context_only: true,
                                                   compliance_flags[], assumptions, disclaimer}
```

Key design choices:

1. **MND data is fetched via simple HTTP GET** of the matching loan-type page. The HTML table parses cleanly with `cheerio` (Node) or `BeautifulSoup` (Python). No JavaScript rendering required for MND.
2. **Spread is applied server-side** so the GPT receives a range, not a single number. This makes it mechanically harder for a downstream draft to accidentally publish "the rate."
3. **APR is never returned.** Always `null` from MND. `market_context_only: true` always.
4. **Cache key:** `loan_type|date` with 4-hour TTL.
5. **The GPT applies the compliance rules** in `MND_RATE_CONTEXT_COMPLIANCE_RULES.md` to decide how to use the data in the draft.

## 11. Open Items Before Production

Before the workflow goes live, the Legends Mortgage Team should:

1. Confirm with Loan Factory compliance that "MND average market context with payment range estimate" is an approved framing for educational marketing assets.
2. Confirm the approved attribution string for MND in marketing copy. Recommended: "based on average market rate data from Mortgage News Daily (national daily survey)."
3. Confirm the standard insurance, taxes, HOA placeholders the workflow may pre-fill or whether those are always LO-confirmed inputs.
4. Decide whether to display the rate range, the payment range, or both in public-facing assets. Recommendation: payment range only on public assets; rate range visible only in the internal compliance footer.

## 12. Manual Fallback (Until n8n Is Built)

Until the n8n webhook is deployed, the GPT may work manually:

1. Use web search to retrieve the current MND daily survey rate from the matching page URL.
2. Cite the URL in the internal compliance footer of the draft.
3. Apply the standard spread (−0.25% to +0.50%) and compute the payment range using LO-confirmed purchase price, loan amount, and assumptions.
4. Apply all rules in `MND_RATE_CONTEXT_COMPLIANCE_RULES.md`.

This manual path is fine for low volume. The n8n webhook becomes valuable once campaign volume crosses ~10 drafts per day or once the team wants automated caching and observability.

## 13. Summary

- MND publishes daily survey rate per loan type, rate-only, no APR.
- `robots.txt` permits all paths except `/print*`.
- HTML tables parse cleanly; no Playwright required (unlike the LF chart).
- All output framed as **average market context only**, never as Loan Factory pricing.
- All exact MND rate values stay off the public-facing image; captions may attribute the payment range but must not imply LF is offering that rate.
- The State Licensing Handoff Workflow still gates everything: MND rate context cannot be published under an LO not licensed in the property state.

See `MND_PAYMENT_RANGE_WORKFLOW.md` for the n8n workflow build, `GPT_ACTION_MND_RATE_OPENAPI_SCHEMA.json` for the GPT Action schema, and `MND_RATE_CONTEXT_COMPLIANCE_RULES.md` for the runtime compliance rules.
