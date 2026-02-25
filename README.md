# Sailfin

Sailfin is an AI-native, systems-friendly programming language designed for precision, safety, and introspection.  
Its type system unifies deterministic computation, effect isolation, and capability-aware security to make large-scale model-driven software reliable by default.

## Why Sailfin

- **Safety without friction** — Algebraic data types, ownership-aware linear typing, and pattern matching keep data pipelines fast and correct without manual memory management.
- **Deterministic where it counts** — Effects such as `io`, `net`, `model`, `gpu`, `rand`, and `clock` are explicit in type signatures, enabling reproducible builds, replayable model calls, and compile-time guarantees.
- **AI first-class** — Models, prompts, schemas, embeddings, and retrieval indices are native concepts. The runtime tracks latency, cost, and provenance for every generation automatically.
- **Capability-oriented security** — Secrets, PII, and data egress policies are enforced through the type system and runtime guards.
- **Interoperable by design** — Sailfin integrates safely with native binaries and sandboxed adapters while maintaining strong typing and effect boundaries.

## Snapshot

```sfn
model Summarizer : Model<Text, Summary> {
  engine     = "gpt-neo@3.1"
  schema     = Summary
  max_tok    = 2000
  cost_cap   = 0.05  // USD (currency literal — planned)
  evaluators = [ Faithfulness, LatencyBudget(150ms) ]
}

struct Summary {
  title   -> string;
  bullets -> Vec<string>;
  risks?  -> Vec<string>;
}

fn summarize_doc(doc: Text) -> Summary ![io, model] {
  prompt system {
    "You are a careful technical summarizer. Output matches `Summary`."
  }
  prompt user {
    "Summarize:\n{{ doc }}"
  }

  let generation = Summarizer.call()
  print.info(generation.card)      // provenance metadata
  generation.output                // typed `Summary`
}
Prompt evaluation order: prompts execute in source order; the common sequence is
system → user → assistant → tool.

Typed prompts (planned): `prompt user<SummaryRequest> { ... }` is design-stage
syntax for shape-checked prompts and is not yet accepted by the compiler.

pipeline index_corpus(docs: Seq<Text>) ![io, gpu] {
  // Future syntax note: the `|>` operator is planned and not yet accepted by
  // the compiler. Use ordinary function calls until the operator lands.
  docs
    |> chunk(by: "semantic", target_tokens: 512)
    |> embed(with: "e5-large")
    |> upsert(index: "docs_idx")
}
```

## Current Status

Sailfin is under active design and self-hosting. The self-hosted native compiler
is the primary toolchain today. The runtime currently ships as C and will move
to a Sailfin-native runtime before the 1.0 release, alongside removing any
Python tooling from the production pipeline.

- `docs/status.md` — source of truth for what the compiler enforces versus what is still planned.
- `docs/spec.md` — language reference with design-preview callouts.
- `docs/enbf.md` — grammar sketch aligned to the current parser.
- `docs/keywords.md` — reserved words and runtime notes.

## Installing the compiler

The compiler is published as per-OS/arch release assets and can be installed via the
curlable `install.sh` script. The repository is currently private, so you need a
token with `repo` scope.

```sh
export GITHUB_TOKEN=<your-token>
curl -fsSL https://raw.githubusercontent.com/SailfinIO/sailfin/main/install.sh | bash
```

To pin a version:

```sh
export GITHUB_TOKEN=<your-token>
VERSION=0.1.1-alpha.135 curl -fsSL https://raw.githubusercontent.com/SailfinIO/sailfin/main/install.sh | bash
```

Notes:

- Windows is supported for the published sailfin binary. Run the installer from WSL or Git Bash (MSYS2/Cygwin environments are detected as `windows`).
- Release assets are named `sailfin_<version>_<os>_<arch>.tar.gz` and contain `bin/sailfin` (or `bin/sailfin.exe` on Windows).

## Architecture Overview

Sailfin targets a capsule-based architecture with fleets coordinating compiler,
runtime, and tooling capsules. The current repository hosts the native compiler
(under `build/native`) alongside the Sailfin runtime (`runtime/`). Future capsule
manifests and fleet layout are tracked in `docs/roadmap.md`.

## Roadmap Highlights

Major milestones and sequencing are captured in `docs/roadmap.md`. Consult the
status page before editing documentation or examples to confirm whether a
feature has shipped.

## Contributing

Sailfin is evolving quickly. See `CONTRIBUTING.md` (coming soon) and join the discussion in issues once the repository is public.  
For now, experiment, record findings, and propose ideas through pull requests.

### Local Development

- `make env` — create or update the `sailfin` Conda environment defined in `environment.yml`.
- `make compile` — build the native compiler by self-hosting from a released seed.
- `make test` — run the suite using the self-hosted native compiler.
- `make install` — install the built compiler into `PREFIX/bin` (default: `~/.local/bin`).

Tip: use the repo-local wrapper `./sfn` to run the freshly built compiler without relying on PATH:

```sh
./sfn --version
./sfn test .
```

The Sailfin registry at `registry.sailfin.dev` is live for experiments; manifest
workflows are still in progress, so treat registry examples in the docs as design
previews.
