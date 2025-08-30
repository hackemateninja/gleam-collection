import gleam/bool
import gleam/io


pub fn equality() -> Nil {

	echo 100 == 50 + 50
	io.print(bool.to_string(1.5 != 0.1 *. 10.0))
}