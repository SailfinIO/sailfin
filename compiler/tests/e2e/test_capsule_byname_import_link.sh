#!/usr/bin/env bash
# Regression test for issue #873: by-name capsule import link parity.
#
# A program that imports a workspace capsule *by name*
# (`import { f } from "sfn/crypto"`) must link: the importer-side
# mangled symbol must match the symbol the compiled capsule object
# actually defines. The original bug (#873, observed during #816) had
# the call site resolve the callee via the `[capsule].name`-based slug
# (`sfn/crypto/mod` -> `sha256_hex__sfn__crypto__mod`) while the capsule
# source was compiled under a different slug
# (`capsules/sfn/crypto/src/mod` -> `sha256_hex__capsules__sfn__crypto__src__mod`),
# so the link failed with `undefined reference`.
#
# Capsule *tests* dodge this by using relative imports
# (`from "../src/mod"`); this test deliberately exercises the by-name
# path that they don't cover.
#
# Usage:
#   compiler/tests/e2e/test_capsule_byname_import_link.sh <compiler-binary>

set -uo pipefail

BINARY="${1:?usage: test_capsule_byname_import_link.sh <compiler-binary>}"
BINARY="$(realpath "$BINARY")"
PASS=0
FAIL=0

# Scratch dir for the test project. Cleaned on exit.
SCRATCH="$(mktemp -d -t sfn-byname-link-XXXXXX)"
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

# ---- Setup: minimal project declaring sfn/crypto as a dep ----
mkdir -p "$SCRATCH/src"

# Link (rather than copy) the in-tree capsules/ dir so the resolver's
# in-tree lookup finds sfn/crypto without needing the user cache.
ln -s "$REPO_ROOT/capsules" "$SCRATCH/capsules"

cat > "$SCRATCH/capsule.toml" <<'EOF'
[capsule]
name = "byname-link-test"
version = "0.1.0"
description = "E2E regression for #873 by-name capsule import linking"

[dependencies]
"sfn/crypto" = "0.3.0"

[capabilities]
required = ["io"]

[build]
entry = "src/main.sfn"
EOF

# Import the crypto capsule *by name* (not by relative path) — this is
# the path that #873 reported broken.
cat > "$SCRATCH/src/main.sfn" <<'EOF'
import { sha256_hex } from "sfn/crypto";

fn main() -> int ![io] {
    // sha256("abc") is a well-known fixed digest. Printing the exact
    // expected value lets the shell test assert correctness, not just
    // a non-crashing run.
    print.info(sha256_hex("abc"));
    return 0;
}
EOF

# Known-answer: SHA-256 of the ASCII string "abc".
EXPECTED="ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad"

# ---- Test 1: by-name import builds with no link error ----
test_build_succeeds() {
    cd "$SCRATCH" || return 1
    local rc
    "$BINARY" build -o build/program src/main.sfn > "$SCRATCH/build.stdout" 2>&1
    rc=$?
    if [ "$rc" -ne 0 ]; then
        echo "[test]   sfn build exited with code $rc; output:" >&2
        cat "$SCRATCH/build.stdout" >&2
        return 1
    fi
    # Guard the exact #873 symptom: a slug mismatch surfaces as an
    # `undefined reference` from the linker even when the compile
    # itself "succeeds" up to the link step.
    if grep -qi "undefined reference" "$SCRATCH/build.stdout"; then
        echo "[test]   linker reported an undefined reference:" >&2
        grep -i "undefined reference" "$SCRATCH/build.stdout" >&2
        return 1
    fi
    return 0
}
run_test "by-name capsule import builds with no undefined reference" test_build_succeeds

# ---- Test 2: the linked binary runs and prints the right digest ----
test_binary_runs() {
    cd "$SCRATCH" || return 1
    [ -x "build/program" ] || return 1
    local rc
    "$SCRATCH/build/program" > "$SCRATCH/program.stdout" 2>&1
    rc=$?
    if [ "$rc" -ne 0 ]; then
        echo "[test]   binary exited with code $rc; output:" >&2
        cat "$SCRATCH/program.stdout" >&2
        return 1
    fi
    if ! grep -q "$EXPECTED" "$SCRATCH/program.stdout"; then
        echo "[test]   expected digest $EXPECTED not found; output:" >&2
        cat "$SCRATCH/program.stdout" >&2
        return 1
    fi
    return 0
}
run_test "by-name capsule binary links and runs the capsule symbol" test_binary_runs

# ---- Test 3: capsule was staged + compiled under the spec slug ----
# Both the importer's call-site slug and the capsule-source compile slug
# must agree on `sfn/crypto/mod`; the staged artifacts living under that
# spec-shaped path (not a `capsules/sfn/crypto/src/...` path slug) is the
# structural witness that the two resolution paths reconciled.
test_staged_under_spec_slug() {
    cd "$SCRATCH" || return 1
    [ -f "build/native/import-context/sfn/crypto/mod.sfn-asm" ] || return 1
    [ -f "build/capsules/sfn/crypto/ir/mod.ll" ] || return 1
    return 0
}
run_test "capsule staged + compiled under the spec slug (sfn/crypto/mod)" test_staged_under_spec_slug

# ---- Summary ----
echo ""
echo "[test] $PASS passed, $FAIL failed"
[ "$FAIL" -eq 0 ]
