#!/usr/bin/env python3
"""Lint: refuse `export { X };` (no `from` clause) where X is imported
from a local module path (./X or ../X) and has no local definition.

This is the textual equivalent of the Sailfin emitter's Option-B check
in compiler/src/emit_native.sfn:collect_reexport_violations.  Running
it here gives PR authors immediate feedback without waiting for the
~13-minute self-host build to surface the same diagnostic.

Usage: scripts/lint_no_implicit_reexports.py <root> [<root> ...]

Exits 0 if no violations.  Exits 1 with one line per violation otherwise.

Symbols imported from non-local paths (e.g. "runtime/prelude" or
"sfn/cli") are exempt — runtime helpers are resolved via the runtime
helper descriptor table in compiler/src/llvm/runtime_helpers.sfn rather
than the re-exporter's .sfn-asm, so they do not trigger the bug.

See docs/rca/2026-04-18-reexport-diagnostic-gep.md for the underlying
miscompile.
"""
from __future__ import annotations

import os
import re
import sys

IMPORT_RE = re.compile(
    r"^\s*import\s*\{([^}]*)\}\s*from\s*\"([^\"]+)\"",
    re.MULTILINE,
)
EXPORT_RE = re.compile(
    r"^\s*export\s*\{([^}]*)\}\s*;",
    re.MULTILINE | re.DOTALL,
)
LOCAL_DECL_RE = re.compile(
    r"^\s*(?:async\s+)?(?:unsafe\s+)?(?:extern\s+)?"
    r"(?:fn|struct|enum|interface|type|model|pipeline|tool)\s+"
    r"([A-Za-z_][A-Za-z0-9_]*)",
    re.MULTILINE,
)


def parse_specifier_list(text: str) -> list[tuple[str, str | None]]:
    """Return list of (name, alias-or-None) tuples from `{a, b as c, d}`."""
    out: list[tuple[str, str | None]] = []
    for raw in text.split(","):
        item = raw.strip()
        if not item:
            continue
        if " as " in item:
            name, _, alias = item.partition(" as ")
            out.append((name.strip(), alias.strip()))
        else:
            out.append((item, None))
    return out


def is_local_module_path(path: str) -> bool:
    return path.startswith("./") or path.startswith("../")


def lint_file(path: str) -> list[str]:
    """Return human-readable violation messages for `path` (empty if clean)."""
    try:
        with open(path, encoding="utf-8") as fh:
            text = fh.read()
    except (OSError, UnicodeDecodeError):
        return []

    # Build the table of imported names → source path (using the
    # locally-visible name, i.e. alias when present).
    imports: dict[str, str] = {}
    for match in IMPORT_RE.finditer(text):
        source = match.group(2)
        for name, alias in parse_specifier_list(match.group(1)):
            local = alias if alias else name
            imports[local] = source

    # Collect locally defined names.
    locals_set: set[str] = {m.group(1) for m in LOCAL_DECL_RE.finditer(text)}

    # Scan implicit `export { ... };` (no `from`) blocks.  EXPORT_RE
    # requires a trailing `;` immediately after `}`, so the inline form
    # `export { ... } from "..."` is automatically excluded.
    violations: list[str] = []
    for match in EXPORT_RE.finditer(text):
        for name, _alias in parse_specifier_list(match.group(1)):
            if name in locals_set:
                continue
            origin = imports.get(name)
            if origin is None:
                continue
            if not is_local_module_path(origin):
                continue
            violations.append(
                f'{path}: `export {{ {name} }};` re-exports a symbol '
                f'imported from "{origin}" but there is no local '
                f'`fn {name}` definition. Sailfin does not support '
                f'implicit re-exports of imported symbols. '
                f'Fix: remove `{name}` from this module\'s export '
                f'block and import it directly from "{origin}", or '
                f'add a local `fn {name}(...)` forwarder.'
            )
    return violations


def main(argv: list[str]) -> int:
    if len(argv) < 2:
        print(f"usage: {argv[0]} <root> [<root> ...]", file=sys.stderr)
        return 2

    paths: list[str] = []
    for root in argv[1:]:
        if os.path.isfile(root) and root.endswith(".sfn"):
            paths.append(root)
            continue
        for dirpath, _dirs, files in os.walk(root):
            for name in files:
                if name.endswith(".sfn"):
                    paths.append(os.path.join(dirpath, name))

    paths.sort()

    all_violations: list[str] = []
    for path in paths:
        all_violations.extend(lint_file(path))

    if all_violations:
        for line in all_violations:
            print(line)
        print(
            f"\n[lint] {len(all_violations)} implicit re-export violation(s) "
            f"across {len(paths)} file(s).",
            file=sys.stderr,
        )
        print(
            "[lint] See docs/rca/2026-04-18-reexport-diagnostic-gep.md.",
            file=sys.stderr,
        )
        return 1
    print(f"[lint] {len(paths)} file(s) scanned; no implicit re-export violations.")
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv))
