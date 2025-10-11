import asyncio
from bootstrap import runtime_support as runtime

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

Expression = runtime.EnumType('Expression')
Expression.Identifier = Expression.variant('Identifier', [])
Expression.NumberLiteral = Expression.variant('NumberLiteral', [])
Expression.StringLiteral = Expression.variant('StringLiteral', [])
Expression.BooleanLiteral = Expression.variant('BooleanLiteral', [])
Expression.NullLiteral = Expression.variant('NullLiteral', [])
Expression.Unary = Expression.variant('Unary', [])
Expression.Binary = Expression.variant('Binary', [])
Expression.Member = Expression.variant('Member', [])
Expression.Call = Expression.variant('Call', [])
Expression.Index = Expression.variant('Index', [])
Expression.Array = Expression.variant('Array', [])
Expression.Object = Expression.variant('Object', [])
Expression.Struct = Expression.variant('Struct', [])
Expression.Lambda = Expression.variant('Lambda', [])
Expression.Range = Expression.variant('Range', [])
Expression.Raw = Expression.variant('Raw', [])

Statement = runtime.EnumType('Statement')
Statement.ImportDeclaration = Statement.variant('ImportDeclaration', ['items', 'source'])
Statement.VariableDeclaration = Statement.variant('VariableDeclaration', ['name', 'mutable', 'type_annotation', 'initializer'])
Statement.ModelDeclaration = Statement.variant('ModelDeclaration', ['name', 'model_type', 'properties', 'effects', 'decorators'])
Statement.PipelineDeclaration = Statement.variant('PipelineDeclaration', ['signature', 'body', 'decorators'])
Statement.ToolDeclaration = Statement.variant('ToolDeclaration', ['signature', 'body', 'decorators'])
Statement.TestDeclaration = Statement.variant('TestDeclaration', ['name', 'body', 'effects', 'decorators'])
Statement.FunctionDeclaration = Statement.variant('FunctionDeclaration', ['signature', 'body', 'decorators'])
Statement.StructDeclaration = Statement.variant('StructDeclaration', ['name', 'type_parameters', 'implements_types', 'fields', 'methods', 'decorators'])
Statement.TypeAliasDeclaration = Statement.variant('TypeAliasDeclaration', ['name', 'type_parameters', 'aliased_type', 'decorators'])
Statement.InterfaceDeclaration = Statement.variant('InterfaceDeclaration', ['name', 'type_parameters', 'members', 'decorators'])
Statement.EnumDeclaration = Statement.variant('EnumDeclaration', ['name', 'type_parameters', 'variants', 'decorators'])
Statement.PromptStatement = Statement.variant('PromptStatement', ['channel', 'body', 'decorators'])
Statement.WithStatement = Statement.variant('WithStatement', ['clauses', 'body', 'decorators'])
Statement.ForStatement = Statement.variant('ForStatement', ['clause', 'body', 'decorators'])
Statement.LoopStatement = Statement.variant('LoopStatement', ['body', 'decorators'])
Statement.BreakStatement = Statement.variant('BreakStatement', [])
Statement.ContinueStatement = Statement.variant('ContinueStatement', [])
Statement.MatchStatement = Statement.variant('MatchStatement', ['expression', 'cases', 'decorators'])
Statement.IfStatement = Statement.variant('IfStatement', ['condition', 'then_block', 'else_branch', 'decorators'])
Statement.ReturnStatement = Statement.variant('ReturnStatement', ['expression'])
Statement.ExpressionStatement = Statement.variant('ExpressionStatement', ['expression'])
Statement.Unknown = Statement.variant('Unknown', ['tokens', 'text'])

class Program:
    def __init__(self, statements):
        self.statements = statements

class TypeAnnotation:
    def __init__(self, text):
        self.text = text

class TypeParameter:
    def __init__(self, name, bound=None):
        self.name = name
        self.bound = bound

class Block:
    def __init__(self, tokens, text, statements):
        self.tokens = tokens
        self.text = text
        self.statements = statements

class Parameter:
    def __init__(self, name, mutable, type_annotation=None, default_value=None):
        self.name = name
        self.type_annotation = type_annotation
        self.default_value = default_value
        self.mutable = mutable

class WithClause:
    def __init__(self, expression):
        self.expression = expression

class ObjectField:
    def __init__(self, name, value):
        self.name = name
        self.value = value

class ElseBranch:
    def __init__(self, statement=None, body=None):
        self.statement = statement
        self.body = body

class ForClause:
    def __init__(self, target, iterable, tokens):
        self.target = target
        self.iterable = iterable
        self.tokens = tokens

class MatchCase:
    def __init__(self, pattern, body, guard=None):
        self.pattern = pattern
        self.guard = guard
        self.body = body

class ModelProperty:
    def __init__(self, name, value):
        self.name = name
        self.value = value

class FieldDeclaration:
    def __init__(self, name, type_annotation, mutable):
        self.name = name
        self.type_annotation = type_annotation
        self.mutable = mutable

class MethodDeclaration:
    def __init__(self, signature, body, decorators):
        self.signature = signature
        self.body = body
        self.decorators = decorators

class EnumVariant:
    def __init__(self, name, fields):
        self.name = name
        self.fields = fields

class FunctionSignature:
    def __init__(self, name, is_async, parameters, effects, type_parameters, return_type=None):
        self.name = name
        self.is_async = is_async
        self.parameters = parameters
        self.return_type = return_type
        self.effects = effects
        self.type_parameters = type_parameters

class PipelineDeclaration:
    def __init__(self, signature, body, decorators):
        self.signature = signature
        self.body = body
        self.decorators = decorators

class ToolDeclaration:
    def __init__(self, signature, body, decorators):
        self.signature = signature
        self.body = body
        self.decorators = decorators

class TestDeclaration:
    def __init__(self, name, body, effects, decorators):
        self.name = name
        self.body = body
        self.effects = effects
        self.decorators = decorators

class ModelDeclaration:
    def __init__(self, name, model_type, properties, effects, decorators):
        self.name = name
        self.model_type = model_type
        self.properties = properties
        self.effects = effects
        self.decorators = decorators

class Decorator:
    def __init__(self, name, arguments):
        self.name = name
        self.arguments = arguments

class DecoratorArgument:
    def __init__(self, expression, name=None):
        self.name = name
        self.expression = expression

