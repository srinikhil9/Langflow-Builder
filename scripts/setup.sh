#!/usr/bin/env bash
set -euo pipefail

PY=${PYTHON:-python3}
ENV_NAME=${ENV_NAME:-venv}

echo "Setting up Langflow Builder environment..."
$PY -m venv "$ENV_NAME"
# shellcheck disable=SC1090
source "$ENV_NAME/bin/activate"

pip install -r requirements.txt

echo "Done. Activate with: source $ENV_NAME/bin/activate"
