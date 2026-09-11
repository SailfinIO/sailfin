---
sfep: 0077
title: CI Source Scope by Dependency Closure, and the Member Lane
status: Accepted
type: tooling
created: 2026-09-11
updated: 2026-09-11
author: "agent:compiler-architect; human review"
tracking: "SFN-1278"   # SFN-1279 is the opposite-direction examples gap
supersedes:
superseded-by:
graduates-to: docs/conventions/ci-test-topology.md
---

# SFEP-0077 — CI Source Scope by Dependency Closure, and the Member Lane

## 1. Summary

`ci.yml`'s `ci-scope` job answers "does this PR need the compiler matrix?" with
"did any of the 31 workspace members change?". That predicate is wrong in one
direction: 16 of the 31 members are not in the compiler's transitive dependency
closure, and changing one cannot affect the compiler binary, the runtime, or
any test outside its own capsule. Today a one-line edit to `stdlib/tensor`
spends `check-fast`, three compiler builds, eight Linux shards, five packed
macOS legs, the aarch64 cross+native lane, and the Windows legs — six of them
on a macOS pool with account-wide concurrency 5.

This proposal replaces the member-root predicate with a **CI source closure**
computed by a fixed-point walk over `[dependencies]` — *the same walk the
script already performs* for `--ci-freshness`
(`scripts/module_layout_fingerprint.sh:342-370`) — and adds a third scope
verdict between "full matrix" and "nothing": a **member lane** that builds the
compiler once on Linux and runs the entire member test surface (~5.2% of suite
share) in one leg. `required-ci` gains a lane-aware branch so a member-scoped
PR reports green for the lane it earned and says so in the summary, never
advertising a compiler-level result it did not run.

## 2. Motivation

### 2.1 The current predicate

`.github/workflows/ci.yml:113` expands `[workspace].members` to all 31 member
roots and `:131-141` sets `source=true` when any changed path falls under any
of them. There is no dependency reasoning anywhere in the job.

The closure, computed from every member's `capsule.toml [dependencies]`:

| Set | Members | Count |
|---|---|---|
| Compiler closure | `sfn/compiler`, `sfn/syntax`, `sfn/ir`, `sfn/analyzer`, `sfn/codegen`, `sfn/codegen-llvm`, `sfn/runtime-native`, `sfn/cli`, `sfn/strings`, `sfn/crypto`, `sfn/archive` | 11 |
| Added by `sfn/test` | `sfn/test`, `sfn/fs`, `sfn/os` | 3 |
| Added by fixture manifests | `sfn/http` | 1 |
| **Outside (the member lane)** | `sfn/bench`, `sfn/device`, `sfn/json`, `sfn/layers`, `sfn/log`, `sfn/losses`, `sfn/math`, `sfn/net`, `sfn/nn`, `sfn/path`, `sfn/prelude`, `sfn/sync`, `sfn/tensor`, `sfn/time`, `sfn/toml`, `tools/repo-tooling` | 16 |

Roots: `compiler/capsule.toml` declares ten capsule dependencies;
`runtime/capsule.toml:132` declares `sfn/crypto`; `sfn/cli`, `sfn/crypto` and
`sfn/archive` each depend on `sfn/strings`. `sfn/http` is deliberately *not* a
compiler dependency (`compiler/capsule.toml:63-68`, SFN-496 bare-name
collision between `sfn/http`'s `get(url)` and `sfn/cli`'s `get(m, name)`);
it enters only through a test fixture, see §3.3.

Three of the 16 are entirely inert in-tree: `sfn/prelude` and `sfn/toml` have
zero in-tree importers (the compiler carries its own
`compiler/src/toml_parser.sfn`), and nothing depends on `tools/repo-tooling`.

`sfn/crypto` is **not** an example of over-scoping and must not be used as one:
both `compiler/capsule.toml` and `runtime/capsule.toml:132` declare it, so it
is genuinely in the closure and a crypto PR genuinely needs the full matrix.
`stdlib/tensor` and `stdlib/json` are the honest motivating cases.

### 2.2 Why it costs what it costs

`.claude/rules/pr-discipline.md` records the measurement: one in-scope PR asks
for six macOS job-slots against an account-wide pool of five, and a measured
window on 2026-08-28 had run `33190689012`'s `Build compiler [macos-arm64]`
waiting **136.2 minutes** to start an 11.9-minute build. Every ML-capsule or
`sfn/json` PR that takes those six slots is displacing a compiler PR that
actually needs them.

### 2.3 This is the same defect, fixed once already

**SFN-484** (Done, priority High) fixed a two-dot `git diff` in this exact job
that made docs-only PRs run the full compiler matrix. Same file, same class of
over-scoping, same cost. The remaining half is that the *path→scope* mapping
itself is coarser than the dependency graph the build actually obeys. The
three-dot fix removed paths that were never in the PR; this removes paths that
are in the PR but cannot reach the compiler.

## 3. Design

### 3.1 Where the closure is computed: bash, in the existing script

**`sfn dev inventory` is ruled out.** `ci-scope` runs before any compiler or
seed exists in the job — it fetches no seed anywhere. **SFN-1160** (Ready,
Project "Repo Tooling Ownership", Design: SFEP-0074 §8.4 Phase A) names it
explicitly under *Out of scope*, alongside `release.yml`'s "Stage version bump"
and `release-train.yml`, as one of the three permanently-bash pre-seed jobs.
SFEP-0074 §8.4 calls the same three "Permanent Tier 3 residue". The closure
must therefore be computable from manifests alone, with no toolchain.

**The graph walk is already in the script, and it is already load-bearing.**
The "is a resolver in scope for a layout-fingerprint script?" judgment was made
when `--ci-freshness` shipped: `module_layout_fingerprint.sh:346-360` extracts
`owner<TAB>dependency` edges from every `[dependencies]` block
(`:235-243`) and iterates a fixed point from the compiler-role and
runtime-kind members, because "the self-hosted compiler and runtime link
workspace library dependencies, so their transitive source closure must
invalidate caches and nightly ancestry" (`:342-344`). This proposal
**generalizes an existing walk over an existing edge list**; it adds no new
class of logic to the script.

**A native twin is not required and should not be built for this.** SFN-1174
(SFEP-0074 §8.4 Phase B) adds native `--member-roots`/`--member-records`/
`--public-members`/`--member-manifest`/compiler-manifest views. Its stated
invariant — "exactly the canonical compiler-role capsules, all non-publishable"
— is a **manifest-attribute predicate**, not a graph walk, and is deliberately
narrower than this closure: `sfn/strings` is in the closure and is not a
compiler-role capsule. The new view should ship as a **bash query only**. Its
sole consumer is `ci-scope`, which SFN-1160 has already classified as permanent
bash; a native twin would be a second implementation with no caller, which is
the exact drift failure SFEP-0074 §8.4's "Rejected: keep whole" paragraph
argues against. If a post-seed caller ever appears, the twin must agree
**set-for-set**, not byte-for-byte — this view feeds a boolean decision, not a
cache key, so the byte-for-byte discipline SFEP-0074 §8.4 Phase C imposes on
digest modes does not apply.

### 3.2 The closure roots

Three root sources, unioned, then closed transitively over `[dependencies]`:

1. **Compiler-role members** — `sfn/compiler`, `sfn/syntax`, `sfn/analyzer`,
   `sfn/ir`, `sfn/codegen`, `sfn/codegen-llvm` (the existing
   `module_layout_fingerprint.sh:347` predicate).
2. **`[build] kind = "runtime"` members** — `sfn/runtime-native` (same line).
   Verified: `runtime/capsule.toml:59-100` lists 44 `sfn-sources`, every one
   under `runtime/sfn/`, and the per-target `sfn-sources-replace`/`-add` blocks
   (`:148-237`) add no stdlib path. `compiler/capsule.toml:104` sets
   `full-runtime = true`, forcing the demand set to `"*"`, so the compiler
   links *all* of them — which is why the runtime's own `sfn/crypto` edge
   reaches the compiler and why no stdlib path sneaks in by the back door.
3. **`sfn/test`** — **include it.** 468 `*_test.sfn` files import it; it is a
   build input to every test binary CI links, and its own deps (`sfn/strings`,
   `sfn/fs`, `sfn/os`) are inputs to all 817 compiler test files. Excluding it
   would mean a `stdlib/os` change skips the entire compiler suite that links
   against it. The cost of including it is that `stdlib/fs` and `stdlib/os`
   PRs keep the full matrix, which is correct: they are compiled into every
   test binary in the tree.

Plus one augmentation that is not a `[workspace].members` manifest:

4. **Fixture manifests under `compiler/tests/`.** Two exist with a
   `[dependencies]` block; one,
   `compiler/tests/e2e/fixtures/stateful_http_users_server/capsule.toml`,
   declares `"sfn/http" = "*"`. Without this root, a `capsules/sfn/http` PR
   would take the member lane and never run the e2e test that compiles that
   fixture. Seeding the walk from every `capsule.toml` under `compiler/tests/`
   is a manifest-only operation reusing the same awk at `:235-243` — not an
   import scan, not a resolver.

The union is **15 of 31 members**. Every capsule imported anywhere under
`compiler/tests/` — `sfn/{test,strings,syntax,fs,ir,os,crypto,codegen,cli,archive,http,analyzer}`
— is inside it. §8.1 makes that a standing assertion rather than a snapshot.

### 3.3 The classification is three-valued, and fail-closed at every edge

`ci-scope` today computes one boolean per changed path. It now computes a
verdict per changed path, in this order, first match wins:

| # | Condition | Verdict |
|---|---|---|
| 1 | path under an **in-closure** member root | `full` |
| 2 | path matches an always-full glob (`compiler/tests/*`, `scripts/*`, `.claude/hooks/*`, the four named workflow files, `.github/actions/*`, `.github/release-signing/toolchain-index-state.json`) — `ci.yml:142-150`, unchanged | `full` |
| 3 | path is a `--layout-inputs` entry not under any member root (`workspace.toml`, `bootstrap.toml`) | `full` |
| 4 | path under a **member glob parent** (`stdlib/`, `capsules/sfn/`, `compiler/capsules/`, `tools/`) but **not** under any head member root | `full` — the add/rename/remove guard, §3.6 |
| 5 | path under an **out-of-closure** member root | `member(<name>)` |
| 6 | otherwise | `none` |

Then:

- `source = true` iff any path scored `full` (identical meaning to today's
  output; every existing `if: needs.ci-scope.outputs.source == 'true'`
  expression keeps working unchanged).
- `member_scope = true` iff `source == false` **and** at least one path scored
  `member(...)`.
- New output `lane` ∈ `full | member | none`, for the summary and for
  `required-ci`.

Ordering is load-bearing. Rule 1 before rule 5 means a PR touching **both** an
in-closure and an out-of-closure member takes `full`. Rule 4 before rule 5
means a path under `stdlib/` that head cannot attribute to a member is `full`,
never `member` and never `none`.

**The existing empty-inventory guard (`ci.yml:124-127`) keeps its shape and
gains a sibling.** Today: empty `workspace_roots` or `workspace_inputs` →
`::error::Workspace inventory is empty; refusing to narrow CI scope` and exit 1.
Add: an empty closure, or a closure that is not a strict subset of the member
roots, is the same error. The script's own guards
(`module_layout_fingerprint.sh:135-138` empty members, `:183-199` missing or
unnamed manifest, `:196-199` duplicate name) already `exit 2`, and `set -euo
pipefail` in the step propagates that. Every failure mode widens or errors;
none narrows.

### 3.4 Reverse dependencies are provably inside the lane

**Lemma.** If member `m` is outside the closure `C` and member `d` depends on
`m`, then `d ∉ C`. Proof: `C` is closed downward over `[dependencies]` from its
roots; if `d ∈ C` then `m ∈ C`, contradiction. ∎

So a changed out-of-closure member's dependents are themselves out-of-closure
members — never the compiler, never the runtime, never a test capsule. Today
the reverse-dependency set is empty (every out-of-closure member is a leaf;
`tools/repo-tooling` depends on `sfn/cli` + `sfn/strings` and nothing depends
on it), but the lemma is what makes §3.5's "run *all* member tests" the right
lane content rather than a guess.

### 3.5 What the member lane runs

**Per-capsule test selection already works. There is no prerequisite.** `sfn
test` takes variadic suite paths (`compiler/src/cli/commands/test/mod.sfn:218`,
`arg_variadic("suite", ...)`), discovery walks a directory for `*_test.sfn`
(`compiler/src/cli/commands/test/discovery.sfn:28-89`), and every member's
tests live at `<member>/tests/` — verified for all 20 members that have them.
`sfn dev inventory member-tests`
(`compiler/src/cli/commands/dev_inventory.sfn:29-31`, backed by
`workspace_inventory.sfn:285-294`) already emits exactly those roots, with
`compiler/tests` excluded by `_wi_member_test_overlaps_cross_domain`. A `-p` /
`--package` flag is **not needed and should not be added for this**.

The lane runs the **whole member test surface**, not just the changed member's:

```
build/bin/sfn test $(build/bin/sfn dev inventory member-tests) --jobs 3
```

Why all of them rather than the changed subset:

- It is the existing `int-caps` shard minus `compiler/tests/integration`
  (`compiler/src/cli/commands/dev_shard.sfn:90-99`), so it is proven-covered
  surface with an existing cover lint, not a new partition to prove.
- It moots §3.4's reverse-dependency question permanently.
- It is cheap. `compiler/tests/shard_weights.tsv` scores the 105 weighted
  member test files at **52,097 / 1e6 = 5.2% of suite share**; against the
  table's recorded `linux-arm64(880 files, 5088s)` total that is ~265 s
  serial on the *slower* Tier-2 target, so well under five minutes on
  linux-x86_64 at `--jobs 3`. Selecting a subset would save seconds and cost a
  correctness argument.
- It is post-seed — the lane job holds `build/bin/sfn` built from this very
  tree — so `dev inventory` is the correct caller here, exactly per SFEP-0074
  §8.4 Phase A's "zero seed-lag risk because the binary in hand is built from
  the current source".

**Jobs.** Two, both Linux:

1. `build-compiler-linux` — widen its `if:` from `source == 'true'` to
   `source == 'true' || member_scope == 'true'`. It already uploads
   `ci-build-tree-linux-x86_64`.
2. **New `member-tests-linux`** (`name: Member tests [linux-x86_64]`),
   `needs: [ci-scope, build-compiler-linux]`, `if: member_scope == 'true'`.
   Downloads and extracts the shared tree (same steps as `build-linux`
   `:1440-1460`), restores `test-bin-Linux-member-…`, runs the command above.

No macOS, no aarch64, no Windows, no shard fan-out, no `check-fast` (its
`--compiler-sources` view is compiler-only and the PR touched none of it), no
`shard-cover` (the shard map is unchanged by a member edit).

**Rejected: run the lane on the pinned seed and skip the compiler build.**
Cheaper still (one runner, no build), and it is what `check-fast` does. It
loses to seed lag: stdlib capsules adopt new language features, and a member
whose source compiles under head but not under the pinned seed would fail the
lane for a reason the PR did not cause. `build-compiler-linux` is the same
build the full lane already pays for and warm-caches at ~1.5 min.

### 3.6 Escape hatches and edges

**Both an in-closure and an out-of-closure member changed.** Rule 1 precedes
rule 5: `full`. No mixed lane exists.

**`workspace.toml` or `bootstrap.toml` edited.** Rule 3: `full`. These are
`--layout-inputs` entries under no member root, and either can change the
member set or the seed.

**A member added.** Its files sit under a glob parent and under a head member
root (the glob expands at head), so rule 5 scores `member(...)` if it is out of
closure — correct — and its `capsule.toml` is under its own root. If the new
member is in the closure (someone adds a compiler dependency), the edit to the
*depending* manifest is under an in-closure root → `full`.

**A member renamed or moved across roots.** Deleted paths under the old root
are no longer attributable at head. Rule 4 catches them: they are under a glob
parent with no head member root, so `full`. This also closes a pre-existing
hole — today an unattributable `stdlib/...` path scores `false` and runs
nothing.

**A manifest edit that changes the closure.** The closure is computed from the
**head** tree, which is the tree being tested. A PR that only edits an
out-of-closure manifest cannot move anything *into* the closure (adding a dep
on an in-closure member does not make the depender a dependency of the
compiler), and a PR that adds an out-of-closure member to an in-closure
manifest necessarily touches that in-closure manifest → rule 1 → `full`. Head
is therefore sufficient; no base-vs-head closure diff is needed.

**`public_claims` stays independent.** It is a separate `case` over the same
loop (`ci.yml:154-158`) keyed on `README.md`, `CLAUDE.md`, `docs/proposals/*`,
`docs/strategy/*`, `examples/README.md`, `llms.txt`, `site/src/*`,
`site/examples/*`, `site/scripts/*`, `site/package.json`, `bootstrap.toml`,
`install.sh`, `install.ps1`, and two workflow files. None of those is a
workspace member path, so this design does not touch it. A member-lane PR that
also edits `site/src/*` still runs `check-public-claims`, and `required-ci`
scores it in its own branch exactly as today. **Confirmed independent.**

**`windows` stays independent.** `windows_roots` is built from
`--member-records` for `sfn/codegen`, `sfn/codegen-llvm`, and the runtime
(`ci.yml:119-123`) — all three in the closure, so any Windows-relevant member
change already scores `full` under rule 1. The `windows` output is unmodified.

**The merge queue is untouched.** `merge_group` has no `paths:` support, and
`ci-scope`'s classification lives inside `elif [ "${GITHUB_EVENT_NAME}" =
"pull_request" ]` (`ci.yml:204`); every other event keeps the `source=true`
default set at `:190-196`. A queued merge runs the full matrix, by construction
and deliberately (SFEP-0037 §3.1). **Confirmed unchanged.** Note the queue is
not yet enabled (`docs/runbooks/merge-queue.md` §1 is an owner action), so it
is not a backstop this design may lean on today — §10 covers what is.

**The draft lever composes, it does not change.** `ci.yml:216-238` forces every
scope output false when `PR_IS_DRAFT` is true. `member_scope` and `lane` join
that list (`member_scope=false`, `lane=none`), and `required-ci`'s
`READY_CI == false` branch keeps failing closed first. One lever that forces
every output false must keep forcing *every* output false; adding an output
that survives it reintroduces the gap that branch exists to remove.

**`examples/` is out of scope for this design.** `examples/web/*.sfn` import
`sfn/http` and are compiled by `scripts/check-examples.sh` on the `build-linux`
primary leg (`ci.yml:1579`), yet no `examples/*` path appears in either the
`source` or `public_claims` glob lists — only `examples/README.md`. That is a
pre-existing gap in the *opposite* direction (under-scoping) and this proposal
neither widens nor narrows it. Worth a separate issue; do not fold it in.

### 3.7 Required-check semantics

`required-ci` (`ci.yml:2766`) is the single require-able gate, `if: always()`,
fail-closed. Narrowing changes what its green means, so the gate must say which
lane it is reporting.

Add `member-tests-linux` to `needs:` and a lane branch in the scoring block
(`ci.yml:2956-2988`):

```
if SOURCE_CI == "true":
    <existing block, unchanged>
elif MEMBER_SCOPE == "true":
    check "Build compiler [linux-x86_64]" "$BUILD_COMPILER_LINUX"
    check "Member tests [linux-x86_64]"   "$MEMBER_TESTS_LINUX"
    summary: "| Lane | member-scoped: <names> — compiler matrix not run |"
else:
    <existing "out of scope" block, unchanged>
```

with the same `lane` validation the other outputs get: a `LANE` that is not one
of `full|member|none`, or a `lane`/`source`/`member_scope` triple that
disagrees, exits 1 before any scoring — the same shape as the existing
`SOURCE_CI` / `PUBLIC_CLAIMS_CI` / `WINDOWS_CI` sanity checks at `:2921-2934`.

Three properties keep branch protection honest:

1. **The gate never claims a job it did not run.** The member branch scores
   exactly two jobs and prints the lane and the member names. A reader of the
   check summary can tell a member-lane green from a full green without
   opening the run.
2. **Honesty is the predicate's soundness, not the label.** A green member lane
   means "no changed path can reach the compiler". That claim rests on §3.3's
   fail-closed ordering and on §8.1's standing assertion that the closure
   covers every capsule the compiler tree imports. Both are testable; the label
   is not.
3. **Every non-`full` path already widens.** There is no input under which a
   compiler-affecting change scores `member`: it would have to live under a
   non-member, non-glob-parent, non-always-full path and still reach the
   compiler, which the closure test in §8.1 makes a test failure.

The gate keeps exactly one required check name, so **no branch-protection
configuration changes**. That is deliberate: a second required check would let
a member-lane PR sit forever pending on a check that never runs, which is the
"skipped counts as success" trap `ci.yml:2896-2900` already documents.

## 4. Effect & capability impact

None. This is workflow and build-tooling configuration plus one bash query. No
Sailfin source in `compiler/src/` or `compiler/capsules/` changes, no effect
signature moves, and the new regression tests are ordinary `![io]` tests that
drive subprocesses via `process.run_capture` per
`.claude/rules/no-bash-e2e.md`.

## 5. Self-hosting impact

None to the compiler. No pass changes, no seed dependency, no `bootstrap.toml`
edit. `scripts/module_layout_fingerprint.sh` is bash read by the pre-seed job
only; adding a mode to it cannot affect `sfn dev bootstrap build`.

Two invariants must hold and are cheap to check:

- **Cache keys must not move.** `--ci-freshness` / `--ci-freshness-inputs`
  (`module_layout_fingerprint.sh:345-370`) currently close over compiler-role +
  runtime only. The new closure adds `sfn/test`, `sfn/fs`, `sfn/os`, `sfn/http`.
  **Do not unify them.** Refactor the fixed point into a shared bash function
  parameterised by its seed file and call it twice; `--ci-freshness` keeps its
  existing seed set byte-for-byte. Changing it would invalidate every CI build
  cache in one commit — recoverable (a one-time cold rebuild, per
  `module_layout_fingerprint.sh:27-30`) but gratuitous.
- **The new mode must reject source roots.** `:65-68` already errors when a
  non-`layout` mode is given positional arguments; the new mode joins the `case`
  at `:50` and inherits that.

## 6. Alternatives considered

**A native `sfn dev inventory` closure view.** Ruled out by SFN-1160, which
names `ci.yml:110-120` under *Out of scope* as one of three permanently-bash
pre-seed jobs, and by SFEP-0074 §8.4's "Permanent Tier 3 residue". `ci-scope`
fetches no seed; a native view has no way to run there.

**A separate script.** The edge extraction (`:235-243`), the member expansion
(`:140-157`), the manifest-name parsing (`:186-199`), and the fixed-point walk
(`:346-360`) all already exist in `module_layout_fingerprint.sh`. A sibling
script would duplicate ~120 lines of manifest parsing whose drift is the exact
failure SFN-661 records as this file's reason for existing.

**Per-member lanes instead of one member lane.** A matrix over the changed
out-of-closure members, each running only its own tests. Saves at most a
couple of minutes over §3.5's whole-surface lane, costs a correctness argument
about reverse dependencies and a second partition to keep covered. Rejected on
`CLAUDE.md` "boring wins".

**Run the member lane on the pinned seed.** §3.5; loses to seed lag.

**Widening `public_claims` to cover member capsules.** Would make a stdlib PR
run `check-public-claims`, which verifies site/docs claims and examples. Wrong
axis, and it does not reduce anything — rejected as scope creep.

**Leaving `check-fast` in the member lane.** It `sfn check`s
`--compiler-sources` only, which by definition contains no out-of-closure
member. It would be a five-minute no-op.

## 7. Stage1 readiness mapping

Not applicable — no language or compiler-source feature ships here. The
checklist rows that do apply:

- [ ] Regression coverage (§8)
- [ ] Self-hosts — unaffected; `sfn dev bootstrap build` untouched
- [ ] `sfn fmt --check` clean — for the new `*_test.sfn` files only
- [ ] Documented — the operational half lands in
      `docs/conventions/ci-test-topology.md` (§ "Where each gate lives" and a
      new § "Scope lanes"), following SFEP-0011's own 2026-08-05 precedent of
      splitting CI operation out of the design record.

## 8. Test plan

### 8.1 `compiler/tests/e2e/ci_source_closure_test.sfn` (new)

The load-bearing file. Drives `scripts/module_layout_fingerprint.sh` via
`process.run_capture_cwd`, modelled on
`compiler/tests/e2e/module_layout_fingerprint_test.sfn:94-113`.

- *"ci source closure: the closure is a strict non-empty subset of member
  roots"* — the fail-closed shape the workflow guard depends on.
- *"ci source closure: every capsule imported under compiler/tests is in the
  closure"* — scan `compiler/tests/**/*.sfn` for `from "sfn/<name>"`, map to
  member roots via `--member-records`, assert each is in `--source-closure-roots`.
  **This is the test that makes a member-lane green honest**, and it fails the
  day someone imports `sfn/tensor` from a compiler test.
- *"ci source closure: every capsule declared by a compiler/tests fixture
  manifest is in the closure"* — the `sfn/http` case, asserted from the
  manifests rather than from the import text.
- *"ci source closure: compiler and runtime manifest dependencies are all in
  the closure"* — guards a regression in the walk itself.
- *"ci source closure: a synthetic leaf member outside the closure stays
  outside"* — build a scratch workspace (the existing test's
  `transitional`/`target` fixture pattern) with a leaf capsule, assert it is
  absent from the closure and present in `--member-roots`.
- *"ci source closure: a synthetic member the compiler depends on is inside"* —
  the positive direction, proving the walk is transitive rather than one-hop.

### 8.2 `compiler/tests/e2e/ci_scope_lane_test.sfn` (new)

Workflow-text assertions, modelled on
`compiler/tests/e2e/windows_host_patterns_guard_test.sfn` and on
`module_layout_fingerprint_test.sfn:399-441` ("every build-cache key site
carries the fp").

- `ci.yml` invokes `--source-closure-roots` and the glob-parent query.
- `required-ci`'s `needs:` contains `member-tests-linux`.
- The `member_scope == 'true'` branch scores exactly `build-compiler-linux` and
  `member-tests-linux`, and no macOS/aarch64/Windows job id appears in it.
- The draft branch forces `member_scope=false` and `lane=none` alongside the
  three existing outputs — asserted by text, since a lever that must force
  *every* output false is exactly the kind of thing added to by omission.
- No job carries `if: needs.ci-scope.outputs.member_scope == 'true'` without
  also appearing in `required-ci`'s `needs:` — the "required gate must see
  every lane job" invariant.

### 8.3 Extend `compiler/tests/e2e/module_layout_fingerprint_test.sfn`

- *"module layout fingerprint: ci-freshness is unchanged by the closure
  query"* — pin the `--ci-freshness` digest against a fixture workspace before
  and after the refactor in the same run, proving the shared fixed-point
  function did not move the cache key (§5).

### 8.4 Manual, once, at Phase 3

Open one throwaway PR touching only `stdlib/tensor/src/mod.sfn` and confirm:
`ci-scope` reports `lane=member`; exactly `build-compiler-linux` and
`member-tests-linux` run; zero macOS jobs are created; `Required CI gate` is
green with the member-lane summary row. Then push a second commit touching
`compiler/src/main.sfn` and confirm the same PR flips to `lane=full`.

### 8.5 Commands

```
sfn fmt --write compiler/tests/e2e/ci_source_closure_test.sfn \
                compiler/tests/e2e/ci_scope_lane_test.sfn
sfn fmt --check compiler/tests/e2e/ci_source_closure_test.sfn \
                compiler/tests/e2e/ci_scope_lane_test.sfn
sfn check compiler/tests/e2e/ci_source_closure_test.sfn
build/bin/sfn test compiler/tests/e2e/ci_source_closure_test.sfn
build/bin/sfn test compiler/tests/e2e/ci_scope_lane_test.sfn
build/bin/sfn test compiler/tests/e2e/module_layout_fingerprint_test.sfn
build/bin/sfn dev shard cover
bash scripts/module_layout_fingerprint.sh --source-closure-roots
bash scripts/module_layout_fingerprint.sh --ci-freshness   # must equal pre-change value
```

No phase needs `sfn dev bootstrap build` for its own correctness (no
`compiler/src` change), but every phase adding a `*_test.sfn` must run it
before the targeted test so the test runs against a current binary
(`.claude/rules/selfhost-invariant.md`).

## 9. Phasing

Each phase is one session, one PR, independently mergeable, and leaves CI
strictly no less safe than before it.

### Phase 1 — the closure query (script + tests only, no workflow change)

**Files:** `scripts/module_layout_fingerprint.sh`,
`compiler/tests/e2e/ci_source_closure_test.sfn` (new),
`compiler/tests/e2e/module_layout_fingerprint_test.sfn`.

Refactor the `selfhost_members` fixed point (`:346-360`) into a bash function
taking a seed file. Add `--source-closure-roots` (closure member roots) and
`--member-glob-parents` (the `/*` prefixes from `[workspace].members`). Seed
the new closure from compiler-role ∪ runtime ∪ `sfn/test` ∪ every
`compiler/tests/**/capsule.toml` `[dependencies]` entry. Leave `--ci-freshness`
seeded exactly as today.

**Acceptance:** §8.1 and §8.3 pass; `--source-closure-roots` emits 15 roots on
this checkout; `--ci-freshness` digest is byte-identical to `main`'s.
**Nothing in CI consumes the new mode yet**, so this phase cannot change any
run's scope.

### Phase 2 — the member lane job (no scope change yet)

**Files:** `.github/workflows/ci.yml`.

Add `member-tests-linux`, gated on a temporary hardcoded `if: false`-equivalent
— concretely, add the job and wire it to a new `ci-scope` output `member_scope`
that the classifier always sets to `false`. Widen `build-compiler-linux`'s
`if:`. Add `member-tests-linux` to `required-ci`'s `needs:` and add the lane
branch. Add the `lane` output with a `full|none` domain only.

**Acceptance:** one PR-CI run behaves exactly as today (every job, same
verdicts); `required-ci` prints a `| Lane | full |` row; §8.2's assertions that
do not depend on `member` being reachable pass. This is the phase that proves
the gate plumbing before it can affect a merge decision.

### Phase 3 — flip the classifier

**Files:** `.github/workflows/ci.yml`,
`compiler/tests/e2e/ci_scope_lane_test.sfn` (new),
`docs/conventions/ci-test-topology.md`.

Replace the member-root predicate at `:131-141` with §3.3's ordered
classification, emit `member_scope` and `lane` for real, extend the
empty-inventory guard to the closure, and extend the draft lever. Document the
lanes in `ci-test-topology.md`.

**Acceptance:** §8.2 and §8.4 pass. Note that this PR itself edits
`.github/workflows/ci.yml`, which is an always-full path (rule 2), so it
validates the full lane on itself — the member lane is validated by §8.4's
throwaway PR.

### Phase 4 — reconcile the docs and retire the manual check

**Files:** `docs/conventions/ci-test-topology.md`,
`.claude/rules/pr-discipline.md` (the "one in-scope PR asks for six macOS
job-slots" paragraph gains the lane caveat), `docs/proposals/README.md`
registry row.

Small; bundle into Phase 3 if the diff is under ~40 lines. Splitting a doc
reconcile off a workflow change manufactures a review cycle for nothing.

**Decomposition note.** Phases 1–3 are genuinely independent: Phase 1 has no
consumer and is separately useful (the closure is also the honest seed for a
future `--ci-freshness` audit), Phase 2 is the gate-plumbing change that must
be provably inert before Phase 3 can be safe, and Phase 3 is the semantic flip.
This is *not* a capability/consumer split under
`.claude/rules/seed-dependency.md` — **no phase touches compiler source, so no
phase creates a seed-cut gate.** The `.sfn` files added are tests, which the
freshly built compiler runs in the same PR.

## 10. Risks

**The closure is derived from `[dependencies]`, and the real build could use an
edge that is not declared there.** This is the one soundness assumption. It is
load-bearing already — the resolver links intra-workspace edges from
`[dependencies]`, and `--ci-freshness` has keyed the CI build cache on the same
walk since it shipped. §8.1's import-vs-closure assertion converts the
assumption into a test, and the one real out-of-band edge found (`sfn/http` via
a fixture manifest) is folded into the roots.

**No merge-queue backstop today.** `docs/runbooks/merge-queue.md` §1 is an
unperformed owner action, so `main` is not queue-protected and a member-lane
green is the last gate before merge. Mitigations that exist today:
`nightly-selfhost.yml` runs the full triple-pass self-host and suite, and
`release-train.yml` only cuts when `main` is green. A member-lane escape is
therefore caught within a day and cannot reach a release. Enabling the queue
(which always runs full, §3.6) would make this risk structural rather than
procedural, and is worth citing as an incentive.

**Someone adds a compiler-test import of an out-of-closure capsule.** Caught by
§8.1 in the same PR, which necessarily touches `compiler/tests/*` → rule 2 →
`full`, so the test actually runs.

**A member lane hides a genuine cross-capsule break.** Bounded by §3.4's lemma
plus §3.5's decision to run the *whole* member surface: the only way a member
change breaks something the lane does not run is through an undeclared edge,
which is the first risk.

**Bash classification complexity.** The per-path loop grows from two set
memberships to six ordered rules. Mitigated by keeping every rule a `case`
glob or a prefix-array scan — no new parsing — and by §8.2 asserting the
workflow text rather than trusting review.

## 11. Future considerations

- **Per-member test selection in the lane.** Once `--dependent-closure <name>`
  exists in the script (trivial: reverse the edge file and reuse the same
  fixed point), the lane could run only the changed members' transitive
  dependents. Worth doing only if the member surface grows past ~15% of suite
  share; at 5.2% it is noise.
- **A `lane = docs` verdict.** The `none` lane already skips everything; naming
  it would only improve the summary.
- **Extending the closure predicate to `installer-smoke.yml`.** It has its own
  `paths:` and its own scope condition (`ci.yml`'s `ready` equivalent) and is
  deliberately out of this design, but it is the next-largest scope surface.
- **The `examples/` under-scoping gap** (§3.6). Separate issue, opposite
  direction, real.
- **If SFN-1174's native views ever acquire a post-seed closure consumer**, add
  the twin then, with a set-equality test against the bash query — never a
  byte-for-byte one, per §3.1.

## 12. References

- `.github/workflows/ci.yml:113,124-141,142-158,190-238,2766-2988` — the job
  being changed
- `scripts/module_layout_fingerprint.sh:50,135-138,235-243,342-370` — the
  existing edge extraction and fixed-point walk
- SFN-484 — the same over-scoping defect in the same job, fixed once
- SFN-1160 — names `ci-scope` as permanently pre-seed bash (SFEP-0074 §8.4
  Phase A, *Out of scope*)
- SFN-1174 — native inventory views (SFEP-0074 §8.4 Phase B); adjacent, not
  this
- `docs/proposals/0074-repo-tooling-ownership.md` §8.4 — the bash-vs-native
  inventory split and the Tier-3 residue
- `docs/proposals/0011-ci-test-speed.md` — content-addressed test artifacts and
  the shard partition; its 2026-08-05 amendment is the precedent for keeping CI
  *configuration* out of an SFEP and in `ci-test-topology.md`
- `docs/proposals/0037-peer-language-process-adoption.md` §3.1 — why
  `merge_group` is always in scope
- `docs/conventions/ci-test-topology.md` — shard map, job budget, gate
  placement; the destination for the operational half
- `.claude/rules/pr-discipline.md` — the macOS pool measurement that motivates
  this
- `compiler/src/cli/commands/dev_shard.sfn:90-99`,
  `compiler/src/workspace_inventory.sfn:285-294`,
  `compiler/src/cli/commands/dev_inventory.sfn:29-31` — the member test surface
  the lane reuses
