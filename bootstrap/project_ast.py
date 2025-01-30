# bootstrap/project_ast.py

from ast_nodes import ASTNode


class Project(ASTNode):
    def __init__(self, imports, name, version, description, dependencies, dev_dependencies, build, test, scripts, run):
        self.imports = imports  # List of ImportStatement
        self.name = name
        self.version = version
        self.description = description
        self.dependencies = dependencies  # Dict[str, str]
        self.dev_dependencies = dev_dependencies  # Dict[str, str]
        self.build = build  # BuildConfig
        self.test = test  # TestConfig
        self.scripts = scripts  # Dict[str, str]
        self.run = run  # RunConfig


class BuildConfig(ASTNode):
    def __init__(self, entry, output, optimize):
        self.entry = entry
        self.output = output
        self.optimize = optimize


class TestConfig(ASTNode):
    def __init__(self, directories, coverage):
        self.directories = directories
        self.coverage = coverage


class RunConfig(ASTNode):
    def __init__(self, script, args):
        self.script = script
        self.args = args
