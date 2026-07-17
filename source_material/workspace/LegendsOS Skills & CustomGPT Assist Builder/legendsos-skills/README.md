# LegendsOS Skills

Production Claude Skills and Custom GPT packages for The Legends Mortgage Team powered by Loan Factory.

## Structure

```
legendsos-skills/
├── _shared/                shared brand, knowledge, templates, prompt components
├── platform/               standalone system skills (ai-boardroom, visual-intelligence, creative-studio, youtube-intelligence, meet-prompter)
└── companions/             the 9 customer-facing companions from Pack v2
```

## Build status

- Wave 0 foundation: complete
- Wave 1 ai-boardroom: complete
- Wave 1 visual-intelligence: complete
- Creative Studio: prep only, awaiting Higgsfield MCP

## How skills consume shared files

Every skill references `_shared/brand-dna/compliance-pack.md` instead of copying compliance text. Every skill references `_shared/knowledge/default-negative-prompt.md` instead of duplicating it. One source of truth, change once, propagates everywhere.

Owner: Jeremy McDonald | NMLS #1195266 | Loan Factory NMLS #320841 | Equal Housing Lender
