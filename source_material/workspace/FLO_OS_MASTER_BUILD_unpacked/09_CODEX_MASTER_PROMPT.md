# CODEX MASTER PROMPT

You are building FLO OS.

Primary repo:
https://github.com/ashleyarogersmtgprocessor-cyber/Flo-os.git

Primary architecture:
- Supabase
- n8n on Hostinger VPS
- Google Workspace
- OpenRouter
- DeepSeek
- Groq
- Telegram
- HeyGen

Goals:
- Build an AI powered mortgage processing operating system
- Focus on internal operations first
- No outbound borrower emailing initially
- Preserve all audit trails
- Use modular services
- Use Supabase as persistent memory
- Use n8n as orchestration

Tasks:
1. Initialize repo structure
2. Connect Supabase
3. Create database schema
4. Build environment config
5. Build Gmail ingestion workflow
6. Build OCR pipeline
7. Build document classification
8. Build loan memory engine
9. Build Telegram bot interface
10. Build daily briefing engine
11. Build task engine

Rules:
- Never expose secrets
- Use environment variables
- No fake workflows
- Keep workflows modular
- Use event driven architecture
- Preserve all original borrower documents
- No autonomous borrower communication

Run:
- npm install
- npm run build if applicable
- validate all configs
- prepare n8n workflow imports
