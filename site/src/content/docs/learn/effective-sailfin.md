---
title: Effective Sailfin
description: Best practices, idioms, and patterns for writing idiomatic Sailfin.
section: learn
order: 10
---

This guide covers patterns and practices for writing clear, safe, and performant Sailfin code. It's similar in spirit to [Effective Go](https://go.dev/doc/effective_go).

## Naming Conventions

- **Types, structs, enums, interfaces**: `CamelCase` — `UserProfile`, `HttpClient`
- **Functions, variables, fields**: `snake_case` — `fetch_data`, `user_count`
- **Constants**: `UPPER_SNAKE_CASE` — `MAX_RETRIES`, `DEFAULT_TIMEOUT`
- **Model bindings**: `CamelCase` — `Gpt4o`, `ClaudeSonnet`
- **File names**: `snake_case.sfn` — `http_client.sfn`, `effect_checker.sfn`

## Minimize Effect Scope

Declare the narrowest set of effects possible:

```sfn
// Prefer: separate pure computation from effectful IO
fn compute(data: Array<Int>) -> Int {
    return data.reduce(|a, b| a + b);
}

fn process_and_log(data: Array<Int>) ![io] {
    let result = compute(data);  // pure — no effects
    print.info("Result: {{result}}");
}
```

## Use Borrows When Possible

Prefer borrowing over ownership transfer:

```sfn
// Good: borrows the data, caller retains ownership
fn analyze(data: &Array<Record>) -> Report {
    // ...
}

// Avoid: takes ownership unnecessarily
fn analyze_owned(data: Array<Record>) -> Report {
    // ...
}
```

## Organize with Modules

Use `mod.sfn` files to define public APIs:

```
http_client/
├── mod.sfn          # Re-exports public API
├── client.sfn       # Implementation
├── request.sfn      # Request types
└── response.sfn     # Response types
```

## Error Handling

Prefer `Result<T, E>` for expected failures, `try/catch` for exceptional conditions:

```sfn
// Expected failure: return Result
fn parse_config(s: String) -> Result<Config, ParseError> { ... }

// Exceptional: use try/catch
fn main() ![io] {
    try {
        let config = parse_config(input).unwrap();
        run(config);
    } catch (e) {
        print.error("Fatal: {{e.message}}");
    }
}
```

## Next Steps

This guide will expand as the language matures toward 1.0. For now, see:

- [Style Guide](/docs/contributing/style-guide) — Repository and code conventions
- [Language Spec](/docs/reference/spec) — Formal reference
