---
sfep: 76
title: User-Level Build Defaults
status: Accepted
type: tooling
created: 2026-09-03
updated: 2026-09-05
author: "agent:Sailbot; owner-directed investigation; project owner acceptance"
tracking: SFN-1257, SFN-1256, SFN-1258, SFN-1259, SFN-1260, SFN-1261, SFN-1262
supersedes:
superseded-by:
graduates-to: reference/on-disk-layout.md
---

# SFEP-0076 — User-Level Build Defaults

## 1. Summary

`~/.sfn/config.toml` is Sailfin's per-user configuration file, and it accepts
exactly two keys. Meanwhile the toolchain reads roughly forty environment
variables, none of which can be persisted anywhere. A user whose machine needs a
specific linker, C compiler, or job count has one option: a shell export, which
`sfn config list` cannot see, `sfn` cannot validate, and no non-login process
inherits.

This SFEP admits a bounded set of *machine-scoped* settings into the file that
already exists, under one stated precedence order, with a single admission rule
governing what may ever be added. It does not propose a new file, a new
directory, or a general settings framework.

## 2. Motivation

### 2.1 The file exists and is nearly empty

`sfn config` recognises two keys (`cli/commands/config.sfn:139-148`):

```toml
[registry]
url = "https://pkg.sfn.dev"

[toolchain]
update-policy = "notify"
```

Everything else the toolchain can be told is environment-only. The sharpest
cases are facts about the workstation, which is precisely what a user-level
config is for:

| Variable | Read at | Why it wants persisting |
|---|---|---|
| `SAILFIN_LINKER` | `build/link.sfn:77`, `build/direct_link.sfn:156` | one linker per machine, not per invocation |
| `SAILFIN_CC` | `backend.sfn:145` | same |
| `SAILFIN_BUILD_JOBS` | `capsule_emit_parallel.sfn:48` | core count and RAM are machine properties |
| `SAILFIN_BUILD_CACHE_DIR` | `build_cache.sfn:812` | which disk is fast is a machine property |
| `SAILFIN_TARGET_TRIPLE` | `build/target.sfn:118`, `build.sfn:189` | a cross-compiling user retypes it every time |

None of these describe the program being built. They describe the machine
building it, and they do not change between projects or between invocations.
A shell export is the wrong lifetime for a fact that stable.

### 2.2 The discoverability failure is real, not hypothetical

Observed 2026-09-03. A user with sixty installed toolchains under
`~/.local/share/sailfin/versions/` and a populated `~/.sfn/cache/` concluded
that Sailfin had no user configuration at all. The reasoning was sound given
what is visible: `~/.sfn` contained `cache/` and `credentials`, and nothing
else, because `config.toml` is created lazily on first `sfn config set` and they
had never run one. There is no `sfn config init`, no commented default file, and
no documentation page that says "this is where your settings would live."

A configuration surface that is invisible until written to is, for
discoverability purposes, absent. SFN-1256 addresses the documentation half;
this SFEP addresses the half where there is little worth documenting yet.

### 2.3 There is no precedence engine

`compiler/src/build_flags.sfn` is not a resolver. It is four env-read primitives
(lines 17-72) that every other module builds on independently, and the resulting
orders disagree:

| Concern | Order | Site |
|---|---|---|
| Registry URL | env → user config → default | `cmd_shared.sfn:116-128` |
| Target triple | CLI flag → env → host default | `build.sfn:154-196` |
| Build cache dir | env → `XDG_CACHE_HOME` → `HOME` | `build_cache.sfn:812-816` |
| Toolchain version | argv → env → project → user default → entry floor | `toolchain/dispatch.sfn`, SFEP-0073 §3.3 |

Four orderings, no shared machinery. Only one of the four consults a user config
at all, and it is the only one that has a user-config key. This is the actual
reason adding a key is expensive: there is no seam to add it to, so each key
costs a bespoke resolution path and a bespoke test.

The cost is not hypothetical either. `SAILFIN_TARGET_TRIPLE` is validated in one
place (`build.sfn:154-196`) and read unvalidated in another
(`build/target.sfn:118`); `HOME` is resolved by two byte-identical helpers
(`build_flags.sfn:24`, `capsule_resolver/paths.sfn:126`) that exist only to
break an import cycle. Duplication at the resolution layer is already producing
drift.

### 2.4 Prior art

Cargo — the tool SFEP-0073 §2 already cites as the model for rustup's UX —
puts exactly these settings in a user-level `config.toml`:

```toml
[target.aarch64-apple-darwin]
linker = "/opt/homebrew/opt/llvm/bin/ld64.lld"

[build]
jobs = 8
target-dir = "/fast/scratch/target"
```

The shape below is deliberately close to it. Boring syntax wins, and a user
arriving from Rust should not have to learn a second spelling of a setting they
already know. This is the same reasoning `CLAUDE.md` applies to language syntax,
applied to configuration.

## 3. Design

### 3.1 The admission rule

This is the load-bearing part of the proposal. Without it, the file accretes
keys until it is a second CLI.

> A setting is admissible to `~/.sfn/config.toml` if and only if it is
> **(a)** a property of the machine or of the user's standing preference, not of
> the program being built; **and**
> **(b)** safe to apply unchanged to every project on that machine; **and**
> **(c)** something a user would otherwise write into a shell profile.

Each clause excludes a real category:

- **(a)** excludes anything that changes what a program *means*. Effect
  enforcement (`SAILFIN_EFFECT_ENFORCE`, `effect_gate.sfn:84`) is the clearest
  case: a per-user setting that relaxes effect checking would make the same
  source compile on one machine and fail on another, which attacks the Reach
  pillar directly. Never admissible, at any priority.
- **(b)** excludes per-project settings. A default `[build] target` fails this
  clause and is deliberately **not** proposed in §3.2 — see §6.3.
- **(c)** excludes debug and test-harness knobs: `SAILFIN_INJECT_FAULT`
  (`emit_helpers.sfn:117`), `SAILFIN_DEBUG_FORCE_PANIC` (`ice.sfn:74`),
  `SAILFIN_TRACE_MEM_LIMIT`, and the `SAILFIN_TEST_*` family. Nobody persists a
  fault injector. These stay environment-only permanently.

Of the ~40 variables surveyed, five clear all three clauses. That ratio is the
point: the file stays small because the rule is strict, not because nobody has
asked yet.

### 3.2 The admitted keys

```toml
# ~/.sfn/config.toml

[registry]
url = "https://pkg.sfn.dev"          # existing, unchanged

[toolchain]
update-policy = "notify"             # existing, unchanged

[build]
jobs = 8                             # new — see §3.4, clamped
cache-dir = "/fast/scratch/sfn"      # new

[target.aarch64-apple-darwin]        # new — per host triple
linker = "/opt/homebrew/opt/llvm/bin/ld64.lld"
cc = "/opt/homebrew/opt/llvm/bin/clang"
```

`[target.<triple>]` is keyed by triple rather than flat so that one home
directory serves a machine that cross-compiles, and so a roaming profile does
not carry a Darwin linker path onto a Linux host. This mirrors the existing
host-qualification of the toolchain store (SFEP-0073 §3.5) and of
`toolchain-default` (`user_default.sfn:26-33`), which both learned the same
lesson.

`SAILFIN_LINKER` and `SAILFIN_CC` are read today as flat globals
(`build/link.sfn:77`, `backend.sfn:145`). The environment variables keep that
flat meaning — they are a one-shot override and the user knows which host they
are on. Only the config file is triple-keyed.

### 3.3 Precedence, stated once

For every admitted key, highest priority first:

1. **CLI flag**, where one exists (`--target`, `--jobs`)
2. **Environment variable**, where one exists
3. **Project manifest** (`capsule.toml` / `workspace.toml`), where the key is
   project-scoped — no admitted key is today, but the rung is reserved so the
   order does not change when one is
4. **User config** (`~/.sfn/config.toml`)
5. **Compiled-in default**

The user config sits *below* the environment deliberately. `SAILFIN_LINKER=...
sfn build` must keep working as a one-shot override for a user who has persisted
a different linker, and CI must be able to override a developer's file without
editing it.

This order is chosen to be compatible with what already exists rather than to be
novel: it is the registry chain (`cmd_shared.sfn:116-128`) with rungs 1 and 3
inserted, and the toolchain-version chain (SFEP-0073 §3.3) with its argv
selector generalised to CLI flags. Neither existing chain changes behaviour
under it.

### 3.4 `[build] jobs` is clamped, not honoured

A user config that could raise the emit fan-out past the host RAM budget would
be a host-kill primitive. `.claude/rules/compiler-safety.md` is explicit that
the 8 GiB `RLIMIT_AS` self-cap bounds a process, not a fleet: `N` concurrent
children means `N × 8 GiB` with nothing enforcing the aggregate, and the failure
mode is the OS killing the host, not an `sfn` error (#1245).

Therefore `[build] jobs` is an **upper bound the user may lower, never raise**:

```
effective_jobs = min(configured_jobs, _cr_ram_budget_jobs())
```

where `_cr_ram_budget_jobs()` (`capsule_emit_parallel.sfn`) keeps its current
2.5 GiB/job out of 66% of RAM sizing (SFN-626), unchanged. A configured value
above the budget is clamped with a warning to stderr naming both numbers; it is
not an error, because the same config file may be roamed onto a smaller host and
should not brick the build there.

`SAILFIN_TEST_JOBS` and the test pool's separate `_test_jobs_budget`
(`cli/commands/test/arg_and_jobs.sfn`, 3 GiB/job, SFN-781) are **out of scope**.
The two fan-outs are deliberately sized against different workloads, and the
pooled-test children are pinned to `SAILFIN_BUILD_JOBS=1` so the two cannot nest
(SFN-547). Admitting a user-level test job count would reopen that interaction
for no user-visible gain; test parallelism stays a CI and harness concern.

### 3.4.1 `[build] cache-dir` and the self-host pin

§3.3 states the precedence chain as env → manifest → user config → compiled-in
default, with no self-host rung, because at the time it was written no admitted
key interacted with SFEP-0040 §3.1's compiler self-host cache pin. The
implementation (SFN-1260) shows that `[build] cache-dir` does, and resolves it
in a way that is a deliberate deviation from a literal reading of §3.3, not an
oversight — recorded here so a later reader does not "fix" it back into one.

**(a) It sits below the SFEP-0040 §3.1 self-host pin, not directly below the
environment variable.** The pin is a hermeticity invariant — `make compile` /
`make check` must never read a developer's global store — not a preference
rung, so nothing below rung 1 may outrank it. `[build] cache-dir` is itself a
developer-global ambient store: exactly the hazard the pin exists to block, so
it cannot sit above it. An environment variable is different in kind, not just
in rank: it is typed next to the specific build it redirects, while a config
file value set months ago is passive and would otherwise silently pull the
self-host cache out of tree on every checkout its owner touches. The env var
therefore stays above the pin, so CI can still redirect the self-host cache
deliberately, while the config file cannot redirect it at all. The full ladder
implemented by `cache_root_from` (`build_cache.sfn`) is: `$SAILFIN_BUILD_CACHE_DIR`
→ self-host pin → `[build] cache-dir` → `$XDG_CACHE_HOME/sailfin` →
`$HOME/.cache/sailfin` → in-tree default.

**(b) It resolves as `<value>/<schema>`, matching the environment variable
rather than the XDG rung's extra `sailfin/` segment.** The XDG segment exists
because `$XDG_CACHE_HOME` is a directory shared across every application on the
host, so Sailfin must namespace itself under it. A directory the user names
specifically in `[build] cache-dir` is not shared — they typed it for Sailfin —
so adding the same segment would be redundant and, worse, would relocate the
store out from under a user who moves a value from `SAILFIN_BUILD_CACHE_DIR`
into the persisted file expecting no change in behavior.

**(c) It deliberately does not extend to `test_bin_cache_root` /
`runtime_obj_cache_root`.** Both stay in-tree (or follow
`SAILFIN_BUILD_CACHE_DIR` alone) regardless of `[build] cache-dir` — a
divergence already documented above `runtime_obj_cache_root` in
`build_cache.sfn`, predating this key and not created by it. The known UX
consequence: a user who sets `cache-dir` gets a partial move — the per-module
`.ll`/`.o` cache relocates, the runtime-object and per-test-binary caches do
not — and `sfn cache info` reports only the moved half. Closing that gap was
out of scope for SFN-1260.

### 3.5 Resolver seam

Each admitted key gets a resolver function in one module — proposed
`compiler/src/user_config.sfn` — with the shape:

```sfn
// Rung 4 of the §3.3 precedence chain. Returns "" when the key is absent,
// letting the caller fall through to its compiled-in default.
fn user_config_linker(triple: string) -> string ![io] { ... }
```

Callers keep their existing rung-1 and rung-2 handling and gain one fall-through
call. This is deliberately *not* a general precedence framework: rewriting four
divergent chains onto shared machinery is a larger change with its own blast
radius, and it is not needed to admit five keys. §6.4 records why.

The one piece of shared machinery this does need is a config-directory
resolver: six call sites hand-rolled `_get_home_cmd() + "/.sfn/..."` (three of
them in `config.sfn` alone). SFN-1258 resolved that seam as `user_config_dir()`
(`compiler/src/user_config.sfn`) and extended `SAILFIN_CONFIG_DIR` to cover all
three per-user records rather than the toolchain-default record alone: the
override is total, not a search path — when set, the real `~/.sfn` is not
consulted for `config.toml`, `credentials`, or `toolchain-default`, with no
read-through fallback. `toolchain_user_default_dir()`
(`compiler/src/toolchain/user_default.sfn`) now delegates to `user_config_dir()`
instead of re-deriving the path, so there is one resolver for the directory.

### 3.6 CLI surface

`sfn config` extends with no new subcommands:

```bash
sfn config set build.jobs 8
sfn config set target.aarch64-apple-darwin.linker /opt/homebrew/opt/llvm/bin/ld64.lld
sfn config get build.jobs
sfn config list          # prints every resolved key, including defaults
sfn config unset build.jobs
```

Dotted key paths map to TOML section + key. `set` validates before writing —
`jobs` must be a positive integer, `cache-dir` and the tool paths must be
absolute, `linker`/`cc` must exist and be executable at set time (a warning, not
an error: the path may be valid on another host sharing the file).

Each `set`/`unset` rewrites only its own section, matching the existing
guarantee that setting `registry` never clobbers `toolchain.update-policy`
(`config.sfn:99-116`).

`sfn config list` gains a provenance column, because a settings file whose
values you cannot trace is worse than no file:

```
build.jobs                            8       ~/.sfn/config.toml
build.cache-dir                       /fast/scratch/sfn   ~/.sfn/config.toml
target.aarch64-apple-darwin.linker    ld64.lld            SAILFIN_LINKER (env)
registry.url                          https://pkg.sfn.dev default
```

## 4. Effect & capability impact

No new effects and no change to the effect system. Reading the config file is
`![io]`, which every affected call site already declares —
`_get_home_cmd()` (`build_flags.sfn:24`) and the existing config readers
(`config.sfn:66-84`, `update_policy.sfn:74-85`) are already `![io]`.

One interaction is load-bearing and stated as a constraint rather than a
consequence: **no admitted key may affect effect checking, capability
enforcement, or manifest derivation.** §3.1 clause (a) forbids it by
construction, and `SAILFIN_EFFECT_ENFORCE` (`effect_gate.sfn:84`) is named there
as the motivating exclusion. A user-level setting that could relax the effect
gate would mean a capability manifest was derived under machine-local
configuration, which makes the manifest unattestable by the stranger the Reach
pillar promises. This is not a tradeoff to be revisited per key; it is the
boundary of the file.

The same reasoning excludes `SAILFIN_CAPSULE_FILTER`
(`capsule_resolver/reachability.sfn:274`) and `SAILFIN_RUNTIME_SOURCE_GATES`
(`build/runtime_selection.sfn:74`) permanently.

## 5. Self-hosting impact

No compiler pass changes. Nothing in the lexer, parser, AST, typechecker, effect
checker, `.sfn-asm` emitter, or LLVM lowering is touched — this is CLI and build
driver only (`compiler/src/cli/commands/config.sfn`, a new
`compiler/src/user_config.sfn`, and fall-through calls at
`build/link.sfn:77`, `backend.sfn:145`, `build_cache.sfn:812`,
`capsule_emit_parallel.sfn:48`).

The self-hosting invariant is preserved by omission: `sfn dev bootstrap build`
runs with no `~/.sfn/config.toml` on CI runners, so every rung-4 lookup returns
absent and every caller falls through to the behaviour it has today. That is the
correctness argument and also the regression risk — **CI cannot observe a
config-file bug, because CI never has the file.** §8 requires tests that
materialise one in a scratch `SAILFIN_CONFIG_DIR` rather than relying on the
ambient home.

A second-order requirement, per `.claude/rules/seed-dependency.md`: the
implementation is compiler-source, and its consumers are compiler-source, so it
bundles into a single PR and needs no seed cut. It does **not** touch runtime
source, so the `runtime/`-consumer carve-out does not apply.

## 6. Alternatives considered

### 6.1 Do nothing; record it as a Non-Goal

The status quo is defensible. Cargo shipped 1.0 without user-level defaults, and
shell exports are a working answer for the handful of users who cross-compile.
The honest version of "do nothing" is to add a Non-Goals section to SFEP-0073
saying so, since it has none today and the absence currently reads as an
oversight rather than a decision.

Rejected because clause (c) cases are real: `SAILFIN_LINKER` and `SAILFIN_CC`
are needed by every user on a machine whose default linker is wrong, which
includes any macOS user preferring Homebrew LLVM to the Xcode default. Telling
them to edit a shell profile means the setting is invisible to `sfn config
list`, unvalidated, and absent from any non-login shell — including the ones
CI, editors, and agents spawn.

Kept as the fallback: if this SFEP is rejected, the Non-Goals section is the
required consolation, and SFN-1257's acceptance criteria say so.

### 6.2 A new file (`~/.sfn/settings.toml`, or XDG `~/.config/sailfin/`)

Rejected. `~/.sfn/config.toml` is already documented, already written by `sfn
config`, already has a precedence chain, and already holds a
non-registry key (`toolchain.update-policy`). A second file would mean two
formats, two precedence stories, and a migration for no gain.

The XDG variant is more tempting — `~/.sfn` is not XDG-conformant, and the
toolchain store already lives at `~/.local/share/sailfin/`. But relocating a
documented path is a breaking change to a shipped contract, and it is
orthogonal to admitting keys. If Sailfin ever moves to XDG, it should move all
three files at once as its own proposal; SFN-1258 is where that conversation
starts.

### 6.3 Include `[build] target` (a default target triple)

Rejected on clause (b). A persisted default target applies to every project on
the machine, so a user who sets it once to cross-compile one project silently
cross-compiles all of them — including, on a compiler checkout, `sfn dev
bootstrap build`. The failure is quiet and the diagnostic points at the wrong
layer.

`SAILFIN_TARGET_TRIPLE` remains available for the same job with a lifetime that
matches its blast radius. If a persisted target is wanted later, its home is the
project manifest (rung 3), not the user config.

### 6.4 Build the general precedence engine first

Tempting, and §2.3 is a real problem: four divergent chains is drift waiting to
happen. Rejected as the *first* move on sequencing grounds — unifying four
resolution paths touches the registry chain, the target chain, the cache chain,
and toolchain dispatch, the last of which is SFEP-0073 machinery that is
mid-delivery at milestone 4 of 5. Landing a refactor across it while it is still
being built is how you get a self-host break that nobody can bisect.

§3.5's per-key resolver is the smaller move that does not foreclose the larger
one: five functions in one module are a seam a future engine can absorb. The
engine should be its own SFEP once SFEP-0073 completes, and §2.3's table is its
motivation section, pre-written.

### 6.5 Let `[build] jobs` raise the fan-out as well as lower it

Rejected outright; see §3.4. The user asking for more parallelism cannot
observe the aggregate memory ceiling, the self-cap does not enforce it, and the
failure mode is a dead host (#1245). A setting whose worst case is losing the
machine does not get a "trust the user" default.

## 7. Stage1 readiness mapping

This is a tooling SFEP: it adds no language construct, so the syntax and codegen
rungs are not applicable and are marked as such rather than left to imply
pending work.

- [x] Parses — n/a, no new syntax
- [x] Type-checks / effect-checks — n/a, no new construct; new code is ordinary
      `![io]` and checked as such
- [x] Emits valid `.sfn-asm` — n/a, no lowering change
- [x] Lowers to LLVM IR — n/a
- [ ] Regression coverage — §8
- [ ] Self-hosts — `sfn dev bootstrap build`; structural (new module) so
      `--clean-tree` per `.claude/rules/selfhost-invariant.md`
- [ ] `sfn fmt --check` clean
- [ ] Documented — `site/src/content/docs/docs/reference/cli.md` `sfn config`
      section, and the new on-disk-layout page (SFN-1256)

## 8. Test plan

`compiler/tests/`, Sailfin `*_test.sfn` only — no shell (`.claude/rules/no-bash-e2e.md`).

Every test materialises its own config file under a scratch `SAILFIN_CONFIG_DIR`
and drives `sfn` through `process.run_capture`, using
`clean_runner_env(nested_runner_scratch("<label>"))` so the child does not
inherit the parent pool's orchestration keys (SFN-401). No test may read or
write the real `~/.sfn` — §5 notes that CI has no config file, which makes an
ambient-home test both non-hermetic and silently vacuous.

**Unit** — pure resolution, no subprocess:
- each admitted key resolves from config text
- absent key returns absent, not a default (fall-through is the caller's job)
- unknown key and malformed TOML are ignored with a stderr warning, never fatal
- `[target.<triple>]` selects by host triple; a section for another triple is
  not consulted
- jobs clamp: configured below budget passes through; above budget clamps and
  warns; zero and negative are rejected at `set`

**Integration** — precedence, one test per adjacent rung pair:
- env beats config (`SAILFIN_LINKER` over `[target.*] linker`)
- CLI flag beats env (`--jobs` over `SAILFIN_BUILD_JOBS`)
- config beats compiled-in default
- setting one section leaves the others byte-identical, extending the existing
  `registry` / `update-policy` isolation coverage

**E2E** — the observable contract:
- `sfn config set`/`get`/`unset` round-trip for each key, including the dotted
  `target.<triple>.linker` path
- `sfn config list` shows provenance, and the provenance changes when the same
  key is also set in the environment
- a build with `[target.<triple>] linker` set to a recorded shim invokes that
  shim — the only test proving the value reaches the linker rather than merely
  parsing
- a config file with a jobs value above budget builds successfully, clamped

**Regression guard:** one test asserting that no admitted key can alter effect
checking — a capsule that fails `E0402` fails identically with every admitted
key set to every legal value. This is the §4 boundary made executable, and it is
the test that must never be deleted.

## 9. References

- SFN-1257 — this SFEP's design gate
- Implementation slices, in delivery order:
  - SFN-1259 (A) — resolver seam + `[target.<triple>]` linker/cc; blocks B and D
  - SFN-1260 (B) — `[build] cache-dir` + clamped `[build] jobs` (§3.4)
  - SFN-1261 (C) — `sfn config` dotted keys, validation, list provenance (§3.6);
    independent of A and B
  - SFN-1262 (D) — the §4 effect-boundary regression guard; never-delete
- SFN-1256 — on-disk layout reference page (`graduates-to` target)
- SFN-1258 — extended `SAILFIN_CONFIG_DIR` from the toolchain-default record
  alone to all three per-user records (`config.toml`, `credentials`,
  `toolchain-default`), with total, non-read-through override semantics. The
  §3.5 resolver (`user_config_dir()`) SFN-1259 introduced is the single seam
  that reads the variable
- SFEP-0073 — Installed Toolchain Lifecycle; §3.3 precedence and §3.5
  host-qualification are the models followed here
- SFEP-0046 — Native Toolchain Version Pinning + Dispatch; establishes
  `~/.sfn` as the config root
- SFEP-0002 — Capsule Distribution; establishes `[registry] url` and the
  `SFN_REGISTRY` → config → default chain
- `.claude/rules/compiler-safety.md` — the RAM budget §3.4 clamps against
- `.claude/rules/seed-dependency.md` — bundling rationale in §5
- Prior art: Cargo `config.toml` `[build]` / `[target.<triple>]`; rustup
  `settings.toml`
