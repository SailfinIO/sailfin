import asyncio
from runtime import runtime_support as runtime

from compiler.build.emit_native import NativeModule
from compiler.build.native_ir import select_text_artifact, parse_native_artifact, NativeFunction, NativeInstruction, NativeParameter
from compiler.build.string_utils import substring, char_code

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

class LoweredLLVMResult:
    def __init__(self, ir, diagnostics):
        self.ir = ir
        self.diagnostics = diagnostics

class LoweredLLVMFunction:
    def __init__(self, lines, diagnostics):
        self.lines = lines
        self.diagnostics = diagnostics

class BodyResult:
    def __init__(self, lines, diagnostics):
        self.lines = lines
        self.diagnostics = diagnostics

class ParameterBinding:
    def __init__(self, name, llvm_name, llvm_type):
        self.name = name
        self.llvm_name = llvm_name
        self.llvm_type = llvm_type

class ParameterPreparation:
    def __init__(self, signature, bindings, diagnostics):
        self.signature = signature
        self.bindings = bindings
        self.diagnostics = diagnostics

def lower_to_llvm(native_module):
    diagnostics = []
    artifact = select_text_artifact(native_module.artifacts)
    if artifact == null:
        diagnostics = append_string(diagnostics, "no sailfin-native-text artifact present")
        return LoweredLLVMResult(ir="", diagnostics=diagnostics)
    parse = parse_native_artifact(artifact.contents)
    diagnostics = (diagnostics) + (parse.diagnostics)
    lines = []
    lines = append_string(lines, "; ModuleID = 'sailfin'")
    lines = append_string(lines, "source_filename = \"sailfin\"")
    lines = append_string(lines, "")
    index = 0
    while True:
        if index >= len(parse.functions):
            break
        lowered = emit_function(parse.functions[index])
        diagnostics = (diagnostics) + (lowered.diagnostics)
        if len(lowered.lines) > 0:
            lines = (lines) + (lowered.lines)
            if index + 1 < len(parse.functions):
                lines = append_string(lines, "")
        index += 1
    ir = join_with_separator(lines, "\n")
    output = ir
    if len(output) > 0:
        output = output + "\n"
    return LoweredLLVMResult(ir=output, diagnostics=diagnostics)

def emit_function(function):
    diagnostics = []
    sanitized = sanitize_symbol(function.name)
    llvm_return = map_return_type(function.return_type)
    if len(llvm_return) == 0:
        diagnostics = append_string(diagnostics, "llvm lowering: unsupported return type `" + function.return_type + "` in " + function.name)
        return LoweredLLVMFunction(lines=[], diagnostics=diagnostics)
    preparation = prepare_parameters(function)
    diagnostics = (diagnostics) + (preparation.diagnostics)
    lines = []
    signature = join_with_separator(preparation.signature, ", ")
    if len(signature) == 0:
        signature = ""
    lines = append_string(lines, "define " + llvm_return + " @" + sanitized + "(" + signature + ") {")
    lines = append_string(lines, "entry:")
    body = emit_body(function, llvm_return, preparation.bindings)
    lines = (lines) + (body.lines)
    diagnostics = (diagnostics) + (body.diagnostics)
    lines = append_string(lines, "}")
    return LoweredLLVMFunction(lines=lines, diagnostics=diagnostics)

def emit_body(function, llvm_return, bindings):
    diagnostics = []
    lines = []
    expression_instructions = 0
    index = 0
    while True:
        if index >= len(function.instructions):
            break
        instruction = function.instructions[index]
        if instruction.variant == "Expression":
            expression_instructions += 1
        index += 1
    if expression_instructions > 0:
        diagnostics = append_string(diagnostics, "llvm lowering: expression instructions are ignored in " + function.name)
    return_expression = select_return_expression(function.instructions)
    lowered = lower_return_instruction(function, llvm_return, return_expression, bindings)
    lines = (lines) + (lowered.lines)
    diagnostics = (diagnostics) + (lowered.diagnostics)
    return BodyResult(lines=lines, diagnostics=diagnostics)

def prepare_parameters(function):
    signature = []
    bindings = []
    diagnostics = []
    index = 0
    while True:
        if index >= len(function.parameters):
            break
        parameter = function.parameters[index]
        llvm_type = map_parameter_type(parameter.type_annotation)
        if len(llvm_type) == 0:
            diagnostics = append_string(diagnostics, "llvm lowering: unsupported parameter type `" + parameter.type_annotation + "` in function `" + function.name + "`")
            llvm_type = "double"
        if len(parameter.type_annotation) == 0:
            diagnostics = append_string(diagnostics, "llvm lowering: parameter `" + parameter.name + "` missing type annotation; defaulting to `" + llvm_type + "`")
        sanitized = sanitize_symbol(parameter.name)
        llvm_name = "%" + sanitized
        signature = append_string(signature, llvm_type + " " + llvm_name)
        bindings = append_parameter_binding(bindings, ParameterBinding(name=parameter.name, llvm_name=llvm_name, llvm_type=llvm_type))
        index += 1
    return ParameterPreparation(signature=signature, bindings=bindings, diagnostics=diagnostics)

def select_return_expression(instructions):
    index = len(instructions)
    while True:
        if index <= 0:
            break
        index -= 1
        instruction = instructions[index]
        if instruction.variant == "Return":
            return instruction.expression
    return null

def lower_return_instruction(function, llvm_return, expression, bindings):
    function_name = function.name
    if llvm_return == "void":
        if expression != null  and  len(expression) > 0:
            diagnostics = ["llvm lowering: void function `" + function_name + "` returned a value"]
            return BodyResult(lines=["  ret void"], diagnostics=diagnostics)
        return BodyResult(lines=["  ret void"], diagnostics=[])
    if expression == null:
        diagnostics = ["llvm lowering: missing return in function `" + function_name + "`"]
        return BodyResult(lines=["  ret " + llvm_return + " 0.0"], diagnostics=diagnostics)
    trimmed = trim_text(expression)
    if len(trimmed) == 0:
        diagnostics = ["llvm lowering: empty return expression in `" + function_name + "`"]
        return BodyResult(lines=["  ret " + llvm_return + " 0.0"], diagnostics=diagnostics)
    binding = find_parameter_binding(bindings, trimmed)
    if binding != null:
        diagnostics = []
        if binding.llvm_type != llvm_return:
            diagnostics = append_string(diagnostics, "llvm lowering: return type `" + llvm_return + "` mismatches parameter `" + binding.name + "` of type `" + binding.llvm_type + "`")
        return BodyResult(lines=["  ret " + binding.llvm_type + " " + binding.llvm_name], diagnostics=diagnostics)
    if llvm_return == "double":
        if is_number_literal(trimmed):
            normalised = normalise_number_literal(trimmed)
            return BodyResult(lines=["  ret double " + normalised], diagnostics=[])
        diagnostics = ["llvm lowering: non-numeric return expression `" + trimmed + "` in `" + function_name + "`"]
        return BodyResult(lines=["  ret double 0.0"], diagnostics=diagnostics)
    diagnostics = ["llvm lowering: unhandled return type `" + llvm_return + "` in `" + function_name + "`"]
    return BodyResult(lines=["  ret " + llvm_return + " zeroinitializer"], diagnostics=diagnostics)

def map_return_type(return_type):
    trimmed = trim_text(return_type)
    if len(trimmed) == 0  or  trimmed == "void":
        return "void"
    if trimmed == "number":
        return "double"
    return ""

def map_parameter_type(parameter_type):
    trimmed = trim_text(parameter_type)
    if len(trimmed) == 0:
        return "double"
    if trimmed == "number":
        return "double"
    return ""

def find_parameter_binding(bindings, name):
    index = 0
    while True:
        if index >= len(bindings):
            break
        binding = bindings[index]
        if binding.name == name:
            return binding
        index += 1
    return null

def sanitize_symbol(name):
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
        return "anon"
    return result

def is_symbol_char(ch):
    if ch == "_":
        return true
    code = char_code(ch)
    if code >= char_code("a")  and  code <= char_code("z"):
        return true
    if code >= char_code("A")  and  code <= char_code("Z"):
        return true
    if code >= char_code("0")  and  code <= char_code("9"):
        return true
    return false

def is_number_literal(text):
    index = 0
    has_digit = false
    has_decimal = false
    trimmed = trim_text(text)
    if len(trimmed) == 0:
        return false
    if trimmed[0] == "-":
        if len(trimmed) == 1:
            return false
        index = 1
    while True:
        if index >= len(trimmed):
            break
        ch = trimmed[index]
        if ch >= "0"  and  ch <= "9":
            has_digit = true
            index += 1
            continue
        if ch == ".":
            if has_decimal:
                return false
            has_decimal = true
            index += 1
            continue
        return false
    return has_digit

def normalise_number_literal(text):
    trimmed = trim_text(text)
    if index_of(trimmed, ".") >= 0:
        return trimmed
    return trimmed + ".0"

def trim_text(value):
    start = 0
    end = len(value)
    while True:
        if start >= end:
            break
        ch = value[start]
        if is_trim_char(ch):
            start += 1
            continue
        break
    while True:
        if end <= start:
            break
        ch = value[end - 1]
        if is_trim_char(ch):
            end -= 1
            continue
        break
    if start == 0  and  end == len(value):
        return value
    return substring(value, start, end)

def is_trim_char(ch):
    return ch == " "  or  ch == "\n"  or  ch == "\r"  or  ch == "\t"

def index_of(value, target):
    if len(target) == 0:
        return 0
    index = 0
    while True:
        if index + len(target) > len(value):
            break
        match_index = 0
        matches = true
        while True:
            if match_index >= len(target):
                break
            if value[index + match_index] != target[match_index]:
                matches = false
                break
            match_index += 1
        if matches:
            return index
        index += 1
    return -1

def append_string(values, value):
    return (values) + ([value])

def append_parameter_binding(bindings, binding):
    return (bindings) + ([binding])

def join_with_separator(values, separator):
    if len(values) == 0:
        return ""
    result = values[0]
    index = 1
    while True:
        if index >= len(values):
            break
        result = result + separator + values[index]
        index += 1
    return result
