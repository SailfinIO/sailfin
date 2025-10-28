"""Stage2 execution helpers that enforce capability manifests at runtime."""

from __future__ import annotations

import contextvars
import ctypes
import os
import pathlib
import re
from dataclasses import dataclass
from collections import OrderedDict
from collections.abc import Iterable as ABCIterable
from typing import Callable, Dict, Iterable, Mapping, Sequence, cast

import llvmlite.binding as llvm

from runtime import runtime_support as runtime

__all__ = ["Stage2Runner", "current_capability_grant"]


CapabilityDelegate = Callable[[ctypes.c_void_p], None]
SleepDelegate = Callable[[float], None]


@dataclass
class Stage2RuntimeHooks:
    """Optional handlers invoked by the native runtime helpers."""

    print_info: CapabilityDelegate | None = None
    print_warn: CapabilityDelegate | None = None
    print_error: CapabilityDelegate | None = None
    sleep: SleepDelegate | None = None


_HELPER_ALIASES: Mapping[str, str] = {
    "print.info": "sailfin_runtime_print_info",
    "print.warn": "sailfin_runtime_print_warn",
    "print.error": "sailfin_runtime_print_error",
    "sleep": "sailfin_runtime_sleep",
}

_HELPER_SIGNATURES: Mapping[str, tuple[str, Sequence[type]]] = {
    "sailfin_runtime_print_info": ("io", (ctypes.c_void_p,)),
    "sailfin_runtime_print_warn": ("io", (ctypes.c_void_p,)),
    "sailfin_runtime_print_error": ("io", (ctypes.c_void_p,)),
    "sailfin_runtime_sleep": ("clock", (ctypes.c_double,)),
}

# Adapter signatures for capability-aware runtime operations
_ADAPTER_SIGNATURES: Mapping[str, tuple[str | Sequence[str] | None, Sequence[type], type | None]] = {
    # Filesystem adapters
    "sailfin_adapter_fs_read_file": ("io", (ctypes.c_void_p,), ctypes.c_void_p),
    "sailfin_adapter_fs_write_file": ("io", (ctypes.c_void_p, ctypes.c_void_p), None),
    "sailfin_adapter_fs_list_directory": ("io", (ctypes.c_void_p,), ctypes.c_void_p),
    "sailfin_adapter_fs_delete_file": ("io", (ctypes.c_void_p,), ctypes.c_bool),
    "sailfin_adapter_fs_create_directory": ("io", (ctypes.c_void_p, ctypes.c_bool), ctypes.c_bool),
    "sailfin_intrinsic_fs_exists": ("io", (ctypes.c_void_p,), ctypes.c_bool),
    # Capability helpers
    "sailfin_runtime_create_capability_grant": (None, (ctypes.c_void_p,), ctypes.c_void_p),
    "sailfin_runtime_create_filesystem_bridge": ("io", (ctypes.c_void_p,), ctypes.c_void_p),
    "sailfin_runtime_create_http_bridge": ("net", (ctypes.c_void_p,), ctypes.c_void_p),
    "sailfin_runtime_create_model_bridge": ("model", (ctypes.c_void_p,), ctypes.c_void_p),
    # String helpers
    "sailfin_runtime_substring": (None, (ctypes.c_void_p, ctypes.c_longlong, ctypes.c_longlong), ctypes.c_void_p),
    "sailfin_runtime_string_length": (None, (ctypes.c_void_p,), ctypes.c_longlong),
    "sailfin_runtime_string_concat": (None, (ctypes.c_void_p, ctypes.c_void_p), ctypes.c_void_p),
    "sailfin_runtime_concat": (None, (ctypes.c_void_p, ctypes.c_void_p), ctypes.c_void_p),
    "sailfin_runtime_append_string": (None, (ctypes.c_void_p, ctypes.c_void_p), ctypes.c_void_p),
    "sailfin_runtime_char_code": (None, (ctypes.c_void_p,), ctypes.c_double),
    "sailfin_runtime_is_decimal_digit": (None, (ctypes.c_byte,), ctypes.c_bool),
    "sailfin_runtime_grapheme_count": (None, (ctypes.c_void_p,), ctypes.c_double),
    "sailfin_runtime_grapheme_at": (None, (ctypes.c_void_p, ctypes.c_double), ctypes.c_void_p),
    "sailfin_runtime_is_whitespace_char": (None, (ctypes.c_byte,), ctypes.c_bool),
    "char_code": (None, (ctypes.c_void_p,), ctypes.c_double),
    "sailfin_runtime_bounds_check": (None, (ctypes.c_longlong, ctypes.c_longlong), None),
    # Generic runtime helpers
    "sailfin_runtime_channel": ("io", (ctypes.c_double,), ctypes.c_void_p),
    "sailfin_runtime_parallel": ("io", (ctypes.c_void_p,), ctypes.c_void_p),
    "sailfin_runtime_spawn": ("io", (ctypes.c_void_p, ctypes.c_void_p), None),
    "sailfin_runtime_log_execution": ("io", (ctypes.c_void_p,), ctypes.c_void_p),
    "sailfin_runtime_to_debug_string": (None, (ctypes.c_void_p,), ctypes.c_void_p),
    "sailfin_runtime_raise_value_error": (None, (ctypes.c_void_p,), None),
    "sailfin_runtime_is_string": (None, (ctypes.c_void_p,), ctypes.c_bool),
    "sailfin_runtime_is_number": (None, (ctypes.c_void_p,), ctypes.c_bool),
    "sailfin_runtime_is_boolean": (None, (ctypes.c_void_p,), ctypes.c_bool),
    "sailfin_runtime_is_void": (None, (ctypes.c_void_p,), ctypes.c_bool),
    "sailfin_runtime_is_array": (None, (ctypes.c_void_p,), ctypes.c_bool),
    "sailfin_runtime_is_callable": (None, (ctypes.c_void_p,), ctypes.c_bool),
    "sailfin_runtime_resolve_type": (None, (ctypes.c_void_p,), ctypes.c_void_p),
    "sailfin_runtime_instance_of": (None, (ctypes.c_void_p, ctypes.c_void_p), ctypes.c_bool),
    "sailfin_runtime_serve": (("io", "net"), (ctypes.c_void_p, ctypes.c_void_p), None),
    "sailfin_runtime_array_map": (None, (ctypes.c_void_p, ctypes.c_void_p), ctypes.c_void_p),
    "sailfin_runtime_array_filter": (None, (ctypes.c_void_p, ctypes.c_void_p), ctypes.c_void_p),
    "sailfin_runtime_array_reduce": (None, (ctypes.c_void_p, ctypes.c_void_p, ctypes.c_void_p), ctypes.c_void_p),
    "sailfin_runtime_get_field": (None, (ctypes.c_void_p, ctypes.c_void_p), ctypes.c_void_p),
    # HTTP adapters
    "sailfin_adapter_http_get": ("net", (ctypes.c_void_p,), ctypes.c_void_p),
    "sailfin_adapter_http_post": ("net", (ctypes.c_void_p, ctypes.c_void_p), ctypes.c_void_p),
    # Model adapter
    "sailfin_adapter_model_invoke_with_prompt": ("model", (ctypes.c_void_p, ctypes.c_void_p), ctypes.c_void_p),
    # Serve adapters
    "sailfin_adapter_serve_start": ("io", (ctypes.c_void_p, ctypes.c_void_p), None),
    "sailfin_adapter_serve_handler_dispatch": ("io", (ctypes.c_void_p, ctypes.c_void_p), ctypes.c_void_p),
    # Concurrency adapters
    "sailfin_adapter_spawn_task": ("spawn", (ctypes.c_void_p, ctypes.c_void_p), None),
    "sailfin_adapter_channel_create": ("channel", (ctypes.c_longlong,), ctypes.c_void_p),
    "sailfin_adapter_channel_send": ("channel", (ctypes.c_void_p, ctypes.c_void_p), None),
    "sailfin_adapter_channel_receive": ("channel", (ctypes.c_void_p,), ctypes.c_void_p),
    "stage2_debug_marker": (None, (ctypes.c_longlong,), None),
}

_ACTIVE_GRANT: contextvars.ContextVar[runtime.CapabilityGrant | None] = contextvars.ContextVar(
    "stage2_active_capability_grant", default=None
)
_LAST_RUNTIME_ERROR: contextvars.ContextVar[Exception | None] = contextvars.ContextVar(
    "stage2_last_runtime_error", default=None
)

_LLVM_INITIALISED = False
_LIBC_HANDLE: ctypes.CDLL | None = None
_LIBC_FUNCTIONS: dict[str, ctypes._CFuncPtr] = {}
_LIBC_SYMBOL_ADDRESSES: dict[str, int] = {}
_LIBC_ALLOCATIONS: dict[int, tuple[ctypes.Array, int]] = {}


def current_capability_grant() -> runtime.CapabilityGrant | None:
    """Return the capability grant active for the current Stage2 invocation."""

    return _ACTIVE_GRANT.get()


def _ensure_llvm_initialised() -> None:
    global _LLVM_INITIALISED
    if _LLVM_INITIALISED:
        return
    llvm.initialize_native_target()
    llvm.initialize_native_asmprinter()
    _LLVM_INITIALISED = True


def _ensure_libc_symbols(debug_log: Callable[[str], None] | None) -> dict[str, ctypes._CFuncPtr]:
    global _LIBC_HANDLE, _LIBC_FUNCTIONS, _LIBC_SYMBOL_ADDRESSES
    if _LIBC_FUNCTIONS:
        for name, address in _LIBC_SYMBOL_ADDRESSES.items():
            llvm.add_symbol(name, address)
        return _LIBC_FUNCTIONS

    try:
        logger = debug_log

        def _malloc_wrapper(size: int) -> int:
            try:
                request = int(size)
            except Exception:
                request = 0
            if request <= 0:
                request = 1
            try:
                buffer = ctypes.create_string_buffer(request)
            except Exception as exc:
                if logger:
                    logger(f"[stage2] malloc({request}) allocation failed: {exc}")
                if _LAST_RUNTIME_ERROR.get() is None:
                    _LAST_RUNTIME_ERROR.set(exc)
                return 0
            address_obj = ctypes.cast(buffer, ctypes.c_void_p)
            address_value = address_obj.value
            pointer = 0 if address_value is None else int(address_value)
            if pointer != 0:
                _LIBC_ALLOCATIONS[pointer] = (buffer, request)
                if logger:
                    logger(
                        f"[stage2] malloc request size={request} result=0x{pointer:x}"
                    )
            else:
                if logger:
                    logger(f"[stage2] malloc request size={request} result=null")
            return pointer

        def _free_wrapper(ptr: ctypes.c_void_p | int) -> None:
            try:
                if isinstance(ptr, ctypes.c_void_p):
                    address = int(ptr.value or 0)
                else:
                    address = int(ptr or 0)
            except Exception:
                address = 0
            if address == 0:
                if logger:
                    logger("[stage2] free ptr=null (ignored)")
                return
            allocation = _LIBC_ALLOCATIONS.pop(address, None)
            if allocation is None:
                if logger:
                    logger(f"[stage2] free unknown ptr=0x{address:x} (skipped)")
                if _LAST_RUNTIME_ERROR.get() is None:
                    _LAST_RUNTIME_ERROR.set(
                        RuntimeError(
                            f"free invoked on unknown pointer 0x{address:x}"
                        )
                    )
                return
            if logger:
                size = allocation[1]
                logger(f"[stage2] free ptr=0x{address:x} size={size}")
            # letting the buffer go out of scope releases the memory

        malloc_cfunc = ctypes.CFUNCTYPE(ctypes.c_void_p, ctypes.c_size_t)(_malloc_wrapper)
        free_cfunc = ctypes.CFUNCTYPE(None, ctypes.c_void_p)(_free_wrapper)
        malloc_addr = int(ctypes.cast(malloc_cfunc, ctypes.c_void_p).value or 0)
        free_addr = int(ctypes.cast(free_cfunc, ctypes.c_void_p).value or 0)

        llvm.add_symbol("malloc", malloc_addr)
        llvm.add_symbol("free", free_addr)

        _LIBC_HANDLE = None
        _LIBC_FUNCTIONS = {"malloc": malloc_cfunc, "free": free_cfunc}
        _LIBC_SYMBOL_ADDRESSES = {"malloc": malloc_addr, "free": free_addr}

        if debug_log:
            debug_log(f"[stage2] registered managed malloc wrapper: addr=0x{malloc_addr:x}")
            debug_log(f"[stage2] registered managed free wrapper: addr=0x{free_addr:x}")
    except Exception as exc:  # pragma: no cover - diagnostics only
        if debug_log:
            debug_log(f"[stage2] failed to register libc malloc/free wrappers: {exc}")

    return _LIBC_FUNCTIONS


def _normalise_hooks(hooks: Stage2RuntimeHooks | Mapping[str, Callable[..., None]] | None) -> Dict[str, Callable[..., None] | None]:
    if hooks is None:
        return {}
    if isinstance(hooks, Stage2RuntimeHooks):
        return {
            "sailfin_runtime_print_info": hooks.print_info,
            "sailfin_runtime_print_warn": hooks.print_warn,
            "sailfin_runtime_print_error": hooks.print_error,
            "sailfin_runtime_sleep": hooks.sleep,
        }
    result: Dict[str, Callable[..., None] | None] = {}
    for key, value in hooks.items():
        canonical = _HELPER_ALIASES.get(key, key)
        if canonical not in _HELPER_SIGNATURES:
            raise ValueError(f"unknown Stage2 runtime helper '{key}'")
        result[canonical] = value
    return result


def _create_execution_engine() -> llvm.ExecutionEngine:
    _ensure_llvm_initialised()
    target = llvm.Target.from_default_triple()
    target_machine = target.create_target_machine()
    backing_module = llvm.parse_assembly("")
    return llvm.create_mcjit_compiler(backing_module, target_machine)


class Stage2Runner:
    """Execute Stage2 LLVM outputs while enforcing capability manifests."""

    def __init__(
        self,
        lowered,
        *,
        runtime_hooks: Stage2RuntimeHooks | Mapping[str,
                                                    Callable[..., None]] | None = None,
    ) -> None:
        log_path = os.environ.get("SAILFIN_STAGE2_DEBUG_LOG")
        self._debug_log_path = log_path if log_path else None
        if self._debug_log_path:
            try:
                with open(self._debug_log_path, "w", encoding="utf-8") as handle:
                    handle.write("")
            except OSError:
                self._debug_log_path = None
        self._lowered_modules = self._normalise_lowered(lowered)
        self._string_abi = self._detect_string_abi(self._lowered_modules)
        self._use_struct_strings = self._string_abi != "cstring"
        self._debug_log(f"[stage2] string ABI: {self._string_abi}")
        self._manifest = self._build_manifest_index(self._lowered_modules)
        self._engine = None
        self._modules = None
        self._registered_helpers = []
        self._hooks = _normalise_hooks(runtime_hooks)
        self._adapter_string_buffers = []
        self._adapter_object_handles: dict[int, object] = {}
        self._function_info_cache = {}
        self._adapter_functions: dict[str, ctypes._CFuncPtr] = {}
        self._initialise_runtime_helpers()
        self._compile_ir()

    @staticmethod
    def _normalise_lowered(lowered) -> list:
        if isinstance(lowered, Sequence) and not isinstance(lowered, (bytes, str)):
            return list(lowered)
        return [lowered]

    @staticmethod
    def _detect_string_abi(lowered_modules: Sequence) -> str:
        """Infer whether the lowered modules expect C strings or structured strings."""

        cstring_pattern = re.compile(
            r"(?:getelementptr\s+(?:inbounds\s+)?i8,\s+ptr\s+%|load\s+i8,\s+ptr\s+%)",
            re.IGNORECASE,
        )
        for lowered in lowered_modules:
            module_ir = getattr(lowered, "ir", "") or ""
            if not module_ir:
                continue
            if cstring_pattern.search(module_ir):
                return "cstring"

        struct_pattern = re.compile(
            r"%(?:Stage2|Sailfin|Runtime)String(?:Ref)?\s*=\s*type\s*\{\s*ptr\s*,\s*i64",
            re.IGNORECASE,
        )
        for lowered in lowered_modules:
            module_ir = getattr(lowered, "ir", "") or ""
            if not module_ir:
                continue
            if struct_pattern.search(module_ir):
                return "struct"

        # Default to the legacy C string representation unless we see explicit
        # evidence of the structured ABI.
        return "cstring"

    def _debug_log(self, message: str) -> None:
        path = self._debug_log_path
        if not path:
            return
        try:
            with open(path, "a", encoding="utf-8") as handle:
                handle.write(message + "\n")
        except OSError:
            # Ignore log errors so diagnostics do not mask compilation issues.
            pass

    @staticmethod
    def _escape_string_for_llvm(value: str) -> str:
        escaped = []
        for ch in value:
            if ch == "\n":
                escaped.append("\\0A")
            elif ch == "\r":
                escaped.append("\\0D")
            elif ch == "\t":
                escaped.append("\\09")
            elif ch == "\"":
                escaped.append("\\22")
            elif ch == "\\":
                escaped.append("\\5C")
            else:
                escaped.append(ch)
        return "".join(escaped)

    @staticmethod
    def _render_string_constant(constant) -> str | None:
        name = getattr(constant, "name", "")
        if not name:
            return None
        if not name.startswith("@"):
            name = f"@{name}"
        content = getattr(constant, "content", "")
        byte_count = getattr(constant, "byte_count", None)
        if byte_count is None:
            byte_count = len(content.encode("utf-8"))
        escaped = Stage2Runner._escape_string_for_llvm(str(content))
        # LLVM string constants include a trailing null terminator.
        length = byte_count + 1
        return f"{name} = private unnamed_addr constant [{length} x i8] c\"{escaped}\\00\""

    @staticmethod
    def _iterate_string_constants(container) -> Iterable:
        if container is None:
            return ()
        if isinstance(container, Mapping):
            return container.values()
        if isinstance(container, Sequence) and not isinstance(container, (str, bytes, bytearray)):
            return container
        if isinstance(container, ABCIterable) and not isinstance(container, (str, bytes, bytearray)):
            return tuple(container)
        return ()

    @staticmethod
    def _collect_global_constant_definitions(lowered_modules: Iterable) -> Dict[str, tuple[str, int]]:
        definitions: Dict[str, tuple[str, int]] = {}
        referenced_enum_constants: set[str] = set()
        for lowered in lowered_modules:
            module_ir = getattr(lowered, "ir", "")
            if module_ir:
                for line in module_ir.splitlines():
                    stripped = line.strip()
                    if not stripped.startswith("@") or " = " not in stripped:
                        continue
                    if " constant " not in stripped:
                        continue
                    if " external " in stripped:
                        continue
                    name = stripped.split("=", 1)[0].strip()[1:]
                    length = Stage2Runner._parse_constant_length(stripped)
                    if length is None:
                        continue
                    definitions.setdefault(name, (line, length))
                for match in re.finditer(r"@\.enum\.[A-Za-z0-9_\.]+\.[A-Za-z0-9_]+\.[A-Za-z0-9_]+", module_ir):
                    referenced_enum_constants.add(match.group(0)[1:])

            for constant in Stage2Runner._iterate_string_constants(getattr(lowered, "string_constants", None)):
                rendered = Stage2Runner._render_string_constant(constant)
                if not rendered:
                    continue
                const_name = getattr(constant, "name", "")
                if const_name.startswith("@"):
                    const_name = const_name[1:]
                if not const_name:
                    continue
                length = Stage2Runner._parse_constant_length(rendered)
                if length is None:
                    continue
                definitions.setdefault(const_name, (rendered, length))
        for name in referenced_enum_constants:
            definition, length = Stage2Runner._synthesize_enum_variant_constant(
                name)
            definitions.setdefault(name, (definition, length))
        return definitions

    @staticmethod
    def _collect_function_signatures(lowered_modules: Iterable) -> "OrderedDict[str, str]":
        signatures: "OrderedDict[str, str]" = OrderedDict()
        for lowered in lowered_modules:
            module_ir = getattr(lowered, "ir", "")
            if not module_ir:
                continue
            for line in module_ir.splitlines():
                stripped = line.lstrip()
                if stripped.startswith("define "):
                    symbol, signature = Stage2Runner._extract_function_symbol_and_signature(
                        line)
                    if symbol and signature and symbol not in signatures:
                        signatures[symbol] = signature
                elif stripped.startswith("declare "):
                    symbol = Stage2Runner._extract_function_symbol_from_declaration(
                        line)
                    if symbol and symbol not in signatures:
                        signatures[symbol] = stripped[len("declare "):]
        return signatures

    @staticmethod
    def _collect_type_definitions(lowered_modules: Iterable) -> "OrderedDict[str, str]":
        definitions: "OrderedDict[str, str]" = OrderedDict()
        for lowered in lowered_modules:
            module_ir = getattr(lowered, "ir", "")
            if not module_ir:
                continue
            for line in module_ir.splitlines():
                stripped = line.strip()
                if not stripped.startswith("%") or " = type" not in stripped:
                    continue
                name = stripped.split("=", 1)[0].strip()[1:]
                if not name:
                    continue
                definitions.setdefault(name, stripped)
        return definitions

    @staticmethod
    def _deduplicate_type_definitions(ir_text: str) -> str:
        lines = ir_text.splitlines()
        seen: set[str] = set()
        result_lines: list[str] = []
        for line in lines:
            stripped = line.strip()
            if stripped.startswith("%") and " = type" in stripped:
                name = stripped.split("=", 1)[0].strip()[1:]
                if name:
                    if name in seen:
                        continue
                    seen.add(name)
            result_lines.append(line)
        if len(result_lines) == len(lines):
            return ir_text
        return "\n".join(result_lines)

    @staticmethod
    def _instrument_lex_ir(ir_text: str) -> str:
        candidates = [
            "define ptr @lex(",
            "define { %Token*, i64 }* @lex(",
        ]
        if not any(candidate in ir_text for candidate in candidates):
            return ir_text
        if "declare void @stage2_debug_marker(i64)" not in ir_text:
            declare_index = ir_text.find("declare")
            declaration = "declare void @stage2_debug_marker(i64)\n"
            if declare_index == -1:
                ir_text = ir_text + "\n" + declaration
            else:
                ir_text = ir_text[:declare_index] + declaration + ir_text[declare_index:]

        lex_start = -1
        lex_marker = ""
        for candidate in candidates:
            index = ir_text.find(candidate)
            if index != -1:
                lex_start = index
                lex_marker = candidate
                break
        if lex_start == -1:
            return ir_text
        lex_end = ir_text.find("\n}\n", lex_start)
        if lex_end == -1:
            return ir_text
        lex_end += 3
        lex_body = ir_text[lex_start:lex_end]
        markers: list[tuple[str, str, int]] = [
            ("block.entry", "  %l0 = alloca %LexerState", 1000),
            ("merge5", "  %t30 = load %LexerState", 1001),
            ("then6", "  %t46 = load %LexerState", 1002),
            ("loop.body9", "  %t58 = load %LexerState", 1003),
            ("merge15", "  %t90 = load %LexerState", 1004),
            ("then19", "  %t152 = load %LexerState", 1005),
            ("then21", "  %t161 = load %LexerState", 1006),
            ("loop.header23", "  %t235 = load double", 1007),
            ("merge28", "  %t209 = load %LexerState", 1008),
            ("then31", "  %t276 = load %LexerState", 1009),
            ("loop.body34", "  %t301 = load %LexerState", 1010),
        ]
        for label, first_instr, code in markers:
            pattern = f"{label}:\n{first_instr}"
            replacement = f"{label}:\n  call void @stage2_debug_marker(i64 {code})\n{first_instr}"
            lex_body = lex_body.replace(pattern, replacement, 1)

        try:
            instrumentation_path = pathlib.Path("scratch/instrumented_lex.ll")
            instrumentation_path.write_text(lex_body, encoding="utf-8")
        except Exception:
            pass

        return ir_text[:lex_start] + lex_body + ir_text[lex_end:]

    @staticmethod
    def _extract_function_symbol_and_signature(line: str) -> tuple[str | None, str | None]:
        stripped = line.lstrip()
        if not stripped.startswith("define "):
            return None, None
        brace_index = stripped.rfind("{")
        if brace_index == -1:
            return None, None
        after_define = stripped[len("define "):brace_index].strip()
        at_index = stripped.find("@")
        if at_index == -1 or at_index > brace_index:
            return None, None
        end_index = stripped.find("(", at_index)
        if end_index == -1:
            return None, None
        symbol = stripped[at_index + 1: end_index]
        if not symbol:
            return None, None
        return symbol, after_define

    @staticmethod
    def _extract_function_symbol_from_declaration(line: str) -> str | None:
        stripped = line.lstrip()
        if not stripped.startswith("declare "):
            return None
        at_index = stripped.find("@")
        if at_index == -1:
            return None
        end_index = stripped.find("(", at_index)
        if end_index == -1:
            return None
        symbol = stripped[at_index + 1: end_index]
        return symbol or None

    @staticmethod
    def _register_type_definitions(ir_text: str, registry: "OrderedDict[str, str]") -> None:
        for line in ir_text.splitlines():
            stripped = line.strip()
            if not stripped.startswith("%") or " = type" not in stripped:
                continue
            name = stripped.split("=", 1)[0].strip()[1:]
            if not name:
                continue
            registry.setdefault(name, stripped)

    @staticmethod
    def _find_type_insertion_index(lines: list[str]) -> int:
        for index, line in enumerate(lines):
            stripped = line.strip()
            if not stripped:
                continue
            if stripped.startswith("; ModuleID") or stripped.startswith("source_filename"):
                continue
            if stripped.startswith("%") and " = type" in stripped:
                continue
            return index
        return len(lines)

    @staticmethod
    def _inject_missing_type_definitions(
        ir_text: str,
        known_types: "OrderedDict[str, str]",
    ) -> str:
        if not known_types:
            return ir_text
        lines = ir_text.splitlines()
        defined: set[str] = set()
        for line in lines:
            stripped = line.strip()
            if not stripped.startswith("%") or " = type" not in stripped:
                continue
            name = stripped.split("=", 1)[0].strip()[1:]
            if name:
                defined.add(name)
        missing = [definition for name,
                   definition in known_types.items() if name not in defined]
        if not missing:
            return ir_text
        insert_index = Stage2Runner._find_type_insertion_index(lines)
        new_lines = lines[:insert_index] + missing + lines[insert_index:]
        return "\n".join(new_lines)

    @staticmethod
    def _find_declaration_insertion_index(lines: list[str]) -> int:
        insert_index = Stage2Runner._find_type_insertion_index(lines)
        while insert_index < len(lines):
            stripped = lines[insert_index].strip()
            if not stripped:
                insert_index += 1
                continue
            if stripped.startswith("declare "):
                insert_index += 1
                continue
            break
        return insert_index

    @staticmethod
    def _inject_missing_function_declarations(
        ir_text: str,
        known_signatures: "OrderedDict[str, str]",
    ) -> str:
        if not known_signatures:
            return ir_text
        lines = ir_text.splitlines()
        defined: set[str] = set()
        declared: set[str] = set()
        for line in lines:
            stripped = line.lstrip()
            if stripped.startswith("define "):
                symbol, _ = Stage2Runner._extract_function_symbol_and_signature(
                    line)
                if symbol:
                    defined.add(symbol)
            elif stripped.startswith("declare "):
                symbol = Stage2Runner._extract_function_symbol_from_declaration(
                    line)
                if symbol:
                    declared.add(symbol)
        missing: list[str] = []
        for symbol, signature in known_signatures.items():
            if symbol in defined or symbol in declared:
                continue
            if f"@{symbol}" not in ir_text:
                continue
            missing.append("declare " + signature)
        if not missing:
            return ir_text
        insert_index = Stage2Runner._find_declaration_insertion_index(lines)
        new_lines = lines[:insert_index] + missing + lines[insert_index:]
        return "\n".join(new_lines)

    @staticmethod
    def _rewrite_function_linkage(
        ir_text: str,
        defined_symbols: set[str],
        known_signatures: "OrderedDict[str, str]",
    ) -> tuple[str, list[str]]:
        """Scope duplicate function definitions to avoid LLVM collisions."""

        non_export_linkages = {
            "private",
            "internal",
            "available_externally",
            "linkonce",
            "linkonce_odr",
            "weak",
            "weak_odr",
            "extern_weak",
            "common",
        }

        duplicates: list[str] = []
        lines = ir_text.splitlines()
        changed = False

        for index, line in enumerate(lines):
            stripped = line.lstrip()
            if not stripped.startswith("define "):
                continue

            symbol, signature = Stage2Runner._extract_function_symbol_and_signature(
                line)
            if not symbol:
                continue

            if signature and symbol not in known_signatures:
                known_signatures[symbol] = signature

            if symbol not in defined_symbols:
                defined_symbols.add(symbol)
                continue

            after_define = stripped[len("define "):]
            first_token = after_define.split(
                None, 1)[0] if after_define else ""
            if first_token in non_export_linkages:
                continue

            indent = line[: len(line) - len(stripped)]
            lines[index] = indent + "define private " + after_define
            duplicates.append(symbol)
            changed = True

        if not changed:
            return ir_text, duplicates

        return "\n".join(lines), duplicates

    @staticmethod
    def _sanitize_symbol_suffix(label: str) -> str:
        characters: list[str] = []
        for ch in label:
            if ch.isalnum():
                characters.append(ch.lower())
            else:
                characters.append("_")
        suffix = "".join(characters).strip("_")
        return suffix or "module"

    @staticmethod
    def _synthesize_enum_variant_constant(name: str) -> tuple[str, int]:
        parts = [part for part in name.split(".") if part]
        variant = parts[-2] if len(parts) >= 2 else name
        content = variant
        escaped = Stage2Runner._escape_string_for_llvm(content)
        length = len(content.encode("utf-8")) + 1
        return f"@{name} = private unnamed_addr constant [{length} x i8] c\"{escaped}\\00\"", length

    @staticmethod
    def _parse_constant_length(definition: str) -> int | None:
        match = re.search(r"\[(\d+) x i8\]", definition)
        if not match:
            return None
        return int(match.group(1))

    @staticmethod
    def _extract_defined_globals(module_ir: str) -> set[str]:
        defined: set[str] = set()
        for line in module_ir.splitlines():
            stripped = line.strip()
            if not stripped.startswith("@") or " = " not in stripped:
                continue
            name = stripped.split("=", 1)[0].strip()[1:]
            defined.add(name)
        return defined

    @staticmethod
    def _inject_missing_constant_definitions(module_ir: str, *, definitions: Mapping[str, tuple[str, int]], already_defined: set[str] | None = None) -> tuple[str, set[str]]:
        if not definitions:
            return module_ir, set()
        defined = Stage2Runner._extract_defined_globals(module_ir)
        missing_lines: list[str] = []
        injected: set[str] = set()
        for name, (definition, length) in definitions.items():
            if name in defined:
                continue
            if already_defined is not None and name in already_defined:
                if f"@{name}" not in module_ir:
                    missing_lines.append(
                        f"@{name} = external constant [{length} x i8]")
                    injected.add(name)
                continue
            if f"@{name}" not in module_ir:
                continue
            missing_lines.append(definition)
            injected.add(name)
        if not missing_lines:
            return module_ir, set()
        patched = module_ir.rstrip() + "\n" + "\n".join(missing_lines) + "\n"
        return patched, injected

    @staticmethod
    def _build_manifest_index(lowered_modules: Iterable) -> Dict[str, Sequence[str]]:
        index: Dict[str, Sequence[str]] = {}
        for lowered in lowered_modules:
            manifest = getattr(lowered, "capability_manifest", None)
            if manifest is None:
                continue
            entries = getattr(manifest, "entries", ()) or ()
            for entry in entries:
                symbol = getattr(entry, "symbol", "")
                effects = list(getattr(entry, "effects", ()))
                if symbol and symbol not in index:
                    index[symbol] = effects
        return index

    def _lookup_function_return(self, symbol: str) -> tuple[object, str] | None:
        if symbol in self._function_info_cache:
            return self._function_info_cache[symbol]
        modules = self._modules or ()
        for module in modules:
            try:
                text = str(module)
            except Exception:
                continue
            for line in text.splitlines():
                stripped = line.lstrip()
                if not stripped.startswith("define "):
                    continue
                if f"@{symbol}" not in stripped:
                    continue
                after_define = stripped[len("define "):]
                at_index = after_define.find("@")
                if at_index == -1:
                    continue
                segment = after_define[:at_index].strip()
                if not segment:
                    continue
                if "{" in segment:
                    brace_index = segment.find("{")
                    return_type = segment[brace_index:].strip()
                else:
                    tokens = segment.split()
                    if not tokens:
                        continue
                    return_type = tokens[-1]
                info = (module, return_type)
                self._function_info_cache[symbol] = info
                return info
        self._function_info_cache[symbol] = None
        return None

    def _resolve_struct_type(self, module, return_type: str):
        if not return_type:
            return None
        type_name = return_type.strip()
        if not type_name:
            return None
        type_ref = None
        if type_name.startswith("%"):
            lookup = type_name[1:].strip()
            candidates = [lookup]
            if lookup.startswith("struct."):
                candidates.append(lookup.split("struct.", 1)[1])
            module_candidates: list = []
            if module is not None:
                module_candidates.append(module)
            for mod in self._modules or ():
                if mod is module:
                    continue
                module_candidates.append(mod)
            for candidate in candidates:
                for mod in module_candidates:
                    try:
                        type_ref = mod.get_struct_type(candidate)
                    except Exception:
                        type_ref = None
                    if type_ref is not None:
                        break
                if type_ref is not None:
                    break
        elif type_name.startswith("{"):
            try:
                tmp_module = llvm.parse_assembly(
                    f"%__sret_tmp = type {type_name}\n")
                type_ref = tmp_module.get_struct_type("__sret_tmp")
            except Exception:
                type_ref = None
        return type_ref

    def _compute_type_layout(self, type_ref) -> tuple[int, int]:
        pointer_size = ctypes.sizeof(ctypes.c_void_p)
        abi_size = 0
        abi_alignment = pointer_size
        target_data = getattr(self._engine, "target_data", None)
        if target_data is not None and type_ref is not None:
            try:
                abi_size = int(target_data.get_abi_size(type_ref))
            except Exception:
                abi_size = 0
            try:
                abi_alignment = int(target_data.get_abi_alignment(type_ref))
            except Exception:
                abi_alignment = pointer_size
        if abi_alignment <= 0:
            abi_alignment = pointer_size
        return abi_size, abi_alignment

    def _allocate_sret_buffer(self, module, return_type: str) -> tuple[int, ctypes.Array, int]:
        pointer_size = ctypes.sizeof(ctypes.c_void_p)
        type_ref = self._resolve_struct_type(module, return_type)
        abi_size, abi_alignment = self._compute_type_layout(type_ref)
        struct_size = pointer_size
        alignment = pointer_size
        if abi_size:
            struct_size = max(struct_size, abi_size)
        if abi_alignment:
            alignment = max(alignment, abi_alignment)
        if struct_size <= 0:
            struct_size = pointer_size
        if alignment <= 0:
            alignment = pointer_size
        raw_buffer = ctypes.create_string_buffer(struct_size + alignment)
        raw_address = ctypes.addressof(raw_buffer)
        aligned_address = (raw_address + (alignment - 1)) & ~(alignment - 1)
        self._adapter_string_buffers.append(raw_buffer)
        return aligned_address, raw_buffer, struct_size

    @staticmethod
    def _extract_sret_result(address: int, size: int, restype):
        if restype is None:
            return None
        if restype is ctypes.c_void_p:
            return ctypes.c_void_p.from_address(address).value
        from_address = getattr(restype, "from_address", None)
        if callable(from_address):
            try:
                instance = from_address(address)
                return getattr(instance, "value", instance)
            except Exception:
                pass
        return ctypes.string_at(address, size)

    @staticmethod
    def _is_aggregate_return_type(return_type: str | None) -> bool:
        if not return_type:
            return False
        stripped = return_type.strip()
        if not stripped:
            return False
        if stripped.endswith("*"):
            return False
        if stripped[0] in {"%", "{", "["}:
            return True
        return False

    def _initialise_runtime_helpers(self) -> None:
        for symbol, (effect, arg_types) in _HELPER_SIGNATURES.items():
            delegate = self._hooks.get(symbol)
            cfunc = self._make_helper(symbol, effect, arg_types, delegate)
            address = ctypes.cast(cfunc, ctypes.c_void_p).value or 0
            self._debug_log(
                f"[stage2] register helper {symbol}: addr=0x{int(address):x}"
            )
            llvm.add_symbol(symbol, address)
            self._registered_helpers.append(cfunc)
            self._adapter_functions[symbol] = cfunc

        # Register capability adapters
        for symbol, (effect, arg_types, return_type) in _ADAPTER_SIGNATURES.items():
            cfunc = self._make_adapter(symbol, effect, arg_types, return_type)
            address = ctypes.cast(cfunc, ctypes.c_void_p).value or 0
            self._debug_log(
                f"[stage2] register adapter {symbol}: addr=0x{int(address):x}"
            )
            llvm.add_symbol(symbol, address)
            self._registered_helpers.append(cfunc)
            self._adapter_functions[symbol] = cfunc

        libc_funcs = _ensure_libc_symbols(self._debug_log)
        malloc_func = libc_funcs.get("malloc")
        if malloc_func is not None:
            malloc_addr = _LIBC_SYMBOL_ADDRESSES.get("malloc", 0)
            self._debug_log(
                f"[stage2] register adapter malloc: addr=0x{int(malloc_addr):x}"
            )
            self._adapter_functions["malloc"] = malloc_func
        else:  # pragma: no cover - diagnostics only
            self._debug_log("[stage2] libc malloc unavailable")

        free_func = libc_funcs.get("free")
        if free_func is not None:
            free_addr = _LIBC_SYMBOL_ADDRESSES.get("free", 0)
            self._debug_log(
                f"[stage2] register adapter free: addr=0x{int(free_addr):x}"
            )
            self._adapter_functions["free"] = free_func
        else:  # pragma: no cover - diagnostics only
            self._debug_log("[stage2] libc free unavailable")

    def _make_helper(
        self,
        symbol: str,
        effect: str | Sequence[str] | None,
        arg_types: Sequence[type],
        delegate: Callable[..., None] | None,
    ):
        def _require(effect_name: str) -> None:
            grant = _ACTIVE_GRANT.get()
            if grant is None:
                raise PermissionError(
                    f"{symbol} invoked without an active capability grant")
            grant.require(effect_name)

        def _require_effects() -> None:
            if not effect:
                return
            targets = (effect,) if isinstance(effect, str) else tuple(effect)
            for effect_name in targets:
                _require(effect_name)
        cfunc_type = ctypes.CFUNCTYPE(None, *arg_types)

        def _wrapper(*args) -> None:
            try:
                if effect:
                    targets = (effect,) if isinstance(
                        effect, str) else tuple(effect)
                    for effect_name in targets:
                        _require(effect_name)
                if delegate is not None:
                    delegate(*args)
            except Exception as exc:  # pragma: no cover - propagated after invocation
                if _LAST_RUNTIME_ERROR.get() is None:
                    _LAST_RUNTIME_ERROR.set(exc)

        return cfunc_type(_wrapper)

    def _make_adapter(
        self,
        symbol: str,
        effect: str | Sequence[str] | None,
        arg_types: Sequence[type],
        return_type: type | None,
    ):
        """Create an adapter bridge that routes LLVM ABI calls to Python runtime helpers."""
        def _require(effect_name: str) -> None:
            grant = _ACTIVE_GRANT.get()
            if grant is None:
                raise PermissionError(
                    f"{symbol} invoked without an active capability grant")
            grant.require(effect_name)

        def _require_effects() -> None:
            if not effect:
                return
            targets = (effect,) if isinstance(effect, str) else tuple(effect)
            for effect_name in targets:
                _require(effect_name)

        def _default_return():
            if return_type is None:
                return None
            if return_type is ctypes.c_void_p:
                return 0
            if return_type is ctypes.c_bool:
                return False
            if return_type is ctypes.c_double:
                return 0.0
            if return_type is ctypes.c_longlong:
                return 0
            try:
                return return_type()
            except Exception:
                return 0

        def _store_handle(value: object | None) -> int:
            if value is None:
                return 0
            handle = id(value)
            self._adapter_object_handles[handle] = value
            stored = ctypes.c_void_p(handle).value
            return 0 if stored is None else int(stored)

        def _load_handle(ptr: int | ctypes.c_void_p) -> object | None:
            if isinstance(ptr, ctypes.c_void_p):
                address = int(ptr.value or 0)
            else:
                address = int(ptr or 0)
            if address == 0:
                return None
            return self._adapter_object_handles.get(address)

        use_struct_strings = getattr(self, "_use_struct_strings", True)
        Stage2StringType: type[ctypes.Structure] | None = None
        if use_struct_strings:
            class _Stage2String(ctypes.Structure):
                _fields_ = [
                    ("data", ctypes.c_void_p),
                    ("length", ctypes.c_longlong),
                ]

            Stage2StringType = _Stage2String

        # Helper to normalise void* arguments into plain integers
        def _normalise_ptr(value: ctypes.c_void_p | int | None) -> int:
            if isinstance(value, ctypes.c_void_p):
                raw = value.value
            else:
                raw = value
            return 0 if raw is None else int(raw)

        # Helper to convert c_void_p to Python string
        def _ptr_to_str(ptr: ctypes.c_void_p | int | None) -> str:
            address = _normalise_ptr(ptr)
            if address == 0:
                return ""

            if Stage2StringType is not None:
                try:
                    struct_ptr = ctypes.cast(
                        ctypes.c_void_p(address), ctypes.POINTER(Stage2StringType)
                    )
                    struct_value = struct_ptr.contents
                except (ValueError, OSError, ctypes.ArgumentError):
                    struct_value = None

                if struct_value is not None:
                    data_address = _normalise_ptr(struct_value.data)
                    length = int(struct_value.length)
                    if 0 <= length <= 1 << 30 and data_address != 0:
                        try:
                            raw_bytes = ctypes.string_at(data_address, length)
                            return raw_bytes.decode("utf-8")
                        except (ValueError, OSError):
                            pass

            # Fallback for legacy raw C strings (pre-struct representation)
            c_string = ctypes.cast(ctypes.c_void_p(
                address), ctypes.c_char_p).value
            return c_string.decode("utf-8") if c_string is not None else ""

        # Storage for string buffers to keep them alive (stored on runner instance)
        # Helper to convert Python string to pointer integer
        def _str_to_ptr(s: str) -> int:
            encoded = s.encode("utf-8")
            buf = ctypes.create_string_buffer(encoded + b"\0")
            self._adapter_string_buffers.append(buf)  # Keep buffer alive

            data_address = ctypes.cast(buf, ctypes.c_void_p).value
            data_int = 0 if data_address is None else int(data_address)
            if Stage2StringType is None:
                return data_int

            stage2_string = Stage2StringType()
            stage2_string.data = ctypes.c_void_p(data_int)
            stage2_string.length = len(encoded)

            stage2_string_ptr = ctypes.pointer(stage2_string)
            # Keep both the structure and the pointer alive for the duration of the runner
            self._adapter_string_buffers.append(stage2_string)
            self._adapter_string_buffers.append(stage2_string_ptr)

            struct_address = ctypes.cast(
                stage2_string_ptr, ctypes.c_void_p).value
            return 0 if struct_address is None else int(struct_address)

        class _StringArray(ctypes.Structure):
            _fields_ = [
                ("data", ctypes.POINTER(ctypes.c_void_p)),
                ("length", ctypes.c_longlong),
            ]

        def _array_to_list(array_ptr: ctypes.c_void_p) -> list[str]:
            address = _normalise_ptr(array_ptr)
            if address == 0:
                return []
            array = ctypes.cast(
                ctypes.c_void_p(address), ctypes.POINTER(_StringArray)
            ).contents
            length = int(array.length)
            if length <= 0 or not array.data:
                return []
            return [_ptr_to_str(array.data[i]) for i in range(length)]

        def _array_to_handles(array_ptr: ctypes.c_void_p) -> list[int]:
            address = _normalise_ptr(array_ptr)
            if address == 0:
                return []
            array = ctypes.cast(
                ctypes.c_void_p(address), ctypes.POINTER(_StringArray)
            ).contents
            length = int(array.length)
            if length <= 0 or not array.data:
                return []
            return [int(array.data[i]) for i in range(length)]

        def _list_to_array(values: list[str]) -> int:
            length = len(values)
            data = (ctypes.c_void_p * length)()
            for index, value in enumerate(values):
                data[index] = ctypes.c_void_p(_str_to_ptr(value))
            array_struct = _StringArray()
            array_struct.data = ctypes.cast(
                data, ctypes.POINTER(ctypes.c_void_p)
            )
            array_struct.length = length
            self._adapter_string_buffers.append(data)
            self._adapter_string_buffers.append(array_struct)
            array_ptr = ctypes.cast(
                ctypes.pointer(array_struct), ctypes.c_void_p).value
            return 0 if array_ptr is None else int(array_ptr)

        def _handles_to_array(handles: Sequence[int]) -> int:
            length = len(handles)
            data = (ctypes.c_void_p * length)()
            for index, handle in enumerate(handles):
                data[index] = ctypes.c_void_p(handle)
            array_struct = _StringArray()
            array_struct.data = ctypes.cast(
                data, ctypes.POINTER(ctypes.c_void_p)
            )
            array_struct.length = length
            self._adapter_string_buffers.append(data)
            self._adapter_string_buffers.append(array_struct)
            array_ptr = ctypes.cast(
                ctypes.pointer(array_struct), ctypes.c_void_p).value
            return 0 if array_ptr is None else int(array_ptr)

        def _build_fallback():
            cfunc_type = (
                ctypes.CFUNCTYPE(return_type, *arg_types)
                if return_type is not None
                else ctypes.CFUNCTYPE(None, *arg_types)
            )

            def _unimplemented(*_args):
                try:
                    _require_effects()
                    raise NotImplementedError(
                        f"adapter for {symbol} not implemented"
                    )
                except Exception as exc:  # pragma: no cover - surfaced after call
                    if _LAST_RUNTIME_ERROR.get() is None:
                        _LAST_RUNTIME_ERROR.set(exc)
                    return _default_return()

            return cfunc_type(_unimplemented)

        # Capability helpers
        if symbol == "sailfin_runtime_create_capability_grant":
            cfunc_type = ctypes.CFUNCTYPE(ctypes.c_void_p, ctypes.c_void_p)

            def _create_capability_grant(effects_ptr: ctypes.c_void_p) -> int:
                try:
                    effect_names = _array_to_list(effects_ptr)
                    grant = runtime.create_capability_grant(effect_names)
                    return _store_handle(grant)
                except Exception as exc:
                    if _LAST_RUNTIME_ERROR.get() is None:
                        _LAST_RUNTIME_ERROR.set(exc)
                    return 0

            return cfunc_type(_create_capability_grant)

        elif symbol == "sailfin_runtime_create_filesystem_bridge":
            cfunc_type = ctypes.CFUNCTYPE(ctypes.c_void_p, ctypes.c_void_p)

            def _create_filesystem_bridge(grant_ptr: ctypes.c_void_p) -> int:
                try:
                    _require_effects()
                    grant = _load_handle(grant_ptr)
                    if grant is None:
                        raise ValueError(
                            "filesystem bridge requires capability grant handle"
                        )
                    bridge = runtime.create_filesystem_bridge(
                        cast(runtime.CapabilityGrant, grant)
                    )
                    return _store_handle(bridge)
                except Exception as exc:
                    if _LAST_RUNTIME_ERROR.get() is None:
                        _LAST_RUNTIME_ERROR.set(exc)
                    return 0

            return cfunc_type(_create_filesystem_bridge)

        elif symbol == "sailfin_runtime_create_http_bridge":
            cfunc_type = ctypes.CFUNCTYPE(ctypes.c_void_p, ctypes.c_void_p)

            def _create_http_bridge(grant_ptr: ctypes.c_void_p) -> int:
                try:
                    _require_effects()
                    grant = _load_handle(grant_ptr)
                    if grant is None:
                        raise ValueError(
                            "HTTP bridge requires capability grant handle"
                        )
                    bridge = runtime.create_http_bridge(
                        cast(runtime.CapabilityGrant, grant)
                    )
                    return _store_handle(bridge)
                except Exception as exc:
                    if _LAST_RUNTIME_ERROR.get() is None:
                        _LAST_RUNTIME_ERROR.set(exc)
                    return 0

            return cfunc_type(_create_http_bridge)

        elif symbol == "sailfin_runtime_create_model_bridge":
            cfunc_type = ctypes.CFUNCTYPE(ctypes.c_void_p, ctypes.c_void_p)

            def _create_model_bridge(grant_ptr: ctypes.c_void_p) -> int:
                try:
                    _require_effects()
                    grant = _load_handle(grant_ptr)
                    if grant is None:
                        raise ValueError(
                            "model bridge requires capability grant handle"
                        )
                    bridge = runtime.create_model_bridge(
                        cast(runtime.CapabilityGrant, grant)
                    )
                    return _store_handle(bridge)
                except Exception as exc:
                    if _LAST_RUNTIME_ERROR.get() is None:
                        _LAST_RUNTIME_ERROR.set(exc)
                    return 0

            return cfunc_type(_create_model_bridge)

        # Filesystem adapters
        elif symbol == "sailfin_adapter_fs_read_file":
            cfunc_type = ctypes.CFUNCTYPE(ctypes.c_void_p, ctypes.c_void_p)

            def _fs_read_file(path_ptr: ctypes.c_void_p) -> int:
                try:
                    _require_effects()
                    path = _ptr_to_str(path_ptr)
                    contents = runtime.fs.readFile(path)
                    return _str_to_ptr(contents)
                except Exception as exc:
                    if _LAST_RUNTIME_ERROR.get() is None:
                        _LAST_RUNTIME_ERROR.set(exc)
                    return 0

            return cfunc_type(_fs_read_file)

        elif symbol == "sailfin_adapter_fs_write_file":
            cfunc_type = ctypes.CFUNCTYPE(
                None, ctypes.c_void_p, ctypes.c_void_p)

            def _fs_write_file(path_ptr: ctypes.c_void_p, contents_ptr: ctypes.c_void_p) -> None:
                try:
                    _require_effects()
                    path = _ptr_to_str(path_ptr)
                    contents = _ptr_to_str(contents_ptr)
                    runtime.fs.writeFile(path, contents)
                except Exception as exc:
                    if _LAST_RUNTIME_ERROR.get() is None:
                        _LAST_RUNTIME_ERROR.set(exc)

            return cfunc_type(_fs_write_file)

        elif symbol == "sailfin_adapter_fs_list_directory":
            cfunc_type = ctypes.CFUNCTYPE(ctypes.c_void_p, ctypes.c_void_p)

            def _fs_list_directory(path_ptr: ctypes.c_void_p) -> int:
                try:
                    _require_effects()
                    path = _ptr_to_str(path_ptr)
                    entries = runtime.fs.listDirectory(path or None)
                    try:
                        import json
                        result = json.dumps(entries)
                    except Exception:  # pragma: no cover - fall back to comma join on JSON issues.
                        result = "[" + \
                            ", ".join(f'\"{name}\"' for name in entries) + "]"
                    return _str_to_ptr(result)
                except Exception as exc:
                    if _LAST_RUNTIME_ERROR.get() is None:
                        _LAST_RUNTIME_ERROR.set(exc)
                    return 0

            return cfunc_type(_fs_list_directory)

        elif symbol == "sailfin_adapter_fs_delete_file":
            cfunc_type = ctypes.CFUNCTYPE(ctypes.c_bool, ctypes.c_void_p)

            def _fs_delete_file(path_ptr: ctypes.c_void_p) -> bool:
                try:
                    _require_effects()
                    path = _ptr_to_str(path_ptr)
                    return bool(runtime.fs.deleteFile(path))
                except Exception as exc:
                    if _LAST_RUNTIME_ERROR.get() is None:
                        _LAST_RUNTIME_ERROR.set(exc)
                    return False

            return cfunc_type(_fs_delete_file)

        elif symbol == "sailfin_adapter_fs_create_directory":
            cfunc_type = ctypes.CFUNCTYPE(
                ctypes.c_bool, ctypes.c_void_p, ctypes.c_bool)

            def _fs_create_directory(path_ptr: ctypes.c_void_p, exist_ok: ctypes.c_bool) -> bool:
                try:
                    _require_effects()
                    path = _ptr_to_str(path_ptr)
                    return bool(runtime.fs.createDirectory(path, exist_ok=bool(exist_ok)))
                except Exception as exc:
                    if _LAST_RUNTIME_ERROR.get() is None:
                        _LAST_RUNTIME_ERROR.set(exc)
                    return False

            return cfunc_type(_fs_create_directory)

        elif symbol == "sailfin_intrinsic_fs_exists":
            cfunc_type = ctypes.CFUNCTYPE(ctypes.c_bool, ctypes.c_void_p)

            def _fs_exists(path_ptr: ctypes.c_void_p) -> bool:
                try:
                    _require_effects()
                    path = _ptr_to_str(path_ptr)
                    return bool(runtime.fs.exists(path))
                except Exception as exc:
                    if _LAST_RUNTIME_ERROR.get() is None:
                        _LAST_RUNTIME_ERROR.set(exc)
                    return False

            return cfunc_type(_fs_exists)

        elif symbol == "sailfin_runtime_string_length":
            cfunc_type = ctypes.CFUNCTYPE(ctypes.c_longlong, ctypes.c_void_p)

            def _string_length(value_ptr: ctypes.c_void_p) -> int:
                try:
                    address = int(value_ptr.value or 0) if isinstance(
                        value_ptr, ctypes.c_void_p) else int(value_ptr or 0)
                    self._debug_log(
                        f"[stage2] runtime string_length ptr=0x{address:x}")
                    _require_effects()
                    text = _ptr_to_str(value_ptr)
                    return len(text)
                except Exception as exc:
                    if _LAST_RUNTIME_ERROR.get() is None:
                        _LAST_RUNTIME_ERROR.set(exc)
                    return 0

            return cfunc_type(_string_length)

        elif symbol == "sailfin_runtime_substring":
            cfunc_type = ctypes.CFUNCTYPE(
                ctypes.c_void_p, ctypes.c_void_p, ctypes.c_longlong, ctypes.c_longlong
            )

            def _substring(text_ptr: ctypes.c_void_p, start: ctypes.c_longlong, end: ctypes.c_longlong) -> int:
                try:
                    _require_effects()
                    text = _ptr_to_str(text_ptr)
                    result = runtime.substring(text, int(start), int(end))
                    return _str_to_ptr(result)
                except Exception as exc:
                    if _LAST_RUNTIME_ERROR.get() is None:
                        _LAST_RUNTIME_ERROR.set(exc)
                    return 0

            return cfunc_type(_substring)

        elif symbol == "sailfin_runtime_string_concat":
            cfunc_type = ctypes.CFUNCTYPE(
                ctypes.c_void_p, ctypes.c_void_p, ctypes.c_void_p)

            def _string_concat(first_ptr: ctypes.c_void_p, second_ptr: ctypes.c_void_p) -> int:
                try:
                    _require_effects()
                    first = _ptr_to_str(first_ptr)
                    second = _ptr_to_str(second_ptr)
                    return _str_to_ptr(first + second)
                except Exception as exc:
                    if _LAST_RUNTIME_ERROR.get() is None:
                        _LAST_RUNTIME_ERROR.set(exc)
                    return 0

            return cfunc_type(_string_concat)

        elif symbol == "sailfin_runtime_concat":
            cfunc_type = ctypes.CFUNCTYPE(
                ctypes.c_void_p, ctypes.c_void_p, ctypes.c_void_p)

            def _concat(first_ptr: ctypes.c_void_p, second_ptr: ctypes.c_void_p) -> int:
                try:
                    left = _array_to_handles(first_ptr)
                    right = _array_to_handles(second_ptr)
                    first_addr = int(first_ptr.value or 0) if isinstance(
                        first_ptr, ctypes.c_void_p) else int(first_ptr or 0)
                    second_addr = int(second_ptr.value or 0) if isinstance(
                        second_ptr, ctypes.c_void_p) else int(second_ptr or 0)
                    self._debug_log(
                        f"[stage2] runtime concat first=0x{first_addr:x} ({len(left)} handles) second=0x{second_addr:x} ({len(right)} handles)"
                    )
                    if not left and not right:
                        result = _handles_to_array(())
                        self._debug_log(
                            f"[stage2] runtime concat result=0x{result:x} length=0 (empty inputs)"
                        )
                        return result
                    merged: list[int] = []
                    if left:
                        merged.extend(left)
                    if right:
                        merged.extend(right)
                    result = _handles_to_array(merged)
                    self._debug_log(
                        f"[stage2] runtime concat result=0x{result:x} length={len(merged)}"
                    )
                    return result
                except Exception as exc:
                    if _LAST_RUNTIME_ERROR.get() is None:
                        _LAST_RUNTIME_ERROR.set(exc)
                    return 0

            return cfunc_type(_concat)

        elif symbol == "sailfin_runtime_append_string":
            cfunc_type = ctypes.CFUNCTYPE(
                ctypes.c_void_p, ctypes.c_void_p, ctypes.c_void_p)

            def _append_string(array_ptr: ctypes.c_void_p, value_ptr: ctypes.c_void_p) -> int:
                try:
                    existing = _array_to_list(array_ptr)
                    appended = list(existing or [])
                    appended.append(_ptr_to_str(value_ptr))
                    return _list_to_array(appended)
                except Exception as exc:
                    if _LAST_RUNTIME_ERROR.get() is None:
                        _LAST_RUNTIME_ERROR.set(exc)
                    return 0

            return cfunc_type(_append_string)

        elif symbol == "sailfin_runtime_bounds_check":
            cfunc_type = ctypes.CFUNCTYPE(
                None, ctypes.c_longlong, ctypes.c_longlong)

            def _bounds_check(index: ctypes.c_longlong, length: ctypes.c_longlong) -> None:
                try:
                    runtime.bounds_check(int(index), int(length))
                except Exception as exc:
                    if _LAST_RUNTIME_ERROR.get() is None:
                        _LAST_RUNTIME_ERROR.set(exc)

            return cfunc_type(_bounds_check)

        elif symbol == "sailfin_runtime_char_code":
            cfunc_type = ctypes.CFUNCTYPE(ctypes.c_double, ctypes.c_void_p)

            def _runtime_char_code(value_ptr: ctypes.c_void_p) -> float:
                try:
                    _require_effects()
                    text = _ptr_to_str(value_ptr)
                    ch = text[0] if text else "\0"
                    return float(runtime.char_code(ch))
                except Exception as exc:
                    if _LAST_RUNTIME_ERROR.get() is None:
                        _LAST_RUNTIME_ERROR.set(exc)
                    return 0.0

            return cfunc_type(_runtime_char_code)

        elif symbol == "sailfin_runtime_is_decimal_digit":
            cfunc_type = ctypes.CFUNCTYPE(ctypes.c_bool, ctypes.c_byte)

            def _is_decimal_digit(value: ctypes.c_byte) -> bool:
                try:
                    code = int(value) & 0xFF
                    ch = chr(code)
                    return '0' <= ch <= '9'
                except Exception as exc:
                    if _LAST_RUNTIME_ERROR.get() is None:
                        _LAST_RUNTIME_ERROR.set(exc)
                    return False

            return cfunc_type(_is_decimal_digit)

        elif symbol == "sailfin_runtime_grapheme_count":
            cfunc_type = ctypes.CFUNCTYPE(ctypes.c_double, ctypes.c_void_p)

            def _grapheme_count(text_ptr: ctypes.c_void_p) -> float:
                try:
                    _require_effects()
                    text = _ptr_to_str(text_ptr)
                    return float(runtime.grapheme_count(text))
                except Exception as exc:
                    if _LAST_RUNTIME_ERROR.get() is None:
                        _LAST_RUNTIME_ERROR.set(exc)
                    return 0.0

            return cfunc_type(_grapheme_count)

        elif symbol == "sailfin_runtime_grapheme_at":
            cfunc_type = ctypes.CFUNCTYPE(
                ctypes.c_void_p, ctypes.c_void_p, ctypes.c_double)

            def _grapheme_at(text_ptr: ctypes.c_void_p, index: ctypes.c_double) -> int:
                try:
                    _require_effects()
                    text = _ptr_to_str(text_ptr)
                    position = int(index)
                    result = runtime.grapheme_at(text, position)
                    return _str_to_ptr(result or "")
                except Exception as exc:
                    if _LAST_RUNTIME_ERROR.get() is None:
                        _LAST_RUNTIME_ERROR.set(exc)
                    return 0

            return cfunc_type(_grapheme_at)

        elif symbol == "sailfin_runtime_is_whitespace_char":
            cfunc_type = ctypes.CFUNCTYPE(ctypes.c_bool, ctypes.c_byte)

            def _is_whitespace_char(value: ctypes.c_byte) -> bool:
                try:
                    code = int(value) & 0xFF
                    ch = chr(code)
                    # Match ASCII whitespace plus newline and carriage return.
                    return ch.isspace()
                except Exception as exc:
                    if _LAST_RUNTIME_ERROR.get() is None:
                        _LAST_RUNTIME_ERROR.set(exc)
                    return False

            return cfunc_type(_is_whitespace_char)

        # HTTP adapters
        elif symbol == "sailfin_adapter_http_get":
            cfunc_type = ctypes.CFUNCTYPE(ctypes.c_void_p, ctypes.c_void_p)

            def _http_get(url_ptr: ctypes.c_void_p) -> int:
                try:
                    _require_effects()
                    url = _ptr_to_str(url_ptr)
                    # Use the mock HTTP module
                    import asyncio
                    response = asyncio.run(runtime.http.get(url))
                    # Return JSON representation
                    import json
                    result = json.dumps(
                        {"status": response.status, "body": response.body})
                    return _str_to_ptr(result)
                except Exception as exc:
                    if _LAST_RUNTIME_ERROR.get() is None:
                        _LAST_RUNTIME_ERROR.set(exc)
                    return 0

            return cfunc_type(_http_get)

        elif symbol == "sailfin_adapter_http_post":
            cfunc_type = ctypes.CFUNCTYPE(
                ctypes.c_void_p, ctypes.c_void_p, ctypes.c_void_p)

            def _http_post(url_ptr: ctypes.c_void_p, body_ptr: ctypes.c_void_p) -> int:
                try:
                    _require_effects()
                    url = _ptr_to_str(url_ptr)
                    body = _ptr_to_str(body_ptr)
                    # Mock HTTP POST - just echo back
                    import json
                    result = json.dumps(
                        {"status": 200, "body": f"Posted to {url}: {body}"})
                    return _str_to_ptr(result)
                except Exception as exc:
                    if _LAST_RUNTIME_ERROR.get() is None:
                        _LAST_RUNTIME_ERROR.set(exc)
                    return 0

            return cfunc_type(_http_post)

        # Model adapter
        elif symbol == "sailfin_adapter_model_invoke_with_prompt":
            cfunc_type = ctypes.CFUNCTYPE(
                ctypes.c_void_p, ctypes.c_void_p, ctypes.c_void_p)

            def _model_invoke(prompt_ptr: ctypes.c_void_p, options_ptr: ctypes.c_void_p) -> int:
                try:
                    _require_effects()
                    prompt = _ptr_to_str(prompt_ptr)
                    # Mock model invocation
                    result = f"[mock:model] Response to: {prompt}"
                    return _str_to_ptr(result)
                except Exception as exc:
                    if _LAST_RUNTIME_ERROR.get() is None:
                        _LAST_RUNTIME_ERROR.set(exc)
                    return 0

            return cfunc_type(_model_invoke)

        # Serve adapters
        elif symbol == "sailfin_adapter_serve_start":
            cfunc_type = ctypes.CFUNCTYPE(
                None, ctypes.c_void_p, ctypes.c_void_p)

            def _serve_start(handler_ptr: ctypes.c_void_p, config_ptr: ctypes.c_void_p) -> None:
                try:
                    _require_effects()
                    # Mock serve start
                    runtime.console.info("[serve] mock server started")
                except Exception as exc:
                    if _LAST_RUNTIME_ERROR.get() is None:
                        _LAST_RUNTIME_ERROR.set(exc)

            return cfunc_type(_serve_start)

        elif symbol == "sailfin_adapter_serve_handler_dispatch":
            cfunc_type = ctypes.CFUNCTYPE(
                ctypes.c_void_p, ctypes.c_void_p, ctypes.c_void_p)

            def _serve_dispatch(handler_ptr: ctypes.c_void_p, request_ptr: ctypes.c_void_p) -> int:
                try:
                    _require_effects()
                    # Mock handler dispatch
                    result = '{"status": 200, "body": "OK"}'
                    return _str_to_ptr(result)
                except Exception as exc:
                    if _LAST_RUNTIME_ERROR.get() is None:
                        _LAST_RUNTIME_ERROR.set(exc)
                    return 0

            return cfunc_type(_serve_dispatch)

        # Concurrency adapters
        elif symbol == "sailfin_adapter_spawn_task":
            cfunc_type = ctypes.CFUNCTYPE(
                None, ctypes.c_void_p, ctypes.c_void_p)

            def _spawn_task(task_ptr: ctypes.c_void_p, name_ptr: ctypes.c_void_p) -> None:
                try:
                    _require_effects()
                    # Mock spawn
                    name = _ptr_to_str(name_ptr) if name_ptr else ""
                    runtime.console.info(
                        f"[spawn] task spawned: {name if name else '<anonymous>'}")
                except Exception as exc:
                    if _LAST_RUNTIME_ERROR.get() is None:
                        _LAST_RUNTIME_ERROR.set(exc)

            return cfunc_type(_spawn_task)

        elif symbol == "sailfin_adapter_channel_create":
            cfunc_type = ctypes.CFUNCTYPE(ctypes.c_void_p, ctypes.c_longlong)

            def _channel_create(capacity: ctypes.c_longlong) -> int:
                try:
                    _require_effects()
                    capacity_value = int(capacity)
                    ch = runtime.channel(
                        capacity_value if capacity_value > 0 else None)
                    # Return a pointer to the channel (simplified - real implementation needs proper object management)
                    return id(ch)
                except Exception as exc:
                    if _LAST_RUNTIME_ERROR.get() is None:
                        _LAST_RUNTIME_ERROR.set(exc)
                    return 0

            return cfunc_type(_channel_create)

        elif symbol == "sailfin_adapter_channel_send":
            cfunc_type = ctypes.CFUNCTYPE(
                None, ctypes.c_void_p, ctypes.c_void_p)

            def _channel_send(channel_ptr: ctypes.c_void_p, value_ptr: ctypes.c_void_p) -> None:
                try:
                    _require_effects()
                    # Mock channel send
                    runtime.console.info("[channel] value sent")
                except Exception as exc:
                    if _LAST_RUNTIME_ERROR.get() is None:
                        _LAST_RUNTIME_ERROR.set(exc)

            return cfunc_type(_channel_send)

        elif symbol == "sailfin_adapter_channel_receive":
            cfunc_type = ctypes.CFUNCTYPE(ctypes.c_void_p, ctypes.c_void_p)

            def _channel_receive(channel_ptr: ctypes.c_void_p) -> int:
                try:
                    _require_effects()
                    # Mock channel receive
                    result = "mock_value"
                    return _str_to_ptr(result)
                except Exception as exc:
                    if _LAST_RUNTIME_ERROR.get() is None:
                        _LAST_RUNTIME_ERROR.set(exc)
                    return 0

            return cfunc_type(_channel_receive)

        elif symbol == "char_code":
            cfunc_type = ctypes.CFUNCTYPE(ctypes.c_double, ctypes.c_void_p)

            def _char_code(value_ptr: ctypes.c_void_p) -> float:
                try:
                    address = int(value_ptr.value or 0) if isinstance(
                        value_ptr, ctypes.c_void_p) else int(value_ptr or 0)
                    self._debug_log(
                        f"[stage2] runtime char_code ptr=0x{address:x}")
                    _require_effects()
                    text = _ptr_to_str(value_ptr)
                    ch = text[0] if text else "\0"
                    return float(runtime.char_code(ch))
                except Exception as exc:
                    if _LAST_RUNTIME_ERROR.get() is None:
                        _LAST_RUNTIME_ERROR.set(exc)
                    return 0.0

            return cfunc_type(_char_code)

        elif symbol == "stage2_debug_marker":
            cfunc_type = ctypes.CFUNCTYPE(None, ctypes.c_longlong)

            def _debug_marker(code: ctypes.c_longlong) -> None:
                self._debug_log(f"[stage2] debug_marker code={int(code)}")

            return cfunc_type(_debug_marker)

        return _build_fallback()

    def _compile_ir(self) -> None:
        constant_definitions = self._collect_global_constant_definitions(
            self._lowered_modules)
        function_signatures: "OrderedDict[str, str]" = self._collect_function_signatures(
            self._lowered_modules)
        type_definitions: "OrderedDict[str, str]" = self._collect_type_definitions(
            self._lowered_modules)

        self._debug_log(
            f"[stage2] lowered modules: {len(self._lowered_modules)}")

        candidates: list[tuple[str, str]] = []
        defined_symbols: set[str] = set()
        duplicate_registry: Dict[str, list[str]] = {}
        defined_globals: set[str] = set()
        for index, lowered in enumerate(self._lowered_modules):
            module_ir = getattr(lowered, "ir", "")
            if not module_ir:
                continue
            module_defined = self._extract_defined_globals(module_ir)
            defined_globals.update(module_defined)
            module_ir = self._deduplicate_type_definitions(module_ir)
            patched_ir, injected = self._inject_missing_constant_definitions(
                module_ir, definitions=constant_definitions, already_defined=defined_globals)
            defined_globals.update(injected)
            rewritten_ir, duplicates = self._rewrite_function_linkage(
                patched_ir, defined_symbols, function_signatures)
            rewritten_ir = self._inject_missing_type_definitions(
                rewritten_ir, type_definitions)
            rewritten_ir = self._inject_missing_function_declarations(
                rewritten_ir, function_signatures)
            rewritten_ir = self._instrument_lex_ir(rewritten_ir)
            self._register_type_definitions(rewritten_ir, type_definitions)
            if duplicates:
                duplicate_registry[str(
                    getattr(lowered, "module_name", None)
                    or getattr(lowered, "module", None)
                    or getattr(lowered, "name", None)
                    or f"module_{index}"
                )] = duplicates
            label = (
                getattr(lowered, "module_name", None)
                or getattr(lowered, "module", None)
                or getattr(lowered, "name", None)
                or f"module_{index}"
            )
            candidates.append((str(label), rewritten_ir))
            source_hint = getattr(lowered, "source_path", None)
            if source_hint is None:
                source_hint = getattr(lowered, "path", None)
            if source_hint is None:
                source_hint = getattr(lowered, "source", None)
            if source_hint is not None:
                self._debug_log(
                    f"[stage2] candidate {label} from {source_hint}"
                )
            else:
                self._debug_log(f"[stage2] candidate {label}")
            if duplicates:
                self._debug_log(
                    f"[stage2] rewrote {len(duplicates)} duplicate function(s) in {label}"
                )

        valid_candidates: list[tuple[str, str]] = []
        skipped: list[tuple[str, str]] = []

        for label, ir_text in candidates:
            try:
                module = llvm.parse_assembly(ir_text)
            except RuntimeError:
                skipped.append((label, "parse"))
                self._debug_log(
                    f"[stage2] skipped module {label}: parse failure")
                continue

            try:
                module.verify()
            except RuntimeError:
                # Tolerate verification failures during filtering; the JIT probe below
                # determines whether the module can execute safely.
                pass

            probe_engine = _create_execution_engine()
            probe_engine.add_module(module)
            try:
                probe_engine.finalize_object()
            except RuntimeError:
                skipped.append((label, "finalize"))
                self._debug_log(
                    f"[stage2] skipped module {label}: probe finalize failure"
                )
                continue

            valid_candidates.append((label, ir_text))
            self._debug_log(f"[stage2] module {label} passed probe")

        if not valid_candidates:
            raise ValueError("no LLVM IR provided for Stage2 execution")

        engine = _create_execution_engine()
        modules: list = []
        seen_functions: set[str] = set()
        seen_globals: set[str] = set()
        final_duplicates: list[str] = []
        for label, ir_text in valid_candidates:
            module = llvm.parse_assembly(ir_text)
            try:
                module.verify()
            except RuntimeError:
                pass

            module_suffix = self._sanitize_symbol_suffix(str(label))
            for function in module.functions:
                if function.is_declaration:
                    continue
                name = function.name
                if name in seen_functions:
                    unique_name = name
                    counter = 1
                    while unique_name in seen_functions:
                        unique_name = f"{name}__{module_suffix}" if counter == 1 else f"{name}__{module_suffix}_{counter}"
                        counter += 1
                    function.name = unique_name
                    function.linkage = "internal"
                    seen_functions.add(unique_name)
                    final_duplicates.append(f"{name}->{unique_name}")
                else:
                    seen_functions.add(name)

            for global_var in module.global_variables:
                if global_var.is_declaration:
                    continue
                name = global_var.name
                if name in seen_globals:
                    unique_name = name
                    counter = 1
                    while unique_name in seen_globals:
                        unique_name = f"{name}__{module_suffix}" if counter == 1 else f"{name}__{module_suffix}_{counter}"
                        counter += 1
                    global_var.name = unique_name
                    global_var.linkage = "internal"
                    seen_globals.add(unique_name)
                    final_duplicates.append(f"{name}->{unique_name}")
                else:
                    seen_globals.add(name)

            self._debug_log(
                f"[stage2] adding module {label} (functions={len(list(module.functions))}, globals={len(list(module.global_variables))})"
            )
            engine.add_module(module)
            modules.append(module)

        self._debug_log(
            f"[stage2] finalizing engine with {len(modules)} module(s)"
        )
        try:
            engine.finalize_object()
        except RuntimeError as exc:
            self._debug_log(f"[stage2] finalize failed: {exc}")
            raise
        engine.run_static_constructors()
        self._debug_log("[stage2] finalize succeeded")

        if skipped:
            preview = ", ".join(
                f"{name} ({reason})" for name, reason in skipped[:5])
            runtime.console.warn(
                f"[stage2] skipped {len(skipped)} module(s): {preview}")

        if duplicate_registry or final_duplicates:
            total_duplicates = sum(len(entries)
                                   for entries in duplicate_registry.values()) + len(final_duplicates)
            runtime.console.warn(
                f"[stage2] scoped {total_duplicates} duplicate symbol definition(s) across modules"
            )

        self._engine = engine
        self._modules = modules

    @property
    def manifest(self) -> Mapping[str, Sequence[str]]:
        """Return a read-only view of the capability manifest index."""

        return self._manifest

    def set_manifest_effects(self, symbol: str, effects: Sequence[str]) -> None:
        """Override the manifest entry for `symbol` (primarily for tests)."""

        self._manifest[symbol] = list(effects)

    def invoke(
        self,
        entry_point: str,
        *args,
        restype: type[ctypes._SimpleCData] | None = ctypes.c_double,
        argtypes: Sequence[type[ctypes._SimpleCData]] | None = None,
    ):
        if self._engine is None:
            raise RuntimeError("execution engine was not initialised")
        address = self._engine.get_function_address(entry_point)
        if address == 0:
            raise ValueError(
                f"entry point '{entry_point}' not found in module")
        if argtypes is None:
            if args:
                raise ValueError(
                    "argtypes must be specified when invoking with positional arguments")
            argtypes = ()
        argtypes = tuple(argtypes)
        invoke_args: tuple = args
        call_argtypes = argtypes
        function = None
        function_info = self._lookup_function_return(entry_point)
        aggregate_module = None
        aggregate_return_type = None
        aggregate_address = 0
        aggregate_buffer: ctypes.Array | None = None
        aggregate_size = 0
        use_aggregate = False
        if function_info is not None:
            aggregate_module, aggregate_return_type = function_info
            if self._is_aggregate_return_type(aggregate_return_type):
                type_ref = self._resolve_struct_type(
                    aggregate_module, aggregate_return_type)
                abi_size, _ = self._compute_type_layout(type_ref)
                pointer_size = ctypes.sizeof(ctypes.c_void_p)
                if abi_size and abi_size <= pointer_size:
                    self._debug_log(
                        f"[stage2] aggregate skip {entry_point}: abi_size={abi_size} pointer_size={pointer_size}"
                    )
                else:
                    aggregate_address, aggregate_buffer, aggregate_size = self._allocate_sret_buffer(
                        aggregate_module, aggregate_return_type)
                    aggregate_size = max(1, aggregate_size)
                    aggregate_pointer_type = ctypes.c_void_p
                    call_argtypes = (aggregate_pointer_type, *argtypes)
                    cfunc_type = ctypes.CFUNCTYPE(None, *call_argtypes)
                    function = cfunc_type(address)
                    invoke_args = (ctypes.c_void_p(aggregate_address), *args)
                    self._debug_log(
                        f"[stage2] aggregate entry {entry_point}: declared={aggregate_return_type} size={aggregate_size} "
                        f"address=0x{address:x} sret=0x{aggregate_address:x}"
                    )
                    use_aggregate = True
        if not use_aggregate:
            cfunc_type = ctypes.CFUNCTYPE(
                restype, *argtypes) if restype is not None else ctypes.CFUNCTYPE(None, *argtypes)
            function = cfunc_type(address)
        if function is None:
            raise RuntimeError(
                f"could not materialise callable for {entry_point}")
        self._debug_log(
            f"[stage2] prepare call {entry_point}: func=0x{address:x} aggregate={use_aggregate} args={args} invoke_args={invoke_args}"
        )
        effects = self._manifest.get(entry_point, ())
        grant = runtime.create_capability_grant(effects)
        token = _ACTIVE_GRANT.set(grant)
        error_token = _LAST_RUNTIME_ERROR.set(None)
        result = None
        try:
            self._debug_log(
                f"[stage2] invoke {entry_point}: aggregate={use_aggregate}"
            )
            if use_aggregate:
                function(*invoke_args)
                self._debug_log(
                    f"[stage2] aggregate write {entry_point}: buffer=0x{aggregate_address:x} size={aggregate_size}"
                )
            else:
                result = function(*invoke_args)
                self._debug_log(
                    f"[stage2] return {entry_point}: result={result}"
                )
        finally:
            _ACTIVE_GRANT.reset(token)
            runtime_error = _LAST_RUNTIME_ERROR.get()
            _LAST_RUNTIME_ERROR.reset(error_token)
        if runtime_error is not None:
            raise runtime_error
        if use_aggregate:
            if aggregate_address == 0:
                raise RuntimeError(
                    f"aggregate invocation for {entry_point} produced null buffer (dest={aggregate_address})"
                )
            if restype is None:
                return aggregate_address
            return self._extract_sret_result(aggregate_address, aggregate_size, restype)
        return result
