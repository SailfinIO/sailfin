#!/usr/bin/env bash
set -euo pipefail

# curlable installer for the Sailfin compiler binary.
#
# Usage:
#   curl -fsSL https://raw.githubusercontent.com/SailfinIO/sailfin/alpha/install.sh | bash
#
# Env overrides:
#   REPO=owner/repo          (default: SailfinIO/sailfin)
#   VERSION=latest|<ver>     (default: latest; accepts optional leading v)
#   BINARY=sailfin           (default: sailfin)
#   INSTALL_BASE=...         (default: ~/.local/share/sailfin/versions)
#   GLOBAL_BIN_DIR=...       (default: ~/.local/bin)
#   GITHUB_TOKEN=...         (required for private repos)
#
# Assets are expected to be named:
#   sailfin_<version>_<os>_<arch>.tar.gz
# where <os> is linux|macos and <arch> is x86_64|arm64.

REPO="${REPO:-SailfinIO/sailfin}"
BINARY="${BINARY:-sailfin}"
VERSION="${VERSION:-latest}"
EXCLUDE_TAG="${EXCLUDE_TAG:-}"

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

release_json="$(api "https://api.github.com/repos/${REPO}/releases/tags/${TAG}")"
asset_id="$(printf '%s' "$release_json" | jq -r '.assets[]? | select(.name=="'"$ASSET"'") | .id' | head -n 1)"

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
