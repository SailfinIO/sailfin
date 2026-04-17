# Build Performance: Root Cause Analysis & Fix Plan

**Date:** 2026-04-15 (revised, post-d2d0bf1/220c8b7)
**Previous revision:** 2026-04-15 (morning), 2026-04-11
**Context:** Self-hosting the compiler from the 0.5.2-alpha.1 seed via `build.sh` takes ~13-16 minutes for 121 modules single-threaded. Down from 60-90 minutes at the April 11 baseline thanks to partial IPC removal, string concat optimization, module splitting, and the Phase 1 accumulator sweep (`d2d0bf1`). Still far from the <5 minute target. Further IPC removal is blocked by a memory management crisis: file serialization was acting as accidental garbage collection. The two residual O(n²) copy sites (`concat_native_functions`, `append_local_binding`) were reverted in `220c8b7` because callers rely on input-array immutability — they are now aliasing-blocked until either the callers explicitly clone or the arena allocator lands.

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
2. **Wait for the arena allocator (Phase 0).** Under an arena, the copy becomes cheap (bump alloc) and doesn't leak — the aliasing problem becomes a non-issue because both views remain live and freed in bulk at module exit.

Option 2 is simpler but requires Phase 0 to land first. Option 1 can proceed now but requires careful call-site analysis (lowering_core invariants around `local_functions` and nested-scope locals restoration are subtle).

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
| `append_local_binding` all 6 sites | 6 | Still copying — aliasing audit revealed deeper caller-side structural dependencies than initial audit indicated; deferred to post-M0.5 |

**Measured impact (lowering_core only — the hottest module):**

| Metric | Baseline (post-d2d0bf1) | Phase 1b partial | Delta |
|--------|------------------------:|-----------------:|------:|
| Compile time | 61.69s | 58.02s | −6.0% |
| Peak memory | 7.23 GB | 7.23 GB | ±0 |
| Aggregate build | 641.33s | 639.51s | −0.3% (noise) |

The win is concentrated on the target module; aggregate is within bench variance. `append_local_binding` conversions become cheap automatically under the M0.5 arena, so Phase 1b is complete as a pre-arena intervention.

### Phase 2: Eliminate IPC Files (Resumed)

**Priority:** Highest — **Expected:** 40-60% time reduction, enables parallel builds
**Depends on:** Phase 0 (arena allocator) to prevent OOM for the per-binding/per-instruction channels

Most IPC channels were introduced as workarounds for v0.1.1-seed ABI corruption of array-of-struct parameters across module boundaries. The 0.5.x seed lineage no longer corrupts those parameters, so many channels are now dead-code fallbacks whose readers already have the data in-memory via an existing `bindings` or `locals` parameter. Those channels can be removed immediately — they do not depend on Phase 0.

Channels that serialize per-instruction/per-binding control-flow state (dispatch, let result, block result, statement mutations) are different: they still act as implicit GC per the IPC-as-GC Problem above and must wait for Phase 0.

#### Procedure: Removing an IPC Channel

Use this pattern for every channel in the priority list. It keeps diffs surgical, preserves self-hosting after each step, and makes the determinism delta measurable.

1. **Locate the writer.** `grep 'fs\.writeLines.*\.channel_name\|fs\.writeFile.*\.channel_name' compiler/src`. There is usually exactly one.
2. **Identify the data being serialized.** If it's a struct that the writer already has as a local — and the reader already accepts that struct type as a parameter — the channel is dead code.
3. **At each reader, check whether the enclosing function already takes that parameter.** `grep 'fs\.readFile.*\.channel_name' compiler/src` to enumerate readers. For `LocalBinding[]`, `ParameterBinding[]`, and `TypeContext`, readers almost always already have the param.
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
4. **Function metadata channel** (13 refs in `lowering_phase_functions.sfn`) — per-function overhead
5. **Context functions serialization** (14 refs in `lowering_phase_types.sfn`) — per-module overhead
6. **Module globals channel** (18 refs in `module_globals.sfn`)
7. **Remaining channels** (emission, self-field, async, coerce)

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
