# CAN-SPAM Footer Block

Used by `companions/04-email-newsletter` and any public email send. Append this block (or its values) to every public email footer.

## Required elements

| Element | Required |
|---|---|
| Physical mailing address | Yes (Loan Factory or Jeremy's verified business address) |
| Working unsubscribe link | Yes |
| Truthful, non-deceptive subject line | Yes |
| Clear identification of who sent it | Yes (Loan Factory + LO when relevant) |
| NMLS #320841 + EHO | Yes (overlap with compliance pack) |

## Subject line rules

- No bait-and-switch.
- No false urgency ("ACT NOW OR LOSE EVERYTHING").
- No misleading "Re:" or "Fwd:" prefixes if not actually a reply or forward.
- Length target: under 50 characters when possible.

## Preview text

Required. Should preview the actual content. Not deceptive. Not a duplicate of the subject.

## Unsubscribe rules

- Link must work for at least 30 days after send.
- Honor unsubscribes within 10 business days.
- No fee, no extra steps, no "log in to manage preferences" trap as the only option.

## Sample compliant footer (PASTE)

```
You're getting this because you connected with Jeremy McDonald or The Legends Mortgage Team.
Don't want these? Unsubscribe: {{unsubscribe_link}}

Legends Mortgage Team | Powered by Loan Factory
Equal Housing Lender · NMLS #1195266 · Loan Factory NMLS #320841
{{business_mailing_address}}

This is not a commitment to lend. All loans subject to credit approval. Rates, terms, and fees subject to change without notice.
```

## Hard rule

No public-marketing email ships without an unsubscribe link, a real mailing address, and the standard compliance strip. The Email Newsletter skill's compliance gate blocks any draft missing these.
