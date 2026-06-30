# Build "Universal Kill Streaks and PowerUp Rewards.wad" (PK3-style zip) and deploy to Steam ADDONS.
param(
    [string]$SourceRoot = (Split-Path $PSScriptRoot -Parent),
    [string]$AddonsRoot = 'C:\Program Files (x86)\Steam\steamapps\common\Ultimate Doom\(Doom Mod Builds)\.ADDONSs',
    [string]$WadName = 'Universal Kill Streaks and PowerUp Rewards.wad'
)

$ErrorActionPreference = 'Stop'
Add-Type -AssemblyName System.IO.Compression
Add-Type -AssemblyName System.IO.Compression.FileSystem

function Build-KillStreaksWad {
    param([string]$Root, [string]$OutFile)

    if (Test-Path -LiteralPath $OutFile) { Remove-Item -LiteralPath $OutFile -Force }

    $excludeDirs = @('.git', 'tools')
    $excludeFiles = @('README.md', '.gitattributes')

    $zip = [System.IO.Compression.ZipFile]::Open($OutFile, [System.IO.Compression.ZipArchiveMode]::Create)
    try {
        Get-ChildItem -LiteralPath $Root -Recurse -File | ForEach-Object {
            $rel = $_.FullName.Substring($Root.Length).TrimStart('\', '/')
            $top = ($rel -split '[\\/]')[0]
            if ($excludeDirs -contains $top) { return }
            if ($excludeFiles -contains $_.Name) { return }

            $entryName = $rel.Replace('\', '/')
            [void][System.IO.Compression.ZipFileExtensions]::CreateEntryFromFile(
                $zip, $_.FullName, $entryName, [System.IO.Compression.CompressionLevel]::Optimal)
        }
    }
    finally {
        $zip.Dispose()
    }
}

function Update-WadInBundleZip {
    param([string]$ZipPath, [string]$NewWadPath, [string]$EntryName)

    $tempZip = "$ZipPath.new"
    if (Test-Path -LiteralPath $tempZip) { Remove-Item -LiteralPath $tempZip -Force }

    $src = [System.IO.Compression.ZipFile]::OpenRead($ZipPath)
    $dest = [System.IO.Compression.ZipFile]::Open($tempZip, [System.IO.Compression.ZipArchiveMode]::Create)
    try {
        foreach ($entry in $src.Entries) {
            if ($entry.FullName -eq $EntryName) { continue }
            if ($entry.FullName.EndsWith('/')) {
                [void]$dest.CreateEntry($entry.FullName, [System.IO.Compression.CompressionLevel]::Optimal)
                continue
            }
            $newEntry = $dest.CreateEntry($entry.FullName, [System.IO.Compression.CompressionLevel]::Optimal)
            $inStream = $entry.Open()
            $outStream = $newEntry.Open()
            try { $inStream.CopyTo($outStream) }
            finally {
                $inStream.Close()
                $outStream.Close()
            }
        }
        [void][System.IO.Compression.ZipFileExtensions]::CreateEntryFromFile(
            $dest, $NewWadPath, $EntryName, [System.IO.Compression.CompressionLevel]::Optimal)
    }
    finally {
        $src.Dispose()
        $dest.Dispose()
    }

    Move-Item -LiteralPath $tempZip -Destination $ZipPath -Force
}

$SourceRoot = (Resolve-Path -LiteralPath $SourceRoot).Path
$stagingWad = Join-Path $env:TEMP $WadName
$folderTarget = Join-Path $AddonsRoot '(UNIVERSAL_DASH_GORE_KICK_TILT)'
$folderWad = Join-Path $folderTarget $WadName

Write-Host "Building from: $SourceRoot"
Build-KillStreaksWad -Root $SourceRoot -OutFile $stagingWad
$built = Get-Item -LiteralPath $stagingWad
Write-Host "Built $($built.Name): $([math]::Round($built.Length/1MB, 2)) MB, $(
    ([System.IO.Compression.ZipFile]::OpenRead($stagingWad).Entries.Count)
) lumps"

Copy-Item -LiteralPath $stagingWad -Destination $folderWad -Force
Write-Host "Updated folder: $folderWad"

Get-ChildItem -LiteralPath $AddonsRoot | Where-Object { $_.Name -like '(UNIVERSAL*.zip' } | ForEach-Object {
    Write-Host "Updating bundle: $($_.Name)"
    Update-WadInBundleZip -ZipPath $_.FullName -NewWadPath $stagingWad -EntryName $WadName
}

Write-Host "Done."
