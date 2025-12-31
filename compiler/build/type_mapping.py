import asyncio
from runtime import runtime_support as runtime

from compiler.build.string_utils import substring, char_code, char_at
from compiler.build.types import TypeContext, TypeAllocationInfo
from compiler.build.utils import trim_text, starts_with, ends_with, index_of, sanitize_symbol

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


def is_ascii_uppercase(ch):
    if len(ch) == 0:
        return False
    code = char_code(ch)
    return code >= char_code("A") and code <= char_code("Z")


def ends_with_pointer_suffix(value):
    trimmed = trim_text(value)
    if len(trimmed) == 0:
        return False
    return trimmed[len(trimmed) - 1] == "*"


def strip_pointer_suffix(value):
    trimmed = trim_text(value)
    if len(trimmed) == 0:
        return trimmed
    if trimmed[len(trimmed) - 1] != "*":
        return trimmed
    return trim_text(substring(trimmed, 0, len(trimmed) - 1))


def unwrap_move_wrapper(annotation):
    trimmed = trim_text(annotation)
    if len(trimmed) == 0:
        return trimmed
    if starts_with(trimmed, "Affine<") or starts_with(trimmed, "Linear<"):
        open_index = index_of(trimmed, "<")
        if open_index >= 0:
            if trimmed[len(trimmed) - 1] == ">":
                inner = substring(trimmed, open_index + 1, len(trimmed) - 1)
                return unwrap_move_wrapper(trim_text(inner))
    return trimmed


def looks_like_user_type(annotation):
    trimmed = trim_text(annotation)
    if len(trimmed) == 0:
        return False
    first = trimmed[0]
    if is_ascii_uppercase(first):
        return True
    index = 1
    while True:
        if index >= len(trimmed):
            break
        current = trimmed[index]
        if current == "." and index + 1 < len(trimmed):
            next = trimmed[index + 1]
            if is_ascii_uppercase(next):
                return True
        index += 1
    return False


def annotation_is_array(annotation):
    trimmed = trim_text(annotation)
    if len(trimmed) < 3:
        return False
    suffix = substring(trimmed, len(trimmed) - 2, len(trimmed))
    return suffix == "[]"


def is_copy_type(type_annotation, llvm_type):
    trimmed = trim_text(type_annotation)
    if starts_with(trimmed, "Affine<") or starts_with(trimmed, "Linear<"):
        return False
    if trimmed == "Affine" or trimmed == "Linear":
        return False
    if llvm_type == "double":
        return True
    if llvm_type == "i32":
        return True
    if llvm_type == "i64":
        return True
    if llvm_type == "i1":
        return True
    if ends_with_pointer_suffix(llvm_type):
        return True
    if len(trimmed) == 0:
        return True
    if trimmed[0] == "&":
        return True
    return False


def layout_annotation_requires_pointer(annotation):
    trimmed = trim_text(annotation)
    if len(trimmed) == 0:
        return False
    normalized = unwrap_move_wrapper(trimmed)
    if len(normalized) == 0:
        return False
    if starts_with(normalized, "mut "):
        remainder = trim_text(substring(normalized, 4, len(normalized)))
        if len(remainder) == 0:
            return False
        return layout_annotation_requires_pointer(remainder)
    if len(normalized) > 0:
        first = normalized[0]
        if first == "&":
            return True
    if len(normalized) > 0:
        last = normalized[len(normalized) - 1]
        if last == "?":
            return True
    if len(normalized) > 2:
        suffix = substring(normalized, len(normalized) - 2, len(normalized))
        if suffix == "[]":
            return True
    return False


def layout_annotation_base_type(annotation):
    trimmed = trim_text(annotation)
    if len(trimmed) == 0:
        return ""
    normalized = unwrap_move_wrapper(trimmed)
    if len(normalized) == 0:
        return ""
    if starts_with(normalized, "mut "):
        remainder = trim_text(substring(normalized, 4, len(normalized)))
        return layout_annotation_base_type(remainder)
    if len(normalized) > 0:
        first = normalized[0]
        if first == "&":
            inner_reference = trim_text(
                substring(normalized, 1, len(normalized)))
            return layout_annotation_base_type(inner_reference)
    if len(normalized) > 0:
        last = normalized[len(normalized) - 1]
        if last == "?":
            inner_optional = trim_text(
                substring(normalized, 0, len(normalized) - 1))
            return layout_annotation_base_type(inner_optional)
    if len(normalized) > 2:
        suffix = substring(normalized, len(normalized) - 2, len(normalized))
        if suffix == "[]":
            element = trim_text(substring(normalized, 0, len(normalized) - 2))
            return layout_annotation_base_type(element)
    return normalized


def layout_annotation_represents_user_value(annotation):
    if layout_annotation_requires_pointer(annotation):
        return False
    base = layout_annotation_base_type(annotation)
    if len(base) == 0:
        return False
    if base == "number":
        return False
    if base == "boolean" or base == "bool":
        return False
    if base == "string":
        return False
    if base == "void":
        return False
    if base == "any":
        return False
    if base == "i64" or base == "i32" or base == "i1" or base == "i8" or base == "usize":
        return False
    if looks_like_user_type(base):
        return True
    return False


def array_struct_type_for_element(element_type):
    return "{ " + element_type + "*, i64 }"


def array_pointer_type_for_element(element_type):
    return "{ " + element_type + "*, i64 }*"


def map_type_annotation(annotation):
    trimmed = trim_text(annotation)
    if len(trimmed) == 0:
        return "void"
    normalized = unwrap_move_wrapper(trimmed)
    if starts_with(normalized, "*"):
        remainder = trim_text(substring(normalized, 1, len(normalized)))
        if starts_with(remainder, "mut"):
            remainder = trim_text(substring(remainder, 3, len(remainder)))
        if remainder == "opaque":
            return "i8*"
        if len(remainder) == 0:
            return "i8*"
        inner = map_type_annotation(remainder)
        if len(inner) == 0 or inner == "void":
            return "i8*"
        if inner[len(inner) - 1] == "*":
            return inner
        return inner + "*"
    if len(normalized) > 0:
        optional_marker = normalized[len(normalized) - 1]
        if optional_marker == "?":
            inner_annotation = trim_text(
                substring(normalized, 0, len(normalized) - 1))
            if len(inner_annotation) == 0:
                return "i8*"
            inner_type = map_type_annotation(inner_annotation)
            if len(inner_type) == 0 or inner_type == "void":
                return "i8*"
            if len(inner_type) > 0 and inner_type[len(inner_type) - 1] == "*":
                return inner_type
            return inner_type + "*"
    if normalized == "number":
        return "double"
    if normalized == "boolean" or normalized == "bool":
        return "i1"
    if normalized == "usize":
        return "i64"
    if normalized == "int" or normalized == "i64":
        return "i64"
    if normalized == "i32":
        return "i32"
    if normalized == "u8":
        return "i8"
    if normalized == "string":
        return "i8*"
    if normalized == "void":
        return "void"
    if len(normalized) > 2:
        suffix = substring(normalized, len(normalized) - 2, len(normalized))
        if suffix == "[]":
            element_annotation = trim_text(
                substring(normalized, 0, len(normalized) - 2))
            element_type = map_type_annotation(element_annotation)
            if len(element_type) == 0:
                return "i8*"
            if not annotation_is_array(element_annotation) and layout_annotation_represents_user_value(element_annotation) and ends_with_pointer_suffix(element_type):
                stripped_element = strip_pointer_suffix(element_type)
                if len(stripped_element) > 0:
                    element_type = stripped_element
            aggregate = array_struct_type_for_element(element_type)
            return aggregate + "*"
    if looks_like_user_type(normalized):
        sanitized = sanitize_symbol(normalized)
        return "%" + sanitized + "*"
    return "i8*"


def map_struct_field_annotation(annotation):
    result = map_type_annotation(annotation)
    if result == "void":
        return ""
    return result


def map_struct_type_annotation(annotation):
    trimmed = trim_text(annotation)
    if len(trimmed) == 0:
        return ""
    normalized = unwrap_move_wrapper(trimmed)
    if looks_like_user_type(normalized):
        return "%" + sanitize_symbol(normalized)
    mapped = map_type_annotation(normalized)
    if ends_with_pointer_suffix(mapped):
        stripped = strip_pointer_suffix(mapped)
        if len(stripped) > 0:
            return stripped
    return mapped


def map_parameter_type(context, parameter_type):
    mapped = map_type_annotation(parameter_type)
    if mapped == "void":
        return ""
    return mapped


def map_local_type(context, annotation):
    mapped = map_type_annotation(annotation)
    if mapped == "void":
        return ""
    return mapped


def map_return_type(context, return_type):
    trimmed = trim_text(return_type)
    if len(trimmed) == 0 or trimmed == "void":
        return "void"
    normalized = unwrap_move_wrapper(trimmed)
    if starts_with(normalized, "*"):
        remainder = trim_text(substring(normalized, 1, len(normalized)))
        if starts_with(remainder, "mut"):
            remainder = trim_text(substring(remainder, 3, len(remainder)))
        if remainder == "opaque" or len(remainder) == 0:
            return "i8*"
        inner = map_return_type(context, remainder)
        if ends_with_pointer_suffix(inner):
            return inner
        if len(inner) == 0 or inner == "void":
            return "i8*"
        return inner + "*"
    union_type = map_union_type(context, normalized)
    if len(union_type) > 0:
        return union_type
    optional_type = map_optional_type(context, normalized)
    if len(optional_type) > 0:
        return optional_type
    reference_type = map_reference_type(context, normalized)
    if len(reference_type) > 0:
        return reference_type
    array_type = map_array_pointer_type(context, normalized)
    if len(array_type) > 0:
        return array_type
    primitive_type = map_primitive_type(context, normalized)
    if len(primitive_type) > 0:
        return primitive_type
    return "i8*"


def map_union_type(context, annotation):
    trimmed = trim_text(annotation)
    if len(trimmed) == 0:
        return ""
    index = 0
    depth = 0
    while True:
        if index >= len(trimmed):
            break
        ch = trimmed[index]
        if ch == "<" or ch == "(" or ch == "[":
            depth += 1
        else:
            if ch == ">" or ch == ")" or ch == "]":
                if depth > 0:
                    depth -= 1
            else:
                if ch == "|" and depth == 0:
                    return "i8*"
        index += 1
    return ""


def map_optional_type(context, annotation):
    trimmed = trim_text(annotation)
    if len(trimmed) == 0:
        return ""
    if trimmed[len(trimmed) - 1] != "?":
        return ""
    inner = trim_text(substring(trimmed, 0, len(trimmed) - 1))
    if len(inner) == 0:
        return "i8*"
    inner_type = map_type_annotation(inner)
    if len(inner_type) == 0 or inner_type == "void":
        return "i8*"
    if ends_with_pointer_suffix(inner_type):
        return inner_type
    return inner_type + "*"


def map_reference_type(context, annotation):
    trimmed = trim_text(annotation)
    if len(trimmed) == 0:
        return ""
    if trimmed[0] != "&":
        return ""
    remainder = trim_text(substring(trimmed, 1, len(trimmed)))
    if starts_with(remainder, "mut"):
        remainder = trim_text(substring(remainder, 3, len(remainder)))
    if len(remainder) == 0:
        return "i8*"
    inner_type = map_type_annotation(remainder)
    if len(inner_type) == 0 or inner_type == "void":
        return "i8*"
    if ends_with_pointer_suffix(inner_type):
        return inner_type
    return inner_type + "*"


def map_array_pointer_type(context, annotation):
    trimmed = trim_text(annotation)
    if len(trimmed) < 3:
        return ""
    suffix = substring(trimmed, len(trimmed) - 2, len(trimmed))
    if suffix != "[]":
        return ""
    element_annotation = trim_text(substring(trimmed, 0, len(trimmed) - 2))
    element_type = map_type_annotation(element_annotation)
    if len(element_type) == 0:
        return "i8*"
    if not annotation_is_array(element_annotation) and layout_annotation_represents_user_value(element_annotation) and ends_with_pointer_suffix(element_type):
        stripped = strip_pointer_suffix(element_type)
        if len(stripped) > 0:
            element_type = stripped
    return array_pointer_type_for_element(element_type)


def map_primitive_type(context, annotation):
    trimmed = trim_text(annotation)
    if trimmed == "number":
        return "double"
    if trimmed == "boolean" or trimmed == "bool":
        return "i1"
    if trimmed == "string":
        return "i8*"
    if trimmed == "void":
        return "void"
    if trimmed == "any":
        return "i8*"
    if trimmed == "int" or trimmed == "i64":
        return "i64"
    if trimmed == "i32":
        return "i32"
    if trimmed == "usize":
        return "i64"
    if trimmed == "u8" or trimmed == "i8":
        return "i8"
    return ""


def future_pointer_type_for_return_type(return_type):
    trimmed = trim_text(return_type)
    if len(trimmed) == 0 or trimmed == "void":
        return "%SailfinFutureVoid*"
    normalized = unwrap_move_wrapper(trimmed)
    if normalized == "number":
        return "%SailfinFutureNumber*"
    if normalized == "boolean" or normalized == "bool":
        return "%SailfinFutureBool*"
    if normalized == "string":
        return "%SailfinFutureString*"
    return "%SailfinFuturePtr*"


def spawn_symbol_for_return_type(return_type):
    trimmed = trim_text(return_type)
    if len(trimmed) == 0 or trimmed == "void":
        return "sailfin_runtime_spawn_void"
    normalized = unwrap_move_wrapper(trimmed)
    if normalized == "number":
        return "sailfin_runtime_spawn_number"
    if normalized == "boolean" or normalized == "bool":
        return "sailfin_runtime_spawn_bool"
    if normalized == "string":
        return "sailfin_runtime_spawn_string"
    return "sailfin_runtime_spawn_ptr"


def spawn_ctx_symbol_for_return_type(return_type):
    trimmed = trim_text(return_type)
    if len(trimmed) == 0 or trimmed == "void":
        return "sailfin_runtime_spawn_void_ctx"
    normalized = unwrap_move_wrapper(trimmed)
    if normalized == "number":
        return "sailfin_runtime_spawn_number_ctx"
    if normalized == "boolean" or normalized == "bool":
        return "sailfin_runtime_spawn_bool_ctx"
    if normalized == "string":
        return "sailfin_runtime_spawn_string_ctx"
    return "sailfin_runtime_spawn_ptr_ctx"


def default_value_for_llvm_type(llvm_type):
    trimmed = trim_text(llvm_type)
    if trimmed == "double":
        return "0.0"
    if trimmed == "i64" or trimmed == "i32" or trimmed == "i1" or trimmed == "i8":
        return "0"
    if ends_with_pointer_suffix(llvm_type):
        return "null"
    return "zeroinitializer"
