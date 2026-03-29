---
title: Ownership & Borrowing
description: Sailfin's move semantics, borrowing rules, and linear types.
section: learn
order: 5
---

Sailfin uses move-by-default semantics to manage resources without a garbage collector.

## Move Semantics

When you assign a value, ownership moves:

```sfn
let data = Vec.new();
let moved = data;        // ownership moves to `moved`
// print.info(data);     // ERROR: use after move
```

## Borrowing

To access a value without taking ownership, use borrows:

```sfn
fn print_length(items: &Vec<Int>) ![io] {
    print.info("Length: {{items.len()}}");
    // items is borrowed — caller still owns it
}

fn add_item(items: &mut Vec<Int>) {
    items.push(42);
    // exclusive mutable access
}
```

### Borrow Rules

- You can have **many** `&T` (shared/read-only) borrows at once
- You can have **one** `&mut T` (exclusive/mutable) borrow at a time
- You **cannot** have `&T` and `&mut T` at the same time

## Affine and Linear Types

For resources that need stricter guarantees:

```sfn
// Affine<T>: may be dropped, but cannot be duplicated
let handle: Affine<FileHandle> = open("data.txt");
// let copy = handle;  // ERROR: Affine values can't be copied

// Linear<T>: must be consumed exactly once
let token: Linear<AuthToken> = mint_token();
// Dropping token without consuming it is a compile error
consume_token(token);  // OK: consumed
```

## Next Steps

- [Error Handling](/docs/learn/error-handling) — Try/catch and result types
- [Language Spec: Ownership](/docs/reference/spec) — Formal ownership rules
