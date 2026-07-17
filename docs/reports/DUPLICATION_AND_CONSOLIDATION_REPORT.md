# Duplication and consolidation report

## Decision summary

The workspace does not lack GPT ideas; it has overlapping prompts, exported package copies, and versioned Realtor knowledge. Preserve raw provenance, but build from a curated canonical layer and consolidate concepts before implementation.

No approved source variant was silently selected. All 658 in-scope files were reviewed; 657 remain under `source_material/workspace/` and are mapped by SHA-256. One borrower-identifiable pipeline reconciliation report was intentionally excluded and recorded in the inventory. Production knowledge must not point at all raw variants at once.

## Exact duplication findings

- 658 reviewed files; 657 copy-preserved files.
- 584 unique contents.
- 74 duplicate copies across 63 exact-content groups.
- The largest exact groups contain four copies; most are two-copy export mirrors.

| Duplicate family | Finding | Canonicalization recommendation |
|---|---|---|
| `realtor_cobranded_marketing_gpt_knowledge`, ` 2`, ` 3`, ` 4` | Four evolving directories contain exact copies plus meaningful MND, licensing-handoff, asset, and V4 differences. | Preserve all raw versions. Treat the unnumbered V4 directory as the leading candidate only after a file-by-file compliance-owner review. Create one curated `knowledge/real_estate/realtor-co-marketing/` release. |
| `LegendsOS_GPT_Packs/` and `legendsos/legendsos-v2/exports/gpt_packs/` | Marketing Image Coach and Setup Coach packages are mirrored exports. | Use `LegendsOS_GPT_Packs/` as research provenance; do not attach both copies to a GPT. Curate into new packages and retain content hashes. |
| `CREATE_GPT_IMAGES_PROMPTS` and `GPT_BUILDER_COPY_PASTE_FIELDS` variants | Numbered and exported copies repeat identical builder material. | One canonical template should replace all copies for new work; preserve originals under source material. |
| Pipeline knowledge and Claude skill reference | The same pipeline knowledge exists at two paths. | Keep one approved version in the future Pipeline GPT package and link the skill to it; avoid independent edits. |
| 60-day machine connector audit and skills docs audit | Same content is stored as output and as reusable documentation. | Canonical reusable docs live in curated knowledge; production reports link to the exact version used. |
| RealtorGPT markup changelogs | Two paths contain the same markup log. | Keep both raw; reference one canonical changelog when curating that source family. |

## Concept-level overlap

| Overlapping concepts and sources | Problem | Consolidated GPT |
|---|---|---|
| Legends Processing Assistant, Legends Pipeline Assistant, processor condition management | Separate pipeline Q&A, record actions, processing support, and borrower drafts would create conflicting status and send rules. | **Legends Pipeline & Processing Copilot** |
| Realtor Relationship Expert, Real Estate Marketing Pro, Personal Realtor AI Twin, Realtor newsletter agent, Realtor co-marketing V1–V4 | They repeat outreach, newsletter, listing, brand-voice, and co-brand responsibilities. | **Legends Realtor Co-Marketing & Partner Growth Studio**, with shared Brand Voice profiles |
| Social Media Guru, First-Time Buyer Post Creator, Email Newsletter Assistant, 60-day content engine | Content types are split by old assistant names rather than a reusable intake/repurposing workflow. | **Legends Mortgage Content Repurposing Studio** |
| Marketing Image Coach, Image Studio, Canva Template System, HeyGen, Higgsfield, Visual Intelligence, B-Roll | Each owns a production step, but users need one asset brief and coordinated output. | **Legends Visual & Video Production Coach** |
| Business Personality Pro, Personal AI Twin, team personas and memory seeds | Voice profiles are duplicated in standalone prompts and documents. | **Legends Brand Voice & AI Twin Studio** as a shared service |
| Mortgage Coaching Assistant, Realtor Coach, persona training, recruiting/onboarding work | Coaching is separated by audience even though the workflow is assessment, roleplay, plan, and follow-up. | **Legends Team Growth & Coaching Assistant** with role modes |
| Mortgage Market Master, market-update translator, MND context rules, rate-environment docs | Market explanation is fragmented from sourcing and compliance. | **Legends Market & Rate Translator** |
| RE Investor Master, DSCR, BRRRR and investor webinar sources | Strategy and financing calculations overlap. | **Legends Investor & DSCR Deal Desk** |
| Setup Coach, Integrations Setup, GHL, n8n, Zapier, webhook docs | Broad setup material repeats vendor steps and becomes stale. | **Legends Integrations Setup Coach**, bounded to approved vendors |
| Podcast Guru, YouTube Intelligence, story and repurposing workflows | Ideation, production, clips, and distribution are separate. | **Legends Podcast & Long-Form Content Producer** |

## Concepts that remain separate

- **Pipeline & Processing** remains separate from **Loan Scenario & Structuring**. One owns operational records and communication; the other organizes scenario analysis against authoritative lending sources.
- **Content Repurposing** remains separate from **Visual & Video Production**. One owns message/channel copy; the other owns asset-production specifications and media QA.
- **Market & Rate Translator** remains separate from the official pricing/guideline systems. It explains cited context; it does not quote or price loans.
- **Borrower Education Concierge** remains separate from every internal GPT. It must not receive operational data or internal tool access.
- **Executive AI Boardroom** remains an internal decision system, not an all-purpose router or mortgage knowledge assistant.

## Canonical source precedence

When curating production knowledge, use this order:

1. Current official Loan Factory/compliance/licensing/product source with owner and effective date.
2. Approved repository knowledge release with owner, review date, and hash.
3. Most recent clearly versioned first-party source after conflict review.
4. Older/raw source for historical context only.
5. Third-party material only when licensed, authoritative for the claim, cited, and current.

If two sources conflict, do not merge by intuition. Record the conflict in `Open_Issues.md`, assign an owner, and prevent the disputed claim from shipping.

## Consolidation procedure

1. Select one approved GPT job and audience boundary.
2. List all source variants and exact hashes from `SOURCE_DOCUMENT_MAP.md`.
3. Diff same-name/version families and identify conflicts.
4. Have the business/compliance owner select authoritative language and current facts.
5. Create a curated knowledge release with provenance and expiration metadata.
6. Build one package from the standard template.
7. Run regression tests derived from every retired concept’s unique behavior.
8. Archive superseded packages with replacement links; do not delete history.

## Expected portfolio reduction

The legacy guide alone names 15 assistants, and the companion spec names nine plus internal tools. Consolidation does not mean only 15 GPTs can ever exist; it means the first portfolio should have 15 clearly differentiated jobs rather than dozens of overlapping prompts. The ranked report identifies those 15 and defers the riskiest or most duplicative concepts.
