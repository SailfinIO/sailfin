---
title: AI Integration
description: How Sailfin gates AI operations through the effect system, and the planned sfn/ai library capsule.
section: learn
order: 8
---

Sailfin gates AI operations through the `![model]` effect — the same capability system used for IO, networking, and other side effects. AI-specific constructs (model invocation, prompt templating, generation provenance) are being delivered as the `sfn/ai` library capsule rather than language-level syntax. This keeps the language grammar stable while letting AI integration iterate independently of compiler releases.

> **Current status:** The compiler parses `model`, `prompt`, `pipeline`, and `tool` blocks and emits them to `.sfn-asm` IR. The `![model]` effect is enforced at compile time. However, **no runtime execution exists** — these constructs emit metadata only. They are being migrated to the `sfn/ai` capsule for post-1.0 delivery. The syntax documented below reflects the current parser; the library API may differ.

---

## `model` Declarations

A `model` block declares a named model binding with its engine, schema, and operational constraints.

```sfn
model Summarizer : Model<Text, Summary> {
    engine     = "openai:gpt-4o@2025-06";
    schema     = Summary;
    max_tok    = 2000;
    cost_cap   = 0.05;  // USD
    temperature = 0.2;
    seed       = 42;
    evaluators = [ Faithfulness, LatencyBudget ];
}
```

### Model block fields

| Field | Type | Description |
|-------|------|-------------|
| `engine` | String | Provider and model version string (e.g. `"openai:gpt-4o@2025-01"`) |
| `schema` | Type | Expected output struct type; planned for enforcement post-1.0 |
| `max_tok` | Int | Token budget for the completion |
| `cost_cap` | Float | Maximum cost in USD per call |
| `temperature` | Float | Sampling temperature (0.0–2.0) |
| `seed` | Int | Random seed for reproducible generation |
| `evaluators` | Array | Named evaluators to run on each output (planned) |

The type parameters `Model<I, O>` declare the input type `I` and output type `O`. These will be enforced by the type checker in the post-1.0 AI milestone.

### What works today

`model` blocks parse and emit a `.model` record into the `.sfn-asm` IR. The field values are recorded. The compiler registers the model name in the current scope.

### What is planned

`.call()` on a model — for example `Summarizer.call(text)` — currently parses as a method call expression. No inference happens: there is no model runtime yet. The call will be wired to a provider adapter in the post-1.0 AI milestone.

---

## `prompt` Blocks

Prompt blocks compose multi-part instructions for a model. They are valid only inside functions that declare the `model` effect.

```sfn
fn summarize(text: String) -> Summary ![model] {
    prompt system { "You are a precise technical summarizer." }
    prompt user   { "Summarize the following document:\n\n{{ text }}" }
    // Summarizer.call() — execution planned for post-1.0
}
```

### Prompt channels

Each `prompt` block targets a message channel:

| Channel | Role |
|---------|------|
| `system` | System-level instruction to the model |
| `user` | User turn content |
| `assistant` | Assistant turn content (for few-shot examples) |
| `tool` | Tool call result being fed back to the model |

Prompt blocks are emitted in source order. The runtime will send them to the model adapter as an ordered message sequence.

### String interpolation

Prompt content supports `{{ variable }}` interpolation. Any variable in scope at the call site can be interpolated:

```sfn
fn classify(input: String, categories: Array<String>) -> Category ![model] {
    prompt system { "Classify into one of: {{ categories.join(\", \") }}." }
    prompt user   { "Input: {{ input }}" }
}
```

### What works today

`prompt` blocks parse and emit `.prompt` IR entries with their channel type and content. The `model` effect requirement is **enforced today** — any function containing a `prompt` block must declare `![model]`, or the compiler emits an error (see [Effect requirement](#effect-requirement-for-model-code) below).

### What is planned

No network calls are made when a `prompt` block is compiled. Prompt execution — sending the composed messages to the model engine and returning a typed result — is planned for the post-1.0 AI milestone.

---

## Effect Requirement for Model Code

The `model` effect is enforced **today** by the effect checker. Any function that contains a `prompt` block must declare `![model]`.

```sfn
// ERROR: missing ![model]
fn summarize(text: String) -> String {
    prompt system { "Summarize." }
    prompt user   { "{{ text }}" }
}
```

The compiler will produce:

```
effects.missing: function `summarize` uses a prompt block, which requires ![model],
                 but `summarize` has no effect annotation
  = help: add `model` to the effect list: `fn summarize(text: String) -> String ![model]`
```

This enforcement is active now because it is a property of the _syntax_, not the runtime. Even though no inference happens today, any code that declares a `prompt` must be clearly marked as requiring model capabilities.

If `summarize` is called from another function that also uses model-related APIs, that caller must declare `![model]` as well:

```sfn
fn analyze(doc: Document) -> Report ![io, model] {
    let summary = summarize(doc.body);  // OK: model is declared
    print("Summary done");
    return build_report(summary);
}
```

---

## `pipeline` Declarations

Pipelines declare named data-processing workflows. The syntax is parsed today and treated as a function declaration.

```sfn
pipeline index_corpus(docs: Array<String>) ![io] {
    // |> operator is planned — use function calls for now
    let chunks   = chunk(docs);
    let embedded = embed(chunks);
    upsert(embedded, "docs_idx");
}
```

Pipelines that involve model calls declare both `![io, model]`:

```sfn
pipeline enrich_records(records: Array<Record>) ![io, model] {
    let tagged   = tag_entities(records);
    let scored   = score_sentiment(tagged);
    save_all(scored);
}
```

### What works today

`pipeline` declarations parse as plain function declarations. They can be called like regular functions. All effect annotations are enforced normally.

### What is planned

The `|>` (pipe) operator will allow steps to be composed declaratively:

```sfn
// PLANNED — |> is not yet implemented
pipeline enrich(records: Array<Record>) ![io, model] {
    records
    |> tag_entities
    |> score_sentiment
    |> save_all;
}
```

The `|>` operator is not yet parsed. Use intermediate `let` bindings today (as shown in the working example above).

---

## `tool` Declarations

Tools are typed capabilities that models can invoke. A `tool` block declares the function signature, a description for the model, and the effect set it requires.

```sfn
tool lookup_order {
    description "Look up an order by its ID and return status and items."

    fn execute(order_id: String) -> Order ![io] {
        return db.find_order(order_id);
    }
}

tool send_notification {
    description "Send a notification to a user."

    fn execute(user_id: String, message: String) -> Bool ![net] {
        return http.post("https://notify.example.com/send", {
            to:   user_id,
            body: message,
        });
    }
}
```

### What works today

`tool` declarations parse and are recorded in the current scope. Their effect annotations are tracked. The compiler registers the tool name.

### What is planned

The tool dispatcher — the mechanism by which a model call can invoke a declared tool and have the result fed back as a `tool` prompt channel — is planned for the post-1.0 AI milestone. Today, tool `execute` functions can be called directly as regular functions.

---

## Design: Generation Cards

> **Not yet implemented.** Generation cards are part of the post-1.0 AI milestone.

Every model call will produce a _generation card_: a signed provenance record attached to the return value. Generation cards will contain:

- Input hash (for deduplication and caching)
- Engine name and version (e.g. `openai:gpt-4o@2025-06`)
- Parameters used (temperature, seed, max tokens)
- Latency in milliseconds
- Estimated cost in USD
- Output hash

Generation cards are the foundation of Sailfin's observability story for AI workloads. They make it possible to audit what model produced a given output, reproduce it (via seed), and enforce cost budgets at the call site.

---

## Design: Typed Output Schemas

> **Not yet implemented.** Schema enforcement is part of the post-1.0 AI milestone.

The `schema = Summary` field in a `model` block declares that the model's output must conform to the `Summary` struct type. At runtime, the model adapter will instruct the engine to produce structured JSON output matching the schema, and the compiler will enforce that the return type of a `.call()` expression matches the declared schema.

```sfn
struct Summary {
    headline   -> String;
    key_points -> Array<String>;
    word_count -> Int;
}

model Summarizer : Model<Text, Summary> {
    engine = "openai:gpt-4o@2025-06";
    schema = Summary;
    max_tok = 1500;
}
```

---

## Design: Evaluators

> **Not yet implemented.** Evaluators are part of the post-1.0 AI milestone.

The `evaluators` field in a `model` block names a list of quality checks to run on each model output before returning it to the caller. Built-in evaluators will include:

- `Faithfulness` — checks that the output does not hallucinate facts not present in the input
- `LatencyBudget(150)` — fails the call if inference took more than 150ms
- `CostGuard` — enforces the `cost_cap` field
- Custom evaluators can be declared as `tool` blocks

If an evaluator fails, the model call will return an error result rather than a potentially bad output.

---

## AI and the Effect System

The effect system and AI constructs are integrated by design. This integration is active **today**:

| Construct | Required effect | Enforced today |
|-----------|----------------|----------------|
| `prompt` blocks | `model` | Yes |
| `http.*` in tool `execute` | `net` | Yes |
| `fs.*` in tool `execute` | `io` | Yes |
| `print(...)` in a pipeline | `io` | Yes |
| Model `.call()` (planned) | `model` | Yes (syntax level) |

This means the _capability surface_ of any AI-enabled function is fully visible in its signature. A function that calls a model and logs results must declare `![io, model]`. A function that only transforms data with no side effects can remain pure — no effect annotation, provably no AI calls.

```sfn
// Pure transformation — no effects needed
fn chunk(text: String) -> Array<String> {
    return text.split_by_words(512);
}

// Uses a model — must declare ![model]
fn embed(chunks: Array<String>) -> Array<Vec> ![model] {
    prompt system { "Embed the following text." }
    prompt user   { "{{ chunks.join(\"\n\") }}" }
}

// Writes to storage — must declare ![io]
fn upsert(vecs: Array<Vec>, index: String) ![io] {
    fs.write(index, vecs.serialize());
}

// Full pipeline — union of all used effects
pipeline build_index(docs: Array<String>) ![io, model] {
    let chunks = chunk(docs);
    let vecs   = embed(chunks);
    upsert(vecs, "index.bin");
}
```

The compiler will reject a pipeline that calls `embed` (requires `![model]`) without declaring `![model]` on the pipeline itself. This prevents accidental model calls from hiding inside code that appears pure.

---

## Roadmap

The post-1.0 AI milestone will deliver:

- Model runtime and provider adapters
- `await`-based async model calls
- Generation cards
- Typed output schema enforcement via structured outputs
- Evaluator framework
- Tool dispatcher for model-invoked tools

These features build on the stable self-hosted LLVM backend targeted by the 1.0 release. See the [roadmap](/roadmap) for the current timeline.

---

## Next Steps

- [The Effect System](/docs/learn/effects) — How `![model]`, `![io]`, `![net]` work
- [Testing](/docs/learn/testing) — Testing AI-powered Sailfin code
- [Advanced: AI Constructs](/docs/advanced/ai-constructs) — Engine system, adapters, and evaluation
