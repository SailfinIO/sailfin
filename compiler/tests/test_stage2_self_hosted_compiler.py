import ctypes
import importlib
import pathlib

import pytest

from runtime.stage2_runner import Stage2Runner
from scripts import bootstrap_stage2

pytestmark = [pytest.mark.stage2,
              pytest.mark.usefixtures("stage1_environment")]


def _read_example(name: str) -> str:
    repo_root = pathlib.Path(__file__).resolve().parents[2]
    return (repo_root / "examples" / name).read_text(encoding="utf-8")


def test_stage2_compile_to_sailfin_roundtrip(tmp_path: pathlib.Path) -> None:
    output_dir = tmp_path / "stage2"
    compilation_result = bootstrap_stage2.compile_compiler_to_stage2(
        output_dir, quiet=True, capture_results=True)
    if len(compilation_result) == 3:
        compiled, aggregator, lowered_map = compilation_result
    else:
        compiled, aggregator = compilation_result
        lowered_map = {}

    assert compiled, "expected stage2 artifacts to be generated"
    assert aggregator.fatal_count == 0
    assert lowered_map, "expected lowered results for compiler modules"

    runner = Stage2Runner(list(lowered_map.values()))

    source_text = _read_example("basics/hello-world.sfn")
    buffer = ctypes.create_string_buffer(source_text.encode("utf-8"))
    result_ptr = runner.invoke(
        "compile_to_sailfin",
        ctypes.cast(buffer, ctypes.c_void_p),
        restype=ctypes.c_void_p,
        argtypes=(ctypes.c_void_p,),
    )
    assert result_ptr

    value = ctypes.cast(result_ptr, ctypes.c_char_p).value
    assert value is not None
    result_text = value.decode("utf-8")

    stage1_main = importlib.import_module("compiler.build.main")
    expected = stage1_main.compile_to_sailfin(source_text)

    assert result_text == expected
