defmodule CommServer.Router do
  use Plug.Router

  import Plug.Conn

  alias CommServer.IncomingServer
  alias CommServer.ResponseCreator

  plug(Plug.Logger)
  plug(:match)
  plug(:dispatch)

  post "/push" do
    {:ok, body, conn} = read_body(conn)
    IO.inspect IncomingServer.process(body)
    response = "OK"
    send_resp(conn |> put_resp_content_type("text/xml"), 200, response)
  end

  match(_, do: send_resp(conn |> put_resp_content_type("text/xml"), 404, "<error>404</error>"))
end
