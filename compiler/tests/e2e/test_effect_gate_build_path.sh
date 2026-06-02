#!/usr/bin/env bash
# End-to-end test for #957: cross-module effect transitivity (E0402)
# must be enforced on the BUILD PATH (`sailfin emit ... llvm`), not just
# under `sailfin check`.
#
# Before #957, `compile_to_llvm_file_with_module` ran the effect gate
# with an empty import table, so a module function that calls an
# imported `![io]` helper without declaring `![io]` compiled clean
# during `make compile` / `make check`. #957 adds an `--import-context`
# flag: the emit subprocess loads the staged `.sfn-asm` effect table
# from `<root>/<module-name>.import-deps` and enforces the same E0402
# the resolver-driven `sailfin check` already catches.
#
# This drives the emit subprocess directly with a hand-staged
# import-context, mirroring what `_cr_compile_one` /
# `_cr_run_parallel_emit` do during the self-host build. The
# import-context is staged at the default cwd-relative layout
# (`build/native/import-context/<slug>.sfn-asm`) so the LLVM lowering's
# own signature resolution (`collect_imported_module_context_for_module`,
# entrypoints.sfn) can resolve the imported callee's return type — the
# effect gate is the only consumer #957 newly wires.
#
# Fixtures (under a throwaway cwd):
#   dep.sfn      — exports `do_io() ![io]`.
#   caller_bad   — `import { do_io }; fn run() { do_io(); }` (under-declared).
#   caller_good  — same, but `fn run() ![io]` (correctly declared).
#
# Assertions:
#   - emit llvm caller_bad WITH    --import-context  → fails with E0402.
#   - emit llvm caller_bad WITHOUT --import-context  → succeeds (proves
#     the flag is what enables cross-module enforcement; the empty-table
#     legacy path stays in-module-only).
#   - emit llvm caller_good WITH    --import-context → succeeds.
#
# Usage:
#   compiler/tests/e2e/test_effect_gate_build_path.sh <compiler-binary>

set -euo pipefail

BINARY="${1:?usage: test_effect_gate_build_path.sh <compiler-binary>}"
BINARY="$(realpath "$BINARY")"
PASS=0
FAIL=0

SCRATCH="$(mktemp -d -t sfn-effect-build-path-XXXXXX)"
trap 'rm -rf "$SCRATCH"' EXIT

# The lowering resolves imported callee signatures from the default
# cwd-relative import-context root, so run everything from $SCRATCH and
# stage there.
cd "$SCRATCH"
CTX="build/native/import-context"
mkdir -p "$CTX"

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

# ---- Setup: dependency that genuinely performs IO ----
cat > "$SCRATCH/dep.sfn" <<'EOF'
fn do_io() ![io] {
    print.info("side effect");
}

export { do_io };
EOF

# Under-declared caller: calls the imported ![io] helper without
# declaring ![io] itself.
cat > "$SCRATCH/caller_bad.sfn" <<'EOF'
import { do_io } from "./dep";

fn run() {
    do_io();
}

export { run };
EOF

# Correctly-declared caller: propagates ![io].
cat > "$SCRATCH/caller_good.sfn" <<'EOF'
import { do_io } from "./dep";

fn run() ![io] {
    do_io();
}

export { run };
EOF

# Stage the dependency's `.sfn-asm` (its top-level function-effect
# surface) into the import-context, exactly as `stage_capsule_imports`
# does during the build.
stage_dep() {
    "$BINARY" emit --module-name dep -o "$CTX/dep.sfn-asm" native "$SCRATCH/dep.sfn" \
        > stage.stdout 2> stage.stderr
    test -s "$CTX/dep.sfn-asm"
}
run_test "stage dep.sfn-asm into import-context" stage_dep

# Write the per-module `.import-deps` sidecar the emit subprocess reads
# for `--module-name caller` (what `_cr_stage_import_deps` writes).
printf '%s\n' "$CTX/dep.sfn-asm" > "$CTX/caller.import-deps"

# ---- Test: under-declared caller fails WITH --import-context ----
test_bad_with_context_fails() {
    local rc=0
    if "$BINARY" emit --module-name caller --import-context "$CTX" \
        -o bad.ll llvm "$SCRATCH/caller_bad.sfn" \
        > bad.stdout 2> bad.stderr; then
        rc=0
    else
        rc=$?
    fi
    if [ "$rc" -eq 0 ]; then
        echo "[test]   expected non-zero exit (E0402), got 0" >&2
        cat bad.stderr >&2
        return 1
    fi
    if ! grep -q "E0402" bad.stderr; then
        echo "[test]   expected E0402 in stderr; full stderr:" >&2
        cat bad.stderr >&2
        return 1
    fi
    return 0
}
run_test "build path rejects under-declared ![io] (E0402) with --import-context" test_bad_with_context_fails

# ---- Negative control: WITHOUT --import-context, the same input
#      compiles clean (empty-table legacy path = in-module only). This
#      proves the flag is what activates cross-module enforcement. ----
test_bad_without_context_passes() {
    local rc=0
    if "$BINARY" emit --module-name caller \
        -o bad_nocxt.ll llvm "$SCRATCH/caller_bad.sfn" \
        > bad_nocxt.stdout 2> bad_nocxt.stderr; then
        rc=0
    else
        rc=$?
    fi
    if [ "$rc" -ne 0 ]; then
        echo "[test]   expected exit 0 without --import-context, got $rc" >&2
        cat bad_nocxt.stderr >&2
        return 1
    fi
    if grep -q "E0402" bad_nocxt.stderr; then
        echo "[test]   unexpected E0402 without --import-context; stderr:" >&2
        cat bad_nocxt.stderr >&2
        return 1
    fi
    return 0
}
run_test "build path stays in-module-only without --import-context (control)" test_bad_without_context_passes

# ---- Positive control: correctly-declared caller compiles clean. ----
test_good_with_context_passes() {
    local rc=0
    if "$BINARY" emit --module-name caller --import-context "$CTX" \
        -o good.ll llvm "$SCRATCH/caller_good.sfn" \
        > good.stdout 2> good.stderr; then
        rc=0
    else
        rc=$?
    fi
    if [ "$rc" -ne 0 ]; then
        echo "[test]   expected exit 0 for correctly-declared caller, got $rc" >&2
        cat good.stderr >&2
        return 1
    fi
    return 0
}
run_test "build path accepts correctly-declared ![io] with --import-context" test_good_with_context_passes

# ---- Summary ----
echo ""
echo "[test] $PASS passed, $FAIL failed"
[ "$FAIL" -eq 0 ]
