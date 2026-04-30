#!/usr/bin/env bash
# End-to-end test for the Stage D PR3 binary-capsule src/ walker.
#
# When `sfn build -p <project>` resolves a `kind = "binary"` capsule,
# the resolver opts into `enumerate_binary_capsule_sources` (see
# `compiler/src/capsule_resolver.sfn`) which walks
# `<project_root>/src/**/*.sfn` directly instead of relying on
# transitive relative-import discovery from `[build] entry`. That
# closes the gap that previously left source files unreachable from
# the entry out of the link — most prominently the compiler's own
# `cli_main.sfn` is not imported from `main.sfn` and would otherwise
# never be compiled by `sfn build -p compiler`.
#
# This test verifies the property in miniature on a synthetic
# `kind = "binary"` fixture: a `main.sfn` plus an unimported
# sibling under `src/util/`. The full `sfn build -p compiler`
# self-host is NOT exercised here — it costs ~6 minutes cold and
# is verified manually before each Stage D PR; running it from a
# unit-suite-tier e2e test would dominate CI wall time. The
# fixture-level coverage is the bug-shape the walker has to
# close; the compiler self-build is just a larger instance of it.
#
# Usage:
#   compiler/tests/e2e/test_binary_capsule_walker.sh <compiler-binary>

set -euo pipefail

BINARY="${1:?usage: test_binary_capsule_walker.sh <compiler-binary>}"
BINARY="$(realpath "$BINARY")"
PASS=0
FAIL=0

# Scratch dir for the test project. Cleaned on exit.
SCRATCH="$(mktemp -d -t sfn-binary-walker-XXXXXX)"
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

# ---- Setup: a binary capsule with a sibling module the entry never imports ----
# Uses two source files where `main.sfn` does NOT import
# `util/orphan.sfn`. The relative-import walker on its own would
# leave `orphan.sfn` out of the resolver's source list. The binary-
# capsule walker is what surfaces it, so the artifact-dir check below
# is the unambiguous regression for this PR.
#
# `main.sfn` is intentionally self-contained so the link succeeds
# without exercising the cross-module symbol mangling that has its
# own slug-shape concerns for fixtures outside `compiler/src/`. PR3
# is a resolver/enumeration change; symbol mangling in non-compiler
# project trees is a separate concern.
mkdir -p "$SCRATCH/src/util"

cat > "$SCRATCH/capsule.toml" <<'EOF'
[capsule]
name = "binary-walker-test"
version = "0.1.0"
description = "E2E test for the Stage D PR3 binary-capsule src/ walker"

[capabilities]
required = ["io"]

[build]
kind = "binary"
entry = "src/main.sfn"
EOF

cat > "$SCRATCH/src/main.sfn" <<'EOF'
fn main() ![io] {
    print("walker-fixture-ok");
}
EOF

# Sibling module the entry never reaches. The walker MUST discover
# it; the relative-import walker (driven from `main.sfn`) will not,
# because `main.sfn` doesn't import anything.
cat > "$SCRATCH/src/util/orphan.sfn" <<'EOF'
export { orphan_helper };

fn orphan_helper() -> string {
    return "orphan-from-walker";
}
EOF

# ---- Test 1: sfn build -p succeeds on the binary fixture ----
test_build_succeeds() {
    cd "$SCRATCH" || return 1
    local rc
    "$BINARY" build -p . > "$SCRATCH/build.stdout" 2>&1
    rc=$?
    if [ "$rc" -ne 0 ]; then
        echo "[test]   sfn build -p . exited with code $rc; output:" >&2
        cat "$SCRATCH/build.stdout" >&2
    fi
    return $rc
}
run_test "sfn build -p . completes for a binary capsule" test_build_succeeds

# ---- Test 2: the produced binary runs and emits the expected greeting ----
test_binary_runs() {
    cd "$SCRATCH" || return 1
    local exe="$SCRATCH/build/sailfin/program"
    [ -x "$exe" ] || return 1
    local rc
    "$exe" > "$SCRATCH/program.stdout" 2>&1
    rc=$?
    if [ "$rc" -ne 0 ]; then
        echo "[test]   binary exited with code $rc; output:" >&2
        cat "$SCRATCH/program.stdout" >&2
        return 1
    fi
    grep -q "^walker-fixture-ok$" "$SCRATCH/program.stdout"
}
run_test "binary links and runs" test_binary_runs

# ---- Test 3: walker picked up the orphaned sibling not reachable from the entry ----
# The fixture's `[capsule].name` ("binary-walker-test") is not in
# scope/name form, so dep `.ll`s land under the legacy flat layout
# (`build/sailfin/capsules/<mangled>.ll`) — see `_cr_legacy_ll_path`.
# The slug for `<scratch>/src/util/orphan.sfn` is path-shaped
# (`module_name_from_path` only strips `compiler/src/` and `runtime/`
# prefixes), so the mangled filename ends in `__src__util__orphan.ll`.
# Anchor on the suffix to keep the assertion stable across mktemp
# directory names.
test_orphan_compiled() {
    cd "$SCRATCH" || return 1
    local count
    count=$(find "$SCRATCH/build/sailfin/capsules" -maxdepth 1 -name "*src__util__orphan.ll" 2>/dev/null | wc -l | tr -d ' ')
    if [ "$count" != "1" ]; then
        echo "[test]   expected exactly 1 orphan .ll under build/sailfin/capsules; found $count" >&2
        ls "$SCRATCH/build/sailfin/capsules" >&2 2>/dev/null || true
        return 1
    fi
    return 0
}
run_test "walker enumerated the unimported sibling module" test_orphan_compiled

# ---- Test 4: positional build (no -p) does NOT walk src/ ----
# The walker is opt-in through `ResolverConsumer.walk_project_src`,
# which only flips on for `-p` builds of `kind = "binary"` capsules.
# A positional `sfn build src/main.sfn` should NOT enumerate the
# orphan, because the relative-import walker driven from `main.sfn`
# can't reach it. This guards against the walker silently flipping
# on for end-user positional builds (where the legacy entry-driven
# enumeration is the contract).
test_positional_skips_walker() {
    cd "$SCRATCH" || return 1
    rm -rf "$SCRATCH/build"
    "$BINARY" build src/main.sfn > "$SCRATCH/positional.stdout" 2>&1 || true
    # If the walker fired, orphan.ll would be under capsules/. With
    # the walker correctly gated, the capsules/ dir is empty (or
    # absent — main.sfn imports nothing).
    local count=0
    if [ -d "$SCRATCH/build/sailfin/capsules" ]; then
        count=$(find "$SCRATCH/build/sailfin/capsules" -maxdepth 1 -name "*orphan.ll" 2>/dev/null | wc -l | tr -d ' ')
    fi
    if [ "$count" != "0" ]; then
        echo "[test]   positional build unexpectedly enumerated orphan; walker should be -p-only" >&2
        return 1
    fi
    return 0
}
run_test "positional build does not trigger the binary-capsule walker" test_positional_skips_walker

# ---- Summary ----
echo ""
echo "[test] $PASS passed, $FAIL failed"
[ "$FAIL" -eq 0 ]
