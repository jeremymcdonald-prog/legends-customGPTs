# Contact and referral routing standard

**Owner:** GOAT Architect
**Effective:** 2026-07-17
**Applies to:** every Legends Custom GPT package

## Source of truth

People and lending-partner relationships are stored once in `config/profiles/*.yaml`. A completed GPT package resolves its manifest and source profiles into these package snapshots:

```text
gpts/<gpt_slug>/generated/contact_profile.md
gpts/<gpt_slug>/generated/compliance_identity.md
gpts/<gpt_slug>/generated/call_to_action_library.md
gpts/<gpt_slug>/generated/referral_routing.md
```

Generated files are never edited directly. Update the source YAML or manifest and rerun `scripts/generate_contact_snapshots.rb`. Do not hardcode contact details, NMLS identifiers, Apply Now links, or lending assignments across instructions and knowledge files.

## Ownership modes

| Owner type | Visible identity | Mortgage recipient |
|---|---|---|
| `jeremy` | Jeremy McDonald | Jeremy McDonald |
| `loan_officer` | The owning loan officer | `owner_profile_id` |
| `realtor` | The Realtor and brokerage remain visible for real estate | `assigned_lending_partner_profile_id` |
| `team_shared` | Approved team identity | A selected active loan officer or approved team routing endpoint |

A team-shared GPT must not enable mortgage routing until its assigned loan officer or approved routing endpoint is selected. A Realtor profile references its lender by profile ID and never duplicates lender contact or application data.

## Routing rules

1. Jeremy-owned mortgage CTAs and leads route to Jeremy.
2. Loan-officer-owned mortgage CTAs and leads route to `owner_profile_id`.
3. Realtor-owned GPTs preserve the Realtor's visible real-estate identity. Mortgage questions, financing, preapproval, payment scenarios, Apply Now requests, and mortgage leads route to `assigned_lending_partner_profile_id`.
4. Team-shared GPTs route only to the selected active loan officer or an approved team routing endpoint.
5. `apply_now_behavior: show_owner_link` resolves the licensed owner's approved URL.
6. `apply_now_behavior: show_assigned_lender_link` resolves the assigned licensed lender's approved URL.
7. `apply_now_behavior: no_application_link` does not display an application link.

## Consumer disclosure and consent

Before asking for confirmation, tell the consumer which licensed professional will receive the information. Resolve and display this prompt with the assigned profile values:

> Your information will be sent securely to [Loan Officer Name] with [Company Name] so they can respond to your mortgage request. Would you like me to submit it?

Call the lead Action only after a clear affirmative response. Silence, continued conversation, an ambiguous reply, or merely providing contact details is not consent. There is no silent lead submission.

## Safe intake boundary

The GPT may collect only the approved low-risk fields defined in `actions/lead_capture/FIELD_MAPPING.md`. It must never ask for or accept Social Security numbers, bank account numbers, credit card numbers, passwords, full dates of birth, tax returns, bank statements, government IDs, or uploaded financial documents.

A lead submission is not a mortgage application, preapproval, approval, rate lock, qualification decision, or lending commitment. Direct anyone ready for a full application to the assigned loan officer's generated Apply Now URL.

## Failure behavior

If the Action fails or its routing assignment cannot be validated, say that the request was not submitted. Provide the assigned licensed loan officer's generated phone, email, and Apply Now URL. Never claim success without a successful Action response.

## Validation command

```bash
ruby scripts/generate_contact_snapshots.rb \
  --owner-profile jeremy_mcdonald \
  --output-dir /tmp/legends-contact-snapshot
ruby scripts/test_contact_snapshot_generation.rb
```
