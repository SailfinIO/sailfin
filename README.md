# Sailfin

Sailfin is an AI-native, systems-friendly programming language that combines
Rust-grade safety, Swift-like ergonomics, and runtime introspection tailored
for large-scale model-driven software. The current toolchain is bootstrapped in
Python while the self-hosted compiler and runtime mature.

## Why Sailfin

- **Safety without friction** – Algebraic data types, ownership-aware linear
  typing, and pattern matching keep data pipelines fast and correct without the
  pain of manual memory management.
- **Deterministic where it counts** – Effects such as `io`, `net`, `model`,
  `gpu`, `rand`, and `clock` are explicit in type signatures, enabling
  reproducible builds, replayable model calls, and compile-time guarantees.
- **AI first-class** – Models, prompts, schemas, embeddings, and retrieval
  indices are core language concepts. The runtime tracks latency, cost, and
  provenance for every generation by default.
- **Capability-oriented security** – Secrets, PII, and data egress policies are
  enforced through the type system and runtime guards.
- **Polyglot interop** – Native FFI for Rust/C, sandboxed adapters for Python
  and JavaScript, and an open tool protocol let Sailfin serve as the glue across
  heterogeneous stacks.

## Snapshot

```sailfin
model Summarizer : Model<Text, Summary> {
  engine     = "gpt-neo@3.1";
  schema     = Summary;
  max_tok    = 2000;
  cost_cap   = $0.05;
  evaluators = [ Faithfulness, LatencyBudget(150ms) ];
}

type Summary {
  title   : String,
  bullets : Vec<String>,
  risks?  : Vec<String>
}

fn summarize_doc(doc: Text) -> Summary ![model,io] {
  prompt system {
    "You are a careful technical summarizer. Output matches `Summary`."
  }
  prompt user {
    "Summarize:\n{doc}"
  }

  let generation = Summarizer.call();
  log.trace(generation.card);        // provenance metadata
  generation.output                  // typed `Summary`
}

pipeline index_corpus(docs: Seq<Text>) ![io,gpu] {
  docs
    |> chunk(by: "semantic", target_tokens: 512)
    |> embed(with: "e5-large")
    |> upsert(index: "docs_idx");
}
```

## Current Status

Sailfin is in active design and bootstrapping. The Python-hosted toolchain
supports a growing subset of the language while we converge on the self-hosted
compiler, effect system, and AI runtime.

- `docs/spec.md` – authoritative reference for the implemented bootstrap subset.
- `enbf.md` – evolving grammar draft.
- `docs/package-management.md` – outlines the `sail` package and model manager.

## Roadmap Highlights

1. **Full effect and taint checking** across compiler phases, including
   cross-package capability manifests.
2. **Model-aware testing** with golden and adversarial suites, replayable via
   signed generation cards.
3. **GPU-native execution paths** for embeddings, vector search, and
   differentiable kernels.
4. **Self-hosted compiler** with incremental type checking, LSP, and notebook
   integration.

## Contributing

The language and toolchain are evolving rapidly. See `CONTRIBUTING.md` (coming
soon) and join the discussion in the issues once the repository is public. For
now, please experiment, record findings, and propose ideas via pull requests.

> **Note:** This repository is not yet versioned or released. Expect breaking
> changes while we iterate on the core language design.
