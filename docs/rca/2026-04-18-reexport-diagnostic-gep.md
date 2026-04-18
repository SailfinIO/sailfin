# RCA: Broken Re-exports Miscompiled `main.sfn` GEP on `%Diagnostic`

- **Date:** 2026-04-18
- **Author:** Opus (with Michael Curtis)
- **Severity:** High — blocked triple-pass `make check`, blocked seed advancement past 0.5.3-alpha.1
- **Affected releases:** 0.5.4, 0.5.5, 0.5.6 (the binary artifacts, not the source history)
- **Fix (merged via `dc3c40e`, as part of `claude/integrate-cli-capsule-6yxod`):** define `starts_with` and `strip_prefix` locally in `native_ir_utils_text.sfn` instead of re-exporting them from `./string_utils`. This gives the `.sfn-asm` real `.fn` entries that consumers' lowering can resolve against.
- **Status:** Workaround merged; underlying compiler bug (re-exports of imported symbols don't emit `.fn` signatures in the re-exporting module's `.sfn-asm`) still present in the binary and needs a real fix tracked as a 1.0 blocker.

## TL;DR

Re-exporting an imported symbol via `export { X }` without a local `fn X`
definition does not emit a `.fn` signature for `X` in the re-exporting
module's `.sfn-asm` artifact. Consumers that import `X` from that module
therefore have no signature to resolve against, so the LLVM lowering falls
back to an `i8*` return type for every call to `X`. When the true return type
is `i1` (any boolean helper), the consumer's generated IR can't produce a
valid conditional branch — the compiler emits `llvm lowering: unable to lower
if condition ...` to `stderr` (non-fatal) and drops the `if` guard on the
floor.

Commit `b9499f1` (the "string utils DRY" refactor) converted
`native_ir_utils_text.sfn` from a module that *defined* `starts_with` /
`strip_prefix` locally into one that only re-exports them from
`./string_utils`. Six files in `compiler/src/native_ir_*` import these
symbols from `native_ir_utils_text`, so every one of their `starts_with(...)`
calls got the `i8*`-return mis-lowering. `parse_layout_manifest` in
`native_ir_api.sfn` is the hottest victim: every `if starts_with(line,
".layout struct ")` / `.layout field ` / `.layout enum ` / etc. guard is
dropped, so the function returns an empty `LayoutManifest` for every
transitively-imported module. That cascade makes structs like `Diagnostic`,
`SymbolEntry`, `LayoutManifest`, `NativeArtifact` never reach
`context.structs`. `render_struct_type_definitions` emits them as
`%Diagnostic = type opaque`. Any by-value use of `Diagnostic` (e.g.
`format_typecheck_diagnostics(entries: Diagnostic[], ...)`) then emits
`getelementptr %Diagnostic, %Diagnostic* ..., i64 ...` which `llvm-as` rejects
with "base element of getelementptr must be sized."

The bug was invisible to CI because CI only exercises a single-pass build
with a pinned-older seed (`0.5.3-alpha.1`, built *before* the refactor) that
does not itself have the re-export bug in its own binary image.


## Impact

- `make check` (the triple-pass fixed-point gate) fails on any machine where
  the seed is advanced past `0.5.3-alpha.1`. The user first noticed when they
  tried to compile with the `0.5.6` seed and got `llvm-as` failures on
  `main.sfn` mentioning `getelementptr` and `Diagnostic`.
- Every release binary produced by `release-tag.yml` between `0.5.4` and
  `0.5.6` is affected, because `release-tag.yml` pins `SEED_VERSION:
  0.5.2-alpha.1`.
- Any downstream user who installed `0.5.4`/`0.5.5`/`0.5.6` and attempted to
  use it as a seed to rebuild the compiler would hit the same failure.
- The self-hosting guarantee is broken for the affected releases: they cannot
  rebuild the sources they were themselves built from.

## Symptom

```text
llvm-as-18: .../main.ll:3268:37: error: base element of getelementptr must be sized
  %t40 = getelementptr %Diagnostic, %Diagnostic* %t37, i64 %t35
                                    ^
```

The IR at the top of the file contains:

```llvm
%Diagnostic = type opaque
```

and 8 other opaque types that should have concrete layouts (`SymbolEntry`,
`NativeArtifact`, `LayoutManifest`, etc.).


## Reproduction

1. Fetch the 0.5.6 seed:

   ```bash
   make fetch-seed SEED_VERSION=0.5.6
   ```

2. Stage the compiler's own import-context (any partial build will do; the
   background build we ran produced
   `build/selfhost/native/raw/tmp/cli_check/seed_cwd/build/native/import-context/`
   which contains every module's `.layout-manifest` and `.sfn-asm`).

3. From that `seed_cwd`:

   ```bash
   ulimit -v 8388608
   timeout 540 build/seed/bin/sailfin emit llvm compiler/src/main.sfn > main.ll
   llvm-as-18 -disable-output main.ll
   # error: base element of getelementptr must be sized
   ```

4. Repeat with the 0.5.3-alpha.1 seed — the same command produces
   `%Diagnostic = type { i8*, i8*, %Token* }` and `llvm-as` passes.

A cheaper reproducer, which skips most of the lowering and isolates the
upstream cause:

```bash
timeout 60 build/seed/bin/sailfin emit llvm compiler/src/native_ir_api.sfn 2>&1 \
  | grep "unknown function"
# test llvm: diagnostic llvm lowering: call to unknown function `starts_with`
# test llvm: diagnostic llvm lowering: unable to lower if condition in
#   `parse_layout_manifest` for `starts_with(line, ";")`
# ... (six more)
```

The same command under the 0.5.3-alpha.1 seed produces no such diagnostics and
emits real `call i1 @starts_with__string_utils` instructions.


## Root Cause

### Layer 1 — source-level trigger

Commit `b9499f1` ("refactor(string_utils): consolidate starts_with,
ends_with, contains_string, strip_prefix") moved four utility functions from
local definitions in `native_ir_utils_text.sfn`, `typecheck_types.sfn`, and
`emit_native_state.sfn` into `string_utils.sfn`. For `native_ir_utils_text.sfn`
specifically, the commit kept `starts_with` and `strip_prefix` in the
module's `export { ... }` block — so the module now *re-exports* two symbols
it only imports, rather than defining them locally.

Six other files in `compiler/src/native_ir_*` continued to import
`starts_with`/`strip_prefix` from `./native_ir_utils_text`, relying on that
re-export:

- `native_ir_api.sfn` (contains `parse_layout_manifest`)
- `native_ir_parser.sfn`
- `native_ir_parser_defs.sfn`
- `native_ir_parser_instructions.sfn`
- `native_ir_utils_layout.sfn`
- `native_ir_utils_parse.sfn`

### Layer 2 — compiler bug

The re-exporter's emitted `.sfn-asm` contains an `export` line for the
re-exported name but **no corresponding `.fn` signature**. Consumers read
imported `.sfn-asm` artifacts to resolve the return type and ABI of every
imported call; when the signature is absent they fall back to `i8*` for the
return type.

For a `string`-returning helper (e.g. `strip_prefix`), that fallback happens
to be numerically right (both `string` and the fallback are `i8*` in the
current ABI), so those calls compile but lose type-checking guarantees.

For a `boolean`-returning helper (e.g. `starts_with`), the real return type
is `i1`. The consumer now has an `i8*` call feeding into a place that
expects `i1`. The lowering gives up with
`llvm lowering: unable to lower if condition in X for starts_with(...)`,
which is emitted to `stderr` as a trace diagnostic — **not a hard error** —
and the entire `if` guard is dropped from the output. The build continues
and produces a binary that runs but is missing control flow.

The visible "`call to unknown function \`starts_with\`" diagnostic comes
from the same site: the consumer's mangler can't decide which module owns
`starts_with` because no `.sfn-asm` actually provides a signature for it.

A commit from earlier in the same week (`7f47f70`, "fix(emit_native_layout):
import contains_string from string_utils") had already documented one half of
this problem: it states that "without an export block, imported symbols
aren't re-exported." The fix for that file was to import directly from the
origin. The assumption that *having* an export block makes re-exports work
held up well enough under `0.5.3-alpha.1` because that seed was itself
compiled from sources that defined `contains_string`/`starts_with`/etc.
locally — the broken path was never exercised across a seed boundary, so
nobody noticed that the emitter simply skips `.fn` generation for
re-exported imports.

### Layer 3 — why it cascades all the way to `getelementptr`

When `parse_layout_manifest` has every line-kind guard dropped, it returns
`LayoutManifest { structs: [], enums: [], diagnostics: [] }` for *every*
transitively-imported module. The direct-import path in `lowering_core.sfn`
survives because it parses structs from the module's own `.sfn-asm` native
text (populated by `parse_native_structs_for_import`, which uses a different
code path). Only depth-1+ imports — where `native_text` is deliberately empty
and we rely on the manifest for struct layout — lose their structs.

Concretely, for `main.sfn`:

- `ast.sfn`, `emit_native.sfn`, `token.sfn`, `toml_parser.sfn` are direct
  imports (depth 0) — 29 structs from these survive into `.struct_info`.
- `typecheck_types.sfn` is reached only transitively through `typecheck.sfn`
  (depth 1) — `Diagnostic`, `SymbolEntry`, `SymbolCollectionResult`,
  `ScopeResult` are lost.
- Similarly `emit_native_layout.sfn` (`NativeArtifact`) and `native_ir.sfn`
  (`LayoutManifest`) are depth-1 and lost.

With the 0.5.3-alpha.1 seed, `parse_layout_manifest` works, the same run
writes 215 entries to `.struct_info`, and every struct lowers to a sized LLVM
type.

### Layer 4 — why it reaches `llvm-as` as an error rather than a silent
miscompile

`render_struct_type_definitions` in `rendering.sfn` emits an opaque forward
declaration (`%Diagnostic = type opaque`) for any type that appears in a
referenced position (function parameter, struct field, etc.) but is missing
from `context.structs`. That alone would be fine — opaque types are legal
when you only pass pointers. The problem is that `main.sfn` contains:

```sfn
fn format_typecheck_diagnostics(entries: Diagnostic[], source: string) -> string[] {
    ...
    let entry = entries[index];
    ...
}
```

By-value indexing and loads on a sized Sailfin struct lower to
`getelementptr ... i64 ...` + `load` on the LLVM type. `llvm-as` rejects both
on an opaque type. This is what finally turned the silent miscompile into a
visible validation failure.


## Timeline

| Date (2026) | Event |
|---|---|
| 04-06 | `6cc02ab` caps transitive import BFS and introduces the manifest-only pathway for depth-1+ imports. This is *correct* — just load struct layouts, skip function bodies. At this point `starts_with`/`strip_prefix` are still locally defined in `native_ir_utils_text.sfn`, so nothing breaks. |
| 04-15 | `02df120` fixes transitive traversal so depth-1 manifests are actually reachable (they were being stranded by a discovery bug). Still no re-exports in play. |
| 04-16 | `0a64170` pins `SEED_VERSION: 0.5.2-alpha.1` in `release-tag.yml`. |
| 04-16 | `397d19c` releases 0.5.3-alpha.1. Source at this point has no re-exports. This binary later becomes the CI pin. |
| 04-17 08:07 | `b9499f1` lands the string-utils DRY refactor. `native_ir_utils_text.sfn` now re-exports `starts_with`/`strip_prefix` instead of defining them. Six consumers start relying on the re-export. |
| 04-17 10:30 | `7f47f70` fixes the `emit_native_layout → emit_native_state → string_utils` variant of the same bug for `contains_string` by importing directly from the origin. The six consumers going through `native_ir_utils_text` are not audited. |
| 04-17 | 0.5.4 released. Binary contains the re-export bug. No local `make check` in release workflow, no attempt to bump seed, so nobody notices. |
| 04-17 16:43 | `162f46e` removes `.condition_locals` IPC. Unrelated, but the determinism gains it claims are real — it is not this bug. |
| 04-18 00:17 | 0.5.5 and then 0.5.6 released. Same bug baked in. |
| 04-18 | User attempts to advance the local seed to 0.5.6, hits `llvm-as` failure on `main.sfn`, files this investigation. |
| 04-18 | `dc3c40e` on `claude/integrate-cli-capsule-6yxod` defines `starts_with`/`strip_prefix` locally in `native_ir_utils_text.sfn` — making the re-exporter's `.sfn-asm` emit real `.fn` entries consumers can resolve. `make check` passes end-to-end on that branch. This is the workaround that ships as the eventual 0.5.7 seed. |


## How This Reached Production (Q1)

### What gates existed

1. **CI `ci.yml`** builds the compiler once using `SEED_VERSION: 0.5.3-alpha.1`
   and runs the test suite on the first-pass binary. The 0.5.3-alpha.1 seed
   was built *before* the refactor, so it does not carry the re-export bug;
   the first-pass binary it produces *does* carry the bug, but CI never uses
   that binary to compile anything, so the bug is invisible.

2. **`llvm-as` validation in `build.sh`** catches invalid IR per-module and
   retries. It would have caught this bug — but only if a *buggy* binary were
   used as a seed. CI doesn't do that.

3. **`make check`** — the triple-pass fixed-point gate — *would* have caught
   this. It builds first-pass from seed, builds seedcheck from first-pass,
   builds stage3 from seedcheck, and compares stage2 vs stage3 IR. A buggy
   first-pass would fail to build a working seedcheck, which would either
   OOM/timeout or produce a binary that can't run `hello-world.sfn`. **`make
   check` is only run locally. It is not a CI gate.**

4. **`release-tag.yml`** does a single-pass build from `0.5.2-alpha.1` seed,
   runs the test suite, and publishes. It has the same blind spot as CI
   (plus, it uses a seed that is *older* than CI's pinned seed — which means
   release binaries are built by a compiler that has not passed CI).

### What should have caught this

There is a ladder of increasingly-strong gates, and we are currently running
only the first rung:

| Rung | Gate | Cost | What it catches | Status |
|---|---|---|---|---|
| 1 | CI single-pass + tests | cheap | "does the first binary run its tests?" | running |
| 2 | CI `make check` (triple-pass fixed-point) | expensive (~30 min) | self-hosting regressions, re-export bugs, IR determinism | **not running** |
| 3 | CI bumps seed forward on each release | ~30 min | detects seeds that miscompile newer source | **not running** |
| 4 | Pre-release audit of re-export sites, dot-file IPC, and cross-module ABI usage | manual review | architecture drift | **not running** |

### Recommended process changes

- **Run `make check` in CI on at least one platform** (the slowest, likely
  macOS, does not need to run it every PR — a nightly or pre-release job is
  sufficient). Without this gate, every self-hosting regression ships. The
  cost (~30 min on beefy CI hardware) is acceptable for a release-blocking
  gate.

- **Advance the CI seed on a cadence and fail loudly if it regresses.** Right
  now `SEED_VERSION: 0.5.3-alpha.1` (CI) and `SEED_VERSION: 0.5.2-alpha.1`
  (release-tag) are two separate pins drifting independently. Add a weekly
  "seed rotation" job that tries the latest release tag as seed and runs
  `make check`. If it fails, investigate *before* cutting the next release
  from that seed.

- **Gate releases on `make check`, not just single-pass tests.** The release
  workflow should do what `make check` does and fail hard if the three passes
  don't converge. Shipping a binary that can't self-host is shipping a
  latent recall.

- **Add a machine-readable self-hosting contract.** At minimum: a test that
  asserts `build/native/sailfin` can compile `compiler/src/main.sfn` and that
  the resulting IR passes `llvm-as` (no retries, no fallbacks). That single
  assertion would have caught this exact failure cheaply enough to run on
  every PR.

- **Write a release-blocker checklist.** The release workflow should refuse
  to tag if any line in `build/selfhost/.../.phase_types_diagnostics` is
  non-empty, if any `retry_log` entry reached `success_after_retry` more
  than N times, or if the stage2/stage3 IR hashes differ. Today these signals
  exist but are warnings only.


## Import / Export Architecture Audit (Q2)

This RCA is the *third* bug in ~10 days rooted in the import/export subsystem.
The pattern is consistent: surface semantics behave well enough for a narrow
set of cases, and the system quietly falls over outside that set. The
subsystem needs a focused audit and a production-ready design before 1.0.

### Known issues with current import/export semantics

1. **Re-exporting an imported symbol via `export { X }` does not emit a
   `.fn` signature for `X` in the re-exporting module's `.sfn-asm`.**
   Consumers that import `X` from that module therefore cannot resolve the
   return type or the callee's mangled symbol, and the lowering silently
   falls back to `i8*`. For `i8*`-returning callees (strings, pointers)
   this is accidentally right. For `i1`-returning callees (booleans) the
   lowering gives up on the enclosing `if` guard with a trace-level
   diagnostic and drops it on the floor. No `.fn` forwarder is emitted,
   no rewrite to the origin's mangled name is emitted, nothing. The
   emitter simply omits re-exported imports from the artifact.

   What the emitter *should* do is one of:
   - (a) emit a local forwarder `.fn X(...)` that body-calls
     `X__origin(...)` and returns its result; or
   - (b) refuse compilation when an `export { X }` cannot be resolved to a
     local definition, with a diagnostic telling the author to import from
     the origin directly.

   Both are defensible; neither is implemented today. Path (b) is simpler
   and matches `7f47f70`'s implicit recommendation.

2. **The module system has no explicit "public" vs "private" distinction.**
   Whether a function is importable depends on whether it appears in the
   `export { ... }` block (if one exists) or whether an export block exists
   at all (in which case every top-level fn is exported implicitly). This is
   a dual-mode design that is trivial to misuse.

3. **Circular re-exports are undefined.** `llvm/expressions.sfn` is
   documented as a "barrel re-export module" and
   `expression_lowering/native/mod.sfn` similarly. We have no test that
   exercises a consumer of a barrel re-export under a seed-boundary.

4. **Transitive import depth is capped at 3** (`max_transitive_depth` in
   `imports.sfn`). This is a performance heuristic that the design doesn't
   justify. If `main.sfn` imports `A`, which imports `B`, which imports
   `C`, which imports `D` — and `D` defines a struct that surfaces through
   `A`'s signatures — the compiler silently falls off the end of the BFS and
   emits opaque types. This is the same failure mode as the bug in this RCA,
   just triggered differently.

5. **Cross-module ABI still requires file-based IPC to work around it.** The
   files under `build/sailfin/` (`.struct_info`, `.enum_info`,
   `.phase_types_diagnostics`, formerly `.condition_locals`) exist because
   the compiler does not trust its own return values across module boundaries.
   These IPC channels are a source of non-determinism and were the visible
   cause of at least one prior release regression (see the determinism delta
   in `162f46e`).

6. **Symbol mangling is context-dependent.** `@starts_with__string_utils` is
   the canonical mangled name, but a caller that imports via
   `./native_ir_utils_text` must either be rewritten or emit a shim. Nothing
   in the spec or source comments pins down which.

### Recommended audit and design work

1. **Inventory every `export { ... }` block in `compiler/src/`** and
   classify each symbol as: (a) defined locally and exported, (b) imported
   and re-exported, (c) imported only. Category (b) is the landmine. Every
   site in (b) is a production incident waiting to happen. The `dc3c40e`
   workaround converted category (b) to (a) for `starts_with`/`strip_prefix`
   in `native_ir_utils_text.sfn`; the same treatment should be applied (or
   a direct-import rewrite performed in every consumer) wherever category
   (b) is found today.

2. **Write a golden test for re-exports.** Three small modules:
   `origin.sfn` defines both a `string`-returning and a `boolean`-returning
   helper, `middle.sfn` imports and re-exports them, `consumer.sfn` imports
   from `middle` and uses each in an `if` guard. Assert that the consumer's
   emitted IR contains calls that resolve to the origin's mangled symbols
   and that the `if` guard survives. The boolean case is critical — that's
   the one the `i8*` fallback masks for string-returning helpers. Run on
   every PR. This test would have caught the current bug on the commit
   that introduced it.

3. **Decide on a canonical re-export semantics** and document it in
   `docs/spec.md` and the compiler:
   - **Option A**: re-exports of imported symbols are permitted and emit a
     local forwarding shim. Simpler for users; costs one extra indirection
     per re-exported call.
   - **Option B**: re-exports of imported symbols are *disallowed*; each
     consumer must import from the origin. Simpler for the compiler; forces
     consumers to know the ultimate source of every symbol.
   - **Option C**: re-exports rewrite import tables. Zero cost at runtime but
     complicates caching and the `.layout-manifest`/`.sfn-asm` format.

   My recommendation is **Option B for 1.0** (with a lint/error to catch
   accidental re-exports) and re-evaluate for a post-1.0 milestone. It is
   the least surprising of the three, has no ABI cost, and the `7f47f70`
   commit already set the precedent by importing from the origin.

4. **Reduce transitive import depth to the minimum required** and treat
   "depth N+ reached" as a hard error, not a silent truncation. If a module
   needs a symbol that lives at depth 4, we should fail the compile with a
   clear message ("type X at path Y is reachable only at depth 4; import it
   or raise `max_transitive_depth`"), not emit `type opaque` and hope.

5. **Audit file-based IPC channels.** `162f46e` removed `.condition_locals`
   and documented a 9-step procedure for safely removing channels. Apply
   that procedure to the remaining channels on a schedule (`.struct_info`,
   `.enum_info`, `.instr_fn_name`, the `.let_*` and `.call_result_*` family)
   and replace each one with in-memory data once the ABI corruption is
   actually gone.

6. **Write a small architectural proposal**
   (`docs/proposals/module-system-1.0.md`) describing: what a module is,
   what an export is, what an import is, how symbol resolution happens
   across modules, how transitive imports work, how re-exports work, and
   what the `.sfn-asm` / `.layout-manifest` artifacts actually represent.
   Pre-1.0 is the time to lock this down. Today these are emergent from the
   code; that's how we got here.


## Other Lessons Learned (Q3)

### The file-IPC recovery mechanisms are masking more than they admit

`render_struct_type_definitions` falls back to `recover_struct_types_from_file`
only if it detects `% = type ...` corruption (empty struct name). It does not
detect *missing* structs. In this bug, the structs simply weren't present —
the recovery never fired, and the opaque types made it all the way to
`llvm-as`. **Every file-IPC recovery path should log when it runs and when it
bypasses**, so we can see drift between the in-memory and file-based states.

### Diagnostics at lowering time are informational, not fatal

The 0.5.6 compiler emits
```
test llvm: diagnostic llvm lowering: call to unknown function `starts_with`
test llvm: diagnostic llvm lowering: unable to lower if condition in parse_layout_manifest for starts_with(line, ";")
```
…*eight times*, and keeps going. A call that can't be lowered should be a
compile error unless an escape hatch is explicitly requested. This is the
same category of problem as "parsed but not enforced" language features — the
compiler produces output that looks successful but has silently lost meaning.
The diagnostics ended up in `stderr` as trace output and were discarded.

**Recommendation:** promote "call to unknown function" and "unable to lower
if condition" to hard errors by default. Add a `--allow-incomplete-lowering`
flag if any bootstrap scenario genuinely needs the current behaviour.

### The seed lineage is undocumented

Today we have four seed versions in active use:
- `0.5.2-alpha.1` (release-tag workflow)
- `0.5.3-alpha.1` (CI)
- `0.5.6` (latest release, user's local)
- Unknown others on developer machines

Nothing asserts that these are compatible. Nothing asserts which seeds have
known-good behaviour for which code patterns. There is no "golden" seed with
a verified self-hosting guarantee.

**Recommendation:** pick one seed (the most recent one that passes
`make check` against the next source snapshot) and pin *both* CI and
release-tag to it, then bump forward only after a successful make-check run.
Document the bump in the release notes.

### Refactors that touch import graphs need a specific review lens

`b9499f1`'s commit message correctly describes the code change ("moved
functions, added re-export"), but it doesn't mention the import graph
implications. Reviewers (human and LLM) focused on correctness of the moved
code, not on whether the new import topology was compiler-safe.

**Recommendation:** add a `.claude/rules/import-graph-discipline.md` (or
extend `change-discipline.md`) with a check: "if this diff touches an
`export { ... }` block or adds a re-export, run the self-hosting triple-pass
locally or request it in CI before merging."

### The user's instincts were exactly right

The two PRs the user flagged as suspect in the initial message were
`b9499f1` (string-utils DRY) and `162f46e` (condition_locals IPC removal).
The actual bug is in `b9499f1`. The IPC PR is unrelated — it's the one that
made macOS arm64 determinism *better*, not worse. The pattern-matching was
correct because "refactor that rearranged how symbols flow across modules" is
exactly the class of change that breaks self-hosting.

This is worth internalising as a review heuristic: any refactor that moves
exported symbols between files deserves a seed-boundary check, even if the
CI signal is green.

### The bug was reproducible in under two minutes after the mechanism was
understood

Once we knew the failure mode was "call to unknown function" on a
re-exported symbol, the minimal reproducer is:

```bash
timeout 60 build/seed/bin/sailfin emit llvm compiler/src/native_ir_api.sfn 2>&1 \
  | grep "unknown function"
```

This runs in under 30 seconds and does not require a full build. Any
CI-equivalent health check that runs this single emit on every module
after a build would have caught the bug immediately. Add this to CI as a
cheap pre-check.

## Links

- Fix branch: `claude/debug-compiler-determinism-6GVN0`
- Triggering commit: `b9499f1` refactor(string_utils): consolidate starts_with, ends_with, contains_string, strip_prefix
- Related commits: `7f47f70` (partial fix for the same class), `162f46e`
  (unrelated, user-flagged)
- Affected releases: `v0.5.4`, `v0.5.5`, `v0.5.6`
- CI pin (unaffected seed): `.github/workflows/ci.yml` — `SEED_VERSION: 0.5.3-alpha.1`
- Release-tag pin (buggy seed): `.github/workflows/release-tag.yml` — `SEED_VERSION: 0.5.2-alpha.1`
