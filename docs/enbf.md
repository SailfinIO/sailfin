# Sailfin Grammar (EBNF)

(filename: `enbf.md`)

The Sailfin grammar is written using an extended Backus–Naur form that mirrors
current bootstrap behaviour while signalling upcoming AI-native features.
Non-terminals are written in `PascalCase`, terminals in double quotes.
Parentheses group expressions, square brackets denote optional elements, and
braces denote repetition (`{ x }` means zero or more occurrences of `x`).

```
Program            = { ImportDeclaration | ExportDeclaration | Declaration | Statement } ;

ImportDeclaration  = "import" ImportSpecifierList "from" StringLiteral ";" ;

ExportDeclaration  = "export" ImportSpecifierList [ "from" StringLiteral ] ";" ;

ImportSpecifierList = "{" [ ImportSpecifier { "," ImportSpecifier } ] "}" ;

ImportSpecifier    = Identifier [ "as" Identifier ] ;

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

StructDeclaration  = "struct" Identifier [ TypeParameters ]
                     [ "implements" NominalType { "," NominalType } ]
                     "{" { StructMember } "}" ;

StructMember       = FieldDeclaration | MethodDeclaration ;

TypeSep            = "->" | ":" ;
FieldDeclaration   = [ "mut" ] Identifier TypeSep Type ";" ;

MethodDeclaration  = { Decorator } [ "async" ] "fn" Identifier [ TypeParameters ]
                     "(" [ Parameters ] ")" [ TypeSep Type ] [ EffectList ] Block ;

InterfaceDeclaration = "interface" Identifier [ TypeParameters ]
                        "{" { FunctionSignature | PropertySignature } "}" ;
PropertySignature   = Identifier TypeSep Type ";" ;

FunctionSignature   = "fn" Identifier "(" [ Parameters ] ")"
                      [ TypeSep Type ] [ EffectList ] ";" ;

TypeAliasDeclaration = "type" Identifier [ TypeParameters ] "=" Type ";" ;

TypeParameters     = "<" TypeParameter { "," TypeParameter } ">" ;
TypeParameter      = Identifier [ ":" Type ] ;

FunctionDeclaration = { Decorator } { FunctionModifier }
                      "fn" Identifier [ TypeParameters ]
                      "(" [ Parameters ] ")"
                      [ TypeSep Type ] [ EffectList ] ( Block | ";" ) ;

FunctionModifier    = "async" | "unsafe" | "extern" ;

// Extern function declarations (FFI bindings to C libraries)
// When both "unsafe" and "extern" modifiers are present, the function
// declares an external C symbol. These declarations end with ";" instead
// of a block body.
//
// Examples:
//   unsafe extern fn malloc(size -> usize) -> *u8;
//   unsafe extern fn free(ptr -> *u8) -> void;
//   unsafe extern fn strlen(s -> *u8) -> usize;

PipelineDeclaration = "pipeline" Identifier "(" [ Parameters ] ")"
                      [ TypeSep Type ] [ EffectList ] Block ;

ToolDeclaration     = "tool" Identifier "(" [ Parameters ] ")"
                      [ TypeSep Type ] [ EffectList ] Block ;

ModelDeclaration    = "model" Identifier ":" Type [ EffectList ] ModelBlock ;
ModelBlock          = "{" { ModelProperty } "}" ;
ModelProperty       = Identifier "=" ModelValue ";" ;
ModelValue          = Expression | Type ;

TestDeclaration     = "test" ( Identifier | StringLiteral ) [ EffectList ] Block ;

Parameters         = Parameter { "," Parameter } ;
Parameter          = [ "mut" ] Identifier [ TypeSep Type ] [ "=" Expression ] ;

Decorator          = "@" QualifiedName [ "(" [ Arguments ] ")" ] ;

EffectList         = "![" EffectIdentifier { "," EffectIdentifier } "]" ;
EffectIdentifier   = Identifier ;

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

AssertStatement    = "assert" Expression ";" ;  // Bootstrap: no parentheses required

VariableDeclaration  = "let" [ "mut" ] Identifier [ TypeSep Type ]
                       [ "=" Expression ] ";" ;

IfStatement        = "if" Expression Block [ "else" ( IfStatement | Block ) ] ;

MatchStatement     = "match" Expression "{" { MatchCase [ "," ] } "}" ;

MatchCase          = Pattern [ "if" Expression ] "->"
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

PromptStatement    = "prompt" PromptChannel Block ;
// Bootstrap status: channels are parsed as identifiers; canonical channel names are
// system | user | assistant | tool (not enforced by the bootstrap lexer/parser).
PromptChannel      = Identifier ;

AssignmentStatement = Assignment ";" ;
Assignment         = Expression ( "=" | "+=" | "-=" | "*=" | "/=" ) Expression ;

ExpressionStatement = Expression ";" ;

Expression         = LambdaExpression | PipelineExpression ;

LambdaExpression   = "fn" "(" [ Parameters ] ")" [ TypeSep Type ] Block ;

// Planned (self-hosted target). The bootstrap parser does not implement the
// pipeline operator; this rule is included for design reference only. `|>`
// binds looser than all expression operators and associates left-to-right.
PipelineExpression = LogicalOr { "|>" LogicalOr } ;

LogicalOr          = LogicalAnd { "||" LogicalAnd } ;
LogicalAnd         = Equality { "&&" Equality } ;
Equality           = Comparison { (("==" | "!=") Comparison) | ("is" Type) } ;
Comparison         = Term { ("<" | "<=" | ">" | ">=") Term } ;
Term               = Factor { ("+" | "-") Factor } ;
Factor             = Unary { ("*" | "/") Unary } ;
Unary              = ("!" | "-" | "+" | "await") Unary
                   | "&" [ "mut" ] Unary           // Reference creation (&x, &mut x)
                   | "&" "raw" Unary               // Raw pointer creation (only in unsafe)
                   | "borrow" "(" Expression ")"   // Explicit borrow expression
                   | "*" Unary                     // Pointer dereference (only in unsafe)
                   | Postfix ;

// Pointer/Reference Expressions:
//   &x       — Create shared borrow (safe)
//   &mut x   — Create mutable borrow (safe)
//   &raw x   — Create raw pointer from value (requires unsafe)
//   *ptr     — Dereference raw pointer (requires unsafe)
//   borrow(x) — Explicit borrow expression (safe)

Postfix            = Primary { PostfixOp } [ "as" Type ] ;
PostfixOp          = "(" [ Arguments ] ")"
                   | "." Identifier
                   | "[" Expression "]" ;

// The "as" operator performs type casting. Inside unsafe blocks, it can
// cast between pointer types:
//   ptr as *i32       — Cast raw pointer to different element type
//   ptr as *u8        — Cast to byte pointer (for free, etc.)
//   value as f64      — Safe numeric conversion

Argument           = [ Identifier ":" ] Expression ;
Arguments          = Argument { "," Argument } ;

Primary            = NumberLiteral
                   | StringLiteral
                   | "true"
                   | "false"
                   | "null"
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

Type               = UnionType ;
UnionType          = OptionalType { "|" OptionalType } ;
OptionalType       = SimpleType [ "?" ] ;
SimpleType         = ReferencePrefix PointerType ;
ReferencePrefix    = { "&" [ "mut" ] } ;
PointerType        = { "*" [ "mut" ] } BaseType ;
BaseType           = QualifiedName [ "<" Type { "," Type } ">" ]
                   | "opaque" ;  // Opaque pointer target for foreign-managed memory
NominalType        = SimpleType ;
QualifiedName      = Identifier { "." Identifier } ;

// Pointer Types:
//   *T       — Read-only raw pointer to type T
//   *mut T   — Mutable raw pointer to type T
//   *opaque  — Opaque pointer to foreign-managed memory (equivalent to void*)
//
// Reference Types (safe, lifetime-tracked):
//   &T       — Shared borrow (read-only reference)
//   &mut T   — Exclusive mutable borrow
//
// Raw pointers (*T, *mut T) are only usable inside `unsafe` blocks.
// References (&T, &mut T) are the safe alternative with compile-time
// lifetime enforcement.

Pattern            = "_"
                   | LiteralPattern
                   | IdentifierPattern
                   | ConstructorPattern ;

LiteralPattern     = NumberLiteral | StringLiteral | BooleanLiteral ;
IdentifierPattern  = Identifier ;
ConstructorPattern = Identifier "{" [ PatternField { "," PatternField } ] "}" ;
PatternField       = Identifier [ ":" Pattern ] ;
```

### Literals

```
NumberLiteral      = Digit { Digit } [ "." Digit { Digit } ] ;
StringLiteral      = '"' { Character | Escape } '"' ;
BooleanLiteral     = "true" | "false" ;
Identifier         = Letter { Letter | Digit | '_' } ;
```

### String Interpolation

String literals support lightweight interpolation using double braces. Any
occurrence of `{{ expression }}` is evaluated at runtime against the current
scope. Whitespace at the edges of the expression is ignored (`{{name}}` == `{{ name }}`).
For example `"Hello, {{ name }}!"` becomes a formatted string.

Named arguments appear in both function calls and pipeline stages:

```
chunk(by: "semantic", target_tokens: 512)
```

The grammar’s `Argument` rule supports this form.

### Effects and Capability Tokens

Effect identifiers in `![ ... ]` lists are ordinary identifiers that must
correspond to capabilities granted via manifests (`sail.toml`, aggregated in
`fleet.toml`). The compiler uses these lists to enforce deterministic,
auditable use of I/O (`io`), networking (`net`), randomness (`rand`), model
invocation (`model`), accelerator usage (`gpu`), and clocks/timers (`clock`).

Bootstrap enforcement note: The stage0 effect checker validates only `model`,
`io`, and `net`. Other effect identifiers are parsed and recorded on
declarations but are not enforced in bootstrap.

### Prompt Blocks

`prompt` statements introduce model instruction blocks. They accept exactly one
channel keyword (`system`, `user`, `assistant`, or `tool`) followed by a block
that typically contains string literals and interpolation.

### Reserved Words

Keywords defined in `docs/keywords.md` are reserved and may not be used where
an `Identifier` is expected. `assert` is reserved for the statement form above.
Array sugar `Type[]` is deprecated; prefer `Vec<Type>`.
