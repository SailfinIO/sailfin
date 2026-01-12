import asyncio
from runtime import runtime_support as runtime

from ...string_utils import substring
from ..types import LLVMOperand, ExpressionResult
from ..utils import trim_text, append_string
from ..expressions import format_temp_name
from ..type_mapping import array_struct_type_for_element

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

def lower_struct_array_concat(lhs, rhs, element_type, lines, temp_index):
    current_lines = lines
    current_temp = temp_index
    diagnostics = []
    if len(element_type) == 0:
        diagnostics = append_string(diagnostics, "llvm lowering: concat requires a concrete element type")
        return ExpressionResult(lines=current_lines, temp_index=current_temp, operand=None, diagnostics=diagnostics, string_constants=[])
    array_struct_type = array_struct_type_for_element(element_type)
    if len(array_struct_type) == 0:
        diagnostics = append_string(diagnostics, "llvm lowering: unsupported concat element type `" + element_type + "`")
        return ExpressionResult(lines=current_lines, temp_index=current_temp, operand=None, diagnostics=diagnostics, string_constants=[])
    data_pointer_type = element_type + "*"
    data_pointer_pointer_type = data_pointer_type + "*"
    lhs_data_ptr = format_temp_name(current_temp)
    current_temp += 1
    current_lines = append_string(current_lines, "  " + lhs_data_ptr + " = getelementptr " + array_struct_type + ", " + lhs.llvm_type + " " + lhs.value + ", i32 0, i32 0")
    lhs_data_value = format_temp_name(current_temp)
    current_temp += 1
    current_lines = append_string(current_lines, "  " + lhs_data_value + " = load " + data_pointer_type + ", " + data_pointer_pointer_type + " " + lhs_data_ptr)
    lhs_len_ptr = format_temp_name(current_temp)
    current_temp += 1
    current_lines = append_string(current_lines, "  " + lhs_len_ptr + " = getelementptr " + array_struct_type + ", " + lhs.llvm_type + " " + lhs.value + ", i32 0, i32 1")
    lhs_len_value = format_temp_name(current_temp)
    current_temp += 1
    current_lines = append_string(current_lines, "  " + lhs_len_value + " = load i64, i64* " + lhs_len_ptr)
    rhs_data_ptr = format_temp_name(current_temp)
    current_temp += 1
    current_lines = append_string(current_lines, "  " + rhs_data_ptr + " = getelementptr " + array_struct_type + ", " + rhs.llvm_type + " " + rhs.value + ", i32 0, i32 0")
    rhs_data_value = format_temp_name(current_temp)
    current_temp += 1
    current_lines = append_string(current_lines, "  " + rhs_data_value + " = load " + data_pointer_type + ", " + data_pointer_pointer_type + " " + rhs_data_ptr)
    rhs_len_ptr = format_temp_name(current_temp)
    current_temp += 1
    current_lines = append_string(current_lines, "  " + rhs_len_ptr + " = getelementptr " + array_struct_type + ", " + rhs.llvm_type + " " + rhs.value + ", i32 0, i32 1")
    rhs_len_value = format_temp_name(current_temp)
    current_temp += 1
    current_lines = append_string(current_lines, "  " + rhs_len_value + " = load i64, i64* " + rhs_len_ptr)
    element_size_ptr = format_temp_name(current_temp)
    current_temp += 1
    current_lines = append_string(current_lines, "  " + element_size_ptr + " = getelementptr [1 x " + element_type + "], [1 x " + element_type + "]* null, i32 0, i32 1")
    element_size_value = format_temp_name(current_temp)
    current_temp += 1
    current_lines = append_string(current_lines, "  " + element_size_value + " = ptrtoint " + element_type + "* " + element_size_ptr + " to i64")
    total_length = format_temp_name(current_temp)
    current_temp += 1
    current_lines = append_string(current_lines, "  " + total_length + " = add i64 " + lhs_len_value + ", " + rhs_len_value)
    total_bytes = format_temp_name(current_temp)
    current_temp += 1
    current_lines = append_string(current_lines, "  " + total_bytes + " = mul i64 " + element_size_value + ", " + total_length)
    new_raw_buffer = format_temp_name(current_temp)
    current_temp += 1
    current_lines = append_string(current_lines, "  " + new_raw_buffer + " = call noalias i8* @malloc(i64 " + total_bytes + ")")
    new_data_ptr = format_temp_name(current_temp)
    current_temp += 1
    current_lines = append_string(current_lines, "  " + new_data_ptr + " = bitcast i8* " + new_raw_buffer + " to " + data_pointer_type)
    new_data_i8 = format_temp_name(current_temp)
    current_temp += 1
    current_lines = append_string(current_lines, "  " + new_data_i8 + " = bitcast " + data_pointer_type + " " + new_data_ptr + " to i8*")
    lhs_bytes = format_temp_name(current_temp)
    current_temp += 1
    current_lines = append_string(current_lines, "  " + lhs_bytes + " = mul i64 " + element_size_value + ", " + lhs_len_value)
    lhs_src_i8 = format_temp_name(current_temp)
    current_temp += 1
    current_lines = append_string(current_lines, "  " + lhs_src_i8 + " = bitcast " + data_pointer_type + " " + lhs_data_value + " to i8*")
    current_lines = append_string(current_lines, "  call void @sailfin_runtime_copy_bytes(i8* " + new_data_i8 + ", i8* " + lhs_src_i8 + ", i64 " + lhs_bytes + ")")
    rhs_bytes = format_temp_name(current_temp)
    current_temp += 1
    current_lines = append_string(current_lines, "  " + rhs_bytes + " = mul i64 " + element_size_value + ", " + rhs_len_value)
    rhs_src_i8 = format_temp_name(current_temp)
    current_temp += 1
    current_lines = append_string(current_lines, "  " + rhs_src_i8 + " = bitcast " + data_pointer_type + " " + rhs_data_value + " to i8*")
    rhs_dest_ptr = format_temp_name(current_temp)
    current_temp += 1
    current_lines = append_string(current_lines, "  " + rhs_dest_ptr + " = getelementptr " + element_type + ", " + data_pointer_type + " " + new_data_ptr + ", i64 " + lhs_len_value)
    rhs_dest_i8 = format_temp_name(current_temp)
    current_temp += 1
    current_lines = append_string(current_lines, "  " + rhs_dest_i8 + " = bitcast " + data_pointer_type + " " + rhs_dest_ptr + " to i8*")
    current_lines = append_string(current_lines, "  call void @sailfin_runtime_copy_bytes(i8* " + rhs_dest_i8 + ", i8* " + rhs_src_i8 + ", i64 " + rhs_bytes + ")")
    struct_size_ptr = format_temp_name(current_temp)
    current_temp += 1
    current_lines = append_string(current_lines, "  " + struct_size_ptr + " = getelementptr " + array_struct_type + ", " + array_struct_type + "* null, i32 1")
    struct_size_value = format_temp_name(current_temp)
    current_temp += 1
    current_lines = append_string(current_lines, "  " + struct_size_value + " = ptrtoint " + array_struct_type + "* " + struct_size_ptr + " to i64")
    new_struct_raw = format_temp_name(current_temp)
    current_temp += 1
    current_lines = append_string(current_lines, "  " + new_struct_raw + " = call i8* @malloc(i64 " + struct_size_value + ")")
    new_struct_ptr = format_temp_name(current_temp)
    current_temp += 1
    current_lines = append_string(current_lines, "  " + new_struct_ptr + " = bitcast i8* " + new_struct_raw + " to " + array_struct_type + "*")
    new_data_field = format_temp_name(current_temp)
    current_temp += 1
    current_lines = append_string(current_lines, "  " + new_data_field + " = getelementptr " + array_struct_type + ", " + array_struct_type + "* " + new_struct_ptr + ", i32 0, i32 0")
    current_lines = append_string(current_lines, "  store " + data_pointer_type + " " + new_data_ptr + ", " + data_pointer_pointer_type + " " + new_data_field)
    new_len_field = format_temp_name(current_temp)
    current_temp += 1
    current_lines = append_string(current_lines, "  " + new_len_field + " = getelementptr " + array_struct_type + ", " + array_struct_type + "* " + new_struct_ptr + ", i32 0, i32 1")
    current_lines = append_string(current_lines, "  store i64 " + total_length + ", i64* " + new_len_field)
    result_operand = LLVMOperand(llvm_type=lhs.llvm_type, value=new_struct_ptr)
    return ExpressionResult(lines=current_lines, temp_index=current_temp, operand=result_operand, diagnostics=diagnostics, string_constants=[])

def lower_array_push_in_place(array, value, element_type, lines, temp_index):
    current_lines = lines
    current_temp = temp_index
    diagnostics = []
    if len(element_type) == 0:
        diagnostics = append_string(diagnostics, "llvm lowering: push requires a concrete element type")
        return ExpressionResult(lines=current_lines, temp_index=current_temp, operand=None, diagnostics=diagnostics, string_constants=[])
    array_struct_type = array_struct_type_for_element(element_type)
    if len(array_struct_type) == 0:
        diagnostics = append_string(diagnostics, "llvm lowering: unsupported push element type `" + element_type + "`")
        return ExpressionResult(lines=current_lines, temp_index=current_temp, operand=None, diagnostics=diagnostics, string_constants=[])
    data_pointer_type = element_type + "*"
    data_pointer_pointer_type = data_pointer_type + "*"
    data_ptr_gep = format_temp_name(current_temp)
    current_temp += 1
    current_lines = append_string(current_lines, "  " + data_ptr_gep + " = getelementptr " + array_struct_type + ", " + array.llvm_type + " " + array.value + ", i32 0, i32 0")
    len_ptr = format_temp_name(current_temp)
    current_temp += 1
    current_lines = append_string(current_lines, "  " + len_ptr + " = getelementptr " + array_struct_type + ", " + array.llvm_type + " " + array.value + ", i32 0, i32 1")
    element_size_ptr = format_temp_name(current_temp)
    current_temp += 1
    current_lines = append_string(current_lines, "  " + element_size_ptr + " = getelementptr [1 x " + element_type + "], [1 x " + element_type + "]* null, i32 0, i32 1")
    element_size_value = format_temp_name(current_temp)
    current_temp += 1
    current_lines = append_string(current_lines, "  " + element_size_value + " = ptrtoint " + element_type + "* " + element_size_ptr + " to i64")
    data_ptr_i8 = format_temp_name(current_temp)
    current_temp += 1
    current_lines = append_string(current_lines, "  " + data_ptr_i8 + " = bitcast " + data_pointer_pointer_type + " " + data_ptr_gep + " to i8**")
    slot_i8 = format_temp_name(current_temp)
    current_temp += 1
    current_lines = append_string(current_lines, "  " + slot_i8 + " = call i8* @sailfin_runtime_array_push_slot(i8** " + data_ptr_i8 + ", i64* " + len_ptr + ", i64 " + element_size_value + ")")
    slot_typed = format_temp_name(current_temp)
    current_temp += 1
    current_lines = append_string(current_lines, "  " + slot_typed + " = bitcast i8* " + slot_i8 + " to " + element_type + "*")
    current_lines = append_string(current_lines, "  store " + element_type + " " + value.value + ", " + element_type + "* " + slot_typed)
    return ExpressionResult(lines=current_lines, temp_index=current_temp, operand=array, diagnostics=diagnostics, string_constants=[])

def find_top_level_comma_in_llvm_type(text):
    brace_depth = 0
    index = 0
    while True:
        if index >= len(text):
            break
        ch = text[index]
        if ch == "{":
            brace_depth += 1
            index += 1
            continue
        if ch == "}":
            if brace_depth > 0:
                brace_depth -= 1
            index += 1
            continue
        if ch == ",":
            if brace_depth == 0:
                return index
        index += 1
    return -1

def array_pointer_element_type(llvm_type):
    trimmed = trim_text(llvm_type)
    if len(trimmed) == 0:
        return ""
    if trimmed[len(trimmed) - 1] != "*":
        return ""
    without_pointer = trim_text(substring(trimmed, 0, len(trimmed) - 1))
    if len(without_pointer) < 2:
        return ""
    if without_pointer[0] != "{":
        return ""
    if without_pointer[len(without_pointer) - 1] != "}":
        return ""
    inner = trim_text(substring(without_pointer, 1, len(without_pointer) - 1))
    if len(inner) == 0:
        return ""
    comma_index = find_top_level_comma_in_llvm_type(inner)
    if comma_index < 0:
        return ""
    first_segment = trim_text(substring(inner, 0, comma_index))
    if len(first_segment) == 0:
        return ""
    if first_segment[len(first_segment) - 1] != "*":
        return ""
    element = trim_text(substring(first_segment, 0, len(first_segment) - 1))
    if len(element) == 0:
        return ""
    return element
