# Documented local primitive

In the local-implementation treatment, `substring` is unavailable. Copy this packet-defined implementation into the solution and call `local_slice` wherever a half-open string slice is needed.

```sailfin
fn local_slice(text: string, start: int, end: int) -> string {
    let mut out = "";
    let mut i = start;
    loop {
        if i >= end { break; }
        out = out + text[i];
        i += 1;
    }
    return out;
}
```
