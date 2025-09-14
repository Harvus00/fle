<#
.SYNOPSIS
    Validates RCON endpoint reachability for Factorio server.

.DESCRIPTION
    Attempts TCP connection to specified RCON host and port. Logs success or failure
    with timestamp. Tagged for fle_TOC validator registry.

.TAGS
    fle_TOC, RCON, Factorio, Validator, Connectivity, Automation

#>

param (
    [string]$RconHost = "127.0.0.1",
    [int]$RconPort = 27015
)

$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
$logPath = "D:\Projects\fle\logs\rcon_handshake_$($timestamp -replace '[: ]','_').txt"

try {
    $client = New-Object System.Net.Sockets.TcpClient
    $client.Connect($RconHost, $RconPort)
    Write-Host "✅ RCON endpoint reachable at ${RconHost}:$RconPort"
    Add-Content -Path $logPath -Value "$timestamp — ✅ RCON handshake successful"
    $client.Close()
}
catch {
    Write-Host "❌ RCON endpoint unreachable at ${RconHost}:$RconPort"
    Add-Content -Path $logPath -Value "$timestamp — ❌ RCON handshake failed: $_"
}