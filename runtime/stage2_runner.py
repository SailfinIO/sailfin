"""Stage2 execution helpers that enforce capability manifests at runtime."""

from __future__ import annotations

import contextvars
import ctypes
import os
from dataclasses import dataclass
from collections import OrderedDict
from collections.abc import Iterable as ABCIterable
from typing import Callable, Dict, Iterable, Mapping, Sequence

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
_ADAPTER_SIGNATURES: Mapping[str, tuple[str | None, Sequence[type], type | None]] = {
    # Filesystem adapters
    "sailfin_adapter_fs_read_file": ("io", (ctypes.c_void_p,), ctypes.c_void_p),
    "sailfin_adapter_fs_write_file": ("io", (ctypes.c_void_p, ctypes.c_void_p), None),
    "sailfin_adapter_fs_list_directory": ("io", (ctypes.c_void_p,), ctypes.c_void_p),
    "sailfin_adapter_fs_delete_file": ("io", (ctypes.c_void_p,), ctypes.c_bool),
    "sailfin_adapter_fs_create_directory": ("io", (ctypes.c_void_p, ctypes.c_bool), ctypes.c_bool),
    # String helpers
    "sailfin_runtime_string_length": (None, (ctypes.c_void_p,), ctypes.c_longlong),
    "sailfin_runtime_string_concat": (None, (ctypes.c_void_p, ctypes.c_void_p), ctypes.c_void_p),
    "sailfin_runtime_concat": (None, (ctypes.c_void_p, ctypes.c_void_p), ctypes.c_void_p),
    "sailfin_runtime_bounds_check": (None, (ctypes.c_longlong, ctypes.c_longlong), None),
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
}

_ACTIVE_GRANT: contextvars.ContextVar[runtime.CapabilityGrant | None] = contextvars.ContextVar(
    "stage2_active_capability_grant", default=None
)
_LAST_RUNTIME_ERROR: contextvars.ContextVar[Exception | None] = contextvars.ContextVar(
    "stage2_last_runtime_error", default=None
)

_LLVM_INITIALISED = False


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
        self._manifest = self._build_manifest_index(self._lowered_modules)
        self._engine = None
        self._modules = None
        self._registered_helpers = []
        self._hooks = _normalise_hooks(runtime_hooks)
        self._adapter_string_buffers = []
        self._initialise_runtime_helpers()
        self._compile_ir()

    @staticmethod
    def _normalise_lowered(lowered) -> list:
        if isinstance(lowered, Sequence) and not isinstance(lowered, (bytes, str)):
            return list(lowered)
        return [lowered]

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
    def _collect_global_constant_definitions(lowered_modules: Iterable) -> Dict[str, str]:
        definitions: Dict[str, str] = {}
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
                    definitions.setdefault(name, line)

            for constant in Stage2Runner._iterate_string_constants(getattr(lowered, "string_constants", None)):
                rendered = Stage2Runner._render_string_constant(constant)
                if not rendered:
                    continue
                const_name = getattr(constant, "name", "")
                if const_name.startswith("@"):
                    const_name = const_name[1:]
                if not const_name:
                    continue
                definitions.setdefault(const_name, rendered)
        return definitions

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
    def _inject_missing_constant_definitions(module_ir: str, *, definitions: Mapping[str, str]) -> str:
        if not definitions:
            return module_ir
        defined = Stage2Runner._extract_defined_globals(module_ir)
        missing_lines: list[str] = []
        for name, definition in definitions.items():
            if name in defined:
                continue
            if f"@{name}" not in module_ir:
                continue
            missing_lines.append(definition)
        if not missing_lines:
            return module_ir
        return module_ir.rstrip() + "\n" + "\n".join(missing_lines) + "\n"

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

    def _initialise_runtime_helpers(self) -> None:
        for symbol, (effect, arg_types) in _HELPER_SIGNATURES.items():
            delegate = self._hooks.get(symbol)
            cfunc = self._make_helper(symbol, effect, arg_types, delegate)
            llvm.add_symbol(symbol, ctypes.cast(cfunc, ctypes.c_void_p).value)
            self._registered_helpers.append(cfunc)

        # Register capability adapters
        for symbol, (effect, arg_types, return_type) in _ADAPTER_SIGNATURES.items():
            cfunc = self._make_adapter(symbol, effect, arg_types, return_type)
            llvm.add_symbol(symbol, ctypes.cast(cfunc, ctypes.c_void_p).value)
            self._registered_helpers.append(cfunc)

    def _make_helper(
        self,
        symbol: str,
        effect: str | None,
        arg_types: Sequence[type],
        delegate: Callable[..., None] | None,
    ):
        def _require(effect_name: str) -> None:
            grant = _ACTIVE_GRANT.get()
            if grant is None:
                raise PermissionError(
                    f"{symbol} invoked without an active capability grant")
            grant.require(effect_name)

        cfunc_type = ctypes.CFUNCTYPE(None, *arg_types)

        def _wrapper(*args) -> None:
            try:
                if effect:
                    _require(effect)
                if delegate is not None:
                    delegate(*args)
            except Exception as exc:  # pragma: no cover - propagated after invocation
                if _LAST_RUNTIME_ERROR.get() is None:
                    _LAST_RUNTIME_ERROR.set(exc)

        return cfunc_type(_wrapper)

    def _make_adapter(
        self,
        symbol: str,
        effect: str | None,
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

        # Helper to convert c_void_p to Python string
        def _ptr_to_str(ptr: ctypes.c_void_p) -> str:
            if not ptr:
                return ""
            value = ctypes.cast(ptr, ctypes.c_char_p).value
            return value.decode('utf-8') if value is not None else ""

        # Storage for string buffers to keep them alive (stored on runner instance)
        # Helper to convert Python string to pointer integer
        def _str_to_ptr(s: str) -> int:
            encoded = s.encode('utf-8')
            buf = ctypes.create_string_buffer(encoded + b'\0')
            self._adapter_string_buffers.append(buf)  # Keep buffer alive
            value = ctypes.cast(buf, ctypes.c_void_p).value
            return 0 if value is None else value

        # Filesystem adapters
        if symbol == "sailfin_adapter_fs_read_file":
            cfunc_type = ctypes.CFUNCTYPE(ctypes.c_void_p, ctypes.c_void_p)

            def _fs_read_file(path_ptr: ctypes.c_void_p) -> int:
                try:
                    if effect:
                        _require(effect)
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
                    if effect:
                        _require(effect)
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
                    if effect:
                        _require(effect)
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
                    if effect:
                        _require(effect)
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
                    if effect:
                        _require(effect)
                    path = _ptr_to_str(path_ptr)
                    return bool(runtime.fs.createDirectory(path, exist_ok=bool(exist_ok)))
                except Exception as exc:
                    if _LAST_RUNTIME_ERROR.get() is None:
                        _LAST_RUNTIME_ERROR.set(exc)
                    return False

            return cfunc_type(_fs_create_directory)

        elif symbol == "sailfin_runtime_string_length":
            cfunc_type = ctypes.CFUNCTYPE(ctypes.c_longlong, ctypes.c_void_p)

            def _string_length(value_ptr: ctypes.c_void_p) -> int:
                try:
                    if effect:
                        _require(effect)
                    text = _ptr_to_str(value_ptr)
                    return len(text)
                except Exception as exc:
                    if _LAST_RUNTIME_ERROR.get() is None:
                        _LAST_RUNTIME_ERROR.set(exc)
                    return 0

            return cfunc_type(_string_length)

        elif symbol == "sailfin_runtime_string_concat":
            cfunc_type = ctypes.CFUNCTYPE(
                ctypes.c_void_p, ctypes.c_void_p, ctypes.c_void_p)

            def _string_concat(first_ptr: ctypes.c_void_p, second_ptr: ctypes.c_void_p) -> int:
                try:
                    if effect:
                        _require(effect)
                    first = _ptr_to_str(first_ptr)
                    second = _ptr_to_str(second_ptr)
                    return _str_to_ptr(first + second)
                except Exception as exc:
                    if _LAST_RUNTIME_ERROR.get() is None:
                        _LAST_RUNTIME_ERROR.set(exc)
                    return 0

            return cfunc_type(_string_concat)

        elif symbol == "sailfin_runtime_concat":
            class _StringArray(ctypes.Structure):
                _fields_ = [
                    ("data", ctypes.POINTER(ctypes.c_void_p)),
                    ("length", ctypes.c_longlong),
                ]

            cfunc_type = ctypes.CFUNCTYPE(
                ctypes.c_void_p, ctypes.c_void_p, ctypes.c_void_p)

            def _array_to_list(array_ptr: ctypes.c_void_p) -> list[str]:
                if not array_ptr:
                    return []
                array = ctypes.cast(
                    array_ptr, ctypes.POINTER(_StringArray)).contents
                length = int(array.length)
                if length <= 0 or not array.data:
                    return []
                return [_ptr_to_str(array.data[i]) for i in range(length)]

            def _list_to_array(values: list[str]) -> int:
                length = len(values)
                data = (ctypes.c_void_p * length)()
                for index, value in enumerate(values):
                    data[index] = ctypes.c_void_p(_str_to_ptr(value))
                array_struct = _StringArray()
                array_struct.data = ctypes.cast(
                    data, ctypes.POINTER(ctypes.c_void_p))
                array_struct.length = length
                self._adapter_string_buffers.append(data)
                self._adapter_string_buffers.append(array_struct)
                return ctypes.cast(ctypes.pointer(array_struct), ctypes.c_void_p).value or 0

            def _concat(first_ptr: ctypes.c_void_p, second_ptr: ctypes.c_void_p) -> int:
                try:
                    first = _array_to_list(first_ptr)
                    second = _array_to_list(second_ptr)
                    combined = (first or []) + (second or [])
                    return _list_to_array(combined)
                except Exception as exc:
                    if _LAST_RUNTIME_ERROR.get() is None:
                        _LAST_RUNTIME_ERROR.set(exc)
                    return 0

            return cfunc_type(_concat)

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

        # HTTP adapters
        elif symbol == "sailfin_adapter_http_get":
            cfunc_type = ctypes.CFUNCTYPE(ctypes.c_void_p, ctypes.c_void_p)

            def _http_get(url_ptr: ctypes.c_void_p) -> int:
                try:
                    if effect:
                        _require(effect)
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
                    if effect:
                        _require(effect)
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
                    if effect:
                        _require(effect)
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
                    if effect:
                        _require(effect)
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
                    if effect:
                        _require(effect)
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
                    if effect:
                        _require(effect)
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
                    if effect:
                        _require(effect)
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
                    if effect:
                        _require(effect)
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
                    if effect:
                        _require(effect)
                    # Mock channel receive
                    result = "mock_value"
                    return _str_to_ptr(result)
                except Exception as exc:
                    if _LAST_RUNTIME_ERROR.get() is None:
                        _LAST_RUNTIME_ERROR.set(exc)
                    return 0

            return cfunc_type(_channel_receive)

        else:
            raise ValueError(f"unknown adapter symbol '{symbol}'")

    def _compile_ir(self) -> None:
        constant_definitions = self._collect_global_constant_definitions(
            self._lowered_modules)
        self._debug_log(
            f"[stage2] lowered modules: {len(self._lowered_modules)}")

        candidates: list[tuple[str, str]] = []
        defined_symbols: set[str] = set()
        function_signatures: "OrderedDict[str, str]" = OrderedDict()
        type_definitions: "OrderedDict[str, str]" = OrderedDict()
        duplicate_registry: Dict[str, list[str]] = {}
        for index, lowered in enumerate(self._lowered_modules):
            module_ir = getattr(lowered, "ir", "")
            if not module_ir:
                continue
            patched_ir = self._inject_missing_constant_definitions(
                module_ir, definitions=constant_definitions)
            rewritten_ir, duplicates = self._rewrite_function_linkage(
                patched_ir, defined_symbols, function_signatures)
            rewritten_ir = self._inject_missing_type_definitions(
                rewritten_ir, type_definitions)
            rewritten_ir = self._inject_missing_function_declarations(
                rewritten_ir, function_signatures)
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
        cfunc_type = ctypes.CFUNCTYPE(
            restype, *argtypes) if restype is not None else ctypes.CFUNCTYPE(None, *argtypes)
        function = cfunc_type(address)
        effects = self._manifest.get(entry_point, ())
        grant = runtime.create_capability_grant(effects)
        token = _ACTIVE_GRANT.set(grant)
        error_token = _LAST_RUNTIME_ERROR.set(None)
        try:
            result = function(*args)
        finally:
            _ACTIVE_GRANT.reset(token)
            runtime_error = _LAST_RUNTIME_ERROR.get()
            _LAST_RUNTIME_ERROR.reset(error_token)
        if runtime_error is not None:
            raise runtime_error
        return result
