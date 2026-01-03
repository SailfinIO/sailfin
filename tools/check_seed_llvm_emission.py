#!/usr/bin/env python3
"""Detect flaky/malformed LLVM emission from a native stage2 seed compiler.

Goal
----
Provide a tight, binary reproducer for the self-hosting blocker:

- Run the seed compiler to emit LLVM IR for a chosen input module repeatedly.
- Validate the emitted IR is syntactically valid by compiling it with clang.

This is intended to be *fail-fast* and to save artifacts for debugging.

Typical usage
-------------
  python tools/check_seed_llvm_emission.py \
    --seed build/native/sailfin-stage2 \
    --input compiler/src/llvm/lowering/instructions.sfn \
    --attempts 50

Exit codes
----------
0: All attempts succeeded.
1: At least one attempt produced malformed/un-compilable LLVM.
2: Usage / missing tools.
"""

from __future__ import annotations

import argparse
import os
import pathlib
import subprocess
import sys
from dataclasses import dataclass


REPO_ROOT = pathlib.Path(__file__).resolve().parents[1]


def _strip_stage2_log_prefixes(text: str) -> str:
    out_lines: list[str] = []
    for line in text.splitlines():
        if line.startswith("[info] "):
            out_lines.append(line[len("[info] "):])
            continue
        if line.startswith("[warn] "):
            out_lines.append(line[len("[warn] "):])
            continue
        if line.startswith("[error] "):
            out_lines.append(line[len("[error] "):])
            continue
        out_lines.append(line)
    return "\n".join(out_lines) + "\n"


def _looks_like_llvm_module(text: str) -> bool:
    for line in text.splitlines()[:200]:
        if not line.strip():
            continue
        if line[:1].isspace():
            return False
        return line.startswith(
            (
                "source_filename =",
                "; ModuleID =",
                "target ",
                "declare ",
                "define ",
                "%",
                "@",
                ";",
                "!",
                "attributes ",
            )
        )
    return False


def _seed_supports_emit_llvm_file(seed: pathlib.Path) -> bool:
    proc = subprocess.run(
        [str(seed), "emit-llvm-file"],
        cwd=str(REPO_ROOT),
        stdout=subprocess.DEVNULL,
        stderr=subprocess.PIPE,
        text=True,
    )
    stderr = proc.stderr or ""
    if "unknown" in stderr and "emit-llvm-file" in stderr:
        return False
    # If the command exists, stage2 prints usage for missing args.
    if "emit-llvm-file" in stderr or "usage" in stderr:
        return True
    return proc.returncode != 0


@dataclass(frozen=True)
class AttemptResult:
    attempt: int
    ok: bool
    reason: str
    raw_path: pathlib.Path
    cleaned_path: pathlib.Path
    clang_stderr_path: pathlib.Path


def _run_emit(
    *,
    seed: pathlib.Path,
    input_path: pathlib.Path,
    raw_path: pathlib.Path,
    use_emit_llvm_file: bool,
    seed_env: dict[str, str],
    timeout_s: float | None,
) -> tuple[int, str]:
    if use_emit_llvm_file:
        try:
            proc = subprocess.run(
                [str(seed), "emit-llvm-file", str(input_path), str(raw_path)],
                cwd=str(REPO_ROOT),
                stdout=subprocess.DEVNULL,
                stderr=subprocess.PIPE,
                env=seed_env,
                text=True,
                close_fds=False,
                timeout=timeout_s,
            )
            return proc.returncode, proc.stderr or ""
        except subprocess.TimeoutExpired as e:
            return 124, (e.stderr or "")

    with raw_path.open("wb") as out:
        try:
            proc = subprocess.run(
                [str(seed), "emit", "llvm", str(input_path)],
                cwd=str(REPO_ROOT),
                stdout=out,
                stderr=subprocess.PIPE,
                env=seed_env,
                text=True,
                close_fds=False,
                timeout=timeout_s,
            )
            return proc.returncode, proc.stderr or ""
        except subprocess.TimeoutExpired as e:
            return 124, (e.stderr or "")


def _run_clang_compile(
    *,
    clang: str,
    clang_flags: list[str],
    ll_path: pathlib.Path,
    out_obj: pathlib.Path,
    stderr_path: pathlib.Path,
) -> int:
    out_obj.parent.mkdir(parents=True, exist_ok=True)
    cmd = [clang, *clang_flags, "-c", str(ll_path), "-o", str(out_obj)]
    proc = subprocess.run(
        cmd,
        cwd=str(REPO_ROOT),
        stdout=subprocess.DEVNULL,
        stderr=subprocess.PIPE,
        text=True,
    )
    stderr_path.write_text(proc.stderr or "", encoding="utf-8")
    return proc.returncode


def main(argv: list[str]) -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "--seed",
        type=pathlib.Path,
        default=REPO_ROOT / "build/native/sailfin-stage2",
        help="Path to the seed native stage2 binary (default: build/native/sailfin-stage2)",
    )
    parser.add_argument(
        "--input",
        type=pathlib.Path,
        default=REPO_ROOT / "compiler/src/llvm/lowering/instructions.sfn",
        help="Sailfin source to compile to LLVM (default: instructions.sfn canary)",
    )
    parser.add_argument(
        "--attempts",
        type=int,
        default=50,
        help="How many times to attempt LLVM emission (default: 50)",
    )
    parser.add_argument(
        "--timeout",
        type=float,
        default=10.0,
        help="Per-attempt timeout in seconds for the seed compiler (default: 10). Use 0 to disable.",
    )
    parser.add_argument(
        "--out-dir",
        type=pathlib.Path,
        default=REPO_ROOT / "build/seed-llvm-check",
        help="Directory to write artifacts (default: build/seed-llvm-check)",
    )
    parser.add_argument(
        "--stop-on-failure",
        action="store_true",
        default=True,
        help="Stop at the first failure (default: on)",
    )
    parser.add_argument(
        "--keep-going",
        action="store_true",
        help="Keep running after failures (overrides --stop-on-failure)",
    )
    parser.add_argument(
        "--clang",
        default=os.environ.get("CLANG", "clang"),
        help="clang executable (default: $CLANG or clang)",
    )
    parser.add_argument(
        "--clang-flag",
        action="append",
        default=[],
        help="Extra flag to pass to clang (repeatable)",
    )
    parser.add_argument(
        "--no-clang",
        action="store_true",
        default=False,
        help="Skip clang validation (header-only check; fastest iteration)",
    )
    parser.add_argument(
        "--disable-string-free",
        action="store_true",
        default=False,
        help="Set SAILFIN_DISABLE_STRING_FREE=1 for the seed run",
    )
    parser.add_argument(
        "--env",
        action="append",
        default=[],
        help="Extra environment for seed, KEY=VALUE (repeatable)",
    )

    args = parser.parse_args(argv)

    seed = args.seed.resolve()
    input_path = args.input.resolve()
    out_dir = args.out_dir.resolve()

    if not seed.exists() or not os.access(seed, os.X_OK):
        print(f"missing or non-executable seed: {seed}", file=sys.stderr)
        return 2
    if not input_path.exists():
        print(f"missing input: {input_path}", file=sys.stderr)
        return 2

    # Artifact directories.
    raw_dir = out_dir / "raw"
    cleaned_dir = out_dir / "cleaned"
    obj_dir = out_dir / "obj"
    clang_err_dir = out_dir / "clang"
    for d in (raw_dir, cleaned_dir, obj_dir, clang_err_dir):
        d.mkdir(parents=True, exist_ok=True)

    # Prepare env.
    seed_env = os.environ.copy()
    if args.disable_string_free:
        seed_env["SAILFIN_DISABLE_STRING_FREE"] = "1"
    for item in args.env:
        if "=" not in item:
            print(
                f"invalid --env (expected KEY=VALUE): {item}", file=sys.stderr)
            return 2
        k, v = item.split("=", 1)
        seed_env[k] = v

    use_emit_llvm_file = _seed_supports_emit_llvm_file(seed)

    clang_flags = ["-Wno-override-module", *args.clang_flag]

    failures: list[AttemptResult] = []
    passes = 0

    attempts = max(1, int(args.attempts))
    keep_going = bool(args.keep_going)
    timeout_s: float | None = None
    if args.timeout and args.timeout > 0:
        timeout_s = float(args.timeout)

    for attempt in range(1, attempts + 1):
        print(f"[seed-llvm-check] attempt {attempt}/{attempts}", flush=True)
        raw_path = raw_dir / f"attempt{attempt}.ll"
        cleaned_path = cleaned_dir / f"attempt{attempt}.ll"
        clang_stderr_path = clang_err_dir / f"attempt{attempt}.stderr"

        rc, stderr_text = _run_emit(
            seed=seed,
            input_path=input_path,
            raw_path=raw_path,
            use_emit_llvm_file=use_emit_llvm_file,
            seed_env=seed_env,
            timeout_s=timeout_s,
        )

        # Always preserve stderr alongside the attempt so runtime diagnostics are
        # visible even when the seed returns success but emits malformed IR.
        clang_stderr_path.write_text(stderr_text or "", encoding="utf-8")

        if rc != 0:
            failures.append(
                AttemptResult(
                    attempt=attempt,
                    ok=False,
                    reason=f"seed returned rc={rc}; stderr saved",
                    raw_path=raw_path,
                    cleaned_path=cleaned_path,
                    clang_stderr_path=clang_stderr_path,
                )
            )
            if not keep_going:
                break
            continue

        raw_text = raw_path.read_text(encoding="utf-8", errors="replace")
        cleaned_text = raw_text if use_emit_llvm_file else _strip_stage2_log_prefixes(
            raw_text)
        cleaned_path.write_text(cleaned_text, encoding="utf-8")

        if not _looks_like_llvm_module(cleaned_text):
            failures.append(
                AttemptResult(
                    attempt=attempt,
                    ok=False,
                    reason="LLVM does not look like a module header (likely truncated)",
                    raw_path=raw_path,
                    cleaned_path=cleaned_path,
                    clang_stderr_path=clang_stderr_path,
                )
            )
            if not keep_going:
                break
            continue

        if not args.no_clang:
            out_obj = obj_dir / f"attempt{attempt}.o"
            clang_rc = _run_clang_compile(
                clang=args.clang,
                clang_flags=clang_flags,
                ll_path=cleaned_path,
                out_obj=out_obj,
                stderr_path=clang_stderr_path,
            )
            if clang_rc != 0:
                failures.append(
                    AttemptResult(
                        attempt=attempt,
                        ok=False,
                        reason=f"clang failed rc={clang_rc} (see stderr)",
                        raw_path=raw_path,
                        cleaned_path=cleaned_path,
                        clang_stderr_path=clang_stderr_path,
                    )
                )
                if not keep_going:
                    break
                continue

        passes += 1

    print("--- seed LLVM emission check ---")
    print(f"seed:   {seed}")
    print(f"input:  {input_path}")
    print(f"emit:   {'emit-llvm-file' if use_emit_llvm_file else 'emit llvm'}")
    print(f"clang:  {args.clang} {' '.join(clang_flags)}")
    print(f"out:    {out_dir}")
    print(f"runs:   {attempts}")
    print(f"ok:     {passes}")
    print(f"fail:   {len(failures)}")

    if failures:
        first = failures[0]
        print("\nfirst failure:")
        print(f"  attempt: {first.attempt}")
        print(f"  reason:  {first.reason}")
        print(f"  raw:     {first.raw_path}")
        print(f"  cleaned: {first.cleaned_path}")
        print(f"  stderr:  {first.clang_stderr_path}")
        return 1

    return 0


if __name__ == "__main__":
    raise SystemExit(main(sys.argv[1:]))
