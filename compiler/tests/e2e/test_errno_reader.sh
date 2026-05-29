#!/usr/bin/env bash
# End-to-end test for the Sailfin-native errno() reader (#876, #893,
# epic #763).
#
# `runtime/sfn/platform/errno.sfn` defines `errno() -> i32` as a
# *host-portable* reader: it calls the `sailfin_intrinsic_errno_location`
# registry sentinel (#887/#890) to obtain the thread-local errno-slot
# pointer, then dereferences it via the `sailfin_intrinsic_pointer_read_i32`
# sentinel (#875). Neither sentinel is a C symbol — the locator folds into
# the host's concrete locator (`@__errno_location` glibc / `@__error`
# Darwin / `@_errno` Windows-mingw) at emit time, and the pointer-read
# folds into a bare `load i32`.
#
# This test pins that shape against the *real shipped module* (not a
# scratch fixture). It is host-independent: it forces each platform path
# via a `uname` shim on PATH (Linux/Darwin) and the `SAILFIN_TARGET_OS`
# cross-compile override (Windows), so it asserts the same thing whether
# CI runs it on Linux or macOS hardware. For each target it pins:
#
#   1. typecheck    — `sfn check errno.sfn` reports `ok`. The bare
#                     intrinsic calls resolve because their names are
#                     runtime-helper call names seeded into the E0420
#                     resolution scope; no extern is needed.
#   2. locator call — emitted IR contains `call i32* @<sym>()`.
#   3. load i32     — emitted IR contains `load i32, i32* %…` (the deref).
#   4. no other sym — the other platforms' locators do NOT appear.
#   5. no sentinel  — no `call`/`declare` targets either sentinel name,
#                     so neither links to a nonexistent symbol.

set -euo pipefail

BINARY="${1:?usage: test_errno_reader.sh <compiler-binary>}"
BINARY="$(realpath "$BINARY")"
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
ERRNO_SFN="$REPO_ROOT/runtime/sfn/platform/errno.sfn"
PASS=0
FAIL=0

SCRATCH="$(mktemp -d -t sfn-errno-XXXXXX)"
trap 'rm -rf "$SCRATCH"' EXIT

LL_LINUX="$SCRATCH/errno_linux.ll"
LL_DARWIN="$SCRATCH/errno_darwin.ll"
LL_WINDOWS="$SCRATCH/errno_windows.ll"

# A `uname` shim that reports the requested OS for `-s` and delegates
# every other invocation to the real binary, so the compiler's `uname -s`
# probe resolves to our forced platform without disturbing anything else.
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
    if ! "$BINARY" check "$ERRNO_SFN" > "$log" 2>&1; then
        echo "[test]   sfn check exited non-zero on errno.sfn:"
        cat "$log"
        return 1
    fi
    return 0
}

# Emit IR for the real errno.sfn with `uname -s` forced to $1
# ("Linux" | "Darwin"); writes to $2.
emit_for_os() {
    local os="$1" out="$2"
    local shimdir="$SCRATCH/shim-$os"
    local log="$SCRATCH/emit-$os.log"
    make_uname_shim "$shimdir" "$os"
    if ! PATH="$shimdir:$PATH" "$BINARY" emit -o "$out" llvm "$ERRNO_SFN" > "$log" 2>&1; then
        echo "[test]   sfn emit llvm failed (uname=$os):"
        cat "$log"
        return 1
    fi
    return 0
}

# Emit IR with the cross-compile target override `SAILFIN_TARGET_OS`
# set to $1; writes to $2. The override names the *target* OS and takes
# precedence over the `uname -s` host probe (the `make ci-cross-windows`
# path: a Linux host producing a Windows binary).
emit_for_target_os() {
    local target_os="$1" out="$2"
    local log="$SCRATCH/emit-target-$target_os.log"
    if ! SAILFIN_TARGET_OS="$target_os" "$BINARY" emit -o "$out" llvm "$ERRNO_SFN" > "$log" 2>&1; then
        echo "[test]   sfn emit llvm failed (SAILFIN_TARGET_OS=$target_os):"
        cat "$log"
        return 1
    fi
    return 0
}

test_emit_linux() { emit_for_os "Linux" "$LL_LINUX"; }
test_emit_darwin() { emit_for_os "Darwin" "$LL_DARWIN"; }
test_emit_windows() { emit_for_target_os "Windows" "$LL_WINDOWS"; }

# --- Linux path: @__errno_location, not @__error / @_errno ---

test_linux_call() {
    if ! grep -qE 'call i32\* @__errno_location\(\)' "$LL_LINUX"; then
        echo "[test]   missing 'call i32* @__errno_location()' on the Linux path"
        return 1
    fi
    return 0
}

test_linux_load() {
    if ! grep -qE 'load i32, i32\* %' "$LL_LINUX"; then
        echo "[test]   missing 'load i32, i32* %…' (errno deref) on the Linux path"
        return 1
    fi
    return 0
}

test_linux_no_other_symbol() {
    # Anchor on the trailing `(` rather than `\b`: BSD/macOS `grep -E`
    # treats `\b` as a literal backspace, not a word boundary, and this
    # test runs on the macos-arm64 CI leg.
    if grep -qE '@__error\(|@_errno\(' "$LL_LINUX"; then
        echo "[test]   unexpected non-Linux locator in Linux-path IR:"
        grep -nE '@__error\(|@_errno\(' "$LL_LINUX"
        return 1
    fi
    return 0
}

# --- Darwin path: @__error, not @__errno_location / @_errno ---

test_darwin_call() {
    if ! grep -qE 'call i32\* @__error\(\)' "$LL_DARWIN"; then
        echo "[test]   missing 'call i32* @__error()' on the Darwin path"
        return 1
    fi
    return 0
}

test_darwin_no_other_symbol() {
    if grep -qE '@__errno_location\(|@_errno\(' "$LL_DARWIN"; then
        echo "[test]   unexpected non-Darwin locator in Darwin-path IR:"
        grep -nE '@__errno_location\(|@_errno\(' "$LL_DARWIN"
        return 1
    fi
    return 0
}

# --- Windows (cross-compile target override): @_errno, not the glibc
#     or Darwin spellings. mingw-w64 exposes the errno slot as
#     `int *_errno(void)`; the Linux-host cross-build must emit that. ---

test_windows_call() {
    if ! grep -qE 'call i32\* @_errno\(\)' "$LL_WINDOWS"; then
        echo "[test]   missing 'call i32* @_errno()' on the Windows-target path"
        return 1
    fi
    return 0
}

test_windows_no_other_symbol() {
    if grep -qE '@__errno_location\(|@__error\(' "$LL_WINDOWS"; then
        echo "[test]   unexpected non-Windows locator in Windows-target IR:"
        grep -nE '@__errno_location\(|@__error\(' "$LL_WINDOWS"
        return 1
    fi
    return 0
}

# --- Neither sentinel name may ever appear as a real symbol ---

test_no_sentinel_leak() {
    local n
    n="$(grep -cE '(call|declare) .*@sailfin_intrinsic_(errno_location|pointer_read_i32)' \
            "$LL_LINUX" "$LL_DARWIN" "$LL_WINDOWS" 2>/dev/null \
         | awk -F: '{s+=$2} END {print s+0}')"
    if [ "$n" != "0" ]; then
        echo "[test]   expected 0 call/declare of a sentinel symbol, found $n:"
        grep -nE '(call|declare) .*@sailfin_intrinsic_(errno_location|pointer_read_i32)' \
            "$LL_LINUX" "$LL_DARWIN" "$LL_WINDOWS" || true
        return 1
    fi
    return 0
}

run_test "sfn check passes on runtime/sfn/platform/errno.sfn" test_check_clean
run_test "sfn emit llvm produces IR (uname=Linux)" test_emit_linux
run_test "sfn emit llvm produces IR (uname=Darwin)" test_emit_darwin
run_test "sfn emit llvm produces IR (SAILFIN_TARGET_OS=Windows)" test_emit_windows
run_test "Linux path calls @__errno_location" test_linux_call
run_test "Linux path derefs via 'load i32'" test_linux_load
run_test "Linux path omits @__error and @_errno" test_linux_no_other_symbol
run_test "Darwin path calls @__error" test_darwin_call
run_test "Darwin path omits @__errno_location and @_errno" test_darwin_no_other_symbol
run_test "Windows-target path calls @_errno" test_windows_call
run_test "Windows-target path omits @__errno_location and @__error" test_windows_no_other_symbol
run_test "neither sentinel symbol is emitted as call/declare" test_no_sentinel_leak

echo "[summary] $PASS passed, $FAIL failed"
if [ "$FAIL" -gt 0 ]; then
    exit 1
fi
