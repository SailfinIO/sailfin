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

## Exporting declarations

A top-level declaration is module-private until it is named in the module's
export manifest. There are two equivalent ways to export one:

```sfn
// Block form — name the symbols in an `export { ... }` list.
fn parse(text: string) -> Token[] { ... }
export { parse };

// Inline form — prefix the declaration with `export`.
export fn parse(text: string) -> Token[] { ... }
```

`export <declaration>` is exactly equivalent to declaring the item and then
naming it in a block export — `export fn f() {}` ≡ `fn f() {} export { f };`.
The inline form works for every top-level declaration:

```sfn
export fn make(x: int) -> int { return x; }
export async fn fetch(u: string) -> Bytes ![net] { ... }
export struct Point { x: int, y: int }
export enum Color { Red, Green, Blue }
export interface Reader { fn read() -> Bytes; }
export type Id = int;
export let MAX: int = 256;
export thread_local let mut counter: int = 0;
export extern fn write(fd: int, buf: i8*, n: int) -> int;
```

Decorators follow the `export`: `export @logExecution fn traced() ![io] { ... }`.
A symbol exported both inline and via a block is a harmless de-duplicated no-op.
The `from` re-export clause is block-only (`export { x } from "./internal";`) —
an inline export always defines a concrete declaration, so it never carries a
source.
