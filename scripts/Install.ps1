[CmdletBinding()]
param(
    [string]$VencordPath = (Join-Path $env:USERPROFILE "Documents\Vencord"),
    [ValidateSet("stable", "ptb", "canary")]
    [string]$DiscordBranch = "stable"
)

$ErrorActionPreference = "Stop"
$pluginName = "autoUploadLongMessages"
$downloadUrl = "https://github.com/eric99543/vencord-auto-upload-long-messages/releases/latest/download/$pluginName.zip"
$tempRoot = Join-Path ([System.IO.Path]::GetTempPath()) ("vencord-plugin-" + [guid]::NewGuid())

try {
    if (-not (Test-Path (Join-Path $VencordPath "package.json"))) {
        throw "Vencord source checkout not found at: $VencordPath"
    }

    New-Item -ItemType Directory -Force -Path $tempRoot | Out-Null
    $archive = Join-Path $tempRoot "$pluginName.zip"
    Invoke-WebRequest -Uri $downloadUrl -OutFile $archive
    Expand-Archive -LiteralPath $archive -DestinationPath $tempRoot -Force

    $source = Join-Path $tempRoot $pluginName
    $targetRoot = Join-Path $VencordPath "src\userplugins"
    if (-not (Test-Path (Join-Path $source "index.ts"))) {
        throw "The release archive has an unexpected layout."
    }

    New-Item -ItemType Directory -Force -Path $targetRoot | Out-Null
    Copy-Item -Recurse -Force -LiteralPath $source -Destination $targetRoot

    Push-Location $VencordPath
    try {
        & pnpm build --disable-updater
        if ($LASTEXITCODE -ne 0) { throw "Vencord build failed with exit code $LASTEXITCODE" }

        Get-Process -Name Discord -ErrorAction SilentlyContinue |
            Stop-Process -Force -ErrorAction SilentlyContinue
        & pnpm inject --branch $DiscordBranch
        if ($LASTEXITCODE -ne 0) { throw "Vencord injection failed with exit code $LASTEXITCODE" }
    }
    finally {
        Pop-Location
    }

    $discordUpdater = Join-Path $env:LOCALAPPDATA "Discord\Update.exe"
    if ($DiscordBranch -eq "stable" -and (Test-Path $discordUpdater)) {
        Start-Process -FilePath $discordUpdater -ArgumentList "--processStart", "Discord.exe"
    }

    Write-Host "AutoUploadLongMessages installed successfully."
}
finally {
    if (Test-Path $tempRoot) {
        Remove-Item -Recurse -Force -LiteralPath $tempRoot
    }
}
