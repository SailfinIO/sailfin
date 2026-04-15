You are a compiler engineer improving the Sailfin compiler's code organization.
The compiler lives in compiler/src/ and is a self-hosting compiler written in
Sailfin (.sfn files) that targets LLVM. It must always be able to compile
itself — every change you make must preserve this invariant.

## Your mission

Pick ONE focused improvement from the priority list below. Implement it, verify
with `make compile && make test`, commit, and push. Do not bundle multiple
improvements — each run should be a single, reviewable PR.

## Priority list (pick the highest-priority item that hasn't been done yet)

### 1. Extract shared string/collection helpers into string_utils.sfn

The same utility functions are copy-pasted across 4-8 files each:

| Function | Duplicated in |
|---|---|
| `trim_text()` | emit_native_state, emitter_sailfin_utils, native_ir_utils_text, typecheck_types, llvm/utils, parser/utils |
| `ends_with()` | cli_main, cli_commands_utils, emit_native_state |
| `starts_with()` | native_ir_utils_text, typecheck_types |
| `contains_string()` | emit_native_state, typecheck_types |
| `contains_effect()` | decorator_semantics, effect_checker |
| `index_of()` | native_ir_utils_text, string_utils, llvm/utils |
| `number_to_string()` | main, emit_native_state, llvm/utils |
| `is_symbol_char()` / `sanitize_symbol()` | string_utils, llvm/utils |
| `string_array_contains()` | llvm/utils, parser/utils |

`compiler/src/string_utils.sfn` already exists (153 lines) but is barely used.
Consolidate the canonical implementations there, then replace duplicates in
other files with imports. Work one function at a time — don't do all of them in
a single commit if it touches too many files.

**Known gotcha:** `llvm/utils.sfn` has a comment saying functions were
"duplicated from string_utils to avoid cross-module function call issues in
Stage2." This was a historical compiler bug. Test whether importing from
string_utils works now by making the change, running `make compile`, and
verifying the resulting binary works (`build/native/sailfin version`). If it
still breaks, leave that file alone and consolidate the others first.

### 2. Deduplicate TextBuilder

`TextBuilder` struct + `builder_to_string()` is defined identically in both
`emit_native_state.sfn` and `emitter_sailfin_utils.sfn`. Extract it into a
shared module (e.g., `text_builder.sfn` or add to `string_utils.sfn`) and have
both emitters import it.

### 3. Move native_ir_* files into a native_ir/ subdirectory

There are 8 `native_ir_*.sfn` files (4,396 lines total) sitting flat at the top
level. They form a clear logical module. Move them into `compiler/src/native_ir/`
with a `mod.sfn` re-exporting the public API. Update all import paths.

### 4. Move emit_native_* files into an emit_native/ subdirectory

Same pattern: 4 `emit_native*.sfn` files (2,472 lines) that are a logical unit.
Move to `compiler/src/emit_native/` with a `mod.sfn`.

### 5. Move typecheck_* files into a typecheck/ subdirectory

`typecheck.sfn` + `typecheck_types.sfn` (1,095 lines) — move to
`compiler/src/typecheck/` with a `mod.sfn`.

### 6. Move cli_* files into a cli/ subdirectory

`cli_main.sfn` + `cli_commands.sfn` + `cli_commands_utils.sfn` (1,937 lines) —
move to `compiler/src/cli/` with a `mod.sfn`.

### 7. Consolidate tiny files in llvm/expression_lowering/native/

Several `core_*.sfn` files are under 60 lines and could be merged into related
larger files:
- `core_match_helpers.sfn` (12 lines) — merge into `core.sfn` or `core_parse.sfn`
- `core_bindings.sfn` (33 lines) — merge into `core.sfn`
- `core_borrow_lowering.sfn` (53 lines) — merge into `core_ownership.sfn`
- `core_addressing.sfn` (57 lines) — merge into `core.sfn`

Each merge reduces the module count that build.sh must compile (currently 121).

### 8. Deduplicate path helpers (_dirname, _path_join)

`_dirname()` and `_path_join()` are implemented identically in `cli_main.sfn`
and `cli_commands_utils.sfn` (with `_cmd` suffix). Extract into a shared path
utilities module.

## Rules

1. **Self-hosting invariant**: After every change, run `make compile` to verify
   the compiler can still build itself. If it breaks, revert and try a smaller
   step.

2. **One logical change per run**: Pick ONE item from the list. If a directory
   move requires updating 20+ import paths, that's fine — it's still one
   logical change. But don't also deduplicate string helpers in the same PR.

3. **Check for prior work**: Before starting, check if the improvement was
   already done in a recent commit. Run `git log --oneline -20` and look for
   related changes. If it's already done, move to the next item on the list.

4. **Test coverage**: If you extract a shared module, ensure existing tests
   still pass (`make test-unit`). Add a test if the extracted module doesn't
   have one.

5. **Import compatibility**: When moving functions from file A to a shared
   module, keep a re-export in file A if other modules import from there. You
   can remove re-exports in a follow-up once all callers are updated.

6. **Minimal diff**: Don't reformat, add comments to, or refactor code you
   didn't move. Move code verbatim, then fix imports.

7. **Memory safety**: Always use `ulimit -v 8388608` before running the
   compiler. Wrap single-file invocations with `timeout 60`.

## How to verify

```bash
ulimit -v 8388608
make compile          # Must succeed — self-hosting invariant
make test-unit        # Must pass — no regressions
```

## Commit format

```
refactor(<scope>): <what you did>

<1-2 sentence explanation of why>

Files moved/changed:
- list of files
```

Push to a branch named `claude/refactor-compiler-<item>-<random>` and open a PR.
