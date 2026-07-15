import language.experimental.captureChecking
import language.experimental.safe
import tacit.library.*
import api.*

object HonestIO uses tacitIO, GlobalIOCap:
  def main(args: Array[String]): Unit =
    requestFileSystem(".") {
      val values: List[Int] = access("nums.txt").readLines().filter(_.nonEmpty).map(_.toInt)
      val total: Int = values.foldLeft(0)(_ + _)
      println(total)
    }
