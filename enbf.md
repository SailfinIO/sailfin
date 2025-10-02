# Sailfin Grammar (EBNF)

The Sailfin grammar is written using an extended Backus–Naur form that mirrors
the behaviour of the bootstrap parser. Non-terminals are written in
`PascalCase`, terminals in double quotes. Parentheses group expressions, square
brackets denote optional elements, and braces denote repetition (`{ x }`
means zero or more occurrences of `x`).

```
Program           = { ImportDeclaration | Declaration | Statement } ;

ImportDeclaration = "import" "{" [ Identifier { "," Identifier } ] "}" "from"
                    StringLiteral ";" ;

Declaration       = StructDeclaration
                  | EnumDeclaration
                  | FunctionDeclaration
                  | TypeAliasDeclaration
                  | VariableDeclaration
                  | ConstantDeclaration ;

StructDeclaration = "struct" Identifier [ TypeParameters ]
                    [ "implements" NominalType { "," NominalType } ]
                    "{" { StructMember } "}" ;

StructMember      = FieldDeclaration | MethodDeclaration ;

FieldDeclaration  = [ "mut" ] [ "let" ] Identifier "->" Type ";" ;

MethodDeclaration = { Decorator } [ "async" ] "fn" Identifier [ TypeParameters ]
                    "(" [ Parameters ] ")" [ "->" Type ] Block ;

InterfaceDeclaration = "interface" Identifier [ TypeParameters ]
                       "{" { FunctionSignature } "}" ;

FunctionSignature  = "fn" Identifier "(" [ Parameters ] ")"
                     [ "->" Type ] ";" ;

TypeAliasDeclaration = "type" Identifier [ TypeParameters ] "=" Type ";" ;

TypeParameters    = "<" TypeParameter { "," TypeParameter } ">" ;
TypeParameter     = Identifier [ ":" Type ] ;

FunctionDeclaration = { Decorator } [ "async" ] "fn" Identifier
                      [ TypeParameters ] "(" [ Parameters ] ")"
                      [ "->" Type ] Block ;

Parameters        = Parameter { "," Parameter } ;
Parameter         = [ "mut" ] Identifier [ "->" Type ] [ "=" Expression ] ;

Decorator         = "@" QualifiedName [ "(" [ Arguments ] ")" ] ;

Block             = "{" { Statement } "}" ;

Statement         = VariableDeclaration
                  | ConstantDeclaration
                  | IfStatement
                  | MatchStatement
                  | TryStatement
                  | RoutineDeclaration
                  | ReturnStatement
                  | ThrowStatement
                  | Block
                  | AssignmentStatement
                  | ExpressionStatement ;

VariableDeclaration = "let" [ "mut" ] Identifier [ "->" Type ]
                      [ "=" Expression ] ";" ;

ConstantDeclaration = "const" Identifier [ "->" Type ] "=" Expression ";" ;

IfStatement       = "if" Expression Block [ "else" ( IfStatement | Block ) ] ;

MatchStatement    = "match" Expression "{" { MatchCase [ "," ] } "}" ;

MatchCase         = Pattern [ "if" Expression ] "->"
                    ( Block | InlineExpression ) ;

InlineExpression  = Expression [ ";" ] ;

TryStatement      = "try" Block [ "catch" [ "(" Identifier ")" ] Block ]
                    [ "finally" Block ] ;

RoutineDeclaration = "routine" Block ;

ReturnStatement   = "return" [ Expression ] ";" ;

ThrowStatement    = "throw" Expression ";" ;

AssignmentStatement = Assignment ";" ;
Assignment        = Expression ( "=" | "+=" | "-=" | "*=" | "/=" ) Expression ;

ExpressionStatement = Expression ";" ;

Expression        = LambdaExpression | LogicalOr ;

LambdaExpression  = "fn" "(" [ Parameters ] ")" [ "->" Type ] Block ;

LogicalOr         = LogicalAnd { "||" LogicalAnd } ;
LogicalAnd        = Equality { "&&" Equality } ;
Equality          = Comparison { ("==" | "!=") Comparison } ;
Comparison        = Term { ("<" | "<=" | ">" | ">=") Term } ;
Term              = Factor { ("+" | "-") Factor } ;
Factor            = Unary { ("*" | "/") Unary } ;
Unary             = ("!" | "-" | "+" | "await") Unary | Postfix ;

Postfix           = Primary { PostfixOp } ;
PostfixOp         = "(" [ Arguments ] ")"
                  | "." Identifier
                  | "[" Expression "]" ;

Arguments         = Expression { "," Expression } ;

Primary           = NumberLiteral
                  | StringLiteral
                  | "true"
                  | "false"
                  | "null"
                  | Identifier
                  | "(" Expression ")"
                  | ArrayLiteral
                  | StructLiteral ;

ArrayLiteral      = "[" [ Expression { "," Expression } ] "]" ;

StructLiteral     = Identifier "{" [ StructField { "," StructField } ] "}" ;
StructField       = Identifier ":" Expression ;

Type              = SimpleType [ "?" ] { "|" Type } ;
SimpleType        = QualifiedName [ "<" Type { "," Type } ">" ] ;
NominalType       = SimpleType ;
QualifiedName     = Identifier { "." Identifier } ;

Pattern           = "_"
                  | LiteralPattern
                  | IdentifierPattern
                  | ConstructorPattern ;

LiteralPattern    = NumberLiteral | StringLiteral ;
IdentifierPattern = Identifier ;
ConstructorPattern = Identifier "{" [ PatternField { "," PatternField } ] "}" ;
PatternField      = Identifier [ ":" Pattern ] ;
```

### Literals

```
NumberLiteral     = Digit { Digit } [ "." Digit { Digit } ] ;
StringLiteral     = '"' { Character | Escape } '"' ;
Identifier        = Letter { Letter | Digit | '_' } ;
```

### String Interpolation

String literals support lightweight interpolation using double braces. Any
occurrence of `{{ expression }}` is evaluated at runtime against the current
scope. For example `"Hello, {{name}}!"` becomes an f-style formatted string.

### Reserved Words

Keywords defined in `docs/keywords.md` are reserved and may not be used where
an `Identifier` is expected.
