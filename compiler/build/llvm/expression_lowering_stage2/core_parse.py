import asyncio
from runtime import runtime_support as runtime

from ...string_utils import substring, char_code, char_at
from compiler.build.llvm.expression_lowering_stage2.core_text import trim_text, append_string, string_array_contains, index_of, char_code_at_text, is_digit_char
from ..utils import ends_with, is_identifier_start_char
from ..expressions import is_simple_identifier
from ..expression_lowering.splitting import split_array_elements
from ..types import StructLiteralParse, StructLiteralField, EnumLiteralParse, MemberAccessParse, IndexExpressionParse, RangeIterableParse

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

def find_matching_closing_brace(text, open_index):
    depth = 0
    index = open_index
    in_single = False
    in_double = False
    escape = False
    while True:
        if index >= len(text):
            break
        ch = text[index]
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
        if ch == "{":
            depth += 1
        else:
            if ch == "}":
                if depth > 0:
                    depth -= 1
                    if depth == 0:
                        return index
        index += 1
    return -1

def find_top_level_colon(text):
    paren_depth = 0
    bracket_depth = 0
    brace_depth = 0
    angle_depth = 0
    in_single = False
    in_double = False
    escape = False
    index = 0
    while True:
        if index >= len(text):
            break
        ch = text[index]
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
        if ch == ":":
            if paren_depth == 0  and  bracket_depth == 0  and  brace_depth == 0  and  angle_depth == 0:
                return index
        index += 1
    return -1

def parse_struct_literal(text):
    trimmed = trim_text(text)
    diagnostics = []
    if len(trimmed) == 0:
        return StructLiteralParse(recognized=False, success=False, type_name="", fields=[], diagnostics=diagnostics)
    first = trimmed[0]
    if not is_identifier_start_char(first):
        return StructLiteralParse(recognized=False, success=False, type_name="", fields=[], diagnostics=diagnostics)
    paren_depth = 0
    bracket_depth = 0
    angle_depth = 0
    index = 0
    open_index = -1
    in_single = False
    in_double = False
    escape = False
    while True:
        if index >= len(trimmed):
            break
        ch = trimmed[index]
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
                        if ch == "<":
                            angle_depth += 1
                        else:
                            if ch == ">":
                                if angle_depth > 0:
                                    angle_depth -= 1
                            else:
                                if ch == "{":
                                    if paren_depth == 0  and  bracket_depth == 0  and  angle_depth == 0:
                                        open_index = index
                                        break
        index += 1
    if open_index < 0:
        return StructLiteralParse(recognized=False, success=False, type_name="", fields=[], diagnostics=diagnostics)
    fatal = False
    close_index = find_matching_closing_brace(trimmed, open_index)
    if close_index < 0:
        diagnostics = append_string(diagnostics, "llvm lowering: struct literal missing closing `}`")
        snippet = trimmed
        if len(snippet) > 120:
            snippet = substring(snippet, 0, 117) + "..."
        diagnostics = append_string(diagnostics, "llvm lowering: struct literal context `" + snippet + "`")
        fatal = True
    type_name = trim_text(substring(trimmed, 0, open_index))
    if len(type_name) == 0:
        diagnostics = append_string(diagnostics, "llvm lowering: struct literal missing type name")
        fatal = True
    fields = []
    if not fatal  and  close_index >= 0:
        body = substring(trimmed, open_index + 1, close_index)
        entries = split_array_elements(body)
        seen = []
        entry_index = 0
        while True:
            if entry_index >= len(entries):
                break
            entry = trim_text(entries[entry_index])
            entry_index += 1
            if len(entry) == 0:
                continue
            colon_index = find_top_level_colon(entry)
            if colon_index < 0:
                diagnostics = append_string(diagnostics, "llvm lowering: struct literal field `" + entry + "` missing `:`")
                continue
            field_name = trim_text(substring(entry, 0, colon_index))
            value_text = trim_text(substring(entry, colon_index + 1, len(entry)))
            if len(field_name) == 0:
                diagnostics = append_string(diagnostics, "llvm lowering: struct literal field missing name")
                continue
            if string_array_contains(seen, field_name):
                diagnostics = append_string(diagnostics, "llvm lowering: struct literal field `" + field_name + "` repeated")
                continue
            if len(value_text) == 0:
                diagnostics = append_string(diagnostics, "llvm lowering: struct literal field `" + field_name + "` missing value")
                continue
            seen = append_string(seen, field_name)
            fields.append(StructLiteralField(name=field_name, value=value_text))
    if not fatal  and  close_index >= 0:
        remainder = trim_text(substring(trimmed, close_index + 1, len(trimmed)))
        if len(remainder) > 0:
            diagnostics = append_string(diagnostics, "llvm lowering: struct literal trailing content `" + remainder + "`")
            fatal = True
    if fatal:
        fields = []
    return StructLiteralParse(recognized=True, success=not fatal, type_name=type_name, fields=fields, diagnostics=diagnostics)

def parse_struct_pattern(text):
    trimmed = trim_text(text)
    diagnostics = []
    if len(trimmed) == 0:
        return StructLiteralParse(recognized=False, success=False, type_name="", fields=[], diagnostics=diagnostics)
    first = trimmed[0]
    if not is_identifier_start_char(first):
        return StructLiteralParse(recognized=False, success=False, type_name="", fields=[], diagnostics=diagnostics)
    paren_depth = 0
    bracket_depth = 0
    angle_depth = 0
    index = 0
    open_index = -1
    in_single = False
    in_double = False
    escape = False
    while True:
        if index >= len(trimmed):
            break
        ch = trimmed[index]
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
                        if ch == "<":
                            angle_depth += 1
                        else:
                            if ch == ">":
                                if angle_depth > 0:
                                    angle_depth -= 1
                            else:
                                if ch == "{":
                                    if paren_depth == 0  and  bracket_depth == 0  and  angle_depth == 0:
                                        open_index = index
                                        break
        index += 1
    if open_index < 0:
        return StructLiteralParse(recognized=False, success=False, type_name="", fields=[], diagnostics=diagnostics)
    fatal = False
    close_index = find_matching_closing_brace(trimmed, open_index)
    if close_index < 0:
        fatal = True
    type_name = trim_text(substring(trimmed, 0, open_index))
    if len(type_name) == 0:
        fatal = True
    fields = []
    if not fatal  and  close_index >= 0:
        body = substring(trimmed, open_index + 1, close_index)
        entries = split_array_elements(body)
        seen = []
        entry_index = 0
        while True:
            if entry_index >= len(entries):
                break
            entry = trim_text(entries[entry_index])
            entry_index += 1
            if len(entry) == 0:
                continue
            colon_index = find_top_level_colon(entry)
            if colon_index < 0:
                field_name = trim_text(entry)
                if len(field_name) == 0:
                    continue
                if string_array_contains(seen, field_name):
                    continue
                seen = append_string(seen, field_name)
                fields.append(StructLiteralField(name=field_name, value=""))
                continue
            field_name = trim_text(substring(entry, 0, colon_index))
            value_text = trim_text(substring(entry, colon_index + 1, len(entry)))
            if len(field_name) == 0:
                continue
            if string_array_contains(seen, field_name):
                continue
            if len(value_text) == 0:
                continue
            seen = append_string(seen, field_name)
            fields.append(StructLiteralField(name=field_name, value=value_text))
    if fatal:
        fields = []
    return StructLiteralParse(recognized=True, success=not fatal, type_name=type_name, fields=fields, diagnostics=diagnostics)

def parse_enum_literal(text):
    trimmed = trim_text(text)
    diagnostics = []
    if len(trimmed) == 0:
        return EnumLiteralParse(recognized=False, success=False, enum_name="", variant_name="", fields=[], diagnostics=diagnostics)
    first = trimmed[0]
    if not is_identifier_start_char(first):
        return EnumLiteralParse(recognized=False, success=False, enum_name="", variant_name="", fields=[], diagnostics=diagnostics)
    dot_index = index_of(trimmed, ".")
    if dot_index < 0:
        return EnumLiteralParse(recognized=False, success=False, enum_name="", variant_name="", fields=[], diagnostics=diagnostics)
    enum_name_part = trim_text(substring(trimmed, 0, dot_index))
    if len(enum_name_part) == 0:
        return EnumLiteralParse(recognized=False, success=False, enum_name="", variant_name="", fields=[], diagnostics=diagnostics)
    paren_depth = 0
    bracket_depth = 0
    angle_depth = 0
    index = dot_index + 1
    open_index = -1
    in_single = False
    in_double = False
    escape = False
    while True:
        if index >= len(trimmed):
            break
        ch = trimmed[index]
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
                        if ch == "<":
                            angle_depth += 1
                        else:
                            if ch == ">":
                                if angle_depth > 0:
                                    angle_depth -= 1
                            else:
                                if ch == "{":
                                    if paren_depth == 0  and  bracket_depth == 0  and  angle_depth == 0:
                                        open_index = index
                                        break
        index += 1
    if open_index < 0:
        variant_name_part = trim_text(substring(trimmed, dot_index + 1, len(trimmed)))
        if len(variant_name_part) == 0:
            return EnumLiteralParse(recognized=False, success=False, enum_name="", variant_name="", fields=[], diagnostics=diagnostics)
        paren_depth = 0
        bracket_depth = 0
        angle_depth = 0
        in_single = False
        in_double = False
        escape = False
        dot_seen = False
        scan_index = 0
        while True:
            if scan_index >= len(variant_name_part):
                break
            ch = variant_name_part[scan_index]
            if in_double:
                if escape:
                    escape = False
                else:
                    if ch == "\\":
                        escape = True
                    else:
                        if ch == "\"":
                            in_double = False
                scan_index += 1
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
                scan_index += 1
                continue
            if ch == "\"":
                in_double = True
                scan_index += 1
                continue
            if ch == "'":
                in_single = True
                scan_index += 1
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
                            if ch == "<":
                                angle_depth += 1
                            else:
                                if ch == ">":
                                    if angle_depth > 0:
                                        angle_depth -= 1
                                else:
                                    if ch == ".":
                                        if paren_depth == 0  and  bracket_depth == 0  and  angle_depth == 0:
                                            dot_seen = True
                                            break
            scan_index += 1
        if dot_seen:
            return EnumLiteralParse(recognized=False, success=False, enum_name="", variant_name="", fields=[], diagnostics=diagnostics)
        if ends_with(variant_name_part, "()"):
            variant_name_part = trim_text(substring(variant_name_part, 0, len(variant_name_part) - 2))
        if len(variant_name_part) == 0:
            return EnumLiteralParse(recognized=False, success=False, enum_name="", variant_name="", fields=[], diagnostics=diagnostics)
        if not is_simple_identifier(variant_name_part):
            return EnumLiteralParse(recognized=False, success=False, enum_name="", variant_name="", fields=[], diagnostics=diagnostics)
        return EnumLiteralParse(recognized=True, success=True, enum_name=enum_name_part, variant_name=variant_name_part, fields=[], diagnostics=diagnostics)
    fatal = False
    close_index = find_matching_closing_brace(trimmed, open_index)
    if close_index < 0:
        diagnostics = append_string(diagnostics, "llvm lowering: enum literal missing closing `}`")
        fatal = True
    variant_name_part = trim_text(substring(trimmed, dot_index + 1, open_index))
    if len(variant_name_part) == 0:
        diagnostics = append_string(diagnostics, "llvm lowering: enum literal missing variant name")
        fatal = True
    fields = []
    if not fatal  and  close_index >= 0:
        body = substring(trimmed, open_index + 1, close_index)
        entries = split_array_elements(body)
        seen = []
        entry_index = 0
        while True:
            if entry_index >= len(entries):
                break
            entry = trim_text(entries[entry_index])
            entry_index += 1
            if len(entry) == 0:
                continue
            colon_index = find_top_level_colon(entry)
            if colon_index < 0:
                field_name = trim_text(entry)
                if len(field_name) == 0:
                    diagnostics = append_string(diagnostics, "llvm lowering: enum literal field missing name")
                    continue
                if string_array_contains(seen, field_name):
                    diagnostics = append_string(diagnostics, "llvm lowering: enum literal field `" + field_name + "` repeated")
                    continue
                seen = append_string(seen, field_name)
                fields.append(StructLiteralField(name=field_name, value=""))
                continue
            field_name = trim_text(substring(entry, 0, colon_index))
            value_text = trim_text(substring(entry, colon_index + 1, len(entry)))
            if len(field_name) == 0:
                diagnostics = append_string(diagnostics, "llvm lowering: enum literal field missing name")
                continue
            if string_array_contains(seen, field_name):
                diagnostics = append_string(diagnostics, "llvm lowering: enum literal field `" + field_name + "` repeated")
                continue
            if len(value_text) == 0:
                diagnostics = append_string(diagnostics, "llvm lowering: enum literal field `" + field_name + "` missing value")
                continue
            seen = append_string(seen, field_name)
            fields.append(StructLiteralField(name=field_name, value=value_text))
    if not fatal  and  close_index >= 0:
        remainder = trim_text(substring(trimmed, close_index + 1, len(trimmed)))
        if len(remainder) > 0:
            diagnostics = append_string(diagnostics, "llvm lowering: enum literal trailing content `" + remainder + "`")
            fatal = True
    if fatal:
        fields = []
    return EnumLiteralParse(recognized=True, success=not fatal, enum_name=enum_name_part, variant_name=variant_name_part, fields=fields, diagnostics=diagnostics)

def find_top_level_range_separator(value):
    paren_depth = 0
    bracket_depth = 0
    brace_depth = 0
    index = 0
    while True:
        if index >= len(value):
            break
        ch = value[index]
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
        if ch == ".":
            if index + 1 < len(value):
                if value[index + 1] == ".":
                    if paren_depth == 0  and  bracket_depth == 0  and  brace_depth == 0:
                        return index
        index += 1
    return -1

def find_top_level_range_separator_from(value, start_index):
    paren_depth = 0
    bracket_depth = 0
    brace_depth = 0
    index = 0
    while True:
        if index >= len(value):
            break
        ch = value[index]
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
        if index >= start_index:
            if ch == ".":
                if index + 1 < len(value):
                    if value[index + 1] == ".":
                        if paren_depth == 0  and  bracket_depth == 0  and  brace_depth == 0:
                            return index
        index += 1
    return -1

def find_member_access_separator(value):
    paren_depth = 0
    bracket_depth = 0
    brace_depth = 0
    in_single = False
    in_double = False
    escape = False
    index = 0
    last_index = -1
    while True:
        if index >= len(value):
            break
        ch = char_at(value, index)
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
        if ch == "'":
            in_single = True
            index += 1
            continue
        if ch == "\"":
            in_double = True
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
        if paren_depth == 0  and  bracket_depth == 0  and  brace_depth == 0:
            if ch == ".":
                if index > 0:
                    previous = char_at(value, index - 1)
                    if previous == ".":
                        index += 1
                        continue
                    if is_digit_char(previous):
                        if index + 1 < len(value):
                            next_digit = char_at(value, index + 1)
                            if is_digit_char(next_digit):
                                index += 1
                                continue
                if index + 1 < len(value):
                    next_char = char_at(value, index + 1)
                    if next_char == ".":
                        index += 1
                        continue
                last_index = index
        index += 1
    return last_index

def parse_member_access(expression):
    trimmed = trim_text(expression)
    if len(trimmed) == 0:
        return MemberAccessParse(success=False, base="", field="")
    separator = find_member_access_separator(trimmed)
    if separator < 0:
        return MemberAccessParse(success=False, base="", field="")
    base = trim_text(substring(trimmed, 0, separator))
    field = trim_text(substring(trimmed, separator + 1, len(trimmed)))
    if len(base) == 0  or  len(field) == 0:
        return MemberAccessParse(success=False, base="", field="")
    if not is_simple_identifier(field):
        return MemberAccessParse(success=False, base="", field="")
    return MemberAccessParse(success=True, base=base, field=field)

def parse_index_expression(expression):
    trimmed = trim_text(expression)
    if len(trimmed) == 0:
        return IndexExpressionParse(success=False, base="", index="")
    bracket_depth = 0
    index_position = -1
    i = len(trimmed) - 1
    if char_code_at_text(trimmed, len(trimmed) - 1) != char_code("]"):
        return IndexExpressionParse(success=False, base="", index="")
    bracket_depth = 1
    i = len(trimmed) - 2
    while True:
        if i < 0:
            break
        ch = char_at(trimmed, i)
        if ch == "]":
            bracket_depth += 1
        if ch == "[":
            bracket_depth -= 1
            if bracket_depth == 0:
                index_position = i
                break
        i -= 1
    if index_position < 0:
        return IndexExpressionParse(success=False, base="", index="")
    base = trim_text(substring(trimmed, 0, index_position))
    index = trim_text(substring(trimmed, index_position + 1, len(trimmed) - 1))
    if len(base) == 0  or  len(index) == 0:
        return IndexExpressionParse(success=False, base="", index="")
    return IndexExpressionParse(success=True, base=base, index=index)

def parse_range_iterable(iterable):
    trimmed = trim_text(iterable)
    diagnostics = []
    if len(trimmed) == 0:
        diagnostics = append_string(diagnostics, "llvm lowering: `.for` iterable expression is empty")
        return RangeIterableParse(success=False, start="", end="", stride="", diagnostics=diagnostics)
    first_separator = find_top_level_range_separator(trimmed)
    has_stride = False
    stride_text = ""
    if first_separator < 0:
        diagnostics = append_string(diagnostics, "llvm lowering: `.for` iterable must use `start..end` range syntax")
        return RangeIterableParse(success=False, start="", end="", stride="", diagnostics=diagnostics)
    second_separator = find_top_level_range_separator_from(trimmed, first_separator + 2)
    start_text = trim_text(substring(trimmed, 0, first_separator))
    end_text = trim_text(substring(trimmed, first_separator + 2, len(trimmed)))
    if second_separator >= 0:
        end_text = trim_text(substring(trimmed, first_separator + 2, second_separator))
        stride_text = trim_text(substring(trimmed, second_separator + 2, len(trimmed)))
        has_stride = len(stride_text) > 0
    if len(start_text) == 0:
        diagnostics = append_string(diagnostics, "llvm lowering: `.for` range missing start expression")
    if len(end_text) == 0:
        diagnostics = append_string(diagnostics, "llvm lowering: `.for` range missing end expression")
    if has_stride  and  len(stride_text) == 0:
        diagnostics = append_string(diagnostics, "llvm lowering: `.for` range missing stride expression")
    success = len(start_text) > 0  and  len(end_text) > 0  and  (not has_stride  or  len(stride_text) > 0)
    return RangeIterableParse(success=success, start=start_text, end=end_text, stride=stride_text, diagnostics=diagnostics)
