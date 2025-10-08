# I/O Examples

Simple file system interactions using the (stub) `sail/io` module. Demonstrates reading and writing text content.

## Files

- **`read-file.sfn`** – Reads a file and logs its contents.
- **`write-file.sfn`** – Writes a file then confirms success.

## Notes

- The bootstrap runtime provides placeholder `fs.readFile` and `fs.writeFile`; capability enforcement (`![io]`) will become mandatory as the effect checker matures.
- Error handling (e.g. missing files) can be layered with `try/catch` similarly to examples in `basics/`.
