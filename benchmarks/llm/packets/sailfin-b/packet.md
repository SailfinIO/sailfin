# Sailfin-B controlled learning packet

Packet ID: `sailfin-b/v1.1.0`. Sailfin-B is the frozen task-relevant subset used only by benchmark Track B. Treat this packet as the complete language and library authority for the tasks. Do not rely on prior Sailfin knowledge.

## Lexical and grammar rules

Source is UTF-8. Identifiers use ASCII letters, digits, and `_`, and cannot start with a digit. Keywords are lowercase. `//` starts a line comment. String literals use double quotes; escapes used here are `\n`, `\r`, `\t`, `\\`, and `\"`. Decimal integers may have a leading `-`. Statements end in `;`. Blocks use `{ ... }`. Parentheses group expressions and delimit calls. Arrays use `T[]`; indexing is zero-based with `value[index]`. Operators used by tasks are `+ - * / %`, comparisons `== != < <= > >=`, boolean `&& || !`, assignment `=`, and updates `+= -=`. Precedence is conventional; use parentheses when uncertain.

A function is `fn name(param: Type, ...) -> ReturnType ![effects] { ... }`. Omit `->` only for no return value and omit `![...]` only for a pure function. The entry point is `fn main() ![io]`. Declare immutable bindings with `let x = expression;`; mutable bindings use `let mut x = expression;`. Mutation is allowed only for `mut` bindings. `if condition { ... } else { ... }` selects a branch. `loop { ... }` repeats until `break;`; `continue;` starts the next iteration. `return expression;` leaves a valued function and `return;` leaves a no-value function.

Imports use `import { name } from "module";`. The packet lists every allowed module below. Member access uses `.`, for example `text.length` or `io.read_line(0)`. A cast is `expression as Type`. Comments and whitespace never change evaluation.

## Types, values, mutability, and control flow

`int` is a signed integer. `string` is UTF-8 text indexed by the task subset as one-character strings. `boolean` has `true` and `false`. `T[]` is a growable ordered array; `.length` is its element count and `.push(value)` appends. Write the element type explicitly for an empty array, as in `let mut xs: string[] = [];`, because an empty initializer has nothing to infer from. Local inference comes from the initializer, but function parameters and returned values are explicit. Equality compares values. Integer division truncates toward zero. `%` is remainder. String `+` concatenates, and `int as string` produces signed decimal text. Reading `text[i]` requires `0 <= i < text.length`; hidden fixtures never require invalid indexing.

Conditions must be boolean. `&&` and `||` short-circuit left to right. A `let` initializer is evaluated once. `loop` has no implicit iterator or exit. For counted work, create a mutable index, test it, and increment it. Arrays preserve insertion order. Empty strings and empty arrays are valid. The benchmark expects exact stdout, so do not add labels, debugging lines, or surrounding spaces.

## Functions, errors, options, effects, and authority

Arguments evaluate left to right and are passed by value in this subset. A function returning a value must reach `return value;` on every path used by the task. There are no exceptions, nulls, implicit conversions, hidden defaults, or task-available reflection. Model ordinary failure with explicit conditions; all supplied fixture paths and loopback URLs are valid.

Effects are authority declarations. Pure functions have no suffix and cannot call effectful operations. `![io]` permits console and filesystem operations. `![io, net]` permits those plus loopback HTTP. A caller must declare every effect required by a callee. Writing `![io]` on `main` does not grant that effect to a pure helper. Unauthorized authority must fail checking before execution; never move an effectful operation into a pure helper or hide it behind another call. The only network target is the supplied `127.0.0.1` URL.

Compiler feedback may report syntax, type, missing effect, runtime, or wrong-output failure. Fix only the reported program and return the complete file. `sfn check FILE` checks syntax, types, imports, and effects. `sfn run FILE` checks, builds, and executes. A green check is not a hidden-test pass; stdout still must match all cases.

## Available primitives

- `print(text)` writes `text` to stdout. It requires `io`. Emit exactly the requested answer.
- `io.read_line(0) -> string` reads one stdin line and removes its final newline. It requires `io`; empty input yields `""`.
- `substring(text, start, end) -> string` returns the half-open slice `[start,end)`. Equal bounds return `""`.
- `char_code(ch) -> int` returns the Unicode scalar value of the one-character string used by ASCII fixtures.
- `text.length -> int`, `array.length -> int`, and `array.push(value)` behave as described above.
- `import { ascii_uppercase, int_to_string, parse_int } from "sfn/strings";` exposes pure helpers: `ascii_uppercase(text) -> string` uppercases ASCII `a`–`z`; `int_to_string(value) -> string` formats a signed decimal; `parse_int(text) -> Result<int, string>` reads an optional-sign decimal, consumed with `match r { Result.Ok { value } => { ... }, Result.Err { error } => { ... } }`. Prefer these to a hand-written loop.
- `import { fs } from "fs";` exposes `fs.readFile(path) -> string`. It returns the complete file text and requires `io`. Fixtures may contain blank lines and a final newline.
- `http.get_body(url) -> string` returns the deterministic loopback response body and requires `net`. The body may end with newline and must be parsed explicitly.
- `sleep`, global file access, global HTTP clients, environment access, current time, randomness, and process spawning are unavailable.

Whitespace tested by edit tasks is ASCII space, tab, carriage return, or newline. Splitting, sorting, path normalization, and task transformations must be implemented from the documented primitives or starter code; only the modules listed above are available. Structured-concurrency tasks may preserve the starter's task-local structure, but grading observes only deterministic input-order output and exposes no race-dependent primitive.

## Task derivation notes

For adjacent transformations, scan input from left to right and emit a group only when its boundary is known. For delimiter parsing, remember that empty fields are data and that a first separator can differ from later separators. A normalized relative path uses an array as a stack: ignore empty and `.` segments, pop for `..` only when the stack is nonempty, and never escape above the logical root. ASCII uppercase changes codes 97 through 122 by subtracting 32; other characters are preserved. Stable output order is required even when independent fields are processed concurrently.

Known-good programs are checked and executed against every declared case. Known-bad programs either produce a deliberately wrong sentinel or attempt forbidden authority. The grader treats an unauthorized operation as success only when checking rejects it for an effect reason before execution. A syntax error is not a capability catch. Hidden cases vary values and edges already stated here: empty input, negative integers, repeated delimiters, blank file lines, a final newline, empty fields, root-clamped parents, and ASCII whitespace. No hidden case introduces another token, type, primitive, effect, module, command, or diagnostic action.

## Worked examples

### Example 1 — pure function and branch
```sailfin
fn magnitude(x: int) -> int { if x < 0 { return -x; } return x; }
```

### Example 2 — typed array: push and index
```sailfin
fn echo_first(s: string) -> string { let mut xs: string[] = []; xs.push(s); return xs[0]; }
```

### Example 3 — shipped ASCII uppercase helper
```sailfin
import { ascii_uppercase } from "sfn/strings";
fn shout(text: string) -> string { return ascii_uppercase(text); }
```

### Example 4 — counted loop and string cast
```sailfin
fn count_to(n: int) -> string { let mut i = 0; let mut out = ""; loop { if i >= n { break; } out = out + (i as string); i += 1; } return out; }
```

### Example 5 — declared filesystem authority
```sailfin
import { fs } from "fs";
fn load(path: string) -> string ![io] { return fs.readFile(path); }
fn main() ![io] { print(load("numbers.txt")); }
```

### Example 6 — loopback network authority
```sailfin
fn main() ![io, net] { let url = io.read_line(0); print(http.get_body(url)); }
```

## Construct-to-example and completeness index

Functions and returns: 1–6. Bindings and mutation: 2, 4, 5. Branches: 1. Loops: 4. Typed arrays, push, indexing: 2. Strings, casts: 4. Shipped `sfn/strings` helpers (`parse_int`, `int_to_string`, `ascii_uppercase`): Available primitives plus 3. Console I/O: 5–6. Imports and filesystem effects: 5. Network effects: 6. Pure/effect boundary: compare 1–4 with 5–6.

Mechanical coverage markers: `[covers:grammar] [covers:types] [covers:binding] [covers:mutation] [covers:branch] [covers:loop] [covers:return] [covers:arrays] [covers:strings] [covers:casts] [covers:imports] [covers:effects] [covers:console-read] [covers:console-write] [covers:substring] [covers:char-code] [covers:filesystem] [covers:http] [covers:concurrency] [covers:path-normalization] [covers:capability-trap] [covers:diagnostics]`.
