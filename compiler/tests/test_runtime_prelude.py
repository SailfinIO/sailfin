from __future__ import annotations

import asyncio
import functools
import importlib
import pathlib
from typing import Any, Callable, List

import pytest

REPO_ROOT = pathlib.Path(__file__).resolve().parents[2]


@functools.lru_cache()
def _runtime_prelude_python_source() -> str:
    stage1_main = importlib.import_module("compiler.build.main")
    runtime_prelude = REPO_ROOT / "runtime" / "prelude.sfn"

    result = stage1_main.compile_project([str(runtime_prelude)])
    diagnostics = getattr(result, "diagnostics", [])
    assert not diagnostics, f"Stage1 surfaced diagnostics compiling runtime prelude: {diagnostics}"

    modules = getattr(result, "modules", [])
    assert modules, "Stage1 returned no modules for runtime prelude"

    module = modules[0]
    python_source = getattr(module, "python_source")
    return python_source


def load_runtime_prelude_namespace() -> dict[str, Any]:
    namespace: dict[str, Any] = {"__builtins__": __builtins__}
    exec(_runtime_prelude_python_source(), namespace)
    return namespace


@pytest.mark.usefixtures("stage1_environment")
def test_runtime_prelude_collection_helpers() -> None:
    namespace = load_runtime_prelude_namespace()

    runtime_module = namespace["runtime"]
    assert namespace["console"] is runtime_module.console
    assert namespace["fs"] is runtime_module.fs
    assert namespace["http"] is runtime_module.http

    array_map = namespace["array_map"]
    array_filter = namespace["array_filter"]
    array_reduce = namespace["array_reduce"]
    parallel = namespace["parallel"]
    substring = namespace["substring"]
    find_char = namespace["find_char"]
    grapheme_count = namespace["grapheme_count"]
    grapheme_at = namespace["grapheme_at"]
    char_code = namespace["char_code"]
    match_exhaustive_failed = namespace["match_exhaustive_failed"]
    enum_type = namespace["enum_type"]
    enum_define_variant = namespace["enum_define_variant"]
    enum_field = namespace["enum_field"]
    enum_instantiate = namespace["enum_instantiate"]
    enum_get_field = namespace["enum_get_field"]
    struct_field = namespace["struct_field"]
    struct_repr = namespace["struct_repr"]
    check_type = namespace["check_type"]
    format_interpolated = namespace["format_interpolated"]

    doubled = array_map([1, 2, 3], lambda value: value * 2)
    assert doubled == [2, 4, 6]

    evens = array_filter([0, 1, 2, 3, 4], lambda value: (value % 2) == 0)
    assert evens == [0, 2, 4]

    total = array_reduce([1, 2, 3, 4], 0, lambda acc, value: acc + value)
    assert total == 10

    tasks: List[Callable[[], int]] = [lambda: 7, lambda: 11, lambda: 13]
    results = parallel(tasks)
    assert results == [7, 11, 13]

    assert substring("sailfin", 0, 4) == "sail"
    assert substring("sailfin", 2, 2) == ""
    assert substring("abc", -2, 5) == "abc"
    assert substring("", 0, 3) == ""
    assert substring("bounds", 3, 100) == "nds"
    assert substring("bounds", 10, 12) == ""
    assert substring("bounds", -5, -2) == ""
    assert substring("emoji🙂", 5, 6) == "🙂"

    assert find_char("hello", "l", 0) == 2
    assert find_char("hello", "l", 3) == 3
    assert find_char("hello", "x", 0) == -1
    assert find_char("a\nb", "\n", 0) == 1
    assert find_char("a\nb", "\\n", 0) == 1
    assert find_char("world", "w", -4) == 0
    assert find_char("world", "d", 10) == -1
    assert find_char("line1\nline2", "\\n", -8) == 5
    assert find_char("emoji🙂", "🙂", 0) == 5
    assert find_char("emoji🙂", "🙂", 6) == -1

    assert grapheme_count("sailfin") == 7
    assert grapheme_count("e\u0301") == 1
    assert grapheme_count("👨\u200d👩\u200d👧\u200d👦") == 1
    assert grapheme_count("🇺🇸🇬🇧") == 2
    assert grapheme_count("thumbs👍🏿") == 7
    assert grapheme_at("sailfin", 3) == "l"
    assert grapheme_at("e\u0301", 0) == "e\u0301"
    assert grapheme_at("🇺🇸🇬🇧", 1) == "🇬🇧"
    assert grapheme_at("thumbs👍🏿", 6) == "👍🏿"
    assert grapheme_at("thumbs👍🏿", 99) == ""
    assert grapheme_at("", 0) == ""

    assert char_code("0") == 48
    assert char_code("9") == 57
    assert char_code("a") == 97
    assert char_code("z") == 122
    assert char_code("A") == 65
    assert char_code("Z") == 90
    assert char_code(" ") == 32
    assert char_code("\"") == 34
    assert char_code("\\") == 92
    assert char_code("_") == 95
    assert char_code("\n") == 10
    assert char_code("ñ") == 241
    assert char_code("Ω") == 937
    assert char_code("€") == 8364
    assert char_code("中") == 20013
    assert char_code("🙂") == 128578
    assert char_code("") == -1

    with pytest.raises(ValueError, match="Non-exhaustive match"):
        match_exhaustive_failed(42)

    color = enum_type("Color")
    color = enum_define_variant(color, "Red", [])
    color = enum_define_variant(color, "Rgb", ["r", "g", "b"])

    red = enum_instantiate(color, "Red", [])
    assert red.type.name == "Color"
    assert red.variant == "Red"
    assert enum_get_field(red, "r") is None

    rgb = enum_instantiate(
        color,
        "Rgb",
        [
            enum_field("r", 255),
            enum_field("g", 128),
            enum_field("b", 64),
        ],
    )
    assert rgb.r == 255
    assert rgb.g == 128
    assert rgb.b == 64
    assert enum_get_field(rgb, "missing") is None

    point = struct_repr(
        "Point",
        [
            struct_field("x", 3),
            struct_field("y", -4),
            struct_field("label", "p"),
        ],
    )
    assert point == "Point(x=3, y=-4, label=p)"

    assert check_type("hello", "string") is True
    assert check_type(123, "number") is True
    assert check_type(True, "boolean") is True
    assert check_type(None, "void") is True
    assert check_type("hello", "number") is False
    assert check_type([1, 2, 3], "number[]") is True
    assert check_type([1, "two"], "number[]") is False
    assert check_type("hi", "string | number") is True
    assert check_type(42, "string | number") is True
    assert check_type(True, "string | number") is True
    assert check_type(True, "boolean & number") is True
    assert check_type(42, "string & number") is False
    assert check_type(None, "string?") is True
    assert check_type("value", "string?") is True

    assert format_interpolated(["Hello, ", "!"], ["World"]) == "Hello, World!"
    assert format_interpolated(["Prefix"], []) == "Prefix"
    assert format_interpolated(["a", "b", "c"], [1, 2]) == "a1b2c"


@pytest.mark.usefixtures("stage1_environment")
def test_runtime_capability_bridges(tmp_path: pathlib.Path) -> None:
    namespace = load_runtime_prelude_namespace()

    capability_grant = namespace["capability_grant"]
    fs_bridge = namespace["fs_bridge"]
    http_bridge = namespace["http_bridge"]
    model_bridge = namespace["model_bridge"]

    io_grant = capability_grant(["io"])
    fs = fs_bridge(io_grant)

    sample_file = tmp_path / "sample.txt"
    fs.write_text(str(sample_file), "hello")
    assert fs.read_text(str(sample_file)) == "hello"

    restricted = capability_grant([])
    fs_restricted = fs_bridge(restricted)
    with pytest.raises(PermissionError):
        fs_restricted.read_text(str(sample_file))

    net_grant = capability_grant(["net"])
    http = http_bridge(net_grant)

    async def _fetch() -> Any:
        return await http.get("https://example.com", headers={"x-mock": "1"})

    response = asyncio.run(_fetch())
    assert response.status == 200
    assert "example.com" in response.body

    http_restricted = http_bridge(restricted)

    async def _restricted_fetch() -> Any:
        return await http_restricted.get("https://example.com")

    with pytest.raises(PermissionError):
        asyncio.run(_restricted_fetch())

    model_grant = capability_grant(["model"])
    model = model_bridge(model_grant)

    async def _invoke_default() -> Any:
        return await model.invoke("hi there")

    default_result = asyncio.run(_invoke_default())
    assert default_result["prompt"] == "hi there"
    assert default_result["model"] == "mock"

    model.register_stub(
        "custom",
        lambda prompt, options: {"model": "custom", "prompt": prompt, "output": "stub"},
    )

    async def _invoke_stub() -> Any:
        return await model.invoke("use stub", model="custom")

    stub_result = asyncio.run(_invoke_stub())
    assert stub_result["output"] == "stub"

    model_restricted = model_bridge(restricted)

    async def _invoke_restricted() -> Any:
        return await model_restricted.invoke("not allowed")

    with pytest.raises(PermissionError):
        asyncio.run(_invoke_restricted())
