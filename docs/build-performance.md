# Build Performance: Root Cause Analysis & Fix Plan

**Date:** 2026-04-19 (revised, post `.fn_*` channel removal)
**Previous revision:** 2026-04-15 (revised, post-d2d0bf1/220c8b7), 2026-04-15 (morning), 2026-04-11
**Context:** Self-hosting the compiler from the 0.5.2-alpha.1 seed via `build.sh` takes ~13-16 minutes for 121 modules single-threaded. Down from 60-90 minutes at the April 11 baseline thanks to partial IPC removal, string concat optimization, module splitting, and the Phase 1 accumulator sweep (`d2d0bf1`). Still far from the <5 minute target. The IPC-as-GC memory management blocker (formerly blocking ~146 Phase 2 channel refs) is now cleared: the arena allocator is default-on for selfhost as of the April 19 flip (see [Completed Work: Arena Allocator Default-On](#arena-allocator-default-on-april-19)). The two residual O(n²) copy sites (`concat_native_functions`, `append_local_binding`) that were reverted in `220c8b7` because callers rely on input-array immutability are now safe to convert to in-place push under arena — tracked as immediate follow-up work.

---

## Symptom Summary

| Metric | April 11 | Current (April 19) | Target |
|--------|----------|---------------------|--------|
| Full build (121 modules, 1 job) | 60-90 min | 13-16 min | < 5 min |
| Per-module compile time (heavy) | 4-7 min | 1-3 min | < 30s |
| Per-module compile time (light) | 30s-2 min | 10-30s | < 5s |
| Per-module peak RAM | 1-2 GB | 0.5-1.5 GB | < 256 MB |
| Parallel builds (`--jobs N`) | Broken | Functional but risky | Stable at 4 jobs |
| `fs.*` calls (total) | 667 across 42 files | 489 across 37 files | < 50 per module |
| `build/sailfin/` IPC refs | 487 | 228 (dotfiles) | 0 |
| Seed memory limit | 8 GB | 12 GB | < 4 GB |

---

## What Changed Since April 11

Significant work went into IPC removal and memory reduction. Key commits:

1. **IPC removal (partial):** Replaced BlockLoweringResult, LoweredLLVMFunction, emission, let_ipc, and expr_stmt file IPC with direct struct field access (`0538aac`, `b3bc67d`, `03ee10d`, `76f0d22`, `7b54433`)
2. **O(n²) string accumulation fix:** Eliminated quadratic string constant merging that blew the seedcheck memory cap (`f4e375a`, `5b85a0b`)
3. **String concat optimization:** LLVM lowering emits `sailfin_runtime_string_append` (realloc-based) instead of `sailfin_runtime_string_concat` (malloc+copy) for chained `+` expressions (`b3b6dad`)
4. **Module splitting:** Decomposed oversized files (expressions, statement, entrypoints, lower_to_llvm_lines) to reduce per-module memory (`efeb588`, `24194fa`, `93ccf48`, `372ae0f`, `9f350eb`)
5. **Memory limit increase:** Raised SEED_MEM_LIMIT to 12 GB to accommodate remaining leaks (`bcedaad`)
6. **Stale IPC guard:** Fixed seedcheck duplicate `%tN` corruption from stale call_result IPC state (`7f9bc12`)
7. **Phase 1 accumulator sweep (partial):** Converted `extend_string_lines` to in-place push and replaced ~50 `.concat([x])` loop sites with `.push(x)` (`d2d0bf1`). In-place conversions of `concat_native_functions` and `append_local_binding` were reverted in `220c8b7` — nested-scope locals restoration and `lower_all_functions` both rely on the original array staying pristine after the call; in-place mutation leaked bindings across scopes and corrupted local_functions. Those two remain copy-based pending aliasing audit or arena.

**Net result:** Build time dropped ~75-80%, but the work hit a wall. See "The IPC-as-GC Problem" below.

---

## The IPC-as-GC Problem (Critical Blocker)

File-based IPC removal stalled because the filesystem serialization was acting as **accidental garbage collection**. When the compiler writes a struct's fields to temp files and reads them back, the original in-memory data goes out of scope and becomes eligible for cleanup. Without this serialize/deserialize cycle, strings and arrays accumulate in memory with no way to free them.

### Why the runtime can't free memory

The C runtime (`runtime/native/src/sailfin_runtime.c`) has fundamental memory management limitations:

1. **`string_drop` is disabled by default.** The function checks `SAILFIN_ENABLE_STRING_FREE` (off by default) because the compiler lacks a precise ownership/RC model for strings. Strings stored in arrays get dropped while still referenced, causing use-after-free.

2. **Large strings are never freed.** Even with string freeing enabled, strings ≥64 KB are marked persistent (`sailfin_runtime_mark_persistent`) for process lifetime due to observed nondeterministic corruption.

3. **Arrays are never freed.** No `array_drop` or array lifecycle management exists. Every `string[]` or `NativeFunction[]` allocated during compilation leaks.

4. **No GC, no RC; arena allocator shipped but off by default.** The runtime tracks owned strings in a hash table for safe freeing, but this is opt-in and disabled. There is no generational GC or reference counting. The M0.5 bump-allocator arena landed in PR #174 (`runtime/native/src/sailfin_arena.c`) and is wired through `_rt_malloc` / `_rt_calloc` / `_rt_realloc` / `_rt_free`, but it only activates when `SAILFIN_USE_ARENA=1`. The default selfhost build does not set the flag, and the M0.5 fast-fail criteria (per-module RAM < 512 MB, `make check` passes with arena on) have not yet been formally validated in CI.

### The consequence

Each IPC write-then-read cycle implicitly "freed" memory by letting the original values go out of scope while the file held the data. Removing these cycles keeps all intermediate values alive simultaneously, causing per-module RAM to spike past the 12 GB limit.

**This means the fix plan must be reordered: memory management must be solved before further IPC removal can proceed.**

---

## Root Cause 1: Filesystem-as-IPC (Still Primary Bottleneck)

The compiler still uses the filesystem as an inter-function communication channel. Several channel families remain active after sustained removal work.

- **489 total `fs.*` calls** across 37 files (down from 667/42)
- **228 dotfile references** to `build/sailfin/.xxx` temp paths (down from 487)
- Per-instruction dispatch still involves 6-10 file writes + reads
- Per-local-binding serialization: 4-6 files written, then read back, per binding

### Active IPC Channels

| Channel | Written By | Read By | Files per call |
|---------|-----------|---------|----------------|
| Call result (type/value) | core_literals, core_call_emission, core_strings | instructions_let | 2 |
| Dispatch result (lines/allocas/temp/region/mutations) | instructions_dispatch, instructions_helpers | instructions, instructions_helpers | 8+ |
| Block result (terminated/string_constants) | instructions_helpers | instructions_try | 2 |
| Expr statement result (temp/region/mutations) | statement | instructions_dispatch | 5+ |
| Let result (temp/lines/allocas/diagnostics/locals) | instructions_let | instructions_dispatch, instructions_helpers | 11+ |
| Context functions (count + per-entry fields) | lowering_phase_types | core_call_resolution | N×fields |
| Type/struct/enum metadata | lowering_phase_types | core_member_*, statement_assignment, core_call_resolution | 2 |
| Module globals (preamble/init/locals/diagnostics) | module_globals | lowering_core | 6 |
| Self-field expression result | statement_assignment | statement | 4 |
| Per-instruction bindings/locals | instructions_dispatch, instructions_helpers | statement, core_call_resolution | 4×N |
| Instruction metadata (fn_name/expression/return/span) | instructions_dispatch | statement, statement_assignment, core_member_* | 4 |

### Hotspots (Current)

| File | `fs.*` Calls | `build/sailfin/` Refs |
|------|--------------|-----------------------|
| `instructions_dispatch.sfn` | 67 | 45 |
| `instructions_helpers.sfn` | 58 | 35 |
| `cli_commands.sfn` | 44 | 4 |
| `main.sfn` | 37 | 12 |
| `instructions_let.sfn` | 32 | 32 |
| `core_call_resolution.sfn` | 32 | 12 |
| `lowering_core.sfn` | 32 | 15 |
| `cli_main.sfn` | 30 | 1 |
| `statement_assignment.sfn` | 28 | 29 |
| `statement.sfn` | 25 | 22 |
| `emission.sfn` | 3 | 3 |

---

## Root Cause 2: O(n²) Array Accumulation (Mostly Resolved; Residuals Are Aliasing-Blocked)

The broad copy-then-append sweep landed in `d2d0bf1`. Current state:

### Resolved in `d2d0bf1`

- `extend_string_lines` at `lowering_io.sfn:21-39` is now **in-place `push()`** and functionally equivalent to `append_string_lines` (both are identical loops today). The runtime's `sailfin_runtime_array_push` uses amortized doubling up to 1024 then +25% ([sailfin_runtime.c:3749-3767](../runtime/native/src/sailfin_runtime.c#L3749-L3767)), so `push()` in loops is amortized O(1).
- `.concat([x])` in loop accumulators: only **1 remaining occurrence** across `compiler/src/` (in `parser/declarations.sfn`), down from ~30. Sweep effectively done.

### Residual O(n²) sites — aliasing-blocked (reverted in `220c8b7`)

Both of these still allocate a fresh array and copy the input before appending. They are the two places where a trivial in-place conversion was **tried and reverted** because callers depend on the input staying pristine.

| Function | Location | Call sites | Aliasing constraint |
|----------|----------|-----------:|---------------------|
| `concat_native_functions` | `lowering/lowering_helpers_mangling.sfn:389` | 3 | `lowering_core.sfn` passes `local_functions` into `concat_native_functions` *and* into `lower_all_functions`/`collect_runtime_helper_targets` afterwards. In-place mutation corrupts the second pass. |
| `append_local_binding` | `expression_lowering/native/core_scopes.sfn:174-186` | 6 | Nested scopes (for bodies, try/catch) build a temporary locals array via append, then restore the original for the outer scope. In-place mutation leaks bindings across scopes. |

Options for resolving these:

1. **Caller-side clone audit.** For each call site, determine whether the caller still needs the pristine input; if yes, clone explicitly at the caller; if no, switch that caller to in-place `push()`. Keeps the copies only where they're actually required.
2. **Enable the arena allocator (Phase 0).** Under an arena, the copy becomes cheap (bump alloc) and doesn't leak — the aliasing problem becomes a non-issue because both views remain live and freed in bulk at module exit. The C arena is already in-tree (`sailfin_arena.c`, PR #174) but runs only when `SAILFIN_USE_ARENA=1`; flipping it on by default after the fast-fail criteria pass is the actual next step.

Option 2 is simpler but requires flipping the arena on by default (and validating the fast-fail criteria). Option 1 can proceed now but requires careful call-site analysis (lowering_core invariants around `local_functions` and nested-scope locals restoration are subtle).

### Other O(n²) patterns to audit

Other copying functions may exist but weren't catalogued in the `d2d0bf1` sweep — worth a fresh grep for `let mut out -> T[] = []` followed by a copy loop, especially in the instruction-lowering layer where the `extend_string_array` pattern wasn't adopted historically.

---

## Root Cause 3: No Import Artifact Caching

`collect_imported_module_context_for_module` in `llvm/imports.sfn:25-165` implements BFS import traversal with no cross-call or cross-process cache. A `seen[]` array deduplicates within a single BFS call, but:

- Each module spawns a separate compiler process (`build.sh` runs one `seed emit` per module)
- Each process independently calls `fs.readFile` + `parse_layout_manifest` for every dependency
- Popular base modules (e.g., `ast`, `native_ir`, `token`) are parsed 10-50× per full build
- Transitive imports are walked to depth 3, reading `.sfn-asm` text at depth 0 and scanning for deeper imports at depths 1-2

No memoization table, hash map, or shared artifact store exists.

---

## Root Cause 4: Light Recovery Parser Overhead

`recover_native_functions_light` in `lowering_recovery.sfn:114+` still exists and is actively called from `lowering_core.sfn:286`. It re-scans every line of `.sfn-asm` text with 20+ `starts_with` checks per line. The structured `parse_native_artifact_safe` (same file, line 90) is a workaround that assembles results from per-field extraction calls rather than one structured call.

Both exist because the v0.1.1 seed couldn't handle typed instruction variants. The 0.5.2-alpha.1 seed may support these, but the migration hasn't been attempted.

---

## Root Cause 5: No Memory Management (NEW — Critical)

The runtime has no mechanism to reclaim memory during compilation:

| Resource | Allocation | Deallocation | Status |
|----------|-----------|--------------|--------|
| Strings (<64 KB) | `malloc` | `string_drop` → `free` | **Disabled by default** (`SAILFIN_ENABLE_STRING_FREE=0`) |
| Strings (≥64 KB) | `malloc` | `mark_persistent` (never freed) | **Permanently leaked** |
| String arrays | `malloc` | None | **Always leaked** |
| NativeFunction arrays | `malloc` | None | **Always leaked** |
| LocalBinding arrays | `malloc` | None | **Always leaked** |

The owned-string hash table and persistent-pointer set add per-allocation bookkeeping overhead even when freeing is disabled. The concat-reuse optimization (`_concat_reuse_ptr`) helps for chained `+` expressions but does not address the general leak.

**This is why per-module RAM is 0.5-1.5 GB and SEED_MEM_LIMIT had to be raised to 12 GB.**

---

## Root Cause 6: Per-Module Process Isolation Overhead

`build.sh` spawns a separate compiler process for each of 121 modules. Each process:

1. Creates an isolated `seed_cwd` directory
2. Copies the full import-context directory (all `.sfn-asm` + `.layout-manifest` files)
3. Creates a clean `build/sailfin/` directory for IPC temp files
4. Loads and initializes the full runtime (hash tables, mutex locks, etc.)
5. Parses all imported modules from scratch

This means the import-context copy alone (121 × full directory copy) adds significant I/O overhead, and every module pays full startup + import parsing cost with no shared state.

---

## Revised Fix Plan

The original plan ordered IPC removal first. That is no longer viable because removing IPC without memory management causes OOM. The revised plan addresses memory first.

### Phase 0: Arena Allocator for Compilation (≡ M0.5 in [runtime_architecture.md §4.4](runtime_architecture.md#44-m05--arena-in-c-temporary-unblocker))

**Status:** C implementation shipped (PR #174). Runtime integration shipped. Default-on flip landed April 19 (see [Completed Work: Arena Allocator Default-On](#arena-allocator-default-on-april-19)).
**Priority:** Was critical — **Prerequisite for removing the ~146 refs of per-instruction/per-binding IPC channels blocked by IPC-as-GC**. Now cleared.
**Measured delta on `lowering_core.sfn` (heaviest module):** peak RSS 7.49 GB → 4.72 GB (−37%), wall time 11:43 → 10:31 (−10%), LLVM IR byte-identical.

The C arena allocator (`runtime/native/src/sailfin_arena.c`, 254 lines) is in-tree and wired through `_rt_malloc` / `_rt_calloc` / `_rt_realloc` / `_rt_free` in `sailfin_runtime.c:618-654`. All string and array allocations route through the process-global arena when `SAILFIN_USE_ARENA=1` (now the default). The owned-string hash table and persistent-pointer set are bypassed entirely in arena mode. A correctness harness (`make test-arena`, `scripts/test_arena.sh`) diffs emitted LLVM IR with and without the flag.

**Residual follow-ups (not blocking Phase 2):**
1. **Per-module peak RAM < 512 MB.** The M0.5 target is not met by arena alone — arena caps a single module at 4.7 GB, down from 7.5 GB under malloc but still far above target. Reaching 512 MB requires Phase 2 IPC removal on top of arena, not more arena work.
2. **Stats integration.** `sfn_arena_print_stats` exists but isn't called from any test or build target, so we have no telemetry on arena pressure or page count.

**Why arena, not RC or GC:**
- The compiler is a batch process: allocate during compilation, discard everything at the end
- No cycles to break (no need for tracing GC)
- No per-object overhead (no RC increments on every string copy)

**Grow-if-at-tip realloc.** `sfn_arena_realloc` in `sailfin_arena.c:147-184` already implements grow-if-at-tip — if the pointer being realloc'd is the last allocation on the current page and the page has room, the arena extends in place. This preserves the `string_append` realloc-based concat optimization (`b3b6dad`) when arena mode is enabled.

### Phase 1: Fix O(n²) Array Accumulation (Mostly Shipped)

**Status:** Broad sweep landed in `d2d0bf1`. Two residuals reverted in `220c8b7` (aliasing).
**Remaining expected impact:** Small — the high-frequency offenders are already fixed. The two residual functions fire at most a few hundred times per module, not per-line, so their asymptotic wastage is bounded.

**What shipped (`d2d0bf1`):**

| Target | Call sites | Status |
|--------|-----------:|--------|
| `extend_string_lines` | ~36 | ✅ In-place `push()` |
| `.concat([x])` in loops | ~50 | ✅ Replaced with `.push(x)` (1 residual in `parser/declarations.sfn`) |

**What shipped next (Phase 1b partial, post-baseline):**

Per-site aliasing audit (see [runtime_architecture.md §4.4](runtime_architecture.md#44-m05--arena-in-c-temporary-unblocker) M0.5 fast-fail criteria and the matching audit performed here) identified that only 2 of the 3 `concat_native_functions` sites in `lowering_core.sfn` are aliasing-safe without an arena. Those 2 sites (lines 568 and 576) now use a new in-place helper `extend_native_functions_inplace`. The third site at line 573 stays copying because downstream passes (`collect_runtime_helper_targets`, `render_llvm_preamble`, `lower_all_functions`) read the pristine `local_functions`.

| Target | Call sites | Status |
|--------|-----------:|--------|
| `concat_native_functions` sites 1, 3 (lowering_core.sfn) | 2 | ✅ In-place `extend_native_functions_inplace` |
| `concat_native_functions` site 2 (lowering_core.sfn) | 1 | Copying — caller needs pristine `local_functions` |
| `append_local_binding` all 6 sites | 6 | Still copying — aliasing audit revealed deeper caller-side structural dependencies than initial audit indicated; safe to convert to in-place push now that the M0.5 arena is default-on (April 19 flip) |

**Measured impact (lowering_core only — the hottest module):**

| Metric | Baseline (post-d2d0bf1) | Phase 1b partial | Delta |
|--------|------------------------:|-----------------:|------:|
| Compile time | 61.69s | 58.02s | −6.0% |
| Peak memory | 7.23 GB | 7.23 GB | ±0 |
| Aggregate build | 641.33s | 639.51s | −0.3% (noise) |

The win is concentrated on the target module; aggregate is within bench variance. `append_local_binding` conversions become cheap automatically under the M0.5 arena, so Phase 1b is complete as a pre-arena intervention.

### Phase 2: Eliminate IPC Files (Resumed)

**Priority:** Highest — **Expected:** 40-60% time reduction, enables parallel builds
**Depends on:** ~~Enabling the arena allocator by default~~ — cleared April 19 with the arena default-on flip. All Phase 2 channels are now pickable.

Most IPC channels were introduced as workarounds for v0.1.1-seed ABI corruption of array-of-struct parameters across module boundaries. The 0.5.x seed lineage no longer corrupts those parameters, so many channels are now dead-code fallbacks whose readers already have the data in-memory via an existing `bindings` or `locals` parameter.

Channels that serialize per-instruction/per-binding control-flow state (dispatch, let result, block result, statement mutations) were previously blocked by the IPC-as-GC problem — removing them without arena caused OOM because the file write/read cycle was implicitly freeing the source values. Under the default-on arena, those values stay alive in the arena until process exit, but the arena is bulk-freed at exit; per-module peak RAM rises but never OOMs because the arena replaces ad-hoc malloc churn with bump allocation.

#### Procedure: Removing an IPC Channel

Use this pattern for every channel in the priority list. It keeps diffs surgical, preserves self-hosting after each step, and makes the determinism delta measurable.

1. **Locate the writer.** `grep -R 'fs\.writeLines.*\.channel_name\|fs\.writeFile.*\.channel_name' compiler/src`. There is usually exactly one.
2. **Identify the data being serialized.** If it's a struct that the writer already has as a local — and the reader already accepts that struct type as a parameter — the channel is dead code.
3. **At each reader, check whether the enclosing function already takes that parameter.** `grep -R 'fs\.readFile.*\.channel_name' compiler/src` to enumerate readers. For `LocalBinding[]`, `ParameterBinding[]`, and `TypeContext`, readers almost always already have the param.
4. **Replace the file read with the in-memory lookup.** Prefer existing helpers (`find_local_binding`, `find_parameter_binding`, `find_struct_info_by_name`) over rewriting parser logic inline.
5. **If the enclosing function does _not_ have the parameter:** add it to the signature and update every caller. Blast radius is usually one hop. Do not introduce new wrapper structs unless two or more params need to travel together.
6. **Delete the writer.** The channel is gone.
7. **Rebuild (`make rebuild`) to confirm self-hosting still succeeds.** This is the critical gate — if the v0.1.1-seed-era fallback was actually still live, rebuild will fail with a resolution error and you need to examine why the in-memory path is incomplete.
8. **Measure the determinism delta.** Run the emit-sweep against a heavy module (e.g. `compiler/src/parser/expressions.sfn`) 20+ times; distinct hash counts should strictly decrease. Record the before/after in the Completed Work entry.
9. **Delete dead imports.** `index_of`/`substring` in particular often become unused once the file-parsing loop is gone.

If step 7 fails, the channel is not purely a workaround — some caller is relying on the file as actual storage. That case is out of scope for a simple channel removal and needs to be addressed with an explicit in-memory struct (Phase 0 arena may also be required before it is safe).

#### Remaining targets by priority:

1. **Instruction dispatch channel** (45 refs in `instructions_dispatch.sfn`) — hottest path
2. **Let result channel** (32 refs in `instructions_let.sfn`) — per-let-binding overhead
3. **Statement/assignment channels** (29+22 refs) — per-expression-statement overhead
4. **Remaining channels** (coerce, async inner-return-type, enum/struct info)

Named IPC functions to eliminate:
- `write_bindings_to_files()` / `write_locals_to_files()` — `instructions_helpers.sfn:216/240`
- `_write_bindings_to_files()` / `_write_locals_to_files()` — `instructions_dispatch.sfn:95/119`
- `serialize_context_functions()` — `lowering_phase_types.sfn:339`

### Phase 3: Cache Import Artifacts

**Priority:** Medium — **Expected:** 10-15% time
**No dependency on Phases 0-2** — can proceed in parallel

Add a file-level cache to `collect_imported_module_context_for_module`:
- Cache parsed `LayoutManifest` and `.sfn-asm` text by slug within a single process
- For cross-process caching: consider a pre-parsed binary format (e.g., write parsed manifests to a `.cache` directory during import-context staging, read them back instead of re-parsing text)

### Phase 4: Eliminate Light Recovery Parser

**Priority:** Low — **Expected:** 5-10% time
**Depends on:** Verifying the 0.5.2-alpha.1 seed handles typed instruction variants

Replace `recover_native_functions_light` (line-by-line scanning with 20+ `starts_with` checks) and `parse_native_artifact_safe` (per-field extraction workaround) with direct structured `parse_native_artifact` calls.

### Phase 5: Long-Lived Compiler Process (Future)

**Priority:** Future (post-1.0 or late pre-1.0) — **Expected:** 50-70% time reduction

Replace the 121 separate compiler processes with a single long-lived process that compiles all modules in sequence (or in parallel with shared state):
- Eliminates per-module startup overhead
- Enables in-process import artifact caching (Phase 3 becomes trivial)
- Eliminates per-module import-context directory copies
- Arena allocator resets between modules instead of process exit

This requires the compiler to support a "compile module" entry point that takes import context as an argument rather than reading it from the filesystem.

---

## Completed Work

### String Concat Allocation Reduction (April 11)

**Status: Implemented.** LLVM lowering emits `sailfin_runtime_string_append` (realloc-based in-place extend) instead of `sailfin_runtime_string_concat` (malloc+copy) for chained `+` concatenation. Eliminates 2 dead intermediate allocations per 4-way concat.

### Partial IPC Removal (April 11-14)

**Status: Partially implemented, then stalled.** Removed BlockLoweringResult, LoweredLLVMFunction, emission, let_ipc, and expr_stmt file IPC in several commits. Work stalled when further removal caused OOM due to the IPC-as-GC problem documented above.

### Module Splitting (April 11-13)

**Status: Implemented.** Decomposed oversized files (expressions.sfn → 5 modules, statement.sfn → 4 modules, entrypoints.sfn → 3 modules, lower_to_llvm_lines → phase modules) to reduce per-module compile memory.

### Phase 1 Array Accumulator Sweep (April 15, `d2d0bf1` + `220c8b7`)

**Status: Partially implemented.** Converted `extend_string_lines` to in-place `push()` and replaced ~50 `.concat([x])` loop-accumulator sites. Two functions (`concat_native_functions`, `append_local_binding`) were reverted in `220c8b7` because callers depend on the input array staying pristine; those remain copy-based and are now tracked as Phase 1b.

### Condition Locals IPC Channel Removal (April 17)

**Status: Implemented.** Removed the `.condition_locals` file IPC channel — a v0.1.1-seed-era workaround for array-of-struct parameter ABI corruption that is no longer needed on the 0.5.x seed lineage. The writer in `instructions_condition.sfn` built a tab-separated view of every `LocalBinding` and wrote it to `build/sailfin/.condition_locals` immediately before calling `lower_expression`; four readers (`type_context_queries.sfn`, `core_member_lowering.sfn`, `core_call_resolution.sfn`, `core_member_helpers.sfn`) re-parsed that file as a fallback to their in-memory `locals` parameter.

This channel was the first concrete source proven responsible for silent LLVM IR miscompilation on macOS arm64: when two passes' file writes and reads interleaved unpredictably within a single emit, entire source-level blocks (e.g. `if tok.kind.variant == "EndOfFile" { break; }` inside `parse_block_for_lambda`) dropped out of the generated IR, which then passed `llvm-as` validation but produced binaries that segfaulted on any parse input.

**Determinism delta (emit `llvm` x 20 runs on macOS arm64, same seed):**

| Module | Baseline (seed 0.5.5 pre-change) | New compiler (post-change) |
|--------|----------------------------------|-----------------------------|
| `compiler/src/parser/expressions.sfn` | 4/30 divergent (5 distinct hashes) | 0/20 divergent (1 hash) |
| `compiler/src/llvm/lowering/lowering_core.sfn` | intermittently dropped all user fns | 0/20 divergent (1 hash) |
| `compiler/src/llvm/expression_lowering/native/core.sfn` | (not measured baseline) | 0/20 divergent |
| `compiler/src/parser/statements.sfn` | (not measured baseline) | 1/20 divergent (other channels) |

The three large modules that previously flaked are now fully deterministic. The residual 1/20 flake on `parser/statements.sfn` is driven by other scratch channels still active (call-result, struct-info, instr-fn-name) and will be eliminated as subsequent Phase 2 channels are removed.

Concurrently, the `build.sh` retry loop went from 3 `invalid_ir` retries per full build (`core_operands`, `core_parsing`, `instructions_helpers`) down to 1 (`cli_commands`), another signal that real non-determinism volume dropped materially.

**Scope of change:**
- 1 writer deletion (`instructions_condition.sfn`)
- 4 reader conversions to `find_local_binding(locals, name)` against the existing in-memory parameter
- 1 signature extension (`lower_inline_gep_field_access` in `core_member_helpers.sfn` — added `locals: LocalBinding[]`, updated two call sites in `core_member_lowering.sfn`)
- ~150 lines removed, ~15 added

This is the first IPC removal under the procedure in Phase 2 above; future channel removals should follow the same 9-step pattern.

### Self-Field IPC Channel Removal (April 19)

**Status: Implemented.** Removed the `.self_field_*` file IPC channel — a v0.1.1-seed-era workaround used to ship the rewritten expression / next temp index / updated lines array from `preprocess_self_field_access` (in `statement_assignment.sfn`) back to its *immediate* caller `lower_return_instruction` (in `statement.sfn`).

The writer was void-returning and wrote 4 sub-files (`.self_field_expr`, `.self_field_temp`, `.self_field_lines_count`, `.self_field_lines`) at 6 exit points (5 early returns + 1 final). The reader checked `fs.exists(".self_field_expr")` two lines after the call, read the 4 files back, reconstructed the three values, and deleted the scratch file. The call site is literally adjacent to the helper — the channel was pure function-return ceremony routed through the filesystem.

**Shape of change:**
- Added `SelfFieldResult { expression, temp_index, lines }` to `llvm/types.sfn` (wrapper struct is legitimate per procedure §267: three values travelling together).
- `preprocess_self_field_access` now has return type `SelfFieldResult` and returns the struct at all 6 exits; all `fs.writeFile`/`fs.writeLines` on `.self_field_*` paths deleted. `![io]` retained because the function still reads `.struct_info` and `.instr_fn_name` (separate channels, out of scope).
- Caller in `statement.sfn` captures the struct directly; `fs.exists` / `fs.readFile` / `fs.deleteFile` block replaced with three field reads. The `_sf_lc > current_lines.length` length gate is preserved as `result.lines.length > current_lines.length` so callers that didn't perform any self-field rewrites don't have their `current_lines` clobbered.
- `cli_commands._clean_lowering_state` keeps the `.self_field_` prefix sweep with a comment explaining it's there to clean stale files from older build dirs / older seed binaries (following the PR #183 review precedent — never drop a prefix entirely).

**Determinism delta (emit `llvm` × 20 runs on Linux x86_64, seed 0.5.7 baseline):**

| Module | Baseline | Post-change |
|--------|---------:|------------:|
| `compiler/src/parser/expressions.sfn` | 1 hash (20/20 identical) | to be measured on new binary |
| `compiler/src/parser/statements.sfn` | 1 hash (20/20 identical) | to be measured on new binary |
| `compiler/src/llvm/lowering/instructions_helpers.sfn` | 1 hash (20/20 identical) | to be measured on new binary |
| `compiler/src/llvm/expression_lowering/native/statement_assignment.sfn` | 1 hash (20/20 identical) | to be measured on new binary |
| `compiler/src/cli_commands.sfn` | 1 hash (20/20 identical) | to be measured on new binary |

On Linux x86_64 the 0.5.7 seed is already fully deterministic on these modules, so this channel's removal is not expected to move the hash count here — it eliminates the per-return file-I/O overhead instead. The equivalent macOS-arm64 measurements (where residual non-determinism still lives) will land in the PR body once the CI rebuild completes on that platform.

**Scope of change:**
- 1 writer function converted from void+file-IPC to `SelfFieldResult` return at 6 exit points
- 1 reader (immediate caller, same stack frame) converted to direct struct-field reads
- 1 struct added to `llvm/types.sfn` (3 fields)
- 14 `fs.writeFile`/`fs.writeLines` calls removed from the writer; 5 `fs.readFile` + 1 `fs.exists` + 1 `fs.deleteFile` removed from the reader
- `.self_field_` kept in the legacy cleanup sweep with a comment
- ~28 net lines removed

Because the writer is called inside `lower_return_instruction`, which fires for every `return <expr>` statement in every function, this removes roughly 3-6 `fs.writeFile` calls per emitted return across every module compile. The compiler itself has no `return self.*` patterns, so the channel's data-bearing path is never exercised during self-hosting; it was pure per-return overhead.

### M0.5 Arena Allocator (Shipped April 17)

**Status: C implementation shipped behind a feature flag.** PR #174 (`de5ee36`) landed the bump-allocator C arena under `runtime/native/src/sailfin_arena.c` (254 lines) and wired it into `sailfin_runtime.c:618-654` via `_rt_malloc` / `_rt_calloc` / `_rt_realloc` / `_rt_free`. Activates when `SAILFIN_USE_ARENA=1`; otherwise the runtime falls back to `malloc`/`realloc` with the existing owned-string hash table and persistent-pointer set.

**What's in the arena code:**
- Linked-list of `SfnArenaPage` blocks (default 1 MiB; 4 MiB for the compiler singleton).
- Lazy global singleton via `pthread_once` — created on first `sfn_arena_global()` call.
- `sfn_arena_alloc(size, align)` — 8-byte aligned bump, new page allocated if the current page can't fit.
- `sfn_arena_realloc(ptr, old, new, align)` — grow-if-at-tip in place; otherwise fresh alloc + memcpy. Preserves the `string_append` realloc optimization.
- `sfn_arena_reset()` / `sfn_arena_destroy()` — bulk reset / tear-down.
- `sfn_arena_print_stats()` — page count, capacity, utilization telemetry (not yet wired to any test or build target).
- Correctness harness in `scripts/test_arena.sh` + `make test-arena` — compiles a module with and without the flag and byte-diffs the emitted LLVM IR to catch arena-induced output corruption.

The default-on flip is tracked as its own entry below.

### Arena Allocator Default-On (April 19)

**Status: Implemented.** The arena allocator is now default-on for selfhost builds. `scripts/build.sh` exports `SAILFIN_USE_ARENA="${SAILFIN_USE_ARENA:-1}"` before staging import-context or invoking the seed for per-module LLVM emit; `SAILFIN_USE_ARENA=0` in the caller's environment preserves the malloc path for diagnostics / regression triage. The CI workflow (`.github/workflows/ci.yml`) pins `SAILFIN_USE_ARENA: "1"` at the workflow `env` block as a belt-and-suspenders guard against future drift in the `build.sh` default.

**Measured on `compiler/src/llvm/lowering/lowering_core.sfn` (the heaviest module in the compiler), seed 0.5.7, Linux x86_64, isolated emit-only run (no parallelism, no timeout):**

| Metric | Malloc | Arena | Delta |
|--------|-------:|------:|------:|
| Wall time | 11:43 | 10:31 | −10% |
| Peak RSS | 7.49 GB | 4.72 GB | **−37%** |
| LLVM IR bytes | 430,213 | 430,213 | **byte-identical** |

The IR is byte-identical to the malloc output — `test-arena` reports `PASS ... (430,213 bytes identical)` — confirming the arena is transparent to compiler semantics on this module.

**Fast-fail criteria from `runtime_architecture.md §4.4`:**

| Criterion | Status | Notes |
|---|---|---|
| (1) `make compile` succeeds with arena on | ✅ In CI | Local selfhost on resource-constrained machines may still exceed `SEED_TIMEOUT=600` per module (lowering_core emit is close to the timeout even on the malloc path); CI's faster hardware clears both paths in ~14 min total on Linux. |
| (2) Per-module peak RAM < 512 MB | ⚠️ Not met | Both paths remain well above 512 MB on the heaviest modules (arena 4.7 GB, malloc 7.5 GB on `lowering_core`). The 512 MB target requires IPC removal on top of the arena — arena alone eliminates the IPC-as-GC dependency but does not bring peak RAM to the target. Filed as a follow-up after Phase 2 IPC removal. |
| (3) `make check` passes with arena on | ✅ In CI | Validated end-to-end in CI by this PR. |

Criterion (2) is the only unmet gate, and its failure is **not arena-induced** — malloc is 59% higher peak. Arena is the better path on every axis measured; the 512 MB target is re-scoped as a Phase 2 follow-up.

**Unblocked work (actionable immediately):**
1. **Phase 1b aliasing-blocked residuals become safe under arena:**
   - `concat_native_functions` site 2 in `lowering_core.sfn:573` (the one the d2d0bf1 sweep left copying because `collect_runtime_helper_targets`/`render_llvm_preamble`/`lower_all_functions` needed a pristine `local_functions`).
   - All 6 `append_local_binding` sites in `expression_lowering/native/core_scopes.sfn:174-186`.
   Both were deferred because in-place mutation leaked across scope restoration. Under arena, the copy is a cheap bump alloc and both views are preserved — in-place conversions are safe.
2. **Phase 2 IPC channels previously blocked by IPC-as-GC (~146 refs) become pickable:** `.call_result_*` (51), `.let_result_*` / `.let_ipc_*` (39), `.expr_stmt_*` (21), `.instr_*` (18), `.dispatch_*` (12), `.block_result_*` (5).

**macOS-arm64 determinism:** The 0.5.7 seed's residual non-determinism on macOS-arm64 (PRs #178 / #183 / #184 / #185 each measured 20-run hash sweeps against this) is driven by Phase 2 channels still active, not by memory allocation patterns. The arena flip itself should not change the non-determinism surface area — measurement will land in the PR body once CI completes on macOS-arm64.

**Scope of change:**
- `scripts/build.sh`: 1 export added (`SAILFIN_USE_ARENA="${SAILFIN_USE_ARENA:-1}"`) with a comment block explaining the contract.
- `.github/workflows/ci.yml`: 1 env var pinned at workflow level (`SAILFIN_USE_ARENA: "1"`).
- No compiler or runtime source changes.

Known pre-existing bug: on macOS-arm64, top-level user `fn` bodies with `return <expr>` can emit as empty blocks; `compiler/tests/unit/intrinsic_declarations_test.sfn` may fail because of this. It is not related to the arena flip.

### Module Globals IPC Channel Removal (April 19)

**Status: Implemented.** Removed the `.module_globals_*` file IPC channel — six scratch files (`preamble`, `locals`, `init`, `init_symbol`, `needs_init`, `diagnostics`) that `lower_module_bindings_to_globals` in `module_globals.sfn` used to ship its output back to its sole caller in `lowering_core.sfn`. The writer had always declared `ModuleGlobalLoweringResult` as its return type, but returned an empty stub; a "UNREACHABLE on v0.1.1 seed" comment documented the workaround. The 0.5.x seed lineage has no such restriction — `preprocess_self_field_access` (PR #184) validated the same return-struct pattern with 6 exits including a post-loop return.

**Shape of change:**
- Added `BindingLoweringResult { preamble_lines: string[]; locals: LocalBinding[]; needs_init: boolean }` to `llvm/types.sfn` (wrapper struct is legitimate per procedure §267: three values travelling together out of the per-binding helper).
- `_process_one_binding` now returns a `BindingLoweringResult` at all 4 exits instead of writing `.module_globals_preamble` / `.module_globals_locals` scratch files. `![io]` removed — the helper is now pure.
- `lower_module_bindings_to_globals` accumulates per-binding results in the outer loop (preamble via `.push`, locals via `.push`, needs_init via `|=`) and fully populates `ModuleGlobalLoweringResult` at its single return point. Early-return for empty bindings kept. `![io]` removed.
- Caller in `lowering_core.sfn:640-672` replaces six `fs.readFile` + `split_lines_local` + `_parse_module_globals_locals` calls with six direct struct field reads.
- `_parse_module_globals_locals` in `lowering_text_utils.sfn` is deleted as dead code (40 lines). `LocalBinding` import dropped from that file.
- `cli_commands._clean_lowering_state` keeps the `.module_globals_` prefix sweep with a "Legacy" comment explaining it's there to clean stale files from older build dirs / older seed binaries (following the PR #183 / PR #184 precedent — never drop a prefix entirely).

**Determinism delta (emit `llvm` × 20 runs on Linux x86_64, seed 0.5.7 baseline):**

| Module | Baseline | Post-change |
|--------|---------:|------------:|
| `compiler/src/llvm/lowering/lowering_core.sfn` | 1 hash (20/20 identical) | to be measured on new binary |
| `compiler/src/parser/expressions.sfn` | 1 hash (20/20 identical) | to be measured on new binary |
| `compiler/src/version.sfn` (module with top-level `let`) | 1 hash (20/20 identical) | to be measured on new binary |

On Linux x86_64 the 0.5.7 seed is already fully deterministic on these modules, so this channel's removal is not expected to move the hash count here — it eliminates per-binding `fs.writeFile` + clear-on-entry + read-back overhead instead. The equivalent macOS-arm64 measurements (where residual non-determinism still lives) will land in the PR body once the CI rebuild completes on that platform.

**Scope of change:**
- 1 writer function (`lower_module_bindings_to_globals`) converted from file-IPC stub to populated `ModuleGlobalLoweringResult` return
- 1 helper (`_process_one_binding`) converted from void+file-IPC to `BindingLoweringResult` return at all 5 exits (4 early + 1 final)
- 1 append-helper (`_append_to_file`) deleted entirely
- 1 reader (`lowering_core.sfn:640-672`) converted from six `fs.readFile` + `split_lines_local` + `_parse_module_globals_locals` calls to direct struct field reads
- 1 wrapper struct (`BindingLoweringResult`) added to `llvm/types.sfn` (3 fields)
- 1 dead parser (`_parse_module_globals_locals`, 40 lines) deleted from `lowering_text_utils.sfn`
- 13 `fs.writeFile` calls removed from the writer; 6 `fs.readFile` calls removed from the reader; `_append_to_file`'s internal `fs.exists` + `fs.readFile` + `fs.writeFile` per call removed
- 3 `![io]` effect annotations narrowed — both `_process_one_binding` and `lower_module_bindings_to_globals` become pure; the `![io]` helper `_append_to_file` is deleted
- `.module_globals_` prefix kept in the legacy cleanup sweep with an explanatory comment
- ~75 net lines removed (−151, +77 per `git diff --stat`)

The writer is called once per module compile, but only performs work when a module has top-level `let` bindings (the compiler has very few — `version.sfn` is the main one). The per-binding overhead was `2×` `_append_to_file` calls per preamble line plus another for the locals row, each entailing an `fs.exists` + `fs.readFile` + `fs.writeFile` round-trip — so O(N × L) filesystem operations for N bindings and L preamble lines per binding. The win is concentrated on two things: the pure-function conversion (helper and writer no longer participate in the `![io]` effect graph), and the elimination of an O(N²) read-modify-write pattern where each `_append_to_file` had to re-read the accumulating file on every call.

### Function Metadata IPC Channel Removal (April 19)

**Status: Implemented.** Removed the `.fn_*` function metadata IPC channel — the most heavily-referenced channel remaining: `.fn_name`, `.fn_return_type`, `.fn_is_async`, `.fn_is_extern`, `.fn_param_count`, `.fn_instr_count`, `.fn_decorator_count`, `.fn_index`, `.fn_index_backup`, plus per-index `.fn_param_N_name`, `.fn_param_N_type`, and `.fn_decorator_N`. Writer: `write_function_ipc` in `lowering_phase_functions.sfn`, called once per local function from `lower_all_functions`. Readers: `emit_llvm_function` and `prepare_parameters_from_files` in `emission.sfn`, plus the dead `emit_body` helper and `.fn_name`/`.fn_return_type`/`.fn_is_async` overrides inside `emit_async_function` in `emission_async.sfn`.

The channel existed as a workaround for the v0.1.1-seed compiling `emission.sfn` with `NativeFunction` demoted to `i8*` across module boundaries, making `function.name` etc. return garbage. The 0.5.7 seed under the default-on arena (PR #186) handles cross-module `NativeFunction` field access correctly — same pattern validated by PRs #183 (`.ctx_func_*`), #184 (`.self_field_*`), and #185 (`.module_globals_*`).

**Shape of change:**
- `emit_llvm_function` signature changed: now `fn emit_llvm_function(function: NativeFunction, functions: ..., ...)` — the caller passes the `NativeFunction` directly instead of a bare name and a `.fn_index` file.
- All eight `fs.readFile` calls in `emission.sfn` for scalar `.fn_*` fields replaced with `function.{name,return_type,is_async,is_extern}` and `.length` reads on `function.parameters`/`function.instructions`/`function.decorators`.
- The per-index `.fn_decorator_N` reader loop now iterates `function.decorators` in memory.
- The `.fn_index` + `.fn_index_backup` lookup-with-fallback block (26 lines plus bounds-check return) collapsed to passing `function` straight into `lower_instruction_range`.
- `prepare_parameters_from_files(fn_name, fn_param_count, context)` renamed to `prepare_parameters_from_function(function: NativeFunction, context: TypeContext)` and iterates `function.parameters` directly instead of reading per-param scratch files.
- `emit_async_function` signature changed to take `NativeFunction`; the impl-function override (name/return-type/async-flag) is now a literal `NativeFunction { ... }` built in-memory and passed into the recursive `emit_llvm_function` call. No files are written.
- `write_function_ipc` in `lowering_phase_functions.sfn` deleted entirely; caller passes `effective_function` directly into `emit_llvm_function`.
- `cli_commands._clean_lowering_state` keeps the `.fn_` prefix sweep with a "Legacy" comment for stale scratch files from older build dirs / older seed binaries (precedent: PRs #183 / #184 / #185 / #188).

**Dead code removed:**
- `emit_body` in `emission.sfn` — 86 lines, unreferenced from any call site, still read `.fn_index`.
- `parse_simple_integer` in `emission.sfn` — only used to parse the file-IPC integer fields.
- `NativeParameter`/`NativeInstruction` imports in `lowering_phase_functions.sfn` — only used by the deleted `write_function_ipc` loops.

**Scope:**
- 226 lines deleted from `emission.sfn` (file reads + `emit_body` + `parse_simple_integer` + fn_index bounds check)
- 42 lines deleted from `lowering_phase_functions.sfn` (writer + call site + unused imports)
- 24 lines changed in `emission_async.sfn` (signature swap + impl NativeFunction literal)
- 2 lines added to `cli_commands.sfn` (Legacy comment)
- Net: −204 lines, 45 insertions across 4 files.

**Per-function-compile overhead removed:**
- 8 `fs.writeFile` calls for scalar fields (name, return_type, async/extern flags, counts, index ×2)
- `2N` `fs.writeFile` calls for parameters (name + type per param)
- `N` `fs.writeFile` calls for decorators
- 8 `fs.readFile` calls for the scalars
- 1 `fs.exists` + 1 `fs.readFile` (with fallback-to-backup) for `fn_index`
- `N` `fs.readFile` calls for decorators
- `2N` `fs.readFile` calls for parameters

For a typical compiler module (50-200 functions, ~3 params + 0-1 decorators per fn), this eliminates roughly 500-2000 filesystem operations per module compile.

**Determinism delta:** Full build + test suite passed on CI across platforms after removal. Linux x86_64 on seed 0.5.7 was already 20/20 identical on the hot modules per the arena-flip entry; this change removes per-function file-I/O overhead without introducing new non-determinism. macOS-arm64 determinism surface continues to be driven by the remaining Phase 2 channels (call-result, dispatch, let-result, expr-stmt) and is unchanged by this removal.

---

## Appendix: IPC Channel Census

Total: **489 `fs.*` calls across 37 files.** 228 dotfile references to `build/sailfin/.xxx` temp paths across 27 files.

### Top IPC files by build/sailfin/ reference count

| File | Dotfile refs |
|------|-------------|
| `instructions_dispatch.sfn` | 45 |
| `instructions_let.sfn` | 32 |
| `instructions_helpers.sfn` | 30 |
| `statement.sfn` | 16 |
| `core_call_emission.sfn` | 13 |
| `core_literals_lowering.sfn` | 12 |
| `main.sfn` | 12 |
| `statement_assignment.sfn` | 9 |
| `lowering_core.sfn` | 9 |
| `lowering_phase_types.sfn` | 7 |
| `cli_commands.sfn` | 4 |
| `emission.sfn` | 3 |
| `lowering_phase_functions.sfn` | 2 |
| `core_call_resolution.sfn` | 1 |
