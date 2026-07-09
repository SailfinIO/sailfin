# SFN-154 — Production-grade typed returns for `io.read_fd` / `io.read_line`

Single-issue implementation design gate (per `.claude/rules/proposals.md`:
this is a bounded retype of two already-shipped builtins, not a forward-looking
language/runtime design — no full SFEP). Design record for the one PR that
lands SFN-154.

- **Issue:** SFN-154
- **Author:** agent:compiler-architect
- **Status:** design-approved (decision made upstream; this is the plan)
- **Depends on pinned seed:** nothing new (see §Self-hosting)
- **Delivers an SFEP:** none — there is no `io`-read SFEP to graduate
  (`docs/proposals/README.md` registry has no matching row). This note is the record.

---

## 1. Goal

Upgrade the two shipped stdin builtins from stringly-typed returns to
production-grade typed returns with Rust/Go parity: `io.read_fd(fd, n)` returns
an owned, length-explicit, binary-safe `OwnedBuf` (== `Vec<u8>` / `[]byte`), and
`io.read_line(fd)` returns `string?` where `null` == EOF (== Rust `Ok(0)` / Go
`io.EOF`) and `Some("")` == a genuine blank line.

## 2. Current state

- `runtime/sfn/io.sfn:153-164` — `fn sfn_read_fd(fd: i64, n: i64) -> * u8 ![io]`:
  single `read(2)` of ≤ `n` bytes into a fresh `malloc(n+1)` NUL-terminated
  buffer; `n<=0`/OOM/EOF/error → `_sfn_shell_empty()` (`""`).
- `runtime/sfn/io.sfn:177-204` — `fn sfn_read_line(fd: i64) -> * u8 ![io]`:
  byte-at-a-time `read(2)` to newline (stripped) or EOF; immediate EOF returns
  `""`. Cannot distinguish EOF from a blank line today.
- `compiler/src/llvm/runtime_helpers.sfn:885-890` — descriptors:
  `io.read_fd` (`return_type "i8*"`, params `["i64","i64"]`, `effects ["io"]`,
  `symbol sfn_read_fd`) and `io.read_line` (`return_type "i8*"`, params
  `["i64"]`, `symbol sfn_read_line`).
- `compiler/src/llvm/lowering/lowering_helpers.sfn:1504-1505` — both declare-tracked.
- `compiler/tests/integration/io_read_fd_test.sfn` (pipe-driven; asserts
  `io.read_fd(...) == "abc"` / `io.read_line(...) == "hello"`) and
  `compiler/tests/e2e/io_read_fd_effect_test.sfn` (E0400 without `![io]`).
- `docs/status.md:416` documents both as `-> string`, **Shipped** (#1579).
- **No consumers.** `login.sfn` still uses the `sh -c "head -1"` hack (status.md:416
  notes retiring it waits on a seed cut). Blast radius of the retype = these two
  test files + the two descriptor rows + the two runtime bodies.

### The typing mechanism (crux #1, resolved)

Member-builtin calls (`io.X(...)`) are **not typed in `typecheck.sfn`** — the
`Member` arm of `walk_expression` returns `[]` for an `Identifier`-object receiver
(`typecheck.sfn:1337-1348`), so `io.read_fd(...) == "abc"` and
`return io.read_line(0)` pass purely because the walker never checks the result
type. The result's LLVM type is set **only at lowering**, in
`resolve_call_signature` (`compiler/src/llvm/expression_lowering/native/core_call_resolution.sfn:1630-1633`):
for a runtime-helper descriptor with no matching function entry,
`llvm_return = descriptor.return_type` **verbatim** (no `map_return_type` pass).
So the "type" of a member-builtin result is exactly its descriptor
`return_type` string, plus whatever the call site's explicit `let`-annotation
records.

Two facts flow from this:

- **`string?` is a nullable `i8*`, null = None** (`type_mapping.sfn:471`;
  `map_optional_type` returns `i8*` for `string?`). The `io.read_line` descriptor
  `return_type "i8*"` is **already** the `string?` ABI — no descriptor change is
  needed; the null-vs-empty distinction is delivered entirely by the runtime body.
- **A user struct crosses boundaries as a boxed `%OwnedBuf*`** (heap-allocated,
  8-byte pointer), *not* by value/sret (`type_mapping.sfn:682-704`:
  `map_return_type("OwnedBuf")` → `info.llvm_name + "*"` = `%OwnedBuf*`). This is
  the same descriptor-carryable shape as `process.environ`'s `{ i8**, i64, i64 }*`
  return (`runtime_helpers.sfn:857`). So a descriptor **can** carry an `OwnedBuf`
  return by setting `return_type = "%OwnedBuf*"`.

**Field access needs an explicit annotation.** `let b = io.read_fd(...)` records
no Sailfin type — `instructions_let.sfn:685-701` only adopts a callee return type
via `find_function_by_name_or_import`, which never matches a descriptor
member-builtin. So `b.len` / `owned_buf_free(b)` resolve only when the call site
writes `let b: OwnedBuf = io.read_fd(...)`; the annotation gives the binding the
`%OwnedBuf*` alloca and the field-name→index map. This is the one ergonomic cost,
and it matches how you'd bind a `Vec<u8>` anyway.

## 3. Constraints

- **Self-hosting:** touches `compiler/src/llvm/runtime_helpers.sfn` (descriptor)
  and `runtime/sfn/io.sfn` (runtime body, linked into every build). Not structural
  (no file split, no new module, no renamed export) → plain `make compile` from the
  pinned seed, no `make clean-build`.
- **No compiler-source consumer.** `login.sfn` does not call these builtins, so the
  retyped ABI is never consumed by the compiler itself → no seed-cut gate
  (SFEP-0026 / `.claude/rules/seed-dependency.md`): capability + its only
  consumers (the two tests) land in **one PR**.
- **#1283 runtime-sfn-source struct-return** (status.md:309, `string.sfn:36-55`):
  the isolated runtime-sfn emit path historically could not resolve a *cross-module
  struct-returning call*. `sfn_read_fd` **constructs** `OwnedBuf` via a struct
  literal (no cross-module struct-returning *call*) and only needs the `OwnedBuf`
  *type* in scope, so this constraint does not bite — and inlining the struct
  (below) removes any dependency on #1288's sibling-`.sfn-asm` staging entirely.
- **#306 inline-extern discipline** (io.sfn:78-84): any libc/type surface used by a
  runtime-sfn-source must be declared *inline*, not imported. `read`/`malloc`/`free`/
  `realloc`/`memset` are already inline; `read_fd` needs **no new extern** (it reads
  directly into the buffer — no `memcpy`).
- **`read_line` byte-at-a-time is correctness-mandated** — must not over-read past
  `\n` on a shared streamed fd. Buffering stays out of scope (future `io.Reader`).

## 4. Design

### 4.1 `io.read_fd(fd, n) -> OwnedBuf` (crux #2, #3 resolved)

**No wrapper capsule.** The runtime body + descriptor carry the typed return
directly, justified by the mechanism in §2: `OwnedBuf` crosses as a boxed
`%OwnedBuf*` — a plain pointer the descriptor carries exactly like
`process.environ`'s `{...}*`. A `sfn/io` capsule wrapper (the `sfn/os` shape) is
**not** warranted: `io.*` has no capsule surface, and the boxed-pointer ABI means
the descriptor already delivers the typed result; a wrapper would add a module and
an import for zero ABI benefit.

**`OwnedBuf` visibility (crux #2):** inline the struct in `runtime/sfn/io.sfn`,
mirroring `sfn/os` (`mod.sfn:77`) and io.sfn's own inline-extern discipline. This is
the conservative choice — self-contained across every seed, no #1288 dependency:

```sfn
// Layout MUST match runtime/sfn/memory/ownedbuf.sfn (32 bytes, four i64
// slots); arena_addr == 0 == libc-backed. Inlined per the #306 discipline
// this file already follows for its externs.
struct OwnedBuf {
    ptr_addr: i64;
    len: i64;
    cap: i64;
    arena_addr: i64;
}
```

**Body** (replaces `sfn_read_fd`, io.sfn:153-164). Owned, length-explicit,
binary-safe, no NUL-terminate; `len` from `read(2)`; empty/EOF/error/`n<=0` →
canonical empty `OwnedBuf {0,0,0,0}` (len==0 is the EOF/empty signal, matching
`sfn/os::handle_read_bytes_stdout`):

```
fn sfn_read_fd(fd: i64, n: i64) -> OwnedBuf ![io] {
    empty := OwnedBuf { ptr_addr: 0, len: 0, cap: 0, arena_addr: 0 };
    if n <= 0            -> return empty
    buf := malloc(n)     // no +1; not NUL-terminated
    if buf == 0          -> return empty
    got := read(fd, buf, n)
    if got <= 0          -> free(buf); return empty     // EOF or error
    return OwnedBuf { ptr_addr: buf, len: got, cap: n, arena_addr: 0 }
}
```

**Descriptor** (`runtime_helpers.sfn:885-887`): flip `return_type "i8*"` →
`"%OwnedBuf*"`. Invariant: the descriptor string must equal
`map_return_type(context, "OwnedBuf")` (`%OwnedBuf*`) so the emitted
`declare %OwnedBuf* @sfn_read_fd(i64, i64)` matches the
`define %OwnedBuf* @sfn_read_fd(...)` the `-> OwnedBuf` body lowers to. If the
struct registry mangles `OwnedBuf`'s `llvm_name` differently under separate
compilation, use whatever `map_return_type` yields — the invariant is
descriptor == `map_return_type` output, not a hard-coded spelling.

**Declare-tracking:** `io.read_fd` is already in the tracked set
(`lowering_helpers.sfn:1504`); no list change. Modules that reference `%OwnedBuf`
but don't fully define it get `%OwnedBuf = type opaque` from the renderer
(`rendering.sfn:701-733`), which is valid for a pointer; the *field-accessing*
module (which annotates `let b: OwnedBuf`) always has the full definition.

**Call site:** `let b: OwnedBuf = io.read_fd(fd, n); ... b.len ... ; owned_buf_free(b)`.
The annotation is required (§2) and any real consumer inlines/imports `OwnedBuf`
anyway to name, read, and free the buffer.

### 4.2 `io.read_line(fd) -> string?`

Keep the `fd` parameter (fd 0 == `read_line(0)`; matches call sites and the
Rust/Go idiom — do not adopt the spec's no-arg form). **No descriptor change**:
`return_type "i8*"` already is the `string?` ABI (null = None). The change is
entirely in the body: distinguish EOF from a blank line by the **first** `read(2)`.

**Body** (replaces `sfn_read_line`, io.sfn:177-204). Keep the return type spelled
`* u8` (== nullable `i8*` == `string?` at the ABI); return `0 as * u8` (None) on
immediate EOF, a real buffer (possibly `""`) otherwise:

```
fn sfn_read_line(fd: i64) -> * u8 ![io] {          // * u8 == string? repr
    scratch := malloc(8)
    if scratch == 0 -> return 0 as * u8            // error → None
    first := read(fd, scratch, 1)
    if first <= 0   -> free(scratch); return 0 as * u8   // immediate EOF → None
    first_b := load_i32(scratch) & 255
    buf := malloc(128); cap := 128; len := 0
    if buf == 0     -> free(scratch); return 0 as * u8
    // first_b == '\n' (10): blank line — len stays 0, fall through to Some("")
    if first_b != 10:
        append first_b to buf (memset 1 byte); len = 1
        loop:
            n := read(fd, scratch, 1)
            if n <= 0 -> break                     // EOF-after-bytes: final unterminated line
            b := load_i32(scratch) & 255
            if b == 10 -> break                    // newline: stop, don't over-read
            grow buf if len+1 >= cap (realloc *2; break on OOM)
            append b; len += 1
    free(scratch)
    memset(buf + len, 0, 1)                         // keep NUL for string compat
    return buf                                      // Some(line); "" for a blank line
}
```

The single up-front `read(2)` is the only structural change from today's loop; it
never over-reads past `\n` (still byte-at-a-time), preserving the streamed-fd
correctness the current body guarantees. `first_b`/`b` are recovered via the
existing `sailfin_intrinsic_pointer_read_i32` + `& 255` idiom and appended with a
single-byte `memset` (no i8 store builtin), unchanged.

**Semantics table (parity):**

| Input at `fd`        | Result        | Rust/Go analogue        |
|----------------------|---------------|-------------------------|
| immediate EOF        | `null`        | `Ok(0)` / `io.EOF`      |
| `"\n"` (blank line)  | `Some("")`    | `Ok(1)`, buf `""`       |
| `"x\n"`              | `Some("x")`   | line, newline stripped  |
| `"tail"` then EOF    | `Some("tail")`| final unterminated line |

**Call site:** `let line: string? = io.read_line(fd); if line == null { ...EOF... }`.
Under the permissive walk this typechecks; at lowering `== null` is a pointer-to-0
compare on the descriptor's `i8*`, and a non-null value is usable as a `string`.

## 5. Migration plan (each step self-hosts)

Single PR (bundle — §3). Ordered so the tree is green at commit:

1. **Runtime bodies + descriptor together** (`runtime/sfn/io.sfn` +
   `runtime_helpers.sfn`): inline `OwnedBuf`; rewrite `sfn_read_fd` → `-> OwnedBuf`;
   flip `io.read_fd` descriptor `return_type` → `%OwnedBuf*`; rewrite
   `sfn_read_line` for null-on-EOF (descriptor untouched). Body and descriptor must
   change atomically (the `-> OwnedBuf` define and the `%OwnedBuf*` declare must
   agree). `make compile` from the pinned seed builds the new compiler and relinks
   the new io.sfn body in one pass.
2. **Tests + docs** (`io_read_fd_test.sfn`, `io_read_fd_effect_test.sfn`,
   `docs/status.md`): retarget assertions to the typed returns (§7). Must land in
   the **same PR** — the suite exercises the retyped ABI, so splitting would leave a
   red suite between merges.

No intermediate state ships a compiler that self-hosts differently; the retype is
invisible to the compiler's own source (no consumer).

## 6. Files affected (by pipeline stage)

| Stage | File | Change |
|---|---|---|
| Runtime body | `runtime/sfn/io.sfn` | Inline `struct OwnedBuf`; rewrite `sfn_read_fd` (153-164) → `-> OwnedBuf`; rewrite `sfn_read_line` (177-204) for null-on-EOF; update the two block comments (144-152, 166-176). No new extern. |
| Descriptor (LLVM) | `compiler/src/llvm/runtime_helpers.sfn` | `io.read_fd` row (886): `return_type "i8*"` → `"%OwnedBuf*"`; update the #1579 block comment (875-890) to state the typed returns. `io.read_line` row (889): unchanged `return_type`, comment update only. |
| Declare-tracking | `compiler/src/llvm/lowering/lowering_helpers.sfn` | None (both already tracked, 1504-1505); verify only. |
| Typecheck / effect | — | No change — member-builtins stay permissive; `![io]` effect gate unchanged. |
| Tests | `compiler/tests/integration/io_read_fd_test.sfn` | Inline `OwnedBuf` + `extern fn free`; `OwnedBuf`-typed read_fd assertions; new EOF-null and blank-line read_line tests. |
| Tests | `compiler/tests/e2e/io_read_fd_effect_test.sfn` | Update `_read_fd_fixture` to the `OwnedBuf` shape (still non-`![io]` → E0400). |
| Docs | `docs/status.md` | Rewrite line 416 to the typed returns. |

## 7. Regression-test plan

`io_read_fd_test.sfn` (add inline `struct OwnedBuf {...}` and
`extern fn free(ptr: * u8) -> void;`):

- **read_fd exact read:** `let b: OwnedBuf = io.read_fd(read_fd as i64, 3);`
  → `assert b.len == 3;` then binary-compare via the `load_byte` builtin
  (`byte_load.sfn`) against literal codes: `assert load_byte(b.ptr_addr) == 97;`
  (`'a'`), `== 98` (`'b'`), `== 99` (`'c'`); then `free(b.ptr_addr as * u8);`.
  Use literal byte codes (not `char_code`) to avoid a prelude dependency.
- **read_fd short read:** `let b: OwnedBuf = io.read_fd(read_fd as i64, 16);` after
  writing `"hi"` + closing the write end → `assert b.len == 2;`, byte-compare
  `104`/`105`, `free`.
- **read_line successive lines / unterminated final:** keep the two existing
  string-compare tests (`== "hello"`, `== "world"`, `== "tail"`) — a non-null
  `string?` compares to a `string` unchanged.
- **NEW — read_line EOF returns null:** open a pipe, `close(write_fd)` before any
  write, `assert io.read_line(read_fd as i64) == null;`. This is the load-bearing
  new coverage for the EOF/blank-line distinction.
- **NEW — read_line blank line returns `""` not null:** write `"\n"`, then
  `let ln = io.read_line(read_fd as i64); assert ln != null; assert ln == "";`.

`io_read_fd_effect_test.sfn`: change `_read_fd_fixture` to inline `OwnedBuf` and
`fn reader() -> int { let b: OwnedBuf = io.read_fd(0, 16); return b.len; }`
(missing `![io]` → E0400; `sfn check` never lowers, so no ABI concern). Leave
`_read_line_fixture` as-is (`return io.read_line(0)` from a `-> string` fn still
misses `![io]` → E0400).

## 8. `docs/status.md` change

Rewrite line 416. New text (shape): `io.read_fd` / `io.read_line` stdin builtins —
**Shipped** (#1579; typed returns SFN-154) — `io.read_fd(fd, n) -> OwnedBuf` (owned,
length-explicit, binary-safe; `len` from one `read(2)` of ≤ n bytes; empty/EOF/error/
`n<=0` → canonical `{0,0,0,0}`) and `io.read_line(fd) -> string?` (byte-at-a-time to
the next newline, no over-read; `null` == EOF, `Some("")` == blank line). Descriptor
`io.read_fd` returns the boxed `%OwnedBuf*`; `io.read_line` stays `i8*` (== nullable
`string?`). Call sites bind `let b: OwnedBuf = io.read_fd(...)` for `.len`/free. Pinned
by `io_read_fd_test.sfn` (incl. the EOF-null and blank-line cases) +
`io_read_fd_effect_test.sfn`. Retiring `login.sfn`'s `sh -c "head -1"` still waits on
a seed cut.

## 9. Slice decomposition (model routing)

- **Slice A — runtime bodies + descriptor (novel/subtle; keep on Opus or a careful
  implementer against this exact spec).** The `sfn_read_line` first-`read(2)`
  restructure (null-on-immediate-EOF, `Some("")` on `"\n"`, without leaking
  `buf`/`scratch`) is the one genuinely subtle change; the `sfn_read_fd` → `OwnedBuf`
  rewrite + the `%OwnedBuf*` descriptor flip are tightly coupled to it (the define and
  declare must agree) and must not be split from each other.
- **Slice B — tests + docs (mechanical; delegatable to a Sonnet implementer).** §7
  assertion rewrites, the two new read_line tests, the effect-fixture edit, and the
  status.md line. The spec above is far smaller than its output → a clean delegation
  win. Must land in the **same PR** as A (bundle; the suite exercises the retyped ABI).

No further splitting — one honest S/M issue, one PR, no seed cut.

## 10. Risks

| Risk | Detection | Mitigation / fallback |
|---|---|---|
| Named `%OwnedBuf*` in a descriptor/declare has no *exact* precedent (`process.environ` uses an anonymous `{...}*`). | `make compile` link error, or clang rejects `%OwnedBuf` in a consuming module. | Renderer already emits `%OwnedBuf = type opaque` for referenced-undefined named types (`rendering.sfn:701-733`); the field-accessing module always inlines the full struct. **Fallback:** spell the descriptor `{i64,i64,i64,i64}*` (anonymous, environ-style) and expose length via an `owned_buf_len(b)` accessor instead of `.len` — loses `.len` ergonomics but removes the named-type dependency. |
| Runtime-sfn-source io.sfn fails isolated emit with the `-> OwnedBuf` return (#1283 class). | `make compile` fails in the io.sfn `.o` emit (`cannot resolve return type…`). | Inlining `OwnedBuf` + constructing via struct literal avoids any cross-module struct-returning *call*; `string.sfn` returns `OwnedBuf`-shaped values through this path today. **Fallback:** if the boxed return still fails, gate on the #1288 seed capability by `import { OwnedBuf } from "./memory/ownedbuf"` (string.sfn's live pattern) — the pinned seed already contains #1288. |
| `let b: OwnedBuf = io.read_fd(...)` annotation forgotten → `b.len` fails to lower. | Lowering diagnostic (unknown field / bad receiver) at the call site. | Documented as required (§2/§4.1); the two tests use the annotation; any real consumer needs `OwnedBuf` in scope regardless. |
| `io.read_line(...) == null` mis-lowers (int vs pointer compare) on the permissive result. | New EOF-null test fails / wrong branch. | Descriptor `i8*` makes lowering treat the result as a pointer → `== null` is a pointer-to-0 compare; covered by the new test. |
| A future non-annotating caller of `io.read_fd` (result discarded) references `%OwnedBuf` without defining it. | clang undefined-type error. | Opaque forward-decl (above) keeps a *pointer-only* reference valid; only field access needs the full def, which requires the annotation anyway. |

## 11. Verification

- `sfn check compiler/src/llvm/runtime_helpers.sfn runtime/sfn/io.sfn` — fast
  parse/typecheck/effect gate after the edits (inner loop).
- `sfn fmt --write` then `--check` on `runtime/sfn/io.sfn` and
  `compiler/src/llvm/runtime_helpers.sfn` (CI gate).
- `make compile` — self-host from the pinned seed (mandatory for the io.sfn body +
  descriptor change; not structural, no `make clean-build`).
- `build/bin/sfn test compiler/tests/integration/io_read_fd_test.sfn` and
  `build/bin/sfn test compiler/tests/e2e/io_read_fd_effect_test.sfn` — the
  retyped assertions, incl. the new EOF-null and blank-line cases and E0400.
- `make check` — full triple-pass self-host + suite before declaring shipped.

## 12. Stage1 readiness mapping

1. Parses — struct literal + `-> OwnedBuf` / `-> * u8` bodies (no new syntax). ✅
2. Type/effect-checks — `sfn check`; `![io]` gate unchanged; E0400 test. ✅
3. `.sfn-asm` — runtime bodies emit as today (io.sfn already a runtime-sfn-source). ✅
4. LLVM lowering — descriptor `%OwnedBuf*` / `i8*`; boxed-struct + nullable-i8* paths. ✅
5. Regression — §7 (two new read_line tests + OwnedBuf read_fd assertions). ✅
6. Self-hosts — `make compile`; no compiler-source consumer; one PR, no seed cut. ✅
7. `sfn fmt --check` on every touched `.sfn`. ✅
8. Documented — `docs/status.md:416` + this design note. ✅

## Future considerations

- Retiring `login.sfn`'s `sh -c "head -1"` (status.md:416) becomes trivial once a
  seed containing the typed builtins is pinned: `io.read_line(0)` with a `null`
  EOF check replaces the subprocess — a clean first real consumer, and the reason
  the typed `string?` return matters.
- A future buffered `io.Reader` (explicitly out of scope here) builds on
  `OwnedBuf` — the length-explicit binary-safe return is the right substrate; the
  byte-at-a-time `read_line` stays the unbuffered floor.
- If more `io.*` typed surface accrues, revisit a `sfn/io` capsule wrapper (the
  `sfn/os` shape); today the descriptor-carried boxed-pointer return makes one
  unnecessary.

## Implementation notes (deviations from the plan above)

Two things diverged from §4 as implemented; recorded here so the design record
matches the shipped code.

1. **`sfn_read_fd` keeps the NUL terminator.** §4.1 proposed `malloc(n)` with no
   terminator. The shipped body allocates `malloc(n + 1)` and writes a NUL at
   `buf[got]`, returning `cap = n + 1`. `len` stays the authoritative byte count
   (from `read(2)`), so the buffer is still binary-safe (embedded NULs preserved,
   `len` never derived from `strlen`) — the terminator merely sits *past* the
   data, making the buffer also a valid cstring. This lets the regression test
   compare content via the `sfn/os`-sibling idiom `(b.ptr_addr as * u8 as string)
   == "abc"` with no heap over-read, instead of a `load_byte` builtin that does
   not exist as a callable runtime helper (the §7 assumption). Strictly a
   superset; costs one byte + one `memset`.

2. **Risk #1 (undefined `%OwnedBuf` in declare-only modules) materialized and was
   fixed in the lowering pipeline, not the descriptor.** The `%OwnedBuf*` helper
   `declare` is emitted program-wide into *every* module (used-target set is
   program-wide), including modules that never define the struct — clang then
   rejected `use of undefined type named 'OwnedBuf'`. The renderer's existing
   opaque-forward-decl pass (`rendering.sfn`) did not cover it, because it keys on
   the module's own functions/structs, not the injected helper declares. Fix: a
   new text-level pass `_append_missing_opaque_forward_decls` in
   `lowering_core.sfn`, called once on the final `lines` **after**
   `apply_module_symbol_mangling` + `dedup_module_declare_lines` — it appends
   `%Name = type opaque` for any named type referenced by a `declare` line with no
   `%Name = type …` definition in that module. It had to run *after* mangling
   (not in `render_llvm_preamble`) because the capsule path lowers with
   `mangle_symbols=true` and the mangling stage runs between the preamble's own
   type pass and the final text; the runtime-sfn-source path
   (`mangle_symbols=false`) tolerated the earlier placement but the capsule path
   did not. The documented anonymous-`{…}*` fallback was rejected: it only moves
   the break to the consuming call site (`%t0 = call {…}* @sfn_read_fd` then
   `load %OwnedBuf, %OwnedBuf* %t0` type-mismatches under typed pointers).

3. **Build-cache gotcha (dev iteration only).** The shared content-addressed
   build cache (`$SAILFIN_BUILD_CACHE_DIR`, default `~/.cache/sailfin`) keys
   capsule IR on source-hash + compiler-version. A dev build's version is
   `…+dev.<git-hash>`, so *uncommitted* compiler changes do not bump it, and an
   unchanged capsule (e.g. `sfn/cli`) is served stale — masking a compiler
   emission change. Verify emission changes with a fresh `SAILFIN_BUILD_CACHE_DIR`
   (or `SAILFIN_NO_CACHE=1`); a committed change / released seed bumps the version
   and busts the cache normally, so this is a local-iteration artifact, not a
   product bug.
