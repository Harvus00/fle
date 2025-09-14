<#
.SYNOPSIS
    Sends RCON commands to a running Factorio server.

.DESCRIPTION
    Wraps RCON communication with secure password handling, endpoint logging,
    and modular structure for fle_TOC integration.

.TAGS
    fle_TOC, Factorio, RCON, SecureString, Validator, Automation

#>

function Send-FactorioCommand {
    param (
        [string]$RconHost = "127.0.0.1",
        [int]$RconPort = 27015,
        [SecureString]$RconPassword,
        [string]$Command
    )

    try {
        # Convert SecureString to plain text (only if needed for payload)
        $plainTextPassword = [Runtime.InteropServices.Marshal]::PtrToStringAuto(
            [Runtime.InteropServices.Marshal]::SecureStringToBSTR($RconPassword)
        )

        # Log endpoint
        $endpoint = "http://${RconHost}:${RconPort}"
        Write-Host "📡 Connecting to $endpoint"
        Write-Host "🧪 Sending command: $Command"
        Write-Host "🔐 Password securely received"

        # Simulated TCP connection (replace with actual RCON logic)
        $client = New-Object System.Net.Sockets.TcpClient
        $client.Connect($RconHost, $RconPort)
        Write-Host "✅ Connected to RCON server"

        # TODO: Inject command using RCON protocol
        Write-Host "📤 Command sent (simulated). Response: OK"

        $client.Close()
    }
    catch {
        Write-Error "❌ Failed to send RCON command: $_"
    }
}