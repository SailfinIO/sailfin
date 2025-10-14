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
    unexpected: list[str] = []
    for entry in diagnostics:
        fatal = getattr(entry, "fatal", False)
        if fatal:
            unexpected.append(f"fatal: {entry}")
            continue
        for message in getattr(entry, "messages", []):
            if "defaulting to pointer layout" not in message:
                unexpected.append(message)
    assert not unexpected, f"Stage1 surfaced diagnostics compiling string utils: {unexpected}"

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
    grapheme_count = namespace["grapheme_count"]
    grapheme_at = namespace["grapheme_at"]
    char_code = namespace["char_code"]

    assert substring("sailfin", 0, 4) == "sail"
    assert substring("sailfin", 2, 2) == ""
    assert substring("abc", -3, 10) == "abc"
    assert substring("", 1, 5) == ""
    assert substring("bounds", 3, 100) == "nds"
    assert substring("bounds", 10, 12) == ""
    assert substring("bounds", -5, -2) == ""
    assert substring("emoji🙂", 5, 6) == "🙂"

    assert find_char("hello", "l", 0) == 2
    assert find_char("hello", "l", 3) == 3
    assert find_char("hello", "x", 0) == -1
    assert find_char("a\nb", "\n", 0) == 1
    assert find_char("\tindent", "\\t", 0) == 0
    assert find_char("offset", "o", -5) == 0
    assert find_char("offset", "t", 99) == -1
    assert find_char("line1\nline2", "\\n", -8) == 5
    assert find_char("emoji🙂", "🙂", 0) == 5
    assert find_char("emoji🙂", "🙂", 6) == -1

    assert grapheme_count("stage") == 5
    assert grapheme_count("naïve") == 5
    assert grapheme_count("🏳️‍⚧️") == 1
    assert grapheme_count("a\u0308") == 1
    assert grapheme_count("🇺🇳") == 1
    assert grapheme_at("naïve", 2) == "ï"
    assert grapheme_at("🏳️‍⚧️", 0) == "🏳️‍⚧️"
    assert grapheme_at("🇺🇳", 0) == "🇺🇳"
    assert grapheme_at("a\u0308", 0) == "a\u0308"
    assert grapheme_at("stage", 9) == ""

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
    assert char_code("ñ") == 241
    assert char_code("Ω") == 937
    assert char_code("€") == 8364
    assert char_code("中") == 20013
    assert char_code("🙂") == 128578
    assert char_code("") == -1
