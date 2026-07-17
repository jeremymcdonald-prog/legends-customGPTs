# Customer Privacy Rules

The default is privacy. Everything else is an exception.

## What is always anonymized

- First name
- Last name
- Initials
- Nickname
- Email
- Phone
- Property address (street, city pair, MLS number)
- Loan number
- Lender names attached to the borrower
- Realtor name attached to the borrower (unless approved co-brand)
- Credit score
- Income figure
- Asset value
- Down payment dollar amount
- Closing cash amount
- Specific rate
- Specific payment
- Specific PMI / MIP / mortgage insurance number

## What can be referenced generically

- Program (VA, FHA, USDA, conventional, DSCR, jumbo, non-QM)
- Loan purpose (purchase, refinance, cash-out, rate-and-term)
- City or county at the regional level (e.g., "St. Johns County")
- Buyer type (first time, move up, investor, Veteran)
- Realtor type (listing agent, buyer agent) without naming
- Approximate timeline ("closed in a week")

## What unlocks naming

- Written permission on file. A reply email saying "yes, please share my story" counts.
- The permission record is stored as `permission_record` on the source.

## What unlocks address use

- Deal is already publicly marketed (MLS listing live and acknowledged by the parties).
- Written approval to use the address in marketing.

## What unlocks rate/payment quotes

- The post explicitly quotes APR and assumptions.
- The piece carries "rates and terms subject to change without notice."
- The piece carries "not a commitment to lend. All loans subject to credit approval."
- The piece is owner-approved (Red tier).

## Protected attributes

The Story Bank does not store protected attributes (race, ethnicity, national origin, religion, age, sex, sexual orientation, gender identity, immigration status, disability, serious illness, union membership) about a borrower, even in internal notes.

## Audit

- Every privacy-gate run is logged on the source record (`last_reviewed` updates).
- If a privacy violation is found post-publish, the source is moved to `retired` and the downstream skills are told to stop using the source ID.
