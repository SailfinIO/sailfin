import asyncio
from runtime import runtime_support as runtime

from ..string_utils import substring, char_code, char_at
from compiler.build.llvm.types import ParameterBinding

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

def trim_text(value):
    start = 0
    end = len(value)
    while True:
        if start >= end:
            break
        ch = char_at(value, start)
        if is_trim_char(ch):
            start += 1
            continue
        break
    while True:
        if end <= start:
            break
        ch = char_at(value, end - 1)
        if is_trim_char(ch):
            end -= 1
            continue
        break
    if start == 0  and  end == len(value):
        return value
    return substring(value, start, end)

def is_trim_char(ch):
    code = char_code(ch)
    return code == char_code(" ")  or  code == char_code("\n")  or  code == char_code("\r")  or  code == char_code("\t")

def starts_with(value, prefix):
    if len(prefix) == 0:
        return True
    if len(value) < len(prefix):
        return False
    head = substring(value, 0, len(prefix))
    return head == prefix

def ends_with(value, suffix):
    if len(suffix) == 0:
        return True
    if len(value) < len(suffix):
        return False
    start_index = len(value) - len(suffix)
    tail = substring(value, start_index, len(value))
    return tail == suffix

def contains_text(haystack, needle):
    if len(needle) == 0:
        return True
    if len(haystack) < len(needle):
        return False
    index = 0
    while True:
        if index + len(needle) > len(haystack):
            break
        candidate = substring(haystack, index, index + len(needle))
        if candidate == needle:
            return True
        index += 1
    return False

def index_of(value, target):
    if len(target) == 0:
        return 0
    index = 0
    while True:
        if index + len(target) > len(value):
            break
        match_index = 0
        matches = True
        while True:
            if match_index >= len(target):
                break
            if char_code_at_text(value, index + match_index) != char_code_at_text(target, match_index):
                matches = False
                break
            match_index += 1
        if matches:
            return index
        index += 1
    return -1

def find_last_index_of_char(value, target):
    if len(target) != 1:
        return -1
    target_code = char_code_at_text(target, 0)
    index = len(value)
    while True:
        if index <= 0:
            break
        index -= 1
        if char_code_at_text(value, index) == target_code:
            return index
    return -1

def char_code_at_text(text, index):
    return char_code(char_at(text, index))

def strip_mut_prefix(value):
    trimmed = trim_text(value)
    if len(trimmed) < 4:
        return trimmed
    prefix = substring(trimmed, 0, 4)
    if prefix == "mut ":
        return trim_text(substring(trimmed, 4, len(trimmed)))
    return trimmed

def number_to_string(value):
    if value == 0:
        return "0"
    digits = "0123456789"
    powers = [1000000000000000, 100000000000000, 10000000000000, 1000000000000, 100000000000, 10000000000, 1000000000, 100000000, 10000000, 1000000, 100000, 10000, 1000, 100, 10, 1]
    remaining = value
    is_negative = False
    if remaining < 0:
        is_negative = True
        remaining = 0 - remaining
    output = ""
    index = 0
    started = False
    while True:
        if index >= len(powers):
            break
        power = powers[index]
        count = 0
        while True:
            if remaining < power:
                break
            remaining -= power
            count += 1
        if started  or  count > 0:
            started = True
            ch = substring(digits, count, count + 1)
            output = output + ch
        index += 1
    if len(output) == 0:
        output = "0"
    if is_negative:
        return "-" + output
    return output

def lower_char_code(code):
    upper_a = char_code("A")
    upper_z = char_code("Z")
    if code >= upper_a  and  code <= upper_z:
        lower_a = char_code("a")
        return code + lower_a - upper_a
    return code

def matches_case_insensitive(value, expected):
    if len(value) != len(expected):
        return False
    index = 0
    while True:
        if index >= len(value):
            break
        value_ch = substring(value, index, index + 1)
        expected_ch = substring(expected, index, index + 1)
        value_code = lower_char_code(char_code(value_ch))
        expected_code = lower_char_code(char_code(expected_ch))
        if value_code != expected_code:
            return False
        index += 1
    return True

def is_boolean_literal(text):
    trimmed = trim_text(text)
    if matches_case_insensitive(trimmed, "true"):
        return True
    if matches_case_insensitive(trimmed, "false"):
        return True
    return False

def is_integer_literal(text):
    trimmed = trim_text(text)
    if len(trimmed) == 0:
        return False
    index = 0
    if char_code_at_text(trimmed, 0) == char_code("-"):
        if len(trimmed) == 1:
            return False
        index = 1
    has_digit = False
    while True:
        if index >= len(trimmed):
            break
        code = char_code_at_text(trimmed, index)
        if code >= char_code("0")  and  code <= char_code("9"):
            has_digit = True
            index += 1
            continue
        return False
    return has_digit

def is_number_literal(text):
    index = 0
    has_digit = False
    has_decimal = False
    trimmed = trim_text(text)
    if len(trimmed) == 0:
        return False
    if char_code_at_text(trimmed, 0) == char_code("-"):
        if len(trimmed) == 1:
            return False
        index = 1
    while True:
        if index >= len(trimmed):
            break
        code = char_code_at_text(trimmed, index)
        if code >= char_code("0")  and  code <= char_code("9"):
            has_digit = True
            index += 1
            continue
        if code == char_code("."):
            if has_decimal:
                return False
            has_decimal = True
            index += 1
            continue
        return False
    return has_digit

def is_digit_char(ch):
    code = char_code(ch)
    zero = char_code("0")
    nine = char_code("9")
    return code >= zero  and  code <= nine

def is_simple_identifier(value):
    trimmed = trim_text(value)
    if len(trimmed) == 0:
        return False
    first = trimmed[0]
    if first >= "0"  and  first <= "9":
        return False
    sanitized = sanitize_symbol(trimmed)
    if sanitized != trimmed:
        return False
    return True

def is_identifier_start_char(ch):
    if ch == "_":
        return True
    if index_of("abcdefghijklmnopqrstuvwxyz", ch) != -1:
        return True
    if index_of("ABCDEFGHIJKLMNOPQRSTUVWXYZ", ch) != -1:
        return True
    return False

def is_identifier_part_char(ch):
    if is_identifier_start_char(ch):
        return True
    if index_of("0123456789", ch) != -1:
        return True
    return False

def matches_keyword(value, start_index, keyword):
    remaining = len(value) - start_index
    if remaining < len(keyword):
        return False
    slice = substring(value, start_index, start_index + len(keyword))
    if slice != keyword:
        return False
    if start_index + len(keyword) >= len(value):
        return True
    next = value[start_index + len(keyword)]
    if is_identifier_part_char(next):
        return False
    return True

def is_effect_prefix_char(ch):
    if is_trim_char(ch):
        return True
    return ch == "("  or  ch == ","  or  ch == ";"  or  ch == "{"  or  ch == "}"  or  ch == "="

def is_effect_delimiter(ch):
    if is_trim_char(ch):
        return True
    return ch == "("  or  ch == ")"  or  ch == ","  or  ch == ";"  or  ch == "{"  or  ch == "}"  or  ch == "="

def is_symbol_char(ch):
    if len(ch) == 0:
        return False
    if ch == "_":
        return True
    code = char_code(ch)
    lower_a = char_code("a")
    lower_z = char_code("z")
    if code >= lower_a  and  code <= lower_z:
        return True
    upper_a = char_code("A")
    upper_z = char_code("Z")
    if code >= upper_a  and  code <= upper_z:
        return True
    zero = char_code("0")
    nine = char_code("9")
    if code >= zero  and  code <= nine:
        return True
    return False

def sanitize_symbol(name):
    if len(name) == 0:
        return "_"
    result = ""
    index = 0
    while True:
        if index >= len(name):
            break
        ch = name[index]
        if is_symbol_char(ch):
            result = result + ch
        index += 1
    if len(result) == 0:
        return "_"
    first = result[0]
    first_code = char_code(first)
    zero = char_code("0")
    nine = char_code("9")
    if first_code >= zero  and  first_code <= nine:
        result = "_" + result
    return result

def append_string(values, value):
    values.append(value)
    return values

def copy_string_array(values):
    result = []
    index = 0
    while True:
        if index >= len(values):
            break
        result = append_string(result, values[index])
        index += 1
    return result

def string_arrays_equal(first, second):
    if len(first) != len(second):
        return False
    index = 0
    while True:
        if index >= len(first):
            break
        if first[index] != second[index]:
            return False
        index += 1
    return True

def string_array_contains(values, target):
    index = 0
    while True:
        if index >= len(values):
            break
        if values[index] == target:
            return True
        index += 1
    return False

def join_with_separator(values, separator):
    if len(values) == 0:
        return ""
    if len(values) == 1:
        return values[0]
    parts = values
    while True:
        if len(parts) <= 1:
            break
        next = []
        index = 0
        while True:
            if index >= len(parts):
                break
            if index + 1 < len(parts):
                combined = parts[index] + separator + parts[index + 1]
                next = append_string(next, combined)
                index += 2
                continue
            next = append_string(next, parts[index])
            index += 1
        parts = next
    return parts[0]

def find_parameter_binding(bindings, name):
    index = 0
    while True:
        if index >= len(bindings):
            break
        if bindings[index].name == name:
            return bindings[index]
        index += 1
    return None

def append_parameter_binding(bindings, binding):
    return (bindings) + ([binding])

def merge_parameter_bindings(first, second):
    result = []
    index = 0
    while True:
        if index >= len(first):
            break
        primary = first[index]
        consumed_flag = primary.consumed
        counterpart = find_parameter_binding(second, primary.name)
        if counterpart != None:
            consumed_flag = consumed_flag  or  counterpart.consumed
        result = append_parameter_binding(result, ParameterBinding(name=primary.name, llvm_name=primary.llvm_name, llvm_type=primary.llvm_type, type_annotation=primary.type_annotation, consumed=consumed_flag, span=primary.span))
        index += 1
    return result

def skip_string_literal(text, start_index):
    index = start_index
    escaped = False
    while True:
        if index >= len(text):
            break
        current = text[index]
        if escaped:
            escaped = False
        else:
            if current == "\\":
                escaped = True
            else:
                if current == "\"":
                    index += 1
                    break
        if current == "\n":
            index += 1
            break
        index += 1
    return index
