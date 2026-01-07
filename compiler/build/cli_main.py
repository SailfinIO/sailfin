import asyncio
from runtime import runtime_support as runtime

from compiler.build.main import compile_to_llvm, compile_to_llvm_with_module, compile_to_llvm_with_module_timed, compile_to_llvm_lines_with_module, compile_to_llvm_lines_with_module_timed, compile_tests_to_llvm, compile_tests_to_llvm_with_module, compile_to_sailfin, number_to_string, module_name_from_path
from compiler.build.main import compile_to_native_text
from compiler.build.native_ir import split_lines
from compiler.build.version import sailfin_stage2_version

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

class _RelativeImportSpan:
    def __init__(self, start, end, spec):
        self.start = start
        self.end = end
        self.spec = spec

    def __repr__(self):
        return runtime.struct_repr('_RelativeImportSpan', [runtime.struct_field('start', self.start), runtime.struct_field('end', self.end), runtime.struct_field('spec', self.spec)])

def _usage():
    return "usage:\n" + "  sfn --version\n" + "  sfn version\n" + "  sfn emit [--timing] llvm|sailfin|native <file.sfn>\n" + "  sfn emit-llvm-file [--timing] <file.sfn> <out.ll>\n" + "  sfn build [-o OUTPUT] <file.sfn>\n" + "  sfn run <file.sfn>\n" + "  sfn run <exe>\n" + "  sfn test [path]\n" + "\n" + "examples:\n" + "  sfn emit llvm examples/basics/hello-world.sfn\n" + "  sfn build -o build/native/examples/hello examples/basics/hello-world.sfn\n" + "  sfn run examples/basics/hello-world.sfn\n" + "  sfn run build/native/examples/hello\n" + "  sfn test .\n"

def _ends_with(value, suffix):
    if len(suffix) == 0:
        return True
    if len(value) < len(suffix):
        return False
    start = len(value) - len(suffix)
    return substring(value, start, len(value)) == suffix

def _is_flag(value, flag):
    return value == flag

def _path_join(base, name):
    if len(base) == 0:
        return name
    if base[len(base) - 1] == "/":
        return base + name
    return base + "/" + name

def _path_pop_last(parts):
    if len(parts) == 0:
        return []
    out = []
    index = 0
    while True:
        if index + 1 >= len(parts):
            break
        out = (out) + ([parts[index]])
        index += 1
    return out

def _read_non_empty_lines(path):
    # effects: io
    if not fs.exists(path):
        return []
    text = fs.readFile(path)
    lines = split_lines(text)
    out = []
    index = 0
    while True:
        if index >= len(lines):
            break
        line = lines[index]
        if len(line) > 0:
            out = (out) + ([line])
        index += 1
    return out

def _path_join_parts(parts):
    out = ""
    index = 0
    while True:
        if index >= len(parts):
            break
        if index == 0:
            out = parts[index]
        else:
            out = out + "/" + parts[index]
        index += 1
    return out

def _path_normalize(path):
    if len(path) == 0:
        return "."
    is_abs = path[0] == "/"
    parts = []
    seg_start = 0
    i = 0
    while True:
        if i >= len(path):
            break
        if path[i] == "/":
            seg = substring(path, seg_start, i)
            if len(seg) == 0  or  seg == ".":
                pass
            else:
                if seg == "..":
                    if len(parts) > 0  and  parts[len(parts) - 1] != "..":
                        parts = _path_pop_last(parts)
                    else:
                        if not is_abs:
                            parts = (parts) + ([".."])
                else:
                    parts = (parts) + ([seg])
            seg_start = i + 1
        i += 1
    if seg_start <= len(path):
        seg = substring(path, seg_start, len(path))
        if len(seg) == 0  or  seg == ".":
            pass
        else:
            if seg == "..":
                if len(parts) > 0  and  parts[len(parts) - 1] != "..":
                    parts = _path_pop_last(parts)
                else:
                    if not is_abs:
                        parts = (parts) + ([".."])
            else:
                parts = (parts) + ([seg])
    joined = _path_join_parts(parts)
    if is_abs:
        if len(joined) == 0:
            return "/"
        return "/" + joined
    if len(joined) == 0:
        return "."
    return joined

def _has_prefix(value, prefix):
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

def _dirname(path):
    last_slash = -1
    index = 0
    while True:
        if index >= len(path):
            break
        if path[index] == "/":
            last_slash = index
        index += 1
    if last_slash < 0:
        return "."
    if last_slash == 0:
        return "/"
    return substring(path, 0, last_slash)

def _is_ident_char(ch):
    allowed = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_"
    return _string_contains(allowed, ch)

def _word_matches(source, index, word):
    if len(word) == 0:
        return False
    if index < 0:
        return False
    if index + len(word) > len(source):
        return False
    if substring_unchecked(source, index, index + len(word)) != word:
        return False
    if index > 0:
        if _is_ident_char(source[index - 1]):
            return False
    if index + len(word) < len(source):
        if _is_ident_char(source[index + len(word)]):
            return False
    return True

def _collect_relative_import_spans(source):
    spans = []
    i = 0
    in_string = False
    escaping = False
    in_line_comment = False
    in_block_comment = False
    while True:
        if i >= len(source):
            break
        ch = source[i]
        if in_line_comment:
            if ch == "\n":
                in_line_comment = False
            i += 1
            continue
        if in_block_comment:
            if ch == "*"  and  i + 1 < len(source)  and  source[i + 1] == "/":
                in_block_comment = False
                i += 2
                continue
            i += 1
            continue
        if in_string:
            if escaping:
                escaping = False
                i += 1
                continue
            if ch == "\\":
                escaping = True
                i += 1
                continue
            if ch == "\"":
                in_string = False
                i += 1
                continue
            i += 1
            continue
        if ch == "/"  and  i + 1 < len(source):
            next = source[i + 1]
            if next == "/":
                in_line_comment = True
                i += 2
                continue
            if next == "*":
                in_block_comment = True
                i += 2
                continue
        if ch == "\"":
            in_string = True
            i += 1
            continue
        if _word_matches(source, i, "import"):
            stmt_start = i
            j = i
            stmt_in_string = False
            stmt_escaping = False
            stmt_in_line_comment = False
            stmt_in_block_comment = False
            spec = ""
            stmt_end = -1
            while True:
                if j >= len(source):
                    break
                cj = source[j]
                if stmt_in_line_comment:
                    if cj == "\n":
                        stmt_in_line_comment = False
                    j += 1
                    continue
                if stmt_in_block_comment:
                    if cj == "*"  and  j + 1 < len(source)  and  source[j + 1] == "/":
                        stmt_in_block_comment = False
                        j += 2
                        continue
                    j += 1
                    continue
                if stmt_in_string:
                    if stmt_escaping:
                        stmt_escaping = False
                        j += 1
                        continue
                    if cj == "\\":
                        stmt_escaping = True
                        j += 1
                        continue
                    if cj == "\"":
                        stmt_in_string = False
                        j += 1
                        continue
                    j += 1
                    continue
                if cj == "/"  and  j + 1 < len(source):
                    nextj = source[j + 1]
                    if nextj == "/":
                        stmt_in_line_comment = True
                        j += 2
                        continue
                    if nextj == "*":
                        stmt_in_block_comment = True
                        j += 2
                        continue
                if cj == "\"":
                    stmt_in_string = True
                    j += 1
                    continue
                if len(spec) == 0  and  _word_matches(source, j, "from"):
                    k = j + 4
                    while True:
                        if k >= len(source):
                            break
                        wk = source[k]
                        if wk == " "  or  wk == "\t"  or  wk == "\n"  or  wk == "\r":
                            k += 1
                            continue
                        break
                    if k < len(source)  and  source[k] == "\"":
                        k += 1
                        start = k
                        esc = False
                        while True:
                            if k >= len(source):
                                break
                            sk = source[k]
                            if esc:
                                esc = False
                                k += 1
                                continue
                            if sk == "\\":
                                esc = True
                                k += 1
                                continue
                            if sk == "\"":
                                spec = substring_unchecked(source, start, k)
                                break
                            k += 1
                if cj == ";":
                    stmt_end = j + 1
                    break
                j += 1
            if stmt_end > 0  and  len(spec) > 0:
                if _has_prefix(spec, "./")  or  _has_prefix(spec, "../"):
                    spans.append(_RelativeImportSpan(start=stmt_start, end=stmt_end, spec=spec))
            if stmt_end > 0:
                i = stmt_end
                continue
        i += 1
    return spans

def _extract_relative_import_specs(source):
    spans = _collect_relative_import_spans(source)
    if len(spans) == 0:
        return []
    specs = []
    index = 0
    while True:
        if index >= len(spans):
            break
        specs = (specs) + ([spans[index].spec])
        index += 1
    return specs

def _resolve_import_path(base_dir, spec):
    current_base = base_dir
    remainder = spec
    while True:
        if _has_prefix(remainder, "../"):
            current_base = _dirname(current_base)
            remainder = substring(remainder, 3, len(remainder))
            continue
        if _has_prefix(remainder, "./"):
            remainder = substring(remainder, 2, len(remainder))
            continue
        break
    path = _path_join(current_base, remainder)
    if _ends_with(path, ".sfn"):
        return path
    return path + ".sfn"

def _string_list_contains(items, value):
    index = 0
    while True:
        if index >= len(items):
            break
        if items[index] == value:
            return True
        index += 1
    return False

def _string_contains(haystack, needle):
    if len(needle) == 0:
        return True
    haystack_len = len(haystack)
    i = 0
    while True:
        if i >= haystack_len:
            break
        if haystack[i] == needle:
            return True
        i += 1
    return False

def _sanitize_filename(value):
    allowed = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789._-"
    out = ""
    value_len = len(value)
    index = 0
    while True:
        if index >= value_len:
            break
        ch = value[index]
        if _string_contains(allowed, ch):
            out = out + ch
        else:
            out = out + "_"
        index += 1
    if len(out) == 0:
        return "_"
    return out

def _strip_relative_import_lines(source):
    spans = _collect_relative_import_spans(source)
    if len(spans) == 0:
        return source
    out = ""
    keep_start = 0
    index = 0
    while True:
        if index >= len(spans):
            break
        span = spans[index]
        if span.start > keep_start:
            out = out + substring_unchecked(source, keep_start, span.start)
        keep_start = span.end
        index += 1
    if keep_start < len(source):
        out = out + substring_unchecked(source, keep_start, len(source))
    return out

def _inline_relative_imports(source, base_dir, depth, visited):
    # effects: io
    if depth <= 0:
        return _strip_relative_import_lines(source)
    spans = _collect_relative_import_spans(source)
    combined = ""
    next_visited = visited
    remove = []
    index = 0
    while True:
        if index >= len(spans):
            break
        if fs.exists("build/sailfin/.dump_test_sources"):
            print.info("test import inlining: base=" + base_dir + " spec=" + spans[index].spec)
        dep_path = _resolve_import_path(base_dir, spans[index].spec)
        is_prebuilt = _has_prefix(dep_path, "compiler/src/")  or  _has_prefix(dep_path, "runtime/")
        if not is_prebuilt:
            if not _string_list_contains(next_visited, dep_path):
                if not fs.exists(dep_path):
                    print.warn("test import inlining: missing dependency: " + dep_path)
                    index += 1
                    continue
                dep_source = fs.readFile(dep_path)
                if len(dep_source) == 0:
                    print.warn("test import inlining: empty dependency source: " + dep_path)
                next_visited = (next_visited) + ([dep_path])
                dep_base = _dirname(dep_path)
                inlined_dep = _inline_relative_imports(dep_source, dep_base, depth - 1, next_visited)
                combined = combined + inlined_dep + "\n"
            remove.append(spans[index])
        index += 1
    stripped = source
    if len(remove) > 0:
        out = ""
        keep_start = 0
        index = 0
        while True:
            if index >= len(remove):
                break
            span = remove[index]
            if span.start > keep_start:
                out = out + substring_unchecked(source, keep_start, span.start)
            keep_start = span.end
            index += 1
        if keep_start < len(source):
            out = out + substring_unchecked(source, keep_start, len(source))
        stripped = out
    combined = combined + stripped
    return combined

def _looks_like_test_file(name):
    return _ends_with(name, "_test.sfn")

def _collect_test_files(root, max_depth):
    # effects: io
    results = []
    if _ends_with(root, ".sfn"):
        return [root]
    if max_depth < 0:
        return []
    entries = fs.listDirectory(root)
    index = 0
    while True:
        if index >= len(entries):
            break
        entry = entries[index]
        full = _path_join(root, entry)
        if _looks_like_test_file(entry):
            results = (results) + ([full])
        child_entries = fs.listDirectory(full)
        if len(child_entries) > 0:
            results = (results) + (_collect_test_files(full, max_depth - 1))
        index += 1
    return results

def _write_text(path, text):
    # effects: io
    fs.writeFile(path, text)

def _write_lines(path, lines):
    # effects: io
    fs.writeLines(path, lines)

def _ensure_dir(path):
    # effects: io
    fs.createDirectory(path, True)

def _clear_cache_dir(path):
    # effects: io
    if len(path) == 0:
        return
    if not fs.exists(path):
        return
    entries = fs.listDirectory(path)
    index = 0
    while True:
        if index >= len(entries):
            break
        entry = entries[index]
        full = _path_join(path, entry)
        fs.deleteFile(full)
        index += 1

def _runtime_bundle_exists(root):
    # effects: io
    if len(root) == 0:
        return False
    include_dir = _path_join(root, "native/include")
    runtime_src = _path_join(root, "native/src/sailfin_runtime.c")
    runtime_ir = _path_join(root, "native/ir/runtime_globals.ll")
    prelude_obj = _runtime_prelude_path(root)
    return fs.exists(include_dir)  and  fs.exists(runtime_src)  and  fs.exists(runtime_ir)  and  len(prelude_obj) > 0

def _runtime_prelude_path(root):
    # effects: io
    bundled = _path_join(root, "native/obj/prelude.o")
    if fs.exists(bundled):
        return bundled
    bundled_nested = _path_join(root, "native/obj/runtime/prelude.o")
    if fs.exists(bundled_nested):
        return bundled_nested
    parent = _dirname(root)
    fallback = _path_join(parent, "build/native/obj/prelude.o")
    if fs.exists(fallback):
        return fallback
    fallback_nested = _path_join(parent, "build/native/obj/runtime/prelude.o")
    if fs.exists(fallback_nested):
        return fallback_nested
    return ""

def _clang_compile_runtime_objects(runtime_root, out_dir, opt_flag):
    # effects: io
    if len(runtime_root) == 0:
        return ["", "", ""]
    if not _runtime_bundle_exists(runtime_root):
        return ["", "", ""]
    include_dir = _path_join(runtime_root, "native/include")
    runtime_src = _path_join(runtime_root, "native/src/sailfin_runtime.c")
    runtime_ir = _path_join(runtime_root, "native/ir/runtime_globals.ll")
    prelude_obj = _runtime_prelude_path(runtime_root)
    runtime_obj = _path_join(out_dir, "sailfin_runtime" + opt_flag + ".o")
    globals_obj = _path_join(out_dir, "runtime_globals" + opt_flag + ".o")
    if not fs.exists(runtime_obj):
        rc = process.run(["clang", opt_flag, "-Wno-override-module", "-I" + include_dir, "-c", runtime_src, "-o", runtime_obj])
        if rc != 0:
            return ["", "", ""]
    if not fs.exists(globals_obj):
        rc2 = process.run(["clang", opt_flag, "-Wno-override-module", "-c", runtime_ir, "-o", globals_obj])
        if rc2 != 0:
            return ["", "", ""]
    return [runtime_obj, globals_obj, prelude_obj]

def _clang_link_with_opt(ll_path, out_path, runtime_root, opt_flag, cache_dir):
    # effects: io
    if len(runtime_root) == 0:
        print.error("runtime bundle not found; set SAILFIN_RUNTIME_ROOT or install runtime alongside the binary")
        return 1
    if not _runtime_bundle_exists(runtime_root):
        print.error("runtime bundle missing expected files under: " + runtime_root)
        return 1
    _ensure_dir("build")
    _ensure_dir("build/sailfin")
    _ensure_dir(cache_dir)
    cached = _clang_compile_runtime_objects(runtime_root, cache_dir, opt_flag)
    runtime_obj = cached[0]
    globals_obj = cached[1]
    prelude_obj = cached[2]
    if len(runtime_obj) == 0  or  len(globals_obj) == 0  or  len(prelude_obj) == 0:
        print.error("failed to build cached runtime objects")
        return 1
    args = ["clang", opt_flag, "-Wno-override-module", runtime_obj, globals_obj, prelude_obj, ll_path, "-o", out_path, "-lm"]
    return process.run(args)

def _clang_link(ll_path, out_path, runtime_root):
    # effects: io
    return _clang_link_with_opt(ll_path, out_path, runtime_root, "-O2", "build/sailfin")

def _clang_link_test(ll_path, out_path, runtime_root):
    # effects: io
    if len(runtime_root) == 0:
        print.error("runtime bundle not found; set SAILFIN_RUNTIME_ROOT or install runtime alongside the binary")
        return 1
    if not _runtime_bundle_exists(runtime_root):
        print.error("runtime bundle missing expected files under: " + runtime_root)
        return 1
    _ensure_dir("build")
    _ensure_dir("build/sailfin")
    cache_dir = "build/sailfin/test-o0"
    _ensure_dir(cache_dir)
    cached = _clang_compile_runtime_objects(runtime_root, cache_dir, "-O0")
    runtime_obj = cached[0]
    globals_obj = cached[1]
    prelude_obj = cached[2]
    if len(runtime_obj) == 0  or  len(globals_obj) == 0  or  len(prelude_obj) == 0:
        print.error("failed to build cached runtime objects")
        return 1
    module_objs = []
    modules = _read_non_empty_lines("build/stage2/aot/modules.txt")
    if len(modules) > 0:
        index = 0
        while True:
            if index >= len(modules):
                break
            if _has_prefix(modules[index], "runtime/"):
                index += 1
                continue
            obj = "build/native/obj/" + modules[index] + ".o"
            if fs.exists(obj):
                module_objs.append(obj)
            index += 1
    args = ["clang", "-O0", "-Wno-override-module", runtime_obj, globals_obj, prelude_obj]
    if len(module_objs) > 0:
        args = (args) + (module_objs)
    args = (args) + ([ll_path, "-o", out_path, "-lm"])
    return process.run(args)

def sailfin_cli_main(argv):
    # effects: io
    if len(argv) == 0:
        print.error(_usage())
        return 2
    runtime_root = ""
    start_index = 0
    if len(argv) >= 2  and  argv[0] == "--runtime-root":
        runtime_root = argv[1]
        start_index = 2
    if len(runtime_root) == 0  and  _runtime_bundle_exists("runtime"):
        runtime_root = "runtime"
    args = []
    arg_index = start_index
    while True:
        if arg_index >= len(argv):
            break
        args = (args) + ([argv[arg_index]])
        arg_index += 1
    if len(args) == 0:
        print.error(_usage())
        return 2
    if len(args) == 1  and  _is_flag(args[0], "--version")  or  _is_flag(args[0], "-V"):
        print.info("sfn " + sailfin_stage2_version())
        return 0
    if len(args) == 3  and  _is_flag(args[0], "--emit"):
        mode = args[1]
        path = args[2]
        if not fs.exists(path):
            print.error("file not found: " + path)
            return 1
        source = fs.readFile(path)
        module_name = module_name_from_path(path)
        if mode == "llvm":
            print.info(compile_to_llvm_with_module(source, module_name))
            return 0
        if mode == "sailfin":
            print.info(compile_to_sailfin(source))
            return 0
        if mode == "native":
            print.info(compile_to_native_text(source))
            return 0
        print.error("unknown --emit mode: " + mode)
        print.error(_usage())
        return 2
    cmd = args[0]
    if cmd == "version":
        if len(args) != 1:
            print.error(_usage())
            return 2
        print.info("sfn " + sailfin_stage2_version())
        return 0
    if cmd == "emit":
        timing = False
        base_index = 1
        if len(args) >= 2  and  _is_flag(args[1], "--timing"):
            timing = True
            base_index = 2
        if len(args) != base_index + 2:
            print.error(_usage())
            return 2
        mode = args[base_index]
        path = args[base_index + 1]
        if not fs.exists(path):
            print.error("file not found: " + path)
            return 1
        source = fs.readFile(path)
        module_name = module_name_from_path(path)
        if mode == "llvm":
            if timing:
                print.info(compile_to_llvm_with_module_timed(source, module_name))
            else:
                print.info(compile_to_llvm_with_module(source, module_name))
            return 0
        if mode == "sailfin":
            print.info(compile_to_sailfin(source))
            return 0
        if mode == "native":
            print.info(compile_to_native_text(source))
            return 0
        print.error("unknown emit mode: " + mode)
        return 2
    if cmd == "emit-llvm-file":
        timing = False
        base_index = 1
        if len(args) >= 2  and  _is_flag(args[1], "--timing"):
            timing = True
            base_index = 2
        if len(args) != base_index + 2:
            print.error(_usage())
            return 2
        path = args[base_index]
        out_path = args[base_index + 1]
        if not fs.exists(path):
            print.error("file not found: " + path)
            return 1
        source = fs.readFile(path)
        module_name = module_name_from_path(path)
        lines = []
        if timing:
            lines = compile_to_llvm_lines_with_module_timed(source, module_name)
        else:
            lines = compile_to_llvm_lines_with_module(source, module_name)
        _write_lines(out_path, lines)
        return 0
    if cmd == "build":
        out_path = ""
        input_path = ""
        if len(args) == 2:
            input_path = args[1]
            out_path = "build/sailfin/program"
        else:
            if len(args) == 4  and  args[1] == "-o":
                out_path = args[2]
                input_path = args[3]
            else:
                print.error(_usage())
                return 2
        if not fs.exists(input_path):
            print.error("file not found: " + input_path)
            return 1
        source = fs.readFile(input_path)
        module_name = module_name_from_path(input_path)
        lines = compile_to_llvm_lines_with_module(source, module_name)
        _ensure_dir("build")
        _ensure_dir("build/sailfin")
        ll_path = "build/sailfin/program.ll"
        _write_lines(ll_path, lines)
        exe_path = out_path
        rc = _clang_link(ll_path, exe_path, runtime_root)
        if rc != 0:
            print.error("link failed (clang exit=" + number_to_string(rc) + ")")
            return rc
        print.info("built: " + exe_path)
        return 0
    if cmd == "run":
        if len(args) != 2:
            print.error(_usage())
            return 2
        input_path = args[1]
        if not _ends_with(input_path, ".sfn"):
            return process.run([input_path])
        if not fs.exists(input_path):
            print.error("file not found: " + input_path)
            return 1
        source = fs.readFile(input_path)
        module_name = module_name_from_path(input_path)
        llvm = compile_to_llvm_with_module(source, module_name)
        _ensure_dir("build")
        _ensure_dir("build/sailfin")
        ll_path = "build/sailfin/run.ll"
        exe_path = "build/sailfin/run"
        _write_text(ll_path, llvm)
        link_rc = _clang_link(ll_path, exe_path, runtime_root)
        if link_rc != 0:
            print.error("link failed (clang exit=" + number_to_string(link_rc) + ")")
            return link_rc
        run_rc = process.run([exe_path])
        return run_rc
    if cmd == "test":
        root = "."
        if len(args) == 2:
            root = args[1]
        else:
            if len(args) != 1:
                print.error(_usage())
                return 2
        _ensure_dir("build")
        _ensure_dir("build/sailfin")
        _clear_cache_dir("build/sailfin/test-o0")
        test_runner_active_path = "build/sailfin/.test_runner_active"
        _write_text(test_runner_active_path, "")
        test_files = _collect_test_files(root, 25)
        if len(test_files) == 0:
            print.error("no Sailfin test files found under: " + root)
            fs.deleteFile(test_runner_active_path)
            return 1
        ll_path = "build/sailfin/test.ll"
        exe_path = "build/sailfin/test"
        dump_sources = fs.exists("build/sailfin/.dump_test_sources")
        trace_runner = fs.exists("build/sailfin/.trace_test_runner")
        index = 0
        while True:
            if index >= len(test_files):
                break
            path = test_files[index]
            print.info("test: " + path)
            source = fs.readFile(path)
            module_name = module_name_from_path(path)
            base_dir = _dirname(path)
            if trace_runner:
                print.info("test runner: inlining start")
            combined_source = _inline_relative_imports(source, base_dir, 10, [])
            if trace_runner:
                print.info("test runner: inlining done (bytes=" + number_to_string(len(combined_source)) + ")")
            if dump_sources:
                safe = _sanitize_filename(path)
                _write_text("build/sailfin/test-source-" + safe + ".sfn", combined_source)
            if trace_runner:
                print.info("test runner: compile start")
            llvm = compile_tests_to_llvm_with_module(combined_source, module_name)
            if trace_runner:
                print.info("test runner: compile done (bytes=" + number_to_string(len(llvm)) + ")")
            if len(llvm) == 0:
                print.error("test compile failed: " + path)
                fs.deleteFile(test_runner_active_path)
                return 1
            cleaned = _strip_stage2_log_prefixes(llvm)
            _write_text(ll_path, cleaned)
            if trace_runner:
                print.info("test runner: link start")
            link_rc = _clang_link_test(ll_path, exe_path, runtime_root)
            if link_rc != 0:
                print.error("link failed (clang exit=" + number_to_string(link_rc) + ")")
                fs.deleteFile(test_runner_active_path)
                return link_rc
            if trace_runner:
                print.info("test runner: link done")
                print.info("test runner: exec start")
            run_rc = process.run([exe_path])
            if trace_runner:
                print.info("test runner: exec done (exit=" + number_to_string(run_rc) + ")")
            if run_rc != 0:
                print.error("test failed: " + path)
                fs.deleteFile(test_runner_active_path)
                return run_rc
            index += 1
        fs.deleteFile(test_runner_active_path)
        return 0
    if cmd == "-h"  or  cmd == "--help":
        print.info(_usage())
        return 0
    print.error("unknown command: " + cmd)
    print.error(_usage())
    return 2

def stage2_cli_main(argv):
    # effects: io
    return sailfin_cli_main(argv)

def _join_with_separator_cli(values, separator):
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
                combined = parts[index] + separator + parts[index + 1]
                next = (next) + ([combined])
                index += 2
                continue
            next = (next) + ([parts[index]])
            index += 1
        parts = next
    return parts[0]

def _strip_stage2_log_prefixes(text):
    if len(text) >= 6:
        head7 = substring(text, 0, 7)
        if head7 != "[info] "  and  head7 != "[warn] ":
            if len(text) >= 8:
                head8 = substring(text, 0, 8)
                if head8 != "[error] ":
                    return text
            else:
                return text
    else:
        return text
    out = []
    start = 0
    while True:
        if start > len(text):
            break
        end = start
        while True:
            if end >= len(text):
                break
            if text[end] == "\n":
                break
            end += 1
        line = substring(text, start, end)
        if len(line) >= 7:
            prefix7 = substring(line, 0, 7)
            if prefix7 == "[info] ":
                line = substring(line, 7, len(line))
            else:
                if prefix7 == "[warn] ":
                    line = substring(line, 7, len(line))
                else:
                    if len(line) >= 8:
                        prefix8 = substring(line, 0, 8)
                        if prefix8 == "[error] ":
                            line = substring(line, 8, len(line))
        else:
            if len(line) >= 8:
                prefix8 = substring(line, 0, 8)
                if prefix8 == "[error] ":
                    line = substring(line, 8, len(line))
        out = append_string(out, line)
        if end >= len(text):
            break
        start = end + 1
    return _join_with_separator_cli(out, "\n") + "\n"
