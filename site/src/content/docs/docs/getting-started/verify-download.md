---
title: Verifying Your Download
description: Verify Sailfin releases automatically or manually with the project release-signing key.
section: getting-started
sidebar:
  order: 1.5
---

Sailfin releases include a signed digest manifest. Verification proves that a
download matches a release authorized by the Sailfin release-signing key, not
just that it arrived over HTTPS.

## Automatic verification

Once `sfn` is installed, let it download and verify another toolchain version:

```console
$ sfn toolchain install 0.8.0
sfn toolchain: installed 0.8.0 to /home/you/.local/share/sailfin/versions/0.8.0
  verified signature + sha256 <asset digest>
```

`sfn` downloads the platform tarball, `SHA256SUMS`, and `SHA256SUMS.sig`. It
verifies the Ed25519 signature against the public key embedded in the compiler,
then verifies the tarball's SHA-256 before extracting it. A missing or invalid
signature or digest aborts the install.

Capsules and workspaces can pin a minimum compiler version in `[toolchain]`.
With the default `SAILFIN_TOOLCHAIN=auto` mode, `sfn build`, `run`, `check`, and
`test` use this same verified install path automatically when the pinned
toolchain is not already available.

## Release-signing trust anchor

The canonical Sailfin release-signing public key is Ed25519. It is published
here over HTTPS independently of the GitHub release assets and is also embedded
in every `sfn` binary.

**Public key (PEM):**

```text
-----BEGIN PUBLIC KEY-----
MCowBQYDK2VwAyEAwxcgcQHwbBCjQWVukG6V1ucZn8qoXZx5NFWwfXQKRLk=
-----END PUBLIC KEY-----
```

**Raw 32-byte public key (hex):**

```text
c317207101f06c10a341656e906e95d6e7199fcaa85d9c793455b07d740a44b9
```

**SHA-256 fingerprint of the DER-encoded SubjectPublicKeyInfo:**

```text
e9e97f56767da7f607d65aff56c28d0cb38986d927024c9eecfd679e9bed6b0f
```

Download the PEM from its stable HTTPS endpoint:

```bash
curl -fsSL https://sailfin.dev/.well-known/sailfin-release-signing-key.pem \
  -o sailfin-release.pub.pem
```

An installed compiler reports its embedded raw key for comparison:

```console
$ sfn version --signing-key
c317207101f06c10a341656e906e95d6e7199fcaa85d9c793455b07d740a44b9
```

To derive and compare the published fingerprint yourself:

```bash
openssl pkey -pubin -in sailfin-release.pub.pem -outform DER \
  | openssl dgst -sha256
```

## Manual verification

The following example verifies the Linux x86_64 tarball from the signed v0.8.0
release. Change `ASSET` for another platform, using the filenames shown on the
[Downloads](/dl) page. You need `curl`, OpenSSL, and `xxd`.

### 1. Download the release files and trusted key

```bash
VERSION=0.8.0
ASSET="sailfin_${VERSION}_linux_x86_64.tar.gz"
RELEASE="https://github.com/SailfinIO/sailfin/releases/download/v${VERSION}"

curl -fsSLO "${RELEASE}/${ASSET}"
curl -fsSLO "${RELEASE}/SHA256SUMS"
curl -fsSLO "${RELEASE}/SHA256SUMS.sig"
curl -fsSL https://sailfin.dev/.well-known/sailfin-release-signing-key.pem \
  -o sailfin-release.pub.pem
```

### 2. Confirm the trust anchor

Compare the downloaded PEM with the fingerprint published above:

```bash
EXPECTED_FINGERPRINT=e9e97f56767da7f607d65aff56c28d0cb38986d927024c9eecfd679e9bed6b0f
ACTUAL_FINGERPRINT="$(openssl pkey -pubin -in sailfin-release.pub.pem \
  -outform DER | openssl dgst -sha256 -r | awk '{print $1}')"
test "$ACTUAL_FINGERPRINT" = "$EXPECTED_FINGERPRINT" \
  || { echo "Sailfin signing-key fingerprint mismatch" >&2; exit 1; }
```

### 3. Verify the manifest signature

`SHA256SUMS.sig` stores the raw 64-byte Ed25519 signature as lowercase hex.
Decode it, then verify the exact bytes of `SHA256SUMS`:

```bash
xxd -r -p SHA256SUMS.sig > SHA256SUMS.sig.bin
openssl pkeyutl -verify -pubin -inkey sailfin-release.pub.pem -rawin \
  -in SHA256SUMS -sigfile SHA256SUMS.sig.bin
```

OpenSSL prints `Signature Verified Successfully`. Do not continue if it does
not.

### 4. Verify the tarball digest

On macOS:

```bash
grep -F "  ${ASSET}" SHA256SUMS | shasum -a 256 -c -
```

On Linux:

```bash
grep -F "  ${ASSET}" SHA256SUMS | sha256sum -c -
```

The command must print the selected asset followed by `OK`. Only then extract
and install the archive.

## Bootstrap trust boundary

The one-line `curl ... install.sh | bash` and PowerShell bootstrap commands
download over HTTPS, but the scripts do **not** currently verify
`SHA256SUMS.sig`. That first bootstrap is therefore TLS-trust only. Manual
verification avoids that limitation; after a trusted `sfn` is installed,
`sfn toolchain install` and automatic toolchain dispatch verify signatures and
digests as described above.
