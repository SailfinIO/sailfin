---
title: Tour of Sailfin
description: A guided introduction to Sailfin's key features.
section: getting-started
order: 4
---

This tour walks through Sailfin's distinctive features. By the end, you'll understand what makes Sailfin different and how its features work together.

## Variables and Types

Sailfin uses `let` for immutable bindings and `let mut` for mutable ones:

```sfn
let name: String = "Sailfin";
let mut counter: Int = 0;
counter = counter + 1;
```

Type inference works for most declarations:

```sfn
let x = 42;           // Int
let pi = 3.14;        // Float
let active = true;    // Bool
```

## Functions and Effects

Every function declares what it can do:

```sfn
fn greet(name: String) ![io] {
    print.info("Hello, {{name}}!");
}

fn add(a: Int, b: Int) -> Int {
    return a + b;  // No effects needed — pure function
}
```

The `![io]` annotation is an **effect type**. The compiler tracks effects transitively — if `foo` calls `greet`, then `foo` must also declare `![io]`.

## Structs and Interfaces

```sfn
struct User {
    name: String,
    email: String,
    age: Int,
}

interface Printable {
    fn display(&self) -> String;
}

impl Printable for User {
    fn display(&self) -> String {
        return "{{self.name}} <{{self.email}}>";
    }
}
```

## Enums and Pattern Matching

```sfn
enum Result<T, E> {
    Ok(T),
    Err(E),
}

fn handle(result: Result<Int, String>) ![io] {
    match result {
        Ok(value) => print.info("Got: {{value}}"),
        Err(msg) => print.error("Failed: {{msg}}"),
    }
}
```

## The Effect System

Effects are Sailfin's capability system. The six canonical effects are:

| Effect | Grants access to |
|--------|-----------------|
| `io` | Filesystem, console, logging |
| `net` | HTTP, WebSocket, network |
| `model` | AI model invocation |
| `gpu` | GPU/accelerator access |
| `rand` | Random number generation |
| `clock` | Timers, sleep, wall-clock time |

```sfn
fn fetch_and_log(url: String) -> String ![io, net] {
    let response = http.get(url);
    print.info("Fetched {{response.status}}");
    return response.body;
}
```

## Ownership and Borrowing

Sailfin uses move-by-default semantics:

```sfn
let data = Vec.new();
let moved = data;       // data is moved — can't use data anymore
// print.info(data);    // ERROR: use after move

fn read_only(items: &Vec<Int>) {      // shared borrow
    print.info("Length: {{items.len()}}");
}

fn mutate(items: &mut Vec<Int>) {     // exclusive borrow
    items.push(42);
}
```

## AI Constructs

Models, prompts, and pipelines are first-class:

```sfn
model gpt4o = openai:"gpt-4o";

fn summarize(text: String) -> String ![model] {
    let result = prompt gpt4o ![model] {
        system "You are a concise summarizer."
        user "Summarize: {{text}}"
    };
    return result;
}
```

## Error Handling

```sfn
fn parse_config(path: String) -> Config ![io] {
    try {
        let content = fs.read(path);
        return Config.parse(content);
    } catch (e: IoError) {
        print.error("Failed to read config: {{e.message}}");
        throw e;
    }
}
```

## Testing

Tests are built into the language:

```sfn
test "addition works" {
    let result = add(2, 3);
    assert result == 5;
}

test "greet produces output" ![io] {
    greet("World");  // Effects required in tests too
}
```

## What's Next?

- [Language Basics](/docs/learn/basics) — Deep dive into syntax and semantics
- [The Effect System](/docs/learn/effects) — Understanding capability-based security
- [Language Spec](/docs/reference/spec) — Complete reference
