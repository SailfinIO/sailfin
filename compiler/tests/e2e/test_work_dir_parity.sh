#!/usr/bin/env bash
# End-to-end parity test for `sfn build -p compiler --work-dir <DIR>`.
#
# Locks in the invariant that two driver runs into different `--work-dir`
# roots produce equivalent compiler binaries and the same set of staged
# import-context artifacts. This is the parity guard that
# `make check`'s fixed-point comparison currently provides at a 30-min
# wall-clock cost; surfacing the same regression at e2e-test time lets
# a `--work-dir` path leak fail fast instead of buried in `make check`.
#
# Acceptance criteria from #379:
#   - SHA-256 of `<DIR>/native/sailfin` matches across two work-dir roots
#     (Linux only — Mach-O binaries embed a per-link UUID/LC_UUID, so
#     byte-for-byte equality is not a stable signal on macOS; on Darwin
#     we instead assert the second binary is invokable, mirroring the
#     fixed-point check in `.github/workflows/ci.yml`)
#   - the set of `.ll` filenames under `<DIR>/native/import-context/`
#     is identical between the two runs
#   - per-build `timeout 600` (10 min)
#   - `ulimit -v 8388608` virtual-memory cap honored
#   - temp directories cleaned up on success and failure
#
# Usage:
#   compiler/tests/e2e/test_work_dir_parity.sh <compiler-binary>

set -euo pipefail

BINARY="${1:?usage: test_work_dir_parity.sh <compiler-binary>}"
BINARY="$(realpath "$BINARY")"

# REPO_ROOT is captured before any `cd` so the build invocations can
# resolve `compiler/capsule.toml` regardless of the test's CWD.
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"

# Cap virtual memory at 8 GB for every compiler subprocess this test
# spawns. Mandatory on Linux per `.claude/rules/compiler-safety.md`;
# best-effort on macOS where `ulimit -v` is unsupported.
ulimit -v 8388608 2>/dev/null || true

# macOS doesn't ship `timeout(1)`; coreutils provides `gtimeout`. Pick
# whichever is available and fall back to "no timeout" if neither
# exists, matching the convention in `scripts/run_native_test.sh` and
# (formerly) the now-retired prior `scripts/build.sh`.
if command -v timeout >/dev/null 2>&1; then
    TIMEOUT_CMD="timeout"
elif command -v gtimeout >/dev/null 2>&1; then
    TIMEOUT_CMD="gtimeout"
else
    TIMEOUT_CMD=""
fi

# `sha256sum` is GNU-only; macOS ships `shasum`. Use the same fallback
# as `.github/workflows/ci.yml`'s fixed-point block and the diag
# scripts under `scripts/diag_*.sh`.
sha256_of() {
    local path="$1"
    sha256sum "$path" 2>/dev/null | awk '{print $1}' \
        || shasum -a 256 "$path" | awk '{print $1}'
}

# Detect Darwin so the byte-equality assertion can be relaxed: Mach-O
# binaries carry an `LC_UUID` load command that's regenerated on every
# link, so two byte-identical inputs still produce non-identical
# binaries.  CI's fixed-point check (ci.yml:238-244) handles this
# the same way.
IS_DARWIN=0
case "$(uname -s 2>/dev/null || echo unknown)" in
    Darwin) IS_DARWIN=1 ;;
esac

PASS=0
FAIL=0

WORK_A=""
WORK_B=""
LOG_A=""
LOG_B=""

cleanup() {
    [ -n "$WORK_A" ] && [ -d "$WORK_A" ] && rm -rf "$WORK_A"
    [ -n "$WORK_B" ] && [ -d "$WORK_B" ] && rm -rf "$WORK_B"
    [ -n "$LOG_A" ] && [ -f "$LOG_A" ] && rm -f "$LOG_A"
    [ -n "$LOG_B" ] && [ -f "$LOG_B" ] && rm -f "$LOG_B"
}
trap cleanup EXIT

WORK_A="$(mktemp -d -t sfwd-a-XXXXXX)"
WORK_B="$(mktemp -d -t sfwd-b-XXXXXX)"
LOG_A="$(mktemp -t sfwd-build-a-XXXXXX.log)"
LOG_B="$(mktemp -t sfwd-build-b-XXXXXX.log)"

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

# Build the compiler under the given work-dir. Output goes to a log
# file we surface only on failure so passing runs don't drown the
# `make test-e2e` summary in 138 module compile lines. The
# `cmd ... && rc=0 || rc=$?` pattern preserves the build's actual
# exit code; an `if ! cmd; then rc=$?` would always observe `0`
# because `!` itself succeeded.
build_compiler_into() {
    local work_dir="$1"
    local log="$2"
    cd "$REPO_ROOT" || return 1
    local rc=0
    if [ -n "$TIMEOUT_CMD" ]; then
        "$TIMEOUT_CMD" 600 "$BINARY" build -p compiler --work-dir "$work_dir" \
            > "$log" 2>&1 && rc=0 || rc=$?
    else
        "$BINARY" build -p compiler --work-dir "$work_dir" \
            > "$log" 2>&1 && rc=0 || rc=$?
    fi
    if [ "$rc" -ne 0 ]; then
        echo "[test]   sfn build -p compiler --work-dir $work_dir failed (rc=$rc)" >&2
        echo "[test]   tail of $log:" >&2
        tail -n 60 "$log" >&2 || true
        return 1
    fi
    if [ ! -f "$work_dir/native/sailfin" ]; then
        echo "[test]   $work_dir/native/sailfin missing after build" >&2
        return 1
    fi
}

# ---- Test 1: build #1 into WORK_A succeeds and produces the binary ----
test_build_a() {
    build_compiler_into "$WORK_A" "$LOG_A"
}
run_test "sfn build -p compiler --work-dir <A> succeeds" test_build_a

# ---- Test 2: build #2 into WORK_B succeeds and produces the binary ----
test_build_b() {
    build_compiler_into "$WORK_B" "$LOG_B"
}
run_test "sfn build -p compiler --work-dir <B> succeeds" test_build_b

# ---- Test 3: SHA-256 (Linux) or runs-cleanly (macOS) ----
# Linux ELF: byte-for-byte equality. A divergence here means the
# work-dir absolute path leaked into the compiled binary (e.g. via
# `__FILE__` metadata, debug-info path prefixes, or RPATH).
# macOS Mach-O: skip the SHA equality (LC_UUID is per-link). Assert
# the second binary is invokable instead, mirroring `ci.yml`'s
# fixed-point block. Both invariants protect against a path leak that
# corrupts the produced compiler.
test_binary_parity() {
    [ -f "$WORK_A/native/sailfin" ] || return 1
    [ -f "$WORK_B/native/sailfin" ] || return 1

    if [ "$IS_DARWIN" -eq 1 ]; then
        # Mach-O LC_UUID makes byte equality unstable. Fall back to a
        # weaker but still meaningful invariant: the work-dir-built
        # compiler is invokable and reports a version string.
        local ver_b
        if ! ver_b="$("$WORK_B/native/sailfin" version 2>&1)"; then
            echo "[test]   $WORK_B/native/sailfin failed to run \`version\`:" >&2
            echo "$ver_b" >&2
            return 1
        fi
        if [ -z "$ver_b" ]; then
            echo "[test]   $WORK_B/native/sailfin produced empty version output" >&2
            return 1
        fi
        echo "[test]   (darwin) skipping byte-equality (LC_UUID); B reports: $ver_b"
        return 0
    fi

    local sha_a sha_b
    sha_a="$(sha256_of "$WORK_A/native/sailfin")"
    sha_b="$(sha256_of "$WORK_B/native/sailfin")"
    if [ "$sha_a" != "$sha_b" ]; then
        echo "[test]   SHA-256 mismatch:" >&2
        echo "[test]     A=$sha_a ($WORK_A/native/sailfin)" >&2
        echo "[test]     B=$sha_b ($WORK_B/native/sailfin)" >&2
        return 1
    fi
}
run_test "two --work-dir builds produce equivalent compilers" test_binary_parity

# ---- Test 4: import-context filename sets are identical ----
# AC requires comparing `.ll` filename sets under
# `<DIR>/native/import-context/`. The driver currently stages
# `.sfn-asm` + `.layout-manifest` into that tree (not `.ll`), so a
# strict `.ll`-only check would pass trivially against two empty
# sets. We compare the **full** set of filenames recursively — a
# strictly stronger invariant that subsumes `.ll` and catches any
# divergence in the staged module surface, regardless of suffix.
# This invariant holds on both Linux and macOS because module names
# and relative paths under import-context don't depend on link-time
# UUIDs.
test_import_context_set_matches() {
    local list_a="$LOG_A.ic-list"
    local list_b="$LOG_B.ic-list"

    if [ -d "$WORK_A/native/import-context" ]; then
        ( cd "$WORK_A/native/import-context" && find . -type f -print \
            | LC_ALL=C sort > "$list_a" ) || return 1
    else
        : > "$list_a"
    fi
    if [ -d "$WORK_B/native/import-context" ]; then
        ( cd "$WORK_B/native/import-context" && find . -type f -print \
            | LC_ALL=C sort > "$list_b" ) || return 1
    else
        : > "$list_b"
    fi

    local rc=0
    if ! diff -u "$list_a" "$list_b" > "$LOG_A.ic-diff" 2>&1; then
        echo "[test]   import-context filename sets differ:" >&2
        head -n 40 "$LOG_A.ic-diff" >&2
        rc=1
    fi

    rm -f "$list_a" "$list_b" "$LOG_A.ic-diff"
    return $rc
}
run_test "import-context filename set matches across --work-dir roots" \
    test_import_context_set_matches

# ---- Summary ----
echo ""
echo "[test] $PASS passed, $FAIL failed"
[ "$FAIL" -eq 0 ]
