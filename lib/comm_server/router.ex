defmodule CommServer.Router do
  use Plug.Router

  import Plug.Conn

  alias CommServer.MessageHandler
  alias CommServer.ResponseCreator
  alias CommServer.SoapParser

  plug(Plug.Logger)
  plug(:match)
  plug(:dispatch)

  post "/api/v3/push" do
    case Plug.Conn.read_body(conn, opts) do
      {:ok, body, conn} ->
        message = SoapParser.parse(body)
        MessageHandler.process(message)
        response = message |> ResponseCreator.create()
        send_resp(conn |> put_resp_content_type("text/xml"), 200, response)

      {:error, term} ->
        send_resp(
          conn |> put_resp_content_type("text/xml"),
          400,
          "<error>#{inspect(term)}</error>"
        )

      _ ->
        send_resp(conn |> put_resp_content_type("text/xml"), 400, "<error>Unknown error</error>")
    end
  end

  match(_, do: send_resp(conn |> put_resp_content_type("text/xml"), 404, "<error>404</error>"))
end
