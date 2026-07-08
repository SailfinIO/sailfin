---
sfep: 0043
title: Phase-scoped arena reclamation to reduce per-module peak RSS
status: Implemented
type: runtime            # language | runtime | tooling | process | informational
created: 2026-07-07
updated: 2026-07-07
author: "agent:compiler-architect; human review"
tracking: "#1989"
supersedes:
superseded-by:
graduates-to: "docs/status.md (Runtime Migration); docs/proposals/0006-build-architecture.md (perf section)"
---

# SFEP-0043 — Phase-scoped arena reclamation to reduce per-module peak RSS

> Implemented in #1989 (merged). Self-hosts; byte-identical `.ll` with the
> rewind on vs off, gated by the e2e test
> `compiler/tests/e2e/arena_phase_rewind_ll_identity_test.sfn`.

## 1. Summary

Each per-module compile is one process whose arena `free` is a no-op, so its
peak RSS equals **every byte ever allocated during that process** — the AST,
typecheck, effect, and ownership garbage of the *front half* of the pipeline
stays resident while the *back half* (LLVM lowering, where peak occurs) allocates
its own bulk on top. This SFEP takes an arena **mark before `parse_program`**,
and — after the emitter produces `native_lines` — **joins them to a single flat
string via `lines_to_native_text` and relocates that ONE string to malloc'd
(non-arena) memory** (`compiler/src/arena_relocate.sfn`:
`relocate_string_to_heap`), then rewinds the arena to reclaim the whole
AST/typecheck/emit region, then lowers via the flat-text entry
`write_llvm_ir_from_native_text[_with_context]`, then frees the heap string
after. `import_asm_paths` is a funnel parameter allocated below the mark so it
survives the rewind natively — imports are re-loaded fresh post-rewind rather
than relocated. The mechanism is gated by `SAILFIN_ARENA_PHASE_REWIND`
(default ON). Peak drops from `front + back` toward `max(front, back)` because
lowering reuses the reclaimed AST region. The mark/rewind pair is already
shipped (`runtime/sfn/memory/arena.sfn:620,656`); the single-string survivor
relocation is a small new `compiler/src/arena_relocate.sfn` helper built on the
`malloc`/`free` externs already declared in those modules, so **no new compiler
frontend capability is required and no seed cut is forced**.

**Measured results (199 modules, rewind OFF vs ON):** peak RSS (heaviest module)
1,211 MB → 1,009 MB (−16.7%); sum of per-module peak RSS 72.4 GB → 56.1 GB
(−22.5%); mean per-module 364 MB → 282 MB; sum wall 871.9 s → 867.3 s (−0.5%,
neutral). Broad global win across all pipeline stages (typecheck −26%, parser/
declarations −28%, effect_checker −27%, ownership_checker −27%, tools/fmt −32%,
lowering modules −17–23%). Known regressions: `capsule_resolver` +18%,
`core_literals_lowering` +8% — small front-half modules where the relocated-text
copy exceeds reclaimed garbage; neither sets the new peak.

## 2. Motivation

### The established root cause (not re-litigated here)

1. The arena bump allocator's `free` is a no-op while the arena is enabled
   (`runtime/sfn/memory/mem.sfn:185-189`). Reclamation happens only in bulk at
   process exit, so **per-module peak RSS ≈ total bytes ever allocated during
   that module's process**, not the live set. `SAILFIN_USE_ARENA=0` makes the
   peak *worse* (1505 MB vs 972 MB on `core_operands`) via libc fragmentation, so
   disabling the arena is not the fix.
2. `parse_program` builds the whole boxed-`Expression` AST (`ast.sfn:54`) and it
   stays resident through typecheck → effects → ownership → emit_native.
3. Peak RSS occurs during the **lower_llvm** phase where lowering allocates its
   own bulk on top of the still-resident front-half state.

### The correlation finding (rules out call-site rewrites as the primary fix)

Concat-site density does **not** predict peak RSS across modules:

| Module | `+` sites | Peak RSS | Note |
|---|---|---|---|
| `runtime_helpers` | 18 | 984 MB | concat-sparse yet a top offender |
| `parser/expressions` | 19 | 855 MB | concat-sparse yet a top offender |
| `core_operands` | 762 | 1210 MB | concat-dense; only +226 MB over similar-LL `runtime_helpers` |
| `instructions_for` | 4 | 724 MB | 173 KB/LL — extreme transient lowering allocation |

The dominant driver is **cumulative allocation under the never-free arena**,
uniform across modules; concat churn is a secondary additive on 2–3 modules.
**Call-site concat→join rewrites are rejected as the primary lever.**

### Why phase-scoped reclamation is the right lever

The build is **process-per-module** (`0006-build-architecture.md` §2.4), so the
arena dies at each process exit and inter-module reclamation is moot. The win is
**intra-process**: reclaim the front-half garbage (AST/`TypeContext`/effect/
ownership/emitter state) *before* the back half allocates its bulk, so lowering
reuses that space and peak drops from `front + back` toward `max(front, back)`.

## 3. Design

### 3.1 The liveness boundary (verified)

The sole per-module build funnel `make compile` drives is
`compile_to_llvm_file_with_module_imports` (`compiler/src/main.sfn:667`; reached
via `_cr_compile_one` → `compile_to_llvm_file_with_module` on the `-p` path,
`capsule_resolver.sfn:1527`). This process **parses source AND lowers in one
pass** (it is not the separate native-staging subprocess `_cr_stage_one`, which
only writes import-context `.sfn-asm`). Its body, in order:

```
parse_program(source)                         // AST — front half
typecheck_* / effects / ownership             // TypeContext etc. — front half
emit_native_lines_with_module_name(program)   // → native_lines: string[]  ← ARTIFACT
import_asm_paths                              // funnel parameter, below the mark
write_llvm_ir_from_native_text[_with_context](native_text, ..., import_asm_paths)
```

The lowering chain that follows — `compile_native_lines_to_llvm_file_with_context`
(`lowering_core.sfn:432`) — has the signature `(native_lines: string[],
module_name, out_path, imported_native_texts: string[])`. **It never receives
`program` or the `TypeContext`.** Its first acts (`lines_to_native_text` +
`parse_native_artifact_from_lines`) read only `native_lines` and re-allocate
fresh arena memory; everything after works off that fresh parse.

**The only front-half data lowering consumes is the bytes of `native_lines`.**
`import_asm_paths` (the list of `.sfn-asm` file paths) is a funnel parameter
allocated before the mark: it survives the rewind natively and imports are
re-read from disk post-rewind via the existing path resolution. That is the full
liveness boundary.

### 3.2 Why the survivor must leave the arena (the corrected mechanism)

`sfn_arena_sfn_rewind(mark)` (`arena.sfn:656`) zeroes `used` on every page
strictly after the marked page and rewinds the marked page's `used`. **A mark
taken before `parse_program` sits below `native_lines`** (produced during emit,
after parse), so rewinding to it reclaims `native_lines` too — and the next
allocation (lowering) reuses exactly that space, corrupting lowering's input.

Under a pure bump allocator **a survivor cannot be placed below a mark taken
before it.** The survivor must therefore be moved **out of the arena** before the
rewind.

### 3.3 The shipped mechanism: join → malloc-relocate → rewind → lower → free

The earlier design (see §6 — Alternatives) attempted to relocate the two
`string[]` artifacts (`native_lines` and `imported_native_texts`) directly. That
produced a use-after-free / SIGABRT: a `string[]` returned by a helper has an
ARENA-allocated container (metadata struct + element-pointer array). After the
rewind, that container is reclaimed, so lowering's post-rewind read of it was a
UAF.

**The shipped design avoids the container problem entirely by passing a single
flat string, not an array:** `lines_to_native_text` joins `native_lines` to a
single string before the rewind, and that string — a by-value `SfnString {data,
len}` — is the sole survivor. Its `data` buffer is relocated to malloc'd memory
via `relocate_string_to_heap` (`compiler/src/arena_relocate.sfn`); the
`SfnString` value itself is by-value on the caller's stack, so it requires no
relocation. After the rewind, lowering receives the flat string via the
`write_llvm_ir_from_native_text[_with_context]` entry (which re-splits it
internally via `parse_native_artifact_from_lines`), and the heap buffer is freed
after lowering completes.

`relocate_string_to_heap(s: string) -> string`: calloc's a zeroed 8-aligned
buffer of `roundup8(s.len + 1)` bytes, memcpy's the `s.len` payload bytes,
returns a new `SfnString {data: heap_ptr, len: s.len}` — the same construction
`sfn_str_sfn_from_cstr` uses to adopt a foreign buffer. The from-cstr NUL-scan
recovers length. The returned string's `data` is off-arena; no container is
involved.

```
// Pseudocode — exact spelling per the implementation.
let mark = runtime.arena_mark();          // BEFORE parse_program

// … parse, typecheck, effects, ownership, emit … (unchanged) …
let native_lines = emit_native_lines_with_module_name(program, module_name);

// Join to flat text, then relocate the data buffer to malloc.
let native_text = lines_to_native_text(native_lines);
let heap_text   = relocate_string_to_heap(native_text);   // compiler/src/arena_relocate.sfn

runtime.arena_rewind(mark);               // reclaims AST + typecheck + emitter garbage

// import_asm_paths survives the rewind natively (allocated before the mark).
let ok = write_llvm_ir_from_native_text_with_context(
    heap_text, module_name, out_path, import_asm_paths);

heap_free(heap_text.data);                // free the sole malloc survivor
return ok;
```

The flat-text entry `write_llvm_ir_from_native_text[_with_context]` reintroduces
the join/re-split that #1817 removed from the per-line path. This is
correctness-neutral (byte-identical `.ll` proves it) and costs only a wall-clock
re-split — a small fixed price versus the broad RSS reduction. The re-split
is bounded by the native-IR size, which is far smaller than the reclaimed
AST/typecheck/emitter state.

### 3.4 String-domain safety (the load-bearing hazard)

`SfnString` is `{i8* data, i64 len}` — an explicit-length fat pointer — and the
runtime carries **no arena-residency assumption** on the `data` pointer:

- `sfn_str_immediate_codepoint(s) -> -1` always (`string.sfn:128`): every string
  is treated as a real pointer; no tagged-immediate confusion with a malloc
  address.
- `sfn_str_decode_owned(s) -> s` (`string.sfn:130`): pass-through, no arena
  dependency.
- **`sfn_str_sfn_from_cstr` (`string.sfn:624`) already adopts a foreign
  (non-arena, potentially malloc'd) buffer in place, no copy** — direct proof the
  runtime treats a malloc-backed string value as first-class. This is exactly the
  survivor shape.
- `sfn_str_len` (`string.sfn:307`) computes length by `strnlen` on `data` — works
  for any live buffer regardless of allocator; our relocation NUL-terminates, so
  this is byte-exact.
- `load_byte((s as i64) + idx)` (`string.sfn:133`) — a raw address load; allocator
  agnostic.

The **one** place arena residency could matter is grow-in-place append:
`sfn_str_append` (`string.sfn:778`) guards on `sfn_str_immediate_codepoint >= 0`
(always false) and delegates the grow to `sfn_arena_sfn_realloc`
(`arena.sfn:505`), which only extends in place when `ptr + old_size` equals the
current page's bump tip — **a malloc pointer never equals the arena's bump tip**,
so it always falls to the safe fresh-alloc + memcpy path. A malloc-backed string
is therefore correct under append too. Lowering never mutates the flat-text
string in place (it reads it into `parse_native_artifact_from_lines`), so no
append path is exercised on the survivor in practice.

**Conclusion: no runtime string assumption breaks when the survivor's `data` is
malloc-backed.** Cited: `string.sfn:128,130,307,624,778`; `arena.sfn:505,534`.

### 3.5 Scope of the shipped step

1. `compiler/src/arena_relocate.sfn` — new file; `relocate_string_to_heap` (and
   its symmetric `heap_free_string` / `heap_free` companion), built on the
   `malloc`/`calloc`/`free`/`memcpy` externs already declared in
   `runtime/sfn/memory/mem.sfn:33-37` and `arena.sfn:107-111`.
2. `compile_to_llvm_file_with_module_imports` (`main.sfn:667`) — adds the
   mark → join → relocate → rewind → lower → free bracket; gated by
   `SAILFIN_ARENA_PHASE_REWIND` (default ON).

`import_asm_paths` is a funnel parameter and therefore allocated before (below)
the mark; it requires no relocation — imports are re-loaded fresh from disk
post-rewind via the existing resolution path.

The `compile_to_llvm_with_module*` family and `print_llvm_with_module`
(`main.sfn:258,281,338`) are the `sfn emit llvm` / trace paths, **not** the build
path — out of scope for this step (a later step may bracket them too).

### 3.6 Rollback boundary

Revert the `main.sfn` bracket (restore the direct `write_llvm_ir_from_native_lines`
pass-through) and delete `compiler/src/arena_relocate.sfn`. Because the change
produces byte-identical `.ll` either way, reverting leaves no residual state.
The `SAILFIN_ARENA_PHASE_REWIND` gate (default ON) allows field disablement
without a rebuild; set `SAILFIN_ARENA_PHASE_REWIND=0` to restore pre-rewind
behavior.

## 4. Effect & capability impact

None. The arena mark/rewind and the malloc/free relocation primitives carry no
effect annotation (memory primitives sit below the I/O layer — `mem.sfn` /
`arena.sfn` headers). The bracket lives in a function already `![io]`; the
relocation helpers are effect-free `string -> string` / `void` functions.
No capability surface changes.

## 5. Self-hosting impact

`make compile` and `make check` are green.

- **No new frontend capability.** `relocate_string_to_heap` uses only `calloc`,
  `free`, `memcpy`, the `_num_put_byte` word-store idiom, and `SfnString`
  construction — all already expressible and lowered by the pinned seed
  (`mem.sfn`/`string.sfn`/`arena.sfn` already do exactly these). No new AST
  node, no new intrinsic, no new lowering path. The mark/rewind primitive is
  already in the seed and already emitted.
- **No seed cut.** One new file (`arena_relocate.sfn`) and one bracket in
  `main.sfn`. Both are ordinary Sailfin source the old seed already compiles;
  `make compile` builds the new compiler from the old seed in one self-host
  pass (per `.claude/rules/seed-dependency.md`: source-only → no seed cut).
- **Pipeline logic unchanged.** Only the *orchestration* in `main.sfn` changes
  (when the arena is reclaimed and where the survivor lives). Every module's
  emitted `.ll` is **byte-identical** before and after — confirmed by the e2e
  test `compiler/tests/e2e/arena_phase_rewind_ll_identity_test.sfn` and
  `make check`'s triple-pass.

## 6. Alternatives considered

### Superseded approach: relocate the two `string[]` artifacts

The original design relocated both `native_lines: string[]` and
`imported_native_texts: string[]` to malloc by walking each array and copying
each element's `data` pointer to a fresh heap buffer, then rebuilding the array
spine on the heap. This was chosen because the two arrays were the only
lowering-consumed survivors and the per-element copy was straightforward.

**Why it was superseded:** A `string[]` returned by a Sailfin helper has an
ARENA-allocated container (the `SfnArray` metadata struct and element-pointer
array). After `sfn_arena_sfn_rewind(mark)`, that container is reclaimed; the
post-rewind read of `native_lines.length` (and any element access) was a
use-after-free, producing a SIGABRT in practice. The element `data` pointers
themselves were correctly moved to the heap, but the array metadata holding the
count and element array pointer was not — and there is no array container free
in the Sailfin runtime to move just the spine independently.

The flat-string approach is strictly simpler: there is no container at all (a
`string` is a by-value `{data, len}` pair, not a heap-allocated object), so the
only thing that needs relocation is the `data` buffer. The re-split overhead
(join then re-parse) is correctness-neutral and wall-clock-neutral at scale.
This also retires the `imported_native_texts` relocation entirely:
`import_asm_paths` (the path list, not the file contents) is a funnel parameter
allocated before the mark and survives natively; the actual import text is
re-read from disk post-rewind via the normal resolution path.

### Mechanism (b): compacting move

Relocate survivors *down* over the reclaimed region, park the bump pointer above
them. Rejected: needs a **new arena primitive** that moves live bytes and
re-seats `used`, and it changes pointer identity mid-arena, which is far riskier
than a malloc round-trip and larger than one file + one bracket. No benefit over
the shipped approach at this scale.

### Mechanism (c): serialize to `.sfn-asm` / temp, rewind, re-read

Rejected. The build's `_cr_stage_one` writes only the *import-context*
`.sfn-asm` (siblings), not this module's own IR consumed by its lowering; and the
funnel's own `native_lines` is not persisted before lowering. Adding a write+read
reintroduces the filesystem-IPC cost `0006` is eliminating and is slower than the
in-memory malloc copy.

### Lever B: grow-in-place `sfn_str_concat`

Deferred as an *additive* step. It has no survivor problem (it changes only how a
single concat allocates, not the arena lifecycle), but it is concat-specific
(helps 2–3 modules per the correlation data) and largely *subsumed* by the
shipped approach (the prefix churn it avoids is front-half garbage the rewind
already reclaims). Lever B could add a small incremental win on
`core_operands`/`core_literals_lowering` after this ships.

### Rewind without relocation

**Withdrawn as incorrect.** Under a pure bump allocator a survivor cannot be
placed below a pre-parse mark; the copy is reclaimed by the same rewind. The
existing loop-body rewind precedent (`instructions_for.sfn:259`, gated by
`loop_body_rewind_eligible`) only rewinds when **nothing** escapes the body —
the clean no-survivor case — confirming rewind is only safe with no in-arena
survivor.

### Disable the arena

Rejected by the data: `SAILFIN_USE_ARENA=0` raises peak RSS via libc
fragmentation (1505 MB vs 972 MB on `core_operands`).

## 7. Cost / risk (honest accounting)

- **Cost is one-time O(native-IR bytes) per module** — one calloc + memcpy of
  the flat native text, matching the order of the `lines_to_native_text` join
  lowering already performs. This is dwarfed by the AST/typecheck garbage freed
  (megabytes reclaimed for kilobytes-to-low-megabytes copied), so net peak falls.
- **The malloc survivor is libc-backed and freed explicitly** after lowering, so
  it adds a small transient libc-heap footprint *during lowering* (bounded by the
  native-IR text size) that the arena would otherwise have held — a wash to a win,
  since the reclaimed front half is far larger.
- **Known regressions: 2 modules.** `capsule_resolver` +18%,
  `core_literals_lowering` +8% — small front-half modules where the
  relocated-text copy is larger than the reclaimed garbage. Neither sets the new
  build peak. Candidate follow-up: size-gate the rewind (skip for modules whose
  native-IR text exceeds reclaimed bytes), or a #1817-preserving relocation.
- **The flat-text entry reintroduces a join/re-split** that #1817 removed. This
  is correctness-neutral (byte-identity proves it) and wall-clock-neutral at
  scale (−0.5% sum wall, within noise). It is a small fixed overhead.
- **Risk — a missed survivor read.** If some path reads arena data *after* the
  rewind that was not moved to the heap, it reads reclaimed memory. Mitigation:
  the bracket replaces the argument at the single call site; the byte-identical-`.ll`
  gate and the triple-pass self-host catch any miss immediately.

## 8. Stage1 readiness mapping

- [x] Parses / type-checks / effect-checks — N/A (no syntax change); the bracket
      and helpers type/effect-check as ordinary calls.
- [x] Emits valid `.sfn-asm` — unchanged; byte-identical per module.
- [x] Lowers to LLVM IR — every module's `.ll` **byte-identical** (confirmed).
- [x] Regression coverage — `compiler/tests/e2e/arena_phase_rewind_ll_identity_test.sfn`.
- [x] Self-hosts — `make compile` (source-only, no seed cut) + `make check` (green).
- [x] `sfn fmt --check` clean on `main.sfn` + `compiler/src/arena_relocate.sfn`.
- [ ] Documented in `docs/status.md` + `0006-build-architecture.md` perf section.

## 9. Test plan

**Correctness (green before measuring):**

1. `make compile` — new compiler self-hosts from the old seed.
2. **Byte-identical `.ll` gate** —
   `compiler/tests/e2e/arena_phase_rewind_ll_identity_test.sfn` compiles a
   representative fixture with `SAILFIN_ARENA_PHASE_REWIND=1` vs `=0` and asserts
   identical `.ll` via `expect_snapshot`. Zero diffs is the pass.
3. `make check` — triple-pass self-host + suite on the seedcheck binary.

**Measurement (the win):**

4. `make bench` full run — expect a reduction on **every** module (global win);
   measured results recorded in §1 Summary.
5. **Spot check two modules** to prove the win is global, not concat-specific:
   - `llvm/expression_lowering/native/core_operands` (concat-dense, 1,210 MB).
   - `parser/expressions` (concat-sparse, 855 MB).
   Both must drop; a comparable *percentage* drop on the concat-sparse module is
   the decisive evidence that the rewind (not concat churn) is the driver.

## 10. Future considerations

- **Stage E long-lived driver** (`0006`): the pre-parse mark becomes the
  per-module reset point; the survivor relocation composes unchanged.
- **Lever B (grow-in-place concat)**: layer on after this ships, measured against
  the new baseline; likely a small additive win on `core_operands` /
  `core_literals_lowering` only.
- **Parallel builds** (`0006`): unaffected — arena is process-global, each worker
  is its own process, malloc survivors are per-process.
- **Size-gate the rewind**: for the 2 known-regression modules, skip the rewind
  when the module's native-IR text is smaller than some threshold (i.e., when the
  copy cost exceeds the reclamation benefit). This is a follow-up optimization,
  not a correctness issue.

## 11. References

- Shipped implementation: `compiler/src/arena_relocate.sfn`
  (`relocate_string_to_heap`), bracket in `compiler/src/main.sfn:667`.
- Arena: `runtime/sfn/memory/arena.sfn:620` (mark), `:656` (rewind — reclaims
  everything after the mark), `:505,534` (grow-if-at-tip realloc).
- No-op free: `runtime/sfn/memory/mem.sfn:185-189`; malloc/free/memcpy externs
  `mem.sfn:33-37`, `arena.sfn:107-111`.
- String domain (no arena-residency assumption): `runtime/sfn/string.sfn:128`
  (immediate_codepoint), `:130` (decode_owned), `:307` (sfn_str_len), `:624`
  (`sfn_str_sfn_from_cstr` adopts a foreign buffer in place), `:778`
  (`sfn_str_append` grow guard).
- Liveness boundary: `compiler/src/main.sfn:667`, `:574`
  (`write_native_text_file_with_module`); `compiler/src/llvm/lowering/lowering_core.sfn:432`;
  `compiler/src/emit_native.sfn:164,192`.
- Build model: `compiler/src/capsule_resolver.sfn:966` (`_cr_stage_one`, native
  staging), `:1527` (`_cr_compile_one`, in-process re-parse+lower);
  `docs/proposals/0006-build-architecture.md` §2.4 (process-per-module), "Stage E".
- Prior art (rewind only when no survivor): `compiler/src/llvm/lowering/instructions_for.sfn:259`,
  `instructions_helpers.sfn:339` (`loop_body_rewind_eligible`).
- Correctness gate: `compiler/tests/e2e/arena_phase_rewind_ll_identity_test.sfn`.
- Seed-cut policy: `.claude/rules/seed-dependency.md` (source-only → no seed cut).
- Baseline: `build/bench-baseline.txt`, `build/bench-baseline-summary.md`.
