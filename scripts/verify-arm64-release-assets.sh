#!/usr/bin/env bash
# Verifies that an already-published release exposes the exact ARM64 payload
# pair required before cadence seed pinning may adopt it.
set -euo pipefail

version="${1:-}"
asset_list="${2:-}"

if [ -z "${version}" ]; then
    echo "[seed-pin-assets][error] release version is empty" >&2
    exit 1
fi
if [ -z "${asset_list}" ] || [ ! -r "${asset_list}" ]; then
    echo "[seed-pin-assets][error] asset list is missing or unreadable: ${asset_list}" >&2
    exit 1
fi

required=(
    "sailfin-native-linux-arm64-${version}.tar.gz"
    "sailfin_${version}_linux_arm64.tar.gz"
)

missing=()
for asset in "${required[@]}"; do
    if ! grep -Fxq "${asset}" "${asset_list}"; then
        missing+=("${asset}")
    fi
done

if [ "${#missing[@]}" -ne 0 ]; then
    printf '[seed-pin-assets][error] release is missing required ARM64 payload: %s\n' "${missing[@]}" >&2
    exit 1
fi

echo "[seed-pin-assets] verified required ARM64 payload pair for ${version}"
