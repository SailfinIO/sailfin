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
FieldDeclaration = getattr(__module_1, 'FieldDeclaration')
MatchCase = getattr(__module_1, 'MatchCase')
FunctionSignature = getattr(__module_1, 'FunctionSignature')
MethodDeclaration = getattr(__module_1, 'MethodDeclaration')
Parameter = getattr(__module_1, 'Parameter')
Program = getattr(__module_1, 'Program')
Statement = getattr(__module_1, 'Statement')
class CodeBuilder:
    def __init__(self, lines, indent):
        self.lines = lines
        self.indent = indent

def generate_program(program):
    builder = builder_new()
    builder = builder_emit(builder, 'import asyncio')
    builder = builder_emit(builder, 'from bootstrap import runtime_support as runtime')
    builder = builder_emit_blank(builder)
    builder = emit_runtime_preamble(builder)
    builder = builder_emit_blank(builder)
    index = 0
    while True:
        if (index >= len(program.statements)):
            break
        builder = emit_statement(builder, program.statements[index])
        if ((index + 1) < len(program.statements)):
            builder = builder_emit_blank(builder)
        index += 1
    return builder_to_string(builder)

def emit_runtime_preamble(builder):
    current = builder
    current = builder_emit(current, 'print = runtime.console')
    current = builder_emit(current, 'sleep = runtime.sleep')
    current = builder_emit(current, 'channel = runtime.channel')
    current = builder_emit(current, 'parallel = runtime.parallel')
    current = builder_emit(current, 'spawn = runtime.spawn')
    current = builder_emit(current, 'fs = runtime.fs')
    current = builder_emit(current, 'serve = runtime.serve')
    current = builder_emit(current, 'http = runtime.http')
    current = builder_emit(current, 'websocket = runtime.websocket')
    current = builder_emit(current, 'logExecution = runtime.logExecution')
    current = builder_emit(current, 'array_map = runtime.array_map')
    current = builder_emit(current, 'array_filter = runtime.array_filter')
    current = builder_emit(current, 'array_reduce = runtime.array_reduce')
    return current

def emit_statement(builder, statement):
    if (statement.variant == 'FunctionDeclaration'):
        return emit_function(builder, statement.signature, statement.body, statement.decorators)
    if (statement.variant == 'StructDeclaration'):
        return emit_struct(builder, statement.name, statement.fields, statement.methods, statement.decorators)
    if (statement.variant == 'TestDeclaration'):
        qualified = (('test \"' + statement.name) + '\"')
        return emit_stub_function(builder, qualified, statement.body, statement.effects, statement.decorators)
    if (statement.variant == 'PipelineDeclaration'):
        qualified = ('pipeline ' + statement.signature.name)
        return emit_stub_function(builder, qualified, statement.body, statement.effects, statement.decorators)
    if (statement.variant == 'ToolDeclaration'):
        qualified = ('tool ' + statement.signature.name)
        return emit_stub_function(builder, qualified, statement.body, statement.effects, statement.decorators)
    if (statement.variant == 'ModelDeclaration'):
        return emit_model(builder, statement.name, statement.effects, statement.decorators)
    builder = builder_emit(builder, ('# TODO: unsupported statement: ' + statement.variant))
    return builder

def emit_function(builder, signature, body, decorators):
    builder = emit_decorator_comments(builder, decorators)
    header = format_function_header(signature)
    builder = builder_emit(builder, header)
    builder = builder_push_indent(builder)
    if (len(signature.effects) > 0):
        builder = builder_emit(builder, ('# effects: ' + join_with_separator(signature.effects, ', ')))
    builder = emit_block(builder, body)
    builder = builder_pop_indent(builder)
    return builder

def emit_struct(builder, name, fields, methods, decorators):
    builder = emit_decorator_comments(builder, decorators)
    builder = builder_emit(builder, (('class ' + name) + ':'))
    builder = builder_push_indent(builder)
    if ((len(fields) == 0) and (len(methods) == 0)):
        builder = builder_emit(builder, 'pass')
        builder = builder_pop_indent(builder)
        return builder
    builder = builder_emit(builder, 'def __init__(self):')
    builder = builder_push_indent(builder)
    if (len(fields) == 0):
        builder = builder_emit(builder, 'pass')
    else:
        index = 0
        while True:
            if (index >= len(fields)):
                break
            field = fields[index]
            builder = builder_emit(builder, (('self.' + field.name) + ' = None'))
            index += 1
    builder = builder_pop_indent(builder)
    method_index = 0
    while True:
        if (method_index >= len(methods)):
            break
        builder = builder_emit_blank(builder)
        builder = emit_method(builder, methods[method_index])
        method_index += 1
    builder = builder_pop_indent(builder)
    return builder

def emit_method(builder, method):
    builder = emit_decorator_comments(builder, method.decorators)
    signature = method.signature
    header = format_method_header(signature)
    builder = builder_emit(builder, header)
    builder = builder_push_indent(builder)
    if (len(signature.effects) > 0):
        builder = builder_emit(builder, ('# effects: ' + join_with_separator(signature.effects, ', ')))
    builder = emit_block(builder, method.body)
    builder = builder_pop_indent(builder)
    return builder

def emit_stub_function(builder, name, body, effects, decorators):
    builder = emit_decorator_comments(builder, decorators)
    header = (('def ' + sanitize_identifier(name)) + '():')
    builder = builder_emit(builder, header)
    builder = builder_push_indent(builder)
    if (len(effects) > 0):
        builder = builder_emit(builder, ('# effects: ' + join_with_separator(effects, ', ')))
    builder = emit_block(builder, body)
    builder = builder_pop_indent(builder)
    return builder

def sanitize_identifier(name):
    result = ''
    index = 0
    while True:
        if (index >= len(name)):
            break
        ch = name[index]
        if is_identifier_char(ch):
            result = (result + ch)
        else:
            if (ch == ' '):
                result = (result + '_')
        index += 1
    if (len(result) == 0):
        return 'generated_test'
    return result

def is_identifier_char(ch):
    if (ch == '_'):
        return True
    code = runtime.char_code(ch)
    if ((code >= runtime.char_code('a')) and (code <= runtime.char_code('z'))):
        return True
    if ((code >= runtime.char_code('A')) and (code <= runtime.char_code('Z'))):
        return True
    if ((code >= runtime.char_code('0')) and (code <= runtime.char_code('9'))):
        return True
    return False

def trim_text(value):
    start = 0
    end = len(value)
    while True:
        if (start >= end):
            break
        ch = value[start]
        if is_trim_char(ch):
            start += 1
            continue
        break
    while True:
        if (end <= start):
            break
        ch = value[(end - 1)]
        if is_trim_char(ch):
            end -= 1
            continue
        break
    if ((start == 0) and (end == len(value))):
        return value
    return runtime.substring(value, start, end)

def is_trim_char(ch):
    return ((((ch == ' ') or (ch == '\n')) or (ch == '\r')) or (ch == '\t'))

def emit_model(builder, name, effects, decorators):
    builder = emit_decorator_comments(builder, decorators)
    assignment = ((((name + ' = {') + "'effects': ") + format_effects_array(effects)) + '}')
    builder = builder_emit(builder, assignment)
    return builder

def format_effects_array(effects):
    if (len(effects) == 0):
        return '[]'
    index = 0
    values = []
    while True:
        if (index >= len(effects)):
            break
        values = append_string(values, (("'" + effects[index]) + "'"))
        index += 1
    return (('[' + join_with_separator(values, ', ')) + ']')

def emit_decorator_comments(builder, decorators):
    index = 0
    current = builder
    while True:
        if (index >= len(decorators)):
            break
        decorator = decorators[index]
        current = builder_emit(current, ('# @' + decorator.name))
        index += 1
    return current

def emit_block(builder, block):
    current = builder
    if (len(block.statements) == 0):
        current = builder_emit(current, 'pass')
        current = emit_original_block_comment(current, block.text)
        return current
    index = 0
    while True:
        if (index >= len(block.statements)):
            break
        current = emit_block_statement(current, block.statements[index])
        index += 1
    return current

def emit_block_statement(builder, statement):
    if (statement.variant == 'ForStatement'):
        return emit_for_statement(builder, statement)
    if (statement.variant == 'LoopStatement'):
        return emit_loop_statement(builder, statement)
    if (statement.variant == 'BreakStatement'):
        return builder_emit(builder, 'break')
    if (statement.variant == 'ContinueStatement'):
        return builder_emit(builder, 'continue')
    if (statement.variant == 'IfStatement'):
        return emit_if_statement(builder, statement)
    if (statement.variant == 'MatchStatement'):
        return emit_match_statement(builder, statement)
    if (statement.variant == 'ReturnStatement'):
        if (statement.expression == None):
            return builder_emit(builder, 'return')
        expression_text = format_expression(statement.expression)
        return builder_emit(builder, ('return ' + expression_text))
    if (statement.variant == 'ExpressionStatement'):
        expression_text = format_expression(statement.expression)
        return builder_emit(builder, expression_text)
    if (statement.variant == 'PromptStatement'):
        return emit_prompt_block(builder, statement.channel, statement.body)
    if (statement.variant == 'WithStatement'):
        return emit_with_block(builder, statement)
    if (statement.variant == 'Unknown'):
        return emit_unknown_comment(builder, statement.text)
    return builder_emit(builder, ('# TODO: unsupported statement: ' + statement.variant))

def emit_prompt_block(builder, channel, body):
    current = builder_emit(builder, ('# prompt ' + channel))
    current = emit_original_block_comment(current, body.text)
    return current

def emit_with_block(builder, statement):
    current = builder_emit(builder, '# with scope')
    current = builder_push_indent(current)
    index = 0
    while True:
        if (index >= len(statement.clauses)):
            break
        clause = statement.clauses[index]
        current = builder_emit(current, ('# clause: ' + format_expression(clause.expression)))
        index += 1
    current = emit_block(current, statement.body)
    current = builder_pop_indent(current)
    return current

def emit_for_statement(builder, statement):
    header = (((('for ' + format_expression(statement.clause.target)) + ' in ') + format_expression(statement.clause.iterable)) + ':')
    current = builder_emit(builder, header)
    current = builder_push_indent(current)
    current = emit_block(current, statement.body)
    current = builder_pop_indent(current)
    return current

def emit_loop_statement(builder, statement):
    current = builder_emit(builder, 'while True:')
    current = builder_push_indent(current)
    current = emit_block(current, statement.body)
    current = builder_pop_indent(current)
    return current

def emit_match_statement(builder, statement):
    current = builder_emit(builder, ('# match ' + format_expression(statement.expression)))
    current = builder_push_indent(current)
    index = 0
    while True:
        if (index >= len(statement.cases)):
            break
        case = statement.cases[index]
        current = emit_match_case(current, case)
        index += 1
    current = builder_pop_indent(current)
    return current

def emit_match_case(builder, case):
    current = builder_emit(builder, ('# case ' + format_expression(case.pattern)))
    if (case.guard != None):
        current = builder_emit(current, ('# guard ' + format_expression(case.guard)))
    current = builder_push_indent(current)
    current = emit_block(current, case.body)
    current = builder_pop_indent(current)
    return current

def emit_if_statement(builder, statement):
    header = (('if ' + format_expression(statement.condition)) + ':')
    current = builder_emit(builder, header)
    current = builder_push_indent(current)
    current = emit_block(current, statement.then_block)
    current = builder_pop_indent(current)
    if (statement.else_branch != None):
        current = emit_else_branch(current, statement.else_branch)
    return current

def emit_else_branch(builder, branch):
    if (branch.statement != None):
        if (branch.statement.variant == 'IfStatement'):
            return emit_elif_statement(builder, branch.statement)
    if (branch.body != None):
        current = builder_emit(builder, 'else:')
        current = builder_push_indent(current)
        current = emit_block(current, branch.body)
        current = builder_pop_indent(current)
        return current
    return builder

def emit_elif_statement(builder, statement):
    header = (('elif ' + format_expression(statement.condition)) + ':')
    current = builder_emit(builder, header)
    current = builder_push_indent(current)
    current = emit_block(current, statement.then_block)
    current = builder_pop_indent(current)
    if (statement.else_branch != None):
        current = emit_else_branch(current, statement.else_branch)
    return current

def emit_unknown_comment(builder, text):
    trimmed = trim_text(text)
    if (len(trimmed) == 0):
        return builder_emit(builder, '# original Sailfin block omitted')
    collapsed = collapse_whitespace(trimmed)
    return builder_emit(builder, ('# original: ' + collapsed))

def emit_original_block_comment(builder, text):
    trimmed = trim_block_text(text)
    if (len(trimmed) == 0):
        return builder
    return builder_emit(builder, ('# original: ' + collapse_whitespace(trimmed)))

def format_expression(expression):
    if (expression.variant == 'Identifier'):
        return expression.name
    if (expression.variant == 'NumberLiteral'):
        return expression.value
    if (expression.variant == 'BooleanLiteral'):
        if expression.value:
            return 'True'
        return 'False'
    if (expression.variant == 'NullLiteral'):
        return 'None'
    if (expression.variant == 'StringLiteral'):
        return quote_string(expression.value)
    if (expression.variant == 'Unary'):
        operand = format_expression(expression.operand)
        op = expression.operator
        if (op == '!'):
            return ('not ' + operand)
        return (op + operand)
    if (expression.variant == 'Binary'):
        left = format_expression(expression.left)
        right = format_expression(expression.right)
        op = expression.operator
        spaced_op = ((' ' + op) + ' ')
        if (op == '&&'):
            spaced_op = ' and '
        else:
            if (op == '||'):
                spaced_op = ' or '
        return ((left + spaced_op) + right)
    if (expression.variant == 'Member'):
        target = format_expression(expression.object)
        if (expression.member == 'length'):
            return (('len(' + target) + ')')
        return ((target + '.') + expression.member)
    if (expression.variant == 'Index'):
        target = format_expression(expression.sequence)
        offset = format_expression(expression.index)
        return (((target + '[') + offset) + ']')
    if (expression.variant == 'Call'):
        callee = expression.callee
        if (callee.variant == 'Member'):
            member_name = callee.member
            target = format_expression(callee.object)
            if ((member_name == 'map') and (len(expression.arguments) == 1)):
                mapper = format_expression(expression.arguments[0])
                return (((('array_map(' + target) + ', ') + mapper) + ')')
            if ((member_name == 'filter') and (len(expression.arguments) == 1)):
                predicate = format_expression(expression.arguments[0])
                return (((('array_filter(' + target) + ', ') + predicate) + ')')
            if ((member_name == 'reduce') and (len(expression.arguments) == 2)):
                initial = format_expression(expression.arguments[0])
                reducer = format_expression(expression.arguments[1])
                return (((((('array_reduce(' + target) + ', ') + initial) + ', ') + reducer) + ')')
            if ((member_name == 'concat') and (len(expression.arguments) == 1)):
                other = format_expression(expression.arguments[0])
                return (((('list(' + target) + ') + list(') + other) + ')')
        parts = []
        index = 0
        while True:
            if (index >= len(expression.arguments)):
                break
            parts = append_string(parts, format_expression(expression.arguments[index]))
            index += 1
        args = join_with_separator(parts, ', ')
        return (((format_expression(expression.callee) + '(') + args) + ')')
    if (expression.variant == 'Array'):
        rendered = []
        index = 0
        while True:
            if (index >= len(expression.elements)):
                break
            rendered = append_string(rendered, format_expression(expression.elements[index]))
            index += 1
        contents = join_with_separator(rendered, ', ')
        return (('[' + contents) + ']')
    if (expression.variant == 'Range'):
        start_value = format_expression(expression.start)
        end_value = format_expression(expression.end)
        return (((('range(' + start_value) + ', ') + end_value) + ')')
    if (expression.variant == 'Object'):
        rendered = []
        index = 0
        while True:
            if (index >= len(expression.fields)):
                break
            field = expression.fields[index]
            value = format_expression(field.value)
            rendered = append_string(rendered, ((field.name + '=') + value))
            index += 1
        args = join_with_separator(rendered, ', ')
        if (len(args) == 0):
            return 'runtime.make_object()'
        return (('runtime.make_object(' + args) + ')')
    if (expression.variant == 'Struct'):
        type_name = join_with_separator(expression.type_name, '.')
        rendered = []
        index = 0
        while True:
            if (index >= len(expression.fields)):
                break
            field = expression.fields[index]
            value = format_expression(field.value)
            rendered = append_string(rendered, ((field.name + '=') + value))
            index += 1
        args = join_with_separator(rendered, ', ')
        if (len(args) == 0):
            return (type_name + '()')
        return (((type_name + '(') + args) + ')')
    if (expression.variant == 'Lambda'):
        return format_lambda_expression(expression)
    if (expression.variant == 'Raw'):
        return trim_text(expression.text)
    return ''

def format_lambda_expression(expression):
    names = []
    index = 0
    while True:
        if (index >= len(expression.parameters)):
            break
        names = append_string(names, expression.parameters[index].name)
        index += 1
    if (len(expression.body.statements) == 1):
        single = expression.body.statements[0]
        if (single.variant == 'ReturnStatement'):
            if (single.expression != None):
                value = format_expression(single.expression)
                args = join_with_separator(names, ', ')
                if (len(args) == 0):
                    return ('lambda: ' + value)
                return ((('lambda ' + args) + ': ') + value)
    args = join_with_separator(names, ', ')
    if (len(args) == 0):
        return 'lambda: None'
    return (('lambda ' + args) + ': None')

def quote_string(value):
    result = "'"
    index = 0
    while True:
        if (index >= len(value)):
            break
        ch = value[index]
        result = (result + escape_string_char(ch))
        index += 1
    result = (result + "'")
    return result

def escape_string_char(ch):
    if (ch == "'"):
        return "\\'"
    if (ch == '\\'):
        return '\\\\'
    if (ch == '\n'):
        return '\\n'
    if (ch == '\r'):
        return '\\r'
    if (ch == '\t'):
        return '\\t'
    return ch

def collapse_whitespace(value):
    result = ''
    index = 0
    last_was_space = False
    while True:
        if (index >= len(value)):
            break
        ch = value[index]
        is_space = ((((ch == ' ') or (ch == '\n')) or (ch == '\r')) or (ch == '\t'))
        if is_space:
            if ((not last_was_space) and (len(result) > 0)):
                result = (result + ' ')
                last_was_space = True
        else:
            result = (result + ch)
            last_was_space = False
        index += 1
    return result

def trim_block_text(text):
    start = 0
    end = len(text)
    while True:
        if (start >= end):
            break
        ch = text[start]
        if is_whitespace_char(ch):
            start += 1
            continue
        break
    while True:
        if (end <= start):
            break
        ch = text[(end - 1)]
        if is_whitespace_char(ch):
            end -= 1
            continue
        break
    return runtime.substring(text, start, end)

def is_whitespace_char(ch):
    return ((((ch == ' ') or (ch == '\t')) or (ch == '\n')) or (ch == '\r'))

def format_function_header(signature):
    prefix = 'def '
    if signature.is_async:
        prefix = 'async def '
    params_array = format_parameters(signature.parameters)
    params = join_with_separator(params_array, ', ')
    return ((((prefix + signature.name) + '(') + params) + '):')

def format_method_header(signature):
    prefix = 'def '
    if signature.is_async:
        prefix = 'async def '
    params = format_method_parameters(signature.parameters)
    return ((((prefix + signature.name) + '(') + params) + '):')

def format_parameters(parameters):
    result = []
    if (len(parameters) == 0):
        return result
    index = 0
    while True:
        if (index >= len(parameters)):
            break
        parameter = parameters[index]
        result = append_string(result, parameter.name)
        index += 1
    return result

def format_method_parameters(parameters):
    names = []
    has_self = False
    index = 0
    while True:
        if (index >= len(parameters)):
            break
        parameter = parameters[index]
        if (parameter.name == 'self'):
            has_self = True
        names = append_string(names, parameter.name)
        index += 1
    if (not has_self):
        names = prepend_string(names, 'self')
    return join_with_separator(names, ', ')

def prepend_string(values, value):
    result = []
    result = append_string(result, value)
    index = 0
    while True:
        if (index >= len(values)):
            break
        result = append_string(result, values[index])
        index += 1
    return result

def join_with_separator(values, separator):
    if (len(values) == 0):
        return ''
    result = values[0]
    index = 1
    while True:
        if (index >= len(values)):
            break
        result = ((result + separator) + values[index])
        index += 1
    return result

def builder_new():
    return CodeBuilder(lines=[], indent=0)

def builder_emit(builder, line):
    if (len(line) == 0):
        return builder_emit_blank(builder)
    prefix = ''
    count = 0
    while True:
        if (count >= builder.indent):
            break
        prefix = (prefix + '    ')
        count += 1
    full_line = (prefix + line)
    lines = append_string(builder.lines, full_line)
    return CodeBuilder(lines=lines, indent=builder.indent)

def builder_emit_blank(builder):
    lines = append_string(builder.lines, '')
    return CodeBuilder(lines=lines, indent=builder.indent)

def builder_push_indent(builder):
    return CodeBuilder(lines=builder.lines, indent=(builder.indent + 1))

def builder_pop_indent(builder):
    indent = builder.indent
    if (indent > 0):
        indent -= 1
    return CodeBuilder(lines=builder.lines, indent=indent)

def builder_to_string(builder):
    content = join_with_separator(builder.lines, '\n')
    if (len(content) == 0):
        return ''
    return (content + '\n')

def append_string(values, value):
    return list(values) + list([value])
