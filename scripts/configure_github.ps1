Param(
    [string]$Repo = "srinikhil9/Langflow-Builder",
    [string]$Branch = "main",
    [string]$Description = "Intelligent multi-agent Langflow flow for planning, follow-ups, and component generation.",
    [string[]]$Topics = @("langflow","multi-agent","llm","openai","gpt-4o","prompt-engineering","conversational-ai","architecture","components"),
    [string]$GitHubToken
)

function Write-Info {
    param([string]$Message)
    Write-Host $Message -ForegroundColor Cyan
}

function Ensure-GH {
    if (Get-Command gh -ErrorAction SilentlyContinue) {
        Write-Info "GitHub CLI found."
        return
    }
    Write-Info "Installing GitHub CLI..."
    $winget = Get-Command winget -ErrorAction SilentlyContinue
    if ($winget) {
        winget install --id GitHub.cli -e --source winget --accept-source-agreements --accept-package-agreements --silent | Out-Null
    } else {
        $choco = Get-Command choco -ErrorAction SilentlyContinue
        if ($choco) {
            choco install gh -y --no-progress | Out-Null
        } else {
            throw "Neither winget nor choco available. Install manually: https://cli.github.com/ and rerun."
        }
    }
    if (-not (Get-Command gh -ErrorAction SilentlyContinue)) {
        throw "GitHub CLI installation failed."
    }
}

function Ensure-Auth {
    if ($GitHubToken) { $env:GH_TOKEN = $GitHubToken }
    if ($env:GH_TOKEN) {
        Write-Info "Authenticating gh with GH_TOKEN..."
        # Try to use gh directly with token; if not logged in, pipe token to --with-token
        try { gh api /user --silent | Out-Null } catch {
            Write-Output $env:GH_TOKEN | gh auth login --hostname github.com --git-protocol https --scopes "repo,workflow,admin:repo_hook" --with-token | Out-Null
        }
    } else {
        Write-Info "No token provided. Launching web-based login (requires user interaction)..."
        gh auth login --hostname github.com --git-protocol https --web --scopes "repo,workflow,admin:repo_hook" | Out-Null
    }
    gh auth status
    if ($LASTEXITCODE -ne 0) { throw "GitHub authentication failed." }
}

function Set-RepoMeta {
    Write-Info "Updating repository description and topics..."
    gh repo edit $Repo --description $Description | Out-Null
    foreach ($topic in $Topics) {
        gh repo edit $Repo --add-topic $topic | Out-Null
    }
}

function Protect-Branch {
    Write-Info "Applying branch protection to '$Branch'..."
    $parts = $Repo.Split('/'); $owner = $parts[0]; $name = $parts[1]
    $payload = @{
        required_status_checks = @{
            strict = $true
            contexts = @("Docs CI","CodeQL")
        }
        enforce_admins = $true
        required_pull_request_reviews = @{
            dismiss_stale_reviews = $true
            require_code_owner_reviews = $false
            required_approving_review_count = 1
        }
        restrictions = $null
        required_linear_history = $true
        allow_force_pushes = $false
        allow_deletions = $false
        required_conversation_resolution = $true
    }
    $json = $payload | ConvertTo-Json -Depth 10
    $endpoint = "/repos/$owner/$name/branches/$Branch/protection"
    $tmpBody = New-TemporaryFile
    Set-Content -Path $tmpBody -Value $json -NoNewline
    gh api -X PUT -H "Accept: application/vnd.github+json" $endpoint --input $tmpBody --silent
    Remove-Item $tmpBody -Force
    if ($LASTEXITCODE -ne 0) {
        Write-Host "Primary protection endpoint failed; applying granular settings..." -ForegroundColor Yellow
        gh api -X PATCH -H "Accept: application/vnd.github+json" "/repos/$owner/$name/branches/$Branch/protection/required_linear_history" -f enabled=true --silent
        gh api -X PATCH -H "Accept: application/vnd.github+json" "/repos/$owner/$name/branches/$Branch/protection/required_conversation_resolution" -f enabled=true --silent
        gh api -X PATCH -H "Accept: application/vnd.github+json" "/repos/$owner/$name/branches/$Branch/protection/allow_force_pushes" -f enabled=false --silent
        gh api -X PATCH -H "Accept: application/vnd.github+json" "/repos/$owner/$name/branches/$Branch/protection/allow_deletions" -f enabled=false --silent
        gh api -X PATCH -H "Accept: application/vnd.github+json" "/repos/$owner/$name/branches/$Branch/protection/required_status_checks" -f strict=true -F contexts[]="Docs CI" -F contexts[]="CodeQL" --silent
        gh api -X PATCH -H "Accept: application/vnd.github+json" "/repos/$owner/$name/branches/$Branch/protection/required_pull_request_reviews" -f required_approving_review_count=1 -f dismiss_stale_reviews=true -f require_code_owner_reviews=false --silent
    }
    Write-Host "Branch protection applied." -ForegroundColor Green
}

function Require-Signed-Commits {
    Write-Info "Requiring signed commits on default branch..."
    $parts = $Repo.Split('/'); $owner = $parts[0]; $name = $parts[1]
    gh api -X POST -H "Accept: application/vnd.github+json" "/repos/$owner/$name/branches/$Branch/protection/required_signatures" --silent 2>$null
}

try {
    Ensure-GH
    Ensure-Auth
    Set-RepoMeta
    Protect-Branch
    Require-Signed-Commits
    Write-Host "GitHub configuration complete." -ForegroundColor Green
} catch {
    Write-Error $_
    exit 1
}
