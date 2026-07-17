# Next actions

## Single best next action

GOAT Architect should approve the internal-first first-five build order and authorize a scoped build brief for **Legends Pipeline & Processing Copilot v0.1**, using synthetic data and read-only pipeline access as the first release boundary.

## After approval

1. Name business, knowledge, compliance, and technical owners.
2. Curate the minimum approved knowledge set; do not point the GPT directly at the entire raw source library.
3. Instantiate the standard GPT package from `gpts/templates/`.
4. Write acceptance tests before enabling any Action.
5. Pilot with two or three internal users, measure time saved and correction rate, then decide whether to add writes.

## Contact and lead-capture gates

1. Name the authoritative profile, licensing, privacy, security, compliance, API, and lead follow-up owners.
2. Add and approve active loan-officer profiles before assigning any Realtor or team-shared GPT.
3. For any public lead pilot, select the destination adapter and approve the public privacy policy, retention/deletion schedule, threat review, consent copy, and operational SLA.
4. Implement `submitMortgageLead` behind a secure external boundary; keep credentials in Action configuration and the server-side secret manager.
5. Run the Action contract tests and GPT consent/routing conversations before enabling lead capture.
