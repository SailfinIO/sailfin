---
title: "§2 Modules and Imports"
description: "Sailfin language specification — Modules and Imports."
sidebar:
  order: 2
  label: "§2 Modules and Imports"
---

```sfn
import { Channel, channel } from "sync";
import { log } from "sfn/log";
import { parse } from "./parser";
import { substring as substr } from "runtime/prelude";

export { MyType, my_fn };
export { helper as publicHelper } from "./internal";
```

- **Relative paths** (`"./module"`) — same capsule
- **Registry capsules** (`"sfn/log"`) — from the capsule registry
- **Workspace capsules** (`"core"`) — sibling capsules in a workspace

Modules may re-export items from other modules. Specifiers support aliasing with `as`.
