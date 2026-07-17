# GPT manifest

Copy this template into a GPT package as `manifest.md`, replace every placeholder, and validate profile references before launch.

```yaml
gpt_id: REQUIRED_UNIQUE_GPT_ID
version: REQUIRED_SEMANTIC_VERSION
owner_type: "REQUIRED: jeremy | loan_officer | realtor | team_shared"
owner_profile_id: REQUIRED_ACTIVE_PROFILE_ID
audience_type: "REQUIRED: internal | loan_officer | realtor | consumer | mixed"
assigned_lending_partner_profile_id: "REQUIRED_FOR_REALTOR_OR_TEAM_SHARED_MORTGAGE_ROUTING"
mortgage_routing_enabled: false
lead_capture_enabled: false
public_or_internal: "REQUIRED: public | internal"
compliance_level: REQUIRED_COMPLIANCE_CLASSIFICATION
privacy_policy_required: false
apply_now_behavior: "REQUIRED: show_owner_link | show_assigned_lender_link | no_application_link"
```

Rules:

- `owner_type: realtor` requires an active `assigned_lending_partner_profile_id`; mortgage CTAs, financing questions, and leads route to that licensed loan officer.
- `owner_type: team_shared` requires a selected active loan officer or an approved team routing endpoint before mortgage routing is enabled.
- Public lead capture requires `privacy_policy_required: true`, a valid public privacy-policy URL in the Action configuration, and explicit consumer consent before submission.
- `show_owner_link` is valid only when the owner profile is a licensed lending profile with an approved Apply Now URL.
- `show_assigned_lender_link` resolves the assigned lender profile; an application URL is never copied into a Realtor profile.
- Generated snapshots in `generated/` are outputs. Edit the source profile or manifest and regenerate them; never edit a snapshot directly.
