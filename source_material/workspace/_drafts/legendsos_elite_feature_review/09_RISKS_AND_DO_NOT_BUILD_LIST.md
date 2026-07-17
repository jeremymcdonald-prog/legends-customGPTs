# 09 — Risks & Do-Not-Build List

The guardrails that keep LegendsOS elite *and* safe. These apply to every phase in `08_NEXT_BUILD_SEQUENCE.md`. Nothing here should be skipped to move faster.

---

## A. Hard safety rules (from the directive — non-negotiable)

- **Do not print secrets.** Do not read or expose `.env` / `.env.local` values. (I did not open `.env.local`.)
- **Do not commit secrets.** Do not commit, push, or deploy anything as part of this review.
- **Do not run live email. Do not send Gmail.** Drafts only; live send stays behind `ALLOW_LIVE_EMAIL_SEND` + human approval.
- **Do not publish social posts.** Same gate (`ALLOW_LIVE_SOCIAL_PUBLISH`).
- **Do not run live n8n workflows** during review/build without explicit approval.
- **Do not modify Google Drive.** No move, rename, delete, upload, or overwrite. **Read-only.**
- **Do not delete files. Do not overwrite borrower files.**
- **Do not invent borrower data. Do not invent guideline citations.** Unknown = shown as unknown, with a source for every claim.
- **Do not treat agency (AUS) guideline approval as lender approval.** Keep overlays separate and labeled.
- **Do not add real borrower data to GitHub** or any repo.
- **Do not build anything until this review is approved and Jeremy runs the next build prompt.**

## B. License risks (confirmed from the archives)

| Project | License | What it means for LegendsOS |
|---|---|---|
| **GitNexus** | **PolyForm Noncommercial 1.0.0** | ⛔ **Do not embed or use commercially.** Personal/dev aid only. Borrow concepts, not code. |
| **herdr** | **AGPL-3.0-or-later** | ⛔ **Do not copy code into LegendsOS** (viral copyleft). Reimplement the status-model concept yourself. |
| AionUi | Apache-2.0 | ✅ Patterns OK; keep attribution if code is reused. |
| UI-TARS Desktop | Apache-2.0 | ✅ Patterns OK; but the GUI-control risk (below) matters more than the license. |
| Hermes Desktop | MIT | ✅ OK to borrow patterns. |
| paperclip | MIT | ✅ OK to borrow patterns. |
| OpenSwarm | MIT | ✅ OK to borrow patterns / use as a dev tool. |
| multica | Open-source (desktop sub-app marked **UNLICENSED**) | ✅ OK to borrow patterns; confirm the repo's top-level LICENSE before reusing any code. |
| **openhuman** | **GPL-3.0 (app)** / MIT (CLI sub-package) | ⛔ **Do not vendor the app code** (copyleft). Reimplement the memory/approval/tool-registry concepts yourself. |

> **Rule:** even for permissive licenses, we **borrow patterns and rebuild LegendsOS-native** — we do not fork these apps or expose their UIs.

## C. Product/architecture risks to avoid (the "do not build" list)

1. **Do not turn LegendsOS into a stitched-together mess.** No bolting on third-party apps; no exposing raw third-party UIs (paperclip board, Hermes tabs, AionUi panes, terminals) to users.
2. **Do not replace LegendsOS** with any reviewed tool. LegendsOS is the platform; the rest are pattern donors.
3. **Do not run a second agent brain/runtime** inside LegendsOS (Hermes Agent / Nous loop, AionUi bundled agent, openhuman agent). **Atlas stays the single brain.**
4. **Do not adopt autonomous GUI/computer control** (UI-TARS operators) on real systems (lender portals, MOSO, Drive). Vision is **read-only**.
5. **Do not enable auto-approve / YOLO / full-auto** modes for anything touching loan files.
6. **Do not require Docker, Cloudflare tunnels, or a local Mac runtime in production.** Production = web app on Netlify/Vercel. (Desktop Electron wrapper stays optional.)
7. **Do not introduce parallel infrastructure** you don't need: no `embedded-postgres` (use Supabase), no Redis/BullMQ if n8n covers queueing, no graph DB for v1.
8. **Do not build security theater.** Apply human-in-the-loop **only** to consequential actions (send, move, push), not to harmless reads/drafts.
9. **Do not let agents act on borrower data over chat platforms** (Telegram/WeChat/etc.). Telegram = alerts to Jeremy only.
10. **Do not bring back LegendsOS v1 mistakes:** over-complex setup, LO-overwhelming UIs, fragile local-only runtime, undocumented one-off scripts, and features no one approved. Keep the first build simple, documented, and production-minded.
11. **Do not overwhelm loan officers.** Every new capability ships behind a clean, role-scoped surface; LOs never see connectors, providers, budgets, or agent internals.

## D. Compliance risks specific to mortgage

- **RESPA / CAN-SPAM / NMLS-EHO:** every borrower/lender/marketing draft must carry your compliance layer (`legendsos-skills/_shared/knowledge` + `brand-dna`). Don't draft outbound text without it.
- **Fair-lending tone:** keep AI drafts factual and neutral; no steering, no promises of approval.
- **Guideline accuracy:** cite UW Guides / Loan Factory Loan Brain sources; never present unsourced guideline claims; never present AUS findings as lender clear-to-close.
- **PII handling:** borrower PII lives only in the RLS-protected store; never in the repo, logs, chat, or screenshots that leave the system.

## E. Operational risk found during this review (resolved — for transparency)

- **What happened:** the first pass unzipped the nine archives in parallel; the sandbox allows one process at a time, so four (`GitNexus`, `OpenSwarm`, `multica`, `openhuman`) collided and left empty folders, and the read channel was briefly degraded.
- **Resolution:** all four were **re-extracted sequentially and verified** at file level. All nine are confirmed. Original `.zip` files were never modified.
- **Lesson for the build:** in the LegendsOS automation/build scripts, **run extraction/IO sequentially** (or guard against concurrent runs). A tiny detail, but it's the kind of thing that silently corrupts a batch.

## F. The gate (must be true before any building)

1. Jeremy has reviewed this report (files 01–10).
2. Jeremy confirms the **first build = Phases 1–2** (mortgage data model + read-only Drive borrower-file browser in Atlas) — or chooses a different first slice.
3. Jeremy confirms the **Drive identity + read-only scope** and the **canonical borrower-folder structure**.
4. Only then: run the next build prompt (see `10_EXECUTIVE_SUMMARY_FOR_JEREMY.md`).

---
*Next: `10_EXECUTIVE_SUMMARY_FOR_JEREMY.md`*
