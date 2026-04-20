# Build Performance: Root Cause Analysis & Fix Plan

**Date:** 2026-04-19 (revised, post `.fn_*` channel removal)
**Previous revision:** 2026-04-15 (revised, post-d2d0bf1/220c8b7), 2026-04-15 (morning), 2026-04-11
**Context:** Self-hosting the compiler from the 0.5.2-alpha.1 seed via `build.sh` takes ~13-16 minutes for 121 modules single-threaded. Down from 60-90 minutes at the April 11 baseline thanks to partial IPC removal, string concat optimization, module splitting, and the Phase 1 accumulator sweep (`d2d0bf1`). Still far from the <5 minute target. The IPC-as-GC memory management blocker (formerly blocking ~146 Phase 2 channel refs) is now cleared: the arena allocator is default-on for selfhost as of the April 19 flip (see [Completed Work: Arena Allocator Default-On](#arena-allocator-default-on-april-19)). The two residual O(n²) copy sites (`concat_native_functions`, `append_local_binding`) that were reverted in `220c8b7` because callers rely on input-array immutability are now safe to convert to in-place push under arena — tracked as immediate follow-up work.

---

## Symptom Summary

| Metric                          | April 11            | Current (April 19)   | Target           |
| ------------------------------- | ------------------- | -------------------- | ---------------- |
| Full build (121 modules, 1 job) | 60-90 min           | 13-16 min            | < 5 min          |
| Per-module compile time (heavy) | 4-7 min             | 1-3 min              | < 30s            |
| Per-module compile time (light) | 30s-2 min           | 10-30s               | < 5s             |
| Per-module peak RAM             | 1-2 GB              | 0.5-1.5 GB           | < 256 MB         |
| Parallel builds (`--jobs N`)    | Broken              | Functional but risky | Stable at 4 jobs |
| `fs.*` calls (total)            | 667 across 42 files | 489 across 37 files  | < 50 per module  |
| `build/sailfin/` IPC refs       | 487                 | 228 (dotfiles)       | 0                |
| Seed memory limit               | 8 GB                | 12 GB                | < 4 GB           |

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

| Channel                                               | Written By                                      | Read By                                                    | Files per call |
| ----------------------------------------------------- | ----------------------------------------------- | ---------------------------------------------------------- | -------------- |
| Call result (type/value)                              | core_literals, core_call_emission, core_strings | instructions_let                                           | 2              |
| Dispatch result (lines/allocas/temp/region/mutations) | instructions_dispatch, instructions_helpers     | instructions, instructions_helpers                         | 8+             |
| Block result (terminated/string_constants)            | instructions_helpers                            | instructions_try                                           | 2              |
| Expr statement result (temp/region/mutations)         | statement                                       | instructions_dispatch                                      | 5+             |
| Let result (temp/lines/allocas/diagnostics/locals)    | instructions_let                                | instructions_dispatch, instructions_helpers                | 11+            |
| Context functions (count + per-entry fields)          | lowering_phase_types                            | core_call_resolution                                       | N×fields       |
| Type/struct/enum metadata                             | lowering_phase_types                            | core*member*\*, statement_assignment, core_call_resolution | 2              |
| Module globals (preamble/init/locals/diagnostics)     | module_globals                                  | lowering_core                                              | 6              |
| Self-field expression result                          | statement_assignment                            | statement                                                  | 4              |
| Per-instruction bindings/locals                       | instructions_dispatch, instructions_helpers     | statement, core_call_resolution                            | 4×N            |
| Instruction metadata (fn_name/expression/return/span) | instructions_dispatch                           | statement, statement*assignment, core_member*\*            | 4              |

### Hotspots (Current)

| File                        | `fs.*` Calls | `build/sailfin/` Refs |
| --------------------------- | ------------ | --------------------- |
| `instructions_dispatch.sfn` | 67           | 45                    |
| `instructions_helpers.sfn`  | 58           | 35                    |
| `cli_commands.sfn`          | 44           | 4                     |
| `main.sfn`                  | 37           | 12                    |
| `instructions_let.sfn`      | 32           | 32                    |
| `core_call_resolution.sfn`  | 32           | 12                    |
| `lowering_core.sfn`         | 32           | 15                    |
| `cli_main.sfn`              | 30           | 1                     |
| `statement_assignment.sfn`  | 28           | 29                    |
| `statement.sfn`             | 25           | 22                    |
| `emission.sfn`              | 3            | 3                     |

---

## Root Cause 2: O(n²) Array Accumulation (Mostly Resolved; Residuals Are Aliasing-Blocked)

The broad copy-then-append sweep landed in `d2d0bf1`. Current state:

### Resolved in `d2d0bf1`

- `extend_string_lines` at `lowering_io.sfn:21-39` is now **in-place `push()`** and functionally equivalent to `append_string_lines` (both are identical loops today). The runtime's `sailfin_runtime_array_push` uses amortized doubling up to 1024 then +25% ([sailfin_runtime.c:3749-3767](../runtime/native/src/sailfin_runtime.c#L3749-L3767)), so `push()` in loops is amortized O(1).
- `.concat([x])` in loop accumulators: only **1 remaining occurrence** across `compiler/src/` (in `parser/declarations.sfn`), down from ~30. Sweep effectively done.

### Residual O(n²) sites — aliasing-blocked (reverted in `220c8b7`)

Both of these still allocate a fresh array and copy the input before appending. They are the two places where a trivial in-place conversion was **tried and reverted** because callers depend on the input staying pristine.

| Function                  | Location                                             | Call sites | Aliasing constraint                                                                                                                                                                                   |
| ------------------------- | ---------------------------------------------------- | ---------: | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `concat_native_functions` | `lowering/lowering_helpers_mangling.sfn:389`         |          3 | `lowering_core.sfn` passes `local_functions` into `concat_native_functions` _and_ into `lower_all_functions`/`collect_runtime_helper_targets` afterwards. In-place mutation corrupts the second pass. |
| `append_local_binding`    | `expression_lowering/native/core_scopes.sfn:174-186` |          6 | Nested scopes (for bodies, try/catch) build a temporary locals array via append, then restore the original for the outer scope. In-place mutation leaks bindings across scopes.                       |

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

`recover_native_functions_light` in `lowering_recovery.sfn:83+` still exists and is actively called from `lowering_core.sfn:127` as the **primary** path, not a fallback. It re-scans every line of `.sfn-asm` text with 20+ `starts_with` checks per line. `parse_native_artifact_safe` (same file, line 78) historically assembled results from 7 per-field extraction calls; as of Tier 1A PR 1 it delegates to `parse_native_artifact` directly (one artifact walk instead of seven). Full deletion of the wrapper is tracked as Tier 1A PR 2 / PR 3 below.

Both exist because the v0.1.1 seed couldn't handle typed instruction variants. The 0.5.7 seed does (validated by the structured parser working through `parse_native_artifact` on every self-host), so the migration is now unblocked — Tier 1C pulls `recover_native_functions_light` off the primary path entirely.

---

## Root Cause 5: No Memory Management (NEW — Critical)

The runtime has no mechanism to reclaim memory during compilation:

| Resource              | Allocation | Deallocation                    | Status                                                   |
| --------------------- | ---------- | ------------------------------- | -------------------------------------------------------- |
| Strings (<64 KB)      | `malloc`   | `string_drop` → `free`          | **Disabled by default** (`SAILFIN_ENABLE_STRING_FREE=0`) |
| Strings (≥64 KB)      | `malloc`   | `mark_persistent` (never freed) | **Permanently leaked**                                   |
| String arrays         | `malloc`   | None                            | **Always leaked**                                        |
| NativeFunction arrays | `malloc`   | None                            | **Always leaked**                                        |
| LocalBinding arrays   | `malloc`   | None                            | **Always leaked**                                        |

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

| Target                  | Call sites | Status                                                                |
| ----------------------- | ---------: | --------------------------------------------------------------------- |
| `extend_string_lines`   |        ~36 | ✅ In-place `push()`                                                  |
| `.concat([x])` in loops |        ~50 | ✅ Replaced with `.push(x)` (1 residual in `parser/declarations.sfn`) |

**What shipped next (Phase 1b partial, post-baseline):**

Per-site aliasing audit (see [runtime_architecture.md §4.4](runtime_architecture.md#44-m05--arena-in-c-temporary-unblocker) M0.5 fast-fail criteria and the matching audit performed here) identified that only 2 of the 3 `concat_native_functions` sites in `lowering_core.sfn` are aliasing-safe without an arena. Those 2 sites (lines 568 and 576) now use a new in-place helper `extend_native_functions_inplace`. The third site at line 573 stays copying because downstream passes (`collect_runtime_helper_targets`, `render_llvm_preamble`, `lower_all_functions`) read the pristine `local_functions`.

| Target                                                   | Call sites | Status                                                                                                                                                                                                  |
| -------------------------------------------------------- | ---------: | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `concat_native_functions` sites 1, 3 (lowering_core.sfn) |          2 | ✅ In-place `extend_native_functions_inplace`                                                                                                                                                           |
| `concat_native_functions` site 2 (lowering_core.sfn)     |          1 | Copying — caller needs pristine `local_functions`                                                                                                                                                       |
| `append_local_binding` all 6 sites                       |          6 | Still copying — aliasing audit revealed deeper caller-side structural dependencies than initial audit indicated; safe to convert to in-place push now that the M0.5 arena is default-on (April 19 flip) |

**Measured impact (lowering_core only — the hottest module):**

| Metric          | Baseline (post-d2d0bf1) | Phase 1b partial |         Delta |
| --------------- | ----------------------: | ---------------: | ------------: |
| Compile time    |                  61.69s |           58.02s |         −6.0% |
| Peak memory     |                 7.23 GB |          7.23 GB |            ±0 |
| Aggregate build |                 641.33s |          639.51s | −0.3% (noise) |

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

1. **Statement/assignment channels** — per-expression-statement overhead
2. ~~**Async inner-return-type channel** (`.async_inner_return_type`) — writer in `core_call_resolution.sfn`, reader in `instructions_let.sfn`~~ — **Removed April 20** (see [Completed Work: Async Inner Return Type IPC Channel Removal](#async-inner-return-type-ipc-channel-removal-april-20))
3. ~~**Struct info channel** (`.struct_info`) — cross-phase type metadata read by `core_member_lowering`, `core_member_helpers`, `core_literals_lowering`, `lowering_phase_render`~~ — **Removed April 20** (see [Completed Work: Struct Info IPC Channel Removal](#struct-info-ipc-channel-removal-april-20))
4. ~~**Context-functions channel** — `serialize_context_functions()` in `lowering_phase_types.sfn`~~ — **Already removed** (writer no longer exists in the source; the `.ctx_func_*` cleanup sweep remains as legacy).

With `.async_inner_return_type` gone, every cross-statement / cross-phase Phase 2 channel has been eliminated. The residual `fs.*` surface in the compiler is now (a) `.trace_lowering` debug gates, (b) `.phase_*` diagnostics sinks, and (c) import-context reads in `llvm/imports.sfn` (targeted by Phase 3).

### Phase 3: Cache Import Artifacts

**Priority:** Medium — **Expected:** 5-15% time reduction
**No dependency on Phases 0-2** — can proceed in parallel

The BFS in `collect_imported_module_context_for_module` (`llvm/imports.sfn:37`) already dedupes within a single process via `seen[]`. Under the per-module-process build model (`scripts/build.sh` spawns one `seed emit llvm` per module), the biggest remaining wins live across process boundaries — either pre-parsed sidecar artifacts or a persistent compiler process (Phase 5).

**Subtasks:**

- ~~**3a.** Fast-path scanner for `parse_native_imports_for_import`~~ — **Shipped** (see [Completed Work: Import Discovery Fast-Path Scanner](#import-discovery-fast-path-scanner-april-20)). Eliminates the recursive `.struct`/`.interface`/`.enum` block parses that were being done only to discard everything except the imports list.
- **3b.** Pre-parsed `.imports` sidecar artifact emitted during `stage_import_context`. Would eliminate the per-discovery file read entirely and take advantage of the static cross-module dependency graph. Requires an emit-time format change and fallback logic for older build directories.
- **3c.** Cross-process shared cache under `build/sailfin/.import-cache/` keyed by source hash. Only worth pursuing if 3b is rejected on artifact-layout grounds; adds invalidation complexity.
- **3d.** In-process memoization of `parse_layout_manifest` and `.sfn-asm` reads. Evaluated during 3a planning and **rejected** because the BFS's `seen[]` already dedupes within a single process, and each `seed emit llvm` invocation calls the collector exactly once. Worth revisiting only after Phase 5 turns `seed emit` into a long-lived process that handles multiple modules per invocation.

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

| Module                                                  | Baseline (seed 0.5.5 pre-change)    | New compiler (post-change)      |
| ------------------------------------------------------- | ----------------------------------- | ------------------------------- |
| `compiler/src/parser/expressions.sfn`                   | 4/30 divergent (5 distinct hashes)  | 0/20 divergent (1 hash)         |
| `compiler/src/llvm/lowering/lowering_core.sfn`          | intermittently dropped all user fns | 0/20 divergent (1 hash)         |
| `compiler/src/llvm/expression_lowering/native/core.sfn` | (not measured baseline)             | 0/20 divergent                  |
| `compiler/src/parser/statements.sfn`                    | (not measured baseline)             | 1/20 divergent (other channels) |

The three large modules that previously flaked are now fully deterministic. The residual 1/20 flake on `parser/statements.sfn` is driven by other scratch channels still active (call-result, struct-info, instr-fn-name) and will be eliminated as subsequent Phase 2 channels are removed.

Concurrently, the `build.sh` retry loop went from 3 `invalid_ir` retries per full build (`core_operands`, `core_parsing`, `instructions_helpers`) down to 1 (`cli_commands`), another signal that real non-determinism volume dropped materially.

**Scope of change:**

- 1 writer deletion (`instructions_condition.sfn`)
- 4 reader conversions to `find_local_binding(locals, name)` against the existing in-memory parameter
- 1 signature extension (`lower_inline_gep_field_access` in `core_member_helpers.sfn` — added `locals: LocalBinding[]`, updated two call sites in `core_member_lowering.sfn`)
- ~150 lines removed, ~15 added

This is the first IPC removal under the procedure in Phase 2 above; future channel removals should follow the same 9-step pattern.

### Self-Field IPC Channel Removal (April 19)

**Status: Implemented.** Removed the `.self_field_*` file IPC channel — a v0.1.1-seed-era workaround used to ship the rewritten expression / next temp index / updated lines array from `preprocess_self_field_access` (in `statement_assignment.sfn`) back to its _immediate_ caller `lower_return_instruction` (in `statement.sfn`).

The writer was void-returning and wrote 4 sub-files (`.self_field_expr`, `.self_field_temp`, `.self_field_lines_count`, `.self_field_lines`) at 6 exit points (5 early returns + 1 final). The reader checked `fs.exists(".self_field_expr")` two lines after the call, read the 4 files back, reconstructed the three values, and deleted the scratch file. The call site is literally adjacent to the helper — the channel was pure function-return ceremony routed through the filesystem.

**Shape of change:**

- Added `SelfFieldResult { expression, temp_index, lines }` to `llvm/types.sfn` (wrapper struct is legitimate per procedure §267: three values travelling together).
- `preprocess_self_field_access` now has return type `SelfFieldResult` and returns the struct at all 6 exits; all `fs.writeFile`/`fs.writeLines` on `.self_field_*` paths deleted. `![io]` subsequently dropped after the `.struct_info` channel removal (April 20) eliminated the last `fs.*` call.
- Caller in `statement.sfn` captures the struct directly; `fs.exists` / `fs.readFile` / `fs.deleteFile` block replaced with three field reads. The `_sf_lc > current_lines.length` length gate is preserved as `result.lines.length > current_lines.length` so callers that didn't perform any self-field rewrites don't have their `current_lines` clobbered.
- `cli_commands._clean_lowering_state` keeps the `.self_field_` prefix sweep with a comment explaining it's there to clean stale files from older build dirs / older seed binaries (following the PR #183 review precedent — never drop a prefix entirely).

**Determinism delta (emit `llvm` × 20 runs on Linux x86_64, seed 0.5.7 baseline):**

| Module                                                                  |                 Baseline |                  Post-change |
| ----------------------------------------------------------------------- | -----------------------: | ---------------------------: |
| `compiler/src/parser/expressions.sfn`                                   | 1 hash (20/20 identical) | to be measured on new binary |
| `compiler/src/parser/statements.sfn`                                    | 1 hash (20/20 identical) | to be measured on new binary |
| `compiler/src/llvm/lowering/instructions_helpers.sfn`                   | 1 hash (20/20 identical) | to be measured on new binary |
| `compiler/src/llvm/expression_lowering/native/statement_assignment.sfn` | 1 hash (20/20 identical) | to be measured on new binary |
| `compiler/src/cli_commands.sfn`                                         | 1 hash (20/20 identical) | to be measured on new binary |

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

| Metric        |  Malloc |   Arena |              Delta |
| ------------- | ------: | ------: | -----------------: |
| Wall time     |   11:43 |   10:31 |               −10% |
| Peak RSS      | 7.49 GB | 4.72 GB |           **−37%** |
| LLVM IR bytes | 430,213 | 430,213 | **byte-identical** |

The IR is byte-identical to the malloc output — `test-arena` reports `PASS ... (430,213 bytes identical)` — confirming the arena is transparent to compiler semantics on this module.

**Fast-fail criteria from `runtime_architecture.md §4.4`:**

| Criterion                                 | Status     | Notes                                                                                                                                                                                                                                                                                                                 |
| ----------------------------------------- | ---------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| (1) `make compile` succeeds with arena on | ✅ In CI   | Local selfhost on resource-constrained machines may still exceed `SEED_TIMEOUT=600` per module (lowering_core emit is close to the timeout even on the malloc path); CI's faster hardware clears both paths in ~14 min total on Linux.                                                                                |
| (2) Per-module peak RAM < 512 MB          | ⚠️ Not met | Both paths remain well above 512 MB on the heaviest modules (arena 4.7 GB, malloc 7.5 GB on `lowering_core`). The 512 MB target requires IPC removal on top of the arena — arena alone eliminates the IPC-as-GC dependency but does not bring peak RAM to the target. Filed as a follow-up after Phase 2 IPC removal. |
| (3) `make check` passes with arena on     | ✅ In CI   | Validated end-to-end in CI by this PR.                                                                                                                                                                                                                                                                                |

Criterion (2) is the only unmet gate, and its failure is **not arena-induced** — malloc is 59% higher peak. Arena is the better path on every axis measured; the 512 MB target is re-scoped as a Phase 2 follow-up.

**Unblocked work (actionable immediately):**

1. ~~**Phase 1b aliasing-blocked residuals become safe under arena:**~~ — **Revised April 20**: on re-inspection, the remaining Phase 1b sites (`concat_native_functions` site 2 in `lowering_core.sfn:500` and all `append_local_binding` call sites) are **not aliasing-blocked in the memory sense** — the reason the sweep left them copying is semantic: `context_functions` and `local_functions` must remain distinct arrays so that appending `imported_functions` to one doesn't contaminate the other, and `append_local_binding` produces per-scope snapshots that nested scopes extend without polluting the outer scope's locals. Arena makes the allocation cheap but does not change array identity, so in-place conversion would break correctness regardless of allocator. The current O(n) copies are the right behavior; under arena they are already cheap bump allocations.
2. **Phase 2 IPC channels previously blocked by IPC-as-GC (~146 refs) become pickable:** `.call_result_*` (51), `.let_result_*` / `.let_ipc_*` (39), ~~`.expr_stmt_*` (21)~~ removed in PR #191, `.instr_*` (18), `.dispatch_*` (12), ~~`.block_result_*` (5)~~ removed in PR #188.

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

| Module                                                   |                 Baseline |                  Post-change |
| -------------------------------------------------------- | -----------------------: | ---------------------------: |
| `compiler/src/llvm/lowering/lowering_core.sfn`           | 1 hash (20/20 identical) | to be measured on new binary |
| `compiler/src/parser/expressions.sfn`                    | 1 hash (20/20 identical) | to be measured on new binary |
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

**Determinism delta:** Full build + test suite passed on CI across platforms after removal. Linux x86_64 on seed 0.5.7 was already 20/20 identical on the hot modules per the arena-flip entry; this change removes per-function file-I/O overhead without introducing new non-determinism. macOS-arm64 determinism surface continues to be driven by the remaining Phase 2 channels (call-result, dispatch, let-result) and is unchanged by this removal.

### Expression Statement & Coerce Result IPC Channel Removal (April 19, PR #191)

**Status: Implemented.** Removed two channels in one sweep:

- **`.expr_stmt_*`** (21 dotfile refs, 2 writers, 2 readers): the v0.1.1-seed-era workaround used by `lower_expression_statement` / `lower_return_instruction` to ship per-statement temp counter, region id, mutations, and string constants back to `dispatch_expression_instruction` / `dispatch_return_instruction`. Both writers already returned a fully-populated `ExpressionStatementResult` struct; the file IPC was a parallel copy of the same data. Under the default-on arena (PR #186) the 0.5.7 seed handles cross-module struct returns correctly — same pattern validated by PRs #183 / #184 / #185 / #188 / #189. The dispatch readers now consume `lowered.{temp_index, next_region_id, mutations, string_constants}` directly, with the same temp-counter floor protection inlined.

- **`.coerce_result_*`** (4 dotfile refs, 0 writers): pure dead code. The fallback reader in `instructions_let.sfn` checked for files no caller ever wrote — `coerce_operand_to_type` returns its result via `CoercionResult` struct and never touched the filesystem. Collapsed to the existing struct-field path.

**Shape of change:**

- `_write_expr_stmt_result_files{,_with_constants}` deleted from `statement.sfn` (2 helpers + 8 call sites at all return points of `lower_expression_statement` and `lower_return_instruction`).
- `_read_expr_string_constants` deleted from `instructions_dispatch.sfn`; both dispatch readers now use struct fields directly.
- `read_expr_string_constants` and `read_expr_mutations` deleted from `instructions_helpers.sfn` — both were unused/dead code.
- `_write_assign_result_files` in `statement_assignment.sfn` had its two `.expr_stmt_*` writes dropped (the surrounding `.call_result_*` writes stay — separate channel, not in scope). Signature simplified from `(pre_lines_count, lines, temp_index, mutations, next_region_id, string_constants)` to `(lines, temp_index)` after the unused params became dead, with `lower_lvalue_assignment_stmt` losing its `pre_lines_count` parameter as well (per PR #191 review).
- `instructions_let.sfn`'s `.coerce_result_type` file-existence branch (62 lines including the dead "fallback") collapsed to the `CoercionResult` struct path.
- `cli_commands._clean_lowering_state` adds `.expr_stmt_` and `.coerce_result_` "Legacy" sweeps for stale files from older build dirs / older seed binaries (precedent: PRs #183 / #184 / #185 / #188 / #189).

**Per-statement overhead removed:**

- 5 + 4N `fs.writeFile` per emitted statement (temp/region/mut_count scalars + 4 per mutation: name/type/value/label)
- 1 `fs.writeLines` per statement (string_constants array)
- 5 `fs.readFile` + bulk parsing on the reader side
- 4 `fs.readFile` per mutation on the reader side

For typical compiler modules (hundreds of statements per function, dozens of functions per module) this eliminates thousands of filesystem operations per module compile.

**Scope:**

- 6 source files modified, ~−241 / +47 lines net.
- No new tests added — the existing integration suite (`selfhost_pipeline_test.sfn`, `async_struct_return_stress_test.sfn`, `compiler_ir_patterns_test.sfn`) and the self-hosting build itself exercise every path that was changed.

### Call Result IPC Channel Removal (April 20)

**Status: Implemented.** Removed the `.call_result_*` file-IPC channel — the heaviest-referenced remaining Phase 2 channel. Two sub-groups shared the prefix:

- **Type/value pair** (`.call_result_type`, `.call_result_value`): a v0.1.1-seed-era workaround that writers in `core_call_emission.sfn`, `core_literals_lowering.sfn`, `core_strings.sfn`, and the await paths of `core.sfn` used to ship `LLVMOperand.{llvm_type, value}` back to `instructions_let.sfn`. Every writer already populated `ExpressionResult.operand` with the identical data — the file IPC was a parallel copy. The reader in `instructions_let.sfn` used the files as a `_use_ipc_override` fallback when `operand.llvm_type` appeared corrupted crossing module boundaries. Under the default-on arena (PR #186) the 0.5.7 seed handles cross-module struct returns correctly — same pattern validated by PRs #183 / #184 / #185 / #188 / #189 / #191.

- **Lines/count/temp triple** (`.call_result_lines_count`, `.call_result_lines`, `.call_result_temp`): a cross-statement leak used by `_write_assign_result_files` in `statement_assignment.sfn` to ship post-lvalue-assignment IR lines + temp counter to a sentinel-gated reader in `statement.sfn`'s `lower_expression_statement`. The sentinel-gated reader fired only when a _prior_ statement's lvalue path had written the files; under arena, in-place array mutation of `current_lines` plus `_recover_temp_from_lines(current_lines, current_temp)` already delivers the same data in-band. The reader block's comment ("ExpressionResult struct fields may be ABI-corrupted crossing module boundaries") describes a pre-arena failure mode.

**Shape of change:**

- `_write_emission_result_lines` deleted from `core_call_emission.sfn` (helper + all 6 call sites at trait/concat/push/array paths).
- 14 `fs.writeFile(".call_result_{type,value}", ...)` pairs deleted across `core_call_emission.sfn` (6), `core_literals_lowering.sfn` (5), `core.sfn` (3 await paths), `core_strings.sfn` (1).
- `_write_assign_result_files` deleted from `statement_assignment.sfn` (helper + all 11 call sites at every return point of `lower_lvalue_assignment_stmt`).
- `statement.sfn`'s `lower_expression_statement` pre-clear block (lines 391-398), trace-gated existence check (403-409), sentinel-gated reader (410-433), and `_pre_call_lines_len` debug print (450-457) all deleted. The surrounding `_recover_temp_from_lines(current_lines, current_temp)` call (previously the `else`-branch fallback) becomes the single temp-recovery path. Return value of the `lower_expression` call renamed to `_lowered` to signal intentional discard (struct fields are unused — the call's effect is the in-place mutation of `current_lines`).
- `_parse_int_local` in `statement.sfn` (16 lines) deleted — only used by the dead `.call_result_temp` reader.
- `split_lines_local` import dropped from `statement.sfn` — only use was in the dead reader block. Export kept in `lowering_text_utils.sfn` (many other files import it).
- `instructions_let.sfn` pre-clear block (lines 154-161), `.call_result_type` trace guard (173-177), `llvm_type` fallback reader (218-225), and `_use_ipc_override` branch (328-354) all deleted. Operand path simplifies to: if `operand.llvm_type == llvm_type` → direct store (identity coerce, unchanged); else → `coerce_operand_to_type` (unchanged).
- `cli_commands._clean_lowering_state` keeps the `.call_result_` prefix sweep with a "Legacy" comment for stale files from older build dirs / older seed binaries (precedent: PRs #183 / #184 / #185 / #188 / #189 / #191).

**Per-call / per-statement overhead removed:**

- Up to 2 `fs.writeFile` per call emission (type + value scalars) — fires on every `call` IR emission across trait dispatch, concat/push inline, void/value standard calls, array-struct literals, zero-field structs, string concat, and await unboxing.
- 3 `fs.writeFile` per lvalue assignment statement (lines count + bulk lines + temp index) — fires on every deref, member-access, and array-index assignment.
- 2 `fs.deleteFile` per let initializer (pre-clear sentinel).
- Up to 3 `fs.readFile` + 1 `fs.deleteFile` per expression statement (sentinel gate + bulk lines + temp + cleanup).
- Up to 2 `fs.readFile` per let-binding fixup (`_use_ipc_override` branch).
- Multiple `fs.exists` trace gates.

For a typical compiler module with hundreds of calls per function and dozens of functions, this eliminates thousands of filesystem operations per module compile. Together with the `.expr_stmt_*` removal in PR #191, the per-statement IR accumulation path is now fully in-memory end-to-end.

**Risks evaluated:**

- **v0.1.1-seed ABI corruption**: the channel's original purpose. 0.5.x seeds under arena validated by PRs #183-#191 — `ExpressionResult` and `ExpressionStatementResult` are reliable across module boundaries today.
- **Cross-statement `_write_assign_result_files` → `statement.sfn` reader**: the else-branch fallback at `statement.sfn:441` (`_recover_temp_from_lines`) was already the standalone code path when the sentinel file was absent, and its comment explicitly documented that `current_lines` is mutated in-place. Removing both writer and reader together makes the scanner-based recovery the single path.
- **`_use_ipc_override` removal**: the reader exists to repair operands whose `llvm_type` is empty or mismatched versus the expected `llvm_type`. Under arena, the operand struct returned by `lower_expression` carries the correct type — the file-based reconstruction was a parallel safety net that is no longer needed. The identity-vs-coerce split at the store site (lines 357-402) is unchanged.

**Scope:**

- 8 source files modified (7 compiler + 1 CLI), 1 docs file updated.
- Net: ~−200 lines deleted / ~+20 lines added.
- No new tests added — the existing integration suite (`selfhost_pipeline_test.sfn`, `async_struct_return_stress_test.sfn`, `compiler_ir_patterns_test.sfn`) plus full self-hosting exercise every path.

**Determinism:** Linux x86*64 on seed 0.5.7 is already 20/20 identical on the hot modules per the arena-flip entry; this change removes file-I/O overhead without introducing new non-determinism. macOS-arm64 measurement to be recorded after CI completes on that platform. With `.call_result*_`gone, the remaining Phase 2 channels driving residual macOS-arm64 non-determinism are`.dispatch\__`, `.let*result*_`/`.let*ipc*_`, and `.instr\_\*`.

### Dispatch / Let Result / Let IPC Dead-Channel Sweep (April 20)

**Status: Implemented.** Removed three file-IPC channel prefixes in a single sweep: `.dispatch_*`, `.let_result_*`, and `.let_ipc_*`. All three were **fully dead code** — the channels never delivered data end-to-end because the live lowering path (`instructions.sfn`) already consumes `LetLoweringResult` as a direct struct return from `lower_let_instruction` at `instructions_let.sfn:377-390`. Audit confirmed:

- `.let_result_*` had **zero writers** anywhere in the repo.
- `.let_ipc_*` had one writer (`read_let_result_from_files` in `instructions_helpers.sfn`) and zero readers.
- `.dispatch_*` had writers only inside `instructions_dispatch.sfn` and was self-read via a single sentinel check inside the same file.
- `instructions_dispatch.sfn` itself had **zero external importers** — its sole header-comment self-reference was the only incoming link.

The channels were v0.1.1-seed-era fallback code paths that became unreferenced after the `LetLoweringResult` struct return shipped but were never pruned.

**Shape of change:**

- Deleted `compiler/src/llvm/lowering/instructions_dispatch.sfn` entirely (256 lines). No import fixups required anywhere.
- Deleted four dead functions from `compiler/src/llvm/lowering/instructions_helpers.sfn`: `write_bindings_to_files`, `write_locals_to_files`, `read_let_result_string_constants`, `read_let_result_from_files` (~152 lines). All four had zero callers across `compiler/src` and `compiler/tests`.
- Pruned imports in `instructions_helpers.sfn` that became unused after the deletion: `append_local_binding`, `merge_string_constants`, `substring`, `index_of`, `number_to_string`, `split_lines_local`, `ParameterBinding`, `StringConstant`.
- Added "Legacy" sweep comments for `.dispatch_`, `.let_ipc_`, and `.let_result_` prefixes in `cli_commands._clean_lowering_state` (following the PR #183 / #184 / #185 / #188 / #189 / #191 / #192 precedent of keeping prefixes in the cleanup sweep to handle stale files from older build dirs and older seed binaries).
- Updated `docs/build-performance.md` Remaining-targets list to reflect the new Phase 2 surface (statement/assignment channels, `.async_inner_return_type`, `.struct_info` / `.enum_info`, `serialize_context_functions`).

**Scope:**

- 1 file deleted (`instructions_dispatch.sfn`, −256 lines).
- 1 file trimmed (`instructions_helpers.sfn`, −152 lines).
- 2 files edited (`cli_commands.sfn` +6 lines for Legacy comments; `docs/build-performance.md` entry + Remaining-targets prune).
- Net: approximately −400 lines across 4 modified/deleted files.
- No new tests added — the existing integration suite plus full self-hosting exercise every live path.

**Per-module overhead removed:**

- `.dispatch_*` writes (lines, allocas, temp, next_local, next_region, used_file_ipc, mutation_count + per-index, string_constants) fired on every instruction dispatch — now zero.
- `.let_ipc_*` writes (lines, allocas, temp, next_local, next_region, used) fired on every let-result read — now zero.
- `.let_result_*` read-with-delete cycles fired on every let-instruction finalize — now zero.
- The 256-line `instructions_dispatch.sfn` module itself is no longer compiled: on the April 15 baseline this module cost 26.17s and 3.1 GB peak RAM per `docs/perf/baseline-0.5.2-alpha.1.csv:66`. Eliminating the module removes that compilation cost from the aggregate build time.

**Risk assessment:**

- Because all three channels were dead code with no live data path, removal cannot change compiler output. The CI full build + test suite is the authoritative gate.
- The `.instr_*` prefix is left intact (still swept without a Legacy comment) because although its writers lived inside the now-deleted `instructions_dispatch.sfn`, several readers remain in `statement.sfn`, `statement_assignment.sfn`, `core_member_lowering.sfn`, `core_member_helpers.sfn`, and `core_literals_lowering.sfn`. Those readers now always take their fallback path (the `fs.exists` check always returns false), which is semantically equivalent to the pre-existing fallback behavior. Full `.instr_*` removal is a separate PR.

**Determinism:** With three more Phase 2 prefixes gone, the remaining channels driving residual macOS-arm64 non-determinism are `.instr_*` (reader-only now; fallback path active), `.async_inner_return_type`, `.struct_info`, and `.enum_info`. Post-change emit-sweep measurement to land in the PR body after CI completes.

### Instr_fn_name Dead-Reader Cleanup (April 20)

**Status: Implemented.** Removed the three remaining `.instr_fn_name` reader blocks — all dead code after the dispatch sweep (April 20 Dispatch / Let Result / Let IPC Dead-Channel Sweep) eliminated the only writers. The `fs.exists("build/sailfin/.instr_fn_name")` check now always returns false in every location that previously read it, so the guarded code never ran.

**Readers removed:**

- `compiler/src/llvm/expression_lowering/native/core_member_helpers.sfn:38-74` — the "For self param, extract struct from function name" fallback block inside `lower_inline_gep_field_access`. Removed the nested `if _igep_struct.length == 0 { if _igep_base == "self" { if fs.exists(...) { ... } } }` block (~37 lines). The remaining locals-based type-annotation lookup one level below covered the same case via `find_local_binding` whenever `self` was properly bound.
- `compiler/src/llvm/expression_lowering/native/core_member_lowering.sfn:919-960` — the identical fallback block inside `try_file_based_struct_field_access` (~42 lines). Function now returns `null_result` when `struct_type_ann` remains empty, consistent with the primary path.
- `compiler/src/llvm/expression_lowering/native/statement_assignment.sfn:595-755` — the `if !fs.exists(".instr_fn_name") { return ... }` guard plus the entire `.struct_info`/`.instr_fn_name` parsing + `self.field` rewrite loop that followed inside `preprocess_self_field_access` (~160 lines). The function now early-returns for any `self.*` return expression — which is the behavior that has been live since the April 20 dispatch sweep removed the writer.

**Shape of change:**

- Three dead `if fs.exists(".instr_fn_name")` reader blocks deleted.
- `preprocess_self_field_access` collapses to a trivial pass-through (early-return on `self.` absent, return unmodified inputs). `![io]` dropped — no `fs.*` calls remain after the `.struct_info` channel removal.
- `cli_commands._clean_lowering_state` line for `.instr_` now carries a "Legacy" comment (following the PR #183 / #184 / #185 / #188 / #189 / #191 / #192 precedent of keeping prefixes in the cleanup sweep to handle stale files from older build dirs / older seed binaries).
- No import cleanup required: `index_of`, `substring`, `format_temp_name`, `number_to_string` all remain heavily used elsewhere in the modified files.

**Scope:**

- 3 source files modified, ~−239 / +4 lines net.
- 1 CLI file edited (+2 lines for Legacy comment).
- 1 docs file updated.
- No new tests added — the existing integration suite plus full self-hosting exercise the live paths; the deletions remove only code guarded by an always-false `fs.exists` check.

**Risk assessment:**

- The writer of `.instr_fn_name` was removed as part of `instructions_dispatch.sfn` deletion in the April 20 dispatch sweep (see entry above). After that removal, every `fs.exists("build/sailfin/.instr_fn_name")` call returned false (unless stale files existed in `build/sailfin/`, which the cleanup sweep already handles). CI for the dispatch sweep passed on all platforms, validating that the fallback path was genuinely dead. This cleanup only removes the unreachable code — no semantic change.

**Determinism:** No behavior change expected on any platform — the deleted blocks were guarded by always-false conditions. Post-change emit-sweep measurement to land in the PR body after CI completes.

### Enum Info IPC Channel Removal (April 20)

**Status: Implemented.** Removed the `.enum_info` file-IPC channel — a v0.1.1-seed-era cross-module ABI workaround. Writer (`serialize_enum_info`) and reader (`recover_enums_from_file`) both lived in the same file (`lowering_phase_types.sfn`) and shared a single call frame inside `build_type_context_with_recovery` (the writer ran two lines before the reader's entry condition). Chosen as the first move ahead of `.struct_info` because the same-file, same-function writer/reader pair is the smallest possible blast radius to validate that arena-mode `build_type_context` reliably returns cross-module struct-array returns — the hypothesis that underwrites every Phase 2 removal since the April 19 arena default-on flip.

**Shape of change:**

- Added pure helper `build_enum_infos_inline(enums: NativeEnum[]) -> EnumTypeInfo[]` to `lowering_phase_types.sfn`. Iterates `fixed_enums_list` directly and produces byte-identical `EnumTypeInfo[]` to the file-based path: unit-enum defaults (`tag_type="i32"`, `tag_size=4`, `tag_align=4`, `size=4`, `align=4`, `max_payload_size=0`) and synthetic variant names `v0`, `v1`, ... (matching the `v<idx>=<idx>` format the writer serialized). The helper is genuinely pure — no `![io]`, no tracing — the `_trace_enums` branch moved to the caller, which already owns `![io]`.
- Deleted `serialize_enum_info` (47 lines) and its single call at `build_type_context_with_recovery`.
- Deleted the `fs.exists("build/sailfin/.enum_info")` gate on the recovery condition — under arena the file was no longer a meaningful signal, and `_needs_recovery` is now driven purely by `type_context.enums.length == 0 || _enum_names_empty`.
- Replaced `recover_enums_from_file(_trace_enums)` call with `build_enum_infos_inline(fixed_enums_list)`; the post-recovery trace moved into the caller's `if recovered.length > 0` branch.
- Deleted `recover_enums_from_file` (72 lines) and `parse_enum_variants` (~27 lines) — both were dead code after the reader was replaced.
- Restructured pre-existing `type_context.enums[0].name` null-check at the recovery trigger to short-circuit before reading `.length` (defensive — if the ABI corruption ever surfaces with a `null` first-enum name, the old `_asgn253` pattern would have dereferenced through it).
- Pruned unused imports: `substring` (from `string_utils`), `index_of` (from `utils`), `parse_number_local` + `split_lines_local` (from `lowering_text_utils`), plus pre-existing dead imports `fixup_enum_layouts` (from `type_context`) and `extend_string_lines_checked` (from `lowering_io`).
- `cli_commands._clean_lowering_state` gets a "Legacy" comment for the `.enum_info` sweep (following the PR #183 / #184 / #185 / #188 / #189 / #191 / #192 precedent of keeping the prefix in the cleanup sweep to handle stale files from older build dirs / older seed binaries).

**Per-module overhead removed:**

- 1 `fs.writeLines(".enum_info", ...)` per module compile (fires on every module with a `build_type_context_with_recovery` call — i.e. every compiler module).
- 1 `fs.exists(".enum_info")` per module compile (gating check).
- 1 `fs.readFile(".enum_info")` + tab-delimited parse per module where recovery fires.
- The 72-line `recover_enums_from_file` + 27-line `parse_enum_variants` helpers no longer compile into the module.

**Risk assessment:**

- **Recovery semantics**: the recovery path fires when `type_context.enums` is empty or has empty names (the v0.1.1-seed ABI corruption signal). Under the default-on arena (PR #186) the 0.5.7 seed returns correct struct-array returns across module boundaries — same pattern validated by PRs #184 (`.self_field_*`), #185 (`.module_globals_*`), #188 (`.fn_*`), #189 (same), #191 (`.expr_stmt_*`), #192 (`.call_result_*`), and the April 20 dispatch/let_result/let_ipc sweep. The in-memory fallback preserves byte-identical output (synthetic `v<idx>` variant names, unit-enum defaults) so any code relying on the file-based recovery shape continues to work.
- **Cross-statement leak**: none — writer and reader share a call frame.
- **Effect narrowing**: `build_enum_infos_inline` is genuinely pure — no `![io]`, no `print.err`, no `fs.*`. `serialize_enum_info`'s `![io]` obligation goes away with the function itself. `build_type_context_with_recovery` retains `![io]` because it still calls `serialize_struct_info`, writes `.phase_types_diagnostics`, and owns the `_trace_enums` post-recovery `print.err`.

**Scope:**

- 3 source files modified (`lowering_phase_types.sfn`, `cli_commands.sfn`, `docs/build-performance.md`).
- `lowering_phase_types.sfn`: net approximately −95 lines (146 removed, 53 added — old serializer + file reader replaced by the inline builder).
- `cli_commands.sfn`: +2 lines for the Legacy comment.
- No signature changes, no new wrapper struct (procedure §267 not triggered — zero params travel; the data is already in scope).
- No new tests added — the existing integration suite plus full self-hosting exercise the live paths; the recovery fallback is byte-identical to the file-based path it replaces.

**Determinism:** Writer/reader shared a same-file call frame, so there was no cross-module hash divergence to measure on the `.enum_info` channel specifically. Post-change emit-sweep on `lowering_core.sfn`, `parser/expressions.sfn`, and modules with user enums (`ast.sfn`) will land in the PR body once CI completes. With `.enum_info` gone, the remaining Phase 2 channels driving residual macOS-arm64 non-determinism are `.struct_info`, `.async_inner_return_type`, and the reader-only `.instr_*` fallbacks.

**Follow-up:** ~~The immediate next PR should remove `.struct_info`~~ — Done. See below.

### Struct Info IPC Channel Removal (April 20)

**Status: Implemented.** Removed the `.struct_info` file-IPC channel — a v0.1.1-seed-era cross-module ABI workaround. Writer (`serialize_struct_info`) in `lowering_phase_types.sfn` serialized `NativeStruct[]` as tab-delimited lines to `build/sailfin/.struct_info`; five readers across four files parsed it back to resolve struct field metadata. Under the 0.5.7 seed with arena (default-on since April 19), `TypeContext` crosses module boundaries reliably, making the file path dead.

**Shape of change:**

_Phase A — Dead code removal:_

- Deleted `try_file_based_struct_field_access` (~130 lines) from `core_member_lowering.sfn` — zero callers, not exported. Pure dead code from a v0.1.1-seed era that was never wired up.
- Collapsed `preprocess_self_field_access` in `statement_assignment.sfn` — removed the `fs.exists(".struct_info")` check, dropped `![io]`. Function is now a trivial pass-through (early-return on `self.` absent, return unmodified inputs).

_Phase B — Reader conversions:_

- `core_member_helpers.sfn`: Rewrote `lower_inline_gep_field_access` to use `find_struct_info_by_name(context, name)` + `find_struct_field_info(info, field_name)` from the in-memory `TypeContext`. Added `context: TypeContext` parameter. Dropped `![io]`. Removed `index_of`/`substring` imports (no longer needed). Updated two call sites in `core_member_lowering.sfn` to pass `context`.
- `core_member_lowering.sfn`: Dropped `![io]` from `lower_member_access` (no more `fs.*` calls in the file).
- `core_literals_lowering.sfn`: Deleted the ~80-line file-based fallback block from `lower_struct_literal` that parsed `.struct_info` when `resolve_struct_info_for_literal` returned null. Dropped `![io]`. Removed unused imports: `index_of`, `StructFieldInfo`, `StructTypeInfo`.
- `lowering_phase_render.sfn`: Converted `recover_struct_types_from_file()` to `recover_struct_types_from_context(type_context: TypeContext)` — iterates `type_context.structs` in-memory to produce the same LLVM type-definition lines. Dropped `![io]` from the recovery function. Removed unused imports: `NativeStruct`, `substring`, `index_of`, `split_lines_local`.

_Phase C — Writer deletion:_

- Deleted `serialize_struct_info` (~43 lines) from `lowering_phase_types.sfn` and its call in `build_type_context_with_recovery`. Removed unused imports: `get_struct_field_name_at`, `get_struct_field_type_at`, `get_struct_fields_at`, `get_struct_name_at`. Updated module header comment.
- `cli_commands.sfn`: Added "Legacy" comment to the `.struct_info` cleanup sweep (following PR #183+ precedent).

**Per-module overhead removed:**

- 1 `fs.writeLines(".struct_info", ...)` per module compile (fires on every module with `build_type_context_with_recovery`).
- Up to 5 `fs.exists(".struct_info")` + `fs.readFile(".struct_info")` + tab-delimited parse calls per module across the four reader sites.
- ~350 lines of file-I/O parsing code removed, replaced with ~20 lines of in-memory lookups.

**Effect narrowing:**

- `lower_inline_gep_field_access`: `![io]` → pure
- `lower_member_access`: `![io]` → pure
- `lower_struct_literal`: `![io]` → pure
- `recover_struct_types_from_context`: new function, pure (replacing `![io]` file-based version)
- `preprocess_self_field_access`: `![io]` → pure (no `fs.*` calls remain)
- `serialize_struct_info`: deleted entirely
- `build_type_context_with_recovery` retains `![io]` (still writes `.phase_types_diagnostics` and owns debug `print.err`).

**Risk assessment:**

- All five reader sites were verified to have `TypeContext` in scope (either directly or one hop up). The in-memory helpers `find_struct_info_by_name` and `find_struct_field_info` already existed in `type_context_queries.sfn` and are exercised by the primary code paths.
- The file-based paths were fallbacks for when `TypeContext` arrived corrupt across module boundaries (v0.1.1-seed ABI issue). Under the 0.5.7 seed with arena, the primary in-memory paths work reliably — validated by PRs #183-#192 and the `.enum_info` removal.

**Scope:**

- 7 source files modified.
- Net approximately −350 lines removed, ~20 added.
- 1 signature extension (`lower_inline_gep_field_access` gains `context: TypeContext`, 2 call sites updated).
- No new wrapper structs, no new tests (existing integration suite + self-hosting exercise all live paths).

**Determinism:** The `.struct_info` channel was a significant source of non-determinism because its five readers spanned four different files across two lowering phases (expression lowering and render). Cross-phase file reads are the primary mechanism for hash divergence on macOS-arm64. Post-change emit-sweep measurements to land in the PR body once CI completes. With `.struct_info` gone, the remaining Phase 2 channels are `.async_inner_return_type` and the reader-only `.instr_*` fallbacks.

### Async Inner Return Type IPC Channel Removal (April 20)

**Status: Implemented.** Removed the `.async_inner_return_type` file-IPC channel — the last remaining cross-statement Phase 2 scalar channel. Writer in `core_call_resolution.sfn:702` (inside `resolve_call_signature`) serialized `function_entry.return_type` whenever the resolved call target was an async function; reader in `instructions_let.sfn:354-358` consumed it in the narrow case where the let's LLVM type was `%SailfinFuturePtr*`, using the value as the local's `type_annotation` so the `await` handler could unbox structs.

The channel was a v0.1.1-seed-era workaround. Under the default-on arena (PR #186), the let-side reader can derive the exact same value in-memory: `instructions_let.sfn` already receives `functions: NativeFunction[]` as a parameter, and the writer only ever fired for direct async function calls — so extracting the leading identifier of `instruction.value` and looking it up via `find_function_by_name_or_import(functions, target)` (exact match + unique `target + "__"` suffix match for imported / mangled callees, matching the resolver the writer used) reaches the same `NativeFunction.return_type` the writer was shipping.

**Shape of change:**

- Added a small local helper `_extract_leading_call_target(expression) -> string` to `instructions_let.sfn` that returns the identifier prefix of the expression when it is shaped `<identifier>(...)`, else the empty string. Uses the existing `is_identifier_start_char` / `is_identifier_part_char` / `trim_text` utilities (extended the existing `../utils` import).
- Promoted the previously-private `_find_function_by_name_or_import` helper in `core_call_resolution.sfn` to the shared `find_function_by_name_or_import` in `rendering_helpers.sfn` so both the resolver and the let-side recovery use one implementation (exact match + unique `target + "__"` suffix match for imported / mangled callees). `core_call_resolution.sfn` now imports it rather than defining a private copy.
- Added `import { find_function_by_name_or_import } from "../rendering_helpers"` in `instructions_let.sfn`.
- Replaced the 5-line `fs.exists` / `fs.readFile` / `fs.deleteFile` block at line 353-358 with a pure `find_function_by_name_or_import(functions, call_target)` lookup; when the callee is async and has a non-empty `return_type`, the local binding's `type_annotation` is set to it (matching previous behavior for both local and imported async functions).
- Deleted the sole `fs.writeFile("build/sailfin/.async_inner_return_type", ...)` call at `core_call_resolution.sfn:702`.
- Narrowed `resolve_call_signature` from `![io]` to pure — it was the only `fs.*` call in the function.
- Added a "Legacy" comment to the existing `.async_inner_` cleanup sweep in `cli_commands.sfn` (following PR #183 / #184 / #185 / #188 / #189 / #191 / #192 / `.enum_info` / `.struct_info` precedent).

**Per-call overhead removed:**

- 1 `fs.writeFile(".async_inner_return_type", ...)` per async call emission (fires in `resolve_call_signature` for every async callee).
- 1 `fs.exists` + up to 1 `fs.readFile` + 1 `fs.deleteFile` per let whose LLVM type is `%SailfinFuturePtr*`.

**Effect narrowing:**

- `resolve_call_signature`: `![io]` → pure.
- `instructions_let.sfn::lower_let_instruction` retains `![io]` (still uses `.trace_lowering` debug gates elsewhere).

**Risk assessment:**

- **Narrow fallback surface**: the writer only fired when `function_entry.is_async` and `function_entry` was non-null — i.e., the call target was a plain async function name found in the `functions` array. The reader-side replacement does the same lookup against the same array; when the original would have fired, the replacement fires with byte-identical data.
- **Non-call initializers**: `let f = some_future_var` (no call in the initializer) leaves `_extract_leading_call_target` returning empty and the `type_annotation` falls through to `instruction.type_annotation` — semantically identical to the old file-IPC path, which also wouldn't have produced output for this case (the writer wasn't fired).
- **Method calls on async targets**: `let f = obj.async_method()` would have the extracted target `obj.async_method`, which doesn't match a bare function name via `find_function_by_name` — so the lookup misses and the annotation falls through. This matches the old file-IPC behavior (the writer fired only via `_find_function_by_name_or_import` matching a top-level function). Async methods flow through a different resolution path and are unaffected.
- **Cross-statement leak**: none — writer and reader are now fully in-memory; no inter-process or inter-module file exchange remains.

**Scope:**

- 4 source files modified (`instructions_let.sfn`, `core_call_resolution.sfn`, `cli_commands.sfn`, `docs/build-performance.md`).
- Net approximately −6 `fs.*` calls removed, +20 lines of local helper (the in-memory path is a tight lookup against an array the reader already had).
- No new wrapper structs, no signature changes to call sites, no new tests (existing integration suite + self-hosting exercise every live path).

**Determinism:** The channel was per-async-call and cross-statement (writer in one lowering phase, reader in another), one of the structural sources of emit-time non-determinism on macOS-arm64. Removing it shrinks the residual non-determinism surface to the `.trace_lowering` debug gates (not IPC) and the reader-only `.instr_*` fallbacks (always-false, no data flow). With this change, every Phase 2 *structural* channel is gone — the fs-call census drops into mostly diagnostic and import-context territory.

### Import Discovery Fast-Path Scanner (April 20)

**Status: Implemented.** First Phase 3 landing. Replaced the full-artifact parse in `parse_native_imports_for_import` (in `compiler/src/native_ir_api.sfn`) with a line scanner that handles only top-level `.import`/`.export` directives and skips everything else with a cheap `starts_with` check. The previous implementation routed through `parse_native_artifact_impl`, which walks every `.struct`/`.interface`/`.enum` body via recursive `parse_struct_definition` / `parse_enum_definition` / `parse_interface_definition` helpers — work the caller (`collect_imported_module_context_for_module` in `llvm/imports.sfn:172`) immediately discarded. `.import`/`.export` lines are emitted only as top-level statements (see `emit_native.sfn:emit_statement_declarations`) and never appear inside block bodies, so a flat scan is semantically equivalent for the imports field.

**Shape of change:**

- `parse_native_imports_for_import` rewritten to loop over lines directly, checking for `.import `/`.export ` prefixes and calling `parse_import_entry` on matches. Diagnostics are intentionally dropped — the single live caller (`llvm/imports.sfn:172`) discards them regardless.
- Added `parse_import_entry` to the imports from `./native_ir_utils_parse`.
- `parse_native_artifact_impl` itself is unchanged — the other `*_for_import` wrappers (`parse_native_structs_for_import`, `parse_native_interfaces_for_import`, `parse_native_enums_for_import`, `parse_native_functions_for_import`) still route through it because they legitimately need the full parse.

**Per-BFS overhead removed:**

The BFS in `collect_imported_module_context_for_module` calls the fast path once per unique transitive module — typically 20-100 calls per `seed emit llvm` invocation for compiler sources. Each call previously did `O(lines)` iteration with recursive block parses; the fast scanner does `O(lines)` iteration with a flat starts_with check per line. Speedup scales with the size of the transitive module's `.sfn-asm` text: large compiler modules (1000-5000 lines) see the biggest wins because they contain many struct/enum/interface blocks whose bodies were being walked just to find the handful of `.import` lines at the top. Across a full 121-module build that's thousands of full-artifact parses reduced to flat line scans.

**Why intra-process memoization was rejected:**

The architect's original Phase 3 plan proposed a process-local memo of `(path → LayoutManifest)` and `(path → NativeImport[])`. Audit showed the BFS's `seen[]` array already dedupes within a single process, and each `seed emit llvm` invocation calls the collector exactly once — so a memo would have had a 0% hit rate. Attacking the per-call cost instead turned a no-op cache into a real per-line-of-artifact win, and left every candidate cross-process caching approach (sidecars, shared caches) available for future PRs when measurement supports them.

**Risk assessment:**

- **Output equivalence:** the fast scanner calls the same `parse_import_entry` helper with the same arguments for matching lines, so the `NativeImport[]` it produces is byte-identical to the `imports` field of `parse_native_artifact_impl` on the same input.
- **No new state:** no module-level mutables, no cross-process cache, no sidecar artifacts. The change is a pure implementation swap inside one function.
- **Scope of callers:** `parse_native_imports_for_import` has exactly one live caller (`imports.sfn:172`). `entrypoints.sfn:31` imports it but does not use it (pre-existing dead import, left alone).

**Scope:**

- 1 source file modified (`compiler/src/native_ir_api.sfn`).
- ~30 lines added (fast-scanner loop + guiding comment), ~4 lines removed (previous body that dispatched to `parse_native_artifact_impl`).
- 1 import added (`parse_import_entry` from `./native_ir_utils_parse`).
- 1 regression test added (`compiler/tests/unit/parse_native_imports_fast_test.sfn`, 11 tests). Follows the `emit_native_format_test.sfn` convention of re-implementing the scanner against minimal local types, because importing `parse_native_imports_for_import` directly would pull the full native_ir parser chain (~4.5k lines) into the test runner's inlined source and exceed the 60s per-test budget. The shipping code is exercised end-to-end by self-host on every `make compile`; the test file pins down the scanner's expected behavior shape.
- No signature changes, no new exports, no new wrapper structs — existing integration suite plus full self-hosting exercise the live path on every module compile.

**Determinism:** No new cross-phase or cross-process state. The function is invoked exactly once per unique transitive import slug per process (unchanged from before) and produces identical output for identical inputs. CI matrix determinism sweep on macOS-arm64 should show no regression.

**Follow-ups (deferred to separate PRs):**

- **3b:** Pre-parsed `.imports` sidecar artifact emitted during `stage_import_context`. Eliminates the per-discovery file read entirely; the sidecar is trivially cheap for the BFS to consume.
- **3c:** Cross-process shared cache under `build/sailfin/.import-cache/`. Only worth pursuing if 3b is rejected on artifact-layout grounds.
- **Phase 5:** Long-lived compiler process — subsumes 3a's intra-process work automatically and makes 3b/3c unnecessary.

### Tier 1A PR 1 — `parse_native_artifact_safe` Inlined (April 20)

**Status: Implemented.** First Tier 1A landing. `parse_native_artifact_safe` in `compiler/src/llvm/lowering/lowering_recovery.sfn:78` no longer assembles a `ParseNativeResult` from seven per-field extraction calls; its body is now a single delegate to `parse_native_artifact(text)` in `compiler/src/native_ir_api.sfn:79`. Each of the 6 live callers drops from running `parse_native_artifact_impl` seven times per call (once per `_from_text` projection: `_functions_`, `_imports_`, `_structs_`, `_interfaces_`, `_enums_`, `_bindings_`, `_diagnostics_`) to exactly once.

**Root cause:** `parse_native_artifact_safe` was written as a v0.1.1-seed struct-return ABI workaround. Each `_from_text` helper at `compiler/src/native_ir_api.sfn:89-129` is literally `let parsed = parse_native_artifact_impl(text, true, true); return parsed.X;` — pure projection of the same single-pass parser. `parse_native_artifact_impl` at `compiler/src/native_ir_parser.sfn:45-436` is the canonical single-pass line-driven state machine: one `split_lines`, one top-level loop, flat directive dispatch, sub-parsers that return `next_index`. The "single-pass parser" we wanted already existed — the wrapper was just calling it seven times.

**Shape of change:**

- `lowering_recovery.sfn:78` rewritten to `return parse_native_artifact(text);`. Comment rewritten to explain the historical ABI-workaround context and point at the PR 2/PR 3 follow-ups.
- `native_ir_api` import block at `lowering_recovery.sfn:24-28` trimmed from 8 symbols to 3: `parse_native_artifact` added; `parse_native_bindings_from_text`, `parse_native_diagnostics_from_text`, `parse_native_enums_from_text`, `parse_native_imports_from_text`, `parse_native_interfaces_from_text`, `parse_native_structs_from_text` all dropped (unused in this file after the body rewrite). Retained: `parse_native_functions_from_text` (still called at `lowering_recovery.sfn:730, 836` inside `recover_functions_for_lowering`) and `parse_native_function_count_from_text` (still called at `lowering_recovery.sfn:826` inside the disk-recovery flow).

**Per-caller overhead removed:**

For each of the 6 live callers (`entrypoints.sfn:164,220,229,263,366` + `entrypoints_tests.sfn:117`), the underlying `parse_native_artifact_impl` invocation count drops from 7 to 1. Across 121 modules with typical 5–6 callsites hit per module in the normal lowering path that's thousands of redundant full-artifact walks eliminated per build. The measurement is algorithmic (7 → 1 by construction) — no benchmarking needed to confirm the invocation delta.

**API surface change:** none. `parse_native_artifact_safe` keeps the same name, same signature, same return type. Callers compile identically. The wrapper's deletion is Tier 1A PR 3's job.

**Risk assessment:**

- **Output equivalence:** `parse_native_artifact(text)` is `parse_native_artifact_impl(text, true, true)` (one-line wrapper at `native_ir_api.sfn:79-81`). The old body called `parse_native_artifact_impl(text, true, true)` seven times and picked one field from each result. The new body calls it once and returns all seven fields. Same parser, same input flags, byte-identical `ParseNativeResult` by construction.
- **ABI relic:** the v0.1.1-seed struct-return workaround that motivated `_safe` is obsolete. `parse_native_artifact` is already live in production (exported at `native_ir_api.sfn:196`, called directly by several callers), so the ABI path we're switching to is exercised end-to-end on every `make check`.
- **Self-hosting:** only `lowering_recovery.sfn` changes; its exports are unchanged; every caller compiles identically. CI full build + test suite is the authoritative gate.

**Scope:**

- 1 source file modified (`compiler/src/llvm/lowering/lowering_recovery.sfn`).
- Net: approximately −18 / +5 lines (body contraction + import-list trim + comment rewrite).
- No signature changes, no new exports, no new wrapper structs, no new tests.

**Determinism:** No new cross-phase or cross-process state. The parse result flowing into every downstream lowering phase is byte-identical to the pre-change path. CI determinism sweep on macOS-arm64 should show no regression.

**Follow-ups (remaining Tier 1A work — track in subsequent PRs):**

- **Tier 1A PR 2 — callsite swap.** Replace `parse_native_artifact_safe(x)` with `parse_native_artifact(x)` at all 6 live sites: `compiler/src/llvm/lowering/entrypoints.sfn:164`, `:220`, `:229`, `:263`, `:366`, and `compiler/src/llvm/lowering/entrypoints_tests.sfn:117`. Remove the two confirmed dead imports: `compiler/src/llvm/lowering/entrypoints_tests_writer.sfn:100` (imported but only referenced in a comment; real path uses `build_parse_result_from_text` at `:133`) and `compiler/src/llvm/lowering/lowering_phase_sanitize.sfn:25` (imported but not used in the file body). Requires `make clean-build` because it's a structural change to the import graph. No runtime behavior change.
- **Tier 1A PR 3 — wrapper deletion.** Delete `fn parse_native_artifact_safe` from `compiler/src/llvm/lowering/lowering_recovery.sfn:78`. After the callsite swap in PR 2, the function has zero callers. Conditionally delete now-orphaned `_from_text` wrappers from `compiler/src/native_ir_api.sfn` if they have zero remaining callers repo-wide: `parse_native_structs_from_text`, `parse_native_imports_from_text`, `parse_native_interfaces_from_text`, `parse_native_enums_from_text`, `parse_native_diagnostics_from_text`. **Keep** `parse_native_functions_from_text` (live callers at `lowering_recovery.sfn:730,836`, `lowering_phase_sanitize.sfn:19,281`, `lowering_core.sfn:33`), `parse_native_function_count_from_text` (live caller at `lowering_recovery.sfn:826`), and `parse_native_bindings_from_text` (live callers at `lowering_phase_sanitize.sfn:19,409`, `lowering_core.sfn:31`) — verify via `grep -rn` at PR 3 time.
- **Tier 1A PR 4 (optional) — equivalence regression test.** Add `compiler/tests/unit/parse_native_artifact_equivalence_test.sfn` constructing a synthetic `.sfn-asm` fixture that exercises every top-level directive (`.import`, `.export`, `.struct`+body, `.interface`+body, `.enum`+body, `.fn`+body, `.test`+body, top-level binding, `.decorator`, `.span`, `.init-span`) and asserts field-by-field equality between `parse_native_artifact(fixture).X` and each legacy `parse_native_X_from_text(fixture)` projection. Defense-in-depth only — the self-host itself is the real equivalence gate. Must follow the `parse_native_imports_fast_test.sfn` pattern (re-implement against minimal local types to stay under the 60s per-test budget; do not import the full parser chain).

---

## Appendix: IPC Channel Census

Total: **489 `fs.*` calls across 37 files.** 228 dotfile references to `build/sailfin/.xxx` temp paths across 27 files.

### Top IPC files by build/sailfin/ reference count

| File                           | Dotfile refs |
| ------------------------------ | ------------ |
| `instructions_dispatch.sfn`    | 45           |
| `instructions_let.sfn`         | 32           |
| `instructions_helpers.sfn`     | 30           |
| `statement.sfn`                | 16           |
| `core_call_emission.sfn`       | 13           |
| `core_literals_lowering.sfn`   | 12           |
| `main.sfn`                     | 12           |
| `statement_assignment.sfn`     | 9            |
| `lowering_core.sfn`            | 9            |
| `lowering_phase_types.sfn`     | 7            |
| `cli_commands.sfn`             | 4            |
| `emission.sfn`                 | 3            |
| `lowering_phase_functions.sfn` | 2            |
| `core_call_resolution.sfn`     | 1            |
