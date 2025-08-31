import gleam/list
import gleam/result
import gleam/bytes_tree
import files/app/web
import gleam/string_tree
import gleam/http.{Get, Post}
import wisp.{type Request, type Response}


pub fn handle_request(req: Request) -> Response{
	use req <- web.middleware(req)

	case wisp.path_segments(req) {
		[] -> show_home(req)
		["file-from-disc"] -> handle_download_file_from_disc(req)
		["file-from-memory"] -> handle_download_file_from_memory(req)
		["file-upload"] -> handle_file_upload(req)
		_ -> wisp.not_found()
	}
}


const html = "
<p><a href='/file-from-memory'>Download file from memory</a></p>
<p><a href='/file-from-disc'>Download file from disc</a></p>

<form method=post action='/file-upload' enctype='multipart/form-data'>
  <label>Your file:
    <input type='file' name='file-uploaded'>
  </label>
  <input type='submit' value='Submit'>
</form>
"


fn show_home(req: Request) -> Response {
	use <- wisp.require_method(req, Get)

	html
	|> string_tree.from_string()
	|> wisp.html_response(200)
}

fn handle_download_file_from_memory(req: Request) -> Response{
 use <- wisp.require_method(req, Get)

 let file_contents = bytes_tree.from_string("Hello herman")

 wisp.ok()
 |> wisp.set_header("content-type", "text/plain")
 |> wisp.file_download_from_memory(
	named: "hello.txt",
	containing:file_contents
 )
}

fn handle_download_file_from_disc(req: Request) -> Response{
	use <- wisp.require_method(req, Post)

	let file_path = "./gleam.toml"

	wisp.ok()
	|> wisp.set_header("content-type", "text/markdown")
	|> wisp.file_download(named: "hello.txt", from: file_path)
}


fn handle_file_upload(req: Request) -> Response {
  use <- wisp.require_method(req, Post)
  use formdata <- wisp.require_form(req)

  let result = {
    use file <- result.try(list.key_find(formdata.files, "file-uploaded"))

    wisp.log_info("File uploaded to " <> file.path)
    wisp.log_info("The file name is reportedly " <> file.file_name)

    Ok(file.file_name)
  }
  case result {
    Ok(name) -> {
      { "<p>Thank you for your file!" <> name <> "</p>" <> html }
			|> string_tree.from_string
      |> wisp.html_response(200)
    }
    Error(_) -> {
      wisp.bad_request()
    }
  }
}