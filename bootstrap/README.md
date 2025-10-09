# Bootstrap

This directory contains the bootstrap compiler for the Sailfin language. The bootstrap compiler is written in Python and is used to compile the Sailfin compiler written in Sailfin itself.

## Usage

To compile the Sailfin compiler, run the following command:

```bash
conda run -n sailfin-bootstrap pyinstaller --onefile --name sfn bootstrap/bootstrap.py
```

This will generate the `sfn` executable in the /dist directory.

## Development

The bootstrap compiler targets Python 3.13. Create or update the development environment with:

```bash
make bootstrap-install
```

To run the tests, run the following command:

```bash
make bootstrap-test
```
