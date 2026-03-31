---
title: Testing
description: Built-in testing, test organization, and patterns for writing reliable Sailfin tests.
section: learn
order: 9
---

Testing is built into Sailfin — there is no external framework to install, no `import testing` at the top of your file, and no runner to configure. The `test` keyword is part of the language itself.

This design reflects a core belief: the closer tests live to the code they verify, the more likely they are to stay up-to-date. Tests are first-class citizens, not afterthoughts.

## Your First Test

```sfn
fn add(a: Int, b: Int) -> Int {
    return a + b;
}

test "add returns the sum of two integers" {
    assert(add(2, 3) == 5);
}
```

Run it:

```bash
sfn test
```

Output when it passes:

```
PASS  add returns the sum of two integers
```

Output when it fails:

```
FAIL  add returns the sum of two integers
      assertion failed: add(2, 3) == 5
        left:  4
        right: 5
      --> src/math.sfn:8:5
```

## The `test` Block

A test block has three parts: the keyword `test`, a string name, and a body enclosed in braces.

```sfn
test "descriptive name here" {
    // assertions and logic
}
```

Test names are documentation. A reader scanning a test file should be able to understand the intended behavior of the system just by reading the test names. Write them as statements of fact about what the code does:

```sfn
// Good — describes observable behavior
test "parse_int returns Err on empty string" { ... }
test "Vec.push increases length by one" { ... }
test "Config.load reads from XDG_CONFIG_HOME when set" { ... }

// Avoid — too vague
test "parse_int works" { ... }
test "test1" { ... }
test "edge case" { ... }
```

## The `assert` Statement

`assert` takes a boolean expression. If the expression evaluates to `false`, the test fails immediately with the failing expression printed as-is.

```sfn
test "string length" {
    let s = "hello";
    assert(s.length == 5);
}
```

Most assertions compare two values with `==`. When the assertion fails, Sailfin prints both sides so you can see the mismatch without adding debug output yourself.

You can include multiple assertions in one test:

```sfn
test "normalise_email lowercases and trims" {
    let result = normalise_email("  Alice@Example.COM  ");
    assert(result == "alice@example.com");
    assert(result.length == 17);
}
```

When there are multiple assertions, execution stops at the first failure. If you want to verify several independent properties, consider separate tests — each will give a clear, isolated failure message.

> **Planned**: richer assertion helpers such as `assert_eq`, `assert_ne`, `assert_contains`, and `assert_throws` are on the roadmap. For now, express these as boolean expressions passed to `assert`.

## Pure Computation Tests

Tests for pure functions need no effects. These are the easiest to write, the fastest to run, and the most valuable to have.

```sfn
fn clamp(value: Int, min: Int, max: Int) -> Int {
    if value < min { return min; }
    if value > max { return max; }
    return value;
}

test "clamp returns value when within range" {
    assert(clamp(5, 0, 10) == 5);
}

test "clamp returns min when value is below range" {
    assert(clamp(-3, 0, 10) == 0);
}

test "clamp returns max when value is above range" {
    assert(clamp(99, 0, 10) == 10);
}

test "clamp handles equal min and max" {
    assert(clamp(7, 5, 5) == 5);
}
```

## Effect Declarations in Tests

Tests declare effects exactly like functions do. This is intentional: the compiler enforces capability discipline everywhere, including test code. A test that calls `fs.read` without declaring `![io]` is a compile error, not a runtime surprise.

```sfn
test "config file loads successfully" ![io] {
    let content = fs.read("tests/fixtures/sample.toml");
    assert(content.length > 0);
}

test "HTTP endpoint returns 200" ![io, net] {
    let response = http.get("https://httpbin.org/get");
    assert(response.status == 200);
}
```

The effects listed in the test signature are exactly the capabilities that test is granted. This makes it easy to see, at a glance, which tests touch the filesystem or network.

### Why this matters

In a large test suite, tests that declare `![io]` or `![net]` are the ones that may be slow, may require fixtures, and may fail due to environment issues. Tests with no effects are pure — they always run fast and always produce the same result. Effect annotations let tools (and people) reason about this without reading the test body.

## Organizing Test Files

### Co-located tests

For small modules, put tests in the same file as the code they test. This is the simplest option and keeps tests close to their subject:

```sfn
// src/math.sfn

fn factorial(n: Int) -> Int {
    if n <= 1 { return 1; }
    return n * factorial(n - 1);
}

test "factorial of zero is one" {
    assert(factorial(0) == 1);
}

test "factorial of five is 120" {
    assert(factorial(5) == 120);
}
```

### Separate test files

For larger modules, or when the test file would dwarf the implementation, use a separate `*_test.sfn` file. The naming convention is `<module>_test.sfn`:

```
src/
├── parser.sfn
├── parser_test.sfn
├── typecheck.sfn
└── typecheck_test.sfn
```

### Dedicated test directories

For integration and end-to-end tests that don't belong to a single module, use a `tests/` directory:

```
project/
├── src/
│   ├── parser.sfn
│   └── parser_test.sfn    # unit tests, co-located
└── tests/
    ├── unit/
    │   └── math_test.sfn
    ├── integration/
    │   └── pipeline_test.sfn
    └── e2e/
        └── full_run_test.sfn
```

This mirrors the structure used in the Sailfin compiler itself:

```
compiler/
├── src/
│   ├── parser.sfn
│   └── lexer.sfn
└── tests/
    ├── unit/
    │   ├── parser_test.sfn
    │   └── lexer_test.sfn
    ├── integration/
    │   └── effect_checker_test.sfn
    └── e2e/
        └── full_pipeline_test.sfn
```

## Running Tests

### With the CLI

```bash
# Run all tests discovered from the current directory
sfn test

# Run tests in a specific file
sfn test src/parser_test.sfn

# Run tests in a directory (recursive)
sfn test tests/unit/

# Note: --filter is not yet supported; run a specific file to narrow scope
sfn test src/math_test.sfn
```

### With Make targets

Projects built with the standard Sailfin Makefile have these targets:

```bash
make test              # Full suite: unit + integration + e2e
make test-unit         # Unit tests only
make test-integration  # Integration tests only
make test-e2e          # End-to-end tests only
```

### Reading the output

```
PASS  factorial of zero is one
PASS  factorial of five is 120
FAIL  factorial of negative number returns one
      assertion failed: factorial(-1) == 1
        left:  -1
        right: 1
      --> src/math.sfn:24:5

3 tests, 2 passed, 1 failed
```

Tests run in declaration order within a file. When running multiple files, the order between files is alphabetical.

## Unit Testing Patterns

### Table-driven tests

When you have many similar cases to verify, use an array of test-case structs and loop over them. This avoids repetitive test bodies and makes it easy to add new cases.

```sfn
struct ParseCase {
    input -> String;
    expected -> Int;
    should_fail -> Bool;
}

test "parse_int handles all cases" {
    let cases: Array<ParseCase> = [
        ParseCase { input: "0",    expected: 0,  should_fail: false },
        ParseCase { input: "42",   expected: 42, should_fail: false },
        ParseCase { input: "-7",   expected: -7, should_fail: false },
        ParseCase { input: "",     expected: 0,  should_fail: true  },
        ParseCase { input: "abc",  expected: 0,  should_fail: true  },
        ParseCase { input: "2147483648", expected: 0, should_fail: true },
    ];

    for c in cases {
        let result = parse_int(c.input);
        if c.should_fail {
            assert(result.is_err());
        } else {
            assert(result.is_ok());
            assert(result.unwrap() == c.expected);
        }
    }
}
```

### Boundary and edge cases

Always test the boundaries of your domain. For a function that works on collections, test the empty case, the one-element case, and a representative multi-element case.

```sfn
fn median(values: Array<Float>) -> Float { ... }

test "median of empty array returns 0.0" {
    assert(median([]) == 0.0);
}

test "median of single element returns that element" {
    assert(median([7.0]) == 7.0);
}

test "median of even-length array averages middle two" {
    assert(median([1.0, 2.0, 3.0, 4.0]) == 2.5);
}

test "median of odd-length array returns middle element" {
    assert(median([1.0, 3.0, 5.0]) == 3.0);
}
```

### Testing with enums

When a function returns an enum, match against it rather than using `.unwrap()` in tests. This gives you a clearer failure message.

```sfn
test "parse_direction recognises north" {
    let result = parse_direction("north");
    match result {
        Ok(Direction.North) => { /* pass */ },
        Ok(other) => assert(false),  // wrong variant
        Err(e) => assert(false),     // unexpected error
    }
}
```

## Integration Testing

Integration tests verify that multiple components work correctly together, often using real effects like the filesystem or network. They are slower than unit tests and may require setup.

```sfn
test "round-trip: write then read returns original content" ![io] {
    let path = "tests/fixtures/temp_roundtrip.txt";
    let original = "hello, world\n";

    try {
        fs.write(path, original);
        let recovered = fs.read(path);
        assert(recovered == original);
    } finally {
        fs.delete(path);
    }
}
```

The `finally` block runs even if an assertion fails, ensuring the temporary file is cleaned up regardless of the test outcome.

### Fixtures

Put static test files in a `tests/fixtures/` directory and read them in tests that need them:

```sfn
test "config parser handles multi-section TOML" ![io] {
    let source = fs.read("tests/fixtures/multi_section.toml");
    let config = Config.parse(source);
    assert(config.sections.length == 3);
}
```

Keep fixtures small and purpose-built. A fixture that exists to test one behavior should not be reused for a different test if the two tests might need to diverge.

### Setup and teardown

Sailfin does not have `beforeEach`/`afterEach` hooks. Instead, extract setup into a helper function and call it at the top of each test that needs it. Use `try/finally` for teardown:

```sfn
fn create_temp_dir() -> String ![io] {
    let path = "tests/temp/{{rand.uuid()}}";
    fs.mkdir(path);
    return path;
}

test "compiler emits expected IR" ![io] {
    let dir = create_temp_dir();
    try {
        let source = "fn main() ![io] { print(\"hi\"); }";
        let out_path = "{{dir}}/out.sfn-asm";
        compile_to_file(source, out_path);
        let ir = fs.read(out_path);
        assert(ir.contains("define void @main"));
    } finally {
        fs.remove_all(dir);
    }
}
```

## Testing Error Handling

To verify that a function throws under expected conditions, wrap the call in a `try/catch` block inside the test. The test fails if the exception is not thrown.

```sfn
test "divide throws on zero divisor" {
    let threw = false;
    try {
        let _ = divide(10, 0);
    } catch (e) {
        threw = true;
    }
    assert(threw);
}
```

To verify that the _right_ exception is thrown, inspect the caught error:

```sfn
test "parse_config throws ParseError on malformed input" {
    let got_parse_error = false;
    try {
        let _ = parse_config("{{ not valid toml }}}");
    } catch (e: ParseError) {
        got_parse_error = true;
    } catch (e) {
        // A different exception type — fail the test
        assert(false);
    }
    assert(got_parse_error);
}
```

## Testing with `Result` Types

Functions that return `Result<T, E>` don't throw — they return an error value. Test these by inspecting the result:

```sfn
test "parse_int returns Ok for valid input" {
    let result = parse_int("42");
    assert(result.is_ok());
    assert(result.unwrap() == 42);
}

test "parse_int returns Err for non-numeric input" {
    let result = parse_int("not a number");
    assert(result.is_err());
}
```

## Testing AI Code

> **Current status**: `model` and `prompt` blocks parse correctly today but do not execute. Model invocation is planned for after the 1.0 release. This section describes the intended testing story.

When model execution lands, prompt-based functions will require `![model]` effects and will be testable using a `seed` parameter for reproducibility:

```sfn
// Planned syntax — not yet executable
test "summarize returns a short string" ![model] {
    let result = summarize("A very long article about the history of programming languages...");
    assert(result.length < 200);
}
```

Each model call produces a **generation card** containing the seed used. By fixing the seed, you get deterministic output across runs — the same prompt with the same seed against the same model version will always return the same response.

The workflow will look like:

1. Run the test once with a known seed to capture the expected output.
2. Pin the expected output and seed in the test.
3. Future runs compare against the pinned output — any change is a signal to review.

This is deliberately different from mocking: you're testing the real model behavior, pinned to a specific configuration.

## Test Coverage

Coverage tooling is planned. The goal is line-level coverage that understands effect boundaries — so you can ask "do I have coverage for all my `![net]` paths?" not just "which lines were executed?".

For now, use the discipline of writing tests first to drive coverage naturally.

## Best Practices

**Test names are documentation.** Someone reading your test file shouldn't need to open the implementation to understand what the code is supposed to do.

**One behavior per test.** When a test verifies a single behavior, the failure message is precise. When a test verifies five behaviors, a failure tells you something broke but not what.

```sfn
// Prefer: one behavior per test
test "trim removes leading whitespace" {
    assert(trim("  hello") == "hello");
}

test "trim removes trailing whitespace" {
    assert(trim("hello  ") == "hello");
}

// Avoid: too many behaviors in one test
test "trim works" {
    assert(trim("  hello") == "hello");
    assert(trim("hello  ") == "hello");
    assert(trim("  hello  ") == "hello");
    assert(trim("") == "");
    assert(trim("no spaces") == "no spaces");
}
```

**Test the interface, not the implementation.** If your test breaks when you refactor internals without changing behavior, the test is testing the wrong thing.

**Keep unit tests fast.** A test suite that takes two minutes to run will be skipped. Unit tests should take milliseconds. If a test is slow, look for `![io]` or `![net]` effects — those are your slow paths. Separate them into an integration test suite that you run less frequently.

**Write a test for every bug fix.** Before fixing a bug, write a test that reproduces it. Then fix the bug. Then confirm the test passes. This prevents regressions and documents the exact scenario that was broken.

**Use `try/finally` for cleanup.** Any test that creates temporary files, starts servers, or modifies shared state should clean up in a `finally` block. This ensures cleanup happens even when assertions fail.

## Next Steps

- [Effective Sailfin](/docs/learn/effective-sailfin) — Idiomatic patterns and best practices
- [CLI Reference](/docs/reference/cli) — Full `sfn test` options
- [The Effect System](/docs/learn/effects) — Understanding capability declarations
