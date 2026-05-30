#!/usr/bin/env bash
# E2E regression test for issue #617 (sub-task of #613).
#
# Background: `capsules/sfn/sync/src/mod.sfn` used to export
# untyped `channel(...)`, `parallel(...)`, and `spawn(...)`, and
# `runtime/prelude.sfn` exposed identically-named prelude wrappers,
# all delegating to `sailfin_runtime_{channel,parallel,spawn}` —
# three C bridges that silently returned NULL / no-op'd. Programs
# built, ran, and did nothing concurrent. The project's `llms.txt`
# rule forbids "parsed but unenforced" surface, so the entire
# untyped wrapper layer was deleted: the `sfn/sync` capsule exports,
# the prelude wrappers, the prelude `runtime.channel/_spawn/_parallel`
# bindings, and the LLVM lowering descriptors that pointed at them.
# The three C stub bodies in `runtime/native/src/sailfin_runtime.c`
# stay until a new seed without those references is pinned (a
# `seed-blocker` follow-up); freshly-built compilers no longer emit
# any reference to them.
#
# Acceptance: any caller that mentions `channel` / `parallel` /
# `spawn` (whether via `import { ... } from "sfn/sync"` or via the
# prelude name itself) must visibly fail at compile time rather
# than silently linking to a NULL-returning runtime trap. The
# diagnostic comes from the LLVM lowering pass: it cannot resolve
# the call's return type now that the descriptor that bridged the
# name to a C symbol is gone.
#
# `sfn check` is intentionally NOT used here — it does not yet flag
# undefined function identifiers (tracked as #616). The active
# rejection path is `sfn build`, which exits non-zero and emits a
# `llvm lowering [fatal]: cannot resolve return type for call to ...`
# diagnostic the moment lowering tries to compile a call to a
# now-unknown name.
#
# The typed `spawn_*` / `await_*` runtime variants below are not
# exercised here — they have working pthread implementations and
# are unaffected by this change.
#
# Usage:
#   compiler/tests/e2e/test_sync_rejects_unimplemented_concurrency.sh <compiler-binary>

set -euo pipefail

BINARY="${1:?usage: test_sync_rejects_unimplemented_concurrency.sh <compiler-binary>}"
BINARY="$(realpath "$BINARY")"
PASS=0
FAIL=0

SCRATCH="$(mktemp -d -t sfn-sync-rejects-XXXXXX)"
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

# Run `sfn build` against the supplied source and confirm the
# build fails closed: a non-zero exit code, no output binary on
# disk, and a lowering diagnostic that names the offending symbol.
# The build is invoked from a directory OUTSIDE the source tree
# (we use the scratch dir as cwd) so the driver does not stumble
# onto a workspace capsule and try to compile it instead.
#
# Issue #631: this assertion is now strict for ALL callers,
# including the void-returning `spawn` case. The void branch used
# to drop its `[fatal]` lowering diagnostic before it reached the
# emit-level fatal gate, so `sfn build` printed the fatal but still
# wrote a (broken) binary and exited 0. The fix threads the
# statement-level diagnostics through to `has_fatal_lowering_diagnostic`,
# so the build now fails closed (rc != 0, no binary) just like the
# value-returning cases.
assert_build_rejects() {
    local label="$1"
    local source="$2"
    local symbol="$3"

    local src_path="$SCRATCH/${label}.sfn"
    local out_path="$SCRATCH/${label}.out"
    local log_path="$SCRATCH/${label}.log"
    printf '%s\n' "$source" > "$src_path"

    local rc=0
    ( cd "$SCRATCH" && "$BINARY" build -o "$out_path" "$src_path" ) \
        > "$log_path" 2>&1 || rc=$?

    if [ "$rc" -eq 0 ]; then
        echo "[test]   build of ${label}.sfn exited 0 — expected non-zero (fail-closed)" >&2
        echo "[test]   output:" >&2
        sed 's/^/[test]     /' "$log_path" >&2
        return 1
    fi

    if [ -e "$out_path" ]; then
        echo "[test]   build of ${label}.sfn produced an output binary at ${out_path} — expected none" >&2
        echo "[test]   output:" >&2
        sed 's/^/[test]     /' "$log_path" >&2
        return 1
    fi

    if ! grep -q "cannot resolve" "$log_path"; then
        echo "[test]   diagnostic for ${label}.sfn did not mention 'cannot resolve'" >&2
        echo "[test]   output:" >&2
        sed 's/^/[test]     /' "$log_path" >&2
        return 1
    fi

    if ! grep -q "\`${symbol}\`" "$log_path"; then
        echo "[test]   diagnostic for ${label}.sfn did not name '\`${symbol}\`'" >&2
        echo "[test]   output:" >&2
        sed 's/^/[test]     /' "$log_path" >&2
        return 1
    fi

    return 0
}

# Generic fail-closed assertion: rc != 0 AND no output binary, with no
# requirement on which pipeline stage produced the diagnostic. Used for
# the bare-undefined-callee fixture below, which the type checker rejects
# (E0420) before lowering ever runs — a different stage from the `spawn`
# lowering path, but the headline contract (`sfn build` exits non-zero and
# writes no binary) must hold uniformly regardless of where the failure
# originates.
assert_build_fails_closed() {
    local label="$1"
    local source="$2"

    local src_path="$SCRATCH/${label}.sfn"
    local out_path="$SCRATCH/${label}.out"
    local log_path="$SCRATCH/${label}.log"
    printf '%s\n' "$source" > "$src_path"

    local rc=0
    ( cd "$SCRATCH" && "$BINARY" build -o "$out_path" "$src_path" ) \
        > "$log_path" 2>&1 || rc=$?

    if [ "$rc" -eq 0 ]; then
        echo "[test]   build of ${label}.sfn exited 0 — expected non-zero (fail-closed)" >&2
        echo "[test]   output:" >&2
        sed 's/^/[test]     /' "$log_path" >&2
        return 1
    fi

    if [ -e "$out_path" ]; then
        echo "[test]   build of ${label}.sfn produced an output binary at ${out_path} — expected none" >&2
        echo "[test]   output:" >&2
        sed 's/^/[test]     /' "$log_path" >&2
        return 1
    fi

    return 0
}

test_channel_via_sfn_sync_rejected() {
    assert_build_rejects "channel_import_caller" \
'import { channel } from "sfn/sync";

fn main() ![io] {
    let _ch = channel(0);
}' \
        "channel"
}

test_parallel_via_sfn_sync_rejected() {
    assert_build_rejects "parallel_import_caller" \
'import { parallel } from "sfn/sync";

fn main() ![io] {
    let _results = parallel([]);
}' \
        "parallel"
}

test_spawn_via_sfn_sync_rejected() {
    assert_build_rejects "spawn_import_caller" \
'import { spawn } from "sfn/sync";

fn main() ![io] {
    spawn(0, "worker");
}' \
        "spawn"
}

# The prelude no longer exposes a top-level `channel` / `parallel` /
# `spawn` wrapper either, so a program that names them without any
# import must also be rejected. This guards the second silent-NULL
# surface (the unqualified prelude name) — pre-#617 this was the
# path most users actually hit when they wrote `spawn(...)` thinking
# of the keyword form.
test_channel_via_prelude_name_rejected() {
    assert_build_rejects "channel_prelude_caller" \
'fn main() ![io] {
    let _ch = channel(0);
}' \
        "channel"
}

test_spawn_via_prelude_name_rejected() {
    assert_build_rejects "spawn_prelude_caller" \
'fn main() ![io] {
    spawn(0, "worker");
}' \
        "spawn"
}

# Issue #631: pin the bare void-call statement shape directly, independent
# of the `sfn/sync` surface. A statement that discards the result of an
# unresolved call must fail closed (rc != 0, no binary). The `spawn` cases
# above exercise the LLVM-lowering void path (the descriptor is gone but
# the name type-checks); this fixture covers a wholly-undefined callee,
# which the type checker rejects with E0420 before lowering. Both shapes
# previously risked a false-green rc=0 on the void statement branch — the
# fix that threads statement-level diagnostics to the fatal gate is what
# guarantees the build now fails closed for the lowering case.
test_unknown_void_helper_rejected() {
    assert_build_fails_closed "unknown_void_helper_caller" \
'fn main() ![io] {
    unknown_void_helper();
}'
}

run_test "sfn build rejects sfn/sync.channel import (#617)" test_channel_via_sfn_sync_rejected
run_test "sfn build rejects sfn/sync.parallel import (#617)" test_parallel_via_sfn_sync_rejected
run_test "sfn build rejects sfn/sync.spawn import (#617)" test_spawn_via_sfn_sync_rejected
run_test "sfn build rejects bare prelude channel() (#617)" test_channel_via_prelude_name_rejected
run_test "sfn build rejects bare prelude spawn() (#617)" test_spawn_via_prelude_name_rejected
run_test "sfn build fails closed on unknown void helper (#631)" test_unknown_void_helper_rejected

echo "[summary] $PASS passed, $FAIL failed"
if [ "$FAIL" -gt 0 ]; then
    exit 1
fi
