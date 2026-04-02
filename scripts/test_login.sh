#!/usr/bin/env bash
# End-to-end tests for `sfn login`.
#
# Usage:
#   scripts/test_login.sh <compiler-binary>
#
# Uses a temporary HOME so the real ~/.sfn/credentials is never touched.

set -euo pipefail

BINARY="${1:?usage: test_login.sh <compiler-binary>}"
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

# ---- Test 1: login with token argument writes credentials ----
test_login_with_arg() {
    local home="$tmpdir/t1"
    mkdir -p "$home"
    HOME="$home" "$BINARY" login "test-token-abc123"
    [ -f "$home/.sfn/credentials" ] || return 1
    local stored
    stored="$(cat "$home/.sfn/credentials")"
    [ "$stored" = "test-token-abc123" ] || { echo "expected 'test-token-abc123', got '$stored'"; return 1; }
}

# ---- Test 2: login overwrites existing credentials ----
test_login_overwrites() {
    local home="$tmpdir/t2"
    mkdir -p "$home/.sfn"
    echo "old-token" > "$home/.sfn/credentials"
    HOME="$home" "$BINARY" login "new-token-xyz"
    local stored
    stored="$(cat "$home/.sfn/credentials")"
    [ "$stored" = "new-token-xyz" ] || { echo "expected 'new-token-xyz', got '$stored'"; return 1; }
}

# ---- Test 3: login creates ~/.sfn directory if missing ----
test_login_creates_dir() {
    local home="$tmpdir/t3"
    mkdir -p "$home"
    [ ! -d "$home/.sfn" ] || return 1
    HOME="$home" "$BINARY" login "dir-test-token"
    [ -d "$home/.sfn" ] || { echo "~/.sfn directory not created"; return 1; }
    [ -f "$home/.sfn/credentials" ] || { echo "credentials file not created"; return 1; }
}

# ---- Test 4: login rejects empty token ----
test_login_empty_token() {
    local home="$tmpdir/t4"
    mkdir -p "$home"
    if HOME="$home" "$BINARY" login "" 2>&1; then
        echo "expected non-zero exit for empty token"
        return 1
    fi
    # credentials file should not exist
    [ ! -f "$home/.sfn/credentials" ] || { echo "credentials file should not exist"; return 1; }
    return 0
}

# ---- Test 5: login with too many args shows usage ----
test_login_too_many_args() {
    local home="$tmpdir/t5"
    mkdir -p "$home"
    local output
    output="$(HOME="$home" "$BINARY" login "a" "b" 2>&1 || true)"
    echo "$output" | grep -qi "usage" || { echo "expected usage message, got: $output"; return 1; }
}

# ---- Test 6: login output confirms save path ----
test_login_output_message() {
    local home="$tmpdir/t6"
    mkdir -p "$home"
    local output
    output="$(HOME="$home" "$BINARY" login "msg-token" 2>&1)"
    echo "$output" | grep -q "credentials saved" || { echo "expected 'credentials saved' in output, got: $output"; return 1; }
}

# ---- Test 7: login interactive reads from stdin ----
test_login_interactive_stdin() {
    local home="$tmpdir/t7"
    mkdir -p "$home"
    echo "stdin-token-999" | HOME="$home" "$BINARY" login
    [ -f "$home/.sfn/credentials" ] || { echo "credentials file not created"; return 1; }
    local stored
    stored="$(cat "$home/.sfn/credentials")"
    [ "$stored" = "stdin-token-999" ] || { echo "expected 'stdin-token-999', got '$stored'"; return 1; }
}

run_test "login with token argument" test_login_with_arg
run_test "login overwrites existing credentials" test_login_overwrites
run_test "login creates ~/.sfn directory" test_login_creates_dir
run_test "login rejects empty token" test_login_empty_token
run_test "login too many args shows usage" test_login_too_many_args
run_test "login output confirms save path" test_login_output_message
run_test "login interactive reads from stdin" test_login_interactive_stdin

echo ""
echo "login tests: $PASS passed, $FAIL failed"
[ "$FAIL" -eq 0 ]
