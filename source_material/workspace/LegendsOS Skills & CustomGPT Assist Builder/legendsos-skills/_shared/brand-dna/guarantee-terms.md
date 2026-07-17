# $1,000 Lowest Rate & Fee Guarantee — Canonical Terms

**STATUS:** Source verification required. This file is the single source of truth. Update here, propagates everywhere.

## Current confirmed values

| Field | Value | Status |
|---|---|---|
| Guarantee amount | `$1,000` | VERIFY current live amount before any guarantee creative ships |
| Eligible states | All states **except Washington** | Hard rule. Never promote the guarantee in Washington. |
| T&C URL | `loanfactory.com/best-price-guarantee` (or the Jeremy-specific URL) | VERIFY current URL before publish |
| Disclaimer (required on any guarantee creative) | "This is not a commitment to lend. All loans subject to credit approval. Rates, terms, and fees subject to change without notice." | Always include verbatim |

## Hard compliance rules

- Do NOT put a specific guarantee dollar amount on an image unless the current source offer and eligible states are confirmed at publish time.
- Do NOT promote the Best Price / Lowest Rate & Fee Guarantee in Washington. Include "All states except Washington" when the guarantee is featured.
- Do NOT use bare "lowest rate" or "lowest fees" language. Only reference the guarantee by its named program with its real terms.
- Always include the T&C URL on any guarantee creative.
- Always include the not-a-commitment-to-lend disclaimer.
- Always include Loan Factory NMLS #320841 + Equal Housing Lender on guarantee creatives.

## Programmatic check (Creative Studio, Visual Intelligence, Email Newsletter)

If `current_guarantee_offer` is unset or stale, the compliance gate **blocks** any creative that references the guarantee. No exceptions, no overrides.

## Approved reference language (PASTE)

```
$1,000 Lowest Rate & Fee Guarantee. Available in all states except Washington. Visit loanfactory.com/best-price-guarantee for full terms. This is not a commitment to lend. All loans subject to credit approval. Rates, terms, and fees subject to change without notice. Equal Housing Lender. Loan Factory NMLS #320841.
```
