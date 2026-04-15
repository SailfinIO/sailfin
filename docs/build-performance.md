# Build Performance: Root Cause Analysis & Fix Plan

**Date:** 2026-04-15 (revised)
**Previous revision:** 2026-04-11
**Context:** Self-hosting the compiler from the 0.5.0-alpha.24 seed via `build.sh` takes ~13-16 minutes for 121 modules single-threaded. Down from 60-90 minutes at the April 11 baseline thanks to partial IPC removal, string concat optimization, and module splitting — but still far from the <5 minute target. Further IPC removal is blocked by a memory management crisis: file serialization was acting as accidental garbage collection.

---

## Symptom Summary

| Metric | April 11 | Current (April 15) | Target |
|--------|----------|---------------------|--------|
| Full build (121 modules, 1 job) | 60-90 min | 13-16 min | < 5 min |
| Per-module compile time (heavy) | 4-7 min | 1-3 min | < 30s |
| Per-module compile time (light) | 30s-2 min | 10-30s | < 5s |
| Per-module peak RAM | 1-2 GB | 0.5-1.5 GB | < 256 MB |
| Parallel builds (`--jobs N`) | Broken | Functional but risky | Stable at 4 jobs |
| `fs.*` calls (total) | 667 across 42 files | 592 across 39 files | < 50 per module |
| `build/sailfin/` IPC refs | 487 | 336 (dotfiles) | 0 |
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

**Net result:** Build time dropped ~75-80%, but the work hit a wall. See "The IPC-as-GC Problem" below.

---

## The IPC-as-GC Problem (Critical Blocker)

File-based IPC removal stalled because the filesystem serialization was acting as **accidental garbage collection**. When the compiler writes a struct's fields to temp files and reads them back, the original in-memory data goes out of scope and becomes eligible for cleanup. Without this serialize/deserialize cycle, strings and arrays accumulate in memory with no way to free them.

### Why the runtime can't free memory

The C runtime (`runtime/native/src/sailfin_runtime.c`) has fundamental memory management limitations:

1. **`string_drop` is disabled by default.** The function checks `SAILFIN_ENABLE_STRING_FREE` (off by default) because the compiler lacks a precise ownership/RC model for strings. Strings stored in arrays get dropped while still referenced, causing use-after-free.

2. **Large strings are never freed.** Even with string freeing enabled, strings ≥64 KB are marked persistent (`sailfin_runtime_mark_persistent`) for process lifetime due to observed nondeterministic corruption.

3. **Arrays are never freed.** No `array_drop` or array lifecycle management exists. Every `string[]` or `NativeFunction[]` allocated during compilation leaks.

4. **No GC, no RC, no arena allocator.** The runtime tracks owned strings in a hash table for safe freeing, but this is opt-in and disabled. There is no generational GC, reference counting, or arena-based allocation.

### The consequence

Each IPC write-then-read cycle implicitly "freed" memory by letting the original values go out of scope while the file held the data. Removing these cycles keeps all intermediate values alive simultaneously, causing per-module RAM to spike past the 12 GB limit.

**This means the fix plan must be reordered: memory management must be solved before further IPC removal can proceed.**

---

## Root Cause 1: Filesystem-as-IPC (Still Primary Bottleneck)

The compiler still uses the filesystem as an inter-function communication channel. After partial removal, 16 distinct IPC channel families remain active.

- **592 total `fs.*` calls** across 39 files (down from 667/42)
- **336 dotfile references** to `build/sailfin/.xxx` temp paths (down from 487)
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
| Function metadata (name/return/async/params/decorators) | lowering_phase_functions | emission | 10+ |
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
| `emission.sfn` | 21 | 21 |

---

## Root Cause 2: O(n²) Array Accumulation (Worse Than Previously Documented)

Multiple array concatenation functions allocate a fresh array and copy both inputs on every call. The problem is larger than previously documented.

### `extend_string_lines` — primary offender

Defined in `lowering_io.sfn:21-48`. Allocates a new `string[]` and copies both inputs every call.

| File | Direct calls | Via `_checked` | Total |
|------|-------------|----------------|-------|
| `lowering_core.sfn` | 13 | 5 | 18 |
| `lowering_phase_render.sfn` | 10 | 0 | 10 |
| `lowering_helpers.sfn` | 6 | 0 | 6 |
| `lowering_phase_functions.sfn` | 1 | 1 | 2 |
| **Total** | **30** | **6** | **36** |

The efficient `append_string_lines` (in-place mutation, O(n)) exists at `lowering_io.sfn:50-68` but has only **2 call sites** vs 36 for the copying variant.

For comparison, `extend_string_array` in `llvm/utils.sfn` (also in-place, O(n)) has **96 call sites** across 18 files — the expression lowering subsystem adopted it widely, but the instruction lowering layer did not.

### Other O(n²) patterns

| Pattern | Location | Call sites |
|---------|----------|------------|
| `concat_native_functions` | `lowering_helpers_mangling.sfn:389` | 5 |
| `append_local_binding` (copies array) | `core_scopes.sfn:174` | 6 |
| `.concat([single_element])` in loops | scattered (6 files) | ~30 in-loop |

### Impact estimate

For a module that accumulates 10,000 LLVM IR lines across 36 extend calls: ~180,000 total line copies, hundreds of MB of garbage array memory that is never freed (see "IPC-as-GC Problem" above).

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

Both exist because the v0.1.1 seed couldn't handle typed instruction variants. The 0.5.0-alpha.24 seed may support these, but the migration hasn't been attempted.

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

### Phase 0: Arena Allocator for Compilation (NEW)

**Priority:** Critical — **Prerequisite for all other phases**
**Expected:** Unblocks IPC removal; 30-50% memory reduction standalone

Add a per-compilation arena allocator to the C runtime. During a single module compilation, all strings and arrays are allocated from a bump allocator that is freed in bulk at process exit (or after each module in a future long-lived compiler process).

**Why arena, not RC or GC:**
- The compiler is a batch process: allocate during compilation, discard everything at the end
- No cycles to break (no need for tracing GC)
- No per-object overhead (no RC increments on every string copy)
- Simple to implement: replace `malloc` with `arena_alloc`, add `arena_reset` at end

**Implementation sketch:**
1. Add `sailfin_arena_t` to `sailfin_runtime.c` (simple bump allocator with page-sized backing blocks)
2. Route string allocations through the arena when `SAILFIN_USE_ARENA=1`
3. Route array allocations through the arena
4. Remove the owned-string hash table overhead (not needed with arena)
5. Call `arena_reset()` at process exit (future: per-module reset in long-lived mode)

**Risk:** The `string_append` realloc optimization assumes `realloc` returns the same or a new pointer. Arena allocators typically don't support `realloc`. Either (a) fall back to concat for arena mode, or (b) implement arena-aware realloc (grow in place if at arena tip, else copy).

### Phase 1: Fix O(n²) Array Accumulation

**Priority:** Highest non-blocked — **Expected:** 15-25% time, 40-60% memory reduction
**No dependency on Phase 0** — can proceed immediately

Replace all copying array concatenation with in-place mutation:

| Target | Call sites | Replacement |
|--------|-----------|-------------|
| `extend_string_lines` | 36 | `append_string_lines` |
| `concat_native_functions` | 5 | `append_native_function` (exists) |
| `append_local_binding` | 6 | In-place push |
| `.concat([x])` in loops | ~30 | `.push(x)` |

Verify no call site depends on the original array being unmodified before switching. The expression lowering layer already uses `extend_string_array` (96 sites) successfully — this is proven safe.

### Phase 2: Eliminate IPC Files (Resumed)

**Priority:** Highest — **Expected:** 40-60% time reduction, enables parallel builds
**Depends on:** Phase 0 (arena allocator) to prevent OOM

With memory management solved, resume replacing filesystem IPC with direct struct returns. Remaining targets by priority:

1. **Instruction dispatch channel** (45 refs in `instructions_dispatch.sfn`) — hottest path
2. **Let result channel** (32 refs in `instructions_let.sfn`) — per-let-binding overhead
3. **Statement/assignment channels** (29+22 refs) — per-expression-statement overhead
4. **Function metadata channel** (13 refs in `lowering_phase_functions.sfn`) — per-function overhead
5. **Context functions serialization** (14 refs in `lowering_phase_types.sfn`) — per-module overhead
6. **Module globals channel** (18 refs in `module_globals.sfn`)
7. **Remaining channels** (emission, self-field, async, coerce, condition locals)

Named IPC functions to eliminate:
- `_write_block_result_files()` — `instructions_helpers.sfn:122`
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
**Depends on:** Verifying the 0.5.0-alpha.24 seed handles typed instruction variants

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

---

## Appendix: IPC Channel Census

Total: **592 `fs.*` calls across 39 files.** 336 dotfile references to `build/sailfin/.xxx` temp paths across 31 files. 16 distinct IPC channel families.

### Top IPC files by build/sailfin/ reference count

| File | Dotfile refs |
|------|-------------|
| `instructions_dispatch.sfn` | 45 |
| `instructions_helpers.sfn` | 35 |
| `instructions_let.sfn` | 32 |
| `statement_assignment.sfn` | 29 |
| `statement.sfn` | 22 |
| `emission.sfn` | 21 |
| `module_globals.sfn` | 18 |
| `lowering_core.sfn` | 15 |
| `lowering_phase_types.sfn` | 10 |
| `lowering_phase_functions.sfn` | 13 |
| `core_call_emission.sfn` | 13 |
| `core_call_resolution.sfn` | 12 |
| `core_literals_lowering.sfn` | 12 |
| `main.sfn` | 12 |
