import asyncio
from runtime import runtime_support as runtime

from compiler.build.main import compile_project, ProjectCompilation, ModuleDiagnostics, CompiledModule

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
globals()['t' + 'rue'] = True
globals()['f' + 'alse'] = False

class SelfHostCheckResult:
    def __init__(self, success, compiled_count, expected_count, fatal_diagnostics, missing_sources):
        self.success = success
        self.compiled_count = compiled_count
        self.expected_count = expected_count
        self.fatal_diagnostics = fatal_diagnostics
        self.missing_sources = missing_sources

def run_self_host_check(sources):
    # effects: io
    compilation = compile_project(sources)
    fatal_entries = collect_fatal_diagnostics(compilation.diagnostics)
    missing_sources = collect_missing_sources(sources, compilation)
    success = true
    if len(fatal_entries) > 0:
        success = false
    if len(missing_sources) > 0:
        success = false
    if len(compilation.modules) != len(sources):
        success = false
    return SelfHostCheckResult(success=success, compiled_count=len(compilation.modules), expected_count=len(sources), fatal_diagnostics=fatal_entries, missing_sources=missing_sources)

def collect_fatal_diagnostics(entries):
    fatal = []
    index = 0
    while True:
        if index >= len(entries):
            break
        entry = entries[index]
        if entry.fatal:
            fatal = (fatal) + ([entry])
        index += 1
    return fatal

def collect_missing_sources(sources, compilation):
    missing = []
    index = 0
    while True:
        if index >= len(sources):
            break
        source_path = sources[index]
        if not module_present(source_path, compilation.modules):
            missing = (missing) + ([source_path])
        index += 1
    return missing

def module_present(target, modules):
    index = 0
    while True:
        if index >= len(modules):
            break
        if modules[index].source_path == target:
            return true
        index += 1
    return false
