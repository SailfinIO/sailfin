import asyncio
from runtime import runtime_support as runtime

from ...native_ir import NativeFunction, NativeSourceSpan
from ...string_utils import substring, char_code, char_at, find_char, find_last_index_of_char, index_of as str_index_of
from ..types import TypeContext, StructTypeInfo, StructFieldInfo, EnumTypeInfo, EnumVariantInfo, InterfaceTypeInfo, VTableInfo, VTableEntry, LocalBinding, ParameterBinding, OwnershipInfo, OwnershipConsumption, OwnershipAnalysis, LifetimeRegionMetadata, LifetimeReleaseEvent, ScopeMetadata, LLVMOperand, ExpressionResult, CoercionResult, BlockLoweringResult, LoweredLLVMFunction, LoweredLLVMResult, LetLoweringResult, ModuleGlobalLoweringResult, OperatorMatch, BorrowParseResult, BorrowArgumentParse, TernaryParseResult, AssignmentParseResult, InlineLetParseResult, MemberAccessParse, IndexExpressionParse, RawAddressParseResult, CastParseResult, TraitMetadata, TraitDescriptor, TraitImplementationDescriptor, FunctionEffectEntry, RuntimeHelperDescriptor, CapabilityManifest, CapabilityManifestEntry, StringConstant, LocalMutation, LoopContext, ImportedModuleContext, LayoutManifestApplication, TypeContextBuild, FunctionCallEntry, StringPointerResult, InterpolatedTemplateParse, BodyResult, ParameterPreparation, ArrayLiteralMetadata, TypeAllocationInfo, HeapBoxResult, StructLiteralField, StructLiteralParse, EnumLiteralParse, ExpressionStatementResult, BlockLabelResult, IfStructure, LoopStructure, TryStructure, RangeIterableParse, MatchCaseStructure, MatchStructure, MatchFieldBinding, MatchStructFieldBinding, MatchCaseCondition, ConditionConversion, ComparisonEmission, BinaryAlignmentResult, ThrowLoweringResult, PhiMergeResult, PhiInputEntry, MutationMaterializationResult, PhiStoreEntry, MatchArmMutations, LoadLocalResult
from ..utils import starts_with, ends_with, char_at as utils_char_at, is_identifier_start_char, is_identifier_part_char, contains_text, matches_keyword, find_parameter_binding as utils_find_parameter_binding, merge_parameter_bindings, is_effect_delimiter
from compiler.build.llvm.expression_lowering_stage2.core_text import number_to_string, matches_case_insensitive, trim_text, is_trim_char, index_of, find_last_index_of_char, append_string, string_array_contains, join_with_separator, find_substring_from, is_union_llvm_type, parse_union_payload_types, extract_simple_identifier, is_boolean_literal, is_null_literal, is_digit_char, char_code_at_text, is_integer_literal, is_number_literal, normalise_number_literal, is_string_literal, is_character_literal, get_character_literal_value, make_string_constant_name, make_string_constant_name_for_module, compute_string_constant_hash, parse_interpolated_template, encode_string_literal_for_sailfin, escape_string_for_sailfin_literal, unescape_string_literal, sanitize_symbol
from compiler.build.llvm.expression_lowering_stage2.core_text import parse_union_payload_types, is_union_llvm_type, extract_simple_identifier, unescape_string_literal, make_string_constant_name, make_string_constant_name_for_module
from ..strings import empty_string_constant_set, append_string_constant, merge_string_constants, find_string_constant, render_string_constants, escape_string_for_llvm
from ..type_mapping import map_type_annotation, unwrap_move_wrapper, ends_with_pointer_suffix, strip_pointer_suffix, layout_annotation_requires_pointer, layout_annotation_base_type, annotation_is_array, layout_annotation_represents_user_value, is_copy_type, array_struct_type_for_element
from ..type_context import fixup_enum_layouts, find_struct_info_by_name, find_interface_info_by_name, find_vtable_for_struct_interface, find_struct_info_by_llvm_type, find_struct_field_index, find_struct_field_info, find_enum_info_by_llvm_type, resolve_struct_info_from_llvm_type, lookup_allocation_info, resolve_struct_info_for_literal, resolve_struct_info_for_method_target, resolve_interface_info_for_method_target, resolve_enum_info_for_literal, resolve_enum_variant_info, find_variant_field_info
from ..rendering import find_function_by_name
from ..runtime_helpers import find_runtime_helper
from ..expressions import format_temp_name, format_local_pointer_name, default_return_literal, strip_mut_prefix, is_simple_identifier
from ..expression_lowering.bindings import bindings_find_parameter_binding, bindings_mark_parameter_consumed, bindings_mark_local_consumed, bindings_reset_local_consumption, bindings_update_local_ownership
from ..expression_lowering.splitting import split_array_elements
from ..expression_lowering.arrays import lower_struct_array_concat, lower_array_push_in_place, find_top_level_comma_in_llvm_type, array_pointer_element_type

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

def find_parameter_binding(bindings, name):
    return bindings_find_parameter_binding(bindings, name)

def mark_parameter_consumed(bindings, name):
    return bindings_mark_parameter_consumed(bindings, name)

def mark_local_consumed(locals, name):
    return bindings_mark_local_consumed(locals, name)

def reset_local_consumption(locals, name):
    return bindings_reset_local_consumption(locals, name)

def update_local_ownership(locals, name, ownership):
    return bindings_update_local_ownership(locals, name, ownership)

def map_struct_type_annotation(context, annotation):
    info = find_struct_info_by_name(context, annotation)
    if info != None:
        return info.llvm_name
    return ""

def map_enum_type_annotation(context, annotation):
    trimmed = trim_text(annotation)
    if len(trimmed) == 0:
        return ""
    index = 0
    while True:
        if index >= len(context.enums):
            break
        enum_info = context.enums[index]
        if enum_info.name == trimmed:
            return enum_info.llvm_name
        index += 1
    return ""

def map_interface_type_annotation(context, annotation):
    trimmed = trim_text(annotation)
    if len(trimmed) == 0:
        return ""
    interface_info = find_interface_info_by_name(context, trimmed)
    if interface_info != None:
        return interface_info.llvm_name
    return ""

def map_primitive_type(context, annotation):
    if annotation == "number":
        return "double"
    if annotation == "boolean"  or  annotation == "bool":
        return "i1"
    if annotation == "usize":
        return "i64"
    if annotation == "int"  or  annotation == "i64":
        return "i64"
    if annotation == "i32":
        return "i32"
    if annotation == "u8":
        return "i8"
    struct_type = map_struct_type_annotation(context, annotation)
    if len(struct_type) > 0:
        return struct_type
    enum_type = map_enum_type_annotation(context, annotation)
    if len(enum_type) > 0:
        return enum_type
    interface_type = map_interface_type_annotation(context, annotation)
    if len(interface_type) > 0:
        return interface_type
    if annotation == "string":
        return "i8*"
    return ""

def map_optional_type(context, annotation):
    trimmed = trim_text(annotation)
    if len(trimmed) == 0:
        return ""
    if trimmed[len(trimmed) - 1] != "?":
        return ""
    inner_annotation = trim_text(substring(trimmed, 0, len(trimmed) - 1))
    if len(inner_annotation) == 0:
        return ""
    struct_type = map_struct_type_annotation(context, inner_annotation)
    if len(struct_type) > 0:
        return struct_type + "*"
    enum_type = map_enum_type_annotation(context, inner_annotation)
    if len(enum_type) > 0:
        return enum_type + "*"
    interface_type = map_interface_type_annotation(context, inner_annotation)
    if len(interface_type) > 0:
        return interface_type + "*"
    inner_type = map_type_annotation(inner_annotation)
    if len(inner_type) == 0  or  inner_type == "void":
        return "i8*"
    if inner_type[len(inner_type) - 1] == "*":
        return inner_type
    return inner_type + "*"

def map_reference_inner_type(context, annotation):
    trimmed = trim_text(annotation)
    if len(trimmed) == 0:
        return ""
    nested_reference = map_reference_type(context, trimmed)
    if len(nested_reference) > 0:
        return nested_reference
    array_type = map_array_pointer_type(context, trimmed)
    if len(array_type) > 0:
        return array_type
    return map_primitive_type(context, trimmed)

def map_reference_type(context, annotation):
    trimmed = trim_text(annotation)
    if len(trimmed) == 0:
        return ""
    if not starts_with(trimmed, "&"):
        return ""
    if starts_with(trimmed, "&&"):
        return ""
    remainder = trim_text(substring(trimmed, 1, len(trimmed)))
    if starts_with(remainder, "mut"):
        after_mut = substring(remainder, 3, len(remainder))
        remainder = trim_text(after_mut)
    if len(remainder) == 0:
        return ""
    if remainder[0] == "("  and  remainder[len(remainder) - 1] == ")":
        remainder = trim_text(substring(remainder, 1, len(remainder) - 1))
    inner_type = map_reference_inner_type(context, remainder)
    if len(inner_type) == 0:
        return ""
    return inner_type + "*"

def map_array_pointer_type(context, annotation):
    trimmed = trim_text(annotation)
    if len(trimmed) < 3:
        return ""
    suffix = substring(trimmed, len(trimmed) - 2, len(trimmed))
    if suffix != "[]":
        return ""
    element_annotation = trim_text(substring(trimmed, 0, len(trimmed) - 2))
    element_type = map_primitive_type(context, element_annotation)
    if len(element_type) == 0:
        element_type = map_type_annotation(element_annotation)
    if len(element_type) == 0:
        element_type = "i8*"
    if not annotation_is_array(element_annotation)  and  layout_annotation_represents_user_value(element_annotation)  and  ends_with_pointer_suffix(element_type):
        stripped_element = strip_pointer_suffix(element_type)
        if len(stripped_element) > 0:
            element_type = stripped_element
    return "{ " + element_type + "*, i64 }*"

def unwrap_move_wrapper(annotation):
    trimmed = trim_text(annotation)
    if len(trimmed) == 0:
        return trimmed
    if starts_with(trimmed, "Affine<")  or  starts_with(trimmed, "Linear<"):
        open_index = index_of(trimmed, "<")
        if open_index >= 0:
            if trimmed[len(trimmed) - 1] == ">":
                inner = substring(trimmed, open_index + 1, len(trimmed) - 1)
                return unwrap_move_wrapper(trim_text(inner))
    return trimmed

def find_top_level_union_separator(text):
    paren_depth = 0
    brace_depth = 0
    bracket_depth = 0
    angle_depth = 0
    in_single = False
    in_double = False
    escape = False
    index = 0
    while True:
        if index >= len(text):
            break
        ch = substring(text, index, index + 1)
        if in_double:
            if escape:
                escape = False
            else:
                if ch == "\\":
                    escape = True
                else:
                    if ch == "\"":
                        in_double = False
            index += 1
            continue
        if in_single:
            if escape:
                escape = False
            else:
                if ch == "\\":
                    escape = True
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
        if ch == "(":
            paren_depth += 1
            index += 1
            continue
        if ch == ")":
            if paren_depth > 0:
                paren_depth -= 1
            index += 1
            continue
        if ch == "{":
            brace_depth += 1
            index += 1
            continue
        if ch == "}":
            if brace_depth > 0:
                brace_depth -= 1
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
        if ch == "<":
            angle_depth += 1
            index += 1
            continue
        if ch == ">":
            if angle_depth > 0:
                angle_depth -= 1
            index += 1
            continue
        if paren_depth == 0  and  brace_depth == 0  and  bracket_depth == 0  and  angle_depth == 0:
            if ch == "|":
                return index
        index += 1
    return -1

def split_union_annotations(text):
    result = []
    remaining = text
    while True:
        index = find_top_level_union_separator(remaining)
        if index < 0:
            tail = trim_text(remaining)
            if len(tail) > 0:
                result = append_string(result, tail)
            break
        left = trim_text(substring(remaining, 0, index))
        if len(left) > 0:
            result = append_string(result, left)
        remaining = trim_text(substring(remaining, index + 1, len(remaining)))
    return result

def is_union_annotation(annotation):
    trimmed = trim_text(annotation)
    if len(trimmed) == 0:
        return False
    return find_top_level_union_separator(trimmed) >= 0

def map_union_type(context, annotation):
    normalized = unwrap_move_wrapper(trim_text(annotation))
    if not is_union_annotation(normalized):
        return ""
    parts = split_union_annotations(normalized)
    if len(parts) < 2:
        return ""
    llvm_parts = []
    index = 0
    while True:
        if index >= len(parts):
            break
        part = trim_text(parts[index])
        if len(part) == 0:
            return ""
        mapped = map_type_annotation(part)
        if len(mapped) == 0  or  mapped == "void":
            return ""
        llvm_parts = append_string(llvm_parts, mapped)
        index += 1
    return "{ i32, " + join_with_separator(llvm_parts, ", ") + " }"

def map_return_type(context, return_type):
    trimmed = trim_text(return_type)
    if len(trimmed) == 0  or  trimmed == "void":
        return "void"
    normalized = unwrap_move_wrapper(trimmed)
    if starts_with(normalized, "*"):
        remainder = trim_text(substring(normalized, 1, len(normalized)))
        if starts_with(remainder, "mut"):
            remainder = trim_text(substring(remainder, 3, len(remainder)))
        if remainder == "opaque"  or  len(remainder) == 0:
            return "i8*"
        inner = map_return_type(context, remainder)
        if ends_with_pointer_suffix(inner):
            return inner
        if len(inner) == 0  or  inner == "void":
            return "i8*"
        return inner + "*"
    union_type = map_union_type(context, normalized)
    if len(union_type) > 0:
        return union_type
    optional_type = map_optional_type(context, normalized)
    if len(optional_type) > 0:
        return optional_type
    reference_type = map_reference_type(context, normalized)
    if len(reference_type) > 0:
        return reference_type
    array_type = map_array_pointer_type(context, normalized)
    if len(array_type) > 0:
        return array_type
    primitive_type = map_primitive_type(context, normalized)
    if len(primitive_type) > 0:
        return primitive_type
    return "i8*"

def future_pointer_type_for_return_type(return_type):
    trimmed = trim_text(return_type)
    if len(trimmed) == 0  or  trimmed == "void":
        return "%SailfinFutureVoid*"
    normalized = unwrap_move_wrapper(trimmed)
    if normalized == "number":
        return "%SailfinFutureNumber*"
    if normalized == "boolean"  or  normalized == "bool":
        return "%SailfinFutureBool*"
    if normalized == "string":
        return "%SailfinFutureString*"
    return "%SailfinFuturePtr*"

def await_symbol_for_future_pointer_type(future_ptr_type):
    if future_ptr_type == "%SailfinFutureNumber*":
        return "sailfin_runtime_await_number"
    if future_ptr_type == "%SailfinFutureBool*":
        return "sailfin_runtime_await_bool"
    if future_ptr_type == "%SailfinFutureVoid*":
        return "sailfin_runtime_await_void"
    if future_ptr_type == "%SailfinFutureString*":
        return "sailfin_runtime_await_string"
    if future_ptr_type == "%SailfinFuturePtr*":
        return "sailfin_runtime_await_ptr"
    return ""

def map_parameter_type(context, parameter_type):
    trimmed = trim_text(parameter_type)
    if len(trimmed) == 0:
        return "double"
    normalized = unwrap_move_wrapper(trimmed)
    if starts_with(normalized, "*"):
        remainder = trim_text(substring(normalized, 1, len(normalized)))
        if starts_with(remainder, "mut"):
            remainder = trim_text(substring(remainder, 3, len(remainder)))
        if remainder == "opaque"  or  len(remainder) == 0:
            return "i8*"
        inner = map_parameter_type(context, remainder)
        if ends_with_pointer_suffix(inner):
            return inner
        if len(inner) == 0:
            return "i8*"
        return inner + "*"
    union_type = map_union_type(context, normalized)
    if len(union_type) > 0:
        return union_type
    optional_type = map_optional_type(context, normalized)
    if len(optional_type) > 0:
        return optional_type
    reference_type = map_reference_type(context, normalized)
    if len(reference_type) > 0:
        return reference_type
    array_type = map_array_pointer_type(context, normalized)
    if len(array_type) > 0:
        return array_type
    primitive_type = map_primitive_type(context, normalized)
    if len(primitive_type) > 0:
        return primitive_type
    return "i8*"

def lower_logical_not_with_operand(operand, temp_index, lines, diagnostics, string_constants):
    coerced = coerce_operand_to_type(operand, "i1", temp_index, lines)
    current_diagnostics = (diagnostics) + (coerced.diagnostics)
    current_lines = coerced.lines
    current_temp = coerced.temp_index
    if coerced.operand != None:
        bool_operand = coerced.operand
        result_temp = format_temp_name(current_temp)
        current_lines = append_string(current_lines, "  " + result_temp + " = xor i1 " + bool_operand.value + ", 1")
        current_temp += 1
        result_operand = LLVMOperand(llvm_type="i1", value=result_temp)
        return ExpressionResult(lines=current_lines, temp_index=current_temp, operand=result_operand, diagnostics=current_diagnostics, string_constants=string_constants)
    return ExpressionResult(lines=current_lines, temp_index=current_temp, operand=None, diagnostics=current_diagnostics, string_constants=string_constants)

def lower_logical_not_result(result, base_diagnostics):
    combined = (base_diagnostics) + (result.diagnostics)
    if result.operand == None:
        return ExpressionResult(lines=result.lines, temp_index=result.temp_index, operand=None, diagnostics=combined, string_constants=result.string_constants)
    return lower_logical_not_with_operand(result.operand, result.temp_index, result.lines, combined, result.string_constants)

def lower_expression(expression, bindings, locals, temp_index, lines, functions, context, expected_type):
    trimmed = trim_text(expression)
    diagnostics = []
    empty_constants = empty_string_constant_set()
    if len(trimmed) == 0:
        diagnostics = append_string(diagnostics, "llvm lowering: empty expression encountered")
        return ExpressionResult(lines=lines, temp_index=temp_index, operand=None, diagnostics=diagnostics, string_constants=empty_constants)
    stripped = strip_enclosing_parentheses(trimmed)
    if stripped != trimmed:
        return lower_expression(stripped, bindings, locals, temp_index, lines, functions, context, expected_type)
    if is_boolean_literal(stripped):
        value = "0"
        if matches_case_insensitive(trim_text(stripped), "true"):
            value = "1"
        operand = LLVMOperand(llvm_type="i1", value=value)
        return ExpressionResult(lines=lines, temp_index=temp_index, operand=operand, diagnostics=diagnostics, string_constants=empty_constants)
    if is_null_literal(stripped):
        trimmed_expected = trim_text(expected_type)
        null_type = "i8*"
        if len(trimmed_expected) > 0  and  ends_with_pointer_suffix(trimmed_expected):
            null_type = trimmed_expected
        operand = LLVMOperand(llvm_type=null_type, value="null")
        return ExpressionResult(lines=lines, temp_index=temp_index, operand=operand, diagnostics=diagnostics, string_constants=empty_constants)
    if is_number_literal(stripped):
        trimmed_expected = trim_text(expected_type)
        if trimmed_expected == "i64"  or  trimmed_expected == "i32"  and  is_integer_literal(stripped):
            operand = LLVMOperand(llvm_type=trimmed_expected, value=trim_text(stripped))
            return ExpressionResult(lines=lines, temp_index=temp_index, operand=operand, diagnostics=diagnostics, string_constants=empty_constants)
        normalized = normalise_number_literal(stripped)
        operand = LLVMOperand(llvm_type="double", value=normalized)
        return ExpressionResult(lines=lines, temp_index=temp_index, operand=operand, diagnostics=diagnostics, string_constants=empty_constants)
    if is_string_literal(stripped):
        interpolated = try_lower_interpolated_string_literal(stripped, bindings, locals, temp_index, lines, functions, context)
        if interpolated != None:
            result = interpolated
            diagnostics = (diagnostics) + (result.diagnostics)
            return ExpressionResult(lines=result.lines, temp_index=result.temp_index, operand=result.operand, diagnostics=diagnostics, string_constants=result.string_constants)
        literal_result = lower_string_literal(stripped, temp_index, lines)
        diagnostics = (diagnostics) + (literal_result.diagnostics)
        return ExpressionResult(lines=literal_result.lines, temp_index=literal_result.temp_index, operand=literal_result.operand, diagnostics=diagnostics, string_constants=literal_result.string_constants)
    if starts_with(stripped, "await"):
        if len(stripped) == 5:
            diagnostics = append_string(diagnostics, "llvm lowering: await expression missing operand")
            return ExpressionResult(lines=lines, temp_index=temp_index, operand=None, diagnostics=diagnostics, string_constants=empty_constants)
        next = char_at(stripped, 5)
        if next == " "  or  next == "\t"  or  next == "(":
            remainder = trim_text(substring(stripped, 5, len(stripped)))
            if len(remainder) == 0:
                diagnostics = append_string(diagnostics, "llvm lowering: await expression missing operand")
                return ExpressionResult(lines=lines, temp_index=temp_index, operand=None, diagnostics=diagnostics, string_constants=empty_constants)
            lowered = lower_expression(remainder, bindings, locals, temp_index, lines, functions, context, expected_type)
            combined = (diagnostics) + (lowered.diagnostics)
            if lowered.operand == None:
                return ExpressionResult(lines=lowered.lines, temp_index=lowered.temp_index, operand=None, diagnostics=combined, string_constants=lowered.string_constants)
            future_operand = lowered.operand
            await_symbol = await_symbol_for_future_pointer_type(future_operand.llvm_type)
            if len(await_symbol) == 0:
                with_issue = append_string(combined, "llvm lowering: await expects a Future pointer, got `" + future_operand.llvm_type + "`")
                return ExpressionResult(lines=lowered.lines, temp_index=lowered.temp_index, operand=None, diagnostics=with_issue, string_constants=lowered.string_constants)
            if future_operand.llvm_type == "%SailfinFutureVoid*":
                awaited_lines = append_string(lowered.lines, "  call void @" + await_symbol + "(%SailfinFutureVoid* " + future_operand.value + ")")
                out_operand = LLVMOperand(llvm_type="void", value="")
                return ExpressionResult(lines=awaited_lines, temp_index=lowered.temp_index, operand=out_operand, diagnostics=combined, string_constants=lowered.string_constants)
            result_type = "i8*"
            if future_operand.llvm_type == "%SailfinFutureNumber*":
                result_type = "double"
            else:
                if future_operand.llvm_type == "%SailfinFutureBool*":
                    result_type = "i1"
            result_temp = format_temp_name(lowered.temp_index)
            awaited_call = "  " + result_temp + " = call " + result_type + " @" + await_symbol + "(" + future_operand.llvm_type + " " + future_operand.value + ")"
            awaited_lines2 = append_string(lowered.lines, awaited_call)
            trimmed_expected = trim_text(expected_type)
            if future_operand.llvm_type == "%SailfinFuturePtr*"  and  len(trimmed_expected) > 0  and  trimmed_expected != "i8*"  and  not ends_with_pointer_suffix(trimmed_expected):
                typed_ptr_temp = format_temp_name(lowered.temp_index + 1)
                load_temp = format_temp_name(lowered.temp_index + 2)
                awaited_lines2 = append_string(awaited_lines2, "  " + typed_ptr_temp + " = bitcast i8* " + result_temp + " to " + trimmed_expected + "*")
                awaited_lines2 = append_string(awaited_lines2, "  " + load_temp + " = load " + trimmed_expected + ", " + trimmed_expected + "* " + typed_ptr_temp)
                awaited_lines2 = append_string(awaited_lines2, "  call void @free(i8* " + result_temp + ")")
                out_operand_unboxed = LLVMOperand(llvm_type=trimmed_expected, value=load_temp)
                return ExpressionResult(lines=awaited_lines2, temp_index=lowered.temp_index + 3, operand=out_operand_unboxed, diagnostics=combined, string_constants=lowered.string_constants)
            out_operand2 = LLVMOperand(llvm_type=result_type, value=result_temp)
            return ExpressionResult(lines=awaited_lines2, temp_index=lowered.temp_index + 1, operand=out_operand2, diagnostics=combined, string_constants=lowered.string_constants)
    ternary_parse = parse_ternary_expression(stripped)
    if ternary_parse.success:
        return lower_ternary_expression(ternary_parse, bindings, locals, temp_index, lines, functions, context, expected_type)
    cast_parse = parse_cast_expression(stripped)
    if cast_parse.recognized:
        return lower_cast_expression(cast_parse, bindings, locals, temp_index, lines, functions, context)
    raw_address_parse = parse_raw_address_expression(stripped)
    if raw_address_parse.recognized:
        return lower_raw_address_expression(raw_address_parse, bindings, locals, temp_index, lines)
    borrow_parse = parse_borrow_expression(stripped)
    if borrow_parse.recognized:
        return lower_borrow_expression(borrow_parse, bindings, locals, temp_index, lines)
    logical = find_logical_operator(stripped)
    if logical.success:
        if logical.symbol == "&&":
            return lower_logical_and(stripped, logical, bindings, locals, temp_index, lines, functions, context)
        if logical.symbol == "||":
            return lower_logical_or(stripped, logical, bindings, locals, temp_index, lines, functions, context)
    comparison = find_comparison_operator(stripped)
    if comparison.success:
        return lower_comparison_operation(stripped, comparison, bindings, locals, temp_index, lines, functions, context)
    additive = find_top_level_operator(stripped, "+-")
    if additive.success:
        return lower_binary_operation(stripped, additive, bindings, locals, temp_index, lines, functions, context)
    multiplicative = find_top_level_operator(stripped, "*/%")
    if multiplicative.success:
        return lower_binary_operation(stripped, multiplicative, bindings, locals, temp_index, lines, functions, context)
    if len(stripped) > 0:
        if char_code_at_text(stripped, 0) == char_code("!"):
            operand_text = trim_text(substring(stripped, 1, len(stripped)))
            if len(operand_text) > 0:
                lowered_operand = lower_expression(operand_text, bindings, locals, temp_index, lines, functions, context, "")
                return lower_logical_not_result(lowered_operand, diagnostics)
        if char_code_at_text(stripped, 0) == char_code("*"):
            operand_text = trim_text(substring(stripped, 1, len(stripped)))
            if len(operand_text) == 0:
                diagnostics = append_string(diagnostics, "llvm lowering: deref expression missing operand")
                return ExpressionResult(lines=lines, temp_index=temp_index, operand=None, diagnostics=diagnostics, string_constants=empty_constants)
            lowered_ptr = lower_expression(operand_text, bindings, locals, temp_index, lines, functions, context, "")
            combined = (diagnostics) + (lowered_ptr.diagnostics)
            if lowered_ptr.operand == None:
                return ExpressionResult(lines=lowered_ptr.lines, temp_index=lowered_ptr.temp_index, operand=None, diagnostics=combined, string_constants=lowered_ptr.string_constants)
            ptr_operand = lowered_ptr.operand
            if not ends_with_pointer_suffix(ptr_operand.llvm_type):
                with_issue = append_string(combined, "llvm lowering: cannot dereference non-pointer type `" + ptr_operand.llvm_type + "`")
                return ExpressionResult(lines=lowered_ptr.lines, temp_index=lowered_ptr.temp_index, operand=None, diagnostics=with_issue, string_constants=lowered_ptr.string_constants)
            element_type = strip_pointer_suffix(ptr_operand.llvm_type)
            load_name = format_temp_name(lowered_ptr.temp_index)
            updated_lines = append_string(lowered_ptr.lines, "  " + load_name + " = load " + element_type + ", " + element_type + "* " + ptr_operand.value)
            operand = LLVMOperand(llvm_type=element_type, value=load_name)
            return ExpressionResult(lines=updated_lines, temp_index=lowered_ptr.temp_index + 1, operand=operand, diagnostics=combined, string_constants=lowered_ptr.string_constants)
    call_index = find_call_site(stripped)
    if call_index >= 0  and  char_code_at_text(stripped, len(stripped) - 1) == char_code(")"):
        target = trim_text(substring(stripped, 0, call_index))
        arguments_text = substring(stripped, call_index + 1, len(stripped) - 1)
        argument_entries = split_call_arguments(arguments_text)
        member_target = parse_member_access(target)
        if member_target.success  and  member_target.field == "concat":
            receiver_name = trim_text(member_target.base)
            if is_simple_identifier(receiver_name):
                local = find_local_binding(locals, receiver_name)
                if local != None:
                    element_type = array_pointer_element_type(local.llvm_type)
                    if element_type == "i8*":
                        rewritten_args = [member_target.base]
                        arg_index = 0
                        while True:
                            if arg_index >= len(argument_entries):
                                break
                            rewritten_args = (rewritten_args) + ([argument_entries[arg_index]])
                            arg_index += 1
                        return lower_call_expression("concat", rewritten_args, bindings, locals, temp_index, lines, functions, context)
                else:
                    param = find_parameter_binding(bindings, receiver_name)
                    if param != None:
                        element_type = array_pointer_element_type(param.llvm_type)
                        if element_type == "i8*":
                            rewritten_args = [member_target.base]
                            arg_index = 0
                            while True:
                                if arg_index >= len(argument_entries):
                                    break
                                rewritten_args = (rewritten_args) + ([argument_entries[arg_index]])
                                arg_index += 1
                            return lower_call_expression("concat", rewritten_args, bindings, locals, temp_index, lines, functions, context)
        return lower_call_expression(target, argument_entries, bindings, locals, temp_index, lines, functions, context)
    if len(stripped) >= 2:
        first_code = char_code_at_text(stripped, 0)
        last_code = char_code_at_text(stripped, len(stripped) - 1)
        if first_code == char_code("[")  and  last_code == char_code("]"):
            return lower_array_literal(stripped, bindings, locals, temp_index, lines, functions, context, expected_type)
    enum_parse = parse_enum_literal(stripped)
    if enum_parse.recognized  and  enum_parse.success:
        enum_info = resolve_enum_info_for_literal(context, enum_parse.enum_name)
        if enum_info != None:
            lowered_enum = lower_enum_literal(enum_parse, bindings, locals, temp_index, lines, functions, context, expected_type)
            combined = (diagnostics) + (lowered_enum.diagnostics)
            return ExpressionResult(lines=lowered_enum.lines, temp_index=lowered_enum.temp_index, operand=lowered_enum.operand, diagnostics=combined, string_constants=lowered_enum.string_constants)
    struct_parse = parse_struct_literal(stripped)
    if struct_parse.recognized:
        if not struct_parse.success:
            diagnostics = (diagnostics) + (struct_parse.diagnostics)
            return ExpressionResult(lines=lines, temp_index=temp_index, operand=None, diagnostics=diagnostics, string_constants=empty_constants)
        lowered_struct = lower_struct_literal(struct_parse, bindings, locals, temp_index, lines, functions, context, expected_type)
        combined = (diagnostics) + (lowered_struct.diagnostics)
        return ExpressionResult(lines=lowered_struct.lines, temp_index=lowered_struct.temp_index, operand=lowered_struct.operand, diagnostics=combined, string_constants=lowered_struct.string_constants)
    index_parse = parse_index_expression(stripped)
    if index_parse.success:
        return lower_index_expression(index_parse, bindings, locals, temp_index, lines, functions, context)
    member_parse = parse_member_access(stripped)
    if member_parse.success:
        return lower_member_access(member_parse, bindings, locals, temp_index, lines, functions, context, expected_type)
    parameter = find_parameter_binding(bindings, stripped)
    if parameter != None:
        operand = LLVMOperand(llvm_type=parameter.llvm_type, value=parameter.llvm_name)
        return ExpressionResult(lines=lines, temp_index=temp_index, operand=operand, diagnostics=diagnostics, string_constants=empty_constants)
    local = find_local_binding(locals, stripped)
    if local != None:
        load_result = load_local_operand(local, temp_index, lines)
        diagnostics = (diagnostics) + (load_result.diagnostics)
        return ExpressionResult(lines=load_result.lines, temp_index=load_result.temp_index, operand=load_result.operand, diagnostics=diagnostics, string_constants=empty_constants)
    diagnostics = append_string(diagnostics, "llvm lowering: unable to lower expression `" + expression + "`")
    return ExpressionResult(lines=lines, temp_index=temp_index, operand=None, diagnostics=diagnostics, string_constants=empty_constants)

def parse_borrow_expression(expression):
    trimmed = trim_text(expression)
    diagnostics = []
    if len(trimmed) == 0:
        return BorrowParseResult(recognized=False, success=False, target="", mutable=False, diagnostics=diagnostics)
    is_prefix_form = False
    remainder = ""
    mutable_flag = False
    if starts_with(trimmed, "&"):
        if starts_with(trimmed, "&&"):
            return BorrowParseResult(recognized=False, success=False, target="", mutable=False, diagnostics=diagnostics)
        is_prefix_form = True
        remainder = trim_text(substring(trimmed, 1, len(trimmed)))
    else:
        after_keyword = ""
        if starts_with(trimmed, "borrow_mut"):
            after_keyword = trim_text(substring(trimmed, 10, len(trimmed)))
            mutable_flag = True
        else:
            if starts_with(trimmed, "borrow"):
                after_keyword = trim_text(substring(trimmed, 6, len(trimmed)))
            else:
                return BorrowParseResult(recognized=False, success=False, target="", mutable=False, diagnostics=diagnostics)
        if len(after_keyword) == 0  or  after_keyword[0] != "(":
            return BorrowParseResult(recognized=False, success=False, target="", mutable=False, diagnostics=diagnostics)
        remainder = after_keyword
    if is_prefix_form:
        if starts_with(remainder, "mut"):
            mutable_flag = True
            after_mut = substring(remainder, 3, len(remainder))
            remainder = trim_text(after_mut)
    if len(remainder) == 0:
        issue = append_string(diagnostics, "llvm lowering: borrow expression missing target")
        return BorrowParseResult(recognized=True, success=False, target="", mutable=mutable_flag, diagnostics=issue)
    if len(remainder) > 0  and  remainder[0] == "(":
        argument_parse = extract_borrow_argument(remainder)
        messages = (diagnostics) + (argument_parse.diagnostics)
        if not argument_parse.success:
            return BorrowParseResult(recognized=True, success=False, target="", mutable=mutable_flag, diagnostics=messages)
        argument_text = argument_parse.argument
        if starts_with(argument_text, "mut"):
            after_mut = substring(argument_text, 3, len(argument_text))
            trimmed_after_mut = trim_text(after_mut)
            if len(trimmed_after_mut) > 0:
                mutable_flag = True
                argument_text = trimmed_after_mut
        if len(argument_text) == 0:
            messages = append_string(messages, "llvm lowering: borrow expression missing target")
            return BorrowParseResult(recognized=True, success=False, target="", mutable=mutable_flag, diagnostics=messages)
        if not is_valid_borrow_target(argument_text):
            return BorrowParseResult(recognized=False, success=False, target="", mutable=mutable_flag, diagnostics=diagnostics)
        return BorrowParseResult(recognized=True, success=True, target=argument_text, mutable=mutable_flag, diagnostics=messages)
    simple_parse = extract_simple_borrow_target(remainder)
    if not simple_parse.success:
        return BorrowParseResult(recognized=False, success=False, target="", mutable=mutable_flag, diagnostics=diagnostics)
    if not is_valid_borrow_target(simple_parse.argument):
        return BorrowParseResult(recognized=False, success=False, target="", mutable=mutable_flag, diagnostics=diagnostics)
    return BorrowParseResult(recognized=True, success=True, target=simple_parse.argument, mutable=mutable_flag, diagnostics=diagnostics)

def extract_borrow_argument(text):
    diagnostics = []
    depth = 0
    index = 0
    closing_index = -1
    while True:
        if index >= len(text):
            break
        ch = text[index]
        if ch == "(":
            depth += 1
            index += 1
            continue
        if ch == ")":
            if depth == 0:
                diagnostics = append_string(diagnostics, "llvm lowering: borrow expression missing opening `(`")
                return BorrowArgumentParse(success=False, argument="", diagnostics=diagnostics)
            depth -= 1
            current_index = index
            index += 1
            if depth == 0:
                closing_index = current_index
                break
            continue
        index += 1
    if closing_index < 0:
        diagnostics = append_string(diagnostics, "llvm lowering: borrow expression missing closing `)`")
        return BorrowArgumentParse(success=False, argument="", diagnostics=diagnostics)
    inner = substring(text, 1, closing_index)
    remainder = trim_text(substring(text, closing_index + 1, len(text)))
    if len(remainder) > 0:
        diagnostics = append_string(diagnostics, "llvm lowering: borrow expression trailing content `" + remainder + "`")
        return BorrowArgumentParse(success=False, argument="", diagnostics=diagnostics)
    return BorrowArgumentParse(success=True, argument=trim_text(inner), diagnostics=diagnostics)

def extract_simple_borrow_target(text):
    diagnostics = []
    trimmed = trim_text(text)
    if len(trimmed) == 0:
        diagnostics = append_string(diagnostics, "llvm lowering: borrow expression missing target")
        return BorrowArgumentParse(success=False, argument="", diagnostics=diagnostics)
    index = 0
    while True:
        if index >= len(trimmed):
            break
        ch = trimmed[index]
        if is_effect_delimiter(ch):
            break
        index += 1
    target = trim_text(substring(trimmed, 0, index))
    if len(target) == 0:
        diagnostics = append_string(diagnostics, "llvm lowering: borrow expression missing target")
        return BorrowArgumentParse(success=False, argument="", diagnostics=diagnostics)
    remainder = trim_text(substring(trimmed, index, len(trimmed)))
    if len(remainder) > 0:
        diagnostics = append_string(diagnostics, "llvm lowering: borrow expression trailing content `" + remainder + "`")
        return BorrowArgumentParse(success=False, argument=target, diagnostics=diagnostics)
    return BorrowArgumentParse(success=True, argument=target, diagnostics=diagnostics)

def is_valid_borrow_target(text):
    trimmed = trim_text(text)
    if len(trimmed) == 0:
        return False
    index = 0
    while True:
        if index >= len(trimmed):
            break
        ch = trimmed[index]
        if ch == ".":
            index += 1
            continue
        if index == 0:
            if not is_identifier_start_char(ch):
                return False
        else:
            if not is_identifier_part_char(ch):
                return False
        index += 1
    return True

def parse_ternary_expression(text):
    diagnostics = []
    trimmed = trim_text(text)
    if len(trimmed) == 0:
        return TernaryParseResult(success=False, condition="", true_value="", false_value="", diagnostics=diagnostics)
    depth = 0
    question_index = -1
    colon_index = -1
    index = 0
    while True:
        if index >= len(trimmed):
            break
        ch = trimmed[index]
        if ch == "("  or  ch == "["  or  ch == "{":
            depth += 1
            index += 1
            continue
        if ch == ")"  or  ch == "]"  or  ch == "}":
            depth -= 1
            index += 1
            continue
        if depth == 0:
            if ch == "?"  and  question_index < 0:
                question_index = index
                index += 1
                continue
            if ch == ":"  and  question_index >= 0  and  colon_index < 0:
                colon_index = index
                index += 1
                continue
        index += 1
    if question_index < 0  or  colon_index < 0:
        return TernaryParseResult(success=False, condition="", true_value="", false_value="", diagnostics=diagnostics)
    if question_index >= colon_index:
        diagnostics = append_string(diagnostics, "llvm lowering: malformed ternary expression - `:` before `?`")
        return TernaryParseResult(success=False, condition="", true_value="", false_value="", diagnostics=diagnostics)
    condition = trim_text(substring(trimmed, 0, question_index))
    true_value = trim_text(substring(trimmed, question_index + 1, colon_index))
    false_value = trim_text(substring(trimmed, colon_index + 1, len(trimmed)))
    if len(condition) == 0:
        diagnostics = append_string(diagnostics, "llvm lowering: ternary expression missing condition")
        return TernaryParseResult(success=False, condition="", true_value="", false_value="", diagnostics=diagnostics)
    if len(true_value) == 0:
        diagnostics = append_string(diagnostics, "llvm lowering: ternary expression missing true branch value")
        return TernaryParseResult(success=False, condition="", true_value="", false_value="", diagnostics=diagnostics)
    if len(false_value) == 0:
        diagnostics = append_string(diagnostics, "llvm lowering: ternary expression missing false branch value")
        return TernaryParseResult(success=False, condition="", true_value="", false_value="", diagnostics=diagnostics)
    return TernaryParseResult(success=True, condition=condition, true_value=true_value, false_value=false_value, diagnostics=diagnostics)

def analyze_value_ownership(initializer, span, locals, bindings):
    if initializer == None:
        return OwnershipAnalysis(ownership=None, consumption=None, diagnostics=[])
    trimmed = trim_text(initializer)
    if len(trimmed) == 0:
        return OwnershipAnalysis(ownership=None, consumption=None, diagnostics=[])
    parse = parse_borrow_expression(trimmed)
    diagnostics = parse.diagnostics
    if parse.recognized:
        if not parse.success:
            return OwnershipAnalysis(ownership=None, consumption=None, diagnostics=diagnostics)
        resolved_base = resolve_borrow_base(parse.target, locals)
        if len(resolved_base) == 0:
            diagnostics = append_string(diagnostics, "llvm lowering: borrow expression missing target")
            return OwnershipAnalysis(ownership=None, consumption=None, diagnostics=diagnostics)
        ownership = OwnershipInfo(variant="Borrow", base=resolved_base, mutable=parse.mutable, span=span, region_id=-1)
        return OwnershipAnalysis(ownership=ownership, consumption=None, diagnostics=diagnostics)
    if is_simple_identifier(trimmed):
        name = trimmed
        local = find_local_binding(locals, name)
        if local != None:
            if local.consumed:
                diagnostics = append_string(diagnostics, format_use_after_move_message(name, span))
                return OwnershipAnalysis(ownership=None, consumption=None, diagnostics=diagnostics)
            if is_copy_type(local.type_annotation, local.llvm_type):
                return OwnershipAnalysis(ownership=None, consumption=None, diagnostics=diagnostics)
            consumption = OwnershipConsumption(kind="local", name=name)
            return OwnershipAnalysis(ownership=None, consumption=consumption, diagnostics=diagnostics)
        parameter = find_parameter_binding(bindings, name)
        if parameter != None:
            if parameter.consumed:
                diagnostics = append_string(diagnostics, format_use_after_move_message(name, span))
                return OwnershipAnalysis(ownership=None, consumption=None, diagnostics=diagnostics)
            if is_copy_type(parameter.type_annotation, parameter.llvm_type):
                return OwnershipAnalysis(ownership=None, consumption=None, diagnostics=diagnostics)
            consumption = OwnershipConsumption(kind="parameter", name=name)
            return OwnershipAnalysis(ownership=None, consumption=consumption, diagnostics=diagnostics)
    return OwnershipAnalysis(ownership=None, consumption=None, diagnostics=diagnostics)

def format_use_after_move_message(name, span):
    if span == None:
        return "llvm lowering: use-after-move of `" + name + "`"
    return "llvm lowering: use-after-move of `" + name + "` at " + format_span_location(span)

def format_span_location(span):
    start = number_to_string(span.start_line) + ":" + number_to_string(span.start_column)
    end = number_to_string(span.end_line) + ":" + number_to_string(span.end_column)
    return start + "-" + end

def format_suspension_location(keyword, borrow_span, suspension_span):
    has_segment = False
    combined = ""
    if borrow_span != None:
        combined = "borrow at " + format_span_location(borrow_span)
        has_segment = True
    if suspension_span != None:
        label = keyword
        if len(label) == 0:
            label = "suspend"
        segment = label + " at " + format_span_location(suspension_span)
        if has_segment:
            combined = combined + "; " + segment
        else:
            combined = segment
            has_segment = True
    if not has_segment:
        return ""
    return " (" + combined + ")"

def detect_borrow_conflicts(ownership, locals, binding_name, function_name):
    diagnostics = []
    if ownership == None:
        return diagnostics
    if ownership.variant != "Borrow":
        return diagnostics
    base = trim_text(ownership.base)
    index = 0
    while True:
        if index >= len(locals):
            break
        existing = locals[index]
        if existing.ownership != None:
            details = existing.ownership
            if details.variant == "Borrow":
                existing_base = trim_text(details.base)
                if existing_base == base:
                    if ownership.mutable:
                        if details.mutable:
                            diagnostics = append_string(diagnostics, "llvm lowering: mutable borrow `" + binding_name + "` conflicts with active mutable borrow `" + existing.name + "` of `" + base + "` in `" + function_name + "`")
                        else:
                            diagnostics = append_string(diagnostics, "llvm lowering: mutable borrow `" + binding_name + "` conflicts with active shared borrow `" + existing.name + "` of `" + base + "` in `" + function_name + "`")
                    else:
                        if details.mutable:
                            diagnostics = append_string(diagnostics, "llvm lowering: shared borrow `" + binding_name + "` conflicts with active mutable borrow `" + existing.name + "` of `" + base + "` in `" + function_name + "`")
        index += 1
    return diagnostics

def resolve_borrow_base(target, locals):
    return resolve_borrow_base_inner(trim_text(target), locals, 0)

def resolve_borrow_base_inner(target, locals, depth):
    trimmed = trim_text(target)
    if len(trimmed) == 0:
        return trimmed
    if depth >= 8:
        return trimmed
    if not is_simple_identifier(trimmed):
        return trimmed
    binding = find_local_binding(locals, trimmed)
    if binding == None:
        return trimmed
    if binding.ownership == None:
        return trimmed
    details = binding.ownership
    if details.variant != "Borrow":
        return trimmed
    return resolve_borrow_base_inner(details.base, locals, depth + 1)

def lower_borrow_expression(parse, bindings, locals, temp_index, lines):
    diagnostics = parse.diagnostics
    empty_constants = empty_string_constant_set()
    if not parse.success:
        return ExpressionResult(lines=lines, temp_index=temp_index, operand=None, diagnostics=diagnostics, string_constants=empty_constants)
    target = strip_enclosing_parentheses(parse.target)
    target = trim_text(target)
    if len(target) == 0:
        diagnostics = append_string(diagnostics, "llvm lowering: borrow expression missing target")
        return ExpressionResult(lines=lines, temp_index=temp_index, operand=None, diagnostics=diagnostics, string_constants=empty_constants)
    local = find_local_binding(locals, target)
    if local == None:
        parameter = find_parameter_binding(bindings, target)
        if parameter == None:
            diagnostics = append_string(diagnostics, "llvm lowering: borrow target `" + target + "` not found")
            return ExpressionResult(lines=lines, temp_index=temp_index, operand=None, diagnostics=diagnostics, string_constants=empty_constants)
        if ends_with(parameter.llvm_type, "*"):
            operand = LLVMOperand(llvm_type=parameter.llvm_type, value=parameter.llvm_name)
            return ExpressionResult(lines=lines, temp_index=temp_index, operand=operand, diagnostics=diagnostics, string_constants=empty_constants)
        diagnostics = append_string(diagnostics, "llvm lowering: cannot borrow non-addressable parameter `" + target + "` (type `" + parameter.llvm_type + "`)")
        return ExpressionResult(lines=lines, temp_index=temp_index, operand=None, diagnostics=diagnostics, string_constants=empty_constants)
    pointer_type = local.llvm_type + "*"
    operand = LLVMOperand(llvm_type=pointer_type, value=local.pointer)
    return ExpressionResult(lines=lines, temp_index=temp_index, operand=operand, diagnostics=diagnostics, string_constants=empty_constants)

def lower_ternary_expression(parse, bindings, locals, temp_index, lines, functions, context, expected_type):
    diagnostics = parse.diagnostics
    string_constants = empty_string_constant_set()
    label_id = number_to_string(temp_index)
    cond_label = "ternary_cond_" + label_id
    then_label = "ternary_then_" + label_id
    else_label = "ternary_else_" + label_id
    merge_label = "ternary_merge_" + label_id
    label_temp_offset = temp_index + 1
    cond_result = lower_expression(parse.condition, bindings, locals, label_temp_offset, lines, functions, context, "")
    diagnostics = (diagnostics) + (cond_result.diagnostics)
    string_constants = cond_result.string_constants
    if cond_result.operand == None:
        return ExpressionResult(lines=cond_result.lines, temp_index=cond_result.temp_index, operand=None, diagnostics=diagnostics, string_constants=string_constants)
    cond_bool = coerce_operand_to_type(cond_result.operand, "i1", cond_result.temp_index, cond_result.lines)
    diagnostics = (diagnostics) + (cond_bool.diagnostics)
    if cond_bool.operand == None:
        return ExpressionResult(lines=cond_bool.lines, temp_index=cond_bool.temp_index, operand=None, diagnostics=diagnostics, string_constants=string_constants)
    current_lines = cond_bool.lines
    current_lines = append_string(current_lines, "  br label %" + cond_label)
    current_lines = append_string(current_lines, "")
    current_lines = append_string(current_lines, cond_label + ":")
    current_lines = append_string(current_lines, "  br i1 " + cond_bool.operand.value + ", label %" + then_label + ", label %" + else_label)
    current_lines = append_string(current_lines, "")
    current_lines = append_string(current_lines, then_label + ":")
    then_result = lower_expression(parse.true_value, bindings, locals, cond_bool.temp_index, current_lines, functions, context, expected_type)
    diagnostics = (diagnostics) + (then_result.diagnostics)
    string_constants = merge_string_constants(string_constants, then_result.string_constants)
    if then_result.operand == None:
        return ExpressionResult(lines=then_result.lines, temp_index=then_result.temp_index, operand=None, diagnostics=diagnostics, string_constants=string_constants)
    then_end_label = "ternary_then_end_" + label_id
    current_lines = then_result.lines
    current_lines = append_string(current_lines, "  br label %" + then_end_label)
    current_lines = append_string(current_lines, "")
    current_lines = append_string(current_lines, then_end_label + ":")
    current_lines = append_string(current_lines, "  br label %" + merge_label)
    current_lines = append_string(current_lines, "")
    current_lines = append_string(current_lines, else_label + ":")
    else_result = lower_expression(parse.false_value, bindings, locals, then_result.temp_index, current_lines, functions, context, expected_type)
    diagnostics = (diagnostics) + (else_result.diagnostics)
    string_constants = merge_string_constants(string_constants, else_result.string_constants)
    if else_result.operand == None:
        return ExpressionResult(lines=else_result.lines, temp_index=else_result.temp_index, operand=None, diagnostics=diagnostics, string_constants=string_constants)
    else_end_label = "ternary_else_end_" + label_id
    current_lines = else_result.lines
    current_lines = append_string(current_lines, "  br label %" + else_end_label)
    current_lines = append_string(current_lines, "")
    current_lines = append_string(current_lines, else_end_label + ":")
    current_lines = append_string(current_lines, "  br label %" + merge_label)
    current_lines = append_string(current_lines, "")
    current_lines = append_string(current_lines, merge_label + ":")
    if then_result.operand.llvm_type != else_result.operand.llvm_type:
        diagnostics = append_string(diagnostics, "llvm lowering: ternary expression branches have incompatible types: `" + then_result.operand.llvm_type + "` vs `" + else_result.operand.llvm_type + "`")
        return ExpressionResult(lines=current_lines, temp_index=else_result.temp_index, operand=None, diagnostics=diagnostics, string_constants=string_constants)
    result_temp = format_temp_name(else_result.temp_index)
    result_type = then_result.operand.llvm_type
    current_lines = append_string(current_lines, "  " + result_temp + " = phi " + result_type + " [ " + then_result.operand.value + ", %" + then_end_label + " ], [ " + else_result.operand.value + ", %" + else_end_label + " ]")
    operand = LLVMOperand(llvm_type=result_type, value=result_temp)
    return ExpressionResult(lines=current_lines, temp_index=else_result.temp_index + 1, operand=operand, diagnostics=diagnostics, string_constants=string_constants)

def lower_binary_operation(expression, match, bindings, locals, temp_index, lines, functions, context):
    left_text = trim_text(substring(expression, 0, match.index))
    right_text = trim_text(substring(expression, match.index + 1, len(expression)))
    diagnostics = []
    if len(left_text) == 0  or  len(right_text) == 0:
        diagnostics = append_string(diagnostics, "llvm lowering: malformed binary expression `" + expression + "`")
        empty_constants = empty_string_constant_set()
        return ExpressionResult(lines=lines, temp_index=temp_index, operand=None, diagnostics=diagnostics, string_constants=empty_constants)
    left_result = lower_expression(left_text, bindings, locals, temp_index, lines, functions, context, "")
    diagnostics = (diagnostics) + (left_result.diagnostics)
    string_constants = left_result.string_constants
    if left_result.operand == None:
        return ExpressionResult(lines=left_result.lines, temp_index=left_result.temp_index, operand=None, diagnostics=diagnostics, string_constants=string_constants)
    right_result = lower_expression(right_text, bindings, locals, left_result.temp_index, left_result.lines, functions, context, "")
    diagnostics = (diagnostics) + (right_result.diagnostics)
    string_constants = merge_string_constants(string_constants, right_result.string_constants)
    if right_result.operand == None:
        return ExpressionResult(lines=right_result.lines, temp_index=right_result.temp_index, operand=None, diagnostics=diagnostics, string_constants=string_constants)
    if match.symbol == "+":
        lhs = left_result.operand
        rhs = right_result.operand
        if lhs.llvm_type == "i8*"  and  rhs.llvm_type == "i8":
            current_lines = right_result.lines
            current_temp = right_result.temp_index
            coerced = coerce_operand_to_type(rhs, "i8*", current_temp, current_lines)
            diagnostics = (diagnostics) + (coerced.diagnostics)
            current_lines = coerced.lines
            current_temp = coerced.temp_index
            if coerced.operand == None:
                return ExpressionResult(lines=current_lines, temp_index=current_temp, operand=None, diagnostics=diagnostics, string_constants=string_constants)
            concat_name = format_temp_name(current_temp)
            current_temp += 1
            current_lines = append_string(current_lines, "  " + concat_name + " = call i8* @sailfin_runtime_string_concat(i8* " + lhs.value + ", i8* " + coerced.operand.value + ")")
            operand = LLVMOperand(llvm_type="i8*", value=concat_name)
            return ExpressionResult(lines=current_lines, temp_index=current_temp, operand=operand, diagnostics=diagnostics, string_constants=string_constants)
        if lhs.llvm_type == "i8"  and  rhs.llvm_type == "i8*":
            current_lines = right_result.lines
            current_temp = right_result.temp_index
            coerced = coerce_operand_to_type(lhs, "i8*", current_temp, current_lines)
            diagnostics = (diagnostics) + (coerced.diagnostics)
            current_lines = coerced.lines
            current_temp = coerced.temp_index
            if coerced.operand == None:
                return ExpressionResult(lines=current_lines, temp_index=current_temp, operand=None, diagnostics=diagnostics, string_constants=string_constants)
            concat_name = format_temp_name(current_temp)
            current_temp += 1
            current_lines = append_string(current_lines, "  " + concat_name + " = call i8* @sailfin_runtime_string_concat(i8* " + coerced.operand.value + ", i8* " + rhs.value + ")")
            operand = LLVMOperand(llvm_type="i8*", value=concat_name)
            return ExpressionResult(lines=current_lines, temp_index=current_temp, operand=operand, diagnostics=diagnostics, string_constants=string_constants)
        if lhs.llvm_type == "i8"  and  rhs.llvm_type == "i8":
            current_lines = right_result.lines
            current_temp = right_result.temp_index
            lhs_coerced = coerce_operand_to_type(lhs, "i8*", current_temp, current_lines)
            diagnostics = (diagnostics) + (lhs_coerced.diagnostics)
            current_lines = lhs_coerced.lines
            current_temp = lhs_coerced.temp_index
            if lhs_coerced.operand == None:
                return ExpressionResult(lines=current_lines, temp_index=current_temp, operand=None, diagnostics=diagnostics, string_constants=string_constants)
            rhs_coerced = coerce_operand_to_type(rhs, "i8*", current_temp, current_lines)
            diagnostics = (diagnostics) + (rhs_coerced.diagnostics)
            current_lines = rhs_coerced.lines
            current_temp = rhs_coerced.temp_index
            if rhs_coerced.operand == None:
                return ExpressionResult(lines=current_lines, temp_index=current_temp, operand=None, diagnostics=diagnostics, string_constants=string_constants)
            concat_name = format_temp_name(current_temp)
            current_temp += 1
            current_lines = append_string(current_lines, "  " + concat_name + " = call i8* @sailfin_runtime_string_concat(i8* " + lhs_coerced.operand.value + ", i8* " + rhs_coerced.operand.value + ")")
            operand = LLVMOperand(llvm_type="i8*", value=concat_name)
            return ExpressionResult(lines=current_lines, temp_index=current_temp, operand=operand, diagnostics=diagnostics, string_constants=string_constants)
    if match.symbol == "+"  or  match.symbol == "-":
        left_type = left_result.operand.llvm_type
        if ends_with_pointer_suffix(left_type):
            rhs = right_result.operand
            if not ends_with_pointer_suffix(rhs.llvm_type):
                if rhs.llvm_type == "double"  or  starts_with(rhs.llvm_type, "i")  or  rhs.llvm_type == "int"  and  rhs.llvm_type != "i8"  and  rhs.llvm_type != "i1":
                    current_lines = right_result.lines
                    current_temp = right_result.temp_index
                    rhs_i64 = rhs
                    if rhs.llvm_type != "i64":
                        coerced = coerce_operand_to_type(rhs, "i64", current_temp, current_lines)
                        diagnostics = (diagnostics) + (coerced.diagnostics)
                        current_lines = coerced.lines
                        current_temp = coerced.temp_index
                        if coerced.operand == None:
                            return ExpressionResult(lines=current_lines, temp_index=current_temp, operand=None, diagnostics=diagnostics, string_constants=string_constants)
                        rhs_i64 = coerced.operand
                    index_value = rhs_i64.value
                    if match.symbol == "-":
                        neg_name = format_temp_name(current_temp)
                        current_temp += 1
                        current_lines = append_string(current_lines, "  " + neg_name + " = sub i64 0, " + rhs_i64.value)
                        index_value = neg_name
                    element_type = strip_pointer_suffix(left_type)
                    gep_name = format_temp_name(current_temp)
                    current_temp += 1
                    current_lines = append_string(current_lines, "  " + gep_name + " = getelementptr " + element_type + ", " + left_type + " " + left_result.operand.value + ", i64 " + index_value)
                    operand = LLVMOperand(llvm_type=left_type, value=gep_name)
                    return ExpressionResult(lines=current_lines, temp_index=current_temp, operand=operand, diagnostics=diagnostics, string_constants=string_constants)
    harmonised = harmonise_operands(left_result.operand, right_result.operand, right_result.temp_index, right_result.lines)
    diagnostics = (diagnostics) + (harmonised.diagnostics)
    if harmonised.left == None  or  harmonised.right == None:
        return ExpressionResult(lines=harmonised.lines, temp_index=harmonised.temp_index, operand=None, diagnostics=diagnostics, string_constants=string_constants)
    left_aligned = harmonised.left
    right_aligned = harmonised.right
    if match.symbol == "+"  and  harmonised.result_type == "i8*":
        temp_name = format_temp_name(harmonised.temp_index)
        line = "  " + temp_name + " = call i8* @sailfin_runtime_string_concat(i8* " + left_aligned.value + ", i8* " + right_aligned.value + ")"
        updated_lines = append_string(harmonised.lines, line)
        operand = LLVMOperand(llvm_type="i8*", value=temp_name)
        return ExpressionResult(lines=updated_lines, temp_index=harmonised.temp_index + 1, operand=operand, diagnostics=diagnostics, string_constants=string_constants)
    operation = operation_name_for_symbol(match.symbol, harmonised.result_type)
    temp_name = format_temp_name(harmonised.temp_index)
    line = "  " + temp_name + " = " + operation + " " + harmonised.result_type + " " + left_aligned.value + ", " + right_aligned.value
    updated_lines = append_string(harmonised.lines, line)
    operand = LLVMOperand(llvm_type=harmonised.result_type, value=temp_name)
    return ExpressionResult(lines=updated_lines, temp_index=harmonised.temp_index + 1, operand=operand, diagnostics=diagnostics, string_constants=string_constants)

def lower_comparison_operation(expression, match, bindings, locals, temp_index, lines, functions, context):
    operator_length = len(match.symbol)
    left_text = trim_text(substring(expression, 0, match.index))
    right_text = trim_text(substring(expression, match.index + operator_length, len(expression)))
    diagnostics = []
    if len(left_text) == 0  or  len(right_text) == 0:
        diagnostics = append_string(diagnostics, "llvm lowering: malformed comparison expression `" + expression + "`")
        empty_constants = empty_string_constant_set()
        return ExpressionResult(lines=lines, temp_index=temp_index, operand=None, diagnostics=diagnostics, string_constants=empty_constants)
    left_result = lower_expression(left_text, bindings, locals, temp_index, lines, functions, context, "")
    diagnostics = (diagnostics) + (left_result.diagnostics)
    string_constants = left_result.string_constants
    if left_result.operand == None:
        return ExpressionResult(lines=left_result.lines, temp_index=left_result.temp_index, operand=None, diagnostics=diagnostics, string_constants=string_constants)
    right_result = lower_expression(right_text, bindings, locals, left_result.temp_index, left_result.lines, functions, context, "")
    diagnostics = (diagnostics) + (right_result.diagnostics)
    string_constants = merge_string_constants(string_constants, right_result.string_constants)
    if right_result.operand == None:
        return ExpressionResult(lines=right_result.lines, temp_index=right_result.temp_index, operand=None, diagnostics=diagnostics, string_constants=string_constants)
    alignment_lines = right_result.lines
    alignment_temp = right_result.temp_index
    left_operand = left_result.operand
    right_operand = right_result.operand
    is_equality = False
    if len(match.symbol) == 2:
        c0 = char_code_at_text(match.symbol, 0)
        c1 = char_code_at_text(match.symbol, 1)
        if c0 == char_code("=")  and  c1 == char_code("=")  or  c0 == char_code("!")  and  c1 == char_code("="):
            is_equality = True
    if is_equality  and  left_operand != None  and  right_operand != None:
        if left_operand.llvm_type == right_operand.llvm_type:
            enum_info = find_enum_info_by_llvm_type(context, left_operand.llvm_type)
            if enum_info != None:
                tag_llvm_type = "i32"
                if enum_info.tag_type == "i8":
                    tag_llvm_type = "i8"
                if enum_info.tag_type == "i16":
                    tag_llvm_type = "i16"
                if enum_info.tag_type == "i32":
                    tag_llvm_type = "i32"
                if enum_info.tag_type == "i64":
                    tag_llvm_type = "i64"
                left_tag_temp = format_temp_name(alignment_temp)
                alignment_temp += 1
                alignment_lines = append_string(alignment_lines, "  " + left_tag_temp + " = extractvalue " + left_operand.llvm_type + " " + left_operand.value + ", 0")
                right_tag_temp = format_temp_name(alignment_temp)
                alignment_temp += 1
                alignment_lines = append_string(alignment_lines, "  " + right_tag_temp + " = extractvalue " + right_operand.llvm_type + " " + right_operand.value + ", 0")
                compare_temp = format_temp_name(alignment_temp)
                alignment_temp += 1
                predicate = "icmp eq"
                if len(match.symbol) == 2:
                    c0 = char_code_at_text(match.symbol, 0)
                    if c0 == char_code("!"):
                        predicate = "icmp ne"
                alignment_lines = append_string(alignment_lines, "  " + compare_temp + " = " + predicate + " " + tag_llvm_type + " " + left_tag_temp + ", " + right_tag_temp)
                operand = LLVMOperand(llvm_type="i1", value=compare_temp)
                return ExpressionResult(lines=alignment_lines, temp_index=alignment_temp, operand=operand, diagnostics=diagnostics, string_constants=string_constants)
        left_is_char = left_operand.llvm_type == "i8"
        right_is_char = right_operand.llvm_type == "i8"
        left_is_pointer = ends_with_pointer_suffix(left_operand.llvm_type)
        right_is_pointer = ends_with_pointer_suffix(right_operand.llvm_type)
        if left_is_char  and  right_is_pointer:
            coercion = coerce_operand_to_type(right_operand, "i8", alignment_temp, alignment_lines)
            diagnostics = (diagnostics) + (coercion.diagnostics)
            if coercion.operand == None:
                return ExpressionResult(lines=coercion.lines, temp_index=coercion.temp_index, operand=None, diagnostics=diagnostics, string_constants=string_constants)
            right_operand = coercion.operand
            alignment_lines = coercion.lines
            alignment_temp = coercion.temp_index
        else:
            if right_is_char  and  left_is_pointer:
                coercion = coerce_operand_to_type(left_operand, "i8", alignment_temp, alignment_lines)
                diagnostics = (diagnostics) + (coercion.diagnostics)
                if coercion.operand == None:
                    return ExpressionResult(lines=coercion.lines, temp_index=coercion.temp_index, operand=None, diagnostics=diagnostics, string_constants=string_constants)
                left_operand = coercion.operand
                alignment_lines = coercion.lines
                alignment_temp = coercion.temp_index
    harmonised = harmonise_operands(left_operand, right_operand, alignment_temp, alignment_lines)
    diagnostics = (diagnostics) + (harmonised.diagnostics)
    if harmonised.left == None  or  harmonised.right == None:
        return ExpressionResult(lines=harmonised.lines, temp_index=harmonised.temp_index, operand=None, diagnostics=diagnostics, string_constants=string_constants)
    comparison = emit_comparison_instruction(match.symbol, harmonised.left, harmonised.right, harmonised.temp_index, harmonised.lines)
    diagnostics = (diagnostics) + (comparison.diagnostics)
    if comparison.operand == None:
        return ExpressionResult(lines=comparison.lines, temp_index=comparison.temp_index, operand=None, diagnostics=diagnostics, string_constants=string_constants)
    return ExpressionResult(lines=comparison.lines, temp_index=comparison.temp_index, operand=comparison.operand, diagnostics=diagnostics, string_constants=string_constants)

def lower_logical_and(expression, match, bindings, locals, temp_index, lines, functions, context):
    left_text = trim_text(substring(expression, 0, match.index))
    right_text = trim_text(substring(expression, match.index + 2, len(expression)))
    diagnostics = []
    string_constants = empty_string_constant_set()
    if len(left_text) == 0  or  len(right_text) == 0:
        diagnostics = append_string(diagnostics, "llvm lowering: malformed && expression `" + expression + "`")
        return ExpressionResult(lines=lines, temp_index=temp_index, operand=None, diagnostics=diagnostics, string_constants=string_constants)
    label_id = number_to_string(temp_index)
    entry_label = "logical_and_entry_" + label_id
    check_right_label = "logical_and_right_" + label_id
    right_end_label = "logical_and_right_end_" + label_id
    merge_label = "logical_and_merge_" + label_id
    label_temp_offset = temp_index + 1
    left_result = lower_expression(left_text, bindings, locals, label_temp_offset, lines, functions, context, "")
    diagnostics = (diagnostics) + (left_result.diagnostics)
    string_constants = left_result.string_constants
    if left_result.operand == None:
        return ExpressionResult(lines=left_result.lines, temp_index=left_result.temp_index, operand=None, diagnostics=diagnostics, string_constants=string_constants)
    left_bool = coerce_operand_to_type(left_result.operand, "i1", left_result.temp_index, left_result.lines)
    diagnostics = (diagnostics) + (left_bool.diagnostics)
    string_constants = merge_string_constants(string_constants, left_result.string_constants)
    if left_bool.operand == None:
        return ExpressionResult(lines=left_bool.lines, temp_index=left_bool.temp_index, operand=None, diagnostics=diagnostics, string_constants=string_constants)
    current_lines = left_bool.lines
    current_lines = append_string(current_lines, "  br label %" + entry_label)
    current_lines = append_string(current_lines, "")
    current_lines = append_string(current_lines, entry_label + ":")
    current_lines = append_string(current_lines, "  br i1 " + left_bool.operand.value + ", label %" + check_right_label + ", label %" + merge_label)
    current_lines = append_string(current_lines, "")
    current_lines = append_string(current_lines, check_right_label + ":")
    right_result = lower_expression(right_text, bindings, locals, left_bool.temp_index, current_lines, functions, context, "")
    diagnostics = (diagnostics) + (right_result.diagnostics)
    string_constants = merge_string_constants(string_constants, right_result.string_constants)
    if right_result.operand == None:
        diagnostics = append_string(diagnostics, "llvm lowering: unable to lower && RHS in `" + expression + "`")
        fallback_lines = right_result.lines
        if not lines_end_with_terminator(fallback_lines):
            fallback_lines = append_string(fallback_lines, "  br label %" + merge_label)
        fallback_lines = append_string(fallback_lines, "")
        fallback_lines = append_string(fallback_lines, merge_label + ":")
        operand = LLVMOperand(llvm_type="i1", value="false")
        return ExpressionResult(lines=fallback_lines, temp_index=right_result.temp_index, operand=operand, diagnostics=diagnostics, string_constants=string_constants)
    right_bool = coerce_operand_to_type(right_result.operand, "i1", right_result.temp_index, right_result.lines)
    diagnostics = (diagnostics) + (right_bool.diagnostics)
    string_constants = merge_string_constants(string_constants, right_result.string_constants)
    if right_bool.operand == None:
        return ExpressionResult(lines=right_bool.lines, temp_index=right_bool.temp_index, operand=None, diagnostics=diagnostics, string_constants=string_constants)
    current_lines = right_bool.lines
    current_lines = append_string(current_lines, "  br label %" + right_end_label)
    current_lines = append_string(current_lines, "")
    current_lines = append_string(current_lines, right_end_label + ":")
    current_lines = append_string(current_lines, "  br label %" + merge_label)
    current_lines = append_string(current_lines, "")
    current_lines = append_string(current_lines, merge_label + ":")
    result_temp = format_temp_name(right_bool.temp_index)
    current_lines = append_string(current_lines, "  " + result_temp + " = phi i1 [ false, %" + entry_label + " ], [ " + right_bool.operand.value + ", %" + right_end_label + " ]")
    operand = LLVMOperand(llvm_type="i1", value=result_temp)
    return ExpressionResult(lines=current_lines, temp_index=right_bool.temp_index + 1, operand=operand, diagnostics=diagnostics, string_constants=string_constants)

def lower_logical_or(expression, match, bindings, locals, temp_index, lines, functions, context):
    left_text = trim_text(substring(expression, 0, match.index))
    right_text = trim_text(substring(expression, match.index + 2, len(expression)))
    diagnostics = []
    string_constants = empty_string_constant_set()
    if len(left_text) == 0  or  len(right_text) == 0:
        diagnostics = append_string(diagnostics, "llvm lowering: malformed || expression `" + expression + "`")
        return ExpressionResult(lines=lines, temp_index=temp_index, operand=None, diagnostics=diagnostics, string_constants=string_constants)
    label_id = number_to_string(temp_index)
    entry_label = "logical_or_entry_" + label_id
    check_right_label = "logical_or_right_" + label_id
    right_end_label = "logical_or_right_end_" + label_id
    merge_label = "logical_or_merge_" + label_id
    label_temp_offset = temp_index + 1
    left_result = lower_expression(left_text, bindings, locals, label_temp_offset, lines, functions, context, "")
    diagnostics = (diagnostics) + (left_result.diagnostics)
    string_constants = left_result.string_constants
    if left_result.operand == None:
        return ExpressionResult(lines=left_result.lines, temp_index=left_result.temp_index, operand=None, diagnostics=diagnostics, string_constants=string_constants)
    left_bool = coerce_operand_to_type(left_result.operand, "i1", left_result.temp_index, left_result.lines)
    diagnostics = (diagnostics) + (left_bool.diagnostics)
    string_constants = merge_string_constants(string_constants, left_result.string_constants)
    if left_bool.operand == None:
        return ExpressionResult(lines=left_bool.lines, temp_index=left_bool.temp_index, operand=None, diagnostics=diagnostics, string_constants=string_constants)
    current_lines = left_bool.lines
    current_lines = append_string(current_lines, "  br label %" + entry_label)
    current_lines = append_string(current_lines, "")
    current_lines = append_string(current_lines, entry_label + ":")
    current_lines = append_string(current_lines, "  br i1 " + left_bool.operand.value + ", label %" + merge_label + ", label %" + check_right_label)
    current_lines = append_string(current_lines, "")
    current_lines = append_string(current_lines, check_right_label + ":")
    right_result = lower_expression(right_text, bindings, locals, left_bool.temp_index, current_lines, functions, context, "")
    diagnostics = (diagnostics) + (right_result.diagnostics)
    string_constants = merge_string_constants(string_constants, right_result.string_constants)
    if right_result.operand == None:
        diagnostics = append_string(diagnostics, "llvm lowering: unable to lower || RHS in `" + expression + "`")
        fallback_lines = right_result.lines
        if not lines_end_with_terminator(fallback_lines):
            fallback_lines = append_string(fallback_lines, "  br label %" + merge_label)
        fallback_lines = append_string(fallback_lines, "")
        fallback_lines = append_string(fallback_lines, merge_label + ":")
        operand = LLVMOperand(llvm_type="i1", value=left_bool.operand.value)
        return ExpressionResult(lines=fallback_lines, temp_index=right_result.temp_index, operand=operand, diagnostics=diagnostics, string_constants=string_constants)
    right_bool = coerce_operand_to_type(right_result.operand, "i1", right_result.temp_index, right_result.lines)
    diagnostics = (diagnostics) + (right_bool.diagnostics)
    string_constants = merge_string_constants(string_constants, right_result.string_constants)
    if right_bool.operand == None:
        return ExpressionResult(lines=right_bool.lines, temp_index=right_bool.temp_index, operand=None, diagnostics=diagnostics, string_constants=string_constants)
    current_lines = right_bool.lines
    current_lines = append_string(current_lines, "  br label %" + right_end_label)
    current_lines = append_string(current_lines, "")
    current_lines = append_string(current_lines, right_end_label + ":")
    current_lines = append_string(current_lines, "  br label %" + merge_label)
    current_lines = append_string(current_lines, "")
    current_lines = append_string(current_lines, merge_label + ":")
    result_temp = format_temp_name(right_bool.temp_index)
    current_lines = append_string(current_lines, "  " + result_temp + " = phi i1 [ true, %" + entry_label + " ], [ " + right_bool.operand.value + ", %" + right_end_label + " ]")
    operand = LLVMOperand(llvm_type="i1", value=result_temp)
    return ExpressionResult(lines=current_lines, temp_index=right_bool.temp_index + 1, operand=operand, diagnostics=diagnostics, string_constants=string_constants)

def lines_end_with_terminator(lines):
    index = len(lines) - 1
    while True:
        if len(lines) == 0:
            return False
        if index < 0:
            break
        line = trim_text(lines[index])
        if len(line) == 0:
            index -= 1
            continue
        if starts_with(line, "ret"):
            return True
        if starts_with(line, "br "):
            return True
        if starts_with(line, "switch "):
            return True
        if line == "unreachable":
            return True
        return False
    return False

def lower_call_expression(target, arguments, bindings, locals, temp_index, lines, functions, context):
    diagnostics = []
    collected_string_constants = empty_string_constant_set()
    empty_constants = empty_string_constant_set()
    trimmed_target = trim_text(target)
    if len(trimmed_target) == 0:
        diagnostics = append_string(diagnostics, "llvm lowering: call target missing")
        return ExpressionResult(lines=lines, temp_index=temp_index, operand=None, diagnostics=diagnostics, string_constants=empty_constants)
    dot_index = index_of(trimmed_target, ".")
    if dot_index > 0:
        enum_name = trim_text(substring(trimmed_target, 0, dot_index))
        variant_name = trim_text(substring(trimmed_target, dot_index + 1, len(trimmed_target)))
        enum_info = resolve_enum_info_for_literal(context, enum_name)
        if enum_info != None:
            fields = []
            if len(arguments) > 0:
                variant_info = resolve_enum_variant_info(enum_info, variant_name)
                if variant_info != None  and  len(variant_info.fields) == len(arguments):
                    arg_index = 0
                    while True:
                        if arg_index >= len(arguments):
                            break
                        field_info = variant_info.fields[arg_index]
                        fields = append_struct_literal_field(fields, StructLiteralField(name=field_info.name, value=arguments[arg_index]))
                        arg_index += 1
                else:
                    pass
            enum_parse = EnumLiteralParse(recognized=True, success=True, enum_name=enum_name, variant_name=variant_name, fields=fields, diagnostics=[])
            return lower_enum_literal(enum_parse, bindings, locals, temp_index, lines, functions, context, "")
    current_lines = lines
    current_temp = temp_index
    operands = []
    injected_argument_count = 0
    method_operand = None
    helper_descriptor = None
    array_concat_element_type = ""
    is_array_concat = False
    array_push_element_type = ""
    is_array_push = False
    fused_target = trimmed_target
    if starts_with(fused_target, "@")  and  len(fused_target) > 1:
        fused_target = substring(fused_target, 1, len(fused_target))
    canonical_fused = sanitize_symbol(fused_target)
    if ends_with(canonical_fused, "concat")  and  len(canonical_fused) > 6:
        receiver_name = trim_text(substring(canonical_fused, 0, len(canonical_fused) - 6))
        if len(receiver_name) > 0  and  is_simple_identifier(receiver_name):
            local = find_local_binding(locals, receiver_name)
            parameter = find_parameter_binding(bindings, receiver_name)
            receiver_operand = None
            if local != None:
                load_result = load_local_operand(local, current_temp, current_lines)
                diagnostics = (diagnostics) + (load_result.diagnostics)
                current_lines = load_result.lines
                current_temp = load_result.temp_index
                receiver_operand = load_result.operand
            else:
                if parameter != None:
                    receiver_operand = LLVMOperand(llvm_type=parameter.llvm_type, value=parameter.llvm_name)
            if receiver_operand != None:
                method_operand = receiver_operand
                injected_argument_count = 1
                trimmed_target = "concat"
                receiver_type = trim_text(receiver_operand.llvm_type)
                element_type = array_pointer_element_type(receiver_type)
                if len(element_type) > 0:
                    is_array_concat = True
                    array_concat_element_type = element_type
                    if not ends_with_pointer_suffix(element_type):
                        helper_descriptor = RuntimeHelperDescriptor(target="concat", symbol="", return_type=receiver_operand.llvm_type, parameter_types=[receiver_operand.llvm_type, receiver_operand.llvm_type], effects=[])
    method_parse = parse_member_access(trimmed_target)
    if method_parse.success:
        if method_parse.field == "concat"  or  method_parse.field == "push":
            lowered_self = lower_expression(method_parse.base, bindings, locals, current_temp, current_lines, functions, context, "")
            diagnostics = (diagnostics) + (lowered_self.diagnostics)
            collected_string_constants = merge_string_constants(collected_string_constants, lowered_self.string_constants)
            current_lines = lowered_self.lines
            current_temp = lowered_self.temp_index
            if lowered_self.operand == None:
                diagnostics = append_string(diagnostics, "llvm lowering: method call base `" + method_parse.base + "` produced no value")
                return ExpressionResult(lines=current_lines, temp_index=current_temp, operand=None, diagnostics=diagnostics, string_constants=collected_string_constants)
            base_operand = lowered_self.operand
            array_element_type = array_pointer_element_type(base_operand.llvm_type)
            if len(array_element_type) > 0:
                if method_parse.field == "concat":
                    method_operand = base_operand
                    trimmed_target = "concat"
                    injected_argument_count = 1
                    array_concat_element_type = array_element_type
                    is_array_concat = True
                    if not ends_with_pointer_suffix(array_element_type):
                        helper_descriptor = RuntimeHelperDescriptor(target="concat", symbol="", return_type=base_operand.llvm_type, parameter_types=[base_operand.llvm_type, base_operand.llvm_type], effects=[])
                else:
                    method_operand = base_operand
                    trimmed_target = "push"
                    injected_argument_count = 1
                    array_push_element_type = array_element_type
                    is_array_push = True
                    helper_descriptor = RuntimeHelperDescriptor(target="push", symbol="", return_type=base_operand.llvm_type, parameter_types=[base_operand.llvm_type, array_element_type], effects=[])
        method_info = resolve_struct_info_for_method_target(method_parse.base, bindings, locals, context)
        interface_info = resolve_interface_info_for_method_target(method_parse.base, bindings, locals, context)
        if method_info != None:
            base_name = trim_text(method_parse.base)
            if is_simple_identifier(base_name):
                bound_local = find_local_binding(locals, base_name)
                bound_param = find_parameter_binding(bindings, base_name)
                if bound_local == None  and  bound_param == None:
                    trimmed_target = method_info.name + "::" + method_parse.field
                    injected_argument_count = 0
                else:
                    lowered_self = lower_expression(method_parse.base, bindings, locals, current_temp, current_lines, functions, context, "")
                    diagnostics = (diagnostics) + (lowered_self.diagnostics)
                    collected_string_constants = merge_string_constants(collected_string_constants, lowered_self.string_constants)
                    current_lines = lowered_self.lines
                    current_temp = lowered_self.temp_index
                    if lowered_self.operand != None:
                        method_operand = lowered_self.operand
                        trimmed_target = method_info.name + "::" + method_parse.field
                        injected_argument_count = 1
                    else:
                        diagnostics = append_string(diagnostics, "llvm lowering: method call base `" + method_parse.base + "` produced no value")
                        return ExpressionResult(lines=current_lines, temp_index=current_temp, operand=None, diagnostics=diagnostics, string_constants=collected_string_constants)
            else:
                lowered_self = lower_expression(method_parse.base, bindings, locals, current_temp, current_lines, functions, context, "")
                diagnostics = (diagnostics) + (lowered_self.diagnostics)
                collected_string_constants = merge_string_constants(collected_string_constants, lowered_self.string_constants)
                current_lines = lowered_self.lines
                current_temp = lowered_self.temp_index
                if lowered_self.operand != None:
                    method_operand = lowered_self.operand
                    trimmed_target = method_info.name + "::" + method_parse.field
                    injected_argument_count = 1
                else:
                    diagnostics = append_string(diagnostics, "llvm lowering: method call base `" + method_parse.base + "` produced no value")
                    return ExpressionResult(lines=current_lines, temp_index=current_temp, operand=None, diagnostics=diagnostics, string_constants=collected_string_constants)
        else:
            if interface_info != None:
                lowered_self = lower_expression(method_parse.base, bindings, locals, current_temp, current_lines, functions, context, "")
                diagnostics = (diagnostics) + (lowered_self.diagnostics)
                collected_string_constants = merge_string_constants(collected_string_constants, lowered_self.string_constants)
                current_lines = lowered_self.lines
                current_temp = lowered_self.temp_index
                if lowered_self.operand != None:
                    method_operand = lowered_self.operand
                    trimmed_target = "trait_dispatch::" + interface_info.name + "::" + method_parse.field
                    injected_argument_count = 1
                else:
                    diagnostics = append_string(diagnostics, "llvm lowering: method call base `" + method_parse.base + "` produced no value")
                    return ExpressionResult(lines=current_lines, temp_index=current_temp, operand=None, diagnostics=diagnostics, string_constants=collected_string_constants)
            else:
                qualified_helper = find_runtime_helper(trimmed_target)
                if qualified_helper != None:
                    helper_descriptor = qualified_helper
                else:
                    field_helper = find_runtime_helper(method_parse.field)
                    lowered_self = lower_expression(method_parse.base, bindings, locals, current_temp, current_lines, functions, context, "")
                    diagnostics = (diagnostics) + (lowered_self.diagnostics)
                    collected_string_constants = merge_string_constants(collected_string_constants, lowered_self.string_constants)
                    current_lines = lowered_self.lines
                    current_temp = lowered_self.temp_index
                    if lowered_self.operand == None:
                        diagnostics = append_string(diagnostics, "llvm lowering: method call base `" + method_parse.base + "` produced no value")
                        return ExpressionResult(lines=current_lines, temp_index=current_temp, operand=None, diagnostics=diagnostics, string_constants=collected_string_constants)
                    base_operand = lowered_self.operand
                    if field_helper != None:
                        method_operand = base_operand
                        trimmed_target = method_parse.field
                        injected_argument_count = 1
                        helper_descriptor = field_helper
                    array_element_type = array_pointer_element_type(base_operand.llvm_type)
                    if len(array_element_type) > 0  and  method_parse.field == "concat":
                        method_operand = base_operand
                        trimmed_target = "concat"
                        injected_argument_count = 1
                        array_concat_element_type = array_element_type
                        is_array_concat = True
                        if not ends_with_pointer_suffix(array_element_type):
                            helper_descriptor = RuntimeHelperDescriptor(target="concat", symbol="", return_type=base_operand.llvm_type, parameter_types=[base_operand.llvm_type, base_operand.llvm_type], effects=[])
                    else:
                        if len(array_element_type) > 0  and  method_parse.field == "push":
                            method_operand = base_operand
                            trimmed_target = "push"
                            injected_argument_count = 1
                            array_push_element_type = array_element_type
                            is_array_push = True
                            helper_descriptor = RuntimeHelperDescriptor(target="push", symbol="", return_type=base_operand.llvm_type, parameter_types=[base_operand.llvm_type, array_element_type], effects=[])
    function_entry = None
    llvm_return = "double"
    expected_params = []
    is_trait_dispatch = False
    if substring(trimmed_target, 0, 16) == "trait_dispatch::":
        is_trait_dispatch = True
        after_prefix = substring(trimmed_target, 16, len(trimmed_target))
        double_colon_pos = find_last_index_of_char(after_prefix, ":")
        if double_colon_pos > 0  and  substring(after_prefix, double_colon_pos - 1, double_colon_pos + 1) == "::":
            interface_name = substring(after_prefix, 0, double_colon_pos - 1)
            method_name = substring(after_prefix, double_colon_pos + 1, len(after_prefix))
            interface_info = find_interface_info_by_name(context, interface_name)
            if interface_info != None:
                sig_idx = 0
                while True:
                    if sig_idx >= len(interface_info.signatures):
                        break
                    sig = interface_info.signatures[sig_idx]
                    if sig.name == method_name:
                        llvm_return = map_return_type(context, sig.return_type)
                        if len(llvm_return) == 0:
                            llvm_return = "double"
                        expected_params = ["i8*"]
                        break
                    sig_idx += 1
    function_entry = find_function_by_name(functions, trimmed_target)
    if helper_descriptor == None:
        helper_descriptor = find_runtime_helper(trimmed_target)
    if not is_trait_dispatch:
        if helper_descriptor != None:
            descriptor = helper_descriptor
            llvm_return = descriptor.return_type
            expected_params = descriptor.parameter_types
            function_entry = None
        else:
            if function_entry != None:
                if function_entry.is_async:
                    future_return = future_pointer_type_for_return_type(function_entry.return_type)
                    if len(future_return) == 0:
                        diagnostics = append_string(diagnostics, "llvm lowering: async function `" + trimmed_target + "` has unsupported return type `" + function_entry.return_type + "`")
                        llvm_return = "i8*"
                    else:
                        llvm_return = future_return
                    expected_params = collect_parameter_types(context, function_entry.parameters, trimmed_target)
                else:
                    llvm_return = map_return_type(context, function_entry.return_type)
                    if len(llvm_return) == 0:
                        diagnostics = append_string(diagnostics, "llvm lowering: unsupported return type in call to `" + trimmed_target + "`")
                        llvm_return = "double"
                    expected_params = collect_parameter_types(context, function_entry.parameters, trimmed_target)
            else:
                diagnostics = append_string(diagnostics, "llvm lowering: call to unknown function `" + trimmed_target + "`")
    if trimmed_target == "concat"  and  method_operand != None:
        receiver = method_operand
        receiver_type = trim_text(receiver.llvm_type)
        element_type = array_pointer_element_type(receiver_type)
        if len(element_type) > 0:
            is_array_concat = True
            array_concat_element_type = element_type
            if not ends_with_pointer_suffix(element_type):
                llvm_return = receiver_type
                expected_params = [receiver_type, receiver_type]
                helper_descriptor = RuntimeHelperDescriptor(target="concat", symbol="", return_type=receiver_type, parameter_types=expected_params, effects=[])
                function_entry = None
    index = 0
    while True:
        if index >= len(arguments):
            break
        argument_text = trim_text(arguments[index])
        if len(argument_text) == 0:
            diagnostics = append_string(diagnostics, "llvm lowering: empty argument in call to `" + trimmed_target + "`")
        argument_expected_type = ""
        parameter_index = index + injected_argument_count
        if len(expected_params) > parameter_index:
            argument_expected_type = expected_params[parameter_index]
        lowered = lower_expression(argument_text, bindings, locals, current_temp, current_lines, functions, context, argument_expected_type)
        diagnostics = (diagnostics) + (lowered.diagnostics)
        collected_string_constants = merge_string_constants(collected_string_constants, lowered.string_constants)
        current_lines = lowered.lines
        current_temp = lowered.temp_index
        if lowered.operand != None:
            operands = append_llvm_operand(operands, lowered.operand)
        else:
            diagnostics = append_string(diagnostics, "llvm lowering: failed to lower argument " + number_to_string(index) + " for call to `" + trimmed_target + "`")
        index += 1
    if method_operand != None:
        operand_value = method_operand
        combined_operands = []
        combined_operands = append_llvm_operand(combined_operands, operand_value)
        operand_index = 0
        while True:
            if operand_index >= len(operands):
                break
            combined_operands = append_llvm_operand(combined_operands, operands[operand_index])
            operand_index += 1
        operands = combined_operands
    expected_operand_count = len(arguments) + injected_argument_count
    if len(operands) != expected_operand_count:
        diagnostics = append_string(diagnostics, "llvm lowering: unable to emit call to `" + trimmed_target + "` due to argument errors")
        return ExpressionResult(lines=current_lines, temp_index=current_temp, operand=None, diagnostics=diagnostics, string_constants=collected_string_constants)
    if trimmed_target == "concat"  and  len(operands) >= 2:
        inferred_element_type = array_pointer_element_type(operands[0].llvm_type)
        if len(inferred_element_type) > 0:
            is_array_concat = True
            array_concat_element_type = inferred_element_type
            if not ends_with_pointer_suffix(inferred_element_type):
                llvm_return = operands[0].llvm_type
                expected_params = [operands[0].llvm_type, operands[0].llvm_type]
                helper_descriptor = RuntimeHelperDescriptor(target="concat", symbol="", return_type=operands[0].llvm_type, parameter_types=expected_params, effects=[])
    if function_entry != None  and  len(operands) < len(expected_params):
        param_index = len(operands)
        while True:
            if param_index >= len(expected_params):
                break
            if param_index >= len(function_entry.parameters):
                break
            param = function_entry.parameters[param_index]
            if param.default_value == None:
                break
            expected_type = expected_params[param_index]
            lowered_default = lower_expression(param.default_value, bindings, locals, current_temp, current_lines, functions, context, expected_type)
            diagnostics = (diagnostics) + (lowered_default.diagnostics)
            collected_string_constants = merge_string_constants(collected_string_constants, lowered_default.string_constants)
            current_lines = lowered_default.lines
            current_temp = lowered_default.temp_index
            if lowered_default.operand == None:
                diagnostics = append_string(diagnostics, "llvm lowering: failed to lower default argument for parameter `" + param.name + "` in call to `" + trimmed_target + "`")
                break
            operands = append_llvm_operand(operands, lowered_default.operand)
            param_index += 1
    if function_entry != None  and  injected_argument_count == 1:
        if len(operands) > 0  and  len(expected_params) > 0:
            expected_self_type = expected_params[0]
            self_operand = operands[0]
            if self_operand.llvm_type != expected_self_type:
                if ends_with_pointer_suffix(self_operand.llvm_type):
                    stripped = strip_pointer_suffix(self_operand.llvm_type)
                    if stripped == expected_self_type:
                        load_name = format_temp_name(current_temp)
                        current_lines = append_string(current_lines, "  " + load_name + " = load " + expected_self_type + ", " + expected_self_type + "* " + self_operand.value)
                        current_temp += 1
                        updated_operand = LLVMOperand(llvm_type=expected_self_type, value=load_name)
                        operands = replace_llvm_operand(operands, 0, updated_operand)
                    else:
                        diagnostics = append_string(diagnostics, "llvm lowering: method call expects `" + expected_self_type + "` but base `" + self_operand.llvm_type + "` is incompatible")
                else:
                    if ends_with_pointer_suffix(expected_self_type):
                        base_name = trim_text(method_parse.base)
                        if is_simple_identifier(base_name):
                            local_pointer = find_local_binding(locals, base_name)
                            if local_pointer != None  and  local_pointer.llvm_type + "*" == expected_self_type:
                                updated_operand = LLVMOperand(llvm_type=expected_self_type, value=local_pointer.pointer)
                                operands = replace_llvm_operand(operands, 0, updated_operand)
                            else:
                                parameter_pointer = find_parameter_binding(bindings, base_name)
                                if parameter_pointer != None  and  parameter_pointer.llvm_type == expected_self_type:
                                    updated_operand = LLVMOperand(llvm_type=expected_self_type, value=parameter_pointer.llvm_name)
                                    operands = replace_llvm_operand(operands, 0, updated_operand)
                                else:
                                    if parameter_pointer != None  and  parameter_pointer.llvm_type == strip_pointer_suffix(expected_self_type):
                                        pass
                                    else:
                                        diagnostics = append_string(diagnostics, "llvm lowering: method call expects `" + expected_self_type + "` but base `" + self_operand.llvm_type + "` is incompatible")
                        else:
                            receiver_base = strip_pointer_suffix(expected_self_type)
                            if self_operand.llvm_type == receiver_base  and  starts_with(receiver_base, "%")  or  starts_with(receiver_base, "{"):
                                pass
                            else:
                                diagnostics = append_string(diagnostics, "llvm lowering: method call expects `" + expected_self_type + "` but base `" + self_operand.llvm_type + "` is incompatible")
                    else:
                        diagnostics = append_string(diagnostics, "llvm lowering: method call expects `" + expected_self_type + "` but base `" + self_operand.llvm_type + "` is incompatible")
    coerced_operands = []
    index = 0
    while True:
        if index >= len(operands):
            break
        operand = operands[index]
        target_type = ""
        if len(expected_params) > index:
            target_type = expected_params[index]
        if is_trait_dispatch  and  index == 0:
            coerced_operands = append_llvm_operand(coerced_operands, operand)
        else:
            if len(target_type) == 0:
                coerced_operands = append_llvm_operand(coerced_operands, operand)
            else:
                coerced = coerce_operand_to_type(operand, target_type, current_temp, current_lines)
                diagnostics = (diagnostics) + (coerced.diagnostics)
                current_lines = coerced.lines
                current_temp = coerced.temp_index
                if coerced.operand == None:
                    diagnostics = append_string(diagnostics, "llvm lowering: unable to coerce argument " + number_to_string(index) + " for call to `" + trimmed_target + "`")
                    placeholder = LLVMOperand(llvm_type="i8*", value="null")
                    coerced_operands = append_llvm_operand(coerced_operands, placeholder)
                else:
                    coerced_operands = append_llvm_operand(coerced_operands, coerced.operand)
        index += 1
    operands = coerced_operands
    if is_array_concat  and  len(array_concat_element_type) > 0  and  not ends_with_pointer_suffix(array_concat_element_type):
        if len(operands) >= 2:
            concat_result = lower_struct_array_concat(operands[0], operands[1], array_concat_element_type, current_lines, current_temp)
            diagnostics = (diagnostics) + (concat_result.diagnostics)
            current_lines = concat_result.lines
            current_temp = concat_result.temp_index
            if concat_result.operand == None:
                return ExpressionResult(lines=current_lines, temp_index=current_temp, operand=None, diagnostics=diagnostics, string_constants=collected_string_constants)
            return ExpressionResult(lines=current_lines, temp_index=current_temp, operand=concat_result.operand, diagnostics=diagnostics, string_constants=collected_string_constants)
        else:
            diagnostics = append_string(diagnostics, "llvm lowering: concat requires two operands")
            return ExpressionResult(lines=current_lines, temp_index=current_temp, operand=None, diagnostics=diagnostics, string_constants=collected_string_constants)
    if is_array_push  and  len(array_push_element_type) > 0:
        if len(operands) >= 2:
            push_result = lower_array_push_in_place(operands[0], operands[1], array_push_element_type, current_lines, current_temp)
            diagnostics = (diagnostics) + (push_result.diagnostics)
            current_lines = push_result.lines
            current_temp = push_result.temp_index
            if push_result.operand == None:
                return ExpressionResult(lines=current_lines, temp_index=current_temp, operand=None, diagnostics=diagnostics, string_constants=collected_string_constants)
            return ExpressionResult(lines=current_lines, temp_index=current_temp, operand=push_result.operand, diagnostics=diagnostics, string_constants=collected_string_constants)
        else:
            diagnostics = append_string(diagnostics, "llvm lowering: push requires two operands")
            return ExpressionResult(lines=current_lines, temp_index=current_temp, operand=None, diagnostics=diagnostics, string_constants=collected_string_constants)
    if function_entry != None  or  helper_descriptor != None:
        if len(expected_params) != len(operands):
            diagnostics = append_string(diagnostics, "llvm lowering: call to `" + trimmed_target + "` expected " + number_to_string(len(expected_params)) + " arguments but received " + number_to_string(len(operands)))
    rendered_args = []
    index = 0
    while True:
        if index >= len(operands):
            break
        rendered_args = append_string(rendered_args, format_typed_operand(operands[index]))
        index += 1
    argument_text = join_with_separator(rendered_args, ", ")
    if substring(trimmed_target, 0, 16) == "trait_dispatch::":
        after_prefix = substring(trimmed_target, 16, len(trimmed_target))
        double_colon_pos = find_last_index_of_char(after_prefix, ":")
        if double_colon_pos > 0  and  substring(after_prefix, double_colon_pos - 1, double_colon_pos + 1) == "::":
            interface_name = substring(after_prefix, 0, double_colon_pos - 1)
            method_name = substring(after_prefix, double_colon_pos + 1, len(after_prefix))
            if len(operands) > 0:
                trait_object = operands[0]
                data_ptr_temp = "%t" + number_to_string(current_temp)
                current_temp += 1
                current_lines = append_string(current_lines, "  " + data_ptr_temp + " = extractvalue " + trait_object.llvm_type + " " + trait_object.value + ", 0")
                vtable_ptr_temp = "%t" + number_to_string(current_temp)
                current_temp += 1
                current_lines = append_string(current_lines, "  " + vtable_ptr_temp + " = extractvalue " + trait_object.llvm_type + " " + trait_object.value + ", 1")
                interface_info = find_interface_info_by_name(context, interface_name)
                if interface_info != None:
                    method_index = -1
                    sig_idx = 0
                    while True:
                        if sig_idx >= len(interface_info.signatures):
                            break
                        if interface_info.signatures[sig_idx].name == method_name:
                            method_index = sig_idx
                            break
                        sig_idx += 1
                    if method_index >= 0:
                        fp_param_types = ["i8*"]
                        arg_idx = 1
                        while True:
                            if arg_idx >= len(operands):
                                break
                            fp_param_types = append_string(fp_param_types, operands[arg_idx].llvm_type)
                            arg_idx += 1
                        fp_params = join_with_separator(fp_param_types, ", ")
                        function_type = llvm_return + " (" + fp_params + ")*"
                        vtable_slots_temp = "%t" + number_to_string(current_temp)
                        current_temp += 1
                        current_lines = append_string(current_lines, "  " + vtable_slots_temp + " = bitcast i8* " + vtable_ptr_temp + " to i8**")
                        slot_ptr_temp = "%t" + number_to_string(current_temp)
                        current_temp += 1
                        current_lines = append_string(current_lines, "  " + slot_ptr_temp + " = getelementptr i8*, i8** " + vtable_slots_temp + ", i64 " + number_to_string(method_index))
                        raw_ptr_temp = "%t" + number_to_string(current_temp)
                        current_temp += 1
                        current_lines = append_string(current_lines, "  " + raw_ptr_temp + " = load i8*, i8** " + slot_ptr_temp)
                        method_ptr_temp = "%t" + number_to_string(current_temp)
                        current_temp += 1
                        current_lines = append_string(current_lines, "  " + method_ptr_temp + " = bitcast i8* " + raw_ptr_temp + " to " + function_type)
                        call_args = ["i8* " + data_ptr_temp]
                        arg_idx = 1
                        while True:
                            if arg_idx >= len(rendered_args):
                                break
                            call_args = append_string(call_args, rendered_args[arg_idx])
                            arg_idx += 1
                        call_arg_text = join_with_separator(call_args, ", ")
                        if llvm_return == "void":
                            current_lines = append_string(current_lines, "  call void " + method_ptr_temp + "(" + call_arg_text + ")")
                            return ExpressionResult(lines=current_lines, temp_index=current_temp, operand=None, diagnostics=diagnostics, string_constants=collected_string_constants)
                        else:
                            result_temp = format_temp_name(current_temp)
                            current_lines = append_string(current_lines, "  " + result_temp + " = call " + llvm_return + " " + method_ptr_temp + "(" + call_arg_text + ")")
                            result_operand = LLVMOperand(llvm_type=llvm_return, value=result_temp)
                            return ExpressionResult(lines=current_lines, temp_index=current_temp + 1, operand=result_operand, diagnostics=diagnostics, string_constants=collected_string_constants)
                    else:
                        diagnostics = append_string(diagnostics, "llvm lowering: method `" + method_name + "` not found in interface `" + interface_name + "`")
                else:
                    diagnostics = append_string(diagnostics, "llvm lowering: interface `" + interface_name + "` not found for trait dispatch")
            else:
                diagnostics = append_string(diagnostics, "llvm lowering: trait dispatch requires at least one argument (the trait object)")
        else:
            diagnostics = append_string(diagnostics, "llvm lowering: malformed trait dispatch target `" + trimmed_target + "`")
    call_symbol = sanitize_symbol(trimmed_target)
    if helper_descriptor != None:
        call_symbol = helper_descriptor.symbol
    if llvm_return == "void":
        call_line = "  call void @" + call_symbol + "(" + argument_text + ")"
        current_lines = append_string(current_lines, call_line)
        return ExpressionResult(lines=current_lines, temp_index=current_temp, operand=None, diagnostics=diagnostics, string_constants=collected_string_constants)
    temp_name = format_temp_name(current_temp)
    call_line = "  " + temp_name + " = call " + llvm_return + " @" + call_symbol + "(" + argument_text + ")"
    current_lines = append_string(current_lines, call_line)
    operand = LLVMOperand(llvm_type=llvm_return, value=temp_name)
    return ExpressionResult(lines=current_lines, temp_index=current_temp + 1, operand=operand, diagnostics=diagnostics, string_constants=collected_string_constants)

def lower_member_access(parse, bindings, locals, temp_index, lines, functions, context, expected_type):
    base_result = lower_expression(parse.base, bindings, locals, temp_index, lines, functions, context, "")
    diagnostics = base_result.diagnostics
    collected_string_constants = base_result.string_constants
    if base_result.operand == None:
        return ExpressionResult(lines=base_result.lines, temp_index=base_result.temp_index, operand=None, diagnostics=diagnostics, string_constants=collected_string_constants)
    current_lines = base_result.lines
    current_temp = base_result.temp_index
    base_operand = base_result.operand
    if parse.field == "length"  and  ends_with_pointer_suffix(base_operand.llvm_type):
        inner_type = strip_pointer_suffix(base_operand.llvm_type)
        if starts_with(inner_type, "{")  and  len(inner_type) > 0  and  inner_type[len(inner_type) - 1] == "}":
            struct_inner = trim_text(substring(inner_type, 1, len(inner_type) - 1))
            if contains_text(struct_inner, ", i64"):
                loaded_array = format_temp_name(current_temp)
                current_lines = append_string(current_lines, "  " + loaded_array + " = load " + inner_type + ", " + base_operand.llvm_type + " " + base_operand.value)
                current_temp += 1
                length_temp = format_temp_name(current_temp)
                current_lines = append_string(current_lines, "  " + length_temp + " = extractvalue " + inner_type + " " + loaded_array + ", 1")
                current_temp += 1
                operand = LLVMOperand(llvm_type="i64", value=length_temp)
                return ExpressionResult(lines=current_lines, temp_index=current_temp, operand=operand, diagnostics=diagnostics, string_constants=collected_string_constants)
    if parse.field == "length"  and  base_operand.llvm_type == "i8*":
        length_temp = format_temp_name(current_temp)
        current_lines = append_string(current_lines, "  " + length_temp + " = call i64 @sailfin_runtime_string_length(i8* " + base_operand.value + ")")
        current_temp += 1
        operand = LLVMOperand(llvm_type="i64", value=length_temp)
        return ExpressionResult(lines=current_lines, temp_index=current_temp, operand=operand, diagnostics=diagnostics, string_constants=collected_string_constants)
    struct_info = None
    pointer_available = False
    pointer_operand = base_operand
    if ends_with_pointer_suffix(base_operand.llvm_type):
        candidate = strip_pointer_suffix(base_operand.llvm_type)
        struct_info = find_struct_info_by_llvm_type(context, candidate)
        if struct_info == None:
            enum_info_candidate = find_enum_info_by_llvm_type(context, candidate)
            if enum_info_candidate != None:
                return lower_enum_member_access(parse, enum_info_candidate, base_operand, True, current_temp, current_lines, diagnostics, collected_string_constants, expected_type)
            if base_operand.llvm_type == "i8*":
                return lower_dynamic_member_access(parse.field, base_operand, current_temp, current_lines, diagnostics, collected_string_constants)
            if base_operand.llvm_type != "double"  and  base_operand.llvm_type != "i8":
                diagnostics = append_string(diagnostics, "llvm lowering: member access base `" + base_operand.llvm_type + "` lacks struct metadata")
            return ExpressionResult(lines=current_lines, temp_index=current_temp, operand=None, diagnostics=diagnostics, string_constants=collected_string_constants)
        pointer_available = True
    else:
        struct_info = find_struct_info_by_llvm_type(context, base_operand.llvm_type)
        if struct_info == None:
            enum_info_candidate = find_enum_info_by_llvm_type(context, base_operand.llvm_type)
            if enum_info_candidate != None:
                return lower_enum_member_access(parse, enum_info_candidate, base_operand, False, current_temp, current_lines, diagnostics, collected_string_constants, expected_type)
            if base_operand.llvm_type == "i8*":
                return lower_dynamic_member_access(parse.field, base_operand, current_temp, current_lines, diagnostics, collected_string_constants)
            if base_operand.llvm_type != "double"  and  base_operand.llvm_type != "i8":
                diagnostics = append_string(diagnostics, "llvm lowering: member access base `" + base_operand.llvm_type + "` lacks struct metadata")
            return ExpressionResult(lines=current_lines, temp_index=current_temp, operand=None, diagnostics=diagnostics, string_constants=collected_string_constants)
    info = struct_info
    field_info = find_struct_field_info(info, parse.field)
    if field_info == None:
        diagnostics = append_string(diagnostics, "llvm lowering: struct `" + info.name + "` has no field `" + parse.field + "`")
        return ExpressionResult(lines=current_lines, temp_index=current_temp, operand=None, diagnostics=diagnostics, string_constants=collected_string_constants)
    if pointer_available:
        struct_type = info.llvm_name
        gep_name = format_temp_name(current_temp)
        current_lines = append_string(current_lines, "  " + gep_name + " = getelementptr " + struct_type + ", " + struct_type + "* " + pointer_operand.value + ", i32 0, i32 " + number_to_string(field_info.index))
        current_temp += 1
        load_name = format_temp_name(current_temp)
        current_lines = append_string(current_lines, "  " + load_name + " = load " + field_info.llvm_type + ", " + field_info.llvm_type + "* " + gep_name)
        current_temp += 1
        if field_info.llvm_type == "i8*"  and  len(field_info.type_annotation) > 0:
            base_type = layout_annotation_base_type(field_info.type_annotation)
            enum_info = resolve_enum_info_for_literal(context, base_type)
            if enum_info != None:
                cast_name = format_temp_name(current_temp)
                current_lines = append_string(current_lines, "  " + cast_name + " = bitcast i8* " + load_name + " to " + enum_info.llvm_name + "*")
                current_temp += 1
                typed_operand = LLVMOperand(llvm_type=enum_info.llvm_name + "*", value=cast_name)
                return ExpressionResult(lines=current_lines, temp_index=current_temp, operand=typed_operand, diagnostics=diagnostics, string_constants=collected_string_constants)
            struct_info_candidate = find_struct_info_by_name(context, base_type)
            if struct_info_candidate != None:
                cast_name = format_temp_name(current_temp)
                current_lines = append_string(current_lines, "  " + cast_name + " = bitcast i8* " + load_name + " to " + struct_info_candidate.llvm_name + "*")
                current_temp += 1
                typed_operand = LLVMOperand(llvm_type=struct_info_candidate.llvm_name + "*", value=cast_name)
                return ExpressionResult(lines=current_lines, temp_index=current_temp, operand=typed_operand, diagnostics=diagnostics, string_constants=collected_string_constants)
        operand = LLVMOperand(llvm_type=field_info.llvm_type, value=load_name)
        return ExpressionResult(lines=current_lines, temp_index=current_temp, operand=operand, diagnostics=diagnostics, string_constants=collected_string_constants)
    extract_name = format_temp_name(current_temp)
    current_lines = append_string(current_lines, "  " + extract_name + " = extractvalue " + info.llvm_name + " " + base_operand.value + ", " + number_to_string(field_info.index))
    current_temp += 1
    if field_info.llvm_type == "i8*"  and  len(field_info.type_annotation) > 0:
        base_type = layout_annotation_base_type(field_info.type_annotation)
        enum_info = resolve_enum_info_for_literal(context, base_type)
        if enum_info != None:
            cast_name = format_temp_name(current_temp)
            current_lines = append_string(current_lines, "  " + cast_name + " = bitcast i8* " + extract_name + " to " + enum_info.llvm_name + "*")
            current_temp += 1
            typed_operand = LLVMOperand(llvm_type=enum_info.llvm_name + "*", value=cast_name)
            return ExpressionResult(lines=current_lines, temp_index=current_temp, operand=typed_operand, diagnostics=diagnostics, string_constants=collected_string_constants)
        struct_info_candidate = find_struct_info_by_name(context, base_type)
        if struct_info_candidate != None:
            cast_name = format_temp_name(current_temp)
            current_lines = append_string(current_lines, "  " + cast_name + " = bitcast i8* " + extract_name + " to " + struct_info_candidate.llvm_name + "*")
            current_temp += 1
            typed_operand = LLVMOperand(llvm_type=struct_info_candidate.llvm_name + "*", value=cast_name)
            return ExpressionResult(lines=current_lines, temp_index=current_temp, operand=typed_operand, diagnostics=diagnostics, string_constants=collected_string_constants)
    operand = LLVMOperand(llvm_type=field_info.llvm_type, value=extract_name)
    return ExpressionResult(lines=current_lines, temp_index=current_temp, operand=operand, diagnostics=diagnostics, string_constants=collected_string_constants)

def make_expression_result(lines, temp_index, operand, diagnostics, string_constants):
    return ExpressionResult(lines=lines, temp_index=temp_index, operand=operand, diagnostics=diagnostics, string_constants=string_constants)

def lower_dynamic_member_access(field, base_operand, temp_index, lines, diagnostics, string_constants):
    current_lines = lines
    current_temp = temp_index
    dynamic_string_constants = string_constants
    sanitized_field = sanitize_symbol(field)
    constant_name = "@.runtime.field." + sanitized_field
    existing_constant = find_string_constant_by_name(dynamic_string_constants, constant_name)
    field_constant = StringConstant(name=constant_name, content=field, byte_count=len(field))
    if existing_constant != None:
        field_constant = existing_constant
    else:
        dynamic_string_constants = append_string_constant(dynamic_string_constants, field_constant)
    pointer_result = emit_string_constant_pointer(field_constant, current_temp, current_lines)
    current_lines = pointer_result.lines
    current_temp = pointer_result.temp_index
    field_pointer = pointer_result.pointer
    call_temp = format_temp_name(current_temp)
    current_lines = append_string(current_lines, "  " + call_temp + " = call i8* @sailfin_runtime_get_field(i8* " + base_operand.value + ", i8* " + field_pointer + ")")
    current_temp += 1
    operand = LLVMOperand(llvm_type="i8*", value=call_temp)
    return make_expression_result(current_lines, current_temp, operand, diagnostics, dynamic_string_constants)

def lower_runtime_global_reference(temp_index, lines):
    runtime_temp = format_temp_name(temp_index)
    current_lines = lines
    current_lines = append_string(current_lines, "  " + runtime_temp + " = load i8*, i8** @runtime")
    operand = LLVMOperand(llvm_type="i8*", value=runtime_temp)
    empty_constants = empty_string_constant_set()
    return ExpressionResult(lines=current_lines, temp_index=temp_index + 1, operand=operand, diagnostics=[], string_constants=empty_constants)

def lower_enum_member_access(parse, enum_info, base_operand, pointer_available, temp_index, lines, diagnostics, string_constants, expected_type):
    current_lines = lines
    current_temp = temp_index
    enum_string_constants = string_constants
    messages = diagnostics
    tag_operand = LLVMOperand(llvm_type=enum_info.tag_type, value="")
    if pointer_available:
        tag_ptr = format_temp_name(current_temp)
        current_lines = append_string(current_lines, "  " + tag_ptr + " = getelementptr inbounds " + enum_info.llvm_name + ", " + enum_info.llvm_name + "* " + base_operand.value + ", i32 0, i32 0")
        current_temp += 1
        tag_temp = format_temp_name(current_temp)
        current_lines = append_string(current_lines, "  " + tag_temp + " = load " + enum_info.tag_type + ", " + enum_info.tag_type + "* " + tag_ptr)
        current_temp += 1
        tag_operand = LLVMOperand(llvm_type=enum_info.tag_type, value=tag_temp)
    else:
        tag_temp = format_temp_name(current_temp)
        current_lines = append_string(current_lines, "  " + tag_temp + " = extractvalue " + enum_info.llvm_name + " " + base_operand.value + ", 0")
        current_temp += 1
        tag_operand = LLVMOperand(llvm_type=enum_info.tag_type, value=tag_temp)
    if parse.field == "variant":
        sanitized_enum = sanitize_symbol(enum_info.name)
        default_constant_name = "@.enum." + sanitized_enum + ".variant.default"
        existing_default = find_string_constant_by_name(enum_string_constants, default_constant_name)
        default_constant = StringConstant(name=default_constant_name, content="", byte_count=0)
        if existing_default != None:
            default_constant = existing_default
        else:
            default_constant = StringConstant(name=default_constant_name, content="", byte_count=0)
            enum_string_constants = append_string_constant(enum_string_constants, default_constant)
        default_pointer_result = emit_string_constant_pointer(default_constant, current_temp, current_lines)
        current_lines = default_pointer_result.lines
        current_temp = default_pointer_result.temp_index
        current_pointer = default_pointer_result.pointer
        variant_index = 0
        while True:
            if variant_index >= len(enum_info.variants):
                break
            variant_info = enum_info.variants[variant_index]
            sanitized_variant = sanitize_symbol(variant_info.name)
            constant_name = "@.enum." + sanitized_enum + "." + sanitized_variant + ".variant"
            existing_variant = find_string_constant_by_name(enum_string_constants, constant_name)
            variant_constant = StringConstant(name=constant_name, content="", byte_count=0)
            if existing_variant != None:
                variant_constant = existing_variant
            else:
                variant_constant = StringConstant(name=constant_name, content=variant_info.name, byte_count=len(variant_info.name))
                enum_string_constants = append_string_constant(enum_string_constants, variant_constant)
            pointer_result = emit_string_constant_pointer(variant_constant, current_temp, current_lines)
            current_lines = pointer_result.lines
            current_temp = pointer_result.temp_index
            variant_pointer = pointer_result.pointer
            compare_temp = format_temp_name(current_temp)
            current_lines = append_string(current_lines, "  " + compare_temp + " = icmp eq " + tag_operand.llvm_type + " " + tag_operand.value + ", " + number_to_string(variant_info.tag))
            current_temp += 1
            select_temp = format_temp_name(current_temp)
            current_lines = append_string(current_lines, "  " + select_temp + " = select i1 " + compare_temp + ", i8* " + variant_pointer + ", i8* " + current_pointer)
            current_temp += 1
            current_pointer = select_temp
            variant_index += 1
        operand = LLVMOperand(llvm_type="i8*", value=current_pointer)
        return make_expression_result(current_lines, current_temp, operand, messages, enum_string_constants)
    matched_variants = []
    matched_fields = []
    variant_check_index = 0
    while True:
        if variant_check_index >= len(enum_info.variants):
            break
        candidate_variant = enum_info.variants[variant_check_index]
        candidate_field = find_variant_field_info(candidate_variant, parse.field)
        if candidate_field != None:
            matched_variants = (matched_variants) + ([candidate_variant])
            matched_fields = (matched_fields) + ([candidate_field])
        variant_check_index += 1
    if len(matched_variants) == 0:
        messages = append_string(messages, "llvm lowering: enum `" + enum_info.name + "` has no field `" + parse.field + "` on any variant")
        return make_expression_result(current_lines, current_temp, None, messages, enum_string_constants)
    selected_variants = matched_variants
    selected_fields = matched_fields
    if len(expected_type) > 0:
        filtered_variants = []
        filtered_fields = []
        selection_index = 0
        while True:
            if selection_index >= len(matched_fields):
                break
            candidate_field = matched_fields[selection_index]
            if candidate_field.llvm_type == expected_type:
                filtered_variants = (filtered_variants) + ([matched_variants[selection_index]])
                filtered_fields = (filtered_fields) + ([candidate_field])
            selection_index += 1
        if len(filtered_variants) > 0:
            selected_variants = filtered_variants
            selected_fields = filtered_fields
    if len(selected_variants) == 0:
        if len(expected_type) > 0:
            messages = append_string(messages, "llvm lowering: enum `" + enum_info.name + "` has no field `" + parse.field + "` compatible with expected type `" + expected_type + "`")
        else:
            messages = append_string(messages, "llvm lowering: enum member access for `" + enum_info.name + "." + parse.field + "` uses incompatible field types across variants")
        return make_expression_result(current_lines, current_temp, None, messages, enum_string_constants)
    first_type = selected_fields[0].llvm_type
    base_type = first_type
    first_pointer_depth = 0
    while True:
        if not ends_with_pointer_suffix(base_type):
            break
        base_type = strip_pointer_suffix(base_type)
        first_pointer_depth += 1
    min_pointer_depth = first_pointer_depth
    max_pointer_depth = first_pointer_depth
    consistent_base = True
    pointer_depth_mismatch = False
    type_index = 1
    while True:
        if type_index >= len(selected_fields):
            break
        candidate_type = selected_fields[type_index].llvm_type
        candidate_base = candidate_type
        candidate_depth = 0
        while True:
            if not ends_with_pointer_suffix(candidate_base):
                break
            candidate_base = strip_pointer_suffix(candidate_base)
            candidate_depth += 1
        if candidate_base != base_type:
            consistent_base = False
            break
        if candidate_depth != first_pointer_depth:
            pointer_depth_mismatch = True
        if candidate_depth < min_pointer_depth:
            min_pointer_depth = candidate_depth
        if candidate_depth > max_pointer_depth:
            max_pointer_depth = candidate_depth
        type_index += 1
    if not consistent_base:
        messages = append_string(messages, "llvm lowering: enum member access for `" + enum_info.name + "." + parse.field + "` uses incompatible field types across variants")
        return make_expression_result(current_lines, current_temp, None, messages, enum_string_constants)
    field_type = selected_fields[0].llvm_type
    pointer_coercion = False
    if pointer_depth_mismatch:
        if max_pointer_depth - min_pointer_depth == 1  and  len(base_type) > 0  and  base_type[0] == "%":
            pointer_coercion = True
            field_type = base_type + "*"
        else:
            messages = append_string(messages, "llvm lowering: enum member access for `" + enum_info.name + "." + parse.field + "` uses incompatible field types across variants")
            return make_expression_result(current_lines, current_temp, None, messages, enum_string_constants)
    enum_pointer_value = base_operand.value
    if not pointer_available:
        alloca_temp = format_temp_name(current_temp)
        current_lines = append_string(current_lines, "  " + alloca_temp + " = alloca " + enum_info.llvm_name)
        current_temp += 1
        current_lines = append_string(current_lines, "  store " + enum_info.llvm_name + " " + base_operand.value + ", " + enum_info.llvm_name + "* " + alloca_temp)
        enum_pointer_value = alloca_temp
    default_literal = default_return_literal(field_type)
    current_value_text = default_literal
    match_index = 0
    while True:
        if match_index >= len(selected_variants):
            break
        variant_info = selected_variants[match_index]
        field_info = selected_fields[match_index]
        payload_ptr_temp = format_temp_name(current_temp)
        current_lines = append_string(current_lines, "  " + payload_ptr_temp + " = getelementptr inbounds " + enum_info.llvm_name + ", " + enum_info.llvm_name + "* " + enum_pointer_value + ", i32 0, i32 1")
        current_temp += 1
        byte_ptr_temp = format_temp_name(current_temp)
        current_lines = append_string(current_lines, "  " + byte_ptr_temp + " = bitcast [" + number_to_string(enum_info.max_payload_size) + " x i8]* " + payload_ptr_temp + " to i8*")
        current_temp += 1
        field_offset_in_payload = field_info.offset - variant_info.offset
        field_ptr_temp = byte_ptr_temp
        if field_offset_in_payload > 0:
            offset_ptr_temp = format_temp_name(current_temp)
            current_lines = append_string(current_lines, "  " + offset_ptr_temp + " = getelementptr inbounds i8, i8* " + byte_ptr_temp + ", i64 " + number_to_string(field_offset_in_payload))
            current_temp += 1
            field_ptr_temp = offset_ptr_temp
        storage_type = field_info.llvm_type
        typed_ptr_temp = format_temp_name(current_temp)
        current_lines = append_string(current_lines, "  " + typed_ptr_temp + " = bitcast i8* " + field_ptr_temp + " to " + storage_type + "*")
        current_temp += 1
        value_temp = typed_ptr_temp
        if pointer_coercion:
            if ends_with_pointer_suffix(storage_type):
                value_temp = format_temp_name(current_temp)
                current_lines = append_string(current_lines, "  " + value_temp + " = load " + storage_type + ", " + storage_type + "* " + typed_ptr_temp)
                current_temp += 1
        else:
            value_temp = format_temp_name(current_temp)
            current_lines = append_string(current_lines, "  " + value_temp + " = load " + storage_type + ", " + storage_type + "* " + typed_ptr_temp)
            current_temp += 1
        compare_temp = format_temp_name(current_temp)
        current_lines = append_string(current_lines, "  " + compare_temp + " = icmp eq " + tag_operand.llvm_type + " " + tag_operand.value + ", " + number_to_string(variant_info.tag))
        current_temp += 1
        select_temp = format_temp_name(current_temp)
        current_lines = append_string(current_lines, "  " + select_temp + " = select i1 " + compare_temp + ", " + field_type + " " + value_temp + ", " + field_type + " " + current_value_text)
        current_temp += 1
        current_value_text = select_temp
        match_index += 1
    operand = LLVMOperand(llvm_type=field_type, value=current_value_text)
    return make_expression_result(current_lines, current_temp, operand, messages, enum_string_constants)

def emit_string_constant_pointer(constant, temp_index, lines):
    current_lines = lines
    array_length = constant.byte_count + 1
    array_type = "[" + number_to_string(array_length) + " x i8]"
    temp_name = format_temp_name(temp_index)
    current_lines = append_string(current_lines, "  " + temp_name + " = getelementptr inbounds " + array_type + ", " + array_type + "* " + constant.name + ", i32 0, i32 0")
    return StringPointerResult(lines=current_lines, temp_index=temp_index + 1, pointer=temp_name)

def lower_index_expression(parse, bindings, locals, temp_index, lines, functions, context):
    base_result = lower_expression(parse.base, bindings, locals, temp_index, lines, functions, context, "")
    diagnostics = base_result.diagnostics
    collected_string_constants = base_result.string_constants
    if base_result.operand == None:
        return ExpressionResult(lines=base_result.lines, temp_index=base_result.temp_index, operand=None, diagnostics=diagnostics, string_constants=collected_string_constants)
    current_lines = base_result.lines
    current_temp = base_result.temp_index
    base_operand = base_result.operand
    index_result = lower_expression(parse.index, bindings, locals, current_temp, current_lines, functions, context, "")
    diagnostics = (diagnostics) + (index_result.diagnostics)
    collected_string_constants = merge_string_constants(collected_string_constants, index_result.string_constants)
    current_lines = index_result.lines
    current_temp = index_result.temp_index
    if index_result.operand == None:
        diagnostics = append_string(diagnostics, "llvm lowering: index expression produced no value")
        return ExpressionResult(lines=current_lines, temp_index=current_temp, operand=None, diagnostics=diagnostics, string_constants=collected_string_constants)
    index_operand = index_result.operand
    index_coercion = coerce_operand_to_type(index_operand, "i64", current_temp, current_lines)
    diagnostics = (diagnostics) + (index_coercion.diagnostics)
    current_lines = index_coercion.lines
    current_temp = index_coercion.temp_index
    if index_coercion.operand == None:
        diagnostics = append_string(diagnostics, "llvm lowering: unable to coerce index expression to i64")
        return ExpressionResult(lines=current_lines, temp_index=current_temp, operand=None, diagnostics=diagnostics, string_constants=collected_string_constants)
    coerced_index = index_coercion.operand
    array_type = base_operand.llvm_type
    element_type = ""
    is_heap_array = False
    is_string = False
    if array_type == "i8*":
        element_type = "i8"
        is_string = True
    else:
        if ends_with_pointer_suffix(array_type):
            inner_type = strip_pointer_suffix(array_type)
            if starts_with(inner_type, "{")  and  len(inner_type) > 0  and  inner_type[len(inner_type) - 1] == "}":
                struct_inner = trim_text(substring(inner_type, 1, len(inner_type) - 1))
                comma_pos = -1
                brace_depth = 0
                bracket_depth = 0
                paren_depth = 0
                angle_depth = 0
                i = 0
                while True:
                    if i >= len(struct_inner):
                        break
                    ch = struct_inner[i]
                    if ch == "{":
                        brace_depth += 1
                    else:
                        if ch == "}":
                            if brace_depth > 0:
                                brace_depth -= 1
                        else:
                            if ch == "[":
                                bracket_depth += 1
                            else:
                                if ch == "]":
                                    if bracket_depth > 0:
                                        bracket_depth -= 1
                                else:
                                    if ch == "(":
                                        paren_depth += 1
                                    else:
                                        if ch == ")":
                                            if paren_depth > 0:
                                                paren_depth -= 1
                                        else:
                                            if ch == "<":
                                                angle_depth += 1
                                            else:
                                                if ch == ">":
                                                    if angle_depth > 0:
                                                        angle_depth -= 1
                                                else:
                                                    if ch == ",":
                                                        if brace_depth == 0  and  bracket_depth == 0  and  paren_depth == 0  and  angle_depth == 0:
                                                            comma_pos = i
                                                            break
                    i += 1
                if comma_pos >= 0:
                    first_field = trim_text(substring(struct_inner, 0, comma_pos))
                    if ends_with_pointer_suffix(first_field):
                        element_type = strip_pointer_suffix(first_field)
                        is_heap_array = True
    if len(element_type) == 0:
        diagnostics = append_string(diagnostics, "llvm lowering: unable to determine element type for array indexing on type `" + array_type + "`")
        return ExpressionResult(lines=current_lines, temp_index=current_temp, operand=None, diagnostics=diagnostics, string_constants=collected_string_constants)
    if is_heap_array:
        data_ptr = ""
        length_value = ""
        array_struct_type = strip_pointer_suffix(array_type)
        loaded_array = format_temp_name(current_temp)
        current_lines = append_string(current_lines, "  " + loaded_array + " = load " + array_struct_type + ", " + array_type + " " + base_operand.value)
        current_temp += 1
        data_ptr_extracted = format_temp_name(current_temp)
        current_lines = append_string(current_lines, "  " + data_ptr_extracted + " = extractvalue " + array_struct_type + " " + loaded_array + ", 0")
        current_temp += 1
        data_ptr = data_ptr_extracted
        length_temp = format_temp_name(current_temp)
        current_lines = append_string(current_lines, "  " + length_temp + " = extractvalue " + array_struct_type + " " + loaded_array + ", 1")
        current_temp += 1
        length_value = length_temp
        bounds_check = format_temp_name(current_temp)
        current_lines = append_string(current_lines, "  " + bounds_check + " = icmp uge i64 " + coerced_index.value + ", " + length_value)
        current_temp += 1
        current_lines = append_string(current_lines, "  ; bounds check: " + bounds_check + " (if true, out of bounds)")
        current_lines = append_string(current_lines, "  call void @sailfin_runtime_bounds_check(i64 " + coerced_index.value + ", i64 " + length_value + ")")
        element_ptr = format_temp_name(current_temp)
        current_lines = append_string(current_lines, "  " + element_ptr + " = getelementptr " + element_type + ", " + element_type + "* " + data_ptr + ", i64 " + coerced_index.value)
        current_temp += 1
        element_value = format_temp_name(current_temp)
        current_lines = append_string(current_lines, "  " + element_value + " = load " + element_type + ", " + element_type + "* " + element_ptr)
        current_temp += 1
        operand = LLVMOperand(llvm_type=element_type, value=element_value)
        return ExpressionResult(lines=current_lines, temp_index=current_temp, operand=operand, diagnostics=diagnostics, string_constants=collected_string_constants)
    else:
        if is_string:
            char_ptr = format_temp_name(current_temp)
            current_lines = append_string(current_lines, "  " + char_ptr + " = getelementptr i8, i8* " + base_operand.value + ", i64 " + coerced_index.value)
            current_temp += 1
            ch_value = format_temp_name(current_temp)
            current_lines = append_string(current_lines, "  " + ch_value + " = load i8, i8* " + char_ptr)
            current_temp += 1
            buf = format_temp_name(current_temp)
            current_lines = append_string(current_lines, "  " + buf + " = call i8* @malloc(i64 2)")
            current_temp += 1
            buf0 = format_temp_name(current_temp)
            current_lines = append_string(current_lines, "  " + buf0 + " = getelementptr i8, i8* " + buf + ", i64 0")
            current_temp += 1
            current_lines = append_string(current_lines, "  store i8 " + ch_value + ", i8* " + buf0)
            buf1 = format_temp_name(current_temp)
            current_lines = append_string(current_lines, "  " + buf1 + " = getelementptr i8, i8* " + buf + ", i64 1")
            current_temp += 1
            current_lines = append_string(current_lines, "  store i8 0, i8* " + buf1)
            operand = LLVMOperand(llvm_type="i8*", value=buf)
            return ExpressionResult(lines=current_lines, temp_index=current_temp, operand=operand, diagnostics=diagnostics, string_constants=collected_string_constants)
    diagnostics = append_string(diagnostics, "llvm lowering: unsupported array type for indexing: `" + array_type + "`")
    return ExpressionResult(lines=current_lines, temp_index=current_temp, operand=None, diagnostics=diagnostics, string_constants=collected_string_constants)

def lower_array_literal(text, bindings, locals, temp_index, lines, functions, context, expected_type):
    diagnostics = []
    current_lines = lines
    current_temp = temp_index
    collected_string_constants = empty_string_constant_set()
    trimmed_expected = trim_text(expected_type)
    if trimmed_expected == "i8*":
        inner = trim_text(substring(text, 1, len(text) - 1))
        elements = []
        if len(inner) > 0:
            elements = split_array_elements(inner)
        open = lower_string_literal("\"[\"", current_temp, current_lines)
        current_lines = open.lines
        current_temp = open.temp_index
        if open.operand == None:
            return ExpressionResult(lines=current_lines, temp_index=current_temp, operand=None, diagnostics=diagnostics, string_constants=collected_string_constants)
        current_operand = open.operand
        index = 0
        while True:
            if index >= len(elements):
                break
            element_text = trim_text(elements[index])
            if len(element_text) == 0:
                diagnostics = append_string(diagnostics, "llvm lowering: empty element in array literal")
                index += 1
                continue
            if index > 0:
                sep = lower_string_literal("\", \"", current_temp, current_lines)
                current_lines = sep.lines
                current_temp = sep.temp_index
                if sep.operand == None:
                    return ExpressionResult(lines=current_lines, temp_index=current_temp, operand=None, diagnostics=diagnostics, string_constants=collected_string_constants)
                with_sep = emit_string_concat(current_operand, sep.operand, current_temp, current_lines)
                diagnostics = (diagnostics) + (with_sep.diagnostics)
                current_lines = with_sep.lines
                current_temp = with_sep.temp_index
                if with_sep.operand == None:
                    return ExpressionResult(lines=current_lines, temp_index=current_temp, operand=None, diagnostics=diagnostics, string_constants=collected_string_constants)
                current_operand = with_sep.operand
            lowered = lower_expression(element_text, bindings, locals, current_temp, current_lines, functions, context, "")
            diagnostics = (diagnostics) + (lowered.diagnostics)
            collected_string_constants = merge_string_constants(collected_string_constants, lowered.string_constants)
            current_lines = lowered.lines
            current_temp = lowered.temp_index
            if lowered.operand == None:
                diagnostics = append_string(diagnostics, "llvm lowering: array literal element produced no value")
                return ExpressionResult(lines=current_lines, temp_index=current_temp, operand=None, diagnostics=diagnostics, string_constants=collected_string_constants)
            as_string = coerce_operand_to_string(lowered.operand, current_temp, current_lines)
            diagnostics = (diagnostics) + (as_string.diagnostics)
            collected_string_constants = merge_string_constants(collected_string_constants, as_string.string_constants)
            current_lines = as_string.lines
            current_temp = as_string.temp_index
            if as_string.operand == None:
                diagnostics = append_string(diagnostics, "llvm lowering: unable to stringify array literal element")
                return ExpressionResult(lines=current_lines, temp_index=current_temp, operand=None, diagnostics=diagnostics, string_constants=collected_string_constants)
            appended = emit_string_concat(current_operand, as_string.operand, current_temp, current_lines)
            diagnostics = (diagnostics) + (appended.diagnostics)
            current_lines = appended.lines
            current_temp = appended.temp_index
            if appended.operand == None:
                return ExpressionResult(lines=current_lines, temp_index=current_temp, operand=None, diagnostics=diagnostics, string_constants=collected_string_constants)
            current_operand = appended.operand
            index += 1
        close = lower_string_literal("\"]\"", current_temp, current_lines)
        current_lines = close.lines
        current_temp = close.temp_index
        if close.operand == None:
            return ExpressionResult(lines=current_lines, temp_index=current_temp, operand=None, diagnostics=diagnostics, string_constants=collected_string_constants)
        finished = emit_string_concat(current_operand, close.operand, current_temp, current_lines)
        diagnostics = (diagnostics) + (finished.diagnostics)
        current_lines = finished.lines
        current_temp = finished.temp_index
        return ExpressionResult(lines=current_lines, temp_index=current_temp, operand=finished.operand, diagnostics=diagnostics, string_constants=collected_string_constants)
    expected_element_type = ""
    if len(trimmed_expected) > 0:
        expected_element_type = array_pointer_element_type(trimmed_expected)
    expected_struct_type = ""
    if len(expected_element_type) > 0:
        expected_struct_type = array_struct_type_for_element(expected_element_type)
    inner = trim_text(substring(text, 1, len(text) - 1))
    elements = split_array_elements(inner)
    metadata = parse_array_literal_metadata(elements, context)
    operands = []
    inferred_element_type = metadata.element_type
    if len(inferred_element_type) == 0  and  len(expected_element_type) > 0:
        inferred_element_type = expected_element_type
    index = metadata.start_index
    while True:
        if index >= len(elements):
            break
        element_text = trim_text(elements[index])
        if len(element_text) == 0:
            diagnostics = append_string(diagnostics, "llvm lowering: empty element in array literal")
            index += 1
            continue
        lowered = lower_expression(element_text, bindings, locals, current_temp, current_lines, functions, context, "")
        diagnostics = (diagnostics) + (lowered.diagnostics)
        collected_string_constants = merge_string_constants(collected_string_constants, lowered.string_constants)
        current_lines = lowered.lines
        current_temp = lowered.temp_index
        if lowered.operand == None:
            diagnostics = append_string(diagnostics, "llvm lowering: array literal element produced no value")
            return ExpressionResult(lines=current_lines, temp_index=current_temp, operand=None, diagnostics=diagnostics, string_constants=collected_string_constants)
        operands = append_llvm_operand(operands, lowered.operand)
        inferred_element_type = dominant_type(inferred_element_type, lowered.operand.llvm_type)
        index += 1
    if len(operands) == 0:
        if len(inferred_element_type) == 0  and  len(expected_element_type) > 0:
            inferred_element_type = expected_element_type
        if len(inferred_element_type) == 0:
            inferred_element_type = "double"
    if len(inferred_element_type) == 0:
        diagnostics = append_string(diagnostics, "llvm lowering: unsupported array literal element type")
        return ExpressionResult(lines=current_lines, temp_index=current_temp, operand=None, diagnostics=diagnostics, string_constants=collected_string_constants)
    element_type = inferred_element_type
    coerced_operands = []
    index = 0
    while True:
        if index >= len(operands):
            break
        operand = operands[index]
        prepared_operand = operand
        if ends_with_pointer_suffix(element_type)  and  not ends_with_pointer_suffix(operand.llvm_type)  and  not is_string_pointer_type(element_type):
            boxed = box_aggregate_operand(operand, element_type, current_temp, current_lines, context)
            diagnostics = (diagnostics) + (boxed.diagnostics)
            current_lines = boxed.lines
            current_temp = boxed.temp_index
            if boxed.operand == None:
                diagnostics = append_string(diagnostics, "llvm lowering: array literal element could not be boxed to `" + element_type + "`")
                return ExpressionResult(lines=current_lines, temp_index=current_temp, operand=None, diagnostics=diagnostics, string_constants=collected_string_constants)
            prepared_operand = boxed.operand
        coerced = coerce_operand_to_type(prepared_operand, element_type, current_temp, current_lines)
        diagnostics = (diagnostics) + (coerced.diagnostics)
        current_lines = coerced.lines
        current_temp = coerced.temp_index
        if coerced.operand == None:
            diagnostics = append_string(diagnostics, "llvm lowering: array literal element could not be coerced to `" + element_type + "`")
            return ExpressionResult(lines=current_lines, temp_index=current_temp, operand=None, diagnostics=diagnostics, string_constants=collected_string_constants)
        coerced_operands = append_llvm_operand(coerced_operands, coerced.operand)
        index += 1
    operands = coerced_operands
    length_value = len(operands)
    length_text = number_to_string(length_value)
    array_type = "[" + length_text + " x " + element_type + "]"
    array_size_ptr = format_temp_name(current_temp)
    current_lines = append_string(current_lines, "  " + array_size_ptr + " = getelementptr " + array_type + ", " + array_type + "* null, i32 1")
    current_temp += 1
    array_bytes = format_temp_name(current_temp)
    current_lines = append_string(current_lines, "  " + array_bytes + " = ptrtoint " + array_type + "* " + array_size_ptr + " to i64")
    current_temp += 1
    array_bytes_is_zero = format_temp_name(current_temp)
    current_lines = append_string(current_lines, "  " + array_bytes_is_zero + " = icmp eq i64 " + array_bytes + ", 0")
    current_temp += 1
    adjusted_array_bytes = format_temp_name(current_temp)
    current_lines = append_string(current_lines, "  " + adjusted_array_bytes + " = select i1 " + array_bytes_is_zero + ", i64 1, i64 " + array_bytes)
    current_temp += 1
    raw_array_ptr = format_temp_name(current_temp)
    current_lines = append_string(current_lines, "  " + raw_array_ptr + " = call i8* @malloc(i64 " + adjusted_array_bytes + ")")
    current_temp += 1
    data_pointer = format_temp_name(current_temp)
    current_lines = append_string(current_lines, "  " + data_pointer + " = bitcast i8* " + raw_array_ptr + " to " + element_type + "*")
    current_temp += 1
    index = 0
    while True:
        if index >= len(operands):
            break
        element_pointer = format_temp_name(current_temp)
        current_lines = append_string(current_lines, "  " + element_pointer + " = getelementptr " + element_type + ", " + element_type + "* " + data_pointer + ", i64 " + number_to_string(index))
        current_temp += 1
        current_lines = append_string(current_lines, "  store " + element_type + " " + operands[index].value + ", " + element_type + "* " + element_pointer)
        index += 1
    struct_type = array_struct_type_for_element(element_type)
    if len(operands) == 0  and  len(expected_struct_type) > 0:
        struct_type = expected_struct_type
    struct_size_ptr = format_temp_name(current_temp)
    current_lines = append_string(current_lines, "  " + struct_size_ptr + " = getelementptr " + struct_type + ", " + struct_type + "* null, i32 1")
    current_temp += 1
    struct_bytes = format_temp_name(current_temp)
    current_lines = append_string(current_lines, "  " + struct_bytes + " = ptrtoint " + struct_type + "* " + struct_size_ptr + " to i64")
    current_temp += 1
    raw_struct_ptr = format_temp_name(current_temp)
    current_lines = append_string(current_lines, "  " + raw_struct_ptr + " = call i8* @malloc(i64 " + struct_bytes + ")")
    current_temp += 1
    struct_pointer = format_temp_name(current_temp)
    current_lines = append_string(current_lines, "  " + struct_pointer + " = bitcast i8* " + raw_struct_ptr + " to " + struct_type + "*")
    current_temp += 1
    data_field_pointer = format_temp_name(current_temp)
    current_lines = append_string(current_lines, "  " + data_field_pointer + " = getelementptr " + struct_type + ", " + struct_type + "* " + struct_pointer + ", i32 0, i32 0")
    current_temp += 1
    data_pointer_type = element_type + "*"
    data_pointer_pointer_type = data_pointer_type + "*"
    current_lines = append_string(current_lines, "  store " + data_pointer_type + " " + data_pointer + ", " + data_pointer_pointer_type + " " + data_field_pointer)
    length_field_pointer = format_temp_name(current_temp)
    current_lines = append_string(current_lines, "  " + length_field_pointer + " = getelementptr " + struct_type + ", " + struct_type + "* " + struct_pointer + ", i32 0, i32 1")
    current_temp += 1
    current_lines = append_string(current_lines, "  store i64 " + length_text + ", i64* " + length_field_pointer)
    operand = LLVMOperand(llvm_type=struct_type + "*", value=struct_pointer)
    return ExpressionResult(lines=current_lines, temp_index=current_temp, operand=operand, diagnostics=diagnostics, string_constants=collected_string_constants)

def find_matching_closing_brace(text, open_index):
    depth = 0
    index = open_index
    in_single = False
    in_double = False
    escape = False
    while True:
        if index >= len(text):
            break
        ch = text[index]
        if in_double:
            if escape:
                escape = False
            else:
                if ch == "\\":
                    escape = True
                else:
                    if ch == "\"":
                        in_double = False
            index += 1
            continue
        if in_single:
            if escape:
                escape = False
            else:
                if ch == "\\":
                    escape = True
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
        if ch == "{":
            depth += 1
        else:
            if ch == "}":
                if depth > 0:
                    depth -= 1
                    if depth == 0:
                        return index
        index += 1
    return -1

def find_top_level_colon(text):
    paren_depth = 0
    bracket_depth = 0
    brace_depth = 0
    angle_depth = 0
    in_single = False
    in_double = False
    escape = False
    index = 0
    while True:
        if index >= len(text):
            break
        ch = text[index]
        if in_double:
            if escape:
                escape = False
            else:
                if ch == "\\":
                    escape = True
                else:
                    if ch == "\"":
                        in_double = False
            index += 1
            continue
        if in_single:
            if escape:
                escape = False
            else:
                if ch == "\\":
                    escape = True
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
            brace_depth += 1
            index += 1
            continue
        if ch == "}":
            if brace_depth > 0:
                brace_depth -= 1
            index += 1
            continue
        if ch == "<":
            angle_depth += 1
            index += 1
            continue
        if ch == ">":
            if angle_depth > 0:
                angle_depth -= 1
            index += 1
            continue
        if ch == ":":
            if paren_depth == 0  and  bracket_depth == 0  and  brace_depth == 0  and  angle_depth == 0:
                return index
        index += 1
    return -1

def parse_struct_literal(text):
    trimmed = trim_text(text)
    diagnostics = []
    if len(trimmed) == 0:
        return StructLiteralParse(recognized=False, success=False, type_name="", fields=[], diagnostics=diagnostics)
    first = trimmed[0]
    if not is_identifier_start_char(first):
        return StructLiteralParse(recognized=False, success=False, type_name="", fields=[], diagnostics=diagnostics)
    paren_depth = 0
    bracket_depth = 0
    angle_depth = 0
    index = 0
    open_index = -1
    in_single = False
    in_double = False
    escape = False
    while True:
        if index >= len(trimmed):
            break
        ch = trimmed[index]
        if in_double:
            if escape:
                escape = False
            else:
                if ch == "\\":
                    escape = True
                else:
                    if ch == "\"":
                        in_double = False
            index += 1
            continue
        if in_single:
            if escape:
                escape = False
            else:
                if ch == "\\":
                    escape = True
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
        if ch == "(":
            paren_depth += 1
        else:
            if ch == ")":
                if paren_depth > 0:
                    paren_depth -= 1
            else:
                if ch == "[":
                    bracket_depth += 1
                else:
                    if ch == "]":
                        if bracket_depth > 0:
                            bracket_depth -= 1
                    else:
                        if ch == "<":
                            angle_depth += 1
                        else:
                            if ch == ">":
                                if angle_depth > 0:
                                    angle_depth -= 1
                            else:
                                if ch == "{":
                                    if paren_depth == 0  and  bracket_depth == 0  and  angle_depth == 0:
                                        open_index = index
                                        break
        index += 1
    if open_index < 0:
        return StructLiteralParse(recognized=False, success=False, type_name="", fields=[], diagnostics=diagnostics)
    fatal = False
    close_index = find_matching_closing_brace(trimmed, open_index)
    if close_index < 0:
        diagnostics = append_string(diagnostics, "llvm lowering: struct literal missing closing `}`")
        snippet = trimmed
        if len(snippet) > 120:
            snippet = substring(snippet, 0, 117) + "..."
        diagnostics = append_string(diagnostics, "llvm lowering: struct literal context `" + snippet + "`")
        fatal = True
    type_name = trim_text(substring(trimmed, 0, open_index))
    if len(type_name) == 0:
        diagnostics = append_string(diagnostics, "llvm lowering: struct literal missing type name")
        fatal = True
    fields = []
    if not fatal  and  close_index >= 0:
        body = substring(trimmed, open_index + 1, close_index)
        entries = split_array_elements(body)
        seen = []
        entry_index = 0
        while True:
            if entry_index >= len(entries):
                break
            entry = trim_text(entries[entry_index])
            entry_index += 1
            if len(entry) == 0:
                continue
            colon_index = find_top_level_colon(entry)
            if colon_index < 0:
                diagnostics = append_string(diagnostics, "llvm lowering: struct literal field `" + entry + "` missing `:`")
                continue
            field_name = trim_text(substring(entry, 0, colon_index))
            value_text = trim_text(substring(entry, colon_index + 1, len(entry)))
            if len(field_name) == 0:
                diagnostics = append_string(diagnostics, "llvm lowering: struct literal field missing name")
                continue
            if string_array_contains(seen, field_name):
                diagnostics = append_string(diagnostics, "llvm lowering: struct literal field `" + field_name + "` repeated")
                continue
            if len(value_text) == 0:
                diagnostics = append_string(diagnostics, "llvm lowering: struct literal field `" + field_name + "` missing value")
                continue
            seen = append_string(seen, field_name)
            fields = (fields) + ([StructLiteralField(name=field_name, value=value_text)])
    if not fatal  and  close_index >= 0:
        remainder = trim_text(substring(trimmed, close_index + 1, len(trimmed)))
        if len(remainder) > 0:
            diagnostics = append_string(diagnostics, "llvm lowering: struct literal trailing content `" + remainder + "`")
            fatal = True
    if fatal:
        fields = []
    return StructLiteralParse(recognized=True, success=not fatal, type_name=type_name, fields=fields, diagnostics=diagnostics)

def parse_struct_pattern(text):
    trimmed = trim_text(text)
    diagnostics = []
    if len(trimmed) == 0:
        return StructLiteralParse(recognized=False, success=False, type_name="", fields=[], diagnostics=diagnostics)
    first = trimmed[0]
    if not is_identifier_start_char(first):
        return StructLiteralParse(recognized=False, success=False, type_name="", fields=[], diagnostics=diagnostics)
    paren_depth = 0
    bracket_depth = 0
    angle_depth = 0
    index = 0
    open_index = -1
    in_single = False
    in_double = False
    escape = False
    while True:
        if index >= len(trimmed):
            break
        ch = trimmed[index]
        if in_double:
            if escape:
                escape = False
            else:
                if ch == "\\":
                    escape = True
                else:
                    if ch == "\"":
                        in_double = False
            index += 1
            continue
        if in_single:
            if escape:
                escape = False
            else:
                if ch == "\\":
                    escape = True
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
        if ch == "(":
            paren_depth += 1
        else:
            if ch == ")":
                if paren_depth > 0:
                    paren_depth -= 1
            else:
                if ch == "[":
                    bracket_depth += 1
                else:
                    if ch == "]":
                        if bracket_depth > 0:
                            bracket_depth -= 1
                    else:
                        if ch == "<":
                            angle_depth += 1
                        else:
                            if ch == ">":
                                if angle_depth > 0:
                                    angle_depth -= 1
                            else:
                                if ch == "{":
                                    if paren_depth == 0  and  bracket_depth == 0  and  angle_depth == 0:
                                        open_index = index
                                        break
        index += 1
    if open_index < 0:
        return StructLiteralParse(recognized=False, success=False, type_name="", fields=[], diagnostics=diagnostics)
    fatal = False
    close_index = find_matching_closing_brace(trimmed, open_index)
    if close_index < 0:
        fatal = True
    type_name = trim_text(substring(trimmed, 0, open_index))
    if len(type_name) == 0:
        fatal = True
    fields = []
    if not fatal  and  close_index >= 0:
        body = substring(trimmed, open_index + 1, close_index)
        entries = split_array_elements(body)
        seen = []
        entry_index = 0
        while True:
            if entry_index >= len(entries):
                break
            entry = trim_text(entries[entry_index])
            entry_index += 1
            if len(entry) == 0:
                continue
            colon_index = find_top_level_colon(entry)
            if colon_index < 0:
                field_name = trim_text(entry)
                if len(field_name) == 0:
                    continue
                if string_array_contains(seen, field_name):
                    continue
                seen = append_string(seen, field_name)
                fields = (fields) + ([StructLiteralField(name=field_name, value="")])
                continue
            field_name = trim_text(substring(entry, 0, colon_index))
            value_text = trim_text(substring(entry, colon_index + 1, len(entry)))
            if len(field_name) == 0:
                continue
            if string_array_contains(seen, field_name):
                continue
            if len(value_text) == 0:
                continue
            seen = append_string(seen, field_name)
            fields = (fields) + ([StructLiteralField(name=field_name, value=value_text)])
    if fatal:
        fields = []
    return StructLiteralParse(recognized=True, success=not fatal, type_name=type_name, fields=fields, diagnostics=diagnostics)

def parse_enum_literal(text):
    trimmed = trim_text(text)
    diagnostics = []
    if len(trimmed) == 0:
        return EnumLiteralParse(recognized=False, success=False, enum_name="", variant_name="", fields=[], diagnostics=diagnostics)
    first = trimmed[0]
    if not is_identifier_start_char(first):
        return EnumLiteralParse(recognized=False, success=False, enum_name="", variant_name="", fields=[], diagnostics=diagnostics)
    dot_index = index_of(trimmed, ".")
    if dot_index < 0:
        return EnumLiteralParse(recognized=False, success=False, enum_name="", variant_name="", fields=[], diagnostics=diagnostics)
    enum_name_part = trim_text(substring(trimmed, 0, dot_index))
    if len(enum_name_part) == 0:
        return EnumLiteralParse(recognized=False, success=False, enum_name="", variant_name="", fields=[], diagnostics=diagnostics)
    paren_depth = 0
    bracket_depth = 0
    angle_depth = 0
    index = dot_index + 1
    open_index = -1
    in_single = False
    in_double = False
    escape = False
    while True:
        if index >= len(trimmed):
            break
        ch = trimmed[index]
        if in_double:
            if escape:
                escape = False
            else:
                if ch == "\\":
                    escape = True
                else:
                    if ch == "\"":
                        in_double = False
            index += 1
            continue
        if in_single:
            if escape:
                escape = False
            else:
                if ch == "\\":
                    escape = True
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
        if ch == "(":
            paren_depth += 1
        else:
            if ch == ")":
                if paren_depth > 0:
                    paren_depth -= 1
            else:
                if ch == "[":
                    bracket_depth += 1
                else:
                    if ch == "]":
                        if bracket_depth > 0:
                            bracket_depth -= 1
                    else:
                        if ch == "<":
                            angle_depth += 1
                        else:
                            if ch == ">":
                                if angle_depth > 0:
                                    angle_depth -= 1
                            else:
                                if ch == "{":
                                    if paren_depth == 0  and  bracket_depth == 0  and  angle_depth == 0:
                                        open_index = index
                                        break
        index += 1
    if open_index < 0:
        variant_name_part = trim_text(substring(trimmed, dot_index + 1, len(trimmed)))
        if len(variant_name_part) == 0:
            return EnumLiteralParse(recognized=False, success=False, enum_name="", variant_name="", fields=[], diagnostics=diagnostics)
        paren_depth = 0
        bracket_depth = 0
        angle_depth = 0
        in_single = False
        in_double = False
        escape = False
        dot_seen = False
        scan_index = 0
        while True:
            if scan_index >= len(variant_name_part):
                break
            ch = variant_name_part[scan_index]
            if in_double:
                if escape:
                    escape = False
                else:
                    if ch == "\\":
                        escape = True
                    else:
                        if ch == "\"":
                            in_double = False
                scan_index += 1
                continue
            if in_single:
                if escape:
                    escape = False
                else:
                    if ch == "\\":
                        escape = True
                    else:
                        if ch == "'":
                            in_single = False
                scan_index += 1
                continue
            if ch == "\"":
                in_double = True
                scan_index += 1
                continue
            if ch == "'":
                in_single = True
                scan_index += 1
                continue
            if ch == "(":
                paren_depth += 1
            else:
                if ch == ")":
                    if paren_depth > 0:
                        paren_depth -= 1
                else:
                    if ch == "[":
                        bracket_depth += 1
                    else:
                        if ch == "]":
                            if bracket_depth > 0:
                                bracket_depth -= 1
                        else:
                            if ch == "<":
                                angle_depth += 1
                            else:
                                if ch == ">":
                                    if angle_depth > 0:
                                        angle_depth -= 1
                                else:
                                    if ch == ".":
                                        if paren_depth == 0  and  bracket_depth == 0  and  angle_depth == 0:
                                            dot_seen = True
                                            break
            scan_index += 1
        if dot_seen:
            return EnumLiteralParse(recognized=False, success=False, enum_name="", variant_name="", fields=[], diagnostics=diagnostics)
        if ends_with(variant_name_part, "()"):
            variant_name_part = trim_text(substring(variant_name_part, 0, len(variant_name_part) - 2))
        if len(variant_name_part) == 0:
            return EnumLiteralParse(recognized=False, success=False, enum_name="", variant_name="", fields=[], diagnostics=diagnostics)
        if not is_simple_identifier(variant_name_part):
            return EnumLiteralParse(recognized=False, success=False, enum_name="", variant_name="", fields=[], diagnostics=diagnostics)
        return EnumLiteralParse(recognized=True, success=True, enum_name=enum_name_part, variant_name=variant_name_part, fields=[], diagnostics=diagnostics)
    fatal = False
    close_index = find_matching_closing_brace(trimmed, open_index)
    if close_index < 0:
        diagnostics = append_string(diagnostics, "llvm lowering: enum literal missing closing `}`")
        fatal = True
    variant_name_part = trim_text(substring(trimmed, dot_index + 1, open_index))
    if len(variant_name_part) == 0:
        diagnostics = append_string(diagnostics, "llvm lowering: enum literal missing variant name")
        fatal = True
    fields = []
    if not fatal  and  close_index >= 0:
        body = substring(trimmed, open_index + 1, close_index)
        entries = split_array_elements(body)
        seen = []
        entry_index = 0
        while True:
            if entry_index >= len(entries):
                break
            entry = trim_text(entries[entry_index])
            entry_index += 1
            if len(entry) == 0:
                continue
            colon_index = find_top_level_colon(entry)
            if colon_index < 0:
                field_name = trim_text(entry)
                if len(field_name) == 0:
                    diagnostics = append_string(diagnostics, "llvm lowering: enum literal field missing name")
                    continue
                if string_array_contains(seen, field_name):
                    diagnostics = append_string(diagnostics, "llvm lowering: enum literal field `" + field_name + "` repeated")
                    continue
                seen = append_string(seen, field_name)
                fields = (fields) + ([StructLiteralField(name=field_name, value="")])
                continue
            field_name = trim_text(substring(entry, 0, colon_index))
            value_text = trim_text(substring(entry, colon_index + 1, len(entry)))
            if len(field_name) == 0:
                diagnostics = append_string(diagnostics, "llvm lowering: enum literal field missing name")
                continue
            if string_array_contains(seen, field_name):
                diagnostics = append_string(diagnostics, "llvm lowering: enum literal field `" + field_name + "` repeated")
                continue
            if len(value_text) == 0:
                diagnostics = append_string(diagnostics, "llvm lowering: enum literal field `" + field_name + "` missing value")
                continue
            seen = append_string(seen, field_name)
            fields = (fields) + ([StructLiteralField(name=field_name, value=value_text)])
    if not fatal  and  close_index >= 0:
        remainder = trim_text(substring(trimmed, close_index + 1, len(trimmed)))
        if len(remainder) > 0:
            diagnostics = append_string(diagnostics, "llvm lowering: enum literal trailing content `" + remainder + "`")
            fatal = True
    if fatal:
        fields = []
    return EnumLiteralParse(recognized=True, success=not fatal, enum_name=enum_name_part, variant_name=variant_name_part, fields=fields, diagnostics=diagnostics)

def lower_struct_literal(parse, bindings, locals, temp_index, lines, functions, context, expected_type):
    # effects: io
    diagnostics = parse.diagnostics
    current_lines = lines
    current_temp = temp_index
    collected_string_constants = empty_string_constant_set()
    info = resolve_struct_info_for_literal(context, parse.type_name)
    if info == None:
        if len(parse.type_name) > 0:
            diagnostics = append_string(diagnostics, "llvm lowering: struct literal references unknown struct `" + parse.type_name + "`")
        else:
            diagnostics = append_string(diagnostics, "llvm lowering: struct literal references unknown struct")
        return ExpressionResult(lines=current_lines, temp_index=current_temp, operand=None, diagnostics=diagnostics, string_constants=collected_string_constants)
    if len(info.fields) == 0:
        operand = LLVMOperand(llvm_type=info.llvm_name, value="zeroinitializer")
        return ExpressionResult(lines=current_lines, temp_index=current_temp, operand=operand, diagnostics=diagnostics, string_constants=collected_string_constants)
    used_names = []
    previous_value = ""
    field_index = 0
    while True:
        if field_index >= len(info.fields):
            break
        expected = info.fields[field_index]
        literal_index = -1
        literal_lookup_index = 0
        while True:
            if literal_lookup_index >= len(parse.fields):
                break
            if parse.fields[literal_lookup_index].name == expected.name:
                literal_index = literal_lookup_index
                break
            literal_lookup_index += 1
        value_operand = None
        if literal_index >= 0:
            literal_field = parse.fields[literal_index]
            lowered = lower_expression(literal_field.value, bindings, locals, current_temp, current_lines, functions, context, expected.llvm_type)
            diagnostics = (diagnostics) + (lowered.diagnostics)
            current_lines = lowered.lines
            current_temp = lowered.temp_index
            collected_string_constants = merge_string_constants(collected_string_constants, lowered.string_constants)
            if lowered.operand != None:
                coerced = coerce_operand_to_type(lowered.operand, expected.llvm_type, current_temp, current_lines)
                diagnostics = (diagnostics) + (coerced.diagnostics)
                current_lines = coerced.lines
                current_temp = coerced.temp_index
                if coerced.operand != None:
                    value_operand = coerced.operand
            if not string_array_contains(used_names, expected.name):
                used_names = append_string(used_names, expected.name)
        else:
            diagnostics = append_string(diagnostics, "llvm lowering: struct literal for `" + info.name + "` missing field `" + expected.name + "`")
        value_text = default_return_literal(expected.llvm_type)
        if value_operand != None:
            value_text = value_operand.value
        aggregate_source = "undef"
        if field_index > 0:
            aggregate_source = previous_value
        temp_name = format_temp_name(current_temp)
        current_lines = append_string(current_lines, "  " + temp_name + " = insertvalue " + info.llvm_name + " " + aggregate_source + ", " + expected.llvm_type + " " + value_text + ", " + number_to_string(field_index))
        current_temp += 1
        previous_value = temp_name
        field_index += 1
    extra_index = 0
    while True:
        if extra_index >= len(parse.fields):
            break
        literal_field = parse.fields[extra_index]
        if not string_array_contains(used_names, literal_field.name):
            diagnostics = append_string(diagnostics, "llvm lowering: struct literal for `" + info.name + "` provides unknown field `" + literal_field.name + "`")
        extra_index += 1
    if len(previous_value) == 0:
        operand = LLVMOperand(llvm_type=info.llvm_name, value="zeroinitializer")
        return ExpressionResult(lines=current_lines, temp_index=current_temp, operand=operand, diagnostics=diagnostics, string_constants=collected_string_constants)
    operand = LLVMOperand(llvm_type=info.llvm_name, value=previous_value)
    return ExpressionResult(lines=current_lines, temp_index=current_temp, operand=operand, diagnostics=diagnostics, string_constants=collected_string_constants)

def box_aggregate_operand(operand, expected_pointer_type, temp_index, lines, context):
    diagnostics = []
    current_lines = lines
    current_temp = temp_index
    allocation = lookup_allocation_info(context, operand.llvm_type)
    if allocation == None:
        diagnostics = append_string(diagnostics, "llvm lowering: unable to allocate heap storage for `" + operand.llvm_type + "` when assigning to `" + expected_pointer_type + "`")
        return HeapBoxResult(lines=current_lines, temp_index=current_temp, operand=None, diagnostics=diagnostics)
    if allocation.size <= 0:
        diagnostics = append_string(diagnostics, "llvm lowering: computed heap allocation size for `" + operand.llvm_type + "` is zero")
        return HeapBoxResult(lines=current_lines, temp_index=current_temp, operand=None, diagnostics=diagnostics)
    malloc_temp = format_temp_name(current_temp)
    current_temp += 1
    current_lines = append_string(current_lines, "  " + malloc_temp + " = call noalias i8* @malloc(i64 " + number_to_string(allocation.size) + ")")
    typed_ptr_temp = format_temp_name(current_temp)
    current_temp += 1
    current_lines = append_string(current_lines, "  " + typed_ptr_temp + " = bitcast i8* " + malloc_temp + " to " + operand.llvm_type + "*")
    current_lines = append_string(current_lines, "  store " + operand.llvm_type + " " + operand.value + ", " + operand.llvm_type + "* " + typed_ptr_temp)
    pointer_operand = LLVMOperand(llvm_type="i8*", value=malloc_temp)
    trimmed_expected = trim_text(expected_pointer_type)
    if len(trimmed_expected) > 0  and  trimmed_expected != "i8*":
        cast_temp = format_temp_name(current_temp)
        current_temp += 1
        current_lines = append_string(current_lines, "  " + cast_temp + " = bitcast i8* " + malloc_temp + " to " + trimmed_expected)
        pointer_operand = LLVMOperand(llvm_type=trimmed_expected, value=cast_temp)
    return HeapBoxResult(lines=current_lines, temp_index=current_temp, operand=pointer_operand, diagnostics=diagnostics)

def lower_enum_literal(parse, bindings, locals, temp_index, lines, functions, context, expected_type):
    diagnostics = parse.diagnostics
    current_lines = lines
    current_temp = temp_index
    collected_string_constants = empty_string_constant_set()
    enum_info = resolve_enum_info_for_literal(context, parse.enum_name)
    if enum_info == None:
        if len(parse.enum_name) > 0:
            diagnostics = append_string(diagnostics, "llvm lowering: enum literal references unknown enum `" + parse.enum_name + "`")
        else:
            diagnostics = append_string(diagnostics, "llvm lowering: enum literal references unknown enum")
        return ExpressionResult(lines=current_lines, temp_index=current_temp, operand=None, diagnostics=diagnostics, string_constants=collected_string_constants)
    variant_info = resolve_enum_variant_info(enum_info, parse.variant_name)
    if variant_info == None:
        diagnostics = append_string(diagnostics, "llvm lowering: enum `" + parse.enum_name + "` has no variant `" + parse.variant_name + "`")
        return ExpressionResult(lines=current_lines, temp_index=current_temp, operand=None, diagnostics=diagnostics, string_constants=collected_string_constants)
    tag_llvm_type = "i32"
    if enum_info.tag_type == "i8":
        tag_llvm_type = "i8"
    if enum_info.tag_type == "i16":
        tag_llvm_type = "i16"
    if enum_info.tag_type == "i32":
        tag_llvm_type = "i32"
    if enum_info.tag_type == "i64":
        tag_llvm_type = "i64"
    enum_value = "undef"
    enum_alloca = None
    if len(variant_info.fields) > 0:
        alloca_temp = format_temp_name(current_temp)
        current_temp += 1
        current_lines = append_string(current_lines, "  " + alloca_temp + " = alloca " + enum_info.llvm_name)
        enum_alloca = alloca_temp
        tag_ptr_temp = format_temp_name(current_temp)
        current_temp += 1
        current_lines = append_string(current_lines, "  " + tag_ptr_temp + " = getelementptr inbounds " + enum_info.llvm_name + ", " + enum_info.llvm_name + "* " + alloca_temp + ", i32 0, i32 0")
        current_lines = append_string(current_lines, "  store " + tag_llvm_type + " " + number_to_string(variant_info.tag) + ", " + tag_llvm_type + "* " + tag_ptr_temp)
    else:
        tag_temp = format_temp_name(current_temp)
        current_lines = append_string(current_lines, "  " + tag_temp + " = insertvalue " + enum_info.llvm_name + " " + enum_value + ", " + tag_llvm_type + " " + number_to_string(variant_info.tag) + ", 0")
        current_temp += 1
        enum_value = tag_temp
    if len(variant_info.fields) > 0:
        alloca_ptr = enum_alloca
        used_names = []
        field_index = 0
        while True:
            if field_index >= len(variant_info.fields):
                break
            expected = variant_info.fields[field_index]
            literal_index = -1
            literal_lookup_index = 0
            while True:
                if literal_lookup_index >= len(parse.fields):
                    break
                if parse.fields[literal_lookup_index].name == expected.name:
                    literal_index = literal_lookup_index
                    break
                literal_lookup_index += 1
            if literal_index >= 0:
                literal_field = parse.fields[literal_index]
                lowered = lower_expression(literal_field.value, bindings, locals, current_temp, current_lines, functions, context, expected.llvm_type)
                diagnostics = (diagnostics) + (lowered.diagnostics)
                current_lines = lowered.lines
                current_temp = lowered.temp_index
                if lowered.operand != None:
                    field_operand = lowered.operand
                    if ends_with_pointer_suffix(expected.llvm_type)  and  not ends_with_pointer_suffix(field_operand.llvm_type)  and  not is_string_pointer_type(expected.llvm_type):
                        boxed = box_aggregate_operand(field_operand, expected.llvm_type, current_temp, current_lines, context)
                        diagnostics = (diagnostics) + (boxed.diagnostics)
                        current_lines = boxed.lines
                        current_temp = boxed.temp_index
                        if boxed.operand != None:
                            field_operand = boxed.operand
                    coerced = coerce_operand_to_type(field_operand, expected.llvm_type, current_temp, current_lines)
                    diagnostics = (diagnostics) + (coerced.diagnostics)
                    current_lines = coerced.lines
                    current_temp = coerced.temp_index
                    if coerced.operand != None  and  alloca_ptr != None:
                        payload_ptr_temp = format_temp_name(current_temp)
                        current_temp += 1
                        current_lines = append_string(current_lines, "  " + payload_ptr_temp + " = getelementptr inbounds " + enum_info.llvm_name + ", " + enum_info.llvm_name + "* " + alloca_ptr + ", i32 0, i32 1")
                        byte_array_ptr_temp = format_temp_name(current_temp)
                        current_temp += 1
                        current_lines = append_string(current_lines, "  " + byte_array_ptr_temp + " = bitcast [" + number_to_string(enum_info.max_payload_size) + " x i8]* " + payload_ptr_temp + " to i8*")
                        field_absolute_offset = variant_info.fields[field_index].offset
                        field_offset_in_payload = field_absolute_offset - variant_info.offset
                        field_byte_ptr_temp = byte_array_ptr_temp
                        if field_offset_in_payload > 0:
                            offset_ptr_temp = format_temp_name(current_temp)
                            current_temp += 1
                            current_lines = append_string(current_lines, "  " + offset_ptr_temp + " = getelementptr inbounds i8, i8* " + byte_array_ptr_temp + ", i64 " + number_to_string(field_offset_in_payload))
                            field_byte_ptr_temp = offset_ptr_temp
                        field_ptr_temp = format_temp_name(current_temp)
                        current_temp += 1
                        current_lines = append_string(current_lines, "  " + field_ptr_temp + " = bitcast i8* " + field_byte_ptr_temp + " to " + expected.llvm_type + "*")
                        current_lines = append_string(current_lines, "  store " + expected.llvm_type + " " + coerced.operand.value + ", " + expected.llvm_type + "* " + field_ptr_temp)
                if not string_array_contains(used_names, expected.name):
                    used_names = append_string(used_names, expected.name)
            else:
                diagnostics = append_string(diagnostics, "llvm lowering: enum literal for `" + parse.enum_name + "." + parse.variant_name + "` missing field `" + expected.name + "`")
            field_index += 1
        extra_index = 0
        while True:
            if extra_index >= len(parse.fields):
                break
            literal_field = parse.fields[extra_index]
            if not string_array_contains(used_names, literal_field.name):
                diagnostics = append_string(diagnostics, "llvm lowering: enum literal for `" + parse.enum_name + "." + parse.variant_name + "` provides unknown field `" + literal_field.name + "`")
            extra_index += 1
        if alloca_ptr != None:
            load_temp = format_temp_name(current_temp)
            current_temp += 1
            current_lines = append_string(current_lines, "  " + load_temp + " = load " + enum_info.llvm_name + ", " + enum_info.llvm_name + "* " + alloca_ptr)
            enum_value = load_temp
    operand = LLVMOperand(llvm_type=enum_info.llvm_name, value=enum_value)
    return ExpressionResult(lines=current_lines, temp_index=current_temp, operand=operand, diagnostics=diagnostics, string_constants=collected_string_constants)

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
                struct_type = map_struct_type_annotation(context, struct_name)
                if len(struct_type) > 0:
                    llvm_type = struct_type + "*"
        if len(llvm_type) == 0:
            types = append_string(types, "double")
        else:
            types = append_string(types, llvm_type)
        index += 1
    return types

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

def strip_enclosing_parentheses(expression):
    trimmed = trim_text(expression)
    if len(trimmed) < 2:
        return trimmed
    if trimmed[0] != "("  or  trimmed[len(trimmed) - 1] != ")":
        return trimmed
    depth = 0
    index = 0
    while True:
        if index >= len(trimmed):
            break
        ch = char_at(trimmed, index)
        if ch == "(":
            depth += 1
        else:
            if ch == ")":
                depth -= 1
                if depth == 0:
                    if index == len(trimmed) - 1:
                        inner = substring(trimmed, 1, len(trimmed) - 1)
                        return strip_enclosing_parentheses(inner)
                    return trimmed
        index += 1
    return trimmed

def find_top_level_operator(expression, operators):
    paren_depth = 0
    bracket_depth = 0
    brace_depth = 0
    angle_depth = 0
    in_single = False
    in_double = False
    escape_next = False
    candidate_index = -1
    candidate_symbol = ""
    index = 0
    while True:
        if index >= len(expression):
            break
        ch = char_at(expression, index)
        if in_double:
            if escape_next:
                escape_next = False
                index += 1
                continue
            if ch == "\\":
                escape_next = True
                index += 1
                continue
            if ch == "\"":
                in_double = False
            index += 1
            continue
        if in_single:
            if escape_next:
                escape_next = False
                index += 1
                continue
            if ch == "\\":
                escape_next = True
                index += 1
                continue
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
            brace_depth += 1
            index += 1
            continue
        if ch == "}":
            if brace_depth > 0:
                brace_depth -= 1
            index += 1
            continue
        if ch == "<":
            angle_depth += 1
            index += 1
            continue
        if ch == ">":
            if angle_depth > 0:
                angle_depth -= 1
            index += 1
            continue
        if paren_depth == 0  and  bracket_depth == 0  and  brace_depth == 0  and  angle_depth == 0  and  contains_char(operators, ch):
            if ch == "-":
                if is_binary_minus(expression, index):
                    candidate_index = index
                    candidate_symbol = substring(expression, index, index + 1)
            else:
                if ch == "*":
                    if is_binary_star(expression, index):
                        candidate_index = index
                        candidate_symbol = substring(expression, index, index + 1)
                else:
                    candidate_index = index
                    candidate_symbol = substring(expression, index, index + 1)
        index += 1
    if candidate_index >= 0:
        return OperatorMatch(index=candidate_index, symbol=candidate_symbol, success=True)
    return OperatorMatch(index=-1, symbol="", success=False)

def find_comparison_operator(expression):
    depth = 0
    index = 0
    in_string = False
    escape_next = False
    while True:
        if index >= len(expression):
            break
        code = char_code_at_text(expression, index)
        if in_string:
            if escape_next:
                escape_next = False
                index += 1
                continue
            if code == char_code("\\"):
                escape_next = True
                index += 1
                continue
            if code == char_code("\""):
                in_string = False
            index += 1
            continue
        if code == char_code("\""):
            in_string = True
            index += 1
            continue
        if code == char_code("("):
            depth += 1
            index += 1
            continue
        if code == char_code(")"):
            if depth > 0:
                depth -= 1
            index += 1
            continue
        if depth > 0:
            index += 1
            continue
        if index + 1 < len(expression):
            next_code = char_code_at_text(expression, index + 1)
            if next_code == char_code("="):
                if code == char_code("="):
                    return OperatorMatch(index=index, symbol="==", success=True)
                if code == char_code("!"):
                    return OperatorMatch(index=index, symbol="!=", success=True)
                if code == char_code("<"):
                    return OperatorMatch(index=index, symbol="<=", success=True)
                if code == char_code(">"):
                    return OperatorMatch(index=index, symbol=">=", success=True)
        if code == char_code("<"):
            return OperatorMatch(index=index, symbol="<", success=True)
        if code == char_code(">"):
            return OperatorMatch(index=index, symbol=">", success=True)
        index += 1
    return OperatorMatch(index=-1, symbol="", success=False)

def find_logical_operator(expression):
    depth = 0
    index = 0
    in_string = False
    escape_next = False
    while True:
        if index + 1 >= len(expression):
            break
        ch = expression[index]
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
            depth += 1
            index += 1
            continue
        if ch == ")":
            if depth > 0:
                depth -= 1
            index += 1
            continue
        if depth == 0:
            two = substring(expression, index, index + 2)
            if two == "||":
                return OperatorMatch(index=index, symbol="||", success=True)
        index += 1
    depth = 0
    index = 0
    in_string = False
    escape_next = False
    while True:
        if index + 1 >= len(expression):
            break
        ch = expression[index]
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
            depth += 1
            index += 1
            continue
        if ch == ")":
            if depth > 0:
                depth -= 1
            index += 1
            continue
        if depth == 0:
            two = substring(expression, index, index + 2)
            if two == "&&":
                return OperatorMatch(index=index, symbol="&&", success=True)
        index += 1
    return OperatorMatch(index=-1, symbol="", success=False)

def contains_char(set, ch):
    if len(ch) == 0:
        return False
    target = char_code(ch)
    index = 0
    while True:
        if index >= len(set):
            break
        if char_code(char_at(set, index)) == target:
            return True
        index += 1
    return False

def is_binary_minus(expression, index):
    previous = find_previous_non_space_char(expression, index)
    next = find_next_non_space_char(expression, index)
    if previous == None:
        return False
    prev_char = previous
    if prev_char == "+"  or  prev_char == "-"  or  prev_char == "*"  or  prev_char == "/"  or  prev_char == "("  or  prev_char == ",":
        return False
    if next == None:
        return False
    next_char = next
    if next_char == "+"  or  next_char == "-"  or  next_char == "*"  or  next_char == "/"  or  next_char == ")"  or  next_char == ",":
        return False
    return True

def is_binary_star(expression, index):
    previous = find_previous_non_space_char(expression, index)
    next = find_next_non_space_char(expression, index)
    if previous == None:
        return False
    prev_char = previous
    if prev_char == "+"  or  prev_char == "-"  or  prev_char == "*"  or  prev_char == "/"  or  prev_char == "("  or  prev_char == ",":
        return False
    if next == None:
        return False
    next_char = next
    if next_char == "+"  or  next_char == "-"  or  next_char == "*"  or  next_char == "/"  or  next_char == ")"  or  next_char == ",":
        return False
    return True

def parse_raw_address_expression(text):
    trimmed = trim_text(text)
    diagnostics = []
    if len(trimmed) == 0:
        return RawAddressParseResult(recognized=False, success=False, target="", diagnostics=diagnostics)
    if not starts_with(trimmed, "&"):
        return RawAddressParseResult(recognized=False, success=False, target="", diagnostics=diagnostics)
    if starts_with(trimmed, "&raw"):
        remainder = trim_text(substring(trimmed, 4, len(trimmed)))
        if len(remainder) == 0:
            diagnostics = append_string(diagnostics, "llvm lowering: &raw expression missing target")
            return RawAddressParseResult(recognized=True, success=False, target="", diagnostics=diagnostics)
        return RawAddressParseResult(recognized=True, success=True, target=remainder, diagnostics=diagnostics)
    if starts_with(trimmed, "&"):
        after_amp = trim_text(substring(trimmed, 1, len(trimmed)))
        if starts_with(after_amp, "raw"):
            remainder = trim_text(substring(after_amp, 3, len(after_amp)))
            if len(remainder) == 0:
                diagnostics = append_string(diagnostics, "llvm lowering: &raw expression missing target")
                return RawAddressParseResult(recognized=True, success=False, target="", diagnostics=diagnostics)
            return RawAddressParseResult(recognized=True, success=True, target=remainder, diagnostics=diagnostics)
    return RawAddressParseResult(recognized=False, success=False, target="", diagnostics=diagnostics)

def lower_raw_address_expression(parse, bindings, locals, temp_index, lines):
    diagnostics = parse.diagnostics
    empty_constants = empty_string_constant_set()
    if not parse.success:
        return ExpressionResult(lines=lines, temp_index=temp_index, operand=None, diagnostics=diagnostics, string_constants=empty_constants)
    target = trim_text(parse.target)
    if not is_simple_identifier(target):
        diagnostics = append_string(diagnostics, "llvm lowering: &raw currently supports only simple identifiers (got `" + target + "`)")
        return ExpressionResult(lines=lines, temp_index=temp_index, operand=None, diagnostics=diagnostics, string_constants=empty_constants)
    local = find_local_binding(locals, target)
    if local != None:
        operand = LLVMOperand(llvm_type=local.llvm_type + "*", value=local.pointer)
        return ExpressionResult(lines=lines, temp_index=temp_index, operand=operand, diagnostics=diagnostics, string_constants=empty_constants)
    param = find_parameter_binding(bindings, target)
    if param != None:
        diagnostics = append_string(diagnostics, "llvm lowering: cannot take raw address of parameter `" + target + "` yet")
        return ExpressionResult(lines=lines, temp_index=temp_index, operand=None, diagnostics=diagnostics, string_constants=empty_constants)
    diagnostics = append_string(diagnostics, "llvm lowering: &raw target `" + target + "` is not a local")
    return ExpressionResult(lines=lines, temp_index=temp_index, operand=None, diagnostics=diagnostics, string_constants=empty_constants)

def parse_cast_expression(text):
    trimmed = trim_text(text)
    diagnostics = []
    if len(trimmed) == 0:
        return CastParseResult(recognized=False, success=False, value="", type_annotation="", diagnostics=diagnostics)
    paren_depth = 0
    bracket_depth = 0
    brace_depth = 0
    angle_depth = 0
    in_single = False
    in_double = False
    escape_next = False
    index = 0
    match_index = -1
    while True:
        if index >= len(trimmed):
            break
        ch = char_at(trimmed, index)
        if in_double:
            if escape_next:
                escape_next = False
                index += 1
                continue
            if ch == "\\":
                escape_next = True
                index += 1
                continue
            if ch == "\"":
                in_double = False
            index += 1
            continue
        if in_single:
            if escape_next:
                escape_next = False
                index += 1
                continue
            if ch == "\\":
                escape_next = True
                index += 1
                continue
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
            brace_depth += 1
            index += 1
            continue
        if ch == "}":
            if brace_depth > 0:
                brace_depth -= 1
            index += 1
            continue
        if ch == "<":
            angle_depth += 1
            index += 1
            continue
        if ch == ">":
            if angle_depth > 0:
                angle_depth -= 1
            index += 1
            continue
        if paren_depth == 0  and  bracket_depth == 0  and  brace_depth == 0  and  angle_depth == 0:
            if index + 4 <= len(trimmed):
                window = substring(trimmed, index, index + 4)
                if window == " as ":
                    match_index = index
        index += 1
    if match_index < 0:
        return CastParseResult(recognized=False, success=False, value="", type_annotation="", diagnostics=diagnostics)
    value = trim_text(substring(trimmed, 0, match_index))
    annotation = trim_text(substring(trimmed, match_index + 4, len(trimmed)))
    if len(value) == 0  or  len(annotation) == 0:
        diagnostics = append_string(diagnostics, "llvm lowering: malformed cast expression `" + text + "`")
        return CastParseResult(recognized=True, success=False, value=value, type_annotation=annotation, diagnostics=diagnostics)
    return CastParseResult(recognized=True, success=True, value=value, type_annotation=annotation, diagnostics=diagnostics)

def lower_cast_expression(parse, bindings, locals, temp_index, lines, functions, context):
    diagnostics = parse.diagnostics
    empty_constants = empty_string_constant_set()
    if not parse.success:
        return ExpressionResult(lines=lines, temp_index=temp_index, operand=None, diagnostics=diagnostics, string_constants=empty_constants)
    target_type = map_type_annotation(parse.type_annotation)
    if len(target_type) == 0:
        diagnostics = append_string(diagnostics, "llvm lowering: unsupported cast target type `" + parse.type_annotation + "`")
        return ExpressionResult(lines=lines, temp_index=temp_index, operand=None, diagnostics=diagnostics, string_constants=empty_constants)
    lowered = lower_expression(parse.value, bindings, locals, temp_index, lines, functions, context, "")
    diagnostics = (diagnostics) + (lowered.diagnostics)
    if lowered.operand == None:
        return ExpressionResult(lines=lowered.lines, temp_index=lowered.temp_index, operand=None, diagnostics=diagnostics, string_constants=lowered.string_constants)
    operand = lowered.operand
    if operand.llvm_type == target_type:
        return ExpressionResult(lines=lowered.lines, temp_index=lowered.temp_index, operand=operand, diagnostics=diagnostics, string_constants=lowered.string_constants)
    current_lines = lowered.lines
    current_temp = lowered.temp_index
    cast_name = format_temp_name(current_temp)
    current_temp += 1
    if ends_with_pointer_suffix(operand.llvm_type)  and  ends_with_pointer_suffix(target_type):
        current_lines = append_string(current_lines, "  " + cast_name + " = bitcast " + operand.llvm_type + " " + operand.value + " to " + target_type)
        casted = LLVMOperand(llvm_type=target_type, value=cast_name)
        return ExpressionResult(lines=current_lines, temp_index=current_temp, operand=casted, diagnostics=diagnostics, string_constants=lowered.string_constants)
    if not ends_with_pointer_suffix(operand.llvm_type)  and  ends_with_pointer_suffix(target_type)  and  starts_with(operand.llvm_type, "i"):
        current_lines = append_string(current_lines, "  " + cast_name + " = inttoptr " + operand.llvm_type + " " + operand.value + " to " + target_type)
        casted = LLVMOperand(llvm_type=target_type, value=cast_name)
        return ExpressionResult(lines=current_lines, temp_index=current_temp, operand=casted, diagnostics=diagnostics, string_constants=lowered.string_constants)
    if ends_with_pointer_suffix(operand.llvm_type)  and  not ends_with_pointer_suffix(target_type)  and  starts_with(target_type, "i"):
        current_lines = append_string(current_lines, "  " + cast_name + " = ptrtoint " + operand.llvm_type + " " + operand.value + " to " + target_type)
        casted = LLVMOperand(llvm_type=target_type, value=cast_name)
        return ExpressionResult(lines=current_lines, temp_index=current_temp, operand=casted, diagnostics=diagnostics, string_constants=lowered.string_constants)
    diagnostics = append_string(diagnostics, "llvm lowering: unsupported cast from `" + operand.llvm_type + "` to `" + target_type + "`")
    return ExpressionResult(lines=current_lines, temp_index=current_temp, operand=None, diagnostics=diagnostics, string_constants=lowered.string_constants)

def find_previous_non_space_char(value, index):
    position = index
    while True:
        if position <= 0:
            break
        position -= 1
        ch = char_at(value, position)
        if not is_trim_char(ch):
            return ch
    return None

def find_next_non_space_char(value, index):
    position = index + 1
    while True:
        if position >= len(value):
            break
        ch = char_at(value, position)
        if not is_trim_char(ch):
            return ch
        position += 1
    return None

def find_call_site(expression):
    depth = 0
    index = 0
    while True:
        if index >= len(expression):
            break
        ch = char_at(expression, index)
        if ch == "(":
            if depth == 0:
                return index
            depth += 1
        else:
            if ch == ")":
                if depth > 0:
                    depth -= 1
        index += 1
    return -1

def split_call_arguments(text):
    trimmed = trim_text(text)
    if len(trimmed) == 0:
        return []
    entries = []
    current = ""
    paren_depth = 0
    bracket_depth = 0
    brace_depth = 0
    in_single = False
    in_double = False
    escape = False
    index = 0
    while True:
        if index >= len(text):
            break
        ch = char_at(text, index)
        if in_double:
            current = current + ch
            if escape:
                escape = False
            else:
                if ch == "\\":
                    escape = True
                else:
                    if ch == "\"":
                        in_double = False
            index += 1
            continue
        if in_single:
            current = current + ch
            if escape:
                escape = False
            else:
                if ch == "\\":
                    escape = True
                else:
                    if ch == "'":
                        in_single = False
            index += 1
            continue
        if ch == "\"":
            in_double = True
            current = current + ch
            index += 1
            continue
        if ch == "'":
            in_single = True
            current = current + ch
            index += 1
            continue
        if ch == "(":
            paren_depth += 1
            current = current + ch
        else:
            if ch == ")":
                if paren_depth > 0:
                    paren_depth -= 1
                current = current + ch
            else:
                if ch == "[":
                    bracket_depth += 1
                    current = current + ch
                else:
                    if ch == "]":
                        if bracket_depth > 0:
                            bracket_depth -= 1
                        current = current + ch
                    else:
                        if ch == "{":
                            brace_depth += 1
                            current = current + ch
                        else:
                            if ch == "}":
                                if brace_depth > 0:
                                    brace_depth -= 1
                                current = current + ch
                            else:
                                if ch == ","  and  paren_depth == 0  and  bracket_depth == 0  and  brace_depth == 0:
                                    entries = append_string(entries, trim_text(current))
                                    current = ""
                                else:
                                    current = current + ch
        index += 1
    entries = append_string(entries, trim_text(current))
    return entries

def parse_array_literal_metadata(entries, context):
    if len(entries) == 0:
        return ArrayLiteralMetadata(element_type="", start_index=0)
    first = trim_text(entries[0])
    if len(first) < 9:
        return ArrayLiteralMetadata(element_type="", start_index=0)
    prefix = substring(first, 0, 9)
    if prefix != "#element:":
        return ArrayLiteralMetadata(element_type="", start_index=0)
    annotation = trim_text(substring(first, 9, len(first)))
    if len(annotation) == 0:
        return ArrayLiteralMetadata(element_type="", start_index=1)
    mapped = map_metadata_annotation(context, annotation)
    return ArrayLiteralMetadata(element_type=mapped, start_index=1)

def map_metadata_annotation(context, annotation):
    trimmed = trim_text(annotation)
    if len(trimmed) == 0:
        return ""
    primitive = map_primitive_type(context, trimmed)
    if len(primitive) > 0:
        return primitive
    if len(trimmed) > 2:
        suffix = substring(trimmed, len(trimmed) - 2, len(trimmed))
        if suffix == "[]":
            inner_annotation = trim_text(substring(trimmed, 0, len(trimmed) - 2))
            inner_type = map_metadata_annotation(context, inner_annotation)
            if len(inner_type) == 0:
                return ""
            struct_type = array_struct_type_for_element(inner_type)
            return struct_type + "*"
    return ""

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

def format_typed_operand(operand):
    return operand.llvm_type + " " + operand.value

def find_top_level_range_separator(value):
    paren_depth = 0
    bracket_depth = 0
    brace_depth = 0
    index = 0
    while True:
        if index >= len(value):
            break
        ch = value[index]
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
            brace_depth += 1
            index += 1
            continue
        if ch == "}":
            if brace_depth > 0:
                brace_depth -= 1
            index += 1
            continue
        if ch == ".":
            if index + 1 < len(value):
                if value[index + 1] == ".":
                    if paren_depth == 0  and  bracket_depth == 0  and  brace_depth == 0:
                        return index
        index += 1
    return -1

def find_top_level_range_separator_from(value, start_index):
    paren_depth = 0
    bracket_depth = 0
    brace_depth = 0
    index = 0
    while True:
        if index >= len(value):
            break
        ch = value[index]
        if ch == "(":
            paren_depth += 1
        else:
            if ch == ")":
                if paren_depth > 0:
                    paren_depth -= 1
            else:
                if ch == "[":
                    bracket_depth += 1
                else:
                    if ch == "]":
                        if bracket_depth > 0:
                            bracket_depth -= 1
                    else:
                        if ch == "{":
                            brace_depth += 1
                        else:
                            if ch == "}":
                                if brace_depth > 0:
                                    brace_depth -= 1
        if index >= start_index:
            if ch == ".":
                if index + 1 < len(value):
                    if value[index + 1] == ".":
                        if paren_depth == 0  and  bracket_depth == 0  and  brace_depth == 0:
                            return index
        index += 1
    return -1

def find_member_access_separator(value):
    paren_depth = 0
    bracket_depth = 0
    brace_depth = 0
    in_single = False
    in_double = False
    escape = False
    index = 0
    last_index = -1
    while True:
        if index >= len(value):
            break
        ch = char_at(value, index)
        if in_single:
            if escape:
                escape = False
            else:
                if ch == "\\":
                    escape = True
                else:
                    if ch == "'":
                        in_single = False
            index += 1
            continue
        if in_double:
            if escape:
                escape = False
            else:
                if ch == "\\":
                    escape = True
                else:
                    if ch == "\"":
                        in_double = False
            index += 1
            continue
        if ch == "'":
            in_single = True
            index += 1
            continue
        if ch == "\"":
            in_double = True
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
            brace_depth += 1
            index += 1
            continue
        if ch == "}":
            if brace_depth > 0:
                brace_depth -= 1
            index += 1
            continue
        if paren_depth == 0  and  bracket_depth == 0  and  brace_depth == 0:
            if ch == ".":
                if index > 0:
                    previous = char_at(value, index - 1)
                    if previous == ".":
                        index += 1
                        continue
                    if is_digit_char(previous):
                        if index + 1 < len(value):
                            next_digit = char_at(value, index + 1)
                            if is_digit_char(next_digit):
                                index += 1
                                continue
                if index + 1 < len(value):
                    next_char = char_at(value, index + 1)
                    if next_char == ".":
                        index += 1
                        continue
                last_index = index
        index += 1
    return last_index

def parse_member_access(expression):
    trimmed = trim_text(expression)
    if len(trimmed) == 0:
        return MemberAccessParse(success=False, base="", field="")
    separator = find_member_access_separator(trimmed)
    if separator < 0:
        return MemberAccessParse(success=False, base="", field="")
    base = trim_text(substring(trimmed, 0, separator))
    field = trim_text(substring(trimmed, separator + 1, len(trimmed)))
    if len(base) == 0  or  len(field) == 0:
        return MemberAccessParse(success=False, base="", field="")
    if not is_simple_identifier(field):
        return MemberAccessParse(success=False, base="", field="")
    return MemberAccessParse(success=True, base=base, field=field)

def parse_index_expression(expression):
    trimmed = trim_text(expression)
    if len(trimmed) == 0:
        return IndexExpressionParse(success=False, base="", index="")
    bracket_depth = 0
    index_position = -1
    i = len(trimmed) - 1
    if char_code_at_text(trimmed, len(trimmed) - 1) != char_code("]"):
        return IndexExpressionParse(success=False, base="", index="")
    bracket_depth = 1
    i = len(trimmed) - 2
    while True:
        if i < 0:
            break
        ch = char_at(trimmed, i)
        if ch == "]":
            bracket_depth += 1
        if ch == "[":
            bracket_depth -= 1
            if bracket_depth == 0:
                index_position = i
                break
        i -= 1
    if index_position < 0:
        return IndexExpressionParse(success=False, base="", index="")
    base = trim_text(substring(trimmed, 0, index_position))
    index = trim_text(substring(trimmed, index_position + 1, len(trimmed) - 1))
    if len(base) == 0  or  len(index) == 0:
        return IndexExpressionParse(success=False, base="", index="")
    return IndexExpressionParse(success=True, base=base, index=index)

def parse_range_iterable(iterable):
    trimmed = trim_text(iterable)
    diagnostics = []
    if len(trimmed) == 0:
        diagnostics = append_string(diagnostics, "llvm lowering: `.for` iterable expression is empty")
        return RangeIterableParse(success=False, start="", end="", stride="", diagnostics=diagnostics)
    first_separator = find_top_level_range_separator(trimmed)
    has_stride = False
    stride_text = ""
    if first_separator < 0:
        diagnostics = append_string(diagnostics, "llvm lowering: `.for` iterable must use `start..end` range syntax")
        return RangeIterableParse(success=False, start="", end="", stride="", diagnostics=diagnostics)
    second_separator = find_top_level_range_separator_from(trimmed, first_separator + 2)
    start_text = trim_text(substring(trimmed, 0, first_separator))
    end_text = trim_text(substring(trimmed, first_separator + 2, len(trimmed)))
    if second_separator >= 0:
        end_text = trim_text(substring(trimmed, first_separator + 2, second_separator))
        stride_text = trim_text(substring(trimmed, second_separator + 2, len(trimmed)))
        has_stride = len(stride_text) > 0
    if len(start_text) == 0:
        diagnostics = append_string(diagnostics, "llvm lowering: `.for` range missing start expression")
    if len(end_text) == 0:
        diagnostics = append_string(diagnostics, "llvm lowering: `.for` range missing end expression")
    if has_stride  and  len(stride_text) == 0:
        diagnostics = append_string(diagnostics, "llvm lowering: `.for` range missing stride expression")
    success = len(start_text) > 0  and  len(end_text) > 0  and  (not has_stride  or  len(stride_text) > 0)
    return RangeIterableParse(success=success, start=start_text, end=end_text, stride=stride_text, diagnostics=diagnostics)

def find_local_binding(locals, name):
    index = len(locals)
    while True:
        if index <= 0:
            break
        index -= 1
        entry = locals[index]
        if entry.name == name:
            return entry
    return None

def infer_borrow_base_scope(base, locals, bindings, function_name):
    local = find_local_binding(locals, base)
    if local != None:
        return ScopeMetadata(scope_id=local.scope_id, scope_depth=local.scope_depth)
    parameter = find_parameter_binding(bindings, base)
    if parameter != None:
        return ScopeMetadata(scope_id=format_root_scope_id(function_name), scope_depth=0)
    return ScopeMetadata(scope_id=format_root_scope_id(function_name), scope_depth=0)

def append_lifetime_region(values, value):
    return (values) + ([value])

def append_lifetime_release_event(events, event):
    return (events) + ([event])

def mark_lifetime_region_released(regions, region_id, scope_id, scope_depth):
    result = []
    index = 0
    while True:
        if index >= len(regions):
            break
        entry = regions[index]
        if entry.id == region_id:
            updated = LifetimeRegionMetadata(id=entry.id, binding=entry.binding, base=entry.base, mutable=entry.mutable, start_span=entry.start_span, scope_id=entry.scope_id, scope_depth=entry.scope_depth, base_scope_id=entry.base_scope_id, base_scope_depth=entry.base_scope_depth, end_scope_id=scope_id, end_scope_depth=scope_depth, released=True)
            result = append_lifetime_region(result, updated)
        else:
            result = append_lifetime_region(result, entry)
        index += 1
    return result

def apply_lifetime_release_events(regions, releases):
    if len(releases) == 0:
        return regions
    current_regions = regions
    index = 0
    while True:
        if index >= len(releases):
            break
        release = releases[index]
        current_regions = mark_lifetime_region_released(current_regions, release.region_id, release.scope_id, release.scope_depth)
        index += 1
    return current_regions

def make_lifetime_region_metadata(id, binding, ownership, scope_id, scope_depth, base_scope_id, base_scope_depth):
    return LifetimeRegionMetadata(id=id, binding=binding, base=ownership.base, mutable=ownership.mutable, start_span=ownership.span, scope_id=scope_id, scope_depth=scope_depth, base_scope_id=base_scope_id, base_scope_depth=base_scope_depth, end_scope_id="", end_scope_depth=0, released=False)

def format_root_scope_id(function_name):
    sanitized = sanitize_symbol(function_name)
    if len(sanitized) == 0:
        sanitized = "fn"
    return "fn:" + sanitized

def make_child_scope_id(parent, child):
    sanitized_child = sanitize_symbol(child)
    if len(sanitized_child) == 0:
        sanitized_child = "scope"
    if len(parent) == 0:
        return sanitized_child
    return parent + "::" + sanitized_child

def is_scope_descendant(parent, candidate):
    if len(parent) == 0:
        return True
    if len(candidate) == 0:
        return False
    if candidate == parent:
        return True
    prefix = parent + "::"
    if len(candidate) <= len(prefix):
        return False
    return starts_with(candidate, prefix)

def append_local_binding(values, value):
    return (values) + ([value])

def append_llvm_operand(values, value):
    return (values) + ([value])

def append_struct_literal_field(values, value):
    return (values) + ([value])

def append_native_struct(values, value):
    return (values) + ([value])

def append_native_enum(values, value):
    return (values) + ([value])

def replace_llvm_operand(values, index, value):
    result = []
    current = 0
    while True:
        if current >= len(values):
            break
        if current == index:
            result = append_llvm_operand(result, value)
        else:
            result = append_llvm_operand(result, values[current])
        current += 1
    return result

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

def try_lower_interpolated_string_literal(literal, bindings, locals, temp_index, lines, functions, context):
    content = unescape_string_literal(literal)
    if find_substring_from(content, "{{", 0) < 0:
        return None
    if find_substring_from(content, "}}", 0) < 0:
        return None
    parsed = parse_interpolated_template(content)
    if not parsed.success:
        return None
    if len(parsed.expressions) == 0:
        return None
    if len(parsed.parts) != len(parsed.expressions) + 1:
        return None
    current_lines = lines
    current_temp = temp_index
    diagnostics = []
    collected_string_constants = empty_string_constant_set()
    first_literal = encode_string_literal_for_sailfin(parsed.parts[0])
    first = lower_string_literal(first_literal, current_temp, current_lines)
    current_lines = first.lines
    current_temp = first.temp_index
    if first.operand == None:
        return ExpressionResult(lines=current_lines, temp_index=current_temp, operand=None, diagnostics=diagnostics, string_constants=collected_string_constants)
    current_operand = first.operand
    index = 0
    while True:
        if index >= len(parsed.expressions):
            break
        expr_text = parsed.expressions[index]
        lowered_expr = lower_expression(expr_text, bindings, locals, current_temp, current_lines, functions, context, "i8*")
        diagnostics = (diagnostics) + (lowered_expr.diagnostics)
        current_lines = lowered_expr.lines
        current_temp = lowered_expr.temp_index
        collected_string_constants = merge_string_constants(collected_string_constants, lowered_expr.string_constants)
        if lowered_expr.operand == None:
            diagnostics = append_string(diagnostics, "llvm lowering: unable to lower interpolated expression `" + expr_text + "`")
            return ExpressionResult(lines=current_lines, temp_index=current_temp, operand=None, diagnostics=diagnostics, string_constants=collected_string_constants)
        coerced = coerce_operand_to_string(lowered_expr.operand, current_temp, current_lines)
        diagnostics = (diagnostics) + (coerced.diagnostics)
        current_lines = coerced.lines
        current_temp = coerced.temp_index
        collected_string_constants = merge_string_constants(collected_string_constants, coerced.string_constants)
        if coerced.operand == None:
            diagnostics = append_string(diagnostics, "llvm lowering: unable to stringify interpolated expression `" + expr_text + "`")
            return ExpressionResult(lines=current_lines, temp_index=current_temp, operand=None, diagnostics=diagnostics, string_constants=collected_string_constants)
        concat1 = emit_string_concat(current_operand, coerced.operand, current_temp, current_lines)
        diagnostics = (diagnostics) + (concat1.diagnostics)
        current_lines = concat1.lines
        current_temp = concat1.temp_index
        if concat1.operand == None:
            return ExpressionResult(lines=current_lines, temp_index=current_temp, operand=None, diagnostics=diagnostics, string_constants=collected_string_constants)
        current_operand = concat1.operand
        part_literal = encode_string_literal_for_sailfin(parsed.parts[index + 1])
        part_value = lower_string_literal(part_literal, current_temp, current_lines)
        current_lines = part_value.lines
        current_temp = part_value.temp_index
        if part_value.operand == None:
            return ExpressionResult(lines=current_lines, temp_index=current_temp, operand=None, diagnostics=diagnostics, string_constants=collected_string_constants)
        concat2 = emit_string_concat(current_operand, part_value.operand, current_temp, current_lines)
        diagnostics = (diagnostics) + (concat2.diagnostics)
        current_lines = concat2.lines
        current_temp = concat2.temp_index
        if concat2.operand == None:
            return ExpressionResult(lines=current_lines, temp_index=current_temp, operand=None, diagnostics=diagnostics, string_constants=collected_string_constants)
        current_operand = concat2.operand
        index += 1
    return ExpressionResult(lines=current_lines, temp_index=current_temp, operand=current_operand, diagnostics=diagnostics, string_constants=collected_string_constants)

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

def append_match_arm_mutations(list, arm):
    list.append(arm)
    return list

def merge_parameter_bindings(first, second):
    result = []
    index = 0
    while True:
        if index >= len(first):
            break
        primary = first[index]
        consumed_flag = primary.consumed
        counterpart = find_parameter_binding(second, primary.name)
        if counterpart != None:
            consumed_flag = consumed_flag  or  counterpart.consumed
        result = append_parameter_binding(result, ParameterBinding(name=primary.name, llvm_name=primary.llvm_name, llvm_type=primary.llvm_type, type_annotation=primary.type_annotation, consumed=consumed_flag, span=primary.span))
        index += 1
    return result

def append_parameter_binding(bindings, binding):
    return (bindings) + ([binding])

def empty_string_constant_set():
    return []

def string_constant_singleton(constant):
    return [constant]

def clone_string_constants(constants):
    copy = []
    index = 0
    while True:
        if index >= len(constants):
            break
        copy = append_string_constant(copy, constants[index])
        index += 1
    return copy

def append_string_constant(set, constant):
    return (set) + ([constant])

def merge_string_constants(existing, new_constants):
    result = existing
    index = 0
    while True:
        if index >= len(new_constants):
            break
        candidate = new_constants[index]
        found_by_name = find_string_constant_by_name(result, candidate.name)
        if found_by_name == None:
            result = append_string_constant(result, candidate)
        index += 1
    return result

def find_string_constant(constants, content):
    index = 0
    while True:
        if index >= len(constants):
            break
        candidate = constants[index]
        if candidate.content == content:
            return candidate
        index += 1
    return None

def find_string_constant_by_name(constants, name):
    index = 0
    while True:
        if index >= len(constants):
            break
        candidate = constants[index]
        if candidate.name == name:
            return candidate
        index += 1
    return None

def render_string_constants(constants):
    lines = []
    index = 0
    while True:
        if index >= len(constants):
            break
        constant = constants[index]
        escaped = escape_string_for_llvm(constant.content)
        length_str = number_to_string(constant.byte_count + 1)
        declaration = constant.name + " = private unnamed_addr constant [" + length_str + " x i8] c\"" + escaped + "\\00\""
        lines = append_string(lines, declaration)
        index += 1
    return lines

def escape_string_for_llvm(content):
    result = ""
    index = 0
    while True:
        if index >= len(content):
            break
        ch = content[index]
        if ch == "\n":
            result = result + "\\0A"
        else:
            if ch == "\r":
                result = result + "\\0D"
            else:
                if ch == "\t":
                    result = result + "\\09"
                else:
                    if ch == "\"":
                        result = result + "\\22"
                    else:
                        if ch == "\\":
                            result = result + "\\5C"
                        else:
                            result = result + ch
        index += 1
    return result

__all__ = ["parse_union_payload_types", "is_union_llvm_type", "extract_simple_identifier", "unescape_string_literal", "make_string_constant_name", "make_string_constant_name_for_module"]
