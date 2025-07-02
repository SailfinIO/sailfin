# Sailfin

The Sailfin language is a simple, statically-typed, stack-based language. It is designed to be easy to learn and use, while still being powerful enough to write complex programs. Sailfin is designed to be a good language for beginners, but it is also a good language for experienced programmers who want to write small, fast programs.

## Features

- Simple syntax
- Statically-typed
- Stack-based
- Easy to learn

## Installation

You can download the latest release of Sailfin from the [releases page](https://github.com/SailfinIO/sailfin/releases)

use curl:

```bash
curl -L https://github.com/SailfinIO/sailfin/releases/download/v0.0.1-alpha.3/sfn -o /usr/local/bin/sfn
```

Make the binary executable:

```bash
chmod +x /usr/local/bin/sfn
```

## Running local

```bash
cd bootstrap
poetry run python bootstrap.py ../examples/basics/hello-wo
```
