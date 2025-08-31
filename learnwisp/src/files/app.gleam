import gleam/erlang/process
import files/app/router
import wisp/wisp_mist
import mist
import wisp


pub fn main(){
	wisp.configure_logger()
	let secret_key_base = wisp.random_string(64)

	let assert Ok(_) =
	wisp_mist.handler(router.handle_request, secret_key_base)
	|> mist.new
	|> mist.port(4000)
	|> mist.start

	process.sleep_forever()
}