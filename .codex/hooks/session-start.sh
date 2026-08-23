#!/usr/bin/env bash
# Codex SessionStart hook: emit dynamic build state. Durable project guidance
# belongs in AGENTS.md and task-specific skills.
# shellcheck disable=SC2016 # Markdown backticks in status text are literal.

set -euo pipefail

repo_root=$(git rev-parse --show-toplevel 2>/dev/null || pwd)
cd "$repo_root"

printf '## Sailfin Codex session bootstrap\n'

if [[ -x build/bin/sfn ]]; then
  version=$(timeout 5 build/bin/sfn version 2>/dev/null | head -n1 || true)
  if [[ -n "$version" ]]; then
    printf -- '- compiler: build/bin/sfn present — %s\n' "$version"
  else
    printf -- '- compiler: build/bin/sfn present — version probe failed\n'
  fi
else
  printf -- '- compiler: build/bin/sfn MISSING — run `sfn dev bootstrap build` to self-host from the seed\n'
fi

if compgen -G 'build/toolchains/seed/*' >/dev/null; then
  printf -- '- seed: build/toolchains/seed present\n'
else
  printf -- '- seed: MISSING — run `sfn dev bootstrap fetch` if a build needs the released seed\n'
fi

if [[ -x build/bin/sfn-seedcheck ]]; then
  printf -- '- seedcheck: build/bin/sfn-seedcheck present\n'
else
  printf -- '- seedcheck: not built (only needed for `sfn dev verify`)\n'
fi

if [[ -f tools/mcp-server/dist/index.js ]]; then
  printf -- '- mcp-server: tools/mcp-server/dist present\n'
elif [[ -d tools/mcp-server ]]; then
  printf -- '- mcp-server: not built — run `(cd tools/mcp-server && npm ci --no-audit --no-fund && npm run build)` if MCP tools are needed\n'
fi

branch=$(git branch --show-current 2>/dev/null || printf '(detached)')
printf -- '- branch: %s\n' "$branch"

version_pin=$(sed -n 's/^version[[:space:]]*=[[:space:]]*"\([^"]*\)".*/version = \1/p' compiler/capsule.toml 2>/dev/null | head -n1 || true)
[[ -n "$version_pin" ]] && printf -- '- capsule: %s\n' "$version_pin"

if [[ -f bootstrap.toml ]]; then
  seed_pin=$(awk '
    /^\[[^]]+\]/ { section=$0 }
    section == "[seed]" && /^version[[:space:]]*=/ { gsub(/"/, "", $3); print $3; exit }
  ' bootstrap.toml)
  [[ -n "$seed_pin" ]] && printf -- '- pinned seed: v%s\n' "$seed_pin"
fi
