# Design note — SFN-148: parent pre-warm of the dep-closure module `.ll` cache

Successor to **SFEP-0044** (`0044-test-runner-invocation-cache.md`, Implemented)
— realizes dep-closure *compile* sharing, which SFEP-0044 tracked as `#2010` and
kept distinct from its work item C (resolver-pass sharing = SFN-141, gated on
proposal 0006). This is a design-note, not a new SFEP: no language/ABI/parser
change, no seed dependency, modest driver-only surface.

## Problem

`sfn test <files> --jobs N` (`compiler/src/cli/commands/test.sfn`, `fn run`
multi-file branch, ~583) spawns a bounded pool of N children, each of which
runs `prepare_project_capsules_for_test([its_file], …)` and compiles the shared
compiler dep closure (parser/typecheck/effect_checker/…). On a **cold** shared
module `.ll` cache the first concurrent wave all LLVM-emit the same closure
before any cache write lands — an 8× CPU / 5.8× wall stampede at jobs 8.

## Decision: (a) parent pre-warm — rejected (b) single-flight lock

Before fanning out children, the parent resolves the **union** dep closure across
all test files (per resolver group) and compiles each unique module once into the
shared content-addressed `.ll` cache, mirroring the shipped runtime-identity-stamp
warming (`test.sfn` ~644–670, SFEP-0044 work item A). Children then all cache-hit
and skip the emit.

**Why not (b) single-flight lock.** No cross-process exclusive-create / `flock`
primitive exists in the runtime today: `_ensure_dir_cmd` is `mkdir -p` (idempotent,
not exclusive) and cache stores are temp+rename (`build_cache.sfn`
`cache_store_artifact`, `build/fs.sfn` `_atomic_rename_into_place`). (b) would
require a **new runtime primitive** (`O_CREAT|O_EXCL` / `flock`) plus stale-lock
crash recovery, and it would touch the general `cache_store_artifact` path used by
every build (large blast radius). (a) reuses `_cr_resolve_and_dedupe` +
`compile_capsule_modules` verbatim, needs no new primitive, and mirrors shipped
precedent — smaller and self-hosting-safe.

## The cache-key parity constraint (load-bearing)

Children call `prepare_project_capsules_for_test(entry, consumer, "", "", binary_dir)`
(`test.sfn` ~1028): `sailfin_exe=""`, `work_dir=""`, real `binary_dir`. The module
`.ll` cache key mixes `cache_compiler_identity(version, effective_exe)`
(`capsule_resolver.sfn` ~1742), where `effective_exe =
_cr_effective_isolation_exe(sailfin_exe, binary_dir, source_count)`. For the heavy
closure (source_count ≫ 16 threshold) that resolves to `binary_dir + "/sailfin"`.

Therefore the parent warm **must pass the identical trailing arguments**
(`sailfin_exe=""`, `work_dir=""`, same `binary_dir`) so `_cr_effective_isolation_exe`
derives the same `effective_exe`, yielding identical keys — otherwise (e.g. passing
`self_exe` directly) a `.dirty` dev stamp would key the warm entries differently
and children would miss them. Passing `""`+`binary_dir` also gives the parent
subprocess-per-module isolation + parallel-fan for free (large closure ⇒ non-empty
`effective_exe` ⇒ `go_parallel`), so the parent warm neither OOMs nor serializes.

The warm call is thus byte-identical to the child's line 1028 except `entry_paths`
is the whole group's file list. That multi-file-group shape of
`prepare_project_capsules_for_test` is already the exercised in-process path
(line 1028), and it only resolves + compiles module `.ll`s (no link, no run), so it
sidesteps the resolver-union execution conflict (`test.sfn` ~560) that the
subprocess fan-out exists to avoid.

## Gating (no regression to warm / serial / single-file)

- Multi-file branch only (already guaranteed at ~583).
- `jobs > 1` only: serial already warms via child[0]; pre-warm there just adds a
  redundant union resolve with no benefit.
- Best-effort / non-fatal: on `staging_failed` (or `has_collision`) log a warning
  and continue — children fall back to today's behavior; correctness never depends
  on the warm succeeding.
- Warm-when-already-warm cost is one union resolve (O(closure), `#1247`
  scan-memoized) + all-hit lookups (no emit) — bounded, comparable to the JSON
  pre-parse the parent already does at ~680.

## Emit-ledger observability (for the regression test)

Gate an append-only emit ledger behind `SAILFIN_EMIT_LEDGER=<path>` at the single
store choke point `cache_store_artifact` (`build_cache.sfn` ~838), on the success
path only: when the env is set and `kind == "ll"`, append `<digest>\n` via
`fs.appendFile` (implemented as `fopen(..., "ab")` = `O_APPEND`, so the short
~65-byte line is a single atomic `write()` — non-interleaving across the concurrent
parent + child appenders; no per-store subprocess, no new runtime primitive; when
the env is unset the only added cost is one in-process `getenv`). A store fires only
on a cache **miss → emit**, so a duplicate digest in the ledger is exactly a
stampede. Order-independent set-uniqueness makes the assertion non-flaky under the
pool. The regression additionally asserts the ledger is non-empty on a clean exit,
so a change that suppresses all emits cannot pass vacuously.

## Effects / self-hosting

All changes are `![io]` build/test-driver code (`test.sfn`, `build_cache.sfn`);
no new effects, keywords, or pipeline-pass changes. `make compile` self-hosts from
the old seed in one pass (the driver *is* the compiler; no cross-consumer seed
gate — one PR). No change to test-bin cache semantics or `--no-test-cache` (module
`.ll` cache is orthogonal), so `make check` stays cold-by-policy for test-bins.
