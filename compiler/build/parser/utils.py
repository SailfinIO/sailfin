import asyncio
from runtime import runtime_support as runtime

from ..string_utils import substring, char_code, char_at, strings_equal

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
        if is_trim_whitespace(ch):
            start += 1
            continue
        break
    while True:
        if end <= start:
            break
        ch = char_at(value, end - 1)
        if is_trim_whitespace(ch):
            end -= 1
            continue
        break
    return substring(value, start, end)

def is_trim_whitespace(ch):
    code = char_code(ch)
    return code == 32  or  code == 10  or  code == 9  or  code == 13

def strip_surrounding_quotes(text):
    if len(text) < 2:
        return text
    first = char_code(char_at(text, 0))
    last = char_code(char_at(text, len(text) - 1))
    if first == 34  and  last == 34:
        return substring(text, 1, len(text) - 1)
    return text

def strip_loose_quotes(text):
    if len(text) == 0:
        return text
    start = 0
    end = len(text)
    while True:
        if start >= end:
            break
        first = char_code(char_at(text, start))
        if first == 34:
            start += 1
            continue
        break
    while True:
        if end <= start:
            break
        last = char_code(char_at(text, end - 1))
        if last == 34:
            end -= 1
            continue
        break
    if start == 0  and  end == len(text):
        return text
    return substring(text, start, end)

def decode_string_literal_escapes(text):
    if len(text) == 0:
        return ""
    decoded = ""
    index = 0
    while True:
        if index >= len(text):
            break
        ch = char_at(text, index)
        if ch == "\\":
            next_index = index + 1
            if next_index >= len(text):
                decoded = decoded + ch
                index += 1
                continue
            escaped = char_at(text, next_index)
            if escaped == "n":
                decoded = decoded + "\n"
            else:
                if escaped == "t":
                    decoded = decoded + "\t"
                else:
                    if escaped == "r":
                        decoded = decoded + "\r"
                    else:
                        if escaped == "\"":
                            decoded = decoded + "\""
                        else:
                            if escaped == "\\":
                                decoded = decoded + "\\"
                            else:
                                decoded = decoded + escaped
            index += 2
            continue
        decoded = decoded + ch
        index += 1
    return decoded

def normalize_test_name(text):
    trimmed = trim_text(text)
    if len(trimmed) >= 2:
        first = char_code(char_at(trimmed, 0))
        last = char_code(char_at(trimmed, len(trimmed) - 1))
        if first == 34  and  last == 34:
            return strip_surrounding_quotes(trimmed)
    return trimmed

def looks_like_number(text):
    if len(text) == 0:
        return False
    has_decimal = False
    index = 0
    if char_at(text, 0) == "-":
        if len(text) == 1:
            return False
        index = 1
    while True:
        if index >= len(text):
            break
        ch = char_at(text, index)
        if ch == ".":
            if has_decimal:
                return False
            has_decimal = True
            index += 1
            continue
        if not is_decimal_digit(ch):
            return False
        index += 1
    return True

def is_decimal_digit(ch):
    return ch == "0"  or  ch == "1"  or  ch == "2"  or  ch == "3"  or  ch == "4"  or  ch == "5"  or  ch == "6"  or  ch == "7"  or  ch == "8"  or  ch == "9"

def string_array_contains(values, target):
    index = 0
    while True:
        if index >= len(values):
            break
        if strings_equal(values[index], target):
            return True
        index += 1
    return False

def append_string(values, value):
    return (values) + ([value])
