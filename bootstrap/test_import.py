from __future__ import annotations

from sailfin.io import fs
def main() -> None:
    testFile: str = "temp_test_read.txt"
    testContent: str = "Hello from Sailfin!\nThis is a test file for reading.\nLine 3 of content."
    fs.writeFile(testFile, testContent)
    content: str = fs.readFile(testFile)
    print(f"File content: {content}")
    fs.deleteFile(testFile)
    print("Cleanup completed.")


if __name__ == "__main__":
    main()