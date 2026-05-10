#!/usr/bin/env bash
set -euo pipefail

VERSION="${1:-}"
if [ -z "$VERSION" ]; then
  echo "[pin-seed] Usage: pin.sh <version>  (e.g. 0.5.10-alpha.12)" >&2
  exit 1
fi

# Strip leading v — .seed-version stores bare versions
VERSION="${VERSION#v}"

SEED_VERSION_FILE="$(git rev-parse --show-toplevel)/.seed-version"

OLD="$(cat "$SEED_VERSION_FILE" 2>/dev/null || echo '(none)')"
echo "[pin-seed] current pin: $OLD"
echo "[pin-seed] new pin:     $VERSION"

printf '%s\n' "$VERSION" > "$SEED_VERSION_FILE"
echo "[pin-seed] wrote $SEED_VERSION_FILE"
