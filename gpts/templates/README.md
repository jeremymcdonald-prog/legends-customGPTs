# Reusable GPT package template

Create `gpts/<gpt-slug>/` with the exact structure defined in `docs/goat_architect/Architecture.md`.

## Package header

Every package begins with:

- Owner and backup owner.
- Audience: `internal`, `partner`, or `public-consumer`.
- Status: `planned`, `draft`, `pilot`, `approved`, `deprecated`, or `archived`.
- Semantic version.
- One measurable business outcome.
- Data classification and prohibited data.
- Capability settings and Action list.
- Knowledge sources with owners and review dates.

## Versioning

Use semantic versions: `MAJOR.MINOR.PATCH`.

- MAJOR: scope, audience, risk boundary, or Action behavior changes.
- MINOR: backward-compatible capability, knowledge, workflow, or test additions.
- PATCH: wording, examples, metadata, or non-behavioral fixes.

Tag approved releases as `<gpt-slug>-vX.Y.Z`. Record every change in the package `changelog.md` and include the tested knowledge snapshot version.
