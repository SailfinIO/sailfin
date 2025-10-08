# Sailfin Grammar (EBNF)

The Sailfin grammar is written using an extended Backus–Naur form that mirrors
current bootstrap behaviour while signalling upcoming AI-native features.
Non-terminals are written in `PascalCase`, terminals in double quotes.
Parentheses group expressions, square brackets denote optional elements, and
braces denote repetition (`{ x }` means zero or more occurrences of `x`).

```
Program            = { ImportDeclaration | Declaration | Statement } ;

ImportDeclaration  = "import" "{" [ Identifier { "," Identifier } ] "}" "from"
                     StringLiteral ";" ;

Declaration        = StructDeclaration
                   | EnumDeclaration
                   | InterfaceDeclaration
                   | FunctionDeclaration
                   | PipelineDeclaration
                   | ToolDeclaration
                   | ModelDeclaration
                   | TestDeclaration
                   | TypeAliasDeclaration
                   | VariableDeclaration
                   | ConstantDeclaration ;

StructDeclaration  = "struct" Identifier [ TypeParameters ]
                     [ "implements" NominalType { "," NominalType } ]
                     "{" { StructMember } "}" ;

StructMember       = FieldDeclaration | MethodDeclaration ;

FieldDeclaration   = [ "mut" ] Identifier "->" Type ";" ;

MethodDeclaration  = { Decorator } [ "async" ] "fn" Identifier [ TypeParameters ]
                     "(" [ Parameters ] ")" [ "->" Type ] [ EffectList ] Block ;

InterfaceDeclaration = "interface" Identifier [ TypeParameters ]
                        "{" { FunctionSignature } "}" ;

FunctionSignature   = "fn" Identifier "(" [ Parameters ] ")"
                      [ "->" Type ] [ EffectList ] ";" ;

TypeAliasDeclaration = "type" Identifier [ TypeParameters ] "=" Type ";" ;

TypeParameters     = "<" TypeParameter { "," TypeParameter } ">" ;
TypeParameter      = Identifier [ ":" Type ] ;

FunctionDeclaration = { Decorator } [ "async" ] "fn" Identifier
                       [ TypeParameters ] "(" [ Parameters ] ")"
                       [ "->" Type ] [ EffectList ] Block ;

PipelineDeclaration = "pipeline" Identifier "(" [ Parameters ] ")"
                      [ "->" Type ] [ EffectList ] Block ;

ToolDeclaration     = "tool" Identifier "(" [ Parameters ] ")"
                      [ "->" Type ] [ EffectList ] Block ;

ModelDeclaration    = "model" Identifier ":" Type [ EffectList ] ModelBlock ;
ModelBlock          = "{" { ModelProperty } "}" ;
ModelProperty       = Identifier "=" ModelValue ";" ;
ModelValue          = Expression | Type ;

TestDeclaration     = "test" ( Identifier | StringLiteral ) [ EffectList ] Block ;

Parameters         = Parameter { "," Parameter } ;
Parameter          = [ "mut" ] Identifier [ "->" Type ] [ "=" Expression ] ;

Decorator          = "@" QualifiedName [ "(" [ Arguments ] ")" ] ;

EffectList         = "![" EffectIdentifier { "," EffectIdentifier } "]" ;
EffectIdentifier   = Identifier ;

Block              = "{" { Statement } "}" ;

Statement          = VariableDeclaration
                   | ConstantDeclaration
                   | IfStatement
                   | MatchStatement
                   | TryStatement
                   | RoutineDeclaration
                   | ReturnStatement
                   | ThrowStatement
                   | WithStatement
                   | PromptStatement
                   | AssertStatement
                   | Block
                   | AssignmentStatement
                   | ExpressionStatement ;

AssertStatement    = "assert" "(" Expression ")" ";" ;

VariableDeclaration  = "let" [ "mut" ] Identifier [ "->" Type ]
                       [ "=" Expression ] ";" ;

ConstantDeclaration  = "const" Identifier [ "->" Type ] "=" Expression ";" ;

IfStatement        = "if" Expression Block [ "else" ( IfStatement | Block ) ] ;

MatchStatement     = "match" Expression "{" { MatchCase [ "," ] } "}" ;

MatchCase          = Pattern [ "if" Expression ] "->"
                     ( Block | InlineExpression ) ;

InlineExpression   = Expression [ ";" ] ;

TryStatement       = "try" Block [ "catch" [ "(" Identifier ")" ] Block ]
                     [ "finally" Block ] ;

RoutineDeclaration = "routine" [ Expression ] Block ;

ReturnStatement    = "return" [ Expression ] ";" ;

ThrowStatement     = "throw" Expression ";" ;

WithStatement      = "with" WithClause { "," WithClause } Block ;
WithClause         = Identifier "(" [ Arguments ] ")" ;

PromptStatement    = "prompt" PromptChannel Block ;
PromptChannel      = "system" | "user" | "assistant" | "tool" ;

AssignmentStatement = Assignment ";" ;
Assignment         = Expression ( "=" | "+=" | "-=" | "*=" | "/=" ) Expression ;

ExpressionStatement = Expression ";" ;

Expression         = LambdaExpression | PipelineExpression ;

LambdaExpression   = "fn" "(" [ Parameters ] ")" [ "->" Type ] [ EffectList ] Block ;

PipelineExpression = LogicalOr { "|>" LogicalOr } ;

LogicalOr          = LogicalAnd { "||" LogicalAnd } ;
LogicalAnd         = Equality { "&&" Equality } ;
Equality           = Comparison { ("==" | "!=") Comparison } ;
Comparison         = Term { ("<" | "<=" | ">" | ">=") Term } ;
Term               = Factor { ("+" | "-") Factor } ;
Factor             = Unary { ("*" | "/") Unary } ;
Unary              = ("!" | "-" | "+" | "await") Unary | Postfix ;

Postfix            = Primary { PostfixOp } ;
PostfixOp          = "(" [ Arguments ] ")"
                   | "." Identifier
                   | "[" Expression "]" ;

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
                   | StructLiteral ;

ArrayLiteral       = "[" [ Expression { "," Expression } ] "]" ;

StructLiteral      = Identifier "{" [ StructField { "," StructField } ] "}" ;
StructField        = Identifier ":" Expression ;

Type               = UnionType ;
UnionType          = OptionalType { "|" OptionalType } ;
OptionalType       = SimpleType [ "?" ] ;
SimpleType         = QualifiedName [ "<" Type { "," Type } ">" ] ;
NominalType        = SimpleType ;
QualifiedName      = Identifier { "." Identifier } ;

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

### Prompt Blocks

`prompt` statements introduce model instruction blocks. They accept exactly one
channel keyword (`system`, `user`, `assistant`, or `tool`) followed by a block
that typically contains string literals and interpolation.

### Reserved Words

Keywords defined in `docs/keywords.md` are reserved and may not be used where
an `Identifier` is expected. `assert` is reserved for the statement form above.
Array sugar `Type[]` is deprecated; prefer `Vec<Type>`.
