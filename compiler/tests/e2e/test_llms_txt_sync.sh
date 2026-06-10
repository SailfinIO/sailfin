#!/usr/bin/env bash
# llms.txt drift guard.
#
# llms.txt is the in-context language reference that LLM agents read
# before generating Sailfin code — a stale or self-contradictory copy
# directly causes systematic agent errors (the 2026-06 audit found it
# still claiming closures, bitwise operators, and int/float were
# unshipped months after they landed). This test pins the two cheap,
# mechanical freshness invariants:
#
#   1. The published site copy (site/public/llms.txt) is a symlink to
#      the repo-root llms.txt, so there is exactly one source of truth.
#   2. The "> Version:" line in llms.txt matches the compiler version
#      in compiler/capsule.toml, so every release bump forces an
#      llms.txt review (the version line cannot silently go stale).
#
# Content accuracy beyond the version stamp is a review concern
# (docs/status.md is the source of truth); this guard only makes
# drift loud.

set -u

ROOT="$(cd "$(dirname "$0")/../../.." && pwd)"
fail=0

# ── 1. Single source of truth ────────────────────────────────────────
SITE_COPY="$ROOT/site/public/llms.txt"
if [ ! -L "$SITE_COPY" ]; then
    echo "FAIL: $SITE_COPY is not a symlink — two divergent llms.txt copies are possible"
    fail=1
elif [ ! -e "$SITE_COPY" ]; then
    echo "FAIL: $SITE_COPY is a broken symlink"
    fail=1
else
    resolved="$(cd "$(dirname "$SITE_COPY")" && cd "$(dirname "$(readlink "$SITE_COPY")")" && pwd)/$(basename "$(readlink "$SITE_COPY")")"
    if [ "$resolved" != "$ROOT/llms.txt" ]; then
        echo "FAIL: $SITE_COPY resolves to $resolved, expected $ROOT/llms.txt"
        fail=1
    else
        echo "ok: site/public/llms.txt -> llms.txt (single source of truth)"
    fi
fi

# ── 2. Version line matches capsule.toml ─────────────────────────────
capsule_version="$(sed -n 's/^version = "\(.*\)"$/\1/p' "$ROOT/compiler/capsule.toml" | head -1)"
llms_version="$(sed -n 's/^> Version: \([^ |]*\).*/\1/p' "$ROOT/llms.txt" | head -1)"

if [ -z "$capsule_version" ]; then
    echo "FAIL: could not extract version from compiler/capsule.toml"
    fail=1
fi
if [ -z "$llms_version" ]; then
    echo "FAIL: could not find '> Version: <semver>' line in llms.txt"
    fail=1
fi
if [ -n "$capsule_version" ] && [ -n "$llms_version" ]; then
    if [ "$capsule_version" != "$llms_version" ]; then
        echo "FAIL: llms.txt version '$llms_version' != capsule.toml version '$capsule_version'"
        echo "      Update the '> Version:' line (and review llms.txt content against docs/status.md)."
        fail=1
    else
        echo "ok: llms.txt version matches capsule.toml ($capsule_version)"
    fi
fi

if [ "$fail" -ne 0 ]; then
    echo "test_llms_txt_sync: FAILED"
    exit 1
fi
echo "test_llms_txt_sync: all checks passed"
