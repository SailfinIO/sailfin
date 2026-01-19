"""Native execution helpers that enforce capability manifests at runtime.

This module is the preferred entrypoint for executing LLVM outputs.
"""

from __future__ import annotations

from .stage2_runner import NativeRunner
from .stage2_runner import current_capability_grant

__all__ = ["NativeRunner", "current_capability_grant"]
