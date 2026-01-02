import asyncio
from runtime import runtime_support as runtime

from ...emit_native import NativeModule
from ...native_ir import select_text_artifact, select_layout_manifest_artifact, parse_native_artifact, parse_layout_manifest, NativeFunction, NativeInterface, NativeStruct, NativeEnum, LayoutManifest
from ...string_utils import substring
from ..types import TypeContext, TraitMetadata, TraitDescriptor, TraitImplementationDescriptor, LoweredLLVMResult, FunctionEffectEntry, LifetimeRegionMetadata, StringConstant, CapabilityManifest
from ..utils import append_string, join_with_separator, number_to_string, sanitize_symbol, starts_with, trim_text, index_of
from ..strings import empty_string_constant_set, merge_string_constants, render_string_constants
from ..effects import collect_direct_function_effects, collect_function_call_graph, propagate_function_effects, build_capability_manifest, collect_runtime_helper_targets, append_unique_effect, find_function_effect_entry
from ..rendering import render_test_harness_main, collect_exported_symbol_names, render_struct_type_definitions, render_enum_type_definitions, render_interface_type_definitions, render_vtable_type_definitions, render_vtable_constants, render_trait_metadata_comments, render_runtime_helper_declarations, render_imported_function_declarations, collect_exported_symbol_names, should_internalize_function, find_function_by_name
from ..type_context import fixup_enum_layouts, build_type_context
from ..imports import collect_imported_module_context_for_module, apply_layout_manifest_to_module
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

def lower_to_llvm(native_module):
    # effects: io
    artifact = select_text_artifact(native_module.artifacts)
    if artifact == None:
        return lower_to_llvm_with_context(native_module, [], [], [])
    parse = parse_native_artifact(artifact.contents)
    import_context = collect_imported_module_context_for_module(parse.imports, native_module.module_name)
    return lower_to_llvm_with_context(native_module, import_context.manifests, import_context.native_texts, import_context.diagnostics)

def lower_to_llvm_for_tests(native_module):
    # effects: io
    artifact = select_text_artifact(native_module.artifacts)
    if artifact == None:
        return lower_to_llvm_with_context_for_tests(native_module, [], [], [])
    parse = parse_native_artifact(artifact.contents)
    import_context = collect_imported_module_context_for_module(parse.imports, native_module.module_name)
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
    runtime_helpers = append_unique_effect(runtime_helpers, "grapheme_at")
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
        function_effects = (function_effects) + ([FunctionEffectEntry(name=current_function.name, effects=effective_effects)])
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
        all_string_constants = merge_string_constants(all_string_constants, lowered.string_constants)
        if len(lowered.lines) > 0:
            if len(function_lines) == 0:
                function_lines = lowered.lines
            else:
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
