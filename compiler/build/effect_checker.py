import asyncio
from runtime import runtime_support as runtime

from compiler.build.ast import Block, Decorator, ElseBranch, Expression, MatchCase, FunctionSignature, MethodDeclaration, Program, Statement
from compiler.build.token import Token
from compiler.build.decorator_semantics import evaluate_decorators

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

class EffectRequirement:
    def __init__(self, effect, description, origin=None):
        self.effect = effect
        self.origin = origin
        self.description = description

    def __repr__(self):
        return runtime.struct_repr('EffectRequirement', [runtime.struct_field('effect', self.effect), runtime.struct_field('origin', self.origin), runtime.struct_field('description', self.description)])

class EffectViolation:
    def __init__(self, routine_name, missing_effects, requirements):
        self.routine_name = routine_name
        self.missing_effects = missing_effects
        self.requirements = requirements

    def __repr__(self):
        return runtime.struct_repr('EffectViolation', [runtime.struct_field('routine_name', self.routine_name), runtime.struct_field('missing_effects', self.missing_effects), runtime.struct_field('requirements', self.requirements)])

def validate_effects(program):
    violations = []
    index = 0
    while True:
        if index >= len(program.statements):
            break
        statement = program.statements[index]
        violations = append_violations(violations, analyze_statement(statement))
        index += 1
    return violations

def analyze_statement(statement):
    if statement.variant == "FunctionDeclaration":
        return analyze_routine(statement.signature, statement.body, statement.decorators, statement.signature.name)
    if statement.variant == "PipelineDeclaration":
        signature = statement.signature
        qualified = "pipeline " + signature.name
        return analyze_routine(signature, statement.body, statement.decorators, qualified)
    if statement.variant == "ToolDeclaration":
        signature = statement.signature
        qualified = "tool " + signature.name
        return analyze_routine(signature, statement.body, statement.decorators, qualified)
    if statement.variant == "TestDeclaration":
        signature = FunctionSignature(name=statement.name, is_async=False, parameters=[], return_type=None, effects=statement.effects, type_parameters=[])
        qualified = "test " + statement.name
        return analyze_routine(signature, statement.body, statement.decorators, qualified)
    if statement.variant == "StructDeclaration":
        issues = []
        index = 0
        while True:
            if index >= len(statement.methods):
                break
            method = statement.methods[index]
            qualified = statement.name + "." + method.signature.name
            issues = append_violations( issues, analyze_routine(method.signature, method.body, method.decorators, qualified) )
            index += 1
        return issues
    return []

def analyze_routine(signature, body, decorators, name):
    decorator_info = evaluate_decorators(decorators)
    declared = []
    declared_index = 0
    while True:
        if declared_index >= len(signature.effects):
            break
        declared = append_unique_effect(declared, signature.effects[declared_index])
        declared_index += 1
    requires_io_from_decorators = False
    decorator_index = 0
    while True:
        if decorator_index >= len(decorator_info):
            break
        decorator_entry = decorator_info[decorator_index]
        if decorator_entry.name == "trace"  or  decorator_entry.name == "logExecution"  or  decorator_entry.name == "logexecution":
            requires_io_from_decorators = True
            break
        decorator_index += 1
    if requires_io_from_decorators:
        declared = append_unique_effect(declared, "io")
    required = required_effects(body)
    missing = []
    missing_requirements = []
    index = 0
    while True:
        if index >= len(required):
            break
        requirement = required[index]
        effect = requirement.effect
        if effect == "io"  and  requires_io_from_decorators:
            index += 1
            continue
        if contains_effect(declared, effect):
            index += 1
            continue
        missing = append_unique_effect(missing, effect)
        if not contains_requirement_for_effect(missing_requirements, effect):
            missing_requirements = append_requirement(missing_requirements, requirement)
        index += 1
    if len(missing) == 0:
        return []
    result = []
    result = append_violation( result, EffectViolation(routine_name=name, missing_effects=missing, requirements=missing_requirements) )
    return result

def required_effects(body):
    return collect_effects_from_block(body)

def collect_effects_from_block(block):
    required = collect_effects_from_tokens(block.tokens)
    index = 0
    while True:
        if index >= len(block.statements):
            break
        required = merge_requirements(required, collect_effects_from_statement(block.statements[index]))
        index += 1
    return required

def collect_effects_from_statement(statement):
    if statement.variant == "PromptStatement":
        required = collect_effects_from_block(statement.body)
        required = append_requirement( required, EffectRequirement(effect="model", origin=statement.keyword_token, description="prompt \"" + statement.channel + "\"") )
        return required
    if statement.variant == "WithStatement":
        required = collect_effects_from_block(statement.body)
        clause_index = 0
        while True:
            if clause_index >= len(statement.clauses):
                break
            clause = statement.clauses[clause_index]
            required = merge_requirements(required, collect_effects_from_expression(clause.expression))
            clause_index += 1
        return required
    if statement.variant == "ForStatement":
        required = collect_effects_from_block(statement.body)
        if statement.clause.target != None:
            required = merge_requirements(required, collect_effects_from_expression(statement.clause.target))
        required = merge_requirements(required, collect_effects_from_expression(statement.clause.iterable))
        return required
    if statement.variant == "LoopStatement":
        return collect_effects_from_block(statement.body)
    if statement.variant == "MatchStatement":
        required = collect_effects_from_expression(statement.expression)
        case_index = 0
        while True:
            if case_index >= len(statement.cases):
                break
            required = merge_requirements(required, collect_effects_from_match_case(statement.cases[case_index]))
            case_index += 1
        return required
    if statement.variant == "IfStatement":
        required = collect_effects_from_expression(statement.condition)
        required = merge_requirements(required, collect_effects_from_block(statement.then_block))
        if statement.else_branch != None:
            required = merge_requirements(required, collect_effects_from_else_branch(statement.else_branch))
        return required
    if statement.variant == "ReturnStatement":
        return collect_effects_from_expression(statement.expression)
    if statement.variant == "ExpressionStatement":
        return collect_effects_from_expression(statement.expression)
    if statement.variant == "VariableDeclaration":
        return collect_effects_from_expression(statement.initializer)
    if statement.variant == "FunctionDeclaration":
        return collect_effects_from_block(statement.body)
    if statement.variant == "PipelineDeclaration":
        return collect_effects_from_block(statement.body)
    if statement.variant == "ToolDeclaration":
        return collect_effects_from_block(statement.body)
    if statement.variant == "TestDeclaration":
        return collect_effects_from_block(statement.body)
    if statement.variant == "StructDeclaration":
        required = []
        method_index = 0
        while True:
            if method_index >= len(statement.methods):
                break
            required = merge_requirements(required, collect_effects_from_block(statement.methods[method_index].body))
            method_index += 1
        return required
    if statement.variant == "ModelDeclaration":
        required = []
        property_index = 0
        while True:
            if property_index >= len(statement.properties):
                break
            required = merge_requirements(required, collect_effects_from_expression(statement.properties[property_index].value))
            property_index += 1
        return required
    if statement.variant == "Unknown":
        return collect_effects_from_tokens(statement.tokens)
    return []

def collect_effects_from_else_branch(branch):
    required = []
    if branch.body != None:
        required = merge_requirements(required, collect_effects_from_block(branch.body))
    if branch.statement != None:
        required = merge_requirements(required, collect_effects_from_statement(branch.statement))
    return required

def collect_effects_from_match_case(case):
    required = collect_effects_from_expression(case.pattern)
    if case.guard != None:
        required = merge_requirements(required, collect_effects_from_expression(case.guard))
    required = merge_requirements(required, collect_effects_from_block(case.body))
    return required

def collect_effects_from_expression(expression):
    if expression == None:
        return []
    if expression.variant == "Call":
        required = collect_effects_from_expression(expression.callee)
        argument_index = 0
        while True:
            if argument_index >= len(expression.arguments):
                break
            required = merge_requirements(required, collect_effects_from_expression(expression.arguments[argument_index]))
            argument_index += 1
        return required
    if expression.variant == "Member":
        return collect_effects_from_expression(expression.object)
    if expression.variant == "Unary":
        return collect_effects_from_expression(expression.operand)
    if expression.variant == "Binary":
        required = collect_effects_from_expression(expression.left)
        required = merge_requirements(required, collect_effects_from_expression(expression.right))
        return required
    if expression.variant == "Array":
        required = []
        element_index = 0
        while True:
            if element_index >= len(expression.elements):
                break
            required = merge_requirements(required, collect_effects_from_expression(expression.elements[element_index]))
            element_index += 1
        return required
    if expression.variant == "Object":
        required = []
        field_index = 0
        while True:
            if field_index >= len(expression.fields):
                break
            required = merge_requirements(required, collect_effects_from_expression(expression.fields[field_index].value))
            field_index += 1
        return required
    if expression.variant == "Struct":
        required = []
        field_index = 0
        while True:
            if field_index >= len(expression.fields):
                break
            required = merge_requirements(required, collect_effects_from_expression(expression.fields[field_index].value))
            field_index += 1
        return required
    if expression.variant == "Lambda":
        return collect_effects_from_block(expression.body)
    if expression.variant == "Index":
        required = collect_effects_from_expression(expression.sequence)
        required = merge_requirements(required, collect_effects_from_expression(expression.index))
        return required
    if expression.variant == "Range":
        required = collect_effects_from_expression(expression.start)
        required = merge_requirements(required, collect_effects_from_expression(expression.end))
        return required
    if expression.variant == "Raw":
        return []
    return []

def collect_effects_from_tokens(tokens):
    required = []
    required = append_prompt_effect(required, tokens)
    required = append_identifier_dot_effect(required, tokens, "fs", "io", "filesystem helper usage")
    required = append_identifier_dot_effect(required, tokens, "print", "io", "print helper usage")
    required = append_identifier_dot_effect(required, tokens, "console", "io", "console helper usage")
    required = append_identifier_dot_effect(required, tokens, "http", "net", "http helper usage")
    required = append_identifier_dot_effect(required, tokens, "websocket", "net", "websocket helper usage")
    required = append_identifier_call_effect(required, tokens, "spawn", "io", "spawn call")
    required = append_identifier_call_effect(required, tokens, "serve", "net", "serve call")
    required = append_identifier_call_effect(required, tokens, "sleep", "clock", "sleep call")
    return required

def append_prompt_effect(requirements, tokens):
    result = requirements
    index = 0
    while True:
        if index >= len(tokens):
            break
        token = tokens[index]
        if is_identifier_token(token, "prompt"):
            channel_index = next_non_trivia(tokens, index + 1)
            description = "prompt block"
            if channel_index != -1:
                channel_token = tokens[channel_index]
                if channel_token.kind.variant == "Identifier"  or  channel_token.kind.variant == "StringLiteral":
                    description = "prompt " + channel_token.lexeme
                    brace_index = next_non_trivia(tokens, channel_index + 1)
                    if brace_index != -1  and  is_symbol_token(tokens[brace_index], "{"):
                        result = append_requirement( result, EffectRequirement(effect="model", origin=token, description=description) )
                        index += 1
                        continue
            result = append_requirement( result, EffectRequirement(effect="model", origin=token, description=description) )
        index += 1
    return result

def append_identifier_dot_effect(requirements, tokens, identifier, effect, description):
    matches = find_identifier_followed_by_symbol(tokens, identifier, ".")
    result = requirements
    index = 0
    while True:
        if index >= len(matches):
            break
        result = append_requirement( result, EffectRequirement(effect=effect, origin=matches[index], description=description) )
        index += 1
    return result

def append_identifier_call_effect(requirements, tokens, identifier, effect, description):
    matches = find_identifier_call(tokens, identifier)
    result = requirements
    index = 0
    while True:
        if index >= len(matches):
            break
        result = append_requirement( result, EffectRequirement(effect=effect, origin=matches[index], description=description) )
        index += 1
    return result

def find_identifier_followed_by_symbol(tokens, name, symbol):
    matches = []
    index = 0
    while True:
        if index >= len(tokens):
            break
        if is_identifier_token(tokens[index], name):
            next_index = next_non_trivia(tokens, index + 1)
            if next_index != -1  and  is_symbol_token(tokens[next_index], symbol):
                matches = (matches) + ([tokens[index]])
        index += 1
    return matches

def find_identifier_call(tokens, name):
    matches = []
    index = 0
    while True:
        if index >= len(tokens):
            break
        if is_identifier_token(tokens[index], name):
            paren = next_non_trivia(tokens, index + 1)
            if paren != -1  and  is_symbol_token(tokens[paren], "("):
                matches = (matches) + ([tokens[index]])
        index += 1
    return matches

def next_non_trivia(tokens, start):
    index = start
    while True:
        if index >= len(tokens):
            break
        token = tokens[index]
        if not is_trivia_token(token):
            return index
        index += 1
    return -1

def is_trivia_token(token):
    return token.kind.variant == "Whitespace"  or  token.kind.variant == "Comment"

def is_identifier_token(token, expected):
    if token.kind.variant == "Identifier":
        value = token.kind.value
        if len(value) > 0:
            return value == expected
    return token.lexeme == expected

def is_symbol_token(token, expected):
    if token.kind.variant == "Symbol":
        value = token.kind.value
        if len(value) > 0:
            return value == expected
    return token.lexeme == expected

def append_violations(violations, new_violations):
    result = violations
    index = 0
    while True:
        if index >= len(new_violations):
            break
        result = (result) + ([new_violations[index]])
        index += 1
    return result

def append_violation(collection, item):
    return (collection) + ([item])

def append_unique_effect(effects, effect):
    if contains_effect(effects, effect):
        return effects
    return (effects) + ([effect])

def contains_effect(effects, effect):
    index = 0
    while True:
        if index >= len(effects):
            break
        if effects[index] == effect:
            return True
        index += 1
    return False

def append_requirement(collection, item):
    return (collection) + ([item])

def merge_requirements(base, additions):
    result = base
    index = 0
    while True:
        if index >= len(additions):
            break
        result = (result) + ([additions[index]])
        index += 1
    return result

def contains_requirement_for_effect(requirements, effect):
    index = 0
    while True:
        if index >= len(requirements):
            break
        if requirements[index].effect == effect:
            return True
        index += 1
    return False
