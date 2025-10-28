import ctypes
import importlib
import pathlib

import llvmlite.binding as llvm
import pytest

from runtime.stage2_runner import Stage2Runner
from scripts import bootstrap_stage2

pytestmark = [pytest.mark.stage2,
              pytest.mark.usefixtures("stage1_environment")]

_LLVM_INITIALISED = False


class _PointerArray(ctypes.Structure):
    _fields_ = [
        ("data", ctypes.POINTER(ctypes.c_void_p)),
        ("length", ctypes.c_longlong),
    ]


class _TraitMetadata(ctypes.Structure):
    _fields_ = [
        ("interfaces", ctypes.c_void_p),
        ("implementations", ctypes.c_void_p),
    ]


class _CapabilityManifest(ctypes.Structure):
    _fields_ = [
        ("entries", ctypes.c_void_p),
    ]


class _LoweredLLVMResult(ctypes.Structure):
    _fields_ = [
        ("ir", ctypes.c_void_p),
        ("diagnostics", ctypes.c_void_p),
        ("trait_metadata", _TraitMetadata),
        ("function_effects", ctypes.c_void_p),
        ("lifetime_regions", ctypes.c_void_p),
        ("capability_manifest", _CapabilityManifest),
        ("string_constants", ctypes.c_void_p),
    ]


class _NativeArtifact(ctypes.Structure):
    _fields_ = [
        ("name", ctypes.c_void_p),
        ("format", ctypes.c_void_p),
        ("contents", ctypes.c_void_p),
    ]


class _NativeModule(ctypes.Structure):
    _fields_ = [
        ("artifacts", ctypes.c_void_p),
        ("entry_points", ctypes.c_void_p),
        ("symbol_count", ctypes.c_double),
    ]


class _EmitNativeResult(ctypes.Structure):
    _fields_ = [
        ("module", _NativeModule),
        ("diagnostics", ctypes.c_void_p),
    ]


def _ensure_llvm_initialised() -> None:
    global _LLVM_INITIALISED
    if _LLVM_INITIALISED:
        return
    llvm.initialize_native_target()
    llvm.initialize_native_asmprinter()
    _LLVM_INITIALISED = True


def _read_example(name: str) -> str:
    repo_root = pathlib.Path(__file__).resolve().parents[2]
    return (repo_root / "examples" / name).read_text(encoding="utf-8")


def _decode_string(ptr: ctypes.c_void_p | int) -> str:
    address = int(ptr)
    if address == 0:
        return ""
    value = ctypes.cast(ctypes.c_void_p(address), ctypes.c_char_p).value
    return value.decode("utf-8") if value is not None else ""


def _read_pointer_array(ptr: ctypes.c_void_p) -> list[int]:
    if not ptr:
        return []
    array = ctypes.cast(ptr, ctypes.POINTER(_PointerArray)).contents
    if not array.data:
        return []
    length = int(array.length)
    if length <= 0:
        return []
    return [int(array.data[i]) for i in range(length)]


def _read_string_array(ptr: ctypes.c_void_p) -> list[str]:
    strings: list[str] = []
    for raw in _read_pointer_array(ptr):
        strings.append(_decode_string(raw))
    return strings


def _read_artifacts(ptr: ctypes.c_void_p) -> list[dict[str, str]]:
    artifacts: list[dict[str, str]] = []
    for raw in _read_pointer_array(ptr):
        if not raw:
            continue
        artifact = ctypes.cast(raw, ctypes.POINTER(_NativeArtifact)).contents
        artifacts.append(
            {
                "name": _decode_string(artifact.name),
                "format": _decode_string(artifact.format),
                "contents": _decode_string(artifact.contents),
            }
        )
    return artifacts


def _run_ir_function(ir_text: str, symbol: str) -> float:
    _ensure_llvm_initialised()
    module = llvm.parse_assembly(ir_text)
    target = llvm.Target.from_default_triple()
    module.triple = target.triple
    module.verify()
    target_machine = target.create_target_machine()
    backing = llvm.parse_assembly("")
    engine = llvm.create_mcjit_compiler(backing, target_machine)
    engine.add_module(module)
    engine.finalize_object()
    engine.run_static_constructors()
    address = engine.get_function_address(symbol)
    assert address != 0, f"{symbol} missing from compiled module"
    function = ctypes.CFUNCTYPE(ctypes.c_double)(address)
    value = function()
    engine.remove_module(module)
    return value


@pytest.fixture(scope="module")
def stage2_bootstrap(tmp_path_factory):
    output_dir = tmp_path_factory.mktemp("stage2")
    compilation_result = bootstrap_stage2.compile_compiler_to_stage2(
        output_dir, quiet=True, capture_results=True
    )
    if len(compilation_result) == 3:
        compiled, aggregator, lowered_map = compilation_result
    else:
        compiled, aggregator = compilation_result
        lowered_map = {}

    assert compiled, "expected stage2 artifacts to be generated"
    assert getattr(aggregator, "fatal_count", 0) == 0
    assert lowered_map, "expected lowered results for compiler modules"

    runner = Stage2Runner(list(lowered_map.values()))
    return {
        "runner": runner,
        "modules": compiled,
        "output_dir": output_dir,
    }


def test_stage2_compile_to_sailfin_roundtrip(stage2_bootstrap) -> None:
    runner: Stage2Runner = stage2_bootstrap["runner"]
    source_text = _read_example("basics/hello-world.sfn")
    buffer = runner.encode_host_string(source_text)
    result_ptr = runner.invoke(
        "compile_to_sailfin",
        buffer,
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


def test_stage2_emits_native_artifacts(stage2_bootstrap) -> None:
    runner: Stage2Runner = stage2_bootstrap["runner"]
    source = "fn greet() -> string { return \"hi\"; }\n"
    buffer = runner.encode_host_string(source)
    result = runner.invoke(
        "compile_to_native",
        buffer,
        restype=_EmitNativeResult,
        argtypes=(ctypes.c_void_p,),
    )

    artifacts = _read_artifacts(result.module.artifacts)
    formats = {artifact["format"] for artifact in artifacts}

    assert "sailfin-native-text" in formats
    assert "sailfin-layout-manifest" in formats

    native_text = next(artifact for artifact in artifacts if artifact["format"] == "sailfin-native-text")
    assert native_text["contents"], "expected non-empty native text contents"


def test_stage2_generates_valid_llvm(stage2_bootstrap) -> None:
    runner: Stage2Runner = stage2_bootstrap["runner"]
    source = "fn number_source() -> number { return 123.0; }\n"
    buffer = runner.encode_host_string(source)
    result = runner.invoke(
        "compile_to_native_llvm",
        buffer,
        restype=_LoweredLLVMResult,
        argtypes=(ctypes.c_void_p,),
    )

    ir_text = _decode_string(result.ir)
    assert "define double @number_source" in ir_text

    _ensure_llvm_initialised()
    module = llvm.parse_assembly(ir_text)
    module.verify()


def test_stage2_executes_compiled_program(stage2_bootstrap) -> None:
    runner: Stage2Runner = stage2_bootstrap["runner"]
    source = "fn compute() -> number { return 21.0 + 21.0; }\n"
    buffer = runner.encode_host_string(source)
    stage2_result = runner.invoke(
        "compile_to_native_llvm",
        buffer,
        restype=_LoweredLLVMResult,
        argtypes=(ctypes.c_void_p,),
    )
    stage2_ir = _decode_string(stage2_result.ir)

    stage1_main = importlib.import_module("compiler.build.main")
    stage1_result = stage1_main.compile_to_native_llvm(source)
    stage1_ir = getattr(stage1_result, "ir", "")

    stage2_value = _run_ir_function(stage2_ir, "compute")
    stage1_value = _run_ir_function(stage1_ir, "compute")

    assert stage2_value == pytest.approx(stage1_value)
    assert stage2_value == pytest.approx(42.0)
