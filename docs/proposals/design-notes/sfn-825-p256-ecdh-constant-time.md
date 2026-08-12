# SFN-825 — Constant-time P-256 ECDH: what it costs, and why it is not this issue

> Single-issue design gate (no SFEP number). Design context: SFEP-0048
> (`docs/proposals/0048-native-crypto.md`, Accepted), Phase D. This note answers
> one question — **can the existing verification-grade P-256 arithmetic carry an
> ECDH secret scalar, and if not, what does a constant-time path actually
> cost?** — and records the disposition. It changes no language surface, adds no
> compiler capability, and has no seed dependency. It is the design gate the
> SFN-825 issue body demanded before any code was written; the answer moved the
> implementation into SFN-845, SFN-846 and SFN-847 and reduced SFN-825 itself to
> this note plus a diagnostic change.

## 1. Verdict

**DEFER. Do not point the verification-grade scalar multiply at an ECDH key,
and do not attempt a constant-time ladder inside SFN-825.**

Three findings drive that, in order of weight:

1. **The arithmetic core is in better shape than its own warning suggests.**
   `bignum.sfn:8-21` declares the module deliberately non-constant-time. That is
   true of the module as a *product*, but it overstates the reach of the
   property: `_mont_mul`'s CIOS body (`bignum.sfn:339-377`) is already
   branch-free and index-independent. The variable-time surface is three small
   sites totalling roughly **40 additive lines** (§3).
2. **The point layer, by contrast, needs a redesign rather than a patch.**
   `P256Point` encodes infinity as a `boolean` flag (`p256.sfn:341-348`), and
   both point primitives branch on that flag and on zero-tests of coordinates
   (`p256.sfn:480-482`, `p256.sfn:516-522`, `p256.sfn:536-539`). Over a secret
   scalar every one of those is a leak (§5).
3. **The TLS plumbing the issue never costed is larger than the crypto.**
   Offering a second group means two key shares or HelloRetryRequest, and HRR is
   *rejected* today (`tls13_handshake_codec.sfn:1103-1105`). Three sites hard-
   require a 32-byte share and the handshake state carries exactly one keypair
   (§6).

Performance is **not** among the reasons. §5.5 sizes a constant-time ladder at
about 1.6x a shipped X25519 handshake and about 1.2x one ECDSA verification the
suite already runs at `-O0`. This is deferred on correctness-assurance and
sequencing grounds, not cost.

The governing risk is §7 and deserves stating in the verdict: **a subtly
non-constant-time ECDH would pass every test in this repository.** Nothing here
can falsify a constant-time claim. Shipping one under a 3-point issue would be
exactly the "parsed but not enforced" failure CLAUDE.md forbids, transposed onto
a security property.

## 2. The bar, already met in-capsule

`capsules/sfn/crypto/src/x25519.sfn` is the precedent: the one shipped path in
this capsule that takes a **secret scalar**, and it is constant-time by
construction, not by inspection.

- `_cswap` (`x25519.sfn:165-183`) is the masked-select exchange. Both arrays are
  written on every iteration regardless of the bit, so there is no
  data-dependent write pattern.
- `_fsub` (`x25519.sfn:70-78`) adds the `_four_p()` bias (`x25519.sfn:38-47`)
  precisely so non-negativity holds "with no sign test and no branch" — the
  subtraction never needs a conditional correction.
- Even the final canonical reduction is branch-free: `_pack25519` routes its
  conditional subtraction through the same masked exchange (`x25519.sfn:254`).
- `_finv` (`x25519.sfn:184-203`) uses a fixed addition chain whose test is on
  the loop counter, and the ladder body (`x25519.sfn:311-333`) is the identical
  straight-line sequence on all 255 iterations, with the scalar bit reaching
  control flow only through `_cswap`.

A P-256 ECDH path is not allowed to clear a lower bar than this. In particular,
"the final subtraction is only one limb comparison, it probably does not matter"
is not an argument this capsule has ever accepted — `_pack25519` did not accept
it either.

## 3. Where the non-constant-time property actually lives

### 3.1 The CIOS core is already clean

Read `_mont_mul` (`bignum.sfn:330-397`) against the definition rather than
against its module header. In the outer loop (`bignum.sfn:339-377`):

- every array index is a loop counter (`i`, `j`, `k`, `w`), never a value;
- every loop bound is `ctx.limbs`, a public modulus property;
- every inner result is masked before the next limb, so no propagation depends
  on operand magnitude;
- there is no early exit and no conditional.

That is a branch-free, index-independent kernel. `bignum.sfn:8-21`'s "THIS CODE
IS DELIBERATELY NOT CONSTANT TIME" is a *policy* statement about the module's
approved uses, and it is correct as such; it is not an accurate description of
the CIOS kernel's structure. The distinction matters, because it is the
difference between "a constant-time P-256 needs a second arithmetic core" and
"a constant-time P-256 needs a different last four lines".

### 3.2 The three variable-time sites, in full

| Site | Why it is variable-time |
|---|---|
| `bignum.sfn:395` — `if _bn_cmp(r, n) >= 0 { return _bn_sub(r, n); }` | The final CIOS canonicalization. Taken or not depending on the residue. |
| `bignum.sfn:127-140` — `_bn_cmp` | Returns on the first differing limb, so its trip count is a function of the operands. |
| `bignum.sfn:145-160` — `_bn_sub` | Per-limb `if d < 0 { … } else { … }` borrow branch. |
| `p256.sfn:172-176` — `_p256_mod_add` | Same conditional subtraction, via the same two helpers. |
| `p256.sfn:180-183` — `_p256_mod_sub` | Branches on `_bn_cmp(a, b) >= 0` to choose whether to pre-add the modulus. |

`_bn_at` (`bignum.sfn:98-102`) tests `i >= x.length`, but lengths here are the
public fixed limb count, so that is not a leak.

### 3.3 The fix is additive, and must be

Roughly 40 lines: a branch-free borrow-propagating `_bn_sub_ct` that always
computes `r - n` and returns the borrow, plus a masked `_bn_select_ct(mask, a,
b)`, plus `_p256_mod_add_ct` / `_p256_mod_sub_ct` / a `_mont_mul_ct` wrapper (or
a `ct` flag threaded on `MontCtx`) built from them.

These land as **siblings, not replacements**. `bignum.sfn:8-21` explicitly
instructs against "fixing" the existing helpers, and it is right to: the RSA and
ECDSA verify paths are in production, and rewriting live public-data code to
serve a not-yet-shipped secret-data path is the SFN-666 §9 hazard by another
name. The new helpers carry their own header stating that they *are* the
constant-time lane and why.

## 4. Operand audit: what is secret in an ECDH

ECDH inverts the ECDSA-verify situation that `sfn-653-p256-rsa-bigint-strategy.md`
§2 audited. There, "there are no secrets". Here there is exactly one, and it
touches the most expensive routine in the module.

**Secret.** The client's ephemeral private scalar `d` in `[1, n-1]`, every
intermediate point of `d * Q`, and the resulting shared x-coordinate.

**Public.** The peer's key share as received, its SEC1 encoding, the curve
parameters, the group ID, all lengths, and every validation *outcome* on the
peer's point — a malformed or off-curve peer key is public data and may be
rejected with a plain branch.

Reusable **as-is**:

- `_p256_point_decode` (`p256.sfn:403-470`) — operates entirely on the peer's
  public key share, including its on-curve and length checks. No change.
- `_p256_p_inv` via `_p256_pow_be` (`p256.sfn:206-222`, `p256.sfn:231-233`) —
  the exponent is the module constant `_p256_p_minus_2_be()`, so the bit branch
  is on public data and the routine is already constant-time *with respect to
  its base*, which is what the final affine conversion needs. This is a genuine
  and slightly surprising win: the inversion at the end of the ladder needs no
  new code.
- `_p256_from_be` / `_p256_to_be` (`p256.sfn:276-294`) — range check and
  serialization on fixed widths.

Must be **new and constant-time**: the variable-base scalar multiply, everything
it calls (§3.3, §5.4), and secret-scalar generation.

**Secret-scalar generation is a fourth item the issue did not name.** X25519
sidesteps it: `hs_client_new` takes 32 raw bytes and clamps them
(`x25519.sfn:290-291`), and every 32-byte string is a valid scalar. P-256 has no
clamp. A scalar must land in `[1, n-1]`, which means rejection sampling from
`random_bytes` (`rand.sfn:35`) with a comparison against `n` — and that
comparison is over a secret. The standard construction is a fixed-iteration
rejection loop whose *trip count* is public (retry a constant number of times,
fail closed) with a constant-time in-range test; the naive `_bn_cmp` loop is not
acceptable here either.

## 5. Why the point layer is a redesign, not a patch

### 5.1 `infinity` is a flag, and the flag is the problem

`P256Point` carries `infinity: boolean` (`p256.sfn:341-348`). The header at
`p256.sfn:340-342` explains the choice: a flag rather than `Z = 0` "so no
arithmetic path can produce it implicitly." That is the right call for verify —
it makes the exceptional case impossible to reach by accident. It is the wrong
representation for a constant-time ladder, where the exceptional case must be
representable and *absorbed arithmetically* rather than tested.

### 5.2 Both primitives branch, not just `_p256_point_add`

The issue named `_p256_point_add`'s `H == 0` split (`p256.sfn:536-539`, with the
rationale at `p256.sfn:516-521`). It is not alone:

- `_p256_point_double` (`p256.sfn:480-514`) opens with `if pt.infinity` and
  `if _bn_is_zero(pt.y)`, and closes with `if _bn_is_zero(z3)`.
- `_p256_point_add` (`p256.sfn:522-560`) opens with `if a.infinity` /
  `if b.infinity` and closes with `if _bn_is_zero(z3)`.

In a verification, every one of those tests is on public data and a readable
branch is the better engineering choice, exactly as `p256.sfn:520-521` argues.
In an ECDH, the accumulator is a function of the secret scalar, so all six are
secret-dependent.

### 5.3 `_p256_joint_mul` is structurally the wrong shape

`_p256_joint_mul` (`p256.sfn:579-602`) is Straus's method with a four-entry
table indexed by `idx` built from two scalar bits, with three `if idx == k`
arms. It is documented as safe precisely because "both scalars are public"
(`p256.sfn:577-578`). It cannot be reused; it is not a ladder with a leak, it is
a different algorithm.

### 5.4 The shape that works

- **Representation.** Drop the flag; encode the point at infinity as `Z = 0` in
  homogeneous or Jacobian projective coordinates, so the identity is an ordinary
  value the formulas can carry.
- **Formulas.** Either complete addition formulas for short-Weierstrass curves
  with `a = -3` (Renes-Costello-Batina), which have no exceptional case at all,
  or the existing `dbl-2001-b`/`add-2007-bl` pair with the exceptional branches
  removed and the ladder structured so they are never hit. The former is
  strongly preferred: it removes the obligation to *prove* the exceptional case
  unreachable, and that proof is exactly the sort of reasoning §7 says nothing
  here can check.
- **Selection.** `_p256_point_select_ct(mask, a, b)` over three coordinate
  arrays, built on `_bn_select_ct` (§3.3) — the direct analogue of
  `x25519.sfn:165`'s `_cswap`.
- **Ladder.** Fixed 256 iterations, one double and one add per bit, no early
  exit on leading zero bits, no windowing (a window means a secret table index,
  which is the same class of leak as §5.3 with extra machinery).

### 5.5 Cost, and why it is not the blocker

At 10 limbs a Montgomery multiply is about 210 limb products (SFN-653 §1).
Counting the shipped formulas: `_p256_point_double` is 3M + 5S = 8 multiplies,
`_p256_point_add` is 11M + 5S = 16. A 256-iteration double-and-add-always ladder
is therefore about **6,100 Montgomery multiplies, ~1.29M limb products**, plus a
final inversion of about 390 multiplies (~82K products, under 7%).

For scale, using the same accounting:

| Operation | Approximate limb products |
|---|---|
| X25519 ECDH, shipped today | ~0.83M |
| Constant-time P-256 ECDH | ~1.29M |
| One ECDSA-P256 verification, shipped today | ~1.08M |

A constant-time P-256 ECDH costs roughly 1.6x a shipped X25519 handshake and
1.2x an ECDSA verification the suite already runs under `-O0`. That is an
ordinary per-handshake cost, not a budget problem. Complete formulas would move
the add to about 12M + 0S and land in the same band.

## 6. The uncosted prerequisite: TLS plumbing

Even with a finished constant-time ladder, nothing reaches the wire. Offering
secp256r1 alongside X25519 means either sending two key shares in the
ClientHello or handling a HelloRetryRequest, and the current stack does neither:

- **HRR is rejected outright** — `tls13_handshake_codec.sfn:1103-1105`. The
  server side agrees and says so (`tls13_server_handshake.sfn:462-466`).
- **The client state holds exactly one keypair** — `client_private` /
  `client_public` (`tls13_handshake.sfn:156-157`), threaded through every state
  transition.
- **Three sites hard-require 32 bytes** — `hs_client_new` (`tls13_handshake.sfn:313`),
  `encode_client_hello` (`tls13_handshake_codec.sfn:345`), and the group check
  plus share-length check in `hs_client_recv_server_hello`
  (`tls13_handshake.sfn:531-540`).
- **The parser's offer model is a boolean** — `parse_client_hello` reports
  `offers_x25519_group: bool` rather than a group list, so the server side
  cannot express a second group either.

`hs_client_new`'s signature is public API. This is a multi-file, both-sides
change with a compatibility story, and it is independent of the crypto: SFN-846.

## 7. The governing risk: nothing here can falsify a constant-time claim

**A subtly non-constant-time ECDH would pass all 41 test files in
`capsules/sfn/crypto/tests/`, and every gate in the validation ladder.**

`sfn check` models types and effects. `make compile` proves self-hosting. The
test suite checks values. None of them observes timing, and this repository has
no timing harness, no `dudect`-style statistical test, no `ctgrind`/Valgrind
instrumentation, and no constant-time-verified toolchain leg. There is also no
LLVM-level guarantee that the branch-free source stays branch-free after
optimization — the capsule's existing constant-time claims rest on source
structure plus `-O0`-era review, and that is a real limit worth writing down
rather than papering over.

This is the same honesty rule CLAUDE.md applies to language features —
"parsed but not enforced is not shipped" — applied to a security property. A
constant-time claim we cannot check is a claim we should not make casually, and
certainly not as a side effect of a 3-point reach improvement.

The only controls that actually exist:

1. **NIST CAVP ECC-CDH known-answer vectors** for P-256, which prove
   *correctness* of the ladder and nothing about timing. Mandatory, not
   sufficient.
2. **A structural review checklist** derived from §3-§5: no branch on a value
   derived from the scalar, no array index derived from the scalar, fixed
   iteration counts, every conditional expressed as a mask. This is
   `x25519.sfn`'s actual assurance mechanism too, and it is why the X25519 note
   (`sfn-335-x25519-limb-strategy.md` §4) spends a section on `_cswap` rather
   than asserting the property.
3. **A cross-implementation differential test** against a known-good ECDH
   (already possible offline via the CAVP vectors), which again covers
   correctness only.

Naming this makes the deferral decision, not just the note: a security property
whose only assurance is reviewer attention should be scheduled as its own issue
with its own review, not bundled into a reach fix.

## 8. Restriction-vs-power: what the group actually buys

`docs/strategy/decision-brief.md`'s test asks what *power* a change attaches,
and the honest answer here is modest.

- **Reach gain: near-zero in practice.** Every mainstream TLS 1.3 server
  implements X25519. A server reachable only via secp256r1 is a rarity, mostly
  hardware or FIPS-constrained middleboxes.
- **Conformance gain: real.** RFC 8446 §9.1 says a TLS 1.3 client "MUST support
  key exchange with secp256r1" and only "SHOULD support key exchange with
  X25519". The stack is non-conformant on that clause today. For a project whose
  positioning is that a stranger can grade the artifact, a stated MUST that is
  unmet is a genuine defect — but it is a conformance defect, not an unblock.
- **Diagnosability gain: real, cheap, and separable.** Today the limit surfaces
  as an abort that never mentions groups. That is fixable in message text alone,
  and is the part of SFN-825 that ships now (§9).

Conformance plus diagnosability justifies scheduling the work. Neither justifies
shipping an unverifiable constant-time primitive to get there faster.

## 9. Disposition

**SFN-825 (this note, 2 points).** This design note, plus the diagnostic change
that makes the group-negotiation failure self-describing:

- `tls13_handshake.sfn:531-535` — the abort now names key-exchange group
  negotiation as the cause and states that X25519 is the only group offered.
- `tls13_handshake_codec.sfn:1103-1105` — the HelloRetryRequest rejection now
  names the usual cause, a server wanting a group this client does not offer.
  The substring `HelloRetryRequest` is retained; `tls13_handshake_codec_test.sfn:259`
  asserts on it.

Both are message text. The fail-closed enforcement is unchanged: a ServerHello
selecting a group other than X25519 is still rejected, and HRR is still refused.

**SFN-845 — constant-time P-256 ECDH primitive (5 points).** §3.3's arithmetic
siblings, §5.4's projective point layer and ladder, §4's rejection-sampling
scalar generation, CAVP ECC-CDH vectors, and the §7 structural review as an
explicit acceptance criterion. One issue: the constant-time arithmetic helpers
have exactly one consumer (the ladder) worked in the same session, so
`.claude/rules/seed-dependency.md`'s bundling default applies. No seed gate —
capsule source only, same as SFN-653 §9.

**SFN-846 — TLS multi-key-share plumbing (5 points).** §6. Depends on SFN-845.

**SFN-847 — HelloRetryRequest (3 points).** Independent of the curve work;
valuable on its own, since HRR is also how a server requests a group after an
under-specified ClientHello.

## 10. Deliberately excluded

**The `_was_offered`-style refactor.** The natural-looking cleanup is to replace
`tls13_handshake.sfn:531`'s comparison against the `tls_group_x25519()` constant
with a lookup against a recorded offered-group set, mirroring
`_was_offered(hs.offered_cipher_suites, …)` at `tls13_handshake.sfn:521`. It is
the right end state and it is the correct shape to copy.

It is excluded from SFN-825 anyway. With one group offered, an offered-set list
and a constant comparison are behaviourally identical, so the refactor adds a
field to `ClientHandshake`, a helper, and test surface while changing nothing
observable — inert scaffolding with no consumer, which the style guide's bias
against speculative generality rules out. It belongs as **step 1 of SFN-846**,
where the second group arrives in the same change and makes it load-bearing.

**Widening `parse_client_hello`'s `offers_x25519_group: bool` into a group
list.** Same argument, same destination (SFN-846).

**Any change to the enforcement itself.** The current check is fail-closed and
correct: `hs_client_recv_server_hello` rejects any `selected_group` other than
X25519, which is exactly right while X25519 is the only group offered. SFN-825
changes what the abort *says*, never what it *does*.

**Retrofitting the constant-time helpers onto RSA or ECDSA verify.** No secret,
no benefit, and it would rewrite production public-data code (`bignum.sfn:8-21`
says so directly).

## 11. Risks

- **The "it is only one conditional subtraction" temptation.** The single
  highest-probability failure in SFN-845 is someone reusing `_mont_mul`
  unchanged on the grounds that `bignum.sfn:395` leaks at most a bit or two of
  the residue. Montgomery-reduction timing leaks are a published attack class;
  the branch-free canonicalization is not optional.
- **Silent reuse of the verification path.** `_p256_joint_mul` and the point
  primitives are exported (`p256.sfn:621-648`) and typecheck fine against a
  secret scalar. Nothing in the language stops it. The mitigation is the header
  contract plus review; SFN-845 should extend `p256.sfn`'s header the way
  `bignum.sfn:8-21` already does, naming the constant-time lane and the
  verification lane separately.
- **Compiler-introduced branches.** Source-level branch-freedom is not
  machine-level branch-freedom. `-O0` mostly preserves the masked-select shape,
  but this is an assumption, not a guarantee, and it is shared with the shipped
  X25519 path rather than introduced by P-256.
- **Scalar-generation bias.** A modular reduction of 32 random bytes into
  `[1, n-1]` is biased and is the classic mistake; rejection sampling with a
  fixed retry bound and fail-closed exhaustion is the required construction
  (§4).
- **Scope creep into SFN-846.** The plumbing change touches public API
  (`hs_client_new`) and both handshake sides. It must not be started inside
  SFN-845; the ladder is testable against CAVP vectors with no TLS involvement
  at all.
- **Deferring indefinitely.** RFC 8446 §9.1 is a MUST. This note defers the work;
  it does not cancel it, and `docs/status.md` should keep describing the
  X25519-only limit accurately in the meantime.

## 12. References

- SFEP-0048: `docs/proposals/0048-native-crypto.md` (Phase D).
- Sibling design notes:
  `docs/proposals/design-notes/sfn-335-x25519-limb-strategy.md` (§3.1 the
  subtraction bias, §4 the constant-time `cswap` construction),
  `docs/proposals/design-notes/sfn-653-p256-rsa-bigint-strategy.md` (§2 the
  no-secrets audit this note inverts, §5 the shared Montgomery contexts).
- Positioning test: `docs/strategy/decision-brief.md`.
- Decomposition policy: `.claude/rules/seed-dependency.md`.
- RFC 8446 §4.1.3 (HelloRetryRequest), §4.2.8 (key_share) and §9.1 (mandatory-
  to-implement): <https://www.rfc-editor.org/rfc/rfc8446#section-9.1>.
- RFC 7748 §5 (X25519): <https://www.rfc-editor.org/rfc/rfc7748#section-5>.
- SP 800-56A Rev. 3 (ECC-CDH):
  <https://doi.org/10.6028/NIST.SP.800-56Ar3>.
- NIST CAVP ECC-CDH ("Component") vectors:
  <https://csrc.nist.gov/Projects/cryptographic-algorithm-validation-program/component-testing>.
- Renes, Costello, Batina, "Complete addition formulas for prime order elliptic
  curves", EUROCRYPT 2016: <https://eprint.iacr.org/2015/1060>.
