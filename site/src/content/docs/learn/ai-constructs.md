---
title: AI Integration
description: How Sailfin gates AI operations through the effect system, and the planned sfn/ai library capsule.
section: learn
order: 8
---

Sailfin gates AI operations through the `![model]` effect — the same capability system used for IO, networking, and other side effects. The `model`, `prompt`, `pipeline`, and `tool` block keywords have been removed from the language. AI functionality will be delivered as a library via the `sfn/ai` capsule, planned for post-1.0. The `![model]` effect remains as the only AI-specific language feature.

## Why a Library, Not Language Syntax

AI APIs change faster than compiler release cycles. Embedding model providers, prompt formats, and orchestration patterns as language syntax would make the grammar a moving target. Delivering them as a library capsule allows independent iteration without breaking existing code.

The capability gate — `![model]` — stays in the language because it is a compile-time security property, not an API shape. Any function that calls into AI infrastructure must declare this effect, so the capability surface remains auditable regardless of which library version is in use.

## The `![model]` Effect

The `![model]` effect marks any function that calls into the `sfn/ai` capsule or any other library function carrying `![model]` in its signature. The effect propagates transitively through the call graph.

```sfn
// A library function that carries ![model] (e.g., from sfn/ai post-1.0)
fn ai_call(model_name: string, input: string) -> string ![model] {
    // implementation in sfn/ai capsule
}

// Callers must also declare ![model]
fn summarize(text: string) -> string ![model] {
    return ai_call("summarizer", text);
}

// Callers of summarize must also declare ![model]
fn process_document(doc: string) -> string ![io, model] {
    let summary = summarize(doc);
    print("Done");
    return summary;
}
```

Omitting `![model]` from any function in the chain is a compile-time error.

## Roadmap

The `sfn/ai` capsule is planned for post-1.0. It will provide model invocation, typed output schemas, and tool dispatch as library functions. See the [roadmap](/roadmap) for the current timeline.

---

## Next Steps

- [The Effect System](/docs/learn/effects) — How `![model]`, `![io]`, `![net]` work
- [Testing](/docs/learn/testing) — Testing Sailfin code
- [Advanced: AI Constructs](/docs/advanced/ai-constructs) — The `sfn/ai` capsule design
