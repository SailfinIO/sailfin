from __future__ import annotations

import importlib

import pytest


@pytest.mark.usefixtures("stage1_environment")
def test_interpolated_string_lowering() -> None:
    stage1_main = importlib.import_module("compiler.build.main")

    source = (
        "fn format(name -> string, count -> number) -> string {\n"
        "    let total = count + 1;\n"
        "    return \"Hello {{ name }} ({{ total }})!\";\n"
        "}\n"
        "\n"
        "fn identity(value -> string) -> string {\n"
        "    return \"{{ value }}\";\n"
        "}\n"
    )

    result = stage1_main.compile_to_native_python(source)
    assert not result.diagnostics, f"Lowering surfaced diagnostics: {result.diagnostics}"

    namespace: dict[str, object] = {"__builtins__": __builtins__}
    exec(result.source, namespace)

    formatter = namespace["format"]
    identity = namespace["identity"]

    assert formatter("Sailfin", 2) == "Hello Sailfin (3)!"
    assert identity("value") == "value"