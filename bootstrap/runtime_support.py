"""Runtime helpers for the Sailfin bootstrap Python backend.

This module provides a small collection of helpers that the bootstrap
code generator targets when translating Sailfin programs into Python.
It is intentionally minimal and focuses on mirroring core language
constructs closely enough for experimentation.
"""

from __future__ import annotations

import asyncio
import atexit
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


console = _Console()


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


# ---------------------------------------------------------------------------
# Enum helpers
# ---------------------------------------------------------------------------


class EnumInstance:
    __slots__ = ("_type", "_variant", "_fields")

    def __init__(self, enum_type: "EnumType", variant: str, fields: Dict[str, Any]):
        self._type = enum_type
        self._variant = variant
        self._fields = fields

    @property
    def type(self) -> "EnumType":
        return self._type

    @property
    def variant(self) -> str:
        return self._variant

    def __getattr__(self, item: str) -> Any:
        try:
            return self._fields[item]
        except KeyError as err:  # pragma: no cover - defensive
            raise AttributeError(item) from err

    def __repr__(self) -> str:
        payload = ", ".join(f"{k}={v!r}" for k, v in self._fields.items())
        return f"{self._type.name}.{self._variant}({payload})"


class EnumType:
    def __init__(self, name: str):
        self.name = name
        self.variants: Dict[str, Callable[..., EnumInstance]] = {}

    def variant(self, name: str, field_names: List[str]) -> Callable[..., EnumInstance]:
        def constructor(**kwargs: Any) -> EnumInstance:
            fields = {}
            for field in field_names:
                fields[field] = kwargs.get(field)
            return EnumInstance(self, name, fields)

        constructor.__name__ = name
        self.variants[name] = constructor
        return constructor


# ---------------------------------------------------------------------------
# Struct helper
# ---------------------------------------------------------------------------


def struct_repr(name: str, fields: Dict[str, Any]) -> str:
    payload = ", ".join(f"{key}={value!r}" for key, value in fields.items())
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
    "array_filter",
    "array_map",
    "array_reduce",
    "channel",
    "console",
    "fs",
    "make_object",
    "format_string",
    "match_exhaustive_failed",
    "http",
    "logExecution",
    "parallel",
    "sleep",
    "serve",
    "check_type",
    "spawn",
    "struct_repr",
    "websocket",
]


class Array(list):
    pass
