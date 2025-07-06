"""
Module loader for Sailfin files.
Handles loading and compiling local .sfn modules and built-in modules.
"""

import os
import sys
from pathlib import Path
from typing import Dict, Set, Optional, Tuple
import importlib.util
import tempfile

from lexer import lexer
from parser import parser
from validator import ASTValidator
from code_generator import PythonCodeGenerator
from ast_nodes import ImportModuleStatement, ImportStatement


class ModuleLoader:
    """Handles loading and compilation of Sailfin modules."""

    def __init__(self, base_path: str = "."):
        self.base_path = Path(base_path).resolve()
        # module_key -> (module_name, temp_file)
        self.loaded_modules: Dict[str, Tuple[str, str]] = {}
        self.loading_modules: Set[str] = set()  # Prevent circular imports
        self.temp_files: Set[str] = set()  # Track temp files for cleanup

        # Initialize compiler components
        self.lexer = lexer
        self.parser = parser
        self.validator = ASTValidator()

    def resolve_module_path(self, source: str, current_file: Optional[str] = None) -> Path:
        """Resolve a module path to an absolute path."""
        if source.startswith('sailfin/'):
            # Built-in module - return as-is for built-in handling
            return Path(source)

        if current_file:
            current_dir = Path(current_file).parent
        else:
            current_dir = self.base_path

        if source.startswith('./') or source.startswith('../'):
            # Explicit relative import
            module_path = current_dir / source
        elif current_file and not source.startswith('/'):
            # Implicit relative import (when we have a current file context)
            module_path = current_dir / source
        else:
            # Absolute import from base path
            module_path = self.base_path / source

        return module_path.resolve()

    def load_sailfin_module(self, source: str, alias: str, current_file: Optional[str] = None) -> str:
        """Load a Sailfin module and return the Python import statement."""

        # Handle built-in modules
        if source.startswith('sailfin/'):
            python_module_name = source.replace('/', '.')
            return f"import {python_module_name} as {alias}"

        # Resolve local module path
        module_path = self.resolve_module_path(source, current_file)

        if not module_path.exists():
            raise ImportError(
                f"Module not found: {source} (resolved to {module_path})")

        # Use canonical path as module key to handle different ways of importing same file
        module_key = str(module_path)

        # Check if already compiled
        if module_key in self.loaded_modules:
            module_name, temp_file = self.loaded_modules[module_key]
            return f"exec(compile(open(r'{temp_file}').read(), r'{temp_file}', 'exec'), globals()); {alias} = type('Module', (), globals().copy())()"

        # Check for circular imports
        if module_key in self.loading_modules:
            raise ImportError(f"Circular import detected: {source}")

        try:
            self.loading_modules.add(module_key)

            # Read and compile the Sailfin source
            with open(module_path, 'r', encoding='utf-8') as f:
                sailfin_source = f.read()

            # Parse the module
            self.lexer.input(sailfin_source)
            ast = self.parser.parse(
                sailfin_source, lexer=self.lexer, tracking=True)

            if not ast:
                raise ImportError(f"Failed to parse module: {source}")

            # Validate the module
            self.validator.validate(ast)

            # Process imports in the module first
            self._process_module_imports(ast, str(module_path))

            # Create a new code generator for the module
            module_generator = PythonCodeGenerator()
            module_generator.module_loader = self
            module_generator.current_file = str(module_path)
            module_generator.is_embedded_module = True  # Flag to avoid __future__ import

            # Generate Python code
            python_code = module_generator.visit(ast)

            # Create a temporary Python file for caching (optional)
            module_name = f"sailfin_module_{alias}_{abs(hash(module_key)) % 1000000}"
            temp_file = self._create_temp_module(module_name, python_code)

            # Store in loaded modules cache
            self.loaded_modules[module_key] = (module_name, temp_file)

            # Return code that embeds the module code directly (no temp file dependency)
            # Use a safer approach with base64 encoding to avoid any quoting issues
            import base64
            encoded_code = base64.b64encode(
                python_code.encode('utf-8')).decode('ascii')

            return f"""
# Import module {alias} from {source}
_module_globals_before_{alias} = set(globals().keys())
import base64
_module_code_{alias} = base64.b64decode('{encoded_code}').decode('utf-8')
exec(compile(_module_code_{alias}, '<module_{alias}>', 'exec'), globals())
_module_globals_after_{alias} = set(globals().keys())
_module_exports_{alias} = {{k: globals()[k] for k in _module_globals_after_{alias} - _module_globals_before_{alias} if not k.startswith('_')}}
class {alias}:
    pass
for _k, _v in _module_exports_{alias}.items():
    setattr({alias}, _k, _v)
del _module_code_{alias}  # Clean up the embedded code
""".strip()

        finally:
            self.loading_modules.discard(module_key)

    def _process_module_imports(self, ast, current_file: str):
        """Process imports in a module's AST, loading dependencies first."""
        for node in ast.statements:
            if isinstance(node, ImportModuleStatement):
                # Load the imported module to ensure dependencies are ready
                self.load_sailfin_module(node.source, node.alias, current_file)
            elif isinstance(node, ImportStatement):
                # Handle { item } from "source" style imports
                if node.source.startswith('sailfin/'):
                    # Built-in modules are handled by the Python import system
                    continue
                else:
                    # For local modules with item imports, we'd need to load the module
                    # and extract the specific items - this is more complex
                    # For now, we'll assume this syntax is primarily for built-ins
                    pass

    def _create_temp_module(self, module_name: str, python_code: str) -> str:
        """Create a temporary Python file with the compiled code."""
        temp_dir = tempfile.gettempdir()
        temp_file = os.path.join(temp_dir, f"{module_name}.py")

        with open(temp_file, 'w', encoding='utf-8') as f:
            f.write(python_code)

        self.temp_files.add(temp_file)
        return temp_file

    def cleanup(self):
        """Clean up temporary files."""
        for temp_file in self.temp_files:
            try:
                if os.path.exists(temp_file):
                    os.remove(temp_file)
            except OSError:
                pass  # Ignore cleanup errors
        self.temp_files.clear()

    def __del__(self):
        """Cleanup on destruction."""
        self.cleanup()


# Global module loader instance
_module_loader = None


def get_module_loader(base_path: str = ".") -> ModuleLoader:
    """Get the global module loader instance."""
    global _module_loader
    if _module_loader is None:
        _module_loader = ModuleLoader(base_path)
    return _module_loader


def load_module(source: str, alias: str, current_file: Optional[str] = None) -> object:
    """Load a Sailfin module using the global module loader."""
    loader = get_module_loader()
    return loader.load_sailfin_module(source, alias, current_file)
