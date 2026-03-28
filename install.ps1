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

    Assets are expected to be named:
      sailfin_<version>_windows_<arch>.tar.gz
    where <arch> is x86_64|arm64.
#>

$ErrorActionPreference = "Stop"

# --- Configuration -----------------------------------------------------------

$Repo       = if ($env:REPO)       { $env:REPO }       else { "SailfinIO/sailfin" }
$Binary     = if ($env:BINARY)     { $env:BINARY }     else { "sailfin" }
$Version    = if ($env:VERSION)    { $env:VERSION }    else { "latest" }
$ExcludeTag = if ($env:EXCLUDE_TAG) { $env:EXCLUDE_TAG } else { "" }
$Token      = $env:GITHUB_TOKEN

$InstallBase  = if ($env:INSTALL_BASE)   { $env:INSTALL_BASE }   else { Join-Path $env:LOCALAPPDATA "sailfin\versions" }
$GlobalBinDir = if ($env:GLOBAL_BIN_DIR) { $env:GLOBAL_BIN_DIR } else { Join-Path $env:LOCALAPPDATA "sailfin\bin" }

# --- Helpers -----------------------------------------------------------------

function Log($msg) {
    $ts = Get-Date -Format "yyyy-MM-ddTHH:mm:sszzz"
    Write-Host "[$ts] $msg"
}

function Die($msg) {
    Log "Error: $msg"
    exit 1
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

# --- Resolve version and asset -----------------------------------------------

$Tag   = ""
$Asset = ""

if (-not $Version -or $Version -eq "latest") {
    Log "VERSION is 'latest'; resolving most recent release with matching asset..."
    $ReleasesUrl = "https://api.github.com/repos/$Repo/releases?per_page=50"
    $Releases = Invoke-RestMethod -Uri $ReleasesUrl -Headers $Headers

    foreach ($Rel in $Releases) {
        if ($ExcludeTag -and $Rel.tag_name -eq $ExcludeTag) { continue }
        $Ver = $Rel.tag_name -replace "^v", ""
        $CandidateAsset = "${Binary}_${Ver}_${OS}_${Arch}.tar.gz"
        $Match = $Rel.assets | Where-Object { $_.name -eq $CandidateAsset }
        if ($Match) {
            $Tag     = $Rel.tag_name
            $Version = $Ver
            $Asset   = $CandidateAsset
            break
        }
    }

    if (-not $Tag -or -not $Version -or -not $Asset) {
        if ($ExcludeTag) {
            Die "Could not find any release (excluding '$ExcludeTag') with asset for ${OS}/${Arch}."
        }
        Die "Could not find any release with asset for ${OS}/${Arch}."
    }
} else {
    $Version = $Version -replace "^[vV]", ""
    $Tag   = "v$Version"
    $Asset = "${Binary}_${Version}_${OS}_${Arch}.tar.gz"
}

Log "Using release tag: $Tag"
Log "Using version: $Version"
Log "Expected asset: $Asset"

# --- Download asset ----------------------------------------------------------

$ReleaseUrl  = "https://api.github.com/repos/$Repo/releases/tags/$Tag"
$ReleaseJson = Invoke-RestMethod -Uri $ReleaseUrl -Headers $Headers

$AssetObj = $ReleaseJson.assets | Where-Object { $_.name -eq $Asset } | Select-Object -First 1
if (-not $AssetObj) {
    Die "Could not find asset '$Asset' in release '$Tag'."
}

$AssetId = $AssetObj.id
$TmpDir  = Join-Path ([System.IO.Path]::GetTempPath()) "sailfin-install-$([guid]::NewGuid().ToString('N'))"
New-Item -ItemType Directory -Path $TmpDir -Force | Out-Null

$ArchivePath = Join-Path $TmpDir $Asset
Log "Downloading asset via GitHub API (id=$AssetId)..."

$DownloadHeaders = @{
    "Accept" = "application/octet-stream"
}
if ($Token) {
    $DownloadHeaders["Authorization"] = "token $Token"
}
$DownloadUrl = "https://api.github.com/repos/$Repo/releases/assets/$AssetId"
Invoke-WebRequest -Uri $DownloadUrl -Headers $DownloadHeaders -OutFile $ArchivePath

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
if (Test-Path $RuntimeSrc) {
    Log "Installing runtime bundle to $TargetDir\runtime..."
    $RuntimeDest = Join-Path $TargetDir "runtime"
    if (Test-Path $RuntimeDest) { Remove-Item -Recurse -Force $RuntimeDest }
    Copy-Item -Path $RuntimeSrc -Destination $RuntimeDest -Recurse
} else {
    Log "Warning: runtime bundle not found in archive; sfn run/build will fail without it."
}

# --- Symlinks / copies in global bin dir -------------------------------------

New-Item -ItemType Directory -Path $GlobalBinDir -Force | Out-Null

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
