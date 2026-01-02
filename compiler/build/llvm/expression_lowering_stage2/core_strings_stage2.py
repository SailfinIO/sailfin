import asyncio
from runtime import runtime_support as runtime

from ..types import LLVMOperand, ExpressionResult, StringConstant
from ..utils import append_string, number_to_string
from ..strings import empty_string_constant_set, escape_string_for_llvm
from ..expressions import format_temp_name
from compiler.build.llvm.expression_lowering_stage2.core_text import unescape_string_literal
from compiler.build.llvm.expression_lowering_stage2.core_operands import harmonise_operands, coerce_operand_to_type

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

def lower_string_literal(literal, temp_index, lines):
    content = unescape_string_literal(literal)
    escaped = escape_string_for_llvm(content)
    array_length = len(content) + 1
    array_type = "[" + number_to_string(array_length) + " x i8]"
    current_lines = lines
    malloc_temp = format_temp_name(temp_index)
    current_lines = append_string(current_lines, "  " + malloc_temp + " = call i8* @malloc(i64 " + number_to_string(array_length) + ")")
    cast_temp = format_temp_name(temp_index + 1)
    current_lines = append_string(current_lines, "  " + cast_temp + " = bitcast i8* " + malloc_temp + " to " + array_type + "*")
    current_lines = append_string(current_lines, "  store " + array_type + " c\"" + escaped + "\\00\", " + array_type + "* " + cast_temp)
    operand = LLVMOperand(llvm_type="i8*", value=malloc_temp)
    empty_constants = empty_string_constant_set()
    return ExpressionResult(lines=current_lines, temp_index=temp_index + 2, operand=operand, diagnostics=[], string_constants=empty_constants)

def emit_string_concat(left, right, temp_index, lines):
    harmonised = harmonise_operands(left, right, temp_index, lines)
    if harmonised.left == None  or  harmonised.right == None:
        return ExpressionResult(lines=harmonised.lines, temp_index=harmonised.temp_index, operand=None, diagnostics=harmonised.diagnostics, string_constants=empty_string_constant_set())
    left_aligned = coerce_operand_to_type(harmonised.left, "i8*", harmonised.temp_index, harmonised.lines)
    diagnostics = (harmonised.diagnostics) + (left_aligned.diagnostics)
    right_aligned = coerce_operand_to_type(harmonised.right, "i8*", left_aligned.temp_index, left_aligned.lines)
    diagnostics = (diagnostics) + (right_aligned.diagnostics)
    if left_aligned.operand == None  or  right_aligned.operand == None:
        return ExpressionResult(lines=right_aligned.lines, temp_index=right_aligned.temp_index, operand=None, diagnostics=diagnostics, string_constants=empty_string_constant_set())
    temp_name = format_temp_name(right_aligned.temp_index)
    line = "  " + temp_name + " = call i8* @sailfin_runtime_string_concat(i8* " + left_aligned.operand.value + ", i8* " + right_aligned.operand.value + ")"
    out_lines = append_string(right_aligned.lines, line)
    operand = LLVMOperand(llvm_type="i8*", value=temp_name)
    return ExpressionResult(lines=out_lines, temp_index=right_aligned.temp_index + 1, operand=operand, diagnostics=diagnostics, string_constants=empty_string_constant_set())

def coerce_operand_to_string(operand, temp_index, lines):
    empty_constants = empty_string_constant_set()
    if operand.llvm_type == "i8*":
        return ExpressionResult(lines=lines, temp_index=temp_index, operand=operand, diagnostics=[], string_constants=empty_constants)
    if operand.llvm_type == "double":
        temp_name = format_temp_name(temp_index)
        out_lines = append_string(lines, "  " + temp_name + " = call i8* @sailfin_runtime_number_to_string(double " + operand.value + ")")
        out_operand = LLVMOperand(llvm_type="i8*", value=temp_name)
        return ExpressionResult(lines=out_lines, temp_index=temp_index + 1, operand=out_operand, diagnostics=[], string_constants=empty_constants)
    if operand.llvm_type == "i64":
        cast_temp = format_temp_name(temp_index)
        out_lines = append_string(lines, "  " + cast_temp + " = sitofp i64 " + operand.value + " to double")
        call_temp = format_temp_name(temp_index + 1)
        out_lines = append_string(out_lines, "  " + call_temp + " = call i8* @sailfin_runtime_number_to_string(double " + cast_temp + ")")
        out_operand = LLVMOperand(llvm_type="i8*", value=call_temp)
        return ExpressionResult(lines=out_lines, temp_index=temp_index + 2, operand=out_operand, diagnostics=[], string_constants=empty_constants)
    if operand.llvm_type == "i32":
        cast_temp = format_temp_name(temp_index)
        out_lines = append_string(lines, "  " + cast_temp + " = sitofp i32 " + operand.value + " to double")
        call_temp = format_temp_name(temp_index + 1)
        out_lines = append_string(out_lines, "  " + call_temp + " = call i8* @sailfin_runtime_number_to_string(double " + cast_temp + ")")
        out_operand = LLVMOperand(llvm_type="i8*", value=call_temp)
        return ExpressionResult(lines=out_lines, temp_index=temp_index + 2, operand=out_operand, diagnostics=[], string_constants=empty_constants)
    if operand.llvm_type == "i8":
        as_i64 = format_temp_name(temp_index)
        as_double = format_temp_name(temp_index + 1)
        as_string = format_temp_name(temp_index + 2)
        out_lines = append_string(lines, "  " + as_i64 + " = sext i8 " + operand.value + " to i64")
        out_lines = append_string(out_lines, "  " + as_double + " = sitofp i64 " + as_i64 + " to double")
        out_lines = append_string(out_lines, "  " + as_string + " = call i8* @sailfin_runtime_number_to_string(double " + as_double + ")")
        out_operand = LLVMOperand(llvm_type="i8*", value=as_string)
        return ExpressionResult(lines=out_lines, temp_index=temp_index + 3, operand=out_operand, diagnostics=[], string_constants=empty_constants)
    if operand.llvm_type == "i1":
        true_lit = lower_string_literal("\"true\"", temp_index, lines)
        if true_lit.operand == None:
            return ExpressionResult(lines=true_lit.lines, temp_index=true_lit.temp_index, operand=None, diagnostics=[], string_constants=empty_constants)
        false_lit = lower_string_literal("\"false\"", true_lit.temp_index, true_lit.lines)
        if false_lit.operand == None:
            return ExpressionResult(lines=false_lit.lines, temp_index=false_lit.temp_index, operand=None, diagnostics=[], string_constants=empty_constants)
        select_temp = format_temp_name(false_lit.temp_index)
        out_lines = append_string(false_lit.lines, "  " + select_temp + " = select i1 " + operand.value + ", i8* " + true_lit.operand.value + ", i8* " + false_lit.operand.value)
        out_operand = LLVMOperand(llvm_type="i8*", value=select_temp)
        return ExpressionResult(lines=out_lines, temp_index=false_lit.temp_index + 1, operand=out_operand, diagnostics=[], string_constants=empty_constants)
    diagnostics = ["llvm lowering: unable to convert `" + operand.llvm_type + "` to string"]
    return ExpressionResult(lines=lines, temp_index=temp_index, operand=None, diagnostics=diagnostics, string_constants=empty_constants)
