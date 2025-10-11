import asyncio
import importlib
from bootstrap import runtime_support as runtime

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

__module_1 = importlib.import_module('compiler.build.parser')
parse_program = getattr(__module_1, 'parse_program')
__module_2 = importlib.import_module('compiler.build.emitter_sailfin')
emit_program = getattr(__module_2, 'emit_program')
__module_3 = importlib.import_module('compiler.build.emit_native')
emit_native = getattr(__module_3, 'emit_native')
EmitNativeResult = getattr(__module_3, 'EmitNativeResult')
NativeModule = getattr(__module_3, 'NativeModule')
__module_4 = importlib.import_module('compiler.build.native_lowering')
lower_to_python = getattr(__module_4, 'lower_to_python')
LoweredPythonResult = getattr(__module_4, 'LoweredPythonResult')
__module_5 = importlib.import_module('compiler.build.native_llvm_lowering')
lower_to_llvm = getattr(__module_5, 'lower_to_llvm')
LoweredLLVMResult = getattr(__module_5, 'LoweredLLVMResult')
__module_6 = importlib.import_module('compiler.build.typecheck')
typecheck_program = getattr(__module_6, 'typecheck_program')
__module_7 = importlib.import_module('compiler.build.code_generator')
generate_program = getattr(__module_7, 'generate_program')
class CompiledModule:
    def __init__(self, source_path, python_source):
        self.source_path = source_path
        self.python_source = python_source

class ModuleDiagnostics:
    def __init__(self, source_path, messages, fatal):
        self.source_path = source_path
        self.messages = messages
        self.fatal = fatal

class ModuleCompilationResult:
    def __init__(self, module, diagnostics):
        self.module = module
        self.diagnostics = diagnostics

class ProjectCompilation:
    def __init__(self, modules, diagnostics):
        self.modules = modules
        self.diagnostics = diagnostics

def compile_to_sailfin(source):
    # effects: io
    program = parse_program(source)
    analysis_result = typecheck_program(program)
    if (len(analysis_result.diagnostics) > 0):
        report_typecheck_errors(analysis_result.diagnostics)
        return ''
    return emit_program(program)

def compile_to_native(source):
    # effects: io
    program = parse_program(source)
    analysis_result = typecheck_program(program)
    if (len(analysis_result.diagnostics) > 0):
        report_typecheck_errors(analysis_result.diagnostics)
        return EmitNativeResult(module=empty_native_module(), diagnostics=format_typecheck_diagnostics(analysis_result.diagnostics))
    return emit_native(program)

def compile_to_native_python(source):
    # effects: io
    native_result = compile_to_native(source)
    lowered = lower_to_python(native_result.module)
    combined = []
    combined = list(combined) + list(native_result.diagnostics)
    combined = list(combined) + list(lowered.diagnostics)
    if (len(combined) > 0):
        index = 0
        while True:
            if (index >= len(combined)):
                break
            print.warn(('[native] ' + combined[index]))
            index += 1
    return LoweredPythonResult(source=lowered.source, diagnostics=combined)

def compile_to_native_llvm(source):
    # effects: io
    native_result = compile_to_native(source)
    lowered = lower_to_llvm(native_result.module)
    combined = []
    combined = list(combined) + list(native_result.diagnostics)
    combined = list(combined) + list(lowered.diagnostics)
    if (len(combined) > 0):
        index = 0
        while True:
            if (index >= len(combined)):
                break
            print.warn(('[native-llvm] ' + combined[index]))
            index += 1
    return LoweredLLVMResult(ir=lowered.ir, diagnostics=combined)

def main():
    # effects: io
    print.info('Sailfin compiler (stage 0)')

def compile_project(sources):
    # effects: io
    modules = []
    diagnostics = []
    for __item in sources:
        source_path = __item
        result = compile_source_at_path(source_path)
        if (result.module != None):
            modules.append(result.module)
        if (len(result.diagnostics) > 0):
            diagnostics = list(diagnostics) + list(result.diagnostics)
    return ProjectCompilation(modules=modules, diagnostics=diagnostics)

def compile_source_at_path(source_path):
    # effects: io
    source = fs.readFile(source_path)
    program = parse_program(source)
    analysis = typecheck_program(program)
    if (len(analysis.diagnostics) > 0):
        return ModuleCompilationResult(module=None, diagnostics=[ModuleDiagnostics(source_path=source_path, messages=format_typecheck_diagnostics(analysis.diagnostics), fatal=True)])
    native_result = emit_native(program)
    lowered = lower_to_python(native_result.module)
    messages = list(native_result.diagnostics) + list(lowered.diagnostics)
    python_source = lowered.source
    fallback_needed = needs_python_fallback(python_source)
    if fallback_needed:
        python_source = generate_program(program)
        messages.append('native backend: python fallback engaged (lowering incomplete)')
    entry_list = []
    if (len(messages) > 0):
        entry_list = [ModuleDiagnostics(source_path=source_path, messages=messages, fatal=False)]
    return ModuleCompilationResult(module=CompiledModule(source_path=source_path, python_source=python_source), diagnostics=entry_list)

def format_typecheck_diagnostics(entries):
    messages = []
    for __item in entries:
        entry = __item
        messages.append(entry.message)
    return messages

def report_typecheck_errors(entries):
    # effects: io
    index = 0
    while True:
        if (index >= len(entries)):
            break
        diagnostic = entries[index]
        print.error(('[typecheck] ' + diagnostic.message))
        index += 1

def empty_native_module():
    return NativeModule(artifacts=[], entry_points=[], symbol_count=0)

def has_prefix(value, prefix):
    if (len(prefix) > len(value)):
        return False
    index = 0
    while True:
        if (index >= len(prefix)):
            break
        if (value[index] != prefix[index]):
            return False
        index += 1
    return True

def needs_python_fallback(source):
    if (len(source) == 0):
        return True
    if string_contains(source, '.push('):
        return True
    if string_contains(source, '.concat('):
        return True
    if string_contains(source, '.length'):
        return True
    if string_contains(source, '\nlet '):
        return True
    if string_contains(source, ' let '):
        return True
    if string_contains(source, ' mut '):
        return True
    if string_contains(source, ' null'):
        return True
    if string_contains(source, ' true'):
        return True
    if string_contains(source, ' false'):
        return True
    return False

def string_contains(value, pattern):
    if (len(pattern) == 0):
        return True
    if (len(value) < len(pattern)):
        return False
    index = 0
    while True:
        if ((index + len(pattern)) > len(value)):
            break
        match_flag = True
        offset = 0
        while True:
            if (offset >= len(pattern)):
                break
            if (value[(index + offset)] != pattern[offset]):
                match_flag = False
                break
            offset += 1
        if match_flag:
            return True
        index += 1
    return False


if __name__ == '__main__':
    main()
