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
# `main()`. The remaining c-sources cover the arena and runtime
# helpers — enough to satisfy the link without an entry-point
# clash. (#964 deleted the sha256/base64 C sources after #816/#817
# ported them to the `sfn/crypto` capsule, so they no longer appear
# here.)
c-sources = ["src/sailfin_arena.c", "src/sailfin_runtime.c"]
ll-sources = ["ir/runtime_globals.ll"]
# PR 2 of the sleep migration (issue 397) deleted the C
# `sfn_sleep` trampoline, so `clock.sfn` is now required at link
# time: the prelude always emits a call to `@sfn_sleep` via the
# `sleep(ms)` wrapper, and without `clock.sfn` listed here the
# synthetic build fails with "undefined reference to sfn_sleep".
# M5.3 (#471) added a synthesized `@main` wrapper that installs a
# top-level setjmp/longjmp exception frame around the user body,
# so the link now also requires `exception.sfn`'s
# `sfn_exception_push_frame` / `_pop_frame` / `sfn_take_exception`
# defines — without them the synthetic build fails with
# "undefined reference to sfn_exception_*". The list still leads
# with `test_marker.sfn` so the "consumer fires for sfn-sources"
# assertions below remain pointed at the marker file.
# #925 (epic #390) ported the Cat-C helpers, so prelude.o now
# emits unconditional calls to `@sfn_log_execution` (io.sfn),
# `@sfn_to_debug_string` (string.sfn), and `@sfn_array_sfn_map` /
# `_filter` / `_reduce` (array.sfn). All three modules are required
# here or the link fails with "undefined reference to
# `sfn_log_execution`" / `sfn_to_debug_string` / `sfn_array_sfn_filter`.
# #927 (epic #390) flipped the get_field / copy_bytes / bounds_check /
# free descriptors to `@sfn_mem_*` (mem.sfn); prelude.o (and any boxed
# local / array index in the linked IR) now references them, so mem.sfn
# is required too or the link fails with "undefined reference to
# `sfn_mem_bounds_check`".
sfn-sources = ["../sfn/test_marker.sfn", "../sfn/clock.sfn", "../sfn/exception.sfn", "../sfn/type_meta.sfn", "../sfn/io.sfn", "../sfn/string.sfn", "../sfn/array.sfn", "../sfn/memory/mem.sfn"]
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

    # Mirror the real clock.sfn + posix.sfn (its dep) and exception.sfn
    # (#471 dep) — the synthetic capsule's `sfn-sources` list above
    # references them by relative path under `runtime/sfn/`, so they
    # have to exist on disk for `_compile_runtime_sfn_sources` to find
    # them.
    mkdir -p "$ws/runtime/sfn/platform"
    ln -s "$REPO_ROOT/runtime/sfn/clock.sfn" "$ws/runtime/sfn/clock.sfn"
    ln -s "$REPO_ROOT/runtime/sfn/platform/posix.sfn" "$ws/runtime/sfn/platform/posix.sfn"
    ln -s "$REPO_ROOT/runtime/sfn/exception.sfn" "$ws/runtime/sfn/exception.sfn"
    # M2.10 (#402) dep — clock.sfn / exception.sfn define structs
    # that trigger `@__sfn_module_type_init__*` ctors calling
    # `@sfn_type_register`; without `type_meta.sfn` on the synthetic
    # sfn-sources list the synthetic build fails at link with
    # "undefined reference to `sfn_type_register`".
    ln -s "$REPO_ROOT/runtime/sfn/type_meta.sfn" "$ws/runtime/sfn/type_meta.sfn"
    # #925 deps — prelude.o calls `@sfn_log_execution` (io.sfn),
    # `@sfn_to_debug_string` (string.sfn), and `@sfn_array_sfn_*`
    # (array.sfn). io.sfn additionally imports `./platform/libc`
    # (`write`), so libc.sfn must exist on disk for the consumer's
    # `sfn emit` to resolve the extern. string.sfn / array.sfn have
    # no imports.
    ln -s "$REPO_ROOT/runtime/sfn/io.sfn" "$ws/runtime/sfn/io.sfn"
    ln -s "$REPO_ROOT/runtime/sfn/string.sfn" "$ws/runtime/sfn/string.sfn"
    ln -s "$REPO_ROOT/runtime/sfn/array.sfn" "$ws/runtime/sfn/array.sfn"
    ln -s "$REPO_ROOT/runtime/sfn/platform/libc.sfn" "$ws/runtime/sfn/platform/libc.sfn"
    # #927 dep — prelude.o + linked IR reference `@sfn_mem_*` (mem.sfn
    # lives under runtime/sfn/memory/). No imports of its own (inlines
    # its externs), so a bare symlink suffices.
    mkdir -p "$ws/runtime/sfn/memory"
    ln -s "$REPO_ROOT/runtime/sfn/memory/mem.sfn" "$ws/runtime/sfn/memory/mem.sfn"

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
    # Post-#397 (PR 2 of the sleep migration), the prelude's
    # `sleep` wrapper emits `call void @sfn_sleep(...)` and the C
    # runtime no longer defines `sfn_sleep` — only the Sailfin
    # `runtime/sfn/clock.sfn` module does, via the same
    # `sfn-sources` consumer this gate disables. So the build is
    # now EXPECTED to fail when the gate is set (the link surfaces
    # an undefined reference to `sfn_sleep`). The gate's
    # short-circuit behavior — no `.o` produced for any
    # `sfn-source` entry — is still pinned below; what changed is
    # the rollback story: disabling the consumer no longer keeps
    # the rest of the build healthy. A future PR that restores a
    # C-side fallback for `sfn_sleep` would re-make this build
    # succeed, at which point this expect-failure assertion flips
    # back to expect-success without changing the .o-absence check.
    local rc=0
    build_scratch_app "$ws" "$log" "SAILFIN_DISABLE_RUNTIME_SFN_SOURCES=1" || rc=$?
    if [ "$rc" -eq 0 ]; then
        echo "[test]   sfn build with disable gate UNEXPECTEDLY succeeded — the C"
        echo "[test]   sfn_sleep trampoline is back? Update this test's gate-failure"
        echo "[test]   expectation if PR 2 of the sleep migration was reverted."
        return 1
    fi
    # GNU ld (Linux) says: `undefined reference to 'sfn_sleep'`
    # macOS ld says:       `"_sfn_sleep", referenced from: _sleep in prelude.o`
    # ld64 prefixes user symbols with an underscore on Mach-O, so the
    # alternation covers both forms.
    if ! grep -qE "undefined reference to .sfn_sleep.|\"_sfn_sleep\", referenced from" "$log"; then
        echo "[test]   sfn build failed but not for the expected sfn_sleep reason:"
        tail -40 "$log"
        return 1
    fi
    local expected_o="$ws/build/sailfin/sfn__runtime-native__test_marker.sfn-O2.o"
    if [ -f "$expected_o" ]; then
        echo "[test]   disable gate did NOT skip the consumer; .o was produced anyway:"
        echo "[test]   $expected_o"
        return 1
    fi
    local clock_o="$ws/build/sailfin/sfn__runtime-native__clock.sfn-O2.o"
    if [ -f "$clock_o" ]; then
        echo "[test]   disable gate did NOT skip the consumer; clock.o was produced:"
        echo "[test]   $clock_o"
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

test_source_edit_busts_cache() {
    # Regression for #969: `_emit_runtime_sfn_to_obj` used to reuse a
    # cached `.o` on existence alone, so a runtime sfn-source that
    # GAINED a function after its `.o` was first cached kept linking
    # against the stale object — undefined symbols at link. That is
    # exactly how the real additions of `sfn_clock_millis` (#905) and
    # `sfn_log_execution` / `sfn_to_debug_string` / `sfn_is_void`
    # (#935) broke `sfn run` on macOS: the prelude called five symbols
    # the stale May-29 runtime objects never defined. The content-key
    # cache (mirroring the c-source path, #632) must bust on a source
    # edit. This test rewrites the marker source between two builds and
    # asserts the rebuilt `.o` reflects the new symbol.
    local ws="$SCRATCH/ws-cache-bust"
    setup_workspace "$ws"
    local log="$SCRATCH/ws-cache-bust.log"
    if ! build_scratch_app "$ws" "$log"; then
        echo "[test]   initial sfn build failed:"
        tail -40 "$log"
        return 1
    fi
    local marker_o="$ws/build/sailfin/sfn__runtime-native__test_marker.sfn-O2.o"
    if [ ! -f "$marker_o" ]; then
        echo "[test]   marker .o missing after first build: $marker_o"
        return 1
    fi
    # Sanity: the new symbol must NOT exist before the edit.
    if nm "$marker_o" 2>/dev/null | grep -q "rt_test_marker_v2"; then
        echo "[test]   unexpected: rt_test_marker_v2 present before edit"
        return 1
    fi
    # Rewrite the marker source (a real file written by
    # setup_workspace, not a symlink) to add a second function. The
    # content change must change the cache key and force a re-emit.
    cat > "$ws/runtime/sfn/test_marker.sfn" <<'EOF'
fn rt_test_marker() -> i64 ![io] {
    return 42;
}

fn rt_test_marker_v2() -> i64 ![io] {
    return 43;
}
EOF
    local log2="$SCRATCH/ws-cache-bust-2.log"
    if ! build_scratch_app "$ws" "$log2"; then
        echo "[test]   rebuild after source edit failed:"
        tail -40 "$log2"
        return 1
    fi
    # With the old existence-only cache the marker .o would still be
    # the stale object and this symbol would be absent.
    if ! nm "$marker_o" 2>/dev/null | grep -q "rt_test_marker_v2"; then
        echo "[test]   stale .o reused after source edit — cache not busted (#969):"
        nm "$marker_o" 2>/dev/null | grep "rt_test_marker" || true
        return 1
    fi
    # The content-key sidecar must exist (proves the keyed path ran).
    if [ ! -f "$marker_o.key" ]; then
        echo "[test]   content-key sidecar missing after rebuild: $marker_o.key"
        return 1
    fi
    return 0
}

run_test "consumer fires for sfn-sources and produces cached .o" test_consumer_fires_and_produces_object
run_test "SAILFIN_DISABLE_RUNTIME_SFN_SOURCES=1 short-circuits consumer" test_disable_gate_skips_consumer
run_test "self-path resolution works through binary symlink (macOS-safe surface)" test_self_path_resolves_via_binary_dir
run_test "source edit busts the runtime sfn-source object cache (#969)" test_source_edit_busts_cache

echo "[summary] $PASS passed, $FAIL failed"
if [ "$FAIL" -gt 0 ]; then
    exit 1
fi
