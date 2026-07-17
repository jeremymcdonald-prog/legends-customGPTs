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

## 2026-07-17 — GPT Factory refactor validation

### Passed

- Core structure: all twelve required modules exist and each contains a README; canonical YAML and JSON files parse successfully.
- Identity deduplication: Jeremy's phone, email, personal website, team website, Apply Now URL, and both NMLS values occur only in the approved profile outside the immutable source archive.
- Shared-source deduplication: CTA library, routing engine, compliance checklist, lead-capture engine, and OpenAPI each have one regular canonical runtime source; legacy paths are valid symbolic compatibility links.
- Audience Engine: exactly nine required audiences resolve every required tone, starter, CTA, routing, compliance, Action, privacy, disclosure, and response-style property.
- Shared engines: thirteen compliance topics, one inherited checklist, twelve conversation stages, eighteen CTA variants, ten lead-capture behaviors, fifteen routing tests, and fifteen Action contract tests are present.
- Manifest/OpenAPI: the manifest template satisfies its schema; builder manifests pass schema and cross-field rules; the OpenAPI operation, fifteen required request fields, unknown-field rejection, consent gate, and prohibited-field exclusion pass.
- Snapshot generation: profile inheritance, Realtor-to-lender routing, generated disclosure, consent, all applicable CTAs, Apply Now suppression, inactive/missing assignment failure, and one-source regeneration pass.
- Factory build: a synthetic temporary package contains every required file, directory, and generated snapshot; no production package was created.
- Reproducibility: identical inputs produce the same package tree digest; changing a shared core module changes the dependency fingerprint.
- Portfolio propagation: the blueprint registry rebuilds every registered synthetic package and validates all blueprints before writing.
- Export boundary: all eight declared platform configurations validate and produce the correct generated export mapping without changing core behavior.
- Security and repository quality: authored Markdown links resolve, secret-pattern scan passes, no sensitive lead field is exposed by OpenAPI, and compatibility links resolve.
- Scope and preservation: zero individual GPT package directories exist, the Top 15 report still contains fifteen recommendations, and `source_material/` has no staged change.
- Clean build: all Ruby files pass syntax checks; the complete staged diff passes `git diff --cached --check`.

### Not validated / intentionally deferred

- Behavior of an individual GPT was not evaluated because this refactor intentionally created no production blueprint or package.
- No live OpenAI, Claude, Gemini, Copilot, Open WebUI, AnythingLLM, OpenHands, or local-model import was attempted.
- No Action endpoint, authentication, destination adapter, CRM, live privacy URL, or lead submission was deployed or tested.
- Curated production knowledge remains a scaffold and was not approved for a first package.
- Formal Loan Factory compliance, security, privacy, legal, licensing, and operational approval remains required.

## 2026-07-17 — GPT Factory v1.0.0 release validation

### Passed

- Release metadata: `VERSION` is exactly `1.0.0`; `CHANGELOG.md` includes the dated v1.0.0 architecture, engine, build, validation, export, and dynamic-README release summary.
- README generation: Ruby syntax and configuration validation passed; generation succeeded; `--check` passed; two unchanged runs produced identical SHA-256 output and no second Git diff.
- README statistics: 12 core modules, 9 audiences, 13 compliance topics, 18 CTAs, 15 routing tests, 15 Action tests, 8 export targets, 0 planned packages, 0 built packages, 0 approved packages, and 657 archived source files independently matched configured sources.
- README content: all configured local links resolve; quick-start commands map to real executable Ruby scripts and accepted syntax; Top 15 names/scores match the decision report; audiences and exports match their YAML sources; lifecycle tables match the absence of package manifests.
- Sensitive-content boundary: no recognized secret or private-key pattern, SSN-like value, borrower contact field, hidden environment value, raw archive filename, or raw archive content was introduced into `README.md`.
- Existing suites: Factory validation, core/profile deduplication, contact snapshot generation, identity inheritance, assigned-lender routing, lead Action/OpenAPI contract, synthetic package build, manifest validation, reproducibility, portfolio rebuild, all eight exporters, dependency fingerprints, and launch gates passed.
- Scope: the Top 15 report and 657-file source archive remain unchanged; no individual GPT package, live lead endpoint, secret, platform deployment, or CRM integration was created.
- Repository quality: all Ruby files pass syntax checks, configured YAML parses, generated local Markdown links resolve, and the final release diff passes Git whitespace validation.
- Git release: one focused commit was created on `main`; the annotated `gpt-factory-v1.0.0` tag and commit were pushed to `origin`; local `main`, `origin/main`, and the remote tag were verified after push.

### Not validated / intentionally deferred

- Individual GPT behavior and production knowledge, because this release intentionally contains no product package.
- Live OpenAI, Claude, Gemini, Copilot, Open WebUI, AnythingLLM, OpenHands, or local-model import behavior.
- Live lead submission, endpoint authentication, routing destination, CRM write, public privacy URL, retention/deletion operation, monitoring, and rollback.
- Formal approval by Loan Factory compliance, privacy, security, legal, licensing, data, and operational owners.
