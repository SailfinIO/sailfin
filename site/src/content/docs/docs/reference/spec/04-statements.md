---
title: "§4 Statements and Control Flow"
description: "Sailfin language specification — Statements and Control Flow."
sidebar:
  order: 4
  label: "§4 Statements and Control Flow"
---

```sfn
// Variables
let x = 10;
let mut y = 0;

// Conditionals
if x > 5 {
    y = 1;
} else if x == 5 {
    y = 0;
} else {
    y = -1;
}

// For loop
for item in items {
    process(item);
}

// Conditional loop (desugars to `loop` plus a conditional `break`)
while queue.length > 0 {
    handle(queue.pop());
}

// Loop with break value
let result = loop {
    let val = compute();
    if val > threshold {
        break val;
    }
};

// Match — see stability note below
match status {
    "active"  => activate(),
    "paused"  => pause(),
    _         => print.err("Unknown: {{ status }}"),
}

// Try / catch / finally (err is bare, no type annotation)
try {
    let data = fs.read(path);
    process(data);
} catch (err) {
    print.err("Read failed: {{ err }}");
    throw err;
} finally {
    cleanup();
}
```

**Assignment operators**: `=`, `+=`, `-=`, `*=`, `/=`

> **Current `match` scope:** Literal patterns, `_`, guards, and enum-variant
> destructuring lower end-to-end. Compile-time exhaustiveness checking remains
> partial, so emitted matches retain the `match_exhaustive_failed` runtime
> backstop for an uncovered value.
