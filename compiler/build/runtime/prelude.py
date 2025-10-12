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

class EnumField:
    def __init__(self, name, value):
        self.name = name
        self.value = value

class EnumVariantDefinition:
    def __init__(self, name, field_names):
        self.name = name
        self.field_names = field_names

class EnumType:
    def __init__(self, name, variants):
        self.name = name
        self.variants = variants

class EnumInstance:
    def __init__(self, type, variant, fields):
        self.type = type
        self.variant = variant
        self.fields = fields

class StructField:
    def __init__(self, name, value):
        self.name = name
        self.value = value

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
    if value == None:
        return "None"
    return "" + value

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
    message = "Non-exhaustive match for value()"
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

__all__ = ["clamp", "substring", "find_char", "char_code", "match_exhaustive_failed", "enum_type", "enum_define_variant", "enum_field", "enum_instantiate", "enum_get_field", "struct_field", "struct_repr"]
