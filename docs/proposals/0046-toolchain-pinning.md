---
sfep: 0046
title: Native Toolchain Version Pinning + Dispatch
status: Accepted
type: tooling
created: 2026-07-09
updated: 2026-07-09
author: "agent:compiler-architect; human review: Michael Curtis"
tracking: SFN-167, SFN-168, SFN-169, SFN-170, SFN-171, SFN-172
supersedes:
superseded-by:
graduates-to:
---

# SFEP-0046 — Native Toolchain Version Pinning + Dispatch

## 1. Summary

A Sailfin project has no native way to declare which `sfn` toolchain builds it.
This SFEP adds a `[toolchain]` section to `capsule.toml` and `workspace.toml`
where a project pins the required `sfn` version, and teaches `sfn
build/run/check/test` to (Phase 1) **read and verify** the running toolchain
against that pin, and (Phase 2) **fetch and dispatch** to the pinned toolchain
when it is not the one on `PATH` — so a fresh clone plus `sfn build` "just
works." This is the downstream-consumer analogue of Go's `go 1.22` directive +
Go 1.21 toolchain auto-download, `rust-toolchain.toml`, and
`package.json`/corepack. It deliberately keeps the compiler repo's own
`.seed-version` bootstrap plumbing out of user projects: `[toolchain]` is the
user-facing surface; `.seed-version` stays an internal self-hosting seed pin.

## 2. Motivation

### The gap

Today the **only** version-pinning mechanism in the repository is
`.seed-version` (currently `0.8.0-alpha.2`, a bare semver line), consumed by
`make fetch-seed` / `install.sh` / the `Makefile`. That file exists to pin the
**seed binary that self-hosts the compiler** — it is bootstrap plumbing for
*this* repo. A downstream product capsule (the first real one being
`SailfinIO/sfn-gateway`) has nothing: it can `sfn init` and `sfn build`, but the
manifest cannot say "this project must be built with `sfn` 0.8.0-alpha.2." A
teammate or CI runner with a different `sfn` on `PATH` silently builds against
the wrong compiler, and the failure — if any — surfaces as a confusing type or
codegen error rather than "your toolchain is too old."

Concretely, I verified that a `[toolchain]` stanza is **silently ignored**
today. `_parse_toml_internal` (`compiler/src/toml_parser.sfn:163`) recognizes
only the sections `capsule`, `build`, `workspace`, `exports`, `dependencies`,
`dev-dependencies`, and `capabilities` (the `if strings_equal(section, ...)`
ladder at lines 200–246). An unknown section header sets the `section` local to
`"toolchain"` and every subsequent key falls through the ladder unmatched. So
`sfn check`/`sfn build` succeed with `[toolchain] sfn = "0.8.0-alpha.2"` present
— it parses as TOML but is read by nothing. There is no field for it on the
`SailToml` struct (`toml_parser.sfn:7`).

### Prior art (why every serious toolchain solves this)

- **Go** — `go.mod` carries a `go 1.22` directive. Since Go 1.21 a `toolchain
  go1.21.4` line (and the bare `go` line as a floor) makes the `go` command
  **auto-download and re-exec** the named toolchain when the local one is older,
  from `https://proxy.golang.org` with checksum verification via `go.sum`/the
  checksum DB. A fresh machine with any Go ≥1.21 builds a Go 1.22 project
  correctly with zero manual steps. This is the model Phase 2 mirrors most
  closely.
- **Rust** — `rust-toolchain.toml` (`[toolchain] channel = "1.78.0"`) is read by
  the `rustup` proxy shims; `cargo`/`rustc` on `PATH` are shims that dispatch to
  the channel the project pins, installing it on demand.
- **Node** — `package.json` `engines.node` is a *soft* check (npm warns/errors);
  `packageManager: "pnpm@9.1.0"` + **corepack** is the *hard* version: corepack
  shims `pnpm`/`yarn` and fetches the exact pinned version, verifying an integrity
  hash.

The common shape: a **declaration in the manifest**, a **verification** step in
the everyday build command, and an **auto-fetch + dispatch** so the pin is
self-fulfilling. Sailfin should match this boring, well-understood convention
rather than invent a novel mechanism.

### Why not just document `make`

`make`/`install.sh` are the compiler-repo bootstrap. A downstream capsule has no
`Makefile` and must never inherit the seed ritual — that plumbing knows about
`.seed-version`, the seed cache under `build/seed`, and `<seed> build -p
compiler`, none of which are meaningful to a product. The user story is `sfn
init` → edit code → `sfn build`, with the toolchain pinned **in the same manifest
the user already edits**.

## 3. Design

Two phases. Phase 1 (declare + verify) is shippable on its own and is the
gate `sfn-gateway` waits on. Phase 2 (fetch + dispatch) layers on top without
changing the Phase 1 schema.

### 3.1 Manifest schema — the `[toolchain]` section

```toml
# capsule.toml (or workspace.toml)
[toolchain]
sfn = "0.8.0-alpha.2"        # required: the pinned toolchain version
channel = "alpha"            # optional: prerelease channel gate (see §3.3)
```

Decisions and rationale:

- **Key name is `sfn`**, mirroring Go's `go 1.22` (the tool's own name is the
  key). One key, one string. This reads naturally: "`[toolchain] sfn =
  "0.8.0-alpha.2"`".
- **Value is a floor semver** (**DECIDED: Go-style floor**, not exact-pin, not an
  NPM-style range). A bare `"0.8.0-alpha.2"` is a **minimum floor** in the spirit
  of Go's `go` directive: the running toolchain must be `>=` the pin (see §3.3 for
  how prereleases order). This matches user intent ("built with at least this")
  and lets a project keep building under newer patch/alpha toolchains without a
  manifest edit, and it avoids shipping a full range-grammar parser pre-1.0.
  Exact-pin (`rust-toolchain.toml`-style "must equal") was rejected as the default
  because it forces a manifest bump on every toolchain upgrade; the schema is
  identical either way, so a future exact/range mode is a one-predicate addition
  in §3.3 without a schema change.
- **`channel` is optional and advisory in Phase 1.** When present it names the
  minimum acceptable prerelease channel (`stable` > `rc` > `beta` > `alpha`).
  Its primary job is to make prerelease comparison legible and to let a project
  say "I require a stable toolchain" (`channel = "stable"`) without naming a
  version it can't yet know.
- **No `[toolchain] dependencies`/component list** (rustup's `components`) — out
  of scope; Sailfin has one binary, not a multi-component distribution.

Parsing lands as an additive `section == "toolchain"` arm in
`_parse_toml_internal` plus two fields on `SailToml`
(`toolchain_sfn: string`, `toolchain_channel: string`) and a string-based
accessor `toml_get_toolchain_sfn(text) -> string` / `toml_get_toolchain_channel`
alongside the existing `toml_get_*` API (`toml_parser.sfn:252+`). Because the
old parser already ignores unknown sections, **an old `sfn` reading a manifest
that pins a newer `sfn` simply ignores the pin** — the additive-parse property
that keeps self-hosting safe (see §5).

### 3.2 Version comparison — the missing primitive

The repository has **no semver comparison** today. `version.sfn` only *extracts*
a version string (`resolve_compiler_version`, `toml_get_version`); nothing
compares two versions or orders prereleases. Both phases need this, so Phase 1
introduces a small, well-tested semver module.

Proposed: `compiler/src/semver.sfn` exporting:

```sfn
struct SemVer {
    major: int; minor: int; patch: int;
    prerelease: string;   // "" for a release; e.g. "alpha.2"
    // build metadata after '+' is parsed and ignored for ordering (semver §10)
}

fn semver_parse(text: string) -> SemVer         // tolerant of a leading 'v'
fn semver_compare(a: SemVer, b: SemVer) -> int  // -1 / 0 / +1, semver §11 order
fn semver_satisfies_floor(running: SemVer, pin: SemVer) -> boolean
```

Ordering follows semver §11 precedence: numeric fields compared numerically; a
release outranks any prerelease of the same core (`1.0.0 > 1.0.0-alpha`);
prerelease identifiers compared left-to-right, numeric identifiers numerically,
alphanumeric lexically. This is the one piece of genuinely new logic; everything
else is manifest plumbing and CLI orchestration.

### 3.3 Verification behavior (Phase 1)

Where it hooks in: `sfn build`, `sfn run`, `sfn check`, and `sfn test` all
resolve a project root via `discover_project_root` / `discover_workspace_root`
(`capsule_resolver.sfn:90+`). Immediately after the manifest is read for a
project build, a new `toolchain_gate` step runs:

1. Read `[toolchain] sfn` from the project manifest (and, if a workspace root is
   found, the `workspace.toml` `[toolchain]` — the workspace pin is the default;
   a member `capsule.toml` `[toolchain]` overrides it for that member). If
   absent → **no-op**, current behavior preserved (unpinned projects keep
   working; this must be true so the feature is additive for the whole existing
   ecosystem).
2. Resolve the running toolchain version via the existing
   `resolve_compiler_version(binary_dir)` (`version.sfn:130`).
3. Compare with `semver_satisfies_floor(running, pin)`.
4. On satisfaction → proceed silently. On mismatch → Phase 1 behavior below.

**Mismatch behavior (Phase 1, no auto-fetch yet):**

- Default: **hard error** with a clear, actionable diagnostic and a non-zero
  exit. Rationale — a silent warn (Node `engines` default) trains users to
  ignore it, violating "don't ship unfinished safety claims." Precedent: Go
  errors when the local toolchain is older than the `go` directive and
  auto-download is off (`GOTOOLCHAIN=local`).
- Message shape (an ordinary CLI diagnostic, not an `E0xxx` typecheck code —
  this is a driver gate, not source analysis):

  ```
  error: toolchain mismatch
    this project pins sfn >= 0.8.0-alpha.2 (capsule.toml [toolchain])
    but the running toolchain is 0.7.4-alpha.1
    install the pinned toolchain, or re-run with --skip-toolchain-check to override
  ```

- **Override flag `--skip-toolchain-check`** (and env `SAILFIN_SKIP_TOOLCHAIN_CHECK=1`
  for CI) downgrades the hard error to a one-line warning and proceeds. This is
  the escape hatch for "I know what I'm doing" and for the compiler's own repo
  during a transition.
- **Prerelease direction:** because alpha < the corresponding release, a project
  pinning `0.8.0-alpha.2` is satisfied by `0.8.0-alpha.2`, `0.8.0-alpha.3`,
  `0.8.0`, `0.9.0`, etc., and **rejected** by `0.8.0-alpha.1` or `0.7.x`. If
  `channel = "stable"` is set, any `-alpha`/`-beta`/`-rc` running toolchain is
  rejected regardless of core version.

### 3.4 `sfn init` scaffolding

`toml_generate` (`toml_parser.sfn:537`) and `sfn init`
(`cli/commands/init.sfn:66`) gain a `[toolchain]` stanza in the generated
manifest, pinned to the **version of the `sfn` doing the scaffolding**
(`resolve_compiler_version` is already available in the driver). So a project
created with `sfn 0.8.0-alpha.2` is born pinning it — matching `cargo new`
stamping the edition and Go's `go mod init` writing the `go` line. `init` is
`![io]`, which is enough to read the running version; no new effect.

### 3.5 Fetch + dispatch (Phase 2)

When verification (§3.3) fails **and** auto-fetch is enabled, instead of
erroring, `sfn` fetches the pinned toolchain and **re-execs** it, transparently.
This is the Go 1.21 / corepack behavior.

**Store layout — reuse, don't reinvent.** `install.sh` already installs versioned
toolchains to `~/.local/share/sailfin/versions/<version>/` (INSTALL_BASE,
`install.sh:240`) with the alias symlink `sfn` in the bin dir. Phase 2 fetches
into the **same** store so a `sfn`-fetched toolchain and an `install.sh`-installed
one are interchangeable:

```
~/.local/share/sailfin/versions/
  0.8.0-alpha.2/
    sailfin              # the binary
    runtime/             # bundled runtime (install.sh already ships this)
    .sha256              # recorded digest of the downloaded tarball
```

(Configuration and the capsule cache stay under `~/.sfn/` — `config.toml`,
`cache/capsules/` per `cmd_shared.sfn:101`. The *toolchain* store stays under the
existing `~/.local/share/sailfin/versions` to converge with `install.sh`.
`SAILFIN_HOME`/`INSTALL_BASE` overrides honored.)

**Fetch is native `.sfn` — no shelling out to bash.** (**DECIDED: native
Sailfin, not a shell-out to `install.sh`.**) The fetch/verify/extract path is a
new `sfn toolchain install` command implemented in Sailfin with `![io, net]`,
matching the pure-Sailfin-toolchain 1.0 goal — the toolchain must not depend on a
bash installer to bootstrap itself. It reuses only the *release-asset layout*
`install.sh` established (asset name `sailfin_<version>_<os>_<arch>.tar.gz` at
`https://github.com/SailfinIO/sailfin/releases/download/<tag>/<asset>`, OS in
{linux, macos, windows}, arch in {x86_64, arm64}), not the script itself. The
native command owns asset resolution, prerelease selection, download, signature +
digest verification (below), extraction, and the version-store symlink. `install.sh`
remains only as a one-shot *initial* installer for a machine with no `sfn` at all
(the chicken-and-egg bootstrap); once any `sfn` is present, all further toolchain
acquisition is native. Accepting native fetch means the compiler's own
`[capabilities] required` gains `net` — see §4; this is the deliberate,
production-grade choice, not a side effect.

**Dispatch.** After ensuring `~/.local/share/sailfin/versions/<pin>/sailfin`
exists, the current process **re-execs** it with the original argv (a
`process.exec`-style replacement, not a subprocess, so exit codes and signals
pass through — Go re-execs; corepack spawns). A **re-entrancy guard**
environment variable (`SAILFIN_TOOLCHAIN_DISPATCHED=<pin>`) is set before re-exec
so the dispatched toolchain, which will also read `[toolchain]` and satisfy the
floor, does not attempt to dispatch again (and to hard-fail loudly if a fetched
toolchain still doesn't satisfy the pin — a corrupt store or a bad release).

**Trust model (production-grade, mandatory verification).** A downloaded toolchain
is executable code that `sfn` is about to re-exec, so verification is not optional
and not best-effort — it is a **fail-closed gate** modelled on what a production
toolchain does (Go's checksum database + signed releases; corepack's integrity
hashes; rustup's signed manifests):

- **Signed release-digest manifest.** (**DECIDED: build the signing root; it is a
  hard prerequisite of Phase 2 shipping.**) Each release publishes a
  `SHA256SUMS` manifest of its assets plus a detached signature over that manifest
  (a minisign/cosign-class Ed25519 signature). The signing **public key is
  embedded in the `sfn` binary** (pinned at build time), so verification needs no
  network trust-on-first-use. This is the supply-chain root; TLS + GitHub
  integrity alone is explicitly **not** sufficient to execute downloaded code.
- **Verification order (fail closed at each step).** Download the asset →
  download `SHA256SUMS` + its signature → verify the signature against the
  embedded public key → confirm the asset's SHA-256 is the one the manifest lists
  → only then extract, record `.sha256` in the store, and mark the version usable.
  Any failure aborts **before** the toolchain is extracted or executed, with a
  clear error; a corrupt or unsigned asset is never re-exec'd.
- **Reuse re-verification.** On every dispatch to an already-stored toolchain,
  the recorded `.sha256` is re-checked against the on-disk binary before re-exec,
  so a tampered store is caught too.
- **Auto-dispatch defaults ON** (`SAILFIN_TOOLCHAIN=auto`), matching Go's
  default — a fresh clone + `sfn build` transparently fetches, *verifies*, and
  dispatches the pinned toolchain. This is safe to default-on **because**
  verification is mandatory and fail-closed: we never silently execute unverified
  code, so the production-grade behavior is the transparent one. `local`/`off`
  remain available for air-gapped or CI-preinstalled environments (see the knob
  below).

**Offline behavior.** If fetch is needed but the network is unavailable (or the
knob is `local`), fall back to the Phase 1 hard error naming the exact
`sfn toolchain install <version>` command the user can run when back online. An
already-fetched toolchain in the store is used offline with digest
re-verification — no network needed once the pin is present locally.

**`GOTOOLCHAIN`-style control knob.** A single env/config lever governs the whole
behavior, matching Go's `GOTOOLCHAIN`:

| `SAILFIN_TOOLCHAIN` | Behavior |
|---|---|
| `auto` (**default in Phase 2**) | verify the pin; on mismatch fetch + *verify* + dispatch |
| `local` (default in Phase 1) | verify only; hard error on mismatch, never fetch |
| `<version>` | force dispatch to that exact version regardless of the pin |
| `off` | skip the gate entirely (equivalent to `--skip-toolchain-check`) |

Signature/digest verification is mandatory whenever a toolchain is fetched or
dispatched and is **not** disabled by any knob value except `off` (which skips the
gate wholesale for explicit air-gapped/CI use).

## 4. Effect & capability impact

No language-semantics or effect-system change — **no new effect keyword, no new
effect-checker rule**. The only capability-surface change is on the compiler's own
manifest, and it is a **deliberate, accepted decision** (native fetch):

- Phase 1 (parse `[toolchain]`, compare versions, gate the build) is pure driver
  orchestration. Reading the manifest and the running version is already `![io]`
  (the build commands are `![io]`); `semver.sfn` parsing/comparison is `![pure]`.
- Phase 2's native `sfn toolchain install` fetch path is `![io, net]` — the only
  new effect surface, living in a toolchain-management command, not in the
  language. Because the fetch is native (not a shell-out), **the compiler's own
  `[capabilities] required` gains `net`** (from `["io", "clock"]`,
  `compiler/capsule.toml`). This is **DECIDED and accepted**: a self-fetching
  toolchain legitimately needs the network capability, and declaring it honestly
  is exactly the capability model working as intended (the compiler's own manifest
  states the authority it actually uses). Verification (§3.5) uses only in-process
  crypto over already-downloaded bytes, so it adds no further effect beyond the
  `net` fetch itself.

## 5. Self-hosting impact

**No compiler *pass* changes** — this touches only the manifest parser
(`toml_parser.sfn`), the driver/CLI (`capsule_resolver.sfn` project-root path,
`cli/commands/*`, a new `semver.sfn`), and scaffolding (`init.sfn`). Lexer,
parser, AST, typecheck, effect-checker, native emitter, and LLVM lowering are
untouched.

The additive-parse property is the self-hosting safety net:

- **The `[toolchain]` section is additively parsed.** An **old seed** compiling
  the **new compiler** never sees new syntax — `[toolchain]` is data in a `.toml`
  file, not `.sfn` source. The new `.sfn` code that *reads* the section (the new
  `SailToml` fields, the `toolchain_gate` call, `semver.sfn`) is ordinary
  Sailfin the old seed already compiles. So `make compile` builds the new
  compiler from the pinned `0.8.0-alpha.2` seed with no seed cut — this is a
  bundled capability+consumer change in one PR (`.claude/rules/seed-dependency.md`
  default), not a seed-blocker.
- **The compiler repo dogfoods `[toolchain]`.** (**DECIDED: yes — the compiler
  adopts its own mechanism.**) `.seed-version` and `[toolchain]` coexist for
  distinct jobs:
  - `.seed-version` **stays** as the seed pin for `make compile` self-hosting — it
    names the *seed binary that bootstraps the compiler*, a repo-internal concept
    nothing downstream should learn.
  - The compiler's `capsule.toml` **also gains a `[toolchain] sfn` stanza** and
    the gate runs on the compiler's own build, so the toolchain eats its own dog
    food: the same verification a product gets. Floor semantics make this
    well-behaved — the seed's version *is* the pin, so `make compile` from the
    pinned seed satisfies the floor; a newer seed also satisfies it. The only
    hazard is the reverse (an *older* seed against a source that raised its
    `[toolchain]` pin), which is exactly the case the gate *should* catch. The
    seed bump does both edits together: `/pin-seed` advances `.seed-version` and
    the `[toolchain]` pin in the same change, and `--skip-toolchain-check` /
    `SAILFIN_TOOLCHAIN=off` is wired into `make compile` as the escape hatch for a
    mid-transition self-build. This keeps the mechanisms honestly aligned rather
    than exempting the compiler from the rule it ships.

## 6. Alternatives considered

- **Keep `.seed-version` and document a `make`-style ritual for users.** Rejected:
  `.seed-version` + `make` is repo-internal bootstrap plumbing; a product capsule
  has no `Makefile` and must not inherit the seed cache / `<seed> build -p
  compiler` machinery. Leaking it into user projects couples every consumer to
  the compiler's self-hosting internals.
- **An environment variable only (`SAILFIN_TOOLCHAIN=0.8.0-alpha.2`).** Rejected
  as the *primary* mechanism: env vars aren't checked into the repo, so they don't
  travel with the project or pin CI reproducibly. Retained as an *override* knob
  (`SAILFIN_TOOLCHAIN`, §3.5) exactly as Go keeps `GOTOOLCHAIN` alongside the
  `go.mod` directive.
- **A separate `sfn-toolchain.toml` (à la `rust-toolchain.toml`).** Rejected:
  Sailfin already has a single project manifest the user edits (`capsule.toml`);
  splitting the toolchain pin into a second file adds a file to discover and keep
  in sync for no gain. Go puts the directive in `go.mod`, not a side file; we
  follow that. (Rust's separate file is a historical artifact of `rustup` predating
  a manifest field.) `workspace.toml` `[toolchain]` covers the multi-capsule case.
- **A `sfnup` external version manager (rustup/nvm-style shim).** Rejected as the
  *baseline* because it requires users to install a *second* tool before `sfn`
  works, and shims add a layer of indirection and PATH fragility. The Go 1.21 model
  — the tool dispatches itself — is strictly better UX for the common case and is
  what Phase 2 implements. A `sfnup`-style manager could still be built later on
  top of the same store layout for users who want explicit multi-version
  management; nothing here precludes it.
- **NPM-style range expressions (`^0.8`, `>=0.8, <0.9`).** Rejected for the
  initial cut: a range grammar is more parser surface and more comparison logic
  than a single floor pin needs pre-1.0, and Go's single-directive model has
  proven sufficient. `semver.sfn` is structured so a range predicate can be added
  later without changing the schema.
- **Shell out to `install.sh` for the Phase 2 fetch.** Rejected: it would keep
  bash on the toolchain's own bootstrap path, against the pure-Sailfin-toolchain
  1.0 goal, and it splits the trust/verification code across a script the compiler
  can't statically reason about. Phase 2 fetches natively (`sfn toolchain install`,
  `![io, net]`) and reuses only the release-asset *layout* `install.sh` established
  (§3.5). `install.sh` survives solely as the one-shot installer for a machine with
  no `sfn` yet.

## 7. Stage1 readiness mapping

This is a **tooling/driver** SFEP: it adds no language syntax, AST node, or IR.
The codegen rows are therefore N/A by construction and are marked so honestly.

- [ ] Parses — N/A for `.sfn` grammar; the change is TOML-section parsing in
  `toml_parser.sfn` (a new `section == "toolchain"` arm + `SailToml` fields).
- [ ] Type-checks / effect-checks — N/A; no new effect rule. The new `.sfn` code
  (`semver.sfn`, the gate, `init` scaffolding) type/effect-checks as ordinary
  driver code (`sfn check`).
- [ ] Emits valid `.sfn-asm` — N/A; no new AST/IR node.
- [ ] Lowers to LLVM IR — N/A; no new lowering.
- [ ] Regression coverage — see §8 (unit tests for `semver.sfn`, integration for
  the gate, e2e for init scaffolding and dispatch).
- [ ] Self-hosts — required: `make compile` must build the new compiler from the
  0.8.0-alpha.2 seed (additive, no seed cut — §5).
- [ ] `sfn fmt --check` clean — required on every touched `.sfn` file.
- [ ] Documented in `docs/status.md` + a tooling reference chapter (the
  `[toolchain]` manifest section and the `SAILFIN_TOOLCHAIN` knob).

Phase 1 clears this list for the verify feature; Phase 2 re-clears it for
fetch/dispatch (with the added `![io]`/`![net]` note from §4).

## 8. Test plan

**Unit (`compiler/tests/unit/`):**

- `semver_parse_test.sfn` — parses `1.2.3`, `v1.2.3`, `0.8.0-alpha.2`,
  `1.0.0-alpha.10`, build metadata (`1.0.0+abc`), and malformed input.
- `semver_compare_test.sfn` — the §11 ordering matrix: numeric fields, release >
  prerelease of same core, `alpha.2 < alpha.10` (numeric identifier), prerelease
  vs. prerelease left-to-right.
- `toml_toolchain_parse_test.sfn` — `toml_get_toolchain_sfn`/`_channel` extract
  the pin; a manifest with **no** `[toolchain]` returns empty (unpinned no-op);
  an old-parser regression asserting an unknown section is still ignored.

**Integration (`compiler/tests/integration/`):**

- `toolchain_gate_test.sfn` — with a fixture manifest pinning a version equal
  to / below / above the running toolchain, assert satisfy / satisfy / hard-error
  respectively; assert `--skip-toolchain-check` downgrades the error to a warning
  and proceeds; assert `channel = "stable"` rejects an `-alpha` running toolchain.

**E2E (`compiler/tests/e2e/`, `*_test.sfn` per `.claude/rules/no-bash-e2e.md`):**

- `init_toolchain_stanza_test.sfn` — `sfn init` in a temp dir writes a
  `[toolchain] sfn = "<running version>"` stanza (drive the subprocess with
  `process.run_capture`, read the generated `capsule.toml`, assert `find` locates
  the pin).
- `toolchain_gate_e2e_test.sfn` — build a fixture capsule pinning a version above
  the running one; assert `sfn build` exits non-zero with the "toolchain mismatch"
  message; assert `SAILFIN_SKIP_TOOLCHAIN_CHECK=1` (threaded via the child env)
  makes it succeed.
- Phase 2 `toolchain_dispatch_test.sfn` — with a stub toolchain pre-seeded into a
  temp store (no real network), assert re-exec dispatch selects it and the
  re-entrancy guard prevents a loop; assert digest mismatch is refused; assert
  offline-with-store-present succeeds and offline-without-store gives the
  actionable install hint. (Real GitHub fetch is exercised behind a network guard
  that *skips* when offline, mirroring the tool-probe skip pattern in the e2e
  rules.)

## 9. References

- `docs/proposals/0002-package-management.md` — capsule/model management, `sfn
  add` + `capsule.lock`, the `https://pkg.sfn.dev` registry, `~/.sfn/` cache
  layout. `[toolchain]` is the toolchain analogue of that capsule-pinning story;
  the store reuses the `~/.sfn/` config + `~/.local/share/sailfin/versions`
  install layout.
- `docs/proposals/0003-tooling.md` — the built-in tooling surface (`sfn
  init/build/run/check/test`) this SFEP extends with the gate.
- `install.sh` — the one-shot bootstrap installer whose release-asset *layout*
  (asset naming `sailfin_<version>_<os>_<arch>.tar.gz`, GitHub-release fetch,
  INSTALL_BASE `~/.local/share/sailfin/versions`, prerelease selection) the native
  `sfn toolchain install` reuses. Phase 2 does **not** shell out to it (§3.5, §6).
- `compiler/src/toml_parser.sfn` (`_parse_toml_internal:163`, `SailToml:7`,
  `toml_generate:537`) — the section-parse ladder that silently ignores unknown
  sections today and where `[toolchain]` parsing lands.
- `compiler/src/version.sfn` (`resolve_compiler_version:130`,
  `__version_fallback__:15`) — running-toolchain version resolution the gate
  compares against.
- `compiler/src/capsule_resolver.sfn` (`discover_project_root`,
  `discover_workspace_root:90+`) — where the gate hooks into the project-build
  path.
- `compiler/src/cli/commands/init.sfn` — scaffolding that will stamp the
  `[toolchain]` stanza.
- `.seed-version` (`0.8.0-alpha.2`) — the internal seed pin that stays
  bootstrap-only and is **not** superseded for the compiler repo.
- **Prior art:** Go `go`/`toolchain` directives + `GOTOOLCHAIN` (auto-download
  since Go 1.21); `rust-toolchain.toml` + `rustup` proxy shims; `package.json`
  `engines`/`packageManager` + corepack.
- **First consumer:** `SailfinIO/sfn-gateway` — the first downstream product
  capsule. It will carry a forward-looking `[toolchain]` stanza *now* (harmlessly
  ignored by the current parser, per §2/§5) and becomes the acceptance driver for
  Phase 1: once the gate ships, a fresh `sfn-gateway` clone verifies (Phase 1)
  and eventually auto-dispatches (Phase 2) its pinned toolchain with no manual
  step.
```
