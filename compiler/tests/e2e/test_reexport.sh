#!/usr/bin/env bash
# End-to-end regression test for the re-export-of-imported-symbol bug.
#
# When a module re-exports a symbol it only imports (no local `fn`
# definition), the native emitter does not produce a `.fn` signature
# for that symbol in the re-exporter's `.sfn-asm`.  Consumers then
# either (a) cannot resolve the return type and fall back to `i8*` —
# dropping boolean `if` guards — or (b) emit a linker call to a
# `sym__middle_module` symbol that does not exist, producing an
# "undefined reference" at link time.
#
# See docs/rca/2026-04-18-reexport-diagnostic-gep.md for the full
# story.  Two outcomes count as "fixed":
#
#   BUG_FIXED_REFUSE   — Option B: the emitter refuses to compile the
#                        re-exporter and prints a clear diagnostic.
#                        We confirm by trying to emit middle.sfn alone
#                        (no inlining) and checking the error message.
#   BUG_FIXED_FORWARDER — Option A: the emitter synthesises a local
#                        forwarder so consumers can resolve the symbol.
#                        We confirm by building+running main.sfn and
#                        verifying every `-ok` line.
#
# Two outcomes count as "still broken":
#
#   EXPECTED_BUG_LINK   — linker can't find `sym__middle` (the most
#                         common manifestation under the original
#                         compiler).
#   EXPECTED_BUG_GUARDS — binary builds and runs but prints `FAIL`
#                         lines (dropped `if` guards from the i8*
#                         fallback).
#
# Anything else is UNEXPECTED and fails the test loud.
#
# Fixture:
#   fixtures/reexport/origin.sfn  — defines the helpers
#   fixtures/reexport/middle.sfn  — only imports and re-exports them
#   fixtures/reexport/main.sfn    — imports from middle, uses them
#
# Usage:
#   compiler/tests/e2e/test_reexport.sh <compiler-binary>

set -euo pipefail

BINARY="${1:?usage: test_reexport.sh <compiler-binary>}"
# Resolve BINARY to an absolute path NOW, before any `cd`.  Callers
# typically pass `build/native/sailfin`, which would become unresolvable
# once we chdir into the fixture directory below.
if [ -x "$BINARY" ]; then
    BINARY="$(cd "$(dirname "$BINARY")" && pwd)/$(basename "$BINARY")"
elif command -v "$BINARY" > /dev/null 2>&1; then
    BINARY="$(command -v "$BINARY")"
else
    echo "[test] FAIL: compiler binary not found: $BINARY" >&2
    exit 1
fi
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
FIXTURE="$SCRIPT_DIR/fixtures/reexport"

# Marker phrase the Option B emitter prints when it refuses an illegal
# implicit re-export.  Must match the diagnostic in
# emit_native.sfn:format_reexport_violation.
REEXPORT_REFUSE_MARKER="re-exports a symbol imported from"

# Try compiling middle.sfn alone via `sfn emit native`.  This goes
# straight through parse → typecheck → emit without the link step
# (middle.sfn has no `fn main`) and without the inline-imports text
# rewrite (only `sfn run` does that).  The parsed AST therefore
# carries the bare re-export shape and the Option B validator can
# fire.  Returns 0 (compile succeeded — Option B not active) or
# non-zero (compile rejected — likely the refusal we want).
try_compile_middle() {
    local out_dir="$1"
    local log="$2"
    local middle_asm="$out_dir/middle.sfn-asm"
    (cd "$out_dir" && "$BINARY" emit -o "$middle_asm" native "$FIXTURE/middle.sfn") \
        > "$log" 2>&1
}

# Classify the outcome of building + running main.sfn end-to-end.
# Returns:
#   0 → BUG_FIXED_FORWARDER   (Option A — every `-ok` line printed)
#   1 → EXPECTED_BUG_LINK     (linker can't find `__middle` symbol)
#   2 → EXPECTED_BUG_GUARDS   (binary built, but `FAIL` lines printed)
#   3 → UNEXPECTED            (anything else)
classify_full_build() {
    local out_dir="$1"
    local exe="$out_dir/reexport_main"
    local build_log="$out_dir/build.log"
    local output

    if (cd "$out_dir" && "$BINARY" build -o "$exe" "$FIXTURE/main.sfn") \
            > "$build_log" 2>&1; then
        if ! output="$("$exe" 2>&1)"; then
            echo "[outcome] UNEXPECTED: binary built but exited non-zero"
            echo "$output"
            return 3
        fi
        if echo "$output" | grep -q FAIL; then
            echo "[outcome] EXPECTED_BUG_GUARDS"
            echo "$output"
            return 2
        fi
        local expected all_ok=1
        for expected in \
            bool-yes-ok \
            bool-no-ok \
            let-truthy-ok \
            let-falsy-ok \
            string-strip-ok \
            string-unchanged-ok; do
            if ! echo "$output" | grep -qx "$expected"; then
                all_ok=0
                break
            fi
        done
        if [ "$all_ok" -eq 1 ]; then
            echo "[outcome] BUG_FIXED_FORWARDER (Option A)"
            return 0
        fi
        echo "[outcome] UNEXPECTED: built, ran, no FAIL lines, but some \`-ok\` lines missing"
        echo "$output"
        return 3
    fi

    # Build failed.  Classify based on stderr.  The "symbol not found
    # at link time" shape appears in two dialects:
    #   - GNU ld (Linux):    undefined reference to 'sym__middle'
    #   - Apple ld (macOS):  Undefined symbols for architecture arm64:
    #                          "_sym__...__middle"
    # Require both:
    #   (a) a linker "undefined" banner in either dialect, AND
    #   (b) `__middle` appearing somewhere in the log — the
    #       re-exporter's mangled suffix, unambiguous to this fixture.
    if grep -qE '(undefined reference)|(Undefined symbols for architecture)' "$build_log" \
            && grep -q '__middle' "$build_log"; then
        echo "[outcome] EXPECTED_BUG_LINK"
        tail -15 "$build_log"
        return 1
    fi

    echo "[outcome] UNEXPECTED: build failed with an error other than the known linker miss"
    tail -20 "$build_log"
    return 3
}

out_dir="$(mktemp -d)"
trap 'rm -rf "$out_dir"' EXIT

middle_log="$out_dir/middle-build.log"
out_rc=0

# Step 1: Direct test of Option B — compile middle.sfn alone.
# `sfn build` does NOT inline relative imports, so the parsed AST
# contains the bare re-export pattern that the validator must reject.
if try_compile_middle "$out_dir" "$middle_log"; then
    # middle.sfn compiled.  Option B not active.  Fall through to the
    # full build/run path to detect Option A or remaining bug shapes.
    echo "[outcome] middle.sfn compile succeeded — Option B not active"
    echo "[outcome] checking full build+run for Option A or stale bug"
    classify_full_build "$out_dir" || out_rc=$?
else
    if grep -q "$REEXPORT_REFUSE_MARKER" "$middle_log"; then
        echo "[outcome] BUG_FIXED_REFUSE (Option B)"
        grep "$REEXPORT_REFUSE_MARKER" "$middle_log" | head -2
        out_rc=0
    else
        echo "[outcome] UNEXPECTED: middle.sfn compile failed with an error other than the re-export diagnostic"
        tail -20 "$middle_log"
        out_rc=3
    fi
fi

case "$out_rc" in
    0)
        echo ""
        echo "[test] PASS: re-export bug FIXED — the compiler now handles"
        echo "[test]       \`export { X };\` of an imported symbol correctly."
        echo "[test]       See docs/rca/2026-04-18-reexport-diagnostic-gep.md."
        ;;
    1 | 2)
        echo ""
        echo "[test] FAIL (xfail flipped to hard fail): re-export bug reproduced."
        echo "[test]        The compiler-side fix landed in this branch but the"
        echo "[test]        regression came back.  See"
        echo "[test]        docs/rca/2026-04-18-reexport-diagnostic-gep.md."
        exit 1
        ;;
    *)
        echo ""
        echo "[test] FAIL: re-export fixture failed in an unexpected way."
        echo "[test]       Either the fixture broke or a new miscompile"
        echo "[test]       shape appeared.  Investigate before merging."
        exit 1
        ;;
esac
exit 0
