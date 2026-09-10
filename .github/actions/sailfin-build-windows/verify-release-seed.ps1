# Fetch the published native MSVC Windows seed named by
# `bootstrap.toml [seed].version` and verify it before anything executes it.
# Called by `.github/actions/sailfin-build-windows/action.yml` when
# `seed_source: 'release'` (SFN-994).
#
# Lives in its own file, rather than inline in `action.yml`, so it can be
# parsed by `[Parser]::ParseFile` in CI the way `install.ps1` already is.
# Security-critical code that cannot be syntax-checked before it runs is a
# 15-minute round trip per typo, and worse, a step that dies mid-verification
# is indistinguishable at a glance from one that verified nothing.
#
# FAILS CLOSED at every step, by design. There is deliberately no downgrade
# path and no override knob here, in the one place `bootstrap.toml`'s
# `[verify] required = true` is unambiguous.
#

[CmdletBinding()]
param(
    # `bootstrap.toml [seed].version`, resolved by the caller. Never defaulted
    # here: SFEP-0047 makes that file the sole compiler-checkout seed source of
    # truth, and a fallback would let this script invent a version.
    [Parameter(Mandatory = $true)]
    [ValidatePattern('^[0-9]+\.[0-9]+\.[0-9]+(-[0-9A-Za-z.]+)?$')]
    [string]$Version,

    # Directory to download into. Relative paths resolve against the caller's
    # working directory, which is the workspace root.
    [string]$WorkDir = "seed-dl",

    # Trust anchor. `docs/release-signing.md` records every copy of this key
    # that must stay in sync; reading the committed file keeps this script from
    # becoming another one.
    [string]$PublicKeyPath = ".github/release-signing/ed25519-release.pub.pem"
)

$ErrorActionPreference = 'Stop'

# SFN-1093: keep this arithmetic and both RFC 8032 self-test assertions in
# sync with install.ps1. D-12 in the SFN-1034 design note requires duplication:
# the installer is delivered as a single file and cannot import a repo helper.
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
        throw "the embedded Ed25519 verifier failed its RFC 8032 self-test with an error ($($_.Exception.Message)). Refusing to bootstrap: a verifier that cannot check a known vector cannot be trusted to reject a forged one."
    }
    if (-not $accepts -or -not $rejects) {
        throw "the embedded Ed25519 verifier failed its RFC 8032 self-test (accepts-genuine=$accepts, rejects-tampered=$rejects). Refusing to bootstrap."
    }
}

$ver = $Version
# Asset naming and the release-asset layout are hardcoded here, as they
# already are in `compiler/src/cli/commands/toolchain.sfn`, `install.sh`
# and `install.ps1`. `bootstrap.toml`'s `repo`/`asset_prefix` are parsed
# and shape-validated but threaded into no fetch anywhere in the tree
# (`compiler/src/bootstrap_manifest.sfn:29-35`); wiring them through is
# a separate change, not a prerequisite for this one.
$asset = "sailfin_${ver}_windows_x86_64-msvc.tar.gz"
$base  = "https://github.com/SailfinIO/sailfin/releases/download/v$ver"

# The msvc asset only, with NO fallback to the plain mingw asset. The
# point of this mode is bootstrapping from a NATIVE seed; silently
# falling back to the build being retired (SFN-58) would defeat it and
# would report green. A missing msvc asset is a real failure.
New-Item -ItemType Directory -Force -Path $WorkDir | Out-Null
$archive  = Join-Path $WorkDir $asset
$manifest = Join-Path $WorkDir "SHA256SUMS"
$sigHex   = Join-Path $WorkDir "SHA256SUMS.sig"
$pubKey   = $PublicKeyPath

foreach ($f in @(@{u="$base/$asset"; o=$archive},
                 @{u="$base/SHA256SUMS"; o=$manifest},
                 @{u="$base/SHA256SUMS.sig"; o=$sigHex})) {
  # Retry transient failures, but never a 404. This job files a regression
  # issue when it fails, so a rate-limit blip or a 5xx would otherwise open an
  # issue describing a compiler break. A 404 is not transient and retrying it
  # only delays a real verdict.
  $attempt = 0
  while ($true) {
    $attempt++
    Write-Host "fetching $($f.u) (attempt $attempt)"
    try {
      Invoke-WebRequest -Uri $f.u -OutFile $f.o -UseBasicParsing -ErrorAction Stop
      break
    } catch {
      $status = $null
      if ($_.Exception.Response) { $status = [int]$_.Exception.Response.StatusCode }

      if ($status -eq 404) {
        # Worth spelling out, because the gate name this lands under says
        # "windows-native-build" and the cause is neither Windows nor a build.
        # SFN-1024 made the msvc payload required, so a release cut after it
        # cannot publish without one. A pin naming an EARLIER release still
        # can, and `cadence-seed-pin.yml` does not itself check the asset
        # before advancing, so this path stays reachable.
        throw "SFN-994: $($f.u) does not exist (404). If this is the seed archive, the pinned release v$ver published no native msvc asset. Releases cut after SFN-1024 require that payload, so this means the pin names an earlier release -- NOT a regression in this checkout. Fix the release or the pin; do not add a mingw fallback here."
      }

      if ($attempt -ge 3) {
        throw "SFN-994: could not fetch $($f.u) after $attempt attempts -- $($_.Exception.Message). A missing signed manifest is a hard failure here, not a reason to continue unverified."
      }
      Write-Host "  transient failure ($($_.Exception.Message)); retrying"
      Start-Sleep -Seconds (5 * $attempt)
    }
  }
}

if (-not (Test-Path $pubKey)) { throw "SFN-994: release signing key missing at $pubKey" }

# RFC 8410 Ed25519 SubjectPublicKeyInfo: fixed algorithm identifier, absent
# parameters, and a 32-byte BIT STRING with no unused bits. Validate the whole
# envelope before extracting the raw key; do not accept another key algorithm.
$pem = (Get-Content -Raw -LiteralPath $pubKey).Trim()
if ($pem -notmatch '\A-----BEGIN PUBLIC KEY-----\s+([A-Za-z0-9+/=\s]+)\s+-----END PUBLIC KEY-----\z') {
  throw "SFN-1093: malformed Ed25519 public key PEM at $pubKey"
}
$keyDer = [Convert]::FromBase64String(($Matches[1] -replace '\s', ''))
$prefix = '302A300506032B6570032100'
if ($keyDer.Length -ne 44 -or ([BitConverter]::ToString($keyDer, 0, 12) -replace '-', '') -cne $prefix) {
  throw "SFN-1093: expected an Ed25519 SubjectPublicKeyInfo key at $pubKey"
}
$keyBytes = New-Object byte[] 32
[Array]::Copy($keyDer, 12, $keyBytes, 0, 32)

Assert-Ed25519VerifierUsable

$hex = ((Get-Content -Raw $sigHex) -replace '\s', '')
if ($hex -notmatch '^[0-9a-fA-F]{128}$') { throw "SFN-994: SHA256SUMS.sig is malformed" }
$sigBytes = _Ed25519HexToBytes $hex
$manifestBytes = [IO.File]::ReadAllBytes((Resolve-Path -LiteralPath $manifest))
$sigOk = Test-Ed25519Signature $keyBytes $sigBytes $manifestBytes
if (-not $sigOk) { throw "SFN-994: SHA256SUMS ed25519 signature verification FAILED for v$ver against $pubKey; refusing to bootstrap from it." }

$digests = @()
foreach ($line in (Get-Content $manifest)) {
  if ($line -match '^([0-9a-fA-F]{64})\s+\*?(.+)$' -and $Matches[2] -eq $asset) { $digests += $Matches[1] }
}
if ($digests.Count -ne 1) { throw "SFN-994: signed manifest does not contain exactly one entry for '$asset' (found $($digests.Count))" }

$sha = [Security.Cryptography.SHA256]::Create()
try {
  $stream = [IO.File]::OpenRead((Resolve-Path -LiteralPath $archive))
  try { $bytes = $sha.ComputeHash($stream) } finally { $stream.Dispose() }
} finally { $sha.Dispose() }
$actual = ([BitConverter]::ToString($bytes) -replace '-', '').ToLowerInvariant()
if ($actual -ne $digests[0].ToLowerInvariant()) {
  throw "SFN-994: SHA-256 digest mismatch for '$asset'; refusing to bootstrap from it."
}

# Say what was verified, matching install.ps1's success evidence (SFN-1034).
Write-Host "verified: SHA256SUMS ed25519 signature (key $pubKey)"
Write-Host "verified: $asset sha256 $actual"
