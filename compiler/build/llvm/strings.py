import asyncio
from runtime import runtime_support as runtime

from compiler.build.llvm.types import StringConstant
from compiler.build.llvm.utils import number_to_string, append_string

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

def empty_string_constant_set():
    return []

def string_constant_singleton(constant):
    return [constant]

def clone_string_constants(constants):
    copy = []
    index = 0
    while True:
        if index >= len(constants):
            break
        copy.append(constants[index])
        index += 1
    return copy

def append_string_constant(set, constant):
    return (set) + ([constant])

def merge_string_constants(existing, new_constants):
    result = clone_string_constants(existing)
    index = 0
    while True:
        if index >= len(new_constants):
            break
        candidate = new_constants[index]
        found_by_name = find_string_constant_by_name(result, candidate.name)
        if found_by_name == None:
            result.append(candidate)
        index += 1
    return result

def find_string_constant(constants, content):
    index = 0
    while True:
        if index >= len(constants):
            break
        candidate = constants[index]
        if candidate.content == content:
            return candidate
        index += 1
    return None

def find_string_constant_by_name(constants, name):
    index = 0
    while True:
        if index >= len(constants):
            break
        candidate = constants[index]
        if candidate.name == name:
            return candidate
        index += 1
    return None

def render_string_constants(constants):
    lines = []
    index = 0
    while True:
        if index >= len(constants):
            break
        constant = constants[index]
        escaped = escape_string_for_llvm(constant.content)
        length_str = number_to_string(constant.byte_count + 1)
        declaration = constant.name + " = private unnamed_addr constant [" + length_str + " x i8] c\"" + escaped + "\\00\""
        lines = append_string(lines, declaration)
        index += 1
    return lines

def escape_string_for_llvm(content):
    result = ""
    index = 0
    while True:
        if index >= len(content):
            break
        ch = content[index]
        if ch == "\n":
            result = result + "\\0A"
        else:
            if ch == "\r":
                result = result + "\\0D"
            else:
                if ch == "\t":
                    result = result + "\\09"
                else:
                    if ch == "\"":
                        result = result + "\\22"
                    else:
                        if ch == "\\":
                            result = result + "\\5C"
                        else:
                            result = result + ch
        index += 1
    return result
