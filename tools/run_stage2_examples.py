"""Run Sailfin Stage2 native compiler against examples.

This script is intended to help uncover Stage2 gaps by compiling + running
`examples/**/*.sfn` with the self-hosted native CLI.

Pipeline per file:
  1) stage2: `--emit llvm <example.sfn>`
  2) clang: link runtime + emitted `.ll` into a native binary
  3) execute the binary

Outputs:
  - LLVM IR: scratch/native-examples/<relative>.ll
  - Binary:  build/native/examples/<relative>
  - Logs:   scratch/native-examples/logs/<relative>.(emit|clang|run).log

The script is intentionally simple; it is not a replacement for pytest.
"""

from __future__ import annotations

import argparse
import os
import re
import shlex
import subprocess
import sys
from dataclasses import dataclass
from pathlib import Path


_REPO_ROOT = Path(__file__).resolve().parents[1]
_DEFAULT_COMPILER = _REPO_ROOT / "build" / "native" / "sailfin-stage2"


@dataclass(frozen=True)
class StepResult:
    name: str
    ok: bool
    returncode: int
    log_path: Path


def _ensure_parent(path: Path) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)


def _run_step(*, name: str, argv: list[str], cwd: Path, log_path: Path) -> StepResult:
    _ensure_parent(log_path)
    with log_path.open("w", encoding="utf-8") as stream:
        stream.write(f"$ {shlex.join(argv)}\n")
        stream.write("\n")
        proc = subprocess.run(
            argv,
            cwd=str(cwd),
            stdout=stream,
            stderr=subprocess.STDOUT,
            text=True,
            env=os.environ.copy(),
        )
    return StepResult(name=name, ok=proc.returncode == 0, returncode=proc.returncode, log_path=log_path)


def _iter_examples(examples_root: Path, *, pattern: str) -> list[Path]:
    # `rglob` does not support full glob sets like **/*.sfn? it does, but only as a pattern.
    candidates = sorted(examples_root.rglob(pattern))
    return [path for path in candidates if path.is_file() and path.suffix == ".sfn"]


def _rel_from(root: Path, path: Path) -> Path:
    try:
        return path.relative_to(root)
    except ValueError:
        return path.name


_MAIN_DECL_RE = re.compile(r"^\s*(fn|pipeline)\s+main\b", re.MULTILINE)


def _has_entrypoint(source_path: Path) -> bool:
    try:
        text = source_path.read_text(encoding="utf-8")
    except OSError:
        return False
    return _MAIN_DECL_RE.search(text) is not None


def _extract_llvm_ir(stdout: str, stderr: str) -> str:
    """Return LLVM IR text from compiler output.

    Stage2 is expected to print IR to stdout, but some debug/warn paths may
    interleave output on stderr. We accept either and slice from the module
    header.
    """

    for stream in (stdout, stderr):
        if not stream:
            continue
        marker = "; ModuleID"
        idx = stream.find(marker)
        if idx >= 0:
            return stream[idx:]
    # Fallback: prefer stdout if present, else stderr.
    return stdout if stdout else stderr


def _log_has_stage2_warnings(log_path: Path) -> bool:
    try:
        text = log_path.read_text(encoding="utf-8", errors="replace")
    except OSError:
        return False
    return "[warn]" in text


def _main(argv: list[str]) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "--compiler",
        type=Path,
        default=_DEFAULT_COMPILER,
        help="Path to native Stage2 CLI (default: build/native/sailfin-stage2)",
    )
    parser.add_argument(
        "--clang",
        type=str,
        default="clang",
        help="Clang executable to use for linking (default: clang)",
    )
    parser.add_argument(
        "--pattern",
        type=str,
        default="*.sfn",
        help="Filename glob pattern to match under examples/ (default: *.sfn)",
    )
    parser.add_argument(
        "--limit",
        type=int,
        default=0,
        help="Limit number of files (0 = no limit)",
    )
    parser.add_argument(
        "--stop-on-fail",
        action="store_true",
        help="Stop after the first failing example",
    )
    parser.add_argument(
        "--no-run",
        action="store_true",
        help="Only emit + link; do not execute the produced binaries",
    )
    parser.add_argument(
        "--allow-warnings",
        action="store_true",
        help="Do not treat Stage2 '[warn]' diagnostics as failures",
    )

    args = parser.parse_args(argv)

    examples_root = _REPO_ROOT / "examples"
    scratch_root = _REPO_ROOT / "scratch" / "native-examples"
    logs_root = scratch_root / "logs"
    binaries_root = _REPO_ROOT / "build" / "native" / "examples"

    if not examples_root.exists():
        print(
            f"error: examples/ not found at {examples_root}", file=sys.stderr)
        return 2

    compiler = args.compiler
    if not compiler.exists():
        print(
            "error: stage2 compiler not found. Build it with `make native-stage2`\n"
            f"  expected: {compiler}",
            file=sys.stderr,
        )
        return 2

    runtime_c = _REPO_ROOT / "runtime" / "native" / "src" / "sailfin_runtime.c"
    runtime_globals_ll = _REPO_ROOT / "runtime" / \
        "native" / "ir" / "runtime_globals.ll"
    runtime_include = _REPO_ROOT / "runtime" / "native" / "include"

    if not runtime_c.exists() or not runtime_globals_ll.exists() or not runtime_include.exists():
        print("error: runtime native sources not found; repo layout unexpected", file=sys.stderr)
        return 2

    examples = _iter_examples(examples_root, pattern=args.pattern)
    if args.limit and args.limit > 0:
        examples = examples[: args.limit]

    if not examples:
        print(
            f"No examples matched pattern={args.pattern!r} under {examples_root}")
        return 0

    total = len(examples)
    failures: list[tuple[Path, str, Path]] = []

    print(f"[stage2] compiler: {compiler}")
    print(f"[stage2] examples: {total}")

    for idx, example in enumerate(examples, start=1):
        rel = _rel_from(examples_root, example)
        rel_stem = rel.with_suffix("")

        runnable = _has_entrypoint(example)

        out_ll = scratch_root / rel_stem.with_suffix(".ll")
        out_bin = binaries_root / rel_stem

        emit_log = logs_root / rel_stem.with_suffix(".emit.log")
        clang_log = logs_root / rel_stem.with_suffix(".clang.log")
        run_log = logs_root / rel_stem.with_suffix(".run.log")

        _ensure_parent(out_ll)
        _ensure_parent(out_bin)

        print(f"[{idx:>4}/{total}] {rel}")

        emit_result = _run_step(
            name="emit",
            argv=[str(compiler), "--emit", "llvm", str(example)],
            cwd=_REPO_ROOT,
            log_path=emit_log,
        )
        if emit_result.ok:
            # Stage2 writes LLVM to stdout; capture already went to log, so re-run piping to file.
            # This keeps logs readable while storing the IR in a stable path.
            proc = subprocess.run(
                [str(compiler), "--emit", "llvm", str(example)],
                cwd=str(_REPO_ROOT),
                stdout=subprocess.PIPE,
                stderr=subprocess.PIPE,
                text=True,
                env=os.environ.copy(),
            )
            if proc.returncode != 0:
                with emit_log.open("a", encoding="utf-8") as stream:
                    stream.write("\n[rerun-to-file] failed\n")
                    stream.write(proc.stdout)
                    stream.write(proc.stderr)
                failures.append((rel, "emit", emit_log))
                if args.stop_on_fail:
                    break
                continue
            llvm_ir = _extract_llvm_ir(proc.stdout, proc.stderr)
            out_ll.write_text(llvm_ir, encoding="utf-8")
        else:
            failures.append((rel, "emit", emit_result.log_path))
            if args.stop_on_fail:
                break
            continue

        if not args.allow_warnings and _log_has_stage2_warnings(emit_log):
            failures.append((rel, "emit-warn", emit_log))
            if args.stop_on_fail:
                break
            continue

        if not runnable or args.no_run:
            # Many examples are definition-only and not intended to link/run.
            continue

        clang_argv = [
            args.clang,
            "-O2",
            "-Wno-override-module",
            "-I",
            str(runtime_include),
            str(runtime_c),
            str(runtime_globals_ll),
            str(out_ll),
            "-o",
            str(out_bin),
        ]
        clang_result = _run_step(
            name="clang", argv=clang_argv, cwd=_REPO_ROOT, log_path=clang_log)
        if not clang_result.ok:
            failures.append((rel, "clang", clang_result.log_path))
            if args.stop_on_fail:
                break
            continue

        run_result = _run_step(name="run", argv=[str(
            out_bin)], cwd=_REPO_ROOT, log_path=run_log)
        if not run_result.ok:
            failures.append((rel, "run", run_result.log_path))
            if args.stop_on_fail:
                break
            continue

        if not args.allow_warnings and _log_has_stage2_warnings(run_log):
            failures.append((rel, "run-warn", run_log))
            if args.stop_on_fail:
                break
            continue

    print("\nSummary")
    print(f"  ok:   {total - len(failures)}/{total}")
    print(f"  fail: {len(failures)}/{total}")

    if failures:
        print("\nFailures")
        for rel, step, log_path in failures[:50]:
            print(
                f"  - {rel}  [{step}]  log: {log_path.relative_to(_REPO_ROOT)}")
        if len(failures) > 50:
            print(f"  ... and {len(failures) - 50} more")
        return 1

    return 0


if __name__ == "__main__":
    raise SystemExit(_main(sys.argv[1:]))
