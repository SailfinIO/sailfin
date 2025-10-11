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
Block = getattr(__module_1, 'Block')
Decorator = getattr(__module_1, 'Decorator')
ElseBranch = getattr(__module_1, 'ElseBranch')
MatchCase = getattr(__module_1, 'MatchCase')
FunctionSignature = getattr(__module_1, 'FunctionSignature')
MethodDeclaration = getattr(__module_1, 'MethodDeclaration')
Program = getattr(__module_1, 'Program')
Statement = getattr(__module_1, 'Statement')
__module_2 = importlib.import_module('compiler.build.token')
Token = getattr(__module_2, 'Token')
__module_3 = importlib.import_module('compiler.build.decorator_semantics')
evaluate_decorators = getattr(__module_3, 'evaluate_decorators')
class EffectViolation:
    def __init__(self, routine_name, missing_effects):
        self.routine_name = routine_name
        self.missing_effects = missing_effects

def validate_effects(program):
    violations = []
    index = 0
    while True:
        if (index >= len(program.statements)):
            break
        statement = program.statements[index]
        violations = append_violations(violations, analyze_statement(statement))
        index += 1
    return violations

def analyze_statement(statement):
    if (statement.variant == 'FunctionDeclaration'):
        return analyze_routine(statement.signature, statement.body, statement.decorators, statement.signature.name)
    if (statement.variant == 'PipelineDeclaration'):
        signature = statement.signature
        qualified = ('pipeline ' + signature.name)
        return analyze_routine(signature, statement.body, statement.decorators, qualified)
    if (statement.variant == 'ToolDeclaration'):
        signature = statement.signature
        qualified = ('tool ' + signature.name)
        return analyze_routine(signature, statement.body, statement.decorators, qualified)
    if (statement.variant == 'TestDeclaration'):
        signature = FunctionSignature(name=statement.name, is_async=False, parameters=[], return_type=None, effects=statement.effects, type_parameters=[])
        qualified = ('test ' + statement.name)
        return analyze_routine(signature, statement.body, statement.decorators, qualified)
    if (statement.variant == 'StructDeclaration'):
        issues = []
        index = 0
        while True:
            if (index >= len(statement.methods)):
                break
            method = statement.methods[index]
            qualified = ((statement.name + '.') + method.signature.name)
            issues = append_violations(issues, analyze_routine(method.signature, method.body, method.decorators, qualified))
            index += 1
        return issues
    return []

def analyze_routine(signature, body, decorators, name):
    decorator_info = evaluate_decorators(decorators)
    declared = []
    declared_index = 0
    while True:
        if (declared_index >= len(signature.effects)):
            break
        declared = append_unique_effect(declared, signature.effects[declared_index])
        declared_index += 1
    requires_io_from_decorators = False
    decorator_index = 0
    while True:
        if (decorator_index >= len(decorator_info)):
            break
        decorator_entry = decorator_info[decorator_index]
        if (((decorator_entry.name == 'trace') or (decorator_entry.name == 'logExecution')) or (decorator_entry.name == 'logexecution')):
            requires_io_from_decorators = True
            break
        decorator_index += 1
    if requires_io_from_decorators:
        declared = append_unique_effect(declared, 'io')
    required = required_effects(body)
    missing = []
    index = 0
    while True:
        if (index >= len(required)):
            break
        effect = required[index]
        if ((effect == 'io') and requires_io_from_decorators):
            index += 1
            continue
        if (not contains_effect(declared, effect)):
            missing = append_unique_effect(missing, effect)
        index += 1
    if (len(missing) == 0):
        return []
    result = []
    result = append_violation(result, EffectViolation(routine_name=name, missing_effects=missing))
    return result

def required_effects(body):
    required = []
    if block_has_prompt(body):
        required = append_unique_effect(required, 'model')
    if block_contains_fs_usage(body.tokens):
        required = append_unique_effect(required, 'io')
    if block_contains_spawn_usage(body.tokens):
        required = append_unique_effect(required, 'io')
    if block_contains_network_usage(body.tokens):
        required = append_unique_effect(required, 'net')
    if block_contains_console_usage(body.tokens):
        required = append_unique_effect(required, 'io')
    if block_contains_sleep_usage(body.tokens):
        required = append_unique_effect(required, 'clock')
    return required

def block_has_prompt(block):
    if (len(block.statements) > 0):
        index = 0
        while True:
            if (index >= len(block.statements)):
                break
            statement = block.statements[index]
            if (statement.variant == 'PromptStatement'):
                return True
            if (statement.variant == 'WithStatement'):
                if block_has_prompt(statement.body):
                    return True
            if (statement.variant == 'ForStatement'):
                if block_has_prompt(statement.body):
                    return True
            if (statement.variant == 'MatchStatement'):
                if match_cases_have_prompt(statement.cases):
                    return True
            if (statement.variant == 'IfStatement'):
                if block_has_prompt(statement.then_block):
                    return True
                if (statement.else_branch != None):
                    if else_branch_has_prompt(statement.else_branch):
                        return True
            index += 1
    return block_contains_prompt(block.tokens)

def block_contains_prompt(tokens):
    index = 0
    while True:
        if (index >= len(tokens)):
            break
        token = tokens[index]
        if is_identifier_token(token, 'prompt'):
            channel_index = next_non_trivia(tokens, (index + 1))
            if (channel_index != (-1)):
                channel_token = tokens[channel_index]
                if ((channel_token.kind.variant == 'Identifier') or (channel_token.kind.variant == 'StringLiteral')):
                    brace_index = next_non_trivia(tokens, (channel_index + 1))
                    if (brace_index != (-1)):
                        brace_token = tokens[brace_index]
                        if is_symbol_token(brace_token, '{'):
                            return True
        index += 1
    return False

def block_contains_fs_usage(tokens):
    if contains_identifier_followed_by_symbol(tokens, 'fs', '.'):
        return True
    if contains_member_chain(tokens, ['runtime', 'fs']):
        return True
    return False

def block_contains_network_usage(tokens):
    if contains_identifier_followed_by_symbol(tokens, 'http', '.'):
        return True
    if contains_identifier_followed_by_symbol(tokens, 'websocket', '.'):
        return True
    if contains_identifier_call(tokens, 'serve'):
        return True
    if contains_member_chain(tokens, ['runtime', 'http']):
        return True
    if contains_member_chain(tokens, ['runtime', 'websocket']):
        return True
    if contains_member_call(tokens, ['runtime', 'serve']):
        return True
    return False

def block_contains_spawn_usage(tokens):
    if contains_identifier_call(tokens, 'spawn'):
        return True
    if contains_member_call(tokens, ['runtime', 'spawn']):
        return True
    return False

def block_contains_console_usage(tokens):
    if contains_identifier_followed_by_symbol(tokens, 'print', '.'):
        return True
    if contains_identifier_followed_by_symbol(tokens, 'console', '.'):
        return True
    if contains_member_chain(tokens, ['runtime', 'console']):
        return True
    return False

def block_contains_sleep_usage(tokens):
    if contains_identifier_call(tokens, 'sleep'):
        return True
    if contains_member_call(tokens, ['runtime', 'sleep']):
        return True
    return False

def contains_identifier_followed_by_symbol(tokens, name, symbol):
    index = 0
    while True:
        if (index >= len(tokens)):
            break
        if is_identifier_token(tokens[index], name):
            next_index = next_non_trivia(tokens, (index + 1))
            if ((next_index != (-1)) and is_symbol_token(tokens[next_index], symbol)):
                return True
        index += 1
    return False

def contains_identifier_call(tokens, name):
    index = 0
    while True:
        if (index >= len(tokens)):
            break
        if is_identifier_token(tokens[index], name):
            paren = next_non_trivia(tokens, (index + 1))
            if ((paren != (-1)) and is_symbol_token(tokens[paren], '(')):
                return True
        index += 1
    return False

def contains_member_chain(tokens, chain):
    if (len(chain) == 0):
        return False
    index = 0
    while True:
        if (index >= len(tokens)):
            break
        if is_identifier_token(tokens[index], chain[0]):
            cursor = index
            chain_index = 1
            matches = True
            while True:
                if (chain_index >= len(chain)):
                    break
                dot_index = next_non_trivia(tokens, (cursor + 1))
                if ((dot_index == (-1)) or (not is_symbol_token(tokens[dot_index], '.'))):
                    matches = False
                    break
                member_index = next_non_trivia(tokens, (dot_index + 1))
                if ((member_index == (-1)) or (not is_identifier_token(tokens[member_index], chain[chain_index]))):
                    matches = False
                    break
                cursor = member_index
                chain_index += 1
            if matches:
                return True
        index += 1
    return False

def contains_member_call(tokens, chain):
    if (len(chain) == 0):
        return False
    index = 0
    while True:
        if (index >= len(tokens)):
            break
        if is_identifier_token(tokens[index], chain[0]):
            cursor = index
            chain_index = 1
            matches = True
            while True:
                if (chain_index >= len(chain)):
                    break
                dot_index = next_non_trivia(tokens, (cursor + 1))
                if ((dot_index == (-1)) or (not is_symbol_token(tokens[dot_index], '.'))):
                    matches = False
                    break
                member_index = next_non_trivia(tokens, (dot_index + 1))
                if ((member_index == (-1)) or (not is_identifier_token(tokens[member_index], chain[chain_index]))):
                    matches = False
                    break
                cursor = member_index
                chain_index += 1
            if matches:
                call_index = next_non_trivia(tokens, (cursor + 1))
                if ((call_index != (-1)) and is_symbol_token(tokens[call_index], '(')):
                    return True
        index += 1
    return False

def next_non_trivia(tokens, start):
    index = start
    while True:
        if (index >= len(tokens)):
            break
        token = tokens[index]
        if (not is_trivia_token(token)):
            return index
        index += 1
    return (-1)

def is_trivia_token(token):
    return ((token.kind.variant == 'Whitespace') or (token.kind.variant == 'Comment'))

def is_identifier_token(token, expected):
    if (token.kind.variant == 'Identifier'):
        value = token.kind.value
        if (len(value) > 0):
            return (value == expected)
    return (token.lexeme == expected)

def is_symbol_token(token, expected):
    if (token.kind.variant == 'Symbol'):
        value = token.kind.value
        if (len(value) > 0):
            return (value == expected)
    return (token.lexeme == expected)

def append_violations(violations, new_violations):
    result = violations
    index = 0
    while True:
        if (index >= len(new_violations)):
            break
        result = list(result) + list([new_violations[index]])
        index += 1
    return result

def append_violation(collection, item):
    return list(collection) + list([item])

def append_unique_effect(effects, effect):
    if contains_effect(effects, effect):
        return effects
    return list(effects) + list([effect])

def contains_effect(effects, effect):
    index = 0
    while True:
        if (index >= len(effects)):
            break
        if (effects[index] == effect):
            return True
        index += 1
    return False

def else_branch_has_prompt(branch):
    if (branch.body != None):
        if block_has_prompt(branch.body):
            return True
    if (branch.statement != None):
        if (branch.statement.variant == 'IfStatement'):
            return if_statement_has_prompt(branch.statement)
    return False

def if_statement_has_prompt(statement):
    if (statement.variant != 'IfStatement'):
        return False
    if block_has_prompt(statement.then_block):
        return True
    if (statement.else_branch != None):
        return else_branch_has_prompt(statement.else_branch)
    return False

def match_cases_have_prompt(cases):
    index = 0
    while True:
        if (index >= len(cases)):
            break
        case = cases[index]
        if block_has_prompt(case.body):
            return True
        index += 1
    return False
