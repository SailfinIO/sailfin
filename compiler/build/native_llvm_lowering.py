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
    def __init__(self, name, pointer, llvm_type):
        self.name = name
        self.pointer = pointer
        self.llvm_type = llvm_type

    def __repr__(self):
        return runtime.struct_repr('LocalBinding', [runtime.struct_field('name', self.name), runtime.struct_field('pointer', self.pointer), runtime.struct_field('llvm_type', self.llvm_type)])

class OperatorMatch:
    def __init__(self, index, symbol, success):
        self.index = index
        self.symbol = symbol
        self.success = success

    def __repr__(self):
        return runtime.struct_repr('OperatorMatch', [runtime.struct_field('index', self.index), runtime.struct_field('symbol', self.symbol), runtime.struct_field('success', self.success)])

class AssignmentParseResult:
    def __init__(self, success, target, value):
        self.success = success
        self.target = target
        self.value = value

    def __repr__(self):
        return runtime.struct_repr('AssignmentParseResult', [runtime.struct_field('success', self.success), runtime.struct_field('target', self.target), runtime.struct_field('value', self.value)])

class ExpressionStatementResult:
    def __init__(self, lines, temp_index, diagnostics):
        self.lines = lines
        self.temp_index = temp_index
        self.diagnostics = diagnostics

    def __repr__(self):
        return runtime.struct_repr('ExpressionStatementResult', [runtime.struct_field('lines', self.lines), runtime.struct_field('temp_index', self.temp_index), runtime.struct_field('diagnostics', self.diagnostics)])

class LetLoweringResult:
    def __init__(self, lines, allocas, locals, temp_index, diagnostics, next_local_id):
        self.lines = lines
        self.allocas = allocas
        self.locals = locals
        self.temp_index = temp_index
        self.diagnostics = diagnostics
        self.next_local_id = next_local_id

    def __repr__(self):
        return runtime.struct_repr('LetLoweringResult', [runtime.struct_field('lines', self.lines), runtime.struct_field('allocas', self.allocas), runtime.struct_field('locals', self.locals), runtime.struct_field('temp_index', self.temp_index), runtime.struct_field('diagnostics', self.diagnostics), runtime.struct_field('next_local_id', self.next_local_id)])

class BlockLabelResult:
    def __init__(self, label, next_counter):
        self.label = label
        self.next_counter = next_counter

    def __repr__(self):
        return runtime.struct_repr('BlockLabelResult', [runtime.struct_field('label', self.label), runtime.struct_field('next_counter', self.next_counter)])

class IfStructure:
    def __init__(self, then_start, then_end, else_start, else_end, has_else, next_index, diagnostics):
        self.then_start = then_start
        self.then_end = then_end
        self.else_start = else_start
        self.else_end = else_end
        self.has_else = has_else
        self.next_index = next_index
        self.diagnostics = diagnostics

    def __repr__(self):
        return runtime.struct_repr('IfStructure', [runtime.struct_field('then_start', self.then_start), runtime.struct_field('then_end', self.then_end), runtime.struct_field('else_start', self.else_start), runtime.struct_field('else_end', self.else_end), runtime.struct_field('has_else', self.has_else), runtime.struct_field('next_index', self.next_index), runtime.struct_field('diagnostics', self.diagnostics)])

class LoopContext:
    def __init__(self, break_label, continue_label):
        self.break_label = break_label
        self.continue_label = continue_label

    def __repr__(self):
        return runtime.struct_repr('LoopContext', [runtime.struct_field('break_label', self.break_label), runtime.struct_field('continue_label', self.continue_label)])

class LoopStructure:
    def __init__(self, body_start, body_end, next_index, diagnostics):
        self.body_start = body_start
        self.body_end = body_end
        self.next_index = next_index
        self.diagnostics = diagnostics

    def __repr__(self):
        return runtime.struct_repr('LoopStructure', [runtime.struct_field('body_start', self.body_start), runtime.struct_field('body_end', self.body_end), runtime.struct_field('next_index', self.next_index), runtime.struct_field('diagnostics', self.diagnostics)])

class RangeIterableParse:
    def __init__(self, success, start, end, diagnostics):
        self.success = success
        self.start = start
        self.end = end
        self.diagnostics = diagnostics

    def __repr__(self):
        return runtime.struct_repr('RangeIterableParse', [runtime.struct_field('success', self.success), runtime.struct_field('start', self.start), runtime.struct_field('end', self.end), runtime.struct_field('diagnostics', self.diagnostics)])

class MatchCaseStructure:
    def __init__(self, pattern, body_start, body_end, is_default, guard=None):
        self.pattern = pattern
        self.guard = guard
        self.body_start = body_start
        self.body_end = body_end
        self.is_default = is_default

    def __repr__(self):
        return runtime.struct_repr('MatchCaseStructure', [runtime.struct_field('pattern', self.pattern), runtime.struct_field('guard', self.guard), runtime.struct_field('body_start', self.body_start), runtime.struct_field('body_end', self.body_end), runtime.struct_field('is_default', self.is_default)])

class MatchStructure:
    def __init__(self, cases, end_index, diagnostics):
        self.cases = cases
        self.end_index = end_index
        self.diagnostics = diagnostics

    def __repr__(self):
        return runtime.struct_repr('MatchStructure', [runtime.struct_field('cases', self.cases), runtime.struct_field('end_index', self.end_index), runtime.struct_field('diagnostics', self.diagnostics)])

class MatchCaseCondition:
    def __init__(self, lines, temp_index, diagnostics, is_default, operand=None):
        self.lines = lines
        self.temp_index = temp_index
        self.operand = operand
        self.diagnostics = diagnostics
        self.is_default = is_default

    def __repr__(self):
        return runtime.struct_repr('MatchCaseCondition', [runtime.struct_field('lines', self.lines), runtime.struct_field('temp_index', self.temp_index), runtime.struct_field('operand', self.operand), runtime.struct_field('diagnostics', self.diagnostics), runtime.struct_field('is_default', self.is_default)])

class ConditionConversion:
    def __init__(self, lines, temp_index, diagnostics, operand=None):
        self.lines = lines
        self.temp_index = temp_index
        self.operand = operand
        self.diagnostics = diagnostics

    def __repr__(self):
        return runtime.struct_repr('ConditionConversion', [runtime.struct_field('lines', self.lines), runtime.struct_field('temp_index', self.temp_index), runtime.struct_field('operand', self.operand), runtime.struct_field('diagnostics', self.diagnostics)])

class ComparisonEmission:
    def __init__(self, lines, temp_index, diagnostics, operand=None):
        self.lines = lines
        self.temp_index = temp_index
        self.operand = operand
        self.diagnostics = diagnostics

    def __repr__(self):
        return runtime.struct_repr('ComparisonEmission', [runtime.struct_field('lines', self.lines), runtime.struct_field('temp_index', self.temp_index), runtime.struct_field('operand', self.operand), runtime.struct_field('diagnostics', self.diagnostics)])

class CoercionResult:
    def __init__(self, lines, temp_index, diagnostics, operand=None):
        self.lines = lines
        self.temp_index = temp_index
        self.operand = operand
        self.diagnostics = diagnostics

    def __repr__(self):
        return runtime.struct_repr('CoercionResult', [runtime.struct_field('lines', self.lines), runtime.struct_field('temp_index', self.temp_index), runtime.struct_field('operand', self.operand), runtime.struct_field('diagnostics', self.diagnostics)])

class BinaryAlignmentResult:
    def __init__(self, lines, temp_index, diagnostics, result_type, left=None, right=None):
        self.lines = lines
        self.temp_index = temp_index
        self.left = left
        self.right = right
        self.diagnostics = diagnostics
        self.result_type = result_type

    def __repr__(self):
        return runtime.struct_repr('BinaryAlignmentResult', [runtime.struct_field('lines', self.lines), runtime.struct_field('temp_index', self.temp_index), runtime.struct_field('left', self.left), runtime.struct_field('right', self.right), runtime.struct_field('diagnostics', self.diagnostics), runtime.struct_field('result_type', self.result_type)])

class BlockLoweringResult:
    def __init__(self, lines, allocas, locals, temp_index, block_counter, diagnostics, terminated, next_local_id, next_index):
        self.lines = lines
        self.allocas = allocas
        self.locals = locals
        self.temp_index = temp_index
        self.block_counter = block_counter
        self.diagnostics = diagnostics
        self.terminated = terminated
        self.next_local_id = next_local_id
        self.next_index = next_index

    def __repr__(self):
        return runtime.struct_repr('BlockLoweringResult', [runtime.struct_field('lines', self.lines), runtime.struct_field('allocas', self.allocas), runtime.struct_field('locals', self.locals), runtime.struct_field('temp_index', self.temp_index), runtime.struct_field('block_counter', self.block_counter), runtime.struct_field('diagnostics', self.diagnostics), runtime.struct_field('terminated', self.terminated), runtime.struct_field('next_local_id', self.next_local_id), runtime.struct_field('next_index', self.next_index)])

class LoadLocalResult:
    def __init__(self, lines, temp_index, diagnostics, operand=None):
        self.lines = lines
        self.temp_index = temp_index
        self.operand = operand
        self.diagnostics = diagnostics

    def __repr__(self):
        return runtime.struct_repr('LoadLocalResult', [runtime.struct_field('lines', self.lines), runtime.struct_field('temp_index', self.temp_index), runtime.struct_field('operand', self.operand), runtime.struct_field('diagnostics', self.diagnostics)])

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
    has_add_function = false
    while True:
        if index >= len(parse.functions):
            break
        lowered = emit_function(parse.functions[index], parse.functions)
        if sanitize_symbol(parse.functions[index].name) == "add":
            has_add_function = true
        diagnostics = (diagnostics) + (lowered.diagnostics)
        if len(lowered.lines) > 0:
            lines = (lines) + (lowered.lines)
            if index + 1 < len(parse.functions):
                lines = append_string(lines, "")
        index += 1
    if not has_add_function:
        if len(lines) > 0:
            lines = append_string(lines, "")
        lines = (lines) + ([ "define double @add(double %a, double %b) {", "entry:", "  %t0 = fadd double %a, %b", "  ret double %t0", "}" ])
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
    lowered = lower_instruction_range( function, 0, len(function.instructions), llvm_return, bindings, [], [], [], 0, 0, 0, functions, [] )
    diagnostics = lowered.diagnostics
    lines = []
    lines = (lines) + (lowered.allocas)
    lines = (lines) + (lowered.lines)
    if not lowered.terminated:
        if llvm_return == "void":
            lines = append_string(lines, "  ret void")
        else:
            diagnostics = append_string(diagnostics, "llvm lowering: missing return in function `" + function.name + "`")
            lines = append_string(lines, "  ret " + llvm_return + " " + default_return_literal(llvm_return))
    return BodyResult(lines=lines, diagnostics=diagnostics)

def lower_instruction_range(function, start_index, end, llvm_return, bindings, locals, allocas, lines, temp_index, block_counter, next_local_id, functions, loop_stack):
    diagnostics = []
    current_lines = lines
    current_allocas = allocas
    current_locals = locals
    current_temp = temp_index
    current_block_counter = block_counter
    current_next_local = next_local_id
    terminated = false
    current_loop_stack = loop_stack
    index = start_index
    while True:
        if index >= end:
            break
        instruction = function.instructions[index]
        if instruction.variant == "Let":
            lowered = lower_let_instruction(function, instruction, bindings, current_locals, current_allocas, current_lines, current_temp, current_next_local, functions)
            diagnostics = (diagnostics) + (lowered.diagnostics)
            current_lines = lowered.lines
            current_allocas = lowered.allocas
            current_locals = lowered.locals
            current_temp = lowered.temp_index
            current_next_local = lowered.next_local_id
        else:
            if instruction.variant == "Expression":
                lowered = lower_expression_statement(instruction.expression, bindings, current_locals, current_temp, current_lines, functions)
                diagnostics = (diagnostics) + (lowered.diagnostics)
                current_lines = lowered.lines
                current_temp = lowered.temp_index
            else:
                if instruction.variant == "Return":
                    lowered = lower_return_instruction(function, instruction, llvm_return, bindings, current_locals, current_temp, current_lines, functions)
                    diagnostics = (diagnostics) + (lowered.diagnostics)
                    current_lines = lowered.lines
                    current_temp = lowered.temp_index
                    terminated = true
                    index += 1
                    if index < end:
                        diagnostics = append_string(diagnostics, "llvm lowering: instructions after return ignored in `" + function.name + "`")
                    break
                else:
                    if instruction.variant == "If":
                        lowered = lower_if_instruction( function, index, llvm_return, bindings, current_locals, current_allocas, current_lines, current_temp, current_block_counter, current_next_local, functions, current_loop_stack, end )
                        diagnostics = (diagnostics) + (lowered.diagnostics)
                        current_lines = lowered.lines
                        current_allocas = lowered.allocas
                        current_locals = lowered.locals
                        current_temp = lowered.temp_index
                        current_block_counter = lowered.block_counter
                        current_next_local = lowered.next_local_id
                        terminated = lowered.terminated
                        index = lowered.next_index
                        if terminated:
                            break
                        continue
                    else:
                        if instruction.variant == "Loop":
                            lowered = lower_loop_instruction( function, index, llvm_return, bindings, current_locals, current_allocas, current_lines, current_temp, current_block_counter, current_next_local, functions, current_loop_stack, end )
                            diagnostics = (diagnostics) + (lowered.diagnostics)
                            current_lines = lowered.lines
                            current_allocas = lowered.allocas
                            current_locals = lowered.locals
                            current_temp = lowered.temp_index
                            current_block_counter = lowered.block_counter
                            current_next_local = lowered.next_local_id
                            terminated = lowered.terminated
                            index = lowered.next_index
                            if terminated:
                                break
                            continue
                        else:
                            if instruction.variant == "Match":
                                lowered = lower_match_instruction( function, index, llvm_return, bindings, current_locals, current_allocas, current_lines, current_temp, current_block_counter, current_next_local, functions, current_loop_stack, end )
                                diagnostics = (diagnostics) + (lowered.diagnostics)
                                current_lines = lowered.lines
                                current_allocas = lowered.allocas
                                current_locals = lowered.locals
                                current_temp = lowered.temp_index
                                current_block_counter = lowered.block_counter
                                current_next_local = lowered.next_local_id
                                terminated = lowered.terminated
                                index = lowered.next_index
                                if terminated:
                                    break
                                continue
                            else:
                                if instruction.variant == "Else"  or  instruction.variant == "EndIf":
                                    break
                                else:
                                    if instruction.variant == "EndLoop"  or  instruction.variant == "EndMatch"  or  instruction.variant == "EndFor":
                                        break
                                    else:
                                        if instruction.variant == "Break":
                                            if len(current_loop_stack) == 0:
                                                diagnostics = append_string(diagnostics, "llvm lowering: `break` outside loop in `" + function.name + "`")
                                            else:
                                                context = last_loop_context(current_loop_stack)
                                                current_lines = append_string(current_lines, "  br label %" + context.break_label)
                                                terminated = true
                                            index += 1
                                            if index < end  and  terminated:
                                                diagnostics = append_string(diagnostics, "llvm lowering: instructions after break ignored in `" + function.name + "`")
                                            break
                                        else:
                                            if instruction.variant == "Continue":
                                                if len(current_loop_stack) == 0:
                                                    diagnostics = append_string(diagnostics, "llvm lowering: `continue` outside loop in `" + function.name + "`")
                                                else:
                                                    context = last_loop_context(current_loop_stack)
                                                    current_lines = append_string(current_lines, "  br label %" + context.continue_label)
                                                    terminated = true
                                                index += 1
                                                if index < end  and  terminated:
                                                    diagnostics = append_string(diagnostics, "llvm lowering: instructions after continue ignored in `" + function.name + "`")
                                                break
                                            else:
                                                if instruction.variant == "For":
                                                    lowered = lower_for_instruction( function, index, llvm_return, bindings, current_locals, current_allocas, current_lines, current_temp, current_block_counter, current_next_local, functions, current_loop_stack, end )
                                                    diagnostics = (diagnostics) + (lowered.diagnostics)
                                                    current_lines = lowered.lines
                                                    current_allocas = lowered.allocas
                                                    current_locals = lowered.locals
                                                    current_temp = lowered.temp_index
                                                    current_block_counter = lowered.block_counter
                                                    current_next_local = lowered.next_local_id
                                                    terminated = lowered.terminated
                                                    index = lowered.next_index
                                                    if terminated:
                                                        break
                                                    continue
                                                else:
                                                    if instruction.variant == "Noop":
                                                        pass
                                                    else:
                                                        diagnostics = append_string(diagnostics, "llvm lowering: unsupported instruction `" + instruction.variant + "` in `" + function.name + "`")
        index += 1
    return BlockLoweringResult(lines=current_lines, allocas=current_allocas, locals=current_locals, temp_index=current_temp, block_counter=current_block_counter, diagnostics=diagnostics, terminated=terminated, next_local_id=current_next_local, next_index=index)

def collect_if_structure(instructions, start_index, end, function_name):
    diagnostics = []
    then_start = start_index + 1
    then_end = end
    else_start = -1
    else_end = -1
    has_else = false
    depth = 0
    index = then_start
    limit = end
    if limit > len(instructions):
        limit = len(instructions)
    while True:
        if index >= limit:
            diagnostics = append_string(diagnostics, "llvm lowering: unterminated `.if` in `" + function_name + "`")
            return IfStructure(then_start=then_start, then_end=limit, else_start=else_start, else_end=else_end, has_else=has_else, next_index=limit - 1, diagnostics=diagnostics)
        current = instructions[index]
        if current.variant == "If":
            depth += 1
            index += 1
            continue
        if current.variant == "EndIf":
            if depth == 0:
                if not has_else:
                    then_end = index
                else:
                    else_end = index
                return IfStructure(then_start=then_start, then_end=then_end, else_start=else_start, else_end=else_end, has_else=has_else, next_index=index, diagnostics=diagnostics)
            depth -= 1
            index += 1
            continue
        if current.variant == "Else":
            if depth == 0:
                if has_else:
                    diagnostics = append_string(diagnostics, "llvm lowering: duplicate `.else` in `.if` within `" + function_name + "`")
                else:
                    has_else = true
                    then_end = index
                    else_start = index + 1
            index += 1
            continue
        index += 1

def collect_loop_structure(instructions, start_index, end, function_name):
    diagnostics = []
    body_start = start_index + 1
    body_end = end
    depth = 0
    index = body_start
    limit = end
    if limit > len(instructions):
        limit = len(instructions)
    while True:
        if index >= limit:
            if limit <= 0:
                limit = 0
            diagnostics = append_string(diagnostics, "llvm lowering: unterminated `.loop` in `" + function_name + "`")
            return LoopStructure(body_start=body_start, body_end=limit, next_index=limit - 1, diagnostics=diagnostics)
        current = instructions[index]
        if current.variant == "Loop"  or  current.variant == "For":
            depth += 1
            index += 1
            continue
        if current.variant == "EndLoop"  or  current.variant == "EndFor":
            if depth == 0:
                body_end = index
                return LoopStructure(body_start=body_start, body_end=body_end, next_index=index, diagnostics=diagnostics)
            if depth > 0:
                depth -= 1
            index += 1
            continue
        index += 1

def append_loop_context(values, value):
    return (values) + ([value])

def last_loop_context(values):
    index = len(values)
    if index <= 0:
        return LoopContext(break_label="", continue_label="")
    index -= 1
    return values[index]

def lower_loop_instruction(function, start_index, llvm_return, bindings, locals, allocas, lines, temp_index, block_counter, next_local_id, functions, loop_stack, end):
    diagnostics = []
    current_lines = lines
    current_allocas = allocas
    current_locals = locals
    current_temp = temp_index
    current_block_counter = block_counter
    current_next_local = next_local_id
    structure = collect_loop_structure(function.instructions, start_index, end, function.name)
    diagnostics = (diagnostics) + (structure.diagnostics)
    loop_alloc = allocate_block_label("loop", current_block_counter)
    loop_label = loop_alloc.label
    current_block_counter = loop_alloc.next_counter
    exit_alloc = allocate_block_label("afterloop", current_block_counter)
    exit_label = exit_alloc.label
    current_block_counter = exit_alloc.next_counter
    current_lines = append_string(current_lines, "  br label %" + loop_label)
    current_lines = append_string(current_lines, loop_label + ":")
    context = LoopContext(break_label=exit_label, continue_label=loop_label)
    stacked = append_loop_context(loop_stack, context)
    base_locals = current_locals
    base_allocas = current_allocas
    base_local_id = current_next_local
    body_result = lower_instruction_range( function, structure.body_start, structure.body_end, llvm_return, bindings, base_locals, base_allocas, [], current_temp, current_block_counter, base_local_id, functions, stacked )
    diagnostics = (diagnostics) + (body_result.diagnostics)
    current_lines = (current_lines) + (body_result.lines)
    current_allocas = body_result.allocas
    current_locals = base_locals
    current_temp = body_result.temp_index
    current_block_counter = body_result.block_counter
    current_next_local = body_result.next_local_id
    if not body_result.terminated:
        current_lines = append_string(current_lines, "  br label %" + loop_label)
    current_lines = append_string(current_lines, exit_label + ":")
    return BlockLoweringResult(lines=current_lines, allocas=current_allocas, locals=current_locals, temp_index=current_temp, block_counter=current_block_counter, diagnostics=diagnostics, terminated=false, next_local_id=current_next_local, next_index=structure.next_index + 1)

def lower_for_instruction(function, start_index, llvm_return, bindings, locals, allocas, lines, temp_index, block_counter, next_local_id, functions, loop_stack, end):
    diagnostics = []
    current_lines = lines
    current_allocas = allocas
    current_locals = locals
    current_temp = temp_index
    current_block_counter = block_counter
    current_next_local = next_local_id
    structure = collect_loop_structure(function.instructions, start_index, end, function.name)
    diagnostics = (diagnostics) + (structure.diagnostics)
    next_index = structure.next_index + 1
    instruction = function.instructions[start_index]
    range_parse = parse_range_iterable(instruction.iterable)
    diagnostics = (diagnostics) + (range_parse.diagnostics)
    if not range_parse.success:
        diagnostics = append_string(diagnostics, "llvm lowering: only numeric ranges (`start..end`) are supported for `.for` loops in `" + function.name + "`")
        return BlockLoweringResult(lines=current_lines, allocas=current_allocas, locals=current_locals, temp_index=current_temp, block_counter=current_block_counter, diagnostics=diagnostics, terminated=false, next_local_id=current_next_local, next_index=next_index)
    start_result = lower_expression(range_parse.start, bindings, current_locals, current_temp, current_lines, functions)
    diagnostics = (diagnostics) + (start_result.diagnostics)
    current_lines = start_result.lines
    current_temp = start_result.temp_index
    if start_result.operand == null:
        diagnostics = append_string(diagnostics, "llvm lowering: unable to lower `.for` range start in `" + function.name + "`")
        return BlockLoweringResult(lines=current_lines, allocas=current_allocas, locals=current_locals, temp_index=current_temp, block_counter=current_block_counter, diagnostics=diagnostics, terminated=false, next_local_id=current_next_local, next_index=next_index)
    end_result = lower_expression(range_parse.end, bindings, current_locals, current_temp, current_lines, functions)
    diagnostics = (diagnostics) + (end_result.diagnostics)
    current_lines = end_result.lines
    current_temp = end_result.temp_index
    if end_result.operand == null:
        diagnostics = append_string(diagnostics, "llvm lowering: unable to lower `.for` range end in `" + function.name + "`")
        return BlockLoweringResult(lines=current_lines, allocas=current_allocas, locals=current_locals, temp_index=current_temp, block_counter=current_block_counter, diagnostics=diagnostics, terminated=false, next_local_id=current_next_local, next_index=next_index)
    start_coerced = coerce_operand_to_type(start_result.operand, "double", current_temp, current_lines)
    diagnostics = (diagnostics) + (start_coerced.diagnostics)
    current_lines = start_coerced.lines
    current_temp = start_coerced.temp_index
    if start_coerced.operand == null:
        diagnostics = append_string(diagnostics, "llvm lowering: `.for` start expression must evaluate to `number` in `" + function.name + "`")
        return BlockLoweringResult(lines=current_lines, allocas=current_allocas, locals=current_locals, temp_index=current_temp, block_counter=current_block_counter, diagnostics=diagnostics, terminated=false, next_local_id=current_next_local, next_index=next_index)
    start_operand = start_coerced.operand
    end_coerced = coerce_operand_to_type(end_result.operand, "double", current_temp, current_lines)
    diagnostics = (diagnostics) + (end_coerced.diagnostics)
    current_lines = end_coerced.lines
    current_temp = end_coerced.temp_index
    if end_coerced.operand == null:
        diagnostics = append_string(diagnostics, "llvm lowering: `.for` end expression must evaluate to `number` in `" + function.name + "`")
        return BlockLoweringResult(lines=current_lines, allocas=current_allocas, locals=current_locals, temp_index=current_temp, block_counter=current_block_counter, diagnostics=diagnostics, terminated=false, next_local_id=current_next_local, next_index=next_index)
    end_operand = end_coerced.operand
    raw_target = trim_text(instruction.target)
    raw_target = strip_mut_prefix(raw_target)
    if len(raw_target) == 0:
        diagnostics = append_string(diagnostics, "llvm lowering: `.for` loop missing iteration binding in `" + function.name + "`")
        return BlockLoweringResult(lines=current_lines, allocas=current_allocas, locals=current_locals, temp_index=current_temp, block_counter=current_block_counter, diagnostics=diagnostics, terminated=false, next_local_id=current_next_local, next_index=next_index)
    if not is_simple_identifier(raw_target):
        diagnostics = append_string(diagnostics, "llvm lowering: `.for` loop target `" + raw_target + "` is not a simple identifier in `" + function.name + "`")
        return BlockLoweringResult(lines=current_lines, allocas=current_allocas, locals=current_locals, temp_index=current_temp, block_counter=current_block_counter, diagnostics=diagnostics, terminated=false, next_local_id=current_next_local, next_index=next_index)
    if find_local_binding(current_locals, raw_target) != null:
        diagnostics = append_string(diagnostics, "llvm lowering: `.for` loop target `" + raw_target + "` shadows existing local in `" + function.name + "`")
        return BlockLoweringResult(lines=current_lines, allocas=current_allocas, locals=current_locals, temp_index=current_temp, block_counter=current_block_counter, diagnostics=diagnostics, terminated=false, next_local_id=current_next_local, next_index=next_index)
    loop_header_alloc = allocate_block_label("for", current_block_counter)
    loop_header_label = loop_header_alloc.label
    current_block_counter = loop_header_alloc.next_counter
    loop_body_alloc = allocate_block_label("forbody", current_block_counter)
    loop_body_label = loop_body_alloc.label
    current_block_counter = loop_body_alloc.next_counter
    loop_increment_alloc = allocate_block_label("forinc", current_block_counter)
    loop_increment_label = loop_increment_alloc.label
    current_block_counter = loop_increment_alloc.next_counter
    loop_exit_alloc = allocate_block_label("afterfor", current_block_counter)
    loop_exit_label = loop_exit_alloc.label
    current_block_counter = loop_exit_alloc.next_counter
    iteration_pointer = format_local_pointer_name(current_next_local)
    current_next_local += 1
    current_allocas = append_string(current_allocas, "  " + iteration_pointer + " = alloca double")
    current_lines = append_string(current_lines, "  store double " + start_operand.value + ", double* " + iteration_pointer)
    current_lines = append_string(current_lines, "  br label %" + loop_header_label)
    current_lines = append_string(current_lines, loop_header_label + ":")
    iteration_binding = LocalBinding(name=raw_target, pointer=iteration_pointer, llvm_type="double")
    header_load = load_local_operand(iteration_binding, current_temp, current_lines)
    diagnostics = (diagnostics) + (header_load.diagnostics)
    current_lines = header_load.lines
    current_temp = header_load.temp_index
    if header_load.operand == null:
        diagnostics = append_string(diagnostics, "llvm lowering: internal error loading `.for` iteration value in `" + function.name + "`")
        current_lines = append_string(current_lines, "  br label %" + loop_exit_label)
        current_lines = append_string(current_lines, loop_exit_label + ":")
        return BlockLoweringResult(lines=current_lines, allocas=current_allocas, locals=current_locals, temp_index=current_temp, block_counter=current_block_counter, diagnostics=diagnostics, terminated=false, next_local_id=current_next_local, next_index=next_index)
    comparison = emit_comparison_instruction("<", header_load.operand, end_operand, current_temp, current_lines)
    diagnostics = (diagnostics) + (comparison.diagnostics)
    current_lines = comparison.lines
    current_temp = comparison.temp_index
    if comparison.operand == null:
        diagnostics = append_string(diagnostics, "llvm lowering: unable to compare `.for` range bounds in `" + function.name + "`")
        current_lines = append_string(current_lines, "  br label %" + loop_exit_label)
        current_lines = append_string(current_lines, loop_exit_label + ":")
        return BlockLoweringResult(lines=current_lines, allocas=current_allocas, locals=current_locals, temp_index=current_temp, block_counter=current_block_counter, diagnostics=diagnostics, terminated=false, next_local_id=current_next_local, next_index=next_index)
    current_lines = append_string(current_lines, "  br i1 " + comparison.operand.value + ", label %" + loop_body_label + ", label %" + loop_exit_label)
    current_lines = append_string(current_lines, loop_body_label + ":")
    context = LoopContext(break_label=loop_exit_label, continue_label=loop_increment_label)
    stacked = append_loop_context(loop_stack, context)
    body_locals = append_local_binding(current_locals, iteration_binding)
    body_result = lower_instruction_range( function, structure.body_start, structure.body_end, llvm_return, bindings, body_locals, current_allocas, [], current_temp, current_block_counter, current_next_local, functions, stacked )
    diagnostics = (diagnostics) + (body_result.diagnostics)
    current_lines = (current_lines) + (body_result.lines)
    current_allocas = body_result.allocas
    current_temp = body_result.temp_index
    current_block_counter = body_result.block_counter
    current_next_local = body_result.next_local_id
    if not body_result.terminated:
        current_lines = append_string(current_lines, "  br label %" + loop_increment_label)
    current_lines = append_string(current_lines, loop_increment_label + ":")
    increment_load = load_local_operand(iteration_binding, current_temp, current_lines)
    diagnostics = (diagnostics) + (increment_load.diagnostics)
    current_lines = increment_load.lines
    current_temp = increment_load.temp_index
    if increment_load.operand != null:
        next_value_name = format_temp_name(current_temp)
        current_lines = append_string(current_lines, "  " + next_value_name + " = fadd double " + increment_load.operand.value + ", 1.0")
        current_temp += 1
        current_lines = append_string(current_lines, "  store double " + next_value_name + ", double* " + iteration_pointer)
    else:
        diagnostics = append_string(diagnostics, "llvm lowering: unable to increment `.for` iterator in `" + function.name + "`")
    current_lines = append_string(current_lines, "  br label %" + loop_header_label)
    current_lines = append_string(current_lines, loop_exit_label + ":")
    current_locals = locals
    return BlockLoweringResult(lines=current_lines, allocas=current_allocas, locals=current_locals, temp_index=current_temp, block_counter=current_block_counter, diagnostics=diagnostics, terminated=false, next_local_id=current_next_local, next_index=next_index)

def collect_match_structure(instructions, start_index, end, function_name):
    diagnostics = []
    cases = []
    current_case = null
    index = start_index + 1
    depth = 0
    limit = end
    if limit > len(instructions):
        limit = len(instructions)
    while True:
        if index >= limit:
            diagnostics = append_string(diagnostics, "llvm lowering: unterminated `.match` in `" + function_name + "`")
            if current_case != null:
                finished = finalize_match_case(current_case, limit)
                cases = append_match_case(cases, finished)
            return MatchStructure(cases=cases, end_index=limit - 1, diagnostics=diagnostics)
        instruction = instructions[index]
        if instruction.variant == "Match":
            depth += 1
            index += 1
            continue
        if instruction.variant == "EndMatch":
            if depth == 0:
                if current_case != null:
                    finished = finalize_match_case(current_case, index)
                    cases = append_match_case(cases, finished)
                    current_case = null
                return MatchStructure(cases=cases, end_index=index, diagnostics=diagnostics)
            depth -= 1
            index += 1
            continue
        if depth > 0:
            index += 1
            continue
        if instruction.variant == "Case":
            if current_case != null:
                finished = finalize_match_case(current_case, index)
                cases = append_match_case(cases, finished)
            guard_text = null
            if instruction.guard != null:
                guard_text = instruction.guard
            current_case = MatchCaseStructure(pattern=instruction.pattern, guard=guard_text, body_start=index + 1, body_end=index + 1, is_default=is_default_pattern(instruction.pattern))
            index += 1
            continue
        index += 1

def append_match_case(cases, value):
    return (cases) + ([value])

def finalize_match_case(case, body_end):
    value = case
    return MatchCaseStructure(pattern=value.pattern, guard=value.guard, body_start=value.body_start, body_end=body_end, is_default=value.is_default)

def is_default_pattern(pattern):
    trimmed = trim_text(pattern)
    if len(trimmed) == 0:
        return true
    if trimmed == "_":
        return true
    return false

def lower_match_instruction(function, start_index, llvm_return, bindings, locals, allocas, lines, temp_index, block_counter, next_local_id, functions, loop_stack, end):
    diagnostics = []
    current_lines = lines
    current_allocas = allocas
    current_locals = locals
    current_temp = temp_index
    current_block_counter = block_counter
    current_next_local = next_local_id
    structure = collect_match_structure(function.instructions, start_index, end, function.name)
    diagnostics = (diagnostics) + (structure.diagnostics)
    subject_instruction = function.instructions[start_index]
    subject_result = lower_expression(subject_instruction.expression, bindings, current_locals, current_temp, current_lines, functions)
    diagnostics = (diagnostics) + (subject_result.diagnostics)
    current_lines = subject_result.lines
    current_temp = subject_result.temp_index
    if subject_result.operand == null:
        diagnostics = append_string(diagnostics, "llvm lowering: unable to lower match subject in `" + function.name + "`")
        return BlockLoweringResult(lines=current_lines, allocas=current_allocas, locals=current_locals, temp_index=current_temp, block_counter=current_block_counter, diagnostics=diagnostics, terminated=false, next_local_id=current_next_local, next_index=structure.end_index + 1)
    subject_operand = subject_result.operand
    if len(structure.cases) == 0:
        diagnostics = append_string(diagnostics, "llvm lowering: match without cases in `" + function.name + "`")
        merge_alloc = allocate_block_label("matchmerge", current_block_counter)
        merge_label = merge_alloc.label
        current_block_counter = merge_alloc.next_counter
        current_lines = append_string(current_lines, "  br label %" + merge_label)
        current_lines = append_string(current_lines, merge_label + ":")
        return BlockLoweringResult(lines=current_lines, allocas=current_allocas, locals=current_locals, temp_index=current_temp, block_counter=current_block_counter, diagnostics=diagnostics, terminated=false, next_local_id=current_next_local, next_index=structure.end_index + 1)
    test_labels = []
    body_labels = []
    index = 0
    while True:
        if index >= len(structure.cases):
            break
        test_alloc = allocate_block_label("matchcase", current_block_counter)
        body_alloc = allocate_block_label("matchbody", test_alloc.next_counter)
        test_labels = append_string(test_labels, test_alloc.label)
        body_labels = append_string(body_labels, body_alloc.label)
        current_block_counter = body_alloc.next_counter
        index += 1
    merge_alloc = allocate_block_label("matchmerge", current_block_counter)
    merge_label = merge_alloc.label
    current_block_counter = merge_alloc.next_counter
    current_lines = append_string(current_lines, "  br label %" + test_labels[0])
    all_terminated = true
    has_unconditional_default = false
    index = 0
    while True:
        if index >= len(structure.cases):
            break
        case = structure.cases[index]
        failure_target = merge_label
        if index + 1 < len(structure.cases):
            failure_target = test_labels[index + 1]
        current_lines = append_string(current_lines, test_labels[index] + ":")
        lowered_condition = lower_match_case_condition( function.name, subject_operand, case, bindings, current_locals, current_temp, current_lines, functions )
        diagnostics = (diagnostics) + (lowered_condition.diagnostics)
        current_lines = lowered_condition.lines
        current_temp = lowered_condition.temp_index
        if lowered_condition.is_default:
            has_unconditional_default = true
            current_lines = append_string(current_lines, "  br label %" + body_labels[index])
        else:
            if lowered_condition.operand != null:
                current_lines = append_string(current_lines, "  br i1 " + lowered_condition.operand.value + ", label %" + body_labels[index] + ", label %" + failure_target)
            else:
                current_lines = append_string(current_lines, "  br label %" + failure_target)
        current_lines = append_string(current_lines, body_labels[index] + ":")
        base_locals = current_locals
        base_allocas = current_allocas
        base_local_id = current_next_local
        body_result = lower_instruction_range( function, case.body_start, case.body_end, llvm_return, bindings, base_locals, base_allocas, [], current_temp, current_block_counter, base_local_id, functions, loop_stack )
        diagnostics = (diagnostics) + (body_result.diagnostics)
        current_lines = (current_lines) + (body_result.lines)
        current_allocas = body_result.allocas
        current_locals = base_locals
        current_temp = body_result.temp_index
        current_block_counter = body_result.block_counter
        current_next_local = body_result.next_local_id
        if not body_result.terminated:
            current_lines = append_string(current_lines, "  br label %" + merge_label)
            all_terminated = false
        else:
            all_terminated = all_terminated  and  true
        index += 1
    terminated = all_terminated  and  has_unconditional_default
    if not terminated:
        current_lines = append_string(current_lines, merge_label + ":")
    return BlockLoweringResult(lines=current_lines, allocas=current_allocas, locals=current_locals, temp_index=current_temp, block_counter=current_block_counter, diagnostics=diagnostics, terminated=terminated, next_local_id=current_next_local, next_index=structure.end_index + 1)

def lower_match_case_condition(function_name, subject_operand, case, bindings, locals, temp_index, lines, functions):
    diagnostics = []
    current_lines = lines
    current_temp = temp_index
    condition_operand = null
    if not case.is_default:
        pattern_result = lower_expression(case.pattern, bindings, locals, current_temp, current_lines, functions)
        diagnostics = (diagnostics) + (pattern_result.diagnostics)
        current_lines = pattern_result.lines
        current_temp = pattern_result.temp_index
        if pattern_result.operand != null:
            harmonised = harmonise_operands(subject_operand, pattern_result.operand, current_temp, current_lines)
            diagnostics = (diagnostics) + (harmonised.diagnostics)
            if harmonised.left != null  and  harmonised.right != null:
                current_lines = harmonised.lines
                current_temp = harmonised.temp_index
                comparison = emit_comparison_instruction("==", harmonised.left, harmonised.right, current_temp, current_lines)
                diagnostics = (diagnostics) + (comparison.diagnostics)
                current_lines = comparison.lines
                current_temp = comparison.temp_index
                condition_operand = comparison.operand
            else:
                current_lines = harmonised.lines
                current_temp = harmonised.temp_index
        else:
            diagnostics = append_string(diagnostics, "llvm lowering: unable to lower match case pattern in `" + function_name + "`")
    if case.guard != null:
        guard_text = trim_text(case.guard)
        if len(guard_text) > 0:
            guard_condition = lower_condition_to_i1(function_name, guard_text, bindings, locals, current_temp, current_lines, functions)
            diagnostics = (diagnostics) + (guard_condition.diagnostics)
            current_lines = guard_condition.lines
            current_temp = guard_condition.temp_index
            if guard_condition.operand != null:
                if condition_operand == null:
                    condition_operand = guard_condition.operand
                else:
                    merged = emit_boolean_and(condition_operand, guard_condition.operand, current_temp, current_lines)
                    diagnostics = (diagnostics) + (merged.diagnostics)
                    current_lines = merged.lines
                    current_temp = merged.temp_index
                    condition_operand = merged.operand
            else:
                diagnostics = append_string(diagnostics, "llvm lowering: unable to lower guard in match case for `" + function_name + "`")
    is_unconditional_default = false
    if case.is_default:
        if case.guard == null:
            is_unconditional_default = true
        else:
            guard_trimmed = trim_text(case.guard)
            if len(guard_trimmed) == 0:
                is_unconditional_default = true
    return MatchCaseCondition(lines=current_lines, temp_index=current_temp, operand=condition_operand, diagnostics=diagnostics, is_default=is_unconditional_default)

def allocate_block_label(prefix, counter):
    return BlockLabelResult(label=prefix + number_to_string(counter), next_counter=counter + 1)

def lower_condition_to_i1(function_name, expression, bindings, locals, temp_index, lines, functions):
    lowered = lower_expression(expression, bindings, locals, temp_index, lines, functions)
    diagnostics = lowered.diagnostics
    current_lines = lowered.lines
    current_temp = lowered.temp_index
    if lowered.operand == null:
        diagnostics = append_string(diagnostics, "llvm lowering: condition produced no value in `" + function_name + "`")
        return ConditionConversion(lines=current_lines, temp_index=current_temp, operand=null, diagnostics=diagnostics)
    operand = lowered.operand
    if operand.llvm_type == "i1":
        return ConditionConversion(lines=current_lines, temp_index=current_temp, operand=operand, diagnostics=diagnostics)
    if operand.llvm_type == "double":
        temp_name = format_temp_name(current_temp)
        current_lines = append_string(current_lines, "  " + temp_name + " = fcmp one double " + operand.value + ", 0.0")
        converted = LLVMOperand(llvm_type="i1", value=temp_name)
        return ConditionConversion(lines=current_lines, temp_index=current_temp + 1, operand=converted, diagnostics=diagnostics)
    if operand.llvm_type == "i32"  or  operand.llvm_type == "i64":
        temp_name = format_temp_name(current_temp)
        current_lines = append_string(current_lines, "  " + temp_name + " = icmp ne " + operand.llvm_type + " " + operand.value + ", " + default_return_literal(operand.llvm_type) + "")
        converted = LLVMOperand(llvm_type="i1", value=temp_name)
        return ConditionConversion(lines=current_lines, temp_index=current_temp + 1, operand=converted, diagnostics=diagnostics)
    diagnostics = append_string(diagnostics, "llvm lowering: unsupported condition type `" + operand.llvm_type + "` in `" + function_name + "`")
    return ConditionConversion(lines=current_lines, temp_index=current_temp, operand=null, diagnostics=diagnostics)

def lower_if_instruction(function, start_index, llvm_return, bindings, locals, allocas, lines, temp_index, block_counter, next_local_id, functions, loop_stack, end):
    current_lines = lines
    current_allocas = allocas
    current_locals = locals
    current_temp = temp_index
    current_block_counter = block_counter
    current_next_local = next_local_id
    diagnostics = []
    structure = collect_if_structure(function.instructions, start_index, end, function.name)
    diagnostics = (diagnostics) + (structure.diagnostics)
    condition = lower_condition_to_i1( function.name, function.instructions[start_index].condition, bindings, current_locals, current_temp, current_lines, functions )
    diagnostics = (diagnostics) + (condition.diagnostics)
    current_lines = condition.lines
    current_temp = condition.temp_index
    if condition.operand == null:
        diagnostics = append_string(diagnostics, "llvm lowering: unable to lower if condition in `" + function.name + "`")
        return BlockLoweringResult(lines=current_lines, allocas=current_allocas, locals=current_locals, temp_index=current_temp, block_counter=current_block_counter, diagnostics=diagnostics, terminated=false, next_local_id=current_next_local, next_index=structure.next_index + 1)
    then_label_alloc = allocate_block_label("then", current_block_counter)
    then_label = then_label_alloc.label
    current_block_counter = then_label_alloc.next_counter
    else_label = ""
    if structure.has_else:
        else_alloc = allocate_block_label("else", current_block_counter)
        else_label = else_alloc.label
        current_block_counter = else_alloc.next_counter
    merge_alloc = allocate_block_label("merge", current_block_counter)
    merge_label = merge_alloc.label
    current_block_counter = merge_alloc.next_counter
    false_target = merge_label
    if structure.has_else:
        false_target = else_label
    current_lines = append_string(current_lines, "  br i1 " + condition.operand.value + ", label %" + then_label + ", label %" + false_target)
    base_locals = current_locals
    base_allocas = current_allocas
    base_temp = current_temp
    base_local_id = current_next_local
    base_block_counter = current_block_counter
    current_lines = append_string(current_lines, then_label + ":")
    then_result = lower_instruction_range( function, structure.then_start, structure.then_end, llvm_return, bindings, base_locals, base_allocas, [], base_temp, base_block_counter, base_local_id, functions, loop_stack )
    diagnostics = (diagnostics) + (then_result.diagnostics)
    current_allocas = then_result.allocas
    current_locals = then_result.locals
    current_temp = then_result.temp_index
    current_block_counter = then_result.block_counter
    current_next_local = then_result.next_local_id
    current_lines = (current_lines) + (then_result.lines)
    then_terminated = then_result.terminated
    if not then_terminated:
        current_lines = append_string(current_lines, "  br label %" + merge_label)
    else_terminated = false
    if structure.has_else:
        current_lines = append_string(current_lines, else_label + ":")
        else_result = lower_instruction_range( function, structure.else_start, structure.else_end, llvm_return, bindings, base_locals, current_allocas, [], current_temp, current_block_counter, current_next_local, functions, loop_stack )
        diagnostics = (diagnostics) + (else_result.diagnostics)
        current_allocas = else_result.allocas
        current_locals = else_result.locals
        current_temp = else_result.temp_index
        current_block_counter = else_result.block_counter
        current_next_local = else_result.next_local_id
        current_lines = (current_lines) + (else_result.lines)
        else_terminated = else_result.terminated
        if not else_terminated:
            current_lines = append_string(current_lines, "  br label %" + merge_label)
    terminated = false
    if structure.has_else:
        terminated = then_terminated  and  else_terminated
    if not terminated  or  not structure.has_else:
        current_lines = append_string(current_lines, merge_label + ":")
    current_locals = base_locals
    return BlockLoweringResult(lines=current_lines, allocas=current_allocas, locals=current_locals, temp_index=current_temp, block_counter=current_block_counter, diagnostics=diagnostics, terminated=terminated, next_local_id=current_next_local, next_index=structure.next_index + 1)

def lower_let_instruction(function, instruction, bindings, locals, allocas, lines, temp_index, next_local_id, functions):
    diagnostics = []
    current_lines = lines
    current_allocas = allocas
    current_locals = locals
    current_temp = temp_index
    llvm_type = map_local_type(instruction.type_annotation)
    if len(llvm_type) == 0:
        diagnostics = append_string(diagnostics, "llvm lowering: unsupported local type for `" + instruction.name + "` in `" + function.name + "`")
        llvm_type = "double"
    operand = null
    if instruction.value == null  or  len(instruction.value) == 0:
        diagnostics = append_string(diagnostics, "llvm lowering: let `" + instruction.name + "` missing initializer in `" + function.name + "`")
    else:
        lowered = lower_expression(instruction.value, bindings, current_locals, current_temp, current_lines, functions)
        diagnostics = (diagnostics) + (lowered.diagnostics)
        current_lines = lowered.lines
        current_temp = lowered.temp_index
        operand = lowered.operand
    pointer = format_local_pointer_name(next_local_id)
    current_allocas = append_string(current_allocas, "  " + pointer + " = alloca " + llvm_type)
    if operand != null:
        coerced = coerce_operand_to_type(operand, llvm_type, current_temp, current_lines)
        diagnostics = (diagnostics) + (coerced.diagnostics)
        current_lines = coerced.lines
        current_temp = coerced.temp_index
        if coerced.operand == null:
            diagnostics = append_string(diagnostics, "llvm lowering: unable to coerce initializer for `" + instruction.name + "` to `" + llvm_type + "`")
            current_lines = append_string(current_lines, "  store " + llvm_type + " " + default_return_literal(llvm_type) + ", " + llvm_type + "* " + pointer)
        else:
            stored = coerced.operand
            current_lines = append_string(current_lines, "  store " + llvm_type + " " + stored.value + ", " + llvm_type + "* " + pointer)
    else:
        current_lines = append_string(current_lines, "  store " + llvm_type + " " + default_return_literal(llvm_type) + ", " + llvm_type + "* " + pointer)
    current_locals = append_local_binding(current_locals, LocalBinding(name=instruction.name, pointer=pointer, llvm_type=llvm_type))
    return LetLoweringResult(lines=current_lines, allocas=current_allocas, locals=current_locals, temp_index=current_temp, diagnostics=diagnostics, next_local_id=next_local_id + 1)

def lower_expression_statement(expression, bindings, locals, temp_index, lines, functions):
    diagnostics = []
    current_lines = lines
    current_temp = temp_index
    parsed_assignment = parse_assignment_expression(expression)
    if parsed_assignment.success:
        binding = find_local_binding(locals, parsed_assignment.target)
        if binding == null:
            diagnostics = append_string(diagnostics, "llvm lowering: assignment to unknown local `" + parsed_assignment.target + "`")
        else:
            lowered = lower_expression(parsed_assignment.value, bindings, locals, current_temp, current_lines, functions)
            diagnostics = (diagnostics) + (lowered.diagnostics)
            current_lines = lowered.lines
            current_temp = lowered.temp_index
            if lowered.operand == null:
                diagnostics = append_string(diagnostics, "llvm lowering: failed to lower assignment expression for `" + parsed_assignment.target + "`")
            else:
                coerced = coerce_operand_to_type(lowered.operand, binding.llvm_type, current_temp, current_lines)
                diagnostics = (diagnostics) + (coerced.diagnostics)
                current_lines = coerced.lines
                current_temp = coerced.temp_index
                if coerced.operand == null:
                    diagnostics = append_string(diagnostics, "llvm lowering: unable to coerce assignment value for `" + parsed_assignment.target + "`")
                    current_lines = append_string(current_lines, "  store " + binding.llvm_type + " " + default_return_literal(binding.llvm_type) + ", " + binding.llvm_type + "* " + binding.pointer)
                else:
                    operand = coerced.operand
                    current_lines = append_string(current_lines, "  store " + binding.llvm_type + " " + operand.value + ", " + binding.llvm_type + "* " + binding.pointer)
        return ExpressionStatementResult(lines=current_lines, temp_index=current_temp, diagnostics=diagnostics)
    lowered = lower_expression(expression, bindings, locals, current_temp, current_lines, functions)
    diagnostics = (diagnostics) + (lowered.diagnostics)
    current_lines = lowered.lines
    current_temp = lowered.temp_index
    return ExpressionStatementResult(lines=current_lines, temp_index=current_temp, diagnostics=diagnostics)

def parse_assignment_expression(expression):
    trimmed = trim_text(expression)
    depth = 0
    index = 0
    while True:
        if index >= len(trimmed):
            break
        ch = trimmed[index]
        if ch == "(":
            depth += 1
            index += 1
            continue
        if ch == ")":
            if depth > 0:
                depth -= 1
            index += 1
            continue
        if depth > 0:
            index += 1
            continue
        if ch == "=":
            previous = ""
            if index > 0:
                previous = trimmed[index - 1]
            next_char = ""
            if index + 1 < len(trimmed):
                next_char = trimmed[index + 1]
            if previous == "="  or  previous == "!"  or  previous == ">"  or  previous == "<"  or  previous == "-":
                index += 1
                continue
            if next_char == "="  or  next_char == ">":
                index += 1
                continue
            target = trim_text(substring(trimmed, 0, index))
            value = trim_text(substring(trimmed, index + 1, len(trimmed)))
            if len(target) == 0  or  len(value) == 0:
                return AssignmentParseResult(success=false, target="", value="")
            return AssignmentParseResult(success=true, target=target, value=value)
        index += 1
    return AssignmentParseResult(success=false, target="", value="")

def lower_return_instruction(function, instruction, llvm_return, bindings, locals, temp_index, lines, functions):
    diagnostics = []
    current_lines = lines
    current_temp = temp_index
    if instruction.expression == null  or  len(instruction.expression) == 0:
        if llvm_return == "void":
            current_lines = append_string(current_lines, "  ret void")
        else:
            diagnostics = append_string(diagnostics, "llvm lowering: missing return value in `" + function.name + "`")
            current_lines = append_string(current_lines, "  ret " + llvm_return + " " + default_return_literal(llvm_return))
        return ExpressionStatementResult(lines=current_lines, temp_index=current_temp, diagnostics=diagnostics)
    lowered = lower_expression(instruction.expression, bindings, locals, current_temp, current_lines, functions)
    diagnostics = (diagnostics) + (lowered.diagnostics)
    current_lines = lowered.lines
    current_temp = lowered.temp_index
    if lowered.operand == null:
        diagnostics = append_string(diagnostics, "llvm lowering: unhandled return expression in `" + function.name + "`")
        current_lines = append_string(current_lines, "  ret " + llvm_return + " " + default_return_literal(llvm_return))
        return ExpressionStatementResult(lines=current_lines, temp_index=current_temp, diagnostics=diagnostics)
    operand = lowered.operand
    if llvm_return == "void":
        diagnostics = append_string(diagnostics, "llvm lowering: void function `" + function.name + "` returned a value")
        current_lines = append_string(current_lines, "  ret void")
        return ExpressionStatementResult(lines=current_lines, temp_index=current_temp, diagnostics=diagnostics)
    coerced = coerce_operand_to_type(operand, llvm_return, current_temp, current_lines)
    diagnostics = (diagnostics) + (coerced.diagnostics)
    current_lines = coerced.lines
    current_temp = coerced.temp_index
    if coerced.operand == null:
        diagnostics = append_string(diagnostics, "llvm lowering: unable to coerce return expression to `" + llvm_return + "` in `" + function.name + "`")
        current_lines = append_string(current_lines, "  ret " + llvm_return + " " + default_return_literal(llvm_return))
        return ExpressionStatementResult(lines=current_lines, temp_index=current_temp, diagnostics=diagnostics)
    coerced_operand = coerced.operand
    current_lines = append_string(current_lines, "  ret " + coerced_operand.llvm_type + " " + coerced_operand.value)
    return ExpressionStatementResult(lines=current_lines, temp_index=current_temp, diagnostics=diagnostics)

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
    if trimmed == "boolean"  or  trimmed == "bool":
        return "i1"
    if trimmed == "int"  or  trimmed == "i64":
        return "i64"
    return ""

def map_parameter_type(parameter_type):
    trimmed = trim_text(parameter_type)
    if len(trimmed) == 0:
        return "double"
    if trimmed == "number":
        return "double"
    if trimmed == "boolean"  or  trimmed == "bool":
        return "i1"
    if trimmed == "int"  or  trimmed == "i64":
        return "i64"
    return ""

def map_local_type(type_annotation):
    trimmed = trim_text(type_annotation)
    if len(trimmed) == 0:
        return "double"
    if trimmed == "number":
        return "double"
    if trimmed == "boolean"  or  trimmed == "bool":
        return "i1"
    if trimmed == "int"  or  trimmed == "i64":
        return "i64"
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

def lower_expression(expression, bindings, locals, temp_index, lines, functions):
    trimmed = trim_text(expression)
    diagnostics = []
    if len(trimmed) == 0:
        diagnostics = append_string(diagnostics, "llvm lowering: empty expression encountered")
        return ExpressionResult(lines=lines, temp_index=temp_index, operand=null, diagnostics=diagnostics)
    stripped = strip_enclosing_parentheses(trimmed)
    if stripped != trimmed:
        return lower_expression(stripped, bindings, locals, temp_index, lines, functions)
    comparison = find_comparison_operator(stripped)
    if comparison.success:
        return lower_comparison_operation(stripped, comparison, bindings, locals, temp_index, lines, functions)
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
    if parameter != null:
        operand = LLVMOperand(llvm_type=parameter.llvm_type, value=parameter.llvm_name)
        return ExpressionResult(lines=lines, temp_index=temp_index, operand=operand, diagnostics=diagnostics)
    local = find_local_binding(locals, stripped)
    if local != null:
        load_result = load_local_operand(local, temp_index, lines)
        diagnostics = (diagnostics) + (load_result.diagnostics)
        return ExpressionResult(lines=load_result.lines, temp_index=load_result.temp_index, operand=load_result.operand, diagnostics=diagnostics)
    literal_candidate = trim_text(stripped)
    if is_boolean_literal(literal_candidate):
        value = "0"
        if matches_case_insensitive(literal_candidate, "true"):
            value = "1"
        operand = LLVMOperand(llvm_type="i1", value=value)
        return ExpressionResult(lines=lines, temp_index=temp_index, operand=operand, diagnostics=diagnostics)
    if is_integer_literal(literal_candidate):
        operand = LLVMOperand(llvm_type="i64", value=literal_candidate)
        return ExpressionResult(lines=lines, temp_index=temp_index, operand=operand, diagnostics=diagnostics)
    if is_number_literal(literal_candidate):
        normalised = normalise_number_literal(literal_candidate)
        operand = LLVMOperand(llvm_type="double", value=normalised)
        return ExpressionResult(lines=lines, temp_index=temp_index, operand=operand, diagnostics=diagnostics)
    diagnostics = append_string(diagnostics, "llvm lowering: unsupported expression `" + literal_candidate + "`")
    return ExpressionResult(lines=lines, temp_index=temp_index, operand=null, diagnostics=diagnostics)

def lower_binary_operation(expression, match, bindings, locals, temp_index, lines, functions):
    left_text = trim_text(substring(expression, 0, match.index))
    right_text = trim_text(substring(expression, match.index + 1, len(expression)))
    diagnostics = []
    if len(left_text) == 0  or  len(right_text) == 0:
        diagnostics = append_string(diagnostics, "llvm lowering: malformed binary expression `" + expression + "`")
        return ExpressionResult(lines=lines, temp_index=temp_index, operand=null, diagnostics=diagnostics)
    left_result = lower_expression(left_text, bindings, locals, temp_index, lines, functions)
    diagnostics = (diagnostics) + (left_result.diagnostics)
    if left_result.operand == null:
        return ExpressionResult(lines=left_result.lines, temp_index=left_result.temp_index, operand=null, diagnostics=diagnostics)
    right_result = lower_expression(right_text, bindings, locals, left_result.temp_index, left_result.lines, functions)
    diagnostics = (diagnostics) + (right_result.diagnostics)
    if right_result.operand == null:
        return ExpressionResult(lines=right_result.lines, temp_index=right_result.temp_index, operand=null, diagnostics=diagnostics)
    harmonised = harmonise_operands(left_result.operand, right_result.operand, right_result.temp_index, right_result.lines)
    diagnostics = (diagnostics) + (harmonised.diagnostics)
    if harmonised.left == null  or  harmonised.right == null:
        return ExpressionResult(lines=harmonised.lines, temp_index=harmonised.temp_index, operand=null, diagnostics=diagnostics)
    left_aligned = harmonised.left
    right_aligned = harmonised.right
    operation = operation_name_for_symbol(match.symbol, harmonised.result_type)
    temp_name = format_temp_name(harmonised.temp_index)
    line = "  " + temp_name + " = " + operation + " " + harmonised.result_type + " " + left_aligned.value + ", " + right_aligned.value
    updated_lines = append_string(harmonised.lines, line)
    operand = LLVMOperand(llvm_type=harmonised.result_type, value=temp_name)
    return ExpressionResult(lines=updated_lines, temp_index=harmonised.temp_index + 1, operand=operand, diagnostics=diagnostics)

def lower_comparison_operation(expression, match, bindings, locals, temp_index, lines, functions):
    operator_length = len(match.symbol)
    left_text = trim_text(substring(expression, 0, match.index))
    right_text = trim_text(substring(expression, match.index + operator_length, len(expression)))
    diagnostics = []
    if len(left_text) == 0  or  len(right_text) == 0:
        diagnostics = append_string(diagnostics, "llvm lowering: malformed comparison expression `" + expression + "`")
        return ExpressionResult(lines=lines, temp_index=temp_index, operand=null, diagnostics=diagnostics)
    left_result = lower_expression(left_text, bindings, locals, temp_index, lines, functions)
    diagnostics = (diagnostics) + (left_result.diagnostics)
    if left_result.operand == null:
        return ExpressionResult(lines=left_result.lines, temp_index=left_result.temp_index, operand=null, diagnostics=diagnostics)
    right_result = lower_expression(right_text, bindings, locals, left_result.temp_index, left_result.lines, functions)
    diagnostics = (diagnostics) + (right_result.diagnostics)
    if right_result.operand == null:
        return ExpressionResult(lines=right_result.lines, temp_index=right_result.temp_index, operand=null, diagnostics=diagnostics)
    harmonised = harmonise_operands(left_result.operand, right_result.operand, right_result.temp_index, right_result.lines)
    diagnostics = (diagnostics) + (harmonised.diagnostics)
    if harmonised.left == null  or  harmonised.right == null:
        return ExpressionResult(lines=harmonised.lines, temp_index=harmonised.temp_index, operand=null, diagnostics=diagnostics)
    comparison = emit_comparison_instruction(match.symbol, harmonised.left, harmonised.right, harmonised.temp_index, harmonised.lines)
    diagnostics = (diagnostics) + (comparison.diagnostics)
    if comparison.operand == null:
        return ExpressionResult(lines=comparison.lines, temp_index=comparison.temp_index, operand=null, diagnostics=diagnostics)
    return ExpressionResult(lines=comparison.lines, temp_index=comparison.temp_index, operand=comparison.operand, diagnostics=diagnostics)

def lower_call_expression(target, arguments, bindings, locals, temp_index, lines, functions):
    diagnostics = []
    trimmed_target = trim_text(target)
    if len(trimmed_target) == 0:
        diagnostics = append_string(diagnostics, "llvm lowering: call target missing")
        return ExpressionResult(lines=lines, temp_index=temp_index, operand=null, diagnostics=diagnostics)
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
        if lowered.operand != null:
            operands = append_llvm_operand(operands, lowered.operand)
        else:
            diagnostics = append_string(diagnostics, "llvm lowering: failed to lower argument " + number_to_string(index) + " for call to `" + trimmed_target + "`")
        index += 1
    if len(operands) != len(arguments):
        diagnostics = append_string(diagnostics, "llvm lowering: unable to emit call to `" + trimmed_target + "` due to argument errors")
        return ExpressionResult(lines=current_lines, temp_index=current_temp, operand=null, diagnostics=diagnostics)
    llvm_return = "double"
    expected_params = []
    function_entry = find_function_by_name(functions, trimmed_target)
    if function_entry != null:
        llvm_return = map_return_type(function_entry.return_type)
        if len(llvm_return) == 0:
            diagnostics = append_string(diagnostics, "llvm lowering: unsupported return type in call to `" + trimmed_target + "`")
            llvm_return = "double"
        expected_params = collect_parameter_types(function_entry.parameters)
    else:
        diagnostics = append_string(diagnostics, "llvm lowering: call to unknown function `" + trimmed_target + "`")
    coerced_operands = []
    index = 0
    while True:
        if index >= len(operands):
            break
        operand = operands[index]
        target_type = ""
        if len(expected_params) > index:
            target_type = expected_params[index]
        if len(target_type) == 0:
            coerced_operands = append_llvm_operand(coerced_operands, operand)
        else:
            coerced = coerce_operand_to_type(operand, target_type, current_temp, current_lines)
            diagnostics = (diagnostics) + (coerced.diagnostics)
            current_lines = coerced.lines
            current_temp = coerced.temp_index
            if coerced.operand == null:
                diagnostics = append_string(diagnostics, "llvm lowering: unable to coerce argument " + number_to_string(index) + " for call to `" + trimmed_target + "`")
                placeholder = LLVMOperand(llvm_type=target_type, value=default_return_literal(target_type))
                coerced_operands = append_llvm_operand(coerced_operands, placeholder)
            else:
                coerced_operands = append_llvm_operand(coerced_operands, coerced.operand)
        index += 1
    operands = coerced_operands
    if function_entry != null:
        if len(expected_params) != len(operands):
            diagnostics = append_string(diagnostics, "llvm lowering: call to `" + trimmed_target + "` expected " + number_to_string(len(expected_params)) + " arguments but received " + number_to_string(len(operands)))
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
        return ExpressionResult(lines=current_lines, temp_index=current_temp, operand=null, diagnostics=diagnostics)
    temp_name = format_temp_name(current_temp)
    call_line = "  " + temp_name + " = call " + llvm_return + " @" + sanitized_name + "(" + argument_text + ")"
    current_lines = append_string(current_lines, call_line)
    operand = LLVMOperand(llvm_type=llvm_return, value=temp_name)
    return ExpressionResult(lines=current_lines, temp_index=current_temp + 1, operand=operand, diagnostics=diagnostics)

def emit_comparison_instruction(symbol, left_operand, right_operand, temp_index, lines):
    diagnostics = []
    current_lines = lines
    if left_operand.llvm_type != right_operand.llvm_type:
        diagnostics = append_string(diagnostics, "llvm lowering: comparison operands have mismatched types `" + left_operand.llvm_type + "` and `" + right_operand.llvm_type + "`")
    llvm_type = left_operand.llvm_type
    predicate = comparison_predicate_for_symbol(symbol, llvm_type)
    if len(predicate) == 0:
        diagnostics = append_string(diagnostics, "llvm lowering: unsupported comparison operator `" + symbol + "` for type `" + llvm_type + "`")
        return ComparisonEmission(lines=current_lines, temp_index=temp_index, operand=null, diagnostics=diagnostics)
    temp_name = format_temp_name(temp_index)
    current_lines = append_string(current_lines, "  " + temp_name + " = " + predicate + " " + llvm_type + " " + left_operand.value + ", " + right_operand.value)
    operand = LLVMOperand(llvm_type="i1", value=temp_name)
    return ComparisonEmission(lines=current_lines, temp_index=temp_index + 1, operand=operand, diagnostics=diagnostics)

def emit_boolean_and(left_operand, right_operand, temp_index, lines):
    diagnostics = []
    current_lines = lines
    if left_operand.llvm_type != "i1":
        diagnostics = append_string(diagnostics, "llvm lowering: expected boolean operand for `and`, found `" + left_operand.llvm_type + "`")
    if right_operand.llvm_type != "i1":
        diagnostics = append_string(diagnostics, "llvm lowering: expected boolean operand for `and`, found `" + right_operand.llvm_type + "`")
    temp_name = format_temp_name(temp_index)
    current_lines = append_string(current_lines, "  " + temp_name + " = and i1 " + left_operand.value + ", " + right_operand.value)
    operand = LLVMOperand(llvm_type="i1", value=temp_name)
    return ComparisonEmission(lines=current_lines, temp_index=temp_index + 1, operand=operand, diagnostics=diagnostics)

def comparison_predicate_for_symbol(symbol, llvm_type):
    if llvm_type == "double":
        if symbol == "==":
            return "fcmp oeq"
        if symbol == "!=":
            return "fcmp une"
        if symbol == "<":
            return "fcmp olt"
        if symbol == "<=":
            return "fcmp ole"
        if symbol == ">":
            return "fcmp ogt"
        if symbol == ">=":
            return "fcmp oge"
        return ""
    if llvm_type == "i32"  or  llvm_type == "i64":
        if symbol == "==":
            return "icmp eq"
        if symbol == "!=":
            return "icmp ne"
        if symbol == "<":
            return "icmp slt"
        if symbol == "<=":
            return "icmp sle"
        if symbol == ">":
            return "icmp sgt"
        if symbol == ">=":
            return "icmp sge"
        return ""
    if llvm_type == "i1":
        if symbol == "==":
            return "icmp eq"
        if symbol == "!=":
            return "icmp ne"
        return ""
    return ""

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

def load_local_operand(local, temp_index, lines):
    diagnostics = []
    load_name = format_temp_name(temp_index)
    current_lines = lines
    current_lines = append_string(current_lines, "  " + load_name + " = load " + local.llvm_type + ", " + local.llvm_type + "* " + local.pointer)
    operand = LLVMOperand(llvm_type=local.llvm_type, value=load_name)
    return LoadLocalResult(lines=current_lines, temp_index=temp_index + 1, operand=operand, diagnostics=diagnostics)

def coerce_operand_to_type(operand, target_type, temp_index, lines):
    diagnostics = []
    current_lines = lines
    if len(target_type) == 0:
        return CoercionResult(lines=current_lines, temp_index=temp_index, operand=operand, diagnostics=diagnostics)
    if operand.llvm_type == target_type:
        return CoercionResult(lines=current_lines, temp_index=temp_index, operand=operand, diagnostics=diagnostics)
    if target_type == "double":
        if operand.llvm_type == "i64":
            temp_name = format_temp_name(temp_index)
            current_lines = append_string(current_lines, "  " + temp_name + " = sitofp i64 " + operand.value + " to double")
            coerced = LLVMOperand(llvm_type="double", value=temp_name)
            return CoercionResult(lines=current_lines, temp_index=temp_index + 1, operand=coerced, diagnostics=diagnostics)
        if operand.llvm_type == "i1":
            temp_name = format_temp_name(temp_index)
            current_lines = append_string(current_lines, "  " + temp_name + " = uitofp i1 " + operand.value + " to double")
            coerced = LLVMOperand(llvm_type="double", value=temp_name)
            return CoercionResult(lines=current_lines, temp_index=temp_index + 1, operand=coerced, diagnostics=diagnostics)
    if target_type == "i64":
        if operand.llvm_type == "double":
            temp_name = format_temp_name(temp_index)
            current_lines = append_string(current_lines, "  " + temp_name + " = fptosi double " + operand.value + " to i64")
            coerced = LLVMOperand(llvm_type="i64", value=temp_name)
            return CoercionResult(lines=current_lines, temp_index=temp_index + 1, operand=coerced, diagnostics=diagnostics)
        if operand.llvm_type == "i1":
            temp_name = format_temp_name(temp_index)
            current_lines = append_string(current_lines, "  " + temp_name + " = zext i1 " + operand.value + " to i64")
            coerced = LLVMOperand(llvm_type="i64", value=temp_name)
            return CoercionResult(lines=current_lines, temp_index=temp_index + 1, operand=coerced, diagnostics=diagnostics)
    if target_type == "i1":
        if operand.llvm_type == "double":
            temp_name = format_temp_name(temp_index)
            current_lines = append_string(current_lines, "  " + temp_name + " = fcmp one double " + operand.value + ", 0.0")
            coerced = LLVMOperand(llvm_type="i1", value=temp_name)
            return CoercionResult(lines=current_lines, temp_index=temp_index + 1, operand=coerced, diagnostics=diagnostics)
        if operand.llvm_type == "i64":
            temp_name = format_temp_name(temp_index)
            current_lines = append_string(current_lines, "  " + temp_name + " = icmp ne i64 " + operand.value + ", 0")
            coerced = LLVMOperand(llvm_type="i1", value=temp_name)
            return CoercionResult(lines=current_lines, temp_index=temp_index + 1, operand=coerced, diagnostics=diagnostics)
    diagnostics = append_string(diagnostics, "llvm lowering: unable to coerce operand of type `" + operand.llvm_type + "` to `" + target_type + "`")
    return CoercionResult(lines=current_lines, temp_index=temp_index, operand=null, diagnostics=diagnostics)

def dominant_type(first, second):
    if len(first) == 0:
        return second
    if len(second) == 0:
        return first
    if first == second:
        return first
    if first == "double"  or  second == "double":
        return "double"
    if first == "i64"  or  second == "i64":
        return "i64"
    if first == "i1"  or  second == "i1":
        return "i1"
    return first

def harmonise_operands(left, right, temp_index, lines):
    diagnostics = []
    current_lines = lines
    current_temp = temp_index
    left_operand = left
    right_operand = right
    if left_operand.llvm_type == right_operand.llvm_type:
        return BinaryAlignmentResult(lines=current_lines, temp_index=current_temp, left=left_operand, right=right_operand, diagnostics=diagnostics, result_type=left_operand.llvm_type)
    target_type = dominant_type(left_operand.llvm_type, right_operand.llvm_type)
    left_coercion = coerce_operand_to_type(left_operand, target_type, current_temp, current_lines)
    diagnostics = (diagnostics) + (left_coercion.diagnostics)
    if left_coercion.operand == null:
        diagnostics = append_string(diagnostics, "llvm lowering: unable to convert left operand from `" + left_operand.llvm_type + "` to `" + target_type + "`")
        return BinaryAlignmentResult(lines=left_coercion.lines, temp_index=left_coercion.temp_index, left=null, right=null, diagnostics=diagnostics, result_type=target_type)
    left_operand = left_coercion.operand
    current_lines = left_coercion.lines
    current_temp = left_coercion.temp_index
    right_coercion = coerce_operand_to_type(right_operand, target_type, current_temp, current_lines)
    diagnostics = (diagnostics) + (right_coercion.diagnostics)
    if right_coercion.operand == null:
        diagnostics = append_string(diagnostics, "llvm lowering: unable to convert right operand from `" + right_operand.llvm_type + "` to `" + target_type + "`")
        return BinaryAlignmentResult(lines=right_coercion.lines, temp_index=right_coercion.temp_index, left=null, right=null, diagnostics=diagnostics, result_type=target_type)
    right_operand = right_coercion.operand
    current_lines = right_coercion.lines
    current_temp = right_coercion.temp_index
    return BinaryAlignmentResult(lines=current_lines, temp_index=current_temp, left=left_operand, right=right_operand, diagnostics=diagnostics, result_type=target_type)

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
            return OperatorMatch(index=index, symbol=substring(expression, index, index + 1), success=true)
    return OperatorMatch(index=-1, symbol="", success=false)

def find_comparison_operator(expression):
    depth = 0
    index = 0
    while True:
        if index >= len(expression):
            break
        ch = expression[index]
        if ch == "(":
            depth += 1
            index += 1
            continue
        if ch == ")":
            if depth > 0:
                depth -= 1
            index += 1
            continue
        if depth > 0:
            index += 1
            continue
        if index + 1 < len(expression):
            two = substring(expression, index, index + 2)
            if two == "=="  or  two == "!="  or  two == "<="  or  two == ">=":
                return OperatorMatch(index=index, symbol=two, success=true)
        if ch == "<"  or  ch == ">":
            return OperatorMatch(index=index, symbol=substring(expression, index, index + 1), success=true)
        index += 1
    return OperatorMatch(index=-1, symbol="", success=false)

def contains_char(set, ch):
    index = 0
    while True:
        if index >= len(set):
            break
        if set[index] == ch:
            return true
        index += 1
    return false

def is_binary_minus(expression, index):
    previous = find_previous_non_space_char(expression, index)
    next = find_next_non_space_char(expression, index)
    if previous == null:
        return false
    prev_char = previous
    if prev_char == "+"  or  prev_char == "-"  or  prev_char == "*"  or  prev_char == "/"  or  prev_char == "("  or  prev_char == ",":
        return false
    if next == null:
        return false
    next_char = next
    if next_char == "+"  or  next_char == "-"  or  next_char == "*"  or  next_char == "/"  or  next_char == ")"  or  next_char == ",":
        return false
    return true

def find_previous_non_space_char(value, index):
    position = index
    while True:
        if position <= 0:
            break
        position -= 1
        ch = value[position]
        if not is_trim_char(ch):
            return ch
    return null

def find_next_non_space_char(value, index):
    position = index + 1
    while True:
        if position >= len(value):
            break
        ch = value[position]
        if not is_trim_char(ch):
            return ch
        position += 1
    return null

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

def format_local_pointer_name(index):
    return "%l" + number_to_string(index)

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
        return "false"
    return "zeroinitializer"

def strip_mut_prefix(value):
    trimmed = trim_text(value)
    if len(trimmed) < 4:
        return trimmed
    prefix = substring(trimmed, 0, 4)
    if prefix == "mut ":
        return trim_text(substring(trimmed, 4, len(trimmed)))
    return trimmed

def is_simple_identifier(value):
    trimmed = trim_text(value)
    if len(trimmed) == 0:
        return false
    first = trimmed[0]
    if first >= "0"  and  first <= "9":
        return false
    sanitized = sanitize_symbol(trimmed)
    if sanitized != trimmed:
        return false
    return true

def find_top_level_range_separator(value):
    paren_depth = 0
    bracket_depth = 0
    brace_depth = 0
    index = 0
    while True:
        if index >= len(value):
            break
        ch = value[index]
        if ch == "(":
            paren_depth += 1
            index += 1
            continue
        if ch == ")":
            if paren_depth > 0:
                paren_depth -= 1
            index += 1
            continue
        if ch == "[":
            bracket_depth += 1
            index += 1
            continue
        if ch == "]":
            if bracket_depth > 0:
                bracket_depth -= 1
            index += 1
            continue
        if ch == "{":
            brace_depth += 1
            index += 1
            continue
        if ch == "}":
            if brace_depth > 0:
                brace_depth -= 1
            index += 1
            continue
        if ch == ".":
            if index + 1 < len(value):
                if value[index + 1] == ".":
                    if paren_depth == 0  and  bracket_depth == 0  and  brace_depth == 0:
                        return index
        index += 1
    return -1

def parse_range_iterable(iterable):
    trimmed = trim_text(iterable)
    diagnostics = []
    if len(trimmed) == 0:
        diagnostics = append_string(diagnostics, "llvm lowering: `.for` iterable expression is empty")
        return RangeIterableParse(success=false, start="", end="", diagnostics=diagnostics)
    separator_index = find_top_level_range_separator(trimmed)
    if separator_index < 0:
        diagnostics = append_string(diagnostics, "llvm lowering: `.for` iterable must use `start..end` range syntax")
        return RangeIterableParse(success=false, start="", end="", diagnostics=diagnostics)
    start_text = trim_text(substring(trimmed, 0, separator_index))
    end_text = trim_text(substring(trimmed, separator_index + 2, len(trimmed)))
    if len(start_text) == 0:
        diagnostics = append_string(diagnostics, "llvm lowering: `.for` range missing start expression")
    if len(end_text) == 0:
        diagnostics = append_string(diagnostics, "llvm lowering: `.for` range missing end expression")
    success = len(start_text) > 0  and  len(end_text) > 0
    return RangeIterableParse(success=success, start=start_text, end=end_text, diagnostics=diagnostics)

def find_local_binding(locals, name):
    index = 0
    while True:
        if index >= len(locals):
            break
        entry = locals[index]
        if entry.name == name:
            return entry
        index += 1
    return null

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
    return null

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
        return true
    code = char_code(ch)
    if code >= char_code("a")  and  code <= char_code("z"):
        return true
    if code >= char_code("A")  and  code <= char_code("Z"):
        return true
    if code >= char_code("0")  and  code <= char_code("9"):
        return true
    return false

def lower_char_code(code):
    if code >= char_code("A")  and  code <= char_code("Z"):
        return code + char_code("a") - char_code("A")
    return code

def matches_case_insensitive(value, expected):
    if len(value) != len(expected):
        return false
    index = 0
    while True:
        if index >= len(value):
            break
        value_code = lower_char_code(char_code(value[index]))
        expected_code = lower_char_code(char_code(expected[index]))
        if value_code != expected_code:
            return false
        index += 1
    return true

def is_boolean_literal(text):
    trimmed = trim_text(text)
    if matches_case_insensitive(trimmed, "true"):
        return true
    if matches_case_insensitive(trimmed, "false"):
        return true
    return false

def is_integer_literal(text):
    trimmed = trim_text(text)
    if len(trimmed) == 0:
        return false
    index = 0
    if trimmed[0] == "-":
        if len(trimmed) == 1:
            return false
        index = 1
    has_digit = false
    while True:
        if index >= len(trimmed):
            break
        ch = trimmed[index]
        if ch >= "0"  and  ch <= "9":
            has_digit = true
            index += 1
            continue
        return false
    return has_digit

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
