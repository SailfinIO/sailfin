import asyncio
from runtime import runtime_support as runtime

from ..types import LocalBinding, ParameterBinding, OwnershipInfo

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

def bindings_find_parameter_binding(bindings, name):
    index = 0
    while True:
        if index >= len(bindings):
            break
        binding = bindings[index]
        if binding.name == name:
            return binding
        index += 1
    return None

def bindings_mark_parameter_consumed(bindings, name):
    result = []
    index = 0
    while True:
        if index >= len(bindings):
            break
        binding = bindings[index]
        if binding.name == name:
            updated = ParameterBinding(name=binding.name, llvm_name=binding.llvm_name, llvm_type=binding.llvm_type, type_annotation=binding.type_annotation, consumed=True, span=binding.span)
            result = (result) + ([updated])
        else:
            result = (result) + ([binding])
        index += 1
    return result

def bindings_mark_local_consumed(locals, name):
    result = []
    index = 0
    while True:
        if index >= len(locals):
            break
        entry = locals[index]
        if entry.name == name:
            updated = LocalBinding(name=entry.name, pointer=entry.pointer, llvm_type=entry.llvm_type, type_annotation=entry.type_annotation, ownership=entry.ownership, consumed=True, scope_id=entry.scope_id, scope_depth=entry.scope_depth)
            result = (result) + ([updated])
        else:
            result = (result) + ([entry])
        index += 1
    return result

def bindings_reset_local_consumption(locals, name):
    result = []
    index = 0
    while True:
        if index >= len(locals):
            break
        entry = locals[index]
        if entry.name == name:
            updated = LocalBinding(name=entry.name, pointer=entry.pointer, llvm_type=entry.llvm_type, type_annotation=entry.type_annotation, ownership=entry.ownership, consumed=False, scope_id=entry.scope_id, scope_depth=entry.scope_depth)
            result = (result) + ([updated])
        else:
            result = (result) + ([entry])
        index += 1
    return result

def bindings_update_local_ownership(locals, name, ownership):
    result = []
    index = 0
    while True:
        if index >= len(locals):
            break
        entry = locals[index]
        if entry.name == name:
            updated = LocalBinding(name=entry.name, pointer=entry.pointer, llvm_type=entry.llvm_type, type_annotation=entry.type_annotation, ownership=ownership, consumed=entry.consumed, scope_id=entry.scope_id, scope_depth=entry.scope_depth)
            result = (result) + ([updated])
        else:
            result = (result) + ([entry])
        index += 1
    return result
