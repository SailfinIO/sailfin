import asyncio
from runtime import runtime_support as runtime

from compiler.build.ast import Program, Statement, Decorator, Expression, Block, FunctionSignature, Parameter, TypeAnnotation, MatchCase, ElseBranch
from compiler.build.token import Token, TokenKind
from compiler.build.string_utils import substring, char_at, char_code

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

LiteralValue = runtime.enum_type('LiteralValue')
LiteralValue = runtime.enum_define_variant(LiteralValue, 'String', ['value'])
LiteralValue = runtime.enum_define_variant(LiteralValue, 'Boolean', ['value'])
LiteralValue = runtime.enum_define_variant(LiteralValue, 'Number', ['value'])
LiteralValue = runtime.enum_define_variant(LiteralValue, 'Null', [])
LiteralValue = runtime.enum_define_variant(LiteralValue, 'Unsupported', [])

class DecoratorArgumentInfo:
    def __init__(self, value, name=None):
        self.name = name
        self.value = value

    def __repr__(self):
        return runtime.struct_repr('DecoratorArgumentInfo', [runtime.struct_field('name', self.name), runtime.struct_field('value', self.value)])

class DecoratorInfo:
    def __init__(self, name, arguments):
        self.name = name
        self.arguments = arguments

    def __repr__(self):
        return runtime.struct_repr('DecoratorInfo', [runtime.struct_field('name', self.name), runtime.struct_field('arguments', self.arguments)])

def infer_effects(existing, decorators):
    effects = clone_effects(existing)
    requires_io = contains_effect(effects, "io")
    index = 0
    while True:
        if index >= len(decorators):
            break
        decorator = decorators[index]
        if decorator.name == "trace"  or  decorator.name == "logExecution"  or  decorator.name == "logexecution":
            requires_io = True
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
        return runtime.enum_instantiate(LiteralValue, 'String', [runtime.enum_field('value', expr.value)])
    if expr.variant == "BooleanLiteral":
        return runtime.enum_instantiate(LiteralValue, 'Boolean', [runtime.enum_field('value', expr.value)])
    if expr.variant == "NumberLiteral":
        return runtime.enum_instantiate(LiteralValue, 'Number', [runtime.enum_field('value', expr.value)])
    if expr.variant == "NullLiteral":
        return LiteralValue.Null()
    if expr.variant == "Raw":
        text = trim_whitespace(expr.text)
        if len(text) == 0:
            return LiteralValue.Unsupported()
        if looks_like_quoted_string(text):
            literal = strip_surrounding_quotes(text)
            return runtime.enum_instantiate(LiteralValue, 'String', [runtime.enum_field('value', literal)])
        if text == "true":
            return runtime.enum_instantiate(LiteralValue, 'Boolean', [runtime.enum_field('value', "true")])
        if text == "false":
            return runtime.enum_instantiate(LiteralValue, 'Boolean', [runtime.enum_field('value', "false")])
        if looks_like_number(text):
            return runtime.enum_instantiate(LiteralValue, 'Number', [runtime.enum_field('value', text)])
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
        ch = char_code(char_at(value, start))
        if is_whitespace_codepoint(ch):
            start += 1
            continue
        break
    while True:
        if end <= start:
            break
        look_index = end - 1
        ch = char_code(char_at(value, look_index))
        if is_whitespace_codepoint(ch):
            end -= 1
            continue
        break
    return slice_text(value, start, end)

def looks_like_quoted_string(text):
    if len(text) < 2:
        return False
    first = char_code(char_at(text, 0))
    if first != 34:
        return False
    last_index = len(text) - 1
    last = char_code(char_at(text, last_index))
    if last != 34:
        return False
    return True

def looks_like_number(text):
    if len(text) == 0:
        return False
    has_decimal = False
    index = 0
    first = char_code(char_at(text, 0))
    if first == 45:
        if len(text) == 1:
            return False
        index = 1
    while True:
        if index >= len(text):
            break
        ch = char_code(char_at(text, index))
        if ch == 46:
            if has_decimal:
                return False
            has_decimal = True
            index += 1
            continue
        if not is_decimal_digit_codepoint(ch):
            return False
        index += 1
    return True

def is_decimal_digit_codepoint(ch):
    return ch >= 48  and  ch <= 57

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
            return True
        index += 1
    return False

def is_whitespace_codepoint(ch):
    return ch == 32  or  ch == 9  or  ch == 10  or  ch == 13

def slice_text(text, start, end):
    return substring(text, start, end)

def strip_surrounding_quotes(value):
    if len(value) < 2:
        return value
    return slice_text(value, 1, len(value) - 1)
