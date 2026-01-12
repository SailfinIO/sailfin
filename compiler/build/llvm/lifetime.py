import asyncio
from runtime import runtime_support as runtime

from ..native_ir import NativeFunction, NativeSourceSpan
from ..string_utils import substring, find_char
from compiler.build.llvm.types import LocalBinding, ParameterBinding, OwnershipInfo, OwnershipConsumption, OwnershipAnalysis, LifetimeRegionMetadata, LifetimeReleaseEvent, BorrowParseResult, BorrowArgumentParse, ScopeMetadata, LLVMOperand, ExpressionResult, StringConstant
from compiler.build.llvm.utils import trim_text, append_string, starts_with, ends_with, char_at, sanitize_symbol, is_identifier_start_char, is_identifier_part_char, number_to_string
from compiler.build.llvm.strings import empty_string_constant_set
from compiler.build.llvm.expressions import find_local_binding, find_parameter_binding, is_simple_identifier, is_effect_delimiter, strip_enclosing_parentheses, is_copy_type
from compiler.build.llvm.type_mapping import unwrap_move_wrapper

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

def parse_borrow_expression(text):
    trimmed = trim_text(text)
    diagnostics = []
    if len(trimmed) == 0:
        return BorrowParseResult(recognized=False, success=False, target="", mutable=False, diagnostics=diagnostics)
    if starts_with(trimmed, "borrow"):
        if len(trimmed) > 6:
            next = char_at(trimmed, 6)
            if next != " "  and  next != "\t"  and  next != "(":
                return BorrowParseResult(recognized=False, success=False, target="", mutable=False, diagnostics=diagnostics)
        remainder = trim_text(substring(trimmed, 6, len(trimmed)))
        if len(remainder) == 0:
            issue = append_string(diagnostics, "llvm lowering: borrow expression missing target")
            return BorrowParseResult(recognized=True, success=False, target="", mutable=False, diagnostics=issue)
        mutable_flag = False
        if starts_with(remainder, "mut"):
            after_mut = substring(remainder, 3, len(remainder))
            mutable_flag = True
            remainder = trim_text(after_mut)
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
    if not starts_with(trimmed, "&"):
        return BorrowParseResult(recognized=False, success=False, target="", mutable=False, diagnostics=diagnostics)
    if starts_with(trimmed, "&&"):
        return BorrowParseResult(recognized=False, success=False, target="", mutable=False, diagnostics=diagnostics)
    remainder = trim_text(substring(trimmed, 1, len(trimmed)))
    mutable_flag = False
    if starts_with(remainder, "mut"):
        mutable_flag = True
        after_mut = substring(remainder, 3, len(remainder))
        remainder = trim_text(after_mut)
    if len(remainder) == 0:
        issue = append_string(diagnostics, "llvm lowering: borrow expression missing target")
        return BorrowParseResult(recognized=True, success=False, target="", mutable=mutable_flag, diagnostics=issue)
    return BorrowParseResult(recognized=True, success=True, target=trim_text(remainder), mutable=mutable_flag, diagnostics=diagnostics)

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

def lower_borrow_expression(parse, bindings, locals, temp_index, lines):
    diagnostics = parse.diagnostics
    empty_constants = empty_string_constant_set()
    if not parse.success:
        return ExpressionResult(lines=lines, temp_index=temp_index, operand=None, diagnostics=diagnostics, string_constants=empty_constants)
    target = strip_enclosing_parentheses(parse.target)
    target = trim_text(target)
    if len(target) == 0:
        diagnostics = append_string(diagnostics, "llvm lowering: borrow expression missing target")
        return ExpressionResult(lines=lines, temp_index=temp_index, operand=None, diagnostics=diagnostics, string_constants=empty_constants)
    local = find_local_binding(locals, target)
    if local == None:
        parameter = find_parameter_binding(bindings, target)
        if parameter == None:
            diagnostics = append_string(diagnostics, "llvm lowering: borrow target `" + target + "` not found")
            return ExpressionResult(lines=lines, temp_index=temp_index, operand=None, diagnostics=diagnostics, string_constants=empty_constants)
        if ends_with(parameter.llvm_type, "*"):
            operand = LLVMOperand(llvm_type=parameter.llvm_type, value=parameter.llvm_name)
            return ExpressionResult(lines=lines, temp_index=temp_index, operand=operand, diagnostics=diagnostics, string_constants=empty_constants)
        diagnostics = append_string(diagnostics, "llvm lowering: cannot borrow non-addressable parameter `" + target + "` (type `" + parameter.llvm_type + "`)")
        return ExpressionResult(lines=lines, temp_index=temp_index, operand=None, diagnostics=diagnostics, string_constants=empty_constants)
    pointer_type = local.llvm_type + "*"
    operand = LLVMOperand(llvm_type=pointer_type, value=local.pointer)
    return ExpressionResult(lines=lines, temp_index=temp_index, operand=operand, diagnostics=diagnostics, string_constants=empty_constants)

def analyze_value_ownership(initializer, span, locals, bindings):
    if initializer == None:
        return OwnershipAnalysis(ownership=None, consumption=None, diagnostics=[])
    trimmed = trim_text(initializer)
    if len(trimmed) == 0:
        return OwnershipAnalysis(ownership=None, consumption=None, diagnostics=[])
    parse = parse_borrow_expression(trimmed)
    diagnostics = parse.diagnostics
    if parse.recognized:
        if not parse.success:
            return OwnershipAnalysis(ownership=None, consumption=None, diagnostics=diagnostics)
        resolved_base = resolve_borrow_base(parse.target, locals)
        if len(resolved_base) == 0:
            diagnostics = append_string(diagnostics, "llvm lowering: borrow expression missing target")
            return OwnershipAnalysis(ownership=None, consumption=None, diagnostics=diagnostics)
        ownership = OwnershipInfo(variant="Borrow", base=resolved_base, mutable=parse.mutable, span=span, region_id=-1)
        return OwnershipAnalysis(ownership=ownership, consumption=None, diagnostics=diagnostics)
    if is_simple_identifier(trimmed):
        name = trimmed
        local = find_local_binding(locals, name)
        if local != None:
            if local.consumed:
                diagnostics = append_string(diagnostics, format_use_after_move_message(name, span))
                return OwnershipAnalysis(ownership=None, consumption=None, diagnostics=diagnostics)
            if is_copy_type(local.type_annotation, local.llvm_type):
                return OwnershipAnalysis(ownership=None, consumption=None, diagnostics=diagnostics)
            consumption = OwnershipConsumption(kind="local", name=name)
            return OwnershipAnalysis(ownership=None, consumption=consumption, diagnostics=diagnostics)
        parameter = find_parameter_binding(bindings, name)
        if parameter != None:
            if parameter.consumed:
                diagnostics = append_string(diagnostics, format_use_after_move_message(name, span))
                return OwnershipAnalysis(ownership=None, consumption=None, diagnostics=diagnostics)
            if is_copy_type(parameter.type_annotation, parameter.llvm_type):
                return OwnershipAnalysis(ownership=None, consumption=None, diagnostics=diagnostics)
            consumption = OwnershipConsumption(kind="parameter", name=name)
            return OwnershipAnalysis(ownership=None, consumption=consumption, diagnostics=diagnostics)
    return OwnershipAnalysis(ownership=None, consumption=None, diagnostics=diagnostics)

def update_local_ownership(locals, name, ownership):
    result = []
    index = 0
    while True:
        if index >= len(locals):
            break
        entry = locals[index]
        if entry.name == name:
            updated = LocalBinding(name=entry.name, pointer=entry.pointer, llvm_type=entry.llvm_type, type_annotation=entry.type_annotation, ownership=ownership, consumed=entry.consumed, scope_id=entry.scope_id, scope_depth=entry.scope_depth)
            result.append(updated)
        else:
            result.append(entry)
        index += 1
    return result

def detect_borrow_conflicts(ownership, locals, binding_name, function_name):
    diagnostics = []
    if ownership == None:
        return diagnostics
    if ownership.variant != "Borrow":
        return diagnostics
    base = trim_text(ownership.base)
    index = 0
    while True:
        if index >= len(locals):
            break
        existing = locals[index]
        if existing.ownership != None:
            details = existing.ownership
            if details.variant == "Borrow":
                existing_base = trim_text(details.base)
                if existing_base == base:
                    if ownership.mutable:
                        if details.mutable:
                            diagnostics = append_string(diagnostics, "llvm lowering: mutable borrow `" + binding_name + "` conflicts with active mutable borrow `" + existing.name + "` of `" + base + "` in `" + function_name + "`")
                        else:
                            diagnostics = append_string(diagnostics, "llvm lowering: mutable borrow `" + binding_name + "` conflicts with active shared borrow `" + existing.name + "` of `" + base + "` in `" + function_name + "`")
                    else:
                        if details.mutable:
                            diagnostics = append_string(diagnostics, "llvm lowering: shared borrow `" + binding_name + "` conflicts with active mutable borrow `" + existing.name + "` of `" + base + "` in `" + function_name + "`")
        index += 1
    return diagnostics

def resolve_borrow_base(target, locals):
    return resolve_borrow_base_inner(trim_text(target), locals, 0)

def resolve_borrow_base_inner(target, locals, depth):
    trimmed = trim_text(target)
    if len(trimmed) == 0:
        return trimmed
    if depth >= 8:
        return trimmed
    if not is_simple_identifier(trimmed):
        return trimmed
    binding = find_local_binding(locals, trimmed)
    if binding == None:
        return trimmed
    if binding.ownership == None:
        return trimmed
    details = binding.ownership
    if details.variant != "Borrow":
        return trimmed
    return resolve_borrow_base_inner(details.base, locals, depth + 1)

def normalise_borrow_base(raw_base):
    trimmed = trim_text(raw_base)
    while True:
        if len(trimmed) == 0:
            break
        if trimmed[0] == "*":
            trimmed = trim_text(substring(trimmed, 1, len(trimmed)))
            continue
        break
    if len(trimmed) >= 2:
        if trimmed[0] == "(":
            if trimmed[len(trimmed) - 1] == ")":
                inner = trim_text(substring(trimmed, 1, len(trimmed) - 1))
                if len(inner) > 0:
                    return inner
    return trimmed

def is_mutable_borrow_annotation(annotation):
    trimmed = trim_text(annotation)
    if len(trimmed) == 0:
        return False
    normalized = unwrap_move_wrapper(trimmed)
    if len(normalized) == 0:
        return False
    if normalized[0] != "&":
        return False
    remainder = trim_text(substring(normalized, 1, len(normalized)))
    if len(remainder) == 0:
        return False
    if starts_with(remainder, "mut"):
        return True
    return False

def append_lifetime_region(values, value):
    return (values) + ([value])

def append_lifetime_release_event(events, event):
    return (events) + ([event])

def mark_lifetime_region_released(regions, region_id, scope_id, scope_depth):
    result = []
    index = 0
    while True:
        if index >= len(regions):
            break
        entry = regions[index]
        if entry.id == region_id:
            updated = LifetimeRegionMetadata(id=entry.id, binding=entry.binding, base=entry.base, mutable=entry.mutable, start_span=entry.start_span, scope_id=entry.scope_id, scope_depth=entry.scope_depth, base_scope_id=entry.base_scope_id, base_scope_depth=entry.base_scope_depth, end_scope_id=scope_id, end_scope_depth=scope_depth, released=True)
            result.append(updated)
        else:
            result.append(entry)
        index += 1
    return result

def apply_lifetime_release_events(regions, releases):
    if len(releases) == 0:
        return regions
    current_regions = regions
    index = 0
    while True:
        if index >= len(releases):
            break
        release = releases[index]
        current_regions = mark_lifetime_region_released(current_regions, release.region_id, release.scope_id, release.scope_depth)
        index += 1
    return current_regions

def make_lifetime_region_metadata(id, binding, ownership, scope_id, scope_depth, base_scope_id, base_scope_depth):
    return LifetimeRegionMetadata(id=id, binding=binding, base=ownership.base, mutable=ownership.mutable, start_span=ownership.span, scope_id=scope_id, scope_depth=scope_depth, base_scope_id=base_scope_id, base_scope_depth=base_scope_depth, end_scope_id="", end_scope_depth=0, released=False)

def infer_borrow_base_scope(base, locals, bindings, function_name):
    local = find_local_binding(locals, base)
    if local != None:
        return ScopeMetadata(scope_id=local.scope_id, scope_depth=local.scope_depth)
    parameter = find_parameter_binding(bindings, base)
    if parameter != None:
        return ScopeMetadata(scope_id=format_root_scope_id(function_name), scope_depth=0)
    return ScopeMetadata(scope_id=format_root_scope_id(function_name), scope_depth=0)

def validate_borrow_lifetimes(function, regions):
    diagnostics = []
    index = 0
    root_scope = format_root_scope_id(function.name)
    while True:
        if index >= len(regions):
            break
        region = regions[index]
        base_scope_id = region.base_scope_id
        base_scope_depth = region.base_scope_depth
        if len(base_scope_id) == 0:
            base_scope_id = root_scope
            base_scope_depth = 0
        violation = False
        if region.released:
            if len(region.end_scope_id) == 0:
                violation = True
            else:
                if not is_scope_descendant(base_scope_id, region.end_scope_id):
                    violation = True
        else:
            if region.scope_depth < base_scope_depth:
                violation = True
            else:
                if not is_scope_descendant(base_scope_id, region.scope_id):
                    violation = True
        if violation:
            location = ""
            if region.start_span != None:
                location = " at " + format_span_location(region.start_span)
            diagnostics = append_string(diagnostics, "llvm lowering: borrow `" + region.binding + "` of `" + region.base + "` escapes lifetime of `" + region.base + "` in `" + function.name + "`" + location)
        index += 1
    return diagnostics

def collect_suspension_conflicts(keyword, locals, bindings, function_name, suspension_span):
    diagnostics = []
    index = 0
    while True:
        if index >= len(locals):
            break
        local = locals[index]
        if not local.consumed  and  local.ownership != None:
            details = local.ownership
            if details.variant == "Borrow"  and  details.mutable:
                base_name = normalise_borrow_base(details.base)
                location = format_suspension_location(keyword, details.span, suspension_span)
                diagnostics = append_string(diagnostics, "llvm lowering: " + keyword + " suspends while mutable borrow `" + local.name + "` of `" + base_name + "` remains active in `" + function_name + "`" + location)
        index += 1
    parameter_index = 0
    while True:
        if parameter_index >= len(bindings):
            break
        binding = bindings[parameter_index]
        if not binding.consumed:
            if is_mutable_borrow_annotation(binding.type_annotation):
                location = format_suspension_location(keyword, binding.span, suspension_span)
                diagnostics = append_string(diagnostics, "llvm lowering: " + keyword + " suspends while mutable borrow parameter `" + binding.name + "` remains active in `" + function_name + "`" + location)
        parameter_index += 1
    return diagnostics

def detect_suspension_conflicts(expression, locals, bindings, function_name, suspension_span):
    if expression == None:
        return []
    trimmed = trim_text(expression)
    if len(trimmed) == 0:
        return []
    keyword = find_suspension_keyword(trimmed)
    if len(keyword) == 0:
        return []
    return collect_suspension_conflicts(keyword, locals, bindings, function_name, suspension_span)

def find_suspension_keyword(text):
    if starts_with(text, "await"):
        if len(text) == 5:
            return "await"
        next = char_at(text, 5)
        if next == " "  or  next == "\t"  or  next == "(":
            return "await"
    if starts_with(text, "yield"):
        if len(text) == 5:
            return "yield"
        next = char_at(text, 5)
        if next == " "  or  next == "\t"  or  next == "(":
            return "yield"
    return ""

def format_root_scope_id(function_name):
    sanitized = sanitize_symbol(function_name)
    if len(sanitized) == 0:
        sanitized = "fn"
    return "fn:" + sanitized

def make_child_scope_id(parent, child):
    sanitized_child = sanitize_symbol(child)
    if len(sanitized_child) == 0:
        sanitized_child = "scope"
    if len(parent) == 0:
        return sanitized_child
    return parent + "::" + sanitized_child

def is_scope_descendant(parent, candidate):
    if len(parent) == 0:
        return True
    if len(candidate) == 0:
        return False
    if candidate == parent:
        return True
    prefix = parent + "::"
    if len(candidate) <= len(prefix):
        return False
    return starts_with(candidate, prefix)

def format_use_after_move_message(name, span):
    if span == None:
        return "llvm lowering: use-after-move of `" + name + "`"
    return "llvm lowering: use-after-move of `" + name + "` at " + format_span_location(span)

def format_span_location(span):
    start = number_to_string(span.start_line) + ":" + number_to_string(span.start_column)
    end = number_to_string(span.end_line) + ":" + number_to_string(span.end_column)
    return start + "-" + end

def format_suspension_location(keyword, borrow_span, suspension_span):
    has_segment = False
    combined = ""
    if borrow_span != None:
        combined = "borrow at " + format_span_location(borrow_span)
        has_segment = True
    if suspension_span != None:
        label = keyword
        if len(label) == 0:
            label = "suspend"
        segment = label + " at " + format_span_location(suspension_span)
        if has_segment:
            combined = combined + "; " + segment
        else:
            combined = segment
            has_segment = True
    if not has_segment:
        return ""
    return " (" + combined + ")"
