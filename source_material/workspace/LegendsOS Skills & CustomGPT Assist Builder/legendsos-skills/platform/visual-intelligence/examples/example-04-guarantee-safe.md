# Example 04 — Best Price Guarantee, compliance-safe (all states except Washington)

## Input

> Design a compliance-safe version of the Best Price Guarantee for all states except Washington.

## Output

**1. Engine + Layout**
Cinematic Authority · Luxury Command Center (banner variant). Premium and quietly confident. The guarantee is real, the disclaimer is unmissable.

**2. Pre-check (compliance gate)**

Before generating, this skill confirms the values from `_shared/brand-dna/guarantee-terms.md`:

| Field | Required value |
|---|---|
| Guarantee amount | Current confirmed amount only — **VERIFY before publish** |
| Eligible states | All states EXCEPT Washington |
| T&C URL | loanfactory.com/best-price-guarantee (or Jeremy-specific URL) |

If `current_guarantee_offer` is unset, the gate blocks. (For this example, assume it's set.)

**3. AI Image Prompt**

```
Cinematic banner 1277x473, LegendsOS dark luxury. Moody premium neighborhood at night, soft warm window glow on the homes, charcoal base, subtle Loan Factory orange edge light. Three small icon zones placed in the lower middle band (rate, fees, promise, all left clean for icons + text in Canva). A clean horizontal band reserved across the top-center for a guarantee headline, and a wide bottom strip reserved for full disclaimer text. Premium realism, film grain, mobile-first.

Negative: garbled text, fake text, misspelled words, distorted letters, gibberish signage, watermark, real bank or competitor logos, trademarked logos, fake legal text, real loan documents, on-image disclaimers rendered by AI, extra fingers, deformed hands, asymmetric eyes, plastic skin, oversaturated, rainbow gradients, cartoon mascot, clip art, busy cluttered footer, white flyer background, low resolution, blurry face.

Do not render any text.
```

**4. Canva Build**

- **Headline (top-center band):** `$1,000 LOWEST RATE & FEE GUARANTEE` — Anton uppercase, white with **$1,000** in Loan Factory Orange.
- **Support line:** `A broker's access. A team's power. Your advantage.` — Montserrat SemiBold, silver.
- **Three icon zones (lower middle):** Rate · Fees · Promise — small caps sans, orange.
- **CTA:** `Start here` — orange chip, lower right.
- **Logo lockup:** Top-left, full Legends + Loan Factory.
- **Compliance strip (full bottom band, mandatory verbatim):**

  ```
  Available in all states except Washington. Visit loanfactory.com/best-price-guarantee for full terms. This is not a commitment to lend. All loans subject to credit approval. Rates, terms, and fees subject to change without notice. Equal Housing Lender. Loan Factory NMLS #320841. Jeremy McDonald NMLS #1195266.
  ```

**5. Caption (Jeremy's voice)**

```
Our $1,000 Lowest Rate & Fee Guarantee is real. So is the fine print.

Available in all states except Washington. Full terms live at loanfactory.com/best-price-guarantee.

If you already got a quote from a bank, send it over. I'll show you how we stack up.

Not a commitment to lend. All loans subject to credit approval. Rates, terms, and fees subject to change without notice.

Legends Mortgage Team | Powered by Loan Factory
Equal Housing Lender · NMLS #1195266 · Loan Factory NMLS #320841
```

**6. Visual Boardroom Review**

- Verdict: **Publish (with verified guarantee config).**
- Attention: 8/10 — banner is premium and authority-led, less scroll-stopping than a face-led post but right for the offer.
- Compliance: 10/10 (if `current_guarantee_offer` config is verified at publish time). Fails to 4/10 and **HOLD** if config is unset or stale.
- Trust: 10/10 — the disclaimer is on the same surface as the headline. Builds trust, doesn't hide.
- Readability: 9/10 — disclaimer is small but legible at phone size.
- Brand: 10/10 — on the dark-luxury DNA.
- Risk notes: this is the highest-risk creative in the LegendsOS catalog. Re-verify the live amount and eligible states on every publish. Geo-target ad placements to exclude Washington at the platform level. Belt + suspenders.
- Fixes before publishing: confirm guarantee value, eligible states, and T&C URL with the verified config TODAY.

**7. Final Approved Prompt**

The Section 3 prompt is approved as-written. The Canva build copy is approved verbatim. Do NOT ship without re-verifying the guarantee config.

**Next step:** confirm `current_guarantee_offer` in the source config, lock the live amount, then publish to FB + GBP. Schedule a recurring config audit each quarter.
