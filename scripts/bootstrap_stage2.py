#!/usr/bin/env python3
"""Bootstrap Stage2 self-hosted compiler by compiling all compiler sources to LLVM.

This script compiles the Sailfin compiler itself using the Stage2 LLVM backend,
producing native executable artifacts that can run independently of the Python runtime.
"""

from __future__ import annotations

import argparse
import importlib
import pathlib
import sys
from typing import List

REPO_ROOT = pathlib.Path(__file__).resolve().parents[1]

if str(REPO_ROOT) not in sys.path:
    sys.path.insert(0, str(REPO_ROOT))


class Stage2BootstrapError(RuntimeError):
    """Raised when Stage2 bootstrap compilation fails."""
    pass


def compile_compiler_to_stage2(output_dir: pathlib.Path, *, debug: bool = False) -> List[pathlib.Path]:
    """Compile all compiler sources to Stage2 LLVM artifacts.

    Args:
        output_dir: Directory to write compiled LLVM modules
        debug: Enable verbose output

    Returns:
        List of paths to compiled LLVM module files

    Raises:
        Stage2BootstrapError: If compilation fails
    """
    stage1_main = importlib.import_module("compiler.build.main")

    compiler_src = REPO_ROOT / "compiler" / "src"
    runtime_src = REPO_ROOT / "runtime"

    if not compiler_src.exists():
        raise Stage2BootstrapError(
            f"compiler source directory not found: {compiler_src}")

    if not runtime_src.exists():
        raise Stage2BootstrapError(
            f"runtime source directory not found: {runtime_src}")

    # Collect all Sailfin source files
    sources = sorted(compiler_src.rglob("*.sfn"))
    runtime_sources = sorted(runtime_src.rglob("*.sfn"))
    all_sources = sources + runtime_sources

    if not all_sources:
        raise Stage2BootstrapError("no Sailfin sources found to compile")

    if debug:
        print(f"[stage2-bootstrap] compiling {len(all_sources)} modules:")
        for src in all_sources:
            print(f"  - {src.relative_to(REPO_ROOT)}")

    output_dir.mkdir(parents=True, exist_ok=True)
    compiled_modules: List[pathlib.Path] = []
    diagnostic_count = 0
    fatal_count = 0

    # Compile each source file to LLVM
    for source_path in all_sources:
        if debug:
            print(f"[stage2-bootstrap] compiling {source_path.name}...")

        try:
            source = source_path.read_text(encoding="utf-8")
            result = stage1_main.compile_to_native_llvm(source)

            # Check for diagnostics
            diagnostics = getattr(result, "diagnostics", [])
            if diagnostics:
                diagnostic_count += len(diagnostics)
                for diag in diagnostics:
                    # Count as fatal only if it's a real error, not a warning about unsupported LLVM features
                    is_llvm_warning = "llvm lowering:" in str(
                        diag).lower() and not str(diag).startswith("fatal:")
                    severity = "warn" if is_llvm_warning else (
                        "error" if "error" in str(diag).lower() else "warn")
                    print(
                        f"[stage2-bootstrap][{severity}] {source_path.name}: {diag}")
                    if severity == "error" and not is_llvm_warning:
                        fatal_count += 1

            # Extract LLVM IR
            ir = getattr(result, "ir", None)
            if ir is None:
                raise Stage2BootstrapError(
                    f"no LLVM IR generated for {source_path.name}")

            # Write LLVM IR to output directory
            output_path = output_dir / source_path.with_suffix(".ll").name
            output_path.write_text(ir, encoding="utf-8")
            compiled_modules.append(output_path)

            if debug:
                print(
                    f"[stage2-bootstrap]   -> {output_path.relative_to(REPO_ROOT)}")

        except Exception as exc:
            raise Stage2BootstrapError(
                f"failed to compile {source_path.name}: {exc}"
            ) from exc

    if fatal_count > 0:
        raise Stage2BootstrapError(
            f"compilation failed with {fatal_count} fatal diagnostic(s)"
        )

    if debug and diagnostic_count > 0:
        print(
            f"[stage2-bootstrap] completed with {diagnostic_count} diagnostic(s)")

    return compiled_modules


def validate_stage2_artifacts(llvm_modules: List[pathlib.Path], *, debug: bool = False) -> None:
    """Validate that compiled LLVM modules are well-formed.

    Args:
        llvm_modules: List of paths to LLVM module files
        debug: Enable verbose output

    Raises:
        Stage2BootstrapError: If validation fails
    """
    try:
        import llvmlite.binding as llvm
    except ImportError as exc:
        raise Stage2BootstrapError(
            "llvmlite not available; cannot validate LLVM modules"
        ) from exc

    if debug:
        print(
            f"[stage2-bootstrap] validating {len(llvm_modules)} LLVM module(s)...")

    llvm.initialize()

    for module_path in llvm_modules:
        if debug:
            print(f"[stage2-bootstrap]   validating {module_path.name}...")

        try:
            ir_text = module_path.read_text(encoding="utf-8")
            llvm_module = llvm.parse_assembly(ir_text)
            llvm_module.verify()

            if debug:
                print(f"[stage2-bootstrap]     ✓ {module_path.name} is valid")

        except Exception as exc:
            raise Stage2BootstrapError(
                f"LLVM module validation failed for {module_path.name}: {exc}"
            ) from exc

    if debug:
        print("[stage2-bootstrap] all modules validated successfully")


def _parse_args(argv: list[str] | None = None) -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description="Bootstrap Stage2 self-hosted Sailfin compiler"
    )
    parser.add_argument(
        "--out",
        dest="output",
        type=pathlib.Path,
        default=REPO_ROOT / "build" / "stage2",
        help="Directory to receive compiled LLVM modules (default: build/stage2)",
    )
    parser.add_argument(
        "--debug",
        action="store_true",
        help="Enable verbose output",
    )
    parser.add_argument(
        "--validate",
        action="store_true",
        default=True,
        help="Validate LLVM modules after compilation (default: enabled)",
    )
    parser.add_argument(
        "--no-validate",
        dest="validate",
        action="store_false",
        help="Skip LLVM module validation",
    )
    return parser.parse_args(argv)


def main(argv: list[str] | None = None) -> int:
    """Main entry point for Stage2 bootstrap script."""
    args = _parse_args(argv)

    try:
        print("[stage2-bootstrap] starting Stage2 self-hosting compilation...")

        # Compile compiler sources to LLVM
        llvm_modules = compile_compiler_to_stage2(
            args.output, debug=args.debug)

        print(
            f"[stage2-bootstrap] compiled {len(llvm_modules)} module(s) to {args.output}")

        # Validate LLVM modules if requested
        if args.validate:
            validate_stage2_artifacts(llvm_modules, debug=args.debug)

        print("[stage2-bootstrap] ✓ Stage2 bootstrap completed successfully")
        return 0

    except Stage2BootstrapError as exc:
        print(f"[stage2-bootstrap][error] {exc}", file=sys.stderr)
        if args.debug and exc.__cause__:
            import traceback
            print("\nCaused by:", file=sys.stderr)
            traceback.print_exception(
                type(exc.__cause__), exc.__cause__, exc.__cause__.__traceback__)
        return 1
    except KeyboardInterrupt:
        print("\n[stage2-bootstrap] interrupted", file=sys.stderr)
        return 130


if __name__ == "__main__":
    raise SystemExit(main())
