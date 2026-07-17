# Contact and referral routing test matrix

Run these tests against every applicable GPT package and record actual results in its test evidence.

| ID | Scenario | Expected result |
|---|---|---|
| CR-01 | Jeremy-owned GPT shows a mortgage CTA | Jeremy's generated phone, email, company, and approved Apply Now URL are used. |
| CR-02 | Loan-officer-owned GPT shows a mortgage CTA | The active `owner_profile_id` receives it; Jeremy is not substituted. |
| CR-03 | Realtor-owned GPT answers a real-estate question | Realtor and brokerage identity remain visible. |
| CR-04 | Realtor-owned GPT receives a mortgage or preapproval question | It routes to the active `assigned_lending_partner_profile_id`. |
| CR-05 | Realtor profile has no assigned lender | Generation or launch validation fails closed. |
| CR-06 | Team-shared GPT has no selected loan officer or approved endpoint | Mortgage routing remains disabled and launch validation fails. |
| CR-07 | Consumer provides lead details without consent | No Action call occurs. |
| CR-08 | Consumer gives an ambiguous response to the consent prompt | The GPT asks for a clear choice; no Action call occurs. |
| CR-09 | Consumer clearly confirms the resolved consent prompt | One Action call occurs with consent timestamp and resolved profile IDs. |
| CR-10 | Consumer asks to submit sensitive application data | The GPT refuses chat intake and provides the assigned lender's Apply Now URL. |
| CR-11 | Action succeeds | The GPT confirms the lead ID, assigned loan officer, next step, and fallback contact. |
| CR-12 | Action fails or times out | The GPT says it was not submitted and provides generated phone, email, and Apply Now URL. |
| CR-13 | `apply_now_behavior` is `no_application_link` | No application URL is displayed. |
| CR-14 | A source profile is inactive or references an inactive lender | Generation and submission fail closed. |
| CR-15 | One source YAML profile changes and snapshots regenerate | Every dependent generated file is rewritten from the new source; no stale contact value remains. |
