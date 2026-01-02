import asyncio
from runtime import runtime_support as runtime

from ...native_ir import NativeSourceSpan
from ..types import LocalBinding, ParameterBinding, OwnershipAnalysis, OwnershipInfo, OwnershipConsumption
from ..utils import trim_text, append_string, number_to_string
from ..type_mapping import is_copy_type
from ..expressions import is_simple_identifier
from compiler.build.llvm.expression_lowering_stage2.core_scopes import find_local_binding
from compiler.build.llvm.expression_lowering_stage2.core_bindings_stage2 import find_parameter_binding
from compiler.build.llvm.expression_lowering_stage2.core_parsing_stage2 import parse_borrow_expression

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

def analyze_value_ownership_impl(initializer, span, locals, bindings):
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
        resolved_base = resolve_borrow_base_impl(parse.target, locals)
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

def format_use_after_move_message(name, span):
    if span == None:
        return "llvm lowering: use-after-move of `" + name + "`"
    return "llvm lowering: use-after-move of `" + name + "` at " + format_span_location(span)

def format_span_location(span):
    start = number_to_string(span.start_line) + ":" + number_to_string(span.start_column)
    end = number_to_string(span.end_line) + ":" + number_to_string(span.end_column)
    return start + "-" + end

def format_suspension_location_impl(keyword, borrow_span, suspension_span):
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

def detect_borrow_conflicts_impl(ownership, locals, binding_name, function_name):
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

def resolve_borrow_base_impl(target, locals):
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
