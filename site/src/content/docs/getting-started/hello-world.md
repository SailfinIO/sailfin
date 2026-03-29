---
title: "Hello, World!"
description: Write and run your first Sailfin program.
section: getting-started
order: 2
---

## Your First Program

Create a file called `hello.sfn`:

```sfn
fn main() ![io] {
    print.info("Hello, World!");
}
```

Notice the `![io]` effect annotation — this tells the compiler that `main` performs IO operations. Sailfin requires you to declare capabilities explicitly. If you removed `![io]`, the compiler would reject the `print.info` call.

## Run It

```bash
sfn run hello.sfn
```

Output:

```
Hello, World!
```

## What Just Happened?

1. The `sfn` CLI invoked the Sailfin compiler
2. The compiler parsed `hello.sfn`, checked types and effects, emitted `.sfn-asm` IR, and lowered it to LLVM IR
3. LLVM compiled the IR to a native binary
4. The binary executed and printed the message

## Next Steps

- [Tour of Sailfin](/docs/getting-started/tour) — A deeper walkthrough of language features
- [Language Basics](/docs/learn/basics) — Variables, types, and control flow
