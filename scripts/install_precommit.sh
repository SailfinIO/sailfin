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
MARKER="# sailfin-precommit-v1"

usage() {
    sed -n '2,18p' "${BASH_SOURCE[0]}" | sed 's/^# \{0,1\}//'
    exit 0
}

# Resolve the pre-commit hook path via `git rev-parse` so the installer
# works in worktrees and submodules where `.git` is a file pointing at
# the real git dir, not a directory.
resolve_hook_path() {
    if ! git -C "$REPO_ROOT" rev-parse --is-inside-work-tree >/dev/null 2>&1; then
        echo "[install-precommit] $REPO_ROOT is not a git working tree" >&2
        exit 1
    fi
    local p
    p="$(git -C "$REPO_ROOT" rev-parse --git-path hooks/pre-commit)"
    if [ -z "$p" ]; then
        echo "[install-precommit] git rev-parse returned empty hooks path" >&2
        exit 1
    fi
    # `--git-path` returns a path relative to CWD when the result is
    # inside the repo; absolutise it for the install/remove operations.
    case "$p" in
        /*) printf '%s\n' "$p" ;;
        *)  printf '%s\n' "$REPO_ROOT/$p" ;;
    esac
}

case "${1:-}" in
    -h|--help) usage ;;
    --remove)
        HOOK_PATH="$(resolve_hook_path)"
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

HOOK_PATH="$(resolve_hook_path)"
mkdir -p "$(dirname "$HOOK_PATH")"

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

# Only run if a compiler/runtime source actually changed. The diff filter
# includes deletions (D) — removing a source file can break the build
# just as easily as editing one, so the gate must fire either way.
changed=$(git diff --cached --name-only --diff-filter=ACMRD | \
    grep -E '^(compiler/src/|runtime/)' || true)
if [ -z "$changed" ]; then
    exit 0
fi

# Defer binary detection to `make check-fast` itself — it knows the
# correct $(NATIVE_BIN) for the platform (including .exe on Windows)
# and emits a clear "missing; run make compile" message when absent.
# That way the hook stays platform-agnostic and doesn't drift from the
# Makefile if NATIVE_BIN is overridden or EXE_EXT changes.
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
