#!/usr/bin/env bash
set -euo pipefail

# curlable installer for Sailfin Stage2 native compiler binary.
#
# Usage:
#   curl -fsSL https://raw.githubusercontent.com/SailfinIO/sailfin/alpha/install.sh | bash
#
# Env overrides:
#   REPO=owner/repo          (default: SailfinIO/sailfin)
#   VERSION=latest|<ver>     (default: latest; accepts optional leading v)
#   BINARY=sailfin-stage2    (default: sailfin-stage2)
#   INSTALL_BASE=...         (default: ~/.local/share/sailfin-stage2/versions)
#   GLOBAL_BIN_DIR=...       (default: ~/.local/bin)
#   GITHUB_TOKEN=...         (required for private repos)
#
# Assets are expected to be named:
#   sailfin-stage2_<version>_<os>_<arch>.tar.gz
# where <os> is linux|macos and <arch> is x86_64|arm64.

REPO="${REPO:-SailfinIO/sailfin}"
BINARY="${BINARY:-sailfin-stage2}"
VERSION="${VERSION:-latest}"

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

# Token required for private repo access.
if [ -z "${GITHUB_TOKEN:-}" ]; then
  die "GITHUB_TOKEN is required (private repo). Export GITHUB_TOKEN with 'repo' scope."
fi

api() {
  # $1 = url
  curl --fail -sSL \
    -H "Authorization: token ${GITHUB_TOKEN}" \
    -H "Accept: application/vnd.github+json" \
    "$1"
}

# Resolve version/tag
TAG=""
if [ -z "$VERSION" ] || [ "$VERSION" = "latest" ]; then
  log "VERSION is 'latest'; resolving most recent release (including prereleases)…"
  releases_json="$(api "https://api.github.com/repos/${REPO}/releases?per_page=1")"
  TAG="$(printf '%s' "$releases_json" | jq -r '.[0].tag_name')"
  [ -n "$TAG" ] && [ "$TAG" != "null" ] || die "Could not determine latest release tag."
else
  VERSION="${VERSION#v}"
  VERSION="${VERSION#V}"
  TAG="v${VERSION}"
fi

# Normalize VERSION from tag
VERSION="${TAG#v}"
log "Using release tag: ${TAG}"
log "Using version: ${VERSION}"

ASSET="${BINARY}_${VERSION}_${OS}_${ARCH}.tar.gz"
log "Expected asset: ${ASSET}"

release_json="$(api "https://api.github.com/repos/${REPO}/releases/tags/${TAG}")"
asset_id="$(printf '%s' "$release_json" | jq -r '.assets[] | select(.name=="'"$ASSET"'") | .id' | head -n 1)"

if [ -z "$asset_id" ] || [ "$asset_id" = "null" ]; then
  die "Could not find asset '${ASSET}' in release '${TAG}'."
fi

TMPDIR="$(mktemp -d)"
cleanup() {
  rm -rf "$TMPDIR" 2>/dev/null || true
}
trap cleanup EXIT

ARCHIVE_PATH="${TMPDIR}/${ASSET}"
log "Downloading asset via GitHub API (id=${asset_id})…"

curl --fail -sSL \
  -H "Authorization: token ${GITHUB_TOKEN}" \
  -H "Accept: application/octet-stream" \
  "https://api.github.com/repos/${REPO}/releases/assets/${asset_id}" \
  -o "$ARCHIVE_PATH"

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

SRC_BINARY=""
if [ "$OS" = "windows" ]; then
  if [ -f "${EXTRACT_DIR}/${BINARY}.exe" ]; then
    SRC_BINARY="${EXTRACT_DIR}/${BINARY}.exe"
  elif [ -f "${EXTRACT_DIR}/bin/${BINARY}.exe" ]; then
    SRC_BINARY="${EXTRACT_DIR}/bin/${BINARY}.exe"
  elif [ -f "${EXTRACT_DIR}/${BINARY}" ]; then
    SRC_BINARY="${EXTRACT_DIR}/${BINARY}"
  elif [ -f "${EXTRACT_DIR}/bin/${BINARY}" ]; then
    SRC_BINARY="${EXTRACT_DIR}/bin/${BINARY}"
  else
    die "Binary '${BINARY}.exe' not found in archive."
  fi
else
  if [ -f "${EXTRACT_DIR}/${BINARY}" ]; then
    SRC_BINARY="${EXTRACT_DIR}/${BINARY}"
  elif [ -f "${EXTRACT_DIR}/bin/${BINARY}" ]; then
    SRC_BINARY="${EXTRACT_DIR}/bin/${BINARY}"
  else
    die "Binary '${BINARY}' not found in archive."
  fi
fi

INSTALL_BASE="${INSTALL_BASE:-$HOME/.local/share/${BINARY}/versions}"
if [ -z "${GLOBAL_BIN_DIR:-}" ]; then
  if [ "$OS" = "macos" ]; then
    GLOBAL_BIN_DIR="/usr/local/bin"
  else
    GLOBAL_BIN_DIR="$HOME/.local/bin"
  fi
else
  GLOBAL_BIN_DIR="${GLOBAL_BIN_DIR}"
fi
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

log "Ensuring global symlink in ${GLOBAL_BIN_DIR}…"
$MAYBE_SUDO mkdir -p "${GLOBAL_BIN_DIR}"
LINK_PATH="${GLOBAL_BIN_DIR}/${DEST_BASENAME}"
if [ -L "$LINK_PATH" ] || [ -f "$LINK_PATH" ]; then
  $MAYBE_SUDO rm -f "$LINK_PATH"
fi
if ! $MAYBE_SUDO ln -s "${TARGET_DIR}/${DEST_BASENAME}" "$LINK_PATH" 2>/dev/null; then
  log "Symlink failed; copying binary instead."
  $MAYBE_SUDO cp -f "${TARGET_DIR}/${DEST_BASENAME}" "$LINK_PATH"
  $MAYBE_SUDO chmod 0755 "$LINK_PATH" || true
fi

# Also install a stable `sfn` entrypoint when installing `sailfin-stage2`.
if [ "$BINARY" = "sailfin-stage2" ]; then
  ALIAS_BASENAME="sfn"
  if [ "$OS" = "windows" ] && [[ "$DEST_BASENAME" == *.exe ]]; then
    ALIAS_BASENAME="sfn.exe"
  fi

  ALIAS_PATH="${GLOBAL_BIN_DIR}/${ALIAS_BASENAME}"
  if [ -L "$ALIAS_PATH" ] || [ -f "$ALIAS_PATH" ]; then
    $MAYBE_SUDO rm -f "$ALIAS_PATH"
  fi
  if ! $MAYBE_SUDO ln -s "${TARGET_DIR}/${DEST_BASENAME}" "$ALIAS_PATH" 2>/dev/null; then
    log "Symlink failed for ${ALIAS_BASENAME}; copying binary instead."
    $MAYBE_SUDO cp -f "${TARGET_DIR}/${DEST_BASENAME}" "$ALIAS_PATH"
    $MAYBE_SUDO chmod 0755 "$ALIAS_PATH" || true
  fi
  log "Linked: ${ALIAS_PATH} -> ${TARGET_DIR}/${DEST_BASENAME}"

  RESOLVED_SFN="$(command -v sfn 2>/dev/null || true)"
  if [ -n "$RESOLVED_SFN" ] && [ "$RESOLVED_SFN" != "$ALIAS_PATH" ]; then
    log "Warning: 'sfn' resolves to ${RESOLVED_SFN} (not ${ALIAS_PATH})."
    log "If you previously installed Stage0, remove that binary or ensure ${GLOBAL_BIN_DIR} comes first in PATH."
  fi
fi

log "Installed: ${TARGET_DIR}/${DEST_BASENAME}"
log "Linked: ${LINK_PATH} -> ${TARGET_DIR}/${DEST_BASENAME}"

if [[ ":$PATH:" != *":${GLOBAL_BIN_DIR}:"* ]]; then
  echo
  echo "Add this to your shell profile to use '${BINARY}':"
  echo "  export PATH=\"${GLOBAL_BIN_DIR}:\$PATH\""
fi
