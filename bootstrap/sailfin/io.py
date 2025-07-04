"""
Sailfin io module - File system and I/O utilities.
"""
import os
import json
from pathlib import Path
from typing import Dict, Any, List, Optional, Union


class FileSystem:
    """File system operations."""

    @staticmethod
    def readFile(path: str) -> str:
        """
        Read the entire contents of a file as a string.

        Args:
            path: Path to the file to read

        Returns:
            File contents as string

        Raises:
            FileNotFoundError: If the file doesn't exist
            IOError: If there's an error reading the file
        """
        try:
            with open(path, 'r', encoding='utf-8') as f:
                return f.read()
        except FileNotFoundError:
            raise FileNotFoundError(f"File not found: {path}")
        except Exception as e:
            raise IOError(f"Error reading file {path}: {e}")

    @staticmethod
    def writeFile(path: str, content: str) -> None:
        """
        Write content to a file, creating it if it doesn't exist.

        Args:
            path: Path to the file to write
            content: Content to write to the file

        Raises:
            IOError: If there's an error writing the file
        """
        try:
            # Create directory if it doesn't exist
            os.makedirs(os.path.dirname(path) or '.', exist_ok=True)

            with open(path, 'w', encoding='utf-8') as f:
                f.write(content)
        except Exception as e:
            raise IOError(f"Error writing file {path}: {e}")

    @staticmethod
    def appendFile(path: str, content: str) -> None:
        """
        Append content to a file, creating it if it doesn't exist.

        Args:
            path: Path to the file to append to
            content: Content to append to the file

        Raises:
            IOError: If there's an error appending to the file
        """
        try:
            # Create directory if it doesn't exist
            os.makedirs(os.path.dirname(path) or '.', exist_ok=True)

            with open(path, 'a', encoding='utf-8') as f:
                f.write(content)
        except Exception as e:
            raise IOError(f"Error appending to file {path}: {e}")

    @staticmethod
    def exists(path: str) -> bool:
        """
        Check if a file or directory exists.

        Args:
            path: Path to check

        Returns:
            True if the path exists, False otherwise
        """
        return os.path.exists(path)

    @staticmethod
    def isFile(path: str) -> bool:
        """
        Check if a path is a file.

        Args:
            path: Path to check

        Returns:
            True if the path is a file, False otherwise
        """
        return os.path.isfile(path)

    @staticmethod
    def isDirectory(path: str) -> bool:
        """
        Check if a path is a directory.

        Args:
            path: Path to check

        Returns:
            True if the path is a directory, False otherwise
        """
        return os.path.isdir(path)

    @staticmethod
    def listDirectory(path: str) -> List[str]:
        """
        List contents of a directory.

        Args:
            path: Path to the directory

        Returns:
            List of file and directory names in the directory

        Raises:
            FileNotFoundError: If the directory doesn't exist
            IOError: If there's an error listing the directory
        """
        try:
            return os.listdir(path)
        except FileNotFoundError:
            raise FileNotFoundError(f"Directory not found: {path}")
        except Exception as e:
            raise IOError(f"Error listing directory {path}: {e}")

    @staticmethod
    def createDirectory(path: str) -> None:
        """
        Create a directory, including parent directories if needed.

        Args:
            path: Path to the directory to create

        Raises:
            IOError: If there's an error creating the directory
        """
        try:
            os.makedirs(path, exist_ok=True)
        except Exception as e:
            raise IOError(f"Error creating directory {path}: {e}")

    @staticmethod
    def removeFile(path: str) -> None:
        """
        Remove a file.

        Args:
            path: Path to the file to remove

        Raises:
            FileNotFoundError: If the file doesn't exist
            IOError: If there's an error removing the file
        """
        try:
            os.remove(path)
        except FileNotFoundError:
            raise FileNotFoundError(f"File not found: {path}")
        except Exception as e:
            raise IOError(f"Error removing file {path}: {e}")

    @staticmethod
    def removeDirectory(path: str) -> None:
        """
        Remove an empty directory.

        Args:
            path: Path to the directory to remove

        Raises:
            FileNotFoundError: If the directory doesn't exist
            IOError: If there's an error removing the directory
        """
        try:
            os.rmdir(path)
        except FileNotFoundError:
            raise FileNotFoundError(f"Directory not found: {path}")
        except Exception as e:
            raise IOError(f"Error removing directory {path}: {e}")

    @staticmethod
    def getFileSize(path: str) -> int:
        """
        Get the size of a file in bytes.

        Args:
            path: Path to the file

        Returns:
            File size in bytes

        Raises:
            FileNotFoundError: If the file doesn't exist
            IOError: If there's an error getting file info
        """
        try:
            return os.path.getsize(path)
        except FileNotFoundError:
            raise FileNotFoundError(f"File not found: {path}")
        except Exception as e:
            raise IOError(f"Error getting file size for {path}: {e}")

    @staticmethod
    def readJSON(path: str) -> Any:
        """
        Read and parse a JSON file.

        Args:
            path: Path to the JSON file

        Returns:
            Parsed JSON data

        Raises:
            FileNotFoundError: If the file doesn't exist
            IOError: If there's an error reading or parsing the file
        """
        try:
            with open(path, 'r', encoding='utf-8') as f:
                return json.load(f)
        except FileNotFoundError:
            raise FileNotFoundError(f"File not found: {path}")
        except json.JSONDecodeError as e:
            raise IOError(f"Error parsing JSON file {path}: {e}")
        except Exception as e:
            raise IOError(f"Error reading JSON file {path}: {e}")

    @staticmethod
    def writeJSON(path: str, data: Any, indent: int = 2) -> None:
        """
        Write data to a JSON file.

        Args:
            path: Path to the JSON file to write
            data: Data to serialize as JSON
            indent: Number of spaces for indentation (default: 2)

        Raises:
            IOError: If there's an error writing the file
        """
        try:
            # Create directory if it doesn't exist
            os.makedirs(os.path.dirname(path) or '.', exist_ok=True)

            with open(path, 'w', encoding='utf-8') as f:
                json.dump(data, f, indent=indent, ensure_ascii=False)
        except Exception as e:
            raise IOError(f"Error writing JSON file {path}: {e}")


# Global file system instance
fs = FileSystem()
