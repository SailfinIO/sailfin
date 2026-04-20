---
title: "Hello, World!"
description: Write and run your first Sailfin program, step by step.
section: getting-started
sidebar:
  order: 3
---

## Your First Program

Create a file called `hello.sfn` with the following contents:

```sfn
fn main() ![io] {
    print("Hello, World!");
}
```

Then run it:

```bash
sfn run hello.sfn
```

Output:

```
Hello, World!
```

That is the complete program. Let's walk through every token so nothing is
mysterious before you move on.

### Breaking down the syntax

```
fn main() ![io] {
```

- `fn` — declares a function.
- `main` — the entry point. Sailfin looks for a function named `main` when you
  run a file.
- `()` — the parameter list. `main` takes no parameters.
- `![io]` — an **effect annotation**. It declares that this function performs IO
  operations. `io` covers anything that writes to stdout, stderr, or the
  filesystem. The compiler uses this information to enforce capability boundaries.
- `{` — opens the function body.

```
    print("Hello, World!");
```

- `print` — the built-in output function. It writes to stdout with no prefix.
- `"Hello, World!"` — a string literal.
- `;` — statement terminator.

> **The `![io]` annotation is not optional.** The compiler will reject any call
> to `print()` in a function that does not declare the `io` effect. This is by
> design: Sailfin requires you to be explicit about what a function does to the
> world around it.

---

## What Happens When You Run It

When you run `sfn run hello.sfn`, the toolchain does the following:

1. **Lexing** — the source file is tokenized.
2. **Parsing** — tokens are assembled into an abstract syntax tree (AST).
3. **Type checking** — types are inferred and validated.
4. **Effect checking** — the compiler verifies that every effectful call is
   covered by a declared effect. A call to `print()` requires `io`.
5. **Native emission** — the AST is lowered to `.sfn-asm` intermediate
   representation.
6. **LLVM lowering** — `.sfn-asm` is lowered to LLVM IR, compiled to a native
   binary, and executed.

This all happens in one command. You do not manage build artifacts for single-file
programs.

---

## What Happens If You Forget `![io]`

Omit the effect annotation:

```sfn
fn main() {
    print("Hello, World!");
}
```

Run it:

```bash
sfn run hello.sfn
```

The compiler emits a diagnostic and exits without running the program:

```
error[E0210]: call to `print` requires effect `io`, but `main` does not declare it
  --> hello.sfn:2:5
   |
 1 | fn main() {
   |           ^ effect `io` missing here — add `![io]` to the function signature
 2 |     print("Hello, World!");
   |     ^^^^^^^^^^^^^^^^^^^^^^ `print` is an `io` operation
   |
   = help: change `fn main()` to `fn main() ![io]`
```

The fix is exactly what the diagnostic says: add `![io]` to the function
signature. The compiler reports the source span, identifies the missing effect,
and provides a fix-it hint. This pattern is consistent throughout the language —
every missing effect produces a diagnostic of this form.

---

## A More Complete Program

The hello-world program shows the minimum viable structure. Here is a slightly
more interesting example that introduces variables, string interpolation, and a
function call:

```sfn
fn greet(name: string) -> string {
    return "Hello, {{name}}!";
}

fn main() ![io] {
    let name = "World";
    print(greet(name));
}
```

Run it:

```bash
sfn run hello.sfn
```

Output:

```
Hello, World!
```

### What is new here

- `fn greet(name: string) -> string` — a function that takes a `string` parameter
  and returns a `string`. Note that `greet` does not declare `![io]` because it
  does not perform any IO itself — it just produces a value.
- `"Hello, {{name}}!"` — **string interpolation**. Any expression inside
  `{{ }}` is evaluated and inserted into the string at that position. This works
  with variables, function calls, and field accesses.
- `let name = "World"` — declares an immutable local variable. The type is
  inferred as `string`.
- `print(greet(name))` — calls `greet` with `name`, then passes the result to
  `print`. The `io` effect is declared on `main`, which is the function actually
  calling `print`, so the effect check passes.

> **Effect transitivity:** `greet` does not need `![io]` because it never calls
> `print`. Only the function that directly invokes an effectful operation — or
> calls another function that does — needs to declare the effect. The compiler
> traces the call graph and enforces this.

---

## Adding a Struct

Sailfin structs group related data. Fields are declared with `name: Type;`:

```sfn
struct Person {
    name: string;
    age: number;
}

fn greet(person: Person) -> string {
    return "Hello, {{person.name}}! You are {{person.age}} years old.";
}

fn main() ![io] {
    let alice = Person { name: "Alice", age: 30 };
    let bob   = Person { name: "Bob",   age: 25 };

    print(greet(alice));
    print(greet(bob));
}
```

Output:

```
Hello, Alice! You are 30 years old.
Hello, Bob! You are 25 years old.
```

### What is new here

- `struct Person { ... }` — declares a struct type named `Person`.
- `name: string;` — a field named `name` of type `string`. Field declarations
  use `name: Type;` and end with a semicolon.
- `Person { name: "Alice", age: 30 }` — struct instantiation. Fields are assigned
  by name. Order does not matter.
- `person.name` — field access inside a string interpolation expression.

---

## Your First Test

Sailfin has first-class test support. Add a `test` block to the same file:

```sfn
struct Person {
    name: string;
    age: number;
}

fn greet(person: Person) -> string {
    return "Hello, {{person.name}}! You are {{person.age}} years old.";
}

fn main() ![io] {
    let alice = Person { name: "Alice", age: 30 };
    print(greet(alice));
}

test "greet produces correct greeting" {
    let p = Person { name: "Alice", age: 30 };
    assert greet(p) == "Hello, Alice! You are 30 years old.";
}

test "greet handles different names" {
    let p = Person { name: "Bob", age: 25 };
    assert greet(p) == "Hello, Bob! You are 25 years old.";
}
```

Run the tests:

```bash
sfn test hello.sfn
```

Output:

```
running 2 tests in hello.sfn

  PASS  greet produces correct greeting
  PASS  greet handles different names

2 passed, 0 failed
```

### What is new here

- `test "name" { ... }` — a test block. The string is the test name displayed in
  output. Test blocks live in the same file as the code they test, or in a
  separate `*_test.sfn` file.
- `assert expression;` — fails the test if the expression evaluates to `false`.
  The compiler reports the failing assertion with a source span.
- `sfn test hello.sfn` — runs all test blocks in the specified file. Run
  `sfn test` (no arguments) to run all `*_test.sfn` files in the project.

> **Note:** Test blocks do not need an effect annotation even if they call
> effectful functions through the code under test. Effect requirements are on
> function declarations, not on test blocks.

---

## Stderr Output

Use `print.err()` to write to stderr instead of stdout:

```sfn
fn main() ![io] {
    print("This goes to stdout.");
    print.err("This goes to stderr.");
}
```

Both `print()` and `print.err()` require the `io` effect. There is no separate
`io` vs `io.err` distinction — both are covered by `![io]`.

---

## Organizing into a Project

Once your program grows beyond a single file, organize it as a capsule (Sailfin's
package format). Create a `capsule.toml` in the root of your project:

```toml
[capsule]
name    = "my-app"
version = "0.1.0"
entry   = "src/main.sfn"
```

A typical project layout:

```
my-app/
  capsule.toml
  src/
    main.sfn
    greet.sfn
  tests/
    greet_test.sfn
```

With a `capsule.toml` present, running `sfn run` from the project root uses the
`entry` field to find the entry point, and `sfn test` discovers all `*_test.sfn`
files recursively.

You can import from other source files within the same capsule using import
statements at the top of a file:

```sfn
import { greet } from "./greet";

fn main() ![io] {
    print(greet("World"));
}
```

---

## Next Steps

- [Tour of Sailfin](/docs/getting-started/tour) — A deeper walkthrough covering control flow, enums, pattern matching, and more
- [Language Basics](/docs/learn/basics) — Variables, types, functions, and control flow in depth
- [Effect System](/docs/learn/effects) — How effect annotations work and why they matter
- [Editor Setup](/docs/getting-started/editor-setup) — Get syntax highlighting and snippets in your editor
