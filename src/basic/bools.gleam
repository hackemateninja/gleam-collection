import gleam/io
import gleam/bool

pub fn bools() -> Nil {
  // Bool operators
  echo True && False
  echo True && True
  echo False || False
  echo False || True

  // Bool functions
  io.print(bool.to_string(True))
}
