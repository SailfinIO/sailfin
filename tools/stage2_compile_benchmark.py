#!/usr/bin/env python3
"""Benchmark Stage2 compilation time for Sailfin source files.

Runs the already-built `build/native/sailfin-stage2` binary against a set of
`.sfn` files and records wall-clock time per file.

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


def run_one(stage2: pathlib.Path, path: pathlib.Path, timeout_s: float, emit: str) -> Result:
    start = time.monotonic()
    try:
        proc = subprocess.run(
            [str(stage2), "--emit", emit, str(path)],
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
        "--stage2",
        default="build/native/sailfin-stage2",
        help="Path to stage2 binary (default: build/native/sailfin-stage2)",
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
        default="compiler/src/*.sfn",
        help="Glob of input files (default: compiler/src/*.sfn)",
    )
    parser.add_argument(
        "--top",
        type=int,
        default=10,
        help="How many slowest files to print (default: 10)",
    )
    args = parser.parse_args()

    repo_root = pathlib.Path(__file__).resolve().parents[1]
    stage2 = (repo_root / args.stage2).resolve()
    if not stage2.exists():
        print(f"missing stage2 binary: {stage2}", file=sys.stderr)
        print("Run `make compile` first.", file=sys.stderr)
        return 2

    files = sorted(repo_root.glob(args.glob))
    if not files:
        print(f"no files matched: {args.glob}", file=sys.stderr)
        return 2

    results: list[Result] = []
    total_start = time.monotonic()
    for path in files:
        res = run_one(stage2, path, timeout_s=args.timeout, emit=args.emit)
        results.append(res)
        if res.timed_out:
            print(f"TIMEOUT  {res.seconds:8.3f}s  {path}")
        elif res.returncode != 0:
            print(
                f"FAIL     {res.seconds:8.3f}s  {path}  (rc={res.returncode})")
        else:
            print(f"OK       {res.seconds:8.3f}s  {path}")

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
