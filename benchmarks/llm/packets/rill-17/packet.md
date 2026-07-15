# Rill-17 controlled learning packet

Packet ID: `rill-17/v1.0.0`. Rill-17 is a nonce synthetic dialect created solely as an unfamiliar experimental control for benchmark Track B. It is not a product or competitor. Treat this packet as the complete language and library authority; do not infer rules from another language.

## Lexical and grammar rules

Source is UTF-8. Identifiers use ASCII letters, digits, and `_`, and cannot start with a digit. Keywords are lowercase. `//` starts a line comment. Text literals use double quotes; escapes used here are `\n`, `\r`, `\t`, `\\`, and `\"`. Decimal wholes may have a leading `-`. Statements end in `;`. Blocks use `{ ... }`. Parentheses group expressions and delimit calls. Arrays use `T[]`; indexing is zero-based with `value[index]`. Operators used by tasks are `+ - * / %`, comparisons `== != < <= > >=`, boolean `&& || !`, assignment `=`, and updates `+= -=`. Precedence is conventional; use parentheses when uncertain.

A routine is `craft name(param: Type, ...) -> ReturnType with[authorities] { ... }`. Omit `->` only for no return value and omit `with[...]` only for a sealed pure routine. The entry point is `craft main() with[console]`. Declare immutable bindings with `bind x = expression;`; mutable bindings use `bind flux x = expression;`. Mutation is allowed only for `flux` bindings. `when condition { ... } otherwise { ... }` selects a branch. `cycle { ... }` repeats until `halt;`; `resume;` starts the next iteration. `yield expression;` leaves a valued routine and `yield;` leaves a no-value routine.

Imports use `draw { name } via "module";`. The packet lists every allowed module below. Member access uses `.`, for example `text.length` or `console.take_line(0)`. A cast is `expression cast Type`. Comments and whitespace never change evaluation.

## Types, values, mutability, and control flow

`whole` is a signed integer. `glyphs` is UTF-8 text indexed by the task subset as one-character text. `truth` has `aye` and `nay`. `T[]` is a growable ordered array; `.length` is its element count and `.push(value)` appends. Local inference comes from the initializer, but routine parameters and returned values are explicit. Equality compares values. Whole division truncates toward zero. `%` is remainder. Glyph `+` concatenates, and `whole cast glyphs` produces signed decimal text. Reading `text[i]` requires `0 <= i < text.length`; hidden fixtures never require invalid indexing.

Conditions must be truth values. `&&` and `||` short-circuit left to right. A `bind` initializer is evaluated once. `cycle` has no implicit iterator or exit. For counted work, create a flux index, test it, and increment it. Arrays preserve insertion order. Empty glyph sequences and empty arrays are valid. The benchmark expects exact stdout, so do not add labels, debugging lines, or surrounding spaces.

## Routines, errors, options, effects, and authority

Arguments evaluate left to right and are passed by value in this subset. A routine returning a value must reach `yield value;` on every path used by the task. There are no exceptions, nulls, implicit conversions, hidden defaults, or task-available reflection. Model ordinary failure with explicit conditions; all supplied fixture paths and loopback URLs are valid.

Authorities are written after `with`. Pure routines have no suffix and cannot call authority-bearing operations. `with[console]` permits console and vault operations. `with[console, link]` permits those plus loopback web access. A caller must declare every authority required by a callee. Writing `with[console]` on `main` does not grant that authority to a sealed helper. Unauthorized authority must fail checking before execution; never move an authority-bearing operation into a sealed helper or hide it behind another call. The only link target is the supplied `127.0.0.1` URL.

Tool feedback may report syntax, type, missing authority, runtime, or wrong-output failure. Fix only the reported program and return the complete file. `rill17 check FILE` checks syntax, types, imports, and authorities. `rill17 run FILE` checks, builds, and executes. A green check is not a hidden-test pass; stdout still must match all cases.

## Available primitives

- `emit(text)` writes `text` to stdout. It requires `console`. Emit exactly the requested answer.
- `console.take_line(0) -> glyphs` reads one stdin line and removes its final newline. It requires `console`; empty input yields `""`.
- `span(text, start, end) -> glyphs` returns the half-open slice `[start,end)`. Equal bounds return `""`.
- `rune_code(ch) -> whole` returns the Unicode scalar value of the one-character glyph used by ASCII fixtures.
- `text.length -> whole`, `array.length -> whole`, and `array.push(value)` behave as described above.
- `draw { vault } via "fs";` exposes `vault.read_text(path) -> glyphs`. It returns the complete file text and requires `console`. Fixtures may contain blank lines and a final newline.
- `loopweb.fetch_body(url) -> glyphs` returns the deterministic loopback response body and requires `link`. The body may end with newline and must be parsed explicitly.
- Sleeping, global file access, global web clients, environment access, current time, randomness, and process spawning are unavailable.

Whole parsing is explicit: handle an optional leading `-`, then accumulate digits with `rune_code(ch) - 48`. Whitespace tested by edit tasks is ASCII space, tab, carriage return, or newline. Splitting, sorting, uppercase conversion, path normalization, and task transformations must be implemented from the documented primitives or starter code; no undeclared standard package is assumed. Structured-concurrency tasks may preserve the starter's task-local structure, but grading observes only deterministic input-order output and exposes no race-dependent primitive.

## Task derivation notes

For adjacent transformations, scan input from left to right and emit a group only when its boundary is known. For delimiter parsing, remember that empty fields are data and that a first separator can differ from later separators. A normalized relative path uses an array as a stack: ignore empty and `.` segments, pop for `..` only when the stack is nonempty, and never escape above the logical root. ASCII uppercase changes codes 97 through 122 by subtracting 32; other characters are preserved. Stable output order is required even when independent fields are processed concurrently.

Known-good programs are checked and executed against every declared case. Known-bad programs either produce a deliberately wrong sentinel or attempt forbidden authority. The grader treats an unauthorized operation as success only when checking rejects it for an authority reason before execution. A syntax error is not an authority catch. Hidden cases vary values and edges already stated here: empty input, negative wholes, repeated delimiters, blank vault lines, a final newline, empty fields, root-clamped parents, and ASCII whitespace. No hidden case introduces another token, type, primitive, authority, module, command, or diagnostic action.

## Worked examples

### Example 1 — sealed routine and branch
```rill17
craft magnitude(x: whole) -> whole { when x < 0 { yield -x; } yield x; }
```

### Example 2 — counted cycle and glyph cast
```rill17
craft count_to(n: whole) -> glyphs { bind flux i = 0; bind flux out = ""; cycle { when i >= n { halt; } out = out + (i cast glyphs); i += 1; } yield out; }
```

### Example 3 — half-open glyph span
```rill17
craft first(text: glyphs) -> glyphs { when text.length == 0 { yield ""; } yield span(text, 0, 1); }
```

### Example 4 — console entry point
```rill17
craft main() with[console] { bind line = console.take_line(0); emit(line); }
```

### Example 5 — declared vault authority
```rill17
draw { vault } via "fs";
craft load(path: glyphs) -> glyphs with[console] { yield vault.read_text(path); }
craft main() with[console] { emit(load("numbers.txt")); }
```

### Example 6 — loopback link authority
```rill17
craft main() with[console, link] { bind url = console.take_line(0); emit(loopweb.fetch_body(url)); }
```

## Construct-to-example and completeness index

Routines and yields: 1–6. Bindings and flux mutation: 2, 4–6. Branches: 1–3. Cycles: 2. Glyphs, length, spans, casts: 2–4. Console: 4–6. Imports and vault authority: 5. Link authority: 6. Sealed/authority boundary: compare 1–3 with 4–6.

Mechanical coverage markers: `[covers:grammar] [covers:types] [covers:binding] [covers:mutation] [covers:branch] [covers:loop] [covers:return] [covers:arrays] [covers:strings] [covers:casts] [covers:imports] [covers:effects] [covers:console-read] [covers:console-write] [covers:substring] [covers:char-code] [covers:filesystem] [covers:http] [covers:concurrency] [covers:path-normalization] [covers:capability-trap] [covers:diagnostics]`.
