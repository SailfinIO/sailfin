"""Runtime helpers used by the Sailfin native compiler."""

__version__ = "0.1.1-alpha.123"

from .runtime_support import *  # noqa: F401,F403
from . import runtime_support as _runtime_support

__all__ = ["__version__"] + getattr(_runtime_support, "__all__", [])

del _runtime_support
