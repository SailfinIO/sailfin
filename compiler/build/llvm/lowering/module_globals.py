import asyncio
from runtime import runtime_support as runtime

from ...native_ir import NativeBinding, NativeFunction
from ..types import TypeContext, LocalBinding, ParameterBinding, ModuleGlobalLoweringResult, StringConstant
from ..utils import append_string, trim_text, number_to_string, matches_case_insensitive, is_number_literal, is_integer_literal, is_boolean_literal, sanitize_symbol
from ..expressions import is_string_literal, normalise_number_literal, default_return_literal
from ..strings import empty_string_constant_set, merge_string_constants
from ..type_mapping import map_local_type
from ..expression_lowering_stage2 import lower_expression, coerce_operand_to_type, append_local_binding, find_local_binding
from ..lifetime import format_root_scope_id

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

def module_global_symbol(name):
    return "@global." + sanitize_symbol(name)

def module_init_symbol(module_name):
    return "@sailfin_module_init__" + sanitize_symbol(module_name)

def module_user_main_symbol(module_name):
    return "sailfin_user_main__" + sanitize_symbol(module_name)

def lower_module_bindings_to_globals(bindings, context, module_name):
    diagnostics = []
    preamble_lines = []
    init_lines = []
    locals = []
    collected_string_constants = empty_string_constant_set()
    init_symbol = module_init_symbol(module_name)
    needs_init = False
    if len(bindings) == 0:
        return ModuleGlobalLoweringResult(preamble_lines=[], init_function_lines=[], init_function_symbol=init_symbol, needs_init_call=False, locals=[], string_constants=collected_string_constants, diagnostics=[])
    scope_id = format_root_scope_id("module")
    scope_depth = 0
    index = 0
    while True:
        if index >= len(bindings):
            break
        binding = bindings[index]
        type_annotation = trim_text(binding.type_annotation)
        effective_type_annotation = binding.type_annotation
        if len(type_annotation) == 0  and  binding.value != None:
            init_expr = trim_text(binding.value)
            if is_string_literal(init_expr):
                type_annotation = "string"
                effective_type_annotation = "string"
        if len(type_annotation) == 0:
            index += 1
            continue
        name = binding.name
        global_name = module_global_symbol(name)
        llvm_type = ""
        if len(type_annotation) > 0:
            llvm_type = map_local_type(context, type_annotation)
        if len(llvm_type) == 0:
            diagnostics = append_string(diagnostics, "llvm lowering: module binding `" + name + "` has unsupported type annotation `" + effective_type_annotation + "`")
            llvm_type = "double"
        if llvm_type == "i8*":
            preamble_lines = append_string(preamble_lines, global_name + " = global i8* null")
            if binding.value != None:
                needs_init = True
        else:
            initializer_text = default_return_literal(llvm_type)
            if binding.value != None:
                init_expr = trim_text(binding.value)
                if llvm_type == "double"  and  is_number_literal(init_expr):
                    initializer_text = normalise_number_literal(init_expr)
                else:
                    if llvm_type == "i64"  and  is_integer_literal(init_expr):
                        initializer_text = init_expr
                    else:
                        if llvm_type == "i32"  and  is_integer_literal(init_expr):
                            initializer_text = init_expr
                        else:
                            if llvm_type == "i1"  and  is_boolean_literal(init_expr):
                                initializer_text = "0"
                                if matches_case_insensitive(init_expr, "true"):
                                    initializer_text = "1"
                            else:
                                needs_init = True
            preamble_lines = append_string(preamble_lines, global_name + " = global " + llvm_type + " " + initializer_text)
        locals = append_local_binding(locals, LocalBinding(name=name, pointer=global_name, llvm_type=llvm_type, type_annotation=effective_type_annotation, ownership=None, consumed=False, scope_id=scope_id, scope_depth=scope_depth))
        index += 1
    if not needs_init:
        return ModuleGlobalLoweringResult(preamble_lines=preamble_lines, init_function_lines=[], init_function_symbol=init_symbol, needs_init_call=False, locals=locals, string_constants=collected_string_constants, diagnostics=diagnostics)
    init_lines = (init_lines) + (["define internal void " + init_symbol + "() {", "block.entry:"])
    init_index = 0
    current_temp = 0
    current_lines = init_lines
    while True:
        if init_index >= len(bindings):
            break
        binding = bindings[init_index]
        type_annotation = trim_text(binding.type_annotation)
        if len(type_annotation) == 0  and  binding.value != None:
            init_expr = trim_text(binding.value)
            if is_string_literal(init_expr):
                type_annotation = "string"
        if len(type_annotation) == 0:
            init_index += 1
            continue
        if binding.value == None:
            init_index += 1
            continue
        name = binding.name
        global_name = module_global_symbol(name)
        local = find_local_binding(locals, name)
        if local == None:
            init_index += 1
            continue
        llvm_type = local.llvm_type
        init_expr = trim_text(binding.value)
        if llvm_type == "i8*":
            lowered = lower_expression(init_expr, [], locals, current_temp, current_lines, [], context, llvm_type)
            diagnostics = (diagnostics) + (lowered.diagnostics)
            current_lines = lowered.lines
            current_temp = lowered.temp_index
            collected_string_constants = merge_string_constants(collected_string_constants, lowered.string_constants)
            if lowered.operand != None:
                current_lines = append_string(current_lines, "  store i8* " + lowered.operand.value + ", i8** " + global_name)
            else:
                diagnostics = append_string(diagnostics, "llvm lowering: failed to initialize module string binding `" + name + "`")
        else:
            should_store = True
            if llvm_type == "double"  and  is_number_literal(init_expr):
                should_store = False
            if llvm_type == "i64"  and  is_integer_literal(init_expr):
                should_store = False
            if llvm_type == "i32"  and  is_integer_literal(init_expr):
                should_store = False
            if llvm_type == "i1"  and  is_boolean_literal(init_expr):
                should_store = False
            if should_store:
                lowered = lower_expression(init_expr, [], locals, current_temp, current_lines, [], context, llvm_type)
                diagnostics = (diagnostics) + (lowered.diagnostics)
                current_lines = lowered.lines
                current_temp = lowered.temp_index
                collected_string_constants = merge_string_constants(collected_string_constants, lowered.string_constants)
                if lowered.operand != None:
                    coerced = coerce_operand_to_type(lowered.operand, llvm_type, current_temp, current_lines)
                    diagnostics = (diagnostics) + (coerced.diagnostics)
                    current_lines = coerced.lines
                    current_temp = coerced.temp_index
                    if coerced.operand != None:
                        current_lines = append_string(current_lines, "  store " + llvm_type + " " + coerced.operand.value + ", " + llvm_type + "* " + global_name)
        init_index += 1
    current_lines = append_string(current_lines, "  ret void")
    current_lines = append_string(current_lines, "}")
    return ModuleGlobalLoweringResult(preamble_lines=preamble_lines, init_function_lines=current_lines, init_function_symbol=init_symbol, needs_init_call=True, locals=locals, string_constants=collected_string_constants, diagnostics=diagnostics)
