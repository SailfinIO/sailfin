import sys
import ply.yacc as yacc
from lexer import tokens
from ast_nodes import *
from errors import ParserError

# Force parser regeneration by adding version comment
# Version: function_expression_support_v8_lambda

# Precedence rules to resolve ambiguity
precedence = (
    ('left', 'COMMA'),
    ('right', 'NOT'),
    ('left', 'OR'),
    ('left', 'AND'),
    ('left', 'EQ', 'NEQ'),
    ('left', 'LT', 'GT', 'LEQ', 'GEQ'),
    ('left', 'IS'),
    ('left', 'PLUS', 'MINUS'),
    ('left', 'MULTIPLY', 'DIVIDE'),
    ('left', 'DOT'),
    ('right', 'ARROW'),
    ('right', 'FAT_ARROW'),
    ('right', 'UMINUS'),
    ('left', 'AMP'),
    ('left', 'PIPE'),
    ('right', 'ASSIGN', 'PLUS_ASSIGN', 'MINUS_ASSIGN',
     'MULTIPLY_ASSIGN', 'DIVIDE_ASSIGN'),
    ('left', 'LBRACE'),
    ('left', 'IDENTIFIER'),
    ('left', 'MATCH'),
)


def stringify_type(node):
    """
    Turn a type-AST node back into the simple string form
    your validator expects (e.g. Identifier -> "Foo",
    ArrayType -> "Foo[]", UnionType -> "A|B", etc.).
    """
    if isinstance(node, Identifier):
        return node.name
    if isinstance(node, ArrayType):
        return f"{stringify_type(node.element_type)}[]"
    if isinstance(node, OptionalType):
        return f"{stringify_type(node.base)}?"
    if isinstance(node, UnionType):
        return f"{stringify_type(node.left)}|{stringify_type(node.right)}"
    if isinstance(node, IntersectionType):
        return f"{stringify_type(node.left)}&{stringify_type(node.right)}"
    if isinstance(node, TypeApplication):
        # just treat the base name (validator doesn’t check generics)
        return stringify_type(node.base)
    # fallback
    return str(node)

# -------------------- Program -------------------- #


def p_program(p):
    '''program : statements'''
    p[0] = Program(statements=p[1])

# -------------------- Statements -------------------- #


def p_statements_multiple(p):
    '''statements : statements statement'''
    p[0] = p[1] + [p[2]]


def p_statements_single(p):
    '''statements : statement'''
    p[0] = [p[1]]

# -------------------- Empty Rule -------------------- #


def p_empty(p):
    'empty :'
    p[0] = None

# -------------------- Statement Rule -------------------- #


def p_statement(p):
    '''statement : print_statement
                 | throw_statement
                 | assert_statement
                 | variable_declaration
                 | constant_declaration
                 | function_declaration
                 | struct_declaration
                 | interface_declaration
                 | enum_declaration
                 | match_statement
                 | if_statement
                 | return_statement
                 | expression_statement
                 | import_statement
                 | type_alias_declaration
                 | try_finally
                 | try_catch_finally
                 | while_loop
                 | for_loop
                 | test_declaration
                 | routine_statement'''
    p[0] = p[1]


# -------------------- Print Statement -------------------- #


def p_print_statement(p):
    '''print_statement : PRINT DOT INFO LPAREN expression RPAREN SEMICOLON'''
    p[0] = PrintStatement(expression=p[5])

# -------------------- Throw Statement -------------------- #


def p_throw_statement(p):
    '''throw_statement : THROW expression SEMICOLON'''
    p[0] = ThrowStatement(expression=p[2])

# -------------------- Assert Statement -------------------- #


def p_assert_statement(p):
    '''assert_statement : ASSERT expression SEMICOLON'''
    p[0] = AssertStatement(condition=p[2])

# -------------------- Routine Statement -------------------- #


def p_routine_statement_named(p):
    '''routine_statement : ROUTINE STRING LBRACE statements_opt RBRACE'''
    p[0] = ExpressionStatement(expression=Routine(name=p[2], body=p[4] if p[4] else []))


def p_routine_statement_unnamed(p):
    '''routine_statement : ROUTINE LBRACE statements_opt RBRACE'''
    p[0] = ExpressionStatement(expression=Routine(name=None, body=p[3] if p[3] else []))

# -------------------- Variable Declarations -------------------- #


def p_variable_declaration_let(p):
    'variable_declaration : LET IDENTIFIER type_opt ASSIGN expression SEMICOLON'
    p[0] = VariableDeclaration(
        name=p[2], var_type=p[3], value=p[5], mutable=False)


def p_variable_declaration_mut(p):
    'variable_declaration : MUT IDENTIFIER type_opt ASSIGN expression SEMICOLON'
    p[0] = VariableDeclaration(
        name=p[2], var_type=p[3], value=p[5], mutable=True)


def p_mut_opt(p):
    '''mut_opt : MUT
               | empty'''
    p[0] = True if p[1] == 'mut' else False

# Updated: now expects COLON type (instead of ARROW type).


def p_type_opt(p):
    '''type_opt : COLON type
                | empty'''
    p[0] = p[2] if len(p) > 2 else None

# -------------------- Constant Declarations -------------------- #


def p_constant_declaration(p):
    '''constant_declaration : CONST IDENTIFIER type_opt ASSIGN expression SEMICOLON'''
    name = p[2]
    var_type = p[3]
    value = p[5]
    p[0] = ConstantDeclaration(name=name, var_type=var_type, value=value)

# -------------------- Type Alias Declarations -------------------- #


def p_type_alias_declaration(p):
    '''type_alias_declaration : IDENTIFIER IDENTIFIER ASSIGN type SEMICOLON'''
    name = p[2]
    aliased_type = p[4]
    p[0] = TypeAliasDeclaration(name=name, aliased_type=aliased_type)

# -------------------- Function Declarations -------------------- #


def p_opt_return_type(p):
    '''opt_return_type : ARROW type_expr
                       | empty'''
    if len(p) == 3:
        p[0] = p[2]
    else:
        p[0] = None


def p_function_declaration(p):
    '''function_declaration : decorators_opt FN IDENTIFIER LPAREN parameters RPAREN opt_return_type block
                            | ASYNC FN IDENTIFIER LPAREN parameters RPAREN opt_return_type block'''
    if len(p) == 9 and p[1] != 'async':  # decorators_opt FN ...
        p[0] = FunctionDeclaration(
            name=p[3],
            params=p[5],
            return_type=p[7] if p[7] is not None else 'void',
            body=p[8],
            decorators=p[1] if p[1] else [],
            is_async=False
        )
    elif len(p) == 9 and p[1] == 'async':  # ASYNC FN ...
        p[0] = FunctionDeclaration(
            name=p[3],
            params=p[5],
            return_type=p[7] if p[7] is not None else 'void',
            body=p[8],
            decorators=[],
            is_async=True
        )


def p_function_declaration_async_with_decorators(p):
    '''function_declaration : decorators ASYNC FN IDENTIFIER LPAREN parameters RPAREN opt_return_type block'''
    p[0] = FunctionDeclaration(
        name=p[4],
        params=p[6],
        return_type=p[8] if p[8] is not None else 'void',
        body=p[9],
        decorators=p[1],
        is_async=True
    )


def p_decorators_opt(p):
    '''decorators_opt : decorators
                      | empty'''
    p[0] = p[1] if p[1] else []


def p_decorators(p):
    '''decorators : decorators decorator
                  | decorator'''
    if len(p) == 3:
        p[0] = p[1] + [p[2]]
    else:
        p[0] = [p[1]]


def p_decorator(p):
    '''decorator : AT IDENTIFIER'''
    p[0] = p[2]

# -------------------- Struct Declarations -------------------- #


def p_struct_declaration(p):
    '''struct_declaration : STRUCT IDENTIFIER implements_opt LBRACE struct_members RBRACE'''
    name = p[2]
    interfaces = p[3]
    members = p[5]
    p[0] = StructDeclaration(name=name, members=members, interfaces=interfaces)


def p_implements_opt(p):
    '''implements_opt : IMPLEMENTS interface_list
                      | empty'''
    p[0] = p[2] if len(p) > 2 else []


def p_interface_list(p):
    '''interface_list : interface_list COMMA IDENTIFIER
                      | IDENTIFIER'''
    if len(p) == 4:
        p[0] = p[1] + [p[3]]
    else:
        p[0] = [p[1]]
    # ... existing code ...


def p_struct_members(p):
    '''struct_members : struct_members struct_member
                     | struct_member'''
    if len(p) == 3:
        p[0] = p[1] + [p[2]]
    else:
        p[0] = [p[1]]


def p_struct_member(p):
    '''struct_member : field_declaration
                     | method_declaration'''
    p[0] = p[1]

# -------------------- Field Declarations -------------------- #

# Updated: now uses COLON for field type annotations.


def p_field_declaration(p):
    '''field_declaration : mut_opt IDENTIFIER COLON type SEMICOLON'''
    name = p[2]
    field_type = p[4]
    mutable = p[1]
    p[0] = FieldDeclaration(name=name, field_type=field_type, mutable=mutable)

# -------------------- Method Declarations -------------------- #

# Updated: method declarations now use the same return type syntax as functions.


def p_method_declaration(p):
    '''method_declaration : decorators_opt FN IDENTIFIER LPAREN parameters RPAREN opt_return_type block'''
    decorators = p[1]
    is_async = False  # Extend to support async methods if needed
    return_type = p[7] if p[7] is not None else 'void'
    body = p[8]
    p[0] = MethodDeclaration(
        name=p[3],
        params=p[5],
        return_type=return_type,
        body=body,
        decorators=decorators,
        is_async=is_async
    )

# -------------------- Interface Declarations -------------------- #


def p_interface_declaration(p):
    '''interface_declaration : INTERFACE IDENTIFIER colon_opt LBRACE interface_members RBRACE'''
    name = p[2]
    methods = p[5]
    p[0] = InterfaceDeclaration(name=name, methods=methods)


def p_colon_opt(p):
    '''colon_opt : COLON
                 | empty'''
    p[0] = None


def p_interface_members(p):
    '''interface_members : interface_members interface_method
                         | interface_method'''
    if len(p) == 3:
        p[0] = p[1] + [p[2]]
    else:
        p[0] = [p[1]]


def p_interface_method(p):
    '''interface_method : FN IDENTIFIER LPAREN parameters RPAREN ARROW type SEMICOLON
                        | FN IDENTIFIER LPAREN parameters RPAREN SEMICOLON'''
    name = p[2]
    params = p[4]
    if len(p) == 9:
        return_type = p[7]
    else:
        return_type = 'void'
    p[0] = InterfaceMethod(name=name, params=params, return_type=return_type)

# -------------------- Enum Declarations -------------------- #


def p_enum_declaration(p):
    '''enum_declaration : ENUM IDENTIFIER LBRACE enum_variants_opt RBRACE'''
    name = p[2]
    variants = p[4]
    p[0] = EnumDeclaration(name=name, variants=variants)


def p_enum_variants_opt(p):
    '''enum_variants_opt : enum_variants optional_comma
                         | empty'''
    p[0] = p[1] if p[1] else []


def p_enum_variants(p):
    '''enum_variants : enum_variants COMMA enum_variant
                     | enum_variant'''
    if len(p) == 4:
        p[0] = p[1] + [p[3]]
    else:
        p[0] = [p[1]]


# New production: enum variant with an assignment (for reserved enums)
def p_enum_variant_assignment(p):
    '''enum_variant : IDENTIFIER ASSIGN STRING'''
    # For a variant like: Fn = "FN"
    p[0] = EnumVariant(name=p[1], value=p[3])


# Existing production: enum variant without an assignment
def p_enum_variant(p):
    '''enum_variant : IDENTIFIER
                    | IDENTIFIER LBRACE enum_fields RBRACE'''
    if len(p) == 2:
        p[0] = EnumVariant(name=p[1])
    else:
        p[0] = EnumVariant(name=p[1], fields=p[3])


def p_enum_field_declaration(p):
    '''enum_field_declaration : IDENTIFIER COLON type'''
    p[0] = FieldDeclaration(name=p[1], field_type=p[3], mutable=False)


def p_enum_fields(p):
    '''enum_fields : enum_fields COMMA enum_field_declaration
                   | enum_field_declaration'''
    if len(p) == 4:
        p[0] = p[1] + [p[3]]
    else:
        p[0] = [p[1]]


def p_optional_comma(p):
    '''optional_comma : COMMA
                      | empty'''
    pass


# -------------------- Array Literals -------------------- #


def p_expression_array_literal(p):
    'expression : LBRACKET array_elements RBRACKET'
    p[0] = ArrayLiteral(elements=p[2])


def p_array_elements_multiple(p):
    'array_elements : array_elements COMMA expression'
    p[0] = p[1] + [p[3]]


def p_array_elements_single(p):
    'array_elements : expression'
    p[0] = [p[1]]


# -------------------- Dictionary Literals -------------------- #


def p_expression_dictionary_literal(p):
    'expression : LBRACE dictionary_pairs RBRACE'
    p[0] = DictionaryLiteral(pairs=p[2])


def p_expression_dictionary_literal_empty(p):
    'expression : LBRACE RBRACE'
    p[0] = DictionaryLiteral(pairs=[])


def p_dictionary_pairs_multiple(p):
    'dictionary_pairs : dictionary_pairs COMMA dictionary_pair'
    p[0] = p[1] + [p[3]]


def p_dictionary_pairs_single(p):
    'dictionary_pairs : dictionary_pair'
    p[0] = [p[1]]


def p_dictionary_pair(p):
    'dictionary_pair : expression COLON expression'
    p[0] = (p[1], p[3])


def p_array_elements_empty(p):
    'array_elements : empty'
    p[0] = []

# -------------------- While Loops -------------------- #


def p_while_loop(p):
    'while_loop : WHILE expression block'
    p[0] = WhileLoop(condition=p[2], body=p[3])

# -------------------- For Loops -------------------- #


def p_for_loop(p):
    'for_loop : FOR IDENTIFIER IN expression block'
    p[0] = ForLoop(variable=p[2], iterable=p[4], body=p[5])

# -------------------- Match Statements -------------------- #


def p_match_statement(p):
    '''match_statement : MATCH expression match_block %prec MATCH'''
    p[0] = MatchStatement(condition=p[2], arms=p[3])


def p_match_block(p):
    '''match_block : LBRACE match_arms RBRACE'''
    p[0] = p[2]


def p_match_arms(p):
    '''match_arms : match_arm_list
                   | match_arm_list COMMA
                   | empty'''
    p[0] = p[1] if p[1] is not None else []


def p_match_arm_list(p):
    '''match_arm_list : match_arm_list COMMA match_arm
                      | match_arm'''
    if len(p) == 4:
        p[0] = p[1] + [p[3]]
    else:
        p[0] = [p[1]]


def p_guard_opt(p):
    '''guard_opt : IF expression
                 | empty'''
    if len(p) == 3:
        p[0] = p[2]
    else:
        p[0] = None


def p_match_arm(p):
    '''match_arm : match_pattern guard_opt match_arrow match_arm_body'''
    p[0] = MatchArm(pattern=p[1], guard=p[2], body=p[4])


def p_match_arrow(p):
    '''match_arrow : FAT_ARROW'''
    p[0] = p[1]


def p_match_arm_body(p):
    '''match_arm_body : block
                      | expression %prec FAT_ARROW
                      | expression_statement
                      | return_statement'''
    # block returns a List[ASTNode], others return single ASTNode
    if isinstance(p[1], list):
        p[0] = p[1]
    else:
        # If it's a raw expression, wrap it in an ExpressionStatement
        if hasattr(p[1], '__class__') and not isinstance(p[1], (ExpressionStatement, IfStatement, ReturnStatement, PrintStatement)):
            p[0] = [ExpressionStatement(expression=p[1])]
        else:
            p[0] = [p[1]]


# -------------------- Match Patterns -------------------- #
# These productions are used exclusively in match arms.

def p_match_pattern_number(p):
    '''match_pattern : NUMBER'''
    p[0] = NumberPattern(value=p[1])


def p_match_pattern_negative(p):
    '''match_pattern : MINUS NUMBER'''
    p[0] = NumberPattern(value=-p[2])


def p_match_pattern_struct(p):
    '''match_pattern : IDENTIFIER LBRACE pattern_field_names RBRACE'''
    p[0] = TaggedPattern(type_name=p[1], variant="", fields=p[3])


def p_match_pattern_tagged_enum(p):
    '''match_pattern : IDENTIFIER DOT IDENTIFIER LBRACE pattern_field_names RBRACE'''
    p[0] = TaggedPattern(type_name=p[1], variant=p[3], fields=p[5])


def p_match_pattern_simple(p):
    '''match_pattern : IDENTIFIER'''
    p[0] = Identifier(name=p[1])


def p_match_pattern_wildcard(p):
    '''match_pattern : UNDERSCORE'''
    p[0] = WildcardPattern()


def p_pattern_field_names(p):
    '''pattern_field_names : pattern_field_names COMMA IDENTIFIER
                           | IDENTIFIER'''
    if len(p) == 2:
        p[0] = [p[1]]
    else:
        p[0] = p[1] + [p[3]]

# -------------------- If Statements -------------------- #


def p_if_statement(p):
    '''if_statement : IF expression block else_opt'''
    condition = p[2]
    then_branch = p[3]
    else_branch = p[4]
    p[0] = IfStatement(condition=condition,
                       then_branch=then_branch, else_branch=else_branch)


def p_else_opt(p):
    '''else_opt : ELSE if_statement
                | ELSE block
                | empty'''
    if len(p) == 3 and isinstance(p[2], IfStatement):
        p[0] = [p[2]]
    elif len(p) == 3:
        p[0] = p[2]
    else:
        p[0] = None

# -------------------- Return Statements -------------------- #


def p_return_statement(p):
    '''return_statement : RETURN expression SEMICOLON
                        | RETURN SEMICOLON'''
    if len(p) == 4:
        p[0] = ReturnStatement(expression=p[2])
    else:
        p[0] = ReturnStatement()

# -------------------- Assignment Statements -------------------- #

# -------------------- Expression Statements -------------------- #


def p_nonassignment_expression(p):
    '''nonassignment_expression : unary_expression
                                | nonassignment_expression PLUS unary_expression
                                | nonassignment_expression MINUS unary_expression
                                | nonassignment_expression MULTIPLY unary_expression
                                | nonassignment_expression DIVIDE unary_expression
                                | nonassignment_expression LT unary_expression
                                | nonassignment_expression GT unary_expression
                                | nonassignment_expression LEQ unary_expression
                                | nonassignment_expression GEQ unary_expression
                                | nonassignment_expression EQ unary_expression
                                | nonassignment_expression NEQ unary_expression
                                | nonassignment_expression AND unary_expression
                                | nonassignment_expression OR unary_expression'''
    if len(p) == 2:
        p[0] = p[1]
    else:
        p[0] = BinOp(operator=p[2], left=p[1], right=p[3])


def p_expression_statement(p):
    '''expression_statement : expression SEMICOLON'''
    p[0] = ExpressionStatement(expression=p[1])


def p_expression_await(p):
    '''expression : AWAIT expression'''
    p[0] = Await(expression=p[2])


def p_expression_range(p):
    'expression : expression DOT DOT expression'
    p[0] = RangeExpression(start=p[1], end=p[4])


def p_expression_typecheck(p):
    'expression : expression IS type'
    p[0] = TypeCheck(expr=p[1], type_name=p[3])

# -------------------- Import Statements -------------------- #


def p_import_statement(p):
    '''import_statement : IMPORT LBRACE import_items RBRACE FROM STRING SEMICOLON'''
    items = p[3]
    source = p[6]
    p[0] = ImportStatement(items=items, source=source)


def p_import_items(p):
    '''import_items : import_items COMMA IDENTIFIER
                   | IDENTIFIER'''
    if len(p) == 4:
        p[0] = p[1] + [p[3]]
    else:
        p[0] = [p[1]]

# -------------------- Lambda Expressions -------------------- #


def p_expression_lambda(p):
    '''expression : LPAREN FN LPAREN lambda_parameters RPAREN opt_lambda_return block RPAREN'''
    p[0] = LambdaExpression(params=p[4], return_type=p[6], body=p[7])


def p_expression_function(p):
    '''expression : LAMBDA LPAREN parameters RPAREN opt_return_type LBRACE statements_opt RBRACE'''
    p[0] = FunctionExpression(params=p[3], return_type=p[5], body=p[7])


def p_lambda_parameters_multiple(p):
    '''lambda_parameters : lambda_parameters COMMA lambda_parameter'''
    p[0] = p[1] + [p[3]]


def p_lambda_parameters_single(p):
    '''lambda_parameters : lambda_parameter'''
    p[0] = [p[1]]


def p_lambda_parameter(p):
    '''lambda_parameter : IDENTIFIER COLON type'''
    p[0] = (Identifier(name=p[1]), p[3])


def p_opt_lambda_return(p):
    '''opt_lambda_return : ARROW type
                         | empty'''
    p[0] = p[2] if len(p) > 2 else None

# -------------------- Try-Finally and Try-Catch-Finally -------------------- #


def p_try_finally(p):
    '''try_finally : TRY block FINALLY block'''
    p[0] = TryFinally(try_block=p[2], finally_block=p[4])


def p_try_catch_finally(p):
    '''try_catch_finally : TRY block CATCH LPAREN IDENTIFIER IDENTIFIER RPAREN block FINALLY block
                          | TRY block CATCH LPAREN IDENTIFIER IDENTIFIER RPAREN block
                          | TRY block CATCH LPAREN IDENTIFIER RPAREN block FINALLY block
                          | TRY block CATCH LPAREN IDENTIFIER RPAREN block'''
    if len(p) == 11:  # TRY block CATCH LPAREN IDENTIFIER IDENTIFIER RPAREN block FINALLY block
        try_block = p[2]
        error_type = p[5]
        error_var = p[6]
        catch_block = p[8]
        finally_block = p[10]
        p[0] = TryCatchFinally(
            try_block=try_block,
            catch_blocks=[(error_type, error_var, catch_block)],
            finally_block=finally_block
        )
    elif len(p) == 10:  # TRY block CATCH LPAREN IDENTIFIER RPAREN block FINALLY block
        try_block = p[2]
        error_type = None
        error_var = p[5]
        catch_block = p[7]
        finally_block = p[9]
        p[0] = TryCatchFinally(
            try_block=try_block,
            catch_blocks=[(error_type, error_var, catch_block)],
            finally_block=finally_block
        )
    elif len(p) == 9:  # TRY block CATCH LPAREN IDENTIFIER IDENTIFIER RPAREN block
        try_block = p[2]
        error_type = p[5]
        error_var = p[6]
        catch_block = p[8]
        p[0] = TryCatchFinally(
            try_block=try_block,
            catch_blocks=[(error_type, error_var, catch_block)],
            finally_block=None
        )
    else:  # len(p) == 8: TRY block CATCH LPAREN IDENTIFIER RPAREN block
        try_block = p[2]
        error_type = None
        error_var = p[5]
        catch_block = p[7]
        p[0] = TryCatchFinally(
            try_block=try_block,
            catch_blocks=[(error_type, error_var, catch_block)],
            finally_block=None
        )

# -------------------- Parameters -------------------- #


def p_parameters_multiple(p):
    '''parameters : parameters COMMA parameter'''
    p[0] = p[1] + [p[3]]


def p_parameters_single(p):
    '''parameters : parameter'''
    p[0] = [p[1]]


def p_parameters_empty(p):
    '''parameters : empty'''
    p[0] = []


def p_parameter(p):
    '''parameter : IDENTIFIER COLON type default_opt
                 | IDENTIFIER'''
    if len(p) == 2:
        if p[1] == "self":
            p[0] = (Identifier(name=p[1]), None, None)
        else:
            raise ParserError(
                "Missing type annotation for parameter '{}'".format(p[1]), p.lineno(1))
    else:
        p[0] = (Identifier(name=p[1]), p[3], p[4])


def p_default_opt(p):
    '''default_opt : ASSIGN expression
                  | empty'''
    p[0] = p[2] if len(p) > 2 else None

# -------------------- Block -------------------- #


def p_block(p):
    '''block : LBRACE statements_opt RBRACE'''
    p[0] = p[2]


def p_statements_opt(p):
    '''statements_opt : statements
                      | empty'''
    if p[1] is None:
        p[0] = []
    else:
        p[0] = p[1]

# -------------------- Type Non-Terminal -------------------- #


# A primary type is just an identifier or a parenthesized type.
def p_type_primary(p):
    '''type_primary : IDENTIFIER
                    | LPAREN type_expr RPAREN'''
    if len(p) == 2:
        p[0] = Identifier(name=p[1])
    else:
        p[0] = p[2]

# A type suffix handles array '[]' and optional '?' sugar.


def p_type_suffix(p):
    '''type_suffix : empty
                   | type_suffix LBRACKET RBRACKET
                   | type_suffix QUESTION'''
    if len(p) == 2:
        p[0] = p[1]
    elif p[2] == '[':
        p[0] = ArrayType(element_type=p[1])
    else:
        p[0] = OptionalType(base=p[1])

# Now the complete type expression is a primary type with optional suffixes.


def p_type_expr_postfix(p):
    '''type_expr_postfix : type_primary type_suffix'''
    if p[2] is None:
        p[0] = p[1]
    else:
        # Apply the type suffix to the primary type
        p[0] = _apply_type_suffix(p[1], p[2])


def _apply_type_suffix(base_type, suffix):
    """Apply a type suffix to a base type, handling nested suffixes."""
    if isinstance(suffix, ArrayType):
        if suffix.element_type is None:
            # This is a simple array suffix, apply it to the base
            return ArrayType(element_type=base_type)
        else:
            # This is a nested suffix, apply it recursively
            return ArrayType(element_type=_apply_type_suffix(base_type, suffix.element_type))
    elif isinstance(suffix, OptionalType):
        if suffix.base is None:
            return OptionalType(base=base_type)
        else:
            return OptionalType(base=_apply_type_suffix(base_type, suffix.base))
    else:
        return suffix

# If you also want to support union and intersection, you can add another level.


def p_type_expr(p):
    '''type_expr : type_expr PIPE type_expr_postfix
                 | type_expr AMP type_expr_postfix
                 | type_expr_postfix'''
    if len(p) == 2:
        p[0] = p[1]
    else:
        # Here you can choose to represent union/intersection in your AST.
        # For example:
        if p[2] == '|':
            p[0] = UnionType(left=p[1], right=p[3])
        elif p[2] == '&':
            p[0] = IntersectionType(left=p[1], right=p[3])


def p_type(p):
    'type : type_expr'
    p[0] = p[1]


# -------------------- Test Declarations -------------------- #


def p_test_declaration(p):
    '''test_declaration : TEST STRING block'''
    description = p[2]
    body = p[3]
    p[0] = TestDeclaration(description=description, body=body)

# -------------------- Primary and Postfix Expressions -------------------- #


def p_postfix_expression_struct_instantiation(p):
    '''postfix_expression : NEW IDENTIFIER LBRACE struct_field_inits_opt RBRACE'''
    p[0] = StructInstantiation(struct_name=p[2], field_inits=p[4])


def p_primary_expression_print(p):
    '''primary_expression : PRINT'''
    p[0] = Identifier(name=p[1])


def p_primary_expression_info(p):
    '''primary_expression : INFO'''
    p[0] = Identifier(name=p[1])


def p_primary_expression_identifier(p):
    '''primary_expression : IDENTIFIER'''
    p[0] = Identifier(name=p[1])


def p_primary_expression_number(p):
    '''primary_expression : NUMBER'''
    p[0] = Number(value=p[1])


def p_primary_expression_string(p):
    '''primary_expression : STRING'''
    p[0] = String(value=p[1])


def p_primary_expression_paren(p):
    '''primary_expression : LPAREN expression RPAREN'''
    p[0] = p[2]


def p_primary_expression_async_block_statements(p):
    '''primary_expression : ASYNC LBRACE statements_opt RBRACE'''
    p[0] = AsyncBlock(body=p[3] if p[3] else [])


def p_primary_expression_async_block_expression(p):
    '''primary_expression : ASYNC LBRACE expression RBRACE'''
    # Convert the expression to an expression statement
    expr_stmt = ExpressionStatement(expression=p[3])
    p[0] = AsyncBlock(body=[expr_stmt])


def p_primary_expression_routine_block_statements(p):
    '''primary_expression : ROUTINE LBRACE statements_opt RBRACE'''
    p[0] = Routine(name=None, body=p[3] if p[3] else [])


def p_primary_expression_routine_block_expression(p):
    '''primary_expression : ROUTINE LBRACE expression RBRACE'''
    # Convert the expression to an expression statement
    expr_stmt = ExpressionStatement(expression=p[3])
    p[0] = Routine(name=None, body=[expr_stmt])


def p_primary_expression_routine_named_block_statements(p):
    '''primary_expression : ROUTINE STRING LBRACE statements_opt RBRACE'''
    p[0] = Routine(name=p[2], body=p[4] if p[4] else [])


def p_primary_expression_routine_named_block_expression(p):
    '''primary_expression : ROUTINE STRING LBRACE expression RBRACE'''
    # Convert the expression to an expression statement
    expr_stmt = ExpressionStatement(expression=p[4])
    p[0] = Routine(name=p[2], body=[expr_stmt])


# Enum variant construction handled in postfix_expression


def p_postfix_expression_index(p):
    '''postfix_expression : postfix_expression LBRACKET expression RBRACKET'''
    p[0] = ArrayIndexing(object_=p[1], index=p[3])


def p_postfix_expression(p):
    '''postfix_expression : primary_expression
                          | postfix_expression LPAREN arguments RPAREN
                          | postfix_expression DOT IDENTIFIER LBRACE struct_field_inits_opt RBRACE %prec LBRACE
                          | postfix_expression DOT IDENTIFIER %prec DOT
                          | postfix_expression DOT INFO'''
    if len(p) == 2:
        p[0] = p[1]
    elif p[2] == '(':
        p[0] = FunctionCall(func_name=p[1], arguments=p[3])
    elif len(p) == 7:  # DOT IDENTIFIER LBRACE ... RBRACE (enum variant construction)
        enum_name = p[1]
        variant_name = p[3]
        field_inits = p[5]
        p[0] = EnumVariantConstruction(
            enum_name=enum_name, variant_name=variant_name, field_inits=field_inits)
    else:  # DOT IDENTIFIER or DOT INFO (member access)
        p[0] = MemberAccess(object_=p[1], member=p[3])


# Struct instantiation handled in primary_expression rules


def p_unary_expression(p):
    '''unary_expression : MINUS unary_expression %prec UMINUS
                        | NOT unary_expression
                        | postfix_expression'''
    if len(p) == 2:
        p[0] = p[1]
    else:
        if p[1] == '-':
            p[0] = BinOp(operator='-', left=Number(0), right=p[2])
        else:
            p[0] = UnaryOp(operator='not', operand=p[2])


def p_expression(p):
    '''expression : nonassignment_expression assignment_opt'''
    if p[2] is None:
        p[0] = p[1]
    else:
        # p[2] is a tuple (op, right)
        op, right = p[2]
        if op == '=':
            p[0] = Assignment(target=p[1], value=right)
        else:
            op_map = {'+=': '+', '-=': '-', '*=': '*', '/=': '/'}
            p[0] = Assignment(target=p[1],
                              value=BinOp(operator=op_map[op], left=p[1], right=right))


def p_assignment_opt(p):
    '''assignment_opt : ASSIGN expression
                      | PLUS_ASSIGN expression
                      | MINUS_ASSIGN expression
                      | MULTIPLY_ASSIGN expression
                      | DIVIDE_ASSIGN expression
                      | empty'''
    if len(p) == 2:
        p[0] = None
    else:
        p[0] = (p[1], p[2])


def p_struct_field_inits_opt(p):
    '''struct_field_inits_opt : struct_field_inits
                              | empty'''
    p[0] = p[1] if p[1] is not None else []


def p_struct_field_inits_multiple(p):
    '''struct_field_inits : struct_field_inits COMMA struct_field_init'''
    p[0] = p[1] + [p[3]]


def p_struct_field_inits_single(p):
    '''struct_field_inits : struct_field_init'''
    p[0] = [p[1]]


def p_struct_field_init(p):
    '''struct_field_init : IDENTIFIER COLON expression'''
    p[0] = (p[1], p[3])


def p_struct_field_init_shorthand(p):
    '''struct_field_init : IDENTIFIER'''
    p[0] = (p[1], Identifier(name=p[1]))

# -------------------- Arguments -------------------- #


def p_arguments(p):
    '''arguments : arguments COMMA argument_expression
                 | argument_expression
                 | empty'''
    if len(p) == 4:
        p[0] = p[1] + [p[3]]
    elif len(p) == 2 and p[1] is not None:
        p[0] = [p[1]]
    else:
        p[0] = []


def p_argument_expression(p):
    '''argument_expression : expression'''
    p[0] = p[1]

# -------------------- Error Handling -------------------- #


def find_column(text, lexpos):
    last_cr = text.rfind('\n', 0, lexpos)
    if last_cr < 0:
        last_cr = -1
    return lexpos - last_cr


def p_error(p):
    if not p:
        # unexpected EOF
        raise ParserError("Syntax error: unexpected end of file", 0)

    # figure out what tokens WOULD have been valid here
    expected = []
    try:
        # `parser` is the Yacc() instance we've built below
        state = p.state
        # parser.action is a dict: { state: { lookahead_token: action, ... } }
        actions = parser.action.get(state, {})
        expected = [tok for tok in actions.keys() if tok != 'error']
    except Exception:
        pass

    data = p.lexer.lexdata
    lineno = data[:p.lexpos].count('\n') + 1
    col = find_column(data, p.lexpos)
    msg = f"Syntax error at token {p.type!r} ({p.value!r}) at line {lineno}, column {col}"
    if expected:
        msg += f"\nExpected one of: {', '.join(expected)}"

    # show the source line + caret
    start = data.rfind('\n', 0, p.lexpos) + 1
    end = data.find('\n', p.lexpos)
    if end == -1:
        end = len(data)
    line = data[start:end]
    pointer = ' ' * (col - 1) + '^'

    raise ParserError(f"{msg}\n  {line}\n  {pointer}", lineno)
# -------------------- Build the Parser -------------------- #


parser = yacc.yacc(debug=False, write_tables=False)
