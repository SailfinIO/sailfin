import asyncio
from runtime import runtime_support as runtime

from compiler.build.runtime.prelude import clamp, substring, find_char, grapheme_count, grapheme_at, char_code, strings_equal

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

def char_at(value, index):
    value_len = len(value)
    if value_len == 0:
        return ""
    if index < 0:
        return ""
    if index >= value_len:
        return ""
    return grapheme_at(value, index)

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
    name_len = len(name)
    if name_len == 0:
        return "_"
    result = ""
    index = 0
    while True:
        if index >= name_len:
            break
        ch = grapheme_at(name, index)
        if is_symbol_char(ch):
            result = result + ch
        index += 1
    if len(result) == 0:
        return "_"
    first = char_at(result, 0)
    first_code = char_code(first)
    zero = char_code("0")
    nine = char_code("9")
    if first_code >= zero  and  first_code <= nine:
        result = "_" + result
    return result

def char_code_at_text(text, index):
    return char_code(char_at(text, index))

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

__all__ = ["clamp", "substring", "find_char", "grapheme_count", "grapheme_at", "char_code", "char_at", "sanitize_symbol", "strings_equal", "index_of", "find_last_index_of_char"]
