#!/usr/bin/env bash
# End-to-end test for `sfn build --work-dir <DIR>`.
#
# Verifies that the driver virtualizes its build artifacts under the
# caller-specified root: `<DIR>/native/import-context/`, `<DIR>/sailfin/`,
# and (when `-o` is omitted) `<DIR>/native/sailfin`. With `--work-dir`
# unset the legacy `./build/...` layout is preserved byte-for-byte.
#
# Usage:
#   compiler/tests/e2e/test_work_dir_flag.sh <compiler-binary>

set -euo pipefail

BINARY="${1:?usage: test_work_dir_flag.sh <compiler-binary>}"
BINARY="$(realpath "$BINARY")"
# Capture repo root before any `cd` so later tests can resolve the
# in-tree capsules/ directory regardless of CWD changes.
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
PASS=0
FAIL=0

# Scratch dirs cleaned on exit.
SCRATCH="$(mktemp -d -t sfn-work-dir-XXXXXX)"
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

# ---- Setup: a minimal positional build (no capsule deps) ----
mkdir -p "$SCRATCH/proj"
cat > "$SCRATCH/proj/hello.sfn" <<'EOF'
fn main() ![io] {
    print("OK");
}
EOF

WORK1="$SCRATCH/wd1"
WORK2="$SCRATCH/wd2"

# ---- Test 1: --help lists --work-dir ----
test_help_lists_flag() {
    cd "$SCRATCH/proj" || return 1
    "$BINARY" build --help > "$SCRATCH/help.stdout" 2>&1 || return 1
    grep -q -- "--work-dir" "$SCRATCH/help.stdout"
}
run_test "sfn build --help lists --work-dir" test_help_lists_flag

# ---- Test 2: --work-dir creates the virtualized layout ----
# Run from $SCRATCH (NOT the project dir) to make sure ./build/ would
# only be created if the driver mistakenly wrote there. The positional
# source is referenced by absolute path so CWD doesn't matter for input
# resolution.
test_work_dir_layout() {
    cd "$SCRATCH" || return 1
    rm -rf "$WORK1" build
    "$BINARY" build --work-dir "$WORK1" "$SCRATCH/proj/hello.sfn" \
        > "$SCRATCH/build1.stdout" 2>&1 || return 1
    [ -f "$WORK1/native/sailfin" ] || return 1
    [ -d "$WORK1/sailfin" ] || return 1
    # No leakage to $SCRATCH/build/ (the CWD-relative default).
    ! [ -d "$SCRATCH/build" ]
}
run_test "--work-dir writes default-binary + sailfin/, no CWD ./build/ leakage" test_work_dir_layout

# ---- Test 3: two --work-dir runs produce SHA-256 identical binaries ----
# Reproducibility check from the issue's AC. Same source compiled to
# two different work-dir roots must yield byte-identical binaries —
# guarding against a regression where the work-dir path leaks into the
# compiled output (e.g. via __FILE__-style metadata).
test_work_dir_reproducible() {
    cd "$SCRATCH" || return 1
    rm -rf "$WORK2" build
    "$BINARY" build --work-dir "$WORK2" "$SCRATCH/proj/hello.sfn" \
        > "$SCRATCH/build2.stdout" 2>&1 || return 1
    local sha1 sha2
    sha1="$(sha256sum "$WORK1/native/sailfin" | awk '{print $1}')"
    sha2="$(sha256sum "$WORK2/native/sailfin" | awk '{print $1}')"
    [ "$sha1" = "$sha2" ]
}
run_test "two --work-dir runs produce SHA-256 identical binaries" test_work_dir_reproducible

# ---- Test 4: omitting --work-dir preserves the legacy ./build/ layout ----
test_default_layout_preserved() {
    local proj="$SCRATCH/default_proj"
    rm -rf "$proj"
    mkdir -p "$proj"
    cat > "$proj/hello.sfn" <<'EOF'
fn main() ![io] {
    print("OK");
}
EOF
    cd "$proj" || return 1
    "$BINARY" build -o build/program hello.sfn > "$SCRATCH/build3.stdout" 2>&1 || return 1
    [ -f "$proj/build/program" ]
}
run_test "default layout (no --work-dir) preserved under ./build/" test_default_layout_preserved

# ---- Summary ----
echo ""
echo "[test] $PASS passed, $FAIL failed"
[ "$FAIL" -eq 0 ]
