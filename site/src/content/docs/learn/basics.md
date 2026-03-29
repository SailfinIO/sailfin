---
title: Language Basics
description: Variables, types, control flow, and expressions in Sailfin.
section: learn
order: 1
---

## Variables

Sailfin uses `let` for bindings. Variables are immutable by default:

```sfn
let name = "Sailfin";      // immutable
let mut count = 0;          // mutable
count = count + 1;          // OK
// name = "Other";          // ERROR: immutable binding
```

## Primitive Types

| Type | Description | Example |
|------|-------------|---------|
| `Int` | 64-bit signed integer | `42` |
| `Float` | 64-bit floating point | `3.14` |
| `Bool` | Boolean | `true`, `false` |
| `String` | UTF-8 string | `"hello"` |
| `Byte` | Unsigned byte | `0xFF` |

## String Interpolation

Sailfin uses double-brace interpolation:

```sfn
let name = "world";
let greeting = "Hello, {{name}}!";     // "Hello, world!"
let math = "2 + 2 = {{2 + 2}}";       // "2 + 2 = 4"
```

## Control Flow

### If / Else

```sfn
if temperature > 100 {
    print.warn("Too hot!");
} else if temperature < 0 {
    print.warn("Too cold!");
} else {
    print.info("Just right.");
}
```

### Match

```sfn
match status {
    "active" => activate(),
    "paused" => pause(),
    "stopped" => stop(),
    _ => print.warn("Unknown status: {{status}}"),
}
```

### Loops

```sfn
// For loop
for item in items {
    process(item);
}

// Loop with break
loop {
    let event = poll();
    if event.is_done() {
        break;
    }
}
```

## Collections

```sfn
// Arrays
let numbers: Array<Int> = [1, 2, 3, 4, 5];
let first = numbers[0];

// Vectors (growable)
let mut items = Vec.new();
items.push("alpha");
items.push("beta");
```

## Next Steps

- [Functions & Methods](/docs/learn/functions) — Defining and calling functions
- [Types & Structs](/docs/learn/types) — Custom types, enums, and interfaces
