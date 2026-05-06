# CLI Modularization Epic

**Status:** Draft
**Date:** 2026-05-06
**Owner:** Core team (compiler-architect)

## 1. Motivation

Sailfin's CLI today is split between three places:

1. The `sfn/cli` capsule (`capsules/sfn/cli/`) — a single 766-line `mod.sfn`
   containing types, builders, parser, accessors, help formatting, and ANSI
   helpers. Its tests *redefine* the API as private `_command` / `_with_arg`
   helpers because cross-capsule import in the test runner has been
   intermittent. Marketed as a library, but no production caller imports it.
2. The compiler CLI (`compiler/src/cli_*.sfn`) — ~4,500 lines of hand-rolled
   argv-walking, per-subcommand `if strings_equal(args[i], "--flag")` chains,
   open-coded help strings, ad-hoc error printing, and a long pile of
   filesystem / shell helpers (`cli_commands_utils.sfn`) that have nothing to
   do with the CLI.
3. Cross-cutting bleed in `compiler/src/main.sfn`, which imports
   `_env_flag` / `_legacy_flag_file` from `cli_commands_utils` to parse env
   flags inside a non-CLI module.

Pain this epic removes:

- **DRY.** Every subcommand reinvents flag parsing. Adding `--json` to
  `build`, `run`, `emit`, and `check` today means four manual edits.
- **Testability.** `sfn/cli`'s `run()` calls `process.exit()` on `--help`,
  `--version`, and parse errors. There is no path for a test or library
  consumer to drive parsing, observe errors, and recover.
- **Agent adoption.** The MCP server (`tools/mcp-server/`) and any
  agentic compile-check-fix loop want a structured command tree they can
  introspect. The current CLI exposes none.
- **Capsule positioning.** `sfn/cli` is the single most reusable library
  Sailfin can ship in 1.0. If the compiler itself doesn't consume it,
  third-party users have no reference and no incentive to trust it.
- **`Result<T, E>` migration.** Once typed errors land (Phase 1 of runtime
  sequencing), parse errors should flow through `Result`. A monolithic
  `mod.sfn` is harder to retrofit than a modularized parser.
- **Roadmap traction.** Structured `--help --json`, machine-readable
  diagnostics, and shell completion all read off the same command tree.
  The epic's deliverable is the tree.

Now, because (a) the capsule is small enough that the split is one
mechanical refactor, (b) the compiler CLI is the single largest non-pipeline
module set in the tree, and (c) every 1.0 milestone — runtime rewrite,
effect-as-gate, MCP server — benefits from a unified CLI surface.

## 2. Goals & non-goals

**Goals:**

- Split `sfn/cli` into focused internal modules (parser / help / style /
  print / types) behind a stable public re-export in `mod.sfn`.
- Expand the public API to cover real CLI needs: typed flag values, env
  bindings, required/exclusive flag groups, variadic positionals,
  non-exiting parse, NO_COLOR/TTY-aware styling, structured help tree,
  canonical exit-code constants.
- Migrate the compiler's CLI to import `sfn/cli` from the capsule. One
  `compiler/src/cli/` directory with one file per subcommand replaces
  `cli_main.sfn` + `cli_commands.sfn`.
- Move filesystem / shell / crypto helpers out of `cli_commands_utils.sfn`
  to the appropriate stdlib capsule (`sfn/fs`, `sfn/path`, `sfn/crypto`)
  or to a tightly scoped `compiler/src/cli/util.sfn` for genuinely
  compiler-specific helpers.
- Flip the capsule tests to import the public surface instead of
  redefining it.

**Non-goals:**

- Do **not** block on `Result<T, E>` or the `?` operator. Use the
  existing "result struct with `ok` flag" pattern that the rest of the
  compiler already uses (see `parser_state.sfn`, `effect_checker.sfn`).
  Re-shape to `Result` post-Phase-1 in a follow-up.
- Do **not** change the effect taxonomy. The capsule keeps `["io"]` as
  its only required effect. Pure parsing functions stay effect-free.
- Do **not** invent a DSL. No macros, no custom syntax, no `derive`
  attributes. Builder functions only. Boring syntax wins.
- Do **not** ship shell completion or `--help --json` as part of the
  core migration. Both ride on the structured command tree this epic
  produces, but each is its own follow-up issue.
- Do **not** add new keywords. `sfn/cli` is and will remain a library.
- Do **not** break the seed. Every phase must self-host with the
  current released seed binary; the migration uses additive features
  only until the next seed is cut.

## 3. Current-state inventory

The table below is the source of truth for "what lives where today" and
"where it lands after the migration." Each row maps to one or more issues
in section 7.

### 3.1 `capsules/sfn/cli/`

| Today | Lines | Lands in |
|---|---|---|
| `src/mod.sfn` — types `Arg`/`Flag`/`Command`/`Matches` | 31–62 | `src/types.sfn` (re-exported by `mod.sfn`) |
| `src/mod.sfn` — builders `arg`, `arg_optional`, `flag*`, `command`, `with_*` | 64–215 | `src/builder.sfn` |
| `src/mod.sfn` — `run()` (exiting parse) | 219–373 | `src/parser.sfn` (kept as `run()`; `parse()` added alongside) |
| `src/mod.sfn` — accessors `get`, `get_or`, `has_flag`, `has`, `subcommand`, `positionals` | 377–466 | `src/matches.sfn` |
| `src/mod.sfn` — help formatting `_format_help`, `_flag_label`, width helpers | 470–615 | `src/help.sfn` |
| `src/mod.sfn` — ANSI styling `bold`, `dim`, color helpers, `_esc`, `_ansi_wrap` | 624–678 | `src/style.sfn` |
| `src/mod.sfn` — `print_error/warn/success/hint` | 682–700 | `src/print.sfn` |
| `src/mod.sfn` — internal helpers `_starts_with`, `_pad`, `_find_flag_*`, `_resolve_active`, `_help_hint` | 704–765 | `src/parser.sfn` (private) |
| `tests/cli_test.sfn` — redefines API privately | all 1032 | rewritten to import from `mod.sfn` |

### 3.2 `compiler/src/cli_main.sfn` (1,534 lines)

| Today | Lines | Lands in |
|---|---|---|
| `_usage()` — hand-concatenated multi-line string | 72–108 | deleted; auto-generated from `Command` tree by `sfn/cli` |
| `_ends_with`, `_path_join`, `_dirname`, `_path_basename`, `_path_strip_ext` | 110–322 | `sfn/path` (or `compiler/src/cli/util.sfn` if kept compiler-local) |
| `_write_llvm_text`, `_print_cache_summary`, `_emit_capsule_artifact_sidecar`, `_emit_build_report` | 136–250 | unchanged location, but invoked from `compiler/src/cli/commands/build.sfn` |
| `_runtime_bundle_exists`, `_runtime_prelude_path` | 257–289 | `compiler/src/cli/runtime_root.sfn` |
| Internal `--runtime-root` / `--binary-dir` parsing (driver-injected) | 892–916 | `compiler/src/cli/context.sfn` (`CliContext` struct) |
| `is_version_flag` / `is_emit_flag` / `is_build` / ... dispatch chain | 957–988, 1523 | replaced by `sfn/cli` `Command` tree dispatch |
| Per-subcommand argv walking (`base_index`, `consumed_flag` loops) for `emit`, `build`, `run` | 1000–1521 | each subcommand owns flag definitions in `compiler/src/cli/commands/<name>.sfn` |
| `sailfin_cli_main(argv)` entry signature | 876–1531 | thin orchestrator in `compiler/src/cli/main.sfn` |
| `native_cli_main(argv)` C-shim entry | 1532–1534 | preserved in `compiler/src/cli/main.sfn` |

### 3.3 `compiler/src/cli_commands.sfn` (1,959 lines)

One `handle_<name>_command` per subcommand. Each one re-implements argv
walking and prints its own help. Migration moves each to
`compiler/src/cli/commands/<name>.sfn`:

| Function | Subcommand | Lands in |
|---|---|---|
| `handle_test_command` | `sfn test` | `compiler/src/cli/commands/test.sfn` |
| `handle_config_command` | `sfn config` | `compiler/src/cli/commands/config.sfn` |
| `handle_publish_command` | `sfn publish` | `compiler/src/cli/commands/publish.sfn` |
| `handle_package_command` | `sfn package` | `compiler/src/cli/commands/package.sfn` |
| `handle_add_command` | `sfn add` | `compiler/src/cli/commands/add.sfn` |
| `handle_init_command` | `sfn init` | `compiler/src/cli/commands/init.sfn` |
| `handle_login_command` | `sfn login` | `compiler/src/cli/commands/login.sfn` |
| `handle_guillermo_command` | `sfn guillermo` | `compiler/src/cli/commands/guillermo.sfn` |
| `handle_fmt_command` | `sfn fmt` | `compiler/src/cli/commands/fmt.sfn` |
| `_test_*`, `_package_*`, `_clang_link_test_cmd_with_deps` | (private) | stay near the subcommand that uses them |
| `_config_*`, `_default_registry_url_cmd`, `_resolve_registry_url_cmd` | (registry policy) | `compiler/src/cli/registry.sfn` (compiler-specific config policy) |

### 3.4 `compiler/src/cli_commands_utils.sfn` (507 lines)

Most of this file does not belong in any `cli_*` module. The migration
breaks it up:

| Function group | Today | Target |
|---|---|---|
| `_ends_with_cmd`, `_dirname_cmd`, `_path_join_cmd`, `_has_prefix_cmd`, `_string_contains_cmd` | path/string utils | `sfn/path` + `sfn/strings` (or `compiler/src/cli/util.sfn` if still missing from stdlib) |
| `_toml_trim_cmd`, `_byte_at_cmd`, `_word_matches_cmd`, `_is_ident_char_cmd` | token utils | `compiler/src/string_utils.sfn` (already exists; consolidate) |
| `_shell_read_cmd`, `_curl_post_json_cmd`, `_curl_download_cmd`, `_shell_single_quote_arg` | shell + http | `sfn/http` (curl wrappers); `compiler/src/cli/shell.sfn` (compiler-local) |
| `_get_env_cmd`, `_get_home_cmd`, `_env_flag`, `_legacy_flag_file` | env policy | `sfn/os` + a thin `compiler/src/cli/env.sfn` for the legacy flag-file shim |
| `_ensure_dir_cmd`, `_ensure_dir_recursive_cmd`, `_write_text_cmd`, `_collect_test_files_cmd`, `_collect_sfn_files_cmd` | fs | `sfn/fs` |
| `_sha256_of_file_cmd` | crypto | `sfn/crypto` |
| `_extract_sfnpkg_cmd` | sfnpkg archive format | `compiler/src/cli/sfnpkg.sfn` (compiler-local; sfnpkg is a tooling concern, not stdlib) |
| `_is_stdlib_capsule_cmd`, `_has_slash_cmd`, `_resolve_capsule_name_cmd`, `_display_capsule_name_cmd`, `_sanitize_filename_cmd`, `_is_safe_capsule_segment_cmd`, `_is_safe_capsule_version_cmd` | capsule-name validation | `compiler/src/capsule_artifact.sfn` (already hosts `is_safe_scope_name`; consolidate) |
| `_string_list_contains_cmd` | array util | `compiler/src/array_utils.sfn` (or `sfn/strings`) |

### 3.5 `compiler/src/cli_check.sfn` (476 lines)

Already isolated — leave the body intact; rename to
`compiler/src/cli/commands/check.sfn` and update its imports during the
Phase 3 migration.

### 3.6 `compiler/src/main.sfn` cross-bleed

`main.sfn:5` imports `_env_flag`, `_legacy_flag_file` from
`cli_commands_utils`. These are env-policy helpers — they belong in
`compiler/src/cli/env.sfn` (re-exported), or, better, `sfn/os`. The
import chain reverses post-migration: `cli` imports from `os`, not
the other way around. `main.sfn` either imports `sfn/os` directly or
keeps a tiny `compiler/src/env_flags.sfn` that re-exports the two
functions for non-CLI callers.

## 4. Target architecture

### 4.1 Capsule layout — `capsules/sfn/cli/`

```
capsules/sfn/cli/
  capsule.toml              # version bump 0.1.1 -> 0.2.0
  src/
    mod.sfn                 # re-exports public surface only
    types.sfn               # Arg, Flag, Command, Matches, ParseError, ParseResult, ExitCode
    builder.sfn             # arg, flag, flag_int, flag_choice, command, with_*
    parser.sfn              # parse() (non-exiting), run() (exits, unchanged)
    matches.sfn             # get, get_or, has_flag, has, subcommand, positionals,
                            # get_int, get_float, get_path, get_choice, count_flag
    help.sfn                # render_help_text(), render_help_tree() (structured)
    style.sfn               # bold, dim, color helpers + NO_COLOR/TTY gate
    print.sfn               # print_error/warn/success/hint/diag/status
    exit_codes.sfn          # EXIT_OK, EXIT_BUILD_FAIL, EXIT_USAGE, EXIT_NOT_FOUND, EXIT_INTERNAL
  tests/
    cli_test.sfn            # imports from "sfn/cli" — no inlined redefinitions
    parser_test.sfn         # focused parser coverage
    typed_flags_test.sfn    # int/float/path/choice/repeat/count
    style_test.sfn          # NO_COLOR + TTY gating
    help_tree_test.sfn      # structured help tree shape (for --help --json)
```

Public surface (`src/mod.sfn` re-exports only these — anything not listed
is internal):

```
// Types
Arg, Flag, Command, Matches, ParseError, ParseResult, ExitCode, FlagKind,
HelpNode, Style

// Argument builders
arg, arg_optional, arg_variadic

// Flag builders
flag, flag_short, flag_value, flag_value_short,
flag_int, flag_float, flag_path, flag_choice, flag_repeat, flag_count,
flag_required, flag_env

// Group constraints
flag_group_exclusive, flag_group_required_one

// Command builders
command, with_version, with_arg, with_flag, with_subcommand,
with_about, with_long_about

// Parsing
parse,            // -> ParseResult (no exit, no print)
run,              // -> Matches ![io] (existing semantics; calls process.exit())

// Matches accessors
get, get_or, has_flag, has, subcommand, positionals,
get_int, get_float, get_path, get_choice, count_flag, repeated

// Help
help, render_help_text, render_help_tree, print_help

// Style
bold, dim, underline, red, green, yellow, blue, magenta, cyan, gray,
style_default, style_disabled, style_for_stream, no_color_active

// Print
print_error, print_warn, print_success, print_hint, print_diag, print_status

// Exit codes
EXIT_OK, EXIT_BUILD_FAIL, EXIT_USAGE, EXIT_NOT_FOUND, EXIT_INTERNAL
```

Notes on the new types:

- `ParseError` — struct `{ kind: string; message: string; hint: string;
  exit_code: number }` with `kind` ∈ `{ "unknown_flag", "missing_value",
  "missing_required_arg", "missing_required_flag", "unknown_subcommand",
  "type_error", "exclusive_violation", "help_requested",
  "version_requested" }`. `missing_required_arg` covers positionals;
  `missing_required_flag` covers flags marked via `flag_required` (added
  in Issue 1.8). `help_requested` and `version_requested` are not errors
  per se but reuse the result channel to keep `parse()` non-exiting; the
  caller decides whether to print and exit.
- `ParseResult` — sentinel-flag struct `{ ok: boolean; matches: Matches;
  error: ParseError }`. Switches to `Result<Matches, ParseError>` once
  the language ships it (Phase 1 of runtime sequencing).
- `FlagKind` — enum-via-string `{ "bool", "string", "int", "float",
  "path", "choice", "repeat", "count" }`. Keeps the parser type-erased
  while stdlib lacks discriminated unions.
- `HelpNode` — recursive struct mirroring the `Command` tree but
  flattened for renderers (text + JSON). Lets `render_help_text` and a
  future `render_help_json` share the structure.
- `Style` — struct `{ ansi_enabled: boolean; force: boolean }` so
  callers don't sprinkle raw ANSI. `style_for_stream(stream_name)`
  returns the right `Style` for stdout vs stderr (TTY check + NO_COLOR).

### 4.2 Compiler CLI layout — `compiler/src/cli/`

```
compiler/src/cli/
  main.sfn                  # sailfin_cli_main + native_cli_main; build the
                            # Command tree, call sfn/cli parse(), dispatch.
  context.sfn              # CliContext { runtime_root, binary_dir,
                            #              registry_url, trace_argv }.
                            # Parses --runtime-root / --binary-dir prefix.
  registry.sfn             # registry URL resolution + config-file policy.
  runtime_root.sfn         # _runtime_bundle_exists, _runtime_prelude_path.
  shell.sfn                # _shell_read, _shell_single_quote_arg
                            # (until sfn/process exists).
  env.sfn                  # _env_flag, _legacy_flag_file (compiler-local
                            # legacy flag-file shim).
  sfnpkg.sfn               # extract_sfnpkg (compiler-only archive format).
  exit_codes.sfn           # re-exports sfn/cli's constants.
  commands/
    build.sfn              # build_command(): Command + run(matches, ctx)
    run.sfn
    emit.sfn
    version.sfn
    check.sfn              # body of today's cli_check.sfn
    fmt.sfn
    test.sfn
    init.sfn
    add.sfn
    publish.sfn
    package.sfn
    login.sfn
    config.sfn
    guillermo.sfn
```

Each `commands/<name>.sfn` exports two functions:

```
fn command_def() -> Command { ... }       // builds the sfn/cli command
fn run(matches: Matches, ctx: CliContext) -> number ![io, ...]
```

`main.sfn` composes the root Command by calling each
`command_def()`, calls `parse(root, argv)`, prints help/version and
exits via the canonical exit-code constants when the result asks for
it, and otherwise dispatches to the matching `run()`.

### 4.3 Dependency direction

```
        compiler/src/main.sfn
                |
                v
    compiler/src/cli/main.sfn
                |
   +------------+------------+
   v            v            v
 sfn/cli   compiler/src/cli/  compiler/src/cli/
 (capsule)   commands/*.sfn    context.sfn, registry.sfn, ...
                |
                +-> sfn/fs, sfn/path, sfn/os, sfn/crypto (stdlib)
                +-> compiler/src/* (compile pipeline modules)
```

Strict rules:

- **`sfn/cli` depends on nothing from the compiler tree.** It is a
  reusable library; it must build and ship standalone.
- **`compiler/src/cli/` depends on `sfn/cli` and on the rest of the
  compiler.** It is a thin orchestrator.
- **No reverse imports.** No compiler module imports from
  `compiler/src/cli/`. Exception: `main.sfn` imports `sailfin_cli_main`
  and the `_env_flag` shim; the latter moves to `compiler/src/env_flags.sfn`
  during Phase 0.5 so the CLI tree owns no cross-cutting exports.

## 5. Migration phases

Each phase produces a buildable, self-hosting compiler that passes
`make check`. No phase depends on a feature that hasn't shipped.

### Phase 0 — Capsule internal split (no API change)

Split `capsules/sfn/cli/src/mod.sfn` into the internal modules above.
`mod.sfn` becomes pure re-exports. Public surface, semantics, and
behaviour are byte-identical. Tests still inline-redefine the API in
this phase (the test rewrite is Phase 0.5).

Validation: `make compile && make check` passes; the diff in capsule
behaviour is zero.

### Phase 0.5 — Capsule test rewrite

Rewrite `capsules/sfn/cli/tests/cli_test.sfn` to import directly from
`mod.sfn`. Confirms the cross-capsule import path works for non-compiler
consumers (the test runner is the canary).

If cross-capsule import in tests is genuinely broken (the prompt
hints it might be), this phase is split into two: (a) fix the test
runner's capsule resolution, (b) flip the imports. The fix lives in
`compiler/src/cli/commands/test.sfn` (or `cli_check.sfn` precursor) and
in the resolver's test path; investigation issue is sized S.

### Phase 1 — Capsule API expansion

Each item is its own issue, sized XS or S. None of these change the
compiler — they expand the capsule surface so Phase 2 can consume it.

1. `parse()` non-exiting variant returning `ParseResult`.
2. `EXIT_*` constants in `exit_codes.sfn`.
3. NO_COLOR + TTY-aware styling: `Style`, `style_for_stream`,
   `no_color_active`.
4. `print_diag` and `print_status`.
5. `flag_int`, `flag_float`, `flag_path` + matching `get_*` accessors.
6. `flag_choice(["a", "b"])` + `get_choice`.
7. `flag_repeat` (`-v -v -v` collects values) + `repeated` accessor.
8. `flag_count` (counted boolean) + `count_flag`.
9. `flag_required` + missing-required-flag diagnostic.
10. `flag_env(f, "VAR_NAME")` — decorate an existing flag to fall back
    to the env var when the flag is absent on the command line.
11. `flag_group_exclusive`, `flag_group_required_one`.
12. `arg_variadic` — `<files>...` positional collection.
13. `--key=value` syntax + `--` end-of-options sentinel.
14. `HelpNode` + `render_help_tree` (powers future `--help --json`).
15. Multi-level subcommand parsing (the parser today only walks one
    level deep; `with_subcommand` stacks further nesting silently).

### Phase 2 — Compiler CLI skeleton + first migration

Introduce `compiler/src/cli/` with:

- `main.sfn` containing a *new* `sailfin_cli_main_v2(argv)` that
  builds the root Command via `command_def()` calls, parses with
  `sfn/cli`, and dispatches. Initially only `version` is wired up;
  every other subcommand falls through to the legacy
  `sailfin_cli_main` (which is renamed to `sailfin_cli_main_legacy`
  and kept verbatim).
- `context.sfn` with `CliContext` parsed from the driver-injected
  `--runtime-root` / `--binary-dir` prefix.
- `commands/version.sfn` as the proof-of-concept migration.
- A top-level dispatcher in `compiler/src/cli_main.sfn` that calls
  `sailfin_cli_main_v2` first, falls through to the legacy path on
  unrecognised subcommands.

`compiler/capsule.toml` gains `sfn/cli = "0.2.0"` in `[dependencies]`.
`build.sh` already routes `sfn/*` deps through `capsules/<scope>/<name>/src/`,
so no build-script changes are needed.

Validation: `make check` passes; `sfn version` round-trips through the
new path; every other subcommand still works via the legacy path.

### Phase 3 — Subcommand migration (one issue per command)

Migrate one subcommand at a time. Order: simplest first so the pattern
solidifies before the heavy ones. Each issue is S or M.

1. `init` — minimal flags, no positionals.
2. `login` — single optional positional.
3. `guillermo` — no flags.
4. `fmt` — boolean flags + variadic paths.
5. `add` — boolean flags + one positional.
6. `config` — multi-mode subcommand-of-subcommand.
7. `check` — flag + variadic paths; reuse existing `cli_check.sfn` body.
8. `test` — single optional positional.
9. `publish` — single optional positional.
10. `package` — many flags including value flags.
11. `emit` — order-independent flag parsing; tests for argv ordering.
12. `build` — full build orchestration; cache flags; capsule mode.
13. `run` — wraps build + exec.

After each issue: `make check` green; the migrated subcommand goes
through `sfn/cli`; legacy fallback in `cli_main.sfn` no longer reaches
that branch (dead-code annotated, removed in Phase 4).

### Phase 4 — Legacy removal

Delete `compiler/src/cli_main.sfn`, `compiler/src/cli_commands.sfn`,
`compiler/src/cli_commands_utils.sfn`. Move surviving helpers per the
inventory table (section 3.4). Update `compiler/src/main.sfn` to
import `_env_flag` / `_legacy_flag_file` from
`compiler/src/env_flags.sfn` (the new home), or from `sfn/os` if the
env-policy helpers shipped there during Phase 1.

This phase is one issue, sized M. It is gated on Phase 3 completing.
Touches every compiler file that imports from the deleted modules —
the inventory table tells us which ones, but the issue's `Files
Affected` list will be regenerated at pickup time.

### Phase 5 — Optional follow-ups

These are not part of the core epic but ride on the structured tree:

- `--help --json` flag — emits `render_help_tree` output as JSON.
- Shell completion generation (`sfn completion bash|zsh|fish`).
- `print_diag` integration with the rendered-diagnostic format used
  in `compiler/src/diagnostics_render.sfn` (unify the two paths).
- `Result<Matches, ParseError>` migration once `?` ships.

## 6. Files affected (full picture)

Grouped by phase. Every file gets exactly one home post-migration.

**Phase 0 — capsule split:**
- Read/rewrite: `capsules/sfn/cli/src/mod.sfn`
- New: `capsules/sfn/cli/src/{types,builder,parser,matches,help,style,print,exit_codes}.sfn`

**Phase 0.5 — capsule test rewrite:**
- Rewrite: `capsules/sfn/cli/tests/cli_test.sfn`
- Possibly: `compiler/src/runtime_capsule_resolver.sfn`,
  `compiler/src/capsule_resolver.sfn` (only if cross-capsule import in
  tests needs a fix)

**Phase 1 — API expansion:** capsule files only (one PR per item):
- `capsules/sfn/cli/src/parser.sfn`, `matches.sfn`, `builder.sfn`,
  `help.sfn`, `style.sfn`, `print.sfn`, `exit_codes.sfn`, `types.sfn`
- New tests under `capsules/sfn/cli/tests/`

**Phase 2 — compiler CLI skeleton:**
- `compiler/capsule.toml` (add `sfn/cli` dep)
- New: `compiler/src/cli/main.sfn`, `context.sfn`,
  `runtime_root.sfn`, `commands/version.sfn`
- Edit: `compiler/src/cli_main.sfn` (top-level dispatcher; renames
  `sailfin_cli_main` -> `sailfin_cli_main_legacy`)

**Phase 3 — per-subcommand:**
- New: `compiler/src/cli/commands/<name>.sfn` (one per phase-3 issue)
- Edit: `compiler/src/cli_commands.sfn` (drop the migrated handler);
  `compiler/src/cli_main.sfn` (drop the migrated dispatch arm);
  `compiler/src/cli/main.sfn` (add the new command_def)

**Phase 4 — legacy removal:**
- Delete: `compiler/src/cli_main.sfn`, `compiler/src/cli_commands.sfn`,
  `compiler/src/cli_commands_utils.sfn`, `compiler/src/cli_check.sfn`
- New: `compiler/src/cli/registry.sfn`, `shell.sfn`, `env.sfn`,
  `sfnpkg.sfn`, `util.sfn`, `env_flags.sfn` (compiler-local re-export
  for `_env_flag`/`_legacy_flag_file`)
- Edit: `compiler/src/main.sfn` (re-point `_env_flag` import),
  `compiler/src/native_driver.c` (re-point entry symbol if
  `native_cli_main` moves)

## 7. Workstream issues

Every issue below uses the contract from
`.github/ISSUE_TEMPLATE/claude-task.md`. Sizes: XS (<1h), S (1-3h), M
(3-6h). All non-bug issues cite this epic as their workstream.

### Phase 0

#### Issue 0.1 — Split sfn/cli mod.sfn into internal modules
- **Goal:** Split `capsules/sfn/cli/src/mod.sfn` into `types`,
  `builder`, `parser`, `matches`, `help`, `style`, `print`,
  `exit_codes`. `mod.sfn` re-exports the existing public surface only.
- **Scope.** In: file split, re-exports, no semantic changes. Out:
  any new API, any compiler-side change, any test rewrite.
- **Acceptance:**
  1. `mod.sfn` contains only `import` + `export` statements.
  2. Public function/struct names match today's surface byte-for-byte.
  3. `make check` passes.
  4. `sfn fmt --check capsules/sfn/cli/src/` is clean.
- **Files:** `capsules/sfn/cli/src/mod.sfn` (rewrite); `types.sfn`,
  `builder.sfn`, `parser.sfn`, `matches.sfn`, `help.sfn`, `style.sfn`,
  `print.sfn`, `exit_codes.sfn` (new).
- **Verification:** `make check`.
- **Size:** S. **Type:** refactor. **Depends on:** none.

#### Issue 0.2 — Bump sfn/cli to 0.2.0 (pre-API-expansion marker)
- **Goal:** Bump `capsules/sfn/cli/capsule.toml` from `0.1.1` to
  `0.2.0`. No code changes.
- **Acceptance:** version updated; `make check` passes.
- **Size:** XS. **Type:** refactor. **Depends on:** 0.1.

### Phase 0.5

#### Issue 0.5.1 — Investigate cross-capsule test import
- **Goal:** Determine whether the bootstrap test runner can resolve
  `import { ... } from "sfn/cli"` from a test file at
  `capsules/sfn/cli/tests/cli_test.sfn`. If not, identify the
  resolver gap.
- **Scope.** In: read-only investigation; one-paragraph writeup
  appended to this epic. Out: any code change.
- **Acceptance:** writeup posted as a comment on the issue;
  follow-up issue opened if a fix is needed.
- **Size:** XS. **Type:** refactor (investigation). **Depends on:** 0.1.

#### Issue 0.5.2 — Rewrite sfn/cli tests to import public API
- **Goal:** Replace the inlined `_command`/`_with_arg`/etc. helpers
  in `capsules/sfn/cli/tests/cli_test.sfn` with imports from
  `mod.sfn`.
- **Scope.** In: test file rewrite. Out: any non-test change.
- **Acceptance:** all tests pass; `_arg`/`_flag`/etc. private
  helpers removed; coverage is the same set of cases.
- **Size:** S. **Type:** refactor. **Depends on:** 0.5.1 (and any
  fix issue it spawns).

### Phase 1 — capsule API expansion

#### Issue 1.1 — Add parse() non-exiting variant
- **Goal:** Add `fn parse(cmd: Command, argv: string[]) -> ParseResult`
  alongside the existing `run()`. `parse()` does not call
  `process.exit()` and does not print. Existing `run()` calls
  `parse()` internally and exits per the current rules.
- **Scope.** In: `parser.sfn`, `types.sfn` (`ParseResult`,
  `ParseError`), `mod.sfn` re-exports, new tests. Out: any compiler
  change; any rename of `run()`.
- **Acceptance:**
  1. `parse()` returns `ParseResult { ok, matches, error }`.
  2. `error.kind` covers all current `process.exit(2)` paths plus
     `help_requested`, `version_requested`.
  3. `run()` semantics unchanged (delegates internally).
  4. New `tests/parser_test.sfn` covers each `error.kind`.
- **Files:** `capsules/sfn/cli/src/{parser,types,mod}.sfn`,
  `capsules/sfn/cli/tests/parser_test.sfn` (new).
- **Size:** M. **Type:** feature. **Depends on:** 0.5.2.

#### Issue 1.2 — Exit code constants
- **Goal:** Define `EXIT_OK = 0`, `EXIT_BUILD_FAIL = 1`,
  `EXIT_USAGE = 2`, `EXIT_NOT_FOUND = 3`, `EXIT_INTERNAL = 70`
  in `exit_codes.sfn`. Use them in the existing `run()` body.
  Codes follow the loose tooling convention (Rust/Cargo): `1` is
  the generic "operation failed" code, `2` is reserved for usage
  errors, `3` distinguishes "input not found" so scripts/CI can
  branch on missing-file vs. compile-failure without parsing
  stderr. `70` matches sysexits.h `EX_SOFTWARE` for internal
  panics.
- **Acceptance:** constants exported; `run()` uses them; tests pass.
- **Size:** XS. **Type:** feature. **Depends on:** 0.1.

#### Issue 1.3 — NO_COLOR / TTY-aware Style
- **Goal:** Add `Style` struct, `style_for_stream(stream: string)`,
  `no_color_active() -> boolean ![io]`. Existing color helpers
  return plain text when ANSI is disabled. Respects
  `NO_COLOR` env var (per the `no-color.org` convention) and
  `--color=auto|always|never` callers.
- **Acceptance:** `style_for_stream("stderr")` returns disabled
  style when `NO_COLOR` is set; new `tests/style_test.sfn` covers
  both env states.
- **Files:** `capsules/sfn/cli/src/{style,types,mod}.sfn`,
  `capsules/sfn/cli/tests/style_test.sfn` (new).
- **Size:** S. **Type:** feature. **Depends on:** 0.1.

#### Issue 1.4 — print_diag and print_status
- **Goal:** Add `print_diag(severity, message, hint)` and
  `print_status(step, total, message)`. Severities: `error`,
  `warn`, `info`, `hint`.
- **Acceptance:** functions exported; tests cover each severity;
  output matches the rendered-diagnostic prefix in
  `diagnostics_render.sfn`.
- **Size:** S. **Type:** feature. **Depends on:** 1.3.

#### Issue 1.5 — Typed value flags (int, float, path)
- **Goal:** Add `flag_int`, `flag_float`, `flag_path` builders +
  `get_int`, `get_float`, `get_path` accessors. Parse failures emit
  `type_error` with span pointing at the offending argv index.
- **Acceptance:** typed flags round-trip; bad input produces
  structured `ParseError`; tests cover overflow/underflow/empty.
- **Size:** S. **Type:** feature. **Depends on:** 1.1.

#### Issue 1.6 — Choice flags
- **Goal:** `flag_choice(name, choices: string[])` validates the
  value against the list; `get_choice` returns the matched value.
- **Size:** XS. **Type:** feature. **Depends on:** 1.1.

#### Issue 1.7 — Repeating and counted flags
- **Goal:** `flag_repeat` collects multiple values
  (`--include a --include b`); `flag_count` counts boolean
  occurrences (`-vvv` -> 3). New accessors `repeated`, `count_flag`.
- **Size:** S. **Type:** feature. **Depends on:** 1.1.

#### Issue 1.8 — Required flags + missing diagnostic
- **Goal:** `flag_required(f)` marker; parser emits
  `missing_required_flag` if absent.
- **Size:** XS. **Type:** feature. **Depends on:** 1.1.

#### Issue 1.9 — Env-bound flags
- **Goal:** `flag_env(f, "VAR_NAME")`; falls back to env var when
  flag absent. Help text shows `[env: VAR_NAME]`.
- **Size:** S. **Type:** feature. **Depends on:** 1.8.

#### Issue 1.10 — Mutually exclusive and required-one groups
- **Goal:** `flag_group_exclusive(["a", "b"])` and
  `flag_group_required_one(["a", "b"])`; parser validates.
- **Size:** S. **Type:** feature. **Depends on:** 1.1.

#### Issue 1.11 — Variadic positionals
- **Goal:** `arg_variadic(name, description)` collects all
  remaining positionals. `positionals(m)` returns them.
- **Size:** XS. **Type:** feature. **Depends on:** 1.1.

#### Issue 1.12 — `--key=value` and `--` sentinel
- **Goal:** Parser accepts `--out=FILE` and stops flag parsing
  after `--`.
- **Size:** S. **Type:** feature. **Depends on:** 1.1.

#### Issue 1.13 — Structured help tree
- **Goal:** `HelpNode` struct + `render_help_tree(cmd: Command) ->
  HelpNode` and `render_help_text(node: HelpNode) -> string` (the
  current `_format_help` becomes `render_help_text` + a small
  adapter on top of the tree).
- **Acceptance:** existing help output is byte-identical; new
  test covers tree shape (powers future `--help --json`).
- **Size:** M. **Type:** feature. **Depends on:** 0.1.

#### Issue 1.14 — Multi-level subcommands
- **Goal:** Parser walks `with_subcommand(with_subcommand(...))`
  trees of arbitrary depth.
- **Acceptance:** `sfn config get key` (two-level) parses.
- **Size:** S. **Type:** feature. **Depends on:** 1.1.

### Phase 2 — compiler CLI skeleton

#### Issue 2.1 — Add sfn/cli as a compiler dependency
- **Goal:** Add `sfn/cli = "0.2.0"` to `compiler/capsule.toml`'s
  `[dependencies]`. Confirm `build.sh` resolves and stages the
  capsule.
- **Acceptance:** `make clean-build && make compile` succeeds; the
  build log shows `capsules/sfn/cli/src/mod.sfn` being compiled.
- **Size:** XS. **Type:** refactor. **Depends on:** Phase 1
  complete (or at minimum 1.1, 1.2, 1.13 — the items Phase 2 uses).

#### Issue 2.2 — CliContext + driver-prefix parsing
- **Goal:** New `compiler/src/cli/context.sfn` with `CliContext {
  runtime_root, binary_dir, registry_url, trace_argv }`. Move
  `--runtime-root` / `--binary-dir` consumption out of
  `sailfin_cli_main` into `parse_driver_prefix(argv) -> CliContext`.
- **Acceptance:** `CliContext` populated identically to today's
  inline parsing; legacy `sailfin_cli_main` body uses `CliContext`.
- **Size:** S. **Type:** refactor. **Depends on:** 2.1.

#### Issue 2.3 — Skeleton for compiler/src/cli/main.sfn (version only)
- **Goal:** New `compiler/src/cli/main.sfn` exporting
  `sailfin_cli_main_v2(argv) -> number ![io, clock]`. Builds a
  Command via `sfn/cli`, registers only `version`, dispatches via
  `parse()`. Falls through to legacy on every other subcommand.
  Existing `compiler/src/cli_main.sfn:sailfin_cli_main` becomes the
  legacy fallback called from v2.
- **Acceptance:** `sfn version` runs through v2; `sfn build`,
  `sfn run`, etc. unchanged; `make check` green.
- **Size:** M. **Type:** feature. **Depends on:** 2.2.

#### Issue 2.4 — Migrate the version subcommand
- **Goal:** `compiler/src/cli/commands/version.sfn` exports
  `command_def()` and `run(matches, ctx)`. Removes the `version`
  arm from `cli_main.sfn`'s legacy dispatch.
- **Acceptance:** `sfn version` and `sfn --version` both work; tests
  in `compiler/tests/integration/` cover both forms.
- **Size:** S. **Type:** refactor. **Depends on:** 2.3.

### Phase 3 — per-subcommand migration

Each issue follows the pattern:

> Goal: migrate `sfn <name>` to `sfn/cli`. Move the body of
> `handle_<name>_command` into `compiler/src/cli/commands/<name>.sfn`;
> express its flags via `sfn/cli` builders; export `command_def()` and
> `run(matches, ctx)`. Drop the legacy arm from `cli_main.sfn` and the
> `handle_<name>_command` from `cli_commands.sfn`.
>
> Acceptance: subcommand works identically (same flags, same exit
> codes, same output); existing integration tests pass; legacy code
> path is dead (`grep handle_<name>_command compiler/src/` returns
> empty).

| Issue | Subcommand | Size | Depends on |
|---|---|---|---|
| 3.1 | `init` | S | 2.4 |
| 3.2 | `login` | S | 2.4 |
| 3.3 | `guillermo` | XS | 2.4 |
| 3.4 | `fmt` | S | 1.11 (variadic), 2.4 |
| 3.5 | `add` | S | 2.4 |
| 3.6 | `config` | M | 1.14 (multi-level), 2.4 |
| 3.7 | `check` | S | 1.11, 2.4 |
| 3.8 | `test` | S | 2.4 |
| 3.9 | `publish` | S | 2.4 |
| 3.10 | `package` | M | 1.5 (typed flags), 2.4 |
| 3.11 | `emit` | M | 1.12 (`--key=value`), 2.4 |
| 3.12 | `build` | M | 1.5, 1.9 (env-bound), 2.4 |
| 3.13 | `run` | M | 3.12 |

### Phase 4 — legacy removal

#### Issue 4.1 — Move env-flag helpers out of cli_commands_utils
- **Goal:** Move `_env_flag` and `_legacy_flag_file` to
  `compiler/src/env_flags.sfn`. Update `compiler/src/main.sfn`,
  `compiler/src/cli/main.sfn`, and any other consumer to import
  from the new location.
- **Acceptance:** no compiler module imports from
  `cli_commands_utils.sfn` for env helpers; `make check` green.
- **Size:** S. **Type:** refactor. **Depends on:** 3.13.

#### Issue 4.2 — Move filesystem/shell/crypto helpers to stdlib
- **Goal:** Move per the inventory table in section 3.4. Functions
  with a stdlib home (`sfn/fs`, `sfn/path`, `sfn/crypto`,
  `sfn/http`, `sfn/os`) move there; consumers re-import. Functions
  that are genuinely compiler-specific (sfnpkg extraction,
  registry policy) move to `compiler/src/cli/{sfnpkg,registry}.sfn`.
- **Acceptance:** `cli_commands_utils.sfn` has no remaining users;
  `make check` green.
- **Size:** M. **Type:** refactor. **Depends on:** 4.1.

#### Issue 4.3 — Delete legacy CLI modules
- **Goal:** Delete `cli_main.sfn`, `cli_commands.sfn`,
  `cli_commands_utils.sfn`, `cli_check.sfn`. Update
  `native_driver.c` if `native_cli_main`'s symbol moved. Update
  any remaining imports.
- **Acceptance:** `find compiler/src -name "cli_*.sfn"` returns
  empty (post-rename); `make check` green; full test suite green.
- **Size:** S. **Type:** refactor. **Depends on:** 4.2.

### Phase 5 — optional follow-ups (not part of core epic)

#### Issue 5.1 — `--help --json` flag
- **Goal:** Top-level `--help --json` emits `HelpNode` as JSON.
- **Size:** S. **Type:** feature. **Depends on:** 1.13, 4.3.

#### Issue 5.2 — Shell completion generation
- **Goal:** `sfn completion bash|zsh|fish` emits a completion
  script derived from the `Command` tree.
- **Size:** M. **Type:** feature. **Depends on:** 4.3.

#### Issue 5.3 — Unify print_diag with diagnostics_render
- **Goal:** `print_diag` calls into `compiler/src/diagnostics_render.sfn`
  for compiler diagnostics, so CLI errors and compile errors render
  identically.
- **Size:** S. **Type:** refactor. **Depends on:** 1.4, 4.3.

#### Issue 5.4 — Result<Matches, ParseError> migration
- **Goal:** Replace `ParseResult` sentinel with
  `Result<Matches, ParseError>` once `Result<T, E>` and `?` ship.
- **Size:** S. **Type:** refactor. **Depends on:** Phase 1 of
  runtime sequencing (`Result<T, E>` shipping in the language).

## 8. Risks & mitigations

### R1 — Self-host break when adding sfn/cli as a compiler dep
**Severity:** high. The compiler currently imports nothing from
`capsules/sfn/*`. The build script (`scripts/build.sh:400-562`) does
route `sfn/*` deps through `capsules/<scope>/<name>/src/` slugs, but
that path has only ever been exercised for runtime-side deps, not
self-hosted compiler imports.
**Detect:** `make clean-build && make compile` immediately after
Issue 2.1 lands. The first failure mode shows up as a missing-symbol
error at link time (`sfn__cli__mod__parse` not found).
**Mitigate:**
- Make 2.1 a standalone PR with no behaviour change. If it breaks,
  revert is a one-file edit.
- Validate Phase 1 capsule changes do not depend on compiler-tree
  modules (capsule must build standalone).
- If the build script needs a fix, fix it once, in 2.1, before any
  compiler code starts importing from `sfn/cli`.

### R2 — process.exit semantics conflict
**Severity:** medium. `sfn/cli`'s current `run()` calls
`process.exit()` directly. `sailfin_cli_main` returns a `number` exit
code. Mixing the two paths means the migrated subcommands return
codes, while help/version flows still exit out from under the caller
— different semantics for `--version` vs `version`.
**Detect:** integration test that asserts the C driver sees the
returned exit code in both paths.
**Mitigate:** Phase 1 Issue 1.1 introduces `parse()` which never
exits. Phase 2's `sailfin_cli_main_v2` calls `parse()`, prints
help/version itself, and returns a code via `EXIT_*` constants. The
exiting `run()` stays in `sfn/cli` for non-compiler consumers but
the compiler never calls it.

### R3 — Capsule test runner cannot import from mod.sfn
**Severity:** medium. The current capsule tests inline the API
because of (suspected) test-runner import gaps. If true, Phase 0.5
needs a resolver fix before tests can flip.
**Detect:** Issue 0.5.1 is explicitly an investigation; outcome
gates 0.5.2. If broken, file a separate `priority:high` issue
against `compiler/src/runtime_capsule_resolver.sfn` /
`capsule_resolver.sfn` and block 0.5.2 on it.
**Mitigate:** the capsule split (Phase 0) is independent of test
imports — it can ship while 0.5.2 stays blocked. Worst case, capsule
tests stay inlined for a release while we fix the resolver.

### R4 — Performance regression on every CLI invocation
**Severity:** low. The parser runs on every `sfn` invocation. Going
from a hand-rolled `if`-chain to a Command-tree walk adds allocations
and copies (every `with_*` builder copies the Command struct). On a
tree of ~13 subcommands with average ~5 flags each, that is ~65
copies on every invocation.
**Detect:** time `sfn version` and `sfn --version` before and after
Phase 2 lands. Threshold: regress no more than 30 ms wall on a
warm filesystem.
**Mitigate:** the `Command` struct is small (six fields); copies are
cheap. If the bench regresses past threshold, switch the builders to
a single-allocation pattern (mut a stack-local Command, return at
the end) — additive change, no API impact.

### R5 — Stale legacy fallback path during Phase 3 migration
**Severity:** medium. While Phase 3 is in flight, two CLIs run side
by side. A user reporting a flag bug in `sfn build` could be hitting
either path; reproductions are ambiguous.
**Detect:** every Phase-3 PR description explicitly states which
path the bug fix touches; integration tests assert behaviour against
the v2 path once a subcommand has been migrated.
**Mitigate:**
- Add a one-line stderr trace on legacy fallback (`SAILFIN_TRACE_CLI`
  gated): `cli: legacy fallback for <subcmd>`. Removed in Phase 4.
- Phase 3 is sequenced (one issue per command) so the legacy path
  shrinks monotonically.

### R6 — Effect-surface drift
**Severity:** low. Adding env-bound flags (`flag_env`) requires `io`
to read env vars. The capsule's declared effect (`io`) covers it,
but the *parser* itself currently has no `![io]` annotation — it's
pure. We must keep the pure parsing path pure and isolate `![io]`
to the `flag_env` resolution step.
**Detect:** `compiler/src/effect_checker.sfn` flags any leak;
`make test-integration` covers the effect annotations.
**Mitigate:** `parse()` remains effect-free; `parse_with_env()` is a
separate variant marked `![io]` that calls into `parse()` after
populating env values. Or: the parser takes a pre-resolved
`{ name -> value }` env map that the caller fills in (`![io]` at the
call site, pure inside the parser).

### R7 — Builders allocate on every with_* call
**Severity:** low (correctness), medium (perf if hit). The current
`with_arg`/`with_flag`/`with_subcommand` build new arrays via a
manual `loop { push }`, allocating O(n) on every call. Building a
13-subcommand root tree is O(n^2). Acceptable today but worth
flagging.
**Mitigate:** post-Phase-2, if `make bench` flags startup time, add
a mutable-builder variant. Out of scope for this epic.

### R8 — Drift between `_format_help` and `render_help_tree`
**Severity:** low. Issue 1.13 introduces a structured tree and
makes the existing text renderer go through it. Risk: text output
changes byte-for-byte even though the intent was to refactor.
**Detect:** golden-file test in `tests/help_tree_test.sfn` snapshots
the rendered text against today's output.
**Mitigate:** the issue's acceptance criterion is byte-identical
output; the test enforces it. Any formatting cleanup is a separate
issue post-1.13.

## 9. Open questions

These need human input before any of these phases get groomed into
`claude-ready` issues.

1. **Cross-capsule import in tests.** Is the test runner's capsule
   resolver currently functional for `sfn/cli` test imports? If not,
   is fixing it a Phase 0.5.1 prerequisite, or do we ship Phase 0
   with the inlined test alias intact and fix it later?
2. **`--color=auto|always|never`.** Standard CLI convention. Do we
   want this as a top-level Sailfin flag, or per-subcommand? Phase 1
   currently scopes it to env (`NO_COLOR`) only.
3. **`config` subcommand shape.** Today `sfn config <get|set|unset|list> [key]
   [value]` is parsed by hand. Migrating to multi-level subcommands
   (Issue 1.14) is the natural fit. Confirm before sizing 3.6.
4. **`emit` flag ordering.** Today `sfn emit --timing -o foo llvm
   path.sfn` parses positional-after-flags. The `sfn/cli` parser as
   currently designed parses positionals after all flags too, so
   this should be a free win — but the current implementation has
   subtleties around `--module-name SLUG llvm path.sfn` that need a
   targeted test (Issue 3.11).
5. **`sfn/cli` versioning.** Bump to `0.2.0` (additive, but signals
   breaking semantics for `run()` which now returns instead of
   exits) or `0.1.2` (claim API stability)? The plan above proposes
   `0.2.0` because Phase 1 adds many new builders.
6. **Effect annotation on `parse()`.** Pure or `![io]`? If we want
   `flag_env` to live inside `parse()`, the parser becomes `![io]`.
   The plan above proposes keeping `parse()` pure and adding
   `parse_with_env()` for env resolution — but a single function
   may be simpler. Confirm.
7. **Should `compiler/src/cli/util.sfn` exist?** Some path/string
   helpers do not have a clear stdlib home today. Ship them in
   `compiler/src/cli/util.sfn` as a holding pen, or push them into
   `sfn/path` even though `sfn/path` may not yet have a home for
   them?

## 10. Out-of-scope follow-ups

These are not part of the epic but are unblocked by it:

- **LSP server CLI surface.** A future `sfn lsp` subcommand reads
  the same `Command` tree to advertise capabilities. No new design
  needed — once Phase 4 is done, `sfn lsp` is a new entry under
  `compiler/src/cli/commands/`.
- **MCP server tool registration.** The MCP server in
  `tools/mcp-server/` can introspect `render_help_tree` to discover
  subcommands and their flags automatically, eliminating the
  hard-coded tool registry. Issue: post-5.1.
- **`sfn vet` security audit subcommand.** Capsule-aware effect
  audit; reuses `flag_choice` for severity levels. Standalone issue
  post-Phase 4.
- **`--help --json` schema versioning.** Once 5.1 ships, the JSON
  shape becomes a public contract. Add a `schema_version` field
  from day one.
- **Subcommand aliases.** `sfn b` -> `sfn build`. Builder addition,
  one issue, post-Phase 4.
- **Cargo-style global `--manifest-path`.** Lets `sfn build` run
  from anywhere given a path to a `capsule.toml`. Post-Phase 4.

