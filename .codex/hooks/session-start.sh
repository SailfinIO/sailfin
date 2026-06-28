#!/usr/bin/env bash
# Codex SessionStart hook: emit a compact project snapshot that keeps Sailfin's
# self-hosted compiler, Sailfin-native runtime, and proposal process visible at
# the start of every session.

set -euo pipefail

repo_root=$(git rev-parse --show-toplevel 2>/dev/null || pwd)
cd "$repo_root"

printf '## Sailfin Codex session bootstrap\n'

if [[ -x build/native/sailfin ]]; then
  version=$(timeout 5 build/native/sailfin version 2>/dev/null | head -n1 || true)
  if [[ -n "$version" ]]; then
    printf -- '- compiler: build/native/sailfin present — %s\n' "$version"
  else
    printf -- '- compiler: build/native/sailfin present — version probe failed\n'
  fi
else
  printf -- '- compiler: build/native/sailfin MISSING — run `make compile` to self-host from the seed\n'
fi

if compgen -G 'build/seed/*' >/dev/null; then
  printf -- '- seed: build/seed present\n'
else
  printf -- '- seed: MISSING — run `make fetch-seed` if a build needs the released seed\n'
fi

if [[ -x build/native/sailfin-seedcheck ]]; then
  printf -- '- seedcheck: build/native/sailfin-seedcheck present\n'
else
  printf -- '- seedcheck: not built (only needed for `make check`)\n'
fi

if [[ -f tools/mcp-server/dist/index.js ]]; then
  printf -- '- mcp-server: tools/mcp-server/dist present\n'
elif [[ -d tools/mcp-server ]]; then
  printf -- '- mcp-server: not built — run `make mcp-server` if MCP tools are needed\n'
fi

branch=$(git branch --show-current 2>/dev/null || printf '(detached)')
printf -- '- branch: %s\n' "$branch"

version_pin=$(sed -n 's/^version[[:space:]]*=[[:space:]]*"\([^"]*\)".*/version = \1/p' compiler/capsule.toml 2>/dev/null | head -n1 || true)
[[ -n "$version_pin" ]] && printf -- '- capsule: %s\n' "$version_pin"

if [[ -f .seed-version ]]; then
  seed_pin=$(tr -d '[:space:]' < .seed-version)
  [[ -n "$seed_pin" ]] && printf -- '- pinned seed: v%s\n' "$seed_pin"
fi

cat <<'MSG'

Reminders:
- The compiler self-caps memory at 8 GiB on Linux (`SAILFIN_MEM_LIMIT` to override); wrap single-file compiles with `timeout 60`.
- The runtime is Sailfin-native (`runtime/prelude.sfn`, `runtime/sfn/`); do not add C runtime fixups.
- Use `sfn check <files>` for the parse/type/effect inner loop, then `make compile` for compiler-source changes.
- Status source of truth: docs/status.md. SFEP process: docs/proposals/0001-sfep-process.md. Roadmap: site/src/pages/roadmap.astro.
- Prefer feature branches named `codex/<issue-or-topic>-<slug>`.
MSG
