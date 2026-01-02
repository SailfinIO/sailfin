import asyncio
from runtime import runtime_support as runtime

from ...native_ir import NativeStruct, NativeEnum
from ..types import OwnershipInfo, LifetimeRegionMetadata, LifetimeReleaseEvent, ScopeMetadata, LocalBinding, ParameterBinding, LLVMOperand, StructLiteralField
from ..utils import starts_with
from compiler.build.llvm.expression_lowering_stage2.core_text import sanitize_symbol
from ..expression_lowering.bindings import bindings_find_parameter_binding

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

def find_parameter_binding(bindings, name):
    return bindings_find_parameter_binding(bindings, name)

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

def infer_borrow_base_scope(base, locals, bindings, function_name):
    local = find_local_binding(locals, base)
    if local != None:
        return ScopeMetadata(scope_id=local.scope_id, scope_depth=local.scope_depth)
    parameter = find_parameter_binding(bindings, base)
    if parameter != None:
        return ScopeMetadata(scope_id=format_root_scope_id(function_name), scope_depth=0)
    return ScopeMetadata(scope_id=format_root_scope_id(function_name), scope_depth=0)

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
            result = append_lifetime_region(result, updated)
        else:
            result = append_lifetime_region(result, entry)
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

def append_local_binding(values, value):
    return (values) + ([value])

def append_llvm_operand(values, value):
    return (values) + ([value])

def append_struct_literal_field(values, value):
    return (values) + ([value])

def append_native_struct(values, value):
    return (values) + ([value])

def append_native_enum(values, value):
    return (values) + ([value])

def replace_llvm_operand(values, index, value):
    result = []
    current = 0
    while True:
        if current >= len(values):
            break
        if current == index:
            result = append_llvm_operand(result, value)
        else:
            result = append_llvm_operand(result, values[current])
        current += 1
    return result
