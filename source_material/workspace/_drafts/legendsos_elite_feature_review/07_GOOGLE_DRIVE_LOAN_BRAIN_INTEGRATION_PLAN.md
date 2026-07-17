# 07 — Google Drive Loan Brain Integration Plan

**Goal:** Connect LegendsOSv2.0 to Jeremy's live mortgage operations workspace in Google Drive — **read-only** — so Atlas becomes a true **Loan Brain**: browse borrower files, search active loans, summarize a folder, track received/missing docs, generate processor handoffs, read 3.4/AUS, build condition responses, search UW guidelines, and draft (never send) communications.

**Target Drive folder (from the handoff):** "Jeremy Applicants Pipeline" — `https://drive.google.com/drive/folders/1X8BD29eHIzK9TJOssKB1hq3EH-Y1H7mW`
Working users of that folder: Jeremy, Ashley, Geraldine, Codex, LegendsOSv2.0.

> **Non-negotiable safety frame:** LegendsOS connects to Drive **read-only**. It does **not** modify, move, rename, delete, or overwrite anything in Drive. Borrower data **never** goes to GitHub. No secrets are printed or committed. (All per directive.)

---

## Architecture (how it plugs into what you already have)

```
Google Drive (read-only)
   └─ "Jeremy Applicants Pipeline"
        └─ per-borrower folders
                │  (Drive API / connector, read scope only)
                ▼
LegendsOS  ── lib/drive/* (new)  →  index in Supabase (metadata + extracted text, RLS-protected)
                │                         │
                ▼                         ▼
        Atlas retrieval  ───────►  Loan Brain features (summary, tracker, handoff, conditions)
        (already exists)                  │
                                          ▼
                              Draft outputs (email, handoff, notes) → human approval → optional send via n8n
```

- **Connector:** reuse your existing `mcp_connections` table + Atlas `ConnectorPanel`. Prefer a **read-only Google Drive connection** via the Google Workspace OAuth you already own (or the Drive MCP / Zapier MCP available in your stack). Scope = read-only (e.g., `drive.readonly` / `drive.metadata.readonly`). **Request the narrowest scope that works.**
- **Index, don't copy:** LegendsOS stores **metadata + extracted text** for search in Supabase (RLS-protected), not a second copy of every PDF. Borrower PII lives only in your controlled, access-scoped store — never in the repo.
- **Brain:** Atlas's existing `retrieval.ts` + `toolRouter.ts` answer questions over the indexed content. This is why we build *inside* Atlas, not as a separate app.

## Borrower folder structure (define this first)

The whole Loan Brain depends on a **predictable per-borrower folder shape**. Confirm/establish a canonical structure, e.g.:

```
Jeremy Applicants Pipeline/
  <Borrower Name> - <Loan #>/
    01_Application (1003, 3.4)
    02_Income
    03_Assets
    04_Credit
    05_Property (appraisal, HOI)
    06_Title
    07_AUS_Findings
    08_Conditions
    09_Disclosures
    10_Correspondence
```

LegendsOS reads this structure to drive classification (received/missing) and summaries. Where a borrower folder doesn't match, LegendsOS flags it for cleanup (recommendation only — file 06).

## The Drive-based features (from the handoff) and how each is built

| Feature | How LegendsOS does it | Borrowed pattern |
|---|---|---|
| **Drive borrower file browser** | Read-only file tree in Atlas with inline preview | AionUi preview panel |
| **Active loan file search** | Hybrid search over indexed metadata + text | paperclip indexing / Atlas retrieval |
| **Borrower folder summary** | Atlas summarizes the folder's key facts + status | Atlas retrieval |
| **Document received / missing tracker** | Classify folder contents vs. program checklist | classification + AionUi preview |
| **Processor handoff generator** | Fill the 21-field handoff (file 05) from folder + 3.4 + AUS | LegendsOS-native template |
| **Ashley email generator** | Draft processor emails, brand+compliance loaded | Hermes draft-first gateway |
| **3.4 intake parser** | Extract loan facts from the Fannie 3.4 file | AI-gateway LLM extraction (no OCR project among the 9; use `lib/ai/providers.ts`) |
| **AUS summary reader** | Summarize DU/LP findings into plain language | AI-gateway LLM + UI-TARS vision (read-only) for screenshots |
| **UW condition-response builder** | Map each condition → satisfying doc + cited guideline | Atlas retrieval over UW Guides + openhuman memory-graph idea |
| **Guideline search (UW Guides + Loan Brain)** | Retrieval over your guideline corpus with citations | Atlas retrieval (GitNexus graph only as inspiration — noncommercial license, don't embed) |
| **Lender overlay note creator** | Compare loan facts to lender overlays → risk note | Atlas retrieval + rules |
| **Pipeline update assistant** | Draft status update from current loan state | paperclip status roll-up |
| **Screenshot intake** (pricing/AUS/lender) | Vision reads the image into structured text | UI-TARS vision (read-only) |

## The guideline layer (UW Guides + Loan Factory Loan Brain)

- Index your **UW Guides** and **Loan Factory Loan Brain** content as an Atlas knowledge collection (your `knowledge` module + `import-local-knowledge.ts` already exist).
- Every guideline answer **shows its source**. LegendsOS **does not invent citations** and **does not present agency/AUS findings as lender approval** — overlays and lender-specific conditions are clearly separated from agency guidelines. (Directive.)

## Suggested build phases for the Drive Loan Brain

1. **Phase A — Connect (read-only).** Drive connector via existing OAuth/MCP, narrowest read scope. Prove: list the "Jeremy Applicants Pipeline" folder and one borrower folder, read-only, in Atlas. No indexing yet.
2. **Phase B — Browse + preview.** Borrower file browser with inline preview (AionUi pattern). Still read-only, no writes anywhere.
3. **Phase C — Index + search + summary.** Index metadata + extracted text into Supabase (RLS); active-loan search + folder summary.
4. **Phase D — Trackers + handoff.** Received/missing tracker + processor-handoff generator (file 05). Outputs are drafts for approval.
5. **Phase E — Conditions + guidelines + overlays.** Condition-response builder + UW guideline search (cited) + lender overlay note.
6. **Phase F — Drafts + pipeline.** Ashley/Geraldine email drafts + pipeline-update assistant, all draft-first behind `ALLOW_LIVE_EMAIL_SEND`.

Each phase is independently useful and safe; you can stop after any phase and still have value.

## Hard safety rules for the Drive integration (restated)

- **Read-only.** No move, rename, delete, overwrite, or upload to Drive.
- **No borrower data in GitHub** or in any repo, ever.
- **No invented data or citations.** Unknown = shown as unknown.
- **Agency findings ≠ lender approval.** Keep overlays separate and labeled.
- **No secrets printed or committed.** Connector credentials live in environment/connector storage, not in code or chat.
- **Least-privilege scope.** Request the narrowest Drive read scope that supports the feature.

## What to confirm before Phase A

1. **Which Google identity** owns the Drive connection (Loan Factory corporate vs. `mcdonald-mtg.com`) and that read-only sharing to that identity is in place.
2. **The canonical borrower-folder structure** (above) so classification is reliable.
3. **The expected-document checklist per loan program** (so "missing" is accurate).
4. **Where contacts live** (AE, AM, title, HOI, realtor) so handoffs populate.
5. **Whether to connect via** Google Workspace OAuth directly, the Google Drive MCP, or Zapier MCP — pick one read-only path and standardize.

---
*Next: `08_NEXT_BUILD_SEQUENCE.md`*
