#!/usr/bin/env bash
# End-to-end test for `sfn check` effect-violation call-site carets.
#
# B1 (Track B in docs/proposals/check-architecture.md) plumbs source
# spans through `Expression.Identifier` and `Expression.Member` so the
# effect checker can attribute violations to the offending call site
# rather than the function declaration. This test exercises the full
# parse → typecheck → effect-check → render pipeline against a fixture
# whose function declaration is far enough above the offending call
# that confusing the two would be obvious in `--> file:line:column`
# output.
#
# Usage:
#   compiler/tests/e2e/test_check_effect_call_site_caret.sh <compiler-binary>

set -euo pipefail

BINARY="${1:?usage: test_check_effect_call_site_caret.sh <compiler-binary>}"
BINARY="$(realpath "$BINARY")"
PASS=0
FAIL=0

SCRATCH="$(mktemp -d -t sfn-check-callsite-XXXXXX)"
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

mkdir -p "$SCRATCH/src"

ln -s "$REPO_ROOT/capsules" "$SCRATCH/capsules"

cat > "$SCRATCH/workspace.toml" <<'EOF'
[workspace]
members = []
EOF

cat > "$SCRATCH/capsule.toml" <<'EOF'
[capsule]
name = "check-callsite-caret-test"
version = "0.1.0"
description = "E2E test for sfn check call-site caret attribution (B1)"

[capabilities]
required = ["io"]

[build]
entry = "src/leak.sfn"
EOF

# `noisy_helper` is declared at line 4, but the offending `print.info`
# is at line 8. Pre-B1 the diagnostic would caret at line 4; post-B1
# it must caret at line 8 (the `print` namespace).
cat > "$SCRATCH/src/leak.sfn" <<'EOF'
// 1
// 2
// 3
fn noisy_helper(x: number) -> number {
    let mut total: number = 0;
    let other: number = 0;
    total = total + x;
    print.info("recording");
    return total + other;
}

fn main() {
    let _ = noisy_helper(1);
}

export { noisy_helper };
EOF

# ---- Test 1: sfn check fires E0400 ----
test_e0400_fires() {
    cd "$SCRATCH" || return 1
    local rc=0
    if "$BINARY" check src/leak.sfn > "$SCRATCH/check.stdout" 2> "$SCRATCH/check.stderr"; then
        rc=0
    else
        rc=$?
    fi
    if [ "$rc" -ne 1 ]; then
        echo "[test]   expected exit code 1 (diagnostics found), got $rc" >&2
        echo "[test]   stderr:" >&2
        cat "$SCRATCH/check.stderr" >&2
        return 1
    fi
    if ! grep -q "E0400" "$SCRATCH/check.stderr"; then
        echo "[test]   expected E0400 in stderr; full stderr:" >&2
        cat "$SCRATCH/check.stderr" >&2
        return 1
    fi
    return 0
}
run_test "sfn check fires E0400 on missing ![io]" test_e0400_fires

# ---- Test 2: stderr carets at the call site (line 8), not the declaration (line 4) ----
test_caret_lands_on_call_site() {
    # The renderer emits `--> <file>:<line>:<column>`. After B1, the
    # E0400 violation should reference line 8 (`print.info(...)`),
    # not line 4 (`fn noisy_helper`).
    if ! grep -q "src/leak.sfn:8:" "$SCRATCH/check.stderr"; then
        echo "[test]   expected '--> src/leak.sfn:8:' in stderr — caret should be at the call site" >&2
        echo "[test]   stderr:" >&2
        cat "$SCRATCH/check.stderr" >&2
        return 1
    fi
    return 0
}
run_test "E0400 caret lands on the print.info call (line 8) not declaration (line 4)" test_caret_lands_on_call_site

# ---- Test 3: declaration site is not the primary caret ----
# We accept that some future renderer may show a "declared here" hint
# at line 4, but the *primary* `--> ` line must be the call site.
# Lock the primary by asserting the first caret arrow contains line 8.
test_primary_caret_is_call_site() {
    local first_arrow
    first_arrow="$(grep -m 1 -E '^[[:space:]]*--> ' "$SCRATCH/check.stderr" || true)"
    if [ -z "$first_arrow" ]; then
        echo "[test]   no '-->' source-location line in stderr" >&2
        cat "$SCRATCH/check.stderr" >&2
        return 1
    fi
    if ! echo "$first_arrow" | grep -q "src/leak.sfn:8:"; then
        echo "[test]   primary caret is not at the call site" >&2
        echo "[test]   first '-->' line: $first_arrow" >&2
        return 1
    fi
    return 0
}
run_test "primary caret is the call site" test_primary_caret_is_call_site

# ---- Test 4: negative control — adding ![io] clears the diagnostic ----
test_negative_control() {
    cd "$SCRATCH" || return 1
    cat > "$SCRATCH/src/leak.sfn" <<'EOF'
// 1
// 2
// 3
fn noisy_helper(x: number) -> number ![io] {
    let mut total: number = 0;
    let other: number = 0;
    total = total + x;
    print.info("recording");
    return total + other;
}

fn main() ![io] {
    let _ = noisy_helper(1);
}

export { noisy_helper };
EOF
    local rc=0
    if "$BINARY" check src/leak.sfn > "$SCRATCH/check_ok.stdout" 2> "$SCRATCH/check_ok.stderr"; then
        rc=0
    else
        rc=$?
    fi
    if [ "$rc" -ne 0 ]; then
        echo "[test]   expected exit 0 after adding ![io]; got $rc" >&2
        cat "$SCRATCH/check_ok.stderr" >&2
        return 1
    fi
    return 0
}
run_test "negative control: declaring ![io] clears the diagnostic" test_negative_control

echo "[summary] $PASS passed, $FAIL failed"
if [ "$FAIL" -ne 0 ]; then
    exit 1
fi
exit 0
