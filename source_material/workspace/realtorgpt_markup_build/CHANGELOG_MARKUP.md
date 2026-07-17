# CHANGELOG_MARKUP.md

Marked-up version of the **RealtorGPT Co-Marketing Step By Step Guide** for the Legends Mortgage Team. This file describes exactly what was added on top of the original walkthrough deck so reviewers can compare, audit, or update.

## What the original deck was

`RealtorGPT Co-Marketing Step By Step Guide (1).pptx` is an 11-slide 16:9 walkthrough where each slide is a single full-bleed PNG screenshot:

| # | Screenshot |
|---|---|
| 1 | ChatGPT — Realtor Co-Branded Marketing Assistant homepage (title, description, 4 conversation starter cards, "Ask anything" prompt) |
| 2 | Redfin listing — Villa Rica GA, $975,000, 6 BR / 5.5 BA, 4,789 sqft |
| 3 | Coldwell Banker agent profile — Carla Stovall |
| 4 | ChatGPT response — copy-paste image generation prompt + uploaded image thumbnails |
| 5 | ChatGPT showing the generated FHA + Conventional 2,1 buydown flyer in the chat |
| 6 | Large flyer edit view (Select / Aspect ratio / Share / Download) |
| 7 | Google Gemini home — Gem list with "Jeremy AI Twin" |
| 8 | Gemini Gem editor — Name, Description, Instructions, Knowledge |
| 9 | Gemini Gem editor with file picker open — picking the RealtorGPT PDF |
| 10 | Gemini Gem editor with Knowledge files attached + Update button |
| 11 | Gemini Gem launched — recent thread history |

Slides 1–6 are the core ChatGPT workflow. Slides 7–11 are an optional Gemini Gem setup.

## What was added in the marked-up version

The original screenshots are **untouched**. Every annotation is an overlay shape that sits on top of the existing picture. The PPTX remains fully editable — every callout, arrow, and highlight box is its own selectable shape in PowerPoint or Keynote.

### Global elements added to every slide

- **Top banner** (black background, orange text): short headline summarizing the slide's step (e.g., "STEP 1 → 3 Open the GPT, click a starter or paste the listing URL"). The Gemini slides use a dark-gray banner with the word "OPTIONAL" to flag the alternative path.
- **Bottom footer** (black bar, white text): `Draft training guide for Legends Mortgage Team — RealtorGPT Co-Marketing Assistant`

### Slide-by-slide overlays

| # | Numbered callouts added | What was highlighted |
|---|---|---|
| 1 | ① Open the GPT  ②  Type your name + paste the URL  ③  Click a starter | GPT title row, "Ask anything" prompt, 4 starter cards |
| 2 | ④ Copy the listing URL from this bar | Browser address bar (with a verify-the-facts side-note) |
| 3 | ⑤ Agent assets are OPTIONAL | Carla's headshot and the Coldwell Banker logo, with a tip to save common assets to a folder |
| 4 | ⑥ Upload listing hero at the + button  ⑦ Copy the prompt  ⑧ Review missing inputs | The + upload area, the prompt code block, the GPT output text — with a "never AI house / never exact rate-APR-payment" reminder strip |
| 5 | ⑨ Review the generated flyer | The flyer thumbnail with a checklist of what to verify |
| 6 | ⑩ Download the flyer | The download icon at top-right + an INSPECT checklist + the COMPLIANCE bar |
| 7 | (OPTIONAL banner only) | The Gems list in the sidebar — note that ChatGPT is the primary tool |
| 8 | ① Name the Gem  ② Paste master Instructions  ③ Attach Knowledge files | Each of the 3 Gem fields |
| 9 | ④ Pick the RealtorGPT PDF + LO profile  ⑤ Then click Open | Selected file row in picker, Open button |
| 10 | ⑥ Knowledge attached  ⑦ Click Update | Knowledge thumbnail row, Update button at top-right |
| 11 | (OPTIONAL banner + compliance bar) | Whole-slide reminder that Gemini follows the same compliance rules |

### Slide 12 — Quick Reminders (new slide appended)

A new final slide was added to put the 7 must-have training reminders in one place:

1. Always upload the REAL listing hero image.
2. Do NOT use a fake AI-generated house.
3. Do NOT publish anything without compliance review.
4. Do NOT put exact MND rates on images.
5. Do NOT invent APR, taxes, HOA, seller credit, or agent information.
6. If the property is outside your licensed state, route to a licensed teammate.
7. Keep a Drive or desktop folder with your favorite headshot, Loan Factory logo, EHL logo, and common assets.

Layout: 7 orange numbered circles + dark gray text cards on a black background, with the compliance bar at the bottom and the standard footer.

## Markup style

- **Palette:** Black (`#101010`), white (`#FFFFFF`), Loan Factory orange (`#E86618`), orange dark accent (`#B84D0F`), dark gray panel (`#333333`).
- **Numbered callouts:** Orange filled circle, white bold number, white outline. Diameter 0.42".
- **Captions:** Rounded rectangle, orange fill, white bold text, orange-dark outline. Sized to fit text without wrapping awkwardly.
- **Highlight boxes:** No fill (so the screenshot shows through), 3 pt orange border.
- **Arrows:** 3.5 pt orange straight connectors with large filled triangle arrowheads.
- **Top banner:** 0.30" black bar, orange Arial Black text, 11 pt.
- **Bottom footer:** 0.205" black bar, white 8 pt Helvetica.

All callouts were positioned in empty white space on the screenshot so the underlying UI remains readable. Highlight rectangles sit on the UI element being labeled; arrows connect caption → element.

## File inventory

| File | Purpose |
|---|---|
| `RealtorGPT_CoMarketing_Marked_Up_Guide.pptx` | Editable PPTX with overlays — 12 slides |
| `RealtorGPT_CoMarketing_Marked_Up_Guide.pdf` | PDF export of the marked-up PPTX |
| `RealtorGPT_CoMarketing_Quick_Start_One_Page.pdf` | One-page Letter-size quick reference for new team members |
| `CHANGELOG_MARKUP.md` | This file |

## Quick Start one-pager — what's on it

Sections, in order:

1. **What this tool does** — one-paragraph description of the assistant.
2. **What to have ready before you start** — 6-item checklist (listing URL, hero image, your headshot, optional agent headshot/logo, optional confirmed taxes/HOA/insurance).
3. **Best starter prompt** — exact paste-ready prompt that defaults to a Seller-Funded 2/1 Buydown with FHA 3.5% + Conv 5%, market-context (not exact-rate) framing, hero-image upload, ask-for-anything-missing behavior.
4. **What to do with the output** — 5-step downstream workflow (copy prompt → upload listing photo → generate graphic → review caption/email/text/DM → send to compliance).
5. **Compliance reminder** — orange bar: "Draft marketing content for compliance review. Do not publish without approval."

Designed to fit on a single Letter-size page with a clean Loan Factory–inspired orange/black/white palette and Chrome's default print headers/footers suppressed.

## Notes / known limitations

- Some captions sit slightly over non-essential UI chrome (browser tabs, sidebar nav labels). These were left as-is because moving them further would have either pushed the caption off the slide or made arrows hard to read. No essential content (rate tables, GPT response text, prompt code blocks, agent or LO info) is blocked.
- The marked-up PPTX was rendered to PDF via LibreOffice Impress. Fonts referenced in the overlays (Helvetica, Arial Black) will fall back to system equivalents on machines that don't have them.
- The reminders slide is `slide 12` of the marked-up deck (the original had 11). All other slide numbers are unchanged from the original.
- Build steps and coordinates live in `markup.py` (in the working folder used to assemble these files). To regenerate after updating the source deck, drop the new PPTX in as `source.pptx` and rerun `python3 markup.py`.

## Quality check performed

- ✅ Each callout points to the correct UI element via a visible arrow.
- ✅ No caption blocks rate tables, the GPT response body, the image-prompt code block, the flyer image, the file picker selection row, or LO/agent info.
- ✅ All 11 original slides retain their original screenshots untouched.
- ✅ Slide 12 (new reminders slide) is opt-in for trainers — easy to delete if not wanted.
- ✅ Final PDF opens cleanly. Final PPTX remains fully editable.
- ✅ Quick Start PDF prints to one Letter-size page with no browser headers/footers.

## How to update later

If a screenshot changes (e.g., ChatGPT UI update), the cleanest workflow is:

1. Drop the updated PPTX in alongside `markup.py` as `source.pptx`.
2. Adjust the per-slide coordinates in the relevant `mark_slide_N(slide)` function (each slide is ~10–20 lines).
3. Run `python3 markup.py`.
4. Convert to PDF: `soffice --headless --convert-to pdf RealtorGPT_CoMarketing_Marked_Up_Guide.pptx`.
5. Re-export the Quick Start PDF if any wording changes there too.
