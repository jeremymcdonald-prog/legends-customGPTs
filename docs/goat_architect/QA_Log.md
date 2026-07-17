# QA log

## 2026-07-17 — Foundation validation

### Passed

- Required foundation: 21 required files and 15 required directories present.
- Remote: `origin` is the requested SSH URL; local `main` tracked `origin/main`; fetch showed `0 ahead / 0 behind` before commit.
- Source review: 658 in-scope first-party Markdown documents fully scanned and inventoried.
- Source preservation: 657 approved documents copied; zero missing; zero SHA-256 mismatches.
- Privacy exclusion: one borrower-identifiable pipeline reconciliation report was reviewed but not copied; the exclusion is explicit in the inventory.
- Source map: 657 mapped rows; every mapped repository file exists and matches its recorded SHA-256.
- Inventory: 658 per-document rows covering every reviewed source.
- Portfolio report: exactly 15 numbered recommendations and exactly 15 score rows.
- Score arithmetic: all 15 totals equal the sum of the 15 factor scores; descending totals are `136, 134, 134, 130, 128, 126, 123, 122, 122, 119, 116, 116, 115, 109, 108`.
- First-five order matches the executive recommendation and build-order section.
- Authored Markdown: every local relative link outside the raw source archive resolves.
- Git whitespace check: authored/foundation changes pass `git diff --check`; original trailing whitespace inside byte-preserved source snapshots was intentionally not rewritten.
- Secret scan: no OpenAI, GitHub, Slack, AWS, Google API, or private-key patterns detected across committed-intent files.
- Binary/archive control: zero ZIP/TGZ/TAR.GZ files and zero files over 5 MB outside Git metadata.
- Mortgage-claim review: authored governance/reports contain prohibitions, risk descriptions, or requests for approved terms, not an unsupported approval/rate/payment/savings/terms promise. Raw source material is explicitly quarantined as unapproved research because it contains legacy and conflicting claim language.

### Not validated in this foundation mission

- Existing live Custom GPT configurations or external ChatGPT links.
- Behavior of any individual GPT; none was built.
- Live Actions, vendor APIs, credentials, pipeline access, email sends, calendars, CRM, pricing, guidelines, image generation, or publishing.
- Accuracy/currentness of raw mortgage, guarantee, licensing, market, vendor, or legal/compliance content.
- Formal approval by Loan Factory compliance, counsel, security, or data owners.
- Relative links inside raw source snapshots when they reference binaries or files intentionally not copied.

### Final Git validation

Commit hash, clean-worktree proof, remote non-divergence, and push status are recorded after the commit/push step.

## 2026-07-17 — Contact, referral, and lead-capture architecture validation

### Passed

- Central profile: Jeremy McDonald's full name, exact title, team role, company, phone, email, personal website, team website, individual/company NMLS values, Equal Housing flag, and Apply Now URL are present in one active YAML profile.
- Generator: Ruby syntax checks passed on the generator and test; `ruby scripts/test_contact_snapshot_generation.rb` passed.
- Generated snapshots: all four required files were produced in a temporary directory with the generated-file warning, exact approved Jeremy contact values, exact compliance sentence, explicit consent prompt, fallback contact, and one approved Apply Now URL.
- Regeneration: the test changed one source lender profile and verified that all four dependent files regenerated with the updated identity and no stale identity; a Realtor with a missing assigned lender failed closed.
- OpenAPI: YAML parsed successfully; `submitMortgageLead` exists once; all fifteen minimum request fields are required; unknown fields are rejected; the seven required response fields are defined.
- Sensitive-field boundary: none of the nine prohibited application fields is defined in `openapi.yaml`; the field and security docs explicitly prohibit them.
- Consent and privacy: the schema requires `consent_to_contact: true` and a timestamp; public-launch docs require a valid public privacy-policy URL and identify the current URL as a non-launch placeholder.
- Reusable coverage: ten lead-capture behaviors, ten CTA variants, fifteen GPT routing tests, fifteen Action tests, and sixteen security requirements are documented.
- Portfolio: exactly fifteen numbered recommendations and fifteen score rows remain; all fifteen now include ownership, profile, routing, Apply Now, lead suitability, privacy, consent, and fallback requirements.
- Links: all authored local relative Markdown links resolve. Jeremy's personal website, team website, and Apply Now URL each returned HTTP 200 on 2026-07-17.
- Formatting: `git diff --cached --check` passed across the complete staged change set.

### Not validated / intentionally deferred

- No Action endpoint was deployed or called; the server and privacy URLs are intentionally non-routable placeholders.
- No CRM or downstream destination was selected, connected, or tested.
- No secret or authentication value was created or configured.
- No team-member or Realtor production profile was supplied, so only Jeremy's production profile and synthetic temporary routing fixtures were tested.
- Loan Factory compliance, privacy, security, legal, licensing, data-retention, and operational owners have not approved a public launch.
