# SFN-653 — P-256 and RSA verification under the current integer model

> Single-issue design gate (no SFEP number). Design context: SFEP-0048
> (`docs/proposals/0048-native-crypto.md`, Accepted), Phase C. This note applies
> the width search from
> `docs/proposals/design-notes/sfn-335-x25519-limb-strategy.md` to ECDSA-P256
> and public-key RSA verification. It changes no language surface, adds no
> compiler capability, and has no seed dependency.

## 1. Verdicts

### ECDSA-P256: **VIABLE**

Use **10 little-endian limbs of 26 bits in Montgomery form for both moduli**:

- field prime
  `p = 2^256 - 2^224 + 2^192 + 2^96 - 1`;
- subgroup order
  `n = FFFFFFFF00000000FFFFFFFFFFFFFFFFBCE6FAADA7179E84F3B9CAC2FC632551`.

The Solinas search still succeeds: a 16x16 schoolbook product has a worst
folded output of `73 * (2^16 - 1)^2 < 2^38.19`, leaving **23.8 bits below
2^62**, and its signed carry chain peaks below `2^22.21`. It is not selected.
A 10x26 CIOS Montgomery multiply needs fewer pair products (210 including the
reduction-digit products, versus 256 before Solinas folding), uses one
normalization proof for `p`, `n`, and RSA, and never creates a signed residual
carry. Its inner step is below `2^52 + 2^28`, leaving essentially **10 bits
below 2^62**. Neither modulus needs sized integers, unsigned semantics, logical
right shift, or a widening multiply.

### RSA verify: **VIABLE**

Use a variable-length **26-bit-limb** bignum and coarsely integrated operand
scanning (CIOS) Montgomery multiplication for 2048-, 3072-, and 4096-bit odd
moduli. Do not accumulate an entire schoolbook column at this width: its
4096-bit bound is `158 * 2^52 = 2^59.30`, only 2.7 bits below `2^62`. CIOS masks
each inner result before the next limb, so its worst inner value is below
`2^52 + 2^28`, independent of modulus length, with 10 bits of headroom.

For the usual public exponent `e = 65537`, conversion in, 16 squarings, one
multiply, and conversion out cost 19 Montgomery multiplications: about 239,000
limb products at 2048 bits, 540,000 at 3072 bits, and 952,000 at 4096 bits.
That is suitable for a single verification KAT under the `-O0` CI build, but
not for a benchmark loop.

Both implementations live in `capsules/sfn/crypto/` and consume only language
features the pinned seed already supports. **There is no compiler capability
predecessor and no seed cut.**

## 2. Security-property audit: there are no secrets

**Neither verification path contains secret-dependent control flow or a
secret-dependent array index, because neither path receives a secret.**

ECDSA verification receives a message digest, a public key, and public
signature integers `r` and `s`. The derived scalars `w = s^-1 mod n`,
`u1 = e*w mod n`, and `u2 = r*w mod n` are public. A branch on a bit of `u1` or
`u2`, a point-at-infinity case, a public-key validation result, or a DER length
therefore reveals no private key or signing nonce. Point-table indexes may be
derived from public scalar bits. The verify-only implementation must not be
reused for signing: signing introduces the secret private scalar and nonce and
would require a separate constant-time design.

RSA verification receives a public modulus, public exponent, public signature,
and public message digest. Square-and-multiply may branch on exponent bits;
normalization may branch on comparisons with the modulus; and CIOS loops may
use the public modulus length. None is secret-dependent. A constant-time
modexp would add complexity without protecting any secret and is explicitly
out of scope.

This relaxation does not excuse unsafe indexing. Every index is still bounded
by a checked input length or a loop bound, and malformed inputs fail closed.
It only removes the cryptographic requirement for branch-free selection and
fixed execution time.

## 3. Arithmetic conventions

Sailfin `int` lowers to signed LLVM `i64`. The safety target follows the SFN-500
precedent: keep every proved intermediate below `2^62`, retaining one sign bit
and one review-error bit. A limb array is little-endian:

```
x = sum(x[i] * B^i), B = 2^w, 0 <= x[i] < B
```

All selected multiplication routines use non-negative canonical inputs. Signed
values appear only in section 4's rejected-candidate Solinas audit, where
arithmetic right shift is the desired floor division by `2^16`; no selected
routine requires a logical right shift of a negative value.

Squaring uses the multiplication routine with identical operands. A future
specialized square may double off-diagonal products, but its total coefficient
sum and therefore every bound below are unchanged.

## 4. P-256 field modulus

Let `B = 2^16 = 65536`. Then

```
B^16 = 2^256 = B^14 - B^12 - B^6 + 1 (mod p).
```

This is a genuine Solinas reduction, not the positive `x38` fold used by
X25519. The negative terms are safe here because verification is public-data
code and because their magnitude is bounded before signed carry propagation.

### 4.1 Width search

Widths 32, 16, and 8 align every exponent in the prime (`256`, `224`, `192`,
and `96`) to a limb boundary. Off-alignment adds cross-limb shifts and larger
coefficients without improving the product-width bound, so it is not a useful
candidate.

For each aligned width, reduce every raw product column symbolically using

```
B^N = B^(224/w) - B^(192/w) - B^(96/w) + 1,
N = 256/w.
```

If `L` is the largest absolute coefficient sum reaching any output limb, then
the reduced-output bound is `L * (B - 1)^2`.

| Width `w` | Limbs `N` | Raw-column bound | Max folded coefficient `L` | Folded bound | Headroom below `2^62` | Verdict |
|---|---:|---:|---:|---:|---:|---|
| 32 | 8 | `8 * 2^64 = 2^67` | 33 | `33 * 2^64 = 2^69.04` | none | impossible |
| **16** | **16** | `16 * 2^32 = 2^36` | **73** | `73 * 2^32 = 2^38.19` | **23.8 bits** | safe Solinas candidate |
| 8 | 32 | `32 * 2^16 = 2^21` | 153 | `153 * 2^16 = 2^23.26` | 38.7 bits | safe but 4x as many pair products as 16-bit |

The 16-bit reduction's per-output absolute coefficient sums are shown rather
than hidden behind the maximum:

| Output limb | 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 10 | 11 | 12 | 13 | 14 | 15 |
|---|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|
| Sum | 53 | 48 | 43 | 38 | 34 | 30 | **73** | 66 | 60 | 54 | 48 | 42 | 57 | 50 | 65 | 58 |

For example, raw column `t[k]` contains
`min(k + 1, 31 - k)` products. Processing high powers from `k = 30` down to
`16` replaces each coefficient `c * B^k` with

```
+c * B^(k - 2) - c * B^(k - 4) - c * B^(k - 10) + c * B^(k - 16).
```

For output limb 6 the surviving weighted terms have absolute total

```
7 + 15 + 13 + 2*9 + 2*7 + 5 + 1 = 73,
```

which is the table maximum. Every partial raw-column sum is non-negative and no
larger than `16 * (B - 1)^2 < 2^36`; every signed folded sum is bounded in
absolute value by `73 * (B - 1)^2 < 2^38.19`.

### 4.2 Signed-carry audit and why Solinas is not selected

Normalize low to high with

```
c = x >> 16
x = x & 65535
next += c
```

Arithmetic right shift is correct for both signs: it computes floor division,
and `x & 65535` is the matching non-negative remainder. If the incoming folded
limbs obey `abs(x) < 73*B^2`, the carry recurrence is

```
abs(c_i) <= floor((73*B^2 + abs(c_(i-1))) / B) + 1
         < 74*B + 1
         < 2^22.21.
```

The terminal carry `q * B^16` can be folded with the same four coefficients
`(+1 at 0, -1 at 6, -1 at 12, +1 at 14)`. The next carry is at most 75 in
absolute value, and the following one is at most 1. Thus Solinas reduction is
**overflow-safe** under the current model, including signed folding and its
carry chain.

It is not the implementation choice. Turning the final signed `q` and masked
low limbs into a canonical value requires a separate sign-directed correction
proof, while CIOS already returns a result below `2p` followed by one public
conditional subtraction. Solinas also starts with 256 pair products before
folding, versus 210 pair products for 10x26 CIOS including its ten
reduction-digit products. There is no safety or performance reason to carry the
more fragile signed reducer into the implementation. **Do not implement the
Solinas path from this analysis; it is the rejected candidate that proves the
prime is not blocked.**

### 4.3 Selected field representation and constants

```
limbs:       10
limb bits:   26
limb mask:   67108863
byte mask:   255
top mask:    4194303
n0 prime:    1             // -p[0]^-1 mod 2^26
```

`p` and its Montgomery constants in little-endian 26-bit limbs are

```
p limbs:   [67108863, 67108863, 67108863, 262143, 0,
            0, 0, 1024, 67043328, 4194303]
R limbs:   [16, 0, 0, 62914560, 67108863,
            67108863, 67108863, 67092479, 1048575, 0]
R^2 limbs: [768, 0, 66060288, 67108863, 67108859,
            67108799, 67108863, 66584575, 16777215, 1]
```

The implementation may decode the standard curve constants from hex strings
in one initialization helper, but arithmetic code uses decimal masks. The
curve is `y^2 = x^3 - 3x + b (mod p)` with the FIPS 186-4 / secp256r1 `b`,
base point `G`, and order `n`; do not duplicate alternate parameter sources.

## 5. Selected P-256 Montgomery arithmetic

The subgroup order `n` has no useful Solinas form. Use the same CIOS primitive
for both `p` and `n`, specialized to 10 limbs of 26 bits. In both contexts
`R = 2^260`; modulus, `n0_prime`, `R`, and `R^2` are parameters/constants, not
separate algorithms.

| Width | Limbs | CIOS inner bound | Headroom below `2^62` | Decision |
|---|---:|---:|---:|---|
| 32 | 8 | about `2^64` | none | impossible |
| 30 | 9 | `< 2^60 + 2^32` | about 2 bits | too thin |
| 28 | 10 | `< 2^56 + 2^30` | about 6 bits | safe |
| **26** | **10** | `< 2^52 + 2^28` | **about 10 bits** | selected |
| 24 | 11 | `< 2^48 + 2^26` | about 14 bits | safe, slower |
| 16 | 16 | `< 2^32 + 2^18` | about 30 bits | safe, 2.56x the pair products of 26-bit |

Scalar-modulus constants:

```
limb mask:  67108863
top mask:   4194303
n0 prime:   33602639       // -n[0]^-1 mod 2^26
n limbs:    [6497617, 41070783, 32001851, 45522014, 62711546,
             67108863, 67108863, 1023, 67043328, 4194303]
R limbs:    [30255856, 13956110, 24841286, 9845272, 3248213,
             1, 0, 67092480, 1048575, 0]
R^2 limbs:  [40747962, 24314746, 64528516, 6596633, 22376891,
             50009688, 52662966, 8325398, 22665558, 3689317]
```

Compute `s^-1 mod n` as `s^(n-2)` with public square-and-multiply. The fixed
exponent costs 255 squarings and 168 multiplies. This is slower than extended
Euclid but avoids unbounded signed Bézout coefficients under today's integer
model. Verification is not a signing hot path.

For a SHA-256 digest or a canonical field x-coordinate, use
`_n_reduce_256(value)`: parse the complete 256-bit value without a scalar range
check and subtract `n` exactly once when `value >= n`. One subtraction is
sufficient because `value < 2^256 < 2n`; for an x-coordinate the tighter
`value < p < 2n` also holds. This helper is distinct from `_n_from_be_checked`,
which rejects out-of-range signature scalars `r` and `s`.

## 6. RSA representation and Montgomery call

### 6.1 Why whole-column schoolbook is rejected at 26 bits

For a modulus of `m` limbs, a full schoolbook column is bounded by
`m * (2^w - 1)^2 < m * 2^(2w)`. The table shows why “pair products fit” is not
enough:

| Width | 2048-bit limbs / bound | 3072-bit limbs / bound | 4096-bit limbs / bound | Result |
|---|---|---|---|---|
| 32 | `64 / 2^70.00` | `96 / 2^70.58` | `128 / 2^71.00` | impossible |
| 30 | `69 / 2^66.11` | `103 / 2^66.69` | `137 / 2^67.10` | impossible |
| 28 | `74 / 2^62.21` | `110 / 2^62.78` | `147 / 2^63.20` | crosses `2^62` |
| 26 | `79 / 2^58.30` | `119 / 2^58.89` | `158 / 2^59.30` | fits, but only 2.7 bits at 4096 |
| 24 | `86 / 2^54.43` | `128 / 2^55.00` | `171 / 2^55.42` | safe |
| 16 | `128 / 2^39.00` | `192 / 2^39.58` | `256 / 2^40.00` | safe, too many products |

A separate schoolbook product followed by trial division or bitwise long
division is therefore rejected. At 24 bits it is arithmetically safe but
creates a 2m-limb temporary and then pays a second quadratic reduction pass.
Barrett reduction also needs a precomputed reciprocal and a 2m-by-m product;
it does not improve this verify-only workload.

### 6.2 CIOS bound

CIOS integrates one multiply row and one Montgomery reduction row, masking each
limb before advancing. With `B = 2^26`, normalized `t`, `a`, `b`, and modulus
limbs below `B`, either inner row evaluates at most

```
z = t[j] + x*y + carry
  <= (B - 1) + (B - 1)^2 + (B - 1)
  = B^2 - 1
  < 2^52.
```

Allowing the top scratch limb to be temporarily below `2B` still gives
`z < 2^52 + 2^28`, essentially 10 bits below `2^62`. The reduction digit is

```
q = (t[0] * n0_prime) & 67108863,
n0_prime = -n[0]^-1 mod 2^26,
```

so `q*n[j] < 2^52` as well. Squaring inherits the identical bound. A final
public comparison subtracts the modulus once; the standard CIOS invariant
keeps the result below `2n`.

Selected shapes and top masks for exact-size moduli:

| Modulus | Limbs | Capacity | Top used bits | Top mask |
|---|---:|---:|---:|---:|
| 2048 | 79 | 2054 | 20 | 1048575 |
| 3072 | 119 | 3094 | 4 | 15 |
| 4096 | 158 | 4108 | 14 | 16383 |

Build a context only for a checked, odd, non-zero modulus. Derive `n0_prime`
with masked Newton iteration on the 26-bit low limb; mask the inner product
before multiplying again so no transient exceeds `2^52`. Derive `R^2 mod n`
by repeated modular doubling, or cache it with the parsed public key. No general
division primitive is required.

Accept public exponents that fit a positive 31-bit `int`, are odd, and are at
least 3. This includes the overwhelmingly common 65537 and the exponents in the
NIST validation vectors while preventing an untrusted certificate from turning
one verification into a multi-thousand-bit exponent denial of service.

### 6.3 `-O0` cost

For exponent bit length `L` and population count `H`, initializing from the
base costs `L - 1` squarings and `H - 1` multiplies, plus one conversion into
and one conversion out of Montgomery form: `L + H` Montgomery multiplications.
For `65537`, `L = 17`, `H = 2`, hence 19.

| Modulus | Limbs `m` | Limb products per Montgomery multiply (`2m^2 + m`) | Limb products per `e=65537` verify (`19*(2m^2 + m)`) |
|---|---:|---:|---:|
| 2048 | 79 | 12,561 | **238,659** |
| 3072 | 119 | 28,441 | **540,379** |
| 4096 | 158 | 50,086 | **951,634** |

Each limb product brings roughly four more scalar operations (adds, mask, and
shift), so the inner-loop order is about 1.19 million primitive operations at
2048 bits, 2.69 million at 3072 bits, and 4.75 million at 4096 bits, before
indexing and loop control. The 2048-bit case is therefore in the same class as
the roughly 2.1 million primitive operations estimated for one shipped X25519
scalar multiplication in the SFN-500 note, not in the repeated
multi-hundred-KiB byte-loop class that regressed the CI shard in
`compiler/src/build/fs.sfn`. The larger cases are still quadratic interpreted
array work under `-O0`, so tests must:

1. run one 2048-bit positive modexp KAT in the fast file;
2. exercise malformed EMSA encodings directly, without repeating modexp;
3. keep 3072/4096 raw-modexp smoke vectors to one case each and isolate them if
   measurement after implementation makes the fast file exceed 30 seconds;
4. never place a 100- or 1,000-verification timing loop in a normal CI shard.

These counts exclude Montgomery-context setup. Computing `R^2` by repeated
doubling is a one-time per-key cost and should be cached with the parsed public
key; the performance measurement must report cold setup separately from a warm
verification. The implementation issue must record the measured one-vector wall
time under the `-O0` test binary. The arithmetic count says “viable”;
measurement chooses whether the two larger smoke vectors stay in the fast file.

## 7. Implementation specification

### 7.1 P-256 modules

`capsules/sfn/crypto/src/p256.sfn` owns the field and point layer. All helpers
are private unless a downstream parser needs the public-key decoder.

| Function | Contract |
|---|---|
| `_p256_from_be` / `_p256_to_be` | 32-byte big-endian encoding to/from 10x26 Montgomery field limbs |
| `_p256_add` / `_p256_sub` | Montgomery x Montgomery to canonical Montgomery residue modulo `p` |
| `_p256_mont_mul` / `_p256_square` | fixed-modulus CIOS using section 4.3 constants |
| `_p256_inv` | `x^(p-2)`; reject zero at caller |
| `_p256_sqrt` | `x^((p+1)/4)` plus square-and-compare for compressed points |
| `_p256_point_decode` | SEC1 compressed/uncompressed point; range and on-curve checks |
| `_p256_point_add` / `_p256_point_double` | Jacobian formulas, including infinity and exceptional public cases |
| `_p256_joint_mul` | public Shamir/Straus calculation `u1*G + u2*Q` |
| `_n_from_be_checked` / `_n_to_be` | checked signature-scalar encoding into Montgomery form / canonical encoding out; require `1 <= value < n` |
| `_n_reduce_256` | any 256-bit digest/coordinate to a Montgomery-domain residue in `[0,n)` with at most one subtraction before conversion |
| `_n_mont_mul` / `_n_mul` / `_n_inv` | fixed 10x26 scalar arithmetic modulo `n` |

`capsules/sfn/crypto/src/ecdsa.sfn` owns DER parsing integration and exports a
verify function over a SHA-256 digest, decoded public point, and decoded `r,s`.
The exact public signature should follow the DER/X.509 types delivered by
SFN-504 rather than founding a second parser.

Verification sequence:

1. Require a valid, non-infinity, on-curve public point.
2. Require `1 <= r < n` and `1 <= s < n`.
3. Interpret the complete SHA-256 digest as a 256-bit integer and call
   `_n_reduce_256`; do not reject a digest that is at least `n`.
4. Compute `w = s^-1`, `u1 = e*w mod n`, and `u2 = r*w mod n`.
5. Compute `R = u1*G + u2*Q` with public-data joint multiplication.
6. Reject infinity; convert the affine x-coordinate out of the `p` Montgomery
   domain, call `_n_reduce_256`, and accept only if it equals `r`. Do not reject
   a valid coordinate merely because it is at least `n`.

Use Jacobian coordinates so the joint multiplication pays one field inversion
at the end, not one per point operation. Public branches are preferred over a
fragile “constant-time” exceptional-case workaround.

### 7.2 RSA modules

`capsules/sfn/crypto/src/bignum.sfn`:

| Function | Contract |
|---|---|
| `_bn_from_be` / `_bn_to_be` | checked big-endian conversion using 26-bit limbs |
| `_bn_cmp` / `_bn_sub` / `_bn_double_mod` | public canonical helpers |
| `_mont_n0_prime` | masked Newton inverse of an odd low limb |
| `_mont_r2` | repeated-doubling `R^2 mod n` setup |
| `_mont_mul` | CIOS multiply; normalized inputs; result `< n` |
| `_mont_in` / `_mont_out` | conversions using `R^2` and one |
| `_modexp_public` | public square-and-multiply for checked small exponent |

`capsules/sfn/crypto/src/rsa.sfn`:

| Function | Contract |
|---|---|
| `_rsa_public_op` | checked OS2IP, shared public modexp, fixed-length I2OSP; the common core for both RSA modes |
| `_emsa_pkcs1_v1_5` | reconstruct the exact `00 01 FF...FF 00 DigestInfo` byte string |
| `rsa_pkcs1_v1_5_verify_sha256` | RFC 8017 section 8.2.2, full-encoding equality |
| `rsa_pkcs1_v1_5_verify_sha384` | same with SHA-384 DigestInfo |
| `_mgf1` | RFC 8017 appendix B.2.1 mask generation; shipped as one hash-tagged function rather than the per-digest pair sketched here, so the counter loop is not duplicated (SFN-658) |
| `_emsa_pss_verify` | RFC 8017 section 9.1.2 structural checks and hash recomputation |
| `rsa_pss_verify_sha256` / `rsa_pss_verify_sha384` | TLS 1.3 profile: salt length equals digest length |

This note's **RSA VIABLE** verdict covers the shared public operation and both
verify modes required by SFEP-0048: PKCS#1 v1.5 for X.509 certificate
signatures and PSS for TLS 1.3 CertificateVerify. Delivery remains deliberately
split: SFN-656 implements `bignum.sfn`, `_rsa_public_op`, and PKCS#1 v1.5;
SFN-658 reuses that exact core and adds MGF1/PSS. SFN-658 is a required consumer,
not an optional follow-up, and must not fork a second bignum implementation.

Reject zero/even/unsupported-size moduli, an invalid exponent, signature length
different from modulus byte length, and `signature >= modulus`. Compare the
entire recovered encoded message with a freshly constructed expected encoding;
never search for a digest inside attacker-controlled padding.

DigestInfo prefixes from RFC 8017 section 9.2:

```
SHA-256: 3031300d060960864801650304020105000420
SHA-384: 3041300d060960864801650304020205000430
```

The padding string is all `ff`, is at least eight bytes, and is separated from
DigestInfo by exactly one `00` byte.

For PSS, follow RFC 8017 section 9.1.2 exactly: require the `bc` trailer,
enforce the unused leftmost-bit mask from `emBits = modBits - 1`, unmask DB with
MGF1, require zero padding followed by exactly one `01`, recover the fixed-size
salt, and compare `H` with the recomputed hash of `8*00 || mHash || salt`.
TLS 1.3's `rsa_pss_rsae_sha256` and `rsa_pss_rsae_sha384` profiles use salt
length equal to hash length; arbitrary salt-length policy is outside SFN-658.

## 8. Known-answer gates

### 8.1 ECDSA-P256

Gate the implementation with both sources:

- RFC 6979 appendix A.2.5, P-256/SHA-256, messages `sample` and `test`. Although
  RFC 6979 specifies deterministic signing, its public key and `(r,s)` values
  are direct verification KATs. For `sample`, use:

  ```
  Ux = 60FED4BA255A9D31C961EB74C6356D68C049B8923B61FA6CE669622E60F29FB6
  Uy = 7903FE1008B8BC99A41AE9E95628BC64F2F1B20C2D7E9F5177A3C294D4462299
  r  = EFD48B2AACB6A8FD1140DD9CD45E81D69D2C877B56AAF991C34D0EA84EAF3716
  s  = F7CB1C942D657C41D436C7A1B6E29F65F3E900DBB9AFF4064DC4AB2F843ACDA8
  ```
- NIST's FIPS 186-4 ECDSA validation archive,
  `186-4ecdsatestvectors/SigVer.rsp`, group `[P-256,SHA-256]`. Import at least
  one passing case and the supplied `R changed`, `S changed`, and `Q changed`
  failures. Preserve the source group and case text in test comments.

Also cover the acceptance holes: `r=0`, `s=0`, `r>=n`, `s>=n`, off-curve key,
infinity, malformed SEC1 point, malformed DER, changed message, and changed key.

### 8.2 RSA

RFC 8017 contains algorithms and DER/EMSA encodings, **not numeric RSA
signature test vectors**. Therefore “RFC 8017 test vector” cannot literally be
the numeric gate. Use:

- RFC 8017 sections 8.2.2 and 9.2 as the procedural and byte-for-byte encoding
  authority, including the SHA-256/SHA-384 DigestInfo prefixes above;
- NIST's FIPS 186-4-linked RSA validation archive,
  `SigVer15_186-3.rsp`, group `[mod = 2048]`, for numeric PKCS#1 v1.5 pass/fail
  vectors. The historical filename is NIST's; the archive is the RSA link in
  the FIPS 186-4 row of the CAVP digital-signature test-vector page;
- the same archive's `SigVerPSS_186-3.rsp`, group `[mod = 2048]`, for numeric
  PSS pass/fail vectors. Select SHA-256 cases whose salt length is 32 bytes and
  SHA-384 cases whose salt length is 48 bytes for the two required TLS 1.3
  profiles.

Run at least one passing 2048/SHA-256 case and supplied failing cases. Then
mutate the recovered encoding directly for garbage after DigestInfo, a short
padding string, wrong DigestInfo prefix, missing `00 01`, missing separator,
and a non-`ff` padding byte. Also cover zero/even modulus, short signature,
long signature, `signature >= modulus`, exponent below 3, even exponent, and
exponent wider than 31 bits.

For PSS, individually reject a wrong `bc` trailer, non-zero unused leftmost
bits, non-zero PS byte, missing `01` delimiter, wrong salt length, mismatched
`H`, changed message, and changed signature. These structural cases exercise
`_emsa_pss_verify` directly after one end-to-end modexp KAT, just as the v1.5
negative encodings avoid repeated exponentiation.

## 9. Scope, self-hosting, and risks

The implementation issues add library-capsule source and tests only. They add
no compiler or runtime capability. As the X25519 note's correction records,
`sfn/crypto` is in the compiler dependency closure, so a newly added module is
a structural self-hosting change and must run `make clean-build` followed by
`make compile`. The seed can already parse, typecheck, and lower every construct
specified here; bundling each module with its only consumer avoids a seed cut.

Primary risks:

- **Wrong fixed Montgomery context.** The field and scalar engines share code
  but not modulus/`n0_prime`/`R`/`R^2` constants. Unit-test both contexts
  against independently generated multiply/inverse values before point tests.
- **Montgomery invariant drift.** Never replace CIOS with a whole-column
  26-bit accumulator without revisiting the table in section 6.1.
- **Incomplete public-key validation.** Reject off-curve and infinity points
  before scalar multiplication.
- **Permissive PKCS#1 padding.** Full expected-encoding equality is
  load-bearing; a substring/parser check recreates known signature-forgery
  failures.
- **Scope reuse.** These branchy public-data routines are not approved for
  ECDSA signing, RSA signing/decryption, or any operation with a secret scalar.
- **`-O0` test multiplication.** Negative EMSA cases must not each repeat a
  2048-bit modexp. Test the decoder directly after one end-to-end KAT.

## 10. References

- SFEP-0048: `docs/proposals/0048-native-crypto.md`.
- SFN-500 precedent:
  `docs/proposals/design-notes/sfn-335-x25519-limb-strategy.md`.
- FIPS 186-4 (withdrawn in favor of 186-5, retained as the issue's algorithm
  contract): <https://doi.org/10.6028/NIST.FIPS.186-4>.
- RFC 6979 appendix A.2.5: <https://www.rfc-editor.org/rfc/rfc6979#appendix-A.2.5>.
- RFC 8017 PKCS#1 v1.5 sections 8.2.2 and 9.2, PSS sections 8.1.2 and
  9.1.2, and MGF1 appendix B.2.1:
  <https://www.rfc-editor.org/rfc/rfc8017#section-8.2.2>,
  <https://www.rfc-editor.org/rfc/rfc8017#section-9.2>,
  <https://www.rfc-editor.org/rfc/rfc8017#section-8.1.2>,
  <https://www.rfc-editor.org/rfc/rfc8017#section-9.1.2>, and
  <https://www.rfc-editor.org/rfc/rfc8017#appendix-B.2.1>.
- NIST CAVP digital-signature vectors:
  <https://csrc.nist.gov/Projects/cryptographic-algorithm-validation-program/digital-signatures>.
- NIST ECDSA archive:
  <https://csrc.nist.gov/CSRC/media/Projects/Cryptographic-Algorithm-Validation-Program/documents/dss/186-4ecdsatestvectors.zip>.
- NIST RSA archive:
  <https://csrc.nist.gov/CSRC/media/Projects/Cryptographic-Algorithm-Validation-Program/documents/dss/186-3rsatestvectors.zip>.
