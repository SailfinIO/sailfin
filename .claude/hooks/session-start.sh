#!/usr/bin/env bash
# SessionStart hook: emit a one-shot environment snapshot so the model
# starts grounded on build state. Stdout is injected as additional context.

set -euo pipefail

cd "${CLAUDE_PROJECT_DIR:-$(pwd)}"

echo "## Sailfin session bootstrap"

if [[ -x build/native/sailfin ]]; then
  version=$(ulimit -v 8388608 2>/dev/null; timeout 5 build/native/sailfin version 2>/dev/null | head -n1 || echo "(version probe failed)")
  echo "- compiler: build/native/sailfin present — $version"
else
  echo "- compiler: build/native/sailfin MISSING — run \`make compile\` to self-host from the seed"
fi

if compgen -G "build/seed/*" >/dev/null; then
  echo "- seed: build/seed present"
else
  echo "- seed: MISSING — run \`make fetch-seed\`"
fi

if [[ -x build/native/sailfin-seedcheck ]]; then
  echo "- seedcheck: build/native/sailfin-seedcheck present"
else
  echo "- seedcheck: not built (only needed for \`make check\`)"
fi

branch=$(git branch --show-current 2>/dev/null || echo "(detached)")
echo "- branch: $branch"

version_pin=$(grep -E '^version' compiler/capsule.toml 2>/dev/null | head -n1 | tr -d '"' || true)
[[ -n "$version_pin" ]] && echo "- capsule: $version_pin"

cat <<'MSG'

Reminders:
- Always `ulimit -v 8388608` before running the compiler (the PreToolUse hook will block otherwise).
- Work lives on the `claude/*` branch; PRs auto-close issues via `Closes #N`.
- Roadmap: site/src/pages/roadmap.astro. Status: docs/status.md.
MSG
