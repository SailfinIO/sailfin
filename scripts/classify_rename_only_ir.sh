#!/usr/bin/env bash
# Classify a textual IR diff after a module or capsule rename.
#
# Usage:
#   scripts/classify_rename_only_ir.sh BEFORE AFTER RENAME_MAP
#
# RENAME_MAP is UTF-8 text with one tab-separated OLD<TAB>NEW pair per line.
# Blank lines and lines beginning with `#` are ignored. Both spellings are
# normalized to the same marker before comparison, so a successful result
# proves every remaining byte is identical. Put broader/longer names in any
# order; the normalizer sorts pairs longest-first to avoid prefix overlap.
set -euo pipefail

if [ "$#" -ne 3 ]; then
    echo "usage: $0 BEFORE AFTER RENAME_MAP" >&2
    exit 2
fi

before=$1
after=$2
rename_map=$3

for input in "$before" "$after" "$rename_map"; do
    if [ ! -f "$input" ]; then
        echo "rename-only: missing input: $input" >&2
        exit 2
    fi
done

awk -F '\t' '
    /^[[:space:]]*$/ || /^#/ { next }
    NF != 2 || $1 == "" || $2 == "" {
        print "rename-only: malformed map line " NR ": expected OLD<TAB>NEW" > "/dev/stderr"
        exit 2
    }
    { count += 1 }
    END {
        if (count == 0) {
            print "rename-only: map contains no rename pairs" > "/dev/stderr"
            exit 2
        }
    }
' "$rename_map"

normalize() {
    awk -v map_file="$rename_map" '
        function replace_fixed(text, needle, replacement,    at, out) {
            if (needle == "") { return text }
            out = ""
            while ((at = index(text, needle)) > 0) {
                out = out substr(text, 1, at - 1) replacement
                text = substr(text, at + length(needle))
            }
            return out text
        }
        BEGIN {
            FS = "\t"
            while ((getline map_line < map_file) > 0) {
                if (map_line ~ /^[[:space:]]*$/ || map_line ~ /^#/) { continue }
                split(map_line, fields, "\t")
                count += 1
                old[count] = fields[1]
                new[count] = fields[2]
                width[count] = length(old[count])
                if (length(new[count]) > width[count]) { width[count] = length(new[count]) }
            }
            close(map_file)
            for (i = 1; i <= count; i += 1) {
                for (j = i + 1; j <= count; j += 1) {
                    if (width[j] > width[i]) {
                        swap = old[i]; old[i] = old[j]; old[j] = swap
                        swap = new[i]; new[i] = new[j]; new[j] = swap
                        swap = width[i]; width[i] = width[j]; width[j] = swap
                    }
                }
            }
        }
        {
            line = $0
            for (i = 1; i <= count; i += 1) {
                marker = "__SFN_RENAME_" i "__"
                # The old spelling is commonly a suffix of the new spelling
                # (`parser__mod` inside `sfn__syntax__parser__mod`), so replace
                # NEW first or the old suffix would strand the new prefix.
                line = replace_fixed(line, new[i], marker)
                line = replace_fixed(line, old[i], marker)
            }
            print line
        }
    ' "$1"
}

ends_with_newline() {
    if [ "$(tail -c 1 "$1" | od -An -tx1 | tr -d '[:space:]')" = "0a" ]; then
        echo yes
    else
        echo no
    fi
}

# awk's record API prints a newline after each normalized record. Compare the
# original EOF state separately so a missing final newline cannot disappear in
# normalization and produce a false byte-identical verdict.
if [ "$(ends_with_newline "$before")" != "$(ends_with_newline "$after")" ]; then
    echo "rename-only: FAIL: final-byte state differs" >&2
    exit 1
fi

if cmp -s <(normalize "$before") <(normalize "$after"); then
    echo "rename-only: PASS: $before -> $after"
    exit 0
fi

echo "rename-only: FAIL: non-rename differences remain" >&2
diff -u <(normalize "$before") <(normalize "$after") || true
exit 1
