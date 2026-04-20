---
title: "Pipeline Operator"
description: "Design preview — Pipeline Operator. Planned, not yet shipped."
sidebar:
  order: 3
---

```sfn
// |> is not yet implemented; use function calls

pipeline index_corpus(docs: string[]) -> void ![io, gpu] {
    docs
        |> chunk(by: "semantic", target_tokens: 512)   // planned
        |> embed(with: "e5-large")
        |> upsert(index: "docs_idx");
}
```
