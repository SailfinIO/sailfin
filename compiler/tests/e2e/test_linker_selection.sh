#!/usr/bin/env bash
# Faster-linker selection guard (#343, PR #1128).
#
# Pins the opportunistic linker selection added in #343: the final clang
# link in `_clang_link_multi_with_opt` (cli_main.sfn) calls
# `_resolve_linker()` (cli_commands_utils.sfn), which probes PATH for a
# faster linker (mold, then lld) and passes `-fuse-ld=<linker>` to clang,
# honouring the `SAILFIN_LINKER` override and falling back to the system
# default otherwise.
#
# The guard asserts the observable CLI contract:
#   - the chosen linker is surfaced on a `[link] linker: …` line,
#   - that line goes to STDERR, never stdout (so it cannot corrupt a
#     program's stdout under `sfn run` / a downstream pipe — the #915
#     `[cache]` invariant, and the bug that broke test_closure_capture.sh
#     on the first cut of this feature),
#   - `SAILFIN_LINKER=ld` forces the system default (no `-fuse-ld`),
#   - `SAILFIN_LINKER=lld` selects lld via the override path,
#   - the produced binary actually runs in every case.
#
# Usage:
#   compiler/tests/e2e/test_linker_selection.sh <compiler-binary>

set -euo pipefail

BINARY="${1:?usage: test_linker_selection.sh <compiler-binary>}"
BINARY="$(realpath "$BINARY")"
PASS=0
FAIL=0

SCRATCH="$(mktemp -d -t sfn-linker-selection-XXXXXX)"
trap 'rm -rf "$SCRATCH"' EXIT

run_test() {
    local name="$1"
    shift
    if "$@"; then
        echo "[test] PASS: $name"
        PASS=$((PASS + 1))
    else
        echo "[test] FAIL: $name"
        FAIL=$((FAIL + 1))
    fi
}

# ---- Setup: a trivial program with a known, exact stdout ----
cat > "$SCRATCH/main.sfn" <<'EOF'
fn main() ![io] {
    print("LINKER_OK");
}
EOF

# Build with the given SAILFIN_LINKER value (empty = auto-detect),
# capturing stdout and stderr to SEPARATE files so the stdout-purity
# assertion is meaningful. Sets globals OUT/ERR/BIN/RC.
build_with_linker() {
    local linker_val="$1"
    local tag="$2"
    OUT="$SCRATCH/$tag.out"
    ERR="$SCRATCH/$tag.err"
    BIN="$SCRATCH/$tag.bin"
    RC=0
    if [ -n "$linker_val" ]; then
        SAILFIN_LINKER="$linker_val" "$BINARY" build -o "$BIN" "$SCRATCH/main.sfn" \
            > "$OUT" 2> "$ERR" || RC=$?
    else
        "$BINARY" build -o "$BIN" "$SCRATCH/main.sfn" \
            > "$OUT" 2> "$ERR" || RC=$?
    fi
    if [ "$RC" -ne 0 ]; then
        echo "[test]   sfn build ($tag) exited $RC; stderr tail:" >&2
        tail -20 "$ERR" >&2
    fi
    return "$RC"
}

# ---- Test 1: auto-detect emits a [link] line on stderr, runs OK ----
test_autodetect() {
    build_with_linker "" "auto" || return 1
    [ -x "$BIN" ] || { echo "[test]   no binary produced" >&2; return 1; }
    # The selection line must be present on stderr...
    if ! grep -q "^\[link\] linker:" "$ERR"; then
        echo "[test]   no '[link] linker:' line on stderr" >&2
        return 1
    fi
    # ...and must NOT leak onto stdout (the #915 / closure-capture bug).
    if grep -q "\[link\] linker:" "$OUT"; then
        echo "[test]   '[link] linker:' leaked onto stdout (must be stderr)" >&2
        cat "$OUT" >&2
        return 1
    fi
    "$BIN" > "$SCRATCH/auto.run.out" 2>&1 || return 1
    grep -qx "LINKER_OK" "$SCRATCH/auto.run.out"
}
run_test "auto-detect surfaces [link] on stderr (not stdout) and runs" test_autodetect

# ---- Test 2: SAILFIN_LINKER=ld forces the system default ----
test_override_system() {
    build_with_linker "ld" "ld" || return 1
    [ -x "$BIN" ] || return 1
    if ! grep -q "^\[link\] linker: system default (SAILFIN_LINKER=ld)" "$ERR"; then
        echo "[test]   expected system-default line for SAILFIN_LINKER=ld; stderr:" >&2
        grep "\[link\]" "$ERR" >&2 || true
        return 1
    fi
    "$BIN" > "$SCRATCH/ld.run.out" 2>&1 || return 1
    grep -qx "LINKER_OK" "$SCRATCH/ld.run.out"
}
run_test "SAILFIN_LINKER=ld forces system default and runs" test_override_system

# ---- Test 3: SAILFIN_LINKER=lld selects lld via the override path ----
# Skipped when lld is unavailable (the override would hand clang a linker
# it cannot find); the override-parsing path is still exercised by Test 2.
test_override_lld() {
    if ! command -v ld.lld >/dev/null 2>&1 && ! command -v lld >/dev/null 2>&1; then
        echo "[test]   SKIP: lld not installed" >&2
        return 0
    fi
    build_with_linker "lld" "lld" || return 1
    [ -x "$BIN" ] || return 1
    if ! grep -q "^\[link\] linker: lld (SAILFIN_LINKER override)" "$ERR"; then
        echo "[test]   expected lld override line; stderr:" >&2
        grep "\[link\]" "$ERR" >&2 || true
        return 1
    fi
    "$BIN" > "$SCRATCH/lld.run.out" 2>&1 || return 1
    grep -qx "LINKER_OK" "$SCRATCH/lld.run.out"
}
run_test "SAILFIN_LINKER=lld selects lld via override and runs" test_override_lld

# ---- Summary ----
echo ""
echo "[test] $PASS passed, $FAIL failed"
[ "$FAIL" -eq 0 ]
