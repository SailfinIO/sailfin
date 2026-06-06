#!/usr/bin/env bash
# E2E test for char_from_code() — issue #874.
#
# `char_from_code(n)` is the raw-byte WRITE primitive for pure-Sailfin code:
# it builds a 1-byte string whose sole byte is the raw value `n` (1..255).
# It is the write counterpart to the already-shipped byte read
# (`char_code(s[i])`, which returns the raw byte 0..255). Together they let
# pure-Sailfin code build and inspect arbitrary binary/multibyte byte
# sequences, removing the `char_from_code()`-pending workarounds in
# `capsules/sfn/cli/src/style.sfn` and `capsules/sfn/crypto/src/mod.sfn`.
#
# Unlike a codepoint encoder, `char_from_code` writes the byte verbatim — no
# UTF-8 expansion for 128..255 — so it is NOT `sfn_str_from_codepoint`
# (which would yield 2 bytes for 195). This program asserts:
#   1. char_from_code(n).length == 1 for every n in 1..255 — the load-bearing
#      write-side guarantee, platform-robust (the result is a real heap buffer,
#      never an immediate-codepoint tagged pointer).
#   2. char_code(char_from_code(n)) == n for n in 128..255 — the read round-trip,
#      and the genuinely novel guarantee (a raw byte, not a 2-byte UTF-8 encode).
#      The ASCII range (1..0x7f) is intentionally NOT round-tripped through
#      char_code: grapheme_at encodes ASCII as the immediate tagged pointer
#      (byte << 32), and on macOS arm64 whether that decodes correctly depends on
#      whether the address happens to be mapped — ASLR-dependent and flaky run to
#      run. That is a pre-existing char_code/immediate-encoding bug across the
#      ASCII range, not a char_from_code defect; tracked in #1136. ASCII
#      correctness is covered by (3) instead.
#   3. char_from_code(65)=="A", (48)=="0", (122)=="z" (literal equality, no
#      char_code dependency on the result).
#   4. char_from_code(200) is a single raw byte: length 1, char_code == 200
#      (a UTF-8 codepoint encoder would give length 2 here).
#   5. The already-shipped multibyte READ path still holds: "é" has length 2
#      and its raw bytes are 195, 169.
#   6. char_from_code(0) returns "" — byte 0 is unrepresentable under the
#      current NUL-terminated string model (length is strlen-recovered);
#      faithful embedded-NUL storage is deferred to the SfnString aggregate
#      flip (M1.A.2). This is a documented limitation, asserted explicitly so
#      a future representation change that fixes it trips this test loudly.
#
# Usage:
#   compiler/tests/e2e/test_runtime_char_from_code.sh <compiler-binary>

set -euo pipefail

BINARY="${1:?usage: test_runtime_char_from_code.sh <compiler-binary>}"
BINARY="$(realpath "$BINARY")"
PASS=0
FAIL=0

SCRATCH="$(mktemp -d -t sfn-char-from-code-XXXXXX)"
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

extract_marker() {
    # $1 = marker name, $2 = log file. Echoes the integer value or nothing.
    local marker="$1" log="$2" line value
    line="$(grep -E "^${marker}=" "$log" || true)"
    [ -z "$line" ] && return 1
    value="${line#${marker}=}"
    value="${value%%.*}"
    value="${value%%[eE]*}"
    [[ "$value" =~ ^-?[0-9]+$ ]] || return 1
    echo "$value"
}

assert_marker() {
    # $1 = marker, $2 = expected, $3 = log
    local marker="$1" expected="$2" log="$3" actual
    if ! actual="$(extract_marker "$marker" "$log")"; then
        echo "[test]   program did not print a valid ${marker} marker:" >&2
        cat "$log" >&2
        return 1
    fi
    if [ "$actual" != "$expected" ]; then
        echo "[test]   ${marker}=${actual}, expected ${expected}" >&2
        return 1
    fi
    return 0
}

test_char_from_code_roundtrip_and_raw_bytes() {
    cat > "$SCRATCH/char_from_code.sfn" <<'EOF'
fn main() ![io] {
    // (1) Write side, full range: char_from_code(n) yields a one-byte string
    // for every n in 1..255. This is the load-bearing guarantee and is
    // platform-robust — char_from_code returns a real heap buffer (never an
    // immediate-codepoint tagged pointer), so `.length` reads back as 1 on
    // every platform.
    let mut len_failures: int = 0;
    let mut n: int = 1;
    loop {
        if n > 255 { break; }
        if char_from_code(n).length != 1 { len_failures += 1; }
        n += 1;
    }
    print("LEN_FAILURES={{len_failures}}");

    // (2) Read round-trip for the high bytes 128..255 via char_code. These take
    // grapheme_at's real-buffer path (a raw byte >= 0x80 is never encoded as an
    // immediate codepoint), so the round-trip is reliable on every platform —
    // and it is the genuinely novel guarantee: a raw byte, NOT a 2-byte UTF-8
    // expansion.
    //
    // The ASCII range (1..0x7f) is deliberately NOT round-tripped through
    // char_code here: grapheme_at encodes an ASCII byte as the immediate tagged
    // pointer (byte << 32), and on macOS arm64 whether that address is treated
    // as immediate vs. a real pointer depends on whether it happens to be
    // mapped — which is ASLR-dependent and varies run to run. That is a
    // pre-existing char_code/immediate-encoding bug (not a char_from_code
    // defect), tracked in #1136. ASCII correctness is covered below by literal
    // equality, which does not depend on the immediate read-back.
    let mut rt_failures: int = 0;
    let mut h: int = 128;
    loop {
        if h > 255 { break; }
        if char_code(char_from_code(h)) != h { rt_failures += 1; }
        h += 1;
    }
    print("HIGH_ROUNDTRIP_FAILURES={{rt_failures}}");

    // (3) ASCII correctness via literal equality (no char_code dependency on
    // the result). Covers low/mid/high printable ASCII.
    let mut ascii_ok: int = 0;
    if char_from_code(65) == "A" {
        if char_from_code(48) == "0" {
            if char_from_code(122) == "z" { ascii_ok = 1; }
        }
    }
    print("ASCII_OK={{ascii_ok}}");

    // (4) Raw high byte: a single byte (length 1), not a 2-byte UTF-8 encode.
    let hi = char_from_code(200);
    print("HI_LEN={{hi.length}}");
    print("HI_CODE={{char_code(hi)}}");

    // (5) Already-shipped multibyte read path still holds.
    let e = "é";
    print("EACUTE_LEN={{e.length}}");
    print("EACUTE_B0={{char_code(e[0])}}");
    print("EACUTE_B1={{char_code(e[1])}}");

    // (6) Documented byte-0 limitation: unrepresentable -> empty string.
    let zero = char_from_code(0);
    print("ZERO_LEN={{zero.length}}");
}
EOF

    local log="$SCRATCH/run.log"
    if ! "$BINARY" run "$SCRATCH/char_from_code.sfn" > "$log" 2>&1; then
        echo "[test]   sfn run char_from_code.sfn failed:" >&2
        cat "$log" >&2
        return 1
    fi

    local rc=0
    assert_marker LEN_FAILURES 0 "$log" || rc=1
    assert_marker HIGH_ROUNDTRIP_FAILURES 0 "$log" || rc=1
    assert_marker ASCII_OK 1 "$log" || rc=1
    assert_marker HI_LEN 1 "$log" || rc=1
    assert_marker HI_CODE 200 "$log" || rc=1
    assert_marker EACUTE_LEN 2 "$log" || rc=1
    assert_marker EACUTE_B0 195 "$log" || rc=1
    assert_marker EACUTE_B1 169 "$log" || rc=1
    assert_marker ZERO_LEN 0 "$log" || rc=1

    if [ "$rc" -eq 0 ]; then
        echo "[test]   char_from_code: 1..255 all len 1; 128..255 round-trip clean; ASCII literals match; raw high byte 200 stays 1 byte; multibyte read 195/169 intact"
    fi
    return "$rc"
}

run_test "char_from_code writes raw bytes 1..255 and round-trips high bytes (issue #874)" test_char_from_code_roundtrip_and_raw_bytes

echo "[summary] $PASS passed, $FAIL failed"
if [ "$FAIL" -gt 0 ]; then
    exit 1
fi
