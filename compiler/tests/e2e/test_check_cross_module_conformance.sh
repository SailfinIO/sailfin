#!/usr/bin/env bash
# End-to-end test for `sfn check` cross-module interface conformance.
#
# Verifies that A2 (Track A in docs/proposals/check-architecture.md)
# wires `sfn check` through the unified resolver: an interface declared
# in module A and consumed by an `implements` clause in module B is
# conformance-checked end-to-end, with E0301 fired when a required
# member is missing from the implementing struct.
#
# Without A2 wired correctly, the typechecker silently no-ops on
# cross-module `implements` clauses (the inline-textual pre-A2 path
# was the only thing making the imported interface visible).
#
# Usage:
#   compiler/tests/e2e/test_check_cross_module_conformance.sh <compiler-binary>

set -euo pipefail

BINARY="${1:?usage: test_check_cross_module_conformance.sh <compiler-binary>}"
BINARY="$(realpath "$BINARY")"
PASS=0
FAIL=0

SCRATCH="$(mktemp -d -t sfn-check-conformance-XXXXXX)"
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

# ---- Setup: minimal capsule with a cross-module conformance bug ----
mkdir -p "$SCRATCH/src"

# Symlink the in-tree capsules/ so the resolver finds sfn/prelude
# without needing the user cache. The repo's own workspace.toml lives
# above $REPO_ROOT; an empty workspace.toml at the test root stops
# `discover_workspace_root` from walking up into the live tree.
ln -s "$REPO_ROOT/capsules" "$SCRATCH/capsules"

cat > "$SCRATCH/workspace.toml" <<'EOF'
[workspace]
members = []
EOF

cat > "$SCRATCH/capsule.toml" <<'EOF'
[capsule]
name = "check-cross-module-test"
version = "0.1.0"
description = "E2E test for sfn check cross-module conformance"

[capabilities]
required = []

[build]
entry = "src/triangle.sfn"
EOF

cat > "$SCRATCH/src/shape.sfn" <<'EOF'
interface Shape {
    fn area(self) -> number;
    fn perimeter(self) -> number;
}

export { Shape };
EOF

# triangle.sfn implements Shape but is missing perimeter() — A2 must
# surface this as E0301. The dummy main() satisfies the parser; the
# diagnostic is what we're testing, not runtime behavior.
cat > "$SCRATCH/src/triangle.sfn" <<'EOF'
import { Shape } from "./shape";

struct Triangle implements Shape {
    a: number;
    b: number;
    c: number;

    fn area(self) -> number { return 0; }
}

fn main() {
    let _t = Triangle { a: 1, b: 1, c: 1 };
}

export { Triangle };
EOF

# ---- Test 1: sfn check fires E0301 on the cross-module conformance gap ----
test_e0301_fires() {
    cd "$SCRATCH" || return 1
    # `sfn check` exits 1 when diagnostics are found. Capture the exit
    # explicitly inside an `if` block so `set -e` does not abort the
    # script before we read $? — bash disables `-e` for commands inside
    # an `if` condition, which is the safest portable form here.
    local rc=0
    if "$BINARY" check src/triangle.sfn > "$SCRATCH/check.stdout" 2> "$SCRATCH/check.stderr"; then
        rc=0
    else
        rc=$?
    fi
    if [ "$rc" -ne 1 ]; then
        echo "[test]   expected exit code 1 (diagnostics found), got $rc" >&2
        echo "[test]   stderr:" >&2
        cat "$SCRATCH/check.stderr" >&2
        echo "[test]   stdout:" >&2
        cat "$SCRATCH/check.stdout" >&2
        return 1
    fi
    if ! grep -q "E0301" "$SCRATCH/check.stderr"; then
        echo "[test]   expected E0301 in stderr; full stderr:" >&2
        cat "$SCRATCH/check.stderr" >&2
        return 1
    fi
    if ! grep -q "perimeter" "$SCRATCH/check.stderr"; then
        echo "[test]   expected 'perimeter' in stderr; full stderr:" >&2
        cat "$SCRATCH/check.stderr" >&2
        return 1
    fi
    return 0
}
run_test "sfn check fires E0301 on cross-module missing-method" test_e0301_fires

# ---- Test 2: stderr contains the per-file [check] header ----
test_check_header() {
    grep -q "^\[check\] src/triangle.sfn$" "$SCRATCH/check.stderr"
}
run_test "stderr includes [check] file header" test_check_header

# ---- Test 3: import-context staging happened (A2 went through the resolver) ----
# Stage B PR2 aligned `_cr_relative_slug` with `module_name_from_path`, so
# relative deps now stage under subdirs rooted at the dep's path-derived
# slug (e.g. `import-context/src/shape.sfn-asm`) instead of flat paths.
# Either layout indicates the resolver ran; recursive find covers both.
test_import_context_staged() {
    find "$SCRATCH/build/native/import-context/" -type f -name '*.sfn-asm' 2>/dev/null \
        | grep -q "shape\|triangle"
}
run_test "resolver staged import-context for the project" test_import_context_staged

# ---- Test 4: negative control — adding the missing method clears the diagnostic ----
test_negative_control() {
    cd "$SCRATCH" || return 1
    cat > "$SCRATCH/src/triangle.sfn" <<'EOF'
import { Shape } from "./shape";

struct Triangle implements Shape {
    a: number;
    b: number;
    c: number;

    fn area(self) -> number { return 0; }
    fn perimeter(self) -> number { return 0; }
}

fn main() {
    let _t = Triangle { a: 1, b: 1, c: 1 };
}

export { Triangle };
EOF
    local rc=0
    if "$BINARY" check src/triangle.sfn > "$SCRATCH/check_ok.stdout" 2> "$SCRATCH/check_ok.stderr"; then
        rc=0
    else
        rc=$?
    fi
    if [ "$rc" -ne 0 ]; then
        echo "[test]   expected exit 0 with full impl, got $rc" >&2
        echo "[test]   stderr:" >&2
        cat "$SCRATCH/check_ok.stderr" >&2
        return 1
    fi
    if grep -q "E0301" "$SCRATCH/check_ok.stderr"; then
        echo "[test]   E0301 still firing after fix; stderr:" >&2
        cat "$SCRATCH/check_ok.stderr" >&2
        return 1
    fi
    return 0
}
run_test "negative control: complete impl produces no E0301" test_negative_control

# ---- Summary ----
echo ""
echo "[test] $PASS passed, $FAIL failed"
[ "$FAIL" -eq 0 ]
