import gleam/float
import gleam/io

pub fn number_formats() -> Nil {
  // Underscores
  echo 1_000_000
  echo 10_000.01

  // Binary, octal, and hex Int literals
  echo 0b00001111
  echo 0o17
  echo 0xF

  // Scientific notation Float literals
  echo 7.0e7
  io.println(float.to_string(7.0e7))
}