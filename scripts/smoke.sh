#!/usr/bin/env bash
# smoke.sh — Build the compiler and run basic smoke tests.
#
# Replaces scripts/selfhost_smoke_native.py.
#
# Usage:
#   scripts/smoke.sh [--seed PATH] [--out PATH] [--keep-work-dir]

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$REPO_ROOT"

SEED="${SEED:-sfn}"
OUT="${OUT:-build/native/sailfin}"
KEEP_WORK_DIR=0

while [[ $# -gt 0 ]]; do
    case "$1" in
        --seed)          SEED="$2"; shift 2 ;;
        --out)           OUT="$2"; shift 2 ;;
        --keep-work-dir) KEEP_WORK_DIR=1; shift ;;
        *)               echo "[smoke] unknown option: $1" >&2; exit 1 ;;
    esac
done

echo "[smoke] building compiler..."
SEED="$SEED" OUT="$OUT" bash scripts/build.sh --seed "$SEED" --out "$OUT"

echo "[smoke] verifying binary..."
if ! "$OUT" --version &>/dev/null; then
    echo "[smoke] FAIL: binary does not respond to --version" >&2
    exit 1
fi

echo "[smoke] running hello-world..."
OUTPUT=$("$OUT" run examples/basics/hello-world.sfn 2>&1) || true
if ! echo "$OUTPUT" | grep -q "Hello, Sailfin!"; then
    echo "[smoke] FAIL: expected 'Hello, Sailfin!' in output" >&2
    echo "[smoke] got: $OUTPUT" >&2
    exit 1
fi
echo "[smoke] hello-world OK"

echo "[smoke] testing emit native..."
if ! "$OUT" emit native compiler/src/version.sfn >/dev/null 2>&1; then
    echo "[smoke] FAIL: emit native failed" >&2
    exit 1
fi
echo "[smoke] emit native OK"

echo "[smoke] all smoke tests passed"
