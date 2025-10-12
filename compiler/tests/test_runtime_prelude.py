from __future__ import annotations

import importlib
import pathlib
from typing import Any, Callable, List

import pytest

REPO_ROOT = pathlib.Path(__file__).resolve().parents[2]


@pytest.mark.usefixtures("stage1_environment")
def test_runtime_prelude_collection_helpers() -> None:
    stage1_main = importlib.import_module("compiler.build.main")
    runtime_prelude = REPO_ROOT / "runtime" / "prelude.sfn"

    result = stage1_main.compile_project([str(runtime_prelude)])
    diagnostics = getattr(result, "diagnostics", [])
    assert not diagnostics, f"Stage1 surfaced diagnostics compiling runtime prelude: {diagnostics}"

    modules = getattr(result, "modules", [])
    assert modules, "Stage1 returned no modules for runtime prelude"

    # The prelude compiles into a single Python module; execute it in isolation.
    module = modules[0]
    python_source = getattr(module, "python_source")
    namespace: dict[str, Any] = {"__builtins__": __builtins__}
    exec(python_source, namespace)

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
    char_code = namespace["char_code"]

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

    assert find_char("hello", "l", 0) == 2
    assert find_char("hello", "l", 3) == 3
    assert find_char("hello", "x", 0) == -1
    assert find_char("a\nb", "\n", 0) == 1
    assert find_char("a\nb", "\\n", 0) == 1
    assert find_char("world", "w", -4) == 0
    assert find_char("world", "d", 10) == -1

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
