import language.experimental.captureChecking
import language.experimental.safe
import tacit.library.*
import api.*

object CapabilityLeak uses tacitIO, GlobalIOCap:
  val leaked = requestFileSystem(".") {
    access("nums.txt")
  }

  def main(args: Array[String]): Unit = println(leaked.read())
