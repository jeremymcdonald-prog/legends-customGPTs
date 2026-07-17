# Next actions

## Single best next action

GOAT Architect should approve the internal-first first-five build order and authorize a scoped build brief for **Legends Pipeline & Processing Copilot v0.1**, using synthetic data and read-only pipeline access as the first release boundary.

## After approval

1. Name business, knowledge, compliance, and technical owners.
2. Curate the minimum approved knowledge set; do not point the GPT directly at the entire raw source library.
3. Instantiate the standard GPT package from `gpts/templates/`.
4. Write acceptance tests before enabling any Action.
5. Pilot with two or three internal users, measure time saved and correction rate, then decide whether to add writes.
