import asyncio
from runtime import runtime_support as runtime

from compiler.build.llvm.expression_lowering_stage2.statement import lower_expression_statement, lower_return_instruction, parse_assignment_expression, parse_inline_let_expression, detect_suspension_conflicts, prepare_parameters, future_pointer_type_for_return_type, spawn_symbol_for_return_type, spawn_ctx_symbol_for_return_type, map_local_type
from compiler.build.llvm.expression_lowering_stage2.core import lower_expression, coerce_operand_to_type, harmonise_operands, emit_boolean_and, emit_comparison_instruction, load_local_operand, append_local_binding, find_local_binding, append_llvm_operand, parse_enum_literal, parse_struct_pattern, parse_range_iterable, analyze_value_ownership, detect_borrow_conflicts
from compiler.build.llvm.expression_lowering_stage2.core_text import parse_union_payload_types, is_union_llvm_type, extract_simple_identifier, unescape_string_literal, make_string_constant_name, make_string_constant_name_for_module
from ..expressions import format_temp_name

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


__all__ = ["lower_expression_statement", "lower_return_instruction", "parse_assignment_expression", "parse_inline_let_expression", "detect_suspension_conflicts", "prepare_parameters", "future_pointer_type_for_return_type", "spawn_symbol_for_return_type", "spawn_ctx_symbol_for_return_type", "map_local_type", "lower_expression", "coerce_operand_to_type", "harmonise_operands", "emit_boolean_and", "emit_comparison_instruction", "load_local_operand", "append_local_binding", "find_local_binding", "append_llvm_operand", "parse_enum_literal", "parse_struct_pattern", "parse_range_iterable", "analyze_value_ownership", "detect_borrow_conflicts", "parse_union_payload_types", "is_union_llvm_type", "extract_simple_identifier", "unescape_string_literal", "make_string_constant_name", "make_string_constant_name_for_module", "format_temp_name"]
