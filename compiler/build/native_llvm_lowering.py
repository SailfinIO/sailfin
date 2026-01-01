import asyncio
from runtime import runtime_support as runtime

from compiler.build.llvm.lowering.entrypoints import lower_to_llvm, lower_to_llvm_for_tests, lower_to_llvm_with_manifests, lower_to_llvm_with_context
from compiler.build.llvm.runtime_helpers import runtime_helper_descriptors, find_runtime_helper, append_runtime_helper
from compiler.build.llvm.expression_lowering_stage2 import coerce_operand_to_type, detect_suspension_conflicts, analyze_value_ownership
from compiler.build.llvm.expressions import mark_local_consumed, mark_parameter_consumed, reset_local_consumption, find_parameter_binding
from compiler.build.llvm.lifetime import update_local_ownership
from compiler.build.llvm.expression_lowering_stage2 import unescape_string_literal, make_string_constant_name
from compiler.build.llvm.strings import escape_string_for_llvm
from compiler.build.llvm.types import StringConstant

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


__all__ = ["lower_to_llvm", "lower_to_llvm_for_tests", "lower_to_llvm_with_manifests", "lower_to_llvm_with_context", "runtime_helper_descriptors", "find_runtime_helper", "append_runtime_helper", "coerce_operand_to_type", "detect_suspension_conflicts", "analyze_value_ownership", "mark_local_consumed", "mark_parameter_consumed", "reset_local_consumption", "find_parameter_binding", "update_local_ownership", "unescape_string_literal", "make_string_constant_name", "escape_string_for_llvm", "StringConstant"]
