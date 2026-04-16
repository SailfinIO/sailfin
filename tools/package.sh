#!/usr/bin/env bash
# package.sh — Package native compiler artifacts for distribution.
#
# Replaces tools/package_native.py.
#
# Produces:
#   dist/sailfin-native-<target>-<version>.tar.gz          — standalone compiler tarball
#   dist/sailfin-native-<target>-<version>.tar.gz.sha256   — sha256 sidecar
#   dist/sailfin-native-<target>-<version>.manifest.json   — build metadata
#   dist/installer-<target>.tar.gz                         — installer layout (compiler + runtime)
#
# Usage:
#   tools/package.sh [--target TARGET] [--out DIR] [--compiler-bin PATH] [--skip-build]

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$REPO_ROOT"

# Detect platform
case "$(uname -s)-$(uname -m)" in
    Linux-x86_64)   DEFAULT_TARGET="linux-x86_64" ;;
    Linux-aarch64)  DEFAULT_TARGET="linux-arm64" ;;
    Darwin-arm64)   DEFAULT_TARGET="macos-arm64" ;;
    Darwin-x86_64)  DEFAULT_TARGET="macos-x86_64" ;;
    *)              DEFAULT_TARGET="unknown-$(uname -s)-$(uname -m)" ;;
esac

TARGET="${TARGET:-$DEFAULT_TARGET}"
OUT_DIR="${OUT_DIR:-dist}"
COMPILER_BIN="${COMPILER_BIN:-build/native/sailfin}"
SKIP_BUILD=0

while [[ $# -gt 0 ]]; do
    case "$1" in
        --target)       TARGET="$2"; shift 2 ;;
        --out)          OUT_DIR="$2"; shift 2 ;;
        --compiler-bin) COMPILER_BIN="$2"; shift 2 ;;
        --skip-build)   SKIP_BUILD=1; shift ;;
        *)              echo "[package] unknown option: $1" >&2; exit 1 ;;
    esac
done

if [[ "$SKIP_BUILD" -eq 0 ]]; then
    echo "[package] building compiler..."
    make compile
fi

if [[ ! -x "$COMPILER_BIN" ]]; then
    echo "[package] error: missing compiler binary: $COMPILER_BIN" >&2
    exit 1
fi

# Extract version from capsule.toml (canonical source of truth)
VERSION="$(sed -n 's/^version *= *"\([^"]*\)"/\1/p' compiler/capsule.toml)"
if [[ -z "$VERSION" ]]; then
    echo "[package] error: could not extract version from compiler/capsule.toml" >&2
    exit 1
fi

echo "[package] version: $VERSION  target: $TARGET"
mkdir -p "$OUT_DIR"

# ---------------------------------------------------------------------------
# 1. Standalone compiler tarball
# ---------------------------------------------------------------------------
NATIVE_STEM="sailfin-native-${TARGET}-${VERSION}"
NATIVE_STAGING="$(mktemp -d)"
NATIVE_ROOT="${NATIVE_STAGING}/sailfin-native-${TARGET}"
mkdir -p "${NATIVE_ROOT}/bin"
cp -f "$COMPILER_BIN" "${NATIVE_ROOT}/bin/sailfin"
cp -f "$COMPILER_BIN" "${NATIVE_ROOT}/bin/sfn"

NATIVE_TAR="${OUT_DIR}/${NATIVE_STEM}.tar.gz"
tar -czf "$NATIVE_TAR" -C "$NATIVE_STAGING" "sailfin-native-${TARGET}"
rm -rf "$NATIVE_STAGING"
echo "[package] created $NATIVE_TAR"

# sha256 sidecar
if command -v sha256sum &>/dev/null; then
    sha256sum "$NATIVE_TAR" | awk '{print $1}' > "${NATIVE_TAR}.sha256"
else
    shasum -a 256 "$NATIVE_TAR" | awk '{print $1}' > "${NATIVE_TAR}.sha256"
fi
echo "[package] created ${NATIVE_TAR}.sha256"

# manifest.json
MANIFEST="${OUT_DIR}/${NATIVE_STEM}.manifest.json"
HASH="$(cat "${NATIVE_TAR}.sha256")"
BINARY_SIZE="$(wc -c < "$COMPILER_BIN" | tr -d ' ')"
TARBALL_SIZE="$(wc -c < "$NATIVE_TAR" | tr -d ' ')"
cat > "$MANIFEST" <<MANIFEST_EOF
{
  "name": "sailfin-native",
  "version": "$VERSION",
  "target": "$TARGET",
  "sha256": "$HASH",
  "binary_size": $BINARY_SIZE,
  "tarball_size": $TARBALL_SIZE,
  "build_date": "$(date -u +%Y-%m-%dT%H:%M:%SZ)"
}
MANIFEST_EOF
echo "[package] created $MANIFEST"

# ---------------------------------------------------------------------------
# 2. Installer layout (compiler + runtime)
# ---------------------------------------------------------------------------
INSTALLER_DIR="${OUT_DIR}/installer-${TARGET}"
rm -rf "$INSTALLER_DIR"
mkdir -p "$INSTALLER_DIR/bin"
cp -f "$COMPILER_BIN" "$INSTALLER_DIR/bin/sailfin"
cp -f "$COMPILER_BIN" "$INSTALLER_DIR/bin/sfn"

# Include runtime
mkdir -p "$INSTALLER_DIR/runtime"
cp -R runtime/native "$INSTALLER_DIR/runtime/native"

# Include prelude object if available
PRELUDE_O="build/selfhost/native/obj/runtime/prelude.o"
if [[ ! -f "$PRELUDE_O" ]]; then
    PRELUDE_O="build/native/obj/runtime/prelude.o"
fi
if [[ -f "$PRELUDE_O" ]]; then
    mkdir -p "$INSTALLER_DIR/runtime/native/obj"
    cp -f "$PRELUDE_O" "$INSTALLER_DIR/runtime/native/obj/prelude.o"
fi

# Include import-context if available
if [[ -d "build/native/import-context" ]]; then
    cp -R "build/native/import-context" "$INSTALLER_DIR/"
fi

INSTALLER_TAR="${OUT_DIR}/installer-${TARGET}.tar.gz"
tar -czf "$INSTALLER_TAR" -C "$INSTALLER_DIR" .
rm -rf "$INSTALLER_DIR"
echo "[package] created $INSTALLER_TAR"

# ---------------------------------------------------------------------------
# Summary
# ---------------------------------------------------------------------------
ls -lh "$NATIVE_TAR" "${NATIVE_TAR}.sha256" "$MANIFEST" "$INSTALLER_TAR"
echo "[package] done"
