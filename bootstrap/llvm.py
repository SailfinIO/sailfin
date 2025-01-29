# bootstrap/llvm.py

import ctypes
from llvmlite import ir, binding

# Define LLVM module and functions
module = ir.Module(name="sailfin_module")
func_type = ir.FunctionType(
    ir.DoubleType(), [ir.DoubleType(), ir.DoubleType()])
func = ir.Function(module, func_type, name="add")

# Implement the function
block = func.append_basic_block(name="entry")
builder = ir.IRBuilder(block)
result = builder.fadd(func.args[0], func.args[1], name="result")
builder.ret(result)

# Compile and execute
binding.initialize()
binding.initialize_native_target()
binding.initialize_native_asmprinter()

target = binding.Target.from_default_triple()
target_machine = target.create_target_machine()
backing_mod = binding.parse_assembly(str(module))
engine = binding.create_mcjit_compiler(backing_mod, target_machine)

engine.finalize_object()
engine.run_static_constructors()

# Get the function pointer
add_ptr = engine.get_function_address("add")

c_add = ctypes.CFUNCTYPE(
    ctypes.c_double, ctypes.c_double, ctypes.c_double)(add_ptr)
print(c_add(2.0, 3.0))  # Outputs: 5.0
