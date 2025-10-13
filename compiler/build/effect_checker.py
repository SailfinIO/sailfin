import asyncio
from runtime import runtime_support as runtime

from compiler.build.ast import Block, Decorator, ElseBranch, MatchCase, FunctionSignature, MethodDeclaration, Program, Statement
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

class EffectViolation:
    def __init__(self, routine_name, missing_effects):
        self.routine_name = routine_name
        self.missing_effects = missing_effects

    def __repr__(self):
        return runtime.struct_repr('EffectViolation', [runtime.struct_field('routine_name', self.routine_name), runtime.struct_field('missing_effects', self.missing_effects)])

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
        signature = FunctionSignature(name=statement.name, is_async=false, parameters=[], return_type=null, effects=statement.effects, type_parameters=[])
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
    requires_io_from_decorators = false
    decorator_index = 0
    while True:
        if decorator_index >= len(decorator_info):
            break
        decorator_entry = decorator_info[decorator_index]
        if decorator_entry.name == "trace"  or  decorator_entry.name == "logExecution"  or  decorator_entry.name == "logexecution":
            requires_io_from_decorators = true
            break
        decorator_index += 1
    if requires_io_from_decorators:
        declared = append_unique_effect(declared, "io")
    required = required_effects(body)
    missing = []
    index = 0
    while True:
        if index >= len(required):
            break
        effect = required[index]
        if effect == "io"  and  requires_io_from_decorators:
            index += 1
            continue
        if not contains_effect(declared, effect):
            missing = append_unique_effect(missing, effect)
        index += 1
    if len(missing) == 0:
        return []
    result = []
    result = append_violation(result, EffectViolation(routine_name=name, missing_effects=missing))
    return result

def required_effects(body):
    required = []
    if block_has_prompt(body):
        required = append_unique_effect(required, "model")
    if block_contains_fs_usage(body.tokens):
        required = append_unique_effect(required, "io")
    if block_contains_spawn_usage(body.tokens):
        required = append_unique_effect(required, "io")
    if block_contains_network_usage(body.tokens):
        required = append_unique_effect(required, "net")
    if block_contains_console_usage(body.tokens):
        required = append_unique_effect(required, "io")
    if block_contains_sleep_usage(body.tokens):
        required = append_unique_effect(required, "clock")
    return required

def block_has_prompt(block):
    if len(block.statements) > 0:
        index = 0
        while True:
            if index >= len(block.statements):
                break
            statement = block.statements[index]
            if statement.variant == "PromptStatement":
                return true
            if statement.variant == "WithStatement":
                if block_has_prompt(statement.body):
                    return true
            if statement.variant == "ForStatement":
                if block_has_prompt(statement.body):
                    return true
            if statement.variant == "MatchStatement":
                if match_cases_have_prompt(statement.cases):
                    return true
            if statement.variant == "IfStatement":
                if block_has_prompt(statement.then_block):
                    return true
                if statement.else_branch != null:
                    if else_branch_has_prompt(statement.else_branch):
                        return true
            index += 1
    return block_contains_prompt(block.tokens)

def block_contains_prompt(tokens):
    index = 0
    while True:
        if index >= len(tokens):
            break
        token = tokens[index]
        if is_identifier_token(token, "prompt"):
            channel_index = next_non_trivia(tokens, index + 1)
            if channel_index != -1:
                channel_token = tokens[channel_index]
                if channel_token.kind.variant == "Identifier"  or  channel_token.kind.variant == "StringLiteral":
                    brace_index = next_non_trivia(tokens, channel_index + 1)
                    if brace_index != -1:
                        brace_token = tokens[brace_index]
                        if is_symbol_token(brace_token, "{"):
                            return true
        index += 1
    return false

def block_contains_fs_usage(tokens):
    if contains_identifier_followed_by_symbol(tokens, "fs", "."):
        return true
    if contains_member_chain(tokens, ["runtime", "fs"]):
        return true
    return false

def block_contains_network_usage(tokens):
    if contains_identifier_followed_by_symbol(tokens, "http", "."):
        return true
    if contains_identifier_followed_by_symbol(tokens, "websocket", "."):
        return true
    if contains_identifier_call(tokens, "serve"):
        return true
    if contains_member_chain(tokens, ["runtime", "http"]):
        return true
    if contains_member_chain(tokens, ["runtime", "websocket"]):
        return true
    if contains_member_call(tokens, ["runtime", "serve"]):
        return true
    return false

def block_contains_spawn_usage(tokens):
    if contains_identifier_call(tokens, "spawn"):
        return true
    if contains_member_call(tokens, ["runtime", "spawn"]):
        return true
    return false

def block_contains_console_usage(tokens):
    if contains_identifier_followed_by_symbol(tokens, "print", "."):
        return true
    if contains_identifier_followed_by_symbol(tokens, "console", "."):
        return true
    if contains_member_chain(tokens, ["runtime", "console"]):
        return true
    return false

def block_contains_sleep_usage(tokens):
    if contains_identifier_call(tokens, "sleep"):
        return true
    if contains_member_call(tokens, ["runtime", "sleep"]):
        return true
    return false

def contains_identifier_followed_by_symbol(tokens, name, symbol):
    index = 0
    while True:
        if index >= len(tokens):
            break
        if is_identifier_token(tokens[index], name):
            next_index = next_non_trivia(tokens, index + 1)
            if next_index != -1  and  is_symbol_token(tokens[next_index], symbol):
                return true
        index += 1
    return false

def contains_identifier_call(tokens, name):
    index = 0
    while True:
        if index >= len(tokens):
            break
        if is_identifier_token(tokens[index], name):
            paren = next_non_trivia(tokens, index + 1)
            if paren != -1  and  is_symbol_token(tokens[paren], "("):
                return true
        index += 1
    return false

def contains_member_chain(tokens, chain):
    if len(chain) == 0:
        return false
    index = 0
    while True:
        if index >= len(tokens):
            break
        if is_identifier_token(tokens[index], chain[0]):
            cursor = index
            chain_index = 1
            matches = true
            while True:
                if chain_index >= len(chain):
                    break
                dot_index = next_non_trivia(tokens, cursor + 1)
                if dot_index == -1  or  not is_symbol_token(tokens[dot_index], "."):
                    matches = false
                    break
                member_index = next_non_trivia(tokens, dot_index + 1)
                if member_index == -1  or  not is_identifier_token(tokens[member_index], chain[chain_index]):
                    matches = false
                    break
                cursor = member_index
                chain_index += 1
            if matches:
                return true
        index += 1
    return false

def contains_member_call(tokens, chain):
    if len(chain) == 0:
        return false
    index = 0
    while True:
        if index >= len(tokens):
            break
        if is_identifier_token(tokens[index], chain[0]):
            cursor = index
            chain_index = 1
            matches = true
            while True:
                if chain_index >= len(chain):
                    break
                dot_index = next_non_trivia(tokens, cursor + 1)
                if dot_index == -1  or  not is_symbol_token(tokens[dot_index], "."):
                    matches = false
                    break
                member_index = next_non_trivia(tokens, dot_index + 1)
                if member_index == -1  or  not is_identifier_token(tokens[member_index], chain[chain_index]):
                    matches = false
                    break
                cursor = member_index
                chain_index += 1
            if matches:
                call_index = next_non_trivia(tokens, cursor + 1)
                if call_index != -1  and  is_symbol_token(tokens[call_index], "("):
                    return true
        index += 1
    return false

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
            return true
        index += 1
    return false

def else_branch_has_prompt(branch):
    if branch.body != null:
        if block_has_prompt(branch.body):
            return true
    if branch.statement != null:
        if branch.statement.variant == "IfStatement":
            return if_statement_has_prompt(branch.statement)
    return false

def if_statement_has_prompt(statement):
    if statement.variant != "IfStatement":
        return false
    if block_has_prompt(statement.then_block):
        return true
    if statement.else_branch != null:
        return else_branch_has_prompt(statement.else_branch)
    return false

def match_cases_have_prompt(cases):
    index = 0
    while True:
        if index >= len(cases):
            break
        case = cases[index]
        if block_has_prompt(case.body):
            return true
        index += 1
    return false
