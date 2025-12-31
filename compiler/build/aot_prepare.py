import asyncio
from runtime import runtime_support as runtime

from compiler.build.string_utils import substring

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

def _aot_number_to_string(value):
    if value == 0:
        return "0"
    working = value
    negative = False
    if working < 0:
        negative = True
        working = 0 - working
    digits = "0123456789"
    remaining = working
    output = ""
    while True:
        if remaining <= 0:
            break
        temp = remaining
        quotient = 0
        while True:
            if temp < 10:
                break
            temp -= 10
            quotient += 1
        ch = substring(digits, temp, temp + 1)
        output = ch + output
        remaining = quotient
    if negative:
        output = "-" + output
    return output

def _aot_matches_at(value, start, pattern):
    if start < 0:
        return False
    pattern_len = len(pattern)
    value_len = len(value)
    if start + pattern_len > value_len:
        return False
    j = 0
    while True:
        if j >= pattern_len:
            break
        if value[start + j] != pattern[j]:
            return False
        j += 1
    return True

def _aot_ensure_intrinsic_decls(ir):
    round_marker = "@round(double"
    round_decl = "declare double @round(double)"
    if _aot_find_substring_outside_quotes(ir, round_marker) < 0:
        return ir
    if _aot_find_substring_outside_quotes(ir, round_decl) >= 0:
        return ir
    decl_line = round_decl + "\n"
    source_at = _aot_find_substring_from(ir, "source_filename", 0)
    if source_at < 0:
        return decl_line + ir
    line_end = source_at
    ir_len = len(ir)
    while True:
        if line_end >= ir_len:
            break
        if ir[line_end] == "\n":
            break
        line_end += 1
    if line_end < ir_len:
        line_end += 1
    return substring(ir, 0, line_end) + decl_line + substring(ir, line_end, ir_len)

def _aot_find_substring_outside_quotes(text, needle):
    needle_len = len(needle)
    if needle_len == 0:
        return 0
    i = 0
    text_len = len(text)
    in_quote = False
    while True:
        if i >= text_len:
            break
        ch = text[i]
        if ch == "\"":
            backslashes = _aot_count_trailing_backslashes(text, i)
            if backslashes % 2 == 0:
                in_quote = not in_quote
            i += 1
            continue
        if not in_quote:
            if _aot_matches_at(text, i, needle):
                return i
        i += 1
    return -1

def _aot_is_symbol_char(ch):
    if len(ch) == 0:
        return False
    if ch == "_"  or  ch == "."  or  ch == "$":
        return True
    if _aot_index_of("0123456789", ch) != -1:
        return True
    if _aot_index_of("abcdefghijklmnopqrstuvwxyz", ch) != -1:
        return True
    if _aot_index_of("ABCDEFGHIJKLMNOPQRSTUVWXYZ", ch) != -1:
        return True
    return False

def _aot_sanitize_module_suffix(module_name):
    out = ""
    index = 0
    while True:
        if index >= len(module_name):
            break
        ch = module_name[index]
        if _aot_is_symbol_char(ch):
            out = out + ch
        else:
            if ch == "/":
                out = out + "__"
            else:
                out = out + "_"
        index += 1
    if len(out) == 0:
        return "module"
    return out

def _aot_contains_string(values, target):
    index = 0
    while True:
        if index >= len(values):
            break
        if values[index] == target:
            return True
        index += 1
    return False

def _aot_append_unique(values, value):
    if _aot_contains_string(values, value):
        return values
    return (values) + ([value])

def _aot_starts_with_at(text, start, prefix):
    prefix_len = len(prefix)
    if prefix_len == 0:
        return True
    if start < 0:
        return False
    text_len = len(text)
    if start + prefix_len > text_len:
        return False
    j = 0
    while True:
        if j >= prefix_len:
            break
        if text[start + j] != prefix[j]:
            return False
        j += 1
    return True

def _aot_count_trailing_backslashes(text, before_index):
    count = 0
    index = before_index - 1
    while True:
        if index < 0:
            break
        if text[index] != "\\":
            break
        count += 1
        index -= 1
    return count

def _aot_rename_symbol_refs(ir, old, fresh):
    old_len = len(old)
    if old_len == 0:
        return ir
    ir_len = len(ir)
    out = ""
    i = 0
    last_emit = 0
    in_quote = False
    while True:
        if i >= ir_len:
            break
        ch = ir[i]
        if ch == "\"":
            backslashes = _aot_count_trailing_backslashes(ir, i)
            if backslashes % 2 == 0:
                in_quote = not in_quote
            i += 1
            continue
        if not in_quote  and  ch == "@":
            if _aot_starts_with_at(ir, i + 1, old):
                end = i + 1 + old_len
                if end >= ir_len  or  not _aot_is_symbol_char(ir[end]):
                    out = out + substring(ir, last_emit, i) + "@" + fresh
                    i = end
                    last_emit = i
                    continue
        i += 1
    out = out + substring(ir, last_emit, ir_len)
    return out

def _aot_trim_text(value):
    start = 0
    end = len(value)
    while True:
        if start >= end:
            break
        ch = value[start]
        if ch == " "  or  ch == "\n"  or  ch == "\r"  or  ch == "\t":
            start += 1
            continue
        break
    while True:
        if end <= start:
            break
        ch = value[end - 1]
        if ch == " "  or  ch == "\n"  or  ch == "\r"  or  ch == "\t":
            end -= 1
            continue
        break
    if start == 0  and  end == len(value):
        return value
    return substring(value, start, end)

def _aot_parse_defined_function_name(line):
    trimmed = _aot_trim_text(line)
    if len(trimmed) < 6:
        return ""
    if substring(trimmed, 0, 6) != "define":
        return ""
    index = 0
    while True:
        if index >= len(trimmed):
            return ""
        if trimmed[index] == "@":
            break
        index += 1
    index += 1
    start = index
    while True:
        if index >= len(trimmed):
            break
        if not _aot_is_symbol_char(trimmed[index]):
            break
        index += 1
    if index <= start:
        return ""
    return substring(trimmed, start, index)

def _aot_index_of(haystack, needle):
    if len(needle) == 0:
        return 0
    i = 0
    while True:
        if i + len(needle) > len(haystack):
            break
        matches = True
        j = 0
        while True:
            if j >= len(needle):
                break
            if haystack[i + j] != needle[j]:
                matches = False
                break
            j += 1
        if matches:
            return i
        i += 1
    return -1

def _aot_parse_defined_global_name(line):
    trimmed = _aot_trim_text(line)
    if len(trimmed) == 0  or  trimmed[0] != "@":
        return ""
    idx = 1
    start = idx
    while True:
        if idx >= len(trimmed):
            return ""
        if not _aot_is_symbol_char(trimmed[idx]):
            break
        idx += 1
    if idx <= start:
        return ""
    if _aot_index_of(trimmed, "=") < 0:
        return ""
    if _aot_index_of(trimmed, " global") < 0  and  _aot_index_of(trimmed, " constant") < 0:
        return ""
    return substring(trimmed, start, idx)

def _aot_split_lines(text):
    lines = []
    start = 0
    index = 0
    text_len = len(text)
    while True:
        if index >= text_len:
            break
        if text[index] == "\n":
            lines = (lines) + ([substring(text, start, index)])
            start = index + 1
        index += 1
    lines = (lines) + ([substring(text, start, text_len)])
    return lines

def _aot_find_defined_functions(ir):
    lines = _aot_split_lines(ir)
    functions = []
    i = 0
    while True:
        if i >= len(lines):
            break
        fun = _aot_parse_defined_function_name(lines[i])
        if len(fun) > 0:
            functions = _aot_append_unique(functions, fun)
        i += 1
    return functions

def _aot_find_defined_globals(ir):
    lines = _aot_split_lines(ir)
    globals = []
    i = 0
    while True:
        if i >= len(lines):
            break
        glob = _aot_parse_defined_global_name(lines[i])
        if len(glob) > 0:
            globals = _aot_append_unique(globals, glob)
        i += 1
    return globals

def _aot_replace(text, needle, replacement):
    if len(needle) == 0:
        return text
    out = ""
    index = 0
    while True:
        if index >= len(text):
            break
        found = _aot_find_substring_from(text, needle, index)
        if found < 0:
            out = out + substring(text, index, len(text))
            break
        out = out + substring(text, index, found)
        out = out + replacement
        index = found + len(needle)
    return out

def _aot_find_substring_from(haystack, needle, start):
    if len(needle) == 0:
        return start
    i = start
    while True:
        if i + len(needle) > len(haystack):
            break
        matches = True
        j = 0
        while True:
            if j >= len(needle):
                break
            if haystack[i + j] != needle[j]:
                matches = False
                break
            j += 1
        if matches:
            return i
        i += 1
    return -1

def prepare_stage2_aot_modules(module_names, module_texts):
    rewritten = []
    seen_functions = []
    seen_globals = []
    module_index = 0
    while True:
        if module_index >= len(module_names)  or  module_index >= len(module_texts):
            break
        module_name = module_names[module_index]
        ir = module_texts[module_index]
        if module_name == "main":
            ir = _aot_replace(ir, "@main(", "@stage2_compiler_main(")
        defined_functions = _aot_find_defined_functions(ir)
        defined_globals = _aot_find_defined_globals(ir)
        safe_module_name = _aot_sanitize_module_suffix(module_name)
        fi = 0
        while True:
            if fi >= len(defined_functions):
                break
            name = defined_functions[fi]
            if not _aot_contains_string(seen_functions, name):
                seen_functions = _aot_append_unique(seen_functions, name)
                fi += 1
                continue
            counter = 1
            candidate = ""
            while True:
                suffix = safe_module_name
                if counter != 1:
                    suffix = safe_module_name + "_" + _aot_number_to_string(counter)
                candidate = name + "__" + suffix
                if not _aot_contains_string(seen_functions, candidate):
                    break
                counter += 1
            ir = _aot_rename_symbol_refs(ir, name, candidate)
            seen_functions = _aot_append_unique(seen_functions, candidate)
            fi += 1
        gi = 0
        while True:
            if gi >= len(defined_globals):
                break
            name = defined_globals[gi]
            if not _aot_contains_string(seen_globals, name):
                seen_globals = _aot_append_unique(seen_globals, name)
                gi += 1
                continue
            counter = 1
            candidate = ""
            while True:
                suffix = safe_module_name
                if counter != 1:
                    suffix = safe_module_name + "_" + _aot_number_to_string(counter)
                candidate = name + "__" + suffix
                if not _aot_contains_string(seen_globals, candidate):
                    break
                counter += 1
            ir = _aot_rename_symbol_refs(ir, name, candidate)
            seen_globals = _aot_append_unique(seen_globals, candidate)
            gi += 1
        ir = _aot_ensure_intrinsic_decls(ir)
        rewritten = (rewritten) + ([ir])
        module_index += 1
    return rewritten
