# bootstrap/bootstrap.py

import enum
import sys
from lexer import lexer
from parser import parser
from code_generator import PythonCodeGenerator
from ast_nodes import ASTNode
from validator import ASTValidator
from errors import CompilerError


def inspect_tokens(source_code):
    lexer.input(source_code)
    for tok in lexer:
        print(tok)


def print_ast(node, indent=0):
    prefix = ' ' * indent
    if isinstance(node, ASTNode):
        print(f"{prefix}{type(node).__name__}:")
        for attr, value in node.__dict__.items():
            print(f"{prefix}  {attr}:")
            print_ast(value, indent + 4)
    elif isinstance(node, str):
        print(f"{prefix}'{node}'")
    else:
        print(f"{prefix}{repr(node)}")


def compile_and_run(source_file):
    try:
        with open(source_file, 'r') as f:
            source_code = f.read()
        print(repr(source_code))

        # Inspect tokens
        print("Token Inspection:")
        inspect_tokens(source_code)
        print("\n")

        # Lexing and Parsing
        ast = parser.parse(source_code, lexer=lexer)

        # Pretty-print the AST for debugging
        print("AST Structure:")
        print_ast(ast)
        print("\n")

        # Validate AST
        ASTValidator.validate(ast)
        print("AST validation successful.")

        # Code Generation
        generator = PythonCodeGenerator()
        target_code = generator.visit(ast)

        print("Generated Python Code:")
        print(target_code)  # Optional: Print the generated code for debugging

        # Optionally, write the target code to a file
        with open('output.py', 'w') as f:
            f.write(target_code)

        # Execute the generated Python code in a separate namespace
        namespace = {'__name__': '__main__'}  # Mimic script execution
        exec(target_code, namespace)

    except CompilerError as e:
        print(e)
    except Exception as e:
        import traceback
        print("Unexpected Error:")
        traceback.print_exc()


if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python bootstrap.py <source_file.sfn>")
    else:
        compile_and_run(sys.argv[1])
