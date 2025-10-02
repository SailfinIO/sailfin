"""Runtime helpers for the Sailfin bootstrap Python backend.

This module provides a small collection of helpers that the bootstrap
code generator targets when translating Sailfin programs into Python.
It is intentionally minimal and focuses on mirroring core language
constructs closely enough for experimentation.
"""

from __future__ import annotations

import asyncio
import dataclasses
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


def channel(capacity: Optional[int] = None) -> Channel:
    return Channel(capacity)


def spawn(coro_factory: Callable[[], Awaitable[Any]], name: Optional[str] = None) -> None:
    loop = _ensure_loop()
    task = loop.create_task(coro_factory())
    if name and hasattr(task, "set_name"):
        task.set_name(name)


def parallel(tasks: Iterable[Callable[[], Any]]) -> List[Any]:
    return [task() for task in tasks]


def sleep(milliseconds: int) -> None:
    time.sleep(milliseconds / 1000)


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


__all__ = [
    "Array",  # backwards compat placeholder
    "EnumInstance",
    "EnumType",
    "channel",
    "console",
    "format_string",
    "match_exhaustive_failed",
    "parallel",
    "sleep",
    "spawn",
    "struct_repr",
]


class Array(list):
    pass
