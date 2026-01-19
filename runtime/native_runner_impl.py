"""Implementation of the native execution runner.

Prefer importing `NativeRunner` from `runtime.native_runner`.
"""

from __future__ import annotations

import contextvars
import ctypes
import os
import platform
import pathlib
import re
import sys
import traceback
from dataclasses import dataclass
from collections import Counter, OrderedDict
from collections.abc import Iterable as ABCIterable
from typing import Callable, Dict, Iterable, Mapping, Sequence, cast

import llvmlite.binding as llvm

from runtime import runtime_support as runtime

__all__ = ["NativeRunner", "NativeRuntimeHooks", "current_capability_grant"]

_REPO_ROOT = pathlib.Path(__file__).resolve().parents[1]


CapabilityDelegate = Callable[[ctypes.c_void_p], None]
SleepDelegate = Callable[[float], None]


@dataclass
class NativeRuntimeHooks:
    """Optional handlers invoked by the native runtime helpers."""

    print_info: CapabilityDelegate | None = None
    print_warn: CapabilityDelegate | None = None
    print_error: CapabilityDelegate | None = None
    sleep: SleepDelegate | None = None


@dataclass
class DebugLogSink:
    path: pathlib.Path
    bytes_written: int = 0
    suppressed: bool = False


@dataclass
class AllocationRecord:
    base: int
    size: int
    guard: int
    total: int
    sequence: int
    marker: int | None = None


_DEFAULT_ALLOC_GUARD_BYTES = 32
_DEFAULT_GUARD_SCAN_INTERVAL = 128
_FRONT_GUARD_VALUE = 0xAB
_BACK_GUARD_VALUE = 0xEF


# Compatibility alias; remove once external callers have migrated.
Stage2RuntimeHooks = NativeRuntimeHooks


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
    "sailfin_runtime_copy_bytes": (None, (ctypes.c_void_p, ctypes.c_void_p, ctypes.c_longlong), None),
    "sailfin_runtime_concat": (None, (ctypes.c_void_p, ctypes.c_void_p), ctypes.c_void_p),
    "sailfin_runtime_append_string": (None, (ctypes.c_void_p, ctypes.c_void_p), ctypes.c_void_p),
    "sailfin_runtime_char_code": (None, (ctypes.c_void_p,), ctypes.c_double),
    "sailfin_runtime_is_decimal_digit": (None, (ctypes.c_byte,), ctypes.c_bool),
    "sailfin_runtime_grapheme_count": (None, (ctypes.c_void_p,), ctypes.c_double),
    "sailfin_runtime_grapheme_at": (None, (ctypes.c_void_p, ctypes.c_double), ctypes.c_void_p),
    "sailfin_runtime_is_whitespace_char": (None, (ctypes.c_byte,), ctypes.c_bool),
    "strings_equal": (None, (ctypes.c_void_p, ctypes.c_void_p), ctypes.c_bool),
    "char_code": (None, (ctypes.c_void_p,), ctypes.c_double),
    # String character helpers used by lexer/parser
    "char_at": (None, (ctypes.c_void_p, ctypes.c_double), ctypes.c_void_p),
    "is_symbol_char": (None, (ctypes.c_void_p,), ctypes.c_bool),
    "sanitize_symbol": (None, (ctypes.c_void_p,), ctypes.c_void_p),
    "sailfin_runtime_bounds_check": (None, (ctypes.c_longlong, ctypes.c_longlong), None),
    "sailfin_runtime_mark_persistent": (None, (ctypes.c_void_p,), None),
    "abort": (None, (), None),
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
    "stage2_debug_unknown_lexeme": (None, (ctypes.c_void_p, ctypes.c_longlong), None),
    "stage2_debug_token": (None, (ctypes.c_longlong, ctypes.c_longlong, ctypes.c_void_p), None),
}

_ACTIVE_GRANT: contextvars.ContextVar[runtime.CapabilityGrant | None] = contextvars.ContextVar(
    "native_active_capability_grant", default=None
)
_LAST_RUNTIME_ERROR: contextvars.ContextVar[Exception | None] = contextvars.ContextVar(
    "native_last_runtime_error", default=None
)
_ACTIVE_RUNNER: contextvars.ContextVar["NativeRunner" | None] = contextvars.ContextVar(
    "native_active_runner_instance", default=None
)

_LLVM_INITIALISED = False
_LIBC_HANDLE: ctypes.CDLL | None = None
_LIBC_FUNCTIONS: dict[str, ctypes._CFuncPtr] = {}
_LIBC_SYMBOL_ADDRESSES: dict[str, int] = {}
_LIBC_ALLOCATIONS: dict[int, AllocationRecord] = {}


def current_capability_grant() -> runtime.CapabilityGrant | None:
    """Return the capability grant active for the current invocation."""

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
        libc = ctypes.CDLL(None)
        libc_malloc = libc.malloc
        libc_malloc.restype = ctypes.c_void_p
        libc_malloc.argtypes = (ctypes.c_size_t,)

        libc_free = libc.free
        libc_free.restype = None
        libc_free.argtypes = (ctypes.c_void_p,)

        logger = debug_log

        total_allocated = [0]
        max_total_memory = 2 * 1024 * 1024 * 1024  # 2GB limit
        guard_bytes_env = os.environ.get("SAILFIN_STAGE2_ALLOC_GUARD_BYTES")
        guard_scan_env = os.environ.get(
            "SAILFIN_STAGE2_ALLOC_GUARD_SCAN_INTERVAL")
        try:
            guard_bytes = max(0, int(
                guard_bytes_env)) if guard_bytes_env is not None else _DEFAULT_ALLOC_GUARD_BYTES
        except ValueError:
            guard_bytes = _DEFAULT_ALLOC_GUARD_BYTES
        try:
            guard_scan_interval = max(1, int(
                guard_scan_env)) if guard_scan_env is not None else _DEFAULT_GUARD_SCAN_INTERVAL
        except ValueError:
            guard_scan_interval = _DEFAULT_GUARD_SCAN_INTERVAL
        guard_patterns: dict[int, tuple[bytes, bytes]] = {}
        allocation_counter = [0]
        MAX_PREVIEW = 64

        def _safe_bytes(address: int, length: int) -> bytes | None:
            if address <= 0 or length <= 0:
                return None
            sample = min(length, MAX_PREVIEW)
            try:
                return ctypes.string_at(address, sample)
            except (ValueError, OSError):
                return None

        def _bytes_hex(blob: bytes | None) -> str:
            if blob is None:
                return "<unreadable>"
            if not blob:
                return "<empty>"
            return blob.hex()

        def _payload_preview(address: int, size: int, *, tail: bool) -> bytes | None:
            if size <= 0:
                return None
            span = min(size, MAX_PREVIEW)
            start = address if not tail or size <= span else address + size - span
            return _safe_bytes(start, span)

        def _format_guard_violation(kind: str, user_ptr: int, record: AllocationRecord, reason: str) -> str:
            payload_head = _payload_preview(user_ptr, record.size, tail=False)
            payload_tail = _payload_preview(user_ptr, record.size, tail=True)
            if kind == "front":
                guard_addr = record.base
            else:
                guard_addr = record.base + record.guard + record.size
            guard_bytes = _safe_bytes(guard_addr, record.guard)
            runner = _ACTIVE_RUNNER.get()
            recent_markers: Sequence[int] = ()
            if runner is not None:
                try:
                    recent_markers = runner._recent_debug_markers()
                except Exception:
                    recent_markers = ()
            marker_value = record.marker
            return (
                f"[stage2] {kind} guard corrupted: ptr=0x{user_ptr:x} base=0x{record.base:x} size={record.size} "
                f"guard={record.guard} reason={reason} id={record.sequence} marker={marker_value} "
                f"recent_markers={list(recent_markers)} payload_head={_bytes_hex(payload_head)} "
                f"payload_tail={_bytes_hex(payload_tail)} guard_sample={_bytes_hex(guard_bytes)}"
            )

        def _guard_patterns(length: int) -> tuple[bytes, bytes]:
            if length <= 0:
                return (b"", b"")
            pattern = guard_patterns.get(length)
            if pattern is None:
                pattern = (
                    bytes([_FRONT_GUARD_VALUE]) * length,
                    bytes([_BACK_GUARD_VALUE]) * length,
                )
                guard_patterns[length] = pattern
            return pattern

        def _check_guard(user_ptr: int, record: AllocationRecord, reason: str) -> str | None:
            guard = record.guard
            if guard <= 0:
                return None
            front_pattern, back_pattern = _guard_patterns(guard)
            try:
                front_bytes = ctypes.string_at(record.base, guard)
                tail_addr = record.base + guard + record.size
                back_bytes = ctypes.string_at(tail_addr, guard)
            except (ValueError, OSError) as exc:
                return (
                    f"[stage2] guard check failed: ptr=0x{user_ptr:x} size={record.size} reason={reason} error={exc}"
                )
            if front_bytes != front_pattern:
                return _format_guard_violation("front", user_ptr, record, reason)
            if back_bytes != back_pattern:
                return _format_guard_violation("tail", user_ptr, record, reason)
            return None

        def _scan_allocation_guards() -> str | None:
            if guard_bytes <= 0:
                return None
            for user_ptr, record in list(_LIBC_ALLOCATIONS.items()):
                violation = _check_guard(user_ptr, record, "scan")
                if violation:
                    return violation
            return None

        def _malloc_wrapper(size: int) -> int:
            try:
                request = int(size)
            except Exception:
                request = 0
            if request <= 0:
                request = 1

            if request > 1024 * 1024 * 1024 or request < 0:
                if logger:
                    logger(
                        f"[stage2] malloc REJECTED: request size={request} bytes (out of bounds)"
                    )
                return 0

            guard = guard_bytes
            total_request = request + (guard * 2 if guard > 0 else 0)
            if total_allocated[0] + total_request > max_total_memory:
                if logger:
                    logger(
                        f"[stage2] malloc REJECTED: would exceed memory limit (current={total_allocated[0] // (1024*1024)} MB, request={request // 1024} KB)"
                    )
                return 0

            result = libc_malloc(total_request)
            pointer = 0 if result is None else int(result)
            if pointer == 0:
                if logger:
                    logger(
                        f"[stage2] malloc FAILED: size={request} bytes result=null")
                return 0

            user_pointer = pointer + (guard if guard > 0 else 0)
            if guard > 0:
                front_pattern, back_pattern = _guard_patterns(guard)
                ctypes.memmove(pointer, front_pattern, guard)
                tail_addr = pointer + guard + request
                ctypes.memmove(tail_addr, back_pattern, guard)
            allocation_counter[0] += 1
            runner = _ACTIVE_RUNNER.get()
            marker_snapshot = None
            if runner is not None:
                marker_snapshot = getattr(runner, "_last_debug_marker", None)
            record = AllocationRecord(
                base=pointer,
                size=request,
                guard=guard,
                total=total_request,
                sequence=allocation_counter[0],
                marker=marker_snapshot,
            )
            _LIBC_ALLOCATIONS[user_pointer] = record
            total_allocated[0] += total_request
            if logger and request > 1024 * 1024:
                logger(
                    f"[stage2] malloc LARGE: size={request} bytes ({request // 1024} KB) result=0x{user_pointer:x}"
                )
            if guard > 0 and allocation_counter[0] % guard_scan_interval == 0:
                violation = _scan_allocation_guards()
                if violation:
                    if logger:
                        logger(violation)
                    if _LAST_RUNTIME_ERROR.get() is None:
                        _LAST_RUNTIME_ERROR.set(RuntimeError(violation))
                    return 0
            return user_pointer

        def _free_wrapper(ptr: ctypes.c_void_p | int) -> None:
            try:
                address = int(ptr) if not isinstance(
                    ptr, ctypes.c_void_p) else int(ptr.value or 0)
            except Exception:
                address = 0
            if address == 0:
                if logger:
                    logger("[stage2] free ptr=null (ignored)")
                return
            record = _LIBC_ALLOCATIONS.pop(address, None)
            if record is None:
                if logger:
                    logger(
                        f"[stage2] free unknown ptr=0x{address:x} (skipped)")
                if _LAST_RUNTIME_ERROR.get() is None:
                    _LAST_RUNTIME_ERROR.set(
                        RuntimeError(
                            f"free invoked on unknown pointer 0x{address:x}"
                        )
                    )
                return
            violation = _check_guard(address, record, "free")
            if violation and logger:
                logger(violation)
            total_allocated[0] = max(0, total_allocated[0] - record.total)
            if logger:
                logger(
                    f"[stage2] free ptr=0x{address:x} base=0x{record.base:x} size={record.size} id={record.sequence}"
                )
            libc_free(ctypes.c_void_p(record.base))

        malloc_cfunc = ctypes.CFUNCTYPE(
            ctypes.c_void_p, ctypes.c_size_t)(_malloc_wrapper)
        free_cfunc = ctypes.CFUNCTYPE(None, ctypes.c_void_p)(_free_wrapper)
        malloc_addr = int(ctypes.cast(
            malloc_cfunc, ctypes.c_void_p).value or 0)
        free_addr = int(ctypes.cast(free_cfunc, ctypes.c_void_p).value or 0)

        llvm.add_symbol("malloc", malloc_addr)
        llvm.add_symbol("free", free_addr)

        _LIBC_HANDLE = libc
        _LIBC_FUNCTIONS = {"malloc": malloc_cfunc, "free": free_cfunc}
        _LIBC_SYMBOL_ADDRESSES = {"malloc": malloc_addr, "free": free_addr}

        if debug_log:
            debug_log(
                f"[stage2] registered libc malloc wrapper: addr=0x{malloc_addr:x}")
            debug_log(
                f"[stage2] registered libc free wrapper: addr=0x{free_addr:x}")
    except Exception as exc:  # pragma: no cover - diagnostics only
        if debug_log:
            debug_log(
                f"[stage2] failed to register libc malloc/free wrappers: {exc}")

    return _LIBC_FUNCTIONS


def _normalise_hooks(hooks: NativeRuntimeHooks | Mapping[str, Callable[..., None]] | None) -> Dict[str, Callable[..., None] | None]:
    if hooks is None:
        return {}
    if isinstance(hooks, NativeRuntimeHooks):
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
            raise ValueError(f"unknown runtime helper '{key}'")
        result[canonical] = value
    return result


def _create_execution_engine() -> llvm.ExecutionEngine:
    _ensure_llvm_initialised()
    target = llvm.Target.from_default_triple()
    target_machine = target.create_target_machine()
    backing_module = llvm.parse_assembly("")
    return llvm.create_mcjit_compiler(backing_module, target_machine)


class NativeRunner:
    """Execute native LLVM outputs while enforcing capability manifests."""

    def __init__(
        self,
        lowered,
        *,
        runtime_hooks: NativeRuntimeHooks | Mapping[str,
                                                    Callable[..., None]] | None = None,
        initialise_runtime: bool = True,
        compile_ir: bool = True,
        disable_instrumentation: bool | None = None,
    ) -> None:
        raw_log_setting = os.environ.get(
            "SAILFIN_NATIVE_DEBUG_LOG", "").strip()
        if not raw_log_setting:
            raw_log_setting = os.environ.get(
                "SAILFIN_STAGE2_DEBUG_LOG", "").strip()
        requested_paths: list[pathlib.Path] = []
        if raw_log_setting:
            for candidate in raw_log_setting.split(os.pathsep):
                candidate_path = candidate.strip()
                if not candidate_path:
                    continue
                requested_paths.append(
                    pathlib.Path(candidate_path).expanduser())
        fallback_pref = os.environ.get(
            "SAILFIN_NATIVE_DEBUG_FALLBACK", "").strip().lower()
        if not fallback_pref:
            fallback_pref = os.environ.get(
                "SAILFIN_STAGE2_DEBUG_FALLBACK", "1").strip().lower()
        if fallback_pref not in {"0", "false", "off", "no"}:
            requested_paths.append(
                _REPO_ROOT / "build" / "native" / "native_debug.log")
        unique_paths: list[pathlib.Path] = []
        for path in requested_paths:
            if path not in unique_paths:
                unique_paths.append(path)
        self._debug_log_sinks: list[DebugLogSink] = []
        for log_path in unique_paths:
            try:
                log_path.parent.mkdir(parents=True, exist_ok=True)
                with open(log_path, "w", encoding="utf-8"):
                    pass
                self._debug_log_sinks.append(DebugLogSink(path=log_path))
            except OSError:
                continue
        self._primary_debug_log_path = (
            str(self._debug_log_sinks[0].path) if self._debug_log_sinks else None
        )
        dump_dir_override = os.environ.get("SAILFIN_NATIVE_INSTRUMENT_DIR")
        if not dump_dir_override:
            dump_dir_override = os.environ.get("SAILFIN_STAGE2_INSTRUMENT_DIR")
        dump_setting = os.environ.get("SAILFIN_NATIVE_DUMP_INSTRUMENTED_IR")
        if dump_setting is None:
            dump_setting = os.environ.get(
                "SAILFIN_STAGE2_DUMP_INSTRUMENTED_IR")
        self._instrument_dump_dir: pathlib.Path | None = None
        selected_dump_dir: pathlib.Path | None = None
        if disable_instrumentation is None:
            disable_instrument_env = os.environ.get(
                "SAILFIN_STAGE2_DISABLE_MARKERS", ""
            ).strip().lower()
            self._disable_instrumentation = disable_instrument_env in {
                "1",
                "true",
                "yes",
                "on",
                "disable",
            }
            if not self._disable_instrumentation:
                machine = platform.machine().lower()
                if machine in {"arm64", "aarch64"}:
                    # On macOS/arm64, calling into Python `ctypes` callbacks from
                    # JITed code is fragile and can segfault. The marker
                    # instrumentation introduces extra callback edges, so keep it
                    # off by default on this platform.
                    self._disable_instrumentation = True
        else:
            self._disable_instrumentation = bool(disable_instrumentation)
        if dump_dir_override:
            selected_dump_dir = pathlib.Path(dump_dir_override)
        elif dump_setting:
            normalized = dump_setting.strip().lower()
            if normalized in {"1", "true", "yes", "on"}:
                selected_dump_dir = pathlib.Path(
                    "build") / "native" / "instrumented"
            elif normalized not in {"0", "false", "no", "off"}:
                selected_dump_dir = pathlib.Path(dump_setting)
        default_log_limit = 25 * 1024 * 1024  # 25 MB cap to avoid runaway logs
        log_limit_env = os.environ.get("SAILFIN_NATIVE_DEBUG_MAX_BYTES")
        if log_limit_env is None:
            log_limit_env = os.environ.get("SAILFIN_STAGE2_DEBUG_MAX_BYTES")
        self._debug_log_limit = default_log_limit
        if log_limit_env is not None:
            try:
                parsed = int(log_limit_env)
                if parsed <= 0:
                    self._debug_log_limit = 0
                else:
                    self._debug_log_limit = parsed
            except ValueError:
                pass
        self._debug_log_notice_emitted = False
        if selected_dump_dir is not None:
            try:
                selected_dump_dir.mkdir(parents=True, exist_ok=True)
                self._instrument_dump_dir = selected_dump_dir
            except OSError:
                self._debug_log(
                    f"[stage2] failed to create instrument dump dir: {selected_dump_dir}"
                )
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
        self._result_buffers = []  # Dedicated storage for large final results
        # Cache strings by pointer address
        self._string_cache: dict[int, str] = {}
        # Global pool: keeps ALL strings alive forever
        self._string_pool: list[ctypes.Array] = []
        self._tracked_string_addresses: dict[int, tuple[str, str, int]] = {}
        self._adapter_object_handles: dict[int, object] = {}
        self._function_info_cache = {}
        self._adapter_functions: dict[str, ctypes._CFuncPtr] = {}
        self._last_debug_marker: int | None = None
        self._debug_marker_history: list[int] = []
        self._debug_marker_history_limit = 64
        if initialise_runtime:
            self._initialise_runtime_helpers()
        if compile_ir:
            self._compile_ir()

    def rewritten_modules(self) -> list[tuple[str, str]]:
        """Return rewritten LLVM IR modules suitable for AOT compilation.

        This performs the same de-duplication and IR patching as the JIT path but
        does not invoke llvmlite or register runtime helpers.
        """

        candidates, _duplicate_registry = self._rewrite_lowered_ir_modules()
        return [(label, ir_text) for label, ir_text, _source_hint in candidates]

    @staticmethod
    def _normalise_lowered(lowered) -> list:
        if isinstance(lowered, Sequence) and not isinstance(lowered, (bytes, str)):
            return list(lowered)
        return [lowered]

    def encode_host_string(self, text: str) -> ctypes.c_void_p:
        """Register a host string so Stage2 helpers can safely read it."""

        encoded = text.encode("utf-8")
        buffer = ctypes.create_string_buffer(encoded + b"\0")
        self._adapter_string_buffers.append(buffer)
        pointer = ctypes.cast(buffer, ctypes.c_void_p)
        address = pointer.value
        if address:
            self._tracked_string_addresses[int(address)] = (
                "cstring", text, len(encoded))
        return pointer

    def bounds_check(self, index: int, length: int) -> None:
        """
        Validate array bounds access. Called by LLVM-generated code.

        Args:
            index: Array index being accessed
            length: Array length

        Raises:
            IndexError: If index >= length (out of bounds)
        """
        if index < 0 or index >= length:
            raise IndexError(
                f"Array bounds violation: index {index} out of range for array of length {length}"
            )

    def mark_persistent(self, ptr: int) -> None:
        """
        Mark a string pointer as persistent to prevent garbage collection.
        Called by LLVM-generated code before returning string values.

        Args:
            ptr: String pointer address to keep alive
        """
        if ptr == 0:
            return

        # The string should already be tracked and in the pool from _str_to_ptr
        # This function is mainly a no-op since strings are already kept alive
        # But we log for debugging
        if ptr in self._tracked_string_addresses:
            self._debug_log(
                f"[stage2] mark_persistent: ptr 0x{ptr:x} already tracked")
        else:
            self._debug_log(
                f"[stage2] mark_persistent: WARNING ptr 0x{ptr:x} NOT tracked")

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
        if not self._debug_log_sinks:
            return
        text = message + "\n"
        limit = self._debug_log_limit
        for sink in self._debug_log_sinks:
            if limit and sink.suppressed:
                continue
            chunk = text
            chunk_len = len(chunk)
            truncated = False
            if limit:
                remaining = limit - sink.bytes_written
                if remaining <= 0:
                    sink.suppressed = True
                    self._emit_debug_log_notice()
                    continue
                if chunk_len > remaining:
                    chunk = chunk[:remaining]
                    chunk_len = remaining
                    sink.suppressed = True
                    truncated = True
            try:
                with open(sink.path, "a", encoding="utf-8") as handle:
                    handle.write(chunk)
                sink.bytes_written += chunk_len
            except OSError:
                continue
            if truncated:
                self._emit_debug_log_notice()

    def _recent_debug_markers(self, limit: int = 8) -> list[int]:
        if limit <= 0:
            return []
        if not self._debug_marker_history:
            return []
        slice_start = max(0, len(self._debug_marker_history) - limit)
        return list(self._debug_marker_history[slice_start:])

    def _emit_debug_log_notice(self) -> None:
        if self._debug_log_notice_emitted:
            return
        self._debug_log_notice_emitted = True
        sys.stderr.write(
            "[stage2] debug log limit reached; suppressing additional entries\n"
        )

    def _write_instrumented_ir(self, filename: str, content: str) -> None:
        dump_dir = self._instrument_dump_dir
        if not dump_dir:
            return
        try:
            target = dump_dir / filename
            target.write_text(content, encoding="utf-8")
        except OSError:
            # Ignore dump errors; instrumentation is best-effort only.
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
                existing = definitions.get(name)
                if existing is None:
                    definitions[name] = stripped
                    continue
                # Prefer concrete definitions over opaque placeholders.
                existing_opaque = "type opaque" in existing
                new_opaque = "type opaque" in stripped
                if existing_opaque and not new_opaque:
                    definitions[name] = stripped
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

    def _instrument_lex_ir(self, ir_text: str) -> str:
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
                ir_text = ir_text[:declare_index] + \
                    declaration + ir_text[declare_index:]

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

        # Insert an entry marker to confirm lex() is entered before any crash.
        entry_pattern = "block.entry:\n"
        if entry_pattern in lex_body:
            lex_body = lex_body.replace(
                entry_pattern,
                "block.entry:\n  call void @stage2_debug_marker(i64 1000)\n",
                1,
            )
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

        char_probe = "  %t36 = load i8, i8* %t35\n"
        if char_probe in lex_body:
            injection = (
                "  %t36 = load i8, i8* %t35\n"
                "  %stage2_debug_index_code = add i64 %t34, 4000\n"
                "  call void @stage2_debug_marker(i64 %stage2_debug_index_code)\n"
                "  %stage2_debug_char = zext i8 %t36 to i64\n"
                "  %stage2_debug_char_code = add i64 %stage2_debug_char, 3000\n"
                "  call void @stage2_debug_marker(i64 %stage2_debug_char_code)\n"
            )
            lex_body = lex_body.replace(char_probe, injection, 1)

        identifier_probe = "  %t898 = load i8, i8* %t897\n"
        if identifier_probe in lex_body:
            id_injection = (
                "  %t898 = load i8, i8* %t897\n"
                "  %stage2_ident_index_code = add i64 %t896, 5000\n"
                "  call void @stage2_debug_marker(i64 %stage2_ident_index_code)\n"
                "  %stage2_ident_char = zext i8 %t898 to i64\n"
                "  %stage2_ident_char_code = add i64 %stage2_ident_char, 3000\n"
                "  call void @stage2_debug_marker(i64 %stage2_ident_char_code)\n"
            )
            lex_body = lex_body.replace(identifier_probe, id_injection, 1)

        self._write_instrumented_ir("instrumented_lex.ll", lex_body)

        return ir_text[:lex_start] + lex_body + ir_text[lex_end:]

    def _instrument_compile_pipeline_ir(self, ir_text: str) -> str:
        has_sailfin = "define i8* @compile_to_sailfin(" in ir_text
        has_native = "@compile_to_native(" in ir_text
        if not has_sailfin and not has_native:
            return ir_text
        if "declare void @stage2_debug_marker(i64)" not in ir_text:
            declare_index = ir_text.find("declare")
            declaration = "declare void @stage2_debug_marker(i64)\n"
            if declare_index == -1:
                ir_text = ir_text + "\n" + declaration
            else:
                ir_text = ir_text[:declare_index] + \
                    declaration + ir_text[declare_index:]

        # --- compile_to_sailfin instrumentation ---
        start = ir_text.find("define i8* @compile_to_sailfin(")
        if start != -1:
            end = ir_text.find("\n}\n", start)
            if end != -1:
                end += 3
                body = ir_text[start:end]

                # Confirm we reach the function entry before any work is done.
                entry_pattern = "block.entry:\n  %l0 = alloca %Program\n"
                if entry_pattern in body:
                    entry_replacement = (
                        "block.entry:\n"
                        "  call void @stage2_debug_marker(i64 1990)\n"
                        "  %l0 = alloca %Program\n"
                    )
                    body = body.replace(entry_pattern, entry_replacement, 1)

                # Emit a marker before the dispatch to parse_statement so we can
                # distinguish crashes occurring inside statement parsing from earlier phases.
                parse_stmt_call = "  %t56 = call %StatementParseResult @parse_statement(%Parser %t55)\n"
                if parse_stmt_call in body:
                    body = body.replace(
                        parse_stmt_call,
                        "  call void @stage2_debug_marker(i64 12000)\n" +
                        parse_stmt_call,
                        1,
                    )

                parse_call = "  %t0 = call %Program @parse_program(i8* %source)\n"
                if parse_call in body:
                    body = body.replace(
                        parse_call,
                        "  call void @stage2_debug_marker(i64 1991)\n" + parse_call +
                        "  call void @stage2_debug_marker(i64 2000)\n",
                        1,
                    )

                typecheck_call = "  %t2 = call %TypecheckResult @typecheck_program(%Program %t1)\n"
                if typecheck_call in body:
                    body = body.replace(
                        typecheck_call,
                        typecheck_call +
                        "  call void @stage2_debug_marker(i64 2001)\n",
                        1,
                    )

                then_label = "then0:\n"
                if then_label in body:
                    body = body.replace(
                        then_label,
                        "then0:\n  call void @stage2_debug_marker(i64 2002)\n",
                        1,
                    )

                merge_label = "merge1:\n"
                if merge_label in body:
                    body = body.replace(
                        merge_label,
                        "merge1:\n  call void @stage2_debug_marker(i64 2003)\n",
                        1,
                    )

                emit_call = "  %t15 = call i8* @emit_program(%Program %t14)\n"
                if emit_call in body:
                    body = body.replace(
                        emit_call,
                        "  %t15 = call i8* @emit_program(%Program %t14)\n  call void @stage2_debug_marker(i64 2004)\n",
                        1,
                    )

                self._write_instrumented_ir("instrumented_compile.ll", body)

                ir_text = ir_text[:start] + body + ir_text[end:]

        # --- compile_to_native instrumentation ---
        if has_native:
            native_at = ir_text.find("@compile_to_native(")
            native_start = ir_text.rfind(
                "define ", 0, native_at) if native_at != -1 else -1
            if native_start != -1:
                native_end = ir_text.find("\n}\n", native_start)
                if native_end != -1:
                    native_end += 3
                    native_body = ir_text[native_start:native_end]

                    native_entry = "block.entry:\n  %l0 = alloca %Program\n"
                    if native_entry in native_body:
                        native_body = native_body.replace(
                            native_entry,
                            "block.entry:\n  call void @stage2_debug_marker(i64 2990)\n  %l0 = alloca %Program\n",
                            1,
                        )

                    native_parse = "  %t0 = call %Program @parse_program(i8* %source)\n"
                    if native_parse in native_body:
                        native_body = native_body.replace(
                            native_parse,
                            "  call void @stage2_debug_marker(i64 2991)\n" + native_parse +
                            "  call void @stage2_debug_marker(i64 2992)\n",
                            1,
                        )

                    emit_native_sig = "call %EmitNativeResult"
                    emit_native_at = native_body.find("@emit_native(")
                    if emit_native_at != -1:
                        line_start = native_body.rfind(
                            "\n", 0, emit_native_at) + 1
                        line_end = native_body.find("\n", emit_native_at)
                        if 0 <= line_start < line_end:
                            call_line = native_body[line_start:line_end] + "\n"
                            if emit_native_sig in call_line:
                                native_body = native_body.replace(
                                    call_line,
                                    "  call void @stage2_debug_marker(i64 2994)\n" +
                                    call_line,
                                    1,
                                )

                    self._write_instrumented_ir(
                        "instrumented_compile_to_native.ll", native_body
                    )

                    ir_text = ir_text[:native_start] + \
                        native_body + ir_text[native_end:]

        return ir_text

    def _instrument_parse_tokens_ir(self, ir_text: str) -> str:
        if "define %Program @parse_tokens(" not in ir_text:
            return ir_text
        if "declare void @stage2_debug_marker(i64)" not in ir_text:
            declare_index = ir_text.find("declare")
            declaration = "declare void @stage2_debug_marker(i64)\n"
            if declare_index == -1:
                ir_text = ir_text + "\n" + declaration
            else:
                ir_text = ir_text[:declare_index] + \
                    declaration + ir_text[declare_index:]

        start = ir_text.find("define %Program @parse_tokens(")
        if start == -1:
            return ir_text
        end = ir_text.find("\n}\n", start)
        if end == -1:
            return ir_text
        end += 3
        body = ir_text[start:end]

        # Emit a function entry marker to confirm we reach parse_tokens at runtime.
        entry_pattern = "block.entry:\n  %l0 = alloca %Parser\n"
        if entry_pattern in body:
            entry_replacement = (
                "block.entry:\n"
                "  call void @stage2_debug_marker(i64 12010)\n"
                "  %l0 = alloca %Parser\n"
            )
            body = body.replace(entry_pattern, entry_replacement, 1)

        # Emit a marker before the dispatch to parse_statement so we can
        # distinguish crashes occurring inside statement parsing from earlier phases.
        parse_stmt_call = "  %t56 = call %StatementParseResult @parse_statement(%Parser %t55)\n"
        if parse_stmt_call in body:
            body = body.replace(
                parse_stmt_call,
                "  call void @stage2_debug_marker(i64 12000)\n" +
                parse_stmt_call,
                1,
            )

        loop_pattern = "loop.body1:\n  %t20 = load %Parser, %Parser* %l0\n"
        if loop_pattern in body:
            loop_replacement = (
                "loop.body1:\n"
                "  %t20 = load %Parser, %Parser* %l0\n"
                "  %stage2_parse_index = extractvalue %Parser %t20, 1\n"
                "  %stage2_parse_index_i64 = fptosi double %stage2_parse_index to i64\n"
                "  %stage2_parse_marker = add i64 %stage2_parse_index_i64, 6000\n"
                "  call void @stage2_debug_marker(i64 %stage2_parse_marker)\n"
            )
            body = body.replace(loop_pattern, loop_replacement, 1)

        token_pattern = "  %t22 = load %Token, %Token* %l2\n"
        if token_pattern in body:
            token_replacement = (
                "  %t22 = load %Token, %Token* %l2\n"
                "  %stage2_token_kind = extractvalue %Token %t22, 0\n"
                "  %stage2_token_variant = extractvalue %TokenKind %stage2_token_kind, 0\n"
                "  %stage2_token_variant_i64 = sext i32 %stage2_token_variant to i64\n"
                "  %stage2_token_marker = add i64 %stage2_token_variant_i64, 7000\n"
                "  call void @stage2_debug_marker(i64 %stage2_token_marker)\n"
            )
            body = body.replace(token_pattern, token_replacement, 1)

        self._write_instrumented_ir("instrumented_parse_tokens.ll", body)

        return ir_text[:start] + body + ir_text[end:]

    def _instrument_tokens_to_text_ir(self, ir_text: str) -> str:
        if "define i8* @tokens_to_text(" not in ir_text:
            return ir_text
        if "declare void @stage2_debug_marker(i64)" not in ir_text:
            declare_index = ir_text.find("declare")
            declaration = "declare void @stage2_debug_marker(i64)\n"
            if declare_index == -1:
                ir_text = ir_text + "\n" + declaration
            else:
                ir_text = (
                    ir_text[:declare_index]
                    + declaration
                    + ir_text[declare_index:]
                )
        if "declare void @stage2_debug_token(i64, i64, i8*)" not in ir_text:
            declare_index = ir_text.find("declare")
            declaration = "declare void @stage2_debug_token(i64, i64, i8*)\n"
            if declare_index == -1:
                ir_text = ir_text + "\n" + declaration
            else:
                ir_text = (
                    ir_text[:declare_index]
                    + declaration
                    + ir_text[declare_index:]
                )

        start = ir_text.find("define i8* @tokens_to_text(")
        if start == -1:
            return ir_text
        end = ir_text.find("\n}\n", start)
        if end == -1:
            return ir_text
        end += 3
        body = ir_text[start:end]

        entry_pattern = "block.entry:\n  %l0 = alloca i8*\n"
        if entry_pattern in body:
            entry_replacement = (
                "block.entry:\n"
                "  call void @stage2_debug_marker(i64 61000)\n"
                "  %l0 = alloca i8*\n"
            )
            body = body.replace(entry_pattern, entry_replacement, 1)

        index_pattern = "  %t30 = fptosi double %t29 to i64\n"
        if index_pattern in body:
            index_replacement = (
                "  %t30 = fptosi double %t29 to i64\n"
                "  %stage2_tokens_text_index = add i64 %t30, 61100\n"
                "  call void @stage2_debug_marker(i64 %stage2_tokens_text_index)\n"
            )
            body = body.replace(index_pattern, index_replacement, 1)

        token_load_pattern = (
            "  %t36 = load %Token, %Token* %t35\n"
            "  %t37 = extractvalue %Token %t36, 1\n"
        )
        if token_load_pattern in body:
            token_load_replacement = (
                "  %t36 = load %Token, %Token* %t35\n"
                "  %stage2_tokens_text_kind = extractvalue %Token %t36, 0\n"
                "  %stage2_tokens_text_variant = extractvalue %TokenKind %stage2_tokens_text_kind, 0\n"
                "  %stage2_tokens_text_variant_i64 = sext i32 %stage2_tokens_text_variant to i64\n"
                "  %t37 = extractvalue %Token %t36, 1\n"
                "  call void @stage2_debug_token(i64 %t30, i64 %stage2_tokens_text_variant_i64, i8* %t37)\n"
            )
            body = body.replace(token_load_pattern, token_load_replacement, 1)

        max_tokens_pattern = "then6:\n  store i1 1, i1* %l4\n"
        if max_tokens_pattern in body:
            max_tokens_replacement = (
                "then6:\n"
                "  call void @stage2_debug_marker(i64 61200)\n"
                "  store i1 1, i1* %l4\n"
            )
            body = body.replace(max_tokens_pattern,
                                max_tokens_replacement, 1)

        limit_pattern = "then8:\n  %t52 = load i8*, i8** %l0\n"
        if limit_pattern in body:
            limit_replacement = (
                "then8:\n"
                "  call void @stage2_debug_marker(i64 61210)\n"
                "  %t52 = load i8*, i8** %l0\n"
            )
            body = body.replace(limit_pattern, limit_replacement, 1)

        tail_trim_pattern = "then10:\n  %t79 = load i8*, i8** %l0\n"
        if tail_trim_pattern in body:
            tail_trim_replacement = (
                "then10:\n"
                "  call void @stage2_debug_marker(i64 61220)\n"
                "  %t79 = load i8*, i8** %l0\n"
            )
            body = body.replace(tail_trim_pattern,
                                tail_trim_replacement, 1)

        suffix_pattern = "then12:\n  %t92 = load i8*, i8** %l0\n"
        if suffix_pattern in body:
            suffix_replacement = (
                "then12:\n"
                "  call void @stage2_debug_marker(i64 61230)\n"
                "  %t92 = load i8*, i8** %l0\n"
            )
            body = body.replace(suffix_pattern, suffix_replacement, 1)

        ret_pattern = (
            "  call void @sailfin_runtime_mark_persistent(i8* %t97)\n"
            "  ret i8* %t97\n"
        )
        if ret_pattern in body:
            ret_replacement = (
                "  call void @sailfin_runtime_mark_persistent(i8* %t97)\n"
                "  call void @stage2_debug_marker(i64 61290)\n"
                "  ret i8* %t97\n"
            )
            body = body.replace(ret_pattern, ret_replacement, 1)

        self._write_instrumented_ir("instrumented_tokens_to_text.ll", body)

        return ir_text[:start] + body + ir_text[end:]

    def _instrument_skip_trivia_ir(self, ir_text: str) -> str:
        if "define %Parser @skip_trivia(" not in ir_text:
            return ir_text
        if "declare void @stage2_debug_marker(i64)" not in ir_text:
            declare_index = ir_text.find("declare")
            declaration = "declare void @stage2_debug_marker(i64)\n"
            if declare_index == -1:
                ir_text = ir_text + "\n" + declaration
            else:
                ir_text = ir_text[:declare_index] + \
                    declaration + ir_text[declare_index:]

        start = ir_text.find("define %Parser @skip_trivia(")
        if start == -1:
            return ir_text
        end = ir_text.find("\n}\n", start)
        if end == -1:
            return ir_text
        end += 3
        body = ir_text[start:end]

        index_pattern = (
            "loop.body1:\n"
            "  %t1 = load %Parser, %Parser* %l0\n"
            "  %t2 = extractvalue %Parser %t1, 1\n"
        )
        if index_pattern in body:
            index_replacement = (
                "loop.body1:\n"
                "  %t1 = load %Parser, %Parser* %l0\n"
                "  %t2 = extractvalue %Parser %t1, 1\n"
                "  %stage2_skip_index_i64 = fptosi double %t2 to i64\n"
                "  %stage2_skip_index_marker = add i64 %stage2_skip_index_i64, 5000\n"
                "  call void @stage2_debug_marker(i64 %stage2_skip_index_marker)\n"
            )
            body = body.replace(index_pattern, index_replacement, 1)

        token_pattern = "  %t22 = load %Token, %Token* %t21\n"
        if token_pattern in body:
            token_replacement = (
                "  %t22 = load %Token, %Token* %t21\n"
                "  %stage2_skip_token_kind = extractvalue %Token %t22, 0\n"
                "  %stage2_skip_token_variant = extractvalue %TokenKind %stage2_skip_token_kind, 0\n"
                "  %stage2_skip_token_variant_i64 = sext i32 %stage2_skip_token_variant to i64\n"
                "  %stage2_skip_token_marker = add i64 %stage2_skip_token_variant_i64, 5100\n"
                "  call void @stage2_debug_marker(i64 %stage2_skip_token_marker)\n"
            )
            body = body.replace(token_pattern, token_replacement, 1)

        eof_branch_pattern = "  br i1 %t8, label %then4, label %merge5\n"
        if eof_branch_pattern in body:
            eof_branch_replacement = (
                "  %stage2_skip_bounds_marker = select i1 %t8, i64 52100, i64 52101\n"
                "  call void @stage2_debug_marker(i64 %stage2_skip_bounds_marker)\n"
                "  br i1 %t8, label %then4, label %merge5\n"
            )
            body = body.replace(eof_branch_pattern, eof_branch_replacement, 1)

        then6_pattern = "then6:\n  %t26 = load %Parser, %Parser* %l0\n"
        if then6_pattern in body:
            then6_replacement = (
                "then6:\n"
                "  call void @stage2_debug_marker(i64 52001)\n"
                "  %t26 = load %Parser, %Parser* %l0\n"
            )
            body = body.replace(then6_pattern, then6_replacement, 1)

        trivia_call_pattern = "  %t23 = call i1 @is_trivia_token(%Token %t22)\n"
        if trivia_call_pattern in body:
            trivia_call_replacement = (
                "  call void @stage2_debug_marker(i64 53080)\n"
                "  %t23 = call i1 @is_trivia_token(%Token %t22)\n"
            )
            body = body.replace(trivia_call_pattern,
                                trivia_call_replacement, 1)

        trivia_branch_pattern = "  br i1 %t23, label %then6, label %merge7\n"
        if trivia_branch_pattern in body:
            trivia_branch_replacement = (
                "  %stage2_skip_trivia_decision = select i1 %t23, i64 52021, i64 52020\n"
                "  call void @stage2_debug_marker(i64 %stage2_skip_trivia_decision)\n"
                "  br i1 %t23, label %then6, label %merge7\n"
            )
            body = body.replace(trivia_branch_pattern,
                                trivia_branch_replacement, 1)

        self._write_instrumented_ir("instrumented_skip_trivia.ll", body)

        return ir_text[:start] + body + ir_text[end:]

    def _instrument_is_trivia_token_ir(self, ir_text: str) -> str:
        if "@is_trivia_token" not in ir_text:
            return ir_text

        def _instrument_body(body: str) -> tuple[str, bool]:
            inserted = False

            entry_label = "block.entry:\n"
            entry_marker = "  call void @stage2_debug_marker(i64 53090)\n"
            if entry_label in body and entry_marker not in body:
                body = body.replace(entry_label, entry_label + entry_marker, 1)
                inserted = True

            def _insert_marker(label: str, code: int) -> None:
                nonlocal body, inserted
                label_marker = f"{label}:\n"
                label_index = body.find(label_marker)
                if label_index == -1:
                    return
                ret_index = body.find(
                    "  ret i1 1", label_index + len(label_marker)
                )
                if ret_index == -1:
                    return
                insertion = f"  call void @stage2_debug_marker(i64 {code})\n"
                body = body[:ret_index] + insertion + body[ret_index:]
                inserted = True

            _insert_marker("then0", 53001)
            _insert_marker("then8", 53002)
            _insert_marker("then12", 53003)

            if not inserted:
                merge_label = "logical_or_merge_0:\n"
                merge_index = body.find(merge_label)
                if merge_index != -1:
                    ret_index = body.find(
                        "  ret i1", merge_index + len(merge_label)
                    )
                    if ret_index != -1:
                        insertion = (
                            "  call void @stage2_debug_marker(i64 53050)\n"
                        )
                        body = body[:ret_index] + insertion + body[ret_index:]
                        inserted = True

            return body, inserted

        pattern = re.compile(
            r"^define\s+[^\n]*@is_trivia_token(?=[^A-Za-z0-9_])",
            re.MULTILINE,
        )

        def _find_function_end(brace_start: int) -> int:
            depth = 0
            index = brace_start
            text_length = len(ir_text)
            while index < text_length:
                ch = ir_text[index]
                if ch == "{":
                    depth += 1
                elif ch == "}":
                    depth -= 1
                    if depth == 0:
                        index += 1
                        while index < text_length and ir_text[index] in "\r\n":
                            index += 1
                        return index
                index += 1
            return -1

        cursor = 0
        pieces: list[str] = []
        modified_any = False
        for match in pattern.finditer(ir_text):
            start = match.start()
            brace_start = ir_text.find("{", match.end())
            if brace_start == -1:
                continue
            end = _find_function_end(brace_start)
            if end == -1:
                continue
            pieces.append(ir_text[cursor:start])
            body, modified = _instrument_body(ir_text[start:end])
            pieces.append(body)
            cursor = end
            modified_any = modified_any or modified

        if not pieces:
            return ir_text

        pieces.append(ir_text[cursor:])
        result = "".join(pieces)

        if not modified_any:
            return ir_text

        if "declare void @stage2_debug_marker(i64)" not in result:
            declare_index = result.find("declare")
            declaration = "declare void @stage2_debug_marker(i64)\n"
            if declare_index == -1:
                result = result + "\n" + declaration
            else:
                result = result[:declare_index] + \
                    declaration + result[declare_index:]

        self._write_instrumented_ir(
            "instrumented_is_trivia_token.ll", result)
        return result

    def _instrument_parse_block_ir(self, ir_text: str) -> str:
        if "define %BlockParseResult @parse_block(" not in ir_text:
            return ir_text
        if "declare void @stage2_debug_marker(i64)" not in ir_text:
            declare_index = ir_text.find("declare")
            declaration = "declare void @stage2_debug_marker(i64)\n"
            if declare_index == -1:
                ir_text = ir_text + "\n" + declaration
            else:
                ir_text = ir_text[:declare_index] + \
                    declaration + ir_text[declare_index:]

        start = ir_text.find("define %BlockParseResult @parse_block(")
        if start == -1:
            return ir_text
        end = ir_text.find("\n}\n", start)
        if end == -1:
            return ir_text
        end += 3
        body = ir_text[start:end]

        loop_pattern = "loop.body3:\n  %t128 = load %Parser, %Parser* %l3\n"
        if loop_pattern in body:
            loop_replacement = (
                "loop.body3:\n"
                "  %t128 = load %Parser, %Parser* %l3\n"
                "  %stage2_block_index = extractvalue %Parser %t128, 1\n"
                "  %stage2_block_index_i64 = fptosi double %stage2_block_index to i64\n"
                "  %stage2_block_marker = add i64 %stage2_block_index_i64, 8000\n"
                "  call void @stage2_debug_marker(i64 %stage2_block_marker)\n"
            )
            body = body.replace(loop_pattern, loop_replacement, 1)

        token_pattern = "  %t133 = load %Token, %Token* %l6\n"
        if token_pattern in body:
            token_replacement = (
                "  %t133 = load %Token, %Token* %l6\n"
                "  %stage2_block_token_kind = extractvalue %Token %t133, 0\n"
                "  %stage2_block_token_variant = extractvalue %TokenKind %stage2_block_token_kind, 0\n"
                "  %stage2_block_token_variant_i64 = sext i32 %stage2_block_token_variant to i64\n"
                "  %stage2_block_token_marker = add i64 %stage2_block_token_variant_i64, 9000\n"
                "  call void @stage2_debug_marker(i64 %stage2_block_token_marker)\n"
            )
            body = body.replace(token_pattern, token_replacement, 1)

        self._write_instrumented_ir("instrumented_parse_block.ll", body)

        return ir_text[:start] + body + ir_text[end:]

    def _instrument_parse_unknown_ir(self, ir_text: str) -> str:
        if "define %StatementParseResult @parse_unknown(" not in ir_text:
            return ir_text
        if "declare void @stage2_debug_marker(i64)" not in ir_text:
            declare_index = ir_text.find("declare")
            declaration = "declare void @stage2_debug_marker(i64)\n"
            if declare_index == -1:
                ir_text = ir_text + "\n" + declaration
            else:
                ir_text = ir_text[:declare_index] + \
                    declaration + ir_text[declare_index:]
        if "declare void @stage2_debug_unknown_lexeme(i8*, i64)" not in ir_text:
            declare_index = ir_text.find("declare")
            declaration = "declare void @stage2_debug_unknown_lexeme(i8*, i64)\n"
            if declare_index == -1:
                ir_text = ir_text + "\n" + declaration
            else:
                ir_text = ir_text[:declare_index] + \
                    declaration + ir_text[declare_index:]

        start = ir_text.find("define %StatementParseResult @parse_unknown(")
        if start == -1:
            return ir_text
        end = ir_text.find("\n}\n", start)
        if end == -1:
            return ir_text
        end += 3
        body = ir_text[start:end]

        entry_label = "block.entry:\n"
        entry_marker = "  call void @stage2_debug_marker(i64 10000)\n"
        if entry_label in body and entry_marker not in body:
            body = body.replace(entry_label, entry_label + entry_marker, 1)

        loop_label = "loop.body1:\n"
        if loop_label in body and "%stage2_unknown_marker" not in body:
            loop_instrument = (
                "loop.body1:\n"
                "  %stage2_unknown_parser = load %Parser, %Parser* %l2\n"
                "  %stage2_unknown_index = extractvalue %Parser %stage2_unknown_parser, 1\n"
                "  %stage2_unknown_index_i64 = fptosi double %stage2_unknown_index to i64\n"
                "  %stage2_unknown_marker = add i64 %stage2_unknown_index_i64, 10000\n"
                "  call void @stage2_debug_marker(i64 %stage2_unknown_marker)\n"
            )
            body = body.replace(loop_label, loop_instrument, 1)

        token_store_pattern = "(  store %Token %t\\d+, %Token\\* %l7\\n)"
        token_store_replacement = (
            r"\1"
            "  %stage2_unknown_token = load %Token, %Token* %l7\n"
            "  %stage2_unknown_token_kind = extractvalue %Token %stage2_unknown_token, 0\n"
            "  %stage2_unknown_token_variant = extractvalue %TokenKind %stage2_unknown_token_kind, 0\n"
            "  %stage2_unknown_token_variant_i64 = sext i32 %stage2_unknown_token_variant to i64\n"
            "  %stage2_unknown_token_marker = add i64 %stage2_unknown_token_variant_i64, 11000\n"
            "  call void @stage2_debug_marker(i64 %stage2_unknown_token_marker)\n"
            "  %stage2_unknown_depth_value = load double, double* %l3\n"
            "  %stage2_unknown_depth_i64 = fptosi double %stage2_unknown_depth_value to i64\n"
            "  %stage2_unknown_depth_marker = add i64 %stage2_unknown_depth_i64, 13000\n"
            "  call void @stage2_debug_marker(i64 %stage2_unknown_depth_marker)\n"
            "  %stage2_unknown_lexeme_ptr = extractvalue %Token %stage2_unknown_token, 1\n"
            "  %stage2_unknown_lexeme_len = call i64 @sailfin_runtime_string_length(i8* %stage2_unknown_lexeme_ptr)\n"
            "  call void @stage2_debug_unknown_lexeme(i8* %stage2_unknown_lexeme_ptr, i64 %stage2_unknown_lexeme_len)\n"
        )
        body, _ = re.subn(token_store_pattern,
                          token_store_replacement, body, count=1)

        self._write_instrumented_ir("instrumented_parse_unknown.ll", body)

        return ir_text[:start] + body + ir_text[end:]

    def _instrument_parse_statement_ir(self, ir_text: str) -> str:
        """
        Insert debug markers in parse_statement to record which branch is taken.

        We add a marker immediately before calls to specific parse_* routines so the
        stage2_debug.log will show which statement kind was selected prior to any
        deeper parsing that may trap.
        """
        if "define %StatementParseResult @parse_statement(" not in ir_text:
            return ir_text
        if "declare void @stage2_debug_marker(i64)" not in ir_text:
            declare_index = ir_text.find("declare")
            declaration = "declare void @stage2_debug_marker(i64)\n"
            if declare_index == -1:
                ir_text = ir_text + "\n" + declaration
            else:
                ir_text = ir_text[:declare_index] + \
                    declaration + ir_text[declare_index:]

        start = ir_text.find("define %StatementParseResult @parse_statement(")
        if start == -1:
            return ir_text
        end = ir_text.find("\n}\n", start)
        if end == -1:
            return ir_text
        end += 3
        body = ir_text[start:end]

        # Map of callee symbol -> marker code base
        marker_map = {
            "@parse_import(": 12101,
            "@parse_export(": 12102,
            "@parse_variable(": 12103,
            "@parse_model(": 12104,
            "@parse_pipeline(": 12105,
            "@parse_tool(": 12106,
            "@parse_test(": 12107,
            "@parse_function(": 12108,
            "@parse_struct(": 12109,
            "@parse_type_alias(": 12110,
            "@parse_interface(": 12111,
            "@parse_enum(": 12112,
            "@parse_unknown(": 12113,
        }

        # Inject markers line-by-line to avoid corrupting SSA assignments
        lines = body.splitlines()
        patched_lines: list[str] = []
        inserted_entry_marker = False
        pending_token_marker = False
        for line in lines:
            stripped = line.lstrip()
            inserted = False
            # Insert an entry marker right after the first basic block label
            if not inserted_entry_marker and stripped.endswith(":") and stripped.startswith("block.entry"):
                patched_lines.append(line)
                patched_lines.append(
                    "  call void @stage2_debug_marker(i64 12100)")
                inserted_entry_marker = True
                continue
            if stripped.startswith("%t12 = call %Token @parser_peek_raw("):
                patched_lines.append(line)
                pending_token_marker = True
                continue
            if pending_token_marker and "store %Token %t12" in stripped:
                patched_lines.append(line)
                patched_lines.append(
                    "  %stage2_stmt_token_kind = extractvalue %Token %t12, 0")
                patched_lines.append(
                    "  %stage2_stmt_token_variant = extractvalue %TokenKind %stage2_stmt_token_kind, 0")
                patched_lines.append(
                    "  %stage2_stmt_token_variant_i64 = sext i32 %stage2_stmt_token_variant to i64")
                patched_lines.append(
                    "  %stage2_stmt_token_marker = add i64 %stage2_stmt_token_variant_i64, 12200")
                patched_lines.append(
                    "  call void @stage2_debug_marker(i64 %stage2_stmt_token_marker)")
                pending_token_marker = False
                continue
            # Only consider actual call instructions to our known callees
            if stripped.startswith("%") or stripped.startswith("br ") or stripped.startswith("ret "):
                for callee, code in marker_map.items():
                    if f"@{callee[1:]}" in line and " call " in line and "%StatementParseResult" in line:
                        # Insert a standalone marker immediately before the call line
                        patched_lines.append(
                            "  call void @stage2_debug_marker(i64 " + str(code) + ")")
                        patched_lines.append(line)
                        inserted = True
                        break
            if not inserted:
                patched_lines.append(line)
        body = "\n".join(patched_lines)

        self._write_instrumented_ir("instrumented_parse_statement.ll", body)

        return ir_text[:start] + body + ir_text[end:]

    def _instrument_parse_program_ir(self, ir_text: str) -> str:
        """
        Insert debug markers in parse_program to trace parser entry.

        - Emit 12001 at function entry
        - Emit 12005 immediately before calling parse_tokens
        - Emit 12000 immediately before calling parse_statement (legacy signal)
        """
        if "define %Program @parse_program(" not in ir_text:
            return ir_text
        if "declare void @stage2_debug_marker(i64)" not in ir_text:
            declare_index = ir_text.find("declare")
            declaration = "declare void @stage2_debug_marker(i64)\n"
            if declare_index == -1:
                ir_text = ir_text + "\n" + declaration
            else:
                ir_text = ir_text[:declare_index] + \
                    declaration + ir_text[declare_index:]

        start = ir_text.find("define %Program @parse_program(")
        if start == -1:
            return ir_text
        end = ir_text.find("\n}\n", start)
        if end == -1:
            return ir_text
        end += 3
        body = ir_text[start:end]

        lines = body.splitlines()
        patched_lines: list[str] = []
        inserted_entry = False
        for line in lines:
            stripped = line.lstrip()
            if not inserted_entry and stripped.endswith(":") and stripped.startswith("block.entry"):
                patched_lines.append(line)
                patched_lines.append(
                    "  call void @stage2_debug_marker(i64 12001)")
                inserted_entry = True
                continue
            if " call %Program @parse_tokens(" in line:
                patched_lines.append(
                    "  call void @stage2_debug_marker(i64 12005)")
                patched_lines.append(line)
                continue
            if " call %StatementParseResult @parse_statement(" in line:
                patched_lines.append(
                    "  call void @stage2_debug_marker(i64 12000)")
                patched_lines.append(line)
            else:
                patched_lines.append(line)
        body = "\n".join(patched_lines)

        self._write_instrumented_ir("instrumented_parse_program.ll", body)

        return ir_text[:start] + body + ir_text[end:]

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
        type_line_index: dict[str, int] = {}
        type_is_opaque: dict[str, bool] = {}

        for index, line in enumerate(lines):
            stripped = line.strip()
            if not stripped.startswith("%") or " = type" not in stripped:
                continue
            name = stripped.split("=", 1)[0].strip()[1:]
            if not name:
                continue
            defined.add(name)
            type_line_index.setdefault(name, index)
            type_is_opaque.setdefault(name, "type opaque" in stripped)

        # Upgrade opaque placeholders to concrete definitions when available.
        upgraded = False
        for name, definition in known_types.items():
            if name not in type_line_index:
                continue
            if not type_is_opaque.get(name, False):
                continue
            if "type opaque" in definition:
                continue
            lines[type_line_index[name]] = definition
            type_is_opaque[name] = False
            upgraded = True

        missing = [
            definition for name, definition in known_types.items() if name not in defined
        ]
        if not missing:
            return "\n".join(lines) if upgraded else ir_text
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
        # Safety check: avoid segfault on invalid addresses
        if address == 0 or address < 0x1000:
            return b""
        try:
            return ctypes.string_at(address, size)
        except (ValueError, OSError):
            return b""

    def _validate_structure_result(self, entry_point: str, result: object) -> None:
        if result is None or not isinstance(result, ctypes.Structure):
            return
        fields = getattr(result.__class__, "_fields_", ())
        if not fields:
            return
        for field_name, field_type in fields:
            if field_name != "ir":
                continue
            pointer_value = getattr(result, field_name, None)
            address = 0
            if isinstance(pointer_value, ctypes.c_void_p):
                address = int(pointer_value.value or 0)
            elif isinstance(pointer_value, ctypes.c_char_p):
                address = int(ctypes.cast(
                    pointer_value, ctypes.c_void_p).value or 0)
            else:
                try:
                    address = int(
                        getattr(pointer_value, "value", pointer_value) or 0)
                except (TypeError, ValueError):
                    address = 0
            if address == 0:
                log_hint = self._primary_debug_log_path or "<no stage2 debug log configured>"
                raise RuntimeError(
                    f"{entry_point} returned NULL pointer for field '{field_name}'. "
                    f"Review Stage2 debug log at {log_hint} to inspect the failing helper."
                )

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

        # Provide backing storage for the external @runtime global expected by stage2 IR.
        # We map it to a 1-element void* array so loads are well-defined even if the
        # value is unused. The buffer is kept on the instance to avoid GC.
        self._runtime_global_storage = (ctypes.c_void_p * 1)()
        # Keep a non-null placeholder buffer alive in case stage2 code dereferences the global.
        self._runtime_placeholder = ctypes.create_string_buffer(1)
        placeholder_addr = ctypes.cast(
            self._runtime_placeholder, ctypes.c_void_p
        ).value or 0
        self._runtime_global_storage[0] = placeholder_addr
        runtime_addr = ctypes.addressof(self._runtime_global_storage)
        runtime_value = int(
            self._runtime_global_storage[0]) if self._runtime_global_storage[0] is not None else 0
        llvm.add_symbol("runtime", runtime_addr)
        self._debug_log(
            f"[stage2] register global runtime: addr=0x{int(runtime_addr):x} value=0x{runtime_value:x} placeholder=0x{int(placeholder_addr):x}"
        )

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

            def _marker_suffix() -> str:
                try:
                    markers = self._recent_debug_markers()
                    if not markers:
                        return " recent_markers=[]"
                    return f" recent_markers={list(markers)}"
                except Exception:
                    return " recent_markers=[]"

            self._debug_log(
                f"[stage2] ptr_to_str ENTER 0x{address:x} tracked={address in self._tracked_string_addresses} "
                f"in_allocs={address in _LIBC_ALLOCATIONS}"
            )
            if address == 0:
                return ""

            meta = self._tracked_string_addresses.get(address)
            if meta is not None:
                self._debug_log(
                    f"[stage2] ptr_to_str reuse 0x{address:x} kind={meta[0]} len={meta[2]}"
                )
                return meta[1]

            def _bytes_from_known_span(ptr_address: int, limit: int | None = None) -> bytes | None:
                """Read bytes from a pointer only when we can prove the span is valid.

                IMPORTANT: `ctypes.string_at` can segfault if the address is not
                readable. Only call it for addresses that fall within:
                - allocations made via our libc malloc wrapper (`_LIBC_ALLOCATIONS`)
                - owned host buffers kept alive in `_string_pool` / `_adapter_string_buffers`
                """

                if ptr_address <= 0:
                    return None

                def _bounded_read(max_available: int) -> bytes | None:
                    read_size = max_available if limit is None else min(
                        max_available, max(limit, 0))
                    if read_size <= 0:
                        return None
                    try:
                        return ctypes.string_at(ptr_address, read_size)
                    except (ValueError, OSError):
                        return None

                record = _LIBC_ALLOCATIONS.get(ptr_address)
                if record is not None:
                    return _bounded_read(record.size)

                for user_ptr, record in list(_LIBC_ALLOCATIONS.items()):
                    start = int(user_ptr)
                    end = start + int(record.size)
                    if start <= ptr_address < end:
                        return _bounded_read(end - ptr_address)

                # Host-owned buffers (cstring ABI). Allow interior pointers.
                for buf in list(self._string_pool) + list(self._adapter_string_buffers):
                    if not isinstance(buf, ctypes.Array):
                        continue
                    if getattr(buf, "_type_", None) is not ctypes.c_char:
                        continue
                    try:
                        buf_addr = ctypes.addressof(buf)
                        buf_size = ctypes.sizeof(buf)
                    except Exception:
                        continue
                    if buf_addr <= ptr_address < buf_addr + buf_size:
                        return _bounded_read(buf_addr + buf_size - ptr_address)

                return None

            if Stage2StringType is not None:
                try:
                    struct_ptr = ctypes.cast(
                        ctypes.c_void_p(address), ctypes.POINTER(
                            Stage2StringType)
                    )
                    struct_value = struct_ptr.contents
                except (ValueError, OSError, ctypes.ArgumentError):
                    struct_value = None

                if struct_value is not None:
                    data_address = _normalise_ptr(struct_value.data)
                    length = int(struct_value.length)
                    self._debug_log(
                        f"[stage2] ptr_to_str struct candidate 0x{address:x} data=0x{data_address:x} len={length}"
                    )
                    if data_address in self._tracked_string_addresses:
                        text = self._tracked_string_addresses[data_address][1]
                        self._tracked_string_addresses[address] = (
                            "struct", text, length)
                        self._debug_log(
                            f"[stage2] ptr_to_str struct cached 0x{address:x} -> data 0x{data_address:x} len={length}"
                        )
                        return text
                    if data_address != 0 and 0 <= length <= 1 << 30:
                        raw_bytes = _bytes_from_known_span(
                            data_address, length)
                        if raw_bytes is not None:
                            slice_length = min(length, len(raw_bytes))
                            raw = raw_bytes[:slice_length]
                            text = raw.decode("utf-8", errors="ignore")
                            self._tracked_string_addresses[address] = (
                                "struct", text, slice_length)
                            self._debug_log(
                                f"[stage2] ptr_to_str struct decode 0x{address:x} -> data 0x{data_address:x} len={slice_length}"
                            )
                            return text

            allocation_bytes = _bytes_from_known_span(address)
            if allocation_bytes is not None:
                raw, _, _ = allocation_bytes.partition(b"\0")
                text = raw.decode("utf-8", errors="ignore")
                self._tracked_string_addresses[address] = (
                    "cstring", text, len(raw))
                self._debug_log(
                    f"[stage2] ptr_to_str cstring decode 0x{address:x} size={len(raw)}"
                )
                return text

            # Untracked address - might be an LLVM string literal (safe) or invalid pointer (unsafe).
            # Reject NULL and very low addresses (definitely invalid).
            if address == 0 or address < 0x1000:
                message = f"runtime string pointer 0x{address:x} is NULL or invalid"
                self._debug_log(f"[stage2] {message}{_marker_suffix()}")
                error = RuntimeError(message)
                if _LAST_RUNTIME_ERROR.get() is None:
                    _LAST_RUNTIME_ERROR.set(error)
                return ""

            # Check if address looks like it could be a valid heap pointer
            # On most systems, heap addresses are > 0x10000 and < 0x7fffffffffff (48-bit)
            if address > 0x7fffffffffff:
                message = f"runtime string pointer 0x{address:x} is suspiciously high (possible stack/garbage)"
                self._debug_log(f"[stage2] {message}{_marker_suffix()}")
                error = RuntimeError(message)
                if _LAST_RUNTIME_ERROR.get() is None:
                    _LAST_RUNTIME_ERROR.set(error)
                return ""

            # Check if this address might be in our known string pools
            is_likely_valid = False
            for buf in self._string_pool:
                buf_addr = ctypes.cast(buf, ctypes.c_void_p).value or 0
                if buf_addr == address:
                    is_likely_valid = True
                    break

            if not is_likely_valid:
                self._debug_log(
                    f"[stage2] ptr_to_str WARNING: untracked address 0x{address:x} not in string pool or allocations{_marker_suffix()}"
                )

            self._debug_log(
                f"[stage2] ptr_to_str untracked 0x{address:x} (likely_valid={is_likely_valid})"
            )

            # `ctypes.string_at` can segfault the interpreter if the address is
            # not readable. On Linux we can prove readability by consulting
            # `/proc/self/maps` and bounding reads to the mapped region.
            # This lets us decode JIT/global string literals without risking a
            # hard crash in CI.
            if sys.platform.startswith("linux"):
                try:
                    max_total = 256 * 1024  # cap to keep failures cheap

                    def _linux_readable_span(ptr_address: int) -> int:
                        try:
                            with open("/proc/self/maps", "r", encoding="utf-8") as handle:
                                for line in handle:
                                    parts = line.split(None, 2)
                                    if len(parts) < 2:
                                        continue
                                    addr_range, perms = parts[0], parts[1]
                                    if "r" not in perms:
                                        continue
                                    if "-" not in addr_range:
                                        continue
                                    lo_s, hi_s = addr_range.split("-", 1)
                                    try:
                                        lo = int(lo_s, 16)
                                        hi = int(hi_s, 16)
                                    except ValueError:
                                        continue
                                    if lo <= ptr_address < hi:
                                        return max(0, hi - ptr_address)
                        except OSError:
                            return 0
                        return 0

                    span = _linux_readable_span(address)
                    if span > 0:
                        read_size = min(span, max_total)
                        raw_bytes = ctypes.string_at(address, read_size)
                        null_pos = raw_bytes.find(b"\0")
                        if null_pos >= 0:
                            raw_bytes = raw_bytes[:null_pos]
                        text = raw_bytes.decode("utf-8", errors="ignore")
                        self._tracked_string_addresses[address] = (
                            "mapped_cstring", text, len(raw_bytes)
                        )
                        self._debug_log(
                            f"[stage2] ptr_to_str mapped_cstring 0x{address:x} size={len(raw_bytes)} span={span}"
                        )
                        return text
                except Exception as exc:
                    self._debug_log(
                        f"[stage2] ptr_to_str linux mapped read failed 0x{address:x}: {type(exc).__name__}{_marker_suffix()}"
                    )

            # Otherwise, refuse to touch arbitrary pointers.

            message = (
                f"runtime string pointer 0x{address:x} not tracked and unreadable"
                f"{_marker_suffix()}"
            )
            self._debug_log(f"[stage2] {message}")
            error = RuntimeError(message)
            if _LAST_RUNTIME_ERROR.get() is None:
                _LAST_RUNTIME_ERROR.set(error)
            return ""

        # Storage for string buffers to keep them alive (stored on runner instance)
        # Helper to convert Python string to pointer integer
        def _str_to_ptr(s: str) -> int:
            encoded = s.encode("utf-8")

            # Validate buffer size before creation
            size = len(encoded) + 1  # +1 for null terminator
            if size > 200_000_000:  # 200MB limit
                self._debug_log(
                    f"[stage2] _str_to_ptr: REJECTED string size={size} bytes ({size // 1024} KB)")
                return 0  # Return NULL instead of creating huge buffer
            if size > 10_000_000:  # 10MB warning
                self._debug_log(
                    f"[stage2] _str_to_ptr: LARGE string size={size} bytes ({size // 1024} KB)")

            # Use ctypes buffers to keep strings alive
            buf = ctypes.create_string_buffer(encoded + b"\0")

            # CRITICAL: Add to permanent string pool - strings never freed until runner destroyed
            # This solves the LLVM memory lifecycle issue where returned pointers become invalid
            self._string_pool.append(buf)
            self._adapter_string_buffers.append(buf)  # Keep for compatibility

            if size > 50_000:  # Log large strings
                self._debug_log(
                    f"[stage2] _str_to_ptr: POOL added large string size={size} bytes (pool_size={len(self._string_pool)})")

            data_address = ctypes.cast(buf, ctypes.c_void_p).value
            data_int = 0 if data_address is None else int(data_address)
            if data_int != 0:
                self._tracked_string_addresses[data_int] = (
                    "cstring", s, len(encoded))
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
            struct_int = 0 if struct_address is None else int(struct_address)
            if struct_int != 0:
                self._tracked_string_addresses[struct_int] = (
                    "struct", s, len(encoded))
            return struct_int

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

        def _record_adapter_exception(context: str, exc: Exception) -> None:
            message = f"[stage2] {context} error: {type(exc).__name__}: {exc}"
            self._debug_log(message)
            if _LAST_RUNTIME_ERROR.get() is None:
                _LAST_RUNTIME_ERROR.set(exc)

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
                    _record_adapter_exception("fs.read_file", exc)
                    return _str_to_ptr("")

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
                    return _list_to_array(list(entries or []))
                except Exception as exc:
                    _record_adapter_exception("fs.list_directory", exc)
                    return _list_to_array([])

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
                    status = "tracked" if address in self._tracked_string_addresses else (
                        "alloc" if address in _LIBC_ALLOCATIONS else "unknown"
                    )
                    _require_effects()
                    text = _ptr_to_str(value_ptr)
                    preview = text[:40] if isinstance(text, str) else ""
                    self._debug_log(
                        f"[stage2] runtime string_length ptr=0x{address:x} status={status} len={len(text)} preview={preview!r}"
                    )
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
                    return _str_to_ptr(result or "")
                except Exception as exc:
                    _record_adapter_exception("runtime substring", exc)
                    return _str_to_ptr("")

            return cfunc_type(_substring)

        elif symbol == "sailfin_runtime_string_concat":
            cfunc_type = ctypes.CFUNCTYPE(
                ctypes.c_void_p, ctypes.c_void_p, ctypes.c_void_p)

            def _string_concat(first_ptr: ctypes.c_void_p, second_ptr: ctypes.c_void_p) -> int:
                try:
                    _require_effects()
                    first = _ptr_to_str(first_ptr)
                    second = _ptr_to_str(second_ptr)

                    # Validate string lengths before concatenating
                    if len(first) > 100_000_000 or len(second) > 100_000_000:
                        self._debug_log(
                            f"[stage2] string_concat: LARGE strings detected first={len(first)} second={len(second)}")
                    result = first + second
                    if len(result) > 100_000_000:
                        self._debug_log(
                            f"[stage2] string_concat: LARGE result={len(result)} bytes")

                    return _str_to_ptr(result)
                except Exception as exc:
                    _record_adapter_exception("runtime string_concat", exc)
                    return _str_to_ptr("")

            return cfunc_type(_string_concat)

        elif symbol == "sailfin_runtime_copy_bytes":
            cfunc_type = ctypes.CFUNCTYPE(
                None, ctypes.c_void_p, ctypes.c_void_p, ctypes.c_longlong
            )

            def _copy_bytes(dest_ptr: ctypes.c_void_p, src_ptr: ctypes.c_void_p, length: ctypes.c_longlong) -> None:
                try:
                    _require_effects()
                    dest = _normalise_ptr(dest_ptr)
                    src = _normalise_ptr(src_ptr)
                    count = int(length)
                    if dest == 0 or src == 0 or count <= 0:
                        return
                    ctypes.memmove(dest, src, count)
                except Exception as exc:
                    if _LAST_RUNTIME_ERROR.get() is None:
                        _LAST_RUNTIME_ERROR.set(exc)

            return cfunc_type(_copy_bytes)

        elif symbol == "char_at":
            cfunc_type = ctypes.CFUNCTYPE(
                ctypes.c_void_p, ctypes.c_void_p, ctypes.c_double)

            def _char_at(text_ptr: ctypes.c_void_p, index: ctypes.c_double) -> int:
                try:
                    _require_effects()
                    text = _ptr_to_str(text_ptr)
                    idx = int(index)
                    if not isinstance(text, str) or idx < 0 or idx >= len(text):
                        return _str_to_ptr("")
                    return _str_to_ptr(text[idx: idx + 1])
                except Exception as exc:
                    _record_adapter_exception("runtime char_at", exc)
                    return _str_to_ptr("")

            return cfunc_type(_char_at)

        elif symbol == "is_symbol_char":
            cfunc_type = ctypes.CFUNCTYPE(ctypes.c_bool, ctypes.c_void_p)

            def _is_symbol_char(ch_ptr: ctypes.c_void_p) -> bool:
                try:
                    _require_effects()
                    ch = _ptr_to_str(ch_ptr)
                    if not ch:
                        return False
                    if ch == "_":
                        return True
                    code = runtime.char_code(ch)
                    lower_a = runtime.char_code("a")
                    lower_z = runtime.char_code("z")
                    if lower_a <= code <= lower_z:
                        return True
                    upper_a = runtime.char_code("A")
                    upper_z = runtime.char_code("Z")
                    if upper_a <= code <= upper_z:
                        return True
                    zero = runtime.char_code("0")
                    nine = runtime.char_code("9")
                    if zero <= code <= nine:
                        return True
                    return False
                except Exception as exc:
                    _record_adapter_exception("runtime is_symbol_char", exc)
                    return False

            return cfunc_type(_is_symbol_char)

        elif symbol == "sanitize_symbol":
            cfunc_type = ctypes.CFUNCTYPE(ctypes.c_void_p, ctypes.c_void_p)

            def _sanitize_symbol(name_ptr: ctypes.c_void_p) -> int:
                try:
                    _require_effects()
                    name = _ptr_to_str(name_ptr)
                    if not isinstance(name, str):
                        return _str_to_ptr("_")
                    if len(name) == 0:
                        return _str_to_ptr("_")

                    def _is_sym(ch: str) -> bool:
                        if not ch:
                            return False
                        if ch == "_":
                            return True
                        code = runtime.char_code(ch)
                        lower_a = runtime.char_code("a")
                        lower_z = runtime.char_code("z")
                        if lower_a <= code <= lower_z:
                            return True
                        upper_a = runtime.char_code("A")
                        upper_z = runtime.char_code("Z")
                        if upper_a <= code <= upper_z:
                            return True
                        zero = runtime.char_code("0")
                        nine = runtime.char_code("9")
                        if zero <= code <= nine:
                            return True
                        return False

                    result_chars: list[str] = []
                    for ch in name:
                        if _is_sym(ch):
                            result_chars.append(ch)
                    result = "".join(result_chars)
                    if len(result) == 0:
                        result = "_"
                    else:
                        first = result[0]
                        code = runtime.char_code(first)
                        zero = runtime.char_code("0")
                        nine = runtime.char_code("9")
                        if zero <= code <= nine:
                            result = "_" + result
                    return _str_to_ptr(result)
                except Exception as exc:
                    _record_adapter_exception("runtime sanitize_symbol", exc)
                    return _str_to_ptr("_")

            return cfunc_type(_sanitize_symbol)

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
                    _record_adapter_exception("runtime concat", exc)
                    return _handles_to_array(())

            return cfunc_type(_concat)

        elif symbol == "sailfin_runtime_append_string":
            append_debug_count = 0
            append_debug_limit = 200
            cfunc_type = ctypes.CFUNCTYPE(
                ctypes.c_void_p, ctypes.c_void_p, ctypes.c_void_p)

            def _append_string(array_ptr: ctypes.c_void_p, value_ptr: ctypes.c_void_p) -> int:
                nonlocal append_debug_count
                existing: list[str] | None = None
                try:
                    existing = _array_to_list(array_ptr)
                    appended = list(existing or [])
                    token_text = _ptr_to_str(value_ptr)
                    appended.append(token_text)
                    if append_debug_count < append_debug_limit:
                        preview = token_text[:64] if isinstance(
                            token_text, str) else ""
                        self._debug_log(
                            f"[stage2] runtime append_string array_len={len(existing or [])} -> {len(appended)} value={preview!r}"
                        )
                    append_debug_count += 1
                    return _list_to_array(appended)
                except Exception as exc:
                    _record_adapter_exception("runtime append_string", exc)
                    return _list_to_array(existing or [])

            return cfunc_type(_append_string)

        elif symbol == "sailfin_runtime_raise_value_error":
            cfunc_type = ctypes.CFUNCTYPE(None, ctypes.c_void_p)

            def _raise_value_error(message_ptr: ctypes.c_void_p) -> None:
                try:
                    _require_effects()
                    address = _normalise_ptr(message_ptr)
                    status = "tracked" if address in self._tracked_string_addresses else (
                        "alloc" if address in _LIBC_ALLOCATIONS else "unknown"
                    )
                    text = _ptr_to_str(message_ptr)
                    preview = text[:160] if isinstance(text, str) else ""
                    self._debug_log(
                        f"[stage2] runtime raise_value_error ptr=0x{address:x} status={status} message={preview!r}"
                    )
                    detail = text if text else f"(ptr=0x{address:x} status={status})"
                    try:
                        runtime.console.error(
                            f"[stage2-runtime] raise_value_error ptr=0x{address:x} status={status}: {detail}"
                        )
                    except Exception:
                        pass
                    error = ValueError(
                        f"Stage2 runtime value error ptr=0x{address:x} status={status}: {text}"
                    )
                    if _LAST_RUNTIME_ERROR.get() is None:
                        _LAST_RUNTIME_ERROR.set(error)
                except Exception as exc:
                    if _LAST_RUNTIME_ERROR.get() is None:
                        _LAST_RUNTIME_ERROR.set(exc)

            return cfunc_type(_raise_value_error)

        elif symbol == "abort":
            cfunc_type = ctypes.CFUNCTYPE(None)

            def _abort() -> None:
                try:
                    message = "[stage2-runtime] abort() invoked"
                    self._debug_log(message)
                    try:
                        runtime.console.error(message)
                    except Exception:
                        pass
                    stack = "".join(traceback.format_stack(limit=12))
                    if stack:
                        self._debug_log(stack.rstrip())
                    error = RuntimeError("Stage2 invoked abort()")
                    if _LAST_RUNTIME_ERROR.get() is None:
                        _LAST_RUNTIME_ERROR.set(error)
                    raise RuntimeError("Stage2 invoked abort()")
                except Exception as exc:
                    if _LAST_RUNTIME_ERROR.get() is None:
                        _LAST_RUNTIME_ERROR.set(exc)
                    raise

            return cfunc_type(_abort)

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
            digit_debug_count = 0
            digit_debug_limit = 200
            cfunc_type = ctypes.CFUNCTYPE(ctypes.c_bool, ctypes.c_byte)

            def _is_decimal_digit(value: ctypes.c_byte) -> bool:
                nonlocal digit_debug_count
                try:
                    code = int(value) & 0xFF
                    ch = chr(code)
                    result = '0' <= ch <= '9'
                    if digit_debug_count < digit_debug_limit:
                        display = repr(
                            ch) if 32 <= code < 127 else f"\\x{code:02x}"
                        self._debug_log(
                            f"[stage2] runtime is_decimal_digit ch=0x{code:02x} ({display}) -> {result}"
                        )
                    digit_debug_count += 1
                    return result
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
                    _record_adapter_exception("runtime grapheme_at", exc)
                    return _str_to_ptr("")

            return cfunc_type(_grapheme_at)

        elif symbol == "sailfin_runtime_is_whitespace_char":
            whitespace_debug_count = 0
            whitespace_debug_limit = 200
            cfunc_type = ctypes.CFUNCTYPE(ctypes.c_bool, ctypes.c_byte)

            def _is_whitespace_char(value: ctypes.c_byte) -> bool:
                nonlocal whitespace_debug_count
                try:
                    code = int(value) & 0xFF
                    ch = chr(code)
                    # Match ASCII whitespace plus newline and carriage return.
                    result = ch.isspace()
                    if whitespace_debug_count < whitespace_debug_limit:
                        display = repr(ch) if 32 <= code < 127 else (
                            "\\n" if ch == "\n" else "\\r" if ch == "\r" else f"\\x{code:02x}"
                        )
                        self._debug_log(
                            f"[stage2] runtime is_whitespace_char ch=0x{code:02x} ({display}) -> {result}"
                        )
                    whitespace_debug_count += 1
                    return result
                except Exception as exc:
                    if _LAST_RUNTIME_ERROR.get() is None:
                        _LAST_RUNTIME_ERROR.set(exc)
                    return False

            return cfunc_type(_is_whitespace_char)

        elif symbol == "strings_equal":
            cfunc_type = ctypes.CFUNCTYPE(
                ctypes.c_bool, ctypes.c_void_p, ctypes.c_void_p)

            def _strings_equal(left_ptr: ctypes.c_void_p, right_ptr: ctypes.c_void_p) -> bool:
                try:
                    left = _ptr_to_str(left_ptr)
                    right = _ptr_to_str(right_ptr)
                    return left == right
                except Exception as exc:
                    if _LAST_RUNTIME_ERROR.get() is None:
                        _LAST_RUNTIME_ERROR.set(exc)
                    return False

            return cfunc_type(_strings_equal)

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
                    _record_adapter_exception("http.get", exc)
                    return _str_to_ptr("")

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
                    _record_adapter_exception("http.post", exc)
                    return _str_to_ptr("")

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
                    _record_adapter_exception("model.invoke_with_prompt", exc)
                    return _str_to_ptr("")

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
                    _record_adapter_exception("serve.handler_dispatch", exc)
                    return _str_to_ptr("")

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
                    return _store_handle(ch)
                except Exception as exc:
                    _record_adapter_exception("channel.create", exc)
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
                    _record_adapter_exception("channel.receive", exc)
                    return _str_to_ptr("")

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
                marker_value = int(code)
                self._last_debug_marker = marker_value
                self._debug_marker_history.append(marker_value)
                limit = getattr(self, "_debug_marker_history_limit", 64)
                overflow = len(self._debug_marker_history) - limit
                if overflow > 0:
                    del self._debug_marker_history[:overflow]
                self._debug_log(f"[stage2] debug_marker code={marker_value}")

            return cfunc_type(_debug_marker)

        elif symbol == "stage2_debug_token":
            cfunc_type = ctypes.CFUNCTYPE(
                None, ctypes.c_longlong, ctypes.c_longlong, ctypes.c_void_p)

            def _debug_token(index: ctypes.c_longlong, kind: ctypes.c_longlong, lexeme_ptr: ctypes.c_void_p) -> None:
                try:
                    token_index = int(index)
                except Exception:
                    token_index = 0
                try:
                    token_kind = int(kind)
                except Exception:
                    token_kind = -1
                address = _normalise_ptr(lexeme_ptr)
                status = "tracked" if address in self._tracked_string_addresses else (
                    "alloc" if address in _LIBC_ALLOCATIONS else "unknown"
                )
                preview = ""
                note = ""
                tracked = status == "tracked" or address in _LIBC_ALLOCATIONS
                if address and tracked and address >= 0x1000:
                    try:
                        raw = ctypes.string_at(address, 64)
                        preview = raw.decode("utf-8", errors="replace")
                    except (ValueError, OSError) as exc:
                        note = f" read_error={exc}"
                self._debug_log(
                    f"[stage2] debug_token index={token_index} kind={token_kind} ptr=0x{address:x} status={status} preview={preview!r}{note}"
                )

            return cfunc_type(_debug_token)

        elif symbol == "stage2_debug_unknown_lexeme":
            cfunc_type = ctypes.CFUNCTYPE(
                None, ctypes.c_void_p, ctypes.c_longlong)

            def _debug_unknown_lexeme(ptr: ctypes.c_void_p, length: ctypes.c_longlong) -> None:
                try:
                    address = _normalise_ptr(ptr)
                    raw_length = max(0, int(length))
                    preview_length = min(raw_length, 256)
                    preview_bytes = b""
                    if address != 0 and preview_length > 0:
                        try:
                            preview_bytes = ctypes.string_at(
                                address, preview_length)
                        except (ValueError, OSError):
                            preview_bytes = b""
                    preview_text = preview_bytes.decode(
                        "utf-8", errors="replace") if preview_bytes else ""
                    safe_preview = preview_text.encode(
                        "unicode_escape").decode("ascii", errors="ignore")
                    truncated = raw_length > preview_length
                    trunc_note = " [truncated]" if truncated else ""
                    self._debug_log(
                        f"[stage2] unknown lexeme ptr=0x{address:x} len={raw_length} preview_limit={preview_length} text=\"{safe_preview}\"{trunc_note}"
                    )
                except Exception as exc:
                    if _LAST_RUNTIME_ERROR.get() is None:
                        _LAST_RUNTIME_ERROR.set(exc)

            return cfunc_type(_debug_unknown_lexeme)

        elif symbol == "sailfin_runtime_mark_persistent":
            cfunc_type = ctypes.CFUNCTYPE(None, ctypes.c_void_p)

            def _mark_persistent_wrapper(ptr: ctypes.c_void_p) -> None:
                try:
                    address = _normalise_ptr(ptr)
                    if address != 0:
                        self._debug_log(
                            f"[stage2] mark_persistent ptr=0x{address:x}")
                        self.mark_persistent(address)
                except Exception as exc:
                    if _LAST_RUNTIME_ERROR.get() is None:
                        _LAST_RUNTIME_ERROR.set(exc)

            return cfunc_type(_mark_persistent_wrapper)

        return _build_fallback()

    def _rewrite_lowered_ir_modules(self) -> tuple[list[tuple[str, str, object | None]], Dict[str, list[str]]]:
        """Rewrite lowered IR modules for safe linking.

        Returns (candidates, duplicate_registry) where candidates include optional
        source hints for diagnostics.
        """

        constant_definitions = self._collect_global_constant_definitions(
            self._lowered_modules
        )
        function_signatures: "OrderedDict[str, str]" = self._collect_function_signatures(
            self._lowered_modules
        )
        type_definitions: "OrderedDict[str, str]" = self._collect_type_definitions(
            self._lowered_modules
        )

        self._debug_log(
            f"[stage2] lowered modules: {len(self._lowered_modules)}")

        candidates: list[tuple[str, str, object | None]] = []
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
                module_ir,
                definitions=constant_definitions,
                already_defined=defined_globals,
            )
            defined_globals.update(injected)

            rewritten_ir, duplicates = self._rewrite_function_linkage(
                patched_ir, defined_symbols, function_signatures
            )
            rewritten_ir = self._inject_missing_type_definitions(
                rewritten_ir, type_definitions
            )
            rewritten_ir = self._inject_missing_function_declarations(
                rewritten_ir, function_signatures
            )

            # On arm64, calling stage2 functions that return aggregates directly via
            # ctypes can segfault before the function body executes (ABI mismatch).
            # Inject lightweight wrappers that return a plain pointer to a heap-
            # allocated copy of the aggregate so Python can safely rehydrate it.
            rewritten_ir = self._inject_aggregate_return_wrappers(rewritten_ir)

            if not self._disable_instrumentation:
                rewritten_ir = self._instrument_lex_ir(rewritten_ir)
                rewritten_ir = self._instrument_compile_pipeline_ir(
                    rewritten_ir)
                rewritten_ir = self._instrument_parse_tokens_ir(rewritten_ir)
                rewritten_ir = self._instrument_tokens_to_text_ir(rewritten_ir)
                rewritten_ir = self._instrument_skip_trivia_ir(rewritten_ir)
                rewritten_ir = self._instrument_is_trivia_token_ir(
                    rewritten_ir)
                rewritten_ir = self._instrument_parse_block_ir(rewritten_ir)
                rewritten_ir = self._instrument_parse_unknown_ir(rewritten_ir)
                rewritten_ir = self._instrument_parse_program_ir(rewritten_ir)
                rewritten_ir = self._instrument_parse_statement_ir(
                    rewritten_ir)

            self._register_type_definitions(rewritten_ir, type_definitions)

            label = (
                getattr(lowered, "module_name", None)
                or getattr(lowered, "module", None)
                or getattr(lowered, "name", None)
                or f"module_{index}"
            )

            # Optional: dump the final rewritten module for debugging.
            # This is intentionally best-effort and only active when
            # SAILFIN_STAGE2_DUMP_INSTRUMENTED_IR (or SAILFIN_STAGE2_INSTRUMENT_DIR)
            # configured a dump directory.
            dump_suffix = self._sanitize_symbol_suffix(str(label))
            self._write_instrumented_ir(
                f"rewritten_{index:02d}_{dump_suffix}.ll", rewritten_ir
            )

            if duplicates:
                duplicate_registry[str(label)] = duplicates

            source_hint = getattr(lowered, "source_path", None)
            if source_hint is None:
                source_hint = getattr(lowered, "path", None)
            if source_hint is None:
                source_hint = getattr(lowered, "source", None)

            candidates.append((str(label), rewritten_ir, source_hint))

            if source_hint is not None:
                self._debug_log(
                    f"[stage2] candidate {label} from {source_hint}")
            else:
                self._debug_log(f"[stage2] candidate {label}")
            if duplicates:
                self._debug_log(
                    f"[stage2] rewrote {len(duplicates)} duplicate function(s) in {label}"
                )

        return candidates, duplicate_registry

    def _inject_aggregate_return_wrappers(self, ir_text: str) -> str:
        machine = platform.machine().lower()
        if machine not in {"arm64", "aarch64"}:
            return ir_text

        # Only inject wrappers for the stage2 entrypoints that our Python tests
        # call and that return aggregates.
        targets = (
            "compile_to_native",
            "compile_to_native_llvm",
            "compile_to_native_python",
        )
        updated = ir_text
        for symbol in targets:
            updated = self._inject_aggregate_return_wrapper(updated, symbol)
        return updated

    @staticmethod
    def _inject_aggregate_return_wrapper(ir_text: str, symbol: str) -> str:
        wrapper_name = f"__stage2_wrapper_{symbol}"
        if f"@{wrapper_name}(" in ir_text:
            return ir_text

        at = ir_text.find(f"@{symbol}(")
        if at == -1:
            return ir_text

        define_start = ir_text.rfind("define ", 0, at)
        if define_start == -1:
            return ir_text

        signature_end = ir_text.find("{", define_start)
        if signature_end == -1:
            return ir_text
        signature_line = ir_text[define_start:signature_end].strip()
        if f"@{symbol}(" not in signature_line:
            return ir_text

        after_define = signature_line[len("define "):]
        at_index = after_define.find("@")
        if at_index == -1:
            return ir_text
        ret_segment = after_define[:at_index].strip()
        if "{" in ret_segment:
            ret_type = ret_segment[ret_segment.find("{"):].strip()
        else:
            tokens = ret_segment.split()
            if not tokens:
                return ir_text
            ret_type = tokens[-1]

        # If the function doesn't return an aggregate, do nothing.
        if ret_type in {"void", "i1", "i8", "i16", "i32", "i64", "double", "float", "i8*", "ptr"}:
            return ir_text

        # Parse parameter types from the definition line.
        open_paren = signature_line.find("(", at_index)
        close_paren = signature_line.rfind(")")
        if open_paren == -1 or close_paren == -1 or close_paren < open_paren:
            return ir_text
        params_raw = signature_line[open_paren + 1: close_paren].strip()
        param_types: list[str] = []
        if params_raw:
            for part in params_raw.split(","):
                part = part.strip()
                if not part:
                    continue
                # Strip any parameter name (e.g. "i8* %source" -> "i8*").
                param_types.append(part.split()[0])

        wrapper_params = ", ".join(
            f"{ty} %arg{i}" for i, ty in enumerate(param_types))
        call_args = ", ".join(f"{ty} %arg{i}" for i,
                              ty in enumerate(param_types))

        # Ensure malloc is declared (stage2 IR generally has it, but be defensive).
        # Be careful: stage2 often declares malloc with attributes (e.g. `declare noalias i8* @malloc(i64)`),
        # so a naive substring check can accidentally insert a duplicate declaration and break parsing.
        has_malloc_decl = re.search(
            r"^\s*(declare|define)\b.*@malloc\s*\(", ir_text, flags=re.MULTILINE)
        if not has_malloc_decl:
            ir_text = ir_text.rstrip() + "\n\ndeclare i8* @malloc(i64)\n"

        wrapper_ir = (
            f"\n; stage2 wrapper for arm64 aggregate return\n"
            f"define i8* @{wrapper_name}({wrapper_params}) {{\n"
            f"block.entry:\n"
            f"  %t0 = call {ret_type} @{symbol}({call_args})\n"
            f"  %t1 = getelementptr {ret_type}, {ret_type}* null, i32 1\n"
            f"  %t2 = ptrtoint {ret_type}* %t1 to i64\n"
            f"  %t3 = call i8* @malloc(i64 %t2)\n"
            f"  %t4 = bitcast i8* %t3 to {ret_type}*\n"
            f"  store {ret_type} %t0, {ret_type}* %t4\n"
            f"  ret i8* %t3\n"
            f"}}\n"
        )

        # Append wrapper after the defining function to keep IR locality.
        insertion_point = ir_text.find("\n}\n", define_start)
        if insertion_point == -1:
            return ir_text.rstrip() + wrapper_ir
        insertion_point += 3
        return ir_text[:insertion_point] + wrapper_ir + ir_text[insertion_point:]

    def _compile_ir(self) -> None:
        candidates_with_sources, duplicate_registry = self._rewrite_lowered_ir_modules()

        valid_candidates: list[tuple[str, str]] = []
        skipped: list[tuple[str, str]] = []

        for label, ir_text, _source_hint in candidates_with_sources:
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
                # Treat local/private functions as module-scoped; they cannot collide across modules
                try:
                    func_linkage = str(function.linkage)
                except Exception:
                    func_linkage = ""
                if func_linkage in {"internal", "private"}:
                    # Do not record in seen_functions; keep original local name
                    continue
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
                # Treat local/private globals as module-scoped; they cannot collide across modules
                try:
                    glob_linkage = str(global_var.linkage)
                except Exception:
                    glob_linkage = ""
                if glob_linkage in {"internal", "private"}:
                    # Do not record in seen_globals; keep original local name
                    continue
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

        # CRITICAL: Register LLVM string literals to prevent segfaults
        # After finalization, enumerate all global string constants and register
        # their addresses so _ptr_to_str() can safely dereference them
        registered_count = 0
        for module in modules:
            for global_var in module.global_variables:
                try:
                    # Check if this is a string constant (array of i8)
                    var_type_str = str(global_var.type)
                    if not var_type_str.startswith('[') or ' x i8]' not in var_type_str:
                        continue  # Not a string constant

                    # Get the address of this global variable
                    global_name = global_var.name
                    try:
                        address = engine.get_global_value_address(global_name)
                    except Exception:
                        continue  # Can't get address, skip

                    if address == 0:
                        continue  # Invalid address

                    # Read the string content and register it
                    try:
                        c_str_ptr = ctypes.cast(address, ctypes.c_char_p)
                        raw_bytes = c_str_ptr.value
                        if raw_bytes is not None:
                            text = raw_bytes.decode("utf-8", errors="ignore")
                            self._tracked_string_addresses[address] = (
                                "llvm_global", text, len(raw_bytes))
                            registered_count += 1
                    except Exception:
                        pass  # Failed to read, skip

                except Exception:
                    continue  # Error processing this global, skip

        self._debug_log(
            f"[stage2] registered {registered_count} LLVM string literal(s)"
        )

        if skipped:
            preview = ", ".join(
                f"{name} ({reason})" for name, reason in skipped[:5])
            runtime.console.warn(
                f"[stage2] skipped {len(skipped)} module(s): {preview}")

        if duplicate_registry:
            for module_label, duplicates in sorted(duplicate_registry.items()):
                if not duplicates:
                    continue
                preview = ", ".join(duplicates[:5])
                self._debug_log(
                    f"[stage2] linkage duplicates {module_label}: {len(duplicates)} symbol(s), e.g. {preview}"
                )

        if final_duplicates:
            renamed_preview = ", ".join(final_duplicates[:10])
            self._debug_log(
                f"[stage2] applied {len(final_duplicates)} post-link rename(s): {renamed_preview}"
            )
            histogram = Counter()
            for entry in final_duplicates:
                original, _, renamed = entry.partition("->")
                if not original:
                    continue
                histogram[original] += 1
            if histogram:
                top = ", ".join(
                    f"{name}×{count}" for name, count in histogram.most_common(10)
                )
                self._debug_log(
                    f"[stage2] duplicate frequency: {top}"
                )

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
        call_restype: type[ctypes._SimpleCData] | None = restype
        function = None
        function_info = self._lookup_function_return(entry_point)
        aggregate_module = None
        aggregate_return_type = None
        aggregate_address = 0
        aggregate_buffer: ctypes.Array | None = None
        aggregate_size = 0
        use_aggregate = False
        use_wrapper = False
        if function_info is not None:
            aggregate_module, aggregate_return_type = function_info
            if self._is_aggregate_return_type(aggregate_return_type):
                machine = platform.machine().lower()
                is_arm64 = machine in {"arm64", "aarch64"}
                if is_arm64:
                    wrapper_name = f"__stage2_wrapper_{entry_point}"
                    wrapper_address = self._engine.get_function_address(
                        wrapper_name
                    )
                    if wrapper_address:
                        type_ref = self._resolve_struct_type(
                            aggregate_module, aggregate_return_type
                        )
                        abi_size, _ = self._compute_type_layout(type_ref)
                        aggregate_size = int(abi_size or 0)
                        if aggregate_size <= 0:
                            if restype is not None and isinstance(restype, type) and issubclass(restype, ctypes.Structure):
                                aggregate_size = ctypes.sizeof(restype)
                            else:
                                aggregate_size = ctypes.sizeof(
                                    ctypes.c_void_p) * 4

                        address = wrapper_address
                        call_restype = ctypes.c_void_p
                        use_wrapper = True
                        self._debug_log(
                            f"[stage2] aggregate entry {entry_point}: using wrapper {wrapper_name} addr=0x{address:x} declared={aggregate_return_type} size={aggregate_size}"
                        )

                if not use_wrapper:
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
                        invoke_args = (ctypes.c_void_p(
                            aggregate_address), *args)
                        self._debug_log(
                            f"[stage2] aggregate entry {entry_point}: declared={aggregate_return_type} size={aggregate_size} "
                            f"address=0x{address:x} sret=0x{aggregate_address:x}"
                        )
                        use_aggregate = True

        if not use_aggregate and function is None:
            cfunc_type = ctypes.CFUNCTYPE(
                call_restype, *argtypes) if call_restype is not None else ctypes.CFUNCTYPE(None, *argtypes)
            function = cfunc_type(address)
        if function is None:
            raise RuntimeError(
                f"could not materialise callable for {entry_point}")
        self._debug_log(
            f"[stage2] prepare call {entry_point}: func=0x{address:x} aggregate={use_aggregate} wrapper={use_wrapper} args={args} invoke_args={invoke_args}"
        )
        effects = self._manifest.get(entry_point, ())
        grant = runtime.create_capability_grant(effects)
        runner_token = _ACTIVE_RUNNER.set(self)
        token = _ACTIVE_GRANT.set(grant)
        error_token = _LAST_RUNTIME_ERROR.set(None)
        result = None
        runtime_error = None
        try:
            self._debug_log(
                f"[stage2] invoke {entry_point}: aggregate={use_aggregate} wrapper={use_wrapper}"
            )
            marker_addr = 0
            parse_addr = 0
            lex_addr = 0
            try:
                marker_addr = int(llvm.address_of_symbol(
                    "stage2_debug_marker") or 0)
            except Exception:
                marker_addr = -1
            try:
                parse_addr = int(
                    self._engine.get_function_address("parse_program") or 0
                )
            except Exception:
                parse_addr = -1
            try:
                lex_addr = int(self._engine.get_function_address("lex") or 0)
            except Exception:
                lex_addr = -1
            self._debug_log(
                f"[stage2] symbol addrs marker=0x{marker_addr:x} parse_program=0x{parse_addr:x} lex=0x{lex_addr:x}"
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
            _ACTIVE_RUNNER.reset(runner_token)
        if runtime_error is not None:
            raise runtime_error
        if use_aggregate:
            if aggregate_address == 0:
                raise RuntimeError(
                    f"aggregate invocation for {entry_point} produced null buffer (dest={aggregate_address})"
                )
            if restype is None:
                return aggregate_address
            extracted = self._extract_sret_result(
                aggregate_address, aggregate_size, restype)
            self._validate_structure_result(entry_point, extracted)
            return extracted

        if use_wrapper:
            if isinstance(result, ctypes.c_void_p):
                address_value = int(result.value or 0)
            else:
                address_value = int(result or 0)
            if address_value == 0:
                raise RuntimeError(
                    f"wrapper invocation for {entry_point} returned null pointer"
                )
            if restype is None:
                return address_value
            extracted = self._extract_sret_result(
                address_value, aggregate_size, restype)
            self._validate_structure_result(entry_point, extracted)
            return extracted

        self._validate_structure_result(entry_point, result)
        return result


# Compatibility alias; remove once external callers have migrated.
Stage2Runner = NativeRunner
