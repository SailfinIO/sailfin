# Sailfin

Sailfin is a compiled systems language with compile-time capability enforcement.
Every function declares what it can do — IO, network, clock, and more — and the compiler checks direct usage of effectful operations against those declarations before your code runs.

## Why Sailfin

- **Effect types** — Capabilities like `io`, `net`, `clock`, and `model` are explicit in function signatures. You can look at a function and know exactly what it does — no hidden side effects. The compiler checks these at compile time.
- **Capability-based security** — Capsules declare what effects they need in their manifest. Undeclared capabilities are compile-time errors. Audit your entire dependency tree's capability surface before deploying.
- **Pragmatic ergonomics** — Conventional syntax (TypeScript/Rust-like), fast compilation, single-binary output, and good error messages with fix-it hints. A language that's easy for humans and LLMs alike.
- **Structured concurrency (planned)** — Routines, channels, and parallel blocks as first-class language constructs with deterministic scoping.
- **Self-hosted native compiler** — Sailfin compiles itself via LLVM. A real native toolchain, not an interpreter wrapper.

## What Works Today

The self-hosted native compiler (`build/native/sailfin`) supports:

- Functions, structs, enums, interfaces, type aliases, and generics (parsed; inference is limited)
- `let`/`let mut` variables, pattern matching (`match`), `if`/`else`, `for`, `while`, `try`/`catch`
- Effect annotations (`![io, net, model, clock]`) — the effect checker detects capability violations (compilation gating on the [roadmap](https://sailfin.dev/roadmap))
- String interpolation (`{{ expression }}`), decorators, `async fn`
- Standard library capsules: `fmt`, `json`, `crypto`, `math`, `path`, `toml`, `fs`, `os`, `log`, `time`, `cli`, `http` (partial)
- Package registry at `registry.sailfin.dev` with dependency resolution (capability auditing planned)
- `print(value)` / `print.err(value)` for stdout/stderr output
- `sfn test` for running `*_test.sfn` files

```sfn
struct User {
  id:   number;
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

> **Note:** The language is undergoing a [syntax reform](https://sailfin.dev/roadmap) before
> 1.0. The `:` type annotation style shown above is the preferred form (the
> parser also accepts `->` in type positions, but this is being deprecated).
> String interpolation (`{{ }}`) will change to `${ }` in a future release.

## What's Coming

Sailfin is working toward a 1.0 release with a fully self-hosted toolchain — no Python build scripts, no C runtime. Key upcoming milestones:

- **Foundation types** — `int`/`float` numeric types, `Result<T, E>` + `?` error handling, `${}` string interpolation
- **Effect system hardening** — hierarchical effects (`io.fs`, `net.http`), effect polymorphism for generics, transitive call-graph enforcement, `--fix` auto-inserter for missing annotations
- **Structured concurrency** — `await`, `routine { }` blocks, `channel()`, and `spawn` as first-class constructs
- **Capability auditing** — `sfn audit` for dependency tree capability analysis; capsule-level effect enforcement
- **Sailfin-native runtime** — replacing the current C runtime; a hard prerequisite for 1.0
- **Developer tooling** — `sfn fmt`, `sfn check`, `sfn vet`

After 1.0, the focus shifts to ecosystem growth:

- **AI integration** — `sfn/ai` capsule for model invocation, prompt templating, and generation provenance (using the `![model]` effect for capability gating)
- **Taint types** — `Secret<T>` and `PII<T>` with compiler-enforced data flow tracking, integrated with the effect system
- **Ownership enforcement** — move semantics and borrow checking (deferred from 1.0 to avoid shipping unenforced guarantees)
- **WebAssembly target** — WASM emission for portable deployment

See `docs/status.md` for a detailed feature matrix and the [roadmap](https://sailfin.dev/roadmap) for sequencing.

## Current Status

Sailfin is under active development targeting a 1.0 release. The self-hosted compiler compiles itself via LLVM and passes a growing test suite.

- `docs/status.md` — source of truth for what the compiler enforces versus what is still planned
- `docs/spec.md` — language reference with design-preview callouts
- [sailfin.dev/roadmap](https://sailfin.dev/roadmap) — milestones and sequencing toward 1.0
- `docs/enbf.md` — grammar sketch aligned to the current parser
- `llms.txt` — single-file language reference designed for LLM context windows (also at [sailfin.dev/llms.txt](https://sailfin.dev/llms.txt))

## Installing the Compiler

The compiler is published as per-OS/arch release assets and can be installed via
the curlable `install.sh` script (Linux/macOS) or `install.ps1` (Windows).

### Linux / macOS

```sh
curl -fsSL https://raw.githubusercontent.com/SailfinIO/sailfin/main/install.sh | bash
```

To pin a version:

```sh
VERSION=0.1.1-alpha.135 curl -fsSL https://raw.githubusercontent.com/SailfinIO/sailfin/main/install.sh | bash
```

### Windows (PowerShell)

```powershell
irm https://raw.githubusercontent.com/SailfinIO/sailfin/main/install.ps1 | iex
```

To pin a version:

```powershell
$env:VERSION = "0.1.1-alpha.135"
irm https://raw.githubusercontent.com/SailfinIO/sailfin/main/install.ps1 | iex
```

The PowerShell installer places `sailfin.exe` and `sfn.exe` in `%LOCALAPPDATA%\sailfin\bin` and adds it to your user PATH.

Notes:

- On Linux and macOS, use the `install.sh` script above.
- On Windows, use the PowerShell installer or run `install.sh` from WSL / Git Bash.
- Release assets are named `sailfin_<version>_<os>_<arch>.tar.gz` and contain `bin/sailfin` (or `bin/sailfin.exe` on Windows).
- Set `GITHUB_TOKEN` to increase GitHub API rate limits if you hit throttling.

## Architecture Overview

The repository hosts the self-hosted native compiler (under `build/native`)
alongside the Sailfin runtime (`runtime/`). Packages are distributed as capsules
with `capsule.toml` manifests that declare capability requirements. The
[roadmap](https://sailfin.dev/roadmap) tracks the path to 1.0.

## Local Development

- `make compile` — build the native compiler by self-hosting from a released seed.
- `make test` — run the suite using the self-hosted native compiler.
- `make install` — install the built compiler into `PREFIX/bin` (default: `~/.local/bin`).

Tip: after `make compile`, use the built binary directly or the installed compiler on PATH:

```sh
build/native/sailfin --version
build/native/sailfin test .
# or, if installed via `make install`:
sfn --version
sfn test .
```

## Contributing

Sailfin is evolving quickly. See `CONTRIBUTING.md` and join the discussion in issues.
For experiments, record findings and propose ideas through pull requests.
