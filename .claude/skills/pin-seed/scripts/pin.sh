#!/usr/bin/env bash
set -euo pipefail

VERSION="${1:-}"
if [ -z "$VERSION" ]; then
  echo "[pin-seed] Usage: pin.sh <version>  (e.g. 0.5.10-alpha.12)" >&2
  exit 1
fi

# Strip leading v/V — bootstrap.toml [seed].version stores bare versions
VERSION="${VERSION#v}"
VERSION="${VERSION#V}"

if [ -z "$VERSION" ]; then
  echo "[pin-seed] error: version is empty after stripping leading 'v' — pass a full version like 0.5.10-alpha.12" >&2
  exit 1
fi

REPO_ROOT="$(git rev-parse --show-toplevel 2>/dev/null)" || {
  echo "[pin-seed] error: not inside a git repository" >&2
  exit 1
}
BOOTSTRAP_FILE="$REPO_ROOT/bootstrap.toml"
CAPSULE_FILE="$REPO_ROOT/compiler/capsule.toml"

if [ ! -f "$BOOTSTRAP_FILE" ]; then
  echo "[pin-seed] error: $BOOTSTRAP_FILE is missing — run inside a compiler checkout" >&2
  exit 1
fi

# Read the current pin from bootstrap.toml [seed].version for the log line.
OLD="$(awk '
  /^\[[^]]+\]/ { section=$0 }
  section == "[seed]" && /^version[[:space:]]*=/ { gsub(/"/, "", $3); print $3; exit }
' "$BOOTSTRAP_FILE")"
echo "[pin-seed] current pin: ${OLD:-(none)}"
echo "[pin-seed] new pin:     $VERSION"

# Rewrite bootstrap.toml [seed].version. Atomic: awk to a temp file in the same
# directory, then mv (a within-filesystem rename). Fail closed if the awk did
# not actually rewrite a version line.
TMP="$(mktemp "$REPO_ROOT/bootstrap.toml.XXXXXX")"
awk -v v="$VERSION" '
  /^\[[^]]+\]/ { section=$0 }
  section == "[seed]" && /^version[[:space:]]*=/ { sub(/"[^"]*"/, "\"" v "\""); done=1 }
  { print }
  END { if (!done) exit 3 }
' "$BOOTSTRAP_FILE" > "$TMP" || {
  rm -f "$TMP"
  echo "[pin-seed] error: no [seed].version line found in $BOOTSTRAP_FILE" >&2
  exit 1
}
mv "$TMP" "$BOOTSTRAP_FILE"
echo "[pin-seed] wrote $BOOTSTRAP_FILE [seed].version = $VERSION"

# Update the compiler capsule's public [toolchain].sfn floor so it tracks the
# adopted seed (SFEP-0047 §3.4). This mirrors the automated cadence-seed-pin.yml
# path. [capsule].version — the version of the compiler *source* being built —
# is a release-time bump, not a seed-pin one; leave it and remind the maintainer.
if [ -f "$CAPSULE_FILE" ]; then
  TMP="$(mktemp "$REPO_ROOT/compiler/capsule.toml.XXXXXX")"
  awk -v v="$VERSION" '
    /^\[[^]]+\]/ { section=$0 }
    section == "[toolchain]" && /^sfn[[:space:]]*=/ { sub(/"[^"]*"/, "\"" v "\""); done=1 }
    { print }
    END { if (!done) exit 3 }
  ' "$CAPSULE_FILE" > "$TMP" || {
    rm -f "$TMP"
    echo "[pin-seed] error: no [toolchain].sfn line found in $CAPSULE_FILE" >&2
    exit 1
  }
  mv "$TMP" "$CAPSULE_FILE"
  echo "[pin-seed] wrote $CAPSULE_FILE [toolchain].sfn = $VERSION"
else
  echo "[pin-seed] warning: $CAPSULE_FILE not found — skipped the [toolchain].sfn bump" >&2
fi

echo "[pin-seed] reminder: bump compiler/capsule.toml [capsule].version separately when the compiler source version advances (SFEP-0047 §3.4)"
