# Architecture: `sfn fmt` — Canonical Formatter

Status: Draft  
Date: April 15, 2026  
Parent: [docs/proposals/tooling.md](../proposals/tooling.md)

## Overview

`sfn fmt` is a zero-configuration source formatter for `.sfn` files. One
canonical style, no options. This document covers the internal architecture,
data structures, algorithm, formatting rules, phased implementation plan,
and test strategy.

## CLI Interface

```
sfn fmt [--check] [--write] [path...]
```

| Invocation | Behavior |
|---|---|
| `sfn fmt file.sfn` | Print formatted output to stdout |
| `sfn fmt --write file.sfn` | Format in place (overwrite) |
| `sfn fmt --write .` | Recursively format all `.sfn` files in place |
| `sfn fmt --check .` | Exit 1 if any file differs from canonical format |
| `sfn fmt --check --write` | Error — mutually exclusive flags |

Exit codes: 0 = success (or all files already formatted), 1 = files would
change (`--check`) or error occurred.

`--check` mode prints the paths of files that differ, one per line — no diffs.
This keeps CI output clean and lets the developer run `sfn fmt --write .` to
fix everything at once.

## Architectural Approach: Token-Stream Formatter

The formatter operates on the **token stream**, not the AST. This is the
central design decision and follows `gofmt`'s proven model.

### Why Not AST-Based?

The Sailfin parser discards comments — AST nodes have no comment attachment
points. An AST-based formatter would lose all comments, making it useless.
Adding comment attachment to the AST is a large, invasive change to
`parser.sfn` and `ast.sfn` that would need to pass through the entire
pipeline (typecheck, effects, emit, LLVM lowering). It's the wrong trade-off
for a formatter.

### Why Not CST-Based?

A Concrete Syntax Tree preserves exact structure including comments and
whitespace. This is the "right" architecture for advanced formatters
(Prettier, rust-analyzer). But it requires building a second parser that
produces CST nodes instead of AST nodes. That's ~2000-3000 lines of new
parser code, a separate maintenance burden, and parser drift risk. Not worth
it for a v1 formatter that needs to ship quickly.

### Token-Stream: The Sweet Spot

The lexer already produces `Whitespace` and `Comment` tokens alongside the
structural tokens. The formatter:
1. **Lexes** the source into the full token stream (all 8 kinds preserved)
2. **Strips** existing whitespace tokens
3. **Classifies** structural tokens to determine nesting and context
4. **Attaches** comments to adjacent structural tokens
5. **Emits** tokens with canonical whitespace inserted between them

This approach:
- Preserves all comments (they're tokens, not AST metadata)
- Reuses the existing lexer with zero modifications
- Produces correct output for any syntactically valid input
- Handles malformed/partial files gracefully (no parse errors to block formatting)
- Is ~800-1200 lines vs ~3000+ for a CST approach

### Limitation: No Semantic Formatting

A token-stream formatter cannot make decisions that require semantic
understanding. For example, it cannot reorder `match` arms, inline small
function bodies, or break long expressions at semantically meaningful
boundaries. These are explicitly out of scope — the formatter handles
**layout** (indentation, spacing, blank lines, alignment) not
**restructuring**.

## Data Structures

### Token (existing — no changes needed)

```sfn
struct Token {
    kind: TokenKind;    // Identifier, NumberLiteral, StringLiteral,
                        // BooleanLiteral, Symbol, Whitespace, Comment, EndOfFile
    lexeme: string;     // Raw source text
    line: number;       // 1-based line number
    column: number;     // 1-based column number
}
```

### FmtToken — Enriched Token for Formatting

The formatter wraps each non-whitespace token with formatting metadata:

```sfn
struct FmtToken {
    token: Token;                // The original token
    leading_comments: Token[];   // Comments that precede this token (on prior lines)
    trailing_comment: Token?;    // Comment on the same line after this token
    blank_lines_before: number;  // Count of blank lines preceding this token
    role: string;                // Structural role (see below)
}
```

**Roles** classify how a token participates in formatting decisions:

| Role | Examples | Effect |
|---|---|---|
| `"block_open"` | `{` after fn/struct/enum/if/loop/for/match | Increases indent |
| `"block_close"` | `}` that closes a block | Decreases indent |
| `"paren_open"` | `(` | Increases indent (for wrapped params) |
| `"paren_close"` | `)` | Decreases indent |
| `"bracket_open"` | `[` | Increases indent (for wrapped arrays) |
| `"bracket_close"` | `]` | Decreases indent |
| `"separator"` | `,`, `;` | Controls spacing |
| `"operator"` | `+`, `-`, `*`, `/`, `==`, `!=`, `&&`, `\|\|`, `=>`, `..` | Surrounded by spaces |
| `"assign"` | `=`, `+=`, `-=` | Surrounded by spaces |
| `"colon"` | `:` in type annotations | Space after, not before |
| `"arrow"` | `->` return type separator | Space before and after |
| `"bang_bracket"` | `![` effect list opener | Space before, no space after |
| `"dot"` | `.` member access | No space before or after |
| `"keyword"` | `fn`, `let`, `if`, `for`, `loop`, `match`, `return`, `import`, `struct`, `enum`, ... | Space after |
| `"value"` | Identifiers, literals | Default spacing |

### FmtContext — Formatting State

```sfn
struct FmtContext {
    indent: number;         // Current nesting depth (0-based)
    line_pos: number;       // Current column position in output line
    context_stack: string[];// Stack of enclosing constructs ("fn", "struct", "if", ...)
    last_emitted: string;   // Role of the last emitted token
    in_import: boolean;     // Inside an import { ... } block
    in_effect_list: boolean;// Inside a ![ ... ] effect annotation
}
```

## Algorithm

### Phase 1: Lex

Call the existing `tokenize(source)` function from `lexer.sfn`. This
produces a `Token[]` containing all token kinds including `Whitespace`
and `Comment`.

### Phase 2: Strip & Classify

Walk the token stream and:
1. Discard all `Whitespace` tokens (we'll regenerate canonical whitespace)
2. Count blank lines between tokens (a blank line = 2+ consecutive newlines
   in discarded whitespace) to preserve intentional paragraph breaks
3. Assign a `role` to each non-whitespace, non-comment token
4. Attach comment tokens to their nearest structural token:
   - A comment on the same line as a preceding token → `trailing_comment`
   - A comment on a line by itself → `leading_comments` of the next token
   - A comment at EOF → `trailing_comment` of the last structural token

This produces a `FmtToken[]` — the enriched token list with no whitespace
tokens but with blank line counts and comment attachments preserved.

**Blank line detection:** When processing a `Whitespace` token, count `\n`
characters in its lexeme. If the count is >= 2, there was at least one blank
line. Cap at 1 (normalize multiple blank lines to exactly one).

**Comment attachment heuristic:**

```
code_token  // trailing comment     → trailing_comment of code_token
// leading comment                  → leading_comments[n] of next_token
code_token                          → no comment attachment

// Section header                   → leading_comments[0] of next_token
// More description                 → leading_comments[1] of next_token
fn foo() { ... }                    → token for "fn"
```

### Phase 3: Emit

Walk the `FmtToken[]` array and build the output string. For each token:

1. **Emit leading blank lines.** If `blank_lines_before > 0` and we're not
   at the start of the file, emit exactly one blank line (two `\n` chars).

2. **Emit leading comments.** For each comment in `leading_comments`:
   - Emit indent (4 spaces × `indent` depth)
   - Emit the comment lexeme
   - Emit `\n`

3. **Determine pre-token whitespace.** Based on the token's `role` and
   `last_emitted`, decide whether to emit:
   - Nothing (no space)
   - A single space
   - A newline + indent (line break before this token)

4. **Emit the token lexeme.**

5. **Update state.** Adjust `indent` for block/paren/bracket opens/closes.
   Update `line_pos`, `last_emitted`, `context_stack`.

6. **Emit trailing comment.** If present:
   - Emit two spaces + comment lexeme

7. **Emit newline after statement-ending tokens** (`;`, `{`, `}`).

**Indent adjustment timing:** `block_close` tokens (and `paren_close`,
`bracket_close`) decrement indent **before** emitting, so the closing brace
aligns with its opening construct. `block_open` tokens increment indent
**after** emitting, so the next line is indented.

## Formatting Rules

These rules are the canonical Sailfin style. They are not configurable.

### Indentation

- 4 spaces per nesting level. No tabs.
- Nesting increases after `{`, `(`, `[`.
- Nesting decreases before `}`, `)`, `]`.
- Continuation lines (wrapped parameters, long expressions) get +4 from the
  declaration indent (8 total from the block indent in most cases).

### Brace Placement (K&R)

```sfn
// Opening brace on same line as declaration
fn foo(x: number) -> number {
    return x + 1;
}

struct Point {
    x: number;
    y: number;
}

if condition {
    body();
}

for item in list {
    process(item);
}

loop {
    if done { break; }
}
```

### Spacing

| Context | Rule | Example |
|---|---|---|
| Binary operators | Space before and after | `x + y`, `a == b` |
| Assignment | Space before and after | `x = 1`, `x += 1` |
| Commas | No space before, one space after | `foo(a, b, c)` |
| Semicolons | No space before, newline after | `let x = 1;` |
| Colons (type annotation) | No space before, one space after | `x: number` |
| Arrow (return type) | Space before and after | `-> number` |
| Effect `![` | Space before, no space after | `-> number ![io]` |
| Effect `]` | No space before | `![io, net]` |
| Dot (member access) | No space before or after | `obj.field` |
| Unary operators | No space between operator and operand | `!flag`, `-x` |
| Parentheses (call) | No space before `(`, no space inside | `foo(x)` |
| Parentheses (grouping) | No space inside | `(x + y)` |
| Brackets (index/type) | No space before, no space inside | `arr[0]`, `string[]` |
| Keywords | One space after | `if cond`, `let x`, `return val` |
| Function params | One space after `:`, comma-separated | `fn f(a: number, b: string)` |

### Blank Lines

| Context | Rule |
|---|---|
| Between top-level declarations | Exactly 1 blank line |
| After import block (before first declaration) | Exactly 1 blank line |
| Within function bodies | Preserve 0 or 1 blank lines (normalize >1 to 1) |
| At start/end of blocks | No blank lines |
| Between struct/enum fields | No blank lines |
| Before/after comment groups | Preserve existing blank line if present |

A "top-level declaration" is any `fn`, `struct`, `enum`, `interface`, `test`,
`const`, or `type` at indent depth 0.

### Import Formatting

Imports are the one area where the formatter applies **ordering** logic:

1. **Sort by module path** (alphabetical, case-sensitive)
2. **Group by category** with a blank line between groups:
   - Group 1: Standard library (`"sfn/..."`)
   - Group 2: Relative imports (`"./..."`, `"../..."`)
3. **Single-item imports:** Keep on one line
4. **Multi-item imports (>3 items):** One item per line, trailing comma,
   closing `}` on its own line
5. **Within multi-line imports:** Sort items alphabetically

```sfn
import { parse } from "sfn/json";
import { join, resolve } from "sfn/path";

import { Token, TokenKind } from "./token";
import {
    Block,
    Expression,
    FunctionSignature,
    Parameter,
    Program,
    Statement,
    TypeAnnotation,
} from "./ast";
import { parse_program } from "./parser/mod";
```

**Import wrapping threshold:** A multi-specifier import wraps to one-per-line
when the single-line form would exceed 80 characters or when it has more than
3 items — whichever triggers first.

### Trailing Whitespace & EOF

- No trailing whitespace on any line.
- File ends with exactly one `\n` (no trailing blank lines).

### Comments

- **Preserved exactly as written.** The formatter does not modify comment
  content — no wrapping, no alignment, no reformatting.
- **Line comments (`//`):** Maintained with their text. Leading whitespace
  before `//` is replaced with canonical indent.
- **Inline comments:** Placed 2 spaces after the preceding code token on the
  same line.
- **Block comments (`/* */`):** Maintained with their internal formatting.
  Only the indent of the opening `/*` is adjusted to canonical depth.
- **Section dividers** (`// ═══`, `// ───`): Preserved as-is.
- **Doc comments (`///`):** Treated the same as `//` comments. The formatter
  does not distinguish them (consistent with the lexer, which doesn't either).

### Struct & Enum Literals

```sfn
// Short literal (fits on one line) — keep inline
let tok = Token { kind: TokenKind.Identifier(), lexeme: name, line: 1, column: 1 };

// Long literal (exceeds 80 chars) — wrap to one field per line
let state = LexerState {
    source: source,
    source_len: length,
    index: 0,
    line: 1,
    column: 1,
};
```

Wrap threshold: if the single-line form exceeds 80 characters, wrap to
one-field-per-line with trailing comma and closing `}` on its own line.

### String Literals

- Never modified. The formatter does not wrap, reindent, or alter string
  content in any way.
- Multi-line strings (strings containing `\n`) are emitted as-is.

### Effect Annotations

```sfn
// Canonical format: space before ![ , comma+space between effects
fn fetch(id: number) -> Order ![io, net] {
```

## File Layout: Where the Code Lives

```
compiler/
  src/
    tools/
      fmt.sfn           # Core formatting logic (~800-1000 lines)
      fmt_rules.sfn      # Spacing / blank-line rule tables (~200-300 lines)
    cli_main.sfn         # Add `fmt` dispatch (minor edit)
    cli_commands.sfn     # Add handle_fmt_command (minor edit)
```

### Module Breakdown

**`compiler/src/tools/fmt.sfn`** — Core formatter module

| Function | Responsibility | ~Lines |
|---|---|---|
| `format_source(source: string) -> string` | Public entry point: lex → classify → emit | 20 |
| `strip_and_classify(tokens: Token[]) -> FmtToken[]` | Phase 2: discard whitespace, assign roles, attach comments | 200 |
| `classify_token_role(token: Token, prev: Token?, next: Token?) -> string` | Determine a single token's structural role | 150 |
| `attach_comments(tokens: Token[]) -> FmtToken[]` | Comment attachment subroutine of strip_and_classify | 100 |
| `count_blank_lines(whitespace_lexeme: string) -> number` | Count newlines in a whitespace token to detect blank lines | 15 |
| `emit_formatted(fmt_tokens: FmtToken[]) -> string` | Phase 3: walk enriched tokens, emit with canonical whitespace | 250 |
| `emit_indent(depth: number) -> string` | Generate indent string (4 spaces × depth) | 8 |
| `should_break_before(token: FmtToken, ctx: FmtContext) -> boolean` | Decide whether a newline+indent precedes this token | 60 |
| `spacing_between(prev_role: string, next_role: string) -> string` | Look up inter-token spacing (space, none, newline) | 60 |
| `sort_imports(fmt_tokens: FmtToken[]) -> FmtToken[]` | Reorder import statements by path; group stdlib/relative | 100 |
| `is_keyword(lexeme: string) -> boolean` | Check if an identifier is a language keyword | 30 |

**`compiler/src/tools/fmt_rules.sfn`** — Formatting rules as data

| Function | Responsibility | ~Lines |
|---|---|---|
| `get_spacing_rule(left_role: string, right_role: string) -> string` | Lookup table: given two adjacent token roles, return spacing | 120 |
| `get_blank_line_rule(context: string) -> number` | Return required blank lines for a given context transition | 40 |
| `opens_block(lexeme: string) -> boolean` | Is this token a block-opening keyword? | 20 |
| `closes_statement(lexeme: string) -> boolean` | Does this token end a statement? (`;`, a `}` at statement level) | 15 |
| `wraps_at_threshold(items: number, line_length: number) -> boolean` | Should a list wrap to one-per-line? | 10 |
| `is_binary_operator(lexeme: string) -> boolean` | Is this symbol a binary operator needing surrounding spaces? | 30 |
| `is_unary_prefix(lexeme: string, prev_role: string) -> boolean` | Is this `-` or `!` a unary prefix? (context-dependent) | 20 |
| `import_group(path: string) -> number` | Return 0 for stdlib, 1 for relative — used in sort | 15 |

**`compiler/src/cli_commands.sfn`** — Command handler (addition)

```sfn
fn handle_fmt_command(args: string[]) -> number ![io] {
    // Parse --check, --write, path arguments
    // Collect .sfn files (reuse _collect_sfn_files_cmd)
    // For each file: read → format_source → write/check/print
    // Return exit code
}
```

~80-120 lines including flag parsing and file I/O.

## Implementation Plan

The formatter is built in 5 incremental steps. Each step produces a
working (if incomplete) formatter that can be tested independently.

### Step 1: Scaffold & CLI Wiring

**Goal:** `sfn fmt file.sfn` runs and prints the file unchanged (identity pass).

- Create `compiler/src/tools/fmt.sfn` with `format_source()` that returns
  input unchanged
- Create `compiler/src/tools/fmt_rules.sfn` with stub functions
- Add `fmt` dispatch to `cli_main.sfn`
- Add `handle_fmt_command` to `cli_commands.sfn` with flag parsing and
  file collection
- Verify `make compile` succeeds (self-hosting invariant)

**Test:** `sfn fmt compiler/src/token.sfn` prints the file to stdout.

**Deliverable:** Working CLI plumbing; format logic is a no-op.

### Step 2: Token Stripping & Basic Indentation

**Goal:** Strip existing whitespace and re-emit with canonical indentation.
Comments are preserved but may not be perfectly placed yet.

- Implement `strip_and_classify()` — discard `Whitespace` tokens, compute
  blank line counts, assign basic roles (`block_open`, `block_close`,
  `separator`, `value`)
- Implement `emit_formatted()` — walk tokens, emit indent on new lines,
  emit newlines after `;` and `{` and `}`, track nesting depth
- Implement `emit_indent()`, `count_blank_lines()`
- Tests: unit tests comparing formatted output against expected strings
  for small snippets (single function, single struct, nested if/loop)

**Test:** Format a 10-line function and verify 4-space indentation.

**Deliverable:** Correct indentation for braces and statement terminators.
Spacing between tokens may still be wrong.

### Step 3: Spacing Rules & Comment Attachment

**Goal:** Correct inter-token spacing (spaces around operators, after commas,
after keywords, etc.) and correct comment placement.

- Implement `classify_token_role()` with full role assignment including
  operator/keyword/colon/arrow/dot detection
- Implement `attach_comments()` — trailing vs leading comment attachment
- Implement `spacing_between()` and the rule tables in `fmt_rules.sfn`
- Implement `is_keyword()`, `is_binary_operator()`, `is_unary_prefix()`

**Test:** Format expressions like `x+y*z` → `x + y * z`; verify comments
on the same line as code stay on that line.

**Deliverable:** Fully correct token-level formatting (spacing, comments).

### Step 4: Blank Line Normalization & Import Sorting

**Goal:** Canonical blank lines between declarations and sorted imports.

- Implement blank line rules: exactly 1 between top-level declarations,
  normalize >1 to 1, no blank lines at block start/end
- Implement `sort_imports()` — parse import statements from the token
  stream, sort by path, group by category, re-emit with canonical wrapping
- Implement `wraps_at_threshold()` for import and struct literal wrapping

**Test:** Multiple blank lines between functions → exactly one. Unsorted
imports → sorted and grouped.

**Deliverable:** Production-ready formatter for standard Sailfin code.

### Step 5: Edge Cases, Self-Hosting Validation & CI

**Goal:** Handle all edge cases in the compiler source and wire into CI.

- Format all 120 compiler source files; fix any formatter bugs discovered
- Verify `sfn fmt --write compiler/src/ && make compile` succeeds
  (formatted code self-hosts)
- Add idempotency test: `sfn fmt | sfn fmt` produces same output
- Add `--check` validation to CI (GitHub Actions)
- Handle edge cases:
  - Empty files
  - Files with only comments
  - Deeply nested constructs (6+ levels)
  - Very long string literals
  - Adjacent comments with no code between them
  - Effect annotations `![io, net]`
  - Enum variants with payloads
  - Match expressions with `=>`
  - Decorator syntax (`@logExecution`)

**Test:** `sfn fmt --check compiler/src/` exits 0 after running
`sfn fmt --write compiler/src/`.

**Deliverable:** CI-enforced canonical formatting for the entire project.

## Key Design Decisions & Rationale

### 1. No Configuration

No `.sfnfmt.toml`, no CLI width flags, no style options. One style.

`gofmt` proved this is the right call. Configuration creates:
- Dialect fragmentation (every project looks different)
- Merge conflicts in config files
- Debates about which style is "best"
- LLM confusion (which style to generate?)

The formatter defines the style. End of discussion.

### 2. Import Sorting Is Formatting

Some formatters (Prettier) explicitly avoid import sorting. We include it
because:
- Sailfin imports are simple (`import { names } from "path"`) — no side effects
- Import order has no semantic meaning in Sailfin
- Consistent import ordering reduces diff noise significantly
- The compiler's own 120 files have inconsistent import ordering today

### 3. 80-Character Wrap Threshold for Collections

Imports and struct literals wrap to multi-line at 80 chars. This is not a
line-length limit — the formatter does NOT wrap arbitrary expressions. 80
is only the threshold for structured collections where wrapping is clean.

General expression lines can be any length. The formatter does not break
`let x = very_long_function_name(arg1, arg2, arg3, arg4);` — that's a
readability decision for the programmer, not the formatter. A future version
could add expression wrapping, but it requires semantic understanding of
precedence and readability that a token-stream formatter can't provide.

### 4. Semicolons Are Required

The formatter does not insert or remove semicolons. Sailfin requires them
as statement terminators. If a semicolon is missing, the formatter emits
the tokens as-is and the parser will report the error.

### 5. Lexer-Only Dependency

The formatter depends only on `lexer.sfn` and `token.sfn`. It does not
import the parser, AST, type checker, or any other compiler pass. This
means:
- Format errors never produce parse errors
- Partially valid files can still be formatted
- The formatter has no dependency on anything that might change
- Build time impact is minimal

## Testing Strategy

### Unit Tests (`compiler/tests/unit/fmt_tool_test.sfn`)

Small, focused tests that verify individual formatting rules:

```sfn
test "fmt: 4-space indentation" {
    let input = "fn foo() {\nreturn 1;\n}";
    let expected = "fn foo() {\n    return 1;\n}\n";
    assert format_source(input) == expected;
}

test "fmt: space around binary operators" {
    let input = "let x=1+2;";
    let expected = "let x = 1 + 2;\n";
    assert format_source(input) == expected;
}

test "fmt: preserve trailing comment" {
    let input = "let x = 1; // important\n";
    let expected = "let x = 1;  // important\n";
    assert format_source(input) == expected;
}

test "fmt: normalize blank lines" {
    let input = "fn a() {}\n\n\n\nfn b() {}";
    let expected = "fn a() {}\n\nfn b() {}\n";
    assert format_source(input) == expected;
}
```

### Integration Tests (`compiler/tests/integration/fmt_integration_test.sfn`)

Format real compiler source files and verify:
1. Output is valid Sailfin (re-lexing produces no errors)
2. Formatting is idempotent (format twice = same result)
3. Token count is preserved (no tokens lost or added)

### Self-Hosting Test

The ultimate integration test:

```bash
# Format all compiler source
sfn fmt --write compiler/src/

# Verify the compiler still compiles itself
make compile

# Verify tests still pass
make test

# Verify formatting is stable
sfn fmt --check compiler/src/  # Should exit 0
```

### Golden File Tests

For complex formatting scenarios, use golden files:

```
compiler/tests/fixtures/fmt/
    input/          # Unformatted .sfn snippets
    expected/       # Expected formatted output
```

Each test reads `input/foo.sfn`, formats it, and compares against
`expected/foo.sfn`. This makes it easy to add edge cases and review
formatting decisions visually.

## Edge Cases & Known Challenges

### 1. Unary vs Binary Minus

`-` is both a unary prefix operator (`-x`) and a binary operator (`x - y`).
The formatter must distinguish them based on context:
- After `=`, `(`, `[`, `,`, `return`, `if`, or start of expression → unary
- After a value token (identifier, literal, `)`, `]`) → binary

The `is_unary_prefix()` function in `fmt_rules.sfn` handles this by
checking the role of the preceding token.

### 2. Generic Type Angle Brackets

`<` and `>` are both comparison operators and generic type delimiters:
- `Array<string>` — generic type
- `x < y` — comparison

The formatter treats `<` and `>` as operators (spaces around them) by
default. When preceded by an identifier and followed by an identifier/type
with no space in the original source, treat as generics (no spaces). This
heuristic works because the lexer preserves original spacing context through
adjacent token positions.

### 3. Effect Annotation `![`

The `!` + `[` sequence in effect annotations (`![io, net]`) must be treated as
a single unit. The classifier checks: if `!` is followed immediately by `[`
(no whitespace between them in the original token positions), assign the `!`
role as `bang_bracket` and treat `[` as the effect list opener with no
space after `!`.

### 4. Decorator Syntax

Decorators (`@logExecution`, `@deprecated`) appear on the line before a
declaration:

```sfn
@logExecution
fn process() ![io] {
```

The formatter ensures decorators are on their own line at the same indent
as the declaration they annotate, with no blank line between decorator
and declaration.

### 5. Arrow in Different Contexts

`->` appears in two contexts:
- Return type: `fn foo() -> number`
- Legacy type annotation: `let x -> number` (deprecated, being migrated to `:`)

Both get space before and after. The formatter is context-agnostic here —
it applies the same spacing regardless of context, which is correct for
both uses.

### 6. Match Expression Arms

```sfn
match value {
    Pattern1 => { body(); }
    Pattern2 => {
        longer_body();
        more_statements();
    }
    _ => { default(); }
}
```

Each arm gets its own line. `=>` gets space before and after. The body
follows normal brace/indent rules. Single-expression arms may stay on
one line if they fit within 80 characters.

### 7. Empty Blocks

```sfn
// Kept on one line
fn noop() {}

// Struct with no fields
struct Unit {}
```

An empty block (`{` immediately followed by `}` with nothing between them)
stays on one line with no space inside.

## Dependencies

| Dependency | Status | Notes |
|---|---|---|
| `compiler/src/lexer.sfn` | Stable | `tokenize()` function |
| `compiler/src/token.sfn` | Stable | `Token`, `TokenKind` types |
| `compiler/src/cli_main.sfn` | Stable | Subcommand dispatch |
| `compiler/src/cli_commands.sfn` | Stable | Command handler pattern |
| `compiler/src/cli_commands_utils.sfn` | Stable | `_collect_sfn_files_cmd()`, file I/O helpers |

No new external dependencies. No changes to existing modules except
minor additions to CLI dispatch.

## Future Considerations (Out of Scope for v1)

- **Expression wrapping:** Break long expressions at operator boundaries.
  Requires precedence-aware formatting → needs parser integration.
- **Align struct field types:** Vertically align `:` in struct fields.
  Controversial (Go explicitly doesn't do this for `gofmt`). Defer.
- **Format-on-save in LSP:** Once `sfn lsp` exists, wire `sfn fmt` as
  a `textDocument/formatting` handler.
- **Partial formatting:** Format only a selected range (LSP
  `textDocument/rangeFormatting`). Requires tracking which FmtTokens
  correspond to the selected source range.
- **Pre-commit hook:** `sfn fmt --check` as a git pre-commit hook.
  Trivial to wire once the formatter exists.
