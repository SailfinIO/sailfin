#!/usr/bin/env python3
from errors import CompilerError
from validator import ASTValidator
from ast_nodes import ASTNode
from code_generator import PythonCodeGenerator
from parser import parser
from lexer import lexer
from module_loader import get_module_loader, reset_module_loader
import sys
import logging
import argparse
import os

#  ─── Logger Setup ───────────────────────────────────────────────────────────
logger = logging.getLogger("sailfin")


def setup_logging(verbose=False):
    """Setup logging based on verbosity level"""
    if verbose:
        logger.setLevel(logging.DEBUG)
        ch = logging.StreamHandler()
        ch.setLevel(logging.DEBUG)
        fmt = logging.Formatter(
            "%(asctime)s %(name)s %(levelname)-5s %(filename)s:%(lineno)d %(funcName)s() │ %(message)s",
            datefmt="%H:%M:%S",
        )
        ch.setFormatter(fmt)
        logger.addHandler(ch)
    else:
        # Production mode - only errors to stderr
        logger.setLevel(logging.ERROR)
        ch = logging.StreamHandler(sys.stderr)
        ch.setLevel(logging.ERROR)
        fmt = logging.Formatter("sfn: %(levelname)s: %(message)s")
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
        logger.debug(f"{prefix}{node!r}")


def compile_and_run(source_file, output_file=None, verbose=False, run_output=True):
    """
    Compile a Sailfin source file to Python and optionally run it.

    Args:
        source_file: Path to the .sfn source file
        output_file: Optional output file path (default: output.py)
        verbose: Enable verbose logging
        run_output: Whether to execute the compiled code
    """
    try:
        # Reset module loader to clear any cached modules from previous runs
        reset_module_loader()

        if verbose:
            logger.info(f"Reading source file {source_file!r}")

        if not os.path.exists(source_file):
            logger.error(f"Source file not found: {source_file}")
            sys.exit(1)

        with open(source_file, "r") as f:
            source_code = f.read()

        if verbose:
            logger.debug(
                f"Source ({len(source_code)} chars):\n{source_code!r}")
            logger.info("Inspecting tokens…")
            inspect_tokens(source_code)

        if verbose:
            logger.info("Parsing…")

        # Parse without debug output in production mode
        ast = parser.parse(
            source_code,
            lexer=lexer,
            tracking=True,
            debug=verbose,  # Only show parser debug in verbose mode
        )

        if verbose:
            logger.info("Dumping AST structure…")
            print_ast(ast)

        if verbose:
            logger.info("Validating AST…")
        validator = ASTValidator()
        validator.validate(ast)
        if verbose:
            logger.info("AST validation successful.")

        # Set up module loader for the source file's directory
        source_dir = os.path.dirname(os.path.abspath(source_file))
        module_loader = get_module_loader(source_dir)

        if verbose:
            logger.info("Generating Python code…")
        generator = PythonCodeGenerator()
        generator.module_loader = module_loader  # Inject module loader
        # Set current file for relative imports
        generator.current_file = source_file
        target_code = generator.visit(ast)
        if verbose:
            logger.debug(f"Generated code:\n{target_code}")

        # Determine output file
        if output_file is None:
            output_file = "output.py"

        if verbose:
            logger.info(f"Writing {output_file}")
        with open(output_file, "w") as f:
            f.write(target_code)

        if run_output:
            if verbose:
                logger.info("Executing compiled code…")
            namespace = {"__name__": "__main__"}

            # Add the source file's directory to sys.path so imports can be resolved
            source_dir = os.path.dirname(os.path.abspath(source_file))
            if source_dir not in sys.path:
                sys.path.insert(0, source_dir)

            exec(target_code, namespace)
        elif verbose:
            logger.info(
                f"Compilation successful. Output written to {output_file}")

    except CompilerError as e:
        logger.error(f"Compilation failed: {e}")
        sys.exit(1)

    except FileNotFoundError as e:
        logger.error(f"File not found: {e}")
        sys.exit(1)

    except Exception as e:
        if verbose:
            logger.error("Unexpected exception:", exc_info=True)
        else:
            logger.error(f"Internal compiler error: {e}")
        sys.exit(1)


def main():
    parser_args = argparse.ArgumentParser(
        description="Sailfin compiler - compile .sfn files to Python",
        prog="sfn"
    )
    parser_args.add_argument(
        "source_file",
        help="Sailfin source file to compile (.sfn)"
    )
    parser_args.add_argument(
        "-o", "--output",
        help="Output file path (default: output.py)",
        default=None
    )
    parser_args.add_argument(
        "-c", "--compile-only",
        help="Compile only, don't execute the output",
        action="store_true"
    )
    parser_args.add_argument(
        "-v", "--verbose",
        help="Enable verbose output for debugging",
        action="store_true"
    )

    args = parser_args.parse_args()

    # Setup logging based on verbosity
    setup_logging(args.verbose)

    # Validate source file extension
    if not args.source_file.endswith('.sfn'):
        logger.error("Source file must have .sfn extension")
        sys.exit(1)

    # Compile and optionally run
    compile_and_run(
        source_file=args.source_file,
        output_file=args.output,
        verbose=args.verbose,
        run_output=not args.compile_only
    )


if __name__ == "__main__":
    main()
