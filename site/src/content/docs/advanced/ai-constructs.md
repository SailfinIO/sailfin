---
title: Models & Pipelines (Advanced)
description: Engine system, adapters, training, and advanced AI features.
section: advanced
order: 3
---

> See also: [AI Constructs (Learn)](/docs/learn/ai-constructs) for the basics.

## Engine System

Sailfin's engine system provides a unified interface across AI providers:

```sfn
model gpt4o = openai:"gpt-4o@2025-09-01";
model bert = torch:"bert@2.5";
model local_llm = ollama:"llama3:8b";
```

Provider identifiers follow the format: `provider:model-name@version`

## Adapters

Adapters are sandboxed modules implementing the unified model interface. Each provider has an adapter:

- `openai` — OpenAI API (GPT-4o, o1, etc.)
- `anthropic` — Anthropic API (Claude)
- `torch` — PyTorch models
- `ollama` — Local models via Ollama

## Tensors

```sfn
let weights: Tensor<[768, 512], Float32> = Tensor.zeros();
let input: Tensor<[1, 768], Float32> = encode(text);
let output = input.matmul(weights);  // ![gpu]
```

## Training (Proposed)

```sfn
training finetune for gpt4o {
    dataset = load_dataset("train.jsonl");
    epochs = 3;
    learning_rate = 1e-5;
}
```

## Generation & Training Cards

Every model interaction produces provenance metadata:

- **Generation cards**: Input hash, model version, cost, latency, seed
- **Training cards**: Dataset hash, hyperparameters, metrics, reproducibility info

## Capabilities

- `![model]` — Required for inference (prompt blocks, model calls)
- `![train]` — Required for training operations (proposed)
- `PII<T>` and `Secret<T>` enforcement on model inputs

---

*Advanced AI features are specified in the [model engines proposal](https://github.com/SailfinIO/sailfin/blob/main/docs/proposals/model-engines-and-training.md). Implementation is phased across the 1.0 roadmap.*
