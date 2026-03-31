---
title: Types & Structs
description: A comprehensive guide to Sailfin's type system — structs, enums, interfaces, generics, type aliases, optionals, union types, wrapper types, pattern matching, and type inference.
section: learn
order: 3
---

Sailfin has a rich, statically-checked type system designed to make incorrect programs hard to write. This guide covers everything from the primitive types you saw in [Language Basics](/docs/learn/basics) through algebraic data types, interfaces, generics, and the ownership-aware wrapper types that power Sailfin's safety guarantees.

## Primitive Types

These are the building blocks. You have seen them already; the table below adds context for how they sit in the type system.

| Type | Width | Literal examples | Notes |
|------|-------|-----------------|-------|
| `Int` | 64-bit signed | `0`, `42`, `-7` | Default numeric type for integers |
| `Float` | 64-bit IEEE 754 | `3.14`, `-0.5`, `1.0e9` | Default for floating-point |
| `Bool` | 1-bit | `true`, `false` | Only boolean values; no implicit coercion from Int |
| `String` | UTF-8, heap | `"hello"` | Immutable; supports `{{ }}` interpolation |
| `Byte` | 8-bit unsigned | `0xFF`, `127` | Raw byte; common in I/O and binary protocols |
| `Void` | — | — | Return type for functions with no return value |

```sfn
let count: Int = 100;
let ratio: Float = 0.618;
let active: Bool = true;
let label: String = "pending";
```

Numeric literals are untyped until they are bound to a variable or parameter. The compiler infers `Int` for integers and `Float` for decimals unless the context demands otherwise.

---

## Structs

Structs group related fields into a named product type. They are the primary way to define domain objects in Sailfin.

### Declaring a struct

Fields use the `name -> Type` syntax. All fields are immutable by default; prefix a field with `mut` to allow mutation after construction.

```sfn
struct Point {
    x -> Float;
    y -> Float;
}

struct Rectangle {
    mut width -> Float;
    mut height -> Float;
}
```

You can also write field annotations as `name: Type` in struct literals and destructuring patterns — but the canonical declaration form uses `->`.

### Struct literals

Construct a struct by supplying every field by name:

```sfn
let origin = Point { x: 0.0, y: 0.0 };
let box = Rectangle { width: 10.0, height: 5.0 };
```

With a type annotation on the binding:

```sfn
let corner -> Point = Point { x: 3.0, y: 4.0 };
```

### Field access

Use dot notation:

```sfn
let p = Point { x: 1.0, y: 2.0 };
print("x = {{p.x}}, y = {{p.y}}");
```

### Mutable fields

Only fields declared `mut` can be reassigned:

```sfn
let mut r = Rectangle { width: 8.0, height: 4.0 };
r.width = 16.0;    // OK — width is `mut`
// r.x = 1.0;      // ERROR — no such field; Point fields are also immutable
```

### Methods

Methods are declared with `fn` inside the struct body. The first parameter `self` receives the receiver (by value). Use `&self` for a read-only borrow and `&mut self` for a mutable borrow:

```sfn
struct Circle {
    radius -> Float;

    fn area(self) -> Float {
        return 3.14159265 * self.radius * self.radius;
    }

    fn circumference(self) -> Float {
        return 2.0 * 3.14159265 * self.radius;
    }

    fn describe(self) -> String {
        return "Circle(r={{self.radius}}, area={{self.area()}})";
    }
}

fn main() ![io] {
    let c = Circle { radius: 5.0 };
    print(c.describe());
    // Circle(r=5, area=78.5398...)
}
```

Static (constructor-style) methods omit `self`:

```sfn
struct Color {
    r -> Int;
    g -> Int;
    b -> Int;

    fn new(r: Int, g: Int, b: Int) -> Color {
        return Color { r: r, g: g, b: b };
    }

    fn black() -> Color {
        return Color { r: 0, g: 0, b: 0 };
    }

    fn to_hex(self) -> String {
        return "#{{self.r}}{{self.g}}{{self.b}}";
    }
}

let red = Color.new(255, 0, 0);
let bg = Color.black();
```

### Nested structs

Structs can contain other structs as fields:

```sfn
struct Address {
    street -> String;
    city -> String;
    country -> String;
}

struct Employee {
    id -> Int;
    name -> String;
    address -> Address;
    mut salary -> Float;
}

let emp = Employee {
    id: 1001,
    name: "Priya Mehta",
    address: Address {
        street: "12 Oak Lane",
        city: "Bangalore",
        country: "India",
    },
    salary: 95000.0,
};

print("City: {{emp.address.city}}");
```

### Implementing interfaces on structs

Use the `implements` keyword in the struct declaration to declare conformance. The compiler verifies that all interface methods are present:

```sfn
interface Printable {
    fn display(self) -> String;
}

struct Invoice implements Printable {
    id -> String;
    amount -> Float;
    paid -> Bool;

    fn display(self) -> String {
        let status = if self.paid { "PAID" } else { "UNPAID" };
        return "Invoice {{self.id}}: ${{self.amount}} [{{status}}]";
    }
}

fn show(item: Printable) ![io] {
    print(item.display());
}

fn main() ![io] {
    let inv = Invoice { id: "INV-007", amount: 1250.0, paid: false };
    show(inv);
    // Invoice INV-007: $1250 [UNPAID]
}
```

---

## Enums / Algebraic Data Types

Enums in Sailfin are full algebraic data types. Variants can be plain unit values, or they can carry named fields.

### Simple (unit) enums

```sfn
enum Direction {
    North,
    South,
    East,
    West,
}

let heading -> Direction = Direction.North;
```

Match on an enum with exhaustive arms:

```sfn
fn describe_direction(d: Direction) -> String {
    match d {
        Direction.North => return "heading north",
        Direction.South => return "heading south",
        Direction.East  => return "heading east",
        Direction.West  => return "heading west",
    }
}
```

### Enums with payload fields

Variants can carry named fields. This is the mechanism for algebraic data types ("tagged unions"):

```sfn
enum Shape {
    Circle { radius -> Float },
    Rectangle { width -> Float, height -> Float },
    Triangle { base -> Float, height -> Float },
}

fn area(shape: Shape) -> Float {
    match shape {
        Shape.Circle { radius } =>
            return 3.14159265 * radius * radius,
        Shape.Rectangle { width, height } =>
            return width * height,
        Shape.Triangle { base, height } =>
            return 0.5 * base * height,
    }
}

fn main() ![io] {
    let s = Shape.Circle { radius: 7.0 };
    print("Area: {{area(s)}}");
}
```

### Option-style enum

Nullable values in Sailfin are modelled either with the `T?` optional syntax (see [Optional Types](#optional-types)) or with an explicit enum. The explicit form makes the absence case part of the type:

```sfn
enum Maybe<T> {
    Some { value -> T },
    None,
}

fn find_user(id: Int, users: Array<User>) -> Maybe<User> {
    for user in users {
        if user.id == id {
            return Maybe.Some { value: user };
        }
    }
    return Maybe.None;
}

fn main() ![io] {
    match find_user(42, users) {
        Maybe.Some { value } => print("Found: {{value.name}}"),
        Maybe.None           => print("User not found"),
    }
}
```

### Result-style enum

Explicit error returns use a two-variant enum:

```sfn
enum Result<T, E> {
    Ok { value -> T },
    Err { error -> E },
}

struct ParseError {
    message -> String;
    position -> Int;
}

fn parse_port(s: String) -> Result<Int, ParseError> {
    let n = Int.parse(s);
    if n == null {
        return Result.Err {
            error: ParseError { message: "not a number", position: 0 },
        };
    }
    if n < 1 || n > 65535 {
        return Result.Err {
            error: ParseError { message: "port out of range", position: 0 },
        };
    }
    return Result.Ok { value: n };
}

fn main() ![io] {
    match parse_port("8080") {
        Result.Ok { value }   => print("Listening on port {{value}}"),
        Result.Err { error }  => print("Bad port: {{error.message}}"),
    }
}
```

---

## Interfaces

Interfaces define a contract: a set of method signatures that a type promises to satisfy. Any struct that implements all the methods conforms to the interface — there is no separate registration step beyond the `implements` clause.

### Declaring an interface

```sfn
interface Serializable {
    fn serialize(self) -> String;
    fn byte_size(self) -> Int;
}
```

### Implementing an interface

```sfn
struct Config implements Serializable {
    host -> String;
    port -> Int;
    debug -> Bool;

    fn serialize(self) -> String {
        return "{{self.host}}:{{self.port}} debug={{self.debug}}";
    }

    fn byte_size(self) -> Int {
        return self.serialize().length;
    }
}
```

### Using interfaces as parameter types

Accepting an interface type enables polymorphism — the caller can pass any conforming struct:

```sfn
interface Driveable {
    fn drive(self) -> String;
    fn fuel_type(self) -> String;
}

struct Car implements Driveable {
    brand -> String;

    fn drive(self) -> String {
        return "Driving {{self.brand}}";
    }

    fn fuel_type(self) -> String {
        return "petrol";
    }
}

struct ElectricBike implements Driveable {
    brand -> String;

    fn drive(self) -> String {
        return "Riding {{self.brand}}";
    }

    fn fuel_type(self) -> String {
        return "electric";
    }
}

fn start_journey(vehicle: Driveable) ![io] {
    print(vehicle.drive());
    print("Fuel: {{vehicle.fuel_type()}}");
}

fn main() ![io] {
    start_journey(Car { brand: "Subaru" });
    start_journey(ElectricBike { brand: "Cowboy" });
}
```

### Multiple interface implementations

A struct can implement any number of interfaces:

```sfn
interface Named {
    fn name(self) -> String;
}

interface Validated {
    fn is_valid(self) -> Bool;
}

interface Auditable {
    fn audit_log(self) -> String;
}

struct User implements Named, Validated, Auditable {
    id -> Int;
    username -> String;
    email -> String;

    fn name(self) -> String {
        return self.username;
    }

    fn is_valid(self) -> Bool {
        return self.username.length > 0 && self.email.length > 0;
    }

    fn audit_log(self) -> String {
        return "User({{self.id}}, {{self.username}})";
    }
}
```

### How Sailfin interfaces compare to Go and Rust

Sailfin interfaces are **explicit**, like Rust traits, rather than **structural**, like Go interfaces. A type must declare `implements SomeInterface` to conform — the compiler will not silently satisfy an interface just because the method signatures happen to match. This makes conformance relationships visible in the source code and enables better error messages.

Unlike Rust traits, Sailfin does not (yet) use `impl Trait for Type` as a separate top-level declaration — conformance is declared inline on the struct. Generic constraints work through interface bounds (see [Generics](#generics) below).

---

## Generics

Generic types and functions are parameterised over types. The compiler captures type parameters and uses them for type checking and code generation.

### Generic functions

```sfn
fn identity<T>(x: T) -> T {
    return x;
}

fn first<T>(items: Array<T>) -> T? {
    if items.length == 0 {
        return null;
    }
    return items[0];
}
```

### Generic structs

```sfn
struct Pair<A, B> {
    first -> A;
    second -> B;

    fn swap(self) -> Pair<B, A> {
        return Pair { first: self.second, second: self.first };
    }
}

let coords = Pair { first: 3.0, second: 4.0 };
let flipped = coords.swap();
print("{{flipped.first}}, {{flipped.second}}");
// 4, 3
```

### A generic stack

```sfn
struct Stack<T> {
    mut items -> Array<T>;

    fn new() -> Stack<T> {
        return Stack { items: [] };
    }

    fn push(self, value: T) {
        self.items.push(value);
    }

    fn pop(self) -> T? {
        if self.items.length == 0 {
            return null;
        }
        return self.items.pop();
    }

    fn peek(self) -> T? {
        if self.items.length == 0 {
            return null;
        }
        return self.items[self.items.length - 1];
    }

    fn is_empty(self) -> Bool {
        return self.items.length == 0;
    }

    fn size(self) -> Int {
        return self.items.length;
    }
}

fn main() ![io] {
    let mut s = Stack.new();
    s.push(10);
    s.push(20);
    s.push(30);
    print("Top: {{s.peek()}}");   // 30
    print("Pop: {{s.pop()}}");    // 30
    print("Size: {{s.size()}}");  // 2
}
```

### Generic interfaces (constraints)

An interface can be generic. Use a generic interface as a constraint on a type parameter by writing `T: InterfaceName`:

```sfn
interface Comparable<T> {
    fn compare_to(self, other: T) -> Int;  // negative, zero, or positive
}

struct SortedList<T: Comparable<T>> {
    mut items -> Array<T>;

    fn insert(self, value: T) {
        // insertion-sort position
        let mut i = 0;
        while i < self.items.length {
            if value.compare_to(self.items[i]) < 0 {
                break;
            }
            i = i + 1;
        }
        self.items.insert(i, value);
    }
}
```

### Generic enums

Generic enums like `Option<T>` and `Result<T, E>` are idioms you will use throughout Sailfin code:

```sfn
enum Option<T> {
    Some { value -> T },
    None,
}

enum Result<T, E> {
    Ok { value -> T },
    Err { error -> E },
}
```

Matching on them unwraps the payload:

```sfn
fn safe_divide(a: Float, b: Float) -> Option<Float> {
    if b == 0.0 {
        return Option.None;
    }
    return Option.Some { value: a / b };
}

fn main() ![io] {
    match safe_divide(10.0, 3.0) {
        Option.Some { value } => print("Result: {{value}}"),
        Option.None           => print("Division by zero"),
    }
}
```

---

## Type Aliases

Use `type` to give a name to an existing type. Aliases are transparent — the compiler treats `UserId` and `String` as the same type.

```sfn
type UserId = String;
type Timestamp = Int;
type Matrix = Array<Array<Float>>;
type Callback = fn(String) -> Bool;
```

Generic type aliases:

```sfn
type Table<K, V> = Array<Pair<K, V>>;
type Predicate<T> = fn(T) -> Bool;
type Transformer<A, B> = fn(A) -> B;
```

Aliases are useful for making signatures self-documenting without the overhead of a newtype:

```sfn
type OrderId = String;
type CustomerId = String;

fn get_order(order_id: OrderId, customer_id: CustomerId) -> Order ![io] {
    return db.find_order(order_id, customer_id);
}
```

---

## Optional Types

The postfix `?` operator creates a nullable type. `T?` is shorthand for "either a `T` or `null`".

```sfn
let name: String? = null;
let count: Int? = 42;
```

Optional fields in structs:

```sfn
struct Profile {
    username -> String;
    bio -> String?;
    avatar_url -> String?;
}

let p = Profile {
    username: "ada",
    bio: null,
    avatar_url: "https://cdn.example.com/ada.png",
};
```

### Null safety

Sailfin does not allow using an optional value where a concrete value is required without first checking or unwrapping. Guard with `if`:

```sfn
fn greet(name: String?) ![io] {
    if name == null {
        print("Hello, stranger!");
    } else {
        print("Hello, {{name}}!");
    }
}
```

Pattern matching on optionals:

```sfn
fn show_bio(profile: Profile) ![io] {
    match profile.bio {
        null => print("No bio set."),
        bio  => print("Bio: {{bio}}"),
    }
}
```

### Recursive optional types

Optional fields enable recursive data structures. A binary tree node where child pointers may be absent:

```sfn
struct TreeNode {
    value -> Int;
    left -> TreeNode?;
    right -> TreeNode?;
}

fn sum_tree(node: TreeNode?) -> Int {
    if node == null {
        return 0;
    }
    return node.value + sum_tree(node.left) + sum_tree(node.right);
}
```

---

## Union Types

A union type `A | B` represents a value that can be either `A` or `B`. Union types are particularly useful for error returns and heterogeneous collections.

```sfn
struct NotFoundError {
    message -> String;
}

struct PermissionError {
    required_role -> String;
}

fn load_document(path: String) -> String | NotFoundError | PermissionError ![io] {
    if !fs.exists(path) {
        return NotFoundError { message: "No file at {{path}}" };
    }
    if !current_user.can_read(path) {
        return PermissionError { required_role: "reader" };
    }
    return fs.read(path);
}
```

Match on union types by shape — the compiler picks the arm whose type the value matches:

```sfn
fn handle_load(path: String) ![io] {
    let result = load_document(path);
    match result {
        NotFoundError { message }         => print("Not found: {{message}}"),
        PermissionError { required_role } => print("Need role: {{required_role}}"),
        content                           => print("Content: {{content}}"),
    }
}
```

You can also use union types to accept heterogeneous inputs:

```sfn
fn stringify(value: Int | Float | Bool | String) -> String {
    match value {
        Int    => return "int:{{value}}",
        Float  => return "float:{{value}}",
        Bool   => return "bool:{{value}}",
        String => return value,
    }
}
```

---

## Wrapper Types (Design Preview)

Sailfin has four special wrapper types for safety-critical code. The syntax is accepted by the compiler today; enforcement of the ownership and taint rules is coming in a future release.

> **Status: syntax accepted today; enforcement coming in a future release.** The compiler parses `Affine<T>`, `Linear<T>`, `PII<T>`, and `Secret<T>` as nominal generic types. The move, consume, and taint rules described below are the *intended* semantics — they are tracked as metadata today and will be enforced as the ownership system matures.

### `Affine<T>` — may be dropped, not copied

An affine value can be used zero or one times. You can drop it without using it, but you cannot copy or clone it. The intended use case is resources like file handles, connections, or any value where duplication would be a bug:

```sfn
fn open_file(path: String) -> Affine<FileHandle> ![io] {
    return fs.open(path);
}

fn process(handle: Affine<FileHandle>) ![io] {
    let data = handle.read_all();
    // handle is consumed here — cannot be used again
    print("Read {{data.length}} bytes");
}

// This would be a compile error once enforcement is active:
// fn bad(handle: Affine<FileHandle>) {
//     let copy = handle;   // ERROR: affine values cannot be copied
//     process(handle);     // ERROR: already moved
// }
```

### `Linear<T>` — must be consumed exactly once

A linear value is stricter than affine: it cannot be dropped silently. The compiler requires that every linear value is consumed (passed to a function, returned, or explicitly discarded with a consuming operation) before the owning scope exits:

```sfn
fn mint_auth_token(user_id: Int) -> Linear<AuthToken> ![net] {
    return auth.issue(user_id);
}

fn use_token(token: Linear<AuthToken>) ![net] {
    // Token is consumed by this call — OK
    api.authenticate(token);
}

// Intended compile error once enforcement is active:
// fn forget_token(user_id: Int) ![net] {
//     let token = mint_auth_token(user_id);
//     // ERROR: linear value `token` must be consumed before scope exits
// }
```

### `PII<T>` — personally identifiable information

`PII<T>` marks data that is subject to privacy policy. Intended enforcement will prevent passing PII values to `net` or `model` effects without an explicit redaction step:

```sfn
struct UserRecord {
    id -> Int;
    email -> PII<String>;
    name -> PII<String>;
}

fn render_invoice(user: UserRecord) -> String {
    // Intended: accessing PII fields in a net/model context without
    // redact() would be a compile error once taint enforcement is active.
    let safe_name = redact(user.name);
    return "Invoice for {{safe_name}}";
}
```

### `Secret<T>` — credentials and sensitive tokens

`Secret<T>` marks cryptographic material, API keys, passwords, and similar secrets. Intended enforcement prevents secrets from flowing into logs, serialization, or any `io` operation that would expose them:

```sfn
fn connect(host: String, api_key: Secret<String>) ![net] {
    // Intended: api_key cannot appear in print() or log statements
    // once Secret enforcement is active.
    http.connect_with_key(host, api_key);
}
```

---

## Pattern Matching Deep Dive

`match` is Sailfin's primary tool for destructuring and branching on complex types. This section ties together everything above.

### Matching on structs (destructuring)

```sfn
struct Point {
    x -> Float;
    y -> Float;
}

fn classify(p: Point) -> String {
    match p {
        Point { x: 0.0, y: 0.0 } => return "origin",
        Point { x: 0.0, y }      => return "on y-axis at {{y}}",
        Point { x, y: 0.0 }      => return "on x-axis at {{x}}",
        Point { x, y }           => return "({{x}}, {{y}})",
    }
}
```

### Matching on enums with payloads

```sfn
enum Event {
    Click { x -> Int, y -> Int },
    KeyPress { key -> String, shift -> Bool },
    Resize { width -> Int, height -> Int },
    Quit,
}

fn handle(event: Event) ![io] {
    match event {
        Event.Click { x, y }               => print("Click at {{x}},{{y}}"),
        Event.KeyPress { key, shift: true } => print("Shift+{{key}}"),
        Event.KeyPress { key, shift: _ }    => print("Key: {{key}}"),
        Event.Resize { width, height }      => print("Resize to {{width}}x{{height}}"),
        Event.Quit                          => print("Quitting"),
    }
}
```

### Guards

Add a boolean guard with `if` after the pattern:

```sfn
fn describe_number(n: Int) -> String {
    match n {
        0          => return "zero",
        n if n < 0 => return "negative ({{n}})",
        n if n % 2 == 0 => return "even positive ({{n}})",
        n          => return "odd positive ({{n}})",
    }
}
```

### Nested patterns

Patterns can be nested to any depth:

```sfn
enum Expr {
    Lit { value -> Int },
    Add { left -> Expr, right -> Expr },
    Mul { left -> Expr, right -> Expr },
    Neg { expr -> Expr },
}

fn eval(e: Expr) -> Int {
    match e {
        Expr.Lit { value }             => return value,
        Expr.Add { left, right }       => return eval(left) + eval(right),
        Expr.Mul { left, right }       => return eval(left) * eval(right),
        Expr.Neg { expr: Expr.Lit { value } } => return -value,
        Expr.Neg { expr }              => return -eval(expr),
    }
}
```

### Binding with `as`

Capture the matched value into a name while still applying a pattern:

```sfn
fn log_event(event: Event) ![io] {
    match event {
        e as Event.Click { x, y } => {
            print("Logging click at {{x}},{{y}}");
            audit_log(e);
        }
        _ => {}
    }
}
```

### Wildcard and catch-all

Use `_` to ignore a value, or a plain identifier to bind-and-ignore the rest:

```sfn
fn is_error(result: Result<Int, String>) -> Bool {
    match result {
        Result.Err { error: _ } => return true,
        _                       => return false,
    }
}
```

### Exhaustiveness

The compiler checks that `match` arms cover all possible cases. For enums, every variant must appear (or a wildcard `_` must be present). Missing arms produce a compile error:

```
error[E0210]: non-exhaustive match on `Direction`
  --> src/main.sfn:8:5
   |
8  |     match d {
   |     ^^^^^^^^ missing arm for `Direction.East`, `Direction.West`
   |
   = help: add a `_` wildcard arm or cover the missing variants
```

---

## Type Inference

Sailfin infers types from context where possible. The rules are straightforward:

### Where inference works

- **Variable initializers**: `let x = 42` infers `Int`.
- **Return types**: if all `return` statements return the same type, the compiler can infer the return type (annotation still recommended for public APIs).
- **Array literals**: `let nums = [1, 2, 3]` infers `Array<Int>`.
- **Struct literal fields**: field types are checked against the struct declaration.
- **Closure parameters**: `items.map(|x| x * 2)` infers `x: Int` from the element type of `items`.

```sfn
let score = 95;                        // Int
let ratio = score / 100.0;             // Float (mixed arithmetic)
let passing = score >= 60;             // Bool
let label = if passing { "pass" } else { "fail" };  // String
```

### Where annotations are required

- **Function parameters**: always require explicit types.
- **Ambiguous generics**: `let empty = []` — the element type is unknown; write `let empty: Array<Int> = []`.
- **Interface types**: `let v: Driveable = Car { ... }` — the concrete type must be coerced to the interface type explicitly via the annotation.
- **Recursive functions**: the return type annotation is required when the function calls itself.

```sfn
// REQUIRED: parameter types cannot be inferred
fn multiply(a: Int, b: Int) -> Int {
    return a * b;
}

// REQUIRED: empty collection needs annotation
let empty: Array<String> = [];

// REQUIRED: return type needed for recursive fn
fn factorial(n: Int) -> Int {
    if n <= 1 { return 1; }
    return n * factorial(n - 1);
}
```

### Current limitations

Type inference coverage is partial. The compiler performs inference on straightforward initializers and return types but does not yet perform full Hindley-Milner unification. When the compiler cannot determine a type, it will ask you to add an annotation:

```
error[E0100]: type annotation required
  --> src/lib.sfn:14:9
   |
14 |     let result = transform(items);
   |         ^^^^^^ cannot infer type — add an annotation: `let result: Array<T> = ...`
```

---

## Next Steps

- [The Effect System](/docs/learn/effects) — Capability annotations and compile-time enforcement
- [Ownership & Borrowing](/docs/learn/ownership) — Move semantics and borrow rules
- [Error Handling](/docs/learn/error-handling) — try/catch and Result-style patterns
- [Language Spec](/docs/reference/spec) — Formal type system reference
