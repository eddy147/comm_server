defmodule CommServer.Router do
  use Plug.Router

  alias CommServer.Handler

  plug(Plug.Logger)
  plug(:match)
  plug(:dispatch)

  post "/push" do
    {:ok, body, conn} = read_body(conn)
    response = Handler.loadMessage(body)
    send_resp(conn, 200, response)
  end

  match(_, do: send_resp(conn, 404, "only POST /push allowed."))
end
