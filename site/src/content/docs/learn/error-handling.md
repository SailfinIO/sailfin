---
title: Error Handling
description: Try/catch, result types, and error propagation in Sailfin.
section: learn
order: 6
---

## Try / Catch

```sfn
fn load_config(path: String) -> Config ![io] {
    try {
        let content = fs.read(path);
        return Config.parse(content);
    } catch (e: IoError) {
        print.error("Cannot read config: {{e.message}}");
        throw e;
    } finally {
        print.info("Config loading attempted");
    }
}
```

## Result Types

For functions that return errors as values:

```sfn
enum Result<T, E> {
    Ok(T),
    Err(E),
}

fn parse_int(s: String) -> Result<Int, String> {
    // ...
}

fn main() ![io] {
    match parse_int("42") {
        Ok(n) => print.info("Parsed: {{n}}"),
        Err(msg) => print.error("Failed: {{msg}}"),
    }
}
```

## Next Steps

- [Concurrency](/docs/learn/concurrency) — Routines, channels, and parallelism
- [Testing](/docs/learn/testing) — Writing and running tests
