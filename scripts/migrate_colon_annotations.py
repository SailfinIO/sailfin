#!/usr/bin/env python3
"""
Migrate Sailfin type annotations from -> to : syntax.

Replaces -> with : in three annotation contexts:
  1. Function parameters:  fn foo(x -> Type)     => fn foo(x: Type)
  2. Variable declarations: let [mut] x -> Type   => let [mut] x: Type
  3. Struct/enum fields:    field -> Type;         => field: Type;

Preserves -> in:
  - Function return types:  fn foo() -> Type
  - String literals:        "contains -> arrow"
  - Comments:               // has -> arrow

Usage:
  python3 scripts/migrate_colon_annotations.py [--dry-run] [paths...]

  --dry-run   Show what would change without modifying files
  paths       Files or directories to process (default: compiler/ examples/ runtime/)

Examples:
  python3 scripts/migrate_colon_annotations.py --dry-run compiler/src/main.sfn
  python3 scripts/migrate_colon_annotations.py compiler/src/
  python3 scripts/migrate_colon_annotations.py
"""

import argparse
import os
import re
import sys
from pathlib import Path


# ---------------------------------------------------------------------------
# Core transformation
# ---------------------------------------------------------------------------

def migrate_line(line: str) -> str:
    """Replace annotation -> with : on a single line, preserving return type ->."""

    # Fast path: no arrow at all
    if "->" not in line:
        return line

    # Strip trailing newline for processing, re-add later
    trailing = ""
    if line.endswith("\n"):
        trailing = "\n"
        line = line[:-1]

    # Find the comment start (outside of strings) so we don't touch comments
    comment_start = _find_comment_start(line)

    # Find all string literal regions so we don't touch them
    string_regions = _find_string_regions(line, comment_start)

    # Find all -> positions (the index of '-' in '->')
    arrow_positions = _find_arrow_positions(line, comment_start, string_regions)

    if not arrow_positions:
        return line + trailing

    # Classify each arrow as "return type" or "annotation"
    # Return type arrows are preceded (ignoring whitespace) by:
    #   - )              e.g., fn foo() -> Type
    #   - ]              e.g., ![io] -> Type  (effect annotations)
    #   - a word char    e.g., ...rare but possible in edge cases
    # The key insight: return type -> follows ) or ] at the end of a
    # parameter list or effect annotation. Annotation -> follows an
    # identifier name.
    #
    # More precisely: an arrow is a RETURN TYPE arrow if the non-whitespace
    # character immediately before it is ')' or ']'.
    # Everything else is an annotation arrow.

    replacements = []  # list of (start, end) pairs to replace with ": "

    for pos in arrow_positions:
        if _is_return_type_arrow(line, pos):
            continue  # keep as ->
        replacements.append(pos)

    if not replacements:
        return line + trailing

    # Apply replacements right-to-left so positions stay valid
    result = line
    for pos in reversed(replacements):
        # Replace "identifier -> " pattern with "identifier: "
        # We want to preserve spacing. The pattern is: <whitespace?> -> <whitespace?>
        # Find the extent of whitespace before and after the arrow
        pre_ws_end = pos
        pre_ws_start = pos
        while pre_ws_start > 0 and result[pre_ws_start - 1] == ' ':
            pre_ws_start -= 1

        arrow_end = pos + 2  # past the '>'
        post_ws_end = arrow_end
        while post_ws_end < len(result) and result[post_ws_end] == ' ':
            post_ws_end += 1

        # Replace "  ->  " with ": " (colon immediately after identifier, one space before type)
        result = result[:pre_ws_start] + ": " + result[post_ws_end:]

    return result + trailing


def _find_comment_start(line: str) -> int:
    """Find the index where a line comment (//) starts, respecting strings."""
    in_string = False
    escape = False
    i = 0
    while i < len(line):
        ch = line[i]
        if escape:
            escape = False
            i += 1
            continue
        if ch == '\\' and in_string:
            escape = True
            i += 1
            continue
        if ch == '"':
            in_string = not in_string
        elif not in_string and ch == '/' and i + 1 < len(line) and line[i + 1] == '/':
            return i
        i += 1
    return len(line)


def _find_string_regions(line: str, comment_start: int) -> list:
    """Return list of (start, end) index pairs for string literal regions."""
    regions = []
    in_string = False
    escape = False
    start = 0
    i = 0
    while i < comment_start:
        ch = line[i]
        if escape:
            escape = False
            i += 1
            continue
        if ch == '\\' and in_string:
            escape = True
            i += 1
            continue
        if ch == '"':
            if in_string:
                regions.append((start, i + 1))
                in_string = False
            else:
                in_string = True
                start = i
        i += 1
    return regions


def _find_arrow_positions(line: str, comment_start: int, string_regions: list) -> list:
    """Find all '->' positions in code (not in strings or comments)."""
    positions = []
    i = 0
    while i < comment_start - 1:
        if line[i] == '-' and line[i + 1] == '>':
            # Check not inside a string
            in_string = False
            for start, end in string_regions:
                if start <= i < end:
                    in_string = True
                    break
            if not in_string:
                positions.append(i)
            i += 2
        else:
            i += 1
    return positions


def _is_return_type_arrow(line: str, arrow_pos: int) -> bool:
    """Determine if the -> at arrow_pos is a return type (vs annotation).

    A return type -> is preceded by ) or ] (after stripping whitespace).
    These correspond to:
      fn foo(params) -> ReturnType
      fn foo(params) ![effects] -> ReturnType
    """
    i = arrow_pos - 1
    while i >= 0 and line[i] == ' ':
        i -= 1
    if i < 0:
        return False
    return line[i] in (')', ']')


# ---------------------------------------------------------------------------
# File processing
# ---------------------------------------------------------------------------

def process_file(filepath: Path, dry_run: bool) -> dict:
    """Process a single .sfn file. Returns stats dict."""
    stats = {"file": str(filepath), "lines_changed": 0, "arrows_replaced": 0}

    try:
        original = filepath.read_text(encoding="utf-8")
    except (OSError, UnicodeDecodeError) as e:
        stats["error"] = str(e)
        return stats

    lines = original.splitlines(keepends=True)
    new_lines = []
    for line in lines:
        new_line = migrate_line(line)
        if new_line != line:
            stats["lines_changed"] += 1
            # Count how many arrows were replaced on this line
            old_count = line.count("->")
            new_count = new_line.count("->")
            stats["arrows_replaced"] += old_count - new_count
        new_lines.append(new_line)

    new_content = "".join(new_lines)

    if new_content != original:
        if not dry_run:
            filepath.write_text(new_content, encoding="utf-8")
    else:
        stats["unchanged"] = True

    return stats


def collect_sfn_files(paths: list) -> list:
    """Collect all .sfn files from the given paths."""
    files = []
    for p in paths:
        path = Path(p)
        if path.is_file() and path.suffix == ".sfn":
            files.append(path)
        elif path.is_dir():
            files.extend(sorted(path.rglob("*.sfn")))
        else:
            print(f"Warning: skipping {p} (not a .sfn file or directory)", file=sys.stderr)
    return files


# ---------------------------------------------------------------------------
# Self-test
# ---------------------------------------------------------------------------

def run_self_test():
    """Run built-in test cases to validate the migration logic."""
    tests = [
        # (input, expected_output, description)
        (
            'fn add(x -> number, y -> number) -> number {',
            'fn add(x: number, y: number) -> number {',
            "basic function params + return type"
        ),
        (
            '    let result -> number = x + y;',
            '    let result: number = x + y;',
            "let binding"
        ),
        (
            '    let mut counter -> number = 0;',
            '    let mut counter: number = 0;',
            "let mut binding"
        ),
        (
            '    name -> string;',
            '    name: string;',
            "struct field"
        ),
        (
            '    elements -> Expression[];',
            '    elements: Expression[];',
            "struct field with array type"
        ),
        (
            '    return_type -> TypeAnnotation?;',
            '    return_type: TypeAnnotation?;',
            "struct field with nullable type"
        ),
        (
            'fn compile(source -> string) -> string ![io] {',
            'fn compile(source: string) -> string ![io] {',
            "function with effect annotation"
        ),
        (
            'fn foo() -> string ![io] {',
            'fn foo() -> string ![io] {',
            "no-param function (nothing to change)"
        ),
        (
            'fn bar() ![io] -> string {',
            'fn bar() ![io] -> string {',
            "effect before return type"
        ),
        (
            '    let sep = "->";',
            '    let sep = "->";',
            "arrow inside string literal"
        ),
        (
            '    // comment with -> arrow',
            '    // comment with -> arrow',
            "arrow inside comment"
        ),
        (
            '    let x -> string = "has -> inside";',
            '    let x: string = "has -> inside";',
            "annotation + arrow in string"
        ),
        (
            'fn f(a -> number) -> number {  // returns -> number',
            'fn f(a: number) -> number {  // returns -> number',
            "param + return + comment arrow"
        ),
        (
            '    Call { callee -> Expression, arguments -> Expression[] },',
            '    Call { callee: Expression, arguments: Expression[] },',
            "enum variant fields"
        ),
        (
            '    Binary { operator -> string, left -> Expression, right -> Expression },',
            '    Binary { operator: string, left: Expression, right: Expression },',
            "enum variant with three fields"
        ),
        (
            'fn foo(a -> string, b -> number, c -> boolean) -> Result {',
            'fn foo(a: string, b: number, c: boolean) -> Result {',
            "three params + return type"
        ),
        (
            '    let mut _if394 -> boolean = false;',
            '    let mut _if394: boolean = false;',
            "underscore-prefixed variable"
        ),
        (
            '    return " -> " + annotation.text;',
            '    return " -> " + annotation.text;',
            "arrow in string with spaces"
        ),
        (
            'fn expression_tokens_consume_type_separator(state -> ExpressionTokens, accept_colon -> boolean, accept_arrow -> boolean) -> ExpressionTypeSeparatorParseResult {',
            'fn expression_tokens_consume_type_separator(state: ExpressionTokens, accept_colon: boolean, accept_arrow: boolean) -> ExpressionTypeSeparatorParseResult {',
            "long signature with multiple params"
        ),
        (
            '    Lambda { parameters -> Parameter[], body -> Block, return_type -> TypeAnnotation? },',
            '    Lambda { parameters: Parameter[], body: Block, return_type: TypeAnnotation? },',
            "enum variant with nullable field"
        ),
        (
            '    found -> boolean;',
            '    found: boolean;',
            "simple struct field"
        ),
        (
            '    parser -> Parser;',
            '    parser: Parser;',
            "struct field with type name"
        ),
        (
            '',
            '',
            "empty line"
        ),
        (
            'import { parse_program } from "../../src/parser/mod";',
            'import { parse_program } from "../../src/parser/mod";',
            "import statement (no arrows)"
        ),
        (
            'fn compile_tests_to_llvm_file_with_module(source -> string, module_name -> string, out_path -> string) -> boolean ![io] {',
            'fn compile_tests_to_llvm_file_with_module(source: string, module_name: string, out_path: string) -> boolean ![io] {',
            "three params + return type + effect"
        ),
    ]

    passed = 0
    failed = 0
    for input_line, expected, description in tests:
        actual = migrate_line(input_line)
        if actual == expected:
            passed += 1
        else:
            failed += 1
            print(f"FAIL: {description}")
            print(f"  Input:    {input_line!r}")
            print(f"  Expected: {expected!r}")
            print(f"  Actual:   {actual!r}")
            print()

    total = passed + failed
    if failed == 0:
        print(f"All {total} tests passed.")
    else:
        print(f"{failed}/{total} tests FAILED.")
    return failed == 0


# ---------------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------------

def main():
    parser = argparse.ArgumentParser(
        description="Migrate Sailfin type annotations from -> to : syntax."
    )
    parser.add_argument(
        "--dry-run",
        action="store_true",
        help="Show what would change without modifying files",
    )
    parser.add_argument(
        "--self-test",
        action="store_true",
        help="Run built-in test cases and exit",
    )
    parser.add_argument(
        "paths",
        nargs="*",
        help="Files or directories to process (default: compiler/ examples/ runtime/)",
    )
    args = parser.parse_args()

    if args.self_test:
        success = run_self_test()
        sys.exit(0 if success else 1)

    paths = args.paths or ["compiler/", "examples/", "runtime/"]
    files = collect_sfn_files(paths)

    if not files:
        print("No .sfn files found.", file=sys.stderr)
        sys.exit(1)

    total_files = 0
    total_changed = 0
    total_arrows = 0
    total_lines = 0

    for filepath in files:
        stats = process_file(filepath, args.dry_run)

        if "error" in stats:
            print(f"  ERROR: {stats['file']}: {stats['error']}", file=sys.stderr)
            continue

        if stats.get("unchanged"):
            continue

        total_files += 1
        total_changed += 1 if stats["lines_changed"] > 0 else 0
        total_arrows += stats["arrows_replaced"]
        total_lines += stats["lines_changed"]

        if args.dry_run or stats["lines_changed"] > 0:
            action = "would change" if args.dry_run else "changed"
            print(f"  {action}: {stats['file']} ({stats['lines_changed']} lines, {stats['arrows_replaced']} arrows)")

    print()
    action = "Would change" if args.dry_run else "Changed"
    print(f"{action} {total_arrows} annotations across {total_lines} lines in {total_changed} files")
    print(f"Total .sfn files scanned: {len(files)}")


if __name__ == "__main__":
    main()
