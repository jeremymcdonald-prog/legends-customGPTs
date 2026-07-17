# Story Risk Scoring

How to assign the risk tier on a story record.

## Default

Yellow.

A borrower scenario, anonymized, with a clear lesson and no numbers, is Yellow.

## Move to Red if any of these are true

- A first name, last name, or initials is on the record AND permission_status is not `written`.
- An address (street + city, or MLS) is on the record AND deal-public + approval is not confirmed.
- A specific rate is in the lesson summary AND APR + assumptions are not paired.
- A specific savings number is in the lesson summary AND the "estimates only, individual results vary" line is missing.
- A guarantee dollar amount is in the lesson summary AND verified current config is not on file.
- A competitor is named in the lesson summary.
- A protected attribute is in the lesson summary.

## Move to Green only if all of these are true

- No mortgage data referenced.
- No customer name.
- No identifiable Realtor or partner name.
- Lesson is about AI workflow, leadership, or personal brand.
- No compliance footer required for that story.

## Risk drives the publish gate

| Tier | Gate |
|---|---|
| Green | Standard review, can publish via normal weekly batch |
| Yellow | Standard review + skill checks `do_not_publish_until` is empty |
| Red | Owner sign-off required; cannot be marked Ready in the production tracker without Jeremy's approval |

## Rescore on edit

Any edit to the lesson summary triggers a rescore. If the edit moves the tier up, the gate resets and the publish-ready state clears.

## Audit trail

Risk tier changes are logged. The Story Bank does not silently downgrade a story; downgrading is an operator action with a note.
