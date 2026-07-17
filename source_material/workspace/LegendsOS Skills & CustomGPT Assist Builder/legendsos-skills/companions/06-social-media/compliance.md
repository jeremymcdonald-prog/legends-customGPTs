# Compliance — Social Media

Reference `_shared/brand-dna/compliance-pack.md` and `_shared/brand-dna/nmls-eho-footer.md` for canonical rules. Skill-specific additions below.

## Hard blocks

The skill must refuse to emit a post that contains any of the following without a documented source or approval:

- A real customer first name, last name, initials, or identifiable nickname
- A real Realtor name (unless they are an approved co-branded partner with written sign-off)
- A property address, street name combined with a city, or MLS number
- A specific interest rate without APR and assumptions
- A specific payment, savings, or cash-to-close figure
- A "lowest rate", "best rate", "guaranteed approval", "free", or "no cost" claim
- A direct quote from a Zillow or Google review unless the review is verified public AND the post clearly references it as a public review
- A claim that VA, FHA, USDA, or any agency endorses Loan Factory
- A guarantee dollar amount on the image without verified live config
- A guarantee post targeted to Washington

## Required additions per topic

| Topic | Required line |
|---|---|
| Rate quote (when used) | "APR is X.XX percent based on these assumptions. Rates and terms subject to change without notice." |
| VA | "VA is a government benefit program. This communication is not affiliated with or endorsed by the VA." |
| FHA | "FHA loans are subject to FHA program guidelines and credit approval." |
| USDA | "USDA Rural Development loans subject to property and borrower eligibility." |
| DSCR / investor | "For business-purpose lending. Terms differ from consumer loans." |
| $1,000 Lowest Rate and Fee Guarantee | Full block from `_shared/brand-dna/guarantee-terms.md`, including "All states except Washington." |
| Credit topic | "This is not credit repair or legal advice." |

## Footer block (paste at the end of every mortgage-related caption)

```
Jeremy McDonald
The Legends Mortgage Team powered by Loan Factory
NMLS 1195266 | Loan Factory NMLS 320841
Equal Housing Lender
904-442-3213 | mcdonald-mtg.com
```

## Risk tier defaults

| Post type | Default tier |
|---|---|
| Personal brand, lifestyle, fitness, family | Green |
| Motivational, leadership, team momentum | Green |
| Mortgage education, broker advantage, market commentary | Yellow |
| Story-based borrower or Realtor content | Yellow |
| Guarantee, rate, savings, VA-specific | Red — owner sign-off required before publish |
| Anything mentioning a real customer | Red — written approval required before publish |

## Skill behavior

- If a hard block fires, emit a `COMPLIANCE BLOCK` note instead of the post and tell the user what is missing.
- If a Yellow item fires, emit the post with a `REVIEW REQUIRED` tag at the top.
- If a Red item fires, emit a `DRAFT — APPROVAL REQUIRED` tag and refuse to mark it Ready in the tracker.
