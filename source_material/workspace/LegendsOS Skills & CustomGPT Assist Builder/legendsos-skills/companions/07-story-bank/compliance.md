# Compliance — Story Bank

Reference `_shared/brand-dna/compliance-pack.md`. Skill-specific:

## The five non-negotiables

1. No invented customers, reviews, names, addresses, rates, payments, credit scores, income, or assets.
2. No customer names unless `permission_status = written` is recorded on the source.
3. No word-for-word review reposts unless `source_url` is set AND the post clearly cites the source as a public review.
4. No "we saved them $X" claims unless paired with "Estimates only. Individual results vary. Not a commitment to lend."
5. No mention of competitor lenders by name. Use "a retail lender" or "a national bank" framing.

## Permission status

| Value | Meaning |
|---|---|
| `none` | No permission on file. Default. Anonymize. |
| `verbal` | Customer said yes in conversation but not in writing. Not enough to name. |
| `written` | Signed permission on file (email reply with the consent line counts). Required to name. |

## Privacy gate (must pass before status moves to Approved)

- Name redaction confirmed.
- Address redaction confirmed.
- Numbers (rate, payment, credit, income) redacted.
- Lesson is documented.
- Risk tier is set.
- Program-specific line attached if VA / FHA / USDA / DSCR.
- Source URL captured if public.

## Review reframe defaults

When intaking a public Zillow or Google review:

- Default to lesson-frame, not testimonial repost.
- If the reviewer named is being reposted verbatim, treat as Yellow with cite.
- If a competitor is mentioned in the review, scrub the competitor name before reuse.
- If the review names sensitive details (rate, loan amount), strip those.

## Source records are append-only

A source record never gets deleted. Status moves through Draft → Anonymized → Approved → Public → Retired. Retired entries stay searchable for audit.
