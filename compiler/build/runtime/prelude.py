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
globals()['t' + 'rue'] = True
globals()['f' + 'alse'] = False

console = runtime.console
fs = runtime.fs
http = runtime.http
websocket = runtime.websocket

def sleep(milliseconds):
    # effects: clock
    runtime.sleep(milliseconds)

def channel(capacity = 0):
    # effects: io
    return runtime.channel(capacity)

def parallel(tasks):
    # effects: io
    results = []
    for task in tasks:
        value = task()
        results = (results) + ([value])
    return results

def spawn(task, name = ""):
    # effects: io
    if len(name) == 0:
        runtime.spawn(task)
        return
    runtime.spawn(task, name)

def logExecution(callable):
    return runtime.logExecution(callable)

def array_map(items, mapper):
    result = []
    for item in items:
        mapped = mapper(item)
        result = (result) + ([mapped])
    return result

def array_filter(items, predicate):
    result = []
    for item in items:
        if predicate(item):
            result = (result) + ([item])
    return result

def array_reduce(items, initial, reducer):
    accumulator = initial
    for item in items:
        accumulator = reducer(accumulator, item)
    return accumulator

def serve(handler, config = null):
    # effects: io, net
    runtime.serve(handler, config)

def clamp(value, minimum, maximum):
    if value < minimum:
        return minimum
    if value > maximum:
        return maximum
    return value

def substring(text, start, end):
    length = len(text)
    if length == 0:
        return ""
    normalized_start = clamp(start, 0, length)
    normalized_end = clamp(end, 0, length)
    if normalized_start >= normalized_end:
        return ""
    index = normalized_start
    result = ""
    while True:
        if index >= normalized_end:
            break
        result = result + text[index]
        index = index + 1
    return result

def find_char(text, character, start = 0):
    length = len(text)
    if length == 0:
        return -1
    normalized_start = start
    if normalized_start < 0:
        normalized_start = 0
    if normalized_start >= length:
        return -1
    target = character
    if len(target) == 2  and  target[0] == "\\":
        escape = target[1]
        if escape == "n":
            target = "\n"
        else:
            if escape == "r":
                target = "\r"
            else:
                if escape == "t":
                    target = "\t"
    index = normalized_start
    while True:
        if index >= length:
            break
        if text[index] == target:
            return index
        index = index + 1
    return -1

def char_code(character):
    if len(character) == 0:
        return -1
    ch = character[0]
    digits = "0123456789"
    digit_index = find_char(digits, ch, 0)
    if digit_index >= 0:
        return 48 + digit_index
    lowercase = "abcdefghijklmnopqrstuvwxyz"
    lowercase_index = find_char(lowercase, ch, 0)
    if lowercase_index >= 0:
        return 97 + lowercase_index
    uppercase = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    uppercase_index = find_char(uppercase, ch, 0)
    if uppercase_index >= 0:
        return 65 + uppercase_index
    if ch == " ":
        return 32
    if ch == "\n":
        return 10
    if ch == "\r":
        return 13
    if ch == "\t":
        return 9
    if ch == "\"":
        return 34
    if ch == "\\":
        return 92
    if ch == "_":
        return 95
    return runtime.char_code(character)

__all__ = ["clamp", "substring", "find_char", "char_code"]
