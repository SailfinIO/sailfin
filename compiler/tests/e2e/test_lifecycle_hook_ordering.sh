#!/usr/bin/env bash
# Issue #975: lifecycle-hook ordering. The compiler recognizes
# `before_each`/`after_each`/`before_all`/`after_all` blocks, carries them
# on `TestDeclaration.hook_kind`, emits them under a `hook:<kind>` symbol,
# and the synthesized test harness (lowering_core.sfn) wraps each ordinary
# `test:` call so:
#
#   before_all   runs once, before any test
#   before_each  runs before every test body
#   after_each   runs after every test body
#   after_all    runs once, after every test
#
# Each hook/test body prints a distinctive marker via print.info (stdout),
# so the observed stdout order pins the wrapping order across >=2 tests in
# one file. The harness `PASS (all N tests passed)` count must exclude
# hooks (hooks emit no RUN/PASS line and are not `test:` symbols).

set -euo pipefail

BINARY="${1:?usage: test_lifecycle_hook_ordering.sh <compiler-binary>}"
BINARY="$(realpath "$BINARY")"
PASS=0
FAIL=0

SCRATCH="$(mktemp -d -t sfn-lifecycle-hook-XXXXXX)"
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

# Markers are emitted via `print.info`, which prefixes each line with
# `[info] `. The full ordered marker sequence pins ordering, counts, and
# per-test pairing in one comparison.

test_hook_ordering() {
    mkdir -p "$SCRATCH/proj"
    cat > "$SCRATCH/proj/lifecycle_test.sfn" <<'EOF'
before_all ![io] {
    print.info("BEFORE_ALL");
}

before_each ![io] {
    print.info("BEFORE_EACH");
}

after_each ![io] {
    print.info("AFTER_EACH");
}

after_all ![io] {
    print.info("AFTER_ALL");
}

test "alpha" ![io] {
    print.info("TEST_ALPHA");
}

test "beta" ![io] {
    print.info("TEST_BETA");
}
EOF
    local log="$SCRATCH/proj/run.log"
    pushd "$SCRATCH/proj" >/dev/null
    if ! "$BINARY" test "$SCRATCH/proj" > "$log" 2>&1; then
        popd >/dev/null
        echo "[test]   sfn test failed:"
        cat "$log"
        return 1
    fi
    popd >/dev/null

    # Extract the ordered body markers (strip the `[info] ` prefix) and
    # compare to the exact expected wrap order across both tests:
    #   before_all, (before_each, test, after_each) x2, after_all.
    local actual expected
    actual=$(grep -oE '(BEFORE_ALL|BEFORE_EACH|TEST_ALPHA|TEST_BETA|AFTER_EACH|AFTER_ALL)$' "$log" || true)
    expected=$(printf '%s\n' \
        BEFORE_ALL \
        BEFORE_EACH TEST_ALPHA AFTER_EACH \
        BEFORE_EACH TEST_BETA AFTER_EACH \
        AFTER_ALL)
    if [ "$actual" != "$expected" ]; then
        echo "[test]   hook/test ordering mismatch."
        echo "[test]   expected:"; printf '%s\n' "$expected" | sed 's/^/[test]     /'
        echo "[test]   actual:";   printf '%s\n' "$actual"   | sed 's/^/[test]     /'
        echo "[test]   full log:"; cat "$log"
        return 1
    fi

    # Both tests ran and the PASS count excludes the four hooks.
    if ! grep -q "all 2 tests passed" "$log"; then
        echo "[test]   expected 'all 2 tests passed' (hooks excluded from count):"
        cat "$log"
        return 1
    fi
    return 0
}

run_test "lifecycle hooks wrap tests in before_all/before_each/after_each/after_all order" test_hook_ordering

echo "[summary] $PASS passed, $FAIL failed"
if [ "$FAIL" -gt 0 ]; then
    exit 1
fi
