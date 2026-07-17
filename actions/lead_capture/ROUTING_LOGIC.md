# Routing logic

The server, not the GPT, is the final routing authority.

1. Authenticate the Action request and enforce rate, replay, and schema controls.
2. Require explicit consent and a valid consent timestamp.
3. Resolve `source_gpt_id` to an approved manifest and compare its owner/routing configuration with the request IDs.
4. Resolve every profile from the approved active profile store.
5. Apply the owner rule:
   - `jeremy`: recipient is Jeremy's active lending profile.
   - `loan_officer`: recipient is the active `owner_profile_id`.
   - `realtor`: recipient is the active `assigned_lending_partner_profile_id`; preserve the Realtor as referral source.
   - `team_shared`: recipient is the selected active loan officer or approved team routing endpoint.
6. Validate that the resolved recipient is licensed for the applicable operational route before acceptance; state licensing policy requires current compliance ownership.
7. Deduplicate, persist only approved fields, create a payload-free audit event, and deliver through the configured destination adapter.
8. Return contact and Apply Now values from the validated licensed lender profile.

Fail closed on any profile mismatch, inactive profile, missing assignment, invalid consent, unavailable destination, or unresolved routing rule. Never silently reroute a consumer to a different person.
