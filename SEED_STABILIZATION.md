# Seed Stabilization Guide

This document describes the strategy and work plan for producing a self-sufficient Sailfin compiler seed that can build itself without any post-processing fixups.

## Current State

- **Pinned seed:** v0.1.1 (`sfn` installed at `~/.local/bin/sfn`)
- **Build driver:** `scripts/selfhost_native.py` (Python, with ~69 IR fixup passes)
- **Goal driver:** `scripts/build.sh` (shell, zero fixups, zero post-processing)
- **Graduation gate:** `make check` — builds seedcheck with `build.sh`, validates it runs hello-world and passes the test suite

### Architecture

The build pipeline has two stages:

1. **Seed + Python driver** → first-pass binary (`build/native/sailfin`)
   - The v0.1.1 seed has known bugs (cross-module types, SSA dupes, etc.)
   - `selfhost_native.py` compensates with fixup passes — **this is acceptable**
   - Fixups here are OK because they help the broken seed produce a working binary

2. **First-pass binary + `build.sh`** → seedcheck binary
   - `build.sh` has **zero fixups, zero post-processing, zero Python**
   - If `build.sh` fails, the first-pass binary has a bug
   - Fix bugs in `compiler/src/*.sfn` so the first-pass binary emits correct IR
   - If the seed can't compile the fix, add a compensating fixup to `selfhost_native.py`

**Key principle:** The Python driver fixups are technical debt from the seed. The goal is to improve the compiler source so each new seed needs fewer fixups, eventually reaching zero. `build.sh` must always stay clean.

## Strategy: Iterative Seed Promotion

Do **not** try to fix all 69 fixups at once. Instead:

1. **Fix one or a few related bugs** in `compiler/src/*.sfn`
2. **Disable the corresponding fixup(s)** in `selfhost_native.py` and rebuild with `make rebuild` (uses Python driver)
3. **If the build still succeeds**, the fixup is dead — delete it
4. **If the build fails**, the compiler fix wasn't complete — iterate
5. **Cut a new seed** once a meaningful batch of fixups (5-10) are removed and the build is stable
6. **Repeat from the new seed** until `make check` passes

### Cutting a New Seed

When you've removed a batch of fixups and the build is stable:

```bash
# Build from current seed with remaining fixups
make rebuild

# Verify the binary works
build/native/sailfin version
build/native/sailfin run examples/basics/hello-world.sfn

# Install as the new seed
make install  # installs to ~/.local/bin/sfn

# Tag for reference (optional but recommended)
# e.g., v0.1.2-alpha.1
```

Then update `SEED_VERSION` if using `make fetch-seed`, or just use the locally installed `sfn`.

### When to Cut a Seed vs. Keep Going

- **Cut a seed** when: you've removed 5+ fixups, the build is stable, and you want a checkpoint
- **Keep going** when: you're in the middle of a related cluster and removing one fixup naturally leads to the next
- **Don't cut** if: the build requires retries or is flaky — fix the flakiness first

## Makefile Targets

| Target | Driver | Purpose |
|--------|--------|---------|
| `make compile` | `BUILD_DRIVER` (default: `py`) | Build compiler from seed |
| `make rebuild` | `BUILD_DRIVER` (default: `py`) | Force rebuild from seed |
| `make rebuild-py` | Python (fixups) | Explicit Python driver |
| `make rebuild-sh` | Shell (no fixups) | Explicit shell driver |
| `make check` | Python for compile, **always shell** for seedcheck | Graduation gate |
| `make smoke` | `BUILD_DRIVER` | Quick build + hello-world |

To switch the default driver once the seed is clean:
```bash
# In Makefile, change:
BUILD_DRIVER ?= py
# to:
BUILD_DRIVER ?= sh
```

## Fixup Catalog

The fixups in `selfhost_native.py` cluster into **5 root cause categories**. Fix the root causes in the compiler source, and whole groups of fixups become unnecessary.

### Category 1: Double-Encoded Pointers (~12 fixups)

**Root cause:** The seed compiler encodes pointer values as `double` (via `ptrtoint` + `sitofp`), then tries to recover them later. This is fundamentally broken — floating-point has insufficient precision for 64-bit pointers and the conversion chain produces invalid IR.

**Compiler source:** `compiler/src/llvm/lowering/` — likely in how `LocalBinding` values of pointer type are materialized.

**Fixups in this category:**
- `_fix_string_concat_as_gep` — replaces ptrtoint→sitofp→round→fptosi→GEP chains with direct string_concat calls
- `_fix_null_check_on_double_encoded_ptr` — fixes null checks via number_to_string(0.0)
- `_fix_null_args_from_double_encoded_pointers` — replaces i8* null with actual pointer values
- `_fix_double_deref_via_inttoptr` — removes null-pointer derefs from double→ptr conversion
- `_fix_mangled_push_calls` — fixes push calls with double-typed pointer args
- `_fix_number_to_string_of_ptr` — fixes double-encoded ptrs passed to number_to_string
- `_fix_bare_zero_lines` — removes stray `0` lines from broken materialization
- `_fix_append_string_writeback` — fixes missing writeback of double-encoded string ptrs
- `_fix_string_double_shadow` — creates shadow locals for double-encoded string pointers
- `_fix_double_encoded_pointer_calls` — fixes calls with double-encoded pointer args
- `_fix_srem_on_pointers` — fixes arithmetic on pointer operands (type confusion)
- `_fix_double_pointer_mismatch` — fixes i8** vs i8* pointer level mismatches

**How to fix:** The compiler must emit proper pointer operations (`bitcast`, `inttoptr`/`ptrtoint` only when semantically correct) instead of encoding pointers through floating-point. This is likely the single highest-impact fix.

### Category 2: Cross-Module Type/ABI Mismatches (~15 fixups)

**Root cause:** When the seed compiler compiles module A that calls a function defined in module B, it cannot always resolve B's type signatures. It falls back to incorrect types (often `double` or `i8*`), creating ABI mismatches at link time.

**Compiler source:** `compiler/src/emit_native.sfn` (cross-module import resolution), `compiler/src/llvm/lowering/entrypoints.sfn` (function signature emission)

**Fixups in this category:**
- `_fix_cross_module_return_types` — fixes mismatched return types between declare/define
- `_fix_cross_module_param_types` — fixes mismatched parameter types across modules
- `_fix_cross_module_abi_for_instructions` — fixes ABI for instructions module calls
- `_fix_byvalue_struct_call_mismatches` — fixes i8* passed for struct-by-value params
- `_fix_native_function_param_for_emission` — fixes NativeFunction param types
- `_fix_lower_instruction_range_return_type` — fixes BlockLoweringResult return type
- `_fix_char_at_return_type` — fixes char_at return from double to i8*
- `_fix_statement_struct_params` — fixes Statement struct parameter passing
- `_fix_native_ir_return_types` — fixes native IR function return types
- `_fix_struct_byval_null_params` — fixes struct-by-value params passed as null
- `_fix_store_type_mismatches` — fixes store instruction type mismatches
- `_fix_mangled_method_calls` — fixes mangled names and param types
- `_fix_empty_params_from_declares` — recovers missing params from declares
- `_fix_truncated_symbol_names` — fixes dropped first character in symbol names
- `_patch_opaque_named_types` — resolves opaque types from cross-module context

**How to fix:** Improve the compiler's LLVM rendering pass (`compiler/src/llvm/rendering.sfn`) to emit concrete type definitions for imported structs (not just opaque stubs) and `declare` statements for cross-module function calls. The compiler already loads imported type info via layout manifests and native texts — it just needs to use that info during rendering instead of emitting `%Type = type opaque`. This is a compiler source fix, not a build script fix. `build.sh` must remain free of any post-processing.

### Category 3: Loop / Control Flow Bugs (~6 fixups)

**Root cause:** The LLVM lowering of `.loop` / `.if` / `.break` control flow produces broken loop headers — loops unconditionally enter the body with no exit condition. Also, continue targets point to wrong blocks.

**Compiler source:** `compiler/src/llvm/lowering/instructions.sfn` — the `.loop`, `.if`, `.break`, `.continue` instruction handlers

**Fixups in this category:**
- `_fix_degenerate_loops` — adds exit conditions to infinite loops
- `_fix_unconditional_loop_headers` — adds branch conditions to loop headers
- `_fix_type_context_infinite_loops` — breaks infinite loops in type context code
- `_fix_misplaced_continue_targets` — fixes wrong continue block targets
- `_fix_undefined_branch_conditions` — injects stubs for undefined branch condition SSA values
- `_fix_null_struct_loads` — replaces loads from null pointers with zeroinitializer

**How to fix:** The loop lowering must emit a proper conditional branch (`br i1 %cond, label %body, label %exit`) at the loop header, not an unconditional `br label %body`. The condition SSA value must be computed and available before the branch.

### Category 4: Phi Node / SSA Violations (~8 fixups)

**Root cause:** The seed emits phi nodes that violate LLVM's structural rules: wrong placement, wrong types, references to non-predecessor blocks, duplicate SSA names, or local names used as types.

**Compiler source:** `compiler/src/llvm/lowering/` — phi emission logic, SSA name generation

**Fixups in this category:**
- `_reorder_phi_nodes_to_block_start` — moves phi nodes before other instructions
- `_fix_broken_phi_nodes` — removes phi nodes with local names as types
- `_fix_phi_predecessor_mismatches` — fixes phi nodes with wrong block labels
- `_fix_phi_type_mismatches` — fixes phi value/type disagreements
- `_fix_duplicate_ssa_names` — renames duplicate %tN variables
- `_fix_duplicate_param_names` — renames duplicate parameter names
- `_fix_missing_parameter_stores` — injects missing alloca/store for params
- `_rewrite_phi_store_to_load` — simplifies unnecessary store/load wrapping of phi results

**How to fix:** Ensure phi nodes are emitted at block entry, with correct predecessor labels and consistent types. The SSA name counter must be per-function and strictly monotonic.

### Category 5: Missing/Duplicate Definitions (~12 fixups)

**Root cause:** The seed either fails to emit required definitions (functions, types, globals, labels) or emits them multiple times.

**Compiler source:** `compiler/src/llvm/lowering/entrypoints.sfn` (definition emission), `compiler/src/emit_native.sfn` (module-level emission)

**Fixups in this category:**
- `_fix_declare_define_conflicts` — removes conflicting declare when define exists
- `_fix_duplicate_globals` — removes duplicate global definitions
- `_dedup_type_definitions` — removes duplicate type definitions
- `_remove_degenerate_empty_functions` — removes trivial stubs
- `_fix_opaque_types_in_gep` — replaces opaque types with sized placeholders
- `_fix_struct_type_mismatches` — fixes struct definitions that disagree with usage
- `_inject_missing_block_labels` — injects labels referenced by branches
- `_inject_missing_function_declarations` — injects declares for called-but-undeclared functions
- `_inject_missing_named_type_stubs` — injects opaque stubs for referenced types
- `_inject_missing_runtime_field_constants` — injects runtime field string constants
- `_inject_clamp_definition` — injects dropped clamp function body
- `_fix_struct_construction_helpers` — fixes incomplete struct construction IR

### Category 6: Linker / Visibility (~6 fixups)

**Root cause:** Symbol visibility and deduplication issues when linking multiple modules.

**Compiler source:** `compiler/src/llvm/lowering/entrypoints.sfn` (linkage attributes), `compiler/src/emit_native.sfn` (module boundaries)

**Fixups in this category:**
- `_dedupe_public_definitions_across_modules` — internalizes duplicate definitions
- `_internalize_symbols_in_nonruntime_modules` — reduces namespace pollution
- `_internalize_duplicate_symbol_for_llvm_link` — resolves llvm-link conflicts
- `_internalize_non_required_definitions` — internalizes non-exported symbols
- `_promote_symbol_definition_visibility` — upgrades private→public linkage
- `_promote_local_declares_to_stubs` — converts declares to stub definitions

### Other / Shims (~4 fixups)

- `_fix_invalid_null_stores` — replaces `null` with `zeroinitializer` for non-pointer types
- `_mark_unaligned_enum_payload_accesses` — adds `align 1` to enum payload accesses
- `_ensure_cli_driver_symbol` / `_ensure_string_char_at_alias` / `_ensure_text_char_at_alias` — cross-module symbol aliasing
- `_rewrite_import_alias_symbols` — rewrites import alias references
- `_inject_declare_for_symbol` — injects declares for specific symbols
- `_inject_debug_enum_payload_probes` — diagnostic instrumentation (can be removed)
- `_fix_native_function_param_for_entrypoints` — no-op placeholder (already fixed)

## Recommended Attack Order

Fix categories in this order for maximum impact with least risk:

1. **Category 4 (Phi/SSA)** — Structural violations that are well-defined and testable. Fixing these first makes the remaining IR easier to validate.

2. **Category 3 (Loops/Control Flow)** — Known critical bug (see CLAUDE.md). Fixing loop headers unblocks many code paths.

3. **Category 1 (Double-Encoded Pointers)** — Highest fixup count. Eliminating the double-encoding pattern removes ~12 fixups at once.

4. **Category 5 (Missing/Duplicate Definitions)** — Many are symptoms of categories 1-3. Some may disappear once the earlier fixes land.

5. **Category 2 (Cross-Module ABI)** — Requires import-context improvements. Most complex, but many fixups here may become unnecessary after 1-3 are fixed.

6. **Category 6 (Linker/Visibility)** — Mostly cosmetic at link time. Low priority.

## Getting Started: Identifying What to Work On

Before diving into compiler fixes, you need to know which fixups actually fire and which are already dead. Many fixups become no-ops as earlier fixes land — removing these is free progress.

### Step 1: Get the current fixup count

```bash
grep -c 'def _fix\|def _inject\|def _rewrite\|def _promote\|def _ensure\|def _dedup\|def _mark\|def _patch\|def _remove' scripts/selfhost_native.py
```

### Step 2: Do a build and capture which fixups actually fire

```bash
make clean-build && make rebuild 2>&1 | tee /tmp/rebuild_output.txt
```

### Step 3: See which fixup types produced output (i.e., actually fired)

```bash
# Show all fixup log lines (excludes module progress, timing, etc.)
grep '\[selfhost\]' /tmp/rebuild_output.txt | grep -E 'fixed|patched|injected|inserted' \
  | grep -v 'malloc\|calloc\|append_string\|unconditional loop' \
  | sort -u

# Show totals for high-volume fixups
grep '\[selfhost\].*total' /tmp/rebuild_output.txt
```

Fixups that produce **zero** log lines are no-ops — they can be disabled, verified with a rebuild, and deleted. This is the easiest way to reduce the fixup count.

### Step 4: Find zero-fire fixups

The pipeline only logs when a fixup makes changes (`if changes > 0`). Cross-reference the fixup call sites in the pipeline (search for `candidate, *_changes = _fix_` and `ll_texts[idx], *_changes = _fix_`) against the build output. Any fixup function called in the pipeline but absent from the output fires zero times.

### Step 5: Pick a fixup to work on

Follow the recommended attack order below. For **zero-fire fixups**, just disable the call, rebuild, run tests, delete the function, and commit. For **active fixups** (those that fire >0 times), you need to trace the root cause to `compiler/src/*.sfn` and fix it there.

### Locating fixup call sites in the pipeline

The pipeline has two main sections where fixups are called:

1. **Per-module pipeline** (~line 11700-12400): processes each module individually during compilation. Search for `candidate, ` assignments.
2. **Post-link pipeline** (~line 12700-13200): processes all modules after individual compilation. Search for `ll_texts[idx], ` assignments.

```bash
# Find all active fixup calls (not commented out)
grep -n 'candidate.*= _fix_\|candidate.*= _inject_\|ll_texts\[idx\].*= _fix_\|ll_texts\[idx\].*= _inject_' scripts/selfhost_native.py | grep -v '^\s*#'
```

## How to Test a Fix

```bash
# 1. Make the fix in compiler/src/*.sfn

# 2. Rebuild with Python driver (uses fixups for everything else)
make clean-build && make rebuild

# 3. Disable the specific fixup in selfhost_native.py:
#    - Comment out or skip the fixup call in the pipeline
#    - Rebuild again
make clean-build && make rebuild

# 4. If build succeeds, run the test suite
make test

# 5. If tests pass, delete the fixup function and commit

# 6. When ready to test full graduation:
make check
```

**Important:** Always `make clean-build` before `make rebuild` when testing fixup changes. The build caches intermediate `.ll` files and won't re-run fixups on cached modules.

## Tracking Progress

Track the fixup count as the primary metric:

```bash
# Count active fixup functions
grep -c 'def _fix\|def _inject\|def _rewrite\|def _promote\|def _ensure\|def _dedup\|def _mark\|def _patch\|def _remove' scripts/selfhost_native.py
```

When this reaches 0 (or only diagnostic/optional passes remain), `make check` should pass and the Python driver can be retired.
