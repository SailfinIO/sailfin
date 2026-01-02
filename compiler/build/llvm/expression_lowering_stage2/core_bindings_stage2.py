import asyncio
from runtime import runtime_support as runtime

from ..types import LocalBinding, ParameterBinding, OwnershipInfo
from ..expression_lowering.bindings import bindings_find_parameter_binding, bindings_mark_parameter_consumed, bindings_mark_local_consumed, bindings_reset_local_consumption, bindings_update_local_ownership

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

def mark_parameter_consumed(bindings, name):
    return bindings_mark_parameter_consumed(bindings, name)

def mark_local_consumed(locals, name):
    return bindings_mark_local_consumed(locals, name)

def reset_local_consumption(locals, name):
    return bindings_reset_local_consumption(locals, name)

def update_local_ownership(locals, name, ownership):
    return bindings_update_local_ownership(locals, name, ownership)
