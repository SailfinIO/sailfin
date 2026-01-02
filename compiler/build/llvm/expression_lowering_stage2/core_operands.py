import asyncio
from runtime import runtime_support as runtime

from ...string_utils import char_code
from compiler.build.llvm.expression_lowering_stage2.core_text import number_to_string, trim_text, append_string, char_code_at_text, is_union_llvm_type, parse_union_payload_types
from ..utils import starts_with
from ..type_mapping import ends_with_pointer_suffix, strip_pointer_suffix
from ..expressions import format_temp_name, default_return_literal
from ..expression_lowering.arrays import array_pointer_element_type
from ..types import LocalBinding, LLVMOperand, ComparisonEmission, LoadLocalResult, CoercionResult, BinaryAlignmentResult

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

def emit_comparison_instruction(symbol, left_operand, right_operand, temp_index, lines):
    diagnostics = []
    current_lines = lines
    if left_operand.llvm_type != right_operand.llvm_type:
        diagnostics = append_string(diagnostics, "llvm lowering: comparison operands have mismatched types `" + left_operand.llvm_type + "` and `" + right_operand.llvm_type + "`")
    symbol_is_equality = False
    if len(symbol) == 2:
        c0 = char_code_at_text(symbol, 0)
        c1 = char_code_at_text(symbol, 1)
        if c0 == char_code("=")  and  c1 == char_code("=")  or  c0 == char_code("!")  and  c1 == char_code("="):
            symbol_is_equality = True
    left_is_string = is_string_pointer_type(left_operand.llvm_type)
    right_is_string = is_string_pointer_type(right_operand.llvm_type)
    left_is_null = left_operand.value == "null"
    right_is_null = right_operand.value == "null"
    if symbol_is_equality  and  left_is_string  and  right_is_string  and  not left_is_null  and  not right_is_null:
        compare_temp = format_temp_name(temp_index)
        current_lines = append_string(current_lines, "  " + compare_temp + " = call i1 @strings_equal(i8* " + left_operand.value + ", i8* " + right_operand.value + ")")
        next_index = temp_index + 1
        operand = LLVMOperand(llvm_type="i1", value=compare_temp)
        if len(symbol) == 2:
            c0 = char_code_at_text(symbol, 0)
            if c0 == char_code("!"):
                inverted_temp = format_temp_name(next_index)
                current_lines = append_string(current_lines, "  " + inverted_temp + " = xor i1 " + compare_temp + ", true")
                operand = LLVMOperand(llvm_type="i1", value=inverted_temp)
                next_index += 1
        return ComparisonEmission(lines=current_lines, temp_index=next_index, operand=operand, diagnostics=diagnostics)
    llvm_type = left_operand.llvm_type
    predicate = comparison_predicate_for_symbol(symbol, llvm_type)
    if len(predicate) == 0:
        diagnostics = append_string(diagnostics, "llvm lowering: unsupported comparison operator `" + symbol + "` for type `" + llvm_type + "`")
        return ComparisonEmission(lines=current_lines, temp_index=temp_index, operand=None, diagnostics=diagnostics)
    temp_name = format_temp_name(temp_index)
    current_lines = append_string(current_lines, "  " + temp_name + " = " + predicate + " " + llvm_type + " " + left_operand.value + ", " + right_operand.value)
    operand = LLVMOperand(llvm_type="i1", value=temp_name)
    return ComparisonEmission(lines=current_lines, temp_index=temp_index + 1, operand=operand, diagnostics=diagnostics)

def emit_boolean_and(left_operand, right_operand, temp_index, lines):
    diagnostics = []
    current_lines = lines
    if left_operand.llvm_type != "i1":
        diagnostics = append_string(diagnostics, "llvm lowering: expected boolean operand for `and`, found `" + left_operand.llvm_type + "`")
    if right_operand.llvm_type != "i1":
        diagnostics = append_string(diagnostics, "llvm lowering: expected boolean operand for `and`, found `" + right_operand.llvm_type + "`")
    temp_name = format_temp_name(temp_index)
    current_lines = append_string(current_lines, "  " + temp_name + " = and i1 " + left_operand.value + ", " + right_operand.value)
    operand = LLVMOperand(llvm_type="i1", value=temp_name)
    return ComparisonEmission(lines=current_lines, temp_index=temp_index + 1, operand=operand, diagnostics=diagnostics)

def comparison_predicate_for_symbol(symbol, llvm_type):
    symbol_len = len(symbol)
    c0 = -1
    c1 = -1
    if symbol_len >= 1:
        c0 = char_code_at_text(symbol, 0)
    if symbol_len >= 2:
        c1 = char_code_at_text(symbol, 1)
    if llvm_type == "double":
        if symbol_len == 2  and  c0 == char_code("=")  and  c1 == char_code("="):
            return "fcmp oeq"
        if symbol_len == 2  and  c0 == char_code("!")  and  c1 == char_code("="):
            return "fcmp une"
        if symbol_len == 1  and  c0 == char_code("<"):
            return "fcmp olt"
        if symbol_len == 2  and  c0 == char_code("<")  and  c1 == char_code("="):
            return "fcmp ole"
        if symbol_len == 1  and  c0 == char_code(">"):
            return "fcmp ogt"
        if symbol_len == 2  and  c0 == char_code(">")  and  c1 == char_code("="):
            return "fcmp oge"
        return ""
    if llvm_type == "i32"  or  llvm_type == "i64":
        if symbol_len == 2  and  c0 == char_code("=")  and  c1 == char_code("="):
            return "icmp eq"
        if symbol_len == 2  and  c0 == char_code("!")  and  c1 == char_code("="):
            return "icmp ne"
        if symbol_len == 1  and  c0 == char_code("<"):
            return "icmp slt"
        if symbol_len == 2  and  c0 == char_code("<")  and  c1 == char_code("="):
            return "icmp sle"
        if symbol_len == 1  and  c0 == char_code(">"):
            return "icmp sgt"
        if symbol_len == 2  and  c0 == char_code(">")  and  c1 == char_code("="):
            return "icmp sge"
        return ""
    if llvm_type == "i1":
        if symbol_len == 2  and  c0 == char_code("=")  and  c1 == char_code("="):
            return "icmp eq"
        if symbol_len == 2  and  c0 == char_code("!")  and  c1 == char_code("="):
            return "icmp ne"
        return ""
    if llvm_type == "i8":
        if symbol_len == 2  and  c0 == char_code("=")  and  c1 == char_code("="):
            return "icmp eq"
        if symbol_len == 2  and  c0 == char_code("!")  and  c1 == char_code("="):
            return "icmp ne"
        if symbol_len == 1  and  c0 == char_code("<"):
            return "icmp slt"
        if symbol_len == 2  and  c0 == char_code("<")  and  c1 == char_code("="):
            return "icmp sle"
        if symbol_len == 1  and  c0 == char_code(">"):
            return "icmp sgt"
        if symbol_len == 2  and  c0 == char_code(">")  and  c1 == char_code("="):
            return "icmp sge"
        return ""
    if ends_with_pointer_suffix(llvm_type):
        if symbol_len == 2  and  c0 == char_code("=")  and  c1 == char_code("="):
            return "icmp eq"
        if symbol_len == 2  and  c0 == char_code("!")  and  c1 == char_code("="):
            return "icmp ne"
        if llvm_type == "i8*":
            if symbol_len == 1  and  c0 == char_code("<"):
                return "icmp ult"
            if symbol_len == 2  and  c0 == char_code("<")  and  c1 == char_code("="):
                return "icmp ule"
            if symbol_len == 1  and  c0 == char_code(">"):
                return "icmp ugt"
            if symbol_len == 2  and  c0 == char_code(">")  and  c1 == char_code("="):
                return "icmp uge"
        return ""
    return ""

def is_string_pointer_type(llvm_type):
    if llvm_type == "i8*":
        return True
    return False

def load_local_operand(local, temp_index, lines):
    diagnostics = []
    load_name = format_temp_name(temp_index)
    current_lines = lines
    current_lines = append_string(current_lines, "  " + load_name + " = load " + local.llvm_type + ", " + local.llvm_type + "* " + local.pointer)
    operand = LLVMOperand(llvm_type=local.llvm_type, value=load_name)
    return LoadLocalResult(lines=current_lines, temp_index=temp_index + 1, operand=operand, diagnostics=diagnostics)

def coerce_operand_to_type(operand, target_type, temp_index, lines):
    diagnostics = []
    current_lines = lines
    operand_type = trim_text(operand.llvm_type)
    if len(target_type) == 0:
        return CoercionResult(lines=current_lines, temp_index=temp_index, operand=operand, diagnostics=diagnostics)
    if operand_type == target_type:
        return CoercionResult(lines=current_lines, temp_index=temp_index, operand=operand, diagnostics=diagnostics)
    if ends_with_pointer_suffix(target_type)  and  not ends_with_pointer_suffix(operand_type):
        expected_value_type = strip_pointer_suffix(target_type)
        if expected_value_type == operand_type:
            if starts_with(operand_type, "%")  or  starts_with(operand_type, "{"):
                size_ptr_temp = format_temp_name(temp_index)
                size_temp = format_temp_name(temp_index + 1)
                malloc_temp = format_temp_name(temp_index + 2)
                typed_ptr_temp = format_temp_name(temp_index + 3)
                current_lines = append_string(current_lines, "  " + size_ptr_temp + " = getelementptr " + operand_type + ", " + operand_type + "* null, i32 1")
                current_lines = append_string(current_lines, "  " + size_temp + " = ptrtoint " + operand_type + "* " + size_ptr_temp + " to i64")
                current_lines = append_string(current_lines, "  " + malloc_temp + " = call noalias i8* @malloc(i64 " + size_temp + ")")
                current_lines = append_string(current_lines, "  " + typed_ptr_temp + " = bitcast i8* " + malloc_temp + " to " + operand_type + "*")
                current_lines = append_string(current_lines, "  store " + operand_type + " " + operand.value + ", " + operand_type + "* " + typed_ptr_temp)
                current_lines = append_string(current_lines, "  call void @sailfin_runtime_mark_persistent(i8* " + malloc_temp + ")")
                boxed = LLVMOperand(llvm_type=target_type, value=typed_ptr_temp)
                return CoercionResult(lines=current_lines, temp_index=temp_index + 4, operand=boxed, diagnostics=diagnostics)
    if is_union_llvm_type(target_type):
        variants = parse_union_payload_types(target_type)
        variant_index = 0
        while True:
            if variant_index >= len(variants):
                break
            variant_type = variants[variant_index]
            has_value = False
            value_text = ""
            local_lines = current_lines
            local_temp = temp_index
            if operand_type == variant_type:
                has_value = True
                value_text = operand.value
            else:
                if not ends_with_pointer_suffix(operand_type)  and  ends_with_pointer_suffix(variant_type):
                    expected_value_type = strip_pointer_suffix(variant_type)
                    if expected_value_type == operand_type:
                        size_ptr_temp = format_temp_name(local_temp)
                        size_temp = format_temp_name(local_temp + 1)
                        malloc_temp = format_temp_name(local_temp + 2)
                        typed_ptr_temp = format_temp_name(local_temp + 3)
                        local_lines = append_string(local_lines, "  " + size_ptr_temp + " = getelementptr " + operand_type + ", " + operand_type + "* null, i32 1")
                        local_lines = append_string(local_lines, "  " + size_temp + " = ptrtoint " + operand_type + "* " + size_ptr_temp + " to i64")
                        local_lines = append_string(local_lines, "  " + malloc_temp + " = call noalias i8* @malloc(i64 " + size_temp + ")")
                        local_lines = append_string(local_lines, "  " + typed_ptr_temp + " = bitcast i8* " + malloc_temp + " to " + operand_type + "*")
                        local_lines = append_string(local_lines, "  store " + operand_type + " " + operand.value + ", " + operand_type + "* " + typed_ptr_temp)
                        local_lines = append_string(local_lines, "  call void @sailfin_runtime_mark_persistent(i8* " + malloc_temp + ")")
                        has_value = True
                        value_text = typed_ptr_temp
                        local_temp += 4
                else:
                    if variant_type == "i8*"  and  not ends_with_pointer_suffix(operand_type):
                        if starts_with(operand_type, "%")  or  starts_with(operand_type, "{"):
                            size_ptr_temp = format_temp_name(local_temp)
                            size_temp = format_temp_name(local_temp + 1)
                            malloc_temp = format_temp_name(local_temp + 2)
                            typed_ptr_temp = format_temp_name(local_temp + 3)
                            local_lines = append_string(local_lines, "  " + size_ptr_temp + " = getelementptr " + operand_type + ", " + operand_type + "* null, i32 1")
                            local_lines = append_string(local_lines, "  " + size_temp + " = ptrtoint " + operand_type + "* " + size_ptr_temp + " to i64")
                            local_lines = append_string(local_lines, "  " + malloc_temp + " = call noalias i8* @malloc(i64 " + size_temp + ")")
                            local_lines = append_string(local_lines, "  " + typed_ptr_temp + " = bitcast i8* " + malloc_temp + " to " + operand_type + "*")
                            local_lines = append_string(local_lines, "  store " + operand_type + " " + operand.value + ", " + operand_type + "* " + typed_ptr_temp)
                            local_lines = append_string(local_lines, "  call void @sailfin_runtime_mark_persistent(i8* " + malloc_temp + ")")
                            has_value = True
                            value_text = malloc_temp
                            local_temp += 4
            if has_value:
                tag_temp = format_temp_name(local_temp)
                union_temp = format_temp_name(local_temp + 1)
                local_lines = append_string(local_lines, "  " + tag_temp + " = insertvalue " + target_type + " undef, i32 " + number_to_string(variant_index) + ", 0")
                local_lines = append_string(local_lines, "  " + union_temp + " = insertvalue " + target_type + " " + tag_temp + ", " + variant_type + " " + value_text + ", " + number_to_string(variant_index + 1))
                coerced = LLVMOperand(llvm_type=target_type, value=union_temp)
                return CoercionResult(lines=local_lines, temp_index=local_temp + 2, operand=coerced, diagnostics=diagnostics)
            variant_index += 1
    if target_type == "i8*":
        if operand.llvm_type == "double":
            temp_name = format_temp_name(temp_index)
            current_lines = append_string(current_lines, "  " + temp_name + " = call i8* @sailfin_runtime_number_to_string(double " + operand.value + ")")
            coerced = LLVMOperand(llvm_type="i8*", value=temp_name)
            return CoercionResult(lines=current_lines, temp_index=temp_index + 1, operand=coerced, diagnostics=diagnostics)
        if operand.llvm_type == "i64":
            as_double = format_temp_name(temp_index)
            as_string = format_temp_name(temp_index + 1)
            current_lines = append_string(current_lines, "  " + as_double + " = sitofp i64 " + operand.value + " to double")
            current_lines = append_string(current_lines, "  " + as_string + " = call i8* @sailfin_runtime_number_to_string(double " + as_double + ")")
            coerced = LLVMOperand(llvm_type="i8*", value=as_string)
            return CoercionResult(lines=current_lines, temp_index=temp_index + 2, operand=coerced, diagnostics=diagnostics)
    if not ends_with_pointer_suffix(target_type)  and  ends_with_pointer_suffix(operand.llvm_type):
        source_base = strip_pointer_suffix(operand.llvm_type)
        if source_base == target_type:
            temp_name = format_temp_name(temp_index)
            current_lines = append_string(current_lines, "  " + temp_name + " = load " + target_type + ", " + operand.llvm_type + " " + operand.value)
            coerced = LLVMOperand(llvm_type=target_type, value=temp_name)
            return CoercionResult(lines=current_lines, temp_index=temp_index + 1, operand=coerced, diagnostics=diagnostics)
    if operand_type == "i8*"  and  not ends_with_pointer_suffix(target_type):
        if starts_with(target_type, "%")  or  starts_with(target_type, "{"):
            typed_ptr_temp = format_temp_name(temp_index)
            load_temp = format_temp_name(temp_index + 1)
            current_lines = append_string(current_lines, "  " + typed_ptr_temp + " = bitcast i8* " + operand.value + " to " + target_type + "*")
            current_lines = append_string(current_lines, "  " + load_temp + " = load " + target_type + ", " + target_type + "* " + typed_ptr_temp)
            coerced = LLVMOperand(llvm_type=target_type, value=load_temp)
            return CoercionResult(lines=current_lines, temp_index=temp_index + 2, operand=coerced, diagnostics=diagnostics)
    if target_type == "double":
        if operand.llvm_type == "i64":
            temp_name = format_temp_name(temp_index)
            current_lines = append_string(current_lines, "  " + temp_name + " = sitofp i64 " + operand.value + " to double")
            coerced = LLVMOperand(llvm_type="double", value=temp_name)
            return CoercionResult(lines=current_lines, temp_index=temp_index + 1, operand=coerced, diagnostics=diagnostics)
        if operand.llvm_type == "i1":
            temp_name = format_temp_name(temp_index)
            current_lines = append_string(current_lines, "  " + temp_name + " = uitofp i1 " + operand.value + " to double")
            coerced = LLVMOperand(llvm_type="double", value=temp_name)
            return CoercionResult(lines=current_lines, temp_index=temp_index + 1, operand=coerced, diagnostics=diagnostics)
    if target_type == "i64":
        if operand.llvm_type == "double":
            round_temp = format_temp_name(temp_index)
            convert_temp = format_temp_name(temp_index + 1)
            current_lines = append_string(current_lines, "  " + round_temp + " = call double @round(double " + operand.value + ")")
            current_lines = append_string(current_lines, "  " + convert_temp + " = fptosi double " + round_temp + " to i64")
            coerced = LLVMOperand(llvm_type="i64", value=convert_temp)
            return CoercionResult(lines=current_lines, temp_index=temp_index + 2, operand=coerced, diagnostics=diagnostics)
        if operand.llvm_type == "i1":
            temp_name = format_temp_name(temp_index)
            current_lines = append_string(current_lines, "  " + temp_name + " = zext i1 " + operand.value + " to i64")
            coerced = LLVMOperand(llvm_type="i64", value=temp_name)
            return CoercionResult(lines=current_lines, temp_index=temp_index + 1, operand=coerced, diagnostics=diagnostics)
        if operand.llvm_type == "i8":
            temp_name = format_temp_name(temp_index)
            current_lines = append_string(current_lines, "  " + temp_name + " = sext i8 " + operand.value + " to i64")
            coerced = LLVMOperand(llvm_type="i64", value=temp_name)
            return CoercionResult(lines=current_lines, temp_index=temp_index + 1, operand=coerced, diagnostics=diagnostics)
        if operand.llvm_type == "i32":
            temp_name = format_temp_name(temp_index)
            current_lines = append_string(current_lines, "  " + temp_name + " = sext i32 " + operand.value + " to i64")
            coerced = LLVMOperand(llvm_type="i64", value=temp_name)
            return CoercionResult(lines=current_lines, temp_index=temp_index + 1, operand=coerced, diagnostics=diagnostics)
    if target_type == "i32":
        if operand.llvm_type == "i64":
            temp_name = format_temp_name(temp_index)
            current_lines = append_string(current_lines, "  " + temp_name + " = trunc i64 " + operand.value + " to i32")
            coerced = LLVMOperand(llvm_type="i32", value=temp_name)
            return CoercionResult(lines=current_lines, temp_index=temp_index + 1, operand=coerced, diagnostics=diagnostics)
        if operand.llvm_type == "i8":
            temp_name = format_temp_name(temp_index)
            current_lines = append_string(current_lines, "  " + temp_name + " = sext i8 " + operand.value + " to i32")
            coerced = LLVMOperand(llvm_type="i32", value=temp_name)
            return CoercionResult(lines=current_lines, temp_index=temp_index + 1, operand=coerced, diagnostics=diagnostics)
        if operand.llvm_type == "i1":
            temp_name = format_temp_name(temp_index)
            current_lines = append_string(current_lines, "  " + temp_name + " = zext i1 " + operand.value + " to i32")
            coerced = LLVMOperand(llvm_type="i32", value=temp_name)
            return CoercionResult(lines=current_lines, temp_index=temp_index + 1, operand=coerced, diagnostics=diagnostics)
        if operand.llvm_type == "double":
            round_temp = format_temp_name(temp_index)
            convert_temp = format_temp_name(temp_index + 1)
            current_lines = append_string(current_lines, "  " + round_temp + " = call double @round(double " + operand.value + ")")
            current_lines = append_string(current_lines, "  " + convert_temp + " = fptosi double " + round_temp + " to i32")
            coerced = LLVMOperand(llvm_type="i32", value=convert_temp)
            return CoercionResult(lines=current_lines, temp_index=temp_index + 2, operand=coerced, diagnostics=diagnostics)
    if target_type == "i8":
        if operand.llvm_type == "i64":
            temp_name = format_temp_name(temp_index)
            current_lines = append_string(current_lines, "  " + temp_name + " = trunc i64 " + operand.value + " to i8")
            coerced = LLVMOperand(llvm_type="i8", value=temp_name)
            return CoercionResult(lines=current_lines, temp_index=temp_index + 1, operand=coerced, diagnostics=diagnostics)
        if operand.llvm_type == "i32":
            temp_name = format_temp_name(temp_index)
            current_lines = append_string(current_lines, "  " + temp_name + " = trunc i32 " + operand.value + " to i8")
            coerced = LLVMOperand(llvm_type="i8", value=temp_name)
            return CoercionResult(lines=current_lines, temp_index=temp_index + 1, operand=coerced, diagnostics=diagnostics)
        if operand.llvm_type == "i1":
            temp_name = format_temp_name(temp_index)
            current_lines = append_string(current_lines, "  " + temp_name + " = zext i1 " + operand.value + " to i8")
            coerced = LLVMOperand(llvm_type="i8", value=temp_name)
            return CoercionResult(lines=current_lines, temp_index=temp_index + 1, operand=coerced, diagnostics=diagnostics)
        if operand.llvm_type == "double":
            round_temp = format_temp_name(temp_index)
            convert_temp = format_temp_name(temp_index + 1)
            current_lines = append_string(current_lines, "  " + round_temp + " = call double @round(double " + operand.value + ")")
            current_lines = append_string(current_lines, "  " + convert_temp + " = fptosi double " + round_temp + " to i8")
            coerced = LLVMOperand(llvm_type="i8", value=convert_temp)
            return CoercionResult(lines=current_lines, temp_index=temp_index + 2, operand=coerced, diagnostics=diagnostics)
    if target_type == "i1":
        if operand.llvm_type == "double":
            temp_name = format_temp_name(temp_index)
            current_lines = append_string(current_lines, "  " + temp_name + " = fcmp one double " + operand.value + ", 0.0")
            coerced = LLVMOperand(llvm_type="i1", value=temp_name)
            return CoercionResult(lines=current_lines, temp_index=temp_index + 1, operand=coerced, diagnostics=diagnostics)
        if operand.llvm_type == "i64":
            temp_name = format_temp_name(temp_index)
            current_lines = append_string(current_lines, "  " + temp_name + " = icmp ne i64 " + operand.value + ", 0")
            coerced = LLVMOperand(llvm_type="i1", value=temp_name)
            return CoercionResult(lines=current_lines, temp_index=temp_index + 1, operand=coerced, diagnostics=diagnostics)
    if target_type == "i8"  and  operand.llvm_type == "i8*":
        char_ptr_temp = format_temp_name(temp_index)
        char_value_temp = format_temp_name(temp_index + 1)
        current_lines = append_string(current_lines, "  " + char_ptr_temp + " = getelementptr i8, i8* " + operand.value + ", i64 0")
        current_lines = append_string(current_lines, "  " + char_value_temp + " = load i8, i8* " + char_ptr_temp)
        coerced = LLVMOperand(llvm_type="i8", value=char_value_temp)
        return CoercionResult(lines=current_lines, temp_index=temp_index + 2, operand=coerced, diagnostics=diagnostics)
    if target_type == "i8*"  and  operand.llvm_type == "i8":
        size_temp = format_temp_name(temp_index)
        malloc_temp = format_temp_name(temp_index + 1)
        null_ptr = format_temp_name(temp_index + 2)
        current_lines = append_string(current_lines, "  " + size_temp + " = add i64 0, 2")
        current_lines = append_string(current_lines, "  " + malloc_temp + " = call i8* @malloc(i64 " + size_temp + ")")
        current_lines = append_string(current_lines, "  store i8 " + operand.value + ", i8* " + malloc_temp)
        current_lines = append_string(current_lines, "  " + null_ptr + " = getelementptr i8, i8* " + malloc_temp + ", i64 1")
        current_lines = append_string(current_lines, "  store i8 0, i8* " + null_ptr)
        current_lines = append_string(current_lines, "  call void @sailfin_runtime_mark_persistent(i8* " + malloc_temp + ")")
        coerced = LLVMOperand(llvm_type="i8*", value=malloc_temp)
        return CoercionResult(lines=current_lines, temp_index=temp_index + 3, operand=coerced, diagnostics=diagnostics)
    if target_type == "i8*"  and  ends_with_pointer_suffix(operand.llvm_type):
        temp_name = format_temp_name(temp_index)
        current_lines = append_string(current_lines, "  " + temp_name + " = bitcast " + operand.llvm_type + " " + operand.value + " to i8*")
        coerced = LLVMOperand(llvm_type="i8*", value=temp_name)
        return CoercionResult(lines=current_lines, temp_index=temp_index + 1, operand=coerced, diagnostics=diagnostics)
    if target_type == "i8*"  and  not ends_with_pointer_suffix(operand.llvm_type):
        if starts_with(operand.llvm_type, "%")  or  starts_with(operand.llvm_type, "{"):
            size_ptr_temp = format_temp_name(temp_index)
            size_temp = format_temp_name(temp_index + 1)
            malloc_temp = format_temp_name(temp_index + 2)
            typed_ptr_temp = format_temp_name(temp_index + 3)
            current_lines = append_string(current_lines, "  " + size_ptr_temp + " = getelementptr " + operand.llvm_type + ", " + operand.llvm_type + "* null, i32 1")
            current_lines = append_string(current_lines, "  " + size_temp + " = ptrtoint " + operand.llvm_type + "* " + size_ptr_temp + " to i64")
            current_lines = append_string(current_lines, "  " + malloc_temp + " = call noalias i8* @malloc(i64 " + size_temp + ")")
            current_lines = append_string(current_lines, "  " + typed_ptr_temp + " = bitcast i8* " + malloc_temp + " to " + operand.llvm_type + "*")
            current_lines = append_string(current_lines, "  store " + operand.llvm_type + " " + operand.value + ", " + operand.llvm_type + "* " + typed_ptr_temp)
            current_lines = append_string(current_lines, "  call void @sailfin_runtime_mark_persistent(i8* " + malloc_temp + ")")
            coerced = LLVMOperand(llvm_type="i8*", value=malloc_temp)
            return CoercionResult(lines=current_lines, temp_index=temp_index + 4, operand=coerced, diagnostics=diagnostics)
    if operand.llvm_type == "i8*"  and  ends_with_pointer_suffix(target_type):
        temp_name = format_temp_name(temp_index)
        current_lines = append_string(current_lines, "  " + temp_name + " = bitcast i8* " + operand.value + " to " + target_type)
        coerced = LLVMOperand(llvm_type=target_type, value=temp_name)
        return CoercionResult(lines=current_lines, temp_index=temp_index + 1, operand=coerced, diagnostics=diagnostics)
    if not ends_with_pointer_suffix(operand.llvm_type)  and  ends_with_pointer_suffix(target_type):
        expected_value_type = strip_pointer_suffix(target_type)
        if expected_value_type == operand.llvm_type:
            size_ptr_temp = format_temp_name(temp_index)
            size_temp = format_temp_name(temp_index + 1)
            malloc_temp = format_temp_name(temp_index + 2)
            typed_ptr_temp = format_temp_name(temp_index + 3)
            current_lines = append_string(current_lines, "  " + size_ptr_temp + " = getelementptr " + operand.llvm_type + ", " + operand.llvm_type + "* null, i32 1")
            current_lines = append_string(current_lines, "  " + size_temp + " = ptrtoint " + operand.llvm_type + "* " + size_ptr_temp + " to i64")
            current_lines = append_string(current_lines, "  " + malloc_temp + " = call noalias i8* @malloc(i64 " + size_temp + ")")
            current_lines = append_string(current_lines, "  " + typed_ptr_temp + " = bitcast i8* " + malloc_temp + " to " + operand.llvm_type + "*")
            current_lines = append_string(current_lines, "  store " + operand.llvm_type + " " + operand.value + ", " + operand.llvm_type + "* " + typed_ptr_temp)
            current_lines = append_string(current_lines, "  call void @sailfin_runtime_mark_persistent(i8* " + malloc_temp + ")")
            pointer_value = typed_ptr_temp
            next_index = temp_index + 4
            typed_pointer_type = operand.llvm_type + "*"
            if typed_pointer_type != target_type:
                cast_temp = format_temp_name(next_index)
                current_lines = append_string(current_lines, "  " + cast_temp + " = bitcast " + typed_pointer_type + " " + typed_ptr_temp + " to " + target_type)
                pointer_value = cast_temp
                next_index += 1
            coerced = LLVMOperand(llvm_type=target_type, value=pointer_value)
            return CoercionResult(lines=current_lines, temp_index=next_index, operand=coerced, diagnostics=diagnostics)
    if not ends_with_pointer_suffix(operand.llvm_type)  and  ends_with_pointer_suffix(target_type):
        operand_array_element = array_pointer_element_type(operand.llvm_type + "*")
        if len(operand_array_element) > 0:
            alloca_temp = format_temp_name(temp_index)
            current_lines = append_string(current_lines, "  " + alloca_temp + " = alloca " + operand.llvm_type)
            current_lines = append_string(current_lines, "  store " + operand.llvm_type + " " + operand.value + ", " + operand.llvm_type + "* " + alloca_temp)
            next_index = temp_index + 1
            pointer_value = alloca_temp
            operand_pointer_type = operand.llvm_type + "*"
            if operand_pointer_type != target_type:
                bitcast_temp = format_temp_name(next_index)
                current_lines = append_string(current_lines, "  " + bitcast_temp + " = bitcast " + operand_pointer_type + " " + alloca_temp + " to " + target_type)
                pointer_value = bitcast_temp
                next_index += 1
            coerced = LLVMOperand(llvm_type=target_type, value=pointer_value)
            return CoercionResult(lines=current_lines, temp_index=next_index, operand=coerced, diagnostics=diagnostics)
    if ends_with_pointer_suffix(operand.llvm_type)  and  ends_with_pointer_suffix(target_type):
        source_element = array_pointer_element_type(operand.llvm_type)
        target_element = array_pointer_element_type(target_type)
        if len(source_element) > 0  and  len(target_element) > 0:
            temp_name = format_temp_name(temp_index)
            current_lines = append_string(current_lines, "  " + temp_name + " = bitcast " + operand.llvm_type + " " + operand.value + " to " + target_type)
            coerced = LLVMOperand(llvm_type=target_type, value=temp_name)
            return CoercionResult(lines=current_lines, temp_index=temp_index + 1, operand=coerced, diagnostics=diagnostics)
        temp_name = format_temp_name(temp_index)
        current_lines = append_string(current_lines, "  " + temp_name + " = bitcast " + operand.llvm_type + " " + operand.value + " to " + target_type)
        coerced = LLVMOperand(llvm_type=target_type, value=temp_name)
        return CoercionResult(lines=current_lines, temp_index=temp_index + 1, operand=coerced, diagnostics=diagnostics)
    if operand.value == "null"  and  ends_with_pointer_suffix(target_type):
        coerced = LLVMOperand(llvm_type=target_type, value="null")
        return CoercionResult(lines=current_lines, temp_index=temp_index, operand=coerced, diagnostics=diagnostics)
    if operand.value == "null"  and  not ends_with_pointer_suffix(target_type):
        literal = default_return_literal(target_type)
        coerced = LLVMOperand(llvm_type=target_type, value=literal)
        return CoercionResult(lines=current_lines, temp_index=temp_index, operand=coerced, diagnostics=diagnostics)
    if not ends_with_pointer_suffix(target_type)  and  ends_with_pointer_suffix(operand.llvm_type):
        pointer_type = operand.llvm_type
        pointer_value = operand.value
        pointer_temp_index = temp_index
        base_type = strip_pointer_suffix(pointer_type)
        if base_type != target_type:
            desired_pointer_type = target_type + "*"
            bitcast_temp = format_temp_name(pointer_temp_index)
            current_lines = append_string(current_lines, "  " + bitcast_temp + " = bitcast " + pointer_type + " " + pointer_value + " to " + desired_pointer_type)
            pointer_type = desired_pointer_type
            pointer_value = bitcast_temp
            pointer_temp_index += 1
        load_temp = format_temp_name(pointer_temp_index)
        current_lines = append_string(current_lines, "  " + load_temp + " = load " + target_type + ", " + pointer_type + " " + pointer_value)
        coerced = LLVMOperand(llvm_type=target_type, value=load_temp)
        return CoercionResult(lines=current_lines, temp_index=pointer_temp_index + 1, operand=coerced, diagnostics=diagnostics)
    diagnostics = append_string(diagnostics, "llvm lowering: unable to coerce operand of type `" + operand.llvm_type + "` to `" + target_type + "`")
    return CoercionResult(lines=current_lines, temp_index=temp_index, operand=None, diagnostics=diagnostics)

def dominant_type(first, second):
    if len(first) == 0:
        return second
    if len(second) == 0:
        return first
    if first == second:
        return first
    first_is_pointer = ends_with_pointer_suffix(first)
    second_is_pointer = ends_with_pointer_suffix(second)
    if first_is_pointer  and  not second_is_pointer:
        return first
    if second_is_pointer  and  not first_is_pointer:
        return second
    if first_is_pointer  and  second_is_pointer:
        return first
    if first == "double"  or  second == "double":
        return "double"
    if first == "i64"  or  second == "i64":
        return "i64"
    if first == "i8"  and  second == "i64"  or  first == "i64"  and  second == "i8":
        return "i64"
    if first == "i1"  or  second == "i1":
        return "i1"
    return first

def harmonise_operands(left, right, temp_index, lines):
    diagnostics = []
    current_lines = lines
    current_temp = temp_index
    left_operand = left
    right_operand = right
    if left_operand.value == "null"  and  ends_with_pointer_suffix(right_operand.llvm_type):
        left_operand = LLVMOperand(llvm_type=right_operand.llvm_type, value="null")
    if right_operand.value == "null"  and  ends_with_pointer_suffix(left_operand.llvm_type):
        right_operand = LLVMOperand(llvm_type=left_operand.llvm_type, value="null")
    if left_operand.llvm_type == right_operand.llvm_type:
        return BinaryAlignmentResult(lines=current_lines, temp_index=current_temp, left=left_operand, right=right_operand, diagnostics=diagnostics, result_type=left_operand.llvm_type)
    target_type = dominant_type(left_operand.llvm_type, right_operand.llvm_type)
    left_coercion = coerce_operand_to_type(left_operand, target_type, current_temp, current_lines)
    diagnostics = (diagnostics) + (left_coercion.diagnostics)
    if left_coercion.operand == None:
        diagnostics = append_string(diagnostics, "llvm lowering: unable to convert left operand from `" + left_operand.llvm_type + "` to `" + target_type + "`")
        return BinaryAlignmentResult(lines=left_coercion.lines, temp_index=left_coercion.temp_index, left=None, right=None, diagnostics=diagnostics, result_type=target_type)
    left_operand = left_coercion.operand
    current_lines = left_coercion.lines
    current_temp = left_coercion.temp_index
    right_coercion = coerce_operand_to_type(right_operand, target_type, current_temp, current_lines)
    diagnostics = (diagnostics) + (right_coercion.diagnostics)
    if right_coercion.operand == None:
        diagnostics = append_string(diagnostics, "llvm lowering: unable to convert right operand from `" + right_operand.llvm_type + "` to `" + target_type + "`")
        return BinaryAlignmentResult(lines=right_coercion.lines, temp_index=right_coercion.temp_index, left=None, right=None, diagnostics=diagnostics, result_type=target_type)
    right_operand = right_coercion.operand
    current_lines = right_coercion.lines
    current_temp = right_coercion.temp_index
    return BinaryAlignmentResult(lines=current_lines, temp_index=current_temp, left=left_operand, right=right_operand, diagnostics=diagnostics, result_type=target_type)
