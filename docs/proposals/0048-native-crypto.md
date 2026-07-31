---
sfep: 0048
title: Native crypto + TLS stack — removing the OpenSSL dependency
status: Accepted
type: runtime
created: 2026-07-12
updated: 2026-07-31
author: "agent:compiler-architect; human review"
tracking:
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

**Current surface (ground truth).** Exactly one file
(`runtime/sfn/platform/tls.sfn`) owns the entire OpenSSL extern surface (24
`SSL_*`/`SSL_CTX_*` symbols) and defines every `tls_*` wrapper. Three consumers
(`http.sfn`, `websocket.sfn`, `serve.sfn`) forward-declare the `tls_*` wrapper
signatures (the #306 cross-module-extern workaround) rather than importing
`tls.sfn`. Separately, `websocket.sfn` declares three **libcrypto** externs —
`SHA1`, `EVP_EncodeBlock`, `RAND_bytes` — used **unconditionally** for the RFC
6455 handshake and frame masking on *every* WebSocket connection, `ws://` and
`wss://` alike. This matters: naively dropping `-lcrypto` breaks all WebSocket
traffic, not just TLS. Phase A's SHA-1 + base64 (already shipped) + a CSPRNG
source are the prerequisites that let Phase D remove those three externs.
Additionally, `capsules/sfn/crypto/src/mod.sfn` itself uses libcrypto for
`hmac_sha256` (the `HMAC`/`EVP_sha256` externs) and `ed25519.sfn` uses the
OpenSSL EVP surface for Ed25519 verify — a fully OpenSSL-free build eventually
needs pure-Sailfin replacements for those too (out of Phase A scope; noted in §7).

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
(`compiler/src/build/fs.sfn:507-519`) rather than by any Sailfin-owned code.

**Consumers.** Build-cache keys (`compiler/src/build_cache.sfn:1178,1198`),
compiler self-identity (`compiler/src/cli_selfhost.sfn:392`), seed/toolchain
tarball verification (`compiler/src/cli/commands/toolchain.sfn:383`), `sfn
package`/`add`/`publish` (`compiler/src/cli/commands/package.sfn:239,428,599`,
`compiler/src/cli/commands/add.sfn:425`), and the determinism triple-pass
(`compiler/src/build/determinism.sfn:231,296`).

**The blocker is not crypto.** Pure SHA-256 already exists and self-hosts
(`compiler/src/build/hash.sfn`). It cannot be used on binaries because
`fs.readFile` coerces its `i8*` return to a Sailfin string via `strlen`
(`compiler/src/llvm/core_operands.sfn:1013-1043`), truncating at the first
NUL. This constraint is recorded verbatim at `hash.sfn:11-19` and
`fs.sfn:521-534`. The unblock is a binary-safe read primitive, not a crypto
port.

**The performance constraint any fix must clear.** The in-process path
already exists for text files but bails above 64 KiB because the vendored
hasher's byte loop collapses under `-O0` CI shard builds — hashing in-process
drove one CI shard from ~6 min to ~23 min (`fs.sfn:541-548`). A naive
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
CLI and would additionally need Ed25519 *signing* — which the verify-only
port (§7) does not provide — before it could be retired. That is separate
work, not part of Phase E.

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
  Ed25519-verify remains a separate follow-on (§8 of the limb-strategy note)
  still gated on the same field-arithmetic port plus SHA-512.

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
- SFEP-0015 (`0015-llvm-independence.md`) — backend/syscall ownership; the seal's
  other prerequisite.
- `0058-sized-integer-types.md` — was cited as the missing capability behind the
  X25519 / Ed25519 blocker (§7); X25519 no longer depends on it (§6.4
  amendment, `docs/proposals/design-notes/sfn-335-x25519-limb-strategy.md`).
  Ed25519-verify remains a separate follow-on.
- Prior art: `capsules/sfn/crypto/src/mod.sfn` (SHA-256, base64, HMAC-SHA-256),
  `capsules/sfn/crypto/src/ed25519.sfn` (OpenSSL-EVP wrapper pattern),
  `compiler/src/build/hash.sfn` (vendored SHA-256 — the runtime-vendoring
  template for Phases B–D).
- Ground-truth extern surface: `runtime/sfn/platform/tls.sfn`,
  `runtime/sfn/adapters/websocket.sfn:98-102`,
  `compiler/src/build/runtime_objs.sfn:904-937`, `runtime/capsule.toml:49,59`.
- RFCs: 4648 (base64, shipped), 3174/6234 (SHA-1), FIPS 180-4 / RFC 6234
  (SHA-384), 2104/4231 (HMAC), 5869 (HKDF), 8439 (ChaCha20 + Poly1305), 7748
  (X25519, shipped — SFN-335).
