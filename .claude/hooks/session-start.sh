#!/usr/bin/env bash
# SessionStart hook: install the pinned sfn toolchain, then emit a one-shot
# environment snapshot so the model starts grounded on build state. Stdout is
# injected as additional context.
#
# The toolchain install uses `sfn dev bootstrap fetch` once any `sfn` exists
# (SFEP-0047), which reads the
# same `bootstrap.toml [seed]` pin and reconciles the repo-local store.
# `./install.sh` — the curlable installer — is the fallback whenever that
# native path cannot deliver the pin: a cold container with no `sfn`, a driver
# that fails, or a store left on the wrong version (SFN-1118).
#
# The reconciliation is what makes the fallback reachable: an image that bakes
# a stale `sfn` into the gitignored seed store used to satisfy the "any sfn
# exists" test, run the upgrade with the very binary needing upgrading, fail,
# and report a bare rc — leaving every session on the stale seed.
#
# Never fatal: a failed install degrades to a reported status line rather than
# blocking session start. `SAILFIN_SESSION_BOOTSTRAP=off` skips the install.

set -euo pipefail

cd "${CLAUDE_PROJECT_DIR:-$(pwd)}"

# Read one `key = "value"` from a `[section]` of bootstrap.toml. An absent file
# or missing key yields "" rather than a failure: `awk` exits 2 on a file it
# cannot open, and under `set -e` that status propagated out of the
# `SEED_VERSION="$(_manifest ...)"` assignments below and killed the hook
# before it printed anything — leaving the `-z "$SEED_VERSION"` guard in
# install_seed unreachable, which is the branch written to handle exactly this
# (SFN-1118).
_manifest() {
  awk -v want_section="[$1]" -v want_key="$2" '
    /^\[[^]]+\]/ { section = $0 }
    section == want_section && $1 == want_key {
      gsub(/"/, "", $3); print $3; exit
    }
  ' bootstrap.toml 2>/dev/null || true
}

SEED_VERSION="$(_manifest seed version)"
SEED_INSTALL_BASE="$(_manifest store install_base)"
SEED_BIN_DIR="$(_manifest store bin_dir)"
SEED_INSTALL_BASE="${SEED_INSTALL_BASE:-build/toolchains/seed/versions}"
SEED_BIN_DIR="${SEED_BIN_DIR:-build/toolchains/seed/bin}"

# macOS ships neither `timeout` nor coreutils; Homebrew spells it `gtimeout`
# (docs/conventions/e2e-tests.md). Resolve once and run unbounded when neither
# exists — an unbounded probe is far better than treating a missing `timeout`
# as a failed one, which would report a healthy seed as broken on every macOS
# session.
TIMEOUT_BIN="$(command -v timeout 2>/dev/null || command -v gtimeout 2>/dev/null || true)"
_bounded() {
  local secs="$1"; shift
  if [[ -n "$TIMEOUT_BIN" ]]; then "$TIMEOUT_BIN" "$secs" "$@"; else "$@"; fi
}

# Any `sfn` that can drive the native bootstrap: a self-hosted build first, then
# the repo-local seed, then whatever is on PATH.
_any_sfn() {
  local candidate
  for candidate in build/bin/sfn "$SEED_BIN_DIR/sfn"; do
    [[ -x "$candidate" ]] || continue
    # SFN-1118: a binary that cannot report its own version cannot drive the
    # bootstrap either. Skipping it lets a working candidate further down the
    # list win instead of failing the whole native path on the first one.
    _bounded 30 "$candidate" version >/dev/null 2>&1 || continue
    echo "$candidate"
    return 0
  done
  # The PATH fallback gets the same health probe as the loop above. Without it
  # the hardening is defeatable: this hook exports build/bin and the seed dir
  # onto the session PATH, so a candidate just rejected can return here as the
  # driver under a different spelling.
  local path_sfn
  path_sfn="$(command -v sfn 2>/dev/null || true)"
  [[ -n "$path_sfn" ]] || return 1
  _bounded 30 "$path_sfn" version >/dev/null 2>&1 || return 1
  echo "$path_sfn"
}

# The version the seed store currently reports, or "" when it holds nothing
# runnable. Deliberately probes $SEED_BIN_DIR and never build/bin: the
# self-hosted compiler is built from source and its version tracks
# compiler/capsule.toml, which legitimately differs from the seed pin.
_seed_store_version() {
  [[ -x "$SEED_BIN_DIR/sfn" ]] || return 1
  # `sfn version` prints exactly `sfn <version>` on one line
  # (compiler/src/cli/commands/version.sfn). Take field 2 of line 1 rather than
  # the last field of the first line: `$NF` silently returns garbage if the
  # line ever gains a suffix, and garbage here reinstalls on every session.
  _bounded 30 "$SEED_BIN_DIR/sfn" version 2>/dev/null | awk 'NR==1 {print $2}'
}

# Install the pinned seed with the curlable installer. The only path that does
# not depend on an existing `sfn` being able to run.
_install_via_installer() {
  mkdir -p "$SEED_BIN_DIR"
  # SAILFIN_BOOTSTRAP_SEED_STORE=1 is load-bearing, not decoration: without it
  # install.sh writes `$INSTALL_BASE/<host-triple>/<version>` while
  # `sfn dev bootstrap build` reads the flat `$INSTALL_BASE/<version>/sailfin`
  # (compiler/src/cli/commands/dev.sfn `_bootstrap_seed_bin`). The bin_dir
  # aliases would still resolve, so the version probe below would report the
  # pin and this hook would print "installed seed X" over a store the native
  # bootstrap still considers empty — the exact false-green this file exists
  # to stop. The retired Makefile's install target set the same flag for the
  # same reason.
  SAILFIN_BOOTSTRAP_SEED_STORE=1 \
    REPO="$(_manifest seed repo)" VERSION="$SEED_VERSION" \
    BINARY="$(_manifest seed asset_prefix)" \
    INSTALL_BASE="$SEED_INSTALL_BASE" GLOBAL_BIN_DIR="$SEED_BIN_DIR" \
    _bounded 300 ./install.sh 2>&1
}

# True when the store holds the artifact `sfn dev bootstrap build` actually
# spawns. The version probe reads `$SEED_BIN_DIR/sfn`, which is a best-effort
# alias that can go stale, so a matching version is necessary but not
# sufficient.
_seed_store_populated() {
  [[ -x "$SEED_INSTALL_BASE/$SEED_VERSION/sailfin" ]]
}

# NOTE ON errexit: both call sites invoke this as `install_seed || ...`, and
# bash propagates `ignore_return` into a function body invoked in a condition
# context — so errexit is effectively disabled for everything below. That is
# what actually delivers the never-fatal contract. Calling this bare re-arms
# every command in the body at once; don't, without auditing each one.
install_seed() {
  if [[ "${SAILFIN_SESSION_BOOTSTRAP:-on}" == "off" ]]; then
    echo "- toolchain: install skipped (SAILFIN_SESSION_BOOTSTRAP=off)"
    return 0
  fi
  if [[ -z "$SEED_VERSION" ]]; then
    echo "- toolchain: bootstrap.toml has no [seed].version — cannot install"
    return 0
  fi

  local driver out rc installed
  if driver="$(_any_sfn)"; then
    # Native, idempotent, and a no-op when the store already holds the pin.
    out=$(_bounded 300 "$driver" dev bootstrap fetch 2>&1) && rc=0 || rc=$?
    if [[ $rc -ne 0 ]]; then
      echo "- toolchain: \`$driver dev bootstrap fetch\` FAILED (rc=$rc) — falling back to ./install.sh"
      # A driver that dies on a signal can produce no output at all, so only
      # print a detail block when there is one. Spelled as an `if` rather than
      # an `&&` list so the empty case cannot return non-zero from this block:
      # both call sites suppress errexit today, but a future bare
      # `install_seed` would otherwise abort session start here.
      if [[ -n "$out" ]]; then
        echo "$out" | tail -n 3 | sed 's/^/  /'
      fi
    fi
  fi

  # SFN-1118: reconcile the store against the pin, whichever path ran above and
  # whether or not it claimed success. This is the assertion the hook never
  # made: the old success line echoed $SEED_VERSION straight from
  # bootstrap.toml, so it reported the pin rather than what is on disk.
  installed="$(_seed_store_version || true)"
  if [[ "$installed" == "$SEED_VERSION" ]] && _seed_store_populated; then
    # Carry the fetch's own last line through: it is the only thing that
    # distinguishes "already present" from "fetched just now", i.e. whether
    # the store moved under this session.
    if [[ $rc -eq 0 && -n "$out" ]]; then
      echo "- toolchain: seed $installed matches the pin — $(echo "$out" | tail -n1)"
    else
      echo "- toolchain: seed $installed matches the pin"
    fi
    return 0
  fi

  if [[ "$installed" == "$SEED_VERSION" ]]; then
    echo "- toolchain: seed $installed matches the pin but $SEED_INSTALL_BASE/$SEED_VERSION is not populated — reinstalling"
  elif [[ -z "$installed" ]]; then
    echo "- toolchain: no runnable seed in $SEED_BIN_DIR — installing pinned $SEED_VERSION"
  else
    echo "- toolchain: seed is $installed but bootstrap.toml pins $SEED_VERSION — reinstalling"
  fi

  if out=$(_install_via_installer); then
    installed="$(_seed_store_version || true)"
    if [[ "$installed" == "$SEED_VERSION" ]] && _seed_store_populated; then
      echo "  installed seed $installed"
      return 0
    fi
    if [[ "$installed" == "$SEED_VERSION" ]]; then
      echo "  install reported success but left no $SEED_INSTALL_BASE/$SEED_VERSION/sailfin for the native bootstrap"
    else
      echo "  install reported success but the seed is ${installed:-not runnable}, not the pinned $SEED_VERSION"
    fi
    return 1
  fi

  echo "  install FAILED — seed is ${installed:-absent}, pin is $SEED_VERSION; fix before building"
  echo "$out" | tail -n 5 | sed 's/^/  /'
  return 1
}

# Test seam (SFN-1118): run only the seed install/reconcile, then exit with its
# verdict (0 = store matches the pin) and skip the environment snapshot. Lets
# compiler/tests/e2e/session_start_seed_test.sfn drive the fallback and
# reconciliation paths against a scratch CLAUDE_PROJECT_DIR, with no network
# and no real toolchain. Never leave it exported: it makes session start emit
# no context at all.
if [[ "${SAILFIN_SESSION_SEED_PROBE_ONLY:-}" == "1" ]]; then
  probe_rc=0
  install_seed || probe_rc=$?
  exit "$probe_rc"
fi

echo "## Sailfin session bootstrap"

# Never fatal (see the header): a shortfall is reported by install_seed and the
# snapshot still runs, so the session starts grounded rather than not at all.
install_seed || true

if [[ -x build/bin/sfn ]]; then
  version=$(timeout 5 build/bin/sfn version 2>/dev/null | head -n1 || echo "(version probe failed)")
  echo "- compiler: build/bin/sfn present — $version"
else
  # The native bootstrap command owns the seed build, build/bin/sfn
  # installation, and source-fingerprint bookkeeping.
  echo "- compiler: build/bin/sfn MISSING — run \`sfn dev bootstrap build\` to self-host from the seed"
fi

if [[ -x build/bin/sfn-seedcheck ]]; then
  echo "- seedcheck: build/bin/sfn-seedcheck present"
else
  echo "- seedcheck: not built (only needed for \`sfn dev verify\`)"
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
