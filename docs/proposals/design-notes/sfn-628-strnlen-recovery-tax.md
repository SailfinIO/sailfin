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

There are also **two** root-cause mechanisms, not the one §4 described: the
struct-field demotion (dominates bytes) and bare-`i8*` runtime-helper returns
that discard a length already known at the call site (dominates call count).

Three findings drive the verdict:

- Length recovery is **16.1%–34.5% of all executed instructions** in a
  front-end `sfn check`, rising with input size.
- Bytes scanned grow as **Θ(n²)** in source-file size (measured exponent
  1.998–2.003). A 1 MB source file would scan ~2.9 TB and spend ~50 s in
  `strnlen` alone.
- A further **58% of front-end call volume** is the runtime symbol scan
  re-walking `runtime/**` once per checked file — a separate defect, blocked on
  a seed codegen bug (#812), that should not be folded into this epic.

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

Workload: `sfn check compiler/src/parser/*.sfn` (7 files, 8,436 lines) — the
front end only (parse + typecheck + effect-check, no IR, no codegen).

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
| 828 | `llvm__expression_lowering__native__core_operands` |
| 660 | `llvm__expression_lowering__native__core_call_emission` |
| 515 | `typecheck_types` |
| 435 | `llvm__expression_lowering__native__core_concurrency_lowering` |
| 364 | `llvm__expression_lowering__native__core_literals_lowering` |

### 3.1 Why the static count is the wrong instrument

`lexer.ll` emits **29** `sfn_str_len` call sites — near the bottom of the
table, 1/28th of `core_operands`. At runtime it produces **97.8% of all bytes
scanned**.

Static emission count does not rank cost even approximately. One call site
inside a per-character loop dominates 828 cold ones. §4 ranked modules by
static count and concluded the parser was the hot path; it is not. Any future
sizing of this work must use dynamic measurement.

## 4. Where the time actually goes

Dynamic attribution, 7-file front-end check — **84,143,313 calls scanning
39,316,783,174 bytes (39.3 GB)** to check 8,436 lines:

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

Machine-level attribution inside `lex__lexer` (33 distinct sites):

| site | calls | bytes | % of all bytes |
|---|---|---|---|
| `lex__lexer+0xc5f` | 139,957 | 9,988,466,067 | 25.4% |
| `lex__lexer+0x2b9` | 105,820 | 7,686,638,092 | 19.6% |
| `lex__lexer+0x327` | 82,694 | 6,098,903,640 | 15.5% |
| `lex__lexer+0x1d1` | 62,968 | 4,361,305,181 | 11.1% |
| `lex__lexer+0x518` | 54,680 | 4,037,767,103 | 10.3% |

**Five call sites = 83.7% of all string-scanning work in the entire front end**,
averaging ~71 KB scanned per call — i.e. each one rescans the whole source
buffer.

## 5. Root cause

There are **two** mechanisms, not one. SFN-460 §4 described only the first.

### 5.A Struct-field demotion — dominates *bytes* (the lexer)

The chain is short and entirely mechanical:

1. `compiler/src/lexer.sfn:10-11` — `struct LexerState { source: string; … }`.
2. `compiler/src/llvm/type_mapping.sfn:619` — `map_struct_field_annotation`
   demotes string-typed **struct fields** to bare `i8*` (deliberately, to keep
   field byte offsets stable), while scalars stay `{i8*, i64}`
   (`map_type_annotation`, `type_mapping.sfn:559-561`).
3. `compiler/src/lexer.sfn:422-437` — `slice(text: string, …)` and
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

Note `_number_run_byte` (`lexer.sfn:406`) already threads `source_len: int`
explicitly as a separate parameter, and its two internal `byte_at(source, …)`
calls therefore pass an *already-scalar* `string` and do not rescan. The pattern
was noticed and worked around by hand for the number path, without the root
cause being addressed — which is also a partial existence proof that the §8.1
fix works.

**Confidence.** The quadratic *measurement* (§6) is direct. The *attribution* of
that quadratic to this specific chain is inferred from source reading plus
machine-level call-site attribution, not from a before/after experiment — no
A/B was possible here because the issue forbids changing lowering code. The
inference is well-supported (24 call sites, scan length ≈ full file, exponent
exactly 2.0, and a hand-workaround already present at `lexer.sfn:406`) but it
is an inference. The first slice of the epic should confirm it by measuring the
fix.

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
already documented as deliberate: `prelude_globals.sfn:118-125` records that
memoizing it in a module global makes **the seed compiler emit a call to an
undefined `@sailfin_module_init__prelude_globals`** — invalid IR that `llvm-as`
rejects — because array-typed module globals are miscompiled (#812). The per-call
FS scan is an accepted workaround for a seed codegen bug.

So the single largest call-count win in the front end is gated on #812, not on
this epic. It should be tracked separately.

### 5.1 IR call-site counts understate the true scan volume

`sfn_str_eq` (`runtime/sfn/string.sfn:284-289`) calls `strnlen` **twice
internally**, on both operands. So counting `@sfn_str_len` in emitted IR —
acceptance criterion 1 as written — structurally undercounts real scan work by
however much bare-`i8*` string equality the program does. Both numbers are
reported above; the dynamic one is the one to trust.

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

Converges on **exactly 2.0**. Fitted model: `bytes_scanned ≈ 2.86 · n²`.

The seven real parser files fit the same curve (`scanned/n²` converging to
~1.7–1.85 for the larger files).

Extrapolation:

| source size | bytes scanned | `strnlen` time alone @ ~57 GB/s |
|---|---|---|
| 106 KB (`parser/expressions.sfn`) | 19.5 GB | ~0.34 s |
| 250 KB | 0.18 TB | ~3 s |
| 1 MB | 2.86 TB | ~50 s |

The compiler's own largest modules sit near the top of the measured range, so
this is not hypothetical: the ~1,500-line soft module budget in
`.claude/rules/code-style.md` is, incidentally, holding this cost down.

## 7. Cost share

Callgrind, exact instruction counts:

| workload | total Ir | `__strnlen_avx2` | `sfn_str_len` frame | combined |
|---|---|---|---|---|
| `parser/token_utils.sfn` (30 KB) | 2,891,394,509 | 464,177,035 (16.05%) | 64,386,155 (2.23%) | **18.3%** |
| `parser/expressions.sfn` (106 KB) | 6,617,481,453 | 2,282,269,124 (34.49%) | 108,399,565 (1.64%) | **36.1%** |

The share **doubles** as the file grows 3.5×, exactly as the quadratic model
predicts. This is the key number: the tax is not a fixed ~18% overhead, it is a
scaling cliff.

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

1. **The lexer is the whole prize on bytes.** Five call sites, 83.7% of scan
   bytes, quadratic (§5.A). Passing the already-hoisted `length`
   (`lexer.sfn:19`) alongside `state.source` — the `_number_run_byte`
   treatment, applied to `byte_at` and `slice` — **should** collapse the
   quadratic term. This is untested: no A/B was run, because the issue forbids
   changing lowering code. It is a **cheap, local, non-architectural candidate
   that must be measured before the full epic is committed to**, and it should
   be the epic's first slice regardless. It does not require
   carry-length-everywhere, and if it lands the measured win, it materially
   changes how much the rest of the epic is worth.
2. **Stop discarding known lengths at runtime-helper returns** (§5.B). Giving
   `substring` / `substring_unchecked` / `grapheme_at` a `{i8*, i64}`
   `return_type` removes a per-character `strnlen` across every char-stepping
   scanner in the compiler. `grapheme_at` already calls the `_lv` native and
   already takes aggregate parameters — it is discarding a length it holds.
   This is the natural spine of the carry-length epic and where SFN-43 attaches.
3. **File the prelude re-scan separately** (§5.C). It is 58% of front-end call
   volume, it is not a lowering bug, and it is blocked on the #812 seed codegen
   bug for array-typed module globals. Folding it into this epic would couple a
   large independent win to an unrelated blocker.
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
size and cannot explain a 0.8.2 → 0.8.4 throughput regression on flat IR volume.
The two remain unrelated.

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
  build/toolchains/seed/bin/sfn check compiler/src/parser/*.sfn
# resolve `CALLER ra=0x…` lines against `nm <binary>`, subtracting the
# `BASE` load address the interposer records from /proc/self/maps.

# exact instruction share
SAILFIN_MEM_LIMIT=unlimited valgrind --tool=callgrind \
  --callgrind-out-file=cg.out \
  build/toolchains/seed/bin/sfn check compiler/src/parser/expressions.sfn
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
