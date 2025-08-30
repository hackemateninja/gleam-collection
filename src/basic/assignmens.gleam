import gleam/int
import gleam/io

pub fn assignments() -> Nil {
  let x = 5
  let y = 10
  let z = x + y
  io.println(int.to_string(z))
}