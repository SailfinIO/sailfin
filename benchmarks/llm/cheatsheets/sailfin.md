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

For standalone benchmark files, prefer local helpers for `trim`, `split`, and
`join` rather than importing `sfn/strings`; the current bare-file runner can
typecheck those imports but fail during lowering when invoked from the isolated
task working directory.

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
