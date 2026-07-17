# Mortgage lead-capture Action package

This directory defines a planned, non-deployed contract for securely handing a consumer's low-risk mortgage inquiry to an assigned licensed loan officer. It does not create an endpoint, configure credentials, or select a CRM.

The GPT must answer first, identify the receiving licensed professional, display the resolved consent prompt, and receive explicit confirmation before calling `submitMortgageLead`. The external service validates the profile assignment again; the GPT is not the authority for routing or identity.

## Launch status

**Blocked from public launch** until all of the following exist and are approved:

- a secure external implementation owned by a named system owner;
- an approved destination adapter;
- a valid public privacy-policy URL;
- authentication configured in the GPT Action secret settings and server secret manager;
- retention, deletion, consent, deduplication, abuse, and audit controls;
- security, privacy, compliance, and end-to-end QA sign-off.

Start with `openapi.yaml`, then review every companion requirement file in this directory. No secret values belong anywhere in this repository.
