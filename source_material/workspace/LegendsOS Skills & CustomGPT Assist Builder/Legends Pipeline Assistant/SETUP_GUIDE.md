# Legends Pipeline Assistant — Setup Guide

This package turns your Master Pipeline into something you can run by just talking, from both Claude
and a ChatGPT Custom GPT, with borrower emails that only go out after you approve them.

## What's in the box

```
Legends Pipeline Assistant/
├── 1_AppsScript_Engine/Code.gs                 The backend on your sheet (read/update/email)
├── 2_Custom_GPT/
│   ├── CustomGPT_Instructions.md               Name, description, instructions, starters
│   └── CustomGPT_Action_OpenAPI.yaml           The Action schema (gives the GPT read/write)
├── 3_Knowledge_Document/
│   └── Legends_Pipeline_Knowledge.md           Drop-in knowledge for any GPT or Project
├── 4_Claude_Skill/legends-pipeline-assistant/  The Cowork skill (SKILL.md + references)
└── SETUP_GUIDE.md                              You are here
```

One engine, two front doors: Claude (Cowork) and your Custom GPT both talk to the same sheet and the
same Change Log. Set it up in three parts, about 20 minutes total.

---

## Part A — Deploy the engine (do this first, ~10 min)

The engine is a Google Apps Script Web App bolted onto the sheet. Because email must come from
**jeremy@mcdonald-mtg.com**, do this whole part while signed in as that account.

**1. Make a token.** This is the shared password between your assistants and the engine. Generate a long
random string. On your Mac terminal:
```
openssl rand -hex 24
```
Copy the result. You'll paste it in three places: the script, the Custom GPT instructions, and (already
referenced) the skill via Cowork.

**2. Open the script editor.** Open the Legends_Master_Pipeline sheet → **Extensions → Apps Script**.

**3. Paste the code.** Delete whatever is in `Code.gs`, paste the full contents of
`1_AppsScript_Engine/Code.gs`. Near the top, set:
```
var SECRET_TOKEN = 'paste-your-token-here';
```
Save (the disk icon).

**4. Authorize + self-test.** In the editor toolbar, choose the function `runSelfTest` and click **Run**.
Google will ask you to authorize... approve the Sheets and Gmail permissions (it's your own script).
Open **View → Logs**; you should see `Header match: true`. That confirms the engine sees your sheet and
the columns line up.

**5. Deploy as a Web App.** Click **Deploy → New deployment**. Gear icon → **Web app**. Set:
- Description: `Legends Pipeline Engine v1`
- Execute as: **Me (jeremy@mcdonald-mtg.com)**
- Who has access: **Anyone**

Click **Deploy**, approve again if asked, and **copy the Web app URL**. It looks like:
```
https://script.google.com/macros/s/AKfy...long...id.../exec
```

**6. Quick test.** In your Mac terminal, swap in your URL and token:
```
curl -L -X POST "https://script.google.com/macros/s/AKfy.../exec" \
  -H "Content-Type: application/json" \
  -d '{"token":"YOUR_TOKEN","action":"summary"}'
```
You should get JSON back with `"ok":true` and your category counts. If you see "Unauthorized", the token
doesn't match. If you get HTML, make sure you used the `/exec` URL and "Anyone" access.

> Whenever you change `Code.gs` later, do **Deploy → Manage deployments → Edit → Version: New version** so
> the live URL picks up your changes. The URL stays the same.

---

## Part B — Build the Custom GPT (~7 min)

**1.** Go to ChatGPT → **Explore GPTs → Create → Configure**.

**2.** From `2_Custom_GPT/CustomGPT_Instructions.md`, paste the **Name**, **Description**, and
**Instructions** into the matching boxes. In the Instructions, replace `PASTE_YOUR_TOKEN_HERE` with your
token. Add the four **Conversation starters**. Turn off Web Browsing / DALL-E / Code Interpreter.

**3. Add the knowledge.** Under **Knowledge**, upload
`3_Knowledge_Document/Legends_Pipeline_Knowledge.md`.

**4. Add the Action.** Click **Create new action**. Open
`2_Custom_GPT/CustomGPT_Action_OpenAPI.yaml`, copy all of it into the schema box. Then fix the server URL:
change the `servers: url:` line so it is your deployment **without** the `/exec` at the end, e.g.
```
servers:
  - url: https://script.google.com/macros/s/AKfy...long...id...
```
(The `/exec` is already on the path.) Authentication: **None** (your token rides in the request body).

**5. Test it.** In the GPT preview, try: *"What's in my pipeline right now?"* It should call the Action and
report your counts. Then: *"Draft a check-in email for Pamela Bell."* It should show a draft and wait for
your go-ahead before sending. Save the GPT as **Only me**.

---

## Part C — Install the Claude Cowork skill (~3 min)

The skill folder is `4_Claude_Skill/legends-pipeline-assistant/` (it contains `SKILL.md` and a
`references/` copy of the knowledge doc).

Add it through the Claude desktop app: **Settings → Capabilities → Skills** and point it at that folder
(or zip the `legends-pipeline-assistant` folder and install it there). I can't install it into your app
from here, so this one is a quick manual step on your side.

In Cowork, the skill uses your already-connected Google Sheets and Gmail tools, so it works without the
Web App. Test it by saying: *"Who in my pipeline is clear to close?"* then *"Draft Pamela Bell a
closing-prep email and send it once I okay it."*

---

## Part D — Acceptance checklist

Run these once to confirm everything works end to end:

- [ ] `summary` returns your real category counts (engine reachable).
- [ ] Ask "tell me about the Pamela Bell file" → correct record comes back.
- [ ] "Update PIP-001, next action is order homeowners insurance" → field changes, Change Log row appears.
- [ ] "Move Alex Orellana to withdrawn" → row leaves Active Loans, lands in Withdrawn, master updates.
- [ ] "Add a new VA lead named Test Borrower" → new PIP-### created, routed to Leads, logged.
- [ ] "Draft Test Borrower a doc-request email" → you get a draft, nothing sends.
- [ ] Approve it → email sends from jeremy@mcdonald-mtg.com, Change Log shows "Email Sent".
- [ ] Delete the Test Borrower rows when you're done.

---

## Security & good habits

- Keep the token private and the Custom GPT set to **Only me**. Anyone with the URL **and** the token can
  write to the sheet, so treat the token like a password. Rotate it by changing `SECRET_TOKEN`, redeploying
  a new version, and updating the GPT instructions.
- The engine refuses to send email unless `approved=true` is passed, which is a hard backstop on top of the
  assistant's draft-first rule.
- The Change Log records every create, update, move, and send, so you always have an audit trail.

## Changing the pipeline later

If you add a column or a new stage, update `HEADERS` / `CATEGORY_TAB` in `Code.gs`, redeploy a new version,
and update the matching sections of `Legends_Pipeline_Knowledge.md` so the assistants stay in sync. Or just
ask me and I'll regenerate the pieces.

Let me know what you'd like me to do next.
