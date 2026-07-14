# Scala quick reference

Use Scala 3 syntax and keep output exact.

```scala
import language.experimental.safe

@main def run(): Unit =
  val line = Option(scala.io.StdIn.readLine()).getOrElse("").trim
  println(line)
```

For the Scala arm, the benchmark command is `scala-cli compile` followed by
`scala-cli run`.

