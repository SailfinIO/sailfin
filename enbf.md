(_ ========================= _)
(_ PROGRAM _)
(_ ========================= _)

<program> ::= { <import_statement> } { <declaration> } <main_function>

(_ ========================= _)
(_ IMPORTS _)
(_ ========================= _)

<import_statement> ::= "import" "{" <import_items> "}" "from" <string_literal> ";"

<import_items> ::= <identifier> { "," <identifier> }

(_ ========================= _)
(_ DECLARATIONS _)
(_ ========================= _)

<declaration> ::= <struct_declaration>
| <enum_declaration>
| <interface_declaration>
| <type_alias_declaration>
| <function_declaration>
| <decorator_declaration>
| <constant_declaration>
| <variable_declaration>

(_ ------------------------- _)
(_ STRUCTS _)
(_ ------------------------- _)

<struct_declaration> ::= "struct" <identifier> "{" { <struct_member> } "}"

<struct_member> ::= <field_declaration> | <function_declaration>

<field_declaration> ::= [ "mut" ] <identifier> "->" <type> ";"

(_ ------------------------- _)
(_ ENUMS _)
(_ ------------------------- _)

<enum_declaration> ::= "enum" <identifier> "{" { <enum_variant> [ "," ] } "}"

<enum_variant> ::= <identifier> [ "{" { <field_declaration> } "}" ]

(_ ------------------------- _)
(_ INTERFACES _)
(_ ------------------------- _)

<interface_declaration> ::= "interface" <identifier> "{" { <interface_member> } "}"

<interface_member> ::= <function_signature>

<function_signature> ::= "fn" <identifier> "(" [ <parameters> ] ")" "->" <type> ";"

(_ ------------------------- _)
(_ TYPE ALIASES _)
(_ ------------------------- _)

<type_alias_declaration> ::= "type" <identifier> "=" <type> ";"

(_ ------------------------- _)
(_ FUNCTION DECLARATION _)
(_ ------------------------- _)

<function_declaration> ::= [ <decorator> ] "fn" <identifier> "(" [ <parameters> ] ")" [ "->" <type> ] "{" { <statement> } "}"

<decorator> ::= "@" <identifier>

<parameters> ::= <parameter> { "," <parameter> }

<parameter> ::= <identifier> [ "->" <type> ]

(_ ------------------------- _)
(_ MAIN FUNCTION _)
(_ ------------------------- _)

<main_function> ::= <function_declaration>

(_ ========================= _)
(_ TYPES _)
(_ ========================= _)

<type> ::= <primitive_type>
| <identifier>
| <generic_type>
| <union_type>
| <intersection_type>
| <array_type>
| <function_type>
| <optional_type>
| "(" <type> ")"

<primitive_type> ::= "number" | "string" | "boolean" | "void" | "null" | "any"

<generic_type> ::= <identifier> "<" <type> { "," <type> } ">"

<union_type> ::= <type> "|" <type>

<intersection_type> ::= <type> "&" <type>

<array_type> ::= <type> "[]"

<function_type> ::= "fn" "(" [ <parameters> ] ")" "->" <type>

<optional_type> ::= <type> "?"

(_ ========================= _)
(_ STATEMENTS _)
(_ ========================= _)

<statement> ::= <variable_declaration>
| <constant_declaration>
| <assignment>
| <if_statement>
| <match_statement>
| <try_catch_finally>
| <return_statement>
| <expression_statement>
| <routine_declaration>
| <import_statement>
| <type_alias_declaration>

(_ ------------------------- _)
(_ VARIABLE DECLARATION _)
(_ ------------------------- _)

<variable_declaration> ::= [ "mut" ] "let" <identifier> [ "->" <type> ] [ "=" <expression> ] ";"

<constant_declaration> ::= "const" "let" <identifier> [ "->" <type> ] "=" <expression> ";"

(_ ------------------------- _)
(_ ASSIGNMENT _)
(_ ------------------------- _)

<assignment> ::= <lvalue> "=" <expression> ";"

<lvalue> ::= <identifier> | <member_access> | <array_access>

<member_access> ::= <lvalue> "." <identifier>

<array_access> ::= <lvalue> "[" <expression> "]"

(_ ------------------------- _)
(_ CONDITIONALS _)
(_ ------------------------- _)

<if_statement> ::= "if" "(" <expression> ")" <block> [ "else if" "(" <expression> ")" <block> ] [ "else" <block> ]

<match_statement> ::= "match" <expression> "{" { <match_case> } "}"

<match_case> ::= <pattern> "=>" <block>

<pattern> ::= <literal>
| <identifier>
| <constructor*pattern>
| "*"

<constructor_pattern> ::= <identifier> "{" { <identifier> [ "," ] } "}" [ "if" <expression> ]

(_ ------------------------- _)
(_ TRY CATCH FINALLY _)
(_ ------------------------- _)

<try_catch_finally> ::= "try" <block> "catch" "(" <identifier> [ "as" <identifier> ] ")" <block> [ "finally" <block> ]

(_ ------------------------- _)
(_ RETURN STATEMENT _)
(_ ------------------------- _)

<return_statement> ::= "return" [ <expression> ] ";"

(_ ------------------------- _)
(_ EXPRESSION STATEMENT _)
(_ ------------------------- _)

<expression_statement> ::= <expression> ";"

(_ ------------------------- _)
(_ ROUTINE DECLARATION _)
(_ ------------------------- _)

<routine_declaration> ::= "routine" [ <routine_name> ] "{" { <statement> } "}"

<routine_name> ::= <string_literal>

(_ ------------------------- _)
(_ BLOCK _)
(_ ------------------------- _)

<block> ::= "{" { <statement> } "}"

(_ ========================= _)
(_ EXPRESSIONS _)
(_ ========================= _)

<expression> ::= <assignment_expression>
| <logical_or_expression>

<assignment_expression> ::= <lvalue> "=" <logical_or_expression>

<logical_or_expression> ::= <logical_and_expression> { "||" <logical_and_expression> }

<logical_and_expression> ::= <equality_expression> { "&&" <equality_expression> }

<equality_expression> ::= <relational_expression> { ( "==" | "!=" ) <relational_expression> }

<relational_expression> ::= <additive_expression> { ( "<" | ">" | "<=" | ">=" ) <additive_expression> }

<additive_expression> ::= <multiplicative_expression> { ( "+" | "-" ) <multiplicative_expression> }

<multiplicative_expression> ::= <unary_expression> { ( "\*" | "/" | "%" ) <unary_expression> }

<unary_expression> ::= [ ( "!" | "-" ) ] <primary_expression>

<primary_expression> ::= <literal>
| <identifier>
| <function_call>
| <member_access>
| <array_access>
| "(" <expression> ")"
| <lambda_expression>

<lambda_expression> ::= "fn" "(" [ <parameters> ] ")" "->" <type> "{" { <statement> } "}"

<function_call> ::= <identifier> "(" [ <arguments> ] ")"

<arguments> ::= <expression> { "," <expression> }

<literal> ::= <number_literal>
| <string_literal>
| <boolean_literal>
| "null"

<number_literal> ::= [ "-" ] <digit> { <digit> } [ "." <digit> { <digit> } ]

<string_literal> ::= "\"" { <string_character> } "\""

<boolean_literal> ::= "true" | "false"

<string_character> ::= ? any character except " and \ ?

<identifier> ::= <letter> { <letter> | <digit> | "\_" }

<digit> ::= "0" | "1" | "2" | "3" | "4" | "5" | "6" | "7" | "8" | "9"

<letter> ::= "A" | ... | "Z" | "a" | ... | "z"

(_ ========================= _)
(_ TYPES _)
(_ ========================= _)

<type_declaration> ::= <struct_declaration>
| <enum_declaration>
| <interface_declaration>
| <type_alias_declaration>

(_ ========================= _)
(_ MAIN _)
(_ ========================= _)

<main_function> ::= "fn" "main" "(" ")" [ "->" <type> ] "{" { <statement> } "}"

(_ ========================= _)
(_ COMMENTS _)
(_ ========================= _)

(_ Assuming single-line and multi-line comments _)
<comment> ::= "//" { <any_character_except_newline> } "\n"
| "/_" { <any_character_except_star_slash> } "_/"

(_ ========================= _)
(_ OPERATORS _)
(_ ========================= _)

(_ Define operator precedence and associativity if needed _)

(_ ========================= _)
(_ ADDITIONAL RULES _)
(_ ========================= _)

(_ You can add more rules here to cover other language features like generics constraints, decorators, etc. _)
