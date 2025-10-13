import asyncio
from runtime import runtime_support as runtime

from compiler.build.ast import Program, Statement, FunctionSignature, Block, FieldDeclaration, MethodDeclaration, EnumVariant, ModelProperty, TypeParameter
from compiler.build.token import Token
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
    def __init__(self, name, kind):
        self.name = name
        self.kind = kind

    def __repr__(self):
        return runtime.struct_repr('SymbolEntry', [runtime.struct_field('name', self.name), runtime.struct_field('kind', self.kind)])

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
    scoped_diagnostics = check_program_scopes(program)
    effect_diagnostics = build_effect_diagnostics(program)
    return TypecheckResult(diagnostics=(top_level.diagnostics) + ((scoped_diagnostics)) + (effect_diagnostics), symbols=top_level.symbols)

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
        return register_symbol(statement.signature.name, "function", existing)
    if statement.variant == "StructDeclaration":
        return register_symbol(statement.name, "struct", existing)
    if statement.variant == "EnumDeclaration":
        return register_symbol(statement.name, "enum", existing)
    if statement.variant == "InterfaceDeclaration":
        return register_symbol(statement.name, "interface", existing)
    if statement.variant == "ModelDeclaration":
        return register_symbol(statement.name, "model", existing)
    if statement.variant == "PipelineDeclaration":
        return register_symbol(statement.signature.name, "pipeline", existing)
    if statement.variant == "ToolDeclaration":
        return register_symbol(statement.signature.name, "tool", existing)
    if statement.variant == "TestDeclaration":
        return register_symbol(statement.name, "test", existing)
    if statement.variant == "TypeAliasDeclaration":
        return register_symbol(statement.name, "type", existing)
    if statement.variant == "VariableDeclaration":
        return register_symbol(statement.name, "variable", existing)
    return SymbolCollectionResult(symbols=existing, diagnostics=[])

def check_program_scopes(program):
    bindings = []
    diagnostics = []
    for statement in program.statements:
        result = check_statement(statement, bindings)
        bindings = result.bindings
        diagnostics = (diagnostics) + (result.diagnostics)
    return diagnostics

def check_statement(statement, bindings):
    if statement.variant == "VariableDeclaration":
        return register_local_symbol(bindings, statement.name, "variable")
    if statement.variant == "FunctionDeclaration":
        registration = register_local_symbol(bindings, statement.signature.name, "function")
        diagnostics = registration.diagnostics
        diagnostics = (diagnostics) + (check_function_signature(statement.signature))
        function_diagnostics = check_function_body(statement.signature, statement.body)
        return ScopeResult(bindings=registration.bindings, diagnostics=(diagnostics) + (function_diagnostics))
    if statement.variant == "StructDeclaration":
        registration = register_local_symbol(bindings, statement.name, "struct")
        diagnostics = registration.diagnostics
        diagnostics = (diagnostics) + (check_type_parameters(statement.type_parameters))
        diagnostics = (diagnostics) + (check_struct_fields(statement.fields))
        diagnostics = (diagnostics) + (check_struct_methods(statement.methods))
        index = 0
        while True:
            if index >= len(statement.methods):
                break
            method = statement.methods[index]
            diagnostics = (diagnostics) + (check_function_body(method.signature, method.body))
            index += 1
        return ScopeResult(bindings=registration.bindings, diagnostics=diagnostics)
    if statement.variant == "EnumDeclaration":
        registration = register_local_symbol(bindings, statement.name, "enum")
        diagnostics = registration.diagnostics
        diagnostics = (diagnostics) + (check_type_parameters(statement.type_parameters))
        diagnostics = (diagnostics) + (check_enum_variants(statement.variants))
        return ScopeResult(bindings=registration.bindings, diagnostics=diagnostics)
    if statement.variant == "InterfaceDeclaration":
        registration = register_local_symbol(bindings, statement.name, "interface")
        diagnostics = registration.diagnostics
        diagnostics = (diagnostics) + (check_type_parameters(statement.type_parameters))
        diagnostics = (diagnostics) + (check_interface_members(statement.members))
        return ScopeResult(bindings=registration.bindings, diagnostics=diagnostics)
    if statement.variant == "ModelDeclaration":
        registration = register_local_symbol(bindings, statement.name, "model")
        diagnostics = (registration.diagnostics) + (check_model_properties(statement.properties))
        return ScopeResult(bindings=registration.bindings, diagnostics=diagnostics)
    if statement.variant == "PipelineDeclaration":
        registration = register_local_symbol(bindings, statement.signature.name, "pipeline")
        diagnostics = registration.diagnostics
        diagnostics = (diagnostics) + (check_function_signature(statement.signature))
        diagnostics = (diagnostics) + (check_function_body(statement.signature, statement.body))
        return ScopeResult(bindings=registration.bindings, diagnostics=diagnostics)
    if statement.variant == "ToolDeclaration":
        registration = register_local_symbol(bindings, statement.signature.name, "tool")
        diagnostics = registration.diagnostics
        diagnostics = (diagnostics) + (check_function_signature(statement.signature))
        diagnostics = (diagnostics) + (check_function_body(statement.signature, statement.body))
        return ScopeResult(bindings=registration.bindings, diagnostics=diagnostics)
    if statement.variant == "TestDeclaration":
        registration = register_local_symbol(bindings, statement.name, "test")
        diagnostics = (registration.diagnostics) + (check_block(statement.body, []))
        return ScopeResult(bindings=registration.bindings, diagnostics=diagnostics)
    if statement.variant == "WithStatement":
        return ScopeResult(bindings=bindings, diagnostics=check_block(statement.body, bindings))
    if statement.variant == "ForStatement":
        return ScopeResult(bindings=bindings, diagnostics=check_block(statement.body, bindings))
    if statement.variant == "MatchStatement":
        diagnostics = []
        index = 0
        while True:
            if index >= len(statement.cases):
                break
            case = statement.cases[index]
            diagnostics = (diagnostics) + (check_block(case.body, bindings))
            index += 1
        return ScopeResult(bindings=bindings, diagnostics=diagnostics)
    if statement.variant == "IfStatement":
        diagnostics = check_block(statement.then_block, bindings)
        if statement.else_branch != null:
            branch = statement.else_branch
            if branch.body != null:
                diagnostics = (diagnostics) + (check_block(branch.body, bindings))
            if branch.statement != null:
                result = check_statement(branch.statement, bindings)
                diagnostics = (diagnostics) + (result.diagnostics)
        return ScopeResult(bindings=bindings, diagnostics=diagnostics)
    if statement.variant == "PromptStatement":
        return ScopeResult(bindings=bindings, diagnostics=check_block(statement.body, bindings))
    if statement.variant == "TypeAliasDeclaration":
        registration = register_local_symbol(bindings, statement.name, "type")
        diagnostics = (registration.diagnostics) + (check_type_parameters(statement.type_parameters))
        return ScopeResult(bindings=registration.bindings, diagnostics=diagnostics)
    return ScopeResult(bindings=bindings, diagnostics=[])

def check_function_body(signature, body):
    parameter_scope = seed_parameter_scope(signature)
    body_diagnostics = check_block(body, parameter_scope.bindings)
    return (parameter_scope.diagnostics) + (body_diagnostics)

def seed_parameter_scope(signature):
    bindings = []
    diagnostics = []
    for parameter in signature.parameters:
        registration = register_local_symbol(bindings, parameter.name, "parameter")
        bindings = registration.bindings
        diagnostics = (diagnostics) + (registration.diagnostics)
    return ScopeResult(bindings=bindings, diagnostics=diagnostics)

def check_block(block, parent_bindings):
    bindings = clone_bindings(parent_bindings)
    diagnostics = []
    for statement in block.statements:
        result = check_statement(statement, bindings)
        bindings = result.bindings
        diagnostics = (diagnostics) + (result.diagnostics)
    return diagnostics

def check_struct_fields(fields):
    seen = []
    diagnostics = []
    for field in fields:
        name = field.name
        if contains_string(seen, name):
            diagnostics = (diagnostics) + ([make_duplicate_symbol_diagnostic(name, "struct field")])
        else:
            seen = (seen) + ([name])
    return diagnostics

def check_struct_methods(methods):
    seen = []
    diagnostics = []
    for method in methods:
        diagnostics = (diagnostics) + (check_function_signature(method.signature))
        name = method.signature.name
        if contains_string(seen, name):
            diagnostics = (diagnostics) + ([make_duplicate_symbol_diagnostic(name, "method")])
        else:
            seen = (seen) + ([name])
    return diagnostics

def check_enum_variants(variants):
    seen = []
    diagnostics = []
    for variant in variants:
        name = variant.name
        if contains_string(seen, name):
            diagnostics = (diagnostics) + ([make_duplicate_symbol_diagnostic(name, "enum variant")])
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
            diagnostics = (diagnostics) + ([make_duplicate_symbol_diagnostic(name, "interface member")])
        else:
            seen = (seen) + ([name])
    return diagnostics

def check_model_properties(properties):
    seen = []
    diagnostics = []
    for property in properties:
        name = property.name
        if contains_string(seen, name):
            diagnostics = (diagnostics) + ([make_duplicate_symbol_diagnostic(name, "model property")])
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
            diagnostics = (diagnostics) + ([make_duplicate_symbol_diagnostic(name, "type parameter")])
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
            diagnostics = (diagnostics) + ([ Diagnostic(code="effects.missing", message=format_effect_message(violation.routine_name, effect, requirement), primary=requirement_primary_token(requirement)) ])
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
    return null

def requirement_primary_token(requirement):
    if requirement == null:
        return null
    return requirement.origin

def format_effect_message(routine_name, effect, requirement):
    message = routine_name + " is missing effect '" + effect + "'"
    if requirement != null:
        message = message + "; required by " + requirement.description
    message = message + ". hint: add ![" + effect + "] to the signature or accept the CLI fix prompt when offered"
    return message

def contains_string(items, candidate):
    for item in items:
        if item == candidate:
            return true
    return false

def register_local_symbol(bindings, name, kind):
    if has_symbol(bindings, name):
        return ScopeResult(bindings=bindings, diagnostics=[make_duplicate_symbol_diagnostic(name, kind)])
    updated = append_symbol(bindings, name, kind)
    return ScopeResult(bindings=updated, diagnostics=[])

def register_symbol(name, kind, existing):
    if has_symbol(existing, name):
        return SymbolCollectionResult(symbols=existing, diagnostics=[make_duplicate_symbol_diagnostic(name, kind)])
    return SymbolCollectionResult(symbols=append_symbol(existing, name, kind), diagnostics=[])

def append_symbol(symbols, name, kind):
    updated = clone_bindings(symbols)
    return (updated) + ([SymbolEntry(name=name, kind=kind)])

def clone_bindings(source):
    copy = []
    for entry in source:
        copy = (copy) + ([entry])
    return copy

def has_symbol(symbols, name):
    for entry in symbols:
        if entry.name == name:
            return true
    return false

def make_duplicate_symbol_diagnostic(name, kind):
    return Diagnostic(code="E0001", message="duplicate " + kind + " `" + name + "` declared", primary=null)
