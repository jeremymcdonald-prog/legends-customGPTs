# FLO OS Architecture

## Core Layers

### Memory Layer
Supabase
- loans
- borrowers
- documents
- tasks
- ai_summaries
- alerts
- workflow_logs
- telegram_messages
- skills
- sops

### Automation Layer
n8n
- Gmail ingestion
- OCR
- AI routing
- Telegram
- Drive organization
- Google Sheets updates
- Task creation
- Alerts

### AI Layer
Primary:
- DeepSeek

Fast Operations:
- Groq

Fallback:
- OpenRouter Free Models

### Storage Layer
Google Drive
Google Sheets
Google Docs

### Future Execution Layer
Playwright
TERA automation
