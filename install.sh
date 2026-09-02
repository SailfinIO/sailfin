#!/usr/bin/env bash
set -euo pipefail

# curlable installer for the Sailfin compiler binary.
#
# Usage:
#   curl -fsSL https://raw.githubusercontent.com/SailfinIO/sailfin/alpha/install.sh | VERSION=0.1.1 bash
#   curl -fsSL https://raw.githubusercontent.com/SailfinIO/sailfin/alpha/install.sh | bash -s -- --version 0.1.1
#   curl -fsSL https://raw.githubusercontent.com/SailfinIO/sailfin/alpha/install.sh | bash  # installs latest
#
# Env overrides:
#   REPO=owner/repo          (default: SailfinIO/sailfin)
#   VERSION=latest|<ver>     (default: latest; accepts optional leading v)
#   BINARY=sailfin           (default: sailfin)
#   INSTALL_BASE=...         (default: ~/.local/share/sailfin/versions; payloads
#                            land under <canonical-host-triple>/<version>)
#   GLOBAL_BIN_DIR=...       (default: ~/.local/bin)
#   GITHUB_TOKEN=...         (optional; increases API rate limits)
#   SAILFIN_RELEASE_BASE=... (default: https://github.com/<REPO>/releases/download;
#                            files are read from <base>/<tag>/, matching the
#                            native SAILFIN_TOOLCHAIN_RELEASE_BASE. Overrides
#                            only WHERE assets/manifest/signature are fetched
#                            from -- a mirror. Verification stays unconditional
#                            and the trust anchor is not overridable.)
#   SAILFIN_OPENSSL=...      (path to an OpenSSL 3.0+ binary to try first as
#                            the Ed25519 signature verifier; see the probe
#                            chain below)
#   SAILFIN_LOCAL_ARCHIVE=... (install a tarball already on disk instead of
#                            a published release; requires an explicit
#                            VERSION)
#   SAILFIN_LOCAL_ARCHIVE_SHA256=... (pins SAILFIN_LOCAL_ARCHIVE to a
#                            caller-supplied SHA-256; reaches trust state
#                            DIGEST_PINNED instead of UNVERIFIED_EXPLICIT)
#   SAILFIN_ALLOW_UNVERIFIED=1 (consent to install an artifact whose signature
#                            chain cannot be established: an unsigned release,
#                            a local archive with no pinned digest, or no
#                            KAT-passing Ed25519 verifier on this host. It
#                            NEVER bypasses a failed signature, a digest
#                            mismatch, a malformed signature/manifest, or a
#                            missing/duplicate asset entry -- those always
#                            abort. There is no trust-anchor override.)
#
# Trust policy (SFN-1034 / SFEP-0073 Sec3.7): a published release's
# SHA256SUMS/SHA256SUMS.sig are verified BEFORE the archive is downloaded.
# Missing manifest, missing signature, or no verifier that passes the RFC
# 8032 known-answer test all abort unless SAILFIN_ALLOW_UNVERIFIED=1 is set.
# See https://sailfin.dev/docs/getting-started/verify-download.
#
# Assets are expected to be named:
#   sailfin_<version>_<os>_<arch>-msvc.tar.gz  (windows only)
#   sailfin_<version>_<os>_<arch>.tar.gz
# where <os> is linux|macos|windows and <arch> is x86_64|arm64. On windows,
# the -msvc asset (the native build, with working TLS) is preferred when
# present; the plain asset is the legacy mingw cross build and is used as a
# fallback for releases before v0.10.3 and for arm64, which has no -msvc
# asset at any version.

REPO="${REPO:-SailfinIO/sailfin}"
BINARY="${BINARY:-sailfin}"
VERSION="${VERSION:-latest}"
EXCLUDE_TAG="${EXCLUDE_TAG:-}"

# Ed25519 release-signing trust anchor. Keep in sync with the locations listed
# in docs/release-signing.md.
RELEASE_SIGNING_PUBLIC_KEY_PEM='-----BEGIN PUBLIC KEY-----
MCowBQYDK2VwAyEAwxcgcQHwbBCjQWVukG6V1ucZn8qoXZx5NFWwfXQKRLk=
-----END PUBLIC KEY-----'

# Parse CLI arguments (supports: --version <ver>)
while [ $# -gt 0 ]; do
  case "$1" in
    --version) VERSION="$2"; shift 2 ;;
    *) shift ;;
  esac
done

log() {
  printf '[%s] %s\n' "$(date +'%Y-%m-%dT%H:%M:%S%z')" "$*"
}

die() {
  log "Error: $*"
  exit 1
}

command_exists() {
  command -v "$1" >/dev/null 2>&1
}

require_cmd() {
  local cmd="$1"
  command_exists "$cmd" || die "Required command '$cmd' is not installed."
}

# Required commands
for cmd in curl tar uname mktemp; do
  require_cmd "$cmd"
done

# We require jq for GitHub API parsing.
require_cmd jq

# --- SFN-1034: release verification helpers -------------------------------
#
# Converts a hex string into raw bytes, appended to $2. Used both for the
# release signature (already the case before SFN-1034) and for materializing
# the RFC 8032 known-answer test's fixed public key from a hex constant, so
# there is exactly one hex-decoding implementation in this script.
hex_to_raw_file() {
  local hex="$1" out="$2"
  local offset=0 len=${#hex} byte octal
  : > "$out"
  while [ "$offset" -lt "$len" ]; do
    byte="${hex:$offset:2}"
    octal="$(printf '%03o' "$((16#$byte))")"
    printf '%b' "\\${octal}" >> "$out"
    offset=$((offset + 2))
  done
}

# D-01: before any candidate is trusted with the real release signature, it
# must reproduce RFC 8032 Sec7.1 TEST 2 -- both halves. A candidate that
# verifies the genuine (pubkey, message, signature) triple but ALSO
# "verifies" the same signature against a different message is not a
# verifier; it is a stub that always exits 0, and trusting it would be worse
# than having no verifier at all (D-01, D-05 case c).
_ed25519_verifier_selftest() {
  local candidate="$1"
  local kat_sig_hex="92a009a9f0d4cab8720e820b5f642540a2b27b5416503f8fb3762223ebdb69da085ac1e43e15996e458f3613d0f11d8c387b2eaeb4302aeeb00d291612bb0c00"
  # Base64 PEM body for the KAT SPKI: the fixed 12-byte Ed25519 SPKI header
  # (302a300506032b6570032100) followed by the raw 32-byte KAT public key
  # (3d4017c3e843895a92b70aa74d1b7ebc9c982ccf2ec4968cc0cd55f12af4660c),
  # docs/release-signing.md "Key generation & rotation". Hardcoded rather than
  # base64-encoded at runtime so this self-test does not depend on a `base64`
  # binary being present (SFN-1034).
  local kat_pub_b64="MCowBQYDK2VwAyEAPUAXw+hDiVqStwqnTRt+vJyYLM8uxJaMwM1V8Sr0Zgw="
  local kat_dir
  kat_dir="$(mktemp -d)" || return 1

  {
    printf -- '-----BEGIN PUBLIC KEY-----\n'
    printf '%s\n' "$kat_pub_b64"
    printf -- '-----END PUBLIC KEY-----\n'
  } >"${kat_dir}/pub.pem"
  hex_to_raw_file "$kat_sig_hex" "${kat_dir}/sig.raw"
  printf '\x72' >"${kat_dir}/msg.genuine"
  printf '\x73' >"${kat_dir}/msg.tampered"

  local ok=1
  if "$candidate" pkeyutl -verify -pubin -inkey "${kat_dir}/pub.pem" -rawin \
      -in "${kat_dir}/msg.genuine" -sigfile "${kat_dir}/sig.raw" >/dev/null 2>&1 &&
     ! "$candidate" pkeyutl -verify -pubin -inkey "${kat_dir}/pub.pem" -rawin \
      -in "${kat_dir}/msg.tampered" -sigfile "${kat_dir}/sig.raw" >/dev/null 2>&1; then
    ok=0
  fi
  rm -rf "$kat_dir"
  return "$ok"
}

# D-04: probe order, each candidate gated by the KAT above, first pass wins.
# The Homebrew keg paths are load-bearing -- `openssl@3` is keg-only, so a Mac
# with Homebrew's `openssl` on PATH resolves to Apple's LibreSSL while a
# working OpenSSL 3 sits unlinked in the cellar.
VERIFIER_CMD=""
VERIFIER_NAME=""
VERIFIER_ATTEMPTS=()
select_signature_verifier() {
  VERIFIER_CMD=""
  VERIFIER_NAME=""
  VERIFIER_ATTEMPTS=()
  local candidates=()
  [ -n "${SAILFIN_OPENSSL:-}" ] && candidates+=("$SAILFIN_OPENSSL")
  candidates+=("openssl")
  candidates+=("/opt/homebrew/opt/openssl@3/bin/openssl")
  candidates+=("/usr/local/opt/openssl@3/bin/openssl")
  local brew_openssl_prefix=""
  if command_exists brew; then
    brew_openssl_prefix="$(brew --prefix openssl@3 2>/dev/null || true)"
  fi
  [ -n "$brew_openssl_prefix" ] && candidates+=("${brew_openssl_prefix}/bin/openssl")

  local candidate
  for candidate in ${candidates[@]+"${candidates[@]}"}; do
    if ! command_exists "$candidate"; then
      VERIFIER_ATTEMPTS+=("${candidate}: not found")
      continue
    fi
    if _ed25519_verifier_selftest "$candidate"; then
      VERIFIER_CMD="$candidate"
      VERIFIER_NAME="openssl"
      return 0
    fi
    VERIFIER_ATTEMPTS+=("${candidate}: found, but failed the RFC 8032 known-answer test (not OpenSSL 3.0+ with raw Ed25519 support)")
  done
  return 1
}

# D-09: digest-tool probe order. Each candidate is KAT-gated on a fixed input
# because the three tools disagree on output format. The openssl candidate is
# probed independently of D-04's signature-verifier selection: a LibreSSL-only
# openssl cannot verify Ed25519 but can still compute SHA-256, so it is not
# disqualified as a digest tool just because it failed the verifier KAT
# (SFN-1034). It prefers an already-selected signature verifier, then
# SAILFIN_OPENSSL, then openssl on PATH.
KAT_DIGEST_INPUT="abc"
KAT_DIGEST_EXPECTED="ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad"
DIGEST_KIND=""
DIGEST_ATTEMPTS=()
OPENSSL_DIGEST_CMD=""
digest_compute() {
  local kind="$1" file="$2"
  case "$kind" in
    sha256sum) sha256sum "$file" 2>/dev/null | awk '{print $1}' ;;
    shasum) shasum -a 256 "$file" 2>/dev/null | awk '{print $1}' ;;
    openssl) "$OPENSSL_DIGEST_CMD" dgst -sha256 -r "$file" 2>/dev/null | awk '{print $1}' ;;
  esac
}
select_digest_tool() {
  DIGEST_KIND=""
  DIGEST_ATTEMPTS=()
  local kat_dir
  kat_dir="$(mktemp -d)" || return 1
  printf '%s' "$KAT_DIGEST_INPUT" >"${kat_dir}/kat.txt"

  local kind got
  for kind in sha256sum shasum openssl; do
    if [ "$kind" = "openssl" ]; then
      OPENSSL_DIGEST_CMD="${VERIFIER_CMD:-${SAILFIN_OPENSSL:-openssl}}"
      if ! command_exists "$OPENSSL_DIGEST_CMD"; then
        DIGEST_ATTEMPTS+=("${OPENSSL_DIGEST_CMD}: not found")
        continue
      fi
    elif ! command_exists "$kind"; then
      DIGEST_ATTEMPTS+=("${kind}: not found")
      continue
    fi
    got="$(digest_compute "$kind" "${kat_dir}/kat.txt" | tr '[:upper:]' '[:lower:]')" || true
    if [ "$got" = "$KAT_DIGEST_EXPECTED" ]; then
      DIGEST_KIND="$kind"
      rm -rf "$kat_dir"
      return 0
    fi
    DIGEST_ATTEMPTS+=("${kind}: failed the known-answer test (unexpected output format or digest)")
  done
  rm -rf "$kat_dir"
  return 1
}

# R-4: distinguishes "this asset does not exist" (404, never retried) from a
# transient failure (retried 3x with backoff), mirroring
# .github/actions/sailfin-build-windows/verify-release-seed.ps1. `curl --fail`
# alone collapses both into one non-zero exit and cannot tell them apart.
# Returns 0 on success, 1 on a definitive 404, 2 once retries are exhausted.
fetch_with_retry() {
  local url="$1" out="$2"
  local auth_args=()
  # A mirror override (SAILFIN_RELEASE_BASE) points this fetch at an arbitrary
  # operator-supplied host; sending the caller's GitHub token there would
  # exfiltrate a credential meant only for github.com (SFN-1034).
  if [ -n "${GITHUB_TOKEN:-}" ] && [ -z "${SAILFIN_RELEASE_BASE:-}" ]; then
    auth_args=(-H "Authorization: Bearer ${GITHUB_TOKEN}")
  fi
  local attempt=0 http_code
  while :; do
    attempt=$((attempt + 1))
    http_code="$(curl -sSL -o "$out" -w '%{http_code}' \
      ${auth_args[@]+"${auth_args[@]}"} "$url" 2>/dev/null || true)"
    [ "$http_code" = "200" ] && return 0
    [ "$http_code" = "404" ] && return 1
    if [ "$attempt" -ge 3 ]; then
      return 2
    fi
    log "  transient failure (HTTP ${http_code:-none}) fetching ${url}; retrying…"
    sleep $((attempt * 2))
  done
}

# D-06: naive MAJOR.MINOR.PATCH compare, prerelease ignored. Used only to pick
# which of two diagnostic messages to show on a missing manifest/signature --
# never to decide whether to enforce, which is version-independent.
SAILFIN_SIGNING_FLOOR="0.8.0"
_version_lt() {
  local left="${1%%-*}" right="${2%%-*}"
  local -a lv rv
  IFS=. read -r -a lv <<<"$left"
  IFS=. read -r -a rv <<<"$right"
  local i li ri
  for i in 0 1 2; do
    li="${lv[$i]:-0}"
    ri="${rv[$i]:-0}"
    # A non-numeric component (e.g. a malformed VERSION) is diagnostic-only
    # here (D-06) -- treat it as 0 rather than letting `-lt`/`-gt` emit
    # "integer expression expected" noise to stderr (SFN-1034).
    case "$li" in ''|*[!0-9]*) li=0 ;; esac
    case "$ri" in ''|*[!0-9]*) ri=0 ;; esac
    [ "$li" -lt "$ri" ] && return 0
    [ "$li" -gt "$ri" ] && return 1
  done
  return 1
}

# Detect OS/arch
UNAME_S="$(uname -s | tr '[:upper:]' '[:lower:]')"
case "$UNAME_S" in
  linux*) OS="linux" ;;
  darwin*) OS="macos" ;;
  msys*|mingw*|cygwin*) OS="windows" ;;
  *) die "Unsupported OS: $(uname -s)" ;;
esac

UNAME_M="$(uname -m)"
case "$UNAME_M" in
  x86_64|amd64) ARCH="x86_64" ;;
  aarch64|arm64) ARCH="arm64" ;;
  *) die "Unsupported architecture: $UNAME_M" ;;
esac

log "Detected OS: $OS"
log "Detected ARCH: $ARCH"

# Optional token for higher API rate limits.
api() {
  # $1 = url
  local auth_args=()
  if [ -n "${GITHUB_TOKEN:-}" ]; then
    auth_args=(-H "Authorization: Bearer ${GITHUB_TOKEN}")
  fi
  curl --fail -sSL \
    ${auth_args[@]+"${auth_args[@]}"} \
    -H "Accept: application/vnd.github+json" \
    "$1"
}

# Offline / local-archive install. Points the installer at a tarball already
# on disk instead of a published GitHub release.
#
# This is the only way to install an archive that has not been published, so
# it is also what lets CI smoke-test a freshly built payload through the real
# installer rather than a hand-rolled copy of its steps. An unpublished
# archive has no signed manifest, so signature verification never applies
# here; supplying SAILFIN_LOCAL_ARCHIVE_SHA256 reaches DIGEST_PINNED, and
# omitting it requires SAILFIN_ALLOW_UNVERIFIED=1 (D-05, SFN-1034). Either
# way this path demands an explicit VERSION.
LOCAL_ARCHIVE="${SAILFIN_LOCAL_ARCHIVE:-}"
if [ -n "$LOCAL_ARCHIVE" ]; then
  [ -f "$LOCAL_ARCHIVE" ] \
    || die "SAILFIN_LOCAL_ARCHIVE='${LOCAL_ARCHIVE}' is not a readable file."
  case "$LOCAL_ARCHIVE" in
    /*) : ;;
    *) LOCAL_ARCHIVE="$(cd "$(dirname "$LOCAL_ARCHIVE")" && pwd)/$(basename "$LOCAL_ARCHIVE")" ;;
  esac
  if [ -z "$VERSION" ] || [ "$VERSION" = "latest" ]; then
    die "SAILFIN_LOCAL_ARCHIVE requires an explicit VERSION (e.g. VERSION=0.9.5); 'latest' cannot be resolved offline."
  fi
fi

TAG=""
ASSET=""
RESOLVED_VIA_LATEST="0"
if [ -z "$VERSION" ] || [ "$VERSION" = "latest" ]; then
  RESOLVED_VIA_LATEST="1"
  log "VERSION is 'latest'; resolving most recent release with matching asset (including prereleases)…"
  releases_json="$(api "https://api.github.com/repos/${REPO}/releases?per_page=50")"

  select_release() {
    local binary_name="$1"
    # The msvc build is the native one with working TLS; the plain asset is
    # the legacy mingw cross build being retired by SFN-58. Prefer msvc,
    # falling back to plain — a release matches if either is present.
    # Fallback is mandatory: releases before v0.10.3 have no -msvc asset,
    # and arm64 has none at any version (SFN-1033).
    printf '%s' "$releases_json" | jq -c --arg binary "$binary_name" --arg os "$OS" --arg arch "$ARCH" --arg exclude "$EXCLUDE_TAG" '
        [ .[]
          | select(($exclude == "") or (.tag_name != $exclude))
          | . as $rel
          | ($rel.tag_name | sub("^v"; "")) as $ver
          | ($binary + "_" + $ver + "_" + $os + "_" + $arch + ".tar.gz") as $plain_asset
          | ($binary + "_" + $ver + "_" + $os + "_" + $arch + "-msvc.tar.gz") as $msvc_asset
          | (($rel.assets // [])) as $assets
          | (if ($os == "windows") then (any($assets[]; .name == $msvc_asset)) else false end) as $has_msvc
          | select($has_msvc or any($assets[]; .name == $plain_asset))
          | {tag: $rel.tag_name, version: $ver, asset: (if $has_msvc then $msvc_asset else $plain_asset end)}
        ][0]
      '
  }

  selected="$(select_release "$BINARY")"
  TAG="$(printf '%s' "$selected" | jq -r '.tag // empty')"
  VERSION="$(printf '%s' "$selected" | jq -r '.version // empty')"
  ASSET="$(printf '%s' "$selected" | jq -r '.asset // empty')"
  if [ -z "$TAG" ] || [ -z "$VERSION" ] || [ -z "$ASSET" ]; then
    if [ -n "$EXCLUDE_TAG" ]; then
      die "Could not find any release (excluding '${EXCLUDE_TAG}') with asset for ${OS}/${ARCH}."
    fi
    die "Could not find any release with asset for ${OS}/${ARCH}."
  fi
else
  VERSION="${VERSION#v}"
  VERSION="${VERSION#V}"
  TAG="v${VERSION}"
  ASSET="${BINARY}_${VERSION}_${OS}_${ARCH}.tar.gz"
fi

log "Using release tag: ${TAG}"
log "Using version: ${VERSION}"

# Resolve the asset id for the GitHub API download path. This call hits
# api.github.com, whose unauthenticated/low-quota responses can be rate
# limited (HTTP 403) — and a scoped token may not grant REST releases
# access at all. Treat the lookup as NON-FATAL: TAG and ASSET are already
# known (for a pinned version they are constructed without the API), so a
# failure here just routes us to the public release-download URL below,
# which consumes no API quota. `|| true` keeps `set -e` from aborting.
release_json=""
if [ -z "$LOCAL_ARCHIVE" ]; then
  release_json="$(api "https://api.github.com/repos/${REPO}/releases/tags/${TAG}" 2>/dev/null || true)"
fi

# Auth header shared by both download paths (optional; raises API rate
# limits and enables private-repo asset access). Hoisted above the msvc
# probe below (rather than left by the download calls that also use it)
# so that probe authenticates too: on a private repo with a
# REST-restricted token, release_json comes back empty and the probe
# would otherwise 404 unauthenticated, silently choosing the plain
# mingw asset even though the token would have worked (SFN-1033).
DL_AUTH_ARGS=()
if [ -n "${GITHUB_TOKEN:-}" ]; then
  DL_AUTH_ARGS=(-H "Authorization: Bearer ${GITHUB_TOKEN}")
fi

# Prefer the msvc asset for an explicit (non-"latest") Windows install; the
# "latest" path above already resolved this via releases_json. The msvc
# build is the native one with working TLS; the plain asset is the legacy
# mingw cross build being retired by SFN-58. The release-JSON lookup just
# above is deliberately non-fatal, so this can't depend on it being
# available: when it is, check the asset list directly; when it isn't
# (rate limiting or a scoped token), probe the public download URL
# instead. A release-download URL redirects to a presigned object URL
# signed for GET only, so HEAD returns 401 there — a ranged GET asks the
# same existence question the way the URL is signed to answer it
# (SFN-798). Fallback to plain is mandatory: releases before v0.10.3 have
# no -msvc asset, and arm64 has none at any version (SFN-1033).
if [ "$OS" = "windows" ] && [ -z "$LOCAL_ARCHIVE" ] && [ "$RESOLVED_VIA_LATEST" != "1" ]; then
  MSVC_ASSET="${BINARY}_${VERSION}_${OS}_${ARCH}-msvc.tar.gz"
  USE_MSVC=0
  if [ -n "$release_json" ]; then
    if printf '%s' "$release_json" \
        | jq -e --arg asset "$MSVC_ASSET" '[.assets[]? | select(.name==$asset)] | length > 0' \
        >/dev/null 2>&1; then
      USE_MSVC=1
    fi
  else
    MSVC_URL="https://github.com/${REPO}/releases/download/${TAG}/${MSVC_ASSET}"
    if curl -fsSL -o /dev/null -r 0-0 \
        ${DL_AUTH_ARGS[@]+"${DL_AUTH_ARGS[@]}"} \
        "$MSVC_URL" 2>/dev/null; then
      USE_MSVC=1
    fi
  fi
  if [ "$USE_MSVC" = "1" ]; then
    ASSET="$MSVC_ASSET"
  fi
fi

log "Expected asset: ${ASSET}"

asset_id=""
if [ -n "$release_json" ]; then
  asset_id="$(printf '%s' "$release_json" | jq -r '.assets[]? | select(.name=="'"$ASSET"'") | .id' 2>/dev/null | head -n 1)"
fi

TMPDIR="$(mktemp -d)"
cleanup() {
  rm -rf "$TMPDIR" 2>/dev/null || true
}
trap cleanup EXIT

ARCHIVE_PATH="${TMPDIR}/${ASSET}"
if [ -n "$LOCAL_ARCHIVE" ]; then
  ASSET="$(basename "$LOCAL_ARCHIVE")"
  ARCHIVE_PATH="$LOCAL_ARCHIVE"
fi

# D-11: location-only mirror override. Verification below is unconditional
# and the trust anchor is not overridable (R-5) -- this only changes WHERE
# the manifest/signature/archive are fetched from.
RELEASE_BASE="${SAILFIN_RELEASE_BASE:-https://github.com/${REPO}/releases/download}"

# Primary: GitHub API asset download (handles private repos + auth). Only
# attempted when the asset id resolved above.
download_via_api() {
  [ -n "$asset_id" ] && [ "$asset_id" != "null" ] || return 1
  log "Downloading asset via GitHub API (id=${asset_id})…"
  curl --fail -sSL \
    ${DL_AUTH_ARGS[@]+"${DL_AUTH_ARGS[@]}"} \
    -H "Accept: application/octet-stream" \
    "https://api.github.com/repos/${REPO}/releases/assets/${asset_id}" \
    -o "$ARCHIVE_PATH"
}

# Fallback: the public browser release-download URL. Needs neither the
# REST API nor an asset id, so it survives API rate limiting / a
# REST-restricted token for public releases.
DIRECT_URL="${RELEASE_BASE}/${TAG}/${ASSET}"
download_via_direct() {
  log "Downloading asset via release URL (${DIRECT_URL})…"
  local direct_auth_args=()
  # A mirror override (SAILFIN_RELEASE_BASE) points DIRECT_URL at an arbitrary
  # operator-supplied host; sending the caller's GitHub token there would
  # exfiltrate a credential meant only for github.com (SFN-1034).
  if [ -z "${SAILFIN_RELEASE_BASE:-}" ]; then
    direct_auth_args=(${DL_AUTH_ARGS[@]+"${DL_AUTH_ARGS[@]}"})
  fi
  curl --fail -sSL \
    ${direct_auth_args[@]+"${direct_auth_args[@]}"} \
    "$DIRECT_URL" \
    -o "$ARCHIVE_PATH"
}

download_release_archive() {
  # An explicit mirror must redirect the PAYLOAD too, not just the manifest.
  # The GitHub API path ignores RELEASE_BASE, so preferring it here would let
  # an operator who pointed this at an internal mirror still fetch the archive
  # from github.com -- and would make an offline fixture silently test the
  # real release instead of the one it staged (SFN-1034).
  if [ -n "${SAILFIN_RELEASE_BASE:-}" ]; then
    download_via_direct \
      || die "Could not download asset '${ASSET}' for release '${TAG}' from ${DIRECT_URL}."
    return 0
  fi
  if ! download_via_api; then
    if [ -n "$asset_id" ] && [ "$asset_id" != "null" ]; then
      log "GitHub API asset download failed; falling back to the public release URL."
    else
      log "GitHub API asset lookup unavailable (rate limit or restricted token); using the public release URL."
    fi
    download_via_direct \
      || die "Could not download asset '${ASSET}' for release '${TAG}' via the GitHub API or ${DIRECT_URL}."
  fi
}

# D-06: enforcement never branches on version; these two messages differ only
# in wording, chosen by the diagnostic-only SAILFIN_SIGNING_FLOOR.
missing_manifest_message() {
  local absent="${1:-SHA256SUMS}"
  local reason
  if _version_lt "$VERSION" "$SAILFIN_SIGNING_FLOOR"; then
    reason="release '${TAG}' predates release signing (Sailfin's first signed release is v0.8.0-alpha.4); no ${absent} is published for it."
  else
    reason="release '${TAG}' must publish ${absent}, but the fetch returned 404 -- either a broken release or an attempt to strip verification."
  fi
  printf '%s Set SAILFIN_ALLOW_UNVERIFIED=1 to install it anyway with no signature or digest verification (forfeits all integrity checking of the downloaded archive). See https://sailfin.dev/docs/getting-started/verify-download for manual verification.' "$reason"
}

# D-10: name every candidate tried and why, per-platform remediation, the
# opt-in and what it forfeits, and the manual-verification doc.
no_verifier_message() {
  local msg="No Ed25519 signature verifier on this host passed the RFC 8032 known-answer test; refusing to install '${ASSET}' unverified."
  local attempt
  for attempt in ${VERIFIER_ATTEMPTS[@]+"${VERIFIER_ATTEMPTS[@]}"}; do
    msg="${msg}
  tried: ${attempt}"
  done
  msg="${msg}
Fix by installing an OpenSSL 3.0+ build (pkeyutl -rawin requires it):
  macOS:          brew install openssl@3
  Debian/Ubuntu:  apt-get install openssl
  Fedora/RHEL:    dnf install openssl
  Or point directly at a working binary: export SAILFIN_OPENSSL=/path/to/openssl
Or set SAILFIN_ALLOW_UNVERIFIED=1 to install anyway. This forfeits signature
verification; the archive's digest is still checked against the fetched
manifest when a digest tool is available, but that manifest travels
unsigned-trust over the same channel as the archive.
See https://sailfin.dev/docs/getting-started/verify-download for manual verification."
  printf '%s' "$msg"
}

no_digest_tool_message() {
  local msg="No SHA-256 digest tool on this host passed the known-answer test; refusing to install '${ASSET}' without a digest check."
  local attempt
  for attempt in ${DIGEST_ATTEMPTS[@]+"${DIGEST_ATTEMPTS[@]}"}; do
    msg="${msg}
  tried: ${attempt}"
  done
  msg="${msg}
Install sha256sum (GNU coreutils), shasum (macOS/BSD), or a working openssl.
See https://sailfin.dev/docs/getting-started/verify-download for manual verification."
  printf '%s' "$msg"
}

# D-08: verify metadata BEFORE downloading the (potentially large) archive.
# Sets TRUST_STATE (D-05) and, on VERIFIED_SIGNED/DIGEST_PINNED/case-c
# UNVERIFIED_EXPLICIT, downloads and digest-checks the archive itself.
# CHECKED_DIGEST records the digest actually compared for VERIFIED_SIGNED,
# so the terminal assertion below (S10) can tell "checked" from "unset"
# without reaching into verify_and_download_release's locals (SFN-1034).
TRUST_STATE=""
CHECKED_DIGEST=""
verify_and_download_release() {
  local manifest_path="${TMPDIR}/SHA256SUMS"
  local signature_hex_path="${TMPDIR}/SHA256SUMS.sig"
  local signature_raw_path="${TMPDIR}/SHA256SUMS.sig.raw"
  local public_key_path="${TMPDIR}/ed25519-release.pub.pem"
  local verification_base="${RELEASE_BASE}/${TAG}"
  local manifest_rc=1 sig_rc=1
  local signature_hex="" expected_digest="" actual_digest=""

  # `cmd; rc=$?` is wrong under `set -e`: a non-zero return exits the script
  # before the assignment runs, so a 404 aborted here with NO diagnostic --
  # indistinguishable from a verification that silently did nothing. Capture
  # the status in the same statement so the fail-closed messages below are
  # actually reachable (SFN-1034).
  manifest_rc=0
  fetch_with_retry "${verification_base}/SHA256SUMS" "$manifest_path" || manifest_rc=$?
  if [ "$manifest_rc" -eq 0 ]; then
    sig_rc=0
    fetch_with_retry "${verification_base}/SHA256SUMS.sig" "$signature_hex_path" || sig_rc=$?
  fi

  # rc 2 is "could not be reached", NOT "is not published". Collapsing them is
  # the R-4 conflation this issue exists to remove: a blocked, throttled or
  # captive-portal'd request would otherwise report as an unsigned release --
  # and, with the opt-in set, would silently install unverified. An
  # unreachable manifest is a hard failure that SAILFIN_ALLOW_UNVERIFIED
  # deliberately cannot override, because consent to install an *unsigned
  # artifact* is not consent to skip a check that was merely prevented.
  if [ "$manifest_rc" -eq 2 ] || [ "$sig_rc" -eq 2 ]; then
    die "could not fetch the release manifest for '${TAG}' from ${verification_base} after 3 attempts. A signed manifest that cannot be reached is a hard failure, not a reason to continue unverified. Check connectivity or the mirror, then retry."
  fi

  if [ "$manifest_rc" -ne 0 ] || [ "$sig_rc" -ne 0 ]; then
    local absent="SHA256SUMS"
    [ "$manifest_rc" -eq 0 ] && absent="SHA256SUMS.sig"
    [ "${SAILFIN_ALLOW_UNVERIFIED:-0}" = "1" ] || die "$(missing_manifest_message "$absent")"
    log "WARNING: UNVERIFIED INSTALL — release '${TAG}' published no ${absent}; installing '${ASSET}' with no signature or digest verification (SAILFIN_ALLOW_UNVERIFIED=1)."
    TRUST_STATE="UNVERIFIED_EXPLICIT"
    download_release_archive
    return 0
  fi

  if select_signature_verifier; then
    signature_hex="$(tr -d '[:space:]' < "$signature_hex_path")"
    if ! printf '%s' "$signature_hex" | grep -Eq '^[0-9a-fA-F]{128}$'; then
      die "Release manifest signature is malformed; refusing to install '${ASSET}'."
    fi
    hex_to_raw_file "$signature_hex" "$signature_raw_path"
    printf '%s\n' "$RELEASE_SIGNING_PUBLIC_KEY_PEM" > "$public_key_path"

    if ! "$VERIFIER_CMD" pkeyutl -verify -pubin -inkey "$public_key_path" -rawin \
        -in "$manifest_path" -sigfile "$signature_raw_path" >/dev/null 2>&1; then
      die "Release manifest signature verification failed; refusing to install '${ASSET}' (tampering or a corrupted mirror)."
    fi
    log "verified: SHA256SUMS ed25519 signature (verifier: ${VERIFIER_NAME})"
    TRUST_STATE="VERIFIED_SIGNED"
  else
    [ "${SAILFIN_ALLOW_UNVERIFIED:-0}" = "1" ] || die "$(no_verifier_message)"
    log "WARNING: UNVERIFIED INSTALL — no KAT-passing Ed25519 verifier is available; installing '${ASSET}' with no signature verification (SAILFIN_ALLOW_UNVERIFIED=1). Its digest will still be checked against the fetched, unsigned-trust manifest when possible."
    local attempt
    for attempt in ${VERIFIER_ATTEMPTS[@]+"${VERIFIER_ATTEMPTS[@]}"}; do
      log "  tried: ${attempt}"
    done
    TRUST_STATE="UNVERIFIED_EXPLICIT"
  fi

  # Manifest well-formedness always aborts on failure, regardless of trust
  # state -- a missing/duplicate asset entry is never something the opt-in
  # excuses (D-05).
  if ! expected_digest="$(awk -v asset="$ASSET" '
      NF >= 2 {
        digest = $1
        $1 = ""
        sub(/^[[:space:]]*\*?/, "", $0)
        if ($0 == asset) { count++; value = digest }
      }
      END { if (count == 1) print value; else exit 1 }
    ' "$manifest_path")"; then
    die "Signed release manifest does not contain exactly one entry for '${ASSET}'."
  fi
  if ! printf '%s' "$expected_digest" | grep -Eq '^[0-9a-fA-F]{64}$'; then
    die "Signed release manifest has a malformed digest for '${ASSET}'."
  fi
  expected_digest="$(printf '%s' "$expected_digest" | tr '[:upper:]' '[:lower:]')"

  download_release_archive

  select_digest_tool || die "$(no_digest_tool_message)"
  actual_digest="$(digest_compute "$DIGEST_KIND" "$ARCHIVE_PATH" | tr '[:upper:]' '[:lower:]')" || true
  if [ "$actual_digest" != "$expected_digest" ]; then
    rm -f "$ARCHIVE_PATH" 2>/dev/null || true
    die "SHA-256 digest mismatch for '${ASSET}'; refusing to install it."
  fi
  if [ "$TRUST_STATE" = "UNVERIFIED_EXPLICIT" ]; then
    log "digest check: ${ASSET} sha256 ${actual_digest} matched an UNSIGNED manifest — this is not a trust statement."
  else
    log "verified: ${ASSET} sha256 ${actual_digest}"
    CHECKED_DIGEST="$expected_digest"
  fi
}

if [ -n "$LOCAL_ARCHIVE" ]; then
  log "Installing from local archive: ${LOCAL_ARCHIVE}"
  LOCAL_ARCHIVE_SHA256="${SAILFIN_LOCAL_ARCHIVE_SHA256:-}"
  if [ -n "$LOCAL_ARCHIVE_SHA256" ]; then
    if ! printf '%s' "$LOCAL_ARCHIVE_SHA256" | grep -Eq '^[0-9a-fA-F]{64}$'; then
      die "SAILFIN_LOCAL_ARCHIVE_SHA256 is malformed; expected 64 hex characters."
    fi
    select_digest_tool || die "$(no_digest_tool_message)"
    actual_digest="$(digest_compute "$DIGEST_KIND" "$ARCHIVE_PATH" | tr '[:upper:]' '[:lower:]')" || true
    expected_digest="$(printf '%s' "$LOCAL_ARCHIVE_SHA256" | tr '[:upper:]' '[:lower:]')"
    if [ "$actual_digest" != "$expected_digest" ]; then
      die "SHA-256 digest mismatch for local archive '${ASSET}'; refusing to install it."
    fi
    log "digest-pinned: ${ASSET} sha256 ${actual_digest} (digest-pinned via SAILFIN_LOCAL_ARCHIVE_SHA256, not signature-verified)"
    TRUST_STATE="DIGEST_PINNED"
    CHECKED_DIGEST="$expected_digest"
  else
    [ "${SAILFIN_ALLOW_UNVERIFIED:-0}" = "1" ] \
      || die "SAILFIN_LOCAL_ARCHIVE has no SAILFIN_LOCAL_ARCHIVE_SHA256 to pin against, so it cannot be verified. Set SAILFIN_LOCAL_ARCHIVE_SHA256=<sha256 of the archive>, or SAILFIN_ALLOW_UNVERIFIED=1 to install it anyway (forfeits all integrity checking of this archive)."
    log "WARNING: UNVERIFIED INSTALL — SAILFIN_LOCAL_ARCHIVE has no SAILFIN_LOCAL_ARCHIVE_SHA256; installing '${ASSET}' with no digest or signature verification (SAILFIN_ALLOW_UNVERIFIED=1)."
    TRUST_STATE="UNVERIFIED_EXPLICIT"
  fi
else
  verify_and_download_release
fi

# S10: defensive terminal assertion. The trust-state branching above is the
# entire enforcement surface -- a future edit that leaves TRUST_STATE unset,
# or that reaches VERIFIED_SIGNED without ever comparing a digest, must fail
# loudly here rather than silently installing with nothing checked and
# nothing printed (SFN-1034).
case "$TRUST_STATE" in
  VERIFIED_SIGNED | DIGEST_PINNED | UNVERIFIED_EXPLICIT) : ;;
  *) die "internal error: TRUST_STATE is '${TRUST_STATE}', expected one of VERIFIED_SIGNED, DIGEST_PINNED, UNVERIFIED_EXPLICIT." ;;
esac
if [ "$TRUST_STATE" = "VERIFIED_SIGNED" ] && [ -z "$CHECKED_DIGEST" ]; then
  die "internal error: TRUST_STATE is VERIFIED_SIGNED but no digest was ever checked."
fi

# Validate archive
if ! tar -tzf "$ARCHIVE_PATH" >/dev/null 2>&1; then
  log "Archive validation failed; first 50 bytes:" 
  head -c 50 "$ARCHIVE_PATH" | sed 's/[^[:print:]]/./g' || true
  die "Downloaded asset is not a valid .tar.gz archive."
fi

EXTRACT_DIR="${TMPDIR}/extract"
mkdir -p "$EXTRACT_DIR"
log "Extracting ${ASSET}…"
tar -xzf "$ARCHIVE_PATH" -C "$EXTRACT_DIR"

ROOT_DIR="$EXTRACT_DIR"
if [ ! -d "${EXTRACT_DIR}/bin" ] && [ ! -f "${EXTRACT_DIR}/${BINARY}" ] && [ ! -f "${EXTRACT_DIR}/${BINARY}.exe" ]; then
  FIRST_DIR="$(find "${EXTRACT_DIR}" -mindepth 1 -maxdepth 1 -type d | head -n 1)"
  if [ -n "$FIRST_DIR" ]; then
    ROOT_DIR="$FIRST_DIR"
  fi
fi

SRC_BINARY=""
if [ "$OS" = "windows" ]; then
  if [ -f "${ROOT_DIR}/${BINARY}.exe" ]; then
    SRC_BINARY="${ROOT_DIR}/${BINARY}.exe"
  elif [ -f "${ROOT_DIR}/bin/${BINARY}.exe" ]; then
    SRC_BINARY="${ROOT_DIR}/bin/${BINARY}.exe"
  elif [ -f "${ROOT_DIR}/${BINARY}" ]; then
    SRC_BINARY="${ROOT_DIR}/${BINARY}"
  elif [ -f "${ROOT_DIR}/bin/${BINARY}" ]; then
    SRC_BINARY="${ROOT_DIR}/bin/${BINARY}"
  else
    die "Binary '${BINARY}.exe' not found in archive."
  fi
else
  if [ -f "${ROOT_DIR}/${BINARY}" ]; then
    SRC_BINARY="${ROOT_DIR}/${BINARY}"
  elif [ -f "${ROOT_DIR}/bin/${BINARY}" ]; then
    SRC_BINARY="${ROOT_DIR}/bin/${BINARY}"
  else
    die "Binary '${BINARY}' not found in archive."
  fi
fi

# SFEP-0073: key the per-user store by the canonical host triple before the
# exact version. Windows identity follows the asset that was actually selected:
# the preferred native archive is MSVC, while the plain compatibility fallback
# is MinGW. Resolve this only after every signed-manifest/mirror fallback has
# finalized ASSET so producer and store identity cannot disagree.
case "${OS}/${ARCH}" in
  linux/x86_64) HOST_TRIPLE="x86_64-unknown-linux-gnu" ;;
  linux/arm64) HOST_TRIPLE="aarch64-unknown-linux-gnu" ;;
  macos/x86_64) HOST_TRIPLE="x86_64-apple-darwin" ;;
  macos/arm64) HOST_TRIPLE="aarch64-apple-darwin" ;;
  windows/x86_64)
    case "$ASSET" in
      *-msvc.tar.gz) HOST_TRIPLE="x86_64-pc-windows-msvc" ;;
      *) HOST_TRIPLE="x86_64-w64-mingw32" ;;
    esac
    ;;
  *) die "Unsupported canonical host for toolchain storage: ${OS}/${ARCH}" ;;
esac
log "Detected host triple: $HOST_TRIPLE"

INSTALL_BASE="${INSTALL_BASE:-$HOME/.local/share/sailfin/versions}"
GLOBAL_BIN_DIR="${GLOBAL_BIN_DIR:-$HOME/.local/bin}"
if [ "${SAILFIN_BOOTSTRAP_SEED_STORE:-0}" = "1" ]; then
  # Internal seam for the repo-local seed store, set by
  # `.github/actions/fetch-seed`, `sailfin-build` and the session-start hook.
  # bootstrap.toml remains the sole authority for that store.
  TARGET_DIR="${INSTALL_BASE}/${VERSION}"
  log "Using flat bootstrap seed-store layout"
else
  TARGET_DIR="${INSTALL_BASE}/${HOST_TRIPLE}/${VERSION}"
fi

MAYBE_SUDO=""
if [ ! -d "${INSTALL_BASE}" ]; then
  mkdir -p "${INSTALL_BASE}" 2>/dev/null || true
fi
if [ ! -w "${INSTALL_BASE}" ]; then
  MAYBE_SUDO="sudo"
fi

log "Installing to ${TARGET_DIR}…"
$MAYBE_SUDO mkdir -p "${TARGET_DIR}"
# A prior marker must not describe bytes while this direct installer writer is
# refreshing them. A new marker is published only after the payload is complete.
$MAYBE_SUDO rm -f "${TARGET_DIR}/.sha256"

DEST_BASENAME="$BINARY"
if [ "$OS" = "windows" ] && [[ "$SRC_BINARY" == *.exe ]]; then
  DEST_BASENAME="${BINARY}.exe"
fi

$MAYBE_SUDO install -m 0755 "$SRC_BINARY" "${TARGET_DIR}/${DEST_BASENAME}"

# SFN-195: a compiler built from post-SFN-173 source (in-tree artifact renamed
# to `sfn`; first released 0.8.0-alpha.3) resolves its own realpath dir and
# re-invokes `<dir>/sfn` when spawning parallel emit workers. The release
# artifact is still packaged as `sailfin`, so without a `sfn`-named peer IN THE
# VERSIONED DIR every parallel `sfn build` (and `make rebuild` with a fetched
# seed) dies with `<dir>/sfn: not found`. Provide the `sfn` name next to the
# installed binary. Relative symlink (same dir) so it holds regardless of
# absolute/relative TARGET_DIR; copy fallback for filesystems without symlinks.
VERSIONED_ALIAS_BASENAME="sfn"
if [ "$OS" = "windows" ] && [[ "$DEST_BASENAME" == *.exe ]]; then
  VERSIONED_ALIAS_BASENAME="sfn.exe"
fi
if [ "$VERSIONED_ALIAS_BASENAME" != "$DEST_BASENAME" ]; then
  VERSIONED_ALIAS_PATH="${TARGET_DIR}/${VERSIONED_ALIAS_BASENAME}"
  if [ -L "$VERSIONED_ALIAS_PATH" ] || [ -f "$VERSIONED_ALIAS_PATH" ]; then
    $MAYBE_SUDO rm -f "$VERSIONED_ALIAS_PATH"
  fi
  if ! $MAYBE_SUDO ln -s "$DEST_BASENAME" "$VERSIONED_ALIAS_PATH" 2>/dev/null; then
    $MAYBE_SUDO cp -f "${TARGET_DIR}/${DEST_BASENAME}" "$VERSIONED_ALIAS_PATH"
    $MAYBE_SUDO chmod 0755 "$VERSIONED_ALIAS_PATH" || true
  fi
fi

# When INSTALL_BASE / GLOBAL_BIN_DIR are relative paths (as in CI), creating a
# symlink to a relative TARGET_DIR will produce a broken link (the link target
# is resolved relative to the link's directory). Resolve to absolute paths so
# symlinks work regardless of cwd.
TARGET_DIR_ABS="$(cd "${TARGET_DIR}" && pwd)"
LINK_TARGET="${TARGET_DIR_ABS}/${DEST_BASENAME}"

# Global commands normally resolve through a symlink, which preserves the
# versioned executable path used to discover runtime/ and workspace.toml. On a
# filesystem that cannot create symlinks, preserve the executable artifact and
# publish an install-root pointer that gives the copied compiler the same
# versioned discovery anchor.
GLOBAL_PAYLOAD_POINTER="${GLOBAL_BIN_DIR}/sailfin-install-root"
GLOBAL_COPY_FALLBACK=0
install_global_command() {
  local destination="$1"
  if [ -L "$destination" ] || [ -f "$destination" ]; then
    $MAYBE_SUDO rm -f "$destination"
  fi
  if $MAYBE_SUDO ln -s "$LINK_TARGET" "$destination" 2>/dev/null; then
    log "Linked: ${destination} -> ${LINK_TARGET}"
    return
  fi
  $MAYBE_SUDO cp -f "${TARGET_DIR}/${DEST_BASENAME}" "$destination"
  $MAYBE_SUDO chmod 0755 "$destination" || true
  GLOBAL_COPY_FALLBACK=1
  log "Installed copy: ${destination}"
}

if [ -d "${ROOT_DIR}/runtime" ]; then
  log "Installing runtime bundle to ${TARGET_DIR}/runtime…"
  $MAYBE_SUDO rm -rf "${TARGET_DIR}/runtime" 2>/dev/null || true
  $MAYBE_SUDO cp -R "${ROOT_DIR}/runtime" "${TARGET_DIR}/runtime"
else
  log "Warning: runtime bundle not found in archive; sfn run/build will fail without it."
fi

# The compiler/runtime workspace dependency closure, staged by
# `sfn package --installer` (SFN-773, SFN-937) as a sibling of runtime/ — the
# compatibility shape installed dependency discovery resolves.
if [ -d "${ROOT_DIR}/capsules" ]; then
  log "Installing runtime capsule dependencies to ${TARGET_DIR}/capsules…"
  $MAYBE_SUDO rm -rf "${TARGET_DIR}/capsules" 2>/dev/null || true
  $MAYBE_SUDO cp -R "${ROOT_DIR}/capsules" "${TARGET_DIR}/capsules"
fi

# SFN-937: install the generated workspace manifest only after its canonical
# capsule payload. Older archives have no workspace.toml and keep their
# runtime-only compatibility behavior.
$MAYBE_SUDO rm -f "${TARGET_DIR}/workspace.toml"
if [ -f "${ROOT_DIR}/workspace.toml" ]; then
  [ -d "${TARGET_DIR}/capsules" ] \
    || die "Bundled workspace manifest has no installed capsule payload."
  log "Installing bundled workspace manifest to ${TARGET_DIR}/workspace.toml…"
  $MAYBE_SUDO cp -f "${ROOT_DIR}/workspace.toml" "${TARGET_DIR}/workspace.toml"
fi

# Native dispatch uses this archive-digest marker only as the completeness
# commit point. Explicitly unverified installs remain runnable entry payloads
# but are not eligible as host-qualified dispatch candidates.
if [ -n "$CHECKED_DIGEST" ]; then
  STORE_MARKER_TEMP="${TMPDIR}/toolchain-store.sha256"
  printf '%s\n' "$CHECKED_DIGEST" > "$STORE_MARKER_TEMP"
  $MAYBE_SUDO install -m 0644 "$STORE_MARKER_TEMP" "${TARGET_DIR}/.sha256"
fi

log "Ensuring global symlink in ${GLOBAL_BIN_DIR}…"
$MAYBE_SUDO mkdir -p "${GLOBAL_BIN_DIR}"
GLOBAL_PAYLOAD_OWNED=0
if [ -f "$GLOBAL_PAYLOAD_POINTER" ]; then
  GLOBAL_PAYLOAD_OWNED=1
fi
# Releases predating SFN-937 do not understand the install-root pointer and
# were mirrored beside a copied executable. A pointer marks those exact paths
# as installer-owned, so upgrades can retire the compatibility mirror safely.
if [ "$GLOBAL_PAYLOAD_OWNED" -eq 1 ]; then
  $MAYBE_SUDO rm -rf "${GLOBAL_BIN_DIR}/runtime" "${GLOBAL_BIN_DIR}/capsules"
  $MAYBE_SUDO rm -f "${GLOBAL_BIN_DIR}/workspace.toml"
fi
$MAYBE_SUDO rm -f "$GLOBAL_PAYLOAD_POINTER"
LINK_PATH="${GLOBAL_BIN_DIR}/${DEST_BASENAME}"
install_global_command "$LINK_PATH"

ALIAS_BASENAME="sfn"
if [ "$OS" = "windows" ] && [[ "$DEST_BASENAME" == *.exe ]]; then
  ALIAS_BASENAME="sfn.exe"
fi

ALIAS_PATH="${GLOBAL_BIN_DIR}/${ALIAS_BASENAME}"
install_global_command "$ALIAS_PATH"

SAILFIN_ALIAS_BASENAME="sailfin"
if [ "$OS" = "windows" ] && [[ "$DEST_BASENAME" == *.exe ]]; then
  SAILFIN_ALIAS_BASENAME="sailfin.exe"
fi

SAILFIN_ALIAS_PATH="${GLOBAL_BIN_DIR}/${SAILFIN_ALIAS_BASENAME}"
install_global_command "$SAILFIN_ALIAS_PATH"

if [ "$GLOBAL_COPY_FALLBACK" -eq 1 ]; then
  for legacy_path in runtime capsules workspace.toml; do
    if [ -e "${GLOBAL_BIN_DIR}/${legacy_path}" ] && [ "$GLOBAL_PAYLOAD_OWNED" -ne 1 ]; then
      die "Refusing to replace unowned ${GLOBAL_BIN_DIR}/${legacy_path} for the adjacent payload mirror."
    fi
  done
  # The pointer alone is not sufficient for any compiler published through
  # 0.10.5. Only the CLI driver reads it; the analyzer's prelude-global loader
  # re-derives the runtime root from the executable's own directory, which for
  # a copied (non-symlinked) executable resolves nowhere. It then contributes
  # no prelude names and every bare prelude call fails E0420 (SFN-1124). The
  # adjacent runtime/ mirror is what that probe finds, so it is mirrored for
  # every archive, not only pre-SFN-937 ones.
  #
  # This deliberately re-couples a version-shared bin directory to one
  # version's payload, which SFN-937 set out to undo. Remove this mirror and
  # restore the legacy-only guard once a release carrying the SFN-1124
  # compiler fix is the pinned seed, deleting this comment with it (SFN-1125).
  if [ -d "${TARGET_DIR}/runtime" ]; then
    $MAYBE_SUDO cp -R "${TARGET_DIR}/runtime" "${GLOBAL_BIN_DIR}/runtime"
    log "Installed adjacent runtime mirror for copied-executable discovery."
  fi
  # capsules/ stays legacy-only: the pointer already anchors dependency
  # discovery for it, and it is the expensive tree SFN-937 exists to stop
  # duplicating.
  if [ ! -f "${ROOT_DIR}/workspace.toml" ]; then
    if [ -d "${TARGET_DIR}/capsules" ]; then
      $MAYBE_SUDO cp -R "${TARGET_DIR}/capsules" "${GLOBAL_BIN_DIR}/capsules"
    fi
    log "Installed adjacent capsule mirror for pre-SFN-937 compiler compatibility."
  fi
  PAYLOAD_POINTER_TEMP="${TMPDIR}/sailfin-install-root"
  printf '%s' "$TARGET_DIR_ABS" > "$PAYLOAD_POINTER_TEMP"
  $MAYBE_SUDO install -m 0644 "$PAYLOAD_POINTER_TEMP" "$GLOBAL_PAYLOAD_POINTER"
  log "Installed payload pointer: ${GLOBAL_PAYLOAD_POINTER} -> ${TARGET_DIR_ABS}"
fi

RESOLVED_SFN="$(command -v sfn 2>/dev/null || true)"
if [ -n "$RESOLVED_SFN" ] && [ "$RESOLVED_SFN" != "$ALIAS_PATH" ]; then
  log "Warning: 'sfn' resolves to ${RESOLVED_SFN} (not ${ALIAS_PATH})."
  log "If you previously installed Stage0, remove that binary or ensure ${GLOBAL_BIN_DIR} comes first in PATH."
fi

log "Installed: ${TARGET_DIR_ABS}/${DEST_BASENAME}"

# A seed-store install populates a repo-local bootstrap seed, not the user's
# entry toolchain, so none of the lifecycle guidance below is true of it.
if [ "${SAILFIN_BOOTSTRAP_SEED_STORE:-0}" != "1" ]; then
  log "entry toolchain: ${VERSION} (${ALIAS_PATH})"
  # The installer deliberately does not write a user default record: with none
  # recorded, selection falls back to the entry toolchain, which is the release
  # just installed (SFEP-0073 Sec3.5). Re-running on a machine that already has
  # one must not claim otherwise -- a stale default is precisely the
  # entry-vs-selected confusion this block exists to surface. Presence only:
  # parsing the schema-versioned, host-keyed record here would duplicate
  # user_default.sfn in shell, so the wording says a record exists rather than
  # claiming it binds this host, and defers the authoritative answer to
  # `sfn toolchain active`.
  #
  # Resolved the long way because install.sh runs under `set -u` and this is
  # the only $HOME dereference on a path where INSTALL_BASE and GLOBAL_BIN_DIR
  # are both supplied, so the defaults at the top of the script never ran.
  # Aborting here would report a finished install as a failure. An
  # unresolvable home means "no record", matching
  # user_default.sfn::toolchain_user_default_dir.
  sfn_config_dir="${SAILFIN_CONFIG_DIR:-}"
  if [ -z "$sfn_config_dir" ] && [ -n "${HOME:-}" ]; then
    sfn_config_dir="${HOME}/.sfn"
  fi
  if [ -n "$sfn_config_dir" ] && [ -s "${sfn_config_dir}/toolchain-default" ]; then
    log "default toolchain: a user default record exists; run 'sfn toolchain active' to see what unpinned commands select"
  else
    log "default toolchain: none recorded; unpinned commands use the entry toolchain"
  fi
  log "Manage this installation natively:"
  log "  sfn toolchain active"
  log "  sfn toolchain update --check"
  log "  sfn toolchain default <version>"
  log "This installer is the one-time on-ramp onto management protocol 1."
  log "An 'sfn' predating that protocol cannot route the native lifecycle"
  log "commands, so crossing over takes one run of this installer or of your"
  log "package manager's upgrade. After that, 'sfn toolchain update' is the"
  log "supported update path, and it never replaces this entry executable."
fi

if [[ ":$PATH:" != *":${GLOBAL_BIN_DIR}:"* ]]; then
  echo
  echo "Add this to your shell profile to use '${BINARY}':"
  echo "  export PATH=\"${GLOBAL_BIN_DIR}:\$PATH\""
fi
