#!/usr/bin/env bash
# End-to-end tests for `sfn config`.
#
# Usage:
#   compiler/tests/e2e/test_config.sh <compiler-binary>
#
# Uses a temporary HOME so the real ~/.sfn/config.toml is never touched.

set -euo pipefail

BINARY="${1:?usage: test_config.sh <compiler-binary>}"
PASS=0
FAIL=0

# Do not let the caller's registry env var leak into these tests — each one
# either sets SFN_REGISTRY explicitly or asserts the unset default.
unset SFN_REGISTRY 2>/dev/null || true

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

# ---- Test 1: no args shows usage ----
test_config_no_args() {
    local home="$tmpdir/t1"
    mkdir -p "$home"
    local output
    output="$(HOME="$home" "$BINARY" config 2>&1 || true)"
    echo "$output" | grep -qi "usage" || { echo "expected usage, got: $output"; return 1; }
}

# ---- Test 2: set registry writes config.toml ----
test_config_set_registry() {
    local home="$tmpdir/t2"
    mkdir -p "$home"
    HOME="$home" "$BINARY" config set registry "https://example.test"
    [ -f "$home/.sfn/config.toml" ] || { echo "config.toml not created"; return 1; }
    grep -q '^\[registry\]' "$home/.sfn/config.toml" \
        || { echo "missing [registry] section"; return 1; }
    grep -q '^url = "https://example.test"' "$home/.sfn/config.toml" \
        || { echo "missing url line"; return 1; }
}

# ---- Test 3: set strips trailing slash(es) ----
test_config_set_strips_trailing_slash() {
    local home="$tmpdir/t3"
    mkdir -p "$home"
    HOME="$home" "$BINARY" config set registry "https://example.test///"
    grep -q '^url = "https://example.test"$' "$home/.sfn/config.toml" \
        || { echo "trailing slashes not stripped:"; cat "$home/.sfn/config.toml"; return 1; }
}

# ---- Test 4: get registry returns default when unset ----
test_config_get_default() {
    local home="$tmpdir/t4"
    mkdir -p "$home"
    local output
    output="$(HOME="$home" "$BINARY" config get registry 2>&1)"
    [ "$output" = "https://pkg.sfn.dev" ] \
        || { echo "expected default registry, got: $output"; return 1; }
}

# ---- Test 5: get registry returns set value ----
test_config_get_set_value() {
    local home="$tmpdir/t5"
    mkdir -p "$home"
    HOME="$home" "$BINARY" config set registry "https://private.corp"
    local output
    output="$(HOME="$home" "$BINARY" config get registry 2>&1)"
    [ "$output" = "https://private.corp" ] \
        || { echo "expected 'https://private.corp', got: $output"; return 1; }
}

# ---- Test 6: SFN_REGISTRY env var wins over config file ----
test_config_env_overrides_file() {
    local home="$tmpdir/t6"
    mkdir -p "$home"
    HOME="$home" "$BINARY" config set registry "https://in-file.test"
    local output
    output="$(HOME="$home" SFN_REGISTRY="https://from-env.test" "$BINARY" config get registry 2>&1)"
    [ "$output" = "https://from-env.test" ] \
        || { echo "env did not override file: $output"; return 1; }
}

# ---- Test 7: unset registry removes the value ----
test_config_unset_registry() {
    local home="$tmpdir/t7"
    mkdir -p "$home"
    HOME="$home" "$BINARY" config set registry "https://custom.test"
    HOME="$home" "$BINARY" config unset registry
    local output
    output="$(HOME="$home" "$BINARY" config get registry 2>&1)"
    [ "$output" = "https://pkg.sfn.dev" ] \
        || { echo "unset did not revert to default: $output"; return 1; }
}

# ---- Test 8: list shows resolved registry ----
test_config_list() {
    local home="$tmpdir/t8"
    mkdir -p "$home"
    HOME="$home" "$BINARY" config set registry "https://list.test"
    local output
    output="$(HOME="$home" "$BINARY" config list 2>&1)"
    echo "$output" | grep -q "registry = https://list.test" \
        || { echo "expected 'registry = https://list.test', got: $output"; return 1; }
}

# ---- Test 9: set with unknown key rejected ----
test_config_set_unknown_key() {
    local home="$tmpdir/t9"
    mkdir -p "$home"
    if HOME="$home" "$BINARY" config set bogus-key value 2>&1; then
        echo "expected non-zero exit for unknown key"
        return 1
    fi
    return 0
}

# ---- Test 10: get with unknown key rejected ----
test_config_get_unknown_key() {
    local home="$tmpdir/t10"
    mkdir -p "$home"
    if HOME="$home" "$BINARY" config get bogus-key 2>&1; then
        echo "expected non-zero exit for unknown key"
        return 1
    fi
    return 0
}

# ---- Test 11: set with empty value rejected ----
test_config_set_empty_value() {
    local home="$tmpdir/t11"
    mkdir -p "$home"
    if HOME="$home" "$BINARY" config set registry "" 2>&1; then
        echo "expected non-zero exit for empty value"
        return 1
    fi
    return 0
}

# ---- Test 11b: set rejects non-http(s) scheme ----
test_config_set_rejects_bad_scheme() {
    local home="$tmpdir/t11b"
    mkdir -p "$home"
    if HOME="$home" "$BINARY" config set registry "ftp://nope.test" 2>&1; then
        echo "expected non-zero exit for non-http scheme"
        return 1
    fi
    [ ! -f "$home/.sfn/config.toml" ] \
        || { echo "config.toml should not have been written"; return 1; }
    return 0
}

# ---- Test 11c: set rejects shell metacharacters ----
test_config_set_rejects_metachars() {
    local home="$tmpdir/t11c"
    mkdir -p "$home"
    if HOME="$home" "$BINARY" config set registry 'https://bad.test"; echo pwn' 2>&1; then
        echo "expected non-zero exit for URL with shell metacharacters"
        return 1
    fi
    [ ! -f "$home/.sfn/config.toml" ] \
        || { echo "config.toml should not have been written"; return 1; }
    return 0
}

# ---- Test 11d: invalid env var falls back to default with warning ----
test_config_invalid_env_falls_back() {
    local home="$tmpdir/t11d"
    mkdir -p "$home"
    local output
    output="$(HOME="$home" SFN_REGISTRY="not a url" "$BINARY" config get registry 2>&1)"
    echo "$output" | grep -q "https://pkg.sfn.dev" \
        || { echo "expected default URL in output, got: $output"; return 1; }
    echo "$output" | grep -qi "warning" \
        || { echo "expected warning about invalid SFN_REGISTRY, got: $output"; return 1; }
}

# ---- Test 12: unknown subcommand rejected ----
test_config_unknown_subcommand() {
    local home="$tmpdir/t12"
    mkdir -p "$home"
    local output
    output="$(HOME="$home" "$BINARY" config quantum registry 2>&1 || true)"
    echo "$output" | grep -qi "unknown subcommand" \
        || { echo "expected 'unknown subcommand' in output, got: $output"; return 1; }
}

# ---- Test 13: ~/.sfn and config.toml have restrictive permissions ----
test_config_permissions() {
    local home="$tmpdir/t13"
    mkdir -p "$home"
    HOME="$home" "$BINARY" config set registry "https://perm.test"
    local dir_perms
    dir_perms="$(stat -c '%a' "$home/.sfn" 2>/dev/null || stat -f '%Lp' "$home/.sfn" 2>/dev/null)"
    [ "$dir_perms" = "700" ] \
        || { echo "expected ~/.sfn perms 700, got $dir_perms"; return 1; }
    local file_perms
    file_perms="$(stat -c '%a' "$home/.sfn/config.toml" 2>/dev/null || stat -f '%Lp' "$home/.sfn/config.toml" 2>/dev/null)"
    [ "$file_perms" = "600" ] \
        || { echo "expected config.toml perms 600, got $file_perms"; return 1; }
}

run_test "config no args shows usage" test_config_no_args
run_test "config set registry writes config.toml" test_config_set_registry
run_test "config set strips trailing slash" test_config_set_strips_trailing_slash
run_test "config get returns default when unset" test_config_get_default
run_test "config get returns set value" test_config_get_set_value
run_test "SFN_REGISTRY env overrides config file" test_config_env_overrides_file
run_test "config unset reverts to default" test_config_unset_registry
run_test "config list shows resolved registry" test_config_list
run_test "config set rejects unknown key" test_config_set_unknown_key
run_test "config get rejects unknown key" test_config_get_unknown_key
run_test "config set rejects empty value" test_config_set_empty_value
run_test "config set rejects non-http scheme" test_config_set_rejects_bad_scheme
run_test "config set rejects shell metacharacters" test_config_set_rejects_metachars
run_test "invalid SFN_REGISTRY env falls back to default" test_config_invalid_env_falls_back
run_test "config rejects unknown subcommand" test_config_unknown_subcommand
run_test "config file permissions restricted" test_config_permissions

echo ""
echo "config tests: $PASS passed, $FAIL failed"
[ "$FAIL" -eq 0 ]
