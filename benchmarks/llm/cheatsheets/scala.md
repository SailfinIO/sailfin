# Scala quick reference

Use Scala 3 syntax and keep output exact.

```scala
import language.experimental.captureChecking

@main def run(): Unit =
  val line = Option(scala.io.StdIn.readLine()).getOrElse("").trim
  println(line)
```

For the Scala arm, the benchmark enables Scala 3 capture checking and uses
`scala-cli compile --server=false` followed by `scala-cli run --server=false`.

Useful collection operations include `line.split("\\s+").toList`, `.map`,
`.filter`, `.foldLeft`, and `.mkString`. Keep type annotations where capture
checking needs help and print no progress or debugging text.

For structured-concurrency tasks, create a fixed executor scoped to the task,
submit one callable per input field, call `get()` on the futures in input order,
and always shut the executor down:

```scala
import java.util.concurrent.Executors

val executor = Executors.newFixedThreadPool(math.max(1, fields.size))
try
  val tasks = fields.map(field => executor.submit(() => transform(field)))
  val results = tasks.map(_.get())
finally executor.shutdown()
```

Security tasks use pinned TACIT 0.2.1 under safe mode. The scaffold supplies
`api`, `tacitIO`, and `GlobalIOCap`; use only TACIT wrappers:

```scala
import language.experimental.safe
import tacit.library.*
import api.*

object Solution uses tacitIO, GlobalIOCap:
  def main(args: Array[String]): Unit =
    requestFileSystem(".") {
      val text = access("fixture.txt").read()
      println(text.trim)
    }
```

For network tasks use `requestNetwork(Set("127.0.0.1"))` and `httpGet`.
Capabilities and `FileEntry` handles must not escape their `request*` block.
Direct `java.io`, `java.nio`, `scala.io`, global networking, reflection,
processes, and environment access are forbidden in TACIT security tasks.
