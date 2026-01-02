import asyncio
from runtime import runtime_support as runtime

from ...string_utils import substring
from ..types import TypeContext
from ..utils import trim_text, starts_with, index_of, append_string, join_with_separator
from ..type_mapping import map_type_annotation, ends_with_pointer_suffix, strip_pointer_suffix, annotation_is_array, layout_annotation_represents_user_value, array_struct_type_for_element
from ..type_context import find_struct_info_by_name, find_interface_info_by_name

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

def map_struct_type_annotation_ctx(context, annotation):
    info = find_struct_info_by_name(context, annotation)
    if info != None:
        return info.llvm_name
    return ""

def map_enum_type_annotation(context, annotation):
    trimmed = trim_text(annotation)
    if len(trimmed) == 0:
        return ""
    index = 0
    while True:
        if index >= len(context.enums):
            break
        enum_info = context.enums[index]
        if enum_info.name == trimmed:
            return enum_info.llvm_name
        index += 1
    return ""

def map_interface_type_annotation(context, annotation):
    trimmed = trim_text(annotation)
    if len(trimmed) == 0:
        return ""
    interface_info = find_interface_info_by_name(context, trimmed)
    if interface_info != None:
        return interface_info.llvm_name
    return ""

def map_primitive_type(context, annotation):
    if annotation == "number":
        return "double"
    if annotation == "boolean"  or  annotation == "bool":
        return "i1"
    if annotation == "usize":
        return "i64"
    if annotation == "int"  or  annotation == "i64":
        return "i64"
    if annotation == "i32":
        return "i32"
    if annotation == "u8":
        return "i8"
    struct_type = map_struct_type_annotation_ctx(context, annotation)
    if len(struct_type) > 0:
        return struct_type
    enum_type = map_enum_type_annotation(context, annotation)
    if len(enum_type) > 0:
        return enum_type
    interface_type = map_interface_type_annotation(context, annotation)
    if len(interface_type) > 0:
        return interface_type
    if annotation == "string":
        return "i8*"
    return ""

def map_optional_type(context, annotation):
    trimmed = trim_text(annotation)
    if len(trimmed) == 0:
        return ""
    if trimmed[len(trimmed) - 1] != "?":
        return ""
    inner_annotation = trim_text(substring(trimmed, 0, len(trimmed) - 1))
    if len(inner_annotation) == 0:
        return ""
    struct_type = map_struct_type_annotation_ctx(context, inner_annotation)
    if len(struct_type) > 0:
        return struct_type + "*"
    enum_type = map_enum_type_annotation(context, inner_annotation)
    if len(enum_type) > 0:
        return enum_type + "*"
    interface_type = map_interface_type_annotation(context, inner_annotation)
    if len(interface_type) > 0:
        return interface_type + "*"
    inner_type = map_type_annotation(inner_annotation)
    if len(inner_type) == 0  or  inner_type == "void":
        return "i8*"
    if inner_type[len(inner_type) - 1] == "*":
        return inner_type
    return inner_type + "*"

def map_reference_inner_type(context, annotation):
    trimmed = trim_text(annotation)
    if len(trimmed) == 0:
        return ""
    nested_reference = map_reference_type(context, trimmed)
    if len(nested_reference) > 0:
        return nested_reference
    array_type = map_array_pointer_type(context, trimmed)
    if len(array_type) > 0:
        return array_type
    return map_primitive_type(context, trimmed)

def map_reference_type(context, annotation):
    trimmed = trim_text(annotation)
    if len(trimmed) == 0:
        return ""
    if not starts_with(trimmed, "&"):
        return ""
    if starts_with(trimmed, "&&"):
        return ""
    remainder = trim_text(substring(trimmed, 1, len(trimmed)))
    if starts_with(remainder, "mut"):
        after_mut = substring(remainder, 3, len(remainder))
        remainder = trim_text(after_mut)
    if len(remainder) == 0:
        return ""
    if remainder[0] == "("  and  remainder[len(remainder) - 1] == ")":
        remainder = trim_text(substring(remainder, 1, len(remainder) - 1))
    inner_type = map_reference_inner_type(context, remainder)
    if len(inner_type) == 0:
        return ""
    return inner_type + "*"

def map_array_pointer_type(context, annotation):
    trimmed = trim_text(annotation)
    if len(trimmed) < 3:
        return ""
    suffix = substring(trimmed, len(trimmed) - 2, len(trimmed))
    if suffix != "[]":
        return ""
    element_annotation = trim_text(substring(trimmed, 0, len(trimmed) - 2))
    element_type = map_primitive_type(context, element_annotation)
    if len(element_type) == 0:
        element_type = map_type_annotation(element_annotation)
    if len(element_type) == 0:
        element_type = "i8*"
    if not annotation_is_array(element_annotation)  and  layout_annotation_represents_user_value(element_annotation)  and  ends_with_pointer_suffix(element_type):
        stripped_element = strip_pointer_suffix(element_type)
        if len(stripped_element) > 0:
            element_type = stripped_element
    return "{ " + element_type + "*, i64 }*"

def unwrap_move_wrapper(annotation):
    trimmed = trim_text(annotation)
    if len(trimmed) == 0:
        return trimmed
    if starts_with(trimmed, "Affine<")  or  starts_with(trimmed, "Linear<"):
        open_index = index_of(trimmed, "<")
        if open_index >= 0:
            if trimmed[len(trimmed) - 1] == ">":
                inner = substring(trimmed, open_index + 1, len(trimmed) - 1)
                return unwrap_move_wrapper(trim_text(inner))
    return trimmed

def find_top_level_union_separator(text):
    paren_depth = 0
    brace_depth = 0
    bracket_depth = 0
    angle_depth = 0
    in_single = False
    in_double = False
    escape = False
    index = 0
    while True:
        if index >= len(text):
            break
        ch = substring(text, index, index + 1)
        if in_double:
            if escape:
                escape = False
            else:
                if ch == "\\":
                    escape = True
                else:
                    if ch == "\"":
                        in_double = False
            index += 1
            continue
        if in_single:
            if escape:
                escape = False
            else:
                if ch == "\\":
                    escape = True
                else:
                    if ch == "'":
                        in_single = False
            index += 1
            continue
        if ch == "\"":
            in_double = True
            index += 1
            continue
        if ch == "'":
            in_single = True
            index += 1
            continue
        if ch == "(":
            paren_depth += 1
            index += 1
            continue
        if ch == ")":
            if paren_depth > 0:
                paren_depth -= 1
            index += 1
            continue
        if ch == "{":
            brace_depth += 1
            index += 1
            continue
        if ch == "}":
            if brace_depth > 0:
                brace_depth -= 1
            index += 1
            continue
        if ch == "[":
            bracket_depth += 1
            index += 1
            continue
        if ch == "]":
            if bracket_depth > 0:
                bracket_depth -= 1
            index += 1
            continue
        if ch == "<":
            angle_depth += 1
            index += 1
            continue
        if ch == ">":
            if angle_depth > 0:
                angle_depth -= 1
            index += 1
            continue
        if paren_depth == 0  and  brace_depth == 0  and  bracket_depth == 0  and  angle_depth == 0:
            if ch == "|":
                return index
        index += 1
    return -1

def split_union_annotations(text):
    result = []
    remaining = text
    while True:
        index = find_top_level_union_separator(remaining)
        if index < 0:
            tail = trim_text(remaining)
            if len(tail) > 0:
                result = append_string(result, tail)
            break
        left = trim_text(substring(remaining, 0, index))
        if len(left) > 0:
            result = append_string(result, left)
        remaining = trim_text(substring(remaining, index + 1, len(remaining)))
    return result

def is_union_annotation(annotation):
    trimmed = trim_text(annotation)
    if len(trimmed) == 0:
        return False
    return find_top_level_union_separator(trimmed) >= 0

def map_union_type(context, annotation):
    normalized = unwrap_move_wrapper(trim_text(annotation))
    if not is_union_annotation(normalized):
        return ""
    parts = split_union_annotations(normalized)
    if len(parts) < 2:
        return ""
    llvm_parts = []
    index = 0
    while True:
        if index >= len(parts):
            break
        part = trim_text(parts[index])
        if len(part) == 0:
            return ""
        mapped = map_type_annotation(part)
        if len(mapped) == 0  or  mapped == "void":
            return ""
        llvm_parts = append_string(llvm_parts, mapped)
        index += 1
    return "{ i32, " + join_with_separator(llvm_parts, ", ") + " }"

def map_return_type(context, return_type):
    trimmed = trim_text(return_type)
    if len(trimmed) == 0  or  trimmed == "void":
        return "void"
    normalized = unwrap_move_wrapper(trimmed)
    if starts_with(normalized, "*"):
        remainder = trim_text(substring(normalized, 1, len(normalized)))
        if starts_with(remainder, "mut"):
            remainder = trim_text(substring(remainder, 3, len(remainder)))
        if remainder == "opaque"  or  len(remainder) == 0:
            return "i8*"
        inner = map_return_type(context, remainder)
        if ends_with_pointer_suffix(inner):
            return inner
        if len(inner) == 0  or  inner == "void":
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

def future_pointer_type_for_return_type(return_type):
    trimmed = trim_text(return_type)
    if len(trimmed) == 0  or  trimmed == "void":
        return "%SailfinFutureVoid*"
    normalized = unwrap_move_wrapper(trimmed)
    if normalized == "number":
        return "%SailfinFutureNumber*"
    if normalized == "boolean"  or  normalized == "bool":
        return "%SailfinFutureBool*"
    if normalized == "string":
        return "%SailfinFutureString*"
    return "%SailfinFuturePtr*"

def await_symbol_for_future_pointer_type(future_ptr_type):
    if future_ptr_type == "%SailfinFutureNumber*":
        return "sailfin_runtime_await_number"
    if future_ptr_type == "%SailfinFutureBool*":
        return "sailfin_runtime_await_bool"
    if future_ptr_type == "%SailfinFutureVoid*":
        return "sailfin_runtime_await_void"
    if future_ptr_type == "%SailfinFutureString*":
        return "sailfin_runtime_await_string"
    if future_ptr_type == "%SailfinFuturePtr*":
        return "sailfin_runtime_await_ptr"
    return ""

def map_parameter_type(context, parameter_type):
    trimmed = trim_text(parameter_type)
    if len(trimmed) == 0:
        return "double"
    normalized = unwrap_move_wrapper(trimmed)
    if starts_with(normalized, "*"):
        remainder = trim_text(substring(normalized, 1, len(normalized)))
        if starts_with(remainder, "mut"):
            remainder = trim_text(substring(remainder, 3, len(remainder)))
        if remainder == "opaque"  or  len(remainder) == 0:
            return "i8*"
        inner = map_parameter_type(context, remainder)
        if ends_with_pointer_suffix(inner):
            return inner
        if len(inner) == 0:
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
