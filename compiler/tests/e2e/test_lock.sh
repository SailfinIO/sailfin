#!/usr/bin/env bash
# End-to-end tests for `sfn lock` (#1070).
#
# Usage:
#   compiler/tests/e2e/test_lock.sh <compiler-binary>
#
# `sfn lock` materializes `workspace.lock` at the workspace root: a
# `# workspace.lock` banner followed by one `[packages]` entry per member.
# Runs against a throwaway fixture workspace so the repo tree is untouched.

set -euo pipefail

BINARY="${1:?usage: test_lock.sh <compiler-binary>}"
# The runner passes a repo-relative binary path; resolve it to an absolute
# path before we cd into the fixture workspace.
BINARY="$(cd "$(dirname "$BINARY")" && pwd)/$(basename "$BINARY")"

PASS=0
FAIL=0

tmpdir="$(mktemp -d)"
trap 'rm -rf "$tmpdir"' EXIT

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

# Build a fixture workspace with two members under $1.
make_workspace() {
    local root="$1"
    mkdir -p "$root/alpha" "$root/beta"
    cat > "$root/workspace.toml" <<'EOF'
[workspace]
members = ["alpha", "beta"]
EOF
    cat > "$root/alpha/capsule.toml" <<'EOF'
[capsule]
name = "fixture/alpha"
version = "1.2.3"
EOF
    cat > "$root/beta/capsule.toml" <<'EOF'
[capsule]
name = "fixture/beta"
version = "4.5.6"
EOF
}

# ---- Test 1: lock in a workspace writes workspace.lock ----
test_lock_writes_file() {
    local root="$tmpdir/t1"
    make_workspace "$root"
    ( cd "$root" && "$BINARY" lock ) >/dev/null
    [ -f "$root/workspace.lock" ] \
        || { echo "workspace.lock not created"; return 1; }
    head -1 "$root/workspace.lock" | grep -q '^# workspace.lock' \
        || { echo "missing banner:"; cat "$root/workspace.lock"; return 1; }
    grep -q '^\[packages\]' "$root/workspace.lock" \
        || { echo "missing [packages] section"; cat "$root/workspace.lock"; return 1; }
    grep -q '^"fixture/alpha" = "1.2.3"$' "$root/workspace.lock" \
        || { echo "missing alpha entry:"; cat "$root/workspace.lock"; return 1; }
    grep -q '^"fixture/beta" = "4.5.6"$' "$root/workspace.lock" \
        || { echo "missing beta entry:"; cat "$root/workspace.lock"; return 1; }
}

# ---- Test 2: re-running is idempotent (stable output) ----
test_lock_idempotent() {
    local root="$tmpdir/t2"
    make_workspace "$root"
    ( cd "$root" && "$BINARY" lock ) >/dev/null
    local first
    first="$(cat "$root/workspace.lock")"
    ( cd "$root" && "$BINARY" lock ) >/dev/null
    local second
    second="$(cat "$root/workspace.lock")"
    [ "$first" = "$second" ] \
        || { echo "output changed on re-run"; return 1; }
}

# ---- Test 3: lock from a nested member dir finds the workspace root ----
test_lock_from_member_dir() {
    local root="$tmpdir/t3"
    make_workspace "$root"
    ( cd "$root/alpha" && "$BINARY" lock ) >/dev/null
    [ -f "$root/workspace.lock" ] \
        || { echo "workspace.lock not written at root from nested dir"; return 1; }
    [ ! -f "$root/alpha/workspace.lock" ] \
        || { echo "workspace.lock wrongly written in member dir"; return 1; }
}

# ---- Test 4: outside a workspace errors cleanly (non-zero) ----
test_lock_outside_workspace() {
    local root="$tmpdir/t4"
    mkdir -p "$root"
    local output
    if output="$( cd "$root" && "$BINARY" lock 2>&1 )"; then
        echo "expected non-zero exit outside a workspace, got: $output"
        return 1
    fi
    [ ! -f "$root/workspace.lock" ] \
        || { echo "workspace.lock should not have been written"; return 1; }
    return 0
}

run_test "lock writes workspace.lock with banner + entries" test_lock_writes_file
run_test "lock is idempotent across re-runs" test_lock_idempotent
run_test "lock from a member dir writes at workspace root" test_lock_from_member_dir
run_test "lock outside a workspace errors cleanly" test_lock_outside_workspace

echo ""
echo "lock tests: $PASS passed, $FAIL failed"
[ "$FAIL" -eq 0 ]
