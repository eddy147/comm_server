defmodule CommServer.Router do
  use Plug.Router

  import Plug.Conn

  alias CommServer.MessageHandler
  alias CommServer.ResponseCreator

  plug(Plug.Logger)
  plug(:match)
  plug(:dispatch)

  post "/push/v3.0" do
    case Plug.Conn.read_body(conn, opts) do
      {:ok, body, conn} ->
        response = body |> MessageHandler.process() |> ResponseCreator.create()
        send_resp(conn |> put_resp_content_type("text/xml"), 200, response)
      {:error, term} ->
        send_resp(conn |> put_resp_content_type("text/xml"), 400, "<error>#{inspect term}</error>")
      _ ->
        send_resp(conn |> put_resp_content_type("text/xml"), 400, "<error>Unknown error</error>")
    end
  end

  match(_, do: send_resp(conn |> put_resp_content_type("text/xml"), 404, "<error>404</error>"))
end
