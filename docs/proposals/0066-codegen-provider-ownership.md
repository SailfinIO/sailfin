---
sfep: 66
title: Codegen Provider Ownership — Which Toolchain Roles Sailfin Owns
status: Draft
type: tooling
created: 2026-08-05
updated: 2026-08-23
author: "agent:Sailbot (drafted); project owner (redistribution decision 2026-08-05); agent:Codex (cross-platform clang-independence amendment 2026-08-23)"
tracking: https://linear.app/sailfin/project/cross-platform-clang-independence-baeafe4f0a9a
supersedes: 15
superseded-by:
graduates-to:
---

# SFEP-0066 — Codegen Provider Ownership

> **Provenance.** This proposal is the normative successor to the retired
> SFEP-0015 ("Toolchain Independence — Sailfin-Native Backend"). Its survey
> moved to `docs/backend-independence.md`; its Typed SSA v0 contract moved to
> SFEP-0059 §10. This document owns the provider boundary, the cross-platform
> clang-independent LLVM contract, and the rules for making role-ownership
> claims.

## 1. Summary

Sailfin's path from an analyzed program to a running process has five roles:
Emit, Select, Assemble/object emission, Link, and Load. This proposal makes the
role and native target pair the unit of ownership. For Linux x86-64, Linux
aarch64, macOS arm64, and Windows x86-64, the destination contract keeps LLVM
as the Select and object-emission provider through a coherent
`llvm-as`/`opt`/`llc` tool family, invokes the platform linker directly, and
never discovers or falls back to clang on the first-party path. Sailfin owns
tool selection, target identity, artifact publication, cache identity,
prerequisite discovery, diagnostics, and linker argv. A supported-platform
claim requires a native cold self-host fixed point and released-asset smoke test
with clang unavailable or poisoned.

This is clang independence, not LLVM independence, libc independence, or a
Sailfin-written native backend. The seal-sufficient `sfn/codegen-native`
provider reserved by SFEP-0020 remains a peer of `sfn/codegen-llvm`; it neither
blocks nor is displaced by this contract.

## 2. Motivation

The existing design records a Linux-centric snapshot rather than a complete
provider contract. In the current tree, every first-party LLVM or C input can
reach `clang -c`; Linux direct linking falls back to clang when prerequisites
are missing; and macOS and Windows delegate their final link to the clang
driver. The driver therefore rents several responsibilities from clang without
recording the inputs clang inferred on Sailfin's behalf.

That ambiguity causes four concrete failures.

1. **Claims are not portable.** A successful direct Linux link says nothing
   about Darwin SDK discovery, Windows CRT/import libraries, or even a second
   Linux host whose CRT layout differs.
2. **The compatibility oracle is also the production fallback.** A missing
   linker or startup object can silently change the provider that executed.
   Cache identity and diagnostics then describe a best-effort route rather than
   a support contract.
3. **LLVM and foreign C are conflated.** `clang_argv.sfn` accepts both `.ll` and
   `.c` inputs plus C include flags. A pure Sailfin build can therefore inherit
   a C-compiler dependency from an abstraction it never asked to use.
4. **Clang owns hidden target knowledge.** It selects optimization/codegen
   passes, object format, relocation model, startup objects, system-library
   roots, SDK/deployment metadata, and default libraries. Removing its argv
   without assigning those decisions would replace one ambient contract with
   another.

The goal is not to eliminate external tools. It is to make every external tool
an explicit provider selected by Sailfin, with complete inputs, deterministic
identity, actionable failure, and an honest claim boundary.

## 3. Design

### 3.1 Roles and claim language

The five roles are normative:

| Role | Input → output | Meaning of ownership |
|---|---|---|
| **Emit** | analyzed program → verified Sailfin/LLVM IR | Sailfin determines program semantics and renders provider input |
| **Select** | LLVM IR → target machine instructions | the selected LLVM family owns optimization, instruction selection, register allocation, and machine lowering |
| **Assemble/object emission** | selected instructions → native object | LLVM MC through `llc -filetype=obj` encodes and writes the target object |
| **Link** | ordered native objects/libraries → executable image | Sailfin resolves every prerequisite and invokes the named platform linker directly |
| **Load** | executable image → process | the target OS loader and system runtime load the image |

An independence claim must name a role and target. "Sailfin is
toolchain-independent" is prohibited. "The default macOS arm64 path is
clang-independent; LLVM owns Select/object emission and Sailfin invokes Apple
`ld` directly" is a valid claim after the gates in §5.2 pass.

Fallback is not ownership. A target owns Link only when missing prerequisites
fail closed instead of selecting another linker driver. Likewise, LLVM owns
object emission only when the default path cannot execute clang. An explicitly
selected migration oracle is reported as the provider that executed and never
counts toward an ownership claim.

### 3.2 Supported native matrix

This proposal governs exactly four native host/target pairs. Cross-compilation
may exercise the same artifact contracts, but it cannot establish native
support.

| Native platform | Target triple | Object | Destination Link provider | Load owner |
|---|---|---|---|---|
| Linux x86-64 | `x86_64-unknown-linux-gnu` | ELF | `ld.lld` in ELF mode | glibc ELF loader/kernel |
| Linux aarch64 | `aarch64-unknown-linux-gnu` | ELF | `ld.lld` in AArch64 ELF mode | glibc ELF loader/kernel |
| macOS arm64 | `arm64-apple-darwin` | Mach-O | Apple `ld`, resolved through the active Xcode/Command Line Tools selection | Darwin `dyld`/kernel |
| Windows x86-64 | `x86_64-pc-windows-msvc` | COFF | `lld-link.exe` | Windows PE loader/kernel |

Linux is glibc/PIE-only in this proposal. Musl, static/`-nostdlib`, MinGW,
macOS x86-64, and every other target remain outside the clang-independent
support claim even if the compiler can emit or cross-link some of them.
`arm64-apple-darwin` is the user-facing logical triple; §3.5 resolves it to a
versioned `arm64-apple-macosx<deployment>.0` LLVM object triple before IR
validation or optimization.

Ownership before and after this migration is:

| Role | Current/default route (all four targets unless narrowed) | Destination route (all four targets) |
|---|---|---|
| Emit | Sailfin | Sailfin |
| Select | LLVM reached through clang's driver | coherent LLVM CLI family selected by Sailfin |
| Assemble/object emission | clang (`clang -c`) | LLVM MC through `llc -filetype=obj` |
| Link — Linux x86-64/aarch64 | Sailfin-authored direct `ld.lld` route with clang fallback | required direct `ld.lld`; fail closed |
| Link — macOS arm64 | clang driver | required direct Apple `ld`; fail closed |
| Link — Windows x86-64 | clang driver selecting LLD | required direct `lld-link`; fail closed |
| Load | target OS loader/system runtime | unchanged |

The current Linux route is an implemented direct-link capability, but the
fallback means it is not yet the final required-owned contract defined here.

### 3.3 Provider boundary and artifact kinds

The code-generation provider seam is the capsule boundary from SFEP-0020, not
the `Backend` interface in `compiler/src/backend.sfn`.
`sfn/codegen-llvm` consumes verified `sfn/ir` values and returns LLVM provider
input plus diagnostics. A future `sfn/codegen-native` consumes the same verified
IR and returns native-provider artifacts. Neither provider parses source,
performs workspace discovery, writes persistent artifacts, spawns processes, or
links.

`sfn/compiler` owns the provider-neutral external-tool boundary. Its requests
and results distinguish these artifact kinds:

| Kind | Required metadata | Permitted consumer |
|---|---|---|
| `LlvmText` | path/content digest, target triple, data layout, producer identity | LLVM validation/optimization request |
| `LlvmBitcode` | path/content digest, LLVM family identity, target triple | LLVM optimizer or object-emission request |
| `NativeObject` | path/content digest, object format, target triple, provider identity | final link plan |
| `ForeignCSource` | capsule/source identity, target, include roots, configured compiler identity | foreign-C request only |
| `ExecutableImage` | target, ordered link-plan digest, linker/platform identity | package/run/test consumers |

An LLVM request cannot carry C include roots or select C language mode. A
foreign-C request cannot carry LLVM IR. The namespaces and cache schemas for the
two requests cannot alias. Final `LinkPlan` values contain native objects and
libraries only; raw `.ll`, `.bc`, or `.c` is rejected before linker selection.

External tools are invoked without a shell. Each request contains an executable
path, argv vector, explicit environment allowlist, input/output paths, target,
timeout class, and diagnostic context. Results contain exit classification,
captured diagnostic text, and produced-artifact identity. Only
`sfn/compiler` performs the `![io]` operations to resolve, spawn, and publish.

### 3.4 Coherent LLVM tool family

The default object provider is one coherent `llvm-as`/`opt`/`llc` family. On
Linux and Windows the family also supplies `ld.lld`/`lld-link`; Apple `ld` is a
platform tool and is identified separately.

Resolution order is deterministic:

1. `SAILFIN_LLVM_ROOT`, when set, is authoritative. All required executables
   must exist below its `bin` directory. A missing or skewed member fails; the
   resolver never falls through to `PATH`.
2. Otherwise, inspect the exact unsuffixed family visible on `PATH`, then the
   release-supported version-suffixed family (for example `llvm-as-<major>`,
   `opt-<major>`, `llc-<major>`). Candidates are evaluated as complete families,
   never tool by tool.
3. The family is accepted only when every member reports the one LLVM major
   supported by that Sailfin release, their full version/build identities are
   compatible, and a probe can validate IR and emit the requested target/object
   format. The supported major is release metadata, not "newest found" policy;
   changing it is an explicit toolchain/release change.

The resolver uses native filesystem/process APIs. It does not use `sh`,
`command -v`, `where`, batch activation scripts, or POSIX null-device paths.
Windows `.exe` conventions and path quoting are data in the resolver rather
than shell behavior.

The LLVM family fingerprint includes canonical executable paths, executable
content digests, complete `--version` outputs, selected major, successful
target/object capability probe, and the provider-pipeline schema version. A
path, binary, version, capability, or schema change invalidates affected
caches. Resolution occurs once per command; trace, cache, and diagnostic
consumers reuse that structured result rather than rerunning probes.

### 3.5 Normative LLVM CLI pipeline

For each `LlvmText` module the driver runs these stages:

```text
LlvmText
  -- llvm-as --> verified LlvmBitcode
  -- opt     --> optimized LlvmBitcode
  -- llc     --> NativeObject (ELF, Mach-O, or COFF)
```

The argv schema is normative even where a tool permits shortcuts:

1. `llvm-as <input.ll> -o <verified.bc>` validates the text and creates the
   bitcode boundary. Invalid IR is not retried with another tool.
2. `opt -passes=default<O0|O2> <verified.bc> -o <optimized.bc>` applies the
   release-supported default pipeline matching the Sailfin optimization level.
   `-verify-each` is enabled in verification/debug gates, not production
   release builds.
3. `llc -O0|-O2 -mtriple=<target> -filetype=obj
   -relocation-model=<profile> <optimized.bc> -o <object>` performs target
   lowering, register allocation, MC encoding, and object writing.

The initial target profiles are fixed as follows. `none` means the corresponding
`-mattr` list is empty; it does not mean host autodetection.

| Target | CPU / features / ABI | Codegen profile |
|---|---|---|
| Linux x86-64 | `x86-64` / none / SysV AMD64 | PIC PIE, small code model, native TLS, `default` EH, frame pointers `all` at O0 and `none` at O2 |
| Linux aarch64 | `generic` / `+neon,+v8a` / AAPCS | PIC PIE, small code model, native TLS, `default` EH, `non-leaf` frame pointers at O0 and O2 |
| macOS arm64 | `apple-m1` / CPU-defined baseline / DarwinPCS | PIC, small code model, native TLS, `default` EH, `non-leaf` frame pointers at O0 and O2 |
| Windows x86-64 MSVC | `x86-64` / none / Win64 MSVC | PIC, small code model, native TLS, WinEH, `none` frame pointers at O0 and O2, incremental-linker-compatible COFF |

All four profiles enable function and data sections, use the target-default
COMDAT selection kind, and preserve unwind tables by applying `uwtable(sync)`
to every defined function. Floating-point semantics are strict:
`fp-contract=on`; unsafe
FP, fast math, approximate functions, no-NaN, no-Inf, no-signed-zero, and
no-trapping assumptions are false. Stack-protector insertion is not inferred by
the LLVM CLI provider; it occurs only when Sailfin IR carries an explicit
function attribute. Emulated TLS is false for these four profiles (the retired
MinGW path is the separate case that required it).

Darwin target resolution precedes the LLVM pipeline, not merely final linking.
The driver resolves one SDK version and one deployment target. An explicit
`MACOSX_DEPLOYMENT_TARGET` is authoritative; release workflows must set it to
the release's supported minimum, while an interactive build with no override
uses the native host major/minor. The provider materializes
`arm64-apple-macosx<deployment>.0` as the module `target triple` and passes
that same versioned triple to `opt -mtriple` and `llc -mtriple`. The module
data layout, Mach-O build-version load command, Apple `ld -platform_version`
minimum, selected SDK version, cache identity, tool-role report, and capability
probe must all agree. An unversioned object triple or disagreement between the
object and link deployment/SDK contract fails before publication.

Every profile field must affect output through one of two normative mechanisms:

- `opt` receives `-mtriple`, `-mcpu`, any non-empty `-mattr`, and
  `-passes=default<O0|O2>`, so target-library and target-transform analysis use
  the same baseline as code generation.
- `llc` receives the same triple/CPU/features plus `-O0|-O2`,
  `-filetype=obj`, `-relocation-model=pic`, `-code-model=small`,
  `-function-sections`, `-data-sections`, `-frame-pointer=<profile>`,
  `-exception-model=<profile>`, and `-fp-contract=on`; Windows additionally
  receives `-incremental-linker-compatible`. A profile ABI that LLVM does not
  derive uniquely from the triple is passed through `-target-abi`.
- Unwind, target CPU/features, frame-pointer, strict-FP, stack-protector, and
  other function-scoped requirements that LLVM represents as IR attributes are
  emitted in the provider's canonical function attribute group before
  `llvm-as`. Triple and data layout are emitted in the module header. The
  validator rejects a module whose header or attributes disagree with the
  resolved target profile.

Omitting a flag is permitted only when the accepted LLVM major has no spelling
for it and a checked capability probe plus object/IR-shape test demonstrates
that the tool default equals the table. Recording a desired value only in a
request or cache key is not implementation. The profile schema, materialized
argv, canonical IR attributes, and tool capability probe all enter the cache
fingerprint. The provider must probe that `opt` and `llc` accept every
materialized setting and that `llc` emits the requested target/object format
before accepting the family.

Program, dependency, runtime Sailfin, runtime `ll-sources`, test, self-host, and
cross-target LLVM modules all use this pipeline. Serial and bounded-parallel
execution must produce the same ordered object plan and use atomic cache
publication. There is no first-party alternate path that skips `opt`, asks
clang to assemble, or sends LLVM input to the final link.

#### Compatibility and performance oracle

During migration, the exact legacy `clang -O0`/`clang -O2` route is the
differential oracle. Its executable path, content/version identity, target
trace, and complete argv are recorded per platform; the oracle is never assumed
to be interchangeable with a similarly numbered upstream LLVM release. It is
never a fallback. A developer or CI job must select it explicitly through the
migration-only `SAILFIN_OBJECT_PROVIDER=clang-oracle` switch and provide its
executable through authoritative `SAILFIN_CLANG_ORACLE`. The default and only
supported first-party value is `llvm-cli`; an invalid value or missing oracle
executable fails without falling through to `PATH`. Tool-role output must label
the selected result `clang-oracle`.

The new pipeline replaces the oracle only after all of these hold per target:

- **Behavior:** the same source corpus produces the same exit status, stdout,
  stderr class, files/network-visible effects, exceptions, atomics, TLS,
  concurrency behavior, ABI results, COMDAT resolution, and determinism. Object
  bytes and unspecified symbol order need not match.
- **Optimization:** O0 uses `default<O0>` plus `llc -O0`; O2 uses
  `default<O2>` plus `llc -O2`. Target/CPU, relocation, TLS, section, unwind,
  and floating-point semantics match the corresponding accepted clang trace.
- **Performance:** on the repository's compiler and consumer benchmark sets,
  the three-run median O2 runtime and emitted-image size may not regress by more
  than 5% from the recorded clang oracle without a separately accepted and
  documented exception. Provider wall time and peak RSS are recorded; a
  regression over 10% requires an explicit issue before the default flips.
- **Diagnostics:** tool absence, invalid IR, optimization failure, target
  lowering failure, and object-publication failure retain their distinct
  Sailfin classifications. Raw clang wording is not an equality requirement.

The accepted target-profile argv and its benchmark/oracle evidence are checked
in. Upgrading the LLVM major reruns the differential and performance gates
instead of inheriting parity from a previous major.

### 3.6 Direct-link ownership

One target-profile-driven link dispatcher serves program, test, self-host, and
package layouts. Differences are link-plan data, not separate selection logic.
Every platform resolver returns either a complete `ResolvedLinkContract` or one
structured failure. It never returns "try clang."

#### ELF/glibc Linux

Sailfin invokes `ld.lld` directly for x86-64 and aarch64 PIE executables. It
owns deterministic discovery and ordering of:

- linker executable/emulation, target triple, entry point, and ELF interpreter;
- `Scrt1.o`, `crti.o`, `crtbeginS.o`, ordered objects/libraries,
  `crtendS.o`, and `crtn.o` from one compatible target/sysroot family;
- compiler-support/runtime libraries, glibc search roots, `libc`, required
  system libraries, rpaths, retain roots, and section garbage collection;
- PIE, dynamic-linker, build-id/reproducibility, response-file, and output flags.

An explicit sysroot/linker override is authoritative and cannot mix with
ambient CRT objects. Candidate version directories are enumerated and sorted
natively; ambiguous or mismatched CRT families fail closed. Musl, static, and
`-nostdlib` are separate contracts.

#### Darwin/macOS arm64

Sailfin invokes Apple `ld` directly. It resolves the active developer directory,
linker, macOS SDK root/version, and deployment target through the supported
Xcode/Command Line Tools contract, then passes architecture, platform/minimum
OS version, syslibroot/search roots, entry/startup behavior, `libSystem`,
required libraries/frameworks, retain roots, dead-strip, response-file, and
output flags explicitly.

An SDK/linker override is authoritative. The resolver cannot combine a Homebrew
LLVM-inferred target with an Apple SDK, cannot infer a stale deployment target,
and cannot proceed when SDK/platform metadata or a required system library is
missing. Link identity includes the canonical developer directory, linker
binary identity, SDK path/version, deployment target, and library/framework
inputs. Existing signing/notarization behavior is preserved but is not owned by
this proposal.

#### MSVC/COFF Windows x86-64

Sailfin invokes the coherent family's `lld-link.exe` directly. It owns native,
shell-free discovery and selection of the Windows SDK/UCRT and MSVC toolset,
then supplies machine, subsystem, entry/startup contract, object/library order,
UCRT/VCRuntime and Windows import-library roots, default libraries, COMDAT/dead
strip, TLS/unwind, response-file quoting, reproducible timestamp, retain-root,
and output/PDB policy explicitly.

The selected Windows SDK, UCRT, and MSVC libraries must form one compatible
x86-64 contract. A missing or mixed toolset, startup/default library, import
library, or unsupported response-file/path encoding fails before spawn when it
can be detected. `LIB`, `PATH`, or a developer-command-prompt environment may
be inputs to discovery but are not sufficient provenance: the resolved roots
and versions are validated and recorded. MinGW is outside this contract.

The coherent LLVM family also owns the compiler-support builtins that `llc`
may reference. For MSVC x86-64 the resolver must locate the matching
`clang_rt.builtins-x86_64.lib` (or the same family's per-target-runtime-dir
equivalent) beneath that family's Clang resource directory, prove that its
version/target match `llc`, and place it after Sailfin objects and before the
UCRT/VCRuntime/default-library tail in the `lld-link` response file. The
capability probe links a COFF object that requires `__extendhfsf2`,
`__truncsfhf2`, `__truncdfhf2`, and `__floatsihf`; a missing library or
symbol fails the resolved-link contract before normal builds. Its canonical
path, content digest, resource version, ordered position, and probe result enter
link/cache/provenance identity. This is the direct-link replacement for the
current clang `--rtlib=compiler-rt` responsibility, not an MSVC/UCRT library.

### 3.7 Fail-closed diagnostics and reporting

Missing `llvm-as`, `opt`, `llc`, target support, object format, linker, SDK,
sysroot, CRT/startup object, loader, search root, system/import library, or
deployment metadata produces a Sailfin diagnostic and a non-zero result. No
required path discovers or invokes clang after such a failure.

Diagnostics name:

- the failed role and stage;
- target triple/object format and source artifact when applicable;
- requested and resolved tool/SDK/CRT identities;
- the exact missing, skewed, ambiguous, or unsupported prerequisite;
- the authoritative configuration knob when one was supplied; and
- retained artifact/log paths plus bug-report context for provider failures.

One tool-role report exposes the resolved validator, optimizer, object emitter,
linker, target profile, SDK/sysroot/CRT identity, default versus migration
oracle selection, and foreign-C state. Its human form is concise; its versioned
machine form is deterministic and suitable for CI without parsing argv traces.
Secrets and unrelated environment values are never included.

### 3.8 Cache and provenance identity

Every object and executable cache key includes:

- input content and ordered dependency/object identities;
- target triple, object format, optimization level, and complete target profile;
- LLVM family fingerprint and pipeline-schema version;
- linker executable identity and full structured link-plan flags;
- selected sysroot/SDK/CRT/startup/library identities;
- compiler/runtime/source-closure identities already required by the cache; and
- foreign-C compiler/request identity when and only when foreign objects exist.

Resolved paths alone are insufficient; executable and prerequisite content or
version identity is included. A default LLVM object and a `clang-oracle` object
cannot share a namespace. A foreign-C object cannot alias an LLVM object even
when source basenames and contents coincide. Provenance cards and tool-role
reports reuse these exact identities.

### 3.9 Foreign `c-sources`

Manifest `c-sources` are a foreign-tool integration, not part of Sailfin's
first-party clang-free claim. The resolved source closure is checked before any
C-compiler discovery. If it contains no C sources, the driver does not inspect
`PATH`, run a probe, or require C-related configuration.

If C sources exist, `SAILFIN_FOREIGN_C_COMPILER` is the v1 explicit
configuration contract. It selects a compiler executable for that request; it
does not change the LLVM object provider or final linker. An unset value fails
before spawning with a diagnostic naming the capsule, source, target, and this
configuration knob. Sailfin does not promise a compiler brand. It passes the
isolated request's target, optimization, include roots, output kind, and ABI
requirements, and records executable/version/content identity plus all flags in
the foreign-object cache and link provenance.

Optional C-harness/differential test oracles use a separate test-owned helper.
They skip explicitly when no external compiler is configured and cannot be
imported by production build, runtime, bootstrap, package, or link paths. Users
may configure clang as their foreign compiler; doing so does not weaken or
participate in the first-party no-clang claim.

## 4. Effect & capability impact

No language effect or capability changes. The pure provider capsules remain
`required = []` under SFEP-0020. `sfn/compiler` already owns the `![io]`
authority needed for environment/filesystem discovery, process execution,
atomic artifact publication, and diagnostics. The amendment narrows authority
by preventing `sfn/codegen-llvm` or a future provider from executing tools.

External-tool selection is not a user-program capability. Foreign C provenance
is nevertheless explicit because its object enters the trusted link inputs. For
the capability seal, this proposal supplies auditable provider/link ownership;
enforcement remains the owned syscall layer and link-time admission contract.

## 5. Self-hosting impact

### 5.1 Bootstrap, release, and seed transition

The current pinned seed (`v0.10.4` when this amendment was written) predates the
clang-independent provider contract. The transition is deliberately staged:

1. **Compatibility build.** The current seed may use the legacy clang route to
   compile the first compiler containing the LLVM/direct-link paths. This is a
   bootstrap fact, not a supported-platform claim.
2. **Candidate fixed points.** The freshly built compiler becomes the default
   provider. Native Linux x86-64/aarch64, macOS arm64, and Windows x86-64 jobs
   reach the ordinary self-host fixed point with clang unavailable or a poison
   executable. The legacy route runs only in explicitly selected differential
   jobs.
3. **Release proof.** Candidate native release assets are installed in clean
   native environments and compile, link, run, test, and package representative
   Sailfin programs with clang unavailable. Tool-role reports and poison logs
   are retained as evidence.
4. **Seed advance.** The first release passing the complete matrix is pinned in
   `bootstrap.toml [seed].version`, with checksums/provenance verified for all
   four native assets. A clean source bootstrap from that pinned seed then
   reaches the fixed point with clang unavailable.
5. **Deletion and ratchet.** Only after step 4 passes may production clang
   validator/object/link fallbacks, flags, shims, cache identities, and active
   bootstrap recipes be deleted. The repository then adds static invocation
   census checks plus dynamic cold native no-clang jobs. Narrow exceptions are
   limited to historical fixtures/docs and explicitly configured foreign-C or
   optional test-oracle boundaries.

A source change needed after a platform fixed-point or release gate invalidates
that gate for the affected platform. Pinning a release that merely cross-builds
a target is prohibited. The clang compatibility code may not be deleted merely
because the new provider is default; the clang-independent seed pin and clean
bootstrap are the deletion gate.

This is ordinary compiler-source evolution under
`.claude/rules/seed-dependency.md`: the provider capability and its compiler
consumers can land together because the old seed compiles the new compiler,
which then exercises the new path. No runtime source calls a new compiler
builtin, so the runtime-source carve-out does not apply.

### 5.2 Supported-platform claim gate

A platform/architecture pair may be called clang-independent only when one
native cold job proves all of the following with clang absent or deterministically
poisoned:

1. bootstrap from the then-pinned released seed;
2. pass-1/pass-2 self-host fixed point and the existing determinism contract;
3. representative compiler, runtime, exception, concurrency, atomic, TLS,
   COMDAT/ABI, and target-link tests;
4. package/release-asset installation plus compile-link-run smoke;
5. tool-role output naming `llvm-as`, `opt`, `llc`, and the direct platform
   linker with complete target/SDK/CRT identity; and
6. a hard failure on any attempted clang invocation, with no fallback branch.

All four rows must pass before Sailfin makes an unqualified "supported native
platforms are clang-independent" claim. A cross-target object or link test is
useful coverage but cannot substitute for a native cold fixed point.

### 5.3 Relationship to the seal-sufficient native backend

The Cross-Platform Clang Independence Project retains LLVM for Select and
object emission. The Seal-Sufficient Native Backend Project builds a different
peer provider that can eventually perform Select/object emission without LLVM
on its gated tier-1 path. The two projects share the verified-IR capsule seam
and provider-neutral `NativeObject`/link contracts; neither project imports or
wraps the other provider.

The default optimized release path may remain `sfn/codegen-llvm` indefinitely.
The native provider can satisfy capability auditability and fast-dev goals
without becoming the performance oracle. Conversely, a clang-independent LLVM
release path does not satisfy the native project's no-LLVM or sealed-runtime
claim. This is the same provider boundary SFEP-0020 reserves:
`sfn/codegen-llvm` and `sfn/codegen-native` are peers depending on `sfn/ir`, and
only `sfn/compiler` owns external tools and final linking.

## 6. Alternatives considered

**Keep clang for object emission but invoke linkers directly.** Rejected. It
leaves every first-party LLVM module dependent on a C compiler driver and does
not provide a coherent tool/cache identity.

**Call `llc` directly on `.ll` and omit `llvm-as`/`opt`.** Rejected. Although
`llc` accepts textual IR, the shortcut erases the validation boundary and does
not reproduce clang O2's middle-end optimization intent.

**Let each LLVM executable resolve independently.** Rejected. Mixed LLVM majors
can accept different bitcode, flags, targets, or object behavior and make a
cache fingerprint meaningless.

**Use `ld64.lld` on Darwin.** Rejected for the supported default. Apple `ld`
and the active SDK/deployment contract are the release-compatibility oracle.
`ld64.lld` remains a possible separately qualified linker provider, not an
ambient substitute.

**Treat missing prerequisites as a reason to retry clang.** Rejected. A hidden
provider change invalidates ownership, diagnostics, and cache/provenance claims.

**Require all `c-sources` to be clang-free.** Rejected. Foreign C is explicitly
outside the first-party source/tool claim. Requiring a bundled C compiler would
expand the project without improving pure Sailfin builds.

**Make `Backend` the code-generation provider seam.** Rejected. Its current
shape is driver/tool invocation over LLVM text and cannot express a pure native
provider. SFEP-0020's capsule boundary is enforced and provider-neutral.

**Replace LLVM with the native backend in this project.** Rejected. It conflicts
with the project's bounded goal and would couple a cross-platform distribution
dependency cleanup to a separate, longer instruction-selection/object-emission
arc.

## 7. Stage1 readiness mapping

This proposal changes toolchain structure and reporting, not Sailfin language
semantics. The design is complete; implementation remains intentionally
pending while the proposal is Draft.

- [x] Parses — no language syntax change.
- [x] Type-checks / effect-checks — no effect semantics change (§4).
- [x] Emits valid `.sfn-asm` — unchanged.
- [x] Lowers to LLVM IR — existing provider remains the production basis.
- [ ] Regression coverage — the differential, resolver, linker, no-clang, and
      release gates in §8 are implementation work.
- [ ] Self-hosts under this contract — current seed may still require clang
      (§5.1).
- [ ] `sfn fmt --check` clean — applies to implementation leaves.
- [x] Design status documented — `docs/backend-independence.md` and
      `docs/status.md` distinguish current state from this destination.

The SFEP stays Draft until review accepts this provider contract. It becomes
Implemented only after the complete four-platform claim gate and
clang-independent seed/deletion ratchet pass; landing one provider or linker
leaf is not sufficient.

## 8. Test plan

The implementation project must provide these layers:

- **Structured unit tests:** coherent LLVM-family/root/PATH/version resolution,
  target/object probes, exact O0/O2 argv, artifact routing, cache namespace and
  fingerprint changes, each platform link argv/prerequisite resolver, response
  files, and deterministic tool-role JSON.
- **Failure classification:** missing/skewed tool family, invalid IR,
  optimization/lowering failure, unsupported triple/object, missing or mixed
  loader/SDK/CRT/startup/import library, authoritative override failure, absent
  foreign compiler, and poisoned clang.
- **Differential execution:** recorded clang oracle versus the LLVM pipeline
  for numerical behavior, ABI/COMDAT, exceptions/unwind, TLS, atomics,
  concurrency, filesystem/network-visible effects, and O0/O2 determinism.
- **Performance oracle:** three-run median compiler/consumer benchmarks and
  image-size comparisons under §3.5's thresholds on each supported target.
- **Direct-link integration:** program, test, runtime, self-host, response-file,
  packaging, and installed-toolchain layouts through the single dispatcher.
- **Native fixed points:** Linux x86-64, Linux aarch64, macOS arm64, and Windows
  x86-64 with clang absent/poisoned, preserving tool-role and attempted-spawn
  evidence.
- **Release and seed:** downloaded-asset smoke on all four targets, then clean
  bootstrap and full self-host verification from the newly pinned seed.
- **Permanent ratchet:** static executable-reference census plus the dynamic
  native cold matrix, with narrow reviewed exceptions for foreign C and
  optional test oracles only.

Each implementation leaf updates `docs/status.md` when its behavior becomes the
default for a target. The tracker reports partial progress per role/target and
never rounds a green cross-target test up to native support.

## 9. References

- [Cross-Platform Clang Independence Project](https://linear.app/sailfin/project/cross-platform-clang-independence-baeafe4f0a9a)
- **SFEP-0020** — Role-Oriented Compiler Capsules (provider boundary)
- **SFEP-0059** — Typed SSA Activation (verified-IR and differential seams)
- **SFEP-0060** — The Owned Syscall Layer (orthogonal libc/syscall axis)
- **SFEP-0016** — The Capability-Sealed Runtime
- **SFEP-0025** — Native Runtime Architecture
- `docs/backend-independence.md` — living architecture tracker
- `docs/status.md` — shipped state
- `.claude/rules/seed-dependency.md` — compiler/runtime seed policy
- [LLVM `llvm-as` command guide](https://llvm.org/docs/CommandGuide/llvm-as.html)
- [LLVM `opt` command guide](https://llvm.org/docs/CommandGuide/opt.html)
- [LLVM `llc` command guide](https://llvm.org/docs/CommandGuide/llc.html)
- [LLD Windows support](https://lld.llvm.org/windows_support.html)
- [Microsoft command-line build tools](https://learn.microsoft.com/en-us/cpp/build/building-on-the-command-line)
- Retired: `docs/proposals/archive/0015-llvm-independence.md`
