<p align="center">
  <a href="https://sailfin.dev">
    <img src="https://raw.githubusercontent.com/SailfinIO/sailfin/main/site/public/images/sfn_lang_logo_256.svg" alt="Sailfin" width="128">
  </a>
</p>

<h1 align="center">Sailfin</h1>

<p align="center">
  <strong>A self-hosted systems language with compile-time capability checks.</strong>
</p>

<p align="center">
  <a href="https://sfn.dev"><strong>Website</strong></a> ·
  <a href="https://sfn.dev/docs/getting-started/install">Install</a> ·
  <a href="https://sfn.dev/docs/reference/spec/">Language Spec</a> ·
  <a href="https://sfn.dev/roadmap">Roadmap</a> ·
  <a href="https://sfn.dev/blog">Blog</a> ·
  <a href="https://sfn.dev/llms.txt"><code>llms.txt</code></a>
</p>

<p align="center">
  <a href="https://github.com/SailfinIO/sailfin/releases"><img alt="Latest release" src="https://img.shields.io/github/v/release/SailfinIO/sailfin?include_prereleases&display_name=tag"></a>
  <a href="https://github.com/SailfinIO/sailfin/blob/main/LICENSE"><img alt="License: GPL v2" src="https://img.shields.io/badge/license-GPL_v2-blue"></a>
  <a href="https://github.com/SailfinIO/sailfin/stargazers"><img alt="GitHub stars" src="https://img.shields.io/github/stars/SailfinIO/sailfin?style=flat"></a>
</p>

> **Status:** Sailfin is pre-1.0 and under active development. The native
> compiler is self-hosted and the runtime is written in Sailfin. The current
> backend still lowers through LLVM and links with the platform toolchain;
> LLVM/clang independence is a project goal, not the current shipping state. For
> the exact feature matrix, see [`docs/status.md`](docs/status.md).

## What is Sailfin?

Sailfin is a systems programming language built around explicit capabilities.
Functions spell the effects they use, such as `![io]`, `![net]`, or
`![clock]`, and capsules declare which capabilities they require. The compiler
checks both levels, so capability use is visible in source and rejected when it
exceeds the declared surface.

The long-term goal is a production-ready compiler, runtime, and capsule
ecosystem with a capability-sealed runtime. The repository is already
self-hosting: the compiler is written in Sailfin, compiles itself from a
released seed, and links a Sailfin runtime from `runtime/sfn/` and
`runtime/prelude.sfn`.

## Repository Layout

- `compiler/src/` - the Sailfin compiler, written in Sailfin.
- `runtime/` - the Sailfin runtime capsule, including platform adapters,
  memory, strings, process, clock, and concurrency support.
- `capsules/sfn/` - standard library capsules such as `strings`, `json`,
  `fs`, `http`, `net`, `cli`, `test`, and numeric/ML-oriented capsules.
- `compiler/tests/` - unit, integration, and end-to-end compiler tests.
- `examples/` - small language and library examples.
- `docs/` - engineering docs, status matrices, proposals, performance notes,
  and RCAs.
- `site/` - the public website and user-facing language documentation.
- `tools/mcp-server/` - MCP integration backed by compiler diagnostics.

## Current Capabilities

The current self-hosted compiler supports the core language: functions,
structs, enums with payloads, interfaces, type aliases, arrays, generics with
partial inference, closures with capture, pattern matching, `Result<T, E>` and
`?`, `unsafe` / `extern fn`, atomic intrinsics, and explicit numeric casts.

The effect system enforces registered `io`, `net`, `clock`, and `rand` entropy
boundaries, including resolved cross-module propagation, dotted sub-effects, and
capsule capability checks. The runtime syscall seal remains a 1.0 target.
Ownership enforcement is active for the owned-buffer family and affine / linear bindings, with
broader borrow checking still in development.

The tooling includes:

- `sfn build` and `sfn run`
- `sfn check` with structured JSON diagnostics
- `sfn fmt --check` / `sfn fmt --write`
- `sfn test` with filtering, snapshots, parallel execution, and a per-test
  binary cache
- `sfn init`, `sfn add`, `sfn lock`, `sfn package`, and `sfn publish`

Structured concurrency is available as a v0 surface: `routine`, `channel`,
`spawn` / `await`, and `parallel` work end-to-end, with typed channel
constructors, richer result collection, and the post-1.0 async I/O runtime
still planned.

For the detailed current-state matrix, use [`docs/status.md`](docs/status.md).
For language semantics, use the
[specification](https://sfn.dev/docs/reference/spec/).

## Example

```sfn
struct User {
  id:   int;
  name: string;
}

fn greet(user: User) -> string ![io] {
  let msg = "Hello, {{ user.name }}!";
  print(msg);
  return msg;
}

test "greet produces correct output" {
  let u = User { id: 1, name: "Alice" };
  let result = greet(u);
  assert(result == "Hello, Alice!");
}
```

`greet` calls `print`, so it declares `![io]`. If the annotation is removed,
`sfn check` reports a compile-time effect error. If a capsule exposes code that
uses `io`, its `capsule.toml` must include `io` in `[capabilities].required`.

## Installing

The v0.8.0 release provides pre-built archives for Linux x86_64, macOS arm64
(Apple Silicon), and Windows x86_64. The archive installs the compiler as both
`sailfin` and `sfn`.

Installing the compiler is only the first prerequisite: compiling, running, or
testing Sailfin programs still requires LLVM tools 17+ or 18+, `clang`, and the
platform linker. The Linux/macOS bootstrap script additionally needs `curl`,
`tar`, `uname`, `mktemp`, and `jq`; signature verification needs OpenSSL 1.1.1+
with raw-Ed25519 support.

The installer defaults to the latest matching release and exposes the commands
in `~/.local/bin` on Linux/macOS or
`%LOCALAPPDATA%\sailfin\bin` on Windows.

### Linux / macOS

```sh
curl -fsSL https://raw.githubusercontent.com/SailfinIO/sailfin/main/install.sh | bash
```

To pin a specific release:

```sh
VERSION=0.8.0
curl -fsSL https://raw.githubusercontent.com/SailfinIO/sailfin/main/install.sh | VERSION="$VERSION" bash
```

### Windows PowerShell

```powershell
irm https://raw.githubusercontent.com/SailfinIO/sailfin/main/install.ps1 | iex
```

To pin a specific release:

```powershell
$env:VERSION = "0.8.0"
irm https://raw.githubusercontent.com/SailfinIO/sailfin/main/install.ps1 | iex
```

Release assets follow the pattern `sailfin_<version>_<os>_<arch>.tar.gz`.
Set `GITHUB_TOKEN` to raise the GitHub API rate limit if release lookup is
throttled.

Both bootstrap scripts try to verify the signed `SHA256SUMS` manifest and the
selected archive's SHA-256 digest before extraction. They warn and continue
only when the signed manifest is absent or suitable OpenSSL is unavailable;
once verification can run, malformed or invalid signed metadata and digest
mismatches abort. See the
[manual verification guide](https://sailfin.dev/docs/getting-started/verify-download/).

## Building From Source

The compiler self-hosts from the released seed pinned in
[`bootstrap.toml`](bootstrap.toml). Source builds require `bash`, `make`, `jq`,
LLVM tools 17+ or 18+, `clang`, and OpenSSL development libraries because the
Sailfin-native runtime links TLS into every binary. See
[`docs/development-setup.md`](docs/development-setup.md) for per-platform
dependency installation and the supported build flags.

```sh
make compile          # Build the self-hosted native compiler
make test             # Run the test suite with an existing build
make check            # Build as needed, build seedcheck, and run the full gate
make install          # Install to PREFIX/bin, defaulting to ~/.local/bin
make clean            # Remove packaged artifacts under dist/
```

After compiling:

```sh
build/bin/sfn --version
build/bin/sfn run examples/basics/hello-world.sfn
build/bin/sfn check compiler/src/
```

If installed:

```sh
sfn --version
sfn run examples/basics/hello-world.sfn
sfn fmt --check compiler/src/ runtime/
```

## Development Notes

- The current backend emits Sailfin native IR (`.sfn-asm`), lowers to LLVM IR,
  and links with the platform toolchain.
- The compiler has deterministic self-hosting coverage: the full verification
  gate checks that successive compiler stages produce byte-identical LLVM IR.
- `docs/status.md` is the source of truth for shipped, partial, and planned
  behavior.
- User-facing docs live in `site/src/content/docs/` and are published at
  [sfn.dev/docs](https://sfn.dev/docs/).
- The public roadmap is generated from GitHub milestones at
  [sfn.dev/roadmap](https://sfn.dev/roadmap).

## Contributing

See [`CONTRIBUTING.md`](CONTRIBUTING.md) for contribution guidelines. Groomed
work is tracked in the [issue tracker](https://github.com/SailfinIO/sailfin/issues),
and the roadmap at [sfn.dev/roadmap](https://sfn.dev/roadmap) tracks
the larger milestones.
