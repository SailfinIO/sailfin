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
  cost_cap   = 0.05  // USD (currency literal — future; use plain number in bootstrap)
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
  print.info(generation.card)      // provenance metadata (bootstrap: `print` bound to runtime.console)
  generation.output                // typed `Summary`
}
Prompt evaluation order: prompts execute in source order; the common sequence is
system → user → assistant → tool.

Typed prompts (planned): `prompt user<SummaryRequest> { ... }` is design-stage
syntax for shape-checked prompts and is not accepted by the bootstrap parser.

pipeline index_corpus(docs: Seq<Text>) ![io, gpu] {
  // Future syntax note: the `|>` operator is part of the self-hosted design
  // and not supported by the bootstrap parser. Use ordinary function calls in
  // stage0 or treat this as illustrative pseudocode.
  docs
    |> chunk(by: "semantic", target_tokens: 512)
    |> embed(with: "e5-large")
    |> upsert(index: "docs_idx")
}
```

## Current Status

Sailfin is under active design and bootstrapping. The native stage2 compiler is
the primary toolchain today; the Stage1 bootstrap compiler remains in the build
pipeline for now. The runtime currently ships as C and is
planned to move into Sailfin for the 1.0 release.

- `docs/status.md` — source of truth for what the bootstrap compiler enforces
  versus what exists only in prototypes.
- `docs/spec.md` — bootstrap language reference with design-preview callouts.
- `docs/enbf.md` — grammar sketch aligned to the stage1 parser (with notes on legacy stage0 behaviour where it still matters).
- `docs/keywords.md` — reserved words and runtime notes.

## Installing the compiler

The compiler is published as per-OS/arch release assets and can be installed via the
curlable `install.sh` script. The repository is currently private, so you need a
token with `repo` scope.

```sh
export GITHUB_TOKEN=<your-token>
curl -fsSL https://raw.githubusercontent.com/SailfinIO/sailfin/alpha/install.sh | bash
```

To pin a version:

```sh
export GITHUB_TOKEN=<your-token>
VERSION=0.1.1-alpha.66 curl -fsSL https://raw.githubusercontent.com/SailfinIO/sailfin/alpha/install.sh | bash
```

Notes:

- Windows is supported for the published sailfin binary. Run the installer from WSL or Git Bash (MSYS2/Cygwin environments are detected as `windows`).
- Release assets are expected to be named `sailfin-stage2_<version>_<os>_<arch>.tar.gz` and contain `bin/sailfin-stage2` (or `bin/sailfin-stage2.exe` on Windows).

## Architecture Overview

Sailfin targets a capsule-based architecture with fleets coordinating compiler,
runtime, and tooling capsules. The current repository hosts the stage2 native
compiler (`build/native`) and the stage1 bootstrap pipeline (`compiler/src` +
`compiler/build`) alongside the Sailfin runtime (`runtime/`). Future capsule manifests and
fleet layout are tracked in `docs/roadmap.md`.

## Roadmap Highlights

Major milestones and sequencing are captured in `docs/roadmap.md`. Consult the
status page before editing documentation or examples to confirm whether a
feature has shipped.

## Contributing

Sailfin is evolving quickly. See `CONTRIBUTING.md` (coming soon) and join the discussion in issues once the repository is public.  
For now, experiment, record findings, and propose ideas through pull requests.

### Local Development

- `make install` — create or update the `sailfin` Conda environment defined in `environment.yml`.
- `make test` — run the suite.
- `make package` — build the stage1 release artifact (`dist/sailfin-stage1-<version>.zip`).
- `sailfin-stage1 <paths> --out <dir>` — compile Sailfin sources using the installed stage1 bundle.

The Sailfin registry at `registry.sailfin.dev` is live for experiments; the
bootstrap toolchain has not yet integrated manifest workflows, so treat registry
examples in the docs as design previews.
