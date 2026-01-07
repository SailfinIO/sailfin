import asyncio
from runtime import runtime_support as runtime


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

console = runtime.console
fs = runtime.fs
http = runtime.http
websocket = runtime.websocket
runtime_create_capability_grant = runtime.create_capability_grant
runtime_create_filesystem_bridge = runtime.create_filesystem_bridge
runtime_create_http_bridge = runtime.create_http_bridge
runtime_create_model_bridge = runtime.create_model_bridge
runtime_sleep_fn = runtime.sleep
runtime_monotonic_millis_fn = runtime.monotonic_millis
runtime_channel_fn = runtime.channel
runtime_spawn_fn = runtime.spawn
runtime_log_execution_fn = runtime.logExecution
runtime_to_debug_string_fn = runtime.to_debug_string
runtime_raise_value_error_fn = runtime.raise_value_error
runtime_is_string_fn = runtime.is_string
runtime_is_number_fn = runtime.is_number
runtime_is_boolean_fn = runtime.is_boolean
runtime_is_void_fn = runtime.is_void
runtime_is_array_fn = runtime.is_array
runtime_is_callable_fn = runtime.is_callable
runtime_resolve_runtime_type_fn = runtime.resolve_runtime_type
runtime_instance_of_fn = runtime.instance_of
runtime_serve_fn = runtime.serve
runtime_char_code_fn = runtime.char_code
runtime_parallel_fn = runtime.parallel
runtime_array_map_fn = runtime.array_map
runtime_array_filter_fn = runtime.array_filter
runtime_array_reduce_fn = runtime.array_reduce
runtime_grapheme_count_fn = runtime.grapheme_count
runtime_grapheme_at_fn = runtime.grapheme_at

class EnumField:
    def __init__(self, name, value):
        self.name = name
        self.value = value

    def __repr__(self):
        return runtime.struct_repr('EnumField', [runtime.struct_field('name', self.name), runtime.struct_field('value', self.value)])

class EnumVariantDefinition:
    def __init__(self, name, field_names):
        self.name = name
        self.field_names = field_names

    def __repr__(self):
        return runtime.struct_repr('EnumVariantDefinition', [runtime.struct_field('name', self.name), runtime.struct_field('field_names', self.field_names)])

class EnumType:
    def __init__(self, name, variants):
        self.name = name
        self.variants = variants

    def __repr__(self):
        return runtime.struct_repr('EnumType', [runtime.struct_field('name', self.name), runtime.struct_field('variants', self.variants)])

class EnumInstance:
    def __init__(self, type, variant, fields):
        self.type = type
        self.variant = variant
        self.fields = fields

    def __repr__(self):
        return runtime.struct_repr('EnumInstance', [runtime.struct_field('type', self.type), runtime.struct_field('variant', self.variant), runtime.struct_field('fields', self.fields)])

    def __getattr__(self, item):
        index = 0
        while True:
            if index >= len(self.fields):
                break
            field = self.fields[index]
            if field.name == item:
                return field.value
            index += 1
        raise AttributeError(item)

class StructField:
    def __init__(self, name, value):
        self.name = name
        self.value = value

    def __repr__(self):
        return runtime.struct_repr('StructField', [runtime.struct_field('name', self.name), runtime.struct_field('value', self.value)])

class TypeDescriptor:
    def __init__(self, kind, items, name=None):
        self.kind = kind
        self.name = name
        self.items = items

    def __repr__(self):
        return runtime.struct_repr('TypeDescriptor', [runtime.struct_field('kind', self.kind), runtime.struct_field('name', self.name), runtime.struct_field('items', self.items)])

def capability_grant(effects):
    return runtime_create_capability_grant(effects)

def fs_bridge(grant):
    return runtime_create_filesystem_bridge(grant)

def http_bridge(grant):
    return runtime_create_http_bridge(grant)

def model_bridge(grant):
    return runtime_create_model_bridge(grant)

def sleep(milliseconds):
    # effects: clock
    runtime_sleep_fn(milliseconds)

def monotonic_millis():
    # effects: clock
    return runtime_monotonic_millis_fn()

def channel(capacity = 0):
    # effects: io
    return runtime_channel_fn(capacity)

def parallel(tasks):
    # effects: io
    return runtime_parallel_fn(tasks)

def spawn(task, name = ""):
    # effects: io
    runtime_spawn_fn(task, name)

def logExecution(callable):
    return runtime_log_execution_fn(callable)

def array_map(items, mapper):
    return runtime_array_map_fn(items, mapper)

def array_filter(items, predicate):
    return runtime_array_filter_fn(items, predicate)

def array_reduce(items, initial, reducer):
    return runtime_array_reduce_fn(items, initial, reducer)

def char_at(value, index):
    if len(value) == 0:
        return ""
    if index < 0:
        return ""
    if index >= len(value):
        return ""
    return runtime_grapheme_at_fn(value, index)

def enum_type(name):
    return EnumType(name=name, variants=[])

def enum_field(name, value):
    return EnumField(name=name, value=value)

def enum_define_variant(enum_type, variant_name, field_names):
    variant = EnumVariantDefinition(name=variant_name, field_names=field_names)
    updated = (enum_type.variants) + ([variant])
    return EnumType(name=enum_type.name, variants=updated)

def enum_lookup_field(fields, name):
    index = 0
    while True:
        if index >= len(fields):
            break
        field = fields[index]
        if field.name == name:
            return field
        index = index + 1
    return None

def enum_find_variant(enum_type, variant_name):
    index = 0
    while True:
        if index >= len(enum_type.variants):
            break
        variant = enum_type.variants[index]
        if variant.name == variant_name:
            return variant
        index = index + 1
    return None

def enum_normalize_fields(definition, provided):
    if definition == None:
        return provided
    expected = definition.field_names
    if len(expected) == 0:
        return []
    normalized = []
    index = 0
    while True:
        if index >= len(expected):
            break
        field_name = expected[index]
        candidate = enum_lookup_field(provided, field_name)
        value = None
        if candidate != None:
            value = candidate.value
        normalized = (normalized) + ([EnumField(name=field_name, value=value)])
        index = index + 1
    return normalized

def enum_instantiate(enum_type, variant_name, provided):
    definition = enum_find_variant(enum_type, variant_name)
    fields = enum_normalize_fields(definition, provided)
    return EnumInstance(type=enum_type, variant=variant_name, fields=fields)

def enum_get_field(instance, name):
    index = 0
    while True:
        if index >= len(instance.fields):
            break
        field = instance.fields[index]
        if field.name == name:
            return field.value
        index = index + 1
    return None

def struct_field(name, value):
    return StructField(name=name, value=value)

def struct_repr(name, fields):
    result = name + "("
    index = 0
    while True:
        if index >= len(fields):
            break
        if index > 0:
            result = result + ", "
        field = fields[index]
        value_text = to_debug_string(field.value)
        result = result + field.name + "=" + value_text
        index = index + 1
    result = result + ")"
    return result

def to_debug_string(value):
    return runtime_to_debug_string_fn(value)

def format_interpolated(parts, values):
    result = ""
    index = 0
    while True:
        if index >= len(parts):
            break
        result = result + parts[index]
        if index < len(values):
            result = result + to_debug_string(values[index])
        index = index + 1
    return result

def type_descriptor(kind, name, items):
    return TypeDescriptor(kind=kind, name=name, items=items)

def type_descriptor_primitive(name):
    return type_descriptor("primitive", name, [])

def type_descriptor_union(descriptors):
    return type_descriptor("union", None, descriptors)

def type_descriptor_intersection(descriptors):
    return type_descriptor("intersection", None, descriptors)

def type_descriptor_array(inner):
    return type_descriptor("array", None, [inner])

def type_descriptor_function():
    return type_descriptor("function", None, [])

def type_descriptor_named(name):
    return type_descriptor("named", name, [])

def type_descriptor_unknown():
    return type_descriptor("unknown", None, [])

def descriptor_trim(value):
    start = 0
    end = len(value)
    while True:
        if start >= end:
            break
        ch = char_at(value, start)
        if ch == " "  or  ch == "\n"  or  ch == "\t"  or  ch == "\r":
            start = start + 1
            continue
        break
    while True:
        if end <= start:
            break
        ch = char_at(value, end - 1)
        if ch == " "  or  ch == "\n"  or  ch == "\t"  or  ch == "\r":
            end = end - 1
            continue
        break
    return substring(value, start, end)

def string_starts_with(value, prefix):
    if len(prefix) > len(value):
        return False
    index = 0
    while True:
        if index >= len(prefix):
            break
        value_ch = char_at(value, index)
        prefix_ch = char_at(prefix, index)
        if value_ch != prefix_ch:
            return False
        index = index + 1
    return True

def string_ends_with(value, suffix):
    if len(suffix) > len(value):
        return False
    offset = len(value) - len(suffix)
    index = 0
    while True:
        if index >= len(suffix):
            break
        value_ch = char_at(value, offset + index)
        suffix_ch = char_at(suffix, index)
        if value_ch != suffix_ch:
            return False
        index = index + 1
    return True

def descriptor_find_top_level(value, needle):
    trimmed = descriptor_trim(value)
    if len(needle) != 1:
        return -1
    target = char_at(needle, 0)
    index = 0
    paren_depth = 0
    angle_depth = 0
    bracket_depth = 0
    while True:
        if index >= len(trimmed):
            break
        ch = char_at(trimmed, index)
        if ch == "(":
            paren_depth = paren_depth + 1
        else:
            if ch == ")":
                if paren_depth > 0:
                    paren_depth = paren_depth - 1
            else:
                if ch == "<":
                    angle_depth = angle_depth + 1
                else:
                    if ch == ">":
                        if angle_depth > 0:
                            angle_depth = angle_depth - 1
                    else:
                        if ch == "[":
                            bracket_depth = bracket_depth + 1
                        else:
                            if ch == "]":
                                if bracket_depth > 0:
                                    bracket_depth = bracket_depth - 1
        if ch == target  and  paren_depth == 0  and  angle_depth == 0  and  bracket_depth == 0:
            return index
        index = index + 1
    return -1

def descriptor_strip_outer_parens(value):
    current = descriptor_trim(value)
    while True:
        if len(current) < 2:
            return current
        if char_at(current, 0) != "(":
            return current
        if char_at(current, len(current) - 1) != ")":
            return current
        depth = 0
        index = 0
        valid = True
        while True:
            if index >= len(current):
                break
            ch = char_at(current, index)
            if ch == "(":
                depth = depth + 1
            else:
                if ch == ")":
                    depth = depth - 1
                    if depth < 0:
                        valid = False
                        break
                    if depth == 0  and  index < len(current) - 1:
                        valid = False
                        break
            index = index + 1
        if not valid  or  depth != 0:
            return current
        current = descriptor_trim(substring(current, 1, len(current) - 1))
    return current

def split_descriptor(value, separator):
    trimmed = descriptor_trim(value)
    if len(separator) != 1:
        return [trimmed]
    parts = []
    start = 0
    index = 0
    paren_depth = 0
    angle_depth = 0
    bracket_depth = 0
    target = char_at(separator, 0)
    while True:
        if index >= len(trimmed):
            break
        ch = char_at(trimmed, index)
        if ch == "(":
            paren_depth = paren_depth + 1
        else:
            if ch == ")":
                if paren_depth > 0:
                    paren_depth = paren_depth - 1
            else:
                if ch == "<":
                    angle_depth = angle_depth + 1
                else:
                    if ch == ">":
                        if angle_depth > 0:
                            angle_depth = angle_depth - 1
                    else:
                        if ch == "[":
                            bracket_depth = bracket_depth + 1
                        else:
                            if ch == "]":
                                if bracket_depth > 0:
                                    bracket_depth = bracket_depth - 1
        if ch == target  and  paren_depth == 0  and  angle_depth == 0  and  bracket_depth == 0:
            segment = substring(trimmed, start, index)
            parts = (parts) + ([descriptor_trim(segment)])
            start = index + 1
        index = index + 1
    tail = substring(trimmed, start, len(trimmed))
    cleaned_tail = descriptor_trim(tail)
    if len(cleaned_tail) > 0  or  len(parts) == 0:
        parts = (parts) + ([cleaned_tail])
    return parts

def parse_descriptor_list(parts):
    descriptors = []
    index = 0
    while True:
        if index >= len(parts):
            break
        entry = parts[index]
        if len(entry) > 0:
            descriptors = (descriptors) + ([parse_type_descriptor(entry)])
        index = index + 1
    return descriptors

def parse_type_descriptor(text):
    trimmed = descriptor_strip_outer_parens(text)
    if len(trimmed) == 0:
        return type_descriptor_unknown()
    union_parts = split_descriptor(trimmed, "|")
    if len(union_parts) > 1:
        return type_descriptor_union(parse_descriptor_list(union_parts))
    intersection_parts = split_descriptor(trimmed, "&")
    if len(intersection_parts) > 1:
        return type_descriptor_intersection(parse_descriptor_list(intersection_parts))
    if string_ends_with(trimmed, "[]"):
        inner_text = substring(trimmed, 0, len(trimmed) - 2)
        return type_descriptor_array(parse_type_descriptor(inner_text))
    if string_starts_with(trimmed, "fn("):
        return type_descriptor_function()
    if char_at(trimmed, len(trimmed) - 1) == "?":
        base_text = substring(trimmed, 0, len(trimmed) - 1)
        base_descriptor = parse_type_descriptor(base_text)
        void_descriptor = type_descriptor_primitive("void")
        return type_descriptor_union([base_descriptor, void_descriptor])
    generic_index = descriptor_find_top_level(trimmed, "<")
    normalized = trimmed
    if generic_index >= 0:
        normalized = descriptor_trim(substring(trimmed, 0, generic_index))
    if string_starts_with(normalized, "runtime."):
        normalized = descriptor_trim(substring(normalized, 8, len(normalized)))
    if normalized == "string"  or  normalized == "number"  or  normalized == "boolean"  or  normalized == "void":
        return type_descriptor_primitive(normalized)
    return type_descriptor_named(normalized)

def check_type_primitive(value, name):
    if name == "string":
        return runtime_is_string_fn(value)
    if name == "number":
        return runtime_is_number_fn(value)
    if name == "boolean":
        return runtime_is_boolean_fn(value)
    if name == "void":
        return runtime_is_void_fn(value)
    return False

def check_type_descriptor(value, descriptor):
    if descriptor.kind == "primitive":
        if descriptor.name == None:
            return False
        return check_type_primitive(value, descriptor.name)
    if descriptor.kind == "union":
        index = 0
        while True:
            if index >= len(descriptor.items):
                break
            if check_type_descriptor(value, descriptor.items[index]):
                return True
            index = index + 1
        return False
    if descriptor.kind == "intersection":
        index = 0
        while True:
            if index >= len(descriptor.items):
                break
            if not check_type_descriptor(value, descriptor.items[index]):
                return False
            index = index + 1
        return len(descriptor.items) > 0
    if descriptor.kind == "array":
        if len(descriptor.items) == 0:
            return runtime_is_array_fn(value)
        if not runtime_is_array_fn(value):
            return False
        element_descriptor = descriptor.items[0]
        index = 0
        while True:
            if index >= len(value):
                break
            if not check_type_descriptor(value[index], element_descriptor):
                return False
            index = index + 1
        return True
    if descriptor.kind == "function":
        return runtime_is_callable_fn(value)
    if descriptor.kind == "named":
        if descriptor.name == None:
            return False
        resolved = runtime_resolve_runtime_type_fn(descriptor.name)
        return runtime_instance_of_fn(value, resolved)
    if descriptor.kind == "unknown":
        return False
    return False

def check_type(value, descriptor):
    parsed = parse_type_descriptor(descriptor)
    return check_type_descriptor(value, parsed)

def serve(handler, config = null):
    # effects: io, net
    runtime_serve_fn(handler, config)

def clamp(value, minimum, maximum):
    if value < minimum:
        return minimum
    if value > maximum:
        return maximum
    return value

def substring(text, start, end):
    length = len(text)
    if length == 0:
        return ""
    normalized_start = clamp(start, 0, length)
    normalized_end = clamp(end, 0, length)
    if normalized_start >= normalized_end:
        return ""
    index = normalized_start
    result = ""
    while True:
        if index >= normalized_end:
            break
        result = result + char_at(text, index)
        index = index + 1
    return result

def strings_equal(left, right):
    if len(left) != len(right):
        return False
    index = 0
    while True:
        if index >= len(left):
            break
        left_char = char_at(left, index)
        right_char = char_at(right, index)
        if runtime_char_code_fn(left_char) != runtime_char_code_fn(right_char):
            return False
        index = index + 1
    return True

def find_char(text, character, start = 0):
    length = len(text)
    if length == 0:
        return -1
    normalized_start = start
    if normalized_start < 0:
        normalized_start = 0
    if normalized_start >= length:
        return -1
    target = character
    if len(target) == 2  and  char_at(target, 0) == "\\":
        escape = char_at(target, 1)
        if escape == "n":
            target = "\n"
        else:
            if escape == "r":
                target = "\r"
            else:
                if escape == "t":
                    target = "\t"
    index = normalized_start
    while True:
        if index >= length:
            break
        if strings_equal(char_at(text, index), target):
            return index
        index = index + 1
    return -1

def match_exhaustive_failed(value):
    message = runtime.format_interpolated(['Non-exhaustive match for value ', ''], [(value)])
    runtime_raise_value_error_fn(message)

def char_code(character):
    if len(character) == 0:
        return -1
    return runtime_char_code_fn(char_at(character, 0))

def grapheme_count(text):
    return runtime_grapheme_count_fn(text)

def grapheme_at(text, index):
    return runtime_grapheme_at_fn(text, index)

__all__ = ["capability_grant", "fs_bridge", "http_bridge", "model_bridge", "clamp", "substring", "find_char", "grapheme_count", "grapheme_at", "char_code", "match_exhaustive_failed", "enum_type", "enum_define_variant", "enum_field", "enum_instantiate", "enum_get_field", "struct_field", "struct_repr", "check_type", "parse_type_descriptor", "format_interpolated"]
