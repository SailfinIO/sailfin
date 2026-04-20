---
title: Grammar Reference (EBNF)
description: The formal Sailfin grammar in Extended Backus-Naur Form.
section: reference
sidebar:
  order: 2
---

The Sailfin grammar is specified in Extended Backus–Naur Form (EBNF). The
canonical source is [`docs/enbf.md`](https://github.com/SailfinIO/sailfin/blob/main/docs/enbf.md)
in the repository.

## Notation

| Symbol | Meaning |
|--------|---------|
| `=` | Defines a non-terminal |
| `\|` | Alternation (either/or) |
| `[ x ]` | Optional — zero or one occurrence of `x` |
| `{ x }` | Repetition — zero or more occurrences of `x` |
| `( x )` | Grouping |
| `"terminal"` | Literal terminal token |
| `PascalCase` | Non-terminal reference |
| `;` | End of production rule |

## Program Structure

```ebnf
Program            = { ImportDeclaration | ExportDeclaration | Declaration | Statement } ;

ImportDeclaration  = "import" ImportSpecifierList "from" StringLiteral ";" ;

ExportDeclaration  = "export" ImportSpecifierList [ "from" StringLiteral ] ";" ;

ImportSpecifierList = "{" [ ImportSpecifier { "," ImportSpecifier } ] "}" ;

ImportSpecifier    = Identifier [ "as" Identifier ] ;
```

A Sailfin source file is a flat sequence of imports, exports, declarations, and
top-level statements. There is no required ordering between them.

## Declarations

```ebnf
Declaration        = StructDeclaration
                   | EnumDeclaration
                   | InterfaceDeclaration
                   | FunctionDeclaration
                   | PipelineDeclaration
                   | ToolDeclaration
                   | ModelDeclaration
                   | TestDeclaration
                   | TypeAliasDeclaration
                   | VariableDeclaration ;
```

### Structs and Interfaces

```ebnf
StructDeclaration  = "struct" Identifier [ TypeParameters ]
                     [ "implements" NominalType { "," NominalType } ]
                     "{" { StructMember } "}" ;

StructMember       = FieldDeclaration | MethodDeclaration ;

TypeAnnotation     = ":" Type ;
ReturnType         = "->" Type ;
FieldDeclaration   = [ "mut" ] Identifier TypeAnnotation ";" ;

MethodDeclaration  = { Decorator } [ "async" ] "fn" Identifier [ TypeParameters ]
                     "(" [ Parameters ] ")" [ ReturnType ] [ EffectList ] Block ;

InterfaceDeclaration = "interface" Identifier [ TypeParameters ]
                        "{" { FunctionSignature | PropertySignature } "}" ;

PropertySignature   = Identifier TypeAnnotation ";" ;

FunctionSignature   = "fn" Identifier "(" [ Parameters ] ")"
                      [ ReturnType ] [ EffectList ] ";" ;
```

Variables, parameters, and struct fields use `:` to introduce the type.
Function return types use `->`. The parser's `TypeSep` production still
accepts `->` in annotation positions for backward compatibility with early
code, but all new code should use `:` for annotations and `->` only for
return types. Methods are declared inside the struct body; the first
parameter is bare `self` (no `&self` or `&mut self`). There are no
`impl Foo { }` blocks — conformance is declared with `implements` on the
struct. Multiple interfaces: `implements A, B, C`.

### Functions

```ebnf
FunctionDeclaration = { Decorator } { FunctionModifier }
                      "fn" Identifier [ TypeParameters ]
                      "(" [ Parameters ] ")"
                      [ ReturnType ] [ EffectList ] ( Block | ";" ) ;

FunctionModifier    = "async" | "unsafe" | "extern" ;
```

When both `unsafe` and `extern` modifiers are present, the declaration introduces
a foreign C symbol and terminates with `;` instead of a block body:

```sfn
unsafe extern fn malloc(size: usize) -> *u8;
unsafe extern fn free(ptr: *u8) -> void;
```

### Parameters, Type Parameters, and Effects

```ebnf
Parameters         = Parameter { "," Parameter } ;
Parameter          = [ "mut" ] Identifier [ TypeAnnotation ] [ "=" Expression ] ;

TypeParameters     = "<" TypeParameter { "," TypeParameter } ">" ;
TypeParameter      = Identifier [ ":" Type ] ;

Decorator          = "@" QualifiedName [ "(" [ Arguments ] ")" ] ;

EffectList         = "![" EffectIdentifier { "," EffectIdentifier } "]" ;
EffectIdentifier   = Identifier ;
```

Canonical effect identifiers: `io`, `net`, `model`, `gpu`, `rand`, `clock`,
plus `unsafe`, `read`, `mut`.

The effect list attaches after the parameter list and optional return type, before the function body.

### Type Aliases and Other Declarations

```ebnf
TypeAliasDeclaration = "type" Identifier [ TypeParameters ] "=" Type ";" ;

VariableDeclaration  = "let" [ "mut" ] Identifier [ TypeAnnotation ]
                       [ "=" Expression ] ";" ;
```

### AI-Native Declarations

```ebnf
ModelDeclaration    = "model" Identifier ":" Type [ EffectList ] ModelBlock ;
ModelBlock          = "{" { ModelProperty } "}" ;
ModelProperty       = Identifier "=" ModelValue ";" ;
ModelValue          = Expression | Type ;

PipelineDeclaration = "pipeline" Identifier "(" [ Parameters ] ")"
                      [ ReturnType ] [ EffectList ] Block ;

ToolDeclaration     = "tool" Identifier "(" [ Parameters ] ")"
                      [ ReturnType ] [ EffectList ] Block ;

TestDeclaration     = "test" ( Identifier | StringLiteral ) [ EffectList ] Block ;
```

> **Status**: `model`, `pipeline`, and `tool` declarations are parsed and emit
> `.sfn-asm` IR today. Model execution (`.call()`), the `|>` operator, and the
> tool dispatcher are planned for post-1.0. See [Status](/docs/reference/spec#part-b--design-preview).

## Statements

```ebnf
Block              = "{" { Statement } "}" ;

Statement          = VariableDeclaration
                   | IfStatement
                   | ForStatement
                   | LoopStatement
                   | BreakStatement
                   | ContinueStatement
                   | MatchStatement
                   | TryStatement
                   | RoutineDeclaration
                   | ReturnStatement
                   | ThrowStatement
                   | WithStatement
                   | PromptStatement
                   | AssertStatement
                   | UnsafeBlock
                   | Block
                   | AssignmentStatement
                   | ExpressionStatement ;

UnsafeBlock        = "unsafe" Block ;
AssertStatement    = "assert" Expression ";" ;

IfStatement        = "if" Expression Block [ "else" ( IfStatement | Block ) ] ;

MatchStatement     = "match" Expression "{" { MatchCase [ "," ] } "}" ;
MatchCase          = Pattern [ "if" Expression ] "=>"
                     ( Block | InlineExpression ) ;
InlineExpression   = Expression [ ";" ] ;

TryStatement       = "try" Block [ "catch" [ "(" Identifier ")" ] Block ]
                     [ "finally" Block ] ;

RoutineDeclaration = "routine" [ Identifier | StringLiteral ] Block ;

ReturnStatement    = "return" [ Expression ] ";" ;
ThrowStatement     = "throw" Expression ";" ;
WithStatement      = "with" Expression { "," Expression } Block ;
ForStatement       = "for" Expression "in" Expression Block [ ";" ] ;
LoopStatement      = "loop" Block [ ";" ] ;
BreakStatement     = "break" [ ";" ] ;
ContinueStatement  = "continue" [ ";" ] ;

AssignmentStatement = Assignment ";" ;
Assignment         = Expression ( "=" | "+=" | "-=" | "*=" | "/=" ) Expression ;

ExpressionStatement = Expression ";" ;
```

> **Note**: `RoutineDeclaration` (`routine { }`, `routine "name" { }`) appears in
> example code today, but full runtime support (scheduling, joins) is planned for
> 1.0. See the [roadmap](/roadmap).

### Prompt Statements

```ebnf
PromptStatement    = "prompt" PromptChannel Block ;
PromptChannel      = Identifier | StringLiteral ;
```

Canonical channel names are `system`, `user`, `assistant`, and `tool`. Any identifier is accepted; channel vocabulary enforcement is planned.

## Expressions

### Operator Precedence (highest to lowest)

| Level | Operators | Notes |
|-------|-----------|-------|
| 1 (highest) | `!` `-` `+` (unary), `&`, `&mut`, `*` (deref), `await` | Right-associative |
| 2 | `*` `/` | Left-associative |
| 3 | `+` `-` | Left-associative |
| 4 | `<` `<=` `>` `>=` | Left-associative |
| 5 | `==` `!=` `is` | Left-associative |
| 6 | `&&` | Left-associative |
| 7 | `\|\|` | Left-associative |
| 8 | `\|>` *(planned)* | Left-associative |
| 9 (lowest) | `=` `+=` `-=` `*=` `/=` | Right-associative |

```ebnf
Expression         = LambdaExpression | PipelineExpression ;

LambdaExpression   = "fn" "(" [ Parameters ] ")" [ ReturnType ] Block ;

PipelineExpression = LogicalOr { "|>" LogicalOr } ;
// Note: |> is not yet implemented.

LogicalOr          = LogicalAnd { "||" LogicalAnd } ;
LogicalAnd         = Equality { "&&" Equality } ;
Equality           = Comparison { (("==" | "!=") Comparison) | ("is" Type) } ;
Comparison         = Term { ("<" | "<=" | ">" | ">=") Term } ;
Term               = Factor { ("+" | "-") Factor } ;
Factor             = Unary { ("*" | "/") Unary } ;
Unary              = ("!" | "-" | "+" | "await") Unary
                   | "&" [ "mut" ] Unary
                   | "&" "raw" Unary
                   | "borrow" "(" Expression ")"
                   | "*" Unary
                   | Postfix ;

Postfix            = Primary { PostfixOp } [ "as" Type ] ;
PostfixOp          = "(" [ Arguments ] ")"
                   | "." Identifier
                   | "[" Expression "]" ;

Argument           = [ Identifier ":" ] Expression ;
Arguments          = Argument { "," Argument } ;
```

### Borrow and Pointer Expressions

| Form | Meaning | Safety |
|------|---------|--------|
| `&x` | Create shared borrow | Safe |
| `&mut x` | Create exclusive mutable borrow | Safe |
| `&raw x` | Create raw pointer from value | `unsafe` block only |
| `*ptr` | Dereference raw pointer | `unsafe` block only |
| `borrow(x)` | Explicit shared borrow | Safe |

The `as` operator performs type casts. Inside `unsafe` blocks it can cast between pointer types (`ptr as *i32`).

### Primary Expressions

```ebnf
Primary            = NumberLiteral
                   | StringLiteral
                   | "true" | "false" | "null"
                   | Identifier
                   | "(" Expression ")"
                   | ArrayLiteral
                   | ObjectLiteral
                   | StructLiteral ;

ArrayLiteral       = "[" [ Expression { "," Expression } ] "]" ;
ObjectLiteral      = "{" [ ObjectField { "," ObjectField } ] "}" ;
ObjectField        = Identifier ":" Expression ;
StructLiteral      = Identifier "{" [ StructField { "," StructField } ] "}" ;
StructField        = Identifier ":" Expression ;
```

## Types

```ebnf
Type               = UnionType ;
UnionType          = OptionalType { "|" OptionalType } ;
OptionalType       = SimpleType [ "?" ] ;
SimpleType         = ReferencePrefix PointerType ;
ReferencePrefix    = { "&" [ "mut" ] } ;
PointerType        = { "*" [ "mut" ] } BaseType ;
BaseType           = QualifiedName [ "<" Type { "," Type } ">" ]
                   | "opaque" ;
NominalType        = SimpleType ;
QualifiedName      = Identifier { "." Identifier } ;
```

### Type Quick Reference

| Syntax | Description |
|--------|-------------|
| `number` | 64-bit float (primary numeric type) |
| `string` | UTF-8 string |
| `boolean` | Boolean |
| `void` | No return value |
| `null` | Explicit absence of value |
| `T?` | Optional (`T` or `null`) |
| `A \| B` | Union type |
| `T[]` | Array / growable collection |
| `&T` | Shared borrow (read-only) — parsed, not enforced ([roadmap](/roadmap)) |
| `&mut T` | Exclusive mutable borrow — parsed, not enforced ([roadmap](/roadmap)) |
| `*T` | Raw read-only pointer (unsafe only) |
| `*mut T` | Raw mutable pointer (unsafe only) |
| `*opaque` | Opaque foreign pointer (`void*`) |

Sized numeric types for FFI / low-level code: `i8`–`i64`, `u8`–`u64`, `f32`,
`f64`, `usize`. The split of `number` into `int` (i64) / `float` (f64) is on
the [roadmap](/roadmap).

**Context-sensitivity of `&`**: In type position `A & B` is type intersection;
in expression position `&x` is a borrow. The grammar resolves this unambiguously.

## Patterns

```ebnf
Pattern            = "_"
                   | LiteralPattern
                   | IdentifierPattern
                   | ConstructorPattern ;

LiteralPattern     = NumberLiteral | StringLiteral | BooleanLiteral ;
IdentifierPattern  = Identifier ;
ConstructorPattern = Identifier "{" [ PatternField { "," PatternField } ] "}" ;
PatternField       = Identifier [ ":" Pattern ] ;
```

Guards attach to any match case: `Pattern [ "if" Expression ] "=>" ...`

## Literals

```ebnf
NumberLiteral      = Digit { Digit } [ "." Digit { Digit } ] ;
StringLiteral      = '"' { Character | Escape | Interpolation } '"' ;
Interpolation      = "{{" Expression "}}" ;
BooleanLiteral     = "true" | "false" ;
Identifier         = Letter { Letter | Digit | '_' } ;
```

String literals support `{{ expression }}` interpolation. Whitespace inside the
braces is ignored — `{{name}}` and `{{ name }}` are equivalent.

## Named Arguments

```ebnf
Argument = [ Identifier ":" ] Expression ;
```

Named arguments are supported in all call positions:

```sfn
chunk(by: "semantic", target_tokens: 512)
http.post(url, body: json_payload)
```

They do not affect overload resolution and exist for readability.

## Reserved Words

The following identifiers are reserved and may not appear where a plain
`Identifier` is expected:

`fn` `async` `await` `extern` `let` `mut` `unsafe` `struct` `enum`
`interface` `type` `import` `export` `if` `else` `for` `in` `while` `loop`
`match` `return` `break` `continue` `try` `catch` `finally` `throw` `model`
`tool` `pipeline` `test` `prompt` `system` `user` `assistant` `routine`
`scope` `with` `true` `false` `null` `assert`

The array syntax is `Type[]` (e.g. `number[]`, `string[]`). Arrays expose
`.length` and `.push(value)`.
