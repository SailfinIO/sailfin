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
globals()['t' + 'rue'] = True
globals()['f' + 'alse'] = False

console = runtime.console
fs = runtime.fs
http = runtime.http
websocket = runtime.websocket
ZERO_WIDTH_JOINER = 8205
GRAPHEME_EXTEND_RANGES = [768, 879, 1155, 1161, 1425, 1469, 1471, 1471, 1473, 1474, 1476, 1477, 1479, 1479, 1552, 1562, 1611, 1631, 1648, 1648, 1750, 1756, 1759, 1764, 1767, 1768, 1770, 1773, 1809, 1809, 1840, 1866, 1958, 1968, 2027, 2035, 2045, 2045, 2070, 2073, 2075, 2083, 2085, 2087, 2089, 2093, 2137, 2139, 2200, 2207, 2250, 2273, 2275, 2307, 2362, 2364, 2366, 2383, 2385, 2391, 2402, 2403, 2433, 2435, 2492, 2492, 2494, 2500, 2503, 2504, 2507, 2509, 2519, 2519, 2530, 2531, 2558, 2558, 2561, 2563, 2620, 2620, 2622, 2626, 2631, 2632, 2635, 2637, 2641, 2641, 2672, 2673, 2677, 2677, 2689, 2691, 2748, 2748, 2750, 2757, 2759, 2761, 2763, 2765, 2786, 2787, 2810, 2815, 2817, 2819, 2876, 2876, 2878, 2884, 2887, 2888, 2891, 2893, 2901, 2903, 2914, 2915, 2946, 2946, 3006, 3010, 3014, 3016, 3018, 3021, 3031, 3031, 3072, 3076, 3132, 3132, 3134, 3140, 3142, 3144, 3146, 3149, 3157, 3158, 3170, 3171, 3201, 3203, 3260, 3260, 3262, 3268, 3270, 3272, 3274, 3277, 3285, 3286, 3298, 3299, 3315, 3315, 3328, 3331, 3387, 3388, 3390, 3396, 3398, 3400, 3402, 3405, 3415, 3415, 3426, 3427, 3457, 3459, 3530, 3530, 3535, 3540, 3542, 3542, 3544, 3551, 3570, 3571, 3633, 3633, 3636, 3642, 3655, 3662, 3761, 3761, 3764, 3772, 3784, 3790, 3864, 3865, 3893, 3893, 3895, 3895, 3897, 3897, 3902, 3903, 3953, 3972, 3974, 3975, 3981, 3991, 3993, 4028, 4038, 4038, 4139, 4158, 4182, 4185, 4190, 4192, 4194, 4196, 4199, 4205, 4209, 4212, 4226, 4237, 4239, 4239, 4250, 4253, 4957, 4959, 5906, 5909, 5938, 5940, 5970, 5971, 6002, 6003, 6068, 6099, 6109, 6109, 6155, 6157, 6159, 6159, 6277, 6278, 6313, 6313, 6432, 6443, 6448, 6459, 6679, 6683, 6741, 6750, 6752, 6780, 6783, 6783, 6832, 6862, 6912, 6916, 6964, 6980, 7019, 7027, 7040, 7042, 7073, 7085, 7142, 7155, 7204, 7223, 7376, 7378, 7380, 7400, 7405, 7405, 7412, 7412, 7415, 7417, 7616, 7679, 8400, 8432, 11503, 11505, 11647, 11647, 11744, 11775, 12330, 12335, 12441, 12442, 42607, 42610, 42612, 42621, 42654, 42655, 42736, 42737, 43010, 43010, 43014, 43014, 43019, 43019, 43043, 43047, 43052, 43052, 43136, 43137, 43188, 43205, 43232, 43249, 43263, 43263, 43302, 43309, 43335, 43347, 43392, 43395, 43443, 43456, 43493, 43493, 43561, 43574, 43587, 43587, 43596, 43597, 43643, 43645, 43696, 43696, 43698, 43700, 43703, 43704, 43710, 43711, 43713, 43713, 43755, 43759, 43765, 43766, 44003, 44010, 44012, 44013, 64286, 64286, 65024, 65039, 65056, 65071, 66045, 66045, 66272, 66272, 66422, 66426, 68097, 68099, 68101, 68102, 68108, 68111, 68152, 68154, 68159, 68159, 68325, 68326, 68900, 68903, 69291, 69292, 69373, 69375, 69446, 69456, 69506, 69509, 69632, 69634, 69688, 69702, 69744, 69744, 69747, 69748, 69759, 69762, 69808, 69818, 69826, 69826, 69888, 69890, 69927, 69940, 69957, 69958, 70003, 70003, 70016, 70018, 70067, 70080, 70089, 70092, 70094, 70095, 70188, 70199, 70206, 70206, 70209, 70209, 70367, 70378, 70400, 70403, 70459, 70460, 70462, 70468, 70471, 70472, 70475, 70477, 70487, 70487, 70498, 70499, 70502, 70508, 70512, 70516, 70709, 70726, 70750, 70750, 70832, 70851, 71087, 71093, 71096, 71104, 71132, 71133, 71216, 71232, 71339, 71351, 71453, 71467, 71724, 71738, 71984, 71989, 71991, 71992, 71995, 71998, 72000, 72000, 72002, 72003, 72145, 72151, 72154, 72160, 72164, 72164, 72193, 72202, 72243, 72249, 72251, 72254, 72263, 72263, 72273, 72283, 72330, 72345, 72751, 72758, 72760, 72767, 72850, 72871, 72873, 72886, 73009, 73014, 73018, 73018, 73020, 73021, 73023, 73029, 73031, 73031, 73098, 73102, 73104, 73105, 73107, 73111, 73459, 73462, 73472, 73473, 73475, 73475, 73524, 73530, 73534, 73538, 78912, 78912, 78919, 78933, 92912, 92916, 92976, 92982, 94031, 94031, 94033, 94087, 94095, 94098, 94180, 94180, 94192, 94193, 113821, 113822, 118528, 118573, 118576, 118598, 119141, 119145, 119149, 119154, 119163, 119170, 119173, 119179, 119210, 119213, 119362, 119364, 121344, 121398, 121403, 121452, 121461, 121461, 121476, 121476, 121499, 121503, 121505, 121519, 122880, 122886, 122888, 122904, 122907, 122913, 122915, 122916, 122918, 122922, 123023, 123023, 123184, 123190, 123566, 123566, 123628, 123631, 124140, 124143, 125136, 125142, 125252, 125258, 127995, 127999, 917760, 917999]

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
    return runtime.create_capability_grant(effects)

def fs_bridge(grant):
    return runtime.create_filesystem_bridge(grant)

def http_bridge(grant):
    return runtime.create_http_bridge(grant)

def model_bridge(grant):
    return runtime.create_model_bridge(grant)

def sleep(milliseconds):
    # effects: clock
    runtime.sleep(milliseconds)

def channel(capacity = 0):
    # effects: io
    return runtime.channel(capacity)

def parallel(tasks):
    # effects: io
    results = []
    for task in tasks:
        value = task()
        results = (results) + ([value])
    return results

def spawn(task, name = ""):
    # effects: io
    if len(name) == 0:
        runtime.spawn(task)
        return
    runtime.spawn(task, name)

def logExecution(callable):
    return runtime.logExecution(callable)

def array_map(items, mapper):
    result = []
    for item in items:
        mapped = mapper(item)
        result = (result) + ([mapped])
    return result

def array_filter(items, predicate):
    result = []
    for item in items:
        if predicate(item):
            result = (result) + ([item])
    return result

def array_reduce(items, initial, reducer):
    accumulator = initial
    for item in items:
        accumulator = reducer(accumulator, item)
    return accumulator

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
    return runtime.to_debug_string(value)

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
        ch = value[start]
        if ch == " "  or  ch == "\n"  or  ch == "\t"  or  ch == "\r":
            start = start + 1
            continue
        break
    while True:
        if end <= start:
            break
        ch = value[end - 1]
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
        if value[index] != prefix[index]:
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
        if value[offset + index] != suffix[index]:
            return False
        index = index + 1
    return True

def descriptor_find_top_level(value, needle):
    trimmed = descriptor_trim(value)
    if len(needle) != 1:
        return -1
    target = needle[0]
    index = 0
    paren_depth = 0
    angle_depth = 0
    bracket_depth = 0
    while True:
        if index >= len(trimmed):
            break
        ch = trimmed[index]
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
        if current[0] != "(":
            return current
        if current[len(current) - 1] != ")":
            return current
        depth = 0
        index = 0
        valid = True
        while True:
            if index >= len(current):
                break
            ch = current[index]
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
    target = separator[0]
    while True:
        if index >= len(trimmed):
            break
        ch = trimmed[index]
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
    if trimmed[len(trimmed) - 1] == "?":
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
        return runtime.is_string(value)
    if name == "number":
        return runtime.is_number(value)
    if name == "boolean":
        return runtime.is_boolean(value)
    if name == "void":
        return runtime.is_void(value)
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
            return runtime.is_array(value)
        if not runtime.is_array(value):
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
        return runtime.is_callable(value)
    if descriptor.kind == "named":
        if descriptor.name == None:
            return False
        resolved = runtime.resolve_runtime_type(descriptor.name)
        return runtime.instance_of(value, resolved)
    if descriptor.kind == "unknown":
        return False
    return False

def check_type(value, descriptor):
    parsed = parse_type_descriptor(descriptor)
    return check_type_descriptor(value, parsed)

def serve(handler, config = null):
    # effects: io, net
    runtime.serve(handler, config)

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
        result = result + text[index]
        index = index + 1
    return result

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
    if len(target) == 2  and  target[0] == "\\":
        escape = target[1]
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
        if text[index] == target:
            return index
        index = index + 1
    return -1

def match_exhaustive_failed(value):
    message = runtime.format_interpolated(['Non-exhaustive match for value ', ''], [(value)])
    runtime.raise_value_error(message)

def char_code(character):
    if len(character) == 0:
        return -1
    ch = character[0]
    digits = "0123456789"
    digit_index = find_char(digits, ch, 0)
    if digit_index >= 0:
        return 48 + digit_index
    lowercase = "abcdefghijklmnopqrstuvwxyz"
    lowercase_index = find_char(lowercase, ch, 0)
    if lowercase_index >= 0:
        return 97 + lowercase_index
    uppercase = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    uppercase_index = find_char(uppercase, ch, 0)
    if uppercase_index >= 0:
        return 65 + uppercase_index
    if ch == " ":
        return 32
    if ch == "\n":
        return 10
    if ch == "\r":
        return 13
    if ch == "\t":
        return 9
    if ch == "\"":
        return 34
    if ch == "\\":
        return 92
    if ch == "_":
        return 95
    encoded = ch.encode("utf-8")
    count = len(encoded)
    if count == 0:
        return -1
    if count > 4:
        return -1
    index = 0
    code = 0
    while True:
        if index >= count:
            break
        byte = encoded[index]
        if index == 0:
            if byte < 128:
                return byte
            if byte >= 192  and  byte <= 223:
                code = byte - 192
            else:
                if byte >= 224  and  byte <= 239:
                    code = byte - 224
                else:
                    if byte >= 240  and  byte <= 247:
                        code = byte - 240
                    else:
                        return -1
        else:
            if byte < 128  or  byte > 191:
                return -1
            code = (code * 64) + (byte - 128)
        index = index + 1
    return code

def is_regional_indicator(codepoint):
    return codepoint >= 127462  and  codepoint <= 127487

def is_variation_selector(codepoint):
    if codepoint >= 65024  and  codepoint <= 65039:
        return True
    return codepoint >= 917760  and  codepoint <= 917999

def is_emoji_modifier(codepoint):
    return codepoint >= 127995  and  codepoint <= 127999

def is_codepoint_in_ranges(codepoint, ranges):
    index = 0
    while True:
        if index >= len(ranges):
            break
        start = ranges[index]
        end = ranges[index + 1]
        if codepoint < start:
            break
        if codepoint <= end:
            return True
        index = index + 2
    return False

def is_grapheme_extend(codepoint):
    if codepoint < 0:
        return False
    if is_variation_selector(codepoint):
        return True
    if is_emoji_modifier(codepoint):
        return True
    return is_codepoint_in_ranges(codepoint, GRAPHEME_EXTEND_RANGES)

def iter_grapheme_clusters(text):
    clusters = []
    if len(text) == 0:
        return clusters
    current = text[0]
    prev_code = char_code(current)
    prev_was_joiner = prev_code == ZERO_WIDTH_JOINER
    prev_was_ri = is_regional_indicator(prev_code)
    ri_run_length = 0
    if prev_was_ri:
        ri_run_length = 1
    index = 1
    while True:
        if index >= len(text):
            break
        character = text[index]
        codepoint = char_code(character)
        is_joiner = codepoint == ZERO_WIDTH_JOINER
        is_extend = is_grapheme_extend(codepoint)
        is_ri = is_regional_indicator(codepoint)
        start_new = False
        if prev_code == 13  and  codepoint == 10:
            start_new = False
        else:
            if prev_was_joiner:
                start_new = False
            else:
                if is_joiner:
                    start_new = False
                else:
                    if is_extend:
                        start_new = False
                    else:
                        if is_ri  and  prev_was_ri  and  ri_run_length % 2 == 1:
                            start_new = False
                        else:
                            start_new = True
        if start_new:
            clusters = (clusters) + ([current])
            current = character
            if is_ri:
                ri_run_length = 1
            else:
                ri_run_length = 0
        else:
            current = current + character
            if is_ri:
                ri_run_length = ri_run_length + 1
            else:
                if not is_joiner  and  not is_extend:
                    ri_run_length = 0
        prev_code = codepoint
        prev_was_joiner = is_joiner
        if is_joiner:
            prev_was_ri = False
            ri_run_length = 0
        else:
            if is_extend:
                pass
            else:
                prev_was_ri = is_ri
                if not is_ri:
                    ri_run_length = 0
        index = index + 1
    clusters = (clusters) + ([current])
    return clusters

def grapheme_count(text):
    clusters = iter_grapheme_clusters(text)
    return len(clusters)

def grapheme_at(text, index):
    if index < 0:
        return ""
    clusters = iter_grapheme_clusters(text)
    if index >= len(clusters):
        return ""
    return clusters[index]

__all__ = ["capability_grant", "fs_bridge", "http_bridge", "model_bridge", "clamp", "substring", "find_char", "grapheme_count", "grapheme_at", "char_code", "match_exhaustive_failed", "enum_type", "enum_define_variant", "enum_field", "enum_instantiate", "enum_get_field", "struct_field", "struct_repr", "check_type", "parse_type_descriptor", "format_interpolated"]
