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
import functools
import pathlib
import re
import time
from typing import Any, Awaitable, Callable, Dict, Iterable, List, Mapping, Optional, Tuple


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


GRAPHEME_EXTEND_RANGES: List[tuple[int, int]] = [
    (768, 879),
    (1155, 1161),
    (1425, 1469),
    (1471, 1471),
    (1473, 1474),
    (1476, 1477),
    (1479, 1479),
    (1552, 1562),
    (1611, 1631),
    (1648, 1648),
    (1750, 1756),
    (1759, 1764),
    (1767, 1768),
    (1770, 1773),
    (1809, 1809),
    (1840, 1866),
    (1958, 1968),
    (2027, 2035),
    (2045, 2045),
    (2070, 2073),
    (2075, 2083),
    (2085, 2087),
    (2089, 2093),
    (2137, 2139),
    (2200, 2207),
    (2250, 2273),
    (2275, 2307),
    (2362, 2364),
    (2366, 2383),
    (2385, 2391),
    (2402, 2403),
    (2433, 2435),
    (2492, 2492),
    (2494, 2500),
    (2503, 2504),
    (2507, 2509),
    (2519, 2519),
    (2530, 2531),
    (2558, 2558),
    (2561, 2563),
    (2620, 2620),
    (2622, 2626),
    (2631, 2632),
    (2635, 2637),
    (2641, 2641),
    (2672, 2673),
    (2677, 2677),
    (2689, 2691),
    (2748, 2748),
    (2750, 2757),
    (2759, 2761),
    (2763, 2765),
    (2786, 2787),
    (2810, 2815),
    (2817, 2819),
    (2876, 2876),
    (2878, 2884),
    (2887, 2888),
    (2891, 2893),
    (2901, 2903),
    (2914, 2915),
    (2946, 2946),
    (3006, 3010),
    (3014, 3016),
    (3018, 3021),
    (3031, 3031),
    (3072, 3076),
    (3132, 3132),
    (3134, 3140),
    (3142, 3144),
    (3146, 3149),
    (3157, 3158),
    (3170, 3171),
    (3201, 3203),
    (3260, 3260),
    (3262, 3268),
    (3270, 3272),
    (3274, 3277),
    (3285, 3286),
    (3298, 3299),
    (3315, 3315),
    (3328, 3331),
    (3387, 3388),
    (3390, 3396),
    (3398, 3400),
    (3402, 3405),
    (3415, 3415),
    (3426, 3427),
    (3457, 3459),
    (3530, 3530),
    (3535, 3540),
    (3542, 3542),
    (3544, 3551),
    (3570, 3571),
    (3633, 3633),
    (3636, 3642),
    (3655, 3662),
    (3761, 3761),
    (3764, 3772),
    (3784, 3790),
    (3864, 3865),
    (3893, 3893),
    (3895, 3895),
    (3897, 3897),
    (3902, 3903),
    (3953, 3972),
    (3974, 3975),
    (3981, 3991),
    (3993, 4028),
    (4038, 4038),
    (4139, 4158),
    (4182, 4185),
    (4190, 4192),
    (4194, 4196),
    (4199, 4205),
    (4209, 4212),
    (4226, 4237),
    (4239, 4239),
    (4250, 4253),
    (4957, 4959),
    (5906, 5909),
    (5938, 5940),
    (5970, 5971),
    (6002, 6003),
    (6068, 6099),
    (6109, 6109),
    (6155, 6157),
    (6159, 6159),
    (6277, 6278),
    (6313, 6313),
    (6432, 6443),
    (6448, 6459),
    (6679, 6683),
    (6741, 6750),
    (6752, 6780),
    (6783, 6783),
    (6832, 6862),
    (6912, 6916),
    (6964, 6980),
    (7019, 7027),
    (7040, 7042),
    (7073, 7085),
    (7142, 7155),
    (7204, 7223),
    (7376, 7378),
    (7380, 7400),
    (7405, 7405),
    (7412, 7412),
    (7415, 7417),
    (7616, 7679),
    (8400, 8432),
    (11503, 11505),
    (11647, 11647),
    (11744, 11775),
    (12330, 12335),
    (12441, 12442),
    (42607, 42610),
    (42612, 42621),
    (42654, 42655),
    (42736, 42737),
    (43010, 43010),
    (43014, 43014),
    (43019, 43019),
    (43043, 43047),
    (43052, 43052),
    (43136, 43137),
    (43188, 43205),
    (43232, 43249),
    (43263, 43263),
    (43302, 43309),
    (43335, 43347),
    (43392, 43395),
    (43443, 43456),
    (43493, 43493),
    (43561, 43574),
    (43587, 43587),
    (43596, 43597),
    (43643, 43645),
    (43696, 43696),
    (43698, 43700),
    (43703, 43704),
    (43710, 43711),
    (43713, 43713),
    (43755, 43759),
    (43765, 43766),
    (44003, 44010),
    (44012, 44013),
    (64286, 64286),
    (65024, 65039),
    (65056, 65071),
    (66045, 66045),
    (66272, 66272),
    (66422, 66426),
    (68097, 68099),
    (68101, 68102),
    (68108, 68111),
    (68152, 68154),
    (68159, 68159),
    (68325, 68326),
    (68900, 68903),
    (69291, 69292),
    (69373, 69375),
    (69446, 69456),
    (69506, 69509),
    (69632, 69634),
    (69688, 69702),
    (69744, 69744),
    (69747, 69748),
    (69759, 69762),
    (69808, 69818),
    (69826, 69826),
    (69888, 69890),
    (69927, 69940),
    (69957, 69958),
    (70003, 70003),
    (70016, 70018),
    (70067, 70080),
    (70089, 70092),
    (70094, 70095),
    (70188, 70199),
    (70206, 70206),
    (70209, 70209),
    (70367, 70378),
    (70400, 70403),
    (70459, 70460),
    (70462, 70468),
    (70471, 70472),
    (70475, 70477),
    (70487, 70487),
    (70498, 70499),
    (70502, 70508),
    (70512, 70516),
    (70709, 70726),
    (70750, 70750),
    (70832, 70851),
    (71087, 71093),
    (71096, 71104),
    (71132, 71133),
    (71216, 71232),
    (71339, 71351),
    (71453, 71467),
    (71724, 71738),
    (71984, 71989),
    (71991, 71992),
    (71995, 71998),
    (72000, 72000),
    (72002, 72003),
    (72145, 72151),
    (72154, 72160),
    (72164, 72164),
    (72193, 72202),
    (72243, 72249),
    (72251, 72254),
    (72263, 72263),
    (72273, 72283),
    (72330, 72345),
    (72751, 72758),
    (72760, 72767),
    (72850, 72871),
    (72873, 72886),
    (73009, 73014),
    (73018, 73018),
    (73020, 73021),
    (73023, 73029),
    (73031, 73031),
    (73098, 73102),
    (73104, 73105),
    (73107, 73111),
    (73459, 73462),
    (73472, 73473),
    (73475, 73475),
    (73524, 73530),
    (73534, 73538),
    (78912, 78912),
    (78919, 78933),
    (92912, 92916),
    (92976, 92982),
    (94031, 94031),
    (94033, 94087),
    (94095, 94098),
    (94180, 94180),
    (94192, 94193),
    (113821, 113822),
    (118528, 118573),
    (118576, 118598),
    (119141, 119145),
    (119149, 119154),
    (119163, 119170),
    (119173, 119179),
    (119210, 119213),
    (119362, 119364),
    (121344, 121398),
    (121403, 121452),
    (121461, 121461),
    (121476, 121476),
    (121499, 121503),
    (121505, 121519),
    (122880, 122886),
    (122888, 122904),
    (122907, 122913),
    (122915, 122916),
    (122918, 122922),
    (123023, 123023),
    (123184, 123190),
    (123566, 123566),
    (123628, 123631),
    (124140, 124143),
    (125136, 125142),
    (125252, 125258),
    (127995, 127999),
    (917760, 917999),
]


_PRIMITIVE_TYPE_ALIASES: Dict[str, tuple[type, ...]] = {
    "string": (str,),
    "number": (int, float),
    "boolean": (bool,),
    "void": (type(None),),
}


def bounds_check(index: int, length: int) -> None:
    """Raise IndexError when an index lies outside the provided bounds."""

    if length < 0:
        length = 0
    if index < 0 or index >= length:
        raise IndexError(
            f"array index {index} out of bounds for length {length}"
        )


class _FileSystem:
    def __init__(self) -> None:
        self._writes: Dict[str, str] = {}

    def exists(self, path: str) -> bool:
        """Check if a file exists at the given path."""
        if path in self._writes:
            return True
        target = pathlib.Path(path)
        try:
            return target.exists()
        except OSError:
            return False

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

    def listDirectory(self, path: str | None = None) -> List[str]:
        """Return directory entries combining on-disk and in-memory files."""

        target = pathlib.Path(path or ".")
        entries: set[str] = set()

        try:
            for child in target.iterdir():
                entries.add(child.name)
        except OSError:
            # Mirror bootstrap behaviour by tolerating missing directories.
            pass

        try:
            target_abs = target.resolve(strict=False)
        except TypeError:  # pragma: no cover - fallback for older Python versions.
            target_abs = (pathlib.Path.cwd() / target).resolve(strict=False)
        except OSError:
            target_abs = (pathlib.Path.cwd() / target).resolve(strict=False)

        for stored_path in self._writes:
            stored = pathlib.Path(stored_path)
            if not stored.is_absolute():
                stored = (pathlib.Path.cwd() / stored).resolve(strict=False)
            try:
                parent = stored.parent
            except RuntimeError:  # pragma: no cover - defensive guard.
                continue
            if parent == target_abs:
                entries.add(stored.name)

        return sorted(entries)

    def deleteFile(self, path: str) -> bool:
        """Delete a file, returning True when removed or buffered."""

        removed = self._writes.pop(path, None) is not None
        target = pathlib.Path(path)
        try:
            target.unlink(missing_ok=True)  # type: ignore[arg-type]
            removed = True
        except AttributeError:
            try:
                target.unlink()
                removed = True
            except FileNotFoundError:
                pass
        except OSError:
            pass
        return removed

    def createDirectory(self, path: str, *, exist_ok: bool = True) -> bool:
        """Create a directory on disk; returns True on success."""

        target = pathlib.Path(path)
        try:
            target.mkdir(parents=True, exist_ok=exist_ok)
            return True
        except OSError:
            return False


fs = _FileSystem()


# ---------------------------------------------------------------------------
# Capability bridge primitives
# ---------------------------------------------------------------------------


class CapabilityGrant:
    """Tracks which effects a caller is authorised to exercise."""

    def __init__(self, effects: Iterable[str]):
        self._effects = {effect for effect in (
            effect.strip() for effect in effects) if effect}

    def allow(self, effect: str) -> bool:
        return effect in self._effects

    def require(self, effect: str) -> None:
        if effect not in self._effects:
            allowed = ", ".join(sorted(self._effects)) or "<none>"
            raise PermissionError(
                f"capability '{effect}' not granted; allowed effects: {allowed}")


def create_capability_grant(effects: Iterable[str]) -> CapabilityGrant:
    return CapabilityGrant(effects)


class FilesystemBridge:
    def __init__(self, grant: CapabilityGrant, delegate: Optional[_FileSystem] = None):
        self._grant = grant
        self._delegate = delegate or fs

    def read_text(self, path: str) -> str:
        self._grant.require("io")
        return self._delegate.readFile(path)

    def write_text(self, path: str, contents: str) -> None:
        self._grant.require("io")
        self._delegate.writeFile(path, contents)

    def delete_file(self, path: str) -> bool:
        self._grant.require("io")
        return self._delegate.deleteFile(path)

    def create_directory(self, path: str, *, exist_ok: bool = True) -> bool:
        self._grant.require("io")
        return self._delegate.createDirectory(path, exist_ok=exist_ok)


def create_filesystem_bridge(
    grant: CapabilityGrant,
    *,
    delegate: Optional[_FileSystem] = None,
) -> FilesystemBridge:
    return FilesystemBridge(grant, delegate)


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


def monotonic_millis() -> float:
    """Monotonic millisecond clock for profiling.

    Returned as float to match the stage2 ABI representation for numbers.
    """

    return float(time.perf_counter() * 1000.0)


@atexit.register
def _cancel_pending_tasks() -> None:
    if not _TASKS:
        return
    tasks_by_loop: Dict[asyncio.AbstractEventLoop,
                        List[asyncio.Task[Any]]] = {}
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
            loop.run_until_complete(asyncio.gather(
                *tasks, return_exceptions=True))
        except RuntimeError:
            # Loop already closed; nothing else to do.
            pass


# ---------------------------------------------------------------------------
# String interpolation helper
# ---------------------------------------------------------------------------

_INTERPOLATION_PATTERN = re.compile(r"{{\s*(.+?)\s*}}")


def _is_regional_indicator(codepoint: int) -> bool:
    return 0x1F1E6 <= codepoint <= 0x1F1FF


def _is_variation_selector(codepoint: int) -> bool:
    return (0xFE00 <= codepoint <= 0xFE0F) or (0xE0100 <= codepoint <= 0xE01EF)


def _is_emoji_modifier(codepoint: int) -> bool:
    return 0x1F3FB <= codepoint <= 0x1F3FF


def _is_extend(codepoint: int) -> bool:
    if _is_variation_selector(codepoint) or _is_emoji_modifier(codepoint):
        return True
    for start, end in GRAPHEME_EXTEND_RANGES:
        if codepoint < start:
            break
        if codepoint <= end:
            return True
    return False


def _iter_grapheme_clusters(text: str) -> List[str]:
    clusters: List[str] = []
    if not text:
        return clusters

    current = text[0]
    prev_code = ord(text[0])
    prev_was_joiner = prev_code == 0x200D
    prev_was_ri = _is_regional_indicator(prev_code)
    ri_run_length = 1 if prev_was_ri else 0

    for character in text[1:]:
        codepoint = ord(character)
        is_joiner = codepoint == 0x200D
        is_extend = _is_extend(codepoint)
        is_ri = _is_regional_indicator(codepoint)

        start_new = False
        if prev_code == 0x000D and codepoint == 0x000A:
            start_new = False
        elif prev_was_joiner:
            start_new = False
        elif is_joiner:
            start_new = False
        elif is_extend:
            start_new = False
        elif is_ri and prev_was_ri and (ri_run_length % 2 == 1):
            start_new = False
        else:
            start_new = True

        if start_new:
            clusters.append(current)
            current = character
            ri_run_length = 1 if is_ri else 0
        else:
            current += character
            if is_ri:
                ri_run_length += 1
            elif not is_joiner and not is_extend:
                ri_run_length = 0

        prev_code = codepoint
        prev_was_joiner = is_joiner
        if is_joiner:
            prev_was_ri = False
            ri_run_length = 0
        elif is_extend:
            # Preserve the previous RI state so RI pairs stay aligned after modifiers.
            pass
        else:
            prev_was_ri = is_ri
            if not is_ri:
                ri_run_length = 0

    clusters.append(current)
    return clusters


def grapheme_count(text: str) -> int:
    if not text:
        return 0
    # Fast path: compiler inputs are overwhelmingly ASCII.
    # Treat each codepoint as a grapheme cluster.
    if text.isascii():
        return len(text)
    return len(_grapheme_clusters_cached(text))


def grapheme_at(text: str, index: int) -> str:
    if not text or index < 0:
        return ""
    # Fast path: compiler inputs are overwhelmingly ASCII.
    if text.isascii():
        if index >= len(text):
            return ""
        return text[index]

    clusters = _grapheme_clusters_cached(text)
    if index >= len(clusters):
        return ""
    return clusters[index]


@functools.lru_cache(maxsize=128)
def _grapheme_clusters_cached(text: str) -> Tuple[str, ...]:
    return tuple(_iter_grapheme_clusters(text))


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


def format_interpolated(parts: Iterable[str], values: Iterable[Any]) -> str:
    result_parts: List[str] = []
    value_iter = iter(values)
    for part in parts:
        result_parts.append(part)
        try:
            value = next(value_iter)
        except StopIteration:
            continue
        result_parts.append(to_debug_string(value))
    # Exhaust remaining values to mirror the stage1 helper semantics.
    for leftover in value_iter:
        result_parts.append(to_debug_string(leftover))
    return "".join(result_parts)


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
        payload = ", ".join(
            f"{field.name}={field.value!r}" for field in self._fields)
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
            provided = [EnumField(field, kwargs.get(field))
                        for field in field_names]
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


# Stage1 (Python) bootstrap helpers. These mirror the stage2 runtime helpers and
# are relied on by generated Python compiler artifacts.
def substring_unchecked(text: str, start: int, end: int) -> str:
    return text[start:end]


def _as_single_char(value: object) -> str:
    if isinstance(value, int):
        return chr(value & 0xFF)
    if isinstance(value, bytes):
        return value[:1].decode("latin-1") if value else ""
    if isinstance(value, str):
        return value[:1]
    return ""


def is_decimal_digit(ch: object) -> bool:
    c = _as_single_char(ch)
    return bool(c) and ("0" <= c <= "9")


def is_whitespace_char(ch: object) -> bool:
    c = _as_single_char(ch)
    return c in (" ", "\t", "\n", "\r")


def is_alpha_char(ch: object) -> bool:
    c = _as_single_char(ch)
    return bool(c) and (("a" <= c <= "z") or ("A" <= c <= "Z"))


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


class HttpBridge:
    def __init__(self, grant: CapabilityGrant, delegate: Optional[_HttpModule] = None):
        self._grant = grant
        self._delegate = delegate or http

    async def get(self, url: str, headers: Optional[Dict[str, str]] = None) -> HttpResponse:
        self._grant.require("net")
        return await self._delegate.get(url, headers=headers)


def create_http_bridge(
    grant: CapabilityGrant,
    *,
    delegate: Optional[_HttpModule] = None,
) -> HttpBridge:
    return HttpBridge(grant, delegate)


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
    console.info(
        f"[serve] mock server listening on port {config.get('port', 0)}")
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
        self._clients = [_WebSocketClient(
            "client-1"), _WebSocketClient("client-2")]

    def clients(self) -> List[_WebSocketClient]:
        return list(self._clients)


class _WebSocketModule:
    def serve(self, config: Optional[Dict[str, Any]] = None) -> _WebSocketServer:
        port = (config or {}).get("port", 0)
        console.info(f"[websocket] mock server listening on port {port}")
        return _WebSocketServer(port)


websocket = _WebSocketModule()


class ModelBridge:
    def __init__(self, grant: CapabilityGrant, handlers: Optional[Mapping[str, Callable[..., Any]]] = None):
        self._grant = grant
        self._handlers: Dict[str, Callable[..., Any]] = dict(handlers or {})

    def register_stub(self, name: str, handler: Callable[..., Any]) -> None:
        self._handlers[name] = handler

    async def invoke(self, prompt: str, /, **options: Any) -> Dict[str, Any]:
        self._grant.require("model")
        model_name = options.get("model", "mock")
        handler = self._handlers.get(model_name)
        if handler is None:
            await asyncio.sleep(0)
            return {
                "model": model_name,
                "prompt": prompt,
                "output": f"[mock:model] {prompt}",
                "options": options,
            }
        result = handler(prompt, options)
        if asyncio.iscoroutine(result):
            result = await result
        return result


def create_model_bridge(
    grant: CapabilityGrant,
    *,
    handlers: Optional[Mapping[str, Callable[..., Any]]] = None,
) -> ModelBridge:
    return ModelBridge(grant, handlers)


__all__ = [
    "Array",  # backwards compat placeholder
    "CapabilityGrant",
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
    "create_capability_grant",
    "create_filesystem_bridge",
    "create_http_bridge",
    "create_model_bridge",
    "fs",
    "FilesystemBridge",
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
    "ModelBridge",
    "parallel",
    "sleep",
    "monotonic_millis",
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
    "format_interpolated",
    "grapheme_at",
    "grapheme_count",
]


class Array(list):
    pass
