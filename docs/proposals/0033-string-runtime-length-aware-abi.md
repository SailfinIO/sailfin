---
sfep: 0033
title: Length-aware ({i8*, i64}) ABI for query-side string runtime helpers
status: Implemented
author: "agent:compiler-architect"
created: 2026-06-26
updated: 2026-07-24
tracking: [1704]
graduates-to: TBD
---

> **As-built note (#1704, one cohesive PR).** The implementation that shipped
> took a deliberately *smaller* path than §4–§5 below; the analysis there
> remains the design record, but the delivered change differs as follows:
>
> 1. **`string.length` / `sfn_str_len` / the coercion shim are untouched.** No
>    `_sfn_str_len_ptr` rename. The circular dependency (§2.1) is avoided by
>    *construction* — we simply never flip `string.length` to the aggregate.
>    Aggregate `.length` already reads field 1 directly via the fast path in
>    `core_member_lowering.sfn:838`, so a non-owning slice is `.length`-safe with
>    no helper change. For the bare-`i8*` operand length-recovery at the
>    reworked `==`/`<` call sites, the existing `@sfn_str_len` is reused.
> 2. **Bare bodies are kept verbatim as the seed/extern trampolines** (not
>    rewritten to forward to `_lv`). `sfn_str_eq` / `sfn_str_cmp` / `codepoint` /
>    `grapheme_count` / `grapheme_at` keep their current `strnlen` bodies; the new
>    length-aware logic lives in additive `*_lv` siblings. `rlimit.sfn`'s
>    `extern fn sfn_str_eq(i8*, i8*)` binds the unchanged trampoline — no edit.
> 3. **`byte_at` / `find_byte` are re-signatured in place** (Class A — no
>    descriptor, no caller).
> 4. **New declare-only descriptors** `string.eq_lv` / `string.cmp_lv` were
>    required: the hardcoded `==`/`<` sites emit `@sfn_str_eq_lv` / `@sfn_str_cmp_lv`
>    directly, and the post-lowering line scan
>    (`collect_runtime_helper_targets_from_lines`) needs a descriptor to map the
>    emitted symbol → a `declare`. Without them, new-compiler-emitted IR carries
>    an undefined `@sfn_str_eq_lv` (caught only when the *new* compiler emits a
>    string compare — the seed-only first `make compile` pass masks it).
> 5. **No split.** Delivered as one self-host-safe PR (the trampolines make all
>    three classes safe in a single pass); the §8 3-PR split was the alternative.
>    The only seed-gated follow-up remains the trampoline-deletion cleanup.


# Length-aware string runtime helper ABI (#1704)

> Design record for migrating the *query-side* string runtime helpers off the
> bare-`i8*` + `strnlen` ABI onto the length-carrying `{i8*, i64}` (SfnString)
> aggregate, so they consume the carried `len` instead of scanning for NUL.
> This unblocks a sound non-owning `string.slice` (#1454): an interior view is
> not NUL-terminated, so every `strnlen`-based consumer over-reads.

## 1. Summary

Eight runtime helpers in `runtime/sfn/string.sfn` currently take a bare data
pointer and recover length with `strnlen(real, 16 MiB)`:

| helper | line | current sig | reached how |
|---|---|---|---|
| `sfn_str_len` | 307 | `(s: * u8) -> i64` | compiler-emitted: `s.length`, the `i8*→{i8*,i64}` coercion shim, numeric→string chain |
| `sfn_str_eq` | 328 | `(a, b: * u8) -> bool` | compiler-emitted: hardcoded `==`/`!=`; plus an `extern` in `rlimit.sfn` |
| `sfn_str_cmp` | 411 | `(a, b: * u8) -> i32` | compiler-emitted: hardcoded `<`/`<=`/`>`/`>=` |
| `sfn_str_grapheme_count` | 756 | `(s: * u8) -> f64` | compiler-emitted via descriptor `native_signature` |
| `sfn_str_grapheme_at` | 769 | `(s: * u8, idx: f64) -> * u8` | compiler-emitted via descriptor `native_signature` |
| `sfn_str_byte_at` | 790 | `(s: * u8, idx: i64) -> i64` | **runtime-internal only — no compiler emission site** |
| `sfn_str_find_byte` | 803 | `(s, bv: i64, start: i64) -> i64` | **runtime-internal only — no compiler emission site** |
| `sfn_str_codepoint` | 825 | `(s: * u8) -> f64` | compiler-emitted via descriptor `native_signature` |

The exemplar is `sfn_str_concat` (string.sfn:649), already on the aggregate ABI:
it takes the aggregate **exploded** as scalar pairs `(a_data: * u8, a_len: i64,
…)` and returns `-> SfnString` (compiler-recognized name → `{i8*, i64}`,
`type_mapping.sfn:528,634`).

**Headline finding: the "size M, mechanically mirror concat" framing is wrong.**
The helpers fall into three sharply different risk classes, and the two
genuinely-thorny ones (`eq`, `cmp`, `len`) are entangled by a circular
dependency and a hard seed-ABI cutover that concat did **not** face in the same
form. The accessors (`byte_at`, `find_byte`, `codepoint`, `grapheme_*`) are
nearly free. Recommendation: **split into 3 PRs** (details in §8).

## 2. Verified landmines

Each claim from the issue was re-checked against source. Findings:

### 2.1 Circular dependency — CONFIRMED, and worse than stated

The `i8* → {i8*, i64}` coercion shim recovers length by calling
`emit_runtime_call("string.length", [i8*-operand], …)` at **three** sites:
`core_operands.sfn:941` (the `i8*→{i8*,i64}` shim), `:1009` and `:1071` (the
`double→{i8*,i64}` and `i64→{i8*,i64}` numeric chains), plus
`core_member_lowering.sfn:871` (the `s.length` member access). The
`string.length` descriptor (`runtime_helpers.sfn:1195`) is
`parameter_types: ["i8*"]`.

If `string.length`'s `parameter_types` flips to `["{i8*, i64}"]`, then the
shim's own `i8*` operand needs an `i8*→{i8*,i64}` coercion **to build the call
to `string.length`** — which re-enters this exact shim. Unbounded recursion in
the lowering. **Confirmed circular.**

### 2.2 Hardcoded call sites — CONFIRMED

`==`/`!=` emit `call i1 @sfn_str_eq(i8* …, i8* …)` literally at
`core_operands.sfn:124–129`; `<`/`<=`/`>`/`>=` emit
`call i32 @sfn_str_cmp(i8* …, i8* …)` at `:197–202`. Both blocks
`extractvalue …, 0` the data pointer out of any `{i8*, i64}` operand and
**discard the length** (`:104–122`, `:177–195`). These do **not** route through
`coerce_and_emit_call` / `helper_descriptor`, so the `native_signature`
indirection that saved concat does **not** apply to them. They are
hand-emitted and must be hand-edited.

### 2.3 Raw extern caller in rlimit.sfn — CONFIRMED, sole instance

`runtime/sfn/platform/rlimit.sfn:93` declares `extern fn sfn_str_eq(a: * u8,
b: * u8) -> bool` with a comment (lines 86–92) explicitly stating it relies on
`sfn_str_eq` being genuinely `(i8*, i8*)` — it deliberately bypasses the
prelude `strings_equal` (which lowers to `({i8*,i64},{i8*,i64})` and would read
garbage length fields from a `(* u8, * u8)` call). A grep across the whole tree
confirms **this is the only `extern fn sfn_str_*` caller** of any of the eight
helpers (`sfn_str_cmp`, `sfn_str_len`, and the accessors have zero externs).

### 2.4 Seed cutover — CONFIRMED, and the mechanism is now pinned exactly

The pinned seed is `0.7.0-alpha.49` (`.seed-version`); `compiler/capsule.toml`
is also `0.7.0-alpha.49`. During `make compile`, the build driver
(`cli_main.sfn:_compile_runtime_sfn_sources`, line 1420) emits **every runtime
`sfn-source`** — including `runtime/sfn/string.sfn` — using
`_resolve_self_path(binary_dir)` (line 1454), i.e. **the binary doing the
build**. For the first self-host pass that binary is the *seed*. Therefore:

> During `make compile`, the seed compiles BOTH `compiler/src/*.sfn` (emitting
> OLD-ABI `@sfn_str_eq(i8*,i8*)` / `@sfn_str_len(i8*)` calls from its own
> hardcoded lowering at 2.2) AND `runtime/sfn/string.sfn` (emitting whatever
> the *new source body* declares). They link into one binary.

So if the new `sfn_str_eq` body is re-signatured to 4 args under the **same
symbol**, the seed emits `define i1 @sfn_str_eq(i8*, i64, i8*, i64)` from the
runtime source while simultaneously emitting `call i1 @sfn_str_eq(i8*, i8*)`
from compiler/src — an arity/ABI mismatch at link or a silent miscompile.
**The claim is correct and load-bearing.**

By contrast, the `make check` seedcheck/stage2/stage3 passes use the
*first-pass* binary (NEW ABI) to emit both compiler/src and runtime, so they
are internally ABI-consistent — the hazard is **exclusively the first-pass
`make compile`** boundary.

#### How concat actually handled this (the correct precedent)

The `runtime_helpers.sfn:1197–1226` comment documents concat's path: it never
re-signatured the bare `sfn_str_concat` symbol *out from under* live seed IR in
one step. It introduced the new ABI under a **distinct symbol** (`_arena`
suffix) so the new body coexisted with the seed's 2-arg `@sfn_str_concat`
emission; a later seed bump promoted the arena body to the bare name and
retired the 2-arg forwarder. **The general rule the codebase already encodes:
a runtime body's ABI may only be re-signatured under the bare symbol once the
*pinned seed* emits the matching call shape.** The `native_signature` field
(`rendering.sfn:287–300`, `core_call_emission.sfn:1286–1298`) is the lever that
lets freshly-emitted IR target a new symbol while seed IR keeps hitting the old
one.

## 3. Three risk classes

**Class A — runtime-internal only (trivial, zero seed exposure):**
`sfn_str_byte_at`, `sfn_str_find_byte`. Verified: **no file under
`compiler/src` references these symbols** (grep clean); the compiler's own
`byte_at`/indexing lowers through `substring_unchecked`, not these. They are
emission targets reached only from other runtime bodies and are compiled by the
same compiler that compiles their callers. Their signature can change freely in
one PR — the only constraint is internal consistency within the runtime
sources, which always recompile together.

**Class B — descriptor-routed accessors (low risk):**
`sfn_str_codepoint`, `sfn_str_grapheme_count`, `sfn_str_grapheme_at`. Reached
via descriptors whose `native_signature` is already set
(`runtime_helpers.sfn:782, 1324, 1327/1330`) and which carry a
`c_abi_return_type: "double"` post-call coercion (`core_call_emission.sfn:1331–
1343`). Because the call site is descriptor-routed, a **new symbol** strategy
(below) lets the new compiler retarget them while seed IR keeps hitting the old
symbol — exactly the concat pattern, and exactly what M2.5 already did to flip
these to `sfn_str_*`. Still, these participate in the seed boundary (the seed
emits old-symbol calls during `make compile`), so they need the trampoline
discipline of §5.

**Class C — hardcoded, externed, circular (high risk):**
`sfn_str_eq`, `sfn_str_cmp`, `sfn_str_len`. All three are hand-emitted (2.2) or
sit at the center of the coercion shim (2.1); `sfn_str_eq` is also externed
(2.3). This is the genuinely hard PR.

## 4. Resolving the circular dependency (chosen approach)

**Chosen: do NOT flip `string.length`'s descriptor to take `{i8*, i64}`. Keep
a data-pointer length-recovery path as a named bootstrap bridge, and give the
length-aware body a new symbol.**

Rationale: the coercion shim's *job* is to manufacture a length for an `i8*`
that has none. That operation is irreducibly "given a bare pointer, scan to find
length" — it cannot consume a length it is trying to produce. Forcing it
through a `{i8*, i64}` `string.length` is a category error. So:

1. Introduce `_sfn_str_len_ptr(s: * u8) -> i64` in `runtime/sfn/string.sfn` —
   the **current** `sfn_str_len` body verbatim (immediate-codepoint classify →
   `strnlen`). This is the bootstrap NUL-scan bridge. It is runtime-internal
   (Class A discipline): no descriptor, no seed exposure.
2. Repoint the `string.length` descriptor's `native_signature` from
   `sfn_str_len` to `_sfn_str_len_ptr`. The coercion shim and `s.length` keep
   emitting a `(i8*) -> i64` call; only the target symbol moves. **No shim edit,
   no recursion.** This is byte-identical behavior to today.
3. The new length-*aware* `sfn_str_len` — if we even want one — becomes a
   separate `(data: * u8, len: i64) -> i64` identity-ish helper. **In practice
   `string.length` over a length-carrying aggregate never needs a runtime call
   at all**: the length is field 1 of the aggregate. The real win for `.length`
   is to make the aggregate fast-path (extractvalue field 1) the *only* path and
   delete the `i8*` length-recovery call entirely — but that is the SfnString
   flip (#1283), out of scope here. For #1704 we keep `.length` exactly as-is
   via `_sfn_str_len_ptr` and stop touching `sfn_str_len`.

This **breaks the cycle without a new keyword, without a shim edit, and without
changing observable `.length` behavior.** It also removes `sfn_str_len` from the
critical path of this issue entirely (it stays as a now-unreferenced legacy
body the SfnString flip retires).

## 5. Per-helper design

Naming convention for the length-aware bodies: suffix `_lv` ("length-viewed")
on a **new symbol**, mirroring concat's `_arena` precedent. The new compiler
emits `_lv` via `native_signature`; the seed keeps emitting the bare old symbol,
which survives the cutover as a **trampoline** that forwards to `_lv` by
recovering length with `_sfn_str_len_ptr`. After a seed bump that ships the new
compiler, a follow-up PR retires the trampolines and may rename `_lv` → bare.

### 5.1 Class A — `byte_at`, `find_byte` (this PR, no trampoline)

Re-signature the bodies in place; no new symbol, no descriptor (there is none),
no trampoline:

- `sfn_str_byte_at(data: * u8, len: i64, idx: i64) -> i64` — drop the
  `strnlen`; bound `idx` against `len`; read via `sfn_str_read_byte`. Immediate
  decode still applies (an immediate has `len` describing its UTF-8 width — the
  caller computes it).
- `sfn_str_find_byte(data: * u8, len: i64, bv: i64, start: i64) -> i64` — same,
  forward scan bounded by `len`.

Because no compiler site emits these and no other runtime module calls them with
the old arity (grep-confirmed §3), the runtime recompiles self-consistently in
one pass under any binary. **Safe in the #1704 PR with zero seed concern.**

> Caveat to verify at implement time: the e2e test
> `runtime_string_utf8_numeric_test.sfn:94–95,174–175` asserts
> `@sfn_str_byte_at(` / `@sfn_str_find_byte(` appear as *defines* in the emitted
> `string.sfn` IR and as symbols in the binary. Re-signaturing keeps the symbol
> name, so those assertions still hold; no test churn needed beyond the new
> interior-view coverage (§9).

### 5.2 Class B — `codepoint`, `grapheme_count`, `grapheme_at`

New bodies `sfn_str_codepoint_lv(data, len)`,
`sfn_str_grapheme_count_lv(data, len)`,
`sfn_str_grapheme_at_lv(data, len, idx: f64)`, each consuming `len` instead of
`strnlen`. Keep the `f64`/`double` return ABI byte-for-byte so the
`c_abi_return_type: "double"` coercion is untouched.

Descriptor edits (`runtime_helpers.sfn`):
- `runtime_char_code_fn` (:782): `native_signature` `sfn_str_codepoint` →
  `sfn_str_codepoint_lv`; `parameter_types` `["i8*"]` → `["{i8*, i64}"]`;
  `return_type`/`c_abi_return_type` unchanged.
- `runtime_grapheme_count_fn` (:1324): `native_signature` →
  `sfn_str_grapheme_count_lv`; `parameter_types` → `["{i8*, i64}"]`.
- `runtime_grapheme_at_fn` (:1327) **and** `grapheme_at` (:1330):
  `native_signature` → `sfn_str_grapheme_at_lv`; `parameter_types` →
  `["{i8*, i64}", "double"]`.

Old-symbol trampolines (in `runtime/sfn/string.sfn`), so seed-emitted
`@sfn_str_codepoint(i8*)` etc. from `make compile` still link:
- `sfn_str_codepoint(s: * u8) -> f64 { return sfn_str_codepoint_lv(s,
  _sfn_str_len_ptr(s)); }`
- analogous for `sfn_str_grapheme_count`, `sfn_str_grapheme_at`.

The trampoline path is exactly today's behavior (recover length by scan, then
operate), so the first-pass binary is byte-equivalent; the *new* compiler's
freshly-emitted IR uses the aggregate `_lv` path.

> ABI note to verify at implement: `c_abi_return_type: "double"` interacts with
> the post-call `round + fptosi` coercion (`runtime_int_helpers_test.sfn:90–110,
> 134–149`). The unit tests pin the emitted line as
> `call double @sfn_str_codepoint(i8* %s)`. After this PR the new compiler emits
> `call double @sfn_str_codepoint_lv({i8*, i64} …)`. **These unit tests will
> need updating** to the `_lv` symbol and aggregate operand — include them in
> the PR.

### 5.3 Class C — `eq`, `cmp` (the hard PR), and `len` (made a non-issue by §4)

`len`: handled by §4 — repoint `string.length.native_signature` to
`_sfn_str_len_ptr`, leave `sfn_str_len` untouched/legacy. No length-aware
`sfn_str_len` is emitted for `#1704`. **This removes `sfn_str_len` from scope.**

`eq` / `cmp`: introduce length-aware bodies and rework the hardcoded call sites.

New bodies:
- `sfn_str_eq_lv(a_data: * u8, a_len: i64, b_data: * u8, b_len: i64) -> bool`
- `sfn_str_cmp_lv(a_data: * u8, a_len: i64, b_data: * u8, b_len: i64) -> i32`

  Both drop all four `strnlen` calls (string.sfn:337,342,345,346 for eq;
  420,425,431,432 for cmp), using the passed `a_len`/`b_len`. The immediate
  arms are unchanged (they never deref). The real-vs-real arms use the carried
  lengths directly: `if a_len != b_len return false; memcmp(a, b, a_len)` (eq);
  `m = min(a_len, b_len); memcmp` + length tie-break (cmp). The decode-owned
  call-seq bump is preserved for parity.

Hardcoded call-site rework (`core_operands.sfn`):
- The `==`/`!=` block (124–129) and `<`/`<=`/`>`/`>=` block (197–202) currently
  `extractvalue …, 0` only the data pointer. Replace each with extraction of
  **both** fields. For a `{i8*, i64}` operand: extract field 0 (data) and field
  1 (len). For a bare-`i8*` operand (literal-vs-local mixed case the comment at
  100–101 calls out), recover len via the **`_sfn_str_len_ptr` path** — i.e.
  emit a `call i64 @_sfn_str_len_ptr(i8* …)` (or, cleaner, route through the
  `i8*→{i8*,i64}` coercion shim *before* the compare so both operands are
  aggregates, then extract both fields uniformly). Then emit
  `call i1 @sfn_str_eq_lv(i8* %ad, i64 %al, i8* %bd, i64 %bl)` /
  `call i32 @sfn_str_cmp_lv(...)`.

  Recommended concretely: **pre-coerce both operands to `{i8*, i64}` via the
  existing coercion path** at the top of each block, then a uniform
  two-`extractvalue` per operand. This reuses the already-correct length
  recovery (`_sfn_str_len_ptr` after §4) and avoids a second hand-rolled
  strlen emission.

Old-symbol trampolines (`runtime/sfn/string.sfn`) for the seed boundary:
- `sfn_str_eq(a: * u8, b: * u8) -> bool { return sfn_str_eq_lv(a,
  _sfn_str_len_ptr(a), b, _sfn_str_len_ptr(b)); }`
- `sfn_str_cmp(a: * u8, b: * u8) -> i32 { return sfn_str_cmp_lv(a,
  _sfn_str_len_ptr(a), b, _sfn_str_len_ptr(b)); }`

These keep the seed's `@sfn_str_eq(i8*,i8*)` / `@sfn_str_cmp(i8*,i8*)` emission
(from `make compile`'s compiler/src pass) resolving to a real definition with
byte-identical behavior, while the new compiler emits the `_lv` calls.

`rlimit.sfn` (2.3): leave its `extern fn sfn_str_eq(a: * u8, b: * u8) -> bool`
**unchanged**. It binds to the old-ABI **trampoline**, which still exists and
still does the right thing. No edit to rlimit.sfn is required — the trampoline
is exactly the `(i8*, i8*)` symbol it depends on. (Document this in the rlimit
comment as a follow-up if desired, but no behavioral change.)

The `strings_equal` (:1266) and `string.compare` (:1272) descriptors:
`native_signature` is `sfn_str_eq` / `sfn_str_cmp`. The prelude `strings_equal`
body (runtime/prelude.sfn:623) is a **hand-written pure-Sailfin loop** that does
NOT call `sfn_str_eq`, so the descriptor redirect only matters for user code
that invokes the free function as an intrinsic. Leave these descriptors pointed
at the **trampoline** (`sfn_str_eq`/`sfn_str_cmp`) — they are reached via the
descriptor path with `parameter_types: ["i8*", "i8*"]`, so they must keep the
old ABI symbol. Do **not** flip them to `_lv` in this PR (that path's operands
are `i8*`, not aggregates). They retire with the SfnString flip.

## 6. Self-host-safe sequencing (the invariant)

The single hard rule, from §2.4: **in the `#1704` PR, every symbol the
*pinned seed* emits a call to must still resolve to a definition with the seed's
expected ABI.** The seed emits (from compiler/src during `make compile`):
`@sfn_str_eq(i8*,i8*)`, `@sfn_str_cmp(i8*,i8*)`, `@sfn_str_len(i8*)`,
`@sfn_str_codepoint(i8*)`, `@sfn_str_grapheme_count(i8*)`,
`@sfn_str_grapheme_at(i8*, double)` (via the seed's own descriptors), and
`@_sfn_str_len_ptr`? — **No.** The seed does *not* know `_sfn_str_len_ptr`;
it only emits what its own descriptors say. This is the subtlety that makes the
plan safe:

- The seed's `string.length` descriptor still says `native_signature:
  sfn_str_len`. So the **seed** emits `@sfn_str_len(i8*)` for `.length` in
  compiler/src. Therefore **the bare `sfn_str_len` symbol must still exist with
  `(i8*) -> i64` during `make compile`.** Under §4 we *renamed the new
  compiler's target* to `_sfn_str_len_ptr` but **must keep a bare `sfn_str_len`
  body** for the seed. Resolution: `_sfn_str_len_ptr` IS the new body;
  `sfn_str_len` stays as a one-line trampoline `return _sfn_str_len_ptr(s);`.
  Both symbols defined, both `(i8*) -> i64`. The new compiler emits
  `@_sfn_str_len_ptr` (via the repointed descriptor); the seed emits
  `@sfn_str_len`; both link. ✓

- Likewise `sfn_str_eq`, `sfn_str_cmp`, `sfn_str_codepoint`,
  `sfn_str_grapheme_count`, `sfn_str_grapheme_at` all keep their bare
  old-ABI **trampoline** bodies (§5.2, §5.3). The seed emits the bare symbols;
  the trampolines satisfy them. ✓

- The new `_lv` bodies and `_sfn_str_len_ptr` are **additive new symbols** the
  seed never references but happily compiles (it just emits more defines). ✓

- The new compiler (first-pass) then compiles the seedcheck/stage2/stage3
  runtime+compiler together with the `_lv` ABI throughout — internally
  consistent. ✓

So **everything in §5 lands in ONE self-host-safe step per class**, with no
seed bump required, *provided* every old bare symbol retains a defined
old-ABI trampoline body. The seed bump is only needed for the **follow-up
cleanup PR** that deletes the trampolines and (optionally) renames `_lv` → bare
— that PR requires the seed to already emit `_lv` calls, i.e. it must wait until
a release ships this compiler and `.seed-version` advances.

**Concretely: nothing in #1704 must wait for a seed bump. The trampolines are
the bridge.** The cleanup is a separate, later, seed-gated PR.

## 7. Why "mirror concat" undersells it

Concat was a **producer** returning `-> SfnString`; its callers
(`a + b`) were descriptor-routed, so `native_signature` alone retargeted them,
and its old 2-arg ABI was bridged by a C trampoline that already existed.
The query helpers add three things concat never had to solve in one issue:

1. A **circular dependency** through the coercion shim (§2.1) — concat is not on
   the length-recovery path.
2. **Hand-emitted, non-descriptor call sites** for `eq`/`cmp` (§2.2) that
   `native_signature` cannot retarget — they need source edits in
   `core_operands.sfn`, with the literal-vs-local mixed-aggregate case to handle.
3. A **raw extern consumer** (`rlimit.sfn`, §2.3) pinned to the exact old ABI.

None of these are "mechanical." The accessors (Class A/B) *are* roughly
mechanical; the `eq`/`cmp`/`len` cluster is not.

## 8. Scope recommendation: split into 3 PRs (size M is wrong for the whole)

| PR | helpers | size | seed concern | notes |
|---|---|---|---|---|
| **PR-1** | `byte_at`, `find_byte` (Class A) | **S** | none | bodies re-signatured in place; no descriptor, no trampoline, no compiler edit. Lowest risk; lands first to validate the interior-view test harness (§9). |
| **PR-2** | `codepoint`, `grapheme_count`, `grapheme_at` (Class B) | **M** | trampolines | new `_lv` bodies + 4 descriptor edits + 3 trampolines; update `runtime_int_helpers_test.sfn` symbol/operand assertions. |
| **PR-3** | `eq`, `cmp` + the `string.length` rename to `_sfn_str_len_ptr` (Class C) | **M (hard)** | trampolines | new `_lv` bodies + the two hardcoded `core_operands.sfn` call-site reworks + the `string.length` descriptor repoint + 3 trampolines (`eq`/`cmp`/`len`). Highest blast radius; lands last. |

A later **PR-4 (seed-gated)** deletes all trampolines and renames `_lv` → bare
once `.seed-version` ships a compiler that emits `_lv`. This is the only
seed-cut-gated piece and queues against the cadence (per
`.claude/rules/seed-dependency.md`), not reactively.

The issue as written ("one M PR, mirror concat") would either (a) under-scope and
miss the circular dependency / hardcoded sites and fail `make compile`, or
(b) balloon into an L. **Recommend re-grooming #1704 into PR-1/PR-2/PR-3 above,
with PR-3 carrying the `#1454` unblock as its acceptance driver.** Per
`.claude/rules/seed-dependency.md`, none of PR-1..3 force a seed cut (trampolines
keep the old ABI live), so the split does NOT manufacture a seed-cut tax — it is
a genuine risk/independence split, which the rule permits.

## 9. Test plan

For each migrated helper, a **non-NUL-terminated interior-view** regression that
the old `strnlen` path would fail. Until `string.slice` returns a real
non-owning view (#1454), synthesize the hazard directly: allocate a buffer
`"abcXYZ"`, hand the helper `(data + 0, len = 3)` so byte 3 is `'X'` (no NUL at
offset 3), and assert the helper respects `len` rather than scanning into
`"XYZ"`.

- `byte_at`: `(view, len=3, idx=3)` → -1 (out of range), not `'X'`.
- `find_byte`: `find_byte(view, len=3, 'X', 0)` → -1 (the `X` is past `len`).
- `codepoint`: only reads index 0; add a length-0 interior view → -1.
- `grapheme_count`: `(view, len=3)` → 3, not 6.
- `grapheme_at`: `(view, len=3, idx=3)` → empty, not `'X'`.
- `eq`: `eq(view3, "abcZZZ"-view3, ...)` where the two 3-byte views share a
  prefix but differ at byte 2 within `len`, and are *equal* in their first 3
  bytes despite different trailing bytes → asserts length-bounded compare.
- `cmp`: two interior views with a shared prefix and different `len` → ordering
  by carried length, not by trailing garbage.

Implement these as `*_test.sfn` building a small fixture (per
`.claude/rules/no-bash-e2e.md`) or as unit tests over the emitted IR + a linked
C harness that calls the `_lv` symbol with a deliberately non-terminated buffer
(mirroring `runtime_memory_arena_test.sfn`'s clang-harness pattern). Add:

- Update `compiler/tests/unit/runtime_int_helpers_test.sfn` (codepoint/grapheme
  emitted-line assertions) to the `_lv` symbol + aggregate operand (PR-2/PR-3).
- Keep `runtime_string_utf8_numeric_test.sfn`'s define/symbol assertions green;
  add `_lv` define assertions.
- A `make compile` self-host run is the binding gate for PR-2/PR-3 (the seed
  boundary cannot be proven by `sfn check`).

## 10. Effect & capability impact

None. These are runtime ABI bodies with no effect surface; the runtime capsule
declares `required = []` (`runtime/capsule.toml:10`). No `![...]` annotation
changes.

## 11. Self-hosting impact

Analyzed exhaustively in §6. Net: **PR-1/2/3 are each self-host-safe in a single
PR with no seed bump**, because every bare old symbol retains a defined old-ABI
trampoline the pinned seed (alpha.49) links against during the first-pass
`make compile`, while the new compiler emits the `_lv` ABI for the
seedcheck/stage2/stage3 passes. The only seed-gated work is the trampoline-
deletion cleanup (PR-4), which queues against the cadence.

## 12. Alternatives considered

- **Flip `string.length` to `{i8*, i64}`** (the issue's hinted option): rejected
  — it is the source of the circular dependency (§2.1) and buys nothing here,
  since `.length` over an aggregate should read field 1 directly (a #1283
  concern), not call a runtime helper.
- **Re-signature bare symbols in place under one symbol** (the naive
  "mirror concat" read): rejected — breaks `make compile` at the seed boundary
  (§2.4), since the seed emits old-ABI calls against the re-signatured body.
- **One big PR**: rejected — conflates trivial Class A with the hard Class C and
  risks an L-sized change that fails self-host late; the 3-way split isolates
  the circular-dependency / hardcoded-site risk in PR-3.

## References

- Issue #1704 (this work); #1454 (sound non-owning `string.slice`); #1283
  (SfnString aggregate flip); #1318/#714/#715 (concat ABI precedent).
- `runtime/sfn/string.sfn:296–833` (target helpers + concat exemplar).
- `runtime/sfn/platform/rlimit.sfn:86–93` (the raw extern caller).
- `compiler/src/llvm/expression_lowering/native/core_operands.sfn:124–129,
  197–202` (hardcoded eq/cmp), `:900–1096` (coercion shim, circular dep).
- `compiler/src/llvm/expression_lowering/native/core_member_lowering.sfn:854–887`
  (`s.length`).
- `compiler/src/llvm/runtime_helpers.sfn:1195` (string.length), `:782, 1324,
  1327, 1330` (accessor descriptors), `:1266, 1272` (strings_equal/compare).
- `compiler/src/llvm/rendering.sfn:287–300`,
  `core_call_emission.sfn:1286–1298, 1331–1343` (native_signature /
  c_abi_return_type machinery).
- `compiler/src/cli_main.sfn:1420–1473` (`_compile_runtime_sfn_sources`,
  `self_path` runtime emit); `Makefile:514–563` (compile vs seedcheck passes).
- `.seed-version` = 0.7.0-alpha.49; `compiler/capsule.toml` = 0.7.0-alpha.49.
