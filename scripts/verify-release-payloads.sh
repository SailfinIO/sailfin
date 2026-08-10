#!/usr/bin/env bash
# Verifies that the final release directory contains every publishable
# platform payload, including the required native+installer ARM64 pair.
set -euo pipefail

payload_dir="${1:-dist}"
release_tag="${RELEASE_TAG:-}"
version="${2:-${release_tag#v}}"

if [ -z "${version}" ]; then
    echo "[release-payloads][error] release version is empty" >&2
    exit 1
fi
if [ ! -d "${payload_dir}" ]; then
    echo "[release-payloads][error] payload directory does not exist: ${payload_dir}" >&2
    exit 1
fi

required=(
    "sailfin-native-linux-x86_64-${version}.tar.gz"
    "sailfin_${version}_linux_x86_64.tar.gz"
    "sailfin-native-linux-arm64-${version}.tar.gz"
    "sailfin_${version}_linux_arm64.tar.gz"
    "sailfin-native-macos-arm64-${version}.tar.gz"
    "sailfin_${version}_macos_arm64.tar.gz"
    "sailfin_${version}_windows_x86_64.tar.gz"
)

missing=()
for asset in "${required[@]}"; do
    if [ ! -f "${payload_dir}/${asset}" ]; then
        missing+=("${asset}")
    fi
done

if [ "${#missing[@]}" -ne 0 ]; then
    printf '[release-payloads][error] required release payload missing: %s\n' "${missing[@]}" >&2
    exit 1
fi

echo "[release-payloads] verified ${#required[@]} required payloads for ${version}"

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
installer_labels=(linux_x86_64 linux_arm64 macos_arm64 windows_x86_64)
for label in "${installer_labels[@]}"; do
    bash "${script_dir}/verify-payload-dep-closure.sh" "${payload_dir}/sailfin_${version}_${label}.tar.gz"
done
