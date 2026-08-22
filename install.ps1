#Requires -Version 5.1
<#
.SYNOPSIS
    Installer for the Sailfin compiler binary on Windows.

.DESCRIPTION
    Downloads and installs the Sailfin compiler from GitHub releases.

.EXAMPLE
    # Install latest version:
    irm https://raw.githubusercontent.com/SailfinIO/sailfin/alpha/install.ps1 | iex

    # Install a specific version:
    $env:VERSION = "0.1.1"; irm https://raw.githubusercontent.com/SailfinIO/sailfin/alpha/install.ps1 | iex

.NOTES
    Env overrides:
      REPO           (default: SailfinIO/sailfin)
      VERSION        (default: latest; accepts optional leading v)
      BINARY         (default: sailfin)
      INSTALL_BASE   (default: $env:LOCALAPPDATA\sailfin\versions)
      GLOBAL_BIN_DIR (default: $env:LOCALAPPDATA\sailfin\bin)
      GITHUB_TOKEN   (optional; increases API rate limits)
      SAILFIN_LOCAL_ARCHIVE
                     (optional; install a tarball already on disk instead
                      of a published release. Requires an explicit VERSION
                      and SKIPS signature/digest verification.)

    Assets are expected to be named:
      sailfin_<version>_windows_<arch>-msvc.tar.gz
      sailfin_<version>_windows_<arch>.tar.gz
    where <arch> is x86_64|arm64. The -msvc asset (the native build, with
    working TLS) is preferred when present; the plain asset is the legacy
    mingw cross build and is used as a fallback for releases before
    v0.10.3 and for arm64, which has no -msvc asset at any version.
#>

$ErrorActionPreference = "Stop"

# --- Configuration -----------------------------------------------------------

$Repo       = if ($env:REPO)       { $env:REPO }       else { "SailfinIO/sailfin" }
$Binary     = if ($env:BINARY)     { $env:BINARY }     else { "sailfin" }
$Version    = if ($env:VERSION)    { $env:VERSION }    else { "latest" }
$ExcludeTag = if ($env:EXCLUDE_TAG) { $env:EXCLUDE_TAG } else { "" }
$Token      = $env:GITHUB_TOKEN

# Ed25519 release-signing trust anchor. Keep in sync with the locations listed
# in docs/release-signing.md.
$ReleaseSigningPublicKeyPem = @"
-----BEGIN PUBLIC KEY-----
MCowBQYDK2VwAyEAwxcgcQHwbBCjQWVukG6V1ucZn8qoXZx5NFWwfXQKRLk=
-----END PUBLIC KEY-----
"@

$InstallBase  = if ($env:INSTALL_BASE)   { $env:INSTALL_BASE }   else { Join-Path $env:LOCALAPPDATA "sailfin\versions" }
$GlobalBinDir = if ($env:GLOBAL_BIN_DIR) { $env:GLOBAL_BIN_DIR } else { Join-Path $env:LOCALAPPDATA "sailfin\bin" }

# --- Helpers -----------------------------------------------------------------

function Log($msg) {
    $ts = Get-Date -Format "yyyy-MM-ddTHH:mm:sszzz"
    Write-Host "[$ts] $msg"
}

function Die($msg) {
    Log "Error: $msg"
    throw $msg
}

# --- Detect architecture -----------------------------------------------------

$RawArch = [System.Runtime.InteropServices.RuntimeInformation]::OSArchitecture.ToString().ToLower()
switch ($RawArch) {
    "x64"   { $Arch = "x86_64" }
    "arm64" { $Arch = "arm64" }
    default { Die "Unsupported architecture: $RawArch" }
}

$OS = "windows"
Log "Detected OS: $OS"
Log "Detected ARCH: $Arch"

# --- Optional token for higher API rate limits -------------------------------

$Headers = @{
    "Accept" = "application/vnd.github+json"
}
if ($Token) {
    $Headers["Authorization"] = "token $Token"
}

# --- Offline / local-archive install ------------------------------------------
# Points the installer at a tarball already on disk instead of a published
# GitHub release.
#
# This is the only way to install an archive that has not been published, so
# it is also what lets CI smoke-test a freshly built payload through the real
# installer rather than a hand-rolled copy of its steps. An unpublished
# archive has no signed manifest, so this path necessarily SKIPS release
# signature and digest verification -- it therefore demands an explicit
# VERSION and says plainly that verification was skipped.
$LocalArchive = $env:SAILFIN_LOCAL_ARCHIVE
if ($LocalArchive) {
    if (-not (Test-Path -LiteralPath $LocalArchive -PathType Leaf)) {
        Die "SAILFIN_LOCAL_ARCHIVE='$LocalArchive' is not a readable file."
    }
    $LocalArchive = (Resolve-Path -LiteralPath $LocalArchive).Path
    if (-not $Version -or $Version -eq "latest") {
        Die "SAILFIN_LOCAL_ARCHIVE requires an explicit VERSION (e.g. VERSION=0.9.5); 'latest' cannot be resolved offline."
    }
}

# --- Resolve version and asset -----------------------------------------------

$Tag   = ""
$Asset = ""
# Preference-ordered asset names to try against the release's actual asset
# list once it is fetched (msvc first, then the legacy mingw fallback).
$AssetCandidates = @()

if (-not $Version -or $Version -eq "latest") {
    Log "VERSION is 'latest'; resolving most recent release with matching asset..."
    $ReleasesUrl = "https://api.github.com/repos/$Repo/releases?per_page=50"
    $Releases = Invoke-RestMethod -Uri $ReleasesUrl -Headers $Headers

    foreach ($Rel in $Releases) {
        if ($ExcludeTag -and $Rel.tag_name -eq $ExcludeTag) { continue }
        $Ver = $Rel.tag_name -replace "^v", ""
        $PlainAsset = "${Binary}_${Ver}_${OS}_${Arch}.tar.gz"
        # The msvc build is the native one with working TLS; the plain asset
        # is the legacy mingw cross build being retired by SFN-58. Fall back
        # to it for releases before v0.10.3 and for arm64, which has no
        # -msvc asset at any version (SFN-1033).
        $MsvcAsset = "${Binary}_${Ver}_${OS}_${Arch}-msvc.tar.gz"
        $CandidateAsset = $PlainAsset
        if ($OS -eq "windows" -and ($Rel.assets | Where-Object { $_.name -eq $MsvcAsset })) {
            $CandidateAsset = $MsvcAsset
        }
        $Match = $Rel.assets | Where-Object { $_.name -eq $CandidateAsset }
        if ($Match) {
            $Tag     = $Rel.tag_name
            $Version = $Ver
            $Asset   = $CandidateAsset
            break
        }
    }
    $AssetCandidates = @($Asset)

    if (-not $Tag -or -not $Version -or -not $Asset) {
        if ($ExcludeTag) {
            Die "Could not find any release (excluding '$ExcludeTag') with asset for ${OS}/${Arch}."
        }
        Die "Could not find any release with asset for ${OS}/${Arch}."
    }
} else {
    $Version = $Version -replace "^[vV]", ""
    $Tag   = "v$Version"
    $PlainAsset = "${Binary}_${Version}_${OS}_${Arch}.tar.gz"
    $AssetCandidates = @($PlainAsset)
    if ($OS -eq "windows") {
        # The msvc build is the native one with working TLS; the plain asset
        # is the legacy mingw cross build being retired by SFN-58. The asset
        # list is not fetched at this point (that happens below for the
        # download), so the choice is deferred as a preference-ordered
        # candidate list and resolved once the list is known. Falling back
        # to the plain asset is mandatory: releases before v0.10.3 have no
        # -msvc asset, and arm64 has none at any version (SFN-1033).
        $MsvcAsset = "${Binary}_${Version}_${OS}_${Arch}-msvc.tar.gz"
        $AssetCandidates = @($MsvcAsset, $PlainAsset)
    }
    $Asset = $AssetCandidates[0]
}

Log "Using release tag: $Tag"
Log "Using version: $Version"

# --- Download asset ----------------------------------------------------------

$TmpDir = Join-Path ([System.IO.Path]::GetTempPath()) "sailfin-install-$([guid]::NewGuid().ToString('N'))"
New-Item -ItemType Directory -Path $TmpDir -Force | Out-Null

$DownloadHeaders = @{
    "Accept" = "application/octet-stream"
}
if ($Token) {
    $DownloadHeaders["Authorization"] = "token $Token"
}

if ($LocalArchive) {
    Log "Installing from local archive: $LocalArchive"
    $Asset = Split-Path -Leaf $LocalArchive
    $ArchivePath = $LocalArchive
} else {
    $ReleaseUrl  = "https://api.github.com/repos/$Repo/releases/tags/$Tag"
    $ReleaseJson = Invoke-RestMethod -Uri $ReleaseUrl -Headers $Headers

    # Resolve the first candidate (msvc preferred, plain as fallback) that is
    # actually present in this release's asset list.
    $AssetObj = $null
    foreach ($Candidate in $AssetCandidates) {
        $AssetObj = $ReleaseJson.assets | Where-Object { $_.name -eq $Candidate } | Select-Object -First 1
        if ($AssetObj) {
            $Asset = $Candidate
            break
        }
    }
    if (-not $AssetObj) {
        # Name every candidate that was tried, not just the preferred one --
        # reporting only the msvc name would read as "this release is missing
        # its native build" when the plain asset is equally absent.
        Die "Could not find any of [$($AssetCandidates -join ', ')] in release '$Tag'."
    }
    Log "Expected asset: $Asset"

    $AssetId = $AssetObj.id
    $ArchivePath = Join-Path $TmpDir $Asset
    Log "Downloading asset via GitHub API (id=$AssetId)..."

    $DownloadUrl = "https://api.github.com/repos/$Repo/releases/assets/$AssetId"
    Invoke-WebRequest -Uri $DownloadUrl -Headers $DownloadHeaders -OutFile $ArchivePath
}

# --- Verify signed release manifest -----------------------------------------

function Verify-ReleaseArchive {
    param(
        [string]$RepoName,
        [string]$ReleaseTag,
        [string]$AssetName,
        [string]$Archive,
        [string]$WorkDir,
        [hashtable]$RequestHeaders
    )

    $ManifestPath = Join-Path $WorkDir "SHA256SUMS"
    $SignatureHexPath = Join-Path $WorkDir "SHA256SUMS.sig"
    $SignatureRawPath = Join-Path $WorkDir "SHA256SUMS.sig.raw"
    $PublicKeyPath = Join-Path $WorkDir "ed25519-release.pub.pem"
    $VerificationBase = "https://github.com/$RepoName/releases/download/$ReleaseTag"

    try {
        Invoke-WebRequest -Uri "$VerificationBase/SHA256SUMS" -Headers $RequestHeaders -OutFile $ManifestPath
        Invoke-WebRequest -Uri "$VerificationBase/SHA256SUMS.sig" -Headers $RequestHeaders -OutFile $SignatureHexPath
    } catch {
        Log "Warning: release '$ReleaseTag' has no signed SHA256SUMS manifest; continuing without bootstrap signature verification."
        return
    }

    $OpenSsl = Get-Command openssl -ErrorAction SilentlyContinue
    $OpenSslVersion = if ($OpenSsl) { (& openssl version 2>$null) } else { "" }
    if (-not $OpenSsl -or $LASTEXITCODE -ne 0 -or $OpenSslVersion -notmatch '^OpenSSL (1\.1\.1|[2-9][0-9]*\.)') {
        Log "Warning: OpenSSL 1.1.1+ with raw Ed25519 support is unavailable; continuing without bootstrap signature verification."
        return
    }

    $SignatureHex = ((Get-Content -Raw $SignatureHexPath) -replace '\s', '')
    if ($SignatureHex -notmatch '^[0-9a-fA-F]{128}$') {
        Die "Release manifest signature is malformed; refusing to install '$AssetName'."
    }

    $SignatureBytes = New-Object byte[] 64
    for ($i = 0; $i -lt 64; $i++) {
        $SignatureBytes[$i] = [Convert]::ToByte($SignatureHex.Substring($i * 2, 2), 16)
    }
    [IO.File]::WriteAllBytes($SignatureRawPath, $SignatureBytes)
    [IO.File]::WriteAllText($PublicKeyPath, $ReleaseSigningPublicKeyPem, [Text.Encoding]::ASCII)

    & openssl pkeyutl -verify -pubin -inkey $PublicKeyPath -rawin `
        -in $ManifestPath -sigfile $SignatureRawPath 2>$null | Out-Null
    if ($LASTEXITCODE -ne 0) {
        Die "Release manifest signature verification failed; refusing to install '$AssetName'."
    }

    $ManifestDigests = @()
    foreach ($Line in (Get-Content $ManifestPath)) {
        if ($Line -match '^([0-9a-fA-F]{64})\s+\*?(.+)$' -and $Matches[2] -eq $AssetName) {
            $ManifestDigests += $Matches[1]
        }
    }
    if ($ManifestDigests.Count -ne 1) {
        Die "Signed release manifest does not contain exactly one entry for '$AssetName'."
    }

    $Sha256 = [Security.Cryptography.SHA256]::Create()
    try {
        $Stream = [IO.File]::OpenRead($Archive)
        try { $DigestBytes = $Sha256.ComputeHash($Stream) } finally { $Stream.Dispose() }
    } finally {
        $Sha256.Dispose()
    }
    $ActualDigest = ([BitConverter]::ToString($DigestBytes) -replace '-', '').ToLowerInvariant()
    if ($ActualDigest -ne $ManifestDigests[0].ToLowerInvariant()) {
        Die "SHA-256 digest mismatch for '$AssetName'; refusing to install it."
    }
}

# Verification runs before extraction or creation of an install destination, so
# detected tampering cannot leave an installed binary behind.
if ($LocalArchive) {
    # A locally built archive has no signed release manifest to check against.
    # Say so rather than letting a silent skip read as a passed verification.
    Log "Warning: local archive install -- release signature and digest verification are SKIPPED."
} else {
    Verify-ReleaseArchive -RepoName $Repo -ReleaseTag $Tag -AssetName $Asset `
        -Archive $ArchivePath -WorkDir $TmpDir -RequestHeaders $DownloadHeaders
}

# --- Extract archive ---------------------------------------------------------

$ExtractDir = Join-Path $TmpDir "extract"
New-Item -ItemType Directory -Path $ExtractDir -Force | Out-Null

Log "Extracting $Asset..."
tar -xzf $ArchivePath -C $ExtractDir
if ($LASTEXITCODE -ne 0) {
    Die "Failed to extract archive. Ensure 'tar' is available (ships with Windows 10+)."
}

# Locate the root of extracted content.
$RootDir = $ExtractDir
if (-not (Test-Path (Join-Path $ExtractDir "bin")) -and
    -not (Test-Path (Join-Path $ExtractDir "$Binary.exe")) -and
    -not (Test-Path (Join-Path $ExtractDir $Binary))) {
    $FirstDir = Get-ChildItem -Path $ExtractDir -Directory | Select-Object -First 1
    if ($FirstDir) { $RootDir = $FirstDir.FullName }
}

# Find the binary.
$SrcBinary = $null
$Candidates = @(
    (Join-Path $RootDir "$Binary.exe"),
    (Join-Path $RootDir "bin\$Binary.exe"),
    (Join-Path $RootDir $Binary),
    (Join-Path $RootDir "bin\$Binary")
)
foreach ($c in $Candidates) {
    if (Test-Path $c) { $SrcBinary = $c; break }
}
if (-not $SrcBinary) {
    Die "Binary '$Binary.exe' not found in archive."
}

# --- Install -----------------------------------------------------------------

$TargetDir = Join-Path $InstallBase $Version
New-Item -ItemType Directory -Path $TargetDir -Force | Out-Null

$DestName = if ($SrcBinary -match '\.exe$') { "$Binary.exe" } else { $Binary }
$DestPath = Join-Path $TargetDir $DestName

Log "Installing to $TargetDir..."
Copy-Item -Path $SrcBinary -Destination $DestPath -Force

# Install runtime bundle if present.
$RuntimeSrc = Join-Path $RootDir "runtime"
$RuntimeDest = Join-Path $TargetDir "runtime"
if (Test-Path $RuntimeSrc) {
    Log "Installing runtime bundle to $TargetDir\runtime..."
    if (Test-Path $RuntimeDest) { Remove-Item -Recurse -Force $RuntimeDest }
    Copy-Item -Path $RuntimeSrc -Destination $RuntimeDest -Recurse
} else {
    Log "Warning: runtime bundle not found in archive; sfn run/build will fail without it."
}

# The compiler/runtime workspace dependency closure, staged by
# `sfn package --installer` (SFN-773, SFN-937) as a sibling of runtime\ -- the
# compatibility shape installed dependency discovery resolves.
$CapsulesSrc = Join-Path $RootDir "capsules"
$CapsulesDest = Join-Path $TargetDir "capsules"
if (Test-Path $CapsulesSrc) {
    Log "Installing runtime capsule dependencies to $TargetDir\capsules..."
    if (Test-Path $CapsulesDest) { Remove-Item -Recurse -Force $CapsulesDest }
    Copy-Item -Path $CapsulesSrc -Destination $CapsulesDest -Recurse
}

# SFN-937: publish the generated workspace manifest only after the canonical
# capsule payload it names. Older archives have no workspace manifest.
$WorkspaceSrc = Join-Path $RootDir "workspace.toml"
$WorkspaceDest = Join-Path $TargetDir "workspace.toml"
if (Test-Path $WorkspaceDest) { Remove-Item -Force $WorkspaceDest }
if (Test-Path $WorkspaceSrc) {
    if (-not (Test-Path $CapsulesDest)) {
        throw "Bundled workspace manifest has no installed capsule payload."
    }
    Log "Installing bundled workspace manifest to $TargetDir\workspace.toml..."
    Copy-Item -Path $WorkspaceSrc -Destination $WorkspaceDest -Force
}

# --- Copies in global bin dir ------------------------------------------------

New-Item -ItemType Directory -Path $GlobalBinDir -Force | Out-Null

$PointerPath = Join-Path $GlobalBinDir "sailfin-install-root"
$GlobalPayloadOwned = Test-Path $PointerPath
if ($GlobalPayloadOwned) {
    foreach ($LegacyName in @("runtime", "capsules", "workspace.toml")) {
        $LegacyPath = Join-Path $GlobalBinDir $LegacyName
        if (Test-Path $LegacyPath) { Remove-Item -Recurse -Force $LegacyPath }
    }
}
if (Test-Path $PointerPath) { Remove-Item -Force $PointerPath }

$Aliases = @($DestName)
if ($DestName -match '\.exe$') {
    $Aliases += "sfn.exe"
    $Aliases += "sailfin.exe"
} else {
    $Aliases += "sfn"
    $Aliases += "sailfin"
}

foreach ($Alias in ($Aliases | Select-Object -Unique)) {
    $LinkPath = Join-Path $GlobalBinDir $Alias
    if (Test-Path $LinkPath) { Remove-Item -Force $LinkPath }
    Copy-Item -Path $DestPath -Destination $LinkPath -Force
    Log "Installed: $LinkPath"
}

# Published compilers predating SFN-937 cannot read the install-root pointer.
# Their archives have no workspace.toml, so mirror their runtime dependency
# payload beside the copied executable. New archives use only the pointer.
if (-not (Test-Path $WorkspaceSrc)) {
    foreach ($LegacyName in @("runtime", "capsules", "workspace.toml")) {
        $LegacyPath = Join-Path $GlobalBinDir $LegacyName
        if ((Test-Path $LegacyPath) -and -not $GlobalPayloadOwned) {
            throw "Refusing to replace unowned $LegacyPath for legacy installer compatibility."
        }
    }
    if (Test-Path $RuntimeDest) {
        Copy-Item -Path $RuntimeDest -Destination (Join-Path $GlobalBinDir "runtime") -Recurse
    }
    if (Test-Path $CapsulesDest) {
        Copy-Item -Path $CapsulesDest -Destination (Join-Path $GlobalBinDir "capsules") -Recurse
    }
    Log "Installed adjacent payload mirror for pre-SFN-937 compiler compatibility."
}

# Copied executables report GLOBAL_BIN_DIR as their own directory. Publish the
# canonical version root after all executable copies so compiler startup can
# recover the runtime/workspace discovery anchor without changing sfn.exe.
$TargetDirResolved = (Resolve-Path -LiteralPath $TargetDir).Path
$Utf8NoBom = New-Object System.Text.UTF8Encoding($false)
[System.IO.File]::WriteAllText($PointerPath, $TargetDirResolved, $Utf8NoBom)
Log "Installed payload pointer: $PointerPath -> $TargetDirResolved"

# --- Update user PATH --------------------------------------------------------

$UserPath = [Environment]::GetEnvironmentVariable("Path", "User")
if ($UserPath -split ";" -notcontains $GlobalBinDir) {
    Log "Adding $GlobalBinDir to user PATH..."
    [Environment]::SetEnvironmentVariable("Path", "$GlobalBinDir;$UserPath", "User")
    # Also update current session so the binary is immediately available.
    $env:Path = "$GlobalBinDir;$env:Path"
    Log "PATH updated. You may need to restart your terminal for the change to take effect."
} else {
    Log "$GlobalBinDir is already in PATH."
}

# --- Cleanup -----------------------------------------------------------------

Remove-Item -Recurse -Force $TmpDir -ErrorAction SilentlyContinue

Log "Installed: $DestPath"
Log "Ready! Run 'sfn version' to verify."
