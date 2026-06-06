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
#   1. char_code(char_from_code(n)) == n for every n in 2..255 (round-trip).
#      Byte 1 is excluded from the read-back: char_from_code(1) writes the byte
#      correctly (length asserted separately) but char_code mis-reads 0x01 on
#      macOS arm64 — grapheme_at encodes ASCII as the immediate tagged pointer
#      (byte << 32), and 1 << 32 == 0x100000000 is the arm64 executable load
#      base, so the mach_vm_region guard treats it as a real pointer and reads
#      the Mach-O header. Pre-existing char_code quirk, not a char_from_code
#      defect; tracked as a follow-up (#1136).
#   2. char_from_code(65) == "A" (builds the expected ASCII string).
#   3. char_from_code(200) is a single raw byte: length 1, char_code == 200
#      (a UTF-8 codepoint encoder would give length 2 here).
#   4. The already-shipped multibyte READ path still holds: "é" has length 2
#      and its raw bytes are 195, 169.
#   5. char_from_code(0) returns "" — byte 0 is unrepresentable under the
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
    // (1) Round-trip bytes 2..255 through write-then-read.
    //
    // Byte 1 (0x01) is deliberately excluded: `char_from_code(1)` writes the
    // byte correctly (asserted separately below), but reading it back through
    // `char_code` mis-reads on macOS arm64. `char_code` routes through
    // `grapheme_at`, which encodes an ASCII byte as the immediate-codepoint
    // tagged pointer `(byte << 32)`; for byte 1 that is address 0x100000000,
    // which is exactly the arm64 executable load base, so the runtime's
    // `mach_vm_region` guard treats the tagged pointer as a real (mapped)
    // pointer and dereferences the Mach-O header instead of decoding the
    // codepoint. This is a pre-existing `char_code`/immediate-encoding quirk
    // (any string's byte 0x01 hits it; rare in real text), not a
    // `char_from_code` defect — tracked as a follow-up (#1136). Bytes 2..0x7f encode
    // to unmapped addresses and round-trip cleanly; bytes >= 0x80 take
    // grapheme_at's real-buffer path and are unaffected.
    let mut failures: int = 0;
    let mut n: int = 2;
    loop {
        if n > 255 { break; }
        let s = char_from_code(n);
        if char_code(s) != n { failures += 1; }
        n += 1;
    }
    print("ROUNDTRIP_FAILURES={{failures}}");

    // Byte 1 write side: char_from_code(1) builds a one-byte string even though
    // char_code's read-back is quirky on macOS (see above).
    let one = char_from_code(1);
    print("BYTE1_LEN={{one.length}}");

    // (2) Builds the expected ASCII string.
    let a = char_from_code(65);
    let mut ascii_ok: int = 0;
    if a == "A" { ascii_ok = 1; }
    print("ASCII_A_OK={{ascii_ok}}");

    // (3) Raw high byte: a single byte (length 1), not a 2-byte UTF-8 encode.
    let hi = char_from_code(200);
    print("HI_LEN={{hi.length}}");
    print("HI_CODE={{char_code(hi)}}");

    // (4) Already-shipped multibyte read path still holds.
    let e = "é";
    print("EACUTE_LEN={{e.length}}");
    print("EACUTE_B0={{char_code(e[0])}}");
    print("EACUTE_B1={{char_code(e[1])}}");

    // (5) Documented byte-0 limitation: unrepresentable -> empty string.
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
    assert_marker ROUNDTRIP_FAILURES 0 "$log" || rc=1
    assert_marker BYTE1_LEN 1 "$log" || rc=1
    assert_marker ASCII_A_OK 1 "$log" || rc=1
    assert_marker HI_LEN 1 "$log" || rc=1
    assert_marker HI_CODE 200 "$log" || rc=1
    assert_marker EACUTE_LEN 2 "$log" || rc=1
    assert_marker EACUTE_B0 195 "$log" || rc=1
    assert_marker EACUTE_B1 169 "$log" || rc=1
    assert_marker ZERO_LEN 0 "$log" || rc=1

    if [ "$rc" -eq 0 ]; then
        echo "[test]   char_from_code: 2..255 round-trip clean; byte 1 writes len 1; raw high byte 200 stays 1 byte; multibyte read 195/169 intact"
    fi
    return "$rc"
}

run_test "char_from_code round-trips 2..255 and writes raw bytes (issue #874)" test_char_from_code_roundtrip_and_raw_bytes

echo "[summary] $PASS passed, $FAIL failed"
if [ "$FAIL" -gt 0 ]; then
    exit 1
fi
