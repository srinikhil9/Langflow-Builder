## Langflow Builder — Conversation Catalyst Engine

[![Stars](https://img.shields.io/github/stars/srinikhil9/Langflow-Builder?style=social)](https://github.com/srinikhil9/Langflow-Builder)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![Python](https://img.shields.io/badge/Python-3.9%2B-blue)](requirements.txt)
[![Langflow](https://img.shields.io/badge/Langflow-%E2%89%A51.4.2-5C2D91)](https://github.com/langflow-ai/langflow)
[![Docs CI](https://github.com/srinikhil9/Langflow-Builder/actions/workflows/publish-docs.yml/badge.svg)](https://github.com/srinikhil9/Langflow-Builder/actions/workflows/publish-docs.yml)
[![CodeQL](https://github.com/srinikhil9/Langflow-Builder/actions/workflows/codeql.yml/badge.svg)](https://github.com/srinikhil9/Langflow-Builder/actions/workflows/codeql.yml)

An intelligent multi-agent Langflow solution that automatically routes user requests to the appropriate response type: architectural planning, conversational follow‑ups, or custom component generation.

Repository: [srinikhil9/Langflow-Builder](https://github.com/srinikhil9/Langflow-Builder)

### Table of Contents

- [Features](#features)
- [Quick start](#quick-start)
- [Usage](#usage)
- [Configuration](#configuration)
- [Project layout](#project-layout)
- [Quick links](#quick-links)
- [Keywords](#keywords)
- [Contributing](#contributing)
- [License](#license)

### Features

- **Smart intent classification** for: new architectures, follow‑ups, and custom component generation
- **Multi‑agent architecture**: Architect Agent, Conversational Agent, Component Generator
- **Enhanced router** with context validation, fallback mechanisms, and confidence scoring
- **Conversation memory** integration for contextual responses

### Prerequisites

- Python 3.9+
- Langflow 1.4.2+
- OpenAI API key

### Quick start

1) Clone and prepare environment
```bash
git clone https://github.com/srinikhil9/Langflow-Builder.git
cd "Langflow-Builder"
python -m venv venv
# Windows
venv\Scripts\activate
# macOS/Linux
# source venv/bin/activate
pip install -r requirements.txt
cp .env.example .env
```

2) Configure environment
```bash
# Edit .env and set your keys
OPENAI_API_KEY=sk-your-openai-api-key
```

3) Install Langflow and run
```bash
pip install "langflow>=1.4.2"
langflow run
```

4) Import the flow in the UI
- Open `http://localhost:7860`
- Import → Upload File → select `Langflow Builder.json`

### Usage

Start a conversation with any project request. The system automatically decides whether to generate a new architecture, continue the conversation contextually, or produce a custom component.

Examples:
```text
"Build an agentic framework for SQL database queries with natural language"  → Architecture plan
"What if I want to add Redis caching to that system?"                         → Contextual follow‑up
"Create a custom component that validates email addresses"                    → Component code
```

### Configuration

- Default model: `gpt-4o` (configurable via `.env` and inside Langflow components)
- Memory: retains last 100 messages (adjustable)
- Router: pattern matching, context validation, and fallbacks

### Project layout

```
Langflow-Builder/
├── Langflow Builder.json            # Main Langflow flow export
├── README.md                        # You are here
├── requirements.txt                 # Python dependencies
├── .env.example                     # Template env config
├── .gitignore
├── .gitattributes
├── docs/
│   ├── setup_guide.md
│   ├── architecture.md
│   └── customization.md
├── examples/
│   ├── project_requests.md
│   ├── follow_up_scenarios.md
│   └── component_generations.md
├── scripts/
│   ├── setup.ps1
│   └── setup.sh
└── assets/
    └── screenshots/ (optional)
```

### Quick links

- Import this flow directly into Langflow: download the JSON and import via UI
  - Raw flow JSON: `https://raw.githubusercontent.com/srinikhil9/Langflow-Builder/main/Langflow%20Builder.json`
  - Import path in UI: Import → Upload File → select `Langflow Builder.json`

### Keywords

Langflow, multi‑agent, LLM, OpenAI, GPT‑4o, AI workflows, intent classification, response router, conversation memory, component generation, prompt engineering, agentic design, AI planning, conversational AI

### Contributing

See `CONTRIBUTING.md` for development workflow. Please follow the `CODE_OF_CONDUCT.md`.

### License

Licensed under the MIT License. See `LICENSE`.

### Acknowledgments

- Built with [Langflow](https://github.com/langflow-ai/langflow)
- Powered by OpenAI GPT models


