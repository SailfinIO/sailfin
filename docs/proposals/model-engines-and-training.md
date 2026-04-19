# Sailfin Proposal: Model Engines, Adapters, Tensors, and Training

Status: Draft Proposal

Author: Sailfin Core Team

Date: October 2025

Applies to: Compiler, Runtime, Spec, and Package Manager

Goal: Unify inference and training semantics through typed engines, modular adapters, and native tensor primitives.

---

## 1. Overview

Sailfin already treats models and prompts as first-class language constructs. However, model creation, training, and fine-tuning are not yet implemented, and runtime engines remain implicit.

This proposal formalizes:

- The Engine system (how `engine = "provider:name@version"` works)
- The Adapter interface (pluggable runtime backends)
- Native Tensor and Dataset types
- Training declarations (`training ... for ... { ... }`)
- Provenance and deterministic reproducibility
- CLI and manifest extensions (`sfn train`, `workspace.toml` changes)

These additions make Sailfin a fully AI-native systems language: capable of defining, training, and deploying models reproducibly.

Status note: All features in this document are planned unless explicitly marked
as shipped in `docs/status.md`.

---

## 2. Engine System

Engines represent execution backends for models — e.g., OpenAI APIs, local Torch, or JAX/MLX kernels.

### 2.1 Engine Identifiers (surface syntax)

Examples:

- `engine = "openai:gpt-4o@2025-09-01"`
- `engine = "ollama:llama3.1@8b-q4_k_m"`
- `engine = "torch:bert-base-uncased@2.5"`
- `engine = "jax:vision-transformer@0.7.1"`
- `engine = "mlx:whisper-small@1.0.0"`
- `engine = "onnxrt:reranker@1.2.3"`

EBNF (planned):

```
EngineIdent = Provider ":" Name "@" Version ;
Provider    = Identifier ;
Name        = Identifier { "-" | "_" | "." | "/" | Letter | Digit } ;
Version     = Identifier { "-" | "_" | "." | Letter | Digit } ;
```

Notes:
- Parsing accepts a broad `Name`/`Version` token set; provider-specific constraints are enforced by adapters at runtime, not in the grammar.
- Existing examples in the spec using `engine = "gpt-foo@…"` remain valid; the provider-less form resolves via the project’s default provider registry.

### 2.2 Resolution and Execution (planned)

1) Parse engine string → `(provider, name, version)`.
2) Resolve an adapter by provider via an Adapter Registry (see §3).
3) Resolve artifacts: local cache, provider registry, or remote endpoint.
4) Materialize an EnginePlan:
   - Executable target (binary or HTTP endpoint)
   - Tokenizer spec and I/O schemas
   - Device/precision settings
   - Declared capabilities (`infer` and optionally `train`)
5) Enforce effects: `![model]` required for inference, `![train]` for training.
6) Execute via sandboxed adapter, producing a generation card (inference) or training card (training).

---

## 3. Adapter Interface

Adapters are sandboxed modules or subprocesses that implement a unified interface for model operations.

### 3.1 Responsibilities

- Normalize Sailfin inputs to backend tensors/requests
- Implement `infer` and (optionally) `train`
- Collect telemetry: cost, latency, token/step counts, device, precision
- Enforce capability and taint policies at the boundary
- Expose metadata for reproducibility (engine build hash, config)

### 3.2 Minimal Adapter Manifest (concept)

```json
{
  "provider": "torch",
  "supports": ["infer", "train"],
  "transport": "process",
  "entrypoint": "sfn-adapter-torch",
  "env": [],
  "map": {
    "engineParam": "model",
    "temperature": "temperature",
    "seed": "seed"
  }
}
```

### 3.3 Adapter Interface (planned)

```sfn
interface EngineAdapter {
  fn infer(request: EngineRequest) -> EngineResponse ![model];
  fn train(request: TrainRequest) -> TrainResponse ![train];
}
```

Transport choices: `process` or `http`. `inproc` is reserved for trusted
environments.

---

## 4. Tensor and Dataset Primitives

### 4.1 Tensor Type (planned)

Sailfin defines a native value type:

```
Tensor<Shape, DType>
```

- Shape is a fixed or symbolic tuple (e.g. `[N, D]`).
- DType is one of `f32`, `f16`, `bf16`, `i32`, `bool`, etc.

Tensors support zero-copy semantics and integrate with `gpu` effect.

### 4.2 Basic Operations (planned std capsule)

A standard capsule `sailfin/tensor` provides core ops.

```sfn
use sailfin/tensor as tensor

let x -> Tensor<[N, D], f32> = tensor.zeros([N, D])
let y = tensor.add(x, 1.0)
let z = tensor.matmul(x, y)
```

### 4.3 Algorithm Capsules (user-level, planned)

The following are examples to illustrate the pattern for algorithm capsules; they are not exhaustive. The plan is to provide a standard, growing set of commonly used model-building algorithms as composable capsules (organized under `sailfin/layers`, `sailfin/nn`, and `sailfin/losses`). Examples of planned coverage include:

- Positional encodings: Rotary, Sinusoidal, ALiBi
- Attention variants: Multi-head attention, FlashAttention (as capability-gated kernels), KV-cache ops
- Normalization: LayerNorm, RMSNorm, GroupNorm
- Regularization: Dropout, Stochastic Depth, Label Smoothing
- Activations: GELU, SiLU/Swish, ReLU, Softmax, Tanh
- Convolutional blocks: Depthwise/Pointwise conv, Residual blocks
- Transformer blocks: Encoder/Decoder layers, Pre/Post-norm variants
- Pooling and projections: Avg/Max pooling, linear projections
- Losses and metrics: CrossEntropy, MSE, CosineEmbedding, Focal loss, Accuracy/F1/Recall@k

Rotary Positional Encoding:

```sfn
fn rotary(x -> Tensor<[N, D], f32>, freqs -> Tensor<[D], f32>) -> Tensor<[N, D], f32> ![gpu] {
  let cos = tensor.cos(freqs)
  let sin = tensor.sin(freqs)
  return tensor.concat([
    x[..., :D/2] * cos - x[..., D/2:] * sin,
    x[..., :D/2] * sin + x[..., D/2:] * cos,
  ], axis: -1)
}
```

Stochastic Depth:

```sfn
fn stochastic_depth(x -> Tensor<[N, D], f32>, drop_rate -> number, train -> boolean) -> Tensor<[N, D], f32> ![rand, gpu] {
  if train && rand.uniform() < drop_rate {
      return tensor.zeros_like(x)
  } else {
      return x / (1 - drop_rate)
  }
}
```

### 4.4 Datasets (planned)

Introduce `Dataset<T>` and `Dataloader<T>` with helpers: `shuffle`, `map`, `cache`, `prefetch`. Loaders require `io` and may declare `gpu` for device transfer.

---

## 5. Training Declarations

### 5.1 Syntax (planned)

A training declaration defines how to fine-tune or train a model.

```sfn
training SummarizerFT for Summarizer ![train, gpu, io] {
  dataset   = dataset.csv("data/train.csv") -> Dataset<Example>;
  valset    = dataset.csv("data/val.csv")   -> Dataset<Example>;
  epochs    = 3;
  batch     = 64;
  optimizer = Adam(lr: 3e-4, weight_decay: 1e-2);
  loss      = CrossEntropy();
  hooks     = [ Checkpoint(every: 1epoch), EarlyStop(patience: 3) ];
}
```

### 5.2 EBNF (planned)

```
TrainingDeclaration = "training" Identifier "for" Identifier [ EffectList ] Block ;
```

Allowed statements inside the block (non-exhaustive):
- `dataset = ...;`, `valset = ...;`
- `epochs = number;`, `batch = number;`
- `optimizer = Ident(…);`, `loss = Ident(…);`
- `hooks = [ Ident(…)* ];`

### 5.3 Execution Semantics (planned)

The compiler lowers a training block to a typed training pipeline:

```
dataset -> dataloader -> forward -> loss -> backward -> step
```

- Requires `![train]` (and typically `![gpu]`).
- Produces a signed TrainingCard (engine, dataset hashes, optimizer, seed, device, metrics).
- Resumable via checkpoints and replayable through the registry.

Note: Provide a `sfn train` CLI that validates manifests and prints a dry-run
plan; no real training in the initial implementation.

---

## 6. Provenance and Reproducibility

Card types and contents (planned):

- Generation Card (model.call): engine ident, parameters, token counts (if available), seed, device, precision, latency, cost
- Training Card (training): engine ident, dataset digests, optimizer config, loss curve, metrics, step/epoch counts, checkpoint hashes, seeds, device/precision

Cards are stored under `.sfn/cards/` and signed if `signing = true` in `workspace.toml`.

---

## 7. Package Manager & CLI Extensions

### 7.1 `capsule.toml` (capsule-level)

```toml
[models]
"summarizer" = "openai:gpt-4o@2025-09-01"

[training]
"SummarizerFT" = "torch:bert-base-uncased@2.5"

[capabilities]
allow = ["model", "train", "gpu", "io"]
```

### 7.2 `workspace.toml` (workspace-level)

```toml
[provenance]
lock_models = true
signing = true

[provenance.training]
lock_datasets = true
lock_engines  = true
sign_cards    = true

[registry]
primary = "https://pkg.sfn.dev"

[engines.prefs]
device = "auto"      # "cpu" | "gpu" | "auto"
precision = "auto"   # "fp32" | "fp16" | "int8" | "auto"
```

### 7.3 CLI (planned)

| Command                      | Description                             |
|----------------------------- |-----------------------------------------|
| `sfn train <model>`          | Run training/finetune declaration       |
| `sfn model pack <model>`     | Package trained weights + card          |
| `sfn models list`            | List installed or cached models         |
| `sfn adapters list`          | List available adapters                 |
| `sfn dataset verify`         | Validate dataset digests                |
| `sfn provenance diff`        | Compare provenance cards between builds |

---

## 8. Example End-to-End Flow (planned)

```sfn
model Summarizer : Model<Text, Summary> {
  engine      = "torch:bert-base-uncased@2.5";
  schema      = Summary;
  max_tok     = 2000;
  evaluators  = [ Faithfulness, LatencyBudget(150ms) ];
}

training SummarizerFT for Summarizer ![train, gpu, io] {
  dataset   = dataset.csv("corpus.csv") -> Dataset<Text>;
  epochs    = 2;
  batch     = 128;
  optimizer = Adam(lr: 3e-4);
  loss      = CrossEntropy();
}
```

CLI (illustrative):

```
sfn train SummarizerFT
sfn model pack SummarizerFT --out packs/summarizer-ft.sfnpkg
```

Results:
- `.sfn/cards/SummarizerFT.card.json`
- `.sfn/checkpoints/summarizer-ft/`

These can be replayed deterministically or published to the registry.

---

## 9. Security and Capability Enforcement

- Inference requires `![model]`.
- Training requires `![train]` (and usually `![gpu]`).
- Datasets and adapters respect `PII<T>` and `Secret<T>` wrappers; the runtime refuses egress without a redaction/consent policy.

---

## 10. Implementation Roadmap (incremental)

| Phase | Feature                         | Components                                  |
|------:|---------------------------------|---------------------------------------------|
| 1     | Engine & Adapter abstraction    | runtime adapters, openai/torch stubs        |
| 2     | Tensor type + ops library       | `sailfin/tensor` capsule                    |
| 3     | Training declarations           | parser + runtime dry-run                    |
| 4     | Provenance & cards              | runtime + `sfn train` CLI                   |
| 5     | GPU execution & autograd        | native Sailfin runtime                       |
| 6     | Cross-engine reproducibility    | adapter registry + signed cards             |

---

## 11. Open Questions

- Should adapters be allowed to compile Sailfin code directly (e.g., JAX → XLA)?
- Should Sailfin ship a built-in lightweight tensor runtime or rely on existing frameworks long-term?
- How to guarantee deterministic reductions on non-deterministic GPU ops?
- Can training hooks (e.g., EarlyStop) be generic functions or must they be built-ins?
- Should `dataset` and `optimizer` be effectful capsules or language primitives?

---

## 12. Next Steps

- Review this proposal collaboratively (core, compiler, runtime).
- Once accepted:
  - Add section “Engines & Training” to `docs/spec.md`.
  - Extend EBNF for `EngineIdent`, `TrainingDeclaration`, and Tensor types in `docs/enbf.md`.
  - Implement Adapter Registry in `runtime/adapters/`.
  - Add CLI commands (`sfn train`, `sfn adapters list`).
  - Add tests under `runtime/tests/engine_and_training/`.

---

### Appendix A: Adapter Registry Sketch (pseudocode)

```sfn
struct AdapterRegistry {
  adapters -> Map<string, EngineAdapter>;
}

fn resolve(registry: AdapterRegistry, engine_ident: string) -> EngineAdapter {
  let provider = engine_ident.split(":", 1)[0];
  let adapter = registry.adapters.get(provider);
  if adapter == null {
    throw RuntimeError("Unknown engine provider: {{ provider }}");
  }
  return adapter;
}
```

Notes:
- This appendix is non-binding and illustrative; exact APIs may change during implementation.
