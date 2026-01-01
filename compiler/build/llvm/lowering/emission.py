import asyncio
from runtime import runtime_support as runtime

from ...native_ir import NativeFunction
from ..types import TypeContext, LocalBinding, ParameterBinding, LoweredLLVMFunction, LLVMOperand, StringConstant, BodyResult
from ..utils import append_string, join_with_separator, sanitize_symbol, number_to_string, matches_case_insensitive
from ..strings import empty_string_constant_set, append_string_constant, merge_string_constants
from ..type_mapping import map_return_type
from ..expression_lowering_stage2 import prepare_parameters, future_pointer_type_for_return_type, spawn_symbol_for_return_type, spawn_ctx_symbol_for_return_type, format_temp_name, append_llvm_operand
from ..expressions import default_return_literal
from ..expression_lowering_stage2 import make_string_constant_name_for_module
from ..lifetime import validate_borrow_lifetimes, format_root_scope_id
from ..rendering import should_internalize_function
from compiler.build.llvm.lowering.instructions import lower_instruction_range
from compiler.build.llvm.lowering.module_globals import module_user_main_symbol

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

def emit_llvm_function(function, functions, effects, context, module_name, entry_points, exported_symbols, imported_functions, module_globals, module_init_symbol, needs_module_init_call):
    diagnostics = []
    if function.is_async  and  not function.is_extern  and  function.name != "main":
        future_return = future_pointer_type_for_return_type(function.return_type)
        impl_return = map_return_type(context, function.return_type)
        if len(future_return) == 0  or  len(impl_return) == 0:
            diagnostics = append_string(diagnostics, "llvm lowering: async fn `" + function.name + "` has unsupported return type `" + function.return_type + "`")
            empty_constants = empty_string_constant_set()
            return LoweredLLVMFunction(lines=[], diagnostics=diagnostics, lifetime_regions=[], string_constants=empty_constants)
        impl_return_type_annotation = function.return_type
        if future_return == "%SailfinFuturePtr*":
            impl_return = "i8*"
            impl_return_type_annotation = "any"
        impl_name = function.name + "__async_impl"
        impl_function = NativeFunction(name=impl_name, is_async=False, parameters=function.parameters, return_type=impl_return_type_annotation, effects=function.effects, decorators=function.decorators, is_extern=function.is_extern, instructions=function.instructions)
        impl_lowered = emit_llvm_function(
impl_function,
functions,
effects,
context,
module_name,
entry_points,
exported_symbols,
imported_functions,
module_globals,
module_init_symbol,
needs_module_init_call
)
        diagnostics = (diagnostics) + (impl_lowered.diagnostics)
        preparation = prepare_parameters(function, context)
        diagnostics = (diagnostics) + (preparation.diagnostics)
        wrapper_lines = []
        linkage = ""
        if should_internalize_function(function, entry_points, exported_symbols, imported_functions):
            linkage = "internal "
        wrapper_symbol = sanitize_symbol(function.name)
        impl_symbol = sanitize_symbol(impl_name)
        signature = join_with_separator(preparation.signature, ", ")
        if len(signature) == 0:
            signature = ""
        if len(function.parameters) == 0:
            spawn_symbol = spawn_symbol_for_return_type(function.return_type)
            if len(spawn_symbol) == 0:
                diagnostics = append_string(diagnostics, "llvm lowering: async fn `" + function.name + "` has unsupported return type `" + function.return_type + "`")
                empty_constants = empty_string_constant_set()
                return LoweredLLVMFunction(lines=[], diagnostics=diagnostics, lifetime_regions=[], string_constants=empty_constants)
            wrapper_lines = append_string(wrapper_lines, "define " + linkage + future_return + " @" + wrapper_symbol + "(" + signature + ") {")
            wrapper_lines = append_string(wrapper_lines, "block.entry:")
            t0 = format_temp_name(0)
            wrapper_lines = append_string(wrapper_lines, "  " + t0 + " = call " + future_return + " @" + spawn_symbol + "(" + impl_return + " ()* @" + impl_symbol + ")")
            wrapper_lines = append_string(wrapper_lines, "  ret " + future_return + " " + t0)
            wrapper_lines = append_string(wrapper_lines, "}")
        else:
            spawn_symbol = spawn_ctx_symbol_for_return_type(function.return_type)
            if len(spawn_symbol) == 0:
                diagnostics = append_string(diagnostics, "llvm lowering: async fn `" + function.name + "` has unsupported return type `" + function.return_type + "`")
                empty_constants = empty_string_constant_set()
                return LoweredLLVMFunction(lines=[], diagnostics=diagnostics, lifetime_regions=[], string_constants=empty_constants)
            ctx_type = "%SailfinAsyncCtx." + wrapper_symbol
            ctx_ptr_type = ctx_type + "*"
            trampoline_symbol = wrapper_symbol + "__async_trampoline"
            param_llvm_types = []
            param_index = 0
            while True:
                if param_index >= len(preparation.bindings):
                    break
                param_llvm_types = append_string(param_llvm_types, preparation.bindings[param_index].llvm_type)
                param_index += 1
            wrapper_lines = append_string(wrapper_lines, ctx_type + " = type()")
            wrapper_lines = append_string(wrapper_lines, "")
            wrapper_lines = append_string(wrapper_lines, "define internal " + impl_return + " @" + trampoline_symbol + "(i8* %ctx_raw) {")
            wrapper_lines = append_string(wrapper_lines, "block.entry:")
            tramp_temp = 0
            tramp_ctx = format_temp_name(tramp_temp)
            tramp_temp += 1
            wrapper_lines = append_string(wrapper_lines, "  " + tramp_ctx + " = bitcast i8* %ctx_raw to " + ctx_ptr_type)
            loaded_args = []
            load_index = 0
            while True:
                if load_index >= len(preparation.bindings):
                    break
                binding = preparation.bindings[load_index]
                field_ptr = format_temp_name(tramp_temp)
                tramp_temp += 1
                wrapper_lines = append_string(wrapper_lines, "  " + field_ptr + " = getelementptr inbounds " + ctx_type + ", " + ctx_ptr_type + " " + tramp_ctx + ", i32 0, i32 " + number_to_string(load_index))
                loaded = format_temp_name(tramp_temp)
                tramp_temp += 1
                wrapper_lines = append_string(wrapper_lines, "  " + loaded + " = load " + binding.llvm_type + ", " + binding.llvm_type + "* " + field_ptr)
                loaded_args = append_llvm_operand(loaded_args, LLVMOperand(llvm_type=binding.llvm_type, value=loaded))
                load_index += 1
            arg_texts = []
            arg_i = 0
            while True:
                if arg_i >= len(loaded_args):
                    break
                arg_texts = append_string(arg_texts, loaded_args[arg_i].llvm_type + " " + loaded_args[arg_i].value)
                arg_i += 1
            call_args = join_with_separator(arg_texts, ", ")
            if impl_return == "void":
                wrapper_lines = append_string(wrapper_lines, "  call void @" + impl_symbol + "(" + call_args + ")")
                wrapper_lines = append_string(wrapper_lines, "  call void @free(i8* %ctx_raw)")
                wrapper_lines = append_string(wrapper_lines, "  ret void")
            else:
                tramp_result = format_temp_name(tramp_temp)
                tramp_temp += 1
                wrapper_lines = append_string(wrapper_lines, "  " + tramp_result + " = call " + impl_return + " @" + impl_symbol + "(" + call_args + ")")
                wrapper_lines = append_string(wrapper_lines, "  call void @free(i8* %ctx_raw)")
                wrapper_lines = append_string(wrapper_lines, "  ret " + impl_return + " " + tramp_result)
            wrapper_lines = append_string(wrapper_lines, "}")
            wrapper_lines = append_string(wrapper_lines, "")
            wrapper_lines = append_string(wrapper_lines, "define " + linkage + future_return + " @" + wrapper_symbol + "(" + signature + ") {")
            wrapper_lines = append_string(wrapper_lines, "block.entry:")
            wrap_temp = 0
            size_ptr = format_temp_name(wrap_temp)
            wrap_temp += 1
            wrapper_lines = append_string(wrapper_lines, "  " + size_ptr + " = getelementptr inbounds " + ctx_type + ", " + ctx_ptr_type + " null, i32 1")
            size_i64 = format_temp_name(wrap_temp)
            wrap_temp += 1
            wrapper_lines = append_string(wrapper_lines, "  " + size_i64 + " = ptrtoint " + ctx_ptr_type + " " + size_ptr + " to i64")
            ctx_raw = format_temp_name(wrap_temp)
            wrap_temp += 1
            wrapper_lines = append_string(wrapper_lines, "  " + ctx_raw + " = call noalias i8* @malloc(i64 " + size_i64 + ")")
            ctx_typed = format_temp_name(wrap_temp)
            wrap_temp += 1
            wrapper_lines = append_string(wrapper_lines, "  " + ctx_typed + " = bitcast i8* " + ctx_raw + " to " + ctx_ptr_type)
            store_index = 0
            while True:
                if store_index >= len(preparation.bindings):
                    break
                binding = preparation.bindings[store_index]
                field_ptr = format_temp_name(wrap_temp)
                wrap_temp += 1
                wrapper_lines = append_string(wrapper_lines, "  " + field_ptr + " = getelementptr inbounds " + ctx_type + ", " + ctx_ptr_type + " " + ctx_typed + ", i32 0, i32 " + number_to_string(store_index))
                wrapper_lines = append_string(wrapper_lines, "  store " + binding.llvm_type + " " + binding.llvm_name + ", " + binding.llvm_type + "* " + field_ptr)
                store_index += 1
            out_future = format_temp_name(wrap_temp)
            wrap_temp += 1
            wrapper_lines = append_string(wrapper_lines, "  " + out_future + " = call " + future_return + " @" + spawn_symbol + "(" + impl_return + " (i8*)* @" + trampoline_symbol + ", i8* " + ctx_raw + ")")
            wrapper_lines = append_string(wrapper_lines, "  ret " + future_return + " " + out_future)
            wrapper_lines = append_string(wrapper_lines, "}")
        merged_lines = wrapper_lines
        if len(impl_lowered.lines) > 0:
            with_spacer = (impl_lowered.lines) + ([""])
            merged_lines = (with_spacer) + (wrapper_lines)
        merged_constants = merge_string_constants(impl_lowered.string_constants, empty_string_constant_set())
        return LoweredLLVMFunction(lines=merged_lines, diagnostics=diagnostics, lifetime_regions=impl_lowered.lifetime_regions, string_constants=merged_constants)
    sanitized = sanitize_symbol(function.name)
    emit_main_wrapper = False
    llvm_return = map_return_type(context, function.return_type)
    if len(llvm_return) == 0:
        diagnostics = append_string(diagnostics, "llvm lowering: unsupported return type `" + function.return_type + "` in " + function.name)
        empty_constants = empty_string_constant_set()
        return LoweredLLVMFunction(lines=[], diagnostics=diagnostics, lifetime_regions=[], string_constants=empty_constants)
    if not function.is_extern  and  function.name == "main":
        sanitized = module_user_main_symbol(module_name)
        emit_main_wrapper = True
    preparation = prepare_parameters(function, context)
    diagnostics = (diagnostics) + (preparation.diagnostics)
    if function.is_extern:
        signature = join_with_separator(preparation.signature, ", ")
        if len(signature) == 0:
            signature = ""
        empty_constants = empty_string_constant_set()
        lines = ["declare " + llvm_return + " @" + sanitized + "(" + signature + ")"]
        return LoweredLLVMFunction(lines=lines, diagnostics=diagnostics, lifetime_regions=[], string_constants=empty_constants)
    lines = []
    if len(effects) > 0:
        lines = append_string(lines, "; fn " + function.name + " effects: ![" + join_with_separator(effects, ", ") + "]")
    signature = join_with_separator(preparation.signature, ", ")
    if len(signature) == 0:
        signature = ""
    entry_label = "block.entry"
    linkage = ""
    if should_internalize_function(function, entry_points, exported_symbols, imported_functions):
        linkage = "internal "
    lines = append_string(lines, "define " + linkage + llvm_return + " @" + sanitized + "(" + signature + ") {")
    lines = append_string(lines, entry_label + ":")
    if needs_module_init_call:
        lines = append_string(lines, "  call void " + module_init_symbol + "()")
    decorator_string_constants = empty_string_constant_set()
    decorator_index = 0
    while True:
        if decorator_index >= len(function.decorators):
            break
        decorator_name = function.decorators[decorator_index]
        if matches_case_insensitive(decorator_name, "logExecution")  or  matches_case_insensitive(decorator_name, "logexecution")  or  matches_case_insensitive(decorator_name, "trace"):
            content = function.name
            constant_name = make_string_constant_name_for_module(module_name, content)
            constant = StringConstant(name=constant_name, content=content, byte_count=len(content))
            decorator_string_constants = append_string_constant(decorator_string_constants, constant)
            array_length = len(content) + 1
            array_type = "[" + number_to_string(array_length) + " x i8]"
            call_line = "  call i8* @sailfin_runtime_log_execution(i8* getelementptr inbounds (" + array_type + ", " + array_type + "* " + constant_name + ", i32 0, i32 0))"
            lines = append_string(lines, call_line)
        decorator_index += 1
    body = emit_body(function, llvm_return, preparation.bindings, module_globals, functions, context, entry_label)
    lines = (lines) + (body.lines)
    diagnostics = (diagnostics) + (body.diagnostics)
    lifetime_diagnostics = validate_borrow_lifetimes(function, body.lifetime_regions)
    diagnostics = (diagnostics) + (lifetime_diagnostics)
    lines = append_string(lines, "}")
    if emit_main_wrapper:
        lines = (lines) + (["", "define i32 @main(i32 %argc, i8** %argv) {", "entry:", "  call void @" + sanitized + "()", "  ret i32 0", "}"])
    merged_constants = merge_string_constants(body.string_constants, decorator_string_constants)
    return LoweredLLVMFunction(lines=lines, diagnostics=diagnostics, lifetime_regions=body.lifetime_regions, string_constants=merged_constants)

def emit_body(function, llvm_return, bindings, module_globals, functions, context, entry_label):
    lowered = lower_instruction_range(
function,
0,
len(function.instructions),
llvm_return,
bindings,
module_globals,
[],
[],
0,
0,
0,
0,
functions,
[],
context,
format_root_scope_id(function.name),
0,
entry_label
)
    diagnostics = lowered.diagnostics
    lines = []
    lines = (lines) + (lowered.allocas)
    lines = (lines) + (lowered.lines)
    if not lowered.terminated:
        if llvm_return == "void":
            lines = append_string(lines, "  ret void")
        else:
            diagnostics = append_string(diagnostics, "llvm lowering: missing return in function `" + function.name + "`")
            lines = append_string(lines, "  ret " + llvm_return + " " + default_return_literal(llvm_return))
    return BodyResult(lines=lines, diagnostics=diagnostics, lifetime_regions=lowered.lifetime_regions, string_constants=lowered.string_constants)
