import asyncio
from runtime import runtime_support as runtime

from compiler.build.ast import Program, Statement, FunctionSignature, Block, FieldDeclaration, MethodDeclaration, EnumVariant, ModelProperty, TypeParameter, TypeAnnotation, SourceSpan
from compiler.build.token import Token, TokenKind
from compiler.build.effect_checker import validate_effects, EffectRequirement, EffectViolation

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

class Diagnostic:
    def __init__(self, code, message, primary=None):
        self.code = code
        self.message = message
        self.primary = primary

    def __repr__(self):
        return runtime.struct_repr('Diagnostic', [runtime.struct_field('code', self.code), runtime.struct_field('message', self.message), runtime.struct_field('primary', self.primary)])

class SymbolEntry:
    def __init__(self, name, kind, span=None):
        self.name = name
        self.kind = kind
        self.span = span

    def __repr__(self):
        return runtime.struct_repr('SymbolEntry', [runtime.struct_field('name', self.name), runtime.struct_field('kind', self.kind), runtime.struct_field('span', self.span)])

class TypecheckResult:
    def __init__(self, diagnostics, symbols):
        self.diagnostics = diagnostics
        self.symbols = symbols

    def __repr__(self):
        return runtime.struct_repr('TypecheckResult', [runtime.struct_field('diagnostics', self.diagnostics), runtime.struct_field('symbols', self.symbols)])

class SymbolCollectionResult:
    def __init__(self, symbols, diagnostics):
        self.symbols = symbols
        self.diagnostics = diagnostics

    def __repr__(self):
        return runtime.struct_repr('SymbolCollectionResult', [runtime.struct_field('symbols', self.symbols), runtime.struct_field('diagnostics', self.diagnostics)])

class ScopeResult:
    def __init__(self, bindings, diagnostics):
        self.bindings = bindings
        self.diagnostics = diagnostics

    def __repr__(self):
        return runtime.struct_repr('ScopeResult', [runtime.struct_field('bindings', self.bindings), runtime.struct_field('diagnostics', self.diagnostics)])

def typecheck_program(program):
    top_level = collect_top_level_symbols(program)
    interfaces = collect_interface_definitions(program)
    scoped_diagnostics = check_program_scopes(program, interfaces)
    effect_diagnostics = build_effect_diagnostics(program)
    return TypecheckResult(diagnostics=(top_level.diagnostics) + ((scoped_diagnostics)) + (effect_diagnostics), symbols=top_level.symbols)

def collect_interface_definitions(program):
    interfaces = []
    for statement in program.statements:
        if statement.variant == "InterfaceDeclaration":
            interfaces = (interfaces) + ([statement])
    return interfaces

def collect_top_level_symbols(program):
    symbols = []
    diagnostics = []
    for statement in program.statements:
        result = register_top_level_symbol(statement, symbols)
        symbols = result.symbols
        diagnostics = (diagnostics) + (result.diagnostics)
    return SymbolCollectionResult(symbols=symbols, diagnostics=diagnostics)

def register_top_level_symbol(statement, existing):
    if statement.variant == "FunctionDeclaration":
        return register_symbol(statement.signature.name, "function", statement.signature.name_span, existing)
    if statement.variant == "StructDeclaration":
        return register_symbol(statement.name, "struct", statement.name_span, existing)
    if statement.variant == "EnumDeclaration":
        return register_symbol(statement.name, "enum", statement.name_span, existing)
    if statement.variant == "InterfaceDeclaration":
        return register_symbol(statement.name, "interface", statement.name_span, existing)
    if statement.variant == "ModelDeclaration":
        return register_symbol(statement.name, "model", statement.name_span, existing)
    if statement.variant == "PipelineDeclaration":
        return register_symbol(statement.signature.name, "pipeline", statement.signature.name_span, existing)
    if statement.variant == "ToolDeclaration":
        return register_symbol(statement.signature.name, "tool", statement.signature.name_span, existing)
    if statement.variant == "TestDeclaration":
        return register_symbol(statement.name, "test", statement.name_span, existing)
    if statement.variant == "TypeAliasDeclaration":
        return register_symbol(statement.name, "type", statement.name_span, existing)
    if statement.variant == "VariableDeclaration":
        return register_symbol(statement.name, "variable", statement.span, existing)
    return SymbolCollectionResult(symbols=existing, diagnostics=[])

def check_program_scopes(program, interfaces):
    bindings = []
    diagnostics = []
    for statement in program.statements:
        result = check_statement(statement, bindings, interfaces)
        bindings = result.bindings
        diagnostics = (diagnostics) + (result.diagnostics)
    return diagnostics

def check_statement(statement, bindings, interfaces):
    if statement.variant == "VariableDeclaration":
        return register_local_symbol(bindings, statement.name, "variable", statement.span)
    if statement.variant == "FunctionDeclaration":
        registration = register_local_symbol(bindings, statement.signature.name, "function", statement.signature.name_span)
        diagnostics = registration.diagnostics
        diagnostics = (diagnostics) + (check_function_signature(statement.signature))
        function_diagnostics = check_function_body(statement.signature, statement.body, interfaces)
        return ScopeResult(bindings=registration.bindings, diagnostics=(diagnostics) + (function_diagnostics))
    if statement.variant == "StructDeclaration":
        registration = register_local_symbol(bindings, statement.name, "struct", statement.name_span)
        diagnostics = registration.diagnostics
        diagnostics = (diagnostics) + (check_type_parameters(statement.type_parameters))
        diagnostics = (diagnostics) + (check_struct_fields(statement.fields))
        diagnostics = (diagnostics) + (check_struct_methods(statement.methods))
        diagnostics = (diagnostics) + (check_struct_implements_interfaces(statement, interfaces))
        index = 0
        while True:
            if index >= len(statement.methods):
                break
            method = statement.methods[index]
            diagnostics = (diagnostics) + (check_function_body(method.signature, method.body, interfaces))
            index += 1
        return ScopeResult(bindings=registration.bindings, diagnostics=diagnostics)
    if statement.variant == "EnumDeclaration":
        registration = register_local_symbol(bindings, statement.name, "enum", statement.name_span)
        diagnostics = registration.diagnostics
        diagnostics = (diagnostics) + (check_type_parameters(statement.type_parameters))
        diagnostics = (diagnostics) + (check_enum_variants(statement.variants))
        return ScopeResult(bindings=registration.bindings, diagnostics=diagnostics)
    if statement.variant == "InterfaceDeclaration":
        registration = register_local_symbol(bindings, statement.name, "interface", statement.name_span)
        diagnostics = registration.diagnostics
        diagnostics = (diagnostics) + (check_type_parameters(statement.type_parameters))
        diagnostics = (diagnostics) + (check_interface_members(statement.members))
        return ScopeResult(bindings=registration.bindings, diagnostics=diagnostics)
    if statement.variant == "ModelDeclaration":
        registration = register_local_symbol(bindings, statement.name, "model", statement.name_span)
        diagnostics = (registration.diagnostics) + (check_model_properties(statement.properties))
        return ScopeResult(bindings=registration.bindings, diagnostics=diagnostics)
    if statement.variant == "PipelineDeclaration":
        registration = register_local_symbol(bindings, statement.signature.name, "pipeline", statement.signature.name_span)
        diagnostics = registration.diagnostics
        diagnostics = (diagnostics) + (check_function_signature(statement.signature))
        diagnostics = (diagnostics) + (check_function_body(statement.signature, statement.body, interfaces))
        return ScopeResult(bindings=registration.bindings, diagnostics=diagnostics)
    if statement.variant == "ToolDeclaration":
        registration = register_local_symbol(bindings, statement.signature.name, "tool", statement.signature.name_span)
        diagnostics = registration.diagnostics
        diagnostics = (diagnostics) + (check_function_signature(statement.signature))
        diagnostics = (diagnostics) + (check_function_body(statement.signature, statement.body, interfaces))
        return ScopeResult(bindings=registration.bindings, diagnostics=diagnostics)
    if statement.variant == "TestDeclaration":
        registration = register_local_symbol(bindings, statement.name, "test", statement.name_span)
        diagnostics = (registration.diagnostics) + (check_block(statement.body, [], interfaces))
        return ScopeResult(bindings=registration.bindings, diagnostics=diagnostics)
    if statement.variant == "WithStatement":
        return ScopeResult(bindings=bindings, diagnostics=check_block(statement.body, bindings, interfaces))
    if statement.variant == "ForStatement":
        return ScopeResult(bindings=bindings, diagnostics=check_block(statement.body, bindings, interfaces))
    if statement.variant == "MatchStatement":
        diagnostics = []
        index = 0
        while True:
            if index >= len(statement.cases):
                break
            case = statement.cases[index]
            diagnostics = (diagnostics) + (check_block(case.body, bindings, interfaces))
            index += 1
        return ScopeResult(bindings=bindings, diagnostics=diagnostics)
    if statement.variant == "IfStatement":
        diagnostics = check_block(statement.then_block, bindings, interfaces)
        if statement.else_branch != None:
            branch = statement.else_branch
            if branch.body != None:
                diagnostics = (diagnostics) + (check_block(branch.body, bindings, interfaces))
            if branch.statement != None:
                result = check_statement(branch.statement, bindings, interfaces)
                diagnostics = (diagnostics) + (result.diagnostics)
        return ScopeResult(bindings=bindings, diagnostics=diagnostics)
    if statement.variant == "PromptStatement":
        return ScopeResult(bindings=bindings, diagnostics=check_block(statement.body, bindings, interfaces))
    if statement.variant == "TypeAliasDeclaration":
        registration = register_local_symbol(bindings, statement.name, "type", statement.name_span)
        diagnostics = (registration.diagnostics) + (check_type_parameters(statement.type_parameters))
        return ScopeResult(bindings=registration.bindings, diagnostics=diagnostics)
    return ScopeResult(bindings=bindings, diagnostics=[])

def check_function_body(signature, body, interfaces):
    parameter_scope = seed_parameter_scope(signature)
    body_diagnostics = check_block(body, parameter_scope.bindings, interfaces)
    return (parameter_scope.diagnostics) + (body_diagnostics)

def seed_parameter_scope(signature):
    bindings = []
    diagnostics = []
    for parameter in signature.parameters:
        registration = register_local_symbol(bindings, parameter.name, "parameter", parameter.span)
        bindings = registration.bindings
        diagnostics = (diagnostics) + (registration.diagnostics)
    return ScopeResult(bindings=bindings, diagnostics=diagnostics)

def check_block(block, parent_bindings, interfaces):
    bindings = clone_bindings(parent_bindings)
    diagnostics = []
    for statement in block.statements:
        result = check_statement(statement, bindings, interfaces)
        bindings = result.bindings
        diagnostics = (diagnostics) + (result.diagnostics)
    return diagnostics

def check_struct_implements_interfaces(statement, interfaces):
    if len(statement.implements_types) == 0:
        return []
    method_names = []
    for method in statement.methods:
        method_names = (method_names) + ([method.signature.name])
    diagnostics = []
    for annotation in statement.implements_types:
        interface_definition = resolve_interface_annotation(annotation, interfaces)
        if interface_definition == None:
            continue
        interface_name = interface_definition.name
        diagnostics = (diagnostics) + (validate_interface_annotation(statement.name, interface_definition, annotation))
        for member in interface_definition.members:
            if not contains_string(method_names, member.name):
                diagnostics = (diagnostics) + ([make_missing_interface_member_diagnostic(statement.name, interface_name, member.name)])
    return diagnostics

def resolve_interface_annotation(annotation, interfaces):
    text = annotation.text
    for interface in interfaces:
        name = interface.name
        if text == name:
            return interface
        generic_prefix = name + "<"
        if starts_with(text, generic_prefix):
            return interface
    return None

def check_struct_fields(fields):
    seen = []
    diagnostics = []
    for field in fields:
        name = field.name
        if contains_string(seen, name):
            diagnostics = (diagnostics) + ([make_duplicate_symbol_diagnostic(name, "struct field", token_from_name(name, field.name_span))])
        else:
            seen = (seen) + ([name])
    return diagnostics

def validate_interface_annotation(struct_name, interface_definition, annotation):
    expected_count = len(interface_definition.type_parameters)
    provided_arguments = parse_type_arguments(annotation.text)
    if expected_count == 0:
        if len(provided_arguments) > 0:
            return [make_interface_no_type_arguments_diagnostic(struct_name, trim_text(annotation.text), interface_definition.name)]
        return []
    if len(provided_arguments) == 0:
        return [make_interface_missing_type_arguments_diagnostic(struct_name, interface_definition.name, format_interface_signature(interface_definition))]
    if len(provided_arguments) != expected_count:
        return [make_interface_type_argument_mismatch_diagnostic(struct_name, trim_text(annotation.text), format_interface_signature(interface_definition))]
    return []

def format_interface_signature(interface_definition):
    names = []
    for parameter in interface_definition.type_parameters:
        names = (names) + ([parameter.name])
    if len(names) == 0:
        return interface_definition.name
    return interface_definition.name + "<" + join_with_separator(names, ", ") + ">"

def join_with_separator(items, separator):
    if len(items) == 0:
        return ""
    result = items[0]
    index = 1
    while True:
        if index >= len(items):
            break
        result = result + separator + items[index]
        index += 1
    return result

def parse_type_arguments(annotation_text):
    block = extract_generic_argument_block(annotation_text)
    if block == None:
        return []
    return split_generic_argument_list(block)

def extract_generic_argument_block(annotation_text):
    trimmed = trim_text(annotation_text)
    index = 0
    depth = 0
    start_index = -1
    while True:
        if index >= len(trimmed):
            break
        ch = trimmed[index]
        if ch == "<":
            if depth == 0:
                start_index = index + 1
            depth += 1
        else:
            if ch == ">":
                if depth == 0:
                    return None
                depth -= 1
                if depth == 0:
                    return slice_text(trimmed, start_index, index)
        index += 1
    return None

def split_generic_argument_list(block):
    arguments = []
    current = ""
    depth = 0
    index = 0
    while True:
        if index >= len(block):
            break
        ch = block[index]
        if ch == "<":
            depth += 1
            current = current + ch
        else:
            if ch == ">":
                if depth > 0:
                    depth -= 1
                current = current + ch
            else:
                if ch == ",":
                    if depth == 0:
                        trimmed = trim_text(current)
                        if len(trimmed) > 0:
                            arguments = (arguments) + ([trimmed])
                        current = ""
                        index += 1
                        continue
                    current = current + ch
                else:
                    current = current + ch
        index += 1
    tail = trim_text(current)
    if len(tail) > 0:
        arguments = (arguments) + ([tail])
    return arguments

def trim_text(value):
    start = 0
    end = len(value)
    while True:
        if start >= end:
            break
        if is_whitespace(value[start]):
            start += 1
            continue
        break
    while True:
        if end <= start:
            break
        if is_whitespace(value[end - 1]):
            end -= 1
            continue
        break
    return slice_text(value, start, end)

def slice_text(value, start, end):
    if start < 0:
        start = 0
    if end > len(value):
        end = len(value)
    if end <= start:
        return ""
    result = ""
    index = start
    while True:
        if index >= end:
            break
        result = result + value[index]
        index += 1
    return result

def is_whitespace(ch):
    return ch == " "  or  ch == "\n"  or  ch == "\t"  or  ch == "\r"

def check_struct_methods(methods):
    seen = []
    diagnostics = []
    for method in methods:
        diagnostics = (diagnostics) + (check_function_signature(method.signature))
        name = method.signature.name
        if contains_string(seen, name):
            diagnostics = (diagnostics) + ([make_duplicate_symbol_diagnostic(name, "method", token_from_name(name, method.signature.name_span))])
        else:
            seen = (seen) + ([name])
    return diagnostics

def check_enum_variants(variants):
    seen = []
    diagnostics = []
    for variant in variants:
        name = variant.name
        if contains_string(seen, name):
            diagnostics = (diagnostics) + ([make_duplicate_symbol_diagnostic(name, "enum variant", token_from_name(name, variant.name_span))])
        else:
            seen = (seen) + ([name])
    return diagnostics

def check_interface_members(members):
    seen = []
    diagnostics = []
    for member in members:
        diagnostics = (diagnostics) + (check_function_signature(member))
        name = member.name
        if contains_string(seen, name):
            diagnostics = (diagnostics) + ([make_duplicate_symbol_diagnostic(name, "interface member", token_from_name(name, member.name_span))])
        else:
            seen = (seen) + ([name])
    return diagnostics

def check_model_properties(properties):
    seen = []
    diagnostics = []
    for property in properties:
        name = property.name
        if contains_string(seen, name):
            diagnostics = (diagnostics) + ([make_duplicate_symbol_diagnostic(name, "model property", token_from_name(name, property.span))])
        else:
            seen = (seen) + ([name])
    return diagnostics

def check_function_signature(signature):
    return check_type_parameters(signature.type_parameters)

def check_type_parameters(type_parameters):
    seen = []
    diagnostics = []
    for type_parameter in type_parameters:
        name = type_parameter.name
        if contains_string(seen, name):
            diagnostics = (diagnostics) + ([make_duplicate_symbol_diagnostic(name, "type parameter", token_from_name(name, type_parameter.span))])
        else:
            seen = (seen) + ([name])
    return diagnostics

def build_effect_diagnostics(program):
    violations = validate_effects(program)
    diagnostics = []
    violation_index = 0
    while True:
        if violation_index >= len(violations):
            break
        violation = violations[violation_index]
        effect_index = 0
        while True:
            if effect_index >= len(violation.missing_effects):
                break
            effect = violation.missing_effects[effect_index]
            requirement = select_requirement_for_effect(violation.requirements, effect)
            diagnostics = (diagnostics) + ([Diagnostic(code="effects.missing", message=format_effect_message(violation.routine_name, effect, requirement), primary=requirement_primary_token(requirement))])
            effect_index += 1
        violation_index += 1
    return diagnostics

def select_requirement_for_effect(requirements, effect):
    index = 0
    while True:
        if index >= len(requirements):
            break
        requirement = requirements[index]
        if requirement.effect == effect:
            return requirement
        index += 1
    return None

def requirement_primary_token(requirement):
    if requirement == None:
        return None
    return requirement.origin

def format_effect_message(routine_name, effect, requirement):
    message = routine_name + " is missing effect '" + effect + "'"
    if requirement != None:
        message = message + "; required by " + requirement.description
    message = message + ". hint: add ![" + effect + "] to the signature or accept the CLI fix prompt when offered"
    return message

def contains_string(items, candidate):
    for item in items:
        if item == candidate:
            return True
    return False

def register_local_symbol(bindings, name, kind, span):
    if has_symbol(bindings, name):
        return ScopeResult(bindings=bindings, diagnostics=[make_duplicate_symbol_diagnostic(name, kind, token_from_name(name, span))])
    updated = append_symbol(bindings, name, kind, span)
    return ScopeResult(bindings=updated, diagnostics=[])

def register_symbol(name, kind, span, existing):
    if has_symbol(existing, name):
        return SymbolCollectionResult(symbols=existing, diagnostics=[make_duplicate_symbol_diagnostic(name, kind, token_from_name(name, span))])
    return SymbolCollectionResult(symbols=append_symbol(existing, name, kind, span), diagnostics=[])

def append_symbol(symbols, name, kind, span):
    updated = clone_bindings(symbols)
    return (updated) + ([SymbolEntry(name=name, kind=kind, span=span)])

def clone_bindings(source):
    copy = []
    for entry in source:
        copy = (copy) + ([entry])
    return copy

def has_symbol(symbols, name):
    for entry in symbols:
        if entry.name == name:
            return True
    return False

def make_interface_missing_type_arguments_diagnostic(struct_name, interface_name, interface_signature):
    return Diagnostic(code="E0302", message="struct " + struct_name + " implements " + interface_name + " but must specify " + interface_signature + " type arguments", primary=None)

def make_interface_type_argument_mismatch_diagnostic(struct_name, annotation_text, interface_signature):
    return Diagnostic(code="E0302", message="struct " + struct_name + " implements " + annotation_text + " but must match " + interface_signature + " type arguments", primary=None)

def make_interface_no_type_arguments_diagnostic(struct_name, annotation_text, interface_name):
    return Diagnostic(code="E0302", message="struct " + struct_name + " implements " + annotation_text + " but " + interface_name + " does not take type arguments", primary=None)

def token_from_name(name, span):
    if span == None:
        return None
    return Token(kind=runtime.enum_instantiate(TokenKind, 'Identifier', [runtime.enum_field('value', name)]), lexeme=name, line=span.start_line, column=span.start_column)

def make_duplicate_symbol_diagnostic(name, kind, token):
    return Diagnostic(code="E0001", message="duplicate " + kind + " `" + name + "` declared", primary=token)

def make_missing_interface_member_diagnostic(struct_name, interface_name, member_name):
    return Diagnostic(code="E0301", message="struct " + struct_name + " implements " + interface_name + " but is missing member `" + member_name + "`", primary=None)

def starts_with(value, prefix):
    if len(prefix) > len(value):
        return False
    index = 0
    while True:
        if index >= len(prefix):
            break
        if value[index] != prefix[index]:
            return False
        index += 1
    return True
