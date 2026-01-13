import asyncio
from runtime import runtime_support as runtime

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

def infer_effects(existing, decorator_names):
    effects = clone_effects(existing)
    requires_io = contains_effect(effects, "io")
    index = 0
    while True:
        if index >= len(decorator_names):
            break
        name = decorator_names[index]
        if name == "trace"  or  name == "logExecution"  or  name == "logexecution":
            requires_io = True
        index += 1
    if requires_io  and  not contains_effect(effects, "io"):
        effects = append_string(effects, "io")
    return effects

def append_string(collection, item):
    return (collection) + ([item])

def clone_effects(effects):
    clone = []
    index = 0
    while True:
        if index >= len(effects):
            break
        clone = append_string(clone, effects[index])
        index += 1
    return clone

def contains_effect(effects, effect):
    index = 0
    while True:
        if index >= len(effects):
            break
        if effects[index] == effect:
            return True
        index += 1
    return False
