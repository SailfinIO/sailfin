import asyncio
from runtime import runtime_support as runtime

from ...native_ir import NativeParameter
from ..types import TypeContext
from ...string_utils import substring, find_last_index_of_char
from ..utils import append_string
from compiler.build.llvm.expression_lowering_stage2.core_type_mapping_stage2 import map_parameter_type, map_struct_type_annotation_ctx

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

def collect_parameter_types(context, parameters, function_name):
    types = []
    index = 0
    while True:
        if index >= len(parameters):
            break
        parameter = parameters[index]
        llvm_type = map_parameter_type(context, parameter.type_annotation)
        if len(parameter.type_annotation) == 0  and  parameter.name == "self"  and  index == 0:
            double_colon_pos = find_last_index_of_char(function_name, ":")
            if double_colon_pos > 0  and  substring(function_name, double_colon_pos - 1, double_colon_pos + 1) == "::":
                struct_name = substring(function_name, 0, double_colon_pos - 1)
                struct_type = map_struct_type_annotation_ctx(context, struct_name)
                if len(struct_type) > 0:
                    llvm_type = struct_type + "*"
        if len(llvm_type) == 0:
            types = append_string(types, "double")
        else:
            types = append_string(types, llvm_type)
        index += 1
    return types

def operation_name_for_symbol(symbol, llvm_type):
    if llvm_type == "double":
        if symbol == "+":
            return "fadd"
        if symbol == "-":
            return "fsub"
        if symbol == "*":
            return "fmul"
        if symbol == "/":
            return "fdiv"
        if symbol == "%":
            return "frem"
    if symbol == "+":
        return "add"
    if symbol == "-":
        return "sub"
    if symbol == "*":
        return "mul"
    if symbol == "/":
        return "sdiv"
    if symbol == "%":
        return "srem"
    return "add"

__all__ = ["collect_parameter_types", "operation_name_for_symbol"]
