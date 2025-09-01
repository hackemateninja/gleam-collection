import gleam/list
import gleam/result
import gleam/string_tree
import gleam/http
import form_data/app/web
import wisp.{type Request, type Response}

pub fn handle_request(req: Request) -> Response{
	use req <- web.middleware(req)

	case req.method {
		http.Get -> show_form()
		http.Post -> handle_form_submission(req)
		_ -> wisp.method_not_allowed(allowed: [http.Get, http.Post])
	}
}

fn show_form() -> Response {
	let html =
    "<form method='post'>
        <label>Title:
          <input type='text' name='title'>
        </label>
        <label>Name:
          <input type='text' name='name'>
        </label>
        <input type='submit' value='Submit'>
      </form>"
  wisp.ok()
  |> wisp.html_body(string_tree.from_string(html))
}

fn handle_form_submission(req: Request) -> Response{
	use formdata <- wisp.require_form(req)

	let result = {
		use title <- result.try(list.key_find(formdata.values, "title"))
		use name 	<- result.try(list.key_find(formdata.values, "name"))

		let greeting =
			"Hi, " <> wisp.escape_html(title) <> " " <> wisp.escape_html(name) <> "!"

		Ok(greeting)
	}

	case result {
		Ok(content) -> {
			wisp.ok()
			|> wisp.html_body(string_tree.from_string(content))
		}
		Error(_) -> {
			wisp.bad_request()
		}
	}
}