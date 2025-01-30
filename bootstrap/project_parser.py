# bootstrap/project_parser.py

import sys
import ply.yacc as yacc
from lexer import tokens
from project_ast import Project, BuildConfig, TestConfig, RunConfig
from ast_nodes import ImportStatement

# Define precedence if necessary
precedence = ()  # project.sfn may not need operator precedence


def p_project(p):
    '''project : import_section metadata_section dependencies_section dev_dependencies_section build_section test_section scripts_section run_section'''
    p[0] = Project(
        imports=p[1],
        name=p[2]['name'],
        version=p[2]['version'],
        description=p[2]['description'],
        dependencies=p[3],
        dev_dependencies=p[4],
        build=p[5],
        test=p[6],
        scripts=p[7],
        run=p[8]
    )


def p_import_section(p):
    '''import_section : import_statement
                      | empty'''
    if isinstance(p[1], list):
        p[0] = p[1]
    else:
        p[0] = []


def p_metadata_section(p):
    '''metadata_section : NAME COLON STRING
                        | VERSION COLON STRING
                        | DESCRIPTION COLON STRING
                        | metadata_section NAME COLON STRING
                        | metadata_section VERSION COLON STRING
                        | metadata_section DESCRIPTION COLON STRING'''
    metadata = {}
    if len(p) == 4:
        metadata[p[1].lower()] = p[3]
    else:
        metadata = p[1]
        metadata[p[2].lower()] = p[4]
    p[0] = metadata


def p_dependencies_section(p):
    '''dependencies_section : DEPENDENCIES COLON LBRACE dependency_list RBRACE
                            | empty'''
    if len(p) == 6:
        p[0] = p[4]
    else:
        p[0] = {}


def p_dev_dependencies_section(p):
    '''dev_dependencies_section : DEVDEPENDENCIES COLON LBRACE dependency_list RBRACE
                                 | empty'''
    if len(p) == 6:
        p[0] = p[4]
    else:
        p[0] = {}


def p_build_section(p):
    '''build_section : BUILD LBRACE build_fields RBRACE
                     | empty'''
    if len(p) == 5:
        p[0] = BuildConfig(
            entry=p[3].get('entry'),
            output=p[3].get('output'),
            optimize=p[3].get('optimize', False)
        )
    else:
        p[0] = BuildConfig(entry=None, output=None, optimize=False)


def p_build_fields(p):
    '''build_fields : build_fields build_field
                    | build_field'''
    if len(p) == 3:
        p[0] = p[1]
        p[0].update(p[2])
    else:
        p[0] = p[1]


def p_build_field(p):
    '''build_field : ENTRY COLON STRING
                   | OUTPUT COLON STRING
                   | OPTIMIZE COLON BOOLEAN'''
    if p[1].lower() == 'optimize':
        p[0] = {p[1].lower(): p[3]}
    else:
        p[0] = {p[1].lower(): p[3]}


def p_test_section(p):
    '''test_section : TEST LBRACE test_fields RBRACE
                   | empty'''
    if len(p) == 5:
        p[0] = TestConfig(
            directories=p[3].get('directories', []),
            coverage=p[3].get('coverage', False)
        )
    else:
        p[0] = TestConfig(directories=[], coverage=False)


def p_test_fields(p):
    '''test_fields : test_fields test_field
                   | test_field'''
    if len(p) == 3:
        p[0] = p[1]
        p[0].update(p[2])
    else:
        p[0] = p[1]


def p_test_field(p):
    '''test_field : DIRECTORIES COLON LBRACKET string_list RBRACKET
                  | COVERAGE COLON BOOLEAN'''
    if p[1].lower() == 'coverage':
        p[0] = {'coverage': p[3]}
    else:
        p[0] = {'directories': p[4]}


def p_scripts_section(p):
    '''scripts_section : SCRIPTS COLON LBRACE script_list RBRACE
                       | empty'''
    if len(p) == 5:
        p[0] = p[4]
    else:
        p[0] = {}


def p_script_list_multiple(p):
    '''script_list : script_list COMMA script_entry
                   | script_list script_entry'''
    p[0] = p[1]
    p[0].update(p[3])


def p_script_list_single(p):
    '''script_list : script_entry'''
    p[0] = p[1]


def p_script_entry(p):
    '''script_entry : IDENTIFIER COLON STRING'''
    p[0] = {p[1]: p[3]}


def p_run_section(p):
    '''run_section : RUN LBRACE run_fields RBRACE
                   | empty'''
    if len(p) == 5:
        p[0] = RunConfig(
            script=p[3].get('script'),
            args=p[3].get('args', [])
        )
    else:
        p[0] = RunConfig(script=None, args=[])


def p_run_fields(p):
    '''run_fields : run_fields run_field
                  | run_field'''
    if len(p) == 3:
        p[0] = p[1]
        p[0].update(p[2])
    else:
        p[0] = p[1]


def p_run_field(p):
    '''run_field : SCRIPT COLON STRING
                 | ARGS COLON LBRACKET string_list RBRACKET'''
    if p[1].lower() == 'args':
        p[0] = {'args': p[4]}
    else:
        p[0] = {'script': p[3]}


def p_dependency_list_multiple(p):
    '''dependency_list : dependency_list COMMA dependency_entry
                       | dependency_list COMMA
                       | dependency_list dependency_entry'''
    if len(p) == 4:
        p[0] = p[1]
        p[0].update(p[3])
    else:
        p[0] = p[1]


def p_dependency_list_single(p):
    '''dependency_list : dependency_entry'''
    p[0] = p[1]


def p_dependency_entry(p):
    '''dependency_entry : IDENTIFIER COLON STRING'''
    p[0] = {p[1]: p[3]}


def p_string_list_multiple(p):
    '''string_list : string_list COMMA STRING
                   | string_list COMMA'''
    if len(p) == 4:
        p[0] = p[1]
        p[0].append(p[3])
    else:
        p[0] = p[1]


def p_string_list_single(p):
    '''string_list : STRING'''
    p[0] = [p[1]]


def p_import_section(p):
    '''import_section : import_section import_statement
                      | import_statement
                      | empty'''
    if len(p) == 3:
        p[0] = p[1]
        p[0].append(p[2])
    elif len(p) == 2 and isinstance(p[1], ImportStatement):
        p[0] = [p[1]]
    else:
        p[0] = []


def p_import_statement(p):
    '''import_statement : IMPORT LBRACE import_items RBRACE FROM STRING'''
    p[0] = ImportStatement(items=p[3], source=p[5])


def p_import_items_multiple(p):
    '''import_items : import_items COMMA IDENTIFIER'''
    p[0] = p[1]
    p[0].append(p[3])


def p_import_items_single(p):
    '''import_items : IDENTIFIER'''
    p[0] = [p[1]]


def p_empty(p):
    '''empty :'''
    p[0] = None


def p_error(p):
    if p:
        print(f"Syntax error in project.sfn at token '{
              p.type}' with value '{p.value}' at line {p.lineno}")
    else:
        print("Syntax error in project.sfn at EOF")
    sys.exit(1)


# Build the project parser
project_parser = yacc.yacc(start='project', debug=False)
