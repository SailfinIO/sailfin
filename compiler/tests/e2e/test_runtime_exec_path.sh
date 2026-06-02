#!/usr/bin/env bash
# End-to-end test for `runtime/sfn/platform/exec.sfn` — the
# Sailfin-native executable-path + runtime-root resolution
# helpers shipped under issue #468 (M5.3 prerequisite per epic
# #451).
#
# Pinned shape:
#
#   1. typecheck   — `sfn check runtime/sfn/platform/exec.sfn`
#                    reports `ok`.
#   2. fmt         — `sfn fmt --check runtime/sfn/platform/exec.sfn`
#                    is canonical.
#   3. emit shape — the module emits `define i8* @exe_path()` and
#                    `define i8* @binary_dir(i8* %exe)` and
#                    `define i8* @resolve_runtime_root(i8* %exe_path)`
#                    at unmangled names so the staged `.o` resolves
#                    when downstream callers (`extern fn`-declared or
#                    the M5.3 `@main` lowering) reach the symbols.
#   4. extern decls — `runtime/sfn/platform/libc.sfn` carries
#                    `declare i32 @_NSGetExecutablePath(i8*, i32*)`
#                    and `declare i32 @GetModuleFileNameA(i8*, i8*, i32)`
#                    when emitted standalone. Criterion 4 of the
#                    issue: declarations parse cleanly on Linux even
#                    though they're never called there. Pinning the
#                    `declare` shape here so a future widening of
#                    the accept-list doesn't accidentally drop them.
#   5. round-trip  — the fixture binary at
#                    `compiler/tests/e2e/fixtures/exec_path_probe.sfn`
#                    builds via `sfn build`, runs, and prints a
#                    path whose `realpath` matches the fixture's
#                    own `realpath`. This pins the
#                    `readlink("/proc/self/exe")` Linux happy path
#                    end-to-end.
#
# Platform coverage. Since #968 `exe_path()` resolves on every
# platform via the host-aware `sailfin_intrinsic_exe_path` sentinel,
# so the compile-time shape checks (1–4) pass cross-platform —
# criterion 3 now asserts the host's primitive (`readlink` on Linux,
# `_NSGetExecutablePath` on Darwin). The end-to-end round-trip (5)
# stays Linux-gated here; the dedicated macOS-arm64 e2e acceptance
# gate (the bare-PATH-name `sfn run` reproduction) is issue #3.

set -euo pipefail

BINARY="${1:?usage: test_runtime_exec_path.sh <compiler-binary>}"
BINARY="$(realpath "$BINARY")"
PASS=0
FAIL=0

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
MODULE="$REPO_ROOT/runtime/sfn/platform/exec.sfn"
LIBC_MODULE="$REPO_ROOT/runtime/sfn/platform/libc.sfn"
FIXTURE="$REPO_ROOT/compiler/tests/e2e/fixtures/exec_path_probe.sfn"

SCRATCH="$(mktemp -d -t sfn-runtime-exec-XXXXXX)"
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
        echo "[test]   sfn check exited non-zero on exec.sfn:"
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

test_emit_define_shape() {
    local ll="$SCRATCH/exec.ll"
    local log="$SCRATCH/emit.log"
    if ! "$BINARY" emit -o "$ll" llvm "$MODULE" > "$log" 2>&1; then
        echo "[test]   sfn emit llvm failed on exec.sfn:"
        cat "$log"
        return 1
    fi

    local missing=0
    # Unmangled symbol names so the staged .o resolves at link time
    # for both `extern fn`-declared user callers (today) and the
    # M5.3 `@main` lowering (planned).
    if ! grep -qE '^define i8\* @exe_path\(\) \{' "$ll"; then
        echo "[test]   missing 'define i8* @exe_path() {'"
        grep -nE '^define .* @exe_path' "$ll" || echo "[test]   (no @exe_path define)"
        missing=$((missing + 1))
    fi
    if ! grep -qE '^define i8\* @binary_dir\(i8\* %exe\) \{' "$ll"; then
        echo "[test]   missing 'define i8* @binary_dir(i8* %exe) {'"
        grep -nE '^define .* @binary_dir' "$ll" || echo "[test]   (no @binary_dir define)"
        missing=$((missing + 1))
    fi
    if ! grep -qE '^define i8\* @resolve_runtime_root\(i8\* %exe_path\) \{' "$ll"; then
        echo "[test]   missing 'define i8* @resolve_runtime_root(i8* %exe_path) {'"
        grep -nE '^define .* @resolve_runtime_root' "$ll" || echo "[test]   (no @resolve_runtime_root define)"
        missing=$((missing + 1))
    fi
    # Bodies must actually call the systems primitives — the whole
    # point of the M5.3 prereq is replacing native_driver.c's C-side
    # `readlink` / `realpath` / `getenv` / `strrchr` calls.
    #
    # `exe_path()` now calls the host-aware `sailfin_intrinsic_exe_path`
    # sentinel (#967/#968), which the compiler lowers to the host's
    # concrete primitive at emit time — `readlink` on Linux,
    # `_NSGetExecutablePath` on Darwin. This emit has no `uname` shim,
    # so it reflects the *build host*; assert the host's primitive
    # accordingly. (The full per-target sentinel shape across all three
    # legs is pinned host-independently by `test_exe_path_reader.sh`.)
    # `binary_dir` / `resolve_runtime_root` still call `strrchr` /
    # `realpath` / `getenv` directly on every host — pinned below.
    case "$(uname -s)" in
        Darwin)
            if ! grep -qE '^[[:space:]]+%[^ ]+ = call i32 @_NSGetExecutablePath\(' "$ll"; then
                echo "[test]   missing 'call i32 @_NSGetExecutablePath(...)' in exec.sfn body (Darwin host)"
                missing=$((missing + 1))
            fi
            ;;
        *)
            if ! grep -qE '^[[:space:]]+%[^ ]+ = call i64 @readlink\(' "$ll"; then
                echo "[test]   missing 'call i64 @readlink(...)' in exec.sfn body (Linux host)"
                missing=$((missing + 1))
            fi
            ;;
    esac
    if ! grep -qE '^[[:space:]]+%[^ ]+ = call i8\* @strrchr\(' "$ll"; then
        echo "[test]   missing 'call i8* @strrchr(...)' in exec.sfn body"
        missing=$((missing + 1))
    fi
    if ! grep -qE '^[[:space:]]+%[^ ]+ = call i8\* @realpath\(' "$ll"; then
        echo "[test]   missing 'call i8* @realpath(...)' in exec.sfn body"
        missing=$((missing + 1))
    fi
    if ! grep -qE '^[[:space:]]+%[^ ]+ = call i8\* @getenv\(' "$ll"; then
        echo "[test]   missing 'call i8* @getenv(...)' in exec.sfn body"
        missing=$((missing + 1))
    fi
    return "$missing"
}

test_platform_extern_decls() {
    # Criterion 4 of #468: `_NSGetExecutablePath` and
    # `GetModuleFileNameA` extern declarations parse cleanly on
    # Linux. The declarations live in `runtime/sfn/platform/libc.sfn`;
    # we emit the module standalone and verify the `declare` lines
    # surface in the IR. Unused declarations don't trigger link
    # errors (clang/ld only complains about unresolved *calls*),
    # so emitting them now lets a follow-up macOS/Windows wire-up
    # start from "add a call site" rather than "extend libc.sfn".
    local ll="$SCRATCH/libc.ll"
    local log="$SCRATCH/libc-emit.log"
    if ! "$BINARY" emit -o "$ll" llvm "$LIBC_MODULE" > "$log" 2>&1; then
        echo "[test]   sfn emit llvm failed on libc.sfn:"
        cat "$log"
        return 1
    fi
    local missing=0
    if ! grep -qE '^declare i32 @_NSGetExecutablePath\(i8\* %buf, i32\* %bufsize\)' "$ll"; then
        echo "[test]   missing '_NSGetExecutablePath' declaration in libc.ll"
        grep -nE '_NSGetExecutablePath' "$ll" || echo "[test]   (no _NSGetExecutablePath references)"
        missing=$((missing + 1))
    fi
    if ! grep -qE '^declare i32 @GetModuleFileNameA\(i8\* %handle, i8\* %buf, i32 %size\)' "$ll"; then
        echo "[test]   missing 'GetModuleFileNameA' declaration in libc.ll"
        grep -nE 'GetModuleFileNameA' "$ll" || echo "[test]   (no GetModuleFileNameA references)"
        missing=$((missing + 1))
    fi
    # The new POSIX additions used by exec.sfn must also surface.
    if ! grep -qE '^declare i64 @readlink\(i8\* %path, i8\* %buf, i64 %bufsize\)' "$ll"; then
        echo "[test]   missing 'readlink' declaration in libc.ll"
        missing=$((missing + 1))
    fi
    if ! grep -qE '^declare i8\* @realpath\(i8\* %path, i8\* %resolved\)' "$ll"; then
        echo "[test]   missing 'realpath' declaration in libc.ll"
        missing=$((missing + 1))
    fi
    if ! grep -qE '^declare i8\* @strrchr\(i8\* %s, i32 %c\)' "$ll"; then
        echo "[test]   missing 'strrchr' declaration in libc.ll"
        missing=$((missing + 1))
    fi
    if ! grep -qE '^declare i8\* @memset\(i8\* %dst, i32 %byte, i64 %n\)' "$ll"; then
        echo "[test]   missing 'memset' declaration in libc.ll"
        missing=$((missing + 1))
    fi
    return "$missing"
}

test_fixture_round_trip() {
    # End-to-end Linux round-trip: build the probe binary via
    # `sfn build`, run it, and confirm the printed path's
    # `realpath` matches the just-built binary's `realpath`.
    # `exe_path` now resolves on macOS too (since #968), but the
    # macOS-arm64 end-to-end acceptance gate is owned by issue #3
    # (a dedicated install-layout reproduction), so this round-trip
    # stays Linux-gated here. The shape-only checks above run
    # cross-platform.
    case "$(uname -s)" in
        Linux) ;;
        *)
            echo "[test]   skipping round-trip on $(uname -s) (Linux-gated here; macOS e2e gate is issue #3)"
            return 0
            ;;
    esac

    # Copy the fixture out of the repo tree before building. When
    # `sfn build` runs on a source inside the workspace it auto-
    # discovers `runtime/native/capsule.toml` as a runtime dep,
    # which routes the link through `_clang_compile_runtime_capsule_objects`
    # — that helper compiles every `c-sources` entry, including
    # `native_driver.c` whose `main` then collides with the
    # fixture's `main` at link time. Building from outside the
    # workspace falls through to the legacy `_clang_compile_runtime_objects`
    # path which only stages the runtime helpers we explicitly
    # need (prelude / clock / process / exception / exec — plus
    # sailfin_runtime.c / arena.c, neither of which defines
    # `main`). The same workaround would not be needed once
    # native_driver.c retires under M5.
    local fixture_copy="$SCRATCH/exec_path_probe.sfn"
    cp "$FIXTURE" "$fixture_copy"

    local probe_bin="$SCRATCH/exec_path_probe"
    local build_log="$SCRATCH/probe-build.log"
    if ! "$BINARY" build -o "$probe_bin" "$fixture_copy" > "$build_log" 2>&1; then
        echo "[test]   sfn build failed on $fixture_copy:"
        cat "$build_log"
        return 1
    fi
    if [ ! -x "$probe_bin" ]; then
        echo "[test]   expected executable at $probe_bin not produced"
        return 1
    fi

    local probe_out
    if ! probe_out="$("$probe_bin")"; then
        echo "[test]   probe binary exited non-zero:"
        "$probe_bin" || true
        return 1
    fi
    if [ -z "$probe_out" ]; then
        echo "[test]   probe binary produced no output"
        return 1
    fi

    # The probe prints the path on one line. Compare canonical
    # forms — the probe's `readlink("/proc/self/exe")` already
    # returns an absolute path, so a plain `realpath` match is
    # sufficient and resilient to symlinked scratch dirs (some
    # macOS / Linux temp roots are symlinks to /private/tmp or
    # similar).
    local probe_resolved
    probe_resolved="$(realpath "$probe_out" 2>/dev/null || echo "$probe_out")"
    local expected_resolved
    expected_resolved="$(realpath "$probe_bin")"
    if [ "$probe_resolved" != "$expected_resolved" ]; then
        echo "[test]   probe printed path does not resolve to fixture binary:"
        echo "[test]     printed   : $probe_out"
        echo "[test]     resolved  : $probe_resolved"
        echo "[test]     expected  : $expected_resolved"
        return 1
    fi
    return 0
}

run_test "sfn check runtime/sfn/platform/exec.sfn passes" test_check_clean
run_test "sfn fmt --check runtime/sfn/platform/exec.sfn is canonical" test_fmt_clean
run_test "sfn emit llvm produces unmangled defines + extern calls" test_emit_define_shape
run_test "libc.sfn declares _NSGetExecutablePath + GetModuleFileNameA + POSIX additions" test_platform_extern_decls
run_test "exec_path_probe fixture round-trips its own path" test_fixture_round_trip

echo "[summary] $PASS passed, $FAIL failed"
if [ "$FAIL" -gt 0 ]; then
    exit 1
fi
