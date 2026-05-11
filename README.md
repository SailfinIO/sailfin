<p align="center">
  <a href="https://sailfin.dev">
    <img src="https://raw.githubusercontent.com/SailfinIO/sailfin/main/site/public/images/sfn_lang_logo_256.svg" alt="Sailfin" width="128">
  </a>
</p>

<h1 align="center">Sailfin</h1>

<p align="center">
  <strong>A compiled systems language with compile-time capability enforcement.</strong>
</p>

<p align="center">
  Every function declares the capabilities it uses — IO, network, clock, and more — and the compiler rejects code that exceeds its declaration. No hidden side effects, no surprises at runtime.
</p>

<p align="center">
  <a href="https://sailfin.dev"><strong>Website</strong></a> ·
  <a href="https://sailfin.dev/docs/getting-started/install">Install</a> ·
  <a href="https://sailfin.dev/docs/reference/spec/">Language Spec</a> ·
  <a href="https://sailfin.dev/roadmap">Roadmap</a> ·
  <a href="https://sailfin.dev/blog">Blog</a> ·
  <a href="https://sailfin.dev/llms.txt"><code>llms.txt</code></a>
</p>

<p align="center">
  <a href="https://github.com/SailfinIO/sailfin/releases"><img alt="Latest release" src="https://img.shields.io/github/v/release/SailfinIO/sailfin?include_prereleases&display_name=tag"></a>
  <a href="https://github.com/SailfinIO/sailfin/blob/main/LICENSE"><img alt="License: GPL v2" src="https://img.shields.io/badge/license-GPL_v2-blue"></a>
  <a href="https://github.com/SailfinIO/sailfin/stargazers"><img alt="GitHub stars" src="https://img.shields.io/github/stars/SailfinIO/sailfin?style=flat"></a>
</p>

> **Status:** Pre-1.0, active development. The self-hosted native compiler is
> stable enough for daily use; some marquee features (structured concurrency,
> `Result<T, E>`, Sailfin-native runtime) are still on the path to 1.0. See
> [What Works Today](#what-works-today) and the
> [roadmap](https://sailfin.dev/roadmap) for the unvarnished picture.

---

## Why Sailfin

- **Effect types, enforced at compile time.** Capabilities like `io`, `net`,
  and `clock` are explicit in function signatures, propagate across module
  boundaries, and are checked against each capsule's declared capability
  surface. A function that calls `print` without declaring `![io]` does not
  compile. A capsule that uses `![net]` without declaring it in
  `capsule.toml` does not compile.
- **Capability-based security.** Capsules declare their capabilities in
  `capsule.toml`. The compiler cross-checks every function's effects against
  that surface, so a dependency cannot quietly start reading the filesystem
  or opening sockets you didn't grant it.
- **Pragmatic ergonomics.** Conventional syntax (TypeScript/Rust-like), a
  zero-configuration formatter, structured diagnostics with fix-it hints,
  and `--json` output for tooling and agents. Designed to be readable by
  humans and machines.
- **Self-hosted native compiler.** Sailfin compiles itself to LLVM IR — a
  real native toolchain, not an interpreter wrapper. Releases ship as
  single-binary `sailfin` / `sfn` artifacts per OS/arch.
- **Structured concurrency (planned).** Routines, channels, and parallel
  blocks as first-class language constructs with deterministic scoping —
  on the critical path to 1.0.

## What Works Today

The self-hosted native compiler (`build/native/sailfin`, installed as
`sailfin` / `sfn`) supports:

**Language**

- Functions, structs, enums (with payloads), interfaces, type aliases, and
  generics (type-parameter capture; full inference is partial)
- `let` / `let mut`, pattern matching (`match` with guards and
  destructuring), `if` / `else`, `for`, `while`, `try` / `catch` / `finally`
- `int` (i64) and `float` (f64) numeric types, alongside `bool`, `string`,
  and arrays. `number` remains as an alias for `float`.
- Bitwise and shift operators (`&`, `|`, `^`, `<<`, `>>`) and explicit
  numeric `as` casts with a typed lowering matrix (`sitofp`, `fptosi`,
  `sext`, `trunc`, …)
- Atomic intrinsics: `atomic_load`, `atomic_store`, `atomic_add`,
  `atomic_sub`, `atomic_cas`, `atomic_fence` (sequential consistency at v0)
- `extern fn` declarations for C-ABI interop (parser + typecheck +
  LLVM `declare` emission)
- Decorators, `async fn` parsing (concurrency runtime pending), string
  interpolation (`{{ expression }}` — migrating to `${ expression }` before
  1.0)

**Effect system (enforced)**

- `![io]`, `![net]`, `![clock]` are real compile-time gates. Undeclared use
  of `print.*` / `console.*` / `fs.*` (io), `http.*` / `websocket.*` /
  `serve` (net), or `sleep` (clock) fails the build with structured
  diagnostics and a fix-it that inserts the missing annotation.
- **Cross-module effect propagation:** a function inherits the declared
  effects of any imported function it calls; missing propagation fails the
  build with `E0402`.
- **Capsule capability cross-check:** `[capabilities] required = [...]` in
  `capsule.toml` is a real contract. A function declaring an effect outside
  the capsule's surface fails with `E0403`.
- `![model]`, `![gpu]`, and `![rand]` are reserved in the effect taxonomy;
  call-site detectors land alongside the libraries that use them.

**Tooling**

- `sfn build` / `sfn run` — content-addressed build cache with `--no-cache`,
  `--clean`, `--cache-trace`, and `--json` output
- `sfn check` — fast parse + typecheck + effect-check without codegen;
  `--json` emits the `sailfin-check/1` envelope consumed by the MCP server
- `sfn fmt --check` / `sfn fmt --write` — zero-configuration token-stream
  formatter, enforced in CI
- `sfn test` — discovers and runs `*_test.sfn` files
- `sfn init` / `sfn add` / `sfn publish` — package registry at
  `pkg.sfn.dev` (configurable via `sfn config set registry <url>` or
  `SFN_REGISTRY` for private/enterprise registries)

**Standard library capsules** (under `capsules/sfn/`, imported by bare name):

`fmt`, `json`, `crypto`, `math`, `path`, `toml`, `fs`, `os`, `log`, `time`,
`cli`, `http` (partial), `tensor` / `layers` / `nn` / `losses` (CPU). See
[`docs/status.md`](docs/status.md) for the full feature matrix and effect
requirements per capsule.

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

`greet` calls `print`, so it must declare `![io]`. A capsule that exposes
`greet` must list `io` in its `[capabilities] required = [...]` surface, or
the compiler rejects it. Drop the `![io]` and `sfn check` reports `E0400`
with a fix-it that splices the annotation in for you.

## What's Coming

Sailfin is working toward a 1.0 release with a fully self-hosted toolchain
and a pure Sailfin runtime. The critical path:

- **`Result<T, E>` + `?` operator** — typed error handling to complement
  `try` / `catch`. Errors become visible in signatures.
- **`${expression}` string interpolation** — replacing `{{ }}` to align
  with mainstream conventions and reduce confusion for both humans and LLMs.
- **Raw pointer types (`*T`, `*const T`)** — needed for OS handles and
  buffer interop, enforced at typecheck.
- **Closures with capture** — `map`/`filter`/`reduce`, spawn handlers, and
  route handlers.
- **Generic type constraints** — `fn sort<T: Comparable>(…)`, real
  `Array<T>` / `HashMap<K, V>` / `Channel<T>`.
- **Deterministic drop emission** (in flight) — compiler-emitted scope-exit
  drops for owned values. Unblocks memory reclamation in the Sailfin-native
  runtime.
- **Structured concurrency** — `routine { }` blocks, `await`, `channel()`,
  and `spawn` as first-class constructs. M0 (atomic intrinsics) is shipped;
  the scheduler is next.
- **Effect system hardening** — hierarchical effects (`io.fs`, `net.http`),
  effect polymorphism for generics, and `sfn fix` for auto-inserting missing
  annotations.
- **Capability auditing (`sfn audit`)** — recursive capability analysis of
  a dependency tree before deployment.
- **Sailfin-native runtime** — the current C runtime under `runtime/native/`
  is being replaced module-by-module with Sailfin (`runtime/sfn/`). The
  first module (`memory/arena.sfn`) is already linked into the compiler;
  the full rewrite (~90 ABI functions) is a hard 1.0 prerequisite.

After 1.0, focus shifts to ecosystem growth: an `sfn/ai` capsule for
model invocation gated by `![model]`, taint types (`Secret<T>`, `PII<T>`)
with enforced data-flow tracking, ownership enforcement (move semantics
and borrow checking), and a WebAssembly target.

See [`docs/status.md`](docs/status.md) for the detailed feature matrix and
[`sailfin.dev/roadmap`](https://sailfin.dev/roadmap) for sequencing.

## Installing the Compiler

Releases are published as per-OS/arch tarballs containing `bin/sailfin` (or
`bin/sailfin.exe` on Windows). The installer script defaults to the latest
release and places binaries in `~/.local/bin` on Linux/macOS (override with
`GLOBAL_BIN_DIR`) or `%LOCALAPPDATA%\sailfin\bin` on Windows.

### Linux / macOS

```sh
curl -fsSL https://raw.githubusercontent.com/SailfinIO/sailfin/main/install.sh | bash
```

To pin a specific version:

```sh
VERSION=0.5.10-alpha.13 curl -fsSL https://raw.githubusercontent.com/SailfinIO/sailfin/main/install.sh | bash
```

### Windows (PowerShell)

```powershell
irm https://raw.githubusercontent.com/SailfinIO/sailfin/main/install.ps1 | iex
```

To pin a specific version:

```powershell
$env:VERSION = "0.5.10-alpha.13"
irm https://raw.githubusercontent.com/SailfinIO/sailfin/main/install.ps1 | iex
```

The PowerShell installer adds the install directory to your user `PATH`
automatically. On Windows you can also run `install.sh` from WSL or Git Bash.

Release assets follow the pattern `sailfin_<version>_<os>_<arch>.tar.gz`.
Set `GITHUB_TOKEN` to raise the GitHub API rate limit if you hit throttling.

## Architecture Overview

- **Compiler** — `compiler/src/*.sfn`. Pipeline: lexer → parser → AST →
  typecheck → effect-check → native IR (`.sfn-asm`) → LLVM IR.
- **Runtime** — `runtime/native/` (C, current) and `runtime/sfn/` (Sailfin,
  migration in progress). The Sailfin-native runtime is the 1.0 milestone.
- **Standard library** — `capsules/sfn/*`. Every capsule ships a
  `capsule.toml` manifest declaring its capability requirements.
- **MCP server** — `tools/mcp-server/`, registered via `.mcp.json`. Wraps
  the compiler so any agent can call `sailfin_check`, `sailfin_emit_llvm`,
  `sailfin_diagnostics`, and friends.

## Local Development

```sh
make compile          # Build the native compiler by self-hosting from a released seed
make test             # Run unit + integration + e2e tests
make check            # Compile (if needed), build a seedcheck, and run the full suite on it
make install          # Install the built compiler to PREFIX/bin (default: ~/.local/bin)
```

After `make compile`, invoke the compiler directly or via the installed binary:

```sh
build/native/sailfin --version
build/native/sailfin run examples/basics/hello-world.sfn
build/native/sailfin check compiler/src/

# Or, if installed via `make install`:
sfn --version
sfn run examples/basics/hello-world.sfn
sfn fmt --check compiler/src/ runtime/
```

The compiler self-hosts from a released seed binary; `make compile` fetches
the seed automatically. See [`CLAUDE.md`](CLAUDE.md) for the full developer
workflow, branch strategy, and release process.

## Contributing

See [`CONTRIBUTING.md`](CONTRIBUTING.md) for the contribution guide, and the
[issue tracker](https://github.com/SailfinIO/sailfin/issues) for groomed,
ready-to-pick-up work tagged `claude-ready`. The roadmap at
[sailfin.dev/roadmap](https://sailfin.dev/roadmap) tracks the epics that
feed into it.
