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
  cost_cap   = $0.05
  evaluators = [ Faithfulness, LatencyBudget(150ms) ]
}

type Summary {
  title   : String
  bullets : Vec<String>
  risks?  : Vec<String>
}

fn summarize_doc(doc: Text) -> Summary ![model, io] {
  prompt system {
    "You are a careful technical summarizer. Output matches `Summary`."
  }
  prompt user {
    "Summarize:\n{{ doc }}"
  }

  let generation = Summarizer.call()
  console.info(generation.card)    // provenance metadata
  generation.output                // typed `Summary`
}

pipeline index_corpus(docs: Seq<Text>) ![io, gpu] {
  docs
    |> chunk(by: "semantic", target_tokens: 512)
    |> embed(with: "e5-large")
    |> upsert(index: "docs_idx")
}
```

## Current Status

Sailfin is under active design and bootstrapping.  
The Python-hosted stage0 toolchain supports a growing subset of the language while the self-hosted compiler, effect system, and runtime evolve in Sailfin itself.

- `docs/spec.md` — current reference for the implemented bootstrap subset.
- `docs/enbf.md` — evolving grammar draft.
- `docs/package-management.md` — outlines the capsule and registry model manager.
- `docs/keywords.md` — evolving list of reserved keywords and future directions.

## Architecture Overview

The project is organized into capsules, each representing a coherent, publishable unit such as a library, runtime, or tool.  
Multiple capsules form a fleet, managed by a single `fleet.toml` workspace manifest.  
Capsules can be published to a registry as bundles or model packs.

```
/sailfin
  fleet.toml
  /std
  /runtime
  /compiler
  /tools
  /packs
```

## Roadmap Highlights

- Full effect and taint checking across compiler phases, including cross-capsule capability manifests.
- Model-aware testing with golden and adversarial suites, replayable via signed generation cards.
- GPU-native execution paths for embeddings, vector search, and differentiable kernels.
- Self-hosted compiler with incremental type checking, LSP integration, and notebook workflows.

## Contributing

Sailfin is evolving quickly. See `CONTRIBUTING.md` (coming soon) and join the discussion in issues once the repository is public.  
For now, experiment, record findings, and propose ideas through pull requests.

> Note: This repository is pre-release and not yet versioned. Expect breaking changes while core concepts stabilize.

> Registry Placeholder: The domain `registry.sailfin.dev` is not yet live; publish/resolve examples are illustrative until public launch.

