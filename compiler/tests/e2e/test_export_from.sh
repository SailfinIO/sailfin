#!/usr/bin/env bash
# End-to-end regression test for #508 — inline `export { X } from "./Y"`.
#
# When a barrel module re-exports a symbol via the inline form, the
# emitter writes a `.export "./Y" { X }` line into the barrel's
# `.sfn-asm` but no `.fn X` signature (because the barrel never
# defines X locally).  Before #508, `apply_module_symbol_mangling`
# only scanned `.import ` lines, so the barrel's LLVM IR contained
# no shim from `X__<barrel_slug>` to `X__<origin_slug>`.  Consumers
# that imported `X` through the barrel mangled their call sites with
# the BARREL slug, and the linker reported "undefined reference at
# link time".
#
# This test compiles and runs `main.sfn`, which goes through
#   main.sfn  → middle.sfn (inline re-export)  → origin.sfn (defines)
# and verifies every checkpoint prints `*-ok`, never `*-FAIL`.
#
# A linker error mentioning `__middle` is the canonical pre-#508
# manifestation; we report it explicitly so a regression is obvious.
#
# Distinct from `test_reexport.sh`, which covers the BARE
# `import; export { X };` shape (RCA 2026-04-18, Option B refusal).
#
# Usage:
#   compiler/tests/e2e/test_export_from.sh <compiler-binary>

set -euo pipefail

BINARY="${1:?usage: test_export_from.sh <compiler-binary>}"
if [ -x "$BINARY" ]; then
    BINARY="$(cd "$(dirname "$BINARY")" && pwd)/$(basename "$BINARY")"
elif command -v "$BINARY" > /dev/null 2>&1; then
    BINARY="$(command -v "$BINARY")"
else
    echo "[test] FAIL: compiler binary not found: $BINARY" >&2
    exit 1
fi
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
FIXTURE="$SCRIPT_DIR/fixtures/export_from"

out_dir="$(mktemp -d)"
trap 'rm -rf "$out_dir"' EXIT

exe="$out_dir/export_from_main"
build_log="$out_dir/build.log"

if ! (cd "$out_dir" && "$BINARY" build -o "$exe" "$FIXTURE/main.sfn") \
        > "$build_log" 2>&1; then
    if grep -qE '(undefined reference)|(Undefined symbols for architecture)' "$build_log" \
            && grep -q '__middle' "$build_log"; then
        echo "[test] FAIL: #508 reproduced — barrel re-export shim missing."
        echo '[test]       Linker cannot resolve a `__middle`-suffixed symbol.'
        tail -15 "$build_log" >&2
    else
        echo "[test] FAIL: build failed in an unexpected way."
        tail -20 "$build_log" >&2
    fi
    exit 1
fi

if ! output="$("$exe" 2>&1)"; then
    echo "[test] FAIL: built binary exited non-zero."
    echo "$output" >&2
    exit 1
fi

if echo "$output" | grep -q FAIL; then
    echo "[test] FAIL: dropped guard / corrupted return value (i8* fallback?)."
    echo "$output" >&2
    exit 1
fi

for expected in \
    bool-yes-ok \
    bool-no-ok \
    let-truthy-ok \
    let-falsy-ok \
    string-strip-ok \
    string-unchanged-ok; do
    if ! echo "$output" | grep -qx "$expected"; then
        echo "[test] FAIL: expected line '$expected' missing from output."
        echo "$output" >&2
        exit 1
    fi
done

echo "[test] PASS: inline 'export { X } from' re-exports link and run correctly."
exit 0
