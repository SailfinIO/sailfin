def fs_class_def():
    return """\
class fs:
    @staticmethod
    def writeFile(filename, content):
        \"\"\"
        Writes the given content to the specified filename.

        :param filename: Name of the file to write to.
        :param content: Content to write into the file.
        \"\"\"
        try:
            with open(filename, 'w', encoding='utf-8') as f:
                f.write(content)
            print(f"File '{{filename}}' written successfully.")
        except Exception as e:
            print(f"Error writing to file '{{filename}}': {{e}}")

    @staticmethod
    def readFile(filename):
        \"\"\"
        Reads and returns the content of the specified filename.

        :param filename: Name of the file to read from.
        :return: Content of the file as a string.
        \"\"\"
        try:
            with open(filename, 'r', encoding='utf-8') as f:
                content = f.read()
            return content
        except Exception as e:
            print(f"Error reading file '{{filename}}': {{e}}")
            return ""

    @staticmethod
    def appendFile(filename, content):
        \"\"\"
        Appends the given content to the specified filename.

        :param filename: Name of the file to append to.
        :param content: Content to append into the file.
        \"\"\"
        try:
            with open(filename, 'a', encoding='utf-8') as f:
                f.write(content)
            print(f"Content appended to '{{filename}}' successfully.")
        except Exception as e:
            print(f"Error appending to file '{{filename}}': {{e}}")

    @staticmethod
    def writeBinaryFile(filename, content):
        \"\"\"
        Writes binary content to the specified filename.

        :param filename: Name of the file to write to.
        :param content: Binary content to write into the file.
        \"\"\"
        try:
            with open(filename, 'wb') as f:
                f.write(content)
            print(f"Binary file '{{filename}}' written successfully.")
        except Exception as e:
            print(f"Error writing binary file '{{filename}}': {{e}}")

    @staticmethod
    def readBinaryFile(filename):
        \"\"\"
        Reads and returns the binary content of the specified filename.

        :param filename: Name of the file to read from.
        :return: Binary content of the file.
        \"\"\"
        try:
            with open(filename, 'rb') as f:
                content = f.read()
            return content
        except Exception as e:
            print(f"Error reading binary file '{{filename}}': {{e}}")
            return b""

    @staticmethod
    def deleteFile(filename):
        \"\"\"
        Deletes the specified file.

        :param filename: Name of the file to delete.
        \"\"\"
        import os
        try:
            os.remove(filename)
            print(f"File '{{filename}}' deleted successfully.")
        except FileNotFoundError:
            print(f"File '{{filename}}' not found, cannot delete.")
        except Exception as e:
            print(f"Error deleting file '{{filename}}': {{e}}")
"""
