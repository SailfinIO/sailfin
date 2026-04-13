# Build Performance: Root Cause Analysis & Fix Plan

**Date:** 2026-04-11
**Context:** Self-hosting the compiler from the 0.5.0-alpha.22 seed via `build.sh` takes ~60-90 minutes for 121 modules single-threaded. Individual modules consume 1-2GB RAM and take 4-7 minutes each. Parallel builds (`--jobs`) are not viable yet due to shared IPC state on the filesystem.

---

## Symptom Summary

| Metric | Current | Target |
|--------|---------|--------|
| Per-module compile time | 4-7 min (heavy), 30s-2min (light) | < 30s per module |
| Per-module peak RAM | 1-2 GB | < 256 MB |
| Full build (121 modules, 1 job) | 60-90 min | < 15 min |
| Parallel builds (`--jobs N`) | Broken (shared IPC files) | Working |
| `fs.*` calls per module | ~8,000+ | < 50 (only final output) |

---

## Root Cause 1: Filesystem-as-IPC (Primary Bottleneck)

The compiler uses the filesystem as an inter-function communication channel. Instead of returning structs from functions, it writes each field to a separate temp file under `build/sailfin/`, then the caller reads them back.

- **667 total `fs.*` calls** across 42 source files
- **487 references** to `build/sailfin/.xxx` temp file paths
- Per-instruction lowering involves 6-10 file writes + reads per function call
- Per-local-binding serialization: 4-6 files written, then read back, per binding
- **Why it exists:** The v0.1.1 seed had a struct-return ABI bug. The workaround was to serialize each field to a file and read it back.
- **Why this blocks parallel builds:** All modules write to the same `build/sailfin/` directory, so parallel compilation causes file conflicts.

### Hotspots

| File | `fs.*` Calls |
|------|--------------|
| `instructions_dispatch.sfn` | 69 |
| `instructions_helpers.sfn` | 64 |
| `instructions.sfn` | 57 |
| `statement.sfn` | 50 |
| `instructions_let.sfn` | 40 |
| `emission.sfn` | 36 |
| `statement_assignment.sfn` | 36 |
| `core_call_resolution.sfn` | 30 |

---

## Root Cause 2: O(n^2) Array Accumulation

`extend_string_lines()` in `lowering_io.sfn` allocates a new array and copies both inputs element-by-element every call. Used 27 times in the hot path. An `append_string_lines` that reuses the input array already exists but is underused.

For 10,000 LLVM IR lines accumulated across 50+ extend calls, this produces ~125,000 total line copies and hundreds of MB of garbage array memory.

---

## Root Cause 3: No Import Artifact Caching

In `imports.sfn`, the BFS import resolver loads and re-parses `.sfn-asm` and `.layout-manifest` files from disk for every dependency with no memoization. Popular base modules get parsed 10-50 times across a full build.

---

## Root Cause 4: Light Recovery Parser Overhead

`recover_native_functions_light` in `lowering_recovery.sfn` re-scans every line of the `.sfn-asm` text with 20+ `starts_with` checks per line. Exists because the v0.1.1 seed couldn't handle typed instruction variants.

---

## Fix Plan

### Phase 1: Eliminate IPC Files

**Priority:** Highest — **Expected:** 50-70% time reduction, unblocks parallel builds

Replace filesystem IPC with direct struct returns now that the seed's ABI works. Key targets:
- `_write_block_result_files` / read-back → direct `BlockLoweringResult` returns
- `write_bindings_to_files` / `write_locals_to_files` → direct array passing
- `.call_result_value` / `.call_result_type` → direct return values
- `serialize_context_functions` / `deserialize_context_functions` → direct struct passing
- Remove defensive serialize-call-check-recover cycles

### Phase 2: Fix Array Accumulation

**Priority:** High — **Expected:** 10-20% time, 40-60% memory

Replace `extend_string_lines` with `append_string_lines` in all 27 call sites. Verify no site depends on the original array being unmodified.

### Phase 3: Cache Import Artifacts

**Priority:** Medium — **Expected:** 10-15% time

Add a lookup cache to `collect_imported_module_context_for_module` to avoid re-parsing the same manifests.

### Phase 4: Eliminate Light Recovery Parser

**Priority:** Low — **Expected:** 5-10% time

Once the new seed reliably handles typed instruction variants, switch back to `parse_native_artifact_safe`.

### Completed: String Concat Allocation Reduction

**Status: Implemented** — The LLVM lowering now emits `sailfin_runtime_string_append`
(realloc-based in-place extend) instead of `sailfin_runtime_string_concat` (malloc+copy)
for intermediate results in chained `+` string concatenation. This eliminates 2 dead
intermediate allocations per 4-way concat and is estimated to reduce per-module peak
memory by 30-50% on string-heavy modules. The optimization is transparent to users —
no syntax or behavior changes.

Files changed: `compiler/src/llvm/expression_lowering/native/core_strings.sfn`,
`core_ops_lowering.sfn`, `compiler/src/llvm/lowering/lowering_core.sfn`,
`compiler/src/llvm/runtime_helpers.sfn`, `runtime/native/src/sailfin_runtime.c`,
`runtime/native/include/sailfin_runtime.h`.

This improvement is independent of Phases 1-4 and does not change the priority or
expected impact of those phases.

---

## Appendix: Full File I/O Census

Total: **667 `fs.*` calls across 42 files.** See analysis session for per-file breakdown.
