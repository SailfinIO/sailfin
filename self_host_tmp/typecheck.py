import asyncio
import importlib
from bootstrap import runtime_support as runtime

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

__module_1 = importlib.import_module('compiler.build.ast')
Program = getattr(__module_1, 'Program')
Statement = getattr(__module_1, 'Statement')
FunctionSignature = getattr(__module_1, 'FunctionSignature')
Block = getattr(__module_1, 'Block')
FieldDeclaration = getattr(__module_1, 'FieldDeclaration')
MethodDeclaration = getattr(__module_1, 'MethodDeclaration')
EnumVariant = getattr(__module_1, 'EnumVariant')
ModelProperty = getattr(__module_1, 'ModelProperty')
TypeParameter = getattr(__module_1, 'TypeParameter')
__module_2 = importlib.import_module('compiler.build.token')
Token = getattr(__module_2, 'Token')
class Diagnostic:
    def __init__(self, code, message, primary):
        self.code = code
        self.message = message
        self.primary = primary

class SymbolEntry:
    def __init__(self, name, kind):
        self.name = name
        self.kind = kind

class TypecheckResult:
    def __init__(self, diagnostics, symbols):
        self.diagnostics = diagnostics
        self.symbols = symbols

class SymbolCollectionResult:
    def __init__(self, symbols, diagnostics):
        self.symbols = symbols
        self.diagnostics = diagnostics

class ScopeResult:
    def __init__(self, bindings, diagnostics):
        self.bindings = bindings
        self.diagnostics = diagnostics

def typecheck_program(program):
    top_level = collect_top_level_symbols(program)
    scoped_diagnostics = check_program_scopes(program)
    return TypecheckResult(diagnostics=list(top_level.diagnostics) + list(scoped_diagnostics), symbols=top_level.symbols)

def collect_top_level_symbols(program):
    symbols = []
    diagnostics = []
    for __item in program.statements:
        statement = __item
        result = register_top_level_symbol(statement, symbols)
        symbols = result.symbols
        diagnostics = list(diagnostics) + list(result.diagnostics)
    return SymbolCollectionResult(symbols=symbols, diagnostics=diagnostics)

def register_top_level_symbol(statement, existing):
    if (statement.variant == 'FunctionDeclaration'):
        return register_symbol(statement.signature.name, 'function', existing)
    if (statement.variant == 'StructDeclaration'):
        return register_symbol(statement.name, 'struct', existing)
    if (statement.variant == 'EnumDeclaration'):
        return register_symbol(statement.name, 'enum', existing)
    if (statement.variant == 'InterfaceDeclaration'):
        return register_symbol(statement.name, 'interface', existing)
    if (statement.variant == 'ModelDeclaration'):
        return register_symbol(statement.name, 'model', existing)
    if (statement.variant == 'PipelineDeclaration'):
        return register_symbol(statement.signature.name, 'pipeline', existing)
    if (statement.variant == 'ToolDeclaration'):
        return register_symbol(statement.signature.name, 'tool', existing)
    if (statement.variant == 'TestDeclaration'):
        return register_symbol(statement.name, 'test', existing)
    if (statement.variant == 'TypeAliasDeclaration'):
        return register_symbol(statement.name, 'type', existing)
    if (statement.variant == 'VariableDeclaration'):
        return register_symbol(statement.name, 'variable', existing)
    return SymbolCollectionResult(symbols=existing, diagnostics=[])

def check_program_scopes(program):
    bindings = []
    diagnostics = []
    for __item in program.statements:
        statement = __item
        result = check_statement(statement, bindings)
        bindings = result.bindings
        diagnostics = list(diagnostics) + list(result.diagnostics)
    return diagnostics

def check_statement(statement, bindings):
    if (statement.variant == 'VariableDeclaration'):
        return register_local_symbol(bindings, statement.name, 'variable')
    if (statement.variant == 'FunctionDeclaration'):
        registration = register_local_symbol(bindings, statement.signature.name, 'function')
        diagnostics = registration.diagnostics
        diagnostics = list(diagnostics) + list(check_function_signature(statement.signature))
        function_diagnostics = check_function_body(statement.signature, statement.body)
        return ScopeResult(bindings=registration.bindings, diagnostics=list(diagnostics) + list(function_diagnostics))
    if (statement.variant == 'StructDeclaration'):
        registration = register_local_symbol(bindings, statement.name, 'struct')
        diagnostics = registration.diagnostics
        diagnostics = list(diagnostics) + list(check_type_parameters(statement.type_parameters))
        diagnostics = list(diagnostics) + list(check_struct_fields(statement.fields))
        diagnostics = list(diagnostics) + list(check_struct_methods(statement.methods))
        index = 0
        while True:
            if (index >= len(statement.methods)):
                break
            method = statement.methods[index]
            diagnostics = list(diagnostics) + list(check_function_body(method.signature, method.body))
            index += 1
        return ScopeResult(bindings=registration.bindings, diagnostics=diagnostics)
    if (statement.variant == 'EnumDeclaration'):
        registration = register_local_symbol(bindings, statement.name, 'enum')
        diagnostics = registration.diagnostics
        diagnostics = list(diagnostics) + list(check_type_parameters(statement.type_parameters))
        diagnostics = list(diagnostics) + list(check_enum_variants(statement.variants))
        return ScopeResult(bindings=registration.bindings, diagnostics=diagnostics)
    if (statement.variant == 'InterfaceDeclaration'):
        registration = register_local_symbol(bindings, statement.name, 'interface')
        diagnostics = registration.diagnostics
        diagnostics = list(diagnostics) + list(check_type_parameters(statement.type_parameters))
        diagnostics = list(diagnostics) + list(check_interface_members(statement.members))
        return ScopeResult(bindings=registration.bindings, diagnostics=diagnostics)
    if (statement.variant == 'ModelDeclaration'):
        registration = register_local_symbol(bindings, statement.name, 'model')
        diagnostics = list(registration.diagnostics) + list(check_model_properties(statement.properties))
        return ScopeResult(bindings=registration.bindings, diagnostics=diagnostics)
    if (statement.variant == 'PipelineDeclaration'):
        registration = register_local_symbol(bindings, statement.signature.name, 'pipeline')
        diagnostics = registration.diagnostics
        diagnostics = list(diagnostics) + list(check_function_signature(statement.signature))
        diagnostics = list(diagnostics) + list(check_function_body(statement.signature, statement.body))
        return ScopeResult(bindings=registration.bindings, diagnostics=diagnostics)
    if (statement.variant == 'ToolDeclaration'):
        registration = register_local_symbol(bindings, statement.signature.name, 'tool')
        diagnostics = registration.diagnostics
        diagnostics = list(diagnostics) + list(check_function_signature(statement.signature))
        diagnostics = list(diagnostics) + list(check_function_body(statement.signature, statement.body))
        return ScopeResult(bindings=registration.bindings, diagnostics=diagnostics)
    if (statement.variant == 'TestDeclaration'):
        registration = register_local_symbol(bindings, statement.name, 'test')
        diagnostics = list(registration.diagnostics) + list(check_block(statement.body, []))
        return ScopeResult(bindings=registration.bindings, diagnostics=diagnostics)
    if (statement.variant == 'WithStatement'):
        return ScopeResult(bindings=bindings, diagnostics=check_block(statement.body, bindings))
    if (statement.variant == 'ForStatement'):
        return ScopeResult(bindings=bindings, diagnostics=check_block(statement.body, bindings))
    if (statement.variant == 'MatchStatement'):
        diagnostics = []
        index = 0
        while True:
            if (index >= len(statement.cases)):
                break
            case = statement.cases[index]
            diagnostics = list(diagnostics) + list(check_block(case.body, bindings))
            index += 1
        return ScopeResult(bindings=bindings, diagnostics=diagnostics)
    if (statement.variant == 'IfStatement'):
        diagnostics = check_block(statement.then_block, bindings)
        if (statement.else_branch != None):
            branch = statement.else_branch
            if (branch.body != None):
                diagnostics = list(diagnostics) + list(check_block(branch.body, bindings))
            if (branch.statement != None):
                result = check_statement(branch.statement, bindings)
                diagnostics = list(diagnostics) + list(result.diagnostics)
        return ScopeResult(bindings=bindings, diagnostics=diagnostics)
    if (statement.variant == 'PromptStatement'):
        return ScopeResult(bindings=bindings, diagnostics=check_block(statement.body, bindings))
    if (statement.variant == 'TypeAliasDeclaration'):
        registration = register_local_symbol(bindings, statement.name, 'type')
        diagnostics = list(registration.diagnostics) + list(check_type_parameters(statement.type_parameters))
        return ScopeResult(bindings=registration.bindings, diagnostics=diagnostics)
    return ScopeResult(bindings=bindings, diagnostics=[])

def check_function_body(signature, body):
    parameter_scope = seed_parameter_scope(signature)
    body_diagnostics = check_block(body, parameter_scope.bindings)
    return list(parameter_scope.diagnostics) + list(body_diagnostics)

def seed_parameter_scope(signature):
    bindings = []
    diagnostics = []
    for __item in signature.parameters:
        parameter = __item
        registration = register_local_symbol(bindings, parameter.name, 'parameter')
        bindings = registration.bindings
        diagnostics = list(diagnostics) + list(registration.diagnostics)
    return ScopeResult(bindings=bindings, diagnostics=diagnostics)

def check_block(block, parent_bindings):
    bindings = clone_bindings(parent_bindings)
    diagnostics = []
    for __item in block.statements:
        statement = __item
        result = check_statement(statement, bindings)
        bindings = result.bindings
        diagnostics = list(diagnostics) + list(result.diagnostics)
    return diagnostics

def check_struct_fields(fields):
    seen = []
    diagnostics = []
    for __item in fields:
        field = __item
        name = field.name
        if contains_string(seen, name):
            diagnostics.append(make_duplicate_symbol_diagnostic(name, 'struct field'))
        else:
            seen.append(name)
    return diagnostics

def check_struct_methods(methods):
    seen = []
    diagnostics = []
    for __item in methods:
        method = __item
        diagnostics = list(diagnostics) + list(check_function_signature(method.signature))
        name = method.signature.name
        if contains_string(seen, name):
            diagnostics.append(make_duplicate_symbol_diagnostic(name, 'method'))
        else:
            seen.append(name)
    return diagnostics

def check_enum_variants(variants):
    seen = []
    diagnostics = []
    for __item in variants:
        variant = __item
        name = variant.name
        if contains_string(seen, name):
            diagnostics.append(make_duplicate_symbol_diagnostic(name, 'enum variant'))
        else:
            seen.append(name)
    return diagnostics

def check_interface_members(members):
    seen = []
    diagnostics = []
    for __item in members:
        member = __item
        diagnostics = list(diagnostics) + list(check_function_signature(member))
        name = member.name
        if contains_string(seen, name):
            diagnostics.append(make_duplicate_symbol_diagnostic(name, 'interface member'))
        else:
            seen.append(name)
    return diagnostics

def check_model_properties(properties):
    seen = []
    diagnostics = []
    for __item in properties:
        property = __item
        name = property.name
        if contains_string(seen, name):
            diagnostics.append(make_duplicate_symbol_diagnostic(name, 'model property'))
        else:
            seen.append(name)
    return diagnostics

def check_function_signature(signature):
    return check_type_parameters(signature.type_parameters)

def check_type_parameters(type_parameters):
    seen = []
    diagnostics = []
    for __item in type_parameters:
        type_parameter = __item
        name = type_parameter.name
        if contains_string(seen, name):
            diagnostics.append(make_duplicate_symbol_diagnostic(name, 'type parameter'))
        else:
            seen.append(name)
    return diagnostics

def contains_string(items, candidate):
    for __item in items:
        item = __item
        if (item == candidate):
            return True
    return False

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
    updated.append(SymbolEntry(name=name, kind=kind))
    return updated

def clone_bindings(source):
    copy = []
    for __item in source:
        entry = __item
        copy.append(entry)
    return copy

def has_symbol(symbols, name):
    for __item in symbols:
        entry = __item
        if (entry.name == name):
            return True
    return False

def make_duplicate_symbol_diagnostic(name, kind):
    return Diagnostic(code='E0001', message=(((('duplicate ' + kind) + ' `') + name) + '` declared'), primary=None)
