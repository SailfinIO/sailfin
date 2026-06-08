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
# As of #631 `sfn build` and `sfn emit llvm` both fail closed on these
# inputs; as of #906 `sfn emit native` joins them (it previously stopped at
# stage 5, before lowering, and false-greened with a `.sfn-asm` at rc=0).
# All three surfaces now reject the identical unresolved-callee programs.
#
# As of #1080 the concurrency frontend parses `spawn <expr>` and
# `channel(...)` into dedicated AST nodes (epic #965), so the FAIL-CLOSED
# MECHANISM differs by surface:
#   - `channel(cap)` is now a recognized `Channel` construct, not an
#     unresolved call. It has no lowering yet, so it fails closed with a
#     `llvm lowering [fatal]: \`channel\` expression is not yet lowered`
#     diagnostic (the `assert_*_rejects_unlowered` helpers). The former
#     `sfn/sync` `channel` export is gone, so the import-based variant is
#     obsolete and was removed.
#   - `spawn(0, "worker")` keeps the paren-call shape (the prefix-operator
#     parse rejects the comma-separated `(...)` and falls back to a `Raw`
#     call), so it still fails closed as an *unresolved call* (`cannot
#     resolve ... \`spawn\``) — the `assert_*_rejects` helpers below.
#   - `parallel(...)` is not parsed as a construct yet; unchanged.
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

# `sfn emit llvm` shares the lowering pipeline with `sfn build`, so the
# same void-call lowering `[fatal]` must abort it: rc != 0, no `.ll`
# artifact, and the `cannot resolve` diagnostic naming the symbol.
# `emit llvm` is a separate CLI surface with its own output path, so it
# gets its own assertion rather than relying on the `build` coverage.
assert_emit_llvm_rejects() {
    local label="$1"
    local source="$2"
    local symbol="$3"

    local src_path="$SCRATCH/${label}.sfn"
    local out_path="$SCRATCH/${label}.ll"
    local log_path="$SCRATCH/${label}.emitll.log"
    printf '%s\n' "$source" > "$src_path"

    local rc=0
    ( cd "$SCRATCH" && "$BINARY" emit -o "$out_path" llvm "$src_path" ) \
        > "$log_path" 2>&1 || rc=$?

    if [ "$rc" -eq 0 ]; then
        echo "[test]   emit llvm of ${label}.sfn exited 0 — expected non-zero (fail-closed)" >&2
        echo "[test]   output:" >&2
        sed 's/^/[test]     /' "$log_path" >&2
        return 1
    fi

    if [ -e "$out_path" ]; then
        echo "[test]   emit llvm of ${label}.sfn produced an .ll at ${out_path} — expected none" >&2
        echo "[test]   output:" >&2
        sed 's/^/[test]     /' "$log_path" >&2
        return 1
    fi

    if ! grep -q "cannot resolve" "$log_path"; then
        echo "[test]   emit llvm diagnostic for ${label}.sfn did not mention 'cannot resolve'" >&2
        echo "[test]   output:" >&2
        sed 's/^/[test]     /' "$log_path" >&2
        return 1
    fi

    if ! grep -q "\`${symbol}\`" "$log_path"; then
        echo "[test]   emit llvm diagnostic for ${label}.sfn did not name '\`${symbol}\`'" >&2
        echo "[test]   output:" >&2
        sed 's/^/[test]     /' "$log_path" >&2
        return 1
    fi

    return 0
}

# `sfn emit native` stops at the native-IR stage (stage 5), BEFORE the
# LLVM lowering (stage 6) that produces the `cannot resolve return type
# for call to ...` `[fatal]`. Pre-#906 it therefore never participated in
# return-type resolution: it wrote a `.sfn-asm` and exited 0 even for the
# unresolved-callee inputs `build` / `emit llvm` reject — a false green for
# any tool gating on its exit code. #906 added a CLI-level lowering dry-run
# gate (`native_text_passes_lowering_gate`) that reuses the exact same
# `[fatal]` machinery, so `emit native` now fails closed (rc != 0, no
# `.sfn-asm`) in parity with the other two surfaces. The gate lives only on
# the `emit native` command path, never on the self-host build's per-module
# stage-5 emit, so it cannot affect bootstrapping. (When #616 lands a shared
# typecheck-layer gate, this dry-run becomes redundant and can be removed
# without touching the build path — keep the two from diverging.)
#
# Note the argument order: `emit -o OUT native FILE` (mode follows the
# output flag), matching the CLI dispatch in `cli_main.sfn`.
assert_emit_native_rejects() {
    local label="$1"
    local source="$2"
    local symbol="$3"

    local src_path="$SCRATCH/${label}.sfn"
    local out_path="$SCRATCH/${label}.sfn-asm"
    local log_path="$SCRATCH/${label}.emitnative.log"
    printf '%s\n' "$source" > "$src_path"

    local rc=0
    ( cd "$SCRATCH" && "$BINARY" emit -o "$out_path" native "$src_path" ) \
        > "$log_path" 2>&1 || rc=$?

    if [ "$rc" -eq 0 ]; then
        echo "[test]   emit native of ${label}.sfn exited 0 — expected non-zero (fail-closed)" >&2
        echo "[test]   output:" >&2
        sed 's/^/[test]     /' "$log_path" >&2
        return 1
    fi

    if [ -e "$out_path" ]; then
        echo "[test]   emit native of ${label}.sfn produced a .sfn-asm at ${out_path} — expected none" >&2
        echo "[test]   output:" >&2
        sed 's/^/[test]     /' "$log_path" >&2
        return 1
    fi

    if ! grep -q "cannot resolve" "$log_path"; then
        echo "[test]   emit native diagnostic for ${label}.sfn did not mention 'cannot resolve'" >&2
        echo "[test]   output:" >&2
        sed 's/^/[test]     /' "$log_path" >&2
        return 1
    fi

    if ! grep -q "\`${symbol}\`" "$log_path"; then
        echo "[test]   emit native diagnostic for ${label}.sfn did not name '\`${symbol}\`'" >&2
        echo "[test]   output:" >&2
        sed 's/^/[test]     /' "$log_path" >&2
        return 1
    fi

    return 0
}

# Issue #1080: fail-closed assertion for a parsed-but-unlowered concurrency
# construct. Same headline contract as `assert_build_rejects` (rc != 0, no
# output binary) but the diagnostic is the lowering `[fatal]: ... is not yet
# lowered` produced by `lower_expression` for the `<concurrency_unlowered
# <kind>>` marker, NOT the `cannot resolve` unresolved-call message. The
# `<symbol>` (e.g. `channel`) must still be named so the diagnostic points at
# the offending construct.
assert_build_rejects_unlowered() {
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

    if ! grep -q "is not yet lowered" "$log_path"; then
        echo "[test]   diagnostic for ${label}.sfn did not mention 'is not yet lowered'" >&2
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

# Issue #1080: `sfn emit native` parity for the unlowered-construct path —
# rc != 0, no `.sfn-asm`, and the `is not yet lowered` lowering `[fatal]`
# naming the construct.
assert_emit_native_rejects_unlowered() {
    local label="$1"
    local source="$2"
    local symbol="$3"

    local src_path="$SCRATCH/${label}.sfn"
    local out_path="$SCRATCH/${label}.sfn-asm"
    local log_path="$SCRATCH/${label}.emitnative.log"
    printf '%s\n' "$source" > "$src_path"

    local rc=0
    ( cd "$SCRATCH" && "$BINARY" emit -o "$out_path" native "$src_path" ) \
        > "$log_path" 2>&1 || rc=$?

    if [ "$rc" -eq 0 ]; then
        echo "[test]   emit native of ${label}.sfn exited 0 — expected non-zero (fail-closed)" >&2
        echo "[test]   output:" >&2
        sed 's/^/[test]     /' "$log_path" >&2
        return 1
    fi

    if [ -e "$out_path" ]; then
        echo "[test]   emit native of ${label}.sfn produced a .sfn-asm at ${out_path} — expected none" >&2
        echo "[test]   output:" >&2
        sed 's/^/[test]     /' "$log_path" >&2
        return 1
    fi

    if ! grep -q "is not yet lowered" "$log_path"; then
        echo "[test]   emit native diagnostic for ${label}.sfn did not mention 'is not yet lowered'" >&2
        echo "[test]   output:" >&2
        sed 's/^/[test]     /' "$log_path" >&2
        return 1
    fi

    if ! grep -q "\`${symbol}\`" "$log_path"; then
        echo "[test]   emit native diagnostic for ${label}.sfn did not name '\`${symbol}\`'" >&2
        echo "[test]   output:" >&2
        sed 's/^/[test]     /' "$log_path" >&2
        return 1
    fi

    return 0
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
#
# Issue #1085: `channel(0)` now has real LLVM lowering (it emits a call
# to `sailfin_adapter_channel_create`), so it no longer fails at the
# lowering stage. It will fail at link time because the runtime body is
# not yet implemented (#1090). The fail-closed contract (rc != 0, no
# binary) is unchanged — only the failure stage moves from lowering to
# link time.
test_channel_via_prelude_name_rejected() {
    assert_build_fails_closed "channel_prelude_caller" \
'fn main() ![io] {
    let _ch = channel(0);
}'
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

# Issue #631: `sfn emit llvm` must fail closed on the void-call lowering
# fatal exactly like `sfn build`. The `spawn` case exercises the LLVM
# lowering void path (type-checks, but the descriptor is gone), which is
# precisely the surface the statement-level diagnostic propagation fix
# guards — pre-fix this emitted the fatal yet still wrote an `.ll` at rc=0.
test_emit_llvm_spawn_rejected() {
    assert_emit_llvm_rejects "spawn_emit_llvm_caller" \
'fn main() ![io] {
    spawn(0, "worker");
}' \
        "spawn"
}

# Issue #906 / #1085: `sfn emit native` previously checked a lowering
# dry-run gate and rejected `channel(0)` as `is not yet lowered`. As of
# #1085, `channel(0)` has real LLVM lowering (emits a call to
# `sailfin_adapter_channel_create`), so the dry-run gate now passes and
# `emit native` succeeds, writing a `.sfn-asm`. The `spawn(0, "worker")`
# case below still exercises the rejection path (unresolved call, unchanged).
test_emit_native_channel_succeeds() {
    local label="channel_emit_native_caller"
    local source='fn main() ![io] {
    let _ch = channel(0);
}'
    local src_path="$SCRATCH/${label}.sfn"
    local out_path="$SCRATCH/${label}.sfn-asm"
    local log_path="$SCRATCH/${label}.emitnative.log"
    printf '%s\n' "$source" > "$src_path"

    local rc=0
    ( cd "$SCRATCH" && "$BINARY" emit -o "$out_path" native "$src_path" ) \
        > "$log_path" 2>&1 || rc=$?

    if [ "$rc" -ne 0 ]; then
        echo "[test]   emit native of ${label}.sfn exited $rc — expected 0 (channel now lowers, #1085)" >&2
        echo "[test]   output:" >&2
        sed 's/^/[test]     /' "$log_path" >&2
        return 1
    fi

    if ! grep -q "channel(" "$out_path" 2>/dev/null; then
        echo "[test]   emit native of ${label}.sfn did not mention 'channel(' in the .sfn-asm" >&2
        return 1
    fi

    return 0
}

test_emit_native_spawn_rejected() {
    assert_emit_native_rejects "spawn_emit_native_caller" \
'fn main() ![io] {
    spawn(0, "worker");
}' \
        "spawn"
}

run_test "sfn build rejects sfn/sync.parallel import (#617)" test_parallel_via_sfn_sync_rejected
run_test "sfn build rejects sfn/sync.spawn import (#617)" test_spawn_via_sfn_sync_rejected
run_test "sfn build fails closed on channel() at link time (#1085)" test_channel_via_prelude_name_rejected
run_test "sfn build rejects bare prelude spawn() (#617)" test_spawn_via_prelude_name_rejected
run_test "sfn build fails closed on unknown void helper (#631)" test_unknown_void_helper_rejected
run_test "sfn emit llvm fails closed on void spawn() (#631)" test_emit_llvm_spawn_rejected
run_test "sfn emit native succeeds on channel() now that lowering exists (#1085)" test_emit_native_channel_succeeds
run_test "sfn emit native fails closed on void spawn() (#906)" test_emit_native_spawn_rejected

echo "[summary] $PASS passed, $FAIL failed"
if [ "$FAIL" -gt 0 ]; then
    exit 1
fi
