import asyncio
from runtime import runtime_support as runtime

from compiler.build.ast import Program, Statement, Decorator, Expression, Block, FunctionSignature, Parameter, TypeAnnotation, MatchCase, ElseBranch
from compiler.build.token import Token, TokenKind
from compiler.build.string_utils import substring

print = runtime.console
sleep = runtime.sleep
channel = runtime.channel
parallel = runtime.parallel
spawn = runtime.spawn
fs = runtime.fs
serve = runtime.serve
http = runtime.http
websocket = runtime.websocket
logExecution = runtime.logExecution
array_map = runtime.array_map
array_filter = runtime.array_filter
array_reduce = runtime.array_reduce
globals()['t' + 'rue'] = True
globals()['f' + 'alse'] = False

LiteralValue = runtime.EnumType('LiteralValue')
LiteralValue.String = LiteralValue.variant('String', ['value'])
LiteralValue.Boolean = LiteralValue.variant('Boolean', ['value'])
LiteralValue.Number = LiteralValue.variant('Number', ['value'])
LiteralValue.Null = LiteralValue.variant('Null', [])
LiteralValue.Unsupported = LiteralValue.variant('Unsupported', [])

class DecoratorArgumentInfo:
    def __init__(self, value, name=None):
        self.name = name
        self.value = value

class DecoratorInfo:
    def __init__(self, name, arguments):
        self.name = name
        self.arguments = arguments

def infer_effects(existing, decorators):
    effects = clone_effects(existing)
    requires_io = contains_effect(effects, "io")
    index = 0
    while True:
        if index >= len(decorators):
            break
        decorator = decorators[index]
        if decorator.name == "trace"  or  decorator.name == "logExecution"  or  decorator.name == "logexecution":
            requires_io = true
        index += 1
    if requires_io  and  not contains_effect(effects, "io"):
        effects = append_string(effects, "io")
    return effects

def evaluate_decorators(decorators):
    results = []
    index = 0
    while True:
        if index >= len(decorators):
            break
        decorator = decorators[index]
        argument_infos = evaluate_arguments(decorator.arguments)
        results = append_decorator_info(results, DecoratorInfo(name=decorator.name, arguments=argument_infos))
        index += 1
    return results

def evaluate_arguments(arguments):
    infos = []
    index = 0
    while True:
        if index >= len(arguments):
            break
        argument = arguments[index]
        value = evaluate_expression(argument.expression)
        infos = append_argument_info(infos, DecoratorArgumentInfo(name=argument.name, value=value))
        index += 1
    return infos

def evaluate_expression(expr):
    if expr.variant == "StringLiteral":
        return LiteralValue.String(value=expr.value)
    if expr.variant == "BooleanLiteral":
        return LiteralValue.Boolean(value=expr.value)
    if expr.variant == "NumberLiteral":
        return LiteralValue.Number(value=expr.value)
    if expr.variant == "NullLiteral":
        return LiteralValue.Null()
    if expr.variant == "Raw":
        text = trim_whitespace(expr.text)
        if len(text) == 0:
            return LiteralValue.Unsupported()
        if looks_like_quoted_string(text):
            literal = strip_surrounding_quotes(text)
            return LiteralValue.String(value=literal)
        if text == "true":
            return LiteralValue.Boolean(value=true)
        if text == "false":
            return LiteralValue.Boolean(value=false)
        if looks_like_number(text):
            return LiteralValue.Number(value=text)
    return LiteralValue.Unsupported()

def evaluate_statement_decorators(statement):
    if statement.variant == "FunctionDeclaration":
        return evaluate_decorators(statement.decorators)
    if statement.variant == "StructDeclaration":
        return evaluate_decorators(statement.decorators)
    return []

def trim_whitespace(value):
    start = 0
    end = len(value)
    while True:
        if start >= end:
            break
        ch = value[start]
        if is_whitespace_char(ch):
            start += 1
            continue
        break
    while True:
        if end <= start:
            break
        ch = value[end - 1]
        if is_whitespace_char(ch):
            end -= 1
            continue
        break
    return slice_text(value, start, end)

def looks_like_quoted_string(text):
    if len(text) < 2:
        return false
    if text[0] != "\"":
        return false
    if text[len(text) - 1] != "\"":
        return false
    return true

def looks_like_number(text):
    if len(text) == 0:
        return false
    has_decimal = false
    index = 0
    if text[0] == "-":
        if len(text) == 1:
            return false
        index = 1
    while True:
        if index >= len(text):
            break
        ch = text[index]
        if ch == ".":
            if has_decimal:
                return false
            has_decimal = true
            index += 1
            continue
        if not is_decimal_digit(ch):
            return false
        index += 1
    return true

def is_decimal_digit(ch):
    return ch == "0"  or  ch == "1"  or  ch == "2"  or  ch == "3"  or  ch == "4"  or  ch == "5"  or  ch == "6"  or  ch == "7"  or  ch == "8"  or  ch == "9"

def append_decorator_info(collection, item):
    return (collection) + ([item])

def append_argument_info(collection, item):
    return (collection) + ([item])

def append_string(collection, item):
    return (collection) + ([item])

def clone_effects(effects):
    clone = []
    index = 0
    while True:
        if index >= len(effects):
            break
        clone = append_string(clone, effects[index])
        index += 1
    return clone

def contains_effect(effects, effect):
    index = 0
    while True:
        if index >= len(effects):
            break
        if effects[index] == effect:
            return true
        index += 1
    return false

def is_whitespace_char(ch):
    return ch == " "  or  ch == "\t"  or  ch == "\n"  or  ch == "\r"

def slice_text(text, start, end):
    return substring(text, start, end)

def strip_surrounding_quotes(value):
    if len(value) < 2:
        return value
    return slice_text(value, 1, len(value) - 1)
