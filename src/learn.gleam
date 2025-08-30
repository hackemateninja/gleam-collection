import basic/discards
import basic/assignmens
import basic/bools
import basic/strings
import basic/equality
import basic/number_formats
import basic/ints
import basic/floats
import gleam/io.{println}
import gleam/string as text


pub fn main() -> Nil {

	let hello_world = "Hello, Herman!"

  io.println(hello_world)

  io.println(text.reverse(hello_world))

	println(hello_world)

	//print only works with strings
	//println(31)

	ints.ints()
	floats.floats()
	number_formats.number_formats()
	equality.equality()
	strings.strings()
	bools.bools()
	assignmens.assignments()
	discards.discards()



}
