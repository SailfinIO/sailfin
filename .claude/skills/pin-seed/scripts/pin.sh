#!/usr/bin/env bash
set -euo pipefail

VERSION="${1:-}"
if [ -z "$VERSION" ]; then
  echo "[pin-seed] Usage: pin.sh <version>  (e.g. 0.5.10-alpha.12)" >&2
  exit 1
fi

# Strip leading v/V — .seed-version stores bare versions
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
SEED_VERSION_FILE="$REPO_ROOT/.seed-version"

OLD="$(cat "$SEED_VERSION_FILE" 2>/dev/null || echo '(none)')"
echo "[pin-seed] current pin: $OLD"
echo "[pin-seed] new pin:     $VERSION"

# Atomic write — temp file in the same directory so mv is within one filesystem
TMP="$(mktemp "$REPO_ROOT/.seed-version.XXXXXX")"
printf '%s\n' "$VERSION" > "$TMP"
mv "$TMP" "$SEED_VERSION_FILE"
echo "[pin-seed] wrote $SEED_VERSION_FILE"
