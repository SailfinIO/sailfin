# Release signing & the toolchain trust root

Sailfin's toolchain auto-fetch (Go-`GOTOOLCHAIN`-style transparent download +
re-exec of a pinned compiler) is only safe if a downloaded toolchain can be
verified before it is executed. This document describes the supply-chain root
that makes that verification possible: a signed release-digest manifest plus a
public key pinned into the `sfn` binary.

Design record: **SFEP-0046** (`docs/proposals/0046-toolchain-pinning.md`) §3.5.
This is the **producer** side (SFN-171 — sign releases + embed the key). The
**consumer** side (native fetch that downloads and verifies, SFN-168) is
separate.

## What a release publishes

Every release uploads, alongside the per-platform tarballs, two extra assets:

| Asset | Contents |
|---|---|
| `SHA256SUMS` | One `sha256sum`-format line (`<hex>  <basename>`) per release asset, sorted. |
| `SHA256SUMS.sig` | Detached Ed25519 signature over the raw bytes of `SHA256SUMS`, encoded as exactly 128 lowercase hex chars (a raw 64-byte signature), no trailing newline. A consumer passes it verbatim to `ed25519_verify_utf8` (trim defensively if a transport adds whitespace). |

The signature is produced by `scripts/sign-release-manifest.sh`, invoked from
the `Sign release manifest (SHA256SUMS)` step in
`.github/workflows/release-tag.yml`. The script:

1. Hashes every release asset in `dist/` by basename (excluding the manifest,
   the signature, and the per-asset `*.sha256` sidecars) into `SHA256SUMS`.
2. Signs `SHA256SUMS` with the private key from the `SAILFIN_RELEASE_SIGNING_KEY`
   secret using raw Ed25519 (`openssl pkeyutl -sign -rawin`).
3. Self-verifies the fresh signature against the committed public key and
   **fails the release** if they disagree (catches a CI-key / committed-key
   drift before anything is published).

If no signing key is configured the manifest is still written but left
unsigned; consumers fail closed on a missing/invalid signature, so an unsigned
release is simply unusable by auto-fetch — never silently trusted.

## The verification key (pinned, no trust-on-first-use)

The signing key is an **Ed25519** keypair. The **public** half is committed and
embedded in the `sfn` binary at build time — there is no trust-on-first-use and
no network step in establishing trust. It lives in six places that must stay
in sync:

| Location | Form | Role |
|---|---|---|
| `.github/release-signing/ed25519-release.pub.pem` | PEM (SPKI) | Canonical committed public key; the release script self-verifies against it. |
| `.github/release-signing/ed25519-release.pub.hex` | 64 hex chars | Raw 32-byte key, convenience/cross-check copy. |
| `compiler/src/release_trust.sfn` | `RELEASE_SIGNING_PUBLIC_KEY_HEX` (64 hex) | The copy pinned into the `sfn` binary; read via `release_signing_public_key_hex()`. |
| `site/public/.well-known/sailfin-release-signing-key.pem` | PEM (SPKI) | HTTPS trust anchor used by the public [verification guide](https://sailfin.dev/docs/getting-started/verify-download). |
| `install.sh` | `RELEASE_SIGNING_PUBLIC_KEY_PEM` (PEM/SPKI) | Bootstrap installer trust anchor on Unix-like hosts. |
| `install.ps1` | `$ReleaseSigningPublicKeyPem` (PEM/SPKI) | Bootstrap installer trust anchor on Windows. |

The **private** half is **never committed**. It is held only as the
`SAILFIN_RELEASE_SIGNING_KEY` CI secret (repo/org level; `release.yml` passes
`secrets: inherit` to `release-tag.yml`).

The embedded key is queryable from any built compiler:

```console
$ sfn version --signing-key
c317207101f06c10a341656e906e95d6e7199fcaa85d9c793455b07d740a44b9
```

A consumer verifies a downloaded release with in-process crypto alone:

```
verify order (fail closed at each step):
  download asset  →  download SHA256SUMS + SHA256SUMS.sig
  →  ed25519_verify_utf8(embedded_pubkey_hex, SHA256SUMS_text, sig_hex) == true
  →  the asset's SHA-256 equals its line in SHA256SUMS
  →  only then extract and mark the toolchain usable
```

`ed25519_verify_utf8` is `sfn/crypto`'s verify-only Ed25519 primitive (SFN-170).

## Key provisioning status

The SFN-171 **bootstrap placeholder** keypair (whose private half was generated
to mint the fixtures and then **not retained**) was retired in **SFN-196**. The
committed/embedded key above is now the **production** key; its private half is
held only as the `SAILFIN_RELEASE_SIGNING_KEY` CI secret and is never committed.

One gate remains before signed releases verify for existing installs: because
the public key is pinned at **build time** (§"The verification key"), the
rotated key only verifies for toolchains built from a compiler that already
carries it. So the rotation must reach the **pinned seed** (`/pin-seed`) before
the first release is signed with the new key — otherwise an older toolchain
cannot verify that release. Sequence the seed bump ahead of the first signed
cut. A release built before the secret is configured is still published
unsigned, and consumers fail closed on it (never silently trusted).

## Key generation & rotation

Rotating the release key means replacing the committed public key everywhere it
appears **and** the CI secret, together, in one change:

```bash
# 1. Generate a fresh Ed25519 keypair.
openssl genpkey -algorithm ed25519 -out release-priv.pem
openssl pkey -in release-priv.pem -pubout -out ed25519-release.pub.pem

# 2. Derive the raw 32-byte public key as hex (DER SPKI tail is the raw key).
openssl pkey -in release-priv.pem -pubout -outform DER | tail -c 32 \
  | od -An -v -tx1 | tr -d ' \n'; echo
```

Then, in one PR:

1. Replace `.github/release-signing/ed25519-release.pub.pem` with the new PEM.
2. Replace `.github/release-signing/ed25519-release.pub.hex` with the new hex.
3. Update `RELEASE_SIGNING_PUBLIC_KEY_HEX` in `compiler/src/release_trust.sfn`
   and the golden value in `compiler/tests/unit/release_trust_test.sfn`.
4. Replace `site/public/.well-known/sailfin-release-signing-key.pem` and update
   the raw key and SHA-256 SPKI fingerprint in the public verification guide.
5. Replace the embedded PEM copies in `install.sh` and `install.ps1`.
6. Regenerate the test fixture in
   `capsules/sfn/crypto/tests/release_signing_key_test.sfn` — sign its `MSG`
   with the new private key and paste the new `KEY`/`SIG`:
   ```bash
   printf '%s' '<MSG from the test>' > /tmp/msg
   openssl pkeyutl -sign -inkey release-priv.pem -rawin -in /tmp/msg -out /tmp/sig
   od -An -v -tx1 /tmp/sig | tr -d ' \n'; echo   # -> new SIG
   ```
7. Store the new private key PEM as the `SAILFIN_RELEASE_SIGNING_KEY` secret.
8. **Securely destroy** the local private key material.

Because the embedded key is pinned at build time, a rotated key only takes
effect for toolchains built from a compiler that carries it — plan rotations
around a seed bump so consumers have a verifier for the new key.

## Threat model notes

- TLS + GitHub asset integrity are **not** sufficient to execute downloaded
  code; the Ed25519 signature over `SHA256SUMS` is the trust root.
- Verification is mandatory and fail-closed on the consumer; it is never skipped
  except by the explicit `SAILFIN_TOOLCHAIN=off` air-gapped escape (SFEP-0046
  §3.5).
- The signing key is single-purpose (release manifests only) and lives solely in
  CI secrets; compromise is bounded by rotating the embedded key.
