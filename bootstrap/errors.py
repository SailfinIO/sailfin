# bootstrap/errors.py

class CompilerError(Exception):
    """Base class for compiler errors."""
    pass


class LexerError(CompilerError):
    def __init__(self, message, lineno):
        super().__init__(f"LexerError at line {lineno}: {message}")


class ParserError(CompilerError):
    def __init__(self, message, lineno=None):
        location = f" at line {lineno}" if lineno else ""
        super().__init__(f"ParserError{location}: {message}")


class ValidationError(CompilerError):
    def __init__(self, message):
        super().__init__(f"ValidationError: {message}")


class CodeGenerationError(CompilerError):
    def __init__(self, message):
        super().__init__(f"CodeGenerationError: {message}")
