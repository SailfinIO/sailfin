#!/usr/bin/env bash
# End-to-end test for end-user capsule dependency resolution.
#
# Verifies that `sfn build` on a project with capsule.toml declaring
# sfn/math as a dep correctly stages the capsule's import-context,
# compiles the capsule module, and links everything into a runnable
# binary — without any text-level inlining.
#
# This is the success condition for the capsule_resolver.sfn refactor.
#
# Usage:
#   compiler/tests/e2e/test_capsule_build.sh <compiler-binary>

set -euo pipefail

BINARY="${1:?usage: test_capsule_build.sh <compiler-binary>}"
BINARY="$(realpath "$BINARY")"
PASS=0
FAIL=0

# Scratch dir for the test project. Cleaned on exit.
SCRATCH="$(mktemp -d -t sfn-capsule-build-XXXXXX)"
trap 'rm -rf "$SCRATCH"' EXIT

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"

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

# ---- Setup: create a minimal project using sfn/math ----
mkdir -p "$SCRATCH/src"

# Link (rather than copy) the in-tree capsules/ dir so the resolver's
# in-tree lookup finds sfn/math without needing the user cache.
ln -s "$REPO_ROOT/capsules" "$SCRATCH/capsules"

cat > "$SCRATCH/capsule.toml" <<'EOF'
[capsule]
name = "capsule-build-test"
version = "0.1.0"
description = "E2E test for sfn build with capsule deps"

[dependencies]
"sfn/math" = "0.1.0"

[capabilities]
required = ["io"]

[build]
entry = "src/main.sfn"
EOF

cat > "$SCRATCH/src/main.sfn" <<'EOF'
import { abs, clamp } from "sfn/math";

fn main() ![io] {
    // Match the conventional `fn main() ![io]` signature used in the
    // examples/ tree. We signal pass/fail via stdout ("OK" or "FAIL ...")
    // and the shell test inspects that output.
    let a = abs(-7);
    let b = clamp(15, 0, 10);
    if a != 7 {
        print("FAIL abs(-7)");
    } else if b != 10 {
        print("FAIL clamp(15,0,10)");
    } else {
        print("OK");
    }
}
EOF

# ---- Test 1: sfn build succeeds on a project with a capsule dep ----
test_build_succeeds() {
    cd "$SCRATCH" || return 1
    local rc
    "$BINARY" build -o build/program src/main.sfn > "$SCRATCH/build.stdout" 2>&1
    rc=$?
    if [ "$rc" -ne 0 ]; then
        echo "[test]   sfn build exited with code $rc; output:" >&2
        cat "$SCRATCH/build.stdout" >&2
    fi
    return $rc
}
run_test "sfn build completes with a capsule dep" test_build_succeeds

# ---- Test 2: the linked binary runs and returns exit 0 + prints "OK" ----
test_binary_runs() {
    cd "$SCRATCH" || return 1
    [ -x "build/program" ] || return 1
    local rc
    "$SCRATCH/build/program" > "$SCRATCH/program.stdout" 2>&1
    rc=$?
    if [ "$rc" -ne 0 ]; then
        echo "[test]   binary exited with code $rc; output:" >&2
        cat "$SCRATCH/program.stdout" >&2
        return 1
    fi
    grep -q "^OK$" "$SCRATCH/program.stdout"
}
run_test "binary links and runs using capsule symbols" test_binary_runs

# ---- Test 3: capsule import-context was staged ----
test_import_context_staged() {
    [ -f "$SCRATCH/build/native/import-context/sfn/math/mod.sfn-asm" ]
}
run_test "capsule import-context was staged" test_import_context_staged

# ---- Test 4: capsule .ll was produced ----
test_capsule_ll_produced() {
    [ -f "$SCRATCH/build/sailfin/capsules/sfn__math__mod.ll" ]
}
run_test "capsule .ll was produced" test_capsule_ll_produced

# ---- Summary ----
echo ""
echo "[test] $PASS passed, $FAIL failed"
[ "$FAIL" -eq 0 ]
