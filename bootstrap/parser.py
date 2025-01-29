# bootstrap/parser.py

import sys
import ply.yacc as yacc
from lexer import tokens
from ast_nodes import (
    ArrayLiteral, EnumDeclaration, EnumVariant, ExpressionStatement, ImportStatement, LambdaExpression, MatchArm, MatchStatement, MethodDeclaration, NumberPattern, Program, FunctionDeclaration, TypeAliasDeclaration, VariableDeclaration, ConstantDeclaration,
    PrintStatement, IfStatement, ReturnStatement, StructDeclaration,
    FieldDeclaration, BinOp, Number, String, Identifier, FunctionCall,
    MemberAccess, Assignment, WildcardPattern
)

# Precedence rules
precedence = (
    ('left', 'OR'),
    ('left', 'AND'),
    ('left', 'EQ', 'NEQ'),
    ('left', 'LT', 'GT', 'LEQ', 'GEQ'),
    ('left', 'PLUS', 'MINUS'),
    ('left', 'MULTIPLY', 'DIVIDE'),
    ('left', 'DOT'),
    ('left', 'LPAREN', 'RPAREN'),  # Added for function calls
    ('right', 'UMINUS'),
)


def p_program(p):
    '''program : statements'''
    p[0] = Program(p[1])


def p_statements_multiple(p):
    '''statements : statements statement'''
    p[0] = p[1] + [p[2]]


def p_statements_single(p):
    '''statements : statement'''
    p[0] = [p[1]]


def p_statement_declaration(p):
    '''statement : variable_declaration
                 | constant_declaration
                 | function_declaration
                 | struct_declaration
                 | enum_declaration
                 | print_statement
                 | if_statement
                 | return_statement
                 | assignment
                 | expression_statement
                 | match_statement 
                 | import_statement'''
    p[0] = p[1]


def p_match_statement(p):
    '''match_statement : MATCH expression LBRACE match_arms RBRACE'''
    p[0] = MatchStatement(condition=p[2], arms=p[4])


def p_match_arms(p):
    '''
    match_arms :
               | match_arm_list maybe_comma
    '''
    # Two possibilities:
    # 1) Empty match arms (no arms at all).
    # 2) One or more arms, followed by an optional trailing comma.
    if len(p) == 1:
        # Empty production => []
        p[0] = []
    else:
        # match_arm_list maybe_comma => the actual list of arms
        p[0] = p[1]


def p_match_arm_list_single(p):
    '''match_arm_list : match_arm'''
    p[0] = [p[1]]


def p_match_arm_list_multiple(p):
    '''match_arm_list : match_arm_list COMMA match_arm'''
    p[0] = p[1] + [p[3]]


def p_maybe_comma(p):
    '''maybe_comma : COMMA
                   | empty
    '''
    # Optional trailing comma. We do nothing with it, just allow it syntactically.
    pass


def p_match_arm(p):
    '''match_arm : pattern ARROW inline_statement'''
    p[0] = MatchArm(pattern=p[1], body=[p[3]])


def p_inline_statement_print(p):
    '''inline_statement : PRINT DOT INFO LPAREN expression RPAREN'''
    p[0] = PrintStatement(expression=p[5])


def p_inline_statement_assignment(p):
    '''inline_statement : assignment_expression'''
    # But note: assignment_expression is returning an Assignment AST node,
    # which is a statement-level node in your AST.
    p[0] = p[1]


def p_inline_statement_expression(p):
    '''inline_statement : expression'''
    p[0] = ExpressionStatement(expression=p[1])


def p_pattern_negative_number(p):
    '''pattern : MINUS NUMBER'''
    p[0] = NumberPattern(-p[2])


def p_pattern_number(p):
    '''pattern : NUMBER'''
    p[0] = NumberPattern(value=p[1])


def p_pattern_wildcard(p):
    '''pattern : UNDERSCORE'''
    p[0] = WildcardPattern()


def p_assignment_expression(p):
    '''assignment_expression : lvalue ASSIGN expression
                              | lvalue PLUS_ASSIGN expression
                              | lvalue MINUS_ASSIGN expression
                              | lvalue MULTIPLY_ASSIGN expression
                              | lvalue DIVIDE_ASSIGN expression'''
    if p[2] == '=':
        p[0] = Assignment(target=p[1], value=p[3])
    elif p[2] == '+=':
        p[0] = Assignment(target=p[1], value=BinOp(
            operator='+', left=p[1], right=p[3]))
    elif p[2] == '-=':
        p[0] = Assignment(target=p[1], value=BinOp(
            operator='-', left=p[1], right=p[3]))
    elif p[2] == '*=':
        p[0] = Assignment(target=p[1], value=BinOp(
            operator='*', left=p[1], right=p[3]))
    elif p[2] == '/=':
        p[0] = Assignment(target=p[1], value=BinOp(
            operator='/', left=p[1], right=p[3]))
    else:
        raise NotImplementedError(f"Assignment operator {
                                  p[2]} not implemented")


# Type Alias Declaration


def p_type_alias_declaration(p):
    '''type_alias_declaration : TYPE IDENTIFIER ASSIGN type SEMICOLON'''
    p[0] = TypeAliasDeclaration(name=p[2], aliased_type=p[4])

# Struct Declaration


def p_struct_declaration(p):
    '''struct_declaration : STRUCT IDENTIFIER LBRACE struct_members RBRACE'''
    p[0] = StructDeclaration(name=p[2], members=p[4])


def p_struct_members_multiple(p):
    '''struct_members : struct_members struct_member'''
    p[0] = p[1] + [p[2]]


def p_struct_members_single(p):
    '''struct_members : struct_member'''
    p[0] = [p[1]]


def p_struct_member(p):
    '''struct_member : mut_field_declaration
                     | field_declaration
                     | method_declaration'''
    p[0] = p[1]

# Method Declaration (within Struct)


def p_method_declaration_with_decorators(p):
    '''method_declaration : decorators FN IDENTIFIER LPAREN parameters RPAREN ARROW type LBRACE statements RBRACE'''
    p[0] = MethodDeclaration(
        name=p[3],
        params=p[5],
        return_type=p[8],
        body=p[10],
        decorators=p[1]
    )


def p_method_declaration_without_decorators(p):
    '''method_declaration : FN IDENTIFIER LPAREN parameters RPAREN ARROW type LBRACE statements RBRACE'''
    p[0] = MethodDeclaration(
        name=p[2],
        params=p[4],
        return_type=p[7],
        body=p[9]
    )

# Field Declarations


def p_mut_field_declaration(p):
    '''mut_field_declaration : MUT LET IDENTIFIER ARROW type SEMICOLON'''
    p[0] = FieldDeclaration(name=p[3], field_type=p[5], mutable=True)


def p_field_declaration(p):
    '''field_declaration : LET IDENTIFIER ARROW type SEMICOLON'''
    p[0] = FieldDeclaration(name=p[2], field_type=p[4], mutable=False)

# Enum Declaration


def p_enum_declaration(p):
    '''enum_declaration : ENUM IDENTIFIER LBRACE enum_variants_opt RBRACE'''
    p[0] = EnumDeclaration(name=p[2], variants=p[4])

# `enum_variants_opt` can be either a list of variants or empty.


def p_enum_variants_opt(p):
    '''enum_variants_opt : enum_variants
                         | empty'''
    # If it's empty, return an empty list so we don't break code that expects a list.
    p[0] = p[1] if p[1] is not None else []

# `enum_variants` requires at least one variant (with possible trailing comma).


def p_enum_variants(p):
    '''enum_variants : enum_variant_list maybe_trailing_comma'''
    # This rule ensures we collect the actual variants
    # in `enum_variant_list` and ignore the optional trailing comma.
    p[0] = p[1]

# One or more variants, separated by commas, but no trailing comma here.


def p_enum_variant_list_single(p):
    '''enum_variant_list : enum_variant'''
    p[0] = [p[1]]


def p_enum_variant_list_multiple(p):
    '''enum_variant_list : enum_variant_list COMMA enum_variant'''
    p[0] = p[1] + [p[3]]

# An optional trailing comma is either a `,` or empty.


def p_maybe_trailing_comma(p):
    '''maybe_trailing_comma : COMMA
                            | empty
    '''
    pass


def p_enum_variant_with_fields(p):
    '''enum_variant : IDENTIFIER LBRACE struct_members RBRACE'''
    p[0] = EnumVariant(name=p[1], fields=p[3])


def p_enum_variant_without_fields(p):
    '''enum_variant : IDENTIFIER'''
    p[0] = EnumVariant(name=p[1])


# Decorators


def p_decorators_multiple(p):
    '''decorators : decorators decorator'''
    p[0] = p[1] + [p[2]]


def p_decorators_single(p):
    '''decorators : decorator'''
    p[0] = [p[1]]


def p_decorator(p):
    '''decorator : AT IDENTIFIER'''
    p[0] = p[2]

# Constant Declaration


def p_constant_declaration(p):
    '''constant_declaration : CONST LET IDENTIFIER ARROW type ASSIGN expression SEMICOLON'''
    p[0] = ConstantDeclaration(name=p[3], var_type=p[5], value=p[7])

# Variable Declaration


def p_variable_declaration_let_with_type(p):
    'variable_declaration : LET mut_opt IDENTIFIER ARROW type ASSIGN expression SEMICOLON'
    mutable = p[2]
    name = p[3]
    var_type = p[5]
    value = p[7]
    print(f"VariableDeclaration (let with type): name={name}, var_type={
          var_type}, value={value}, mutable={mutable}")  # Debugging
    p[0] = VariableDeclaration(name, var_type, value, mutable)


def p_variable_declaration_let_without_type(p):
    'variable_declaration : LET mut_opt IDENTIFIER ASSIGN expression SEMICOLON'
    mutable = p[2]
    name = p[3]
    var_type = None
    value = p[5]
    print(f"VariableDeclaration (let without type): name={name}, var_type={
          var_type}, value={value}, mutable={mutable}")  # Debugging
    p[0] = VariableDeclaration(name, var_type, value, mutable)


def p_variable_declaration_mut_with_type(p):
    'variable_declaration : MUT IDENTIFIER ARROW type ASSIGN expression SEMICOLON'
    mutable = True
    name = p[2]
    var_type = p[4]
    value = p[6]
    print(f"VariableDeclaration (mut with type): name={name}, var_type={
          var_type}, value={value}, mutable={mutable}")  # Debugging
    p[0] = VariableDeclaration(name, var_type, value, mutable)


def p_variable_declaration_mut_without_type(p):
    'variable_declaration : MUT IDENTIFIER ASSIGN expression SEMICOLON'
    mutable = True
    name = p[2]
    var_type = None
    value = p[4]
    print(f"VariableDeclaration (mut without type): name={name}, var_type={
          var_type}, value={value}, mutable={mutable}")  # Debugging
    p[0] = VariableDeclaration(name, var_type, value, mutable)


def p_mut_opt_mut(p):
    '''mut_opt : MUT'''
    p[0] = True


def p_mut_opt_empty(p):
    '''mut_opt : '''
    p[0] = False


# Function Declaration


def p_function_declaration_with_decorators(p):
    '''function_declaration : decorators FN IDENTIFIER LPAREN parameters RPAREN ARROW type LBRACE statements RBRACE'''
    p[0] = FunctionDeclaration(
        name=p[3],
        params=p[5],
        return_type=p[8],
        body=p[10],
        decorators=p[1]
    )


def p_function_declaration_with_decorators_no_return(p):
    '''function_declaration : decorators FN IDENTIFIER LPAREN parameters RPAREN LBRACE statements RBRACE'''
    p[0] = FunctionDeclaration(
        name=p[3],
        params=p[5],
        return_type='void',  # Default return type
        body=p[8],
        decorators=p[1]
    )


def p_function_declaration_without_decorators(p):
    '''function_declaration : FN IDENTIFIER LPAREN parameters RPAREN ARROW type LBRACE statements RBRACE'''
    p[0] = FunctionDeclaration(
        name=p[2],
        params=p[4],
        return_type=p[7],
        body=p[9]
    )


def p_function_declaration_without_decorators_no_return(p):
    '''function_declaration : FN IDENTIFIER LPAREN parameters RPAREN LBRACE statements RBRACE'''
    p[0] = FunctionDeclaration(
        name=p[2],
        params=p[4],
        return_type='void',  # Default return type
        body=p[7]
    )


# Print Statement


def p_print_statement(p):
    '''print_statement : PRINT DOT INFO LPAREN expression RPAREN SEMICOLON'''
    p[0] = PrintStatement(expression=p[5])


# Import Statement

def p_import_statement(p):
    '''import_statement : IMPORT LBRACE import_items RBRACE FROM STRING SEMICOLON'''
    p[0] = ImportStatement(items=p[3], source=p[5])


def p_import_items_multiple(p):
    '''import_items : import_items COMMA IDENTIFIER'''
    p[0] = p[1] + [p[3]]


def p_import_items_single(p):
    '''import_items : IDENTIFIER'''
    p[0] = [p[1]]


def p_import_items_empty(p):
    '''import_items : '''
    p[0] = []

# If Statement


def p_block(p):
    """block : LBRACE statements RBRACE"""
    p[0] = p[2]


def p_if_statement_no_parens(p):
    """if_statement : IF expression block else_clause"""
    p[0] = IfStatement(condition=p[2],
                       then_branch=p[3],
                       else_branch=p[4])


def p_if_statement_with_parens(p):
    """if_statement : IF LPAREN expression RPAREN block else_clause"""
    p[0] = IfStatement(condition=p[3],
                       then_branch=p[5],
                       else_branch=p[6])


def p_else_clause_if(p):
    """else_clause : ELSE if_statement"""
    # “else if …” is effectively just “ELSE <nested if>”
    # We'll store it in a single-element list so it reuses your AST shape
    # (IfStatement wants else_branch as a list or None).
    p[0] = [p[2]]


def p_else_clause_block(p):
    """else_clause : ELSE block"""
    # This is a normal “else { … }”
    # We'll store the statements of the block directly.
    p[0] = p[2]


def p_else_clause_empty(p):
    """else_clause :"""
    # No else at all
    p[0] = []


# Return Statement


def p_return_statement(p):
    '''return_statement : RETURN expression SEMICOLON
                        | RETURN SEMICOLON'''
    if len(p) == 4:
        p[0] = ReturnStatement(expression=p[2])
    else:
        p[0] = ReturnStatement()

# Assignment


def p_assignment(p):
    '''assignment : assignment_expression SEMICOLON'''
    p[0] = p[1]


def p_lvalue_identifier(p):
    '''lvalue : IDENTIFIER'''
    p[0] = Identifier(name=p[1])


def p_lvalue_member_access(p):
    '''lvalue : expression DOT IDENTIFIER'''
    p[0] = MemberAccess(object_=p[1], member=p[3])

# Expression Statement


def p_expression_lambda(p):
    '''expression : FN LPAREN parameters RPAREN ARROW type LBRACE statements RBRACE'''
    print("Parsing lambda with return type")
    p[0] = LambdaExpression(params=p[3], body=p[8])


def p_expression_lambda_no_return(p):
    '''expression : FN LPAREN parameters RPAREN LBRACE statements RBRACE'''
    print("Parsing lambda without return type")
    p[0] = LambdaExpression(params=p[3], body=p[6])


def p_expression_statement(p):
    '''expression_statement : expression SEMICOLON'''
    p[0] = ExpressionStatement(expression=p[1])

# Parameters


def p_parameters_multiple(p):
    '''parameters : parameters COMMA parameter
                  | parameters COMMA'''
    if len(p) == 4:
        p[0] = p[1] + [p[3]]
    else:
        p[0] = p[1]


def p_parameters_single(p):
    '''parameters : parameter'''
    p[0] = [p[1]]


def p_parameters_empty(p):
    '''parameters : '''
    p[0] = []


def p_parameter_with_type(p):
    'parameter : IDENTIFIER ARROW type'
    p[0] = (p[1], p[3])

# Allow parameters without type annotations


def p_parameter_without_type(p):
    'parameter : IDENTIFIER'
    p[0] = (p[1], None)

# Type Definitions


def p_type(p):
    '''type : IDENTIFIER
            | type LT type_list GT'''
    if len(p) == 2:
        p[0] = p[1]
    else:
        p[0] = f"{p[1]}<{', '.join(p[3])}>"


def p_type_list_multiple(p):
    '''type_list : type_list COMMA type'''
    p[0] = p[1] + [p[3]]


def p_type_list_single(p):
    '''type_list : type'''
    p[0] = [p[1]]

# Expressions


def p_expression_array_literal(p):
    '''expression : LBRACKET elements RBRACKET'''
    p[0] = ArrayLiteral(elements=p[2])


def p_elements_multiple(p):
    '''elements : elements COMMA expression
                | elements COMMA'''
    if len(p) == 4:
        p[0] = p[1] + [p[3]]
    else:
        p[0] = p[1]


def p_elements_single(p):
    '''elements : expression'''
    p[0] = [p[1]]


def p_elements_empty(p):
    '''elements : '''
    p[0] = []


def p_expression_binop(p):
    '''expression : expression PLUS expression
                  | expression MINUS expression
                  | expression MULTIPLY expression
                  | expression DIVIDE expression
                  | expression LT expression
                  | expression GT expression
                  | expression LEQ expression
                  | expression GEQ expression
                  | expression EQ expression
                  | expression NEQ expression
                  | expression AND expression
                  | expression OR expression'''
    p[0] = BinOp(operator=p[2], left=p[1], right=p[3])


def p_expression_uminus(p):
    '''expression : MINUS expression %prec UMINUS'''
    p[0] = BinOp(operator='-', left=Number(0), right=p[2])


def p_expression_group(p):
    '''expression : LPAREN expression RPAREN'''
    p[0] = p[2]


def p_expression_number(p):
    '''expression : NUMBER'''
    p[0] = Number(value=p[1])


def p_expression_string(p):
    '''expression : STRING'''
    p[0] = String(value=p[1])


def p_expression_identifier(p):
    '''expression : IDENTIFIER'''
    p[0] = Identifier(name=p[1])


def p_expression_function_call(p):
    '''expression : IDENTIFIER LPAREN arguments RPAREN
                  | expression LPAREN arguments RPAREN'''
    # If p[1] is a plain string (from the IDENTIFIER token),
    # wrap it in an Identifier node:
    if isinstance(p[1], str):
        p[1] = Identifier(p[1])

    # Now p[1] is always an AST node
    p[0] = FunctionCall(func_name=p[1], arguments=p[3])


def p_expression_member_access(p):
    '''expression : expression DOT IDENTIFIER'''
    p[0] = MemberAccess(object_=p[1], member=p[3])


def p_arguments_multiple(p):
    '''arguments : arguments COMMA expression'''
    p[0] = p[1] + [p[3]]


def p_arguments_single(p):
    '''arguments : expression'''
    p[0] = [p[1]]


def p_arguments_empty(p):
    '''arguments : '''
    p[0] = []


def p_empty(p):
    '''empty :'''
    pass


def p_error(p):
    if p:
        print(f"Syntax error at token '{p.type}' with value '{
              p.value}' at line {p.lineno}")
        # Optionally, raise an exception or implement recovery strategies
    else:
        print("Syntax error at EOF")
    sys.exit(1)  # Exit to prevent further errors


# Build the parser
parser = yacc.yacc()
