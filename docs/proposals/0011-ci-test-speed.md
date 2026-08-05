---
sfep: 11
title: Content-Addressed Test Artifacts and Deterministic Suite Partitioning
status: Implemented
type: tooling
created: 2026-05-01
updated: 2026-08-05
author: "agent:compiler-architect (2026-05 plan); agent:Sailbot (2026-08 rewrite); human review"
tracking: "#1012, #1230, #1233, #843 (historical intake); SFN-431, SFN-545, SFN-547"
supersedes:
superseded-by:
graduates-to: site/src/content/docs/docs/reference/spec/11-testing.md
---

# SFEP-0011 — Content-Addressed Test Artifacts and Deterministic Suite Partitioning

> **Amendment, 2026-08-05.** This document was previously titled *"CI Test-Speed
> Plan"* and was not an enhancement proposal. It was three other genres wearing
> SFEP front-matter: a dated status report ("ship this week", a wall-time table
> from one CI run), a CI-configuration plan (fan the matrix, add cache steps,
> assign owners), and a sequencing table with risk columns. None of those are
> design; SFEP-0001 §1 places them in conventions, RCAs, and Linear respectively.
>
> The operational half now lives in `docs/conventions/ci-test-topology.md` —
> shard names, job counts, cache plumbing, gate placement. The one durable
> finding from its `--jobs` benchmark (peak RSS stays flat under test-suite
> parallelism) survives as rationale there; the raw sweep is retired, since it
> justified a hardcoded job count that a computed budget has since replaced.
> What remains here is the design: **why test artifacts are content-addressed,
> what makes that sound, and what was rejected.**
>
> The filename keeps its `ci-test-speed` slug deliberately. SFEP-0001 §2 makes
> `SFEP-0011` the citable identifier, not the path; renaming would rewrite nine
> in-tree citations across `.sfn`, `Makefile`, and workflow files to buy nothing.
> Do not "fix" it.

## 1. Summary

Two mechanisms let the test suite scale without losing coverage, and both rest
on determinism rather than on scheduling.

**Content-addressed test artifacts.** Each test's linked native binary is keyed
by a hash over every input the link consumed. An unchanged test skips LLVM
lowering and the `clang` link — the dominant per-test cost — and re-runs its
cached executable. The binary is always *run*; a pass/fail result is never
cached.

**Deterministic suite partitioning.** `sfn test --shard I/N` splits a discovered
file list by stable stride, and `sfn dev shard` names the CI-facing shard map.
A mandatory cover lint proves the partition is disjoint and exhaustive.

The unifying claim: *a cache is only as sound as the completeness of its key's
input set, and a partition is only as safe as the proof that it covers.* Both
halves of this SFEP are that claim applied twice.

The normative user-facing description of the cache is
[spec §11 "Per-test binary cache"](../../site/src/content/docs/docs/reference/spec/11-testing.md);
the current shard map and job budget are in
`docs/conventions/ci-test-topology.md`. This document is the *why* behind both
and restates neither.

## 2. Motivation

The suite is roughly 90% of CI wall time on a warm build cache, and it grows
monotonically — the surface has gone from ~175 test files to ~708, and from
~1,900 `test` blocks to ~5,285, in the span this proposal has existed. Any
approach that scales with *runners rented* rather than *work actually changed*
loses that race.

Three properties are non-negotiable in fixing it, and they are what make this a
design problem rather than a configuration one:

1. **No coverage may be lost.** A speed-up that silently stops running tests is
   strictly worse than a slow suite, because it converts a red signal into a
   green one.
2. **A stale artifact must never be reused.** A false cache hit produces a
   passing test that did not test the current code — the single worst failure
   mode available to a build system, since it is invisible by construction.
3. **The mechanism must be usable outside CI.** Logic that lives in workflow
   YAML cannot be run locally, cannot be unit-tested, and drifts from the
   runner it partitions.

## 3. Design

### 3.1 The cache key is the whole design

The key is a hash over the test source, the sorted hashes of every transitive
dependency the link consumes, the compiler's identity, the runtime's identity,
the canonicalized `clang` flags, and a schema version. The exact composition is
normative in spec §11 and is not duplicated here.

What matters is the invariant beneath it: **the key's input set must be complete.
Every byte that can change the produced binary must be folded in.** A missing
input is not a performance bug, it is a correctness bug that manifests as a
green test.

Two properties enforce this in practice:

- **The dependency set is not enumerated separately.** It is the resolver output
  that the link *already consumes* for the test's closure. A second, parallel
  enumeration would be a second source of truth, and the two would drift. Using
  the link's own inputs means the key cannot describe a different program than
  the one that was built.
- **The mechanism is a second consumer of an existing model.** Content-addressed
  keying with sorted dep-manifest hashes is what the module IR cache already does
  (`compiler/src/build_cache.sfn`). This introduces no new correctness model,
  only a new consumer of a proven one.

### 3.2 Completeness was got wrong twice, and that is the useful part

The cache schema has reached `v3`. Each bump was an input discovered to be
missing, and recording them is more valuable than the key itself:

- **Compiler identity.** Keying on the version string was insufficient: the build
  stamp's `+dev.<hash>` metadata made byte-identical compilers miss, while
  materially different compilers at the same version could hit. The fix keys on
  the running binary's own SHA-256 with the stamp metadata stripped (SFN-545) —
  identity by *content*, matching the rest of the model.
- **Runtime identity.** A header-only edit under a runtime include root changed
  the produced binary without changing any hashed input; soundness was leaning on
  the assumption that a runtime change would force a compiler rebuild and shift
  the stamp. That assumption was never guaranteed. The fix folds the runtime link
  inputs in by content — sources, prelude, headers under each include root, each
  as `<path>@<sha256>` so distinct inputs cannot alias.

**The generalizable rule: an input that "can only change when something else
already in the key changes" is an assumption, not a guarantee, and belongs in the
key explicitly.**

### 3.3 Fail closed, never fall back

If the running compiler binary cannot be resolved or hashed, the runner
**disables test-bin cache reads and writes for that invocation** rather than
falling back to a weaker identity. A degraded key is worse than no cache: it
preserves the speed-up while silently removing the property that made it safe.
Losing cache hits is a performance outcome; a weakened identity is a correctness
outcome. They are not comparable, so the choice is not a trade-off.

### 3.4 The escape hatch is part of the design, not a debugging flag

`--no-test-cache` bypasses both read and write, forcing a cold lower + link for
every test. Two paths pass it, and being precise about which matters:

- **`make check`** — the full-suite triple-pass gate, run nightly and before a
  release cut. This is the authoritative cold path.
- **The advisory aarch64-Linux lane** — runs a cold full suite on every PR, but
  is `continue-on-error` and excluded from the merge gate, so it *observes* a
  discrepancy without blocking on one.

This is defence in depth with an explicit threat model: §3.1 and §3.2 argue the
key is complete, and §3.2 is the record of that argument having been wrong twice.
So the cold path does not rely on the argument at all, and any escaped staleness
surfaces there rather than at a release. A cache whose soundness cannot be
independently re-checked is a cache that must be trusted; one with a cold path is
a cache that can be *audited*.

The honest limit of this: because the blocking gate is nightly rather than
per-merge, a false hit can live on `main` for up to a day. That is a deliberate
cost — a per-PR blocking cold suite would forfeit most of the cache's value —
but it is a cost, not an absence of one.

### 3.5 Partition by stable stride, and prove the cover

`sfn test --shard I/N` keeps file index `i` when `i % N == I - 1` over a sorted
file list. Deterministic, stable across runs, no coordination between shards, and
no state carried between legs.

A time-balanced bin-pack would produce more even legs, and was not chosen: it
requires per-test timing data that does not durably exist (see §5), it is
unstable — the same file lands in different shards as timings drift, destroying
per-shard cache locality — and it makes "which shard runs this test" unanswerable
without replaying the packer.

**The cover lint is mandatory and is the load-bearing half.** `sfn dev shard
cover` asserts the named shards are disjoint, exhaustive, and contain nothing
outside the surface `make test` discovers. Without it, a rebalance that drops a
group of files produces sixteen green legs and no signal. Every shard map needs
this property; a stride partition merely makes it cheap to prove.

### 3.6 The shard map belongs in the compiler

The map is `sfn dev shard`, not workflow YAML and not a bash script — the earlier
`scripts/test_shards.sh` was retired into it.

Three reasons, in order of weight: the cover invariant is only enforceable if the
map has one representation to check; the map is reusable by `make`, nightly, and
a developer reproducing one CI leg locally; and it is testable
(`compiler/tests/e2e/dev_shard_test.sfn`), which YAML is not. This also runs with
the grain of moving build and test ownership into `sfn` and shrinking the
Makefile/CI bash surface.

## 4. Effect and capability impact

**None on the language surface.** No new effect, no change to the taxonomy, no
change to capability enforcement or the seal.

One interaction is worth stating because it is easy to get wrong: the cache and
the partition both add concurrency, and concurrency interacts with the memory
budget, which is a *fleet* property the per-process cap does not cover. The
per-process `RLIMIT_AS` self-cap bounds one `sfn`; N concurrent children bound
nothing collectively. Any fan-out therefore budgets host RAM itself, and pooled
children are pinned so nested fan-outs cannot multiply (SFN-547). That contract
is owned by `.claude/rules/compiler-safety.md`; this design composes with it and
does not restate it.

Cache writes are atomic (temp file + rename into place), so concurrent legs
racing on the same key cannot half-write an entry. Reads need no lock: under
content addressing, a file present at `<key>` is correct or absent.

## 5. Self-hosting impact

Both mechanisms live in the runner and the cache layer —
`compiler/src/cli/commands/test/` and `compiler/src/build_cache.sfn` — plus
`compiler/src/cli/commands/dev_shard.sfn` for the named map. No language surface
changes: no lexer, parser, AST, typecheck, or effect-checker involvement.

The self-hosting risk is indirect but real, and it is the reason for §3.4. The
compiler is built and tested by the same toolchain this caches. A cache defect
that masked a test-compile regression would hide a self-hosting break rather than
cause one — the failure mode is a *missing* signal. The §3.4 cold paths exist
precisely so the self-host proof never depends on a cache hit.

**A known gap, recorded honestly:** there is no durable time-series for
test-suite wall time, unlike the build-time series in `perf-history.yml`. Per-run
`test_seconds` and `test_bin_hit_rate` are written to the step summary and then
discarded. A regression in cache hit rate or shard balance is therefore currently
detectable only against the same run's own numbers. Closing this is the natural
follow-on to this proposal.

## 6. Alternatives considered

### 6.1 Caching the pass/fail result, not just the binary

**Rejected.** Storing the exit code and skipping the run entirely is faster, and
it trusts that a test with identical inputs is deterministic. Tests are precisely
the code where that assumption is least safe: a flaky-at-runtime test would be
cached green on its first pass and never observed again. Caching the *binary*
saves the dominant cost (lower + link) while preserving the property that every
reported pass corresponds to an execution that actually happened. The remaining
speed-up was not worth converting a flake into a permanent false green.

### 6.2 Timestamp or mtime invalidation

**Rejected.** Not reusable across runners or checkouts — a fresh clone rewrites
every mtime, so CI would never hit — and unsound under branch switching, where a
file can revert to older content with a newer timestamp. Content addressing is
the only model that is both cross-runner portable and monotonic in the right
variable.

### 6.3 Shard selection in CI bash (the original "Seam A")

**Rejected, after shipping.** Selecting a shard's file list with
`find | sort | awk 'NR%2==0'` inside the workflow required no compiler change and
was the fastest way to get value. It was always labelled temporary, and it was
retired for the reasons in §3.6 — chiefly that the cover invariant is
unenforceable when the map has two representations.

Recorded as a genuine sequencing success rather than a mistake: shipping the
throwaway seam first proved the shard shape before any compiler surface was
committed to it.

### 6.4 Intra-shard `xargs -P` fan-out

**Rejected.** Running multiple test processes from one runner via shell
parallelism reintroduces exactly the shared-scratch contention that separate
shard legs avoid, and it requires per-worker isolation of the scratch root to be
safe at all. The in-runner job pool supersedes it: it isolates scratch per child
by construction and budgets memory against actual host RAM.

### 6.5 Trimming PR scope — a curated `smoke` tag on the long-pole OS

**Rejected.** Running only a tagged subset on the slower OS's PR legs, with the
full suite deferred to merge or nightly, was the largest single wall-time lever
available. It is also the only lever that *removes coverage from the PR gate*
rather than doing the same work faster.

It fails property (1) of §2. The mitigations available — full suite on Linux PRs,
full suite on push:main — do not restore the property, they relocate it: a
platform-specific regression would surface after merge instead of before it,
which is a strictly longer and more expensive feedback loop. It also requires
curating and maintaining a tag across hundreds of files, with no mechanism
comparable to the cover lint to detect the curation going stale.

The mechanisms in §3 reached the target without spending coverage, which is what
made this rejectable rather than merely deferred. It should stay rejected unless
someone can propose a *proof* that the smoke set is sufficient — the analogue of
the cover invariant — rather than a curated list.

### 6.6 Accepting a full compiler rebuild per shard leg

**Rejected, after shipping as an interim.** Having each shard leg rebuild the
compiler costs no wall time (legs run concurrently) but multiplies runner-minutes
by the shard count and puts build-time variance on every leg's critical path. The
shipped shape builds once per OS and has the shard legs download the tree.

## 7. Stage1 readiness mapping

Runner and cache work; no language surface, so the codegen rungs are satisfied
vacuously rather than exercised.

- [x] Parses — n/a, no new syntax
- [x] Type-checks / effect-checks — the implementing modules do
- [x] Emits valid `.sfn-asm` — n/a
- [x] Lowers to LLVM IR — n/a
- [x] Regression coverage — see §8
- [x] Self-hosts — in the shipped compiler; the suite runs through this path
- [x] `sfn fmt --check` clean
- [x] Documented — the cache in `docs/status.md` and spec §11 "Per-test binary
      cache"; the partition flags (`--shard`, `sfn dev shard`) in
      `site/src/content/docs/docs/reference/cli.md`. The two halves document in
      different places, which is worth knowing before looking for one in the
      other's home.

**Status is `Implemented`.** Both mechanisms ship end-to-end, are exercised by
every CI run, and carry regression coverage. The alternatives in §6 are rejected
rather than pending, so no commitment in this document's body is outstanding. The
missing wall-time time-series (§5) is a gap in *observability of* this design,
not an unshipped part of it, and belongs to a follow-on issue.

## 8. Test plan

- `compiler/tests/e2e/test_bin_cache_test.sfn` — cache hit/miss behaviour and
  key sensitivity.
- `compiler/tests/e2e/dev_shard_test.sfn` — the named shard map and the cover
  invariant.
- `compiler/tests/e2e/run_cache_flags_test.sfn`,
  `dep_object_cache_test.sfn`, `runtime_obj_shared_cache_test.sfn` — surrounding
  cache-layer behaviour the key composes with.
- **The standing invariant test** is the one no file encodes: a PR editing one
  `compiler/src/*.sfn` must show cache *misses* for every test transitively
  importing it and *hits* for the rest, observable via `test_bin_hit_rate` in the
  `--json` summary. A no-op re-run must show ~100% hits. Any change to the key's
  input set should be checked against both directions by hand, because §3.2 is
  the record of that check being skipped twice.

## 9. References

- **Spec / reference** — [`spec/11-testing.md`](../../site/src/content/docs/docs/reference/spec/11-testing.md),
  "Per-test binary cache" (normative);
  [`reference/cli.md`](../../site/src/content/docs/docs/reference/cli.md) for the
  `--shard` and `sfn dev shard` flag surface
- **Convention** — `docs/conventions/ci-test-topology.md` (shard map, job budget,
  cache plumbing, gate placement)
- **Related SFEPs** — SFEP-0010 (the test framework this partitions and caches),
  SFEP-0044 (runner invocation cache and link-window cost), SFEP-0045 (runner
  architecture, `Draft`), SFEP-0050 (streamed harness↔runner IPC),
  SFEP-0006 (build architecture and the content-addressed module cache this
  reuses), SFEP-0003 §3.1 (toolchain territory map)
- **Rules** — `.claude/rules/compiler-safety.md` (the memory budget this fan-out
  composes with), `.claude/rules/no-bash-e2e.md`
- **Historical intake** — GitHub #1012 (CI sharding), #1230 / #1233 (per-test
  binary cache and self-validating entry keys), #843 (test-infra epic, Track A)
