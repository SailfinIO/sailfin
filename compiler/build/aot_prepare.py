import asyncio
from runtime import runtime_support as runtime

from compiler.build.string_utils import substring
from compiler.build.native_ir import char_code

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

def _aot_bucket_index(key):
    if len(key) == 0:
        return 0
    return char_code(key[0]) % 256

def _aot_bucket_set_make():
    buckets = []
    i = 0
    while True:
        if i >= 256:
            break
        buckets.append([])
        i += 1
    return buckets

def _aot_bucket_set_contains(buckets, key):
    idx = _aot_bucket_index(key)
    return _aot_contains_string(buckets[idx], key)

def _aot_bucket_set_insert(buckets, key):
    if len(key) == 0:
        return buckets
    idx = _aot_bucket_index(key)
    existing = buckets[idx]
    if _aot_contains_string(existing, key):
        return buckets
    existing.append(key)
    out = buckets
    out[idx] = existing
    return out

def _aot_join_parts(parts):
    if len(parts) == 0:
        return ""
    if len(parts) == 1:
        return parts[0]
    current = parts
    while True:
        if len(current) <= 1:
            break
        next = []
        i = 0
        while True:
            if i >= len(current):
                break
            if i + 1 < len(current):
                next.append(current[i] + current[i + 1])
                i += 2
                continue
            next.append(current[i])
            i += 1
        current = next
    return current[0]

def _aot_apply_symbol_renames_lines(lines, olds, news):
    out = lines
    i = 0
    while True:
        if i >= len(out):
            break
        updated = out[i]
        j = 0
        while True:
            if j >= len(olds):
                break
            updated = _aot_rename_symbol_refs(updated, olds[j], news[j])
            j += 1
        out[i] = updated
        i += 1
    return out

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
    out = values
    out.append(value)
    return out

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
    parts = []
    changed = False
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
                    parts.append(substring(ir, last_emit, i))
                    parts.append("@" + fresh)
                    changed = True
                    i = end
                    last_emit = i
                    continue
        i += 1
    if not changed:
        return ir
    parts.append(substring(ir, last_emit, ir_len))
    return _aot_join_parts(parts)

def _aot_replace_lines(lines, needle, replacement):
    if len(needle) == 0:
        return lines
    out = []
    i = 0
    while True:
        if i >= len(lines):
            break
        out.append(_aot_replace(lines[i], needle, replacement))
        i += 1
    return out

def _aot_rename_symbol_refs_lines(lines, old, fresh):
    if len(old) == 0:
        return lines
    out = []
    i = 0
    while True:
        if i >= len(lines):
            break
        out.append(_aot_rename_symbol_refs(lines[i], old, fresh))
        i += 1
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
            lines.append(substring(text, start, index))
            start = index + 1
        index += 1
    lines.append(substring(text, start, text_len))
    return lines

def _aot_skip_line_ws(text, start, end):
    i = start
    while True:
        if i >= end:
            break
        ch = text[i]
        if ch == " "  or  ch == "\t"  or  ch == "\r":
            i += 1
            continue
        break
    return i

def _aot_line_has_global_or_constant(text, start, end):
    i = start
    saw_equals = False
    while True:
        if i >= end:
            break
        ch = text[i]
        if ch == "=":
            saw_equals = True
            i += 1
            continue
        if _aot_matches_at(text, i, " global"):
            return saw_equals
        if _aot_matches_at(text, i, " constant"):
            return saw_equals
        i += 1
    return False

def _aot_find_defined_functions_fast(ir):
    functions = []
    line_start = 0
    i = 0
    ir_len = len(ir)
    while True:
        if i > ir_len:
            break
        at_end = i == ir_len
        if not at_end  and  ir[i] != "\n":
            i += 1
            continue
        line_end = i
        start = _aot_skip_line_ws(ir, line_start, line_end)
        if _aot_matches_at(ir, start, "define"):
            j = start
            while True:
                if j >= line_end:
                    break
                if ir[j] == "@":
                    name_start = j + 1
                    k = name_start
                    while True:
                        if k >= line_end:
                            break
                        if not _aot_is_symbol_char(ir[k]):
                            break
                        k += 1
                    if k > name_start:
                        functions.append(substring(ir, name_start, k))
                    break
                j += 1
        line_start = i + 1
        i += 1
    return functions

def _aot_find_defined_globals_fast(ir):
    globals = []
    line_start = 0
    i = 0
    ir_len = len(ir)
    while True:
        if i > ir_len:
            break
        at_end = i == ir_len
        if not at_end  and  ir[i] != "\n":
            i += 1
            continue
        line_end = i
        start = _aot_skip_line_ws(ir, line_start, line_end)
        if start < line_end  and  ir[start] == "@":
            name_start = start + 1
            k = name_start
            while True:
                if k >= line_end:
                    break
                if not _aot_is_symbol_char(ir[k]):
                    break
                k += 1
            if k > name_start:
                if _aot_line_has_global_or_constant(ir, k, line_end):
                    globals.append(substring(ir, name_start, k))
        line_start = i + 1
        i += 1
    return globals

def _aot_find_defined_functions(ir):
    lines = _aot_split_lines(ir)
    functions = []
    i = 0
    while True:
        if i >= len(lines):
            break
        fun = _aot_parse_defined_function_name(lines[i])
        if len(fun) > 0:
            if not _aot_contains_string(functions, fun):
                functions.append(fun)
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
            if not _aot_contains_string(globals, glob):
                globals.append(glob)
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
    seen_functions = _aot_bucket_set_make()
    seen_globals = _aot_bucket_set_make()
    module_index = 0
    while True:
        if module_index >= len(module_names)  or  module_index >= len(module_texts):
            break
        module_name = module_names[module_index]
        ir = module_texts[module_index]
        if module_name == "main":
            ir = _aot_replace(ir, "@main(", "@stage2_compiler_main(")
        defined_functions = _aot_find_defined_functions_fast(ir)
        defined_globals = _aot_find_defined_globals_fast(ir)
        safe_module_name = _aot_sanitize_module_suffix(module_name)
        fi = 0
        while True:
            if fi >= len(defined_functions):
                break
            name = defined_functions[fi]
            if not _aot_bucket_set_contains(seen_functions, name):
                seen_functions = _aot_bucket_set_insert(seen_functions, name)
                fi += 1
                continue
            counter = 1
            candidate = ""
            while True:
                suffix = safe_module_name
                if counter != 1:
                    suffix = safe_module_name + "_" + _aot_number_to_string(counter)
                candidate = name + "__" + suffix
                if not _aot_bucket_set_contains(seen_functions, candidate):
                    break
                counter += 1
            ir = _aot_rename_symbol_refs(ir, name, candidate)
            seen_functions = _aot_bucket_set_insert(seen_functions, candidate)
            fi += 1
        gi = 0
        while True:
            if gi >= len(defined_globals):
                break
            name = defined_globals[gi]
            if not _aot_bucket_set_contains(seen_globals, name):
                seen_globals = _aot_bucket_set_insert(seen_globals, name)
                gi += 1
                continue
            counter = 1
            candidate = ""
            while True:
                suffix = safe_module_name
                if counter != 1:
                    suffix = safe_module_name + "_" + _aot_number_to_string(counter)
                candidate = name + "__" + suffix
                if not _aot_bucket_set_contains(seen_globals, candidate):
                    break
                counter += 1
            ir = _aot_rename_symbol_refs(ir, name, candidate)
            seen_globals = _aot_bucket_set_insert(seen_globals, candidate)
            gi += 1
        rewritten.append(ir)
        module_index += 1
    return rewritten
