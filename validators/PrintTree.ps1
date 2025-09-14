<#
.SYNOPSIS
    Captures and logs the directory tree of the FLE project.

.DESCRIPTION
    Runs `tree` on the FLE root directory, outputs to a timestamped log file,
    and ensures the logs folder exists. Tagged for fle_TOC traceability.

.TAGS
    fle_TOC, Validator, DirectoryStructure, TreeSnapshot

#>

# Ensure logs directory exists
$logDir = "D:\Projects\fle\logs"
if (-not (Test-Path $logDir)) {
    New-Item -Path $logDir -ItemType Directory | Out-Null
}

# Generate timestamped log path
$timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
$logPath = Join-Path $logDir "tree_$timestamp.txt"

# Run tree and output to file
tree /f /a "D:\Projects\fle" | Out-File -FilePath $logPath -Encoding ASCII

Write-Host "✅ Directory tree saved to: $logPath"

