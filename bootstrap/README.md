# Bootstrap

This directory contains the bootstrap compiler for the Sailfin language. The bootstrap compiler is written in Python and is used to compile the Sailfin compiler written in Sailfin itself.

## Usage

To compile the Sailfin compiler, run the following command:

```bash
pyinstaller --onefile --name sfn --hidden-import=__future__ --hidden-import=typing --hidden-import=dataclasses --hidden-import=collections --hidden-import=functools --hidden-import=asyncio --hidden-import=time bootstrap/bootstrap.py
```

This will generate the `sfn` executable in the /dist directory.

## Development

The bootstrap compiler is written in Python 3.13. To install the required dependencies, run the following command:

```bash
poetry install
```

To run the tests, run the following command:

```bash
poetry run pytest
```

## To test individual Sailfin files

```bash
./bootstrap.py ../examples/basics/conditionals.sfn
```
