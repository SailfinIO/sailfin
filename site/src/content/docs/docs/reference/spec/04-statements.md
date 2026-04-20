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

// Loop with break condition (Sailfin has no `while` — see Part B)
loop {
    if queue.length == 0 {
        break;
    }
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

> **Note on `match` stability**: `match` is parsed and emits IR, but LLVM lowering of common match patterns (number literals, enum variants) may trigger crashes or incorrect codegen in the current compiler. String pattern matching (as shown above) is more reliable. Move complex match expressions to Part B patterns or use `if`/`else if` chains until lowering stabilizes.
