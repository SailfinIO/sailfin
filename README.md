# Sailfin

Sailfin is an AI-native, systems-friendly programming language designed for precision, safety, and introspection.
Its type system unifies deterministic computation, effect isolation, and capability-aware security to make large-scale model-driven software reliable by default.

## Why Sailfin

- **Safety without friction** — Algebraic data types, ownership-aware linear typing, and pattern matching keep data pipelines fast and correct without manual memory management.
- **Deterministic where it counts** — Effects such as `io`, `net`, `model`, `gpu`, `rand`, and `clock` are explicit in type signatures, enabling reproducible builds, replayable model calls, and compile-time guarantees.
- **AI first-class (planned)** — Models, prompts, schemas, embeddings, and retrieval indices are designed as native concepts. The runtime will track latency, cost, and provenance for every generation automatically. See _What's Coming_ below.
- **Capability-oriented security** — Secrets, PII, and data egress policies will be enforced through the type system and runtime guards.
- **Interoperable by design** — Sailfin integrates safely with native binaries and sandboxed adapters while maintaining strong typing and effect boundaries.

## What Works Today

The self-hosted native compiler (`build/native/sailfin`) supports:

- Functions, structs, enums, interfaces, type aliases, and generics (parsed; inference is limited)
- `let`/`let mut` variables, pattern matching (`match`), `if`/`else`, `for`, `while`, `try`/`catch`
- Effect annotations (`![io, net, model, ...]`) — the effect checker enforces `io`, `net`, and `model` (for `prompt` blocks)
- String interpolation (`{{ expression }}`), decorators, `async fn`
- `model` and `prompt` blocks — parsed and emitted to `.sfn-asm` IR; **no runtime model execution yet**
- `pipeline` declarations — parsed as plain functions; the `|>` operator is not yet implemented
- `tool` declarations — parsed and recorded; dispatcher is not yet implemented
- `Affine<T>`, `Linear<T>`, `PII<T>`, `Secret<T>` — parsed; ownership and taint enforcement are not yet active
- The `sfn/log` capsule for structured logging
- `print(value)` / `print.err(value)` for stdout/stderr output
- `sfn test` for running `*_test.sfn` files

```sfn
struct User {
  id   -> number;
  name -> string;
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

## What's Coming

Sailfin is working toward a 1.0 release with a fully self-hosted toolchain — no Python build scripts, no C runtime. Key upcoming milestones:

- **Compiler stabilization** — eliminating the Python post-processing fixup script; `build.sh` becomes the sole build path
- **Sailfin-native runtime** — replacing the current C runtime; a hard prerequisite for 1.0
- **Concurrency primitives** — `await`, `routine { }` blocks, and `channel()` as first-class constructs
- **Full ownership enforcement** — move semantics, borrow checking, use-after-move errors

After 1.0, the focus shifts to making AI constructs fully functional:

```sfn
// Future: model execution, typed prompt blocks, generation cards, and provenance metadata
model Summarizer : Model<Text, Summary> {
  engine    = "gpt-neo@3.1"
  schema    = Summary
  max_tok   = 2000
  // cost_cap = 0.05  // USD — currency literal syntax planned
}

fn summarize_doc(doc: Text) -> Summary ![io, model] {
  prompt system { "You are a careful technical summarizer." }
  prompt user   { "Summarize:\n{{ doc }}" }
  let generation = Summarizer.call()
  print(generation.card)    // provenance metadata
  return generation.output  // typed Summary
}
```

See `docs/status.md` for a detailed feature matrix and `docs/roadmap.md` for sequencing.

## Current Status

Sailfin is under active development targeting a 1.0 release. The recommended compiler is `v0.1.1` (pinned in CI); releases past that point are built with the Python stabilization script and are pre-stabilization artifacts.

- `docs/status.md` — source of truth for what the compiler enforces versus what is still planned
- `docs/spec.md` — language reference with design-preview callouts
- `docs/roadmap.md` — milestones and sequencing toward 1.0
- `docs/enbf.md` — grammar sketch aligned to the current parser

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

Sailfin targets a capsule-based architecture with fleets coordinating compiler,
runtime, and tooling capsules. The current repository hosts the native compiler
(under `build/native`) alongside the Sailfin runtime (`runtime/`). Future capsule
manifests and fleet layout are tracked in `docs/roadmap.md`.

## Local Development

- `make env` — create or update the `sailfin` Conda environment defined in `environment.yml`. Only needed for `BUILD_DRIVER=py`; the default shell driver has no Conda requirement.
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
