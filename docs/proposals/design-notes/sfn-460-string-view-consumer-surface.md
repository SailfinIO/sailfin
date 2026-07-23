# SFN-460 — String consumer surface for non-terminated `substring` views

> Single-issue design note (no SFEP number). Audit + root-cause output that
> determines whether SFN-42 (non-owning `substring` view) can land via a
> mechanical carried-length migration or needs a lowering-level design.
> Design context: SFEP-0025 §3.3 (string-view slice), SFEP-0043 (phase-scoped
> arena reclamation — the view-lifetime axis). Predecessors already in seed
> 0.8.0: #1704 (length-aware `_lv` query helpers), #1705 (`cstr` boundary),
> #1722 (`to_number`).

## 1. Problem

SFN-42 (PR #2559) makes `substring` / `substring_unchecked` emit a non-owning
`{data+start, end-start}` view — an interior pointer into the source buffer that
is **not NUL-terminated** at its end boundary. It self-hosts and passes targeted
tests, but full CI was red across many shards. This note root-causes that
breakage and enumerates the surface, so SFN-42's path forward is decided on
evidence rather than the "both blockers cleared → sound" premise that turned out
incomplete.

`substring` is the runtime's first non-NUL-terminated string surface, so this is
the first time a non-terminated value flows through the broader consumer set.

## 2. Method — and a load-bearing caveat about the baseline

Every comparison here was run with **isolated, freshly-cleaned build caches per
compiler**. This matters: the compiler routes each compile's IR through a shared
`build/sailfin/program.ll` + `build/cache` (the `--jobs`/shared-`program.ll`
collision documented in `.claude/rules/no-bash-e2e.md`). Rapidly switching a
single `build/bin/sfn` between the seed, main, and the view compiler leaves
**cross-contaminated cache entries** that produce corrupted test binaries — an
exit-139 that is a cache artifact, not a real crash.

**This contamination is exactly what mis-attributed the crash originally.** The
SFN-42 parking analysis used the **0.8.0 seed** as its "known-good" baseline and
reported `closure_lifting_test` "passes on the seed, SIGSEGVs with the view."
With a clean cache the **seed passes the same test too**, and so does
main-self-hosted. The correct baseline for "is this view-caused?" is
**main-self-hosted** (the current compiler without the view), never the seed —
the seed carries its own codegen quirks and its shared cache contaminates.

Controlled matrix (clean cache, each compiler built from a clean tree):

| test | seed 0.8.0 | main-self-hosted | view compiler |
|---|---|---|---|
| `closure_lifting_test` | PASS | PASS | **139 (SIGSEGV)** |
| `toml_test` | PASS | PASS | **fail** |
| `http/router_test` | PASS | PASS | **fail** |
| `http/wire_test` | PASS | PASS | **fail** |
| `path_test` | PASS | PASS | **fail** |

So **every** failure is genuinely view-caused (main passes all; view fails all),
and the "3 pre-existing toml failures" the issue cited were also seed/cache
artifacts — toml is fully green on main.

## 3. Root cause of the `closure_lifting_test` SIGSEGV — classification (a), over-read

**Classification: (a) NUL-scan / over-read.** Not (b) a dangling arena-rewound
view, and not an emission/GEP bug. Evidence:

1. **Minimal repro isolates a wrong *result*, not a crash.** A standalone
   `parse_program("fn main() { let f = fn() -> int { return 42; }; }")` +
   `lift_non_capturing_lambdas` prints `counter=0`, `statements=1` under the view
   compiler, but `counter=1`, `statements=2` under main. The view corrupts the
   parse/lift computation deterministically — the source string is alive
   throughout and there is no arena rewind at test runtime, which rules out a
   dangling view (b).
2. **The corruption is an over-read of a mis-recovered length.** The view value
   itself is correctly typed `{i8*, i64}` (`emit_substring_view`,
   `core_strings.sfn:344`) — so this is not a bad GEP. The fault is the
   `{i8*,i64} → i8* → {i8*,i64}` round-trip in `coerce_pointer_or_struct`
   (`core_operands.sfn:1032-1087`): a view coerced down to `i8*` (`extractvalue …
   , 0`, line 1035) **drops its carried length**, and the return coercion
   recovers length via `string.length` → `sfn_str_len` = `strnlen`
   (`runtime/sfn/string.sfn:274-277`), which **scans past the non-terminated
   slice boundary**. The wrong (over-long) length then drives wrong string
   comparisons/positions.
3. **The wrong length breaks an integer record match.** The lift misclassifies
   the lambda because `_find_capture_record`
   (`lambda_lowering.sfn:363`) matches records by `body_start_line` /
   `body_start_column`, and those positions (or the compared capture records) are
   computed wrong upstream once a slice over-reads — so no record matches,
   `_is_non_capturing` returns `false`, and the lambda is never lifted
   (`counter=0`).
4. **The SIGSEGV is a downstream cascade.** With the lambda unlifted, the AST
   lacks the expected lifted-fn/initializer nodes; the next sub-test dereferences
   a field of that missing node — gdb shows a **NULL-pointer dereference**
   (`rdi=0x0`) in `test "lift zero-arg case rewrites the let initializer…"`, not
   an out-of-bounds read *at the crash site*. The crash is the tail of the
   over-read, not an independent bug.

## 4. The consumer surface is systemic, not a bounded set

The over-read is **not** confined to a small set of NUL-scanning helpers that a
#1704-style per-helper `_lv` migration would close. The emitted IR shows
`sfn_str_len` (strnlen) **length-recovery calls in the hundreds** across the
front end — e.g. **209** in `parser__expressions`, **157** in
`parser__token_utils`, **154** in `closures`, **135** in `lambda_lowering`.
Strings are pervasively **bare-`i8*`-typed and length-recovered by scanning** at
those sites; any of them that receives a view (directly, or after a
`{i8*,i64}→i8*` downgrade) over-reads. The failing paths (toml dotted-path /
unicode-escape decode, router/wire/path parsing, and the parser/lift itself) all
reach the over-read through this pervasive recovery pattern, not through one
choke point.

Length-aware `_lv` siblings that already exist (from #1704/#1705/#1722):
`sfn_str_eq_lv`, `sfn_str_cmp_lv`, `sfn_str_to_number_lv`, `sfn_str_codepoint_lv`,
`sfn_str_grapheme_count_lv`, `sfn_str_grapheme_at_lv`. **Confirmed missing:**
`sfn_str_len` has **no `_lv` sibling** — but adding one does not help the
round-trip, because at the `i8* → {i8*,i64}` recovery point the carried length
has *already been lost* (only the bare pointer remains). The length must be
preserved end-to-end, not re-derived.

## 5. Recommendation for SFN-42

**SFN-42's non-owning view cannot land as a mechanical carried-length migration.**
The consumer surface is the front end's pervasive bare-`i8*`-string +
`strnlen`-recovery lowering; making it view-safe means **carrying string length
end-to-end so a string value is never downgraded to a bare `i8*` and rescanned**
— a lowering-level change of large blast radius, overlapping SFN-42's own
(out-of-scope) view lowering.

Two viable paths (recommend the owner pick at grooming):

- **(P1) Carry-length-everywhere lowering.** Eliminate the `{i8*,i64}→i8*→
  {i8*,i64}` round-trip: keep string operands as the `{i8*,i64}` aggregate through
  binding/params/returns, so `sfn_str_len` (strnlen) recovery is never reached for
  a view. This is the sound end state and unblocks true zero-copy views, but it is
  an architectural front-end change — a new epic, not a 3-point migration. Add
  `sfn_str_len_lv` as part of it.
- **(P2) Defer the non-owning aspect for 1.0.** Keep `substring` /
  `substring_unchecked` **copying + NUL-terminating** (today's behaviour), so the
  entire existing consumer surface stays sound, and schedule the zero-copy view
  behind P1 post-1.0. Lowest risk; SFN-42 becomes "no-op / defer" and the
  view-lifetime axis (SFEP-0043) is revisited with P1.

Either way, the premise that #1704/#1705/#1722 made consumers view-safe holds
only for the operators they touched; the general surface was never view-safe.

## 6. Disposition

- **SFN-460 delivers** this audit + root-cause + recommendation (its stated
  purpose: determine mechanical-vs-design → **design**). No mechanical
  consumer-migration code lands, because the audit found no bounded mechanical
  fix that greens the red tests while staying safe on today's NUL-terminated
  `substring`.
- **SFN-42 stays blocked**, now on the P1-vs-P2 design decision above rather than
  on a "migrate the consumers" predecessor.
- A follow-on issue carries the P1/P2 decision and the carry-length-everywhere
  scope; SFEP-0025 §3.3 is annotated to point here.
