import asyncio
from runtime import runtime_support as runtime

from ...native_ir import NativeFunction, NativeParameter, NativeInterfaceSignature, NativeImport
from ...string_utils import substring, find_last_index_of_char
from compiler.build.types import TypeContext, TraitMetadata, RuntimeHelperDescriptor
from compiler.build.utils import trim_text, append_string, join_with_separator, string_array_contains, sanitize_symbol, number_to_string
from compiler.build.runtime_helpers import runtime_helper_descriptors
from compiler.build.type_mapping import map_return_type, map_parameter_type, map_struct_type_annotation

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

def render_struct_type_definitions(context, functions):
    lines = []
    referenced_types = []
    struct_index = 0
    while True:
        if struct_index >= len(context.structs):
            break
        info = context.structs[struct_index]
        field_index = 0
        while True:
            if field_index >= len(info.fields):
                break
            field_type = info.fields[field_index].llvm_type
            extracted = extract_struct_type_from_llvm(field_type)
            if len(extracted) > 0  and  not string_array_contains(referenced_types, extracted):
                referenced_types = append_string(referenced_types, extracted)
            field_index += 1
        struct_index += 1
    enum_index = 0
    while True:
        if enum_index >= len(context.enums):
            break
        enum_info = context.enums[enum_index]
        variant_index = 0
        while True:
            if variant_index >= len(enum_info.variants):
                break
            variant = enum_info.variants[variant_index]
            variant_field_index = 0
            while True:
                if variant_field_index >= len(variant.fields):
                    break
                field_type = variant.fields[variant_field_index].llvm_type
                extracted = extract_struct_type_from_llvm(field_type)
                if len(extracted) > 0  and  not string_array_contains(referenced_types, extracted):
                    referenced_types = append_string(referenced_types, extracted)
                variant_field_index += 1
            variant_index += 1
        enum_index += 1
    func_index = 0
    while True:
        if func_index >= len(functions):
            break
        func = functions[func_index]
        return_llvm_type = map_return_type(context, func.return_type)
        extracted_return = extract_struct_type_from_llvm(return_llvm_type)
        if len(extracted_return) > 0  and  not string_array_contains(referenced_types, extracted_return):
            referenced_types = append_string(referenced_types, extracted_return)
        param_index = 0
        while True:
            if param_index >= len(func.parameters):
                break
            param_llvm_type = map_parameter_type(context, func.parameters[param_index].type_annotation)
            extracted_param = extract_struct_type_from_llvm(param_llvm_type)
            if len(extracted_param) > 0  and  not string_array_contains(referenced_types, extracted_param):
                referenced_types = append_string(referenced_types, extracted_param)
            param_index += 1
        func_index += 1
    ref_index = 0
    while True:
        if ref_index >= len(referenced_types):
            break
        ref_type = referenced_types[ref_index]
        is_defined = False
        check_index = 0
        while True:
            if check_index >= len(context.structs):
                break
            if context.structs[check_index].llvm_name == ref_type:
                is_defined = True
                break
            check_index += 1
        if not is_defined:
            check_index = 0
            while True:
                if check_index >= len(context.enums):
                    break
                enum_llvm_name = "%" + sanitize_symbol(context.enums[check_index].name)
                if enum_llvm_name == ref_type:
                    is_defined = True
                    break
                check_index += 1
        if not is_defined:
            lines = append_string(lines, ref_type + " = type opaque")
        ref_index += 1
    index = 0
    emitted_types = []
    while True:
        if index >= len(context.structs):
            break
        info = context.structs[index]
        if string_array_contains(emitted_types, info.llvm_name):
            index += 1
            continue
        emitted_types = append_string(emitted_types, info.llvm_name)
        field_types = []
        field_index = 0
        while True:
            if field_index >= len(info.fields):
                break
            field_types = append_string(field_types, info.fields[field_index].llvm_type)
            field_index += 1
        body = ""
        if len(field_types) == 0:
            body = "{}"
        else:
            body = "{ " + join_with_separator(field_types, ", ") + " }"
        lines = append_string(lines, info.llvm_name + " = type " + body)
        index += 1
    return lines

def render_enum_type_definitions(context):
    lines = []
    emitted_types = []
    index = 0
    while True:
        if index >= len(context.enums):
            break
        enum_info = context.enums[index]
        enum_llvm_name = "%" + sanitize_symbol(enum_info.name)
        if string_array_contains(emitted_types, enum_llvm_name):
            index += 1
            continue
        emitted_types = append_string(emitted_types, enum_llvm_name)
        llvm_tag_type = "i32"
        if enum_info.tag_type == "i8":
            llvm_tag_type = "i8"
        if enum_info.tag_type == "i16":
            llvm_tag_type = "i16"
        if enum_info.tag_type == "i32":
            llvm_tag_type = "i32"
        if enum_info.tag_type == "i64":
            llvm_tag_type = "i64"
        max_payload_size = 0
        variant_idx = 0
        while True:
            if variant_idx >= len(enum_info.variants):
                break
            variant = enum_info.variants[variant_idx]
            if variant.size > max_payload_size:
                max_payload_size = variant.size
            variant_idx += 1
        payload_repr = ""
        if max_payload_size > 0:
            payload_repr = ", [" + number_to_string(max_payload_size) + " x i8]"
        body = "{ " + llvm_tag_type + payload_repr + " }"
        lines = append_string(lines, enum_info.llvm_name + " = type " + body)
        index += 1
    return lines

def render_interface_type_definitions(context):
    lines = []
    index = 0
    while True:
        if index >= len(context.interfaces):
            break
        interface_info = context.interfaces[index]
        body = "{ i8*, i8* }"
        lines = append_string(lines, interface_info.llvm_name + " = type " + body)
        index += 1
    return lines

def render_vtable_type_definitions(context):
    lines = []
    index = 0
    while True:
        if index >= len(context.vtables):
            break
        vtable = context.vtables[index]
        entry_types = []
        entry_index = 0
        while True:
            if entry_index >= len(vtable.entries):
                break
            entry_types = append_string(entry_types, vtable.entries[entry_index].function_pointer_type)
            entry_index += 1
        body = ""
        if len(entry_types) == 0:
            body = "{}"
        else:
            body = "{ " + join_with_separator(entry_types, ", ") + " }"
        lines = append_string(lines, vtable.llvm_type_name + " = type " + body)
        index += 1
    return lines

def render_vtable_constants(context):
    lines = []
    index = 0
    while True:
        if index >= len(context.vtables):
            break
        vtable = context.vtables[index]
        entry_values = []
        entry_index = 0
        while True:
            if entry_index >= len(vtable.entries):
                break
            entry = vtable.entries[entry_index]
            sanitized_method = sanitize_symbol(entry.method_name)
            cast_value = "bitcast (" + entry.function_pointer_type + " @" + sanitized_method + " to " + entry.function_pointer_type + ")"
            typed_value = entry.function_pointer_type + " " + cast_value
            entry_values = append_string(entry_values, typed_value)
            entry_index += 1
        body = ""
        if len(entry_values) == 0:
            body = "zeroinitializer"
        else:
            body = "{ " + join_with_separator(entry_values, ", ") + " }"
        lines = append_string(lines, vtable.llvm_global_name + " = internal constant " + vtable.llvm_type_name + " " + body)
        index += 1
    return lines

def render_test_harness_main(tests):
    lines = []
    lines = (lines) + (["define i32 @main(i32 %argc, i8** %argv) {", "entry:"])
    index = 0
    while True:
        if index >= len(tests):
            break
        sym = sanitize_symbol(tests[index].name)
        lines = append_string(lines, "  call void @" + sym + "()")
        index += 1
    lines = (lines) + (["  ret i32 0", "}"])
    return lines

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

def extract_struct_type_from_llvm(llvm_type):
    if len(llvm_type) == 0:
        return ""
    result = ""
    index = 0
    while True:
        if index >= len(llvm_type):
            break
        ch = substring(llvm_type, index, index + 1)
        if ch == "%":
            end_index = index + 1
            while True:
                if end_index >= len(llvm_type):
                    break
                end_ch = substring(llvm_type, end_index, end_index + 1)
                if end_ch == " "  or  end_ch == ","  or  end_ch == "*"  or  end_ch == "}"  or  end_ch == ">":
                    break
                end_index += 1
            if end_index > index + 1:
                result = substring(llvm_type, index, end_index)
                break
        index += 1
    return result

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

def find_function_by_name(functions, name):
    index = 0
    while True:
        if index >= len(functions):
            break
        if functions[index].name == name:
            return functions[index]
        index += 1
    return None

def is_entry_point(entry_points, function_name):
    index = 0
    while True:
        if index >= len(entry_points):
            break
        if entry_points[index] == function_name:
            return True
        index += 1
    return False

def collect_exported_symbol_names(imports):
    names = []
    index = 0
    while True:
        if index >= len(imports):
            break
        entry = imports[index]
        if entry.kind == "export":
            specifiers = entry.specifiers
            spec_index = 0
            while True:
                if spec_index >= len(specifiers):
                    break
                exported = specifiers[spec_index].name
                if len(exported) > 0  and  not string_array_contains(names, exported):
                    names = append_string(names, exported)
                spec_index += 1
        index += 1
    return names

def is_exported_symbol(exported_symbols, function_name):
    index = 0
    while True:
        if index >= len(exported_symbols):
            break
        if exported_symbols[index] == function_name:
            return True
        index += 1
    return False

def should_internalize_function(function, entry_points, exported_symbols, imported_functions):
    if function.is_extern:
        return False
    if is_entry_point(entry_points, function.name):
        return False
    if is_exported_symbol(exported_symbols, function.name):
        return False
    sanitized = sanitize_symbol(function.name)
    if len(sanitized) > 0  and  sanitized[0] == "_":
        return True
    if find_function_by_name(imported_functions, function.name) != None:
        return True
    return True
