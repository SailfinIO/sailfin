# Release signing & the toolchain trust root

Sailfin's toolchain auto-fetch (Go-`GOTOOLCHAIN`-style transparent download +
re-exec of a pinned compiler) is only safe if a downloaded toolchain can be
verified before it is executed. This document describes the supply-chain root
that makes that verification possible: a signed release-digest manifest plus a
public key pinned into the `sfn` binary. The same release pipeline also signs
the cross-release discovery index described by SFEP-0073 §3.7.

Design record: **SFEP-0046** (`docs/proposals/0046-toolchain-pinning.md`) §3.5.
This is the **producer** side (SFN-171 for per-release manifests and SFN-1062
for signed cross-release discovery). The
**consumer** side (native fetch that downloads and verifies, SFN-168) is
separate.

## What a release publishes

Every release uploads, alongside the per-platform tarballs, four trust assets:

| Asset | Contents |
|---|---|
| `SHA256SUMS` | One `sha256sum`-format line (`<hex>  <basename>`) per release asset, sorted. |
| `SHA256SUMS.sig` | Detached Ed25519 signature over the raw bytes of `SHA256SUMS`, encoded as exactly 128 lowercase hex chars (a raw 64-byte signature), no trailing newline. A consumer passes it verbatim to `ed25519_verify_utf8` (trim defensively if a transport adds whitespace). |
| `toolchain-index.json` | Canonical `sailfin-toolchain-index/1` discovery metadata: exact channel/host candidates, release-manifest bindings, sequence/expiry, release states, advisories, and signing-key transitions. |
| `toolchain-index.json.sig` | Detached Ed25519 signature over the exact canonical index bytes, in the same 128-lowercase-hex/no-newline representation. |

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

After `SHA256SUMS` is complete, `scripts/publish-toolchain-index.py` hashes its
raw bytes, verifies its signature, validates every supported host asset
against its manifest digest,
advances the prior authenticated index, serializes canonical JSON, signs it,
and self-verifies the detached signature. Unlike the historical manifest
helper, the index producer requires the signing key: a release cannot publish
discovery metadata without its signature. The index pair is uploaded twice
with identical bytes:

- on the versioned release, beside `SHA256SUMS`; and
- under `<release-base>/toolchain-index-v1/toolchain-index.json` and
  `toolchain-index.json.sig`, using a reserved non-latest GitHub release as the
  stable cross-release endpoint. Mirrors preserve this `<tag>/<asset>` shape.

The reserved release is drafted while both assets are replaced, so a client
can observe a temporary miss but not an intentionally published mixed-sequence
JSON/signature pair. It also retains the last authenticated pair under
`toolchain-index.previous.json{,.sig}` so a retry can recover if replacement
stops after only one public asset changes. Recovery authenticates all complete
versioned pairs and selects the highest sequence; equal-sequence payloads must
be byte-identical, while mixed JSON/signature upload remnants are ignored. See
`docs/reference/toolchain-index-schema.md` for the locked payload and
transition-proof format.

The index is **discovery metadata, not artifact verification**. It selects an
exact release and authenticates that release's `SHA256SUMS` location/digest;
an installer must still verify `SHA256SUMS.sig`, then the selected archive's
digest, before extraction. SFN-1062 ships this producer. Client-side index
verification and enforcement remain SFN-1069; until that lands, existing exact
installs retain their release-specific SFEP-0046 verification behavior.

## The verification key (pinned, no trust-on-first-use)

The signing key is an **Ed25519** keypair. The **public** half is committed and
embedded in the `sfn` binary at build time — there is no trust-on-first-use and
no network step in establishing trust. It lives in seven places that must stay
in sync:

| Location | Form | Role |
|---|---|---|
| `.github/release-signing/ed25519-release.pub.pem` | PEM (SPKI) | Canonical committed public key; the release script self-verifies against it. |
| `.github/release-signing/ed25519-release.pub.hex` | 64 hex chars | Raw 32-byte key, convenience/cross-check copy. |
| `.github/release-signing/toolchain-index-state.json` | Canonical producer policy | Trusted roots, active signing key, authenticated transitions, and current yank/revocation/advisory records. |
| `compiler/src/release_trust.sfn` | `RELEASE_SIGNING_PUBLIC_KEY_HEX` (64 hex) | The copy pinned into the `sfn` binary; read via `release_signing_public_key_hex()`. |
| `site/public/.well-known/sailfin-release-signing-key.pem` | PEM (SPKI) | HTTPS trust anchor used by the public [verification guide](https://sailfin.dev/docs/getting-started/verify-download). |
| `install.sh` | `RELEASE_SIGNING_PUBLIC_KEY_PEM` (PEM/SPKI) | Bootstrap installer trust anchor on Unix-like hosts; verified with a KAT-gated OpenSSL 3.0+ (SFN-1034). |
| `install.ps1` | `$ReleaseSigningPublicKeyHex` (raw 32-byte hex) | Bootstrap installer trust anchor on Windows, consumed by the embedded pure-PowerShell Ed25519 verifier — no external tooling (SFN-1034). |

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

`ed25519_verify_utf8` is `sfn/crypto`'s text-message verification API. The
capsule also exposes byte-oriented pure-Sailfin signing and PKCS#8 seed decoding
(SFN-699), but the release producer remains on the separately managed CI path.

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
cut. The legacy manifest helper still emits unsigned `SHA256SUMS` when the
secret is absent, but the signed-index producer now fails before promotion, so
the complete release pipeline cannot publish a modern release without the key.

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

Before replacing the old key, create the canonical transition message defined
in `docs/reference/toolchain-index-schema.md` and sign those exact bytes with
the **old** private key. That proof is the only part of a rotation that lets an
already-pinned old client authenticate the new public key; signing it with the
new key is circular and is rejected by the producer.

Then, in one PR:

1. Replace `.github/release-signing/ed25519-release.pub.pem` with the new PEM.
2. Replace `.github/release-signing/ed25519-release.pub.hex` with the new hex.
3. Update `RELEASE_SIGNING_PUBLIC_KEY_HEX` in `compiler/src/release_trust.sfn`
   and the golden value in `compiler/tests/unit/release_trust_test.sfn`.
4. Replace `site/public/.well-known/sailfin-release-signing-key.pem` and update
   the raw key and SHA-256 SPKI fingerprint in the public verification guide.
5. Replace the embedded trust anchor in **both** bootstrap installers: the PEM
   copy (`RELEASE_SIGNING_PUBLIC_KEY_PEM`) in `install.sh`, and the raw
   32-byte hex copy (`$ReleaseSigningPublicKeyHex`) in `install.ps1` — its
   embedded Ed25519 verifier consumes the hex form directly, never PEM
   (SFN-1034). The two forms encode the same key but are not
   interchangeable text; forgetting `install.ps1` fails closed loudly (every
   Windows install starts rejecting the newly signed manifests as a
   verification failure) rather than silently, but it still means Windows was
   left on the old anchor until caught — sequence both edits in this same PR.
6. Append the old-key-signed transition to
   `.github/release-signing/toolchain-index-state.json`, retain the old key in
   `trusted_root_keys`, and set `signing_key` to the new raw public key/key ID.
   Transition `effective_sequence` values are strictly increasing and the new
   one must equal the first index sequence signed by the new key.
7. Regenerate the test fixture in
   `capsules/sfn/crypto/tests/release_signing_key_test.sfn` — sign its `MSG`
   with the new private key and paste the new `KEY`/`SIG`:
   ```bash
   printf '%s' '<MSG from the test>' > /tmp/msg
   openssl pkeyutl -sign -inkey release-priv.pem -rawin -in /tmp/msg -out /tmp/sig
   od -An -v -tx1 /tmp/sig | tr -d ' \n'; echo   # -> new SIG
   ```
8. Store the new private key PEM as the `SAILFIN_RELEASE_SIGNING_KEY` secret.
9. **Securely destroy** the local private key material.

Because the embedded key is pinned at build time, a rotated key only takes
effect for toolchains built from a compiler that carries it — plan rotations
around a seed bump so consumers have a verifier for the new key.

## Threat model notes

- TLS + GitHub asset integrity are **not** sufficient to execute downloaded
  code; the Ed25519 signature over `SHA256SUMS` is the trust root.
- Verification is mandatory and fail-closed on the consumer; it is never skipped
  except by the explicit `SAILFIN_TOOLCHAIN=off` air-gapped escape (SFEP-0046
  §3.5).
- The signing key is single-purpose (release manifests and the authenticated
  toolchain discovery index) and lives solely in CI secrets; compromise is
  bounded by an authenticated rotation and revocation record.
