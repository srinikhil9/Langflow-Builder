# Setup Guide - Langflow Builder

This guide will walk you through setting up the Langflow Builder - Conversation Catalyst Engine on your local machine or server.

## Prerequisites

- Python: 3.9 or higher
- Memory: Minimum 4GB RAM (8GB+ recommended)
- Storage: 2GB available space
- OS: Windows 10+, macOS 10.15+, or Linux
- Services: OpenAI API access, Langflow 1.4.2+

## Quick Start

### 1) Clone the repository
```bash
git clone https://github.com/srinikhil9/Langflow-Builder.git
cd "Langflow-Builder"
```

### 2) Set up environment
```bash
# Create and activate virtual environment
python -m venv venv
# Windows
venv\Scripts\activate
# macOS/Linux
# source venv/bin/activate

# Install dependencies
pip install -r requirements.txt
```

### 3) Configure environment variables
```bash
# Copy environment template
copy env.example .env   # Windows
# cp env.example .env   # macOS/Linux

# Edit .env and add your OpenAI API key
```

### 4) Install and run Langflow
```bash
pip install "langflow>=1.4.2"
langflow run
```

### 5) Import the Flow
```bash
# Open browser to http://localhost:7860
# Click "Import" → "Upload File"
# Select "Langflow Builder.json"
```

## Recommended Configuration

```bash
# Model Configuration
DEFAULT_OPENAI_MODEL=gpt-4o
MAX_TOKENS=4000

# Memory Settings
MEMORY_MESSAGE_LIMIT=100
ENABLE_PERSISTENT_MEMORY=true

# Router Configuration
INTENT_CONFIDENCE_THRESHOLD=0.6
ENABLE_CONTEXT_VALIDATION=true
```

## Langflow Configuration

1) API Key: Set OpenAI API Key in each OpenAI component or via environment variable.
2) Models: Use `gpt-4o` for Architect, Conversational, and Component Generator agents.
3) Memory: Message limit 100; enable session management for persistent conversations.

## Testing

- Basic: "Build a simple chatbot for customer service" → Full plan
- Follow-up: "What if I add voice recognition?" → Context-aware response
- Component: "Create a component that validates phone numbers" → Component code

## Troubleshooting

- OpenAI key not found: ensure `.env` exists with `OPENAI_API_KEY`
- Import failed: verify Langflow >= 1.4.2 and JSON integrity
- Router issues: verify inputs and API keys in all OpenAI components

## Production Notes

- DEBUG=false, LOG_LEVEL=WARNING
- Enable persistent memory and caching
- Enforce HTTPS and rotate API keys periodically

## Updating

```bash
git pull origin main
pip install -r requirements.txt --upgrade
langflow run
```

---

Need more help? See `docs/architecture.md` and `docs/customization.md`.
