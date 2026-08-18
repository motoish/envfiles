$ErrorActionPreference = "Stop"

$SourceDir = Split-Path -Parent $MyInvocation.MyCommand.Path

if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
    throw "winget is required. Install App Installer from Microsoft Store first."
}

if (-not (Get-Command chezmoi -ErrorAction SilentlyContinue)) {
    winget install --id twpayne.chezmoi --exact --accept-source-agreements --accept-package-agreements
    $env:Path = [Environment]::GetEnvironmentVariable("Path", "User") + ";" + [Environment]::GetEnvironmentVariable("Path", "Machine")
}

if (-not (Get-Command chezmoi -ErrorAction SilentlyContinue)) {
    throw "chezmoi was installed, but is not available in this PowerShell session. Restart PowerShell and run this script again."
}

chezmoi --source $SourceDir apply
