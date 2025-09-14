# ─── Activate venv_fle ──────────────────────────────────────────────────────────
$venvPath = "D:\Projects\fle\.venv_fle\Scripts\Activate.ps1"
if (Test-Path $venvPath) {
    & $venvPath
    Write-Host "✅ Activated .venv_fle"
} else {
    Write-Host "❌ venv_fle not found. Run: python -m venv .venv_fle"
    exit 1
}

# ─── Validate Required Packages ─────────────────────────────────────────────────
$required = @("python-dotenv", "mcrcon")
$missing = @()

foreach ($pkg in $required) {
    $installed = python -m pip show $pkg 2>$null
    if (-not $installed) { $missing += $pkg }
}

if ($missing.Count -gt 0) {
    Write-Host "📦 Installing missing packages: $($missing -join ', ')"
    python -m pip install $missing
} else {
    Write-Host "✅ All required packages are installed"
}

# ─── Run RCON Validator ─────────────────────────────────────────────────────────
$validatorPath = "D:\Projects\fle\validators\rcon\rcon_validator.py"
if (Test-Path $validatorPath) {
    Write-Host "🚀 Running RCON validator..."
    python $validatorPath
} else {
    Write-Host "❌ rcon_validator.py not found at expected path"
}