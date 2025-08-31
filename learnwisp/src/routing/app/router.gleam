import gleam/string_tree
import gleam/http.{Get,Post}
import routing/app/web
import wisp.{type Request, type Response}

pub fn handle_request(req: Request) -> Response {
	use req <- web.middleware(req)

	case wisp.path_segments(req) {

		[] -> home_page(req)
		["comments"] -> comments(req)
		["comment", id] -> show_comment(req, id)
		_ -> wisp.not_found()
	}
}

fn home_page(req: Request) -> Response {
	use <- wisp.require_method(req, Get)

	wisp.ok()
	|> wisp.html_body(string_tree.from_string("Hello, herman!"))
}

fn comments(req: Request) -> Response {

	case req.method {
		Get -> list_comments()
		Post -> create_comment(req)
		_ -> wisp.method_not_allowed([Get, Post])
	}
}

fn list_comments() -> Response {
	wisp.ok()
	|> wisp.html_body(string_tree.from_string("Comments!"))
}

fn create_comment(_req: Request) -> Response {
	wisp.created()
	|> wisp.html_body(string_tree.from_string("Created"))
}

fn show_comment(req: Request, id: String) -> Response {

	use <- wisp.require_method(req, Get)

	wisp.ok()
	|> wisp.html_body(string_tree.from_string("Comment with id " <> id))
}