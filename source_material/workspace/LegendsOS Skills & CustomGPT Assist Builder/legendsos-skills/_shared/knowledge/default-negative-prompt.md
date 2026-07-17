# Default Negative Prompt (canonical)

One source of truth. Every AI image / video skill appends this block to its generation prompt. Update here, propagates everywhere.

## Default negative prompt (PASTE)

```
garbled text, fake text, misspelled words, distorted letters, gibberish signage, watermark, logos of real banks or named competitors, trademarked logos, fake legal text, real loan documents, on-image disclaimers rendered by AI, extra fingers, deformed hands, asymmetric eyes, plastic skin, oversaturated, rainbow gradients, cartoon mascot, clip art, busy cluttered footer, white flyer background, low resolution, blurry face
```

## Add-on negative fragments (use when context calls for it)

| Context | Add to negative |
|---|---|
| Bank vs broker / Pattern Interrupt | `no bank names, no competitor logos, no zombie or caricature competitors` |
| Testimonial card | `no cartoon characters, no clip-art stars` |
| AI authority command center | `dashboards must look illustrative, not real performance data` |
| VA / patriotic | `no flags rendered as logos, no government seals` |
| Veteran closing day | `no real borrower faces unless approved, no real closing documents` |
| Realtor co-brand | `no agent face unless approved, no agent broker logo unless approved` |

## Hard rule

Image and video models cannot be trusted to render text. Always reserve text and compliance zones for Canva. Always include this negative prompt. Always.
