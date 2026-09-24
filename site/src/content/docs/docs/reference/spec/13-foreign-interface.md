---
title: "§13 Foreign Interface"
description: "Sailfin language specification — extern declarations, the C-ABI accept-list, the @repr(C) layout contract, raw pointer operations, and function addresses."
sidebar:
  order: 13
  label: "§13 Foreign Interface"
---

Sailfin reaches foreign code through `extern fn` declarations, raw pointers,
and a validated `@repr(C)` struct layout. This chapter is normative for the
surface that **ships today**. The raw-pointer mutability contract follows
[SFEP-0079](/sfep/0079-systems-c-interop/): `*T` and `*mut T` permit stores,
while `*const T` permits loads but rejects stores.

For the practical guide, see [Unsafe & FFI](/docs/advanced/ffi/).

## 13.1 Extern declarations

An extern declaration names a symbol resolved at link time:

```sfn
extern fn malloc(size: usize) -> *u8;
extern fn free(ptr: *u8) -> void;
extern fn strlen(s: *u8) -> usize;
```

The declaration is a signature only; it has no body. Parameters use the
ordinary `name: Type` form and the return type follows `->`.

A foreign **variable** is declared with `extern var`, which is the one extern
form that may also define storage:

```sfn
extern var environ: **u8;
```

Its type is validated against the same accept-list, in parameter position — so
a bare `void` is rejected there too.

`unsafe extern fn` is also accepted. The `unsafe` keyword on an extern is a
parsed marker: it is consumed by the parser and no analysis pass reads it back,
so `extern fn` and `unsafe extern fn` typecheck and lower identically. `unsafe`
is **not** an effect — see §13.6.

An extern may attest its effects with `![...]`, including an explicit `![]`
claim of purity. Calls to an attested extern require the caller to declare its
effects. An extern with no effect clause is unattested and contributes no
effect requirement. The compiler trusts the attestation; it does not inspect
foreign code to verify it.

### Variadic externs

A trailing `...` marks an extern as C-variadic. It is meaningful only as the
declaration's last parameter, and only after at least one fixed parameter — a
C variadic resolves a call against the fixed prototype, and LLVM has no
function type spelled `...` alone:

```sfn
extern fn ioctl(fd: i32, request: u64, ...) -> i32;
```

Misplacing `...` — with no fixed parameter before it, or with a parameter
after it — is `E0851`.

Lowering emits both the variadic `declare` and, at each call site, the
explicit function-type call form:

```llvm
declare i32 @ioctl(i32, i64, ...)

%1 = call i32 (i32, i64, ...) @ioctl(i32 %fd, i64 %request, i32 %flag)
```

The explicit `(i32, i64, ...)` on the call is load-bearing, not cosmetic: it
is what tells LLVM to apply the callee's declared variadic type rather than
infer one from the argument list. That matters because the two governed
targets disagree on where a variadic argument goes — registers on AAPCS64
Linux, the stack on Apple arm64 — and only the declared function type carries
that distinction through to codegen.

When a module re-exports a variadic extern, downstream imports bind the
original provider symbol directly. Sailfin does not emit the ordinary
re-export wrapper for that symbol: a wrapper can name the fixed parameters but
cannot name or forward the unknown variadic tail.

**Call-site promotion check.** C applies its default argument promotions to
everything in variadic position: `i8`/`i16`/`u8`/`u16` and `_Bool` widen to
`int`, and `float` widens to `double`. Sailfin has no implicit promotion
(SFEP-0058), so an unpromoted value passed there reaches the callee at a width
it cannot read back. `E0851` also covers this: an argument in variadic
position whose *stated* type — an explicit `as` cast, or an identifier bound
with an explicit type annotation — is `i8`, `i16`, `u8`, `u16`, `f32`, or
`bool`/`boolean` is rejected with a hint to cast explicitly (`as i32`,
`as f64`).

This check is deliberately narrow and **fails open**: it judges only an
argument whose type the source states outright. An untyped integer literal
(`sum_va(1, 10, 20)`), the result of a call, or an identifier whose declared
type is out of view all pass silently whether or not they need promotion — the
check does not infer a type in order to accuse it. State the argument's type
explicitly at the call site if you want the check to see it.

Variadic Sailfin function *definitions* and `va_list` access to a variadic
extern's own arguments remain designed, not shipped.

### Narrow-integer extension

Extern prototypes and their matching call sites carry the extension attributes
used by clang for the governed C ABIs. Signed `i8` and `i16` parameters and
returns carry `signext`; `u8`, `u16`, and `bool` carry `zeroext`. The return
attribute precedes the LLVM return type, while a parameter attribute follows
its LLVM type:

```llvm
declare signext i16 @takes(i8 signext, i16 zeroext, i1 zeroext)

%result = call signext i16 @takes(
    i8 signext %signed,
    i16 zeroext %unsigned,
    i1 zeroext %flag
)
```

These attributes apply only at the C boundary. Sailfin-to-Sailfin definitions
and calls retain their native ABI and do not gain `signext` or `zeroext`.

## 13.2 The C-ABI accept-list

A type is admissible in extern parameter or return position when it is one of:

**Primitives**

| Sailfin | C | Notes |
|---|---|---|
| `i8`, `i16`, `i32`, `i64` | `int8_t` … `int64_t` | |
| `u8`, `u16`, `u32`, `u64` | `uint8_t` … `uint64_t` | |
| `usize`, `isize` | `size_t`, `ssize_t` | pointer-sized |
| `f32`, `f64` | `float`, `double` | |
| `f16`, `bf16` | `_Float16`, `__bf16` | accepted by the checker; no dedicated ABI handling |
| `bool` | `_Bool` | the extern spelling is `bool`, **not** `boolean` |
| `int` | `int64_t` | Sailfin's default integer, lowers to `i64` |
| `float` | `double` | Sailfin's default float |
| `void` | `void` | **return position only** — bare `void` as a parameter is `E0805` |

**Pointers.** `*T` where `T` is itself admissible, `void`, or an identifier
with an uppercase initial, treated as an opaque foreign handle (`*File`,
`*FILE`, `*PthreadMutex`). The rule checks only the first character and that
the rest are identifier characters; it does not verify that the name denotes a
declared type. `**T` follows by recursion. `*void` is the untyped byte
pointer (C's `void*`); `*u8` is the conventional spelling for byte buffers and
C strings.

`*const T` and `*mut T` are accepted: the checker strips the `const ` or `mut `
prefix for the ABI accept-list and applies the same rule to the pointee.
`*const T` is read-only at a store site; see §13.4.

> **Not admissible:** `*opaque` is rejected with `E0805`. The opaque-pointee
> rule requires an uppercase initial, so the lowercase `opaque` matches nothing.
> Write `*void`.

**Function pointers.** `* fn (A, B) -> C` is a single C code pointer, accepted
in both the compact `*fn(` spelling and the formatted `* fn (` spelling. Each
parameter must satisfy this accept-list in parameter position, and the return
must satisfy it in return position. Bare `fn (A, B) -> C` is a Sailfin closure
pair and is rejected in an extern declaration with `E0805`.

### Declaration diagnostics

| Code | Raised when |
|---|---|
| `E0801` | The type is `string` or `string?`, or a pointer whose pointee is (`*string`, `*const string`). Use `*u8` plus a NUL-terminated copy. |
| `E0802` | The type has a `[]` at the top level. Sailfin arrays carry runtime metadata; use `*T` plus a length parameter. |
| `E0803` | The extern declares type parameters (`<...>`). Only concrete C-ABI types cross the boundary. |
| `E0804` | Retired: extern effect attestations are accepted. |
| `E0805` | Any other inadmissible or missing type: a missing parameter or `extern var` annotation, bare `void` in parameter position, an unrecognized name such as `number` or `boolean`, and any `string`/array shape the two rules above do not reach (a nested `Foo<int[]>` lands here, not on `E0802`). |
| `E0850` | A named function passed to a typed extern callback parameter has a mismatched or non-C-ABI signature, or a lambda is passed to that slot. |
| `E0851` | A variadic extern's `...` is misplaced — no fixed parameter before it, or a parameter after it — or a call-site argument in variadic position has a stated type C would have promoted (`i8`, `i16`, `u8`, `u16`, `f32`, `bool`/`boolean`). See [Variadic externs](#variadic-externs). |

## 13.3 The `@repr(C)` layout contract

`@repr(C)` on a struct guarantees a C-compatible layout: fields are placed in
declaration order at each field's natural alignment, the struct's alignment is
the maximum field alignment, and the size is rounded up to that alignment
(tail padding). For a valid unpacked struct this changes **no generated IR** —
the LLVM lowering for a struct already does this — what `@repr(C)` adds is the
*guarantee*: a future Sailfin-native layout optimization (reordering, niche
packing, field elision) must skip a `@repr(C)` struct.

```sfn
// linux/input.h — 24 bytes on LP64 (aarch64 and x86_64 Linux).
@repr(C, size = 24)
struct InputEvent {
    sec: i64;
    usec: i64;
    kind: u16;
    code: u16;
    value: i32;
}
```

`InputEvent` lays out at offsets 0, 8, 16, 18, 20, for a size of 24 and an
alignment of 8, mirroring `struct input_event` from `linux/input.h` on LP64.

**Admissible field types.** A `@repr(C)` struct field must be one of:

| Sailfin | Size / align (bytes) |
|---|---|
| `i8`, `u8` | 1 / 1 |
| `i16`, `u16` | 2 / 2 |
| `i32`, `u32` | 4 / 4 |
| `i64`, `u64`, `isize`, `usize` | 8 / 8 |
| `f32` | 4 / 4 |
| `f64` | 8 / 8 |
| `f16`, `bf16` | 2 / 2 |
| `*T`, `*const T`, `*mut T` | 8 / 8 |
| another `@repr(C)` struct, by value | that struct's computed size / align |

Every other field type is `E0847`: `string`, `T[]`, closures, enums,
optionals (`T?`), generics, a non-`@repr(C)` struct by value, and **`bool`**.
`bool` is rejected because C's `_Bool` is a byte while Sailfin's `bool`
storage is `i1`; a loaded byte other than `0`/`1` would be undefined
behavior. Use `u8` instead. Admitting `bool` later with `i8` storage is a
compatible widening. An inline fixed-size array field (`[T; N]`) is **not**
admissible yet — designed, not shipped (SFEP-0079 §3.1, leaf L9, SFN-1299).

A nested `@repr(C)` struct field must be **declared in the same module**. A
struct imported from another module is reconstructed from that module's
compiled artifact, which records no decorators, so the compiler cannot tell
whether it carries `@repr(C)` and conservatively rejects the field with
`E0847`. Declare the mirror alongside the struct that embeds it, or hold it
behind a pointer (`*Timespec`), which is admissible across modules.

**`packed`.** `@repr(C, packed)` lowers to an LLVM packed struct
(`<{ ... }>`): alignment 1, no padding between or after fields — the same
guarantee as `__attribute__((packed))`. Field loads and stores against a
packed struct use `align 1`.

```sfn
@repr(C, packed)
struct EpollEvent {
    events: u32;
    data: u64;
}
```

Unpacked, `EpollEvent` would lay out as `{ i32, [4 x i8], i64 }` — 16 bytes,
with 4 bytes of padding before `data` so it lands at its natural 8-byte
alignment. Packed, it lowers to `<{ i32, i64 }>` and is 12 bytes: `data`
follows `events` immediately, at offset 4.

**Assertions.** `size = N` and `align = N` are optional named arguments,
checked against the computed layout. `align = N` must be a power of two. A
mismatch is `E0848`, and the diagnostic prints the computed per-field offsets
so a C header transcription error is caught at compile time instead of
becoming a silent ABI mismatch. `InputEvent` above uses `size = 24` this way.

**Target invariance.** Every governed target (SFEP-0066 §3.2: x86_64 and
aarch64 Linux, arm64 macOS, x86_64 Windows) is 64-bit with identical natural
alignment for every admissible field type, so a valid `@repr(C)` layout is
**target-invariant** — with one exception, `packed`, which reproduces
whatever ABI the platform's C compiler assigns a packed struct. A C type
whose layout genuinely differs per target (`long`, `struct stat`) must still
be modeled per target by the binding library; `@repr(C)` does not make a
target-varying C type target-invariant, it only guarantees that Sailfin lays
out the fields you wrote exactly as specified everywhere.

**Misuse.** `E0846` covers:

- an unknown or malformed decorator argument (`@repr(c)`, `@repr(C, pack)`,
  a non-literal or non-power-of-two `align`)
- `@repr(C)` on an **enum**
- `@repr(C)` on a **generic struct** — a type parameter has no single C
  layout

Methods are allowed on a `@repr(C)` struct; the decorator constrains data
layout only.

**Not shipped.** The layout builtins `size_of`, `align_of`, and `offset_of`
are **designed, not shipped** (SFEP-0079 §3.1, leaf L2b, SFN-1295). There is
no way yet to query a `@repr(C)` struct's layout from Sailfin source; the
guarantee is enforced at compile time by the checker and the LLVM lowering,
not exposed as a value.

### Layout diagnostics

| Code | Raised when |
|---|---|
| `E0846` | An unrecognized or malformed `@repr` argument, or `@repr(C)` applied to an enum or a generic struct. |
| `E0847` | A `@repr(C)` struct field's type has no C representation: `string`, `T[]`, a closure, an enum, `T?`, a generic, a non-`@repr(C)` struct by value, or `bool`. |
| `E0848` | A `size =` or `align =` assertion disagrees with the computed layout. The message prints the computed per-field offsets. |

## 13.4 Raw pointer operations

`*T` is a read-write raw pointer to `T`. `*const T` is read-only: a load is
allowed, but a store through it receives `E0852`, including `*p = v`, `p.f = v`,
and compound assignments. `*mut T` is an accepted synonym for `*T`.
Implicitly placing a `*const T` in a writable pointer slot also receives
`E0852`; an explicit pointer cast can change that view.
None of the following operations requires an `unsafe` block.

- **Load.** `*p` reads a `T`.
- **Store.** `*p = v` writes a `T`.
- **Member access.** `p.f`, where `p: *S` and `S` is a struct, loads or stores
  field `f` at its offset, auto-dereferencing.
- **Arithmetic.** `p + n` and `p - n` advance and retreat by `n` elements,
  scaled by the pointee's size, matching C. On `*u8` the step is one byte.
- **Casts.** `p as *U` reinterprets. `p as i64` and `n as *T` convert between
  an address and an integer. `0 as *T` and `null` are the null pointer, and
  `p == null` / `p != null` are the null tests.
- **Address of a struct binding.** `s as *S` yields the address of that
  struct's storage.
- **String data pointer.** `s as *u8` yields a string's data pointer. It is
  NUL-terminated **only for string literals**; any other string handed to a C
  `const char*` must first be copied with an explicit NUL, because slices are
  not NUL-terminated.

> Dereferencing a non-pointer is **not** rejected by `sfn check`. It produces
> `E1006`, a `warning`-severity diagnostic raised during *lowering*, and the
> expression lowers to no operand. `sfn check` models no codegen, so it reports
> nothing at all.

> **Bind a literal before casting it.** Write the string to a `string` local
> and cast the local. The inline form — `getenv("PATH" as *u8)` — miscompiles:
> the call is elided and its result lowered to a null store, so the value reads
> as unset. The runtime records this at `runtime/sfn/memory/arena.sfn:441`.

The pointer qualifiers have the same C pointer representation; `const` governs
which stores Sailfin accepts. `E0852` is raised during type checking.

**Retention.** A pointer into Sailfin-managed storage is valid only for the
duration of the foreign call it is passed to; Sailfin storage may be
arena-backed and reclaimed at a phase boundary. Anything the foreign side
retains beyond the call must live in memory it owns, such as a `malloc`
allocation. This rule is **documented, not enforced**.

**Layout is unspecified except under `@repr(C)`.** A struct without `@repr(C)`
lowers to an LLVM identified type in field declaration order, which coincides
with the C ABI for scalar fields on the supported targets, but no part of that
is a contract: nothing prevents a future layout optimization from reordering
its fields. `@repr(C)` is the guarantee — see §13.3.

## 13.5 Function addresses

At a call to an extern with a `* fn (A) -> R` parameter, a bare named
function with the exact C-ABI parameter and return types is passed as a code
address. For example, `qsort(base, count, width, compare)` accepts a Sailfin
`fn compare(a: *u8, b: *u8) -> i32`. A lambda cannot fill this slot because
its environment has no place in a C function pointer.

A named Sailfin function's address is taken with an explicit cast:

```sfn
extern fn pthread_create(t: *u8, attr: *u8, start: *u8, arg: *u8) -> i32;

fn worker(arg: *u8) -> *u8 { return arg; }

// `worker as *u8` is the code pointer C receives.
```

The cast lowers to a single code pointer, not a closure pair, so foreign code
can call the function directly. Two diagnostics guard the form:

| Code | Raised when |
|---|---|
| `E0808` | A function name is used as a value without the cast, or with a target other than `* u8` or a function-pointer type. |
| `E0809` | The named function is generic. Only concrete functions have a single address. |

This is the shipped C→Sailfin callback path. Defining a C-callable symbol under
an unmangled name (`extern fn … { body }`) is **designed, not shipped**
(SFEP-0079 §3.4, leaf L6). A Sailfin `throw` unwinding across a foreign frame
is undefined.

## 13.6 Effects and `unsafe`

An attested extern call participates in ordinary effect checking. A caller
missing an attested effect receives `E0400` in the same module or `E0402`
across modules. The capsule manifest must grant effects attested by externs
and declared by callers, or `E0403` reports the mismatch. An unknown effect
root receives `E0404`. Hierarchical sub-effects apply as for
Sailfin functions. An unattested extern call contributes nothing; foreign
effects remain the author's responsibility to attest.

`unsafe` is meaningful to the ownership checker and to nothing else. No pointer
operation requires it. What it does is **suppress ownership analysis**, and the
two forms suppress different amounts:

- **`unsafe { }`** — the checker does not walk the block's interior, so
  statement-level findings inside it are not raised: a double consume that
  would be `E0901` outside the block is not reported inside it. The
  *routine-level* obligation survives, but the checker cannot see a consumption
  that happened inside the block, so a `Linear<T>` consumed only there is
  reported as `E0907` — the diagnostic moves rather than disappearing.
- **`unsafe fn`** — the entire body is skipped. A `Linear<T>` parameter of an
  `unsafe fn` carries **no** enforced obligation; the same function written
  `fn` raises `E0907`.

Passing a bare owned value to an extern declared in the same compilation unit,
outside an `unsafe` block, raises `E0906`; inside one it does not. That is the
boundary the block exists for.

Because `unsafe fn` disables the checks rather than narrowing them, prefer a
plain `fn` with a narrow `unsafe { }` block around the foreign call.

`![unsafe]` is **not** an effect and never was. The canonical effects are
`clock`, `gpu`, `io`, `model`, `net`, and `rand`; a function declaring
`![unsafe]` is rejected with `E0404`. The `![unsafe]` effect,
`[capabilities] required = ["unsafe"]`, and `[policies.unsafe]` are
**withdrawn** by SFEP-0079 §3.5: each was a restriction with no matching power,
and a derived record of the program's foreign edges supersedes the audit
purpose they were meant to serve. That record is **designed, not shipped**
(SFEP-0079 §3.5, leaf L8).

## 13.7 Linking

The foreign library providing an extern symbol must be linked into the final
binary. Name it in the capsule's manifest:

```toml
[build]
link-libs = ["m", "pthread"]
```

`link-libs` is honored **only for the capsule being built**. A dependency
capsule that declares it has the key ignored, reported as `E0627` at `warning`
severity, so an application linking a foreign library must declare it itself.

Link inputs are build inputs, not provenance: naming a library tells the linker
what to resolve against, and records nothing about what that library does.
