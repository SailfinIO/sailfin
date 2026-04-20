---
title: Ownership & Borrowing
description: How Sailfin manages memory and resources through move semantics, borrowing rules, and linear types — without a garbage collector.
section: learn
sidebar:
  order: 5
---

Every running program needs to manage memory: allocate it when you need a value, release it when you're done. Get this wrong and you get dangling pointers, double-frees, or data races. Get it right and programs are fast, safe, and predictable.

Languages have tackled this problem in different ways. Garbage-collected languages like Go and Python track which values are still reachable and periodically reclaim the rest — simple to program but with runtime overhead and unpredictable pauses. C and C++ hand control entirely to the programmer — maximum efficiency but a rich source of security vulnerabilities. Rust pioneered a third path: enforce memory safety at compile time through ownership rules, with zero runtime cost.

Sailfin takes the same third path. The ownership system is central to the language, not bolted on. Once you understand it, code that seemed strange starts to read naturally, and a class of bugs you'd otherwise spend hours debugging simply doesn't compile.

> **Implementation status:** The ownership syntax in this guide — `&T`, `&mut T`, `borrow(...)`, `Affine<T>`, `Linear<T>` — is parsed by the compiler today and flows through to the IR, but **no enforcement runs yet**. Use-after-move, exclusivity, and must-consume violations all compile without error. Full enforcement is deferred to post-1.0; see the [roadmap](/roadmap). Treat the rules in this guide as the design intent, not as behavior you can rely on today.

---

## Why ownership?

Before getting into mechanics, consider a concrete problem. In C:

```c
char *greet(int user_id) {
    char buf[64];
    snprintf(buf, 64, "Hello, user %d", user_id);
    return buf;  // BUG: returning pointer to stack memory
}
```

The caller receives a pointer to memory that was already freed when `greet` returned. This is a dangling pointer. Dereferencing it is undefined behavior — it might work, it might crash, it might silently corrupt other data.

Or consider double-free: two owners of the same allocation each call `free`. The heap is now in an undefined state. Exploiting double-frees is a classic attack vector.

Data races are the concurrent equivalent: two threads read and write the same memory without coordination. The outcome is non-deterministic and impossible to test reliably.

Garbage collectors solve some of these (no dangling pointers, no double-free) by ensuring a value isn't freed until no references to it remain. But a GC can't solve data races, and it introduces runtime pauses and memory overhead that matter in latency-sensitive or resource-constrained contexts.

Sailfin's ownership model solves all three at compile time:

- **Dangling pointers**: borrows cannot outlive the value they reference.
- **Double-free**: each value has exactly one owner; when that owner goes out of scope, the value is freed — once.
- **Data races**: at any moment you have either many read-only borrows or exactly one mutable borrow, never both.

The key insight: the compiler tracks who owns what. It knows when ownership transfers, when a borrow is active, and when a value is freed. If you break the rules, it's a compile error, not a runtime crash.

---

## Move semantics

In Sailfin, values are **moved** by default when you assign them to a new binding or pass them to a function. Moving transfers ownership: the original binding is no longer valid.

```sfn
struct Config {
    host: string;
    port: number;
}

fn main() ![io] {
    let config = Config { host: "localhost", port: 8080 };
    let server_config = config;   // ownership moves to server_config

    // print(config.host);        // would be a use-after-move error (once enforced)
    print(server_config.host);    // OK: server_config is the owner
}
```

After `let server_config = config`, `config` is gone. The compiler can determine this statically — no runtime bookkeeping needed.

The same applies to function calls. Passing a value to a function by value moves ownership into that function:

```sfn
fn start_server(cfg: Config) ![io] {
    print("Starting server on {{cfg.host}}:{{cfg.port}}");
    // cfg is freed when this function returns
}

fn main() ![io] {
    let config = Config { host: "localhost", port: 8080 };
    start_server(config);         // config moves into start_server

    // start_server(config);      // would be: config was already moved (once enforced)
}
```

If you want to call `start_server` a second time with the same data, you either need a separate value, or you need to use borrowing (covered below).

### Copy types vs. move types

Not all types move. Primitive types — `number`, `boolean`, `string` — are **copied** on assignment. Copy is cheap and semantically clean for small, self-contained values:

```sfn
fn main() ![io] {
    let x = 42;
    let y = x;        // x is copied, not moved
    print("x = {{x}}, y = {{y}}");   // both valid
}
```

Composite types — structs, enums with data, collections — move by default. They may contain heap-allocated buffers or other resources, so implicit copying would be expensive and surprising.

If you need two separate owners of the same composite data, you clone it explicitly:

```sfn
let original = Config { host: "api.example.com", port: 443 };
let replica = original.clone();   // explicit, intentional copy

start_server(original);           // original moved
start_server(replica);            // replica is an independent copy
```

The explicitness of `.clone()` makes expensive copies visible in code review and performance profiling.

---

## Borrowing overview

Ownership is powerful but strict. If every function that needs to read a config took ownership of it, you'd clone constantly. Borrowing gives you a way to let a function access a value without taking ownership.

A borrow is a temporary reference to a value. The owner keeps ownership; the borrower gets access for a limited time. There are two kinds:

- `&T` — a **shared borrow**: read-only, and multiple can coexist.
- `&mut T` — an **exclusive borrow**: read-write, and only one exists at a time.

Think of it like a library book. You can have many readers look at the same reference copy at once (`&T`). Or one person can check it out to annotate it (`&mut T`) — but while they have it, nobody else can read or write it.

---

## Shared borrows: `&T`

A shared borrow lets you read a value without taking ownership. The original owner retains the value; the borrow is just a window into it.

```sfn
fn print_config(cfg: &Config) ![io] {
    print("host: {{cfg.host}}, port: {{cfg.port}}");
}

fn main() ![io] {
    let config = Config { host: "localhost", port: 8080 };

    print_config(&config);    // borrow config for the call
    print_config(&config);    // borrow again — still valid, owner unchanged
    print_config(&config);    // as many times as needed

    // config is still owned here; it's freed when main returns
}
```

Passing `&config` creates a shared borrow. `print_config` receives `cfg: &Config` — a reference, not an owned value. When `print_config` returns, the borrow ends. `config` is unaffected.

Multiple shared borrows of the same value can be active at the same time:

```sfn
fn log_host(cfg: &Config) ![io] { print(cfg.host); }
fn log_port(cfg: &Config) ![io] { print("{{cfg.port}}"); }

fn main() ![io] {
    let config = Config { host: "localhost", port: 8080 };
    let a: &Config = &config;
    let b: &Config = &config;    // two shared borrows — fine

    log_host(a);
    log_port(b);
}
```

Shared borrows are read-only. Attempting to mutate through a `&T` reference is a type error.

---

## Mutable borrows: `&mut T`

A mutable borrow lets you modify a value temporarily. The constraint is strict: only one mutable borrow may exist at a time, and no shared borrows may be active simultaneously.

```sfn
struct Counter {
    value: number;
}

fn increment(counter: &mut Counter) {
    counter.value = counter.value + 1;
}

fn main() ![io] {
    let mut counter = Counter { value: 0 };

    increment(&mut counter);
    increment(&mut counter);
    increment(&mut counter);

    print("Counter: {{counter.value}}");   // "Counter: 3"
}
```

Notice `let mut counter` — the binding itself must be declared mutable before you can create a mutable borrow of it. This makes mutation visible at the declaration site, not just at the use site.

### Exclusivity

You cannot hold a `&T` and a `&mut T` to the same value at the same time. The mutable borrow needs exclusive access:

```sfn
fn main() ![io] {
    let mut data = Counter { value: 0 };

    let read_ref: &Counter = &data;
    // let write_ref: &mut Counter = &mut data;  // would be an error:
    //   cannot borrow `data` as mutable while it is already borrowed as immutable

    print("{{read_ref.value}}");   // read_ref's lifetime ends here
    let write_ref: &mut Counter = &mut data;    // now valid
    write_ref.value = 10;
}
```

The comment above shows what the compiler will reject. The rule: a `&mut T` borrow requires that no other borrows — shared or exclusive — are active at the same time.

---

## The borrow rules

Stated precisely:

1. At any given point in the code, for any value, you may have **either**:
   - Any number of shared borrows `&T`, **or**
   - Exactly one exclusive borrow `&mut T`
   — never both simultaneously.

2. A borrow cannot outlive the value it references. A reference to a stack-allocated value cannot escape the scope that value lives in.

3. You cannot move a value while it is borrowed. Moving ends the owner; the outstanding reference would dangle.

These three rules together eliminate dangling pointers, data races, and use-after-free.

> **Current enforcement:** The compiler parses `&T` and `&mut T` syntax and threads borrow metadata through the IR, but full exclusivity checking is deferred to post-1.0. Violations compile without error today. See the [roadmap](/roadmap) for when enforcement lands.

The examples throughout this guide show what the rules will require. Building correct habits now means your code will pass the strict checker without changes.

---

## `Affine<T>`: may be dropped, not copied

Not every value fits neatly into the primitive/composite divide. Some values represent real-world resources — file handles, network connections, database transactions — where duplication would be nonsensical or dangerous.

`Affine<T>` wraps a type to say: *this value can be dropped (it has a destructor), but it cannot be duplicated*. An affine value is used at most once.

```sfn
struct FileHandle {
    path: string;
    fd: number;
}

fn open_file(path: string) -> Affine<FileHandle> ![io] {
    // Opens the file, returns an affine handle
    return FileHandle { path: path, fd: syscall_open(path) };
}

fn read_contents(handle: Affine<FileHandle>) -> string ![io] {
    // Consumes the handle; file is closed when handle is dropped
    return syscall_read(handle.fd);
}

fn main() ![io] {
    let handle = open_file("data.csv");
    let contents = read_contents(handle);   // handle is moved (consumed)

    // let contents2 = read_contents(handle);  // would be: handle was already moved (once enforced)

    print(contents);
}
```

Typical uses for `Affine<T>`:

- **File handles**: opening a file twice to the same path with the same mode can cause corruption. Each `open` call returns a fresh affine handle.
- **Database connections**: a connection represents real server-side state. Copying would imply two clients on one server-side connection.
- **Mutex locks**: a "lock guard" prevents double-locking by being affine — you can drop it, but you can't clone it.
- **Cryptographic contexts**: some cipher states are position-dependent; duplicating them could produce duplicate keystreams.

`Affine<T>` is also the right choice when you want the compiler to enforce that a destructor runs — i.e., you want a guarantee that cleanup code fires before the value is abandoned.

> **Current enforcement:** `Affine<T>` syntax is accepted and the compiler records annotations. The rule "cannot be copied" is **not yet enforced at compile time**. See the [roadmap](/roadmap) for enforcement sequencing. Treat your code as if the restriction is active.

---

## `Linear<T>`: must be consumed exactly once

`Linear<T>` is stricter than `Affine<T>`. A linear value **must** be consumed — you cannot drop it silently. If a linear value goes out of scope without being explicitly passed to a consuming function, it is a compile error.

This is useful when forgetting to act on something is a bug, not just a missed optimization.

```sfn
struct AuthToken {
    value: string;
    expiry: number;
}

fn mint_token(user_id: string) -> Linear<AuthToken> ![io, net] {
    // Creates a one-time auth token; must be used or explicitly invalidated
    let token_value = generate_secure_random_token();
    return AuthToken { value: token_value, expiry: now() + 3600 };
}

fn submit_request(token: Linear<AuthToken>, payload: string) -> Response ![net] {
    // Consuming the token here is intentional: tokens are single-use
    let auth_header = token.value;
    return http.post_with_auth(auth_header, payload);
}

fn invalidate(token: Linear<AuthToken>) ![net] {
    // Explicit disposal path: revoke the token server-side
    http.post("/auth/revoke", token.value);
}

fn main() ![io, net] {
    let token = mint_token("user-42");

    // Exactly one of these paths must be taken:
    if should_submit() {
        submit_request(token, "{ \"action\": \"purchase\" }");
    } else {
        invalidate(token);   // must consume token even on the no-submit path
    }

    // Falling out of scope without consuming token would be a compile error (once enforced)
}
```

The must-consume rule catches an entire category of logic errors:

- **Authentication tokens**: a minted token that's never sent wastes server resources; a token that's created but neither used nor revoked could be replayed.
- **Cryptographic nonces**: nonces must be used exactly once; dropping one without sending means the encryption step was skipped.
- **Transactions**: beginning a transaction and forgetting to commit or roll it back leaves the database in an inconsistent state.
- **Acknowledgements**: in message-queue systems, a received message must be explicitly acknowledged or rejected; silently dropping it causes it to redeliver.

```sfn
// Another example: database transaction
fn update_balance(conn: &mut DbConn, user_id: number, delta: number) ![io] {
    let txn: Linear<Transaction> = conn.begin_transaction();

    let balance = conn.query_balance(user_id);
    if balance + delta < 0.0 {
        txn.rollback();      // consume txn on the error path
        throw "Insufficient funds";
    }

    conn.execute_update(user_id, balance + delta);
    txn.commit();            // consume txn on the success path
    // Once must-consume is enforced, failing to call either rollback or commit is a compile error
}
```

> **Current enforcement:** `Linear<T>` syntax is accepted and the compiler records annotations. The "must be consumed" rule is **not yet enforced at compile time**. See the [roadmap](/roadmap). Write consume-patterns now so your code is correct by construction.

---

## Ownership in practice

### Returning ownership from functions

A function can create a value and return ownership to the caller:

```sfn
fn make_greeting(name: string) -> string {
    return "Hello, {{name}}!";
}

fn main() ![io] {
    let msg = make_greeting("Sailfin");   // caller receives ownership
    print(msg);
}
```

There is no copy here. The `String` is constructed inside `make_greeting` and its ownership moves to the caller via the return value. This is efficient: the compiler can often eliminate the move entirely (return-value optimization).

### When to clone

Cloning makes sense when:

- You genuinely need two independent copies (e.g., original vs. preview).
- A library function takes ownership and you still need the data.
- You're prototyping and want to skip the borrow ergonomics temporarily.

Cloning can be expensive — it allocates. Prefer borrowing when the function only needs to read:

```sfn
// Don't do this — takes ownership when a borrow is sufficient
fn display_name(user: User) ![io] {
    print(user.name);
}

// Do this instead — borrows only what it needs
fn display_name(user: &User) ![io] {
    print(user.name);
}
```

### Struct fields and ownership

When you access a field of a struct you own, you get a reference to that field, not a copy. Moving a field out of a struct is only valid if you do not use the struct afterward (or if you replace the field before the struct is used again):

```sfn
struct Pipeline {
    config: Config;
    name: string;
}

fn run(pipeline: Pipeline) ![io] {
    let cfg = pipeline.config;    // moves config out of pipeline
    // Using pipeline.name here would require that only config was moved, not
    // the whole pipeline. Partial moves are tracked by the compiler.
    start_server(cfg);
}
```

For structs that are frequently broken apart this way, consider having the consuming function take the whole struct, or restructure ownership so the fields stay together.

---

## Common pitfalls

### Use after move

The most common ownership error. After a move, the original binding is gone:

```sfn
fn main() ![io] {
    let data = Config { host: "localhost", port: 8080 };
    process(data);       // data moved into process
    log(data);           // ERROR: data was moved

    // Fix 1: borrow instead of move
    process_ref(&data);
    log_ref(&data);

    // Fix 2: clone if you need two independent values
    process(data.clone());
    log(data);
}
```

### Accidentally taking ownership

A function signature with `param: T` takes ownership. If you meant to inspect without owning, use `param: &T`:

```sfn
// This takes ownership — caller loses the config
fn validate(cfg: Config) -> boolean { ... }

// This borrows — caller keeps the config
fn validate(cfg: &Config) -> boolean { ... }
```

When in doubt, start with borrows. You can always change to owned if you find you need to store or transform the value.

### Mutable borrow while immutable borrow is live

The borrow checker's most common friction point. If you hold a `&T` and then try to get a `&mut T`, the compiler will (once exclusivity enforcement lands) reject it:

```sfn
fn main() ![io] {
    let mut items = [1, 2, 3, 4, 5];
    let first = &items[0];          // shared borrow of items
    items.push(6);                  // would be a mutable borrow of items
                                    // ERROR: cannot mutate while borrowed
    print("first: {{first}}");      // first is still in scope here
}
```

The fix is usually to end the shared borrow before taking the mutable one:

```sfn
fn main() ![io] {
    let mut items = [1, 2, 3, 4, 5];
    let first_val = items[0];       // copy the value out (number is Copy)
    items.push(6);                  // mutable borrow; no conflict
    print("first: {{first_val}}");
}
```

### Borrowing across loops

Long-lived borrows inside loops can conflict with mutations in the same loop:

```sfn
fn main() ![io] {
    let mut cache: Cache = Cache.new();
    for item in items {
        let existing: &Entry = cache.get(item.key);   // shared borrow
        if should_update(existing) {
            cache.set(item.key, new_value());         // mutable — conflicts with existing
        }
    }
}

// Fix: end the shared borrow before mutating
fn main() ![io] {
    let mut cache: Cache = Cache.new();
    for item in items {
        let needs_update = should_update(cache.get(item.key));
        if needs_update {
            cache.set(item.key, new_value());
        }
    }
}
```

---

## Ownership and effects

The effect system and the ownership system compose naturally. Borrowing carries implicit effect semantics:

- Reading a value through `&T` implies a `read` capability on that value.
- Mutating through `&mut T` implies a `mut` capability.

The `examples/basics/borrowing.sfn` example shows this in action, with functions annotated `![read]` and `![mut]`:

```sfn
fn read_counter(counter: &Counter) ![read] -> number {
    return counter.value;
}

fn increment_counter(counter: &mut Counter) ![mut] {
    counter.value = counter.value + 1;
}
```

In the current compiler, `read` and `mut` are accepted as effect annotations. Future releases will integrate borrow effects more tightly with the capability system — for example, requiring that a function that takes `&mut T` to a shared resource declares the appropriate capability, or that `PII<T>` fields cannot be read without a `redact` or `policy` effect.

The intersection of ownership and effects is where Sailfin's safety story comes together: not only is memory safe, but *what you can do* with a value is statically bounded by the declared capabilities of the function holding it.

---

## Summary

| Concept | Syntax | Meaning | Enforced today? |
|---------|--------|---------|----------------|
| Move | `let b = a` | Ownership transfers; `a` is no longer valid | Syntax only |
| Shared borrow | `&T` | Read-only reference; many can coexist | Syntax only |
| Exclusive borrow | `&mut T` | Read-write reference; must be sole borrow | Syntax only |
| Affine type | `Affine<T>` | Can be dropped, cannot be duplicated | Syntax only |
| Linear type | `Linear<T>` | Must be consumed exactly once | Syntax only |

Full ownership enforcement — move tracking, exclusivity checking, must-consume verification — is deferred to post-1.0. The syntax is stable and recorded in the IR; code you write today using these annotations will work correctly once enforcement lands. See the [roadmap](/roadmap) for sequencing.

---

## Next steps

- [Error Handling](/docs/learn/error-handling) — How Sailfin handles failures with `try/catch` and result types
- [The Effect System](/docs/learn/effects) — Capability annotations and transitive enforcement
- [Language Spec: Ownership](/docs/reference/spec) — Formal ownership semantics
