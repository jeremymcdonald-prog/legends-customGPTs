# Review Source Rules

How to treat any public review (Zillow, Google, Facebook recommendations, LinkedIn recommendation, etc.).

## Source URL is mandatory

If we cannot link the review, we cannot treat it as a public review. Without a source URL it becomes a `borrower_memory` and the privacy gate applies the full anonymization defaults.

## Public review treatment

- Reframe is the default. Lesson over quote.
- A word-for-word quote requires the source URL and the line "Public review on [platform]" in the post.
- Reviewer name stays as published. We do not add details beyond what is public.
- Sensitive details inside the review (rate, loan amount, address) get redacted from any repost.
- Competitor mentions inside the review get redacted.

## Public review storage

- `source_id` prefix per platform.
- `source_url` filled.
- `permission_status` may stay `none` because the reviewer published the review themselves; the public-source citation is the consent layer.
- `status` can move to `public` after privacy gate.

## Non-public review treatment

- A review the reviewer sent us privately (text, email, DM) is NOT a public review.
- Treat as `borrower_memory`.
- Reframe only.
- Names require `permission_status = written`.

## Aggregation

- The skill can produce a "themes across reviews" output (no names) when asked.
- Aggregations cite the platforms drawn from, never specific reviewer names.

## Tools

- This skill does NOT scrape Zillow or Google. Jeremy or an operator pastes review text in. If a connector becomes available later, the audit doc records it.
