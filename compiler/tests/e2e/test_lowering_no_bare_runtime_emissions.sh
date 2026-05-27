#!/usr/bin/env bash
# End-to-end audit for issue #727 — pin the hardcoded
# `@sailfin_runtime_*` call-site emissions under the LLVM lowering
# directories against an explicit allowlist.
#
# Why this exists:
#
# The runtime helper descriptor registry in
# `compiler/src/llvm/runtime_helpers.sfn` is the single source of truth
# for runtime call symbols. Each descriptor carries a `symbol`
# (legacy C entrypoint) and an optional `native_signature` (canonical
# Sailfin-native `sfn_*` entrypoint). Call-site emission resolves the
# symbol through `effective_symbol = native_signature ?? symbol` so a
# single descriptor flip migrates every call site in lockstep.
#
# Hardcoded `@sailfin_runtime_*` strings pushed straight into the
# emitted IR (via `lines.push("…")` or `wrapper_lines.push("…")`)
# bypass that resolution. When M2.4a/M2.6/M2.8 flipped descriptors,
# the bypass sites linked against the *old* symbol and the wave PR
# crashed with `use of undefined value '@sailfin_runtime_print_err'`.
# The lockstep update was caught by hand, not by tooling.
#
# This test mechanises the guard: every match against the audit grep
# must appear in the allowlist (with the exact line number), and every
# allowlist entry must be matched by an actual line. A new
# hardcoded emission lands → the test fails until the author either
# (a) routes it through the descriptor registry or (b) adds it to
# the allowlist with a one-line bypass comment in the source.
#
# Allowlist format: `compiler/tests/e2e/fixtures/runtime_emission_allowlist.txt`
# Each non-comment line is the verbatim `grep -nE` output
# (`<repo-rel path>:<line>:<source line>`).
#
# Usage:
#   compiler/tests/e2e/test_lowering_no_bare_runtime_emissions.sh <compiler-binary>
#
# The compiler binary argument is accepted but unused — this is a
# pure source-audit test. We take it so the e2e harness can pass
# `$(NATIVE_BIN)` uniformly to every shell test.

set -euo pipefail

# Argument required for harness uniformity (every e2e shell test
# takes the compiler binary as $1, even when unused — keeps
# accidental mis-invocations like `bash …test.sh` from silently
# passing).
BINARY="${1:?usage: test_lowering_no_bare_runtime_emissions.sh <compiler-binary>}"
if [ ! -e "$BINARY" ]; then
    echo "[test] FAIL: compiler binary not found at $BINARY"
    exit 1
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../../.." && pwd)"
ALLOWLIST="$SCRIPT_DIR/fixtures/runtime_emission_allowlist.txt"

if [ ! -f "$ALLOWLIST" ]; then
    echo "[test] FAIL: allowlist missing at $ALLOWLIST"
    exit 1
fi

# Audit grep: catches any `call ... @sailfin_runtime_…` literal inside
# a pushed IR string. The `[^"]*` between `call` and `@` keeps the
# match within a single emitted IR token so comment lines that happen
# to mention the symbol elsewhere don't trip the audit; pure
# `// …` comment lines are dropped below for the same reason.
ACTUAL="$(cd "$REPO_ROOT" && \
    grep -rnE 'call [^"]*@sailfin_runtime_' \
        compiler/src/llvm/lowering/ \
        compiler/src/llvm/expression_lowering/native/ 2>/dev/null \
    | grep -vE ':[[:space:]]*//' \
    | sort || true)"

EXPECTED="$(grep -vE '^[[:space:]]*(#|$)' "$ALLOWLIST" | sort)"

if [ "$ACTUAL" != "$EXPECTED" ]; then
    echo "[test] FAIL: runtime emission audit drift"
    echo "[test]   Allowlist: $ALLOWLIST"
    echo "[test]   Audit:     grep -rnE 'call [^\"]*@sailfin_runtime_' \\"
    echo "[test]                compiler/src/llvm/lowering/ \\"
    echo "[test]                compiler/src/llvm/expression_lowering/native/"
    echo "[test]"
    echo "[test]   Diff (expected vs actual):"
    diff <(printf '%s\n' "$EXPECTED") <(printf '%s\n' "$ACTUAL") \
        | sed 's/^/[test]     /' || true
    echo "[test]"
    echo "[test]   To fix:"
    echo "[test]     - New emission?  Route it through the descriptor"
    echo "[test]       registry (emit_runtime_call / effective_symbol)"
    echo "[test]       or add the verbatim grep line to the allowlist"
    echo "[test]       with a '// Registry bypass: …' source comment."
    echo "[test]     - Moved line?    Re-justify the bypass and update"
    echo "[test]       the allowlist's pinned line number."
    echo "[test]     - Removed?       Delete the allowlist entry too."
    exit 1
fi

# Bypass-comment invariant: every allowlisted entry must carry a
# `// Registry bypass:` justification within the 10 lines immediately
# preceding the call site. The fixture file documents this invariant
# (`Every allowlist entry must carry a one-line // Registry bypass: …
# comment immediately above the call site`); enforcing it here keeps
# the docs honest and the audit's signal/noise ratio high.
missing_marker=""
while IFS= read -r entry; do
    [ -z "$entry" ] && continue
    file="${entry%%:*}"
    rest="${entry#*:}"
    line_no="${rest%%:*}"
    if [ -z "$file" ] || [ -z "$line_no" ]; then continue; fi
    start=$(( line_no - 10 ))
    if [ "$start" -lt 1 ]; then start=1; fi
    end=$(( line_no - 1 ))
    if [ "$end" -lt 1 ]; then end=1; fi
    if ! sed -n "${start},${end}p" "$REPO_ROOT/$file" \
            | grep -qE '//[[:space:]]*Registry bypass:'; then
        missing_marker="${missing_marker}${file}:${line_no}\n"
    fi
done <<EOF
$EXPECTED
EOF

if [ -n "$missing_marker" ]; then
    echo "[test] FAIL: allowlist invariant violated — missing bypass comment"
    echo "[test]   The fixture file requires each allowlisted call site to"
    echo "[test]   carry a '// Registry bypass: …' comment within the 10"
    echo "[test]   lines immediately above the call. These entries are"
    echo "[test]   missing it:"
    printf '%b' "$missing_marker" | sed 's/^/[test]     - /'
    exit 1
fi

matches="$(printf '%s\n' "$ACTUAL" | grep -c '.' || true)"
echo "[test] PASS: $matches allowlisted runtime emission(s) match audit"
exit 0
