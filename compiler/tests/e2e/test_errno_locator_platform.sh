#!/usr/bin/env bash
# End-to-end test for the host-aware errno-location sentinel (#877, epic #763).
#
# `sailfin_intrinsic_errno_location` is a registry sentinel whose lowering
# branch (`core_call_emission.sfn`) emits a `call` to the host's concrete
# `errno`-slot locator — `@__errno_location` on Linux/glibc, `@__error` on
# Darwin/macOS — chosen at emit time from `uname -s`. This lets the same
# compiler source link on both platforms when built natively, and is what
# unblocks `runtime/sfn/clock.sfn` reading `errno` without hardcoding the
# glibc-only symbol (which broke the macOS link — see #876/#882).
#
# The test is host-independent: it forces BOTH platform paths via a `uname`
# shim on PATH, so it asserts the same thing whether CI runs it on Linux or
# macOS hardware. For each forced platform it pins:
#
#   1. typecheck       — `sfn check <fixture>` reports `ok` (the sentinel is
#                        seeded into the resolution scope; no extern needed).
#   2. locator call    — emitted IR contains `call i32* @<sym>()`.
#   3. locator declare — emitted IR contains `declare i32* @<sym>()` (so the
#                        call resolves; emitted via the concrete descriptor).
#   4. load i32        — the pointer-read deref following the locator call.
#   5. no other symbol — the opposite platform's locator does NOT appear.
#   6. no sentinel leak — no `call`/`declare` targets the sentinel name
#                        (`sailfin_intrinsic_errno_location`); it must vanish
#                        into the concrete locator.

set -euo pipefail

BINARY="${1:?usage: test_errno_locator_platform.sh <compiler-binary>}"
BINARY="$(realpath "$BINARY")"
PASS=0
FAIL=0

SCRATCH="$(mktemp -d -t sfn-errno-locator-XXXXXX)"
trap 'rm -rf "$SCRATCH"' EXIT

# Fixture mirrors the real consumer shape (clock.sfn): chain the locator
# sentinel into the pointer-read intrinsic, exactly as `errno()` does.
FIXTURE="$SCRATCH/errno_locator.sfn"
cat > "$FIXTURE" <<'EOF'
fn read_errno() -> i32 {
    return sailfin_intrinsic_pointer_read_i32(sailfin_intrinsic_errno_location());
}

fn main() -> void {
    let e: i32 = read_errno();
}
EOF

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
    if ! "$BINARY" check "$FIXTURE" > "$log" 2>&1; then
        echo "[test]   sfn check exited non-zero on fixture:"
        cat "$log"
        return 1
    fi
    return 0
}

# Emit IR with `uname -s` forced to $1 ("Linux" | "Darwin"); writes to $2.
emit_for_os() {
    local os="$1" out="$2"
    local shimdir="$SCRATCH/shim-$os"
    local log="$SCRATCH/emit-$os.log"
    make_uname_shim "$shimdir" "$os"
    if ! PATH="$shimdir:$PATH" "$BINARY" emit -o "$out" llvm "$FIXTURE" > "$log" 2>&1; then
        echo "[test]   sfn emit llvm failed (uname=$os):"
        cat "$log"
        return 1
    fi
    return 0
}

LL_LINUX="$SCRATCH/errno_linux.ll"
LL_DARWIN="$SCRATCH/errno_darwin.ll"
LL_WINDOWS="$SCRATCH/errno_windows.ll"

test_emit_linux() { emit_for_os "Linux" "$LL_LINUX"; }
test_emit_darwin() { emit_for_os "Darwin" "$LL_DARWIN"; }

# Emit IR with the cross-compile target override `SAILFIN_TARGET_OS`
# set to $1; writes to $2. This is the cross-compilation path (#877):
# the override names the *target* OS and takes precedence over the
# `uname -s` host probe, so `make ci-cross-windows` (a Linux host
# producing a Windows binary) gets the target's errno accessor. The
# `uname` value is left as the real host here precisely to prove the
# override wins regardless of host.
emit_for_target_os() {
    local target_os="$1" out="$2"
    local log="$SCRATCH/emit-target-$target_os.log"
    if ! SAILFIN_TARGET_OS="$target_os" "$BINARY" emit -o "$out" llvm "$FIXTURE" > "$log" 2>&1; then
        echo "[test]   sfn emit llvm failed (SAILFIN_TARGET_OS=$target_os):"
        cat "$log"
        return 1
    fi
    return 0
}

test_emit_windows() { emit_for_target_os "Windows" "$LL_WINDOWS"; }

# --- Linux path: @__errno_location, not @__error ---

test_linux_call() {
    if ! grep -qE 'call i32\* @__errno_location\(\)' "$LL_LINUX"; then
        echo "[test]   missing 'call i32* @__errno_location()' on the Linux path"
        return 1
    fi
    return 0
}

test_linux_declare() {
    if ! grep -qE 'declare i32\* @__errno_location\(\)' "$LL_LINUX"; then
        echo "[test]   missing 'declare i32* @__errno_location()' on the Linux path"
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

test_linux_no_darwin_symbol() {
    # Anchor on the trailing `(` rather than `\b`: BSD/macOS `grep -E`
    # treats `\b` as a literal backspace, not a word boundary (see
    # test_runtime_libc_skeleton.sh:95-102), and this test runs on the
    # macos-arm64 CI leg.
    if grep -qE '@__error\(' "$LL_LINUX"; then
        echo "[test]   unexpected '@__error(' in Linux-path IR:"
        grep -nE '@__error\(' "$LL_LINUX"
        return 1
    fi
    return 0
}

# --- Darwin path: @__error, not @__errno_location ---

test_darwin_call() {
    if ! grep -qE 'call i32\* @__error\(\)' "$LL_DARWIN"; then
        echo "[test]   missing 'call i32* @__error()' on the Darwin path"
        return 1
    fi
    return 0
}

test_darwin_declare() {
    if ! grep -qE 'declare i32\* @__error\(\)' "$LL_DARWIN"; then
        echo "[test]   missing 'declare i32* @__error()' on the Darwin path"
        return 1
    fi
    return 0
}

test_darwin_no_linux_symbol() {
    # Anchor on `(` not `\b` for BSD/macOS `grep -E` portability — see
    # test_linux_no_darwin_symbol above.
    if grep -qE '@__errno_location\(' "$LL_DARWIN"; then
        echo "[test]   unexpected '@__errno_location(' in Darwin-path IR:"
        grep -nE '@__errno_location\(' "$LL_DARWIN"
        return 1
    fi
    return 0
}

# --- Windows (cross-compile target override): @_errno, not the glibc
#     or Darwin spellings (#877). mingw-w64 exposes the errno slot as
#     `int *_errno(void)`; the Linux-host cross-build must emit that. ---

test_windows_call() {
    if ! grep -qE 'call i32\* @_errno\(\)' "$LL_WINDOWS"; then
        echo "[test]   missing 'call i32* @_errno()' on the Windows-target path"
        return 1
    fi
    return 0
}

test_windows_declare() {
    if ! grep -qE 'declare i32\* @_errno\(\)' "$LL_WINDOWS"; then
        echo "[test]   missing 'declare i32* @_errno()' on the Windows-target path"
        return 1
    fi
    return 0
}

test_windows_no_other_symbol() {
    # Anchor on `(` not `\b` for BSD/macOS `grep -E` portability. Neither
    # the glibc nor the Darwin locator may appear when the target is
    # Windows — otherwise the mingw link picks up an undefined symbol.
    if grep -qE '@__errno_location\(|@__error\(' "$LL_WINDOWS"; then
        echo "[test]   unexpected non-Windows locator in Windows-target IR:"
        grep -nE '@__errno_location\(|@__error\(' "$LL_WINDOWS"
        return 1
    fi
    return 0
}

# --- The sentinel name must never appear as a real symbol ---

test_no_sentinel_leak() {
    local n
    n="$(grep -cE '(call|declare) .*@sailfin_intrinsic_errno_location' "$LL_LINUX" "$LL_DARWIN" "$LL_WINDOWS" 2>/dev/null | awk -F: '{s+=$2} END {print s+0}')"
    if [ "$n" != "0" ]; then
        echo "[test]   expected 0 call/declare of the sentinel symbol, found $n:"
        grep -nE '(call|declare) .*@sailfin_intrinsic_errno_location' "$LL_LINUX" "$LL_DARWIN" "$LL_WINDOWS" || true
        return 1
    fi
    return 0
}

run_test "sfn check passes on the errno-locator fixture" test_check_clean
run_test "sfn emit llvm produces IR (uname=Linux)" test_emit_linux
run_test "sfn emit llvm produces IR (uname=Darwin)" test_emit_darwin
run_test "sfn emit llvm produces IR (SAILFIN_TARGET_OS=Windows)" test_emit_windows
run_test "Linux path calls @__errno_location" test_linux_call
run_test "Linux path declares @__errno_location" test_linux_declare
run_test "Linux path derefs via 'load i32'" test_linux_load
run_test "Linux path omits @__error" test_linux_no_darwin_symbol
run_test "Darwin path calls @__error" test_darwin_call
run_test "Darwin path declares @__error" test_darwin_declare
run_test "Darwin path omits @__errno_location" test_darwin_no_linux_symbol
run_test "Windows-target path calls @_errno" test_windows_call
run_test "Windows-target path declares @_errno" test_windows_declare
run_test "Windows-target path omits @__errno_location and @__error" test_windows_no_other_symbol
run_test "sentinel symbol never emitted as call/declare" test_no_sentinel_leak

echo "[summary] $PASS passed, $FAIL failed"
if [ "$FAIL" -gt 0 ]; then
    exit 1
fi
