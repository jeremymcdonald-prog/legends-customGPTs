# Persona Builder Integration Notes

## 1. How This Builder Should Plug Into The AI Twin Generation Flow

The persona builder should sit between intake collection and document generation.

Recommended flow:

1. User completes intake.
2. System assembles the available intake payload.
3. Persona builder generates a structured persona object using `PERSONA_BUILDER_SYSTEM.md` and `PERSONA_BUILDER_OUTPUT_SPEC.md`.
4. Persona output is validated against `PERSONA_BUILDER_SCHEMA.json`.
5. Validated persona output is stored as a reusable generation context object.
6. Document generation uses:
   - raw profile data
   - persona selection overlay
   - canonical source docs
   - validated persona builder output
7. Compliance and review rules remain higher priority than persona guidance.

In the current repo, this logically fits alongside the existing sequence used by:

- [services/profile.ts](/Users/JeremyMcDonald/Desktop/FOLDER%20FOR%20APPS%20AND%20WEBSITES%20I%20AM%20BUILDING/loan-factory-ai-twin-portal/services/profile.ts)
- [services/persona.ts](/Users/JeremyMcDonald/Desktop/FOLDER%20FOR%20APPS%20AND%20WEBSITES%20I%20AM%20BUILDING/loan-factory-ai-twin-portal/services/persona.ts)
- [services/generation.ts](/Users/JeremyMcDonald/Desktop/FOLDER%20FOR%20APPS%20AND%20WEBSITES%20I%20AM%20BUILDING/loan-factory-ai-twin-portal/services/generation.ts)
- [lib/ai/prompt.ts](/Users/JeremyMcDonald/Desktop/FOLDER%20FOR%20APPS%20AND%20WEBSITES%20I%20AM%20BUILDING/loan-factory-ai-twin-portal/lib/ai/prompt.ts)

## 2. What Intake Inputs It Needs

### Minimum current inputs available in the portal

- `firstName`
- `lastName`
- `nmlsId`
- `bioSummary`
- `specialties`
- selected persona overlay

### Recommended richer inputs for a better builder

- preferred borrower type
- explanation style prompt
- objection handling prompt
- follow-up cadence prompt
- sample email or text message
- rate/risk communication prompt
- team leadership style prompt, if applicable
- referral partner communication style, if applicable

The builder must still work when only the minimum set exists, but the output should then reflect lower confidence and more explicit gaps.

## 3. How Persona Output Should Influence Downstream Document Generation

The persona output should shape:

- tone
- level of explanation
- sentence density
- call-to-action style
- objection framing
- follow-up structure
- urgency level

The persona output should not shape:

- compliance claims
- underwriting certainty
- approval language
- rate promises
- legal positioning

Recommended prompt assembly order:

1. canonical source rules
2. compliance and review rules
3. document template purpose
4. validated persona summary
5. high-confidence twin directives
6. contradiction notes
7. gap-aware restrictions

Use only high-confidence or medium-confidence persona conclusions as real steering inputs. Low-confidence conclusions should appear only as soft hints or should be omitted entirely for outward-facing content.

## 4. What Should Happen If Persona Confidence Is Low

If overall persona confidence is low:

- keep document tone conservative and neutral
- rely more on canonical Loan Factory brand voice and template defaults
- suppress aggressive tone mirroring
- suppress strong behavioral claims in prompt assembly
- attach a `low persona confidence` flag for internal visibility
- optionally ask the user for richer intake before generating outward-facing materials

Practical rule:

- low-confidence persona data can guide phrasing lightly
- it cannot drive bold style shifts

## 5. What Should Happen If Contradictions Are High

If contradiction density is high:

- keep both sides of the hybrid when they are evidence-backed
- do not compress them into one simplified archetype
- generate hybrid directives only when the operational split is clear
- reduce confidence for any directive that depends on unresolved tension
- prefer neutral language for external documents
- flag the record for intake expansion or human review

Example:

If the subject is both "data-driven" and "gut-driven," the downstream system should not present the twin as purely analytical. It should instead use balanced decision framing and avoid overcommitting to a single style unless more evidence arrives.
