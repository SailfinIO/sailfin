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

__module_1 = importlib.import_module('compiler.build.emit_native')
NativeModule = getattr(__module_1, 'NativeModule')
__module_2 = importlib.import_module('compiler.build.native_ir')
select_text_artifact = getattr(__module_2, 'select_text_artifact')
parse_native_artifact = getattr(__module_2, 'parse_native_artifact')
NativeFunction = getattr(__module_2, 'NativeFunction')
NativeInstruction = getattr(__module_2, 'NativeInstruction')
NativeParameter = getattr(__module_2, 'NativeParameter')
NativeStruct = getattr(__module_2, 'NativeStruct')
NativeStructField = getattr(__module_2, 'NativeStructField')
NativeImport = getattr(__module_2, 'NativeImport')
NativeEnum = getattr(__module_2, 'NativeEnum')
NativeEnumVariantField = getattr(__module_2, 'NativeEnumVariantField')
class LoweredPythonResult:
    def __init__(self, source, diagnostics):
        self.source = source
        self.diagnostics = diagnostics

class MatchContext:
    def __init__(self, subject_name, case_index, has_active_case):
        self.subject_name = subject_name
        self.case_index = case_index
        self.has_active_case = has_active_case

class LoweredCaseCondition:
    def __init__(self, condition, is_default, has_guard):
        self.condition = condition
        self.is_default = is_default
        self.has_guard = has_guard

def lower_to_python(native_module):
    diagnostics = []
    artifact = select_text_artifact(native_module.artifacts)
    if (artifact == None):
        diagnostics = append_string(diagnostics, 'no sailfin-native-text artifact present')
        return LoweredPythonResult(source='', diagnostics=diagnostics)
    parse = parse_native_artifact(artifact.contents)
    diagnostics = list(diagnostics) + list(parse.diagnostics)
    python_source = emit_python_module(parse.functions, parse.imports, parse.structs, parse.enums)
    return LoweredPythonResult(source=python_source, diagnostics=diagnostics)

def emit_python_module(functions, imports, structs, enums):
    builder = builder_new()
    builder = builder_emit(builder, 'import asyncio')
    builder = builder_emit(builder, 'from bootstrap import runtime_support as runtime')
    if (len(imports) > 0):
        builder = builder_emit_blank(builder)
        builder = emit_python_imports(builder, imports)
    builder = builder_emit_blank(builder)
    builder = emit_runtime_aliases(builder)
    if (len(enums) > 0):
        builder = builder_emit_blank(builder)
        builder = emit_enum_definitions(builder, enums)
    if (len(structs) > 0):
        builder = builder_emit_blank(builder)
        builder = emit_struct_definitions(builder, structs)
    builder = builder_emit_blank(builder)
    index = 0
    while True:
        if (index >= len(functions)):
            break
        builder = emit_python_function(builder, functions[index])
        if ((index + 1) < len(functions)):
            builder = builder_emit_blank(builder)
        index += 1
    return builder_to_string(builder)

def emit_runtime_aliases(builder):
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

def emit_python_imports(builder, imports):
    current = builder
    index = 0
    while True:
        if (index >= len(imports)):
            break
        line = render_python_import(imports[index])
        if (len(line) > 0):
            current = builder_emit(current, line)
        index += 1
    return current

def emit_enum_definitions(builder, enums):
    current = builder
    index = 0
    while True:
        if (index >= len(enums)):
            break
        current = emit_single_enum(current, enums[index])
        if ((index + 1) < len(enums)):
            current = builder_emit_blank(current)
        index += 1
    return current

def emit_single_enum(builder, definition):
    enum_name = sanitize_identifier(definition.name)
    current = builder_emit(builder, (((enum_name + " = runtime.EnumType('") + enum_name) + "')"))
    index = 0
    while True:
        if (index >= len(definition.variants)):
            break
        variant = definition.variants[index]
        variant_name = sanitize_identifier(variant.name)
        variant_line = (((((((((enum_name + '.') + variant_name) + ' = ') + enum_name) + ".variant('") + variant_name) + "', [") + render_enum_variant_fields(variant.fields)) + '])')
        current = builder_emit(current, variant_line)
        index += 1
    return current

def render_enum_variant_fields(fields):
    if (len(fields) == 0):
        return ''
    rendered = []
    index = 0
    while True:
        if (index >= len(fields)):
            break
        rendered = append_string(rendered, (("'" + sanitize_identifier(fields[index].name)) + "'"))
        index += 1
    return join_with_separator(rendered, ', ')

def render_python_import(entry):
    module_path = normalize_import_module(entry.module)
    if (len(entry.names) == 0):
        return ('import ' + module_path)
    return ((('from ' + module_path) + ' import ') + join_with_separator(entry.names, ', '))

def normalize_import_module(path):
    trimmed = trim_text(path)
    if (len(trimmed) == 0):
        return trimmed
    if starts_with(trimmed, './'):
        remainder = runtime.substring(trimmed, 2, len(trimmed))
        remainder = replace_all(remainder, '/', '.')
        return ('compiler.build.' + remainder)
    return replace_all(trimmed, '/', '.')

def emit_struct_definitions(builder, structs):
    current = builder
    index = 0
    while True:
        if (index >= len(structs)):
            break
        current = emit_single_struct(current, structs[index])
        if ((index + 1) < len(structs)):
            current = builder_emit_blank(current)
        index += 1
    return current

def emit_single_struct(builder, definition):
    class_name = sanitize_identifier(definition.name)
    current = builder_emit(builder, (('class ' + class_name) + ':'))
    current = builder_push_indent(current)
    if (len(definition.fields) == 0):
        current = builder_emit(current, 'pass')
        current = builder_pop_indent(current)
        return current
    parameters = render_struct_parameters(definition.fields)
    current = builder_emit(current, (('def __init__(self, ' + join_with_separator(parameters, ', ')) + '):'))
    current = builder_push_indent(current)
    index = 0
    while True:
        if (index >= len(definition.fields)):
            break
        field = definition.fields[index]
        attr_name = sanitize_identifier(field.name)
        current = builder_emit(current, ((('self.' + attr_name) + ' = ') + attr_name))
        index += 1
    current = builder_pop_indent(current)
    current = builder_pop_indent(current)
    return current

def render_struct_parameters(fields):
    required = []
    optional = []
    index = 0
    while True:
        if (index >= len(fields)):
            break
        field = fields[index]
        name = sanitize_identifier(field.name)
        entry = name
        if is_optional_type(field.type_annotation):
            entry = (entry + '=None')
            optional = append_string(optional, entry)
        else:
            required = append_string(required, entry)
        index += 1
    return list(required) + list(optional)

def is_optional_type(type_annotation):
    trimmed = trim_text(type_annotation)
    if (len(trimmed) == 0):
        return True
    return ends_with(trimmed, '?')

def lower_expression(expression):
    return lower_expression_with_depth(expression, 0)

def lower_expression_with_depth(expression, depth):
    if (depth > 8):
        return trim_text(expression)
    trimmed = trim_text(expression)
    if (len(trimmed) == 0):
        return trimmed
    struct_literal = lower_struct_literal_expression(trimmed, depth)
    if (struct_literal != None):
        return struct_literal
    return trimmed

def lower_struct_literal_expression(expression, depth):
    brace_index = index_of(expression, '{')
    if (brace_index < 0):
        return None
    closing_index = find_matching_brace(expression, brace_index)
    if (closing_index < 0):
        return None
    type_name = trim_text(runtime.substring(expression, 0, brace_index))
    if (len(type_name) == 0):
        return None
    fields_text = runtime.substring(expression, (brace_index + 1), closing_index)
    entries = split_struct_field_entries(fields_text)
    assignments = []
    index = 0
    while True:
        if (index >= len(entries)):
            break
        entry = trim_trailing_delimiters(trim_text(entries[index]))
        if (len(entry) == 0):
            index += 1
            continue
        colon_index = index_of(entry, ':')
        if (colon_index < 0):
            index += 1
            continue
        name = trim_text(runtime.substring(entry, 0, colon_index))
        value_text = trim_text(runtime.substring(entry, (colon_index + 1), len(entry)))
        if (len(name) == 0):
            index += 1
            continue
        lowered_value = lower_expression_with_depth(value_text, (depth + 1))
        assignments = append_string(assignments, ((sanitize_identifier(name) + '=') + lowered_value))
        index += 1
    sanitized_type = sanitize_identifier(type_name)
    return (((sanitized_type + '(') + join_with_separator(assignments, ', ')) + ')')

def split_struct_field_entries(text):
    entries = []
    current = ''
    depth = 0
    index = 0
    while True:
        if (index >= len(text)):
            break
        ch = text[index]
        if (((ch == '{') or (ch == '[')) or (ch == '(')):
            depth += 1
        else:
            if (((ch == '}') or (ch == ']')) or (ch == ')')):
                if (depth > 0):
                    depth -= 1
        if ((ch == ',') and (depth == 0)):
            entries = append_string(entries, current)
            current = ''
        else:
            current = (current + ch)
        index += 1
    if (len(current) > 0):
        entries = append_string(entries, current)
    return entries

def trim_trailing_delimiters(text):
    end = len(text)
    while True:
        if (end <= 0):
            break
        ch = text[(end - 1)]
        if ((ch == ',') or (ch == ';')):
            end -= 1
            continue
        break
    if (end == len(text)):
        return text
    return runtime.substring(text, 0, end)

def index_of(value, target):
    if (len(target) == 0):
        return 0
    index = 0
    while True:
        if ((index + len(target)) > len(value)):
            break
        match_index = 0
        matches = True
        while True:
            if (match_index >= len(target)):
                break
            if (value[(index + match_index)] != target[match_index]):
                matches = False
                break
            match_index += 1
        if matches:
            return index
        index += 1
    return (-1)

def find_matching_brace(text, open_index):
    depth = 0
    index = open_index
    while True:
        if (index >= len(text)):
            break
        ch = text[index]
        if (ch == '{'):
            depth += 1
        else:
            if (ch == '}'):
                if (depth <= 0):
                    return (-1)
                depth -= 1
                if (depth == 0):
                    return index
        index += 1
    return (-1)

def emit_python_function(builder, function):
    current = builder
    parameters = render_python_parameters(function.parameters)
    header = (((('def ' + sanitize_identifier(function.name)) + '(') + join_with_separator(parameters, ', ')) + '):')
    current = builder_emit(current, header)
    current = builder_push_indent(current)
    if (len(function.effects) > 0):
        current = builder_emit(current, ('# effects: ' + join_with_separator(function.effects, ', ')))
    if (len(function.instructions) == 0):
        current = builder_emit(current, 'pass')
        current = builder_pop_indent(current)
        return current
    block_depth = 0
    match_stack = []
    match_counter = 0
    index = 0
    while True:
        if (index >= len(function.instructions)):
            break
        instruction = function.instructions[index]
        if (instruction.variant == 'Return'):
            if (len(instruction.expression) == 0):
                current = builder_emit(current, 'return')
            else:
                current = builder_emit(current, ('return ' + lower_expression(instruction.expression)))
        else:
            if (instruction.variant == 'Expression'):
                current = builder_emit(current, lower_expression(instruction.expression))
            else:
                if (instruction.variant == 'Let'):
                    target_name = sanitize_identifier(instruction.name)
                    line = (target_name + ' = ')
                    if (instruction.value != None):
                        line = (line + lower_expression(instruction.value))
                    else:
                        line = (line + 'None')
                    current = builder_emit(current, line)
                else:
                    if (instruction.variant == 'If'):
                        current = builder_emit(current, (('if ' + instruction.condition) + ':'))
                        current = builder_push_indent(current)
                        block_depth += 1
                    else:
                        if (instruction.variant == 'Else'):
                            if (block_depth > 0):
                                current = builder_pop_indent(current)
                            current = builder_emit(current, 'else:')
                            current = builder_push_indent(current)
                        else:
                            if (instruction.variant == 'EndIf'):
                                if (block_depth > 0):
                                    current = builder_pop_indent(current)
                                    block_depth -= 1
                            else:
                                if (instruction.variant == 'For'):
                                    current = builder_emit(current, (((('for ' + instruction.target) + ' in ') + instruction.iterable) + ':'))
                                    current = builder_push_indent(current)
                                    block_depth += 1
                                else:
                                    if (instruction.variant == 'EndFor'):
                                        if (block_depth > 0):
                                            current = builder_pop_indent(current)
                                            block_depth -= 1
                                    else:
                                        if (instruction.variant == 'Loop'):
                                            current = builder_emit(current, 'while True:')
                                            current = builder_push_indent(current)
                                            block_depth += 1
                                        else:
                                            if (instruction.variant == 'EndLoop'):
                                                if (block_depth > 0):
                                                    current = builder_pop_indent(current)
                                                    block_depth -= 1
                                            else:
                                                if (instruction.variant == 'Break'):
                                                    current = builder_emit(current, 'break')
                                                else:
                                                    if (instruction.variant == 'Continue'):
                                                        current = builder_emit(current, 'continue')
                                                    else:
                                                        if (instruction.variant == 'Match'):
                                                            subject_name = generate_match_subject_name(match_counter)
                                                            match_counter += 1
                                                            lowered_subject = lower_expression(instruction.expression)
                                                            current = builder_emit(current, ((subject_name + ' = ') + lowered_subject))
                                                            context = MatchContext(subject_name=subject_name, case_index=0, has_active_case=False)
                                                            match_stack = append_match_context(match_stack, context)
                                                        else:
                                                            if (instruction.variant == 'Case'):
                                                                if (len(match_stack) == 0):
                                                                    current = builder_emit(current, '# unsupported: match case without context')
                                                                else:
                                                                    top_index = (len(match_stack) - 1)
                                                                    context = match_stack[top_index]
                                                                    if context.has_active_case:
                                                                        current = builder_pop_indent(current)
                                                                    lowered = lower_match_case_condition(context.subject_name, instruction.pattern, instruction.guard)
                                                                    if (context.case_index == 0):
                                                                        current = builder_emit(current, (('if ' + lowered.condition) + ':'))
                                                                    else:
                                                                        if (lowered.is_default and (not lowered.has_guard)):
                                                                            current = builder_emit(current, 'else:')
                                                                        else:
                                                                            current = builder_emit(current, (('elif ' + lowered.condition) + ':'))
                                                                    current = builder_push_indent(current)
                                                                    updated = MatchContext(subject_name=context.subject_name, case_index=(context.case_index + 1), has_active_case=True)
                                                                    match_stack = replace_match_context(match_stack, top_index, updated)
                                                            else:
                                                                if (instruction.variant == 'EndMatch'):
                                                                    if (len(match_stack) == 0):
                                                                        current = builder_emit(current, '# unsupported: endmatch without context')
                                                                    else:
                                                                        top_index = (len(match_stack) - 1)
                                                                        context = match_stack[top_index]
                                                                        if context.has_active_case:
                                                                            current = builder_pop_indent(current)
                                                                        match_stack = truncate_match_contexts(match_stack, top_index)
                                                                else:
                                                                    if (instruction.variant == 'Noop'):
                                                                        current = builder_emit(current, 'pass')
                                                                    else:
                                                                        current = builder_emit(current, ('# unsupported: ' + instruction.text))
        index += 1
    while True:
        if (len(match_stack) == 0):
            break
        top_index = (len(match_stack) - 1)
        context = match_stack[top_index]
        if context.has_active_case:
            current = builder_pop_indent(current)
        match_stack = truncate_match_contexts(match_stack, top_index)
    while True:
        if (block_depth <= 0):
            break
        current = builder_pop_indent(current)
        block_depth -= 1
    current = builder_pop_indent(current)
    return current

def append_match_context(values, value):
    return list(values) + list([value])

def replace_match_context(values, index, replacement):
    result = []
    position = 0
    while True:
        if (position >= len(values)):
            break
        if (position == index):
            result = append_match_context(result, replacement)
        else:
            result = append_match_context(result, values[position])
        position += 1
    return result

def truncate_match_contexts(values, end_index):
    if (end_index <= 0):
        return []
    result = []
    index = 0
    while True:
        if (index >= end_index):
            break
        result = append_match_context(result, values[index])
        index += 1
    return result

def generate_match_subject_name(counter):
    return ('__match_value_' + number_to_string(counter))

def lower_match_case_condition(subject_name, pattern, guard):
    trimmed_pattern = trim_text(pattern)
    normalized_guard = None
    if (guard != None):
        trimmed_guard = trim_text(guard)
        if (len(trimmed_guard) > 0):
            normalized_guard = trimmed_guard
    if ((len(trimmed_pattern) == 0) or (trimmed_pattern == '_')):
        if (normalized_guard == None):
            return LoweredCaseCondition(condition='True', is_default=True, has_guard=False)
        lowered_guard = lower_expression(normalized_guard)
        return LoweredCaseCondition(condition=lowered_guard, is_default=False, has_guard=True)
    lowered_pattern = lower_expression(trimmed_pattern)
    condition = ((subject_name + ' == ') + lowered_pattern)
    has_guard = False
    if (normalized_guard != None):
        lowered_guard = lower_expression(normalized_guard)
        condition = (((('(' + condition) + ') and (') + lowered_guard) + ')')
        has_guard = True
    return LoweredCaseCondition(condition=condition, is_default=False, has_guard=has_guard)

def number_to_string(value):
    if (value == 0):
        return '0'
    digits = '0123456789'
    remaining = value
    output = ''
    while True:
        if (remaining <= 0):
            break
        temp = remaining
        quotient = 0
        while True:
            if (temp < 10):
                break
            temp -= 10
            quotient += 1
        digit = temp
        ch = runtime.substring(digits, digit, (digit + 1))
        output = (ch + output)
        remaining = quotient
    return output

def render_python_parameters(parameters):
    if (len(parameters) == 0):
        return []
    rendered = []
    index = 0
    while True:
        if (index >= len(parameters)):
            break
        parameter = parameters[index]
        entry = parameter.name
        if (parameter.default_value != None):
            entry = ((entry + ' = ') + parameter.default_value)
        rendered = append_string(rendered, entry)
        index += 1
    return rendered

class PythonBuilder:
    def __init__(self, lines, indent):
        self.lines = lines
        self.indent = indent

def builder_new():
    return PythonBuilder(lines=[], indent=0)

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
    return PythonBuilder(lines=lines, indent=builder.indent)

def builder_emit_blank(builder):
    lines = append_string(builder.lines, '')
    return PythonBuilder(lines=lines, indent=builder.indent)

def builder_push_indent(builder):
    return PythonBuilder(lines=builder.lines, indent=(builder.indent + 1))

def builder_pop_indent(builder):
    indent = builder.indent
    if (indent > 0):
        indent -= 1
    return PythonBuilder(lines=builder.lines, indent=indent)

def builder_to_string(builder):
    content = join_with_separator(builder.lines, '\n')
    if (len(content) == 0):
        return ''
    return (content + '\n')

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
        return 'generated_function'
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
        if ((((ch == ' ') or (ch == '\n')) or (ch == '\r')) or (ch == '\t')):
            start += 1
            continue
        break
    while True:
        if (end <= start):
            break
        ch = value[(end - 1)]
        if ((((ch == ' ') or (ch == '\n')) or (ch == '\r')) or (ch == '\t')):
            end -= 1
            continue
        break
    if ((start == 0) and (end == len(value))):
        return value
    return runtime.substring(value, start, end)

def starts_with(value, prefix):
    if (len(prefix) == 0):
        return True
    if (len(value) < len(prefix)):
        return False
    index = 0
    while True:
        if (index >= len(prefix)):
            break
        if (value[index] != prefix[index]):
            return False
        index += 1
    return True

def ends_with(value, suffix):
    if (len(suffix) == 0):
        return True
    if (len(value) < len(suffix)):
        return False
    index = 0
    while True:
        if (index >= len(suffix)):
            break
        if (value[((len(value) - len(suffix)) + index)] != suffix[index]):
            return False
        index += 1
    return True

def replace_all(value, target, replacement):
    if (len(target) == 0):
        return value
    result = ''
    index = 0
    while True:
        if (index >= len(value)):
            break
        if ((index + len(target)) <= len(value)):
            matches = True
            offset = 0
            while True:
                if (offset >= len(target)):
                    break
                if (value[(index + offset)] != target[offset]):
                    matches = False
                    break
                offset += 1
            if matches:
                result = (result + replacement)
                index += len(target)
                continue
        result = (result + value[index])
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

def append_string(values, value):
    return list(values) + list([value])
