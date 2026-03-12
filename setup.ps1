#Requires -Version 5.1
# DVP Setup - Windows
# One-command setup: installs Git, Claude Code, places config files.
$ErrorActionPreference = "Stop"

$DvpRepo = "https://github.com/PropterMalone/dvp.git"
$DvpDir = "$env:USERPROFILE\dvp"
$ClaudeDir = "$env:USERPROFILE\.claude"
$Step = 0
$TotalSteps = 4

# --- Helpers ---
function Refresh-Path {
    $machinePath = [System.Environment]::GetEnvironmentVariable("PATH", "Machine")
    $userPath = [System.Environment]::GetEnvironmentVariable("PATH", "User")
    $env:PATH = "$machinePath;$userPath"
}

function Show-Step {
    param([string]$Label)
    $script:Step++
    Write-Host ""
    Write-Host "  [$Step/$TotalSteps] $Label" -ForegroundColor Cyan
}

function Show-OK {
    param([string]$Message)
    Write-Host "         $Message" -ForegroundColor Green
}

function Show-Warn {
    param([string]$Message)
    Write-Host "         $Message" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "  ========================================" -ForegroundColor Cyan
Write-Host "  DVP Setup" -ForegroundColor Cyan
Write-Host "  ========================================" -ForegroundColor Cyan
Write-Host ""

# --- Step 1: Git ---
Show-Step "Git"
if (Get-Command git -ErrorAction SilentlyContinue) {
    Show-OK "Ready."
} else {
    Write-Host "         Installing..." -ForegroundColor White
    $hasWinget = Get-Command winget -ErrorAction SilentlyContinue
    if ($hasWinget) {
        winget install Git.Git --accept-source-agreements --accept-package-agreements
        Refresh-Path
    }
    if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
        Show-Warn "Could not install Git automatically."
        Show-Warn "Please install from https://git-scm.com/downloads and run this script again."
        exit 1
    }
    Show-OK "Installed."
}

# --- Step 2: Claude Code ---
Show-Step "Claude Code"
if (Get-Command claude -ErrorAction SilentlyContinue) {
    Show-OK "Ready."
} else {
    Write-Host "         Installing..." -ForegroundColor White
    $hasWinget = Get-Command winget -ErrorAction SilentlyContinue
    if ($hasWinget) {
        winget install Anthropic.ClaudeCode --accept-source-agreements --accept-package-agreements
    } else {
        Show-Warn "Could not install automatically (winget not available)."
        Show-Warn "Open PowerShell and run: irm https://claude.ai/install.ps1 | iex"
        Show-Warn "Then run this script again."
        exit 1
    }
    Refresh-Path
    if (-not (Get-Command claude -ErrorAction SilentlyContinue)) {
        Show-Warn "Installation completed but 'claude' command not found."
        Show-Warn "Please close this window, open a new PowerShell, and run this script again."
        exit 1
    }
    Show-OK "Installed."
}

# --- Ensure HOME is set ---
if (-not $env:HOME) {
    $env:HOME = $env:USERPROFILE
    [System.Environment]::SetEnvironmentVariable("HOME", $env:USERPROFILE, "User")
}

# --- Step 3: DVP repo ---
Show-Step "Configuration files"
if (Test-Path "$DvpDir\.git") {
    Write-Host "         Checking for updates..." -ForegroundColor White
    try {
        Push-Location $DvpDir
        git pull --ff-only 2>&1 | Out-Null
    } catch { } finally {
        Pop-Location
    }
    Show-OK "Up to date."
} elseif (Test-Path $DvpDir) {
    Show-Warn "Folder exists but is not a Git repo."
    Show-Warn "To get automatic updates, delete $DvpDir and run this script again."
} else {
    Write-Host "         Downloading..." -ForegroundColor White
    git clone $DvpRepo $DvpDir
    if (-not (Test-Path $DvpDir)) {
        Show-Warn "Failed to download. Check your internet connection and try again."
        exit 1
    }
    Show-OK "Downloaded."
}

# --- Step 4: Place config ---
Show-Step "Claude Code configuration"

# Create directories
New-Item -ItemType Directory -Path "$ClaudeDir\styles" -Force | Out-Null
New-Item -ItemType Directory -Path "$ClaudeDir\skills" -Force | Out-Null

# CLAUDE.md — don't overwrite if customized
if (-not (Test-Path "$ClaudeDir\CLAUDE.md")) {
    Copy-Item "$DvpDir\claude\CLAUDE.md" "$ClaudeDir\CLAUDE.md"
    Show-OK "Installed CLAUDE.md"
} else {
    Show-OK "CLAUDE.md already exists (keeping yours)"
}

# Styles — always update
Copy-Item "$DvpDir\claude\styles\*.md" "$ClaudeDir\styles\" -Force
Show-OK "Styles installed"

# Skills — always update
Copy-Item "$DvpDir\claude\skills\*.md" "$ClaudeDir\skills\" -Force
Show-OK "Skills installed"

# .env.example
if (-not (Test-Path "$env:USERPROFILE\.env.example")) {
    @"
# API keys for stock data, brokerage, etc.
# Copy this file to .env and fill in your values.
# Never commit .env to git — it contains secrets.

# ALPHA_VANTAGE_API_KEY=
# POLYGON_API_KEY=
# FINNHUB_API_KEY=
"@ | Set-Content "$env:USERPROFILE\.env.example"
    Show-OK "Created .env.example"
}

# --- Done ---
Write-Host ""
Write-Host "  ========================================" -ForegroundColor Green
Write-Host "  Setup complete!" -ForegroundColor Green
Write-Host "  ========================================" -ForegroundColor Green
Write-Host ""
Write-Host "  Type 'claude' to start Claude Code." -ForegroundColor White
Write-Host ""
Write-Host "  First time? Claude will ask you to log in" -ForegroundColor White
Write-Host "  via your browser. After that, just talk to it." -ForegroundColor White
Write-Host ""
Write-Host "  Try: /kickoff" -ForegroundColor White
Write-Host ""
