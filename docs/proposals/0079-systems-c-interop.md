---
sfep: 79
title: Systems C Interop — a Specified Layout, Pointer, Callback, and Foreign-Reach Contract
status: Accepted
type: language
created: 2026-09-18
updated: 2026-09-18
author: "agent:compiler-architect (drafted); project owner (commissioned 2026-09-18)"
tracking: https://linear.app/sailfin/project/systems-c-interop-828be16b7d55
supersedes:
superseded-by:
graduates-to: reference/spec/13-foreign-interface.md
---

# SFEP-0079 — Systems C Interop

## 1. Summary

Sailfin can already drive a Linux framebuffer from pure Sailfin: a spike
cross-built with `sfn build --target aarch64-unknown-linux-gnu` ran on an
aarch64 handheld. It opened `/dev/fb0`, read `fb_var_screeninfo` through a
Sailfin struct overlay, `mmap`ed the framebuffer, and filled 786,432 pixels in
3.9 ms, with every store made through a typed raw pointer. All of that works
by accident. The struct layout, the pointer-store semantics, the callback path,
and the ABI that externs use are **incidental and unspecified**. Parts of the
documentation describe features that do not exist (`@repr(C)`, `![unsafe]`,
`&raw`, read-only `*T`).

This proposal turns that accidental floor into a contract. It does five things:

1. It gives `@repr(C)` real meaning: a guaranteed layout, validated fields,
   `size_of`/`align_of`/`offset_of`, and optional compile-time size
   assertions.
2. It fixes one pointer model, matching Zig: `*T` is read-write, `*const T`
   is read-only, and the existing deref/member/element-scaled arithmetic
   becomes specified.
3. It fixes C calling-convention fidelity: variadic externs, and
   `signext`/`zeroext` on narrow integers.
4. It makes C↔Sailfin callbacks first-class: typed `* fn (A) -> R` extern
   parameters, plus C-ABI function *definitions* that C can call by name and
   that abort instead of unwinding across C frames.
5. It proposes an answer to the owner-level `extern` design gate
   (decision-brief §7.6, SFEP-0016 §4.4 Q3). Externs may **attest** effects.
   Every foreign symbol a build reaches is **enumerated in the derived build
   manifest**, so the Reach proof stays complete over an explicitly listed
   foreign trust base instead of silently ending at the first `extern`.

## 2. Motivation

### 2.1 The consumer

The project owner intends to port **MeshClient** gradually to Sailfin.
MeshClient is a ~140k-LOC C Meshtastic client that runs on a TrimUI Brick:
aarch64 Cortex-A53, Tina Linux 4.9, glibc 2.33, 1 GB RAM, and a framebuffer
UI. This is a real program with a hard OS surface, and it has clean seams to
port across: a UI-backend vtable, a transport vtable, and a core layer that
never includes UI headers. It needs the following:

| Surface | C shape | What Sailfin needs |
|---|---|---|
| `/dev/fb0` | `open` + `ioctl(FBIOGET_{F,V}SCREENINFO)` + `mmap(MAP_SHARED)`; XRGB8888; 1024×16384 virtual, visible page = `yoffset` | C-layout structs with **inline char/u32 arrays** (`fb_fix_screeninfo.id[16]`, `fb_var_screeninfo.reserved[4]`), variadic `ioctl`, pointer stores |
| evdev | `EVIOCGBIT`/`EVIOCGNAME` ioctls; `read()` of `struct input_event` (24 B on LP64) | `size_of<InputEvent>()`, pinned layout |
| Serial | `tcgetattr`/`cfsetispeed`/`tcsetattr` at B115200 | `struct termios` with `c_cc[32]` (inline array) |
| BLE | libdbus/BlueZ; C **callbacks** (watch/timeout add/remove/toggle functions registered into the loop) | typed C function pointers; Sailfin functions callable from C |
| Event loop | one `epoll` loop plus `eventfd`/`timerfd` | `struct epoll_event` (union payload, **packed on x86_64** only) |
| Crash handler | `sigaction` + `sigaltstack` | handler = C-ABI function definition |
| DNS | `fork` | plain externs |
| Libraries | mbedTLS, nanopb | foreign link inputs via `[build] link-libs` (SFN-1269, shipped) |

A gradual port also runs **both directions** at once. Ported Sailfin modules
call the remaining C, and the remaining C calls ported Sailfin modules by
symbol name, through the existing vtables.

### 2.2 The spike proves the floor

In `fbspike.sfn` (scratchpad, 2026-09-18), `extern fn open/ioctl/mmap/munmap/
memcpy/memset/usleep/clock_gettime` are declared by hand. `fb_var_screeninfo`
is read by casting `*u8` to a struct of `i32` fields, and pixels are stored
with `px.v = …` where `px: *Word`. Readback matched the written values, and
the owner confirmed the image on the device. A host probe confirmed `i32`
fields at a 4-byte stride and that typed-pointer field assignment lowers to a
`store`.

`ioctl` was declared **fixed-arity**. That is correct on AAPCS64 Linux, where
variadic and fixed integer arguments share `x0`–`x7`. It is **wrong on Apple
arm64**, where every variadic argument goes on the stack. The spike was
correct by platform luck.

### 2.3 What is actually true today (verified 2026-09-18)

| Claim | Reality | Evidence |
|---|---|---|
| `@repr(C)` controls layout | **No implementation.** Struct decorators are parsed into `StructDeclaration.decorators` (`compiler/capsules/syntax/src/ast.sfn:430`) and never read. `@repr(C)` and `@bogus_thing(C)` both pass `sfn check` silently. | `site/.../advanced/ffi.md:174-203`; probe `c_repr.sfn`, `i_deco.sfn` |
| Struct layout is C-compatible | **Incidentally, yes, in LLVM.** Structs lower to non-packed identified types in declaration order (`%P = type { i8, i32, i16, i64, i1, float, %Inner, i8*, i8* }`), and allocation uses `getelementptr %T, %T* null, i32 1` sizing. LLVM's natural layout coincides with the LP64 C ABI for these scalars. | `sfn emit llvm` probe `j_layout.sfn`, `k_lit.sfn` |
| The `.sfn-asm` layout agrees | **It does not.** `analyze_type_layout` knows only `i32`/`i64`/`int`/`bool`/pointers/`string`. `u8`/`i8`/`u16`/`i16`/`u32`/`u64`/`f32`/`f64` fall through to `size: 8, align: 8` (`compiler/capsules/codegen/src/emit_native_layout.sfn:309-465`). `.layout struct name=Ev size=40` is emitted for a struct LLVM sizes at 24. Plain-struct GEPs use the field *index*, so this is latent for plain structs, but enum payload offsets **do** consume `.layout` offsets (`codegen-llvm/src/lowering/instructions_match.sfn:512`, `expression_lowering/native/core_literals_lowering.sfn:1276`). | `sfn emit native` probe |
| Externs reject `i16/u16/u32/u64/isize/f32/f64` | **False.** Slice C (#286, `a3884092`) admitted them. `is_extern_primitive_type` (`compiler/capsules/analyzer/src/typecheck_types/extern_abi.sfn:128-146`) accepts all of them, plus `f16`/`bf16`, `int`, and `float`. The header comment at `extern_abi.sfn:22-42` is stale. | probe `a_types.sfn` passes `sfn check` |
| Narrow integers cross the C ABI correctly | **Unverified, and likely wrong off Linux-aarch64.** No `signext`/`zeroext` attribute is emitted anywhere in `compiler/capsules`. x86-64 SysV (as clang implements it) and Apple arm64 both expect the *caller* to extend `i8`/`i16` arguments to 32 bits. SFN-575 fixed Sailfin-to-Sailfin sign correctness only. | `grep zeroext\|signext` → 0 hits |
| No pointer store exists except `memcpy` | **Stale.** `*p = v` lowers to `store i32` (probe `e_deref.sfn`/`j_layout.sfn`). Field stores through typed pointers appear throughout the runtime (`runtime/sfn/type_meta.sfn:154`, `runtime/sfn/exception.sfn:205`). The comment at `runtime/sfn/adapters/filesystem.sfn:844-847` is out of date. There is no `pointer_write` intrinsic, and none is needed. | probes |
| `*T` is read-only | **Documented, not enforced.** `ffi.md` and `spec/06-types.md:125-127` say `*T` is read-only. Every runtime write goes through a `*T`. | spike and runtime |
| Pointer arithmetic is element-scaled | **True.** `q + 1` with `q: *i32` → `getelementptr i32, i32* %q, i64 1`. The index currently round-trips through `@round(double)`, which is lossless below 2^53 and is a codegen-quality issue, not a semantic one. | `j_layout.sfn` IR |
| C calling back into Sailfin | **Works by raw address.** `name as *u8` lowers to `bitcast @fn to i8*` (#1146), which `compiler/tests/e2e/fn_reference_pthread_test.sfn` covers: libpthread calls a Sailfin start routine. The runtime scheduler depends on it. What is missing: typed extern function-pointer parameters are **dead**. `is_c_abi_function_pointer` accepts only the tight `fn(` spelling, `sfn fmt` rewrites it to `fn (`, and `* fn (A) -> R` (the #1089 plain-pointer spelling) is rejected with E0805 (probes `b_fnspace.sfn`, `n_starfn.sfn`). Nothing stops a Sailfin `throw` from `longjmp`ing across C frames. | `runtime/sfn/platform/pthread.sfn:18-31` |
| C can call Sailfin by name | **No.** Defined functions are module-mangled, and there is no defining form for a C-ABI symbol. The only defining extern is `extern var NAME: T = init` (#1436). | `fn_reference_pthread.sfn` header |
| Variadic externs | **Parse error** (`E0500` at `...`). | probe `f_var.sfn` |
| Inline arrays in structs | **Rejected** (`E0830`, "arrays are written `T[]`"). The runtime works around this with runs of `i64` slots (`runtime/sfn/platform/pthread_layout.sfn`). | probe `h_arr.sfn` |
| `&raw value` | **Documented as shipped, but does not type-check** (`E0818` "unstructured expression"). | probe `o_raw.sfn` |
| `![unsafe]`, `[capabilities] required = ["unsafe"]`, `[policies.unsafe]` | **Unenforced, and `unsafe` is not a canonical effect** (`compiler/capsules/analyzer/src/effect_taxonomy.sfn`). | `ffi.md:47-52,116-151,331-367` |
| Externs can carry effects | **Forbidden** (`E0804`, `extern_abi.sfn:420-434`). `compiler/capsules/analyzer/src/effect_checker/` never mentions externs, so extern calls are invisible to the effect system. | `declaration_and_statement_checks.sfn:177-181` |
| Linux syscall surface | **Absent.** No `ioctl`/`mmap`/`epoll_*`/`eventfd`/`timerfd_*`/`tc{get,set}attr`/`sigaction` extern exists in `runtime/`, `stdlib/`, or `capsules/`. Only `poll` does (`runtime/sfn/platform/posix.sfn:56`). | grep |

The status quo has three concrete problems:

- **Soundness.** A C port needs guarantees, and "the layout happens to
  match" becomes silent memory corruption the day a layout optimization lands.
  The only thing standing in for a contract today is a hand-computed byte
  offset (`fix + 48`), and SFEP-0075 is already reshaping struct semantics
  underneath it.
- **Honesty.** `ffi.md` documents at least four unshipped features, which
  violates the "parsed but not enforced is not shipped" rule in `CLAUDE.md`.
- **The Reach pillar.** Every `extern` is a hole in the capability manifest:
  it can do anything, and nothing records that it exists.

## 3. Design

The unifying principle: **no new keywords, and no new effect.** Every
construct is existing Sailfin syntax given a specified meaning, the C/Rust/Zig
spelling of a missing piece, or a library.

### 3.1 `@repr(C)` — the layout contract

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

**Semantics.**

- **Order and padding.** Fields are laid out in declaration order with C
  natural alignment. Each field is placed at the next offset that is a
  multiple of its alignment. The struct's alignment is the maximum field
  alignment, and its size is rounded up to that alignment. This is exactly
  what the LLVM lowering already produces. `@repr(C)` changes **no generated
  IR** for a valid struct. What it adds is the *guarantee*: any future
  Sailfin-native layout optimization (reordering, niche packing, field
  elision) must skip `@repr(C)` structs.
- **Admissible field types.** Allowed:
  - `i8/i16/i32/i64`, `u8/u16/u32/u64`, `isize/usize`
  - `f32/f64` (and `f16`/`bf16`, which match clang's `_Float16`/`__bf16` on
    the governed targets)
  - raw pointers `*T`/`*const T`
  - typed C function pointers `* fn (A) -> R` (§3.4)
  - another `@repr(C)` struct **by value**
  - an inline array `[T; N]` of an admissible `T` (§3.6)

  Everything else is `E0847`: `string`, `T[]`, closures `fn (A) -> R`, enums,
  optionals, generics, non-`@repr(C)` structs, and `bool`. `bool` is rejected
  in v1 because C `_Bool` is a byte, and Sailfin's `i1` storage makes a loaded
  byte other than 0/1 UB; use `u8`. Admitting `bool` later with an `i8`
  storage lowering is a compatible widening.
- **Target invariance.** Every governed target (SFEP-0066 §3.2: x86_64/aarch64
  Linux, arm64 macOS, x86_64 Windows) is 64-bit with identical natural
  alignment for every admissible field type. So a valid `@repr(C)` layout is
  **target-invariant**, with one exception, `packed`, below. A C type whose
  layout *does* differ across targets (`long`, `struct stat`, `epoll_event`)
  must be modeled per target by the library that binds it (§3.8). That is a
  library concern, not a language one.
- **`packed`.** `@repr(C, packed)` lowers to an LLVM packed struct
  (`<{ … }>`, alignment 1, no padding), which is what
  `__attribute__((packed))` means. It exists for the one case MeshClient needs
  on x86_64 hosts: `struct epoll_event`. Loads and stores through a packed
  field use `align 1`.
- **Assertions.** `size = N` and `align = N` are optional named decorator
  arguments. The compiler computes the layout and emits `E0848` on mismatch,
  printing the computed per-field offsets. This is the Rust
  `const _: () = assert!(size_of::<T>() == 24)` idiom without const
  evaluation, and it turns a header transcription error into a compile error.
- **Misuse.** `@repr(C)` on an enum, a generic struct, or a struct with
  methods that capture, or with an unknown argument (`@repr(c)`,
  `@repr(C, pack)`), is `E0846`. Methods are allowed; `@repr(C)` constrains
  data only.

**Layout builtins.** These use the existing explicit type-argument call syntax
(`ident<i64>(3)` type-checks today):

```sfn
let n: usize = size_of<InputEvent>();          // 24
let a: usize = align_of<InputEvent>();         // 8
let o: usize = offset_of<InputEvent>("value"); // 20
```

`size_of`/`align_of` accept any sized type. `offset_of` requires a
`@repr(C)` struct and a string-literal field name (Zig's `@offsetOf(T,
"field")`). An unknown field reuses `E0015`. All three lower to constants
computed by the same layout engine that `E0848` uses. For `size_of`, that is
the `getelementptr null, 1` idiom the struct allocator already emits.

**Single layout authority.** The C layout engine is new code in
`compiler/capsules/codegen/src/emit_native_layout.sfn`. It is used **only for
`@repr(C)` structs** and for the builtins, and it is checked against the LLVM
lowering by test. The legacy `.layout` table for non-`@repr(C)` types is
**left unchanged** on purpose. Correcting its 8-byte fallback globally would
change enum aggregate types and payload offsets. Runtime objects compiled by
the pinned seed would then disagree with user objects compiled by the fresh
compiler (see §6 and §5), which is a separate, seed-gated change.

### 3.2 The raw-pointer model

This section adopts **Zig's convention**, because it is the one the code
already uses:

| Spelling | Meaning | Enforcement |
|---|---|---|
| `*T` | read-write raw pointer to `T` | (current behavior) |
| `*const T` | read-only raw pointer | store through it → **`E0852`** |
| `*mut T` | accepted synonym for `*T` | documented as legacy, no diagnostic in v1 |
| `*u8` / `*void` | untyped byte pointer (C `void*`/`char*`) | — |

The following operations are specified, and all of them already work:

- **Deref.** `*p` is a load of `T`. `*p = v` is a store of `T`.
- **Member access through a pointer.** `p.f` with `p: *S` loads or stores
  field `f` at its offset, auto-dereferencing like Zig's `ptr.field`. This is
  the spike's `px.v = …`.
- **Arithmetic.** `p + n` / `p - n` advance by `n * size_of<T>()` bytes,
  which is C semantics. On `*u8`, the step is one byte.
- **Casts.** `p as *U` reinterprets. `p as i64` / `n as *T` convert between
  address and integer. `0 as *T` and the `null` literal are the null pointer.
- **Struct place to pointer.** `s as *S`, where `s` is a struct binding,
  yields the address of that struct's storage (today: the arena-allocated
  block `sfn_alloc_struct` returned, probe `p_cast.sfn`). This is how a
  Sailfin-owned `termios` is handed to `tcgetattr`.
- **`string` to pointer.** `s as *u8` yields the data pointer. It is
  NUL-terminated **only for string literals**. Anything else passed to a C
  `const char*` must be copied with a NUL (library helper, §3.8), because
  SFEP-0033 slices are not NUL-terminated.

**Retention rule** (normative, matching Rust's `as_ptr` borrow discipline): a
pointer into Sailfin-managed storage is valid **only for the duration of the
foreign call it is passed to**. That covers `s as *S`, `str as *u8`, and array
data. Sailfin storage may be arena-backed and reclaimed at phase boundaries
(SFEP-0043). Anything C *retains* must be allocated with `malloc` (or a
`sfn/sys` allocator), such as libdbus `user_data` or an epoll `data.ptr`.
This rule is documented, not enforced, in v1. A future ownership rule can make
passing arena storage to a retaining parameter an error once parameters can
be annotated.

`&raw` is removed from the documentation until it type-checks (it currently
fails `E0818`). `s as *S` covers the struct case, and scalars use a
`malloc`'d slot, which is the existing runtime idiom.

`unsafe { }` keeps its **shipped** meaning, and only that meaning: it is the
author-asserted region for the ownership checker (`E0906`). This SFEP does not
make any pointer operation require `unsafe`. That is a restriction without a
power, and it would churn the ~46 runtime files that do raw-pointer work
outside `unsafe` today.

### 3.3 Calling-convention fidelity

**Variadic externs** use the C and Rust spelling:

```sfn
extern fn ioctl(fd: i32, request: u64, ...) -> i32;
extern fn printf(fmt: *const u8, ...) -> i32;
```

- **Parse.** `...` is permitted only as the last parameter of an `extern fn`
  declaration, after at least one named parameter. Any other placement is
  `E0851`.
- **Lower.** The declaration becomes `declare i32 @ioctl(i32, i64, ...)`, and
  each call site uses the full function type
  `call i32 (i32, i64, ...) @ioctl(…)`. LLVM then applies the right
  per-target variadic convention: registers on AAPCS64 Linux and on the stack
  on Apple arm64. That is exactly the fix the spike needed.
- **Check.** An argument in variadic position must already be a C
  default-promoted type: `i32`, `u32`, `i64`, `u64`, `isize`, `usize`, `f64`,
  or a pointer. `i8`/`i16`/`u8`/`u16`/`bool`/`f32` are `E0851`, with a hint
  to cast explicitly (`x as i32`, `y as f64`). Sailfin has no implicit
  promotion (SFEP-0058), so the author writes the promotion C would have
  inserted silently.

**Narrow-integer extension.** On extern `declare` lines and the matching
calls, the lowering emits `signext` on `i8`/`i16` parameters and returns and
`zeroext` on `u8`/`u16`/`bool`. This matches what clang emits for the same C
prototype on x86-64 SysV and Apple arm64. It is a no-op on AAPCS64 Linux, and
it is what makes `extern fn f(x: u16)` correct on every governed target rather
than only on the Brick.

### 3.4 C→Sailfin: typed function pointers and C-ABI definitions

**Typed callback parameters.** An extern parameter or return of type
`* fn (A, B) -> R` (either formatter spelling, `*fn(` or `* fn (`) is a plain
C function pointer. This is the #1089 spelling the lowering already
dispatches for Sailfin-side indirect calls. Each `A`/`B` must be a C-ABI
parameter type and `R` a C-ABI return type, using the same accept-list as the
extern itself. The bare `fn (A) -> R` form in extern position is **retired**:
outside externs it means a closure pair `{fn, env}`, so admitting it in
externs made one spelling mean two ABIs. No tree source uses it; the formatter
already made it unusable. A bare `fn (A) -> R` in extern position now gets
E0805 with a hint pointing at `* fn`.

**Coercion.** At a call to an extern whose parameter is `* fn (A) -> R`, a bare
reference to a named Sailfin function whose signature is **exactly**
`(A) -> R`, with every type C-ABI-admissible, coerces to its address. No `as`
cast is needed. `E0850` is raised for the following:

- a signature mismatch
- a non-C-ABI signature (a `string` parameter, for example)
- a lambda or closure with captures, which has no env slot in C
- `as *T` applied to a function whose signature is not C-ABI

The existing `name as *u8` (#1146) remains the untyped escape hatch, and the
runtime scheduler keeps using it.

```sfn
extern fn dbus_connection_set_watch_functions(
    conn: *DBusConnection,
    add: * fn (*DBusWatch, *u8) -> u32,
    remove: * fn (*DBusWatch, *u8) -> void,
    toggled: * fn (*DBusWatch, *u8) -> void,
    data: *u8,
    free_data: *u8
) -> u32 ![io];

extern fn on_watch_add(w: *DBusWatch, data: *u8) -> u32 ![io] {
    // runs when libdbus calls back
    return 1;
}
```

**C-ABI definitions.** `extern fn name(params) -> R ![effects] { body }` is an
`extern fn` **with a body**. It is Rust's `extern "C" fn` plus `#[no_mangle]`
in one form, and the function-level twin of the shipped defining
`extern var NAME: T = init` (#1436). It has three properties:

1. **Validated signature.** It uses the same accept-list as extern
   declarations (E0801–E0805, E0803 for type parameters).
2. **Unmangled symbol.** The symbol is exactly `name`, so the remaining C
   code in a gradual port can call a ported module by name through its
   existing vtable, and a C library can call it back. `export extern fn`
   makes it importable by other Sailfin modules. A duplicate definition
   across the link fails at link time in v1.
3. **Abort on unwind.** The body is emitted inside a guard frame
   (`sfn_exception_push_frame` + `setjmp`, the same shape as the generated
   `main`). A Sailfin `throw` or panic that would otherwise `longjmp` across
   C frames instead prints the panic and calls `abort()`. That is Rust's
   behavior for a panic escaping `extern "C"` since 1.81, and the only one
   that cannot corrupt a C library's internal state.

A C-ABI definition is an ordinary Sailfin function inside: effects,
ownership, and type checks all apply to its body against its declared
`![…]`.

### 3.5 Externs and the Reach pillar

This section answers the **owner-level design gate** in decision-brief §7.6
and SFEP-0016 §4.4 Q3. **Owner decision (2026-09-18): accepted as drafted.**
It is kept isolated so that a later revision does not disturb §3.1–§3.4 or
§3.6.

**(a) Effect-attested externs.** `E0804` is retired, and an extern may declare
effects:

```sfn
extern fn connect(fd: i32, addr: *const u8, len: u32) -> i32 ![net];
extern fn clock_gettime(id: i32, ts: *u8) -> i32 ![clock];
extern fn memcpy(dst: *u8, src: *const u8, n: usize) -> *u8 ![];
```

A call to an attested extern contributes its effects to the caller exactly as
a call to a Sailfin function does. So `E0400` (missing effect), `E0402`
(cross-module propagation), `E0403` (capsule manifest cross-check), and
hierarchical sub-effects (SFEP-0017) all apply unchanged. `![]` is an explicit
**attested-pure** claim. An extern with **no** clause is **unattested**: it
contributes no effect, compiles as it does today, and is flagged in the
manifest (b). Attestation is **trusted, not verified**. A lying `![]` on
`connect` compiles, and the manifest shows exactly that claim, next to the
symbol name, for a reviewer.

**The restriction-vs-power test.** `E0804` exists today to *force* a wrapper
function around every extern just to attach effects, which is pure tax.
Lifting it *removes* code. The attestation is the power: one line of `extern`
carries its reach. Nothing new is forbidden.

**(b) The foreign-reach record.** Every build emits, alongside the existing
per-capsule `build/capsules/<scope>/<name>/manifest.json`
(`compiler/src/capsule_artifact.sfn`), an additive `foreign` object:

```json
"foreign": {
  "outbound": [
    {"symbol": "ioctl",   "declared_in": "src/fb.sfn:12", "variadic": true,
     "attested": ["io"]},
    {"symbol": "memcpy",  "declared_in": "src/fb.sfn:15", "attested": []},
    {"symbol": "usleep",  "declared_in": "src/fb.sfn:17", "attested": null}
  ],
  "inbound": [
    {"symbol": "on_watch_add", "defined_in": "src/ble.sfn:40",
     "effects": ["io"]}
  ],
  "link_inputs": ["-lm", "-lpthread", "-ldbus-1", "-lmbedtls"],
  "runtime": {"capsule": "sfn/runtime", "version": "<pinned>",
              "classification": "SFEP-0060 §2.1"}
}
```

- `outbound` covers every extern **referenced** by call, coercion, or `as`
  address in the capsule's sources. It is a conservative superset of the
  reachable set, so it is **complete**. `attested: null` marks unattested.
- `inbound` lists every C-ABI definition (§3.4), because C code can enter the
  program there.
- `link_inputs` is the resolved link argv libraries (build inputs, **not
  provenance**, per the SFN-1269 design note). The runtime's own foreign
  surface is recorded as one versioned entry that points at SFEP-0060's
  classification rather than being re-enumerated.

**The claim this earns:** *the derived manifest is complete: every effect of
Sailfin code is derived, and every edge into or out of foreign code is
enumerated with its attestation.* A reviewer audits a finite, diffable list:
"this release added `connect`, unattested". That is the Reach pillar's
completeness claim, stated honestly over an explicit trust base.

**Claims this does not earn**, and must not be marketed:

- that foreign code is confined
- that attestations are true
- anything above SFEP-0016's **provenance-sealed** tier

A binary with un-digested `link-libs` sits *below* that tier (SFN-1269 design
note §3). A later step can route an *attested* `![net]` extern through the
seal's gate hook (SFEP-0016 §3.4, SFEP-0060 §3.4) so that the attestation is
enforced at runtime. That is **designed here, not shipped, and not phased in
this SFEP.**

**`unsafe` is not an effect.** The `![unsafe]` effect,
`[capabilities] required = ["unsafe"]`, and `[policies.unsafe]` in `ffi.md` are
**withdrawn**:

- `unsafe` is not canonical (`effect_taxonomy.sfn`).
- As designed, it was a restriction without a power: a marker on every caller
  that proves nothing.
- The foreign-reach record supersedes its audit purpose with a *derived*
  artifact instead of an authored annotation.

The workspace-policy idea (`allowed_capsules`) survives as future work keyed
on the record (§9 future considerations).

### 3.6 Inline fixed-size arrays in `@repr(C)` structs

```sfn
@repr(C, size = 80)    // LP64 sizeof(struct fb_fix_screeninfo)
struct FbFixScreeninfo {
    id: [u8; 16];
    smem_start: u64;
    smem_len: u32;
    kind: u32;
    type_aux: u32;
    visual: u32;
    xpanstep: u16;
    ypanstep: u16;
    ywrapstep: u16;
    line_length: u32;   // offset_of = 48, the spike's hand-computed constant
    mmio_start: u64;
    mmio_len: u32;
    accel: u32;
    capabilities: u16;
    reserved: [u16; 2];
}
```

The `[T; N]` spelling is Rust's. It is admitted **only as a field type of a
`@repr(C)` struct**, where `N` is an integer literal and `T` is admissible.
Anywhere else, including a `let` or a parameter type, it is `E0853`, and
`E0830` keeps its existing meaning for malformed `T[]`. There is deliberately
no array *value* type: `[T; N]` has no binding, copy, or pass semantics in
v1.

- **Access.** `s.id[i]` and `p.id[i]` load or store element `i` through
  `getelementptr … i32 0, i32 <field>, i64 i`. A constant index is checked at
  compile time (`E0853`). A dynamic index is bounds-checked at runtime and
  panics like `T[]` indexing.
- **Address.** `s.id as *u8` is the element-0 address, used to hand
  `c_cc`/`id`/`sun_path` to C.
- **Lowering.** The field lowers to an LLVM `[N x T]` member, and the layout
  engine counts `N * size_of<T>()` at `align_of<T>()`.

This is what retires the `i64`-slot workaround (`pthread_layout.sfn`) for new
code, and what lets `termios`, `sockaddr_un`, `fb_fix_screeninfo`, and
MeshClient's own `char name[40]` structs be written as their headers are.

### 3.7 Unions: not required

MeshClient's union-bearing types are `epoll_data_t` and `sockaddr` storage.
Neither needs a union type:

- `epoll_data_t` is an 8-byte, 8-aligned union of `{ptr, fd, u32, u64}`. It is
  modeled as a `u64` field and read with casts (`d as *u8`, `d as i32`), which
  is exactly what C code does after choosing a member.
- `sockaddr` families are distinct `@repr(C)` structs addressed through
  `*u8`/`*SockaddrIn` casts. That is the POSIX idiom (`(struct sockaddr *)&sin`).

`input_event`, `termios`, and the framebuffer structs have no unions. A
union type is deferred until a consumer needs overlapping members of
*different sizes* that cannot be expressed as the largest member plus casts.

### 3.8 The syscall library: a follow-on, not this SFEP and not SFEP-0060

The OS surface (`ioctl` request encoders `_IOR`/`_IOW`, `FBIOGET_*`, `EVIOC*`,
`termios`, `epoll`/`eventfd`/`timerfd`, `sigaction`/`sigaltstack`, `mmap`,
a NUL-terminating `to_c_string`) belongs in a **library capsule**, `sfn/sys`
under `stdlib/sys/`, with a `linux` module first. "Libraries over keywords"
applies: no intrinsic, keyword, or builtin is added for any of it.

It is **not** part of SFEP-0060. That proposal is the runtime-internal
chokepoint: an allowlisted `syscall1…6` builtin reachable from one runtime
module (SFEP-0060 §3.2), whose allowlist is a correctness requirement of the
seal. User-facing bindings must not widen that allowlist. `sfn/sys` binds libc
through **effect-attested** externs (§3.5). Where SFEP-0060 later owns a stub
for a symbol, `sfn/sys` calls the runtime's owned stub instead, so the gate
hook covers it.

It is **not** part of this SFEP, because its API is a design of its own:
`Result`-returning wrappers, `Linear<Fd>` ownership, and per-target struct
modules, since `epoll_event` is packed only on x86_64 and Sailfin has no
`cfg`. It needs its own SFEP and Project, **blocked by** this one's Phases 1–3.

### 3.9 Phasing

Each leaf is one session and one PR, and each self-hosts from the pinned seed.
Every capability is bundled with its own regression tests as its consumer
(`.claude/rules/seed-dependency.md`), so **no leaf creates a seed-cut gate.**

| Leaf | Scope | Blocked by |
|---|---|---|
| **L1** | Reconcile `ffi.md`, `spec/06-types.md:125-127`, and the stale comments in `extern_abi.sfn:22-42` and `filesystem.sfn:844-847` with shipped reality: mark `@repr(C)` as planned (link this SFEP), withdraw `![unsafe]`/`[policies.unsafe]`, drop `&raw`, and document the accepted extern widths. | — |
| **L2** | `@repr(C)` validator + C layout engine + `packed` + `size`/`align` assertions + `size_of`/`align_of`/`offset_of` (E0846–E0848) | — |
| **L3** | Pointer model: `*const T` store rejection (E0852); spec of deref, member access, arithmetic, and casts; the retention rule | — |
| **L4** | Calling-convention fidelity: variadic externs (E0851) + `signext`/`zeroext` | — |
| **L5** | Typed `* fn` extern parameters + named-function coercion (E0850) | — |
| **L6** | C-ABI definitions: `extern fn … { body }`, unmangled, abort-on-unwind | L5 |
| **L7** | Effect-attested externs: E0804 retired, `![]` vs. no clause | owner decision on §3.5 |
| **L8** | Foreign-reach record in `manifest.json` | L6, L7 |
| **L9** | `[T; N]` inline arrays in `@repr(C)` structs (E0853) | L2 |

L1 lands first because it removes documentation of unshipped features, which
`CLAUDE.md` forbids today. Every later leaf extends
`reference/spec/13-foreign-interface.md` and keeps `ffi.md` truthful.

## 4. Effect & capability impact

- **Effect checker.** Externs enter the callee-signature index that
  `compiler/capsules/analyzer/src/effect_checker/collector.sfn` builds, so an
  attested extern call is indistinguishable from a Sailfin call. An unattested
  extern contributes nothing, as today. Declared effects on C-ABI definitions
  are checked against their bodies like any function.
- **Canonical effects.** Unchanged: `clock, gpu, io, model, net, rand`. No
  `unsafe`, `ffi`, or `foreign` effect is added. §3.5 explains why a derived
  record beats an authored effect.
- **Capsule manifest.** `E0403` now sees attested extern effects
  transitively. A capsule whose externs attest `![net]` must declare `net` in
  `[capabilities] required`, which closes the "`extern` bypasses the manifest"
  half of the hole *for attested externs*.
- **Seal (SFEP-0016).** There is no change to the claim ladder. The
  foreign-reach record is **input** to the seal: it enumerates what the
  `vetted-link-inputs` rule (SFEP-0016 §3.5, unimplemented) will later
  digest-check. Nothing here upgrades any tier.
- **Owner gate.** §3.5 is the proposed resolution of decision-brief §7.6
  ("Is `extern` capability-typed, forbidden in untrusted units, or something
  else?"). The answer is **capability-attested + derived-enumerated**. This
  SFEP must not move to `Accepted` without the owner's explicit call on §3.5.
  If the owner rejects it, only leaves L7 and L8 (§8.2) change.
- **Honest wording until L7 and L8 ship.** "Extern calls are invisible to the
  effect system and not enumerated." After they ship: "Every foreign edge is
  enumerated with its author attestation; attestations are trusted, not
  verified."

## 5. Self-hosting impact

**Passes touched**

| Stage | Change | Section |
|---|---|---|
| Parser (`compiler/capsules/syntax/src/`) | `...` in extern params; `extern fn` with a body; `[T; N]` field type; `* fn (…)` already parses | §3.3, §3.4, §3.6 |
| AST (`ast.sfn`) | `FunctionSignature.variadic: boolean`; `ExternFunctionDeclaration` gains `body: Block?`; an explicit-empty-effects flag so `![]` is distinguishable from no clause. **Structural: needs `--clean-tree`.** | §3.3–§3.5 |
| Typecheck (`analyzer/src/typecheck_types/extern_abi.sfn`, `declaration_and_statement_checks.sfn`, a new `repr_c.sfn`) | accept-list for `* fn`, E0804 retirement, E0846–E0853, builtin typing | all |
| Effect checker (`analyzer/src/effect_checker/collector.sfn`, `analyzer.sfn`) | externs in the signature index | §3.5 |
| Native IR (`codegen/src/emit_native_layout.sfn`, `emit_native.sfn`) | C layout engine for `@repr(C)`; `.layout` agrees with LLVM for those structs; variadic/definition markers | §3.1, §3.3, §3.4 |
| LLVM lowering (`codegen-llvm/src/type_context.sfn`, `expression_lowering/native/core_call_lowering.sfn`, `core_expression_tail.sfn:312`, `lowering/lowering_helpers.sfn` declare tracking, the mangling post-pass) | packed types; `[N x T]` members; variadic declare/call; `signext`/`zeroext`; `* fn` coercion; unmangled guarded definitions; builtin constants | §3.1–§3.6 |
| Build (`compiler/src/capsule_artifact.sfn`) | `foreign` object in `manifest.json` | §3.5 |

**Invariant.** Every capability is consumed only by tests, examples, and user
capsules, all compiled by the *freshly built* compiler. No compiler-source or
runtime-source file adopts a new construct in the same PR. So each leaf
self-hosts from the current pinned seed with no seed cut
(`.claude/rules/seed-dependency.md`: bundle capability with consumer; here the
consumer is the leaf's own regression tests).

**The runtime carve-out, stated so nobody trips on it.** The pinned seed
compiles `runtime/`. Runtime source may adopt a construct only after a seed
that understands it is pinned. Each adoption is a separate, later change:

- `[T; N]`: the seed rejects it with E0830.
- extern `...`: the seed gives a parse error.
- extern-with-body: the seed gives a parse error.
- `size_of`: the seed has no such builtin.
- attested externs: the seed rejects them with E0804.

The one exception is `@repr(C)` itself. The seed parses and ignores struct
decorators, so annotating `runtime/sfn/platform/pthread_layout.sfn` structs is
seed-safe at any time, but it earns nothing until the validator runs. No leaf
below requires runtime adoption.

**Two hazards held out of scope deliberately:**

1. **Correcting the legacy `.layout` 8-byte fallback for non-`@repr(C)`
   types.** That would change enum aggregate LLVM types and payload offsets.
   Seed-compiled runtime objects and fresh-compiled user objects would then
   disagree on any enum crossing that boundary, a cross-seed ABI break. The
   fix is real, but it is its own seed-gated change and not a prerequisite
   here.
2. **Rewriting the runtime's hand-declared `*u8`-typed callbacks to
   `* fn`.** This is cosmetic and gated on the seed.

## 6. Alternatives considered

- **Make the incidental layout the contract without `@repr(C)`** ("all structs
  are C-layout"). Rejected. It forecloses every future layout optimization
  (field reordering, niche packing) for all Sailfin code, just to serve the
  subset that crosses FFI. Rust, Swift, and Zig (`extern struct`) all
  separate the two. SFEP-0075 is already re-deciding struct semantics, and
  pinning layout globally would couple it to FFI.
- **Zig's `extern struct` keyword instead of a decorator.** Rejected. It adds
  a keyword ("libraries over keywords"), and `@repr(C)` is already the
  documented spelling users and agents will reach for. Decorator arguments
  (`packed`, `size = N`) are named-argument syntax that already parses
  (`DecoratorArgument.name`).
- **A `pointer_write_*` intrinsic family** (the store half the
  `filesystem.sfn` comment asks for). Rejected: `*p = v` and `p.f = v` already
  lower to correct stores. Intrinsics would be a second spelling of the same
  thing.
- **Rust's `*const T`/`*mut T` with `*T` meaning const.** Rejected. It
  inverts the meaning of every existing runtime `*T` write and forces a
  tree-wide churn with a seed gate. Zig's `*T` / `*const T` matches what the
  code already does.
- **Require `unsafe` for pointer operations and extern calls.** Rejected. It
  is a restriction with no power attached (decision-brief §3). It would also
  be a large runtime churn and seed-gated.
- **A new canonical effect (`![ffi]` or `![unsafe]`) on every extern
  caller.** Rejected. It is authored rather than derived, it propagates
  through every caller of `memcpy`, and it tells a reviewer less than the
  enumerated symbol list does. It fails the restriction-vs-power test.
- **Forbid externs outside allowlisted modules** (SFEP-0060-style). Rejected
  for user code. A gradual C port is thousands of externs across the tree. The
  allowlist model is right for the one module that can issue raw syscalls and
  wrong for the library boundary.
- **Keep `E0804` and require wrappers** (status quo). Rejected. Wrappers are
  boilerplate, they are not enumerated anywhere, and an unwrapped extern is
  still invisible. That is the hole decision-brief §7.6 names.
- **By-value struct passing across externs.** Deferred, and out of scope. It
  needs per-ABI classification (SysV eightbytes, AAPCS64 HFA/HVA, Windows
  x64 ≤8-byte rule), and SFEP-0075 keeps struct transport at `%T*`. Every
  MeshClient surface passes structs by pointer (ioctl, termios, epoll,
  sigaction, dbus, mbedTLS, nanopb). E0805 continues to reject by-value struct
  parameters with a clear message.
- **Header import / bindgen.** Deferred as future work (§9). It is the right
  answer for the libdbus and mbedTLS surfaces at scale, but it needs a C
  parser (or libclang, which is a foreign toolchain dependency SFEP-0066
  would have to admit). Hand-written bindings over a checked layout contract
  come first.

## 7. Stage1 readiness mapping

Each box is ticked per leaf. The SFEP is `Implemented` only when all leaves are.

- [ ] **Parses.** `@repr(C, …)` already parses. `...`, extern-with-body, and
      `[T; N]` land in L4, L6, and L9. `* fn` extern types already parse.
- [ ] **Type-checks / effect-checks.** Every construct: E0846–E0853, the E0805
      hint update, E0804 retirement, and extern effect propagation.
- [ ] **Emits valid `.sfn-asm`.** `@repr(C)` `.layout` agrees with LLVM, and
      variadic/definition markers are present.
- [ ] **Lowers to LLVM IR.** Packed, `[N x T]`, variadic call types,
      `signext`/`zeroext`, guarded unmangled definitions, and builtin constants.
- [ ] **Regression coverage** (§8).
- [ ] **Self-hosts.** Per leaf, `sfn dev bootstrap build`. The AST-shape leaves
      (L4, L6, L7, L9) use `--clean-tree`.
- [ ] **`sfn fmt --check` clean.** The formatter round-trips `...`,
      extern-with-body, `* fn (…)`, `[T; N]`, and `@repr(C, size = N)`.
- [ ] **Documented in the spec chapter.** A new
      `reference/spec/13-foreign-interface.md` is grown per leaf.
      `advanced/ffi.md` is reconciled in L1 and kept truthful by every leaf.
      `spec/06-types.md:125-127` is corrected in L2.

## 8. Test plan

### 8.1 Tests

All tests are Sailfin `*_test.sfn` files. There are no bash scripts
(`.claude/rules/no-bash-e2e.md`). C sides use `run_external_c_oracle` from
`sfn/test` (`capsules/sfn/test/src/external_c_oracle.sfn`), which skips when
no C compiler resolves. Tests that spawn builds thread `SAILFIN_TEST_SCRATCH`
and `PATH`.

**Unit** (`compiler/tests/unit/`):

- `ffi_repr_c_validation_test.sfn`:
  - E0846: `@repr(c)`, `@repr(C)` on an enum, and on a generic struct
  - E0847: a field of each rejected kind, including `bool`
  - E0848: a deliberate `size = 20` on `InputEvent`, with the message
    carrying the computed offsets
  - clean acceptance of the nested-struct, pointer, `* fn`, and `f16` fields
- `ffi_extern_abi_test.sfn`:
  - `* fn (…)` accepted in both spellings
  - bare `fn (…)` rejected with the new hint
  - E0851 variadic placement and promotion
  - E0850 coercion mismatch, closure, and non-C signature
  - E0852 store through `*const T`
  - E0853 `[T; N]` outside `@repr(C)`, and a constant out-of-range index
- `ffi_extern_effects_test.sfn`:
  - an attested `![net]` extern called from a non-`![net]` function gives E0400
  - `![]` versus no clause is distinguishable in the analyzed program
  - E0403 fires for an attested effect absent from `[capabilities]`
- Update `numeric_low_precision_test.sfn` only if the E0805 hint text
  assertions depend on the changed message.

**Integration** (`compiler/tests/integration/`):

- `ffi_layout_builtins_test.sfn`: `size_of`/`align_of`/`offset_of` for
  `InputEvent` (24/8/20), a packed `EpollEvent` (12/1), `FbFixScreeninfo` with
  `id: [u8; 16]` (`offset_of("line_length") == 48`, the spike's
  hand-computed constant), and nested structs.
- `ffi_pointer_model_test.sfn`: deref load/store, `p.f = v` through `*S`,
  element-scaled `+`/`-` on `*i32`/`*i64`/`*u8`, and `s as *S` round-trip
  through `memset`.

**E2E** (`compiler/tests/e2e/`):

- `ffi_repr_c_c_oracle_test.sfn`. This is the layout acceptance test. It
  writes a C harness that prints `sizeof`/`offsetof` for mirrors of
  `InputEvent`, `FbFixScreeninfo`, `termios`-shaped `{u32×4, u8, [u8;32], u32×2}`,
  and a packed struct. The Sailfin program prints `size_of`/`offset_of` for
  the same types, and the test asserts the outputs are identical. A second
  leg builds the C side into a static archive linked via root
  `[build] link-libs`. C fills a `@repr(C)` struct through a pointer, and
  Sailfin reads every field back (plus the reverse direction).
- `ffi_variadic_test.sfn`: Sailfin calls a C harness `int sum_va(int n, ...)`
  with mixed `i32`/`i64`/`f64`/pointer variadic arguments, and `snprintf`.
  This runs on macOS arm64 **and** Linux. The macOS leg is the one that
  fails today under a fixed-arity declaration.
- `ffi_narrow_int_abi_test.sfn`: C harness functions taking and returning
  `int8_t`/`uint16_t`, called with boundary values (`-128`, `65535`).
  Compiled at `-O2` so the callee relies on caller extension.
- `ffi_callback_test.sfn`:
  - `qsort` with a Sailfin comparator passed as a bare name to a
    `* fn (*const u8, *const u8) -> i32` parameter
  - a C harness registering and later invoking a watch-style
    `(*u8, *u8) -> u32` callback (the libdbus shape)
  - a C `main` calling an unmangled `extern fn sfn_core_tick(…)` definition
    by name (the gradual-port direction)
  - a definition whose body throws, which must `abort` (asserted by exit
    signal) and never return into C
- `ffi_foreign_manifest_test.sfn`: builds a capsule with attested,
  explicitly pure, and unattested externs, one C-ABI definition, and a
  `link-libs` entry. It asserts the `foreign` object in
  `build/capsules/<scope>/<name>/manifest.json`, with byte-stable field
  order.
- **Cross-target smoke**, folded into `ffi_repr_c_c_oracle_test.sfn` as a
  best-effort leg. `sfn emit llvm --target aarch64-unknown-linux-gnu` of the
  layout fixture must show the same `[N x T]` and packed types as the host.
  This proves target invariance without a device.

### 8.2 Verification commands per leaf

```bash
build/bin/sfn check <touched .sfn files>
sfn dev bootstrap build          # add --clean-tree for L4, L6, L7, L9 (AST shape)
build/bin/sfn test compiler/tests/unit/ffi_repr_c_validation_test.sfn
build/bin/sfn test compiler/tests/e2e/ffi_repr_c_c_oracle_test.sfn
build/bin/sfn test compiler/tests/e2e/ffi_callback_test.sfn -k "abort"
sfn fmt --check <touched files>
```

`sfn dev verify` runs once, when the last leaf lands.

**Device acceptance** (manual, owner). Rewrite `fbspike.sfn` against the
contract: `@repr(C, size = 160) struct FbVarScreeninfo`, `offset_of` instead
of `+ 48`, and a variadic `ioctl`. Cross-build with
`sfn build --target aarch64-unknown-linux-gnu` and run it on the Brick. This
is recorded on the final leaf, not automated.

## 9. References

**SFEPs**

- SFEP-0016: capability-sealed runtime (claim ladder, §3.4–3.5 link
  provenance, §4.4 Q3)
- SFEP-0017: hierarchical effects
- SFEP-0023: capsule decorators (decorator surface)
- SFEP-0025: native runtime architecture (§3.6 extern lowering)
- SFEP-0033: length-aware string ABI (why `str as *u8` is not a C string)
- SFEP-0043: phase-scoped arena reclamation (the retention rule)
- SFEP-0056: aarch64 Linux target
- SFEP-0058: sized integers (no implicit promotion)
- SFEP-0060: owned syscall layer (§2.2 holes, §3.2 allowlist)
- SFEP-0066: governed targets
- SFEP-0067: platform-access ownership
- SFEP-0068: cross-target builds
- SFEP-0075: struct value semantics (transport stays `%T*`)

**Issues and PRs**

- #286 (Slice C widths), #1089 (plain C fn pointers), #1146 (fn reference →
  address), #1436 (defining `extern var`)
- SFN-571, SFN-575 (narrow-int call boundary), SFN-630
- SFN-1268 (`--static`), SFN-1269 (root `link-libs`, plus design note
  `docs/proposals/design-notes/sfn-1269-link-libs-build-input-not-provenance.md`),
  SFN-1287 (per-target sysroot)

**Strategy**

- `docs/strategy/decision-brief.md` §3 (restriction-vs-power), §4 Pillar 1,
  §7.6 (the `extern` gate), §10

**Docs**

- `site/src/content/docs/docs/advanced/ffi.md`
- `reference/spec/06-types.md`
- `reference/preview/unsafe-enforcement.md`

**Prior art**

- Rust: `#[repr(C)]`, `#[repr(packed)]`, `extern "C" fn`, `#[no_mangle]`,
  `core::mem::{size_of, align_of, offset_of!}`, abort-on-unwind at
  `extern "C"` (1.81)
- Zig: `*T`/`*const T`, `extern struct`, `packed struct`, `@sizeOf`,
  `@offsetOf(T, "f")`, `callconv(.C)`
- C11: `offsetof`, default argument promotions (§6.5.2.2)

**Future considerations** (not phased)

- A `sfn/sys` capsule SFEP (§3.8).
- Header import / bindgen.
- By-value struct passing.
- `cfg`-style target-conditional declarations, for per-target struct
  variants.
- A workspace policy keyed on the foreign-reach record: `[policies.foreign]`
  allowlists of symbols or libraries per capsule, which is the surviving form
  of `ffi.md`'s `[policies.unsafe]`.
- Routing attested externs through the seal's gate hook.
- Correcting the legacy non-`@repr(C)` `.layout` fallback under a seed cut.
- Admitting `bool` in `@repr(C)` via `i8` storage.
- Union types, if a consumer appears.
