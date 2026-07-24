---
title: Models & Pipelines (Advanced)
description: AI constructs in Sailfin — the ![model] effect and the planned sfn/ai capsule.
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
| `![model]` effect | **Reserved** | Declarable and propagated from function signatures, but 0.8 has no shipped model detector or runtime API. |
| `model` / `prompt` / `tool` / `pipeline` block keywords | **Removed** | These keywords have been removed from the language parser and compiler. AI functionality is being delivered as the `sfn/ai` library capsule, planned post-1.0. |

## The `![model]` Effect (Reserved)

The `![model]` effect can be declared today and propagates through resolved
calls like other declared effects. It is reserved for the future `sfn/ai`
capsule, however: 0.8 ships no model-specific detector or runtime API.

```sfn
fn ai_call(model_name: string, input: string) -> string ![model] {
    // implemented in sfn/ai capsule (post-1.0)
    return "";
}

fn summarize_invoice(invoice: string) -> string ![model, io] {
    let payload = redact(invoice);
    let summary = ai_call("summarizer", payload);
    print(summary);
    return summary;
}
```

In this example the declared effect on `ai_call` propagates to
`summarize_invoice`; that generic signature propagation should not be confused
with a shipped model invocation boundary.

## The `sfn/ai` Capsule (Planned Post-1.0)

The `sfn/ai` capsule will provide:

- Model invocation functions carrying `![model]` in their signatures
- Typed output schemas and structured response parsing
- Tool dispatch for model-orchestrated function calls
- Provider adapters (OpenAI, Anthropic, and others)

Because these are library functions, not keywords, they can be versioned and
updated independently of compiler releases. The `![model]` effect gates the
entire capsule surface at the language level.

## What Is Not Shipped

- `model { ... }` block declarations — removed from the language
- `prompt system { ... }` / `prompt user { ... }` blocks — removed
- `tool Name { ... }` declarations — removed
- `pipeline Name { ... }` declarations — removed
- `Tensor<...>` types, `training` blocks, PyTorch/Ollama adapters — not implemented

---

*The `sfn/ai` capsule that will host runtime AI behaviour is post-1.0 work. See the [roadmap](/roadmap).*
