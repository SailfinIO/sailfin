#!/usr/bin/env bash
# Issue #1288 (Gap 1 of #1283): regression test for cross-module
# struct-returning calls between runtime sfn-sources.
#
# `_compile_runtime_sfn_sources` (compiler/src/cli_main.sfn) emits
# each `sfn-sources` entry in an isolated child `sfn emit`. Before
# #1288, no sibling sfn-source's `.sfn-asm` was staged into the
# import-context tree, so a runtime module importing a
# struct-returning fn from a sibling died during LLVM lowering with
#   "cannot resolve return type for call to `<fn>` — callee
#    signature is not known to the compiler"
# (core_call_emission.sfn). Pointer/i64 externs could be worked
# around with inline `extern fn`; a struct-by-value return cannot
# (E0805) — which is why #1217 had to inline a copy of ownedbuf.sfn
# into string.sfn. #1288 stages every sfn-source's `.sfn-asm` under a
# PRIVATE root (`<out_dir>/rt-import-context/<slug>.sfn-asm`), writes
# per-module `.import-deps` sidecars for sibling imports, and threads
# the root into each child emit via `--import-context` (the #957/#999
# mechanism), so sibling signatures resolve without publishing
# anything into the shared cwd `build/native/import-context/` tree.
# (Publishing there regresses every other emit in the cwd: the
# prelude imports the runtime modules, and staged runtime artifacts
# make its lowering render imported-signature declares that conflict
# with its runtime-helper descriptor declares — clang then rejects
# the prelude IR with "invalid redefinition".)
#
# The test (scaffolding modeled on
# `test_runtime_sfn_sources_link_consumer.sh`):
#   1. Builds a scratch workspace whose runtime capsule declares two
#      synthetic sfn-sources: `structlib.sfn` (defines struct Pair +
#      struct-returning pair_new/pair_shift) and `structuse.sfn`
#      (imports them across the module boundary and wraps the result
#      in an i64-returning probe fn).
#   2. Runs `sfn build -p capsules/sfn/test-app`; the app calls the
#      probe via a plain i64 extern and prints a marker.
#   3. Asserts the build succeeds (it fails with the lowering fatal
#      before #1288).
#   4. Asserts the staged import-context artifacts exist.
#   5. Asserts the consumer module's .ll resolved the imported
#      signatures as `%Pair` (not a defaulted i8*).
#   6. Runs the produced binary and asserts the probe value
#      round-tripped through the cross-module struct returns.
#   7. Asserts SAILFIN_DISABLE_RUNTIME_SFN_SOURCES=1 stages nothing.

set -euo pipefail

BINARY="${1:?usage: test_runtime_sfn_sources_struct_import.sh <compiler-binary>}"
BINARY="$(realpath "$BINARY")"
PASS=0
FAIL=0
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"

SCRATCH="$(mktemp -d -t sfn-rtsrc-struct-XXXXXX)"
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

setup_workspace() {
    local ws="$1"
    rm -rf "$ws"
    mkdir -p "$ws/runtime/native"
    mkdir -p "$ws/runtime/sfn/platform" "$ws/runtime/sfn/memory"
    mkdir -p "$ws/capsules/sfn/test-app/src"

    cat > "$ws/workspace.toml" <<EOF
[workspace]
members = ["runtime/native", "capsules/sfn/test-app"]
EOF

    # Runtime capsule manifest. Mirrors the link-consumer test's
    # dependency list (the real modules the prelude/link require)
    # plus the two synthetic modules under test. structlib must be
    # listed so its definitions link; structuse is the importing
    # consumer whose emit exercises the staged sibling context.
    cat > "$ws/runtime/native/capsule.toml" <<'EOF'
[capsule]
name = "sfn/runtime-native"
version = "0.0.1"

[capabilities]
required = []

[build]
kind = "runtime"
# Same shape as test_runtime_sfn_sources_link_consumer.sh's manifest
# (see that file for why each real runtime module is required at
# link time). The interesting entries are structlib/structuse.
# arena.sfn + ownedbuf.sfn are required because string.sfn now imports
# `./memory/ownedbuf` (#1289): ownedbuf.sfn so string's emit resolves
# the cross-module struct-returning call, arena.sfn so ownedbuf's
# `sfn_arena_sfn_*` externs resolve at link.
c-sources = []
ll-sources = ["ir/runtime_globals.ll"]
sfn-sources = ["../sfn/structlib.sfn", "../sfn/structuse.sfn", "../sfn/clock.sfn", "../sfn/exception.sfn", "../sfn/type_meta.sfn", "../sfn/io.sfn", "../sfn/memory/arena.sfn", "../sfn/memory/ownedbuf.sfn", "../sfn/string.sfn", "../sfn/array.sfn", "../sfn/memory/mem.sfn"]
include-dirs = ["include"]
link-libs = ["-lm"]
prelude-entry = "../prelude.sfn"
EOF

    # Mirror the repo's runtime/native tree + the real runtime
    # modules the manifest references (symlinks, no copies).
    ln -s "$REPO_ROOT/runtime/native/src" "$ws/runtime/native/src"
    ln -s "$REPO_ROOT/runtime/native/include" "$ws/runtime/native/include"
    ln -s "$REPO_ROOT/runtime/native/ir" "$ws/runtime/native/ir"
    ln -s "$REPO_ROOT/runtime/prelude.sfn" "$ws/runtime/prelude.sfn"
    ln -s "$REPO_ROOT/runtime/sfn/clock.sfn" "$ws/runtime/sfn/clock.sfn"
    ln -s "$REPO_ROOT/runtime/sfn/exception.sfn" "$ws/runtime/sfn/exception.sfn"
    ln -s "$REPO_ROOT/runtime/sfn/type_meta.sfn" "$ws/runtime/sfn/type_meta.sfn"
    ln -s "$REPO_ROOT/runtime/sfn/io.sfn" "$ws/runtime/sfn/io.sfn"
    ln -s "$REPO_ROOT/runtime/sfn/string.sfn" "$ws/runtime/sfn/string.sfn"
    ln -s "$REPO_ROOT/runtime/sfn/array.sfn" "$ws/runtime/sfn/array.sfn"
    ln -s "$REPO_ROOT/runtime/sfn/memory/mem.sfn" "$ws/runtime/sfn/memory/mem.sfn"
    # #1289 — string.sfn imports `./memory/ownedbuf`; ownedbuf's inline
    # `sfn_arena_sfn_*` externs resolve to arena.sfn at link. Both must
    # be on disk for the emit + link to succeed.
    ln -s "$REPO_ROOT/runtime/sfn/memory/arena.sfn" "$ws/runtime/sfn/memory/arena.sfn"
    ln -s "$REPO_ROOT/runtime/sfn/memory/ownedbuf.sfn" "$ws/runtime/sfn/memory/ownedbuf.sfn"
    ln -s "$REPO_ROOT/runtime/sfn/platform/posix.sfn" "$ws/runtime/sfn/platform/posix.sfn"
    ln -s "$REPO_ROOT/runtime/sfn/platform/libc.sfn" "$ws/runtime/sfn/platform/libc.sfn"

    # The struct-defining sibling. Returned by value across the
    # module boundary — the case an inline `extern fn` cannot
    # express (E0805).
    cat > "$ws/runtime/sfn/structlib.sfn" <<'EOF'
// Synthetic runtime sfn-source for
// `test_runtime_sfn_sources_struct_import.sh`: defines a struct and
// struct-returning constructors, imported by structuse.sfn.
struct Pair {
    a: i64;
    b: i64;
}

fn pair_new(a: i64, b: i64) -> Pair {
    return Pair { a: a, b: b };
}

fn pair_shift(p: Pair, d: i64) -> Pair {
    return Pair { a: p.a + d, b: p.b + d };
}
EOF

    # The importing consumer. Before #1288 its llvm emit dies with
    # "cannot resolve return type for call to `pair_new`".
    cat > "$ws/runtime/sfn/structuse.sfn" <<'EOF'
// Synthetic runtime sfn-source for
// `test_runtime_sfn_sources_struct_import.sh`: makes cross-module
// struct-returning calls into structlib.sfn and exposes an
// i64-returning probe the app can reach via a plain extern.
import { Pair, pair_new, pair_shift } from "./structlib";

fn rt_struct_probe() -> i64 {
    let p = pair_new(40, 2);
    let q = pair_shift(p, 1);
    return q.a * 100 + q.b;
}
EOF

    cat > "$ws/capsules/sfn/test-app/capsule.toml" <<EOF
[capsule]
name = "sfn/test-app"
version = "0.0.1"

[capabilities]
required = ["io"]

[build]
kind = "binary"
entry = "src/main.sfn"

[dependencies]
"sfn/runtime-native" = "*"
EOF

    # pair_new(40,2) shifted by 1 → {41,3} → 41*100+3 = 4103.
    cat > "$ws/capsules/sfn/test-app/src/main.sfn" <<'EOF'
extern fn rt_struct_probe() -> i64;

fn main() ![io] {
    let probe = rt_struct_probe();
    if probe == 4103 {
        print.info("struct-roundtrip-ok");
    } else {
        print.info("struct-roundtrip-bad");
    }
}
EOF
}

build_scratch_app() {
    local ws="$1"
    local log="$2"
    local extra_env="${3:-}"
    local rc=0
    (cd "$ws" && env $extra_env "$BINARY" build -p capsules/sfn/test-app > "$log" 2>&1) || rc=$?
    return $rc
}

test_struct_import_builds_and_roundtrips() {
    local ws="$SCRATCH/ws-positive"
    setup_workspace "$ws"
    local log="$SCRATCH/ws-positive.log"
    if ! build_scratch_app "$ws" "$log"; then
        echo "[test]   sfn build failed for the synthetic workspace:"
        if grep -q "cannot resolve return type" "$log"; then
            echo "[test]   (the pre-#1288 'cannot resolve return type' fatal — sibling"
            echo "[test]    import-context staging did not happen)"
        fi
        tail -40 "$log"
        return 1
    fi

    # Staged private import-context artifacts for the synthetic
    # modules. Deliberately NOT under build/native/import-context —
    # see the header comment for the prelude-regression rationale.
    local ctx="$ws/build/sailfin/rt-import-context/runtime/sfn"
    for f in structlib.sfn-asm structuse.sfn-asm structuse.import-deps; do
        if [ ! -f "$ctx/$f" ]; then
            echo "[test]   expected staged import-context artifact missing: $ctx/$f"
            ls -R "$ws/build/sailfin/rt-import-context" 2>/dev/null | head -30
            return 1
        fi
    done
    # The consumer's deps sidecar must point at the staged sibling asm.
    if ! grep -q "rt-import-context/runtime/sfn/structlib.sfn-asm" "$ctx/structuse.import-deps"; then
        echo "[test]   structuse.import-deps does not reference structlib.sfn-asm:"
        cat "$ctx/structuse.import-deps"
        return 1
    fi
    # The defining module has no sibling imports → no deps sidecar.
    if [ -f "$ctx/structlib.import-deps" ]; then
        echo "[test]   structlib unexpectedly has an .import-deps sidecar:"
        cat "$ctx/structlib.import-deps"
        return 1
    fi
    # Nothing may leak into the SHARED cwd-relative import-context
    # tree (the prelude-regression vector).
    if ls "$ws/build/native/import-context/runtime/sfn/"*.sfn-asm >/dev/null 2>&1; then
        echo "[test]   runtime sfn-source artifacts leaked into the shared tree:"
        ls "$ws/build/native/import-context/runtime/sfn/" | head -10
        return 1
    fi

    # The consumer's emitted IR resolved the imported callees with the
    # real %Pair signature (a defaulted signature would be i8*).
    local use_ll="$ws/build/sailfin/sfn__runtime-native__structuse.sfn-O2.ll"
    if [ ! -f "$use_ll" ]; then
        echo "[test]   expected consumer .ll missing: $use_ll"
        ls "$ws/build/sailfin/" 2>/dev/null | head -20
        return 1
    fi
    if ! grep -qE "call %Pair\*? @pair_new" "$use_ll"; then
        echo "[test]   structuse.ll did not resolve pair_new as %Pair-returning:"
        grep -E "pair_new|pair_shift" "$use_ll" | head -10
        return 1
    fi

    # End-to-end: the values survive the cross-module struct returns.
    local app_bin="$ws/build/capsules/sfn/test-app/bin/test-app"
    if [ ! -x "$app_bin" ]; then
        echo "[test]   expected app binary missing: $app_bin"
        find "$ws/build" -name 'test-app*' -type f 2>/dev/null | head -10
        return 1
    fi
    local out
    out="$("$app_bin" 2>&1)" || {
        echo "[test]   app binary exited non-zero; output:"
        printf '%s\n' "$out"
        return 1
    }
    if ! printf '%s\n' "$out" | grep -q "struct-roundtrip-ok"; then
        echo "[test]   app output did not contain struct-roundtrip-ok:"
        printf '%s\n' "$out"
        return 1
    fi
    return 0
}

test_disable_gate_skips_staging() {
    local ws="$SCRATCH/ws-disabled"
    setup_workspace "$ws"
    local log="$SCRATCH/ws-disabled.log"
    # The gated build is expected to fail (see the link-consumer
    # test: post-#397 the prelude needs sfn-source symbols). This
    # test only pins that the gate also short-circuits the #1288
    # staging pass — no import-context artifacts for sfn-sources.
    build_scratch_app "$ws" "$log" "SAILFIN_DISABLE_RUNTIME_SFN_SOURCES=1" || true
    if [ -d "$ws/build/sailfin/rt-import-context" ]; then
        echo "[test]   disable gate did NOT skip import-context staging:"
        find "$ws/build/sailfin/rt-import-context" -type f 2>/dev/null | head -10
        return 1
    fi
    return 0
}

run_test "runtime sfn-source struct import builds, stages context, and round-trips" \
    test_struct_import_builds_and_roundtrips
run_test "SAILFIN_DISABLE_RUNTIME_SFN_SOURCES skips import-context staging" \
    test_disable_gate_skips_staging

echo ""
echo "[test] results: $PASS passed, $FAIL failed"
[ "$FAIL" -eq 0 ]
