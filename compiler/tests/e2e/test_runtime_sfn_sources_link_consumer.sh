#!/usr/bin/env bash
# Issue #308: regression test for `_compile_runtime_sfn_sources` in
# `compiler/src/cli_main.sfn`. Pins that the dormant link-time
# consumer of `RuntimeCapsuleArtifacts.sfn_sources` actually fires
# when a manifest declares the field, produces a cached `.o`, and
# threads it into the final link.
#
# PR #310 added the consumer but did not flip
# `runtime/native/capsule.toml` to populate `sfn-sources` (that
# happens in PR B of the sleep migration). Without this test, a
# regression in self-path resolution, cache naming, the child
# `sfn emit` invocation, or `clang -c` would stay invisible
# until PR B activates the active manifest. This test exercises
# the path against a synthetic workspace that declares the field
# explicitly.
#
# The test:
#   1. Builds a scratch workspace under a tmp dir with:
#      - workspace.toml listing two members
#      - runtime/native/capsule.toml: kind=runtime, declares
#        sfn-sources = ["../sfn/test_marker.sfn"], plus the
#        c-sources/include-dirs the link path requires
#      - runtime/sfn/test_marker.sfn: a tiny module exporting
#        a marker symbol
#      - capsules/sfn/test-app: kind=binary, depends on the
#        runtime capsule, has a one-line main.sfn
#   2. Runs `sfn build -p capsules/sfn/test-app` against it.
#   3. Asserts the build succeeded.
#   4. Asserts `_compile_runtime_sfn_sources` produced the
#      expected cached .o under the build's cache dir
#      (capsule_prefix + basename + opt_flag + ".o").
#   5. Asserts SAILFIN_DISABLE_RUNTIME_SFN_SOURCES=1 short-circuits
#      the consumer (no .o produced).

set -euo pipefail

BINARY="${1:?usage: test_runtime_sfn_sources_link_consumer.sh <compiler-binary>}"
BINARY="$(realpath "$BINARY")"
PASS=0
FAIL=0
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"

SCRATCH="$(mktemp -d -t sfn-rtsrc-link-XXXXXX)"
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
    mkdir -p "$ws/runtime/native/src" "$ws/runtime/native/include" "$ws/runtime/native/ir"
    mkdir -p "$ws/runtime/sfn"
    mkdir -p "$ws/capsules/sfn/test-app/src"

    cat > "$ws/workspace.toml" <<EOF
[workspace]
members = ["runtime/native", "capsules/sfn/test-app"]
EOF

    # Runtime capsule manifest — points c-sources/ll-sources at the
    # repo's real runtime so the link can satisfy prelude/runtime
    # symbol references. The interesting field is sfn-sources,
    # which the consumer under test materializes into a .o.
    cat > "$ws/runtime/native/capsule.toml" <<'EOF'
[capsule]
name = "sfn/runtime-native"
version = "0.0.1"

[capabilities]
required = []

[build]
kind = "runtime"
# Intentionally omit native_driver.c — it defines `main` for the
# compiler binary itself and would conflict with the consumer's
# `main()`. The remaining c-sources cover arena, runtime helpers,
# crypto, and base64 — enough to satisfy the link without an
# entry-point clash.
c-sources = ["src/sailfin_arena.c", "src/sailfin_runtime.c", "src/sailfin_sha256.c", "src/sailfin_base64.c"]
ll-sources = ["ir/runtime_globals.ll"]
sfn-sources = ["../sfn/test_marker.sfn"]
include-dirs = ["include"]
link-libs = ["-lm"]
prelude-entry = "../prelude.sfn"
EOF

    # Mirror the repo's runtime/native tree into the scratch
    # workspace so the c-sources resolve. Cheap symlinks keep
    # this tiny — no copies.
    rm -rf "$ws/runtime/native/src" "$ws/runtime/native/include" "$ws/runtime/native/ir"
    ln -s "$REPO_ROOT/runtime/native/src" "$ws/runtime/native/src"
    ln -s "$REPO_ROOT/runtime/native/include" "$ws/runtime/native/include"
    ln -s "$REPO_ROOT/runtime/native/ir" "$ws/runtime/native/ir"

    # Mirror prelude.sfn (the runtime capsule's prelude-entry).
    ln -s "$REPO_ROOT/runtime/prelude.sfn" "$ws/runtime/prelude.sfn"

    # The sfn-source under test. Tiny self-contained module.
    cat > "$ws/runtime/sfn/test_marker.sfn" <<'EOF'
// Synthetic runtime sfn-source used by
// `compiler/tests/e2e/test_runtime_sfn_sources_link_consumer.sh`.
// Exists solely to be picked up by `_compile_runtime_sfn_sources`
// and produce a cached .o; the consumer doesn't call into it.
fn rt_test_marker() -> i64 ![io] {
    return 42;
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

    cat > "$ws/capsules/sfn/test-app/src/main.sfn" <<'EOF'
fn main() ![io] {
    print.info("test-app");
}
EOF
}

# Helper: run sfn build inside the scratch workspace.
build_scratch_app() {
    local ws="$1"
    local log="$2"
    local extra_env="${3:-}"
    local rc=0
    (cd "$ws" && env $extra_env "$BINARY" build -p capsules/sfn/test-app > "$log" 2>&1) || rc=$?
    return $rc
}

test_consumer_fires_and_produces_object() {
    local ws="$SCRATCH/ws-positive"
    setup_workspace "$ws"
    local log="$SCRATCH/ws-positive.log"
    if ! build_scratch_app "$ws" "$log"; then
        echo "[test]   sfn build failed for the synthetic workspace:"
        tail -40 "$log"
        return 1
    fi
    # The cached .o lives under the build's cache_dir
    # (`<workspace>/build/sailfin`) keyed by capsule prefix +
    # basename + opt_flag. For our manifest:
    #   capsule_name = "sfn/runtime-native"
    #   _runtime_obj_prefix => "sfn__runtime-native__"
    #   basename(test_marker.sfn) = "test_marker.sfn"
    #   opt_flag = "-O2"
    local expected_o="$ws/build/sailfin/sfn__runtime-native__test_marker.sfn-O2.o"
    local expected_ll="$ws/build/sailfin/sfn__runtime-native__test_marker.sfn-O2.ll"
    if [ ! -f "$expected_ll" ]; then
        echo "[test]   expected cached .ll missing: $expected_ll"
        echo "[test]   files in build/sailfin/:"
        ls "$ws/build/sailfin/" 2>/dev/null | head -20
        return 1
    fi
    if [ ! -f "$expected_o" ]; then
        echo "[test]   expected cached .o missing: $expected_o"
        echo "[test]   files in build/sailfin/:"
        ls "$ws/build/sailfin/" 2>/dev/null | head -20
        return 1
    fi
    return 0
}

test_disable_gate_skips_consumer() {
    local ws="$SCRATCH/ws-disabled"
    setup_workspace "$ws"
    local log="$SCRATCH/ws-disabled.log"
    if ! build_scratch_app "$ws" "$log" "SAILFIN_DISABLE_RUNTIME_SFN_SOURCES=1"; then
        echo "[test]   sfn build with disable gate failed (it should still succeed):"
        tail -40 "$log"
        return 1
    fi
    local expected_o="$ws/build/sailfin/sfn__runtime-native__test_marker.sfn-O2.o"
    if [ -f "$expected_o" ]; then
        echo "[test]   disable gate did NOT skip the consumer; .o was produced anyway:"
        echo "[test]   $expected_o"
        return 1
    fi
    return 0
}

test_self_path_resolves_via_binary_dir() {
    # The consumer threads `binary_dir` from the CLI plumbing. When
    # we invoke the binary directly (no --binary-dir flag), the
    # native driver's argv parsing computes binary_dir from argv[0]
    # — verify a symlinked binary still resolves correctly. This
    # exercises the cross-platform path that's load-bearing on
    # macOS where `/proc/self/exe` doesn't exist.
    local ws="$SCRATCH/ws-binary-dir"
    setup_workspace "$ws"
    local log="$SCRATCH/ws-binary-dir.log"
    # Symlink the binary into a fresh dir; invoke through the symlink.
    local symlink_dir="$SCRATCH/symlinked-bin"
    mkdir -p "$symlink_dir"
    ln -sf "$BINARY" "$symlink_dir/sailfin"
    local rc=0
    (cd "$ws" && "$symlink_dir/sailfin" build -p capsules/sfn/test-app > "$log" 2>&1) || rc=$?
    if [ "$rc" -ne 0 ]; then
        echo "[test]   sfn build via symlinked binary failed:"
        tail -40 "$log"
        return 1
    fi
    local expected_o="$ws/build/sailfin/sfn__runtime-native__test_marker.sfn-O2.o"
    if [ ! -f "$expected_o" ]; then
        echo "[test]   sfn-source .o missing after symlinked build: $expected_o"
        return 1
    fi
    return 0
}

run_test "consumer fires for sfn-sources and produces cached .o" test_consumer_fires_and_produces_object
run_test "SAILFIN_DISABLE_RUNTIME_SFN_SOURCES=1 short-circuits consumer" test_disable_gate_skips_consumer
run_test "self-path resolution works through binary symlink (macOS-safe surface)" test_self_path_resolves_via_binary_dir

echo "[summary] $PASS passed, $FAIL failed"
if [ "$FAIL" -gt 0 ]; then
    exit 1
fi
