# Field mapping

## Required request fields

| Field | Purpose | Validation |
|---|---|---|
| `first_name` | Human follow-up | 1–80 characters |
| `last_name` | Human follow-up | 1–80 characters |
| `email` | Contact fallback | Valid email, at most 254 characters |
| `phone` | Contact fallback | 7–32 characters |
| `preferred_contact_method` | Follow-up preference | `phone`, `text`, or `email` |
| `inquiry_type` | Safe triage | Approved enum only |
| `buy_or_refinance` | Safe triage | `buy`, `refinance`, or `undecided` |
| `property_state` | Licensing/routing validation | Two-letter uppercase state code |
| `estimated_timeframe` | Follow-up context | 1–100 characters |
| `message` | Consumer's low-risk question | 1–1,000 characters; server content screening |
| `source_gpt_id` | Source audit | Active registered GPT ID |
| `owner_profile_id` | Ownership audit | Active registered profile ID |
| `assigned_lending_partner_profile_id` | Licensed recipient | Active licensed lending profile ID |
| `consent_to_contact` | Submission gate | Must be `true` |
| `consent_timestamp` | Consent evidence | Current ISO 8601 date-time |

## Optional low-risk fields

`first_time_buyer`, `veteran_status`, `estimated_credit_range`, `estimated_purchase_price`, and `estimated_down_payment_range` may be collected only when relevant and voluntary. They are educational context, not qualification inputs.

## Prohibited fields

Never request, accept, transmit, or map:

- `social_security_number`
- `bank_account_number`
- `credit_card_number`
- `password`
- `full_date_of_birth`
- `tax_return`
- `bank_statement`
- `government_id`
- `uploaded_financial_documents`

Direct full application and document intake to the assigned loan officer's approved secure Apply Now URL.

## Response fields

The Action returns `success`, `lead_id`, `assigned_loan_officer_name`, `next_step`, `apply_now_url`, `contact_phone`, and `contact_email`. All contact and application values must come from the server's validated active lender profile, not from untrusted request text.
