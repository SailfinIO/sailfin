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
