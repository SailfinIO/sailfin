# bootstrap/lexer.py

import ply.lex as lex
from errors import LexerError

# List of token names, including reserved keywords
reserved = {
    'fn': 'FN',
    'lambda': 'LAMBDA',
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
    'assert': 'ASSERT',
    'is': 'IS',
    'new': 'NEW',
}

tokens = [
    'IDENTIFIER',
    'NUMBER',
    'STRING',
    # Operators
    'PLUS', 'MINUS', 'MULTIPLY', 'DIVIDE', 'ASSIGN',
    'PLUS_ASSIGN', 'MINUS_ASSIGN', 'MULTIPLY_ASSIGN', 'DIVIDE_ASSIGN', 'QUESTION',
    # Delimiters
    'LPAREN', 'RPAREN', 'LBRACE', 'RBRACE', 'LBRACKET', 'RBRACKET',
    'SEMICOLON', 'COMMA', 'DOT', 'COLON', 'AT', 'UNDERSCORE',
    # Comparison Operators
    'LT', 'GT', 'LEQ', 'GEQ', 'EQ', 'NEQ',
    # Logical Operators
    'AND', 'OR', 'NOT',
    # Arrows
    'ARROW',
    'FAT_ARROW',
    # Union and Intersection operators
    'PIPE',
    'AMP'
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
t_QUESTION = r'\?'
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
t_FAT_ARROW = r'=>'
t_PIPE = r'\|'
t_AMP = r'&'

# Regular expression rules with actions


def t_IDENTIFIER(t):
    r'[A-Za-z_][A-Za-z0-9_]*'
    if t.value == '_':
        t.type = 'UNDERSCORE'
    else:
        # Check for reserved words
        t.type = reserved.get(t.value, 'IDENTIFIER')
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
    # find the start of this line
    data = t.lexer.lexdata
    pos = t.lexpos
    line_start = data.rfind("\n", 0, pos) + 1
    line_end = data.find("\n", pos)
    if line_end == -1:
        line_end = len(data)
    line_text = data[line_start:line_end]
    col = pos - line_start + 1

    msg = (
        f"\nIllegal character {t.value[0]!r} "
        f"at line {t.lineno}, column {col!r}\n\n"
        f"  {line_text}\n"
        f"  {' '*(col-1)}^"
    )
    # raise with a nice message that your bootstrap catches
    raise LexerError(msg, t.lineno)


# Build the lexer
lexer = lex.lex()
