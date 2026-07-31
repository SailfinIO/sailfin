#!/usr/bin/env bash
# SessionStart hook: install the pinned sfn toolchain, then emit a one-shot
# environment snapshot so the model starts grounded on build state. Stdout is
# injected as additional context.
#
# The toolchain install is the native path, not `make fetch-seed`: once any
# `sfn` exists it is `sfn dev bootstrap fetch` (SFEP-0047), which reads the
# same `bootstrap.toml [seed]` pin and reconciles the repo-local store. Only a
# cold container with no `sfn` at all falls back to `./install.sh` — the
# curlable installer `make fetch-seed` itself shells out to. Nothing here goes
# through the Makefile, so retiring it does not touch this hook.
#
# Never fatal: a failed fetch degrades to a reported status line rather than
# blocking session start. `SAILFIN_SESSION_BOOTSTRAP=off` skips the install.

set -euo pipefail

cd "${CLAUDE_PROJECT_DIR:-$(pwd)}"

# Read one `key = "value"` from a `[section]` of bootstrap.toml.
_manifest() {
  awk -v want_section="[$1]" -v want_key="$2" '
    /^\[[^]]+\]/ { section = $0 }
    section == want_section && $1 == want_key {
      gsub(/"/, "", $3); print $3; exit
    }
  ' bootstrap.toml 2>/dev/null
}

SEED_VERSION="$(_manifest seed version)"
SEED_INSTALL_BASE="$(_manifest store install_base)"
SEED_BIN_DIR="$(_manifest store bin_dir)"
SEED_INSTALL_BASE="${SEED_INSTALL_BASE:-build/toolchains/seed/versions}"
SEED_BIN_DIR="${SEED_BIN_DIR:-build/toolchains/seed/bin}"

# Any `sfn` that can drive the native bootstrap: a self-hosted build first, then
# the repo-local seed, then whatever is on PATH.
_any_sfn() {
  for candidate in build/bin/sfn "$SEED_BIN_DIR/sfn"; do
    [[ -x "$candidate" ]] && { echo "$candidate"; return 0; }
  done
  command -v sfn 2>/dev/null || return 1
}

install_seed() {
  if [[ "${SAILFIN_SESSION_BOOTSTRAP:-on}" == "off" ]]; then
    echo "- toolchain: install skipped (SAILFIN_SESSION_BOOTSTRAP=off)"
    return 0
  fi
  if [[ -z "$SEED_VERSION" ]]; then
    echo "- toolchain: bootstrap.toml has no [seed].version — cannot install"
    return 0
  fi

  local driver out rc
  if driver="$(_any_sfn)"; then
    # Native, idempotent, and a no-op when the store already holds the pin.
    out=$(timeout 300 "$driver" dev bootstrap fetch 2>&1) && rc=0 || rc=$?
    if [[ $rc -eq 0 ]]; then
      echo "- toolchain: sfn $SEED_VERSION installed — $(echo "$out" | tail -n1)"
    else
      echo "- toolchain: \`$driver dev bootstrap fetch\` FAILED (rc=$rc)"
      echo "$out" | tail -n 3 | sed 's/^/  /'
    fi
    return 0
  fi

  # Cold container: no sfn anywhere, so the native path has nothing to run.
  echo "- toolchain: no sfn present — installing pinned seed $SEED_VERSION"
  mkdir -p "$SEED_BIN_DIR"
  if out=$(REPO="$(_manifest seed repo)" VERSION="$SEED_VERSION" \
      BINARY="$(_manifest seed asset_prefix)" \
      INSTALL_BASE="$SEED_INSTALL_BASE" GLOBAL_BIN_DIR="$SEED_BIN_DIR" \
      timeout 300 ./install.sh 2>&1); then
    echo "  installed $("$SEED_BIN_DIR/sfn" version 2>/dev/null | head -n1)"
  else
    echo "  install FAILED — run \`sfn dev bootstrap fetch\` (or \`make fetch-seed\`) manually"
    echo "$out" | tail -n 5 | sed 's/^/  /'
  fi
}

echo "## Sailfin session bootstrap"

install_seed

if [[ -x build/bin/sfn ]]; then
  version=$(timeout 5 build/bin/sfn version 2>/dev/null | head -n1 || echo "(version probe failed)")
  echo "- compiler: build/bin/sfn present — $version"
else
  # `make compile`, not `sfn dev bootstrap build`: the native command stops at
  # build/sailfin/program, and the Makefile still owns installing that to
  # build/bin/sfn plus the fingerprint/stamp bookkeeping.
  echo "- compiler: build/bin/sfn MISSING — run \`make compile\` to self-host from the seed"
fi

if [[ -x build/bin/sfn-seedcheck ]]; then
  echo "- seedcheck: build/bin/sfn-seedcheck present"
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

# Put both the self-hosted compiler and the seed on PATH for the session, so a
# bare `sfn` resolves — build/bin first, so a freshly self-hosted compiler wins
# over the seed.
if [[ -n "${CLAUDE_ENV_FILE:-}" ]]; then
  {
    echo "export PATH=\"$PWD/build/bin:$PWD/$SEED_BIN_DIR:\$PATH\""
  } >> "$CLAUDE_ENV_FILE"
  echo "- PATH: build/bin and $SEED_BIN_DIR exported for this session"
fi
