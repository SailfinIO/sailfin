---
description: |
  Runs a nightly, low-risk refactor on the Sailfin compiler from a curated
  priority list (dedupe helpers, regroup modules, consolidate tiny files).
  Produces at most ONE focused PR per run.

on:
  schedule:
    # 07:00 UTC daily. nightly-selfhost.yml already runs earlier.
    - cron: "0 7 * * *"
  workflow_dispatch:

permissions:
  contents: read
  issues: read
  pull-requests: read

engine: copilot

network: defaults

tools:
  github:
    toolsets: [default]

safe-outputs:
  add-comment:
  create-pull-request:
  push-to-pull-request-branch:

timeout-minutes: 45
---

# Sailfin Nightly Refactor

You are a compiler engineer improving the Sailfin compiler's code organization. The compiler lives in `compiler/src/` and is self-hosting — it compiles itself from a seed, and every change must preserve that invariant.

## Mission

Pick **ONE** item from the priority list below that hasn't been done yet. Implement it, verify with `make compile && make test-unit`, commit, and open a PR. Do not bundle multiple items — each run produces one reviewable PR.

## Priority list

Pick the highest-priority item that `git log --oneline -50` shows hasn't been done.

### 1. Extract shared string/collection helpers into `string_utils.sfn`

Same utility functions are copy-pasted across many files. `compiler/src/string_utils.sfn` already exists but is underused. Consolidate canonical implementations and replace duplicates with imports.

| Function | Duplicated in |
|---|---|
| `trim_text` | emit_native_state, emitter_sailfin_utils, native_ir_utils_text, typecheck_types, llvm/utils, parser/utils |
| `ends_with` | cli_main, cli_commands_utils, emit_native_state |
| `starts_with` | native_ir_utils_text, typecheck_types |
| `contains_string` | emit_native_state, typecheck_types |
| `contains_effect` | decorator_semantics, effect_checker |
| `index_of` | native_ir_utils_text, string_utils, llvm/utils |
| `number_to_string` | main, emit_native_state, llvm/utils |
| `is_symbol_char` / `sanitize_symbol` | string_utils, llvm/utils |
| `string_array_contains` | llvm/utils, parser/utils |

Work one function at a time. **Known gotcha:** `llvm/utils.sfn` has a comment stating functions were duplicated to avoid cross-module call issues in Stage2. Test whether imports work now; if still broken, leave that file and consolidate others first.

### 2. Deduplicate `TextBuilder`

`TextBuilder` + `builder_to_string` is defined identically in `emit_native_state.sfn` and `emitter_sailfin_utils.sfn`. Extract into a shared module.

### 3. Move `native_ir_*.sfn` files into `native_ir/` subdirectory

8 flat-top-level files, ~4,400 lines. Move to `compiler/src/native_ir/` with a `mod.sfn` re-exporting the public API. Update all imports.

### 4. Move `emit_native_*.sfn` files into `emit_native/` subdirectory

4 files, ~2,500 lines. Move to `compiler/src/emit_native/` with a `mod.sfn`.

### 5. Move `typecheck_*.sfn` files into `typecheck/` subdirectory

`typecheck.sfn` + `typecheck_types.sfn`, ~1,100 lines.

### 6. Move `cli_*.sfn` files into `cli/` subdirectory

`cli_main.sfn` + `cli_commands.sfn` + `cli_commands_utils.sfn`, ~1,900 lines.

### 7. Consolidate tiny files under `llvm/expression_lowering/native/`

Merge into related larger files:

- `core_match_helpers.sfn` (12 lines) → `core.sfn` or `core_parse.sfn`
- `core_bindings.sfn` (33 lines) → `core.sfn`
- `core_borrow_lowering.sfn` (53 lines) → `core_ownership.sfn`
- `core_addressing.sfn` (57 lines) → `core.sfn`

Each merge reduces the module count the build must compile.

### 8. Deduplicate path helpers (`_dirname`, `_path_join`)

Implemented identically in `cli_main.sfn` and `cli_commands_utils.sfn`. Extract to a shared module.

## Rules

1. **Self-hosting invariant** — after every change, `make compile` must succeed. If it breaks, revert and try a smaller step.
2. **One logical change per run** — one item from the list per PR. A directory move touching 20+ import paths is still one logical change.
3. **Check for prior work** — before starting, run `git log --oneline -50` for related commits. If already done, move to the next item.
4. **Test coverage** — after extracting a shared module, run `make test-unit`. Add a test if the new module lacks one.
5. **Import compatibility** — when moving functions, keep a re-export in the origin file if other modules still import from there. Remove re-exports in a follow-up.
6. **Minimal diff** — don't reformat or refactor code you didn't move. Move verbatim, then fix imports.
7. **Memory safety** — always `ulimit -v 8388608` before running the compiler. Wrap single-file invocations with `timeout 60`.

## Verification

Commit and push before compiling. The build can take 15–20+ minutes; always commit and push first, then verify.

```bash
git add -A
git commit -m "refactor(<scope>): <what you did>"
git push origin HEAD

ulimit -v 8388608
make compile        # self-hosting invariant — must succeed
make test-unit      # must pass — no regressions
```

If verification fails after the push, open a follow-up commit on the same branch — don't amend or force-push.

## Commit & PR format

```
refactor(<scope>): <what you did>

<1–2 sentence explanation of why>

Files moved/changed:
- list
```

Branch: `claude/refactor-compiler-<item>-<random>`. PR title uses the same Conventional Commit prefix.

## Abort conditions

Bail with a `noop` and explanation if:

- All priority-list items appear already done in recent commits.
- The repository is mid-release (tag push in progress, `beta`/`rc` branch recently cut).
- A prior nightly-refactor PR is still open unmerged — don't pile on.
