import asyncio
from runtime import runtime_support as runtime

from compiler.build.emit_native import NativeModule
from compiler.build.native_ir import select_text_artifact, select_layout_manifest_artifact, parse_native_artifact, parse_layout_manifest, NativeFunction, NativeInstruction, NativeParameter, NativeInterface, NativeInterfaceSignature, NativeStruct, NativeEnum, NativeEnumLayout, NativeEnumVariant, NativeEnumVariantLayout, NativeSourceSpan, NativeImport, LayoutManifest, NativeBinding
from compiler.build.string_utils import substring, char_code, char_at, find_char, find_last_index_of_char, index_of as str_index_of
from compiler.build.llvm.types import TypeContext, StructTypeInfo, StructFieldInfo, EnumTypeInfo, EnumVariantInfo, InterfaceTypeInfo, VTableInfo, VTableEntry, LocalBinding, ParameterBinding, OwnershipInfo, OwnershipConsumption, OwnershipAnalysis, LifetimeRegionMetadata, LifetimeReleaseEvent, ScopeMetadata, LLVMOperand, ExpressionResult, CoercionResult, BlockLoweringResult, LoweredLLVMFunction, LoweredLLVMResult, LetLoweringResult, ModuleGlobalLoweringResult, OperatorMatch, BorrowParseResult, BorrowArgumentParse, TernaryParseResult, AssignmentParseResult, InlineLetParseResult, MemberAccessParse, IndexExpressionParse, RawAddressParseResult, CastParseResult, TraitMetadata, TraitDescriptor, TraitImplementationDescriptor, FunctionEffectEntry, RuntimeHelperDescriptor, CapabilityManifest, CapabilityManifestEntry, StringConstant, LocalMutation, LoopContext, ImportedModuleContext, LayoutManifestApplication, TypeContextBuild, FunctionCallEntry, StringPointerResult, InterpolatedTemplateParse, BodyResult, ParameterPreparation, ArrayLiteralMetadata, TypeAllocationInfo, HeapBoxResult, StructLiteralField, StructLiteralParse, EnumLiteralParse, ExpressionStatementResult, BlockLabelResult, IfStructure, LoopStructure, TryStructure, RangeIterableParse, MatchCaseStructure, MatchStructure, MatchFieldBinding, MatchStructFieldBinding, MatchCaseCondition, ConditionConversion, ComparisonEmission, BinaryAlignmentResult, ThrowLoweringResult, PhiMergeResult, PhiInputEntry, MutationMaterializationResult, PhiStoreEntry, MatchArmMutations, LoadLocalResult
from compiler.build.llvm.expression_lowering_stage2 import analyze_value_ownership, array_pointer_element_type, array_struct_type_for_element, coerce_operand_to_type, collect_parameter_types, default_return_literal, detect_borrow_conflicts, detect_suspension_conflicts, emit_boolean_and, emit_comparison_instruction, ends_with_pointer_suffix, extract_simple_identifier, find_parameter_binding, format_local_pointer_name, format_span_location, format_temp_name, future_pointer_type_for_return_type, harmonise_operands, is_simple_identifier, is_union_llvm_type, load_local_operand, lower_expression, lower_expression_statement, lower_return_instruction, map_local_type, map_return_type, mark_local_consumed, mark_parameter_consumed, parse_enum_literal, parse_inline_let_expression, parse_range_iterable, parse_struct_pattern, parse_union_payload_types, prepare_parameters, spawn_ctx_symbol_for_return_type, spawn_symbol_for_return_type, starts_with, strip_mut_prefix, strip_pointer_suffix
from compiler.build.llvm.utils import trim_text, starts_with, ends_with, char_at as utils_char_at, append_string, join_with_separator, string_array_contains, sanitize_symbol, number_to_string, index_of, is_identifier_start_char, is_identifier_part_char, find_parameter_binding as utils_find_parameter_binding, merge_parameter_bindings
from compiler.build.llvm.strings import empty_string_constant_set, append_string_constant, merge_string_constants, find_string_constant, render_string_constants, escape_string_for_llvm
from compiler.build.llvm.effects import collect_direct_function_effects, collect_function_call_graph, propagate_function_effects, build_capability_manifest, collect_function_borrow_effects, collect_expression_borrow_effects, collect_runtime_helper_targets
from compiler.build.llvm.runtime_helpers import runtime_helper_descriptors, find_runtime_helper, append_runtime_helper
from compiler.build.llvm.type_mapping import map_type_annotation, map_return_type, map_parameter_type, map_local_type, map_struct_type_annotation, map_struct_field_annotation, unwrap_move_wrapper, ends_with_pointer_suffix, strip_pointer_suffix, layout_annotation_requires_pointer, layout_annotation_base_type, annotation_is_array, layout_annotation_represents_user_value
from compiler.build.llvm.rendering import render_test_harness_main, collect_exported_symbol_names, should_internalize_function, render_struct_type_definitions, render_enum_type_definitions, render_interface_type_definitions, render_vtable_type_definitions, render_vtable_constants, find_function_by_name
from compiler.build.llvm.type_context import fixup_enum_layouts, find_struct_info_by_name, find_interface_info_by_name, find_vtable_for_struct_interface, find_struct_info_by_llvm_type, find_struct_field_index, find_struct_field_info, find_enum_info_by_llvm_type, resolve_struct_info_from_llvm_type, lookup_allocation_info, resolve_struct_info_for_literal, resolve_struct_info_for_method_target, resolve_interface_info_for_method_target, resolve_enum_info_for_literal, resolve_enum_variant_info, find_variant_field_info
from compiler.build.llvm.lowering.instructions import lower_instruction_range, collect_if_structure, lower_throw_instruction, collect_try_structure, lower_try_instruction, collect_loop_structure, lower_loop_instruction, lower_for_instruction, collect_match_structure, lower_match_instruction, lower_match_case_condition, allocate_block_label, lower_condition_to_i1, lower_if_instruction, lower_let_instruction
from compiler.build.llvm.lowering.phi import find_preloaded_value, collect_mutation_names, find_mutation_for_name, join_strings, build_phi_and_store, find_last_label, retarget_recent_mutations, materialize_mutation_values_at_exit, emit_phi_merges_for_straight_if, emit_phi_merges_for_if_else, emit_phi_merges_for_match

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

def empty_trait_metadata():
    return TraitMetadata(interfaces=[], implementations=[])

def empty_capability_manifest():
    return CapabilityManifest(entries=[])

def build_trait_metadata(interfaces, structs):
    interface_descriptors = []
    index = 0
    while True:
        if index >= len(interfaces):
            break
        interface = interfaces[index]
        interface_descriptors = (interface_descriptors) + ([TraitDescriptor(name=interface.name, type_parameters=interface.type_parameters, signatures=interface.signatures)])
        index += 1
    implementation_descriptors = []
    index = 0
    while True:
        if index >= len(structs):
            break
        definition = structs[index]
        if len(definition.implements) > 0:
            implementation_descriptors = (implementation_descriptors) + ([TraitImplementationDescriptor(struct_name=definition.name, interfaces=definition.implements)])
        index += 1
    return TraitMetadata(interfaces=interface_descriptors, implementations=implementation_descriptors)

def render_trait_metadata_comments(metadata):
    interface_lines = []
    index = 0
    while True:
        if index >= len(metadata.interfaces):
            break
        interface = metadata.interfaces[index]
        header = "; interface " + interface.name
        if len(interface.type_parameters) > 0:
            header = header + "<" + join_with_separator(interface.type_parameters, ", ") + ">"
        interface_lines = append_string(interface_lines, header)
        signature_index = 0
        while True:
            if signature_index >= len(interface.signatures):
                break
            signature = interface.signatures[signature_index]
            rendered = render_interface_signature(signature)
            interface_lines = append_string(interface_lines, ";   " + rendered)
            signature_index += 1
        if len(interface.signatures) == 0:
            interface_lines = append_string(interface_lines, ";   ; no signatures recorded")
        index += 1
    struct_lines = []
    index = 0
    while True:
        if index >= len(metadata.implementations):
            break
        implementation = metadata.implementations[index]
        line = "; struct " + implementation.struct_name + " implements " + join_with_separator(implementation.interfaces, ", ")
        struct_lines = append_string(struct_lines, line)
        index += 1
    if len(interface_lines) == 0  and  len(struct_lines) == 0:
        return []
    lines = []
    lines = append_string(lines, "; -- Trait Metadata --------------------------------")
    lines = (lines) + (interface_lines)
    if len(interface_lines) > 0  and  len(struct_lines) > 0:
        lines = append_string(lines, ";")
    lines = (lines) + (struct_lines)
    lines = append_string(lines, "; -----------------------------------------------")
    return lines

def render_runtime_helper_declarations(used_targets, local_functions):
    if len(used_targets) == 0:
        return []
    local_symbols = []
    local_index = 0
    while True:
        if local_index >= len(local_functions):
            break
        local_symbols = append_string(local_symbols, sanitize_symbol(local_functions[local_index].name))
        local_index += 1
    lines = []
    descriptors = runtime_helper_descriptors()
    index = 0
    while True:
        if index >= len(descriptors):
            break
        descriptor = descriptors[index]
        if string_array_contains(used_targets, descriptor.target):
            if string_array_contains(local_symbols, descriptor.symbol):
                index += 1
                continue
            if len(descriptor.effects) > 0:
                effects_text = join_with_separator(descriptor.effects, ", ")
                lines = append_string(lines, "; intrinsic " + descriptor.symbol + " requires capabilities: ![" + effects_text + "]")
            parameter_text = ""
            if len(descriptor.parameter_types) > 0:
                parameter_text = join_with_separator(descriptor.parameter_types, ", ")
            line = "declare " + descriptor.return_type + " @" + descriptor.symbol + "(" + parameter_text + ")"
            lines = append_string(lines, line)
        index += 1
    return lines

def render_imported_function_declarations(imported_functions, local_functions, context):
    if len(imported_functions) == 0:
        return []
    helper_descriptors = runtime_helper_descriptors()
    helper_symbols = []
    helper_index = 0
    while True:
        if helper_index >= len(helper_descriptors):
            break
        helper_symbols = append_string(helper_symbols, helper_descriptors[helper_index].symbol)
        helper_index += 1
    local_symbols = []
    local_index = 0
    while True:
        if local_index >= len(local_functions):
            break
        local_symbols = append_string(local_symbols, sanitize_symbol(local_functions[local_index].name))
        local_index += 1
    lines = []
    emitted_declarations = []
    index = 0
    while True:
        if index >= len(imported_functions):
            break
        function = imported_functions[index]
        sanitized_name = sanitize_symbol(function.name)
        if string_array_contains(helper_symbols, sanitized_name)  or  string_array_contains(local_symbols, sanitized_name):
            index += 1
            continue
        if string_array_contains(emitted_declarations, sanitized_name):
            index += 1
            continue
        emitted_declarations = append_string(emitted_declarations, sanitized_name)
        return_type = map_return_type(context, function.return_type)
        param_types = collect_parameter_types(context, function.parameters, function.name)
        param_text = join_with_separator(param_types, ", ")
        line = "declare " + return_type + " @" + sanitized_name + "(" + param_text + ")"
        lines = append_string(lines, line)
        index += 1
    return lines

def empty_type_context():
    return TypeContext(structs=[], enums=[], interfaces=[], vtables=[])

def build_type_context(structs, enums, interfaces):
    diagnostics = []
    struct_entries = []
    index = 0
    while True:
        if index >= len(structs):
            break
        definition = structs[index]
        if definition.layout == None:
            diagnostics = append_string(diagnostics, "llvm lowering: struct `" + definition.name + "` missing layout metadata; skipping type emission")
            index += 1
            continue
        layout = definition.layout
        sanitized = sanitize_symbol(definition.name)
        llvm_name = "%" + sanitized
        fields = []
        field_index = 0
        while True:
            if field_index >= len(layout.fields):
                break
            layout_field = layout.fields[field_index]
            mapped = map_struct_field_annotation(layout_field.type_annotation)
            llvm_field_type = mapped
            if len(llvm_field_type) == 0:
                diagnostics = append_string(diagnostics, "llvm lowering: struct `" + definition.name + "` field `" + layout_field.name + "` uses unsupported type `" + layout_field.type_annotation + "`; lowering as `i8*`")
                llvm_field_type = "i8*"
            else:
                if ends_with_pointer_suffix(llvm_field_type):
                    layout_base_type = layout_annotation_base_type(layout_field.type_annotation)
                    references_self_type = layout_base_type == definition.name
                    if layout_annotation_represents_user_value(layout_field.type_annotation)  and  not references_self_type:
                        stripped = strip_pointer_suffix(llvm_field_type)
                        if len(stripped) > 0:
                            llvm_field_type = stripped
            fields = append_struct_field_info(fields, StructFieldInfo(name=layout_field.name, llvm_type=llvm_field_type, type_annotation=layout_field.type_annotation, index=field_index, offset=layout_field.offset))
            field_index += 1
        align_value = layout.align
        if align_value <= 0:
            align_value = 1
        struct_entries = append_struct_type_info(struct_entries, StructTypeInfo(name=definition.name, llvm_name=llvm_name, fields=fields, size=layout.size, align=align_value))
        index += 1
    enum_entries = []
    enum_index = 0
    while True:
        if enum_index >= len(enums):
            break
        enum_def = enums[enum_index]
        if enum_def.layout == None:
            diagnostics = append_string(diagnostics, "llvm lowering: enum `" + enum_def.name + "` missing layout metadata; skipping type emission")
            enum_index += 1
            continue
        enum_layout = enum_def.layout
        sanitized_enum = sanitize_symbol(enum_def.name)
        llvm_enum_name = "%" + sanitized_enum
        variants = []
        variant_index = 0
        while True:
            if variant_index >= len(enum_layout.variants):
                break
            variant_layout = enum_layout.variants[variant_index]
            variant_fields = []
            variant_field_index = 0
            while True:
                if variant_field_index >= len(variant_layout.fields):
                    break
                variant_field = variant_layout.fields[variant_field_index]
                mapped_variant_type = map_struct_field_annotation(variant_field.type_annotation)
                llvm_variant_field_type = mapped_variant_type
                if len(llvm_variant_field_type) == 0:
                    diagnostics = append_string(diagnostics, "llvm lowering: enum `" + enum_def.name + "` variant `" + variant_layout.name + "` field `" + variant_field.name + "` uses unsupported type `" + variant_field.type_annotation + "`; lowering as `i8*`")
                    llvm_variant_field_type = "i8*"
                else:
                    if ends_with_pointer_suffix(llvm_variant_field_type):
                        variant_base_type = layout_annotation_base_type(variant_field.type_annotation)
                        references_declaring_enum = variant_base_type == enum_def.name
                        if layout_annotation_represents_user_value(variant_field.type_annotation)  and  not references_declaring_enum:
                            stripped_variant = strip_pointer_suffix(llvm_variant_field_type)
                            if len(stripped_variant) > 0:
                                llvm_variant_field_type = stripped_variant
                variant_fields = append_struct_field_info(variant_fields, StructFieldInfo(name=variant_field.name, llvm_type=llvm_variant_field_type, type_annotation=variant_field.type_annotation, index=variant_field_index, offset=variant_field.offset))
                variant_field_index += 1
            variants = append_enum_variant_info(variants, EnumVariantInfo(name=variant_layout.name, tag=variant_layout.tag, offset=variant_layout.offset, size=variant_layout.size, align=variant_layout.align, fields=variant_fields))
            variant_index += 1
        enum_align_value = enum_layout.align
        if enum_align_value <= 0:
            enum_align_value = 1
        max_payload_size = 0
        payload_scan = 0
        while True:
            if payload_scan >= len(variants):
                break
            variant = variants[payload_scan]
            if variant.size > max_payload_size:
                max_payload_size = variant.size
            payload_scan += 1
        enum_entries = append_enum_type_info(enum_entries, EnumTypeInfo(name=enum_def.name, llvm_name=llvm_enum_name, tag_type=enum_layout.tag_type, tag_size=enum_layout.tag_size, tag_align=enum_layout.tag_align, max_payload_size=max_payload_size, size=enum_layout.size, align=enum_align_value, variants=variants))
        enum_index += 1
    interface_entries = []
    interface_index = 0
    while True:
        if interface_index >= len(interfaces):
            break
        interface_def = interfaces[interface_index]
        sanitized_interface = sanitize_symbol(interface_def.name)
        llvm_interface_name = "%trait." + sanitized_interface
        interface_entries = append_interface_type_info(interface_entries, InterfaceTypeInfo(name=interface_def.name, llvm_name=llvm_interface_name, type_parameters=interface_def.type_parameters, signatures=interface_def.signatures))
        interface_index += 1
    vtable_entries = []
    struct_vtable_index = 0
    while True:
        if struct_vtable_index >= len(structs):
            break
        struct_def = structs[struct_vtable_index]
        implements_index = 0
        while True:
            if implements_index >= len(struct_def.implements):
                break
            interface_name = struct_def.implements[implements_index]
            interface_def_opt = None
            search_idx = 0
            while True:
                if search_idx >= len(interfaces):
                    break
                if interfaces[search_idx].name == interface_name:
                    interface_def_opt = interfaces[search_idx]
                    break
                search_idx += 1
            if interface_def_opt == None:
                diagnostics = append_string(diagnostics, "llvm lowering: struct `" + struct_def.name + "` implements unknown interface `" + interface_name + "`")
                implements_index += 1
                continue
            interface_def = interface_def_opt
            sanitized_struct = sanitize_symbol(struct_def.name)
            sanitized_iface = sanitize_symbol(interface_name)
            vtable_type_name = "%vtable." + sanitized_struct + "." + sanitized_iface
            vtable_global_name = "@vtable." + sanitized_struct + "." + sanitized_iface + ".const"
            vtable_method_entries = []
            sig_index = 0
            while True:
                if sig_index >= len(interface_def.signatures):
                    break
                signature = interface_def.signatures[sig_index]
                param_types = ["i8*"]
                param_idx = 1
                while True:
                    if param_idx >= len(signature.parameters):
                        break
                    param = signature.parameters[param_idx]
                    mapped_type = map_type_annotation(param.type_annotation)
                    param_types = append_string(param_types, mapped_type)
                    param_idx += 1
                return_type = map_type_annotation(signature.return_type)
                func_ptr_type = return_type + " (" + join_with_separator(param_types, ", ") + ")*"
                vtable_method_entries = append_vtable_entry(vtable_method_entries, VTableEntry(method_name=struct_def.name + "::" + signature.name, interface_method_name=signature.name, function_pointer_type=func_ptr_type))
                sig_index += 1
            vtable_entries = append_vtable_info(vtable_entries, VTableInfo(struct_name=struct_def.name, interface_name=interface_name, llvm_type_name=vtable_type_name, llvm_global_name=vtable_global_name, entries=vtable_method_entries))
            implements_index += 1
        interface_scan = 0
        while True:
            if interface_scan >= len(interfaces):
                break
            interface_def = interfaces[interface_scan]
            if not struct_declares_interface(struct_def, interface_def.name):
                if struct_satisfies_interface_structurally(struct_def, interface_def):
                    interface_name = interface_def.name
                    sanitized_struct = sanitize_symbol(struct_def.name)
                    sanitized_iface = sanitize_symbol(interface_name)
                    vtable_type_name = "%vtable." + sanitized_struct + "." + sanitized_iface
                    vtable_global_name = "@vtable." + sanitized_struct + "." + sanitized_iface + ".const"
                    vtable_method_entries = []
                    sig_index = 0
                    while True:
                        if sig_index >= len(interface_def.signatures):
                            break
                        signature = interface_def.signatures[sig_index]
                        param_types = ["i8*"]
                        param_idx = 1
                        while True:
                            if param_idx >= len(signature.parameters):
                                break
                            param = signature.parameters[param_idx]
                            mapped_type = map_type_annotation(param.type_annotation)
                            param_types = append_string(param_types, mapped_type)
                            param_idx += 1
                        return_type = map_type_annotation(signature.return_type)
                        func_ptr_type = return_type + " (" + join_with_separator(param_types, ", ") + ")*"
                        vtable_method_entries = append_vtable_entry(vtable_method_entries, VTableEntry(method_name=struct_def.name + "::" + signature.name, interface_method_name=signature.name, function_pointer_type=func_ptr_type))
                        sig_index += 1
                    vtable_entries = append_vtable_info(vtable_entries, VTableInfo(struct_name=struct_def.name, interface_name=interface_name, llvm_type_name=vtable_type_name, llvm_global_name=vtable_global_name, entries=vtable_method_entries))
            interface_scan += 1
        struct_vtable_index += 1
    return TypeContextBuild(context=TypeContext(structs=struct_entries, enums=enum_entries, interfaces=interface_entries, vtables=vtable_entries), diagnostics=diagnostics)

def append_struct_type_info(values, value):
    return (values) + ([value])

def append_struct_field_info(values, value):
    return (values) + ([value])

def append_enum_variant_info(values, value):
    return (values) + ([value])

def append_enum_type_info(values, value):
    return (values) + ([value])

def append_interface_type_info(values, value):
    return (values) + ([value])

def append_vtable_info(values, value):
    return (values) + ([value])

def append_vtable_entry(values, value):
    return (values) + ([value])

def struct_declares_interface(struct_def, interface_name):
    index = 0
    while True:
        if index >= len(struct_def.implements):
            break
        if struct_def.implements[index] == interface_name:
            return True
        index += 1
    return False

def find_struct_method(struct_def, method_name):
    index = 0
    while True:
        if index >= len(struct_def.methods):
            break
        method = struct_def.methods[index]
        if method.name == method_name:
            return method
        index += 1
    return None

def struct_satisfies_interface_structurally(struct_def, interface_def):
    sig_index = 0
    while True:
        if sig_index >= len(interface_def.signatures):
            break
        signature = interface_def.signatures[sig_index]
        method = find_struct_method(struct_def, signature.name)
        if method == None:
            return False
        if len(method.parameters) != len(signature.parameters):
            return False
        sig_return = map_type_annotation(signature.return_type)
        method_return = map_type_annotation(method.return_type)
        if sig_return != method_return:
            return False
        param_index = 1
        while True:
            if param_index >= len(signature.parameters):
                break
            sig_param = signature.parameters[param_index]
            method_param = method.parameters[param_index]
            sig_ty = map_type_annotation(sig_param.type_annotation)
            method_ty = map_type_annotation(method_param.type_annotation)
            if sig_ty != method_ty:
                return False
            param_index += 1
        sig_index += 1
    return True

def append_native_function(values, value):
    return (values) + ([value])

def concat_native_functions(first, second):
    result = first
    index = 0
    while True:
        if index >= len(second):
            break
        result = append_native_function(result, second[index])
        index += 1
    return result

def flatten_struct_methods(structs):
    result = []
    index = 0
    while True:
        if index >= len(structs):
            break
        definition = structs[index]
        method_index = 0
        while True:
            if method_index >= len(definition.methods):
                break
            method = definition.methods[method_index]
            qualified_name = definition.name + "::" + method.name
            qualified = NativeFunction(name=qualified_name, is_async=method.is_async, parameters=method.parameters, return_type=method.return_type, effects=method.effects, decorators=method.decorators, instructions=method.instructions, is_extern=False)
            result = append_native_function(result, qualified)
            method_index += 1
        index += 1
    return result

def load_imported_layout_manifests(imports):
    # effects: io
    context = collect_imported_module_context(imports)
    return context.manifests

def collect_imported_module_context(imports):
    # effects: io
    manifests = []
    native_texts = []
    diagnostics = []
    seen = []
    index = 0
    while True:
        if index >= len(imports):
            break
        module_path = imports[index].module
        slug = resolve_import_module_slug(module_path)
        if len(slug) == 0:
            index += 1
            continue
        if string_array_contains(seen, slug):
            index += 1
            continue
        seen = append_string(seen, slug)
        manifest_path = layout_manifest_path_for_slug(slug)
        native_text_path = native_text_path_for_slug(slug)
        manifest_structs = []
        manifest_enums = []
        if fs.exists(manifest_path):
            manifest_contents = fs.readFile(manifest_path)
            parsed_manifest = parse_layout_manifest(manifest_contents)
            manifest_structs = parsed_manifest.structs
            manifest_enums = parsed_manifest.enums
        else:
            diagnostics = (diagnostics) + (["layout manifest: missing artifact for import `" + module_path + "` (expected " + manifest_path + ")"])
        native_text = ""
        if fs.exists(native_text_path):
            native_text = fs.readFile(native_text_path)
        else:
            diagnostics = (diagnostics) + (["native lowering: missing native text artifact for import `" + module_path + "` (expected " + native_text_path + ")"])
        manifests = (manifests) + ([LayoutManifest(structs=manifest_structs, enums=manifest_enums, diagnostics=[])])
        native_texts = (native_texts) + ([native_text])
        index += 1
    return ImportedModuleContext(manifests=manifests, native_texts=native_texts, diagnostics=diagnostics)

def resolve_import_module_slug(module):
    trimmed = trim_text(module)
    if len(trimmed) == 0:
        return ""
    normalized = normalize_import_module_path(trimmed)
    parts = []
    segment = ""
    index = 0
    while True:
        if index >= len(normalized):
            break
        ch = normalized[index]
        if ch == "/":
            if len(segment) > 0:
                parts = append_string(parts, segment)
            segment = ""
        else:
            segment = segment + ch
        index += 1
    if len(segment) > 0:
        parts = append_string(parts, segment)
    resolved = []
    index = 0
    while True:
        if index >= len(parts):
            break
        part = parts[index]
        if len(part) == 0  or  part == ".":
            index += 1
            continue
        if part == "..":
            if len(resolved) > 0:
                shortened = []
                drop_index = 0
                limit = len(resolved) - 1
                while True:
                    if drop_index >= limit:
                        break
                    shortened = append_string(shortened, resolved[drop_index])
                    drop_index += 1
                resolved = shortened
            index += 1
            continue
        resolved = append_string(resolved, part)
        index += 1
    slug = join_with_separator(resolved, "/")
    if starts_with(slug, "src/"):
        slug = substring(slug, 4, len(slug))
    if starts_with(slug, "compiler/src/"):
        slug = substring(slug, 13, len(slug))
    return slug

def layout_manifest_path_for_slug(slug):
    return "build/stage2/" + slug + ".layout-manifest"

def native_text_path_for_slug(slug):
    return "build/stage2/" + slug + ".sfn-asm"

def normalize_import_module_path(value):
    result = ""
    index = 0
    while True:
        if index >= len(value):
            break
        ch = value[index]
        if ch == "\\":
            result = result + "/"
        else:
            result = result + ch
        index += 1
    return result

def replace_native_struct(values, index, value):
    result = []
    current = 0
    while True:
        if current >= len(values):
            break
        if current == index:
            result = append_native_struct(result, value)
        else:
            result = append_native_struct(result, values[current])
        current += 1
    return result

def replace_native_enum(values, index, value):
    result = []
    current = 0
    while True:
        if current >= len(values):
            break
        if current == index:
            result = append_native_enum(result, value)
        else:
            result = append_native_enum(result, values[current])
        current += 1
    return result

def find_struct_index(structs, name):
    index = 0
    while True:
        if index >= len(structs):
            break
        if structs[index].name == name:
            return index
        index += 1
    return -1

def find_enum_index(enums, name):
    index = 0
    while True:
        if index >= len(enums):
            break
        if enums[index].name == name:
            return index
        index += 1
    return -1

def apply_layout_manifest_to_module(structs, enums, manifest):
    if manifest == None:
        return LayoutManifestApplication(structs=structs, enums=enums, diagnostics=[])
    return apply_layout_manifest_entries(structs, enums, manifest)

def apply_layout_manifest_entries(structs, enums, manifest):
    diagnostics = []
    updated_structs = structs
    struct_index = 0
    while True:
        if struct_index >= len(manifest.structs):
            break
        layout_struct = manifest.structs[struct_index]
        target_index = find_struct_index(updated_structs, layout_struct.name)
        if target_index < 0:
            diagnostics = append_string(diagnostics, "layout manifest: struct `" + layout_struct.name + "` missing from native module")
        else:
            target = updated_structs[target_index]
            replaced = NativeStruct(name=target.name, fields=target.fields, methods=target.methods, implements=target.implements, layout=layout_struct.layout)
            updated_structs = replace_native_struct(updated_structs, target_index, replaced)
        struct_index += 1
    updated_enums = enums
    enum_index = 0
    while True:
        if enum_index >= len(manifest.enums):
            break
        layout_enum = manifest.enums[enum_index]
        target_index = find_enum_index(updated_enums, layout_enum.name)
        if target_index < 0:
            diagnostics = append_string(diagnostics, "layout manifest: enum `" + layout_enum.name + "` missing from native module")
        else:
            target = updated_enums[target_index]
            replaced = NativeEnum(name=target.name, variants=target.variants, layout=layout_enum.layout)
            updated_enums = replace_native_enum(updated_enums, target_index, replaced)
        enum_index += 1
    return LayoutManifestApplication(structs=updated_structs, enums=updated_enums, diagnostics=diagnostics)

def lower_to_llvm(native_module):
    # effects: io
    artifact = select_text_artifact(native_module.artifacts)
    if artifact == None:
        return lower_to_llvm_with_context(native_module, [], [], [])
    parse = parse_native_artifact(artifact.contents)
    import_context = collect_imported_module_context(parse.imports)
    return lower_to_llvm_with_context(native_module, import_context.manifests, import_context.native_texts, import_context.diagnostics)

def lower_to_llvm_for_tests(native_module):
    # effects: io
    artifact = select_text_artifact(native_module.artifacts)
    if artifact == None:
        return lower_to_llvm_with_context_for_tests(native_module, [], [], [])
    parse = parse_native_artifact(artifact.contents)
    import_context = collect_imported_module_context(parse.imports)
    return lower_to_llvm_with_context_for_tests(native_module, import_context.manifests, import_context.native_texts, import_context.diagnostics)

def lower_to_llvm_with_manifests(native_module, imported_manifests):
    return lower_to_llvm_with_context(native_module, imported_manifests, [], [])

def lower_to_llvm_with_context_for_tests(native_module, imported_manifests, imported_native_texts, imported_diagnostics):
    base = lower_to_llvm_with_context(native_module, imported_manifests, imported_native_texts, imported_diagnostics)
    if len(base.ir) == 0:
        return base
    artifact = select_text_artifact(native_module.artifacts)
    if artifact == None:
        return base
    parse = parse_native_artifact(artifact.contents)
    tests = []
    has_main = False
    index = 0
    while True:
        if index >= len(parse.functions):
            break
        fun = parse.functions[index]
        if fun.name == "main":
            has_main = True
        if len(fun.name) >= 5  and  substring(fun.name, 0, 5) == "test:":
            tests = (tests) + ([fun])
        index += 1
    if len(tests) == 0:
        return base
    if has_main:
        updated = base
        updated.diagnostics = (updated.diagnostics) + (["llvm lowering (test): module defines `main`; skipping synthesized test harness"])
        return updated
    harness = render_test_harness_main(tests)
    updated = base
    if len(updated.ir) > 0:
        updated.ir = updated.ir + "\n"
    updated.ir = updated.ir + join_with_separator(harness, "\n") + "\n"
    return updated

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

def lower_to_llvm_with_context(native_module, imported_manifests, imported_native_texts, imported_diagnostics):
    diagnostics = []
    if len(imported_diagnostics) > 0:
        diagnostics = (diagnostics) + (imported_diagnostics)
    artifact = select_text_artifact(native_module.artifacts)
    if artifact == None:
        diagnostics = append_string(diagnostics, "no sailfin-native-text artifact present")
        empty_constants = empty_string_constant_set()
        return LoweredLLVMResult(ir="", diagnostics=diagnostics, trait_metadata=empty_trait_metadata(), function_effects=[], lifetime_regions=[], capability_manifest=empty_capability_manifest(), string_constants=empty_constants)
    parse = parse_native_artifact(artifact.contents)
    diagnostics = (diagnostics) + (parse.diagnostics)
    exported_symbols = collect_exported_symbol_names(parse.imports)
    manifest_artifact = select_layout_manifest_artifact(native_module.artifacts)
    module_manifest = None
    if manifest_artifact != None:
        parsed_manifest = parse_layout_manifest(manifest_artifact.contents)
        diagnostics = (diagnostics) + (parsed_manifest.diagnostics)
        module_manifest = parsed_manifest
    manifest_application = apply_layout_manifest_to_module(parse.structs, parse.enums, module_manifest)
    diagnostics = (diagnostics) + (manifest_application.diagnostics)
    module_structs = manifest_application.structs
    module_enums = manifest_application.enums
    imported_structs = []
    imported_enums = []
    imported_interfaces = []
    imported_functions = []
    imported_struct_methods = []
    manifest_count = len(imported_manifests)
    text_index = 0
    while True:
        if text_index >= len(imported_native_texts):
            break
        native_text = imported_native_texts[text_index]
        manifest_for_module = None
        if text_index < manifest_count:
            candidate_manifest = imported_manifests[text_index]
            manifest_for_module = candidate_manifest
        if len(native_text) == 0:
            if manifest_for_module != None:
                manifest_only = manifest_for_module
                imported_structs = (imported_structs) + (manifest_only.structs)
                imported_enums = (imported_enums) + (manifest_only.enums)
            text_index += 1
            continue
        imported_parse = parse_native_artifact(native_text)
        applied_import = apply_layout_manifest_to_module(imported_parse.structs, imported_parse.enums, manifest_for_module)
        imported_structs = (imported_structs) + (applied_import.structs)
        imported_enums = (imported_enums) + (applied_import.enums)
        imported_interfaces = (imported_interfaces) + (imported_parse.interfaces)
        imported_functions = (imported_functions) + (imported_parse.functions)
        imported_methods = flatten_struct_methods(applied_import.structs)
        imported_struct_methods = (imported_struct_methods) + (imported_methods)
        text_index += 1
    if len(imported_native_texts) < manifest_count:
        manifest_index = len(imported_native_texts)
        while True:
            if manifest_index >= manifest_count:
                break
            leftover_manifest = imported_manifests[manifest_index]
            imported_structs = (imported_structs) + (leftover_manifest.structs)
            imported_enums = (imported_enums) + (leftover_manifest.enums)
            manifest_index += 1
    combined_structs = (module_structs) + (imported_structs)
    combined_enums = (module_enums) + (imported_enums)
    combined_interfaces = (parse.interfaces) + (imported_interfaces)
    trait_metadata = build_trait_metadata(combined_interfaces, combined_structs)
    fixed_enums = fixup_enum_layouts(combined_enums)
    diagnostics = (diagnostics) + (fixed_enums.diagnostics)
    type_build = build_type_context(combined_structs, fixed_enums.enums, combined_interfaces)
    diagnostics = (diagnostics) + (type_build.diagnostics)
    type_context = type_build.context
    module_struct_methods = flatten_struct_methods(module_structs)
    local_functions = concat_native_functions(parse.functions, module_struct_methods)
    context_functions = concat_native_functions(local_functions, imported_functions)
    context_functions = concat_native_functions(context_functions, imported_struct_methods)
    runtime_helpers = collect_runtime_helper_targets(local_functions)
    runtime_helpers = append_unique_effect(runtime_helpers, "get_field")
    runtime_helpers = append_unique_effect(runtime_helpers, "string.concat")
    runtime_helpers = append_unique_effect(runtime_helpers, "number.to_string")
    runtime_helpers = append_unique_effect(runtime_helpers, "strings_equal")
    runtime_helpers = append_unique_effect(runtime_helpers, "runtime.bounds_check")
    runtime_helpers = append_unique_effect(runtime_helpers, "mark_persistent")
    direct_effects = collect_direct_function_effects(context_functions)
    call_graph = collect_function_call_graph(context_functions)
    aggregated_effects = propagate_function_effects(direct_effects, call_graph)
    function_effects = []
    lifetime_regions = []
    lines = []
    lines = append_string(lines, "source_filename = \"" + module_source_filename(native_module.module_name) + "\"")
    lines = append_string(lines, "")
    trait_lines = render_trait_metadata_comments(trait_metadata)
    if len(trait_lines) > 0:
        lines = (lines) + (trait_lines)
        lines = append_string(lines, "")
    struct_type_lines = render_struct_type_definitions(type_context, context_functions)
    if len(struct_type_lines) > 0:
        lines = (lines) + (struct_type_lines)
        lines = append_string(lines, "")
    enum_type_lines = render_enum_type_definitions(type_context)
    if len(enum_type_lines) > 0:
        lines = (lines) + (enum_type_lines)
        lines = append_string(lines, "")
    interface_type_lines = render_interface_type_definitions(type_context)
    if len(interface_type_lines) > 0:
        lines = (lines) + (interface_type_lines)
        lines = append_string(lines, "")
    lines = (lines) + (["%SailfinFutureNumber = type opaque", "%SailfinFutureBool = type opaque", "%SailfinFuturePtr = type opaque", "%SailfinFutureVoid = type opaque", "%SailfinFutureString = type opaque", "", "declare %SailfinFutureNumber* @sailfin_runtime_spawn_number(double ()*)", "declare %SailfinFutureNumber* @sailfin_runtime_spawn_number_ctx(double (i8*)*, i8*)", "declare double @sailfin_runtime_await_number(%SailfinFutureNumber*)", "declare %SailfinFutureBool* @sailfin_runtime_spawn_bool(i1 ()*)", "declare %SailfinFutureBool* @sailfin_runtime_spawn_bool_ctx(i1 (i8*)*, i8*)", "declare i1 @sailfin_runtime_await_bool(%SailfinFutureBool*)", "declare %SailfinFuturePtr* @sailfin_runtime_spawn_ptr(i8* ()*)", "declare %SailfinFuturePtr* @sailfin_runtime_spawn_ptr_ctx(i8* (i8*)*, i8*)", "declare i8* @sailfin_runtime_await_ptr(%SailfinFuturePtr*)", "declare %SailfinFutureVoid* @sailfin_runtime_spawn_void(void ()*)", "declare %SailfinFutureVoid* @sailfin_runtime_spawn_void_ctx(void (i8*)*, i8*)", "declare void @sailfin_runtime_await_void(%SailfinFutureVoid*)", "declare %SailfinFutureString* @sailfin_runtime_spawn_string(i8* ()*)", "declare %SailfinFutureString* @sailfin_runtime_spawn_string_ctx(i8* (i8*)*, i8*)", "declare i8* @sailfin_runtime_await_string(%SailfinFutureString*)", ""])
    vtable_type_lines = render_vtable_type_definitions(type_context)
    if len(vtable_type_lines) > 0:
        lines = (lines) + (vtable_type_lines)
        lines = append_string(lines, "")
    vtable_const_lines = render_vtable_constants(type_context)
    if len(vtable_const_lines) > 0:
        lines = (lines) + (vtable_const_lines)
        lines = append_string(lines, "")
    helper_declarations = render_runtime_helper_declarations(runtime_helpers, local_functions)
    if len(helper_declarations) > 0:
        lines = (lines) + (helper_declarations)
        lines = append_string(lines, "")
    imported_declarations = render_imported_function_declarations(imported_functions, local_functions, type_context)
    if len(imported_declarations) > 0:
        lines = (lines) + (imported_declarations)
        lines = append_string(lines, "")
    if find_function_by_name(context_functions, "malloc") == None:
        lines = append_string(lines, "declare noalias i8* @malloc(i64)")
    if find_function_by_name(context_functions, "free") == None:
        lines = append_string(lines, "declare void @free(i8*)")
    lines = append_string(lines, "")
    lines = append_string(lines, "@runtime = external global i8**")
    lines = append_string(lines, "")
    module_globals = lower_module_bindings_to_globals(parse.bindings, type_context, native_module.module_name)
    diagnostics = (diagnostics) + (module_globals.diagnostics)
    if len(module_globals.preamble_lines) > 0:
        lines = (lines) + (module_globals.preamble_lines)
        lines = append_string(lines, "")
    preamble_lines = lines
    function_lines = []
    if len(module_globals.init_function_lines) > 0:
        function_lines = (function_lines) + (module_globals.init_function_lines)
        function_lines = append_string(function_lines, "")
    index = 0
    has_add_function = False
    all_string_constants = module_globals.string_constants
    while True:
        if index >= len(local_functions):
            break
        current_function = local_functions[index]
        aggregated_entry = find_function_effect_entry(aggregated_effects, current_function.name)
        effective_effects = []
        if aggregated_entry != None:
            effective_effects = aggregated_entry.effects
        function_effects = append_function_effect_entry(function_effects, FunctionEffectEntry(name=current_function.name, effects=effective_effects))
        lowered = emit_function(current_function, context_functions, effective_effects, type_context, native_module.module_name, native_module.entry_points, exported_symbols, imported_functions, module_globals.locals, module_globals.init_function_symbol, module_globals.needs_init_call)
        if sanitize_symbol(current_function.name) == "add":
            has_add_function = True
        diagnostics = (diagnostics) + (lowered.diagnostics)
        lifetime_regions = (lifetime_regions) + (lowered.lifetime_regions)
        all_string_constants = merge_string_constants(all_string_constants, lowered.string_constants)
        if len(lowered.lines) > 0:
            function_lines = (function_lines) + (lowered.lines)
            if index + 1 < len(local_functions):
                function_lines = append_string(function_lines, "")
        index += 1
    if not has_add_function:
        if len(function_lines) > 0:
            function_lines = append_string(function_lines, "")
        function_lines = (function_lines) + (["define internal double @add(double %a, double %b) {", "entry:", "  %t0 = fadd double %a, %b", "  ret double %t0", "}"])
    string_constant_lines = render_string_constants(all_string_constants)
    final_lines = preamble_lines
    if len(string_constant_lines) > 0:
        final_lines = (final_lines) + (string_constant_lines)
        final_lines = append_string(final_lines, "")
    final_lines = (final_lines) + (function_lines)
    final_lines = ensure_intrinsic_declarations(final_lines)
    ir = join_with_separator(final_lines, "\n")
    manifest = build_capability_manifest(native_module.entry_points, function_effects)
    output = ir
    if len(output) > 0:
        output = output + "\n"
    return LoweredLLVMResult(ir=output, diagnostics=diagnostics, trait_metadata=trait_metadata, function_effects=function_effects, lifetime_regions=lifetime_regions, capability_manifest=manifest, string_constants=all_string_constants)

def module_source_filename(module_name):
    if len(module_name) == 0:
        return "sailfin"
    if len(module_name) >= 4:
        suffix = substring(module_name, len(module_name) - 4, len(module_name))
        if suffix == ".sfn":
            return module_name
    return module_name + ".sfn"

def ensure_intrinsic_declarations(lines):
    uses_round = False
    has_round_decl = False
    index = 0
    while True:
        if index >= len(lines):
            break
        line = lines[index]
        if index_of(line, "call double @round(") >= 0:
            uses_round = True
        trimmed = trim_text(line)
        if starts_with(trimmed, "declare double @round(double)"):
            has_round_decl = True
        index += 1
    if not uses_round  or  has_round_decl:
        return lines
    return insert_string_at(lines, 1, "declare double @round(double)")

def insert_string_at(values, insert_index, value):
    out = []
    index = 0
    while True:
        if index >= len(values):
            break
        if index == insert_index:
            out = append_string(out, value)
        out = append_string(out, values[index])
        index += 1
    if insert_index >= len(values):
        out = append_string(out, value)
    return out

def collect_direct_function_effects(functions):
    entries = []
    index = 0
    while True:
        if index >= len(functions):
            break
        entry = collect_function_effect_entry(functions[index])
        entries = append_function_effect_entry(entries, entry)
        index += 1
    return entries

def collect_function_call_graph(functions):
    entries = []
    function_names = collect_function_names(functions)
    index = 0
    while True:
        if index >= len(functions):
            break
        call_entry = collect_function_call_entry(functions[index], function_names)
        entries = append_function_call_entry(entries, call_entry)
        index += 1
    return entries

def collect_function_call_entry(function, function_names):
    callees = []
    index = 0
    while True:
        if index >= len(function.instructions):
            break
        instruction = function.instructions[index]
        callees = merge_effect_lists(callees, collect_instruction_calls(instruction, function_names))
        index += 1
    return FunctionCallEntry(name=function.name, callees=callees)

def collect_runtime_helper_targets(functions):
    used = []
    index = 0
    while True:
        if index >= len(functions):
            break
        helpers = collect_function_runtime_helper_targets(functions[index])
        used = merge_effect_lists(used, helpers)
        index += 1
    return used

def collect_function_runtime_helper_targets(function):
    used = []
    decorator_index = 0
    while True:
        if decorator_index >= len(function.decorators):
            break
        decorator_name = function.decorators[decorator_index]
        if matches_case_insensitive(decorator_name, "logExecution")  or  matches_case_insensitive(decorator_name, "logexecution")  or  matches_case_insensitive(decorator_name, "trace"):
            used = append_unique_effect(used, "runtime_log_execution_fn")
        decorator_index += 1
    index = 0
    while True:
        if index >= len(function.instructions):
            break
        instruction = function.instructions[index]
        instruction_helpers = collect_instruction_runtime_helper_targets(instruction)
        used = merge_effect_lists(used, instruction_helpers)
        index += 1
    return used

def collect_instruction_runtime_helper_targets(instruction):
    if instruction.variant == "Let":
        if instruction.value != None:
            helpers = filter_runtime_helper_targets(extract_all_call_targets(instruction.value))
            helpers = merge_effect_lists(helpers, collect_runtime_property_targets(instruction.value))
            return helpers
        return []
    if instruction.variant == "Expression":
        helpers = filter_runtime_helper_targets(extract_all_call_targets(instruction.expression))
        helpers = merge_effect_lists(helpers, collect_runtime_property_targets(instruction.expression))
        return helpers
    if instruction.variant == "Return":
        trimmed = trim_text(instruction.expression)
        if len(trimmed) > 0:
            helpers = filter_runtime_helper_targets(extract_all_call_targets(trimmed))
            helpers = merge_effect_lists(helpers, collect_runtime_property_targets(trimmed))
            return helpers
        return []
    if instruction.variant == "If":
        helpers = filter_runtime_helper_targets(extract_all_call_targets(instruction.condition))
        helpers = merge_effect_lists(helpers, collect_runtime_property_targets(instruction.condition))
        return helpers
    if instruction.variant == "For":
        helpers = filter_runtime_helper_targets(extract_all_call_targets(instruction.iterable))
        helpers = merge_effect_lists(helpers, collect_runtime_property_targets(instruction.iterable))
        return helpers
    if instruction.variant == "Match":
        helpers = filter_runtime_helper_targets(extract_all_call_targets(instruction.expression))
        helpers = merge_effect_lists(helpers, collect_runtime_property_targets(instruction.expression))
        return helpers
    if instruction.variant == "Case":
        helpers = filter_runtime_helper_targets(extract_all_call_targets(instruction.pattern))
        helpers = merge_effect_lists(helpers, collect_runtime_property_targets(instruction.pattern))
        if instruction.guard != None:
            guard_targets = filter_runtime_helper_targets(extract_all_call_targets(instruction.guard))
            combined = merge_effect_lists(helpers, guard_targets)
            combined = merge_effect_lists(combined, collect_runtime_property_targets(instruction.guard))
            return combined
        return helpers
    if instruction.variant == "Try":
        return ["clear_exception", "has_exception", "take_exception"]
    if instruction.variant == "Throw":
        return ["set_exception"]
    return []

def collect_instruction_calls(instruction, function_names):
    callees = []
    if instruction.variant == "Let":
        if instruction.value != None:
            callees = merge_effect_lists(callees, extract_call_targets(instruction.value, function_names))
        return callees
    if instruction.variant == "Expression":
        callees = merge_effect_lists(callees, extract_call_targets(instruction.expression, function_names))
        return callees
    if instruction.variant == "Return":
        trimmed = trim_text(instruction.expression)
        if len(trimmed) > 0:
            callees = merge_effect_lists(callees, extract_call_targets(trimmed, function_names))
        return callees
    if instruction.variant == "If":
        callees = merge_effect_lists(callees, extract_call_targets(instruction.condition, function_names))
        return callees
    if instruction.variant == "For":
        callees = merge_effect_lists(callees, extract_call_targets(instruction.iterable, function_names))
        return callees
    if instruction.variant == "Match":
        callees = merge_effect_lists(callees, extract_call_targets(instruction.expression, function_names))
        return callees
    if instruction.variant == "Case":
        callees = merge_effect_lists(callees, extract_call_targets(instruction.pattern, function_names))
        if instruction.guard != None:
            callees = merge_effect_lists(callees, extract_call_targets(instruction.guard, function_names))
        return callees
    return callees

def collect_function_names(functions):
    names = []
    index = 0
    while True:
        if index >= len(functions):
            break
        names = append_string(names, functions[index].name)
        index += 1
    return names

def extract_call_targets(expression, function_names):
    results = []
    expression_len = len(expression)
    if expression_len == 0:
        return results
    index = 0
    while True:
        if index >= expression_len:
            break
        ch = expression[index]
        if ch == "\"":
            index = skip_string_literal(expression, index + 1)
            continue
        if is_identifier_start_char(ch):
            start_index = index
            index += 1
            while True:
                if index >= expression_len:
                    break
                current = expression[index]
                if is_identifier_part_char(current):
                    index += 1
                    continue
                if current == ".":
                    index += 1
                    continue
                break
            candidate = substring(expression, start_index, index)
            if len(candidate) > 0:
                while True:
                    dot_index = index_of(candidate, ".")
                    if dot_index == -1:
                        break
                    candidate = substring(candidate, dot_index + 1, len(candidate))
                cursor = index
                while True:
                    if cursor >= expression_len:
                        break
                    next = expression[cursor]
                    if is_trim_char(next):
                        cursor += 1
                        continue
                    if next == "(":
                        if string_array_contains(function_names, candidate):
                            results = append_unique_effect(results, candidate)
                    break
            continue
        index += 1
    return results

def extract_all_call_targets(expression):
    results = []
    expression_len = len(expression)
    if expression_len == 0:
        return results
    index = 0
    while True:
        if index >= expression_len:
            break
        ch = expression[index]
        if ch == "\"":
            index = skip_string_literal(expression, index + 1)
            continue
        if is_identifier_start_char(ch):
            start_index = index
            index += 1
            while True:
                if index >= expression_len:
                    break
                current = expression[index]
                if is_identifier_part_char(current):
                    index += 1
                    continue
                if current == "."  or  current == ":":
                    index += 1
                    continue
                break
            candidate = substring(expression, start_index, index)
            if len(candidate) > 0:
                cursor = index
                while True:
                    if cursor >= expression_len:
                        break
                    next = expression[cursor]
                    if is_trim_char(next):
                        cursor += 1
                        continue
                    if next == "(":
                        results = append_unique_effect(results, candidate)
                    break
            continue
        index += 1
    return results

def filter_runtime_helper_targets(targets):
    results = []
    index = 0
    while True:
        if index >= len(targets):
            break
        trimmed = trim_text(targets[index])
        helper = find_runtime_helper(trimmed)
        if helper == None:
            dot_index = find_last_index_of_char(trimmed, ".")
            if dot_index >= 0  and  dot_index + 1 < len(trimmed):
                suffix = substring(trimmed, dot_index + 1, len(trimmed))
                helper = find_runtime_helper(suffix)
        if helper == None:
            colon_index = find_last_index_of_char(trimmed, ":")
            if colon_index >= 0  and  colon_index + 1 < len(trimmed):
                suffix = substring(trimmed, colon_index + 1, len(trimmed))
                helper = find_runtime_helper(suffix)
        if helper == None:
            length_suffix = ".length"
            if len(trimmed) >= len(length_suffix):
                maybe_length = substring(trimmed, len(trimmed) - len(length_suffix), len(trimmed))
                if maybe_length == length_suffix:
                    helper = find_runtime_helper("len(string)")
                    if helper == None:
                        helper = find_runtime_helper("len(string)")
            if helper == None:
                concat_suffix = ".concat"
                if len(trimmed) >= len(concat_suffix):
                    maybe_concat = substring(trimmed, len(trimmed) - len(concat_suffix), len(trimmed))
                    if maybe_concat == concat_suffix:
                        helper = find_runtime_helper("concat")
        if helper != None:
            results = append_unique_effect(results, helper.target)
        index += 1
    return results

def collect_runtime_property_targets(expression):
    trimmed = trim_text(expression)
    if len(trimmed) == 0:
        return []
    results = []
    if contains_dot_property(trimmed, "length"):
        results = append_unique_effect(results, "len(string)")
    return results

def contains_dot_property(expression, name):
    suffix = "." + name
    suffix_length = len(suffix)
    if suffix_length == 0  or  len(expression) < suffix_length:
        return False
    index = 0
    in_single = False
    in_double = False
    escape_next = False
    while True:
        if index >= len(expression):
            break
        ch = expression[index]
        if in_double:
            if escape_next:
                escape_next = False
            else:
                if ch == "\\":
                    escape_next = True
                else:
                    if ch == "\"":
                        in_double = False
            index += 1
            continue
        if in_single:
            if escape_next:
                escape_next = False
            else:
                if ch == "\\":
                    escape_next = True
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
        if index + suffix_length <= len(expression):
            match_index = 0
            matches = True
            while True:
                if match_index >= suffix_length:
                    break
                expr_char = char_at(expression, index + match_index)
                suffix_char = char_at(suffix, match_index)
                if len(expr_char) == 0  or  len(suffix_char) == 0  or  expr_char != suffix_char:
                    matches = False
                    break
                match_index += 1
            if matches:
                after_index = index + suffix_length
                after_char = char_at(expression, after_index)
                if len(after_char) == 0:
                    return True
                if not is_identifier_part_char(after_char):
                    return True
        index += 1
    return False

def append_function_call_entry(entries, entry):
    return (entries) + ([entry])

def replace_function_effect_entry(entries, position, entry):
    result = []
    index = 0
    while True:
        if index >= len(entries):
            break
        if index == position:
            result = (result) + ([entry])
        else:
            result = (result) + ([entries[index]])
        index += 1
    return result

def find_function_effect_entry_index(entries, name):
    index = 0
    while True:
        if index >= len(entries):
            break
        if entries[index].name == name:
            return index
        index += 1
    return -1

def propagate_function_effects(direct_effects, call_graph):
    aggregated = []
    index = 0
    while True:
        if index >= len(direct_effects):
            break
        aggregated = (aggregated) + ([FunctionEffectEntry(name=direct_effects[index].name, effects=copy_string_array(direct_effects[index].effects))])
        index += 1
    changed = True
    while True:
        if not changed:
            break
        changed = False
        call_index = 0
        while True:
            if call_index >= len(call_graph):
                break
            call_entry = call_graph[call_index]
            target_index = find_function_effect_entry_index(aggregated, call_entry.name)
            if target_index >= 0:
                target_entry = aggregated[target_index]
                merged = copy_string_array(target_entry.effects)
                callee_index = 0
                while True:
                    if callee_index >= len(call_entry.callees):
                        break
                    callee_name = call_entry.callees[callee_index]
                    callee_pos = find_function_effect_entry_index(aggregated, callee_name)
                    if callee_pos >= 0:
                        callee_entry = aggregated[callee_pos]
                        effect_index = 0
                        while True:
                            if effect_index >= len(callee_entry.effects):
                                break
                            merged = append_unique_effect(merged, callee_entry.effects[effect_index])
                            effect_index += 1
                    callee_index += 1
                if not string_arrays_equal(merged, target_entry.effects):
                    updated_entry = FunctionEffectEntry(name=target_entry.name, effects=merged)
                    aggregated = replace_function_effect_entry(aggregated, target_index, updated_entry)
                    changed = True
            call_index += 1
    return aggregated

def find_function_effect_entry(entries, name):
    index = find_function_effect_entry_index(entries, name)
    if index >= 0:
        return entries[index]
    return None

def build_capability_manifest(entry_points, function_effects):
    entries = []
    index = 0
    while True:
        if index >= len(entry_points):
            break
        symbol = entry_points[index]
        effect_entry = find_function_effect_entry(function_effects, symbol)
        effects = []
        if effect_entry != None:
            effects = effect_entry.effects
        entries = append_manifest_entry(entries, CapabilityManifestEntry(symbol=symbol, effects=effects))
        index += 1
    return CapabilityManifest(entries=entries)

def append_manifest_entry(entries, entry):
    return (entries) + ([entry])

def runtime_helper_descriptors():
    descriptors = []
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="print.info", symbol="sailfin_runtime_print_info", return_type="void", parameter_types=["i8*"], effects=["io"]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="print.error", symbol="sailfin_runtime_print_error", return_type="void", parameter_types=["i8*"], effects=["io"]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="print.warn", symbol="sailfin_runtime_print_warn", return_type="void", parameter_types=["i8*"], effects=["io"]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="console.info", symbol="sailfin_intrinsic_io_print", return_type="void", parameter_types=["i8*"], effects=["io"]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="console.log", symbol="sailfin_intrinsic_io_print", return_type="void", parameter_types=["i8*"], effects=["io"]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="console.error", symbol="sailfin_runtime_print_error", return_type="void", parameter_types=["i8*"], effects=["io"]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="io_read", symbol="sailfin_intrinsic_io_read", return_type="i8*", parameter_types=["i8*"], effects=["io"]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="fs.read", symbol="sailfin_intrinsic_fs_read", return_type="i8*", parameter_types=["i8*"], effects=["io"]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="fs.write", symbol="sailfin_intrinsic_fs_write", return_type="void", parameter_types=["i8*", "i8*"], effects=["io"]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="fs.exists", symbol="sailfin_intrinsic_fs_exists", return_type="i1", parameter_types=["i8*"], effects=["io"]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="model_invoke", symbol="sailfin_intrinsic_model_invoke", return_type="i8*", parameter_types=["i8*", "i8*"], effects=["model"]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="prompt", symbol="sailfin_intrinsic_model_invoke", return_type="i8*", parameter_types=["i8*", "i8*"], effects=["model"]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="net_request", symbol="sailfin_intrinsic_net_request", return_type="i8*", parameter_types=["i8*", "i8*", "i8*"], effects=["net"]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="http.get", symbol="sailfin_intrinsic_http_get", return_type="i8*", parameter_types=["i8*"], effects=["net"]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="http.post", symbol="sailfin_intrinsic_http_post", return_type="i8*", parameter_types=["i8*", "i8*"], effects=["net"]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="sleep", symbol="sailfin_runtime_sleep", return_type="void", parameter_types=["double"], effects=["clock"]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="runtime_sleep_fn", symbol="sailfin_runtime_sleep", return_type="void", parameter_types=["double"], effects=["clock"]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="runtime_channel_fn", symbol="sailfin_runtime_channel", return_type="i8*", parameter_types=["double"], effects=["io"]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="runtime_spawn_fn", symbol="sailfin_runtime_spawn", return_type="void", parameter_types=["i8*", "i8*"], effects=["io"]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="runtime_parallel_fn", symbol="sailfin_runtime_parallel", return_type="i8*", parameter_types=["i8*"], effects=["io"]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="runtime_create_capability_grant", symbol="sailfin_runtime_create_capability_grant", return_type="i8*", parameter_types=["i8*"], effects=[]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="runtime_create_filesystem_bridge", symbol="sailfin_runtime_create_filesystem_bridge", return_type="i8*", parameter_types=["i8*"], effects=["io"]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="runtime_create_http_bridge", symbol="sailfin_runtime_create_http_bridge", return_type="i8*", parameter_types=["i8*"], effects=["net"]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="runtime_create_model_bridge", symbol="sailfin_runtime_create_model_bridge", return_type="i8*", parameter_types=["i8*"], effects=["model"]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="runtime_log_execution_fn", symbol="sailfin_runtime_log_execution", return_type="i8*", parameter_types=["i8*"], effects=["io"]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="runtime_to_debug_string_fn", symbol="sailfin_runtime_to_debug_string", return_type="i8*", parameter_types=["i8*"], effects=[]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="runtime_raise_value_error_fn", symbol="sailfin_runtime_raise_value_error", return_type="void", parameter_types=["i8*"], effects=[]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="runtime_is_string_fn", symbol="sailfin_runtime_is_string", return_type="i1", parameter_types=["i8*"], effects=[]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="runtime_is_number_fn", symbol="sailfin_runtime_is_number", return_type="i1", parameter_types=["i8*"], effects=[]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="runtime_is_boolean_fn", symbol="sailfin_runtime_is_boolean", return_type="i1", parameter_types=["i8*"], effects=[]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="runtime_is_void_fn", symbol="sailfin_runtime_is_void", return_type="i1", parameter_types=["i8*"], effects=[]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="runtime.bounds_check", symbol="sailfin_runtime_bounds_check", return_type="void", parameter_types=["i64", "i64"], effects=[]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="runtime_is_array_fn", symbol="sailfin_runtime_is_array", return_type="i1", parameter_types=["i8*"], effects=[]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="runtime_is_callable_fn", symbol="sailfin_runtime_is_callable", return_type="i1", parameter_types=["i8*"], effects=[]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="runtime_resolve_runtime_type_fn", symbol="sailfin_runtime_resolve_type", return_type="i8*", parameter_types=["i8*"], effects=[]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="runtime_instance_of_fn", symbol="sailfin_runtime_instance_of", return_type="i1", parameter_types=["i8*", "i8*"], effects=[]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="runtime_serve_fn", symbol="sailfin_runtime_serve", return_type="void", parameter_types=["i8*", "i8*"], effects=["io", "net"]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="runtime_char_code_fn", symbol="sailfin_runtime_char_code", return_type="double", parameter_types=["i8*"], effects=[]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="process.run", symbol="sailfin_runtime_process_run", return_type="double", parameter_types=["{ i8**, i64 }*"], effects=["io"]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="fs_read_file", symbol="sailfin_adapter_fs_read_file", return_type="i8*", parameter_types=["i8*"], effects=["io"]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="fs.readFile", symbol="sailfin_adapter_fs_read_file", return_type="i8*", parameter_types=["i8*"], effects=["io"]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="fs_write_file", symbol="sailfin_adapter_fs_write_file", return_type="void", parameter_types=["i8*", "i8*"], effects=["io"]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="fs.writeFile", symbol="sailfin_adapter_fs_write_file", return_type="void", parameter_types=["i8*", "i8*"], effects=["io"]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="fs_list_directory", symbol="sailfin_adapter_fs_list_directory", return_type="{ i8**, i64 }*", parameter_types=["i8*"], effects=["io"]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="fs.listDirectory", symbol="sailfin_adapter_fs_list_directory", return_type="{ i8**, i64 }*", parameter_types=["i8*"], effects=["io"]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="fs_delete_file", symbol="sailfin_adapter_fs_delete_file", return_type="i1", parameter_types=["i8*"], effects=["io"]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="fs.deleteFile", symbol="sailfin_adapter_fs_delete_file", return_type="i1", parameter_types=["i8*"], effects=["io"]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="fs_create_directory", symbol="sailfin_adapter_fs_create_directory", return_type="i1", parameter_types=["i8*", "i1"], effects=["io"]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="fs.createDirectory", symbol="sailfin_adapter_fs_create_directory", return_type="i1", parameter_types=["i8*", "i1"], effects=["io"]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="http_get", symbol="sailfin_adapter_http_get", return_type="i8*", parameter_types=["i8*"], effects=["net"]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="http_post", symbol="sailfin_adapter_http_post", return_type="i8*", parameter_types=["i8*", "i8*"], effects=["net"]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="model_invoke_with_prompt", symbol="sailfin_adapter_model_invoke_with_prompt", return_type="i8*", parameter_types=["i8*", "i8*"], effects=["model"]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="serve_start", symbol="sailfin_adapter_serve_start", return_type="void", parameter_types=["i8*", "i32"], effects=["net", "io"]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="serve_handler_dispatch", symbol="sailfin_adapter_serve_handler_dispatch", return_type="i8*", parameter_types=["i8*", "i8*"], effects=["net", "io"]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="spawn_task", symbol="sailfin_adapter_spawn_task", return_type="i8*", parameter_types=["i8*"], effects=["spawn"]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="channel_create", symbol="sailfin_adapter_channel_create", return_type="i8*", parameter_types=["i32"], effects=[]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="channel_send", symbol="sailfin_adapter_channel_send", return_type="void", parameter_types=["i8*", "i8*"], effects=["channel"]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="channel_receive", symbol="sailfin_adapter_channel_receive", return_type="i8*", parameter_types=["i8*"], effects=["channel"]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="runtime_array_map_fn", symbol="sailfin_runtime_array_map", return_type="i8*", parameter_types=["i8*", "i8*"], effects=[]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="runtime_array_filter_fn", symbol="sailfin_runtime_array_filter", return_type="i8*", parameter_types=["i8*", "i8*"], effects=[]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="runtime_array_reduce_fn", symbol="sailfin_runtime_array_reduce", return_type="i8*", parameter_types=["i8*", "i8*", "i8*"], effects=[]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="substring", symbol="sailfin_runtime_substring", return_type="i8*", parameter_types=["i8*", "i64", "i64"], effects=[]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="substring_unchecked", symbol="sailfin_runtime_substring_unchecked", return_type="i8*", parameter_types=["i8*", "i64", "i64"], effects=[]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="len(string)", symbol="sailfin_runtime_string_length", return_type="i64", parameter_types=["i8*"], effects=[]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="string.concat", symbol="sailfin_runtime_string_concat", return_type="i8*", parameter_types=["i8*", "i8*"], effects=[]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="string.drop", symbol="sailfin_runtime_string_drop", return_type="void", parameter_types=["i8*"], effects=[]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="number.to_string", symbol="sailfin_runtime_number_to_string", return_type="i8*", parameter_types=["double"], effects=[]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="strings_equal", symbol="strings_equal", return_type="i1", parameter_types=["i8*", "i8*"], effects=[]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="char_code", symbol="char_code", return_type="double", parameter_types=["i8*"], effects=[]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="runtime_grapheme_count_fn", symbol="sailfin_runtime_grapheme_count", return_type="double", parameter_types=["i8*"], effects=[]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="runtime_grapheme_at_fn", symbol="sailfin_runtime_grapheme_at", return_type="i8*", parameter_types=["i8*", "double"], effects=[]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="grapheme_at", symbol="sailfin_runtime_grapheme_at", return_type="i8*", parameter_types=["i8*", "double"], effects=[]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="is_whitespace_char", symbol="sailfin_runtime_is_whitespace_char", return_type="i1", parameter_types=["i8"], effects=[]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="is_decimal_digit", symbol="sailfin_runtime_is_decimal_digit", return_type="i1", parameter_types=["i8"], effects=[]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="is_alpha_char", symbol="sailfin_runtime_is_alpha_char", return_type="i1", parameter_types=["i8"], effects=[]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="append_string", symbol="sailfin_runtime_append_string", return_type="{ i8**, i64 }*", parameter_types=["{ i8**, i64 }*", "i8*"], effects=[]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="concat", symbol="sailfin_runtime_concat", return_type="{ i8**, i64 }*", parameter_types=["{ i8**, i64 }*", "{ i8**, i64 }*"], effects=[]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="copy_bytes", symbol="sailfin_runtime_copy_bytes", return_type="void", parameter_types=["i8*", "i8*", "i64"], effects=[]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="get_field", symbol="sailfin_runtime_get_field", return_type="i8*", parameter_types=["i8*", "i8*"], effects=[]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="mark_persistent", symbol="sailfin_runtime_mark_persistent", return_type="void", parameter_types=["i8*"], effects=[]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="set_exception", symbol="sailfin_runtime_set_exception", return_type="void", parameter_types=["i8*"], effects=[]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="clear_exception", symbol="sailfin_runtime_clear_exception", return_type="void", parameter_types=[], effects=[]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="has_exception", symbol="sailfin_runtime_has_exception", return_type="i1", parameter_types=[], effects=[]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="try_enter", symbol="sailfin_runtime_try_enter", return_type="i32", parameter_types=["i8**"], effects=[]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="try_leave", symbol="sailfin_runtime_try_leave", return_type="void", parameter_types=["i8*"], effects=[]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="throw", symbol="sailfin_runtime_throw", return_type="void", parameter_types=["i8*"], effects=[]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="take_exception", symbol="sailfin_runtime_take_exception", return_type="i8*", parameter_types=[], effects=[]))
    return descriptors

def append_runtime_helper(values, value):
    return (values) + ([value])

def find_runtime_helper(target):
    descriptors = runtime_helper_descriptors()
    trimmed = trim_text(target)
    index = 0
    while True:
        if index >= len(descriptors):
            break
        if descriptors[index].target == trimmed:
            return descriptors[index]
        index += 1
    return None

def collect_function_effect_entry(function):
    combined = []
    combined = merge_effect_lists(combined, function.effects)
    combined = merge_effect_lists(combined, collect_function_borrow_effects(function))
    return FunctionEffectEntry(name=function.name, effects=combined)

def append_function_effect_entry(values, entry):
    return (values) + ([entry])

def merge_effect_lists(base, extras):
    result = []
    index = 0
    while True:
        if index >= len(base):
            break
        result = append_unique_effect(result, base[index])
        index += 1
    index = 0
    while True:
        if index >= len(extras):
            break
        result = append_unique_effect(result, extras[index])
        index += 1
    return result

def append_unique_effect(effects, effect):
    if len(effect) == 0:
        return effects
    if string_array_contains(effects, effect):
        return effects
    return (effects) + ([effect])

def collect_function_borrow_effects(function):
    effects = []
    index = 0
    while True:
        if index >= len(function.instructions):
            break
        instruction = function.instructions[index]
        if instruction.variant == "Let":
            if instruction.value != None:
                effects = merge_effect_lists(effects, collect_expression_borrow_effects(instruction.value))
        else:
            if instruction.variant == "Expression":
                effects = merge_effect_lists(effects, collect_expression_borrow_effects(instruction.expression))
            else:
                if instruction.variant == "Return":
                    trimmed = trim_text(instruction.expression)
                    if len(trimmed) > 0:
                        effects = merge_effect_lists(effects, collect_expression_borrow_effects(trimmed))
        index += 1
    return effects

def collect_expression_borrow_effects(expression):
    trimmed = trim_text(expression)
    if len(trimmed) == 0:
        return []
    effects = []
    index = 0
    while True:
        if index >= len(trimmed):
            break
        ch = trimmed[index]
        if ch == "\"":
            index = skip_string_literal(trimmed, index + 1)
            continue
        if ch == "&":
            if index + 1 < len(trimmed)  and  trimmed[index + 1] == "&":
                index += 2
                continue
            if index > 0:
                prefix = trimmed[index - 1]
                if is_identifier_part_char(prefix):
                    index += 1
                    continue
            cursor = index + 1
            mutable_flag = False
            if cursor + 3 <= len(trimmed):
                maybe_mut = substring(trimmed, cursor, cursor + 3)
                if maybe_mut == "mut":
                    after_mut_index = cursor + 3
                    if after_mut_index >= len(trimmed)  or  is_effect_delimiter(trimmed[after_mut_index]):
                        mutable_flag = True
                        cursor = after_mut_index
            while True:
                if cursor >= len(trimmed):
                    break
                current = trimmed[cursor]
                if not is_trim_char(current):
                    break
                cursor += 1
            if cursor < len(trimmed):
                target_start = trimmed[cursor]
                if is_identifier_start_char(target_start):
                    if mutable_flag:
                        effects = append_unique_effect(effects, "mut")
                    else:
                        effects = append_unique_effect(effects, "read")
            index += 1
            continue
        if ch == "b":
            if matches_keyword(trimmed, index, "borrow"):
                before_index = index - 1
                if before_index < 0  or  is_effect_prefix_char(trimmed[before_index]):
                    effects = append_unique_effect(effects, "read")
                    index += 6
                    continue
        index += 1
    return effects

def skip_string_literal(text, start_index):
    index = start_index
    escaped = False
    while True:
        if index >= len(text):
            break
        current = text[index]
        if escaped:
            escaped = False
        else:
            if current == "\\":
                escaped = True
            else:
                if current == "\"":
                    index += 1
                    break
        if current == "\n":
            index += 1
            break
        index += 1
    return index

def copy_string_array(values):
    result = []
    index = 0
    while True:
        if index >= len(values):
            break
        result = append_string(result, values[index])
        index += 1
    return result

def string_arrays_equal(first, second):
    if len(first) != len(second):
        return False
    index = 0
    while True:
        if index >= len(first):
            break
        if first[index] != second[index]:
            return False
        index += 1
    return True

def matches_keyword(value, start_index, keyword):
    remaining = len(value) - start_index
    if remaining < len(keyword):
        return False
    slice = substring(value, start_index, start_index + len(keyword))
    if slice != keyword:
        return False
    if start_index + len(keyword) >= len(value):
        return True
    next = value[start_index + len(keyword)]
    if is_identifier_part_char(next):
        return False
    return True

def is_effect_prefix_char(ch):
    if is_trim_char(ch):
        return True
    return ch == "("  or  ch == ","  or  ch == ";"  or  ch == "{"  or  ch == "}"  or  ch == "="

def is_effect_delimiter(ch):
    if is_trim_char(ch):
        return True
    return ch == "("  or  ch == ")"  or  ch == ","  or  ch == ";"  or  ch == "{"  or  ch == "}"  or  ch == "="

def is_identifier_start_char(ch):
    if ch == "_":
        return True
    if index_of("abcdefghijklmnopqrstuvwxyz", ch) != -1:
        return True
    if index_of("ABCDEFGHIJKLMNOPQRSTUVWXYZ", ch) != -1:
        return True
    return False

def is_identifier_part_char(ch):
    if is_identifier_start_char(ch):
        return True
    if index_of("0123456789", ch) != -1:
        return True
    return False

def render_interface_signature(signature):
    line = "fn " + signature.name
    if len(signature.type_parameters) > 0:
        line = line + "<" + join_with_separator(signature.type_parameters, ", ") + ">"
    line = line + "(" + render_interface_parameters(signature.parameters) + ")"
    if len(signature.return_type) > 0  and  signature.return_type != "void":
        line = line + " -> " + signature.return_type
    if len(signature.effects) > 0:
        line = line + " ![" + join_with_separator(signature.effects, ", ") + "]"
    if signature.is_async:
        line = "async " + line
    return line

def render_interface_parameters(parameters):
    if len(parameters) == 0:
        return ""
    rendered = []
    index = 0
    while True:
        if index >= len(parameters):
            break
        parameter = parameters[index]
        entry = parameter.name
        if parameter.mutable:
            entry = "mut " + entry
        if len(parameter.type_annotation) > 0:
            entry = entry + " -> " + parameter.type_annotation
        if parameter.default_value != None:
            entry = entry + " = " + parameter.default_value
        rendered = append_string(rendered, entry)
        index += 1
    return join_with_separator(rendered, ", ")

def emit_function(function, functions, effects, context, module_name, entry_points, exported_symbols, imported_functions, module_globals, module_init_symbol, needs_module_init_call):
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
        impl_lowered = emit_function(
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
            call_args = ""
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

def validate_borrow_lifetimes(function, regions):
    diagnostics = []
    index = 0
    root_scope = format_root_scope_id(function.name)
    while True:
        if index >= len(regions):
            break
        region = regions[index]
        base_scope_id = region.base_scope_id
        base_scope_depth = region.base_scope_depth
        if len(base_scope_id) == 0:
            base_scope_id = root_scope
            base_scope_depth = 0
        violation = False
        if region.released:
            if len(region.end_scope_id) == 0:
                violation = True
            else:
                if not is_scope_descendant(base_scope_id, region.end_scope_id):
                    violation = True
        else:
            if region.scope_depth < base_scope_depth:
                violation = True
            else:
                if not is_scope_descendant(base_scope_id, region.scope_id):
                    violation = True
        if violation:
            location = ""
            if region.start_span != None:
                location = " at " + format_span_location(region.start_span)
            diagnostics = append_string(diagnostics, "llvm lowering: borrow `" + region.binding + "` of `" + region.base + "` escapes lifetime of `" + region.base + "` in `" + function.name + "`" + location)
        index += 1
    return diagnostics

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

def number_to_string(value):
    if value == 0:
        return "0"
    digits = "0123456789"
    powers = [1000000000000000, 100000000000000, 10000000000000, 1000000000000, 100000000000, 10000000000, 1000000000, 100000000, 10000000, 1000000, 100000, 10000, 1000, 100, 10, 1]
    remaining = value
    is_negative = False
    if remaining < 0:
        is_negative = True
        remaining = 0 - remaining
    output = ""
    index = 0
    started = False
    while True:
        if index >= len(powers):
            break
        power = powers[index]
        count = 0
        while True:
            if remaining < power:
                break
            remaining -= power
            count += 1
        if started  or  count > 0:
            started = True
            ch = substring(digits, count, count + 1)
            output = output + ch
        index += 1
    if len(output) == 0:
        output = "0"
    if is_negative:
        return "-" + output
    return output

def lower_char_code(code):
    upper_a = char_code("A")
    upper_z = char_code("Z")
    if code >= upper_a  and  code <= upper_z:
        lower_a = char_code("a")
        return code + lower_a - upper_a
    return code

def matches_case_insensitive(value, expected):
    if len(value) != len(expected):
        return False
    index = 0
    while True:
        if index >= len(value):
            break
        value_ch = substring(value, index, index + 1)
        expected_ch = substring(expected, index, index + 1)
        value_code = lower_char_code(char_code(value_ch))
        expected_code = lower_char_code(char_code(expected_ch))
        if value_code != expected_code:
            return False
        index += 1
    return True

def is_boolean_literal(text):
    trimmed = trim_text(text)
    if matches_case_insensitive(trimmed, "true"):
        return True
    if matches_case_insensitive(trimmed, "false"):
        return True
    return False

def is_null_literal(text):
    trimmed = trim_text(text)
    if matches_case_insensitive(trimmed, "null"):
        return True
    return False

def is_digit_char(ch):
    code = char_code(ch)
    zero = char_code("0")
    nine = char_code("9")
    return code >= zero  and  code <= nine

def char_code_at_text(text, index):
    return char_code(char_at(text, index))

def is_integer_literal(text):
    trimmed = trim_text(text)
    if len(trimmed) == 0:
        return False
    index = 0
    if char_code_at_text(trimmed, 0) == char_code("-"):
        if len(trimmed) == 1:
            return False
        index = 1
    has_digit = False
    while True:
        if index >= len(trimmed):
            break
        code = char_code_at_text(trimmed, index)
        if code >= char_code("0")  and  code <= char_code("9"):
            has_digit = True
            index += 1
            continue
        return False
    return has_digit

def is_number_literal(text):
    index = 0
    has_digit = False
    has_decimal = False
    trimmed = trim_text(text)
    if len(trimmed) == 0:
        return False
    if char_code_at_text(trimmed, 0) == char_code("-"):
        if len(trimmed) == 1:
            return False
        index = 1
    while True:
        if index >= len(trimmed):
            break
        code = char_code_at_text(trimmed, index)
        if code >= char_code("0")  and  code <= char_code("9"):
            has_digit = True
            index += 1
            continue
        if code == char_code("."):
            if has_decimal:
                return False
            has_decimal = True
            index += 1
            continue
        return False
    return has_digit

def normalise_number_literal(text):
    trimmed = trim_text(text)
    if index_of(trimmed, ".") >= 0:
        return trimmed
    return trimmed + ".0"

def is_string_literal(text):
    trimmed = trim_text(text)
    if len(trimmed) < 2:
        return False
    if char_code_at_text(trimmed, 0) != char_code("\""):
        return False
    if char_code_at_text(trimmed, len(trimmed) - 1) != char_code("\""):
        return False
    return True

def is_character_literal(text):
    if len(text) < 2:
        return False
    if char_code_at_text(text, 0) != char_code("\"")  or  char_code_at_text(text, len(text) - 1) != char_code("\""):
        return False
    inner = substring(text, 1, len(text) - 1)
    if len(inner) == 2  and  char_code_at_text(inner, 0) == char_code("\\"):
        return True
    return len(inner) == 1

def get_character_literal_value(text):
    inner = substring(text, 1, len(text) - 1)
    if len(inner) == 0:
        return 0
    if len(inner) == 2  and  char_code_at_text(inner, 0) == char_code("\\"):
        escape = char_at(inner, 1)
        escape_code = char_code(escape)
        if escape_code == char_code("n"):
            return char_code("\n")
        else:
            if escape_code == char_code("r"):
                return char_code("\r")
            else:
                if escape_code == char_code("t"):
                    return char_code("\t")
                else:
                    if escape_code == char_code("\""):
                        return char_code("\"")
                    else:
                        if escape_code == char_code("\\"):
                            return char_code("\\")
        return char_code(escape)
    return char_code(char_at(inner, 0))

def make_string_constant_name(content):
    hash_value = compute_string_constant_hash(content)
    length_part = number_to_string(len(content))
    hash_part = number_to_string(hash_value)
    return "@.str.len" + length_part + ".h" + hash_part

def make_string_constant_name_for_module(module_name, content):
    base = make_string_constant_name(content)
    tag = sanitize_symbol(module_name)
    if len(tag) == 0  or  tag == "_":
        return base
    return "@.str." + tag + substring(base, 5, len(base))

def compute_string_constant_hash(content):
    hash = 5381
    modulus = 2147483647
    index = 0
    while True:
        if index >= len(content):
            break
        code = char_code_at_text(content, index)
        hash = hash * 33 + code
        while True:
            if hash < modulus:
                break
            hash -= modulus
        index += 1
    hash = hash * 33 + len(content)
    while True:
        if hash < modulus:
            break
        hash -= modulus
    return hash

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

def parse_interpolated_template(content):
    parts = []
    expressions = []
    index = 0
    while True:
        if index > len(content):
            break
        start = find_substring_from(content, "{{", index)
        if start < 0:
            parts = append_string(parts, substring(content, index, len(content)))
            break
        parts = append_string(parts, substring(content, index, start))
        end = find_substring_from(content, "}}", start + 2)
        if end < 0:
            return InterpolatedTemplateParse(parts=[], expressions=[], success=False)
        expr_text = trim_text(substring(content, start + 2, end))
        if len(expr_text) == 0:
            return InterpolatedTemplateParse(parts=[], expressions=[], success=False)
        expressions = append_string(expressions, expr_text)
        index = end + 2
    return InterpolatedTemplateParse(parts=parts, expressions=expressions, success=True)

def find_substring_from(value, target, start):
    if len(target) == 0:
        return start
    index = start
    if index < 0:
        index = 0
    while True:
        if index + len(target) > len(value):
            break
        match_index = 0
        matches = True
        while True:
            if match_index >= len(target):
                break
            if char_code_at_text(value, index + match_index) != char_code_at_text(target, match_index):
                matches = False
                break
            match_index += 1
        if matches:
            return index
        index += 1
    return -1

def encode_string_literal_for_sailfin(content):
    escaped = escape_string_for_sailfin_literal(content)
    return "\"" + escaped + "\""

def escape_string_for_sailfin_literal(content):
    result = ""
    index = 0
    while True:
        if index >= len(content):
            break
        ch = content[index]
        if ch == "\\":
            result = result + "\\\\"
        else:
            if ch == "\"":
                result = result + "\\\""
            else:
                if ch == "\n":
                    result = result + "\\n"
                else:
                    if ch == "\r":
                        result = result + "\\r"
                    else:
                        if ch == "\t":
                            result = result + "\\t"
                        else:
                            result = result + ch
        index += 1
    return result

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

def unescape_string_literal(literal):
    if len(literal) < 2:
        return ""
    start_index = 1
    end_index = len(literal) - 1
    inner = substring(literal, start_index, end_index)
    result = ""
    index = 0
    while True:
        if index >= len(inner):
            break
        ch = char_at(inner, index)
        if char_code(ch) == char_code("\\")  and  index + 1 < len(inner):
            next = char_at(inner, index + 1)
            next_code = char_code(next)
            if next_code == char_code("n"):
                result = result + "\n"
                index += 2
                continue
            else:
                if next_code == char_code("r"):
                    result = result + "\r"
                    index += 2
                    continue
                else:
                    if next_code == char_code("t"):
                        result = result + "\t"
                        index += 2
                        continue
                    else:
                        if next_code == char_code("\""):
                            result = result + "\""
                            index += 2
                            continue
                        else:
                            if next_code == char_code("\\"):
                                result = result + "\\"
                                index += 2
                                continue
            result = result + next
            index += 2
            continue
        result = result + ch
        index += 1
    return result

def trim_text(value):
    start = 0
    end = len(value)
    while True:
        if start >= end:
            break
        ch = char_at(value, start)
        if is_trim_char(ch):
            start += 1
            continue
        break
    while True:
        if end <= start:
            break
        ch = char_at(value, end - 1)
        if is_trim_char(ch):
            end -= 1
            continue
        break
    if start == 0  and  end == len(value):
        return value
    return substring(value, start, end)

def is_trim_char(ch):
    code = char_code(ch)
    return code == char_code(" ")  or  code == char_code("\n")  or  code == char_code("\r")  or  code == char_code("\t")

def index_of(value, target):
    if len(target) == 0:
        return 0
    index = 0
    while True:
        if index + len(target) > len(value):
            break
        match_index = 0
        matches = True
        while True:
            if match_index >= len(target):
                break
            if char_code_at_text(value, index + match_index) != char_code_at_text(target, match_index):
                matches = False
                break
            match_index += 1
        if matches:
            return index
        index += 1
    return -1

def find_last_index_of_char(value, target):
    if len(target) != 1:
        return -1
    target_code = char_code_at_text(target, 0)
    index = len(value)
    while True:
        if index <= 0:
            break
        index -= 1
        if char_code_at_text(value, index) == target_code:
            return index
    return -1

def append_string(values, value):
    values.append(value)
    return values

def append_match_arm_mutations(list, arm):
    list.append(arm)
    return list

def string_array_contains(values, target):
    index = 0
    while True:
        if index >= len(values):
            break
        if values[index] == target:
            return True
        index += 1
    return False

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

def join_with_separator(values, separator):
    if len(values) == 0:
        return ""
    if len(values) == 1:
        return values[0]
    parts = values
    while True:
        if len(parts) <= 1:
            break
        next = []
        index = 0
        while True:
            if index >= len(parts):
                break
            if index + 1 < len(parts):
                next = (next) + ([parts[index] + separator + parts[index + 1]])
                index += 2
                continue
            next = (next) + ([parts[index]])
            index += 1
        parts = next
    return parts[0]

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

def is_symbol_char(ch):
    if len(ch) == 0:
        return False
    if ch == "_":
        return True
    code = char_code(ch)
    lower_a = char_code("a")
    lower_z = char_code("z")
    if code >= lower_a  and  code <= lower_z:
        return True
    upper_a = char_code("A")
    upper_z = char_code("Z")
    if code >= upper_a  and  code <= upper_z:
        return True
    zero = char_code("0")
    nine = char_code("9")
    if code >= zero  and  code <= nine:
        return True
    return False

def sanitize_symbol(name):
    if len(name) == 0:
        return "_"
    result = ""
    index = 0
    while True:
        if index >= len(name):
            break
        ch = name[index]
        if is_symbol_char(ch):
            result = result + ch
        index += 1
    if len(result) == 0:
        return "_"
    first = result[0]
    first_code = char_code(first)
    zero = char_code("0")
    nine = char_code("9")
    if first_code >= zero  and  first_code <= nine:
        result = "_" + result
    return result
