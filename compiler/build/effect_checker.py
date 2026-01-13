import asyncio
from runtime import runtime_support as runtime

from compiler.build.ast import Block, Decorator, ElseBranch, Expression, MatchCase, FunctionSignature, MethodDeclaration, Program, Statement, decorator_names
from compiler.build.string_utils import substring

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


class EffectRequirement:
    def __init__(self, effect, description):
        self.effect = effect
        self.description = description

    def __repr__(self):
        return runtime.struct_repr('EffectRequirement', [runtime.struct_field('effect', self.effect), runtime.struct_field('description', self.description)])


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
        violations = append_violations(
            violations, analyze_statement(program.statements[index]))
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
        signature = FunctionSignature(name=statement.name, is_async=False, parameters=[
        ], return_type=None, effects=statement.effects, type_parameters=[], name_span=None)
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
            issues = append_violations(
                issues,
                analyze_routine(method.signature, method.body,
                                method.decorators, qualified)
            )
            index += 1
        return issues
    return []


def analyze_routine(signature, body, decorators, name):
    names = decorator_names(decorators)
    declared = []
    declared_index = 0
    while True:
        if declared_index >= len(signature.effects):
            break
        declared = append_unique_effect(
            declared, signature.effects[declared_index])
        declared_index += 1
    requires_io_from_decorators = False
    decorator_index = 0
    while True:
        if decorator_index >= len(names):
            break
        decorator_name = names[decorator_index]
        if decorator_name == "trace" or decorator_name == "logExecution" or decorator_name == "logexecution":
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
        if effect == "io" and requires_io_from_decorators:
            index += 1
            continue
        if contains_effect(declared, effect):
            index += 1
            continue
        missing = append_unique_effect(missing, effect)
        if not contains_requirement_for_effect(missing_requirements, effect):
            missing_requirements = append_requirement(
                missing_requirements, requirement)
        index += 1
    if len(missing) == 0:
        return []
    result = []
    result = append_violation(
        result,
        EffectViolation(routine_name=name, missing_effects=missing,
                        requirements=missing_requirements)
    )
    return result


def required_effects(body):
    return collect_effects_from_block(body)


def collect_effects_from_block(block):
    required = []
    index = 0
    while True:
        if index >= len(block.statements):
            break
        required = merge_requirements(
            required, collect_effects_from_statement(block.statements[index]))
        index += 1
    return required


def collect_effects_from_optional_block(block):
    if block == None:
        return []
    return collect_effects_from_block(block)


def collect_effects_from_optional_statement(statement):
    if statement == None:
        return []
    return collect_effects_from_statement(statement)


def collect_effects_from_statement(statement):
    if statement.variant == "PromptStatement":
        required = collect_effects_from_block(statement.body)
        required = append_requirement(
            required,
            EffectRequirement(
                effect="model", description="prompt \"" + statement.channel + "\"")
        )
        return required
    if statement.variant == "WithStatement":
        required = collect_effects_from_block(statement.body)
        clause_index = 0
        while True:
            if clause_index >= len(statement.clauses):
                break
            clause = statement.clauses[clause_index]
            required = merge_requirements(
                required, collect_effects_from_expression(clause.expression))
            clause_index += 1
        return required
    if statement.variant == "ForStatement":
        required = collect_effects_from_block(statement.body)
        required = merge_requirements(
            required, collect_effects_from_expression(statement.clause.target))
        required = merge_requirements(
            required, collect_effects_from_expression(statement.clause.iterable))
        return required
    if statement.variant == "LoopStatement":
        return collect_effects_from_block(statement.body)
    if statement.variant == "MatchStatement":
        required = collect_effects_from_expression(statement.expression)
        case_index = 0
        while True:
            if case_index >= len(statement.cases):
                break
            required = merge_requirements(
                required, collect_effects_from_match_case(statement.cases[case_index]))
            case_index += 1
        return required
    if statement.variant == "IfStatement":
        required = collect_effects_from_expression(statement.condition)
        required = merge_requirements(
            required, collect_effects_from_block(statement.then_block))
        else_branch = statement.else_branch
        if else_branch == None:
            return required
        required = merge_requirements(
            required, collect_effects_from_else_branch(else_branch))
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
            required = merge_requirements(required, collect_effects_from_block(
                statement.methods[method_index].body))
            method_index += 1
        return required
    if statement.variant == "ModelDeclaration":
        required = []
        property_index = 0
        while True:
            if property_index >= len(statement.properties):
                break
            required = merge_requirements(required, collect_effects_from_expression(
                statement.properties[property_index].value))
            property_index += 1
        return required
    if statement.variant == "Unknown":
        return collect_effects_from_text(statement.text)
    return []


def collect_effects_from_else_branch(branch):
    required = []
    required = merge_requirements(
        required, collect_effects_from_optional_block(branch.body))
    required = merge_requirements(
        required, collect_effects_from_optional_statement(branch.statement))
    return required


def collect_effects_from_match_case(case):
    required = collect_effects_from_expression(case.pattern)
    required = merge_requirements(
        required, collect_effects_from_expression(case.guard))
    required = merge_requirements(
        required, collect_effects_from_block(case.body))
    return required


def collect_effects_from_expression(expression):
    if expression == None:
        return []
    if expression.variant == "Call":
        required = collect_effects_from_expression(expression.callee)
        if expression.callee.variant == "Identifier":
            name = expression.callee.name
            if name == "spawn":
                required = append_requirement(required, EffectRequirement(
                    effect="io", description="spawn call"))
            if name == "sleep":
                required = append_requirement(required, EffectRequirement(
                    effect="clock", description="sleep call"))
            if name == "serve":
                required = append_requirement(required, EffectRequirement(
                    effect="net", description="serve call"))
        if expression.callee.variant == "Member":
            required = merge_requirements(
                required, collect_effects_from_expression(expression.callee))
        argument_index = 0
        while True:
            if argument_index >= len(expression.arguments):
                break
            required = merge_requirements(required, collect_effects_from_expression(
                expression.arguments[argument_index]))
            argument_index += 1
        return required
    if expression.variant == "Member":
        required = collect_effects_from_expression(expression.object)
        if expression.object.variant == "Identifier":
            root = expression.object.name
            if root == "fs":
                required = append_requirement(required, EffectRequirement(
                    effect="io", description="filesystem helper usage"))
            if root == "print" or root == "console":
                required = append_requirement(required, EffectRequirement(
                    effect="io", description="print/console helper usage"))
            if root == "http" or root == "websocket":
                required = append_requirement(required, EffectRequirement(
                    effect="net", description="network helper usage"))
        return required
    if expression.variant == "Unary":
        return collect_effects_from_expression(expression.operand)
    if expression.variant == "Binary":
        required = collect_effects_from_expression(expression.left)
        required = merge_requirements(
            required, collect_effects_from_expression(expression.right))
        return required
    if expression.variant == "Array":
        required = []
        element_index = 0
        while True:
            if element_index >= len(expression.elements):
                break
            required = merge_requirements(
                required, collect_effects_from_expression(expression.elements[element_index]))
            element_index += 1
        return required
    if expression.variant == "Object":
        required = []
        field_index = 0
        while True:
            if field_index >= len(expression.fields):
                break
            required = merge_requirements(required, collect_effects_from_expression(
                expression.fields[field_index].value))
            field_index += 1
        return required
    if expression.variant == "Struct":
        required = []
        field_index = 0
        while True:
            if field_index >= len(expression.fields):
                break
            required = merge_requirements(required, collect_effects_from_expression(
                expression.fields[field_index].value))
            field_index += 1
        return required
    if expression.variant == "Lambda":
        return collect_effects_from_block(expression.body)
    if expression.variant == "Index":
        required = collect_effects_from_expression(expression.sequence)
        required = merge_requirements(
            required, collect_effects_from_expression(expression.index))
        return required
    if expression.variant == "Range":
        required = collect_effects_from_expression(expression.start)
        required = merge_requirements(
            required, collect_effects_from_expression(expression.end))
        return required
    if expression.variant == "Raw":
        return collect_effects_from_text(expression.text)
    return []


def collect_effects_from_text(text):
    required = []
    if contains_code(text, "fs."):
        required = append_requirement(
            required,
            EffectRequirement(
                effect="io", description="filesystem helper usage")
        )
    if contains_code(text, "print(") or contains_code(text, "print."):
        required = append_requirement(
            required,
            EffectRequirement(effect="io", description="print helper usage")
        )
    if contains_code(text, "console."):
        required = append_requirement(
            required,
            EffectRequirement(effect="io", description="console helper usage")
        )
    if contains_code(text, "http."):
        required = append_requirement(
            required,
            EffectRequirement(effect="net", description="http helper usage")
        )
    if contains_code(text, "websocket."):
        required = append_requirement(
            required,
            EffectRequirement(
                effect="net", description="websocket helper usage")
        )
    if contains_code(text, "spawn("):
        required = append_requirement(
            required,
            EffectRequirement(effect="io", description="spawn call")
        )
    if contains_code(text, "serve("):
        required = append_requirement(
            required,
            EffectRequirement(effect="net", description="serve call")
        )
    if contains_code(text, "sleep("):
        required = append_requirement(
            required,
            EffectRequirement(effect="clock", description="sleep call")
        )
    return required


def contains_code(text, needle):
    if len(needle) == 0:
        return True
    if len(text) < len(needle):
        return False
    index = 0
    in_line_comment = False
    in_block_comment = False
    in_string_quote = ""
    escaped = False
    while True:
        if index >= len(text):
            break
        ch = substring(text, index, index + 1)
        two = ""
        if index + 1 < len(text):
            two = substring(text, index, index + 2)
        if len(in_string_quote) > 0:
            if escaped:
                escaped = False
                index += 1
                continue
            if ch == "\\":
                escaped = True
                index += 1
                continue
            if ch == in_string_quote:
                in_string_quote = ""
                index += 1
                continue
            index += 1
            continue
        if in_line_comment:
            if ch == "\n":
                in_line_comment = False
            index += 1
            continue
        if in_block_comment:
            if two == "*/":
                in_block_comment = False
                index += 2
                continue
            index += 1
            continue
        if two == "//":
            in_line_comment = True
            index += 2
            continue
        if two == "/*":
            in_block_comment = True
            index += 2
            continue
        if ch == "\"" or ch == "'":
            in_string_quote = ch
            escaped = False
            index += 1
            continue
        if index + len(needle) <= len(text) and substring(text, index, index + len(needle)) == needle:
            return True
        index += 1
    return False


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
