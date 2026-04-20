---
title: Models & Pipelines (Advanced)
description: AI constructs in Sailfin — what's enforced today and what's parsed-but-stubbed.
section: advanced
sidebar:
  order: 3
---

> See also: [AI Integration (Learn)](/docs/learn/ai-constructs) for the basics
> and the `![model]` effect.

## Status Summary

Sailfin's AI story is two layers:

| Layer | Status | Notes |
|---|---|---|
| `![model]` effect | **Enforced today** | A language-level capability gate. Calls into model-invoking code require callers to declare `![model]` in their effect list; the effect checker rejects the code otherwise. |
| `model` / `prompt` / `tool` / `pipeline` blocks | **Parsed, metadata only** | The parser accepts these constructs and the compiler emits metadata, but there is **no runtime execution**. They will move from language syntax into the `sfn/ai` capsule post-1.0. Do not rely on them for inference today. |
| `Tensor<...>`, `training` blocks, PyTorch/Ollama adapters | **Proposal only** | Specified in design notes; not implemented in the compiler or standard library. |

The guidance below shows what the parser accepts today. Treat any inference,
training, tensor, or adapter behaviour as **not yet wired up** — these examples
compile and type-check but do not call external providers.

## The `![model]` Effect (Enforced)

The `![model]` effect is a real, enforced capability. Any function that invokes
model-related code must declare it, and callers must declare it transitively:

```sfn
fn call_model(name: string, input: string) -> string ![model] {
    return "{{name}}::{{input}}";
}

fn summarize_invoice(invoice: string) -> string ![model, io] {
    let payload: string = redact(invoice);
    let summary: string = call_model("summarizer", payload);
    print(summary);
    return summary;
}
```

Removing `![model]` from `summarize_invoice` is a compile-time error — this is
the safety property Sailfin actually ships today.

## `model` Blocks (Parsed, Metadata Only)

A `model` block declares a named model binding with an engine identifier and
optional schema metadata. The compiler records the declaration but does **not**
dispatch to a real provider at runtime.

```sfn
model Summarizer : Model<Text, Summary> {
    engine = "mock@1";
    schema = Summary;
    max_tok = 2000;
}
```

## `prompt` Blocks (Parsed, Metadata Only)

Inside a function declared with `![model]`, `prompt` blocks describe system and
user turns. They are syntactic markers — no provider is called.

```sfn
fn summarize(doc: string) -> string ![model] {
    prompt system {
        "Summarize the document precisely.";
    }
    prompt user {
        doc;
    }
    return call_model("summarizer", doc);
}
```

## `tool` Declarations (Parsed)

A `tool` is a function-like declaration that can be surfaced to a future
model-orchestration runtime. Today it parses exactly like a function with an
effect list:

```sfn
tool FetchTitle(id: string) -> string ![net] {
    return "title:" + id;
}
```

## `pipeline` Blocks (Parsed, Metadata Only)

A `pipeline` groups model-calling logic under a single effect surface. Its body
runs as ordinary code today; no orchestration layer intercepts it.

```sfn
pipeline summarize_all(docs: string[]) -> void ![model, io] {
    for doc in docs {
        summarize(doc);
    }
}
```

## `with` Scopes (Parsed, Metadata Only)

A `with` block is intended to thread deterministic-inference knobs (seed,
temperature) through nested calls. Today the identifiers inside `with` resolve
as ordinary function calls; there is no scheduler that reads them.

```sfn
fn main() -> void ![model, io] {
    with seed(42), temperature(0.2) {
        let result: string = summarize("Design doc");
        print(result);
    }
}
```

## What Is **Not** Shipped

The following appear in design notes but are **not** in the compiler or the
standard library. Treat them as forward-looking proposals:

- `Tensor<...>` types, tensor operations, and a `![gpu]` execution path
- `training` blocks, fine-tuning, dataset loading
- Concrete provider adapters (OpenAI, Anthropic, PyTorch, Ollama)
- `![train]` effect
- Runtime enforcement of `PII<T>` / `Secret<T>` on model inputs (parsed only)
- Generation and training provenance cards

---

*The full design direction for models, engines, and training lives in the
[model engines proposal](https://github.com/SailfinIO/sailfin/blob/main/docs/proposals/model-engines-and-training.md).
The `sfn/ai` capsule that will host runtime behaviour is post-1.0 work.*
