# Week 1 HeyGen Execution Packet

**HeyGen connector status.** Needs setup. Zapier HeyGen actions exist but no zero-cost safe test is available (all actions consume render credits or require a video ID). Auth + avatar identity not confirmed in this session.
**Mode.** Manual until one operator-run test render confirms auth and avatar.
**Source.** `04_prompt_banks/week_1_heygen_batch_prompts.csv` (19 rows).

## Required first action — test render (one prompt only)
Do NOT submit all 19 prompts at once. Submit ONE test from the row below first.

### Test prompt
- **Day.** DAY01
- **Platform.** IG_REEL
- **Persona.** Coach
- **Length.** 45 seconds
- **Topic.** Broker Advantage - Week 1 DAY01
- **Script.** ```A retail lender said wait. We pulled the file, called multiple wholesale investors, found the right overlay, kept the same loan amount, closed on time. Brokers shop. Banks sell.```
- **On-screen text.** Bank said wait. / Broker closed on time. / Brokers shop. Banks sell.
- **B-roll.** cinematic phone call; closing day handoff; Northeast Florida lifestyle
- **Music.** warm low bpm strings no vocals
- **End screen.** DM NUMBERS for a second opinion on your file.
- **Compliance footer.** Yes

## After the test renders successfully
1. Confirm Jeremy's avatar is the correct identity.
2. Confirm captions and on-screen text look right.
3. Confirm length is on target.
4. Note actual render minutes used.
5. Submit the remaining 18 prompts from `week_1_heygen_render_queue.csv`.

## If the test fails or auth is blocked
- Skip HeyGen for Week 1. Jeremy films the Friday VA closing-day Reel on camera.
- Mark the failed slots in dispatch tracker as `NEEDS_REVIEW`.
- Update the connector verification report with the failure reason.

## Hard rules
- No HeyGen avatars of other people unless written authorization is on file.
- VA scripts include the VA non-endorsement line in the description.
- DSCR / investor scripts include the business-purpose line in the description.
- All output stays as drafts in HeyGen until Jeremy approves for download.