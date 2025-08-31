import gleam/string_tree
import hello_world/app/web
import wisp.{type Request, type Response}

pub fn handle_request(req: Request) -> Response {
  use _req <- web.middleware(req)

  // Convert your HTML string into a StringTree
  let body_tree = string_tree.from_string("<h1>Hello, Herman!</h1>")

  // Pass the StringTree to html_response
  wisp.html_response(body_tree, 200)
}
