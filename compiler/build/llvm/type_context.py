import asyncio
from runtime import runtime_support as runtime

from ...native_ir import NativeStruct, NativeEnum, NativeEnumLayout, NativeEnumVariantLayout, NativeInterface, NativeFunction, NativeInterfaceSignature
from ...string_utils import substring
from compiler.build.types import TypeContext, TypeContextBuild, StructTypeInfo, StructFieldInfo, EnumTypeInfo, EnumVariantInfo, InterfaceTypeInfo, VTableInfo, VTableEntry, TypeAllocationInfo, ParameterBinding, LocalBinding
from compiler.build.utils import trim_text, append_string, sanitize_symbol, is_simple_identifier, find_last_index_of_char, index_of, string_array_contains
from compiler.build.type_mapping import map_type_annotation, map_struct_field_annotation, ends_with_pointer_suffix, strip_pointer_suffix, layout_annotation_base_type, layout_annotation_represents_user_value

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

class EnumLayoutFixupResult:
    def __init__(self, enums, diagnostics):
        self.enums = enums
        self.diagnostics = diagnostics

    def __repr__(self):
        return runtime.struct_repr('EnumLayoutFixupResult', [runtime.struct_field('enums', self.enums), runtime.struct_field('diagnostics', self.diagnostics)])

def is_unit_enum(enum_def):
    index = 0
    while True:
        if index >= len(enum_def.variants):
            break
        variant = enum_def.variants[index]
        if len(variant.fields) > 0:
            return False
        index += 1
    return True

def synthesize_unit_enum_layout(enum_def):
    tag_size = 4
    tag_align = 4
    layouts = []
    index = 0
    while True:
        if index >= len(enum_def.variants):
            break
        variant = enum_def.variants[index]
        layouts = (layouts) + ([NativeEnumVariantLayout(name=variant.name, tag=index, offset=0, size=tag_size, align=tag_align, fields=[])])
        index += 1
    return NativeEnumLayout(size=tag_size, align=tag_align, tag_type="i32", tag_size=tag_size, tag_align=tag_align, variants=layouts)

def enum_layout_matches_variants(enum_def, layout):
    if len(layout.variants) != len(enum_def.variants):
        return False
    index = 0
    while True:
        if index >= len(enum_def.variants):
            break
        expected = enum_def.variants[index].name
        found = False
        layout_index = 0
        while True:
            if layout_index >= len(layout.variants):
                break
            if layout.variants[layout_index].name == expected:
                found = True
                break
            layout_index += 1
        if not found:
            return False
        index += 1
    return True

def fixup_enum_layouts(enums):
    diagnostics = []
    updated = []
    index = 0
    while True:
        if index >= len(enums):
            break
        enum_def = enums[index]
        fixed = enum_def
        if enum_def.layout == None:
            if is_unit_enum(enum_def):
                fixed = NativeEnum(name=enum_def.name, variants=enum_def.variants, layout=synthesize_unit_enum_layout(enum_def))
                diagnostics = (diagnostics) + (["llvm lowering: enum `" + enum_def.name + "` missing layout metadata; synthesized unit-enum layout"])
            updated = (updated) + ([fixed])
            index += 1
            continue
        layout = enum_def.layout
        if not enum_layout_matches_variants(enum_def, layout):
            if is_unit_enum(enum_def):
                fixed = NativeEnum(name=enum_def.name, variants=enum_def.variants, layout=synthesize_unit_enum_layout(enum_def))
                diagnostics = (diagnostics) + (["llvm lowering: enum `" + enum_def.name + "` layout variants incomplete/garbled; synthesized unit-enum layout"])
            else:
                diagnostics = (diagnostics) + (["llvm lowering: enum `" + enum_def.name + "` layout variants incomplete/garbled; payload enums require full layout metadata"])
        updated = (updated) + ([fixed])
        index += 1
    return EnumLayoutFixupResult(enums=updated, diagnostics=diagnostics)

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

def find_struct_info_by_name(context, name):
    index = 0
    while True:
        if index >= len(context.structs):
            break
        info = context.structs[index]
        if info.name == name:
            return info
        index += 1
    return None

def find_struct_info_by_llvm_name(context, llvm_name):
    return find_struct_info_by_llvm_type(context, llvm_name)

def find_interface_info_by_name(context, name):
    index = 0
    while True:
        if index >= len(context.interfaces):
            break
        info = context.interfaces[index]
        if info.name == name:
            return info
        index += 1
    return None

def find_vtable_for_struct_interface(context, struct_name, interface_name):
    index = 0
    while True:
        if index >= len(context.vtables):
            break
        vtable = context.vtables[index]
        if vtable.struct_name == struct_name  and  vtable.interface_name == interface_name:
            return vtable
        index += 1
    return None

def find_struct_info_by_llvm_type(context, llvm_type):
    trimmed = trim_text(llvm_type)
    index = 0
    while True:
        if index >= len(context.structs):
            break
        info = context.structs[index]
        if info.llvm_name == trimmed:
            return info
        index += 1
    return None

def find_struct_field_index(struct_info, field_name):
    index = 0
    while True:
        if index >= len(struct_info.fields):
            break
        field = struct_info.fields[index]
        if field.name == field_name:
            return index
        index += 1
    return -1

def find_enum_info_by_llvm_type(context, llvm_type):
    trimmed = trim_text(llvm_type)
    index = 0
    while True:
        if index >= len(context.enums):
            break
        info = context.enums[index]
        if info.llvm_name == trimmed:
            return info
        index += 1
    return None

def resolve_struct_info_from_llvm_type(context, llvm_type):
    candidate = trim_text(llvm_type)
    if len(candidate) == 0:
        return None
    if ends_with_pointer_suffix(candidate):
        candidate = strip_pointer_suffix(candidate)
    return find_struct_info_by_llvm_type(context, candidate)

def lookup_allocation_info(context, llvm_type):
    trimmed = trim_text(llvm_type)
    if len(trimmed) == 0:
        return None
    if ends_with_pointer_suffix(trimmed):
        return None
    if trimmed == "double":
        return TypeAllocationInfo(llvm_type=trimmed, size=8, align=8)
    if trimmed == "i64"  or  trimmed == "int":
        return TypeAllocationInfo(llvm_type=trimmed, size=8, align=8)
    if trimmed == "i32":
        return TypeAllocationInfo(llvm_type=trimmed, size=4, align=4)
    if trimmed == "i1":
        return TypeAllocationInfo(llvm_type=trimmed, size=1, align=1)
    if trimmed == "i8":
        return TypeAllocationInfo(llvm_type=trimmed, size=1, align=1)
    struct_info = find_struct_info_by_llvm_type(context, trimmed)
    if struct_info != None:
        align_value = struct_info.align
        if align_value <= 0:
            align_value = 1
        return TypeAllocationInfo(llvm_type=struct_info.llvm_name, size=struct_info.size, align=align_value)
    enum_info = find_enum_info_by_llvm_type(context, trimmed)
    if enum_info != None:
        align_value = enum_info.align
        if align_value <= 0:
            align_value = 1
        return TypeAllocationInfo(llvm_type=enum_info.llvm_name, size=enum_info.size, align=align_value)
    return None

def resolve_struct_info_for_method_target(base, bindings, locals, context):
    trimmed = trim_text(base)
    if len(trimmed) == 0:
        return None
    if is_simple_identifier(trimmed):
        parameter = find_parameter_binding(bindings, trimmed)
        if parameter != None:
            info = resolve_struct_info_from_llvm_type(context, parameter.llvm_type)
            if info != None:
                return info
        local = find_local_binding(locals, trimmed)
        if local != None:
            info = resolve_struct_info_from_llvm_type(context, local.llvm_type)
            if info != None:
                return info
    by_name = find_struct_info_by_name(context, trimmed)
    if by_name != None:
        return by_name
    return None

def resolve_interface_info_for_method_target(base, bindings, locals, context):
    trimmed = trim_text(base)
    if len(trimmed) == 0:
        return None
    if is_simple_identifier(trimmed):
        parameter = find_parameter_binding(bindings, trimmed)
        if parameter != None:
            type_name = parameter.llvm_type
            if substring(type_name, 0, 7) == "%trait.":
                interface_name = substring(type_name, 7, len(type_name))
                info = find_interface_info_by_name(context, interface_name)
                if info != None:
                    return info
            info = find_interface_info_by_name(context, type_name)
            if info != None:
                return info
        local = find_local_binding(locals, trimmed)
        if local != None:
            type_name = local.llvm_type
            if substring(type_name, 0, 7) == "%trait.":
                interface_name = substring(type_name, 7, len(type_name))
                info = find_interface_info_by_name(context, interface_name)
                if info != None:
                    return info
            info = find_interface_info_by_name(context, type_name)
            if info != None:
                return info
    return None

def find_struct_field_info(info, field_name):
    index = 0
    while True:
        if index >= len(info.fields):
            break
        field = info.fields[index]
        if field.name == field_name:
            return field
        index += 1
    return None

def find_variant_field_info(variant, field_name):
    index = 0
    while True:
        if index >= len(variant.fields):
            break
        field = variant.fields[index]
        if field.name == field_name:
            return field
        index += 1
    return None

def resolve_struct_info_for_literal(context, type_name):
    trimmed = trim_text(type_name)
    if len(trimmed) == 0:
        return None
    candidates = [trimmed]
    generic_index = index_of(trimmed, "<")
    if generic_index >= 0:
        base = trim_text(substring(trimmed, 0, generic_index))
        if len(base) > 0:
            if not string_array_contains(candidates, base):
                candidates = append_string(candidates, base)
    last_dot = find_last_index_of_char(trimmed, ".")
    if last_dot >= 0:
        tail_full = trim_text(substring(trimmed, last_dot + 1, len(trimmed)))
        if len(tail_full) > 0:
            if not string_array_contains(candidates, tail_full):
                candidates = append_string(candidates, tail_full)
            tail_generic_index = index_of(tail_full, "<")
            if tail_generic_index >= 0:
                tail_base = trim_text(substring(tail_full, 0, tail_generic_index))
                if len(tail_base) > 0:
                    if not string_array_contains(candidates, tail_base):
                        candidates = append_string(candidates, tail_base)
    index = 0
    while True:
        if index >= len(candidates):
            break
        candidate = candidates[index]
        info = find_struct_info_by_name(context, candidate)
        if info != None:
            return info
        index += 1
    return None

def resolve_enum_info_for_literal(context, enum_name):
    trimmed = trim_text(enum_name)
    if len(trimmed) == 0:
        return None
    index = 0
    while True:
        if index >= len(context.enums):
            break
        enum_info = context.enums[index]
        if enum_info.name == trimmed:
            return enum_info
        index += 1
    return None

def resolve_enum_variant_info(enum_info, variant_name):
    trimmed = trim_text(variant_name)
    if len(trimmed) == 0:
        return None
    index = 0
    while True:
        if index >= len(enum_info.variants):
            break
        variant = enum_info.variants[index]
        if variant.name == trimmed:
            return variant
        index += 1
    return None

def find_parameter_binding(bindings, name):
    index = 0
    while True:
        if index >= len(bindings):
            break
        if bindings[index].name == name:
            return bindings[index]
        index += 1
    return None

def find_local_binding(locals, name):
    index = 0
    while True:
        if index >= len(locals):
            break
        if locals[index].name == name:
            return locals[index]
        index += 1
    return None

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
