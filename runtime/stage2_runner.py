"""Stage2 execution helpers that enforce capability manifests at runtime."""

from __future__ import annotations

import contextvars
import ctypes
from dataclasses import dataclass
from typing import Callable, Dict, Mapping, MutableMapping, Sequence

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
_ADAPTER_SIGNATURES: Mapping[str, tuple[str, Sequence[type], type | None]] = {
    # Filesystem adapters
    "sailfin_adapter_fs_read_file": ("io", (ctypes.c_void_p,), ctypes.c_void_p),
    "sailfin_adapter_fs_write_file": ("io", (ctypes.c_void_p, ctypes.c_void_p), None),
    "sailfin_adapter_fs_list_directory": ("io", (ctypes.c_void_p,), ctypes.c_void_p),
    # String helpers
    "sailfin_runtime_string_length": (None, (ctypes.c_void_p,), ctypes.c_longlong),
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
        self._lowered = lowered
        self._manifest = self._build_manifest_index(
            getattr(lowered, "capability_manifest", None))
        self._engine = None
        self._module = None
        self._registered_helpers: list[ctypes._CFuncPtr] = []
        self._hooks: MutableMapping[str, Callable[...,
                                                  None] | None] = _normalise_hooks(runtime_hooks)
        self._initialise_runtime_helpers()
        self._compile_ir()

    @staticmethod
    def _build_manifest_index(manifest) -> Dict[str, Sequence[str]]:
        index: Dict[str, Sequence[str]] = {}
        if manifest is None:
            return index
        entries = getattr(manifest, "entries", ()) or ()
        for entry in entries:
            symbol = getattr(entry, "symbol", "")
            effects = list(getattr(entry, "effects", ()))
            if symbol:
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
    ) -> ctypes._CFuncPtr:
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
    ) -> ctypes._CFuncPtr:
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
            return ctypes.cast(ptr, ctypes.c_char_p).value.decode('utf-8')

        # Storage for string buffers to keep them alive (stored on runner instance)
        if not hasattr(self, '_adapter_string_buffers'):
            self._adapter_string_buffers = []

        # Helper to convert Python string to pointer integer
        def _str_to_ptr(s: str) -> int:
            encoded = s.encode('utf-8')
            buf = ctypes.create_string_buffer(encoded + b'\0')
            self._adapter_string_buffers.append(buf)  # Keep buffer alive
            return ctypes.cast(buf, ctypes.c_void_p).value

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
                    # Mock implementation: return a JSON array representation
                    result = '["file1.txt", "file2.txt"]'
                    return _str_to_ptr(result)
                except Exception as exc:
                    if _LAST_RUNTIME_ERROR.get() is None:
                        _LAST_RUNTIME_ERROR.set(exc)
                    return 0

            return cfunc_type(_fs_list_directory)

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
                    ch = runtime.channel(
                        int(capacity) if capacity > 0 else None)
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
        engine = _create_execution_engine()
        module = llvm.parse_assembly(getattr(self._lowered, "ir", ""))
        module.verify()
        engine.add_module(module)
        engine.finalize_object()
        engine.run_static_constructors()
        self._engine = engine
        self._module = module

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
