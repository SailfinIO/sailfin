import asyncio
from runtime import runtime_support as runtime

from ..native_ir import NativeFunction, NativeInstruction
from ..string_utils import substring, char_at
from compiler.build.llvm.types import FunctionEffectEntry, FunctionCallEntry, CapabilityManifest, CapabilityManifestEntry, RuntimeHelperDescriptor
from compiler.build.llvm.utils import trim_text, append_string, copy_string_array, string_array_contains, string_arrays_equal, is_identifier_start_char, is_identifier_part_char, is_trim_char, is_effect_prefix_char, is_effect_delimiter, index_of, find_last_index_of_char, matches_case_insensitive, matches_keyword, skip_string_literal
from compiler.build.llvm.runtime_helpers import find_runtime_helper

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

def collect_direct_function_effects(functions):
    entries = []
    index = 0
    while True:
        if index >= len(functions):
            break
        entry = collect_function_effect_entry(functions[index])
        entries = append_function_effect_entry(entries, entry)
        index += 1
    return entries

def collect_function_effect_entry(function):
    combined = []
    combined = merge_effect_lists(combined, function.effects)
    combined = merge_effect_lists(combined, collect_function_borrow_effects(function))
    return FunctionEffectEntry(name=function.name, effects=combined)

def append_function_effect_entry(values, entry):
    return (values) + ([entry])

def merge_effect_lists(base, extras):
    result = []
    index = 0
    while True:
        if index >= len(base):
            break
        result = append_unique_effect(result, base[index])
        index += 1
    index = 0
    while True:
        if index >= len(extras):
            break
        result = append_unique_effect(result, extras[index])
        index += 1
    return result

def append_unique_effect(effects, effect):
    if len(effect) == 0:
        return effects
    if string_array_contains(effects, effect):
        return effects
    return (effects) + ([effect])

def collect_function_borrow_effects(function):
    effects = []
    index = 0
    while True:
        if index >= len(function.instructions):
            break
        instruction = function.instructions[index]
        if instruction.variant == "Let":
            if instruction.value != None:
                effects = merge_effect_lists(effects, collect_expression_borrow_effects(instruction.value))
        else:
            if instruction.variant == "Expression":
                effects = merge_effect_lists(effects, collect_expression_borrow_effects(instruction.expression))
            else:
                if instruction.variant == "Return":
                    trimmed = trim_text(instruction.expression)
                    if len(trimmed) > 0:
                        effects = merge_effect_lists(effects, collect_expression_borrow_effects(trimmed))
        index += 1
    return effects

def collect_expression_borrow_effects(expression):
    trimmed = trim_text(expression)
    if len(trimmed) == 0:
        return []
    effects = []
    index = 0
    while True:
        if index >= len(trimmed):
            break
        ch = trimmed[index]
        if ch == "\"":
            index = skip_string_literal(trimmed, index + 1)
            continue
        if ch == "&":
            if index + 1 < len(trimmed)  and  trimmed[index + 1] == "&":
                index += 2
                continue
            if index > 0:
                prefix = trimmed[index - 1]
                if is_identifier_part_char(prefix):
                    index += 1
                    continue
            cursor = index + 1
            mutable_flag = False
            if cursor + 3 <= len(trimmed):
                maybe_mut = substring(trimmed, cursor, cursor + 3)
                if maybe_mut == "mut":
                    after_mut_index = cursor + 3
                    if after_mut_index >= len(trimmed)  or  is_effect_delimiter(trimmed[after_mut_index]):
                        mutable_flag = True
                        cursor = after_mut_index
            while True:
                if cursor >= len(trimmed):
                    break
                current = trimmed[cursor]
                if not is_trim_char(current):
                    break
                cursor += 1
            if cursor < len(trimmed):
                target_start = trimmed[cursor]
                if is_identifier_start_char(target_start):
                    if mutable_flag:
                        effects = append_unique_effect(effects, "mut")
                    else:
                        effects = append_unique_effect(effects, "read")
            index += 1
            continue
        if ch == "b":
            if matches_keyword(trimmed, index, "borrow"):
                before_index = index - 1
                if before_index < 0  or  is_effect_prefix_char(trimmed[before_index]):
                    effects = append_unique_effect(effects, "read")
                    index += 6
                    continue
        index += 1
    return effects

def collect_function_call_graph(functions):
    entries = []
    function_names = collect_function_names(functions)
    index = 0
    while True:
        if index >= len(functions):
            break
        call_entry = collect_function_call_entry(functions[index], function_names)
        entries = append_function_call_entry(entries, call_entry)
        index += 1
    return entries

def collect_function_call_entry(function, function_names):
    callees = []
    index = 0
    while True:
        if index >= len(function.instructions):
            break
        instruction = function.instructions[index]
        callees = merge_effect_lists(callees, collect_instruction_calls(instruction, function_names))
        index += 1
    return FunctionCallEntry(name=function.name, callees=callees)

def collect_function_names(functions):
    names = []
    index = 0
    while True:
        if index >= len(functions):
            break
        names = append_string(names, functions[index].name)
        index += 1
    return names

def append_function_call_entry(entries, entry):
    return (entries) + ([entry])

def collect_instruction_calls(instruction, function_names):
    callees = []
    if instruction.variant == "Let":
        if instruction.value != None:
            callees = merge_effect_lists(callees, extract_call_targets(instruction.value, function_names))
        return callees
    if instruction.variant == "Expression":
        callees = merge_effect_lists(callees, extract_call_targets(instruction.expression, function_names))
        return callees
    if instruction.variant == "Return":
        trimmed = trim_text(instruction.expression)
        if len(trimmed) > 0:
            callees = merge_effect_lists(callees, extract_call_targets(trimmed, function_names))
        return callees
    if instruction.variant == "If":
        callees = merge_effect_lists(callees, extract_call_targets(instruction.condition, function_names))
        return callees
    if instruction.variant == "For":
        callees = merge_effect_lists(callees, extract_call_targets(instruction.iterable, function_names))
        return callees
    if instruction.variant == "Match":
        callees = merge_effect_lists(callees, extract_call_targets(instruction.expression, function_names))
        return callees
    if instruction.variant == "Case":
        callees = merge_effect_lists(callees, extract_call_targets(instruction.pattern, function_names))
        if instruction.guard != None:
            callees = merge_effect_lists(callees, extract_call_targets(instruction.guard, function_names))
        return callees
    return callees

def extract_call_targets(expression, function_names):
    results = []
    expression_len = len(expression)
    if expression_len == 0:
        return results
    index = 0
    while True:
        if index >= expression_len:
            break
        ch = expression[index]
        if ch == "\"":
            index = skip_string_literal(expression, index + 1)
            continue
        if is_identifier_start_char(ch):
            start_index = index
            index += 1
            while True:
                if index >= expression_len:
                    break
                current = expression[index]
                if is_identifier_part_char(current):
                    index += 1
                    continue
                if current == ".":
                    index += 1
                    continue
                break
            candidate = substring(expression, start_index, index)
            if len(candidate) > 0:
                while True:
                    dot_index = index_of(candidate, ".")
                    if dot_index == -1:
                        break
                    candidate = substring(candidate, dot_index + 1, len(candidate))
                cursor = index
                while True:
                    if cursor >= expression_len:
                        break
                    next = expression[cursor]
                    if is_trim_char(next):
                        cursor += 1
                        continue
                    if next == "(":
                        if string_array_contains(function_names, candidate):
                            results = append_unique_effect(results, candidate)
                    break
            continue
        index += 1
    return results

def extract_all_call_targets(expression):
    results = []
    expression_len = len(expression)
    if expression_len == 0:
        return results
    index = 0
    while True:
        if index >= expression_len:
            break
        ch = expression[index]
        if ch == "\"":
            index = skip_string_literal(expression, index + 1)
            continue
        if is_identifier_start_char(ch):
            start_index = index
            index += 1
            while True:
                if index >= expression_len:
                    break
                current = expression[index]
                if is_identifier_part_char(current):
                    index += 1
                    continue
                if current == "."  or  current == ":":
                    index += 1
                    continue
                break
            candidate = substring(expression, start_index, index)
            if len(candidate) > 0:
                cursor = index
                while True:
                    if cursor >= expression_len:
                        break
                    next = expression[cursor]
                    if is_trim_char(next):
                        cursor += 1
                        continue
                    if next == "(":
                        results = append_unique_effect(results, candidate)
                    break
            continue
        index += 1
    return results

def collect_runtime_helper_targets(functions):
    used = []
    index = 0
    while True:
        if index >= len(functions):
            break
        helpers = collect_function_runtime_helper_targets(functions[index])
        used = merge_effect_lists(used, helpers)
        index += 1
    return used

def collect_function_runtime_helper_targets(function):
    used = []
    decorator_index = 0
    while True:
        if decorator_index >= len(function.decorators):
            break
        decorator_name = function.decorators[decorator_index]
        if matches_case_insensitive(decorator_name, "logExecution")  or  matches_case_insensitive(decorator_name, "logexecution")  or  matches_case_insensitive(decorator_name, "trace"):
            used = append_unique_effect(used, "runtime_log_execution_fn")
        decorator_index += 1
    index = 0
    while True:
        if index >= len(function.instructions):
            break
        instruction = function.instructions[index]
        instruction_helpers = collect_instruction_runtime_helper_targets(instruction)
        used = merge_effect_lists(used, instruction_helpers)
        index += 1
    return used

def collect_instruction_runtime_helper_targets(instruction):
    if instruction.variant == "Let":
        if instruction.value != None:
            helpers = filter_runtime_helper_targets(extract_all_call_targets(instruction.value))
            helpers = merge_effect_lists(helpers, collect_runtime_property_targets(instruction.value))
            return helpers
        return []
    if instruction.variant == "Expression":
        helpers = filter_runtime_helper_targets(extract_all_call_targets(instruction.expression))
        helpers = merge_effect_lists(helpers, collect_runtime_property_targets(instruction.expression))
        return helpers
    if instruction.variant == "Return":
        trimmed = trim_text(instruction.expression)
        if len(trimmed) > 0:
            helpers = filter_runtime_helper_targets(extract_all_call_targets(trimmed))
            helpers = merge_effect_lists(helpers, collect_runtime_property_targets(trimmed))
            return helpers
        return []
    if instruction.variant == "If":
        helpers = filter_runtime_helper_targets(extract_all_call_targets(instruction.condition))
        helpers = merge_effect_lists(helpers, collect_runtime_property_targets(instruction.condition))
        return helpers
    if instruction.variant == "For":
        helpers = filter_runtime_helper_targets(extract_all_call_targets(instruction.iterable))
        helpers = merge_effect_lists(helpers, collect_runtime_property_targets(instruction.iterable))
        return helpers
    if instruction.variant == "Match":
        helpers = filter_runtime_helper_targets(extract_all_call_targets(instruction.expression))
        helpers = merge_effect_lists(helpers, collect_runtime_property_targets(instruction.expression))
        return helpers
    if instruction.variant == "Case":
        helpers = filter_runtime_helper_targets(extract_all_call_targets(instruction.pattern))
        helpers = merge_effect_lists(helpers, collect_runtime_property_targets(instruction.pattern))
        if instruction.guard != None:
            guard_targets = filter_runtime_helper_targets(extract_all_call_targets(instruction.guard))
            combined = merge_effect_lists(helpers, guard_targets)
            combined = merge_effect_lists(combined, collect_runtime_property_targets(instruction.guard))
            return combined
        return helpers
    if instruction.variant == "Try":
        return ["clear_exception", "has_exception", "take_exception"]
    if instruction.variant == "Throw":
        return ["set_exception"]
    return []

def filter_runtime_helper_targets(targets):
    results = []
    index = 0
    while True:
        if index >= len(targets):
            break
        trimmed = trim_text(targets[index])
        helper = find_runtime_helper(trimmed)
        if helper == None:
            dot_index = find_last_index_of_char(trimmed, ".")
            if dot_index >= 0  and  dot_index + 1 < len(trimmed):
                suffix = substring(trimmed, dot_index + 1, len(trimmed))
                helper = find_runtime_helper(suffix)
        if helper == None:
            colon_index = find_last_index_of_char(trimmed, ":")
            if colon_index >= 0  and  colon_index + 1 < len(trimmed):
                suffix = substring(trimmed, colon_index + 1, len(trimmed))
                helper = find_runtime_helper(suffix)
        if helper == None:
            length_suffix = ".length"
            if len(trimmed) >= len(length_suffix):
                maybe_length = substring(trimmed, len(trimmed) - len(length_suffix), len(trimmed))
                if maybe_length == length_suffix:
                    helper = find_runtime_helper("len(string)")
                    if helper == None:
                        helper = find_runtime_helper("len(string)")
            if helper == None:
                concat_suffix = ".concat"
                if len(trimmed) >= len(concat_suffix):
                    maybe_concat = substring(trimmed, len(trimmed) - len(concat_suffix), len(trimmed))
                    if maybe_concat == concat_suffix:
                        helper = find_runtime_helper("concat")
        if helper != None:
            results = append_unique_effect(results, helper.target)
        index += 1
    return results

def collect_runtime_property_targets(expression):
    trimmed = trim_text(expression)
    if len(trimmed) == 0:
        return []
    results = []
    if contains_dot_property(trimmed, "length"):
        results = append_unique_effect(results, "len(string)")
    return results

def contains_dot_property(expression, name):
    suffix = "." + name
    suffix_length = len(suffix)
    if suffix_length == 0  or  len(expression) < suffix_length:
        return False
    index = 0
    in_single = False
    in_double = False
    escape_next = False
    while True:
        if index >= len(expression):
            break
        ch = expression[index]
        if in_double:
            if escape_next:
                escape_next = False
            else:
                if ch == "\\":
                    escape_next = True
                else:
                    if ch == "\"":
                        in_double = False
            index += 1
            continue
        if in_single:
            if escape_next:
                escape_next = False
            else:
                if ch == "\\":
                    escape_next = True
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
        if index + suffix_length <= len(expression):
            match_index = 0
            matches = True
            while True:
                if match_index >= suffix_length:
                    break
                expr_char = char_at(expression, index + match_index)
                suffix_char = char_at(suffix, match_index)
                if len(expr_char) == 0  or  len(suffix_char) == 0  or  expr_char != suffix_char:
                    matches = False
                    break
                match_index += 1
            if matches:
                after_index = index + suffix_length
                after_char = char_at(expression, after_index)
                if len(after_char) == 0:
                    return True
                if not is_identifier_part_char(after_char):
                    return True
        index += 1
    return False

def propagate_function_effects(direct_effects, call_graph):
    aggregated = []
    index = 0
    while True:
        if index >= len(direct_effects):
            break
        aggregated = (aggregated) + ([FunctionEffectEntry(name=direct_effects[index].name, effects=copy_string_array(direct_effects[index].effects))])
        index += 1
    changed = True
    while True:
        if not changed:
            break
        changed = False
        call_index = 0
        while True:
            if call_index >= len(call_graph):
                break
            call_entry = call_graph[call_index]
            target_index = find_function_effect_entry_index(aggregated, call_entry.name)
            if target_index >= 0:
                target_entry = aggregated[target_index]
                merged = copy_string_array(target_entry.effects)
                callee_index = 0
                while True:
                    if callee_index >= len(call_entry.callees):
                        break
                    callee_name = call_entry.callees[callee_index]
                    callee_pos = find_function_effect_entry_index(aggregated, callee_name)
                    if callee_pos >= 0:
                        callee_entry = aggregated[callee_pos]
                        effect_index = 0
                        while True:
                            if effect_index >= len(callee_entry.effects):
                                break
                            merged = append_unique_effect(merged, callee_entry.effects[effect_index])
                            effect_index += 1
                    callee_index += 1
                if not string_arrays_equal(merged, target_entry.effects):
                    updated_entry = FunctionEffectEntry(name=target_entry.name, effects=merged)
                    aggregated = replace_function_effect_entry(aggregated, target_index, updated_entry)
                    changed = True
            call_index += 1
    return aggregated

def find_function_effect_entry_index(entries, name):
    index = 0
    while True:
        if index >= len(entries):
            break
        if entries[index].name == name:
            return index
        index += 1
    return -1

def find_function_effect_entry(entries, name):
    index = find_function_effect_entry_index(entries, name)
    if index >= 0:
        return entries[index]
    return None

def replace_function_effect_entry(entries, position, entry):
    result = []
    index = 0
    while True:
        if index >= len(entries):
            break
        if index == position:
            result = (result) + ([entry])
        else:
            result = (result) + ([entries[index]])
        index += 1
    return result

def build_capability_manifest(entry_points, function_effects):
    entries = []
    index = 0
    while True:
        if index >= len(entry_points):
            break
        symbol = entry_points[index]
        effect_entry = find_function_effect_entry(function_effects, symbol)
        effects = []
        if effect_entry != None:
            effects = effect_entry.effects
        entries = append_manifest_entry(entries, CapabilityManifestEntry(symbol=symbol, effects=effects))
        index += 1
    return CapabilityManifest(entries=entries)

def append_manifest_entry(entries, entry):
    return (entries) + ([entry])
