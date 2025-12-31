import asyncio
from runtime import runtime_support as runtime

from compiler.build.string_utils import substring
from compiler.build.llvm.types import LocalBinding, LocalMutation, PhiMergeResult, PhiStoreEntry, MutationMaterializationResult, MatchArmMutations
from compiler.build.llvm.utils import append_string
from compiler.build.llvm.expressions import find_local_binding, format_temp_name

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

def find_preloaded_value(locals, preloaded_values, name):
    local_index = 0
    while True:
        if local_index >= len(locals):
            break
        check_local = locals[local_index]
        if check_local.name == name  and  local_index < len(preloaded_values):
            return preloaded_values[local_index]
        local_index += 1
    return None

def collect_mutation_names(mutations):
    names = []
    index = 0
    while True:
        if index >= len(mutations):
            break
        mutation = mutations[index]
        already_added = False
        check_index = 0
        while True:
            if check_index >= len(names):
                break
            if names[check_index] == mutation.name:
                already_added = True
                break
            check_index += 1
        if not already_added:
            names = append_string(names, mutation.name)
        index += 1
    return names

def find_mutation_for_name(mutations, name):
    index = 0
    while True:
        if index >= len(mutations):
            break
        if mutations[index].name == name:
            return mutations[index]
        index += 1
    return None

def join_strings(strings, separator):
    result = ""
    index = 0
    while True:
        if index >= len(strings):
            break
        if index > 0:
            result = result + separator
        result = result + strings[index]
        index += 1
    return result

def build_phi_and_store(local, llvm_type, phi_inputs, temp_index):
    phi_temp = format_temp_name(temp_index)
    phi_input_str = join_strings(phi_inputs, ", ")
    phi_line = "  " + phi_temp + " = phi " + llvm_type + " " + phi_input_str
    store_line = "  store " + llvm_type + " " + phi_temp + ", " + llvm_type + "* " + local.pointer
    return PhiStoreEntry(phi_line=phi_line, store_line=store_line)

def find_last_label(lines, fallback):
    index = len(lines)
    while True:
        if index <= 0:
            break
        index -= 1
        line = lines[index]
        if len(line) == 0:
            continue
        if line[len(line) - 1] == ":":
            return substring(line, 0, len(line) - 1)
    return fallback

def retarget_recent_mutations(mutations, start_index, target_label):
    if len(target_label) == 0:
        return mutations
    index = 0
    result = []
    while True:
        if index >= len(mutations):
            break
        mutation = mutations[index]
        if index >= start_index:
            updated = LocalMutation(name=mutation.name, llvm_type=mutation.llvm_type, value_name=mutation.value_name, span=mutation.span, originating_label=target_label)
            result = (result) + ([updated])
        else:
            result = (result) + ([mutation])
        index += 1
    return result

def materialize_mutation_values_at_exit(mutations, locals, lines, temp_index):
    updated_lines = lines
    current_temp = temp_index
    updated_mutations = []
    index = 0
    while True:
        if index >= len(mutations):
            break
        mutation = mutations[index]
        local = find_local_binding(locals, mutation.name)
        if local != None:
            load_temp = format_temp_name(current_temp)
            current_temp += 1
            load_line = "  " + load_temp + " = load " + local.llvm_type + ", " + local.llvm_type + "* " + local.pointer
            updated_lines = append_string(updated_lines, load_line)
            updated = LocalMutation(name=mutation.name, llvm_type=mutation.llvm_type, value_name=load_temp, span=mutation.span, originating_label=mutation.originating_label)
            updated_mutations = (updated_mutations) + ([updated])
        else:
            updated_mutations = (updated_mutations) + ([mutation])
        index += 1
    return MutationMaterializationResult(mutations=updated_mutations, lines=updated_lines, temp_index=current_temp)

def emit_phi_merges_for_straight_if(mutations, locals, preloaded_values, base_label, then_label, lines, temp_index):
    phi_lines = []
    store_lines = []
    current_temp = temp_index
    index = 0
    while True:
        if index >= len(mutations):
            break
        mutation = mutations[index]
        local = find_local_binding(locals, mutation.name)
        if local != None:
            preloaded_value = find_preloaded_value(locals, preloaded_values, mutation.name)
            if preloaded_value != None  and  len(preloaded_value) > 0:
                then_source_label = mutation.originating_label
                if len(then_source_label) == 0:
                    then_source_label = then_label
                phi_inputs = ["[ " + mutation.value_name + ", %" + then_source_label + " ]", "[ " + preloaded_value + ", %" + base_label + " ]"]
                entry = build_phi_and_store(local, mutation.llvm_type, phi_inputs, current_temp)
                phi_lines = append_string(phi_lines, entry.phi_line)
                store_lines = append_string(store_lines, entry.store_line)
                current_temp += 1
        index += 1
    lines_with_phi = (lines) + (phi_lines)
    combined_lines = (lines_with_phi) + (store_lines)
    return PhiMergeResult(lines=combined_lines, temp_index=current_temp)

def emit_phi_merges_for_if_else(then_mutations, else_mutations, locals, preloaded_values, then_label, else_label, then_exit_label, else_exit_label, then_terminated, else_terminated, lines, temp_index):
    phi_lines = []
    store_lines = []
    current_temp = temp_index
    then_names = collect_mutation_names(then_mutations)
    else_names = collect_mutation_names(else_mutations)
    mutated_names = then_names
    else_idx = 0
    while True:
        if else_idx >= len(else_names):
            break
        else_name = else_names[else_idx]
        already_added = False
        check_idx = 0
        while True:
            if check_idx >= len(mutated_names):
                break
            if mutated_names[check_idx] == else_name:
                already_added = True
                break
            check_idx += 1
        if not already_added:
            mutated_names = append_string(mutated_names, else_name)
        else_idx += 1
    name_idx = 0
    while True:
        if name_idx >= len(mutated_names):
            break
        name = mutated_names[name_idx]
        local = find_local_binding(locals, name)
        if local != None:
            then_mutation = find_mutation_for_name(then_mutations, name)
            else_mutation = find_mutation_for_name(else_mutations, name)
            preloaded_value = find_preloaded_value(locals, preloaded_values, name)
            llvm_type = local.llvm_type
            if then_mutation != None:
                llvm_type = then_mutation.llvm_type
            if else_mutation != None  and  len(else_mutation.llvm_type) > 0:
                llvm_type = else_mutation.llvm_type
            phi_inputs = []
            if not then_terminated:
                if then_mutation != None:
                    then_source_label = then_mutation.originating_label
                    if len(then_source_label) == 0:
                        if len(then_exit_label) > 0:
                            then_source_label = then_exit_label
                        else:
                            then_source_label = then_label
                    phi_inputs = append_string(phi_inputs, "[ " + then_mutation.value_name + ", %" + then_source_label + " ]")
                else:
                    if preloaded_value != None:
                        fallback_label = then_exit_label
                        if len(fallback_label) == 0:
                            fallback_label = then_label
                        phi_inputs = append_string(phi_inputs, "[ " + preloaded_value + ", %" + fallback_label + " ]")
            if not else_terminated:
                if else_mutation != None:
                    else_source_label = else_mutation.originating_label
                    if len(else_source_label) == 0:
                        if len(else_exit_label) > 0:
                            else_source_label = else_exit_label
                        else:
                            else_source_label = else_label
                    phi_inputs = append_string(phi_inputs, "[ " + else_mutation.value_name + ", %" + else_source_label + " ]")
                else:
                    if preloaded_value != None:
                        fallback_label = else_exit_label
                        if len(fallback_label) == 0:
                            fallback_label = else_label
                        phi_inputs = append_string(phi_inputs, "[ " + preloaded_value + ", %" + fallback_label + " ]")
            if len(phi_inputs) >= 2:
                entry = build_phi_and_store(local, llvm_type, phi_inputs, current_temp)
                phi_lines = append_string(phi_lines, entry.phi_line)
                store_lines = append_string(store_lines, entry.store_line)
                current_temp += 1
        name_idx += 1
    lines_with_phi = (lines) + (phi_lines)
    combined_lines = (lines_with_phi) + (store_lines)
    return PhiMergeResult(lines=combined_lines, temp_index=current_temp)

def emit_phi_merges_for_match(arm_mutations_list, locals, preloaded_values, lines, temp_index):
    phi_lines = []
    store_lines = []
    current_temp = temp_index
    mutated_names = []
    arm_idx = 0
    while True:
        if arm_idx >= len(arm_mutations_list):
            break
        arm = arm_mutations_list[arm_idx]
        arm_names = collect_mutation_names(arm.mutations)
        name_idx = 0
        while True:
            if name_idx >= len(arm_names):
                break
            arm_name = arm_names[name_idx]
            already_added = False
            check_idx = 0
            while True:
                if check_idx >= len(mutated_names):
                    break
                if mutated_names[check_idx] == arm_name:
                    already_added = True
                    break
                check_idx += 1
            if not already_added:
                mutated_names = append_string(mutated_names, arm_name)
            name_idx += 1
        arm_idx += 1
    name_idx = 0
    while True:
        if name_idx >= len(mutated_names):
            break
        name = mutated_names[name_idx]
        local = find_local_binding(locals, name)
        if local != None:
            preloaded_value = find_preloaded_value(locals, preloaded_values, name)
            llvm_type = local.llvm_type
            phi_inputs = []
            arm_scan_idx = 0
            while True:
                if arm_scan_idx >= len(arm_mutations_list):
                    break
                arm = arm_mutations_list[arm_scan_idx]
                if not arm.terminated:
                    arm_mutation = find_mutation_for_name(arm.mutations, name)
                    if arm_mutation != None:
                        if len(arm_mutation.llvm_type) > 0:
                            llvm_type = arm_mutation.llvm_type
                        phi_inputs = append_string(phi_inputs, "[ " + arm_mutation.value_name + ", %" + arm.label + " ]")
                    else:
                        if preloaded_value != None:
                            phi_inputs = append_string(phi_inputs, "[ " + preloaded_value + ", %" + arm.label + " ]")
                arm_scan_idx += 1
            if len(phi_inputs) >= 2:
                entry = build_phi_and_store(local, llvm_type, phi_inputs, current_temp)
                phi_lines = append_string(phi_lines, entry.phi_line)
                store_lines = append_string(store_lines, entry.store_line)
                current_temp += 1
        name_idx += 1
    lines_with_phi = (lines) + (phi_lines)
    combined_lines = (lines_with_phi) + (store_lines)
    return PhiMergeResult(lines=combined_lines, temp_index=current_temp)
