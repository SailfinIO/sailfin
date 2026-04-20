---
title: "Concurrency"
description: "Design preview — Concurrency. Planned, not yet shipped."
sidebar:
  order: 1
---

```sfn
// `routine { }` and channels parse today; `await` does not.

import { Channel, channel } from "sync";

async fn fetch(url: string) -> string ![net] {
    return await http.get(url);   // await not yet implemented
}

fn process_batch(items: Item[]) ![io] {
    let messages: Channel<string> = channel();

    routine {
        messages.send("hello");
    }

    let msg = await messages.receive();
}
```

**Planned for 1.0**: `await`, full `routine` runtime, channel runtime, `spawn`.
See the [roadmap](/roadmap).
