import asyncio
from runtime import runtime_support as runtime

from ..native_ir import NativeFunction, NativeSourceSpan
from ..string_utils import substring, char_code, char_at, index_of
from compiler.build.llvm.types import TypeContext, LocalBinding, ParameterBinding, LLVMOperand, ExpressionResult, OperatorMatch, CoercionResult, StringConstant, AssignmentParseResult, InlineLetParseResult, TernaryParseResult, MemberAccessParse, IndexExpressionParse, RawAddressParseResult, CastParseResult
from compiler.build.llvm.utils import trim_text, append_string, starts_with, ends_with, sanitize_symbol, number_to_string, join_with_separator, is_identifier_start_char, is_identifier_part_char
from compiler.build.llvm.strings import empty_string_constant_set, append_string_constant, find_string_constant

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

def find_local_binding(locals, name):
    index = len(locals)
    while True:
        if index <= 0:
            break
        index -= 1
        entry = locals[index]
        if entry.name == name:
            return entry
    return None

def find_parameter_binding(bindings, name):
    index = 0
    while True:
        if index >= len(bindings):
            break
        binding = bindings[index]
        if binding.name == name:
            return binding
        index += 1
    return None

def mark_parameter_consumed(bindings, name):
    result = []
    index = 0
    while True:
        if index >= len(bindings):
            break
        binding = bindings[index]
        if binding.name == name:
            updated = ParameterBinding(name=binding.name, llvm_name=binding.llvm_name, llvm_type=binding.llvm_type, type_annotation=binding.type_annotation, consumed=True, span=binding.span)
            result.append(updated)
        else:
            result.append(binding)
        index += 1
    return result

def mark_local_consumed(locals, name):
    result = []
    index = 0
    while True:
        if index >= len(locals):
            break
        entry = locals[index]
        if entry.name == name:
            updated = LocalBinding(name=entry.name, pointer=entry.pointer, llvm_type=entry.llvm_type, type_annotation=entry.type_annotation, ownership=entry.ownership, consumed=True, scope_id=entry.scope_id, scope_depth=entry.scope_depth)
            result.append(updated)
        else:
            result.append(entry)
        index += 1
    return result

def reset_local_consumption(locals, name):
    result = []
    index = 0
    while True:
        if index >= len(locals):
            break
        entry = locals[index]
        if entry.name == name:
            updated = LocalBinding(name=entry.name, pointer=entry.pointer, llvm_type=entry.llvm_type, type_annotation=entry.type_annotation, ownership=entry.ownership, consumed=False, scope_id=entry.scope_id, scope_depth=entry.scope_depth)
            result.append(updated)
        else:
            result.append(entry)
        index += 1
    return result

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
                        else:
                            if escape_code == char_code("0"):
                                return 0
        return escape_code
    return char_code(char_at(inner, 0))

def matches_case_insensitive(text, target):
    if len(text) != len(target):
        return False
    index = 0
    while True:
        if index >= len(text):
            break
        ch = char_code_at_text(text, index)
        target_ch = char_code_at_text(target, index)
        text_lower = ch
        target_lower = target_ch
        if ch >= 65  and  ch <= 90:
            text_lower = ch + 32
        if target_ch >= 65  and  target_ch <= 90:
            target_lower = target_ch + 32
        if text_lower != target_lower:
            return False
        index += 1
    return True

def is_simple_identifier(value):
    trimmed = trim_text(value)
    if len(trimmed) == 0:
        return False
    first = trimmed[0]
    if first >= "0"  and  first <= "9":
        return False
    sanitized = sanitize_symbol(trimmed)
    if sanitized != trimmed:
        return False
    return True

def is_effect_delimiter(ch):
    if ch == "!"  or  ch == "?":
        return True
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

def strip_mut_prefix(value):
    trimmed = trim_text(value)
    if len(trimmed) < 4:
        return trimmed
    prefix = substring(trimmed, 0, 4)
    if prefix == "mut ":
        return trim_text(substring(trimmed, 4, len(trimmed)))
    return trimmed

def contains_text(haystack, needle):
    if len(needle) == 0:
        return True
    if len(haystack) < len(needle):
        return False
    index = 0
    while True:
        if index + len(needle) > len(haystack):
            break
        candidate = substring(haystack, index, index + len(needle))
        if candidate == needle:
            return True
        index += 1
    return False

def is_copy_type(type_annotation, llvm_type):
    trimmed = trim_text(type_annotation)
    if starts_with(trimmed, "Affine<")  or  starts_with(trimmed, "Linear<"):
        return False
    if trimmed == "Affine"  or  trimmed == "Linear":
        return False
    if llvm_type == "double":
        return True
    if llvm_type == "i32":
        return True
    if llvm_type == "i64":
        return True
    if llvm_type == "i1":
        return True
    if ends_with_pointer_suffix(llvm_type):
        return True
    if len(trimmed) == 0:
        return True
    if trimmed[0] == "&":
        return True
    if starts_with(trimmed, "mut "):
        stripped = strip_mut_prefix(trimmed)
        if len(stripped) > 0:
            if stripped[0] == "&":
                return True
    return False

def ends_with_pointer_suffix(value):
    trimmed = trim_text(value)
    if len(trimmed) == 0:
        return False
    return trimmed[len(trimmed) - 1] == "*"

def default_return_literal(llvm_type):
    if llvm_type == "double":
        return "0.0"
    if llvm_type == "i32":
        return "0"
    if llvm_type == "i64":
        return "0"
    if llvm_type == "i1":
        return "false"
    if ends_with_pointer_suffix(llvm_type):
        return "null"
    return "zeroinitializer"

def format_temp_name(index):
    return "%t" + number_to_string(index)

def format_local_pointer_name(index):
    return "%l" + number_to_string(index)

def format_typed_operand(operand):
    return operand.llvm_type + " " + operand.value

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
        if paren_depth == 0  and  bracket_depth == 0  and  brace_depth == 0  and  angle_depth == 0:
            if index + 2 <= len(expression):
                two_char = substring(expression, index, index + 2)
                if contains_text(operators, two_char):
                    candidate_index = index
                    candidate_symbol = two_char
                    index += 2
                    continue
            if contains_text(operators, ch):
                candidate_index = index
                candidate_symbol = ch
        index += 1
    success = candidate_index >= 0
    return OperatorMatch(success=success, index=candidate_index, symbol=candidate_symbol)

def is_binary_minus(expression, index):
    if index == 0:
        return False
    prev_char = char_at(expression, index - 1)
    if prev_char == " "  or  prev_char == "\t":
        return True
    if is_identifier_part_char(prev_char):
        return True
    if prev_char == ")"  or  prev_char == "]":
        return True
    return False

def is_binary_star(expression, index):
    if index == 0:
        return False
    prev_char = char_at(expression, index - 1)
    if prev_char == " "  or  prev_char == "\t":
        return True
    if is_identifier_part_char(prev_char):
        return True
    if prev_char == ")"  or  prev_char == "]":
        return True
    return False

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

def find_top_level_union_separator(text):
    paren_depth = 0
    brace_depth = 0
    bracket_depth = 0
    angle_depth = 0
    in_single = False
    in_double = False
    escape = False
    index = 0
    while True:
        if index >= len(text):
            break
        ch = substring(text, index, index + 1)
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
                        if ch == "{":
                            brace_depth += 1
                        else:
                            if ch == "}":
                                if brace_depth > 0:
                                    brace_depth -= 1
                            else:
                                if ch == "<":
                                    angle_depth += 1
                                else:
                                    if ch == ">":
                                        if angle_depth > 0:
                                            angle_depth -= 1
                                    else:
                                        if ch == "|":
                                            if paren_depth == 0  and  brace_depth == 0  and  bracket_depth == 0  and  angle_depth == 0:
                                                return index
        index += 1
    return -1

def parse_member_access(expression):
    trimmed = trim_text(expression)
    paren_depth = 0
    bracket_depth = 0
    brace_depth = 0
    in_double = False
    in_single = False
    escape_next = False
    last_dot = -1
    index = 0
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
        if ch == ".":
            if paren_depth == 0  and  bracket_depth == 0  and  brace_depth == 0:
                if index + 1 < len(trimmed)  and  char_at(trimmed, index + 1) == ".":
                    index += 2
                    continue
                last_dot = index
        index += 1
    if last_dot < 0:
        return MemberAccessParse(success=False, base="", field="")
    base = trim_text(substring(trimmed, 0, last_dot))
    field = trim_text(substring(trimmed, last_dot + 1, len(trimmed)))
    return MemberAccessParse(success=True, base=base, field=field)

def parse_index_expression(expression):
    trimmed = trim_text(expression)
    if len(trimmed) < 3:
        return IndexExpressionParse(success=False, base="", index="")
    if trimmed[len(trimmed) - 1] != "]":
        return IndexExpressionParse(success=False, base="", index="")
    bracket_depth = 0
    paren_depth = 0
    brace_depth = 0
    in_double = False
    in_single = False
    escape_next = False
    open_bracket = -1
    index = len(trimmed) - 1
    while True:
        if index < 0:
            break
        ch = char_at(trimmed, index)
        if in_double:
            if escape_next:
                escape_next = False
                index -= 1
                continue
            if ch == "\\":
                escape_next = True
                index -= 1
                continue
            if ch == "\"":
                in_double = False
            index -= 1
            continue
        if in_single:
            if escape_next:
                escape_next = False
                index -= 1
                continue
            if ch == "\\":
                escape_next = True
                index -= 1
                continue
            if ch == "'":
                in_single = False
            index -= 1
            continue
        if ch == "\"":
            in_double = True
            index -= 1
            continue
        if ch == "'":
            in_single = True
            index -= 1
            continue
        if ch == ")":
            paren_depth += 1
            index -= 1
            continue
        if ch == "(":
            if paren_depth > 0:
                paren_depth -= 1
            index -= 1
            continue
        if ch == "}":
            brace_depth += 1
            index -= 1
            continue
        if ch == "{":
            if brace_depth > 0:
                brace_depth -= 1
            index -= 1
            continue
        if ch == "]":
            bracket_depth += 1
            index -= 1
            continue
        if ch == "[":
            if bracket_depth > 0:
                bracket_depth -= 1
                if bracket_depth == 0  and  paren_depth == 0  and  brace_depth == 0:
                    open_bracket = index
                    break
            index -= 1
            continue
        index -= 1
    if open_bracket < 0:
        return IndexExpressionParse(success=False, base="", index="")
    base = trim_text(substring(trimmed, 0, open_bracket))
    index_value = trim_text(substring(trimmed, open_bracket + 1, len(trimmed) - 1))
    return IndexExpressionParse(success=True, base=base, index=index_value)

def parse_assignment_expression(expression):
    trimmed = trim_text(expression)
    paren_depth = 0
    bracket_depth = 0
    brace_depth = 0
    in_double = False
    in_single = False
    escape_next = False
    equals_index = -1
    index = 0
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
        if paren_depth == 0  and  bracket_depth == 0  and  brace_depth == 0:
            if ch == "=":
                if index > 0:
                    prev = char_at(trimmed, index - 1)
                    if prev == "="  or  prev == "!"  or  prev == "<"  or  prev == ">":
                        index += 1
                        continue
                if index + 1 < len(trimmed):
                    next = char_at(trimmed, index + 1)
                    if next == "=":
                        index += 2
                        continue
                equals_index = index
                break
        index += 1
    if equals_index < 0:
        return AssignmentParseResult(success=False, target="", value="", operator="")
    target = trim_text(substring(trimmed, 0, equals_index))
    value = trim_text(substring(trimmed, equals_index + 1, len(trimmed)))
    return AssignmentParseResult(success=True, target=target, value=value, operator="")

def parse_inline_let_expression(expression):
    trimmed = trim_text(expression)
    diagnostics = []
    if not starts_with(trimmed, "let "):
        return InlineLetParseResult(success=False, name="", mutable=False, type_annotation="", initializer="", diagnostics=diagnostics)
    remainder = trim_text(substring(trimmed, 4, len(trimmed)))
    is_mutable = False
    after_mut = remainder
    if starts_with(remainder, "mut "):
        is_mutable = True
        after_mut = trim_text(substring(remainder, 4, len(remainder)))
    assignment = parse_assignment_expression(after_mut)
    if not assignment.success:
        diagnostics = append_string(diagnostics, "llvm lowering: inline let expression missing initializer")
        return InlineLetParseResult(success=False, name="", mutable=is_mutable, type_annotation="", initializer="", diagnostics=diagnostics)
    lhs = trim_text(assignment.target)
    initializer = trim_text(assignment.value)
    name = ""
    type_annotation = ""
    arrow_index = index_of(lhs, "->")
    if arrow_index >= 0:
        name = trim_text(substring(lhs, 0, arrow_index))
        type_annotation = trim_text(substring(lhs, arrow_index + 2, len(lhs)))
    else:
        name = lhs
    if len(name) == 0:
        diagnostics = append_string(diagnostics, "llvm lowering: inline let expression missing variable name")
        return InlineLetParseResult(success=False, name="", mutable=is_mutable, type_annotation=type_annotation, initializer=initializer, diagnostics=diagnostics)
    return InlineLetParseResult(success=True, name=name, mutable=is_mutable, type_annotation=type_annotation, initializer=initializer, diagnostics=diagnostics)

def parse_ternary_expression(text):
    diagnostics = []
    trimmed = trim_text(text)
    if len(trimmed) == 0:
        return TernaryParseResult(success=False, condition="", true_value="", false_value="", diagnostics=diagnostics)
    depth = 0
    question_index = -1
    colon_index = -1
    index = 0
    in_double = False
    in_single = False
    escape_next = False
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
        if ch == "("  or  ch == "["  or  ch == "{":
            depth += 1
            index += 1
            continue
        if ch == ")"  or  ch == "]"  or  ch == "}":
            if depth > 0:
                depth -= 1
            index += 1
            continue
        if depth == 0:
            if ch == "?"  and  question_index < 0:
                question_index = index
            else:
                if ch == ":"  and  question_index >= 0  and  colon_index < 0:
                    colon_index = index
                    break
        index += 1
    if question_index < 0  or  colon_index < 0:
        return TernaryParseResult(success=False, condition="", true_value="", false_value="", diagnostics=diagnostics)
    condition = trim_text(substring(trimmed, 0, question_index))
    true_value = trim_text(substring(trimmed, question_index + 1, colon_index))
    false_value = trim_text(substring(trimmed, colon_index + 1, len(trimmed)))
    return TernaryParseResult(success=True, condition=condition, true_value=true_value, false_value=false_value, diagnostics=diagnostics)

def parse_raw_address_expression(text):
    trimmed = trim_text(text)
    if not starts_with(trimmed, "raw_address("):
        return RawAddressParseResult(recognized=False, success=False, target="", diagnostics=[])
    if not ends_with(trimmed, ")"):
        diagnostics = ["llvm lowering: raw_address expression missing closing `)`"]
        return RawAddressParseResult(recognized=True, success=False, target="", diagnostics=diagnostics)
    inner = trim_text(substring(trimmed, 12, len(trimmed) - 1))
    if len(inner) == 0:
        diagnostics = ["llvm lowering: raw_address expression missing target"]
        return RawAddressParseResult(recognized=True, success=False, target="", diagnostics=diagnostics)
    return RawAddressParseResult(recognized=True, success=True, target=inner, diagnostics=[])

def parse_cast_expression(text):
    trimmed = trim_text(text)
    diagnostics = []
    if len(trimmed) == 0:
        return CastParseResult(recognized=False, success=False, value="", type_annotation="", diagnostics=diagnostics)
    paren_depth = 0
    bracket_depth = 0
    brace_depth = 0
    angle_depth = 0
    in_double = False
    in_single = False
    escape_next = False
    match_index = -1
    index = 0
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
