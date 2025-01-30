
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
    def getAbsolutePath(path):
        \"\"\"
        Returns the absolute path of the given path.

        :param path: Relative or absolute path.
        :return: Absolute path.
        \"\"\"
        try:
            abs_path = os.path.abspath(path)
            return abs_path
        except Exception as e:
            print(f"Error getting absolute path for '{{path}}': {{e}}")
            return ""

"""
