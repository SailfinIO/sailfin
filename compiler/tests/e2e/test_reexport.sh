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
# story.  This test is currently an **xfail marker** — it documents
# the expected failure shape and reports it clearly without blocking
# CI.  When the compiler-side fix lands (either emitter-side forwarder
# or compile-time refusal with diagnostic), the expected-failure path
# goes away and the test will flip to a real regression gate.
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

# Classify the build+run outcome into one of:
#   EXPECTED_BUG_LINK    — linker can't find `sym__middle` (most
#                          common manifestation under current compiler)
#   EXPECTED_BUG_GUARDS  — binary builds and runs but prints FAIL
#                          lines (dropped `if` guards)
#   BUG_FIXED            — binary prints all six `-ok` lines cleanly
#   UNEXPECTED           — something else went wrong
outcome() {
    local out_dir exe build_log output
    out_dir="$(mktemp -d)"
    exe="$out_dir/reexport_main"
    build_log="$out_dir/build.log"

    # Build from a tempdir so `build/sailfin/` scratch files don't
    # pollute the fixture directory.  `sfn build` resolves relative
    # imports from the source file's own location, so absolute paths
    # work from any cwd.
    local fixture="$SCRIPT_DIR/fixtures/reexport"
    if (cd "$out_dir" && "$BINARY" build -o "$exe" "$fixture/main.sfn") \
            > "$build_log" 2>&1; then
        # Build succeeded.  Run and look at output.
        if ! output="$("$exe" 2>&1)"; then
            echo "[outcome] UNEXPECTED: binary built but exited non-zero"
            echo "$output"
            rm -rf "$out_dir"
            return 2
        fi
        rm -rf "$out_dir"
        if echo "$output" | grep -q FAIL; then
            echo "[outcome] EXPECTED_BUG_GUARDS"
            echo "$output"
            return 1
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
            echo "[outcome] BUG_FIXED"
            return 0
        fi
        echo "[outcome] UNEXPECTED: built, ran, no FAIL lines, but some \`-ok\` lines missing"
        echo "$output"
        return 2
    fi

    # Build failed.  Classify based on stderr.
    if grep -qE 'undefined reference to .*__middle' "$build_log"; then
        echo "[outcome] EXPECTED_BUG_LINK"
        tail -10 "$build_log"
        rm -rf "$out_dir"
        return 1
    fi

    echo "[outcome] UNEXPECTED: build failed with an error other than the known linker miss"
    tail -20 "$build_log"
    rm -rf "$out_dir"
    return 2
}

out_rc=0
outcome || out_rc=$?

case "$out_rc" in
    0)
        echo ""
        echo "[test] PASS: reexport bug appears FIXED — this test should be"
        echo "[test]       promoted to a hard regression gate in CI."
        echo "[test]       See docs/rca/2026-04-18-reexport-diagnostic-gep.md."
        ;;
    1)
        echo ""
        echo "[test] PASS (xfail): reexport bug reproduced in the expected shape."
        echo "[test]                Compiler-side fix still pending; see RCA."
        ;;
    *)
        echo ""
        echo "[test] FAIL: reexport fixture failed in an unexpected way."
        echo "[test]       Either the fixture broke or a new miscompile"
        echo "[test]       shape appeared.  Investigate before merging."
        exit 1
        ;;
esac
exit 0
