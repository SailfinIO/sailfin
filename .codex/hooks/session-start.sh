#!/usr/bin/env bash
# Codex SessionStart hook: emit a compact project snapshot that keeps Sailfin's
# self-hosted compiler constraints visible at the start of every session.

set -euo pipefail

repo_root=$(git rev-parse --show-toplevel 2>/dev/null || pwd)
cd "$repo_root"

printf '## Sailfin Codex session bootstrap\n'

if [[ -x build/native/sailfin ]]; then
  version=$(ulimit -v 8388608 2>/dev/null; timeout 5 build/native/sailfin version 2>/dev/null | head -n1 || true)
  if [[ -n "$version" ]]; then
    printf -- '- compiler: build/native/sailfin present — %s\n' "$version"
  else
    printf -- '- compiler: build/native/sailfin present — version probe failed\n'
  fi
else
  printf -- '- compiler: build/native/sailfin MISSING — run `ulimit -v 8388608 && make compile` to self-host from the seed\n'
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

branch=$(git branch --show-current 2>/dev/null || printf '(detached)')
printf -- '- branch: %s\n' "$branch"

version_pin=$(sed -n 's/^version[[:space:]]*=[[:space:]]*"\([^"]*\)".*/version = \1/p' compiler/capsule.toml 2>/dev/null | head -n1 || true)
[[ -n "$version_pin" ]] && printf -- '- capsule: %s\n' "$version_pin"

cat <<'MSG'

Reminders:
- Always prefix Sailfin compiler or make invocations with `ulimit -v 8388608 &&`.
- Prefer feature branches named `codex/<issue-or-topic>-<slug>`.
- Status source of truth: docs/status.md. Roadmap: site/src/pages/roadmap.astro.
- For issue pickup, use .codex/prompts/pickup.md as the web/CLI prompt template.
MSG
