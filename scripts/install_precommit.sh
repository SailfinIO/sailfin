#!/usr/bin/env bash
# install_precommit.sh — opt-in pre-commit hook for Sailfin contributors.
#
# Installs a Git pre-commit hook that runs `make check-fast` (a
# `sfn check compiler/src/ runtime/` invocation, ~2 min) so contributors
# catch parser, typecheck, and effect-system breakage before pushing.
#
# This is opt-in by design — it adds ~2 min to every commit, which is a
# fair trade for committers actively touching compiler/src/ but excessive
# for docs-only or release-tooling work.
#
# Usage:
#   bash scripts/install_precommit.sh           # install the hook
#   bash scripts/install_precommit.sh --remove  # uninstall the hook
#
# The installed hook respects two escape hatches:
#   - `git commit --no-verify` skips it entirely (standard git behavior)
#   - `SAILFIN_SKIP_PRECOMMIT=1 git commit ...` skips it without --no-verify
#     (so other hooks like commit-msg still run)

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
HOOK_PATH="$REPO_ROOT/.git/hooks/pre-commit"
MARKER="# sailfin-precommit-v1"

usage() {
    sed -n '2,18p' "${BASH_SOURCE[0]}" | sed 's/^# \{0,1\}//'
    exit 0
}

case "${1:-}" in
    -h|--help) usage ;;
    --remove)
        if [ ! -e "$HOOK_PATH" ]; then
            echo "[install-precommit] no hook installed at $HOOK_PATH"
            exit 0
        fi
        if ! grep -q "$MARKER" "$HOOK_PATH" 2>/dev/null; then
            echo "[install-precommit] hook at $HOOK_PATH was not installed by this script; refusing to remove" >&2
            exit 1
        fi
        rm -f "$HOOK_PATH"
        echo "[install-precommit] removed $HOOK_PATH"
        exit 0
        ;;
    "") ;;
    *)
        echo "[install-precommit] unknown argument: $1" >&2
        echo "Usage: $0 [--remove]" >&2
        exit 1
        ;;
esac

if [ ! -d "$REPO_ROOT/.git" ]; then
    echo "[install-precommit] $REPO_ROOT is not a git repository" >&2
    exit 1
fi

if [ -e "$HOOK_PATH" ] && ! grep -q "$MARKER" "$HOOK_PATH" 2>/dev/null; then
    backup="$HOOK_PATH.bak.$(date +%s)"
    echo "[install-precommit] existing hook found; backing up to $backup"
    mv "$HOOK_PATH" "$backup"
fi

cat > "$HOOK_PATH" <<'HOOK'
#!/usr/bin/env bash
# sailfin-precommit-v1
#
# Runs `make check-fast` to surface parser/typecheck/effect breakage
# before committing. Skip with `git commit --no-verify` or
# `SAILFIN_SKIP_PRECOMMIT=1 git commit ...`.
set -euo pipefail

if [ "${SAILFIN_SKIP_PRECOMMIT:-0}" = "1" ]; then
    echo "[pre-commit] SAILFIN_SKIP_PRECOMMIT=1 — skipping check-fast"
    exit 0
fi

# Only run if a compiler/runtime source actually changed.
changed=$(git diff --cached --name-only --diff-filter=ACMR | \
    grep -E '^(compiler/src/|runtime/)' || true)
if [ -z "$changed" ]; then
    exit 0
fi

if [ ! -x build/native/sailfin ]; then
    echo "[pre-commit] build/native/sailfin not built; skipping check-fast"
    echo "[pre-commit] run 'make compile' to enable the pre-commit gate"
    exit 0
fi

echo "[pre-commit] running 'make check-fast' (set SAILFIN_SKIP_PRECOMMIT=1 to skip)"
if ! make check-fast; then
    echo ""
    echo "[pre-commit] check-fast failed. Fix the diagnostics above, or"
    echo "[pre-commit] bypass with: git commit --no-verify"
    exit 1
fi
HOOK
chmod +x "$HOOK_PATH"

echo "[install-precommit] installed $HOOK_PATH"
echo "[install-precommit] runs 'make check-fast' on commits touching compiler/src/ or runtime/"
echo "[install-precommit] skip with: SAILFIN_SKIP_PRECOMMIT=1 git commit ...   (or --no-verify)"
echo "[install-precommit] uninstall with: bash scripts/install_precommit.sh --remove"
