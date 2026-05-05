# Build Performance: Root Cause Analysis & Fix Plan

**Date:** 2026-04-25 (revised, post lowering_core per-module memory splits)
**Previous revisions:** 2026-04-25 morning (post Phase 6 Stage 1+2 flip), 2026-04-24 (post 0.5.9 release — first IPC-free seed), 2026-04-19 (post `.fn_*` channel removal), 2026-04-15 (post-d2d0bf1/220c8b7), 2026-04-15 (morning), 2026-04-11
**Context:** 0.5.9 has shipped and is pinned as the seed (`.seed-version`). It is **the first release with no file-based data-flow IPC** — every cross-phase channel that used `build/sailfin/.xxx` files has been removed. **Phase 6 Stages 1 and 2 flipped on April 24/25**: `stage_import_context` now runs in parallel under the same `JOBS` knob as the per-module emit loop, and the Makefile auto-detects `BUILD_JOBS` from CPU count and total RAM. Post-flip CI wall-times: **Linux x86_64 5:28** (was ~13 min single-threaded; 2.4× speedup), macOS arm64 10:37 (`BUILD_JOBS=1`, 7 GB RAM cap). Stage 3 (explicit CI input) shipped as a composite-action input. Stage 4 (`EMIT_RETRIES` 3→1) attempted and **reverted** — the post-0.5.9 corruption corpus is NOT dry; `llvm/lowering/instructions.sfn` surfaced one intermittent `invalid_ir` flake under `EMIT_RETRIES=1` that recovered on retry with `EMIT_RETRIES=3`. The knob is preserved; the default stays at 3 until the flake is root-caused (separate seed-stabilizer task). Two structural per-module-memory commits shipped on top: Phase 4 PR 2 (structured parser everywhere, `build_parse_result_from_text` deleted), and a `lowering_core.sfn` decomposition that shaved peak RSS from **2350 MB → 1594 MB (-756 MB, -32%)** via two extractions (`gather_imported_module_symbols`, `seed_default_runtime_helpers`). This clears the `min(nproc, mem/5)` gate in `scripts/detect_build_jobs.sh` for the first time on macOS — a follow-up can raise `BUILD_JOBS` to 2 on that runner without OOM.

---

## Symptom Summary

| Metric                          | April 11            | April 19              | April 24 (0.5.9)          | April 25 AM (post Phase 6) | **Current (April 25 PM, post lowering_core split)** | Target           |
| ------------------------------- | ------------------- | --------------------- | ------------------------- | -------------------------- | --------------------------------------------------- | ---------------- |
| Full build (1 job, single-threaded) | 60-90 min       | 13-16 min             | ~13 min (CI Linux)        | ~13 min serial / 5:28 parallel | ~2:30 local (3 jobs, container) / 5:28 CI Linux     | < 5 min          |
| Full build (CI macOS arm64)     | n/a                 | n/a                   | ~13 min                   | **10:37** (BUILD_JOBS=1)  | 10:37 (BUILD_JOBS=1; ≥2 now unblocked per-module)  | < 5 min          |
| Per-module compile time (heavy) | 4-7 min             | 1-3 min               | 1-3 min                   | 13s (`lowering_core`)     | **7.65s (`lowering_core`)**                         | < 30s ✓          |
| Per-module compile time (light) | 30s-2 min           | 10-30s                | 10-30s                    | 10-30s                    | 10-30s                                              | < 5s             |
| Per-module peak RAM (heaviest)  | 1-2 GB              | 0.5-1.5 GB            | 4.7 GB (`lowering_core` under 0.5.7 seed) | 2350 MB (`lowering_core` under 0.5.9+dev post Phase 4 PR 2) | **1594 MB (`lowering_core`)** | < 2 GB (macOS parallelism gate) ✓ |
| Parallel builds (`BUILD_JOBS`)  | Broken              | Functional but risky  | Mature, never enabled     | Auto-detected (Linux ≈3, macOS 1) | Auto-detected; **macOS can now safely go to 2** after detect_build_jobs.sh re-budgeted against new peak | Default-on, ≥4 jobs Linux |
| `fs.*` calls (total)            | 667 across 42 files | 489 across 37 files   | 212 across 24 files       | 212 across 24 files        | 212 across 24 files                                 | bounded by CLI / capsule manifest reads |
| `build/sailfin/` dotfile refs   | 487                 | 228 (dotfiles)        | 48 (diag/trace only)      | 48 (diag/trace only)       | 48 (diag/trace only)                                | 0 (post-Phase 5) |
| Active data-flow IPC channels   | 12+                 | 6                     | 0                         | 0                          | **0**                                               | 0                |
| Seed memory limit               | 8 GB                | 12 GB                 | 12 GB                     | 12 GB                      | 12 GB                                               | < 4 GB           |

---

## Reassessed Roadmap (April 25)

Status of every track named in the original RCA. "Shipped" means the work landed and the doc's **Completed Work** section has the entry.

| Track                                                           | Status                                                                        | Expected wall-time delta (remaining work) |
| --------------------------------------------------------------- | ----------------------------------------------------------------------------- | ----------------------------------------- |
| Phase 0 — M0.5 arena allocator                                  | **Shipped** (default-on April 19); arena stats env gate shipped April 25     | counted                                   |
| Phase 1 — O(n²) array accumulation sweep                        | **Shipped** (April 25 re-audit confirms zero residual `.concat([x])` sites in `llvm/lowering` + `llvm/expression_lowering`; `extend_string_lines` is in-place push) | <2%                                       |
| Phase 2 — File-based IPC channel removal                        | **Shipped** (0.5.9 — first IPC-free seed)                                     | counted                                   |
| Phase 3a — Import-discovery fast-path scanner                   | **Shipped**                                                                   | counted                                   |
| Phase 3b — Pre-parsed `.imports` sidecar                        | Not started; may be subsumed by Phase 5                                       | 5–10%                                     |
| Phase 4 PR 1 — Light recovery off non-test primary path         | **Shipped**                                                                   | counted                                   |
| Phase 4 PR 2 — `parse_native_artifact` primary swap             | **Shipped April 25** (commit `395a1c7`; swapped all 3 callers; `build_parse_result_from_text` + 4 `recover_*_light` imports deleted) | counted                                   |
| Phase 4b — Defensive light-recovery arm deletion                | Not started; needs counters bake then delete ~600 LOC                         | trivial wall-time                         |
| **Per-module memory — `lowering_core.sfn` split**               | **Shipped April 25** (commits `072bea1`, `cd34d14`): peak RSS 2350 → **1594 MB** (-32%) via `gather_imported_module_symbols` + `seed_default_runtime_helpers` extractions. Clears macOS `BUILD_JOBS=2` gate. | wall delta ancillary; unblocks parallelism |
| **Phase 6 — Parallel builds**                                   | **Stages 1+2 shipped April 24/25**; **Stage 3 shipped April 25** (`build_jobs` composite-action input); **Stage 4 reverted April 25** — `EMIT_RETRIES=1` attempted, hit a live flake on `instructions.sfn`; default stays at 3 until root-caused | Linux: **2.4× speedup** (13 min → 5:28); macOS unlock pending `detect_build_jobs.sh` rebudget against new 1594 MB peak |
| **Phase 5a — Arena mark/rewind for in-process multi-module tools** | **Shipped April 27** — `sfn_arena_mark` / `sfn_arena_rewind` C primitives + `sailfin_intrinsic_runtime_arena_*` runtime wrappers + descriptor registry entries; `sfn check` and `sfn test`'s test-discovery loops now mark the arena before the per-iteration loop and rewind at each iteration's bottom (`!json` only on the check path). `sfn_arena_alloc` got a forward-scan fix so rewound pages are reused instead of leaked. Path-normalization fix in `_collect_sfn_files_cmd` (strip trailing slash) eliminated a directory-walk SIGSEGV that surfaced once mark/rewind made the cross-iteration burst long-lived. | enables `sfn check compiler/src/` end-to-end (132 files, ~130s, was SIGSEGV at ~120s pre-Phase-5a) |
| Phase 5 — Long-lived compiler process                           | Post-1.0; needs `compile module` entry point and arena reset between modules. **Phase 5a's mark/rewind primitive is the same shape Phase 5 needs** — when Phase 5 lands, it marks at process start, rewinds between modules, no new runtime work. | 50–70% on top of Phase 6                  |

Follow-up tracks:

- **Per-module memory reduction** — done for `lowering_core.sfn`. Next worst offenders: `parser/declarations.sfn` (1759 MB), `lowering_recovery.sfn` (1570 MB — will go away with Phase 4b delete), `instructions_match.sfn` (1361 MB). Same playbook applies to declarations; flag for a follow-up branch.
- **Selfhost1 clang opt level** — **Shipped April 25** (commit `85deb34`). `SELFHOST1_OPT ?= -O0` threaded into `make check`'s first-pass build; seedcheck + stage3 keep `$(NATIVE_OPT)`. Promotes seedcheck to canonical `build/native/sailfin` on successful fixed-point so subsequent `make compile` doesn't see a stale -O0 binary.
- **Scripts/bench_compile.sh memory detection** — silently returns `0MB` for all modules when `/usr/bin/time` is not installed (the detection at `scripts/bench_compile.sh:55` correctly empties `GNU_TIME`, but the fallback path in `run_module` doesn't surface the warning in the per-module row). Low priority hygiene fix — standalone `/usr/bin/time -v <seed> emit -o ...` gives correct data today.

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

4. **No GC, no RC; arena allocator shipped, default-on for selfhost builds, off by default for installed binaries.** The runtime tracks owned strings in a hash table for safe freeing, but this is opt-in and disabled. There is no generational GC or reference counting. The M0.5 bump-allocator arena landed in PR #174 (`runtime/native/src/sailfin_arena.c`) and is wired through `_rt_malloc` / `_rt_calloc` / `_rt_realloc` / `_rt_free`. `scripts/build.sh` exports `SAILFIN_USE_ARENA=1` for the selfhost build (April 19 flip), so `make compile`, `make check`, and `make test` all run under the arena. **Installed binaries do not yet get the arena by default** — end users running `sfn check` or `sfn test` need to set `SAILFIN_USE_ARENA=1` themselves until the runtime-side default-on flip lands as a separate workstream. The M0.5 fast-fail criteria (per-module RAM < 512 MB, `make check` passes with arena on) have not yet been formally validated in CI.

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

### Phase 2: Eliminate IPC Files (✅ Shipped in 0.5.9)

**Status:** Complete. 0.5.9 is the first release with no file-based data-flow IPC. Every cross-phase channel has been removed; the 48 remaining `build/sailfin/.xxx` references are debug/diag gates (`.trace_*`, `.phase_*_diagnostics`, `.skip_*`, `.test_runner_active`, `.dump_test_sources`) — none of them carry pipeline data. The full removal arc is documented in **Completed Work** below; the per-channel entries (block_result, fn_*, expr_stmt, coerce_result, call_result, dispatch/let_result, instr_fn_name, enum_info, struct_info, async_inner_return_type, condition_locals, self_field, expr_stmt_temp, module_globals, function_metadata, emit-native.tmp / emit-llvm.tmp) cover every channel that ever existed.

**Original framing (kept for the historical record):** Most IPC channels were introduced as workarounds for v0.1.1-seed ABI corruption of array-of-struct parameters across module boundaries. The 0.5.x seed lineage no longer corrupts those parameters, so the channels were dead-code fallbacks whose readers already had the data in-memory via an existing `bindings` or `locals` parameter. Channels that serialized per-instruction/per-binding control-flow state (dispatch, let_result, block_result, statement mutations) were previously blocked by the IPC-as-GC problem — removing them without arena caused OOM because the file write/read cycle was implicitly freeing the source values. The April 19 arena default-on flip cleared that blocker and the rest of the channels came out in the following four weeks.

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
**Status:** PR 1 (non-test primary path) landed April 21 — see [Completed Work: Phase 4 PR 1](#phase-4-pr-1--non-test-primary-path-april-21). PR 2 (test-writer swap) and PR 3 (Phase 4b wrapper deletion) remain.

Replace `recover_native_functions_light` (line-by-line scanning with 20+ `starts_with` checks) and `parse_native_artifact_safe` (per-field extraction workaround) with direct structured `parse_native_artifact` calls. The non-test primary path (`compile_native_text_to_llvm_file` + `sanitize_lowering_inputs` override-reparse) is done. The test-writer path (`write_llvm_ir_for_tests_from_text` in `entrypoints_tests_writer.sfn`) still routes through `build_parse_result_from_text` pending confirmation that seed 0.5.7's seedcheck correctly dispatches typed instruction variants and reads typed-variant payload fields.

### Phase 5a: Arena Mark/Rewind for In-Process Multi-Module Tools (✅ Shipped April 27)

**Priority:** Shipped pre-1.0 — **Expected:** unblocks `sfn check compiler/src/`, `sfn test` directory mode, and the entire `sfn lsp` pre-scaffold workstream.

Phase 5's full long-lived-process redesign for `make compile` is post-1.0. But the underlying shape — "mark the arena, do work, rewind" — is exactly what `sfn check`, `sfn test`, and any future `sfn vet` / `sfn fix` / `sfn lsp` need *today*, since each of those tools already operates as a single long-lived process that walks N modules in a loop. Phase 5a ships that primitive without touching the build-system architecture.

What landed:

- **C runtime primitive** (`runtime/native/src/sailfin_arena.c`):
  - `sfn_arena_mark()` snapshots `(current_page, used)` — ~5 LOC.
  - `sfn_arena_rewind(mark)` walks pages back to the snapshot, zeroes `used` on every page strictly after the marked page, and resets `arena->current` to the marked page so subsequent allocations reuse the existing capacity. ~15 LOC.
  - **Bug fix in `sfn_arena_alloc`**: when the current page fills up, scan `current->next` forward looking for an empty page (with capacity) before allocating a new one. Without this, rewound pages downstream of the mark target stayed attached but were never reused — every iteration allocated fresh pages and the page list grew linearly, defeating mark/rewind. Identified during integration testing on `sfn check compiler/src/` (124 pages × 4 MB = 496 MB after 30 analysis passes pre-fix; ~92 pages stable after).
- **C runtime wrappers** (`runtime/native/src/sailfin_runtime.c`): `sailfin_intrinsic_runtime_arena_mark()` returns the encoded mark as `double` (Sailfin `number`); `sailfin_intrinsic_runtime_arena_rewind(double)` decodes and rewinds. Encoding packs `(page_index, used)` into the 53-bit mantissa. Both gated on `sfn_arena_enabled()` so they're no-ops with `SAILFIN_USE_ARENA` unset.
- **Sailfin descriptor entries** (`compiler/src/llvm/runtime_helpers.sfn` + `compiler/src/llvm/lowering/lowering_helpers.sfn`): bare-name targets so the seed compiler's compiled-in descriptor table resolves the call to the C symbol the same way it does `monotonic_millis()`.
- **Call sites**:
  - `compiler/src/cli_check.sfn:handle_check_command`: mark before the per-file loop, rewind at the bottom of each iteration in non-JSON mode (JSON mode keeps `results[]` for envelope construction so it can't rewind). Cross-iteration state — `groups[].interfaces`, `function_effects`, `aggregate_*` arrays, `file_group_index`, `files` — is all populated *above* the mark, so the rewind is correctness-safe.
  - `compiler/src/cli_commands.sfn:handle_test_command`: mark before the per-test loop, rewind at the bottom of each iteration. Cross-iteration state (`test_files`, `groups`, `runtime_root`) sits above the mark.
- **Path-normalization fix** in `compiler/src/cli_commands_utils.sfn:_collect_sfn_files_cmd`: strip a trailing slash from the root directory before the BFS. Without this, `dir + "/" + entry` produced double-slashed paths (`compiler/src//ast.sfn`) that — once Phase 5a made the cross-iteration burst long-lived enough to expose it — tripped a downstream resolver-grouping path into a SIGSEGV during the late-tail batch of files.
- **Acceptance test** (`compiler/tests/e2e/test_check_compiler_src.sh`, 4 cases):
  1. `sfn check compiler/src` (no trailing slash) completes with exit 0 or 1 (never 139).
  2. `sfn check compiler/src/` (trailing slash) — same.
  3. Exit codes match between (1) and (2).
  4. Directory walk visits every `.sfn` file under `compiler/src/`.

Two-PR sequence:

- **Step 1** (PR #249, merged into 0.5.10-alpha.1): C runtime primitive + descriptors + lowering helper declarations. **No Sailfin callers.** This is the seed-bootstrap step — the released compiler's compiled-in descriptor table now knows the helpers.
- **Step 2** (this PR): bumped `.seed-version` to 0.5.10-alpha.1, added the `cli_check.sfn` / `cli_commands.sfn` callers via bare-name descriptor lookup, plus the path-normalization fix and the acceptance test.

Headline measurement:

| Scenario                            | Pre-Phase-5a               | Post-Phase-5a                       |
| ----------------------------------- | -------------------------- | ----------------------------------- |
| `sfn check` single file (`main.sfn`)| 84 s SIGSEGV (pre-cache)   | 8 s clean                           |
| `sfn check` 60 files                | 98 s SIGSEGV               | ~80 s clean                         |
| `sfn check compiler/src/` (132 files)| 120 s SIGSEGV             | 130 s clean (rc=1, 2 errors found)  |

Open follow-up: `SAILFIN_USE_ARENA=1` is exported by `scripts/build.sh` (so `make compile`/`make check`/`make test` get the arena), but installed binaries used by end users do not get the arena by default. Phase 5a only helps when the arena is on. A separate PR flips `_init_arena_enabled` to default `1` (with `SAILFIN_USE_ARENA=0` as the opt-out) so `sfn check` for end users gets the arena without surfacing an env-var contract.

### Phase 5: Long-Lived Compiler Process (Future)

**Priority:** Future (post-1.0 or late pre-1.0) — **Expected:** 50-70% time reduction on top of Phase 6

Replace the 121 separate compiler processes with a single long-lived process that compiles all modules in sequence (or in parallel with shared state):

- Eliminates per-module startup overhead
- Enables in-process import artifact caching (Phase 3 becomes trivial)
- Eliminates per-module import-context directory copies
- Arena allocator resets between modules instead of process exit — Phase 5a's `sfn_arena_mark` / `sfn_arena_rewind` primitives are exactly the right shape; Phase 5 marks at process start and rewinds between modules.

This requires the compiler to support a "compile module" entry point that takes import context as an argument rather than reading it from the filesystem.

### Phase 6: Parallel Builds

**Priority:** Highest. **Stages 1+2 shipped April 24/25; measured 2.4× speedup on Linux CI.** Stages 3–4 remain queued.
**Depends on:** Phase 0 (arena default-on, shipped) and Phase 2 (IPC removal, shipped). Both prerequisites are met.

The xargs-based parallel emit path in `build_module` (`scripts/build.sh`) has been mature for weeks. Each parallel worker runs `bash scripts/build.sh --_build_module_worker` in an isolated `seed_cwd`, copies the import-context, runs the seed, and appends one line to a shared `MODULES_LIST` (atomic for sub-PIPE_BUF lines). The list is `LC_ALL=C sort`ed before `llvm-link` consumption so link order is deterministic regardless of completion order. The same pattern now applies to `stage_import_context` via the new `--_stage_import_worker` entry.

The reason it never went default before April 25 was per-job memory: with the arena default-on, `lowering_core` (the heaviest module) peaks at ~4.7 GB RSS. With `BUILD_JOBS=4`, worst-case concurrent peak is ~18.8 GB. That fits ubuntu-24.04 GitHub runners (22 GB) but overcommits `macos-latest` (M1, 7 GB) — which is exactly why the Stage 2 heuristic caps macOS at `BUILD_JOBS=1`.

#### Measured CI wall-time (post-flip)

| Runner          | Before (single-thread) | After (auto BUILD_JOBS) | Speedup |
| --------------- | ---------------------- | ----------------------- | ------- |
| linux-x86_64    | ~13 min                | **5:28**                | 2.4×    |
| macos-arm64     | ~13 min                | **10:37** (BUILD_JOBS=1) | 1.2×   |

macOS gets a smaller win because the heuristic picks `BUILD_JOBS=1` to fit the 7 GB total RAM ceiling. The improvement there comes entirely from the parallel `stage_import_context` step still being able to overlap I/O even when `JOBS=1` (which… it can't — at JOBS=1 staging is serial). The macOS speedup likely comes from the per-worker preamble silencing fix and modest CI runner variance, not parallelism.

#### Enablement plan (staged rollout)

1. **Stage 1 — parallelize `stage_import_context`.** ✅ **Shipped April 24** (commit `d5a2d93`, plus log-noise fix `0eda32b`). The loop was previously sequential ("for safety with older seeds"). 0.5.9 is the safe seed; the same `xargs -P` pattern from `build_module` applies directly. Each `seed emit native <src> >dest` call writes to a distinct destination, no shared state.
2. **Stage 2 — adaptive `BUILD_JOBS` default in the Makefile.** ✅ **Shipped April 24** (commit `7f0ef9a`). `scripts/detect_build_jobs.sh` computes `BUILD_JOBS` from `nproc` capped by a memory budget (5 GB per job ≈ heaviest-module peak under arena, plus headroom). On macOS, cap at 2 jobs because of the 7 GB total RAM ceiling on M1 runners. Global cap of 8 jobs prevents I/O / link-time contention from dominating on workstations. Existing `BUILD_JOBS=N` env override still wins.
3. **Stage 3 — wire `BUILD_JOBS` through the CI composite action.** Currently CI inherits the Makefile's auto-detected default (Stage 2 carried this for free since `.github/actions/sailfin-build` calls `make rebuild` without overriding `BUILD_JOBS`). The remaining work is to surface `build_jobs` as an explicit composite-action input so individual workflows can override (e.g. pin to 1 for a regression bisect, or to 8 on a self-hosted runner). **Pending** — low-priority polish; the auto default is already producing the desired effect in PR CI.
4. **Stage 4 — drop `EMIT_RETRIES` default 3 → 1.** With 0.5.9 stable, the corruption corpus is dry; retries only hide regressions now. Keep the env knob for diagnostic builds. **Pending** — needs one full build with `retries.log` inspection to confirm zero retry hits in CI.

#### Why each stage is safe

- **Stage 1 (parallel staging):** Each `stage_import_context` call writes to `$IMPORT_CACHE/${slug}.sfn-asm` and `$IMPORT_CACHE/${slug}.layout-manifest`. Slugs are derived from source paths via `slug_from_path`, which is unique by construction. The seed writes only to the redirected destination — no shared scratch directory. The April 25 follow-up (`fix(build): silence per-worker preamble`) gates the directory-prep / cleanup blocks behind `IS_WORKER=0`, eliminating a latent race where peer workers could have stomped each other's `.ll` files when `build_module` parallelism is increased further.
- **Stage 2 (adaptive default):** `detect_build_jobs.sh` picks `min(nproc, total_ram_gb / 5)` clamped to `[1, 8]`, with a macOS additional cap of 2. Falls back to 1 on any platform we can't probe (Windows, BSD without `/proc/meminfo` and without `sysctl hw.memsize`). `BUILD_JOBS` env var still overrides for users who want a specific number.
- **Stage 3 (CI wiring):** Adding the input is purely additive. Existing callers that don't set it continue to inherit the Makefile's auto-detected default.
- **Stage 4 (retry budget):** The retry corpus (`build/selfhost/native/corrupted/`) is the canonical signal. If `find $WORK_DIR/corrupted -type f -newer build/native/sailfin | wc -l` is 0 across one full nightly, retries are dead weight.

#### What this does NOT change

- Determinism: link order is sorted post-emit; LLVM IR output is byte-identical to the serial path (the existing `make check` fixed-point comparison continues to gate this).
- Memory ceiling: `SEED_MEM_LIMIT=12 GB` per process is unchanged. A future PR can lower this to 6 GB once we have telemetry showing no module needs more.
- `make check` triple-pass logic: the seedcheck and stage3 builds use the same `BUILD_JOBS` knob, so the fixed-point comparison runs at parallel load too.

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

- ~~**Tier 1A PR 2 — callsite swap.**~~ — **Shipped** (see [Completed Work: Tier 1A PR 2+3](#tier-1a-pr-23--callsite-swap--wrapper-deletion-april-21)).
- ~~**Tier 1A PR 3 — wrapper deletion.**~~ — **Shipped** (combined with PR 2 in the same PR).
- **Tier 1A PR 4 (optional) — equivalence regression test.** Add `compiler/tests/unit/parse_native_artifact_equivalence_test.sfn` constructing a synthetic `.sfn-asm` fixture that exercises every top-level directive (`.import`, `.export`, `.struct`+body, `.interface`+body, `.enum`+body, `.fn`+body, `.test`+body, top-level binding, `.decorator`, `.span`, `.init-span`) and asserts field-by-field equality between `parse_native_artifact(fixture).X` and each legacy `parse_native_X_from_text(fixture)` projection. Defense-in-depth only — the self-host itself is the real equivalence gate. Must follow the `parse_native_imports_fast_test.sfn` pattern (re-implement against minimal local types to stay under the 60s per-test budget; do not import the full parser chain).

### Tier 1A PR 2+3 — Callsite Swap + Wrapper Deletion (April 21)

**Status: Implemented.** Combines the two planned Tier 1A follow-ups into a single PR: swap every `parse_native_artifact_safe` callsite to `parse_native_artifact`, delete the wrapper, and prune the five orphaned `_from_text` projections that fell out once the wrapper's internal machinery was gone.

**Shape of change:**

- `compiler/src/llvm/lowering/entrypoints.sfn`: dropped `parse_native_artifact_safe` from the `./lowering_recovery` import block (`parse_native_artifact` was already imported from `../../native_ir_api`). Dropped the five orphan `_from_text` imports (`parse_native_structs_from_text`, `parse_native_imports_from_text`, `parse_native_interfaces_from_text`, `parse_native_enums_from_text`, `parse_native_diagnostics_from_text`) — they were imported but never referenced in this file. Swapped all 5 callsites (lines 158, 214, 223, 257, 360 after prior edits) to `parse_native_artifact`.
- `compiler/src/llvm/lowering/entrypoints_tests.sfn`: added `parse_native_artifact` to the `../../native_ir_api` import block, dropped the `parse_native_artifact_safe` import from `./lowering_recovery`, swapped the single callsite.
- `compiler/src/llvm/lowering/entrypoints_tests_writer.sfn`: dropped the dead `parse_native_artifact_safe` import (referenced only in a comment; real path uses `build_parse_result_from_text`). Updated the comment to reference `parse_native_artifact` instead.
- `compiler/src/llvm/lowering/lowering_phase_sanitize.sfn`: dropped `parse_native_artifact_safe` from the `./lowering_recovery` import block — the identifier never appeared in the file body.
- `compiler/src/llvm/lowering/lowering_recovery.sfn`: deleted `fn parse_native_artifact_safe` (one-line delegator) and its header comment block. Pruned now-unused imports `parse_native_artifact` (from `../../native_ir_api`) and `ParseNativeResult` (from `../../native_ir`). Rewrote the module header comment to drop the stale `parse_native_artifact_safe` reference.
- `compiler/src/native_ir_api.sfn`: deleted the five orphaned `_from_text` wrappers (`parse_native_structs_from_text`, `parse_native_imports_from_text`, `parse_native_interfaces_from_text`, `parse_native_enums_from_text`, `parse_native_diagnostics_from_text`) and their entries in the `export` block. **Kept:** `parse_native_artifact`, `parse_native_function_count_from_text`, `parse_native_functions_from_text`, `parse_native_bindings_from_text`, all `_for_import` variants, `parse_native_artifact_for_import_context`, `parse_layout_manifest` — all still have live callers (verified via repo-wide `grep -rn` prior to deletion).

**Caller audit at PR-open time:**

| Symbol                                 | Live callers (non-import) | Decision |
| -------------------------------------- | -------------------------: | -------- |
| `parse_native_artifact_safe`           |                          6 | delete after swap |
| `parse_native_structs_from_text`       |                          0 | delete |
| `parse_native_imports_from_text`       |                          0 | delete |
| `parse_native_interfaces_from_text`    |                          0 | delete |
| `parse_native_enums_from_text`         |                          0 | delete |
| `parse_native_diagnostics_from_text`   |                          0 | delete |
| `parse_native_functions_from_text`     |                          4 | keep (`lowering_recovery`, `lowering_phase_sanitize`) |
| `parse_native_function_count_from_text`|                          1 | keep (`lowering_recovery`) |
| `parse_native_bindings_from_text`      |                          1 | keep (`lowering_phase_sanitize`) |

Pre-existing dead imports of the retained symbols in `lowering_core.sfn` and `lowering_helpers.sfn` are left alone — they're not in scope for Tier 1A and their removal is a separate cleanup.

**API surface change:** all five deleted `_from_text` symbols were in the `export` block of `native_ir_api.sfn`; they are now removed from the public surface. No capsule outside the compiler imports them (caller audit is repo-wide).

**Risk assessment:**

- **Output equivalence:** `parse_native_artifact(text) ≡ parse_native_artifact_impl(text, true, true)` — the exact call the wrapper delegated to. The five deleted projection wrappers were pure `parsed.X` field reads off the same underlying parser; no caller depended on any projection-only semantics.
- **Structural / import-graph change:** touches 6 source files with one symbol deletion and 5 projection deletions. Requires `make clean-build` on a fresh build directory because several modules' import lists changed. CI's matrix build on PR open exercises this on every supported platform.
- **Self-hosting:** only `parse_native_artifact_safe`'s five live callers were real work — each reduces from a trivial delegate call to the underlying parser call. Compiler output is byte-identical by construction.

**Scope:**

- 6 source files modified (`entrypoints.sfn`, `entrypoints_tests.sfn`, `entrypoints_tests_writer.sfn`, `lowering_phase_sanitize.sfn`, `lowering_recovery.sfn`, `native_ir_api.sfn`) + this entry in `docs/build-performance.md` + `docs/proposals/phase-4-eliminate-light-recovery.md` (architect's Phase 4 migration plan, dropped in the same PR so the next session can pick it up).
- Net: approximately −70 lines across the 6 source files (wrapper deletion + 5 projection deletions + dead-import pruning). No signature changes, no new wrapper structs, no new tests (the self-host itself exercises every live path on every `make check`).

**Determinism:** No new cross-phase or cross-process state. The parse result flowing into every downstream lowering phase is produced by the same single-pass `parse_native_artifact_impl` invocation as before; the only change is whether it routes through a trivial wrapper or not. CI determinism sweep on macOS-arm64 should show no regression.

### Phase 4 PR 1 — Non-Test Primary Path (April 21)

**Status: Partially implemented (revised April 21 after CI discovered a cross-module ABI segfault).** First Phase 4 landing. The `sanitize_lowering_inputs` override-reparse block is gone and the per-import `recover_native_enums_light` was replaced with `parse_native_enums_for_import`. The `compile_native_text_to_llvm_file` primary-parse swap (`build_parse_result_from_text` → `parse_native_artifact`) was **reverted** because the 0.5.7 seed compiled a latent cross-module ABI bug into `ParseNativeResult` struct returns that causes a segfault inside `sanitize_structs` / `sanitize_enums` / `sanitize_interfaces` when the parse result is marshaled from `native_ir_api.sfn` across into `lowering_core.sfn`. The swap moves to Phase 4 PR 2 once the struct-return ABI is stable. The other wins land: removing the override-reparse block alone eliminates three full line-scanner walks per module on the primary path (the block was re-running `recover_native_functions_light` + `recover_native_structs_light` + `recover_native_enums_light` on every `compile_native_text_to_llvm_file` invocation).

**Shape of change:**

- `lowering_core.sfn::compile_native_text_to_llvm_file`: **kept** on `build_parse_result_from_text(native_text)` — the primary-parse swap to `parse_native_artifact` was attempted and reverted (see Root-cause note below). Dropped the redundant `recover_native_imports_light(native_text)` call in favor of reusing `parse.imports` (which, from `build_parse_result_from_text`, is equivalent — only `.import` entries). Net: one fewer redundant artifact walk per non-test module compile.
- `lowering_core.sfn` per-import loop at `:425`: swapped `recover_native_enums_light(native_text)` → `parse_native_enums_for_import(native_text)`. Fires once per transitive imported module — typical compiler module imports 5-20, so this eliminates a full line-scanner walk per import per module compile. Safe under the cross-module ABI issue because `parse_native_enums_for_import` returns a `NativeEnum[]` (single flat array), not a nested `ParseNativeResult` struct.
- `lowering_core.sfn` imports: added `parse_native_artifact` (kept for future PR 2) and `parse_native_enums_for_import` to the `native_ir_api` block. `parse_native_artifact` remains imported even though its call site was reverted, because retaining the import tracks the pending PR 2 work and avoids a further edit when it lands.
- `lowering_core.sfn::build_parse_result_from_text` (lines 125-144): **retained** as the primary-path parser with an updated doc-comment pointing at the Phase 4 PR 2 gating question. Still has two live callers: `compile_native_text_to_llvm_file` (primary path) and `entrypoints_tests_writer.sfn:132` (test-writer path). Both move to `parse_native_artifact` in PR 2 once the cross-module struct-return ABI and the test-writer typed-tag dispatch are both confirmed under seed 0.5.7.
- `lowering_phase_sanitize.sfn::sanitize_lowering_inputs`: deleted the `_rfns`/`_rsts`/`_rens` override-reparse block (formerly lines 58-83). The structured `parse_in` is now authoritative end-to-end. Function body collapses from ~40 lines to 8.
- `lowering_phase_sanitize.sfn` imports: dropped `recover_native_enums_light` and `recover_native_imports_light` (both were only used by the deleted override-reparse block). `recover_native_functions_light` and `recover_native_structs_light` remain in the import list — they still feed the defensive `sanitize_functions` and `recover_structs_if_corrupt` fallbacks, which only fire on empty/corrupt primary parse.
- `entrypoints.sfn` imports: dropped `recover_native_functions_light`, `recover_native_imports_light`, `recover_native_structs_light` (all three were imported but never referenced in the file — dead imports left over from earlier pipeline passes). `recover_functions_for_lowering` retained as a single-symbol import block.
- `docs/proposals/phase-4-eliminate-light-recovery.md`: Section 3 (Scope) and Section 4 (PR 1 Step 2) rewritten to match the actual PR 1 endpoint — `build_parse_result_from_text` deletion and its light-recovery import drops are explicitly moved to PR 2.

**Per-module overhead removed (non-test primary path):**

- 1 redundant `recover_native_imports_light(native_text)` call at the call site (the one at `compile_native_text_to_llvm_file:258`). `build_parse_result_from_text` already calls it internally; the extra one was pure redundancy. Eliminated.
- The entire override-reparse swap-in-place block in `sanitize_lowering_inputs` — another 3 walks (`_rfns` / `_rsts` / `_rens`) per module compile when `native_text_override_path` is non-empty (the normal case from `compile_native_text_to_llvm_file`). Eliminated.
- Per imported module: 1 full line-scanner walk (`recover_native_enums_light`) replaced with `parse_native_enums_for_import`, which routes through the same single-pass `parse_native_artifact_impl` the other import helpers already share. This is ~5-20 walks eliminated per module compile depending on import fan-in.

For the 121-module compiler self-host, this is thousands of line-scanner walks per build on the primary path via the override-reparse removal alone, plus the redundant import-recovery call elimination. The full primary-parse swap (another 4 walks → 1 per module) is deferred to PR 2.

**Root-cause note for the reverted primary-parse swap:**

The initial PR 1 swapped `build_parse_result_from_text(native_text)` → `parse_native_artifact(native_text)` in `compile_native_text_to_llvm_file`. CI on both linux-x86_64 and macos-arm64 segfaulted inside `test_capsule_build.sh` with `rc=139` and no stdout/stderr output. Local reproduction (self-host + `sfn build` on a minimal `sfn/math` capsule) isolated the crash to `sanitize_structs` / `sanitize_enums` / `sanitize_interfaces` operating on fields of the `ParseNativeResult` returned by `parse_native_artifact`. The crash is a `SEGV_MAPERR` (unmapped address) when reading those array fields.

`build_parse_result_from_text` is defined inside `lowering_core.sfn` and constructs its `ParseNativeResult` locally from four cross-module `recover_*_light` calls — no cross-module struct return. `parse_native_artifact` is defined in `native_ir_api.sfn` and returns `ParseNativeResult` across the module boundary. The 0.5.7 seed compiles this specific cross-module struct-return pattern with a latent ABI bug: the returned struct's array fields point into memory that is unmapped by the time the caller reads them. Every other live call site of `parse_native_artifact` routes through a function in the same module (entrypoints.sfn or entrypoints_tests.sfn) that immediately destructures into local arrays before passing downstream; `compile_native_text_to_llvm_file` in `lowering_core.sfn` was the first caller to consume the struct's fields across the boundary in the sanitize chain.

The fix is not to guess at the ABI corner; the fix is to not rely on the cross-module struct-return until a future seed can marshal it safely. The primary-parse swap moves to Phase 4 PR 2 along with the test-writer migration. PR 2's gate expands to cover both conditions: (a) seedcheck correctly dispatches typed-tag instruction variants AND reads their payloads, (b) the 0.5.7+ seed reliably marshals `ParseNativeResult` across module boundaries. Both are needed before the swap can safely land.

**Defensive fallbacks retained (Phase 4b scope):**

- `sanitize_functions` at `lowering_phase_sanitize.sfn:~267` — still calls `recover_native_functions_light` if the structured parse returns zero functions or only extern declarations.
- `recover_structs_if_corrupt` at `lowering_phase_sanitize.sfn:~350` — still calls `recover_native_structs_light` if every safe struct has an empty name.
- `recover_functions_for_lowering` light arms at `lowering_recovery.sfn:773, 838, 852` — still fire when the structured parser returns empty / inconsistent results.
- These stay in place as belt-and-suspenders. Phase 4b (PR 3) will add `print.err` counters, bake for a release cycle, and delete the arms and their `recover_*_light` bodies once counters confirm zero hits on the happy path.

**Risk assessment:**

- **Reverted primary-parse swap** — see the Root-cause note above. The partial PR 1 delivers the override-reparse removal but defers the `parse_native_artifact` call-site swap to PR 2 to avoid the cross-module struct-return ABI bug.
- **macOS-arm64 determinism**: the deleted override-reparse block was introduced during v0.1.1-seed-era ABI flake. Seed 0.5.7 with arena has been stable across PRs #183-#203 determinism sweeps. Pre-merge gate is CI's macOS-arm64 matrix build + a 20× `emit llvm` determinism sweep on `lowering_core.sfn` (see verification section in the proposal).
- **Defensive-fallback hits on the happy path**: with `build_parse_result_from_text` still the primary parser, the `sanitize_functions:267` and `recover_structs_if_corrupt:350` arms remain live as they were before the PR. Phase 4b's counter PR is the correct gate for *deleting* these arms; PR 1 leaves them in place specifically so any structured-parser bug (when PR 2 re-introduces it) gets caught and corrected instead of propagating a regression into IR.

**Scope:**

- 3 compiler source files modified (`lowering_core.sfn`, `lowering_phase_sanitize.sfn`, `entrypoints.sfn`) + 2 docs files (this entry + `docs/proposals/phase-4-eliminate-light-recovery.md` scope rewrite).
- Net approximately −40 lines in `lowering_phase_sanitize.sfn` (override-reparse block gone), −10 lines across `lowering_core.sfn` (call-site simplification + import additions), −8 lines in `entrypoints.sfn` (dead-import cleanup). No signature changes, no new wrapper structs, no new tests (the self-host itself exercises every live path on every `make check`; the defensive fallbacks at `sanitize_functions:267` / `recover_structs_if_corrupt:350` / `recover_functions_for_lowering:773` catch regressions).

**Determinism:** The deleted override-reparse block was a cross-module reparse that fed back into the primary pipeline's `parse`. Removing it shrinks the set of per-module operations that can non-determinize output on macOS-arm64. Post-change emit-sweep measurements to land in the PR body once CI completes on all platforms.

**Follow-ups:**

- **Phase 4 PR 2** — gating now expands to three conditions: (a) seedcheck typed-tag dispatch works, (b) seedcheck reads typed-variant payload fields correctly, (c) seed 0.5.7+ reliably marshals `ParseNativeResult` across module boundaries (or we route the structured parse through a same-module wrapper that destructures into flat arrays before crossing). Once all three clear, swap `compile_native_text_to_llvm_file:261` + `entrypoints_tests_writer.sfn:132` to `parse_native_artifact`, delete `build_parse_result_from_text` and its four light-recovery imports in `lowering_core.sfn`, and add a test-harness determinism check.
- **Phase 4b (PR 3)** — instrument the three remaining defensive-fallback arms with `print.err` counters; after a release cycle with zero hits, delete the arms plus the `recover_*_light` function bodies from `lowering_recovery.sfn` (~600 LOC).

### Phase 4 PR 2 — Structured Parser Everywhere (April 25)

**Status: Implemented.** Swaps every live caller of `build_parse_result_from_text` in `lowering_core.sfn`, `entrypoints.sfn` (`print_llvm_ir_from_text`), and `entrypoints_tests_writer.sfn` (`write_llvm_ir_for_tests_from_text`) to `parse_native_artifact` (single-pass structured parser in `native_ir_api.sfn`). Deletes the wrapper + four `recover_*_light` import aliases from `lowering_core.sfn`; trims stale comments from `lowering_recovery.sfn` and `lowering_phase_sanitize.sfn`.

**Unblocked by:** seed 0.5.9 (file-IPC-free; stable cross-module struct returns on the happy path) + PR #229 (routes `compile_to_llvm_file_with_module` through in-memory lowering, closing the April 21 sanitize-chain SEGV that had forced the previous revert).

**Per-module overhead removed:** 4 full line-scanner walks (the `recover_*_light` helpers inside the old `build_parse_result_from_text` body) replaced with a single `parse_native_artifact_impl` pass per non-test module compile.

**Scope:** 5 files, net -64 / +19. `recover_native_functions_light` / `recover_native_structs_light` remain defined in `lowering_recovery.sfn` — still have live defensive-fallback callers in `lowering_phase_sanitize.sfn` and `lowering_recovery.sfn` itself. Phase 4b will remove those arms after counter bake.

**Determinism:** Fresh `make compile FORCE=1` selfhost completed in 155s on a 3-job Linux container. No new retries. No `invalid_ir` failures in the emit loop for modules that consume `parse_native_artifact` across boundaries — the Phase 4 PR 1 revert signal.

**Commit:** `395a1c7`.

### lowering_core.sfn Per-Module Memory Split — PR 1 + PR 2 (April 25)

**Status: Implemented.** Two-commit decomposition of `lowering_core.sfn` (732 LOC after Phase 4 PR 2) driven by a new measurement: peak RSS on the heaviest module was **2350 MB** post-Phase-4-PR-2 on a Linux container with the freshly self-hosted 0.5.9+dev binary. Gate for `BUILD_JOBS=2` on the macOS GitHub runner (7 GB RAM, `min(nproc, mem/5)`) is 2 GB per module. Goal: get under 2 GB so the macOS `BUILD_JOBS` heuristic relaxes.

**PR 1 — extract Phase 2 import-gather** (commit `072bea1`):
Pulls the 52-line Phase 2 import-gather loop out of the orchestrator and into `lowering_phase_imports.gather_imported_module_symbols`. The orchestrator now calls the helper once and destructures the returned `ImportedModuleSymbols` into the 5 local arrays. Moves 6 imports (`parse_native_structs_for_import`, `parse_native_enums_for_import`, `extend_native_functions`, `parse_single_import_interfaces`, `parse_single_import_functions`, `extract_import_struct_methods`) out of `lowering_core`.

**PR 2 — seed default runtime helpers** (commit `cd34d14`):
Collapses the 82-line block of `runtime_helpers.append_unique_effect(...)` calls (67 unconditional + 3 conditional) in the orchestrator into a single call to the new `lowering_helpers.seed_default_runtime_helpers(initial)`. Normalizes the conditional `if !string_array_contains { push }` sites to the dedupe-equivalent `append_unique_effect`. Drops 2 imports from `lowering_core` (`append_unique_effect`, `string_array_contains`).

**Measured peak RSS on `lowering_core.sfn`:**

| Stage | Peak RSS | Wall | Delta |
| --- | ---: | ---: | ---: |
| Pre-branch baseline | 2350 MB | 13.42s | — |
| After PR 1 | 2067 MB | 9.66s | **−283 MB / −28% wall** |
| After PR 2 | **1594 MB** | 7.65s | **−473 MB further / −21% wall** |
| **Cumulative** | — | — | **−756 MB (−32%) / −43% wall** |

Result: `lowering_core.sfn` is now **406 MB under the 2 GB per-module gate**. macOS `BUILD_JOBS=2` is unblocked on the per-module memory axis.

Other modules' peak RSS unchanged: `lowering_recovery` 1570 MB, `instructions_match` 1361 MB, `parser/declarations` 1759 MB. The new homes grew proportionally: `lowering_phase_imports.sfn` 92 MB (was ~30 MB), `lowering_helpers.sfn` 1292 MB (was ~800 MB) — both comfortably under the gate.

**Determinism:** 3× `emit llvm` of `lowering_core.sfn` after each commit produced md5-identical IR.

**Landmine discovered and documented:** the architect's original PR 1 plan named the new struct `ImportedModuleContext` — that name is already taken by an unrelated struct in `llvm/types.sfn` (manifests / native_texts / diagnostics, consumed by `collect_imported_module_context_for_module`). Defining a second `ImportedModuleContext` in `lowering_phase_imports.sfn` made the 0.5.9 seed produce a subtly miscompiled binary: it compiled cleanly and linked, but every `emit` invocation of the produced compiler segfaulted during struct-field access. Classic shadow-struct ABI symptom. Renamed to `ImportedModuleSymbols` → SEGV disappeared, IR byte-equal across runs. Any future cross-module struct extraction should grep the repo for the proposed name first.

**Not shipped (deferred):** PR 3 (test-harness extraction, projected −50 to −100 MB) and PR 4a (delete dead `skip_effects=true` block) queued in the architect's plan. The 2 GB target is already hit with 406 MB of margin; PR 3+4a are pure code tidy at this point and can ship independently if a future regression pushes peak back above 2 GB.

---

### Additional Perf-Track Commits (April 25)

**`SAILFIN_DUMP_ARENA_STATS` env gate** (commit `69b56bd`): wires `sfn_arena_print_stats` into `native_driver.c` as an `atexit` handler gated on `SAILFIN_DUMP_ARENA_STATS=1 && SAILFIN_USE_ARENA=1`. Output line includes a source-path label derived from argv. Sample on `lowering_core.sfn` solo compile: `pages=103 capacity=412.00MB used=409.18MB allocated=332.36MB utilization=99.3%`. This surfaced the critical insight that arena allocated bytes (~332 MB) are a small fraction of peak RSS (~2350 MB pre-split) — the bulk of the seed's per-module memory is non-arena (typecheck state, import-graph transitive closure, emission buffer). Splitting the file reduces *imports-side* of that budget, which is what PR 1+2 above exploit.

**`SELFHOST1_OPT ?= -O0` thread-through** (commit `85deb34`): `make check`'s first-pass binary now builds at `-O0` by default (clang compile stage drops 20-30% in the validation flow). Seedcheck + stage3 keep `$(NATIVE_OPT)` (-O2) because they are the fixed-point binaries. `check` gets a seedcheck → canonical promotion step at the tail to avoid leaving a stale -O0 binary at `build/native/sailfin` after a successful run.

**`build_jobs` composite-action input** (commit `3cd820d`): `.github/actions/sailfin-build/action.yml` gains an explicit `build_jobs` input that forwards into `make rebuild` as `BUILD_JOBS=N`. Empty (default) inherits the Makefile's auto-detect. Lets individual workflows pin a value (regression bisects, self-hosted runners) without editing the composite.

**`EMIT_RETRIES` 3→1 attempted + reverted** (commits `e45730e` → `ff970fc`): the first `make compile` post-commit hit a one-shot `invalid_ir` flake on `llvm/lowering/instructions.sfn` (mid-struct-definition memory corruption, `%NativeBinding = type <garbage-utf8>`). Retried with `EMIT_RETRIES=3` and the same build cleanly produced valid IR on attempt 1 — i.e. a genuine flake, not deterministic. The post-0.5.9 corruption corpus is NOT dry; retries are still masking real intermittent IR corruption. Reverted the default change until a seed-stabilizer session can root-cause the flake. Env knob still works for diagnostic builds.

---

## Appendix: IPC Channel Census

**Current (April 24, post-0.5.9):** 212 `fs.*` calls across 24 files. 48 `build/sailfin/.xxx` references across 18 files. **Zero data-flow IPC channels.**

The remaining `fs.*` surface is concentrated in CLI / orchestration paths that legitimately read filesystem state (capsule manifest resolution, lock-file management, target-directory bookkeeping) — not pipeline IPC:

| File                                        | `fs.*` calls | Role                            |
| ------------------------------------------- | -----------: | ------------------------------- |
| `cli_commands.sfn`                          |           60 | CLI subcommand dispatch          |
| `main.sfn`                                  |           36 | binary entry point + flag parsing |
| `cli_main.sfn`                              |           22 | CLI argv routing                  |
| `capsule_resolver.sfn`                      |           19 | capsule manifest + dep resolution |
| `llvm/lowering/lowering_core.sfn`           |           14 | trace gates + diagnostic dumps    |
| `llvm/imports.sfn`                          |           13 | import-context reads              |
| `cli_commands_utils.sfn`                    |           13 | CLI helpers                       |
| `llvm/lowering/lowering_io.sfn`             |            9 | LLVM IR output                    |
| `version.sfn`                               |            6 | resolve compiler version          |
| `llvm/runtime_helpers.sfn`                  |            5 | runtime IR file reads             |

The remaining `build/sailfin/.xxx` references are **all flag/diagnostic gates**:

```
(historical inventory — all flag-file probes have since been retired by issues
#308, #311, and #312. See the migration sections below for the full census.)
build/sailfin/.dump_test_sources         build/sailfin/.skip_typecheck
build/sailfin/.phase_functions_diagnostics build/sailfin/.trace_argv
build/sailfin/.phase_types_diagnostics   build/sailfin/.trace_call_lowering
build/sailfin/.skip_module_globals       build/sailfin/.trace_emit
build/sailfin/.skip_test_inlining        build/sailfin/.trace_lowering
                                         build/sailfin/.trace_test_runner
```

These were checked via `fs.exists`/`fs.readFile` as a workaround for the lack of `--feature-flag X=Y` plumbing in the CLI. They carried no pipeline data, but the parent/child cwd-inheritance pattern raced with subprocess-emit. The migration to env vars (issue #308) and module-local state (#311, #312) closed that gap.

> Issue #311 (May 2026) retired `build/sailfin/.test_runner_active` entirely.
> The marker was intra-process state masquerading as cross-process IPC — the
> test orchestrator (`handle_test_command`) calls the LLVM lowering pipeline
> via direct in-process function calls, never via a spawned child compiler.
> The 10+ `fs.exists` probes on per-statement / per-function lowering hot
> paths now read process-local booleans in `compiler/src/test_runner_state.sfn`
> instead. See the **Test-runner state migration (issue #311)** section below
> for the full census of replaced sites.

### Compiler debug toggles — env-var migration (issue #308)

The flag-file pattern raced when the parent compiler spawned a child compiler to emit a runtime sfn-source at link time: the child inherited the parent's cwd and silently picked up parent-written flag files. As of issue #308, the user-facing debug toggles are env vars; the file probes still work for one release as a back-compat shim and will be removed in the release after.

| Env var (preferred)               | Legacy file probe (back-compat one release)   | Effect                                                                |
| --------------------------------- | --------------------------------------------- | --------------------------------------------------------------------- |
| `SAILFIN_TRACE_EMIT`              | `build/sailfin/.trace_emit`                   | Compiler stderr trace inside emit pipeline                            |
| `SAILFIN_SKIP_TYPECHECK`          | `build/sailfin/.skip_typecheck`               | Skip typecheck before LLVM emit (debug shortcut, NOT for production)  |
| `SAILFIN_TRACE_TEST_RUNNER`       | `build/sailfin/.trace_test_runner`            | Test runner stderr trace                                              |
| `SAILFIN_DUMP_TEST_SOURCES`       | `build/sailfin/.dump_test_sources`            | Dump per-test source bundles to scratch dir                           |
| `SAILFIN_DISABLE_RUNTIME_SFN_SOURCES` | (no file probe — new flag)                | Skip the link-time runtime-sfn-source emit loop entirely (rollback)   |

A toggle is **on** when the env var is set to a value other than `""`, `"0"`, or `"false"`.

The internal compiler-diagnostic probes (`build/sailfin/.phase_functions_diagnostics`, `.phase_types_diagnostics`, `.skip_module_globals`, `.skip_test_inlining`, `.trace_argv`, `.trace_call_lowering`, `.trace_lowering`) were not user-facing and were deferred from issue #308. They have since been retired — `.phase_*_diagnostics` and `.skip_test_inlining` were already gone (replaced with in-memory diagnostics or removed entirely) when #312 audited the inventory; the four remaining hot- and cold-path probes (`.trace_lowering`, `.trace_call_lowering`, `.skip_module_globals`, `.trace_argv`) were migrated to env vars by issue #312. See the **Internal compiler-diagnostic toggle migration (issue #312)** section below.

### Test-runner state migration (issue #311)

Issue #308 explicitly deferred the `.test_runner_active` marker and the six paired `.trace_test_runner` reads in LLVM lowering on the assumption that they were cross-process IPC needing an env-var plus per-process cache. Issue #311's design pass found the assumption was wrong: the marker is **intra-process state**. The producer (`compiler/src/cli_commands.sfn:handle_test_command`) and every consumer (the LLVM lowering pipeline) run in the **same Sailfin process** — `compile_tests_to_llvm_file_with_module_imports` is called via direct in-process function call, and `process.run([exe_path])` runs the *compiled test binary*, not a nested `sfn` invocation. Round-tripping that state through the filesystem cost one `fs.exists` syscall per probe per statement on the lowering hot paths.

**Replacement:** `compiler/src/test_runner_state.sfn` exports four functions backed by two module-level `let mut` booleans:

| Symbol                          | Replaces                                                                  |
| ------------------------------- | ------------------------------------------------------------------------- |
| `enter_test_runner_mode(trace)` | `_write_text_cmd("build/sailfin/.test_runner_active", "")` at orchestrator entry |
| `exit_test_runner_mode()`       | `fs.deleteFile("build/sailfin/.test_runner_active")` at the 6 cleanup paths      |
| `test_runner_active() -> boolean` | `fs.exists("build/sailfin/.test_runner_active")` at 2 lowering sites             |
| `test_runner_trace() -> boolean`  | The paired `if fs.exists(.trace_test_runner) { if fs.exists(.test_runner_active) }` pattern at 6 lowering sites |

**Sites migrated** (10 reads + 1 writer + 6 cleanup paths — no-tests, staging-failure, compile-failure, link-failure, run-failure, success):

| File                                                               | Probe count | Notes                                                |
| ------------------------------------------------------------------ | ----------- | ---------------------------------------------------- |
| `compiler/src/cli_commands.sfn`                                    |  7          | Writer (`enter_test_runner_mode`) + 6 cleanup paths  |
| `compiler/src/main.sfn`                                            |  1          | `compile_tests_to_llvm_file_with_module_imports`     |
| `compiler/src/llvm/effects.sfn`                                    |  1          | `propagate_function_effects` trace gate              |
| `compiler/src/llvm/imports.sfn`                                    |  1          | `collect_imported_module_context_for_module` trace   |
| `compiler/src/llvm/expression_lowering/native/statement.sfn`       |  1          | `lower_return_instruction` (per-`return`)            |
| `compiler/src/llvm/lowering/emission.sfn`                          |  1          | `emit_llvm_function` (per-function)                  |
| `compiler/src/llvm/lowering/instructions.sfn`                      |  1          | `lower_instruction_range` (per-block)                |
| `compiler/src/llvm/lowering/lowering_core.sfn`                     |  3          | `is_test_module` gate (behavior-changing) + trace + timing |

The writer side did **not** need a `setenv` extern or `sh -c` wrapper: in-process state has no producer/consumer fork. No back-compat shim was needed either — the marker file was never user-facing; nothing outside the compiler ever wrote or read it.

**Probe cost.** Each probe is now a single `load i1` from a global, no syscall. The `is_test_module` gate (the only behavior-changing read) is hit once per module; the trace gates short-circuit on `_active` so the `_trace` load is skipped when the runner isn't engaged.

### Internal compiler-diagnostic toggle migration (issue #312)

The trailing follow-up to #308 + #311. Closes the file-IPC removal campaign: after this migration, `grep -nE 'fs.exists\("build/sailfin/\.(phase|skip|trace|dump)_' compiler/src/` returns zero matches outside the new module's header comment.

`.test_runner_active` (#311) was intra-process state and got module-local booleans with explicit `enter/exit` lifecycle. The four flags retired by #312 are different: they're env-var-style debug knobs that the user sets once before invoking the compiler. The orchestrator never toggles them mid-run, but they ARE inherited by spawned children (the runtime-sfn-source emit loop, parallel per-module emit), and `_env_flag` reads are popen-shaped — which would be ~1ms per probe on the lowering hot paths if read naively.

**Replacement:** `compiler/src/llvm/lowering_debug_state.sfn` exports three lazy-init cached probes backed by sentinel-encoded `let mut number` caches (`-1` = uninit, `0` = false, `1` = true). First call performs `_env_flag(...) || _legacy_flag_file(...)`; subsequent calls return the cached value without a syscall.

| Env var (preferred)               | Legacy file probe (back-compat one release)   | Effect                                                           |
| --------------------------------- | --------------------------------------------- | ---------------------------------------------------------------- |
| `SAILFIN_TRACE_LOWERING`          | `build/sailfin/.trace_lowering`               | Stderr trace inside LLVM lowering (per-statement / per-function) |
| `SAILFIN_TRACE_CALL_LOWERING`     | `build/sailfin/.trace_call_lowering`          | Stderr trace inside the call-lowering / enum-literal path       |
| `SAILFIN_SKIP_MODULE_GLOBALS`     | `build/sailfin/.skip_module_globals`          | Skip module-globals emission (debug shortcut for triage)        |
| `SAILFIN_TRACE_ARGV`              | `build/sailfin/.trace_argv`                   | Print parsed CLI argv at compiler entry                         |

The first three are read inside the LLVM lowering pipeline and use the cached helper. `SAILFIN_TRACE_ARGV` is read once at `sailfin_cli_main` entry (cold path) and uses `_env_flag` directly without a cache.

**Sites migrated** (15 reads — 11 hot + 4 cold):

| File                                                                  | Probe count | Flag                       |
| --------------------------------------------------------------------- | ----------: | -------------------------- |
| `compiler/src/cli_main.sfn`                                           |  1          | `.trace_argv` (cold)       |
| `compiler/src/llvm/lowering/lowering_core.sfn`                        |  3          | trace + call-trace + skip  |
| `compiler/src/llvm/lowering/instructions.sfn`                         |  1          | `.trace_lowering`          |
| `compiler/src/llvm/lowering/instructions_let.sfn`                     |  1          | `.trace_lowering`          |
| `compiler/src/llvm/lowering/instructions_loops.sfn`                   |  1          | `.trace_lowering`          |
| `compiler/src/llvm/lowering/emission.sfn`                             |  1          | `.trace_lowering`          |
| `compiler/src/llvm/lowering/lowering_helpers_mangling.sfn`            |  1          | `.trace_lowering`          |
| `compiler/src/llvm/expression_lowering/native/core.sfn`               |  1          | `.trace_lowering`          |
| `compiler/src/llvm/expression_lowering/native/core_operands.sfn`      |  1          | `.trace_lowering`          |
| `compiler/src/llvm/expression_lowering/native/core_call_emission.sfn` |  1          | `.trace_lowering`          |
| `compiler/src/llvm/expression_lowering/native/core_call_lowering.sfn` |  1          | `.trace_call_lowering`     |
| `compiler/src/llvm/expression_lowering/native/statement.sfn`          |  2          | `.trace_lowering` ×2       |

**Probe cost.** Lazy-init: one popen per cache on the first probe; every subsequent read is a single `load i64` + compare. For a 138-module self-host with all three lowering flags off, the total cost is 3 popens (one per flag at first probe per process), versus the pre-migration cost of 13 hot-path × N statements × M functions × `fs.exists` syscalls.

**Back-compat.** `_legacy_flag_file` continues to honour `touch build/sailfin/.X` for one release. Drop the legacy fallback in the release after #312 ships. Tracked as the trailing item in the file-IPC removal campaign (#197 → #200 → #201 → #217 → #284 → #308 → #311 → #312).

### Pre-0.5.9 census (kept for the historical record)

| Date       | `fs.*` calls          | Dotfile refs | Active data-flow channels |
| ---------- | --------------------- | -----------: | ------------------------: |
| April 11   | 667 across 42 files   | 487          | 12+                       |
| April 19   | 489 across 37 files   | 228          | 6                         |
| **April 24 (0.5.9)** | **212 across 24 files** | **48**     | **0**                     |
