#!/usr/bin/env bash
# scripts/sign-release-manifest.sh
#
# Produce and Ed25519-sign the SHA256SUMS manifest for a Sailfin release.
#
# Given a directory of release assets, this writes:
#   <dir>/SHA256SUMS      one `sha256sum`-format line per asset (by basename),
#                         sorted deterministically.
#   <dir>/SHA256SUMS.sig  the detached signature over SHA256SUMS as 128 lowercase
#                         hex chars — a raw 64-byte Ed25519 signature. This is the
#                         exact form sfn/crypto::ed25519_verify_utf8 consumes, so
#                         the toolchain fetch/verify path (SFN-168) can verify it
#                         in-process against the public key embedded in the sfn
#                         binary (compiler/src/release_trust.sfn).
#
# The PRIVATE signing key is supplied out of band and never committed:
#   SAILFIN_RELEASE_SIGNING_KEY       PEM-encoded Ed25519 private key (PKCS#8), or
#   SAILFIN_RELEASE_SIGNING_KEY_FILE  path to such a PEM file.
# With neither set, the manifest is still written and signing is skipped with a
# warning — consumers fail-closed on a missing/invalid signature, so an unsigned
# release is simply unusable by auto-fetch, not silently trusted.
#
# Trust model + rotation: docs/release-signing.md. Design: SFEP-0046 §3.5.
set -euo pipefail

dir="${1:-dist}"
[ -d "$dir" ] || { echo "[sign] asset dir not found: $dir" >&2; exit 1; }
command -v openssl >/dev/null 2>&1 || { echo "[sign] openssl is required" >&2; exit 1; }

manifest="${dir}/SHA256SUMS"
sig="${dir}/SHA256SUMS.sig"
rm -f "$manifest" "$sig"

sumtool="sha256sum"
if ! command -v sha256sum >/dev/null 2>&1; then sumtool="shasum -a 256"; fi

# Hash every asset by basename, excluding the manifest/signature themselves and
# the per-asset *.sha256 sidecars. Sorted for a byte-stable manifest.
(
  cd "$dir"
  files="$(find . -maxdepth 1 -type f \
      ! -name 'SHA256SUMS' ! -name 'SHA256SUMS.sig' ! -name '*.sha256' \
      -printf '%f\n' | LC_ALL=C sort)"
  [ -n "$files" ] || { echo "[sign] no assets to hash in $dir" >&2; exit 1; }
  while IFS= read -r f; do
    [ -n "$f" ] || continue
    # shellcheck disable=SC2086
    $sumtool "$f"
  done <<< "$files"
) > "$manifest"

echo "[sign] wrote ${manifest} ($(wc -l < "$manifest" | tr -d ' ') entries)"

# All temp files are cleaned on exit (the private-key temp especially).
tmpfiles=""
# shellcheck disable=SC2064
trap 'rm -f $tmpfiles' EXIT

# Resolve the private key PEM; absent -> leave the manifest unsigned.
key_pem=""
if [ -n "${SAILFIN_RELEASE_SIGNING_KEY:-}" ]; then
  key_pem="$(mktemp)"
  tmpfiles="$tmpfiles $key_pem"
  printf '%s' "$SAILFIN_RELEASE_SIGNING_KEY" > "$key_pem"
elif [ -n "${SAILFIN_RELEASE_SIGNING_KEY_FILE:-}" ]; then
  key_pem="${SAILFIN_RELEASE_SIGNING_KEY_FILE}"
  [ -f "$key_pem" ] || { echo "[sign] key file not found: $key_pem" >&2; exit 1; }
else
  echo "[sign][warn] no SAILFIN_RELEASE_SIGNING_KEY[_FILE]; manifest left UNSIGNED" >&2
  exit 0
fi

# Raw 64-byte Ed25519 signature over the manifest bytes.
sig_raw="$(mktemp)"
tmpfiles="$tmpfiles $sig_raw"
openssl pkeyutl -sign -inkey "$key_pem" -rawin -in "$manifest" -out "$sig_raw"

# Fail-closed drift check: the fresh signature MUST verify against the committed
# public key, or the CI signing key and the embedded/committed key disagree —
# which would ship a release nothing can verify. openssl verifies the raw bytes
# directly (no hex round-trip, no extra interpreter), so this always runs.
pub_pem="${SAILFIN_RELEASE_PUBKEY_FILE:-.github/release-signing/ed25519-release.pub.pem}"
if [ -f "$pub_pem" ]; then
  if openssl pkeyutl -verify -pubin -inkey "$pub_pem" -rawin \
      -in "$manifest" -sigfile "$sig_raw" >/dev/null 2>&1; then
    echo "[sign] self-verify OK against ${pub_pem}"
  else
    echo "[sign][error] signature does NOT verify against ${pub_pem} —" \
         "the CI signing key and the committed public key are out of sync" >&2
    exit 1
  fi
else
  echo "[sign][warn] committed public key ${pub_pem} not found; skipping drift self-verify" >&2
fi

# Emit the detached signature as exactly 128 lowercase hex chars, no trailing
# newline — the exact form sfn/crypto::ed25519_verify_utf8 consumes.
od -An -v -tx1 "$sig_raw" | tr -d ' \n' > "$sig"
echo "[sign] wrote ${sig} (detached Ed25519 signature, 128 hex chars)"
