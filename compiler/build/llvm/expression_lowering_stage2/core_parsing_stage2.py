import asyncio
from runtime import runtime_support as runtime

from ...string_utils import substring, char_at
from ..types import TypeContext, BorrowParseResult, BorrowArgumentParse, TernaryParseResult, RawAddressParseResult, CastParseResult, ArrayLiteralMetadata
from ..utils import trim_text, starts_with, append_string, is_effect_delimiter, is_identifier_start_char, is_identifier_part_char
from ..type_mapping import array_struct_type_for_element
from ..type_mapping import map_type_annotation
from compiler.build.llvm.expression_lowering_stage2.core_type_mapping_stage2 import map_primitive_type

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

def parse_borrow_expression(expression):
    trimmed = trim_text(expression)
    diagnostics = []
    if len(trimmed) == 0:
        return BorrowParseResult(recognized=False, success=False, target="", mutable=False, diagnostics=diagnostics)
    is_prefix_form = False
    remainder = ""
    mutable_flag = False
    if starts_with(trimmed, "&"):
        if starts_with(trimmed, "&&"):
            return BorrowParseResult(recognized=False, success=False, target="", mutable=False, diagnostics=diagnostics)
        is_prefix_form = True
        remainder = trim_text(substring(trimmed, 1, len(trimmed)))
    else:
        after_keyword = ""
        if starts_with(trimmed, "borrow_mut"):
            after_keyword = trim_text(substring(trimmed, 10, len(trimmed)))
            mutable_flag = True
        else:
            if starts_with(trimmed, "borrow"):
                after_keyword = trim_text(substring(trimmed, 6, len(trimmed)))
            else:
                return BorrowParseResult(recognized=False, success=False, target="", mutable=False, diagnostics=diagnostics)
        if len(after_keyword) == 0  or  after_keyword[0] != "(":
            return BorrowParseResult(recognized=False, success=False, target="", mutable=False, diagnostics=diagnostics)
        remainder = after_keyword
    if is_prefix_form:
        if starts_with(remainder, "mut"):
            mutable_flag = True
            after_mut = substring(remainder, 3, len(remainder))
            remainder = trim_text(after_mut)
    if len(remainder) == 0:
        issue = append_string(diagnostics, "llvm lowering: borrow expression missing target")
        return BorrowParseResult(recognized=True, success=False, target="", mutable=mutable_flag, diagnostics=issue)
    if len(remainder) > 0  and  remainder[0] == "(":
        argument_parse = extract_borrow_argument(remainder)
        messages = (diagnostics) + (argument_parse.diagnostics)
        if not argument_parse.success:
            return BorrowParseResult(recognized=True, success=False, target="", mutable=mutable_flag, diagnostics=messages)
        argument_text = argument_parse.argument
        if starts_with(argument_text, "mut"):
            after_mut = substring(argument_text, 3, len(argument_text))
            trimmed_after_mut = trim_text(after_mut)
            if len(trimmed_after_mut) > 0:
                mutable_flag = True
                argument_text = trimmed_after_mut
        if len(argument_text) == 0:
            messages = append_string(messages, "llvm lowering: borrow expression missing target")
            return BorrowParseResult(recognized=True, success=False, target="", mutable=mutable_flag, diagnostics=messages)
        if not is_valid_borrow_target(argument_text):
            return BorrowParseResult(recognized=False, success=False, target="", mutable=mutable_flag, diagnostics=diagnostics)
        return BorrowParseResult(recognized=True, success=True, target=argument_text, mutable=mutable_flag, diagnostics=messages)
    simple_parse = extract_simple_borrow_target(remainder)
    if not simple_parse.success:
        return BorrowParseResult(recognized=False, success=False, target="", mutable=mutable_flag, diagnostics=diagnostics)
    if not is_valid_borrow_target(simple_parse.argument):
        return BorrowParseResult(recognized=False, success=False, target="", mutable=mutable_flag, diagnostics=diagnostics)
    return BorrowParseResult(recognized=True, success=True, target=simple_parse.argument, mutable=mutable_flag, diagnostics=diagnostics)

def extract_borrow_argument(text):
    diagnostics = []
    depth = 0
    index = 0
    closing_index = -1
    while True:
        if index >= len(text):
            break
        ch = text[index]
        if ch == "(":
            depth += 1
            index += 1
            continue
        if ch == ")":
            if depth == 0:
                diagnostics = append_string(diagnostics, "llvm lowering: borrow expression missing opening `(`")
                return BorrowArgumentParse(success=False, argument="", diagnostics=diagnostics)
            depth -= 1
            current_index = index
            index += 1
            if depth == 0:
                closing_index = current_index
                break
            continue
        index += 1
    if closing_index < 0:
        diagnostics = append_string(diagnostics, "llvm lowering: borrow expression missing closing `)`")
        return BorrowArgumentParse(success=False, argument="", diagnostics=diagnostics)
    inner = substring(text, 1, closing_index)
    remainder = trim_text(substring(text, closing_index + 1, len(text)))
    if len(remainder) > 0:
        diagnostics = append_string(diagnostics, "llvm lowering: borrow expression trailing content `" + remainder + "`")
        return BorrowArgumentParse(success=False, argument="", diagnostics=diagnostics)
    return BorrowArgumentParse(success=True, argument=trim_text(inner), diagnostics=diagnostics)

def extract_simple_borrow_target(text):
    diagnostics = []
    trimmed = trim_text(text)
    if len(trimmed) == 0:
        diagnostics = append_string(diagnostics, "llvm lowering: borrow expression missing target")
        return BorrowArgumentParse(success=False, argument="", diagnostics=diagnostics)
    index = 0
    while True:
        if index >= len(trimmed):
            break
        ch = trimmed[index]
        if is_effect_delimiter(ch):
            break
        index += 1
    target = trim_text(substring(trimmed, 0, index))
    if len(target) == 0:
        diagnostics = append_string(diagnostics, "llvm lowering: borrow expression missing target")
        return BorrowArgumentParse(success=False, argument="", diagnostics=diagnostics)
    remainder = trim_text(substring(trimmed, index, len(trimmed)))
    if len(remainder) > 0:
        diagnostics = append_string(diagnostics, "llvm lowering: borrow expression trailing content `" + remainder + "`")
        return BorrowArgumentParse(success=False, argument=target, diagnostics=diagnostics)
    return BorrowArgumentParse(success=True, argument=target, diagnostics=diagnostics)

def is_valid_borrow_target(text):
    trimmed = trim_text(text)
    if len(trimmed) == 0:
        return False
    index = 0
    while True:
        if index >= len(trimmed):
            break
        ch = trimmed[index]
        if ch == ".":
            index += 1
            continue
        if index == 0:
            if not is_identifier_start_char(ch):
                return False
        else:
            if not is_identifier_part_char(ch):
                return False
        index += 1
    return True

def parse_ternary_expression(text):
    diagnostics = []
    trimmed = trim_text(text)
    if len(trimmed) == 0:
        return TernaryParseResult(success=False, condition="", true_value="", false_value="", diagnostics=diagnostics)
    depth = 0
    question_index = -1
    colon_index = -1
    index = 0
    while True:
        if index >= len(trimmed):
            break
        ch = trimmed[index]
        if ch == "("  or  ch == "["  or  ch == "{":
            depth += 1
            index += 1
            continue
        if ch == ")"  or  ch == "]"  or  ch == "}":
            depth -= 1
            index += 1
            continue
        if depth == 0:
            if ch == "?"  and  question_index < 0:
                question_index = index
                index += 1
                continue
            if ch == ":"  and  question_index >= 0  and  colon_index < 0:
                colon_index = index
                index += 1
                continue
        index += 1
    if question_index < 0  or  colon_index < 0:
        return TernaryParseResult(success=False, condition="", true_value="", false_value="", diagnostics=diagnostics)
    if question_index >= colon_index:
        diagnostics = append_string(diagnostics, "llvm lowering: malformed ternary expression - `:` before `?`")
        return TernaryParseResult(success=False, condition="", true_value="", false_value="", diagnostics=diagnostics)
    condition = trim_text(substring(trimmed, 0, question_index))
    true_value = trim_text(substring(trimmed, question_index + 1, colon_index))
    false_value = trim_text(substring(trimmed, colon_index + 1, len(trimmed)))
    if len(condition) == 0:
        diagnostics = append_string(diagnostics, "llvm lowering: ternary expression missing condition")
        return TernaryParseResult(success=False, condition="", true_value="", false_value="", diagnostics=diagnostics)
    if len(true_value) == 0:
        diagnostics = append_string(diagnostics, "llvm lowering: ternary expression missing true branch value")
        return TernaryParseResult(success=False, condition="", true_value="", false_value="", diagnostics=diagnostics)
    if len(false_value) == 0:
        diagnostics = append_string(diagnostics, "llvm lowering: ternary expression missing false branch value")
        return TernaryParseResult(success=False, condition="", true_value="", false_value="", diagnostics=diagnostics)
    return TernaryParseResult(success=True, condition=condition, true_value=true_value, false_value=false_value, diagnostics=diagnostics)

def parse_raw_address_expression(text):
    trimmed = trim_text(text)
    diagnostics = []
    if len(trimmed) == 0:
        return RawAddressParseResult(recognized=False, success=False, target="", diagnostics=diagnostics)
    if not starts_with(trimmed, "&"):
        return RawAddressParseResult(recognized=False, success=False, target="", diagnostics=diagnostics)
    if starts_with(trimmed, "&raw"):
        remainder = trim_text(substring(trimmed, 4, len(trimmed)))
        if len(remainder) == 0:
            diagnostics = append_string(diagnostics, "llvm lowering: &raw expression missing target")
            return RawAddressParseResult(recognized=True, success=False, target="", diagnostics=diagnostics)
        return RawAddressParseResult(recognized=True, success=True, target=remainder, diagnostics=diagnostics)
    if starts_with(trimmed, "&"):
        after_amp = trim_text(substring(trimmed, 1, len(trimmed)))
        if starts_with(after_amp, "raw"):
            remainder = trim_text(substring(after_amp, 3, len(after_amp)))
            if len(remainder) == 0:
                diagnostics = append_string(diagnostics, "llvm lowering: &raw expression missing target")
                return RawAddressParseResult(recognized=True, success=False, target="", diagnostics=diagnostics)
            return RawAddressParseResult(recognized=True, success=True, target=remainder, diagnostics=diagnostics)
    return RawAddressParseResult(recognized=False, success=False, target="", diagnostics=diagnostics)

def parse_cast_expression(text):
    trimmed = trim_text(text)
    diagnostics = []
    if len(trimmed) == 0:
        return CastParseResult(recognized=False, success=False, value="", type_annotation="", diagnostics=diagnostics)
    paren_depth = 0
    bracket_depth = 0
    brace_depth = 0
    angle_depth = 0
    in_single = False
    in_double = False
    escape_next = False
    index = 0
    match_index = -1
    while True:
        if index >= len(trimmed):
            break
        ch = char_at(trimmed, index)
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
        if paren_depth == 0  and  bracket_depth == 0  and  brace_depth == 0  and  angle_depth == 0:
            if index + 4 <= len(trimmed):
                window = substring(trimmed, index, index + 4)
                if window == " as ":
                    match_index = index
        index += 1
    if match_index < 0:
        return CastParseResult(recognized=False, success=False, value="", type_annotation="", diagnostics=diagnostics)
    value = trim_text(substring(trimmed, 0, match_index))
    annotation = trim_text(substring(trimmed, match_index + 4, len(trimmed)))
    if len(value) == 0  or  len(annotation) == 0:
        diagnostics = append_string(diagnostics, "llvm lowering: malformed cast expression `" + text + "`")
        return CastParseResult(recognized=True, success=False, value=value, type_annotation=annotation, diagnostics=diagnostics)
    return CastParseResult(recognized=True, success=True, value=value, type_annotation=annotation, diagnostics=diagnostics)

def parse_array_literal_metadata(entries, context):
    if len(entries) == 0:
        return ArrayLiteralMetadata(element_type="", start_index=0)
    first = trim_text(entries[0])
    if len(first) < 9:
        return ArrayLiteralMetadata(element_type="", start_index=0)
    prefix = substring(first, 0, 9)
    if prefix != "#element:":
        return ArrayLiteralMetadata(element_type="", start_index=0)
    annotation = trim_text(substring(first, 9, len(first)))
    if len(annotation) == 0:
        return ArrayLiteralMetadata(element_type="", start_index=1)
    mapped = map_metadata_annotation(context, annotation)
    return ArrayLiteralMetadata(element_type=mapped, start_index=1)

def map_metadata_annotation(context, annotation):
    trimmed = trim_text(annotation)
    if len(trimmed) == 0:
        return ""
    primitive = map_primitive_type(context, trimmed)
    if len(primitive) > 0:
        return primitive
    if len(trimmed) > 2:
        suffix = substring(trimmed, len(trimmed) - 2, len(trimmed))
        if suffix == "[]":
            inner_annotation = trim_text(substring(trimmed, 0, len(trimmed) - 2))
            inner_type = map_metadata_annotation(context, inner_annotation)
            if len(inner_type) == 0:
                return ""
            struct_type = array_struct_type_for_element(inner_type)
            return struct_type + "*"
    return ""
