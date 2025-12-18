"""Prepare Stage2 LLVM IR for AOT compilation.

This tool reuses the Stage2 IR rewrite/deduplication logic (the same one used by
Stage2Runner's JIT path) and writes a set of rewritten *.ll modules to disk.

It is intended as a transition tool while moving Stage2 execution away from
llvmlite/Python and toward a fully native runtime + AOT compilation pipeline.

Usage:
  python tools/prepare_stage2_aot.py --input build/stage2 --output build/stage2/aot
"""

from __future__ import annotations

import argparse
import pathlib
import sys
from dataclasses import dataclass

REPO_ROOT = pathlib.Path(__file__).resolve().parents[1]
if str(REPO_ROOT) not in sys.path:
    sys.path.insert(0, str(REPO_ROOT))

from runtime.stage2_runner import Stage2Runner  # noqa: E402


@dataclass
class LoweredModule:
    ir: str
    module_name: str
    source_path: pathlib.Path

    @property
    def module(self) -> str:
        return self.module_name


def _load_modules(input_dir: pathlib.Path) -> list[LoweredModule]:
    artifacts = sorted(input_dir.glob("*.ll"))
    if not artifacts:
        raise FileNotFoundError(f"no .ll files found in {input_dir}")
    lowered: list[LoweredModule] = []
    for artifact in artifacts:
        lowered.append(
            LoweredModule(
                ir=artifact.read_text(encoding="utf-8"),
                module_name=artifact.stem,
                source_path=artifact,
            )
        )
    return lowered


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(
        description="Rewrite stage2 LLVM IR modules for AOT compilation"
    )
    parser.add_argument(
        "--input",
        type=pathlib.Path,
        default=REPO_ROOT / "build" / "stage2",
        help="Directory containing stage2 *.ll modules (default: build/stage2)",
    )
    parser.add_argument(
        "--output",
        type=pathlib.Path,
        default=REPO_ROOT / "build" / "stage2" / "aot",
        help="Directory to write rewritten *.ll modules (default: build/stage2/aot)",
    )
    parser.add_argument(
        "--instrument",
        action="store_true",
        help="Keep Stage2 debug marker instrumentation in the output",
    )

    args = parser.parse_args(argv)

    lowered = _load_modules(args.input)
    args.output.mkdir(parents=True, exist_ok=True)

    runner = Stage2Runner(
        lowered,
        initialise_runtime=False,
        compile_ir=False,
        disable_instrumentation=not args.instrument,
    )

    rewritten = runner.rewritten_modules()
    if not rewritten:
        raise RuntimeError("no rewritten modules produced")

    for name, ir in rewritten:
        if name == "main":
            # The stage2 compiler IR includes its own CLI `main` entrypoint.
            # The native AOT executable provides a separate C `main`, so we
            # rename the IR symbol to prevent duplicate-definition link errors.
            ir = ir.replace("@main(", "@stage2_compiler_main(")
        target = args.output / f"{name}.ll"
        target.write_text(ir, encoding="utf-8")

    (args.output / "modules.txt").write_text(
        "\n".join(name for name, _ in rewritten) + "\n", encoding="utf-8"
    )

    print(
        f"[prepare-stage2-aot] wrote {len(rewritten)} module(s) to {args.output}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
