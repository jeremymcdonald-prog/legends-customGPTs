# LegendsOS Meet Prompter — Product & Build Spec

**Owner:** Jeremy McDonald — The Legends Mortgage Team powered by Loan Factory **What it is:** A private, presenter-only floating teleprompter overlay for Google Meet webinars. **MVP:** Chrome extension (Manifest V3). Google Meet Add-on is a future consideration, not the MVP. **Connects to (future):** LegendsOS Webinar Builder \+ Supabase for approved scripts. **Status:** Production spec. Section 8 is a ready-to-run Claude Code build prompt.

---

## Read This First — The Presenter-Only Model

The overlay renders in the presenter's local browser on the Meet tab. Google Meet transmits only your camera and mic, never your local browser UI, so during normal presenting the prompter is private to you.

It becomes visible to attendees only if you screen-share a surface that contains it:

- **Share "Entire screen"** \-\> overlay is visible to attendees. Avoid.  
- **Share "A window"** \-\> only that window is captured. Keep the prompter on the Meet tab and share your slides window. Overlay stays private.  
- **Share "A Chrome tab"** \-\> only that tab is captured. Share your slides tab, not the Meet tab. Overlay stays private.

Best practice baked into the product: present slides from a separate window or tab (or a second monitor) and share that, while the prompter stays on the Meet tab. The extension shows a persistent safe-share reminder. Honest limitation: a content script cannot reliably detect when you trigger screen-share from Meet's own controls, so protection is workflow plus warning, not a hard block. The product never hides this from the user.

---

# 1\. Product Spec

**Purpose:** Give Jeremy and team members a private teleprompter while hosting Google Meet webinars, showing a scrolling script, bullet points, timing cues, CTAs, compliance reminders, and speaker notes, visible only to the presenter.

**Goals:** fast to build, easy to test, truly private, presenter-controlled, on the LegendsOS dark-glass brand, and ready to receive approved scripts from Webinar Builder later.

**Required features (all in MVP unless marked future):**

1. Works on meet.google.com  
2. Floating draggable overlay  
3. Resizable overlay  
4. Dark transparent glass design  
5. Burnt gold LegendsOS accents  
6. Scrolling teleprompter script  
7. Bullet point side panel  
8. Speaker notes panel  
9. Timer (elapsed \+ optional per-section target)  
10. Scroll speed control  
11. Font size control  
12. Opacity control  
13. Pause and resume  
14. Restart  
15. Jump to section  
16. Collapse mode (shrink to a small pill)  
17. Keyboard shortcuts  
18. Local script paste mode  
19. Import script from JSON  
20. LegendsOS sync mode (future)

**Non-goals (hard):** no call recording, no attendee audio/video access, no scraping meeting data, no auto-chat, no auto-join, no bypassing Google permissions, no embedded Supabase keys, no storing borrower-sensitive data in raw scripts unless explicitly approved.

**Brand:** dark transparent glass panels, charcoal/black base, burnt gold / Loan Factory orange accents, white/silver type, high-contrast readability, mobile-second (desktop-first because webinars are hosted on desktop).

---

# 2\. User Flow

**MVP (local):**

```
1. Install extension.
2. Open a Google Meet webinar (meet.google.com).
3. Click the extension icon -> popup opens.
4. Paste a script OR import a script JSON.
5. Click "Open Prompter" -> floating glass overlay appears on the Meet tab.
6. Position and resize the overlay; set font, opacity, speed.
7. Read the safe-share reminder; start your screen share of slides (separate window/tab).
8. Press Play -> script auto-scrolls; bullets and speaker notes show alongside; timer runs.
9. Use controls/shortcuts: pause, speed, jump to section, restart, collapse.
10. Finish -> close overlay. Session stats stored locally.
```

**Future (LegendsOS sync):**

```
1. Create webinar in LegendsOS.
2. Generate script with Webinar Builder.
3. Approve script (Boardroom + sign-off).
4. Script + sections + notes saved in Supabase.
5. Open Meet Prompter; sign in to LegendsOS via secure token.
6. Select the approved webinar script.
7. Teleprompter loads sections, bullets, notes, CTAs, compliance cues.
8. Track completion locally and/or in LegendsOS (prompter_sessions).
```

---

# 3\. UI Wireframe Description

**Floating overlay (default \~420x600, draggable by its top bar, resizable from corners):**

```
+--------------------------------------------------+
| [drag bar]  LegendsOS Meet Prompter   [_][collapse][x] |
|  00:14:32 elapsed   section 3/8: "VA Benefits"   |  <- timer + section cue
+--------------------------------------------------+
|  MAIN SCRIPT (auto-scroll, large readable type)  |
|  ...current line highlighted in burnt gold...    |
|                                                  |
+----------------------+---------------------------+
|  BULLETS (this sec)  |  SPEAKER NOTES (this sec) |
|  - point one         |  say warmly; pause here    |
|  - point two         |  CTA: "DM VA"              |
|                      |  COMPLIANCE: eligibility…  |
+----------------------+---------------------------+
| [<< prev] [Play/Pause] [Restart] [next >>] [jump v]|
| speed [—o——] font [—o—] opacity [——o-]            |
| SAFE SHARE: share your slides window, not screen  |  <- persistent reminder
+--------------------------------------------------+
```

- **Collapse mode:** a small burnt-gold glass pill showing timer \+ Play/Pause, click to expand.  
- **Jump-to-section:** dropdown of section titles; selecting scrolls instantly.  
- **Compliance cue:** any section flagged with a compliance line shows a small gold badge.

**Popup (extension icon):** Load script (Paste / Import JSON), recent scripts, Open Prompter, quick settings (font, opacity, speed), link to Options. Future: "Sign in to LegendsOS" \+ "Select approved webinar."

**Options page:** default overlay size/position, default font/opacity/speed, keyboard shortcut reference, theme, data retention, future LegendsOS API endpoint \+ token status, "clear local data."

**Keyboard shortcuts (scoped to overlay focus / Alt modifier to avoid Meet conflicts):**

```
Alt+P   Play / Pause
Alt+R   Restart
Alt+Up  / Alt+Down     Scroll speed + / -
Alt+=   / Alt+-         Font size + / -
Alt+[   / Alt+]         Previous / Next section
Alt+C   Collapse / Expand
Alt+H   Hide / Show overlay
```

Shortcuts deliberately avoid Meet's own (Ctrl+D mute, Ctrl+E camera, etc.).

---

# 4\. Extension Architecture

**Manifest V3.** React \+ TypeScript, bundled with Vite \+ @crxjs/vite-plugin.

```
manifest.json        MV3 manifest
src/contentScript.ts injects overlay (shadow DOM) on meet.google.com; mounts overlay.tsx
src/overlay.tsx      the floating teleprompter UI + scroll engine + controls
src/popup.tsx        load scripts, quick settings, open prompter
src/options.tsx      full settings + future LegendsOS config
src/styles.css       dark glass theme, burnt gold accents (scoped inside shadow DOM)
src/storage.ts       typed chrome.storage.local wrapper
src/types.ts         WebinarScript, ScriptSection, SpeakerNote, PrompterSettings, PrompterSession
README.md            install, dev, build, usage, safety
(service worker)     src/serviceWorker.ts for extension state + message routing
```

**manifest essentials:**

- `manifest_version: 3`  
- `content_scripts`: matches `https://meet.google.com/*`, runs `contentScript`  
- `background.service_worker`: `serviceWorker`  
- `action.default_popup`: `popup.html`  
- `options_page`: `options.html`  
- `permissions`: `storage` (and `commands` for shortcuts if using the Commands API)  
- `host_permissions`: `https://meet.google.com/*` for MVP; add the LegendsOS API origin later  
- No `tabs`, no `scripting` beyond what's needed, no broad host access. Least privilege.

**Why shadow DOM:** isolates the overlay's CSS from Meet's styles and vice versa, so Meet can't break the prompter and the prompter can't leak styles into Meet.

**Message passing:** popup/options \-\> serviceWorker \-\> contentScript (load script, open/close overlay, update settings). State (current script, settings, session) persisted in `chrome.storage.local`. The overlay reads/writes through `storage.ts`.

**Scroll engine:** requestAnimationFrame loop translating the script container at `speed` px/sec; pause/resume toggles the loop; restart resets scroll \+ timer; jump-to-section scrolls to the section anchor and sets current section.

**Draggable/resizable:** pointer events on the drag bar and resize handles; clamp to viewport; persist position/size.

---

# 5\. LegendsOS Integration Plan (Future)

**Bridge:** Webinar Builder produces an approved script. On approval (Boardroom gate \+ sign-off), LegendsOS writes the script, its sections, and speaker notes to Supabase. Meet Prompter pulls the approved script by ID.

**Auth and keys:** the extension never holds Supabase keys. It authenticates to a LegendsOS API (server-side) with a short-lived token (PKCE or a LegendsOS-issued session token). The LegendsOS API reads Supabase server-side and returns only the script payload the user is allowed to see (org-scoped). All access logged.

**Sync flow:**

```
Extension -> LegendsOS API: GET /v1/webinars (org-scoped, token)
Extension -> LegendsOS API: GET /v1/webinars/:id/script (sections + notes)
Extension renders teleprompter from the payload
Extension -> LegendsOS API: POST /v1/prompter-sessions (completion, duration) [optional]
```

**Payload \= the JSON import schema** (Section below), so local import and LegendsOS sync share one shape.

**Script JSON schema (PASTE):**

```json
{
  "webinar_id": "optional-uuid",
  "title": "VA Buyer Webinar",
  "presenter": "Jeremy McDonald",
  "total_target_minutes": 45,
  "sections": [
    {
      "id": "sec-1",
      "title": "Welcome",
      "target_minutes": 3,
      "script": "Full spoken script text for this section...",
      "bullets": ["point one", "point two"],
      "speaker_notes": "Say warmly. Pause after the question.",
      "cta": "DM VA",
      "compliance": "VA is a government benefit. No endorsement implied. Eligibility and program guidelines apply."
    }
  ]
}
```

---

# 6\. Supabase Table Recommendations (Future)

```
webinars                (id, org_id, title, presenter, status, total_target_minutes,
                         created_by, created_at)
webinar_scripts         (id, org_id, webinar_id FK, version, approved bool,
                         approved_by, created_at)
webinar_script_sections (id, org_id, script_id FK, position, title, target_minutes,
                         script_text, bullets jsonb, cta, compliance_text)
webinar_speaker_notes   (id, org_id, section_id FK, note_text)
webinar_prompter_sessions(id, org_id, webinar_id FK, presenter_id, started_at,
                         ended_at, sections_completed, duration_sec, device)
```

Org\_id \+ RLS on every table. Only approved scripts (`webinar_scripts.approved = true`) are loadable into the prompter. Sessions are append-only for a usage record. No borrower PII in script text unless explicitly approved and flagged.

---

# 7\. Security Rules (PASTE)

```
LEGENDSOS MEET PROMPTER — SECURITY RULES
- Do not record calls. No media capture of any kind.
- Do not access attendee audio or video. The extension never touches media streams.
- Do not scrape or read private meeting data, participant lists, or chat.
- Do not auto-send chat messages.
- Do not auto-join meetings.
- Do not bypass or spoof Google permissions. Use only declared, least-privilege permissions.
- Do not embed or expose Supabase keys in the extension. All Supabase access is server-side via the LegendsOS API with short-lived tokens.
- Do not store borrower-sensitive data in raw scripts unless explicitly approved and flagged.
- Least privilege: permissions = storage (+ commands if used); host_permissions = meet.google.com (+ LegendsOS API origin later). Nothing broader.
- Overlay is local-only; it is never transmitted unless the presenter screen-shares a surface containing it. Show the safe-share reminder persistently.
- Local data (scripts, settings, sessions) stored in chrome.storage.local; provide a "clear local data" action.
- Future LegendsOS calls are org-scoped, token-authenticated, and logged. No service keys client-side, ever.
```

---

# 8\. MVP Build Prompt for Claude Code (PASTE)

```
TASK
Build the LegendsOS Meet Prompter MVP: a Manifest V3 Chrome extension that injects a private, presenter-only floating teleprompter overlay on meet.google.com. Local scripts only for MVP (paste + JSON import). No LegendsOS/Supabase calls yet, but structure the code so sync can be added later.

STACK
TypeScript, React, Vite + @crxjs/vite-plugin, Manifest V3. No Supabase keys. No network calls in MVP.

FILES
manifest.json, src/contentScript.ts, src/overlay.tsx, src/popup.tsx, src/options.tsx,
src/styles.css, src/storage.ts, src/types.ts, src/serviceWorker.ts, README.md, plus
vite.config.ts, tsconfig.json, package.json, popup.html, options.html.

MANIFEST (MV3)
- manifest_version 3
- name "LegendsOS Meet Prompter", version "0.1.0"
- action.default_popup popup.html
- options_page options.html
- background.service_worker src/serviceWorker.ts
- content_scripts: matches ["https://meet.google.com/*"], js [contentScript], run_at document_idle
- permissions: ["storage"]  (add "commands" only if implementing the Commands API)
- host_permissions: ["https://meet.google.com/*"]
- least privilege; no tabs, no broad host access

TYPES (src/types.ts)
WebinarScript { webinar_id?, title, presenter, total_target_minutes?, sections: ScriptSection[] }
ScriptSection { id, title, target_minutes?, script, bullets: string[], speaker_notes?, cta?, compliance? }
PrompterSettings { fontSize, opacity, speedPxPerSec, x, y, width, height, collapsed }
PrompterSession { id, title, startedAt, endedAt?, sectionsCompleted, durationSec }

STORAGE (src/storage.ts)
Typed wrapper over chrome.storage.local: getScript/setScript, getSettings/setSettings (with defaults),
listRecentScripts/saveRecentScript, saveSession, clearAll.

CONTENT SCRIPT (src/contentScript.ts)
- On meet.google.com, create a host element, attach a shadow root, inject styles.css into the shadow root,
  and mount overlay.tsx (React) inside it. Style isolation via shadow DOM.
- Listen for messages from the service worker: OPEN_OVERLAY, CLOSE_OVERLAY, LOAD_SCRIPT, UPDATE_SETTINGS.
- Do not read or touch any Meet media, DOM data, participants, or chat.

OVERLAY (src/overlay.tsx)
- Floating glass panel: draggable by its top bar, resizable from corners, clamped to viewport,
  position/size persisted via storage.
- Header: title, elapsed timer (mm:ss / hh:mm:ss), current section indicator (n/total + title),
  minimize/collapse/close buttons.
- Main script area: auto-scroll via requestAnimationFrame at speedPxPerSec; current line emphasis in burnt gold.
- Side panels: Bullets (current section) and Speaker Notes (current section), with CTA and a gold COMPLIANCE badge when present.
- Controls: prev/next section, Play/Pause, Restart, jump-to-section dropdown; sliders for speed, font size, opacity.
- Collapse mode: small burnt-gold glass pill with timer + Play/Pause; click to expand.
- Persistent safe-share reminder line: "Share your slides window or tab, not your entire screen. Keep the prompter on the Meet tab."
- Keyboard shortcuts (Alt-modified to avoid Meet conflicts): Alt+P play/pause, Alt+R restart, Alt+Up/Down speed, Alt+=/- font, Alt+[/] section, Alt+C collapse, Alt+H hide.
- On close, save a PrompterSession via storage.

POPUP (src/popup.tsx)
- Tabs: Paste Script (textarea -> parse to WebinarScript; allow plain text that becomes a single section, or structured paste) and Import JSON (validate against the schema; clear errors on invalid).
- Recent scripts list. "Open Prompter" sends OPEN_OVERLAY + LOAD_SCRIPT to the active Meet tab via the service worker.
- Quick settings: font, opacity, speed.

OPTIONS (src/options.tsx)
- Defaults for size/position/font/opacity/speed, keyboard shortcut reference, theme, data retention,
  "Clear local data", and a disabled-but-present "LegendsOS Sync (coming soon)" section with endpoint + token fields stubbed.

STYLES (src/styles.css)
- Dark transparent glass: charcoal/black with backdrop-filter blur, subtle border, soft shadow.
- Burnt gold / Loan Factory orange accents (#F26A21) and champagne gold (#C9A24B) for highlights and the current line.
- White/silver type, high contrast, large readable teleprompter font. Scoped inside the shadow root.

SERVICE WORKER (src/serviceWorker.ts)
- Route messages between popup/options and the active Meet tab's content script.
- Hold no sensitive state; persistence is in chrome.storage.local.

CONSTRAINTS
- No media capture, no reading Meet DOM data/participants/chat, no auto-chat, no auto-join, no network calls.
- Least-privilege manifest. No secrets anywhere.
- Strict TypeScript. Validate imported JSON (Zod or a hand-rolled validator) and fail gracefully.
- Structure LegendsOS sync as a clean future seam (a loadScript source interface with a LocalSource now and an ApiSource later).

DELIVERABLES
- A working extension that loads unpacked in Chrome, injects the overlay on meet.google.com, plays a pasted/imported script with all MVP controls, and persists settings.
- README.md with: install unpacked, dev (vite), build, how to load a script, the safe-share guidance, and the shortcut list.
- Basic tests for storage and JSON validation.
```

---

# 9\. Testing Checklist (PASTE)

```
MEET PROMPTER MVP CHECKLIST
[ ] Loads unpacked in Chrome with no manifest errors.
[ ] Overlay injects only on meet.google.com, inside a shadow root (no style bleed either way).
[ ] Overlay is draggable, resizable, and clamped to the viewport; position/size persist.
[ ] Dark glass theme with burnt gold accents renders correctly.
[ ] Paste mode loads a script; plain text becomes a single readable section.
[ ] JSON import validates against the schema; invalid JSON fails with a clear message.
[ ] Auto-scroll plays; speed, font, and opacity sliders work live.
[ ] Pause/resume, restart, prev/next section, and jump-to-section all work.
[ ] Timer counts elapsed; current section indicator updates.
[ ] Bullets, speaker notes, CTA, and compliance badge show per section.
[ ] Collapse mode shows the pill; expand restores state.
[ ] Alt-based shortcuts work and do NOT trigger Meet's own shortcuts.
[ ] Safe-share reminder is always visible.
[ ] Manual screen-share test: sharing a separate slides window does NOT show the overlay; sharing the Meet tab/entire screen DOES (documented behavior, reminder present).
[ ] No network calls; no Meet media/DOM/chat access; permissions are storage + host meet.google.com only.
[ ] "Clear local data" wipes scripts, settings, and sessions.
[ ] Session is saved on close.
```

---

# 10\. Future Roadmap \+ Chrome Extension vs Google Meet Add-on

**Roadmap:**

- v0.1 (MVP): local paste/JSON, full overlay \+ controls, presenter-only, Chrome extension.  
- v0.2: LegendsOS sync (API \+ token), select approved Webinar Builder scripts, prompter\_sessions logging.  
- v0.3: per-section timing alerts and pacing (behind/ahead of target), section auto-advance option.  
- v0.4: multi-presenter handoff cues, CTA prompts timed to slides.  
- v0.5: second-monitor mode, presenter remote (phone) control.  
- v1.0: evaluate Google Meet Add-on for official Workspace distribution.

**Chrome Extension vs Google Meet Add-on:**

|  | Chrome Extension (MVP) | Google Meet Add-on (future) |
| :---- | :---- | :---- |
| Privacy of overlay | Truly local and private; only visible if the presenter shares a surface containing it | Add-on surfaces (side panel, main stage) are designed for collaboration; main stage is shared with the meeting, so a private presenter-only overlay is harder |
| Build/test speed | Fast; load unpacked, iterate immediately | Slower; SDK setup, Workspace config, app review |
| Distribution | Install per browser; easy for an internal team | Official Workspace Marketplace distribution |
| Surfaces | Free-floating overlay anywhere on the Meet tab | Constrained to Meet's side panel \+ main stage iframes |
| Permissions | Least-privilege, presenter-controlled | More Google review and scope considerations |
| Best fit | A private presenter teleprompter (this product) | Collaborative in-meeting apps and official distribution |

**Conclusion:** the Meet Add-ons SDK can embed apps into Meet with a side panel and a shared main stage, which is great for collaborative tools and official distribution, but it works against a private presenter-only overlay and is slower to ship. The MVP stays a Chrome extension. Revisit the Add-on only if Loan Factory wants official Workspace Marketplace distribution, and even then keep the private prompter as the extension.

---

Let me know what you'd like me to do next.  
