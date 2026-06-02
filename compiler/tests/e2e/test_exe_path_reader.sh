#!/usr/bin/env bash
# End-to-end test for the Sailfin-native exe_path() reader (#968, epic #390).
#
# `runtime/sfn/platform/exec.sfn` defines `exe_path() -> string ![io]` as a
# *host-portable* reader: it calls the `sailfin_intrinsic_exe_path` registry
# sentinel (#967) to fill a buffer with the running binary's path, then
# canonicalizes the result with `realpath` (portable POSIX — Darwin's
# `_NSGetExecutablePath` may return a non-canonical / symlinked path; Linux's
# `/proc/self/exe` is already canonical, so `realpath` is idempotent there).
# The sentinel is not a C symbol — it folds into the host's concrete primitive
# at emit time (`@readlink` Linux / `@_NSGetExecutablePath` Darwin /
# `@GetModuleFileNameA` Windows-mingw), so the same source links on every
# platform; only the host's symbol is ever `call`ed / `declare`d.
#
# This test pins that shape against the *real shipped module* (not a scratch
# fixture — that is `test_exe_path_intrinsic_platform.sh`'s job). It is
# host-independent: it forces each platform path via a `uname` shim on PATH
# (Linux/Darwin) and the `SAILFIN_TARGET_OS` cross-compile override (Windows),
# so it asserts the same thing whether CI runs it on Linux or macOS hardware.
# For each target it pins:
#
#   1. typecheck    — `sfn check exec.sfn` reports `ok`. The bare sentinel call
#                     resolves because its name is a runtime-helper call name
#                     seeded into the resolution scope; no extern is needed.
#   2. leg call     — emitted IR contains the host primitive's `call`.
#   3. realpath     — the body canonicalizes via `call i8* @realpath(`.
#   4. no other leg — neither of the other two platforms' primitives appear
#                     (the now-removed `extern fn readlink` no longer leaks a
#                     stray `declare` on the non-Linux legs).
#   5. no sentinel  — no `call`/`declare` targets the sentinel name; it must
#                     vanish into the concrete primitive.

set -euo pipefail

BINARY="${1:?usage: test_exe_path_reader.sh <compiler-binary>}"
BINARY="$(realpath "$BINARY")"
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
EXEC_SFN="$REPO_ROOT/runtime/sfn/platform/exec.sfn"
PASS=0
FAIL=0

SCRATCH="$(mktemp -d -t sfn-exe-path-reader-XXXXXX)"
trap 'rm -rf "$SCRATCH"' EXIT

LL_LINUX="$SCRATCH/exec_linux.ll"
LL_DARWIN="$SCRATCH/exec_darwin.ll"
LL_WINDOWS="$SCRATCH/exec_windows.ll"

# A `uname` shim that reports the requested OS for `-s` and delegates every
# other invocation to the real binary, so the compiler's `uname -s` probe
# resolves to our forced platform without disturbing anything else.
make_uname_shim() {
    local dir="$1" os="$2"
    mkdir -p "$dir"
    cat > "$dir/uname" <<SHIM
#!/bin/sh
if [ "\$1" = "-s" ]; then echo "$os"; exit 0; fi
exec /usr/bin/uname "\$@"
SHIM
    chmod +x "$dir/uname"
}

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
    if ! "$BINARY" check "$EXEC_SFN" > "$log" 2>&1; then
        echo "[test]   sfn check exited non-zero on exec.sfn:"
        cat "$log"
        return 1
    fi
    return 0
}

# Emit IR for the real exec.sfn with `uname -s` forced to $1
# ("Linux" | "Darwin"); writes to $2.
emit_for_os() {
    local os="$1" out="$2"
    local shimdir="$SCRATCH/shim-$os"
    local log="$SCRATCH/emit-$os.log"
    make_uname_shim "$shimdir" "$os"
    if ! PATH="$shimdir:$PATH" "$BINARY" emit -o "$out" llvm "$EXEC_SFN" > "$log" 2>&1; then
        echo "[test]   sfn emit llvm failed (uname=$os):"
        cat "$log"
        return 1
    fi
    return 0
}

# Emit IR with the cross-compile target override `SAILFIN_TARGET_OS` set to $1;
# writes to $2. The override names the *target* OS and takes precedence over
# the `uname -s` host probe (the `make ci-cross-windows` path: a Linux host
# producing a Windows binary).
emit_for_target_os() {
    local target_os="$1" out="$2"
    local log="$SCRATCH/emit-target-$target_os.log"
    if ! SAILFIN_TARGET_OS="$target_os" "$BINARY" emit -o "$out" llvm "$EXEC_SFN" > "$log" 2>&1; then
        echo "[test]   sfn emit llvm failed (SAILFIN_TARGET_OS=$target_os):"
        cat "$log"
        return 1
    fi
    return 0
}

test_emit_linux() { emit_for_os "Linux" "$LL_LINUX"; }
test_emit_darwin() { emit_for_os "Darwin" "$LL_DARWIN"; }
test_emit_windows() { emit_for_target_os "Windows" "$LL_WINDOWS"; }

# --- Linux leg: readlink against the interned /proc/self/exe literal ---

test_linux_call() {
    if ! grep -qE 'call i64 @readlink\(' "$LL_LINUX"; then
        echo "[test]   missing 'call i64 @readlink(' on the Linux leg"
        return 1
    fi
    return 0
}

test_linux_interned_path() {
    # The dispatcher interns the /proc/self/exe literal as a private global and
    # passes its i8* as readlink's first arg, keeping the sentinel signature
    # uniform across targets. The global must be materialized in the IR.
    if ! grep -qE 'private unnamed_addr constant .* c"/proc/self/exe' "$LL_LINUX"; then
        echo "[test]   missing interned '/proc/self/exe' string global on the Linux leg"
        return 1
    fi
    return 0
}

test_linux_realpath() {
    if ! grep -qE 'call i8\* @realpath\(' "$LL_LINUX"; then
        echo "[test]   missing 'call i8* @realpath(' (canonicalization) on the Linux leg"
        return 1
    fi
    return 0
}

test_linux_no_other_symbol() {
    # Anchor on the trailing `(` rather than `\b`: BSD/macOS `grep -E` treats
    # `\b` as a literal backspace, not a word boundary (this test runs on the
    # macos-arm64 CI leg too).
    if grep -qE '@_NSGetExecutablePath\(|@GetModuleFileNameA\(' "$LL_LINUX"; then
        echo "[test]   unexpected non-Linux primitive in Linux-leg IR:"
        grep -nE '@_NSGetExecutablePath\(|@GetModuleFileNameA\(' "$LL_LINUX"
        return 1
    fi
    return 0
}

# --- Darwin leg: _NSGetExecutablePath + alloca i32 + strlen + realpath ---

test_darwin_call() {
    if ! grep -qE 'call i32 @_NSGetExecutablePath\(' "$LL_DARWIN"; then
        echo "[test]   missing 'call i32 @_NSGetExecutablePath(' on the Darwin leg"
        return 1
    fi
    return 0
}

test_darwin_strlen() {
    if ! grep -qE 'call i64 @strlen\(' "$LL_DARWIN"; then
        echo "[test]   missing 'call i64 @strlen(' (length recovery) on the Darwin leg"
        return 1
    fi
    return 0
}

test_darwin_realpath() {
    if ! grep -qE 'call i8\* @realpath\(' "$LL_DARWIN"; then
        echo "[test]   missing 'call i8* @realpath(' (canonicalization) on the Darwin leg"
        return 1
    fi
    return 0
}

test_darwin_no_other_symbol() {
    if grep -qE '@readlink\(|@GetModuleFileNameA\(' "$LL_DARWIN"; then
        echo "[test]   unexpected non-Darwin primitive in Darwin-leg IR:"
        grep -nE '@readlink\(|@GetModuleFileNameA\(' "$LL_DARWIN"
        return 1
    fi
    return 0
}

# --- Windows leg (cross-compile target override): GetModuleFileNameA + realpath ---

test_windows_call() {
    if ! grep -qE 'call i32 @GetModuleFileNameA\(' "$LL_WINDOWS"; then
        echo "[test]   missing 'call i32 @GetModuleFileNameA(' on the Windows-target leg"
        return 1
    fi
    return 0
}

test_windows_realpath() {
    if ! grep -qE 'call i8\* @realpath\(' "$LL_WINDOWS"; then
        echo "[test]   missing 'call i8* @realpath(' (canonicalization) on the Windows-target leg"
        return 1
    fi
    return 0
}

test_windows_no_other_symbol() {
    if grep -qE '@readlink\(|@_NSGetExecutablePath\(' "$LL_WINDOWS"; then
        echo "[test]   unexpected non-Windows primitive in Windows-target IR:"
        grep -nE '@readlink\(|@_NSGetExecutablePath\(' "$LL_WINDOWS"
        return 1
    fi
    return 0
}

# --- The sentinel name must never appear as a real symbol ---

test_no_sentinel_leak() {
    local n
    # `grep -c` exits 1 when there are zero matches (the success case here).
    # The trailing `|| true` keeps that expected non-match from tripping
    # `set -euo pipefail`.
    n="$(grep -cE '(call|declare) .*@sailfin_intrinsic_exe_path' "$LL_LINUX" "$LL_DARWIN" "$LL_WINDOWS" 2>/dev/null | awk -F: '{s+=$2} END {print s+0}' || true)"
    if [ "$n" != "0" ]; then
        echo "[test]   expected 0 call/declare of the sentinel symbol, found $n:"
        grep -nE '(call|declare) .*@sailfin_intrinsic_exe_path' "$LL_LINUX" "$LL_DARWIN" "$LL_WINDOWS" || true
        return 1
    fi
    return 0
}

run_test "sfn check passes on runtime/sfn/platform/exec.sfn" test_check_clean
run_test "sfn emit llvm produces IR (uname=Linux)" test_emit_linux
run_test "sfn emit llvm produces IR (uname=Darwin)" test_emit_darwin
run_test "sfn emit llvm produces IR (SAILFIN_TARGET_OS=Windows)" test_emit_windows
run_test "Linux leg calls @readlink" test_linux_call
run_test "Linux leg interns /proc/self/exe" test_linux_interned_path
run_test "Linux leg canonicalizes via @realpath" test_linux_realpath
run_test "Linux leg omits Darwin/Windows primitives" test_linux_no_other_symbol
run_test "Darwin leg calls @_NSGetExecutablePath" test_darwin_call
run_test "Darwin leg recovers length via @strlen" test_darwin_strlen
run_test "Darwin leg canonicalizes via @realpath" test_darwin_realpath
run_test "Darwin leg omits Linux/Windows primitives" test_darwin_no_other_symbol
run_test "Windows-target leg calls @GetModuleFileNameA" test_windows_call
run_test "Windows-target leg canonicalizes via @realpath" test_windows_realpath
run_test "Windows-target leg omits Linux/Darwin primitives" test_windows_no_other_symbol
run_test "sentinel symbol never emitted as call/declare" test_no_sentinel_leak

echo "[summary] $PASS passed, $FAIL failed"
if [ "$FAIL" -gt 0 ]; then
    exit 1
fi
