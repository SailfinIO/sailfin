#!/usr/bin/env python3
from errors import CompilerError
from validator import ASTValidator
from ast_nodes import ASTNode
from code_generator import PythonCodeGenerator
from parser import parser
from lexer import lexer
import sys
import logging

#  ─── Logger Setup ───────────────────────────────────────────────────────────
logger = logging.getLogger("sailfin")
logger.setLevel(logging.DEBUG)

# Console handler
ch = logging.StreamHandler()
ch.setLevel(logging.DEBUG)

# Formatter: time, logger name, level, file:line, func
fmt = logging.Formatter(
    "%(asctime)s %(name)s %(levelname)-5s %(filename)s:%(lineno)d %(funcName)s() │ %(message)s",
    datefmt="%H:%M:%S",
)
ch.setFormatter(fmt)
logger.addHandler(ch)
# ──────────────────────────────────────────────────────────────────────────────


def inspect_tokens(source_code):
    lexer.input(source_code)
    for tok in lexer:
        # compute column if you like
        line_start = source_code.rfind("\n", 0, tok.lexpos) + 1
        col = tok.lexpos - line_start + 1
        logger.debug(
            f"Token {tok.type!r} {tok.value!r} at line {tok.lineno}, col {col}")


def print_ast(node, indent=0):
    prefix = " " * indent
    if isinstance(node, ASTNode):
        logger.debug(f"{prefix}{type(node).__name__}:")
        for attr, value in node.__dict__.items():
            logger.debug(f"{prefix}  {attr}:")
            print_ast(value, indent + 4)
    elif isinstance(node, str):
        logger.debug(f"{prefix}{node!r}")
    else:
        logger.debug(f"{prefix}{value!r}")


def compile_and_run(source_file):
    try:
        logger.info(f"Reading source file {source_file!r}")
        with open(source_file, "r") as f:
            source_code = f.read()

        logger.debug(f"Source ({len(source_code)} chars):\n{source_code!r}")

        logger.info("Inspecting tokens…")
        inspect_tokens(source_code)

        logger.info("Parsing…")
        ast = parser.parse(
            source_code,
            lexer=lexer,
            tracking=True,
            debug=True,
        )

        logger.info("Dumping AST structure…")
        print_ast(ast)

        logger.info("Validating AST…")
        ASTValidator.validate(ast)
        logger.info("AST validation successful.")

        logger.info("Generating Python code…")
        generator = PythonCodeGenerator()
        target_code = generator.visit(ast)
        logger.debug(f"Generated code:\n{target_code}")

        logger.info("Writing output.py and executing…")
        with open("output.py", "w") as f:
            f.write(target_code)
        namespace = {"__name__": "__main__"}
        exec(target_code, namespace)

    except CompilerError as e:
        logger.error("Compilation error: %s", e)
        sys.exit(1)

    except Exception:
        logger.error("Unexpected exception:", exc_info=True)
        sys.exit(1)


if __name__ == "__main__":
    if len(sys.argv) != 2:
        logger.error("Usage: python bootstrap.py <source_file.sfn>")
        sys.exit(1)
    compile_and_run(sys.argv[1])
