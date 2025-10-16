import asyncio
from runtime import runtime_support as runtime

from compiler.build.lexer import lex
from compiler.build.token import Token, TokenKind
from compiler.build.ast import Block, Decorator, DecoratorArgument, Expression, FieldDeclaration, FunctionSignature, EnumVariant, MethodDeclaration, ModelDeclaration, ModelProperty, ObjectField, Parameter, PipelineDeclaration, ForClause, Program, Statement, ImportSpecifier, ExportSpecifier, TypeParameter, TestDeclaration, TypeAnnotation, ToolDeclaration, MatchCase, ElseBranch, WithClause, SourceSpan
from compiler.build.decorator_semantics import evaluate_decorators, infer_effects
from compiler.build.string_utils import substring, char_code

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


class BlockStatementParseResult:
    def __init__(self, parser, success, statement=None):
        self.parser = parser
        self.statement = statement
        self.success = success

    def __repr__(self):
        return runtime.struct_repr('BlockStatementParseResult', [runtime.struct_field('parser', self.parser), runtime.struct_field('statement', self.statement), runtime.struct_field('success', self.success)])


class ParenthesizedParseResult:
    def __init__(self, parser, tokens, success):
        self.parser = parser
        self.tokens = tokens
        self.success = success

    def __repr__(self):
        return runtime.struct_repr('ParenthesizedParseResult', [runtime.struct_field('parser', self.parser), runtime.struct_field('tokens', self.tokens), runtime.struct_field('success', self.success)])


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


class CaptureResult:
    def __init__(self, parser, tokens):
        self.parser = parser
        self.tokens = tokens

    def __repr__(self):
        return runtime.struct_repr('CaptureResult', [runtime.struct_field('parser', self.parser), runtime.struct_field('tokens', self.tokens)])


class EffectParseResult:
    def __init__(self, parser, effects):
        self.parser = parser
        self.effects = effects

    def __repr__(self):
        return runtime.struct_repr('EffectParseResult', [runtime.struct_field('parser', self.parser), runtime.struct_field('effects', self.effects)])


class BlockParseResult:
    def __init__(self, parser, block):
        self.parser = parser
        self.block = block

    def __repr__(self):
        return runtime.struct_repr('BlockParseResult', [runtime.struct_field('parser', self.parser), runtime.struct_field('block', self.block)])


class PatternCaptureResult:
    def __init__(self, parser, tokens, success):
        self.parser = parser
        self.tokens = tokens
        self.success = success

    def __repr__(self):
        return runtime.struct_repr('PatternCaptureResult', [runtime.struct_field('parser', self.parser), runtime.struct_field('tokens', self.tokens), runtime.struct_field('success', self.success)])


def parse_program(source):
    tokens = lex(source)
    return parse_tokens(tokens)


def parse_tokens(tokens):
    parser = Parser(tokens=tokens, index=0)
    statements = []
    parser = skip_trivia(parser)
    while True:
        token = parser_peek_raw(parser)
        if token.kind.variant == "EndOfFile":
            break
        result = parse_statement(parser)
        parser = result.parser
        statements = append_statement(statements, result.statement)
        parser = skip_trivia(parser)
    return Program(statements=statements)


def parse_statement(parser):
    original = parser
    parser = skip_trivia(parser)
    decorator_result = parse_decorators(parser)
    parser = decorator_result.parser
    decorators = decorator_result.decorators
    parser = skip_trivia(parser)
    token = parser_peek_raw(parser)
    if identifier_matches(token, "import"):
        if len(decorators) > 0:
            return parse_unknown(original)
        return parse_import(parser)
    if identifier_matches(token, "let"):
        if len(decorators) > 0:
            return parse_unknown(original)
        return parse_variable(parser)
    if identifier_matches(token, "model"):
        if len(decorators) > 0:
            return parse_unknown(original)
        return parse_model(parser, decorators)
    if identifier_matches(token, "pipeline"):
        if len(decorators) > 0:
            return parse_unknown(original)
        return parse_pipeline(parser, decorators)
    if identifier_matches(token, "tool"):
        if len(decorators) > 0:
            return parse_unknown(original)
        return parse_tool(parser, decorators)
    if identifier_matches(token, "test"):
        if len(decorators) > 0:
            return parse_unknown(original)
        return parse_test(parser, decorators)
    if identifier_matches(token, "fn"):
        return parse_function(parser, False, decorators)
    if identifier_matches(token, "loop"):
        if identifier_matches(token, "async"):
            pass
        if identifier_matches(token, "break"):
            if len(decorators) > 0:
                return BlockStatementParseResult(parser=original, statement=None, success=False)
            return parse_break_statement(after_decorators)
        if identifier_matches(token, "continue"):
            if len(decorators) > 0:
                return BlockStatementParseResult(parser=original, statement=None, success=False)
            return parse_continue_statement(after_decorators)
        after = parser_peek_raw(lookahead)
        if identifier_matches(after, "fn"):
            return parse_function(parser, True, decorators)
    if identifier_matches(token, "import"):
        return parse_import(parser)
    if identifier_matches(token, "export"):
        return parse_export(parser)
    if identifier_matches(token, "struct"):
        return parse_struct(parser, decorators)
    if identifier_matches(token, "type"):
        return parse_type_alias(parser, decorators)
    if identifier_matches(token, "interface"):
        return parse_interface(parser, decorators)
    if identifier_matches(token, "enum"):
        return parse_enum(parser, decorators)
    if len(decorators) > 0:
        return parse_unknown(original)
    return parse_unknown(parser)


def parse_import(parser):
    parser = skip_trivia(parser)
    parser = consume_keyword(parser, "import")
    specifier_result = parse_specifier_list(parser)
    parser = specifier_result.parser
    import_specifiers = build_import_specifiers(specifier_result.specifiers)
    parser = skip_trivia(parser)
    parser = consume_keyword(parser, "from")
    parser = skip_trivia(parser)
    capture = collect_until(parser, [";"])
    parser = capture.parser
    source = trim_text(tokens_to_text(capture.tokens))
    source = strip_surrounding_quotes(source)
    parser = skip_trivia(parser)
    if parser_peek_raw(parser).kind.variant == "Symbol" and parser_peek_raw(parser).kind.value == ";":
        parser = parser_advance_raw(parser)
    statement = runtime.enum_instantiate(Statement, 'ImportDeclaration', [runtime.enum_field(
        'specifiers', import_specifiers), runtime.enum_field('source', source)])
    return StatementParseResult(parser=parser, statement=statement)


def parse_export(parser):
    parser = skip_trivia(parser)
    parser = consume_keyword(parser, "export")
    specifier_result = parse_specifier_list(parser)
    parser = specifier_result.parser
    export_specifiers = build_export_specifiers(specifier_result.specifiers)
    parser = skip_trivia(parser)
    parser = consume_keyword(parser, "from")
    parser = skip_trivia(parser)
    capture = collect_until(parser, [";"])
    parser = capture.parser
    source = trim_text(tokens_to_text(capture.tokens))
    source = strip_surrounding_quotes(source)
    parser = skip_trivia(parser)
    if parser_peek_raw(parser).kind.variant == "Symbol" and parser_peek_raw(parser).kind.value == ";":
        parser = parser_advance_raw(parser)
    statement = runtime.enum_instantiate(Statement, 'ExportDeclaration', [runtime.enum_field(
        'specifiers', export_specifiers), runtime.enum_field('source', source)])
    return StatementParseResult(parser=parser, statement=statement)


def parse_variable(parser):
    parser = skip_trivia(parser)
    statement_tokens = []
    let_token = parser_peek_raw(parser)
    statement_tokens = append_token(statement_tokens, let_token)
    parser = consume_keyword(parser, "let")
    mutable_flag = False
    parser = skip_trivia(parser)
    mut_token = parser_peek_raw(parser)
    if identifier_matches(mut_token, "mut"):
        statement_tokens = append_token(statement_tokens, mut_token)
        parser = consume_keyword(parser, "mut")
        mutable_flag = True
    parser = skip_trivia(parser)
    name_token = parser_peek_raw(parser)
    statement_tokens = append_token(statement_tokens, name_token)
    name = identifier_text(name_token)
    parser = parser_advance_raw(parser)
    type_annotation = None
    parser = skip_trivia(parser)
    separator = parser_peek_raw(parser)
    if separator.kind.variant == "Symbol" and separator.kind.value == ":" or separator.kind.value == "->":
        statement_tokens = append_token(statement_tokens, separator)
        parser = parser_advance_raw(parser)
        capture = collect_until(skip_trivia(parser), ["=", ";"])
        index = 0
        while True:
            if index >= len(capture.tokens):
                break
            statement_tokens = append_token(
                statement_tokens, capture.tokens[index])
            index += 1
        parser = capture.parser
        text = trim_text(tokens_to_text(capture.tokens))
        if len(text) > 0:
            type_annotation = TypeAnnotation(text=text)
    initializer = None
    initializer_span = None
    parser = skip_trivia(parser)
    assign = parser_peek_raw(parser)
    if assign.kind.variant == "Symbol" and assign.kind.value == "=":
        statement_tokens = append_token(statement_tokens, assign)
        parser = parser_advance_raw(parser)
        capture = collect_until(skip_trivia(parser), [";"])
        index = 0
        while True:
            if index >= len(capture.tokens):
                break
            statement_tokens = append_token(
                statement_tokens, capture.tokens[index])
            index += 1
        parser = capture.parser
        if len(capture.tokens) > 0:
            initializer_span = source_span_from_tokens(capture.tokens)
            initializer = expression_from_tokens(capture.tokens)
    parser = skip_trivia(parser)
    terminator = parser_peek_raw(parser)
    if terminator.kind.variant == "Symbol" and terminator.kind.value == ";":
        statement_tokens = append_token(statement_tokens, terminator)
        parser = parser_advance_raw(parser)
    span = source_span_from_tokens(statement_tokens)
    statement = runtime.enum_instantiate(Statement, 'VariableDeclaration', [runtime.enum_field('name', name), runtime.enum_field('mutable', mutable_flag), runtime.enum_field(
        'type_annotation', type_annotation), runtime.enum_field('initializer', initializer), runtime.enum_field('span', span), runtime.enum_field('initializer_span', initializer_span)])
    return StatementParseResult(parser=parser, statement=statement)


def parse_specifier_list(parser):
    parser = skip_trivia(parser)
    parser = consume_symbol(parser, "{")
    specifiers = []
    parser = skip_trivia(parser)
    while True:
        current = parser_peek_raw(parser)
        if current.kind.variant == "Symbol" and current.kind.value == "}":
            parser = parser_advance_raw(parser)
            break
        if current.kind.variant != "Identifier":
            break
        name = identifier_text(current)
        parser = parser_advance_raw(parser)
        parser = skip_trivia(parser)
        alias = None
        potential_alias = parser_peek_raw(parser)
        if identifier_matches(potential_alias, "as"):
            parser = consume_keyword(parser, "as")
            parser = skip_trivia(parser)
            alias_token = parser_peek_raw(parser)
            if alias_token.kind.variant == "Identifier":
                alias = identifier_text(alias_token)
                parser = parser_advance_raw(parser)
                parser = skip_trivia(parser)
        specifiers = (specifiers) + ([NamedSpecifier(name=name, alias=alias)])
        separator = parser_peek_raw(parser)
        if separator.kind.variant == "Symbol" and separator.kind.value == ",":
            parser = parser_advance_raw(parser)
            parser = skip_trivia(parser)
            continue
    parser = skip_trivia(parser)
    if parser_peek_raw(parser).kind.variant == "Symbol" and parser_peek_raw(parser).kind.value == "}":
        parser = parser_advance_raw(parser)
    return SpecifierListParseResult(parser=parser, specifiers=specifiers)


def build_import_specifiers(values):
    result = []
    index = 0
    while True:
        if index >= len(values):
            break
        entry = values[index]
        result = (result) + \
            ([ImportSpecifier(name=entry.name, alias=entry.alias)])
        index += 1
    return result


def build_export_specifiers(values):
    result = []
    index = 0
    while True:
        if index >= len(values):
            break
        entry = values[index]
        result = (result) + \
            ([ExportSpecifier(name=entry.name, alias=entry.alias)])
        index += 1
    return result


def parse_struct(parser, decorators):
    parser = skip_trivia(parser)
    parser = consume_keyword(parser, "struct")
    parser = skip_trivia(parser)
    name_token = parser_peek_raw(parser)
    name = identifier_text(name_token)
    name_span = source_span_from_tokens([name_token])
    parser = parser_advance_raw(parser)
    type_param_result = parse_type_parameter_clause(parser)
    parser = type_param_result.parser
    type_parameters = type_param_result.parameters
    implements_result = parse_implements_clause(parser)
    parser = implements_result.parser
    implements_types = implements_result.types
    parser = skip_trivia(parser)
    parser = advance_to_symbol(parser, "{")
    parser = consume_symbol(parser, "{")
    fields = []
    methods = []
    while True:
        parser = skip_trivia(parser)
        member_start = parser
        decorator_result = parse_decorators(parser)
        parser = decorator_result.parser
        member_decorators = decorator_result.decorators
        parser = skip_trivia(parser)
        token = parser_peek_raw(parser)
        if token.kind.variant == "Symbol" and token.kind.value == "}":
            parser = parser_advance_raw(parser)
            break
        if token.kind.variant == "EndOfFile":
            break
        field_result = parse_struct_field(parser)
        if field_result.success and len(member_decorators) == 0:
            if field_result.field != None:
                fields = append_field(fields, field_result.field)
            parser = field_result.parser
            continue
        method_result = parse_struct_method(parser, member_decorators)
        if method_result.success:
            if method_result.method != None:
                methods = append_method(methods, method_result.method)
            parser = method_result.parser
            continue
        parser = skip_struct_member(member_start)
    statement = runtime.enum_instantiate(Statement, 'StructDeclaration', [runtime.enum_field('name', name), runtime.enum_field('name_span', name_span), runtime.enum_field(
        'type_parameters', type_parameters), runtime.enum_field('implements_types', implements_types), runtime.enum_field('fields', fields), runtime.enum_field('methods', methods), runtime.enum_field('decorators', decorators)])
    return StatementParseResult(parser=parser, statement=statement)


def parse_type_alias(parser, decorators):
    original = parser
    parser = skip_trivia(parser)
    parser = consume_keyword(parser, "type")
    parser = skip_trivia(parser)
    name_token = parser_peek_raw(parser)
    if name_token.kind.variant != "Identifier":
        return parse_unknown(original)
    name = identifier_text(name_token)
    name_span = source_span_from_tokens([name_token])
    parser = parser_advance_raw(parser)
    type_param_result = parse_type_parameter_clause(parser)
    parser = type_param_result.parser
    type_parameters = type_param_result.parameters
    parser = skip_trivia(parser)
    equals = parser_peek_raw(parser)
    if equals.kind.variant != "Symbol" or equals.kind.value != "=":
        return parse_unknown(original)
    parser = parser_advance_raw(parser)
    capture = collect_until(skip_trivia(parser), [";"])
    parser = capture.parser
    aliased_text = trim_text(tokens_to_text(capture.tokens))
    if len(aliased_text) == 0:
        return parse_unknown(original)
    aliased_type = TypeAnnotation(text=aliased_text)
    parser = skip_trivia(parser)
    if parser_peek_raw(parser).kind.variant == "Symbol" and parser_peek_raw(parser).kind.value == ";":
        parser = parser_advance_raw(parser)
    statement = runtime.enum_instantiate(Statement, 'TypeAliasDeclaration', [runtime.enum_field('name', name), runtime.enum_field('name_span', name_span), runtime.enum_field(
        'type_parameters', type_parameters), runtime.enum_field('aliased_type', aliased_type), runtime.enum_field('decorators', decorators)])
    return StatementParseResult(parser=parser, statement=statement)


def parse_interface(parser, decorators):
    original = parser
    parser = skip_trivia(parser)
    parser = consume_keyword(parser, "interface")
    parser = skip_trivia(parser)
    name_token = parser_peek_raw(parser)
    if name_token.kind.variant != "Identifier":
        return parse_unknown(original)
    name = identifier_text(name_token)
    name_span = source_span_from_tokens([name_token])
    parser = parser_advance_raw(parser)
    type_param_result = parse_type_parameter_clause(parser)
    parser = type_param_result.parser
    type_parameters = type_param_result.parameters
    parser = skip_trivia(parser)
    parser = advance_to_symbol(parser, "{")
    parser = consume_symbol(parser, "{")
    members = []
    while True:
        parser = skip_trivia(parser)
        token = parser_peek_raw(parser)
        if token.kind.variant == "Symbol" and token.kind.value == "}":
            parser = parser_advance_raw(parser)
            break
        if token.kind.variant == "EndOfFile":
            break
        member_start = parser
        decorator_result = parse_decorators(parser)
        parser = decorator_result.parser
        member_decorators = decorator_result.decorators
        parser = skip_trivia(parser)
        member_result = parse_interface_member(parser, member_decorators)
        if member_result.success:
            parser = member_result.parser
            if member_result.signature != None:
                members = append_signature(members, member_result.signature)
            continue
        parser = skip_struct_member(member_start)
    statement = runtime.enum_instantiate(Statement, 'InterfaceDeclaration', [runtime.enum_field('name', name), runtime.enum_field(
        'name_span', name_span), runtime.enum_field('type_parameters', type_parameters), runtime.enum_field('members', members), runtime.enum_field('decorators', decorators)])
    return StatementParseResult(parser=parser, statement=statement)


def parse_enum(parser, decorators):
    original = parser
    parser = skip_trivia(parser)
    parser = consume_keyword(parser, "enum")
    parser = skip_trivia(parser)
    name_token = parser_peek_raw(parser)
    if name_token.kind.variant != "Identifier":
        return parse_unknown(original)
    name = identifier_text(name_token)
    name_span = source_span_from_tokens([name_token])
    parser = parser_advance_raw(parser)
    type_param_result = parse_type_parameter_clause(parser)
    parser = type_param_result.parser
    type_parameters = type_param_result.parameters
    parser = skip_trivia(parser)
    parser = advance_to_symbol(parser, "{")
    parser = consume_symbol(parser, "{")
    variants = []
    while True:
        parser = skip_trivia(parser)
        token = parser_peek_raw(parser)
        if token.kind.variant == "Symbol" and token.kind.value == "}":
            parser = parser_advance_raw(parser)
            break
        if token.kind.variant == "EndOfFile":
            break
        variant_result = parse_enum_variant(parser)
        if variant_result.success:
            parser = variant_result.parser
            if variant_result.variant != None:
                variants = append_enum_variant(
                    variants, variant_result.variant)
            parser = skip_trailing_comma(parser)
            continue
        parser = skip_struct_member(parser)
    statement = runtime.enum_instantiate(Statement, 'EnumDeclaration', [runtime.enum_field('name', name), runtime.enum_field('name_span', name_span), runtime.enum_field(
        'type_parameters', type_parameters), runtime.enum_field('variants', variants), runtime.enum_field('decorators', decorators)])
    return StatementParseResult(parser=parser, statement=statement)


def parse_interface_member(parser, decorators):
    original = parser
    current = skip_trivia(parser)
    is_async = False
    peek = parser_peek_raw(current)
    if identifier_matches(peek, "async"):
        lookahead = skip_trivia(parser_advance_raw(current))
        if identifier_matches(parser_peek_raw(lookahead), "fn"):
            current = consume_keyword(current, "async")
            is_async = True
    current = skip_trivia(current)
    if not identifier_matches(parser_peek_raw(current), "fn"):
        return InterfaceMemberParseResult(parser=original, signature=None, success=False)
    current = consume_keyword(current, "fn")
    current = skip_trivia(current)
    name_token = parser_peek_raw(current)
    if name_token.kind.variant != "Identifier":
        return InterfaceMemberParseResult(parser=original, signature=None, success=False)
    name = identifier_text(name_token)
    name_span = source_span_from_tokens([name_token])
    current = parser_advance_raw(current)
    type_param_result = parse_type_parameter_clause(current)
    current = type_param_result.parser
    type_parameters = type_param_result.parameters
    current = skip_trivia(current)
    current = consume_symbol(current, "(")
    parameter_result = parse_parameter_list(current)
    current = parameter_result.parser
    parameters = parameter_result.parameters
    current = skip_trivia(current)
    return_type = None
    separator = parser_peek_raw(current)
    if separator.kind.variant == "Symbol" and separator.kind.value == ":" or separator.kind.value == "->":
        current = parser_advance_raw(current)
        capture = collect_until(skip_trivia(current), ["!", ";", "{"])
        current = capture.parser
        text = trim_text(tokens_to_text(capture.tokens))
        if len(text) > 0:
            return_type = TypeAnnotation(text=text)
    effect_result = parse_effect_list(current)
    current = effect_result.parser
    parsed_effects = effect_result.effects
    decorator_info = evaluate_decorators(decorators)
    inferred_effects = infer_effects(parsed_effects, decorator_info)
    current = skip_trivia(current)
    if current.index < len(current.tokens):
        terminator = parser_peek_raw(current)
        if terminator.kind.variant == "Symbol" and terminator.kind.value == ";":
            current = parser_advance_raw(current)
    signature = FunctionSignature(name=name, is_async=is_async, parameters=parameters, return_type=return_type,
                                  effects=inferred_effects, type_parameters=type_parameters, name_span=name_span)
    return InterfaceMemberParseResult(parser=current, signature=signature, success=True)


def parse_enum_variant(parser):
    original = parser
    current = skip_trivia(parser)
    name_token = parser_peek_raw(current)
    if name_token.kind.variant != "Identifier":
        return EnumVariantParseResult(parser=original, variant=None, success=False)
    name = identifier_text(name_token)
    name_span = source_span_from_tokens([name_token])
    current = parser_advance_raw(current)
    fields = []
    current = skip_trivia(current)
    next = parser_peek_raw(current)
    if next.kind.variant == "Symbol" and next.kind.value == "{":
        current = parser_advance_raw(current)
        while True:
            current = skip_trivia(current)
            token = parser_peek_raw(current)
            if token.kind.variant == "Symbol" and token.kind.value == "}":
                current = parser_advance_raw(current)
                break
            if token.kind.variant == "EndOfFile":
                break
            field_result = parse_enum_variant_field(current)
            if field_result.success:
                current = field_result.parser
                if field_result.field != None:
                    fields = append_field(fields, field_result.field)
                continue
            current = skip_enum_variant_entry(current)
    current = skip_trivia(current)
    terminator = parser_peek_raw(current)
    if terminator.kind.variant == "Symbol" and terminator.kind.value == ";":
        current = parser_advance_raw(current)
        current = skip_trivia(current)
        terminator = parser_peek_raw(current)
    variant = EnumVariant(name=name, fields=fields, name_span=name_span)
    return EnumVariantParseResult(parser=current, variant=variant, success=True)


def parse_enum_variant_field(parser):
    current = skip_trivia(parser)
    is_mutable = False
    token = parser_peek_raw(current)
    token_to_use = token
    if identifier_matches(token_to_use, "mut"):
        current = parser_advance_raw(current)
        is_mutable = True
        current = skip_trivia(current)
        token_to_use = parser_peek_raw(current)
    if token_to_use.kind.variant != "Identifier":
        return StructFieldParseResult(parser=parser, field=None, success=False)
    name = identifier_text(token_to_use)
    name_span = source_span_from_tokens([token_to_use])
    current = parser_advance_raw(current)
    current = skip_trivia(current)
    separator = parser_peek_raw(current)
    is_type_sep = separator.kind.variant == "Symbol" and (
        separator.kind.value == ":" or separator.kind.value == "->")
    if not is_type_sep:
        return StructFieldParseResult(parser=parser, field=None, success=False)
    current = parser_advance_raw(current)
    capture = collect_until(skip_trivia(current), [",", "}", ";"])
    current = capture.parser
    type_text = trim_text(tokens_to_text(capture.tokens))
    while True:
        if len(type_text) == 0:
            break
        last = type_text[len(type_text) - 1]
        if last != ";":
            break
        trimmed = substring(type_text, 0, len(type_text) - 1)
        type_text = trim_text(trimmed)
    if len(type_text) == 0:
        return StructFieldParseResult(parser=parser, field=None, success=False)
    current = skip_trivia(current)
    terminator = parser_peek_raw(current)
    if terminator.kind.variant == "Symbol":
        if terminator.kind.value == ",":
            current = parser_advance_raw(current)
        else:
            if terminator.kind.value == ";":
                current = parser_advance_raw(current)
                current = skip_trivia(current)
                maybe_comma = parser_peek_raw(current)
                if maybe_comma.kind.variant == "Symbol" and maybe_comma.kind.value == ",":
                    current = parser_advance_raw(current)
    field = FieldDeclaration(name=name, type_annotation=TypeAnnotation(
        text=type_text), mutable=is_mutable, name_span=name_span)
    return StructFieldParseResult(parser=current, field=field, success=True)


def skip_trailing_comma(parser):
    current = skip_trivia(parser)
    token = parser_peek_raw(current)
    if token.kind.variant == "Symbol" and token.kind.value == ",":
        current = parser_advance_raw(current)
    return current


def parse_model(parser, decorators):
    original = parser
    parser = skip_trivia(parser)
    parser = consume_keyword(parser, "model")
    parser = skip_trivia(parser)
    name_token = parser_peek_raw(parser)
    name = identifier_text(name_token)
    name_span = source_span_from_tokens([name_token])
    parser = parser_advance_raw(parser)
    parser = skip_trivia(parser)
    parser = advance_to_symbol(parser, ":")
    parser = consume_symbol(parser, ":")
    type_capture = collect_until(skip_trivia(parser), ["!", "{"])
    parser = type_capture.parser
    type_text = trim_text(tokens_to_text(type_capture.tokens))
    if len(type_text) == 0:
        return parse_unknown(original)
    model_type = TypeAnnotation(text=type_text)
    effect_result = parse_effect_list(parser)
    parser = effect_result.parser
    effects = effect_result.effects
    parser = skip_trivia(parser)
    parser = advance_to_symbol(parser, "{")
    parser = consume_symbol(parser, "{")
    properties = []
    while True:
        parser = skip_trivia(parser)
        token = parser_peek_raw(parser)
        if token.kind.variant == "Symbol" and token.kind.value == "}":
            parser = parser_advance_raw(parser)
            break
        if token.kind.variant == "EndOfFile":
            break
        entry_start = parser
        property_result = parse_model_property(parser)
        if property_result.success and property_result.property != None:
            parser = property_result.parser
            properties = append_model_property(
                properties, property_result.property)
            continue
        parser = skip_struct_member(entry_start)
        parser = skip_trivia(parser)
        maybe_close = parser_peek_raw(parser)
        if maybe_close.kind.variant == "Symbol" and maybe_close.kind.value == "}":
            parser = parser_advance_raw(parser)
            break
        if maybe_close.kind.variant == "EndOfFile":
            break
    statement = runtime.enum_instantiate(Statement, 'ModelDeclaration', [runtime.enum_field('name', name), runtime.enum_field('name_span', name_span), runtime.enum_field(
        'model_type', model_type), runtime.enum_field('properties', properties), runtime.enum_field('effects', effects), runtime.enum_field('decorators', decorators)])
    return StatementParseResult(parser=parser, statement=statement)


def parse_pipeline(parser, decorators):
    parser = skip_trivia(parser)
    parser = consume_keyword(parser, "pipeline")
    parser = skip_trivia(parser)
    name_token = parser_peek_raw(parser)
    name = identifier_text(name_token)
    name_span = source_span_from_tokens([name_token])
    parser = parser_advance_raw(parser)
    type_param_result = parse_type_parameter_clause(parser)
    parser = type_param_result.parser
    type_parameters = type_param_result.parameters
    parser = skip_trivia(parser)
    parser = consume_symbol(parser, "(")
    parameter_result = parse_parameter_list(parser)
    parser = parameter_result.parser
    parameters = parameter_result.parameters
    parser = skip_trivia(parser)
    return_type = None
    separator = parser_peek_raw(parser)
    if separator.kind.variant == "Symbol" and separator.kind.value == ":" or separator.kind.value == "->":
        parser = parser_advance_raw(parser)
        capture = collect_until(skip_trivia(parser), ["!", "{"])
        parser = capture.parser
        text = trim_text(tokens_to_text(capture.tokens))
        if len(text) > 0:
            return_type = TypeAnnotation(text=text)
    effect_result = parse_effect_list(parser)
    parser = effect_result.parser
    parsed_effects = effect_result.effects
    decorator_info = evaluate_decorators(decorators)
    inferred_effects = infer_effects(parsed_effects, decorator_info)
    block_result = parse_block(parser)
    parser = block_result.parser
    body = block_result.block
    signature = FunctionSignature(name=name, is_async=False, parameters=parameters,
                                  return_type=return_type, effects=inferred_effects, type_parameters=[], name_span=name_span)
    statement = runtime.enum_instantiate(Statement, 'PipelineDeclaration', [runtime.enum_field(
        'signature', signature), runtime.enum_field('body', body), runtime.enum_field('decorators', decorators)])
    return StatementParseResult(parser=parser, statement=statement)


def parse_tool(parser, decorators):
    parser = skip_trivia(parser)
    parser = consume_keyword(parser, "tool")
    parser = skip_trivia(parser)
    name_token = parser_peek_raw(parser)
    name = identifier_text(name_token)
    name_span = source_span_from_tokens([name_token])
    parser = parser_advance_raw(parser)
    parser = skip_trivia(parser)
    parser = consume_symbol(parser, "(")
    parameter_result = parse_parameter_list(parser)
    parser = parameter_result.parser
    parameters = parameter_result.parameters
    parser = skip_trivia(parser)
    return_type = None
    separator = parser_peek_raw(parser)
    if separator.kind.variant == "Symbol" and separator.kind.value == ":" or separator.kind.value == "->":
        parser = parser_advance_raw(parser)
        capture = collect_until(skip_trivia(parser), ["!", "{"])
        parser = capture.parser
        text = trim_text(tokens_to_text(capture.tokens))
        if len(text) > 0:
            return_type = TypeAnnotation(text=text)
    effect_result = parse_effect_list(parser)
    parser = effect_result.parser
    parsed_effects = effect_result.effects
    decorator_info = evaluate_decorators(decorators)
    inferred_effects = infer_effects(parsed_effects, decorator_info)
    block_result = parse_block(parser)
    parser = block_result.parser
    body = block_result.block
    signature = FunctionSignature(name=name, is_async=False, parameters=parameters,
                                  return_type=return_type, effects=inferred_effects, type_parameters=[])
    statement = runtime.enum_instantiate(Statement, 'ToolDeclaration', [runtime.enum_field(
        'signature', signature), runtime.enum_field('body', body), runtime.enum_field('decorators', decorators)])
    return StatementParseResult(parser=parser, statement=statement)


def parse_test(parser, decorators):
    original = parser
    parser = skip_trivia(parser)
    parser = consume_keyword(parser, "test")
    name_capture = collect_until(skip_trivia(parser), ["!", "{"])
    parser = name_capture.parser
    name_text = trim_text(tokens_to_text(name_capture.tokens))
    if len(name_text) == 0:
        return parse_unknown(original)
    name_span = source_span_from_tokens(name_capture.tokens)
    name = normalize_test_name(name_text)
    effect_result = parse_effect_list(parser)
    parser = effect_result.parser
    parsed_effects = effect_result.effects
    decorator_info = evaluate_decorators(decorators)
    inferred_effects = infer_effects(parsed_effects, decorator_info)
    block_result = parse_block(parser)
    parser = block_result.parser
    body = block_result.block
    statement = runtime.enum_instantiate(Statement, 'TestDeclaration', [runtime.enum_field('name', name), runtime.enum_field(
        'name_span', name_span), runtime.enum_field('body', body), runtime.enum_field('effects', inferred_effects), runtime.enum_field('decorators', decorators)])
    return StatementParseResult(parser=parser, statement=statement)


def parse_function(parser, starts_with_async, decorators):
    parser = skip_trivia(parser)
    is_async = False
    if starts_with_async:
        parser = consume_keyword(parser, "async")
        is_async = True
    else:
        look = parser_peek_raw(parser)
        if identifier_matches(look, "async"):
            lookahead = skip_trivia(parser_advance_raw(parser))
            next = parser_peek_raw(lookahead)
            if identifier_matches(next, "fn"):
                parser = consume_keyword(parser, "async")
                parser = skip_trivia(parser)
                is_async = True
    parser = skip_trivia(parser)
    parser = consume_keyword(parser, "fn")
    parser = skip_trivia(parser)
    name_token = parser_peek_raw(parser)
    name = identifier_text(name_token)
    name_span = source_span_from_tokens([name_token])
    parser = parser_advance_raw(parser)
    type_param_result = parse_type_parameter_clause(parser)
    parser = type_param_result.parser
    type_parameters = type_param_result.parameters
    parser = skip_trivia(parser)
    parser = consume_symbol(parser, "(")
    parameter_result = parse_parameter_list(parser)
    parser = parameter_result.parser
    parameters = parameter_result.parameters
    parser = skip_trivia(parser)
    return_type = None
    separator = parser_peek_raw(parser)
    if separator.kind.variant == "Symbol" and separator.kind.value == ":" or separator.kind.value == "->":
        parser = parser_advance_raw(parser)
        capture = collect_until(skip_trivia(parser), ["!", "{"])
        parser = capture.parser
        text = trim_text(tokens_to_text(capture.tokens))
        if len(text) > 0:
            return_type = TypeAnnotation(text=text)
    effect_result = parse_effect_list(parser)
    parser = effect_result.parser
    parsed_effects = effect_result.effects
    decorator_info = evaluate_decorators(decorators)
    inferred_effects = infer_effects(parsed_effects, decorator_info)
    block_result = parse_block(parser)
    parser = block_result.parser
    body = block_result.block
    signature = FunctionSignature(name=name, is_async=is_async, parameters=parameters, return_type=return_type,
                                  effects=inferred_effects, type_parameters=type_parameters, name_span=name_span)
    statement = runtime.enum_instantiate(Statement, 'FunctionDeclaration', [runtime.enum_field(
        'signature', signature), runtime.enum_field('body', body), runtime.enum_field('decorators', decorators)])
    return StatementParseResult(parser=parser, statement=statement)


def parse_parameter_list(parser):
    parser = skip_trivia(parser)
    parameters = []
    token = parser_peek_raw(parser)
    if token.kind.variant == "Symbol" and token.kind.value == ")":
        parser = parser_advance_raw(parser)
        return ParameterListParseResult(parser=parser, parameters=parameters)
    while True:
        param_result = parse_single_parameter(parser)
        parser = param_result.parser
        parameters = append_parameter(parameters, param_result.parameter)
        parser = skip_trivia(parser)
        separator = parser_peek_raw(parser)
        if separator.kind.variant == "Symbol" and separator.kind.value == ",":
            parser = parser_advance_raw(parser)
            parser = skip_trivia(parser)
            continue
        if separator.kind.variant == "Symbol" and separator.kind.value == ")":
            parser = parser_advance_raw(parser)
            break
        if separator.kind.variant == "EndOfFile":
            break
    return ParameterListParseResult(parser=parser, parameters=parameters)


def parse_struct_field(parser):
    current = skip_trivia(parser)
    is_mutable = False
    token = parser_peek_raw(current)
    token_to_use = token
    if identifier_matches(token_to_use, "mut"):
        current = parser_advance_raw(current)
        is_mutable = True
        current = skip_trivia(current)
        token_to_use = parser_peek_raw(current)
    if token_to_use.kind.variant != "Identifier":
        return StructFieldParseResult(parser=parser, field=None, success=False)
    name = identifier_text(token_to_use)
    name_span = source_span_from_tokens([token_to_use])
    current = parser_advance_raw(current)
    current = skip_trivia(current)
    separator = parser_peek_raw(current)
    is_type_sep = separator.kind.variant == "Symbol" and (
        separator.kind.value == ":" or separator.kind.value == "->")
    if not is_type_sep:
        return StructFieldParseResult(parser=parser, field=None, success=False)
    current = parser_advance_raw(current)
    capture = collect_until(skip_trivia(current), [";"])
    current = capture.parser
    type_text = trim_text(tokens_to_text(capture.tokens))
    if len(type_text) == 0:
        return StructFieldParseResult(parser=parser, field=None, success=False)
    current = skip_trivia(current)
    terminator = parser_peek_raw(current)
    if terminator.kind.variant != "Symbol" or terminator.kind.value != ";":
        return StructFieldParseResult(parser=parser, field=None, success=False)
    current = parser_advance_raw(current)
    field = FieldDeclaration(name=name, type_annotation=TypeAnnotation(
        text=type_text), mutable=is_mutable, name_span=name_span)
    return StructFieldParseResult(parser=current, field=field, success=True)


def parse_model_property(parser):
    current = skip_trivia(parser)
    name_token = parser_peek_raw(current)
    if name_token.kind.variant != "Identifier":
        return ModelPropertyParseResult(parser=parser, property=None, success=False)
    name = identifier_text(name_token)
    current = parser_advance_raw(current)
    current = skip_trivia(current)
    equals = parser_peek_raw(current)
    if equals.kind.variant != "Symbol" or equals.kind.value != "=":
        return ModelPropertyParseResult(parser=parser, property=None, success=False)
    current = parser_advance_raw(current)
    capture = collect_until(skip_trivia(current), [";"])
    current = capture.parser
    value_expression = expression_from_tokens(capture.tokens)
    current = skip_trivia(current)
    terminator = parser_peek_raw(current)
    if terminator.kind.variant != "Symbol" or terminator.kind.value != ";":
        return ModelPropertyParseResult(parser=parser, property=None, success=False)
    current = parser_advance_raw(current)
    property = ModelProperty(
        name=name, value=value_expression, span=source_span_from_tokens([name_token]))
    return ModelPropertyParseResult(parser=current, property=property, success=True)


def parse_struct_method(parser, decorators):
    current = skip_trivia(parser)
    is_async = False
    peek = parser_peek_raw(current)
    if identifier_matches(peek, "async"):
        lookahead = skip_trivia(parser_advance_raw(current))
        if identifier_matches(parser_peek_raw(lookahead), "fn"):
            current = consume_keyword(current, "async")
            is_async = True
    current = skip_trivia(current)
    if not identifier_matches(parser_peek_raw(current), "fn"):
        return MethodParseResult(parser=parser, method=None, success=False)
    current = consume_keyword(current, "fn")
    current = skip_trivia(current)
    name_token = parser_peek_raw(current)
    if name_token.kind.variant != "Identifier":
        return MethodParseResult(parser=parser, method=None, success=False)
    name = identifier_text(name_token)
    name_span = source_span_from_tokens([name_token])
    current = parser_advance_raw(current)
    type_param_result = parse_type_parameter_clause(current)
    current = type_param_result.parser
    type_parameters = type_param_result.parameters
    current = skip_trivia(current)
    current = consume_symbol(current, "(")
    parameter_result = parse_parameter_list(current)
    current = parameter_result.parser
    parameters = parameter_result.parameters
    current = skip_trivia(current)
    return_type = None
    separator = parser_peek_raw(current)
    if separator.kind.variant == "Symbol" and separator.kind.value == ":" or separator.kind.value == "->":
        current = parser_advance_raw(current)
        capture = collect_until(skip_trivia(current), ["!", "{"])
        current = capture.parser
        text = trim_text(tokens_to_text(capture.tokens))
        if len(text) > 0:
            return_type = TypeAnnotation(text=text)
    effect_result = parse_effect_list(current)
    current = effect_result.parser
    parsed_effects = effect_result.effects
    decorator_info = evaluate_decorators(decorators)
    inferred_effects = infer_effects(parsed_effects, decorator_info)
    block_result = parse_block(current)
    current = block_result.parser
    body = block_result.block
    signature = FunctionSignature(name=name, is_async=is_async, parameters=parameters, return_type=return_type,
                                  effects=inferred_effects, type_parameters=type_parameters, name_span=name_span)
    method = MethodDeclaration(
        signature=signature, body=body, decorators=decorators)
    return MethodParseResult(parser=current, method=method, success=True)


def parse_decorators(parser):
    current = parser
    decorators = []
    while True:
        current = skip_trivia(current)
        token = parser_peek_raw(current)
        if token.kind.variant != "Symbol" or token.kind.value != "@":
            break
        decorator_start = current
        current = parser_advance_raw(current)
        current = skip_trivia(current)
        name_token = parser_peek_raw(current)
        if name_token.kind.variant != "Identifier":
            current = decorator_start
            break
        name = identifier_text(name_token)
        current = parser_advance_raw(current)
        current = skip_trivia(current)
        decorator_arguments = []
        after = parser_peek_raw(current)
        if after.kind.variant == "Symbol" and after.kind.value == "(":
            paren_result = collect_parenthesized(current)
            if paren_result.success:
                segment_tokens = []
                angle = 0
                paren = 0
                brace = 0
                bracket = 0
                index = 0
                while True:
                    if index >= len(paren_result.tokens):
                        break
                    tok = paren_result.tokens[index]
                    if tok.kind.variant == "Symbol":
                        sym = tok.kind.value
                        if sym == "<":
                            angle += 1
                        else:
                            if sym == ">" and angle > 0:
                                angle -= 1
                            else:
                                if sym == "(":
                                    paren += 1
                                else:
                                    if sym == ")" and paren > 0:
                                        paren -= 1
                                    else:
                                        if sym == "{":
                                            brace += 1
                                        else:
                                            if sym == "}" and brace > 0:
                                                brace -= 1
                                            else:
                                                if sym == "[":
                                                    bracket += 1
                                                else:
                                                    if sym == "]" and bracket > 0:
                                                        bracket -= 1
                        at_top_level = angle == 0 and paren == 0 and brace == 0 and bracket == 0
                        if sym == "," and at_top_level:
                            trimmed_tokens = trim_token_edges(segment_tokens)
                            argument = parse_decorator_argument(trimmed_tokens)
                            if argument != None:
                                decorator_arguments = append_decorator_argument(
                                    decorator_arguments, argument)
                            segment_tokens = []
                            index += 1
                            continue
                    segment_tokens = append_token(segment_tokens, tok)
                    index += 1
                final_tokens = trim_token_edges(segment_tokens)
                trailing_argument = parse_decorator_argument(final_tokens)
                if trailing_argument != None:
                    decorator_arguments = append_decorator_argument(
                        decorator_arguments, trailing_argument)
                current = paren_result.parser
            else:
                current = decorator_start
                break
        decorators = append_decorator(decorators, Decorator(
            name=name, arguments=decorator_arguments))
    return DecoratorParseResult(parser=current, decorators=decorators)


def parse_type_parameter_clause(parser):
    current = skip_trivia(parser)
    token = parser_peek_raw(current)
    if token.kind.variant != "Symbol" or token.kind.value != "<":
        return TypeParameterParseResult(parser=parser, parameters=[])
    current = parser_advance_raw(current)
    collected = []
    depth = 1
    while True:
        tok = parser_peek_raw(current)
        if tok.kind.variant == "EndOfFile":
            break
        if tok.kind.variant == "Symbol":
            sym = tok.kind.value
            if sym == "<":
                depth += 1
            else:
                if sym == ">":
                    depth -= 1
                    if depth == 0:
                        current = parser_advance_raw(current)
                        break
        collected = append_token(collected, tok)
        current = parser_advance_raw(current)
    slices = split_token_slices_by_comma(collected)
    parameters = []
    index = 0
    while True:
        if index >= len(slices):
            break
        slice_tokens = trim_token_edges(slices[index])
        if len(slice_tokens) > 0:
            colon_index = find_top_level_symbol(slice_tokens, ":")
            name_tokens = slice_tokens
            bound_tokens = []
            if colon_index != -1:
                name_tokens = token_slice(slice_tokens, 0, colon_index)
                bound_tokens = token_slice(
                    slice_tokens, colon_index + 1, len(slice_tokens))
            name_text = trim_text(tokens_to_text(name_tokens))
            if len(name_text) > 0:
                bound = None
                bound_text = trim_text(tokens_to_text(bound_tokens))
                if len(bound_tokens) > 0 and len(bound_text) > 0:
                    bound = TypeAnnotation(text=bound_text)
                name_span = source_span_from_tokens(name_tokens)
                parameters = append_type_parameter(parameters, TypeParameter(
                    name=name_text, bound=bound, span=name_span), )
        index += 1
    return TypeParameterParseResult(parser=current, parameters=parameters)


def parse_implements_clause(parser):
    current = skip_trivia(parser)
    if not identifier_matches(parser_peek_raw(current), "implements"):
        return ImplementsParseResult(parser=parser, types=[], found=False)
    current = consume_keyword(current, "implements")
    current = skip_trivia(current)
    capture = collect_until(current, ["{"])
    current = capture.parser
    implements_types = []
    entries = split_tokens_by_comma(capture.tokens)
    index = 0
    while True:
        if index >= len(entries):
            break
        text = trim_text(entries[index])
        if len(text) > 0:
            implements_types = append_type_annotation(
                implements_types, TypeAnnotation(text=text))
        index += 1
    return ImplementsParseResult(parser=current, types=implements_types, found=True)


def parse_single_parameter(parser):
    parser = skip_trivia(parser)
    tokens_ref = parser.tokens
    start_index = parser.index
    is_mutable = False
    token = parser_peek_raw(parser)
    if identifier_matches(token, "mut"):
        parser = parser_advance_raw(parser)
        is_mutable = True
    parser = skip_trivia(parser)
    name_token = parser_peek_raw(parser)
    name = identifier_text(name_token)
    parser = parser_advance_raw(parser)
    type_annotation = None
    parser = skip_trivia(parser)
    separator = parser_peek_raw(parser)
    if separator.kind.variant == "Symbol" and separator.kind.value == ":" or separator.kind.value == "->":
        parser = parser_advance_raw(parser)
        capture = collect_until(skip_trivia(parser), ["=", ",", ")"])
        parser = capture.parser
        text = trim_text(tokens_to_text(capture.tokens))
        if len(text) > 0:
            type_annotation = TypeAnnotation(text=text)
    default_value = None
    parser = skip_trivia(parser)
    assign = parser_peek_raw(parser)
    if assign.kind.variant == "Symbol" and assign.kind.value == "=":
        parser = parser_advance_raw(parser)
        capture = collect_until(skip_trivia(parser), [",", ")"])
        parser = capture.parser
        default_value = expression_from_tokens(capture.tokens)
    end_index = parser.index
    parameter_tokens = token_slice(tokens_ref, start_index, end_index)
    span = source_span_from_tokens(parameter_tokens)
    parameter = Parameter(name=name, type_annotation=type_annotation,
                          default_value=default_value, mutable=is_mutable, span=span)
    return ParameterParseResult(parser=parser, parameter=parameter)


def parse_effect_list(parser):
    parser = skip_trivia(parser)
    token = parser_peek_raw(parser)
    if token.kind.variant != "Symbol" or token.kind.value != "!":
        return EffectParseResult(parser=parser, effects=[])
    parser = parser_advance_raw(parser)
    parser = skip_trivia(parser)
    parser = consume_symbol(parser, "[")
    effects = []
    parser = skip_trivia(parser)
    while True:
        current = parser_peek_raw(parser)
        if current.kind.variant == "Symbol" and current.kind.value == "]":
            parser = parser_advance_raw(parser)
            break
        if current.kind.variant == "Identifier":
            effect = identifier_text(current)
            effects = append_string(effects, effect)
            parser = parser_advance_raw(parser)
            parser = skip_trivia(parser)
            separator = parser_peek_raw(parser)
            if separator.kind.variant == "Symbol" and separator.kind.value == ",":
                parser = parser_advance_raw(parser)
                parser = skip_trivia(parser)
                continue
            continue
        parser = parser_advance_raw(parser)
        parser = skip_trivia(parser)
    return EffectParseResult(parser=parser, effects=effects)


def parse_block(parser):
    parser = skip_trivia(parser)
    token = parser_peek_raw(parser)
    if token.kind.variant != "Symbol" or token.kind.value != "{":
        return BlockParseResult(parser=parser, block=Block(tokens=[], text="", statements=[]))
    start_index = parser.index
    current = parser_advance_raw(parser)
    block_end_index = start_index
    statements = []
    while True:
        current = skip_trivia(current)
        tok = parser_peek_raw(current)
        if tok.kind.variant == "Symbol" and tok.kind.value == "}":
            block_end_index = current.index + 1
            current = parser_advance_raw(current)
            break
        if tok.kind.variant == "EndOfFile":
            break
        block_result = parse_block_statement(current)
        if block_result.success:
            current = block_result.parser
            if block_result.statement != None:
                statements = append_statement(
                    statements, block_result.statement)
            continue
        before_index = current.index
        unknown_result = parse_unknown(current)
        current = unknown_result.parser
        if unknown_result.statement.variant == "Unknown":
            statements = append_statement(statements, unknown_result.statement)
        if current.index <= before_index:
            current = parser_advance_raw(current)
    end_index = current.index
    if block_end_index > start_index:
        end_index = block_end_index
    block_tokens = token_slice(parser.tokens, start_index, end_index)
    block_tokens = trim_block_tokens(block_tokens)
    text = tokens_to_text(block_tokens)
    block = Block(tokens=block_tokens, text=text, statements=statements)
    return BlockParseResult(parser=skip_trivia(current), block=block)


def parse_block_statement(parser):
    original = parser
    decorator_result = parse_decorators(parser)
    current = decorator_result.parser
    decorators = decorator_result.decorators
    after_decorators = skip_trivia(current)
    token = parser_peek_raw(after_decorators)
    if identifier_matches(token, "for"):
        return parse_for_statement(after_decorators, decorators)
    if identifier_matches(token, "loop"):
        return parse_loop_statement(after_decorators, decorators)
    if identifier_matches(token, "break"):
        if len(decorators) > 0:
            return BlockStatementParseResult(parser=original, statement=None, success=False)
        return parse_break_statement(after_decorators)
    if identifier_matches(token, "continue"):
        if len(decorators) > 0:
            return BlockStatementParseResult(parser=original, statement=None, success=False)
        return parse_continue_statement(after_decorators)
    if identifier_matches(token, "if"):
        return parse_if_statement(after_decorators, decorators)
    if identifier_matches(token, "match"):
        return parse_match_statement(after_decorators, decorators)
    if identifier_matches(token, "prompt"):
        return parse_prompt_statement(after_decorators, decorators)
    if identifier_matches(token, "with"):
        return parse_with_statement(after_decorators, decorators)
    if identifier_matches(token, "return"):
        if len(decorators) > 0:
            return BlockStatementParseResult(parser=original, statement=None, success=False)
        return parse_return_statement(after_decorators)
    expression_result = parse_expression_statement(
        after_decorators, decorators)
    if expression_result.success:
        return expression_result
    return BlockStatementParseResult(parser=original, statement=None, success=False)


def parse_for_statement(parser, decorators):
    original = parser
    current = skip_trivia(parser)
    if not identifier_matches(parser_peek_raw(current), "for"):
        return BlockStatementParseResult(parser=original, statement=None, success=False)
    current = consume_keyword(current, "for")
    clause_capture = collect_until(skip_trivia(current), ["{"])
    current = clause_capture.parser
    clause_tokens = trim_token_edges(clause_capture.tokens)
    if len(clause_tokens) == 0:
        return BlockStatementParseResult(parser=original, statement=None, success=False)
    in_index = find_top_level_identifier(clause_tokens, "in")
    if in_index == -1:
        return BlockStatementParseResult(parser=original, statement=None, success=False)
    target_tokens = trim_token_edges(token_slice(clause_tokens, 0, in_index))
    iterable_tokens = trim_token_edges(token_slice(
        clause_tokens, in_index + 1, len(clause_tokens)))
    if len(target_tokens) == 0 or len(iterable_tokens) == 0:
        return BlockStatementParseResult(parser=original, statement=None, success=False)
    target_expression = expression_from_tokens(target_tokens)
    iterable_expression = expression_from_tokens(iterable_tokens)
    clause = ForClause(target=target_expression,
                       iterable=iterable_expression, tokens=clause_tokens)
    body_result = parse_block(current)
    if len(body_result.block.tokens) == 0:
        return BlockStatementParseResult(parser=original, statement=None, success=False)
    current = body_result.parser
    body = body_result.block
    current = skip_trivia(current)
    terminator = parser_peek_raw(current)
    if terminator.kind.variant == "Symbol" and terminator.kind.value == ";":
        current = parser_advance_raw(current)
    statement = runtime.enum_instantiate(Statement, 'ForStatement', [runtime.enum_field(
        'clause', clause), runtime.enum_field('body', body), runtime.enum_field('decorators', decorators)])
    return BlockStatementParseResult(parser=current, statement=statement, success=True)


def parse_loop_statement(parser, decorators):
    original = parser
    current = skip_trivia(parser)
    if not identifier_matches(parser_peek_raw(current), "loop"):
        return BlockStatementParseResult(parser=original, statement=None, success=False)
    current = consume_keyword(current, "loop")
    body_result = parse_block(current)
    if len(body_result.block.tokens) == 0:
        return BlockStatementParseResult(parser=original, statement=None, success=False)
    current = body_result.parser
    current = skip_trivia(current)
    terminator = parser_peek_raw(current)
    if terminator.kind.variant == "Symbol" and terminator.kind.value == ";":
        current = parser_advance_raw(current)
    statement = runtime.enum_instantiate(Statement, 'LoopStatement', [runtime.enum_field(
        'body', body_result.block), runtime.enum_field('decorators', decorators)])
    return BlockStatementParseResult(parser=current, statement=statement, success=True)


def parse_break_statement(parser):
    original = parser
    current = skip_trivia(parser)
    if not identifier_matches(parser_peek_raw(current), "break"):
        return BlockStatementParseResult(parser=original, statement=None, success=False)
    current = consume_keyword(current, "break")
    current = skip_trivia(current)
    terminator = parser_peek_raw(current)
    if terminator.kind.variant == "Symbol" and terminator.kind.value == ";":
        current = parser_advance_raw(current)
    return BlockStatementParseResult(parser=current, statement=Statement.BreakStatement(), success=True)


def parse_continue_statement(parser):
    original = parser
    current = skip_trivia(parser)
    if not identifier_matches(parser_peek_raw(current), "continue"):
        return BlockStatementParseResult(parser=original, statement=None, success=False)
    current = consume_keyword(current, "continue")
    current = skip_trivia(current)
    terminator = parser_peek_raw(current)
    if terminator.kind.variant == "Symbol" and terminator.kind.value == ";":
        current = parser_advance_raw(current)
    return BlockStatementParseResult(parser=current, statement=Statement.ContinueStatement(), success=True)


def parse_if_statement(parser, decorators):
    original = parser
    current = skip_trivia(parser)
    if not identifier_matches(parser_peek_raw(current), "if"):
        return BlockStatementParseResult(parser=original, statement=None, success=False)
    current = consume_keyword(current, "if")
    condition_capture = collect_until(skip_trivia(current), ["{"])
    current = condition_capture.parser
    condition_tokens = trim_token_edges(condition_capture.tokens)
    if len(condition_tokens) == 0:
        return BlockStatementParseResult(parser=original, statement=None, success=False)
    condition_expression = expression_from_tokens(condition_tokens)
    then_result = parse_block(current)
    if len(then_result.block.tokens) == 0:
        return BlockStatementParseResult(parser=original, statement=None, success=False)
    current = then_result.parser
    then_block = then_result.block
    current = skip_trivia(current)
    else_branch = None
    if identifier_matches(parser_peek_raw(current), "else"):
        current = consume_keyword(current, "else")
        current = skip_trivia(current)
        next_token = parser_peek_raw(current)
        if identifier_matches(next_token, "if"):
            nested_result = parse_if_statement(current, [])
            if not nested_result.success:
                return BlockStatementParseResult(parser=original, statement=None, success=False)
            if nested_result.statement == None:
                return BlockStatementParseResult(parser=original, statement=None, success=False)
            current = nested_result.parser
            else_branch = ElseBranch(
                statement=nested_result.statement, body=None)
        else:
            else_result = parse_block(current)
            if len(else_result.block.tokens) == 0:
                return BlockStatementParseResult(parser=original, statement=None, success=False)
            current = else_result.parser
            else_branch = ElseBranch(statement=None, body=else_result.block)
        current = skip_trivia(current)
        terminator = parser_peek_raw(current)
        if terminator.kind.variant == "Symbol" and terminator.kind.value == ";":
            current = parser_advance_raw(current)
    statement = runtime.enum_instantiate(Statement, 'IfStatement', [runtime.enum_field('condition', condition_expression), runtime.enum_field(
        'then_block', then_block), runtime.enum_field('else_branch', else_branch), runtime.enum_field('decorators', decorators)])
    return BlockStatementParseResult(parser=current, statement=statement, success=True)


def parse_match_statement(parser, decorators):
    original = parser
    current = skip_trivia(parser)
    if not identifier_matches(parser_peek_raw(current), "match"):
        return BlockStatementParseResult(parser=original, statement=None, success=False)
    current = consume_keyword(current, "match")
    value_capture = collect_until(skip_trivia(current), ["{"])
    current = value_capture.parser
    value_tokens = trim_token_edges(value_capture.tokens)
    if len(value_tokens) == 0:
        return BlockStatementParseResult(parser=original, statement=None, success=False)
    match_expression = expression_from_tokens(value_tokens)
    body_result = parse_match_cases(current)
    if not body_result.success:
        return BlockStatementParseResult(parser=original, statement=None, success=False)
    current = body_result.parser
    current = skip_trivia(current)
    if current.index < len(current.tokens):
        terminator = parser_peek_raw(current)
        if terminator.kind.variant == "Symbol" and terminator.kind.value == ";":
            current = parser_advance_raw(current)
    statement = runtime.enum_instantiate(Statement, 'MatchStatement', [runtime.enum_field(
        'expression', match_expression), runtime.enum_field('cases', body_result.cases), runtime.enum_field('decorators', decorators)])
    return BlockStatementParseResult(parser=current, statement=statement, success=True)


def parse_match_cases(parser):
    current = skip_trivia(parser)
    current = advance_to_symbol(current, "{")
    peek = parser_peek_raw(current)
    if peek.kind.variant != "Symbol" or peek.kind.value != "{":
        return MatchCasesParseResult(parser=parser, cases=[], success=False)
    current = parser_advance_raw(current)
    cases = []
    while True:
        current = skip_trivia(current)
        token = parser_peek_raw(current)
        if token.kind.variant == "Symbol" and token.kind.value == "}":
            current = parser_advance_raw(current)
            break
        if token.kind.variant == "EndOfFile":
            return MatchCasesParseResult(parser=parser, cases=[], success=False)
        case_result = parse_match_case(current)
        if not case_result.success or case_result.case == None:
            return MatchCasesParseResult(parser=parser, cases=[], success=False)
        current = case_result.parser
        cases = append_match_case(cases, case_result.case)
        current = skip_trivia(current)
        separator = parser_peek_raw(current)
        if separator.kind.variant == "Symbol" and separator.kind.value == ",":
            current = parser_advance_raw(current)
    return MatchCasesParseResult(parser=current, cases=cases, success=True)


def parse_match_case(parser):
    original = parser
    current = skip_trivia(parser)
    if identifier_matches(parser_peek_raw(current), "case"):
        current = consume_keyword(current, "case")
        current = skip_trivia(current)
    pattern_capture = collect_pattern_until_arrow(current)
    if not pattern_capture.success:
        return MatchCaseParseResult(parser=original, case=None, success=False)
    current = pattern_capture.parser
    split_tokens = split_match_case_tokens(pattern_capture.tokens)
    if len(split_tokens.pattern_tokens) == 0:
        return MatchCaseParseResult(parser=original, case=None, success=False)
    pattern_expression = expression_from_tokens(split_tokens.pattern_tokens)
    guard_expression = None
    if split_tokens.has_guard:
        if len(split_tokens.guard_tokens) == 0:
            return MatchCaseParseResult(parser=original, case=None, success=False)
        guard_expression = expression_from_tokens(split_tokens.guard_tokens)
    current = skip_trivia(current)
    next = parser_peek_raw(current)
    body = None
    if next.kind.variant == "Symbol" and next.kind.value == "{":
        body_result = parse_block(current)
        if len(body_result.block.tokens) == 0:
            return MatchCaseParseResult(parser=original, case=None, success=False)
        current = body_result.parser
        body = body_result.block
    else:
        if identifier_matches(next, "return"):
            block_tokens = []
            block_tokens = append_token(block_tokens, next)
            current = parser_advance_raw(current)
            capture = collect_until(current, [";", "}"])
            index = 0
            while True:
                if index >= len(capture.tokens):
                    break
                block_tokens = append_token(
                    block_tokens, capture.tokens[index])
                index += 1
            trimmed_expression_tokens = trim_token_edges(capture.tokens)
            return_expression = None
            if len(trimmed_expression_tokens) > 0:
                return_expression = expression_from_tokens(
                    trimmed_expression_tokens)
            current = skip_trivia(capture.parser)
            terminator = parser_peek_raw(current)
            if terminator.kind.variant == "Symbol" and terminator.kind.value == ";":
                block_tokens = append_token(block_tokens, terminator)
                current = parser_advance_raw(current)
            block_tokens = trim_token_edges(block_tokens)
            statement_span = source_span_from_tokens(block_tokens)
            statements = []
            statements = append_statement(statements, runtime.enum_instantiate(Statement, 'ReturnStatement', [
                                          runtime.enum_field('expression', return_expression), runtime.enum_field('span', statement_span)]))
            text = trim_text(tokens_to_text(block_tokens))
            body = Block(tokens=block_tokens, text=text, statements=statements)
        else:
            capture = collect_until(current, [";", "}"])
            trimmed_expression_tokens = trim_token_edges(capture.tokens)
            if len(trimmed_expression_tokens) == 0:
                return MatchCaseParseResult(parser=original, case=None, success=False)
            expression = expression_from_tokens(trimmed_expression_tokens)
            block_tokens = []
            index = 0
            while True:
                if index >= len(capture.tokens):
                    break
                block_tokens = append_token(
                    block_tokens, capture.tokens[index])
                index += 1
            current = skip_trivia(capture.parser)
            terminator = parser_peek_raw(current)
            if terminator.kind.variant == "Symbol" and terminator.kind.value == ";":
                block_tokens = append_token(block_tokens, terminator)
                current = parser_advance_raw(current)
            block_tokens = trim_token_edges(block_tokens)
            statement_span = source_span_from_tokens(block_tokens)
            statements = []
            statements = append_statement(statements, runtime.enum_instantiate(Statement, 'ExpressionStatement', [
                                          runtime.enum_field('expression', expression), runtime.enum_field('span', statement_span)]))
            text = trim_text(tokens_to_text(block_tokens))
            body = Block(tokens=block_tokens, text=text, statements=statements)
    if body == None:
        return MatchCaseParseResult(parser=original, case=None, success=False)
    case = MatchCase(pattern=pattern_expression,
                     guard=guard_expression, body=body)
    return MatchCaseParseResult(parser=current, case=case, success=True)


def parse_prompt_statement(parser, decorators):
    original = parser
    current = skip_trivia(parser)
    prompt_token = parser_peek_raw(current)
    if not identifier_matches(prompt_token, "prompt"):
        return BlockStatementParseResult(parser=original, statement=None, success=False)
    current = consume_keyword(current, "prompt")
    current = skip_trivia(current)
    channel_token = parser_peek_raw(current)
    channel = ""
    if channel_token.kind.variant == "Identifier":
        channel = identifier_text(channel_token)
        current = parser_advance_raw(current)
    else:
        if channel_token.kind.variant == "StringLiteral":
            channel = string_literal_value(channel_token)
            current = parser_advance_raw(current)
        else:
            return BlockStatementParseResult(parser=original, statement=None, success=False)
    block_result = parse_block(current)
    if len(block_result.block.tokens) == 0:
        return BlockStatementParseResult(parser=original, statement=None, success=False)
    current = block_result.parser
    body = block_result.block
    current = skip_trivia(current)
    if parser_peek_raw(current).kind.variant == "Symbol" and parser_peek_raw(current).kind.value == ";":
        current = parser_advance_raw(current)
    statement = runtime.enum_instantiate(Statement, 'PromptStatement', [runtime.enum_field('channel', channel), runtime.enum_field(
        'keyword_token', prompt_token), runtime.enum_field('channel_token', channel_token), runtime.enum_field('body', body), runtime.enum_field('decorators', decorators)])
    return BlockStatementParseResult(parser=current, statement=statement, success=True)


def parse_with_statement(parser, decorators):
    original = parser
    current = skip_trivia(parser)
    if not identifier_matches(parser_peek_raw(current), "with"):
        return BlockStatementParseResult(parser=original, statement=None, success=False)
    current = consume_keyword(current, "with")
    clauses_capture = collect_until(skip_trivia(current), ["{"])
    current = clauses_capture.parser
    clause_slices = split_token_slices_by_comma(clauses_capture.tokens)
    clauses = []
    index = 0
    while True:
        if index >= len(clause_slices):
            break
        slice_tokens = trim_token_edges(clause_slices[index])
        if len(slice_tokens) > 0:
            expression = expression_from_tokens(slice_tokens)
            clauses = append_with_clause(
                clauses, WithClause(expression=expression))
        index += 1
    block_result = parse_block(current)
    if len(block_result.block.tokens) == 0:
        return BlockStatementParseResult(parser=original, statement=None, success=False)
    current = block_result.parser
    body = block_result.block
    current = skip_trivia(current)
    if parser_peek_raw(current).kind.variant == "Symbol" and parser_peek_raw(current).kind.value == ";":
        current = parser_advance_raw(current)
    statement = runtime.enum_instantiate(Statement, 'WithStatement', [runtime.enum_field(
        'clauses', clauses), runtime.enum_field('body', body), runtime.enum_field('decorators', decorators)])
    return BlockStatementParseResult(parser=current, statement=statement, success=True)


def parse_return_statement(parser):
    original = parser
    current = skip_trivia(parser)
    if not identifier_matches(parser_peek_raw(current), "return"):
        return BlockStatementParseResult(parser=original, statement=None, success=False)
    statement_tokens = []
    statement_tokens = append_token(statement_tokens, parser_peek_raw(current))
    current = consume_keyword(current, "return")
    capture = collect_until(skip_trivia(current), [";", "}"])
    current = capture.parser
    trimmed = trim_token_edges(capture.tokens)
    expression = None
    if len(trimmed) > 0:
        expression = expression_from_tokens(trimmed)
    index = 0
    while True:
        if index >= len(capture.tokens):
            break
        statement_tokens = append_token(
            statement_tokens, capture.tokens[index])
        index += 1
    current = skip_trivia(current)
    terminator = parser_peek_raw(current)
    if terminator.kind.variant == "Symbol" and terminator.kind.value == ";":
        statement_tokens = append_token(statement_tokens, terminator)
        current = parser_advance_raw(current)
    span = source_span_from_tokens(statement_tokens)
    statement = runtime.enum_instantiate(Statement, 'ReturnStatement', [
                                         runtime.enum_field('expression', expression), runtime.enum_field('span', span)])
    return BlockStatementParseResult(parser=current, statement=statement, success=True)


def parse_expression_statement(parser, decorators):
    if len(decorators) > 0:
        return BlockStatementParseResult(parser=parser, statement=None, success=False)
    current = skip_trivia(parser)
    start = parser_peek_raw(current)
    if start.kind.variant == "EndOfFile":
        return BlockStatementParseResult(parser=parser, statement=None, success=False)
    if start.kind.variant == "Symbol":
        sym = start.kind.value
        if sym == "}" or sym == "{":
            return BlockStatementParseResult(parser=parser, statement=None, success=False)
    capture = collect_until(current, [";"])
    if len(capture.tokens) == 0:
        return BlockStatementParseResult(parser=parser, statement=None, success=False)
    statement_tokens = []
    token_index = 0
    while True:
        if token_index >= len(capture.tokens):
            break
        statement_tokens = append_token(
            statement_tokens, capture.tokens[token_index])
        token_index += 1
    trimmed = trim_token_edges(capture.tokens)
    if len(trimmed) == 0:
        return BlockStatementParseResult(parser=parser, statement=None, success=False)
    current = capture.parser
    current = skip_trivia(current)
    terminator = parser_peek_raw(current)
    if terminator.kind.variant != "Symbol" or terminator.kind.value != ";":
        return BlockStatementParseResult(parser=parser, statement=None, success=False)
    statement_tokens = append_token(statement_tokens, terminator)
    current = parser_advance_raw(current)
    expression = expression_from_tokens(trimmed)
    span = source_span_from_tokens(statement_tokens)
    statement = runtime.enum_instantiate(Statement, 'ExpressionStatement', [
                                         runtime.enum_field('expression', expression), runtime.enum_field('span', span)])
    return BlockStatementParseResult(parser=current, statement=statement, success=True)


def parse_unknown(parser):
    parser = skip_trivia(parser)
    tokens = []
    current = parser
    depth = 0
    while True:
        tok = parser_peek_raw(current)
        tokens = append_token(tokens, tok)
        if tok.kind.variant == "Symbol":
            sym = tok.kind.value
            if sym == "{":
                depth += 1
            else:
                if sym == "}":
                    if depth > 0:
                        depth -= 1
                    if depth == 0 and sym == "}":
                        current = parser_advance_raw(current)
                        break
                else:
                    if sym == ";" and depth == 0:
                        current = parser_advance_raw(current)
                        break
        if tok.kind.variant == "EndOfFile":
            current = parser_advance_raw(current)
            break
        current = parser_advance_raw(current)
    text = tokens_to_text(tokens)
    block = runtime.enum_instantiate(Statement, 'Unknown', [runtime.enum_field(
        'tokens', tokens), runtime.enum_field('text', text)])
    parser = skip_trivia(current)
    return StatementParseResult(parser=parser, statement=block)


def identifier_matches(token, expected):
    if token.kind.variant != "Identifier":
        return False
    if token.kind.value == expected:
        return True
    return token.lexeme == expected


def identifier_text(token):
    if token.kind.variant == "Identifier":
        value = token.kind.value
        if len(value) > 0:
            return value
    return token.lexeme


def string_literal_value(token):
    if token.kind.variant == "StringLiteral":
        value = token.kind.value
        if len(value) > 0:
            return value
    lexeme = token.lexeme
    return strip_surrounding_quotes(lexeme)


def skip_trivia(parser):
    current = parser
    while True:
        if current.index >= len(current.tokens):
            break
        token = current.tokens[current.index]
        if is_trivia_token(token):
            current = parser_advance_raw(current)
            continue
        break
    return current


def parser_peek_raw(parser):
    if parser.index >= len(parser.tokens):
        return parser.tokens[len(parser.tokens) - 1]
    return parser.tokens[parser.index]


def parser_advance_raw(parser):
    if parser.index + 1 > len(parser.tokens):
        return parser
    return Parser(tokens=parser.tokens, index=parser.index + 1)


def consume_keyword(parser, keyword):
    parser = skip_trivia(parser)
    token = parser_peek_raw(parser)
    if identifier_matches(token, keyword):
        return parser_advance_raw(parser)
    return parser


def consume_symbol(parser, symbol):
    parser = skip_trivia(parser)
    token = parser_peek_raw(parser)
    if token.kind.variant == "Symbol" and token.kind.value == symbol:
        return parser_advance_raw(parser)
    return parser


def collect_until(parser, terminators):
    current = parser
    captured = []
    paren_depth = 0
    brace_depth = 0
    bracket_depth = 0
    while True:
        token = parser_peek_raw(current)
        if token.kind.variant == "EndOfFile":
            break
        should_stop = paren_depth == 0 and brace_depth == 0 and bracket_depth == 0 and token.kind.variant == "Symbol" and string_array_contains(
            terminators, token.kind.value)
        if should_stop:
            break
        captured = append_token(captured, token)
        if token.kind.variant == "Symbol":
            sym = token.kind.value
            if sym == "(":
                paren_depth += 1
            else:
                if sym == ")" and paren_depth > 0:
                    paren_depth -= 1
                else:
                    if sym == "{":
                        brace_depth += 1
                    else:
                        if sym == "}" and brace_depth > 0:
                            brace_depth -= 1
                        else:
                            if sym == "[":
                                bracket_depth += 1
                            else:
                                if sym == "]" and bracket_depth > 0:
                                    bracket_depth -= 1
        advanced = parser_advance_raw(current)
        if advanced.index == current.index:
            break
        current = advanced
    return CaptureResult(parser=current, tokens=captured)


def collect_parenthesized(parser):
    current = skip_trivia(parser)
    start = parser_peek_raw(current)
    if start.kind.variant != "Symbol" or start.kind.value != "(":
        return ParenthesizedParseResult(parser=parser, tokens=[], success=False)
    current = parser_advance_raw(current)
    tokens = []
    depth = 1
    while True:
        token = parser_peek_raw(current)
        if token.kind.variant == "EndOfFile":
            return ParenthesizedParseResult(parser=parser, tokens=[], success=False)
        if token.kind.variant == "Symbol":
            sym = token.kind.value
            if sym == "(":
                depth += 1
            else:
                if sym == ")":
                    depth -= 1
                    if depth == 0:
                        current = parser_advance_raw(current)
                        break
        tokens = append_token(tokens, token)
        current = parser_advance_raw(current)
    return ParenthesizedParseResult(parser=current, tokens=tokens, success=True)


def collect_pattern_until_arrow(parser):
    current = skip_trivia(parser)
    tokens = []
    while True:
        token = parser_peek_raw(current)
        if token.kind.variant == "EndOfFile":
            return PatternCaptureResult(parser=parser, tokens=[], success=False)
        if token.kind.variant == "Symbol":
            sym = token.kind.value
            if sym == "=>" or sym == "->":
                current = parser_advance_raw(current)
                break
        tokens = append_token(tokens, token)
        advanced = parser_advance_raw(current)
        if advanced.index == current.index:
            return PatternCaptureResult(parser=parser, tokens=[], success=False)
        current = advanced
    return PatternCaptureResult(parser=current, tokens=tokens, success=True)


def split_match_case_tokens(tokens):
    trimmed = trim_token_edges(tokens)
    if len(trimmed) == 0:
        return MatchCaseTokenSplit(pattern_tokens=[], guard_tokens=[], has_guard=False)
    guard_index = find_top_level_identifier(trimmed, "if")
    if guard_index == -1:
        return MatchCaseTokenSplit(pattern_tokens=trimmed, guard_tokens=[], has_guard=False)
    pattern_tokens = trim_token_edges(token_slice(trimmed, 0, guard_index))
    guard_tokens = trim_token_edges(token_slice(
        trimmed, guard_index + 1, len(trimmed)))
    return MatchCaseTokenSplit(pattern_tokens=pattern_tokens, guard_tokens=guard_tokens, has_guard=True)


def parse_decorator_argument(tokens):
    if len(tokens) == 0:
        return None
    colon_index = find_top_level_colon(tokens)
    if colon_index == -1:
        trimmed_tokens = trim_token_edges(tokens)
        if len(trimmed_tokens) == 0:
            return None
        expr = normalize_expression(
            trimmed_tokens, expression_from_tokens(trimmed_tokens))
        return DecoratorArgument(name=None, expression=expr)
    name_tokens = trim_token_edges(token_slice(tokens, 0, colon_index))
    value_tokens = trim_token_edges(
        token_slice(tokens, colon_index + 1, len(tokens)))
    if len(value_tokens) == 0:
        return None
    name_text = trim_text(tokens_to_text(name_tokens))
    if len(name_text) == 0:
        return None
    expr = normalize_expression(
        value_tokens, expression_from_tokens(value_tokens))
    if expr.variant == "Raw":
        raw_text = trim_text(tokens_to_text(value_tokens))
        if len(raw_text) >= 2 and raw_text[0] == "\"" and raw_text[len(raw_text) - 1] == "\"":
            literal = strip_surrounding_quotes(raw_text)
            expr = runtime.enum_instantiate(Expression, 'StringLiteral', [
                                            runtime.enum_field('value', literal)])
        else:
            if raw_text == "true":
                expr = runtime.enum_instantiate(Expression, 'BooleanLiteral', [
                                                runtime.enum_field('value', True)])
            else:
                if raw_text == "false":
                    expr = runtime.enum_instantiate(Expression, 'BooleanLiteral', [
                                                    runtime.enum_field('value', False)])
                else:
                    if looks_like_number(raw_text):
                        expr = runtime.enum_instantiate(Expression, 'NumberLiteral', [
                                                        runtime.enum_field('value', raw_text)])
    return DecoratorArgument(name=name_text, expression=expr)


def normalize_expression(tokens, expr):
    if expr.variant == "Raw":
        filtered = filter_trivia(tokens)
        if len(filtered) == 1:
            token = filtered[0]
            if token.kind.variant == "StringLiteral":
                return runtime.enum_instantiate(Expression, 'StringLiteral', [runtime.enum_field('value', token.kind.value)])
            if token.kind.variant == "BooleanLiteral":
                return runtime.enum_instantiate(Expression, 'BooleanLiteral', [runtime.enum_field('value', token.kind.value)])
            if token.kind.variant == "NumberLiteral":
                return runtime.enum_instantiate(Expression, 'NumberLiteral', [runtime.enum_field('value', token.kind.value)])
        raw_text = trim_text(expr.text)
        if len(raw_text) >= 2 and raw_text[0] == "\"" and raw_text[len(raw_text) - 1] == "\"":
            literal = strip_surrounding_quotes(raw_text)
            return runtime.enum_instantiate(Expression, 'StringLiteral', [runtime.enum_field('value', literal)])
        if raw_text == "true":
            return runtime.enum_instantiate(Expression, 'BooleanLiteral', [runtime.enum_field('value', True)])
        if raw_text == "false":
            return runtime.enum_instantiate(Expression, 'BooleanLiteral', [runtime.enum_field('value', False)])
        if looks_like_number(raw_text):
            return runtime.enum_instantiate(Expression, 'NumberLiteral', [runtime.enum_field('value', raw_text)])
    return expr


def looks_like_number(text):
    if len(text) == 0:
        return False
    has_decimal = False
    index = 0
    if text[0] == "-":
        if len(text) == 1:
            return False
        index = 1
    while True:
        if index >= len(text):
            break
        ch = text[index]
        if ch == ".":
            if has_decimal:
                return False
            has_decimal = True
            index += 1
            continue
        if not is_decimal_digit(ch):
            return False
        index += 1
    return True


def is_decimal_digit(ch):
    return ch == "0" or ch == "1" or ch == "2" or ch == "3" or ch == "4" or ch == "5" or ch == "6" or ch == "7" or ch == "8" or ch == "9"


def trim_token_edges(tokens):
    start = 0
    end = len(tokens)
    while True:
        if start >= end:
            break
        token = tokens[start]
        if is_trivia_token(token):
            start += 1
            continue
        break
    while True:
        if end <= start:
            break
        token = tokens[end - 1]
        if is_trivia_token(token):
            end -= 1
            continue
        break
    return token_slice(tokens, start, end)


def token_slice(tokens, start, end):
    result = []
    index = start
    while True:
        if index >= end:
            break
        result = append_token(result, tokens[index])
        index += 1
    return result


def source_span_from_tokens(tokens):
    trimmed = trim_token_edges(tokens)
    if len(trimmed) == 0:
        return None
    start = trimmed[0]
    last = trimmed[len(trimmed) - 1]
    end_line = last.line
    end_column = last.column
    lexeme = last.lexeme
    index = 0
    while True:
        if index >= len(lexeme):
            break
        ch = lexeme[index]
        if ch == "\n":
            end_line += 1
            end_column = 1
        else:
            end_column += 1
        index += 1
    return SourceSpan(start_line=start.line, start_column=start.column, end_line=end_line, end_column=end_column)


def trim_block_tokens(tokens):
    depth = 0
    index = 0
    end = len(tokens)
    while True:
        if index >= len(tokens):
            break
        token = tokens[index]
        if token.kind.variant == "Symbol":
            sym = token.kind.value
            if sym == "{":
                depth += 1
            else:
                if sym == "}":
                    if depth > 0:
                        depth -= 1
                    if depth == 0:
                        end = index + 1
                        break
        index += 1
    return token_slice(tokens, 0, end)


def find_top_level_colon(tokens):
    angle = 0
    paren = 0
    brace = 0
    bracket = 0
    index = 0
    while True:
        if index >= len(tokens):
            break
        token = tokens[index]
        if token.kind.variant == "Symbol":
            sym = token.kind.value
            if sym == "<":
                angle += 1
            else:
                if sym == ">" and angle > 0:
                    angle -= 1
                else:
                    if sym == "(":
                        paren += 1
                    else:
                        if sym == ")" and paren > 0:
                            paren -= 1
                        else:
                            if sym == "{":
                                brace += 1
                            else:
                                if sym == "}" and brace > 0:
                                    brace -= 1
                                else:
                                    if sym == "[":
                                        bracket += 1
                                    else:
                                        if sym == "]" and bracket > 0:
                                            bracket -= 1
                                        else:
                                            if sym == ":":
                                                at_top = angle == 0 and paren == 0 and brace == 0 and bracket == 0
                                                if at_top:
                                                    return index
        index += 1
    return -1


def expression_from_tokens(tokens):
    filtered = filter_trivia(tokens)
    if len(filtered) == 0:
        return runtime.enum_instantiate(Expression, 'Raw', [runtime.enum_field('text', "")])
    if len(filtered) == 1:
        single = expression_from_single_token(filtered[0])
        if single != None:
            return single
    state = ExpressionTokens(tokens=filtered, index=0)
    result = parse_expression_bp(state, 0)
    if not result.success:
        return runtime.enum_instantiate(Expression, 'Raw', [runtime.enum_field('text', trim_text(tokens_to_text(tokens)))])
    if result.state.index != len(result.state.tokens):
        return runtime.enum_instantiate(Expression, 'Raw', [runtime.enum_field('text', trim_text(tokens_to_text(tokens)))])
    return result.expression


def expression_from_single_token(token):
    if token.kind.variant == "NumberLiteral":
        return runtime.enum_instantiate(Expression, 'NumberLiteral', [runtime.enum_field('value', token.kind.value)])
    if token.kind.variant == "BooleanLiteral":
        return runtime.enum_instantiate(Expression, 'BooleanLiteral', [runtime.enum_field('value', token.kind.value)])
    if token.kind.variant == "StringLiteral":
        return runtime.enum_instantiate(Expression, 'StringLiteral', [runtime.enum_field('value', token.kind.value)])
    if token.kind.variant == "Identifier":
        value = identifier_text(token)
        if value == "true":
            return runtime.enum_instantiate(Expression, 'BooleanLiteral', [runtime.enum_field('value', True)])
        if value == "false":
            return runtime.enum_instantiate(Expression, 'BooleanLiteral', [runtime.enum_field('value', False)])
        if value == "null":
            return Expression.NullLiteral()
        return runtime.enum_instantiate(Expression, 'Identifier', [runtime.enum_field('name', value)])
    return None


def expression_tokens_collect_until(state, terminators):
    current = state
    collected = []
    angle = 0
    paren = 0
    brace = 0
    bracket = 0
    while True:
        if expression_tokens_is_at_end(current):
            return ExpressionCollectResult(state=current, tokens=collected, success=False)
        token = expression_tokens_peek(current)
        at_top = angle == 0 and paren == 0 and brace == 0 and bracket == 0
        if at_top and token.kind.variant == "Symbol" and string_array_contains(terminators, token.kind.value):
            break
        if token.kind.variant == "Symbol":
            sym = token.kind.value
            if sym == "<":
                angle += 1
            else:
                if sym == ">":
                    if angle > 0:
                        angle -= 1
                else:
                    if sym == "(":
                        paren += 1
                    else:
                        if sym == ")":
                            if paren > 0:
                                paren -= 1
                        else:
                            if sym == "{":
                                brace += 1
                            else:
                                if sym == "}":
                                    if brace > 0:
                                        brace -= 1
                                else:
                                    if sym == "[":
                                        bracket += 1
                                    else:
                                        if sym == "]":
                                            if bracket > 0:
                                                bracket -= 1
        collected = append_token(collected, token)
        current = expression_tokens_advance(current)
    return ExpressionCollectResult(state=current, tokens=collected, success=True)


def collect_expression_block(state):
    current = state
    if expression_tokens_is_at_end(current):
        return ExpressionBlockParseResult(state=current, tokens=[], success=False)
    first = expression_tokens_peek(current)
    if first.kind.variant != "Symbol" or first.kind.value != "{":
        return ExpressionBlockParseResult(state=current, tokens=[], success=False)
    tokens = []
    depth = 0
    while True:
        if expression_tokens_is_at_end(current):
            return ExpressionBlockParseResult(state=current, tokens=tokens, success=False)
        token = expression_tokens_peek(current)
        tokens = append_token(tokens, token)
        if token.kind.variant == "Symbol":
            sym = token.kind.value
            if sym == "{":
                depth += 1
            else:
                if sym == "}":
                    depth -= 1
                    if depth == 0:
                        current = expression_tokens_advance(current)
                        break
        current = expression_tokens_advance(current)
    return ExpressionBlockParseResult(state=current, tokens=tokens, success=True)


def parse_lambda_parameter(state):
    current = state
    if expression_tokens_is_at_end(current):
        return LambdaParameterParseResult(state=current, parameter=Parameter(name="", type_annotation=None, default_value=None, mutable=False, span=None), success=False)
    start_index = current.index
    is_mutable = False
    token = expression_tokens_peek(current)
    if token.kind.variant == "Identifier" and identifier_matches(token, "mut"):
        is_mutable = True
        current = expression_tokens_advance(current)
        if expression_tokens_is_at_end(current):
            return LambdaParameterParseResult(state=current, parameter=Parameter(name="", type_annotation=None, default_value=None, mutable=False, span=None), success=False)
    name_token = expression_tokens_peek(current)
    if name_token.kind.variant != "Identifier":
        return LambdaParameterParseResult(state=current, parameter=Parameter(name="", type_annotation=None, default_value=None, mutable=False, span=None), success=False)
    name = identifier_text(name_token)
    current = expression_tokens_advance(current)
    type_annotation = None
    if not expression_tokens_is_at_end(current):
        separator = expression_tokens_peek(current)
        if separator.kind.variant == "Symbol" and separator.kind.value == ":" or separator.kind.value == "->":
            current = expression_tokens_advance(current)
            capture = expression_tokens_collect_until(current, ["=", ",", ")"])
            if not capture.success:
                return LambdaParameterParseResult(state=current, parameter=Parameter(name=name, type_annotation=None, default_value=None, mutable=is_mutable, span=None), success=False)
            type_text = trim_text(tokens_to_text(capture.tokens))
            if len(type_text) > 0:
                type_annotation = TypeAnnotation(text=type_text)
            current = capture.state
    default_value = None
    if not expression_tokens_is_at_end(current):
        assign = expression_tokens_peek(current)
        if assign.kind.variant == "Symbol" and assign.kind.value == "=":
            current = expression_tokens_advance(current)
            capture = expression_tokens_collect_until(current, [",", ")"])
            if not capture.success:
                return LambdaParameterParseResult(state=current, parameter=Parameter(name=name, type_annotation=type_annotation, default_value=None, mutable=is_mutable, span=None), success=False)
            default_value = expression_from_tokens(capture.tokens)
            current = capture.state
    parameter_tokens = token_slice(state.tokens, start_index, current.index)
    span = source_span_from_tokens(parameter_tokens)
    parameter = Parameter(name=name, type_annotation=type_annotation,
                          default_value=default_value, mutable=is_mutable, span=span)
    return LambdaParameterParseResult(state=current, parameter=parameter, success=True)


def parse_lambda_parameter_list(state):
    current = state
    parameters = []
    if expression_tokens_is_at_end(current):
        return LambdaParameterListParseResult(state=current, parameters=parameters, success=False)
    closing = expression_tokens_peek(current)
    if closing.kind.variant == "Symbol" and closing.kind.value == ")":
        current = expression_tokens_advance(current)
        return LambdaParameterListParseResult(state=current, parameters=parameters, success=True)
    while True:
        param_result = parse_lambda_parameter(current)
        if not param_result.success:
            return LambdaParameterListParseResult(state=current, parameters=parameters, success=False)
        parameters = append_parameter(parameters, param_result.parameter)
        current = param_result.state
        if expression_tokens_is_at_end(current):
            return LambdaParameterListParseResult(state=current, parameters=parameters, success=False)
        separator = expression_tokens_peek(current)
        if separator.kind.variant == "Symbol":
            if separator.kind.value == ",":
                current = expression_tokens_advance(current)
                continue
            if separator.kind.value == ")":
                current = expression_tokens_advance(current)
                break
        return LambdaParameterListParseResult(state=current, parameters=parameters, success=False)
    return LambdaParameterListParseResult(state=current, parameters=parameters, success=True)


def parse_lambda_expression(state):
    current = state
    if expression_tokens_is_at_end(current):
        return expression_parse_failure(state)
    token = expression_tokens_peek(current)
    if token.kind.variant != "Identifier" or not identifier_matches(token, "fn"):
        return expression_parse_failure(state)
    current = expression_tokens_advance(current)
    if expression_tokens_is_at_end(current):
        return expression_parse_failure(state)
    open_paren = expression_tokens_peek(current)
    if open_paren.kind.variant != "Symbol" or open_paren.kind.value != "(":
        return expression_parse_failure(state)
    current = expression_tokens_advance(current)
    params_result = parse_lambda_parameter_list(current)
    if not params_result.success:
        return expression_parse_failure(state)
    current = params_result.state
    parameters = params_result.parameters
    return_type = None
    if not expression_tokens_is_at_end(current):
        separator = expression_tokens_peek(current)
        if separator.kind.variant == "Symbol" and separator.kind.value == ":" or separator.kind.value == "->":
            current = expression_tokens_advance(current)
            capture = expression_tokens_collect_until(current, ["{"])
            if not capture.success:
                return expression_parse_failure(state)
            type_text = trim_text(tokens_to_text(capture.tokens))
            if len(type_text) > 0:
                return_type = TypeAnnotation(text=type_text)
            current = capture.state
    if expression_tokens_is_at_end(current):
        return expression_parse_failure(state)
    block_result = collect_expression_block(current)
    if not block_result.success:
        return expression_parse_failure(state)
    current = block_result.state
    block_tokens = block_result.tokens
    block_tokens = append_token(block_tokens, Token(
        kind=TokenKind.EndOfFile(), lexeme="", line=0, column=0))
    block_parser = Parser(tokens=block_tokens, index=0)
    parsed_block = parse_block(block_parser)
    body = parsed_block.block
    return ExpressionParseResult(state=current, expression=runtime.enum_instantiate(Expression, 'Lambda', [runtime.enum_field('parameters', parameters), runtime.enum_field('body', body), runtime.enum_field('return_type', return_type)]), success=True)


def parse_expression_bp(state, min_precedence):
    prefix_result = parse_prefix_expression(state)
    if not prefix_result.success:
        return prefix_result
    current_state = prefix_result.state
    left_expression = prefix_result.expression
    while True:
        if expression_tokens_is_at_end(current_state):
            break
        token = expression_tokens_peek(current_state)
        if token.kind.variant != "Symbol":
            break
        op = token.kind.value
        precedence = binary_precedence(op)
        if precedence == -1:
            break
        if precedence < min_precedence:
            break
        current_state = expression_tokens_advance(current_state)
        rhs_result = parse_expression_bp(current_state, precedence + 1)
        if not rhs_result.success:
            return expression_parse_failure(state)
        current_state = rhs_result.state
        if op == "..":
            left_expression = runtime.enum_instantiate(Expression, 'Range', [runtime.enum_field(
                'start', left_expression), runtime.enum_field('end', rhs_result.expression)])
        else:
            left_expression = runtime.enum_instantiate(Expression, 'Binary', [runtime.enum_field(
                'operator', op), runtime.enum_field('left', left_expression), runtime.enum_field('right', rhs_result.expression)])
    return ExpressionParseResult(state=current_state, expression=left_expression, success=True)


def parse_prefix_expression(state):
    if expression_tokens_is_at_end(state):
        return expression_parse_failure(state)
    token = expression_tokens_peek(state)
    if token.kind.variant == "Symbol":
        sym = token.kind.value
        if sym == "-" or sym == "!":
            advanced = expression_tokens_advance(state)
            operand_result = parse_expression_bp(advanced, unary_precedence())
            if not operand_result.success:
                return operand_result
            return ExpressionParseResult(state=operand_result.state, expression=runtime.enum_instantiate(Expression, 'Unary', [runtime.enum_field('operator', sym), runtime.enum_field('operand', operand_result.expression)]), success=True)
    if token.kind.variant == "Identifier" and identifier_matches(token, "fn"):
        lambda_result = parse_lambda_expression(state)
        if lambda_result.success:
            return lambda_result
    primary_result = parse_primary_expression(state)
    if not primary_result.success:
        return primary_result
    return parse_postfix_chain(primary_result.state, primary_result.expression)


def parse_primary_expression(state):
    if expression_tokens_is_at_end(state):
        return expression_parse_failure(state)
    token = expression_tokens_peek(state)
    if token.kind.variant == "NumberLiteral":
        return ExpressionParseResult(state=expression_tokens_advance(state), expression=runtime.enum_instantiate(Expression, 'NumberLiteral', [runtime.enum_field('value', token.kind.value)]), success=True)
    if token.kind.variant == "BooleanLiteral":
        return ExpressionParseResult(state=expression_tokens_advance(state), expression=runtime.enum_instantiate(Expression, 'BooleanLiteral', [runtime.enum_field('value', token.kind.value)]), success=True)
    if token.kind.variant == "StringLiteral":
        return ExpressionParseResult(state=expression_tokens_advance(state), expression=runtime.enum_instantiate(Expression, 'StringLiteral', [runtime.enum_field('value', token.kind.value)]), success=True)
    if token.kind.variant == "Identifier":
        name = identifier_text(token)
        if name == "true":
            return ExpressionParseResult(state=expression_tokens_advance(state), expression=runtime.enum_instantiate(Expression, 'BooleanLiteral', [runtime.enum_field('value', True)]), success=True)
        if name == "false":
            return ExpressionParseResult(state=expression_tokens_advance(state), expression=runtime.enum_instantiate(Expression, 'BooleanLiteral', [runtime.enum_field('value', False)]), success=True)
        if name == "null":
            return ExpressionParseResult(state=expression_tokens_advance(state), expression=Expression.NullLiteral(), success=True)
        return ExpressionParseResult(state=expression_tokens_advance(state), expression=runtime.enum_instantiate(Expression, 'Identifier', [runtime.enum_field('name', name)]), success=True)
    if token.kind.variant == "Symbol" and token.kind.value == "(":
        inner_state = expression_tokens_advance(state)
        inner_result = parse_expression_bp(inner_state, 0)
        if not inner_result.success:
            return inner_result
        after_inner = inner_result.state
        if expression_tokens_is_at_end(after_inner):
            return expression_parse_failure(state)
        closing = expression_tokens_peek(after_inner)
        if closing.kind.variant != "Symbol" or closing.kind.value != ")":
            return expression_parse_failure(state)
        return ExpressionParseResult(state=expression_tokens_advance(after_inner), expression=inner_result.expression, success=True)
    if token.kind.variant == "Symbol" and token.kind.value == "[":
        array_result = parse_array_literal(expression_tokens_advance(state))
        if not array_result.success:
            return expression_parse_failure(state)
        return ExpressionParseResult(state=array_result.state, expression=runtime.enum_instantiate(Expression, 'Array', [runtime.enum_field('elements', array_result.elements)]), success=True)
    if token.kind.variant == "Symbol" and token.kind.value == "{":
        object_result = parse_object_literal(expression_tokens_advance(state))
        if not object_result.success:
            return expression_parse_failure(state)
        return ExpressionParseResult(state=object_result.state, expression=runtime.enum_instantiate(Expression, 'Object', [runtime.enum_field('fields', object_result.fields)]), success=True)
    return expression_parse_failure(state)


def parse_postfix_chain(state, expression):
    current_state = state
    current_expression = expression
    while True:
        if expression_tokens_is_at_end(current_state):
            break
        token = expression_tokens_peek(current_state)
        if token.kind.variant != "Symbol":
            break
        sym = token.kind.value
        if sym == ".":
            after_dot = expression_tokens_advance(current_state)
            if expression_tokens_is_at_end(after_dot):
                return expression_parse_failure(state)
            member_token = expression_tokens_peek(after_dot)
            if member_token.kind.variant != "Identifier":
                return expression_parse_failure(state)
            current_state = expression_tokens_advance(after_dot)
            current_expression = runtime.enum_instantiate(Expression, 'Member', [runtime.enum_field(
                'object', current_expression), runtime.enum_field('member', identifier_text(member_token))])
            continue
        if sym == "(":
            call_result = parse_call_arguments(current_state)
            if not call_result.success:
                return expression_parse_failure(state)
            current_state = call_result.state
            current_expression = runtime.enum_instantiate(Expression, 'Call', [runtime.enum_field(
                'callee', current_expression), runtime.enum_field('arguments', call_result.arguments)])
            continue
        if sym == "[":
            index_state = expression_tokens_advance(current_state)
            index_result = parse_expression_bp(index_state, 0)
            if not index_result.success:
                return expression_parse_failure(state)
            after_index = index_result.state
            if expression_tokens_is_at_end(after_index):
                return expression_parse_failure(state)
            closing = expression_tokens_peek(after_index)
            if closing.kind.variant != "Symbol" or closing.kind.value != "]":
                return expression_parse_failure(state)
            current_state = expression_tokens_advance(after_index)
            current_expression = runtime.enum_instantiate(Expression, 'Index', [runtime.enum_field(
                'sequence', current_expression), runtime.enum_field('index', index_result.expression)])
            continue
        if sym == "{":
            if not expression_is_struct_target(current_expression):
                break
            struct_result = parse_struct_literal(
                expression_tokens_advance(current_state), current_expression)
            if not struct_result.success:
                return expression_parse_failure(state)
            current_state = struct_result.state
            current_expression = struct_result.expression
            continue
        break
    return ExpressionParseResult(state=current_state, expression=current_expression, success=True)


def parse_call_arguments(state):
    current = expression_tokens_advance(state)
    arguments = []
    if expression_tokens_is_at_end(current):
        return CallArgumentsParseResult(state=state, arguments=[], success=False)
    if expression_tokens_peek(current).kind.variant == "Symbol" and expression_tokens_peek(current).kind.value == ")":
        current = expression_tokens_advance(current)
        return CallArgumentsParseResult(state=current, arguments=arguments, success=True)
    while True:
        argument_result = parse_expression_bp(current, 0)
        if not argument_result.success:
            return CallArgumentsParseResult(state=state, arguments=[], success=False)
        arguments = append_expression(arguments, argument_result.expression)
        current = argument_result.state
        if expression_tokens_is_at_end(current):
            return CallArgumentsParseResult(state=state, arguments=[], success=False)
        separator = expression_tokens_peek(current)
        if separator.kind.variant == "Symbol" and separator.kind.value == ",":
            current = expression_tokens_advance(current)
            continue
        if separator.kind.variant == "Symbol" and separator.kind.value == ")":
            current = expression_tokens_advance(current)
            break
        return CallArgumentsParseResult(state=state, arguments=[], success=False)
    return CallArgumentsParseResult(state=current, arguments=arguments, success=True)


def parse_array_literal(state):
    current = state
    elements = []
    if expression_tokens_is_at_end(current):
        return ArrayLiteralParseResult(state=state, elements=[], success=False)
    if expression_tokens_peek(current).kind.variant == "Symbol" and expression_tokens_peek(current).kind.value == "]":
        current = expression_tokens_advance(current)
        return ArrayLiteralParseResult(state=current, elements=elements, success=True)
    while True:
        element_result = parse_expression_bp(current, 0)
        if not element_result.success:
            return ArrayLiteralParseResult(state=state, elements=[], success=False)
        elements = append_expression(elements, element_result.expression)
        current = element_result.state
        if expression_tokens_is_at_end(current):
            return ArrayLiteralParseResult(state=state, elements=[], success=False)
        separator = expression_tokens_peek(current)
        if separator.kind.variant == "Symbol" and separator.kind.value == ",":
            current = expression_tokens_advance(current)
            if expression_tokens_is_at_end(current):
                return ArrayLiteralParseResult(state=state, elements=[], success=False)
            maybe_end = expression_tokens_peek(current)
            if maybe_end.kind.variant == "Symbol" and maybe_end.kind.value == "]":
                current = expression_tokens_advance(current)
                break
            continue
        if separator.kind.variant == "Symbol" and separator.kind.value == "]":
            current = expression_tokens_advance(current)
            break
        return ArrayLiteralParseResult(state=state, elements=[], success=False)
    return ArrayLiteralParseResult(state=current, elements=elements, success=True)


def parse_object_literal(state):
    current = state
    fields = []
    if expression_tokens_is_at_end(current):
        return ObjectLiteralParseResult(state=state, fields=[], success=False)
    if expression_tokens_peek(current).kind.variant == "Symbol" and expression_tokens_peek(current).kind.value == "}":
        current = expression_tokens_advance(current)
        return ObjectLiteralParseResult(state=current, fields=fields, success=True)
    while True:
        if expression_tokens_is_at_end(current):
            return ObjectLiteralParseResult(state=state, fields=[], success=False)
        name_token = expression_tokens_peek(current)
        if name_token.kind.variant != "Identifier":
            return ObjectLiteralParseResult(state=state, fields=[], success=False)
        field_name = identifier_text(name_token)
        current = expression_tokens_advance(current)
        if expression_tokens_is_at_end(current):
            return ObjectLiteralParseResult(state=state, fields=[], success=False)
        colon = expression_tokens_peek(current)
        if colon.kind.variant != "Symbol" or colon.kind.value != ":":
            return ObjectLiteralParseResult(state=state, fields=[], success=False)
        current = expression_tokens_advance(current)
        value_result = parse_expression_bp(current, 0)
        if not value_result.success:
            return ObjectLiteralParseResult(state=state, fields=[], success=False)
        current = value_result.state
        fields = append_object_field(fields, ObjectField(
            name=field_name, value=value_result.expression))
        if expression_tokens_is_at_end(current):
            return ObjectLiteralParseResult(state=state, fields=[], success=False)
        separator = expression_tokens_peek(current)
        if separator.kind.variant == "Symbol" and separator.kind.value == ",":
            current = expression_tokens_advance(current)
            if expression_tokens_is_at_end(current):
                return ObjectLiteralParseResult(state=state, fields=[], success=False)
            maybe_end = expression_tokens_peek(current)
            if maybe_end.kind.variant == "Symbol" and maybe_end.kind.value == "}":
                current = expression_tokens_advance(current)
                break
            continue
        if separator.kind.variant == "Symbol" and separator.kind.value == "}":
            current = expression_tokens_advance(current)
            break
        return ObjectLiteralParseResult(state=state, fields=[], success=False)
    return ObjectLiteralParseResult(state=current, fields=fields, success=True)


def parse_struct_literal(state, target):
    type_result = collect_struct_type_name(target)
    if not type_result.success:
        return expression_parse_failure(state)
    fields_result = parse_object_literal(state)
    if not fields_result.success:
        return expression_parse_failure(state)
    return ExpressionParseResult(state=fields_result.state, expression=runtime.enum_instantiate(Expression, 'Struct', [runtime.enum_field('type_name', type_result.parts), runtime.enum_field('fields', fields_result.fields)]), success=True)


def expression_parse_failure(state):
    return ExpressionParseResult(state=state, expression=runtime.enum_instantiate(Expression, 'Raw', [runtime.enum_field('text', "")]), success=False)


def expression_tokens_is_at_end(state):
    return state.index >= len(state.tokens)


def expression_tokens_peek(state):
    return state.tokens[state.index]


def expression_tokens_advance(state):
    if state.index >= len(state.tokens):
        return state
    return ExpressionTokens(tokens=state.tokens, index=state.index + 1)


def expression_is_struct_target(expression):
    if expression.variant == "Identifier":
        return True
    if expression.variant == "Member":
        return expression_is_struct_target(expression.object)
    return False


def collect_struct_type_name(expression):
    if expression.variant == "Identifier":
        return StructTypeNameResult(parts=[expression.name], success=True)
    if expression.variant == "Member":
        inner = collect_struct_type_name(expression.object)
        if not inner.success:
            return StructTypeNameResult(parts=[], success=False)
        return StructTypeNameResult(parts=append_string(inner.parts, expression.member), success=True)
    return StructTypeNameResult(parts=[], success=False)


def binary_precedence(op):
    if op == "..":
        return 0
    if op == "||":
        return 1
    if op == "&&":
        return 2
    if op == "==" or op == "!=":
        return 3
    if op == "<" or op == "<=" or op == ">" or op == ">=":
        return 4
    if op == "+" or op == "-":
        return 5
    if op == "*" or op == "/" or op == "%":
        return 6
    return -1


def unary_precedence():
    return 7


def filter_trivia(tokens):
    index = 0
    filtered = []
    while True:
        if index >= len(tokens):
            break
        token = tokens[index]
        if token.kind.variant != "Whitespace" and token.kind.variant != "Comment" and token.kind.variant != "EndOfFile":
            filtered = append_token(filtered, token)
        index += 1
    return filtered


def tokens_to_text(tokens):
    text = ""
    index = 0
    while True:
        if index >= len(tokens):
            break
        text = text + tokens[index].lexeme
        index += 1
    return text


def trim_text(value):
    start = 0
    end = len(value)
    while True:
        if start >= end:
            break
        ch = value[start]
        if is_trim_whitespace(ch):
            start += 1
            continue
        break
    while True:
        if end <= start:
            break
        ch = value[end - 1]
        if is_trim_whitespace(ch):
            end -= 1
            continue
        break
    return substring(value, start, end)


def is_trim_whitespace(ch):
    code = char_code(ch)
    return code == 32 or code == 10 or code == 9 or code == 13


def string_array_contains(values, target):
    index = 0
    while True:
        if index >= len(values):
            break
        if values[index] == target:
            return True
        index += 1
    return False


def is_trivia_token(token):
    if token.kind.variant == "Whitespace" or token.kind.variant == "Comment":
        return True
    if token.kind.variant == "Symbol":
        if is_whitespace_lexeme(token.lexeme):
            return True
    return False


def is_whitespace_lexeme(text):
    if len(text) == 0:
        return False
    index = 0
    while True:
        if index >= len(text):
            break
        ch = text[index]
        if not is_trim_whitespace(ch):
            return False
        index += 1
    return True


def advance_to_symbol(parser, symbol):
    current = parser
    while True:
        current = skip_trivia(current)
        token = parser_peek_raw(current)
        if token.kind.variant == "Symbol" and token.kind.value == symbol:
            return current
        if token.kind.variant == "EndOfFile":
            return current
        next = parser_advance_raw(current)
        if next.index == current.index:
            return current
        current = next


def skip_struct_member(parser):
    current = parser
    while True:
        next = parser_advance_raw(current)
        if next.index == current.index:
            return current
        current = next
        token = parser_peek_raw(current)
        if token.kind.variant == "EndOfFile":
            return current
        if token.kind.variant == "Symbol":
            sym = token.kind.value
            if sym == ";":
                current = parser_advance_raw(current)
                return current
            if sym == "}":
                return current


def skip_enum_variant_entry(parser):
    current = parser
    while True:
        next = parser_advance_raw(current)
        if next.index == current.index:
            return current
        current = next
        token = parser_peek_raw(current)
        if token.kind.variant == "EndOfFile":
            return current
        if token.kind.variant == "Symbol":
            sym = token.kind.value
            if sym == ",":
                current = parser_advance_raw(current)
                return current
            if sym == "}":
                return current


def strip_surrounding_quotes(text):
    if len(text) < 2:
        return text
    first = char_code(text[0])
    last = char_code(text[len(text) - 1])
    if first == 34 and last == 34:
        return substring(text, 1, len(text) - 1)
    return text


def normalize_test_name(text):
    trimmed = trim_text(text)
    if len(trimmed) >= 2:
        first = char_code(trimmed[0])
        last = char_code(trimmed[len(trimmed) - 1])
        if first == 34 and last == 34:
            return strip_surrounding_quotes(trimmed)
    return trimmed


def split_tokens_by_comma(tokens):
    parts = []
    segment = ""
    angle = 0
    paren = 0
    brace = 0
    bracket = 0
    index = 0
    while True:
        if index >= len(tokens):
            break
        token = tokens[index]
        if token.kind.variant == "Symbol":
            sym = token.kind.value
            if sym == "<":
                angle += 1
            else:
                if sym == ">" and angle > 0:
                    angle -= 1
                else:
                    if sym == "(":
                        paren += 1
                    else:
                        if sym == ")" and paren > 0:
                            paren -= 1
                        else:
                            if sym == "{":
                                brace += 1
                            else:
                                if sym == "}" and brace > 0:
                                    brace -= 1
                                else:
                                    if sym == "[":
                                        bracket += 1
                                    else:
                                        if sym == "]" and bracket > 0:
                                            bracket -= 1
            if sym == "," and angle == 0 and paren == 0 and brace == 0 and bracket == 0:
                text = trim_text(segment)
                if len(text) > 0:
                    parts = append_string(parts, text)
                segment = ""
                index += 1
                continue
        segment = segment + token.lexeme
        index += 1
    tail = trim_text(segment)
    if len(tail) > 0:
        parts = append_string(parts, tail)
    return parts


def split_token_slices_by_comma(tokens):
    parts = []
    segment = []
    angle = 0
    paren = 0
    brace = 0
    bracket = 0
    index = 0
    while True:
        if index >= len(tokens):
            break
        token = tokens[index]
        if token.kind.variant == "Symbol":
            sym = token.kind.value
            if sym == "<":
                angle += 1
            else:
                if sym == ">" and angle > 0:
                    angle -= 1
                else:
                    if sym == "(":
                        paren += 1
                    else:
                        if sym == ")" and paren > 0:
                            paren -= 1
                        else:
                            if sym == "{":
                                brace += 1
                            else:
                                if sym == "}" and brace > 0:
                                    brace -= 1
                                else:
                                    if sym == "[":
                                        bracket += 1
                                    else:
                                        if sym == "]" and bracket > 0:
                                            bracket -= 1
            if sym == "," and angle == 0 and paren == 0 and brace == 0 and bracket == 0:
                parts = append_token_array(parts, segment)
                segment = []
                index += 1
                continue
        segment = append_token(segment, token)
        index += 1
    if len(segment) > 0:
        parts = append_token_array(parts, segment)
    return parts


def find_top_level_symbol(tokens, symbol):
    angle = 0
    paren = 0
    brace = 0
    bracket = 0
    index = 0
    while True:
        if index >= len(tokens):
            break
        token = tokens[index]
        if token.kind.variant == "Symbol":
            sym = token.kind.value
            if sym == "<":
                angle += 1
            else:
                if sym == ">" and angle > 0:
                    angle -= 1
                else:
                    if sym == "(":
                        paren += 1
                    else:
                        if sym == ")" and paren > 0:
                            paren -= 1
                        else:
                            if sym == "{":
                                brace += 1
                            else:
                                if sym == "}" and brace > 0:
                                    brace -= 1
                                else:
                                    if sym == "[":
                                        bracket += 1
                                    else:
                                        if sym == "]" and bracket > 0:
                                            bracket -= 1
            if sym == symbol and angle == 0 and paren == 0 and brace == 0 and bracket == 0:
                return index
        index += 1
    return -1


def find_top_level_identifier(tokens, keyword):
    angle = 0
    paren = 0
    brace = 0
    bracket = 0
    index = 0
    while True:
        if index >= len(tokens):
            break
        token = tokens[index]
        if token.kind.variant == "Symbol":
            sym = token.kind.value
            if sym == "<":
                angle += 1
            else:
                if sym == ">" and angle > 0:
                    angle -= 1
                else:
                    if sym == "(":
                        paren += 1
                    else:
                        if sym == ")" and paren > 0:
                            paren -= 1
                        else:
                            if sym == "{":
                                brace += 1
                            else:
                                if sym == "}" and brace > 0:
                                    brace -= 1
                                else:
                                    if sym == "[":
                                        bracket += 1
                                    else:
                                        if sym == "]" and bracket > 0:
                                            bracket -= 1
        if token.kind.variant == "Identifier":
            if identifier_matches(token, keyword):
                if angle == 0 and paren == 0 and brace == 0 and bracket == 0:
                    return index
        index += 1
    return -1


def append_statement(statements, statement):
    return (statements) + ([statement])


def append_string(values, value):
    return (values) + ([value])


def append_parameter(parameters, parameter):
    return (parameters) + ([parameter])


def append_model_property(properties, property):
    return (properties) + ([property])


def append_field(fields, field):
    return (fields) + ([field])


def append_method(methods, method):
    return (methods) + ([method])


def append_signature(signatures, signature):
    return (signatures) + ([signature])


def append_enum_variant(variants, variant):
    return (variants) + ([variant])


def append_type_annotation(types, item):
    return (types) + ([item])


def append_type_parameter(parameters, parameter):
    return (parameters) + ([parameter])


def append_decorator(decorators, decorator):
    return (decorators) + ([decorator])


def append_decorator_argument(arguments, argument):
    return (arguments) + ([argument])


def append_with_clause(clauses, clause):
    return (clauses) + ([clause])


def append_match_case(cases, case):
    return (cases) + ([case])


def append_expression(expressions, expression):
    return (expressions) + ([expression])


def append_object_field(fields, field):
    return (fields) + ([field])


def append_token(tokens, token):
    return (tokens) + ([token])


def append_token_array(collection, tokens):
    return (collection) + ([tokens])
