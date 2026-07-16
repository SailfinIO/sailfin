# Sailfin quick reference

Use `fn main() ![io]` for programs that read stdin or print. Read one line from
stdin with `io.read_line(0)` and print with `print(value)`.

Declare effects explicitly and alphabetically, for example:

```sailfin
fn sum_file(path: string) -> int ![io] {
    let text = fs.readFile(path);
    return 0;
}
```

For standalone benchmark files, import `trim`, `split`, and `join` from
`sfn/strings` when those helpers are useful:

```sailfin
import { join, split, trim } from "sfn/strings";
```

Useful basics:

```sailfin
let mut i = 0;
loop {
    if i >= text.length { break; }
    let ch = text[i];
    i += 1;
}

let part = substring(text, start, end);
let code = char_code(ch);
    let label = n as string;
```

For filesystem work, import `{ fs }` from `"fs"` and declare `![io]`. For a
local HTTP task, call `http.get_body(url)` from a function declaring `![net]`;
`main` normally needs effects in alphabetical order, such as `![io, net]`.
Structured-concurrency tasks use the shipped `routine { ... }` nursery,
`spawn fn() -> T { ... }` task lambdas, and `await` joins. Spawn tasks in input
order, retain their handles in that order, and await them in the same order
before printing. The concurrency primitives currently require `![io]`:

```sailfin
fn main() ![io] {
    routine {
        let left = spawn fn() -> int { return 20; };
        let right = spawn fn() -> int { return 22; };
        let first: int = await left;
        let second: int = await right;
        print((first + second) as string);
    }
}
```

Keep generated output exact and do not print diagnostics. A helper without an
effect annotation must remain pure:
file, clock, environment, process, random, and network access must be rejected
there rather than hidden behind another helper.
