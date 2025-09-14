<#
.SYNOPSIS
    Tests Git remote URL and branch sync status before push.

.DESCRIPTION
    Detects malformed remote URLs (e.g., 'hppts'), confirms expected origin,
    checks for non-fast-forward conditions, and logs results for fle_TOC traceability.

.TAGS
    fle_TOC, Git, Validator, RemoteURL, PushAudit

#>

function Test-GitRemote {
    param (
        [string]$RepoPath = (Get-Location),
        [string]$ExpectedRemote = "https://github.com/harvus00/fle.git",
        [string]$Branch = "main"
    )

    Write-Host "`n🔍 Testing Git remote in: $RepoPath"

    try {
        Set-Location $RepoPath

        $remoteUrl = git remote get-url origin 2>$null
        if (-not $remoteUrl) {
            Write-Warning "❌ No remote 'origin' found."
            return
        }

        if ($remoteUrl -match "hppts") {
            Write-Warning "⚠️ Malformed remote URL detected: $remoteUrl"
            Write-Host "🔧 Correcting to: $ExpectedRemote"
            git remote set-url origin $ExpectedRemote
            $remoteUrl = $ExpectedRemote
        }

        if ($remoteUrl -ne $ExpectedRemote) {
            Write-Warning "⚠️ Remote URL mismatch. Expected: $ExpectedRemote"
        } else {
            Write-Host "✅ Remote URL is valid."
        }

        Write-Host "🔄 Fetching remote branch state..."
        git fetch origin $Branch

        $localHash  = git rev-parse $Branch
        $remoteHash = git rev-parse origin/$Branch

        if ($localHash -ne $remoteHash) {
            Write-Warning "⚠️ Local '$Branch' is behind remote. Consider pulling before pushing."
        } else {
            Write-Host "✅ Local '$Branch' is up to date with remote."
        }

        Write-Host "🧪 Git remote test complete.`n"
    }
    catch {
        Write-Error "❌ Exception during Git remote test: $_"
    }
}

# Invoke the test
Test-GitRemote