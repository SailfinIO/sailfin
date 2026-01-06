import asyncio
from runtime import runtime_support as runtime

from ...emit_native import NativeModule
from ...native_ir import select_text_artifact, select_layout_manifest_artifact, parse_native_artifact, parse_layout_manifest, NativeFunction, NativeInstruction, NativeParameter, NativeInterface, NativeInterfaceSignature, NativeStruct, NativeEnum, NativeEnumLayout, NativeEnumVariant, NativeEnumVariantLayout, NativeSourceSpan, NativeImport, LayoutManifest, NativeBinding
from ...string_utils import substring, char_code, char_at, find_char, find_last_index_of_char, index_of as str_index_of
from compiler.build.llvm.expression_lowering_stage2.core import lower_expression, analyze_value_ownership, detect_borrow_conflicts, format_suspension_location
from compiler.build.llvm.expression_lowering_stage2.core_operands import coerce_operand_to_type
from compiler.build.llvm.expression_lowering_stage2.core_parse import parse_member_access, parse_index_expression
from compiler.build.llvm.expression_lowering_stage2.core_scopes import find_local_binding, infer_borrow_base_scope, append_lifetime_region, append_lifetime_release_event, make_lifetime_region_metadata
from ..types import TypeContext, StructTypeInfo, StructFieldInfo, EnumTypeInfo, EnumVariantInfo, InterfaceTypeInfo, VTableInfo, VTableEntry, LocalBinding, ParameterBinding, OwnershipInfo, OwnershipConsumption, OwnershipAnalysis, LifetimeRegionMetadata, LifetimeReleaseEvent, ScopeMetadata, LLVMOperand, ExpressionResult, CoercionResult, BlockLoweringResult, LoweredLLVMFunction, LoweredLLVMResult, LetLoweringResult, ModuleGlobalLoweringResult, OperatorMatch, BorrowParseResult, BorrowArgumentParse, TernaryParseResult, AssignmentParseResult, InlineLetParseResult, MemberAccessParse, IndexExpressionParse, RawAddressParseResult, CastParseResult, TraitMetadata, TraitDescriptor, TraitImplementationDescriptor, FunctionEffectEntry, RuntimeHelperDescriptor, CapabilityManifest, CapabilityManifestEntry, StringConstant, LocalMutation, LoopContext, ImportedModuleContext, LayoutManifestApplication, TypeContextBuild, FunctionCallEntry, StringPointerResult, InterpolatedTemplateParse, BodyResult, ParameterPreparation, ArrayLiteralMetadata, TypeAllocationInfo, HeapBoxResult, StructLiteralField, StructLiteralParse, EnumLiteralParse, ExpressionStatementResult, BlockLabelResult, IfStructure, LoopStructure, TryStructure, RangeIterableParse, MatchCaseStructure, MatchStructure, MatchFieldBinding, MatchStructFieldBinding, MatchCaseCondition, ConditionConversion, ComparisonEmission, BinaryAlignmentResult, ThrowLoweringResult, PhiMergeResult, PhiInputEntry, MutationMaterializationResult, PhiStoreEntry, MatchArmMutations, LoadLocalResult
from ..utils import trim_text, starts_with, ends_with, char_at as utils_char_at, append_string, join_with_separator, string_array_contains, sanitize_symbol, number_to_string, index_of, is_identifier_start_char, is_identifier_part_char, contains_text, matches_keyword, find_parameter_binding as utils_find_parameter_binding, merge_parameter_bindings, append_parameter_binding
from ..strings import empty_string_constant_set, append_string_constant, merge_string_constants, find_string_constant, render_string_constants, escape_string_for_llvm
from ..effects import collect_direct_function_effects, collect_function_call_graph, propagate_function_effects, build_capability_manifest, collect_function_borrow_effects, collect_expression_borrow_effects, collect_runtime_helper_targets
from ..runtime_helpers import runtime_helper_descriptors, find_runtime_helper, append_runtime_helper
from ..type_mapping import map_type_annotation, map_struct_field_annotation, ends_with_pointer_suffix, strip_pointer_suffix, layout_annotation_requires_pointer, layout_annotation_base_type, annotation_is_array, layout_annotation_represents_user_value, is_copy_type, array_struct_type_for_element
from ..rendering import render_test_harness_main, collect_exported_symbol_names, should_internalize_function, render_struct_type_definitions, render_enum_type_definitions, render_interface_type_definitions, render_vtable_type_definitions, render_vtable_constants, find_function_by_name
from ..type_context import fixup_enum_layouts, find_struct_info_by_name, find_interface_info_by_name, find_vtable_for_struct_interface, find_struct_info_by_llvm_type, find_struct_field_index, find_struct_field_info, find_enum_info_by_llvm_type, resolve_struct_info_from_llvm_type, lookup_allocation_info, resolve_struct_info_for_literal, resolve_struct_info_for_method_target, resolve_interface_info_for_method_target, resolve_enum_info_for_literal, resolve_enum_variant_info, find_variant_field_info
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

def lower_expression_statement(function_name, instruction, expression, bindings, locals, temp_index, lines, next_region_id, scope_id, scope_depth, functions, context, current_label):
    suspension_span = None
    if instruction.span != None:
        suspension_span = instruction.span
    diagnostics = detect_suspension_conflicts(expression, locals, bindings, function_name, suspension_span)
    current_lines = lines
    current_temp = temp_index
    current_locals = locals
    current_bindings = bindings
    lifetime_regions = []
    lifetime_releases = []
    current_next_region = next_region_id
    mutations = []
    string_constants = empty_string_constant_set()
    parsed_assignment = parse_assignment_expression(expression)
    if parsed_assignment.success:
        trimmed_target = trim_text(parsed_assignment.target)
        if starts_with(trimmed_target, "*"):
            effective_value = parsed_assignment.value
            if len(parsed_assignment.operator) > 0:
                effective_value = trimmed_target + " " + parsed_assignment.operator + " " + parsed_assignment.value
            lowered_value = lower_expression(effective_value, current_bindings, current_locals, current_temp, current_lines, functions, context, "")
            diagnostics = (diagnostics) + (lowered_value.diagnostics)
            string_constants = lowered_value.string_constants
            current_lines = lowered_value.lines
            current_temp = lowered_value.temp_index
            if lowered_value.operand == None:
                diagnostics = append_string(diagnostics, "llvm lowering: failed to lower assignment value for deref target `" + parsed_assignment.target + "`")
                return ExpressionStatementResult(lines=current_lines, temp_index=current_temp, locals=current_locals, bindings=current_bindings, diagnostics=diagnostics, lifetime_regions=lifetime_regions, lifetime_releases=lifetime_releases, next_region_id=current_next_region, mutations=mutations, string_constants=string_constants)
            pointer_text = trim_text(substring(trimmed_target, 1, len(trimmed_target)))
            if len(pointer_text) == 0:
                diagnostics = append_string(diagnostics, "llvm lowering: deref assignment missing pointer operand")
                return ExpressionStatementResult(lines=current_lines, temp_index=current_temp, locals=current_locals, bindings=current_bindings, diagnostics=diagnostics, lifetime_regions=lifetime_regions, lifetime_releases=lifetime_releases, next_region_id=current_next_region, mutations=mutations, string_constants=string_constants)
            lowered_ptr = lower_expression(pointer_text, current_bindings, current_locals, current_temp, current_lines, functions, context, "")
            diagnostics = (diagnostics) + (lowered_ptr.diagnostics)
            current_lines = lowered_ptr.lines
            current_temp = lowered_ptr.temp_index
            if lowered_ptr.operand == None:
                diagnostics = append_string(diagnostics, "llvm lowering: deref assignment pointer `" + pointer_text + "` produced no value")
                return ExpressionStatementResult(lines=current_lines, temp_index=current_temp, locals=current_locals, bindings=current_bindings, diagnostics=diagnostics, lifetime_regions=lifetime_regions, lifetime_releases=lifetime_releases, next_region_id=current_next_region, mutations=mutations, string_constants=string_constants)
            if not ends_with_pointer_suffix(lowered_ptr.operand.llvm_type):
                diagnostics = append_string(diagnostics, "llvm lowering: deref assignment target is not a pointer (got `" + lowered_ptr.operand.llvm_type + "`)")
                return ExpressionStatementResult(lines=current_lines, temp_index=current_temp, locals=current_locals, bindings=current_bindings, diagnostics=diagnostics, lifetime_regions=lifetime_regions, lifetime_releases=lifetime_releases, next_region_id=current_next_region, mutations=mutations, string_constants=string_constants)
            element_type = strip_pointer_suffix(lowered_ptr.operand.llvm_type)
            coerced = coerce_operand_to_type(lowered_value.operand, element_type, current_temp, current_lines)
            diagnostics = (diagnostics) + (coerced.diagnostics)
            current_lines = coerced.lines
            current_temp = coerced.temp_index
            if coerced.operand == None:
                diagnostics = append_string(diagnostics, "llvm lowering: unable to coerce deref assignment value to `" + element_type + "`")
                return ExpressionStatementResult(lines=current_lines, temp_index=current_temp, locals=current_locals, bindings=current_bindings, diagnostics=diagnostics, lifetime_regions=lifetime_regions, lifetime_releases=lifetime_releases, next_region_id=current_next_region, mutations=mutations, string_constants=string_constants)
            current_lines = append_string(current_lines, "  store " + element_type + " " + coerced.operand.value + ", " + element_type + "* " + lowered_ptr.operand.value)
            return ExpressionStatementResult(lines=current_lines, temp_index=current_temp, locals=current_locals, bindings=current_bindings, diagnostics=diagnostics, lifetime_regions=lifetime_regions, lifetime_releases=lifetime_releases, next_region_id=current_next_region, mutations=mutations, string_constants=string_constants)
        member_parse = parse_member_access(parsed_assignment.target)
        if member_parse.success:
            effective_value = parsed_assignment.value
            if len(parsed_assignment.operator) > 0:
                effective_value = parsed_assignment.target + " " + parsed_assignment.operator + " " + parsed_assignment.value
            lowered = lower_expression(effective_value, current_bindings, current_locals, current_temp, current_lines, functions, context, "")
            diagnostics = (diagnostics) + (lowered.diagnostics)
            string_constants = lowered.string_constants
            current_lines = lowered.lines
            current_temp = lowered.temp_index
            if lowered.operand == None:
                diagnostics = append_string(diagnostics, "llvm lowering: failed to lower assignment value for member `" + parsed_assignment.target + "`")
            else:
                base_result = lower_expression(member_parse.base, current_bindings, current_locals, current_temp, current_lines, functions, context, "")
                diagnostics = (diagnostics) + (base_result.diagnostics)
                current_lines = base_result.lines
                current_temp = base_result.temp_index
                if base_result.operand == None:
                    diagnostics = append_string(diagnostics, "llvm lowering: member access assignment base `" + member_parse.base + "` produced no value")
                else:
                    base_operand = base_result.operand
                    base_pointer_type = base_operand.llvm_type
                    base_pointer_value = base_operand.value
                    base_name = trim_text(member_parse.base)
                    if not ends_with_pointer_suffix(base_pointer_type)  and  is_simple_identifier(base_name):
                        local_pointer = find_local_binding(current_locals, base_name)
                        if local_pointer != None:
                            base_pointer_type = local_pointer.llvm_type + "*"
                            base_pointer_value = local_pointer.pointer
                        else:
                            parameter_pointer = find_parameter_binding(current_bindings, base_name)
                            if parameter_pointer != None  and  ends_with_pointer_suffix(parameter_pointer.llvm_type):
                                base_pointer_type = parameter_pointer.llvm_type
                                base_pointer_value = parameter_pointer.llvm_name
                    if not ends_with_pointer_suffix(base_pointer_type):
                        diagnostics = append_string(diagnostics, "llvm lowering: member access assignment base `" + member_parse.base + "` is not addressable")
                        return ExpressionStatementResult(lines=current_lines, temp_index=current_temp, locals=current_locals, bindings=current_bindings, diagnostics=diagnostics, lifetime_regions=lifetime_regions, lifetime_releases=lifetime_releases, next_region_id=current_next_region, mutations=mutations, string_constants=string_constants)
                    struct_llvm_name = strip_pointer_suffix(base_pointer_type)
                    struct_info = find_struct_info_by_llvm_type(context, struct_llvm_name)
                    if struct_info == None:
                        diagnostics = append_string(diagnostics, "llvm lowering: member access assignment on non-struct type `" + base_result.operand.llvm_type + "`")
                    else:
                        field_index = find_struct_field_index(struct_info, member_parse.field)
                        if field_index < 0:
                            diagnostics = append_string(diagnostics, "llvm lowering: struct `" + struct_info.name + "` has no field `" + member_parse.field + "`")
                        else:
                            field_info = struct_info.fields[field_index]
                            coerced = coerce_operand_to_type(lowered.operand, field_info.llvm_type, current_temp, current_lines)
                            diagnostics = (diagnostics) + (coerced.diagnostics)
                            current_lines = coerced.lines
                            current_temp = coerced.temp_index
                            if coerced.operand != None:
                                field_ptr_temp = format_temp_name(current_temp)
                                current_temp += 1
                                current_lines = append_string(current_lines, "  " + field_ptr_temp + " = getelementptr " + struct_info.llvm_name + ", " + base_pointer_type + " " + base_pointer_value + ", i32 0, i32 " + number_to_string(field_index))
                                current_lines = append_string(current_lines, "  store " + coerced.operand.llvm_type + " " + coerced.operand.value + ", " + coerced.operand.llvm_type + "* " + field_ptr_temp)
            return ExpressionStatementResult(lines=current_lines, temp_index=current_temp, locals=current_locals, bindings=current_bindings, diagnostics=diagnostics, lifetime_regions=lifetime_regions, lifetime_releases=lifetime_releases, next_region_id=current_next_region, mutations=mutations, string_constants=string_constants)
        index_parse = parse_index_expression(parsed_assignment.target)
        if index_parse.success:
            effective_value = parsed_assignment.value
            if len(parsed_assignment.operator) > 0:
                effective_value = parsed_assignment.target + " " + parsed_assignment.operator + " " + parsed_assignment.value
            lowered = lower_expression(effective_value, current_bindings, current_locals, current_temp, current_lines, functions, context, "")
            diagnostics = (diagnostics) + (lowered.diagnostics)
            string_constants = lowered.string_constants
            current_lines = lowered.lines
            current_temp = lowered.temp_index
            if lowered.operand == None:
                diagnostics = append_string(diagnostics, "llvm lowering: failed to lower assignment value for array index `" + parsed_assignment.target + "`")
            else:
                base_result = lower_expression(index_parse.base, current_bindings, current_locals, current_temp, current_lines, functions, context, "")
                diagnostics = (diagnostics) + (base_result.diagnostics)
                current_lines = base_result.lines
                current_temp = base_result.temp_index
                if base_result.operand == None:
                    diagnostics = append_string(diagnostics, "llvm lowering: array index assignment base `" + index_parse.base + "` produced no value")
                else:
                    index_result = lower_expression(index_parse.index, current_bindings, current_locals, current_temp, current_lines, functions, context, "")
                    diagnostics = (diagnostics) + (index_result.diagnostics)
                    current_lines = index_result.lines
                    current_temp = index_result.temp_index
                    if index_result.operand == None:
                        diagnostics = append_string(diagnostics, "llvm lowering: array index `" + index_parse.index + "` produced no value")
                    else:
                        element_type = array_pointer_element_type(base_result.operand.llvm_type)
                        if len(element_type) == 0:
                            diagnostics = append_string(diagnostics, "llvm lowering: cannot determine element type for array assignment `" + base_result.operand.llvm_type + "`")
                        else:
                            coerced = coerce_operand_to_type(lowered.operand, element_type, current_temp, current_lines)
                            diagnostics = (diagnostics) + (coerced.diagnostics)
                            current_lines = coerced.lines
                            current_temp = coerced.temp_index
                            if coerced.operand != None:
                                coerced_index = coerce_operand_to_type(index_result.operand, "i64", current_temp, current_lines)
                                diagnostics = (diagnostics) + (coerced_index.diagnostics)
                                current_lines = coerced_index.lines
                                current_temp = coerced_index.temp_index
                                if coerced_index.operand == None:
                                    diagnostics = append_string(diagnostics, "llvm lowering: unable to coerce array index to i64 for `" + parsed_assignment.target + "`")
                                    return ExpressionStatementResult(lines=current_lines, temp_index=current_temp, locals=current_locals, bindings=current_bindings, diagnostics=diagnostics, lifetime_regions=lifetime_regions, lifetime_releases=lifetime_releases, next_region_id=current_next_region, mutations=mutations, string_constants=string_constants)
                                data_ptr_temp = format_temp_name(current_temp)
                                current_temp += 1
                                elem_ptr_temp = format_temp_name(current_temp)
                                current_temp += 1
                                current_lines = append_string(current_lines, "  " + data_ptr_temp + " = getelementptr " + array_struct_type_for_element(element_type) + ", " + base_result.operand.llvm_type + " " + base_result.operand.value + ", i32 0, i32 0")
                                data_ptr_loaded = format_temp_name(current_temp)
                                current_temp += 1
                                current_lines = append_string(current_lines, "  " + data_ptr_loaded + " = load " + element_type + "*, " + element_type + "** " + data_ptr_temp)
                                current_lines = append_string(current_lines, "  " + elem_ptr_temp + " = getelementptr " + element_type + ", " + element_type + "* " + data_ptr_loaded + ", i64 " + coerced_index.operand.value)
                                current_lines = append_string(current_lines, "  store " + coerced.operand.llvm_type + " " + coerced.operand.value + ", " + coerced.operand.llvm_type + "* " + elem_ptr_temp)
            return ExpressionStatementResult(lines=current_lines, temp_index=current_temp, locals=current_locals, bindings=current_bindings, diagnostics=diagnostics, lifetime_regions=lifetime_regions, lifetime_releases=lifetime_releases, next_region_id=current_next_region, mutations=mutations, string_constants=string_constants)
        binding = find_local_binding(current_locals, parsed_assignment.target)
        if binding == None:
            diagnostics = append_string(diagnostics, "llvm lowering: assignment to unknown local `" + parsed_assignment.target + "`")
        else:
            effective_value = parsed_assignment.value
            if len(parsed_assignment.operator) > 0:
                effective_value = parsed_assignment.target + " " + parsed_assignment.operator + " " + parsed_assignment.value
            previous_ownership = binding.ownership
            ownership_analysis = analyze_value_ownership(effective_value, instruction.span, current_locals, current_bindings)
            diagnostics = (diagnostics) + (ownership_analysis.diagnostics)
            assignment_ownership = ownership_analysis.ownership
            consumption = ownership_analysis.consumption
            stored_value = default_return_literal(binding.llvm_type)
            lowered = lower_expression(effective_value, current_bindings, current_locals, current_temp, current_lines, functions, context, binding.llvm_type)
            diagnostics = (diagnostics) + (lowered.diagnostics)
            string_constants = lowered.string_constants
            current_lines = lowered.lines
            current_temp = lowered.temp_index
            if lowered.operand == None:
                diagnostics = append_string(diagnostics, "llvm lowering: failed to lower assignment expression for `" + parsed_assignment.target + "`")
            else:
                coerced = coerce_operand_to_type(lowered.operand, binding.llvm_type, current_temp, current_lines)
                diagnostics = (diagnostics) + (coerced.diagnostics)
                current_lines = coerced.lines
                current_temp = coerced.temp_index
                if coerced.operand == None:
                    diagnostics = append_string(diagnostics, "llvm lowering: unable to coerce assignment value for `" + parsed_assignment.target + "`")
                    current_lines = append_string(current_lines, "  store " + binding.llvm_type + " " + default_return_literal(binding.llvm_type) + ", " + binding.llvm_type + "* " + binding.pointer)
                else:
                    operand = coerced.operand
                    stored_value = operand.value
                    current_lines = append_string(current_lines, "  store " + binding.llvm_type + " " + operand.value + ", " + binding.llvm_type + "* " + binding.pointer)
            if consumption != None:
                if consumption.kind == "local":
                    current_locals = mark_local_consumed(current_locals, consumption.name)
                else:
                    if consumption.kind == "parameter":
                        current_bindings = mark_parameter_consumed(current_bindings, consumption.name)
            if previous_ownership != None:
                if previous_ownership.variant == "Borrow":
                    if previous_ownership.region_id >= 0:
                        release_event = LifetimeReleaseEvent(region_id=previous_ownership.region_id, scope_id=scope_id, scope_depth=scope_depth)
                        lifetime_releases = append_lifetime_release_event(lifetime_releases, release_event)
            if assignment_ownership != None:
                if assignment_ownership.variant == "Borrow":
                    region_id = current_next_region
                    current_next_region += 1
                    assignment_ownership = OwnershipInfo(variant=assignment_ownership.variant, base=assignment_ownership.base, mutable=assignment_ownership.mutable, span=assignment_ownership.span, region_id=region_id)
                else:
                    assignment_ownership = OwnershipInfo(variant=assignment_ownership.variant, base=assignment_ownership.base, mutable=assignment_ownership.mutable, span=assignment_ownership.span, region_id=-1)
            current_locals = reset_local_consumption(current_locals, parsed_assignment.target)
            current_locals = update_local_ownership(current_locals, parsed_assignment.target, assignment_ownership)
            if assignment_ownership != None:
                if assignment_ownership.variant == "Borrow":
                    base_scope = infer_borrow_base_scope(assignment_ownership.base, current_locals, current_bindings, function_name)
                    region = make_lifetime_region_metadata(assignment_ownership.region_id, parsed_assignment.target, assignment_ownership, binding.scope_id, binding.scope_depth, base_scope.scope_id, base_scope.scope_depth)
                    lifetime_regions = append_lifetime_region(lifetime_regions, region)
            mutation = LocalMutation(name=parsed_assignment.target, llvm_type=binding.llvm_type, value_name=stored_value, span=instruction.span, originating_label=current_label)
            mutations = (mutations) + ([mutation])
        return ExpressionStatementResult(lines=current_lines, temp_index=current_temp, locals=current_locals, bindings=current_bindings, diagnostics=diagnostics, lifetime_regions=lifetime_regions, lifetime_releases=lifetime_releases, next_region_id=current_next_region, mutations=mutations, string_constants=string_constants)
    ownership_analysis = analyze_value_ownership(expression, instruction.span, current_locals, current_bindings)
    diagnostics = (diagnostics) + (ownership_analysis.diagnostics)
    consumption = ownership_analysis.consumption
    lowered = lower_expression(expression, current_bindings, current_locals, current_temp, current_lines, functions, context, "")
    diagnostics = (diagnostics) + (lowered.diagnostics)
    string_constants = lowered.string_constants
    current_lines = lowered.lines
    current_temp = lowered.temp_index
    if consumption != None:
        if consumption.kind == "local":
            current_locals = mark_local_consumed(current_locals, consumption.name)
        else:
            if consumption.kind == "parameter":
                current_bindings = mark_parameter_consumed(current_bindings, consumption.name)
    return ExpressionStatementResult(lines=current_lines, temp_index=current_temp, locals=current_locals, bindings=current_bindings, diagnostics=diagnostics, lifetime_regions=lifetime_regions, lifetime_releases=lifetime_releases, next_region_id=current_next_region, mutations=mutations, string_constants=string_constants)

def parse_assignment_expression(expression):
    trimmed = trim_text(expression)
    paren_depth = 0
    bracket_depth = 0
    index = 0
    while True:
        if index >= len(trimmed):
            break
        ch = trimmed[index]
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
        if paren_depth > 0  or  bracket_depth > 0:
            index += 1
            continue
        if ch == "=":
            previous = ""
            if index > 0:
                previous = trimmed[index - 1]
            next_char = ""
            if index + 1 < len(trimmed):
                next_char = trimmed[index + 1]
            if previous == "+"  or  previous == "-"  or  previous == "*"  or  previous == "/":
                target = trim_text(substring(trimmed, 0, index - 1))
                value = trim_text(substring(trimmed, index + 1, len(trimmed)))
                if len(target) == 0  or  len(value) == 0:
                    return AssignmentParseResult(success=False, target="", value="", operator="")
                return AssignmentParseResult(success=True, target=target, value=value, operator=previous)
            if previous == "="  or  previous == "!"  or  previous == ">"  or  previous == "<":
                index += 1
                continue
            if next_char == "="  or  next_char == ">":
                index += 1
                continue
            target = trim_text(substring(trimmed, 0, index))
            value = trim_text(substring(trimmed, index + 1, len(trimmed)))
            if len(target) == 0  or  len(value) == 0:
                return AssignmentParseResult(success=False, target="", value="", operator="")
            return AssignmentParseResult(success=True, target=target, value=value, operator="")
        index += 1
    return AssignmentParseResult(success=False, target="", value="", operator="")

def parse_inline_let_expression(expression):
    diagnostics = []
    trimmed = trim_text(expression)
    if len(trimmed) < 4:
        diagnostics = append_string(diagnostics, "llvm lowering: malformed let expression `" + expression + "`")
        return InlineLetParseResult(success=False, name="", mutable=False, type_annotation="", initializer=None, diagnostics=diagnostics)
    prefix = substring(trimmed, 0, 4)
    if prefix != "let ":
        return InlineLetParseResult(success=False, name="", mutable=False, type_annotation="", initializer=None, diagnostics=diagnostics)
    remainder = trim_text(substring(trimmed, 4, len(trimmed)))
    is_mutable = False
    if len(remainder) >= 4:
        mut_prefix = substring(remainder, 0, 4)
        if mut_prefix == "mut ":
            is_mutable = True
            remainder = trim_text(substring(remainder, 4, len(remainder)))
    if len(remainder) == 0:
        diagnostics = append_string(diagnostics, "llvm lowering: let expression missing binding name in `" + expression + "`")
        return InlineLetParseResult(success=False, name="", mutable=is_mutable, type_annotation="", initializer=None, diagnostics=diagnostics)
    name = ""
    index = 0
    while True:
        if index >= len(remainder):
            break
        ch = remainder[index]
        if ch == " "  or  ch == ":"  or  ch == "-"  or  ch == "=":
            break
        name = name + ch
        index += 1
    name = trim_text(name)
    if len(name) == 0:
        diagnostics = append_string(diagnostics, "llvm lowering: let expression missing binding name in `" + expression + "`")
        return InlineLetParseResult(success=False, name="", mutable=is_mutable, type_annotation="", initializer=None, diagnostics=diagnostics)
    tail = trim_text(substring(remainder, index, len(remainder)))
    type_annotation = ""
    initializer = None
    if len(tail) > 0:
        if len(tail) >= 2:
            annotation_prefix = substring(tail, 0, 2)
            if annotation_prefix == "->":
                tail = trim_text(substring(tail, 2, len(tail)))
                assign_index = index_of(tail, "=")
                if assign_index >= 0:
                    type_annotation = trim_text(substring(tail, 0, assign_index))
                    value_text = trim_text(substring(tail, assign_index + 1, len(tail)))
                    if len(value_text) > 0:
                        initializer = value_text
                else:
                    type_annotation = trim_text(tail)
            else:
                if tail[0] == ":":
                    tail = trim_text(substring(tail, 1, len(tail)))
                    assign_index = index_of(tail, "=")
                    if assign_index >= 0:
                        type_annotation = trim_text(substring(tail, 0, assign_index))
                        value_text = trim_text(substring(tail, assign_index + 1, len(tail)))
                        if len(value_text) > 0:
                            initializer = value_text
                    else:
                        type_annotation = trim_text(tail)
                else:
                    if tail[0] == "=":
                        value_text = trim_text(substring(tail, 1, len(tail)))
                        if len(value_text) > 0:
                            initializer = value_text
                    else:
                        value_text = trim_text(tail)
                        if len(value_text) > 0:
                            initializer = value_text
        else:
            if tail[0] == "=":
                value_text = trim_text(substring(tail, 1, len(tail)))
                if len(value_text) > 0:
                    initializer = value_text
            else:
                value_text = trim_text(tail)
                if len(value_text) > 0:
                    initializer = value_text
    if initializer == None:
        diagnostics = append_string(diagnostics, "llvm lowering: let expression missing initializer for `" + name + "`")
        return InlineLetParseResult(success=False, name=name, mutable=is_mutable, type_annotation=type_annotation, initializer=None, diagnostics=diagnostics)
    return InlineLetParseResult(success=True, name=name, mutable=is_mutable, type_annotation=type_annotation, initializer=initializer, diagnostics=diagnostics)

def lower_return_instruction(function, instruction, llvm_return, bindings, locals, temp_index, lines, next_region_id, scope_id, scope_depth, functions, context):
    diagnostics = []
    current_lines = lines
    current_temp = temp_index
    lifetime_regions = []
    lifetime_releases = []
    current_next_region = next_region_id
    if instruction.expression == None  or  len(instruction.expression) == 0:
        if llvm_return == "void":
            current_lines = append_string(current_lines, "  ret void")
        else:
            diagnostics = append_string(diagnostics, "llvm lowering: missing return value in `" + function.name + "`")
            current_lines = append_string(current_lines, "  ret " + llvm_return + " " + default_return_literal(llvm_return))
        empty_constants = empty_string_constant_set()
        return ExpressionStatementResult(lines=current_lines, temp_index=current_temp, locals=locals, bindings=bindings, diagnostics=diagnostics, lifetime_regions=lifetime_regions, lifetime_releases=lifetime_releases, next_region_id=current_next_region, mutations=[], string_constants=empty_constants)
    current_locals = locals
    current_bindings = bindings
    suspension_diagnostics = detect_suspension_conflicts(instruction.expression, current_locals, current_bindings, function.name, instruction.span)
    diagnostics = (diagnostics) + (suspension_diagnostics)
    ownership_analysis = analyze_value_ownership(instruction.expression, instruction.span, current_locals, current_bindings)
    diagnostics = (diagnostics) + (ownership_analysis.diagnostics)
    consumption = ownership_analysis.consumption
    lowered = lower_expression(instruction.expression, current_bindings, current_locals, current_temp, current_lines, functions, context, llvm_return)
    diagnostics = (diagnostics) + (lowered.diagnostics)
    current_lines = lowered.lines
    current_temp = lowered.temp_index
    string_constants = lowered.string_constants
    if lowered.operand == None:
        diagnostics = append_string(diagnostics, "llvm lowering: unhandled return expression in `" + function.name + "`")
        current_lines = append_string(current_lines, "  ret " + llvm_return + " " + default_return_literal(llvm_return))
        return ExpressionStatementResult(lines=current_lines, temp_index=current_temp, locals=current_locals, bindings=current_bindings, diagnostics=diagnostics, lifetime_regions=lifetime_regions, lifetime_releases=lifetime_releases, next_region_id=current_next_region, mutations=[], string_constants=string_constants)
    operand = lowered.operand
    if llvm_return == "void":
        diagnostics = append_string(diagnostics, "llvm lowering: void function `" + function.name + "` returned a value")
        current_lines = append_string(current_lines, "  ret void")
        return ExpressionStatementResult(lines=current_lines, temp_index=current_temp, locals=current_locals, bindings=current_bindings, diagnostics=diagnostics, lifetime_regions=lifetime_regions, lifetime_releases=lifetime_releases, next_region_id=current_next_region, mutations=[], string_constants=string_constants)
    coerced = coerce_operand_to_type(operand, llvm_return, current_temp, current_lines)
    diagnostics = (diagnostics) + (coerced.diagnostics)
    current_lines = coerced.lines
    current_temp = coerced.temp_index
    if coerced.operand == None:
        diagnostics = append_string(diagnostics, "llvm lowering: unable to coerce return expression to `" + llvm_return + "` in `" + function.name + "`")
        current_lines = append_string(current_lines, "  ret " + llvm_return + " " + default_return_literal(llvm_return))
        return ExpressionStatementResult(lines=current_lines, temp_index=current_temp, locals=current_locals, bindings=current_bindings, diagnostics=diagnostics, lifetime_regions=lifetime_regions, lifetime_releases=lifetime_releases, next_region_id=current_next_region, mutations=[], string_constants=string_constants)
    coerced_operand = coerced.operand
    if coerced_operand.llvm_type == "i8*":
        current_lines = append_string(current_lines, "  call void @sailfin_runtime_mark_persistent(i8* " + coerced_operand.value + ")")
    current_lines = append_string(current_lines, "  ret " + coerced_operand.llvm_type + " " + coerced_operand.value)
    if consumption != None:
        if consumption.kind == "local":
            current_locals = mark_local_consumed(current_locals, consumption.name)
        else:
            if consumption.kind == "parameter":
                current_bindings = mark_parameter_consumed(current_bindings, consumption.name)
    return ExpressionStatementResult(lines=current_lines, temp_index=current_temp, locals=current_locals, bindings=current_bindings, diagnostics=diagnostics, lifetime_regions=lifetime_regions, lifetime_releases=lifetime_releases, next_region_id=current_next_region, mutations=[], string_constants=string_constants)

def prepare_parameters(function, context):
    signature = []
    bindings = []
    diagnostics = []
    index = 0
    while True:
        if index >= len(function.parameters):
            break
        parameter = function.parameters[index]
        llvm_type = map_parameter_type(context, parameter.type_annotation)
        inferred_self_type = False
        if len(parameter.type_annotation) == 0  and  parameter.name == "self"  and  index == 0:
            double_colon_pos = find_last_index_of_char(function.name, ":")
            if double_colon_pos > 0  and  substring(function.name, double_colon_pos - 1, double_colon_pos + 1) == "::":
                struct_name = substring(function.name, 0, double_colon_pos - 1)
                struct_type = map_struct_type_annotation(context, struct_name)
                if len(struct_type) > 0:
                    llvm_type = struct_type + "*"
                    inferred_self_type = True
        if len(parameter.type_annotation) == 0  and  not inferred_self_type:
            diagnostics = append_string(diagnostics, "llvm lowering: parameter `" + parameter.name + "` missing type annotation; defaulting to `" + llvm_type + "`")
        sanitized = sanitize_symbol(parameter.name)
        llvm_name = "%" + sanitized
        signature = append_string(signature, llvm_type + " " + llvm_name)
        bindings = append_parameter_binding(bindings, ParameterBinding(name=parameter.name, llvm_name=llvm_name, llvm_type=llvm_type, type_annotation=parameter.type_annotation, consumed=False, span=parameter.span))
        index += 1
    return ParameterPreparation(signature=signature, bindings=bindings, diagnostics=diagnostics)

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

def contains_keyword_outside_strings(value, keyword):
    if len(value) == 0:
        return False
    index = 0
    in_single = False
    in_double = False
    escape = False
    while True:
        if index >= len(value):
            break
        ch = value[index]
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
        if ch == keyword[0]:
            if index > 0:
                previous = value[index - 1]
                if is_identifier_part_char(previous):
                    index += 1
                    continue
            if matches_keyword(value, index, keyword):
                return True
        index += 1
    return False

def find_suspension_keyword(expression):
    if contains_keyword_outside_strings(expression, "await"):
        return "await"
    if contains_keyword_outside_strings(expression, "yield"):
        return "yield"
    return ""

def is_mutable_borrow_annotation(annotation):
    trimmed = trim_text(annotation)
    if len(trimmed) == 0:
        return False
    normalized = unwrap_move_wrapper(trimmed)
    if len(normalized) == 0:
        return False
    if normalized[0] != "&":
        return False
    remainder = trim_text(substring(normalized, 1, len(normalized)))
    if len(remainder) == 0:
        return False
    if starts_with(remainder, "mut"):
        return True
    return False

def collect_suspension_conflicts(keyword, locals, bindings, function_name, suspension_span):
    diagnostics = []
    index = 0
    while True:
        if index >= len(locals):
            break
        local = locals[index]
        if not local.consumed  and  local.ownership != None:
            details = local.ownership
            if details.variant == "Borrow"  and  details.mutable:
                base_name = normalise_borrow_base(details.base)
                location = format_suspension_location(keyword, details.span, suspension_span)
                diagnostics = append_string(diagnostics, "llvm lowering: " + keyword + " suspends while mutable borrow `" + local.name + "` of `" + base_name + "` remains active in `" + function_name + "`" + location)
        index += 1
    parameter_index = 0
    while True:
        if parameter_index >= len(bindings):
            break
        binding = bindings[parameter_index]
        if not binding.consumed:
            if is_mutable_borrow_annotation(binding.type_annotation):
                location = format_suspension_location(keyword, binding.span, suspension_span)
                diagnostics = append_string(diagnostics, "llvm lowering: " + keyword + " suspends while mutable borrow parameter `" + binding.name + "` remains active in `" + function_name + "`" + location)
        parameter_index += 1
    return diagnostics

def normalise_borrow_base(raw_base):
    trimmed = trim_text(raw_base)
    while True:
        if len(trimmed) == 0:
            break
        if trimmed[0] == "*":
            trimmed = trim_text(substring(trimmed, 1, len(trimmed)))
            continue
        break
    if len(trimmed) >= 2:
        if trimmed[0] == "(":
            if trimmed[len(trimmed) - 1] == ")":
                inner = trim_text(substring(trimmed, 1, len(trimmed) - 1))
                if len(inner) > 0:
                    return inner
    return trimmed

def detect_suspension_conflicts(expression, locals, bindings, function_name, suspension_span):
    if expression == None:
        return []
    trimmed = trim_text(expression)
    if len(trimmed) == 0:
        return []
    keyword = find_suspension_keyword(trimmed)
    if len(keyword) == 0:
        return []
    return collect_suspension_conflicts(keyword, locals, bindings, function_name, suspension_span)

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

def spawn_symbol_for_return_type(return_type):
    trimmed = trim_text(return_type)
    if len(trimmed) == 0  or  trimmed == "void":
        return "sailfin_runtime_spawn_void"
    normalized = unwrap_move_wrapper(trimmed)
    if normalized == "number":
        return "sailfin_runtime_spawn_number"
    if normalized == "boolean"  or  normalized == "bool":
        return "sailfin_runtime_spawn_bool"
    if normalized == "string":
        return "sailfin_runtime_spawn_string"
    return "sailfin_runtime_spawn_ptr"

def spawn_ctx_symbol_for_return_type(return_type):
    trimmed = trim_text(return_type)
    if len(trimmed) == 0  or  trimmed == "void":
        return "sailfin_runtime_spawn_void_ctx"
    normalized = unwrap_move_wrapper(trimmed)
    if normalized == "number":
        return "sailfin_runtime_spawn_number_ctx"
    if normalized == "boolean"  or  normalized == "bool":
        return "sailfin_runtime_spawn_bool_ctx"
    if normalized == "string":
        return "sailfin_runtime_spawn_string_ctx"
    return "sailfin_runtime_spawn_ptr_ctx"

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

def map_local_type(context, type_annotation):
    trimmed = trim_text(type_annotation)
    if len(trimmed) == 0:
        return "double"
    normalized = unwrap_move_wrapper(trimmed)
    if starts_with(normalized, "*"):
        remainder = trim_text(substring(normalized, 1, len(normalized)))
        if starts_with(remainder, "mut"):
            remainder = trim_text(substring(remainder, 3, len(remainder)))
        if remainder == "opaque"  or  len(remainder) == 0:
            return "i8*"
        inner = map_local_type(context, remainder)
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
