---
sfep: 73
title: Installed Toolchain Lifecycle, Exact Selection, and Update Policy
status: Accepted
type: tooling
created: 2026-08-22
updated: 2026-08-22
author: "agent:compiler-architect; project owner direction + acceptance"
tracking:
supersedes:
superseded-by:
graduates-to:
---

# SFEP-0073 — Installed Toolchain Lifecycle, Exact Selection, and Update Policy

## 1. Summary

Sailfin already has the hard substrate of a production toolchain manager:
versioned installs, signed native acquisition, project minimum-version gates,
and automatic re-exec dispatch (SFEP-0046). It does not yet expose that
substrate as a coherent user workflow. `sfn toolchain` can install a version but
cannot list, select, inspect, update, verify, or remove one; the project field
called a pin is a compatibility floor rather than an exact compiler selection;
and updating the default compiler still requires re-running a bootstrap script.

This SFEP completes that product surface without introducing a separate
`sfnup`: exact project selection alongside the existing floor, deterministic
selection precedence, one-shot and global switching, installed-toolchain
lifecycle commands, explicit native updates, bounded opt-out update notices,
and post-install integrity verification. The executable found on `PATH` remains
the self-hosted entry toolchain and dispatches to versioned payloads in the
existing store. Normal compiler commands become reproducible; update discovery
never silently changes the compiler used by a project.

## 2. Motivation

### 2.1 The infrastructure is ahead of the UX

The installer and SFEP-0046 already converge on a version store under
`~/.local/share/sailfin/versions/<version>/`. `sfn toolchain install <version>`
downloads a release natively, verifies its signed `SHA256SUMS` and archive
digest, extracts it with the in-process path guard, and writes the completeness
marker last. `sfn build`, `run`, `check`, and `test` can then fetch and re-exec a
project's missing floor version automatically.

The public management surface has only one leaf, however:

```text
sfn toolchain install <version>
```

Installing `0.10.3` does not tell a user how to run it. There is no supported
answer to any of these ordinary questions:

- Which versions are installed?
- Which version will this directory use, and why?
- How do I test once with an older compiler?
- How do I make a release the user default without rerunning a remote script?
- Is an update available, and will accepting it alter this project's compiler?
- Can an old toolchain be removed safely?
- Has a stored toolchain changed since it was verified at install time?

The direct versioned path can be invoked by an expert, and the install script
can republish the global command, but neither is an acceptable primary
interface. A production language makes selection visible and deliberate.

### 2.2 A minimum version is not an exact build input

SFEP-0046 deliberately gave `[toolchain] sfn = "V"` floor semantics: any running
compiler at least as new as `V` satisfies the manifest. That is a compatibility
requirement, not a reproducibility guarantee. If Alice has `0.10.4` on `PATH`
and CI has `0.11.0`, both satisfy a `0.10.4` floor and may compile the same
checkout with different frontend, lowering, runtime, cache-schema, or
diagnostic behavior.

Floor semantics remain valuable. A library can state the oldest compiler it is
intended to support, and a newer compiler should not require a manifest edit
merely to consume it. Root applications, workspaces, CI, release builds, and
the Sailfin compiler checkout need a second fact: the exact compiler selected
for work in that root. Conflating those facts makes either compatibility or
reproducibility lose.

Sailfin is pre-1.0 and self-hosting. Exact compiler identity is therefore a
load-bearing build input, not a convenience feature.

### 2.3 Updates are policy, not a background side effect

The current update instructions re-run `install.sh` or `install.ps1`. That is a
reasonable chicken-and-egg bootstrap for a machine with no Sailfin compiler,
but it should not remain the steady-state lifecycle after a trusted `sfn`
exists.

At the same time, a background service or silent compiler replacement would be
the wrong correction. It would introduce hidden network activity, surprise
air-gapped and managed environments, interfere with package-manager ownership,
and make a previously green checkout use a different compiler without a
manifest change. Update discovery and update installation are distinct
operations; only the latter changes the user default, and neither changes an
exact project selection unless the user explicitly requests a project update.

### 2.4 Peer designs contribute different strengths

- Go 1.21+ treats the toolchain as a selected dependency: project metadata can
  cause a verified download and re-exec, while `GOTOOLCHAIN` supplies an
  explicit override. SFEP-0046 already adopted this strongest part of Go.
- Rustup makes human control legible: installed-toolchain listing, a global
  default, `rustup show`, checked-in project selection, and `cargo +toolchain`
  one-shot overrides have an explicit precedence.
- TypeScript's project-local compiler plus lockfile demonstrates the value of
  exact compiler identity for repeatable builds even when a global compiler is
  available.
- Zig demonstrates the operational value of self-contained, signed archives
  that can coexist without an installer mutating system state.

Sailfin should combine these properties around its existing single-binary,
self-dispatching architecture rather than copy any ecosystem wholesale.

## 3. Design

### 3.1 Terminology and scope

This proposal uses four distinct terms:

- **Entry toolchain** — the `sfn` executable resolved from `PATH`. It owns the
  stable early selection/management router and the minimal repair fallback.
- **Selected toolchain** — the exact versioned payload that ultimately handles
  an ordinary command after any re-exec.
- **Minimum** — the existing `[toolchain] sfn = "V"` compatibility floor.
- **Project version** — the new exact version selected by the root manifest.

The entry toolchain may itself be a full compiler; a separate proxy executable
is not required. The contract is behavioral: selection happens before the
selected compiler parses and executes an ordinary command, and the entry
toolchain remains able to manage the shared store.

This SFEP does not add installable compiler components or target libraries,
does not change `bootstrap.toml`'s exact seed role, and does not introduce
semver range expressions. Toolchain garbage collection beyond explicit removal
is deferred until store-usage evidence exists.

### 3.2 Manifest schema: minimum plus exact selection

`capsule.toml` and `workspace.toml` gain an optional exact `version` field:

```toml
[toolchain]
sfn = "0.10.4"       # existing compatibility floor: selected >= 0.10.4
version = "0.10.4"   # exact compiler selected for this root
channel = "stable"   # existing minimum stability constraint
```

The rules are:

1. `sfn` retains its SFEP-0046 floor semantics unchanged. Existing manifests
   are byte-for-byte compatible.
2. `version`, when present, must be a complete release semver, optionally with
   prerelease identifiers, **without build metadata**, and without a moving
   alias such as `stable`. Published/selectable release versions containing `+`
   are invalid: two signed artifacts must never collapse onto one exact store
   identity. `sfn init` strips the local `+dev.<hash>` build stamp before
   writing the release version, matching the existing floor scaffolding.
3. `version` is exact. A selected `0.10.4` is not satisfied by `0.10.5`.
4. The exact version must itself satisfy `sfn` and `channel`. A manifest whose
   `version` is below its own minimum is invalid and fails before any fetch.
5. Workspace/member precedence remains per-field as in SFEP-0046: the member's
   field wins when present and otherwise inherits the workspace field.
6. Dependency manifests do not select the root compiler. Their compatibility
   floors may be validated separately by dependency resolution, but selection
   is owned only by the active capsule/workspace root.
7. `sfn init` writes both `sfn` and `version` using the selected compiler's
   release version. This makes a new project reproducible while retaining an
   explicit compatibility floor that can diverge later.

A future compatibility-policy command may raise `sfn`; switching or updating
`version` does not raise it implicitly. Selecting a newer compiler does not
prove that the project stopped supporting older compilers.

### 3.3 Selection precedence

Selection is resolved once, before full ordinary-command parsing, in this
order:

1. A one-shot CLI selector: `sfn +<selector> <command> ...`.
2. An explicit semver in `SAILFIN_TOOLCHAIN=<version>`.
3. The active root's exact `[toolchain] version`.
4. The per-user default recorded by `sfn toolchain default`.
5. The entry toolchain itself.

`<selector>` is an exact release semver or a channel name accepted by an
interactive management command. A channel selector (`stable`, `rc`, `beta`, or
`alpha`) resolves to one exact release before dispatch; it never becomes a
floating project field. `latest` is accepted at bootstrap/interactive CLI
boundaries as an alias for `stable`, but is never written to configuration or a
project manifest.

After selection, the existing minimum and stability checks run. A one-shot or
environment-selected compiler below the project minimum still errors. The
existing `--skip-toolchain-check`, `SAILFIN_SKIP_TOOLCHAIN_CHECK=1`, and
`SAILFIN_TOOLCHAIN=off|0` escape hatches continue to permit an intentional
unsafe run with a warning.

The existing mode values keep their meanings:

| Value | Selection/fetch behavior |
|---|---|
| unset or `auto` | Apply precedence and fetch a missing selected version after verification. |
| `local` | Apply precedence but never fetch; a missing selected version is an error. |
| exact semver | Select that version unconditionally, then enforce the root minimum/channel. |
| `off` or `0` | Do not dispatch or enforce the root requirement; run the entry toolchain with a warning on mismatch. |

This corrects the current implementation detail where an explicit semver is
consulted only after a floor mismatch. An explicit selector is a selection
input, not merely mismatch recovery.

Selection applies to every command whose semantics can vary with the compiler,
including `version`, `init`, `fmt`, `check`, `build`, `run`, `test`, `emit`,
`bench`, `package`, and future compiler commands. `toolchain` and the minimal
configuration/help prefixes are intercepted by the entry before the management
routing in §3.5, so a broken or missing selected payload can be repaired. Early
selector parsing must occur before the complete command tree is parsed,
allowing an older entry toolchain to hand an unfamiliar future command to a
newer selected compiler.

`sfn --version` remains fast and network-silent. It prints the already
available selected compiler when selection is locally resolvable; it does not
fetch merely to answer a version query. When a required selected version is
missing, it reports the entry version plus an actionable `sfn toolchain
install` hint. `sfn toolchain active` is the authoritative explanation surface.

### 3.4 Management command surface

`sfn toolchain` gains these leaves:

```text
sfn toolchain list [--json]
sfn toolchain active [--json]
sfn toolchain install <selector> [--allow-yanked]
sfn toolchain default [<selector>]
sfn toolchain run <selector> -- <sfn-args...>
sfn toolchain update [<channel>] [--check] [--project]
sfn toolchain verify [<version> | --all] [--json]
sfn toolchain remove <version> [--force]
sfn toolchain entry-version
```

`sfn +<selector> ...` is shorthand for `sfn toolchain run <selector> -- ...`.

Command behavior is normative:

- **`list`** reports every complete store entry, its integrity state, and
  markers for entry, selected, project, and user-default versions. Partial
  entries are reported separately rather than treated as installed.
- **`active`** resolves the current directory and prints the selected version,
  executable path, selection source, entry version, project minimum/exact
  fields, fetch policy, and update track. It performs no fetch by default.
- **`install`** resolves a channel to an exact release when necessary, performs
  the existing fail-closed native install, and prints how to run, select, or
  make the installed version default. It does not silently change the default.
- **`default`** with no argument prints the user default. With a selector it
  resolves and installs the version when `auto` permits, then atomically records
  that exact version as the default. A channel also records the update track
  used by a later argument-less `update`.
- **`run`** performs a one-shot exact selection without modifying project or
  user configuration and preserves child exit codes and signals through re-exec.
- **`update --check`** reports whether a newer release exists on the requested
  or recorded channel and changes nothing. An argument-less update requires a
  recorded user-default track; if `default <exact-version>` created no track,
  it errors with the exact `update <channel>` forms available. `update
  <channel>` records that new user track after success. `--project` requires an
  explicit channel argument (`update stable --project`), installs a strictly
  newer exact candidate, and atomically updates only the root's `version`
  field. No update command downgrades; an intentional downgrade uses `default`,
  `+<version>`, or an explicit project edit. The manifest's existing `channel`
  remains a stability constraint and is never inferred as an update track.
- **`verify`** validates the installed payload against its recorded install
  manifest. `--all` covers every complete store entry and returns non-zero if
  any entry is corrupt or incomplete.
- **`remove`** accepts only an exact installed version. It refuses the entry,
  selected, user-default, or active-project version. `--force` may override the
  default/project protections but never removes the executable currently
  running. Removal is explicit and reports that other checkouts may reinstall
  the version automatically.
- **`entry-version`** bypasses selection and prints the PATH entry's version,
  host, executable path, and supported management-protocol range. It is the
  stable diagnostic for deciding whether the one-time entry upgrade is needed.

The human output follows the ordinary CLI diagnostic conventions. `--json`
uses one locked envelope shared by `list`, `active`, `verify`, and `update
--check`:

```json
{
  "schema_version": "sailfin-toolchains/1",
  "operation": "active",
  "host": "aarch64-apple-darwin",
  "entry": { "version": "0.10.4", "path": "/.../sfn" },
  "selected": {
    "version": "0.10.3",
    "path": "/.../aarch64-apple-darwin/0.10.3/sfn",
    "source": "workspace",
    "installed": true,
    "integrity": "verified"
  },
  "requirement": {
    "minimum": "0.10.0",
    "version": "0.10.3",
    "channel": "stable",
    "source": "workspace.toml"
  },
  "default": { "version": "0.10.4", "track": "stable" },
  "update": {
    "policy": "notify",
    "available": false,
    "current": "0.10.4",
    "candidate": null,
    "advisory": null
  },
  "toolchains": [],
  "diagnostics": []
}
```

`schema_version` is the first serialized field. Every top-level field is
present for every operation; an inapplicable scalar or record is `null` and an
inapplicable collection is `[]`. `toolchains` entries carry `version`, `host`,
`path`, `state` (`complete|partial|corrupt`), `integrity`
(`verified|unverified|failed`), and `roles` (zero or more of
`entry|selected|project|default|management`). Diagnostics use SFEP-0061's coded
severity/message shape.

The exit matrix follows SFEP-0003: `0` means the operation completed with no
actionable findings, including either value of `update.available`; `1` means an
inspection completed and found an actionable condition such as corrupt,
partial, or known-revoked payload state; and `2` means setup, selection,
policy, network, operational, or CLI-usage failure. Availability is data, never
an error exit. A setup or preflight failure may emit no envelope. The JSON slice
must add `docs/reference/toolchains-json-schema.md` and a schema-lock test before
the interface is documented as stable. Additions require a schema version or
explicitly optional fields under SFEP-0003's contract rules.

### 3.5 The per-user default, host identity, and management routing

The user default is configuration, not a mutable copy of the compiler. It is
stored atomically in Sailfin's existing per-user configuration domain and names
an exact store entry plus, when chosen through an alias, its update channel.
Mutable last-check timestamps live in a cache/state file, not in the
user-authored configuration.

The executable found on `PATH` remains the entry toolchain. It reads the
default and re-execs the selected version; changing defaults therefore does not
overwrite a running executable and works uniformly on Windows. The entry
toolchain is a bootstrap controller, not the claimed compiler identity for an
ordinary command. `active` exposes both identities so diagnostics never hide
which binary made the selection.

Initial bootstrap installers continue to publish an entry toolchain and set
the same release as the initial default. Once any trusted entry toolchain is
installed, native lifecycle commands are the recommended update path. A
package-manager-owned entry executable is never overwritten by `sfn`; native
updates only add store payloads and move Sailfin's user default. Re-running an
installer or invoking the package manager remains an explicit way to replace
the entry toolchain itself.

The early-selection protocol and store layout are backwards-compatible
contracts. New releases may extend them, but a supported entry toolchain must
continue to dispatch to newer payloads using the signed release metadata. If a
future incompatible protocol is unavoidable, it requires a separately
versioned migration rather than silently stranding older entry installations.

The canonical store identity becomes **`(host triple, exact version)`**, laid
out as:

```text
~/.local/share/sailfin/versions/<host-triple>/<version>/
```

Per-user defaults are also keyed by host triple. A roaming/shared home can hold
macOS arm64, macOS x86_64, Linux, and Windows payloads for the same release
without collision. New writers never create the legacy `versions/<version>`
shape. A legacy entry is a read-only fallback only when no host-qualified entry
exists. Migration never blesses or moves an already-extracted legacy payload
from its archive-digest marker alone because that marker does not authenticate
the extracted files. Online migration resolves the host asset from signed
release metadata, downloads it into a fresh staging directory, performs normal
archive and install-manifest verification, and atomically installs the verified
payload into the host-qualified store. The legacy entry remains untouched until
the new entry commits successfully and is removed only by a later explicit
operation. An unidentified legacy entry may run offline only through the
pre-SFEP behavior and is reported as `unverified`; it is never treated as a
host-qualified installed candidate by `default`, channel resolution, or
update.

Native lifecycle evolution does not depend forever on the original entry
compiler's command tree. Install manifests carry a small integer
`management_protocol`. An SFEP-0073 entry performs a stable prefix scan before
full CLI parsing:

1. Ordinary commands route by §3.3.
2. `sfn toolchain ...` routes to the newest verified, non-revoked installed
   toolchain for the current host whose management protocol is compatible with
   the entry.
3. The entry retains only exact-version `toolchain install` as a repair fallback
   when no compatible management payload exists, plus `toolchain entry-version`
   for diagnosis. Channels, updates, defaults, removal, index parsing, and all
   later management leaves run in the management payload.

After `update` installs a newer compatible payload, the next management command
therefore gains that payload's command/index/trust implementation without
replacing the running entry executable. The protocol prefix and install-manifest
reader are the durable compatibility seam; adding a management leaf does not
require an entry update. A release that raises the management protocol beyond
the entry's supported range must emit an actionable bootstrap-installer or
package-manager upgrade error and cannot become the management payload.

Pre-SFEP-0073 entries know neither this prefix router nor the user-default
record. Adoption consequently requires **one explicit entry upgrade** through
the bootstrap installer or owning package manager to the first release carrying
management protocol 1. From that release onward, ordinary toolchain updates are
native. The install guide and that release's completion message must state this
one-time boundary; the proposal does not claim an old `0.10.4` binary can learn
new commands it was never built to parse.

### 3.6 Update notification policy

There is no background daemon and no automatic installation mode.

The default policy is a bounded **notification check**:

- At most once per seven days.
- Only after a successful interactive command on a TTY.
- Never for `--json` or another machine-readable mode.
- Never when conventional CI/non-interactive environment signals are present.
- One request to the configured signed metadata endpoint, with **at most 500
  milliseconds of additional wall time** including DNS, connect, TLS, and body
  read; timeout, offline, proxy, or parse failures are silent and never
  affect the command's exit status.
- The notice names the current/default version and exact update command. It
  does not alter the store, default, or project manifest.

An atomic per-host lease ensures concurrent commands do not stampede the
endpoint. Only the lease holder attempts a check; the lease expires after 30
seconds so a crashed checker cannot suppress unrelated management work. Before
the lease holder begins network access, it atomically advances the next
eligibility time by seven days. Successful, timed-out, offline, malformed, and
other failed attempts therefore all receive the same bounded retry interval and
cannot add 500 milliseconds to every command. A successful check additionally
records its signed-index sequence. Explicit `update --check` ignores the
opportunistic eligibility timestamp while still obeying network policy.

Per-user configuration supports `notify` (the default), `manual`, and
`disabled`. `manual` suppresses opportunistic checks but permits explicit
`install`, `update`, and `update --check`. `disabled` is the administrative or
air-gapped network policy: every toolchain command or automatic selection that
would contact a release endpoint fails before the request and tells the user to
change policy or use an already-installed exact version. It does not block
local selection, inspection, verification, default changes, or removal.

Security advisories are metadata, not a license to mutate a project. When an
enabled check learns that the selected or default toolchain is revoked or has a
security update, the diagnostic is more prominent and names the affected
version, but installation and project-pin changes remain explicit.

### 3.7 Release discovery and trust

Selecting `latest` (the `stable` alias) or a channel requires trustworthy
release discovery in addition to the per-release artifact verification
SFEP-0046 already provides.
The release process therefore publishes a compact signed toolchain index with:

- A schema version and monotonically increasing sequence.
- Generation and expiry timestamps.
- The exact release selected by each channel.
- Supported host assets for each release.
- Yank/revocation and security-advisory state.
- The release-manifest location and digest.
- A key identifier and an authenticated key-transition record when the signing
  root rotates.

The index and detached signature live under the same overridable release base
as toolchain acquisition. Mirrors may change location, never verification.
Clients cache the highest accepted sequence and reject a lower online sequence;
expired metadata cannot claim that a user is current. Offline use of already
installed exact toolchains remains available.

The signed index chooses a candidate; it does not replace artifact validation.
Every newly installed release still verifies the release-specific signed
manifest and archive digest before extraction. Key-transition and emergency
revocation fixtures are required before update notifications may describe an
installation as secure.

Index states have distinct mandatory behavior:

- **Yanked** means unsuitable for new selection, not cryptographically unsafe.
  Channel/latest resolution excludes the release. A new exact install refuses
  it unless the user passes `--allow-yanked`; the warning is repeated in the
  install result. An already-installed exact project/default selection may run
  and is reported as yanked by `active`/`list`.
- **Revoked** means the release or signing material is unsafe. Channel
  resolution and every new install reject it with no override. Once a client
  has accepted signed metadata revoking a version, selection and execution of
  that installed payload fail closed, online or offline. Revocation of an exact
  release identity is monotonic in local state: a later index cannot un-revoke
  it; remediation is a new signed release identity. Directly invoking a
  versioned binary is outside the manager's enforcement boundary and is
  reported as such in security guidance.
- **Advisory** permits selection and execution but emits the indexed severity,
  affected range, and fixed version whenever update policy permits fresh or
  cached advisory reporting.

Once the trusted-index slice ships, every network-backed exact install consults
the signed index before the release-specific manifest, so exact spelling is not
a revocation bypass. A client that has never received a revocation cannot infer
it while disconnected; offline execution is fail-closed only against its
highest cached signed sequence. This limitation is stated explicitly rather
than claiming omniscient offline revocation.

The bootstrap scripts tighten their boundary once all supported releases carry
signed metadata: a missing signature or unavailable verifier is a hard failure
for modern releases. Installing a historical unsigned release requires an
explicit, loudly named opt-in; warning-and-continue is not the default trust
policy for executable code.

### 3.8 Stored-payload integrity

The current `.sha256` records the verified archive digest but dispatch readiness
checks only that the marker is non-empty. Installation gains a versioned install
manifest derived from the verified archive, recording the executable and every
runtime/workspace payload file that can affect compilation.

Before re-exec, the selected executable is hashed against that manifest. Before
a build-like command consumes bundled runtime or capsule sources, those inputs
are verified as well. Implementations may cache a successful full-payload check
only behind a mutation-resistant cache key; file size and mtime alone are not a
sufficient integrity key. `sfn toolchain verify` always performs an uncached
full verification.

A mismatch marks the entry unusable, refuses execution, and prints the exact
reinstall command. Verification never repairs or deletes a corrupt entry
without an explicit user command.

### 3.9 Delivery order and compatibility

The work can land in independently useful slices without weakening the final
contract:

1. **Inspect and run:** `list`, `active`, `verify`, one-shot exact dispatch, and
   unconditional explicit-semver override precedence.
2. **Exact roots:** manifest `version`, root precedence, `sfn init` scaffolding,
   and exact downward as well as upward dispatch.
3. **Default lifecycle:** the per-user default, `default`, `remove`, and entry
   vs. selected reporting.
4. **Trusted updates:** the signed index, channel resolution, `update --check`,
   explicit update, and bounded notification policy.
5. **Bootstrap hardening:** modern-release fail-closed scripts, key-transition
   coverage, and package-manager provenance behavior.

Until Slice 2 ships, the existing floor dispatch remains authoritative. Until
Slice 4 ships, exact installation retains SFEP-0046's release-specific signed
manifest behavior, cannot claim index-backed yank or revocation enforcement,
and no channel selection or opportunistic update notice is available. Slice 4
atomically makes the signed index a prerequisite for every network-backed exact
install as well as channel installation. Documentation and `docs/status.md`
must describe only landed slices; `Accepted` does not authorize claiming the
whole surface as shipped.

## 4. Effect & capability impact

No new effect kind or language capability is introduced.

- Local selection, configuration, store inspection, payload verification, and
  removal require `![io]`.
- Release discovery and installation require `![io, net]`, which the compiler
  already declares for SFEP-0046's native acquisition.
- Notification interval and signed-index expiry evaluation require `![clock,
  io, net]` on the update-check path only.
- One-shot/default re-exec uses the existing process and environment surface;
  it does not grant a compiled program additional authority.

The effect boundary remains explicit: `sfn --version` and locally resolvable
selection do not acquire `net` merely because update support exists elsewhere
in the binary.

## 5. Self-hosting impact

This is compiler-driver and distribution work. It changes no Sailfin language
syntax, AST, typechecker, effect rule, native IR, LLVM lowering, or runtime ABI.

Implementation lives in the CLI/toolchain orchestration, TOML accessors,
version-store helpers, release metadata/trust code, installer scripts, and
tests. The new project `version` field is additive TOML data, so an older seed
can compile sources that know how to read it. Old released compilers ignore the
unknown field and retain floor behavior; a new entry toolchain must therefore
make the exact selection before re-execing an old target.

The compiler checkout's `bootstrap.toml [seed].version` remains the sole exact
bootstrap seed. The workspace `[toolchain] version` selects the compiler used
for ordinary developer commands and must not replace, infer, or rewrite the
seed pin. Changes under `compiler/src/` still require `make compile` before
targeted tests, and the final selection path must pass self-host and seedcheck
without caller-side build-driver workarounds.

## 6. Alternatives considered

### Keep the current install + floor dispatch surface

Rejected. It solves fresh-clone minimum compatibility but leaves ordinary
multi-version management undiscoverable and permits two satisfying compilers to
produce the same project's artifacts. The store already exists; refusing to
expose its lifecycle would preserve complexity without delivering its user
value.

### Change the existing `sfn` field from floor to exact

Rejected as a compatibility break and a loss of information. A minimum
supported compiler and a selected development compiler are different facts.
Adding `version` preserves every current manifest and permits both to be stated.

### Put exact compiler identity only in `capsule.lock` / `workspace.lock`

Rejected. Lockfiles are appropriate for resolved dependency closures, but
library roots intentionally differ in lockfile ownership and a toolchain must be
selected before dependency resolution can safely run. The exact root compiler
belongs beside the existing minimum in `[toolchain]`. A future lock format may
mirror it for provenance, but it is not the authority.

### Add `policy = "exact" | "minimum"` to the existing field

Rejected because it forces one version to serve two roles and cannot express
"develop with 0.11.2 while retaining a 0.10.4 compatibility floor." Separate
fields are slightly more verbose and materially clearer.

### Introduce a separate `sfnup` executable

Rejected as the required architecture, consistent with SFEP-0046. It adds a
second product, installation step, PATH owner, release cadence, and trust root.
The existing `sfn` already has native acquisition and re-exec. A future
physically smaller entry executable may implement the same protocol, but the
user-facing contract remains `sfn toolchain`.

### Make channel names float in project manifests

Rejected. `version = "stable"` would make the same commit select different
compilers over time. Channels are interactive resolution and update-policy
inputs; a project records the exact result.

### Automatically install updates or rewrite project manifests

Rejected. Notifications may be automatic and bounded; changes to executable
code and checked-in compiler identity require an explicit command. Security
urgency changes diagnostic prominence, not consent or reproducibility.

### Run an update daemon or check the network on every invocation

Rejected. Both add failure, privacy, latency, and managed-environment costs to
unrelated compiler commands. A cached post-success notice plus explicit
`update --check` provides discovery without making compiler startup depend on a
service.

### Trust the GitHub releases API as the update index

Rejected for the final contract. A TLS response can identify candidates, but it
does not provide durable channel semantics, expiry, anti-rollback sequence,
revocation, or signing-key transition. Candidate discovery and executable
artifact verification must share an authenticated metadata story.

## 7. Stage1 readiness mapping

This SFEP is **Accepted**, not Implemented. It adds no language or IR node, so
the first four compiler-pipeline rows are N/A; all shipping rows remain open.

- [ ] Parses — N/A for Sailfin syntax; additive TOML/CLI parsing is pending.
- [ ] Type-checks / effect-checks — N/A for a new language construct; new
  driver code must type/effect-check.
- [ ] Emits valid `.sfn-asm` — N/A; no program IR change.
- [ ] Lowers to LLVM IR — N/A; no lowering change.
- [ ] Regression coverage — pending the matrix in §8.
- [ ] Self-hosts — pending `make compile` plus the required self-host gate for
  each compiler-source slice.
- [ ] `sfn fmt --check` clean — pending implementation.
- [ ] Documented in `docs/status.md` + spec — this accepted design record is
  present; shipped CLI/install/reference and status updates remain pending.

## 8. Test plan

### Unit tests

- Parse and merge `sfn`, `version`, and `channel` across capsule/workspace
  precedence; reject exact versions below their own floor or stability gate.
- Reject build metadata and moving aliases in project exact versions while
  stripping the running compiler's `+dev.<hash>` during `sfn init`.
- Resolve the full precedence matrix: CLI selector, explicit env semver,
  project exact, user default, entry fallback, and every `auto/local/off` mode.
- Parse channel aliases only in interactive selectors, never project `version`.
- Read/write the default and update-policy state atomically without mixing
  mutable timestamps into user configuration.
- Parse and verify signed-index schema, sequence, expiry, revocation, channel,
  asset, and key-transition fixtures; reject malformed, expired, rolled-back,
  or wrongly signed metadata.
- Resolve update tracks: no-track errors, explicit channel transitions,
  prerelease-to-stable advancement, equal/older candidates as no update, and
  strict no-downgrade behavior.
- Generate and verify install manifests, including executable, runtime,
  capsules, workspace manifest, missing file, modified file, and duplicate/path
  normalization cases.
- Lock every field/nullability rule and the `0`/`1`/`2` exit matrix of the
  `sailfin-toolchains/1` JSON envelope.

### Integration tests

- `sfn init` writes equal minimum/exact versions; switching the exact version
  leaves the minimum untouched.
- A newer entry toolchain dispatches downward to an older exact project
  version, and an older entry dispatches upward, with loop guards intact.
- `SAILFIN_TOOLCHAIN=<version>` selects unconditionally in an unpinned root and
  in a root whose floor is already satisfied; a below-floor selection errors.
- `local` uses an installed exact selection offline and refuses a missing one
  without a network attempt.
- `default` changes subsequent unpinned command selection without overwriting
  the entry executable, including the Windows path shape.
- Management prefix routing chooses the newest compatible verified payload,
  excludes known-revoked payloads, preserves exact-install repair fallback,
  and rejects an unsupported management-protocol increase with the entry
  upgrade diagnostic.
- Host-qualified stores and defaults keep two host payloads of the same release
  distinct; legacy migration reinstalls a freshly downloaded, fully verified
  host asset instead of moving an extracted legacy payload.
- `remove` protects entry/default/project/selected versions and removes only
  the exact validated store entry requested.
- A modified stored executable refuses re-exec; a modified runtime/capsule
  payload refuses a build-like command; `verify --all` identifies each entry.

### End-to-end tests

- Seed two signed stub toolchains and prove `sfn +V --version`, `toolchain run`,
  project exact selection, and user default each execute the expected stub and
  preserve exit status.
- Serve a signed toolchain index and releases from a controlled local endpoint;
  prove `install stable`, `latest` aliasing, `update --check`, tracked and
  untracked `update`, explicit `--project`, expiry, sequence rollback, key
  transition, and offline cache behavior. Yanked releases are excluded from
  channels and require `--allow-yanked` for exact installation; revoked
  releases reject install and cached-known execution with no override; advisory
  releases remain runnable with the indexed warning.
- Prove opportunistic checks are suppressed for CI, non-TTY, JSON, disabled,
  and unexpired-cache cases; a timeout adds no more than 500 milliseconds and
  never changes the wrapped command's output contract or exit status. Failed,
  offline, malformed, and timed-out attempts advance eligibility by seven days.
  Parallel commands prove the per-host lease admits one request and recovers
  after its 30-second expiry.
- Exercise Linux/macOS symlink installs and native Windows copy/pointer installs
  through the same default-selection behavior.
- Tightened bootstrap scripts reject unsigned modern releases and accept a
  legacy unsigned fixture only with the explicit opt-in.

Every implementation slice touching compiler sources runs `make compile` before
the narrowest relevant `build/bin/sfn test ...` command, then formatting checks
for every touched `.sfn` file. The final slice runs the full `make check` gate
because selection and self-dispatch sit on every compiler command's startup path.

## 9. References

- [SFEP-0046 — Native Toolchain Version Pinning + Dispatch](./0046-toolchain-pinning.md)
  — shipped floor, acquisition, trust root, and mismatch dispatch foundation.
- [SFEP-0047 — Compiler Bootstrap Manifest](./0047-compiler-bootstrap-manifest.md)
  — exact compiler-repository seed policy, deliberately separate from user
  selection.
- [SFEP-0003 — The Toolchain Surface and Its Output Contracts](./0003-tooling.md)
  — command/envelope ownership and schema-lock requirement.
- [`docs/status.md`](../status.md) — authoritative current shipped behavior; it
  must advance slice by slice rather than from this acceptance alone.
- [`site/src/content/docs/docs/reference/cli.md`](../../site/src/content/docs/docs/reference/cli.md)
  — current floor/dispatch reference and eventual graduated CLI documentation.
- [Go toolchain selection](https://go.dev/doc/toolchain)
- [Rustup overrides and selection precedence](https://rust-lang.github.io/rustup/overrides.html)
- [Rustup update policy](https://rust-lang.github.io/rustup/basics.html)
- [TypeScript project-local installation](https://www.typescriptlang.org/download/)
- [Zig signed release archives](https://ziglang.org/download/)

`tracking:` is intentionally empty at acceptance: implementation work has not
started, and the project owner will groom this accepted design into Linear
issues. Once the implementing slice or 1:1 Project exists, its identifiers or
Project URL must be added under SFEP-0001 §3.1.
