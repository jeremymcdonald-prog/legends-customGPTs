# Core module dependency map

The builder composes every future assistant through one ordered graph. Arrows mean “resolves before and constrains.” Package purpose may narrow the result but cannot override upstream identity, safety, privacy, compliance, routing, or consent.

```mermaid
flowchart TD
    I["Identity Pack<br/>profiles and formatting"] --> A["Audience Engine<br/>tone, privacy, actions, style"]
    A --> C["Compliance Engine<br/>rules and inherited checklist"]
    C --> V["Conversation Engine<br/>lifecycle and handoff"]
    V --> R["Routing Engine<br/>owner and licensed recipient"]
    R --> T["CTA Library<br/>resolved next steps"]
    T --> L["Lead Capture Engine<br/>consent, fields, security, fallback"]
    L --> S["Generated Snapshots<br/>identity, audience, compliance, routing, CTA"]
    K["Shared Knowledge Registry"] --> S
    X["Shared Tests"] --> S
    S --> P["Final GPT Package"]
    P --> E["Platform Export Layer"]
    E --> O["OpenAI GPTs"]
    E --> CP["Claude Projects"]
    E --> G["Gemini Gems"]
    E --> M["Microsoft Copilot Agents"]
    E --> W["Open WebUI Assistants"]
    E --> AL["AnythingLLM"]
    E --> OH["OpenHands"]
    E --> LL["Local LLM assistants"]
```

## Dependency contract

1. `config/profiles/` contains approved person-specific identity values.
2. `core/` contains all shared behavior and formatting.
3. A blueprint selects owner, audience, knowledge, capabilities, Actions, routing, compliance level, and target platform.
4. `scripts/build_gpt_package.rb` validates cross-field constraints and resolves inherited modules.
5. Generated package files include `generated/factory_dependencies.yaml`, with a SHA-256 digest for every core module and selected profile.
6. Any shared source change produces a different build fingerprint and must regenerate affected packages.
7. `exporters/` changes platform packaging only; it cannot change core behavior.
