---
sfep: 27
title: CLI Modularization — Per-Worker RSS Relief First, Then Migration
status: Draft
type: tooling
created: 2026-06-26
updated: 2026-06-26
author: "agent:compiler-architect; human review"
tracking: "#351"
supersedes: 9
superseded-by:
graduates-to:
---

# SFEP-0027 — CLI Modularization: Per-Worker RSS Relief First, Then Migration

> Supersedes SFEP-0009 (`0009-cli-modularization-epic.md`). 0009 was written
> 2026-05-06, **before** the runtime migration (#822) dumped the entire
> build/link orchestration into `cli_main.sfn`. Its inventory (`cli_main.sfn`
> = 1,534 lines), its driver (`tracking: "#345"` — that is the
> *compiler-decomposition* epic, not the CLI epic), and its framing
> (capsule-positioning + DRY) are all stale. This SFEP re-anchors the epic on
> its real present-day driver: **per-worker peak RSS in `cli_main.sfn` caps CI
> `--jobs`.**

## 1. Summary

`compiler/src/cli_main.sfn` has grown to **3,067 lines** (verified
2026-06-26), 2× its size when SFEP-0009 was written. The growth is **not**
argv parsing — it is build/link/determinism orchestration the runtime
migration (#822) dumped into the CLI module, plus a single **937-line**
`sailfin_cli_main_legacy` mega-function (`cli_main.sfn:1918-2855`). That
single-module working set makes `cli_main` and its sibling `cli_commands` two
of the three heaviest emitters in the build (`0006-build-architecture.md:1635-
1636`: `cli_commands` 22.30 s, `cli_main` 19.76 s). Because per-module emit is
isolated, **per-worker peak RSS is the cap on parallel `--jobs`**. This SFEP
sequences the epic **RSS-relief first**: extract the build-driver orchestration
out of `cli_main.sfn` into a dedicated `compiler/src/build/` module set and
shatter the 937-line function (mechanical, behavior-preserving, self-hosting-
trivial, bundle-no-seed-cut), measured with `make bench`; **then** finish the
half-done, untracked command migration (6 commands + `lock`) into
`compiler/src/cli/commands/`, delete the legacy remnants, and relocate the
non-CLI residue in `cli_commands_utils.sfn`.

## 2. Motivation

Three drivers, in priority order.

### 2.1 Per-worker peak RSS caps CI `--jobs` (the new, urgent driver)

The parallel build runs one isolated `emit llvm` subprocess per module; total
build wall-time is governed by `(slowest worker) × (modules / jobs)` and the
node's RAM budget is `jobs × (per-worker peak RSS)`. The 8 GiB self-cap
(`.claude/rules/compiler-safety.md`) is per-process, so the *fleet* memory
ceiling on a CI runner is `jobs × peak_RSS_of_heaviest_concurrent_module`.
`0006-build-architecture.md:1635-1644` (0.7.0 baseline) names the two CLI
modules among the heaviest emitters alongside the 4.4 GB
`llvm__expression_lowering__native__core` family:

| Module | emit time | role |
| --- | --- | --- |
| `cli_commands` | 22.30 s | command dispatch |
| `cli_main` | 19.76 s | **build/link orchestration + 937-line legacy fn** |
| `llvm__expression_lowering__native__core` | 16.71 s (4389 MB) | unrelated; structural |

The CLI modules' cost is **self-inflicted and reducible**: `cli_main.sfn`
carries the full clang-compile/link/runtime-object-cache/determinism pipeline
(see §3.1), and the 937-line legacy function is a single colossal function
body the lowering pass must hold in working set at once. Carving the build
driver out of `cli_main` and splitting the mega-function **lowers the
single-module working set**, dropping `cli_main`'s per-worker peak RSS — which,
multiplied by `jobs`, is exactly what bounds how high CI can raise `--jobs`.
This is falsifiable: `make bench` reports per-module RSS and time, and each
Phase A step states a measured threshold (§8).

### 2.2 The migration is half-done and was never tracked

SFEP-0009 Phases 0 / 0.5 / 1 genuinely shipped: the `sfn/cli` capsule split is
done (`capsules/sfn/cli/src/` — 9 modules at v0.13.2, 14 test files), and
`compiler/src/cli/` exists (`main.sfn` 239 lines composing the v2 root +
dispatch, `context.sfn` 96 lines). **8 commands** are migrated into
`cli/commands/` (version, guillermo, init, login, add, publish, fmt, test).
But:

- **0009 Phase 3 sub-issues were never filed.** The 8 migrations happened
  untracked; #351 has no record of them.
- **7 commands remain unmigrated** — they still run through
  `sailfin_cli_main_legacy`: `config`, `check`, `package`, `emit`, `build`,
  `run`, **and `lock`** (the legacy dispatch arms are
  `cli_main.sfn:2001/2237/2662/2807/2817/2819/2823/2827`). The user brief
  listed 6; `lock` (`handle_lock_command`, dispatched at `cli_main.sfn:2819`)
  is the 7th and must be migrated too.
- **Phase 4 (delete legacy + relocate utils) has not started.**

`cli/main.sfn` dispatches the 8 migrated commands and falls through to
`sailfin_cli_main_legacy(argv)` (`cli/main.sfn:238`) for everything else. The
epic is stuck at a stable but unfinished midpoint with no tracking.

### 2.3 Dead weight for the compiler-decomposition epic (#345 / SFEP-0020)

**Dogfooding is real but partial — and SFEP-0020 §3.4 is right in the narrow
sense it means.** The compiler *does* consume `sfn/cli` today:
`compiler/capsule.toml:35` declares `"sfn/cli" = "*"` (the Issue 2.1 R1 gate),
and **9 files** import its builders/types — `compiler/src/cli/main.sfn` plus the
8 migrated commands under `cli/commands/`. So §3.4 is correct that there is **no
private CLI-*library* copy to swap out** (unlike `string_utils`→`sfn/strings`);
that DRY box is genuinely closed. What "already done" *elides* is the
**modularization** state: the 7 remaining commands and all legacy flag parsing
still bypass `sfn/cli`. The legacy `cli_main.sfn` imports the capsule for a
single `bold` symbol only (`cli_main.sfn:4` — the R1 link-feasibility canary,
not parsing) and otherwise walks argv by hand (44 `strings_equal` comparisons);
`cli_commands.sfn` imports nothing from `sfn/cli`. Decomposing the compiler into
`sfn/compiler-common` + a binary capsule (#345) would therefore inherit
**3,067 + 1,075 + 713 = 4,855 lines** of un-migrated `cli_*` (`cli_main` +
`cli_commands` + `cli_commands_utils`) — including the build driver and the
937-line legacy function — as dead weight in the `sfn/compiler` binary capsule.
Finishing this epic is therefore effectively a **prerequisite for a clean
#345**: it strips the binary capsule down to `cli/` + `build/` before the
decomposition draws its module boundaries. The two epics stay **cross-
referenced but independent** (this one self-hosts at every step without
touching the decomposition's import graph).

## 3. Design

Four concrete architectural calls. Target files are named; every move is
behavior-preserving.

### 3.1 Build/link orchestration leaves `cli_main.sfn` → `compiler/src/build/`

The single biggest RSS lever. These functions are **not CLI** — they are the
build driver the runtime migration dumped into `cli_main.sfn`. Inventory
(verified via `grep -nE '^fn ' compiler/src/cli_main.sfn`), bucketed:

**Bucket: runtime-object compile/cache** (→ `compiler/src/build/runtime_objs.sfn`)
- `_runtime_bundle_exists` (738), `_runtime_obj_prefix` (811),
  `_runtime_obj_cache_hit` (835), `_runtime_obj_cache_record` (846),
  `_runtime_obj_shared_cache_fetch` (861), `_runtime_obj_shared_cache_publish`
  (880), `_clang_compile_runtime_capsule_objects` (899),
  `_runtime_obj_key_with_sibling_deps` (1130), `_emit_runtime_sfn_to_obj`
  (1145), `_runtime_sfn_ctx_root` (1247), `_stage_one_runtime_sfn_import_context`
  (1273), `_write_runtime_sfn_import_deps` (1340),
  `_stage_runtime_sfn_import_context` (1394), `_compile_runtime_sfn_sources`
  (1426), `assemble_runtime_capsule_link_inputs` (1519, exported),
  `_failed_runtime_link_inputs` (794).

**Bucket: link** (→ `compiler/src/build/link.sfn`)
- `_dead_strip_link_flag` (1608), `_runtime_retain_root_flags` (1634),
  `_failed_link_result` (1671), `_clang_link_with_opt` (1675),
  `_clang_link_multi_with_opt` (1682), `_clang_link` (1784),
  `_clang_link_multi` (1792), `_resolve_self_path` (1051).

**Bucket: determinism** (→ `compiler/src/build/determinism.sfn`)
- `_extract_modules_from_manifest_json` (438), `_read_import_deps` (514),
  `_derive_pass2_work_dir` (539), `_pass2_out_path` (549),
  `_run_determinism_pass2` (573), `_read_sidecar_modules` (615),
  `_do_determinism_check` (627), `_sidecar_path_for_capsule` (403).

**Bucket: build cache / spec / sidecar** (→ `compiler/src/build/cache.sfn`,
or fold into `runtime_objs.sfn` if the carve proves too fine)
- `_resolve_sailfin_cache_dir` (1805), `_resolve_sailfin_cache_dir_for_work`
  (1826), `_resolve_capsule_build_spec` (1853), `_print_cache_summary` (248),
  `_emit_build_report` (343), `_emit_capsule_artifact_sidecar` (273),
  `_write_llvm_text` (226).

**Stays in `cli_main.sfn`** (genuine CLI/dispatch/entry + tiny path utils used
only by the legacy body until §3.3 migrates them out): `_usage` (161),
`_ends_with`/`_path_join`/`_dirname`/`_ensure_dir`/`_find_substring_from`/
`_path_basename`/`_path_strip_ext` (path/string util), `sailfin_cli_main_legacy`
(1918), `sailfin_cli_main_with_paths` (2856), `native_cli_main` (2885),
`_arena_telemetry_*` (2912/2934), `main` (2954).

**Carve rationale.** Four small, single-concern modules (`runtime_objs`,
`link`, `determinism`, `cache`) beat one fat `build/driver.sfn`: per-module
working set is the thing we are lowering, so the carve must itself produce
*small* modules. Each is `![io]`-only orchestration with **no behavior change**
— it remains "pure orchestration, no fixups" per CLAUDE.md (the driver does not
post-process compiler output; it shells `clang`/`llvm-link` and manages caches,
exactly as today). The legacy body and the migrated `build`/`run` commands
import the new modules; nothing else changes. **Per `.claude/rules/
seed-dependency.md`: this is a pure mechanical move with no new
capability/consumer split → one PR per move, NO seed cut** (`make compile`
builds the relocated module from the old seed in the same self-host pass).

### 3.2 Where `cli_commands.sfn` (1,075 lines) sits

`cli_commands.sfn` is the second-heaviest emitter (22.30 s). It holds the
`handle_*_command` bodies the legacy dispatch calls (`handle_package_command`,
`handle_lock_command`, `handle_config_command`, `handle_check_command`, plus
`handle_publish_command`). As §3.3 migrates each command into
`cli/commands/<name>.sfn`, the corresponding `handle_*` body moves with it (or
is reused — `check` reuses `cli_check.sfn`). `cli_commands.sfn` is **emptied
and deleted in Phase C**; its RSS cost disappears rather than relocating.

### 3.3 Break the 937-line `sailfin_cli_main_legacy` (`cli_main.sfn:1918-2855`)

The function is one giant `if is_emit { … } if is_build { … } if is_run { … }`
chain over pre-computed boolean command flags (`cli_main.sfn:1982-1996`:
`is_emit`/`is_build`/`is_run`/`is_package`/`is_lock`/`is_config`/`is_check`).
Each dispatch arm is the migration target:

1. **Phase A (RSS):** extract each arm's inline body into a per-concern
   `fn _legacy_dispatch_<cmd>(args, ctx, ...) -> int ![io, clock]` *in
   `cli_main.sfn` itself* — purely to shrink the single function the lowering
   pass holds at once. No semantic change; the dispatch chain calls the
   helpers. This alone drops `cli_main`'s peak working set before any command
   moves to `cli/`.
2. **Phase B:** each extracted `_legacy_dispatch_<cmd>` becomes the seed of the
   real `cli/commands/<cmd>.sfn` migration (`command_def()` + `run(matches,
   ctx)`), and its arm in legacy is deleted as `cli/main.sfn` gains the
   dispatch (mirroring the existing 8).

Splitting first (A) then migrating (B) means each migration in B starts from a
small, already-isolated helper rather than carving live code out of a 937-line
body.

### 3.4 The 7 remaining command migrations → `cli/commands/<name>.sfn`

Follow the established pattern (`cli/commands/version.sfn` … `test.sfn`):
`command_def() -> Command` registered on the v2 root in `cli/main.sfn`, and
`run(matches: ParseResult..., ctx: CliContext) -> int`. Order **simplest
first**:

| # | command | notes |
| --- | --- | --- |
| 1 | `config` | multi-level subcommands — `sfn/cli` nested subcommand support already shipped (capsule Issue 1.14; `nested_subcommand_test.sfn`). Reuse `handle_config_command`. |
| 2 | `lock` | thin; reuse `handle_lock_command`. |
| 3 | `package` | reuse `handle_package_command`. |
| 4 | `emit` | flag-heavy (`--timing`, `--module-name`, `-o`, `--attempts`, `--no-retry`, `--validate`, `--no-validate`, `--no-resolve-gate` — `cli_main.sfn:2001-2236`); maps cleanly onto `sfn/cli` typed flags. |
| 5 | `check` | **reuse the `cli_check.sfn` body verbatim** (`handle_check_command(args, binary_dir)`); the migration is the `command_def()` + dispatch wiring, not a rewrite. |
| 6 | `build` | **heavy** — pulls in the §3.1-extracted `build/` modules (link, runtime_objs, determinism, cache). |
| 7 | `run` | **heavy** — shares the `build/` modules with `build`; `run` = build-then-exec. |

`build`/`run` are last because they depend on §3.1 having already moved the
build driver into `compiler/src/build/`; their `run()` imports those modules
directly instead of reaching into `cli_main`.

### 3.5 Phase C — relocate `cli_commands_utils.sfn` (713 lines) residue

`cli_commands_utils.sfn` is "FS-atomic / shell / crypto helpers that have
nothing to do with the CLI" (SFEP-0020 §4.3 flags it as *backend-used*).
Reconcile with #345/SFEP-0020 so we **do not double-own**:

- **FS-atomic + path helpers** used by the build backend (`_mktemp_sibling_cmd`,
  `_atomic_rename_into_place`, `_ensure_dir_recursive_cmd`, `_write_text_cmd`,
  `_path_join_cmd`, `_dirname_cmd`, `_strip_trailing_slashes_cmd`): these are
  what SFEP-0020 §4.3 earmarks for `sfn/compiler-common` / backend. **Leave
  them compiler-local** (move into `compiler/src/build/fs.sfn` or keep in a
  slimmed util module) and let #345 draw the `compiler-common` boundary — do
  **not** push them into a stdlib capsule here.
- **String helpers** (`_string_lt_cmd`, `_sort_strings_cmd`,
  `_string_contains_cmd`, `_has_prefix_cmd`, `_byte_at_cmd`,
  `_word_matches_cmd`, `_string_list_contains_cmd`): **do not relocate to
  `sfn/strings` in this epic.** SFEP-0020 §7 owns the `sfn/strings` dogfooding
  swap; relocating them here would collide. Keep them compiler-local; tag them
  in the issue as "candidates for #345 §7's `sfn/strings` swap."
- **Shell/crypto/registry helpers** (`_shell_read_cmd`, `_curl_post_json_cmd`,
  `_curl_download_cmd`, `_sha256_of_file_cmd`, `_extract_sfnpkg_cmd`): move with
  their consuming command (`publish`/`add`/`package`) — they are command-local,
  not general util.
- **Env-flag bleed** (`_env_flag`, `_legacy_flag_file` — imported by
  `main.sfn`, the 0009 §1.3 cross-cutting bleed): relocate to a small
  `compiler/src/build_flags.sfn` (or `cli/context.sfn`) so `main.sfn` no longer
  imports from a "cli_commands" module.

After Phase C, `cli_commands_utils.sfn` is deleted; `cli_commands.sfn` is
deleted; `cli_main.sfn` retains only the entry shims (`main`,
`native_cli_main`, `sailfin_cli_main_with_paths`, `_arena_telemetry_*`) and
`_usage`, with `sailfin_cli_main_v2` (`cli/main.sfn`) as the sole dispatch.
`compiler/src/main.sfn` cross-imports update to the new module paths.

## 4. Effect & capability impact

**None.** This is a pure structural refactor. The extracted build-driver
functions keep their existing `![io]` (and `![io, clock]` for the dispatch
entry points) signatures verbatim; no effect annotation is added, widened, or
narrowed. The effect checker (`effect_checker.sfn`) sees identical effect rows
before and after each move because the function bodies are unchanged — only
their module home changes. No capability surface (capsule manifest, `![…]`
gate) is touched. If a relocated function's transitive effect set were to
change, that would be a bug, not an intended outcome — Phase A's `make compile`
+ `sfn check` gate catches it.

## 5. Self-hosting impact

**Hard invariant (every phase, every step):** each step produces a
self-hosting compiler. The change touches **no pipeline pass** — not lexer,
parser, AST, typecheck, effects, emitter, or LLVM lowering. It moves function
bodies between `compiler/src/*.sfn` modules. Therefore:

- **No seed dependency, no seed cut.** Per `.claude/rules/seed-dependency.md`:
  a pure refactor with no new capability and no capability/consumer split is
  **bundled in one PR per move**. `make compile` builds the relocated compiler
  from the *old* pinned seed in a single self-host pass — there is nothing the
  old seed cannot compile, because no new syntax/intrinsic/lowering is
  introduced.
- **Gate per step:** `make compile` (self-host) is mandatory after every move
  to a `compiler/src/*.sfn` file; structural moves (new module, deleted module,
  changed exports) additionally require `make clean-build` then `make check`
  (`.claude/rules/selfhost-invariant.md`).
- **Fix the compiler, not the driver.** All changes land in
  `compiler/src/*.sfn`. The build driver stays pure orchestration; no fixups,
  no post-processing (CLAUDE.md).
- **`sfn fmt --write` + `--check`** on every touched `.sfn` file before commit
  (`.claude/rules/formatting.md`).
- **Memory cap interaction:** the 8 GiB self-cap
  (`.claude/rules/compiler-safety.md`) is *per process*; the whole point of
  Phase A is lowering per-worker peak RSS **below** the level that currently
  bottlenecks parallel CI, so that `jobs × peak_RSS` fits a CI runner at a
  higher `jobs` than today. No phase raises peak RSS; every Phase A step must
  measurably lower it or be reverted.

## 6. Alternatives considered

- **Migrate-first, then relieve RSS (SFEP-0009's implicit order).** Rejected:
  the RSS bottleneck is *live* (it caps CI `--jobs` today), while the command
  migration is a long tail. Front-loading the mechanical, self-hosting-trivial
  build-driver carve delivers the CI win in days, decoupled from the multi-
  issue migration. This is the user's locked sequencing decision.
- **Leave the build driver in `cli_main.sfn`; only split the function.**
  Rejected: the build-driver functions are the *bulk* of `cli_main`'s 3,067
  lines and its working set. Splitting the legacy function alone leaves the
  clang/link/determinism pipeline co-resident in the same module — partial RSS
  relief. The two levers are complementary; do both in Phase A.
- **One fat `build/driver.sfn`.** Rejected: per-module working set is exactly
  what we are minimizing, so the carve must yield *small* modules
  (`runtime_objs`/`link`/`determinism`/`cache`), not relocate one monolith into
  another.
- **Push build-driver helpers down into `sfn/cli` or a new stdlib capsule.**
  Rejected: they are compiler-internal build orchestration, not a reusable CLI
  library surface; pushing them into stdlib would invert the dependency and
  collide with #345's `compiler-common` boundary (SFEP-0020 §7).
- **Fold this into #345 (compiler decomposition).** Rejected: #345 is a larger,
  riskier graph-cut; this epic is independently shippable and *reduces #345's
  blast radius* by stripping the binary capsule first. Keep them cross-
  referenced but separately tracked.

## 7. Stage1 readiness mapping

This is a structural refactor, not a language feature; the checklist maps to
"behavior preserved + self-hosts" rather than "new construct works":

- [x] Parses — no new syntax; existing forms only.
- [x] Type-checks / effect-checks — identical signatures; `sfn check` green per
  step (catches any accidental effect/type drift from a move).
- [x] Emits valid `.sfn-asm` — relocated bodies emit byte-identically (modulo
  module name in mangling).
- [x] Lowers to LLVM IR — unchanged lowering; the *goal* is lower per-module
  RSS during lowering.
- [ ] Regression coverage — existing CLI/e2e tests must stay green; add a
  per-module RSS guard (§8).
- [ ] Self-hosts — `make compile` per step; `make check` per structural step.
- [ ] `sfn fmt --check` clean — every touched `.sfn`.
- [ ] Documented — update `docs/status.md` (CLI module map) and cross-ref
  SFEP-0020; flip this SFEP to `Implemented` when Phase C lands.

## 8. Test plan

**Behavior preservation (every step).**
- Full suite green: `make compile && make test` after each Phase A move;
  `make clean-build && make check` after each structural (new/deleted module)
  step.
- CLI behavior parity: the existing `compiler/tests/e2e/*_test.sfn` that drive
  `build`/`run`/`emit`/`check`/`config`/`package`/`lock` via
  `process.run_capture` (per `.claude/rules/no-bash-e2e.md`) must pass
  unchanged — they are the regression oracle that a relocated/extracted body
  behaves identically. Each Phase B command migration re-runs its command's
  e2e peer.
- `sfn check compiler/src/` clean per step (fast inner loop; catches effect/type
  drift a move could introduce).

**RSS / performance (Phase A success threshold — the falsifiable claim).**
- Capture a `make bench` baseline for `cli_main` and `cli_commands`
  (per-module emit time + peak RSS) *before* Phase A. Record alongside the
  0006 baseline CSV.
- **Threshold:** after Phase A, `cli_main`'s per-module peak RSS must drop by a
  measurable margin (target: bring `cli_main` and `cli_commands` peak RSS in
  line with the median module, i.e. out of the "two heaviest CLI emitters"
  callout in `0006-build-architecture.md:1643-1644`). Re-run `make bench` after
  the build-driver carve and after the legacy-function split; record both in
  the SFEP/issue. If a step does **not** lower RSS, revert it.
- Optional: a `compiler/tests/` guard asserting `cli_main.sfn` stays under a
  line budget (e.g. < 1,200 lines) so the module cannot silently re-balloon —
  a cheap regression sentinel for the RSS lever.

**Migration coverage (Phase B/C).**
- Each migrated command gains/keeps a `cli/commands/<name>.sfn` test peer
  mirroring the existing 8 (e.g. `version`/`fmt`/`test` command tests) and the
  capsule's parser tests.
- Post-Phase-C: assert `cli_commands.sfn` and `cli_commands_utils.sfn` are
  deleted and `compiler/src/main.sfn` imports resolve (a build-time check via
  `make check`).

## 9. References

- **Supersedes:** SFEP-0009 `docs/proposals/0009-cli-modularization-epic.md`
  (stale inventory, mis-linked `tracking: #345`, pre-runtime-migration framing).
- **Epic:** GitHub #351 (CLI modularization — to be closed; a fresh epic tied
  to this SFEP replaces it).
- **RSS evidence:** `docs/proposals/0006-build-architecture.md:1621-1648`
  (0.7.0 build-performance baseline; `cli_commands` 22.30 s / `cli_main`
  19.76 s named among heaviest emitters; per-module isolated emit ⇒
  per-worker RSS caps `--jobs`).
- **Interacts with:** SFEP-0020 `docs/proposals/0020-compiler-decomposition.md`
  (#345) — §3.4 (CLI dogfooding "already done"), §4.3 (`cli_commands_utils` is
  backend-used FS-atomic helpers), §7 (`sfn/strings` dogfooding swap — do not
  double-own the string helpers). Finishing this epic is a prerequisite for a
  clean #345.
- **Rules:** `.claude/rules/seed-dependency.md` (pure refactor → bundle, no
  seed cut), `.claude/rules/selfhost-invariant.md`, `.claude/rules/
  compiler-safety.md` (8 GiB self-cap), `.claude/rules/no-bash-e2e.md`,
  `.claude/rules/formatting.md`.
- **Current state (verified 2026-06-26):** `cli_main.sfn` 3,067 lines;
  `cli_commands.sfn` 1,075; `cli_commands_utils.sfn` 713; `cli_check.sfn` 515;
  `cli/main.sfn` 239; `cli/context.sfn` 96. `sailfin_cli_main_legacy`
  `cli_main.sfn:1918-2855` (937 lines). 8 migrated commands in
  `cli/commands/`; 7 unmigrated via legacy (`config`, `check`, `package`,
  `emit`, `build`, `run`, `lock`). `sfn/cli` capsule v0.13.2, 9 src modules,
  14 test files.
