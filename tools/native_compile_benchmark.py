#!/usr/bin/env python3
"""Benchmark native compiler compilation time for Sailfin source files.

Runs the already-built self-hosted native compiler binary (default:
`build/native/sailfin`) against a set of `.sfn` files and records wall-clock
time per file.

This is intended to catch regressions where lexing/parsing becomes O(N^2) and
large files start hanging.
"""

from __future__ import annotations

import argparse
import pathlib
import subprocess
import sys
import time
from dataclasses import dataclass


@dataclass(frozen=True)
class Result:
    path: pathlib.Path
    seconds: float
    returncode: int
    timed_out: bool


def run_one(compiler: pathlib.Path, path: pathlib.Path, timeout_s: float, emit: str) -> Result:
    start = time.monotonic()
    try:
        proc = subprocess.run(
            # Match the CLI shape used by scripts/selfhost_native.py.
            # (Older invocations used a --emit flag; the subcommand is the
            # stable interface and tends to give clearer failures.)
            [str(compiler), "emit", emit, str(path)],
            stdout=subprocess.DEVNULL,
            stderr=subprocess.PIPE,
            text=True,
            timeout=timeout_s,
            check=False,
        )
    except subprocess.TimeoutExpired:
        end = time.monotonic()
        return Result(path=path, seconds=end - start, returncode=124, timed_out=True)

    end = time.monotonic()
    return Result(path=path, seconds=end - start, returncode=proc.returncode, timed_out=False)


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "--compiler",
        dest="compiler",
        default="build/native/sailfin",
        help="Path to the native compiler binary (default: build/native/sailfin)",
    )
    parser.add_argument(
        "--emit",
        choices=["sailfin", "llvm"],
        default="sailfin",
        help="Emit mode to compile with (default: sailfin)",
    )
    parser.add_argument(
        "--timeout",
        type=float,
        default=30.0,
        help="Per-file timeout in seconds (default: 30)",
    )
    parser.add_argument(
        "--glob",
        action="append",
        default=["compiler/src/**/*.sfn"],
        help="Glob of input files (repeatable, default: compiler/src/**/*.sfn)",
    )
    parser.add_argument(
        "--top",
        type=int,
        default=10,
        help="How many slowest files to print (default: 10)",
    )
    parser.add_argument(
        "--max-failures",
        type=int,
        default=1,
        help="Stop after this many failures/timeouts (default: 1)",
    )
    parser.add_argument(
        "--fail-fast",
        action="store_true",
        help="Alias for --max-failures=1",
    )
    args = parser.parse_args()

    if args.fail_fast:
        args.max_failures = 1

    repo_root = pathlib.Path(__file__).resolve().parents[1]
    compiler = (repo_root / args.compiler).resolve()
    if not compiler.exists():
        print(f"missing native compiler binary: {compiler}", file=sys.stderr)
        print("Run `make compile` first.", file=sys.stderr)
        return 2

    matched: set[pathlib.Path] = set()
    for pattern in args.glob:
        matched.update(repo_root.glob(pattern))

    files = sorted(p for p in matched if p.is_file())
    if not files:
        patterns = ", ".join(args.glob)
        print(f"no files matched: {patterns}", file=sys.stderr)
        return 2

    results: list[Result] = []
    failures_seen = 0
    total_start = time.monotonic()
    for path in files:
        res = run_one(compiler, path, timeout_s=args.timeout, emit=args.emit)
        results.append(res)
        if res.timed_out:
            print(f"TIMEOUT  {res.seconds:8.3f}s  {path}")
            failures_seen += 1
        elif res.returncode != 0:
            print(
                f"FAIL     {res.seconds:8.3f}s  {path}  (rc={res.returncode})")
            failures_seen += 1
        else:
            print(f"OK       {res.seconds:8.3f}s  {path}")

        if args.max_failures is not None and args.max_failures > 0 and failures_seen >= args.max_failures:
            print(
                f"\n[benchmark] stopping early after {failures_seen} failure(s)")
            break

    total_end = time.monotonic()

    failures = [r for r in results if r.timed_out or r.returncode != 0]
    ok = [r for r in results if (not r.timed_out and r.returncode == 0)]
    slowest = sorted(ok, key=lambda r: r.seconds, reverse=True)[
        : max(1, args.top)]

    print("\n--- summary ---")
    print(f"files: {len(results)} (ok={len(ok)} fail={len(failures)})")
    print(f"total: {total_end - total_start:.3f}s")
    if ok:
        avg = sum(r.seconds for r in ok) / len(ok)
        print(f"avg:   {avg:.3f}s")
    print("\nslowest:")
    for r in slowest:
        print(f"  {r.seconds:8.3f}s  {r.path}")

    return 1 if failures else 0


if __name__ == "__main__":
    raise SystemExit(main())
