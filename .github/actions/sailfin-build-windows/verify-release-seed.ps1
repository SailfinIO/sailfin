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
# `install.ps1` and `install.sh` used to warn-and-continue when OpenSSL was
# missing or the manifest fetch failed; SFN-1034 closed that, so all three now
# fail closed. They are NOT identical: the installers accept a loudly named
# `SAILFIN_ALLOW_UNVERIFIED=1` opt-in for genuinely unsigned artifacts, which
# this script must never grow. `install.ps1` also carries an embedded Ed25519
# verifier and needs no OpenSSL at all; SFN-1093 converges this script onto it
# so CI and users exercise identical arithmetic, and deletes this paragraph.

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
$sigRaw   = Join-Path $WorkDir "SHA256SUMS.sig.raw"
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

# OpenSSL 3.0+, NOT the `1.1.1|[2-9]` pattern `install.sh` and `install.ps1`
# use. `pkeyutl -rawin` arrived in 3.0; on 1.1.1 it is an unknown option, so
# that pattern admits a toolchain which then fails at the verify call and
# reports a SIGNATURE failure for what is really a missing flag. Rejecting it
# up front costs nothing here -- the pinned `windows-2025` image carries
# OpenSSL 3.6.3 -- and keeps the diagnosis honest.
$ossl = Get-Command openssl -ErrorAction SilentlyContinue
$osslVersion = if ($ossl) { (& openssl version 2>$null) } else { "" }
if (-not $ossl -or $osslVersion -notmatch '^OpenSSL ([3-9]|[1-9][0-9]+)\.') {
  throw "SFN-994: OpenSSL 3.0+ is required to verify the release seed (pkeyutl -rawin), and was not found (got '$osslVersion'). Failing closed -- bootstrap.toml [verify].required = true. If the runner image dropped OpenSSL, that is the bug; do not relax this check."
}

$hex = ((Get-Content -Raw $sigHex) -replace '\s', '')
if ($hex -notmatch '^[0-9a-fA-F]{128}$') { throw "SFN-994: SHA256SUMS.sig is malformed" }
$sigBytes = New-Object byte[] 64
for ($i = 0; $i -lt 64; $i++) { $sigBytes[$i] = [Convert]::ToByte($hex.Substring($i * 2, 2), 16) }
[IO.File]::WriteAllBytes((Join-Path (Resolve-Path -LiteralPath $WorkDir) 'SHA256SUMS.sig.raw'), $sigBytes)

# try/catch, not a bare `$LASTEXITCODE` check. PowerShell 7.4 defaults
# `$PSNativeCommandUseErrorActionPreference` to true, so with
# `$ErrorActionPreference = 'Stop'` a non-zero native exit raises a terminating
# error AT the call, before the next line runs. Either way the step goes red,
# but without this the log shows PowerShell's generic native-command error
# instead of saying which check failed -- and "the step died somewhere in
# verification" is the ambiguity this whole file exists to avoid.
$sigOk = $false
try {
  & openssl pkeyutl -verify -pubin -inkey $pubKey -rawin -in $manifest -sigfile $sigRaw 2>$null | Out-Null
  $sigOk = ($LASTEXITCODE -eq 0)
} catch {
  $sigOk = $false
}
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

# Say what was verified. `install.ps1`'s equivalent is silent on
# success, which is why establishing whether it had verified anything
# took log forensics rather than reading a line (SFN-1034).
Write-Host "verified: SHA256SUMS ed25519 signature (key $pubKey)"
Write-Host "verified: $asset sha256 $actual"

