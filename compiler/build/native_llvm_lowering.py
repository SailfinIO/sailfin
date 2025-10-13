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

    def __repr__(self):
        return runtime.struct_repr('LoweredLLVMResult', [runtime.struct_field('ir', self.ir), runtime.struct_field('diagnostics', self.diagnostics)])

class LoweredLLVMFunction:
    def __init__(self, lines, diagnostics):
        self.lines = lines
        self.diagnostics = diagnostics

    def __repr__(self):
        return runtime.struct_repr('LoweredLLVMFunction', [runtime.struct_field('lines', self.lines), runtime.struct_field('diagnostics', self.diagnostics)])

class BodyResult:
    def __init__(self, lines, diagnostics):
        self.lines = lines
        self.diagnostics = diagnostics

    def __repr__(self):
        return runtime.struct_repr('BodyResult', [runtime.struct_field('lines', self.lines), runtime.struct_field('diagnostics', self.diagnostics)])

class ParameterBinding:
    def __init__(self, name, llvm_name, llvm_type):
        self.name = name
        self.llvm_name = llvm_name
        self.llvm_type = llvm_type

    def __repr__(self):
        return runtime.struct_repr('ParameterBinding', [runtime.struct_field('name', self.name), runtime.struct_field('llvm_name', self.llvm_name), runtime.struct_field('llvm_type', self.llvm_type)])

class ParameterPreparation:
    def __init__(self, signature, bindings, diagnostics):
        self.signature = signature
        self.bindings = bindings
        self.diagnostics = diagnostics

    def __repr__(self):
        return runtime.struct_repr('ParameterPreparation', [runtime.struct_field('signature', self.signature), runtime.struct_field('bindings', self.bindings), runtime.struct_field('diagnostics', self.diagnostics)])

class LLVMOperand:
    def __init__(self, llvm_type, value):
        self.llvm_type = llvm_type
        self.value = value

    def __repr__(self):
        return runtime.struct_repr('LLVMOperand', [runtime.struct_field('llvm_type', self.llvm_type), runtime.struct_field('value', self.value)])

class ExpressionResult:
    def __init__(self, lines, temp_index, diagnostics, operand=None):
        self.lines = lines
        self.temp_index = temp_index
        self.operand = operand
        self.diagnostics = diagnostics

    def __repr__(self):
        return runtime.struct_repr('ExpressionResult', [runtime.struct_field('lines', self.lines), runtime.struct_field('temp_index', self.temp_index), runtime.struct_field('operand', self.operand), runtime.struct_field('diagnostics', self.diagnostics)])

class LocalBinding:
    def __init__(self, name, operand):
        self.name = name
        self.operand = operand

    def __repr__(self):
        return runtime.struct_repr('LocalBinding', [runtime.struct_field('name', self.name), runtime.struct_field('operand', self.operand)])

class OperatorMatch:
    def __init__(self, index, symbol, success):
        self.index = index
        self.symbol = symbol
        self.success = success

    def __repr__(self):
        return runtime.struct_repr('OperatorMatch', [runtime.struct_field('index', self.index), runtime.struct_field('symbol', self.symbol), runtime.struct_field('success', self.success)])

def lower_to_llvm(native_module):
    diagnostics = []
    artifact = select_text_artifact(native_module.artifacts)
    if artifact == None:
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
        lowered = emit_function(parse.functions[index], parse.functions)
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

def emit_function(function, functions):
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
    body = emit_body(function, llvm_return, preparation.bindings, functions)
    lines = (lines) + (body.lines)
    diagnostics = (diagnostics) + (body.diagnostics)
    lines = append_string(lines, "}")
    return LoweredLLVMFunction(lines=lines, diagnostics=diagnostics)

def emit_body(function, llvm_return, bindings, functions):
    diagnostics = []
    lines = []
    locals = []
    temp_index = 0
    encountered_return = False
    index = 0
    while True:
        if index >= len(function.instructions):
            break
        instruction = function.instructions[index]
        if instruction.variant == "Let":
            if instruction.value == None  or  len(instruction.value) == 0:
                diagnostics = append_string(diagnostics, "llvm lowering: let `" + instruction.name + "` missing initializer in `" + function.name + "`")
            else:
                lowered = lower_expression(instruction.value, bindings, locals, temp_index, lines, functions)
                diagnostics = (diagnostics) + (lowered.diagnostics)
                lines = lowered.lines
                temp_index = lowered.temp_index
                if lowered.operand == None:
                    diagnostics = append_string(diagnostics, "llvm lowering: unable to materialize value for `" + instruction.name + "` in `" + function.name + "`")
                else:
                    locals = upsert_local_binding(locals, instruction.name, lowered.operand)
        else:
            if instruction.variant == "Expression":
                lowered = lower_expression(instruction.expression, bindings, locals, temp_index, lines, functions)
                diagnostics = (diagnostics) + (lowered.diagnostics)
                lines = lowered.lines
                temp_index = lowered.temp_index
            else:
                if instruction.variant == "Return":
                    encountered_return = True
                    if instruction.expression == None  or  len(instruction.expression) == 0:
                        if llvm_return == "void":
                            lines = append_string(lines, "  ret void")
                        else:
                            diagnostics = append_string(diagnostics, "llvm lowering: missing return value in `" + function.name + "`")
                            lines = append_string(lines, "  ret " + llvm_return + " " + default_return_literal(llvm_return))
                    else:
                        lowered = lower_expression(instruction.expression, bindings, locals, temp_index, lines, functions)
                        diagnostics = (diagnostics) + (lowered.diagnostics)
                        lines = lowered.lines
                        temp_index = lowered.temp_index
                        if lowered.operand == None:
                            diagnostics = append_string(diagnostics, "llvm lowering: unhandled return expression in `" + function.name + "`")
                            lines = append_string(lines, "  ret " + llvm_return + " " + default_return_literal(llvm_return))
                        else:
                            if llvm_return == "void":
                                diagnostics = append_string(diagnostics, "llvm lowering: void function `" + function.name + "` returned a value")
                                lines = append_string(lines, "  ret void")
                            else:
                                if lowered.operand.llvm_type != llvm_return:
                                    diagnostics = append_string(diagnostics, "llvm lowering: return type `" + llvm_return + "` mismatches expression type `" + lowered.operand.llvm_type + "` in `" + function.name + "`")
                                    lines = append_string(lines, "  ret " + llvm_return + " " + default_return_literal(llvm_return))
                                else:
                                    lines = append_string(lines, "  ret " + lowered.operand.llvm_type + " " + lowered.operand.value)
                    index += 1
                    if index < len(function.instructions):
                        diagnostics = append_string(diagnostics, "llvm lowering: instructions after return ignored in `" + function.name + "`")
                    break
                else:
                    if instruction.variant == "Noop":
                        pass
                    else:
                        diagnostics = append_string(diagnostics, "llvm lowering: unsupported instruction `" + instruction.variant + "` in `" + function.name + "`")
        index += 1
    if not encountered_return:
        if llvm_return == "void":
            lines = append_string(lines, "  ret void")
        else:
            diagnostics = append_string(diagnostics, "llvm lowering: missing return in function `" + function.name + "`")
            lines = append_string(lines, "  ret " + llvm_return + " " + default_return_literal(llvm_return))
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
    return None

def lower_expression(expression, bindings, locals, temp_index, lines, functions):
    trimmed = trim_text(expression)
    diagnostics = []
    if len(trimmed) == 0:
        diagnostics = append_string(diagnostics, "llvm lowering: empty expression encountered")
        return ExpressionResult(lines=lines, temp_index=temp_index, operand=None, diagnostics=diagnostics)
    stripped = strip_enclosing_parentheses(trimmed)
    if stripped != trimmed:
        return lower_expression(stripped, bindings, locals, temp_index, lines, functions)
    additive = find_top_level_operator(stripped, "+-")
    if additive.success:
        return lower_binary_operation(stripped, additive, bindings, locals, temp_index, lines, functions)
    multiplicative = find_top_level_operator(stripped, "*/")
    if multiplicative.success:
        return lower_binary_operation(stripped, multiplicative, bindings, locals, temp_index, lines, functions)
    call_index = find_call_site(stripped)
    if call_index >= 0  and  stripped[len(stripped) - 1] == ")":
        target = trim_text(substring(stripped, 0, call_index))
        arguments_text = substring(stripped, call_index + 1, len(stripped) - 1)
        argument_entries = split_call_arguments(arguments_text)
        return lower_call_expression(target, argument_entries, bindings, locals, temp_index, lines, functions)
    parameter = find_parameter_binding(bindings, stripped)
    if parameter != None:
        operand = LLVMOperand(llvm_type=parameter.llvm_type, value=parameter.llvm_name)
        return ExpressionResult(lines=lines, temp_index=temp_index, operand=operand, diagnostics=diagnostics)
    local = find_local_binding(locals, stripped)
    if local != None:
        return ExpressionResult(lines=lines, temp_index=temp_index, operand=local, diagnostics=diagnostics)
    if is_number_literal(stripped):
        normalised = normalise_number_literal(stripped)
        operand = LLVMOperand(llvm_type="double", value=normalised)
        return ExpressionResult(lines=lines, temp_index=temp_index, operand=operand, diagnostics=diagnostics)
    diagnostics = append_string(diagnostics, "llvm lowering: unsupported expression `" + stripped + "`")
    return ExpressionResult(lines=lines, temp_index=temp_index, operand=None, diagnostics=diagnostics)

def lower_binary_operation(expression, match, bindings, locals, temp_index, lines, functions):
    left_text = trim_text(substring(expression, 0, match.index))
    right_text = trim_text(substring(expression, match.index + 1, len(expression)))
    diagnostics = []
    if len(left_text) == 0  or  len(right_text) == 0:
        diagnostics = append_string(diagnostics, "llvm lowering: malformed binary expression `" + expression + "`")
        return ExpressionResult(lines=lines, temp_index=temp_index, operand=None, diagnostics=diagnostics)
    left_result = lower_expression(left_text, bindings, locals, temp_index, lines, functions)
    diagnostics = (diagnostics) + (left_result.diagnostics)
    if left_result.operand == None:
        return ExpressionResult(lines=left_result.lines, temp_index=left_result.temp_index, operand=None, diagnostics=diagnostics)
    right_result = lower_expression(right_text, bindings, locals, left_result.temp_index, left_result.lines, functions)
    diagnostics = (diagnostics) + (right_result.diagnostics)
    if right_result.operand == None:
        return ExpressionResult(lines=right_result.lines, temp_index=right_result.temp_index, operand=None, diagnostics=diagnostics)
    left_operand = left_result.operand
    right_operand = right_result.operand
    if left_operand.llvm_type != right_operand.llvm_type:
        diagnostics = append_string(diagnostics, "llvm lowering: type mismatch in binary expression `" + expression + "`")
    operation = operation_name_for_symbol(match.symbol, left_operand.llvm_type)
    temp_name = format_temp_name(right_result.temp_index)
    line = "  " + temp_name + " = " + operation + " " + left_operand.llvm_type + " " + left_operand.value + ", " + right_operand.value
    updated_lines = append_string(right_result.lines, line)
    operand = LLVMOperand(llvm_type=left_operand.llvm_type, value=temp_name)
    return ExpressionResult(lines=updated_lines, temp_index=right_result.temp_index + 1, operand=operand, diagnostics=diagnostics)

def lower_call_expression(target, arguments, bindings, locals, temp_index, lines, functions):
    diagnostics = []
    trimmed_target = trim_text(target)
    if len(trimmed_target) == 0:
        diagnostics = append_string(diagnostics, "llvm lowering: call target missing")
        return ExpressionResult(lines=lines, temp_index=temp_index, operand=None, diagnostics=diagnostics)
    current_lines = lines
    current_temp = temp_index
    operands = []
    index = 0
    while True:
        if index >= len(arguments):
            break
        argument_text = trim_text(arguments[index])
        if len(argument_text) == 0:
            diagnostics = append_string(diagnostics, "llvm lowering: empty argument in call to `" + trimmed_target + "`")
        lowered = lower_expression(argument_text, bindings, locals, current_temp, current_lines, functions)
        diagnostics = (diagnostics) + (lowered.diagnostics)
        current_lines = lowered.lines
        current_temp = lowered.temp_index
        if lowered.operand != None:
            operands = append_llvm_operand(operands, lowered.operand)
        else:
            diagnostics = append_string(diagnostics, "llvm lowering: failed to lower argument " + number_to_string(index) + " for call to `" + trimmed_target + "`")
        index += 1
    if len(operands) != len(arguments):
        diagnostics = append_string(diagnostics, "llvm lowering: unable to emit call to `" + trimmed_target + "` due to argument errors")
        return ExpressionResult(lines=current_lines, temp_index=current_temp, operand=None, diagnostics=diagnostics)
    llvm_return = "double"
    expected_params = []
    function_entry = find_function_by_name(functions, trimmed_target)
    if function_entry != None:
        llvm_return = map_return_type(function_entry.return_type)
        if len(llvm_return) == 0:
            diagnostics = append_string(diagnostics, "llvm lowering: unsupported return type in call to `" + trimmed_target + "`")
            llvm_return = "double"
        expected_params = collect_parameter_types(function_entry.parameters)
        if len(expected_params) != len(operands):
            diagnostics = append_string(diagnostics, "llvm lowering: call to `" + trimmed_target + "` expected " + number_to_string(len(expected_params)) + " arguments but received " + number_to_string(len(operands)))
        else:
            type_index = 0
            while True:
                if type_index >= len(operands):
                    break
                if expected_params[type_index] != operands[type_index].llvm_type:
                    diagnostics = append_string(diagnostics, "llvm lowering: argument " + number_to_string(type_index) + " for call to `" + trimmed_target + "` has type `" + operands[type_index].llvm_type + "` but expected `" + expected_params[type_index] + "`")
                type_index += 1
    else:
        diagnostics = append_string(diagnostics, "llvm lowering: call to unknown function `" + trimmed_target + "`")
    rendered_args = []
    index = 0
    while True:
        if index >= len(operands):
            break
        rendered_args = append_string(rendered_args, format_typed_operand(operands[index]))
        index += 1
    argument_text = join_with_separator(rendered_args, ", ")
    sanitized_name = sanitize_symbol(trimmed_target)
    if llvm_return == "void":
        call_line = "  call void @" + sanitized_name + "(" + argument_text + ")"
        current_lines = append_string(current_lines, call_line)
        return ExpressionResult(lines=current_lines, temp_index=current_temp, operand=None, diagnostics=diagnostics)
    temp_name = format_temp_name(current_temp)
    call_line = "  " + temp_name + " = call " + llvm_return + " @" + sanitized_name + "(" + argument_text + ")"
    current_lines = append_string(current_lines, call_line)
    operand = LLVMOperand(llvm_type=llvm_return, value=temp_name)
    return ExpressionResult(lines=current_lines, temp_index=current_temp + 1, operand=operand, diagnostics=diagnostics)

def collect_parameter_types(parameters):
    types = []
    index = 0
    while True:
        if index >= len(parameters):
            break
        llvm_type = map_parameter_type(parameters[index].type_annotation)
        if len(llvm_type) == 0:
            types = append_string(types, "double")
        else:
            types = append_string(types, llvm_type)
        index += 1
    return types

def strip_enclosing_parentheses(expression):
    trimmed = trim_text(expression)
    if len(trimmed) < 2:
        return trimmed
    if trimmed[0] != "("  or  trimmed[len(trimmed) - 1] != ")":
        return trimmed
    depth = 0
    index = 0
    while True:
        if index >= len(trimmed):
            break
        ch = trimmed[index]
        if ch == "(":
            depth += 1
        else:
            if ch == ")":
                depth -= 1
                if depth == 0:
                    if index == len(trimmed) - 1:
                        inner = substring(trimmed, 1, len(trimmed) - 1)
                        return strip_enclosing_parentheses(inner)
                    return trimmed
        index += 1
    return trimmed

def find_top_level_operator(expression, operators):
    depth = 0
    index = len(expression)
    while True:
        if index <= 0:
            break
        index -= 1
        ch = expression[index]
        if ch == ")":
            depth += 1
            continue
        if ch == "(":
            if depth > 0:
                depth -= 1
                continue
        if depth > 0:
            continue
        if contains_char(operators, ch):
            if ch == "-":
                if not is_binary_minus(expression, index):
                    continue
            return OperatorMatch(index=index, symbol=substring(expression, index, index + 1), success=True)
    return OperatorMatch(index=-1, symbol="", success=False)

def contains_char(set, ch):
    index = 0
    while True:
        if index >= len(set):
            break
        if set[index] == ch:
            return True
        index += 1
    return False

def is_binary_minus(expression, index):
    previous = find_previous_non_space_char(expression, index)
    next = find_next_non_space_char(expression, index)
    if previous == None:
        return False
    prev_char = previous
    if prev_char == "+"  or  prev_char == "-"  or  prev_char == "*"  or  prev_char == "/"  or  prev_char == "("  or  prev_char == ",":
        return False
    if next == None:
        return False
    next_char = next
    if next_char == "+"  or  next_char == "-"  or  next_char == "*"  or  next_char == "/"  or  next_char == ")"  or  next_char == ",":
        return False
    return True

def find_previous_non_space_char(value, index):
    position = index
    while True:
        if position <= 0:
            break
        position -= 1
        ch = value[position]
        if not is_trim_char(ch):
            return ch
    return None

def find_next_non_space_char(value, index):
    position = index + 1
    while True:
        if position >= len(value):
            break
        ch = value[position]
        if not is_trim_char(ch):
            return ch
        position += 1
    return None

def find_call_site(expression):
    depth = 0
    index = 0
    while True:
        if index >= len(expression):
            break
        ch = expression[index]
        if ch == "(":
            if depth == 0:
                return index
            depth += 1
        else:
            if ch == ")":
                if depth > 0:
                    depth -= 1
        index += 1
    return -1

def split_call_arguments(text):
    trimmed = trim_text(text)
    if len(trimmed) == 0:
        return []
    entries = []
    current = ""
    depth = 0
    index = 0
    while True:
        if index >= len(text):
            break
        ch = text[index]
        if ch == "(":
            depth += 1
            current = current + ch
        else:
            if ch == ")":
                if depth > 0:
                    depth -= 1
                current = current + ch
            else:
                if ch == ","  and  depth == 0:
                    entries = append_string(entries, trim_text(current))
                    current = ""
                else:
                    current = current + ch
        index += 1
    entries = append_string(entries, trim_text(current))
    return entries

def operation_name_for_symbol(symbol, llvm_type):
    if llvm_type == "double":
        if symbol == "+":
            return "fadd"
        if symbol == "-":
            return "fsub"
        if symbol == "*":
            return "fmul"
        if symbol == "/":
            return "fdiv"
    if symbol == "+":
        return "add"
    if symbol == "-":
        return "sub"
    if symbol == "*":
        return "mul"
    if symbol == "/":
        return "sdiv"
    return "add"

def format_temp_name(index):
    return "%t" + number_to_string(index)

def format_typed_operand(operand):
    return operand.llvm_type + " " + operand.value

def default_return_literal(llvm_type):
    if llvm_type == "double":
        return "0.0"
    if llvm_type == "i32":
        return "0"
    if llvm_type == "i64":
        return "0"
    if llvm_type == "i1":
        return "0"
    return "zeroinitializer"

def find_local_binding(locals, name):
    index = 0
    while True:
        if index >= len(locals):
            break
        entry = locals[index]
        if entry.name == name:
            return entry.operand
        index += 1
    return None

def upsert_local_binding(locals, name, operand):
    result = []
    replaced = False
    index = 0
    while True:
        if index >= len(locals):
            break
        entry = locals[index]
        if entry.name == name:
            result = append_local_binding(result, LocalBinding(name=name, operand=operand))
            replaced = True
        else:
            result = append_local_binding(result, entry)
        index += 1
    if not replaced:
        result = append_local_binding(result, LocalBinding(name=name, operand=operand))
    return result

def append_local_binding(values, value):
    return (values) + ([value])

def append_llvm_operand(values, value):
    return (values) + ([value])

def find_function_by_name(functions, name):
    index = 0
    while True:
        if index >= len(functions):
            break
        if functions[index].name == name:
            return functions[index]
        index += 1
    return None

def number_to_string(value):
    if value == 0:
        return "0"
    digits = "0123456789"
    remaining = value
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
        digit = temp
        ch = substring(digits, digit, digit + 1)
        output = ch + output
        remaining = quotient
    return output

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
        return True
    code = char_code(ch)
    if code >= char_code("a")  and  code <= char_code("z"):
        return True
    if code >= char_code("A")  and  code <= char_code("Z"):
        return True
    if code >= char_code("0")  and  code <= char_code("9"):
        return True
    return False

def is_number_literal(text):
    index = 0
    has_digit = False
    has_decimal = False
    trimmed = trim_text(text)
    if len(trimmed) == 0:
        return False
    if trimmed[0] == "-":
        if len(trimmed) == 1:
            return False
        index = 1
    while True:
        if index >= len(trimmed):
            break
        ch = trimmed[index]
        if ch >= "0"  and  ch <= "9":
            has_digit = True
            index += 1
            continue
        if ch == ".":
            if has_decimal:
                return False
            has_decimal = True
            index += 1
            continue
        return False
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
        matches = True
        while True:
            if match_index >= len(target):
                break
            if value[index + match_index] != target[match_index]:
                matches = False
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
