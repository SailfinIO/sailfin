---
title: "Model Execution"
description: "Design preview — Model Execution. Planned, not yet shipped."
sidebar:
  order: 2
---

```sfn
// model.call() parses today but performs no execution

fn summarize(text: string) -> Summary ![io, model] {
    prompt system { "You are a precise summarizer." }
    prompt user   { "Summarize: {{ text }}" }
    let gen = Summarizer.call();   // planned: executes against model provider
    print(gen.card);               // planned: generation card (provenance metadata)
    return gen.output;             // planned: typed Summary
}
```

**Planned post-1.0**: model execution, generation cards, typed output schemas, evaluators.
