import asyncio
from runtime import runtime_support as runtime

from compiler.build.types import RuntimeHelperDescriptor
from compiler.build.utils import trim_text

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

def runtime_helper_descriptors():
    descriptors = []
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="print.info", symbol="sailfin_runtime_print_info", return_type="void", parameter_types=["i8*"], effects=["io"]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="print.error", symbol="sailfin_runtime_print_error", return_type="void", parameter_types=["i8*"], effects=["io"]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="print.warn", symbol="sailfin_runtime_print_warn", return_type="void", parameter_types=["i8*"], effects=["io"]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="console.info", symbol="sailfin_intrinsic_io_print", return_type="void", parameter_types=["i8*"], effects=["io"]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="console.log", symbol="sailfin_intrinsic_io_print", return_type="void", parameter_types=["i8*"], effects=["io"]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="console.error", symbol="sailfin_runtime_print_error", return_type="void", parameter_types=["i8*"], effects=["io"]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="io_read", symbol="sailfin_intrinsic_io_read", return_type="i8*", parameter_types=["i8*"], effects=["io"]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="fs.read", symbol="sailfin_intrinsic_fs_read", return_type="i8*", parameter_types=["i8*"], effects=["io"]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="fs.write", symbol="sailfin_intrinsic_fs_write", return_type="void", parameter_types=["i8*", "i8*"], effects=["io"]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="fs.exists", symbol="sailfin_intrinsic_fs_exists", return_type="i1", parameter_types=["i8*"], effects=["io"]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="model_invoke", symbol="sailfin_intrinsic_model_invoke", return_type="i8*", parameter_types=["i8*", "i8*"], effects=["model"]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="prompt", symbol="sailfin_intrinsic_model_invoke", return_type="i8*", parameter_types=["i8*", "i8*"], effects=["model"]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="net_request", symbol="sailfin_intrinsic_net_request", return_type="i8*", parameter_types=["i8*", "i8*", "i8*"], effects=["net"]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="http.get", symbol="sailfin_intrinsic_http_get", return_type="i8*", parameter_types=["i8*"], effects=["net"]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="http.post", symbol="sailfin_intrinsic_http_post", return_type="i8*", parameter_types=["i8*", "i8*"], effects=["net"]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="sleep", symbol="sailfin_runtime_sleep", return_type="void", parameter_types=["double"], effects=["clock"]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="runtime_sleep_fn", symbol="sailfin_runtime_sleep", return_type="void", parameter_types=["double"], effects=["clock"]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="runtime_channel_fn", symbol="sailfin_runtime_channel", return_type="i8*", parameter_types=["double"], effects=["io"]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="runtime_spawn_fn", symbol="sailfin_runtime_spawn", return_type="void", parameter_types=["i8*", "i8*"], effects=["io"]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="runtime_parallel_fn", symbol="sailfin_runtime_parallel", return_type="i8*", parameter_types=["i8*"], effects=["io"]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="runtime_create_capability_grant", symbol="sailfin_runtime_create_capability_grant", return_type="i8*", parameter_types=["i8*"], effects=[]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="runtime_create_filesystem_bridge", symbol="sailfin_runtime_create_filesystem_bridge", return_type="i8*", parameter_types=["i8*"], effects=["io"]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="runtime_create_http_bridge", symbol="sailfin_runtime_create_http_bridge", return_type="i8*", parameter_types=["i8*"], effects=["net"]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="runtime_create_model_bridge", symbol="sailfin_runtime_create_model_bridge", return_type="i8*", parameter_types=["i8*"], effects=["model"]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="runtime_log_execution_fn", symbol="sailfin_runtime_log_execution", return_type="i8*", parameter_types=["i8*"], effects=["io"]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="runtime_to_debug_string_fn", symbol="sailfin_runtime_to_debug_string", return_type="i8*", parameter_types=["i8*"], effects=[]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="runtime_raise_value_error_fn", symbol="sailfin_runtime_raise_value_error", return_type="void", parameter_types=["i8*"], effects=[]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="runtime_is_string_fn", symbol="sailfin_runtime_is_string", return_type="i1", parameter_types=["i8*"], effects=[]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="runtime_is_number_fn", symbol="sailfin_runtime_is_number", return_type="i1", parameter_types=["i8*"], effects=[]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="runtime_is_boolean_fn", symbol="sailfin_runtime_is_boolean", return_type="i1", parameter_types=["i8*"], effects=[]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="runtime_is_void_fn", symbol="sailfin_runtime_is_void", return_type="i1", parameter_types=["i8*"], effects=[]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="runtime.bounds_check", symbol="sailfin_runtime_bounds_check", return_type="void", parameter_types=["i64", "i64"], effects=[]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="runtime_is_array_fn", symbol="sailfin_runtime_is_array", return_type="i1", parameter_types=["i8*"], effects=[]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="runtime_is_callable_fn", symbol="sailfin_runtime_is_callable", return_type="i1", parameter_types=["i8*"], effects=[]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="runtime_resolve_runtime_type_fn", symbol="sailfin_runtime_resolve_type", return_type="i8*", parameter_types=["i8*"], effects=[]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="runtime_instance_of_fn", symbol="sailfin_runtime_instance_of", return_type="i1", parameter_types=["i8*", "i8*"], effects=[]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="runtime_serve_fn", symbol="sailfin_runtime_serve", return_type="void", parameter_types=["i8*", "i8*"], effects=["io", "net"]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="runtime_char_code_fn", symbol="sailfin_runtime_char_code", return_type="double", parameter_types=["i8*"], effects=[]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="process.run", symbol="sailfin_runtime_process_run", return_type="double", parameter_types=["{ i8**, i64 }*"], effects=["io"]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="fs_read_file", symbol="sailfin_adapter_fs_read_file", return_type="i8*", parameter_types=["i8*"], effects=["io"]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="fs.readFile", symbol="sailfin_adapter_fs_read_file", return_type="i8*", parameter_types=["i8*"], effects=["io"]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="fs_write_file", symbol="sailfin_adapter_fs_write_file", return_type="void", parameter_types=["i8*", "i8*"], effects=["io"]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="fs.writeFile", symbol="sailfin_adapter_fs_write_file", return_type="void", parameter_types=["i8*", "i8*"], effects=["io"]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="fs_list_directory", symbol="sailfin_adapter_fs_list_directory", return_type="{ i8**, i64 }*", parameter_types=["i8*"], effects=["io"]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="fs.listDirectory", symbol="sailfin_adapter_fs_list_directory", return_type="{ i8**, i64 }*", parameter_types=["i8*"], effects=["io"]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="fs_delete_file", symbol="sailfin_adapter_fs_delete_file", return_type="i1", parameter_types=["i8*"], effects=["io"]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="fs.deleteFile", symbol="sailfin_adapter_fs_delete_file", return_type="i1", parameter_types=["i8*"], effects=["io"]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="fs_create_directory", symbol="sailfin_adapter_fs_create_directory", return_type="i1", parameter_types=["i8*", "i1"], effects=["io"]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="fs.createDirectory", symbol="sailfin_adapter_fs_create_directory", return_type="i1", parameter_types=["i8*", "i1"], effects=["io"]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="http_get", symbol="sailfin_adapter_http_get", return_type="i8*", parameter_types=["i8*"], effects=["net"]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="http_post", symbol="sailfin_adapter_http_post", return_type="i8*", parameter_types=["i8*", "i8*"], effects=["net"]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="model_invoke_with_prompt", symbol="sailfin_adapter_model_invoke_with_prompt", return_type="i8*", parameter_types=["i8*", "i8*"], effects=["model"]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="serve_start", symbol="sailfin_adapter_serve_start", return_type="void", parameter_types=["i8*", "i32"], effects=["net", "io"]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="serve_handler_dispatch", symbol="sailfin_adapter_serve_handler_dispatch", return_type="i8*", parameter_types=["i8*", "i8*"], effects=["net", "io"]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="spawn_task", symbol="sailfin_adapter_spawn_task", return_type="i8*", parameter_types=["i8*"], effects=["spawn"]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="channel_create", symbol="sailfin_adapter_channel_create", return_type="i8*", parameter_types=["i32"], effects=[]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="channel_send", symbol="sailfin_adapter_channel_send", return_type="void", parameter_types=["i8*", "i8*"], effects=["channel"]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="channel_receive", symbol="sailfin_adapter_channel_receive", return_type="i8*", parameter_types=["i8*"], effects=["channel"]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="runtime_array_map_fn", symbol="sailfin_runtime_array_map", return_type="i8*", parameter_types=["i8*", "i8*"], effects=[]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="runtime_array_filter_fn", symbol="sailfin_runtime_array_filter", return_type="i8*", parameter_types=["i8*", "i8*"], effects=[]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="runtime_array_reduce_fn", symbol="sailfin_runtime_array_reduce", return_type="i8*", parameter_types=["i8*", "i8*", "i8*"], effects=[]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="substring", symbol="sailfin_runtime_substring", return_type="i8*", parameter_types=["i8*", "i64", "i64"], effects=[]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="substring_unchecked", symbol="sailfin_runtime_substring_unchecked", return_type="i8*", parameter_types=["i8*", "i64", "i64"], effects=[]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="len(string)", symbol="sailfin_runtime_string_length", return_type="i64", parameter_types=["i8*"], effects=[]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="string.concat", symbol="sailfin_runtime_string_concat", return_type="i8*", parameter_types=["i8*", "i8*"], effects=[]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="string.drop", symbol="sailfin_runtime_string_drop", return_type="void", parameter_types=["i8*"], effects=[]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="number.to_string", symbol="sailfin_runtime_number_to_string", return_type="i8*", parameter_types=["double"], effects=[]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="strings_equal", symbol="strings_equal", return_type="i1", parameter_types=["i8*", "i8*"], effects=[]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="char_code", symbol="char_code", return_type="double", parameter_types=["i8*"], effects=[]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="runtime_grapheme_count_fn", symbol="sailfin_runtime_grapheme_count", return_type="double", parameter_types=["i8*"], effects=[]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="runtime_grapheme_at_fn", symbol="sailfin_runtime_grapheme_at", return_type="i8*", parameter_types=["i8*", "double"], effects=[]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="grapheme_at", symbol="sailfin_runtime_grapheme_at", return_type="i8*", parameter_types=["i8*", "double"], effects=[]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="is_whitespace_char", symbol="sailfin_runtime_is_whitespace_char", return_type="i1", parameter_types=["i8"], effects=[]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="is_decimal_digit", symbol="sailfin_runtime_is_decimal_digit", return_type="i1", parameter_types=["i8"], effects=[]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="is_alpha_char", symbol="sailfin_runtime_is_alpha_char", return_type="i1", parameter_types=["i8"], effects=[]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="append_string", symbol="sailfin_runtime_append_string", return_type="{ i8**, i64 }*", parameter_types=["{ i8**, i64 }*", "i8*"], effects=[]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="concat", symbol="sailfin_runtime_concat", return_type="{ i8**, i64 }*", parameter_types=["{ i8**, i64 }*", "{ i8**, i64 }*"], effects=[]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="copy_bytes", symbol="sailfin_runtime_copy_bytes", return_type="void", parameter_types=["i8*", "i8*", "i64"], effects=[]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="get_field", symbol="sailfin_runtime_get_field", return_type="i8*", parameter_types=["i8*", "i8*"], effects=[]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="mark_persistent", symbol="sailfin_runtime_mark_persistent", return_type="void", parameter_types=["i8*"], effects=[]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="set_exception", symbol="sailfin_runtime_set_exception", return_type="void", parameter_types=["i8*"], effects=[]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="clear_exception", symbol="sailfin_runtime_clear_exception", return_type="void", parameter_types=[], effects=[]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="has_exception", symbol="sailfin_runtime_has_exception", return_type="i1", parameter_types=[], effects=[]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="try_enter", symbol="sailfin_runtime_try_enter", return_type="i32", parameter_types=["i8**"], effects=[]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="try_leave", symbol="sailfin_runtime_try_leave", return_type="void", parameter_types=["i8*"], effects=[]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="throw", symbol="sailfin_runtime_throw", return_type="void", parameter_types=["i8*"], effects=[]))
    descriptors = append_runtime_helper(descriptors, RuntimeHelperDescriptor(target="take_exception", symbol="sailfin_runtime_take_exception", return_type="i8*", parameter_types=[], effects=[]))
    return descriptors

def append_runtime_helper(values, value):
    return (values) + ([value])

def find_runtime_helper(target):
    descriptors = runtime_helper_descriptors()
    trimmed = trim_text(target)
    index = 0
    while True:
        if index >= len(descriptors):
            break
        if descriptors[index].target == trimmed:
            return descriptors[index]
        index += 1
    return None
