import asyncio
from runtime import runtime_support as runtime

from ...string_utils import char_at
from ..utils import trim_text, append_string

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

def split_array_elements(text):
    trimmed = trim_text(text)
    if len(trimmed) == 0:
        return []
    entries = []
    current = ""
    paren_depth = 0
    bracket_depth = 0
    brace_depth = 0
    index = 0
    in_single = False
    in_double = False
    escape = False
    while True:
        if index >= len(text):
            break
        ch = char_at(text, index)
        if in_double:
            current = current + ch
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
            current = current + ch
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
            current = current + ch
            index += 1
            continue
        if ch == "'":
            in_single = True
            current = current + ch
            index += 1
            continue
        if ch == "(":
            paren_depth += 1
        else:
            if ch == ")":
                if paren_depth > 0:
                    paren_depth -= 1
            else:
                if ch == "[":
                    bracket_depth += 1
                else:
                    if ch == "]":
                        if bracket_depth > 0:
                            bracket_depth -= 1
                    else:
                        if ch == "{":
                            brace_depth += 1
                        else:
                            if ch == "}":
                                if brace_depth > 0:
                                    brace_depth -= 1
        if ch == ","  and  paren_depth == 0  and  bracket_depth == 0  and  brace_depth == 0:
            entries = append_string(entries, trim_text(current))
            current = ""
        else:
            current = current + ch
        index += 1
    if len(current) > 0:
        entries = append_string(entries, trim_text(current))
    filtered = []
    index = 0
    while True:
        if index >= len(entries):
            break
        entry = trim_text(entries[index])
        if len(entry) > 0:
            filtered = append_string(filtered, entry)
        index += 1
    return filtered
