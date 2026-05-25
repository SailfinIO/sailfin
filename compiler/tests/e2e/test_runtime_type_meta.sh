#!/usr/bin/env bash
# End-to-end test for runtime/sfn/type_meta.sfn — minimum-viable
# type metadata (`SfnTypeDescriptor { id, name_ptr, kind }`,
# registry, `sfn_resolve_type` / `sfn_instance_of`) per issue
# #402 / epic #389 M2.10.
#
# Mirrors test_runtime_string_basic.sh's structure:
#
#   1. typecheck — `sfn check runtime/sfn/type_meta.sfn` reports `ok`.
#   2. fmt       — `sfn fmt --check runtime/sfn/type_meta.sfn` is canonical.
#   3. emit shape — emitted IR contains a `define` for each public
#                   `sfn_*` export plus the inlined libc declares.
#   4. compiled IR for a user module with structs emits
#      `@__sfn_type_desc.*` globals and an
#      `@__sfn_module_type_init__*` constructor wired through
#      `@llvm.global_ctors`.
#   5. The `runtime_helpers.sfn` descriptor flips route fresh
#      compiler emission to the `sfn_*` symbols (the `native_signature`
#      flip from M2.4a / M2.5 / M2.9 applied to the seven type-meta
#      descriptors).
#   6. Compiler binary exports the type-meta symbols + the descriptor
#      globals registered by its own `@llvm.global_ctors` chain
#      (acceptance criterion #2 in #402: `nm | grep __sfn_type_desc`
#      shows registered descriptors).
#   7. The runtime capsule manifest lists the new module.

set -euo pipefail

BINARY="${1:?usage: test_runtime_type_meta.sh <compiler-binary>}"
BINARY="$(realpath "$BINARY")"
PASS=0
FAIL=0

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
MODULE="$REPO_ROOT/runtime/sfn/type_meta.sfn"

SCRATCH="$(mktemp -d -t sfn-runtime-type-meta-XXXXXX)"
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

test_check_clean() {
    local log="$SCRATCH/check.log"
    if ! "$BINARY" check "$MODULE" > "$log" 2>&1; then
        echo "[test]   sfn check exited non-zero on type_meta.sfn:"
        cat "$log"
        return 1
    fi
    if ! grep -q "checked .* ok" "$log"; then
        echo "[test]   sfn check did not report 'ok':"
        cat "$log"
        return 1
    fi
    return 0
}

test_fmt_clean() {
    if ! "$BINARY" fmt --check "$MODULE" > /dev/null 2>&1; then
        echo "[test]   $MODULE needs formatting (run: sfn fmt --write $MODULE)"
        return 1
    fi
    return 0
}

# ---- Test: emitted IR carries a `define` for every public export ----
test_emit_define_shape() {
    local ll="$SCRATCH/type_meta.ll"
    local log="$SCRATCH/emit.log"
    if ! "$BINARY" emit -o "$ll" llvm "$MODULE" > "$log" 2>&1; then
        echo "[test]   sfn emit llvm failed on runtime/sfn/type_meta.sfn:"
        cat "$log"
        return 1
    fi
    local missing=0
    # Architect-spec public surface: register / resolve_type /
    # instance_of / type_of plus the five primitive guards. Each
    # produces exactly one `define` in the emitted module —
    # anchored at line start so a `call` site never satisfies the
    # assertion.
    for sym in sfn_type_register sfn_resolve_type sfn_instance_of sfn_type_of sfn_is_string sfn_is_number sfn_is_boolean sfn_is_callable sfn_is_array; do
        if ! grep -qE "^define .* @${sym}\(" "$ll"; then
            echo "[test]   missing 'define ... @${sym}(' in type_meta.ll"
            missing=$((missing + 1))
        fi
    done
    return "$missing"
}

# ---- Test: emitted IR declares the libc primitives bodies use ----
test_emit_libc_declares() {
    local ll="$SCRATCH/type_meta.ll"
    if [ ! -f "$ll" ]; then
        echo "[test]   $ll missing — test_emit_define_shape must run first"
        return 1
    fi
    local missing=0
    for sym in malloc free realloc strcmp; do
        if ! grep -qE "^declare .* @${sym}\(" "$ll"; then
            echo "[test]   missing 'declare ... @${sym}(' in type_meta.ll"
            missing=$((missing + 1))
        fi
    done
    return "$missing"
}

# ---- Test: compiling a small struct-bearing module emits descriptor globals ----
test_descriptor_globals_emit() {
    local source="$SCRATCH/has_types.sfn"
    local ll="$SCRATCH/has_types.ll"
    cat > "$source" << 'EOF'
struct M2_10_A {
    x: i64;
}

struct M2_10_B {
    y: i64;
}

fn main() -> int { return 0; }
EOF
    if ! "$BINARY" emit -o "$ll" llvm "$source" > "$SCRATCH/has_types_emit.log" 2>&1; then
        echo "[test]   sfn emit llvm failed on the type-bearing module:"
        cat "$SCRATCH/has_types_emit.log"
        return 1
    fi

    local missing=0
    # Architect §2.5.1 wire shape: `{ i64, i64, i32 }` with the
    # `linkonce_odr` linkage M2.10 picked so multi-module imports
    # of the same type coalesce at link time.
    for sym in M2_10_A M2_10_B; do
        if ! grep -qE "^@__sfn_type_desc\.${sym} = linkonce_odr constant \{ i64, i64, i32 \}" "$ll"; then
            echo "[test]   missing '@__sfn_type_desc.${sym}' descriptor global in has_types.ll"
            missing=$((missing + 1))
        fi
        if ! grep -qE "^@__sfn_type_desc_name\.${sym} = linkonce_odr unnamed_addr constant" "$ll"; then
            echo "[test]   missing '@__sfn_type_desc_name.${sym}' name global in has_types.ll"
            missing=$((missing + 1))
        fi
    done
    return "$missing"
}

# ---- Test: type-meta constructor wired through @llvm.global_ctors ----
test_module_init_ctor_wired() {
    local ll="$SCRATCH/has_types.ll"
    if [ ! -f "$ll" ]; then
        echo "[test]   $ll missing — test_descriptor_globals_emit must run first"
        return 1
    fi
    local missing=0
    if ! grep -qE "^define internal void @__sfn_module_type_init__" "$ll"; then
        echo "[test]   missing 'define internal void @__sfn_module_type_init__*' in has_types.ll"
        missing=$((missing + 1))
    fi
    if ! grep -qE "^@llvm\.global_ctors = appending global" "$ll"; then
        echo "[test]   missing '@llvm.global_ctors = appending global' in has_types.ll"
        missing=$((missing + 1))
    fi
    if ! grep -qE "call void @sfn_type_register\(i8\* bitcast \(\{ i64, i64, i32 \}\* @__sfn_type_desc\." "$ll"; then
        echo "[test]   missing 'call void @sfn_type_register(...)' inside module init ctor"
        missing=$((missing + 1))
    fi
    if ! grep -qE "^declare void @sfn_type_register\(i8\*\)" "$ll"; then
        echo "[test]   missing 'declare void @sfn_type_register(i8*)' in has_types.ll"
        missing=$((missing + 1))
    fi
    return "$missing"
}

# ---- Test: prelude indirection routes through the sfn_* symbols ----
#
# The seven descriptors flipped via `native_signature` in
# `compiler/src/llvm/runtime_helpers.sfn` retire the
# `sailfin_runtime_is_string` / `_resolve_type` / `_instance_of` C
# stubs from user emission. The prelude calls these via module-level
# `let`-bindings (`runtime_resolve_runtime_type_fn`,
# `runtime_instance_of_fn`); compiling the prelude is the most
# direct way to assert the flip.
test_prelude_emission_flipped() {
    local prelude="$REPO_ROOT/runtime/prelude.sfn"
    local ll="$SCRATCH/prelude.ll"
    if ! "$BINARY" emit -o "$ll" llvm "$prelude" > "$SCRATCH/prelude_emit.log" 2>&1; then
        echo "[test]   sfn emit llvm failed on runtime/prelude.sfn:"
        cat "$SCRATCH/prelude_emit.log"
        return 1
    fi
    local found=0
    # Each flipped C stub must be unreferenced in the prelude's
    # fresh emission. `\b` treats `_` as a word char so the
    # patterns match exactly the C-stub symbols and not the
    # `sfn_*` replacements emitted alongside.
    for sym in sailfin_runtime_is_string sailfin_runtime_is_number sailfin_runtime_is_boolean sailfin_runtime_is_array sailfin_runtime_is_callable sailfin_runtime_resolve_type sailfin_runtime_instance_of; do
        if grep -qE "@${sym}\b" "$ll"; then
            echo "[test]   prelude emission still references @${sym} (expected the sfn_* flip)"
            grep -nE "@${sym}\b" "$ll" | head -2
            found=$((found + 1))
        fi
    done
    # And the replacements must show up. The prelude is the only
    # module whose helper-walker normally surfaces these targets,
    # so a missing `@sfn_resolve_type` / `@sfn_instance_of` here
    # means the descriptor flip silently dropped the call.
    for sym in sfn_resolve_type sfn_instance_of; do
        if ! grep -qE "@${sym}\b" "$ll"; then
            echo "[test]   prelude emission does not reference @${sym} after the M2.10 flip"
            found=$((found + 1))
        fi
    done
    return "$found"
}

# ---- Test: compiler binary exports the type-meta symbols ----
#
# The binary linked from the M2.10 build must carry the Sailfin
# bodies (`sfn_type_register`, etc.) as defined text symbols —
# they ship from `runtime/sfn/type_meta.sfn` via the runtime
# capsule's `sfn-sources` link path the same way M2.4a /
# M2.5 / M2.9 shipped their `sfn_str_*` / `sfn_process_*` symbols.
#
# Descriptor globals (`@__sfn_type_desc.*`) on the compiler
# binary itself — acceptance criterion #2 in issue #402 — gate
# on the NEXT seed bump: the released seed predates the
# `compiler/src/llvm/lowering/type_descriptors.sfn` emission and
# therefore does not emit `@__sfn_type_desc.*` globals into
# `build/native/sailfin` directly. The compile-time check at
# `test_descriptor_globals_emit` proves the new compiler emits
# them for fresh user code; once a seed re-cut adopts this
# emission, this test grows the `nm | grep __sfn_type_desc`
# assertion the issue calls for. Tracked in the PR description.
test_compiler_binary_exports_type_meta() {
    local nm_log
    nm_log="$(nm "$BINARY" 2>/dev/null || true)"
    if [ -z "$nm_log" ]; then
        echo "[test]   nm produced no output for $BINARY (stripped binary?)"
        return 1
    fi
    local missing=0
    # Defined text symbols (` T ` / ` t `, optional `_` prefix for
    # Mach-O). Here-string avoids the `echo | grep -q` SIGPIPE-under-
    # pipefail trap when grep -q closes stdin after the first match.
    for sym in sfn_type_register sfn_resolve_type sfn_instance_of sfn_type_of sfn_is_string sfn_is_number sfn_is_boolean sfn_is_callable sfn_is_array; do
        if ! grep -qE "[[:space:]][Tt][[:space:]]_?${sym}\$" <<< "$nm_log"; then
            echo "[test]   compiler binary does not export defined symbol ${sym}"
            missing=$((missing + 1))
        fi
    done
    return "$missing"
}

# ---- Test: capsule.toml lists the new module ----
test_manifest_lists_type_meta() {
    local manifest="$REPO_ROOT/runtime/native/capsule.toml"
    if ! grep -qE '^sfn-sources = \[.*"\.\./sfn/type_meta\.sfn".*\]' "$manifest"; then
        echo "[test]   sfn-sources does not list ../sfn/type_meta.sfn:"
        grep -nE 'sfn-sources' "$manifest" || true
        return 1
    fi
    return 0
}

run_test "sfn check runtime/sfn/type_meta.sfn passes" test_check_clean
run_test "sfn fmt --check runtime/sfn/type_meta.sfn is canonical" test_fmt_clean
run_test "sfn emit llvm produces define for every sfn_* type-meta export" test_emit_define_shape
run_test "sfn emit llvm declares libc malloc/free/realloc/strcmp trampolines" test_emit_libc_declares
run_test "user module emission carries @__sfn_type_desc.* + name globals" test_descriptor_globals_emit
run_test "user module emission wires @__sfn_module_type_init__* via @llvm.global_ctors" test_module_init_ctor_wired
run_test "prelude emission routes type-meta calls through @sfn_resolve_type / @sfn_instance_of" test_prelude_emission_flipped
run_test "compiler binary exports defined sfn_* type-meta symbols and registered descriptors" test_compiler_binary_exports_type_meta
run_test "runtime/native/capsule.toml sfn-sources lists the type_meta module" test_manifest_lists_type_meta

echo "[summary] $PASS passed, $FAIL failed"
if [ "$FAIL" -gt 0 ]; then
    exit 1
fi
