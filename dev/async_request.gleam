import gleam/erlang/process
import gleam/http/request
import gleam/httpc
import gleam/io

pub fn main() {
  let assert Ok(req) = request.to("https://httpbin.org/get")
  io.println("Sending request")
  let assert Ok(request_id) =
    request.set_body(req, <<>>)
    |> httpc.send_bits_async(fn(response) {
      io.println("Async response received!")
      echo response
      Nil
    })
  io.println("Request sent")
  echo request_id
  process.sleep_forever()
}
