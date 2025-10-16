import asyncio
from runtime import runtime_support as runtime

from compiler.build.token import Token

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

Expression = runtime.enum_type('Expression')
Expression = runtime.enum_define_variant(Expression, 'Identifier', ['name'])
Expression = runtime.enum_define_variant(Expression, 'NumberLiteral', ['value'])
Expression = runtime.enum_define_variant(Expression, 'StringLiteral', ['value'])
Expression = runtime.enum_define_variant(Expression, 'BooleanLiteral', ['value'])
Expression = runtime.enum_define_variant(Expression, 'NullLiteral', [])
Expression = runtime.enum_define_variant(Expression, 'Unary', ['operator', 'operand'])
Expression = runtime.enum_define_variant(Expression, 'Binary', ['operator', 'left', 'right'])
Expression = runtime.enum_define_variant(Expression, 'Member', ['object', 'member'])
Expression = runtime.enum_define_variant(Expression, 'Call', ['callee', 'arguments'])
Expression = runtime.enum_define_variant(Expression, 'Index', ['sequence', 'index'])
Expression = runtime.enum_define_variant(Expression, 'Array', ['elements'])
Expression = runtime.enum_define_variant(Expression, 'Object', ['fields'])
Expression = runtime.enum_define_variant(Expression, 'Struct', ['type_name', 'fields'])
Expression = runtime.enum_define_variant(Expression, 'Lambda', ['parameters', 'body', 'return_type'])
Expression = runtime.enum_define_variant(Expression, 'Range', ['start', 'end'])
Expression = runtime.enum_define_variant(Expression, 'Raw', ['text'])

Statement = runtime.enum_type('Statement')
Statement = runtime.enum_define_variant(Statement, 'ImportDeclaration', ['specifiers', 'source'])
Statement = runtime.enum_define_variant(Statement, 'ExportDeclaration', ['specifiers', 'source'])
Statement = runtime.enum_define_variant(Statement, 'VariableDeclaration', ['name', 'mutable', 'type_annotation', 'initializer', 'span', 'initializer_span'])
Statement = runtime.enum_define_variant(Statement, 'ModelDeclaration', ['name', 'name_span', 'model_type', 'properties', 'effects', 'decorators'])
Statement = runtime.enum_define_variant(Statement, 'PipelineDeclaration', ['signature', 'body', 'decorators'])
Statement = runtime.enum_define_variant(Statement, 'ToolDeclaration', ['signature', 'body', 'decorators'])
Statement = runtime.enum_define_variant(Statement, 'TestDeclaration', ['name', 'name_span', 'body', 'effects', 'decorators'])
Statement = runtime.enum_define_variant(Statement, 'FunctionDeclaration', ['signature', 'body', 'decorators'])
Statement = runtime.enum_define_variant(Statement, 'StructDeclaration', ['name', 'name_span', 'type_parameters', 'implements_types', 'fields', 'methods', 'decorators'])
Statement = runtime.enum_define_variant(Statement, 'TypeAliasDeclaration', ['name', 'name_span', 'type_parameters', 'aliased_type', 'decorators'])
Statement = runtime.enum_define_variant(Statement, 'InterfaceDeclaration', ['name', 'name_span', 'type_parameters', 'members', 'decorators'])
Statement = runtime.enum_define_variant(Statement, 'EnumDeclaration', ['name', 'name_span', 'type_parameters', 'variants', 'decorators'])
Statement = runtime.enum_define_variant(Statement, 'PromptStatement', ['channel', 'keyword_token', 'channel_token', 'body', 'decorators'])
Statement = runtime.enum_define_variant(Statement, 'WithStatement', ['clauses', 'body', 'decorators'])
Statement = runtime.enum_define_variant(Statement, 'ForStatement', ['clause', 'body', 'decorators'])
Statement = runtime.enum_define_variant(Statement, 'LoopStatement', ['body', 'decorators'])
Statement = runtime.enum_define_variant(Statement, 'BreakStatement', [])
Statement = runtime.enum_define_variant(Statement, 'ContinueStatement', [])
Statement = runtime.enum_define_variant(Statement, 'MatchStatement', ['expression', 'cases', 'decorators'])
Statement = runtime.enum_define_variant(Statement, 'IfStatement', ['condition', 'then_block', 'else_branch', 'decorators'])
Statement = runtime.enum_define_variant(Statement, 'ReturnStatement', ['expression', 'span'])
Statement = runtime.enum_define_variant(Statement, 'ExpressionStatement', ['expression', 'span'])
Statement = runtime.enum_define_variant(Statement, 'Unknown', ['tokens', 'text'])

class Program:
    def __init__(self, statements):
        self.statements = statements

    def __repr__(self):
        return runtime.struct_repr('Program', [runtime.struct_field('statements', self.statements)])

class TypeAnnotation:
    def __init__(self, text):
        self.text = text

    def __repr__(self):
        return runtime.struct_repr('TypeAnnotation', [runtime.struct_field('text', self.text)])

class TypeParameter:
    def __init__(self, name, bound=None, span=None):
        self.name = name
        self.bound = bound
        self.span = span

    def __repr__(self):
        return runtime.struct_repr('TypeParameter', [runtime.struct_field('name', self.name), runtime.struct_field('bound', self.bound), runtime.struct_field('span', self.span)])

class Block:
    def __init__(self, tokens, text, statements):
        self.tokens = tokens
        self.text = text
        self.statements = statements

    def __repr__(self):
        return runtime.struct_repr('Block', [runtime.struct_field('tokens', self.tokens), runtime.struct_field('text', self.text), runtime.struct_field('statements', self.statements)])

class SourceSpan:
    def __init__(self, start_line, start_column, end_line, end_column):
        self.start_line = start_line
        self.start_column = start_column
        self.end_line = end_line
        self.end_column = end_column

    def __repr__(self):
        return runtime.struct_repr('SourceSpan', [runtime.struct_field('start_line', self.start_line), runtime.struct_field('start_column', self.start_column), runtime.struct_field('end_line', self.end_line), runtime.struct_field('end_column', self.end_column)])

class Parameter:
    def __init__(self, name, mutable, type_annotation=None, default_value=None, span=None):
        self.name = name
        self.type_annotation = type_annotation
        self.default_value = default_value
        self.mutable = mutable
        self.span = span

    def __repr__(self):
        return runtime.struct_repr('Parameter', [runtime.struct_field('name', self.name), runtime.struct_field('type_annotation', self.type_annotation), runtime.struct_field('default_value', self.default_value), runtime.struct_field('mutable', self.mutable), runtime.struct_field('span', self.span)])

class WithClause:
    def __init__(self, expression):
        self.expression = expression

    def __repr__(self):
        return runtime.struct_repr('WithClause', [runtime.struct_field('expression', self.expression)])

class ObjectField:
    def __init__(self, name, value):
        self.name = name
        self.value = value

    def __repr__(self):
        return runtime.struct_repr('ObjectField', [runtime.struct_field('name', self.name), runtime.struct_field('value', self.value)])

class ElseBranch:
    def __init__(self, statement=None, body=None):
        self.statement = statement
        self.body = body

    def __repr__(self):
        return runtime.struct_repr('ElseBranch', [runtime.struct_field('statement', self.statement), runtime.struct_field('body', self.body)])

class ForClause:
    def __init__(self, target, iterable, tokens):
        self.target = target
        self.iterable = iterable
        self.tokens = tokens

    def __repr__(self):
        return runtime.struct_repr('ForClause', [runtime.struct_field('target', self.target), runtime.struct_field('iterable', self.iterable), runtime.struct_field('tokens', self.tokens)])

class MatchCase:
    def __init__(self, pattern, body, guard=None):
        self.pattern = pattern
        self.guard = guard
        self.body = body

    def __repr__(self):
        return runtime.struct_repr('MatchCase', [runtime.struct_field('pattern', self.pattern), runtime.struct_field('guard', self.guard), runtime.struct_field('body', self.body)])

class ModelProperty:
    def __init__(self, name, value, span=None):
        self.name = name
        self.value = value
        self.span = span

    def __repr__(self):
        return runtime.struct_repr('ModelProperty', [runtime.struct_field('name', self.name), runtime.struct_field('value', self.value), runtime.struct_field('span', self.span)])

class FieldDeclaration:
    def __init__(self, name, type_annotation, mutable, name_span=None):
        self.name = name
        self.type_annotation = type_annotation
        self.mutable = mutable
        self.name_span = name_span

    def __repr__(self):
        return runtime.struct_repr('FieldDeclaration', [runtime.struct_field('name', self.name), runtime.struct_field('type_annotation', self.type_annotation), runtime.struct_field('mutable', self.mutable), runtime.struct_field('name_span', self.name_span)])

class MethodDeclaration:
    def __init__(self, signature, body, decorators):
        self.signature = signature
        self.body = body
        self.decorators = decorators

    def __repr__(self):
        return runtime.struct_repr('MethodDeclaration', [runtime.struct_field('signature', self.signature), runtime.struct_field('body', self.body), runtime.struct_field('decorators', self.decorators)])

class EnumVariant:
    def __init__(self, name, fields, name_span=None):
        self.name = name
        self.fields = fields
        self.name_span = name_span

    def __repr__(self):
        return runtime.struct_repr('EnumVariant', [runtime.struct_field('name', self.name), runtime.struct_field('fields', self.fields), runtime.struct_field('name_span', self.name_span)])

class FunctionSignature:
    def __init__(self, name, is_async, parameters, effects, type_parameters, return_type=None, name_span=None):
        self.name = name
        self.is_async = is_async
        self.parameters = parameters
        self.return_type = return_type
        self.effects = effects
        self.type_parameters = type_parameters
        self.name_span = name_span

    def __repr__(self):
        return runtime.struct_repr('FunctionSignature', [runtime.struct_field('name', self.name), runtime.struct_field('is_async', self.is_async), runtime.struct_field('parameters', self.parameters), runtime.struct_field('return_type', self.return_type), runtime.struct_field('effects', self.effects), runtime.struct_field('type_parameters', self.type_parameters), runtime.struct_field('name_span', self.name_span)])

class PipelineDeclaration:
    def __init__(self, signature, body, decorators):
        self.signature = signature
        self.body = body
        self.decorators = decorators

    def __repr__(self):
        return runtime.struct_repr('PipelineDeclaration', [runtime.struct_field('signature', self.signature), runtime.struct_field('body', self.body), runtime.struct_field('decorators', self.decorators)])

class ToolDeclaration:
    def __init__(self, signature, body, decorators):
        self.signature = signature
        self.body = body
        self.decorators = decorators

    def __repr__(self):
        return runtime.struct_repr('ToolDeclaration', [runtime.struct_field('signature', self.signature), runtime.struct_field('body', self.body), runtime.struct_field('decorators', self.decorators)])

class TestDeclaration:
    def __init__(self, name, body, effects, decorators):
        self.name = name
        self.body = body
        self.effects = effects
        self.decorators = decorators

    def __repr__(self):
        return runtime.struct_repr('TestDeclaration', [runtime.struct_field('name', self.name), runtime.struct_field('body', self.body), runtime.struct_field('effects', self.effects), runtime.struct_field('decorators', self.decorators)])

class ModelDeclaration:
    def __init__(self, name, model_type, properties, effects, decorators):
        self.name = name
        self.model_type = model_type
        self.properties = properties
        self.effects = effects
        self.decorators = decorators

    def __repr__(self):
        return runtime.struct_repr('ModelDeclaration', [runtime.struct_field('name', self.name), runtime.struct_field('model_type', self.model_type), runtime.struct_field('properties', self.properties), runtime.struct_field('effects', self.effects), runtime.struct_field('decorators', self.decorators)])

class Decorator:
    def __init__(self, name, arguments):
        self.name = name
        self.arguments = arguments

    def __repr__(self):
        return runtime.struct_repr('Decorator', [runtime.struct_field('name', self.name), runtime.struct_field('arguments', self.arguments)])

class DecoratorArgument:
    def __init__(self, expression, name=None):
        self.name = name
        self.expression = expression

    def __repr__(self):
        return runtime.struct_repr('DecoratorArgument', [runtime.struct_field('name', self.name), runtime.struct_field('expression', self.expression)])

class ImportSpecifier:
    def __init__(self, name, alias=None):
        self.name = name
        self.alias = alias

    def __repr__(self):
        return runtime.struct_repr('ImportSpecifier', [runtime.struct_field('name', self.name), runtime.struct_field('alias', self.alias)])

class ExportSpecifier:
    def __init__(self, name, alias=None):
        self.name = name
        self.alias = alias

    def __repr__(self):
        return runtime.struct_repr('ExportSpecifier', [runtime.struct_field('name', self.name), runtime.struct_field('alias', self.alias)])

