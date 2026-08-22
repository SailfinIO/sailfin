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
      SAILFIN_RELEASE_BASE
                     (optional; overrides where SHA256SUMS, SHA256SUMS.sig
                      and the archive are fetched from. Location only --
                      verification is unconditional and the trust anchor is
                      never overridable.)
      SAILFIN_LOCAL_ARCHIVE
                     (optional; install a tarball already on disk instead
                      of a published release. Requires an explicit VERSION.)
      SAILFIN_LOCAL_ARCHIVE_SHA256
                     (optional; expected SHA-256 of SAILFIN_LOCAL_ARCHIVE.
                      Supplying it pins the archive by digest instead of
                      installing it unverified.)
      SAILFIN_ALLOW_UNVERIFIED
                     (set to 1 to consent to installing an artifact whose
                      signature chain cannot be established -- an unsigned
                      historical release, or a local archive with no
                      expected digest. It NEVER bypasses a check that could
                      have run: a failed signature, a digest mismatch, or a
                      malformed manifest still aborts.)

    Trust policy (SFN-1034, SFEP-0073 section 3.7): this installer fails
    closed. A missing SHA256SUMS or SHA256SUMS.sig aborts the install unless
    SAILFIN_ALLOW_UNVERIFIED=1 is set. Signature verification uses an
    embedded Ed25519 implementation and requires no external tooling, so
    there is no host on which verification silently does not run.

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

# Ed25519 release-signing trust anchor: the raw 32-byte public key as lowercase
# hex, the form the embedded verifier below consumes. Identical to
# RELEASE_SIGNING_PUBLIC_KEY_HEX in compiler/src/release_trust.sfn. Keep in sync
# with every location listed in docs/release-signing.md.
#
# There is deliberately no environment override for this value. A knob that
# swaps the trust anchor is a one-line social-engineering exploit.
$ReleaseSigningPublicKeyHex = "c317207101f06c10a341656e906e95d6e7199fcaa85d9c793455b07d740a44b9"

$AllowUnverified = ($env:SAILFIN_ALLOW_UNVERIFIED -eq "1")
$ReleaseBase = $env:SAILFIN_RELEASE_BASE

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

# --- Embedded Ed25519 verifier (SFN-1034) ------------------------------------
# Verify-only Ed25519 (RFC 8032) over System.Numerics.BigInteger and
# System.Security.Cryptography.SHA512, both present on .NET Framework 4.x and
# therefore on the #Requires -Version 5.1 floor.
#
# Why this exists rather than shelling out to `openssl pkeyutl -rawin`: a stock
# Windows host has no OpenSSL, so the OpenSSL path made verification silently
# unreachable for exactly the users running this script, while CI -- whose
# runner image does carry OpenSSL -- exercised a path no user runs. Deleting
# the external dependency makes the verified path the only path. It also
# removes the OpenSSL version gate, which tested for 1.1.1+ when `pkeyutl
# -rawin` in fact arrived in 3.0 (see
# .github/actions/sailfin-build-windows/verify-release-seed.ps1).
#
# Only the arithmetic needed to verify is implemented. There is no signing
# path, no key generation, and no secret material, so the constant-time
# concerns that normally rule out a scripted implementation do not apply: every
# input here is public.

$script:_Ed25519P = [System.Numerics.BigInteger]::Pow(2, 255) - 19
$script:_Ed25519L = [System.Numerics.BigInteger]::Pow(2, 252) + [System.Numerics.BigInteger]::Parse("27742317777372353535851937790883648493")

function _Ed25519Mod([System.Numerics.BigInteger]$a) {
    $r = $a % $script:_Ed25519P
    if ($r.Sign -lt 0) { $r += $script:_Ed25519P }
    return $r
}

function _Ed25519Inv([System.Numerics.BigInteger]$a) {
    return [System.Numerics.BigInteger]::ModPow((_Ed25519Mod $a), $script:_Ed25519P - 2, $script:_Ed25519P)
}

$script:_Ed25519D = _Ed25519Mod ((_Ed25519Mod ([System.Numerics.BigInteger]-121665)) * (_Ed25519Inv ([System.Numerics.BigInteger]121666)))
$script:_Ed25519I = [System.Numerics.BigInteger]::ModPow([System.Numerics.BigInteger]2, ($script:_Ed25519P - 1) / 4, $script:_Ed25519P)

# Points are extended twisted-Edwards coordinates (X, Y, Z, T) with a = -1.
function _Ed25519PointAdd($p1, $p2) {
    $a = _Ed25519Mod (($p1[1] - $p1[0]) * ($p2[1] - $p2[0]))
    $b = _Ed25519Mod (($p1[1] + $p1[0]) * ($p2[1] + $p2[0]))
    $c = _Ed25519Mod ($p1[3] * 2 * $script:_Ed25519D * $p2[3])
    $d = _Ed25519Mod ($p1[2] * 2 * $p2[2])
    $e = $b - $a; $f = $d - $c; $g = $d + $c; $h = $b + $a
    return @((_Ed25519Mod ($e * $f)), (_Ed25519Mod ($g * $h)), (_Ed25519Mod ($f * $g)), (_Ed25519Mod ($e * $h)))
}

function _Ed25519PointDouble($p1) {
    $a = _Ed25519Mod ($p1[0] * $p1[0])
    $b = _Ed25519Mod ($p1[1] * $p1[1])
    $c = _Ed25519Mod (2 * $p1[2] * $p1[2])
    $d = _Ed25519Mod (-$a)
    $e = _Ed25519Mod ((_Ed25519Mod (($p1[0] + $p1[1]) * ($p1[0] + $p1[1]))) - $a - $b)
    $g = $d + $b; $f = $g - $c; $h = $d - $b
    return @((_Ed25519Mod ($e * $f)), (_Ed25519Mod ($g * $h)), (_Ed25519Mod ($f * $g)), (_Ed25519Mod ($e * $h)))
}

function _Ed25519PointMul($pt, [System.Numerics.BigInteger]$n) {
    $q = @([System.Numerics.BigInteger]0, [System.Numerics.BigInteger]1, [System.Numerics.BigInteger]1, [System.Numerics.BigInteger]0)
    $bits = New-Object System.Collections.ArrayList
    $t = $n
    while ($t -gt 0) { [void]$bits.Add([int]($t % 2)); $t = $t / 2 }
    for ($i = $bits.Count - 1; $i -ge 0; $i--) {
        $q = _Ed25519PointDouble $q
        if ($bits[$i] -eq 1) { $q = _Ed25519PointAdd $q $pt }
    }
    return $q
}

# Recover x from y on the curve, or $null when y encodes no curve point.
function _Ed25519XRecover([System.Numerics.BigInteger]$y) {
    $yy = _Ed25519Mod ($y * $y)
    $u = _Ed25519Mod ($yy - 1)
    $v = _Ed25519Mod ($script:_Ed25519D * $yy + 1)
    $uv = _Ed25519Mod ($u * (_Ed25519Inv $v))
    $x = [System.Numerics.BigInteger]::ModPow($uv, ($script:_Ed25519P + 3) / 8, $script:_Ed25519P)
    if ((_Ed25519Mod ($x * $x - $uv)) -ne 0) { $x = _Ed25519Mod ($x * $script:_Ed25519I) }
    if ((_Ed25519Mod ($x * $x * $v - $u)) -ne 0) { return $null }
    return $x
}

function _Ed25519HexToBytes([string]$h) {
    $n = $h.Length / 2
    $r = New-Object byte[] $n
    for ($i = 0; $i -lt $n; $i++) { $r[$i] = [Convert]::ToByte($h.Substring($i * 2, 2), 16) }
    return ,$r
}

# Little-endian byte string to BigInteger. The extra zero byte forces a
# non-negative interpretation regardless of the top bit.
function _Ed25519LeToBig([byte[]]$b) {
    $e = New-Object byte[] ($b.Length + 1)
    [Array]::Copy($b, $e, $b.Length)
    return [System.Numerics.BigInteger]::new($e)
}

function _Ed25519DecodePoint([byte[]]$b) {
    if ($b.Length -ne 32) { return $null }
    $c = New-Object byte[] 32
    [Array]::Copy($b, $c, 32)
    $sign = ($c[31] -shr 7) -band 1
    $c[31] = $c[31] -band 0x7f
    $y = _Ed25519LeToBig $c
    if ($y -ge $script:_Ed25519P) { return $null }
    $x = _Ed25519XRecover $y
    if ($null -eq $x) { return $null }
    # RFC 8032 section 5.1.3 step 4: x = 0 with the sign bit set is a
    # non-canonical encoding and decoding MUST fail. Negating zero would
    # otherwise silently accept a second byte encoding of the identity and the
    # order-2 point. Not a forgery route here -- the public key is a pinned
    # constant and is always canonical -- but accepting an alternate encoding
    # of R is signature malleability, and a verifier should not deviate from
    # the spec on inputs an attacker chooses.
    if ($x -eq 0 -and $sign -eq 1) { return $null }
    if (($x % 2) -ne $sign) { $x = _Ed25519Mod (-$x) }
    return @($x, $y, [System.Numerics.BigInteger]1, (_Ed25519Mod ($x * $y)))
}

# Returns $true only when `sig` is a valid Ed25519 signature by `pub` over
# `msg`. Every malformed input returns $false; nothing here throws on bad data,
# so a caller cannot mistake a parse failure for a verification pass.
function Test-Ed25519Signature([byte[]]$pub, [byte[]]$sig, [byte[]]$msg) {
    if ($null -eq $pub -or $pub.Length -ne 32) { return $false }
    if ($null -eq $sig -or $sig.Length -ne 64) { return $false }
    # A null message would otherwise verify over the EMPTY message rather than
    # returning false, quietly breaking this function's stated contract that
    # every malformed input is rejected.
    if ($null -eq $msg) { return $false }

    $a = _Ed25519DecodePoint $pub
    if ($null -eq $a) { return $false }

    $rBytes = New-Object byte[] 32
    $sBytes = New-Object byte[] 32
    [Array]::Copy($sig, 0, $rBytes, 0, 32)
    [Array]::Copy($sig, 32, $sBytes, 0, 32)

    $r = _Ed25519DecodePoint $rBytes
    if ($null -eq $r) { return $false }

    # Reject a non-canonical scalar rather than reducing it: s >= L would admit
    # a second valid encoding of the same signature.
    $s = _Ed25519LeToBig $sBytes
    if ($s -ge $script:_Ed25519L) { return $false }

    $sha = [System.Security.Cryptography.SHA512]::Create()
    try {
        $buf = New-Object byte[] (64 + $msg.Length)
        [Array]::Copy($rBytes, 0, $buf, 0, 32)
        [Array]::Copy($pub, 0, $buf, 32, 32)
        if ($msg.Length -gt 0) { [Array]::Copy($msg, 0, $buf, 64, $msg.Length) }
        $hashBytes = $sha.ComputeHash($buf)
    } finally {
        $sha.Dispose()
    }
    $h = (_Ed25519LeToBig $hashBytes) % $script:_Ed25519L

    $basePoint = _Ed25519DecodePoint (_Ed25519HexToBytes "5866666666666666666666666666666666666666666666666666666666666666")
    $lhs = _Ed25519PointMul $basePoint $s
    $rhs = _Ed25519PointAdd $r (_Ed25519PointMul $a $h)

    # Compare projectively: X1*Z2 == X2*Z1 and Y1*Z2 == Y2*Z1.
    $okX = (_Ed25519Mod ($lhs[0] * $rhs[2])) -eq (_Ed25519Mod ($rhs[0] * $lhs[2]))
    $okY = (_Ed25519Mod ($lhs[1] * $rhs[2])) -eq (_Ed25519Mod ($rhs[1] * $lhs[2]))
    return ($okX -and $okY)
}

# Known-answer self-test, RFC 8032 section 7.1 TEST 2, run before the verifier
# is trusted with a release signature.
#
# BOTH assertions are mandatory. Without the negative case a verifier that
# always returns true would pass this probe -- which is precisely the failure
# mode SFN-1034 exists to close.
function Assert-Ed25519VerifierUsable {
    $katKey = _Ed25519HexToBytes "3d4017c3e843895a92b70aa74d1b7ebc9c982ccf2ec4968cc0cd55f12af4660c"
    $katSig = _Ed25519HexToBytes "92a009a9f0d4cab8720e820b5f642540a2b27b5416503f8fb3762223ebdb69da085ac1e43e15996e458f3613d0f11d8c387b2eaeb4302aeeb00d291612bb0c00"
    $genuine = _Ed25519HexToBytes "72"
    $tampered = _Ed25519HexToBytes "73"

    $accepts = $false
    $rejects = $false
    try {
        $accepts = (Test-Ed25519Signature $katKey $katSig $genuine)
        $rejects = -not (Test-Ed25519Signature $katKey $katSig $tampered)
    } catch {
        Die "the embedded Ed25519 verifier failed its RFC 8032 self-test with an error ($($_.Exception.Message)). Refusing to install: a verifier that cannot check a known vector cannot be trusted to reject a forged one."
    }
    if (-not $accepts -or -not $rejects) {
        Die "the embedded Ed25519 verifier failed its RFC 8032 self-test (accepts-genuine=$accepts, rejects-tampered=$rejects). Refusing to install."
    }
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
# installer rather than a hand-rolled copy of its steps. An unpublished archive
# has no signed release manifest, so it cannot reach VERIFIED_SIGNED.
#
# It can still be pinned: a caller that just built the archive can hash it and
# pass SAILFIN_LOCAL_ARCHIVE_SHA256, which lands in DIGEST_PINNED and makes
# this a real end-to-end exercise of the digest path. Without an expected
# digest the install is unverified and requires SAILFIN_ALLOW_UNVERIFIED=1
# (SFN-1034).
$LocalArchive = $env:SAILFIN_LOCAL_ARCHIVE
$LocalArchiveSha256 = $env:SAILFIN_LOCAL_ARCHIVE_SHA256
if ($LocalArchive) {
    if (-not (Test-Path -LiteralPath $LocalArchive -PathType Leaf)) {
        Die "SAILFIN_LOCAL_ARCHIVE='$LocalArchive' is not a readable file."
    }
    $LocalArchive = (Resolve-Path -LiteralPath $LocalArchive).Path
    if (-not $Version -or $Version -eq "latest") {
        Die "SAILFIN_LOCAL_ARCHIVE requires an explicit VERSION (e.g. VERSION=0.9.5); 'latest' cannot be resolved offline."
    }
    if ($LocalArchiveSha256) {
        $LocalArchiveSha256 = $LocalArchiveSha256.Trim().ToLowerInvariant()
        if ($LocalArchiveSha256 -notmatch '^[0-9a-f]{64}$') {
            Die "SAILFIN_LOCAL_ARCHIVE_SHA256 must be 64 hex characters; got '$LocalArchiveSha256'."
        }
    } elseif (-not $AllowUnverified) {
        Die @"
refusing to install a local archive with no expected digest.

  SAILFIN_LOCAL_ARCHIVE='$LocalArchive' has no signed release manifest, so its
  signature chain cannot be established.

  Fix one of:
    pin it     Set SAILFIN_LOCAL_ARCHIVE_SHA256 to the archive's SHA-256.
               PowerShell: (Get-FileHash -Algorithm SHA256 '$LocalArchive').Hash
    consent    Set SAILFIN_ALLOW_UNVERIFIED=1 to install it unverified.
"@
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
try {

    $DownloadHeaders = @{
        "Accept" = "application/octet-stream"
    }
    # Never attach the caller's GitHub credential to a mirror. SAILFIN_RELEASE_BASE
    # redirects these fetches to an operator-supplied host, and before SFN-1034 the
    # token could only ever reach github.com. Verification staying unconditional
    # bounds what a hostile mirror can do to the PAYLOAD; it does nothing to stop
    # one harvesting a token it was handed.
    if ($Token -and -not $ReleaseBase) {
        $DownloadHeaders["Authorization"] = "token $Token"
    }

    # The payload is NOT downloaded here. SFN-1034 moves the download after the
    # signed manifest that judges it has been fetched and verified, so a stripped
    # signature costs a request rather than a full archive, and the code reads in
    # trust order. Asset *resolution* stays exactly where it was -- it carries the
    # msvc-vs-mingw fallback logic from SFN-798 and SFN-1033.
    $AssetId = $null
    if ($LocalArchive) {
        Log "Installing from local archive: $LocalArchive"
        $Asset = Split-Path -Leaf $LocalArchive
        $ArchivePath = $LocalArchive
    } elseif ($ReleaseBase) {
        # A mirror serves plain files and has no GitHub API, so the asset list is
        # not available here. The choice is deferred until the verified manifest
        # can supply it -- authenticated data, which is strictly better than an
        # unauthenticated asset-list probe.
        $ArchivePath = $null
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
    }

    # --- Verify signed release manifest -----------------------------------------

    # First release that published a signed SHA256SUMS manifest.
    #
    # DIAGNOSTIC ONLY -- it selects between two failure messages and never gates
    # enforcement. Deciding whether verification is required from the version, or
    # from whether a signature happens to be present, would hand an attacker the
    # downgrade: strip the file (or influence which version `latest` resolves to)
    # and the strict path is skipped. Enforcement is therefore version-independent
    # (SFN-1034, SFEP-0073 section 3.7).
    $SigningFloor = "0.8.0"

    # Naive MAJOR.MINOR.PATCH compare, prerelease deliberately ignored: this feeds
    # wording, not policy, so prerelease ordering would be precision without
    # purpose.
    function Test-BelowSigningFloor([string]$Candidate, [string]$Floor) {
        $c = ($Candidate -split '-')[0] -split '\.'
        $f = $Floor -split '\.'
        for ($i = 0; $i -lt 3; $i++) {
            # A non-numeric component becomes 0 rather than throwing: this picks
            # wording only, so a malformed VERSION must not replace the D-06
            # diagnostic with a type-conversion error.
            $cvRaw = if ($i -lt $c.Count) { ($c[$i] -replace '\D', '') } else { "" }
            $cv = if ($cvRaw) { [int]$cvRaw } else { 0 }
            $fv = if ($i -lt $f.Count) { [int]$f[$i] } else { 0 }
            if ($cv -lt $fv) { return $true }
            if ($cv -gt $fv) { return $false }
        }
        return $false
    }

    # Fetch one release file, distinguishing "not published" from "could not be
    # reached". Collapsing those is what let a blocked or throttled request read as
    # an unsigned release; a 404 is never retried and a transient failure is never
    # reported as absence.
    function Get-ReleaseFile {
        param(
            [string]$Uri,
            [string]$OutFile,
            [hashtable]$RequestHeaders
        )

        for ($attempt = 1; $attempt -le 3; $attempt++) {
            try {
                Invoke-WebRequest -Uri $Uri -Headers $RequestHeaders -OutFile $OutFile -UseBasicParsing -ErrorAction Stop
                return "ok"
            } catch {
                $status = $null
                if ($_.Exception.Response) { $status = [int]$_.Exception.Response.StatusCode }
                if ($status -eq 404) { return "missing" }
                if ($attempt -ge 3) {
                    Die "could not fetch $Uri after $attempt attempts -- $($_.Exception.Message). A signed manifest that cannot be reached is a hard failure, not a reason to continue unverified."
                }
                Log "  transient failure fetching $Uri ($($_.Exception.Message)); retrying"
                Start-Sleep -Seconds (5 * $attempt)
            }
        }
        return "missing"
    }

    # Fetch and verify the signed manifest, returning the expected digest for the
    # asset. Runs BEFORE the payload is downloaded.
    function Get-VerifiedManifest {
        param(
            [string]$VerificationBase,
            [string]$ReleaseTag,
            [string]$WorkDir,
            [hashtable]$RequestHeaders
        )

        $ManifestPath = Join-Path $WorkDir "SHA256SUMS"
        $SignatureHexPath = Join-Path $WorkDir "SHA256SUMS.sig"

        $manifestStatus = Get-ReleaseFile -Uri "$VerificationBase/SHA256SUMS" -OutFile $ManifestPath -RequestHeaders $RequestHeaders
        $signatureStatus = "missing"
        if ($manifestStatus -eq "ok") {
            $signatureStatus = Get-ReleaseFile -Uri "$VerificationBase/SHA256SUMS.sig" -OutFile $SignatureHexPath -RequestHeaders $RequestHeaders
        }

        if ($manifestStatus -ne "ok" -or $signatureStatus -ne "ok") {
            $missing = if ($manifestStatus -ne "ok") { "SHA256SUMS" } else { "SHA256SUMS.sig" }
            if (-not $AllowUnverified) {
                if (Test-BelowSigningFloor $Version $SigningFloor) {
                    Die @"
    release '$ReleaseTag' publishes no $missing.

      Releases before v$SigningFloor predate release signing, so nothing about this
      archive can be verified.

      To install it anyway, set SAILFIN_ALLOW_UNVERIFIED=1 and understand that its
      contents are not checked against any signature.
    "@
                }
                Die @"
    release '$ReleaseTag' must publish $missing, but the fetch returned 404.

      Every release from v$SigningFloor onward is signed, so this is either a broken
      release or an attempt to strip verification from this install.

      Refusing to install. If you have independently established that this release
      is genuinely unsigned, set SAILFIN_ALLOW_UNVERIFIED=1.
    "@
            }
            return @{ State = "UNVERIFIED_EXPLICIT"; Reason = "release '$ReleaseTag' publishes no $missing" }
        }

        # Only now is a verifier needed, and it is always present.
        Assert-Ed25519VerifierUsable

        $SignatureHex = ((Get-Content -Raw $SignatureHexPath) -replace '\s', '')
        if ($SignatureHex -notmatch '^[0-9a-fA-F]{128}$') {
            Die "release manifest signature is malformed; refusing to install from '$ReleaseTag'."
        }

        $PublicKeyBytes = _Ed25519HexToBytes $ReleaseSigningPublicKeyHex
        $SignatureBytes = _Ed25519HexToBytes $SignatureHex
        $ManifestBytes = [IO.File]::ReadAllBytes($ManifestPath)

        if (-not (Test-Ed25519Signature $PublicKeyBytes $SignatureBytes $ManifestBytes)) {
            Die @"
    release manifest signature verification FAILED for '$ReleaseTag'.

      SHA256SUMS is not signed by the Sailfin release key. This means the manifest
      was modified in transit or the release is not authentic.

      Refusing to install. This is not overridable.
    "@
        }

        return @{ State = "VERIFIED_SIGNED"; ManifestPath = $ManifestPath }
    }

    # Extract the single manifest entry for an asset. Zero or more than one is a
    # hard failure: a duplicated name is an ambiguous claim about which bytes are
    # authentic.
    function Get-ManifestDigest([string]$ManifestPath, [string]$AssetName) {
        $digests = @()
        foreach ($Line in (Get-Content $ManifestPath)) {
            if ($Line -match '^([0-9a-fA-F]{64})\s+\*?(.+)$' -and $Matches[2].Trim() -eq $AssetName) {
                $digests += $Matches[1].ToLowerInvariant()
            }
        }
        if ($digests.Count -ne 1) {
            Die "signed release manifest does not contain exactly one entry for '$AssetName' (found $($digests.Count)); refusing to install."
        }
        return $digests[0]
    }

    function Get-FileSha256([string]$Path) {
        $Sha256 = [Security.Cryptography.SHA256]::Create()
        try {
            $Stream = [IO.File]::OpenRead($Path)
            try { $DigestBytes = $Sha256.ComputeHash($Stream) } finally { $Stream.Dispose() }
        } finally {
            $Sha256.Dispose()
        }
        return ([BitConverter]::ToString($DigestBytes) -replace '-', '').ToLowerInvariant()
    }

    # --- Establish trust, then fetch the payload ---------------------------------
    # Verification runs before extraction or creation of an install destination, so
    # detected tampering cannot leave an installed binary behind.

    $TrustState = "UNVERIFIED_EXPLICIT"
    $UnverifiedReason = ""
    $ExpectedDigest = $null

    if ($LocalArchive) {
        if ($LocalArchiveSha256) {
            $TrustState = "DIGEST_PINNED"
            $ExpectedDigest = $LocalArchiveSha256
        } else {
            $UnverifiedReason = "local archive install with no expected digest"
        }
    } else {
        # Files live at <base>/<tag>/, matching the native
        # SAILFIN_TOOLCHAIN_RELEASE_BASE knob and install.sh, so a mirror laid out
        # for one is laid out for all three.
        $VerificationBase = if ($ReleaseBase) { "$($ReleaseBase.TrimEnd('/'))/$Tag" } else { "https://github.com/$Repo/releases/download/$Tag" }
        $Manifest = Get-VerifiedManifest -VerificationBase $VerificationBase -ReleaseTag $Tag `
            -WorkDir $TmpDir -RequestHeaders $DownloadHeaders
        $TrustState = $Manifest.State

        if ($TrustState -eq "VERIFIED_SIGNED") {
            # With a mirror the asset list came from no authenticated source, so
            # resolve the preference-ordered candidates against the verified
            # manifest instead.
            if ($ReleaseBase) {
                $ResolvedAsset = $null
                foreach ($Candidate in $AssetCandidates) {
                    if ((Get-Content $Manifest.ManifestPath) -match ("\s\*?" + [regex]::Escape($Candidate) + "\s*$")) {
                        $ResolvedAsset = $Candidate
                        break
                    }
                }
                if (-not $ResolvedAsset) {
                    Die "none of [$($AssetCandidates -join ', ')] appears in the verified manifest for '$Tag'."
                }
                $Asset = $ResolvedAsset
                $ArchivePath = Join-Path $TmpDir $Asset
                Log "Expected asset: $Asset"
            }
            $ExpectedDigest = Get-ManifestDigest $Manifest.ManifestPath $Asset
            Log "verified: SHA256SUMS ed25519 signature (verifier: powershell-ed25519)"
        } elseif ($TrustState -eq "UNVERIFIED_EXPLICIT") {
            $UnverifiedReason = $Manifest.Reason
            if ($ReleaseBase) {
                $Asset = $AssetCandidates[0]
                $ArchivePath = Join-Path $TmpDir $Asset
            }
        } else {
            # Neither known state. Unreachable today, but this is exactly the
            # silent fail-open shape SFN-1034 exists to remove: falling through
            # would skip the digest check, skip the warning block, and install
            # with nothing checked and nothing printed.
            Die "internal error: unexpected trust state '$TrustState'; refusing to install."
        }

        # The manifest that will judge these bytes is verified; fetch them now.
        if ($ReleaseBase) {
            Log "Downloading asset from $VerificationBase..."
            $status = Get-ReleaseFile -Uri "$VerificationBase/$Asset" -OutFile $ArchivePath -RequestHeaders $DownloadHeaders
            if ($status -ne "ok" -and $TrustState -eq "UNVERIFIED_EXPLICIT" -and $AssetCandidates.Count -gt 1) {
                # No signed manifest was available to pick the asset name, so the
                # preferred (-msvc) candidate may simply not exist for this
                # release or arch. Fall back the same way the signed path does.
                foreach ($Candidate in ($AssetCandidates | Select-Object -Skip 1)) {
                    $ArchivePath = Join-Path $TmpDir $Candidate
                    $status = Get-ReleaseFile -Uri "$VerificationBase/$Candidate" -OutFile $ArchivePath -RequestHeaders $DownloadHeaders
                    if ($status -eq "ok") { $Asset = $Candidate; break }
                }
            }
            if ($status -ne "ok") { Die "could not download '$Asset' from $VerificationBase." }
        } else {
            Log "Downloading asset via GitHub API (id=$AssetId)..."
            $DownloadUrl = "https://api.github.com/repos/$Repo/releases/assets/$AssetId"
            Invoke-WebRequest -Uri $DownloadUrl -Headers $DownloadHeaders -OutFile $ArchivePath -UseBasicParsing
        }
    }

    # The digest check runs in EVERY state in which an expected digest exists,
    # including the explicitly unverified one. Nothing about a missing signature
    # makes a corrupt download acceptable.
    if ($ExpectedDigest) {
        $ActualDigest = Get-FileSha256 $ArchivePath
        if ($ActualDigest -ne $ExpectedDigest) {
            # Only ever unlink an archive WE downloaded into the temp dir. In
            # DIGEST_PINNED the path is the caller's own file, and a mistyped
            # SAILFIN_LOCAL_ARCHIVE_SHA256 must not destroy it.
            if (-not $LocalArchive) {
                Remove-Item -Force $ArchivePath -ErrorAction SilentlyContinue
            }
            Die @"
    SHA-256 digest mismatch for '$Asset'; refusing to install it.

      expected $ExpectedDigest
      actual   $ActualDigest
    "@
        }
        if ($TrustState -eq "VERIFIED_SIGNED") {
            Log "verified: $Asset sha256 $ActualDigest"
        } else {
            Log "digest-pinned: $Asset sha256 $ActualDigest (matched a caller-supplied digest, not a signature)"
        }
    }

    if ($TrustState -eq "UNVERIFIED_EXPLICIT") {
        Log "WARNING: UNVERIFIED INSTALL"
        Log "WARNING:   reason: $UnverifiedReason"
        Log "WARNING:   the release signature was NOT checked"
        Log "WARNING:   the archive digest was NOT checked against any signed manifest"
        Log "WARNING:   proceeding only because SAILFIN_ALLOW_UNVERIFIED=1 was set"
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

} finally {
    Remove-Item -Recurse -Force $TmpDir -ErrorAction SilentlyContinue
}

Log "Installed: $DestPath"
Log "Ready! Run 'sfn version' to verify."
