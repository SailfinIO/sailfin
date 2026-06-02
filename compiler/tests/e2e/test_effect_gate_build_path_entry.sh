#!/usr/bin/env bash
# End-to-end test for #984: on `-p` (`walk_project_src`) builds the
# entry module is staged but excluded from `resolved.sources`, so a
# sibling that imports an `![io]` function FROM THE ENTRY must still get
# the entry's `.sfn-asm` listed in its `.import-deps` sidecar and have
# `sibling→entry` effects enforced on the build path (E0402) — the same
# enforcement `sailfin check` already performs.
#
# Before #984, `_cr_stage_import_deps` resolved each source's import
# slugs against `resolved.sources` ONLY, which excludes the `-p` entry.
# An import of the entry resolved to no slug, the sibling's sidecar
# omitted the entry's `.sfn-asm`, and an under-declared `sibling→entry`
# call slipped past `make check`. #984 threads the staged entry into the
# slug-resolution universe (`compile_capsule_modules`'
# `slug_universe_extra`) so the sidecar lists the entry and the gate
# fires.
#
# This drives the real resolver via `sfn build -p .` on a synthetic
# binary capsule (mirroring `test_binary_capsule_walker.sh`), so the
# entry-staging + sidecar-resolution path is exercised exactly as in the
# compiler self-build.
#
# Fixtures (under a throwaway cwd):
#   src/main.sfn      — entry; exports `do_io() ![io]` plus `main()`.
#   src/util/sib.sfn  — sibling; imports `do_io` from the entry.
#                       Rewritten between the good and bad runs.
#
# Assertions:
#   - good sibling (`fn use_dep() ![io]`): the sibling's `.import-deps`
#     sidecar lists the entry's `.sfn-asm` (proves the staging fix).
#   - bad sibling (`fn use_dep()` — under-declared): `sfn build -p .`
#     emits E0402 on the build path (proves cross-module enforcement of
#     `sibling→entry` effects). Pre-fix, the same input instead produced
#     a "cannot resolve return type" lowering fatal — the entry's
#     `.sfn-asm` was never referenced — so asserting on E0402 cleanly
#     distinguishes fixed from unfixed.
#
# Note: this fixture's `main()` does NOT call the sibling, so the `-p`
# driver's module-drop leniency (a module whose emit fails is silently
# dropped from the link, cli_main.sfn) keeps the overall exit code at 0
# — we assert on the E0402 diagnostic, not the exit code. In the real
# compiler self-build every module IS linked, so the same E0402 breaks
# the link and genuinely fails `make check` (acceptance criterion 1).
#
# Usage:
#   compiler/tests/e2e/test_effect_gate_build_path_entry.sh <compiler-binary>

set -euo pipefail

BINARY="${1:?usage: test_effect_gate_build_path_entry.sh <compiler-binary>}"
BINARY="$(realpath "$BINARY")"
PASS=0
FAIL=0

SCRATCH="$(mktemp -d -t sfn-effect-entry-XXXXXX)"
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

mkdir -p "$SCRATCH/src/util"

cat > "$SCRATCH/capsule.toml" <<'EOF'
[capsule]
name = "effect-entry-test"
version = "0.1.0"
description = "E2E test for #984 sibling->entry build-path effect enforcement"

[capabilities]
required = ["io"]

[build]
kind = "binary"
entry = "src/main.sfn"
EOF

# Entry module: exports an `![io]` helper that siblings import. The
# `-p` walker excludes this file from `resolved.sources`; #984 re-adds
# it to the slug-resolution universe so dependents can reference it.
cat > "$SCRATCH/src/main.sfn" <<'EOF'
fn do_io() ![io] {
    print.info("entry side effect");
}

fn main() ![io] {
    print.info("entry-fixture-ok");
}

export { do_io };
EOF

# Helper: write the sibling with the given effect annotation on the
# function that calls the entry-exported `![io]` helper.
write_sib() {
    local effect_annot="$1"  # e.g. " ![io]" for the good case, "" for bad
    cat > "$SCRATCH/src/util/sib.sfn" <<EOF
import { do_io } from "../main";

fn use_dep()${effect_annot} {
    do_io();
}

export { use_dep };
EOF
}

# ---- Test 1: good sibling — its sidecar lists the entry's .sfn-asm ----
# This is the direct regression for the staging fix: before #984 the
# entry import resolved to no slug, leaving the sidecar without the
# entry reference. The sidecar is written before any emit, so it exists
# regardless of how the rest of the build resolves.
test_sidecar_lists_entry() {
    cd "$SCRATCH" || return 1
    rm -rf "$SCRATCH/build"
    write_sib " ![io]"
    "$BINARY" build -p . > "$SCRATCH/good.stdout" 2>&1 || true

    # `|| true`: under `set -euo pipefail` a missing build/ makes `find`
    # exit non-zero and pipefail would abort before the explicit empty
    # check below can report a useful diagnostic.
    local sidecar
    sidecar=$(find "$SCRATCH/build" -name '*sib*.import-deps' 2>/dev/null | head -n1 || true)
    if [ -z "$sidecar" ]; then
        echo "[test]   no sibling .import-deps sidecar found under build/" >&2
        find "$SCRATCH/build" -name '*.import-deps' >&2 2>/dev/null || true
        return 1
    fi
    # The entry slug ends in `main`; its staged artifact is `<...>main.sfn-asm`.
    if ! grep -q 'main\.sfn-asm' "$sidecar"; then
        echo "[test]   sibling sidecar does not reference the entry's .sfn-asm:" >&2
        echo "[test]   sidecar=$sidecar" >&2
        cat "$sidecar" >&2
        return 1
    fi
    return 0
}
run_test "sibling .import-deps lists the -p entry's .sfn-asm" test_sidecar_lists_entry

# ---- Test 2: under-declared sibling triggers E0402 on the build path ----
test_bad_sibling_e0402() {
    cd "$SCRATCH" || return 1
    rm -rf "$SCRATCH/build"
    write_sib ""  # use_dep() calls do_io() without declaring ![io]
    "$BINARY" build -p . > "$SCRATCH/bad.stdout" 2>&1 || true
    if ! grep -q "E0402" "$SCRATCH/bad.stdout"; then
        echo "[test]   expected E0402 on the build path; full output:" >&2
        cat "$SCRATCH/bad.stdout" >&2
        return 1
    fi
    return 0
}
run_test "build path emits E0402 for under-declared sibling->entry ![io]" test_bad_sibling_e0402

# ---- Summary ----
echo ""
echo "[test] $PASS passed, $FAIL failed"
[ "$FAIL" -eq 0 ]
