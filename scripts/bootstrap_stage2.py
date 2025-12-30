#!/usr/bin/env python3
"""Bootstrap Stage2 self-hosted compiler by compiling all compiler sources to LLVM.

This script compiles the Sailfin compiler itself using the Stage2 LLVM backend,
producing native executable artifacts that can run independently of the Python runtime.
"""

from __future__ import annotations

import argparse
import hashlib
import importlib
import json
import pathlib
import re
import shutil
import sys
from collections import defaultdict
import time
from typing import Any, Dict, List, Optional, Set, Tuple

REPO_ROOT = pathlib.Path(__file__).resolve().parents[1]

if str(REPO_ROOT) not in sys.path:
    sys.path.insert(0, str(REPO_ROOT))


_STAGE1_LOWERING = None

_STAGE1_AOT_PREPARE = None


_STAGE2_BOOTSTRAP_CACHE_VERSION = "stage2-bootstrap-cache-v1"


def _sha256_text(text: str) -> str:
    digest = hashlib.sha256()
    digest.update(text.encode("utf-8"))
    return digest.hexdigest()


def _atomic_write_text(path: pathlib.Path, content: str) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    tmp_path = path.with_suffix(path.suffix + ".tmp")
    tmp_path.write_text(content, encoding="utf-8")
    tmp_path.replace(path)


def _relative_output_path(source_path: pathlib.Path, suffix: str, output_dir: pathlib.Path) -> pathlib.Path:
    """Compute the output path preserving directory structure relative to compiler/src or runtime.

    For example:
      compiler/src/llvm/types.sfn -> output_dir/llvm/types.ll
      compiler/src/parser.sfn -> output_dir/parser.ll
      runtime/prelude.sfn -> output_dir/prelude.ll

    This enables nested module imports to resolve correctly.
    """
    compiler_src = REPO_ROOT / "compiler" / "src"
    runtime_src = REPO_ROOT / "runtime"

    try:
        relative = source_path.relative_to(compiler_src)
        return output_dir / relative.with_suffix(suffix)
    except ValueError:
        pass

    try:
        relative = source_path.relative_to(runtime_src)
        # Runtime files go directly in output_dir (no subdirectory)
        return output_dir / relative.with_suffix(suffix)
    except ValueError:
        pass

    # Fallback to just the filename
    return output_dir / source_path.with_suffix(suffix).name


def _stage1_fingerprint() -> str:
    """Fingerprint the stage1-generated Python compiler modules.

    `bootstrap_stage2.py` imports `compiler.build.main` + lowering helpers.
    If those change, we must rebuild stage2 artifacts.
    """

    digest = hashlib.sha256()
    digest.update(_STAGE2_BOOTSTRAP_CACHE_VERSION.encode("utf-8"))
    digest.update(b"\0")
    digest.update(
        f"python-{sys.version_info.major}.{sys.version_info.minor}".encode("utf-8"))
    digest.update(b"\0")

    stage1_root = (REPO_ROOT / "compiler" / "build").resolve()
    inputs: List[pathlib.Path] = []
    if stage1_root.exists():
        inputs.extend(sorted(stage1_root.rglob("*.py")))
    inputs.append(pathlib.Path(__file__).resolve())

    for path in inputs:
        try:
            rel = path.relative_to(REPO_ROOT)
        except ValueError:
            rel = path
        digest.update(str(rel).encode("utf-8"))
        digest.update(b"\0")
        try:
            data = path.read_bytes()
        except FileNotFoundError:
            data = b"<missing>"
        digest.update(data)
        digest.update(b"\0")

    return digest.hexdigest()


def _bootstrap_manifest_path(output_dir: pathlib.Path) -> pathlib.Path:
    return output_dir / ".stage2-bootstrap-manifest.json"


def _load_bootstrap_manifest(output_dir: pathlib.Path) -> Dict[str, Any] | None:
    path = _bootstrap_manifest_path(output_dir)
    if not path.exists():
        return None
    try:
        return json.loads(path.read_text(encoding="utf-8"))
    except Exception:
        return None


def _write_bootstrap_manifest(output_dir: pathlib.Path, payload: Dict[str, Any]) -> None:
    path = _bootstrap_manifest_path(output_dir)
    _atomic_write_text(path, json.dumps(
        payload, indent=2, sort_keys=True) + "\n")


def _resolve_import_provider(
    import_path: str,
    *,
    providers_by_name: Dict[str, pathlib.Path],
) -> pathlib.Path | None:
    module_name = _import_basename(import_path)
    provider = providers_by_name.get(module_name)
    if provider is not None:
        return provider
    if "/" in module_name:
        provider = providers_by_name.get(module_name.split("/")[-1])
    return provider


def _stage1_lowering_module():
    global _STAGE1_LOWERING
    if _STAGE1_LOWERING is None:
        _STAGE1_LOWERING = importlib.import_module(
            "compiler.build.native_llvm_lowering"
        )
    return _STAGE1_LOWERING


def _stage1_aot_prepare_module():
    global _STAGE1_AOT_PREPARE
    if _STAGE1_AOT_PREPARE is None:
        _STAGE1_AOT_PREPARE = importlib.import_module(
            "compiler.build.aot_prepare")
    return _STAGE1_AOT_PREPARE


def prepare_stage2_aot_modules(
    module_paths: List[pathlib.Path],
    *,
    output_dir: pathlib.Path,
    debug: bool = False,
) -> pathlib.Path:
    """Rewrite stage2 *.ll modules into an AOT-safe, collision-free set.

    Uses the stage1-generated implementation from compiler/src/aot_prepare.sfn.
    Writes rewritten IR modules to build/stage2/aot and returns that directory.
    """

    aot_dir = output_dir / "aot"
    aot_dir.mkdir(parents=True, exist_ok=True)

    module_names = [p.stem for p in module_paths]

    # Fast path: skip AOT rewriting if inputs are unchanged.
    manifest_path = aot_dir / ".aot-prepare-manifest.json"
    input_hashes: Dict[str, str] = {}
    for path in module_paths:
        digest = hashlib.sha256()
        digest.update(path.read_bytes())
        input_hashes[path.stem] = digest.hexdigest()

    expected_outputs_ok = True
    for name in module_names:
        if not (aot_dir / f"{name}.ll").exists():
            expected_outputs_ok = False
            break
    if expected_outputs_ok and (aot_dir / "modules.txt").exists() and manifest_path.exists():
        try:
            cached = json.loads(manifest_path.read_text(encoding="utf-8"))
        except Exception:
            cached = None
        if isinstance(cached, dict) and cached.get("version") == "aot-prepare-v1":
            cached_names = cached.get("module_names")
            cached_hashes = cached.get("input_hashes")
            if cached_names == module_names and cached_hashes == input_hashes:
                if debug:
                    rel = aot_dir.relative_to(REPO_ROOT)
                    print(
                        f"[stage2-bootstrap] reused AOT-rewritten modules in {rel}")
                return aot_dir

    module_texts = [p.read_text(encoding="utf-8") for p in module_paths]

    aot_prepare = _stage1_aot_prepare_module()
    rewritten = aot_prepare.prepare_stage2_aot_modules(
        module_names, module_texts)
    if len(rewritten) != len(module_names):
        raise Stage2BootstrapError(
            "stage1 aot_prepare returned unexpected module count: "
            f"{len(rewritten)} (expected {len(module_names)})"
        )

    for name, ir in zip(module_names, rewritten):
        _atomic_write_text(aot_dir / f"{name}.ll", ir)

    _atomic_write_text(aot_dir / "modules.txt", "\n".join(module_names) + "\n")
    _atomic_write_text(
        manifest_path,
        json.dumps(
            {
                "version": "aot-prepare-v1",
                "module_names": module_names,
                "input_hashes": input_hashes,
            },
            indent=2,
            sort_keys=True,
        )
        + "\n",
    )

    if debug:
        rel = aot_dir.relative_to(REPO_ROOT)
        print(f"[stage2-bootstrap] wrote AOT-rewritten modules to {rel}")

    return aot_dir


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


def extract_import_paths(source: str) -> List[str]:
    """Extract import module paths from Sailfin source code.

    Handles both single-line and multiline import statements so we can
    gather the layout manifests required for cross-module lowering.
    """

    def _extract_path(import_statement: str) -> Optional[str]:
        statement = import_statement.strip()
        if " from " in statement:
            _, remainder = statement.split(" from ", 1)
        else:
            parts = statement.split()
            remainder = parts[1] if len(parts) > 1 else ""

        remainder = remainder.strip()
        if remainder.endswith(";"):
            remainder = remainder[:-1].strip()
        if remainder.startswith(("'", '"')):
            quote = remainder[0]
            end_quote = remainder.find(quote, 1)
            if end_quote > 0:
                return remainder[1:end_quote]
        return None

    import_paths: List[str] = []
    current: List[str] = []
    collecting = False

    for raw_line in source.splitlines():
        line = raw_line.strip()
        if not collecting:
            if line.startswith("import "):
                current = [line]
                collecting = True
                if line.endswith(";"):
                    collected = " ".join(current)
                    collecting = False
                    module = _extract_path(collected)
                    if module and module not in import_paths:
                        import_paths.append(module)
                continue
        else:
            current.append(line)
            if line.endswith(";"):
                collected = " ".join(current)
                collecting = False
                module = _extract_path(collected)
                if module and module not in import_paths:
                    import_paths.append(module)
                current = []

    return import_paths


def _import_basename(import_path: str) -> str:
    if import_path.startswith("./"):
        return import_path[2:]
    if import_path.startswith("../"):
        parts = import_path.split("/")
        return parts[-1] if parts else import_path
    return import_path


def load_manifest_for_import(import_path: str, output_dir: pathlib.Path) -> str:
    """Load a layout manifest for an imported module.

    Args:
        import_path: Import path like "./ast" or "../runtime/prelude"
        output_dir: Directory containing compiled manifests

    Returns:
        Manifest content as string, or empty string if not found
    """
    # Convert import path to manifest filename
    # "./ast" -> "ast.layout-manifest"
    # "../runtime/prelude" -> "prelude.layout-manifest"

    module_name = _import_basename(import_path)

    manifest_path = output_dir / f"{module_name}.layout-manifest"

    if manifest_path.exists():
        return manifest_path.read_text(encoding="utf-8")

    if "/" in module_name:
        fallback = module_name.split("/")[-1]
        fallback_path = output_dir / f"{fallback}.layout-manifest"
        if fallback_path.exists():
            return fallback_path.read_text(encoding="utf-8")

    return ""


def load_native_text_for_import(import_path: str, output_dir: pathlib.Path) -> str:
    """Load the native text artifact for an imported module."""

    module_name = _import_basename(import_path)
    text_path = output_dir / f"{module_name}.sfn-asm"

    if text_path.exists():
        return text_path.read_text(encoding="utf-8")

    if "/" in module_name:
        fallback = module_name.split("/")[-1]
        fallback_path = output_dir / f"{fallback}.sfn-asm"
        if fallback_path.exists():
            return fallback_path.read_text(encoding="utf-8")

    return ""


def compile_compiler_to_stage2(
    output_dir: pathlib.Path,
    *,
    debug: bool = False,
    quiet: bool = False,
    capture_results: bool = False,
    progress: bool = False,
    incremental: bool = True,
    force: bool = False,
) -> Tuple[List[pathlib.Path], DiagnosticAggregator] | Tuple[List[pathlib.Path], DiagnosticAggregator, Dict[pathlib.Path, Any]]:
    """Compile all compiler sources to Stage2 LLVM artifacts.

    Args:
        output_dir: Directory to write compiled LLVM modules
        debug: Enable verbose output
        quiet: Suppress individual diagnostic output (use with summary)
        capture_results: When True, retain the lowered LLVM results for each
            source file and return them alongside the compiled module paths.

    Returns:
        Either ``(compiled_modules, aggregator)`` when ``capture_results`` is
        False, or ``(compiled_modules, aggregator, lowered_results)`` when the
        lowered results are requested. ``lowered_results`` maps absolute source
        paths to their corresponding lowered LLVM result objects.

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

    has_full = hasattr(stage1_main, "compile_to_native_llvm_full")
    has_manifest = hasattr(
        stage1_main, "compile_to_native_llvm_with_manifests")
    has_context = hasattr(stage1_main, "compile_to_native_llvm_with_context")

    # Collect all Sailfin source files
    # Note: compiler/src/aot_prepare.sfn is a stage1-only helper (used to rewrite
    # LLVM text for AOT); it is intentionally excluded from stage2 LLVM output.
    sources = [p for p in sorted(compiler_src.rglob(
        "*.sfn")) if p.name != "aot_prepare.sfn"]
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
    lowered_results: Dict[pathlib.Path,
                          Any] | None = {} if capture_results else None

    source_cache: Dict[pathlib.Path, str] = {}
    import_cache: Dict[pathlib.Path, List[str]] = {}
    first_pass_results: Dict[pathlib.Path, Any] = {}

    # --- Incremental planning -------------------------------------------------
    current_stage1 = _stage1_fingerprint()
    prior_manifest = _load_bootstrap_manifest(
        output_dir) if incremental else None
    prior_sources: Dict[str, Any] = {}
    prior_stage1 = None
    prior_version = None
    prior_python = None
    if prior_manifest is not None:
        prior_sources = dict(prior_manifest.get("sources", {}) or {})
        prior_stage1 = prior_manifest.get("stage1_fingerprint")
        prior_version = prior_manifest.get("version")
        prior_python = prior_manifest.get("python")

    python_tag = f"{sys.version_info.major}.{sys.version_info.minor}"
    rebuild_all = force or (not incremental)
    if incremental and not rebuild_all:
        if prior_manifest is None:
            rebuild_all = True
        elif prior_version != _STAGE2_BOOTSTRAP_CACHE_VERSION:
            rebuild_all = True
        elif prior_python != python_tag:
            rebuild_all = True
        elif prior_stage1 != current_stage1:
            rebuild_all = True

    # Map import basenames -> providing source paths.
    providers_by_name: Dict[str, pathlib.Path] = {
        p.stem: p for p in all_sources}
    dependents: Dict[pathlib.Path, Set[pathlib.Path]] = defaultdict(set)

    # Read sources once up-front and compute import graph.
    source_hash: Dict[pathlib.Path, str] = {}
    for source_path in all_sources:
        source = source_path.read_text(encoding="utf-8")
        source_cache[source_path] = source
        imports = extract_import_paths(source)
        import_cache[source_path] = imports
        source_hash[source_path] = _sha256_text(source)
        for import_path in imports:
            provider = _resolve_import_provider(
                import_path, providers_by_name=providers_by_name
            )
            if provider is None:
                continue
            dependents[provider].add(source_path)

    # Determine which outputs must exist for a module to be considered reusable.
    def _required_outputs_for(source_path: pathlib.Path) -> List[pathlib.Path]:
        outputs = [_relative_output_path(source_path, ".ll", output_dir)]
        if has_manifest or has_context:
            outputs.append(
                _relative_output_path(source_path, ".layout-manifest", output_dir))
        if has_context:
            outputs.append(
                _relative_output_path(source_path, ".sfn-asm", output_dir))
        return outputs

    direct_rebuild: Set[pathlib.Path] = set()
    missing_outputs: Set[pathlib.Path] = set()
    if rebuild_all:
        direct_rebuild = set(all_sources)
    else:
        for source_path in all_sources:
            rel_key = str(source_path.relative_to(REPO_ROOT))
            previous = prior_sources.get(rel_key) if prior_sources else None
            previous_hash = previous.get(
                "sha256") if isinstance(previous, dict) else None
            required = _required_outputs_for(source_path)
            if any(not path.exists() for path in required):
                missing_outputs.add(source_path)
                direct_rebuild.add(source_path)
                continue
            if previous_hash != source_hash[source_path]:
                direct_rebuild.add(source_path)

    # Propagate rebuild to dependents (imports) so callers see updated manifests.
    to_rebuild: Set[pathlib.Path] = set(direct_rebuild)
    queue: List[pathlib.Path] = list(direct_rebuild)
    while queue:
        changed = queue.pop()
        for dependent in dependents.get(changed, set()):
            if dependent in to_rebuild:
                continue
            to_rebuild.add(dependent)
            queue.append(dependent)

    if incremental and not force:
        skipped = len(all_sources) - len(to_rebuild)
        if skipped > 0:
            changed = len(direct_rebuild)
            missing = len(missing_outputs)
            print(
                f"[stage2-bootstrap] incremental: rebuilding {len(to_rebuild)}/{len(all_sources)} module(s) "
                f"(direct={changed}, missing={missing}, reused={skipped})"
            )

    if debug:
        print("[stage2-bootstrap] first pass: collecting layout manifests...")

    first_pass_sources = sorted(to_rebuild, key=lambda p: str(p))
    first_pass_total = len(first_pass_sources)
    for index, source_path in enumerate(first_pass_sources):
        try:
            source = source_cache[source_path]
            imports = import_cache.get(source_path, [])

            if debug or progress:
                rel = source_path.relative_to(REPO_ROOT)
                print(
                    f"[stage2-bootstrap] pass1 {index + 1}/{first_pass_total}: {rel}",
                    flush=True,
                )

            start = time.perf_counter() if progress else None

            if has_full:
                full_result = stage1_main.compile_to_native_llvm_full(source)
                first_pass_results[source_path] = full_result
                native_module = getattr(full_result, "native_module", None)
                if native_module is not None and hasattr(native_module, "artifacts"):
                    for artifact in native_module.artifacts:
                        if hasattr(artifact, "format") and artifact.format == "sailfin-layout-manifest":
                            manifest_path = _relative_output_path(
                                source_path, ".layout-manifest", output_dir)
                            manifest_content = getattr(
                                artifact, "contents", "")
                            _atomic_write_text(manifest_path, manifest_content)
                            if debug:
                                rel_path = manifest_path.relative_to(REPO_ROOT)
                                print(
                                    f"[stage2-bootstrap]     wrote {rel_path}")
                        elif hasattr(artifact, "format") and artifact.format == "sailfin-native-text":
                            text_path = _relative_output_path(
                                source_path, ".sfn-asm", output_dir)
                            text_content = getattr(artifact, "contents", "")
                            _atomic_write_text(text_path, text_content)
                            if debug:
                                rel_text = text_path.relative_to(REPO_ROOT)
                                print(
                                    f"[stage2-bootstrap]     wrote {rel_text}")
            else:
                lowered = stage1_main.compile_to_native_llvm(source)
                first_pass_results[source_path] = lowered

            if start is not None:
                elapsed = time.perf_counter() - start
                if elapsed >= 2.0:
                    print(
                        f"[stage2-bootstrap] pass1 slow ({elapsed:.1f}s): {source_path.name}",
                        flush=True,
                    )

        except Exception as exc:
            raise Stage2BootstrapError(
                f"failed to compile {source_path.name}: {exc}"
            ) from exc

    if debug:
        print("[stage2-bootstrap] second pass: lowering with manifests...")

    second_pass_sources = sorted(to_rebuild, key=lambda p: str(p))
    second_pass_total = len(second_pass_sources)
    for index, source_path in enumerate(second_pass_sources):
        try:
            source = source_cache[source_path]
            import_paths = import_cache.get(source_path, [])

            if debug or progress:
                rel = source_path.relative_to(REPO_ROOT)
                print(
                    f"[stage2-bootstrap] pass2 {index + 1}/{second_pass_total}: {rel}",
                    flush=True,
                )

            start = time.perf_counter() if progress else None

            import_contexts: List[Tuple[str, str]] = []
            if has_manifest:
                for import_path in import_paths:
                    manifest_content = load_manifest_for_import(
                        import_path, output_dir)
                    native_text_content = load_native_text_for_import(
                        import_path, output_dir)
                    import_contexts.append((manifest_content,
                                            native_text_content))
                    if debug and manifest_content:
                        print(
                            f"[stage2-bootstrap]   using manifest for {import_path}")

            result = None
            native_module = None

            cached_result = first_pass_results.get(source_path)
            if cached_result is None:
                raise Stage2BootstrapError(
                    f"first pass result missing for {source_path}")

            fallback_llvm = getattr(
                cached_result, "llvm", None) if has_full else None
            fallback_native_module = getattr(
                cached_result, "native_module", None) if has_full else None
            native_module = None

            if has_context and import_contexts and (any(ctx[0] for ctx in import_contexts) or any(ctx[1] for ctx in import_contexts)):
                manifests_payload = [ctx[0] for ctx in import_contexts]
                native_payload = [ctx[1] for ctx in import_contexts]
                result = stage1_main.compile_to_native_llvm_with_context(
                    source, manifests_payload, native_payload)
            elif has_manifest:
                manifest_payload = [ctx[0]
                                    for ctx in import_contexts if ctx[0]]
                if manifest_payload:
                    result = stage1_main.compile_to_native_llvm_with_manifests(
                        source, manifest_payload)
                else:
                    if has_full and fallback_llvm is not None:
                        result = fallback_llvm
                        native_module = fallback_native_module
                    else:
                        result = cached_result
            else:
                if has_full and fallback_llvm is not None:
                    result = fallback_llvm
                    native_module = fallback_native_module
                else:
                    result = cached_result

            _ensure_module_string_constants(source_path, source, result)
            _ensure_runtime_helper_declarations(result)

            diagnostics = getattr(result, "diagnostics", [])
            if diagnostics:
                for diag in diagnostics:
                    text = str(diag)
                    is_llvm_warning = "llvm lowering:" in text.lower() and not text.startswith("fatal:")
                    is_fatal = not is_llvm_warning and "error" in text.lower()
                    aggregator.add_diagnostic(source_path.name, text, is_fatal)
                    if not quiet:
                        severity = "warn" if is_llvm_warning else (
                            "error" if is_fatal else "warn")
                        print(
                            f"[stage2-bootstrap][{severity}] {source_path.name}: {diag}")

            ir = getattr(result, "ir", None)
            if ir is None:
                raise Stage2BootstrapError(
                    f"no LLVM IR generated for {source_path.name}")

            output_path = _relative_output_path(source_path, ".ll", output_dir)
            _atomic_write_text(output_path, ir)

            if lowered_results is not None:
                if fallback_llvm is not None and result is not fallback_llvm:
                    _merge_missing_string_constants(result, fallback_llvm)
                lowered_results[source_path] = result

            if native_module is not None and hasattr(native_module, "artifacts"):
                for artifact in native_module.artifacts:
                    if hasattr(artifact, "format") and artifact.format == "sailfin-layout-manifest":
                        manifest_path = _relative_output_path(
                            source_path, ".layout-manifest", output_dir)
                        manifest_content = getattr(artifact, "contents", "")
                        _atomic_write_text(manifest_path, manifest_content)
                        if debug:
                            rel_path = manifest_path.relative_to(REPO_ROOT)
                            print(
                                f"[stage2-bootstrap]     refreshed {rel_path}")
                    elif hasattr(artifact, "format") and artifact.format == "sailfin-native-text":
                        text_path = _relative_output_path(
                            source_path, ".sfn-asm", output_dir)
                        text_content = getattr(artifact, "contents", "")
                        _atomic_write_text(text_path, text_content)
                        if debug:
                            rel_text = text_path.relative_to(REPO_ROOT)
                            print(
                                f"[stage2-bootstrap]     refreshed {rel_text}")

            if debug:
                rel_ir = output_path.relative_to(REPO_ROOT)
                print(f"[stage2-bootstrap]   -> {rel_ir}")

            if start is not None:
                elapsed = time.perf_counter() - start
                if elapsed >= 2.0:
                    print(
                        f"[stage2-bootstrap] pass2 slow ({elapsed:.1f}s): {source_path.name}",
                        flush=True,
                    )

        except Exception as exc:
            raise Stage2BootstrapError(
                f"failed to compile {source_path.name}: {exc}"
            ) from exc

    if aggregator.fatal_count > 0:
        raise Stage2BootstrapError(
            f"compilation failed with {aggregator.fatal_count} fatal diagnostic(s)"
        )

    # Collect all module paths (rebuilt + reused) deterministically.
    all_module_paths: List[pathlib.Path] = []
    for source_path in all_sources:
        module_path = _relative_output_path(source_path, ".ll", output_dir)
        if not module_path.exists():
            raise Stage2BootstrapError(
                f"missing expected output module: {module_path} (source={source_path.name})"
            )
        all_module_paths.append(module_path)
    module_paths = sorted(all_module_paths, key=lambda p: p.stem)

    # Persist a deterministic module list to drive native AOT compilation.
    _atomic_write_text(
        output_dir / "modules.txt",
        "\n".join(p.stem for p in module_paths) + "\n",
    )

    # Prepare collision-free modules for AOT linking.
    prepare_stage2_aot_modules(
        module_paths, output_dir=output_dir, debug=debug)

    # Persist bootstrap manifest for incremental builds.
    manifest_sources: Dict[str, Any] = {}
    for source_path in all_sources:
        rel_key = str(source_path.relative_to(REPO_ROOT))
        manifest_sources[rel_key] = {
            "sha256": source_hash[source_path],
            "imports": import_cache.get(source_path, []),
        }
    _write_bootstrap_manifest(
        output_dir,
        {
            "version": _STAGE2_BOOTSTRAP_CACHE_VERSION,
            "python": python_tag,
            "stage1_fingerprint": current_stage1,
            "sources": manifest_sources,
        },
    )

    if debug and aggregator.total_count > 0:
        print(
            f"[stage2-bootstrap] completed with {aggregator.total_count} diagnostic(s)")

    compiled_modules = list(module_paths)
    if lowered_results is not None:
        return compiled_modules, aggregator, lowered_results

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


_STRING_DEF_PATTERN = re.compile(r"^(@\.str[^\s=]*)\s*=", re.MULTILINE)
_STRING_REF_PATTERN = re.compile(r"@\.str[0-9A-Za-z_.]*")


def verify_string_constants(llvm_modules: List[pathlib.Path], *, debug: bool = False) -> None:
    """Ensure every referenced @.str.* global has a definition within the module."""

    missing_by_module: Dict[str, List[str]] = {}

    for module_path in llvm_modules:
        if module_path.name != "native_llvm_lowering.ll":
            continue

        text = module_path.read_text(encoding="utf-8")

        defined = {match.group(1)
                   for match in _STRING_DEF_PATTERN.finditer(text)}
        referenced: Set[str] = set()
        for match in _STRING_REF_PATTERN.finditer(text):
            pos = match.start()
            if pos > 0 and text[pos - 1] == "\"":
                continue
            referenced.add(match.group(0))

        missing = sorted(name for name in referenced if name not in defined)
        if missing:
            missing_by_module[module_path.name] = missing
            if debug:
                print(
                    f"[stage2-bootstrap][error] {module_path.name} missing definitions for: {', '.join(missing)}")

    if missing_by_module:
        message_lines = ["detected missing string constant definitions:"]
        for module_name, names in sorted(missing_by_module.items()):
            message_lines.append(f"  {module_name}: {', '.join(names)}")
        raise Stage2BootstrapError("\n".join(message_lines))


def _merge_missing_string_constants(primary, fallback) -> None:
    """Ensure `primary` exposes all string constants present in `fallback`."""
    primary_constants = list(getattr(primary, "string_constants", []) or [])
    fallback_constants = getattr(fallback, "string_constants", []) or []
    if not fallback_constants:
        return
    existing = {getattr(const, "name", "") for const in primary_constants}
    appended = False
    for constant in fallback_constants:
        name = getattr(constant, "name", "")
        if not name or name in existing:
            continue
        primary_constants.append(constant)
        existing.add(name)
        appended = True
    if appended:
        setattr(primary, "string_constants", primary_constants)


_STRING_LITERAL_RE = re.compile(r'"(?:\\.|[^"\\])*"')
_STRING_REF_RE = re.compile(r'@\.str[0-9A-Za-z_.]*')
_ENUM_REF_RE = re.compile(r'@\.enum(?:\.[A-Za-z0-9_]+)+')
_LITERAL_CACHE: Dict[pathlib.Path, Dict[str, Any]] = {}
_HELPER_DECLARATIONS: Dict[str, str] | None = None
_HELPER_REF_RE = re.compile(r'@(sailfin_(?:runtime|adapter)_[A-Za-z0-9_]+)')


def _helper_declarations() -> Dict[str, str]:
    global _HELPER_DECLARATIONS
    if _HELPER_DECLARATIONS is None:
        _HELPER_DECLARATIONS = {
            descriptor.symbol: f"declare {descriptor.return_type} @{descriptor.symbol}({', '.join(descriptor.parameter_types)})"
            for descriptor in _stage1_lowering_module().runtime_helper_descriptors()
        }
    return _HELPER_DECLARATIONS


def _string_constants_from_source(source_path: pathlib.Path, source_text: str) -> Dict[str, Any]:
    resolved = source_path.resolve()
    cached = _LITERAL_CACHE.get(resolved)
    if cached is not None:
        return cached
    constants: Dict[str, Any] = {}
    stage1_lowering = _stage1_lowering_module()
    for match in _STRING_LITERAL_RE.finditer(source_text):
        literal = match.group(0)
        content = stage1_lowering.unescape_string_literal(literal)
        name = stage1_lowering.make_string_constant_name(content)
        if name in constants:
            continue
        constants[name] = stage1_lowering.StringConstant(
            name=name, content=content, byte_count=len(content)
        )
    _LITERAL_CACHE[resolved] = constants
    return constants


def _ensure_module_string_constants(source_path: pathlib.Path, source_text: str, lowered) -> None:
    ir_text = getattr(lowered, "ir", "")
    if not ir_text:
        return
    referenced: Set[str] = set(_STRING_REF_RE.findall(ir_text))
    referenced.update(match.group(0)
                      for match in _ENUM_REF_RE.finditer(ir_text))
    if not referenced:
        return
    literal_map = _string_constants_from_source(source_path, source_text)
    existing_constants = list(getattr(lowered, "string_constants", []) or [])
    constant_map = {
        getattr(constant, "name", ""): constant for constant in existing_constants if getattr(constant, "name", "")
    }
    defined_globals = _extract_defined_globals(ir_text)
    updated_constants = list(existing_constants)
    appended = False
    appended_definitions: list[str] = []
    for name in referenced:
        if not name:
            continue
        constant = constant_map.get(name)
        if constant is None:
            constant = literal_map.get(name)
        if constant is None and name.startswith("@.enum."):
            constant = _synthesise_enum_string_constant(name)
        if constant is None:
            continue
        if getattr(constant, "name", "") not in constant_map:
            updated_constants.append(constant)
            constant_map[getattr(constant, "name", "")] = constant
            appended = True
        definition = _render_string_constant_definition(constant)
        if name not in defined_globals and definition:
            appended_definitions.append(definition)
            defined_globals.add(name)

    if appended:
        setattr(lowered, "string_constants", updated_constants)
    if appended_definitions:
        ir_body = ir_text.rstrip() + "\n" + "\n".join(appended_definitions) + "\n"
        setattr(lowered, "ir", ir_body)


def _synthesise_enum_string_constant(name: str):
    raw = name[1:] if name.startswith("@") else name
    parts = [part for part in raw.split(".") if part]
    if len(parts) < 3 or parts[0] != "enum":
        return None
    if parts[-1] == "default":
        content = ""
    elif parts[-1] == "variant" and len(parts) >= 4:
        content = parts[-2]
    else:
        return None
    byte_count = len(content.encode("utf-8"))
    stage1_lowering = _stage1_lowering_module()
    return stage1_lowering.StringConstant(
        name=name,
        content=content,
        byte_count=byte_count,
    )


def _render_string_constant_definition(constant) -> str | None:
    name = getattr(constant, "name", "")
    content = getattr(constant, "content", "")
    if not name:
        return None
    if not name.startswith("@"):
        name = "@" + name
    stage1_lowering = _stage1_lowering_module()
    escaped = stage1_lowering.escape_string_for_llvm(content)
    byte_count = getattr(constant, "byte_count", len(content.encode("utf-8")))
    length = byte_count + 1
    return f"{name} = private unnamed_addr constant [{length} x i8] c\"{escaped}\\00\""


def _extract_defined_globals(ir_text: str) -> Set[str]:
    defined: Set[str] = set()
    for line in ir_text.splitlines():
        stripped = line.strip()
        if not stripped.startswith("@") or " = " not in stripped:
            continue
        name = stripped.split("=", 1)[0].strip()
        defined.add(name)
    return defined


def _ensure_runtime_helper_declarations(lowered) -> None:
    ir_text = getattr(lowered, "ir", "")
    if not ir_text:
        return
    declared_symbols: Set[str] = set()
    new_lines: Optional[List[str]] = None
    for line in ir_text.splitlines():
        stripped = line.strip()
        if stripped.startswith("declare"):
            parts = stripped.split("@", 1)
            if len(parts) == 2:
                symbol = parts[1].split("(", 1)[0]
                declared_symbols.add(symbol)
    referenced: Set[str] = set(match.group(1)
                               for match in _HELPER_REF_RE.finditer(ir_text))
    helper_decls = _helper_declarations()
    missing = [
        symbol for symbol in referenced if symbol in helper_decls and symbol not in declared_symbols]
    if not missing:
        return
    lines = ir_text.splitlines()
    insert_index = 0
    while insert_index < len(lines) and not lines[insert_index].startswith("define "):
        insert_index += 1
    declarations = [helper_decls[symbol] for symbol in missing]
    new_lines = lines[:insert_index] + \
        declarations + [""] + lines[insert_index:]
    setattr(lowered, "ir", "\n".join(new_lines))


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
        "--progress",
        action="store_true",
        help="Print per-module progress and timing (helps diagnose hangs)",
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
        "--verify-strings",
        action="store_true",
        help="Verify that referenced string constants have module-local definitions",
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
    parser.add_argument(
        "--incremental",
        action="store_true",
        default=True,
        help="Enable incremental rebuilds (default: enabled)",
    )
    parser.add_argument(
        "--no-incremental",
        dest="incremental",
        action="store_false",
        help="Disable incremental mode (rebuild everything)",
    )
    parser.add_argument(
        "--force",
        action="store_true",
        help="Force rebuild all modules (still writes manifest)",
    )
    parser.add_argument(
        "--clean",
        action="store_true",
        help="Delete output directory before building",
    )
    return parser.parse_args(argv)


def main(argv: list[str] | None = None) -> int:
    """Main entry point for Stage2 bootstrap script."""
    args = _parse_args(argv)

    try:
        print("[stage2-bootstrap] starting Stage2 self-hosting compilation...")

        if args.clean and args.output.exists():
            shutil.rmtree(args.output)

        # Compile compiler sources to LLVM
        compilation_result = compile_compiler_to_stage2(
            args.output,
            debug=args.debug,
            quiet=args.quiet,
            progress=args.progress,
            incremental=args.incremental,
            force=args.force,
        )
        llvm_modules, aggregator = compilation_result[:2]

        print(
            f"[stage2-bootstrap] compiled {len(llvm_modules)} module(s) to {args.output}")

        # Show diagnostic summary if requested
        if args.summary and aggregator.total_count > 0:
            aggregator.print_summary(verbose=args.debug)

        if args.verify_strings:
            verify_string_constants(llvm_modules, debug=args.debug)

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
