# Zillow Review Story Rules

## Source

Zillow profile reviews for Jeremy McDonald.
Profile URL: https://www.zillow.com/lender-profile/JeremyMcDonaldFL/#reviews

## Intake rule

Reviews are pasted in by an operator. The skill does not scrape. If a scraping connector ever becomes available, see `docs/mcp-connector-audit.md`.

## Source ID

`ZILLOW_REVIEW_SOURCE_xxx`

## Public treatment

- `source_url` must be the Zillow profile URL above (or a direct review URL if Zillow exposes one for that review).
- Reframe is the default.
- Word-for-word quote allowed only with the citation "Public review on Zillow" included in the post.
- Sensitive specifics (rate, loan amount, address, payment) get scrubbed even when the review mentioned them.
- Competitor mentions inside a review get scrubbed.

## Anonymization

- Reviewer's first name is allowed in public-quote mode if the name is visible on Zillow as published.
- Reviewer's last name typically is NOT visible on Zillow; do not invent it.
- Do not pair the reviewer with the property address.

## Output bias

Stories sourced from Zillow lean toward:

- Speed of close
- Communication quality
- Broker advantage felt by the borrower
- VA / FHA / first-time-buyer benefit framing

## Disclaimers when using

- "Individual results vary."
- Program-specific lines if a program is referenced (VA non-endorsement, FHA program guidelines, etc.).
- Footer block on any mortgage-marketing piece.

## Forbidden

- No "as featured on Zillow's top lender list" type claims unless verified and current.
- No "rated #1" type claims.
- No pairing a Zillow rating number with a rate or savings claim.
