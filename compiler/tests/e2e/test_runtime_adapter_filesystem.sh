#!/usr/bin/env bash
# End-to-end test for runtime/sfn/adapters/filesystem.sfn — the
# Sailfin-native filesystem adapter (M3.1a #814 + M3.1b #815,
# epic #390).
#
# Mirrors test_runtime_io_extended.sh's structure: typecheck + fmt
# + emit-shape on the source module, plus a compiled-IR regression
# that the new compiler routes `fs.readFile` / `fs.writeFile` /
# `fs.appendFile` (M3.1a) and `fs.listDirectory` / `fs.deleteFile`
# / `fs.createDirectory` (M3.1b) call sites through the `sfn_fs_*`
# adapter family instead of the legacy `sailfin_adapter_fs_*` C
# entrypoints. The M3.1b wave also adds a behavioral round-trip
# that recursively creates a directory, enumerates it, and deletes
# an entry through the flipped registry rows.

set -euo pipefail

BINARY="${1:?usage: test_runtime_adapter_filesystem.sh <compiler-binary>}"
BINARY="$(realpath "$BINARY")"
PASS=0
FAIL=0

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
MODULE="$REPO_ROOT/runtime/sfn/adapters/filesystem.sfn"
LIBC_MODULE="$REPO_ROOT/runtime/sfn/platform/libc.sfn"

SCRATCH="$(mktemp -d -t sfn-runtime-fs-XXXXXX)"
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
        echo "[test]   sfn check exited non-zero on filesystem.sfn:"
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

# ---- Test: libc.sfn parses cleanly with the new dir/stat externs ----
test_libc_check_clean() {
    local log="$SCRATCH/libc-check.log"
    if ! "$BINARY" check "$LIBC_MODULE" > "$log" 2>&1; then
        echo "[test]   sfn check exited non-zero on libc.sfn:"
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

# ---- Test: source modules are fmt-canonical ----
test_fmt_clean() {
    if ! "$BINARY" fmt --check "$MODULE" > /dev/null 2>&1; then
        echo "[test]   $MODULE needs formatting (run: sfn fmt --write $MODULE)"
        return 1
    fi
    if ! "$BINARY" fmt --check "$LIBC_MODULE" > /dev/null 2>&1; then
        echo "[test]   $LIBC_MODULE needs formatting (run: sfn fmt --write $LIBC_MODULE)"
        return 1
    fi
    return 0
}

# ---- Test: libc.sfn declares the directory + stat externs ----
#
# Pins the M3.1a surface so a regression that drops one of the
# new declarations (and silently fails the M3.1b list_directory
# / delete wave when it tries to use them) surfaces here instead
# of at the follow-up PR.
test_libc_declares_dir_stat_externs() {
    local missing=0
    for sym in stat opendir readdir closedir unlink mkdir rmdir; do
        if ! grep -qE "^extern fn ${sym}\(" "$LIBC_MODULE"; then
            echo "[test]   libc.sfn missing 'extern fn ${sym}(...'"
            missing=$((missing + 1))
        fi
    done
    return "$missing"
}

# ---- Test: emitted IR carries a `define` for every sfn_fs_* export ----
test_emit_define_shape() {
    local ll="$SCRATCH/filesystem.ll"
    local log="$SCRATCH/emit.log"
    if ! "$BINARY" emit -o "$ll" llvm "$MODULE" > "$log" 2>&1; then
        echo "[test]   sfn emit llvm failed on runtime/sfn/adapters/filesystem.sfn:"
        cat "$log"
        return 1
    fi
    local missing=0
    for sym in sfn_fs_read_file sfn_fs_write_file sfn_fs_append_file \
        sfn_fs_delete sfn_fs_mkdir sfn_fs_list_dir sfn_fs_read_bytes; do
        if ! grep -qE "^define .* @${sym}\(" "$ll"; then
            echo "[test]   missing 'define ... @${sym}(' in filesystem.ll"
            missing=$((missing + 1))
        fi
    done
    return "$missing"
}

# ---- Test: compiled probe routes fs.* through the @sfn_fs_* family ----
test_probe_flipped() {
    local probe="$SCRATCH/fs_probe.sfn"
    cat > "$probe" <<'PROBE'
fn main() -> int ![io] {
    fs.writeFile("/tmp/sfn_fs_probe.txt", "hello world");
    let content = fs.readFile("/tmp/sfn_fs_probe.txt");
    fs.appendFile("/tmp/sfn_fs_probe.txt", " again");
    return 0;
}
PROBE
    local ll="$SCRATCH/fs_probe.ll"
    local log="$SCRATCH/fs_probe.log"
    if ! "$BINARY" emit -o "$ll" llvm "$probe" > "$log" 2>&1; then
        echo "[test]   sfn emit llvm failed on fs_probe.sfn:"
        cat "$log"
        return 1
    fi
    # Anchor the match on a non-identifier character (or end of
    # line) after the symbol name. `\b` word-boundaries are
    # GNU-only in ERE — BSD/macOS `grep -E` treats `\b` as a
    # backspace and would silently skip every match. The
    # delimiter `([^A-Za-z0-9_]|$)` is portable across both
    # grep dialects.
    local missing=0
    for sym in sfn_fs_read_file sfn_fs_write_file sfn_fs_append_file; do
        if ! grep -qE "@${sym}([^A-Za-z0-9_]|$)" "$ll"; then
            echo "[test]   fs_probe.sfn does not reference @${sym}"
            missing=$((missing + 1))
        fi
    done
    # Banned legacy entrypoints — these stay defined in
    # sailfin_runtime.c (the issue's `Out:` defers their deletion
    # to M3.9). Trampoline `declare` lines are allowed (the
    # Sailfin write/append bodies forward through the legacy C
    # adapters); only `call` sites are forbidden, so the probe
    # checks `call ... @<sym>(` specifically. The `(` is the
    # canonical follow-up in any LLVM call line.
    local found=0
    for sym in sailfin_adapter_fs_read_file sailfin_adapter_fs_write_file sailfin_adapter_fs_append_file; do
        if grep -qE "call [^\"]*@${sym}\(" "$ll"; then
            echo "[test]   fs_probe.sfn still calls @${sym} (expected the sfn_fs_* flip)"
            grep -nE "@${sym}\(" "$ll" | head -3
            found=$((found + 1))
        fi
    done
    return "$((missing + found))"
}

# ---- Test: M3.1b probe routes fs.{listDirectory,deleteFile,createDirectory} ----
#
# Companion to test_probe_flipped for the #815 rows. The probe uses
# the listing result in its return value so dead-code elimination
# cannot drop the `@sfn_fs_list_dir` call before the assertion runs.
test_probe_flipped_m31b() {
    local probe="$SCRATCH/fs_probe_m31b.sfn"
    # deleteFile maps to unlink (files only), so the probe targets a
    # real file it just wrote — not the directory — to stay
    # representative if the probe is ever executed.
    cat > "$probe" <<'PROBE'
fn main() -> int ![io] {
    fs.createDirectory("/tmp/sfn_fs_probe_m31b/a/b", true);
    fs.writeFile("/tmp/sfn_fs_probe_m31b/note.txt", "x");
    let entries = fs.listDirectory("/tmp/sfn_fs_probe_m31b");
    fs.deleteFile("/tmp/sfn_fs_probe_m31b/note.txt");
    return entries.length;
}
PROBE
    local ll="$SCRATCH/fs_probe_m31b.ll"
    local log="$SCRATCH/fs_probe_m31b.log"
    if ! "$BINARY" emit -o "$ll" llvm "$probe" > "$log" 2>&1; then
        echo "[test]   sfn emit llvm failed on fs_probe_m31b.sfn:"
        cat "$log"
        return 1
    fi
    local missing=0
    for sym in sfn_fs_list_dir sfn_fs_delete sfn_fs_mkdir; do
        if ! grep -qE "@${sym}([^A-Za-z0-9_]|$)" "$ll"; then
            echo "[test]   fs_probe_m31b.sfn does not reference @${sym}"
            missing=$((missing + 1))
        fi
    done
    # Legacy C call sites must be gone (declares are tolerated for
    # the list_dir trampoline; only `call` sites are forbidden).
    local found=0
    for sym in sailfin_adapter_fs_list_directory_v2 sailfin_adapter_fs_delete_file sailfin_adapter_fs_create_directory; do
        if grep -qE "call [^\"]*@${sym}\(" "$ll"; then
            echo "[test]   fs_probe_m31b.sfn still calls @${sym} (expected the sfn_fs_* flip)"
            grep -nE "@${sym}\(" "$ll" | head -3
            found=$((found + 1))
        fi
    done
    return "$((missing + found))"
}

# ---- Test: list / delete / recursive-mkdir round-trip end-to-end ----
#
# The #815 behavior gate. One probe recursively creates a nested
# directory, drops two files in the parent, enumerates it (writing
# each entry to a listing file through the proven appendFile path),
# deletes one file, then re-enumerates. The bash assertions inspect
# the resulting on-disk state and the two listing files — exercising
# the flipped sfn_fs_mkdir / sfn_fs_list_dir / sfn_fs_delete symbols
# through the real `sfn run` link path.
test_round_trip_list_delete_mkdir() {
    local base="$SCRATCH/m31b"
    local listing="$SCRATCH/listing.txt"
    local listing2="$SCRATCH/listing2.txt"
    local probe="$SCRATCH/m31b_probe.sfn"
    local out_log="$SCRATCH/m31b.log"
    cat > "$probe" <<PROBE
fn main() -> int ![io] {
    fs.createDirectory("${base}/x/y/z", true);
    fs.writeFile("${base}/alpha.txt", "a");
    fs.writeFile("${base}/beta.txt", "b");
    let entries = fs.listDirectory("${base}");
    let mut i = 0;
    loop {
        if i >= entries.length { break; }
        fs.appendFile("${listing}", entries[i]);
        fs.appendFile("${listing}", "\n");
        i = i + 1;
    }
    fs.deleteFile("${base}/alpha.txt");
    let after = fs.listDirectory("${base}");
    let mut j = 0;
    loop {
        if j >= after.length { break; }
        fs.appendFile("${listing2}", after[j]);
        fs.appendFile("${listing2}", "\n");
        j = j + 1;
    }
    return 0;
}
PROBE
    if ! "$BINARY" run "$probe" > "$out_log" 2>&1; then
        echo "[test]   sfn run m31b_probe.sfn failed:"
        cat "$out_log"
        return 1
    fi
    # Recursive mkdir materialized every parent component.
    if [ ! -d "$base/x/y/z" ]; then
        echo "[test]   recursive mkdir did not create $base/x/y/z"
        return 1
    fi
    # First enumeration sees both files plus the nested dir 'x'.
    local want
    for want in alpha.txt beta.txt x; do
        if ! grep -qx "$want" "$listing"; then
            echo "[test]   first listing missing '$want':"
            sed 's/^/[test]     /' "$listing"
            return 1
        fi
    done
    # delete removed alpha.txt from disk.
    if [ -e "$base/alpha.txt" ]; then
        echo "[test]   delete did not remove $base/alpha.txt"
        return 1
    fi
    # Second enumeration drops alpha.txt but keeps beta.txt and x.
    if grep -qx "alpha.txt" "$listing2"; then
        echo "[test]   second listing still contains alpha.txt:"
        sed 's/^/[test]     /' "$listing2"
        return 1
    fi
    for want in beta.txt x; do
        if ! grep -qx "$want" "$listing2"; then
            echo "[test]   second listing missing '$want':"
            sed 's/^/[test]     /' "$listing2"
            return 1
        fi
    done
    return 0
}

# ---- Test: compiler binary exports the sfn_fs_* family ----
test_compiler_binary_exports() {
    local nm_log
    nm_log="$(nm "$BINARY" 2>/dev/null || true)"
    if [ -z "$nm_log" ]; then
        echo "[test]   nm produced no output for $BINARY (stripped binary?)"
        return 1
    fi
    local missing=0
    for sym in sfn_fs_read_file sfn_fs_write_file sfn_fs_append_file \
        sfn_fs_delete sfn_fs_mkdir sfn_fs_list_dir sfn_fs_read_bytes; do
        if ! grep -qE "[[:space:]][Tt][[:space:]]_?${sym}\$" <<< "$nm_log"; then
            echo "[test]   compiler binary does not export defined symbol ${sym}"
            missing=$((missing + 1))
        fi
    done
    return "$missing"
}

# ---- Test: capsule.toml lists the adapter ----
test_manifest_lists_filesystem() {
    local manifest="$REPO_ROOT/runtime/capsule.toml"
    if ! grep -qE '^sfn-sources = \[.*"sfn/adapters/filesystem\.sfn".*\]' "$manifest"; then
        echo "[test]   sfn-sources does not list sfn/adapters/filesystem.sfn:"
        grep -nE 'sfn-sources' "$manifest" || true
        return 1
    fi
    return 0
}

# ---- Test: round-trip a file through the adapter end-to-end ----
#
# The acceptance-criterion behavior gate from #814. Writes a
# scratch file, reads it back, appends to it, reads again, and
# confirms the on-disk and in-memory contents match the expected
# accumulator. Exercises all three flipped sfn_fs_* symbols
# through the legacy `sfn run` link path (which loads
# `runtime/sfn/adapters/filesystem.sfn`'s staged object via
# `_runtime_filesystem_path` in `compiler/src/cli_main.sfn`).
test_round_trip_file() {
    local scratch_file="$SCRATCH/round_trip.txt"
    local probe="$SCRATCH/round_trip_probe.sfn"
    local out_log="$SCRATCH/round_trip.log"
    # Build a probe that writes, reads, appends, reads — printing
    # each readback so we can assert on the observed bytes.
    cat > "$probe" <<PROBE
fn main() -> int ![io] {
    let path = "${scratch_file}";
    fs.writeFile(path, "first chunk");
    let after_write = fs.readFile(path);
    print(after_write);
    fs.appendFile(path, " plus appended");
    let after_append = fs.readFile(path);
    print(after_append);
    return 0;
}
PROBE
    # #915: capture stdout separately from stderr. The driver folds the
    # runtime object cache into the `[cache]` summary, which now prints
    # (to stderr) on nearly every `sfn run`; a combined `2>&1` capture
    # would corrupt the round-trip stdout comparison below.
    if ! "$BINARY" run "$probe" > "$out_log" 2> "$out_log.err"; then
        echo "[test]   sfn run round_trip_probe.sfn failed:"
        cat "$out_log" "$out_log.err"
        return 1
    fi
    # Expected stdout (each `print` adds a trailing newline):
    #   first chunk
    #   first chunk plus appended
    local expected
    expected="$(printf 'first chunk\nfirst chunk plus appended\n')"
    if [ "$(cat "$out_log")" != "$expected" ]; then
        echo "[test]   round-trip stdout mismatch."
        echo "[test]   expected:"
        printf '%s\n' "$expected" | sed 's/^/[test]     /'
        echo "[test]   got:"
        sed 's/^/[test]     /' "$out_log"
        return 1
    fi
    # Final on-disk contents must match the second read.
    if [ "$(cat "$scratch_file")" != "first chunk plus appended" ]; then
        echo "[test]   round-trip file contents mismatch."
        echo "[test]   expected: 'first chunk plus appended'"
        echo "[test]   got:      '$(cat "$scratch_file")'"
        return 1
    fi
    return 0
}

# ---- Test: large-file round-trip exercises the chunked-read grow path ----
#
# The `sfn_fs_read_file` body starts with a 4 KiB buffer and
# doubles via `realloc` on overflow. Writing and reading back a
# multi-megabyte file forces several realloc passes; a regression
# in the grow-or-NUL-slack arithmetic surfaces here as a length
# or content mismatch rather than as a segfault in production.
test_round_trip_large_file() {
    local scratch_file="$SCRATCH/large.bin"
    # Build a 32 KiB payload (8 realloc passes from the initial
    # 4 KiB capacity). Each line is 64 bytes including the
    # newline; 512 lines = 32768 bytes.
    local line='0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcde'
    : > "$scratch_file.expected"
    for _ in $(seq 1 512); do
        printf '%s\n' "$line" >> "$scratch_file.expected"
    done
    local probe="$SCRATCH/large_probe.sfn"
    # The probe reads the expected payload from disk, writes it
    # back through fs.writeFile, then reads it through
    # fs.readFile and re-emits it on stdout. A round-trip
    # mismatch surfaces as a `diff` failure below.
    cat > "$probe" <<PROBE
fn main() -> int ![io] {
    let src = "${scratch_file}.expected";
    let dst = "${scratch_file}";
    let payload = fs.readFile(src);
    fs.writeFile(dst, payload);
    let round_tripped = fs.readFile(dst);
    print(round_tripped);
    return 0;
}
PROBE
    local out_log="$SCRATCH/large.log"
    # #915: capture stdout separately (see test_round_trip_file) so the
    # stderr `[cache]` summary cannot inflate the byte-exact payload diff.
    if ! "$BINARY" run "$probe" > "$out_log" 2> "$out_log.err"; then
        echo "[test]   sfn run large_probe.sfn failed:"
        head -20 "$out_log" "$out_log.err"
        return 1
    fi
    # `print` always appends a trailing newline; the expected
    # payload already ends with one, so the observed stdout is
    # the payload + one extra newline. Compare against the
    # expected payload with a trailing newline appended.
    {
        cat "$scratch_file.expected"
        printf '\n'
    } > "$scratch_file.expected_stdout"
    if ! diff -q "$scratch_file.expected_stdout" "$out_log" > /dev/null 2>&1; then
        echo "[test]   large-file round-trip stdout mismatch."
        echo "[test]   expected $(wc -c < "$scratch_file.expected_stdout") bytes, got $(wc -c < "$out_log") bytes"
        return 1
    fi
    # The on-disk write should also exactly match the payload
    # (no trailing newline shenanigans — fs.writeFile mirrors the
    # contents byte-for-byte).
    if ! diff -q "$scratch_file.expected" "$scratch_file" > /dev/null 2>&1; then
        echo "[test]   large-file on-disk contents mismatch."
        echo "[test]   expected $(wc -c < "$scratch_file.expected") bytes, got $(wc -c < "$scratch_file") bytes"
        return 1
    fi
    return 0
}

run_test "sfn check runtime/sfn/adapters/filesystem.sfn passes" test_check_clean
run_test "sfn check runtime/sfn/platform/libc.sfn passes with dir/stat externs" test_libc_check_clean
run_test "sfn fmt --check is canonical for both touched modules" test_fmt_clean
run_test "libc.sfn declares stat/opendir/readdir/closedir/unlink/mkdir/rmdir" test_libc_declares_dir_stat_externs
run_test "sfn emit llvm produces define for every sfn_fs_* export" test_emit_define_shape
run_test "probe binary routes fs.{readFile,writeFile,appendFile} through @sfn_fs_*" test_probe_flipped
run_test "probe binary routes fs.{listDirectory,deleteFile,createDirectory} through @sfn_fs_*" test_probe_flipped_m31b
run_test "compiler binary exports defined sfn_fs_* family (read/write/append + list/delete/mkdir/read_bytes)" test_compiler_binary_exports
run_test "runtime/capsule.toml sfn-sources lists the adapter" test_manifest_lists_filesystem
run_test "fs.writeFile / readFile / appendFile round-trip end-to-end" test_round_trip_file
run_test "large-file round-trip exercises chunked-read grow path" test_round_trip_large_file
run_test "fs.createDirectory / listDirectory / deleteFile round-trip end-to-end" test_round_trip_list_delete_mkdir

echo "[summary] $PASS passed, $FAIL failed"
if [ "$FAIL" -gt 0 ]; then
    exit 1
fi
