import asyncio
from runtime import runtime_support as runtime

from ...emit_native import NativeModule
from ...native_ir import select_text_artifact, select_layout_manifest_artifact, parse_native_artifact, parse_layout_manifest, NativeImport, NativeImportSpecifier, NativeFunction, NativeInterface, NativeStruct, NativeEnum, LayoutManifest
from ...string_utils import substring, char_code
from ..types import TypeContext, TraitMetadata, TraitDescriptor, TraitImplementationDescriptor, LoweredLLVMResult, LoweredLLVMLinesResult, FunctionEffectEntry, LifetimeRegionMetadata, StringConstant, CapabilityManifest
from ..utils import append_string, join_with_separator, number_to_string, sanitize_symbol, string_array_contains, starts_with, trim_text, index_of
from ..strings import empty_string_constant_set, merge_string_constants, render_string_constants
from ..effects import collect_direct_function_effects, collect_function_call_graph, propagate_function_effects, build_capability_manifest, collect_runtime_helper_targets, append_unique_effect, find_function_effect_entry
from ..rendering import render_test_harness_main, collect_exported_symbol_names, render_struct_type_definitions, render_enum_type_definitions, render_interface_type_definitions, render_vtable_type_definitions, render_vtable_constants, render_trait_metadata_comments, render_runtime_helper_declarations, render_imported_function_declarations, collect_exported_symbol_names, should_internalize_function, find_function_by_name
from ..type_context import fixup_enum_layouts, build_type_context
from ..imports import collect_imported_module_context_for_module, apply_layout_manifest_to_module, resolve_import_module_slug_for_module
from compiler.build.llvm.lowering.module_globals import lower_module_bindings_to_globals
from compiler.build.llvm.lowering.emission import emit_llvm_function

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


class MangledModuleResult:
    def __init__(self, lines, diagnostics):
        self.lines = lines
        self.diagnostics = diagnostics

    def __repr__(self):
        return runtime.struct_repr('MangledModuleResult', [runtime.struct_field('lines', self.lines), runtime.struct_field('diagnostics', self.diagnostics)])


class DeclareSignature:
    def __init__(self, return_type, param_types):
        self.return_type = return_type
        self.param_types = param_types

    def __repr__(self):
        return runtime.struct_repr('DeclareSignature', [runtime.struct_field('return_type', self.return_type), runtime.struct_field('param_types', self.param_types)])


def empty_trait_metadata():
    return TraitMetadata(interfaces=[], implementations=[])


def is_llvm_symbol_char(ch):
    if len(ch) == 0:
        return False
    if ch == "_":
        return True
    code = char_code(ch)
    lower_a = char_code("a")
    lower_z = char_code("z")
    if code >= lower_a and code <= lower_z:
        return True
    upper_a = char_code("A")
    upper_z = char_code("Z")
    if code >= upper_a and code <= upper_z:
        return True
    zero = char_code("0")
    nine = char_code("9")
    if code >= zero and code <= nine:
        return True
    return False


def sanitize_module_suffix(module_name):
    if len(module_name) == 0:
        return "module"
    out = ""
    index = 0
    while True:
        if index >= len(module_name):
            break
        ch = module_name[index]
        if is_llvm_symbol_char(ch):
            out = out + ch
        else:
            if ch == "/":
                out = out + "__"
            else:
                out = out + "_"
        index += 1
    if len(out) == 0:
        return "module"
    return out


def should_keep_unmangled_abi_symbol(symbol):
    if symbol == "stage2_cli_main":
        return True
    if symbol == "compile_to_sailfin":
        return True
    if symbol == "compile_to_llvm":
        return True
    return False


def extract_module_name_from_native_text(native_text):
    if len(native_text) == 0:
        return ""
    index = 0
    line = ""
    while True:
        if index > len(native_text):
            break
        if index == len(native_text) or native_text[index] == "\n":
            trimmed = trim_text(line)
            if starts_with(trimmed, ".module "):
                return trim_text(substring(trimmed, 8, len(trimmed)))
            line = ""
            index += 1
            continue
        line = line + native_text[index]
        index += 1
    return ""


def collect_available_import_module_names(imported_native_texts):
    names = []
    index = 0
    while True:
        if index >= len(imported_native_texts):
            break
        text = imported_native_texts[index]
        name = extract_module_name_from_native_text(text)
        if len(name) > 0 and not string_array_contains(names, name):
            names = append_string(names, name)
        index += 1
    return names


def resolve_import_provider_module_name(import_path, current_module_slug, available_module_names):
    base = resolve_import_module_slug_for_module(
        import_path, current_module_slug)
    if len(base) == 0:
        return base
    if string_array_contains(available_module_names, base):
        return base
    mod_slug = base + "/mod"
    if string_array_contains(available_module_names, mod_slug):
        return mod_slug
    return base


def collect_defined_function_symbols(lines):
    symbols = []
    index = 0
    while True:
        if index >= len(lines):
            break
        trimmed = trim_text(lines[index])
        if starts_with(trimmed, "define "):
            at_index = index_of(trimmed, "@")
            if at_index >= 0:
                start = at_index + 1
                end = start
                while True:
                    if end >= len(trimmed):
                        break
                    if not is_llvm_symbol_char(trimmed[end]):
                        break
                    end += 1
                if end > start:
                    sym = substring(trimmed, start, end)
                    if not string_array_contains(symbols, sym):
                        symbols = append_string(symbols, sym)
        index += 1
    return symbols


def find_substitution_index(olds, news, symbol):
    index = 0
    while True:
        if index >= len(olds) or index >= len(news):
            break
        if olds[index] == symbol:
            return index
        index += 1
    return -1


def replace_symbol_refs_in_line(line, olds, news):
    if len(olds) == 0:
        return line
    if len(line) == 0:
        return line
    out = ""
    index = 0
    in_string = False
    while True:
        if index >= len(line):
            break
        ch = line[index]
        if ch == "\"":
            in_string = not in_string
            out = out + ch
            index += 1
            continue
        if in_string:
            out = out + ch
            index += 1
            continue
        if ch != "@":
            out = out + ch
            index += 1
            continue
        start = index + 1
        if start >= len(line):
            out = out + ch
            index += 1
            continue
        end = start
        while True:
            if end >= len(line):
                break
            if not is_llvm_symbol_char(line[end]):
                break
            end += 1
        if end == start:
            out = out + ch
            index += 1
            continue
        sym = substring(line, start, end)
        replacement_index = find_substitution_index(olds, news, sym)
        if replacement_index >= 0:
            out = out + "@" + news[replacement_index]
        else:
            out = out + "@" + sym
        index = end
    return out


def apply_symbol_substitutions(lines, olds, news):
    if len(olds) == 0:
        return lines
    out = []
    index = 0
    while True:
        if index >= len(lines):
            break
        out = append_string(
            out, replace_symbol_refs_in_line(lines[index], olds, news))
        index += 1
    return out


def find_declare_signature(lines, symbol):
    if len(symbol) == 0:
        return None
    index = 0
    while True:
        if index >= len(lines):
            break
        trimmed = trim_text(lines[index])
        if starts_with(trimmed, "declare "):
            at_index = index_of(trimmed, "@")
            if at_index >= 0:
                start = at_index + 1
                end = start
                while True:
                    if end >= len(trimmed):
                        break
                    if not is_llvm_symbol_char(trimmed[end]):
                        break
                    end += 1
                if end > start:
                    sym = substring(trimmed, start, end)
                    if sym == symbol:
                        open_index = index_of(trimmed, "(")
                        close_index = index_of(trimmed, ")")
                        if open_index < 0 or close_index < 0 or close_index <= open_index:
                            return None
                        ret_type = trim_text(substring(trimmed, 8, at_index))
                        params_text = trim_text(
                            substring(trimmed, open_index + 1, close_index))
                        if len(params_text) == 0 or params_text == "void":
                            return DeclareSignature(return_type=ret_type, param_types=[])
                        parts = []
                        start_index = 0
                        scan = 0
                        curly_depth = 0
                        angle_depth = 0
                        while True:
                            if scan >= len(params_text):
                                break
                            ch = params_text[scan]
                            if ch == "{":
                                curly_depth += 1
                            else:
                                if ch == "}":
                                    if curly_depth > 0:
                                        curly_depth -= 1
                                else:
                                    if ch == "<":
                                        angle_depth += 1
                                    else:
                                        if ch == ">":
                                            if angle_depth > 0:
                                                angle_depth -= 1
                            if ch == "," and curly_depth == 0 and angle_depth == 0:
                                part = trim_text(
                                    substring(params_text, start_index, scan))
                                if len(part) > 0:
                                    parts = append_string(parts, part)
                                start_index = scan + 1
                            scan += 1
                        final_part = trim_text(
                            substring(params_text, start_index, len(params_text)))
                        if len(final_part) > 0:
                            parts = append_string(parts, final_part)
                        return DeclareSignature(return_type=ret_type, param_types=parts)
        index += 1
    return None


def render_function_shim(export_symbol, target_symbol, signature):
    param_decls = []
    call_args = []
    idx = 0
    while True:
        if idx >= len(signature.param_types):
            break
        ty = trim_text(signature.param_types[idx])
        if ty == "...":
            param_decls = append_string(param_decls, "...")
            idx += 1
            continue
        name = "%a" + number_to_string(idx)
        param_decls = append_string(param_decls, ty + " " + name)
        call_args = append_string(call_args, ty + " " + name)
        idx += 1
    header = "define " + signature.return_type + " @" + export_symbol + \
        "(" + join_with_separator(param_decls, ", ") + ") {"
    if signature.return_type == "void":
        return [header, "entry:", "  call void @" + target_symbol + "(" + join_with_separator(call_args, ", ") + ")", "  ret void", "}"]
    return [header, "entry:", "  %t0 = call " + signature.return_type + " @" + target_symbol + "(" + join_with_separator(call_args, ", ") + ")", "  ret " + signature.return_type + " %t0", "}"]


def insert_before_llvm_footer(lines, inserted):
    if len(inserted) == 0:
        return lines
    footer_index = len(lines)
    index = 0
    while True:
        if index >= len(lines):
            break
        trimmed = trim_text(lines[index])
        if starts_with(trimmed, "attributes ") or starts_with(trimmed, "!"):
            footer_index = index
            break
        index += 1
    out = []
    i = 0
    while True:
        if i >= len(lines):
            break
        if i == footer_index:
            j = 0
            while True:
                if j >= len(inserted):
                    break
                out = append_string(out, inserted[j])
                j += 1
        out = append_string(out, lines[i])
        i += 1
    if footer_index == len(lines):
        j = 0
        while True:
            if j >= len(inserted):
                break
            out = append_string(out, inserted[j])
            j += 1
    return out


def apply_module_symbol_mangling(lines, imports, current_module_slug, imported_native_texts):
    diagnostics = []
    if starts_with(current_module_slug, "runtime/"):
        return MangledModuleResult(lines=lines, diagnostics=diagnostics)
    module_suffix = sanitize_module_suffix(current_module_slug)
    available_modules = collect_available_import_module_names(
        imported_native_texts)
    defined = collect_defined_function_symbols(lines)
    local_olds = []
    local_news = []
    def_index = 0
    while True:
        if def_index >= len(defined):
            break
        sym = defined[def_index]
        if should_keep_unmangled_abi_symbol(sym):
            def_index += 1
            continue
        if index_of(sym, "__") >= 0:
            def_index += 1
            continue
        local_olds = append_string(local_olds, sym)
        local_news = append_string(local_news, sym + "__" + module_suffix)
        def_index += 1
    rewritten = apply_symbol_substitutions(lines, local_olds, local_news)
    import_olds = []
    import_news = []
    shim_exports = []
    shim_targets = []
    import_index = 0
    while True:
        if import_index >= len(imports):
            break
        entry = imports[import_index]
        if entry.kind != "import":
            import_index += 1
            continue
        provider_module = resolve_import_provider_module_name(
            entry.module, current_module_slug, available_modules)
        provider_is_runtime = starts_with(provider_module, "runtime/")
        provider_suffix = sanitize_module_suffix(provider_module)
        spec_index = 0
        while True:
            if spec_index >= len(entry.specifiers):
                break
            spec = entry.specifiers[spec_index]
            imported_name = sanitize_symbol(spec.name)
            local_name = spec.name
            if spec.alias != None and len(spec.alias) > 0:
                local_name = spec.alias
            local_symbol = sanitize_symbol(local_name)
            if should_keep_unmangled_abi_symbol(local_symbol):
                spec_index += 1
                continue
            if string_array_contains(defined, local_symbol):
                diagnostics = append_string(diagnostics, "llvm lowering: import `" + local_symbol +
                                            "` shadows local function in module `" + current_module_slug + "`")
                spec_index += 1
                continue
            if index_of(local_symbol, "__") >= 0:
                spec_index += 1
                continue
            import_olds = append_string(import_olds, local_symbol)
            target_symbol = imported_name
            if not provider_is_runtime:
                target_symbol = imported_name + "__" + provider_suffix
            import_news = append_string(import_news, target_symbol)
            export_sym = local_symbol + "__" + module_suffix
            if not string_array_contains(shim_exports, export_sym):
                shim_exports = append_string(shim_exports, export_sym)
                shim_targets = append_string(shim_targets, target_symbol)
            spec_index += 1
        import_index += 1
    rewritten = apply_symbol_substitutions(rewritten, import_olds, import_news)
    shim_lines = []
    shim_index = 0
    while True:
        if shim_index >= len(shim_exports) or shim_index >= len(shim_targets):
            break
        export_sym = shim_exports[shim_index]
        target_sym = shim_targets[shim_index]
        signature = find_declare_signature(rewritten, target_sym)
        if signature == None:
            shim_index += 1
            continue
        shim_lines = (shim_lines) + \
            (render_function_shim(export_sym, target_sym, signature))
        shim_lines = append_string(shim_lines, "")
        shim_index += 1
    rewritten = insert_before_llvm_footer(rewritten, shim_lines)
    return MangledModuleResult(lines=rewritten, diagnostics=diagnostics)


def empty_capability_manifest():
    return CapabilityManifest(entries=[])


def build_trait_metadata(interfaces, structs):
    interface_descriptors = []
    index = 0
    while True:
        if index >= len(interfaces):
            break
        interface = interfaces[index]
        interface_descriptors = (interface_descriptors) + ([TraitDescriptor(
            name=interface.name, type_parameters=interface.type_parameters, signatures=interface.signatures)])
        index += 1
    implementation_descriptors = []
    index = 0
    while True:
        if index >= len(structs):
            break
        definition = structs[index]
        if len(definition.implements) > 0:
            implementation_descriptors = (implementation_descriptors) + (
                [TraitImplementationDescriptor(struct_name=definition.name, interfaces=definition.implements)])
        index += 1
    return TraitMetadata(interfaces=interface_descriptors, implementations=implementation_descriptors)


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
            qualified = NativeFunction(name=qualified_name, is_async=method.is_async, parameters=method.parameters, return_type=method.return_type,
                                       effects=method.effects, decorators=method.decorators, instructions=method.instructions, is_extern=False)
            result = append_native_function(result, qualified)
            method_index += 1
        index += 1
    return result


def lower_to_llvm(native_module):
    # effects: io
    artifact = select_text_artifact(native_module.artifacts)
    if artifact == None:
        return lower_to_llvm_with_context(native_module, [], [], [])
    parse = parse_native_artifact(artifact.contents)
    import_context = collect_imported_module_context_for_module(
        parse.imports, native_module.module_name)
    return lower_to_llvm_with_context(native_module, import_context.manifests, import_context.native_texts, import_context.diagnostics)


def lower_to_llvm_lines(native_module):
    # effects: io
    artifact = select_text_artifact(native_module.artifacts)
    if artifact == None:
        return lower_to_llvm_lines_with_context(native_module, [], [], [])
    parse = parse_native_artifact(artifact.contents)
    import_context = collect_imported_module_context_for_module(
        parse.imports, native_module.module_name)
    return lower_to_llvm_lines_with_context(native_module, import_context.manifests, import_context.native_texts, import_context.diagnostics)


def lower_to_llvm_lines_only(native_module):
    # effects: io
    lowered = lower_to_llvm_lines(native_module)
    return lowered.lines


def lower_to_llvm_ir(native_module):
    # effects: io
    lowered = lower_to_llvm(native_module)
    return lowered.ir


def lower_to_llvm_for_tests(native_module):
    # effects: io
    artifact = select_text_artifact(native_module.artifacts)
    if artifact == None:
        return lower_to_llvm_with_context_for_tests(native_module, [], [], [])
    parse = parse_native_artifact(artifact.contents)
    import_context = collect_imported_module_context_for_module(
        parse.imports, native_module.module_name)
    return lower_to_llvm_with_context_for_tests(native_module, import_context.manifests, import_context.native_texts, import_context.diagnostics)


def lower_to_llvm_ir_for_tests(native_module):
    # effects: io
    lowered = lower_to_llvm_for_tests(native_module)
    return lowered.ir


def lower_to_llvm_with_manifests(native_module, imported_manifests):
    return lower_to_llvm_with_context(native_module, imported_manifests, [], [])


def lower_to_llvm_with_context_for_tests(native_module, imported_manifests, imported_native_texts, imported_diagnostics):
    base = lower_to_llvm_with_context(
        native_module, imported_manifests, imported_native_texts, imported_diagnostics)
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
        if len(fun.name) >= 5 and substring(fun.name, 0, 5) == "test:":
            tests = (tests) + ([fun])
        index += 1
    if len(tests) == 0:
        return base
    if has_main:
        updated = base
        updated.diagnostics = (updated.diagnostics) + (
            ["llvm lowering (test): module defines `main`; skipping synthesized test harness"])
        return updated
    harness = render_test_harness_main(tests)
    updated = base
    if len(updated.ir) > 0:
        updated.ir = updated.ir + "\n"
    updated.ir = updated.ir + join_with_separator(harness, "\n") + "\n"
    return updated


def lower_to_llvm_with_context(native_module, imported_manifests, imported_native_texts, imported_diagnostics):
    lowered = lower_to_llvm_lines_with_context(
        native_module, imported_manifests, imported_native_texts, imported_diagnostics)
    ir = join_with_separator(lowered.lines, "\n")
    output = ir
    if len(output) > 0:
        output = output + "\n"
    return LoweredLLVMResult(ir=output, diagnostics=lowered.diagnostics, trait_metadata=lowered.trait_metadata, function_effects=lowered.function_effects, lifetime_regions=lowered.lifetime_regions, capability_manifest=lowered.capability_manifest, string_constants=lowered.string_constants)


def lower_to_llvm_lines_with_context(native_module, imported_manifests, imported_native_texts, imported_diagnostics):
    diagnostics = []
    if len(imported_diagnostics) > 0:
        diagnostics = (diagnostics) + (imported_diagnostics)
    artifact = select_text_artifact(native_module.artifacts)
    if artifact == None:
        diagnostics = append_string(
            diagnostics, "no sailfin-native-text artifact present")
        empty_constants = empty_string_constant_set()
        return LoweredLLVMLinesResult(lines=[], diagnostics=diagnostics, trait_metadata=empty_trait_metadata(), function_effects=[], lifetime_regions=[], capability_manifest=empty_capability_manifest(), string_constants=empty_constants)
    parse = parse_native_artifact(artifact.contents)
    diagnostics = (diagnostics) + (parse.diagnostics)
    exported_symbols = collect_exported_symbol_names(parse.imports)
    manifest_artifact = select_layout_manifest_artifact(
        native_module.artifacts)
    module_manifest = None
    if manifest_artifact != None:
        parsed_manifest = parse_layout_manifest(manifest_artifact.contents)
        diagnostics = (diagnostics) + (parsed_manifest.diagnostics)
        module_manifest = parsed_manifest
    manifest_application = apply_layout_manifest_to_module(
        parse.structs, parse.enums, module_manifest)
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
        applied_import = apply_layout_manifest_to_module(
            imported_parse.structs, imported_parse.enums, manifest_for_module)
        imported_structs = (imported_structs) + (applied_import.structs)
        imported_enums = (imported_enums) + (applied_import.enums)
        imported_interfaces = (imported_interfaces) + \
            (imported_parse.interfaces)
        imported_functions = (imported_functions) + (imported_parse.functions)
        imported_methods = flatten_struct_methods(applied_import.structs)
        imported_struct_methods = (
            imported_struct_methods) + (imported_methods)
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
    trait_metadata = build_trait_metadata(
        combined_interfaces, combined_structs)
    fixed_enums = fixup_enum_layouts(combined_enums)
    diagnostics = (diagnostics) + (fixed_enums.diagnostics)
    type_build = build_type_context(
        combined_structs, fixed_enums.enums, combined_interfaces)
    diagnostics = (diagnostics) + (type_build.diagnostics)
    type_context = type_build.context
    module_struct_methods = flatten_struct_methods(module_structs)
    local_functions = concat_native_functions(
        parse.functions, module_struct_methods)
    context_functions = concat_native_functions(
        local_functions, imported_functions)
    context_functions = concat_native_functions(
        context_functions, imported_struct_methods)
    runtime_helpers = collect_runtime_helper_targets(local_functions)
    if not string_array_contains(runtime_helpers, "copy_bytes"):
        runtime_helpers = append_string(runtime_helpers, "copy_bytes")
    runtime_helpers = append_unique_effect(runtime_helpers, "get_field")
    runtime_helpers = append_unique_effect(runtime_helpers, "string.concat")
    runtime_helpers = append_unique_effect(runtime_helpers, "grapheme_at")
    runtime_helpers = append_unique_effect(runtime_helpers, "number.to_string")
    runtime_helpers = append_unique_effect(runtime_helpers, "strings_equal")
    runtime_helpers = append_unique_effect(
        runtime_helpers, "runtime.bounds_check")
    runtime_helpers = append_unique_effect(runtime_helpers, "mark_persistent")
    direct_effects = collect_direct_function_effects(context_functions)
    call_graph = collect_function_call_graph(context_functions)
    aggregated_effects = propagate_function_effects(direct_effects, call_graph)
    function_effects = []
    lifetime_regions = []
    lines = []
    lines = append_string(lines, "source_filename = \"" +
                          module_source_filename(native_module.module_name) + "\"")
    lines = append_string(lines, "")
    trait_lines = render_trait_metadata_comments(trait_metadata)
    if len(trait_lines) > 0:
        lines = extend_string_lines(lines, trait_lines)
        lines = append_string(lines, "")
    struct_type_lines = render_struct_type_definitions(
        type_context, context_functions)
    if len(struct_type_lines) > 0:
        lines = extend_string_lines(lines, struct_type_lines)
        lines = append_string(lines, "")
    enum_type_lines = render_enum_type_definitions(type_context)
    if len(enum_type_lines) > 0:
        lines = extend_string_lines(lines, enum_type_lines)
        lines = append_string(lines, "")
    interface_type_lines = render_interface_type_definitions(type_context)
    if len(interface_type_lines) > 0:
        lines = extend_string_lines(lines, interface_type_lines)
        lines = append_string(lines, "")
    lines = extend_string_lines(lines, ["%SailfinFutureNumber = type opaque", "%SailfinFutureBool = type opaque", "%SailfinFuturePtr = type opaque", "%SailfinFutureVoid = type opaque", "%SailfinFutureString = type opaque", "", "declare %SailfinFutureNumber* @sailfin_runtime_spawn_number(double ()*)", "declare %SailfinFutureNumber* @sailfin_runtime_spawn_number_ctx(double (i8*)*, i8*)", "declare double @sailfin_runtime_await_number(%SailfinFutureNumber*)", "declare %SailfinFutureBool* @sailfin_runtime_spawn_bool(i1 ()*)", "declare %SailfinFutureBool* @sailfin_runtime_spawn_bool_ctx(i1 (i8*)*, i8*)", "declare i1 @sailfin_runtime_await_bool(%SailfinFutureBool*)",
                                "declare %SailfinFuturePtr* @sailfin_runtime_spawn_ptr(i8* ()*)", "declare %SailfinFuturePtr* @sailfin_runtime_spawn_ptr_ctx(i8* (i8*)*, i8*)", "declare i8* @sailfin_runtime_await_ptr(%SailfinFuturePtr*)", "declare %SailfinFutureVoid* @sailfin_runtime_spawn_void(void ()*)", "declare %SailfinFutureVoid* @sailfin_runtime_spawn_void_ctx(void (i8*)*, i8*)", "declare void @sailfin_runtime_await_void(%SailfinFutureVoid*)", "declare %SailfinFutureString* @sailfin_runtime_spawn_string(i8* ()*)", "declare %SailfinFutureString* @sailfin_runtime_spawn_string_ctx(i8* (i8*)*, i8*)", "declare i8* @sailfin_runtime_await_string(%SailfinFutureString*)", ""])
    vtable_type_lines = render_vtable_type_definitions(type_context)
    if len(vtable_type_lines) > 0:
        lines = extend_string_lines(lines, vtable_type_lines)
        lines = append_string(lines, "")
    vtable_const_lines = render_vtable_constants(type_context)
    if len(vtable_const_lines) > 0:
        lines = extend_string_lines(lines, vtable_const_lines)
        lines = append_string(lines, "")
    helper_declarations = render_runtime_helper_declarations(
        runtime_helpers, local_functions)
    if len(helper_declarations) > 0:
        lines = extend_string_lines(lines, helper_declarations)
        lines = append_string(lines, "")
    imported_declarations = render_imported_function_declarations(
        imported_functions, local_functions, type_context)
    if len(imported_declarations) > 0:
        lines = extend_string_lines(lines, imported_declarations)
        lines = append_string(lines, "")
    if find_function_by_name(context_functions, "malloc") == None:
        lines = append_string(lines, "declare noalias i8* @malloc(i64)")
    if find_function_by_name(context_functions, "free") == None:
        lines = append_string(lines, "declare void @free(i8*)")
    lines = append_string(lines, "")
    lines = append_string(lines, "@runtime = external global i8**")
    lines = append_string(lines, "")
    module_globals = lower_module_bindings_to_globals(
        parse.bindings, type_context, native_module.module_name)
    diagnostics = (diagnostics) + (module_globals.diagnostics)
    if len(module_globals.preamble_lines) > 0:
        lines = extend_string_lines(lines, module_globals.preamble_lines)
        lines = append_string(lines, "")
    if len(module_globals.init_function_lines) > 0:
        lines = extend_string_lines(lines, module_globals.init_function_lines)
        lines = append_string(lines, "")
    index = 0
    has_add_function = False
    all_string_constants = module_globals.string_constants
    while True:
        if index >= len(local_functions):
            break
        current_function = local_functions[index]
        aggregated_entry = find_function_effect_entry(
            aggregated_effects, current_function.name)
        effective_effects = []
        if aggregated_entry != None:
            effective_effects = aggregated_entry.effects
        function_effects = (function_effects) + (
            [FunctionEffectEntry(name=current_function.name, effects=effective_effects)])
        lowered = emit_llvm_function(
            current_function,
            context_functions,
            effective_effects,
            type_context,
            native_module.module_name,
            native_module.entry_points,
            exported_symbols,
            imported_functions,
            module_globals.locals,
            module_globals.init_function_symbol,
            module_globals.needs_init_call
        )
        if sanitize_symbol(current_function.name) == "add":
            has_add_function = True
        diagnostics = (diagnostics) + (lowered.diagnostics)
        lifetime_regions = (lifetime_regions) + (lowered.lifetime_regions)
        all_string_constants = merge_string_constants(
            all_string_constants, lowered.string_constants)
        if len(lowered.lines) > 0:
            lines = extend_string_lines(lines, lowered.lines)
            if index + 1 < len(local_functions):
                lines = append_string(lines, "")
        index += 1
    if not has_add_function:
        lines = append_string(lines, "")
        lines = extend_string_lines(lines, [
                                    "define internal double @add(double %a, double %b) {", "entry:", "  %t0 = fadd double %a, %b", "  ret double %t0", "}"])
    string_constant_lines = render_string_constants(all_string_constants)
    if len(string_constant_lines) > 0:
        lines = append_string(lines, "")
        lines = extend_string_lines(lines, string_constant_lines)
        lines = append_string(lines, "")
    lines = ensure_intrinsic_declarations(lines)
    mangled = apply_module_symbol_mangling(
        lines, parse.imports, native_module.module_name, imported_native_texts)
    diagnostics = (diagnostics) + (mangled.diagnostics)
    lines = mangled.lines
    manifest = build_capability_manifest(
        native_module.entry_points, function_effects)
    return LoweredLLVMLinesResult(lines=lines, diagnostics=diagnostics, trait_metadata=trait_metadata, function_effects=function_effects, lifetime_regions=lifetime_regions, capability_manifest=manifest, string_constants=all_string_constants)


def extend_string_lines(values, extras):
    out = values
    index = 0
    while True:
        if index >= len(extras):
            break
        out = append_string(out, extras[index])
        index += 1
    return out


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
    if not uses_round or has_round_decl:
        return lines
    out = lines
    out = append_string(out, "")
    out = append_string(out, "declare double @round(double)")
    return out


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
