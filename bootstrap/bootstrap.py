# bootstrap/compiler.py

import sys
from lexer import lexer
from parser import parser
from code_generator import CodeGenerator
from ast_nodes import ASTNode


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
            if isinstance(value, list):
                for item in value:
                    print_ast(item, indent + 4)
            else:
                print_ast(value, indent + 4)
    elif isinstance(node, str):
        print(f"{prefix}'{node}'")
    else:
        print(f"{prefix}{repr(node)}")


def validate_ast(node):
    if isinstance(node, ASTNode):
        for attr, value in node.__dict__.items():
            if isinstance(value, list):
                for item in value:
                    validate_ast(item)
            elif isinstance(value, ASTNode):
                validate_ast(value)
            elif value is not None and not isinstance(value, (int, float, str, bool, tuple)):
                # If it's not None, not an ASTNode, and not a basic type/tuple we accept
                raise TypeError(f"Invalid AST node type: {
                                type(value).__name__}")
    else:
        if node is not None and not isinstance(node, (int, float, str, bool, tuple)):
            raise TypeError(f"Invalid AST node type: {type(node).__name__}")


def compile_and_run(source_file):
    with open(source_file, 'r') as f:
        source_code = f.read()

    # Inspect tokens
    print("Token Inspection:")
    inspect_tokens(source_code)
    print("\n")

    # Lexing and Parsing
    ast = parser.parse(source_code, lexer=lexer)

    if ast is None:
        print("Parsing failed due to syntax errors.")
        return

    # Pretty-print the AST for debugging
    print("AST Structure:")
    print_ast(ast)

    # Validate AST
    try:
        validate_ast(ast)
    except TypeError as e:
        print(f"AST Validation Error: {e}")
        return

    # Code Generation
    generator = CodeGenerator()
    try:
        target_code = generator.generate_code(ast)
    except NotImplementedError as error:
        print("\nCode generation is not available yet:")
        print(f"  {error}")
        return

    print("\nGenerated Python Code:")
    print(target_code)  # Optional: Print the generated code for debugging

    # Optionally, write the target code to a file
    with open('output.py', 'w') as f:
        f.write(target_code)

    # Execute the generated Python code in a separate namespace
    namespace = {'__name__': '__main__'}  # Mimic script execution
    try:
        exec(target_code, namespace)
    except Exception:
        import traceback
        print("Runtime Error:")
        traceback.print_exc()


if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python compiler.py <source_file.sfn>")
    else:
        compile_and_run(sys.argv[1])
