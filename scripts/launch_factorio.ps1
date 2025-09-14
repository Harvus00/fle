# ─── Config ─────────────────────────────────────────────────────────────────────
$factorioExe = "C:\FacServer\bin\x64\factorio.exe"
$mapZip      = "C:\FactorioAutomation\FLE_O1.zip"
$rconPort    = "25575"
$rconPass    = "Ank3lz100"

# ─── Logging ─────────────────────────────────────────────────────────────────────
$timestamp = Get-Date -Format "yyyy-MM-dd_HH-mm-ss"
$logPath   = "D:\Projects\fle\logs\factorio_launch_$timestamp.log"
New-Item -ItemType File -Path $logPath -Force | Out-Null

# ─── CMD-style Launch ────────────────────────────────────────────────────────────
$cmd = 'start /wait "" "C:\FacServer\bin\x64\factorio.exe" --start-server "C:\FactorioAutomation\FLE_O1.zip" --rcon-port 25575 --rcon-password "Ank3lz100"'
Write-Host "🚀 Launching Factorio via CMD shell..."
try {
    cmd.exe /c $cmd
    Write-Host "✅ Server launched successfully"
} catch {
    Write-Host "❌ CMD launch failed: $_"
}