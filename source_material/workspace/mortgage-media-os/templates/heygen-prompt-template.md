# HEYGEN PROMPT TEMPLATE

Use this template to structure HeyGen API submissions for each video.

**Avatar ID:** 417274708f6a4fb6bfe850e2f0e575e7  
**Voice:** Jeremy McDonald custom voice  
**Resolution:** 1920 x 1080  
**Aspect Ratio:** 16:9  

---

## VIDEO INFO

**Topic:** [TOPIC]  
**Total Segments:** [X] (HeyGen max per generation: varies by plan)  
**Estimated Total Duration:** [X] minutes  
**Background:** [professional-indoor | modern-office | minimal-dark] (per persona config)  
**Persona:** [inside-man | coach | wolf]  

---

## SEGMENT STRUCTURE

Divide the script into segments of 60-90 seconds each (150-225 words). This manages HeyGen's input limits and allows easier re-generation if any segment needs revision.

---

### SEGMENT 1: [Section Name]
**Time range:** [0:00 - 0:XX]  
**Emotion setting:** [confident | empathetic | concerned | animated | warm]  
**Avatar instruction:** [Body language direction — forward lean, relaxed, etc.]  

**Script:**
"[Full segment text. Clean of markdown, stage directions, and compliance notes. Only the spoken words.]"

**HeyGen tone tag:** `[confident | empathetic | serious | warm]`  
**Pacing note:** [Any timing instruction — slow down here, pause after this line, etc.]  

---

### SEGMENT 2: [Section Name]
**Time range:** [0:XX - 0:XX]  
**Emotion setting:** [emotion]  
**Avatar instruction:** [direction]  

**Script:**
"[Segment 2 text]"

**HeyGen tone tag:** `[tag]`  
**Pacing note:** [instruction]  

---

### SEGMENT 3: [Section Name]
**Time range:** [0:XX - 0:XX]  
**Emotion setting:** [emotion]  
**Avatar instruction:** [direction]  

**Script:**
"[Segment 3 text]"

**HeyGen tone tag:** `[tag]`  
**Pacing note:** [instruction]  

---

### SEGMENT 4: [Section Name]
**Time range:** [0:XX - 0:XX]  
**Emotion setting:** [emotion]  
**Avatar instruction:** [direction]  

**Script:**
"[Segment 4 text]"

**HeyGen tone tag:** `[tag]`  
**Pacing note:** [instruction]  

---

### SEGMENT 5: [Section Name] (CTA)
**Time range:** [0:XX - 0:XX]  
**Emotion setting:** warm, direct  
**Avatar instruction:** slight smile, conversational close  

**Script:**
"[CTA text and sign-off]"

**HeyGen tone tag:** `[confident]`  

---

## API SUBMISSION CHECKLIST

Before submitting each segment:
- [ ] Script text is clean (no markdown, no asterisks, no hashtags)
- [ ] Stage directions removed
- [ ] Compliance footer removed (compliance goes in video description, not script)
- [ ] Pronunciation-sensitive words spelled phonetically where needed:
  - NMLS → "N-M-L-S"
  - DSCR → "D-S-C-R"
  - DTI → "D-T-I"
  - LTV → "L-T-V"
  - Loan Factory → natural (no change needed)
- [ ] Word count per segment is within API limits
- [ ] Background/avatar config matches persona

---

## POST-GENERATION ASSEMBLY NOTES

After all segments are generated and downloaded:

1. Import all MP4 segments to editing software in order
2. Check audio levels consistency across segments (normalize to -14 LUFS for YouTube)
3. Add NMLS compliance overlay (lower third, persistent)
4. Add B-roll graphics at planned insertion points (see edit-package-brief.md)
5. Add YouTube end screen (final 20 seconds)
6. Export master file at 1920x1080, H.264
7. Create vertical crop for Reels (1080x1920) — center crop of avatar
8. Export 60-second cut for Reels
9. Export 30-45 second cut for LinkedIn

**Output file naming:**
- Master: `[topic]-MASTER-v[1].mp4`
- Reel: `[topic]-reel-60sec-v[1].mp4`
- LinkedIn: `[topic]-linkedin-45sec-v[1].mp4`

---

*Jeremy McDonald | NMLS 1195266 | Loan Factory NMLS 320841 | Equal Housing Opportunity*
