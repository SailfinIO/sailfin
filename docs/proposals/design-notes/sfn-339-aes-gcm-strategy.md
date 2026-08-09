# SFN-339 — AES-GCM strategy: is constant-time pure-Sailfin AES buildable under the current integer model?

> Single-issue design gate (no SFEP number). Design context: SFEP-0048
> (`docs/proposals/0048-native-crypto.md`, Accepted) §3.3 item 5 (the narrow-limb
> search this note runs), §6.3 (the cut that deferred AES-GCM), §7 (the blocker
> record). It answers one question — **can AES-GCM be implemented today, and
> constant-time, without the AES intrinsics §6.3 said it needed?** — and amends
> that section's scope. It changes no language surface, adds no compiler
> capability, and has no seed dependency.

## 1. Verdict

**VIABLE, and constant-time by construction.** AES-128/AES-256-GCM is buildable
today in pure Sailfin with **no new compiler capability** — no sized integers, no
unsigned semantics, no `lshr`, no `64×64 → 128` widening multiply, no AES-NI
intrinsic.

The representation is **bitsliced AES over 8 words of 32 bits**, word `i` holding
bit `i` of each of the 32 state bytes (16 bytes × 2 blocks). GHASH multiplies via
**masked-integer carryless multiplication on 32-bit operands**. Neither needs
anything the seed lacks, so **zero seed cuts**.

**Why §6.3 got this wrong.** It deferred AES-GCM because "constant-time software
AES needs either bitsliced AES (very large, error-prone) or hardware AES-NI
intrinsics the backend does not expose." That names two options, calls the
tractable one unpleasant, and stops — the identical failure mode the §6.4
amendment identified in itself. The deeper error is a *conflation*: "very large"
and "error-prone" are code-size and review-burden claims, while whether a
construction is **expressible** under Sailfin's `ashr`-only integer model is a
different question, and it was answered by assumption rather than by the search
§3.3 item 5 mandates.

## 2. The search terminates immediately, because bitsliced AES does no arithmetic

§3.3 item 5's search is over *arithmetic* intermediates ("narrow limbs whose
pairwise products stay inside i64"). Bitsliced AES has none. Its entire round
function is `and`, `or`, `xor`, `not`, and lane-local shifts on words masked to
`[0, 2^32)`.

Worst case across the whole cipher, both key sizes, and any message length:

```
(2^32 - 1) << 15  <  2^47
```

**15 bits of headroom below 2^62, 16 below 2^63.** Critically there is **no
accumulation term**: a Boolean circuit never sums, so unlike X25519's `2^45.80`
the bound cannot drift with round count, key size, or message length. It is a
wider margin on a strictly easier problem.

`NOT x` is `x ^ 4294967295`. No hex literals exist in the lexer, so every mask is
decimal.

**Why 32-bit words and not 64.** A word masked to `2^64` necessarily sets bit 63,
at which point `>>` (`ashr`) sign-extends and the idiom collapses. Holding a
64-bit word as two 32-bit limbs is arithmetically identical to two independent
32-bit instances, so there is no gain. 32-bit words is not a preference; it is
what the `ashr`-only shift model permits. This mirrors `bits.sfn`'s own
`rotl32`/`rotr32` precondition ("`x` must already be a masked 32-bit value so
`>>` behaves as a logical shift") and the shipped ChaCha20 and Poly1305 modules.

### 2.1 GCM needs encryption only

GCM is CTR mode: it uses AES *encryption* in both directions. `InvSubBytes`,
`InvMixColumns`, and the entire equivalent-inverse-cipher apparatus are absent.
That halves the size objection before any other consideration.

### 2.2 "Error-prone" is backwards for this primitive

AES has the most comprehensive public known-answer vector set of anything in the
capsule — FIPS-197 Appendix B/C, NIST SP 800-38A CTR, NIST CAVP GCM. Its
correctness is *more* mechanically verifiable than Ed25519's or P-256's, both of
which shipped.

## 3. The S-box: a sourcing constraint, and the derivable construction

This is the one place the plan needed changing, and it is a **practical**
constraint rather than a mathematical one.

The S-box is the only nonlinear part of AES and therefore the only place the
constant-time question actually lives: a lookup table leaks through the cache, a
Boolean circuit does not. The literature's smallest circuit is Boyar–Peralta
(2010), ~32 AND + ~83 XOR/XNOR ≈ 115 gates.

**That circuit must be sourced, not recalled.** It is a specific gate list with
no internal redundancy — a transcription error produces a wrong S-box, and while
FIPS-197 vectors would catch it, "type in 115 gates from memory and hope" is not
a defensible way to author a cipher. Adopting it requires the published circuit
in hand.

So this note specifies a construction that is **derivable from first principles**
and gives up nothing that matters:

```
sbox(x) = affine(inv(x))
inv(x)  = x^254 in GF(2^8) with the AES polynomial x^8 + x^4 + x^3 + x + 1
        = x^128 · x^64 · x^32 · x^16 · x^8 · x^4 · x^2
```

`inv(0) = 0` falls out: `0^254 = 0`, which is exactly the S-box's defined
behaviour at zero, so no special case and therefore no branch.

The affine step is the standard AES map, `b_i' = b_i ⊕ b_{(i+4) mod 8} ⊕
b_{(i+5) mod 8} ⊕ b_{(i+6) mod 8} ⊕ b_{(i+7) mod 8} ⊕ c_i` with `c = 0x63`. In the
bitsliced representation it is eight XOR chains across the eight words plus two
complements — free.

**Why this is fast enough: squaring in GF(2^8) is linear.** Frobenius —
`(a + b)^2 = a^2 + b^2` in characteristic 2 — makes squaring a bit permutation
followed by reduction XORs, roughly 10 gates, *not* a full multiply. So inversion
costs **7 cheap squarings + 6 full multiplies**, where a bitsliced GF(2^8)
multiply is schoolbook (64 AND + ~56 XOR partial products) plus reduction
(~20 XOR) ≈ 140–164 gates.

Per round, over all 32 bytes at once:

| Component | gates |
|---|---|
| 6 × bitsliced GF(2^8) multiply | ~984 |
| 7 × Frobenius squaring | ~70 |
| affine map | ~26 |
| **SubBytes total** | **~1,080** |

≈ **34 gates/byte** for SubBytes. Against Boyar–Peralta's ~115 gates (≈ 3.6
gates/byte) this is roughly 9× more expensive *for the S-box*, but SubBytes is
not the whole cipher — with the linear layer included, total AES cost lands near
**~140 ops/byte** rather than the ~72 the sourced circuit would give.

**Estimated throughput**, extrapolating the SFN-768 *measured* pointer-layer
figures (`docs/status.md`: 233–235 MB/s at `-O2`, 42–43 MB/s at `-O0`):

| | ops/byte | est. `-O2` |
|---|---|---|
| ChaCha20-Poly1305 (measured baseline) | ~29–34 | 233–235 MB/s |
| AES-128-GCM, derivable S-box | ~193 | **~36 MB/s** |
| AES-128-GCM, Boyar–Peralta S-box | ~125 | ~63 MB/s |

~36 MB/s still clears the ~20 MB/s `-O2` bar in
`docs/proposals/design-notes/sfn-341-native-tls-runtime-swap.md` §3.3 by ~1.8×.
These are estimates; per the SFN-768 precedent the implementing issue's
acceptance must carry a **measured** figure at both `-O0` and `-O2`, and if
`-O2` misses the bar the honest outcome is a documented ceiling in
`docs/status.md`, not an omitted number.

**Boyar–Peralta therefore becomes a contingent optimization**, not the v1: it is
a drop-in replacement for one function with identical inputs, outputs, and KATs,
worth taking only once the circuit is in hand and only if the measured number
warrants it. Same for fixslicing (Adomnicai–Najm–Peyrin 2020, ~1.3–1.9×). Do not
file either up front.

**The security claim is unchanged by this substitution.** No lookup table exists
in either construction; no branch or array index depends on the key or
plaintext. The derivable version is table-free for the same structural reason and
is, if anything, easier to review — a reviewer can *check* `x^254` against the
field axioms, whereas a 115-gate list can only be diffed against a reference.

### 3.1 The key schedule uses the same circuit

`SubWord` operates on secret key material, so it must not use a table either. It
runs the same bitsliced S-box, wasting 28 of 32 lanes. That costs ~21k word-ops
once per direction per connection — three orders of magnitude below X25519's
per-connection cost, and the reason a table-free module is affordable at all:
**the only place a table is tempting is the key schedule, and the key schedule is
free.**

## 4. GHASH: where the width search does real work

### 4.1 Rejected: table-driven GHASH

The standard 4-bit or 8-bit window tables are indexed by values derived from `H`,
the authentication subkey. Recovering `H` yields tag forgery — a *more* severe
outcome than key recovery through the cipher side channel. Rejected for the same
reason as T-tables, with more force.

### 4.2 Rejected: 128-iteration constant-time shift-and-xor

Correct, but ~47 word-ops × 128 = ~6,000 ops per 16-byte block ≈ **375 ops/byte**,
which would make GHASH ~3× the cipher's cost and drag the total to the bar.

### 4.3 Adopted: masked-integer carryless multiplication (`_clmul32`)

Split each 32-bit operand into four right-aligned classes (mask `286331153`,
i.e. `0x11111111`):

```
x0 = x & 286331153
x1 = (x >> 1) & 286331153
x2 = (x >> 2) & 286331153
x3 = (x >> 3) & 286331153
```

Each class holds bits only at positions ≡ 0 mod 4 in `0..28`, so **at most 8 set
bits**. For any output position `p`, the number of colliding pairs `(a, b)` with
`a + b = p` and `a, b ∈ {0, 4, …, 28}` is at most 8. A count of 8 occupies 4 bits
(`1000₂`), contaminating `p+1, p+2, p+3` — all ≢ 0 mod 4, hence all removed by the
output mask. **Carries never reach `p+4`.**

**Bound.** Products `xi * yj ≤ 286331153² = 2^56.19`; masked, then shifted left by
`i + j ≤ 6`:

```
max intermediate = 2^62.19   (5.247e18)
i64 max          = 2^63      (9.223e18)
headroom         = 0.813 bits
```

Non-negative throughout, so `ashr` stays logical. The bound is **exact,
deterministic, and message-length-independent** — it is the magnitude of the
answer itself, since a carryless product of two 32-bit values has degree ≤ 62.
Thin, but hard, unlike an accumulation bound.

**64-bit operands are not merely awkward, they are incorrect.** 16 set bits per
class permits a count of 16, whose fifth bit lands at `p+4` — the same residue
class — and survives the mask. 32 bits is the widest *correct* width, and `ashr`
independently forbids 64-bit words anyway.

Output masks, all expressible as positive decimal i64 literals:

```
1229782938247303441   //  0x1111111111111111
2459565876494606882   //  0x2222222222222222
4919131752989213764   //  0x4444444444444444
614891469123651720    //  0x0888888888888888
```

Note `0x8888888888888888 = 9838263505978427528 > i64 max` and is **not
writable**; dropping bit 63 is sound because the product's degree is ≤ 62, so bit
63 is provably zero.

**Guard the bound with a KAT at the exact worst case**, `_clmul32(4294967295,
4294967295)`, so it is regression-covered rather than merely argued. `compiler/src/llvm/`
emits no `nsw`/`nuw`, so a bound violation would wrap rather than be UB — it
would fail that KAT loudly instead of silently miscompiling.

**Fallback if 0.813 bits ever proves uncomfortable:** `_clmul16` on 16-bit
operands (masks 4369 / 8738 / 17476 / 34952), max intermediate `34952² = 2^30.19`,
**31.8 bits of headroom**, at ~4× the cost.

**Cost.** 128×128 = 4×4 = 16 `_clmul32` calls × ~43 ops ≈ 690, plus hi/lo
accumulation into four 32-bit limbs (~96) plus reduction mod
`x^128 + x^7 + x^2 + x + 1` (~60) ≈ **850 ops per 16-byte block = ~53 ops/byte**.
Karatsuba would cut 16 calls to 9; not required in v1.

## 5. Why not T-tables, stated as a tradeoff rather than a reflex

For a TLS *client* fetching a release asset, the cache-timing attack needs an
adversary with local code execution on the same host observing L1/L2 timing —
and such an adversary can already read the traffic key out of our address space.
**For that specific use, T-tables would be acceptable.** Three reasons that does
not decide it:

1. **`sfn/crypto` is a public library capsule**, `kind = "library"` with
   `[capabilities] required = []`, exporting `aes_gcm_seal`/`open` to any user.
   There is no mechanism to scope a timing caveat to "only from a TLS client on a
   host you own."
2. **There is no tradeoff to make.** The constant-time construction is
   computed-feasible above and clears the throughput bar. T-tables would buy
   perhaps 2× we do not need, in exchange for a caveat we would have to publish.
3. **Ship-then-swap is pure rework.** The swap is invisible — same KATs, same API
   — so the only artifact of a first T-table cut is a `docs/status.md` caveat we
   then retract. This repo has retracted enough.

Per `docs/strategy/decision-brief.md`'s restriction-vs-power test, a documented
negative security property is a restriction with no attached power.

**The RSA-verify escape hatch does not extend here and is not used.** §6.3's 2026-07-31
amendment un-deferred RSA verify because it "operates entirely on public data …
carries **no** constant-time requirement." AES in TLS operates on a symmetric
traffic key; the requirement is real. What transfers is that amendment's
*motivating* argument — ChaCha20-only makes the native stack "a non-replacement
for libssl rather than a drop-in" on the AEAD axis, exactly as ed25519-only did
on the signature axis (`sfn-341-native-tls-runtime-swap.md` §3.4).

## 6. AES-NI: right long-term answer, and a seed-gated one

`compiler/capsule.toml` declares `[dependencies] "sfn/crypto" = "*"`, and
`make compile` is `<seed> build -p compiler`. So the **pinned seed** resolves and
compiles the working-tree `capsules/sfn/crypto/src/*.sfn`. The runtime-source
carve-out in `.claude/rules/seed-dependency.md` therefore **generalises to any
source the pinned seed compiles**, which includes every capsule in the compiler's
dependency closure — not `runtime/` alone. A new intrinsic called from
`sfn/crypto` must exist in the **seed**, and bundling cannot help.

Consequences: an AES-NI path needs a `seed-blocker` predecessor landing the whole
`aesenc`/`aesenclast`/`aeskeygenassist`/`pclmulqdq` family at once, then a queued
cadence seed cut, then consumers. It also needs CPUID dispatch and a software
fallback regardless, since the compiler targets macOS arm64 (wanting
`AESE`/`AESMC`, a second family) and Windows cross-builds.

It would be a **pure optimization over an already-shipped software path**, never
the thing that unblocks interop. The pure-Sailfin path costs zero seed cuts.

## 7. Scope

**In:** AES-128 and AES-256 key schedules, encryption, CTR; GHASH; AES-128-GCM
and AES-256-GCM `seal`/`open`; an `aead` registry so the record layer dispatches
rather than hardcoding ChaCha20; NIST vector coverage.

**Out:** the `TLS_AES_256_GCM_SHA384` cipher suite. It needs `hash_len = 48`
threaded through `tls13_handshake.sfn`, whose `_hash_len()` returns a constant 32
by deliberate design, and there is no RFC 8448 SHA-384 trace to check it
against. **RFC 8446 §9.1** — "A TLS-compliant application MUST implement the
TLS_AES_128_GCM_SHA256 cipher suite" — makes offering AES-128-GCM sufficient for
universal TLS 1.3 interop, so this is a clean scope cut rather than a punt. The
AES-256-GCM *AEAD* still ships: a 32-byte key is ~60 extra lines of key schedule
and the capsule is a public library.

Also out: RSA signing, RSA keygen (unchanged), Boyar–Peralta and fixsliced S-box
variants (contingent optimizations, §3).

## 8. The published claim

Constant-time **by construction**: no lookup table exists anywhere in the AES or
GHASH modules — including the key schedule — and no branch or array index depends
on the key, the plaintext, or the GHASH subkey `H`. The AEAD tag is compared with
`bits::ct_eq_bytes` before decryption.

Scoped honestly: that is a property of the algorithm and of the emitted LLVM IR,
whose S-box and GHASH cores are straight-line and table-free. It is **not** a
claim about host microarchitecture; Sailfin has no compiler barrier preventing a
future optimizer from introducing a data-dependent `select`; and **no automated
constant-time verification (ct-verif, dudect, or equivalent) is run** — the
property is established by construction and code review, and re-checked by review
on every change to these modules.

Do not attempt a mechanical "zero branches in the IR" guard: `int[]` bounds checks
put `br` in every function, so the assertion would be false, and a cleverer one
would be fragile theatre. The invariant to enforce in review is *structural* —
"no secret-indexed array exists in these modules" — which is checkable by reading.
