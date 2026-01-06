import asyncio
from runtime import runtime_support as runtime

from compiler.build.parser import parse_program
from compiler.build.ast import Program
from compiler.build.emitter_sailfin import emit_program
from compiler.build.emit_native import emit_native, emit_native_with_module_name, EmitNativeResult, NativeModule
from compiler.build.native_lowering import lower_to_python, LoweredPythonResult
from compiler.build.llvm.lowering.entrypoints import lower_to_llvm, lower_to_llvm_for_tests, lower_to_llvm_ir, lower_to_llvm_ir_for_tests, lower_to_llvm_lines_only, lower_to_llvm_with_manifests, lower_to_llvm_with_context
from compiler.build.native_ir import LayoutManifest, parse_layout_manifest
from compiler.build.string_utils import substring
from compiler.build.token import Token
from compiler.build.typecheck import typecheck_program

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

class CompiledModule:
    def __init__(self, source_path, python_source):
        self.source_path = source_path
        self.python_source = python_source

    def __repr__(self):
        return runtime.struct_repr('CompiledModule', [runtime.struct_field('source_path', self.source_path), runtime.struct_field('python_source', self.python_source)])

class ModuleDiagnostics:
    def __init__(self, source_path, messages, fatal):
        self.source_path = source_path
        self.messages = messages
        self.fatal = fatal

    def __repr__(self):
        return runtime.struct_repr('ModuleDiagnostics', [runtime.struct_field('source_path', self.source_path), runtime.struct_field('messages', self.messages), runtime.struct_field('fatal', self.fatal)])

class ModuleCompilationResult:
    def __init__(self, diagnostics, module=None):
        self.module = module
        self.diagnostics = diagnostics

    def __repr__(self):
        return runtime.struct_repr('ModuleCompilationResult', [runtime.struct_field('module', self.module), runtime.struct_field('diagnostics', self.diagnostics)])

class ProjectCompilation:
    def __init__(self, modules, diagnostics):
        self.modules = modules
        self.diagnostics = diagnostics

    def __repr__(self):
        return runtime.struct_repr('ProjectCompilation', [runtime.struct_field('modules', self.modules), runtime.struct_field('diagnostics', self.diagnostics)])

class LLVMCompilationResult:
    def __init__(self, llvm, native_module):
        self.llvm = llvm
        self.native_module = native_module

    def __repr__(self):
        return runtime.struct_repr('LLVMCompilationResult', [runtime.struct_field('llvm', self.llvm), runtime.struct_field('native_module', self.native_module)])

class LoweredLLVMResult:
    def __init__(self, ir, diagnostics, trait_metadata, function_effects, lifetime_regions, capability_manifest, string_constants):
        self.ir = ir
        self.diagnostics = diagnostics
        self.trait_metadata = trait_metadata
        self.function_effects = function_effects
        self.lifetime_regions = lifetime_regions
        self.capability_manifest = capability_manifest
        self.string_constants = string_constants

    def __repr__(self):
        return runtime.struct_repr('LoweredLLVMResult', [runtime.struct_field('ir', self.ir), runtime.struct_field('diagnostics', self.diagnostics), runtime.struct_field('trait_metadata', self.trait_metadata), runtime.struct_field('function_effects', self.function_effects), runtime.struct_field('lifetime_regions', self.lifetime_regions), runtime.struct_field('capability_manifest', self.capability_manifest), runtime.struct_field('string_constants', self.string_constants)])

def compile_to_sailfin(source):
    # effects: io
    program = parse_program(source)
    analysis_result = typecheck_program(program)
    if len(analysis_result.diagnostics) > 0:
        report_typecheck_errors(analysis_result.diagnostics, source)
        return ""
    return emit_program(program)

def compile_to_native(source):
    # effects: io
    program = parse_program(source)
    analysis_result = typecheck_program(program)
    if len(analysis_result.diagnostics) > 0:
        report_typecheck_errors(analysis_result.diagnostics, source)
        return EmitNativeResult(module=empty_native_module(), diagnostics=format_typecheck_diagnostics(analysis_result.diagnostics, source))
    return emit_native(program)

def module_name_from_path(source_path):
    if len(source_path) == 0:
        return "main"
    normalized = ""
    index = 0
    while True:
        if index >= len(source_path):
            break
        ch = source_path[index]
        if ch == "\\":
            normalized = normalized + "/"
        else:
            normalized = normalized + ch
        index += 1
    compiler_prefix = "compiler/src/"
    runtime_prefix = "runtime/"
    start = 0
    last_compiler = -1
    index = 0
    while True:
        if index + len(compiler_prefix) > len(normalized):
            break
        if substring(normalized, index, index + len(compiler_prefix)) == compiler_prefix:
            last_compiler = index
        index += 1
    if last_compiler >= 0:
        start = last_compiler + len(compiler_prefix)
    else:
        last_runtime = -1
        index = 0
        while True:
            if index + len(runtime_prefix) > len(normalized):
                break
            if substring(normalized, index, index + len(runtime_prefix)) == runtime_prefix:
                last_runtime = index
            index += 1
        if last_runtime >= 0:
            start = last_runtime
    last_slash = -1
    index = start
    while True:
        if index >= len(normalized):
            break
        if normalized[index] == "/":
            last_slash = index
        index += 1
    end = len(normalized)
    dot_index = -1
    index = len(normalized)
    dot_limit = last_slash + 1
    while True:
        if index <= dot_limit:
            break
        index -= 1
        if normalized[index] == ".":
            dot_index = index
            break
    if dot_index >= 0:
        end = dot_index
    if end <= start:
        return "main"
    base = substring(normalized, start, end)
    if len(base) == 0:
        return "main"
    return base

def compile_to_native_python(source):
    # effects: io
    native_result = compile_to_native(source)
    lowered = lower_to_python(native_result.module, "main")
    combined = []
    combined = (combined) + (native_result.diagnostics)
    combined = (combined) + (lowered.diagnostics)
    if len(combined) > 0:
        index = 0
        while True:
            if index >= len(combined):
                break
            print.warn("[native] " + combined[index])
            index += 1
    return LoweredPythonResult(source=lowered.source, diagnostics=combined)

def compile_to_native_llvm(source):
    # effects: io
    native_result = compile_to_native(source)
    lowered = lower_to_llvm(native_result.module)
    combined = []
    combined = (combined) + (native_result.diagnostics)
    combined = (combined) + (lowered.diagnostics)
    if len(combined) > 0:
        index = 0
        while True:
            if index >= len(combined):
                break
            print.warn("[native-llvm] " + combined[index])
            index += 1
    return LoweredLLVMResult(ir=lowered.ir, diagnostics=combined, trait_metadata=lowered.trait_metadata, function_effects=lowered.function_effects, lifetime_regions=lowered.lifetime_regions, capability_manifest=lowered.capability_manifest, string_constants=lowered.string_constants)

def compile_to_native_llvm_with_module(source, module_name):
    # effects: io
    program = parse_program(source)
    analysis_result = typecheck_program(program)
    if len(analysis_result.diagnostics) > 0:
        report_typecheck_errors(analysis_result.diagnostics, source)
        messages = format_typecheck_diagnostics(analysis_result.diagnostics, source)
        return LoweredLLVMResult(ir="", diagnostics=messages, trait_metadata=None, function_effects=None, lifetime_regions=None, capability_manifest=None, string_constants=None)
    native_result = emit_native_with_module_name(program, module_name)
    lowered = lower_to_llvm(native_result.module)
    combined = []
    combined = (combined) + (native_result.diagnostics)
    combined = (combined) + (lowered.diagnostics)
    if len(combined) > 0:
        index = 0
        while True:
            if index >= len(combined):
                break
            print.warn("[native-llvm] " + combined[index])
            index += 1
    return LoweredLLVMResult(ir=lowered.ir, diagnostics=combined, trait_metadata=lowered.trait_metadata, function_effects=lowered.function_effects, lifetime_regions=lowered.lifetime_regions, capability_manifest=lowered.capability_manifest, string_constants=lowered.string_constants)

def compile_to_llvm(source):
    # effects: io
    native_result = compile_to_native(source)
    return lower_to_llvm_ir(native_result.module)

def compile_to_llvm_with_module(source, module_name):
    # effects: io
    program = parse_program(source)
    analysis_result = typecheck_program(program)
    if len(analysis_result.diagnostics) > 0:
        report_typecheck_errors(analysis_result.diagnostics, source)
        return ""
    native_result = emit_native_with_module_name(program, module_name)
    return lower_to_llvm_ir(native_result.module)

def compile_to_llvm_lines_with_module(source, module_name):
    # effects: io
    program = parse_program(source)
    analysis_result = typecheck_program(program)
    if len(analysis_result.diagnostics) > 0:
        report_typecheck_errors(analysis_result.diagnostics, source)
        return []
    native_result = emit_native_with_module_name(program, module_name)
    return lower_to_llvm_lines_only(native_result.module)

def compile_tests_to_llvm(source):
    # effects: io
    trace = fs.exists("build/sailfin/.trace_test_runner")  and  fs.exists("build/sailfin/.test_runner_active")
    if trace:
        print.info("test compiler: compile_to_native start")
    native_result = compile_to_native(source)
    if trace:
        print.info("test compiler: compile_to_native done (diagnostics=" + number_to_string(len(native_result.diagnostics)) + ")")
        print.info("test compiler: lower_to_llvm_for_tests start")
    ir = lower_to_llvm_ir_for_tests(native_result.module)
    if trace:
        print.info("test compiler: lower_to_llvm_for_tests done (ir_bytes=" + number_to_string(len(ir)) + ")")
    return ir

def compile_tests_to_llvm_with_module(source, module_name):
    # effects: io
    trace = fs.exists("build/sailfin/.trace_test_runner")  and  fs.exists("build/sailfin/.test_runner_active")
    if trace:
        print.info("test compiler: parse_program start")
    program = parse_program(source)
    analysis_result = typecheck_program(program)
    if len(analysis_result.diagnostics) > 0:
        report_typecheck_errors(analysis_result.diagnostics, source)
        return ""
    if trace:
        print.info("test compiler: emit_native_with_module_name start (module=" + module_name + ")")
    native_result = emit_native_with_module_name(program, module_name)
    if trace:
        print.info("test compiler: lower_to_llvm_for_tests start")
    return lower_to_llvm_ir_for_tests(native_result.module)

def compile_to_native_text(source):
    # effects: io
    native_result = compile_to_native(source)
    index = 0
    while True:
        if index >= len(native_result.module.artifacts):
            break
        artifact = native_result.module.artifacts[index]
        if artifact.format == "sailfin-native-text":
            return artifact.contents
        index += 1
    return ""

def compile_to_native_llvm_full(source):
    # effects: io
    native_result = compile_to_native(source)
    lowered = lower_to_llvm(native_result.module)
    combined = []
    combined = (combined) + (native_result.diagnostics)
    combined = (combined) + (lowered.diagnostics)
    if len(combined) > 0:
        index = 0
        while True:
            if index >= len(combined):
                break
            print.warn("[native-llvm] " + combined[index])
            index += 1
    return LLVMCompilationResult(llvm=LoweredLLVMResult(ir=lowered.ir, diagnostics=combined, trait_metadata=lowered.trait_metadata, function_effects=lowered.function_effects, lifetime_regions=lowered.lifetime_regions, capability_manifest=lowered.capability_manifest, string_constants=lowered.string_constants), native_module=native_result.module)

def compile_to_native_llvm_full_with_module(source, module_name):
    # effects: io
    program = parse_program(source)
    analysis_result = typecheck_program(program)
    if len(analysis_result.diagnostics) > 0:
        report_typecheck_errors(analysis_result.diagnostics, source)
        messages = format_typecheck_diagnostics(analysis_result.diagnostics, source)
        return LLVMCompilationResult(llvm=LoweredLLVMResult(ir="", diagnostics=messages, trait_metadata=None, function_effects=None, lifetime_regions=None, capability_manifest=None, string_constants=None), native_module=None)
    native_result = emit_native_with_module_name(program, module_name)
    lowered = lower_to_llvm(native_result.module)
    combined = []
    combined = (combined) + (native_result.diagnostics)
    combined = (combined) + (lowered.diagnostics)
    if len(combined) > 0:
        index = 0
        while True:
            if index >= len(combined):
                break
            print.warn("[native-llvm] " + combined[index])
            index += 1
    return LLVMCompilationResult(llvm=LoweredLLVMResult(ir=lowered.ir, diagnostics=combined, trait_metadata=lowered.trait_metadata, function_effects=lowered.function_effects, lifetime_regions=lowered.lifetime_regions, capability_manifest=lowered.capability_manifest, string_constants=lowered.string_constants), native_module=native_result.module)

def compile_to_native_llvm_with_context(source, manifest_contents, native_artifacts):
    # effects: io
    native_result = compile_to_native(source)
    manifests = []
    manifest_index = 0
    while True:
        if manifest_index >= len(manifest_contents):
            break
        manifest_text = manifest_contents[manifest_index]
        if len(manifest_text) == 0:
            manifests = (manifests) + ([LayoutManifest(structs=[], enums=[], diagnostics=[])])
        else:
            parsed = parse_layout_manifest(manifest_text)
            manifests = (manifests) + ([LayoutManifest(structs=parsed.structs, enums=parsed.enums, diagnostics=[])])
        manifest_index += 1
    lowered = lower_to_llvm_with_context(native_result.module, manifests, native_artifacts, [])
    combined = []
    combined = (combined) + (native_result.diagnostics)
    combined = (combined) + (lowered.diagnostics)
    if len(combined) > 0:
        index = 0
        while True:
            if index >= len(combined):
                break
            print.warn("[native-llvm] " + combined[index])
            index += 1
    return LoweredLLVMResult(ir=lowered.ir, diagnostics=combined, trait_metadata=lowered.trait_metadata, function_effects=lowered.function_effects, lifetime_regions=lowered.lifetime_regions, capability_manifest=lowered.capability_manifest, string_constants=lowered.string_constants)

def compile_to_native_llvm_with_context_with_module(source, module_name, manifest_contents, native_artifacts):
    # effects: io
    program = parse_program(source)
    analysis_result = typecheck_program(program)
    if len(analysis_result.diagnostics) > 0:
        report_typecheck_errors(analysis_result.diagnostics, source)
        messages = format_typecheck_diagnostics(analysis_result.diagnostics, source)
        return LoweredLLVMResult(ir="", diagnostics=messages, trait_metadata=None, function_effects=None, lifetime_regions=None, capability_manifest=None, string_constants=None)
    native_result = emit_native_with_module_name(program, module_name)
    manifests = []
    manifest_index = 0
    while True:
        if manifest_index >= len(manifest_contents):
            break
        manifest_text = manifest_contents[manifest_index]
        if len(manifest_text) == 0:
            manifests = (manifests) + ([LayoutManifest(structs=[], enums=[], diagnostics=[])])
        else:
            parsed = parse_layout_manifest(manifest_text)
            manifests = (manifests) + ([LayoutManifest(structs=parsed.structs, enums=parsed.enums, diagnostics=[])])
        manifest_index += 1
    lowered = lower_to_llvm_with_context(native_result.module, manifests, native_artifacts, [])
    combined = []
    combined = (combined) + (native_result.diagnostics)
    combined = (combined) + (lowered.diagnostics)
    if len(combined) > 0:
        index = 0
        while True:
            if index >= len(combined):
                break
            print.warn("[native-llvm] " + combined[index])
            index += 1
    return LoweredLLVMResult(ir=lowered.ir, diagnostics=combined, trait_metadata=lowered.trait_metadata, function_effects=lowered.function_effects, lifetime_regions=lowered.lifetime_regions, capability_manifest=lowered.capability_manifest, string_constants=lowered.string_constants)

def compile_to_native_llvm_with_context_with_module_and_entry_points(source, module_name, manifest_contents, native_artifacts, entry_points):
    # effects: io
    program = parse_program(source)
    analysis_result = typecheck_program(program)
    if len(analysis_result.diagnostics) > 0:
        report_typecheck_errors(analysis_result.diagnostics, source)
        messages = format_typecheck_diagnostics(analysis_result.diagnostics, source)
        return LoweredLLVMResult(ir="", diagnostics=messages, trait_metadata=None, function_effects=None, lifetime_regions=None, capability_manifest=None, string_constants=None)
    native_result = emit_native_with_module_name(program, module_name)
    overridden_module = NativeModule(module_name=native_result.module.module_name, artifacts=native_result.module.artifacts, entry_points=entry_points, symbol_count=native_result.module.symbol_count)
    manifests = []
    manifest_index = 0
    while True:
        if manifest_index >= len(manifest_contents):
            break
        manifest_text = manifest_contents[manifest_index]
        if len(manifest_text) == 0:
            manifests = (manifests) + ([LayoutManifest(structs=[], enums=[], diagnostics=[])])
        else:
            parsed = parse_layout_manifest(manifest_text)
            manifests = (manifests) + ([LayoutManifest(structs=parsed.structs, enums=parsed.enums, diagnostics=[])])
        manifest_index += 1
    lowered = lower_to_llvm_with_context(overridden_module, manifests, native_artifacts, [])
    combined = []
    combined = (combined) + (native_result.diagnostics)
    combined = (combined) + (lowered.diagnostics)
    if len(combined) > 0:
        index = 0
        while True:
            if index >= len(combined):
                break
            print.warn("[native-llvm] " + combined[index])
            index += 1
    return LoweredLLVMResult(ir=lowered.ir, diagnostics=combined, trait_metadata=lowered.trait_metadata, function_effects=lowered.function_effects, lifetime_regions=lowered.lifetime_regions, capability_manifest=lowered.capability_manifest, string_constants=lowered.string_constants)

def compile_to_native_llvm_with_manifests(source, manifest_contents):
    # effects: io
    return compile_to_native_llvm_with_context(source, manifest_contents, [])

def stage2_compiler_main():
    # effects: io
    print.info("Sailfin compiler")

def compile_project(sources):
    # effects: io
    modules = []
    diagnostics = []
    for source_path in sources:
        result = compile_source_at_path(source_path)
        if result.module != None:
            modules = (modules) + ([result.module])
        if len(result.diagnostics) > 0:
            diagnostics = (diagnostics) + (result.diagnostics)
    return ProjectCompilation(modules=modules, diagnostics=diagnostics)

def compile_source_at_path(source_path):
    # effects: io
    source = fs.readFile(source_path)
    program = parse_program(source)
    analysis = typecheck_program(program)
    if len(analysis.diagnostics) > 0:
        return ModuleCompilationResult(module=None, diagnostics=[ModuleDiagnostics(source_path=source_path, messages=format_typecheck_diagnostics(analysis.diagnostics, source), fatal=True)])
    module_name = module_name_from_path(source_path)
    native_result = emit_native_with_module_name(program, module_name)
    lowered = lower_to_python(native_result.module, module_name)
    messages = (native_result.diagnostics) + (lowered.diagnostics)
    python_source = lowered.source
    entry_list = []
    if len(messages) > 0:
        entry_list = [ModuleDiagnostics(source_path=source_path, messages=messages, fatal=False)]
    return ModuleCompilationResult(module=CompiledModule(source_path=source_path, python_source=python_source), diagnostics=entry_list)

def format_typecheck_diagnostics(entries, source):
    lines = split_source_lines(source)
    padding_width = len(number_to_string(len(lines)))
    if padding_width < 1:
        padding_width = 1
    messages = []
    index = 0
    while True:
        if index >= len(entries):
            break
        formatted = format_typecheck_diagnostic(entries[index], lines, padding_width)
        messages = append_string(messages, formatted)
        index += 1
    return messages

def report_typecheck_errors(entries, source):
    # effects: io
    formatted = format_typecheck_diagnostics(entries, source)
    prefix = "[typecheck] "
    padding = repeat_character(" ", len(prefix))
    index = 0
    while True:
        if index >= len(formatted):
            break
        message = formatted[index]
        lines = split_source_lines(message)
        if len(lines) == 0:
            print.error(prefix)
            index += 1
            continue
        line_index = 0
        while True:
            if line_index >= len(lines):
                break
            if line_index == 0:
                print.error(prefix + lines[line_index])
            else:
                print.error(padding + lines[line_index])
            line_index += 1
        index += 1

def format_typecheck_diagnostic(entry, source_lines, line_padding):
    if entry.primary == None:
        return entry.message
    parts = []
    parts = append_string(parts, entry.message)
    token = entry.primary
    line_number = token.line
    column_number = token.column
    location = "  --> line " + number_to_string(line_number) + ", column " + number_to_string(column_number)
    parts = append_string(parts, location)
    if line_number < 1  or  line_number > len(source_lines):
        return join_lines(parts)
    line_text = source_lines[line_number - 1]
    gutter_spaces = repeat_character(" ", line_padding)
    parts = append_string(parts, " " + gutter_spaces + " |")
    line_number_text = number_to_string(line_number)
    prefix_padding = ""
    pad_count = line_padding - len(line_number_text)
    if pad_count < 0:
        pad_count = 0
    if pad_count > 0:
        prefix_padding = repeat_character(" ", pad_count)
    parts = append_string(parts, " " + prefix_padding + line_number_text + " | " + line_text)
    pointer = build_pointer_line(column_number, token.lexeme, line_text)
    parts = append_string(parts, " " + gutter_spaces + " | " + pointer)
    return join_lines(parts)

def split_source_lines(source):
    lines = []
    current = ""
    index = 0
    while True:
        if index >= len(source):
            break
        ch = substring(source, index, index + 1)
        if ch == "\r":
            lines = append_string(lines, current)
            current = ""
            if index + 1 < len(source):
                next = substring(source, index + 1, index + 2)
                if next == "\n":
                    index += 2
                    continue
            index += 1
            continue
        if ch == "\n":
            lines = append_string(lines, current)
            current = ""
            index += 1
            continue
        current = current + ch
        index += 1
    lines = append_string(lines, current)
    return lines

def build_pointer_line(column, lexeme, line_text):
    if len(line_text) == 0:
        return "^"
    start_column = column
    if start_column < 1:
        start_column = 1
    if start_column > len(line_text):
        start_column = len(line_text)
    pointer = ""
    index = 1
    while True:
        if index >= start_column:
            break
        if index <= len(line_text):
            current = substring(line_text, index - 1, index)
            if current == "\t":
                pointer = pointer + "\t"
            else:
                pointer = pointer + " "
        else:
            pointer = pointer + " "
        index += 1
    highlight_length = len(lexeme)
    if highlight_length <= 0:
        highlight_length = 1
    remaining = len(line_text) - (start_column - 1)
    if remaining <= 0:
        remaining = 1
    if highlight_length > remaining:
        highlight_length = remaining
    highlight_index = 0
    while True:
        if highlight_index >= highlight_length:
            break
        pointer = pointer + "^"
        highlight_index += 1
    return pointer

def join_lines(lines):
    if len(lines) == 0:
        return ""
    result = lines[0]
    index = 1
    while True:
        if index >= len(lines):
            break
        result = result + "\n" + lines[index]
        index += 1
    return result

def append_string(values, value):
    return (values) + ([value])

def number_to_string(value):
    if value == 0:
        return "0"
    working = value
    negative = False
    if working < 0:
        negative = True
        working = 0 - working
    digits = "0123456789"
    remaining = working
    output = ""
    while True:
        if remaining <= 0:
            break
        temp = remaining
        quotient = 0
        while True:
            if temp < 10:
                break
            temp -= 10
            quotient += 1
        ch = substring(digits, temp, temp + 1)
        output = ch + output
        remaining = quotient
    if negative:
        output = "-" + output
    return output

def empty_native_module():
    return NativeModule(module_name="main", artifacts=[], entry_points=[], symbol_count=0)

def has_prefix(value, prefix):
    if len(prefix) > len(value):
        return False
    index = 0
    while True:
        if index >= len(prefix):
            break
        if value[index] != prefix[index]:
            return False
        index += 1
    return True

def repeat_character(ch, count):
    if count <= 0:
        return ""
    index = 0
    result = ""
    while True:
        if index >= count:
            break
        result = result + ch
        index += 1
    return result

def find_substring(value, pattern):
    if len(pattern) == 0:
        return 0
    if len(value) < len(pattern):
        return -1
    index = 0
    while True:
        if index + len(pattern) > len(value):
            break
        match_flag = True
        offset = 0
        while True:
            if offset >= len(pattern):
                break
            if value[index + offset] != pattern[offset]:
                match_flag = False
                break
            offset += 1
        if match_flag:
            return index
        index += 1
    return -1

def find_substring_from(value, pattern, start):
    if start < 0:
        return find_substring(value, pattern)
    if start >= len(value):
        return -1
    index = start
    while True:
        if index + len(pattern) > len(value):
            break
        match_flag = True
        offset = 0
        while True:
            if offset >= len(pattern):
                break
            if value[index + offset] != pattern[offset]:
                match_flag = False
                break
            offset += 1
        if match_flag:
            return index
        index += 1
    return -1
