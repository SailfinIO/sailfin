import asyncio
from runtime import runtime_support as runtime

from compiler.build.emit_native import NativeModule
from compiler.build.native_ir import select_text_artifact, parse_native_artifact, NativeFunction, NativeInstruction, NativeParameter, NativeStruct, NativeStructField, NativeImport, NativeImportSpecifier, NativeEnum, NativeEnumVariantField, NativeBinding
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

class LoweredPythonResult:
    def __init__(self, source, diagnostics):
        self.source = source
        self.diagnostics = diagnostics

    def __repr__(self):
        return runtime.struct_repr('LoweredPythonResult', [runtime.struct_field('source', self.source), runtime.struct_field('diagnostics', self.diagnostics)])

class MatchContext:
    def __init__(self, subject_name, case_index, has_active_case):
        self.subject_name = subject_name
        self.case_index = case_index
        self.has_active_case = has_active_case

    def __repr__(self):
        return runtime.struct_repr('MatchContext', [runtime.struct_field('subject_name', self.subject_name), runtime.struct_field('case_index', self.case_index), runtime.struct_field('has_active_case', self.has_active_case)])

class LoweredCaseCondition:
    def __init__(self, condition, is_default, has_guard):
        self.condition = condition
        self.is_default = is_default
        self.has_guard = has_guard

    def __repr__(self):
        return runtime.struct_repr('LoweredCaseCondition', [runtime.struct_field('condition', self.condition), runtime.struct_field('is_default', self.is_default), runtime.struct_field('has_guard', self.has_guard)])

class PythonModuleEmission:
    def __init__(self, builder, diagnostics):
        self.builder = builder
        self.diagnostics = diagnostics

    def __repr__(self):
        return runtime.struct_repr('PythonModuleEmission', [runtime.struct_field('builder', self.builder), runtime.struct_field('diagnostics', self.diagnostics)])

class PythonFunctionEmission:
    def __init__(self, builder, diagnostics):
        self.builder = builder
        self.diagnostics = diagnostics

    def __repr__(self):
        return runtime.struct_repr('PythonFunctionEmission', [runtime.struct_field('builder', self.builder), runtime.struct_field('diagnostics', self.diagnostics)])

class PythonImportEmission:
    def __init__(self, builder, exports):
        self.builder = builder
        self.exports = exports

    def __repr__(self):
        return runtime.struct_repr('PythonImportEmission', [runtime.struct_field('builder', self.builder), runtime.struct_field('exports', self.exports)])

class PythonStructEmission:
    def __init__(self, builder, diagnostics):
        self.builder = builder
        self.diagnostics = diagnostics

    def __repr__(self):
        return runtime.struct_repr('PythonStructEmission', [runtime.struct_field('builder', self.builder), runtime.struct_field('diagnostics', self.diagnostics)])

class StructLiteralCapture:
    def __init__(self, expression, consumed, success):
        self.expression = expression
        self.consumed = consumed
        self.success = success

    def __repr__(self):
        return runtime.struct_repr('StructLiteralCapture', [runtime.struct_field('expression', self.expression), runtime.struct_field('consumed', self.consumed), runtime.struct_field('success', self.success)])

class ExpressionContinuationCapture:
    def __init__(self, expression, consumed, success):
        self.expression = expression
        self.consumed = consumed
        self.success = success

    def __repr__(self):
        return runtime.struct_repr('ExpressionContinuationCapture', [runtime.struct_field('expression', self.expression), runtime.struct_field('consumed', self.consumed), runtime.struct_field('success', self.success)])

class ExtractedSpan:
    def __init__(self, value, start, end, success):
        self.value = value
        self.start = start
        self.end = end
        self.success = success

    def __repr__(self):
        return runtime.struct_repr('ExtractedSpan', [runtime.struct_field('value', self.value), runtime.struct_field('start', self.start), runtime.struct_field('end', self.end), runtime.struct_field('success', self.success)])

class PythonBuilder:
    def __init__(self, lines, indent):
        self.lines = lines
        self.indent = indent

    def __repr__(self):
        return runtime.struct_repr('PythonBuilder', [runtime.struct_field('lines', self.lines), runtime.struct_field('indent', self.indent)])

def lower_to_python(native_module):
    diagnostics = []
    artifact = select_text_artifact(native_module.artifacts)
    if artifact == null:
        diagnostics = append_string(diagnostics, "no sailfin-native-text artifact present")
        return LoweredPythonResult(source="", diagnostics=diagnostics)
    parse = parse_native_artifact(artifact.contents)
    diagnostics = (diagnostics) + (parse.diagnostics)
    module = emit_python_module(parse.functions, parse.imports, parse.structs, parse.enums, parse.bindings)
    diagnostics = (diagnostics) + (module.diagnostics)
    python_source = builder_to_string(module.builder)
    return LoweredPythonResult(source=python_source, diagnostics=diagnostics)

def emit_python_module(functions, imports, structs, enums, bindings):
    builder = builder_new()
    diagnostics = []
    builder = builder_emit(builder, "import asyncio")
    builder = builder_emit(builder, "from runtime import runtime_support as runtime")
    export_names = []
    if len(imports) > 0:
        builder = builder_emit_blank(builder)
        import_emission = emit_python_imports(builder, imports)
        builder = import_emission.builder
        export_names = import_emission.exports
    builder = builder_emit_blank(builder)
    builder = emit_runtime_aliases(builder)
    if len(bindings) > 0:
        builder = builder_emit_blank(builder)
        builder = emit_top_level_bindings(builder, bindings)
    if len(enums) > 0:
        builder = builder_emit_blank(builder)
        builder = emit_enum_definitions(builder, enums)
    if len(structs) > 0:
        builder = builder_emit_blank(builder)
        struct_emission = emit_struct_definitions(builder, structs)
        builder = struct_emission.builder
        diagnostics = (diagnostics) + (struct_emission.diagnostics)
    builder = builder_emit_blank(builder)
    index = 0
    while True:
        if index >= len(functions):
            break
        emission = emit_python_function(builder, functions[index])
        builder = emission.builder
        diagnostics = (diagnostics) + (emission.diagnostics)
        if index + 1 < len(functions):
            builder = builder_emit_blank(builder)
        index += 1
    if len(export_names) > 0:
        builder = builder_emit_blank(builder)
        builder = emit_export_list(builder, export_names)
    return PythonModuleEmission(builder=builder, diagnostics=diagnostics)

def emit_runtime_aliases(builder):
    current = builder
    current = builder_emit(current, "print = runtime.console")
    current = builder_emit(current, "sleep = runtime.sleep")
    current = builder_emit(current, "channel = runtime.channel")
    current = builder_emit(current, "parallel = runtime.parallel")
    current = builder_emit(current, "spawn = runtime.spawn")
    current = builder_emit(current, "fs = runtime.fs")
    current = builder_emit(current, "serve = runtime.serve")
    current = builder_emit(current, "http = runtime.http")
    current = builder_emit(current, "websocket = runtime.websocket")
    current = builder_emit(current, "logExecution = runtime.logExecution")
    current = builder_emit(current, "array_map = runtime.array_map")
    current = builder_emit(current, "array_filter = runtime.array_filter")
    current = builder_emit(current, "array_reduce = runtime.array_reduce")
    current = builder_emit(current, "globals()['t' + 'rue'] = True")
    current = builder_emit(current, "globals()['f' + 'alse'] = False")
    return current

def emit_top_level_bindings(builder, bindings):
    current = builder
    index = 0
    while True:
        if index >= len(bindings):
            break
        binding = bindings[index]
        name = sanitize_identifier(binding.name)
        line = name + " = "
        if binding.value != null:
            value_text = binding.value
            line = line + lower_expression(value_text)
        else:
            line = line + "None"
        current = builder_emit(current, line)
        index += 1
    return current

def emit_python_imports(builder, imports):
    current = builder
    exports = []
    index = 0
    while True:
        if index >= len(imports):
            break
        entry = imports[index]
        if entry.kind == "export":
            exports = collect_export_names(exports, entry.specifiers)
            module_text = trim_text(entry.module)
            if len(module_text) == 0:
                index += 1
                continue
        line = render_python_import(entry)
        if len(line) > 0:
            current = builder_emit(current, line)
        index += 1
    return PythonImportEmission(builder=current, exports=exports)

def emit_enum_definitions(builder, enums):
    current = builder
    index = 0
    while True:
        if index >= len(enums):
            break
        current = emit_single_enum(current, enums[index])
        if index + 1 < len(enums):
            current = builder_emit_blank(current)
        index += 1
    return current

def emit_single_enum(builder, definition):
    enum_name = sanitize_identifier(definition.name)
    current = builder_emit(builder, enum_name + " = runtime.enum_type('" + enum_name + "')")
    index = 0
    while True:
        if index >= len(definition.variants):
            break
        variant = definition.variants[index]
        variant_name = sanitize_identifier(variant.name)
        variant_line = enum_name + " = runtime.enum_define_variant(" + enum_name + ", '" + variant_name + "', [" + render_enum_variant_fields(variant.fields) + "])"
        current = builder_emit(current, variant_line)
        index += 1
    return current

def render_enum_variant_fields(fields):
    if len(fields) == 0:
        return ""
    rendered = []
    index = 0
    while True:
        if index >= len(fields):
            break
        rendered = append_string(rendered, "'" + sanitize_identifier(fields[index].name) + "'")
        index += 1
    return join_with_separator(rendered, ", ")

def render_python_import(entry):
    module_path = normalize_import_module(entry.module)
    if len(module_path) == 0:
        return ""
    if len(entry.specifiers) == 0:
        return "import " + module_path
    rendered = render_python_specifiers(entry.specifiers)
    return "from " + module_path + " import " + rendered

def render_python_specifiers(specifiers):
    parts = []
    index = 0
    while True:
        if index >= len(specifiers):
            break
        parts = append_string(parts, render_python_specifier(specifiers[index]))
        index += 1
    return join_with_separator(parts, ", ")

def render_python_specifier(specifier):
    base = sanitize_identifier(specifier.name)
    if specifier.alias == null  or  len(specifier.alias) == 0:
        return base
    return base + " as " + sanitize_identifier(specifier.alias)

def normalize_import_module(path):
    trimmed = trim_text(path)
    if len(trimmed) == 0:
        return trimmed
    if starts_with(trimmed, "runtime/"):
        remainder = replace_all(trimmed, "/", ".")
        return "compiler.build." + remainder
    if starts_with(trimmed, "./"):
        remainder = substring(trimmed, 2, len(trimmed))
        remainder = replace_all(remainder, "/", ".")
        return "compiler.build." + remainder
    return replace_all(trimmed, "/", ".")

def emit_struct_definitions(builder, structs):
    current = builder
    diagnostics = []
    index = 0
    while True:
        if index >= len(structs):
            break
        emission = emit_single_struct(current, structs[index])
        current = emission.builder
        diagnostics = (diagnostics) + (emission.diagnostics)
        if index + 1 < len(structs):
            current = builder_emit_blank(current)
        index += 1
    return PythonStructEmission(builder=current, diagnostics=diagnostics)

def emit_export_list(builder, exports):
    unique = []
    index = 0
    while True:
        if index >= len(exports):
            break
        name = sanitize_identifier(exports[index])
        seen = false
        existing_index = 0
        while True:
            if existing_index >= len(unique):
                break
            if unique[existing_index] == name:
                seen = true
                break
            existing_index += 1
        if not seen:
            unique = append_string(unique, name)
        index += 1
    quoted = []
    index = 0
    while True:
        if index >= len(unique):
            break
        quoted = append_string(quoted, "\"" + unique[index] + "\"")
        index += 1
    return builder_emit(builder, "__all__ = [" + join_with_separator(quoted, ", ") + "]")

def collect_export_names(existing, specifiers):
    result = existing
    index = 0
    while True:
        if index >= len(specifiers):
            break
        specifier = specifiers[index]
        exported = select_export_name(specifier)
        if len(exported) > 0:
            result = append_string(result, exported)
        index += 1
    return result

def select_export_name(specifier):
    if specifier.alias != null  and  len(specifier.alias) > 0:
        return specifier.alias
    return specifier.name

def emit_single_struct(builder, definition):
    class_name = sanitize_identifier(definition.name)
    current = builder_emit(builder, "class " + class_name + ":")
    current = builder_push_indent(current)
    diagnostics = []
    parameters = render_struct_parameters(definition.fields)
    init_signature = "def __init__(self"
    if len(parameters) > 0:
        init_signature = init_signature + ", " + join_with_separator(parameters, ", ")
    init_signature = init_signature + ")"
    current = builder_emit(current, init_signature + ":")
    current = builder_push_indent(current)
    if len(definition.fields) == 0:
        current = builder_emit(current, "pass")
    else:
        index = 0
        while True:
            if index >= len(definition.fields):
                break
            field = definition.fields[index]
            attr_name = sanitize_identifier(field.name)
            current = builder_emit(current, "self." + attr_name + " = " + attr_name)
            index += 1
    current = builder_pop_indent(current)
    current = builder_emit_blank(current)
    current = builder_emit(current, "def __repr__(self):")
    current = builder_push_indent(current)
    repr_fields = render_struct_repr_fields(class_name, definition.fields)
    current = builder_emit(current, repr_fields)
    current = builder_pop_indent(current)
    if class_name == "EnumInstance":
        current = builder_emit_blank(current)
        current = builder_emit(current, "def __getattr__(self, item):")
        current = builder_push_indent(current)
        current = builder_emit(current, "index = 0")
        current = builder_emit(current, "while True:")
        current = builder_push_indent(current)
        current = builder_emit(current, "if index >= len(self.fields):")
        current = builder_push_indent(current)
        current = builder_emit(current, "break")
        current = builder_pop_indent(current)
        current = builder_emit(current, "field = self.fields[index]")
        current = builder_emit(current, "if field.name == item:")
        current = builder_push_indent(current)
        current = builder_emit(current, "return field.value")
        current = builder_pop_indent(current)
        current = builder_emit(current, "index += 1")
        current = builder_pop_indent(current)
        current = builder_emit(current, "raise AttributeError(item)")
        current = builder_pop_indent(current)
    if len(definition.methods) > 0:
        current = builder_emit_blank(current)
        method_index = 0
        while True:
            if method_index >= len(definition.methods):
                break
            method = definition.methods[method_index]
            emission = emit_python_function(current, method)
            current = emission.builder
            diagnostics = (diagnostics) + (emission.diagnostics)
            if method_index + 1 < len(definition.methods):
                current = builder_emit_blank(current)
            method_index += 1
    current = builder_pop_indent(current)
    return PythonStructEmission(builder=current, diagnostics=diagnostics)

def render_struct_parameters(fields):
    required = []
    optional = []
    index = 0
    while True:
        if index >= len(fields):
            break
        field = fields[index]
        name = sanitize_identifier(field.name)
        entry = name
        if is_optional_type(field.type_annotation):
            entry = entry + "=None"
            optional = append_string(optional, entry)
        else:
            required = append_string(required, entry)
        index += 1
    return (required) + (optional)

def render_struct_repr_fields(class_name, fields):
    if len(fields) == 0:
        return "return runtime.struct_repr('" + class_name + "', [])"
    rendered = []
    index = 0
    while True:
        if index >= len(fields):
            break
        field = fields[index]
        name = sanitize_identifier(field.name)
        rendered = append_string(rendered, "runtime.struct_field('" + name + "', self." + name + ")")
        index += 1
    return "return runtime.struct_repr('" + class_name + "', [" + join_with_separator(rendered, ", ") + "])"

def is_optional_type(type_annotation):
    trimmed = trim_text(type_annotation)
    if len(trimmed) == 0:
        return true
    return ends_with(trimmed, "?")

def lower_expression(expression):
    return lower_expression_with_depth(expression, 0)

def lower_expression_with_depth(expression, depth):
    if depth > 8:
        return trim_text(expression)
    trimmed = trim_text(expression)
    if len(trimmed) == 0:
        return trimmed
    interpolated = rewrite_interpolated_string_literal(trimmed)
    if interpolated != null:
        return interpolated
    struct_literal = lower_struct_literal_expression(trimmed, depth)
    if struct_literal != null:
        return struct_literal
    array_literal = lower_array_literal_expression(trimmed, depth)
    if array_literal != null:
        return array_literal
    rewritten = rewrite_expression_intrinsics(trimmed)
    return rewrite_struct_literals_inline(rewritten, depth)

def rewrite_interpolated_string_literal(expression):
    if len(expression) < 2:
        return null
    decoded = decode_string_literal(expression)
    if decoded == null:
        return null
    if find_substring(decoded, "{{") < 0:
        return null
    if find_substring(decoded, "}}") < 0:
        return null
    parts = []
    expressions = []
    index = 0
    while True:
        if index > len(decoded):
            break
        start = find_substring_from(decoded, "{{", index)
        if start < 0:
            tail = substring(decoded, index, len(decoded))
            parts = append_string(parts, tail)
            break
        prefix = substring(decoded, index, start)
        parts = append_string(parts, prefix)
        end = find_substring_from(decoded, "}}", start + 2)
        if end < 0:
            return null
        expr_text = trim_text(substring(decoded, start + 2, end))
        if len(expr_text) == 0:
            return null
        expressions = append_string(expressions, expr_text)
        index = end + 2
    if len(expressions) == 0:
        return null
    encoded_parts = []
    part_index = 0
    while True:
        if part_index >= len(parts):
            break
        encoded_parts = append_string(encoded_parts, python_string_literal(parts[part_index]))
        part_index = part_index + 1
    value_entries = []
    part_index = 0
    while True:
        if part_index >= len(expressions):
            break
        value_entries = append_string(value_entries, "(" + expressions[part_index] + ")")
        part_index = part_index + 1
    part_list = "[" + join_with_separator(encoded_parts, ", ") + "]"
    value_list = "[" + join_with_separator(value_entries, ", ") + "]"
    return "runtime.format_interpolated(" + part_list + ", " + value_list + ")"

def decode_string_literal(expression):
    if len(expression) < 2:
        return null
    quote = expression[0]
    if quote != "\""  and  quote != "'":
        return null
    if expression[len(expression) - 1] != quote:
        return null
    result = ""
    index = 1
    while True:
        if index >= len(expression) - 1:
            break
        ch = expression[index]
        if ch == "\\":
            index = index + 1
            if index >= len(expression) - 1:
                return null
            escape = expression[index]
            result = result + decode_escape_sequence(escape, quote)
            index = index + 1
            continue
        result = result + ch
        index = index + 1
    return result

def decode_escape_sequence(escape, quote):
    if escape == "n":
        return "\n"
    if escape == "r":
        return "\r"
    if escape == "t":
        return "\t"
    if escape == "\\":
        return "\\"
    if escape == quote:
        return quote
    return escape

def python_string_literal(value):
    result = "'"
    index = 0
    while True:
        if index >= len(value):
            break
        ch = value[index]
        if ch == "\\":
            result = result + "\\\\"
        else:
            if ch == "'":
                result = result + "\\'"
            else:
                if ch == "\n":
                    result = result + "\\n"
                else:
                    if ch == "\r":
                        result = result + "\\r"
                    else:
                        if ch == "\t":
                            result = result + "\\t"
                        else:
                            result = result + ch
        index = index + 1
    result = result + "'"
    return result

def find_substring(value, pattern):
    if len(pattern) == 0:
        return 0
    if len(value) < len(pattern):
        return -1
    index = 0
    while True:
        if index + len(pattern) > len(value):
            break
        matches = true
        offset = 0
        while True:
            if offset >= len(pattern):
                break
            if value[index + offset] != pattern[offset]:
                matches = false
                break
            offset = offset + 1
        if matches:
            return index
        index = index + 1
    return -1

def lower_struct_literal_expression(expression, depth):
    brace_index = index_of(expression, "{")
    if brace_index < 0:
        return null
    closing_index = find_matching_brace(expression, brace_index)
    if closing_index < 0:
        return null
    type_name = trim_text(substring(expression, 0, brace_index))
    if len(type_name) == 0:
        return null
    if not is_struct_literal_type_candidate(type_name):
        return null
    fields_text = substring(expression, brace_index + 1, closing_index)
    entries = split_struct_field_entries(fields_text)
    assignments = []
    enum_fields = []
    index = 0
    while True:
        if index >= len(entries):
            break
        entry = trim_trailing_delimiters(trim_text(entries[index]))
        if len(entry) == 0:
            index += 1
            continue
        colon_index = index_of(entry, ":")
        if colon_index < 0:
            index += 1
            continue
        name = trim_text(substring(entry, 0, colon_index))
        value_text = trim_text(substring(entry, colon_index + 1, len(entry)))
        if len(name) == 0:
            index += 1
            continue
        lowered_value = lower_expression_with_depth(value_text, depth + 1)
        sanitized_name = sanitize_identifier(name)
        assignments = append_string(assignments, sanitized_name + "=" + lowered_value)
        enum_fields = append_string(enum_fields, "runtime.enum_field('" + sanitized_name + "', " + lowered_value + ")")
        index += 1
    sanitized_type = sanitize_qualified_identifier(type_name)
    last_dot = -1
    index = 0
    while True:
        if index >= len(sanitized_type):
            break
        if sanitized_type[index] == ".":
            last_dot = index
        index += 1
    if last_dot >= 0:
        enum_target = substring(sanitized_type, 0, last_dot)
        variant_name = substring(sanitized_type, last_dot + 1, len(sanitized_type))
        field_list = "[" + join_with_separator(enum_fields, ", ") + "]"
        return "runtime.enum_instantiate(" + enum_target + ", '" + variant_name + "', " + field_list + ")"
    return sanitized_type + "(" + join_with_separator(assignments, ", ") + ")"

def is_struct_literal_type_candidate(text):
    if len(text) == 0:
        return false
    index = 0
    while True:
        if index >= len(text):
            break
        ch = text[index]
        if ch == ".":
            index += 1
            continue
        if is_identifier_char(ch):
            index += 1
            continue
        return false
    return true

def lower_array_literal_expression(expression, depth):
    trimmed = trim_text(expression)
    if len(trimmed) < 2:
        return null
    if trimmed[0] != "[":
        return null
    if trimmed[len(trimmed) - 1] != "]":
        return null
    inner = substring(trimmed, 1, len(trimmed) - 1)
    entries = split_array_entries(inner)
    lowered = []
    index = 0
    while True:
        if index >= len(entries):
            break
        entry = trim_trailing_delimiters(trim_text(entries[index]))
        if len(entry) > 0:
            lowered = append_string(lowered, lower_expression_with_depth(entry, depth + 1))
        index += 1
    return "[" + join_with_separator(lowered, ", ") + "]"

def rewrite_struct_literals_inline(expression, depth):
    if len(expression) == 0:
        return expression
    current = expression
    search_start = 0
    while True:
        if search_start >= len(current):
            break
        open_index = find_substring_from(current, "{", search_start)
        if open_index < 0:
            break
        type_end = open_index
        while True:
            if type_end <= 0:
                break
            prev = current[type_end - 1]
            if is_whitespace_char(prev):
                type_end -= 1
                continue
            break
        type_start = type_end
        while True:
            if type_start <= 0:
                break
            candidate_char = current[type_start - 1]
            if candidate_char == ".":
                type_start -= 1
                continue
            if is_identifier_char(candidate_char):
                type_start -= 1
                continue
            break
        if type_start == type_end:
            search_start = open_index + 1
            continue
        candidate = substring(current, type_start, type_end)
        if not is_struct_literal_type_candidate(candidate):
            search_start = open_index + 1
            continue
        if type_start > 0:
            prefix_char = current[type_start - 1]
            if is_identifier_char(prefix_char)  or  prefix_char == ".":
                search_start = open_index + 1
                continue
        closing_index = find_matching_brace(current, open_index)
        if closing_index < 0:
            break
        struct_text = substring(current, type_start, closing_index + 1)
        lowered = lower_struct_literal_expression(struct_text, depth + 1)
        if lowered == null:
            search_start = closing_index + 1
            continue
        prefix = substring(current, 0, type_start)
        suffix = substring(current, closing_index + 1, len(current))
        current = prefix + lowered + suffix
        search_start = type_start + len(lowered)
    return current

def capture_struct_literal_expression(initial, instructions, start_index):
    trimmed = trim_text(initial)
    if not ends_with(trimmed, "{"):
        return StructLiteralCapture(expression=trimmed, consumed=0, success=false)
    expression = trimmed
    index = start_index
    consumed = 0
    depth = compute_brace_balance(trimmed)
    if depth <= 0:
        return StructLiteralCapture(expression=trimmed, consumed=0, success=false)
    while True:
        if index >= len(instructions):
            break
        candidate = instructions[index]
        if candidate.variant != "Unknown":
            break
        segment = trim_text(candidate.text)
        if len(segment) > 0:
            expression = expression + " " + segment
        depth += compute_brace_balance(segment)
        consumed += 1
        index += 1
        if depth <= 0:
            break
    if depth != 0:
        return StructLiteralCapture(expression=trimmed, consumed=0, success=false)
    if consumed == 0:
        return StructLiteralCapture(expression=trimmed, consumed=0, success=false)
    normalized = trim_trailing_delimiters(trim_text(expression))
    if not ends_with(normalized, "}"):
        return StructLiteralCapture(expression=trimmed, consumed=0, success=false)
    return StructLiteralCapture(expression=normalized, consumed=consumed, success=true)

def rewrite_expression_intrinsics(expression):
    if len(expression) == 0:
        return expression
    current = expression
    current = rewrite_literal_tokens(current)
    current = rewrite_logical_operators(current)
    current = rewrite_push_calls(current)
    current = rewrite_concat_calls(current)
    current = rewrite_length_accesses(current)
    return current

def rewrite_logical_operators(expression):
    if len(expression) == 0:
        return expression
    result = ""
    index = 0
    while True:
        if index >= len(expression):
            break
        ch = expression[index]
        if ch == "'"  or  ch == "\"":
            literal_end = skip_string_literal(expression, index)
            result = result + substring(expression, index, literal_end)
            index = literal_end
            continue
        if ch == "&":
            if index + 1 < len(expression):
                next = expression[index + 1]
                if next == "&":
                    result = result + " and "
                    index += 2
                    continue
        if ch == "|":
            if index + 1 < len(expression):
                next = expression[index + 1]
                if next == "|":
                    result = result + " or "
                    index += 2
                    continue
        if ch == "!":
            if index + 1 < len(expression):
                next = expression[index + 1]
                if next == "=":
                    result = result + "!="
                    index += 2
                    continue
            result = result + "not "
            index += 1
            continue
        result = result + ch
        index += 1
    return result

def rewrite_literal_tokens(expression):
    if len(expression) == 0:
        return expression
    result = ""
    index = 0
    while True:
        if index >= len(expression):
            break
        ch = expression[index]
        if is_identifier_char(ch):
            start = index
            while True:
                index += 1
                if index >= len(expression):
                    break
                next = expression[index]
                if not is_identifier_char(next):
                    break
            token = substring(expression, start, index)
            if token == "null":
                result = result + "None"
            else:
                if token == "true":
                    result = result + "True"
                else:
                    if token == "false":
                        result = result + "False"
                    else:
                        result = result + token
            continue
        result = result + ch
        index += 1
    return result

def rewrite_push_calls(expression):
    if len(expression) == 0:
        return expression
    return replace_all(expression, ".push(", ".append(")

def rewrite_concat_calls(expression):
    current = expression
    while True:
        match_index = index_of(current, ".concat(")
        if match_index < 0:
            break
        object_span = extract_object_span(current, match_index)
        if not object_span.success:
            break
        paren_index = match_index + 7
        args_span = extract_parenthesized_span(current, paren_index)
        if not args_span.success:
            break
        before = substring(current, 0, object_span.start)
        after = substring(current, args_span.end, len(current))
        object_expr = trim_text(object_span.value)
        argument_expr = trim_text(args_span.value)
        replacement = "(" + object_expr + ") + (" + argument_expr + ")"
        current = before + replacement + after
    return current

def rewrite_length_accesses(expression):
    current = expression
    while True:
        match_index = index_of(current, ".length")
        if match_index < 0:
            break
        object_span = extract_object_span(current, match_index)
        if not object_span.success:
            break
        before = substring(current, 0, object_span.start)
        after = substring(current, match_index + 7, len(current))
        object_expr = trim_text(object_span.value)
        if len(object_expr) == 0:
            break
        current = before + "len(" + object_expr + ")" + after
    return current

def extract_object_span(text, dot_index):
    if dot_index <= 0:
        return ExtractedSpan(value="", start=0, end=0, success=false)
    index = dot_index - 1
    square_depth = 0
    paren_depth = 0
    while True:
        if index < 0:
            break
        ch = text[index]
        if ch == "]":
            square_depth += 1
            index -= 1
            continue
        if ch == "[":
            if square_depth > 0:
                square_depth -= 1
                index -= 1
                continue
            break
        if ch == ")":
            paren_depth += 1
            index -= 1
            continue
        if ch == "(":
            if paren_depth > 0:
                paren_depth -= 1
                index -= 1
                continue
            break
        if square_depth > 0  or  paren_depth > 0:
            index -= 1
            continue
        if is_identifier_char(ch)  or  ch == ".":
            index -= 1
            continue
        break
    start = index + 1
    if start >= dot_index:
        return ExtractedSpan(value="", start=start, end=dot_index, success=false)
    value = substring(text, start, dot_index)
    return ExtractedSpan(value=value, start=start, end=dot_index, success=true)

def extract_parenthesized_span(text, open_index):
    if open_index >= len(text):
        return ExtractedSpan(value="", start=open_index, end=open_index, success=false)
    if text[open_index] != "(":
        return ExtractedSpan(value="", start=open_index, end=open_index, success=false)
    index = open_index + 1
    depth = 1
    while True:
        if index >= len(text):
            break
        ch = text[index]
        if ch == "(":
            depth += 1
        else:
            if ch == ")":
                depth -= 1
                if depth == 0:
                    value = substring(text, open_index + 1, index)
                    return ExtractedSpan(value=value, start=open_index + 1, end=index + 1, success=true)
            else:
                if ch == "\""  or  ch == "'":
                    index = skip_string_literal(text, index)
                    continue
        index += 1
    return ExtractedSpan(value="", start=open_index, end=open_index, success=false)

def skip_string_literal(text, quote_index):
    quote = text[quote_index]
    index = quote_index + 1
    while True:
        if index >= len(text):
            break
        ch = text[index]
        if ch == "\\":
            index += 2
            continue
        if ch == quote:
            index += 1
            break
        index += 1
    return index

def capture_expression_continuation(initial, instructions, start_index):
    trimmed = trim_text(initial)
    if len(trimmed) == 0:
        return ExpressionContinuationCapture(expression=trimmed, consumed=0, success=false)
    paren_balance = compute_parenthesis_balance(trimmed)
    brace_balance = compute_brace_balance(trimmed)
    bracket_balance = compute_bracket_balance(trimmed)
    expression = trimmed
    index = start_index
    consumed = 0
    attempting = paren_balance > 0  or  brace_balance > 0  or  bracket_balance > 0
    while True:
        if index >= len(instructions):
            break
        segment = continuation_segment_text(instructions[index])
        if segment == null:
            break
        normalized_segment = trim_text(segment)
        if len(normalized_segment) == 0:
            index += 1
            consumed += 1
            continue
        if not attempting:
            if not segment_signals_expression_continuation(normalized_segment):
                break
            attempting = true
        expression = expression + " " + normalized_segment
        paren_balance += compute_parenthesis_balance(normalized_segment)
        brace_balance += compute_brace_balance(normalized_segment)
        bracket_balance += compute_bracket_balance(normalized_segment)
        consumed += 1
        index += 1
        if paren_balance <= 0  and  brace_balance <= 0  and  bracket_balance <= 0:
            should_finalize = true
            lookahead = index
            while True:
                if lookahead >= len(instructions):
                    break
                upcoming = continuation_segment_text(instructions[lookahead])
                if upcoming == null:
                    break
                normalized_upcoming = trim_text(upcoming)
                if len(normalized_upcoming) == 0:
                    lookahead += 1
                    continue
                if segment_signals_expression_continuation(normalized_upcoming):
                    should_finalize = false
                break
            if should_finalize:
                finalized = trim_trailing_delimiters(trim_text(expression))
                return ExpressionContinuationCapture(expression=finalized, consumed=consumed, success=true)
    if not attempting  or  consumed == 0:
        return ExpressionContinuationCapture(expression=trimmed, consumed=0, success=false)
    if paren_balance <= 0  and  brace_balance <= 0  and  bracket_balance <= 0:
        finalized = trim_trailing_delimiters(trim_text(expression))
        return ExpressionContinuationCapture(expression=finalized, consumed=consumed, success=true)
    return ExpressionContinuationCapture(expression=trimmed, consumed=0, success=false)

def continuation_segment_text(instruction):
    if instruction.variant == "Unknown":
        return instruction.text
    if instruction.variant == "Expression":
        return instruction.expression
    return null

def segment_signals_expression_continuation(segment):
    if len(segment) == 0:
        return false
    if starts_with(segment, "&&"):
        return true
    if starts_with(segment, "||"):
        return true
    first = segment[0]
    if first == "."  or  first == ")"  or  first == "]"  or  first == "}":
        return true
    return false

def compute_brace_balance(text):
    if len(text) == 0:
        return 0
    balance = 0
    index = 0
    while True:
        if index >= len(text):
            break
        ch = text[index]
        if ch == "{":
            balance += 1
        else:
            if ch == "}":
                balance -= 1
        index += 1
    return balance

def compute_parenthesis_balance(text):
    return compute_symbol_balance(text, "(", ")")

def compute_bracket_balance(text):
    return compute_symbol_balance(text, "[", "]")

def compute_symbol_balance(text, open, close):
    if len(text) == 0:
        return 0
    balance = 0
    index = 0
    while True:
        if index >= len(text):
            break
        ch = text[index]
        if ch == open:
            balance += 1
        else:
            if ch == close:
                balance -= 1
        index += 1
    return balance

def split_struct_field_entries(text):
    entries = []
    current = ""
    depth = 0
    index = 0
    while True:
        if index >= len(text):
            break
        ch = text[index]
        if ch == "{"  or  ch == "["  or  ch == "(":
            depth += 1
        else:
            if ch == "}"  or  ch == "]"  or  ch == ")":
                if depth > 0:
                    depth -= 1
        if ch == ","  and  depth == 0:
            entries = append_string(entries, current)
            current = ""
        else:
            current = current + ch
        index += 1
    if len(current) > 0:
        entries = append_string(entries, current)
    return entries

def split_array_entries(text):
    entries = []
    current = ""
    depth = 0
    index = 0
    while True:
        if index >= len(text):
            break
        ch = text[index]
        if ch == "{"  or  ch == "["  or  ch == "(":
            depth += 1
        else:
            if ch == "}"  or  ch == "]"  or  ch == ")":
                if depth > 0:
                    depth -= 1
        if ch == ","  and  depth == 0:
            entries = append_string(entries, current)
            current = ""
        else:
            current = current + ch
        index += 1
    if len(current) > 0:
        entries = append_string(entries, current)
    return entries

def trim_trailing_delimiters(text):
    end = len(text)
    while True:
        if end <= 0:
            break
        ch = text[end - 1]
        if ch == ","  or  ch == ";":
            end -= 1
            continue
        break
    if end == len(text):
        return text
    return substring(text, 0, end)

def index_of(value, target):
    if len(target) == 0:
        return 0
    index = 0
    while True:
        if index + len(target) > len(value):
            break
        match_index = 0
        matches = true
        while True:
            if match_index >= len(target):
                break
            if value[index + match_index] != target[match_index]:
                matches = false
                break
            match_index += 1
        if matches:
            return index
        index += 1
    return -1

def find_matching_brace(text, open_index):
    depth = 0
    index = open_index
    while True:
        if index >= len(text):
            break
        ch = text[index]
        if ch == "{":
            depth += 1
        else:
            if ch == "}":
                if depth <= 0:
                    return -1
                depth -= 1
                if depth == 0:
                    return index
        index += 1
    return -1

def find_substring_from(value, pattern, start):
    if len(pattern) == 0:
        if start < 0:
            return 0
        if start > len(value):
            return len(value)
        return start
    index = start
    if index < 0:
        index = 0
    while True:
        if index + len(pattern) > len(value):
            break
        matches = true
        offset = 0
        while True:
            if offset >= len(pattern):
                break
            if value[index + offset] != pattern[offset]:
                matches = false
                break
            offset += 1
        if matches:
            return index
        index += 1
    return -1

def emit_python_function(builder, function):
    current = builder
    diagnostics = []
    parameters = render_python_parameters(function.parameters)
    header = "def " + sanitize_identifier(function.name) + "(" + join_with_separator(parameters, ", ") + "):"
    current = builder_emit(current, header)
    current = builder_push_indent(current)
    if len(function.effects) > 0:
        current = builder_emit(current, "# effects: " + join_with_separator(function.effects, ", "))
    if len(function.instructions) == 0:
        current = builder_emit(current, "pass")
        current = builder_pop_indent(current)
        return PythonFunctionEmission(builder=current, diagnostics=diagnostics)
    block_depth = 0
    match_stack = []
    match_counter = 0
    index = 0
    while True:
        if index >= len(function.instructions):
            break
        instruction = function.instructions[index]
        if instruction.variant == "Return":
            if len(instruction.expression) == 0:
                current = builder_emit(current, "return")
            else:
                expression_text = instruction.expression
                struct_capture = capture_struct_literal_expression(expression_text, function.instructions, index + 1)
                consumed = 0
                if struct_capture.success:
                    expression_text = struct_capture.expression
                    consumed = struct_capture.consumed
                else:
                    continuation = capture_expression_continuation(expression_text, function.instructions, index + 1)
                    if continuation.success:
                        expression_text = continuation.expression
                        consumed = continuation.consumed
                current = builder_emit(current, "return " + lower_expression(expression_text))
                index += consumed
        else:
            if instruction.variant == "Expression":
                expression_text = instruction.expression
                struct_capture = capture_struct_literal_expression(expression_text, function.instructions, index + 1)
                consumed = 0
                if struct_capture.success:
                    expression_text = struct_capture.expression
                    consumed = struct_capture.consumed
                else:
                    continuation = capture_expression_continuation(expression_text, function.instructions, index + 1)
                    if continuation.success:
                        expression_text = continuation.expression
                        consumed = continuation.consumed
                current = builder_emit(current, lower_expression(expression_text))
                index += consumed
            else:
                if instruction.variant == "Let":
                    target_name = sanitize_identifier(instruction.name)
                    line = target_name + " = "
                    if instruction.value != null:
                        value_text = instruction.value
                        struct_capture = capture_struct_literal_expression(value_text, function.instructions, index + 1)
                        consumed = 0
                        if struct_capture.success:
                            value_text = struct_capture.expression
                            consumed = struct_capture.consumed
                        else:
                            continuation = capture_expression_continuation(value_text, function.instructions, index + 1)
                            if continuation.success:
                                value_text = continuation.expression
                                consumed = continuation.consumed
                        line = line + lower_expression(value_text)
                        index += consumed
                    else:
                        line = line + "None"
                    current = builder_emit(current, line)
                else:
                    if instruction.variant == "If":
                        lowered_condition = rewrite_expression_intrinsics(trim_text(instruction.condition))
                        current = builder_emit(current, "if " + lowered_condition + ":")
                        current = builder_push_indent(current)
                        block_depth += 1
                    else:
                        if instruction.variant == "Else":
                            if block_depth > 0:
                                current = builder_pop_indent(current)
                            else:
                                diagnostics = append_lowering_diagnostic(diagnostics, function.name, "else without matching if")
                            current = builder_emit(current, "else:")
                            current = builder_push_indent(current)
                        else:
                            if instruction.variant == "EndIf":
                                if block_depth > 0:
                                    current = builder_pop_indent(current)
                                    block_depth -= 1
                                else:
                                    diagnostics = append_lowering_diagnostic(diagnostics, function.name, "endif without matching if")
                            else:
                                if instruction.variant == "For":
                                    lowered_iterable = rewrite_expression_intrinsics(trim_text(instruction.iterable))
                                    current = builder_emit(current, "for " + instruction.target + " in " + lowered_iterable + ":")
                                    current = builder_push_indent(current)
                                    block_depth += 1
                                else:
                                    if instruction.variant == "EndFor":
                                        if block_depth > 0:
                                            current = builder_pop_indent(current)
                                            block_depth -= 1
                                        else:
                                            diagnostics = append_lowering_diagnostic(diagnostics, function.name, "endfor without matching for loop")
                                    else:
                                        if instruction.variant == "Loop":
                                            current = builder_emit(current, "while True:")
                                            current = builder_push_indent(current)
                                            block_depth += 1
                                        else:
                                            if instruction.variant == "EndLoop":
                                                if block_depth > 0:
                                                    current = builder_pop_indent(current)
                                                    block_depth -= 1
                                                else:
                                                    diagnostics = append_lowering_diagnostic(diagnostics, function.name, "endloop without matching loop")
                                            else:
                                                if instruction.variant == "Break":
                                                    current = builder_emit(current, "break")
                                                else:
                                                    if instruction.variant == "Continue":
                                                        current = builder_emit(current, "continue")
                                                    else:
                                                        if instruction.variant == "Match":
                                                            subject_name = generate_match_subject_name(match_counter)
                                                            match_counter += 1
                                                            lowered_subject = lower_expression(instruction.expression)
                                                            current = builder_emit(current, subject_name + " = " + lowered_subject)
                                                            context = MatchContext(subject_name=subject_name, case_index=0, has_active_case=false)
                                                            match_stack = append_match_context(match_stack, context)
                                                        else:
                                                            if instruction.variant == "Case":
                                                                if len(match_stack) == 0:
                                                                    pattern_summary = trim_text(instruction.pattern)
                                                                    detail = "match case without active match context"
                                                                    if len(pattern_summary) > 0:
                                                                        detail = detail + " (pattern: " + pattern_summary + ")"
                                                                    diagnostics = append_lowering_diagnostic(diagnostics, function.name, detail)
                                                                    current = builder_emit(current, "# unsupported: match case without context")
                                                                else:
                                                                    top_index = len(match_stack) - 1
                                                                    context = match_stack[top_index]
                                                                    if context.has_active_case:
                                                                        current = builder_pop_indent(current)
                                                                    lowered = lower_match_case_condition(context.subject_name, instruction.pattern, instruction.guard)
                                                                    if context.case_index == 0:
                                                                        current = builder_emit(current, "if " + lowered.condition + ":")
                                                                    else:
                                                                        if lowered.is_default  and  not lowered.has_guard:
                                                                            current = builder_emit(current, "else:")
                                                                        else:
                                                                            current = builder_emit(current, "elif " + lowered.condition + ":")
                                                                    current = builder_push_indent(current)
                                                                    updated = MatchContext(subject_name=context.subject_name, case_index=context.case_index + 1, has_active_case=true)
                                                                    match_stack = replace_match_context(match_stack, top_index, updated)
                                                            else:
                                                                if instruction.variant == "EndMatch":
                                                                    if len(match_stack) == 0:
                                                                        diagnostics = append_lowering_diagnostic(diagnostics, function.name, "endmatch without active match context")
                                                                        current = builder_emit(current, "# unsupported: endmatch without context")
                                                                    else:
                                                                        top_index = len(match_stack) - 1
                                                                        context = match_stack[top_index]
                                                                        if context.has_active_case:
                                                                            current = builder_pop_indent(current)
                                                                        match_stack = truncate_match_contexts(match_stack, top_index)
                                                                else:
                                                                    if instruction.variant == "Noop":
                                                                        current = builder_emit(current, "pass")
                                                                    else:
                                                                        trimmed_text = trim_text(instruction.text)
                                                                        detail = "unsupported instruction emitted as comment"
                                                                        if len(trimmed_text) > 0:
                                                                            detail = detail + ": " + trimmed_text
                                                                        diagnostics = append_lowering_diagnostic(diagnostics, function.name, detail)
                                                                        current = builder_emit(current, "# unsupported: " + instruction.text)
        index += 1
    while True:
        if len(match_stack) == 0:
            break
        top_index = len(match_stack) - 1
        context = match_stack[top_index]
        if context.has_active_case:
            current = builder_pop_indent(current)
        diagnostics = append_lowering_diagnostic(diagnostics, function.name, "unterminated match expression")
        match_stack = truncate_match_contexts(match_stack, top_index)
    while True:
        if block_depth <= 0:
            break
        current = builder_pop_indent(current)
        block_depth -= 1
        diagnostics = append_lowering_diagnostic(diagnostics, function.name, "unterminated control-flow block")
    current = builder_pop_indent(current)
    return PythonFunctionEmission(builder=current, diagnostics=diagnostics)

def append_match_context(values, value):
    return (values) + ([value])

def replace_match_context(values, index, replacement):
    result = []
    position = 0
    while True:
        if position >= len(values):
            break
        if position == index:
            result = append_match_context(result, replacement)
        else:
            result = append_match_context(result, values[position])
        position += 1
    return result

def truncate_match_contexts(values, end_index):
    if end_index <= 0:
        return []
    result = []
    index = 0
    while True:
        if index >= end_index:
            break
        result = append_match_context(result, values[index])
        index += 1
    return result

def generate_match_subject_name(counter):
    return "__match_value_" + number_to_string(counter)

def lower_match_case_condition(subject_name, pattern, guard):
    trimmed_pattern = trim_text(pattern)
    normalized_guard = null
    if guard != null:
        trimmed_guard = trim_text(guard)
        if len(trimmed_guard) > 0:
            normalized_guard = trimmed_guard
    if len(trimmed_pattern) == 0  or  trimmed_pattern == "_":
        if normalized_guard == null:
            return LoweredCaseCondition(condition="True", is_default=true, has_guard=false)
        lowered_guard = lower_expression(normalized_guard)
        return LoweredCaseCondition(condition=lowered_guard, is_default=false, has_guard=true)
    lowered_pattern = lower_expression(trimmed_pattern)
    condition = subject_name + " == " + lowered_pattern
    has_guard = false
    if normalized_guard != null:
        lowered_guard = lower_expression(normalized_guard)
        condition = "(" + condition + ") and (" + lowered_guard + ")"
        has_guard = true
    return LoweredCaseCondition(condition=condition, is_default=false, has_guard=has_guard)

def number_to_string(value):
    if value == 0:
        return "0"
    digits = "0123456789"
    remaining = value
    output = ""
    while True:
        if remaining <= 0:
            break
        temp = remaining
        quotient = 0
        while True:
            if temp < 10:
                break
            temp -= 10
            quotient += 1
        digit = temp
        ch = substring(digits, digit, digit + 1)
        output = ch + output
        remaining = quotient
    return output

def render_python_parameters(parameters):
    if len(parameters) == 0:
        return []
    rendered = []
    index = 0
    while True:
        if index >= len(parameters):
            break
        parameter = parameters[index]
        entry = parameter.name
        if parameter.default_value != null:
            entry = entry + " = " + parameter.default_value
        rendered = append_string(rendered, entry)
        index += 1
    return rendered

def builder_new():
    return PythonBuilder(lines=[], indent=0)

def builder_emit(builder, line):
    if len(line) == 0:
        return builder_emit_blank(builder)
    prefix = ""
    count = 0
    while True:
        if count >= builder.indent:
            break
        prefix = prefix + "    "
        count += 1
    full_line = prefix + line
    lines = append_string(builder.lines, full_line)
    return PythonBuilder(lines=lines, indent=builder.indent)

def builder_emit_blank(builder):
    lines = append_string(builder.lines, "")
    return PythonBuilder(lines=lines, indent=builder.indent)

def builder_push_indent(builder):
    return PythonBuilder(lines=builder.lines, indent=builder.indent + 1)

def builder_pop_indent(builder):
    indent = builder.indent
    if indent > 0:
        indent -= 1
    return PythonBuilder(lines=builder.lines, indent=indent)

def builder_to_string(builder):
    content = join_with_separator(builder.lines, "\n")
    if len(content) == 0:
        return ""
    return content + "\n"

def sanitize_identifier(name):
    result = ""
    index = 0
    while True:
        if index >= len(name):
            break
        ch = name[index]
        if is_identifier_char(ch):
            result = result + ch
        else:
            if ch == " ":
                result = result + "_"
        index += 1
    if len(result) == 0:
        return "generated_function"
    return result

def sanitize_qualified_identifier(name):
    trimmed = trim_text(name)
    if len(trimmed) == 0:
        return sanitize_identifier(trimmed)
    part = ""
    parts = []
    index = 0
    while True:
        if index >= len(trimmed):
            break
        ch = trimmed[index]
        if ch == ".":
            if len(part) > 0:
                parts = append_string(parts, sanitize_identifier(part))
                part = ""
        else:
            part = part + ch
        index += 1
    if len(part) > 0:
        parts = append_string(parts, sanitize_identifier(part))
    if len(parts) == 0:
        return sanitize_identifier(trimmed)
    return join_with_separator(parts, ".")

def is_identifier_char(ch):
    if ch == "_":
        return true
    code = char_code(ch)
    if code >= char_code("a")  and  code <= char_code("z"):
        return true
    if code >= char_code("A")  and  code <= char_code("Z"):
        return true
    if code >= char_code("0")  and  code <= char_code("9"):
        return true
    return false

def is_whitespace_char(ch):
    if ch == " ":
        return true
    if ch == "\n":
        return true
    if ch == "\r":
        return true
    if ch == "\t":
        return true
    return false

def trim_text(value):
    start = 0
    end = len(value)
    while True:
        if start >= end:
            break
        ch = value[start]
        if ch == " "  or  ch == "\n"  or  ch == "\r"  or  ch == "\t":
            start += 1
            continue
        break
    while True:
        if end <= start:
            break
        ch = value[end - 1]
        if ch == " "  or  ch == "\n"  or  ch == "\r"  or  ch == "\t":
            end -= 1
            continue
        break
    if start == 0  and  end == len(value):
        return value
    return substring(value, start, end)

def starts_with(value, prefix):
    if len(prefix) == 0:
        return true
    if len(value) < len(prefix):
        return false
    index = 0
    while True:
        if index >= len(prefix):
            break
        if value[index] != prefix[index]:
            return false
        index += 1
    return true

def ends_with(value, suffix):
    if len(suffix) == 0:
        return true
    if len(value) < len(suffix):
        return false
    index = 0
    while True:
        if index >= len(suffix):
            break
        if value[len(value) - len(suffix) + index] != suffix[index]:
            return false
        index += 1
    return true

def replace_all(value, target, replacement):
    if len(target) == 0:
        return value
    result = ""
    index = 0
    while True:
        if index >= len(value):
            break
        if index + len(target) <= len(value):
            matches = true
            offset = 0
            while True:
                if offset >= len(target):
                    break
                if value[index + offset] != target[offset]:
                    matches = false
                    break
                offset += 1
            if matches:
                result = result + replacement
                index += len(target)
                continue
        result = result + value[index]
        index += 1
    return result

def join_with_separator(values, separator):
    if len(values) == 0:
        return ""
    result = values[0]
    index = 1
    while True:
        if index >= len(values):
            break
        result = result + separator + values[index]
        index += 1
    return result

def append_lowering_diagnostic(diagnostics, function_name, detail):
    trimmed_name = trim_text(function_name)
    entry = "[lowering] "
    if len(trimmed_name) == 0:
        entry = entry + detail
    else:
        entry = entry + trimmed_name + ": " + detail
    return append_string(diagnostics, entry)

def append_string(values, value):
    return (values) + ([value])
