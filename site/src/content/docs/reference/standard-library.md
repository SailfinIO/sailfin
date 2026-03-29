---
title: Standard Library
description: Sailfin's standard library and prelude.
section: reference
order: 5
---

## Prelude

The prelude (`runtime/prelude.sfn`) is automatically available in every Sailfin program. It provides:

### Printing & Logging

```sfn
print.info(message: String) ![io]
print.warn(message: String) ![io]
print.error(message: String) ![io]
print.debug(message: String) ![io]
```

### Strings

```sfn
String.length -> Int
String.split(delimiter: String) -> Array<String>
String.substring(start: Int, end: Int) -> String
String.contains(s: String) -> Bool
String.trim() -> String
String.to_upper() -> String
String.to_lower() -> String
```

### Collections

```sfn
Array<T>.length -> Int
Array<T>.map(fn: (T) -> U) -> Array<U>
Array<T>.filter(fn: (T) -> Bool) -> Array<T>
Array<T>.reduce(fn: (T, T) -> T) -> T

Vec<T>.new() -> Vec<T>
Vec<T>.push(item: T)
Vec<T>.pop() -> Option<T>
Vec<T>.len() -> Int
```

### Filesystem

```sfn
fs.read(path: String) -> String ![io]
fs.write(path: String, content: String) ![io]
fs.exists(path: String) -> Bool ![io]
```

### HTTP

```sfn
http.get(url: String) -> Response ![net]
http.post(url: String, body: String) -> Response ![net]
```

### Process

```sfn
process.exec(command: String) -> ProcessResult ![io]
process.exit(code: Int) ![io]
```

---

*The standard library is actively expanding as the runtime migrates from C to Sailfin. See [Runtime Audit](/docs/reference/runtime-abi) for migration status.*
