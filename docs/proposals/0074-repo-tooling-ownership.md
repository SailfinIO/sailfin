---
sfep: 74
title: Repo Tooling Ownership — Retiring `scripts/` into Native Verbs
status: Accepted
type: tooling
created: 2026-08-27
updated: 2026-08-27
author: "agent:Sailbot; project owner direction"
tracking: https://linear.app/sailfin/project/repo-tooling-ownership-13d4826f99a9
supersedes:
superseded-by:
graduates-to:
---

# SFEP-0074 — Repo Tooling Ownership: Retiring `scripts/` into Native Verbs

## 1. Summary

`scripts/` holds 21 files (19 bash, 2 Python; ~5,000 lines) in a repo whose
stated 1.0 goal is a pure-Sailfin toolchain. None are orphaned — every one has a
live call site — so this is not a dead-code cleanup. It is an **ownership**
question: which repo logic belongs in the compiler binary, which belongs in a
Sailfin capsule that is not the compiler, and which is structurally required to
be shell because it runs before any `sfn` binary exists.

All four questions this SFEP opened were investigated and resolved before
grooming (§8); no design unknown blocks the gate.

This SFEP establishes a three-tier ownership model, classifies all 21 scripts
against it, and — critically — identifies the **friction gradient** that
produced the directory in the first place. The gradient, not the inventory, is
the thing to fix first: adding a bash script costs one file; adding an
`sfn dev` verb costs edits in three files plus a hand-maintained usage string
plus a known seed miscompile hazard. No convention survives that ratio.

## 2. Motivation

### 2.1 The pattern already exists and already worked

Four scripts have already been retired into native verbs, each announcing its
own retirement in its help text:

| Verb | Definition | Retired |
|---|---|---|
| `sfn dev shard` | `compiler/src/cli/commands/dev_shard.sfn:416` | `scripts/test_shards.sh` |
| `sfn dev arena` | `compiler/src/cli/commands/dev_arena.sfn:286` | `scripts/test_arena.sh` |
| `sfn dev determinism-sweep` | `compiler/src/cli/commands/dev_det_sweep.sfn:502` | `scripts/diag_determinism_sweep.sh` |
| `sfn dev clean` | `compiler/src/cli/commands/dev_clean.sfn:330` | `make clean-build` / `clean` |

All three `.sh` files are gone from the tree. `sfn dev inventory`
(`dev_inventory.sfn:43`) is a fifth instance: the Makefile now asks the
compiler for workspace path lists instead of deriving them in shell.

The convention is therefore **proven, load-bearing, and undocumented**. It
stopped spreading not because it failed but because nothing named it, and
because of §2.2.

### 2.2 The friction gradient is the root cause

Registering a new `sfn dev <verb>` today requires:

1. `compiler/src/cli/commands/dev_<foo>.sfn` exporting `<foo>_command_def()` / `<foo>_run()`
2. an import in `dev.sfn`
3. a `with_subcommand(dev, <foo>_command_def())` line (`dev.sfn:1432-1438`)
4. a `path[1] == "<foo>"` dispatch branch (`dev.sfn:1445-1482`)
5. a hand-edited entry in `_usage()` (`main.sfn:99-144`)

plus the constraint at `main.sfn:280-284`: the pinned seed **miscompiles nested
`with_subcommand(...)` chains** (#1773), so registration must use the
reassignment form. There is no auto-discovery, no manifest, no directory
convention that self-registers.

Adding a bash script costs: create one file.

Agents — and humans under time pressure — take the cheaper path. That is not an
adherence problem to be solved with a prohibition; it is a design problem in the
extension surface. **Flatten the gradient and most of the policy question
dissolves.**

### 2.3 Restriction without a path relocates the debt

`.claude/rules/no-bash-e2e.md` banned `.sh` files from the e2e suite. The ban
was honoured to the letter: there are zero `.sh` files under
`compiler/tests/e2e/`. There are also 22 `.sfn` files that pass `bash` or
`sh -c` as a **string argument** to `process.run_capture`, which is the direct
cause of current native-Windows test failures.

Measured, at the time of writing:

- 20 call sites in `.sfn` tests exist solely to shell out to a `scripts/*.sh`
  and assert on its exit code
- ~10 use bash as a coreutils substitute (`ls -a`, `find`, `head -c`, `ulimit`)
- the remainder are `stdlib/os` subprocess fixtures (legitimate: testing
  subprocess handling requires a subprocess, though `sh` is the wrong choice
  for a cross-platform suite)

Production compiler source contains **zero** shell-outs — the only match in
`compiler/src` is a comment at `build/fs.sfn:778`. The rot is confined to
tests and repo tooling.

### 2.4 The debt loop is self-sustaining

Each bash script that acquired an `.sfn` regression test acquired a test that
**depends on the script existing**. Deleting the script deletes the test and
the coverage with it, so the rational local move is always to keep the script.

The purest instance is `compiler/tests/e2e/toolchain_index_producer_test.sfn`:
a Linux-gated shell-out to `python3 scripts/test_publish_toolchain_index.py`
asserting exit 0, empty stderr, and a magic substring. It contains **zero
independent assertions**; all 859 lines of real coverage live in Python. The
structure is `sfn test` → assertion-free `.sfn` → Python harness → Python under
test: three process layers, skipped entirely on macOS and Windows, whose
function is making a non-Sailfin artifact read green inside `sfn test`.

A second instance: `scripts/test-check-examples-bash-compat.sh` exists only to
test macOS Bash 3.2 array semantics inside `scripts/check-examples.sh`. It has
no independent reason to exist and evaporates the moment its subject is ported.

### 2.5 No capability blocker remains

Every primitive a native port needs has shipped:

| Need | Status |
|---|---|
| Ed25519 signing | `capsules/sfn/crypto/src/ed25519_sign.sfn:115` (SFN-699) |
| SHA-256, X.509, TLS 1.3, AES-GCM, P-256/384 | `capsules/sfn/crypto/` (33 files) |
| tar/gzip read **and write** | `stdlib/archive/src/tar_read.sfn:500`, `tar_write.sfn:537` — the writer is used in production by `compiler/src/cli/commands/package.sfn:447` |
| JSON | `stdlib/json/` |
| TOML | `capsules/sfn/toml/`, `compiler/src/toml_parser.sfn` |
| HTTP + TLS client | `runtime/sfn/adapters/http.sfn` |
| CLI arg parsing | `capsules/sfn/cli/` |
| Subprocess, fs, env, time | `stdlib/os/`, `stdlib/fs/`, `stdlib/time/` |

Known gaps: **no glob matcher** and **no regex** exposed to user code.
`compiler/src/build/fs_tree.sfn:25` has `walk_dirs` but it is compiler-internal.
Any port doing pattern matching over file trees must compose `read_dir` with
manual string matching, or a small glob helper must land first.

SFEP-0048 §3.5 already records the consequence in writing:
`scripts/sign-release-manifest.sh` shells to `openssl pkeyutl -sign` while pure
Ed25519 signing sits in `sfn/crypto`, and "rewiring that script remains separate
work" (`docs/proposals/0048-native-crypto.md:448`). **The scripts do not survive
because porting them is hard. They survive because porting them is nobody's
issue.**

This is also a positioning cost. Sailfin ships a pure-Sailfin Ed25519 signer and
signs its own releases by shelling to `openssl` — a Reach-pillar story the
project currently fails to tell about itself.

## 3. Design — three tiers of ownership

### Tier 1 — `sfn dev <verb>` (in the compiler binary)

**Criterion:** the logic is *about* the compiler, the workspace, or the build,
and CI already has an `sfn` binary at the point of use.

Rationale: ships with the compiler, self-hosts, inherits `sfn fmt` / `sfn check`
/ `sfn test` / review for free, needs no second bootstrap chain, and is
available the moment the seed lands on a runner.

### Tier 2 — a repo-tooling capsule, built from source

**Criterion:** Sailfin-appropriate, but not a compiler concern — release
publication, signing, GitHub/Linear API glue. Shipping this in the compiler
binary would put Linear API credentials handling and label reconciliation in
every end user's toolchain.

The workspace already supports this with **zero infrastructure work**:
`workspace.toml:22-29` globs `capsules/sfn/*` and `stdlib/*`, and
`.github/workflows/capsule-release.yml` picks up new members automatically via
path filters and `--public-members` classification.

**Built from source in CI, not pulled as a published binary.** See §4.

### Tier 3 — irreducible shell, with a mandatory seam

**Criterion:** runs before any `sfn` binary exists on the host. The hard
boundary is precise: anything invoked before a job's "Fetch released seed
compiler" step (`.github/actions/sailfin-build/action.yml:109-130`), or that
itself computes which seed version to fetch, cannot be Sailfin.

Tier 3 is legitimate and permanent. It is not a grandfather clause: membership
is decided by bootstrap ordering, not by convenience, and every Tier 3 script
**must expose a pure-decision seam** so its logic is testable from `sfn test`
without the real environment.

That convention already exists organically, invented independently at least six
times:

```
SAILFIN_BINFMT_PROBE_ONLY        SAILFIN_SEED_ASSET_LIST
SAILFIN_SEED_PROBE_HTTP_CODE     SAILFIN_BOOTSTRAP_PROBE_PATH
SAILFIN_SESSION_SEED_PROBE_ONLY  SAILFIN_SEED_PIN_ASSET_GATE_SCRIPT
```

This SFEP promotes it from accident to requirement. **A Tier 3 script without a
seam is not Tier 3; it is un-ported Tier 1.** That is the test that keeps the
tier from becoming an excuse.

## 4. Rejected alternative — publishing repo tooling as a binary

Considered: build the Tier 2 capsule, publish it to the registry, have CI pull
`sailfin-tooling@X.Y.Z`.

**Rejected.** `.claude/rules/seed-dependency.md` already documents the failure
mode: a capability landing in a separate PR from its consumer cannot self-host
until it reaches the pinned version, which forces a cut between the two merges.
Pulling repo tooling as a published binary manufactures that same tax for repo
tooling — a PR that changes release verification **could not test its own
change**. It rebuilds the seed problem in a second place, voluntarily, for a
build-time saving.

**Chosen instead:** build from source with the seed already on disk. The seed
is present at every point Tier 2 logic runs. Cost is build time; benefit is that
repo tooling is testable in the PR that changes it, which is the property whose
absence created this directory.

### 4.1 Boundary with SFEP-0073 (Installed Toolchain Lifecycle)

SFEP-0073 is **in flight** and owns the *consumer* side of the toolchain index:
`sfn toolchain list/use/verify/update/remove`, selection precedence, and
install-time integrity verification. Its stated Out list does not claim the
producer, and this SFEP does not reopen any of its accepted decisions.

The adjacency is real nonetheless. `scripts/publish-toolchain-index.py` writes
the index that SFEP-0073 reads, and two of that project's milestones are
actively changing the *trust semantics of that artifact*:

- Milestone 4, "Trusted Updates" (27%) — signed release index, channel and
  release-state enforcement, anti-rollback metadata
- Milestone 5, "Bootstrap Hardening" (63%) — Protocol-1 adoption, fail-closed
  provenance, key transition

Porting a 997-line producer while the format and trust protocol it emits are
still moving is the worst available ordering: the port would be rewriting to a
target that changes underneath it, and any behavioural difference would be
ambiguous between port defect and intended protocol change.

**Rule for this SFEP:** the `publish-toolchain-index.py` port is sequenced
**after** SFEP-0073 milestones 4 and 5 land, and the porting issue must cite
SFEP-0073 as a blocker rather than an inspiration. Every other Tier 2 item is
independent of it — including `sign-release-manifest.sh`, which writes
`SHA256SUMS` and its detached signature, a format SFEP-0073 consumes but does
not redefine.

This ordering costs nothing: the producer was already last in §6 for unrelated
reasons (largest, most mechanical, highest blast radius).

## 5. Classification — all 21 scripts

### 5.1 Delete outright (2)

| Script | Lines | Rationale |
|---|---|---|
| `detect_build_jobs.sh` | 85 | Computes `BUILD_JOBS` at `Makefile:89`; read nowhere. `Makefile:837` states it "no longer plumbs through." `SAILFIN_BUILD_JOBS` is owned natively at `capsule_emit_parallel.sfn:48`. Its constants have silently drifted from `_cr_ram_budget_jobs` — inert only because the output is discarded. Also remove the `build_jobs` input from `.github/actions/sailfin-build/action.yml:39-42`. |
| `test-check-examples-bash-compat.sh` | 60 | Tests bash-3.2 semantics in `check-examples.sh`. Evaporates when §5.3 lands. |

### 5.2 Retires with the Makefile (1)

| Script | Rationale |
|---|---|
| `detect_test_jobs.sh` | Only production caller is `Makefile:167`. Native `_test_jobs_budget` (`compiler/src/cli/commands/test/arg_and_jobs.sfn:90`) already encodes identical constants. `compiler/tests/integration/test_jobs_budget_parity_test.sfn` retires with it — it exists only to prove the two agree. |

**Sequencing note.** Both §5.1 and §5.2 exist *because* `make` evaluates `?=`
defaults before any `sfn` binary exists. Deleting the Makefile is the event that
retires them. Do it first and this SFEP's scope shrinks by three files and a
test at zero cost; do it after and the scripts acquire a new home they do not
need.

### 5.3 Tier 1 — absorb into `sfn dev <verb>` (9, ~1,400 lines)

| Script | Lines | Target | Notes |
|---|---|---|---|
| `check-examples.sh` | 180 | `sfn dev examples` | **Not** a loop over `sfn check`. Two-phase (`check` then `run`), plus `EMPTY_OUT` detection (`:113`) for an example that exits 0 while printing nothing, plus an XFAIL/XPASS ratchet. `sfn test` has **zero** xfail/xpass concept — this is a missing compiler feature, not a cleanup chore. `KNOWN_FAILING` is currently **empty**: port now, while there is no exemption state to migrate and no live exemption to argue about. |
| `corpus-run.sh` | 371 | `sfn dev corpus` | SFN-92 / SFEP-0037 §3.4 oracle diff. Sole implementation. No bootstrap constraint. |
| `perf_history.sh` | 402 | `sfn dev perf-history` | Consumer of `sfn bench` CSV output; `bench.sfn:479` and `bench_consumer.sfn:434` already cross-reference it as a schema dependent. Git/gh work lives in the workflow, not the script. |
| `aggregate_shard_weights.sh` | 121 | `sfn dev shard weights` | Natural sibling of the existing `sfn dev shard`. No test today. |
| `classify_rename_only_ir.sh` | 127 | `sfn dev classify-rename` | Load-bearing subtleties to preserve: the `ENVIRON`-vs-`-v` escaping workaround (`:45-54`) and the newline-parity check separate from byte-compare (`:111-117`). |
| `verify-release-payloads.sh` | 53 | `sfn dev verify-payloads` | Filename-existence check over a fixed list. Lowest-risk port in the set. |
| `verify-arm64-release-assets.sh` | 36 | same verb, flag | Fixed-string membership check. |
| `verify-payload-dep-closure.sh` | 143 | same verb, flag | `sfn/archive::targz_extract` removes the `tar` dependency; `compiler/src/toml_parser.sfn` replaces the hand-rolled awk and **structurally fixes** the SFN-1024 CRLF defect class rather than patching around it. |
| `install_precommit.sh` | 200 | `sfn dev install-hooks` | Runs after a compiler exists. Hook body already invokes `sfn check` directly (SFN-1114). |

### 5.4 Tier 2 — repo-tooling capsule (6, ~2,100 lines)

| Script | Lines | Notes |
|---|---|---|
| `publish-toolchain-index.py` | 997 | Largest non-Sailfin artifact. No missing capability — crypto, JSON, file I/O and `sfn/cli` all ship. A sizable but mechanical rewrite. **Sequenced last — see §4.1.** |
| `test_publish_toolchain_index.py` | 859 | Becomes a normal `sfn/test` e2e suite, collapsing three process layers to one and removing the Linux+Python+openssl gate. |
| `sign-release-manifest.sh` | 103 | Explicitly named in SFEP-0048 §3.5 as the recorded, unblocked follow-on. Smallest, highest symbolic value. |
| `capsule-release-topology-only.sh` | 84 | Still shells to `git` (no in-process git library, and none is proposed); everything else is string work. |
| `setup-github-labels.sh` | 180 | Pure `gh`/`jq`/`yq` API glue. **No test coverage today.** |
| `linear-priority-sync.sh` | 120 | Pure Linear GraphQL glue. **No test coverage today.** |

The last two are the clearest argument for Tier 2 over Tier 1: they are
genuinely useful, genuinely untested, and have no business inside a compiler
binary shipped to users.

### 5.5 Tier 3 — irreducible shell (4)

| Script | Seam | Notes |
|---|---|---|
| `install.sh` (repo root) | installer-smoke | Produces the first `sfn` on a bare runner. Can never be Sailfin without a separate bootstrapping mechanism. `install.ps1` is its Windows twin. |
| `bootstrap-aarch64-linux.sh` | `SAILFIN_BINFMT_PROBE_ONLY` | Seed → qemu → compiler A → pass-1 → pass-2 fixed point. Vehicle that produces the first native aarch64 binary. |
| `select-aarch64-seed-mode.sh` | `SAILFIN_SEED_ASSET_LIST`, `SAILFIN_SEED_PROBE_HTTP_CODE` | Decides which bootstrap path to take before a seed is fetched at all. |
| `module_layout_fingerprint.sh` | — (**gap**) | 427 lines, 25+ call sites, computes the cache keys that gate whether a build happens. **Three** genuinely pre-seed jobs, not one: `ci.yml:110-120` (`ci-scope`), `release.yml`'s "Stage version bump" job, and `release-train.yml`'s Node-driven historical-SHA comparison — none fetches a seed anywhere in the job. Every other call site is post-seed. Split the script's **usage**, not the script — see §8.4. |

## 6. Migration sequencing

1. **Flatten the friction gradient** (§2.2). Reduce `sfn dev <verb>` registration
   to a single file plus one registration line; generate `_usage()` from the
   command tree rather than hand-maintaining it. Everything downstream is
   cheaper afterward, and the convention becomes self-enforcing.
2. **Delete the Makefile** (in flight). Retires §5.1 and §5.2 for free.
3. **Delete the `scripts/` directory as a directory** once emptied of Tier 1/2.
   Tier 3 moves to `scripts/bootstrap/` with a README stating the tier rule and
   the seam requirement. Removing the generic directory removes the affordance:
   "drop a `.sh` in `scripts/`" stops having an obvious home.
4. **Tier 1 absorption**, cheapest first — `verify-release-payloads.sh` and
   `verify-arm64-release-assets.sh` are near-trivial and establish the pattern;
   `check-examples.sh` next while its ratchet is empty.
5. **Stand up the Tier 2 capsule**, `sign-release-manifest.sh` first (smallest,
   already-recorded, highest symbolic value), `publish-toolchain-index.py` last
   and **gated on SFEP-0073 milestones 4-5** (§4.1).
6. **Document the convention** in `docs/conventions/`, including the retirement
   note in help text that the existing four verbs already model.

Each Tier 1/2 port deletes its bash script and its shell-out test in the **same
PR**. A port that leaves the script in place has not landed.

## 7. Out of scope

**Inline shell in CI YAML.** Measured at **5,206 lines** across
`.github/workflows/` and `.github/actions/` — 1.6× the entire `scripts/`
directory, with 1,317 lines in `ci.yml` alone, and `bootstrap.toml` awk-parsed
in four separate places. It has no tests, no formatter, and no review gate.

This is deliberately **not** addressed here, and needs its own audit: the
project owner's assessment is that it also contains CI jobs unrun in a year that
should be deleted outright, and steps that are stale mirrors of capability the
compiler now has natively — a different shape of problem from this one.

It is recorded here because it constrains this SFEP's success criterion:
**emptying `scripts/` without a landing zone relocates logic into `run:` blocks**,
the one place with none of the reviewability properties `scripts/` at least has.
`scripts/` is the visible, tested, reviewable portion of the repo's shell
surface. Success is measured by shell **eliminated**, never by `scripts/`
emptied.

## 8. Resolved questions

All four opened questions were investigated before grooming. Answers below are
binding for leaf authoring; the evidence is cited rather than restated.

### 8.1 The glob/regex gap does not exist — RESOLVED, no predecessor needed

The scripts do not glob. Every instance is `find <root> -name '*.sfn' | sort`:
a recursive walk with a **suffix match**, no mid-pattern wildcards, no
character classes (`check-examples.sh:126`, `corpus-run.sh:280,289,297`).
Regex appears nowhere — `classify_rename_only_ir.sh`'s `sed` use is literal
string replacement.

The capability exists in the compiler twice already, as bounded BFS walks with
a suffix predicate: `_collect_sfn_files_cmd`
(`compiler/src/build/fs.sfn:712`) and `_collect_test_files_cmd`
(`compiler/src/cli/commands/test/discovery.sfn:28`). Tier 1 verbs live in
`compiler/src/cli/commands/`, so they import the existing helper — **zero new
API surface**.

The native walkers additionally carry correctness fixes the bash `find` lacks:
the missing-file guard that stopped `sfn fmt --write absent.sfn` minting a
0-byte stub which then shadowed the directory that replaced it
(`fs.sfn:714-718`), and the SFN-648 typo case plus trailing-slash normalization
in `discovery.sfn`. **Porting off `find` improves correctness; it is not a
like-for-like move.**

Do **not** speculatively add `fs.walk` to `stdlib/fs` — that is a public API
commitment, and Tier 2's needs are manifest-driven rather than tree-walking.
Revisit only if a Tier 2 leaf demonstrates the need.

### 8.2 `sfn dev examples` is a distinct verb, with the ratchet as data — RESOLVED

Examples are **programs with `main` that print**, not `test "..."` blocks.
Folding the sweep into `sfn test` would require either teaching the runner to
treat a `main` program as a test case or wrapping each example in a synthetic
test; both are worse than a separate verb, and `EMPTY_OUT` detection is
meaningless for tests. Placement follows the same logic: `sfn test` is
user-facing, an examples sweep is a maintainer gate, so it belongs beside
`shard` / `arena` / `determinism-sweep` under `dev`.

Confirmed no expected-failure concept exists anywhere in
`compiler/src/cli/commands/test/` or `compiler/src/test_runner_state.sfn` —
nothing to reuse, nothing to conflict with.

**One deliberate change from the script:** the ratchet state moves from a
source array (`KNOWN_FAILING`, `check-examples.sh:55`) to a checked-in
manifest file. Tightening then becomes a reviewable data change rather than an
edit to the tool that enforces it — an agent loosening a data file is a visible
one-line diff; an agent editing enforcement logic is not.

### 8.3 The Tier 2 capsule lives at `tools/*` with `publish = false` — RESOLVED

Auto-publish is already a solved problem: `[capsule] publish` is parsed at
`module_layout_fingerprint.sh:219`, defaults to `true` when absent, and **fails
closed** on an invalid value; `--public-members` lists only publishable members
and is what drives `capsule-release.yml`. `compiler/capsule.toml:5` already
sets `publish = false` — the precedent is the compiler itself.

The deciding factor is therefore namespace, not mechanism. `capsules/sfn/*`
would name repo-internal tooling `sfn/<something>`, placing it in the **public
scope** where it reads as a shipped capsule. `tools/` already exists and
already means "not the compiler" (`bluesky`, `mcp-server`).

Adding `tools/*` to `workspace.toml:23` is a one-line edit and is seed-safe:
the manifest's own comment records that the pinned seed already expands a
trailing `/*` into every subdirectory carrying a `capsule.toml`
(`capsule_resolver/workspace.sfn::_cr_expand_member_globs`). `capsule-release.yml`'s
path filters are `capsules/**` / `stdlib/**`, so `tools/` is not even
considered — belt and braces alongside `publish = false`.

### 8.4 `module_layout_fingerprint.sh` — split the usage in three phases, not the file

Per-**mode** splitting fails: `--compiler-manifests` and `--member-manifest`
each straddle both tiers depending on the caller (`ci.yml:112` pre-seed vs.
`release-tag.yml:352` post-seed). Individual **call sites** move; modes do not.

**Phase A — free, no new native code.** At `ci.yml:1487,1520,1570` (build-linux)
and `:2013,2040,2084` (build-macos), the step shells to bash for
`--maintainer-sources` while `build/bin/sfn` — **built from this very tree** —
is invoked two lines below (`ci.yml:1494,1575`, `:2020,2089`).
`sfn dev inventory maintainer-sources` (`dev_inventory.sfn:25-27`) is already
semantically identical. Repoint these; zero seed-lag risk because the binary in
hand is built from the current source. This is live, measurable duplication
today.

`ci.yml:407` (`check-fast`) is deliberately **excluded** from Phase A: it calls
the *seed* (`ci.yml:413`), not the fresh build, so bash remains defensible
there until the view is known-present in the pinned seed.

**Phase B — new native views required.** `--member-roots`, `--member-records`,
`--public-members`, `--member-manifest <name>`, and `--compiler-manifests` have
no `dev inventory` equivalent. `--compiler-manifests` is **not** a rename of the
existing `manifests` view: it additionally enforces exactly 6 canonical
compiler-role capsules all declaring `publish = false`
(`module_layout_fingerprint.sh:380-392`), so the invariant ports with it. Once
these views exist, `capsule-release.yml:126` and `corpus-run.sh:301` (both
confirmed post-seed) are the next call sites to repoint.

**Phase C — digest modes, sequenced last.** `dev_inventory` performs no hashing
at all; that logic lives only in `compiler/src/build/source_fingerprint.sfn`.
A `--paths-only` mode on `sfn dev bootstrap fingerprint` is structurally cheap —
`inventory.all_source_inputs ∪ inventory.explicit_inputs`
(`workspace_inventory.sfn:141-151,206-230`) is the same universe as the bash
`$paths` — but five conventions must match byte-for-byte or CI cache keys
change: path string form (no `./` prefix, forward slashes), `LC_ALL=C` sort
order, dedup rule, hash-input framing (bare `path\n` join, **not** the
`<hash>\t<path>` tuple the content mode uses), and lowercase hex encoding.

Note the native content-mode digest already uses the `"v2-"` prefix
(`source_fingerprint.sfn:206-245`) for a *different* meaning than the bash
layout digest's `"v2-"`. A native path-only mode must not reuse that prefix
shape or the two become indistinguishable to a reader.

Mitigation: ship `--paths-only` **side-by-side** with the bash mode for one
release cycle — both computed, only one wired to the cache key — and confirm
identical output before cutting over. The failure mode is self-limiting (a
one-time cold rebuild, per `module_layout_fingerprint.sh:27-30`) **except** if
a restore/save pair mixes an old bash-computed key with a new native-computed
one, which is a permanent-miss availability bug. Never split a pair across the
cutover.

**Permanent Tier 3 residue.** Three jobs fetch no seed anywhere and keep bash
indefinitely: `ci.yml:110-120` (`ci-scope`), `release.yml`'s "Stage version
bump", and `release-train.yml`'s Node-driven historical-SHA comparison.

**Rejected: keep whole.** The enumeration modes total ~150 lines and are
already a live second implementation of a native-inventory concept that drifts
on every workspace-topology change — the exact failure SFN-661 records as this
file's reason for existing.

## 9. References

- `docs/proposals/0073-toolchain-lifecycle.md` — consumer side of the toolchain index; boundary and sequencing in §4.1
- `docs/proposals/0048-native-crypto.md` §3.5 — the recorded, unclaimed signing follow-on
- `docs/proposals/0026-delivery-process.md` — seed-cut tax, the basis for §4
- `.claude/rules/seed-dependency.md` — bundling rule cited in §4
- `.claude/rules/no-bash-e2e.md` — the restriction whose outcome motivates §2.3
- `docs/conventions/e2e-tests.md` — subprocess-driving patterns for ported tests
