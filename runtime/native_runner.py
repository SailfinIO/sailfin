"""Native execution helpers that enforce capability manifests at runtime.

This module is the preferred entrypoint for executing LLVM outputs.

Compatibility note: the current implementation still lives in
`runtime.stage2_runner` for historical reasons. During the 1.0 cleanup we will
fully rename/remove the legacy module.
"""

from __future__ import annotations

from .stage2_runner import Stage2Runner as NativeRunner
from .stage2_runner import current_capability_grant

__all__ = ["NativeRunner", "current_capability_grant"]
