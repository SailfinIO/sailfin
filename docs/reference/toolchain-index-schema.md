# Signed toolchain index schema

`toolchain-index.json` is Sailfin's authenticated cross-release discovery
payload. SFEP-0073 §3.7 owns the policy; SFN-1062 owns the producer. The payload
chooses candidates and binds them to a release-specific manifest. It never
replaces verification of `SHA256SUMS.sig` or the selected archive digest.

The canonical endpoint is:

```text
<release-base>/toolchain-index-v1/toolchain-index.json
<release-base>/toolchain-index-v1/toolchain-index.json.sig
```

Every versioned release also carries the same two bytes. A mirror may replace
`<release-base>` but preserves the path shape and verification requirements.

## Canonical encoding and signature

The payload schema is `sailfin-toolchain-index/1`. It is UTF-8 JSON serialized
with object keys sorted lexicographically, no insignificant whitespace, no
ASCII escaping requirement for Unicode text, and one final LF. The detached
signature is raw Ed25519 over those exact bytes, encoded as exactly 128
lowercase hexadecimal characters with no trailing newline. Previous candidates
are verified against their downloaded bytes, not reconstructed JSON; duplicate
keys or any noncanonical encoding are rejected before signature acceptance.

For unexpired identical semantic state, the producer retains the prior
`generated_at`, `expires_at`, sequence, payload bytes, and deterministic
signature. A changed release or policy state increments sequence by exactly
one. Refreshing expired metadata also increments sequence. Times use whole-
second RFC3339 UTC (`YYYY-MM-DDTHH:MM:SSZ`).

## Payload

```json
{
  "schema_version": "sailfin-toolchain-index/1",
  "sequence": 42,
  "generated_at": "2026-08-23T15:00:00Z",
  "expires_at": "2026-09-27T15:00:00Z",
  "signing": {
    "key_id": "ed25519:<64 lowercase hex>",
    "public_key": "<64 lowercase hex>"
  },
  "key_transitions": [],
  "channels": {
    "stable": { "x86_64-unknown-linux-gnu": "0.10.4" },
    "rc": { "x86_64-unknown-linux-gnu": null },
    "beta": { "x86_64-unknown-linux-gnu": null },
    "alpha": { "x86_64-unknown-linux-gnu": "0.11.0-alpha.3" }
  },
  "releases": {
    "0.10.4": {
      "version": "0.10.4",
      "channel": "stable",
      "manifest_key_id": "ed25519:<64 lowercase hex>",
      "release_manifest": {
        "path": "v0.10.4/SHA256SUMS",
        "sha256": "<64 lowercase hex>"
      },
      "hosts": {
        "x86_64-unknown-linux-gnu": {
          "asset": "sailfin_0.10.4_linux_x86_64.tar.gz",
          "sha256": "<64 lowercase hex>"
        }
      }
    }
  },
  "yanks": [],
  "revocations": [],
  "advisories": []
}
```

The example abbreviates `channels` and `hosts`. Every channel object contains
all five supported host keys, with either one exact release version or `null`:

| Host key | Release asset suffix |
|---|---|
| `aarch64-apple-darwin` | `macos_arm64` |
| `aarch64-unknown-linux-gnu` | `linux_arm64` |
| `x86_64-pc-windows-msvc` | `windows_x86_64-msvc` |
| `x86_64-unknown-linux-gnu` | `linux_x86_64` |
| `x86_64-w64-mingw32` | `windows_x86_64` |

`latest` is never stored. CLI-only `latest` aliases `stable` in the future
consumer. A candidate must name a release on the same channel, carrying the
same host, and not excluded by a yank, release revocation, or signing-key
revocation. Release versions are exact semvers without build metadata.

Yanks have `version`, `reason`, and `recorded_at`. Revocations have `kind`
(`release` or `signing-key`), `subject`, `reason`, and `recorded_at`.
Revocation history is append-only and cannot be rewritten by a later producer
run. Advisories have `id`, `severity` (`low|moderate|high|critical`), a
space-separated comparator range in `affected`, nullable exact
`fixed_version`, `summary`, and an HTTPS `url`. These arrays stay distinct;
an advisory does not make a release ineligible.

## Authenticated signing-key transitions

A transition record has:

```json
{
  "effective_sequence": 43,
  "from_key_id": "ed25519:<old raw public key hex>",
  "to_key_id": "ed25519:<new raw public key hex>",
  "to_public_key": "<new raw public key hex>",
  "signature": "<128 lowercase hex>"
}
```

The old key signs the following canonical JSON object (same encoding rules and
final LF as the index):

```json
{"effective_sequence":43,"from_key_id":"ed25519:<old raw public key hex>","schema_version":"sailfin-toolchain-key-transition/1","to_key_id":"ed25519:<new raw public key hex>","to_public_key":"<new raw public key hex>"}
```

Transitions form a contiguous, strictly sequence-ordered chain from a trusted
root to `signing.key_id`. The producer verifies every proof with the old key,
rejects self/colliding/unknown-key transitions, rejects an effective sequence
after the output sequence, and refuses to remove or rewrite transition history
accepted by the previous signed index. After bootstrap, a signer change must
add exactly one transition from the previous index's signer to the new signer
at the new sequence; adding another repository-trusted root alone cannot
authorize a cross-release signer switch.

## Producer state and validation

`.github/release-signing/toolchain-index-state.json` is trusted repository
policy, not a published payload. It records trusted roots, the current signer,
the transition chain, and current release-state/advisory records. The release
workflow supplies final assets plus `SHA256SUMS` to
`scripts/publish-toolchain-index.py`. Before signing, the producer verifies the
previous index signature, monotonic sequence, expiry, exact channel/version
shape, supported host filenames and their on-disk SHA-256 values, the raw
release-manifest signature/digest/location, record references, append-only
revocations, and authenticated key-transition history.

Sequence 1 bootstrap is an explicit release input and is refused when any
published versioned release already carries an index asset or the reserved Git
tag already exists. Endpoint absence alone never authorizes a history reset.
The producer authenticates the canonical pair, preserved pair, and every
complete versioned-release pair,
then selects the globally highest sequence. Authenticated candidates at the
same sequence must have byte-identical canonical payloads. Unauthenticated
partial-upload pairs do not outrank signed history. Before canonical
replacement, the workflow keeps the last authenticated pair as
`toolchain-index.previous.json{,.sig}` on the reserved release. These rules
make missing or interrupted two-asset replacement repairable without allowing
an older dispatched release or retry timestamps to fork signed history.
