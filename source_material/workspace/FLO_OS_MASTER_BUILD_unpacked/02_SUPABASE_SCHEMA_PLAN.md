# Supabase Schema Plan

## Tables

### loans
- id
- loan_number
- borrower_name
- coborrower_name
- loan_type
- purchase_or_refi
- milestone
- health_score
- urgency
- drive_folder
- created_at

### borrowers
- id
- loan_id
- name
- email
- phone

### documents
- id
- loan_id
- doc_type
- filename
- source_name
- statement_date
- confidence_score
- drive_url
- uploaded_at

### ai_summaries
- id
- loan_id
- summary
- risk_level
- recommended_actions
- updated_at

### tasks
- id
- loan_id
- task_type
- task_description
- priority
- assigned_to
- approved
- completed

### workflow_logs
- id
- workflow_name
- status
- details
- created_at
