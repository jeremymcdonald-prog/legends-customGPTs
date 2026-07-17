# Credentials map — no secrets

This file names credential categories and ownership only. It must never contain passwords, tokens, private keys, client secrets, recovery codes, or live webhook URLs.

| System | Credential location | Intended access | Status |
|---|---|---|---|
| GitHub repository | User SSH agent / GitHub account | Maintainers | Existing access verified during foundation work |
| OpenAI / Custom GPT builder | Owner-managed OpenAI account | GPT owners/builders | Confirm before first build |
| Google Workspace | Google account and approved OAuth scopes | Named team roles | Confirm per Action |
| Google Sheets pipeline Action | Server-side Apps Script properties or approved secret store | Internal pipeline GPT only | Replace any instruction-embedded token design before launch |
| GoHighLevel | Platform credential store | Approved CRM operators | Confirm before integration work |
| n8n | n8n credential store / environment | Automation operators | Confirm before integration work |
| Zapier | Zapier connected accounts | Approved operators | Confirm before integration work |
| Canva / HeyGen / media tools | Vendor account credential store | Marketing operators | Confirm consent and license scope |
| Hosting / API gateway | Deployment secret manager | Service identities | Select during Action design |

Credential rotation, revocation, owner, scope, and last verification date must be recorded in the authorized secret-management system, not Git.
