# bootstrap/lexer.py

import ply.lex as lex
from errors import LexerError

# List of token names, including reserved keywords
reserved = {
    'fn': 'FN',
    'print': 'PRINT',
    'info': 'INFO',
    'let': 'LET',
    'mut': 'MUT',
    'return': 'RETURN',
    'if': 'IF',
    'else': 'ELSE',
    'match': 'MATCH',
    'const': 'CONST',
    'async': 'ASYNC',
    'await': 'AWAIT',
    'import': 'IMPORT',
    'from': 'FROM',
    'struct': 'STRUCT',
    'enum': 'ENUM',
    'interface': 'INTERFACE',
    'implements': 'IMPLEMENTS',
    'throw': 'THROW',
    'try': 'TRY',
    'catch': 'CATCH',
    'finally': 'FINALLY',
    'for': 'FOR',
    'while': 'WHILE',
    'in': 'IN',
    'test': 'TEST',
}

tokens = [
    'IDENTIFIER',
    'NUMBER',
    'STRING',
    # Operators
    'PLUS', 'MINUS', 'MULTIPLY', 'DIVIDE', 'ASSIGN',
    'PLUS_ASSIGN', 'MINUS_ASSIGN', 'MULTIPLY_ASSIGN', 'DIVIDE_ASSIGN',
    # Delimiters
    'LPAREN', 'RPAREN', 'LBRACE', 'RBRACE', 'LBRACKET', 'RBRACKET',
    'SEMICOLON', 'COMMA', 'DOT', 'COLON', 'AT', 'UNDERSCORE',
    # Comparison Operators
    'LT', 'GT', 'LEQ', 'GEQ', 'EQ', 'NEQ',
    # Logical Operators
    'AND', 'OR', 'NOT',
    # Arrows
    'ARROW',
] + list(reserved.values())

# Regular expression rules for simple tokens
t_PLUS = r'\+'
t_MINUS = r'-'
t_MULTIPLY = r'\*'
t_DIVIDE = r'/'
t_ASSIGN = r'='
t_PLUS_ASSIGN = r'\+='
t_MINUS_ASSIGN = r'-='
t_MULTIPLY_ASSIGN = r'\*='
t_DIVIDE_ASSIGN = r'/='
t_LPAREN = r'\('
t_RPAREN = r'\)'
t_LBRACE = r'\{'
t_RBRACE = r'\}'
t_LBRACKET = r'\['
t_RBRACKET = r'\]'
t_SEMICOLON = r';'
t_COMMA = r','
t_DOT = r'\.'
t_COLON = r':'
t_AT = r'@'
t_UNDERSCORE = r'_'
t_LT = r'<'
t_GT = r'>'
t_LEQ = r'<='
t_GEQ = r'>='
t_EQ = r'=='
t_NEQ = r'!='
t_AND = r'&&'
t_OR = r'\|\|'
t_NOT = r'!'
t_ARROW = r'->'

# Regular expression rules with actions


def t_IDENTIFIER(t):
    r'[A-Za-z_][A-Za-z0-9_]*'
    t.type = reserved.get(t.value, 'IDENTIFIER')  # Check for reserved words
    return t


def t_NUMBER(t):
    r'\d+(\.\d+)?'
    t.value = float(t.value) if '.' in t.value else int(t.value)
    return t


def t_STRING(t):
    r'\"([^\\\n]|(\\.))*?\"'
    t.value = t.value[1:-1]  # Remove quotes
    return t


# Define a rule for ignoring whitespace
t_ignore = ' \t'

# Define a rule for newlines


def t_newline(t):
    r'\n+'
    t.lexer.lineno += len(t.value)


# Define a rule for single-line comments


def t_comment(t):
    r'//.*'
    pass  # Ignore comments


# Define a rule for multi-line comments


def t_multiline_comment(t):
    r'/\*(.|\n)*?\*/'
    t.lexer.lineno += t.value.count('\n')
    pass


# Error handling rule


def t_error(t):
    error_message = f"Illegal character '{t.value[0]}' at line {t.lineno}"
    raise LexerError(error_message, t.lineno)


# Build the lexer
lexer = lex.lex()
