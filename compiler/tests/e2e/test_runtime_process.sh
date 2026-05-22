#!/usr/bin/env bash
# End-to-end test for runtime/sfn/process.sfn — the Sailfin-native
# replacement for `sailfin_runtime_process_run_v2` shipped under
# M2.9 (issue #405, epic #389).
#
# The migration's contract per the issue's acceptance criteria:
#
#   1. typecheck — `sfn check runtime/sfn/process.sfn` reports `ok`.
#   2. fmt       — `sfn fmt --check runtime/sfn/process.sfn` is canonical.
#   3. emit shape — the module emits
#                   `define double @sfn_process_run({ i8**, i64, i64 }* %argv)`
#                   alongside `declare`s for `@posix_spawnp` + `@waitpid`,
#                   matching the legacy C trampoline's call signature
#                   (`double(SfnArray*)`) exactly so the descriptor's
#                   `c_abi_return_type: "double"` redirect lands on a
#                   compatible ABI.
#   4. user-emission flip — emission of a small Sailfin program that
#                   calls `process.run([...])` references
#                   `@sfn_process_run` (not the legacy
#                   `@sailfin_runtime_process_run` / `_v2` symbols).
#                   Mirrors the issue's "is unreferenced in user
#                   emission" criterion.
#
# The integration spawn of `echo hello` (acceptance criterion 1)
# requires the full `make compile` self-host followed by linking the
# runtime, so it lives in `make test` rather than this skeleton
# test (which runs from the seed binary). The skeleton pins the
# shape contract; the full-build path is covered by
# `compiler/tests/integration/process_run_test.sfn`.

set -euo pipefail

BINARY="${1:?usage: test_runtime_process.sh <compiler-binary>}"
BINARY="$(realpath "$BINARY")"
PASS=0
FAIL=0

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
SKELETON="$REPO_ROOT/runtime/sfn/process.sfn"

SCRATCH="$(mktemp -d -t sfn-runtime-process-XXXXXX)"
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

test_check_clean() {
    local log="$SCRATCH/check.log"
    if ! "$BINARY" check "$SKELETON" > "$log" 2>&1; then
        echo "[test]   sfn check exited non-zero on process.sfn:"
        cat "$log"
        return 1
    fi
    if ! grep -q "checked .* ok" "$log"; then
        echo "[test]   sfn check did not report 'ok':"
        cat "$log"
        return 1
    fi
    return 0
}

test_fmt_clean() {
    if ! "$BINARY" fmt --check "$SKELETON" > /dev/null 2>&1; then
        echo "[test]   $SKELETON needs formatting (run: sfn fmt --write $SKELETON)"
        return 1
    fi
    return 0
}

test_emit_define_shape() {
    local ll="$SCRATCH/process.ll"
    local log="$SCRATCH/emit.log"
    if ! "$BINARY" emit -o "$ll" llvm "$SKELETON" > "$log" 2>&1; then
        echo "[test]   sfn emit llvm failed on runtime/sfn/process.sfn:"
        cat "$log"
        return 1
    fi

    local missing=0
    # The Sailfin function must emit at the bare unmangled name so
    # the runtime helper descriptor's `native_signature` redirect
    # lands at link time. `{ i8**, i64, i64 }*` is the SfnArray
    # ABI shape pinned by `runtime_helpers.sfn`.
    if ! grep -qE '^define double @sfn_process_run\(\{ i8\*\*, i64, i64 \}\* %argv\) \{' "$ll"; then
        echo "[test]   missing 'define double @sfn_process_run({ i8**, i64, i64 }* %argv)'"
        echo "[test]   --- actual sfn_process_run define ---"
        grep -nE '^define .* @sfn_process_run' "$ll" || echo "[test]   (no @sfn_process_run define)"
        missing=$((missing + 1))
    fi
    # The body must call posix_spawnp + waitpid directly (the whole
    # point of the M2.9 migration). The grep is anchored to a `call`
    # so the inlined extern's `declare` does not satisfy it on its own.
    if ! grep -qE '^[[:space:]]+%[^ ]+ = call i32 @posix_spawnp\(' "$ll"; then
        echo "[test]   missing 'call i32 @posix_spawnp(...)' in sfn_process_run body"
        grep -nE 'posix_spawnp' "$ll" || echo "[test]   (no posix_spawnp references at all)"
        missing=$((missing + 1))
    fi
    if ! grep -qE '^[[:space:]]+%[^ ]+ = call i32 @waitpid\(' "$ll"; then
        echo "[test]   missing 'call i32 @waitpid(...)' in sfn_process_run body"
        grep -nE 'waitpid' "$ll" || echo "[test]   (no waitpid references at all)"
        missing=$((missing + 1))
    fi
    return "$missing"
}

test_emit_declare_shape() {
    local ll="$SCRATCH/process.ll"
    if [ ! -f "$ll" ]; then
        echo "[test]   $ll missing — test_emit_define_shape must run first to produce it"
        return 1
    fi
    # Inlined extern declarations from the file header. Each must
    # produce a `declare` line at module scope so the body's calls
    # link against the libc symbols.
    local missing=0
    if ! grep -qE '^declare i32 @posix_spawnp\(' "$ll"; then
        echo "[test]   missing 'declare i32 @posix_spawnp(...)'"
        missing=$((missing + 1))
    fi
    if ! grep -qE '^declare i32 @waitpid\(' "$ll"; then
        echo "[test]   missing 'declare i32 @waitpid(...)'"
        missing=$((missing + 1))
    fi
    if ! grep -qE '^declare i8\* @malloc\(' "$ll"; then
        echo "[test]   missing 'declare i8* @malloc(...)'"
        missing=$((missing + 1))
    fi
    if ! grep -qE '^declare void @free\(' "$ll"; then
        echo "[test]   missing 'declare void @free(...)'"
        missing=$((missing + 1))
    fi
    return "$missing"
}

test_user_emission_flip() {
    # Acceptance criterion (issue #405): user emission must NOT
    # reference the legacy C trampoline `sailfin_runtime_process_run`
    # (with or without the `_v2` suffix). The hello-world program
    # doesn't exercise process.run, so we build a tiny driver that
    # actually calls it.
    local driver="$SCRATCH/driver.sfn"
    cat > "$driver" <<'SAILFIN'
fn main() -> int ![io] {
    let rc = process.run(["echo", "hello"]);
    return rc;
}
SAILFIN
    local ll="$SCRATCH/driver.ll"
    local log="$SCRATCH/driver-emit.log"
    if ! "$BINARY" emit -o "$ll" llvm "$driver" > "$log" 2>&1; then
        echo "[test]   sfn emit llvm failed on $driver:"
        cat "$log"
        return 1
    fi
    # The call site must land on @sfn_process_run, not the legacy
    # C trampoline.
    if ! grep -qE 'call double @sfn_process_run\(' "$ll"; then
        echo "[test]   user emission did not produce 'call double @sfn_process_run(...)':"
        grep -nE 'process_run' "$ll" || echo "[test]   (no process_run references at all)"
        return 1
    fi
    # The legacy symbol may still appear as a vestigial `declare`
    # (the seed default helpers list emits it preventively) but
    # must NOT appear as a `call` instruction — that's the
    # "unreferenced in user emission" contract.
    if grep -qE '^[[:space:]]+%[^ ]+ = call [^@]*@sailfin_runtime_process_run\b' "$ll"; then
        echo "[test]   user emission still calls legacy @sailfin_runtime_process_run:"
        grep -nE 'call [^@]*@sailfin_runtime_process_run' "$ll" | head -5
        return 1
    fi
    if grep -qE '^[[:space:]]+%[^ ]+ = call [^@]*@sailfin_runtime_process_run_v2\b' "$ll"; then
        echo "[test]   user emission still calls legacy @sailfin_runtime_process_run_v2:"
        grep -nE 'call [^@]*@sailfin_runtime_process_run_v2' "$ll" | head -5
        return 1
    fi
    return 0
}

run_test "sfn check runtime/sfn/process.sfn passes" test_check_clean
run_test "sfn fmt --check runtime/sfn/process.sfn is canonical" test_fmt_clean
run_test "sfn emit llvm produces sfn_process_run define + posix_spawnp/waitpid calls" test_emit_define_shape
run_test "sfn emit llvm declares the inlined libc + posix externs" test_emit_declare_shape
run_test "user emission flips process.run calls to @sfn_process_run" test_user_emission_flip

echo "[summary] $PASS passed, $FAIL failed"
if [ "$FAIL" -gt 0 ]; then
    exit 1
fi
