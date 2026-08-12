# SFN-666 — One byte-oriented HMAC/HKDF parametrized by hash

> Single-issue design gate (no SFEP number). Design context: SFEP-0048
> (`docs/proposals/0048-native-crypto.md`, Accepted), Phase D cleanup. This note
> answers one question — **should the SHA-256 and SHA-384 HMAC/HKDF ladders in
> `sfn/crypto` be unified, and if so on what parameter?** — and specifies the
> shape. It changes no language surface, adds no compiler capability, and has no
> seed dependency. Predecessors SFN-662, SFN-663, SFN-664 and SFN-665 are Done,
> so the digest cores, the byte/hex helpers and the test helpers are already
> single-sourced; the composition layer is the last cluster.

## 1. Verdict

**UNIFY, on `hash_len: int` — not on a function value, and not on a new
`HashId` enum.**

One byte-oriented `hmac_bytes(hash_len, key, data)` plus
`hkdf_extract(hash_len, salt, ikm)` and `hkdf_expand(hash_len, prk, info,
length)` live in `capsules/sfn/crypto/src/hkdf.sfn`. Block size and digest
length are derived from `hash_len` by two four-line helpers; the digest call is
one closed `if hash_len == 48` dispatch. `hkdf.sfn`'s three public names become
three-line wrappers that pass `32`. `tls13_schedule.sfn` loses its four private
copies outright.

Three findings drive the verdict, and two of them were not knowable when the
issue was filed:

1. **The duplication is real and mechanical.** 102 lines duplicated, of which
   **91 are character-identical** (§2). Every divergence is a literal `64`↔`128`
   / `32`↔`48` / `8160`↔`12240` and the digest callee.
2. **The hypothesised third and fourth instantiations never arrived.** SFN-655
   (Ed25519), SFN-656 (RSA) and SFN-657 (ECDSA-P256) are all Done, and **none of
   them consumes HMAC or HKDF** — they call `sha512_bytes` / `sha256_bytes` /
   `sha384_bytes` directly (§4.3). The HMAC/HKDF consumer set is closed at two
   and will stay closed: TLS 1.3 defines HKDF only over the cipher-suite hash,
   and RFC 8446 §B.4 registers no SHA-512 suite. A generic mechanism sized for
   *n* hashes would be built for *n = 2*, forever.
3. **A function-value design is not merely inconvenient today — it is
   structurally unavailable to this capsule for at least two seed cycles.**
   A bare function name in argument position is `E0808` on the current
   compiler, and `sfn/crypto` is inside the **runtime's** dependency closure, so
   it is compiled by the *pinned seed*, not by the freshly built compiler (§3.4).
   Even after PR #2901 merges, the capsule cannot use it until that release is
   pinned. Designing against it would park this issue behind a release train for
   a 100-line refactor.

The unification is also **not just cleanup**: `tls13_handshake.sfn:132` and
`tls13_server_handshake.sfn:128` hardcode `_hash_len() -> 32` and explicitly
refuse `TLS_AES_256_GCM_SHA384` because "accepting it would silently change
every hash length here" (`tls13_handshake.sfn:137-140`). The Finished MAC at
`tls13_handshake.sfn:279` calls `hmac_sha256_bytes` unconditionally. A
`hmac_bytes(hash_len, …)` is the exact primitive that suite needs. Today the
SHA-384 ladder has **zero production callers** — only `tls13_schedule_test.sfn`
reaches it — which is simultaneously why this refactor is safe now and why it is
worth doing before the SHA-384 suite is wired up.

## 2. The measured duplication

Two files, four functions, 305 + 275 lines total.

| Pair | SHA-256 | SHA-384 | Lines each | Lines differing |
|---|---|---|---|---|
| HMAC (RFC 2104) | `hkdf.sfn:149-204` `hmac_sha256_bytes` | `tls13_schedule.sfn:30-85` `_hmac_sha384_bytes` | 56 | **6** (incl. signature) |
| HKDF-Expand (RFC 5869 §2.3) | `hkdf.sfn:230-275` `hkdf_sha256_expand` | `tls13_schedule.sfn:90-135` `_hkdf_sha384_expand` | 46 | **5** (incl. signature) |
| HKDF-Extract (RFC 5869 §2.2) | `hkdf.sfn:209-222` `hkdf_sha256_extract` | `tls13_schedule.sfn:145-159` `_hkdf_extract` | 14 / 15 | already `hash_len`-generic on the 384 side |

A line-for-line `diff` of the two 56-line HMAC bodies yields exactly five body
edits:

| `hmac_sha256_bytes` | `_hmac_sha384_bytes` | Meaning |
|---|---|---|
| `if k.length > 64 { k = sha256_bytes(k); }` | `if k.length > 128 { k = sha384_bytes(k); }` | block size B, digest H |
| `if k_pad.length >= 64` | `if k_pad.length >= 128` | B |
| `if pi >= 64` | `if pi >= 128` | B |
| `let inner = sha256_bytes(inner_msg);` | `let inner = sha384_bytes(inner_msg);` | H |
| `return sha256_bytes(outer_msg);` | `return sha384_bytes(outer_msg);` | H |

The ipad/opad `^ 54` / `^ 92` construction, the key zero-fill, and both message
concatenation loops are byte-identical.

The two 46-line Expand bodies yield four body edits:

| `hkdf_sha256_expand` | `_hkdf_sha384_expand` | Meaning |
|---|---|---|
| `length > 8160` | `length > 12240` | `255 * hash_len` |
| `prk.length < 32` | `prk.length < 48` | `hash_len` |
| `(length + 31) / 32` | `(length + 47) / 48` | `ceil(length / hash_len)` |
| `hmac_sha256_bytes(prk, msg)` | `_hmac_sha384_bytes(prk, msg)` | the HMAC above |

The `T(i)` counter loop, the `info` append, the `& 255` counter byte and the
final truncation are byte-identical.

**Every difference is a value, not a shape.** `8160 = 255 * 32` and
`12240 = 255 * 48`; `(l + 31)/32` and `(l + 47)/48` are one ceil-div in
`hash_len`. There is no algorithmic divergence to lose in a merge — which is the
precondition for treating a crypto unification as low-risk at all.

## 3. What Sailfin can express here, as of today's compiler

The issue asks whether a hash can be passed as a parameter. Answered against the
tree, not against intent.

### 3.1 A bare function name in argument position is rejected

`compiler/tests/unit/fn_reference_typecheck_test.sfn:53-56` asserts it directly:

```
test "fn-ref: bare function passed as an argument is E0808"
  "fn worker() { } fn take(f: * u8) { } fn main() { take(worker); }" -> 1x E0808
```

The diagnostic
(`compiler/capsules/analyzer/src/typecheck_types/symbol_table_and_raw_exprs.sfn:296-311`)
states the rule: the only supported materialization is `<fn> as * u8`, or a
typed `<fn> as * fn (...) -> R` (`classify_fn_cast`, same file). The shipped
higher-order fixture confirms the ergonomics gap — it wraps the named function
rather than passing it:

`compiler/tests/e2e/fixtures/higher_order_named_fn/apply_named.sfn:11`
`print(apply(5, fn (x) => double(x)));`

PR #2901 ("materialize named functions as typed values") is **open and
unmerged**. Per the task framing this note does not design against it.

### 3.2 The two indirect-call lanes that do exist, and why neither is proven for this shape

| Lane | Spelling | Lowering | In-tree consumers |
|---|---|---|---|
| Closure pair | `f: fn (int[]) -> int[]` | `{i8*, i8*}` + `extractvalue` dispatch | `fn (int) -> int` only (`apply_named.sfn`, `array.map/filter/reduce`) |
| Bare code pointer | `f: * fn (int[]) -> int[]` | env-less `call` via bitcast (#1089, `core_call_lowering.sfn:84-160`) | `sfn_task_run` (`runtime/sfn/concurrency/scheduler.sfn:601-609`), C-ABI `*u8` only |

Both lanes ship, and both ship **only over pointer-width scalar or raw-pointer
types**. Nothing in the tree passes an `int[]` through either. The `* fn` lane in
particular routes the parameter annotation through `map_parameter_type`
(`compiler/src/llvm/expression_lowering/native/core_type_mapping.sfn:595-634`),
where `* fn (…)` falls into the raw-pointer branch and composes as
`{i8*, i8*}` + `*` — i.e. a pointer-to-closure-pair type that the call site then
bitcasts to a typed function pointer. That may well work by pointer-punning
accident; it is not covered by a test, and `sfn check` would not catch it
(#1389). `sfn/http`'s `serve(handler: *fn (Request) -> Response, …)`
(`capsules/sfn/http/src/server.sfn:149`) is the closest precedent and it never
performs the indirect call — it stores `handler as i64` and dispatches through a
`*u8` trampoline.

**Proving out an untested lowering lane inside the TLS 1.3 key schedule is the
wrong place to do it.** If array-typed function parameters are worth having, they
want their own issue, their own e2e fixture, and a non-crypto first consumer.

### 3.3 There is no struct-of-function-pointers option worth taking

Option 2 (a vtable-ish record) is expressible in principle — a struct with
`* fn (int[]) -> int[]` fields — but it inherits every uncertainty in §3.2 and
adds a struct-field-through-`map_parameter_type` path on top. For a two-member
closed set it is machinery for its own sake: CLAUDE.md's "libraries over
keywords" and "boring syntax wins" both point the other way.

### 3.4 The seed constraint makes this decisive, not merely prudent

`sfn/crypto` is not an ordinary leaf capsule. `runtime/capsule.toml:105-107`
declares `[dependencies] "sfn/crypto" = "*"`, and
`runtime/sfn/platform/tls.sfn:83` imports the handshake facade from it. The
runtime's `sfn-sources` are compiled by the **pinned seed**
(`_compile_runtime_sfn_sources`, `compiler/src/build/runtime_objs.sfn`) — the
carve-out in `.claude/rules/seed-dependency.md`. So:

- Any language construct this capsule uses must be present in the **seed**, not
  merely on `main`. Bundling with a compiler change does not help here.
- Consequently a function-value design could not land until #2901 merged *and*
  the following cadence seed was pinned — two release boundaries for a
  Low-priority 100-line refactor.

The recommended design uses only `int` parameters, `if`, and existing calls. It
compiles on the current seed. **No `seed-blocker`, no `/pin-seed`, no gate.**

## 4. The options, weighed

### 4.1 Option 1 — tag parameter dispatched internally — **RECOMMENDED**

One implementation taking `hash_len: int`; block size, digest length, output cap
and ceil-div all derived from it; the digest call a single closed `if`.

**For.** Compiles on the seed. Monomorphic — no indirect call, no new LLVM path,
no new failure mode in a crypto capsule. Honest about a two-member closed set.
Deletes ~100 lines net. Has **two independent in-capsule precedents that
post-date the issue's filing**: `rsa.sfn:250-262`

```
fn _pss_hash(tag: int, message: int[]) -> int[] {
    if tag == _pss_sha384() { return sha384_bytes(message); }
    return sha256_bytes(message);
}
fn _pss_hash_len(tag: int) -> int { if tag == _pss_sha384() { return 48; } return 32; }
```

and `tls13_schedule.sfn` itself, which *already* dispatches on `hash_len` at
three sites (`_hkdf_expand:138`, `_hkdf_extract:157`, `_empty_transcript_hash:165`)
and infers it from secret length at four more. The refactor does not introduce a
convention; it pushes an existing one down one layer.

**Against.** A tag is a closed world: adding SHA-512-based HKDF later means
touching two helpers. Given §4.3 that cost is hypothetical, and it is two
four-line functions.

**Why `hash_len: int` and not a new `HashId` enum.** `hash_len` is already the
discriminator throughout `tls13_schedule.sfn`, and unlike an opaque tag it is
*also the data the algorithm needs* — Expand needs it for the ceil-div and the
output cap regardless. A `HashId` enum would add a second, parallel taxonomy plus
`HashId -> len` and `HashId -> block` mappings, and every existing call site
would have to convert. `hash_len` collides only if two supported hashes ever
share a digest length (SHA-512/256, SHA3-256); at that point the discriminator
changes in one file, and the fail-closed guard in §5.2 makes the collision a
compile-time-visible edit rather than a silent misderivation. Note this is a
*capsule-internal* parameter — the public `sfn/crypto` surface
(`mod.sfn:33`, `mod.sfn:387`) does not gain it.

### 4.2 Option 2 — function value / struct of function pointers — **REJECT**

Blocked by §3.1 today; blocked by §3.4 for two seed cycles even after PR #2901;
and even then it requires the untested `int[]`-through-`* fn` or
`int[]`-through-closure-pair lowering lane of §3.2. Record the dependency and
move on: **if this ever becomes attractive, its predecessor is PR #2901 landing
*and* being pinned as a seed, plus an e2e fixture proving an `int[]`-carrying
indirect call.** Nothing in this issue should wait on that.

### 4.3 Option 3 — extract the shared byte-level core only — **collapses into Option 1**

The premise is right — the ipad/opad construction and the `T(i)` counter loop are
hash-agnostic given `(B, HashLen)` as data — but it does not survive contact with
HMAC's shape: HMAC must *call* the digest three times (key shortening, inner,
outer). There is no formulation that takes only `(B, HashLen)` and pre-computed
digests. The moment the shared core needs the digest, it needs either a function
value (§4.2) or a tag (§4.1). Option 3 is therefore Option 1 with the dispatch
pushed into a helper, which is exactly what §5 specifies.

The narrower variant — unify Expand only, keep two HMACs — is worse than either:
Expand calls HMAC in a loop, so it still needs the dispatch, and it would leave
the larger (56-line) duplicate in place to buy nothing.

### 4.4 Option 4 — do nothing — **legitimate, but rejected on evidence**

The honest case for it: 102 lines in a ~2,900-line pair of files; both copies are
correct and vector-pinned; Low priority; a crypto refactor's downside is
unbounded and its upside is a line count. If the only argument were tidiness,
this note would recommend closing the issue.

Three facts outweigh it:

1. **The SHA-384 copy has two branches no test reaches.**
   `tls13_schedule_test.sfn` derives at most 48 bytes at a time (`key` 16, `iv`
   12, `derive_secret` 48), so `n` is always 1 and the SHA-384 **multi-block
   counter loop has never executed**. Likewise no vector feeds
   `_hmac_sha384_bytes` a key longer than 128 bytes, so its key-shortening branch
   is unexercised. The SHA-256 copies of both branches *are* covered — RFC 5869
   case 1 requests 42 bytes (`n = 2`, `hkdf_test.sfn:28`) and RFC 4231 case 6
   uses a 131-byte key (`hmac_sha256_test.sfn:52`). Unification makes the covered
   code and the uncovered code the *same* code. That is a security argument, not
   a cleanliness one.
2. **Two divergent copies is the drift risk this whole issue family exists to
   retire** — SFN-665 was filed because one of 15 copied test helpers had already
   drifted.
3. **It is the prerequisite for `TLS_AES_256_GCM_SHA384`** (§1), which both
   handshake state machines currently reject by name.

## 5. Recommended design

All new code in `capsules/sfn/crypto/src/hkdf.sfn`, which after SFN-663 is
already the home of `sha256_bytes` (`hkdf.sfn:28-145`). It gains one import,
`sha384_bytes` from `./sha384`. No cycle: `sha384.sfn` imports `./bits` and
`./sha512`; `sha512.sfn` imports `./bits`; neither imports `./hkdf`.

### 5.1 The five functions

```
// module-private
fn _hash_bytes(hash_len: int, msg: int[]) -> int[]     // 48 -> sha384_bytes, else sha256_bytes
fn _hmac_block_size(hash_len: int) -> int              // 48 -> 128, else 64

// exported from hkdf.sfn, capsule-internal (NOT re-exported from mod.sfn,
// matching the sha384_bytes precedent, sha384.sfn:52)
fn hmac_bytes(hash_len: int, key: int[], data: int[]) -> int[]
fn hkdf_extract(hash_len: int, salt: int[], ikm: int[]) -> int[]
fn hkdf_expand(hash_len: int, prk: int[], info: int[], length: int) -> int[]
```

Bodies are the existing SHA-256 bodies with five literals replaced:

| Was | Becomes |
|---|---|
| `64` (three sites in HMAC) | `_hmac_block_size(hash_len)`, hoisted to one `let b: int` |
| `sha256_bytes(x)` (three sites) | `_hash_bytes(hash_len, x)` |
| `length > 8160` | `length > 255 * hash_len` |
| `prk.length < 32` | `prk.length < hash_len` |
| `(length + 31) / 32` | `(length + hash_len - 1) / hash_len` |
| `32` zero-fill in extract | `hash_len` |

Each substitution is exact at both instantiations: `255 * 32 = 8160`,
`255 * 48 = 12240`, `(l + 32 - 1)/32 = (l + 31)/32`, `(l + 48 - 1)/48 = (l + 47)/48`.
The `msg.push(i & 255)` counter byte is unchanged and still cannot truncate,
because the output cap bounds `n` at 255.

### 5.2 The one behavioural change: fail closed on an unknown `hash_len`

`_hash_bytes` and `_hmac_block_size` must not silently default to SHA-256 for a
`hash_len` that is neither 32 nor 48. Each of `hmac_bytes`, `hkdf_extract` and
`hkdf_expand` opens with

```
if hash_len != 32 && hash_len != 48 { return []; }
```

mirroring `hkdf_expand_label` (`tls13_schedule.sfn:182`) and
`tls13_early_secret` (`:229`). Without it, a caller passing `64` would get an
HMAC that pads to 64 bytes and hashes with SHA-256 — a plausible-looking,
non-standard derivation, which is precisely the failure class the existing
fail-closed checks were written to prevent. This is the only intentional
semantic change in the refactor and it is a tightening.

### 5.3 The three public wrappers, unchanged in signature and behaviour

```
fn hmac_sha256_bytes(key: int[], data: int[]) -> int[] { return hmac_bytes(32, key, data); }
fn hkdf_sha256_extract(salt: int[], ikm: int[]) -> int[] { return hkdf_extract(32, salt, ikm); }
fn hkdf_sha256_expand(prk: int[], info: int[], length: int) -> int[] { return hkdf_expand(32, prk, info, length); }
```

`mod.sfn:33`'s re-export list and `mod.sfn:387`'s `hmac_sha256` hex wrapper are
untouched. The public `sfn/crypto` API does not move.

### 5.4 Deletions in `tls13_schedule.sfn`

`_hmac_sha384_bytes` (56), `_hkdf_sha384_expand` (46), `_hkdf_expand` (4) and
`_hkdf_extract` (15) all go — **121 lines**, the file dropping from 305 to ~185.
The import becomes `import { hkdf_expand, hkdf_extract } from "./hkdf";` and the
`sha384_bytes` import moves to `hkdf.sfn`. Call sites rewrite mechanically:
`_hkdf_expand(hash_len, …)` → `hkdf_expand(hash_len, …)` (`:215`),
`_hkdf_extract(hash_len, …)` → `hkdf_extract(hash_len, …)` (`:242`, `:252`,
`:268`). `_empty_transcript_hash` stays as-is — it is a constant table, not
composition logic. Net across the capsule: **about −100 lines.**

## 6. Blast radius: every call site

The full consumer set, from a repo-wide grep. This is small, and entirely inside
the capsule plus its tests.

| Symbol | Call sites |
|---|---|
| `hmac_sha256_bytes` | `mod.sfn:7` (import), `mod.sfn:33` (re-export), `mod.sfn:395` (hex wrapper), `tls13_handshake.sfn:48,279` (Finished MAC), `tls13_schedule.sfn:24,158`, `hkdf.sfn:221,256` (internal), `tests/hkdf_test.sfn:7,14` |
| `hkdf_sha256_extract` | `mod.sfn:33` (re-export), `tests/hkdf_test.sfn:21,35` |
| `hkdf_sha256_expand` | `mod.sfn:33` (re-export), `tls13_schedule.sfn:24,140`, `tests/hkdf_test.sfn:28,38,45,52` |
| `_hmac_sha384_bytes` | `tls13_schedule.sfn:116,157` — **file-local, no external caller** |
| `_hkdf_sha384_expand` | `tls13_schedule.sfn:139` — **file-local, no external caller** |

Beyond the capsule: `runtime/sfn/platform/tls.sfn:20-83` imports only the
handshake/record facade (`hs_*`, `tls13_*`, `aead_*`), never HMAC or HKDF. So the
runtime is unaffected by construction, and the only cross-module surface that
changes is `hkdf.sfn`'s export list gaining three capsule-internal names.

Because both handshake state machines pin `_hash_len() -> 32`
(`tls13_handshake.sfn:132`, `tls13_server_handshake.sfn:128`) and reject 0x1302
(`tls13_handshake.sfn:141-145`), **no shipped code path executes the SHA-384
ladder.** The production risk of the merge is confined to the SHA-256 path,
which is pinned by RFC 4231, RFC 5869 and RFC 8448 vectors.

## 7. Correctness gates

The oracle is the existing vector set, unedited. Per the issue: **if any vector
needs editing, stop.**

- `capsules/sfn/crypto/tests/hkdf_test.sfn` — RFC 4231 case 1 (HMAC), RFC 5869
  cases 1 and 3 (42-byte output ⇒ `n = 2`, covering the shared counter loop),
  plus the two fail-closed cases.
- `capsules/sfn/crypto/tests/hmac_sha256_test.sfn` — RFC 4231 cases 1-4 and 6;
  case 6's 131-byte key covers the shared key-shortening branch.
- `capsules/sfn/crypto/tests/tls13_schedule_test.sfn` — RFC 8448 §3 full SHA-256
  ladder; independently computed SHA-384 ladder + traffic key/iv; the
  invalid-length fail-closed cases.

Three additions the implementing issue should carry, all covering branches that
are unreachable-by-test *today* (§4.4) and become reachable-and-shared after the
merge:

1. **A SHA-384 HKDF-Expand vector with `length > 48`** (e.g. 96 bytes ⇒ `n = 2`),
   computed with `hashlib`/`hmac` the same way the existing SHA-384 vectors were.
   This is the first execution of the SHA-384 multi-block path in the project's
   history.
2. **A SHA-384 HMAC vector with a key longer than 128 bytes**, exercising
   key shortening at `B = 128`.
3. **Fail-closed assertions on the new generic entry points** for a `hash_len` of
   neither 32 nor 48 (§5.2), one per function.

Verification commands, exactly as the issue specifies:

```
make compile
build/bin/sfn test capsules/sfn/crypto/tests
sfn fmt --check capsules/sfn/crypto/src/hkdf.sfn capsules/sfn/crypto/src/tls13_schedule.sfn
```

`make compile` is not optional here despite this being a capsule change:
`sfn/crypto` is inside the runtime's dependency closure (§3.4), so the capsule
is rebuilt as part of every compiler binary.

## 8. Scope of the follow-on implementing issue

One issue, **M / 3 points, one PR**. Do not split: the generic core and its only
two consumers are the same edit, in two files, gated by one test run. Splitting
the core from `tls13_schedule.sfn`'s adoption would leave a dead generic layer
behind for a release with no caller — and per `.claude/rules/seed-dependency.md`
bundling is the default when a capability has a single consumer worked in the
same session. There is no seed gate either way (§3.4), so the split would buy
nothing at all.

**In scope**

- `hkdf.sfn`: add `sha384_bytes` import, `_hash_bytes`, `_hmac_block_size`,
  `hmac_bytes`, `hkdf_extract`, `hkdf_expand`; reduce the three public functions
  to wrappers; extend the export list with the three generic names.
- `tls13_schedule.sfn`: delete the four private functions; repoint the four call
  sites; update the module header comment, which currently says "Only the SHA-384
  HMAC/HKDF layer (block size 128, 48-byte output) is local, pending SFN-666"
  (`tls13_schedule.sfn:21-22`).
- The three test additions in §7.
- `docs/status.md` if it names the twin ladders.

**Out of scope**

- `mod.sfn`'s public export list and the TLS 1.3 key-schedule public API — both
  unchanged by construction.
- Wiring `TLS_AES_256_GCM_SHA384` into either handshake state machine. That is a
  separate, larger issue (transcript hash, `_hash_len()`, Finished MAC, suite
  gate, record layer) which this refactor unblocks but must not attempt.
- New hash families; any function-value or generics work.

## 9. Risks

- **Silent hash-length default.** The single largest failure mode is a
  `hash_len` that is neither 32 nor 48 falling through to SHA-256. Mitigated by
  the explicit guard in §5.2 and its regression tests; the guard is not
  optional and must not be "simplified away" as unreachable.
- **Constant-substitution arithmetic.** `255 * hash_len` and
  `(length + hash_len - 1) / hash_len` must reproduce `8160` / `12240` and the
  two ceil-divs exactly. Verified above; re-verify by inspection during review
  rather than trusting the vectors alone, since the 12240 bound is not exercised
  by any vector.
- **Changing the SHA-256 path to fix the SHA-384 path.** The merge rewrites
  code that *is* in production to fix code that is not. This is the reason the
  vectors must pass unedited, and the reason this issue is sequenced after the
  purely mechanical SFN-662/663/664.
- **`hkdf.sfn`'s dependency closure widens** to include `sha384.sfn` →
  `sha512.sfn`. No new work at capsule scope (both are already compiled for
  `rsa.sfn`, `ecdsa.sfn` and `ed25519.sfn`), but it adds a module-graph edge on a
  file that is on the compiler build's critical path. If per-module emit ordering
  ever makes this measurable, the alternative placement is a new `hmac.sfn`
  importing both digest modules, with `hkdf.sfn` delegating — viable now that
  SFN-663 has settled `sha256_bytes`'s home, and cycle-free.
- **Timing.** All of this is public-data derivation over public transcript
  hashes and derived secrets; the dispatch branch is on `hash_len`, a public
  cipher-suite property, never on key material. The refactor introduces no
  secret-dependent control flow.

## 10. References

- SFEP-0048: `docs/proposals/0048-native-crypto.md` (Phase D).
- Sibling design notes: `docs/proposals/design-notes/sfn-335-x25519-limb-strategy.md`,
  `docs/proposals/design-notes/sfn-653-p256-rsa-bigint-strategy.md`.
- Seed-dependency policy: `.claude/rules/seed-dependency.md` (the runtime-source
  carve-out).
- RFC 2104 (HMAC): <https://www.rfc-editor.org/rfc/rfc2104>.
- RFC 4231 (HMAC-SHA-2 test vectors): <https://www.rfc-editor.org/rfc/rfc4231>.
- RFC 5869 (HKDF), §2.2-2.3 and appendix A:
  <https://www.rfc-editor.org/rfc/rfc5869>.
- RFC 8446 (TLS 1.3) §7.1 key schedule and §B.4 cipher suites:
  <https://www.rfc-editor.org/rfc/rfc8446#section-7.1>.
- RFC 8448 (TLS 1.3 traces) §3: <https://www.rfc-editor.org/rfc/rfc8448#section-3>.
- FIPS 180-4 (SHA-256/384/512): <https://doi.org/10.6028/NIST.FIPS.180-4>.
