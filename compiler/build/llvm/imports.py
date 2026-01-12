import asyncio
from runtime import runtime_support as runtime

from ..native_ir import NativeImport, NativeStruct, NativeEnum, LayoutManifest, parse_layout_manifest
from ..string_utils import substring
from compiler.build.llvm.types import ImportedModuleContext, LayoutManifestApplication
from compiler.build.llvm.utils import trim_text, append_string, string_array_contains, number_to_string, starts_with, ends_with, join_with_separator

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

def load_imported_layout_manifests(imports):
    # effects: io
    context = collect_imported_module_context(imports)
    return context.manifests

def collect_imported_module_context(imports):
    # effects: io
    return collect_imported_module_context_for_module(imports, "")

def collect_imported_module_context_for_module(imports, current_module_slug):
    # effects: io
    trace = fs.exists("build/sailfin/.trace_test_runner")  and  fs.exists("build/sailfin/.test_runner_active")
    if trace:
        print.info("test llvm: collect_imported_module_context start (imports=" + number_to_string(len(imports)) + ")")
    manifests = []
    native_texts = []
    diagnostics = []
    seen = []
    index = 0
    while True:
        if index >= len(imports):
            break
        if trace  and  index > 0  and  index % 50 == 0:
            print.info("test llvm: collect_imported_module_context progress (index=" + number_to_string(index) + ")")
        module_path = imports[index].module
        base_slug = resolve_import_module_slug_for_module(module_path, current_module_slug)
        slug = resolve_import_artifact_slug(base_slug)
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
    if trace:
        print.info("test llvm: collect_imported_module_context done (unique_imports=" + number_to_string(len(seen)) + ")")
    return ImportedModuleContext(manifests=manifests, native_texts=native_texts, diagnostics=diagnostics)

def resolve_import_artifact_slug(slug):
    # effects: io
    if len(slug) == 0:
        return slug
    if fs.exists(layout_manifest_path_for_slug(slug)):
        return slug
    if not ends_with(slug, "/mod"):
        mod_slug = slug + "/mod"
        if fs.exists(layout_manifest_path_for_slug(mod_slug)):
            return mod_slug
    return slug

def resolve_import_module_slug(module):
    return resolve_import_module_slug_for_module(module, "")

def dirname_for_module_slug(slug):
    last_slash = -1
    index = 0
    while True:
        if index >= len(slug):
            break
        if slug[index] == "/":
            last_slash = index
        index += 1
    if last_slash < 0:
        return ""
    return substring(slug, 0, last_slash)

def resolve_import_module_slug_for_module(module, current_module_slug):
    trimmed = trim_text(module)
    if len(trimmed) == 0:
        return ""
    normalized = normalize_import_module_path(trimmed)
    if starts_with(normalized, "./")  or  starts_with(normalized, "../"):
        base_dir = dirname_for_module_slug(current_module_slug)
        if len(base_dir) > 0:
            normalized = base_dir + "/" + normalized
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

def replace_native_struct(structs, index, replacement):
    result = []
    i = 0
    while True:
        if i >= len(structs):
            break
        if i == index:
            result.append(replacement)
        else:
            result.append(structs[i])
        i += 1
    return result

def replace_native_enum(enums, index, replacement):
    result = []
    i = 0
    while True:
        if i >= len(enums):
            break
        if i == index:
            result.append(replacement)
        else:
            result.append(enums[i])
        i += 1
    return result
