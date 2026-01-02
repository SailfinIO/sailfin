import asyncio
from runtime import runtime_support as runtime

from ..types import ParameterBinding, LocalBinding, RawAddressParseResult, LLVMOperand, ExpressionResult
from ..utils import trim_text, append_string
from ..strings import empty_string_constant_set
from ..expressions import is_simple_identifier
from compiler.build.llvm.expression_lowering_stage2.core_scopes import find_local_binding
from compiler.build.llvm.expression_lowering_stage2.core_bindings_stage2 import find_parameter_binding

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

def lower_raw_address_expression(parse, bindings, locals, temp_index, lines):
    diagnostics = parse.diagnostics
    empty_constants = empty_string_constant_set()
    if not parse.success:
        return ExpressionResult(lines=lines, temp_index=temp_index, operand=None, diagnostics=diagnostics, string_constants=empty_constants)
    target = trim_text(parse.target)
    if not is_simple_identifier(target):
        diagnostics = append_string(diagnostics, "llvm lowering: &raw currently supports only simple identifiers (got `" + target + "`)")
        return ExpressionResult(lines=lines, temp_index=temp_index, operand=None, diagnostics=diagnostics, string_constants=empty_constants)
    local = find_local_binding(locals, target)
    if local != None:
        operand = LLVMOperand(llvm_type=local.llvm_type + "*", value=local.pointer)
        return ExpressionResult(lines=lines, temp_index=temp_index, operand=operand, diagnostics=diagnostics, string_constants=empty_constants)
    param = find_parameter_binding(bindings, target)
    if param != None:
        diagnostics = append_string(diagnostics, "llvm lowering: cannot take raw address of parameter `" + target + "` yet")
        return ExpressionResult(lines=lines, temp_index=temp_index, operand=None, diagnostics=diagnostics, string_constants=empty_constants)
    diagnostics = append_string(diagnostics, "llvm lowering: &raw target `" + target + "` is not a local")
    return ExpressionResult(lines=lines, temp_index=temp_index, operand=None, diagnostics=diagnostics, string_constants=empty_constants)
