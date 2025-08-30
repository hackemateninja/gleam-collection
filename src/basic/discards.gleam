import gleam/io


pub fn discards() -> Nil {
	let _unused = 5
	io.print("This value is discarded")
}