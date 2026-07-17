---
name: legends-pipeline-assistant
description: >
  Read, update, and maintain Jeremy McDonald's Legends Master Pipeline Google Sheet, and
  draft and send borrower emails after Jeremy approves them. Use this whenever Jeremy mentions
  a borrower or lead by name, a loan or pipeline update, changing a file's stage (preapproved,
  clear to close, withdrawn, denied, closed), adding a new lead, asking what's in the pipeline
  or who's closing soon, or asking to draft, write, or send a check-in or document-request email
  to a client. Trigger even when he doesn't say "pipeline" or "spreadsheet" — for example
  "for the James Smith loan, update his status", "who's closing this week", "mark Alex withdrawn",
  "add this new VA lead", or "draft Pamela a doc-request email and send it once I okay it".
---

# Legends Pipeline Assistant

This skill makes Claude the operator of Jeremy's mortgage pipeline. The point is that Jeremy can
just talk... say what happened on a loan, ask who's closing, or ask for a borrower email... and the
pipeline stays current and accurate, with email always going out only after he approves it.

The full data model, the standard Category and Status words, stage routing, the API contract, and
the email voice and compliance rules live in `references/pipeline_knowledge.md`. Read it whenever you
need the exact column names or rules. The essentials are below.

## The one rule that keeps the data clean

The **Master Pipeline** tab is the single source of truth. Update it first, then make the stage tabs
match it. Spreadsheet ID: `1kJtbtNPj2BGd42HH3uulISBVIz6xFtIvSLsZuT23pOM`. Stage tabs are filtered
copies (Active Loans, Leads, Preapproved, Past Clients, Withdrawn, Dead Leads, Closed Loans). Every
edit gets a row in the **Change Log** tab so there is always an audit trail.

## How to do the work in Cowork

Use the connected Google Sheets tools on that spreadsheet, and the connected Gmail tools for email.
(If Jeremy has deployed the Apps Script engine, you may call that instead; either way the schema,
routing, and Change Log discipline are identical.)

**To answer a question** ("who's clear to close?", "what's the Bell file's blocker?"): read the
Master Pipeline tab, filter by what he asked, and answer with the PIP-### and borrower name plus the
relevant fields. Keep it tight.

**To update a file with new info:**
1. Find the borrower's row in Master Pipeline (search the Borrower Or Lead column).
2. Update only the fields that changed (Status, Next Action, Main Blocker, Last Known Activity,
   Follow Up Date, Confidence, etc.). Use exact column names and the standard Status words.
3. If the **Category** changed, move the file: delete the row from the old stage tab and add the full
   updated row to the new stage tab. If Category did not change, update the matching stage-tab row in place.
4. Append a row to the Change Log (Date, Record ID, Borrower, Change Type, Detail, Old Value, New Value,
   Source, Changed By).
5. Confirm in one or two lines what changed, naming the PIP-### and borrower, and offer the next step.

**To add a new lead or borrower:** assign the next PIP-### (one above the current highest), write the
row to Master Pipeline and the routed stage tab, and log it. Require at least Borrower Or Lead, Category,
and Status. Leave unknown loan fields blank... never guess.

**Verify before trusting a write.** These sheet tools can occasionally map a column loosely, so after a
meaningful update, read the row back and confirm the key fields landed before telling Jeremy it's done.

## Email — always draft, approve, then send

This is the part Jeremy cares about most, so handle it carefully. Sending the wrong thing to a borrower
is worse than being slow.

1. Pull the borrower's record for context (status, blocker, next action, names).
2. **Write the draft and show it to Jeremy right in the chat** — To, Subject, and Body. Then ask
   something like "Want me to send this as-is, or change anything?"
3. **Only after he clearly approves**, send it through Gmail from **jeremy@mcdonald-mtg.com**.
4. Log the send on the borrower's record (Last Known Activity) and in the Change Log.
5. Never send without an explicit yes. If he wants to eyeball it in Gmail first, leave it as a draft and
   tell him it's in Drafts.

## Borrower email voice

Write as Jeremy: first person, warm, plain, confident, a little clever when it fits. Short sentences.
Use commas or ellipses instead of dashes. Be the broker who makes a confusing process feel simple and
never makes someone feel dumb for asking. Sign off as Jeremy with The Legends Mortgage Team.

Two everyday types:
- **Doc request** — a friendly nudge that lists exactly what's needed and why it keeps things moving.
- **Check-in** — a no-pressure touch ("just seeing how the home search is going... no rush").

## Mortgage compliance (anything a borrower will read)

- No promises of approval or guaranteed outcomes.
- No specific rate quote without APR and context... steer to "let's run your real numbers."
- Avoid "lowest", "best", "guaranteed", "free" unless the facts clearly support it.
- Stay broker-first and honest: more lender options, more flexibility, often better pricing than one bank.
- If a compliance call is unclear, say so and let Jeremy decide.

## Close every useful reply

Confirm what you did (name the PIP-### and borrower), then end with:
"Let me know what you'd like me to do next."
