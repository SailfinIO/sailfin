#!/usr/bin/env python3
"""Bootstrap Stage2 self-hosted compiler by compiling all compiler sources to LLVM.

This script compiles the Sailfin compiler itself using the Stage2 LLVM backend,
producing native executable artifacts that can run independently of the Python runtime.
"""

from __future__ import annotations

import argparse
import importlib
import pathlib
import re
import sys
from collections import defaultdict
from typing import Dict, List, Tuple

REPO_ROOT = pathlib.Path(__file__).resolve().parents[1]

if str(REPO_ROOT) not in sys.path:
    sys.path.insert(0, str(REPO_ROOT))


class Stage2BootstrapError(RuntimeError):
    """Raised when Stage2 bootstrap compilation fails."""
    pass


class DiagnosticAggregator:
    """Aggregates and categorizes diagnostics from Stage2 compilation."""

    def __init__(self):
        self.categories: Dict[str, int] = defaultdict(int)
        self.by_module: Dict[str, Dict[str, int]
                             ] = defaultdict(lambda: defaultdict(int))
        self.total_count = 0
        self.fatal_count = 0
        self.examples: Dict[str, str] = {}  # Store one example per category

    def add_diagnostic(self, module_name: str, diagnostic: str, is_fatal: bool = False):
        """Add a diagnostic and categorize it."""
        self.total_count += 1
        if is_fatal:
            self.fatal_count += 1

        # Extract category from diagnostic message
        category = self._categorize_diagnostic(diagnostic)
        self.categories[category] += 1
        self.by_module[module_name][category] += 1

        # Store first example of each category
        if category not in self.examples:
            self.examples[category] = diagnostic

    def _categorize_diagnostic(self, diagnostic: str) -> str:
        """Extract a normalized category from a diagnostic message."""
        # Remove module prefix if present
        text = diagnostic
        if ": llvm lowering:" in text:
            text = text.split(": llvm lowering:", 1)[1].strip()
        elif "llvm lowering:" in text:
            text = text.split("llvm lowering:", 1)[1].strip()

        # Common patterns to extract
        patterns = [
            (r"^member access base `([^`]+)` lacks struct metadata",
             "member access on {0} lacks metadata"),
            (r"^member access on opaque type `([^`]+)`",
             "member access on opaque type {0}"),
            (r"^unable to coerce operand of type `([^`]+)` to `([^`]+)`",
             "type coercion {0} → {1}"),
            (r"^unable to coerce argument \d+ for call to `([^`]+)`",
             "call argument coercion for {0}"),
            (r"^call to unknown function `([^`]+)`", "unknown function {0}"),
            (r"^condition produced no value in `([^`]+)`",
             "condition failed in {0}"),
            (r"^unable to lower if condition in `([^`]+)`",
             "if condition failed in {0}"),
            (r"^unsupported expression `([^`]+)`",
             "unsupported expression: {0}"),
            (r"^struct `([^`]+)` has no field `([^`]+)`",
             "struct {0} missing field {1}"),
            (r"^failed to lower argument \d+ for call to `([^`]+)`",
             "call argument lowering for {0}"),
            (r"^unable to coerce assignment value for `([^`]+)`",
             "assignment coercion for {0}"),
        ]

        for pattern, template in patterns:
            match = re.match(pattern, text)
            if match:
                try:
                    return template.format(*match.groups())
                except:
                    return template

        # Truncate long messages
        if len(text) > 80:
            text = text[:77] + "..."

        return text

    def print_summary(self, verbose: bool = False):
        """Print a summary of diagnostics."""
        print("\n" + "=" * 80)
        print("STAGE2 BOOTSTRAP DIAGNOSTIC SUMMARY")
        print("=" * 80)
        print(f"Total diagnostics: {self.total_count}")
        print(f"Fatal errors: {self.fatal_count}")
        print(f"Unique categories: {len(self.categories)}")
        print()

        # Sort categories by count (descending)
        sorted_categories = sorted(
            self.categories.items(), key=lambda x: x[1], reverse=True)

        # Print top 20 categories
        print("TOP DIAGNOSTIC CATEGORIES (by frequency):")
        print("-" * 80)
        for i, (category, count) in enumerate(sorted_categories[:20], 1):
            percentage = (count / self.total_count) * 100
            print(f"{i:2d}. [{count:5d}] ({percentage:5.2f}%) {category}")
            if verbose and category in self.examples:
                example = self.examples[category]
                if len(example) > 70:
                    example = example[:67] + "..."
                print(f"     Example: {example}")

        # If there are more categories, show count
        if len(sorted_categories) > 20:
            remaining = len(sorted_categories) - 20
            remaining_count = sum(count for _, count in sorted_categories[20:])
            print(
                f"\n... and {remaining} more categories ({remaining_count} diagnostics)")

        print()

        # Module breakdown
        if verbose:
            print("\nDIAGNOSTICS BY MODULE:")
            print("-" * 80)
            module_totals = [(name, sum(counts.values()))
                             for name, counts in self.by_module.items()]
            module_totals.sort(key=lambda x: x[1], reverse=True)

            for module_name, total in module_totals[:10]:
                print(f"{module_name}: {total} diagnostics")
                # Show top 3 categories for this module
                module_cats = sorted(self.by_module[module_name].items(),
                                     key=lambda x: x[1], reverse=True)[:3]
                for cat, count in module_cats:
                    print(f"  - [{count:4d}] {cat}")

            if len(module_totals) > 10:
                print(f"\n... and {len(module_totals) - 10} more modules")

        print("=" * 80)

    def save_report(self, output_path: pathlib.Path):
        """Save detailed report to a file."""
        with open(output_path, "w") as f:
            f.write("STAGE2 BOOTSTRAP DIAGNOSTIC REPORT\n")
            f.write("=" * 80 + "\n\n")
            f.write(f"Total diagnostics: {self.total_count}\n")
            f.write(f"Fatal errors: {self.fatal_count}\n")
            f.write(f"Unique categories: {len(self.categories)}\n\n")

            # All categories
            f.write("ALL DIAGNOSTIC CATEGORIES:\n")
            f.write("-" * 80 + "\n")
            sorted_categories = sorted(
                self.categories.items(), key=lambda x: x[1], reverse=True)
            for i, (category, count) in enumerate(sorted_categories, 1):
                percentage = (count / self.total_count) * 100
                f.write(
                    f"{i:3d}. [{count:5d}] ({percentage:5.2f}%) {category}\n")
                if category in self.examples:
                    f.write(f"      Example: {self.examples[category]}\n")

            f.write("\n" + "=" * 80 + "\n")
            f.write("DIAGNOSTICS BY MODULE:\n")
            f.write("-" * 80 + "\n")

            module_totals = [(name, sum(counts.values()))
                             for name, counts in self.by_module.items()]
            module_totals.sort(key=lambda x: x[1], reverse=True)

            for module_name, total in module_totals:
                f.write(f"\n{module_name}: {total} diagnostics\n")
                module_cats = sorted(self.by_module[module_name].items(),
                                     key=lambda x: x[1], reverse=True)
                for cat, count in module_cats:
                    f.write(f"  [{count:4d}] {cat}\n")

        print(f"\n[stage2-bootstrap] detailed report saved to {output_path}")


def compile_compiler_to_stage2(output_dir: pathlib.Path, *, debug: bool = False,
                               quiet: bool = False) -> Tuple[List[pathlib.Path], DiagnosticAggregator]:
    """Compile all compiler sources to Stage2 LLVM artifacts.

    Args:
        output_dir: Directory to write compiled LLVM modules
        debug: Enable verbose output
        quiet: Suppress individual diagnostic output (use with summary)

    Returns:
        Tuple of (compiled module paths, diagnostic aggregator)

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
    aggregator = DiagnosticAggregator()

    # Compile each source file to LLVM
    for source_path in all_sources:
        if debug:
            print(f"[stage2-bootstrap] compiling {source_path.name}...")

        try:
            source = source_path.read_text(encoding="utf-8")
            # Try the new function that returns both LLVM and native_module
            if hasattr(stage1_main, "compile_to_native_llvm_full"):
                full_result = stage1_main.compile_to_native_llvm_full(source)
                result = full_result.llvm
                native_module = full_result.native_module
            else:
                result = stage1_main.compile_to_native_llvm(source)
                native_module = None

            # Check for diagnostics
            diagnostics = getattr(result, "diagnostics", [])
            if diagnostics:
                for diag in diagnostics:
                    # Count as fatal only if it's a real error, not a warning about unsupported LLVM features
                    is_llvm_warning = "llvm lowering:" in str(
                        diag).lower() and not str(diag).startswith("fatal:")
                    is_fatal = not is_llvm_warning and "error" in str(
                        diag).lower()

                    # Add to aggregator
                    aggregator.add_diagnostic(
                        source_path.name, str(diag), is_fatal)

                    # Print if not in quiet mode
                    if not quiet:
                        severity = "warn" if is_llvm_warning else (
                            "error" if is_fatal else "warn")
                        print(
                            f"[stage2-bootstrap][{severity}] {source_path.name}: {diag}")

            # Extract LLVM IR
            ir = getattr(result, "ir", None)
            if ir is None:
                raise Stage2BootstrapError(
                    f"no LLVM IR generated for {source_path.name}")

            # Write LLVM IR to output directory
            output_path = output_dir / source_path.with_suffix(".ll").name
            output_path.write_text(ir, encoding="utf-8")
            compiled_modules.append(output_path)

            # Also extract and save layout manifest if available
            # The manifest contains struct/enum layout information needed for cross-module type resolution
            if native_module is not None and hasattr(native_module, "artifacts"):
                for artifact in native_module.artifacts:
                    if hasattr(artifact, "format") and artifact.format == "sailfin-layout-manifest":
                        manifest_path = output_dir / \
                            source_path.with_suffix(".layout-manifest").name
                        manifest_content = getattr(artifact, "contents", "")
                        manifest_path.write_text(
                            manifest_content, encoding="utf-8")
                        if debug:
                            print(
                                f"[stage2-bootstrap]   -> {manifest_path.relative_to(REPO_ROOT)}")

            if debug:
                print(
                    f"[stage2-bootstrap]   -> {output_path.relative_to(REPO_ROOT)}")

        except Exception as exc:
            raise Stage2BootstrapError(
                f"failed to compile {source_path.name}: {exc}"
            ) from exc

    if aggregator.fatal_count > 0:
        raise Stage2BootstrapError(
            f"compilation failed with {aggregator.fatal_count} fatal diagnostic(s)"
        )

    if debug and aggregator.total_count > 0:
        print(
            f"[stage2-bootstrap] completed with {aggregator.total_count} diagnostic(s)")

    return compiled_modules, aggregator


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
        "--quiet",
        action="store_true",
        help="Suppress individual diagnostic output (only show summary)",
    )
    parser.add_argument(
        "--summary",
        action="store_true",
        default=True,
        help="Show diagnostic summary at end (default: enabled)",
    )
    parser.add_argument(
        "--no-summary",
        dest="summary",
        action="store_false",
        help="Skip diagnostic summary",
    )
    parser.add_argument(
        "--report",
        type=pathlib.Path,
        help="Save detailed diagnostic report to file",
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
        llvm_modules, aggregator = compile_compiler_to_stage2(
            args.output, debug=args.debug, quiet=args.quiet)

        print(
            f"[stage2-bootstrap] compiled {len(llvm_modules)} module(s) to {args.output}")

        # Show diagnostic summary if requested
        if args.summary and aggregator.total_count > 0:
            aggregator.print_summary(verbose=args.debug)

        # Save detailed report if requested
        if args.report:
            aggregator.save_report(args.report)

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
