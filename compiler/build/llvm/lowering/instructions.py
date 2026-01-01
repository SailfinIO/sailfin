import asyncio
from runtime import runtime_support as runtime

from ...native_ir import NativeFunction, NativeInstruction, NativeSourceSpan
from ...string_utils import substring
from ..types import TypeContext, LocalBinding, ParameterBinding, LLVMOperand, BlockLoweringResult, LetLoweringResult, LoopContext, LifetimeRegionMetadata, LifetimeReleaseEvent, OwnershipInfo, OwnershipConsumption, ScopeMetadata, LocalMutation, StringConstant, IfStructure, TryStructure, LoopStructure, MatchStructure, MatchCaseStructure, MatchCaseCondition, MatchFieldBinding, MatchStructFieldBinding, EnumTypeInfo, EnumVariantInfo, StructTypeInfo, StructFieldInfo, ConditionConversion, BlockLabelResult, MatchArmMutations
from ..utils import trim_text, append_string, number_to_string, index_of, starts_with, strip_mut_prefix, is_simple_identifier, merge_parameter_bindings
from ..strings import empty_string_constant_set, merge_string_constants
from ..type_context import find_struct_info_by_name, find_interface_info_by_name, find_enum_info_by_llvm_type, resolve_enum_info_for_literal, resolve_enum_variant_info
from ..expression_lowering_stage2 import append_local_binding, coerce_operand_to_type, detect_suspension_conflicts, emit_boolean_and, emit_comparison_instruction, extract_simple_identifier, harmonise_operands, is_union_llvm_type, load_local_operand, lower_expression, lower_expression_statement, lower_return_instruction, map_local_type, parse_enum_literal, parse_inline_let_expression, parse_range_iterable, parse_struct_pattern, parse_union_payload_types, analyze_value_ownership, detect_borrow_conflicts
from ..expression_lowering.arrays import array_pointer_element_type
from ..type_mapping import array_struct_type_for_element
from ..expressions import find_local_binding, find_parameter_binding, mark_local_consumed, mark_parameter_consumed, default_return_literal, format_local_pointer_name, format_temp_name
from ..lifetime import infer_borrow_base_scope, append_lifetime_region, append_lifetime_release_event, mark_lifetime_region_released, apply_lifetime_release_events, make_lifetime_region_metadata, format_root_scope_id, make_child_scope_id
from compiler.build.llvm.lowering.phi import emit_phi_merges_for_match, emit_phi_merges_for_straight_if, emit_phi_merges_for_if_else, find_last_label, retarget_recent_mutations, materialize_mutation_values_at_exit, collect_mutation_names, find_mutation_for_name

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

def lower_instruction_range(function, start_index, end, llvm_return, bindings, locals, allocas, lines, temp_index, block_counter, next_local_id, next_region_id, functions, loop_stack, context, scope_id, scope_depth, current_label):
    diagnostics = []
    current_lines = lines
    current_allocas = allocas
    current_locals = locals
    current_bindings = bindings
    current_temp = temp_index
    current_block_counter = block_counter
    current_next_local = next_local_id
    current_next_region = next_region_id
    terminated = False
    current_loop_stack = loop_stack
    index = start_index
    collected_lifetime_regions = []
    current_mutations = []
    collected_string_constants = empty_string_constant_set()
    active_label = current_label
    while True:
        if index >= end:
            break
        instruction = function.instructions[index]
        if instruction.variant == "Let":
            lowered = lower_let_instruction(function, instruction, current_bindings, current_locals, current_allocas, current_lines, current_temp, current_next_local, current_next_region, functions, context, scope_id, scope_depth, active_label)
            diagnostics = (diagnostics) + (lowered.diagnostics)
            collected_lifetime_regions = (collected_lifetime_regions) + (lowered.lifetime_regions)
            collected_lifetime_regions = apply_lifetime_release_events(collected_lifetime_regions, lowered.lifetime_releases)
            current_lines = lowered.lines
            current_allocas = lowered.allocas
            current_locals = lowered.locals
            current_bindings = lowered.bindings
            current_temp = lowered.temp_index
            current_next_local = lowered.next_local_id
            current_next_region = lowered.next_region_id
            current_mutations = (current_mutations) + (lowered.mutations)
            temp_constants = collected_string_constants
            collected_string_constants = merge_string_constants(temp_constants, lowered.string_constants)
            active_label = find_last_label(current_lines, active_label)
        else:
            if instruction.variant == "Expression":
                trimmed_expression = trim_text(instruction.expression)
                handled_inline_let = False
                if len(trimmed_expression) >= 4:
                    prefix = substring(trimmed_expression, 0, 4)
                    if prefix == "let ":
                        inline_parse = parse_inline_let_expression(trimmed_expression)
                        diagnostics = (diagnostics) + (inline_parse.diagnostics)
                        if inline_parse.success:
                            inline_instruction = runtime.enum_instantiate(NativeInstruction, 'Let', [runtime.enum_field('name', inline_parse.name), runtime.enum_field('mutable', inline_parse.mutable), runtime.enum_field('type_annotation', inline_parse.type_annotation), runtime.enum_field('value', inline_parse.initializer), runtime.enum_field('span', instruction.span), runtime.enum_field('value_span', instruction.span)])
                            lowered = lower_let_instruction(function, inline_instruction, current_bindings, current_locals, current_allocas, current_lines, current_temp, current_next_local, current_next_region, functions, context, scope_id, scope_depth, active_label)
                            diagnostics = (diagnostics) + (lowered.diagnostics)
                            collected_lifetime_regions = (collected_lifetime_regions) + (lowered.lifetime_regions)
                            collected_lifetime_regions = apply_lifetime_release_events(collected_lifetime_regions, lowered.lifetime_releases)
                            current_lines = lowered.lines
                            current_allocas = lowered.allocas
                            current_locals = lowered.locals
                            current_bindings = lowered.bindings
                            current_temp = lowered.temp_index
                            current_next_local = lowered.next_local_id
                            current_next_region = lowered.next_region_id
                            current_mutations = (current_mutations) + (lowered.mutations)
                            temp_constants = collected_string_constants
                            collected_string_constants = merge_string_constants(temp_constants, lowered.string_constants)
                            handled_inline_let = True
                if not handled_inline_let:
                    lowered = lower_expression_statement(function.name, instruction, trimmed_expression, current_bindings, current_locals, current_temp, current_lines, current_next_region, scope_id, scope_depth, functions, context, active_label)
                    diagnostics = (diagnostics) + (lowered.diagnostics)
                    current_lines = lowered.lines
                    current_temp = lowered.temp_index
                    current_locals = lowered.locals
                    current_bindings = lowered.bindings
                    collected_lifetime_regions = (collected_lifetime_regions) + (lowered.lifetime_regions)
                    collected_lifetime_regions = apply_lifetime_release_events(collected_lifetime_regions, lowered.lifetime_releases)
                    current_next_region = lowered.next_region_id
                    current_mutations = (current_mutations) + (lowered.mutations)
                    temp_constants = collected_string_constants
                    collected_string_constants = merge_string_constants(temp_constants, lowered.string_constants)
                active_label = find_last_label(current_lines, active_label)
            else:
                if instruction.variant == "Return":
                    lowered = lower_return_instruction(function, instruction, llvm_return, current_bindings, current_locals, current_temp, current_lines, current_next_region, scope_id, scope_depth, functions, context)
                    diagnostics = (diagnostics) + (lowered.diagnostics)
                    current_lines = lowered.lines
                    current_temp = lowered.temp_index
                    current_locals = lowered.locals
                    current_bindings = lowered.bindings
                    collected_lifetime_regions = (collected_lifetime_regions) + (lowered.lifetime_regions)
                    collected_lifetime_regions = apply_lifetime_release_events(collected_lifetime_regions, lowered.lifetime_releases)
                    current_next_region = lowered.next_region_id
                    current_mutations = (current_mutations) + (lowered.mutations)
                    temp_constants = collected_string_constants
                    collected_string_constants = merge_string_constants(temp_constants, lowered.string_constants)
                    terminated = True
                    index += 1
                    if index < end:
                        diagnostics = append_string(diagnostics, "llvm lowering: instructions after return ignored in `" + function.name + "`")
                    break
                else:
                    if instruction.variant == "If":
                        lowered = lower_if_instruction(
function,
index,
llvm_return,
current_bindings,
current_locals,
current_allocas,
current_lines,
current_temp,
current_block_counter,
current_next_local,
current_next_region,
functions,
current_loop_stack,
end,
context,
scope_id,
scope_depth,
active_label
)
                        diagnostics = (diagnostics) + (lowered.diagnostics)
                        collected_lifetime_regions = (collected_lifetime_regions) + (lowered.lifetime_regions)
                        current_lines = lowered.lines
                        current_allocas = lowered.allocas
                        current_locals = lowered.locals
                        current_bindings = lowered.bindings
                        current_temp = lowered.temp_index
                        current_block_counter = lowered.block_counter
                        current_next_local = lowered.next_local_id
                        current_next_region = lowered.next_lifetime_region_id
                        current_mutations = (current_mutations) + (lowered.mutations)
                        temp_constants = collected_string_constants
                        collected_string_constants = merge_string_constants(temp_constants, lowered.string_constants)
                        terminated = lowered.terminated
                        index = lowered.next_index
                        active_label = find_last_label(current_lines, active_label)
                        if terminated:
                            break
                        continue
                    else:
                        if instruction.variant == "Loop":
                            lowered = lower_loop_instruction(
function,
index,
llvm_return,
current_bindings,
current_locals,
current_allocas,
current_lines,
current_temp,
current_block_counter,
current_next_local,
current_next_region,
functions,
current_loop_stack,
end,
context,
scope_id,
scope_depth,
active_label
)
                            diagnostics = (diagnostics) + (lowered.diagnostics)
                            collected_lifetime_regions = (collected_lifetime_regions) + (lowered.lifetime_regions)
                            current_lines = lowered.lines
                            current_allocas = lowered.allocas
                            current_locals = lowered.locals
                            current_bindings = lowered.bindings
                            current_temp = lowered.temp_index
                            current_block_counter = lowered.block_counter
                            current_next_local = lowered.next_local_id
                            current_next_region = lowered.next_lifetime_region_id
                            current_mutations = (current_mutations) + (lowered.mutations)
                            temp_constants = collected_string_constants
                            collected_string_constants = merge_string_constants(temp_constants, lowered.string_constants)
                            terminated = lowered.terminated
                            index = lowered.next_index
                            active_label = find_last_label(current_lines, active_label)
                            if terminated:
                                break
                            continue
                        else:
                            if instruction.variant == "Match":
                                lowered = lower_match_instruction(
function,
index,
llvm_return,
current_bindings,
current_locals,
current_allocas,
current_lines,
current_temp,
current_block_counter,
current_next_local,
current_next_region,
functions,
current_loop_stack,
end,
context,
scope_id,
scope_depth,
active_label
)
                                diagnostics = (diagnostics) + (lowered.diagnostics)
                                collected_lifetime_regions = (collected_lifetime_regions) + (lowered.lifetime_regions)
                                current_lines = lowered.lines
                                current_allocas = lowered.allocas
                                current_locals = lowered.locals
                                current_bindings = lowered.bindings
                                current_temp = lowered.temp_index
                                current_block_counter = lowered.block_counter
                                current_next_local = lowered.next_local_id
                                current_next_region = lowered.next_lifetime_region_id
                                current_mutations = (current_mutations) + (lowered.mutations)
                                temp_constants = collected_string_constants
                                collected_string_constants = merge_string_constants(temp_constants, lowered.string_constants)
                                terminated = lowered.terminated
                                index = lowered.next_index
                                active_label = find_last_label(current_lines, active_label)
                                if terminated:
                                    break
                                continue
                            else:
                                if instruction.variant == "Try":
                                    lowered = lower_try_instruction(
function,
index,
llvm_return,
current_bindings,
current_locals,
current_allocas,
current_lines,
current_temp,
current_block_counter,
current_next_local,
current_next_region,
functions,
current_loop_stack,
end,
context,
scope_id,
scope_depth,
active_label
)
                                    diagnostics = (diagnostics) + (lowered.diagnostics)
                                    collected_lifetime_regions = (collected_lifetime_regions) + (lowered.lifetime_regions)
                                    current_lines = lowered.lines
                                    current_allocas = lowered.allocas
                                    current_locals = lowered.locals
                                    current_bindings = lowered.bindings
                                    current_temp = lowered.temp_index
                                    current_block_counter = lowered.block_counter
                                    current_next_local = lowered.next_local_id
                                    current_next_region = lowered.next_lifetime_region_id
                                    current_mutations = (current_mutations) + (lowered.mutations)
                                    temp_constants = collected_string_constants
                                    collected_string_constants = merge_string_constants(temp_constants, lowered.string_constants)
                                    terminated = lowered.terminated
                                    index = lowered.next_index
                                    active_label = find_last_label(current_lines, active_label)
                                    if terminated:
                                        break
                                    continue
                                else:
                                    if instruction.variant == "Throw":
                                        lowered = lower_throw_instruction(
function.name,
instruction,
llvm_return,
current_bindings,
current_locals,
current_temp,
current_lines,
functions,
context
)
                                        diagnostics = (diagnostics) + (lowered.diagnostics)
                                        current_lines = lowered.lines
                                        current_temp = lowered.temp_index
                                        temp_constants = collected_string_constants
                                        collected_string_constants = merge_string_constants(temp_constants, lowered.string_constants)
                                        terminated = True
                                        index += 1
                                        if index < end:
                                            diagnostics = append_string(diagnostics, "llvm lowering: instructions after throw ignored in `" + function.name + "`")
                                        break
                                    else:
                                        if instruction.variant == "Else"  or  instruction.variant == "EndIf":
                                            break
                                        else:
                                            if instruction.variant == "EndLoop"  or  instruction.variant == "EndMatch"  or  instruction.variant == "EndFor":
                                                break
                                            else:
                                                if instruction.variant == "Break":
                                                    if len(current_loop_stack) == 0:
                                                        diagnostics = append_string(diagnostics, "llvm lowering: `break` outside loop in `" + function.name + "`")
                                                    else:
                                                        loop_context = last_loop_context(current_loop_stack)
                                                        current_lines = append_string(current_lines, "  br label %" + loop_context.break_label)
                                                        terminated = True
                                                    index += 1
                                                    if index < end  and  terminated:
                                                        diagnostics = append_string(diagnostics, "llvm lowering: instructions after break ignored in `" + function.name + "`")
                                                    break
                                                else:
                                                    if instruction.variant == "Continue":
                                                        if len(current_loop_stack) == 0:
                                                            diagnostics = append_string(diagnostics, "llvm lowering: `continue` outside loop in `" + function.name + "`")
                                                        else:
                                                            loop_context = last_loop_context(current_loop_stack)
                                                            current_lines = append_string(current_lines, "  br label %" + loop_context.continue_label)
                                                            terminated = True
                                                        index += 1
                                                        if index < end  and  terminated:
                                                            diagnostics = append_string(diagnostics, "llvm lowering: instructions after continue ignored in `" + function.name + "`")
                                                        break
                                                    else:
                                                        if instruction.variant == "For":
                                                            lowered = lower_for_instruction(
function,
index,
llvm_return,
current_bindings,
current_locals,
current_allocas,
current_lines,
current_temp,
current_block_counter,
current_next_local,
current_next_region,
functions,
current_loop_stack,
end,
context,
scope_id,
scope_depth,
active_label
)
                                                            diagnostics = (diagnostics) + (lowered.diagnostics)
                                                            collected_lifetime_regions = (collected_lifetime_regions) + (lowered.lifetime_regions)
                                                            current_lines = lowered.lines
                                                            current_allocas = lowered.allocas
                                                            current_locals = lowered.locals
                                                            current_bindings = lowered.bindings
                                                            current_temp = lowered.temp_index
                                                            current_block_counter = lowered.block_counter
                                                            current_next_local = lowered.next_local_id
                                                            current_next_region = lowered.next_lifetime_region_id
                                                            current_mutations = (current_mutations) + (lowered.mutations)
                                                            temp_constants = collected_string_constants
                                                            collected_string_constants = merge_string_constants(temp_constants, lowered.string_constants)
                                                            terminated = lowered.terminated
                                                            index = lowered.next_index
                                                            active_label = find_last_label(current_lines, active_label)
                                                            if terminated:
                                                                break
                                                            continue
                                                        else:
                                                            if instruction.variant == "Noop":
                                                                pass
                                                            else:
                                                                diagnostics = append_string(diagnostics, "llvm lowering: unsupported instruction `" + instruction.variant + "` in `" + function.name + "`")
        index += 1
    return BlockLoweringResult(lines=current_lines, allocas=current_allocas, locals=current_locals, bindings=current_bindings, temp_index=current_temp, block_counter=current_block_counter, diagnostics=diagnostics, terminated=terminated, next_local_id=current_next_local, lifetime_regions=collected_lifetime_regions, next_lifetime_region_id=current_next_region, next_index=index, mutations=current_mutations, string_constants=collected_string_constants)

def collect_if_structure(instructions, start_index, end, function_name):
    diagnostics = []
    then_start = start_index + 1
    then_end = end
    else_start = -1
    else_end = -1
    has_else = False
    depth = 0
    index = then_start
    limit = end
    if limit > len(instructions):
        limit = len(instructions)
    while True:
        if index >= limit:
            diagnostics = append_string(diagnostics, "llvm lowering: unterminated `.if` in `" + function_name + "`")
            return IfStructure(then_start=then_start, then_end=limit, else_start=else_start, else_end=else_end, has_else=has_else, next_index=limit - 1, diagnostics=diagnostics)
        current = instructions[index]
        if current.variant == "If":
            depth += 1
            index += 1
            continue
        if current.variant == "EndIf":
            if depth == 0:
                if not has_else:
                    then_end = index
                else:
                    else_end = index
                return IfStructure(then_start=then_start, then_end=then_end, else_start=else_start, else_end=else_end, has_else=has_else, next_index=index, diagnostics=diagnostics)
            depth -= 1
            index += 1
            continue
        if current.variant == "Else":
            if depth == 0:
                if has_else:
                    diagnostics = append_string(diagnostics, "llvm lowering: duplicate `.else` in `.if` within `" + function_name + "`")
                else:
                    has_else = True
                    then_end = index
                    else_start = index + 1
            index += 1
            continue
        index += 1
    return IfStructure(then_start=then_start, then_end=then_end, else_start=else_start, else_end=else_end, has_else=has_else, next_index=limit, diagnostics=diagnostics)

def lower_throw_instruction(function_name, instruction, llvm_return, bindings, locals, temp_index, lines, functions, context):
    diagnostics = []
    current_lines = lines
    current_temp = temp_index
    collected_string_constants = empty_string_constant_set()
    lowered_expr = lower_expression(
instruction.expression,
bindings,
locals,
current_temp,
current_lines,
functions,
context,
"i8*"
)
    diagnostics = (diagnostics) + (lowered_expr.diagnostics)
    current_lines = lowered_expr.lines
    current_temp = lowered_expr.temp_index
    collected_string_constants = merge_string_constants(collected_string_constants, lowered_expr.string_constants)
    if lowered_expr.operand == None:
        diagnostics = append_string(diagnostics, "llvm lowering: unsupported throw expression in `" + function_name + "`")
        current_lines = append_string(current_lines, "  unreachable")
        return ThrowLoweringResult(lines=current_lines, temp_index=current_temp, diagnostics=diagnostics, terminated=True, string_constants=collected_string_constants)
    coerced = coerce_operand_to_type(lowered_expr.operand, "i8*", current_temp, current_lines)
    diagnostics = (diagnostics) + (coerced.diagnostics)
    current_lines = coerced.lines
    current_temp = coerced.temp_index
    if coerced.operand == None:
        diagnostics = append_string(diagnostics, "llvm lowering: unable to coerce throw value to string in `" + function_name + "`")
        current_lines = append_string(current_lines, "  unreachable")
        return ThrowLoweringResult(lines=current_lines, temp_index=current_temp, diagnostics=diagnostics, terminated=True, string_constants=collected_string_constants)
    current_lines = append_string(current_lines, "  call void @sailfin_runtime_set_exception(i8* " + coerced.operand.value + ")")
    if llvm_return == "void":
        current_lines = append_string(current_lines, "  ret void")
    else:
        current_lines = append_string(current_lines, "  ret " + llvm_return + " " + default_return_literal(llvm_return))
    return ThrowLoweringResult(lines=current_lines, temp_index=current_temp, diagnostics=diagnostics, terminated=True, string_constants=collected_string_constants)

def collect_try_structure(instructions, start_index, end, function_name):
    diagnostics = []
    depth = 1
    index = start_index + 1
    catch_index = -1
    catch_name = ""
    finally_index = -1
    end_index = -1
    while True:
        if index >= end:
            break
        instruction = instructions[index]
        if instruction.variant == "Try":
            depth += 1
        else:
            if instruction.variant == "EndTry":
                depth -= 1
                if depth == 0:
                    end_index = index
                    break
            else:
                if instruction.variant == "Catch":
                    if depth == 1  and  catch_index == -1:
                        catch_index = index
                        catch_name = instruction.name
                else:
                    if instruction.variant == "Finally":
                        if depth == 1  and  finally_index == -1:
                            finally_index = index
        index += 1
    if end_index == -1:
        diagnostics = append_string(diagnostics, "llvm lowering: try without endtry in `" + function_name + "`")
        end_index = end - 1
    try_start = start_index + 1
    try_end = end_index
    if catch_index != -1:
        try_end = catch_index
    else:
        if finally_index != -1:
            try_end = finally_index
    catch_start = -1
    catch_end = -1
    if catch_index != -1:
        catch_start = catch_index + 1
        catch_end = end_index
        if finally_index != -1:
            catch_end = finally_index
    finally_start = -1
    finally_end = -1
    if finally_index != -1:
        finally_start = finally_index + 1
        finally_end = end_index
    return TryStructure(try_start=try_start, try_end=try_end, catch_index=catch_index, catch_name=catch_name, catch_start=catch_start, catch_end=catch_end, finally_index=finally_index, finally_start=finally_start, finally_end=finally_end, end_index=end_index, next_index=end_index + 1, diagnostics=diagnostics)

def lower_try_instruction(function, start_index, llvm_return, bindings, locals, allocas, lines, temp_index, block_counter, next_local_id, next_region_id, functions, loop_stack, end, context, scope_id, scope_depth, current_label):
    diagnostics = []
    structure = collect_try_structure(function.instructions, start_index, end, function.name)
    diagnostics = (diagnostics) + (structure.diagnostics)
    current_lines = lines
    current_allocas = allocas
    current_locals = locals
    current_bindings = bindings
    current_temp = temp_index
    current_block_counter = block_counter
    current_next_local = next_local_id
    current_next_region = next_region_id
    lifetime_regions = []
    collected_string_constants = empty_string_constant_set()
    current_lines = append_string(current_lines, "  call void @sailfin_runtime_clear_exception()")
    try_label_alloc = allocate_block_label("try", current_block_counter)
    try_label = try_label_alloc.label
    current_block_counter = try_label_alloc.next_counter
    catch_label = ""
    if structure.catch_index != -1:
        catch_label_alloc = allocate_block_label("catch", current_block_counter)
        catch_label = catch_label_alloc.label
        current_block_counter = catch_label_alloc.next_counter
    finally_label = ""
    if structure.finally_index != -1:
        finally_label_alloc = allocate_block_label("finally", current_block_counter)
        finally_label = finally_label_alloc.label
        current_block_counter = finally_label_alloc.next_counter
    merge_label_alloc = allocate_block_label("merge", current_block_counter)
    merge_label = merge_label_alloc.label
    current_block_counter = merge_label_alloc.next_counter
    current_lines = append_string(current_lines, "  br label %" + try_label)
    current_lines = append_string(current_lines, try_label + ":")
    try_scope_id = make_child_scope_id(scope_id, try_label)
    try_result = lower_instruction_range(
function,
structure.try_start,
structure.try_end,
llvm_return,
current_bindings,
current_locals,
current_allocas,
[],
current_temp,
current_block_counter,
current_next_local,
current_next_region,
functions,
loop_stack,
context,
try_scope_id,
scope_depth + 1,
try_label
)
    diagnostics = (diagnostics) + (try_result.diagnostics)
    lifetime_regions = (lifetime_regions) + (try_result.lifetime_regions)
    current_allocas = try_result.allocas
    current_temp = try_result.temp_index
    current_block_counter = try_result.block_counter
    current_next_local = try_result.next_local_id
    current_next_region = try_result.next_lifetime_region_id
    current_lines = (current_lines) + (try_result.lines)
    collected_string_constants = merge_string_constants(collected_string_constants, try_result.string_constants)
    if not try_result.terminated:
        has_exc = format_temp_name(current_temp)
        current_temp += 1
        current_lines = append_string(current_lines, "  " + has_exc + " = call i1 @sailfin_runtime_has_exception()")
        normal_target = merge_label
        if structure.finally_index != -1:
            normal_target = finally_label
        if structure.catch_index != -1:
            current_lines = append_string(current_lines, "  br i1 " + has_exc + ", label %" + catch_label + ", label %" + normal_target)
        else:
            current_lines = append_string(current_lines, "  br label %" + normal_target)
    if structure.catch_index != -1:
        current_lines = append_string(current_lines, catch_label + ":")
        catch_scope_id = make_child_scope_id(scope_id, catch_label)
        exception_temp = format_temp_name(current_temp)
        current_temp += 1
        current_lines = append_string(current_lines, "  " + exception_temp + " = call i8* @sailfin_runtime_take_exception()")
        catch_locals = current_locals
        trimmed_name = trim_text(structure.catch_name)
        if len(trimmed_name) > 0  and  trimmed_name != "_":
            err_slot = format_local_pointer_name(current_next_local)
            current_next_local += 1
            current_allocas = append_string(current_allocas, "  " + err_slot + " = alloca i8*")
            current_lines = append_string(current_lines, "  store i8* " + exception_temp + ", i8** " + err_slot)
            catch_locals = (catch_locals) + ([LocalBinding(name=trimmed_name, pointer=err_slot, llvm_type="i8*", type_annotation="string", ownership=None, consumed=False, scope_id=catch_scope_id, scope_depth=scope_depth + 1)])
        catch_result = lower_instruction_range(
function,
structure.catch_start,
structure.catch_end,
llvm_return,
current_bindings,
catch_locals,
current_allocas,
[],
current_temp,
current_block_counter,
current_next_local,
current_next_region,
functions,
loop_stack,
context,
catch_scope_id,
scope_depth + 1,
catch_label
)
        diagnostics = (diagnostics) + (catch_result.diagnostics)
        lifetime_regions = (lifetime_regions) + (catch_result.lifetime_regions)
        current_allocas = catch_result.allocas
        current_temp = catch_result.temp_index
        current_block_counter = catch_result.block_counter
        current_next_local = catch_result.next_local_id
        current_next_region = catch_result.next_lifetime_region_id
        current_lines = (current_lines) + (catch_result.lines)
        collected_string_constants = merge_string_constants(collected_string_constants, catch_result.string_constants)
        if not catch_result.terminated:
            target = merge_label
            if structure.finally_index != -1:
                target = finally_label
            current_lines = append_string(current_lines, "  br label %" + target)
    if structure.finally_index != -1:
        current_lines = append_string(current_lines, finally_label + ":")
        finally_scope_id = make_child_scope_id(scope_id, finally_label)
        finally_result = lower_instruction_range(
function,
structure.finally_start,
structure.finally_end,
llvm_return,
current_bindings,
current_locals,
current_allocas,
[],
current_temp,
current_block_counter,
current_next_local,
current_next_region,
functions,
loop_stack,
context,
finally_scope_id,
scope_depth + 1,
finally_label
)
        diagnostics = (diagnostics) + (finally_result.diagnostics)
        lifetime_regions = (lifetime_regions) + (finally_result.lifetime_regions)
        current_allocas = finally_result.allocas
        current_temp = finally_result.temp_index
        current_block_counter = finally_result.block_counter
        current_next_local = finally_result.next_local_id
        current_next_region = finally_result.next_lifetime_region_id
        current_lines = (current_lines) + (finally_result.lines)
        collected_string_constants = merge_string_constants(collected_string_constants, finally_result.string_constants)
        if not finally_result.terminated:
            current_lines = append_string(current_lines, "  br label %" + merge_label)
    current_lines = append_string(current_lines, merge_label + ":")
    has_exc_after = format_temp_name(current_temp)
    current_temp += 1
    current_lines = append_string(current_lines, "  " + has_exc_after + " = call i1 @sailfin_runtime_has_exception()")
    propagate_label_alloc = allocate_block_label("try.propagate", current_block_counter)
    propagate_label = propagate_label_alloc.label
    current_block_counter = propagate_label_alloc.next_counter
    continue_label_alloc = allocate_block_label("try.continue", current_block_counter)
    continue_label = continue_label_alloc.label
    current_block_counter = continue_label_alloc.next_counter
    current_lines = append_string(current_lines, "  br i1 " + has_exc_after + ", label %" + propagate_label + ", label %" + continue_label)
    current_lines = append_string(current_lines, propagate_label + ":")
    if llvm_return == "void":
        current_lines = append_string(current_lines, "  ret void")
    else:
        current_lines = append_string(current_lines, "  ret " + llvm_return + " " + default_return_literal(llvm_return))
    current_lines = append_string(current_lines, continue_label + ":")
    return BlockLoweringResult(lines=current_lines, allocas=current_allocas, locals=current_locals, bindings=current_bindings, temp_index=current_temp, block_counter=current_block_counter, diagnostics=diagnostics, terminated=False, next_local_id=current_next_local, lifetime_regions=lifetime_regions, next_lifetime_region_id=current_next_region, next_index=structure.next_index, mutations=[], string_constants=collected_string_constants)

def collect_loop_structure(instructions, start_index, end, function_name):
    diagnostics = []
    body_start = start_index + 1
    body_end = end
    depth = 0
    index = body_start
    limit = end
    if limit > len(instructions):
        limit = len(instructions)
    while True:
        if index >= limit:
            if limit <= 0:
                limit = 0
            diagnostics = append_string(diagnostics, "llvm lowering: unterminated `.loop` in `" + function_name + "`")
            return LoopStructure(body_start=body_start, body_end=limit, next_index=limit - 1, diagnostics=diagnostics)
        current = instructions[index]
        if current.variant == "Loop"  or  current.variant == "For":
            depth += 1
            index += 1
            continue
        if current.variant == "EndLoop"  or  current.variant == "EndFor":
            if depth == 0:
                body_end = index
                return LoopStructure(body_start=body_start, body_end=body_end, next_index=index, diagnostics=diagnostics)
            if depth > 0:
                depth -= 1
            index += 1
            continue
        index += 1
    return LoopStructure(body_start=body_start, body_end=body_end, next_index=limit, diagnostics=diagnostics)

def append_loop_context(values, value):
    return (values) + ([value])

def last_loop_context(values):
    index = len(values)
    if index <= 0:
        return LoopContext(break_label="", continue_label="")
    index -= 1
    return values[index]

def lower_loop_instruction(function, start_index, llvm_return, bindings, locals, allocas, lines, temp_index, block_counter, next_local_id, next_region_id, functions, loop_stack, end, context, scope_id, scope_depth, current_label):
    diagnostics = []
    current_lines = lines
    current_allocas = allocas
    current_locals = locals
    current_bindings = bindings
    current_temp = temp_index
    current_block_counter = block_counter
    current_next_local = next_local_id
    lifetime_regions = []
    current_next_region = next_region_id
    collected_mutations = []
    collected_string_constants = empty_string_constant_set()
    structure = collect_loop_structure(function.instructions, start_index, end, function.name)
    diagnostics = (diagnostics) + (structure.diagnostics)
    preloaded_locals = []
    preload_index = 0
    while True:
        if preload_index >= len(current_locals):
            break
        local = current_locals[preload_index]
        preload_temp = format_temp_name(current_temp)
        current_temp += 1
        preload_line = "  " + preload_temp + " = load " + local.llvm_type + ", " + local.llvm_type + "* " + local.pointer
        current_lines = append_string(current_lines, preload_line)
        preloaded_locals = append_string(preloaded_locals, preload_temp)
        preload_index += 1
    header_alloc = allocate_block_label("loop.header", current_block_counter)
    header_label = header_alloc.label
    current_block_counter = header_alloc.next_counter
    body_alloc = allocate_block_label("loop.body", current_block_counter)
    body_label = body_alloc.label
    current_block_counter = body_alloc.next_counter
    latch_alloc = allocate_block_label("loop.latch", current_block_counter)
    latch_label = latch_alloc.label
    current_block_counter = latch_alloc.next_counter
    exit_alloc = allocate_block_label("afterloop", current_block_counter)
    exit_label = exit_alloc.label
    current_block_counter = exit_alloc.next_counter
    current_lines = append_string(current_lines, "  br label %" + header_label)
    current_lines = append_string(current_lines, header_label + ":")
    loop_context = LoopContext(break_label=exit_label, continue_label=latch_label)
    stacked = append_loop_context(loop_stack, loop_context)
    base_locals = current_locals
    base_allocas = current_allocas
    base_local_id = current_next_local
    body_scope_id = make_child_scope_id(scope_id, body_label)
    body_result = lower_instruction_range(
function,
structure.body_start,
structure.body_end,
llvm_return,
current_bindings,
base_locals,
base_allocas,
[],
current_temp,
current_block_counter,
base_local_id,
current_next_region,
functions,
stacked,
context,
body_scope_id,
scope_depth + 1,
body_label
)
    diagnostics = (diagnostics) + (body_result.diagnostics)
    lifetime_regions = (lifetime_regions) + (body_result.lifetime_regions)
    current_allocas = body_result.allocas
    current_temp = body_result.temp_index
    current_block_counter = body_result.block_counter
    current_next_local = body_result.next_local_id
    current_bindings = body_result.bindings
    current_next_region = body_result.next_lifetime_region_id
    collected_mutations = (collected_mutations) + (body_result.mutations)
    collected_string_constants = merge_string_constants(collected_string_constants, body_result.string_constants)
    header_phis = []
    phi_stores = []
    mutated_names = []
    mut_idx = 0
    while True:
        if mut_idx >= len(body_result.mutations):
            break
        mutation = body_result.mutations[mut_idx]
        already_added = False
        check_idx = 0
        while True:
            if check_idx >= len(mutated_names):
                break
            if mutated_names[check_idx] == mutation.name:
                already_added = True
                break
            check_idx += 1
        if not already_added:
            mutated_names = append_string(mutated_names, mutation.name)
        mut_idx += 1
    current_lines = append_string(current_lines, "  br label %" + body_label)
    current_lines = append_string(current_lines, body_label + ":")
    current_lines = (current_lines) + (body_result.lines)
    if not body_result.terminated:
        current_lines = append_string(current_lines, "  br label %" + latch_label)
    current_lines = append_string(current_lines, latch_label + ":")
    latch_loads = []
    load_idx = 0
    while True:
        if load_idx >= len(mutated_names):
            break
        name = mutated_names[load_idx]
        local = find_local_binding(base_locals, name)
        if local != None:
            load_temp = format_temp_name(current_temp)
            current_temp += 1
            load_line = "  " + load_temp + " = load " + local.llvm_type + ", " + local.llvm_type + "* " + local.pointer
            current_lines = append_string(current_lines, load_line)
            latch_loads = append_string(latch_loads, load_temp)
        else:
            latch_loads = append_string(latch_loads, "")
        load_idx += 1
    current_lines = append_string(current_lines, "  br label %" + header_label)
    name_idx = 0
    while True:
        if name_idx >= len(mutated_names):
            break
        name = mutated_names[name_idx]
        local = find_local_binding(base_locals, name)
        if local != None  and  name_idx < len(latch_loads):
            latch_value = latch_loads[name_idx]
            if len(latch_value) > 0:
                preload_value = ""
                local_idx = 0
                while True:
                    if local_idx >= len(base_locals):
                        break
                    if base_locals[local_idx].name == name  and  local_idx < len(preloaded_locals):
                        preload_value = preloaded_locals[local_idx]
                        break
                    local_idx += 1
                if len(preload_value) > 0:
                    phi_temp = format_temp_name(current_temp)
                    current_temp += 1
                    phi_line = "  " + phi_temp + " = phi " + local.llvm_type + " [ " + preload_value + ", %" + current_label + " ], [ " + latch_value + ", %" + latch_label + " ]"
                    header_phis = append_string(header_phis, phi_line)
                    store_line = "  store " + local.llvm_type + " " + phi_temp + ", " + local.llvm_type + "* " + local.pointer
                    phi_stores = append_string(phi_stores, store_line)
        name_idx += 1
    final_lines = []
    line_idx = 0
    found_header = False
    while True:
        if line_idx >= len(current_lines):
            break
        line = current_lines[line_idx]
        final_lines = append_string(final_lines, line)
        if not found_header  and  line == header_label + ":":
            found_header = True
            final_lines = (final_lines) + (header_phis)
            final_lines = (final_lines) + (phi_stores)
        line_idx += 1
    current_lines = final_lines
    current_lines = append_string(current_lines, exit_label + ":")
    current_locals = base_locals
    exit_loads = []
    exit_load_idx = 0
    while True:
        if exit_load_idx >= len(mutated_names):
            break
        name = mutated_names[exit_load_idx]
        local = find_local_binding(base_locals, name)
        if local != None:
            exit_load_temp = format_temp_name(current_temp)
            current_temp += 1
            current_lines = append_string(current_lines, "  " + exit_load_temp + " = load " + local.llvm_type + ", " + local.llvm_type + "* " + local.pointer)
            exit_loads = append_string(exit_loads, exit_load_temp)
        else:
            exit_loads = append_string(exit_loads, "")
        exit_load_idx += 1
    exit_mutations = []
    name_idx = 0
    while True:
        if name_idx >= len(mutated_names):
            break
        name = mutated_names[name_idx]
        exit_value = ""
        if name_idx < len(exit_loads):
            exit_value = exit_loads[name_idx]
        if len(exit_value) > 0:
            original = find_mutation_for_name(collected_mutations, name)
            llvm_type = ""
            original_span = None
            if original != None:
                llvm_type = original.llvm_type
                original_span = original.span
            if len(llvm_type) == 0:
                local = find_local_binding(base_locals, name)
                if local != None:
                    llvm_type = local.llvm_type
            if len(llvm_type) == 0:
                llvm_type = "double"
            exit_mutation = LocalMutation(name=name, llvm_type=llvm_type, value_name=exit_value, span=original_span, originating_label=exit_label)
            exit_mutations = (exit_mutations) + ([exit_mutation])
        name_idx += 1
    body_scoped_mutations = []
    body_mut_idx = 0
    while True:
        if body_mut_idx >= len(body_result.mutations):
            break
        mutation = body_result.mutations[body_mut_idx]
        if find_local_binding(base_locals, mutation.name) == None:
            already_added = False
            seen_idx = 0
            while True:
                if seen_idx >= len(body_scoped_mutations):
                    break
                if body_scoped_mutations[seen_idx].name == mutation.name:
                    already_added = True
                    break
                seen_idx += 1
            if not already_added:
                body_scoped_mutations = (body_scoped_mutations) + ([mutation])
        body_mut_idx += 1
    collected_mutations = (body_scoped_mutations) + (exit_mutations)
    return BlockLoweringResult(lines=current_lines, allocas=current_allocas, locals=current_locals, bindings=current_bindings, temp_index=current_temp, block_counter=current_block_counter, diagnostics=diagnostics, terminated=False, next_local_id=current_next_local, lifetime_regions=lifetime_regions, next_lifetime_region_id=current_next_region, next_index=structure.next_index + 1, mutations=collected_mutations, string_constants=collected_string_constants)

def lower_for_instruction(function, start_index, llvm_return, bindings, locals, allocas, lines, temp_index, block_counter, next_local_id, next_region_id, functions, loop_stack, end, context, scope_id, scope_depth, current_label):
    diagnostics = []
    current_lines = lines
    current_allocas = allocas
    current_locals = locals
    current_bindings = bindings
    current_temp = temp_index
    current_block_counter = block_counter
    current_next_local = next_local_id
    lifetime_regions = []
    current_next_region = next_region_id
    collected_mutations = []
    collected_string_constants = empty_string_constant_set()
    structure = collect_loop_structure(function.instructions, start_index, end, function.name)
    diagnostics = (diagnostics) + (structure.diagnostics)
    next_index = structure.next_index + 1
    instruction = function.instructions[start_index]
    raw_target = trim_text(instruction.target)
    raw_target = strip_mut_prefix(raw_target)
    if len(raw_target) == 0:
        diagnostics = append_string(diagnostics, "llvm lowering: `.for` loop missing iteration binding in `" + function.name + "`")
        return BlockLoweringResult(lines=current_lines, allocas=current_allocas, locals=current_locals, bindings=current_bindings, temp_index=current_temp, block_counter=current_block_counter, diagnostics=diagnostics, terminated=False, next_local_id=current_next_local, lifetime_regions=lifetime_regions, next_lifetime_region_id=current_next_region, next_index=next_index, mutations=collected_mutations, string_constants=collected_string_constants)
    if not is_simple_identifier(raw_target):
        diagnostics = append_string(diagnostics, "llvm lowering: `.for` loop target `" + raw_target + "` is not a simple identifier in `" + function.name + "`")
        return BlockLoweringResult(lines=current_lines, allocas=current_allocas, locals=current_locals, bindings=current_bindings, temp_index=current_temp, block_counter=current_block_counter, diagnostics=diagnostics, terminated=False, next_local_id=current_next_local, lifetime_regions=lifetime_regions, next_lifetime_region_id=current_next_region, next_index=next_index, mutations=collected_mutations, string_constants=collected_string_constants)
    if find_local_binding(current_locals, raw_target) != None:
        diagnostics = append_string(diagnostics, "llvm lowering: `.for` loop target `" + raw_target + "` shadows existing local in `" + function.name + "`")
        return BlockLoweringResult(lines=current_lines, allocas=current_allocas, locals=current_locals, bindings=current_bindings, temp_index=current_temp, block_counter=current_block_counter, diagnostics=diagnostics, terminated=False, next_local_id=current_next_local, lifetime_regions=lifetime_regions, next_lifetime_region_id=current_next_region, next_index=next_index, mutations=collected_mutations, string_constants=collected_string_constants)
    range_parse = parse_range_iterable(instruction.iterable)
    if range_parse.success:
        diagnostics = (diagnostics) + (range_parse.diagnostics)
        start_result = lower_expression(range_parse.start, current_bindings, current_locals, current_temp, current_lines, functions, context, "")
        diagnostics = (diagnostics) + (start_result.diagnostics)
        current_lines = start_result.lines
        current_temp = start_result.temp_index
        if start_result.operand == None:
            diagnostics = append_string(diagnostics, "llvm lowering: unable to lower `.for` range start in `" + function.name + "`")
            return BlockLoweringResult(lines=current_lines, allocas=current_allocas, locals=current_locals, bindings=current_bindings, temp_index=current_temp, block_counter=current_block_counter, diagnostics=diagnostics, terminated=False, next_local_id=current_next_local, lifetime_regions=lifetime_regions, next_lifetime_region_id=current_next_region, next_index=next_index, mutations=collected_mutations, string_constants=collected_string_constants)
        end_result = lower_expression(range_parse.end, current_bindings, current_locals, current_temp, current_lines, functions, context, "")
        diagnostics = (diagnostics) + (end_result.diagnostics)
        current_lines = end_result.lines
        current_temp = end_result.temp_index
        if end_result.operand == None:
            diagnostics = append_string(diagnostics, "llvm lowering: unable to lower `.for` range end in `" + function.name + "`")
            return BlockLoweringResult(lines=current_lines, allocas=current_allocas, locals=current_locals, bindings=current_bindings, temp_index=current_temp, block_counter=current_block_counter, diagnostics=diagnostics, terminated=False, next_local_id=current_next_local, lifetime_regions=lifetime_regions, next_lifetime_region_id=current_next_region, next_index=next_index, mutations=collected_mutations, string_constants=collected_string_constants)
        start_coerced = coerce_operand_to_type(start_result.operand, "double", current_temp, current_lines)
        diagnostics = (diagnostics) + (start_coerced.diagnostics)
        current_lines = start_coerced.lines
        current_temp = start_coerced.temp_index
        if start_coerced.operand == None:
            diagnostics = append_string(diagnostics, "llvm lowering: `.for` start expression must evaluate to `number` in `" + function.name + "`")
            return BlockLoweringResult(lines=current_lines, allocas=current_allocas, locals=current_locals, bindings=current_bindings, temp_index=current_temp, block_counter=current_block_counter, diagnostics=diagnostics, terminated=False, next_local_id=current_next_local, lifetime_regions=lifetime_regions, next_lifetime_region_id=current_next_region, next_index=next_index, mutations=collected_mutations, string_constants=collected_string_constants)
        start_operand = start_coerced.operand
        end_coerced = coerce_operand_to_type(end_result.operand, "double", current_temp, current_lines)
        diagnostics = (diagnostics) + (end_coerced.diagnostics)
        current_lines = end_coerced.lines
        current_temp = end_coerced.temp_index
        if end_coerced.operand == None:
            diagnostics = append_string(diagnostics, "llvm lowering: `.for` end expression must evaluate to `number` in `" + function.name + "`")
            return BlockLoweringResult(lines=current_lines, allocas=current_allocas, locals=current_locals, bindings=current_bindings, temp_index=current_temp, block_counter=current_block_counter, diagnostics=diagnostics, terminated=False, next_local_id=current_next_local, lifetime_regions=lifetime_regions, next_lifetime_region_id=current_next_region, next_index=next_index, mutations=collected_mutations, string_constants=collected_string_constants)
        end_operand = end_coerced.operand
        stride_operand = LLVMOperand(llvm_type="double", value="1.0")
        stride_text = trim_text(range_parse.stride)
        if len(stride_text) > 0:
            stride_result = lower_expression(stride_text, current_bindings, current_locals, current_temp, current_lines, functions, context, "")
            diagnostics = (diagnostics) + (stride_result.diagnostics)
            current_lines = stride_result.lines
            current_temp = stride_result.temp_index
            if stride_result.operand == None:
                diagnostics = append_string(diagnostics, "llvm lowering: `.for` stride expression did not produce a value in `" + function.name + "`")
                return BlockLoweringResult(lines=current_lines, allocas=current_allocas, locals=current_locals, bindings=current_bindings, temp_index=current_temp, block_counter=current_block_counter, diagnostics=diagnostics, terminated=False, next_local_id=current_next_local, lifetime_regions=lifetime_regions, next_lifetime_region_id=current_next_region, next_index=next_index, mutations=collected_mutations, string_constants=collected_string_constants)
            stride_coerced = coerce_operand_to_type(stride_result.operand, "double", current_temp, current_lines)
            diagnostics = (diagnostics) + (stride_coerced.diagnostics)
            current_lines = stride_coerced.lines
            current_temp = stride_coerced.temp_index
            if stride_coerced.operand == None:
                diagnostics = append_string(diagnostics, "llvm lowering: `.for` stride expression must evaluate to `number` in `" + function.name + "`")
                return BlockLoweringResult(lines=current_lines, allocas=current_allocas, locals=current_locals, bindings=current_bindings, temp_index=current_temp, block_counter=current_block_counter, diagnostics=diagnostics, terminated=False, next_local_id=current_next_local, lifetime_regions=lifetime_regions, next_lifetime_region_id=current_next_region, next_index=next_index, mutations=collected_mutations, string_constants=collected_string_constants)
            stride_operand = stride_coerced.operand
            if is_number_literal(stride_text):
                normalised_stride = normalise_number_literal(stride_text)
                if normalised_stride == "0.0":
                    diagnostics = append_string(diagnostics, "llvm lowering: `.for` stride must not be zero in `" + function.name + "`")
        stride_pointer = format_local_pointer_name(current_next_local)
        current_next_local += 1
        current_allocas = append_string(current_allocas, "  " + stride_pointer + " = alloca double")
        current_lines = append_string(current_lines, "  store double " + stride_operand.value + ", double* " + stride_pointer)
        loop_header_alloc = allocate_block_label("for", current_block_counter)
        loop_header_label = loop_header_alloc.label
        current_block_counter = loop_header_alloc.next_counter
        loop_body_alloc = allocate_block_label("forbody", current_block_counter)
        loop_body_label = loop_body_alloc.label
        current_block_counter = loop_body_alloc.next_counter
        loop_increment_alloc = allocate_block_label("forinc", current_block_counter)
        loop_increment_label = loop_increment_alloc.label
        current_block_counter = loop_increment_alloc.next_counter
        loop_exit_alloc = allocate_block_label("afterfor", current_block_counter)
        loop_exit_label = loop_exit_alloc.label
        current_block_counter = loop_exit_alloc.next_counter
        iteration_pointer = format_local_pointer_name(current_next_local)
        current_next_local += 1
        current_allocas = append_string(current_allocas, "  " + iteration_pointer + " = alloca double")
        current_lines = append_string(current_lines, "  store double " + start_operand.value + ", double* " + iteration_pointer)
        current_lines = append_string(current_lines, "  br label %" + loop_header_label)
        current_lines = append_string(current_lines, loop_header_label + ":")
        loop_body_scope_id = make_child_scope_id(scope_id, loop_body_label)
        iteration_binding = LocalBinding(name=raw_target, pointer=iteration_pointer, llvm_type="double", type_annotation="number", ownership=None, consumed=False, scope_id=loop_body_scope_id, scope_depth=scope_depth + 1)
        header_load = load_local_operand(iteration_binding, current_temp, current_lines)
        diagnostics = (diagnostics) + (header_load.diagnostics)
        current_lines = header_load.lines
        current_temp = header_load.temp_index
        if header_load.operand == None:
            diagnostics = append_string(diagnostics, "llvm lowering: internal error loading `.for` iteration value in `" + function.name + "`")
            current_lines = append_string(current_lines, "  br label %" + loop_exit_label)
            current_lines = append_string(current_lines, loop_exit_label + ":")
            return BlockLoweringResult(lines=current_lines, allocas=current_allocas, locals=current_locals, bindings=current_bindings, temp_index=current_temp, block_counter=current_block_counter, diagnostics=diagnostics, terminated=False, next_local_id=current_next_local, lifetime_regions=lifetime_regions, next_lifetime_region_id=current_next_region, next_index=next_index, mutations=collected_mutations, string_constants=collected_string_constants)
        stride_header_name = format_temp_name(current_temp)
        current_lines = append_string(current_lines, "  " + stride_header_name + " = load double, double* " + stride_pointer)
        current_temp += 1
        stride_positive_name = format_temp_name(current_temp)
        current_lines = append_string(current_lines, "  " + stride_positive_name + " = fcmp ogt double " + stride_header_name + ", 0.0")
        current_temp += 1
        stride_negative_name = format_temp_name(current_temp)
        current_lines = append_string(current_lines, "  " + stride_negative_name + " = fcmp olt double " + stride_header_name + ", 0.0")
        current_temp += 1
        ascending_comparison = emit_comparison_instruction("<", header_load.operand, end_operand, current_temp, current_lines)
        diagnostics = (diagnostics) + (ascending_comparison.diagnostics)
        current_lines = ascending_comparison.lines
        current_temp = ascending_comparison.temp_index
        if ascending_comparison.operand == None:
            diagnostics = append_string(diagnostics, "llvm lowering: unable to compare `.for` range bounds in `" + function.name + "`")
            current_lines = append_string(current_lines, "  br label %" + loop_exit_label)
            current_lines = append_string(current_lines, loop_exit_label + ":")
            return BlockLoweringResult(lines=current_lines, allocas=current_allocas, locals=current_locals, bindings=current_bindings, temp_index=current_temp, block_counter=current_block_counter, diagnostics=diagnostics, terminated=False, next_local_id=current_next_local, lifetime_regions=lifetime_regions, next_lifetime_region_id=current_next_region, next_index=next_index, mutations=collected_mutations, string_constants=collected_string_constants)
        descending_comparison = emit_comparison_instruction(">", header_load.operand, end_operand, current_temp, current_lines)
        diagnostics = (diagnostics) + (descending_comparison.diagnostics)
        current_lines = descending_comparison.lines
        current_temp = descending_comparison.temp_index
        if descending_comparison.operand == None:
            diagnostics = append_string(diagnostics, "llvm lowering: unable to compare descending `.for` range bounds in `" + function.name + "`")
            current_lines = append_string(current_lines, "  br label %" + loop_exit_label)
            current_lines = append_string(current_lines, loop_exit_label + ":")
            return BlockLoweringResult(lines=current_lines, allocas=current_allocas, locals=current_locals, bindings=current_bindings, temp_index=current_temp, block_counter=current_block_counter, diagnostics=diagnostics, terminated=False, next_local_id=current_next_local, lifetime_regions=lifetime_regions, next_lifetime_region_id=current_next_region, next_index=next_index, mutations=collected_mutations, string_constants=collected_string_constants)
        ascending_active_name = format_temp_name(current_temp)
        current_lines = append_string(current_lines, "  " + ascending_active_name + " = and i1 " + stride_positive_name + ", " + ascending_comparison.operand.value)
        current_temp += 1
        descending_active_name = format_temp_name(current_temp)
        current_lines = append_string(current_lines, "  " + descending_active_name + " = and i1 " + stride_negative_name + ", " + descending_comparison.operand.value)
        current_temp += 1
        continue_name = format_temp_name(current_temp)
        current_lines = append_string(current_lines, "  " + continue_name + " = or i1 " + ascending_active_name + ", " + descending_active_name)
        current_temp += 1
        current_lines = append_string(current_lines, "  br i1 " + continue_name + ", label %" + loop_body_label + ", label %" + loop_exit_label)
        current_lines = append_string(current_lines, loop_body_label + ":")
        loop_context = LoopContext(break_label=loop_exit_label, continue_label=loop_increment_label)
        stacked = append_loop_context(loop_stack, loop_context)
        body_locals = append_local_binding(current_locals, iteration_binding)
        body_result = lower_instruction_range(
function,
structure.body_start,
structure.body_end,
llvm_return,
current_bindings,
body_locals,
current_allocas,
[],
current_temp,
current_block_counter,
current_next_local,
current_next_region,
functions,
stacked,
context,
loop_body_scope_id,
scope_depth + 1,
loop_body_label
)
        diagnostics = (diagnostics) + (body_result.diagnostics)
        lifetime_regions = (lifetime_regions) + (body_result.lifetime_regions)
        current_lines = (current_lines) + (body_result.lines)
        current_allocas = body_result.allocas
        current_temp = body_result.temp_index
        current_block_counter = body_result.block_counter
        current_next_local = body_result.next_local_id
        current_bindings = body_result.bindings
        current_next_region = body_result.next_lifetime_region_id
        collected_mutations = (collected_mutations) + (body_result.mutations)
        if not body_result.terminated:
            current_lines = append_string(current_lines, "  br label %" + loop_increment_label)
        current_lines = append_string(current_lines, loop_increment_label + ":")
        increment_load = load_local_operand(iteration_binding, current_temp, current_lines)
        diagnostics = (diagnostics) + (increment_load.diagnostics)
        current_lines = increment_load.lines
        current_temp = increment_load.temp_index
        if increment_load.operand != None:
            increment_stride_name = format_temp_name(current_temp)
            current_lines = append_string(current_lines, "  " + increment_stride_name + " = load double, double* " + stride_pointer)
            current_temp += 1
            next_value_name = format_temp_name(current_temp)
            current_lines = append_string(current_lines, "  " + next_value_name + " = fadd double " + increment_load.operand.value + ", " + increment_stride_name)
            current_temp += 1
            current_lines = append_string(current_lines, "  store double " + next_value_name + ", double* " + iteration_pointer)
        else:
            diagnostics = append_string(diagnostics, "llvm lowering: unable to increment `.for` iterator in `" + function.name + "`")
        current_lines = append_string(current_lines, "  br label %" + loop_header_label)
        current_lines = append_string(current_lines, loop_exit_label + ":")
        mutated_names = collect_mutation_names(collected_mutations)
        exit_loads = []
        load_idx = 0
        while True:
            if load_idx >= len(mutated_names):
                break
            name = mutated_names[load_idx]
            local = find_local_binding(locals, name)
            if local != None:
                exit_load_temp = format_temp_name(current_temp)
                current_temp += 1
                current_lines = append_string(current_lines, "  " + exit_load_temp + " = load " + local.llvm_type + ", " + local.llvm_type + "* " + local.pointer)
                exit_loads = append_string(exit_loads, exit_load_temp)
            else:
                exit_loads = append_string(exit_loads, "")
            load_idx += 1
        exit_mutations = []
        exit_idx = 0
        while True:
            if exit_idx >= len(mutated_names):
                break
            name = mutated_names[exit_idx]
            exit_value = ""
            if exit_idx < len(exit_loads):
                exit_value = exit_loads[exit_idx]
            if len(exit_value) > 0:
                original = find_mutation_for_name(collected_mutations, name)
                llvm_type = ""
                original_span = None
                if original != None:
                    llvm_type = original.llvm_type
                    original_span = original.span
                if len(llvm_type) == 0:
                    local = find_local_binding(locals, name)
                    if local != None:
                        llvm_type = local.llvm_type
                if len(llvm_type) == 0:
                    llvm_type = "double"
                exit_mutation = LocalMutation(name=name, llvm_type=llvm_type, value_name=exit_value, span=original_span, originating_label=loop_exit_label)
                exit_mutations = (exit_mutations) + ([exit_mutation])
            exit_idx += 1
        collected_mutations = exit_mutations
        current_locals = locals
        return BlockLoweringResult(lines=current_lines, allocas=current_allocas, locals=current_locals, bindings=current_bindings, temp_index=current_temp, block_counter=current_block_counter, diagnostics=diagnostics, terminated=False, next_local_id=current_next_local, lifetime_regions=lifetime_regions, next_lifetime_region_id=current_next_region, next_index=next_index, mutations=collected_mutations, string_constants=collected_string_constants)
    iterable_result = lower_expression(instruction.iterable, current_bindings, current_locals, current_temp, current_lines, functions, context, "")
    diagnostics = (diagnostics) + (iterable_result.diagnostics)
    current_lines = iterable_result.lines
    current_temp = iterable_result.temp_index
    if iterable_result.operand == None:
        diagnostics = (diagnostics) + (range_parse.diagnostics)
        diagnostics = append_string(diagnostics, "llvm lowering: unable to lower `.for` iterable in `" + function.name + "`")
        return BlockLoweringResult(lines=current_lines, allocas=current_allocas, locals=current_locals, bindings=current_bindings, temp_index=current_temp, block_counter=current_block_counter, diagnostics=diagnostics, terminated=False, next_local_id=current_next_local, lifetime_regions=lifetime_regions, next_lifetime_region_id=current_next_region, next_index=next_index, mutations=collected_mutations, string_constants=collected_string_constants)
    iterable_operand = iterable_result.operand
    element_type = array_pointer_element_type(iterable_operand.llvm_type)
    if len(element_type) == 0:
        diagnostics = (diagnostics) + (range_parse.diagnostics)
        diagnostics = append_string(diagnostics, "llvm lowering: `.for` iterable must resolve to an array value in `" + function.name + "`")
        return BlockLoweringResult(lines=current_lines, allocas=current_allocas, locals=current_locals, bindings=current_bindings, temp_index=current_temp, block_counter=current_block_counter, diagnostics=diagnostics, terminated=False, next_local_id=current_next_local, lifetime_regions=lifetime_regions, next_lifetime_region_id=current_next_region, next_index=next_index, mutations=collected_mutations, string_constants=collected_string_constants)
    array_struct_type = array_struct_type_for_element(element_type)
    data_pointer_type = element_type + "*"
    data_pointer_pointer_type = data_pointer_type + "*"
    length_pointer_name = format_temp_name(current_temp)
    current_lines = append_string(current_lines, "  " + length_pointer_name + " = getelementptr " + array_struct_type + ", " + array_struct_type + "* " + iterable_operand.value + ", i32 0, i32 1")
    current_temp += 1
    length_load_name = format_temp_name(current_temp)
    current_lines = append_string(current_lines, "  " + length_load_name + " = load i64, i64* " + length_pointer_name)
    current_temp += 1
    length_operand = LLVMOperand(llvm_type="i64", value=length_load_name)
    data_pointer_name = format_temp_name(current_temp)
    current_lines = append_string(current_lines, "  " + data_pointer_name + " = getelementptr " + array_struct_type + ", " + array_struct_type + "* " + iterable_operand.value + ", i32 0, i32 0")
    current_temp += 1
    data_load_name = format_temp_name(current_temp)
    current_lines = append_string(current_lines, "  " + data_load_name + " = load " + data_pointer_type + ", " + data_pointer_pointer_type + " " + data_pointer_name)
    current_temp += 1
    data_operand = LLVMOperand(llvm_type=data_pointer_type, value=data_load_name)
    loop_header_alloc = allocate_block_label("for", current_block_counter)
    loop_header_label = loop_header_alloc.label
    current_block_counter = loop_header_alloc.next_counter
    loop_body_alloc = allocate_block_label("forbody", current_block_counter)
    loop_body_label = loop_body_alloc.label
    current_block_counter = loop_body_alloc.next_counter
    loop_increment_alloc = allocate_block_label("forinc", current_block_counter)
    loop_increment_label = loop_increment_alloc.label
    current_block_counter = loop_increment_alloc.next_counter
    loop_exit_alloc = allocate_block_label("afterfor", current_block_counter)
    loop_exit_label = loop_exit_alloc.label
    current_block_counter = loop_exit_alloc.next_counter
    index_pointer = format_local_pointer_name(current_next_local)
    current_next_local += 1
    current_allocas = append_string(current_allocas, "  " + index_pointer + " = alloca i64")
    current_lines = append_string(current_lines, "  store i64 0, i64* " + index_pointer)
    iteration_pointer = format_local_pointer_name(current_next_local)
    current_next_local += 1
    current_allocas = append_string(current_allocas, "  " + iteration_pointer + " = alloca " + element_type)
    current_lines = append_string(current_lines, "  store " + element_type + " " + default_return_literal(element_type) + ", " + element_type + "* " + iteration_pointer)
    current_lines = append_string(current_lines, "  br label %" + loop_header_label)
    current_lines = append_string(current_lines, loop_header_label + ":")
    header_index_name = format_temp_name(current_temp)
    current_lines = append_string(current_lines, "  " + header_index_name + " = load i64, i64* " + index_pointer)
    current_temp += 1
    comparison_name = format_temp_name(current_temp)
    current_lines = append_string(current_lines, "  " + comparison_name + " = icmp slt i64 " + header_index_name + ", " + length_operand.value)
    current_temp += 1
    current_lines = append_string(current_lines, "  br i1 " + comparison_name + ", label %" + loop_body_label + ", label %" + loop_exit_label)
    current_lines = append_string(current_lines, loop_body_label + ":")
    body_index_name = format_temp_name(current_temp)
    current_lines = append_string(current_lines, "  " + body_index_name + " = load i64, i64* " + index_pointer)
    current_temp += 1
    element_pointer_name = format_temp_name(current_temp)
    current_lines = append_string(current_lines, "  " + element_pointer_name + " = getelementptr " + element_type + ", " + element_type + "* " + data_operand.value + ", i64 " + body_index_name)
    current_temp += 1
    element_load_name = format_temp_name(current_temp)
    current_lines = append_string(current_lines, "  " + element_load_name + " = load " + element_type + ", " + element_type + "* " + element_pointer_name)
    current_temp += 1
    current_lines = append_string(current_lines, "  store " + element_type + " " + element_load_name + ", " + element_type + "* " + iteration_pointer)
    loop_context = LoopContext(break_label=loop_exit_label, continue_label=loop_increment_label)
    stacked = append_loop_context(loop_stack, loop_context)
    element_loop_scope_id = make_child_scope_id(scope_id, loop_body_label)
    iteration_binding = LocalBinding(name=raw_target, pointer=iteration_pointer, llvm_type=element_type, type_annotation="", ownership=None, consumed=False, scope_id=element_loop_scope_id, scope_depth=scope_depth + 1)
    body_locals = append_local_binding(current_locals, iteration_binding)
    body_result = lower_instruction_range(
function,
structure.body_start,
structure.body_end,
llvm_return,
current_bindings,
body_locals,
current_allocas,
[],
current_temp,
current_block_counter,
current_next_local,
current_next_region,
functions,
stacked,
context,
element_loop_scope_id,
scope_depth + 1,
loop_body_label
)
    diagnostics = (diagnostics) + (body_result.diagnostics)
    lifetime_regions = (lifetime_regions) + (body_result.lifetime_regions)
    current_lines = (current_lines) + (body_result.lines)
    current_allocas = body_result.allocas
    current_temp = body_result.temp_index
    current_block_counter = body_result.block_counter
    current_next_local = body_result.next_local_id
    current_bindings = body_result.bindings
    current_next_region = body_result.next_lifetime_region_id
    collected_mutations = (collected_mutations) + (body_result.mutations)
    collected_string_constants = merge_string_constants(collected_string_constants, body_result.string_constants)
    if not body_result.terminated:
        current_lines = append_string(current_lines, "  br label %" + loop_increment_label)
    current_lines = append_string(current_lines, loop_increment_label + ":")
    increment_index_name = format_temp_name(current_temp)
    current_lines = append_string(current_lines, "  " + increment_index_name + " = load i64, i64* " + index_pointer)
    current_temp += 1
    next_index_name = format_temp_name(current_temp)
    current_lines = append_string(current_lines, "  " + next_index_name + " = add i64 " + increment_index_name + ", 1")
    current_temp += 1
    current_lines = append_string(current_lines, "  store i64 " + next_index_name + ", i64* " + index_pointer)
    current_lines = append_string(current_lines, "  br label %" + loop_header_label)
    current_lines = append_string(current_lines, loop_exit_label + ":")
    mutated_names = collect_mutation_names(collected_mutations)
    exit_loads = []
    load_idx = 0
    while True:
        if load_idx >= len(mutated_names):
            break
        name = mutated_names[load_idx]
        local = find_local_binding(locals, name)
        if local != None:
            exit_load_temp = format_temp_name(current_temp)
            current_temp += 1
            current_lines = append_string(current_lines, "  " + exit_load_temp + " = load " + local.llvm_type + ", " + local.llvm_type + "* " + local.pointer)
            exit_loads = append_string(exit_loads, exit_load_temp)
        else:
            exit_loads = append_string(exit_loads, "")
        load_idx += 1
    exit_mutations = []
    exit_idx = 0
    while True:
        if exit_idx >= len(mutated_names):
            break
        name = mutated_names[exit_idx]
        exit_value = ""
        if exit_idx < len(exit_loads):
            exit_value = exit_loads[exit_idx]
        if len(exit_value) > 0:
            original = find_mutation_for_name(collected_mutations, name)
            llvm_type = ""
            original_span = None
            if original != None:
                llvm_type = original.llvm_type
                original_span = original.span
            if len(llvm_type) == 0:
                local = find_local_binding(locals, name)
                if local != None:
                    llvm_type = local.llvm_type
            if len(llvm_type) == 0:
                llvm_type = "double"
            exit_mutation = LocalMutation(name=name, llvm_type=llvm_type, value_name=exit_value, span=original_span, originating_label=loop_exit_label)
            exit_mutations = (exit_mutations) + ([exit_mutation])
        exit_idx += 1
    collected_mutations = exit_mutations
    current_locals = locals
    empty_constants = empty_string_constant_set()
    return BlockLoweringResult(lines=current_lines, allocas=current_allocas, locals=current_locals, bindings=current_bindings, temp_index=current_temp, block_counter=current_block_counter, diagnostics=diagnostics, terminated=False, next_local_id=current_next_local, lifetime_regions=lifetime_regions, next_lifetime_region_id=current_next_region, next_index=next_index, mutations=collected_mutations, string_constants=empty_constants)

def collect_match_structure(instructions, start_index, end, function_name):
    diagnostics = []
    cases = []
    current_case = None
    index = start_index + 1
    depth = 0
    limit = end
    if limit > len(instructions):
        limit = len(instructions)
    while True:
        if index >= limit:
            diagnostics = append_string(diagnostics, "llvm lowering: unterminated `.match` in `" + function_name + "`")
            if current_case != None:
                finished = finalize_match_case(current_case, limit)
                cases = append_match_case(cases, finished)
            return MatchStructure(cases=cases, end_index=limit - 1, diagnostics=diagnostics)
        instruction = instructions[index]
        if instruction.variant == "Match":
            depth += 1
            index += 1
            continue
        if instruction.variant == "EndMatch":
            if depth == 0:
                if current_case != None:
                    finished = finalize_match_case(current_case, index)
                    cases = append_match_case(cases, finished)
                    current_case = None
                return MatchStructure(cases=cases, end_index=index, diagnostics=diagnostics)
            depth -= 1
            index += 1
            continue
        if depth > 0:
            index += 1
            continue
        if instruction.variant == "Case":
            if current_case != None:
                finished = finalize_match_case(current_case, index)
                cases = append_match_case(cases, finished)
            guard_text = None
            if instruction.guard != None:
                guard_text = instruction.guard
            current_case = MatchCaseStructure(pattern=instruction.pattern, guard=guard_text, body_start=index + 1, body_end=index + 1, is_default=is_default_pattern(instruction.pattern))
            index += 1
            continue
        index += 1
    return MatchStructure(cases=cases, end_index=limit, diagnostics=diagnostics)

def append_match_case(cases, value):
    return (cases) + ([value])

def finalize_match_case(case, body_end):
    value = case
    return MatchCaseStructure(pattern=value.pattern, guard=value.guard, body_start=value.body_start, body_end=body_end, is_default=value.is_default)

def is_default_pattern(pattern):
    trimmed = trim_text(pattern)
    if len(trimmed) == 0:
        return True
    if trimmed == "_":
        return True
    return False

def lower_match_instruction(function, start_index, llvm_return, bindings, locals, allocas, lines, temp_index, block_counter, next_local_id, next_region_id, functions, loop_stack, end, context, scope_id, scope_depth, current_label):
    diagnostics = []
    current_lines = lines
    current_allocas = allocas
    current_locals = locals
    current_temp = temp_index
    current_block_counter = block_counter
    current_next_local = next_local_id
    base_bindings = bindings
    merged_bindings = base_bindings
    lifetime_regions = []
    current_next_region = next_region_id
    collected_mutations = []
    collected_string_constants = empty_string_constant_set()
    structure = collect_match_structure(function.instructions, start_index, end, function.name)
    diagnostics = (diagnostics) + (structure.diagnostics)
    subject_instruction = function.instructions[start_index]
    subject_name = extract_simple_identifier(subject_instruction.expression)
    subject_result = lower_expression(subject_instruction.expression, bindings, current_locals, current_temp, current_lines, functions, context, "")
    diagnostics = (diagnostics) + (subject_result.diagnostics)
    current_lines = subject_result.lines
    current_temp = subject_result.temp_index
    collected_string_constants = merge_string_constants(collected_string_constants, subject_result.string_constants)
    if subject_result.operand == None:
        diagnostics = append_string(diagnostics, "llvm lowering: unable to lower match subject in `" + function.name + "`")
        return BlockLoweringResult(lines=current_lines, allocas=current_allocas, locals=current_locals, bindings=base_bindings, temp_index=current_temp, block_counter=current_block_counter, diagnostics=diagnostics, terminated=False, next_local_id=current_next_local, lifetime_regions=lifetime_regions, next_lifetime_region_id=current_next_region, next_index=structure.end_index + 1, mutations=collected_mutations, string_constants=collected_string_constants)
    subject_operand = subject_result.operand
    union_payload_types = parse_union_payload_types(subject_operand.llvm_type)
    matched_union_variants = []
    subject_enum_info = find_enum_info_by_llvm_type(context, subject_operand.llvm_type)
    matched_enum_tags = []
    if len(structure.cases) == 0:
        diagnostics = append_string(diagnostics, "llvm lowering: match without cases in `" + function.name + "`")
        merge_alloc = allocate_block_label("matchmerge", current_block_counter)
        merge_label = merge_alloc.label
        current_block_counter = merge_alloc.next_counter
        current_lines = append_string(current_lines, "  br label %" + merge_label)
        current_lines = append_string(current_lines, merge_label + ":")
        return BlockLoweringResult(lines=current_lines, allocas=current_allocas, locals=current_locals, bindings=base_bindings, temp_index=current_temp, block_counter=current_block_counter, diagnostics=diagnostics, terminated=False, next_local_id=current_next_local, lifetime_regions=lifetime_regions, next_lifetime_region_id=current_next_region, next_index=structure.end_index + 1, mutations=collected_mutations, string_constants=collected_string_constants)
    test_labels = []
    body_labels = []
    index = 0
    while True:
        if index >= len(structure.cases):
            break
        test_alloc = allocate_block_label("matchcase", current_block_counter)
        body_alloc = allocate_block_label("matchbody", test_alloc.next_counter)
        test_labels = append_string(test_labels, test_alloc.label)
        body_labels = append_string(body_labels, body_alloc.label)
        current_block_counter = body_alloc.next_counter
        index += 1
    merge_alloc = allocate_block_label("matchmerge", current_block_counter)
    merge_label = merge_alloc.label
    current_block_counter = merge_alloc.next_counter
    preloaded_locals = []
    preload_index = 0
    while True:
        if preload_index >= len(current_locals):
            break
        local = current_locals[preload_index]
        preload_temp = format_temp_name(current_temp)
        current_temp += 1
        preload_line = "  " + preload_temp + " = load " + local.llvm_type + ", " + local.llvm_type + "* " + local.pointer
        current_lines = append_string(current_lines, preload_line)
        preloaded_locals = append_string(preloaded_locals, preload_temp)
        preload_index += 1
    current_lines = append_string(current_lines, "  br label %" + test_labels[0])
    all_terminated = True
    has_unconditional_default = False
    has_guarded_cases = False
    arm_mutations_list = []
    index = 0
    while True:
        if index >= len(structure.cases):
            break
        case = structure.cases[index]
        guard_has_text = False
        if case.guard != None:
            guard_trimmed = trim_text(case.guard)
            if len(guard_trimmed) > 0:
                guard_has_text = True
                has_guarded_cases = True
        failure_target = merge_label
        if index + 1 < len(structure.cases):
            failure_target = test_labels[index + 1]
        current_lines = append_string(current_lines, test_labels[index] + ":")
        lowered_condition = lower_match_case_condition(
function.name,
subject_operand,
case,
bindings,
current_locals,
current_temp,
current_lines,
functions,
context
)
        diagnostics = (diagnostics) + (lowered_condition.diagnostics)
        current_lines = lowered_condition.lines
        current_temp = lowered_condition.temp_index
        collected_string_constants = merge_string_constants(collected_string_constants, lowered_condition.string_constants)
        if lowered_condition.union_variant_index >= 0  and  not guard_has_text:
            seen = False
            seen_index = 0
            while True:
                if seen_index >= len(matched_union_variants):
                    break
                if matched_union_variants[seen_index] == lowered_condition.union_variant_index:
                    seen = True
                    break
                seen_index += 1
            if not seen:
                matched_union_variants = (matched_union_variants) + ([lowered_condition.union_variant_index])
        if subject_enum_info != None  and  lowered_condition.enum_info != None  and  lowered_condition.variant_info != None  and  not guard_has_text:
            enum_info_val = lowered_condition.enum_info
            variant_info_val = lowered_condition.variant_info
            if enum_info_val.llvm_name == subject_enum_info.llvm_name:
                tag_value = variant_info_val.tag
                seen_tag = False
                tag_index = 0
                while True:
                    if tag_index >= len(matched_enum_tags):
                        break
                    if matched_enum_tags[tag_index] == tag_value:
                        seen_tag = True
                        break
                    tag_index += 1
                if not seen_tag:
                    matched_enum_tags = (matched_enum_tags) + ([tag_value])
        if lowered_condition.is_default:
            has_unconditional_default = True
            current_lines = append_string(current_lines, "  br label %" + body_labels[index])
        else:
            if lowered_condition.operand != None:
                current_lines = append_string(current_lines, "  br i1 " + lowered_condition.operand.value + ", label %" + body_labels[index] + ", label %" + failure_target)
            else:
                current_lines = append_string(current_lines, "  br label %" + failure_target)
        current_lines = append_string(current_lines, body_labels[index] + ":")
        base_locals = current_locals
        base_allocas = current_allocas
        base_local_id = current_next_local
        if len(lowered_condition.field_bindings) > 0  and  lowered_condition.enum_info != None  and  lowered_condition.variant_info != None  and  subject_operand != None:
            enum_info_val = lowered_condition.enum_info
            variant_info_val = lowered_condition.variant_info
            subject_alloca_temp = format_temp_name(current_temp)
            current_temp += 1
            current_lines = append_string(current_lines, "  " + subject_alloca_temp + " = alloca " + subject_operand.llvm_type)
            current_lines = append_string(current_lines, "  store " + subject_operand.llvm_type + " " + subject_operand.value + ", " + subject_operand.llvm_type + "* " + subject_alloca_temp)
            binding_idx = 0
            while True:
                if binding_idx >= len(lowered_condition.field_bindings):
                    break
                field_binding = lowered_condition.field_bindings[binding_idx]
                payload_ptr_temp = format_temp_name(current_temp)
                current_temp += 1
                current_lines = append_string(current_lines, "  " + payload_ptr_temp + " = getelementptr inbounds " + enum_info_val.llvm_name + ", " + enum_info_val.llvm_name + "* " + subject_alloca_temp + ", i32 0, i32 1")
                byte_ptr_temp = format_temp_name(current_temp)
                current_temp += 1
                current_lines = append_string(current_lines, "  " + byte_ptr_temp + " = bitcast [" + number_to_string(enum_info_val.max_payload_size) + " x i8]* " + payload_ptr_temp + " to i8*")
                field_offset_in_payload = field_binding.field_offset - variant_info_val.offset
                field_ptr_temp = byte_ptr_temp
                if field_offset_in_payload > 0:
                    offset_ptr_temp = format_temp_name(current_temp)
                    current_temp += 1
                    current_lines = append_string(current_lines, "  " + offset_ptr_temp + " = getelementptr inbounds i8, i8* " + byte_ptr_temp + ", i64 " + number_to_string(field_offset_in_payload))
                    field_ptr_temp = offset_ptr_temp
                typed_ptr_temp = format_temp_name(current_temp)
                current_temp += 1
                current_lines = append_string(current_lines, "  " + typed_ptr_temp + " = bitcast i8* " + field_ptr_temp + " to " + field_binding.field_type + "*")
                value_temp = format_temp_name(current_temp)
                current_temp += 1
                current_lines = append_string(current_lines, "  " + value_temp + " = load " + field_binding.field_type + ", " + field_binding.field_type + "* " + typed_ptr_temp)
                local_alloca_temp = format_temp_name(current_temp)
                current_temp += 1
                current_lines = append_string(current_lines, "  " + local_alloca_temp + " = alloca " + field_binding.field_type)
                current_lines = append_string(current_lines, "  store " + field_binding.field_type + " " + value_temp + ", " + field_binding.field_type + "* " + local_alloca_temp)
                base_locals = (base_locals) + ([LocalBinding(name=field_binding.field_name, pointer=local_alloca_temp, llvm_type=field_binding.field_type, type_annotation="", ownership=None, consumed=False, scope_id=make_child_scope_id(scope_id, body_labels[index]), scope_depth=scope_depth + 1)])
                base_local_id += 1
                binding_idx += 1
        if lowered_condition.union_variant_index >= 0  and  lowered_condition.union_struct_info != None  and  len(lowered_condition.union_struct_bindings) > 0:
            struct_info_val = lowered_condition.union_struct_info
            variant_index = lowered_condition.union_variant_index
            payload_index = variant_index + 1
            payload_temp = format_temp_name(current_temp)
            current_temp += 1
            payload_type = union_payload_types[variant_index]
            current_lines = append_string(current_lines, "  " + payload_temp + " = extractvalue " + subject_operand.llvm_type + " " + subject_operand.value + ", " + number_to_string(payload_index))
            typed_payload_ptr = payload_temp
            expected_ptr_type = struct_info_val.llvm_name + "*"
            if payload_type == "i8*":
                cast_temp = format_temp_name(current_temp)
                current_temp += 1
                current_lines = append_string(current_lines, "  " + cast_temp + " = bitcast i8* " + payload_temp + " to " + expected_ptr_type)
                typed_payload_ptr = cast_temp
            binding_idx = 0
            while True:
                if binding_idx >= len(lowered_condition.union_struct_bindings):
                    break
                binding = lowered_condition.union_struct_bindings[binding_idx]
                gep_temp = format_temp_name(current_temp)
                current_temp += 1
                current_lines = append_string(current_lines, "  " + gep_temp + " = getelementptr " + struct_info_val.llvm_name + ", " + expected_ptr_type + " " + typed_payload_ptr + ", i32 0, i32 " + number_to_string(binding.field_index))
                load_temp = format_temp_name(current_temp)
                current_temp += 1
                current_lines = append_string(current_lines, "  " + load_temp + " = load " + binding.field_type + ", " + binding.field_type + "* " + gep_temp)
                local_alloca_temp = format_temp_name(current_temp)
                current_temp += 1
                current_lines = append_string(current_lines, "  " + local_alloca_temp + " = alloca " + binding.field_type)
                current_lines = append_string(current_lines, "  store " + binding.field_type + " " + load_temp + ", " + binding.field_type + "* " + local_alloca_temp)
                base_locals = (base_locals) + ([LocalBinding(name=binding.field_name, pointer=local_alloca_temp, llvm_type=binding.field_type, type_annotation="", ownership=None, consumed=False, scope_id=make_child_scope_id(scope_id, body_labels[index]), scope_depth=scope_depth + 1)])
                base_local_id += 1
                binding_idx += 1
        if lowered_condition.is_default  and  len(union_payload_types) > 0  and  len(subject_name) > 0:
            remaining = []
            v = 0
            while True:
                if v >= len(union_payload_types):
                    break
                is_matched = False
                mi = 0
                while True:
                    if mi >= len(matched_union_variants):
                        break
                    if matched_union_variants[mi] == v:
                        is_matched = True
                        break
                    mi += 1
                if not is_matched:
                    remaining = (remaining) + ([v])
                v += 1
            if len(remaining) == 1:
                remaining_index = remaining[0]
                payload_index = remaining_index + 1
                payload_type = union_payload_types[remaining_index]
                payload_temp = format_temp_name(current_temp)
                current_temp += 1
                current_lines = append_string(current_lines, "  " + payload_temp + " = extractvalue " + subject_operand.llvm_type + " " + subject_operand.value + ", " + number_to_string(payload_index))
                local_alloca_temp = format_temp_name(current_temp)
                current_temp += 1
                current_lines = append_string(current_lines, "  " + local_alloca_temp + " = alloca " + payload_type)
                current_lines = append_string(current_lines, "  store " + payload_type + " " + payload_temp + ", " + payload_type + "* " + local_alloca_temp)
                base_locals = (base_locals) + ([LocalBinding(name=subject_name, pointer=local_alloca_temp, llvm_type=payload_type, type_annotation="", ownership=None, consumed=False, scope_id=make_child_scope_id(scope_id, body_labels[index]), scope_depth=scope_depth + 1)])
                base_local_id += 1
        body_result = lower_instruction_range(
function,
case.body_start,
case.body_end,
llvm_return,
bindings,
base_locals,
base_allocas,
[],
current_temp,
current_block_counter,
base_local_id,
current_next_region,
functions,
loop_stack,
context,
make_child_scope_id(scope_id, body_labels[index]),
scope_depth + 1,
body_labels[index]
)
        diagnostics = (diagnostics) + (body_result.diagnostics)
        lifetime_regions = (lifetime_regions) + (body_result.lifetime_regions)
        current_lines = (current_lines) + (body_result.lines)
        current_allocas = body_result.allocas
        current_locals = base_locals
        current_temp = body_result.temp_index
        current_block_counter = body_result.block_counter
        current_next_local = body_result.next_local_id
        current_next_region = body_result.next_lifetime_region_id
        collected_mutations = (collected_mutations) + (body_result.mutations)
        collected_string_constants = merge_string_constants(collected_string_constants, body_result.string_constants)
        arm_mutations_list = append_match_arm_mutations(
arm_mutations_list,
MatchArmMutations(mutations=body_result.mutations, label=body_labels[index], terminated=body_result.terminated)
)
        if not body_result.terminated:
            merged_bindings = merge_parameter_bindings(merged_bindings, body_result.bindings)
            current_lines = append_string(current_lines, "  br label %" + merge_label)
            all_terminated = False
        else:
            all_terminated = all_terminated  and  True
        index += 1
    match_exhaustive = has_unconditional_default
    if not match_exhaustive  and  not has_guarded_cases:
        if subject_enum_info != None:
            match_exhaustive = len(matched_enum_tags) == len(subject_enum_info.variants)
        else:
            if len(union_payload_types) > 0:
                match_exhaustive = len(matched_union_variants) == len(union_payload_types)
    terminated = all_terminated  and  match_exhaustive
    current_lines = append_string(current_lines, merge_label + ":")
    if terminated:
        current_lines = append_string(current_lines, "  unreachable")
    else:
        phi_result = emit_phi_merges_for_match(
arm_mutations_list,
current_locals,
preloaded_locals,
current_lines,
current_temp
)
        current_lines = phi_result.lines
        current_temp = phi_result.temp_index
    result_string_constants = collected_string_constants
    return BlockLoweringResult(lines=current_lines, allocas=current_allocas, locals=current_locals, bindings=merged_bindings, temp_index=current_temp, block_counter=current_block_counter, diagnostics=diagnostics, terminated=terminated, next_local_id=current_next_local, lifetime_regions=lifetime_regions, next_lifetime_region_id=current_next_region, next_index=structure.end_index + 1, mutations=collected_mutations, string_constants=result_string_constants)

def lower_match_case_condition(function_name, subject_operand, case, bindings, locals, temp_index, lines, functions, context):
    diagnostics = []
    current_lines = lines
    current_temp = temp_index
    condition_operand = None
    field_bindings = []
    matched_enum_info = None
    matched_variant_info = None
    union_variant_index = -1
    union_struct_info = None
    union_struct_bindings = []
    collected_string_constants = empty_string_constant_set()
    if not case.is_default:
        enum_parse = parse_enum_literal(case.pattern)
        if enum_parse.recognized  and  enum_parse.success:
            enum_info = resolve_enum_info_for_literal(context, enum_parse.enum_name)
            if enum_info == None:
                diagnostics = append_string(diagnostics, "llvm lowering: match pattern references unknown enum `" + enum_parse.enum_name + "`")
            else:
                variant_info = resolve_enum_variant_info(enum_info, enum_parse.variant_name)
                if variant_info == None:
                    diagnostics = append_string(diagnostics, "llvm lowering: enum `" + enum_parse.enum_name + "` has no variant `" + enum_parse.variant_name + "`")
                else:
                    tag_llvm_type = "i32"
                    if enum_info.tag_type == "i8":
                        tag_llvm_type = "i8"
                    if enum_info.tag_type == "i16":
                        tag_llvm_type = "i16"
                    if enum_info.tag_type == "i32":
                        tag_llvm_type = "i32"
                    if enum_info.tag_type == "i64":
                        tag_llvm_type = "i64"
                    tag_temp = format_temp_name(current_temp)
                    current_temp += 1
                    current_lines = append_string(current_lines, "  " + tag_temp + " = extractvalue " + subject_operand.llvm_type + " " + subject_operand.value + ", 0")
                    tag_operand = LLVMOperand(llvm_type=tag_llvm_type, value=tag_temp)
                    variant_tag_operand = LLVMOperand(llvm_type=tag_llvm_type, value=number_to_string(variant_info.tag))
                    comparison = emit_comparison_instruction("==", tag_operand, variant_tag_operand, current_temp, current_lines)
                    diagnostics = (diagnostics) + (comparison.diagnostics)
                    current_lines = comparison.lines
                    current_temp = comparison.temp_index
                    condition_operand = comparison.operand
                    if len(variant_info.fields) > 0:
                        field_idx = 0
                        while True:
                            if field_idx >= len(enum_parse.fields):
                                break
                            pattern_field = enum_parse.fields[field_idx]
                            variant_field_idx = 0
                            found_field = None
                            while True:
                                if variant_field_idx >= len(variant_info.fields):
                                    break
                                if variant_info.fields[variant_field_idx].name == pattern_field.name:
                                    found_field = variant_info.fields[variant_field_idx]
                                    break
                                variant_field_idx += 1
                            if found_field != None:
                                field_bindings = (field_bindings) + ([MatchFieldBinding(field_name=pattern_field.name, field_type=found_field.llvm_type, field_offset=found_field.offset)])
                            else:
                                diagnostics = append_string(diagnostics, "llvm lowering: match pattern field `" + pattern_field.name + "` not found in variant `" + enum_parse.enum_name + "." + enum_parse.variant_name + "`")
                            field_idx += 1
                        matched_enum_info = enum_info
                        matched_variant_info = variant_info
        else:
            if is_union_llvm_type(subject_operand.llvm_type):
                union_parts = parse_union_payload_types(subject_operand.llvm_type)
                struct_parse = parse_struct_pattern(case.pattern)
                if struct_parse.recognized  and  struct_parse.success:
                    info = find_struct_info_by_name(context, struct_parse.type_name)
                    if info != None:
                        idx = 0
                        found_index = -1
                        while True:
                            if idx >= len(union_parts):
                                break
                            part = union_parts[idx]
                            if part == info.llvm_name + "*"  or  part == info.llvm_name:
                                found_index = idx
                                break
                            idx += 1
                        if found_index >= 0:
                            tag_temp = format_temp_name(current_temp)
                            current_temp += 1
                            current_lines = append_string(current_lines, "  " + tag_temp + " = extractvalue " + subject_operand.llvm_type + " " + subject_operand.value + ", 0")
                            tag_operand = LLVMOperand(llvm_type="i32", value=tag_temp)
                            expected_tag = LLVMOperand(llvm_type="i32", value=number_to_string(found_index))
                            comparison = emit_comparison_instruction("==", tag_operand, expected_tag, current_temp, current_lines)
                            diagnostics = (diagnostics) + (comparison.diagnostics)
                            current_lines = comparison.lines
                            current_temp = comparison.temp_index
                            condition_operand = comparison.operand
                            fidx = 0
                            while True:
                                if fidx >= len(struct_parse.fields):
                                    break
                                pattern_field = struct_parse.fields[fidx]
                                if len(pattern_field.value) == 0:
                                    sfi = 0
                                    field_info = None
                                    while True:
                                        if sfi >= len(info.fields):
                                            break
                                        if info.fields[sfi].name == pattern_field.name:
                                            field_info = info.fields[sfi]
                                            break
                                        sfi += 1
                                    if field_info != None:
                                        union_struct_bindings = (union_struct_bindings) + ([MatchStructFieldBinding(field_name=pattern_field.name, field_type=field_info.llvm_type, field_index=field_info.index)])
                                    else:
                                        diagnostics = append_string(diagnostics, "llvm lowering: match pattern field `" + pattern_field.name + "` not found in struct `" + struct_parse.type_name + "`")
                                else:
                                    diagnostics = append_string(diagnostics, "llvm lowering: match struct field literal patterns are not supported for `" + pattern_field.name + "`")
                                fidx += 1
                            union_variant_index = found_index
                            union_struct_info = info
                        else:
                            diagnostics = append_string(diagnostics, "llvm lowering: match struct pattern `" + struct_parse.type_name + "` does not match union type `" + subject_operand.llvm_type + "`")
                    else:
                        diagnostics = append_string(diagnostics, "llvm lowering: match pattern references unknown struct `" + struct_parse.type_name + "`")
            if condition_operand == None:
                pattern_result = lower_expression(case.pattern, bindings, locals, current_temp, current_lines, functions, context, "")
                diagnostics = (diagnostics) + (pattern_result.diagnostics)
                current_lines = pattern_result.lines
                current_temp = pattern_result.temp_index
                collected_string_constants = merge_string_constants(collected_string_constants, pattern_result.string_constants)
                if pattern_result.operand != None:
                    harmonised = harmonise_operands(subject_operand, pattern_result.operand, current_temp, current_lines)
                    diagnostics = (diagnostics) + (harmonised.diagnostics)
                    if harmonised.left != None  and  harmonised.right != None:
                        current_lines = harmonised.lines
                        current_temp = harmonised.temp_index
                        comparison = emit_comparison_instruction("==", harmonised.left, harmonised.right, current_temp, current_lines)
                        diagnostics = (diagnostics) + (comparison.diagnostics)
                        current_lines = comparison.lines
                        current_temp = comparison.temp_index
                        condition_operand = comparison.operand
                    else:
                        current_lines = harmonised.lines
                        current_temp = harmonised.temp_index
                else:
                    diagnostics = append_string(diagnostics, "llvm lowering: unable to lower match case pattern in `" + function_name + "`")
    if case.guard != None:
        guard_text = trim_text(case.guard)
        if len(guard_text) > 0:
            guard_condition = lower_condition_to_i1(function_name, guard_text, bindings, locals, current_temp, current_lines, functions, context)
            diagnostics = (diagnostics) + (guard_condition.diagnostics)
            current_lines = guard_condition.lines
            current_temp = guard_condition.temp_index
            collected_string_constants = merge_string_constants(collected_string_constants, guard_condition.string_constants)
            if guard_condition.operand != None:
                if condition_operand == None:
                    condition_operand = guard_condition.operand
                else:
                    merged = emit_boolean_and(condition_operand, guard_condition.operand, current_temp, current_lines)
                    diagnostics = (diagnostics) + (merged.diagnostics)
                    current_lines = merged.lines
                    current_temp = merged.temp_index
                    condition_operand = merged.operand
            else:
                diagnostics = append_string(diagnostics, "llvm lowering: unable to lower guard in match case for `" + function_name + "`")
    is_unconditional_default = False
    if case.is_default:
        if case.guard == None:
            is_unconditional_default = True
        else:
            guard_trimmed = trim_text(case.guard)
            if len(guard_trimmed) == 0:
                is_unconditional_default = True
    return MatchCaseCondition(lines=current_lines, temp_index=current_temp, operand=condition_operand, diagnostics=diagnostics, is_default=is_unconditional_default, field_bindings=field_bindings, enum_info=matched_enum_info, variant_info=matched_variant_info, union_variant_index=union_variant_index, union_struct_info=union_struct_info, union_struct_bindings=union_struct_bindings, string_constants=collected_string_constants)

def allocate_block_label(prefix, counter):
    return BlockLabelResult(label=prefix + number_to_string(counter), next_counter=counter + 1)

def lower_condition_to_i1(function_name, expression, bindings, locals, temp_index, lines, functions, context):
    diagnostics = detect_suspension_conflicts(expression, locals, bindings, function_name, None)
    lowered = lower_expression(expression, bindings, locals, temp_index, lines, functions, context, "")
    diagnostics = (diagnostics) + (lowered.diagnostics)
    current_lines = lowered.lines
    current_temp = lowered.temp_index
    string_constants = lowered.string_constants
    if lowered.operand == None:
        rendered_condition = trim_text(expression)
        if len(rendered_condition) == 0:
            diagnostics = append_string(diagnostics, "llvm lowering: condition produced no value in `" + function_name + "`")
        else:
            diagnostics = append_string(diagnostics, "llvm lowering: condition produced no value in `" + function_name + "` for `" + rendered_condition + "`")
        return ConditionConversion(lines=current_lines, temp_index=current_temp, operand=None, diagnostics=diagnostics, string_constants=string_constants)
    operand = lowered.operand
    if operand.llvm_type == "i1":
        return ConditionConversion(lines=current_lines, temp_index=current_temp, operand=operand, diagnostics=diagnostics, string_constants=string_constants)
    if operand.llvm_type == "double":
        temp_name = format_temp_name(current_temp)
        current_lines = append_string(current_lines, "  " + temp_name + " = fcmp one double " + operand.value + ", 0.0")
        converted = LLVMOperand(llvm_type="i1", value=temp_name)
        return ConditionConversion(lines=current_lines, temp_index=current_temp + 1, operand=converted, diagnostics=diagnostics, string_constants=string_constants)
    if operand.llvm_type == "i32"  or  operand.llvm_type == "i64":
        temp_name = format_temp_name(current_temp)
        current_lines = append_string(current_lines, "  " + temp_name + " = icmp ne " + operand.llvm_type + " " + operand.value + ", " + default_return_literal(operand.llvm_type) + "")
        converted = LLVMOperand(llvm_type="i1", value=temp_name)
        return ConditionConversion(lines=current_lines, temp_index=current_temp + 1, operand=converted, diagnostics=diagnostics, string_constants=string_constants)
    diagnostics = append_string(diagnostics, "llvm lowering: unsupported condition type `" + operand.llvm_type + "` in `" + function_name + "`")
    return ConditionConversion(lines=current_lines, temp_index=current_temp, operand=None, diagnostics=diagnostics, string_constants=string_constants)

def lower_if_instruction(function, start_index, llvm_return, bindings, locals, allocas, lines, temp_index, block_counter, next_local_id, next_region_id, functions, loop_stack, end, context, scope_id, scope_depth, current_label):
    current_lines = lines
    current_allocas = allocas
    current_locals = locals
    current_temp = temp_index
    current_block_counter = block_counter
    current_next_local = next_local_id
    diagnostics = []
    base_bindings = bindings
    then_bindings = base_bindings
    else_bindings = base_bindings
    lifetime_regions = []
    current_next_region = next_region_id
    collected_mutations = []
    structure = collect_if_structure(function.instructions, start_index, end, function.name)
    diagnostics = (diagnostics) + (structure.diagnostics)
    rendered_condition_source = trim_text(function.instructions[start_index].condition)
    sanitized_condition_source = sanitize_if_condition_text(rendered_condition_source)
    condition = lower_condition_to_i1(
function.name,
sanitized_condition_source,
bindings,
current_locals,
current_temp,
current_lines,
functions,
context
)
    diagnostics = (diagnostics) + (condition.diagnostics)
    current_lines = condition.lines
    current_temp = condition.temp_index
    collected_string_constants = condition.string_constants
    if condition.operand == None:
        rendered_condition = sanitized_condition_source
        if len(rendered_condition) == 0:
            diagnostics = append_string(diagnostics, "llvm lowering: unable to lower if condition in `" + function.name + "`")
        else:
            diagnostics = append_string(diagnostics, "llvm lowering: unable to lower if condition in `" + function.name + "` for `" + rendered_condition + "`")
        return BlockLoweringResult(lines=current_lines, allocas=current_allocas, locals=current_locals, bindings=base_bindings, temp_index=current_temp, block_counter=current_block_counter, diagnostics=diagnostics, terminated=False, next_local_id=current_next_local, lifetime_regions=lifetime_regions, next_lifetime_region_id=current_next_region, next_index=structure.next_index + 1, mutations=[], string_constants=collected_string_constants)
    then_label_alloc = allocate_block_label("then", current_block_counter)
    then_label = then_label_alloc.label
    current_block_counter = then_label_alloc.next_counter
    else_label = ""
    if structure.has_else:
        else_alloc = allocate_block_label("else", current_block_counter)
        else_label = else_alloc.label
        current_block_counter = else_alloc.next_counter
    merge_alloc = allocate_block_label("merge", current_block_counter)
    merge_label = merge_alloc.label
    current_block_counter = merge_alloc.next_counter
    false_target = merge_label
    if structure.has_else:
        false_target = else_label
    preloaded_locals = []
    preload_index = 0
    while True:
        if preload_index >= len(current_locals):
            break
        local = current_locals[preload_index]
        preload_temp = format_temp_name(current_temp)
        current_temp += 1
        preload_line = "  " + preload_temp + " = load " + local.llvm_type + ", " + local.llvm_type + "* " + local.pointer
        current_lines = append_string(current_lines, preload_line)
        preloaded_locals = append_string(preloaded_locals, preload_temp)
        preload_index += 1
    current_lines = append_string(current_lines, "  br i1 " + condition.operand.value + ", label %" + then_label + ", label %" + false_target)
    branch_label = find_last_label(current_lines, current_label)
    base_locals = current_locals
    base_allocas = current_allocas
    base_temp = current_temp
    base_local_id = current_next_local
    base_block_counter = current_block_counter
    current_lines = append_string(current_lines, then_label + ":")
    then_scope_id = make_child_scope_id(scope_id, then_label)
    then_result = lower_instruction_range(
function,
structure.then_start,
structure.then_end,
llvm_return,
bindings,
base_locals,
base_allocas,
[],
base_temp,
base_block_counter,
base_local_id,
current_next_region,
functions,
loop_stack,
context,
then_scope_id,
scope_depth + 1,
then_label
)
    diagnostics = (diagnostics) + (then_result.diagnostics)
    lifetime_regions = (lifetime_regions) + (then_result.lifetime_regions)
    current_allocas = then_result.allocas
    current_locals = then_result.locals
    current_temp = then_result.temp_index
    current_block_counter = then_result.block_counter
    current_next_local = then_result.next_local_id
    then_bindings = then_result.bindings
    current_next_region = then_result.next_lifetime_region_id
    current_lines = (current_lines) + (then_result.lines)
    then_exit_label = find_last_label(current_lines, then_label)
    then_mutations = retarget_recent_mutations(then_result.mutations, 0, then_exit_label)
    if not then_result.terminated  and  len(then_mutations) > 0:
        materialized_then = materialize_mutation_values_at_exit(then_mutations, base_locals, current_lines, current_temp)
        current_lines = materialized_then.lines
        current_temp = materialized_then.temp_index
        then_mutations = materialized_then.mutations
    collected_mutations = (collected_mutations) + (then_mutations)
    collected_string_constants = merge_string_constants(collected_string_constants, then_result.string_constants)
    then_terminated = then_result.terminated
    if not then_terminated:
        current_lines = append_string(current_lines, "  br label %" + merge_label)
    else_terminated = False
    else_mutations = []
    else_exit_label = else_label
    if structure.has_else:
        current_lines = append_string(current_lines, else_label + ":")
        else_scope_id = make_child_scope_id(scope_id, else_label)
        else_result = lower_instruction_range(
function,
structure.else_start,
structure.else_end,
llvm_return,
bindings,
base_locals,
current_allocas,
[],
current_temp,
current_block_counter,
current_next_local,
current_next_region,
functions,
loop_stack,
context,
else_scope_id,
scope_depth + 1,
else_label
)
        diagnostics = (diagnostics) + (else_result.diagnostics)
        lifetime_regions = (lifetime_regions) + (else_result.lifetime_regions)
        current_allocas = else_result.allocas
        current_locals = else_result.locals
        current_temp = else_result.temp_index
        current_block_counter = else_result.block_counter
        current_next_local = else_result.next_local_id
        else_bindings = else_result.bindings
        current_next_region = else_result.next_lifetime_region_id
        current_lines = (current_lines) + (else_result.lines)
        else_terminated = else_result.terminated
        exit_label = find_last_label(current_lines, else_label)
        else_exit_label = exit_label
        branch_mutations = retarget_recent_mutations(else_result.mutations, 0, exit_label)
        if not else_terminated  and  len(branch_mutations) > 0:
            materialized_else = materialize_mutation_values_at_exit(branch_mutations, base_locals, current_lines, current_temp)
            current_lines = materialized_else.lines
            current_temp = materialized_else.temp_index
            branch_mutations = materialized_else.mutations
        else_mutations = branch_mutations
        collected_mutations = (collected_mutations) + (else_mutations)
        collected_string_constants = merge_string_constants(collected_string_constants, else_result.string_constants)
        if not else_terminated:
            current_lines = append_string(current_lines, "  br label %" + merge_label)
    terminated = False
    if structure.has_else:
        terminated = then_terminated  and  else_terminated
    if not terminated  or  not structure.has_else:
        current_lines = append_string(current_lines, merge_label + ":")
        if structure.has_else:
            if not then_terminated  or  not else_terminated  and  len(collected_mutations) > 0:
                phi_result = emit_phi_merges_for_if_else(
then_mutations,
else_mutations,
base_locals,
preloaded_locals,
then_label,
else_label,
then_exit_label,
else_exit_label,
then_terminated,
else_terminated,
current_lines,
current_temp
)
                current_lines = phi_result.lines
                current_temp = phi_result.temp_index
        else:
            if not then_terminated  and  len(collected_mutations) > 0:
                phi_result = emit_phi_merges_for_straight_if(
collected_mutations,
base_locals,
preloaded_locals,
branch_label,
then_label,
current_lines,
current_temp
)
                current_lines = phi_result.lines
                current_temp = phi_result.temp_index
    current_locals = base_locals
    merged_bindings = base_bindings
    if not then_terminated:
        merged_bindings = merge_parameter_bindings(merged_bindings, then_bindings)
    if structure.has_else:
        if not else_terminated:
            merged_bindings = merge_parameter_bindings(merged_bindings, else_bindings)
    return BlockLoweringResult(lines=current_lines, allocas=current_allocas, locals=current_locals, bindings=merged_bindings, temp_index=current_temp, block_counter=current_block_counter, diagnostics=diagnostics, terminated=terminated, next_local_id=current_next_local, lifetime_regions=lifetime_regions, next_lifetime_region_id=current_next_region, next_index=structure.next_index + 1, mutations=collected_mutations, string_constants=collected_string_constants)

def sanitize_if_condition_text(condition):
    trimmed = trim_text(condition)
    if len(trimmed) == 0:
        return trimmed
    if starts_with(trimmed, "{"):
        return trimmed
    paren_depth = 0
    bracket_depth = 0
    brace_depth = 0
    in_string = False
    escape_next = False
    index = 0
    while True:
        if index >= len(trimmed):
            break
        ch = substring(trimmed, index, index + 1)
        if in_string:
            if escape_next:
                escape_next = False
                index += 1
                continue
            if ch == "\\":
                escape_next = True
                index += 1
                continue
            if ch == "\"":
                in_string = False
            index += 1
            continue
        if ch == "\"":
            in_string = True
            index += 1
            continue
        if ch == "(":
            paren_depth += 1
            index += 1
            continue
        if ch == ")":
            if paren_depth > 0:
                paren_depth -= 1
            index += 1
            continue
        if ch == "[":
            bracket_depth += 1
            index += 1
            continue
        if ch == "]":
            if bracket_depth > 0:
                bracket_depth -= 1
            index += 1
            continue
        if ch == "{":
            if paren_depth == 0  and  bracket_depth == 0  and  brace_depth == 0  and  index > 0:
                return trim_text(substring(trimmed, 0, index))
            brace_depth += 1
            index += 1
            continue
        if ch == "}":
            if brace_depth > 0:
                brace_depth -= 1
            index += 1
            continue
        index += 1
    return trimmed

def lower_let_instruction(function, instruction, bindings, locals, allocas, lines, temp_index, next_local_id, next_region_id, functions, context, scope_id, scope_depth, current_label):
    diagnostics = []
    current_lines = lines
    current_allocas = allocas
    current_locals = locals
    current_temp = temp_index
    current_bindings = bindings
    ownership = None
    consumption = None
    initializer_span = instruction.value_span
    lifetime_regions = []
    lifetime_releases = []
    current_next_region = next_region_id
    mutations = []
    if initializer_span == None:
        initializer_span = instruction.span
    suspension_diagnostics = detect_suspension_conflicts(instruction.value, current_locals, current_bindings, function.name, initializer_span)
    diagnostics = (diagnostics) + (suspension_diagnostics)
    existing_binding = find_local_binding(current_locals, instruction.name)
    if existing_binding != None:
        previous_ownership = existing_binding.ownership
        if previous_ownership != None:
            if previous_ownership.variant == "Borrow":
                if previous_ownership.region_id >= 0:
                    release_event = LifetimeReleaseEvent(region_id=previous_ownership.region_id, scope_id=scope_id, scope_depth=scope_depth)
                    lifetime_releases = append_lifetime_release_event(lifetime_releases, release_event)
    trimmed_annotation = trim_text(instruction.type_annotation)
    llvm_type = ""
    if len(trimmed_annotation) > 0:
        llvm_type = map_local_type(context, instruction.type_annotation)
        if len(llvm_type) == 0:
            diagnostics = append_string(diagnostics, "llvm lowering: unsupported local type for `" + instruction.name + "` in `" + function.name + "`")
    operand = None
    ownership_analysis = analyze_value_ownership(instruction.value, initializer_span, current_locals, current_bindings)
    diagnostics = (diagnostics) + (ownership_analysis.diagnostics)
    ownership = ownership_analysis.ownership
    consumption = ownership_analysis.consumption
    if ownership != None:
        conflict_diagnostics = detect_borrow_conflicts(ownership, current_locals, instruction.name, function.name)
        diagnostics = (diagnostics) + (conflict_diagnostics)
        if ownership.variant == "Borrow":
            base_scope = infer_borrow_base_scope(ownership.base, current_locals, current_bindings, function.name)
            region_id = current_next_region
            current_next_region += 1
            ownership = OwnershipInfo(variant=ownership.variant, base=ownership.base, mutable=ownership.mutable, span=ownership.span, region_id=region_id)
            region = make_lifetime_region_metadata(region_id, instruction.name, ownership, scope_id, scope_depth, base_scope.scope_id, base_scope.scope_depth)
            lifetime_regions = append_lifetime_region(lifetime_regions, region)
        else:
            ownership = OwnershipInfo(variant=ownership.variant, base=ownership.base, mutable=ownership.mutable, span=ownership.span, region_id=-1)
    if consumption != None:
        if consumption.kind == "local":
            current_locals = mark_local_consumed(current_locals, consumption.name)
        else:
            if consumption.kind == "parameter":
                current_bindings = mark_parameter_consumed(current_bindings, consumption.name)
    string_constants = empty_string_constant_set()
    if instruction.value == None  or  len(instruction.value) == 0:
        diagnostics = append_string(diagnostics, "llvm lowering: let `" + instruction.name + "` missing initializer in `" + function.name + "`")
    else:
        lowered = lower_expression(instruction.value, current_bindings, current_locals, current_temp, current_lines, functions, context, llvm_type)
        diagnostics = (diagnostics) + (lowered.diagnostics)
        current_lines = lowered.lines
        current_temp = lowered.temp_index
        operand = lowered.operand
        string_constants = lowered.string_constants
    if len(llvm_type) == 0:
        if operand != None:
            llvm_type = operand.llvm_type
    if len(llvm_type) == 0:
        llvm_type = "double"
    interface_info = find_interface_info_by_name(context, instruction.type_annotation)
    if interface_info != None  and  operand != None:
        struct_info = find_struct_info_by_llvm_type(context, operand.llvm_type)
        if struct_info != None:
            vtable = find_vtable_for_struct_interface(context, struct_info.name, interface_info.name)
            if vtable != None:
                struct_ptr_temp = "%t" + number_to_string(current_temp)
                current_temp += 1
                vtable_ptr_temp = "%t" + number_to_string(current_temp)
                current_temp += 1
                data_ptr_temp = "%t" + number_to_string(current_temp)
                current_temp += 1
                with_data_temp = "%t" + number_to_string(current_temp)
                current_temp += 1
                with_vtable_temp = "%t" + number_to_string(current_temp)
                current_temp += 1
                current_lines = append_string(current_lines, "  " + struct_ptr_temp + " = alloca " + struct_info.llvm_name)
                current_lines = append_string(current_lines, "  store " + operand.llvm_type + " " + operand.value + ", " + operand.llvm_type + "* " + struct_ptr_temp)
                current_lines = append_string(current_lines, "  " + data_ptr_temp + " = bitcast " + struct_info.llvm_name + "* " + struct_ptr_temp + " to i8*")
                current_lines = append_string(current_lines, "  " + vtable_ptr_temp + " = bitcast " + vtable.llvm_type_name + "* " + vtable.llvm_global_name + " to i8*")
                current_lines = append_string(current_lines, "  " + with_data_temp + " = insertvalue " + interface_info.llvm_name + " undef, i8* " + data_ptr_temp + ", 0")
                current_lines = append_string(current_lines, "  " + with_vtable_temp + " = insertvalue " + interface_info.llvm_name + " " + with_data_temp + ", i8* " + vtable_ptr_temp + ", 1")
                operand = LLVMOperand(llvm_type=interface_info.llvm_name, value=with_vtable_temp)
                llvm_type = interface_info.llvm_name
            else:
                diagnostics = append_string(diagnostics, "llvm lowering: struct `" + struct_info.name + "` does not implement interface `" + interface_info.name + "`")
    pointer = format_local_pointer_name(next_local_id)
    current_allocas = append_string(current_allocas, "  " + pointer + " = alloca " + llvm_type)
    stored_value = default_return_literal(llvm_type)
    if operand != None:
        coerced = coerce_operand_to_type(operand, llvm_type, current_temp, current_lines)
        diagnostics = (diagnostics) + (coerced.diagnostics)
        current_lines = coerced.lines
        current_temp = coerced.temp_index
        if coerced.operand == None:
            diagnostics = append_string(diagnostics, "llvm lowering: unable to coerce initializer for `" + instruction.name + "` to `" + llvm_type + "`")
            current_lines = append_string(current_lines, "  store " + llvm_type + " " + default_return_literal(llvm_type) + ", " + llvm_type + "* " + pointer)
        else:
            stored = coerced.operand
            stored_value = stored.value
            current_lines = append_string(current_lines, "  store " + llvm_type + " " + stored.value + ", " + llvm_type + "* " + pointer)
    else:
        current_lines = append_string(current_lines, "  store " + llvm_type + " " + default_return_literal(llvm_type) + ", " + llvm_type + "* " + pointer)
    current_locals = append_local_binding(current_locals, LocalBinding(name=instruction.name, pointer=pointer, llvm_type=llvm_type, type_annotation=instruction.type_annotation, ownership=ownership, consumed=False, scope_id=scope_id, scope_depth=scope_depth))
    mutation = LocalMutation(name=instruction.name, llvm_type=llvm_type, value_name=stored_value, span=initializer_span, originating_label=current_label)
    mutations = (mutations) + ([mutation])
    return LetLoweringResult(lines=current_lines, allocas=current_allocas, locals=current_locals, bindings=current_bindings, temp_index=current_temp, diagnostics=diagnostics, next_local_id=next_local_id + 1, lifetime_regions=lifetime_regions, lifetime_releases=lifetime_releases, next_region_id=current_next_region, mutations=mutations, string_constants=string_constants)
