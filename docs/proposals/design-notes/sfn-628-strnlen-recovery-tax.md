# SFN-628 — Measuring the `sfn_str_len` recovery tax

> Sibling design note to `sfn-460-string-view-consumer-surface.md`. Measurement
> only; no lowering code changed. Answers the P1-vs-P2 gate left open by that
> note's §5, and **supersedes its §4 figures**.

## 1. Verdict

**Material.** Groom carry-length-everywhere (SFN-460 §5 "P1") as an epic and
absorb SFN-43 into it.

But the evidence points at a **different target than §4 named**. The tax is not
a diffuse per-token cost spread over the parser's token-comparison surface. It
is a **quadratic blow-up concentrated in five machine instructions in the
lexer**, and the parser surface §4 singled out is negligible. An epic scoped
from §4's conclusions would optimise the wrong code.

**How the measured cost splits across the recommendation.** Of the 39.3 GB
scanned, ~97.8% is the lexer and ~0.6% is the prelude re-scan path; of the 84.1M
calls, ~58% is the prelude re-scan and ~48.7% flows through `_dr_split_lines`.
§8 sends the prelude re-scan *outside* this epic (§5.C — it is redundant
repetition, not length re-derivation), which is most of the call volume. What
stays inside the epic is the lexer's bytes (§5.A, and §5.A.1 establishes it is
genuinely carry-length work) plus the per-character helper returns (§5.B). That
is the honest allocation: **the epic owns nearly all the bytes and roughly half
the calls; a separately-tracked defect owns the rest of the calls.**

There are also **two** root-cause mechanisms, not the one §4 described: the
struct-field demotion (dominates bytes) and bare-`i8*` runtime-helper returns
that discard a length already known at the call site (dominates call count).

Three findings drive the verdict:

- Length recovery is **16.1%–34.5% of all executed instructions** in a
  front-end `sfn check`, rising with input size.
- Bytes scanned grow as **Θ(n²)** in source-file size (floor-subtracted exponent
  converging to 2.0). A 1 MB source file would scan ~1.7–2.9 TB and spend
  ~30–50 s in `strnlen` alone, depending on whether real-source or synthetic
  scaling holds.
- A further **58% of front-end call volume** is the runtime symbol scan
  re-walking `runtime/**` once per checked file — a separate, **unblocked**
  defect that should not be folded into this epic. Its source comment cites a
  codegen blocker that measurement showed is stale (§5.C).

## 2. Method

All measurements against the **shipped 0.8.4 seed binary**
(`build/toolchains/seed/versions/0.8.4/sailfin`), i.e. what users actually run,
not a locally patched compiler. Linux x86_64, 4 cores, glibc `__strnlen_avx2`.

Three independent instruments:

1. **`LD_PRELOAD` interposer on `strnlen`** — counts every call, bytes scanned,
   a log2 size histogram, and the return address of each call site. `strnlen`
   is an undefined dynamic symbol in the binary (`nm -D` confirms), so
   interposition is complete. Return addresses resolve against the binary's
   3,171 symbols; `sfn_str_len` is always inlined by LLVM, so attribution lands
   on the *enclosing Sailfin function*, which is what we want.
2. **`valgrind --tool=callgrind`** — exact instruction counts, deterministic, no
   sampling error. Run with `SAILFIN_MEM_LIMIT=unlimited` (valgrind is
   incompatible with a finite `RLIMIT_AS`, per `.claude/rules/compiler-safety.md`).
3. **Bandwidth calibration** — a microbenchmark replaying the measured size
   distribution, to convert bytes-scanned into wall time.

Workload: `sfn check compiler/capsules/syntax/src/parser/*.sfn` (7 files, 8,436 lines) — the
front end only (parse + typecheck + effect-check, no IR, no codegen).

**Two artifacts are mixed.** All *dynamic* measurement is against the 0.8.4 seed
binary; the *static* IR counts in §3 come from a working-tree `make compile`, and
§3.1 compares the two directly. Tree and seed are close but not identical, so
treat that one comparison as indicative.

**Uncertainty.** The callgrind figure is exact (instruction counts, not
samples). The wall-time figure is the soft one: calibration reuses one hot
buffer, so it models an L2-resident best case and, if anything, *understates*
the tax; and instruction share overstates time share slightly because
`strnlen` is AVX2-vectorised and retires at above-average IPC. The two methods
bracket the answer at 18%–21% on a 30 KB file, and they were derived
independently. Treat the *shape* (quadratic) as solid and the *constant* as
±20%.

## 3. Re-derived IR emission counts (supersedes SFN-460 §4)

Command (from `make compile`, 271 modules):

```bash
for f in build/native/raw/*.ll; do
  printf '%s\t%s\n' "$(grep -c 'call i64 @sfn_str_len' "$f")" "$(basename $f)"
done | sort -rn | head -20

# the total (head -20 above shows only the leaders)
cat build/native/raw/*.ll | grep -c 'call i64 @sfn_str_len'
```

**Total: 20,972 emitted `call i64 @sfn_str_len` sites across 271 modules.**

§4's four cited figures, checked:

| module | §4 claimed | re-derived | delta |
|---|---|---|---|
| `parser__expressions` | 209 | **146** | −30% |
| `parser__token_utils` | 157 | **81** | −48% |
| `closures` | 154 | **163** | +6% |
| `lambda_lowering` | 135 | **132** | −2% |

Two are close; the two parser figures are overstated by a third to a half. More
importantly, **none of these are the top emitters**. The actual top modules are:

| count | module |
|---|---|
| 827 | `llvm__expression_lowering__native__core_operands` |
| 659 | `llvm__expression_lowering__native__core_call_emission` |
| 514 | `typecheck_types` |
| 434 | `llvm__expression_lowering__native__core_concurrency_lowering` |
| 363 | `llvm__expression_lowering__native__core_literals_lowering` |

Count `call i64 @sfn_str_len`, not `@sfn_str_len` — the latter is one higher per
module, picking up the `declare` line. The §4 figures being superseded do not
state which they used.

### 3.1 Why the static count is the wrong instrument

`lexer.ll` emits **29** `sfn_str_len` call sites — below the 271-module mean of
77, and 1/28th of `core_operands`. At runtime it produces **97.8% of all bytes
scanned**.

Static emission count does not rank cost even approximately. One call site
inside a per-character loop dominates 827 cold ones. §4 ranked modules by
static count and concluded the parser was the hot path; it is not. Any future
sizing of this work must use dynamic measurement.

## 4. Where the time actually goes

Dynamic attribution, 7-file front-end check — **84,143,313 calls scanning
39,316,783,174 bytes (39.3 GB)** to check 8,436 lines. Top entries only — these
rows cover ~76% of calls; the rest is spread across 260-odd symbols:

| enclosing function | calls | % calls | bytes | % bytes |
|---|---|---|---|---|
| `lex__lexer` | 1,073,054 | 1.3% | 38,448,071,285 | **97.8%** |
| `_dr_split_lines__diagnostics_render` | 40,993,532 | **48.7%** | 240,474,626 | 0.6% |
| `sfn_str_concat` | 7,023,718 | 8.3% | 276,530,275 | 0.7% |
| `_ps_is_ident_char__prelude_scan` | 5,827,710 | 6.9% | 5,827,710 | 0.0% |
| `find_symbol__typecheck_types` | 5,166,632 | 6.1% | 82,900,300 | 0.2% |
| `split_lines__native_ir_utils_text` | 3,633,252 | 4.3% | 3,633,252 | 0.0% |
| `tokens_to_text__parser__token_utils` | 220,887 | 0.3% | 69,176,531 | 0.2% |
| **`identifier_matches` + `symbol_matches`** | **141,049** | **0.17%** | **812,280** | **0.002%** |

### 4.1 The issue's traced hot path is not hot

SFN-628's own premise — and SFN-460 §4's — was that `identifier_matches` /
`symbol_matches` (`parser/token_utils.sfn:68-84`), with 230 call sites across
the parser, are the dominant cost because "every token classification in the
language" pays them.

They are **0.17% of calls and 0.002% of bytes**. The call-site *count* is real
(230 confirmed; the issue's "232" is a raw-grep figure that includes the two
`fn` definition lines). The cost attributed to it is not. Static call-site
counting mis-ranked this the same way static IR counting did.

### 4.2 The real hot spot: five instructions in the lexer

Machine-level attribution inside `lex__lexer` (33 distinct machine-level sites —
more than `lexer.ll`'s 29 static IR sites because `sfn_str_len` and its callers
are inlined, so one IR site can become several machine sites):

| site | calls | bytes | % of all bytes |
|---|---|---|---|
| `lex__lexer+0xc5f` | 139,957 | 9,988,466,067 | 25.4% |
| `lex__lexer+0x2b9` | 105,820 | 7,686,638,092 | 19.6% |
| `lex__lexer+0x327` | 82,694 | 6,098,903,640 | 15.5% |
| `lex__lexer+0x1d1` | 62,968 | 4,361,305,181 | 11.1% |
| `lex__lexer+0x518` | 54,680 | 4,037,767,103 | 10.3% |

**Five call sites = 81.8% of all string-scanning work in the entire front end**
(83.7% of the lexer's own bytes), averaging ~71 KB scanned per call — i.e. each
one rescans the whole source buffer.

## 5. Root cause

There are **two** mechanisms, not one. SFN-460 §4 described only the first.

### 5.A Struct-field demotion — dominates *bytes* (the lexer)

The chain is short and entirely mechanical:

1. `compiler/capsules/syntax/src/lexer.sfn:10-11` — `struct LexerState { source: string; … }`.
2. `compiler/src/llvm/type_mapping.sfn:619` — `map_struct_field_annotation`
   demotes string-typed **struct fields** to bare `i8*` (deliberately, to keep
   field byte offsets stable), while scalars stay `{i8*, i64}`
   (`map_type_annotation`, `type_mapping.sfn:559-561`).
3. `compiler/capsules/syntax/src/lexer.sfn:422-439` — `slice(text: string, …)` and
   `byte_at(text: string, …)` take the source as a **scalar** `string`
   parameter.
4. **24 call sites** in `lexer.sfn` pass `state.source` — the bare-`i8*` field
   — into that scalar parameter (`grep -cE '(byte_at|slice)\(state\.source'`).
   The call boundary emits the `i8* → {i8*, i64}` coercion, whose
   length-recovery leg is `sfn_str_len` → `strnlen` over the **entire source
   buffer** (`runtime/sfn/string.sfn:274-277`) — the scan starts at offset 0,
   not at `state.index`, which is why the measured average is a full file
   length rather than a remaining-input length.
5. `byte_at` is called at least once per input character.

O(n) calls × O(n) scan each = **Θ(n²)**.

### 5.A.1 Passing the length as an extra parameter does **not** fix it

This is the most important negative result in the note, and it rules out the
obvious cheap fix.

`LexerState` **already carries the length as a field** — `source_len: int`
(`lexer.sfn:12`). And `_number_run_byte` (`lexer.sfn:406`) already takes it as
an explicit `source_len: int` parameter. Both facts suggest the scan should be
avoidable locally. The emitted IR says otherwise (`build/native/raw/lexer.ll:1418-1424`):

```llvm
  %t905 = extractvalue %LexerState %t904, 0     ; source      — bare i8*
  %t907 = extractvalue %LexerState %t906, 1     ; source_len  — already in hand, free
  %t910 = call i64 @sfn_str_len(i8* %t905)      ; …and strnlen'd anyway
  %t911 = insertvalue {i8*, i64} undef, i8* %t905, 0
  %t912 = insertvalue {i8*, i64} %t911, i64 %t910, 1
  %t913 = call i1 @_number_run_byte__lexer({i8*, i64} %t912, i64 %t907, i64 %t909)
```

The correct length is extracted for free and passed as the *second* argument,
while the *first* argument still pays a full whole-buffer `strnlen`. Same shape
at the other two call sites (`lexer.ll:1586-1592`, `:2059-2065`).

The scan is caused by the **parameter's declared type**, not by a missing
length. `source: string` is scalar, so a bare-`i8*` argument must be widened to
`{i8*, i64}`, and widening *is* the `strnlen`. No amount of threading a
`source_len` alongside it removes the scan.

**Consequence.** Removing the quadratic term requires changing the parameter
*type* off scalar `string` — a `*u8` + `i64` pair — or changing the struct-field
mapping. That is carry-length work, not a local tidy-up. `_number_run_byte` is
not a partial fix that merely needs generalising; it is a **worked example of
the fix not working**.

**Confidence.** The quadratic *measurement* (§6) is direct, and the mechanism is
now confirmed from emitted IR (above), not merely inferred. Two caveats remain:
the five hot offsets in §4.2 were resolved to the enclosing function
(`lex__lexer`) but **not mapped back to individual source call sites**, and **no
before/after experiment was run** — SFN-628 forbids changing lowering code, so
there is no A/B. The attribution is well-supported but the size of any fix's win
is unmeasured.

Other Mechanism-A instances: `SymbolEntry.name` (`typecheck_types.sfn:65-66`,
scanned per linear symbol-table probe in `find_symbol`) and `Token.lexeme`
(`token.sfn:17-19`, scanned once per token in `tokens_to_text`).

### 5.B Bare-`i8*` runtime returns — dominates *call count*

A second, independent mechanism the §4 audit did not identify. Several runtime
helpers that *manufacture a slice whose length is already known* are registered
with `return_type: "i8*"` — a bare pointer with no carried length:

| target | descriptor | native |
|---|---|---|
| `substring` | `runtime_helpers.sfn:1279` | `sfn_str_slice` |
| `substring_unchecked` | `runtime_helpers.sfn:1282` | `sfn_str_slice` |
| `grapheme_at` (the `s[i]` subscript) | `runtime_helpers.sfn:1423` | `sfn_str_grapheme_at_lv` |

The Sailfin-level declared return type is `string` = `{i8*, i64}`, so satisfying
it re-triggers the same coercion bridge and `strnlen`s the slice **that was just
created from a known length** (`end - start`). `grapheme_at` is the sharpest
case: its *parameters* are already `{i8*, i64}` and its native target is the
length-aware `_lv` variant, yet the length is discarded on the way out and
immediately rescanned.

Because these fire once per *character* rather than once per struct read, they
own the call-count side: `_dr_split_lines` (`diagnostics_render.sfn:292-325`,
`substring(source, index, index+1)` per character) alone is 48.7% of all calls.

### 5.C Why 41M calls happen on a check that reports no diagnostics

`_dr_split_lines` is not on the error path. It is the general line splitter
(`split_source_lines`, `diagnostics_render.sfn:327`), and the dominant caller is
the implicit-runtime symbol scan: `load_prelude_global_names`
(`prelude_globals.sfn:126`) reads `runtime/prelude.sfn` and BFS-walks every
`.sfn` under `runtime/sfn/**`, line-splitting each one character by character —
and it is called **once per checked file**.

Measured directly (N copies of one 3 KB file, single invocation):

| files | calls | bytes |
|---|---|---|
| 1 | 8,168,059 | 100,679,807 |
| 2 | 16,255,651 | 201,130,291 |
| 4 | 32,430,853 | 402,031,419 |
| 8 | 64,781,281 | 803,834,251 |

Exactly linear at **~8.09M calls per file, with zero amortization** — the whole
runtime corpus is re-read and re-scanned for every file in the same invocation.
For the 7-file parser run, ~6 × 8.1M ≈ **48.6M of the 84.1M calls (58%) are
redundant re-scans of runtime source**.

This is *not* a lowering problem and is not fixed by carrying length. It is
documented as deliberate at `prelude_globals.sfn:118-125`, which records that
memoizing it in a module global makes the seed emit a call to an undefined
`@sailfin_module_init__prelude_globals` — invalid IR that `llvm-as` rejects —
because array-typed module globals are miscompiled (#812).

**That comment is stale.** Tested directly: adding
`let mut _pg_cache: string[] = [];` to `prelude_globals.sfn` and running
`make clean-build && make compile` **compiles all 299 modules and links**
(`built: build/sailfin/program`). No invalid IR, no undefined
`@sailfin_module_init__`. The defect class was closed by #1386, which defined
`@sailfin_module_init__` end-to-end and is guarded by
`compiler/tests/e2e/check_build_agree_module_global_test.sfn` — whose header
names the original symptom as exactly `let mut xs: int[] = [];`. `#812` is a
closed GitHub issue predating the Linear migration; the comment outlived its
cause and should be deleted by whoever does the memoization.

### 5.C.1 The real constraint is correctness, not codegen

The same experiment found the trap that actually matters. A **naive**
unconditional cache — return `_pg_cache` whenever non-empty, ignoring the
`helper_names` argument — builds the compiler successfully and then **segfaults
the freshly built binary** emitting `runtime/sfn/platform/posix.sfn`
(`sfn emit --module-name runtime/sfn/platform/posix native`, SIGSEGV). A control
`make clean-build && make compile` on the unmodified tree passes that same step,
so the crash is attributable to the memoization, not to a pre-existing cold-build
failure.

Cause: `load_prelude_global_names(helper_names)` is parameterised, and callers do
not all pass the same set. An unkeyed cache hands one caller another's
global-name set.

So the memoization is **viable but must be keyed on `helper_names`** (or the
callers proven to pass an identical set). The recompute-every-time behaviour was
defensible on correctness grounds even though its stated codegen justification no
longer holds.

It is not part of this epic and should be tracked separately.

#### Resolution (SFN-633)

The parenthetical is what held: all ten call sites (`main.sfn:152,335,388,414,475,618,688,757,857`
and `tools/check.sfn:164`) pass the same `runtime_helper_call_names()`, which is
built from hardcoded descriptors with no I/O and no environment dependence
(`llvm/runtime_helpers.sfn:1747-1758`). The differing-callers diagnosis above is
therefore wrong, and keying on `helper_names` was not what the fix needed.

The operative hazard is the **phase-scoped arena rewind**, and it makes any
`string[]` memo in this module a use-after-free regardless of keying.

Ordinary Sailfin arrays and strings are arena-backed: `sfn_alloc_struct`
(`runtime/sfn/memory/mem.sfn:240-250`) routes through `sfn_arena_alloc` →
`sfn_arena_sfn_alloc`, the same bump allocator `sfn_arena_sfn_mark` /
`sfn_arena_sfn_rewind` operate on (`runtime/sfn/memory/arena.sfn:352-354`,
`:665-748`). The compiler's own execution rewinds at **four** sites, not one:

| site | mark | rewind | cadence |
|---|---|---|---|
| `main.sfn` emit pass | `:855` | `:917` | once per file, success path only |
| `check/engine.sfn` | `:422` | `:454` | **once per checked file** |
| `cli/commands/test.sfn` | `:1163` | `:1340,1354,1379,…` | per test phase |
| `cli/commands/fmt.sfn` | `:112` | `:136` | per run |

In `main.sfn` the mark is taken at `:855`, one line *before* the first
`load_prelude_global_names` call at `:857`, so a `string[]` memo populated on that
first call sits above the mark and is reclaimed by the rewind at `:917`. Every
later file in the same process then indexes a dangling container — exactly the
hazard `arena_relocate.sfn:6-13` records for SFEP-0043: "a `string[]` returned by
a helper is itself arena-allocated; after the rewind its metadata struct is gone,
so any post-rewind indexing is a use-after-free."

That explains the original report precisely. The reported crash command was
`sfn emit --module-name runtime/sfn/platform/posix native` — the `main.sfn`
rewind path. It also explains the *intermittency*: a UAF read succeeds silently
until something else allocates over the reclaimed region, so single-file and
warm-cache runs pass while parallel cold runs fault.

Two consequences worth recording, because both are easy to get wrong:

- **Hoisting the call above the mark does not fix it.** That would rescue
  `main.sfn` alone; `check/engine.sfn` rewinds once per *file*, so an
  arena-allocated memo still dangles there.
- **The differing-callers and aliasing diagnoses were both wrong.** No consumer
  mutates the returned array (`typecheck.sfn:220` only concats it;
  `_symbols_from_global_names`, `typecheck.sfn:356-367`, only reads), so a
  shared-array cache would have been content-correct. Neither theory predicts a
  SIGSEGV.

The shipped fix therefore carries only a heap-backed scalar across the mark
boundary, per the sanctioned pattern: the scanned names are joined into one blob,
relocated out of the arena with `relocate_string_to_heap`
(`arena_relocate.sfn:31`), stored in a `string` module global, and re-split per
call. The guard is a `boolean` — const-initialized in the preamble
(`module_globals.sfn:315-323`), needing no `@sailfin_module_init__` call (which
#1386 plants only in a module's own `fn main`, `emission.sfn:447-456`, and this
module has none), hence safe to read before any assignment.

Cost of the round trip: the blob is ~18 KB over 1,119 names, against the ~940 KB
of runtime source the memo stops re-reading. Measured marginal cost per checked
file went 8.02M → 213.7K `strnlen` calls (37.5×), flat in N, with `sfn check`
output byte-identical at N = 1, 2, 4, 8.

Measured after the change: per-file marginal cost drops from ~8.02M `strnlen`
calls to ~176K, flat in N (8 files: 64,249,837 → 9,336,251 calls, 1.14s → 0.23s),
with `sfn check` output byte-identical at N = 1, 2, 4, 8.

### 5.1 IR call-site counts understate the true scan volume

`sfn_str_eq` (`runtime/sfn/string.sfn:284-289`) calls `strnlen` **twice
internally**, on both operands. So counting `@sfn_str_len` in emitted IR —
acceptance criterion 1 as written — structurally undercounts real scan work by
however much bare-`i8*` string equality the program does.

The interposer counts those inner scans, so the gap is measured, not just
asserted: `sfn_str_eq` accounts for **1,422,038 calls (1.7%) and 5,861,315 bytes
(0.015%)** of the totals. Small — freshly emitted IR mostly targets the
length-aware `sfn_str_eq_lv` (`runtime/sfn/string.sfn:299-302`), which does not
scan. The undercount is real but bounded and changes no conclusion here.

## 6. Scaling evidence

Synthetic doubling series (identical structure, size doubling each step),
measured bytes scanned, floor-subtracted to remove fixed startup cost:

| source bytes | bytes scanned | exponent vs. previous |
|---|---|---|
| 2,990 | 100,679,927 | — |
| 5,990 | 179,384,052 | 2.259 |
| 11,990 | 491,877,302 | 2.049 |
| 24,090 | 1,746,674,102 | 2.003 |
| 48,290 | 6,766,007,702 | 1.998 |
| 96,690 | 26,843,634,902 | 1.998 |

Exponents are computed after subtracting a fixed **8.0e7-byte floor** (the
per-invocation startup cost isolated in §5.C); the byte column above is raw.
Raw exponents for the same rows are 0.831 / 1.453 / 1.816 / 1.947 / 1.985 — the
floor dominates at small n, which is why it is subtracted.

Converging to 2.0 from above. Fitted model on the synthetic series:
`bytes_scanned ≈ 2.86 · n²`.

The seven real parser files show the **same exponent but a lower constant** —
`scanned/n²` converges to ~1.72, not 2.86 — so real source is ~40% cheaper per
byte² than the synthetic series. Both coefficients are carried below rather than
blended.

Extrapolation:

Extrapolated at ~57 GB/s (§7's calibration; the implied rate from the 7-file run
is ~60 GB/s, so these are slightly conservative). The range spans the
real-source coefficient (1.72) and the synthetic one (2.86):

| source size | bytes scanned | `strnlen` time alone |
|---|---|---|
| 106 KB (`parser/expressions.sfn`, measured) | 19.5 GB | ~0.34 s |
| 250 KB | 0.11–0.18 TB | ~2–3 s |
| 1 MB | 1.7–2.9 TB | ~30–50 s |

The compiler's own largest modules sit near the top of the measured range, so
this is not hypothetical: the ~1,500-line soft module budget in
`.claude/rules/code-style.md` is, incidentally, holding this cost down.

## 7. Cost share

Callgrind, exact instruction counts:

| workload | total Ir | `__strnlen_avx2` | `sfn_str_len` frame | combined |
|---|---|---|---|---|
| `parser/token_utils.sfn` (30 KB) | 2,891,394,509 | 464,177,035 (16.05%) | 64,386,155 (2.23%) | **18.3%** |
| `parser/expressions.sfn` (106 KB) | 6,617,481,453 | 2,282,269,124 (34.49%) | 108,399,565 (1.64%) | **36.1%** |

The share roughly doubles as the file grows 3.5×. Call this **consistent with a
super-linear share**, not a confirmation of the byte model: two points from two
structurally different files cannot carry a fit, and the instruments do not fully
reconcile — absolute `__strnlen_avx2` instructions grow 4.92× (464M → 2,282M)
for a 3.53× size increase, an implied exponent near 1.26, well below what §6's
byte model predicts. The likely reconciliation is that instructions per scanned
byte fall as scans lengthen (AVX2 amortising a fixed per-call cost), but that
was not measured. Rely on the directionally solid claim: **the tax is not a
fixed ~18% overhead, it grows with input size.**

Bandwidth calibration agrees independently: ~0.65 s of `strnlen` against 3.11 s
user CPU for the 7-file run ≈ **21%**, versus callgrind's 18.3% on comparable
input.

For reference, the other large cost in the same profile is
`sfn_arena_sfn_alloc` (19.8% / 15.8%) — allocation, a separate concern, noted
only so the `strnlen` share is read in proportion.

## 8. Recommendation

**Groom carry-length-everywhere (P1) as an epic; absorb SFN-43.** The verdict is
material on the measured evidence, and SFN-42's non-owning view stays deferred
on that evidence rather than on a calendar.

Scope the epic from §4–§6 of this note, **not** from SFN-460 §4:

1. **The lexer is the whole prize on bytes** — five call sites, 81.8% of scan
   bytes, quadratic (§5.A) — **and it is carry-length work, not a shortcut
   around it.** §5.A.1 is the load-bearing result: `LexerState.source_len`
   already exists and `_number_run_byte` already receives it, and the `strnlen`
   fires anyway, because the scan is caused by the parameter's scalar `string`
   *type*, not by a missing length. Threading a length alongside cannot fix it.
   The fix is to change the parameter type off scalar `string` (a `*u8` + `i64`
   pair) or to change the struct-field mapping — both squarely inside this
   epic. Still sequence it first: it is the smallest slice, needs no seed cut,
   and its measured win sizes the rest. It remains **untested** — no A/B was
   possible.
2. **Stop discarding known lengths at runtime-helper returns** (§5.B). Giving
   `substring` / `substring_unchecked` / `grapheme_at` a `{i8*, i64}`
   `return_type` removes a per-character `strnlen` across every char-stepping
   scanner in the compiler. `grapheme_at` already calls the `_lv` native and
   already takes aggregate parameters — it is discarding a length it holds.
   This is the natural spine of the carry-length epic and where SFN-43 attaches.
3. **File the prelude re-scan separately** (§5.C) — and note it is **not
   blocked**. It is 58% of front-end call volume and is not a lowering bug. The
   `#812` codegen blocker its source comment cites was verified stale (§5.C):
   the array-typed module global compiles and self-hosts today. The real
   requirement is that the cache be **keyed on `helper_names`** (§5.C.1) — an
   unkeyed one self-hosts and then segfaults. Likely the cheapest large win
   available in the front end; it is kept out of this epic because it is a
   different defect, not because it is gated.
4. **The parser token-comparison surface is not worth touching** on performance
   grounds. If it changes, it changes for the memory-safety argument
   (SFN-42/SFN-460), not this one.

The **memory-safety** case for P1 from SFN-460 §3 is untouched by any of this
and remains the stronger reason to do the work: the round-trip drops carried
length, so a non-terminated view over-reads. This note only settles whether
performance *also* justifies it. It does.

## 9. Out of scope, confirmed

No lowering code was changed — `type_mapping.sfn`, the coercion shim, and the
comparison/`.length` lowering are untouched. Per SFN-628's own instruction, the
lexer fix identified in §8 was **not** implemented here; it is reported, not
applied.

This says nothing about SFN-613. The tax is a constant per build at fixed input
size, so on this evidence it does not explain a 0.8.2 → 0.8.4 throughput
regression on flat IR volume. Nothing here measured 0.8.2, so that is a
non-explanation rather than a proof of independence.

## 10. Reproducing

```bash
make compile

# static IR emission counts
for f in build/native/raw/*.ll; do
  printf '%s\t%s\n' "$(grep -c 'call i64 @sfn_str_len' "$f")" "$(basename $f)"
done | sort -rn | head -20

# dynamic attribution: build the interposer in §11, then
gcc -shared -fPIC -O2 -o /tmp/libcount.so /tmp/count_strnlen.c -ldl
STRNLEN_STATS=/tmp/stats.txt LD_PRELOAD=/tmp/libcount.so \
  build/toolchains/seed/bin/sfn check compiler/capsules/syntax/src/parser/*.sfn
# resolve `CALLER ra=0x…` lines against `nm <binary>`, subtracting the
# `BASE` load address the interposer records from /proc/self/maps.

# exact instruction share
SAILFIN_MEM_LIMIT=unlimited valgrind --tool=callgrind \
  --callgrind-out-file=cg.out \
  build/toolchains/seed/bin/sfn check compiler/capsules/syntax/src/parser/expressions.sfn
callgrind_annotate cg.out | grep -E 'PROGRAM TOTALS|strnlen|sfn_str_len'
```

## 11. The interposer

Kept here rather than in-tree: it is a measurement tool, not build surface, and
Sailfin ships no C runtime. Save as `count_strnlen.c`.

```c
#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <dlfcn.h>
#include <stdint.h>

static size_t (*real_strnlen)(const char *, size_t);
static unsigned long long n_calls, n_bytes, hist_n[40], hist_b[40];
#define NSLOT 4096
static struct { uintptr_t ra; unsigned long long n, b; } tab[NSLOT];

__attribute__((constructor)) static void init(void) {
    real_strnlen = dlsym(RTLD_NEXT, "strnlen");
}

static void note(uintptr_t ra, size_t r) {
    size_t h = (ra >> 4) % NSLOT;
    for (size_t i = 0; i < NSLOT; i++) {
        size_t s = (h + i) % NSLOT;
        if (tab[s].ra == 0) { tab[s].ra = ra; tab[s].n = 1; tab[s].b = r; return; }
        if (tab[s].ra == ra) { tab[s].n++; tab[s].b += r; return; }
    }
}

size_t strnlen(const char *s, size_t maxlen) {
    if (!real_strnlen) real_strnlen = dlsym(RTLD_NEXT, "strnlen");
    size_t r = real_strnlen(s, maxlen);
    n_calls++; n_bytes += r;
    int b = 0; size_t v = r;
    while (v) { b++; v >>= 1; }
    if (b > 39) b = 39;
    hist_n[b]++; hist_b[b] += r;
    note((uintptr_t)__builtin_return_address(0), r);
    return r;
}

__attribute__((destructor)) static void fini(void) {
    if (n_calls == 0) return;
    const char *out = getenv("STRNLEN_STATS");
    FILE *f = out ? fopen(out, "a") : stderr;
    if (!f) f = stderr;
    fprintf(f, "TOTAL calls=%llu bytes=%llu\n", n_calls, n_bytes);
    for (int i = 0; i < 40; i++)
        if (hist_n[i]) fprintf(f, "HIST bucket=2^%d calls=%llu bytes=%llu\n",
                               i, hist_n[i], hist_b[i]);
    FILE *m = fopen("/proc/self/maps", "r");
    char line[512];
    if (m && fgets(line, sizeof line, m)) fprintf(f, "BASE %s", line);
    if (m) fclose(m);
    for (int i = 0; i < NSLOT; i++)
        if (tab[i].ra) fprintf(f, "CALLER ra=0x%lx calls=%llu bytes=%llu\n",
                               (unsigned long)tab[i].ra, tab[i].n, tab[i].b);
    if (out) fclose(f);
}
```

`sfn_str_len` is inlined into its callers, so `__builtin_return_address(0)`
resolves to the enclosing Sailfin function — which is the attribution wanted.
Because the interposer adds ~16 ns of bookkeeping per call, its wall-clock
numbers are not usable; use it for counts and attribution, and callgrind for
cost share.
