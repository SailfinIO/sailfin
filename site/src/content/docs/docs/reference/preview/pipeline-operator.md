---
title: "Pipeline Operator"
description: "Design preview — Pipeline Operator. Planned, not yet shipped."
sidebar:
  order: 3
---

```sfn
// |> is not yet implemented; use function calls
fn index_corpus(docs: string[]) -> void ![io] {
    let chunked = chunk(docs);
    let embedded = embed(chunked);
    upsert(embedded, "docs_idx");
}
```
