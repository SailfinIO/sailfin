#!/usr/bin/env bash
# End-to-end test for runtime/sfn/io.sfn's M2.8 extension —
# Sailfin-defined print / console / env helpers linked into the
# compiler binary (issue #401, epic #389 M2.8).
#
# Mirrors test_runtime_string_basic.sh's structure: typecheck +
# fmt + emit-shape on the source module, plus a compiled-IR
# regression that the new compiler routes `print.*` / `console.*`
# / `env.get` / `env.home` call sites through the `sfn_print*` /
# `sfn_getenv` / `sfn_home_dir` family instead of the legacy
# `sailfin_runtime_print_*` / `sailfin_runtime_getenv` /
# `sailfin_runtime_home_dir` C entrypoints.
#
# When a follow-up wave retires the trampoline bodies and ships
# length-aware print bodies, the emit-shape assertions stay —
# they pin the migration symbol surface, not the body strategy.

set -euo pipefail

BINARY="${1:?usage: test_runtime_io_extended.sh <compiler-binary>}"
BINARY="$(realpath "$BINARY")"
PASS=0
FAIL=0

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
MODULE="$REPO_ROOT/runtime/sfn/io.sfn"

SCRATCH="$(mktemp -d -t sfn-runtime-io-XXXXXX)"
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

# ---- Test: source module typechecks cleanly ----
test_check_clean() {
    local log="$SCRATCH/check.log"
    if ! "$BINARY" check "$MODULE" > "$log" 2>&1; then
        echo "[test]   sfn check exited non-zero on io.sfn:"
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

# ---- Test: source module is fmt-canonical ----
test_fmt_clean() {
    if ! "$BINARY" fmt --check "$MODULE" > /dev/null 2>&1; then
        echo "[test]   $MODULE needs formatting (run: sfn fmt --write $MODULE)"
        return 1
    fi
    return 0
}

# ---- Test: emitted IR carries a `define` for every sfn_*_sfn_* export ----
#
# The Sailfin module exports the `_sfn_` infix family
# (`sfn_print_sfn`, `sfn_getenv_sfn`, ...) so its definitions
# coexist with the C trampolines that own the bare `sfn_print*` /
# `sfn_getenv` / `sfn_home_dir` namespace —
# `runtime/native/src/sailfin_runtime.c` defines those for the new
# compiler emission and the test linker. A follow-up wave retires
# the C trampolines and renames these exports to the bare form.
test_emit_define_shape() {
    local ll="$SCRATCH/io.ll"
    local log="$SCRATCH/emit.log"
    if ! "$BINARY" emit -o "$ll" llvm "$MODULE" > "$log" 2>&1; then
        echo "[test]   sfn emit llvm failed on runtime/sfn/io.sfn:"
        cat "$log"
        return 1
    fi
    local missing=0
    for sym in sfn_print_sfn sfn_print_err_sfn sfn_print_info_sfn sfn_print_warn_sfn sfn_print_error_sfn sfn_getenv_sfn sfn_home_dir_sfn sfn_write_fd; do
        if ! grep -qE "^define .* @${sym}\(" "$ll"; then
            echo "[test]   missing 'define ... @${sym}(' in io.ll"
            missing=$((missing + 1))
        fi
    done
    return "$missing"
}

# ---- Test: emitted IR does NOT collide with C trampolines ----
#
# Coexistence regression: a regression that flips a Sailfin export
# to a bare `sfn_print*` / `sfn_getenv` / `sfn_home_dir` define
# would collide with the C trampoline at link time and break
# `make compile`. Pin the `_sfn_` infix as the marker until the
# follow-up wave removes the C trampolines.
test_no_bare_canonical_define() {
    local ll="$SCRATCH/io.ll"
    if [ ! -f "$ll" ]; then
        echo "[test]   $ll missing — test_emit_define_shape must run first"
        return 1
    fi
    local found=0
    for sym in sfn_print sfn_print_err sfn_print_info sfn_print_warn sfn_print_error sfn_getenv sfn_home_dir; do
        if grep -qE "^define .* @${sym}\(" "$ll"; then
            echo "[test]   collision risk: io.sfn emits 'define ... @${sym}(', conflicts with C trampoline"
            found=$((found + 1))
        fi
    done
    return "$found"
}

# ---- Test: compiled hello-world IR routes print through @sfn_print ----
#
# Acceptance criterion from #401 is phrased against `print.info`:
# "`print.info("hello")` lowers to `call void
# @sfn_print_info({i8*, i64} %s)` not `@sailfin_runtime_print_info`."
# The `examples/basics/hello-world.sfn` source uses bare `print(...)`
# rather than `print.info(...)`, so this test pins the analogous
# bare-print flip; `test_full_probe_flipped` below covers the
# `print.info` site explicitly.
test_hello_world_flipped() {
    local hello="$REPO_ROOT/examples/basics/hello-world.sfn"
    local ll="$SCRATCH/hello.ll"
    local log="$SCRATCH/hello-emit.log"
    if ! "$BINARY" emit -o "$ll" llvm "$hello" > "$log" 2>&1; then
        echo "[test]   sfn emit llvm failed on hello-world.sfn:"
        cat "$log"
        return 1
    fi
    # Must call the new sfn_print symbol against the SfnString
    # aggregate ABI.
    if ! grep -qE "call void @sfn_print\(\{i8\*, i64\}" "$ll"; then
        echo "[test]   hello-world.sfn does not lower to @sfn_print({i8*, i64} ...)"
        echo "[test]   ll head:"
        grep -nE "@sfn_print\b|@sailfin_runtime_print_raw\b" "$ll" | head -5
        return 1
    fi
    # And must not reference the legacy entrypoint.
    if grep -qE "@sailfin_runtime_print_raw\b" "$ll"; then
        echo "[test]   hello-world.sfn still references @sailfin_runtime_print_raw (expected the sfn_print flip)"
        grep -nE "@sailfin_runtime_print_raw\b" "$ll" | head -3
        return 1
    fi
    return 0
}

# ---- Test: compiled probe IR routes every print/console/env call site ----
test_full_probe_flipped() {
    local probe="$SCRATCH/io_probe.sfn"
    cat > "$probe" <<'PROBE'
fn main() -> int ![io] {
    print("raw");
    print.err("raw err");
    print.info("info");
    print.warn("warn");
    print.error("error");
    console.info("c info");
    console.log("c log");
    console.error("c error");
    let _h = env.home();
    let _v = env.get("HOME");
    return 0;
}
PROBE
    local ll="$SCRATCH/io_probe.ll"
    local log="$SCRATCH/io_probe.log"
    if ! "$BINARY" emit -o "$ll" llvm "$probe" > "$log" 2>&1; then
        echo "[test]   sfn emit llvm failed on io_probe.sfn:"
        cat "$log"
        return 1
    fi
    local missing=0
    # Required new symbols (note: console.info/log alias `sfn_print`;
    # console.error aliases `sfn_print_error`).
    for sym in sfn_print sfn_print_err sfn_print_info sfn_print_warn sfn_print_error sfn_getenv sfn_home_dir; do
        if ! grep -qE "@${sym}\b" "$ll"; then
            echo "[test]   io_probe.sfn does not reference @${sym}"
            missing=$((missing + 1))
        fi
    done
    # Banned legacy entrypoints.
    local found=0
    for sym in sailfin_runtime_print_raw sailfin_runtime_print_err sailfin_runtime_print_info sailfin_runtime_print_warn sailfin_runtime_print_error sailfin_runtime_getenv sailfin_runtime_home_dir; do
        if grep -qE "@${sym}\b" "$ll"; then
            echo "[test]   io_probe.sfn still references @${sym} (expected the sfn_* flip)"
            grep -nE "@${sym}\b" "$ll" | head -3
            found=$((found + 1))
        fi
    done
    # M2.8b (#726): env.get / env.home must lower against the
    # SfnString aggregate ABI with the trailing arena slot. Pin the
    # exact call shape so a regression that drops the arena thread or
    # reverts the aggregate flip is caught at the IR layer rather
    # than as a downstream segfault.
    if ! grep -qE 'call \{i8\*, i64\} @sfn_getenv\(\{i8\*, i64\} .+, ptr @sfn_default_arena\)' "$ll"; then
        echo "[test]   io_probe.sfn does not lower env.get to call {i8*, i64} @sfn_getenv({i8*, i64} ..., ptr @sfn_default_arena)"
        grep -nE '@sfn_getenv\b' "$ll" | head -3
        found=$((found + 1))
    fi
    if ! grep -qE 'call \{i8\*, i64\} @sfn_home_dir\(ptr @sfn_default_arena\)' "$ll"; then
        echo "[test]   io_probe.sfn does not lower env.home to call {i8*, i64} @sfn_home_dir(ptr @sfn_default_arena)"
        grep -nE '@sfn_home_dir\b' "$ll" | head -3
        found=$((found + 1))
    fi
    return "$((missing + found))"
}

# ---- Test: compiler binary exports both name families ----
test_compiler_binary_exports() {
    local nm_log
    nm_log="$(nm "$BINARY" 2>/dev/null || true)"
    if [ -z "$nm_log" ]; then
        echo "[test]   nm produced no output for $BINARY (stripped binary?)"
        return 1
    fi
    local missing=0
    # Canonical C-trampoline names (the symbols the new compiler
    # emission targets), plus the Sailfin proof-of-life `_sfn_`
    # infix family.
    for sym in sfn_print sfn_print_err sfn_print_info sfn_print_warn sfn_print_error sfn_getenv sfn_home_dir sfn_print_sfn sfn_print_err_sfn sfn_print_info_sfn sfn_print_warn_sfn sfn_print_error_sfn sfn_getenv_sfn sfn_home_dir_sfn; do
        if ! grep -qE "[[:space:]][Tt][[:space:]]_?${sym}\$" <<< "$nm_log"; then
            echo "[test]   compiler binary does not export defined symbol ${sym}"
            missing=$((missing + 1))
        fi
    done
    return "$missing"
}

# ---- Test: capsule.toml lists the io module ----
test_manifest_lists_io() {
    local manifest="$REPO_ROOT/runtime/native/capsule.toml"
    if ! grep -qE '^sfn-sources = \[.*"\.\./sfn/io\.sfn".*\]' "$manifest"; then
        echo "[test]   sfn-sources does not list ../sfn/io.sfn:"
        grep -nE 'sfn-sources' "$manifest" || true
        return 1
    fi
    return 0
}

# ---- Test: hello-world runs and produces expected output ----
#
# End-to-end behavior gate — the AC explicitly calls out that
# `examples/basics/hello-world.sfn` must still print correctly
# after the symbol flip. Compiles the example and runs it.
test_hello_world_runs() {
    local hello="$REPO_ROOT/examples/basics/hello-world.sfn"
    local out
    if ! out="$("$BINARY" run "$hello" 2>&1)"; then
        echo "[test]   sfn run hello-world.sfn failed:"
        echo "$out"
        return 1
    fi
    if ! grep -q "Hello, Sailfin!" <<< "$out"; then
        echo "[test]   hello-world output missing expected greeting:"
        echo "$out"
        return 1
    fi
    return 0
}

run_test "sfn check runtime/sfn/io.sfn passes" test_check_clean
run_test "sfn fmt --check runtime/sfn/io.sfn is canonical" test_fmt_clean
run_test "sfn emit llvm produces define for every sfn_*_sfn_* export" test_emit_define_shape
run_test "sfn emit llvm does not collide with C trampoline sfn_print* / sfn_getenv / sfn_home_dir names" test_no_bare_canonical_define
run_test "hello-world.sfn lowers print() to @sfn_print({i8*, i64} ...)" test_hello_world_flipped
run_test "probe binary routes every print/console/env site through @sfn_*" test_full_probe_flipped
run_test "compiler binary exports defined sfn_print* / sfn_getenv / sfn_home_dir and _sfn_ infix symbols" test_compiler_binary_exports
run_test "runtime/native/capsule.toml sfn-sources lists the io module" test_manifest_lists_io
run_test "hello-world.sfn still prints correctly end-to-end" test_hello_world_runs

echo "[summary] $PASS passed, $FAIL failed"
if [ "$FAIL" -gt 0 ]; then
    exit 1
fi
