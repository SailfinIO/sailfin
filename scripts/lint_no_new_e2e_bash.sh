#!/usr/bin/env bash
# Anti-regrowth ratchet for e2e bash scripts — test-infra Phase 3 (#842),
# sub-issue #1327.
#
# The sfn/test framework (capsules/sfn/test) has been the supported way to
# write end-to-end tests since Phase 1, yet compiler/tests/e2e/*.sh grew
# 38 -> 122 because dropping a new .sh in that directory "just works" with
# no friction. This lint is the friction: it flags any test_*.sh that is
# not on the grandfathered allowlist so reviewers catch new bash before it
# compounds the migration backlog.
#
# WARN-FIRST (per maintainer decision 2026-06-13): an off-allowlist script
# is reported as a warning and the script still exits 0, so it does not
# break in-flight PRs. Once the #842 batch ports drain the allowlist down
# to the permanent hold-outs, a follow-up flips RATCHET_MODE to "fail".
#
# Usage:
#   scripts/lint_no_new_e2e_bash.sh            # warn-first (default)
#   RATCHET_MODE=fail scripts/lint_no_new_e2e_bash.sh
#
# Exit codes:
#   0  no off-allowlist scripts (or warn-first mode, regardless of findings)
#   1  off-allowlist scripts found AND RATCHET_MODE=fail

set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
e2e_dir="$repo_root/compiler/tests/e2e"
allowlist="$repo_root/scripts/e2e_bash_allowlist.txt"
mode="${RATCHET_MODE:-warn}"

# Emit a GitHub Actions annotation when running in CI, a plain line otherwise.
annotate() {
    local level="$1" msg="$2"
    if [ -n "${GITHUB_ACTIONS:-}" ]; then
        echo "::${level}::${msg}"
    else
        echo "[${level}] ${msg}"
    fi
}

if [ ! -f "$allowlist" ]; then
    echo "lint_no_new_e2e_bash: missing allowlist $allowlist" >&2
    exit 2
fi

# Allowlisted basenames (strip comments + blank lines).
allowed="$(grep -vE '^#|^[[:space:]]*$' "$allowlist" | sort -u)"

# Current scripts on disk.
present="$(find "$e2e_dir" -maxdepth 1 -name 'test_*.sh' -printf '%f\n' | sort -u)"

# (1) New scripts: present on disk, absent from the allowlist.
new_scripts="$(comm -23 <(printf '%s\n' "$present") <(printf '%s\n' "$allowed"))"

# (2) Stale entries: allowlisted but no longer on disk — a migrated script
#     whose line was not removed. Always a warning (never fatal); keeps the
#     allowlist honest as batches land.
stale_entries="$(comm -13 <(printf '%s\n' "$present") <(printf '%s\n' "$allowed"))"

status=0

if [ -n "$stale_entries" ]; then
    while IFS= read -r s; do
        [ -z "$s" ] && continue
        annotate warning "stale allowlist entry: $s no longer exists — remove it from scripts/e2e_bash_allowlist.txt"
    done <<< "$stale_entries"
fi

if [ -n "$new_scripts" ]; then
    while IFS= read -r s; do
        [ -z "$s" ] && continue
        local_msg="new e2e bash script compiler/tests/e2e/$s — write end-to-end tests as *_test.sfn using sfn/test (see .claude/rules/no-bash-e2e.md). If this genuinely needs bash, add it to scripts/e2e_bash_allowlist.txt with justification in the PR."
        if [ "$mode" = "fail" ]; then
            annotate error "$local_msg"
            status=1
        else
            annotate warning "$local_msg"
        fi
    done <<< "$new_scripts"
else
    echo "[lint] no off-allowlist e2e bash scripts — ratchet clean ($(printf '%s\n' "$present" | grep -c . ) scripts, all grandfathered)"
fi

if [ "$mode" != "fail" ] && [ -n "$new_scripts" ]; then
    echo "[lint] warn-first mode: not failing the build (set RATCHET_MODE=fail to enforce)"
fi

exit "$status"
