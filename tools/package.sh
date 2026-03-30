#!/usr/bin/env bash
# package.sh — Package native compiler artifacts for distribution.
#
# Replaces tools/package_native.py.
#
# Produces:
#   dist/sailfin-<target>.tar.gz       — compiler + runtime tarball
#   dist/installer-<target>.tar.gz     — installer layout
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

echo "[package] packaging for target: $TARGET"
mkdir -p "$OUT_DIR"

# Create installer layout
INSTALLER_DIR="$OUT_DIR/installer-$TARGET"
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

# Create tarball
TARBALL="$OUT_DIR/installer-$TARGET.tar.gz"
tar -czf "$TARBALL" -C "$INSTALLER_DIR" .
echo "[package] created $TARBALL"

# Also create a standalone compiler tarball
COMPILER_TAR="$OUT_DIR/sailfin-$TARGET.tar.gz"
tar -czf "$COMPILER_TAR" -C "$(dirname "$COMPILER_BIN")" "$(basename "$COMPILER_BIN")"
echo "[package] created $COMPILER_TAR"

ls -lh "$TARBALL" "$COMPILER_TAR"
echo "[package] done"
