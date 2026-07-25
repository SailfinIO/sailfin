# SFN-335 — X25519 limb strategy: is pure-Sailfin Curve25519 buildable under the current integer model?

> Single-issue design gate (no SFEP number). Design context: SFEP-0048
> (`docs/proposals/0048-native-crypto.md`, Accepted) §3.3 (the narrow-limb
> masking idiom), §6.4 (the Phase A rejection of X25519), §7 (the blocker
> record). This note answers exactly one question and does not amend the SFEP's
> phasing: **can X25519 be implemented safely today, at a limb width §6.4 never
> evaluated?** It changes no language surface, adds no compiler capability, and
> has no seed dependency.

## 1. Verdict

**VIABLE.** X25519 is buildable today, in pure Sailfin, in
`capsules/sfn/crypto/src/x25519.sfn`, with **no new compiler capability** — no
sized integers, no unsigned semantics, no `lshr`, no `64×64 → 128` widening
multiply.

The representation is **16 limbs of 16 bits** (`h = Σ h_i · 2^(16i)`, i = 0..15,
reduction `2^256 ≡ 38 mod p`) — the TweetNaCl `gf` layout. Worst-case
intermediate across the entire scalar multiplication is **2^45.80**, leaving
**16.2 bits of headroom below 2^62** and 17.2 bits below 2^63. Under a
deliberately loosened declared precondition (limbs ≤ 2^19, §3.4) the bound is
2^47.16 — still **14.8 bits below 2^62**. Every value fed to `>>` in the field
layer is provably non-negative, so `ashr` is `lshr`. The two places a sign-bearing
shift appears are borrow extractions of the form `(x >> 16) & 1` on values
provably in `[-2^16, 2^16]`, which are correct under `ashr` *and* under `lshr` —
the identical construction SFN-331 already shipped and tested in
`capsules/sfn/crypto/src/poly1305.sfn:183`.

**Why §6.4 got this wrong.** §6.4 evaluated exactly two widths and stopped at the
first one that fit "in principle": 51-bit (impossible — needs a widening
multiply) and 25.5-bit/10-limb (~2^58, "a thin margin"). It never went narrower,
even though SFEP-0048 §3.3 item 5 *mandates* going narrower and Poly1305 already
demonstrates the technique. Halving the limb width from 25.5 to 16 bits costs
19 bits of product width and buys back only 1.7 bits of column count
(`571` vs `172` accumulated terms) — a **net gain of ~17 bits of headroom**. The
margin problem is not a fixed property of Curve25519; it is a function of a
freely-chosen parameter, and §6.4 chose it badly.

**Consequences.** SFN-335 loses its dependency on `draft-sized-integer-types`
and on a widening-multiply intrinsic. It unblocks SFN-337 → SFN-340 → SFN-341,
the last of which clears the SFEP-0016 capability-seal blocker. Per
`.claude/rules/seed-dependency.md` there is **no seed-cut gate**: X25519 lands in
a `kind = "library"` capsule the compiler's own build does not depend on
(SFEP-0048 §5), so it needs no new compiler binary behaviour and no `/pin-seed`.

## 2. What §6.4 actually rejected, restated precisely

| Width | Limbs | Reduction constant | Max column terms | Worst intermediate (carried operands) | Headroom < 2^62 |
|---|---|---|---|---|---|
| 51 bits | 5 | 19 | 5 | `2^102` (single product) | **impossible** |
| 32 bits | 8 | 38 | 8 | `267 · 2^64 = 2^72.06` | **impossible** |
| 25.5 bits | 10 | 19 | 10 | `172 · 2^52 = 2^59.43` | 2.6 bits |
| **17 bits** | **15** | **19** | **15** | `267 · 2^34 = 2^42.06` | 20.0 bits |
| **16 bits** | **16** | **38** | **16** | `571 · 2^32 = 2^41.16` | **20.8 bits** |
| **15 bits** | **17** | **19** | **17** | `305 · 2^30 = 2^38.25` | 23.8 bits |

The "max column terms" coefficient is derived in §3.2. Two structural facts fix
the shape of this table:

1. **Only widths where `n·w ∈ {255, 256}` keep the reduction multiplier small**
   (19 or 38). A width like 22 bits forces `n·w = 264`, i.e. `2^264 ≡ 2^9 · 19 =
   9728`, and the multiplier alone eats 13 bits. Off-alignment is a trap; the
   viable widths are `w ∈ {15, 16, 17}` (plus the impossible 25.5/32/51).
2. **The 25.5-bit row is worse than §6.4's "~2^58" suggests.** `2^59.43` is the
   bound for *fully carried* operands. In the Montgomery ladder, multiply
   operands are the outputs of add/subtract, which run to ~`2^27` under any
   bias scheme — pushing the bound to `172 · 2^54 = 2^61.43`, **0.6 bits below
   2^62**. §6.4's rejection of 25.5-bit was correct, and if anything
   under-stated. It just did not follow through to the next width.

**16 bits wins over 15 and 17** on grounds other than headroom (all three are
comfortable): it is byte-aligned, so pack/unpack is `t[i] & 255` and
`t[i] >> 8` with no cross-limb bit shuffling — the exact class of code that
produced the interleaving bugs `_extract_limbs` in `poly1305.sfn:15-23` had to
be carefully tuned for. And it is the TweetNaCl representation, so the
reference implementation is a line-for-line transcription target rather than a
re-derivation. Correctness-by-transcription is worth more here than 3 bits of
headroom.

## 3. Margin analysis (the safety argument)

Notation: `p = 2^255 − 19`. A field element is `h = Σ_{i=0}^{15} h_i · 2^(16i)`
with `h_i` a plain `int` (LLVM `i64`, per SFEP-0048 §3.3 item 1). All limbs are
**non-negative at every point in the field layer**; §3.6 discharges the two
exceptions in the serializer.

Two declared forms, which every function's contract is stated in terms of:

- **C-form (carried):** every limb ∈ `[0, 2^16)`.
- **L-form (loose):** every limb ∈ `[0, 2^19)`.

### 3.1 The subtraction bias (why nothing goes negative)

Subtraction is the only field operation that can produce a negative limb. It is
made unconditionally non-negative by adding a limbwise representation of `4p`,
which is `≡ 0 mod p`:

```
p in 16-bit limbs:   p_0 = 65517,  p_1..p_14 = 65535,  p_15 = 32767
                     (2^255 − 1 is [65535 ×15, 32767]; subtract 18 from limb 0)
4p limbwise:         B_0 = 262068, B_1..B_14 = 262140, B_15 = 131068
```

Limbwise doubling is exact without carrying, so `Σ B_i · 2^(16i) = 4p` holds by
construction. `min(B_i) = 131068`.

`_fsub(a, b)` with `a, b` in C-form computes `o_i = a_i + B_i − b_i`:

- **Lower bound:** `o_i ≥ 0 + 131068 − 65535 = 65533 > 0`. **Provably positive,
  for every limb, unconditionally** — no sign test, no branch.
- **Upper bound:** `o_i ≤ 65535 + 262140 = 327675 < 2^18.32`.

`2p` does *not* work here and the near-miss is instructive: `2p` limbwise gives
`B_15 = 65534 < 65535`, one short of the maximum subtrahend limb. `4p` is the
smallest multiple that clears it. (Any bias vector with all entries ≥ 2^16 must
sum to more than `2^16 · (2^256−1)/(2^16−1) > 2^256 > 2p`, so this is not a
matter of a cleverer `2p` encoding — `4p` is forced.)

`_fadd(a, b)` with `a, b` in C-form: `o_i = a_i + b_i ≤ 131070 < 2^17.001`.

So **every value the ladder ever hands to a multiply is in L-form**, with the
true worst case `327675 < 2^18.32` (an `_fsub` output) and the declared
precondition `< 2^19` giving slack for review error.

### 3.2 Schoolbook field multiply

`_fmul(a, b)` accumulates `t[k] += a_i · b_j` for `i + j = k`, `k = 0..30`, then
folds the high half with `2^256 ≡ 38`:

```
r[i]  = t[i] + 38 · t[i+16]     for i = 0..14
r[15] = t[15]
```

Term counts: `t[k]` has `k+1` products for `k ≤ 15` and `31−k` for `k ≥ 16`. So
the accumulated-term coefficient for output limb `i` is

```
coef(i) = (i+1) + 38 · (31 − (i+16)) = (i+1) + 38 · (15 − i)
coef(0) = 1 + 570 = 571   ← maximum
coef(15) = 16
```

`max coef = 571 = 2^9.157`.

**Bound with the declared L-form precondition (`limbs < 2^19`):**

```
single product        a_i · b_j  <  2^19 · 2^19 = 2^38
t[k]                             <  16 · 2^38   = 2^42
38 · t[i+16]                     <  38 · 15 · 2^38 = 570 · 2^38 = 2^47.155
r[0] = t[0] + 38·t[16]           <  571 · 2^38   = 2^47.157
```

`2^62 / 2^47.157 = 2^14.84`. **Headroom: 14.8 bits below 2^62, 15.8 below 2^63.**

**Bound with the true worst operand (`327675`, an `_fsub` output):**

```
327675^2                = 107,370,905,625  = 2^36.644
571 · 327675^2          =  61,308,787,111,875 ≈ 6.131e13 = 2^45.80
2^62 = 4.6117e18  →  4.6117e18 / 6.131e13 = 75,222 = 2^16.20
```

**Headroom: 16.2 bits below 2^62.** The worst intermediate in the whole
algorithm is ~75,000× smaller than 2^62.

Partial sums are monotonically increasing (all terms non-negative), so no
intermediate of the accumulation exceeds the final column value — the bound
holds at every step of the inner loop, not just at its end.

When both operands are C-form (which is the case for the entire inversion, §3.5,
and for several ladder multiplies), the bound tightens to `571 · 2^32 = 2^41.16`
— **20.8 bits of headroom**.

### 3.3 Squaring

`_fsqr(a)` is specified as `_fmul(a, a)`. It inherits §3.2's bound exactly. A
specialized squaring (doubling the off-diagonal terms to halve the multiply
count) would keep the same coefficient sum and therefore the same bound, but is
**not** specified: the ~2× win does not justify the extra hand-derived index
arithmetic in a security primitive. If it is ever added, the bound is unchanged
by construction.

### 3.4 Carry propagation

One `_carry` pass over `o[0..15]`:

```
c = o[i] >> 16;  o[i] = o[i] & 65535;
o[i+1] += c                     (i < 15)
o[0]   += 38 * c                (i == 15)
```

Every `o[i]` entering the pass is non-negative (§3.2: all terms of `r` are
products and 38× products of non-negative limbs), so `>> 16` is a shift of a
non-negative value — `ashr` is `lshr`, and `c ≥ 0`. Non-negativity is preserved
by induction across the pass, so **every shift in the carry chain is on a
provably non-negative operand**.

Magnitudes, starting from the L-form bound `2^47.157`:

```
pass 1: c ≤ 2^47.157 / 2^16 = 2^31.157
        o[i+1] + c ≤ 2^47.157 + 2^31.157 < 2^47.16     (still 14.8 bits under 2^62)
        c15 ≤ 2^31.16;  o[0] += 38·c15 ≤ 65535 + 2^36.41 < 2^36.42
        ⟹ limbs 1..15 ∈ [0, 2^16);  limb 0 ≤ 2^36.42
pass 2: c0 ≤ 2^20.42; o[1] ≤ 2^16 + 2^20.42 < 2^20.5; c1 ≤ 23;
        o[2] ≤ 65558; c2 ≤ 1; the remaining ripple carries ≤ 1
        c15 ≤ 1  ⟹  o[0] ≤ 65535 + 38 = 65573
        ⟹ limbs 1..15 ∈ [0, 2^16);  limb 0 ≤ 65573  (marginally ≥ 2^16)
pass 3: the represented value is now < 2^256 (65573 + 2^256 − 2^16 < 2^256),
        so the pass produces c15 = 0 and no wrap into limb 0
        ⟹ every limb ∈ [0, 2^16)   ← C-form, strictly
```

**Three carry passes provably yield C-form.** TweetNaCl runs two and lives with
`limb0 ≤ 2^16 + 37`; the third pass is one extra 16-step loop and it is what lets
`_fsub`'s bias argument (§3.1) assume a hard `< 2^16` bound on its subtrahend
rather than a soft one. Take the third pass. It is the cheapest safety margin in
the design.

### 3.5 Ladder operand audit

Transcribing TweetNaCl's `crypto_scalarmult` inner loop and tagging each operand
with its form:

| Step | Operands | Result form |
|---|---|---|
| `_cswap(a,b,r)`, `_cswap(c,d,r)` | C, C | C (XOR of C-form limbs is < 2^16) |
| `e = _fadd(a,c)` | C, C | L (< 2^17.001) |
| `a = _fsub(a,c)` | C, C | L (< 2^18.32) |
| `c = _fadd(b,d)` | C, C | L |
| `b = _fsub(b,d)` | C, C | L |
| `d = _fsqr(e)` | L | C |
| `f = _fsqr(a)` | L (worst case: `_fsub` × `_fsub` → **2^45.80**) | C |
| `a = _fmul(c,a)` | L, L | C |
| `c = _fmul(b,e)` | L, L | C |
| `e = _fadd(a,c)` | C, C | L |
| `a = _fsub(a,c)` | C, C | L |
| `b = _fsqr(a)` | L | C |
| `c = _fsub(d,f)` | C, C | L |
| `a = _fmul(c, GF_121665)` | L, C | C |
| `a = _fadd(a,d)` | C, C | L |
| `c = _fmul(c,a)` | L, L | C |
| `a = _fmul(d,f)` | C, C | C |
| `d = _fmul(b,x)` | C, C | C |
| `b = _fsqr(e)` | L | C |
| `_cswap(a,b,r)`, `_cswap(c,d,r)` | C, C | C |

**Every `_fsub` and `_fadd` receives C-form operands** (they are always applied
to `_cswap`/`_fmul`/`_fsqr` outputs), and **every `_fmul`/`_fsqr` operand is
L-form**. The contract in §3.1/§3.2 is satisfied at every call site; the single
worst intermediate in the entire loop is `_fsqr` of an `_fsub` output, at
`2^45.80`. `GF_121665` is the constant `121665` as limbs `[56129, 1, 0 ×14]`.

### 3.6 Inversion — no new hazard

`_finv(z)` computes `z^(p−2) = z^(2^255 − 21)` as a fixed addition chain
(TweetNaCl `inv25519`): 254 iterations of `_fsqr`, with `_fmul(·, z)` on every
iteration except `a == 2` and `a == 4`. That is 254 squarings and 252 multiplies.

- **The exponent `p − 2` is a public constant.** The `a != 2 && a != 4` test is
  on the *loop counter*, not on data. No secret-dependent control flow.
- **Both operands are always C-form** (each `_fsqr`/`_fmul` returns C-form, and
  `z` is C-form), so the bound here is the tight `571 · 2^32 = 2^41.16` —
  20.8 bits of headroom, strictly better than the ladder.
- The iteration count is fixed at 254 regardless of input, so the timing is
  input-independent.

**No new hazard. No new capability.**

### 3.7 The `ashr` question, exhaustively

Every `>>` in the design, with its operand's provable range:

| Site | Operand range | Verdict |
|---|---|---|
| `_carry`: `o[i] >> 16` | `[0, 2^47.16]` | non-negative — `ashr` ≡ `lshr` |
| `_unpack25519`: bytes | `[0, 255]` | non-negative |
| `_pack25519` serialize: `t[i] >> 8` | `[0, 2^16)` (C-form) | non-negative |
| scalar bit: `k[i >> 3] >> (i & 7)` | `[0, 255]`, shift 0..7 | non-negative |
| `_pack25519` borrow: `(m[i] >> 16) & 1` | **`[−2^16, 2^16]`** | see below |

The last row is the only sign-bearing shift, and it is confined to
`_pack25519`'s final conditional subtraction of `p`:

```
m[0]  = t[0]  − 65517                            ∈ [−65517, 18]
m[i]  = t[i]  − 65535 − ((m[i−1] >> 16) & 1)     ∈ [−65536, 65535]   (i = 1..14)
m[15] = t[15] − 32767 − ((m[14] >> 16) & 1)      ∈ [−32768, 32768]
```

For any `x ∈ [−2^16, 2^16)`, `x >> 16` is `−1` when `x < 0` and `0` when
`x ≥ 0`, so `(x >> 16) & 1` is exactly the borrow bit. This is correct under
`ashr` (`−1 >> 16 = −1`, `& 1 = 1`) **and** under a hypothetical `lshr`
(`−1 lshr 16 = 0x0000FFFFFFFFFFFF`, `& 1 = 1`) — the `& 1` makes it
shift-signedness-agnostic. This is byte-for-byte the argument
`poly1305.sfn:177-185` already carries for `(g4 >> 63) & 1`, shipped and
regression-covered by `capsules/sfn/crypto/tests/poly1305_test.sfn`.

Note also that `m[i] & 65535` on a negative `m[i]` yields the correct wrapped
low limb (`−65517 & 65535 = 19`) and is always non-negative, because `&` with a
non-negative mask cannot produce a negative result regardless of the operand's
sign.

**There is no place in X25519 that needs a logical shift on a possibly-negative
value.** The `lshr` gap in `core_helpers.sfn:60-70` is not on this critical path.

Corroborating detail: the emitter attaches no `nsw`/`nuw` flags (no occurrence
anywhere under `compiler/src/llvm/`; `operation_name_for_symbol` returns bare
`mul`/`add`/`shl`), so even a hypothetical bound violation would be defined
two's-complement wrap, not undefined behaviour. The design does not rely on
this — the bounds above are proven — but it means the failure mode of a
transcription error is a wrong answer caught by a test vector, not miscompiled
code.

## 4. Constant-time `cswap` — the SFN-331 construction generalizes

TweetNaCl's `sel25519` uses `c = ~(b−1)`. Sailfin needs no `~`: for `b ∈ {0,1}`,
`0 − b` produces `0` and `−1` (all-ones) respectively — identical, and it is
**the exact idiom SFN-331 shipped** in `poly1305.sfn:183-190`
(`mask_h = 0 - borrow; mask_g = borrow - 1`).

```
_cswap(p, q, b):        // b ∈ {0,1}, secret
    c = 0 - b           // 0 or -1 (all ones)
    for i in 0..15:
        t = c & (p[i] ^ q[i])
        p[i] = p[i] ^ t
        q[i] = q[i] ^ t
```

Safety under the current model:

- `c` is `−1`, a negative value — but it is **only ever an operand of `&`**,
  never of a shift. Bitwise AND with all-ones on `i64` is exact identity; the
  sign is irrelevant.
- `p[i] ^ q[i]` is the XOR of two values in `[0, 2^16)`, hence in `[0, 2^16)` —
  non-negative, C-form preserved.
- Both arrays are written on every iteration regardless of `b`, so there is no
  data-dependent memory-write pattern.
- The loop bound is the fixed constant 16.

**Confirmation that the ladder needs no secret-dependent branch or index.** The
scalar bit is `r = (k[i >> 3] >> (i & 7)) & 1` where `i` is the *public* loop
counter `254..0`. The index `i >> 3` and the shift amount `i & 7` are both
functions of `i` alone; only the resulting *value* `r` is secret, and `r` reaches
control flow only through `0 - r` inside `_cswap`. The ladder body executes the
identical straight-line sequence of 10 field multiplications and 8 add/subs on
every one of the 255 iterations. `_finv`'s branch is on its public loop counter
(§3.6). `_pack25519`'s conditional subtraction is secret-dependent but is
resolved by the same masked select. **There is no secret-dependent branch and no
secret-dependent array index anywhere in the implementation.**

The one deliberate secret-dependent early return is the input length check
(`scalar.length != 32`), which is public metadata — the same fail-closed
length-check convention `poly1305_mac` and `bits.ct_eq_bytes` already use.

## 5. Implementation spec

One new module, `capsules/sfn/crypto/src/x25519.sfn`, plus two test files. No
changes to `compiler/src/`, `runtime/`, or `bits.sfn`.

### 5.1 Representation and constants

```
16 limbs × 16 bits, little-endian:  h = Σ h_i · 2^(16i),  i = 0..15
limb mask:            65535          (2^16 − 1)
reduction multiplier: 38             (2^256 ≡ 38 mod 2^255 − 19)
4p bias vector:       [262068, 262140 ×14, 131068]
GF_121665:            [56129, 1, 0 ×14]         (121665 = 1·65536 + 56129)
basepoint u = 9:      [9, 0 ×15]
```

All constants decimal (SFEP-0048 §3.3 item 7 — no hex literals in Sailfin
source).

### 5.2 Function list

Field layer (all module-private, `_`-prefixed per `.claude/rules/code-style.md`):

| Function | Signature | Contract |
|---|---|---|
| `_gf_zero` / `_gf_one` | `() -> int[]` | 16-limb constants |
| `_gf_copy` | `(a: int[]) -> int[]` | value copy |
| `_four_p` | `() -> int[]` | the §5.1 bias vector |
| `_fadd` | `(o: int[], a: int[], b: int[]) -> void` | C × C → L; `o` may alias `a` or `b` |
| `_fsub` | `(o: int[], a: int[], b: int[]) -> void` | C × C → L; adds `_four_p()` |
| `_carry` | `(o: int[]) -> void` | one pass, ×38 top wrap |
| `_fmul` | `(o: int[], a: int[], b: int[]) -> void` | L × L → C; 3 `_carry` passes |
| `_fsqr` | `(o: int[], a: int[]) -> void` | `_fmul(o, a, a)` |
| `_cswap` | `(p: int[], q: int[], b: int) -> void` | masked, in place |
| `_finv` | `(o: int[], z: int[]) -> void` | `z^(p−2)`, 254-step chain |
| `_unpack25519` | `(n: int[]) -> int[]` | 32 bytes → C-form; clears bit 255 |
| `_pack25519` | `(n: int[]) -> int[]` | C-form → 32 bytes, fully reduced |

Public surface, re-exported from `capsules/sfn/crypto/src/mod.sfn`:

| Function | Signature | Behaviour |
|---|---|---|
| `x25519` | `(scalar: int[], u: int[]) -> int[]` | RFC 7748 §5; `[]` if either input is not 32 bytes |
| `x25519_base` | `(scalar: int[]) -> int[]` | `x25519(scalar, [9, 0 ×31])` — the key-generation path SFN-337 needs |
| `x25519_is_zero` | `(shared: int[]) -> bool` | constant-time all-zero check; RFC 8446 §7.4.2 requires the handshake to abort on an all-zero shared secret |

**Use the in-place, output-parameter shape, not a value-returning one.** Sailfin
arrays are reference-semantics (`chacha20.sfn:19` mutates its `s: int[]`
parameter in place), so `_fmul(o, a, b)` transcribes TweetNaCl's `M(o,a,b)`
line-for-line. This is both a correctness win (review against the reference is
mechanical) and an allocation win (~28,000 array allocations per scalar
multiplication otherwise).

**Aliasing is safe but load-bearing.** The ladder calls `_fmul(a, c, a)` and
`_fsqr(c, c)` — output aliases an input. This is correct **only** because
`_fmul` accumulates into a module-local `t[0..30]` and writes `o` at the very
end. Do not "optimize" by accumulating directly into `o`; the comment in the
implementation must state this. `_fadd`/`_fsub`/`_cswap` are componentwise and
alias-safe unconditionally.

### 5.3 Algorithm

`x25519(scalar, u)`:

1. Length-check both inputs (32 bytes each); return `[]` otherwise.
2. Clamp the scalar per RFC 7748 §5 on a **copy**: `k[0] &= 248`, `k[31] &= 127`,
   `k[31] |= 64`. Never mutate the caller's array.
3. `x = _unpack25519(u)` (clears bit 255 — required of receivers by RFC 7748 §5).
4. Montgomery ladder, `i = 254` down to `0`, exactly as in §3.5's table, with
   `_cswap` at both ends of each iteration.
5. `_finv(z, c)`; `_fmul(a, a, z)`; `return _pack25519(a)`.

`_pack25519` runs `_carry` three times, then **two** rounds of the conditional
`− p` borrow chain of §3.7 with a `_cswap`-based select, then serializes
`o[2i] = t[i] & 255`, `o[2i+1] = t[i] >> 8`. Two rounds are required (a single
round leaves inputs in `[p, 2p)` unreduced); after two, `t < p < 2^255` so
`t[15] ≤ 32767` and the serialization is exact.

### 5.4 Tests

`capsules/sfn/crypto/tests/x25519_test.sfn`, using the established `hexb`/
`_hexval`/`eq_bytes` helper trio copied from
`capsules/sfn/crypto/tests/poly1305_test.sfn:8-40` (hex literals are unavailable
in source, so vectors are decoded from hex *strings*). Pure functions — bare
`assert`, no `![io]`, no `sfn/test` matchers.

Vectors, **transcribed from RFC 7748 by the implementer** (reproduced here for
scoping, not as the authority):

*§5.2, single scalar multiplication:*

```
scalar a546e36bf0527c9d3b16154b82465edd62144c0ac1fc5a18506a2244ba449ac4
u      e6db6867583030db3594c1a424b15f7c726624ec26b3353b10a903a6d0ab1c4c
→      c3da55379de9c6908e94ea4df28d084f32eccf03491c71f754b4075577a28552

scalar 4b66e9d4d1b4673c5ad22691957d6af5c11b6421e0ea01d42ca4169e7918ba0d
u      e5210f12786811d3f4b7959d0538ae2c31dbe7106fc03c3efc4cd549c715a493
→      95cbde9476e8907d7aade45cb4b873f88b595a68799fa152e6f8f7647aac7957
```

*§5.2, iterated (`k = u = 09||0^31`; then `k, u = X25519(k, u), k`):*

```
after 1 iteration      422c8e7a6227d7bca1350b3e2bb7279f7897b87bb6854b783c60e80311ae3079
after 1,000 iterations 684cf59ba83309552800ef566f2f4d3c1c3887c49360e3875f2eb94d99532c51
```

The 1,000,000-iteration vector is **explicitly out of scope** (RFC 7748 marks it
optional and it is slow even in C).

*§6.1, the ECDH round trip — the vector that actually matches SFN-337's usage:*

```
Alice priv 77076d0a7318a57d3c16c17251b26645df4c2f87ebc0992ab177fba51db92c2a
Alice pub  8520f0098930a754748b7ddcb43ef75a0dbf3a0d26381af4eba4a98eaa9b4e6a
Bob   priv 5dab087e624a8a4b79e17f8b83800ee66f3bb1292618b6fd1c2f8b27ff88e0eb
Bob   pub  de9edb7d7b7dc1b4d35b61c2ece435373f8343c85b78674dadfc7e146f882b4f
shared     4a5d9d5ba4ce2de1728e3bf480350f25e07e21c947d19e3376f09b3c1e161742
```

Covering `x25519_base` for both public keys and `x25519` for both directions of
the shared secret.

Plus fail-closed cases: wrong-length scalar → `[]`, wrong-length `u` → `[]`, and
`x25519_is_zero` on the all-zero low-order-point result.

**Put the 1,000-iteration vector in its own file**,
`capsules/sfn/crypto/tests/x25519_iterated_test.sfn`. Rationale in §7 (Risks) —
it is 1,000 scalar multiplications and its wall time is the one number this note
cannot predict from first principles. Separating it means a slow iterated vector
never blocks the fast vectors from running in the inner loop, and it can be
gated independently if it turns out to be minutes rather than seconds.

### 5.5 Verification

```
build/bin/sfn fmt --write  capsules/sfn/crypto/src/x25519.sfn
build/bin/sfn fmt --check  capsules/sfn/crypto/src/x25519.sfn capsules/sfn/crypto/tests/x25519_test.sfn capsules/sfn/crypto/tests/x25519_iterated_test.sfn
build/bin/sfn check        capsules/sfn/crypto/src/x25519.sfn
build/bin/sfn test         capsules/sfn/crypto/tests/x25519_test.sfn
build/bin/sfn test         capsules/sfn/crypto/tests/x25519_iterated_test.sfn
```

`make compile` is **not** a gate: no `compiler/src/*.sfn` file is touched
(validation-ladder rung 2 applies to compiler sources). A `make check` before
merge is cheap insurance that the new capsule module did not disturb the capsule
resolver's dependency closure, but it is not the correctness gate.

## 6. Scope and decomposition

**One issue, one PR — do not split.** SFN-335 stays as filed (estimate 3). The
field layer and the ladder are not independently shippable: the field layer has
exactly one consumer, and there is no meaningful acceptance criterion for it
other than "the RFC 7748 vectors reproduce," which requires the ladder. Splitting
would manufacture two PRs, two review cycles, and a half-tested intermediate
state, for no benefit. Per `.claude/rules/seed-dependency.md`, bundle.

**No seed-cut gate.** `capsules/sfn/crypto/` is `kind = "library"`; the
compiler's own build does not resolve it (SFEP-0048 §5). X25519 introduces no
new compiler binary behaviour, so `make compile` is unaffected and no
`/pin-seed` is required. The seed-coupled step in this chain remains where
SFEP-0048 §3.2 put it — the Phase D vendoring of capsule primitives into
`runtime/`, tracked by SFN-341, which already bundles the body swap and the
extern deletion into one PR.

**Downstream unblocking.** SFN-335 moves `Blocked → Ready` with its "Depends on
upstream: `draft-sized-integer-types`" paragraph deleted. SFN-337, SFN-340, and
SFN-341 lose the same transitive dependency, and SFN-341's "Bump the
`[toolchain]` pin once the seed carries the needed capability" line becomes moot.
SFEP-0048 §6.4 and §7 need an amendment recording that the X25519 blocker is
withdrawn, with a pointer to this note.

## 7. Risks

**Transcription error, not arithmetic error.** The margin argument is proven with
17 bits to spare; the realistic failure mode is a mis-indexed limb or a dropped
carry. Mitigation: transcribe from TweetNaCl's `crypto_scalarmult` structurally
(same function decomposition, same in-place signatures), and rely on the RFC
vectors — Curve25519 is unforgiving, and any single-bit error fails vector 1.

**Performance is the real unknown.** One scalar multiplication is ~2,550
multiply-class field operations (255 ladder steps × 10) plus ~506 for the
inversion, each ~700 primitive integer ops — roughly **2.1M integer operations
and ~28,000 array allocations** if the in-place shape of §5.2 is *not* used. This
is inherent to a 16-limb representation: it is ~10× the multiply count of a
10-limb implementation and ~25× that of a 5-limb one. For a TLS handshake (one
or two scalar multiplications) that is a non-issue. For the 1,000-iteration RFC
vector it is 1,000 scalar multiplications, which is why §5.4 isolates it in its
own file. **The implementer should measure the single-vector time first**, then
decide whether the iterated file runs in CI as-is. If it is intolerable, reduce
the iterated test to a smaller published-checkpoint count rather than dropping
the coverage or weakening the primitive.

**A later widening multiply is an optimization, not a correctness fix.** If
`draft-sized-integer-types` or a `64×64 → 128` intrinsic ever lands, the same
module can be re-parameterized to 51-bit limbs for a ~25× speedup. That is a
performance follow-on with its own issue, and it does **not** belong in
SFN-335's scope. This note deliberately removes X25519 from the justification
stack for that language work — which materially narrows what sized integers must
deliver to be worth doing.

**`sfn fmt` on wide expression tables.** The `_fmul` schoolbook and the 4p bias
vector are wide literal-heavy code; `bits.sfn:44-48` shows `fmt` breaking long
index expressions in ways that read oddly. Per `.claude/rules/formatting.md`, run
`--write` then `--check` and accept the output.

## 8. Future considerations

**Ed25519-verify becomes mechanically reachable.** SFEP-0048 §7 blocks the pure
Ed25519 port on "the same Curve25519 field arithmetic X25519 needs." That field
layer is exactly §5.2's `_fadd`/`_fsub`/`_fmul`/`_fsqr`/`_finv`/`_pack`/`_unpack`.
What remains is the twisted-Edwards group law, a `pow(z, (p−5)/8)` square root,
and SHA-512 — and `sha384.sfn:1-68` already carries the full 64-bit limb-pair
machinery SHA-512 needs (same compression function, different IV, untruncated
output). This is a real follow-on issue, not a claim of this note's verdict; it
should be groomed separately once X25519 is green, and it is the remaining item
between SFN-341 and a genuinely OpenSSL-free `-lcrypto`-free link line.

**The generalizable lesson for SFEP-0048.** §3.3's mandate is "narrow limbs whose
pairwise products stay inside i64," but §6.4 evaluated only the widths a C
implementation would pick — widths chosen to exploit a 64×64→128 multiply Sailfin
does not have. The correct search is over widths that keep `n·w ∈ {255, 256}`
(so the reduction constant stays 19 or 38) and then take the *narrowest*
tolerable one, because product width costs 2 bits per limb-bit while column
count costs only `log2(n)`. Any future big-integer primitive under this integer
model — P-256, RSA, X448 — should run that search before being declared blocked.

## 9. References

- SFN-335 (this note's issue); SFN-337 / SFN-340 / SFN-341 (the blocked chain);
  SFN-331 (the branch-free masked select this note generalizes).
- SFEP-0048 `docs/proposals/0048-native-crypto.md` §3.3 (integer idiom, lines
  140-186), §6.4 (the rejection this note overturns, lines 304-317), §7
  (blocker record, lines 328-339), §5 (no-seed-cut rationale).
- SFEP-0016 (`0016-capability-sealed-runtime.md`) — the seal SFN-341 clears.
- Shipped precedent: `capsules/sfn/crypto/src/poly1305.sfn` (5×26-bit limbs,
  `_limb_mask()` line 11; branch-free masked select lines 177-190),
  `capsules/sfn/crypto/src/sha384.sfn:28-68` (64-bit words as masked 32-bit limb
  pairs), `capsules/sfn/crypto/src/bits.sfn` (`ct_eq_bytes`, mask/rotate
  helpers), `capsules/sfn/crypto/src/chacha20.sfn:19-29` (in-place `int[]`
  parameter mutation).
- Integer-model ground truth: `compiler/src/llvm/expression_lowering/native/
  core_helpers.sfn:60-70` (`>>` → `ashr`, no `lshr` form); no `nsw`/`nuw` flags
  anywhere under `compiler/src/llvm/`.
- `docs/proposals/draft-sized-integer-types.md` — the language work this note
  removes X25519 from the justification for.
- RFC 7748 §5 (X25519 function), §5.2 (test vectors), §6.1 (ECDH vectors);
  RFC 8446 §7.4.2 (all-zero shared-secret abort).
- Reference implementation shape: TweetNaCl `crypto_scalarmult`, `car25519`,
  `sel25519`, `pack25519`, `unpack25519`, `inv25519`.
