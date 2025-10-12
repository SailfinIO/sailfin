from __future__ import annotations

import importlib
import pathlib
from typing import Any, Dict

import pytest

REPO_ROOT = pathlib.Path(__file__).resolve().parents[2]


@pytest.mark.usefixtures("stage1_environment")
def test_string_utils_helpers() -> None:
    stage1_main = importlib.import_module("compiler.build.main")
    source_path = REPO_ROOT / "compiler" / "src" / "string_utils.sfn"
    runtime_prelude = REPO_ROOT / "runtime" / "prelude.sfn"

    result = stage1_main.compile_project([str(source_path), str(runtime_prelude)])
    diagnostics = getattr(result, "diagnostics", [])
    assert not diagnostics, f"Stage1 surfaced diagnostics compiling string utils: {diagnostics}"

    modules = getattr(result, "modules", [])
    assert modules, "Stage1 returned no modules for string utils"

    module = next(
        (entry for entry in modules if pathlib.Path(getattr(entry, "source_path")).resolve() == source_path.resolve()),
        None,
    )
    assert module is not None, "String utils module missing from stage1 output"
    python_source = getattr(module, "python_source")

    namespace: Dict[str, Any] = {"__builtins__": __builtins__}
    exec(python_source, namespace)

    substring = namespace["substring"]
    find_char = namespace["find_char"]
    char_code = namespace["char_code"]

    assert substring("sailfin", 0, 4) == "sail"
    assert substring("sailfin", 2, 2) == ""
    assert substring("abc", -3, 10) == "abc"
    assert substring("", 1, 5) == ""

    assert find_char("hello", "l", 0) == 2
    assert find_char("hello", "l", 3) == 3
    assert find_char("hello", "x", 0) == -1
    assert find_char("a\nb", "\n", 0) == 1
    assert find_char("\tindent", "\\t", 0) == 0
    assert find_char("offset", "o", -5) == 0
    assert find_char("offset", "t", 99) == -1

    assert char_code("0") == 48
    assert char_code("9") == 57
    assert char_code("a") == 97
    assert char_code("z") == 122
    assert char_code("A") == 65
    assert char_code("Z") == 90
    assert char_code(" ") == 32
    assert char_code("\n") == 10
    assert char_code("\t") == 9
    assert char_code("\\") == 92
    assert char_code("_") == 95
    assert char_code("") == -1
