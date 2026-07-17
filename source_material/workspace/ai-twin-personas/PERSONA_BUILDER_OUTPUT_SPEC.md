# Persona Builder Output Spec

This document defines the exact persona output contract for the Loan Factory AI Twin Portal.

## Common Section Contract

Every section must return the following fields:

- `sectionName`: exact section label
- `summary`: concise plain-language conclusion
- `evidenceQuotes`: array of quotes or wording references with source fields
- `interpretation`: bounded operational meaning of the evidence
- `confidence`: object with `label` and `reason`
- `gaps`: array of missing-data or uncertainty notes

Additional rules:

- `summary` must be evidence-grounded and business-relevant.
- `interpretation` may go one step beyond the raw quote, but only within safe inference rules.
- `confidence.label` must be `high`, `medium`, or `low`.
- `confidence.reason` must explain why the label was assigned.
- `gaps` must be explicit when evidence is thin, conflicting, or absent.
- Only `AI Twin Build Directives` requires `twinDirectives`.

## Section Order

The output must always appear in this order:

1. Identity Summary
2. Communication Style
3. Sales Style
4. Behavioral Archetype
5. Decision Making Pattern
6. Emotional and Motivational Drivers
7. Language Patterns and Tone Signals
8. Contradictions and Hybrid Traits
9. AI Twin Build Directives
10. Confidence and Gaps

## 1. Identity Summary

- Purpose: Establish the subject's role, business lane, client orientation, and most reliable operating impression.
- Required evidence: At least one direct statement about role, audience, specialty, or working style. Strong versions should include two or more signals.
- Allowed inference level: Bounded operational inference only.
- Required confidence format: `{"label":"high|medium|low","reason":"..."}`.

## 2. Communication Style

- Purpose: Describe how the subject explains, structures, and delivers information.
- Required evidence: Quotes about explanation style, clarity, pacing, tone, borrower education, or message format.
- Allowed inference level: Bounded operational inference only.
- Required confidence format: `{"label":"high|medium|low","reason":"..."}`.

## 3. Sales Style

- Purpose: Describe how the subject advances decisions, handles conversion, and moves conversations forward.
- Required evidence: Quotes about urgency, qualifying, trust-building, objection handling, calls to action, or closing behavior.
- Allowed inference level: Bounded operational inference only.
- Required confidence format: `{"label":"high|medium|low","reason":"..."}`.

## 4. Behavioral Archetype

- Purpose: Provide a concise plain-language synthesis of the subject's overall working pattern.
- Required evidence: At least two supporting signals from earlier sections. Archetype language must stay operational, not clinical.
- Allowed inference level: Moderate bounded synthesis. No deep personality claims.
- Required confidence format: `{"label":"high|medium|low","reason":"..."}`.

## 5. Decision Making Pattern

- Purpose: Explain how the subject appears to weigh speed, detail, risk, options, and next-step commitment.
- Required evidence: Quotes about tradeoffs, risk, gut feel, data use, timing, or decision framing.
- Allowed inference level: Bounded operational inference only.
- Required confidence format: `{"label":"high|medium|low","reason":"..."}`.

## 6. Emotional and Motivational Drivers

- Purpose: Identify business-relevant drivers that shape communication and selling behavior.
- Required evidence: Quotes that indicate what the subject tries to protect, win, avoid, or deliver for clients or team members.
- Allowed inference level: Narrow business-motivation inference only. No therapy language or hidden motive narratives.
- Required confidence format: `{"label":"high|medium|low","reason":"..."}`.

## 7. Language Patterns and Tone Signals

- Purpose: Capture repeated wording habits that the AI Twin should mirror or avoid.
- Required evidence: Exact words, repeated phrases, sensory language, sentence habits, or tone cues from intake answers.
- Allowed inference level: Observation-first. Minimal interpretation only.
- Required confidence format: `{"label":"high|medium|low","reason":"..."}`.

## 8. Contradictions and Hybrid Traits

- Purpose: Preserve the subject's mixed or context-dependent traits without flattening them.
- Required evidence: The opposing quotes or wording references that create the tension.
- Allowed inference level: Observation-first plus limited operational synthesis.
- Required confidence format: `{"label":"high|medium|low","reason":"..."}`.

## 9. AI Twin Build Directives

- Purpose: Translate the persona into actionable downstream generation instructions.
- Required evidence: Directives must be traceable to evidence from the earlier sections. They must reflect communication, sales, objection handling, and follow-up behavior.
- Allowed inference level: Synthesis only from already-supported conclusions.
- Required confidence format: `{"label":"high|medium|low","reason":"..."}`.

Required directive coverage:

- writing tone
- sales communication
- objection handling
- follow-up style
- compliance-safe caution

## 10. Confidence and Gaps

- Purpose: Summarize overall persona reliability, unresolved ambiguity, and missing information that limits generation quality.
- Required evidence: Intake thinness, contradiction count, missing fields, or uneven support across sections.
- Allowed inference level: Observation-only.
- Required confidence format: `{"label":"high|medium|low","reason":"..."}`.

## Evidence Quote Format

Each `evidenceQuotes` entry must contain:

- `sourceField`
- `referenceType`
- `quote`

Allowed `referenceType` values:

- `exact_quote`
- `wording_reference`

## AI Twin Directive Format

Each `twinDirectives` entry must contain:

- `category`
- `directive`
- `confidenceLabel`

Recommended categories:

- `writing_tone`
- `sales_communication`
- `objection_handling`
- `follow_up_style`
- `relationship_management`
- `leadership_style`
- `content_pacing`
- `compliance_guardrail`
