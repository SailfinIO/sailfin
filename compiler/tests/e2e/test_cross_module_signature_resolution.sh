#!/usr/bin/env bash
# Regression for #999: a `-p` sibling that imports a VALUE-RETURNING fn
# from the walk-excluded entry must resolve the callee's return-type
# signature during its own per-module lowering, emit cleanly, link, and
# run.
#
# Root cause (pre-#999): `compile_to_llvm_file_with_module_imports`
# (main.sfn) loaded the entry's staged `.sfn-asm` only to feed the E0402
# effect gate (`loaded.function_effects`), then discarded
# `loaded.native_texts` and lowered through the context-free
# `write_llvm_ir_from_native_text`. The sibling's per-module emit
# re-derived import context from its own embedded `import` directives
# only — never seeing the walk-excluded entry's body — so a call to the
# entry's exported fn could not resolve its return type and hit the
# `cannot resolve return type for call` `[fatal]`
# (core_call_emission.sfn:362), surfaced via `has_fatal_lowering_diagnostic`.
#
# #999 threads `loaded.native_texts` into a context-carrying lowering
# writer (`write_llvm_ir_from_native_text_with_context`) that UNIONS the
# staged bodies with the embedded-import context, mirroring the proven
# tests path. The `[fatal]` gate is untouched — the fix supplies the
# missing input, it does not weaken the gate (#306).
#
# This drives the real resolver via `sfn build -p .` on a synthetic
# binary capsule. Unlike `test_effect_gate_build_path_entry.sh` (orphan
# sibling), `main()` here CALLS the sibling, so the sibling is linked and
# the produced binary is run — a clean emit must also produce correct
# runtime output.
#
# Usage:
#   compiler/tests/e2e/test_cross_module_signature_resolution.sh <compiler-binary>

set -euo pipefail

BINARY="${1:?usage: test_cross_module_signature_resolution.sh <compiler-binary>}"
BINARY="$(realpath "$BINARY")"
PASS=0
FAIL=0

SCRATCH="$(mktemp -d -t sfn-xmod-sig-XXXXXX)"
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

mkdir -p "$SCRATCH/src/util"

cat > "$SCRATCH/capsule.toml" <<'EOF'
[capsule]
name = "xmod-sig-test"
version = "0.1.0"
description = "E2E regression for #999 cross-module signature resolution on -p"

[capabilities]
required = ["io"]

[build]
kind = "binary"
entry = "src/main.sfn"
EOF

# Sibling: imports the value-returning `answer` from the entry and
# returns a value derived from it. Correctly annotated (no effects).
cat > "$SCRATCH/src/util/sib.sfn" <<'EOF'
import { answer } from "../main";

fn compute() -> number {
    return answer() + 1;
}

export { compute };
EOF

# Entry module: exports a VALUE-RETURNING fn (`answer`) and imports
# `compute` from the sibling so the linked binary is runnable. The `-p`
# walker excludes this file from `resolved.sources`; #984 stages it for
# slug resolution and #999 threads its body into sibling lowering so the
# return type of `answer()` resolves at the sibling's call site.
cat > "$SCRATCH/src/main.sfn" <<'EOF'
import { compute } from "./util/sib";

fn answer() -> number {
    return 42;
}

fn main() ![io] {
    let v = compute();
    print.info("xmod-result=" + number_to_string(v));
}

export { answer };
EOF

# ---- Test 1: build emits cleanly (no unresolved-callee fatal) ----
# Grep for the SPECIFIC imported callees (`answer`, `compute`) rather than
# the generic "cannot resolve return type" phrase: a sibling that imports
# an io-side-effecting void fn from the entry can still surface a
# non-blocking "...call to `write`..." diagnostic while the build links
# fine. Pinning the user-level callees keeps this test a precise #999
# regression (the build exiting 0 is the authoritative signal).
test_no_unresolved_callee_fatal() {
    cd "$SCRATCH" || return 1
    rm -rf "$SCRATCH/build"
    local rc=0
    "$BINARY" build -p . > "$SCRATCH/build.stdout" 2>&1 || rc=$?
    if grep -qE "cannot resolve return type for call to .(answer|compute)." "$SCRATCH/build.stdout"; then
        echo "[test]   sibling hit the #999 unresolved-callee fatal:" >&2
        cat "$SCRATCH/build.stdout" >&2
        return 1
    fi
    if [ "$rc" -ne 0 ]; then
        echo "[test]   expected exit 0 for cross-module value-returning build; got $rc" >&2
        cat "$SCRATCH/build.stdout" >&2
        return 1
    fi
    return 0
}
run_test "cross-module value-returning sibling emits + links (#999)" test_no_unresolved_callee_fatal

# ---- Test 2: the linked binary runs and prints the resolved value ----
test_runtime_output() {
    cd "$SCRATCH" || return 1
    local exe="$SCRATCH/build/sailfin/program"
    [ -x "$exe" ] || { echo "[test]   no linked binary at $exe" >&2; return 1; }
    local rc=0
    "$exe" > "$SCRATCH/program.stdout" 2>&1 || rc=$?
    if [ "$rc" -ne 0 ]; then
        echo "[test]   linked binary exited with code $rc; output:" >&2
        cat "$SCRATCH/program.stdout" >&2
        return 1
    fi
    # answer() == 42, compute() == answer() + 1 == 43. Assert the whole
    # sentinel line (`print.info` prefixes with `[info] `) rather than a
    # bare `43` substring, which would also match `143`/`430` or an
    # incidental log line.
    if ! grep -qx '\[info\] xmod-result=43' "$SCRATCH/program.stdout"; then
        echo "[test]   expected line '[info] xmod-result=43' in output; got:" >&2
        cat "$SCRATCH/program.stdout" >&2
        return 1
    fi
    return 0
}
run_test "linked binary computes 43 across the module boundary (#999)" test_runtime_output

# ---- Summary ----
echo ""
echo "[test] $PASS passed, $FAIL failed"
[ "$FAIL" -eq 0 ]
