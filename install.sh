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
#   INSTALL_BASE=...         (default: ~/.local/share/sailfin/versions)
#   GLOBAL_BIN_DIR=...       (default: ~/.local/bin)
#   GITHUB_TOKEN=...         (optional; increases API rate limits)
#
# Assets are expected to be named:
#   sailfin_<version>_<os>_<arch>.tar.gz
# where <os> is linux|macos|windows and <arch> is x86_64|arm64.

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

TAG=""
ASSET=""
if [ -z "$VERSION" ] || [ "$VERSION" = "latest" ]; then
  log "VERSION is 'latest'; resolving most recent release with matching asset (including prereleases)…"
  releases_json="$(api "https://api.github.com/repos/${REPO}/releases?per_page=50")"

  select_release() {
    local binary_name="$1"
    printf '%s' "$releases_json" | jq -c --arg binary "$binary_name" --arg os "$OS" --arg arch "$ARCH" --arg exclude "$EXCLUDE_TAG" '
        [ .[]
          | select(($exclude == "") or (.tag_name != $exclude))
          | . as $rel
          | ($rel.tag_name | sub("^v"; "")) as $ver
          | ($binary + "_" + $ver + "_" + $os + "_" + $arch + ".tar.gz") as $asset
          | select(any((($rel.assets // [])[]); .name == $asset))
          | {tag: $rel.tag_name, version: $ver, asset: $asset}
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
log "Expected asset: ${ASSET}"

# Resolve the asset id for the GitHub API download path. This call hits
# api.github.com, whose unauthenticated/low-quota responses can be rate
# limited (HTTP 403) — and a scoped token may not grant REST releases
# access at all. Treat the lookup as NON-FATAL: TAG and ASSET are already
# known (for a pinned version they are constructed without the API), so a
# failure here just routes us to the public release-download URL below,
# which consumes no API quota. `|| true` keeps `set -e` from aborting.
release_json="$(api "https://api.github.com/repos/${REPO}/releases/tags/${TAG}" 2>/dev/null || true)"
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

# Auth header shared by both download paths (optional; raises API rate
# limits and enables private-repo asset access).
DL_AUTH_ARGS=()
if [ -n "${GITHUB_TOKEN:-}" ]; then
  DL_AUTH_ARGS=(-H "Authorization: Bearer ${GITHUB_TOKEN}")
fi

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
DIRECT_URL="https://github.com/${REPO}/releases/download/${TAG}/${ASSET}"
download_via_direct() {
  log "Downloading asset via release URL (${DIRECT_URL})…"
  curl --fail -sSL \
    ${DL_AUTH_ARGS[@]+"${DL_AUTH_ARGS[@]}"} \
    "$DIRECT_URL" \
    -o "$ARCHIVE_PATH"
}

if ! download_via_api; then
  if [ -n "$asset_id" ] && [ "$asset_id" != "null" ]; then
    log "GitHub API asset download failed; falling back to the public release URL."
  else
    log "GitHub API asset lookup unavailable (rate limit or restricted token); using the public release URL."
  fi
  download_via_direct \
    || die "Could not download asset '${ASSET}' for release '${TAG}' via the GitHub API or ${DIRECT_URL}."
fi

# Verify before parsing or extracting any downloaded bytes. An unsigned older
# release or host without suitable raw-Ed25519 support remains installable with
# a warning; once verification can run, every failure is a tampering signal.
verify_release_archive() {
  local manifest_path="${TMPDIR}/SHA256SUMS"
  local signature_hex_path="${TMPDIR}/SHA256SUMS.sig"
  local signature_raw_path="${TMPDIR}/SHA256SUMS.sig.raw"
  local public_key_path="${TMPDIR}/ed25519-release.pub.pem"
  local verification_base="https://github.com/${REPO}/releases/download/${TAG}"
  local openssl_version=""
  local signature_hex=""
  local expected_digest=""
  local actual_digest=""

  if ! curl --fail -sSL \
      ${DL_AUTH_ARGS[@]+"${DL_AUTH_ARGS[@]}"} \
      "${verification_base}/SHA256SUMS" -o "$manifest_path" ||
     ! curl --fail -sSL \
      ${DL_AUTH_ARGS[@]+"${DL_AUTH_ARGS[@]}"} \
      "${verification_base}/SHA256SUMS.sig" -o "$signature_hex_path"; then
    log "Warning: release '${TAG}' has no signed SHA256SUMS manifest; continuing without bootstrap signature verification."
    return 0
  fi

  if command_exists openssl; then
    openssl_version="$(openssl version 2>/dev/null || true)"
  fi
  if ! printf '%s' "$openssl_version" | grep -Eq '^OpenSSL (1\.1\.1|[2-9][0-9]*\.)'; then
    log "Warning: OpenSSL 1.1.1+ with raw Ed25519 support is unavailable; continuing without bootstrap signature verification."
    return 0
  fi

  signature_hex="$(tr -d '[:space:]' < "$signature_hex_path")"
  if ! printf '%s' "$signature_hex" | grep -Eq '^[0-9a-fA-F]{128}$'; then
    die "Release manifest signature is malformed; refusing to install '${ASSET}'."
  fi

  : > "$signature_raw_path"
  local offset byte octal
  offset=0
  while [ "$offset" -lt 128 ]; do
    byte="${signature_hex:$offset:2}"
    octal="$(printf '%03o' "$((16#$byte))")"
    printf '%b' "\\${octal}" >> "$signature_raw_path"
    offset=$((offset + 2))
  done
  printf '%s\n' "$RELEASE_SIGNING_PUBLIC_KEY_PEM" > "$public_key_path"

  if ! openssl pkeyutl -verify -pubin -inkey "$public_key_path" -rawin \
      -in "$manifest_path" -sigfile "$signature_raw_path" >/dev/null 2>&1; then
    die "Release manifest signature verification failed; refusing to install '${ASSET}'."
  fi

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

  actual_digest="$(openssl dgst -sha256 -r "$ARCHIVE_PATH" | awk '{print $1}')"
  expected_digest="$(printf '%s' "$expected_digest" | tr '[:upper:]' '[:lower:]')"
  actual_digest="$(printf '%s' "$actual_digest" | tr '[:upper:]' '[:lower:]')"
  if [ "$actual_digest" != "$expected_digest" ]; then
    die "SHA-256 digest mismatch for '${ASSET}'; refusing to install it."
  fi
}

verify_release_archive

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

INSTALL_BASE="${INSTALL_BASE:-$HOME/.local/share/sailfin/versions}"
GLOBAL_BIN_DIR="${GLOBAL_BIN_DIR:-$HOME/.local/bin}"
TARGET_DIR="${INSTALL_BASE}/${VERSION}"

MAYBE_SUDO=""
if [ ! -d "${INSTALL_BASE}" ]; then
  mkdir -p "${INSTALL_BASE}" 2>/dev/null || true
fi
if [ ! -w "${INSTALL_BASE}" ]; then
  MAYBE_SUDO="sudo"
fi

log "Installing to ${TARGET_DIR}…"
$MAYBE_SUDO mkdir -p "${TARGET_DIR}"

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

if [ -d "${ROOT_DIR}/runtime" ]; then
  log "Installing runtime bundle to ${TARGET_DIR}/runtime…"
  $MAYBE_SUDO rm -rf "${TARGET_DIR}/runtime" 2>/dev/null || true
  $MAYBE_SUDO cp -R "${ROOT_DIR}/runtime" "${TARGET_DIR}/runtime"
else
  log "Warning: runtime bundle not found in archive; sfn run/build will fail without it."
fi

log "Ensuring global symlink in ${GLOBAL_BIN_DIR}…"
$MAYBE_SUDO mkdir -p "${GLOBAL_BIN_DIR}"
LINK_PATH="${GLOBAL_BIN_DIR}/${DEST_BASENAME}"
if [ -L "$LINK_PATH" ] || [ -f "$LINK_PATH" ]; then
  $MAYBE_SUDO rm -f "$LINK_PATH"
fi
if ! $MAYBE_SUDO ln -s "${LINK_TARGET}" "$LINK_PATH" 2>/dev/null; then
  log "Symlink failed; copying binary instead."
  $MAYBE_SUDO cp -f "${TARGET_DIR}/${DEST_BASENAME}" "$LINK_PATH"
  $MAYBE_SUDO chmod 0755 "$LINK_PATH" || true
fi

ALIAS_BASENAME="sfn"
if [ "$OS" = "windows" ] && [[ "$DEST_BASENAME" == *.exe ]]; then
  ALIAS_BASENAME="sfn.exe"
fi

ALIAS_PATH="${GLOBAL_BIN_DIR}/${ALIAS_BASENAME}"
if [ -L "$ALIAS_PATH" ] || [ -f "$ALIAS_PATH" ]; then
  $MAYBE_SUDO rm -f "$ALIAS_PATH"
fi
if ! $MAYBE_SUDO ln -s "${LINK_TARGET}" "$ALIAS_PATH" 2>/dev/null; then
  log "Symlink failed for ${ALIAS_BASENAME}; copying binary instead."
  $MAYBE_SUDO cp -f "${TARGET_DIR}/${DEST_BASENAME}" "$ALIAS_PATH"
  $MAYBE_SUDO chmod 0755 "$ALIAS_PATH" || true
fi
log "Linked: ${ALIAS_PATH} -> ${LINK_TARGET}"

SAILFIN_ALIAS_BASENAME="sailfin"
if [ "$OS" = "windows" ] && [[ "$DEST_BASENAME" == *.exe ]]; then
  SAILFIN_ALIAS_BASENAME="sailfin.exe"
fi

SAILFIN_ALIAS_PATH="${GLOBAL_BIN_DIR}/${SAILFIN_ALIAS_BASENAME}"
if [ -L "$SAILFIN_ALIAS_PATH" ] || [ -f "$SAILFIN_ALIAS_PATH" ]; then
  $MAYBE_SUDO rm -f "$SAILFIN_ALIAS_PATH"
fi
if ! $MAYBE_SUDO ln -s "${LINK_TARGET}" "$SAILFIN_ALIAS_PATH" 2>/dev/null; then
  log "Symlink failed for ${SAILFIN_ALIAS_BASENAME}; copying binary instead."
  $MAYBE_SUDO cp -f "${TARGET_DIR}/${DEST_BASENAME}" "$SAILFIN_ALIAS_PATH"
  $MAYBE_SUDO chmod 0755 "$SAILFIN_ALIAS_PATH" || true
fi
log "Linked: ${SAILFIN_ALIAS_PATH} -> ${LINK_TARGET}"

RESOLVED_SFN="$(command -v sfn 2>/dev/null || true)"
if [ -n "$RESOLVED_SFN" ] && [ "$RESOLVED_SFN" != "$ALIAS_PATH" ]; then
  log "Warning: 'sfn' resolves to ${RESOLVED_SFN} (not ${ALIAS_PATH})."
  log "If you previously installed Stage0, remove that binary or ensure ${GLOBAL_BIN_DIR} comes first in PATH."
fi

log "Installed: ${TARGET_DIR_ABS}/${DEST_BASENAME}"
log "Linked: ${LINK_PATH} -> ${LINK_TARGET}"

if [[ ":$PATH:" != *":${GLOBAL_BIN_DIR}:"* ]]; then
  echo
  echo "Add this to your shell profile to use '${BINARY}':"
  echo "  export PATH=\"${GLOBAL_BIN_DIR}:\$PATH\""
fi
