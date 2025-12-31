import asyncio
from runtime import runtime_support as runtime

from compiler.build.token import Token
from compiler.build.ast import Block, Decorator, DecoratorArgument, Expression, FieldDeclaration, FunctionSignature, EnumVariant, MethodDeclaration, ModelProperty, ObjectField, Parameter, Statement, ImportSpecifier, ExportSpecifier, TypeParameter, TypeAnnotation, MatchCase, ElseBranch, WithClause, SourceSpan

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
substring_unchecked = runtime.substring_unchecked
is_decimal_digit = runtime.is_decimal_digit
is_whitespace_char = runtime.is_whitespace_char
is_alpha_char = runtime.is_alpha_char
globals()['t' + 'rue'] = True
globals()['f' + 'alse'] = False

class Parser:
    def __init__(self, tokens, index):
        self.tokens = tokens
        self.index = index

    def __repr__(self):
        return runtime.struct_repr('Parser', [runtime.struct_field('tokens', self.tokens), runtime.struct_field('index', self.index)])

class StatementParseResult:
    def __init__(self, parser, statement):
        self.parser = parser
        self.statement = statement

    def __repr__(self):
        return runtime.struct_repr('StatementParseResult', [runtime.struct_field('parser', self.parser), runtime.struct_field('statement', self.statement)])

class BlockStatementParseResult:
    def __init__(self, parser, success, statement=None):
        self.parser = parser
        self.statement = statement
        self.success = success

    def __repr__(self):
        return runtime.struct_repr('BlockStatementParseResult', [runtime.struct_field('parser', self.parser), runtime.struct_field('statement', self.statement), runtime.struct_field('success', self.success)])

class BlockParseResult:
    def __init__(self, parser, block):
        self.parser = parser
        self.block = block

    def __repr__(self):
        return runtime.struct_repr('BlockParseResult', [runtime.struct_field('parser', self.parser), runtime.struct_field('block', self.block)])

class ParameterParseResult:
    def __init__(self, parser, parameter):
        self.parser = parser
        self.parameter = parameter

    def __repr__(self):
        return runtime.struct_repr('ParameterParseResult', [runtime.struct_field('parser', self.parser), runtime.struct_field('parameter', self.parameter)])

class ParameterListParseResult:
    def __init__(self, parser, parameters):
        self.parser = parser
        self.parameters = parameters

    def __repr__(self):
        return runtime.struct_repr('ParameterListParseResult', [runtime.struct_field('parser', self.parser), runtime.struct_field('parameters', self.parameters)])

class StructFieldParseResult:
    def __init__(self, parser, success, field=None):
        self.parser = parser
        self.field = field
        self.success = success

    def __repr__(self):
        return runtime.struct_repr('StructFieldParseResult', [runtime.struct_field('parser', self.parser), runtime.struct_field('field', self.field), runtime.struct_field('success', self.success)])

class ModelPropertyParseResult:
    def __init__(self, parser, success, property=None):
        self.parser = parser
        self.property = property
        self.success = success

    def __repr__(self):
        return runtime.struct_repr('ModelPropertyParseResult', [runtime.struct_field('parser', self.parser), runtime.struct_field('property', self.property), runtime.struct_field('success', self.success)])

class MethodParseResult:
    def __init__(self, parser, success, method=None):
        self.parser = parser
        self.method = method
        self.success = success

    def __repr__(self):
        return runtime.struct_repr('MethodParseResult', [runtime.struct_field('parser', self.parser), runtime.struct_field('method', self.method), runtime.struct_field('success', self.success)])

class InterfaceMemberParseResult:
    def __init__(self, parser, success, signature=None):
        self.parser = parser
        self.signature = signature
        self.success = success

    def __repr__(self):
        return runtime.struct_repr('InterfaceMemberParseResult', [runtime.struct_field('parser', self.parser), runtime.struct_field('signature', self.signature), runtime.struct_field('success', self.success)])

class EnumVariantParseResult:
    def __init__(self, parser, success, variant=None):
        self.parser = parser
        self.variant = variant
        self.success = success

    def __repr__(self):
        return runtime.struct_repr('EnumVariantParseResult', [runtime.struct_field('parser', self.parser), runtime.struct_field('variant', self.variant), runtime.struct_field('success', self.success)])

class TypeParameterParseResult:
    def __init__(self, parser, parameters):
        self.parser = parser
        self.parameters = parameters

    def __repr__(self):
        return runtime.struct_repr('TypeParameterParseResult', [runtime.struct_field('parser', self.parser), runtime.struct_field('parameters', self.parameters)])

class ImplementsParseResult:
    def __init__(self, parser, types, found):
        self.parser = parser
        self.types = types
        self.found = found

    def __repr__(self):
        return runtime.struct_repr('ImplementsParseResult', [runtime.struct_field('parser', self.parser), runtime.struct_field('types', self.types), runtime.struct_field('found', self.found)])

class DecoratorParseResult:
    def __init__(self, parser, decorators):
        self.parser = parser
        self.decorators = decorators

    def __repr__(self):
        return runtime.struct_repr('DecoratorParseResult', [runtime.struct_field('parser', self.parser), runtime.struct_field('decorators', self.decorators)])

class EffectParseResult:
    def __init__(self, parser, effects):
        self.parser = parser
        self.effects = effects

    def __repr__(self):
        return runtime.struct_repr('EffectParseResult', [runtime.struct_field('parser', self.parser), runtime.struct_field('effects', self.effects)])

class TypeSeparatorParseResult:
    def __init__(self, parser, found):
        self.parser = parser
        self.found = found

    def __repr__(self):
        return runtime.struct_repr('TypeSeparatorParseResult', [runtime.struct_field('parser', self.parser), runtime.struct_field('found', self.found)])

class SpecifierListParseResult:
    def __init__(self, parser, specifiers):
        self.parser = parser
        self.specifiers = specifiers

    def __repr__(self):
        return runtime.struct_repr('SpecifierListParseResult', [runtime.struct_field('parser', self.parser), runtime.struct_field('specifiers', self.specifiers)])

class NamedSpecifier:
    def __init__(self, name, alias=None):
        self.name = name
        self.alias = alias

    def __repr__(self):
        return runtime.struct_repr('NamedSpecifier', [runtime.struct_field('name', self.name), runtime.struct_field('alias', self.alias)])

class CaptureResult:
    def __init__(self, parser, tokens):
        self.parser = parser
        self.tokens = tokens

    def __repr__(self):
        return runtime.struct_repr('CaptureResult', [runtime.struct_field('parser', self.parser), runtime.struct_field('tokens', self.tokens)])

class ParenthesizedParseResult:
    def __init__(self, parser, tokens, success):
        self.parser = parser
        self.tokens = tokens
        self.success = success

    def __repr__(self):
        return runtime.struct_repr('ParenthesizedParseResult', [runtime.struct_field('parser', self.parser), runtime.struct_field('tokens', self.tokens), runtime.struct_field('success', self.success)])

class PatternCaptureResult:
    def __init__(self, parser, tokens, success):
        self.parser = parser
        self.tokens = tokens
        self.success = success

    def __repr__(self):
        return runtime.struct_repr('PatternCaptureResult', [runtime.struct_field('parser', self.parser), runtime.struct_field('tokens', self.tokens), runtime.struct_field('success', self.success)])

class MatchCasesParseResult:
    def __init__(self, parser, cases, success):
        self.parser = parser
        self.cases = cases
        self.success = success

    def __repr__(self):
        return runtime.struct_repr('MatchCasesParseResult', [runtime.struct_field('parser', self.parser), runtime.struct_field('cases', self.cases), runtime.struct_field('success', self.success)])

class MatchCaseParseResult:
    def __init__(self, parser, success, case=None):
        self.parser = parser
        self.case = case
        self.success = success

    def __repr__(self):
        return runtime.struct_repr('MatchCaseParseResult', [runtime.struct_field('parser', self.parser), runtime.struct_field('case', self.case), runtime.struct_field('success', self.success)])

class MatchCaseTokenSplit:
    def __init__(self, pattern_tokens, guard_tokens, has_guard):
        self.pattern_tokens = pattern_tokens
        self.guard_tokens = guard_tokens
        self.has_guard = has_guard

    def __repr__(self):
        return runtime.struct_repr('MatchCaseTokenSplit', [runtime.struct_field('pattern_tokens', self.pattern_tokens), runtime.struct_field('guard_tokens', self.guard_tokens), runtime.struct_field('has_guard', self.has_guard)])

class ExpressionTokens:
    def __init__(self, tokens, index):
        self.tokens = tokens
        self.index = index

    def __repr__(self):
        return runtime.struct_repr('ExpressionTokens', [runtime.struct_field('tokens', self.tokens), runtime.struct_field('index', self.index)])

class ExpressionParseResult:
    def __init__(self, state, expression, success):
        self.state = state
        self.expression = expression
        self.success = success

    def __repr__(self):
        return runtime.struct_repr('ExpressionParseResult', [runtime.struct_field('state', self.state), runtime.struct_field('expression', self.expression), runtime.struct_field('success', self.success)])

class ExpressionTypeSeparatorParseResult:
    def __init__(self, state, used_separator, found):
        self.state = state
        self.used_separator = used_separator
        self.found = found

    def __repr__(self):
        return runtime.struct_repr('ExpressionTypeSeparatorParseResult', [runtime.struct_field('state', self.state), runtime.struct_field('used_separator', self.used_separator), runtime.struct_field('found', self.found)])

class ExpressionCollectResult:
    def __init__(self, state, tokens, success):
        self.state = state
        self.tokens = tokens
        self.success = success

    def __repr__(self):
        return runtime.struct_repr('ExpressionCollectResult', [runtime.struct_field('state', self.state), runtime.struct_field('tokens', self.tokens), runtime.struct_field('success', self.success)])

class ExpressionBlockParseResult:
    def __init__(self, state, tokens, success):
        self.state = state
        self.tokens = tokens
        self.success = success

    def __repr__(self):
        return runtime.struct_repr('ExpressionBlockParseResult', [runtime.struct_field('state', self.state), runtime.struct_field('tokens', self.tokens), runtime.struct_field('success', self.success)])

class LambdaParameterParseResult:
    def __init__(self, state, parameter, success):
        self.state = state
        self.parameter = parameter
        self.success = success

    def __repr__(self):
        return runtime.struct_repr('LambdaParameterParseResult', [runtime.struct_field('state', self.state), runtime.struct_field('parameter', self.parameter), runtime.struct_field('success', self.success)])

class LambdaParameterListParseResult:
    def __init__(self, state, parameters, success):
        self.state = state
        self.parameters = parameters
        self.success = success

    def __repr__(self):
        return runtime.struct_repr('LambdaParameterListParseResult', [runtime.struct_field('state', self.state), runtime.struct_field('parameters', self.parameters), runtime.struct_field('success', self.success)])

class CallArgumentsParseResult:
    def __init__(self, state, arguments, success):
        self.state = state
        self.arguments = arguments
        self.success = success

    def __repr__(self):
        return runtime.struct_repr('CallArgumentsParseResult', [runtime.struct_field('state', self.state), runtime.struct_field('arguments', self.arguments), runtime.struct_field('success', self.success)])

class ArrayLiteralParseResult:
    def __init__(self, state, elements, success):
        self.state = state
        self.elements = elements
        self.success = success

    def __repr__(self):
        return runtime.struct_repr('ArrayLiteralParseResult', [runtime.struct_field('state', self.state), runtime.struct_field('elements', self.elements), runtime.struct_field('success', self.success)])

class ObjectLiteralParseResult:
    def __init__(self, state, fields, success):
        self.state = state
        self.fields = fields
        self.success = success

    def __repr__(self):
        return runtime.struct_repr('ObjectLiteralParseResult', [runtime.struct_field('state', self.state), runtime.struct_field('fields', self.fields), runtime.struct_field('success', self.success)])

class StructTypeNameResult:
    def __init__(self, parts, success):
        self.parts = parts
        self.success = success

    def __repr__(self):
        return runtime.struct_repr('StructTypeNameResult', [runtime.struct_field('parts', self.parts), runtime.struct_field('success', self.success)])

