# Example 03 — Automation Workflow Risk Review (Tier 3 input)

## Input

> Risk-review this automation: a form where LOs flag a slow lender and the system auto-emails the lender AE under our name with an AI-written body.

## Output

**1. EXECUTIVE VERDICT**
Hold. This is a Tier 3 Red workflow as designed. The auto-send under Loan Factory's name with an AI-written body cannot ship in this shape. The intake form is fine. The send mechanic has to change to draft-and-approve before this can move.

**2. BOARDROOM WORKFLOW SELECTED**
Workflow 11 — Automation Workflow Risk Review. Operational Council. Architect, Data, Compliance, Operations/TERA, Risk, CTO active.

**3. ADVISOR SEAT REVIEWS**
- **Architect Seat:** the LO feedback form belongs in TERA's data model (or Airtable as middle layer), not in a standalone tool with its own contact list. As scoped, this risks an orphan system. R2.
- **Data Seat:** free-text LO complaints touching lender names and possibly loan numbers is borrower-adjacent. Any AI step must run in-stack (Claude), with PII redaction before classification.
- **Compliance Seat:** an AI-written external email under Loan Factory's name, sent without human review, fails on sender-identity, NMLS disclosure, and external-send approval. Multiple keywords likely to trigger pause routing (RESPA, lender, escalation).
- **Operations/TERA Seat:** the lender AE on the other end has no idea this email came from an AI. That's a relationship risk, not just a compliance one. If the message lands wrong, the AE relationship is harder to repair than the original lender problem.
- **Risk Seat:** R10 squarely triggered (autopilot risk on external communication). Also R4 (unapproved content drift), and R8 (overbuilding before manual is proven).
- **CTO Seat (would Thuan ship this?):** not in this shape. Documented, defensible, pointed at a real platform feature? The form yes. The auto-send no.

**4. POINTS OF AGREEMENT**
Every seat agrees the intake side is fine and useful. The send side is the problem.

**5. POINTS OF CONFLICT**
None inside the board. The conflict is between the design intent (speed of escalation) and the regulatory + relationship realities of external lender communication.

**6. HIDDEN RISKS**
- **Tier 3 Red** (active lender escalation + AI-written external email under Loan Factory's name).
- **R2** orphan systems (form data lives outside TERA).
- **R4** unapproved content drift (AI-written body goes external without review).
- **R8** overbuilding (manual lender escalation isn't proven inside the team yet).
- **R10** autopilot risk on external communication.
- GLBA / borrower-privacy risk if any LO feedback references active loans.

**7. BEST OPPORTUNITY**
Rebuild as a routed intake + draft-and-review workflow. The form captures the signal. Claude drafts a redacted-PII suggestion. A human owner approves. Then it sends, with audit log. Same speed lift, none of the legal exposure. This is genuinely a useful platform feature once the gate is added.

**8. RECOMMENDED DECISION**
Hold and redesign.

**9. PRIORITY FIXES (ranked)**
1. Move the form data into TERA (or Airtable as middle layer) so the LO record, lender, and routing live in one shared source. Kills R2.
2. The AI body is generated as a draft only. It writes to a queue. It never sends.
3. A named human owner (per lender or by region) reviews and approves the draft. Their email account sends, with "Sent on behalf of [LO name]" if relevant. Full audit log + routing record per message.
4. PII redaction step before any AI call: scrub loan numbers and borrower names before the body is drafted.
5. Keyword filter in front of any external send: pause and route to Compliance on RESPA, TILA, CFPB, fair lending, discrimination, attorney, lawsuit, predatory, OFAC.
6. Manual-first: run the manual version for 30 days. Only automate once the manual flow has shown it works and the failure modes are known.

**10. FINAL ACTION PLAN**
- Today: stop building the auto-send. Spec the manual version of the lender feedback intake + draft-and-approve flow.
- This week: build the form into TERA/Airtable. Define the human owner per lender.
- Next 30 days: run the manual version. Capture every escalation as an audit row.
- After 30 days, with proof the manual version is working: layer in the Claude-drafted body, keep the human approval, keep the audit log + routing record, keep Tier 3 controls in writing.

Let me know what you'd like me to do next.
