# Image-to-Video Rules

## What it is

A Higgsfield still that animates into the first 2 to 3 seconds of a Reel, Short, or TikTok. The hook.

## When to use

- The first 2 seconds of a short-form video need a pattern interrupt.
- A cinematic still alone is too static for a hook.
- The story benefits from a slow zoom, subtle parallax, or key rotation.

## Spec rules

- Duration 2 to 5 seconds at the most.
- Loop seam clean (last frame matches first frame, or fades out clean).
- Motion subtle. No rapid zoom, no whip pans.
- Easing: slow in, slow out preferred.
- Output format: mp4 or webm, vertical 1080x1920 default.
- Reserved text zones must hold steady through the motion.

## Motion vocabulary

- Slow zoom in
- Slow zoom out
- Subtle parallax (foreground slower than background)
- Key rotation (small object rotates 8 to 15 degrees)
- Particle drift (gentle film grain or dust)
- Light pulse (one accent light slowly brightens)

## What to avoid

- Whip pans
- Fast cuts
- Color shifts
- Faces moving unnaturally
- Aggressive motion that competes with HeyGen avatar handoff

## Handoff to HeyGen

The image-to-video plays first 2 to 3 seconds. HeyGen avatar then takes the screen. The transition is a clean cut, never a fade between mediums (which looks cheap).

## Audit

Treated the same as still generation. Logs `motion: true` and the motion notes.
