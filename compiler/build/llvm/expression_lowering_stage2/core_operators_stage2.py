import asyncio
from runtime import runtime_support as runtime

from ...string_utils import substring, char_at, char_code
from ..types import OperatorMatch
from ..utils import trim_text, starts_with, contains_text
from compiler.build.llvm.expression_lowering_stage2.core_text import char_code_at_text, is_trim_char

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

def lines_end_with_terminator(lines):
    index = len(lines) - 1
    while True:
        if len(lines) == 0:
            return False
        if index < 0:
            break
        line = trim_text(lines[index])
        if len(line) == 0:
            index -= 1
            continue
        if starts_with(line, "ret"):
            return True
        if starts_with(line, "br "):
            return True
        if starts_with(line, "switch "):
            return True
        if line == "unreachable":
            return True
        return False
    return False

def strip_enclosing_parentheses(expression):
    trimmed = trim_text(expression)
    if len(trimmed) < 2:
        return trimmed
    if trimmed[0] != "("  or  trimmed[len(trimmed) - 1] != ")":
        return trimmed
    depth = 0
    index = 0
    while True:
        if index >= len(trimmed):
            break
        ch = char_at(trimmed, index)
        if ch == "(":
            depth += 1
        else:
            if ch == ")":
                depth -= 1
                if depth == 0:
                    if index == len(trimmed) - 1:
                        inner = substring(trimmed, 1, len(trimmed) - 1)
                        return strip_enclosing_parentheses(inner)
                    return trimmed
        index += 1
    return trimmed

def find_top_level_operator(expression, operators):
    paren_depth = 0
    bracket_depth = 0
    brace_depth = 0
    angle_depth = 0
    in_single = False
    in_double = False
    escape_next = False
    candidate_index = -1
    candidate_symbol = ""
    index = 0
    while True:
        if index >= len(expression):
            break
        ch = char_at(expression, index)
        if in_double:
            if escape_next:
                escape_next = False
                index += 1
                continue
            if ch == "\\":
                escape_next = True
                index += 1
                continue
            if ch == "\"":
                in_double = False
            index += 1
            continue
        if in_single:
            if escape_next:
                escape_next = False
                index += 1
                continue
            if ch == "\\":
                escape_next = True
                index += 1
                continue
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
        if ch == "[":
            bracket_depth += 1
            index += 1
            continue
        if ch == "]":
            if bracket_depth > 0:
                bracket_depth -= 1
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
        if ch == "<":
            angle_depth += 1
            index += 1
            continue
        if ch == ">":
            if angle_depth > 0:
                angle_depth -= 1
            index += 1
            continue
        if paren_depth == 0  and  bracket_depth == 0  and  brace_depth == 0  and  angle_depth == 0  and  contains_char(operators, ch):
            if ch == "-":
                if is_binary_minus(expression, index):
                    candidate_index = index
                    candidate_symbol = substring(expression, index, index + 1)
            else:
                if ch == "*":
                    if is_binary_star(expression, index):
                        candidate_index = index
                        candidate_symbol = substring(expression, index, index + 1)
                else:
                    candidate_index = index
                    candidate_symbol = substring(expression, index, index + 1)
        index += 1
    if candidate_index >= 0:
        return OperatorMatch(index=candidate_index, symbol=candidate_symbol, success=True)
    return OperatorMatch(index=-1, symbol="", success=False)

def find_comparison_operator(expression):
    depth = 0
    index = 0
    in_string = False
    escape_next = False
    while True:
        if index >= len(expression):
            break
        code = char_code_at_text(expression, index)
        if in_string:
            if escape_next:
                escape_next = False
                index += 1
                continue
            if code == char_code("\\"):
                escape_next = True
                index += 1
                continue
            if code == char_code("\""):
                in_string = False
            index += 1
            continue
        if code == char_code("\""):
            in_string = True
            index += 1
            continue
        if code == char_code("("):
            depth += 1
            index += 1
            continue
        if code == char_code(")"):
            if depth > 0:
                depth -= 1
            index += 1
            continue
        if depth > 0:
            index += 1
            continue
        if index + 1 < len(expression):
            next_code = char_code_at_text(expression, index + 1)
            if next_code == char_code("="):
                if code == char_code("="):
                    return OperatorMatch(index=index, symbol="==", success=True)
                if code == char_code("!"):
                    return OperatorMatch(index=index, symbol="!=", success=True)
                if code == char_code("<"):
                    return OperatorMatch(index=index, symbol="<=", success=True)
                if code == char_code(">"):
                    return OperatorMatch(index=index, symbol=">=", success=True)
        if code == char_code("<"):
            return OperatorMatch(index=index, symbol="<", success=True)
        if code == char_code(">"):
            return OperatorMatch(index=index, symbol=">", success=True)
        index += 1
    return OperatorMatch(index=-1, symbol="", success=False)

def find_logical_operator(expression):
    depth = 0
    index = 0
    in_string = False
    escape_next = False
    while True:
        if index + 1 >= len(expression):
            break
        ch = expression[index]
        if in_string:
            if escape_next:
                escape_next = False
                index += 1
                continue
            if ch == "\\":
                escape_next = True
                index += 1
                continue
            if ch == "\"":
                in_string = False
            index += 1
            continue
        if ch == "\"":
            in_string = True
            index += 1
            continue
        if ch == "(":
            depth += 1
            index += 1
            continue
        if ch == ")":
            if depth > 0:
                depth -= 1
            index += 1
            continue
        if depth == 0:
            two = substring(expression, index, index + 2)
            if two == "||":
                return OperatorMatch(index=index, symbol="||", success=True)
        index += 1
    depth = 0
    index = 0
    in_string = False
    escape_next = False
    while True:
        if index + 1 >= len(expression):
            break
        ch = expression[index]
        if in_string:
            if escape_next:
                escape_next = False
                index += 1
                continue
            if ch == "\\":
                escape_next = True
                index += 1
                continue
            if ch == "\"":
                in_string = False
            index += 1
            continue
        if ch == "\"":
            in_string = True
            index += 1
            continue
        if ch == "(":
            depth += 1
            index += 1
            continue
        if ch == ")":
            if depth > 0:
                depth -= 1
            index += 1
            continue
        if depth == 0:
            two = substring(expression, index, index + 2)
            if two == "&&":
                return OperatorMatch(index=index, symbol="&&", success=True)
        index += 1
    return OperatorMatch(index=-1, symbol="", success=False)

def contains_char(set, ch):
    if len(ch) == 0:
        return False
    target = char_code(ch)
    index = 0
    while True:
        if index >= len(set):
            break
        if char_code(char_at(set, index)) == target:
            return True
        index += 1
    return False

def is_binary_minus(expression, index):
    previous = find_previous_non_space_char(expression, index)
    next = find_next_non_space_char(expression, index)
    if previous == None:
        return False
    prev_char = previous
    if prev_char == "+"  or  prev_char == "-"  or  prev_char == "*"  or  prev_char == "/"  or  prev_char == "("  or  prev_char == ",":
        return False
    if next == None:
        return False
    next_char = next
    if next_char == "+"  or  next_char == "-"  or  next_char == "*"  or  next_char == "/"  or  next_char == ")"  or  next_char == ",":
        return False
    return True

def is_binary_star(expression, index):
    previous = find_previous_non_space_char(expression, index)
    next = find_next_non_space_char(expression, index)
    if previous == None:
        return False
    prev_char = previous
    if prev_char == "+"  or  prev_char == "-"  or  prev_char == "*"  or  prev_char == "/"  or  prev_char == "("  or  prev_char == ",":
        return False
    if next == None:
        return False
    next_char = next
    if next_char == "+"  or  next_char == "-"  or  next_char == "*"  or  next_char == "/"  or  next_char == ")"  or  next_char == ",":
        return False
    return True

def find_previous_non_space_char(value, index):
    position = index
    while True:
        if position <= 0:
            break
        position -= 1
        ch = char_at(value, position)
        if not is_trim_char(ch):
            return ch
    return None

def find_next_non_space_char(value, index):
    position = index + 1
    while True:
        if position >= len(value):
            break
        ch = char_at(value, position)
        if not is_trim_char(ch):
            return ch
        position += 1
    return None
