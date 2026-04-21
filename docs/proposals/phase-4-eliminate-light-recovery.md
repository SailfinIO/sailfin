# Phase 4: Eliminate `recover_native_functions_light` Primary Path

**Status:** Planned (April 21, 2026). Not yet implemented.
**Parent track:** `docs/build-performance.md` — Root Cause 4 / Phase 4.
**Predecessor PRs:** Tier 1A PR 1 (#204), Tier 1A PR 2+3 (this branch).
**Owner:** next session.

---

## 1. Call graph (confirmed)

**Primary paths into light recovery** (every module hits these):

- `compile_native_text_to_llvm_file` at `compiler/src/llvm/lowering/lowering_core.sfn:247-282` — the path used by `main.sfn:501` via `write_llvm_ir_from_native_text_file` for *every* non-test build. Calls `build_parse_result_from_text` (`:126-140`), which unconditionally runs all four `recover_*_light` routines, then *also* calls `recover_native_imports_light` a second time at `:258`.
- `lower_to_llvm_lines_with_parsed_context` at `lowering_core.sfn:284` — always calls `sanitize_lowering_inputs` (`lowering_phase_sanitize.sfn:50-88`), which, when `native_text_override_path.length > 0` (the normal case from `compile_native_text_to_llvm_file`), re-runs `recover_native_functions_light` + `recover_native_structs_light` + `recover_native_enums_light` and *replaces* `parse` wholesale when the reparse has ≥ the function count.
- Per-imported-module: `recover_native_enums_light` at `lowering_core.sfn:425` runs once per import text.

**Fallback paths** (only fire on empty/corrupt parse — keep for now):

- `sanitize_functions` at `:300`
- `recover_structs_if_corrupt` at `:383`
- `recover_functions_for_lowering` light fallbacks at `lowering_recovery.sfn:773, 838, 852`

**Test-only path:**

- `write_llvm_ir_for_tests_from_text` at `entrypoints_tests_writer.sfn:132` — also uses `build_parse_result_from_text`. Comment at `:124-131` explicitly states it depends on all instructions being emitted as tag-21 Expression because the seedcheck's `get_instruction_tag` cannot distinguish the typed variants.

## 2. Output-contract delta (structured vs. light)

| Field | `parse_native_artifact` | `recover_*_light` |
|-------|-------------------------|-------------------|
| `functions[i].instructions[j].tag` | Typed (0 Return, 1 Expression, 3 If, 4 Else, 5 EndIf, 8 Loop, …) | **All tag 21** except Return/If/Else/EndIf/Loop/EndLoop/For/EndFor/Break/Continue/Match/Case/EndMatch |
| Struct-method `.method` within `.struct` | Emitted nested in `NativeStruct.methods` | Flattened to top-level `NativeFunction` with name = `StructName` + methodName |
| Enum variants | Real variant names + payload fields | Same |
| `bindings` | Populated | Always `[]` |
| `interfaces` | Populated | Always `[]` |
| `diagnostics` | Populated | Always `[]` |

**Two fabricated contracts the pipeline relies on:**

1. **Flat struct-method flattening.** `recover_native_functions_light` flattens methods at parse time; the structured parser keeps them nested. `lowering_core.sfn:488` calls `flatten_struct_methods(module_structs)`, so this is already papered over on the non-test primary path via `lower_to_llvm` (`entrypoints.sfn:158`). The issue only bites `compile_native_text_to_llvm_file` and the test-writer (which skip that flatten call).

2. **Tag-21 instruction dispatch.** Per the `entrypoints_tests_writer.sfn:124-131` comment, the seedcheck's `get_instruction_tag` historically returned 21 for every typed variant. **Confirm before proceeding** — inspect `compiler/src/native_ir.sfn`'s `get_instruction_tag` and `compiler/src/llvm/lowering/instructions_*.sfn` dispatch against typed tags under seed 0.5.7. If it now dispatches typed tags correctly, Phase 4 can cover the test path (PR 2). If not, the test path stays on `build_parse_result_from_text` and Phase 4 only covers the non-test primary (PR 1 alone).

## 3. Scope

**In (PR 1):**
- Rework `compile_native_text_to_llvm_file` to call `parse_native_artifact` directly.
- Delete the `_rfns`/`_rsts`/`_rens` override-reparse block in `sanitize_lowering_inputs` (`lowering_phase_sanitize.sfn:58-83`).
- Replace per-import `recover_native_enums_light` at `lowering_core.sfn:425` with `parse_native_enums_for_import`.
- Collapse the duplicate `recover_native_imports_light` at `lowering_core.sfn:258` into reusing `parse.imports`.
- Clean up now-orphaned imports in `entrypoints.sfn` and `lowering_phase_sanitize.sfn`.

**Out (keep as defensive fallbacks):**
- `recover_functions_for_lowering` internal light calls — fire only when structured parse returned empty/inconsistent. Keep as belt-and-suspenders; delete in Phase 4b.
- `sanitize_functions:300` and `recover_structs_if_corrupt:383` — same argument.
- The `recover_*_light` function bodies themselves in `lowering_recovery.sfn` — still exported for the fallbacks. Delete in Phase 4b once counters confirm zero hits for a release cycle.
- `write_llvm_ir_for_tests_from_text` — still the gating question (Section 2 item 2). Stays on `build_parse_result_from_text` for PR 1.
- `build_parse_result_from_text` (`lowering_core.sfn:126-140`) and its four light-recovery imports — retained because the test writer still calls it. Deletion moves to PR 2 once the test-writer swap lands.

## 4. Sequencing

### PR 1 — Non-test primary path

**Branch:** `claude/phase-4-eliminate-light-recovery-primary`

**Step 1** — `lowering_phase_sanitize.sfn`:
- Lines `:58-83`: delete the override-reparse block and the length-swap. The structured `parse_in` is authoritative.
- Lines `:25-30`: drop `recover_native_functions_light`, `recover_native_imports_light`, `recover_native_structs_light`, `recover_native_enums_light`. Keep `recover_functions_for_lowering`.

**Step 2** — `lowering_core.sfn`:
- Lines `:247-282`: replace `build_parse_result_from_text(native_text)` with `parse_native_artifact(native_text)`; replace `recover_native_imports_light(native_text)` at `:258` with `parse.imports`.
- Lines `:126-140`: **Keep** `build_parse_result_from_text` — the test-writer (`entrypoints_tests_writer.sfn:132`) still depends on it. Add a comment pointing at PR 2's gating. Deletion moves to PR 2.
- Lines `:115-119`: **Keep** all four light-recovery imports — `build_parse_result_from_text` still calls them. Dropping moves to PR 2.
- Line `:425`: replace `recover_native_enums_light(native_text)` with `parse_native_enums_for_import(native_text)`. Add `parse_native_enums_for_import` to the `native_ir_api` import block.

**Step 3** — Fallback verification:
- Add transient `print.err` counters in `recover_functions_for_lowering`'s light fallback arms and in `sanitize_functions:300` / `recover_structs_if_corrupt:383`. Run `make compile && make check`. Expectation: counts are zero on the happy path. If any non-zero, investigate per-module before merging — there's a structured-parser bug to fix first. Remove counters before commit.

**Step 4** — `entrypoints.sfn` import cleanup:
- Lines `:142-147`: drop `recover_native_functions_light`, `recover_native_imports_light`, `recover_native_structs_light` (confirm via grep).

**Verification gate:**
- `make clean-build && make check`.
- `make bench` before/after; record delta in PR body (target: 5–10%).
- Determinism: 10× `make compile` on Linux, hash `build/native/sailfin` each time — all 10 must match.

### PR 2 — Test-writer path (conditional)

Only proceed if inspection of `native_ir.sfn:get_instruction_tag` confirms typed-tag dispatch works under seed 0.5.7, **and** the payload accessors (`get_instruction_text`, `get_instruction_condition`, etc. in `lowering_native_helpers.sfn:291-299`) correctly read typed-variant payload fields under the seedcheck (the second failure mode flagged by the test-writer comment block). Then:
- `entrypoints_tests_writer.sfn:132`: switch from `build_parse_result_from_text` to `parse_native_artifact`. Remove the `:76` import. Update the `:120-131` comment block.
- `lowering_core.sfn:126-140`: delete `build_parse_result_from_text` (now has zero callers).
- `lowering_core.sfn:115-119`: drop the four light-recovery imports (now orphaned).
- Add a test-harness determinism check covering a module with `if`/`loop`/`match`.

Otherwise, park PR 2 with a tracking comment and revisit after the next seed cut.

### PR 3 — Phase 4b (future)

Once fallback counters confirm zero hits for a full release cycle: delete `recover_native_functions_light`, `recover_native_imports_light`, `recover_native_structs_light`, `recover_native_enums_light` from `lowering_recovery.sfn`. Remove the fallback arms. Drops ~600 LOC.

## 5. Risks

- **macOS-arm64 determinism**: the override-reparse block in `lowering_phase_sanitize.sfn:58-83` was added when cross-module struct returns were unreliable. Seed 0.5.7 proved stable in PR #183/#186 sweeps, but arm64 has lagged on prior ABI flakes. **Mitigation**: gate PR 1 merge on a macOS-arm64 determinism run (20× `emit llvm` per-module, hash compare). If arm64 flakes, narrow PR 1 to Step 2 only (leave the override-reparse in `sanitize_lowering_inputs` intact), reclaiming ~half the win.

- **Struct-method shape mismatch in `compile_native_text_to_llvm_file`**: light parser flattens methods at parse; structured parser keeps them nested. `lower_to_llvm_lines_with_parsed_context` already calls `flatten_struct_methods` at `:488`, so flattening happens regardless. Step 2 changes `parse.functions` to no longer contain flattened methods. Net effect: methods appear once (via flatten) instead of twice. **Verify** by diffing a small module's pre/post IR; if method-mangled symbols double, there's already latent dedup and this change is a net fix.

- **Instruction-tag dispatch regression**: if any instruction lowerer still has a tag-21 fast path that implicitly handled cases the typed tags now route elsewhere, typed dispatch may surface a latent bug. **Mitigation**: Step 3's counter run will catch this.

- **`emit-native.tmp` disk race**: `compile_native_text_to_llvm_file:259` writes `emit-native.tmp` before calling `lower_to_llvm_lines_with_parsed_context`, and multiple fallback paths read it back. No change needed for PR 1, but note for Phase 5: when the compiler becomes long-lived, this temp file becomes a cross-invocation race and needs to move in-memory.

## 6. Verification commands

```
# Per-step during PR 1
make compile
make test-unit
make test-integration

# Pre-merge gate
make clean-build && make check

# Determinism (Linux)
for i in $(seq 1 10); do make rebuild >/dev/null 2>&1 && sha256sum build/native/sailfin; done | sort -u

# Determinism (macOS arm64, per-module — run from CI)
for i in $(seq 1 20); do \
  ulimit -v 8388608; \
  timeout 60 build/native/sailfin emit llvm compiler/src/llvm/lowering/lowering_core.sfn \
    -o /tmp/lc.$i.ll; \
  sha256sum /tmp/lc.$i.ll; \
done | sort -u | wc -l
# Expected: 1

# Perf delta
make bench > /tmp/bench.after
diff /tmp/bench.before /tmp/bench.after
```

## 7. Future interactions

- **Phase 5 (long-lived process)**: removing `emit-native.tmp` as a primary channel is a prerequisite. Phase 4 reduces its reader count from 5 to 2, shrinking Phase 5's in-memory-only transition.
- **Structured diagnostics (`--json`)**: the structured parser produces real `diagnostics` — once Phase 4 routes everything through it, those diagnostics become first-class, unblocking machine-readable diagnostic output without double-parse.
- **Runtime Phase 2 (typed containers)**: independent of Phase 4.

## 8. Files affected

**PR 1:**
- `compiler/src/llvm/lowering/lowering_core.sfn`
- `compiler/src/llvm/lowering/lowering_phase_sanitize.sfn`
- `compiler/src/llvm/lowering/entrypoints.sfn`

**PR 2 (conditional):**
- `compiler/src/llvm/lowering/entrypoints_tests_writer.sfn`

**Reference (read-only during planning):**
- `compiler/src/llvm/lowering/lowering_recovery.sfn`
- `compiler/src/native_ir_parser.sfn`
- `compiler/src/native_ir_api.sfn`
- `compiler/src/main.sfn` (caller of `write_llvm_ir_from_native_text_file`)

No changes in lexer, parser, AST, typecheck, effect checker, or `emit_native`.
