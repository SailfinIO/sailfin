---
sfep: 0048
title: Native crypto + TLS stack — removing the OpenSSL dependency
status: Accepted
type: runtime
created: 2026-07-12
updated: 2026-08-07
author: "agent:compiler-architect; human review"
tracking: SFN-333, SFN-335, SFN-336, SFN-337, SFN-340, SFN-504, SFN-654, SFN-655, SFN-656, SFN-657, SFN-658, SFN-659, SFN-660, SFN-699
supersedes:
superseded-by:
graduates-to:
---

# SFEP-0048 — Native crypto + TLS stack — removing the OpenSSL dependency

## 1. Summary

Sailfin links OpenSSL (`-lssl -lcrypto`) into **every** binary it produces —
including the compiler itself — to provide TLS for the native HTTP/WebSocket
runtime and a handful of crypto primitives (HMAC-SHA-256, Ed25519 verify,
WebSocket SHA-1 + base64 + CSPRNG). This is the single largest external
dependency in the toolchain and a direct obstacle to the capability-sealed
runtime (SFEP-0016): **you cannot seal a binary whose entire TLS record layer
and syscall-issuing crypto engine is opaque C you do not own.** The manifest's
own comment (`runtime/capsule.toml:59`) confirms `-lssl`/`-lcrypto` reaches the
final link of the compiler binary, so the seal's "one enforcement chokepoint"
premise is violated the moment libssl issues a `connect(2)` the runtime cannot
see.

This SFEP records the **full phased path to zero OpenSSL**, and its first
workflow implements **Phase A only**: extending the *existing*
`capsules/sfn/crypto/` library capsule with the pure-Sailfin primitives the
native TLS/WebSocket stack will need but does not yet have — SHA-1, SHA-384,
HKDF, ChaCha20, Poly1305, and a shared constant-time/masking helper module.
(SHA-256, base64 encode/decode, HMAC-SHA-256, and Ed25519-verify already ship
in that capsule; Phase A does not re-found them.) Later phases build the TLS 1.3
record layer and handshake (Phase B), X.509 chain verification + trust store
(Phase C), and finally swap the `tls_*` wrappers onto the native stack and
delete the OpenSSL externs + link wiring (Phase D). Crypto is pure computation
(no effects); the CSPRNG source and TLS I/O keep their effects. The phasing is
deliberately sequenced so each phase self-hosts and ships independently, and so
the highest-risk field arithmetic (Curve25519 / X25519) is **explicitly
excluded from Phase A** as a blocker pending sized-integer / wide-multiply
support (§6, §7).

## 2. Motivation

**The seal blocker.** SFEP-0016 (a 1.0 hallmark / hard GA blocker per
`docs/strategy/decision-brief.md`) requires that every effectful operation pass
through a syscall chokepoint the runtime owns. Today `-lssl`/`-lcrypto` is in
the same dependency class as `-lm`/`-lpthread` (`runtime/capsule.toml:59`): it
is on the link line of every Sailfin binary, and libssl's own `connect`/`read`/
`write` calls resolve to libc, not to any gated Sailfin stub. As long as TLS is
OpenSSL, a sealed binary has a hole the width of the entire TLS stack.

**The dependency-footprint problem.** OpenSSL is a large, version-churning C
dependency with a keg-only Homebrew story on macOS that forces a shell-probed
`-L` search path (`_openssl_link_search_flags()` in
`compiler/src/build/runtime_objs.sfn:904`). It is excluded from the Windows
cross-build entirely (`runtime/ir/windows_stubs.ll` stubs the `tls_*` wrappers),
so `https://` silently degrades to null on Windows today. Removing it collapses
three platform forks into one native code path.

**Original surface (baseline at acceptance).** Exactly one file
(`runtime/sfn/platform/tls.sfn`) owned the entire OpenSSL extern surface (24
`SSL_*`/`SSL_CTX_*` symbols) and defined every `tls_*` wrapper. Three consumers
(`http.sfn`, `websocket.sfn`, `serve.sfn`) forward-declared the `tls_*` wrapper
signatures (the #306 cross-module-extern workaround) rather than importing
`tls.sfn`. Separately, `websocket.sfn` declared three **libcrypto** externs —
`SHA1`, `EVP_EncodeBlock`, `RAND_bytes` — used **unconditionally** for the RFC
6455 handshake and frame masking on *every* WebSocket connection, `ws://` and
`wss://` alike. This mattered: naively dropping `-lcrypto` broke all WebSocket
traffic, not just TLS. Phase A's SHA-1 + base64 (already shipped) + a CSPRNG
source were the prerequisites that let Phase D remove those three externs.
Additionally, `capsules/sfn/crypto/src/mod.sfn` itself used libcrypto for
`hmac_sha256` (the `HMAC`/`EVP_sha256` externs), and `ed25519.sfn` used the
OpenSSL EVP surface for Ed25519 verify. The implementation amendments in §6.4
and §7 record the pure-Sailfin replacements that have landed since this baseline.

**The honest constraint (§6).** A from-scratch TLS 1.3 stack is a multi-quarter
effort and a security surface. This SFEP does not pretend otherwise. It scopes
Phase A to the primitives that are provably constant-correct under Sailfin's
*current* integer semantics, and it is explicit that X25519 — the one primitive
TLS 1.3 key exchange cannot do without — is **not** buildable today (§6.4) and
gates Phase B.

## 3. Design

### 3.1 The phases

| Phase | Deliverable | External-dep effect | Ships when |
|---|---|---|---|
| **A** | Extend `capsules/sfn/crypto/`: SHA-1, SHA-384, HKDF, ChaCha20, Poly1305, a `bits` constant-time/masking helper module (SHA-256, base64, HMAC-SHA-256, Ed25519-verify already ship) | none removed yet; primitives exist natively | this workflow |
| **B** | TLS 1.3 record layer (AEAD via ChaCha20-Poly1305) + client handshake, then server handshake | still linked (fallback); native path selectable | X25519 unblocked (§6.4 amendment, SFN-335) |
| **C** | X.509 cert parse + chain verification + system trust-store loading + RFC 6125 hostname check | still linked | after Phase B |
| **D** | Swap `tls_*` wrapper **bodies** to the native stack; replace `websocket.sfn`'s `SHA1`/`EVP_EncodeBlock`/`RAND_bytes` with the native primitives; replace the `sfn/crypto` HMAC/Ed25519 externs with pure-Sailfin ports; delete all OpenSSL externs; drop `-lssl`/`-lcrypto`; remove `_openssl_link_search_flags()` | **`-lssl`/`-lcrypto` gone from every binary** | after Phase C |
| **E** | Retire the `sha256sum`/`shasum` shell-out (`_sha256_of_file_cmd`) for binary-artifact hashing; replace with an in-process binary-safe hasher (§3.5) | drops a second, previously unphased external-dependency class — subprocess hashers, not OpenSSL | a binary-safe `fs` read primitive exists and the `-O0` in-process performance regression is resolved; independent of Phases A–D |

Because the three TLS consumers forward-declare only the **`tls_*` wrapper
names** (not raw OpenSSL symbols), Phase D changes only `tls.sfn`'s function
*bodies* and `websocket.sfn`'s three externs — no consumer-signature churn.
Phase D is where the seal blocker is actually cleared.

**Amendment (2026-08-01) — Phase B progress: client handshake landed
(SFN-337).** The record layer (`tls13_record.sfn`, SFN-336) and key schedule
(`tls13_schedule.sfn`, SFN-333) now have a client-side handshake driving them:
`capsules/sfn/crypto/src/tls13_handshake.sfn` +
`tls13_handshake_codec.sfn` implement the RFC 8446 §4 ClientHello/ServerHello/
EncryptedExtensions/Certificate/CertificateVerify/Finished state machine and
wire code, checked against the RFC 8448 §3 "Simple 1-RTT Handshake" trace
(16 tests, `capsules/sfn/crypto/tests/tls13_handshake_test.sfn`, plus 34 fail-closed codec tests in `tls13_handshake_codec_test.sfn`). It is pure
computation with no socket I/O — `runtime/sfn/platform/tls.sfn` is untouched
and still OpenSSL-backed (the swap is SFN-341); CertificateVerify checking is
Ed25519-only pending RSA-PSS/ECDSA-P256 (SFN-653); and there is no certificate
chain/trust decision (SFN-340) or server-side handshake (SFN-654) yet. Phase B
therefore stays open; see `docs/status.md`'s `sfn/crypto` row for the full
capability and limitation list.

**Amendment (2026-08-06) — Phase C: the inspection half has landed
(SFN-504); chain verification and the trust store have not, so Phase C is
partially complete.** `capsules/sfn/crypto/src/der.sfn` adds a minimal
definite-length DER/ASN.1 TLV reader covering the subset X.509 needs
(SEQUENCE, SET, INTEGER, OBJECT IDENTIFIER, BIT STRING, OCTET STRING,
BOOLEAN, NULL, UTCTime/GeneralizedTime, directory strings), hardened with
nesting-depth and total-length guards on the SFN-156 precedent and strict
about non-minimal lengths/integers/OID arcs, non-canonical booleans, and
over-wide length fields. `capsules/sfn/crypto/src/x509.sfn` adds certificate
structure parsing, RFC 6125 §6.4.3 SAN-`dNSName`-only hostname matching
(commonName is deliberately not consulted, §6.4.4), and a pure
`x509_validity_at(cert, unix_millis)` window classifier that takes a
caller-supplied snapshot rather than reading ambient time — the caller owns
`![clock]` and the fallible `sfn/time::unix_millis()` read (SFN-623), which is
what keeps `sfn/crypto` effect-free through this addition. The capsule gains
a `sfn/strings` dependency edge and moves 0.18.0 → 0.19.0;
`[capabilities] required` stays `[]`.

This is parsing and inspection only, exactly the "parsed but not enforced"
distinction this SFEP's own bar (CLAUDE.md Stage1 readiness) draws: no
signature is verified, no chain is built, and basicConstraints/keyUsage/
extendedKeyUsage are parsed and exposed via `X509Extension` but never
enforced. None of this is wired into `runtime/sfn/platform/tls.sfn`. Chain
verification and the system trust store — the rest of Phase C's original
scope — remain unshipped and tracked separately (SFN-340), which stays
blocked on signature-verification primitives (RSA verify lands per §6.3's
amendment; ECDSA-P256 per SFN-653). Phase C therefore stays open.

**Amendment (2026-08-07) — Phase B: the server handshake has landed
(SFN-654); Phase B is now complete for the handshake layer.**
`capsules/sfn/crypto/src/tls13_server_handshake.sfn` adds a `ServerHandshake`
state machine, the sibling of the SFN-337 client, driving the RFC 8446 §4
ClientHello/ServerHello/EncryptedExtensions/Certificate/CertificateVerify/
Finished exchange from the server side over the same record layer
(`tls13_record.sfn`, SFN-336) and key schedule (`tls13_schedule.sfn`,
SFN-333), with its own running transcript hash and the X25519 key share wired
into the schedule so the record layer can be rekeyed at each transition.
`tls13_handshake_codec.sfn` gained the server-direction encoders
(`encode_server_hello`, `encode_encrypted_extensions`, `encode_certificate`,
`encode_certificate_verify`) plus `struct ClientHelloMsg` /
`parse_client_hello`, so the codec now covers both directions. It is checked
against the RFC 8448 §3 "Simple 1-RTT Handshake" trace **from the server
side** (11 tests, `capsules/sfn/crypto/tests/tls13_server_handshake_test.sfn`),
and against the SFN-337 client directly via a client/server interop test
driving a real X25519 exchange, a real Ed25519 CertificateVerify the client
verifies, cross-checked Finished MACs on both sides, and a sealed/opened
application record — RFC 8448 §3 is now reproduced from both directions. New
`capsules/sfn/crypto/src/pem.sfn` (`pem_decode_blocks`,
`pem_certificates_to_der`; 6 tests) decodes PEM → DER for loading a
certificate chain, binary-safe unlike `mod.sfn`'s `string`-returning
`base64_decode`, which cannot carry DER's 0x00 bytes. CertificateVerify signs
with Ed25519 only (`ed25519_sign`, SFN-699); a ClientHello that does not offer
ed25519 is refused at the CertificateVerify step, and RSA-PSS/ECDSA-P256
signing remain unimplemented (SFN-658/SFN-653 territory). This supersedes the
2026-08-01 amendment's "no server-side handshake (SFN-654) yet" clause. Like
the client, this is pure computation with no socket I/O —
`runtime/sfn/platform/tls.sfn` is untouched and still OpenSSL-backed
(`tls_accept_fd`/`tls_server_ctx` unchanged); swapping those bodies onto the
native stack is still Phase D's job (SFN-341), so Phase B's link-line status
in §3.1's table — "still linked (fallback); native path selectable" — is
unchanged. There is still no client authentication/mTLS, no session
resumption, no tickets, no 0-RTT, and no HelloRetryRequest, and the server
performs no certificate chain verification of its own (trust remains the
client's decision, SFN-340). See `docs/status.md`'s `sfn/crypto` row for the
full capability and limitation list.

**Amendment (2026-08-07) — Phase C: chain verification and the trust store
have landed (SFN-340); Phase C is now complete.** This supersedes the
2026-08-06 amendment's closing claim that "Chain verification and the system
trust store — the rest of Phase C's original scope — remain unshipped
(SFN-340)." New `capsules/sfn/crypto/src/x509_verify.sfn` (pure, no effects;
caller supplies the Unix-millisecond snapshot, the same boundary
`x509_validity_at` established under SFN-504) adds
`x509_verify_chain(leaf, intermediates, anchors, options) -> X509ChainResult`:
chain building treats `intermediates` as an unordered bag and walks greedily
without backtracking, safe because a candidate issuer is accepted only after
its signature over the subject verifies, each intermediate is consumed at
most once, and the turn count is bounded by the bag size. Signature dispatch
on the certificate's signature-algorithm OID covers Ed25519, ECDSA-P256/
SHA-256 (SFN-657), and RSASSA-PKCS1-v1.5/SHA-256/SHA-384 (SFN-656) — realizing
the §6.3 amendment's RSA-in-scope decision in the dispatch table for
certificate-signature verification, though RSASSA-PSS (SFN-658) stays out of
this dispatch, since PSS is the CertificateVerify scheme, not the X.509
cert-signature scheme; any other OID rejects the link rather than skipping
it. Enforces RFC 5280 §6.1.3(f) — a certificate asserting a *critical*
extension outside the recognised set (basicConstraints, keyUsage,
extendedKeyUsage, subjectAltName) rejects the chain rather than being
processed with that extension ignored, which is what stops a
technically-constrained sub-CA carrying critical `nameConstraints` from being
treated as unconstrained; §4.1.1.2 outer/inner signatureAlgorithm agreement,
validity at every position in the path (not just the leaf), basicConstraints
CA flag, keyUsage keyCertSign when present, pathLenConstraint, and
extendedKeyUsage serverAuth on the leaf when present; trust anchors are not
exempt from validity or CA constraints. New
`capsules/sfn/crypto/src/trust_store.sfn` adds the anchor set:
`trust_store_from_pem` is pure; `trust_store_load()`/
`trust_store_load_from(path)` are the only `![io]` surface added to
`sfn/crypto`, consulting `SAILFIN_TLS_CAFILE` then `SSL_CERT_FILE` before
probing `trust_store_default_paths()`. `SAILFIN_TLS_CAFILE` is honoured first
because it is the name the OpenSSL-backed `runtime/sfn/platform/tls.sfn`
already reads, so a program configured against today's stack keeps its custom
CA when SFN-341 swaps those bodies onto this one rather than silently falling
back to the system bundle. macOS is documented, not solved: the real
system trust store is the Keychain, not a file, and is not read by this
path — a caller needing Keychain fidelity supplies anchors via
`trust_store_from_pem`, and a Security.framework binding is outside this cut.
`x509.sfn` gained `signature_algorithm_outer`/`tbs_der`/`signature_value`
fields so a signature can be checked at all, exposed but never enforced
there — `x509.sfn` itself still makes no trust decision. Capsule version
0.25.0 → 0.26.0; `[capabilities] required` stays `[]`. Full capability and
limitation list: `docs/status.md`'s `sfn/crypto` row.

**Phase C's completion does not advance Phase D.**
`runtime/sfn/platform/tls.sfn` is untouched; `-lssl`/`-lcrypto` are still
linked; §3.1's table entry for Phase C ("still linked") is unchanged, and
SFN-341 remains the seal blocker. Neither TLS 1.3 handshake's
CertificateVerify accepts ECDSA-P256 or RSA yet, and neither
`tls13_handshake.sfn` nor `tls13_server_handshake.sfn` calls
`x509_verify_chain` — the capability exists in the capsule but is not wired
into either state machine. No OCSP/CRL/revocation, no name constraints
beyond SAN matching, no client-cert/mTLS. Phase C is complete; Phase D
(dropping `-lssl`/`-lcrypto` from the link line) has not begun.

### 3.2 Where the code lives

Phase A extends the **existing `capsules/sfn/crypto/`** library capsule
(`kind = "library"`, `entry = "src/mod.sfn"`, version `0.7.1`), which already
ships SHA-256, base64, HMAC-SHA-256, and Ed25519-verify (`docs/status.md:435`).
It does **not** found a new `runtime/sfn/crypto/` tree. Each new primitive is a
sibling module under `capsules/sfn/crypto/src/` re-exported from `mod.sfn`,
following the established `ed25519.sfn` precedent:

```sfn
// capsules/sfn/crypto/src/mod.sfn — new re-export lines
export { sha1_hex, sha1_bytes } from "./sha1";
export { sha384_hex } from "./sha384";
export { hkdf_sha256_extract, hkdf_sha256_expand } from "./hkdf";
export { chacha20_block, chacha20_xor } from "./chacha20";
export { poly1305_mac } from "./poly1305";
```

No `runtime/capsule.toml` / `runtime_objs.sfn` staging is needed: that machinery
is exclusively for the compiler's own linked-in runtime, and a capsule-library's
`capsule.toml` `[build] entry` + normal capsule resolution is all that is
required. Tests live under `capsules/sfn/crypto/tests/<primitive>_test.sfn`.

**Consumption by Phases B–D (the runtime-vs-capsule tension).** Phases B–D need
these primitives from *compiler-runtime* modules (`tls.sfn`, `websocket.sfn`),
which cannot depend on a `kind = "library"` capsule — the same dependency-closure
reason the compiler already vendors SHA-256 into `compiler/src/build/hash.sfn`.
Phase A does **not** solve that: it lands the primitives in the capsule where
they get user-facing test coverage and a canonical home. When Phase B begins,
each primitive it needs is **vendored** into the runtime (a byte-identical copy,
exactly as `build/hash.sfn` vendors SHA-256), with the capsule copy remaining the
tested source of truth. Deciding whether to later unify these (e.g. a shared
`sfn-sources`-staged runtime crypto module the capsule re-exports) is out of
Phase A scope and deferred to a Phase B design note. Phase A's deliverable is
correct, tested primitives — not their runtime wiring.

### 3.3 The integer-idiom standard (honest about sized ints)

Sailfin's sized-integer family is **half-real** today
(SFEP-0058, `Accepted`): unsigned widths collapse to
signed LLVM twins (`compiler/src/llvm/type_mapping.sfn:877-895`); `u8 as u64`
mis-lowers as `sext` (255 → -1) (`core_cast_lowering.sfn:443-449`); `>>` always
lowers to `ashr`, never `lshr` (`core_helpers.sfn:60-70`); no overflow/wrapping
semantics exist; literal ranges are unchecked; there are no typed literal
suffixes; and there is no `64×64 → 128` multiply. Every Phase A module therefore
obeys a single mandated idiom, proven by the in-tree SHA-256
(`capsules/sfn/crypto/src/mod.sfn:88-241`, `compiler/src/build/hash.sfn`):

1. **All word arithmetic on plain `int` (signed i64). Never `u32`/`u64` typed
   locals for arithmetic.** `u8`/`i32`/`usize` appear only in `extern fn` FFI
   signatures, never in Sailfin-side arithmetic.
2. **Mask to the algorithm's true width after every op that could exceed it.**
   32-bit words: `& 4294967295` after every add/xor/rotate/shift. This keeps
   every value in `[0, 2^32)` — non-negative — which is *what makes `ashr`
   behave as the logical shift the algorithm needs*. The mask is load-bearing,
   not decoration.
3. **Rotate-left / rotate-right via mask-after-shift**, e.g.
   `((x << n) | (x >> (32 - n))) & 4294967295`.
4. **64-bit words (SHA-384) held as two 32-bit limbs (`hi`, `lo`), each masked
   `& 4294967295`.** No 64-bit word is ever stored in a single `int` and shifted
   as a unit, because a set bit 63 would make `ashr` sign-extend. All 64-bit
   add/xor/rotate/shift are done limb-wise with explicit inter-limb carry. This
   keeps every limb non-negative and every limb sum ≤ `2^33` (inside i64). The
   existing SHA-256 already builds/consumes a 64-bit bit-length as `hi`/`lo`
   32-bit halves at `mod.sfn:141-150` — the exact template.
5. **Multi-precision reduction (Poly1305) via narrow limbs whose pairwise
   products stay inside i64.** Poly1305 uses **five 26-bit limbs**; a limb
   product is ≤ `2^52`, and a full field-mul accumulates ≤ 5 such products +
   the ×5 reduction multiplier ≤ ~`2^55` per output column — comfortably inside
   i64's `2^63`. Exact limb layout mandated in the Phase A `poly1305` spec.
6. **Bytes via `int[]` + `char_code`/`char_from_code`, masked `& 255`.**
   Byte value `0x00` is unrepresentable in a Sailfin `string`
   (`char_from_code(0)` → `""`, `runtime/prelude.sfn:731-769`), so **any
   function that produces arbitrary binary output does so as `int[]`, never
   `string`.** Only hex/base64 *encodings* (always NUL-free ASCII) return
   `string`. This is the fail-closed contract the existing `base64_decode`
   already follows.
7. **Constants written in decimal.** Hex literals are unavailable in Sailfin
   source; round-constant tables and initial state are decimal (`4294967295`
   is the 0xffffffff mask), matching the shipped SHA-256.

The Phase A implementer follows these idioms exactly; there is no design
latitude to introduce `u32`/`u64` arithmetic or unmasked shifts.

### 3.4 Worked example (the mandated shape)

```sfn
// capsules/sfn/crypto/src/bits.sfn — the constant-time / masking helper module.
// 32-bit mask, decimal (no hex literals in Sailfin source).
fn mask32() -> int { return 4294967295; }

fn rotl32(x: int, n: int) -> int {
    return ((x << n) | (x >> (32 - n))) & 4294967295;
}

// Constant-time byte equality over two equal-length int[] byte arrays.
// Accumulates the OR of per-byte XOR differences; no early return, no
// data-dependent branch. Returns true iff every byte matches.
fn ct_eq_bytes(a: int[], b: int[]) -> bool {
    if a.length != b.length { return false; }  // length is public
    let mut diff: int = 0;
    let mut i: int = 0;
    loop {
        if i >= a.length { break; }
        diff = diff | ((a[i] & 255) ^ (b[i] & 255));
        i += 1;
    }
    return diff == 0;
}
```

### 3.5 Phase E — retire the shelled-out hashers

**Added 2026-07-31.** Phases A–D retire the OpenSSL/libcrypto external
dependency. There is a **second, previously unphased external-dependency
class** in the same toolchain, unrelated to TLS: binary-artifact SHA-256 is
computed by shelling out to `sha256sum`/`shasum` via `_sha256_of_file_cmd`
(`compiler/src/build/fs.sfn:511-523`) rather than by any Sailfin-owned code.

**Consumers.** Build-cache keys (`compiler/src/build_cache.sfn:1178,1198`),
compiler self-identity (`compiler/src/cli_selfhost.sfn:392`), seed/toolchain
tarball verification (`compiler/src/cli/commands/toolchain.sfn:383`), `sfn
package`/`add`/`publish` (`compiler/src/cli/commands/package.sfn:239,428,599`,
`compiler/src/cli/commands/add.sfn:425`), and the determinism triple-pass
(`compiler/src/build/determinism.sfn:231,296`).

**The blocker is not crypto.** Pure SHA-256 already exists and self-hosts
(`compiler/src/build/hash.sfn`). It cannot be used on binaries because
`fs.readFile` coerces its `i8*` return to a Sailfin string via `strlen`
(`compiler/src/llvm/expression_lowering/native/core_operands/pointer_coercion.sfn:42-83`), truncating at the first
NUL. This constraint is recorded verbatim at `hash.sfn:11-19` and
`fs.sfn:525-534`. The unblock is a binary-safe read primitive, not a crypto
port.

**The performance constraint any fix must clear.** The in-process path
already exists for text files but bails above 64 KiB because the vendored
hasher's byte loop collapses under `-O0` CI shard builds — hashing in-process
drove one CI shard from ~6 min to ~23 min (`fs.sfn:662-669`). A naive
in-process swap for binaries would regress CI the same way; the `-O0`
question must be answered as part of the work, not discovered after landing
it.

**Fail-closed behaviour is currently correct, but platform-incomplete.**
`toolchain.sfn:384-388` treats an empty digest as a hard error, which is the
right failure mode — but `_sha256_of_file_cmd` returns `""` unconditionally on
Windows (no `sha256sum`/`shasum` there), so `sfn toolchain install` is
non-functional on Windows by construction, not by bug.

**Recorded follow-on, not scoped here.** The release-signing *producer* path
(`scripts/sign-release-manifest.sh:28,34-35,78,86`) shells to the `openssl`
CLI. Pure Ed25519 signing has since landed in `sfn/crypto` (SFN-699; amendment
below), but rewiring that script remains separate work, not part of Phase E.

**Amendment (2026-08-03) — pure Ed25519 signing landed (SFN-699).**
`capsules/sfn/crypto/src/ed25519_sign.sfn` implements deterministic RFC 8032
signing as `ed25519_sign(seed: int[], message: int[]) -> int[]`, returning the
canonical 64-byte signature or `[]` for a wrong-length seed. Secret base-point
multiplication uses 256 fixed double/add rounds with branch-free coordinate
selection; secret bits never drive control flow or array indexes. The same
module exposes binary-safe, fail-closed RFC 8410 version-0 key decoding as
`ed25519_seed_from_pkcs8_der` and `ed25519_seed_from_pkcs8_pem`. It accepts the
canonical unencrypted Ed25519 PrivateKeyInfo subset and rejects other
algorithms, parameters, extensions, encrypted labels, trailing data, and
malformed DER/PEM. All five RFC 8032 section 7.1 signing vectors pass.

The primitive is the signing dependency consumed by the TLS 1.3 server
CertificateVerify state machine (SFN-654) and by the eventual OpenSSL runtime
body swap (SFN-341). SFN-699 does not implement either consumer, delete link
wiring, or rewire release automation.

**Amendment (2026-07-31) — the read primitive landed; route recorded
(SFN-659).** The binary-safe read this phase was gated on is
`_read_file_bytes(file_path) -> FileBytes ![io]` in
`compiler/src/build/fs.sfn`, returning `{ addr, length, status }`. It is a
plain Sailfin function over libc externs already declared in that module
(`fopen`/`fread`/`fclose`/`ferror`/`malloc`/`free`, plus `realloc` and
`memset`), modelled on the `_copy_file` chunked-`fread` loop in the same
file. `fread` reports the true byte count regardless of embedded NULs, so
binary safety follows from never routing bytes through the `i8*`-to-`string`
coercion (`core_operands/pointer_coercion.sfn:42-83`) that `fs.readFile`
performs.

*Route and its seed-sequencing consequence.* No builtin, no runtime-helper
descriptor row, no intrinsic sentinel, no new runtime symbol — every
construct is one the pinned seed already compiles, so **no seed cut is
required** and the consumer work may land independently. A `fs.readBinary`
builtin was rejected for the opposite reason: the consumer is *compiler
source*, which the pinned seed compiles during `make compile`, so a
descriptor row added to the working tree would not help the call site and
would force a seed cut for a single consumer — the carve-out shape
`.claude/rules/seed-dependency.md` exists to avoid.

*Deviation from §3.3 item 6, stated deliberately.* That rule mandates
`int[]` for arbitrary binary output; its stated reason is that byte `0x00`
is unrepresentable in a Sailfin `string`. An `(addr, length)` pair does not
violate that reason, and `int[]` would: one i64 per byte, built by
bounds-checked appends, is precisely the `-O0` blow-up this section
pre-forbids. `int[]` remains correct for `capsules/sfn/crypto/` public APIs
and is the wrong shape for a build-driver whole-file slurp. Consumers read
bytes back via the `load_byte(addr) -> int` intrinsic.

*Failure modes.* `0` ok · `1` not found · `2` unreadable or I/O error · `3`
allocation failure · `4` over the 512 MiB cap. The buffer is allocated
before the read loop, so a genuinely empty file yields `status == 0,
length == 0, addr != 0` while every failure yields `addr == 0`; the
`""`-means-failure mapping stays the caller's choice rather than being
collapsed the way `fs.readFile` collapses it today. Status `4` is a
deliberate seam: `_sha256_of_file_cmd` stays alive as the pathological-size
fallback rather than silently truncating into a confidently-wrong digest.

*Still open, and owned by the consumer issue (SFN-660).* The `-O0`
constraint above is **not** resolved by this primitive.
`sha256_hex_of_string` (`compiler/src/build/hash.sfn:50`) materialises a
whole-message `int[]` plus padding, so even fed correct bytes it reproduces
the regression that put the 64 KiB threshold there. Retiring
`_sha256_of_file_cmd` requires a scalar `sha256_hex_of_bytes(addr, len)`
entry point streaming 64-byte blocks via `load_byte`, and an actual
measurement. If streaming still does not clear the bar under `-O0`, the
honest outcome is that Phase E waits on the CI shards moving off `-O0` —
not that the threshold is quietly raised.

*Windows.* `fopen`/`fread`/`fclose`/`ferror` all resolve on the Windows leg
(the read uses `"rb"`, never `"r"`, so no CRLF translation corrupts binary
input), so this path is a route to closing the platform-incompleteness noted
above — once SFN-660 repoints the callers.

## 4. Effect & capability impact

**Deterministic crypto primitives are pure — zero effects.** Every Phase A hash/
MAC/KDF/cipher function is a deterministic pure computation over its byte-array/
string inputs (no `![io]`, no `![net]`, no `![rand]`). This mirrors the existing
`sfn/crypto` capsule (`docs/status.md:435`: "no required effects"). SHA-1,
SHA-384, HKDF, ChaCha20 (keystream/xor with a caller-supplied nonce+counter),
Poly1305, and the `bits` helpers all take inputs and return outputs with no
ambient authority. Bare `assert lhs == rhs;` known-answer tests suffice — no
`![io]`, no `sfn/test` matchers.

**The CSPRNG is the one effectful boundary — and it is NOT in Phase A.** WebSocket
key generation and TLS nonces need cryptographically strong randomness, which
today comes from `RAND_bytes` (libcrypto). A native random source reads the OS
entropy device (`getrandom(2)` on Linux, `arc4random_buf` / `/dev/urandom` on
macOS) — that is an I/O syscall and must carry **`![rand]`** at minimum, and
arguably `![io]`. It is a non-deterministic effectful primitive that cannot be
known-answer tested and does not belong in a pure-crypto wave. It is therefore
**deferred to Phase D** (bundled with the `websocket.sfn` extern removal that
actually consumes it), where the effect cost is visible at the exact call site.
Phase A ships only pure, deterministic, known-answer-testable primitives. The
RNG is explicitly **not** folded into any pure module.

**TLS I/O (Phase B+) stays `![net]`.** Replacing OpenSSL's record layer with a
native one does not change the effect surface: `tls_read`/`tls_write`/
`tls_connect_fd`/`tls_accept_fd` already carry `![net]` and continue to. The
*handshake crypto* (key schedule, AEAD) is pure and effect-free; only the socket
read/write that carries the records is `![net]`.

**Capability-seal payoff (the point of the whole SFEP).** Once Phase D lands,
the TLS record layer's socket traffic flows through Sailfin-owned `send`/`recv`
externs (already gated candidates), not through libssl's opaque libc calls. This
is a **prerequisite** for SFEP-0016's syscall chokepoint: the seal cannot gate
what it cannot see, and today it cannot see inside libssl.

## 5. Self-hosting impact

**No compiler-pass changes, and no seed dependency for Phase A.** Phase A adds
only new source modules to the `capsules/sfn/crypto/` *library* capsule and
their tests. It touches **no** `compiler/src/*.sfn`, no `runtime/sfn/*.sfn`, and
no `runtime/capsule.toml`. No lexer/parser/AST/typecheck/effect/emitter/lowering
change is required — the primitives use only constructs the current seed already
compiles (loops, `int[]`, `int` arithmetic, `char_code`/`char_from_code`,
bitwise ops), confirmed by the in-tree SHA-256/base64/HMAC which already
self-host and pass their vector tests under the current compiler.

Because Phase A changes only a library capsule that the compiler's own build
does **not** depend on, `make compile` is unaffected and **no seed cut is
required** (`.claude/rules/seed-dependency.md`). The capsule builds and tests
with whatever compiler binary already exists (`sfn test
capsules/sfn/crypto/tests/<primitive>_test.sfn`).

**Phase D is the seed-coupled change.** It swaps runtime bodies the compiler
binary links (`tls.sfn`, `websocket.sfn`) and vendors the primitives into the
runtime. Per the bundling rule it should land the body swap **and** the
extern/link-wiring deletion in **one PR** — `make compile` builds the new
compiler from the old seed and that compiler links the native crypto in the same
self-host pass, avoiding a seed cut between "native stack exists" and "OpenSSL
removed." Phase A deliberately front-loads all the seed-independent work so the
seed-coupled surface is minimized to Phase D.

## 6. Alternatives considered

### 6.1 Vendor BoringSSL / build OpenSSL from source
Rejected. Vendoring reintroduces a C/CMake build step — the exact thing the
C-runtime retirement (#822) removed — and BoringSSL deliberately breaks API. It
would trade a system-lib dependency for a heavier vendored-build dependency and
still leave an opaque C blob the seal cannot see through. Does not advance
SFEP-0016.

### 6.2 Keep OpenSSL, gate it at the syscall layer only
Rejected. SFEP-0016's chokepoint gates *Sailfin-owned* syscall stubs; libssl
calls libc directly and would bypass the gate unless we interpose every libc
symbol libssl uses — a fragile, incomplete interposition surface. Owning the
TLS stack is the clean cut.

### 6.3 rustls-style scope cuts (TLS 1.3 only, no TLS 1.2)
**Adopted for Phases B–D**, and it is what makes the native TLS effort
tractable. TLS 1.3 only (no 1.2 downgrade), ChaCha20-Poly1305 AEAD only
(deferring AES-GCM, which needs constant-time AES — hard without hardware AES
intrinsics the backend does not yet expose), X25519 key exchange only, Ed25519 +
ECDSA-P256 + RSA cert signatures (§6.3 amendment below). No session
resumption/tickets, no ALPN beyond `http/1.1`, no OCSP, no client-cert/mTLS
(already out of scope in SFEP-0036).
This mirrors the deliberately-minimal surface `tls_features_required` documents
the runtime actually exercises. Phase A ships exactly the *missing* primitives
this cut needs: ChaCha20 + Poly1305 (AEAD), SHA-384 (SHA-256 already ships;
transcript hash + HKDF), HKDF (key schedule), SHA-1 (WebSocket handshake accept
value, the libcrypto removal).

**Amendment (2026-07-31) — RSA certificate-signature verification is now IN
scope; RSA signing/keygen remain out.** The original cut excluded RSA on
tractability grounds, but that judgement was inherited from the same
pre-2026-07-25 analysis that wrongly declared X25519 blocked (§6.4 amendment)
— it never re-ran the width search that overturned that call. The decisive
point: RSA *verify* operates entirely on public data (public key, public
signature, public message), so it carries **no constant-time requirement** —
the constraint that makes the private-key side hard does not apply. It is
bignum modular exponentiation with a small public exponent (typically 65537).

The motivating reason to add it: the overwhelming majority of public-web
certificate chains are RSA-rooted. Ed25519 + ECDSA-P256 alone verifies only
known peers, not the general web, which makes the native stack a non-replacement
for libssl rather than a drop-in.

Two verify modes are required, not one — a correctness point worth stating
plainly, since conflating them is a real interop bug: **RSASSA-PKCS1-v1_5**
(RFC 8017 §8.2.2) for X.509 certificate signatures, and **RSASSA-PSS**
(RFC 8017 §8.1.2) for TLS 1.3 CertificateVerify — RFC 8446 §4.2.3 forbids
PKCS#1 v1.5 in CertificateVerify and mandates the `rsa_pss_rsae_*` schemes.
Both share one modexp core.

Still deferred/out of scope: RSA signing, RSA key generation, and AES-GCM
(unchanged — the original AES reasoning above stands).

### 6.4 Pure-Sailfin X25519 in Phase A
**Rejected for Phase A — recorded as a blocker (§7).** Curve25519 field
arithmetic mod `2^255 − 19` requires either 51-bit limbs (needs a `64×64 → 128`
multiply that Sailfin cannot express) or 25.5-bit limbs (10 limbs) whose
field-multiply carry chain runs to ~`2^58` per output column with the ×19
reduction — inside i64 in principle, but with a thin margin and no
compiler-enforced overflow check, and requiring a **constant-time conditional
swap** (`cswap`) whose branch-free correctness is the exact thing the current
`ashr`-only, unsigned-broken integer model makes hard to guarantee. The
instruction is explicit: do not spec workarounds not trusted to be
constant-correct. X25519 is therefore excluded from the Phase A waves and filed
as a blocker; it gates Phase B (TLS 1.3 key exchange is impossible without it).
It is the canonical use case for SFEP-0058 and a future
`64×64 → 128` widening-multiply intrinsic.

**Amendment (2026-07-25) — WITHDRAWN.** This rejection evaluated exactly two
limb widths (51-bit and 25.5-bit) and stopped at the first one that fit "in
principle," without going narrower — even though §3.3 item 5 mandates exactly
that search. At **16 limbs × 16 bits** (the TweetNaCl `gf` layout,
`2^256 ≡ 38 mod p`), the worst-case intermediate across the entire scalar
multiplication is `2^45.80`, leaving 16.2 bits of headroom below `2^62`, and it
needs **no new compiler capability** — no sized integers, no unsigned
semantics, no `lshr`, no `64×64 → 128` widening multiply. The full margin
analysis and ladder operand audit are in
`docs/proposals/design-notes/sfn-335-x25519-limb-strategy.md` §§1–3. X25519
shipped in pure Sailfin as `capsules/sfn/crypto/src/x25519.sfn` (SFN-335); see
the §7 amendment for the blocker-record disposition. SFN-502 consequently
records widening multiply as not needed and files no proposal; its scope
decision is in
`docs/proposals/design-notes/sfn-502-widening-multiply-scope.md`. The original
rejection above is preserved as the historical record of what was actually
evaluated.

### 6.5 Put the new primitives in `runtime/sfn/crypto/` instead of the capsule
Rejected for Phase A. The existing crypto surface already lives in the
`capsules/sfn/crypto/` library capsule, which is where user-facing crypto and
its vector-test coverage belong; founding a parallel `runtime/sfn/crypto/` tree
now would fork the surface and duplicate SHA-256/base64. Phases B–D consume the
primitives from compiler-runtime modules that *cannot* import a library capsule,
but that is solved by vendoring (§3.2) — the same pattern `build/hash.sfn`
already uses — not by relocating the tested source of truth out of the capsule.

## 7. Blockers

- **X25519 (Curve25519 ECDH) — WITHDRAWN (2026-07-25), no longer a blocker.**
  Previously recorded as not buildable in Phase A pending sized/unsigned integer
  semantics (SFEP-0058) or a widening-multiply intrinsic. That evaluation
  stopped at 51-bit and 25.5-bit limb widths; at 16 limbs × 16 bits (TweetNaCl's
  `gf` layout) the worst-case intermediate is `2^45.80`, 16.2 bits below `2^62`,
  with no new compiler capability required. Full analysis:
  `docs/proposals/design-notes/sfn-335-x25519-limb-strategy.md`. Shipped in pure
  Sailfin as `capsules/sfn/crypto/src/x25519.sfn` (SFN-335), self-hosted, and
  regression-covered by the RFC 7748 §5.2/§6.1 vectors. Phase B's key exchange
  is unblocked. SFN-502 therefore records no current need for widening multiply
  and files no proposal; see
  `docs/proposals/design-notes/sfn-502-widening-multiply-scope.md`.
  Ed25519-verify was the separate follow-on (§8 of the limb-strategy note); it
  shipped in pure Sailfin as SFN-655 after the field port and SHA-512 landed.

- **AES-GCM AEAD — deliberately deferred (not a hard blocker for the chosen
  cut).** Constant-time software AES needs either bitsliced AES (very large,
  error-prone) or hardware AES-NI intrinsics the backend does not expose. The
  rustls-style cut (§6.3) sidesteps this by shipping **ChaCha20-Poly1305 only**,
  which Phase A fully delivers. Recorded so a future "AES-GCM parity" ask lands
  on a known missing capability (SIMD/AES intrinsics), not a surprise.

- **Pure-Sailfin HMAC-SHA-256 + Ed25519-verify — deferred to Phase D.** The
  shipped `hmac_sha256` (`mod.sfn`) and `ed25519_verify` (`ed25519.sfn`) are
  OpenSSL-backed; a fully OpenSSL-free build needs pure ports. HMAC-SHA-256 is
  trivially portable once Phase A's HKDF (which already composes HMAC over the
  pure SHA-256) exists — indeed Phase A's HKDF spec includes a pure HMAC-SHA-256
  helper. Ed25519-verify needs the same Curve25519 field arithmetic X25519 needs
  and is therefore blocked on the same missing capability. Both are Phase D
  concerns, not Phase A.

  **Amendment (2026-07-31) — HMAC-SHA-256 half RESOLVED; Ed25519-verify
  blocker description refreshed.** HMAC-SHA-256 is now pure Sailfin:
  `capsules/sfn/crypto/src/hkdf.sfn:142-197` provides `hmac_sha256_bytes` over
  the existing pure SHA-256, and `capsules/sfn/crypto/src/mod.sfn:75-109`
  delegates `hmac_sha256` to it — the former libcrypto `HMAC`/`EVP_sha256`
  externs are retired (see the note at `mod.sfn:73`).

  Ed25519-verify remains the open half, but it is no longer gated on a missing
  compiler capability. Per the limb-strategy note §8
  (`docs/proposals/design-notes/sfn-335-x25519-limb-strategy.md`), the
  Curve25519 field layer it needed now exists
  (`capsules/sfn/crypto/src/x25519.sfn`, SFN-335), and what remains is the
  twisted-Edwards group law, a `pow(z, (p−5)/8)` square root, and SHA-512 —
  where `sha384.sfn:1-68` already carries the SHA-512 compression machinery
  (same compression function, different IV, untruncated output).
  `capsules/sfn/crypto/src/ed25519.sfn:10-26` is now the **only** remaining
  OpenSSL extern in the crypto capsule, and because `compiler/capsule.toml:59`
  makes the compiler itself depend on `sfn/crypto`, this single module is what
  keeps `-lcrypto` on the compiler's own link line.

  **Amendment (2026-08-02) — RESOLVED (SFN-655).** Ed25519 verification is now
  pure Sailfin in `capsules/sfn/crypto/src/ed25519.sfn`, sharing the 16×16-bit
  field layer from `x25519.sfn` and the byte-oriented SHA-512 from SFN-652. The
  implementation covers twisted-Edwards addition and scalar multiplication,
  canonical point decompression with the fixed `(p−5)/8` square-root chain,
  scalar reduction, and the RFC 8032 §5.1.7 `S < L` check. All RFC 8032 §7.1
  Ed25519 vectors and malformed-input regressions pass. No `extern` declaration
  remains in `ed25519.sfn`; the public `ed25519_verify` and
  `ed25519_verify_utf8` surface is unchanged. This retires the crypto capsule's
  final OpenSSL use. The runtime TLS implementation still owns the remaining
  `-lssl`/`-lcrypto` link dependency until SFN-341 performs the body swap.

## 8. Stage1 readiness mapping

Phase A adds no language syntax, so the parse/typecheck/emit/lower rows are
satisfied by *existing* compiler support for the constructs used; the
feature-completeness bar is regression coverage + a green capsule build.

- [x] Parses — no new syntax; uses existing loops/`int[]`/bitwise ops.
- [x] Type-checks / effect-checks — pure fns, no new effects; existing effect
      checker already handles these.
- [x] Emits valid `.sfn-asm` — same constructs the in-tree SHA-256 emits.
- [x] Lowers to LLVM IR — ditto.
- [ ] Regression coverage — new: known-answer-vector tests per primitive
      (§ Phase A specs), under `capsules/sfn/crypto/tests/<primitive>_test.sfn`.
- [ ] Self-hosts — `make compile` is unaffected (library-capsule-only change,
      no seed dependency, §5); the bar is `sfn test capsules/sfn/crypto/tests`
      green.
- [ ] `sfn fmt --check` clean — on every new `capsules/sfn/crypto/src/*.sfn`.
- [ ] Documented in `docs/status.md` + spec — update the `sfn/crypto` row
      (`docs/status.md:435`) to list SHA-1/SHA-384/HKDF/ChaCha20/Poly1305.

## 9. Test plan

Per the `sfn/crypto` capsule's established convention, each new primitive gets a
`capsules/sfn/crypto/tests/<primitive>_test.sfn` importing the module under test
by relative path (`import { sha1_hex } from "../src/sha1";` or via the `mod.sfn`
re-export). Test bodies are plain `test "<name>" { assert ...; }` blocks with
hardcoded known-answer vectors from the governing RFC (inlined in the Phase A
specs): RFC 3174/6234 (SHA-1), FIPS 180-4 / RFC 6234 (SHA-384), RFC 5869 (HKDF),
RFC 8439 (ChaCha20, Poly1305). Pure fns use bare `assert lhs == rhs;` (no
`sfn/test` matcher machinery, no `![io]`). Run a single file with `build/bin/sfn
test capsules/sfn/crypto/tests/sha1_test.sfn`.

Phase B/C/D add: a native-vs-OpenSSL differential test (record-layer round-trip,
handshake transcript), an X.509 chain-verification vector set, the CSPRNG
liveness smoke test (`![rand]`, never known-answer), and the loopback e2e
already established by SFEP-0036 §10 (self-signed cert, `SAILFIN_TLS_CAFILE`)
re-pointed at the native stack.

## 10. References

- SFEP-0016 (`0016-capability-sealed-runtime.md`, Accepted) — the seal this
  unblocks; 1.0 hallmark / GA blocker per `docs/strategy/decision-brief.md`.
- SFEP-0036 (`0036-tls-runtime.md`, Implemented) — the OpenSSL TLS runtime this
  replaces; its `tls_*` wrapper contracts are the Phase D swap target.
- SFEP-0060 (`0060-owned-syscall-layer.md`) — owned syscall ownership, the seal's
  other prerequisite; SFEP-0066 §3.5 corrects this as independent of backend
  (code-generation) ownership.
- `0058-sized-integer-types.md` — was cited as the missing capability behind the
  X25519 / Ed25519 blocker (§7); X25519 no longer depends on it (§6.4
  amendment, `docs/proposals/design-notes/sfn-335-x25519-limb-strategy.md`).
  Ed25519 verification subsequently shipped on the same narrow field layer
  (SFN-655), without sized integers.
- Prior art: `capsules/sfn/crypto/src/mod.sfn` (SHA-256, base64, HMAC-SHA-256),
  `capsules/sfn/crypto/src/ed25519.sfn` (pure RFC 8032 verify),
  `compiler/src/build/hash.sfn` (vendored SHA-256 — the runtime-vendoring
  template for Phases B–D).
- Ground-truth extern surface: `runtime/sfn/platform/tls.sfn`,
  `runtime/sfn/adapters/websocket.sfn:98-102`,
  `compiler/src/build/runtime_objs.sfn:904-937`, `runtime/capsule.toml:49,59`.
- RFCs: 4648 (base64, shipped), 3174/6234 (SHA-1), FIPS 180-4 / RFC 6234
  (SHA-384), 2104/4231 (HMAC), 5869 (HKDF), 8439 (ChaCha20 + Poly1305), 7748
  (X25519, shipped — SFN-335).
