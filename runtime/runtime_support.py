"""Runtime helpers for the Sailfin bootstrap Python backend.

This module provides a small collection of helpers that the bootstrap
code generator targets when translating Sailfin programs into Python.
It is intentionally minimal and focuses on mirroring core language
constructs closely enough for experimentation.
"""

from __future__ import annotations

import asyncio
import atexit
import builtins
import dataclasses
import pathlib
import re
import time
from typing import Any, Awaitable, Callable, Dict, Iterable, List, Optional


# ---------------------------------------------------------------------------
# Console utilities
# ---------------------------------------------------------------------------


@dataclasses.dataclass
class _Console:
    """Simple console facade with Sailfin-style helpers."""

    def info(self, message: Any) -> None:
        print(message)

    def error(self, message: Any) -> None:
        print(message)

    def warn(self, message: Any) -> None:
        print(f"[warn] {message}")


console = _Console()

# Provide Sailfin literal aliases at the Python level so bootstrap- and
# stage1-generated modules can refer to `null` without injecting per-module
# shims. Booleans already map to the matching Python singletons, but Python
# lacks a built-in `null`, so expose it via the builtins table for lookups.
builtins.null = None


_PRIMITIVE_TYPE_ALIASES: Dict[str, tuple[type, ...]] = {
    "string": (str,),
    "number": (int, float),
    "boolean": (bool,),
    "void": (type(None),),
}


class _FileSystem:
    def __init__(self) -> None:
        self._writes: Dict[str, str] = {}

    def readFile(self, path: str) -> str:
        stored = self._writes.get(path)
        if stored is not None:
            return stored
        target = pathlib.Path(path)
        try:
            if target.exists():
                return target.read_text(encoding="utf-8")
        except OSError:
            pass
        return f"[mock] contents of {path}"

    def writeFile(self, path: str, contents: str) -> None:
        self._writes[path] = contents
        console.info(f"[fs] wrote {len(contents)} bytes to {path}")


fs = _FileSystem()


class _SimpleObject(dict):
    def __getattr__(self, item: str) -> Any:
        try:
            return self[item]
        except KeyError as err:  # pragma: no cover - defensive
            raise AttributeError(item) from err

    def __setattr__(self, key: str, value: Any) -> None:
        self[key] = value

    def __repr__(self) -> str:  # pragma: no cover - helper
        payload = ", ".join(f"{k}={v!r}" for k, v in self.items())
        return f"Object({payload})"


def make_object(**fields: Any) -> _SimpleObject:
    return _SimpleObject(fields)


# ---------------------------------------------------------------------------
# Concurrency helpers
# ---------------------------------------------------------------------------


class Channel:
    def __init__(self, capacity: Optional[int] = None):
        loop = _ensure_loop()
        maxsize = 0 if capacity is None else capacity
        # Queue is bound to the current running loop
        self._loop = loop
        self._queue: asyncio.Queue[Any] = asyncio.Queue(maxsize=maxsize)

    def send(self, value: Any) -> None:
        self._queue.put_nowait(value)

    async def receive(self) -> Any:
        return await self._queue.get()

    def close(self) -> None:
        pass


_TASKS: List[tuple[asyncio.AbstractEventLoop, asyncio.Task[Any]]] = []


def channel(capacity: Optional[int] = None) -> Channel:
    return Channel(capacity)


def spawn(coro_factory: Callable[[], Awaitable[Any]], name: Optional[str] = None) -> None:
    loop = _ensure_loop()
    task = loop.create_task(coro_factory())
    if name and hasattr(task, "set_name"):
        task.set_name(name)
    _TASKS.append((loop, task))

    def _cleanup(completed: asyncio.Task[Any]) -> None:
        for entry in list(_TASKS):
            if entry[1] is completed:
                _TASKS.remove(entry)
                break

    task.add_done_callback(_cleanup)


def parallel(tasks: Iterable[Callable[[], Any]]) -> List[Any]:
    return [task() for task in tasks]


def sleep(milliseconds: int) -> None:
    time.sleep(milliseconds / 1000)


@atexit.register
def _cancel_pending_tasks() -> None:
    if not _TASKS:
        return
    tasks_by_loop: Dict[asyncio.AbstractEventLoop, List[asyncio.Task[Any]]] = {}
    for loop, task in list(_TASKS):
        tasks_by_loop.setdefault(loop, []).append(task)
    for loop, tasks in tasks_by_loop.items():
        for task in tasks:
            if not task.done():
                task.cancel()
        if not tasks:
            continue
        try:
            if loop.is_running():
                continue
            loop.run_until_complete(asyncio.gather(*tasks, return_exceptions=True))
        except RuntimeError:
            # Loop already closed; nothing else to do.
            pass


# ---------------------------------------------------------------------------
# String interpolation helper
# ---------------------------------------------------------------------------

_INTERPOLATION_PATTERN = re.compile(r"{{\s*(.+?)\s*}}")


def format_string(template: str, local_scope: Dict[str, Any], global_scope: Dict[str, Any]) -> str:
    """Perform lightweight ``{{ expression }}`` interpolation.

    The helper evaluates expressions against the supplied local/global scope
    dictionaries.  Errors fall back to the original placeholder to avoid
    masking issues in user programs.
    """

    def _replace(match: re.Match[str]) -> str:
        expression = match.group(1)
        try:
            return str(eval(expression, global_scope, local_scope))  # noqa: S307 - controlled scope
        except Exception:
            return "{" + expression + "}"

    return _INTERPOLATION_PATTERN.sub(_replace, template)


# ---------------------------------------------------------------------------
# Pattern matching helpers (very small and incomplete)
# ---------------------------------------------------------------------------


def match_exhaustive_failed(value: Any) -> None:
    raise ValueError(f"Non-exhaustive match for value {value!r}")


def raise_value_error(message: str) -> None:
    raise ValueError(message)


# ---------------------------------------------------------------------------
# Enum helpers
# ---------------------------------------------------------------------------


@dataclasses.dataclass
class EnumField:
    name: str
    value: Any


class EnumInstance:
    __slots__ = ("_type", "_variant", "_fields", "_field_map")

    def __init__(self, enum_type: "EnumType", variant: str, fields: Iterable[EnumField]):
        normalized = [_coerce_field(entry) for entry in fields]
        self._type = enum_type
        self._variant = variant
        self._fields = normalized
        self._field_map = {field.name: field.value for field in normalized}

    @property
    def type(self) -> "EnumType":
        return self._type

    @property
    def variant(self) -> str:
        return self._variant

    @property
    def fields(self) -> List[EnumField]:
        mapped = self._field_map.get("fields")
        if mapped is not None:
            return mapped
        return self._fields

    def __getattr__(self, item: str) -> Any:
        try:
            return self._field_map[item]
        except KeyError as err:  # pragma: no cover - defensive
            raise AttributeError(item) from err

    def __repr__(self) -> str:
        payload = ", ".join(f"{field.name}={field.value!r}" for field in self._fields)
        return f"{self._type.name}.{self._variant}({payload})"


class EnumType:
    def __init__(self, name: str):
        self.name = name
        self._variant_fields: Dict[str, List[str]] = {}
        self.variants: Dict[str, Callable[..., EnumInstance]] = {}

    def register_variant(self, name: str, field_names: Iterable[str]) -> None:
        self._variant_fields[name] = list(field_names)

    def variant(self, name: str, field_names: List[str]) -> Callable[..., EnumInstance]:
        self.register_variant(name, field_names)

        def constructor(**kwargs: Any) -> EnumInstance:
            provided = [EnumField(field, kwargs.get(field)) for field in field_names]
            return EnumInstance(self, name, provided)

        constructor.__name__ = name
        self.variants[name] = constructor
        return constructor


def _coerce_field(entry: Any) -> EnumField:
    if isinstance(entry, EnumField):
        return entry
    if isinstance(entry, (tuple, list)) and len(entry) == 2:
        return EnumField(entry[0], entry[1])
    name = getattr(entry, "name", None)
    value = getattr(entry, "value", None)
    if name is not None:
        return EnumField(name, value)
    raise TypeError(f"Cannot interpret enum field entry: {entry!r}")


def enum_type(name: str) -> EnumType:
    return EnumType(name)


def enum_define_variant(enum_type: EnumType, variant_name: str, field_names: Iterable[str]) -> EnumType:
    constructor = enum_type.variant(variant_name, list(field_names))
    setattr(enum_type, variant_name, constructor)
    return enum_type


def enum_field(name: str, value: Any) -> EnumField:
    return EnumField(name=name, value=value)


def enum_instantiate(enum_type: EnumType, variant_name: str, provided: Iterable[Any]) -> EnumInstance:
    expected = enum_type._variant_fields.get(variant_name)
    provided_list = [_coerce_field(entry) for entry in provided]
    if not expected:
        return EnumInstance(enum_type, variant_name, provided_list)
    provided_map = {field.name: field.value for field in provided_list}
    ordered = [EnumField(name, provided_map.get(name)) for name in expected]
    return EnumInstance(enum_type, variant_name, ordered)


def enum_get_field(instance: EnumInstance, name: str) -> Any:
    for field in instance.fields:
        if field.name == name:
            return field.value
    return None


# ---------------------------------------------------------------------------
# Struct helper
# ---------------------------------------------------------------------------


@dataclasses.dataclass
class StructField:
    name: str
    value: Any


def _coerce_struct_field(entry: Any) -> StructField:
    if isinstance(entry, StructField):
        return entry
    if isinstance(entry, (tuple, list)) and len(entry) == 2:
        return StructField(entry[0], entry[1])
    name = getattr(entry, "name", None)
    value = getattr(entry, "value", None)
    if name is not None:
        return StructField(name, value)
    raise TypeError(f"Cannot interpret struct field entry: {entry!r}")


def struct_field(name: str, value: Any) -> StructField:
    return StructField(name=name, value=value)


def struct_repr(name: str, fields: Iterable[Any]) -> str:
    payload = ", ".join(
        f"{field.name}={field.value!r}"
        for field in (_coerce_struct_field(entry) for entry in fields)
    )
    return f"{name}({payload})"


# ---------------------------------------------------------------------------
# Utilities
# ---------------------------------------------------------------------------


def _ensure_loop() -> asyncio.AbstractEventLoop:
    try:
        return asyncio.get_running_loop()
    except RuntimeError:
        loop = asyncio.new_event_loop()
        asyncio.set_event_loop(loop)
        return loop


def _resolve_runtime_type(descriptor: str) -> Optional[type]:
    current: Any = globals()
    for part in descriptor.split('.'):
        if not part:
            return None
        if isinstance(current, dict):
            current = current.get(part)
        else:
            current = getattr(current, part, None)
        if current is None:
            return None
    return current if isinstance(current, type) else None


def resolve_runtime_type(descriptor: str) -> Optional[type]:
    return _resolve_runtime_type(descriptor)


def instance_of(value: Any, runtime_type: Optional[type]) -> bool:
    if runtime_type is None:
        return False
    return isinstance(value, runtime_type)


def is_string(value: Any) -> bool:
    return isinstance(value, str)


def is_number(value: Any) -> bool:
    return isinstance(value, (int, float))


def is_boolean(value: Any) -> bool:
    return isinstance(value, bool)


def is_void(value: Any) -> bool:
    return value is None


def is_array(value: Any) -> bool:
    return isinstance(value, list)


def is_callable(value: Any) -> bool:
    return callable(value)


def check_type(value: Any, descriptor: str) -> bool:
    descriptor = descriptor.strip()
    if not descriptor:
        return False
    if '|' in descriptor:
        return any(check_type(value, part.strip()) for part in descriptor.split('|'))
    if '&' in descriptor:
        return all(check_type(value, part.strip()) for part in descriptor.split('&'))
    if descriptor.endswith('[]'):
        if not isinstance(value, list):
            return False
        inner = descriptor[:-2].strip()
        return all(check_type(item, inner) for item in value)
    if descriptor.startswith('fn('):
        return callable(value)
    alias = _PRIMITIVE_TYPE_ALIASES.get(descriptor)
    if alias is not None:
        return isinstance(value, alias)
    resolved = _resolve_runtime_type(descriptor)
    if resolved is None:
        return False
    return isinstance(value, resolved)


def array_map(iterable: Iterable[Any], mapper: Callable[[Any], Any]) -> List[Any]:
    return [mapper(item) for item in iterable]


def array_filter(iterable: Iterable[Any], predicate: Callable[[Any], bool]) -> List[Any]:
    return [item for item in iterable if predicate(item)]


def array_reduce(
    iterable: Iterable[Any],
    initial: Any,
    reducer: Callable[[Any, Any], Any],
) -> Any:
    accumulator = initial
    for item in iterable:
        accumulator = reducer(accumulator, item)
    return accumulator


def char_code(character: str) -> int:
    return ord(character)


def to_debug_string(value: Any) -> str:
    if value is None:
        return "null"
    return str(value)


def substring(text: str, start: int, end: int) -> str:
    return text[start:end]


def find_char(text: str, character: str, start: int = 0) -> int:
    if len(character) != 1:
        if character == "\\n":
            character = "\n"
        elif character == "\\r":
            character = "\r"
    try:
        return text.index(character, start)
    except ValueError:
        return -1


@dataclasses.dataclass
class HttpResponse:
    status: int
    body: str
    headers: Dict[str, Any] | None = None


class _HttpModule:
    async def get(self, url: str, headers: Optional[Dict[str, str]] = None) -> HttpResponse:
        await asyncio.sleep(0)
        body = f"Mock response for {url}"
        status = 200
        if "jsonplaceholder" in url:
            body = "{ 'title': 'Mock Post', 'body': 'Lorem ipsum' }"
        return HttpResponse(status=status, body=body, headers=headers or {})


http = _HttpModule()


def logExecution(func: Callable[..., Any]) -> Callable[..., Any]:
    if asyncio.iscoroutinefunction(func):

        async def _async_wrapper(*args: Any, **kwargs: Any) -> Any:
            console.info(f"[decorator] calling {func.__name__}")
            result = await func(*args, **kwargs)
            console.info(f"[decorator] {func.__name__} finished")
            return result

        return _async_wrapper

    def _sync_wrapper(*args: Any, **kwargs: Any) -> Any:
        console.info(f"[decorator] calling {func.__name__}")
        result = func(*args, **kwargs)
        console.info(f"[decorator] {func.__name__} finished")
        return result

    return _sync_wrapper


@dataclasses.dataclass
class _Request:
    path: str
    method: str = "GET"
    body: Any = None


class _Response:
    def __init__(self) -> None:
        self.status = 200
        self.body: Any = None

    def send(self, body: Any, status: int = 200) -> None:
        self.status = status
        self.body = body
        console.info(f"[serve] responded with {status}: {body}")


def serve(handler: Callable[[Any, Any], Any], config: Optional[Dict[str, Any]] = None) -> None:
    config = config or {}
    console.info(f"[serve] mock server listening on port {config.get('port', 0)}")
    samples = [
        _Request(path="/", method="GET"),
        _Request(path="/compute", method="POST", body={"payload": 1}),
    ]
    for req in samples:
        res = _Response()
        handler(req, res)
    console.info("[serve] mock server processed sample requests")


class _WebSocketClient:
    def __init__(self, name: str) -> None:
        self.name = name
        self._handler: Optional[Callable[[str], Any]] = None

    def onMessage(self, handler: Callable[[str], Any]) -> None:
        self._handler = handler
        handler(f"hello from {self.name}")

    def send(self, message: str) -> None:
        console.info(f"[websocket] send to {self.name}: {message}")


class _WebSocketServer:
    def __init__(self, port: int) -> None:
        self.port = port
        self._clients = [_WebSocketClient("client-1"), _WebSocketClient("client-2")]

    def clients(self) -> List[_WebSocketClient]:
        return list(self._clients)


class _WebSocketModule:
    def serve(self, config: Optional[Dict[str, Any]] = None) -> _WebSocketServer:
        port = (config or {}).get("port", 0)
        console.info(f"[websocket] mock server listening on port {port}")
        return _WebSocketServer(port)


websocket = _WebSocketModule()


__all__ = [
    "Array",  # backwards compat placeholder
    "EnumInstance",
    "EnumType",
    "enum_type",
    "enum_define_variant",
    "enum_field",
    "enum_instantiate",
    "enum_get_field",
    "array_filter",
    "array_map",
    "array_reduce",
    "channel",
    "console",
    "fs",
    "make_object",
    "char_code",
    "to_debug_string",
    "substring",
    "find_char",
    "format_string",
    "match_exhaustive_failed",
    "raise_value_error",
    "http",
    "logExecution",
    "parallel",
    "sleep",
    "serve",
    "check_type",
    "spawn",
    "struct_repr",
    "struct_field",
    "websocket",
    "resolve_runtime_type",
    "instance_of",
    "is_string",
    "is_number",
    "is_boolean",
    "is_void",
    "is_array",
    "is_callable",
]


class Array(list):
    pass
