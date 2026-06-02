# Unit-test import envelope (SPIKE for #619)

**Status:** grooming spike — design only, no compiler source changed.
**Issue:** #619 "enable importing exported symbols from compiler/src in unit tests".
**Author:** compiler-architect spike, 2026-06-02.

This doc closes the three open questions from the prior #619 spike, states the
root cause, recommends a path, and provides a paste-ready groomed-issue spec.

---

## 1. Root cause

The blocker is **import-closure size**, not a linker incapacity and not the
`char_code`/runtime chain that `check_tool_test.sfn`'s header comment blames.

### Citation-first evidence

The `sfn test` runner links one standalone `*_test.sfn` via
`_clang_link_test_cmd_with_deps` (`compiler/src/cli_commands.sfn:140`). The link
line is, head → tail (`cli_commands.sfn:120-123`):

1. the test source `.ll` (strong),
2. resolver-produced dependency `.ll` files for the test's import closure
   (strong),
3. the **runtime sources + globals + prelude** (strong), assembled by
   `assemble_runtime_capsule_link_inputs` (`cli_commands.sfn:51`, `:176`).

Two facts fall directly out of this:

- **The runtime/`char_code` chain is already on every test's link line.**
  `runtime/prelude` (which exports `char_code`, consumed by
  `string_utils.sfn:6-13`) is linked into *every* test via step 3. A test that
  imports a light `src` module that itself uses `char_code` therefore resolves
  `char_code` fine. The header comment in `check_tool_test.sfn:4-9` ("the test
  runner cannot link against `char_code` via the string_utils → runtime chain")
  is **stale/incorrect** — it was a symptom misattribution.

- **The real cost is the transitive import closure the resolver must compile +
  link as step 2.** That set is determined by the `from "..."` graph of the
  imported symbol's home module.

### The two closures, measured by the import graph

`diagnostics_render.sfn` (home of `join_effects` @ `:42` and
`code_for_missing_effect` @ `:54`) imports only
(`diagnostics_render.sfn:34-37`):

```
effect_checker, string_utils, token, typecheck_types
```

That is the **light closure** (~8 modules). Precedent that this links from a
standalone unit test today: `effect_capabilities_test.sfn:30` already imports
`validate_capsule_capabilities` from `effect_checker` and passes;
`abi_hash_determinism_test.sfn:23` imports from `llvm/lowering/abi_hash` and
passes. No unit test imports `diagnostics_render` *symbols* yet (the references
in `effect_checker_test.sfn:633` and `effect_imports_test.sfn:207` are comments),
but its dependency `effect_checker` is already proven linkable standalone.

`tools/check.sfn` (home of `render_summary` @ `:212`) and `main.sfn` (home of
`number_to_string` @ `:621`) anchor the **heavy closure** (~130 modules):

- `render_summary` calls `number_to_string`, imported from `main`
  (`tools/check.sfn:34`).
- `main.sfn` imports the entire backend: `llvm/lowering/entrypoints`,
  `llvm/lowering/entrypoints_tests`, `llvm/lowering/entrypoints_tests_writer`,
  `emit_native`, `emitter_sailfin`, `typecheck`, … (`main.sfn:28-48`).

So importing `render_summary` **or** `number_to_string` transitively drags
`main.sfn` → the full compiler. That is the link set that "blows up" — not a
missing symbol.

### Live reproduction status (honest disclosure)

Open question 2 asked for a live reproduction (build a light-import test and a
heavy-import test, capture the actual error). **This could not be executed in the
spike environment:** there is no prebuilt `build/native/sailfin` and no seed
binary on disk (`.seed-version` pins `0.7.0-alpha.19` but `build/seed/` is
empty), and a from-scratch `make compile` is a 60–90 min self-host that exceeds
the spike's tooling budget. The root cause above is therefore established by
**static import-graph analysis plus existing passing-test precedent**, which is
conclusive on the *light* side (the precedent tests already link). The
implementing engineer MUST still run the live reproduction as the first
acceptance step (commands in §3 Verification) and record the actual heavy-side
failure mode (expected: clang `undefined reference`/OOM/timeout from pulling the
~130-module closure into one test link) in the PR.

---

## 2. Recommended path: **(C) hybrid**

**Migrate the light-closure subset now behind a documented "test-import
envelope"; file the heavy-closure structural fix as a separate follow-up.**

### Why (one paragraph)

Forcing the 130-module `main.sfn` closure into a single unit-test link is
exactly the wasteful coupling a performant toolchain should avoid: it would make
one tiny string-rendering test compile and link the entire backend, multiplying
unit-test wall-clock and memory for zero added coverage value. The light subset
(`diagnostics_render`) already satisfies #619's intent — a unit test importing a
*real* exported `src` symbol, with mutation of that symbol failing the test —
and it links today by the same precedent that `effect_capabilities_test` relies
on. So we get the production-grade win (real-symbol coverage, drift protection)
immediately for the symbols that fit, document the envelope so future authors
know which modules are unit-test-linkable, and quarantine the genuinely hard
problem (making `main.sfn`-anchored symbols linkable, which requires extracting
`number_to_string`/`render_summary` out of the heavy closure) into its own
scoped issue rather than letting it block the easy win.

### What migrates vs. stays (from open question 3)

| Local helper | Real symbol | Closure | Signature parity | Decision |
|---|---|---|---|---|
| `_local_join_effects` | `join_effects(string[])` @ `diagnostics_render.sfn:42` | light (~8) | **exact** | **Migrate** — direct import, delete local |
| `_local_code_for_first_description(string)` | `code_for_missing_effect(string[], EffectRequirement[])` @ `:54` | light (~8) | **mismatch** (struct args, not desc string) | **Migrate via struct literals** — build `EffectRequirement { effect, description, trigger: null }` and assert the E0400/E0401/E0402 contract on the real fn |
| `_local_build_effect_message` | no standalone peer; logic inlined in `effect_violation_to_diagnostic(EffectViolation)` @ `:92-115` | light (~8) | n/a (no peer) | **Optional / defer** — only reachable by constructing an `EffectViolation` (nested arrays); higher struct-literal segfault risk. Keep local OR add as stretch |
| `_local_num_to_string` | `number_to_string(int)` @ `main.sfn:621` | **heavy (~130)** | exact | **Keep local** — heavy closure; follow-up issue |
| `_local_render_summary(int,int)` | `render_summary(CheckSummary)` @ `tools/check.sfn:212` | **heavy (~130)** | **mismatch** (struct arg) + heavy | **Keep local** — heavy closure; follow-up issue |

Net: the canary migration drops `_local_join_effects` and
`_local_code_for_first_description` outright (the light, on-target subset),
optionally `_local_build_effect_message`, and **documents** why
`_local_num_to_string` / `_local_render_summary` remain (heavy closure). It does
*not* drop all `_local_*`.

### Struct-literal caveat

The header comment also blames "segfault on nested struct-literal initialisers
(some compiler versions)". `EffectRequirement` has a nullable `trigger: Token?`
(`effect_checker.sfn:53`), so a flat `EffectRequirement { effect: "...",
description: "...", trigger: null }` is a *single-level* literal and is the
recommended construction for the `code_for_missing_effect` migration. Avoid the
`EffectViolation` path (nested `EffectRequirement[]` + `missing_effects[]`)
unless the live repro shows it is segfault-clean on the pinned seed — hence
`_local_build_effect_message` is "optional" not "required".

---

## 3. Groomed-issue spec for #619 (paste-ready)

### Goal

Replace the hand-mirrored `_local_*` helpers in
`compiler/tests/unit/check_tool_test.sfn` with imports of the **real** exported
symbols they shadow, for the symbols whose import closure is light enough to link
from a standalone unit test, and document the supported "test-import envelope" so
future test authors know which `compiler/src` modules are unit-test-linkable.

### Scope

**In:**
- Migrate `check_tool_test.sfn` to `import { join_effects, code_for_missing_effect } from "../../src/diagnostics_render"` and delete the corresponding `_local_join_effects` and `_local_code_for_first_description` helpers, rewriting the affected tests against the real signatures (`code_for_missing_effect` takes `(string[], EffectRequirement[])`, so tests build flat `EffectRequirement { …, trigger: null }` literals).
- Update `check_tool_test.sfn`'s header comment to the correct root cause (import-closure size, not the `char_code` chain).
- Add `docs/conventions/unit-test-import-envelope.md` (or a section in an existing `docs/conventions/` file) documenting: the runner links `runtime/prelude` into every test, light-closure `src` modules are importable, `main.sfn`-anchored symbols are NOT (they drag the ~130-module backend), and how to check a module's closure before importing.

**Out:**
- Migrating `_local_num_to_string` / `_local_render_summary` (heavy `main.sfn` closure) — split to a follow-up structural issue (see Split decision).
- Any change to the runtime link path / `_clang_link_test_cmd_with_deps`.
- ~~`scripts/run_native_test.sh`~~ — **deleted in PR #850**; the runner is now the Sailfin-native `sfn test` command (`handle_test_command` in `compiler/src/cli_commands.sfn:875`, single-file compile+link via `_clang_link_test_cmd_with_deps` @ `cli_commands.sfn:140`). #619's original Files-Affected reference to that script is stale and is corrected below.

### Acceptance Criteria

1. At least one test in `check_tool_test.sfn` imports a real exported symbol from the `tools/check.sfn` analysis area's dependency graph (`diagnostics_render`'s `join_effects` / `code_for_missing_effect`, which `tools/check.sfn:29` itself imports) instead of a `_local_*` copy.
2. The `_local_*` helpers that have a linkable real peer are deleted from `check_tool_test.sfn` (`_local_join_effects`, `_local_code_for_first_description`; optionally `_local_build_effect_message`). The header comment documents which helpers remain (`_local_num_to_string`, `_local_render_summary`) and that the reason is heavy import closure, not linker capability.
3. Mutating the real symbol (e.g. changing `join_effects`'s separator or `code_for_missing_effect`'s prefix logic in `compiler/src/diagnostics_render.sfn`) makes the migrated test FAIL — proving it exercises the real code, not a copy. (Verified by a temporary local edit during review; reverted.)
4. No new segfaults or link failures: `build/native/sailfin test compiler/tests/unit/check_tool_test.sfn` passes, and the full `make test-unit` is green.
5. `docs/conventions/` describes the supported test-import envelope (which `src` modules/symbols are linkable from unit tests and why heavy ones are not).

### Files Affected (corrected)

| Pipeline stage / area | File | Change |
|---|---|---|
| Test (canary) | `compiler/tests/unit/check_tool_test.sfn` | Import `join_effects`, `code_for_missing_effect` from `../../src/diagnostics_render`; delete light `_local_*`; rewrite tests against real signatures; fix header comment |
| Docs (convention) | `docs/conventions/unit-test-import-envelope.md` (new) **or** a section in an existing `docs/conventions/*.md` | Document the test-import envelope |
| Reference (read-only, do not edit) | `compiler/src/diagnostics_render.sfn` | Source of `join_effects` (`:42`), `code_for_missing_effect` (`:54`); only touched transiently to verify AC#3 |
| Reference (read-only) | `compiler/src/cli_commands.sfn` | Runner link path (`:140`, `:875`) — for understanding, not modification |

**Stale reference removed:** `scripts/run_native_test.sh` (deleted in #850) — replaced by `sfn test` / `compiler/src/cli_commands.sfn`.

### Verification

```bash
# 0. Build the compiler if no native binary present (one-time, slow).
ulimit -v 8388608; make compile

# 1. LIVE ROOT-CAUSE REPRO (record outputs in the PR).
#    Light import — expected to LINK + PASS:
ulimit -v 8388608; timeout 60 build/native/sailfin test \
  compiler/tests/unit/check_tool_test.sfn
#    Heavy import — author a throwaway test importing `number_to_string`
#    from ../../src/main (or render_summary from ../../src/tools/check)
#    and capture the actual failure (undefined ref / OOM / timeout):
ulimit -v 8388608; timeout 60 build/native/sailfin test /tmp/heavy_import_test.sfn

# 2. Migrated canary passes:
ulimit -v 8388608; timeout 60 build/native/sailfin test \
  compiler/tests/unit/check_tool_test.sfn

# 3. AC#3 mutation check (temporary): change the ", " separator in
#    diagnostics_render.join_effects, rebuild, confirm the migrated test
#    FAILS, then revert.
ulimit -v 8388608; make compile && \
  build/native/sailfin test compiler/tests/unit/check_tool_test.sfn   # expect FAIL, then revert

# 4. Full unit suite green + formatting:
ulimit -v 8388608; make test-unit
ulimit -v 8388608; timeout 30 build/native/sailfin fmt --check \
  compiler/tests/unit/check_tool_test.sfn
```

### Size: **S**

Justification: the implementation surface is one test file plus one docs file.
The work is not XS because it is not a mechanical delete — `code_for_missing_effect`
has a *different signature* than `_local_code_for_first_description` (struct args
vs. a description string), so several tests must be rewritten to construct
`EffectRequirement` literals and assert the E0400/E0401/E0402 contract through
the real API, and the engineer must run the live light/heavy reproduction and the
AC#3 mutation check (each gated behind a `make compile`). It is not M because no
compiler source changes, no runtime/link-path changes, and the heavy closure is
explicitly out of scope.

### Split decision: **split into two issues**

- **#619 (this issue, Size S):** test-import envelope doc + light-closure
  migration (`join_effects`, `code_for_missing_effect`). Self-contained, no
  compiler changes, deliverable now.
- **Follow-up (new issue, Size M, structural):** "make `tools/check.sfn` summary
  helpers unit-test-linkable" — extract `number_to_string` (and have
  `render_summary` depend on the extracted home) out of the `main.sfn`-anchored
  heavy closure into a leaf module (e.g. a `num_format.sfn` or
  `string_utils`-adjacent module) so `_local_num_to_string` / `_local_render_summary`
  can also drop their copies. This is the real structural fix and should not
  block #619. Label `seed-blocker` is NOT required (additive).
- **Backport (optional, fold into the follow-up or a third XS issue):** apply the
  same envelope pattern to `selfhosting_patterns_test.sfn` and the sibling files
  the header names (`fmt_test.sfn`, `capsule_dep_resolution_test.sfn`,
  `stdlib_capsule_allowlist_test.sfn`) once the envelope doc exists.

### Required in pinned seed

*(empty — no seed dependency)*

This work imports already-exported symbols from `compiler/src` into a test file
and adds a docs file. It uses no new language features and changes no syntax the
compiler consumes, so it self-hosts on the current pinned seed
(`0.7.0-alpha.19`) with no seed bump. The only caveat is the documented
struct-literal segfault risk on *some* seed versions; the migration deliberately
restricts itself to flat `EffectRequirement { …, trigger: null }` literals to
stay clear of it, and the optional `EffectViolation`-based
`_local_build_effect_message` migration is gated on the live repro confirming the
pinned seed handles its nested literal cleanly.

---

## 4. Open-question close-out summary

1. **Current runner:** `sfn test` (`handle_test_command`,
   `compiler/src/cli_commands.sfn:875`); single standalone-test compile+link is
   `_clang_link_test_cmd_with_deps` (`cli_commands.sfn:140`), with the import
   closure resolved via `compile_tests_to_llvm_file_with_module_imports`
   (`main.sfn:415`) and the runtime assembled by
   `assemble_runtime_capsule_link_inputs` (`cli_commands.sfn:51/176`).
   `scripts/run_native_test.sh` is **deleted** (#850).
2. **Closure hypothesis: CONFIRMED statically** (live repro deferred to
   implementation — no binary/seed in the spike env). Light closure
   (`diagnostics_render`, ~8 mods) links from unit tests today (precedent:
   `effect_capabilities_test.sfn:30`). Heavy closure
   (`render_summary`/`number_to_string` → `main.sfn` → backend, ~130 mods) is the
   blow-up. The `char_code` framing is stale: `runtime/prelude` is on every
   test's link line already.
3. **Signatures:** `join_effects` is an exact match (direct migrate);
   `code_for_missing_effect` is light but has a *different* (struct) signature,
   so it migrates with `EffectRequirement` literals — it is NOT a string-arg
   drop-in for `_local_code_for_first_description`; `_local_build_effect_message`
   has **no** standalone exported peer (logic is inlined in
   `effect_violation_to_diagnostic`), so it is optional/deferred;
   `_local_num_to_string` (`number_to_string`) and `_local_render_summary`
   (`render_summary`, also a struct-arg mismatch) are heavy and stay local. The
   canary migration therefore drops the **light subset**, not all `_local_*`.
