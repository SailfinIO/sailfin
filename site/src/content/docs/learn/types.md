---
title: Types & Structs
description: Structs, enums, interfaces, generics, and type aliases in Sailfin.
section: learn
order: 3
---

## Structs

```sfn
struct Point {
    x: Float,
    y: Float,
}

let origin = Point { x: 0.0, y: 0.0 };
```

## Enums

```sfn
enum Direction {
    North,
    South,
    East,
    West,
}

enum Option<T> {
    Some(T),
    None,
}
```

## Interfaces

Interfaces define shared behavior:

```sfn
interface Serializable {
    fn serialize(&self) -> String;
    fn deserialize(data: String) -> Self;
}

impl Serializable for Point {
    fn serialize(&self) -> String {
        return "{{self.x}},{{self.y}}";
    }

    fn deserialize(data: String) -> Self {
        let parts = data.split(",");
        return Point {
            x: Float.parse(parts[0]),
            y: Float.parse(parts[1]),
        };
    }
}
```

## Generics

```sfn
fn first<T>(items: Array<T>) -> Option<T> {
    if items.length == 0 {
        return Option.None;
    }
    return Option.Some(items[0]);
}
```

## Type Aliases

```sfn
type UserId = String;
type Matrix = Array<Array<Float>>;
```

## Wrapper Types

Sailfin provides special wrapper types for safety:

```sfn
let email: PII<String> = PII.wrap("user@example.com");
let api_key: Secret<String> = Secret.wrap("sk-...");
let handle: Affine<FileHandle> = open("data.txt");  // May be dropped, not copied
let token: Linear<AuthToken> = mint_token();          // Must be consumed exactly once
```

## Next Steps

- [The Effect System](/docs/learn/effects) — Capability-based security
- [Ownership & Borrowing](/docs/learn/ownership) — Memory safety
