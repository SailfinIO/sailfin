---
title: Functions & Methods
description: Defining functions, methods, closures, and understanding effect propagation.
section: learn
order: 2
---

## Function Declarations

```sfn
fn add(a: Int, b: Int) -> Int {
    return a + b;
}
```

Functions that perform side effects must declare them:

```sfn
fn save(data: String, path: String) ![io] {
    fs.write(path, data);
}
```

## Methods

Methods are defined in `impl` blocks:

```sfn
struct Circle {
    radius: Float,
}

impl Circle {
    fn area(&self) -> Float {
        return 3.14159 * self.radius * self.radius;
    }

    fn scale(&mut self, factor: Float) {
        self.radius = self.radius * factor;
    }
}
```

## Closures

```sfn
let double = |x: Int| -> Int { return x * 2; };
let numbers = [1, 2, 3].map(|n| n * 2);
```

## Effect Propagation

Effects are transitive. If a function calls an effectful function, it must declare those effects:

```sfn
fn helper() ![io] {
    print.info("helping");
}

// Must declare ![io] because it calls helper()
fn main() ![io] {
    helper();
}
```

The compiler provides fix-it hints when effects are missing.

## Next Steps

- [Types & Structs](/docs/learn/types) — Defining custom types
- [The Effect System](/docs/learn/effects) — Deep dive into capabilities
