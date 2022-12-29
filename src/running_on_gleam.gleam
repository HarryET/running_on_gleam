import gleam/io
import gleam/string
import gleam/int
import gleam/erlang/process
import gleam/erlang/os
import shimmer
import shimmer/handlers
import gleam/result

pub fn main() {
  let handlers =
    handlers.new_builder()
    |> handlers.on_ready(fn(data) {
      io.println(
        [
          "Logged in as ",
          data.user.username,
          " (",
          int.to_string(data.user.id),
          ")",
        ]
        |> string.join(with: ""),
      )
    })
    |> handlers.on_message(fn(_message) { io.print("Message Received!") })

  let token =
    os.get_env("DISCORD_TOKEN")
    |> result.unwrap(or: "set.a.token")

  let _client =
    shimmer.new(token, handlers)
    |> shimmer.connect

  process.sleep_forever()
}
