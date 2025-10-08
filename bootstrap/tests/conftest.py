"""Test configuration and shared fixtures for the bootstrap compiler.

- Ensures the repository root is importable in tests (so `bootstrap.*` works)
- Adds custom markers for unit/integration/e2e
"""
from __future__ import annotations

import pathlib
import sys

import pytest

REPO_ROOT = pathlib.Path(__file__).resolve().parents[2]
if str(REPO_ROOT) not in sys.path:
    sys.path.insert(0, str(REPO_ROOT))


def pytest_collection_modifyitems(items: list[pytest.Item]) -> None:  # small quality-of-life: auto-mark by filename
    for item in items:
        path = pathlib.Path(item.fspath)
        if path.name.startswith("test_unit_"):
            item.add_marker(pytest.mark.unit)
        elif path.name.startswith("test_integration_"):
            item.add_marker(pytest.mark.integration)
        elif path.name.startswith("test_e2e_"):
            item.add_marker(pytest.mark.e2e)
