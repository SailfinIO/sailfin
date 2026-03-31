# SailfinIO

**Sailfin** is an AI-native, systems-friendly programming language designed for precision, safety, and introspection. Its type system unifies deterministic computation, effect isolation, and capability-aware security to make large-scale AI-integrated software reliable by default.

## The Language

Sailfin combines the performance guarantees of a systems language with first-class support for AI workloads — models, prompts, pipelines, and tools are language primitives, not library abstractions.

**Core design principles:**

- **Effect types** — every function explicitly declares what it can do (`io`, `net`, `model`, `gpu`, `rand`, `clock`), enabling compile-time capability auditing and reproducible builds
- **Ownership and borrowing** — memory safety without garbage collection, with `Affine<T>` and `Linear<T>` for precise resource control
- **Capability-based security** — `PII<T>`, `Secret<T>`, and structured data-egress policies enforced through the type system
- **AI constructs as primitives** — typed model invocation, structured prompt composition, and generation provenance cards are built into the language
- **Self-hosted native compiler** — Sailfin compiles itself via LLVM with no interpreter layer

## Current Status

Sailfin is under active pre-1.0 development. The self-hosted native compiler compiles itself and is being stabilized. The 1.0 release targets a fully self-hosted toolchain; Python build tooling and a C runtime are currently required and are being eliminated as hard prerequisites for 1.0.

| Milestone | Status |
|---|---|
| Self-hosted native compiler (LLVM backend) | Active — stabilization in progress |
| Core language (structs, enums, interfaces, generics) | Shipped |
| Effect checker (`io`, `net`, `model`) | Shipped |
| Python build tooling elimination | In Progress — hard 1.0 prerequisite |
| Sailfin-native runtime (replacing C runtime) | In Progress — hard 1.0 prerequisite |
| Concurrency primitives (`await`, `routine`, `channel`) | Planned |
| Full ownership enforcement | Planned |
| AI construct execution (model calls, generation cards) | Planned |

See [`docs/status.md`](https://github.com/SailfinIO/sailfin/blob/main/docs/status.md) for the full feature matrix and [`docs/roadmap.md`](https://github.com/SailfinIO/sailfin/blob/main/docs/roadmap.md) for the 1.0 milestone plan.

## Repository

All development takes place in the [sailfin](https://github.com/SailfinIO/sailfin) repository. The compiler, runtime, standard library, documentation, and website live together in a single monorepo.

## Getting Started

```sh
# Linux / macOS
curl -fsSL https://raw.githubusercontent.com/SailfinIO/sailfin/main/install.sh | bash

# Windows (PowerShell)
irm https://raw.githubusercontent.com/SailfinIO/sailfin/main/install.ps1 | iex
```

Full documentation is available at [sailfin.dev](https://sailfin.dev).

## Contributing

Sailfin is built in the open. Contributions are welcome — from compiler work and runtime development to documentation and language design.

- [Contributor Guide](https://github.com/SailfinIO/sailfin/blob/main/CONTRIBUTING.md)
- [Open Issues](https://github.com/SailfinIO/sailfin/issues)
- [Language Specification](https://github.com/SailfinIO/sailfin/blob/main/docs/spec.md)
