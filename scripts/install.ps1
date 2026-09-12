<#
.SYNOPSIS
    Preceptor: Academic Learning Engine Installer for Windows (PowerShell)
.DESCRIPTION
    Installs Preceptor into Antigravity, Claude Code, Cursor, Windsurf, Copilot, or Cline.
.EXAMPLE
    irm https://raw.githubusercontent.com/samuli-h/preceptor/main/scripts/install.ps1 | iex
.EXAMPLE
    .\scripts\install.ps1 -Target Cursor -Scope Project
#>

param (
    [ValidateSet("Auto", "All", "Claude", "Cursor", "Antigravity", "Windsurf", "Copilot", "Cline")]
    [string]$Target = "Auto",

    [ValidateSet("Global", "Project")]
    [string]$Scope = "Global",

    [switch]$DryRun = $false
)

$ErrorActionPreference = "Stop"

Write-Host "======================================================" -ForegroundColor Cyan
Write-Host "   Preceptor: Academic Learning Engine Installer (Windows)  " -ForegroundColor Cyan
Write-Host "======================================================" -ForegroundColor Cyan

# Locate local repository or clone
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path -ErrorAction SilentlyContinue
if (-not $ScriptDir) { $ScriptDir = Get-Location }
$RootDir = Split-Path -Parent $ScriptDir -ErrorAction SilentlyContinue

$LocalSkills = Join-Path $RootDir "skills"
$LocalDist = Join-Path $RootDir "dist"

if (Test-Path $LocalSkills) {
    $SrcSkills = $LocalSkills
    $SrcDist = $LocalDist
    Write-Host "[OK] Detected local repository at: $RootDir" -ForegroundColor Green
} else {
    Write-Host "Downloading skill suite from GitHub..." -ForegroundColor Yellow
    $TempDir = Join-Path $env:TEMP ([System.IO.Path]::GetRandomFileName())
    New-Item -ItemType Directory -Path $TempDir -Force | Out-Null
    try {
        git clone --depth 1 "https://github.com/samuli-h/preceptor.git" (Join-Path $TempDir "suite") 2>$null
        $SrcSkills = Join-Path $TempDir "suite\skills"
        $SrcDist = Join-Path $TempDir "suite\dist"
    } catch {
        Write-Error "Failed to clone repository. Ensure git is installed and reachable."
    }
}

$InstalledCount = 0

function Install-Antigravity {
    Write-Host "`nInstalling for Google Antigravity / Gemini CLI..." -ForegroundColor White
    $dest = if ($Scope -eq "Global") { Join-Path $HOME ".gemini\config\skills" } else { ".\.agents\skills" }
    if (-not $DryRun) {
        New-Item -ItemType Directory -Path $dest -Force | Out-Null
        Copy-Item -Path "$SrcSkills\*" -Destination $dest -Recurse -Force
    }
    Write-Host "[OK] Installed 7 skills to $dest" -ForegroundColor Green
    $script:InstalledCount++
}

function Install-Claude {
    Write-Host "`nInstalling for Claude Code..." -ForegroundColor White
    $dest = if ($Scope -eq "Global") { Join-Path $HOME ".claude\skills" } else { ".\.claude\skills" }
    if (-not $DryRun) {
        New-Item -ItemType Directory -Path $dest -Force | Out-Null
        Copy-Item -Path "$SrcSkills\*" -Destination $dest -Recurse -Force
    }
    Write-Host "[OK] Installed 7 skills to $dest" -ForegroundColor Green
    $script:InstalledCount++
}

function Install-Cursor {
    Write-Host "`nInstalling for Cursor..." -ForegroundColor White
    if ($Scope -eq "Project") {
        $dest = ".\.cursor\rules"
        if (-not $DryRun) {
            New-Item -ItemType Directory -Path $dest -Force | Out-Null
            if (Test-Path "$SrcDist\cursor") {
                Copy-Item -Path "$SrcDist\cursor\*.mdc" -Destination $dest -Force
            } else {
                Copy-Item -Path "$SrcSkills\*" -Destination ".\.cursor\skills" -Recurse -Force
            }
        }
        Write-Host "[OK] Installed Cursor rules to $dest" -ForegroundColor Green
    } else {
        $dest = Join-Path $HOME ".cursor\skills"
        if (-not $DryRun) {
            New-Item -ItemType Directory -Path $dest -Force | Out-Null
            Copy-Item -Path "$SrcSkills\*" -Destination $dest -Recurse -Force
        }
        Write-Host "[OK] Installed global skills to $dest" -ForegroundColor Green
    }
    $script:InstalledCount++
}

function Install-Windsurf {
    Write-Host "`nInstalling for Windsurf (Cascade)..." -ForegroundColor White
    $dest = if ($Scope -eq "Global") { Join-Path $HOME ".windsurf\skills" } else { ".\.windsurf\rules" }
    if (-not $DryRun) {
        New-Item -ItemType Directory -Path $dest -Force | Out-Null
        Copy-Item -Path "$SrcSkills\*" -Destination $dest -Recurse -Force
    }
    Write-Host "[OK] Installed to $dest" -ForegroundColor Green
    $script:InstalledCount++
}

function Install-Copilot {
    Write-Host "`nInstalling for GitHub Copilot..." -ForegroundColor White
    $dest = ".\.github"
    if (-not $DryRun) {
        New-Item -ItemType Directory -Path $dest -Force | Out-Null
        if (Test-Path "$SrcDist\copilot-instructions.md") {
            Copy-Item -Path "$SrcDist\copilot-instructions.md" -Destination "$dest\copilot-instructions.md" -Force
            Write-Host "[OK] Copied copilot-instructions.md to $dest\copilot-instructions.md" -ForegroundColor Green
            $script:InstalledCount++
        }
    }
}

function Install-Cline {
    Write-Host "`nInstalling for Cline / Roo Code..." -ForegroundColor White
    if (-not $DryRun) {
        if (Test-Path "$SrcDist\clinerules") {
            Copy-Item -Path "$SrcDist\clinerules" -Destination ".\.clinerules" -Force
            Write-Host "[OK] Created .\.clinerules" -ForegroundColor Green
            $script:InstalledCount++
        }
    }
}

# Run installation logic
switch ($Target) {
    "Antigravity" { Install-Antigravity }
    "Claude"      { Install-Claude }
    "Cursor"      { Install-Cursor }
    "Windsurf"    { Install-Windsurf }
    "Copilot"     { Install-Copilot }
    "Cline"       { Install-Cline }
    "All"         {
        Install-Antigravity
        Install-Claude
        Install-Cursor
        Install-Windsurf
        Install-Copilot
        Install-Cline
    }
    "Auto" {
        Write-Host "Auto-detecting installed AI coding harnesses..." -ForegroundColor Yellow
        $detected = $false

        if ((Test-Path (Join-Path $HOME ".gemini")) -or (Test-Path ".\.agents")) {
            Install-Antigravity
            $detected = $true
        }

        if ((Test-Path (Join-Path $HOME ".claude")) -or (Test-Path ".\.claude")) {
            Install-Claude
            $detected = $true
        }

        if ((Test-Path (Join-Path $HOME ".cursor")) -or (Test-Path ".\.cursor")) {
            Install-Cursor
            $detected = $true
        }

        if ((Test-Path (Join-Path $HOME ".windsurf")) -or (Test-Path ".\.windsurf")) {
            Install-Windsurf
            $detected = $true
        }

        if (Test-Path ".\.github") {
            Install-Copilot
            $detected = $true
        }

        if (-not $detected) {
            Write-Host "No specific harness detected. Installing default to Claude / Open Skills standard..." -ForegroundColor Yellow
            Install-Claude
        }
    }
}

Write-Host "`n======================================================" -ForegroundColor Green
Write-Host "   Successfully installed to $InstalledCount harness(es)!       " -ForegroundColor Green
Write-Host "======================================================" -ForegroundColor Green
Write-Host "You can now use skills in your chat via:" -ForegroundColor White
Write-Host "  * @teach            (Open learning router)"
Write-Host "  * @teach-roadmap    (Curriculum planning)"
Write-Host "  * @teach-conceptual (Mental models & analogies)"
Write-Host "  * @teach-socratic   (Guided discovery & active recall)"
Write-Host "  * @teach-applied    (Practice problems & hint ladder)"
Write-Host "  * @teach-deepdive   (First principles & formal derivations)"
Write-Host "  * @teach-exam       (Closed-book test & diagnostic report)`n"
