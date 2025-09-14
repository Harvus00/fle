<#
.SYNOPSIS
    Executes all validator modules in fle\validators and logs results.

.DESCRIPTION
    Recursively scans $Env:ValidatorRoot for .ps1 files, executes each validator,
    and logs pass/fail status with timestamp. Tagged for fle_TOC integration.

.TAGS
    fle_TOC, ValidatorRunner, Automation, Logging, ModularExecution

#>
if ($global:ValidatorRunnerActive) {
    Write-Host "🛑 Validator runner already active. Skipping re-entry."
    return
}
$global:ValidatorRunnerActive = $true

# Ensure ValidatorRoot is set
if (-not $Env:ValidatorRoot) {
    $Env:ValidatorRoot = "D:\Projects\fle\validators"
}

# Create logs directory if missing
$logDir = "D:\Projects\fle\logs"
if (-not (Test-Path $logDir)) {
    New-Item -Path $logDir -ItemType Directory | Out-Null
}

# Timestamped log file
$timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
$logPath = Join-Path $logDir "validator_run_$timestamp.txt"

# Discover validator scripts
$validators = Get-ChildItem -Path $Env:ValidatorRoot -Filter *.ps1 -Recurse

# Execute each validator
foreach ($validator in $validators) {
    try {
    . $validator.FullName
    Add-Content -Path $logPath -Value "✅ $($validator.Name) passed at $timestamp"
    }
catch {
    Write-Host "❌ Validator failed: $($validator.Name)"
    Add-Content -Path $logPath -Value "❌ $($validator.Name) failed at $timestamp — $_"
    }
}

Write-Host "Validator run complete. Log saved to: $logPath"