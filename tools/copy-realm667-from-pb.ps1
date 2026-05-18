# Sync Realm667 power-up graphics + audio from a PB2022 checkout into this repo.
# Default layout matches Project Brutality 2022 on disk; Universal uses sounds/Realm667Powerups/ per SNDINFO.txt.
param(
	[string] $PbRoot = (Join-Path (Split-Path $PSScriptRoot -Parent) "ProjectBrutality2022"),
	[string] $UniversalRoot = (Split-Path $PSScriptRoot -Parent)
)

$ErrorActionPreference = "Stop"
$srcSprites = Join-Path $PbRoot "SPRITES\ITEMS\Powerups\Realm667"
$srcSounds  = Join-Path $PbRoot "SOUNDS\Realm667Powerups"
$dstSprites = Join-Path $UniversalRoot "SPRITES\ITEMS\Powerups\Realm667"
$dstSounds  = Join-Path $UniversalRoot "sounds\Realm667Powerups"

foreach ($p in @($srcSprites, $srcSounds)) {
	if (-not (Test-Path $p)) { throw "Missing PB path: $p" }
}

New-Item -ItemType Directory -Force -Path $dstSprites, $dstSounds | Out-Null
Copy-Item -Path (Join-Path $srcSprites "*") -Destination $dstSprites -Force
Copy-Item -Path (Join-Path $srcSounds "*.ogg") -Destination $dstSounds -Force

Write-Host "Sprites: $((Get-ChildItem $dstSprites -File).Count) -> $dstSprites"
Write-Host "Sounds:  $((Get-ChildItem $dstSounds -File).Count) -> $dstSounds"
