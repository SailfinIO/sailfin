#!/usr/bin/env bash
# End-to-end test for the compiler CLI skeleton `sailfin_cli_main_v2`
# (CLI modularization epic #351, Issue 2.3 — proposal §5 Phase 2,
# §7 Issue 2.3, Risk R2).
#
# v2 is the new front door for the compiler CLI: it builds a root
# `Command` via `sfn/cli`, registers only `version`, parses with the
# pure, non-exiting `parse()`, prints help/version itself, and falls
# through to the verbatim legacy dispatch (`sailfin_cli_main_legacy`)
# for every other subcommand.
#
# This pins the Issue 2.3 acceptance contract end-to-end against the
# real binary — i.e. through the synthesized `@main` →
# `sailfin_cli_main_with_paths` → `sailfin_cli_main_v2` chain:
#
#   1. `sfn version`  routes through v2 → prints `sfn <version>`, exit 0.
#   2. `sfn --version` / `sfn -V` route through v2's `version_requested`
#      branch → prints `sfn <version>`, exit 0.
#   3. A legacy subcommand (`build` / unknown) falls through to the
#      legacy dispatch and the v2 CALLER OBSERVES the returned exit code
#      — i.e. `run()`/`process.exit()` never fires out from under the
#      `int`-returning contract (Risk R2). An unknown command returns
#      the canonical EXIT_USAGE (2) with an "unknown command" diagnostic.
#
# An in-process `.sfn` integration test cannot exercise this without
# importing the full compiler graph (`cli/main` → `cli_main` → `main`),
# which no test does; running the real binary is both lighter and the
# faithful realization of "the C driver observes the returned code".

set -euo pipefail

BINARY="${1:?usage: test_cli_v2_exit_codes.sh <compiler-binary>}"
BINARY="$(realpath "$BINARY")"
PASS=0
FAIL=0

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"

SCRATCH="$(mktemp -d -t sfn-cli-v2-XXXXXX)"
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

# Run the binary from the repo root (so the `runtime/` bundle resolves)
# and capture stdout, stderr, and the exit code separately.
_invoke() {
    local out_log="$1"
    local err_log="$2"
    shift 2
    local rc=0
    (cd "$REPO_ROOT" && "$BINARY" "$@") > "$out_log" 2> "$err_log" || rc=$?
    echo "$rc"
}

# Shared assertion for the version-printing legs: exit 0 and a stdout
# line of the form `sfn <non-empty version>`.
_assert_version_ok() {
    local label="$1"
    shift
    local out_log="$SCRATCH/version-out.log"
    local err_log="$SCRATCH/version-err.log"
    local rc
    rc="$(_invoke "$out_log" "$err_log" "$@")"
    if [ "$rc" -ne 0 ]; then
        echo "[test]   '$label' exited with code $rc (expected 0)"
        echo "[test]   stdout:"; cat "$out_log"
        echo "[test]   stderr:"; cat "$err_log"
        return 1
    fi
    if ! grep -Eqx 'sfn .+' "$out_log"; then
        echo "[test]   '$label' stdout did not match 'sfn <version>':"
        cat "$out_log"
        return 1
    fi
    return 0
}

test_version_subcommand_routes_through_v2() {
    _assert_version_ok "sfn version" version
}

test_version_long_flag_routes_through_v2() {
    _assert_version_ok "sfn --version" --version
}

test_version_short_flag_routes_through_v2() {
    _assert_version_ok "sfn -V" -V
}

test_legacy_unknown_subcommand_returns_observed_code() {
    # `not-a-known-subcommand` is not `version`, does not end in `.sfn`,
    # and is unknown to the legacy dispatch — which prints "unknown
    # command" and returns EXIT_USAGE (2). The point of the pin: the
    # legacy exit code is OBSERVED by the v2 caller, proving v2 forwarded
    # to legacy without a `process.exit` terminating the process first.
    local out_log="$SCRATCH/legacy-out.log"
    local err_log="$SCRATCH/legacy-err.log"
    local rc
    rc="$(_invoke "$out_log" "$err_log" not-a-known-subcommand)"
    if [ "$rc" -ne 2 ]; then
        echo "[test]   expected exit 2 for unknown command, got $rc"
        echo "[test]   stdout:"; cat "$out_log"
        echo "[test]   stderr:"; cat "$err_log"
        return 1
    fi
    if ! grep -q "unknown command" "$out_log" "$err_log" 2>/dev/null; then
        echo "[test]   expected 'unknown command' diagnostic, got:"
        echo "[test]   stdout:"; cat "$out_log"
        echo "[test]   stderr:"; cat "$err_log"
        return 1
    fi
    return 0
}

run_test "sfn version routes through v2 (exit 0, prints version)" \
    test_version_subcommand_routes_through_v2
run_test "sfn --version routes through v2 (exit 0, prints version)" \
    test_version_long_flag_routes_through_v2
run_test "sfn -V routes through v2 (exit 0, prints version)" \
    test_version_short_flag_routes_through_v2
run_test "legacy fallthrough exit code is observed by the v2 caller (no process.exit)" \
    test_legacy_unknown_subcommand_returns_observed_code

echo "[summary] $PASS passed, $FAIL failed"
if [ "$FAIL" -gt 0 ]; then
    exit 1
fi
