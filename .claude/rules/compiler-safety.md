When running the Sailfin compiler (build/native/sailfin) or any make target that invokes it:

- Always set `ulimit -v 8388608` before the command to cap memory at 8GB
- Always wrap compiler invocations with `timeout` (60s for single files, no limit needed for make targets which handle their own timeouts)
- Never run the compiler without a memory cap — runaway compilation can crash the entire WSL instance and IDE
