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
        runtime_hooks: Stage2RuntimeHooks | Mapping[str, Callable[..., None]] | None = None,
    ) -> None:
        self._lowered = lowered
        self._manifest = self._build_manifest_index(getattr(lowered, "capability_manifest", None))
        self._engine = None
        self._module = None
        self._registered_helpers: list[ctypes._CFuncPtr] = []
        self._hooks: MutableMapping[str, Callable[..., None] | None] = _normalise_hooks(runtime_hooks)
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
                raise PermissionError(f"{symbol} invoked without an active capability grant")
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
            raise ValueError(f"entry point '{entry_point}' not found in module")
        if argtypes is None:
            if args:
                raise ValueError("argtypes must be specified when invoking with positional arguments")
            argtypes = ()
        cfunc_type = ctypes.CFUNCTYPE(restype, *argtypes) if restype is not None else ctypes.CFUNCTYPE(None, *argtypes)
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
