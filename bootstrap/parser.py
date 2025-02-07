import sys
import ply.yacc as yacc
from lexer import tokens
from ast_nodes import *
from errors import ParserError

# Precedence rules to resolve ambiguity
precedence = (
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
    ('right', 'UMINUS'),
    ('left', 'AMP'),
    ('left', 'PIPE'),
    ('right', 'ASSIGN', 'PLUS_ASSIGN', 'MINUS_ASSIGN',
     'MULTIPLY_ASSIGN', 'DIVIDE_ASSIGN'),

)
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
                 | test_declaration'''
    p[0] = p[1]


# -------------------- Print Statement -------------------- #


def p_print_statement(p):
    '''print_statement : PRINT DOT INFO LPAREN expression RPAREN SEMICOLON'''
    p[0] = PrintStatement(expression=p[5])

# -------------------- Throw Statement -------------------- #


def p_throw_statement(p):
    '''throw_statement : THROW expression SEMICOLON'''
    p[0] = ThrowStatement(expression=p[2])

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
    '''function_declaration : decorators_opt FN IDENTIFIER LPAREN parameters RPAREN opt_return_type block'''
    p[0] = FunctionDeclaration(
        name=p[3],
        params=p[5],
        return_type=p[7] if p[7] is not None else 'void',
        body=p[8],
        decorators=p[1] if p[1] else [],
        is_async=False
    )


def p_function_declaration_async(p):
    '''function_declaration : decorators_opt ASYNC FN IDENTIFIER LPAREN parameters RPAREN opt_return_type block'''
    p[0] = FunctionDeclaration(
        name=p[4],
        params=p[6],
        return_type=p[8] if p[8] is not None else 'void',
        body=p[9],
        decorators=p[1] if p[1] else [],
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
    '''match_statement : MATCH expression LBRACE match_arms RBRACE'''
    p[0] = MatchStatement(condition=p[2], arms=p[4])


def p_match_arms(p):
    '''match_arms : match_arm_list_opt'''
    p[0] = p[1]


def p_match_arm_list_opt(p):
    '''match_arm_list_opt : match_arm_list
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
                      | expression'''
    # If it’s a block, it’s already a list of statements.
    # Otherwise, wrap a bare expression in an ExpressionStatement.
    if isinstance(p[1], list):
        p[0] = p[1]
    else:
        p[0] = [ExpressionStatement(expression=p[1])]


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


def p_lvalue(p):
    '''lvalue : IDENTIFIER
              | lvalue DOT IDENTIFIER'''
    if len(p) == 2:
        p[0] = Identifier(name=p[1])
    else:
        p[0] = MemberAccess(object_=p[1], member=p[3])


def p_assignment_expression(p):
    '''assignment_expression : lvalue ASSIGN expression %prec ASSIGN
                             | lvalue PLUS_ASSIGN expression %prec ASSIGN
                             | lvalue MINUS_ASSIGN expression %prec ASSIGN
                             | lvalue MULTIPLY_ASSIGN expression %prec ASSIGN
                             | lvalue DIVIDE_ASSIGN expression %prec ASSIGN'''
    if p[2] == '=':
        p[0] = Assignment(target=p[1], value=p[3])
    else:
        op_map = {'+=': '+', '-=': '-', '*=': '*', '/=': '/'}
        p[0] = Assignment(target=p[1], value=BinOp(
            operator=op_map[p[2]], left=p[1], right=p[3]))


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


def p_lambda_parameters_multiple(p):
    '''lambda_parameters : lambda_parameters COMMA lambda_parameter'''
    p[0] = p[1] + [p[3]]


def p_lambda_parameters_single(p):
    '''lambda_parameters : lambda_parameter'''
    p[0] = [p[1]]


def p_lambda_parameter(p):
    '''lambda_parameter : IDENTIFIER COLON type'''
    p[0] = (p[1], p[3])


def p_opt_lambda_return(p):
    '''opt_lambda_return : ARROW type
                         | empty'''
    p[0] = p[2] if len(p) > 2 else None

# -------------------- Try-Finally and Try-Catch-Finally -------------------- #


def p_try_finally(p):
    '''try_finally : TRY block FINALLY block'''
    p[0] = TryFinally(try_block=p[2], finally_block=p[4])


def p_try_catch_finally(p):
    '''try_catch_finally : TRY block CATCH LPAREN IDENTIFIER RPAREN block FINALLY block
                          | TRY block CATCH LPAREN IDENTIFIER RPAREN block'''
    if len(p) == 10:
        try_block = p[2]
        error_type = p[5]
        error_var = p[6]
        catch_block = p[7]
        finally_block = p[9]
        p[0] = TryCatchFinally(
            try_block=try_block,
            catch_blocks=[(error_type, error_var, catch_block)],
            finally_block=finally_block
        )
    else:
        try_block = p[2]
        error_type = p[5]
        error_var = p[6]
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
        # This branch matches if the parameter is specified without a type.
        if p[1] == "self":
            p[0] = (p[1], None, None)
        else:
            # You might want to raise an error or force a type annotation for non-self parameters.
            raise ParserError(
                "Missing type annotation for parameter '{}'".format(p[1]), p.lineno(1))
    else:
        p[0] = (p[1], p[3], p[4])


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


def stringify_type(t):
    # If t is already a string, return it.
    if isinstance(t, str):
        return t
    # If t is a UnionType, convert it into something like "left|right"
    elif isinstance(t, UnionType):
        return stringify_type(t.left) + "|" + stringify_type(t.right)
    elif isinstance(t, IntersectionType):
        return stringify_type(t.left) + "&" + stringify_type(t.right)
    else:
        # You can customize this based on your AST
        return str(t)

# A primary type is just an identifier or a parenthesized type.


def p_type_primary(p):
    '''type_primary : IDENTIFIER
                    | LPAREN type_expr RPAREN'''
    if len(p) == 2:
        p[0] = p[1]
    else:
        p[0] = stringify_type(p[2])


# A type suffix is zero or more array postfixes.


def p_type_suffix(p):
    '''type_suffix : type_suffix LBRACKET RBRACKET
                   | empty'''
    if len(p) == 2:  # empty production
        p[0] = ""
    else:
        p[0] = p[1] + "[]"

# Now the complete type expression is a primary type with optional suffixes.


def p_type_expr_postfix(p):
    '''type_expr_postfix : type_primary type_suffix'''
    p[0] = p[1] + p[2]

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


def p_primary_expression(p):
    '''primary_expression : IDENTIFIER struct_instantiation_opt
                          | NUMBER
                          | STRING
                          | LPAREN expression RPAREN'''
    if p.slice[1].type == "IDENTIFIER":
        # If the optional part is present, p[2] will be non-None.
        if p[2] is not None:
            p[0] = StructInstantiation(struct_name=p[1], field_inits=p[2])
        else:
            p[0] = Identifier(name=p[1])
    elif p.slice[1].type == "NUMBER":
        p[0] = Number(value=p[1])
    elif p.slice[1].type == "STRING":
        p[0] = String(value=p[1])
    else:  # LPAREN expression RPAREN
        p[0] = p[2]


def p_postfix_expression_index(p):
    '''postfix_expression : postfix_expression LBRACKET expression RBRACKET'''
    p[0] = ArrayIndexing(object_=p[1], index=p[3])


def p_postfix_expression(p):
    '''postfix_expression : primary_expression
                          | postfix_expression LPAREN arguments RPAREN
                          | postfix_expression DOT IDENTIFIER'''
    if len(p) == 2:
        p[0] = p[1]
    elif p[2] == '(':
        p[0] = FunctionCall(func_name=p[1], arguments=p[3])
    else:
        p[0] = MemberAccess(object_=p[1], member=p[3])


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


def p_struct_instantiation_opt(p):
    '''struct_instantiation_opt : LBRACE struct_field_inits_opt RBRACE
                                | empty'''
    if len(p) == 2:  # matched empty
        p[0] = None
    else:
        p[0] = p[2]


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
    '''arguments : arguments COMMA expression
                 | expression
                 | empty'''
    if len(p) == 4:
        p[0] = p[1] + [p[3]]
    elif len(p) == 2 and p[1] is not None:
        p[0] = [p[1]]
    else:
        p[0] = []

# -------------------- Error Handling -------------------- #


def p_error(p):
    if p:
        error_message = f"Syntax error at token '{
            p.type}' with value '{p.value}' at line {p.lineno}"
        raise ParserError(error_message, p.lineno)
    else:
        raise ParserError("Syntax error at EOF")

# -------------------- Build the Parser -------------------- #


parser = yacc.yacc(debug=False)
