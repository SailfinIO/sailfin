---
title: Testing
description: Writing and running tests in Sailfin.
section: learn
order: 9
---

Testing is built into the language — no external framework needed.

## Writing Tests

```sfn
test "basic arithmetic" {
    assert 2 + 2 == 4;
    assert 10 / 3 == 3;
}

test "string interpolation" {
    let name = "Sailfin";
    assert "Hello, {{name}}!" == "Hello, Sailfin!";
}
```

## Tests with Effects

Tests that call effectful functions must declare the effects:

```sfn
test "reads a file" ![io] {
    let content = fs.read("test-fixtures/sample.txt");
    assert content.length > 0;
}

test "fetches data" ![io, net] {
    let response = http.get("https://httpbin.org/get");
    assert response.status == 200;
}
```

## Running Tests

```bash
# Run all tests
sfn test

# Run a specific test file
sfn test path/to/test_file.sfn

# Run tests matching a pattern
sfn test --filter "arithmetic"
```

### Make targets

```bash
make test              # Full suite
make test-unit         # Unit tests only
make test-integration  # Integration tests only
make test-e2e          # End-to-end tests
```

## Test Organization

Tests live alongside source code or in dedicated test directories:

```
compiler/tests/
├── unit/
│   ├── parser_test.sfn
│   └── typecheck_test.sfn
├── integration/
│   └── effect_checker_test.sfn
└── e2e/
    └── full_pipeline_test.sfn
```

## Next Steps

- [Effective Sailfin](/docs/learn/effective-sailfin) — Best practices and idioms
- [CLI Reference](/docs/reference/cli) — Full test runner options
