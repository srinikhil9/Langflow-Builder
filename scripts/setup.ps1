Param(
    [string]$Python = "python",
    [string]$EnvName = "venv"
)

Write-Host "Setting up Langflow Builder environment..." -ForegroundColor Cyan

# Create venv
& $Python -m venv $EnvName

# Activate venv
$activate = Join-Path $EnvName "Scripts\Activate.ps1"
. $activate

# Install requirements
pip install -r requirements.txt

Write-Host "Done. Activate with: .\\$EnvName\\Scripts\\Activate.ps1" -ForegroundColor Green
