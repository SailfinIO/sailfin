import asyncio
from runtime import runtime_support as runtime

from ...string_utils import substring, char_code, char_at
from ..types import InterpolatedTemplateParse
from ..utils import starts_with, is_identifier_start_char, is_identifier_part_char
from ..expression_lowering.splitting import split_array_elements

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
            ch = digits[count]
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

def append_string(values, value):
    values.append(value)
    return values

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
                next.append(combined)
                index += 2
                continue
            next.append(parts[index])
            index += 1
        parts = next
    return parts[0]

def find_substring_from(value, target, start):
    if len(target) == 0:
        return start
    index = start
    if index < 0:
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

def is_union_llvm_type(llvm_type):
    trimmed = trim_text(llvm_type)
    if not starts_with(trimmed, "{"):
        return False
    if find_substring_from(trimmed, "i32", 0) < 0:
        return False
    return starts_with(trim_text(trimmed), "{ i32,")

def parse_union_payload_types(union_llvm_type):
    trimmed = trim_text(union_llvm_type)
    if not is_union_llvm_type(trimmed):
        return []
    inner = trim_text(substring(trimmed, 1, len(trimmed) - 1))
    fields = split_array_elements(inner)
    if len(fields) < 2:
        return []
    result = []
    index = 1
    while True:
        if index >= len(fields):
            break
        result = append_string(result, trim_text(fields[index]))
        index += 1
    return result

def extract_simple_identifier(text):
    trimmed = trim_text(text)
    if len(trimmed) == 0:
        return ""
    first = trimmed[0]
    if not is_identifier_start_char(first):
        return ""
    index = 0
    while True:
        if index >= len(trimmed):
            break
        ch = trimmed[index]
        if not is_identifier_part_char(ch):
            return ""
        index += 1
    return trimmed

def is_boolean_literal(text):
    trimmed = trim_text(text)
    if matches_case_insensitive(trimmed, "true"):
        return True
    if matches_case_insensitive(trimmed, "false"):
        return True
    return False

def is_null_literal(text):
    trimmed = trim_text(text)
    if matches_case_insensitive(trimmed, "null"):
        return True
    return False

def is_digit_char(ch):
    code = char_code(ch)
    zero = char_code("0")
    nine = char_code("9")
    return code >= zero  and  code <= nine

def char_code_at_text(text, index):
    return char_code(char_at(text, index))

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

def normalise_number_literal(text):
    trimmed = trim_text(text)
    if index_of(trimmed, ".") >= 0:
        return trimmed
    return trimmed + ".0"

def is_string_literal(text):
    trimmed = trim_text(text)
    if len(trimmed) < 2:
        return False
    if char_code_at_text(trimmed, 0) != char_code("\""):
        return False
    if char_code_at_text(trimmed, len(trimmed) - 1) != char_code("\""):
        return False
    escape = False
    index = 1
    while True:
        if index >= len(trimmed) - 1:
            break
        ch = char_at(trimmed, index)
        if escape:
            escape = False
            index += 1
            continue
        if ch == "\\":
            escape = True
            index += 1
            continue
        if ch == "\"":
            return False
        index += 1
    if escape:
        return False
    return True

def is_character_literal(text):
    if len(text) < 2:
        return False
    if char_code_at_text(text, 0) != char_code("\"")  or  char_code_at_text(text, len(text) - 1) != char_code("\""):
        return False
    inner = substring(text, 1, len(text) - 1)
    if len(inner) == 2  and  char_code_at_text(inner, 0) == char_code("\\"):
        return True
    return len(inner) == 1

def get_character_literal_value(text):
    inner = substring(text, 1, len(text) - 1)
    if len(inner) == 0:
        return 0
    if len(inner) == 2  and  char_code_at_text(inner, 0) == char_code("\\"):
        escape = char_at(inner, 1)
        escape_code = char_code(escape)
        if escape_code == char_code("n"):
            return char_code("\n")
        else:
            if escape_code == char_code("r"):
                return char_code("\r")
            else:
                if escape_code == char_code("t"):
                    return char_code("\t")
                else:
                    if escape_code == char_code("\""):
                        return char_code("\"")
                    else:
                        if escape_code == char_code("\\"):
                            return char_code("\\")
        return char_code(escape)
    return char_code(char_at(inner, 0))

def make_string_constant_name(content):
    hash_value = compute_string_constant_hash(content)
    length_part = number_to_string(len(content))
    hash_part = number_to_string(hash_value)
    return "@.str.len" + length_part + ".h" + hash_part

def make_string_constant_name_for_module(module_name, content):
    base = make_string_constant_name(content)
    tag = sanitize_symbol(module_name)
    if len(tag) == 0  or  tag == "_":
        return base
    return "@.str." + tag + substring(base, 5, len(base))

def compute_string_constant_hash(content):
    hash = 5381
    modulus = 2147483647
    index = 0
    while True:
        if index >= len(content):
            break
        code = char_code_at_text(content, index)
        hash = hash * 33 + code
        while True:
            if hash < modulus:
                break
            hash -= modulus
        index += 1
    hash = hash * 33 + len(content)
    while True:
        if hash < modulus:
            break
        hash -= modulus
    return hash

def parse_interpolated_template(content):
    parts = []
    expressions = []
    index = 0
    while True:
        if index > len(content):
            break
        start = find_substring_from(content, "{{", index)
        if start < 0:
            parts = append_string(parts, substring(content, index, len(content)))
            break
        parts = append_string(parts, substring(content, index, start))
        end = find_substring_from(content, "}}", start + 2)
        if end < 0:
            return InterpolatedTemplateParse(parts=[], expressions=[], success=False)
        expr_text = trim_text(substring(content, start + 2, end))
        if len(expr_text) == 0:
            return InterpolatedTemplateParse(parts=[], expressions=[], success=False)
        expressions = append_string(expressions, expr_text)
        index = end + 2
    return InterpolatedTemplateParse(parts=parts, expressions=expressions, success=True)

def encode_string_literal_for_sailfin(content):
    escaped = escape_string_for_sailfin_literal(content)
    return "\"" + escaped + "\""

def escape_string_for_sailfin_literal(content):
    result = ""
    index = 0
    while True:
        if index >= len(content):
            break
        ch = content[index]
        if ch == "\\":
            result = result + "\\\\"
        else:
            if ch == "\"":
                result = result + "\\\""
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
        index += 1
    return result

def unescape_string_literal(literal):
    if len(literal) < 2:
        return ""
    start_index = 1
    end_index = len(literal) - 1
    inner = substring(literal, start_index, end_index)
    result = ""
    index = 0
    while True:
        if index >= len(inner):
            break
        ch = char_at(inner, index)
        if char_code(ch) == char_code("\\")  and  index + 1 < len(inner):
            next = char_at(inner, index + 1)
            next_code = char_code(next)
            if next_code == char_code("n"):
                result = result + "\n"
                index += 2
                continue
            else:
                if next_code == char_code("r"):
                    result = result + "\r"
                    index += 2
                    continue
                else:
                    if next_code == char_code("t"):
                        result = result + "\t"
                        index += 2
                        continue
                    else:
                        if next_code == char_code("\""):
                            result = result + "\""
                            index += 2
                            continue
                        else:
                            if next_code == char_code("\\"):
                                result = result + "\\"
                                index += 2
                                continue
            result = result + next
            index += 2
            continue
        result = result + ch
        index += 1
    return result

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
