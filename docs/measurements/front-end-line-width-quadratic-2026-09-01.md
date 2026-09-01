# Front-end peak-memory scaling — 2026-09-01 (SFN-1134)

Localization of the quadratic peak-memory growth reported against `sfn check`
and LLVM emit. Measured on Linux x86_64, 4 cores / 15 GiB, compiler built by
`sfn dev bootstrap build` from seed 0.10.6 at `b2c3a18`, under the normal 8 GiB
self-cap (no `SAILFIN_MEM_LIMIT` override).

Peak memory is `Maximum resident set size` from `/usr/bin/time -v`.

## Result

The defect is **not per-token and not in the parser**. It is **per-line**, and it
lives in the driver's diagnostic line splitter:

- **Owner:** `_dr_split_lines`, `compiler/src/diagnostics_render.sfn:104-137`,
  hot line `:132` — `current = current + ch;`, one concat per source byte.
- **Mechanism:** each `+` lowers to `sfn_str_concat`
  (`runtime/sfn/string.sfn:575-607`), which bump-allocates a *fresh* buffer of
  `total + 1` bytes from the arena (`:590`) and memcpys both operands. The
  previous buffer is never reclaimed — the arena does not free. Accumulating a
  line of length `k` therefore allocates `Σ(i+1) ≈ k²/2` bytes of never-reused
  arena, of which only `k` is live.
- **Cost law:** `peak ≈ floor + Σ_lines k²/2`, i.e. quadratic in the length of
  the *longest line*, and independent of file size, token count, and symbol
  count.
- **It runs unconditionally**, before anything checks whether a diagnostic
  exists. Every measurement below is on a file that compiles clean (`rc=0`,
  zero diagnostics) and still pays in full.

Entry points that reach it on every invocation:

| Path | Call site |
|---|---|
| `sfn check` | `compiler/src/tools/check.sfn:73` (`check_result_from_analysis`) |
| build / LLVM emit | `compiler/src/main.sfn:605` → `compiler/src/effect_gate.sfn:139` |
| capability resolve | `compiler/src/capsule_resolver/capability.sfn:62` |
| native artifact write | `compiler/src/native_artifact_writer.sfn:25` |

`sfn fmt` never reaches `diagnostics_render.sfn`; `format_source`
(`compiler/src/tools/fmt/mod.sfn:14-36`) stops at the token stream. That is the
whole explanation for the reported "check and emit blow up, fmt stays linear".

A structurally identical sibling exists in the analyzer's prelude scanner:
`_ps_split_source_lines`, `compiler/capsules/analyzer/src/prelude_scan.sfn:19-40`,
called at `:104`.

## Four-point curve — peak RSS (KB), `sfn check`

Process floor, minimal file: **163,276 KB**.

| bytes | `ident` (one identifier) | `comment` (one comment) | `manytok` (many short) | `str` (string literal) |
|---|---|---|---|---|
| 4,096  | 173,520 | 173,264 | 239,500 | 181,716 |
| 8,192  | 198,404 | 198,180 | 386,232 | 231,516 |
| 16,384 | 297,572 | 296,852 | 756,084 | 429,028 |
| 32,768 | 692,628 | 691,216 | 1,803,296 | 1,217,772 |
| 65,536 | 2,267,740 | 2,265,484 | — | — |

`sfn emit llvm` tracks `check` closely except for `ident`, noted below.

| bytes | `ident` emit | `comment` emit | `manytok` emit | `str` emit |
|---|---|---|---|---|
| 4,096  | 173,640 | 173,464 | 244,192 | 181,824 |
| 8,192  | 198,624 | 198,316 | 401,236 | 231,440 |
| 16,384 | 554,284 | 297,076 | 811,700 | 429,408 |
| 32,768 | 2,138,920 | 691,536 | 2,014,012 | 1,218,900 |

### Fit against `k²/2`

Peak over floor, `sfn check`, versus the predicted `k²/2`:

| bytes | predicted `k²/2` (KB) | `ident` measured | ratio | `comment` measured | ratio |
|---|---|---|---|---|---|
| 4,096  | 8,192 | 10,244 | 1.250 | 9,988 | 1.219 |
| 8,192  | 32,768 | 35,128 | 1.072 | 34,904 | 1.065 |
| 16,384 | 131,072 | 134,296 | 1.025 | 133,576 | 1.019 |
| 32,768 | 524,288 | 529,352 | 1.010 | 527,940 | 1.007 |
| 65,536 | 2,097,152 | 2,104,464 | **1.003** | 2,102,208 | **1.002** |

The ratio converges to 1.0 across a 16x range; the residual is the fixed ~7 MB
of genuinely live data plus a small linear term.

**A comment costs exactly what an identifier costs.** A comment is trivia the
parser discards entirely, so no per-token or per-AST-node explanation survives
this pair — only a scan of raw source text before tokenization does.

## Causal control: line width at constant file size

Same ~32.8 KB of comment bytes, only the line width varies.

| line width | peak KB | over floor | predicted `Σ k²/2` |
|---|---|---|---|
| 80 | 167,028 | 3,752 | 1,280 |
| 512 | 173,580 | 10,304 | 8,192 |
| 4,096 | 231,084 | 67,808 | 65,536 |
| 32,768 | 690,044 | 526,768 | 524,288 |

File size is held constant. The quadratic term (peak over floor) moves 140x,
and total peak 4.13x. Cost is a function of line width, not of source size;
80-column source is effectively free.

## Direct arena attribution

`SAILFIN_DUMP_ARENA_STATS=1`, both files ~32.8 KB:

| fixture | capacity | used | utilization |
|---|---|---|---|
| `width_80` | 163,577,856 | 7,289,770 | 4% |
| `ident_32768` | 700,448,768 | 7,290,268 | 1% |

`used` differs by 498 bytes. `capacity` differs by **536,870,912 bytes**, which
is exactly `32768² / 2`. The live data is identical; the half-gigabyte is
abandoned intermediate concat buffers, matching the predicted law to the byte.

## Separating SFN-1192 (string-literal escape decoding)

Peak over floor versus `k²/2`, `str` fixtures:

| bytes | predicted `k²/2` (KB) | measured | ratio |
|---|---|---|---|
| 4,096 | 8,192 | 18,440 | 2.25 |
| 8,192 | 32,768 | 68,240 | 2.08 |
| 16,384 | 131,072 | 265,752 | 2.03 |
| 32,768 | 524,288 | 1,054,496 | **2.01** |

A string literal pays exactly **2x** the generic cost, converging to 2.00. One
`k²/2` is `_dr_split_lines` (the literal sits on one long line, like any other
long line); the second `k²/2` is the independently-tracked escape decoder,
SFN-1192. The two are additive and separable, and SFN-1192 accounts for exactly
half of the string-literal case — it is not the owner of the generic defect.

## Cost on real source today

This is not only a synthetic-fixture defect. Summing `k²/2` over every line of
`runtime/**.sfn` — the input the sibling `_ps_split_source_lines` scans on every
invocation — predicts **43.6 MB** of never-reused arena per run. Real source is
far from pathological (longest runtime line is 465 chars at
`runtime/sfn/platform/tls_record.sfn:1036`; longest in `compiler/src` is 1,423
chars at `compiler/src/tools/fmt/unary.sfn:260`), but the aggregate is a
meaningful share of the ~156 MB arena floor a trivial `sfn check` already
reserves.

## Open, not explained by this owner

- **`manytok` superlinearity.** Many short lines make the per-line term
  negligible (`32768 x 16 / 2 ≈ 262 KB`), yet `manytok` still grows ~2.6x per
  doubling (~`n^1.4`). That residual is a *different* mechanism and is not the
  subject of this leaf. The leading candidate is the linear reverse scan in
  `find_symbol` / `find_value_symbol`
  (`compiler/capsules/analyzer/src/typecheck_types/symbol_table_and_raw_exprs.sfn:261-290`),
  which is O(symbol count) per reference. Tracked by SFN-1227.
- **`ident` emit exceeding `ident` check** (2,138,920 vs 692,628 at 32 KiB,
  while `comment` emit and check agree). A long identifier reaches symbol
  mangling and lowering, which a comment does not; a third helping of the same
  concat pattern is likely but was not localized here.

## Successors

* **SFN-1226** — *perf(driver): make diagnostic source-line splitting linear*.
  Fixes the owner above and its `prelude_scan.sfn` sibling, with observable
  peak-memory, arena-capacity and wall-time targets against the baselines here.
* **SFN-1227** — *perf(analyzer): localize the residual superlinear cost on
  many-short-line sources*. Investigation leaf for the `manytok` residual, best
  measured after SFN-1226 lands.

## Reproducer

```python
# fixtures
N = 32768
open("ident.sfn",   "w").write("fn main() {\n  let %s = 1;\n}\n" % ("a" * N))
open("comment.sfn", "w").write("// %s\nfn main() {\n  let x = 1;\n}\n" % ("a" * N))
# line-width control: same total bytes, varying width
for width in (80, 512, 4096, 32768):
    lines, rem = [], N
    while rem > 0:
        k = min(width, rem); lines.append("// " + "a" * k); rem -= k
    open("width_%d.sfn" % width, "w").write(
        "\n".join(lines) + "\nfn main() {\n  let x = 1;\n}\n")
```

```bash
/usr/bin/time -v build/bin/sfn check ident.sfn
/usr/bin/time -v build/bin/sfn emit -o /tmp/out.ll llvm ident.sfn
SAILFIN_DUMP_ARENA_STATS=1 build/bin/sfn check ident.sfn
```

## Prior art

`docs/proposals/design-notes/sfn-628-strnlen-recovery-tax.md` investigated the
same class of defect and fixed the lexer's own instance
(`compiler/capsules/syntax/src/lexer.sfn:10-21`). Its corpus was real `.sfn`
files, which have no pathologically long lines, so `_dr_split_lines` never
appeared in its attribution table. The single-long-line discriminator used here
is what exposes it.
