#!/usr/bin/env bash
# SessionStart hook: emit a one-shot environment snapshot so the model
# starts grounded on build state. Stdout is injected as additional context.

set -euo pipefail

cd "${CLAUDE_PROJECT_DIR:-$(pwd)}"

echo "## Sailfin session bootstrap"

if [[ -x build/native/sailfin ]]; then
  version=$(timeout 5 build/native/sailfin version 2>/dev/null | head -n1 || echo "(version probe failed)")
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

if [[ ! -f tools/mcp-server/dist/index.js ]]; then
  echo "- mcp-server: building tools/mcp-server..."
  (cd tools/mcp-server && npm ci --no-audit --no-fund --silent && npm run build --silent) 2>&1 | tail -n 3 || echo "  (mcp-server build failed — MCP tools unavailable)"
else
  echo "- mcp-server: tools/mcp-server/dist present"
fi

branch=$(git branch --show-current 2>/dev/null || echo "(detached)")
echo "- branch: $branch"

version_pin=$(grep -E '^version' compiler/capsule.toml 2>/dev/null | head -n1 | tr -d '"' || true)
[[ -n "$version_pin" ]] && echo "- capsule: $version_pin"

cat <<'MSG'

Reminders:
- The compiler self-caps memory at 8 GiB on Linux (`SAILFIN_MEM_LIMIT` to override); still wrap single-file compiles with `timeout 60`.
- Work lives on `claude/*` branches (`/pickup` uses `claude/sfn-<N>-…`); PRs cite `Fixes SFN-<N>` so Linear closes the issue on merge.
- Roadmap: site/src/pages/roadmap.astro. Status: docs/status.md.
MSG
