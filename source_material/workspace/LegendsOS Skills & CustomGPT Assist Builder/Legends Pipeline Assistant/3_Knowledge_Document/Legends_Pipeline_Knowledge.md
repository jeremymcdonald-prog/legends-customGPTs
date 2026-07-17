# Legends Master Pipeline — Assistant Knowledge Document

**Purpose:** This document gives any AI assistant (a Claude Project, a ChatGPT Custom GPT, or Claude in Cowork) everything it needs to read and update Jeremy McDonald's mortgage pipeline and to draft and send borrower emails the right way. Drop it into the project/GPT's knowledge, connect the engine (see Section 8), and the assistant can run the pipeline.

**Owner:** Jeremy McDonald, The Legends Mortgage Team powered by Loan Factory. NMLS #1195266 (Jeremy) / #320841 (Loan Factory). Northeast Florida.

---

## 1. What this system is

The pipeline lives in one Google Sheet called **Legends_Master_Pipeline**. The **Master Pipeline** tab is the single source of truth... every borrower and lead has one row there. Stage tabs (Active Loans, Leads, etc.) are filtered copies that must stay in sync with the master.

An assistant using this knowledge can do four things:

1. **Answer questions** about any borrower or the pipeline as a whole.
2. **Update records** when Jeremy gives new information.
3. **Move records** between stages as loans progress.
4. **Draft borrower emails**, and after Jeremy approves, **send** them from jeremy@mcdonald-mtg.com.

---

## 2. The workbook

Spreadsheet ID: `1kJtbtNPj2BGd42HH3uulISBVIz6xFtIvSLsZuT23pOM`

Tabs:

| Tab | Role |
|-----|------|
| **Master Pipeline** | Source of truth. Every record, all categories. |
| Leads | Category = Lead |
| Preapproved | Category = Preapproved |
| Active Loans | Category = Active Loan |
| Past Clients | Category = Past Client (closed / historical) |
| Withdrawn | Category = Withdrawn |
| Dead Leads | Category = Dead / Denied |
| Closed Loans | Optional current-period closings view |
| Change Log | Audit trail. One row per edit. |
| Dashboard, Sources, Field Dictionary | Reference / rollup |

---

## 3. Record schema (34 columns, exact names and order)

Use these exact column names when reading or writing. Order matters for the sheet but you address fields by name.

1. **Record ID** — PIP-### unique id
2. **Category** — top-level bucket (see Section 4)
3. **Status** — current stage (see Section 5)
4. **Borrower Or Lead** — primary name
5. **Co Borrower**
6. **Primary LO** — loan officer
7. **Processor**
8. **Referral Source**
9. **Property Address**
10. **City**
11. **State**
12. **Loan Purpose** — Purchase, Refinance, etc.
13. **Loan Type** — FHA, VA, USDA, Conventional, Non-QM, etc.
14. **Lender**
15. **Loan Number**
16. **Sales Price**
17. **Loan Amount**
18. **Rate**
19. **Credit Score**
20. **DTI**
21. **Closing Date**
22. **Appraisal Status**
23. **Approval Status**
24. **Title Status**
25. **Insurance Status**
26. **Main Blocker** — the thing most likely to delay or stop the file
27. **Next Action** — the next practical move
28. **Owner** — who owns the next action (default Jeremy)
29. **Priority** — High / Medium / Low
30. **Last Known Activity**
31. **Follow Up Date**
32. **Confidence** — High (source doc), Medium (chat context), Low (name only)
33. **Source Summary** — why the row exists / evidence
34. **Source File** — document or chat the row came from

**Never invent loan facts.** If you do not know a value (rate, amount, address, score), leave it blank and say it needs backfill. Confidence should reflect how solid the information is.

---

## 4. Categories and stage routing

When Category changes, the record moves to the matching stage tab. The engine does this automatically; if you ever edit the sheet by hand, keep them in sync.

| Category | Stage tab |
|----------|-----------|
| Lead | Leads |
| Preapproved | Preapproved |
| Active Loan | Active Loans |
| Past Client | Past Clients |
| Withdrawn | Withdrawn |
| Dead / Denied | Dead Leads |
| Closed | Closed Loans (optional; freshly closed loans normally go to Past Client with Status Closed) |

Closed loans: per Jeremy, a funded loan becomes Category **Past Client** with Status **Closed** (that is his long-term nurture book). The Closed Loans tab exists if he wants a separate current-period view.

---

## 5. Standard Status vocabulary

Use these standard words. Normalize close synonyms to the standard (for example "Declined" becomes **Denied**).

`New Lead` · `Application Pending` · `Docs Requested` · `Preapproved` · `Scenario Review` · `Conditional Approval` · `Appraisal Ordered` · `Appraisal Completed` · `Approved With Conditions` · `Clear To Close` · `Closed` · `Withdrawn` · `Denied` · `Credit Repair` · `Nurture`

---

## 6. Record ID convention

IDs are `PIP-###`, zero-padded to three digits (PIP-001, PIP-017, ...). New records take the next number after the current highest. The engine assigns this for you on createRecord. Never reuse an id.

---

## 7. Golden rules

1. **Master Pipeline is the source of truth.** Update it first; the stage tabs follow.
2. **Every change gets logged** to the Change Log tab (Date, Record ID, Borrower, Change Type, Detail, Old Value, New Value, Source, Changed By). The engine logs automatically.
3. **Use exact column names and standard status words.**
4. **Never fabricate loan data.** Blank beats a guess. Flag unknowns for backfill.
5. **Email is always draft → approve → send.** Never send without Jeremy's explicit yes.
6. **Confirm what changed** after every action, naming the PIP-### and borrower, and offer the next step.
7. When a status is clearly confirmed by Jeremy, **make the change without asking permission**... only the *email send* needs a separate yes.

---

## 8. The engine (API contract)

External assistants (Custom GPT, other projects) reach the sheet through a Google Apps Script **Web App**. One endpoint, JSON in, JSON out. Every request includes the shared `token`.

**Endpoint:** the Web App `/exec` URL (from the deployment).
**Auth:** include `"token": "<your token>"` in every request.

### Actions

| action | what it does | key inputs |
|--------|--------------|------------|
| `ping` | health check | token |
| `summary` | counts by category + next id | token |
| `getRecords` | list/search records | q, category, status (all optional) |
| `getRecord` | one record | recordId or borrower |
| `createRecord` | add a record (auto PIP-###) | borrower, category, status, fields |
| `updateRecord` | change fields on a record | recordId or borrower, fields |
| `moveRecord` | change stage | recordId, toCategory, status, note |
| `appendLog` | manual Change Log row | changeType, detail, ... |
| `draftEmail` | create a Gmail draft | to, subject, body, recordId |
| `sendEmail` | send email (needs approval) | to, subject, body, approved=true, recordId |

`fields` is a map of exact column names to values, e.g.
`{"Next Action":"Order appraisal","Priority":"High","Last Known Activity":"Talked to borrower 06/19/2026"}`.

### Request examples

Read one borrower:
```json
{ "token":"XXX", "action":"getRecord", "borrower":"James Smith" }
```

Update after a call:
```json
{ "token":"XXX", "action":"updateRecord", "recordId":"PIP-001",
  "fields": { "Status":"Clear To Close", "Next Action":"Confirm closing time with title",
              "Last Known Activity":"CTC confirmed 06/19/2026", "Confidence":"High" },
  "source":"Custom GPT", "changedBy":"Jeremy via GPT" }
```

Move a file to Withdrawn:
```json
{ "token":"XXX", "action":"moveRecord", "recordId":"PIP-005",
  "toCategory":"Withdrawn", "status":"Withdrawn", "note":"Borrower withdrew 06/19/2026" }
```

Create a new lead:
```json
{ "token":"XXX", "action":"createRecord",
  "fields": { "Borrower Or Lead":"James Smith", "Category":"Lead", "Status":"New Lead",
              "Loan Purpose":"Purchase", "Referral Source":"Realtor Jane Doe",
              "Next Action":"Send application link", "Priority":"High" } }
```

Send an approved email:
```json
{ "token":"XXX", "action":"sendEmail", "to":"james@email.com",
  "subject":"Quick check-in on your home search",
  "body":"Hi James, ...", "approved":true, "recordId":"PIP-021" }
```

### Response shape

Success: `{ "ok": true, ... }` (with `record`, `records`, `recordId`, `count`, `byCategory`, `draftId`, or `sent` depending on action).
Failure: `{ "ok": false, "error": "..." }`. If you see "Unauthorized", the token is wrong. If sendEmail returns the approval error, you tried to send before passing approved=true.

### Cowork note (Claude desktop)

Inside Claude Cowork, the same sheet and Gmail are reachable through the connected Google Sheets and Gmail tools, so the Claude skill can act directly without the Web App. Either path uses this same schema, the same routing, and the same Change Log discipline. The Web App is what makes the Custom GPT and any outside project work.

---

## 9. Borrower email — voice and compliance

**Voice:** Jeremy's. First person, warm, plain, confident, a little clever when it fits. Short sentences. Commas or ellipses, not dashes. The vibe is the broker who makes a confusing process simple and never makes the borrower feel dumb. Sign as Jeremy, The Legends Mortgage Team.

**Always draft first, send only on Jeremy's approval.**

**Compliance guardrails for anything a borrower will read:**
- No promises of approval or guaranteed outcomes.
- No specific rate quotes without APR and the required context. Steer to "let's run your real numbers."
- Avoid "lowest", "best", "guaranteed", "free" unless the facts clearly support it.
- Broker-first and honest: more lender options, more flexibility, often better pricing than one bank.
- When in doubt on a compliance call, say so and let Jeremy decide.

**Two common email types:**

- *Doc request:* friendly nudge listing exactly what's needed and why it keeps things moving. "Hey James, we're close... I just need a couple things to keep your file moving."
- *Check-in:* warm touch with no pressure. "Just checking in on how the home search is going... no rush, I'm here when you're ready."

---

## 10. Worked end-to-end examples

**A. Give info, update the file**
Jeremy: "For the Pamela Bell loan, appraisal came in clean, we're clear to close Friday."
Assistant: getRecord borrower "Pamela Bell" → updateRecord PIP-001 with Status "Clear To Close", Appraisal Status "Completed", Next Action "Confirm Friday closing with title", Last Known Activity "CTC 06/19/2026", Confidence "High" → reply: "Done. PIP-001 Pamela Bell is now Clear To Close, appraisal marked complete, next action set to confirm Friday closing with title. Logged it. Want me to draft the borrower a closing-prep email?"

**B. Ask a question**
Jeremy: "Who's closing soon?"
Assistant: getRecords status "Clear To Close" (and check Closed soon) → reply with the short list, PIP-### and borrower each, plus the next action on each.

**C. Draft, approve, send**
Jeremy: "Send James Smith an email, we still need his documents."
Assistant: getRecord "James Smith" for context → write the draft and show it (To / Subject / Body) → "Want me to send this as-is, or tweak it?" → on "send it", sendEmail with approved=true and recordId → reply: "Sent to James from your mcdonald-mtg.com inbox and logged it on PIP-021. Let me know what you'd like me to do next."

---

*Keep this document with the engine. If the schema, tabs, or rules change, update this file and the assistants that use it stay correct.*
