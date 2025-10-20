import asyncio
from runtime import runtime_support as runtime

from compiler.build.runtime.prelude import clamp, substring, find_char, grapheme_count, grapheme_at, char_code

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
globals()['t' + 'rue'] = True
globals()['f' + 'alse'] = False

def char_at(value, index):
    if len(value) == 0:
        return ""
    if index < 0:
        return ""
    if index >= len(value):
        return ""
    return substring(value, index, index + 1)

__all__ = ["clamp", "substring", "find_char", "grapheme_count", "grapheme_at", "char_code", "char_at"]
